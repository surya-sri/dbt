SELECT lad.advertiser_key
	,lad.advertiser_no
	,--Qlik Enhancement
	lad.Advertiser_Name
	,COALESCE(lacm.advertiser_category_master_id, - 1) AS advertiser_category_master_id
	,COALESCE(lacm.advertiser_category_master_descr, 'Undefined') AS advertiser_category_master_descr
	,COALESCE(lam.advertiser_master_id, - 1) advertiser_master_id
	,--Qlik Enhancement
	COALESCE(lam.advertiser_master_name, 'Undefined') advertiser_master_name
	,COALESCE(lamp.advertiser_master_parent_id, - 1) advertiser_master_parent_id
	,--Qlik Enhancement
	lamp.advertiser_master_parent_name
	,lac.advertiser_corporate_name
	,COALESCE(lac.advertiser_corporate_id, - 1) advertiser_corporate_id
	,--Qlik Enhancement
	COALESCE(lacg.advertiser_category_group_descr, 'Undefined') AS advertiser_category_group_descr
FROM edh.lt_advertiser lad
LEFT JOIN edh.rl_advertiser_product_category_master apc ON apc.advertiser_master_key = lad.advertiser_master_key
	AND apc.display_flg = 'Y'
LEFT JOIN edh.lt_advertiser_category_master lacm ON lacm.advertiser_category_master_key = coalesce(apc.advertiser_category_master_key, - 1)
LEFT JOIN edh.lt_advertiser_master lam ON lam.advertiser_master_key = lad.advertiser_master_key
LEFT JOIN edh.lt_advertiser_master_parent lamp ON lamp.advertiser_master_parent_key = lam.advertiser_master_parent_key
LEFT JOIN edh.lt_advertiser_corporate lac ON lac.advertiser_corporate_key = lamp.advertiser_corporate_key
LEFT JOIN edh.lt_advertiser_category_group lacg ON lad.advertiser_category_key = lacg.advertiser_category_group_key;

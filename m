Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0CC606A32C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 05:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Hm/ltEzH
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLSwW1Zkrz2xJR;
	Fri, 06 Nov 2026 16:51:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793944283;
	cv=pass; b=L+BkpmhCk52aJJpK+RWwEV2WCRbD9J76kPVxC0iAOcltzEcAKIWlv2xNGzK6OmtxJt0LJ5A9VX4r4DJH0iIYj4nSBlbUcmkTeDwvngAIKKsXohlGpFeRuG7y7vUM5SHHaTZsuJMxrdSdaayAncMweMsDemy2dj+Q+/CpFJ1NHJAahTLZ984I9Tf6PJPEB4ZA78INLkHxqHDbwbs3ahSSsMfvZQZqI8aX8dc4T+6dlrtgOfdJbpq2St2AKrBBO+aMSqS/loaFF67HaZyHC0x/7eruI0AH6WIHp1IQaumhSElPzqyw0X6nXuMjfDhy+CqBRPWxF6ggdqtt+OQH/On7nw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793944283; c=relaxed/relaxed;
	bh=BiucHKtr1h+ZZ1tf6PtOaZblGmbEiF+AJeMRFfmixBo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=blsZZ5QGisQCMcZ09xu0kgxVV7PhgPwiyvD6QBuhpjIZuoWUkqChaHIj0J5bEyfFwNJQgCjAW6YNNoLv22ndmTKe1owX+QcLfNUP0oPjAtUhEYnxUhB7rA48JUnumSPGNWxG8Pk6x2Sof2yuWwK5CGnV3FpUppET/LLiRJzeftUwCRoLHFUb4xfOj7bPxMhTnX47qfM97RWypelk7P89VlRryVz7utY2YljB4bpPBM5+r34y1WNILhglPpUXGDfPA9FeqjBwFUVZ6+ZO2QLtEajCXetD3n1wEgJPTj6y4W61WYRW3f8JZWzPLSU8V6oUJ1WV7b453adMqfUqXw3QKQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Hm/ltEzH; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=chancel.liu@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Hm/ltEzH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=chancel.liu@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLSwV2fC1z2xHG
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 16:51:21 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcwRRbd5rPe+m4XsZYZthmdD8uAtLSgY48L0ved9VreYBJ/90CHl1+Iq7oBNfos4P/VzK32nLXVMa6DfVH2+D11eGP6lLG/ae9rvoo4FjvDv9ftTRln2aRWuNrJxU9OMB/U05O/kqLoZEy6dmV8+YmtXRL9/F9+8OpUXM6KtYiC2JkMDBWBLwy1MWNfOfVvLRf9U5hzedBNu1uR+oZsQL6wOT5XCJ/kEwCVBta08qd1cXGdxtv4KbssFJ9o1afC/youVdCAWxMPxVvlIJmrKdPNUm4ieo8eC8BzBli1wjO/dooqjh7eXKRnVUHQgufn4u4CXvKsDlCPsrK3lkkiZwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiucHKtr1h+ZZ1tf6PtOaZblGmbEiF+AJeMRFfmixBo=;
 b=A62cjHzr+Mf8Xjmx5M9DblQLmbTlA3a9cfpGoEBvRbZj4xidpenu+y/SrSCApd2gN+5uEV4XTvrqSLy4XGdu7Ow2OSGRjcI8zB7tmKBmSql25yvRrr4wjGwEhR9x2edJW/Mdsj8F4Sne509c/Lka5LK97Uxd0JsC80k3VlqYL06XxEN1sKqmL3RzrAtJL7XLMSWBAZu4Z2oard2nasnrDaSZsVtL8WijQs0QaI1OoZ/951dTCqOZl+/QXLMTn0oOB0AqGlmssd5XNV6B5ixMehUuFlXykckYrY3aSansX5/KODzHXWudI3O+4uQWzA0gSOFhwe5Wqem7ae5WXGjBpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiucHKtr1h+ZZ1tf6PtOaZblGmbEiF+AJeMRFfmixBo=;
 b=Hm/ltEzHRIicTrF5E6m2Vmp/Pl2P524TeKKiB0l0WYR7WUZzyI82ZQ+LxYIDsmkl1dXy7wB8+Ayl0SsdxG1U0gTa+kc63rKyve3qHoiwpHc9ea52bI8lzf//q0R3E0MKhziCf5Yc/soixF+FNYwpLwr0TYUeZbfd3iTyr4Y1V5Zj37gXGTBrSi+9axiAJUOqv0A+I8oJG0sbFNTUMXk5zjk93hITtPxe90hzYcfTRL9wDlBI8BP1g/EfRDbLEH39hGFU9GKehtMIybCsHw0EaAYEWeplfzE7C3JXmF5sHU6S5VaH6MXbR8kSC1uI6Nxrv9DtW8gsI7incvcKX8LY6g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8364.eurprd04.prod.outlook.com (2603:10a6:10:24c::17)
 by DB8PR04MB7050.eurprd04.prod.outlook.com (2603:10a6:10:129::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:50:59 +0000
Received: from DB9PR04MB8364.eurprd04.prod.outlook.com
 ([fe80::9f8f:d501:88da:538c]) by DB9PR04MB8364.eurprd04.prod.outlook.com
 ([fe80::9f8f:d501:88da:538c%7]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 05:50:58 +0000
Message-ID: <11ef44f7-e268-438f-8a42-c3bb89e42cfc@oss.nxp.com>
Date: Fri, 6 Nov 2026 13:50:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: fsl_asrc_dma: fix error handling for DMA channel
 retrieval
To: shengjiu.wang@oss.nxp.com, shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, nicoleotsuka@gmail.com, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20261028025921.4155551-1-shengjiu.wang@oss.nxp.com>
Content-Language: en-US
From: Chancel Liu <chancel.liu@oss.nxp.com>
In-Reply-To: <20261028025921.4155551-1-shengjiu.wang@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To DB9PR04MB8364.eurprd04.prod.outlook.com
 (2603:10a6:10:24c::17)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8364:EE_|DB8PR04MB7050:EE_
X-MS-Office365-Filtering-Correlation-Id: 27157d02-0bc1-45e3-5d88-08df3bc9ee42
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|19092799006|921020|11063799006|56012099006|261021121427099003|261022105027099003|261021123027099003|261009223027099003|261102123227099003|261026140227099003|261028144727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hq/jH4Z6DProXHurPsEaF//UB+8cGtxY2o29MNPLVMSBWv3F3gCJ57v6z8MzJv0F7uCmzyBgQrtlcQYX3zsx5HOw9PktlHwJFdbgbnqMOmOcfX9zyOqQ3kWRcUt3hQFgZ04O2MLr7fTEcFffIDZsqxgtBBiukxq49foP3W0ivr8zH/OsBARUfjfFgG2nnzGUKnqw7oelxH/Mp+tQbNBmefK/I+NG5Jv8rtX8nbJcDXKjJ4bRapqwj0jVrr5JdbC4DUpcgcNPg34ygDK7eLjTo9P5zUHzUvLbz5ulaVv/fIQ4Q0+/kZ0GOTBMl2ovSuqkFvrlp7yv4EoZaN2MXUI/LQQ+MTYo91hujz60y/QeDXQ1G5o2PVqCXeBPn92iHliyrM0UPHURNEe+s/4vImFQK4X9/zk5CJIlw8zzfN4g4EhevrXEzf1T8PRQiiBvGKJ4QuwFpTKVir61Swl2ju3OKrI8qZ5TE4QYpmxtGp6zmc9b9CkbFWfYAiebuWks0SJeIIQ5E6R22jEEFIAsT6qzMTlx/EUPcAkYYtbOzMWY6gUtr4MfQ8Z8uU2NctQwyfB0ysxbuy0R8plbx+27YLkw8SDRzI2hkc5b0i9hDb01+Lv5Es3L55QuwLeo6oBzhQf7+PCCDB5ZuQacDUfFWsY/riy/mmGzHpNcKa2vRJgKYu0WZ/Nz2buCR9GbXeO1nQg9m0YtYkK3Vrxs3779jYJmYw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8364.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(19092799006)(921020)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkhZcURSNDBjYjZEcWxSQUFYcy9YcU9lOE1VaytrY3lndHdQR3gxTjFTUlAv?=
 =?utf-8?B?ZEdpaC9qVUhDQnBSeEwxeTFWNThKbVZaeFJHWWE1MWJ0M2V5a3EwSDBTMkEy?=
 =?utf-8?B?bU5SUjdXRW9nTWpzanh5K0dPYzFzMHU5Z3ZOTUNXcStkcTI5MjJlM2l0QWJR?=
 =?utf-8?B?UE5TM3lGY09kOXJrcnRYK0lwS1hRU3lvaHRVR0Job0psa1VnbU9meVZLZGVX?=
 =?utf-8?B?OWZWNENuZm4vdXVzK2J4RGkvcEtMaTZKM1IvTlZ6RDJDZ0lVZ1V1bkVBNGRM?=
 =?utf-8?B?SWdJZUZiVWY2c0UyVlpnZ09RV21GK3B1N1JBdW84bTFlTE5WL3loSVh1a3dy?=
 =?utf-8?B?Ti94V3Z2eWJJMnhSRWE2ekkvQ0dFSVh4cmt2QTQyK3pEWENQdThERGw4cDFq?=
 =?utf-8?B?YlM0RkRKbU9SWlJ4b25neTlqMG1XRzNxNXJKQ3pzQmcrejR3YWM0VU5UV015?=
 =?utf-8?B?U3Z2djVCS3dNOXUvMFB4QmxzYk85UGZCczdPTHlQdXRvekxrbnU2b0JySEpV?=
 =?utf-8?B?UzdVSU9CeFpFTEMrTktwc3FQMDZHQUt3RXNmZTdMSDhFaHJNTmthaW42cUxu?=
 =?utf-8?B?dXBzbURSVnowdExFSTZuVUIwOTNaVHB0TS81STE2ZDNOcDltRTBQTDlNNW9X?=
 =?utf-8?B?Y29BbWk3bG01V3NLWVhWRmQyM2tvcmFsUSsrU0NpcHc1VWRTZ29BZDFYT3c5?=
 =?utf-8?B?WnpOR3RMWjRFTUNhbXZMY1dqNE1nUDNlT0FUNUNpMWh5ZHljR2tINmVSeGZW?=
 =?utf-8?B?OWJqazMyVG9WUGlOVi9FMHoya0QzRUpwV1BCamhQb0c4bmNvZDlHMmdEZm1T?=
 =?utf-8?B?WllrdktUYWdqcnB6OG95YXZVQU9mMEJoS0hEY0NDSFBkeGhvMStvMzhMdlQ3?=
 =?utf-8?B?SzJ6RXVLa01LcnFNYTdqTWFOZHVzYWN5VzJxRXBRd0VkSFl0U2hHVWl0VmN2?=
 =?utf-8?B?YTNxckswN3VkSnllRi9UTlVzVmE3aGc1ZHRPNDh0NXJsV0xzU053WjhRUzJB?=
 =?utf-8?B?VWcxc3NWanlwR3NjYkxYZ3Z3NUV4SnBDUVJKa09HREptRncrbmV4bW9uSnha?=
 =?utf-8?B?MUVhRXNGQ0FWY2kxZ3lMcFRIaHBiRnU2d2RuQ1RQM0JiQ3drTkVwTmIxM1F2?=
 =?utf-8?B?QnVBdlVoOGxTTjFVK0M4c2piUGxwN1BKcHdQOEE1UDlJb2dJaGRMcm9HTHFD?=
 =?utf-8?B?ZTFScXBEMS9SUHFwcExIUndFRTV1a1BQUlBPSzRVQzM2R0FFd2hmUUJhd09G?=
 =?utf-8?B?MTF6SlBKb2ZFLzJSQ1hZSjNVOStGaU1BSWNhOEFSVVVsMFVwamFZLzRldG40?=
 =?utf-8?B?ZFdJWHUyM0JpczdoVDBPWU9kVlc2WEErTEx5NlhIMTVHL3VXcnVraXhvWDQw?=
 =?utf-8?B?VFA0THBkWFNRSmxsLzVTRGJrVitRVlZzRGJoL2lPOTRKMWVHSytCZTZDVHYr?=
 =?utf-8?B?dCt6RmZhNjhpYzNoTVgxZ1lKMDZUUXBuY0EvZ0ZINFBYNFA2aHVUenQzU3NM?=
 =?utf-8?B?SGliMlJqSnNjSHNEVDZwVDNvVnV3R29VTmYwb3NQSHFIUGdGSk9GNG9sTVBR?=
 =?utf-8?B?dVdOOTd4b3lKelhxVzltMlJtbXJYeFMxVmhod3A3eCt0WENXdEUxcWlNWW1o?=
 =?utf-8?B?blNuM0pxdmY3NjNWekI5b3dPeGVKVW55b0xUQTkwclhuMC9UaDhOM0RFRm1q?=
 =?utf-8?B?TVAvQVhLeWY1c3piZm93NzBsSXlzODg5eEpxUGw5Si96a2ZoY1BCcUlNdDl6?=
 =?utf-8?B?cTczYi9ldVF3dURBK0dlbVZrQkZubHZRenlhMmhTVjZubjJIV05HOWVDa0Rw?=
 =?utf-8?B?aUlhbXN3MFFyR3loeWZ4VmdXUEJVQWVWdHBtUU11YXhaZzUwY2xZUXY4QW15?=
 =?utf-8?B?Rml0VzEralJOQ29ZMUtvK3pnS2o4MkM1Y0ViOFlhejVDcWxwV0pIRHdZcXda?=
 =?utf-8?B?aVRBMjVWZVdzZm5RSTFDOVU2WHJFNmJWNk92SUp0N1Z1VFllSFQrY3l0UkZr?=
 =?utf-8?B?Tkwyb1NHZzRtSUFvc3pwQUMrbW5BcjJiN29RbFpSWWdJMXdXd25qdVF3VFVv?=
 =?utf-8?B?S2xqVnBmdmpiZzR2bHU4Q0k3TXNQaEl6VDZzQVBKV1k5WDJXRThKVG5qbk55?=
 =?utf-8?B?Yk5XdDRxK1oxaGx3K3pOM3pUNzNkRGJXSEFGWjdyd3FCaVFyZ0lJdWVGaFll?=
 =?utf-8?B?YjJtcVJYUTN1YkNQbjhja3pjMDRsamp2aGlCQVFjTHFHbmwxMTdsY2hTeWdx?=
 =?utf-8?B?NDA1cmczTkl1QlpDY1dwa1RRSDF6WklPOVF2MEt2SkphVUw3dW1Eb3VHcTRn?=
 =?utf-8?B?ZVViRTBNdFhqV0dQVEZKY2lySElkNjc5MitQR3J2WUhhWUdhYmk4Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27157d02-0bc1-45e3-5d88-08df3bc9ee42
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8364.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:50:58.7953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCQOPrOD3thyvKcslNUqMsVhxon4b2WZnM6YvK6tCM0Ct2EkZB2wrcfQmbI/aMm/wdNn52H86LPS+qZuZC8DTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7050
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/2026 10:59 AM, shengjiu.wang@oss.nxp.com wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
> 
> The original check used `if (!tmp_chan)`, which only catches NULL pointers.
> However `asrc->get_dma_channel()` returns an error pointer. The NULL check
> will always succeed, so replace it with `IS_ERR(tmp_chan)` to correctly
> detect errors.
> 
> Fixes: b4136c0d69ea ("ASoC: fsl_asrc: check the second front-end DMA channel")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Chancel Liu <chancel.liu@gmail.com>

Regards,
Chancel Liu

> ---
>  sound/soc/fsl/fsl_asrc_dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
> index b417de6abebe..b39d3d76d26a 100644
> --- a/sound/soc/fsl/fsl_asrc_dma.c
> +++ b/sound/soc/fsl/fsl_asrc_dma.c
> @@ -251,7 +251,7 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
>  
>  		/* Get DMA request of Front-End */
>  		tmp_chan = asrc->get_dma_channel(pair, dir);
> -		if (!tmp_chan) {
> +		if (IS_ERR(tmp_chan)) {
>  			dma_release_channel(pair->dma_chan[!dir]);
>  			pair->dma_chan[!dir] = NULL;
>  			return -EINVAL;


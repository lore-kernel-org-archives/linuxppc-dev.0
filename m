Return-Path: <linuxppc-dev+bounces-25664-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6E2C5AD4E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 09:39:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJV876f2hz30B7;
	Mon, 10 Aug 2026 19:39:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786354759;
	cv=pass; b=fofIVoVK3FtvT7Rc8jIMh9faxp5n4BSkqdcWAhM95y9O+gO7BQcPcZrKCM3Dw5LL5Wj28AeT8BX70X9TI0ssovVxjyofpWR/LToijOOeyBSZ88u7lccQEaOJNnjuaP9i/bhqu2FF0e3zNJ/5mnZU0MxCLzOIvvSVLjBKtkY2/1XfcD+pogloIx8zxTrnXbbtUocwTELtxR3NZ5Vnx53sOxrJRld2ppqmmzc/jrmlpjYFU5uGtrEMamP/ecPEMtX4FMaBUlnxodT1Lvie+WjqRLHA83gjbTnLC5MQsvq599gSpWMGQTSeGWC3+9N4vZSpyaVsW9ADSISbdRZgvJt9yg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786354759; c=relaxed/relaxed;
	bh=DyiwU6m7TBUz+XV6Ct+ExYh21+Dow4TW2YHodOfeUGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F5RhCdGUM+0tE8x01QKLSYxbYEtpA1Yqg/YmqvwriU6vC8uPsnHoW6G61QKzaMx4YoNcPBCFRwbL/LDwVgN8uc3h+yOqjZa9mBCyOiDK+bh9PKMGzRkuy792DsC5+SfkPDl/ERmmKBpRXgT1WqVhjA29KjAWim5E6yuh/mtBbP8zhV9uCrPKnfUHcTQi5UnFIeCBphPt1/qI7x2FyTNcYasGDzvXOcqBbUUqqrIyCUmckB+j/kJwX3hDDfkFcgfecUj6DkrFTY/mwZd5Ca6jagAKAeWo/ioJUHw+3w9h/ZP7PRMk77nNRUMddZ3jDsbJnd6YPB617DIvZLDQ13HrbA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Ew8a8OBc; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Ew8a8OBc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJV863mq0z30T0
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 19:39:18 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxXsW6K6C9vwLhzJebu6T2jTaRJz77bHeJ6lgHILkL5RH6zd4B5gx6fWIkbOO3WGWzwM7us5HGzl4CbPCRytLrh7HJWoVGhJqwlOnYAU5p2OsKjHKA5U1xo/3jvNWfAnuUwB2KAWaNZS9YFW70J903msHPRMGvNQRQc0CeJCWJFIxlFO4qjq5heetpJx4Xd1Wk0k3TP+wI2NuJ5qpURzmmWcNJT/J3QIYb/lKV1Ec2YMcyz2OG7DaqBaHMt7rtrR/bsiD+PQ+3+EOhezNvlfMvozNI6OM163cDDqHVfbf2/zI6/6C7l8Dk/yxGPrfBxCXV2ssG7r2DNyFZAcjF3nWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyiwU6m7TBUz+XV6Ct+ExYh21+Dow4TW2YHodOfeUGQ=;
 b=d1T7v4okzsVDw/xxHXp1mVnSKzpG4XI5Q9Gqf+bdZyUjp9cnC7K8bcybevOf9+xCzkS/jnMgm5l0D24btkXa5v8XXH8aNSpPC2ZZv6s/h5hBCh2EwSbXuepKLZgtMJB6eG8prbcMg/yZeWcnUAHnblhGe8aG6QT7/SKkwiuWttGRZXKeeSC72CIPbXaGYTtE4ZLpvYSybrIs3ReMyhwWkfj8Ii42pkTB02er6/6jBQOXX2zACjhM1zjSHBiDPVPwU5CwGHTCMEPD6yu2VuAlynFXQKg4aROaSzwfyS22gkGmuVimWc2z8yA5ST9D68Bjby6LpM0hBNRmSSf4UHppxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyiwU6m7TBUz+XV6Ct+ExYh21+Dow4TW2YHodOfeUGQ=;
 b=Ew8a8OBc9EDPmwnUJEVB2Lu55vNwFU0sHQfHq/8pYrERs2A9CTx+s9Jw//XSD9JH1aki6ZvIgk2pkq1ilhXXsu631EefhfedrfiMnb1ddmXsXyKfmznLxlYAsCDlTnEZ0dU6JqK4+UuZglbnDKAtjxjZInRFwJplsbaKQpwEbFiOhQcNmOI+8MPg9fnMBD2ZvOqLbW4a4UuBdoLx1XHchMkPUXV8pf9Ov9n2HahJpKt7CWKoSC9osxYatK9I4tQiiPczTVDtC4OY1E3BXSdfUsY9rEwRHwn//v6tYIdR6/R6RnBDVmaFfoFp51j/SMvoeCeTpXJKw/TqQVm9BfopKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB10021.eurprd04.prod.outlook.com
 (2603:10a6:150:112::20) by AS8PR04MB7557.eurprd04.prod.outlook.com
 (2603:10a6:20b:294::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 09:38:55 +0000
Received: from GVXPR04MB10021.eurprd04.prod.outlook.com
 ([fe80::d247:853:3e16:1994]) by GVXPR04MB10021.eurprd04.prod.outlook.com
 ([fe80::d247:853:3e16:1994%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 09:38:55 +0000
From: Chancel Liu <chancel.liu@oss.nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: hui.wang@canonical.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ASoC: fsl-asoc-card: Move static compatible data to platform data
Date: Mon, 10 Aug 2026 18:35:30 +0900
Message-ID: <20260810093834.1511749-3-chancel.liu@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260810093834.1511749-1-chancel.liu@oss.nxp.com>
References: <20260810093834.1511749-1-chancel.liu@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SL2P216CA0103.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::18) To GVXPR04MB10021.eurprd04.prod.outlook.com
 (2603:10a6:150:112::20)
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB10021:EE_|AS8PR04MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 940dc6a5-ce77-4e90-bbb7-08def6c331ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|19092799006|6133799003|11063799006|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cNZ88WB8+UUbO2tl9gArftJt6GTC0odacd26+JMIAatKAAxjCg26F3u+sxzs1gIaB6YXSOacQgWR+wzC7W9awX/kyAzJfJYWtwpX3iq23/X6zbpugvvdck7urjNYr3cc4mDZJdEJnI/e47WGrZGx5H9pWWRr7KKwyR6Jef/Qm7D3hEmgyHHtYEx5O2hJywoDiXAA96qX4PD6es2pD7VYHwp9KeKXZt3Et81ZlDHwC5tksp/Dr3msUgZp4Q8W+efJ7S0mGHyKzwZ4XaB7PcSJmAvsTyYk3jGRnA0VBiIQt+qOrDHIjiQVtZ3CHf8YjCtsrNF92w4BSSPQdQjV0WJuEwGofPt6r6knKMDsSSK900Sv0LWNqt5Tpuqn6K20KmLhDxbFyDfXABGCxY7qIHnZQGQCRQwrVtpMLa+KGJ1ylybiFyDwhBJdus1+EwLCP7TY64OTBgwnk7Z7iyNND69/RpZv7F9io7DJt5vUsBw8SWYwIRtsxi4Bh1ZZMNdpQR9qUBt7mmnjJFErZpHiaN4HojgzI7iHfn4WxW+AE838dlL1lwKX5lcFYE9fbuDHrDX6PaPuUNUb2MFhoakFhQRldGKt+oK5CjUzKjBTa7kE4B44ldxpzUFA5AUePcnUOM+8Aeh7V2/GHafMIAT/RGibS38LHz513weJnbWIJornW38=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB10021.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(19092799006)(6133799003)(11063799006)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2Jqd0lqdWZQOFpoTDErUEZhSDJJKzQwcS9ZSjNYK0lzWlpPZlkwWmZJL1Fp?=
 =?utf-8?B?MmluNWlCWHhjeHByTXBHWEFORmNaUDlHMThieWlIUlFHbFhaSFY3OGRnTUNw?=
 =?utf-8?B?TnNMblJQNVNnaFNxRmNkeVBJclVwSHNlQkpGTENOM1AzakZpaXpkQ1ZrT3gz?=
 =?utf-8?B?U3d2MGNpNldDT0N6ZlJZYlJzMUR0Zld0ZHZGdWx1bjV3UkliRllWY2M1Y0tY?=
 =?utf-8?B?bW5EQ0RZOEFyUkNQZTJVY1JkTEFPaFV2dkNWT1d6S1pJbHA3K3VGQ1NYZXBY?=
 =?utf-8?B?Q2NFYVNSKzVWWmtNS3U5UmdsempadkwrSWhqMWZRNWh3aHNONlVWclcrRmEv?=
 =?utf-8?B?S0NuWkNpcUlCUG4wVGx0a0FPaURuUXZjOGhZQkV3V2tQTktNR0NQOU1XbG5B?=
 =?utf-8?B?NnZBdEJQRVJIR1FWeldSOXpGY3dVVXN3dzJCdk1DNmtWRmRqVHlUaDV1eCtI?=
 =?utf-8?B?YVIySGYyMDd5K1ErcUNJZE1Jakg0eUNCbDFvdzNUL2cvRllubVBwOGpOMHFo?=
 =?utf-8?B?QXg2MEcrV0FuVUtCTFcyQ2RUY1c1aXlKakJrbnV0aEFEZ2NUbEVjT3JBcnRs?=
 =?utf-8?B?bldLSnpKd1hEOGtoSHp0MEZsV1BvMS8yT0psUGhtampzeUYyU1MwTFFHUnRW?=
 =?utf-8?B?S2lySUhkc1l2dzlXUEgxWENmUWxwOHdCdWRwVEY2WXFUUFdwWXFsbHo1bEFa?=
 =?utf-8?B?b2tCWHVsYzVxYVFVQ0NzajJHODhObkVnVE04OHlRT01zb3NLYTVHTFhWRXJU?=
 =?utf-8?B?NGpDdWE1Uk9LZFlVUHo1bzdkL2V1SG8zNFI5aEhreFpKOHBhTy9JaVJKNjkv?=
 =?utf-8?B?U3AvM0JoUFNybHNneG1nZ2RlYXQvNC9Ddjc0Tk8zdGhDSzlJb2g0Zko1cGE0?=
 =?utf-8?B?QVNCL1hNTEh5V2krSUgwVXZlMGpsa2REdTBjb1lQTkpsRjlHSlQ1cXY5aEI2?=
 =?utf-8?B?ZFV1UjI2dnIwRG4zRTNIc1hvUzVBRlRMN1NsMm5PZ2hSQmZBdjAvUVEwb2VO?=
 =?utf-8?B?MVh6VXZPWUQ5UHRYWXR3bDcrK0dKM3J1UmVyZXhSTGlLMDJLSDN6Z2o1Zmk5?=
 =?utf-8?B?aXJHL0ZKUDhNRkNUUU96amlmRW9VSk93bG0wMGpEb25ET1IvRmxxdWp1SVBt?=
 =?utf-8?B?OHJ3QzN3TjhZSGllWXdPY01BNEc5Z2pUTGE3K2pldkFTaGluV3IrSW02R0lH?=
 =?utf-8?B?cjNDY0I1RzhYZTQvdkp3N3ZIOW40V1JRUzVVM2Q2ejdKYzVobXorZzd4TUpx?=
 =?utf-8?B?aGJvMHVFZEtkL2RMTDhKUzJveE5icWtSZndqT1kyV2tGaTN1WUtrSU1McS9w?=
 =?utf-8?B?bXhWTllOZ2s0TnJPMDE5V0owaWowY3dWM2pWM0Z1NWcrVEtLTmc1d1lxMDlO?=
 =?utf-8?B?clJBbjRjbmFReTl4WVFxUmtjL2pKc243ODFpWVJFNU1Gemp0L2E1Qk9XekNr?=
 =?utf-8?B?WG4vVjVuekRzSHFoUDk2VjhDQUZreWhrbzRQMmFCWGxQajlobi9mZzMvNHRa?=
 =?utf-8?B?UytzWmJUYSs1Y2UzQUdhSm45c2tVODdIVHRXa2JqVE9sM3RqS0JvOWVxWVdn?=
 =?utf-8?B?VXpZRndic1VaaGNUc1NpakR1RytlL3Bkb1VkRGFqZXJTOEJVOGp3UUI4bXda?=
 =?utf-8?B?RmpHVDdaRTQ2LzM3RHlRTnFldGlESnRUT0hrZ0ZXWU01M3Q2S2c2UUp3Um81?=
 =?utf-8?B?MktmS0tWWGNmSjBXNHpvOHN6Y3Bpdnl6VnVsVUV1aVBSR3U5Rkx3ZUdQaDhw?=
 =?utf-8?B?cVBrQVd1d0FFQkhCUDExSk0zRTJQcWxjNzR6cE50ay8ra3V6SXRuTWlVekVP?=
 =?utf-8?B?QmlvYVhXbDJUajF4Yk1UZG1rTldlblExbXZ5MmdLS28vbXFrRzVZeHdvYVRB?=
 =?utf-8?B?RmdXTzRwRVUxT1FGc2ZBU3lvblpyNWsvVUlrZ1RVMTUwaTg4WGx3TWxFTzNR?=
 =?utf-8?B?TUdKMytGYThoL05DZkliT2swZlVpbU1VaDVpSnM5UHZiRzlOS29nSEY0SWRW?=
 =?utf-8?B?eFdHR2crd0lBQUlFOHRIcS9GNEVsa3ZPdXExeFVxdG9jaC9NOEtLV2F6Ti81?=
 =?utf-8?B?YnROUkFITGZBOTlLcGlOWWJnZTE5dDVrWXQ0OHhJN3h6THFJMGFRcHRKOHZR?=
 =?utf-8?B?QncxcDc5TC9sVGVOWVdhNnpWQ2hSdWlsc3dGN3oxUXRFT3o4OTlUWFV0Wi9P?=
 =?utf-8?B?bXk4dFp5N2U3dGtsRFljNGo4YTVUNlpmdEdXdDZuVEg2bCt6d2dUSTBrQUN2?=
 =?utf-8?B?d1RVbUI1REdEbVZTYSs0eFptUkxMVnU3TUlUWm5DbHpFMDdzMy85N202eCtR?=
 =?utf-8?B?VFJGNUo1SlA5N2pyd2JHQllxNjI3Y3puMTNiT0t0Qm0rM0dqT0Q4amQ1UUdI?=
 =?utf-8?Q?QB/aozirqxCYAWMzKC9q8QQN3mJYiE1rzO/Oa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940dc6a5-ce77-4e90-bbb7-08def6c331ba
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB10021.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 09:38:54.9919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QgWsyXBMCfUK1bG/r5hvu2hZECB0Q0vZgSUIOaQMwAshUuI8YVNZF9ZQzxRtdtOpHPMGsxuGzL4MhU1qodYZ7OXuhIMWc9MxMbTLfhJkKvREVD22xEFnYzsR2ICW6FQm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7557

From: Chancel Liu <chancel.liu@nxp.com>

Replace the large if/else chain of of_device_is_compatible() calls in
probe() with a table-driven approach.  Each compatible string now has
a corresponding static const struct fsl_asoc_card_pdata descriptor
stored in the of_device_id .data field.

probe() calls of_device_get_match_data() once and reads all
per-compatible configuration from the returned pointer:
  - DAI format
  - CPU SYSCLK direction and ratio overrides
  - TDM slot width
  - Codec DAI name, MCLK id, FLL/PLL ids, PLL S24 ratio
  - playback_only / capture_only direction restrictions
  - Default DAPM route table
  - Excluded PCM format mask (for SAI + WM8960/WM8962)
  - Optional probe_init callback (SPDIF multi-codec discovery)
  - Optional codec_init callback (codec-specific post-probe logic)

This patch is a pure refactoring, no functional change is intended.

Assisted-by: VeroCoder:claude-sonnet-4-6
Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 423 +++++++++++++++++++++++-----------
 1 file changed, 287 insertions(+), 136 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 4c245aaf2847..10e432c916b8 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -107,12 +107,58 @@ struct cpu_priv {
 	u32 slot_num;
 };
 
+struct fsl_asoc_card_priv;
+
+/*
+ * struct fsl_asoc_card_pdata - per-compatible static card description
+ * @sysclk_dir: initial CPU SYSCLK direction override (0 = leave default IN)
+ * @sysclk_ratio: SYSCLK ratio on sample rate (0 = not used)
+ * @slot_width: TDM slot width (0 = not TDM)
+ * @codec_dai_name: name of the codec DAI
+ * @codec_mclk_id: MCLK id passed to set_sysclk() for the codec
+ * @codec_fll_id: FLL id; only valid when has_pll is true
+ * @codec_pll_id: PLL id; only valid when has_pll is true
+ * @codec_pll_ratio_s24: PLL output ratio for S24_LE
+ * @has_pll: codec uses PLL/FLL; codec_fll_id and codec_pll_id are valid
+ * @dai_fmt: DAI format flags
+ * @playback_only: restrict card to playback direction
+ * @capture_only: restrict card to capture direction
+ * @dapm_routes: DAPM route table override
+ * @num_dapm_routes: number of entries in dapm_routes
+ * @exclude_format: PCM format bitmask excluded (for SAI + WM8960/WM8962)
+ * @codec_init: codec-specific init run after mclk_freq is populated
+ * @probe_init: optional DT-driven init run at end of probe() (e.g. SPDIF codec discovery)
+ */
+struct fsl_asoc_card_pdata {
+	u32 sysclk_dir[2];
+	u32 sysclk_ratio[2];
+	u32 slot_width;
+	const char *codec_dai_name;
+	u32 codec_mclk_id;
+	int codec_fll_id;
+	int codec_pll_id;
+	int codec_pll_ratio_s24;
+	bool has_pll;
+	bool playback_only;
+	bool capture_only;
+	u32 dai_fmt;
+	const struct snd_soc_dapm_route *dapm_routes;
+	int num_dapm_routes;
+	u64 exclude_format;
+	int (*codec_init)(struct fsl_asoc_card_priv *priv);
+	int (*probe_init)(struct device_node *codec_np[],
+			  struct device_node *cpu_np,
+			  const char *codec_dai_name[],
+			  struct fsl_asoc_card_priv *priv);
+};
+
 /**
  * struct fsl_asoc_card_priv - Freescale Generic ASOC card private data
  * @dai_link: DAI link structure including normal one and DPCM link
  * @hp_jack: Headphone Jack structure
  * @mic_jack: Microphone Jack structure
  * @pdev: platform device pointer
+ * @pdata: pointer to the per-compatible card platform data
  * @codec_priv: CODEC private data
  * @cpu_priv: CPU private data
  * @card: ASoC card structure
@@ -133,6 +179,7 @@ struct fsl_asoc_card_priv {
 	struct simple_util_jack hp_jack;
 	struct simple_util_jack mic_jack;
 	struct platform_device *pdev;
+	const struct fsl_asoc_card_pdata *pdata;
 	struct codec_priv codec_priv[2];
 	struct cpu_priv cpu_priv;
 	struct snd_soc_card card;
@@ -607,6 +654,186 @@ static int fsl_asoc_card_spdif_init(struct device_node *codec_np[],
 	return 0;
 }
 
+static int fsl_asoc_card_cs42888_codec_init(struct fsl_asoc_card_priv *priv)
+{
+	unsigned long mclk_freq = priv->codec_priv[0].mclk_freq;
+
+	priv->cpu_priv.sysclk_freq[TX] = mclk_freq;
+	priv->cpu_priv.sysclk_freq[RX] = mclk_freq;
+
+	priv->constraint_channels = &cs42888_channel_constraints;
+	if (mclk_freq % 12288000 == 0)
+		priv->constraint_rates = &cs42888_rate_48k_constraints;
+	else if (mclk_freq % 11289600 == 0)
+		priv->constraint_rates = &cs42888_rate_44k_constraints;
+	else
+		dev_warn(&priv->pdev->dev,
+			 "Unknown MCLK frequency %lu, no rate constraints\n",
+			 mclk_freq);
+
+	return 0;
+}
+
+static int fsl_asoc_card_wm8958_codec_init(struct fsl_asoc_card_priv *priv)
+{
+	priv->codec_priv[0].free_freq = priv->codec_priv[0].mclk_freq;
+	return 0;
+}
+
+static const struct fsl_asoc_card_pdata fsl_asoc_cs42888_pdata = {
+	.codec_dai_name      = "cs42888",
+	.dai_fmt             = DAI_FMT_BASE | SND_SOC_DAIFMT_CBC_CFC,
+	.sysclk_dir          = { SND_SOC_CLOCK_OUT, SND_SOC_CLOCK_OUT },
+	.slot_width          = 32,
+	.dapm_routes         = audio_map,
+	.num_dapm_routes     = ARRAY_SIZE(audio_map),
+	.codec_init          = fsl_asoc_card_cs42888_codec_init,
+};
+
+static const struct fsl_asoc_card_pdata fsl_asoc_cs427x_pdata = {
+	.codec_dai_name  = "cs4271-hifi",
+	.dai_fmt         = DAI_FMT_BASE | SND_SOC_DAIFMT_CBP_CFP,
+	.codec_mclk_id   = CS427x_SYSCLK_MCLK,
+	.dapm_routes     = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
+};
+
+static const struct fsl_asoc_card_pdata fsl_asoc_sgtl5000_pdata = {
+	.codec_dai_name  = "sgtl5000",
+	.dai_fmt         = DAI_FMT_BASE | SND_SOC_DAIFMT_CBP_CFP,
+	.codec_mclk_id   = SGTL5000_SYSCLK,
+	.dapm_routes     = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
+};
+
+static const struct fsl_asoc_card_pdata fsl_asoc_tlv320aic32x4_pdata = {
+	.codec_dai_name  = "tlv320aic32x4-hifi",
+	.dai_fmt         = DAI_FMT_BASE | SND_SOC_DAIFMT_CBP_CFP,
+	.dapm_routes     = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
+};
+
+static const struct fsl_asoc_card_pdata fsl_asoc_tlv320aic31xx_pdata = {
+	.codec_dai_name  = "tlv320dac31xx-hifi",
+	.dai_fmt         = DAI_FMT_BASE | SND_SOC_DAIFMT_CBC_CFC,
+	.sysclk_dir      = { SND_SOC_CLOCK_OUT, SND_SOC_CLOCK_OUT },
+	.playback_only   = true,
+	.dapm_routes     = audio_map_tx,
+	.num_dapm_routes = ARRAY_SIZE(audio_map_tx),
+};
+
+static const struct fsl_asoc_card_pdata fsl_asoc_wm8962_pdata = {
+	.codec_dai_name      = "wm8962",
+	.dai_fmt             = DAI_FMT_BASE | SND_SOC_DAIFMT_CBP_CFP,
+	.codec_mclk_id       = WM8962_SYSCLK_MCLK,
+	.has_pll             = true,
+	.codec_fll_id        = WM8962_SYSCLK_FLL,
+	.codec_pll_id        = WM8962_FLL,
+	/*
+	 * WM8962 has same BCLK generation limitations as WM8960.
+	 * See WM8960 section for detailed explanation.
+	 */
+	.exclude_format      = SNDRV_PCM_FMTBIT_S20_3LE,
+	.dapm_routes         = audio_map,
+	.num_dapm_routes     = ARRAY_SIZE(audio_map),
+};
+
+static const struct fsl_asoc_card_pdata fsl_asoc_wm8960_pdata = {
+	.codec_dai_name      = "wm8960-hifi",
+	.dai_fmt             = DAI_FMT_BASE | SND_SOC_DAIFMT_CBP_CFP,
+	.has_pll             = true,
+	.codec_fll_id        = WM8960_SYSCLK_AUTO,
+	.codec_pll_id        = WM8960_SYSCLK_AUTO,
+	/*
+	 * WM8960 in master mode cannot generate exact 1.92 MHz BCLK
+	 * required for S20_3LE (48kHz x 2ch x 20bit). Closest available
+	 * is 2.048 MHz (SYSCLK/6), which causes right channel corruption.
+	 *
+	 * In SAI master mode, SAI derive BCLK from MCLK using integer
+	 * dividers only. S20_3LE requires non-integer divider ratios
+	 * with standard MCLK frequencies. For example, 48kHz stereo
+	 * needs 1.920 MHz BCLK, which requires a divider of 6.4 from
+	 * 12.288 MHz MCLK (not an integer).
+	 */
+	.exclude_format      = SNDRV_PCM_FMTBIT_S20_3LE,
+	.dapm_routes         = audio_map,
+	.num_dapm_routes     = ARRAY_SIZE(audio_map),
+};
+
+static const struct fsl_asoc_card_pdata fsl_asoc_ac97_pdata = {
+	.codec_dai_name  = "ac97-hifi",
+	.dai_fmt         = SND_SOC_DAIFMT_AC97,
+	.dapm_routes     = audio_map_ac97,
+	.num_dapm_routes = ARRAY_SIZE(audio_map_ac97),
+};
+
+static const struct fsl_asoc_card_pdata fsl_asoc_mqs_pdata = {
+	.codec_dai_name  = "fsl-mqs-dai",
+	.dai_fmt         = SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_CBC_CFC |
+			   SND_SOC_DAIFMT_NB_NF,
+	.playback_only   = true,
+	.dapm_routes     = audio_map_tx,
+	.num_dapm_routes = ARRAY_SIZE(audio_map_tx),
+};
+
+static const struct fsl_asoc_card_pdata fsl_asoc_wm8524_pdata = {
+	.codec_dai_name  = "wm8524-hifi",
+	.dai_fmt         = DAI_FMT_BASE | SND_SOC_DAIFMT_CBC_CFC,
+	/* RX=0, TX=1: set TX (index 1) to CLOCK_OUT, RX stays at default IN */
+	.sysclk_dir      = { 0, SND_SOC_CLOCK_OUT },
+	.sysclk_ratio    = { 0, 256 },
+	.slot_width      = 32,
+	.playback_only   = true,
+	.dapm_routes     = audio_map_tx,
+	.num_dapm_routes = ARRAY_SIZE(audio_map_tx),
+};
+
+static const struct fsl_asoc_card_pdata fsl_asoc_si476x_pdata = {
+	.codec_dai_name  = "si476x-codec",
+	.dai_fmt         = DAI_FMT_BASE | SND_SOC_DAIFMT_CBC_CFC,
+	.dapm_routes     = audio_map_rx,
+	.num_dapm_routes = ARRAY_SIZE(audio_map_rx),
+};
+
+static const struct fsl_asoc_card_pdata fsl_asoc_wm8958_pdata = {
+	.codec_dai_name  = "wm8994-aif1",
+	.dai_fmt         = DAI_FMT_BASE | SND_SOC_DAIFMT_CBP_CFP,
+	.codec_mclk_id   = WM8994_FLL_SRC_MCLK1,
+	.has_pll         = true,
+	.codec_fll_id    = WM8994_SYSCLK_FLL1,
+	.codec_pll_id    = WM8994_FLL1,
+	.codec_init      = fsl_asoc_card_wm8958_codec_init,
+};
+
+static const struct fsl_asoc_card_pdata fsl_asoc_nau8822_pdata = {
+	.codec_dai_name  = "nau8822-hifi",
+	.dai_fmt         = DAI_FMT_BASE | SND_SOC_DAIFMT_CBP_CFP,
+	.codec_mclk_id   = NAU8822_CLK_MCLK,
+	.has_pll         = true,
+	.codec_fll_id    = NAU8822_CLK_PLL,
+	.codec_pll_id    = NAU8822_CLK_PLL,
+	.dapm_routes     = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
+};
+
+static const struct fsl_asoc_card_pdata fsl_asoc_wm8904_pdata = {
+	.codec_dai_name      = "wm8904-hifi",
+	.dai_fmt             = DAI_FMT_BASE | SND_SOC_DAIFMT_CBP_CFP,
+	.codec_mclk_id       = WM8904_FLL_MCLK,
+	.has_pll             = true,
+	.codec_fll_id        = WM8904_CLK_FLL,
+	.codec_pll_id        = WM8904_FLL_MCLK,
+	.codec_pll_ratio_s24 = 192,
+	.dapm_routes         = audio_map,
+	.num_dapm_routes     = ARRAY_SIZE(audio_map),
+};
+
+static const struct fsl_asoc_card_pdata fsl_asoc_spdif_pdata = {
+	.codec_dai_name = "spdif",
+	.dai_fmt        = DAI_FMT_BASE,
+	.probe_init     = fsl_asoc_card_spdif_init,
+};
+
 static int hp_jack_event(struct notifier_block *nb, unsigned long event,
 			 void *data)
 {
@@ -694,6 +921,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	struct device_node *frameprovider = NULL;
 	struct platform_device *cpu_pdev;
 	struct fsl_asoc_card_priv *priv;
+	const struct fsl_asoc_card_pdata *pdata;
 	struct device *codec_dev[2] = { NULL, NULL };
 	struct snd_soc_dai_link_component *dlc;
 	const char *codec_dai_name[2];
@@ -709,6 +937,11 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 
 	priv->pdev = pdev;
 
+	pdata = of_device_get_match_data(&pdev->dev);
+	if (!pdata)
+		return -EINVAL;
+	priv->pdata = pdata;
+
 	cpu_np = of_parse_phandle(np, "audio-cpu", 0);
 	/* Give a chance to old DT bindings */
 	if (!cpu_np)
@@ -767,6 +1000,12 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (pdata->codec_init) {
+		ret = pdata->codec_init(priv);
+		if (ret)
+			goto asrc_fail;
+	}
+
 	/* Default sample rate and format, will be updated in hw_params() */
 	priv->sample_rate = 44100;
 	priv->sample_format = SNDRV_PCM_FORMAT_S16_LE;
@@ -818,131 +1057,43 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	}
 
 	/* Diversify the card configurations */
-	if (of_device_is_compatible(np, "fsl,imx-audio-cs42888")) {
-		codec_dai_name[0] = "cs42888";
-		priv->cpu_priv.sysclk_freq[TX] = priv->codec_priv[0].mclk_freq;
-		priv->cpu_priv.sysclk_freq[RX] = priv->codec_priv[0].mclk_freq;
-		priv->cpu_priv.sysclk_dir[TX] = SND_SOC_CLOCK_OUT;
-		priv->cpu_priv.sysclk_dir[RX] = SND_SOC_CLOCK_OUT;
-		priv->cpu_priv.slot_width = 32;
-		priv->dai_fmt |= SND_SOC_DAIFMT_CBC_CFC;
-		priv->constraint_channels = &cs42888_channel_constraints;
-		if (priv->codec_priv[0].mclk_freq % 12288000 == 0)
-			priv->constraint_rates  = &cs42888_rate_48k_constraints;
-		else if (priv->codec_priv[0].mclk_freq % 11289600 == 0)
-			priv->constraint_rates = &cs42888_rate_44k_constraints;
-		else
-			dev_warn(&pdev->dev, "Unknown MCLK frequency %lu, no rate constraints\n",
-				 priv->codec_priv[0].mclk_freq);
-	} else if (of_device_is_compatible(np, "fsl,imx-audio-cs427x")) {
-		codec_dai_name[0] = "cs4271-hifi";
-		priv->codec_priv[0].mclk_id = CS427x_SYSCLK_MCLK;
-		priv->dai_fmt |= SND_SOC_DAIFMT_CBP_CFP;
-	} else if (of_device_is_compatible(np, "fsl,imx-audio-sgtl5000")) {
-		codec_dai_name[0] = "sgtl5000";
-		priv->codec_priv[0].mclk_id = SGTL5000_SYSCLK;
-		priv->dai_fmt |= SND_SOC_DAIFMT_CBP_CFP;
-	} else if (of_device_is_compatible(np, "fsl,imx-audio-tlv320aic32x4")) {
-		codec_dai_name[0] = "tlv320aic32x4-hifi";
-		priv->dai_fmt |= SND_SOC_DAIFMT_CBP_CFP;
-	} else if (of_device_is_compatible(np, "fsl,imx-audio-tlv320aic31xx")) {
-		codec_dai_name[0] = "tlv320dac31xx-hifi";
-		priv->dai_fmt |= SND_SOC_DAIFMT_CBC_CFC;
-		priv->dai_link[1].playback_only = 1;
-		priv->dai_link[2].playback_only = 1;
-		priv->cpu_priv.sysclk_dir[TX] = SND_SOC_CLOCK_OUT;
-		priv->cpu_priv.sysclk_dir[RX] = SND_SOC_CLOCK_OUT;
-		priv->card.dapm_routes = audio_map_tx;
-		priv->card.num_dapm_routes = ARRAY_SIZE(audio_map_tx);
-	} else if (of_device_is_compatible(np, "fsl,imx-audio-wm8962")) {
-		codec_dai_name[0] = "wm8962";
-		priv->codec_priv[0].mclk_id = WM8962_SYSCLK_MCLK;
-		priv->codec_priv[0].fll_id = WM8962_SYSCLK_FLL;
-		priv->codec_priv[0].pll_id = WM8962_FLL;
-		priv->dai_fmt |= SND_SOC_DAIFMT_CBP_CFP;
-		/*
-		 * WM8962 has same BCLK generation limitations as WM8960.
-		 * See WM8960 section for detailed explanation.
-		 */
-		if (of_node_name_eq(cpu_np, "sai"))
-			priv->exclude_format = SNDRV_PCM_FMTBIT_S20_3LE;
-	} else if (of_device_is_compatible(np, "fsl,imx-audio-wm8960")) {
-		codec_dai_name[0] = "wm8960-hifi";
-		priv->codec_priv[0].fll_id = WM8960_SYSCLK_AUTO;
-		priv->codec_priv[0].pll_id = WM8960_SYSCLK_AUTO;
-		priv->dai_fmt |= SND_SOC_DAIFMT_CBP_CFP;
-		/*
-		 * WM8960 in master mode cannot generate exact 1.92 MHz BCLK
-		 * required for S20_3LE (48kHz × 2ch × 20bit). Closest available
-		 * is 2.048 MHz (SYSCLK/6), which causes right channel corruption.
-		 *
-		 * In SAI master mode, SAI derive BCLK from MCLK using integer
-		 * dividers only. S20_3LE requires non-integer divider ratios
-		 * with standard MCLK frequencies. For example, 48kHz stereo
-		 * needs 1.920 MHz BCLK, which requires a divider of 6.4 from
-		 * 12.288 MHz MCLK (not an integer).
-		 */
-		if (of_node_name_eq(cpu_np, "sai"))
-			priv->exclude_format = SNDRV_PCM_FMTBIT_S20_3LE;
-	} else if (of_device_is_compatible(np, "fsl,imx-audio-ac97")) {
-		codec_dai_name[0] = "ac97-hifi";
-		priv->dai_fmt = SND_SOC_DAIFMT_AC97;
-		priv->card.dapm_routes = audio_map_ac97;
-		priv->card.num_dapm_routes = ARRAY_SIZE(audio_map_ac97);
-	} else if (of_device_is_compatible(np, "fsl,imx-audio-mqs")) {
-		codec_dai_name[0] = "fsl-mqs-dai";
-		priv->dai_fmt = SND_SOC_DAIFMT_LEFT_J |
-				SND_SOC_DAIFMT_CBC_CFC |
-				SND_SOC_DAIFMT_NB_NF;
-		priv->dai_link[1].playback_only = 1;
-		priv->dai_link[2].playback_only = 1;
-		priv->card.dapm_routes = audio_map_tx;
-		priv->card.num_dapm_routes = ARRAY_SIZE(audio_map_tx);
-	} else if (of_device_is_compatible(np, "fsl,imx-audio-wm8524")) {
-		codec_dai_name[0] = "wm8524-hifi";
-		priv->dai_fmt |= SND_SOC_DAIFMT_CBC_CFC;
+	priv->cpu_priv.sysclk_dir[TX] = pdata->sysclk_dir[TX];
+	priv->cpu_priv.sysclk_dir[RX] = pdata->sysclk_dir[RX];
+	priv->cpu_priv.sysclk_ratio[TX] = pdata->sysclk_ratio[TX];
+	priv->cpu_priv.sysclk_ratio[RX] = pdata->sysclk_ratio[RX];
+	priv->cpu_priv.slot_width = pdata->slot_width;
+
+	codec_dai_name[0] = pdata->codec_dai_name;
+	priv->codec_priv[0].mclk_id = pdata->codec_mclk_id;
+	if (pdata->has_pll) {
+		priv->codec_priv[0].fll_id = pdata->codec_fll_id;
+		priv->codec_priv[0].pll_id = pdata->codec_pll_id;
+	}
+	if (pdata->codec_pll_ratio_s24)
+		priv->codec_priv[0].pll_ratio_s24 = pdata->codec_pll_ratio_s24;
+
+	if (pdata->playback_only) {
 		priv->dai_link[1].playback_only = 1;
 		priv->dai_link[2].playback_only = 1;
-		priv->cpu_priv.slot_width = 32;
-		priv->card.dapm_routes = audio_map_tx;
-		priv->card.num_dapm_routes = ARRAY_SIZE(audio_map_tx);
-		priv->cpu_priv.sysclk_dir[TX] = SND_SOC_CLOCK_OUT;
-		priv->cpu_priv.sysclk_ratio[TX] = 256;
-	} else if (of_device_is_compatible(np, "fsl,imx-audio-si476x")) {
-		codec_dai_name[0] = "si476x-codec";
-		priv->dai_fmt |= SND_SOC_DAIFMT_CBC_CFC;
-		priv->card.dapm_routes = audio_map_rx;
-		priv->card.num_dapm_routes = ARRAY_SIZE(audio_map_rx);
-	} else if (of_device_is_compatible(np, "fsl,imx-audio-wm8958")) {
-		codec_dai_name[0] = "wm8994-aif1";
-		priv->dai_fmt |= SND_SOC_DAIFMT_CBP_CFP;
-		priv->codec_priv[0].mclk_id = WM8994_FLL_SRC_MCLK1;
-		priv->codec_priv[0].fll_id = WM8994_SYSCLK_FLL1;
-		priv->codec_priv[0].pll_id = WM8994_FLL1;
-		priv->codec_priv[0].free_freq = priv->codec_priv[0].mclk_freq;
-		priv->card.dapm_routes = NULL;
-		priv->card.num_dapm_routes = 0;
-	} else if (of_device_is_compatible(np, "fsl,imx-audio-nau8822")) {
-		codec_dai_name[0] = "nau8822-hifi";
-		priv->codec_priv[0].mclk_id = NAU8822_CLK_MCLK;
-		priv->codec_priv[0].fll_id = NAU8822_CLK_PLL;
-		priv->codec_priv[0].pll_id = NAU8822_CLK_PLL;
-		priv->dai_fmt |= SND_SOC_DAIFMT_CBP_CFP;
-	} else if (of_device_is_compatible(np, "fsl,imx-audio-wm8904")) {
-		codec_dai_name[0] = "wm8904-hifi";
-		priv->codec_priv[0].mclk_id = WM8904_FLL_MCLK;
-		priv->codec_priv[0].fll_id = WM8904_CLK_FLL;
-		priv->codec_priv[0].pll_id = WM8904_FLL_MCLK;
-		priv->codec_priv[0].pll_ratio_s24 = 192;
-		priv->dai_fmt |= SND_SOC_DAIFMT_CBP_CFP;
-	} else if (of_device_is_compatible(np, "fsl,imx-audio-spdif")) {
-		ret = fsl_asoc_card_spdif_init(codec_np, cpu_np, codec_dai_name, priv);
+	}
+	if (pdata->capture_only) {
+		priv->dai_link[1].capture_only = 1;
+		priv->dai_link[2].capture_only = 1;
+	}
+
+	priv->dai_fmt = pdata->dai_fmt;
+
+	priv->card.dapm_routes = pdata->dapm_routes;
+	priv->card.num_dapm_routes = pdata->num_dapm_routes;
+
+	if (pdata->exclude_format && of_node_name_eq(cpu_np, "sai"))
+		priv->exclude_format = pdata->exclude_format;
+
+	if (pdata->probe_init) {
+		ret = pdata->probe_init(codec_np, cpu_np,
+					codec_dai_name, priv);
 		if (ret)
 			goto asrc_fail;
-	} else {
-		dev_err(&pdev->dev, "unknown Device Tree compatible\n");
-		ret = -EINVAL;
-		goto asrc_fail;
 	}
 
 	/*
@@ -1179,21 +1330,21 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id fsl_asoc_card_dt_ids[] = {
-	{ .compatible = "fsl,imx-audio-ac97", },
-	{ .compatible = "fsl,imx-audio-cs42888", },
-	{ .compatible = "fsl,imx-audio-cs427x", },
-	{ .compatible = "fsl,imx-audio-tlv320aic32x4", },
-	{ .compatible = "fsl,imx-audio-tlv320aic31xx", },
-	{ .compatible = "fsl,imx-audio-sgtl5000", },
-	{ .compatible = "fsl,imx-audio-wm8962", },
-	{ .compatible = "fsl,imx-audio-wm8960", },
-	{ .compatible = "fsl,imx-audio-mqs", },
-	{ .compatible = "fsl,imx-audio-wm8524", },
-	{ .compatible = "fsl,imx-audio-si476x", },
-	{ .compatible = "fsl,imx-audio-wm8958", },
-	{ .compatible = "fsl,imx-audio-nau8822", },
-	{ .compatible = "fsl,imx-audio-wm8904", },
-	{ .compatible = "fsl,imx-audio-spdif", },
+	{ .compatible = "fsl,imx-audio-ac97",           .data = &fsl_asoc_ac97_pdata },
+	{ .compatible = "fsl,imx-audio-cs42888",        .data = &fsl_asoc_cs42888_pdata },
+	{ .compatible = "fsl,imx-audio-cs427x",         .data = &fsl_asoc_cs427x_pdata },
+	{ .compatible = "fsl,imx-audio-tlv320aic32x4",  .data = &fsl_asoc_tlv320aic32x4_pdata },
+	{ .compatible = "fsl,imx-audio-tlv320aic31xx",  .data = &fsl_asoc_tlv320aic31xx_pdata },
+	{ .compatible = "fsl,imx-audio-sgtl5000",       .data = &fsl_asoc_sgtl5000_pdata },
+	{ .compatible = "fsl,imx-audio-wm8962",         .data = &fsl_asoc_wm8962_pdata },
+	{ .compatible = "fsl,imx-audio-wm8960",         .data = &fsl_asoc_wm8960_pdata },
+	{ .compatible = "fsl,imx-audio-mqs",            .data = &fsl_asoc_mqs_pdata },
+	{ .compatible = "fsl,imx-audio-wm8524",         .data = &fsl_asoc_wm8524_pdata },
+	{ .compatible = "fsl,imx-audio-si476x",         .data = &fsl_asoc_si476x_pdata },
+	{ .compatible = "fsl,imx-audio-wm8958",         .data = &fsl_asoc_wm8958_pdata },
+	{ .compatible = "fsl,imx-audio-nau8822",        .data = &fsl_asoc_nau8822_pdata },
+	{ .compatible = "fsl,imx-audio-wm8904",         .data = &fsl_asoc_wm8904_pdata },
+	{ .compatible = "fsl,imx-audio-spdif",          .data = &fsl_asoc_spdif_pdata },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_asoc_card_dt_ids);
-- 
2.50.1



Return-Path: <linuxppc-dev+bounces-23684-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C84C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 08:47:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvZbr1csLz2xKh;
	Tue, 07 Jul 2026 18:47:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783414040;
	cv=pass; b=egBtUcWf5lSD8SPN1pf9uQZZx8jKqVMBrjQKMurPoow/glUeTx5VxsKwrS1erMDxZsztVNmpGOMLkb+C/5I5bGLRxfupvG7IODISdF97Zat1mWxzdjTXvkQVDdhBz4npgthVsHFWV61iKgL1RgIwOwFve0l5Zlji7kGYsNnAoUQBEmLuBIqGk/FTW7vwkyPXDNs0UoSt6qO6/DeHcLMFjAZi5krfglFRZeSaOIyld7J8cmAGY28Y1c1r3dKZ0o8bnG8jG337x4JAcnEP6wZciQMDFV0nHHgcbukC/HWhcVLZVthuxrq3/hf5oevqSNWw0JZhlQ6rPsp4Cf7ATHBHnw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783414040; c=relaxed/relaxed;
	bh=3Las6btVDpUpGm1nSQdmf8dHgbehQicILpRuIQGnbOw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=L37hFkFw8JsAE4ztR+jA6a0h/ivJ0AZ/y3LXUBBaAIFFuugOZ3C6FPk933wHmVNC8pephAeAzP+QdB+CoI2pizZgxzdrMX9WpHZ5busvVX21CwXmK8x9Gw3fnYt6JI6XslZ4+tVu45O/wT9ph6raUr1MqEZtjJCkvZjrXzAqhQaPongGm0y6rwO3EiX6KP60TUCSJa7+3Kl8kN6DO970MsZmwhaSEHTd5XjKDSrUqiO9qR7zUkX/44487FEXZHeuCFrSkOMkhhgeBxruVHzxO8cnBTnXSlyCp4dFd4oedTTNpyHKLKIcm+Xgdd4BUZ60u3vroTW90H5ciGhYB41xtg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=F6tbqRWa; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=F6tbqRWa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvZbq1vxsz3btT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 18:47:19 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbHzPdMDh3/KyvRkpZ/a4sec2HS3e789M7QKoZ2WT2qRW6LI83fBpfWObXD6OYYZsmmkDvTaoViXVgRS7/6ibCpoBJAtpUsO9l7K4d8tbrjonF+IZupBNTGXbKgQSW9xJa3phKX4o0y4tbEZaXC5VElqwOx6tdotn5BtUrxWz2zjgsO2NJtqSCaeq+NxHcwf07Tv+7sFLFKjvRWVlNSJvzfOi3sIDDO4ndVUhB+VWQ2OjiCSV6ovNoeT+bD3QbdirsT8Po45m4YKcQW3NmICIdVD9zHc/EMBf7lRUnlnk5xAw4vBuz/2MKQFv6r05FO+z/KSwu/YbjaeRGyfcxwQHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Las6btVDpUpGm1nSQdmf8dHgbehQicILpRuIQGnbOw=;
 b=WoZAEDDnyCU0t+vKQDWwJiXH2y+tXSiJwrp1hsZnSZXVDGXgrRp84C5F+aQDrt1/YtWa2TVzs7um0+L4hDV3s4+PeCI6uz8X1bEXxPxc6EbhW3/S2vhhWXwTf3yWtguO1/wSfJ737jz/zAe5l+bjwW28hXiQ9wqMQBBK+pR4ODRgxLv1Eao1B+N0PycGuTwcAENukCqXF0Bk5zzT4bLPQp2cQTtFCtCXxbtRm5j42l9EYTnUp4VTCWWMF6iqfoxrysOZKso71e/LrzyVAxZq2W4LhdETdeLTHUVXaKpZDaXhb2NuYn7fr0xtGBZZMkKlhX3wnNBKqkSy9pjZSKWAmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Las6btVDpUpGm1nSQdmf8dHgbehQicILpRuIQGnbOw=;
 b=F6tbqRWafKO1czTYY/sSpoQQxacUj1aP6nfM6r3CDCLQ0vsUdtScgfAMo8pg3dmSiYVAzXJaNqSjFcdJKyB/XHzN+aLvcy9n7fzmWmgSJsDrJfPiI0c9aoXpk/nBvRW7bwuHqyyH/+4lg8yNDDkEbPY4smkOdkoQrrW15ddRrUyJhU51+DyD9410Dy36RNxwr76R85vCj0NFPC/OBkR4lm/66P466QHD01wBYDJyurvC3zwsIm57cZbssx/YYWuXM9nfarjIAO81fDvLFoxXWNfxPlpJ84NlL8bFrRiq24SKvpIkUNqFqqYX9qZz/DhXYLe76bGtDygYmNJ1sx2hDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB10021.eurprd04.prod.outlook.com
 (2603:10a6:150:112::20) by AS8PR04MB8085.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:46:56 +0000
Received: from GVXPR04MB10021.eurprd04.prod.outlook.com
 ([fe80::d247:853:3e16:1994]) by GVXPR04MB10021.eurprd04.prod.outlook.com
 ([fe80::d247:853:3e16:1994%5]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 08:46:55 +0000
From: Chancel Liu <chancel.liu@oss.nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org
Subject: [PATCH] ASoC: fsl_sai: Fix spurious BCLK on resume by clearing BYP
Date: Tue,  7 Jul 2026 17:46:48 +0900
Message-ID: <20260707084648.475743-1-chancel.liu@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0044.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:116::11) To GVXPR04MB10021.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GVXPR04MB10021:EE_|AS8PR04MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: a9932ba2-dc2a-422a-b201-08dedc044c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|1800799024|23010399003|56012099006|18002099003|5023799004|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	s86cK+iCcnwshqAjvmuMMY88UYIHd03BJXGNQS1EdQyxLvH7NMHzrx/s+aWHPfO9jxn6oW7xk96O2XSpN4ekSeVcKICeQqTRmcU4vEpKzfLTmDdaQLuEzoWpTN3YV+AVCQi3k7v9E+nMlMF4u8fHExoNzyy5oB/FC08Yu7LTBYWiWzpoLNoNiiHTC4cXMP0fzIp/2nUbue+NF8QAQjvScI83+YLcQnCguYOZTWEMo8BOg2nB5eiuHRIVdiZiexTEg26VOEK4iHcjS4PY8FGKYDwUTIMfo7VNwDAefctqll8gyBe0jnspqW2maC8AjVzdkIg3g7qECHuH/MJ0Y00RlfuufJLhyo0jEhqJKNxC83u7i4JTmGF0BLVbg9vVLMjpbPCKmaPPA3wYswS1DRYzRFwYtL+lZ+zsNAf7ySqgFleBGTvscHnN7Gln7esK9gHjfjEBB3bxvDfwjf+bLcPB7dB8WaYIagnEDi0uqaOMuseTvJkAqwJUxG5bc2ekqAbOuS7+p+D9HHjr8yghzDdphDlXKjuNnRnEQ0pQMwK5mqc9BNZgYAEsEG1c5k8oBo31R48MpkCmBIvd81Tx0QZBO/dJoyhtrZhnFHsb7LFi0McqpVjZXa+mK96QyrZd1pTeLHzXpezWZORebA4C5iR86p13gvZNPy9gSkspgBKknZE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB10021.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(1800799024)(23010399003)(56012099006)(18002099003)(5023799004)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EBVJwOYOAgifdGs/966dBVJ2cCecllYagR8L+esOfQIS2bJzaJiXAs9UklN6?=
 =?us-ascii?Q?LBw1ln53n279v1BKp+QvRI7UKeSl/StTZ6JbtUC1qz26a8VueuUtjjZ6q/Zm?=
 =?us-ascii?Q?yHZ2d6VqcmUFrmbrFbjNdm/Vc1ZJEoxBBESLzTTa+M5YZbKs6m7et9jCJP6l?=
 =?us-ascii?Q?h18m4dsn2CadBmBgCZrdz/Pugc4OBn/jmx/L9EcNwUnpPmIDQweSFMlsg4vr?=
 =?us-ascii?Q?67tpdeLPnLHk7by4lqF0is/UhMiWcxpqxaJdodTouX8JWhUOa8iq4bRMFxs1?=
 =?us-ascii?Q?CZIUTG2TNWUig3y783oyguMkNMdNJaOi4g81lv0z08ZyCT9yfNl4PRkVSoJp?=
 =?us-ascii?Q?33hWWiaRLQsMVISwhzeccmkIWemLImZ+xo+YtPtk+QL4XCwH8FadNOtPWFKu?=
 =?us-ascii?Q?MNTOjusxFWtXtn+UwBN3UqfB9SH6wAeWSwU5c5sRODyEKG1F3+l1utqHQ/pk?=
 =?us-ascii?Q?Q66GHWtxPrsAI11dtTY4tQJ4QLQJxb14bpbtJUPPm+C4nF/gA+6xgh1EUD6c?=
 =?us-ascii?Q?wIhWF99qhEHNI4YD9NvfqlHxYdBEuSioEuKxhvAHc/S+DBsT86vrTemx2Kt5?=
 =?us-ascii?Q?EoZ0IH6w1RTW5n8FQmga47eTGI0SccYgD2CU/b4p5IK0hwQck3wrpk8daOrP?=
 =?us-ascii?Q?8RbLdeopcIkiBGcPn8xcQP+MO+wkelNYS7QHYZ5S8m7SWFgc2ppedNk75ZV+?=
 =?us-ascii?Q?kW0XEOHuq/lu0GlcT134DZp2UOdsGk48uyrpc9KR3F/bs04cHuaTehzP2hOa?=
 =?us-ascii?Q?L7PHdrEjDleIEZWm8S33ktm+pOi/LNPgMsEaFippi5dMwxrL5OEuoCNazhyT?=
 =?us-ascii?Q?PmY+o+KVw2y7ftSSwU3sq8YlBq2BZNOrCnrINawXf9uO4p/7tt1S0cOWvNL0?=
 =?us-ascii?Q?+7zgwMZC1GtplKML2diSTcr4MygDKOF1c9IoFTGAA3VL0ugz3mzeOTmdJHnA?=
 =?us-ascii?Q?cnUS628JwuOCLDkVjjrUBwyAOCng6zDcKfbJRaTz49beySHsDe2eVaD9gvMd?=
 =?us-ascii?Q?KUOrNyhLB/2+5V+gSQ3E9Oqbs1bD4MOA0W3Bz3xKsv5As3ValQEWKgg5R6NX?=
 =?us-ascii?Q?C9x3OjdVU/sOC2pWp1t6AACJ04tOphAnl/PEDcFpxYw0w3MN4I3IdZOh8LyZ?=
 =?us-ascii?Q?LpnxnsLhQdCZPhZR4PZ+YO2UrjoVY6uDelgl+0DyMFcoW83QaCE8qrwFcI7t?=
 =?us-ascii?Q?kJOgzVdCtw+AlgvFEl4Z9sW8EhiXXrxB75NPHteWE23cbAm8I98B+2WYkwYA?=
 =?us-ascii?Q?7iNLRQwKqrSd4lPmpKdafN/AX6gs8Jt5+bizxULAjlcYeFfOqCyBc+Nxr5sx?=
 =?us-ascii?Q?l++2Qw+zQQXfKSAiRyeOZWP39Hc5hAlLI6zP8KjzQDGtEYh8XsQQ13NmfvSx?=
 =?us-ascii?Q?f5MDGyqfiebH0t+r4IREQAJSxD4Abg+AnUhIcCJcmW1602tt9BrW93LS/9nU?=
 =?us-ascii?Q?O+eV/59Sylj7GWExv0wrvp7WpPgFRQQHRuXChzcXZC002BEguDF85zuSr658?=
 =?us-ascii?Q?6SLgSwzB0tZ8vgN9CJaLuuJj9V85H+ct5wvgYUVt+/DPDl0/NMpKZ3YM54fi?=
 =?us-ascii?Q?CkMrd8TUSuLJUeEnDVKqpuKDqS1DP7Fy+TBuSQaMx9iZ45ubFlIfXURrJnDU?=
 =?us-ascii?Q?flQkz8VdZSoIC6ad3JBcqRaaY6hbYgwtcRlDuJSwZvbdHuutPVqehAcR4vfJ?=
 =?us-ascii?Q?ZIaN9aFa2+AaebML9S5Ztrn9XVohp9dP5PdQVweAERaVompFm7a6fPz8xu0F?=
 =?us-ascii?Q?4d5WK1h4nAVlLKxE5W4y2PpzZ+eGRHDua31pA6feFqNkG+e5oZ5T?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9932ba2-dc2a-422a-b201-08dedc044c60
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB10021.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:46:55.8230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDxWd+/qWNb6e9l55CD3TzIML6gF9wOTOL68Efj13gu6C0TDXFeQnglEyd9mhANBh5oz9sclaGYEj42Kn6/VGM6lpOeTjR1BzT4+r6sZ+QpFYF1AyGSJECHJg/3pg1Ih
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8085

From: Chancel Liu <chancel.liu@nxp.com>

When the BCLK divider ratio is 1:1, fsl_sai_set_bclk() enables bypass
mode by setting BYP, but never clears the bit. The BYP=1 value remains
in the regcache, and is restored by regcache_sync() on the next runtime
resume.

Since BYP=1 combined with BCD=1 immediately outputs the ungated MCLK
as BCLK without waiting for BCE/TE/RE to be enabled, the clock is
driven prematurely before the stream is fully configured, causing
noise on some codecs.

Fix this by clearing BYP and BCI together in fsl_sai_config_disable().
Also clear BCI, which is programmed together with the bypass case in
synchronous mode, so the cached CR2 state is clean and regcache_sync()
will not restore bypass mode prematurely on the next resume.

Fixes: a50b7926d015 ("ASoC: fsl_sai: implement 1:1 bclk:mclk ratio support")
Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 9661602b53c5..4c0626d572a5 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -847,6 +847,9 @@ static void fsl_sai_config_disable(struct fsl_sai *sai, int dir)
 	regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx, ofs),
 			   FSL_SAI_CSR_FR, FSL_SAI_CSR_FR);
 
+	regmap_update_bits(sai->regmap, FSL_SAI_xCR2(tx, ofs),
+			   FSL_SAI_CR2_BCI | FSL_SAI_CR2_BYP, 0);
+
 	/*
 	 * For sai master mode, after several open/close sai,
 	 * there will be no frame clock, and can't recover
-- 
2.50.1



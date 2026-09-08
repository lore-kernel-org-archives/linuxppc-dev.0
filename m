Return-Path: <linuxppc-dev+bounces-26763-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB780C79F82
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 08:17:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfGy36nsqz2yr9;
	Tue, 08 Sep 2026 18:17:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788855435;
	cv=pass; b=G8m8YfHuKMtv/dTckH7wLemB6JD1PGYLaBTrQ8xqpkYi37DLuJH5e/o6FqC1BGlsUMG8+jTlu3bakUEna/wZDzzTdPUq633k1Yf8xuFgxGb2eA0r4OOhmf7soSf/1bbHuxXaVS0JMRPscl9Dyim8hG2nEuzqgOHlCVWfbUjIAuQb5kumeAy2D2Bmb5Gef8VS/PmqTYnr3NUVtcId5jQvTywXReHT40P2O3g9BpxCFf7HnIAqhwXFXcYoUlVYCD3eODvXsm1htaAtKz5rTcqLyb2lXc5LULMOARdkLk0gzelt6at0qPOlde+qKen88mIxcrWyn1KDfbv+jJ6FNyBoKA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788855435; c=relaxed/relaxed;
	bh=YEboG4Zxp7AQf+aG6R684bvhk8syxXtvQNAtM3xJ18A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n0aJCE5BnrEoana6oVytW8NBHi20GehTIDfW3vYwqB8w/FivlA9aoPMnTRp32r36wDmEKpMBSkrmA191nA62A9AKEZ6dX+df8euzjc+M6ivt4K//ifJqrvymVdiGDNtRW7KweYSuGtg5lPBrUkXmZSMTfeSc4eFvLb38ZGRuKmKNrTIFpbhuRu38fi6Lhl4lSRaaFCWiB7Op7Qr0JwleamnvI+SVVCKhHPYA4TWy/4gkA0aOtjyw+tD7K1Ht//jOpnKXhx4kGqWodUaejVrVWVYjgQPsBgO5+EiyQzYaYqph5lhsc3ii01MjduTUZmTGdGU0z8GBvFTjZTJikfED1w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kR0uiBtt; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kR0uiBtt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfGy302d0z2ysW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 18:17:15 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQXlricqkNtCT9FuOl0m/cXrlSHghijsDRMiwHLohNpWE+cq/hUfdJndVzOBFRwOSNK5UHzsaaTbFm07issqBPoG0/y4ub7qV0QpeADcq5WcsbctxJrGZ55IIWwx71CJxyxjp/rlAKXpthQFpWlIY2B9qbh4wU5YHv6Xj/HSMMexZlgQVd3AmMsvhhqbdDAnIrLwz+I7cPVWPVtFgeeQ0C5HVeugVbXwyfpHAZ/3mQWROEHeJUeoi9kLmCJ3t6zGWA2Lp8E+V9xN47F9UNjt0MVNJJE9eix0FmS5QdNqVzD2Eg6S/YxoH3er2tli0wZ1XM30d8scf3vtBPIG7pS+ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEboG4Zxp7AQf+aG6R684bvhk8syxXtvQNAtM3xJ18A=;
 b=MM/v9QdF0r/rAodSHzj+vhae1uxFlg/xgcbqaSHJPuvaIVUgJSkNs2cnEeK1SiqlEeVpZirprDfL3rxJd/Fp+fogrS+zGp0GXFVep0ZAplCwXzyHY76UnwxF6mmLD6iMejJ4m67GoWvroVlP66eYidGjlZttDeelTd7Kp8MujzpLK1fVuVQCqAq2nwlOnaFBqgBolgdt1n7wPcMMtH90J7r0HnQbGdjwhnqvIlJxP3xNIJVTzKBzWbSs37Y6WTghbooG/mEV2jAXMe/UMcF9pHly8zORvFVvVCu4aL7h3vBWqlbZe9qN7sekwZvih0DsgN6Q9NxwpzUl1HHbrUelew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEboG4Zxp7AQf+aG6R684bvhk8syxXtvQNAtM3xJ18A=;
 b=kR0uiBttiQUsL/YYap2ibNzfVmVg/3Lj306KBZ0v/W7m74D+pDdvBhm4RHDjYOVZXtybZpCwPFrKqBXK/WJOM36a8Q03GzOqTnM4dHqm8SbVaw7ajFCwOMb7/LW63KJJf9ufjF5i87/dqX8l8v03PPNgsSXJEpuQbzqTwiCQ7ZfpkpV4O8eO1fap3CPGVK3YUCvYfjc4oqJ6rIRLJf4Xsuwn424PmMd4PwHGZ2iR2SqJYueWNK3GYgQO+Sjz8X/lwJTWeINOPPR+rOdrqhX4Mx+expLUC4+aq+bUShJwau+7/bOIDzF6OJWD8YbyP8fEdDzXyhnGKoB8XyivHRV1FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by VI0PR04MB754002.eurprd04.prod.outlook.com (2603:10a6:800:364::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 08:17:08 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 08:17:08 +0000
From: shengjiu.wang@oss.nxp.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	shawnguo@kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	nicoleotsuka@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linuxppc-dev@lists.ozlabs.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: [PATCH v5 3/5] ASoC: fsl_asrc/fsl_easrc: move DMA params into pair/context struct
Date: Tue,  8 Sep 2026 16:21:38 +0800
Message-Id: <20260908082140.1316872-4-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908082140.1316872-1-shengjiu.wang@oss.nxp.com>
References: <20260908082140.1316872-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0210.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::16) To PAXPR04MB9351.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::17)
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|VI0PR04MB754002:EE_
X-MS-Office365-Filtering-Correlation-Id: 84790414-979e-4b8a-1d16-08df0d819375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|366016|1800799024|376014|10067099003|6133799003|3023799007|18002099003|22082099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	LTt/mZtVa+Opsu8JjPbqu3w+mBk3B1tvXJdAX2CPDMbjBPnyIClTt5Uwu5Sxxsbd0msb0g+dAruVrPbeM5lUNfgWJRVIKek5yWRfK/xz0jCHTk0cY+NQMI19rFK+2uTEnxfV/G0dYVP8diqQCDscqMLMnCiLMGuO3fuFLdC3d4M4JzqN9GKUT6B5GYIv7U9BWsOfZrxvCXQaFT3aRDJnLaoQxPwDpmcm4A/gkR5ZmuMR+ufujS3qiewBCgXtYnWASGwTDh1VQQDomv4L2rsVDBDKG49PWEfsSvqIr1uIK1ui09XiDMSCGHIlG5WQycPFMJG8yIaTzdEl1qJAvQ8LvtyGsGL/Uw12BdjEFIxt3IE2BH5OJ9RGBqOB0xyBUm6QGy6/Ch96rG2K7Zcgvleu99wVcN1/Yh7FpFrWwS5eAeRFk1L8UUOGkeH45OwO3bPY6wlNhnsHNDOYL9m7A9mIGRhkPtr2ts5TnlnAl9YLJmRqBZAIOppEmfIWy17gHkH4HNcMolv4gt01IVWtYg3GfavdbXcKBYELlwvQqVylC8jO02tiOInE7Hvs0JPD2GVZWTcCYSxw+ILHJkc1KDqVkwIASkyPEsijg1ileA++4xi1zT9Qzz8iFCpDCIQm0JSoOtRmKmetPZREenLEuN4dDx3qE3sUkUE902Qs2p276LLKh/i+aItEqrO7p1Lw0JifEjcEkXadMS1lBCvDWMxBXw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8V+yJhyvvmnY4cZ1Uef2XR41imyqvim+66jc6/zG3uhHA6J9RmSrU9qiG6wS?=
 =?us-ascii?Q?+LKm3v8knTfyyo7KgCL3O5mfmsgmffAyHah0fDjnwg9CO4Pdx+1eEuoCIaU+?=
 =?us-ascii?Q?H6TUhip/HisiQBkRm8e9x7ptM1arhP32fN9iNcVLzTIN9CzGFAUyaH7/cuTN?=
 =?us-ascii?Q?ly179c8oWuxdSmMarlZfaI1ezAB1uatmRdNU1+1L9hefG+/QSeyx6/EpGOEo?=
 =?us-ascii?Q?9aIAwEsnldrfedPJ44TjJT8tyAPNJ/e1SRMBq9H29m6VlfiL26OpFSVfBEBF?=
 =?us-ascii?Q?fcd+JOGV3z6871SC71dINs+GwYe29tsp3+flRQt+4DYnsQYhbERExTspY0sJ?=
 =?us-ascii?Q?miot4gCjDxhJoob36TaccgnbG3v0Tr2Sqp8Sf6FDoh964YQyEuJ2cz5vg3Fv?=
 =?us-ascii?Q?R0glTPfvtcftLi4VUq/WhcufE4dmpAGme4E/pBbV/WbnYrO1yREm4GEeUsrs?=
 =?us-ascii?Q?oHtEwkBLNhBGlDf/DGDrmozL8jIolUTfmTTXWdUe9+BVfEWbLQwuUxR0lTY/?=
 =?us-ascii?Q?rvnKVOdCDefK2/kxx1e0Oe/YKrICgmTGWz9kzmEl+fPAZGCEcOzf7G3fHjui?=
 =?us-ascii?Q?F1ryuF+j/tF+cehT1i8EgscpKN/j2iP0DyMxcajjgcK7r8lWiDEPKdvxtkqF?=
 =?us-ascii?Q?RTAZFvn2Td+SAiFv9m0M5/DF3+xUG4G2j6bPCyHBTzmwsx7l1XC1xN35HtOF?=
 =?us-ascii?Q?CLXin1YRH/9/ULJU0JqPulALZWBsrCb0WEWFlXV6HAeSbwnL/+weoL76zbmb?=
 =?us-ascii?Q?qe9SLoSSpsUnLeUf7VTLD47Gz3lwX4yVL+6gXRa7bGeZuKJ1deg4GW8N2o4j?=
 =?us-ascii?Q?RQRdYfhW1mMuEan/WwK/aeBYrA4UHWh6s1bq68+XtGaUOPV2rWncn90pdLFn?=
 =?us-ascii?Q?aXdJWI/lXiB94++GxHXTr1X8V8D5IgggYufSLJ22nJSypFNv27GPwSw1y9iP?=
 =?us-ascii?Q?lh+y7EaKARbkTNIFrnU4pIv0HDAlRWcEqWBq7Y6PBMD99xT4gePQqYwXPS1w?=
 =?us-ascii?Q?Bz0gqZsMt7fN5loeZnkr3oy/iZiO7lGy3tEmUy7KjbKi0tfCZXyHm+NYL3Ee?=
 =?us-ascii?Q?bfSgnj71rvSHUvt1Jo1tBOcokYIWEZN/H4Hc62qDHwtCpk753ENdSNbFV0Bp?=
 =?us-ascii?Q?2Q+r6i5ZJtvzR+31R2tIundrMwIgllExv9qqcqhB8ICXf++FrpxinJoxyfYK?=
 =?us-ascii?Q?DhSOgHBtwrKQaW7Ti2E0TtC65rf/Q6NR3qOmRaK3uIPMiBGLdi7XANKa6q6p?=
 =?us-ascii?Q?BlQBNcI8rf+qakXbxU4esTjpNRLpDYkWRbs0TCizsrfEr8wu9QDz2gters++?=
 =?us-ascii?Q?dV+ogTVkacjz9eqeM5E5NJ/UazZVtY52mGtm9n8pm/t2fDlnypi+ypeQ7c/n?=
 =?us-ascii?Q?sGRgeKq+h3D6XsedJ4d1ZeOCMklepACBRUBHKKw9ogCqJYV4xJbXCDNNmD3X?=
 =?us-ascii?Q?NCNlDBBzKCBK8sKNupeSi4+63vh4j7Rg5ZrEXqDFNtlptSmeYZJhH+xWKBja?=
 =?us-ascii?Q?iKW8rmCa9BypOWv1V53D1SSDHVL4940HYymtBL077sn3O0mX4jY3YUb9dTfM?=
 =?us-ascii?Q?fP5ucslvKyJhxUVk0so5A5A/78IG+heUvAT1cu39fAhzSVZmjpAj1LR59V1P?=
 =?us-ascii?Q?hf3qa/j0pIZEJ1vRExWcbMW+TFGXzb/c0Epwbeawrdyn0WkYy/v+acwgrB+L?=
 =?us-ascii?Q?UHHmQC+id/lpwVXyi+0fno0CDvyNddSNcvwFNfVhuLFbPHKQpvOgpe+Hj5eu?=
 =?us-ascii?Q?w5Rs+/kYtlELV3DhYqDtmy/LWyxjdXTRrbzS+GxWgI6Pb9algAXG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84790414-979e-4b8a-1d16-08df0d819375
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 08:17:08.6982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wxskCYXDNZ5G8SRMU5PpljxdGEMge3JJhrn7kVAGAGmydty6/ZE54Egx2b7XIccPgYZo6COg1P7c6pW+QVSBETpV6Sza6F+fef82oRM9rj69xUNs1o+b80r61ZW0JdI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB754002

From: Shengjiu Wang <shengjiu.wang@nxp.com>

The shared dma_params_tx/rx fields in struct fsl_asrc were a single
instance written by every concurrent fsl_asrc_dma_hw_params() call.
With multiple DAIs registered (one per pair/context), parallel stream
open+hw_params races would corrupt addr and maxburst for all active
streams.

Fix by moving dma_params into struct fsl_asrc_pair so each pair owns
its own copy. Initialise them in fsl_asrc_dma_startup() where
the pair is allocated, which makes the per-DAI probe callbacks in
fsl_asrc.c and fsl_easrc.c redundant; remove those as well.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c        | 11 -----------
 sound/soc/fsl/fsl_asrc_common.h |  7 +++----
 sound/soc/fsl/fsl_asrc_dma.c    | 14 ++++++++++++++
 sound/soc/fsl/fsl_easrc.c       | 11 -----------
 4 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index b24737add001..d226531f1332 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -781,18 +781,7 @@ static int fsl_asrc_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
-static int fsl_asrc_dai_probe(struct snd_soc_dai *dai)
-{
-	struct fsl_asrc *asrc = snd_soc_dai_get_drvdata(dai);
-
-	snd_soc_dai_init_dma_data(dai, &asrc->dma_params_tx,
-				  &asrc->dma_params_rx);
-
-	return 0;
-}
-
 static const struct snd_soc_dai_ops fsl_asrc_dai_ops = {
-	.probe		= fsl_asrc_dai_probe,
 	.startup	= fsl_asrc_dai_startup,
 	.hw_params	= fsl_asrc_dai_hw_params,
 	.hw_free	= fsl_asrc_dai_hw_free,
diff --git a/sound/soc/fsl/fsl_asrc_common.h b/sound/soc/fsl/fsl_asrc_common.h
index c8a1a2b5915d..4e6b00cb5d63 100644
--- a/sound/soc/fsl/fsl_asrc_common.h
+++ b/sound/soc/fsl/fsl_asrc_common.h
@@ -53,6 +53,7 @@ struct fsl_asrc_m2m_cap {
  * @dma_data: private dma data
  * @pos: hardware pointer position
  * @req_dma_chan: flag to release dev_to_dev chan
+ * @dma_params: DMA parameters for transmit/receive channel
  * @private: pair private area
  * @complete: dma task complete
  * @sample_format: format of m2m
@@ -76,6 +77,8 @@ struct fsl_asrc_pair {
 	unsigned int pos;
 	bool req_dma_chan;
 
+	struct snd_dmaengine_dai_dma_data dma_params;
+
 	void *private;
 
 	/* used for m2m */
@@ -92,8 +95,6 @@ struct fsl_asrc_pair {
 /**
  * fsl_asrc: ASRC common data
  *
- * @dma_params_rx: DMA parameters for receive channel
- * @dma_params_tx: DMA parameters for transmit channel
  * @pdev: platform device pointer
  * @regmap: regmap handler
  * @paddr: physical address to the base address of registers
@@ -128,8 +129,6 @@ struct fsl_asrc_pair {
  * @private: private data structure
  */
 struct fsl_asrc {
-	struct snd_dmaengine_dai_dma_data dma_params_rx;
-	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct platform_device *pdev;
 	struct regmap *regmap;
 	unsigned long paddr;
diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index 2f662bdf14d0..15f2dccc3584 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -392,6 +392,20 @@ static int fsl_asrc_dma_startup(struct snd_soc_component *component,
 
 	runtime->private_data = pair;
 
+	/*
+	 * Point the cpu DAI dma_data at the per-pair params so that
+	 * concurrent hw_params calls on different pairs each write to
+	 * their own struct and do not race on addr/maxburst.  Use the
+	 * per-direction setters so that a concurrent open of the other
+	 * direction on the same DAI does not NULL out its pointer.
+	 */
+	if (tx)
+		snd_soc_dai_dma_data_set_playback(snd_soc_rtd_to_cpu(rtd, 0),
+						  &pair->dma_params);
+	else
+		snd_soc_dai_dma_data_set_capture(snd_soc_rtd_to_cpu(rtd, 0),
+						 &pair->dma_params);
+
 	/* Request a dummy pair, which will be released later.
 	 * Request pair function needs channel num as input, for this
 	 * dummy pair, we just request "1" channel temporarily.
diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index aced16d1228a..a6ac94055b17 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1582,18 +1582,7 @@ static int fsl_easrc_hw_free(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int fsl_easrc_dai_probe(struct snd_soc_dai *cpu_dai)
-{
-	struct fsl_asrc *easrc = dev_get_drvdata(cpu_dai->dev);
-
-	snd_soc_dai_init_dma_data(cpu_dai,
-				  &easrc->dma_params_tx,
-				  &easrc->dma_params_rx);
-	return 0;
-}
-
 static const struct snd_soc_dai_ops fsl_easrc_dai_ops = {
-	.probe		= fsl_easrc_dai_probe,
 	.startup	= fsl_easrc_startup,
 	.trigger	= fsl_easrc_trigger,
 	.hw_params	= fsl_easrc_hw_params,
-- 
2.34.1



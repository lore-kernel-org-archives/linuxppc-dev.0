Return-Path: <linuxppc-dev+bounces-24493-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6A3C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 13:37:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3hQX3KVfz309w;
	Mon, 20 Jul 2026 23:37:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784554644;
	cv=pass; b=o2PH9pqT2UNDHbCU5DhN3Bdbb9pG5XXiEUHh1ZGAbUi8I49p3cJHD4dqCzxY72C8H9RtIKSkm0yVuSI/WWpoafpxcYzHMzOBhTaUhikjip0xTm/NLMGleITPRuI2aW5RoM3YiPiMkF7J6Vc5cLlY8MQfvXLe3c2dWerpbZa87YGlN2lDBR+JpWL3sa33Gtetb1WH6ds1zU4H6YaHGpCl/DV1/RtjvvuYA+Hli3rHn7Jrf0Pp2KKEl2f//vhLtlPmZeCvO69BVE/I9oGHpCDUcy1csRglqw5XjcV2djxGZrhTxrNQaoreZOq0itVqYl0z+hlMFHQdtJgbVwjo1aMI/A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784554644; c=relaxed/relaxed;
	bh=r8C1iPY5H+aYOVLx8GmlsIz6mJWm6UNRbFpTk423AZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dmqOJhiNlOke7kSRMeCF+AaN0TRrbMvkHRX7hIdJhtSdQpLX/6WVCnxp90oUy3Zh23Sm8UKbNSdzKDZl/cOIUoh+xGGOtEaqa5DzcWhjjsTHas7Q/0t2pKUIPhbtYsPvWBYHvF1GuKKAGtOcG9Dyu/Zh6KtOr17yCzn1gBtsaap84t+OaflxBpMVytG++3QSugvsgYowAiYz0uBGAjeiklVe6J8PA3Bls0MgftqicdD2/hkv/TRMVzcLAsS05UKAEmTLzidfCTQCvDzvjoQuFGLXjFS6oNjyCx1BP6ltrFYyrsKeAFEOAFa7lLAVWRmv7dMHrtOWXnTklczGvTwA2g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ZHAbrWjL; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ZHAbrWjL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3hQW2PR9z307v
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 23:37:22 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSY0PahZy9XQwEcHNUpMo84XzEW3cU19zyRNzrmEEixbEcUobyoQeg7jlAc4e/M6fbPOkfIUd9ma2VwGnPXZMKQe2UAgXYCRDLqS3/Xt/EKTVvscANn4jARZ2BYWO33K/hatM9isOZy3RomXPH4HK5FTUrC0HbZElEUZctPjQPe2d9+dDbOm353zK5DV8ra0m6K3K1Ef+MTeESSV3cSlxf8XDjdfUMCWdtOKjI1IKiX5ynMDK2tZubcyYeKGRwP/nedrZ9kMJUL+9P4GY/1shvKZegGPKdm09l7HHdb2ctq4NrqfADJxKMKWsizJ8CpsgHNy/d+vY9cmfQOd/Y+BjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8C1iPY5H+aYOVLx8GmlsIz6mJWm6UNRbFpTk423AZ4=;
 b=GwalJBM05+EQNCaCTvk80Zzetu47r2EZM7r8vjTmia79NRMeqnapsVblPqyPFdrEMnBb1MYEd4OSjSJH/EKVS87RAP2N1JgOmzOAgY5ViY4mFBNLjAfu7gr69eGCew5uPHrqbyA3tFE+kGvf+6btrlUAWZRCbYD1hurRD7Dp54tGsgdgloUuqCcauOMz3S2xhvtsDStYbO0OOXPul3qIMyK/dr1l9oHVoeM9XoyEUycVl4C+mZPOChxWbMOFfVFvIIjT7leN+8Z/IMZFtS4NehZvZGhaw7uzyJ5ID/FTm+qr6ycBXltKVKNGRQmJAWjeHqqHkq1BmIUKYJEjfH4rDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8C1iPY5H+aYOVLx8GmlsIz6mJWm6UNRbFpTk423AZ4=;
 b=ZHAbrWjLtVGp1HsO7peKBIDKjOXXT8HwPwRwGoiNCAIEE7l+xWeYKfciRCpLis678YPqSIJAVSr5ETBnaKTEeao3QIgO+FEs7xBKLwnE4EpN1FwyWFRUCkLLCihgbPaJU8Yru53jflF51gvh2pDa0qJKXpgnFTdM7to6cNVXQt45haNK5a5JtfgNtEG0A5F2Dg0fjhrw9tKwrGDrcB/4p1IYbRpLEwkD6gGYLGA9FTV+ZQu5oEcDgW8sMAjYH0EQ7X5vus5d+60wBTewjSO7Xb6QsVDvWmfghAUckgPkL8TPYxF/kAGDAckGBHmH2ec6e6ozCUAFsYTUZxnO6muLPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by PR3PR04MB7259.eurprd04.prod.outlook.com (2603:10a6:102:8a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 13:36:59 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 13:36:59 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tanjeff Moos <tanjeff.moos@westermo.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 phy-next 4/8] soc: fsl: guts: make it easier to determine on which SoC we are running
Date: Mon, 20 Jul 2026 16:36:38 +0300
Message-Id: <20260720133642.136324-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720133642.136324-1-vladimir.oltean@nxp.com>
References: <20260720133642.136324-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0023.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::19) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|PR3PR04MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca8cb3e-db5f-4334-2811-08dee663f932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|7416014|376014|1800799024|3023799007|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	F/s8Pum1gi4ieReNMasssUTEQLrw/sikq5qC4s2J3HCnSyOUC2V4TflolXP0bRTu9+vFZBRW9JZamW4guSszp3QOzVMNVN2i2ZyAeQBmdxtueWtJWa5VIPEGXme2gvVZJKqPc8G+P1rV5/PW0Pu78wRbIHf1XsaKpAbcEk1Z+iPCeO8GpsamILTZmr58tRHcwr+yDOfh+V8EO0TmfHjcz5KA9ByTQv4Nn5NjMpyVGIIQG0SR5JswGSsuLb6R25gKHLwhYPgiB8F5x+iBmZKk6EUrSW3+9eoSBYhgeTZpRsGVsy1ymRyuAYDkrfHf9HR47Y1uSAx6tNna/uHvm5x0NKMlzMpog08PJO7xUmAf5TVOlhoYLi391YL9rkjZYeBrYd7ihWw+Hl9UdzkhzN8ohJC7358Q9EFV/Pw3j9ZOQe0F+FE1ClOJrdyddM6R+R/hrLO0EM3QNvgd1HJ/Pj3SQxYPuzoC/K5MYBVkRMj7MWgxmZoWc4IfAYcpp2mB8HViKN0VSQv6R8Uor05Zy/bQbTFnYycSPZBeufF0v1/Qzvb5drzhx4Kt4rTG7q31/D34ewRWs2Q8IfILNMw2sazeOroLR+958R/J8QnrnTkLiciZJtn1RSQPchdp1cUxJuS90S0/p7dj9vKGxstF4YiIbgA4nyz5BdwZRMnjz2JrrYA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(7416014)(376014)(1800799024)(3023799007)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kbEPiYY2YqLi8JSUZlUg3ce6NbzRqbf5WvQPO4up2ItxRnLnw1fw7YYKQBu1?=
 =?us-ascii?Q?LRcXoc3KC6j1kLcpI8GgDGMkmfib1XKN/Zkz3KKfW6fKy7tGQwnJu2omlmEJ?=
 =?us-ascii?Q?ydY9JwiPAc9Ei3HrcVorqNHCL8ytU/zL+gdRO8BDSB0kU6zMMcgpVgJr/2Ni?=
 =?us-ascii?Q?3ksR+s1t8QzMJow06UwGnUpEeMyy/F79rZ8iGRtjeBAGjBwjYYsuWTC1oOOM?=
 =?us-ascii?Q?/cFSy0I+m5gbTIOpBt/dCPQZq+DbngE0tue7+AyIoZCCYvt+Dlriv7gBdXfg?=
 =?us-ascii?Q?cVxcrQ7QqRkhx0d+F2gcCneGLtY2bxMyXwAj++e55wlwsXw0OAfhBDsFoo9v?=
 =?us-ascii?Q?RUoZqECO2vbVOEIiI6NnD41M668jM/Q9TvPF7UOmX9/fLBazZI/lyx18NVVb?=
 =?us-ascii?Q?jfVFy5o+/IAidYdi5B/bn6JIgAefp4s7WN+AvqgQypl07xKVmqLykeGzFh6m?=
 =?us-ascii?Q?ym/L5/LG5YTrywYLMTVm6jhuPTJE+HBObk7UgSP7Dz/XpIKzW2cnJZHQiuDy?=
 =?us-ascii?Q?16Wig5MxvszdqCy3kWxGj+t86lCYrSkrIyVP7heSliqXZIdNr6gg5I6ZDJPO?=
 =?us-ascii?Q?oS8bPFI2x6bcinPZaomTJx3AYxq5QMsNOluufxnk7QPkiuwMJ/lpctxI5Wpo?=
 =?us-ascii?Q?DsZofpC09u/3AgxXHHqmnvynb00+2GesQ9yVeU2PueF4KOqAab8aWEi/7y3x?=
 =?us-ascii?Q?F/Fp3E67RuHotC2IXHM/IixFtmhV08bDYmDbg/cSdn2ImOyxBOFodR5AU5r2?=
 =?us-ascii?Q?iSz3SIhCuckl6/vfs0X4+3nhN4+QTqUsHC4zVuhF4GAwJFYtYNW2WBOCfl1N?=
 =?us-ascii?Q?XOrJMslaQVIWa7yvZtQj+b6Yh58+r8FK8DZelv+quTSTqVMkQQVFBOiuQK57?=
 =?us-ascii?Q?Hdskbz2VS6KskCT68TVnmYnAzNKx8UM/IiOhnpZVgOmnN9p5hmhIKNCJa1h9?=
 =?us-ascii?Q?m19mJZ4QiiB8QaUZ18/cXU71Sf1l55VdNW1sISWJ7H3HRyW6z0Ur2j4r7298?=
 =?us-ascii?Q?K3y/db/hN7+0Nz1XFYWZ0beCralIWCy9iqGuP/LNyiyWYy0iXmrZk1QNeCGM?=
 =?us-ascii?Q?0kv8dsHwnBT765ikZGWsoHPaofJS91H0tEGAceHIsYbz5ImEqtxE5GytwCq6?=
 =?us-ascii?Q?ru6sCgEtvcl0h3ybqEWRlsXvmpVSjNOvXc4lY1c+XrpuWPJQvAqxSKGmgvVt?=
 =?us-ascii?Q?dUzvou1F9usBQgw7D2VdotqL1tcZCcmfYMTBru55Ta12fEoiy21keBtYyNAK?=
 =?us-ascii?Q?ZdACBDZ20BcHqDgtLdAXnV0xhryRviLGAAddvnZ1cMdHd4pLNKiUVgqSjJBg?=
 =?us-ascii?Q?Ke7tkWaVCKzEF29YlKjigDlxXsKDEw3DIuoGtW8+p/LSIrN/7yBPG0FjYruK?=
 =?us-ascii?Q?YZOSmfLFoVrZpic9febtGxHyKNQV+ugS+/Fab3QDqk9x6eZGDgahPVOoYxz+?=
 =?us-ascii?Q?ZG1mfcg1zHgfAxUjcpEZNP1l/HroCpxWLdKBIN3Kc6/1lKbCRfuAUoE+hOpB?=
 =?us-ascii?Q?qBWQ5yMxGTBDc1cxL0HFC8XgVqSAPIVHVVxM7o85RSjW/ub3zsBWOqqDlQCG?=
 =?us-ascii?Q?ATEsE2pn/B32HWwSbrS5F2au3Bwew49tejsQ7aiqrXNtACgEhbWdAv9e0whi?=
 =?us-ascii?Q?KGgMnTKhwL+15VQ9j+Oci6Pw6VXSfm3B+S9XohLkqCotCF3idVopPKuRdh5y?=
 =?us-ascii?Q?ylBR4dIJuahQVllHQfTSzYalfhpObGZiOQZHVxvEJ/wwT6ntRY6WltFCU9MX?=
 =?us-ascii?Q?1UjdrfVEdw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca8cb3e-db5f-4334-2811-08dee663f932
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 13:36:59.1373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3iSb/LmKzSjL9sZAKZxl856slKJpA8ae/mf8pkTB0KAWCsjG06nEoXMfwQoLHFn60H9D02FAXWevVrpSIA3qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7259

From: Ioana Ciornei <ioana.ciornei@nxp.com>

The guts driver will need to easily determine on which SoC it's running
when it will need to perform RCW override at runtime. The guts driver
knows this already because fsl_guts_init() reads the QorIQ/Layerscape
architectural System Version Register (SVR), but it doesn't save this
for later lookups.

Add a new qoriq_die enum to be used as an index in the fsl_soc_die
array. A new fsl_soc_die_match_one() function is also added so that we
can directly determine if the SVR is a match with a specific die.
The SVR value read from the DCFG CCSR is also kept in the global soc
structure so that it can be accessed when needed.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v3: none
---
 drivers/soc/fsl/guts.c | 47 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index e1b3a054e681..922560d98782 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -27,6 +27,23 @@ struct fsl_soc_data {
 	u32 uid_offset;
 };
 
+enum qoriq_die {
+	DIE_T4240,
+	DIE_T1040,
+	DIE_T2080,
+	DIE_T1024,
+	DIE_LS1043A,
+	DIE_LS2080A,
+	DIE_LS1088A,
+	DIE_LS1012A,
+	DIE_LS1046A,
+	DIE_LS2088A,
+	DIE_LS1021A,
+	DIE_LX2160A,
+	DIE_LS1028A,
+	DIE_MAX,
+};
+
 /* SoC die attribute definition for QorIQ platform */
 static const struct fsl_soc_die_attr fsl_soc_die[] = {
 	/*
@@ -34,21 +51,25 @@ static const struct fsl_soc_die_attr fsl_soc_die[] = {
 	 */
 
 	/* Die: T4240, SoC: T4240/T4160/T4080 */
+	[DIE_T4240] =
 	{ .die		= "T4240",
 	  .svr		= 0x82400000,
 	  .mask		= 0xfff00000,
 	},
 	/* Die: T1040, SoC: T1040/T1020/T1042/T1022 */
+	[DIE_T1040] =
 	{ .die		= "T1040",
 	  .svr		= 0x85200000,
 	  .mask		= 0xfff00000,
 	},
 	/* Die: T2080, SoC: T2080/T2081 */
+	[DIE_T2080] =
 	{ .die		= "T2080",
 	  .svr		= 0x85300000,
 	  .mask		= 0xfff00000,
 	},
 	/* Die: T1024, SoC: T1024/T1014/T1023/T1013 */
+	[DIE_T1024] =
 	{ .die		= "T1024",
 	  .svr		= 0x85400000,
 	  .mask		= 0xfff00000,
@@ -59,46 +80,55 @@ static const struct fsl_soc_die_attr fsl_soc_die[] = {
 	 */
 
 	/* Die: LS1043A, SoC: LS1043A/LS1023A */
+	[DIE_LS1043A] =
 	{ .die		= "LS1043A",
 	  .svr		= 0x87920000,
 	  .mask		= 0xffff0000,
 	},
 	/* Die: LS2080A, SoC: LS2080A/LS2040A/LS2085A */
+	[DIE_LS2080A] =
 	{ .die		= "LS2080A",
 	  .svr		= 0x87010000,
 	  .mask		= 0xff3f0000,
 	},
 	/* Die: LS1088A, SoC: LS1088A/LS1048A/LS1084A/LS1044A */
+	[DIE_LS1088A] =
 	{ .die		= "LS1088A",
 	  .svr		= 0x87030000,
 	  .mask		= 0xff3f0000,
 	},
 	/* Die: LS1012A, SoC: LS1012A */
+	[DIE_LS1012A] =
 	{ .die		= "LS1012A",
 	  .svr		= 0x87040000,
 	  .mask		= 0xffff0000,
 	},
 	/* Die: LS1046A, SoC: LS1046A/LS1026A */
+	[DIE_LS1046A] =
 	{ .die		= "LS1046A",
 	  .svr		= 0x87070000,
 	  .mask		= 0xffff0000,
 	},
 	/* Die: LS2088A, SoC: LS2088A/LS2048A/LS2084A/LS2044A */
+	[DIE_LS2088A] =
 	{ .die		= "LS2088A",
 	  .svr		= 0x87090000,
 	  .mask		= 0xff3f0000,
 	},
 	/* Die: LS1021A, SoC: LS1021A/LS1020A/LS1022A */
+	[DIE_LS1021A] =
 	{ .die		= "LS1021A",
 	  .svr		= 0x87000000,
 	  .mask		= 0xfff70000,
 	},
 	/* Die: LX2160A, SoC: LX2160A/LX2120A/LX2080A */
+	[DIE_LX2160A] =
 	{ .die          = "LX2160A",
 	  .svr          = 0x87360000,
 	  .mask         = 0xff3f0000,
 	},
 	/* Die: LS1028A, SoC: LS1028A */
+	[DIE_LS1028A] =
 	{ .die          = "LS1028A",
 	  .svr          = 0x870b0000,
 	  .mask         = 0xff3f0000,
@@ -109,6 +139,7 @@ static const struct fsl_soc_die_attr fsl_soc_die[] = {
 static struct fsl_soc_guts {
 	struct ccsr_guts __iomem *dcfg_ccsr;
 	bool little_endian;
+	u32 svr;
 } soc;
 
 static unsigned int fsl_guts_read(const void __iomem *reg)
@@ -119,11 +150,16 @@ static unsigned int fsl_guts_read(const void __iomem *reg)
 	return ioread32be(reg);
 }
 
+static bool fsl_soc_die_match_one(u32 svr, const struct fsl_soc_die_attr *match)
+{
+	return match->svr == (svr & match->mask);
+}
+
 static const struct fsl_soc_die_attr *fsl_soc_die_match(
 	u32 svr, const struct fsl_soc_die_attr *matches)
 {
 	while (matches->svr) {
-		if (matches->svr == (svr & matches->mask))
+		if (fsl_soc_die_match_one(svr, matches))
 			return matches;
 		matches++;
 	}
@@ -202,7 +238,6 @@ static int __init fsl_guts_init(void)
 	const struct of_device_id *match;
 	struct device_node *np;
 	u64 soc_uid = 0;
-	u32 svr;
 	int ret;
 
 	np = of_find_matching_node_and_match(NULL, fsl_guts_of_match, &match);
@@ -217,7 +252,7 @@ static int __init fsl_guts_init(void)
 	}
 
 	soc.little_endian = of_property_read_bool(np, "little-endian");
-	svr = fsl_guts_read(&soc.dcfg_ccsr->svr);
+	soc.svr = fsl_guts_read(&soc.dcfg_ccsr->svr);
 	of_node_put(np);
 
 	/* Register soc device */
@@ -229,7 +264,7 @@ static int __init fsl_guts_init(void)
 	if (ret)
 		of_machine_read_compatible(&soc_dev_attr->machine, 0);
 
-	soc_die = fsl_soc_die_match(svr, fsl_soc_die);
+	soc_die = fsl_soc_die_match(soc.svr, fsl_soc_die);
 	if (soc_die) {
 		soc_dev_attr->family = kasprintf(GFP_KERNEL, "QorIQ %s",
 						 soc_die->die);
@@ -239,12 +274,12 @@ static int __init fsl_guts_init(void)
 	if (!soc_dev_attr->family)
 		goto err_nomem;
 
-	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "svr:0x%08x", svr);
+	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "svr:0x%08x", soc.svr);
 	if (!soc_dev_attr->soc_id)
 		goto err_nomem;
 
 	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%d.%d",
-					   (svr >>  4) & 0xf, svr & 0xf);
+					   (soc.svr >>  4) & 0xf, soc.svr & 0xf);
 	if (!soc_dev_attr->revision)
 		goto err_nomem;
 
-- 
2.34.1



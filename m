Return-Path: <linuxppc-dev+bounces-28376-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D42C98328
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 06:13:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htWG13R14z30Vd;
	Mon, 28 Sep 2026 16:13:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790576009;
	cv=pass; b=olvEbiwE3fm+rGqhMuZnNb8Mhuohxh1Lv6XrdHeuIdTGFA7pTJzGB26QFXt0OUShx/RtNrlHxv+ycVh9iPFfFfbCBVsv0q1MJR2EQmcOo3KOdnLKAcksusunqFHkHt7Gw7yfpr3TG32Te/RK+uNJio4XRdyir2vsxoWMfqcEoLEsiZDMkTjW2Kbm1MX+GToYU15EQuWXL6Mbe3L1Mr7/n1DJNmvw24r9nwGk/iMZ8wq0dKnRLaLzs+E64iFkJUEfaVbvDR+JosfA10lKg4XeR5SwKPUrjGqYoBLFVmldjFTXAn9GCn0B1ZEOCpblaOPHckKCL02fwumstlG6j3R9aQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790576009; c=relaxed/relaxed;
	bh=XFepkEKPMPiaIv2WvOYN+xxGutMPFJj2Qkk3QhSLJ7o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fFwja210DAtLyVHoqx0/n7d4cpHBYzufvCrg6+NFm/3ptywierhiWJkB9hsSTOlx9TGIYp/ImOeXaoT4oFrCrqw3tCOBOclHsKKJM2c4L11f8eWgM/atASHQcek7U1PNmC4fX3lMnV6ebHhX/VHupkt6Hb3nRveJHPiPzwXFYTQuhcSYZY6i3cSfJEZ0TgjHyGVPlhW4GqJCi22AMNSqfoLyEXaEvdgbti0kzaTqIo1yaz9C2TX+8dJyFXBS/epzbMKHGChsqsdgOcztkjvSl8gQuUq48f99CNoL+7YvCbX99g1HZMA9gAtJWWPDbrIXalU9cNoMAFNpSfppvtcVxQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=uSMTnp2H; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=uSMTnp2H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htWG02qxPz30W9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 16:13:28 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c75hZuDYzbxlRbGWAPIIa93xFOQ+sccy4Zw37u4i3dpdDhVUThMm2QsCsqpGZKFSwKt06+WC7AdIbKhpjoNTPwL1R8KjB6e4fTiXlxOO1Gr4ww8fsUark8USH0UId7roZp18+vjNLGkzBeXgb+MJNSk+MZOQDoYk+vJMakv5FIZy3CzgOSvsscMTcogbatLpD+cngWGw8EcGe8i4mHoAdB9UvbD/7RzmVx2GNblbVNz2Y1m2PxkjRo0CDF3qS2L748znhYrJoeH8smhD2rRzYfeky69arPRBlldgRdsKRc2Kbfc4xiQ+MseV2jcZFJh7ULSyKw35XTPSEqQEz72YkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFepkEKPMPiaIv2WvOYN+xxGutMPFJj2Qkk3QhSLJ7o=;
 b=SxLCTd+0ilhLsNDA7G145WbbDO8iMtL1e5yc2ajZovz9/bpZwgkPDGkr5LNFwka95C3vuI3if29f/WyfOWS+CXVxesHjgii2WULF0jMaI31mSp0xfDTX05eu28i6l7gmdYZRFotLt7AXIjTxis3AWwelvy6M/5Fo2jtdR5KKsjyYx0sB+zKd4GRqTujv0LdRBrft80QB+7y6rimeAOGWM04s60eXEU0XNV/ezIINH/Zo+KY20RhTMq2pdAtt391VstNN8ynJuxSFbVVCHS8OCglYgdWQoHHPQFIp42cMD8zZsVsbumd3UMf91nSEVJfmo0k3qY7Eo6PW1VjDmIvdjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFepkEKPMPiaIv2WvOYN+xxGutMPFJj2Qkk3QhSLJ7o=;
 b=uSMTnp2HTpoHMoh99sgRwJhp0gpp1GsEwoIzRjNhnhRe71JiuJTH7QI4cZfrFC/oe9wC5YXZg6hjWD8AXF/OMTLZf15eOpXFEJIk30s86/uudXQIXj7gcyXtUJyyHEopOrsCm1qgf+hCn/RSf0ERbxY9k+3wcoItkBLBogC0QdLlTmbxxmqLFWsumi6hiHQQNAqKu1NLqs8AA3JXb5XWsdjhU7L8R9f4t6F0K7HgvfVMxX+WtsvE3L2LCnQvJSdq0iPuNL8ONOSQy5pCMsjPcsXHkpp1nnwnLsF/oCIJ3XgfrU0mHxHiCzzIYMf2IenbF7SqMUH7BnJ1mM2799e9tQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by PA1PR04MB10721.eurprd04.prod.outlook.com (2603:10a6:102:489::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 06:13:22 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 06:13:21 +0000
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
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>,
	Chancel Liu <chancel.liu@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v6 5/5] ASoC: fsl_easrc: expose individual DAIs per conversion path
Date: Mon, 28 Sep 2026 14:17:56 +0800
Message-Id: <20260928061756.1844185-1-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::10) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|PA1PR04MB10721:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f6b7060-ef53-44d1-47ea-08df1d2798b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|23010399003|921020|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	a9+2FvGyDOLZihCt+sj1iD9xovDaKHr7zwE1J1QXy9dBcTxjWXsqg50hSL0FGu+C0PdJOzHxjxGJ/yeOKEmdeTNf2ApKqWtom4bc6vyc1PnPyB8J1mbAA/SYPmYuuco2kZRz+tVPdRrMy7UW0/iVOoeKDtRtemFUEWdH70TtllqiiPfTtIRoLrCZfAdwYNt1lj/qj5i9xLX0+jCWdTeSjvSN1TPcTWHDlOM1Jf+yRdD3gOtMU8IsGL5pMkyCebzr2JDLYLpInH1WBHoE4Q9bM0VXcXbePiH0wGg7aAUtNS4oR5SwPkMMO837HZmnxlxNv5/doMthHxeFf1YjAiUdGDF9iM7zqTK3Wj6/uh+Rmj/aRbp2SXTULTp5HQIU4/gwUZ/Jtp35vNrdxBNkH9NJAicPxXzg5gZYYphMHF2N+grRYleTLqUy8pUbKnKh3JbidlazHEe5cM8ox7oYRfWmgMUwh649lQoVpp9omAFQhb9nGV2Wd2RgRUaLZ8UiyHSapLsbrUREAH0DT18mhsQcQXAWvWn/mfZ6DCCzR0d9tN4HtieHZkTFJQyAJeOZmcEDyJNxhSQvl6VQS0A5ZGpmJRnXXCQLX8Z/EdLdvptxsT7uzD/R60Fwnp7HpjOWXk6qSQHqR2L0nRF+41EQX5WSb05Zd/Rp5PerVD7522kzeEP/Vfqke+di8MrU3jviFtmg36oHcYjhWd5kRBXlNKVGjw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(23010399003)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S/77vvvWWI+h2zk1PGFRpOf1GzORdL+FoWZKh2RKUoh6dVq90hTW0Ic1TnME?=
 =?us-ascii?Q?jPZk5sKqs8Opm2Q2BlXJHlFFHuC1499aghZPV7LoLvL21vCL+L5HTa57S6WO?=
 =?us-ascii?Q?LGLrK/mEZOZCJHvWolG1z635VgkKINh5BTcFdU1VCxdiXWRCH0FbSdLeyAM6?=
 =?us-ascii?Q?kxNIrsrz0QXREK4AOAFjRmZ6eH3PCFQIN7ATTutLxtsHRLqU+KVuKoc9X2Dl?=
 =?us-ascii?Q?B5eizfYf5ZVIVrTIq9MDKWWZvQ5tRa2V//MtkaXrYxzeEy2ogy5fUlXWlMsN?=
 =?us-ascii?Q?ALXLksRv4xn0Plv1CyRZXTAWGquLUEOnUGN2szfHUYVKP7rt3gqTSiIO78Xx?=
 =?us-ascii?Q?m+QuwF4+jojnE3pyr8V8fYKRKfkwe7QGZSmOIKB/SvOLg/25y14oJ20AZVv6?=
 =?us-ascii?Q?sFDhxDIwylGy8HXhGjluT/xgj+XWf9+KV3Ua/gXyQ0/ApKTvHBNLmE/lJi0O?=
 =?us-ascii?Q?ObC4wAZYZMyd/OEVeg/mapyz0zECNAatWopeg5vBPIghk3k/HjP3RqvqsX6e?=
 =?us-ascii?Q?EbTU5sFBr7t8Rb6JSr6CO+is70Vy32ejnGUGwv4Bt06uheK7v95sUAUc8J6Z?=
 =?us-ascii?Q?SK0ByVusYQM4Zu0OjHO3eFX1ZcHFOo6ZFPzYghgRSZu0PRr5DEh7J+pTg27A?=
 =?us-ascii?Q?6MyrhFXHu1/8LKEQPgab9EpuIM7zAjRE5L40MDpjminhBBTbAw2z6jFN2Vro?=
 =?us-ascii?Q?mwm/CURwUvUaA59dQ7v7bCshCjjITuo4+B+zNcSZwcVApbFNi8F2UK/x+3Cm?=
 =?us-ascii?Q?CpU8ZWhrxgDWqXFmCa0gLM96PxOl56biaJqHEiNZ1/HJqKko63lxYhgyjn0K?=
 =?us-ascii?Q?LCFvp2o11phas1QkRfEi53w9L3rQCilx8KTskAm6YkMPt+khnDXouUtGPhe/?=
 =?us-ascii?Q?4+8lw4iA9DSr8dPu++RBwUgRt1kt1EBOoFkgwe8iidjIsD78TwEENX6uuj6M?=
 =?us-ascii?Q?rYuGzV//C1EVb2YX159iAjajF3CvZmH3ZL1lFePUXR8+yttzaW8EyOutv7RA?=
 =?us-ascii?Q?YPyK9wCsAM21GU2g0xbA21wL23g7daO+fJRESMcyWJWNfZmmD4diR7VUHOhx?=
 =?us-ascii?Q?G5XzNmXlPFWjG+R9pAK95Jt8PqHFXai3u33k+xLxbITJrHFCxnus+YZJTLpu?=
 =?us-ascii?Q?gLuiNSX0vT4uQ5cMNW51ujWwTU76XYLSw5J7XsSiKZi0QdSUBY6Gu66lvpOa?=
 =?us-ascii?Q?EB0Ac6olihOEHjZsBx6RbDP2s6A1iIf2/lFUgG2wYT+xsOkU/0PJx84x83UY?=
 =?us-ascii?Q?AFlH6TzI701YySCV2RHAVXoab07FSVNZZZPnsHyygvCGdURwTr0aHnxARD8V?=
 =?us-ascii?Q?D+Y/OIAQAXprpr+qC6GmuPHy1yfmoZTVIxp7sH2LKY8gXHH2D5ve8YZJ8YKT?=
 =?us-ascii?Q?+XgmjSs2fcQQlXTLy9qbfB6Q8CC4EC5+6R0gAg35FvnQbMNsmVpFv47E6il8?=
 =?us-ascii?Q?Pxq1y4bgasY2h/limbOYR2Qq59bwrBWu/XQdqhDDXsAdxYyRQnUrsJ5560r2?=
 =?us-ascii?Q?nk1gF/8gXHOwPVx/HkTuU2mly+jPO+hC1aBxRsuNec4vSRmwuVshGFhLhQ4r?=
 =?us-ascii?Q?9Sp50nfwuFEBfmUh4fEsb8FqjUpyZ4G4gqKvKOj/munBYw9AGiwkdEX7k5qS?=
 =?us-ascii?Q?/iBnk5kF/V9xPPUZS7yd/AHRvd85GESqbC06MmKo+FYRaURWqNNh4EPQWPIB?=
 =?us-ascii?Q?kgEs6e3kCheYeOXiPmRtmLfrzbguUNI7p95gxPbobzURgUVjJxk3dWpsBvoL?=
 =?us-ascii?Q?EtKyhJnwErXXxn8JZFd9dyaBdZ4ld48aZ9tmPeJXTBG9JLCXMW9w?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6b7060-ef53-44d1-47ea-08df1d2798b9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 06:13:21.7350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qqI6xTAXyoKcCKvLi3Lk5yCgBP3JZZtNdStLZu/iQkdfCKfbP/KMFbPdnBrQlalKaxPLH9FjQhVPnA/cpzlBhIDN5/fTxjyZnFjX8m0HJmp30awihBYh1e2H9KiAYM55
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10721

From: Shengjiu Wang <shengjiu.wang@nxp.com>

The i.MX EASRC hardware supports four independent conversion contexts
(A, B, C, D). The driver previously registered a single DAI with generic
stream names "ASRC-Playback" and "ASRC-Capture", which prevents
multiple independent conversion paths from being used simultaneously.

Replace the single fsl_easrc_dai instance with an array of four DAI
drivers to allow up to four independent conversion paths to be active
at the same time:

  easrc-0 -- ASRC-Playback / ASRC-Capture (backward compatible)
  easrc-1 -- ASRC1-Playback / ASRC1-Capture
  easrc-2 -- ASRC2-Playback / ASRC2-Capture
  easrc-3 -- ASRC3-Playback / ASRC3-Capture

easrc-0 retains the original generic stream names to preserve backward
compatibility with existing machine drivers and board configurations.
Each DAI retains the same channel, rate and format capabilities as the
original, including IEC958 subframe support on the capture side. Update
the devm_snd_soc_register_component() call to register all four DAIs.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Chancel Liu <chancel.liu@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/fsl/fsl_easrc.c | 112 +++++++++++++++++++++++++++++++-------
 1 file changed, 92 insertions(+), 20 deletions(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 4401c4e100b3..5d715bc07357 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1589,27 +1589,99 @@ static const struct snd_soc_dai_ops fsl_easrc_dai_ops = {
 	.hw_free	= fsl_easrc_hw_free,
 };
 
-static struct snd_soc_dai_driver fsl_easrc_dai = {
-	.playback = {
-		.stream_name = "ASRC-Playback",
-		.channels_min = 1,
-		.channels_max = 32,
-		.rate_min = 8000,
-		.rate_max = 768000,
-		.rates = SNDRV_PCM_RATE_KNOT,
-		.formats = FSL_EASRC_FORMATS,
+static struct snd_soc_dai_driver fsl_easrc_dai[] = {
+	{
+		.name = "easrc-0",
+		.playback = {
+			.stream_name = "ASRC-Playback",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS,
+		},
+		.capture = {
+			.stream_name = "ASRC-Capture",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE,
+		},
+		.ops = &fsl_easrc_dai_ops,
 	},
-	.capture = {
-		.stream_name = "ASRC-Capture",
-		.channels_min = 1,
-		.channels_max = 32,
-		.rate_min = 8000,
-		.rate_max = 768000,
-		.rates = SNDRV_PCM_RATE_KNOT,
-		.formats = FSL_EASRC_FORMATS |
-			   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE,
+	{
+		.name = "easrc-1",
+		.playback = {
+			.stream_name = "ASRC1-Playback",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS,
+		},
+		.capture = {
+			.stream_name = "ASRC1-Capture",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE,
+		},
+		.ops = &fsl_easrc_dai_ops,
+	},
+	{
+		.name = "easrc-2",
+		.playback = {
+			.stream_name = "ASRC2-Playback",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS,
+		},
+		.capture = {
+			.stream_name = "ASRC2-Capture",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE,
+		},
+		.ops = &fsl_easrc_dai_ops,
+	},
+	{
+		.name = "easrc-3",
+		.playback = {
+			.stream_name = "ASRC3-Playback",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS,
+		},
+		.capture = {
+			.stream_name = "ASRC3-Capture",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE,
+		},
+		.ops = &fsl_easrc_dai_ops,
 	},
-	.ops = &fsl_easrc_dai_ops,
 };
 
 static const struct snd_soc_component_driver fsl_easrc_component = {
@@ -2234,7 +2306,7 @@ static int fsl_easrc_probe(struct platform_device *pdev)
 	regcache_cache_only(easrc->regmap, true);
 
 	ret = devm_snd_soc_register_component(dev, &fsl_easrc_component,
-					      &fsl_easrc_dai, 1);
+					      fsl_easrc_dai, ARRAY_SIZE(fsl_easrc_dai));
 	if (ret) {
 		dev_err(dev, "failed to register ASoC DAI\n");
 		goto err_pm_disable;
-- 
2.34.1



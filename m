Return-Path: <linuxppc-dev+bounces-24626-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF487C4452D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 23:17:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4YDm4CCHz2yvT;
	Wed, 22 Jul 2026 09:16:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784675816;
	cv=pass; b=ffEi7ML8dR+1M2JfhYfKKhzG0DXs05DN6ko1bYeMrxsMPLCXF290UHke2bBxC9Ow6l1qJJeQteksgObQGezT69qR8tot3ZaI1Oz4AleQGzoNvs8K544cpQWizY6adjEtFb4TJ+Jr7jiIgiAJqsvHTJDopHb+3aXxFoQTHIVhXMt80tjo1RH05V1ZrBemNVQDs3Pzb7Jj6XjCcYMQWzUPFdBUcmi7uxzM46ueF7q4ZmHw9aIOnhLdD8UhWgzeW+KO334XoDArvFiFymJj+nFIqs9OkLd+s+3AuMpyhjqW/QMiGPCICPdGi610gu6GRUl7aY22gqljhd6s5KKiOhKnhA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784675816; c=relaxed/relaxed;
	bh=tkO96bpp4Fik/CoANpI5arj9Vn7TGtDhXpFGdR+H+k8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UYfdfJHLk+MgoCoJnJtT6kJ4g2BSFkghh3U9aw4YCgjeXI5cNkEn8Z5KnKO5oFcTUPixfD/e7yCqrCcIM/oUfMtnpUDMRwsDiREEuG9xVmPYsHq3QxW3JLeSnuvpu1Aypax1keRNjNQ9O9gfZTiFDgUn4dRQi/GP0/XgQGwGKhEY8qEGRZVLBmAGy2OU7WnkP6M3DbZNkJgNHz8AiS1P5V5I5aBUkKUSltUcZhAVJx39MKRaKuMiQGjXNuihXcJLX8Z+DOBSPwo6ZuoH9LKJtcrqtx2F3I2P+M6uzAg4AVKIQ3wLhG+ZNWFcIsKBVxWa2G8bxtz/t5ByphMJM/MqlQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Wa0DZdNY; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Wa0DZdNY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4YDk4pJkz2yth
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 09:16:54 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Us+24GC928WdNCXUD4SvHet17DEQQJFa4bP/TsDFZV7wB/Crvu7OWq3fqrqYZRLrfuhGlLM70/dXTkfCoOLLtv2I62l8PeTjjmlKj4bwlNCwfJlIzYpqFZ0EwLAFlX52HtriQAG6vkgQxJaaa78KCczGehdxQjFnerDoyoCuGOsIzJAhFQwzR48wpPXwrovHfm5fMdNZJM9DOBlRl6E06CxUQqDQfVnOWC1NBWHgcLuEQV/dEBa4O/XVMoHv8LdPqJci4XcH/GDN736FpBbpTFE9LrtzW2oJYUO46Iyrte+5nXEOYi0nIsS73qMLVCqnpoTt4zwS7wZbvYJCPyOqHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkO96bpp4Fik/CoANpI5arj9Vn7TGtDhXpFGdR+H+k8=;
 b=NCeWx662uSwVDG1Br4sfAdep7gCWOxKKr7gOG3SDaqKxru4+tmW9lq/00dPDYk6PvXs6AhR/lQ2cd0Ob9kv/b+T5DR8xZw0e3fxRPscPhhls+K0CUeVLb3i8aMeYWpWnzE+uhTLJKE8g8scNaXQSjfuEQfGVYCtY1gvVndRYRyrPHRwY5jmLWUx3x0033h4jubNAuXpex+W4aZP2TG//NIuUPaIDfmfbHOMfk2OJ3jQ2xurfuaIq3Fc2Emox/NbKYoIo3RwvSiK7itP/dAUC/MMeqDA7knuJSqAUfTbi6GJazWBYdMxjpIQyrfcqKjDAam8dHcnT9gUmB08lLJw+cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkO96bpp4Fik/CoANpI5arj9Vn7TGtDhXpFGdR+H+k8=;
 b=Wa0DZdNYvOWZrWCRffiuaNvApS6yPBLvM6SEpWZUbhcoS+bolPX5TwdDpieGvXPnN5T+cM4gh+JzHjm0W9OofmkzbqgR0V6F+RT7ECXhaAnc3/ZS0TVZUxZqQT0m3FGb1pbRBMdEDRVAK4WZjAlLmvhp10MWwxsdxEakN9/6eermV83krnNyrbSAeT67ZOBPR0S6d30Aa8mqwbKqCegZh5US+rFpnE3/HiGP+PLja68amJ7do8lhfpMB/ox0kBRQiIrCBA+r8xLFyFXxrFgbd50XwmW2EPP1MukDp4XB7dhuMSb2BYj55muVOG3wzQ3094GsvQrpbIoMcyR33+WBEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by VI0PR04MB11817.eurprd04.prod.outlook.com (2603:10a6:800:2ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 23:16:29 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 23:16:28 +0000
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
Subject: [PATCH v4 phy-next 9/9] phy: lynx-10g: use RCW override procedure for dynamic protocol change
Date: Wed, 22 Jul 2026 02:16:03 +0300
Message-Id: <20260721231603.67865-10-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721231603.67865-1-vladimir.oltean@nxp.com>
References: <20260721231603.67865-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0111.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::8) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|VI0PR04MB11817:EE_
X-MS-Office365-Filtering-Correlation-Id: edc8883a-5920-4d3b-2331-08dee77e1807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|19092799006|1800799024|366016|6133799003|11063799006|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	TLRUI6u2a8z4OtQdZb+2gM4rCFE0gKIbbvaXOYWRhVVCQpiEhwnnCIGPMoJE6eWemdijfpB3t4oZjQO4l5D+qD7QM6KfaMUCxxOR/uQGbqLNZVywDa4rYrNNrDNv4fOB4PNWqc2wCuxg1WCjwHTpWiDT7EB2HZGzpjmt6luqDOr/Aelw2deSjA1vkbB/Rwczr1hcNsZX0l3PDsWUxJdE7GoJ0MyzaBQZugIDuMGBaLsA5XF7hy+ADFAKLbr9sQzT21aqMqM3dbDhJ3q/i5ERXhQRCq/9KPscC+stI6sZT314tY6RUzb2i0sSYIU6k+XHkcRhQPemuoqWM+QDjvROGMjC8wiSedGmw3NM+Cx3wFPSrAggLmJ322Jb02AKGz548YtsDWrTB3SykS1fAIFb5xIv+utWFUpOB37dCwcAOhaZDnvu19JysgICTi6qmDRDY0oyQKy4Wh004jGJbnHVe4Lfs72r1jit4J7iAlXq1D8vHWMhYe0VNi5TKJMequT3hRE6GFyT6WJeptN+jIt+n3EYlC1XnHPBOQ5YHDSg9Lgk+lcKCy43W2PBvTr9hy6vmf5CGFQsuQsiELlzG7TzxQ+3f0bzVN9+FxNkSkWVwBuord4eDpf9oEWG4w+Qz7aNYvhp1wgQC+Td3D3lkhzO69kYU/DC7fars6kPo6kZ86k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(19092799006)(1800799024)(366016)(6133799003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BH/YldC4ChvA2qJwOTGfTTb4dLYUuUmiGjF6qfl2JATSD5+WpgjbDNtbiBtD?=
 =?us-ascii?Q?x4Bb/W5hHcAjzp+M/pzvsUEfVcCm/hvmDnFVrFuc6R/Bzu+i4gpQLJs3BtKL?=
 =?us-ascii?Q?9U3O0o1gH4yktr9DDIPQrPgXlhmDxViYXSuoYPYBPQEb2EjeOTq9wwMP4mOS?=
 =?us-ascii?Q?gi6m6kxEWfvjXldYfhomIQoHcYGIbAG1oPOYeGndmJkf/JkTDqXohfX31I98?=
 =?us-ascii?Q?qNoSKyWP3wtzUmc1nK6jSF+L0ZE4b3c6wocKQ69TIyW03Pi5+psQ3OwLTBK7?=
 =?us-ascii?Q?OJS80kTsyuQkcQUaU4ndWY6zR+3iR0X+MLblHFM2xuuPFlC9rXwrLf/Q+1EW?=
 =?us-ascii?Q?YjJM4W7hOsnVHg/FGm35UIdVCxzA622xcYf/oUo533zTa3RXmhBTOE2F6spz?=
 =?us-ascii?Q?qw9adBzLlu1yGtG1x/z7Vg6CGAZ0SrE/7cDTXCMDaMUVqh89WMoD8hIv31YU?=
 =?us-ascii?Q?3iRAdGh3LSv25bhE7hpLx0yNygOOiOfCc48SS1qj7GEqq9uP/eQHBY6LCGtg?=
 =?us-ascii?Q?/YqdC1ikwemc9EZ25PaCn/dWdYDXbSTF2yrqujsuXUEWiI9K3QOA+c6g+zH0?=
 =?us-ascii?Q?Dzw4iBivZ/9l7ZuRv3qaSPq+nWrUzLByQbezcYyveKtd5w2SVI1IBmGEF0NQ?=
 =?us-ascii?Q?J3W0LH//eJ0t/D996VhVwK4YcW/G2NtIZZ5SMPPo3evhUPj4xfkWqbMjh74h?=
 =?us-ascii?Q?Cj2A9DE6oAs075Id+cwrIx6zWjG7LN9mddcTE+WuAl7JPKBDc9ckPrzy8gv6?=
 =?us-ascii?Q?+jXy5QthA2NwMS1qBXbw8qCbfEaReEQ+pLOKbNNP+1qHcD7kbKvjFPkVRstQ?=
 =?us-ascii?Q?Sgv2Rr0zRrvl13sn1tbG/o9APMuSXF5OrMGpgJYLuQD93SdlFsb3yK4aACCA?=
 =?us-ascii?Q?1vITyHN5dPx0cIifcm/lHqJ1fpPeDCmH1TzMCoTl/Jh679J/yhWmYQkXDsxT?=
 =?us-ascii?Q?Q0wola1e884MHK4+vhLJYVqjWtvJokPTMSSp9pOJXbk3HgGu4KFyH3myz9/5?=
 =?us-ascii?Q?0oPIP1jF5RNFR4tCR4jCmyiYIYceWte/+TbkGOAuSY5ir98wyPeC4OMyYhR0?=
 =?us-ascii?Q?rjbNamxCyH4otY8PuLx6P8XRamo8O4l13dwMaZtDiLp4bHuUR3qr46hTnx8c?=
 =?us-ascii?Q?XytIXLL08J7By00Te07ElEmA0DLYSqZtYdt37wUC7HA3gPEY/FYwqrsoR6I4?=
 =?us-ascii?Q?TD675j/NzyKWCYHkaEMeAqIwXjyIkAigEIeur6bpstK7ewCHPvwpbFxbI/nt?=
 =?us-ascii?Q?r/DHKBLuTnJ2LhhdkzW4OCRsFQ9N5/bYxrUpKrFSi+yZ4m3SV5haYWE3EsVi?=
 =?us-ascii?Q?Y67HIofYzYp6875z/yHiwVHRk3KxOaLjo0M43PvA9liYmzdlKtwVxjvoOjks?=
 =?us-ascii?Q?F2sOlEF8o7mU7KE/3Fp57ldpfB5az4RDUsjkxlz2uzRn/juDDn7L4hJC8ll4?=
 =?us-ascii?Q?dbkA6NjSvKPcTFfkNofiNwjJYzFxKQBCZPiZK1c7qy59f1TyK9TFOASmfLgz?=
 =?us-ascii?Q?zPQFMv587aaunNQqqFVyAPTEGTk7reeULra6vry+yryD03p9joUY256LMfFB?=
 =?us-ascii?Q?zeBZ7nTMqJclOnvb52FvW/bPAl9ZtB3yvnNLWcIQiwn/JAGDNwT+5MneAVOc?=
 =?us-ascii?Q?5jF1v2SGqGnTN7XddsuZ0slZjZMt0uUpnZpJRHfYu1lTsy38fIokHQwKjIMm?=
 =?us-ascii?Q?Wbn+0smwRlaroP4nq3hnEpoVP3eNs3c0lzIGJWmR2lp6YGF6Av3e3b/AO2Db?=
 =?us-ascii?Q?MpoRK75Pbw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc8883a-5920-4d3b-2331-08dee77e1807
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 23:16:28.9077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fF1AQNwwD1Fex3v3QPQxq3hwjnthGpN8RF2tIujEnOzg69IDcTzEjFWN40MGuABouzO1Z1xPJ177v/NVKAs1JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11817

Up until this patch, the only protocol change supported was between
1000Base-X/SGMII and 2500Base-X. The others require an RCW override
procedure which was lacking.

Since now the guts driver provides the means of applying this procedure,
make use of it and remove any comment which mentioned the limitation.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v3->v4:
- drop the lynx_10g_lane_read_configuration() -> fsl_guts_lane_init()
  call. The guts driver now uses a self-contained procedure to figure
  out initial SerDes protocols by decoding RCWSR29 on LS2088A, rather
  than relying on the SerDes driver to tell it.
v1->v3: none
---
 drivers/phy/freescale/Kconfig            |  1 +
 drivers/phy/freescale/phy-fsl-lynx-10g.c | 23 ++++++++++++++---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kconfig
index 5bf3864fbe64..d4e189fffbf8 100644
--- a/drivers/phy/freescale/Kconfig
+++ b/drivers/phy/freescale/Kconfig
@@ -58,6 +58,7 @@ config PHY_FSL_LYNX_10G
 	tristate "Freescale Layerscape Lynx 10G SerDes PHY support"
 	depends on OF
 	depends on ARCH_LAYERSCAPE || COMPILE_TEST
+	select FSL_GUTS
 	select GENERIC_PHY
 	select PHY_FSL_LYNX_CORE
 	help
diff --git a/drivers/phy/freescale/phy-fsl-lynx-10g.c b/drivers/phy/freescale/phy-fsl-lynx-10g.c
index 38def160ef1a..60c85d08c33e 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-10g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-10g.c
@@ -8,6 +8,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/workqueue.h>
+#include <linux/fsl/guts.h>
 
 #include "phy-fsl-lynx-core.h"
 
@@ -1167,14 +1168,7 @@ static bool lynx_10g_lane_mode_needs_rcw_override(struct lynx_lane *lane,
 
 	/* Major protocol changes, which involve changing the PCS connection to
 	 * the GMII MAC with the one to the XGMII MAC, require an RCW override
-	 * procedure to reconfigure an internal mux, as documented here:
-	 * https://lore.kernel.org/linux-phy/20230810102631.bvozjer3t67r67iy@skbuf/
-	 * This is SoC-specific, and not yet implemented in drivers/soc/fsl/guts.c.
-	 *
-	 * So the supported set of protocols depends on the initial lane mode.
-	 *
-	 * Minor protocol changes (SGMII <-> 1000Base-X <-> 2500Base-X or
-	 * 10GBase-R <-> USXGMII) are supported.
+	 * procedure to reconfigure an internal mux.
 	 */
 	if ((lynx_lane_mode_uses_gmii_mac(curr) &&
 	     lynx_lane_mode_uses_xgmii_mac(new)) ||
@@ -1189,6 +1183,7 @@ static int lynx_10g_validate(struct phy *phy, enum phy_mode mode, int submode,
 			     union phy_configure_opts *opts)
 {
 	struct lynx_lane *lane = phy_get_drvdata(phy);
+	struct lynx_priv *priv = lane->priv;
 	enum lynx_lane_mode lane_mode;
 	int err;
 
@@ -1197,7 +1192,8 @@ static int lynx_10g_validate(struct phy *phy, enum phy_mode mode, int submode,
 		return err;
 
 	if (lynx_10g_lane_mode_needs_rcw_override(lane, lane_mode))
-		return -EINVAL;
+		return fsl_guts_lane_validate(priv->info->index, lane->id,
+					      lane_mode);
 
 	return 0;
 }
@@ -1205,6 +1201,7 @@ static int lynx_10g_validate(struct phy *phy, enum phy_mode mode, int submode,
 static int lynx_10g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 {
 	struct lynx_lane *lane = phy_get_drvdata(phy);
+	struct lynx_priv *priv = lane->priv;
 	bool powered_up = lane->powered_up;
 	enum lynx_lane_mode lane_mode;
 	int err;
@@ -1225,6 +1222,13 @@ static int lynx_10g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	if (powered_up)
 		lynx_10g_lane_halt(phy);
 
+	if (lynx_10g_lane_mode_needs_rcw_override(lane, lane_mode)) {
+		err = fsl_guts_lane_set_mode(priv->info->index, lane->id,
+					     lane_mode);
+		if (err)
+			goto out;
+	}
+
 	err = lynx_10g_lane_disable_pcvt(lane, lane->mode);
 	if (err)
 		goto out;
@@ -1314,6 +1318,7 @@ static struct platform_driver lynx_10g_driver = {
 };
 module_platform_driver(lynx_10g_driver);
 
+MODULE_IMPORT_NS("FSL_GUTS");
 MODULE_IMPORT_NS("PHY_FSL_LYNX");
 MODULE_AUTHOR("Ioana Ciornei <ioana.ciornei@nxp.com>");
 MODULE_AUTHOR("Vladimir Oltean <vladimir.oltean@nxp.com>");
-- 
2.34.1



Return-Path: <linuxppc-dev+bounces-22595-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D163ACD98D8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 21:10:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcXFv40Jzz3c4C;
	Sat, 13 Jun 2026 07:09:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781298579;
	cv=pass; b=TedtaYsrWCpKnD/NHlto+bCQtUOiWO/bho4BrxcqkAdkge15UEX94LxTmbUtB3riP5qcqzLKcLlS9CN/zKfpOF3FT33+i7r+ztLNFfSK1wRko/6XcqKEvAks0uuoQutoXyBSmm5+REMqgj+TW0oi5i00ykRfMmikTAKiHyLO0pznStdOtf/UgBSBlRSaYZrXOTIgJJMFh3q+lQ4GlEdmWTL3CiHuvAbQOZKBYlYabf6XpA8OdvjXE3sDUcPdTKMpUCQqxop4jUNbv4x+sJCcD1mNRa9TMJajBPWHRLmOZXTpN87X891sKxk8gFXcQZLylqnPJpQY5mRjB2m7DWAQZg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781298579; c=relaxed/relaxed;
	bh=1V3H4HOP4olVSLNmNNj1Bo3P0QoS4BcVhh0MpV47574=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W+d9Qo5IgFoDW5WdTXHRO5AykXnYOq8ys0rn23lbow5sVFZ8YmmRVRxd9ewlKGIqG5YzPgdBOu4WK6DVdTegZGVsvv7sJbnxIJW8FpBwQaC0ptk6Jsl+N1VsNMHStW4xG3HLjbwxjAOCt+82k3CAOaGecyw0zSddbBB/SwQt8PEvuvDlBLn5LUdXhO6OOnD8XOQxgWsFn3IzM5xKC3Rr9263EiOWtI2R1iPQZ+Ch6UV8A1cU73FPQ/GewakjXZHibvNRibYzXf0CbPbuWYvkLqptKDs/Lz7iMH/1jn7nOueqJLRscn/P09/au7C/kb/pIG+ng4D1w5jSLUtna+F6pA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Sa01DgZV; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Sa01DgZV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcXFs6x1pz3c2V
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 07:09:37 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+LLM0gIbUbCN7Z92GWehsMheMkR0Yn9ZQqnLVvq9gtYMtxnjs4265tDVfgcrD32RWsICw2mpHGE7adbmCvJDG0QSR7hymphsqSBZOsVbeQESVazLbyc6kXrozhpeJ6174ahFUzuOf8WtNmUtp2MaAYx62eyXWrh+OeqMHWmnTmDCMK8oXNUmkEOA2eG+Cs7sSv/V0muOfqDLCDyplZYdSweAWvoLI0kfQrYXmmOwmuq5rhLJ1Shjq1iJJS2Zbxh7ZxYYNhM0I1Ivagi4MdZQzd0bSRh0S/GS2g1TVjD2QvhbQgisx3oLiZBUJFYoT1KNKdM3HA5KspsCg5oAZNQPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1V3H4HOP4olVSLNmNNj1Bo3P0QoS4BcVhh0MpV47574=;
 b=Awa1t75+7QxNIn81v4rSCdvPHqJEO+EdJhstHS5d0ZfBDLByM6BUpOINHimIq2Jfv09ZgyVTqZpkYyw+q/WcJG5sT4KrouGolnsIDJIDCIC2Ceoy3v2NY1gG4lLDWiXdOQiQR7qq6AZNOFCiufpMEX5hXJULVaU8TsC2C+LbTGhLaAuIl3aMIy+9tZG1mJ9Bs7qkxg0kfpWH2WkeOAD2G8nQwCCXxJN6TTloikHsmVuLvUBOx7UYCvDPuo0yUPbR4/TCoUJW4AdXv+ZzzYRyJwU07aDtn0Mc7lx90QWbbLediVI9vM8KkYXkAleSh+K8lYGueIHCp38zXdEoeS400A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1V3H4HOP4olVSLNmNNj1Bo3P0QoS4BcVhh0MpV47574=;
 b=Sa01DgZVoflapgKa3FLdYHGyaT4TvCsNwVpUv02ZuotlBY2W45pfnspMJ+/DEsm3RVRFBCDTO3fgpmJslmhXv7UcyQEcMW3/xLn5OCdg1sFiDP2geRiLchgBHNWVW87g/hec94s1TO7Di47ZKobruqwog02eU0lUqSqAirS49cTQKjyNHAi6pnleN0w3fNBNaFSLivH4F1S8tW6PciN5ptTjwfXeHCXH6U4g5GXGDZO9+TyIHuS98MBh9Y+2Z1dTtMpHxwhLcGjuvEAyLudpH0wYy1ugscF8VveGgTo2Po61UUZMhDFU3Q9UamyUAoTKCOosCrx3iWfCAJa3+1JH6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by GVXPR04MB10969.eurprd04.prod.outlook.com (2603:10a6:150:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 21:09:21 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0113.011; Fri, 12 Jun 2026
 21:09:21 +0000
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
Subject: [PATCH v2 phy-next 8/8] phy: lynx-10g: use RCW override procedure for dynamic protocol change
Date: Sat, 13 Jun 2026 00:08:59 +0300
Message-Id: <20260612210859.266759-9-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612210859.266759-1-vladimir.oltean@nxp.com>
References: <20260612210859.266759-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0037.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::8) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|GVXPR04MB10969:EE_
X-MS-Office365-Filtering-Correlation-Id: a5960621-f636-47b2-77dc-08dec8c6df92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|10070799003|1800799024|366016|7416014|376014|56012099006|3023799007|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hYmu3ijo4fjVYxtGFUfImybmYThLfqZw3IzdLp1u0NIjYDdp0qMnpLFoPcW+IlSJxDzLtASdq5hjmkKOEoMtl81Ih6SPEPULTWnNpFk8zW88tWPrxSJNSBw4rv49vdj5LE6gyBhkMObNOst9tOI91lkL0dEo7hQOASJ4BlIeXsSWLwUYR4WBEIrFibWDfMMmy0QqzZVDMqjHpXfJo1yF3wVXKHSwp+MYEhNhB0H6EgkVmuBTuUguGzYzJ0DcUZONnZhgjau9tP0ZTyCCL9JIWx7xXyi9+q25uQ45YVbT/+BYqCtqt+ZFF0r1XRGXSMavz/odti64L1GJJ2g58mFjoqWrTM1PIeIrVmoduW+kL4HG2F7AXwsaRGLxNrouk30Yz7HL3A1Io/LHWq7Rn0ZBUXzywXj1qK33lGtfwvKSvEtPggq+4zy+4pouVo1VKJ7gTwdsy4ZcwMtTqbCU/UC6KP1L58WgezQzOLltt0nfrRVXHPqkX+WDiSDywsmWTm5OsNBi3UocBtif0wO/+eHE9EksJbKpmGdI0ha4yr2VBO4PtMshBE3voDEA5HnIA2i0bWRdH6AuYbR8EFmJ4HJLxZ3w2qMWDgv5QGMAiCkWpS8IUgPqLD2N/Rq/Q3trejYQw1utBI6bRkR8/TclfWCgCcxJMRPwAJVGvcxjTHLxXmtkEoA3C1za4cXU/rIap8FQ+XFiHcXaw2J+/lxmu2hDqQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(10070799003)(1800799024)(366016)(7416014)(376014)(56012099006)(3023799007)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LZf5yKEjkbSpoE2e1IJeahniBsnlg3HMysuYY6CRl9GCtXBT/L7ynojHdg27?=
 =?us-ascii?Q?8xTUJmZIL45cXmi12nDqgA7kH907kQ2YH/BLI+Tbok7nPhyEk95mktSGlrU7?=
 =?us-ascii?Q?HGyHeJqWs6uPeh62hzujLOYmJ+dSzE1odQb2rnK/Yg2G2Epdah4/2rcYjfoF?=
 =?us-ascii?Q?htpKr+FQnrd3TgHyKy0Be4o9L2Cb4pJjxWeqshm3AysEix0Wzy+OFTD5Fbgj?=
 =?us-ascii?Q?W+65a4o5JgulaQboW8y0ErpM83WrGJ3lWvZkFg2cWr1ZmbldKNP7DLqVkBqE?=
 =?us-ascii?Q?jWY2yqPXpR/4997wx6qsU9TFXnIjAhVt/O9+VoVvUyGNS9NfGcwjh5EECwgb?=
 =?us-ascii?Q?zWpUx0I20y8zutAH9mcL9pGyoJamMhSgeTVAGNgcFgjURVitSflzWpvOgvMI?=
 =?us-ascii?Q?L8kQ6Gv4mnAYseHqGFySZ96xEP4onpgRNcdpHU265m6y76ARQB17szz9H5HU?=
 =?us-ascii?Q?PJVjHP9VrUiLlWV5RxOx8WjSbD4prn4WObvYN7jeXN83okIpDUZ8R1rPZOW7?=
 =?us-ascii?Q?bf4UXOx0YMqTOGdIC1xDDrFlQHMEA5oB1ZRIXYPrPhTrTgz9SGfCrhTfalqw?=
 =?us-ascii?Q?oSVdv7CmnzHWjuXebFwG4daT1+rWUOFZ+1jbuyckTlOEcUx/M/sh8Qi1Fxan?=
 =?us-ascii?Q?sqs5O2hJ4W9I0z31f7cHOhPdaBAqDMn+gbPXiQSwAWii8XPpQaxkXqhiDElc?=
 =?us-ascii?Q?vxw+o+yg5wMHNW9ZZRxXFrnD6J+ulIE5XcRXhXglYTUu9TzeEYKagLlLnDGF?=
 =?us-ascii?Q?mWuOIsayeE4fd3f1sI5pGjksrgSLKpNiGZtwPU8RfQSNI4SAXHUySexHGDON?=
 =?us-ascii?Q?KjODWKErqaLUuJBJPrhSlmlIlQMP+wRb6BsWq3pQmhlD5I1wiI5K5Xj6ZNaE?=
 =?us-ascii?Q?r7ltscu0DR/vz39dqyVsGjf5KyehHZ88XSLPZ7beuZtMLjBSovJ/p5onnfer?=
 =?us-ascii?Q?4ar1pGnQ8jpx8YwhMVJjX2XzWLx1GzX/Jycrjot1qGjRq5dKnoKAy+YP1KD7?=
 =?us-ascii?Q?sodMgztHQXMQX7gf8TCZtCbby6wcJWfz2xutL7Tsn3KYhY5nHMHEtXQkb5AF?=
 =?us-ascii?Q?mntx1hReLVcOF3K3Ys+bttLNhhWKjiA91yf2wklxYF/3Mn7mr9IYUDHR7Gui?=
 =?us-ascii?Q?JSSKab5TTUr3lCMEvlPzVFnu8S3DuGJbVaWwRLx0lsMGe1Tw+KM3xf+0WKbd?=
 =?us-ascii?Q?4ZoS5louptaps1yz55eZPLcqX6ZgjxsrJ+49gPczeUPyrFekaQwt43KOAbjS?=
 =?us-ascii?Q?AUvULnmYAv/h2KJ0oemNHDbMQp1IK60J892JJqLQbCbLfWHB59SGo+g7FEtd?=
 =?us-ascii?Q?50F+LHnBxzaWZhrLR8AvOd9YnmoXijgxDcZc4N+P2OT/D7geW6CjxU6t8n97?=
 =?us-ascii?Q?Cz3KpSSsLuF0kWDoTC+dRTf14j5DIJemA5glfekfQ+UuKDG4tl0zCkrweklL?=
 =?us-ascii?Q?6WgPnSA/rzKpC7CG2uQZn6X1K3sLfk5YVZ+W6o146ePSHqQOoe9WnN6hLJQP?=
 =?us-ascii?Q?JW+fDMDTO5nMiAXxd5Q3uO2Yy3GKowcwUdM1Ilp++je2gsCKOiCLjrKfDRAC?=
 =?us-ascii?Q?4TA3ewKRIm7qLCpYr5gDEdpfgSVYyRmyjTJRjri0aYhKlUoKwCwWPs56lDBC?=
 =?us-ascii?Q?poYgIQDxG3+oYSL6q5bw4+gf74wVJKAWM3dpQ24Nyyroh28meoPiJM+AbfU7?=
 =?us-ascii?Q?ncfBApZrC2u5/bISlFse1uhaUQvSya0HaOhMRv7G+Ze7PFU8j3D7oDG/4KOO?=
 =?us-ascii?Q?T0pe6s8N4QjPX5MLb7OiCIBPgl/YyrPtBKkUT/x5EV7tG/v8mOSW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5960621-f636-47b2-77dc-08dec8c6df92
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 21:09:21.4813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4qjtZ7MfHcMN8a+3JBvHS7P344yGFX2YRIk5IJEQwfAa1/IWhwempHC72k2wWm2vt4v2F0wL/Tq0kG8hFAQ/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10969

Up until this patch, the only protocol change supported was between
1000Base-X/SGMII and 2500Base-X. The others require an RCW override
procedure which was lacking.

Since now the guts driver provides the means of applying this procedure,
make use of it and remove any comment which mentioned the limitation.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: none
---
 drivers/phy/freescale/Kconfig            |  1 +
 drivers/phy/freescale/phy-fsl-lynx-10g.c | 24 +++++++++++++++---------
 2 files changed, 16 insertions(+), 9 deletions(-)

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
index 38def160ef1a..5ece7889aed7 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-10g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-10g.c
@@ -8,6 +8,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/workqueue.h>
+#include <linux/fsl/guts.h>
 
 #include "phy-fsl-lynx-core.h"
 
@@ -446,6 +447,7 @@ static void lynx_10g_lane_read_configuration(struct lynx_lane *lane)
 	}
 
 	lynx_10g_backup_pccr_val(lane);
+	fsl_guts_lane_init(priv->info->index, lane->id, lane->mode);
 }
 
 static int ls1028a_get_pccr(enum lynx_lane_mode lane_mode, int lane,
@@ -1167,14 +1169,7 @@ static bool lynx_10g_lane_mode_needs_rcw_override(struct lynx_lane *lane,
 
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
@@ -1189,6 +1184,7 @@ static int lynx_10g_validate(struct phy *phy, enum phy_mode mode, int submode,
 			     union phy_configure_opts *opts)
 {
 	struct lynx_lane *lane = phy_get_drvdata(phy);
+	struct lynx_priv *priv = lane->priv;
 	enum lynx_lane_mode lane_mode;
 	int err;
 
@@ -1197,7 +1193,8 @@ static int lynx_10g_validate(struct phy *phy, enum phy_mode mode, int submode,
 		return err;
 
 	if (lynx_10g_lane_mode_needs_rcw_override(lane, lane_mode))
-		return -EINVAL;
+		return fsl_guts_lane_validate(priv->info->index, lane->id,
+					      lane_mode);
 
 	return 0;
 }
@@ -1205,6 +1202,7 @@ static int lynx_10g_validate(struct phy *phy, enum phy_mode mode, int submode,
 static int lynx_10g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 {
 	struct lynx_lane *lane = phy_get_drvdata(phy);
+	struct lynx_priv *priv = lane->priv;
 	bool powered_up = lane->powered_up;
 	enum lynx_lane_mode lane_mode;
 	int err;
@@ -1225,6 +1223,13 @@ static int lynx_10g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
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
@@ -1314,6 +1319,7 @@ static struct platform_driver lynx_10g_driver = {
 };
 module_platform_driver(lynx_10g_driver);
 
+MODULE_IMPORT_NS("FSL_GUTS");
 MODULE_IMPORT_NS("PHY_FSL_LYNX");
 MODULE_AUTHOR("Ioana Ciornei <ioana.ciornei@nxp.com>");
 MODULE_AUTHOR("Vladimir Oltean <vladimir.oltean@nxp.com>");
-- 
2.34.1



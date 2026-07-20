Return-Path: <linuxppc-dev+bounces-24497-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2669C4452A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 13:38:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3hQf5tZZz3c00;
	Mon, 20 Jul 2026 23:37:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784554650;
	cv=pass; b=FY6laUBd702lAd8Dk95E/tDTXHnojQllhxqoVr29mPwit281XL08nNmtXQve2IN939zS3g38htHYdsx9lVI6SB8JE5/53bGEYej7iaqTLUtoD65/QGGW2y3sAmhMBPqJ7qEaktveL/K4r0A27f6BnQfi3B8825JaC6evztdmgkpStFeLIKln60jXnMBcMTdReqIzR1kMEMC4d36sq4bXqv/HD7p7srIc8/KseiFEUQoJ9uju235NYYDJurKf9m967/N3gvmTI+OCYHAYVhjQx3kkzo73ajU+U2RmzytpeYNVPStBfuqr1aPyuo3SyBVkSQNle0YumfeLdQrkgmnrbA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784554650; c=relaxed/relaxed;
	bh=czgduSDav/edvxpU/ItYxUu9iycZCPfau5aOpO5fZ2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HjnNRU4hyVBxbIDPPPGVUiO70WRN5y7Nk+MjA8kpUfp415GRYWu4gj6GrnAin24yiGjp867gV1u/DzfUcsGhy2JQ9ICtT2gARf5oaEyGHH9Z++w87RpB7lqjqt3qeuUb+Ydm6jSeMhP5uk6hQ4vKlh6cAtWhLnWGuRO4KbxhLP7WFNcJEzRXnnYOjyfLq+lJEfhVbWX4DLA6cbV8Qugss22+5nzZrrR/FiHR1Ng1mX9l7AXV0Xv84ZTRRJynRywz4SMZKofJopYiS8o/vqJTPKePXz4797vxtlFKtEIMcM/YpD+7YhdPnp7HUC/ArrCQrwrQnVxfWFqSLRPvHr7O4w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=PL5ma+2x; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=PL5ma+2x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3hQd4S4Bz3bxM
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 23:37:29 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9R/aWo49LawSMx6yqWcrsLkCmOVlVrjQtkhHkqBPpnCGZ2zoXfSufPJA84KQHC/rq9kIOQObgKnlAdRH96XHw2QzV9C37bVzYmfYBQdypEWSMUgA+UIhYodurkkSeOHdpdaopsRMjVjAMIbvRexfEQdKw43Y0lam1yL7r7SKAxvB8GgMc6ngnT4J+5u/WhvQl5nf9zMqA2o/d6hPlHiw8XSuzBnzxNA0J/TbjlE6drulcANBdUTsx/6A55/o+3k3hRK1qGyJMjRyGPCeF9BrRFz3iIxIvGBL+WMstTkt6VrgLbsY0wdIlsbUz/6wJN2mAKHkftGaN1OQtwy2u4yvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czgduSDav/edvxpU/ItYxUu9iycZCPfau5aOpO5fZ2Q=;
 b=ivcgFOfWrncaYDOggJr6kZvM4Wcfs2cVJPHP9SykHQC3+Cq9l+ANwlWRHHMVmwJcyITPn2/MvJcAsVbO3+kgpV0aSHxx7t13gOGGOXbdciP5TsVkrskfTQ28qHyEEeZgfXj+rEl/+rwiRNN0nswNIbtBng6gDcZRu1J4rR11NWPRWPpuynZgixGmgJ4MpMgK4ro0YnLLrYcTeUWI+yF+mAFeOk8M9mrnVVHagyG9zFIBnHWbChDHMUNmaS7FqlifVt/Efqzuy8ZcDOzYN8mjy0rPzPmNuUMV12143RsDUkUIZSut1pUO/OYPo9nC/xNiEp4DksYy5KufZjQPUiSvZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czgduSDav/edvxpU/ItYxUu9iycZCPfau5aOpO5fZ2Q=;
 b=PL5ma+2xPjwJAtbQz7eXn9aL/p7QJLGO5lfDsxkqZn750rx4N9CRcLwv+3NM1Ai8m4ZZdTMMbB5/tZwWVjPMS7gVPc4I9VcC0KnLIMzKlJkgOqGVHUlUwQ4Ks32RcEttWDuwxXA+4JXVQzWL8E8HEgB17mXV02auKQBp65jOO29IUwcLXBmZY4OLQBhIXM0mqTE7EdckZsUdkLt5oebFNZckH6OtG4owwa8PLDWClRZLNacMj15eSpJstlRZ0VEuePsZdA7TOHuoo/MkfVLQZopJKo47UgJCLUEne0FgWW/86hIcEbEqyF0E//ksRQvqzhNgJfVQBSdZf2UEneAZvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by PR3PR04MB7259.eurprd04.prod.outlook.com (2603:10a6:102:8a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 13:37:07 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 13:37:07 +0000
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
Subject: [PATCH v3 phy-next 8/8] phy: lynx-10g: use RCW override procedure for dynamic protocol change
Date: Mon, 20 Jul 2026 16:36:42 +0300
Message-Id: <20260720133642.136324-9-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720133642.136324-1-vladimir.oltean@nxp.com>
References: <20260720133642.136324-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::13) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 4c92c420-f528-463d-2085-08dee663fe38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|7416014|376014|1800799024|3023799007|56012099006|11063799006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tvpzQS18WyIkk2NR5EmxGMQ4Qt1w5+sQrGQzV+Dh14xPLkCDFGeEFynqspWWEQnRNV3we/FQSfDmZ/NT6U0g8TD5n0S8pEMjpqgrBv9QS7Zk7j49DjYf3JjfC/tpalBppoG1u9qEmEEInXE28F0qZ8yQEKNnOwqBQwugJNj9PSRvVWnwPJNwAe31UGnNUyJpMsQOux9wFqkNLujqn/19n+OKjV3cVjgPuZZOGRitLz6zMvdVEvC1PPXvSnDMwED0HnAsobt+m5gdxK7tu3EQWgx7yApRDfL5hsN/7M6ElmEw8XRPdKRLKWnT2kSocj+AoAz1vnkbXXFasmp0AmaYKTBXMlkOog2LwwjroPQMmiqI5fLY5P2Y4dk2SS8ixTxdSOcVOfIHNAcNALWXilozQ2ZCnhNbcjhlVdjEoU6DRIGzh1DmjBik2wXfWHV4LWgq6p0N2cPIgkGwPVBsW0TgDIi9AKp2UsI34Dq6RpYArGeoOLaGqgMwk2xIX2YqY1KnPgxh3V8/glwn8GQM2Uw6obTeP40FOXQU5riEpqAR1qY1ccB2a2JQWw32esvpxT18tV1roFPfjk+17nk8F97zmKu5kJgnyaFhQ5mYA/ULiCul2bz7KGVyAJjTtl1lerhF1uHscpRbd7sjhhE8uOy7hOM5DoeRDfEtvlM/ttb8Kfw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(7416014)(376014)(1800799024)(3023799007)(56012099006)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aquV2TVtJPVEZgrAQVeiooWHiYiJxi/2HAMwzgpTtckoovoc2R5zTwta1fjw?=
 =?us-ascii?Q?uxmpV7PwizLr9EkitovLPORF5nKIE35QAOVaCfdyARAr1iFDOdryvX/9FCp3?=
 =?us-ascii?Q?1Z5w5PlShxnO/079DDud5WlB3qRHXazANPhPbHmoOAzv1uxwv9pKM8eHRcD1?=
 =?us-ascii?Q?repWzPBhvoe/2MHGArfxXCJ+mvuRGdvI1VdEtbPUU0zQa4kW0nDPT08PHYN6?=
 =?us-ascii?Q?PTfmStflEqtscNeVSoF/cSWAlOLvcBRHSrlo+p2FHoDo0tRXBKS357CywD/M?=
 =?us-ascii?Q?j5zy0DCJG/TeJ1XS4LXaJVvwFCbGgE9avxtrPoVO34liSxaaZzD+AGXyENq4?=
 =?us-ascii?Q?uS7rM1cXDV9mRGXLWTRdFhpm+iYKd9gMraS6qT0t/SZxcSxoqxIPsHy5SJ+4?=
 =?us-ascii?Q?8jcQrhm5YgPtjrnjR+88zaAHhj0ftZqZcsCq4GlcK/FmAjY/ZjIRqmERlJcL?=
 =?us-ascii?Q?FiWXkPsCZQhAViKHzIaCXM/pUFxkA/DDlvHOR9zXkQdN07figF3/7LQ7RkWB?=
 =?us-ascii?Q?Z6iqHnAgke1HLJ35btmDLN5DayLdf0mOPnuh7W/iWhRmm9r7o2Xq+Ikf/sL/?=
 =?us-ascii?Q?jgq9bYcehduBRx6iXCDxNDzpnelTXkeIKe2TZbGkbdUVczHEJc6y+JXVTghB?=
 =?us-ascii?Q?SJqeGXPecVoP8nb4SpvQRJ8R+JB5waVAy36LW8bNRv+DH1GVeGzdqyAYkW2y?=
 =?us-ascii?Q?+pPD6do3jMs5d11gI2aiacRs2dHmSCzdjCjNU33JHL+tKwBUwQNUI9/EqU0g?=
 =?us-ascii?Q?1ZG+PR9mSm1i3qY0ppvy5HCFuNnMqvTUHWl4595d909SE8+1grMJniCBOxtW?=
 =?us-ascii?Q?ceWNiBdiHLB7tEI60EzCOg0mcFAWCAH0VlgPsDwQoCINhFPRQ4sg+ulV3q5I?=
 =?us-ascii?Q?l9DuJkbwqeM7FtrQDl+fak8ABfNjpDMsUKy1aRu9V6r6sE4xL1Ha3X6u1c/L?=
 =?us-ascii?Q?5Lh8grAXZoloEcSd3bWAb3tz6sebEl7z2wNemFYp4E3Pn1rBTZ4Q3n8GwR/e?=
 =?us-ascii?Q?/bD/zy6yNBsYNdurizSBuZVSzY8NBeJlfAFlGjFL83olFUPerFkBwzMYIaWS?=
 =?us-ascii?Q?kwXIyXUAjjw2WU5C348PFW444kEmdCHfciTY1IhBRV35A18iqjV38mvBGgz0?=
 =?us-ascii?Q?OogY+Qu4EYFXia/CCBmBRmBldr/G+2IKwo80z24qXdOQgQWr4IIwXjJO4j0w?=
 =?us-ascii?Q?B3V35VLBlyk+wkQ+KcsB4/mNwJSRpMdQ3+NQFypjawyJps51TggANUj2+B8Q?=
 =?us-ascii?Q?VX5PYnXzBkiV2WLro8IuY8iy3KvxtMbtgvOuw3Pg3DG5QjIiPqcJ9Kne0g2b?=
 =?us-ascii?Q?pRipjvDMZGsSdyVPrrDwHR0utD57gSQhBfz6YM7mZ3QW5ty7knJ4i+pAFZ+N?=
 =?us-ascii?Q?I0Ch+ZJ+cwa6Y5sHVIsxDxf19aEpt3PPepq4/QCiEm2iWfVb7tWxtjVA3RcQ?=
 =?us-ascii?Q?6P4fTWALko3PB7j+y1fKVh3ylcsjXNsaDd7PWxl1/WVcFjZLCKKcWSW7fy7O?=
 =?us-ascii?Q?9pTLv7Yc5CBacSWqqEiAF+vDBJ/pww1P3VyAZyDKTsqWC+euWTs4SwNkn9PC?=
 =?us-ascii?Q?7JXIvj5LdbEHBJcaYq+B64BlFv5rM0EwvopzvJVo6EejFXrjEcZYYLHPWgJ4?=
 =?us-ascii?Q?nP2TzowAN3gf17GpJvojmnM7YOc/Hpo64B+CATZDxFfJgwz2KHtoomaWDBoN?=
 =?us-ascii?Q?p1FOIGPxZf610BTm6Y1IrDSSZiUGcCsa/eV4s2UGDPbuo7gDHUBtH4sJMofG?=
 =?us-ascii?Q?CXn/rQII0w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c92c420-f528-463d-2085-08dee663fe38
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 13:37:07.5548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itZZvVp/DxCnSiJh9c83/MeR1nbHtRw5HbnwwaQhipqBVL+bEEbd7fahXD9DTIkI148kdqop+gHioVUg/qXz2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7259

Up until this patch, the only protocol change supported was between
1000Base-X/SGMII and 2500Base-X. The others require an RCW override
procedure which was lacking.

Since now the guts driver provides the means of applying this procedure,
make use of it and remove any comment which mentioned the limitation.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v3: none
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



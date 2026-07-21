Return-Path: <linuxppc-dev+bounces-24620-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F80EC44532
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 23:17:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4YDf2KVGz2yh4;
	Wed, 22 Jul 2026 09:16:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784675810;
	cv=pass; b=AJdb6+v0yEGMiTeF5zNNsz8Lpx3HKBrwWJF00jm+BS6ZUlh5spMUs6Y1pwI3Q4vJSPCUAb00Y6MX3PMJQnqBQQXoVcVxNzUGOe/OkmjE4R+RbZTZ2Gq2CsgguK8j6KBM3CAb3pOqfZq9ytDeUxbxURTwp3r7lpFZynSDRvj3+ZrobJ426xa/xIqqhrihnQYLhQnGmu5GcRQoUYIx73Zzt7BA+Swr0yXdzq/zOs5XsSVnDr4KQwD+TmP+9F+wBDBpsZONtaoSEXNkGeyrdJHQLm2XM19XNcLtqvSwk8SKlQk5n6PAY1aA8lRr7tP4B4lef0CyEku17SdQ5BPfJ6wqCg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784675810; c=relaxed/relaxed;
	bh=LoQOtTW3FtlA8mww2f4TSbIuazq3KdLl8+erw+Wwn+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MPJMQRk+HwMfIvVYpzFyuKWbNaHDz0G34BK2nZjQCxCn/JIZWI+foCwtcrF15baQXhUOATGCqv0Pt5/aT2urvigWrazuaz9BhNpw/wNRIo8E2xnzCuYENK5gpDmM7YKNKs8SRCFHhRuwgZxxk54vFCfrZEldnl6l2nV55KJD/V+x+XcF1cBp5NmT4mqkcwG4QYRlzPB+abiwCeIkQGY4+PUKdPYhohzyEkDKSfL1uwoEyqbnQJrlbTsf+zC7uk+yXGZmL53QLbdmSW6LL6diHd688tUCDtpTtj8MNmllg6Ar2S0DyEUqz4aVd1e1rqfaI7jxdiyDZztEBUqj6O1MOA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Ft4/HPYl; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Ft4/HPYl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4YDd2ljxz2yfD
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 09:16:49 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDm7JyYrzM9FJKOooTW9sKm3kKvfw1eI9vTRSRMJALr3ACVHIY18mWZ65l2wdgFqEopgruCycgEbeV+65iIDruE8Dct6wwGzdoQnwugttL3bX8cBPt6w3aD2CO7rQNF7weLQRxjL8YXnMfB76cv2Ft30N0pEbteiWshqUMpxNy96nSE/Qt9XuMFMLai3LXmhLZvvBGEarM27mprFr+RT5h9SZ6U/B/UDr9uqMo5oskitq8cUOg58DffjnizesJ2jc4ZqCE0H0UXU+cflfzepGyNXsP4len2eOWDu1Ixo7Lz/VfqPeZIMUPTCtpkCEGVM/t8yfh21AkRLgWVBVv7iKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoQOtTW3FtlA8mww2f4TSbIuazq3KdLl8+erw+Wwn+M=;
 b=sx0sUTA3beiv+FwG5h4U6fOs6LvP7HqfgBZ7a8YQjmquuaOV4zhHyarSgfBNCQZncOewBNSSVH93qI7QZ1XTSOhc2wZ8jIjeXrsrrpPx6sGru/4ZOuIQtkdG5WDvjnYwrQms6qNWkM1kyAGKMgRW2cveSdva5gBRG4htIRLYXDnyDNbtxyhR0/P5qHewvkqps+agjL4FAkaGLTymlEegcBN8W4+HfKrMXTAAJjct8YnWKTIo6lb3Mml6ua4LmpiF/Agt/t/po/0I8x+ZNsE5+cfKCvINTo3eTAZa1C9S/vpl3lrg+8K7qBCNPVYV4o4a+36Hh9e0iGo8+GUQDkejMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoQOtTW3FtlA8mww2f4TSbIuazq3KdLl8+erw+Wwn+M=;
 b=Ft4/HPYlw6eVrqXW0ro+2WA4Y2lYCLT2d93bTOJolQFMWbt55RYQFoqJkIi/5uMj3eGlq+LOhqxNmmTXQXvSLoZgt3zPiHNw86Rdw3p790KJftcVq0857RZ6zJrNyLMci0ltymrZlmMGLvSfr4+UPB0w64o6BzmB5iLtL3iWxKy5Z2OfuYHMfqJGUCZsRMaxA3ibw5r38v9pPkbW1QJ2u8Q2oMN2unLNW2hH6rvoordFGD1eAqyMydSKt5tmU6Mg0pXqoNOPlHj8ciIvknlPIDHne0l/MuXRhRoWEG6ID2rmVAbXYznsmO6IxhXU+9Urt/nC5b25JMlazDa0HrEFiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by VI0PR04MB11817.eurprd04.prod.outlook.com (2603:10a6:800:2ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 23:16:17 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 23:16:17 +0000
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
Subject: [PATCH v4 phy-next 2/9] soc: fsl: guts: use a macro to encode the DCFG CCSR space
Date: Wed, 22 Jul 2026 02:15:56 +0300
Message-Id: <20260721231603.67865-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721231603.67865-1-vladimir.oltean@nxp.com>
References: <20260721231603.67865-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0008.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::16) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 6ccd43a9-f82e-44a1-49b2-08dee77e10f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|19092799006|1800799024|366016|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KqMie4706PgoXw27QSQoMFpOdnMEd28Tt+oWZJajSUkXq+2P2kXrTJ9Ag8Fe1iwirscVd0cFn0G52T4D0h4uEqGj9mJ2tGA2jco7Wb9kcV+wLzHisWCJzOv8zsXvGKgAjmOeBwAvBWYlYzQtlIB7CllWef1G09RGHKYqX74UlvFxRLGOFSJ6L/0qwdagZD0QDSEPNTB/HXOnTV9H/bQFELXyQhdpIxSKf3YEcgk3dWjze5MePgVw1bX8Wy18m8hpKwYUw2Ep8oWelbbQNXQaS661x/dWqPupbAkfLlYR50y60sKQ8KYDyUFVxjP9SizH1AICi90Xnzt155R/z39J6n+mdP24XKKvfXWxC931P/xIQxxANWrmYjj1r8nvxBxw0kB3ncnM0Z7fzoy1adLHjw8+m/HDjX/08n11nsXFz8SqkYmdicxzNAi8VMdr2bMeg9BeCCRiBYBAv6ojZZtm0UA2EvsM11yndGX1TDhyzRYoCBS9OpG3mlAFeuFZZehwYsE3Wfae+QNoaU33I7ZNQpJpT20uyVuBSOuvGM+RbzZUMM2EEPN8VCLG4EYyT8Bif5Axnsy9Ec18i0J5jxu26jENwTKDMLn/KwJpu+JnfbISMKd2ynvlJMYvm9BHF92tkmfTXnvMbU8j9B2NRYFHzHhMJbbO9GhF6FH/1+N6RvM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(19092799006)(1800799024)(366016)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1XhSAqjxJTRkVenHDZD8NQ3ib7t/M37ACcbvGmtxfK3a8K64uONf7yp1Z1he?=
 =?us-ascii?Q?5bq+2FULjpSVFdqAoiAxl6sANYmwYsv3R416JxsaZx6X5hvJfI3XtfjlGAa0?=
 =?us-ascii?Q?q1z1C968mWtoiC1Fke+Fwmay6UxQcKYpVmp+C+pw4ZTmTq7qJe73ZJN2msSI?=
 =?us-ascii?Q?0JfFXoPgoKa5FBhyyPM8PY7/mCBnmYFcQCyJx8L6u30DmGXzrNPLNuE14E0I?=
 =?us-ascii?Q?Zw92mJUJ/Do/1amNrEa+13uYFKiloIQbmzycLIYuY342wtGmKlGXJEZTxoVd?=
 =?us-ascii?Q?bKo2pugaWGME8TC6c9DLnFMSms6ZzWEYqaF/+olNbP+8XsN5RCB/1gPdC2WU?=
 =?us-ascii?Q?ZJ4/MMqO95KZfGMvMFlt4Ia0GNqxMHKTgwCVvIAbkbN+0UphqEyOrXuM3K3y?=
 =?us-ascii?Q?blCDCnXim8O4qho8Ybr3C6WJtyvEQe+EH4LhTmZg5hhqLJqOGeH3hVvUbuZ3?=
 =?us-ascii?Q?ZP3OQ3fjSoF4ZeNrL2fEpSGpA2gw+C9BldmvFXYpQysx+XuqpcbmwrUGjWxD?=
 =?us-ascii?Q?etGg46U/nyOUhRbt7fcRKjQ/BzV0BBo7dEYAg7PLgmcgXf/vDP2sttJIOg7m?=
 =?us-ascii?Q?B2rQ/LAOMKAX/QrceCm9OQV+rOJIK1umS4zN0GXQoTorKash5Xu8Ii33er41?=
 =?us-ascii?Q?OH6rFM9o2IyoZn1YPoQA8KitJ5KFUTQ3fTR7eNFojVQrkddzjkZz9htRVpTU?=
 =?us-ascii?Q?ydDg9TObNMa9SCTeqz2hWOLhkCjx4sIOYqVsQX9bTO0e9jwHCrAA1/EftHB7?=
 =?us-ascii?Q?bNJo19xIcL3hRibCW1KM7K1pXfE3njwP9s+0sjzAroXs0Vs5bAZ8uuHKDUkU?=
 =?us-ascii?Q?MmQByT/fwNH6x87q+f3BEDv4cXlJhoLqrcdheW0f9OO0ux36VWFn1qeOKEnt?=
 =?us-ascii?Q?ZG+TNhFCPFzHErmVKLuTS1qpUmciGX3jfvx98rfPli8xldbGkW+reo0+MCA+?=
 =?us-ascii?Q?jQGAs0B5ETDqx9GBk1v9L7vZwToZAbBrBFDPkKYUNcFzY4ptMeeHluImgBOh?=
 =?us-ascii?Q?7kUyjHR9/S+CmBiScLWgY/vfkdZcwAexCw6Kp+u0Tp3W2XcP3s6mY1UCIYsL?=
 =?us-ascii?Q?3E3F33UirWJsi5F5oAI+UBNFDmv/0LEQkOj06Jppo6viN9CDIaO7qwogiq+2?=
 =?us-ascii?Q?cIFdcE2/0LRQyMODyOKoEXS/gQkd5l4dUitdtrzOzHZSnKGcsxju/H9bq79a?=
 =?us-ascii?Q?l1VMcSSrZ1QefC28lQADLGPKShB8DQKGfO8teOv6JffSTHSeV2P1IXXdrAGQ?=
 =?us-ascii?Q?bPqxHixA/9ddUtibPGGTVELipkxIKML4S4yEjUrxDMMz9kjlSvidWuSK4UFL?=
 =?us-ascii?Q?pfKfo5G7PAbgmGfCWozgpxmPkmg49AS/KjV0OClXt1gBdy3d/N7MRNeAgXST?=
 =?us-ascii?Q?9S0qIZnjP25rnGqR6HEeIVRvTjvNXysPJGgrg2nT1iAaL+3x+RT8cf3K6rRc?=
 =?us-ascii?Q?UJ0bnIUGo8U3Lxgv7ra5MpFJ5a04S9I3Avitko3nuVz7oiCMYqFsof/BG2hg?=
 =?us-ascii?Q?5UQJKruZBXVjGh0PsgeaP6ERCdekYRzc0CQ2/4UDWjKidXqH0BZ5ofzRpbo7?=
 =?us-ascii?Q?KobsQfitXcMT9mM7HbsdZEcAFTqI4PWz+IWlgq+pCbFtfoHUQKug9un/EW7K?=
 =?us-ascii?Q?9DPCc9ZnzKyQx08J1tPMC/sIDv0/JIMwkwJRjXx8pPJffvsnRLC74gbLDdJJ?=
 =?us-ascii?Q?mwrIrKiuyumuxkI2Kv5sfNkXGfm2ntZeuiyKVvE5fu6oAuNLzn5FbEvvL0Oz?=
 =?us-ascii?Q?9UABp5EXXQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ccd43a9-f82e-44a1-49b2-08dee77e10f4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 23:16:17.0406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKoRkKXOWeOUXtdJ02vzbF9+0TGArJRHOz/xRAzQUbkHc5Le0wdYBR54j8eMSoiUXu1ipcQbGixZzqfGfs5z/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11817

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Instead of using a hardcoded value when iomapping the DCFG CCSR space,
add a new macro for it. The code will be easier to follow this way,
especially when we add support for the DCFG DCSR space as well.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v4: none
---
 drivers/soc/fsl/guts.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 453456f31800..b97eb80cea95 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -14,6 +14,8 @@
 #include <linux/platform_device.h>
 #include <linux/fsl/guts.h>
 
+#define DCFG_CCSR	0
+
 struct fsl_soc_die_attr {
 	char	*die;
 	u32	svr;
@@ -197,7 +199,7 @@ static int __init fsl_guts_init(void)
 		return 0;
 	soc_data = match->data;
 
-	regs = of_iomap(np, 0);
+	regs = of_iomap(np, DCFG_CCSR);
 	if (!regs) {
 		of_node_put(np);
 		return -ENOMEM;
-- 
2.34.1



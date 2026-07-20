Return-Path: <linuxppc-dev+bounces-24466-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AB1C44525
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 10:00:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3bbm52pWz3078;
	Mon, 20 Jul 2026 20:00:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784541604;
	cv=pass; b=FbBM+H8mlBREZ5vxAqhBiKrP8GRzyEpBwxSOSKZ0Zh1IMhHkCCZwYfAtnWPSTTpg4mT/+lDCCUiKvicMbVCg8s7R7K0YS2O79nv8VuhWUN7/05gtLleAVeRYF8RwwN5febxfj9H45OITB3q+ytaseZHeEDyfAsEvrTn9X7fx7ZOEXyybIYI/6dZsA7KLwzPEPew9GI9oiLAGA+y4k2wK5GK3GXd5+7CiGEXbQ76XL1WF6GSbQrgsWQvf5Ueyn/UmjUn7k4xrcyJ3P1Lj/Orvw9IMzCpGFecC0XhMmi848tr+XrWWpC/TMz8Y+LETyXmWZdbRc5h8TaKHH2xfvyshTw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784541604; c=relaxed/relaxed;
	bh=L5nTYn5DydJnT1vSxB4ZFr8dxNjhvum8jXttXPqXX/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O6dM8U3VaVsIn7KdJjvtKmJHrSqmDxz3of3cJAhwgpIHrnu5HvvjXAXTiBm6Gujled0WosV06koCucsTRN8zq+GPoNreXekSIZD96wf7ShJwox6wvX0HGJHBdoF/ihx8NtNvDFftLolFB6H3ax28t6Rqplsj2MWnKcQeZtedslwBt/FDZkWxh6P3tkg/W7INEUAGTzVLuz/4gG5oGFvMrg8cBPqs0uF948/CCiMdVXGMlEP7G+HfWndR1jObYyf8K/zMGIlxSz0Jwkeyf/Ww6p9WDsuhr1jheMp9bCYzvxn6P6AnBJcdWhDmVdUQSTHxbruLfPc6w50lUY7eb18HNg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=BiqcrOSA; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=panchuang@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=BiqcrOSA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=panchuang@vivo.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3bbk6x1Lz2ygs
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 20:00:02 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JiBnedts/mnhFTj2FYeVcjJym9g649v4TXDw6bE8wh1K4usvWgZtyAa9eqFqBjkRUfFfadb6rxjb7Ri3Yit4x/+3OqHK9rvLyJe7a+RCG7OTDd0S1Ojsass4DY5079E3LR1ghfc0KycqHzzbtRCndwc+XZzCZq95Th+gvde7GO9VsX3+4XJzodvs+uRaWsviasO+XHwPy0te4S5GI0gDWRIeAfKpw2V8/X538hqYR7QBd5M8FTyE6IJGT1HdL3UBQ7SDqpoPrD3oWZYOrZekNUoRrXiy31XeAfMWRsa8MIcQovtkmp3tZ2OX5lqcOK7iZDPNgyj8jerYTGWW6UvfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5nTYn5DydJnT1vSxB4ZFr8dxNjhvum8jXttXPqXX/M=;
 b=tH51fw3MFzX3+CDu5PGc8q0YYLAjWPMiGaxJciDGZJ9fabSffBkFtj3FG2dq4xaiM6G4rNDLeBmJJcjVubu8IjhlGQ8ERsSIpSo+PNWcVUBSqfpQoSLrg/yMda+Q8U5+yfWdtLaG1zLXEWDLyFZyiyfujw321w43e1XItqOLNAU0lZ065cRY/SEeI2H9Bubupn8AyfBSh7FojBaAPfBYcuqu1u+ZcuqF4Lr6VSfFzpX+Kyb9P6KpPKAV7U0b+g8RZ0Qte7DLr4TKP9Xoiq2QrehES4U+A4lIRfYk3lAlwkwwZhfb3Wr57GvLjpjIhVi/+A/3dFHOJqpvnzs9BH+X7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5nTYn5DydJnT1vSxB4ZFr8dxNjhvum8jXttXPqXX/M=;
 b=BiqcrOSAhzz5YjDetTn0AQgv1iIcYS2FQ137HdUWEzBMoMOSeCXC5M17M30OpLb6e0QIbj2IcIzeVHiZvb3rz/S/Jyotzt5xhswM61l1oXUiZkWvSHBBBdX3H3ltyWqU9bpG/weykmugDYMMxXXuEP7ETIleiVkjT52iuiLStqc7gtKFZVAEn1tQBuPZZOyWXO3LbTrYcfZDzzYSx/KdxZSbbaH2HkwBQy3wSpncQQPXHbb3aRRaJ+oplPIREXQECFQTFyux6gZYFRn/IyRRbfEmhG7VSlh67jRy2Rpc2Kx+1FsI+x3uiitPx2VaDMvMMutZnvqc1x+p+bri636WaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5828.apcprd06.prod.outlook.com (2603:1096:301:e8::11)
 by KU4PR06MB8458.apcprd06.prod.outlook.com (2603:1096:d10:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 09:59:38 +0000
Received: from PUZPR06MB5828.apcprd06.prod.outlook.com
 ([fe80::1d47:987a:ed97:769a]) by PUZPR06MB5828.apcprd06.prod.outlook.com
 ([fe80::1d47:987a:ed97:769a%4]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 09:59:37 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Roy Pledge <Roy.Pledge@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org (open list:DPAA2 DATAPATH I/O (DPIO) DRIVER),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:FREESCALE SOC DRIVERS)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 1/7] soc: fsl: dpio: Remove redundant dev_err()
Date: Mon, 20 Jul 2026 17:59:07 +0800
Message-Id: <20260720095920.542801-2-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720095920.542801-1-panchuang@vivo.com>
References: <20260720095920.542801-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::11) To PUZPR06MB5828.apcprd06.prod.outlook.com
 (2603:1096:301:e8::11)
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
X-MS-TrafficTypeDiagnostic: PUZPR06MB5828:EE_|KU4PR06MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b40f138-b761-4b2b-e5a3-08dee6459bf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|52116014|376014|1800799024|56012099006|11063799006|10067099003|6133799003|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Bko6mvY0sdS3mdjBYMLNybTVvkXleW47FghJw77/YInCdSwmknpT6mLQXyoTluQJkAZDb634APzVkKpwqJNBW2QZ/PI887ku3fpYkNNCvjHDxMRNS6rR7WOYW+tm3wuYIxVGDBKmAUcrUtHsP9uk1CDxcbWTXaHvKPsRBEuGjC55T7JfNWvM37UYi3qyyee/OmWBNwpXuXfb7xO/3DKKPx3AItmsfWdNIZZdTouwAssLEWoYqHgLXhaMKZ/VloxH8JJHsF8VYCfGtCadkPbwftxbkpQ741TaffVyFPbOaSa6Uuz7BQ5enxf1OsfHEoMYeJx8W+qbrED06h7hZi+XoWxCXQylf/IyIxSXM/DtF01JYZfxUy8G/IcYcWQR0Kvb/usWNvoF3L39SYWM0RRoDBBti6C9gcYdoDxO1tBfckkgckU9Z9JFzX+cMgrObAwkrAreU1AGTF1GGPy1aLmbT1573ZX0ohXpzdUZ1xFMU41Ac4xRtDlep2U82+u3h+ht2081Dq9CvIdCvY5Sxy1XMYif2QEFMW7fVBQZCaJUl6XIxrlqN6Iztcyvm0urvR52lZNypLAx6o3Q6F3Ai6YqYr5X02isHHyIu53N8sWBHRmbuqn4aQeUvXB5w6QjTMEod0mJ4ljBerc/W519mIxOD1yp9yx9GHOdZuA5R63/tes7WoMikWJ7GXx4yJkYBaavTSWIKuo96YOuwzzpM9YFZXAegoOAqaw681LDabqLuus=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5828.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(52116014)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(6133799003)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tANS6epCChqkLeVZkD+25EYAAseYFC7pT3FFLtPFWxyVkNG82qbPUgIMJIWN?=
 =?us-ascii?Q?ymucwMe+K+n9Kr7k+DHX/bWG2Enafi81VNpRNpjZPUMrMVYVYLeyp8OKGqDI?=
 =?us-ascii?Q?xLCfkUQXvTXBabwokXpVubayMFAZibC6C76ALbHLqgKdtF3MWsOes191gFaZ?=
 =?us-ascii?Q?chQlj02V3mufFr5txuTKG0BUJ0Aa8z2Hlzb2gQbSf+vjnVEEOTQzPoiCQeys?=
 =?us-ascii?Q?Wfjf3/anNNE5qCuaOXVoI4CKm4mwMdfn20NHMWSQGJf7g4SDm4Tx3u2MvJ8n?=
 =?us-ascii?Q?Amk4efRCnAdmdEkFXYdeejFjPpYsO9KJq1sdo838sMIUJRydf2G9kPjApkQL?=
 =?us-ascii?Q?aNpArHNruhQhrsECGPzQS7AF2BXifuVdkfosFtFtDg6p0VPgJTlZBaTC6e1E?=
 =?us-ascii?Q?GiAFowcrGPTtlE66CWcgVRgPnnD5cuhF9kKx9VaZQke94Xg1uo7dhYto4jTB?=
 =?us-ascii?Q?EG/+KlGcCxX4EmJfr2kk2rHbTaHv52JMVMvVa/9FEZgd6G66ilqbLLCh17dr?=
 =?us-ascii?Q?hYWXRZvBwWzgMgx74JfXMueLb8CAtPL8FMdxzHXFjQrLdvvOETpSO/vv4Av6?=
 =?us-ascii?Q?K0Fu59RcOWaBsaPKuBQwxCQEY5bS2pTaPmG4aAZTHIOkhEs7pqFtu6znIK4C?=
 =?us-ascii?Q?r0BnqLvifpVmEmwdc/+xKtLsvHfCsUP8h2pcssrowlFZVOI8c2X74HZINxe/?=
 =?us-ascii?Q?yfu5kE0OVyWwZCWaDx9WbVfQPVH/xxA63rBhZNdwcgDSnLhQ6pFJRR3H94qn?=
 =?us-ascii?Q?QO+KD3SoxjvTNQ8KMILEfkp9KPfWYKsWF2Ujkijgy2IoW+ozWxtckGRsJFvh?=
 =?us-ascii?Q?e7YpKo0JAnMy9+RhqUQmm+bKwdcjkUbQUr2CxQEHWbdTx91WVyfxHyr1ezvw?=
 =?us-ascii?Q?/ANfZ2uWMcnlvMVKnY2ueZj3LWRuv+eVyLRYMGK/Sy+mlufmPzy6XWzOz/5M?=
 =?us-ascii?Q?XuTUorFNDQ/8rZyIvKuTaIPDPc3dOXZUxb3NZNkEuS8FioDBUidZN05c5ucv?=
 =?us-ascii?Q?X70aCKkVYXKW0W+08vcZ4tmW8h2bHT1EhkFQbkskTOV9yaTXJic36fTR2UbD?=
 =?us-ascii?Q?RuMqFdwQBdwjFnSFcXAgfmasUyc8wfTTAmEV6f71oypy1i1ltmFV4OxWrOnm?=
 =?us-ascii?Q?LXii+pSrRUyfBCoQjT0bXFz+iyf7wGHER1Ad4MgWveNQ5N0fHLjYrraT8T6l?=
 =?us-ascii?Q?REtv6+SE3PxgdP6Sm22B3q2aFXftwR4oeuG80fF1KrLMb0bEbIttYFpAf/sr?=
 =?us-ascii?Q?SHmmKGCacqNibvPjLr8Y22PWSxqUKH2nyPUecu7sZlEBvrIHI1DKGFKZi1R7?=
 =?us-ascii?Q?35p2drnqg68uTwWtS/FAzP8UZvcZpn87c7VJ342arRVz8i89lyHi9ODEaxrP?=
 =?us-ascii?Q?wu1xOpAl/Bz6m0bUEuVYocdKLxabqG2d3HekqMCmItbhGkAcKIbHpWJERSiG?=
 =?us-ascii?Q?47EUIxlQT548kUDnWRByNHz9g7nbH92xj7X0YSGaLWhaP2Nw8QPaW+EYITBy?=
 =?us-ascii?Q?31XYxAIPyf6H5LTWXgYYPnX+qM/PDNSbPcAWCv7Iyw4x4W4MrbtuH7lAXSRe?=
 =?us-ascii?Q?/ofxNWcsJwVQCRwlAR20R55E3hlpx45z0mVZeL7BeevHH66y0M2MGbGbooiv?=
 =?us-ascii?Q?Zk7MVDb0XxFv8qT54wlK4zLqhOxqn5YUFkeK1Uc1z8XGXUtvUAksbsEiDxwW?=
 =?us-ascii?Q?viUcPQYTYs2/QUDusATr0wXdaUcOMlNGVV8XtW7n1mx+d4KChStBzLdYsU07?=
 =?us-ascii?Q?L5g9ZwoL2A=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b40f138-b761-4b2b-e5a3-08dee6459bf5
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5828.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 09:59:37.9049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPnyTdBGrD5lVDJrPXOvKclb1Qzh4iVBHhVp/rhCo4XUIvnyU7wgy/pWebpYQczzBaoWyHvP2+xUNyZjHAcDPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8458

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/soc/fsl/dpio/dpio-driver.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
index 9e3fddd8f5a9..d5198ffc4455 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -102,12 +102,8 @@ static int register_dpio_irq_handlers(struct fsl_mc_device *dpio_dev, int cpu)
 				 0,
 				 dev_name(&dpio_dev->dev),
 				 &dpio_dev->dev);
-	if (error < 0) {
-		dev_err(&dpio_dev->dev,
-			"devm_request_irq() failed: %d\n",
-			error);
+	if (error < 0)
 		return error;
-	}
 
 	/* set the affinity hint */
 	if (irq_set_affinity_hint(irq->virq, cpumask_of(cpu)))
-- 
2.34.1



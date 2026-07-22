Return-Path: <linuxppc-dev+bounces-24629-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA24EC4452B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2026 02:36:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4dfX2PN8z2xBb;
	Wed, 22 Jul 2026 12:36:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784687764;
	cv=pass; b=CjUH546XkKvei+hPAxXeeTug+qcURPLSAgIYN9oMmYCc3kTaxuDz7yrF1mouxfVHn2n/HjZC/TYaiYO/n/Gp0TQSUaWMeBH5apv4siiZVvftP4w+bU1NNN9HosUf9qeSCRTbsDuF4RDABt6NH31/plWUD3VIxR/uH+QuFBV3yT6pI/v/EWYHoXpFzves932WOuXJHXDSkRl/e7uMXbf5ZX49Lv4joMUvO8ZaIyEVN0NzTCDDKPDJeqEaHHMwW2WPrCEbxyk2/FgTgvUbGkfQlvsq1uoaFmf9pYl9dgg7cPhfZy4qX4Tz+67Ujpd11TSbiTwgxGBIoMFX0amyAmSnug==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784687764; c=relaxed/relaxed;
	bh=L5nTYn5DydJnT1vSxB4ZFr8dxNjhvum8jXttXPqXX/M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KWoIT3Nbs8d1c0ndeZ3yH/OwZPYRvDQZSFxaIZdaVqhd+mDrjXGhvfx8yHGqHSu+7EznA+ZWzXlSThDT1Y1IT/FAdDr8xITPLkIEMRu+Vmj9AcbvmdpcwEvJqRXeT22aq3NlOmuxXfn+k45DzB7GXs8ZDsHBrVWx6bRECNlDQVOykRB5k34gViZvi2JHLjitBS57KTxDVz4YTzC6TsTCi3yccZHWgPTzTR/3YIc/LTp6U8zoj0FezqGKsBOs8bfgNCTEl/4EhPbvmJLLx76ksIUyG/WFYmyHHKt9F/Ez2LJKI8HRpvnu+9astWsw684PDofErk6GPVtfLJJpvJ8ySQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=prkUypdC; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=panchuang@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=prkUypdC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=panchuang@vivo.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4dfT4z9qz2yfS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 12:36:00 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0Xa/mifTJ4ly8bUU1aKSRq4vwtALpLDqYSLGMytUW3orG8wdODT/pKb0xe8t2ixDnkKMYXKMNal52TvNpnOxIK4ZoUukFMBllbosPU9o4g6usWU5uKBv8tHBLWlKHs0lHP0Nl6GCa/PUS0V5JSb5rICM2l4xHkarLru5vxElB3z6Ee3qMoYz6eO5trZRNsfkb+6HKnWK5fGWmF85GGVyqGso2njuKEyzN9OAUUnNmjac7wPoeqPNSw55fRc8sfF0jre79kpgIroWibyDux1JAx9mwOQnDlBI57O6Zo5F1e6URcIxOO8wIZGQ/ua8LJI3fh/s65+X5wSa6gEc91VPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5nTYn5DydJnT1vSxB4ZFr8dxNjhvum8jXttXPqXX/M=;
 b=x8UOgJ1Lbuq+qkot1wcyCuAa3uP3aEmKcXUoucc4x7dkveMNy8JxdiYCBhyUvkh7g7rGxM2FKabtHpdacxoJRpl42RiWq9bgls9kVod4FH8pfV6DsUs4//fXHAGJUacW+C3rm36yMhEqNwOuL8kKI128itP79Sq8AenZEQMOGKrDlQHfrhYcWns4ZtDvBaXxmW/8zji86GglvZQpQK9PMaKRFVG5ZuSLbW34EGtm3mIHF06xXPk0jYMgBoQZIMOMBL0A1Nulb9HGaJlaOsYpciSnEduVpnlW1Acqszp/c2aowv+2elbMHD5CDxEzsESpOR+I212A9HUIStvS2X9mng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5nTYn5DydJnT1vSxB4ZFr8dxNjhvum8jXttXPqXX/M=;
 b=prkUypdCpEEY2kdOhjxvGW2V+BGvHzEna1mBhqJijLodujWaiti8muzwoCz02+LRZuyCt1kHzJ+7I4Hi1G9rroA/3aKRVIUYDgpjYsHFlHrHLW7+1HKoArzFqDvuLLIJvwkBYPYaychyILF9J6bIHyCqtVTl/llQLL3hjmlvnZ/MUdrMfaypba5s7+kEDyDlxZHDJhM9Hz4skmYbGPbxz23d8mY8wcJzVIpnSbYMuX46M+glHpHenMpI1z8kx4cRCt2xkB04Io5a6/fbu3anKqdhrT4+Mg6VgEIhYpTBAs92YL4RsVu+34DHFLva2mwNJtxI1ykAHRPXJTILgd/bLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SE2PPFEBA6DFDFF.apcprd06.prod.outlook.com (2603:1096:108:1::7f1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 02:35:35 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 02:35:35 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Roy Pledge <Roy.Pledge@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org (open list:DPAA2 DATAPATH I/O (DPIO) DRIVER),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:FREESCALE SOC DRIVERS)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v2] soc: fsl: dpio: Remove redundant dev_err()
Date: Wed, 22 Jul 2026 10:35:17 +0800
Message-Id: <20260722023523.42269-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0023.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::19) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SE2PPFEBA6DFDFF:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c86600c-ec4c-4b3c-9888-08dee799e87b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|23010399003|10067099003|11063799006|56012099006|6133799003|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info:
	qWdgkkWtoZTVcDQ/uJoBeeN4cbfjXFOlFQk7NDRJtMIgc+nbc1FBuQ2F0ETtXMg9IjSxF1UYAdYtZU/cF/z8GMlaNfCralqUx5dYRbXxl9w1weq84R/dnUUYvOguvwjXErKIHzgVyzopVYlDh3rPduDl6SBLpPQEbxLSgt6qHs9KGJ48Eoo7pZrzXgV3WLSYeO2A5KsPWyemY4CrcJOzY5LKy8XbBYxjyuQNck2onitm/kC//DcQv5WqCm5e9D9Jh9miifdeq89+QwIrwFvJ02O3XAa2PAP/TJ4OELaLmJOHuFIdAFMpv0iUdi1fjYI9L1EYHo4MjRIm1JDelMviXlQ3SODCSgXizES91jfZbHgU5R8xrD1OqMlHXRbJNKvDpp0/oj5LT2bI1LnLdslR+prra1qcZQlodzW2fJEc7084Jp2ZAVv2ul4uOxo7R2QUjMkJCDwl/DC25gz+49xGkqzrzm+DIUI5B/jeKXF/si42DMyXIIUOp37R4SKEJ837ALAfUVVoeZr92JB/y4su7K2FV4Bho3A007wZJxz+OMQVFUyA4lDxGOfEnhh9LKj1CldAWEyLji0DJtXq9SHc9Trnvsf5Sxe5RNzy7pSOIVp3VL+ItDOblNnwWut/rEWWKWwB/WrhS7YJlsQ7CaU6I7DXlQqBpnCyeY3OWK/PE9BASZlegBquy0kxTxdgCgGbqHN33cGe5BrmkxQroSim1dWI8shPwi6OGuL4SLBMghw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(23010399003)(10067099003)(11063799006)(56012099006)(6133799003)(38350700014)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IOWAbh1kyFZb0/UMgvLoHOffauhK3H80fM5fJI/mWNZ0v+5UrowBCfn77wsJ?=
 =?us-ascii?Q?4OYlHszIh4nzOyZM/sqo/GkI/nXY6QVrTgmigqMvCjSALaGb4Ogn/FWurcFV?=
 =?us-ascii?Q?8X9NZvFlkeVwE1n6jnxP838lnuBbA2EwdWOvyCGccZwU8QRbBPtlJdkNLXCJ?=
 =?us-ascii?Q?W1/MnLgz+m+UO/qVvGfoUgaIl0cIhCseDNVcmAbKxxU8d+wEJdXChRewyvlb?=
 =?us-ascii?Q?WAPO+AG5t9RXWogXvGqQq/a9/erfZgZCfL0GPqF4R60ZX8NwyEEAJbVxcw37?=
 =?us-ascii?Q?0/2d618KQrmc2XFZ7/73HpQ0CMJekOVajM02YbOXp8+PqptLgBymnZLLC33y?=
 =?us-ascii?Q?ppQS2+tiYOB6CQ1sENSFpANM7dk/UyvcTvqbXBcazfkFeZe2FCso4obJvNvv?=
 =?us-ascii?Q?TtJo6aZ2azL1kCNFTujV8oTta9FJvJ0+et9DgKV7q/oDOTTTZZ0iByVtyNJt?=
 =?us-ascii?Q?8+vAdxeJDP4EghdStjTuFJY5mFkOJcR/4RmgYTuzvkc79BVAO1Af+2CyBrYw?=
 =?us-ascii?Q?zYMYtjfRx4BpfWV+XxXSJ5WoIRpWokKvt21xyCLeQr4K8SrtnFLWdYaEkun9?=
 =?us-ascii?Q?OplRkZfuOxRN0EFp3hkeJDf8fPa7v42GgYXfDj0ec27FGSpJe++6z0wV27pb?=
 =?us-ascii?Q?ZzE16NeEI+hyf8NRqTpribvQtCtvXxfBCZTzu9L+EF+JU033E2hK/Fh+vZ2r?=
 =?us-ascii?Q?DzT6F4QjSgRpktFv63yZhuSy2KT+ZlGh0ANwAUXn7P3XeMUFq9kSCMT45zWC?=
 =?us-ascii?Q?ILMk0Rh2iwUlHWYwHEdoDpes97urTGDu0X3cNAGGKI7s/xecIyn0bDpaIITR?=
 =?us-ascii?Q?Zxc3WthYetJa2MbSG+6Swg4cJFbrzsgOB5aJmlUtBZyXtWI/mz6rYQ+EyqWb?=
 =?us-ascii?Q?UtNLAuLlHmFM5Y4BO1tmT1c/dLrFJ9tEgXxAsZvnThBL36Hq4KmY8P81w3PO?=
 =?us-ascii?Q?Ko1L6gOZUAQi8TCAdrfD++GYElw4IaWYAH/++Yz0zEYkQ0e7Lz+gIvP+sIwF?=
 =?us-ascii?Q?zB9ZDK5EaTc+hiLVUUbV0gRarrhApenXdnJGjeJsv1YVZmbYjAEI8T63hEEw?=
 =?us-ascii?Q?WDOGg7HVT0p+E8fLworv2ksDaGqbByZxtNFpiIyGuvDSOeXNDqeRoOoXvtyZ?=
 =?us-ascii?Q?bAhsBabb2QwpOh5EicwaWUHYRBjF7emETgRGcnjOQTL2leffwccSs7m5UEUz?=
 =?us-ascii?Q?oACrQjILYjzP3dm2c7HW3kGc7nlYznxooR3LEt4QfSBQMrowgaU842ztvKOk?=
 =?us-ascii?Q?dxsZf3OpEMilnMzBcxEbzkYCupAuucS81y/0KsfVSXW+IX+Z7aTNmWppDRsB?=
 =?us-ascii?Q?xgvliZiS86yYlGH/oayeCFo/Qwvou8ic/A5y1udgY2A0DYl0FCWbQ5W1VULK?=
 =?us-ascii?Q?epkleQrYEE8VWPDQHwR02/LiCZCZGHkn5V7AoJ7Du5sCZut1qOIIJBnSL0RW?=
 =?us-ascii?Q?73fFoSbT9bD0clW2OBNf9n9xvohPyFxDJH0nnJE93jOMKOHwvLDfv01/nT3D?=
 =?us-ascii?Q?76FQK/0UFiN6wsfvLerKC0yl0MEgxQgdO8epA5648OjZOwwFcO7H1+X/I+dz?=
 =?us-ascii?Q?Xb4LvEGGoAP9lkemyXTP2avnTJsBdsyGd9389VNEGVls3bdnK0GnUU0Xthc4?=
 =?us-ascii?Q?LmkpGhPYNtGfaYzFie+Mqpr3jaA7+cjKgbGjWaIsWIBRF8V5op7raeqCIcA9?=
 =?us-ascii?Q?SKXqxESCoxZY+FFu/75V+0HE2n/3SBhhfv4IZms9OgOXU25F60DdtE2wZNkj?=
 =?us-ascii?Q?yShLsu/mfA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c86600c-ec4c-4b3c-9888-08dee799e87b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 02:35:35.2107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2hvNZCJ29H7A632eYpqDuTbFj1cS4tUoj5VcIj66QevH7R6SAPMwV89+fSDCr2v0Ehs+rb9F3JBf6cbdCRUpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPFEBA6DFDFF

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



Return-Path: <linuxppc-dev+bounces-24708-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323AFC4453D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 02:48:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5FtM5dTSz2yVZ;
	Thu, 23 Jul 2026 12:48:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784774907;
	cv=pass; b=E8m9zsqq3fveqVx1bGOPQjuebL9FwjB93VT7bEUSqMxbaLcEzDKyTyUFn9dE7Hy8H4xq6wIYO3dh1427GlJl1ur4q+8Vgk7/uXny8vQuSTM2nn3oHPA2rFLGc9etvd2A2Lt46/JZcHxmRguKvE3EzM12xAFoMCInKL7Aj1i1zIq+CQXuPo9JXz1BBbCw5U4zOemoxp4PLKm+x9K8DiZ2sBQBeQWUCbwNGLZy1IGZ3imoox+25NNQ9zoBHrF20Pr4LySFpUIQghtrNDMiTb6YVEHBadfu+0xXZSbbvzF5oLY4ivdB8nbjmz6bHVNkS19+esXgGfKR1JvSOuWw/coTXA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784774907; c=relaxed/relaxed;
	bh=L5nTYn5DydJnT1vSxB4ZFr8dxNjhvum8jXttXPqXX/M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aZh03T4HjR01X2cOmSfT7Wo4NTZ8hL340gwsB31xyieeqpD1MZAu98ig0Kz2WW16ei0QFERHUSvpOzXw8532EkZUXKnWKXOcgNI7ZyR6sFTSaHw0gKKTGm01d1ewekhfg6RUs4hDb4JUeCizXnDZxkI/PQsUZFmh+pRn9ngRUP1Z9hwQVed7T2yh7cjve69B8m0IjEPrKsw4dHluCacsuPORhFqG29/gf+n47nov3y0wMIIrvVf1Ejyy+uLedyExXeEKMKmv3spe5WGO8Rul1nTDx+9ZRw6+UAaXBtNCM7T9Z+L1EJyFwp4oWPUTzhTNq3WneCvIFpcdcCRHCA4b7A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=MQPi810y; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=panchuang@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=MQPi810y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=panchuang@vivo.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5FtJ5Vrpz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 12:48:23 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpuiKAPh++xHWy8PitYQQEcNmukj47UMP0Gg4Ru5NV7Vh077J1HjE/DMtZNuS8OhSO9Oc68BV9wZkJ6ViuQ84HGw5OO0ZZCmVja8qsjgI1ioIu4iTdXthkjk2afhz40LJ0SMcfhc70OhljLLZOCgKPHAXLg+rzqdk8qbB8yZfhOC0LfbGGo/DX86uRhpa84/dAbrGRsgRnwuTEofG5toZ71UcUfnkyOwpcT0ZweDaJzdnymqGF8SF7W3aQ2lIu7lFBh9TkpcLEp8F7IB4QSPyKS8mtKwa5QSKB7iv1NDiUN9Jp6j7JNUDPib+FYuk8t89GvEk/0EfrI5N4QmvAUehA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5nTYn5DydJnT1vSxB4ZFr8dxNjhvum8jXttXPqXX/M=;
 b=tlJjJ5cDng65UYnI4jgxr8sd2DtneJIM9SHhvdHPHraX5t0034Rv2qmNFDzPbElPgiXWzIatAwmMpI5N/nBxFOu9s/UR7RNCO46KbEB9XGno5jEiqZYphseqC5vrytXSbtofDkuwuO+UBO65fEVWk5dH3wez+eq6CEznJc7Nyv+nvz0Km8tZo7fij0FTH7ftX2UGzBNDGEHyBZQw0pmS8X9+LjiNBUfnGOUbdK6IPk8pYWJs3mfWdFeoLCULKg4Wpu2n+Xq01RCXaweX1jDM74o3vKnTQ9b3Xh7cTr8mdgeuwLvXpkGoLAWse8DBpJyzfEEiI1Sq4jVn3xw3gxjCyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5nTYn5DydJnT1vSxB4ZFr8dxNjhvum8jXttXPqXX/M=;
 b=MQPi810yF231seKUBip6154TBnxgWr+soPxGPFXM7l/ikmLZz1bfXdyR4lC+luigbEvQlBtJwykXJULxyZwmDdbP+MeWuJhPn0mEDR0K6q0/fgVtWQYMD1g/A8gCGE2SdscHD6yCs5Pl3TwSjPJAtrEvs4LDMvjJkhrEp5SD/IIntsdodlVMmh3vvIRASpIDnU2/ZkRdUfFuD+pODTHaLX2B0IGVMKXS4aZYCqjooTIPdNbYqbF97x762xzxmsI2Z7t0ZyZ2D3h+qLHXxYq+TAFcySbu8XK08l0VJu8cY7NEZrDfjebKf9HfIvstlWWxlXEaNEb/wzcMFesos6B6cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SI2PR06MB5339.apcprd06.prod.outlook.com (2603:1096:4:1eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:47:58 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 02:47:58 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Roy Pledge <Roy.Pledge@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org (open list:DPAA2 DATAPATH I/O (DPIO) DRIVER),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:FREESCALE SOC DRIVERS)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH] soc: fsl: dpio: Remove redundant dev_err()
Date: Thu, 23 Jul 2026 10:47:48 +0800
Message-Id: <20260723024748.30105-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0026.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::10) To SEZPR06MB5832.apcprd06.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SI2PR06MB5339:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ded8d3c-6406-4f50-54a1-08dee864ce2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|23010399003|1800799024|18002099003|10067099003|56012099006|11063799006|38350700014|6133799003;
X-Microsoft-Antispam-Message-Info:
	HRfW6PzBiAhNCrlYeQvGQApF6u9VUkQ1QgejyBaihKD3XprvLrxUinYqrfLP+Te1s9Zwms3wqnd6yYrn88C4FCL+XzrqjSQp5YXvTqQyaPLd25qG35H7EKcBavlpVZcTALYYf/YopCl6nuKB+zmUr6ceplXE3zpT1muDor3If2WVzpHJBXqGrTux1G2eeSXkt3dSI+8OORgFZ5X+h3Lj9X1shFnt7LXjiB/JdazSeGCDjZfJf16QHFJQN9XzHWGVo+vk7QRYcYsvcfMHdPzCDhPoFp7ek4rgMe4AbXCcHLXlDunrlBW00FL6XNan5bLc1pq+jgtuI8tG/WT+uFgUdOoT8f4arm74I795I9ptuDG4u8m/iPU2QxhuUVkpglsCqRgU5dSBamvSrls5Jc42Y9ybREfl8fX3+qxGKj0dKTpPBXvESEoZ8wGjkPYUonkICgQgAsAbN49qbjXs+zzoFkTKhDN4w2BT/sibf258YfhOxnoMz+UZtKrFjPcljlXOM1IZEsXdFi4kwpyiaxi3HR/BSv70sDFjpNZn6l9r5vY/LHD5iZHjpystI+IzbvBpwZAV6QaFI30F4+rfIAqsY+ltZtGrbCPzN+sBAkZ9ndgpBvfBIfDTMNQa5Zs2gAF2WtJtI5usxCoZ0cIRwnNDuN4+xwwqhXxrlrPXFIoFGOGrzUvrRMGdkZa5rJ8x+ICferUbpOHSJV284oCExCXaAF5wMj6bW3CO51RlsVWdmqQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(23010399003)(1800799024)(18002099003)(10067099003)(56012099006)(11063799006)(38350700014)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lXBHAWkp80E95u5QAA/daC634b4cAMPeScA07E2JagGfsu22d3fc8y5T6w8J?=
 =?us-ascii?Q?WouvRUoqvLsaAZ8P3cYUgLp7iLm2nxElFKNtsUpzzIVSXw+PLgxCVWNLT1Yy?=
 =?us-ascii?Q?JpoaQJWJVwuLMbDA1tdUDbfvdKUG0ZRCN1XHWfbCV/MlwMHdc24CK5up9tWc?=
 =?us-ascii?Q?qV5VDeHBOg1ONaVgdZFr6mjhi0dXNp48LQQWbP//7DUH7B4NHckYVFvpwdxW?=
 =?us-ascii?Q?wgnHyhLmtkU+YymN7PUmLcDXza+fA+UZpz8YQVf6xPuhpWWYHWkE9RUolN0X?=
 =?us-ascii?Q?XmY/T41O4Cf6u1OfYg9p4gU2oHMq8h0ySiY2hZn0Nbfigob3y2QPbSIFw8OK?=
 =?us-ascii?Q?SQ1+i4uc5WIjHi50uQl2dPBq21A10bZxEpTFGw9Q3ReNQL65vdKI212NBGb7?=
 =?us-ascii?Q?b+K/8x3FTpAEbYtr2hUynVR8mE7zraPzZdvy8oIhpFwT7lgiXMazYQ8wtzSI?=
 =?us-ascii?Q?yeKzzr72nxkuhfgb07Ql3TAKfCd0ULuuBXrBFjkZM+cOjYLgTX4T6lxvfxNO?=
 =?us-ascii?Q?zOZSQUtK/h6ZSDn+SztPSLKCV60VrsxKHvgYV+GSOYgFoxPvT7ajGbpy1yX7?=
 =?us-ascii?Q?QCIv8lCi/goOY9MrKZXDOD8KN53PHyQijR6FAYb2ZmICOsGQIV9cQ6QiN88J?=
 =?us-ascii?Q?ZgZZqDDfWgX2UkAH0ZlUVSy54j/K6BmroFzrx0yGIRTgONhMt0MKJC4Dlkqk?=
 =?us-ascii?Q?9pER9qhL9nxEI061R6aeHQgv//n9AkHOvx0NdyXlrHqbaPz6V95uzWEL96Rv?=
 =?us-ascii?Q?1KBaKgY2CCWIMAuPHYlQ7gx8mhQO3hASLzM8sR0E/K6m8qTPv3NEs2SrDY4u?=
 =?us-ascii?Q?nW5GM4LJbKsYe3ftAH45WEYLqY25kfsQaKAxwivwibISn10RX7PuXcP/P+P4?=
 =?us-ascii?Q?5j8HtoSBcXC6mgxxDm/N5pRIB8KVmv1dsqnNByrzqkARcizKzbs5xQ1Sz2Gg?=
 =?us-ascii?Q?swk/Fy+FvphCktmbDfSbZgxMgA9b8PglbfsA8GR/c3dUAF/u2o7KpeH4fr8s?=
 =?us-ascii?Q?JN0pCk1DG1E1+CoPQlMs20BIBMp3uBYy5kiCEgfY6jg80UIzuE+1mzgPhNTO?=
 =?us-ascii?Q?/d4jtyrSHfDGBre2pUZknGu/UZkUewghgirfrB9ikiRhG7GRmV44ITRmOjP+?=
 =?us-ascii?Q?r6vOkE0cv51Z7CMVL7xaEvHAdltr9GKju6bnzVg9pDlUdHyK9SSKubvcKsol?=
 =?us-ascii?Q?iQml5ai/Vb0yL8tCkg64U1DN4iKv4nW8SIrd2SEp2eB2oD+ikLZWNeAYz2Yg?=
 =?us-ascii?Q?u+s2fiMmccjxz8BgJzjwy7X1zv5lKnWTlq8moImuHlxgMrpUsHq6pfolbjk5?=
 =?us-ascii?Q?EpbRSJdotAqDBaC6fKmCvo/GL6TNQjhbR6/AmDFamMAv1MGGCvAvkOzI+YOZ?=
 =?us-ascii?Q?ygY5TC47HSmkocj+G001sA440ZHT9Uy1Fb92WLrOVBQGBWtxMD2fqaFX4WgZ?=
 =?us-ascii?Q?q7sOu0D5t4hVk6W0h/bPxiBT9TdYiCgUsa4g8dRFGzDu+X3EMPO0JWeF44+4?=
 =?us-ascii?Q?BAfteRK+UdvIqcIKQB1R677PkXRmtTCF6dg2jnxrB+ChYYNE4S0SvY6OmPcs?=
 =?us-ascii?Q?DQd/DTGOEd3ACXbnIgI/qJh+TC7T/wHv8TZ3TfENQqVdIglF2cBp5UkaKlMq?=
 =?us-ascii?Q?58EERe2xfL6NqEWGCwNkCYZKYQD1JGS7dKk4kD6lbRIgUs7//TkKF4YZh5DP?=
 =?us-ascii?Q?yZw1/PDa/UbB40s2S5x5Ownr/FIcLQ3ub8kYvUTOdPZC4Z8aYArs4Thx1bZk?=
 =?us-ascii?Q?Q/Ew2tHivQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ded8d3c-6406-4f50-54a1-08dee864ce2c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 02:47:58.8114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pkl/iFAI/X+g9/HlOrUi2RzdMg3dmEpr6ZYeWUIMHMpT32BJKiiVAdesV9RKOogIqdeOzPlIpj4cPy668TUXLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5339

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



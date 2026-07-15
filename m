Return-Path: <linuxppc-dev+bounces-24293-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E35CC4450A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 02:44:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0L8s1G2Yz30BJ;
	Wed, 15 Jul 2026 12:43:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784083437;
	cv=pass; b=exmH2sblnTLE0T4L8ZGpLq47FCnaAcAJXXXLogFqkacMeCD2LTN2d5bLqjirVJMMok0oT0IB1hPUgpAaKihSo2+EcTqVzH/bq7HeiSTyeJbwSE72mhUr27XmE3nY4q0QoBjanPutjLvmMNUCrNJakaNUPQmGza0UScDXj8zLSJghKcxaKJlDju/xIYs3DQJUyv1kg6sXhDbIA1pxB43XReHsDq3ne92zNNnxV5WK9MjXWgBfXdg1OYUFx/bokNG0UFqxT5Kp69Q1S90ThZE9XlktbABTjH10QXKi73JTefCTWdIKbEPmAB+VNIDNoZcALydf+FZ9Sivy/B63rRGuZA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784083437; c=relaxed/relaxed;
	bh=lOIgeugpdlNs1eZ+9ykpSDyxKVn9Q33TEoTDTfPSDkE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YvpM9pFH8wf8hwdd707/npkM3AQ7Vi0OXsw5jfOcK8uGljLPJho5naXetBemD3bMwo/q5Ii7VtFK7IXnNt214UcbFI85EYvN4a6HA69d1vP1rrj3jbRMFhwOa0yJBkDXV4R+ck0sjU461J2K/OU30Xf0l9iy0VlJ8iQkQcRyv/DjdkRdHirRVCpIFCl9VRhIbGf7xgrqZVNWgkLURobpYI+NZaM8cTH6ZHAU9NmGsiMF1FEGiUX5vCiQESc0stVff0QpE15ANVVbFVqlmUnRTmXWaBqUx+7pAI46Zry7SVY7Jm9Yc3BgexLOuLhniKhdJsp5uwWYdOUL14gOfqkP0Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=hoFZWQlc; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=hoFZWQlc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0L8r31v6z2xLk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 12:43:56 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2cXI3fSal1H1DF1LOUmpfT+3FRF9NLgKNcSo/xeI7yuxKB40ZvRccES3oAGRRlzt6oUT15hKbkQLQnMY2QBiYSUJ5yvZ/Vy6BR5O3D7y70omRuTtMM+SpH8BBq7MN+fbvYUTY6V76QobhsZaUfkRmE1rdwsCxTQ9FDOYskVixCZS/CQevIvTGrq/fnUyxk7fvfuVs1rn8TKfo7fJ4mWl9fYLwlC3TqlHEr42cj/PRy8bsSSG4cbalmxoWl2z5OftADw3L59XvsX6KqkZcA9X3D1Cvu5VmK87Dj0ycR3ay7NngdGElaupXq0RBs0YDk7m9/tddsNIe4YJFFYzYjnBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOIgeugpdlNs1eZ+9ykpSDyxKVn9Q33TEoTDTfPSDkE=;
 b=SQVtVhbekW7NuFn7aPFm6h9wyS6YVn9XwdPCP8zsu52pAhexvfXTokWYMUfG5KNEpydRryTh2VQldIaS4MIxQzRlNwom3iGXVcMbAyZr1hS5zobtsdgsIdzis1JoN91obOgJlzfCT5VWJdjSo+k3gDhXpnOuUQ4dm7JaZy6ZtMB9/nIXXWcn5EaID/J5OVWaoSUIXPxUbuf88TeErxa6HQ+UOX3fmnjr7vpTKA1FdR7e1ul1sKOMlxqqttUUSEh8mCnUEVwDm5CJqAU8H1br9snd4JMeYXuOH1nnYkdsZUxA+WVE0iLRmQV7ltML4qFmrgHoK8PwBXIlpqqJdqGqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOIgeugpdlNs1eZ+9ykpSDyxKVn9Q33TEoTDTfPSDkE=;
 b=hoFZWQlcw5OKS3k6mMS67IpEYf6xGaTswAlNfwsPYj9YFZTalf30tJb7cI5l8LpAI5KaZmYhStr/5WhGbeMFKdCH8+88AlncY3ZGubNXShZ4eoR/YVP+fOPmnKileZ+PxZWnq4qGn9INpmFcUnTOzyIrR4lBaqgGIP8ajRx4QBxyhyozcslhgn+Z9FfcSn3HKhNsLtCChJLGDfbj97FceIXDy+H/YroA4oxwG8y1+navx1yrFBUx68hAuIajiEJhx1IAsmc8E4AFoFQXp5h9SbYNXAq3LtwC/dyv7hFP1jkjlTKFr5EKwBpAJ6FL16PVytFEAj7E1IUXft6UguO7DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by DU2PR04MB8583.eurprd04.prod.outlook.com (2603:10a6:10:2da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 02:43:42 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0202.018; Wed, 15 Jul 2026
 02:43:42 +0000
From: shengjiu.wang@oss.nxp.com
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: fsl_easrc: fix m2m_init error path to use goto instead of bare return
Date: Wed, 15 Jul 2026 10:47:58 +0800
Message-Id: <20260715024758.1252801-3-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715024758.1252801-1-shengjiu.wang@oss.nxp.com>
References: <20260715024758.1252801-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::7) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|DU2PR04MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: e49be4c6-2db6-4d07-1afd-08dee21ae24b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|19092799006|1800799024|366016|921020|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GjgRID81Cbny9M/ozrl/q5UwSkM9FSPjRffoRhKQPG2cgyQeo8h6y/7T5Rs+rZUyQvd/KU+1ds+Hczn6FnX62aMhx030JwJk7Uis/YyEhSnUsXrqIhMbs4jBK6efSE95CiyjaESh3hN0UhuD9LLmeiv8kV0eYuRqADUun+BhRKMmHPGrRqpEPCsMBC3l05bjfkze56zZqgzVCqtZYux9oGCZH2/BxYtfag1cwMKxyT9H9eiccsyjpdoF4L41opV6CJ2ZBOyqTw5FGKan3GhenhXuznLLvKcTe7ELxHwCh7Njn006TtQVeGNy5aYhZMCRZyhCTRhIDRRsHtTL/OgupObkRPsZjiTzJMxfT5e+ifVclI/QGUcRvupYGrp5YN/IvJCBkKGO0EVP5NPIi6iLhM0eCEejapb5y7QFBiyHos+hnPGbDAToRW2vOvhqzNaeMr0md4Lr1Fkrk8kKYX1CoCadDj+NRLeV6ycbJOFevlJAHoolX7z03Sc/xbNCB/skICNlaeWaPTWWD8HozFIGBjCpPztOPWGsJP15agFHGadOikfvAFchMoJqNhrwF5hCVjWJwy3pwaJbiBfe6EnrDBAM1ZACOCWM6AHrG9xwe4eVYbD+s66LfN/gW8M7ndHPvOCkIVI92NrofqK+dZ++lYuM0gLU4B/fR5vtAMxJAwZLIb1QFOoITqL/vo7wtxj88hr7EJF6NJICqGu9sGQqEw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(19092799006)(1800799024)(366016)(921020)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PyxneOanomxThuflHv8MZZndbI1zta2pvK9VMgBWyRh47n1I7bn748Rvrsyn?=
 =?us-ascii?Q?WBIUdxFb56KHKOnJDUMSVdtm8TtKfbqYEM9rz04K+SEF/vQTXAT9ShE3t75z?=
 =?us-ascii?Q?vv2Gl600acCL6ZovxV5Cvy8JcZrsPioTFigqUHpbgfx5h+du30+Yz4uoA9jd?=
 =?us-ascii?Q?wbwYxsPyeyEQOY9tSB+oD3p+Q9lg0sSBXiWxPGdZjPS9EJG3VBeGphZjzepa?=
 =?us-ascii?Q?fdZCBb40xzLTsZs8KI8opHTC2T4SusPR0AaN26pjEufRNm3QqziL8IxjSzXp?=
 =?us-ascii?Q?GPikHgr2vS86qI8lsJR3blEX0Es/uN3kF40Qe8WAp05o8W/KKYSyK7iHVAHI?=
 =?us-ascii?Q?+P1gLjJVVIzEc98AO6YEsCsietZcBFGm4JYdOJQgSOMucDySCNIto+h6kdpb?=
 =?us-ascii?Q?oBJJue0T8PSIBBy4379v1kUuxQZvMXWzhSjT5KVOIwcqPw40UyuyNH/UhrRF?=
 =?us-ascii?Q?VseQf7GCcnA7O9aU9WnLJzaPXoI4TL5MuOt6Y8x4FhEJYHeRDhl2RTlQyCoR?=
 =?us-ascii?Q?O2ejcrnlov6osrNREO02E/KtkKqDs2/CVCv6bAtLT6ey9nzscC+GtMjaY3q3?=
 =?us-ascii?Q?CBwedcNtOYn0ZOVwAaiWFn1sgZf9rQb1de2w0ZRqVAfGhSxuugkVUL3k3ULo?=
 =?us-ascii?Q?Yv4TqXYbwdrE9KKXFGtShCXCFed2O9XyX/zmX0mexSjEInWRszJMAoInZVA7?=
 =?us-ascii?Q?PMc3z/X5iIGW2c1Nh/BRLRwVHwuf01IKZ0Jl88AH+6YFg4TN+mCG6jQnAHmJ?=
 =?us-ascii?Q?dgRmuFf/nCyKftLEFmBrOAhFu8hVhPtXzPZ+a7jieMeBI9+8MOw9jQt+gm04?=
 =?us-ascii?Q?NKLZYFjXEVjv4TJXLo+kgfhr/YJDMbSNUS0SE5lE+x7VNlKtyZXaFF7r4B9i?=
 =?us-ascii?Q?paKNuAgGZ6GTSNQnYACnJbBOQKgVhyMrvtGdD/Uuoy8kcSPksgL/DhUP26Ql?=
 =?us-ascii?Q?onJBDngHOve/a2F73t95GBDbEkeXOeSXmduFpIrE1RibaZ5Psh5/gvGPgUl7?=
 =?us-ascii?Q?8awPp6E7h2IGxaAhjNa6JjbW1etI65NINC99pi+GoXLFBx/WITFLD4FsPUdX?=
 =?us-ascii?Q?EIzgwJasKEphdeo4f78WpX4HrrrsEtleIFOgZK5t8YWljTvsxpbHoVudR7TC?=
 =?us-ascii?Q?pNx/L2oHVHtiN4riTMeZRO3SAr1Sr3k9GoV5oyK4O0vtLgSWQDqwFpFfT8PV?=
 =?us-ascii?Q?QT0ZN/wG0st3Id5ZJVVWCyuHxphOTz59kldNsezRT78DNmWz958E1LZcz7QA?=
 =?us-ascii?Q?w/28WbNLwzfb2CyGmvAV3RthsFh+4s9n+mGJ8XTuEAeLGdOBrWuUDR/+Ob7y?=
 =?us-ascii?Q?K89LKGdVHsS7SMtx+NDRXWU31fQZ3xZnXqwVZZkyMrqOB8gIBNn0HdEK9iuj?=
 =?us-ascii?Q?5j2//EsDPg5k4xJRnE6Vz0NUCAyCjHtHN0bNvThD0dCvdEZ/h+YgA4MKsmVb?=
 =?us-ascii?Q?vFFXYFjjqSA/7d3n2PSWjEDTh4eP+jBMW+xEC+SQKkVK6R8iEfsiH2GXo614?=
 =?us-ascii?Q?0pRUCGU3OVqcNDez90f5p1fB0zJ/mmqRf1Nfc6bSaR+yokqTVmMXmLOkZL/y?=
 =?us-ascii?Q?LODD9Jhie3fLtZjKwoV0GZdFwv94PPY8hIHbFo9HIACxg1qJVa6AyyBZTlH6?=
 =?us-ascii?Q?C0z3d5R6dYRyeqFUAde9w5Jq8iZFuz1AtllSDDKjWI/QXjKEaSEAOAH7jtwP?=
 =?us-ascii?Q?/NhQgcMPtXgHNZVmhXM55242+XCSiGFMoUC9fvWpAG22USpBRHoqyCuk4WZB?=
 =?us-ascii?Q?f2K8NUS/S1UPt/d4qZMCBi4LksBn1cXPliVKefM3abEDhkXt2pWR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e49be4c6-2db6-4d07-1afd-08dee21ae24b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 02:43:42.7889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjuLoSv8w4o6pxK0fPhrVGfnTPumkcii0XmvTMf1YSi4IKiaBSkbPnpmfInlskT/xTXy4e6DkxBInbBQShmYeuMsZR7Skhako1uh0R/h9g7RvONnQWyHF04ZaZRitJS3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8583

From: Shengjiu Wang <shengjiu.wang@nxp.com>

When fsl_asrc_m2m_init() fails in fsl_easrc_probe(), the code did a
bare return ret, bypassing pm_runtime_disable() in err_pm_disable.
Use goto err_pm_disable to ensure proper cleanup on failure.

Fixes: b62eaff0650d ("ASoC: fsl_easrc: register m2m platform device")
Cc: stable@vger.kernel.org
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_easrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index edfd943197a0..0d8bc3a9ee08 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -2261,7 +2261,7 @@ static int fsl_easrc_probe(struct platform_device *pdev)
 	ret = fsl_asrc_m2m_init(easrc);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to init m2m device %d\n", ret);
-		return ret;
+		goto err_pm_disable;
 	}
 
 	return 0;
-- 
2.34.1



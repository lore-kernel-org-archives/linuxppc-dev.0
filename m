Return-Path: <linuxppc-dev+bounces-23191-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86EFC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 12:36:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqN0w2yDyz2yZZ;
	Tue, 30 Jun 2026 22:36:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782822960;
	cv=pass; b=SPD7PezLDnU8UzgjfVh27hbtGysEaYRY9CxPaAsIb2Psb1AH/msxie4OZJ6MkXZUhL+vyKNecAVYwd8XYd1Fw7hDeqppF6nfddrz0nl9vB2WIYPTJEAImx0Ar+5DrvzhX3IfD0JHFYBlNBIHg3Z6UGvNdjAILj2BNnkt8rkpb9cE9BUqIsSMwE4Om504AUO5ARM6jYl+70yiTnVQxNUksVsw+kpRS7Um9kYnYa0e8yV7k5CB56BrQwLLzlNMpIG6zoxWXg/TInKVZTEq/RVNo2sU+xcKjiSYni/fk/s3OGb+Y+2hnHVsTv3u7GGoSZsKuSIymC+zM+mNUTB/g7l6vQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782822960; c=relaxed/relaxed;
	bh=rIX9yQuXazTT55tOiPNwB3xkzORBainoVimaa3L3SzM=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iF7DQVlQJy5X6GtajvOpGZoHbmjkqoA7uPvRHinK1co14Vmc+aF5H2ieSd0WbMdXEPdyjx+IBLQNujZs5wHoyBjMSuPPc/nPt+lBBFNgdyK208wjNEMmbrODvYUsFqAJrFkcp/csjssD6+54xeGViM1uPTAJzCDhVx07Exymf3iwe5qwQi5FFfjyugQUVEtEQSgXygKErq+wN/zIg+B1qEd0RAq9UgIJw4LLVo2ajoY1FYahqOrjAoVS1ELyn42sUAzVtOgfxfqURKexu8hOmhclhlWMWLqPZwdC0mJXhntDdpuPgGZ1SBKHBKqdKlQeoJqqRMoWEDIShMrdBfNAJw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QmF/CO4d; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QmF/CO4d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqN0t4yFPz2yZ8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 22:35:58 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNvpGWByM8peNZsyQlSd0y+aBbVUnPVPfYVUG7oUry/F/7q1IGQmjoRzveP8aqoYSb9/ZBdQg1pmlM0+llQYppxjjuaqotIVtrVSxsO8/Wbdi8wDAlMkVHeHSbO3fqCYX6KFPVOQsYdM9KFL0fS4OR7WNSta2q+w+iE+fOHTF/mssHHIds7uGNrn6FcgZ4hdfChP8LRuMj2yTWKXRCk/0q+fPg7irooj4q1XV4bB5ZF9QXQzEdZk0M7Q20D1lh0VSARLuT55jToStby1sNkMiYaUeyWIP0ou4YHXj4KzS7kNTNsS7iRoxsGu3kbmhKKLD4KS8soEYWg0Y+loaTZWZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIX9yQuXazTT55tOiPNwB3xkzORBainoVimaa3L3SzM=;
 b=KdLo/3FFzqsl+2B41ylBtAaiFBkz+UoCgmoOmkCsmHAEnGYVzszsSZXCClB4BL92A3gl78HLBbrV6fmzVGhsJZ7jRvV3jGorxuwocSyp44fk5Xw5Bdd5PN4i3bIRav3G31XIEI0JDte5RLMf/Hm/m9lDcNPsbXMQmS2RtJUhwT36AUivKd3srCGmOzH9zud93xVqPAwgpjGITK/r3DAX98VbUpsDfLx+A5xPe8RnJUwhV/EzS4XCig2STYC2bMqEuL96nLBAYYiuJnSSKQzmk/CkKZ3OqkQ6W8Txka2sEKccx0sGu+XV1a+IQavwcCSLyGho6TqaWQODXxf/e21Yzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIX9yQuXazTT55tOiPNwB3xkzORBainoVimaa3L3SzM=;
 b=QmF/CO4dEruhtqW/Tj9KXF8HfW9eB3S5TNymbe86H08qTfdBcIO35ICg9V9+dRWsJ44UOlyiXGzN4H9t6rrcBSS5roEuO5DVtv5PIvNiH75e1OZVO4t7LziuSWg6KDqJSPXEd+Q8sxYP31OniNxW/TncLzLAa1rKycfLnHv4/rax72ZejpH4h24L+tzE7wij6yPRlg7rNDtJg+/3evXTVY1FUnh8cIRxghvOvlzD8V8XXmJ9qJ9fU1d4FLHt9hskrdxDbwpFKMoggxeOZH+dQOxUXZPEpg+rpaD822eUPIjfxVRcGS/TwFI7Z77+SEC8UDrO2CfvGQaMNQ+JRLHp4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by GV2PR04MB12582.eurprd04.prod.outlook.com (2603:10a6:150:36f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 12:35:28 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 12:35:28 +0000
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
Subject: [PATCH V3] ASoC: fsl_audmix: rework runtime PM handling in probe
Date: Tue, 30 Jun 2026 20:40:16 +0800
Message-Id: <20260630124016.645114-1-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::7) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|GV2PR04MB12582:EE_
X-MS-Office365-Filtering-Correlation-Id: d62fb861-b1ea-46d7-4f75-08ded6a410a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|23010399003|376014|6133799003|11063799006|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	eNdoiqMkkqmodxSxbOyoqruFTDar0yhp330mv1CUmYsreVuPTWvviuBXjxPPa+mqLlO3C3BSvcH5glzIlaiR4UNHKe7UbI1SGjhN0Vt4dGC95zul1hHdhaObeisRkvR3NOtoRnVQTfZinH74f1ccHN4aUeGeQvY+ts/abUr8OWy0uslRdDznHlbFLoLfJO0lhvwV7PCMyeuO2SmBuyMcq9VYcizL0uOOnpTvw3I/FmD06Z21N2grY3/1NtKaPdx5E17rTPpVQOVTH/exTjvdU8yeZiGMVSPyo6QYm8XtrWxZ28gJpuPSkL/sUIYlBmscXnagwWWmg9dgjqkYLtd7gloRL6R56PUHTyHfbdZS3JEh0h+YlRNeeEsHX8+hyr/arWxuaIJd8XLv6U3yCrCKlkTmHVOIUvquubfXk/wXpI4MyN/FNhS7ULnR+lCk8cKchg7gVfuOP61qFwPIExD4t+HMbc58gSt85R/XYJAYqNPQYdr7V7nL11C1ujoXUOOQ3GaYKQ/5bf1JnMwroUpML+NG0HTQugMGKfAmArwjcl4uS4KWrKMcnEvHw3h8GsIYMI1AdE2paZfkdSaR8gaxEmAnp+FLZdfAO5w7oibMkNo9oHSF/QpB8XRdvX8w1lqYP/caP9TtjOZU/hWFYTJRQhkNMHqye7SMkSTyB7wioRNkBOX1mALTVHWDJJQYvNplnL9IZzNthh5iL+v2SB85Lg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(23010399003)(376014)(6133799003)(11063799006)(18002099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Gn04st/8T6YPGdNsNQpRBfjrRBXQ5vBHHZbOZ1fUdvXNGejyXKcNoJ50Zep?=
 =?us-ascii?Q?WbxcjDYt/Mtn8MyouRSVsza1gRuP6Im2hSUvnnf+2ulJks7ApFwUOCX4NMqd?=
 =?us-ascii?Q?xAOwkE8qZWzO3iYnzawc+9Z8KU9s0ujdCeVwgiwgVc/qP89UURZL0vl7ERyS?=
 =?us-ascii?Q?Bnr2af29JLnvbi0drHbd4X1gfX9sstrKkeWepzQnLNKAiwSUejcaDM9/rZfN?=
 =?us-ascii?Q?zwK67FtY3tX3a3olCPp//IHu8oE7BpCLqyquXz924FD68X0ZdcuKAq+ktPdU?=
 =?us-ascii?Q?5kItu+nDSSJl/EqfKiX6y91Pfet0MZoa8u+uSDW9DF/UDCOqLaQg8Yn34N8l?=
 =?us-ascii?Q?vLkfArx4KfOY45OGz28v2K7SZi6pRYmlUhO3MGg5w+m07pQvl35QbjOC7iGQ?=
 =?us-ascii?Q?NASj6uD3U2hlziCbPAvk6BK+jKuDJHfgf33xrdd6lPfAPk3T1tP2SM2PIXnv?=
 =?us-ascii?Q?xtGVNsGL0wwHLWbNqupuQGU1g1JkcKL/aKK4Dm3ubigDcDJLoKU7gEtpx3hl?=
 =?us-ascii?Q?YcKMhW6yvTLd2yP5tpkZnYMcqwY/BsVPpYkA6BTGgFns3n9uPO1DZrHIgNDK?=
 =?us-ascii?Q?gyO9H+W+AYhbaGzIfrfj7oy44eJRZuAf6yMaFgcOZUN8CN/cAmnZjKn6NNvA?=
 =?us-ascii?Q?8cE4ImeCOhpbPxYrGeEw9af8dGbP1w4ogPku475BpEEls+lHOXNRMxe1hwyo?=
 =?us-ascii?Q?n27Gi5V+/BR/WHo+6snTvW9zPoIMafWIDfclNYefTc2T3elM6S9r7ne0adRg?=
 =?us-ascii?Q?sTpz+9J6QcT81HDaFz4S+xWTVGLSHp36zq+jO8ZjfKlqYb7DD8DAWMZgIbsu?=
 =?us-ascii?Q?44smHdHQuynO9t9ILBikM3uzFR0qm8vJtdbID7xFB1+QEBpBSMeLQ5KA1VQd?=
 =?us-ascii?Q?WLLRsyPJ/yXxTkDF19VlIQQh/e5chJjti0REXbBZCW3KwJvBFg1TcoEGYSGD?=
 =?us-ascii?Q?W09oyzIDkfAzopXf+39yEkeT6zMG+pgGajgvo7ctWj2AmOiO1PVzvEwBhxzq?=
 =?us-ascii?Q?N6yce7AUOn5N5Ai52OIX+DJwf65OF75/cuuSCB4zDWYwitxMLSm5odp1D8Jn?=
 =?us-ascii?Q?Ax1RH2lu4B7wyMIpVxdz6MHa7vQgUG0hnq38FssHBESjnRp7AonakWLMRTQc?=
 =?us-ascii?Q?ZS3xYp+6K1yPT6V6P/LLbe/uJQZX3/WIIIAMk2OZuH/8ccgUitDgcdaT/Ail?=
 =?us-ascii?Q?XNvQXypaTQT2t1eMrMwzzlOeaoFPvJdm1JiakS0OFwuul6/JnuOogH9CWxCr?=
 =?us-ascii?Q?JrIxZPNKZ4nS9kN8saEX+FvkxRlLKuw+wn4ErgC6HA9F/xMi164NgM8K6XD9?=
 =?us-ascii?Q?eOBsMd2K6Mv3GqxQVossb9USccMLurv1ZEaTWcU5HA9ldmEnMIL3YG0e4sJW?=
 =?us-ascii?Q?0fY/ZDWHEsB6wHQ+izlkgGdKRMoG5Tdaf1M8Z0Rn45svnSXfCCeKOwq+4twS?=
 =?us-ascii?Q?cvqGew4RlJ7NRr06yGH4fxYzsG0HcrTELB9GT4+h0ssIfzpOoHFyjo7dT+6d?=
 =?us-ascii?Q?xX5om4MCCtHMhPulSSCfvN6xYFSyUqsy3xnYN+wNUn0Eyw/NQDK3GZ4EDRqs?=
 =?us-ascii?Q?CdY4eJPqtikvroY6t4S+bIg5qjm4u5Ge6Bb6fRpmz0LdECx/iaTi8E2GdHp0?=
 =?us-ascii?Q?XQm4WAZr28oaoNQFojKvYbQt+R6glY8w2TufA7pBcbR/32BxfPXnEP4yRqfT?=
 =?us-ascii?Q?lJl/1plCwJahGra1cBcdDhjgYYu4nmyopYdrjtE4hVsWKTpGrbnG3ljbYO9H?=
 =?us-ascii?Q?qxwiCJclFxMu7EKbqLm5TOcn/RA0Ao7hiZ9xiq9+8pAy5HScSTYw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d62fb861-b1ea-46d7-4f75-08ded6a410a8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 12:35:28.1634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOKkGK0Ie9H0Sam7yLF+dGVQ+liPa5Guo6hlhI49CpYkbXZUe6xt/bxXfn3QTAYZ6E5X3s/sFXxuA4eDf3sJFXyaFE0PaBy5ZnheiK/LGgkSXDUfbsLtDpiUzzq87Bb/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12582

From: Shengjiu Wang <shengjiu.wang@nxp.com>

After pm_runtime_enable() the AUDMIX block is powered off and stays
suspended until the first runtime resume. Register writes issued between
probe() and the first resume (e.g. from DAPM or ALSA control paths)
target unpowered hardware and cause a system hang.

Fix this by calling pm_runtime_resume_and_get() immediately after
pm_runtime_enable() to power the hardware up and enable its clocks.
Release the reference afterwards with pm_runtime_put_sync() to allow
the runtime PM framework to suspend the device and switch the regmap to
cache-only mode when idle.

When CONFIG_PM is disabled or runtime PM is not enabled, pm_runtime_*
calls are stubs that do not power up the hardware. Handle this case
explicitly by calling fsl_audmix_runtime_resume() directly so the
hardware is always initialised and its clocks are enabled, ensuring
register accesses succeed regardless of PM configuration.

Fixes: be1df61cf06ef ("ASoC: fsl: Add Audio Mixer CPU DAI driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
Changes in v3:
- address the comments from sashiko.dev
- replace the pm_runtime_put() with pm_runtime_put_sync() to fix the
  race of async 

Changes in v2:
- remove the call of regcache_cache_only in probe, rework the runtime
  handling in probe, call the pm_runtime_put() to enable the cache only.
- refine the commit message

 sound/soc/fsl/fsl_audmix.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index f819f33ec46b..f45d3ef02b72 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -457,6 +457,9 @@ static const struct of_device_id fsl_audmix_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, fsl_audmix_ids);
 
+static int fsl_audmix_runtime_resume(struct device *dev);
+static int fsl_audmix_runtime_suspend(struct device *dev);
+
 static int fsl_audmix_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -488,13 +491,27 @@ static int fsl_audmix_probe(struct platform_device *pdev)
 	spin_lock_init(&priv->lock);
 	platform_set_drvdata(pdev, priv);
 	pm_runtime_enable(dev);
+	if (!pm_runtime_enabled(dev)) {
+		ret = fsl_audmix_runtime_resume(dev);
+		if (ret)
+			goto err_disable_pm;
+	}
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		goto err_pm_get_sync;
+
+	/* To enable regmap cache only when runtime PM enabled */
+	ret = pm_runtime_put_sync(dev);
+	if (ret < 0 && ret != -ENOSYS)
+		goto err_pm_get_sync;
 
 	ret = devm_snd_soc_register_component(dev, &fsl_audmix_component,
 					      fsl_audmix_dai,
 					      ARRAY_SIZE(fsl_audmix_dai));
 	if (ret) {
 		dev_err(dev, "failed to register ASoC DAI\n");
-		goto err_disable_pm;
+		goto err_pm_get_sync;
 	}
 
 	/*
@@ -506,12 +523,15 @@ static int fsl_audmix_probe(struct platform_device *pdev)
 		if (IS_ERR(priv->pdev)) {
 			ret = PTR_ERR(priv->pdev);
 			dev_err(dev, "failed to register platform: %d\n", ret);
-			goto err_disable_pm;
+			goto err_pm_get_sync;
 		}
 	}
 
 	return 0;
 
+err_pm_get_sync:
+	if (!pm_runtime_status_suspended(dev))
+		fsl_audmix_runtime_suspend(dev);
 err_disable_pm:
 	pm_runtime_disable(dev);
 	return ret;
@@ -522,6 +542,8 @@ static void fsl_audmix_remove(struct platform_device *pdev)
 	struct fsl_audmix *priv = dev_get_drvdata(&pdev->dev);
 
 	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		fsl_audmix_runtime_suspend(&pdev->dev);
 
 	if (priv->pdev)
 		platform_device_unregister(priv->pdev);
-- 
2.34.1



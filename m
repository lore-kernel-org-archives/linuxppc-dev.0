Return-Path: <linuxppc-dev+bounces-22971-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6274CCDE008
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2026 10:19:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmFD855Hnz2y8p;
	Thu, 25 Jun 2026 20:19:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782382792;
	cv=pass; b=nVTouHN/WTDhbg1cqnNce/a9ZvnKHbjfNkM/EC5eXWoEU6nEzT+vnUDrIFcGu8GHT1ZxEI9LB+tHki4SZnpd3+RITuV3f7/Z8Gt/XsUW9A4xfwIxhwdXBzo8xFa64ZnMeFJCHAUqzqeusps+o68zodq99ebqOG915Faxv96n1TPMtdg1zOZOlOuIxqW6qqBZlp0ibXxwa45GFDF6t/o9aoFprzMgsZxFoKr4BXVY7fDGR35X/hRqYO2tWLyzoCHbP50Qa77vZdzv4mxhsuRjWp28qM4jwN2Jzt+HPDlInI4k4gx1Nzdo+httX3JTX0s7QT8vBAsKl1Mh1TjrSsXWSw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782382792; c=relaxed/relaxed;
	bh=oyjlMSV0kBhnLDimC4I4jO0eOwFu6CyJUqyhC5ytGjA=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=E6r4shcSZ4A+zH662M5tNc5ja1ML7rkr9dSnGeFUOk2w/dq2u/b0VRl2z8lk+riCI0Q71WLAzWKkpwl4u0AtNtaruRCdmB1Brgm7IFaUwRtCxfQEj1j0j8N7DtlUNJSTXXxJavx7oWpYzWkdV+zp/r5XquiMuV+EAO1JcsRnJiYjl0wQWcdLwxyzOnGT6NLDPnSgXtDhRKcrLJ/qtpx2EMIBTIViIPs9c6NsxtCldNm0oXHiazcwaDzmqrmd5s3Afmjfs/NCQcw48In3ZpUv6Gmpm6+0Q0bjh8yoTSXGhyNanMSXtc1B7Rna16sf2r07Mwg886tkeT7sfQKTmMrdFg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=tZ/aQ/oV; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=tZ/aQ/oV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmFD70Rkkz2xwH
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2026 20:19:50 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyYsQN6SIF7IRTbroWE9qnaJAs576pTqviFpHrI+jJwhaBOquZ97jJCDBCJ/WWh1kQe91nm27x8QB4U0r0F0UpetyBOZQqrZGlEDKaVc/rPM4k0JbExhGf0nla4Ck0zAAIR/0WYKUCtue/Q1tK3ZirNi7kS9W0pUod0eY8cd/r+GoWfh4PGRenYxBP7fY4A71U4OGhGZo2gIw8jTuhLh/339Vuv5veSlfVT6jNILRu/8PKzzR71y7ljhpEfSvRlnTpwdC4/MIlX1YmoDpclHpErvmgd+wTAjvK3PLKC3MS+X95viS+MBX6GcKrlCcb0aBy2DiJlGXTY7izGfHH8+2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyjlMSV0kBhnLDimC4I4jO0eOwFu6CyJUqyhC5ytGjA=;
 b=fTAuOyJvbtwuSmmnyVSVp+LF9+g0GBEMVOr/u5I4tRDaW9m+pRav5+Rv23SBGON1rUrh+qj/D0yYEyddt+p5+SZydFNUKsQg20qCxxX5vnjglQjFJmc2rgVczzEk7pB/umYkZIhgLXvGLqpM1vnCOjlDpMPf0pkz2VwZnzJ7KbL0ly+XFdvOJvj9QVOMDBuKyx5bfPY4AaBAteEOwS5MfnjWCpooczsq1a7Hd/jsQkzkZcxxgCF+yuDslFZh8oBpuPVJIj6wl15VlN1es4ppGGKgMKsUBjZTg8zOxjNh+0vAVMZwRkxScvh+a4KY42+5zYir9uPylTiAlOSVEe0vOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyjlMSV0kBhnLDimC4I4jO0eOwFu6CyJUqyhC5ytGjA=;
 b=tZ/aQ/oVcfYBu8OJn0Vq+8+LTXhJkSmTpguMJ4LI82WpmWg1wIZ6cuc72WBsVv5qqSrqbg5BEFTE6n4/WzYTTb0uNhKAyqwivYjsRVKpwMLAniFCPHIpiFpUFthKhTgG62EQQh4iYznEg+WJSFQSnvk3wxtp0Wndvg16PhDrYAL/lp26f//hsjR7kp6Ue8AbSIdyFK1eCt1QXXNzIOMmpOJG4WQkeGlHYHJpXUDiapXtnb5fvJfiu/PRi7jKpfsH45ABYZO7OAvUyRVPQdfhOebj9J2Qh1WpqYa6a3GMSxlaKQ3ifAOdrBa8we1HJCbY7ZXO6Jqw3oUP2QnFfLxLhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by PAXPR04MB8192.eurprd04.prod.outlook.com (2603:10a6:102:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 10:19:25 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0159.013; Thu, 25 Jun 2026
 10:19:25 +0000
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
Subject: [PATCH] ASoC: fsl_asrc_dma: fix eDMA maxburst misalignment with channel count
Date: Thu, 25 Jun 2026 18:24:16 +0800
Message-Id: <20260625102416.424911-1-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::8) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|PAXPR04MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c7f7fde-4391-470b-0eb9-08ded2a33b36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|7416014|376014|1800799024|56012099006|11063799006|6133799003|3023799007|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	Nnq0r7MYYK38uE0lSjRjdY2nyiEiEFNKIlYqp6eJyOFAV5rRZFT9A0TSLRTXVT2AH3GEjjjs0DBsL+XSY7wdFo8ZGmenGODPBvf6tyvqxhPhvPXG6b/I3nVA+TuSK8NfP2jhAiwRox4B2PECDH/bMd8GXxc6H9GgQY+gT6bUZ2oqoNp+I/QYiK2XAhy+amu8/ruBbSyrjNoLfUzcEZj61I4HGXZJ9cCWvvW8t9A+lb+N7g2inywOeDk90EfNRavcEAXGGrmyqMkfKfKYMFanRAX4ogyJMBxL3vvcXI7BPzz7aqZoMlBjnmBDWqHNia4hH9PHBsMqaIXgkibyvNDG6Zgs0iVugVsTcNdROApv8/4qlFr9R/8zlePlbXGgaScODY7+9pv1bcIHjUxA/dJZ5iKjZX43MpqBKnffL1ZbC7Qnu97QGzkOiJz65u1w9pJF4PaPlIGIH/qzlkW3wR37lvc52030q1gw3AOb3flRDdjEVEkUUTpI1cZTEdeH3o1f/hUq7tWjt/F/WTl/ANWkk38fxFgWDUvAccm4ZG6sza69PNbQPcqJBXE5HakvKDYrtOUXxwCd+tzBzIasYa93SeykPZtmSa5CZIwKrz6YcFVqA/6YWrDYOv5/wKXVpGYMXFOQiFsV+gU4ZLj0fCzKc6yHGCYsI8jWUQP1vXXDV6+zdUm2Uud8IPzdlWpNqhxostfWfIQWeEBz79k0gVtqBg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(7416014)(376014)(1800799024)(56012099006)(11063799006)(6133799003)(3023799007)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NIRS3YDKCprZl/iHHrPdQfgFcQUWUixHUCE2VQdb92q7iW2Gq/KFfOcOsYmL?=
 =?us-ascii?Q?j2qj10r5d69VJW4u6cewwbLqeaF/GGGKvnkk51CSsJ+0Bxv8pM/dvJ3RbZPQ?=
 =?us-ascii?Q?eNjwBG5UYpcGyviQKFeKVu37YZaZFpUqmOkerY848mffnHlofooX1L301iOd?=
 =?us-ascii?Q?jzdb0cXpQSvmigBKP4c1ePHjwJEbHe9Okjb/9AcBCadK2w1fgzCaFgEoJjzi?=
 =?us-ascii?Q?nawUHnO3/XogbUzSvxxWLrHlPwUrfzyYQUm3FTYLmcq+lFMOgnoALn1T1JuN?=
 =?us-ascii?Q?xNEEDBOWzmzrxcQp/7STKkaESnUfaRQNlsOIDzSpSaS1VdjEoNFcBzXtMQ4G?=
 =?us-ascii?Q?cwF5zz7oAkp1yLTsP8itbuMFzh0ij97nx7OfvFWz98WYyJWDn12uzlL3BdN+?=
 =?us-ascii?Q?F4TvL7CpCSLZZi5WD1nZgsv3JX2MpdjrvmZf6p0YHLhUujaRCxToTLVEj/Nk?=
 =?us-ascii?Q?+tZL/SXlHU9jJ5Wt6FoRl6m2KQAx+EZcCWNEZfV93+SW4rVSa8royRRn02lN?=
 =?us-ascii?Q?smtps1zOemORuakQN4U/NgJCXRFwiNQuaWKuvzSRlY6EtBns63np89u8/cFl?=
 =?us-ascii?Q?gdjotNhelasWUcWb1NBetvS3f7ZbIxm2LsHz4LqCl1O08xA6cjdq9ELRCH/8?=
 =?us-ascii?Q?L/LCsXT1VmrylCBS19C+Vrj+1XF9HXKS/t0TpwA83zcUFqucjDGzAT9J3bOL?=
 =?us-ascii?Q?HYmhgwyTTBOWB8HI9n/x//i07/m0VO/kSdauIaLmlVa5JZRG/HbSxE5KcTSu?=
 =?us-ascii?Q?Eag1RKXJziGQFrVY/hVLRzhLzSPtiGfvLIGuy6ZnBDReawvFTcRzuLG2KHId?=
 =?us-ascii?Q?WyCkRKThCiAyojfXwebfRRxFC7SIavXxOFGeyZRJ6f/vcpZ9fP4lnmlrX1A9?=
 =?us-ascii?Q?iLyg218HP0ZIwplQTczUtXRvzXbbhXIbBqFjXQCDl0191sKSeJJJWj6ik6m0?=
 =?us-ascii?Q?OShTzDp6LDj/O99ehHUzz5tgwquucAGz/iNPktZUXKoMdM3tbWMBYP89Pus2?=
 =?us-ascii?Q?B5aTPLre89nQaN9gq+fEn5pY7N2CrObXBLfs+diRnVEUrOG5fh93XuZNpuvy?=
 =?us-ascii?Q?mbq/NHpgUuRIenpeB8awJlpSJW04myrr3UcWagHkBlYMcjFffpuoF0dVfngl?=
 =?us-ascii?Q?czk9tJalTsL4m/tsBqltnZ45ttycYraSDfl6xz0E8OGo5slT7UC6ZuYWndwt?=
 =?us-ascii?Q?dh6UQBETe3y6FKV0RTfqjVcYq4NV2+VwFbbrbXnziSxZ1hxP/opihGwhFuhr?=
 =?us-ascii?Q?6tioQ7kdszcRmqUjUjn+qSapGPCJxcsW794y1dGRahPXrgTVhY41az5NQYPe?=
 =?us-ascii?Q?0YfBT/6EPd8kpm3h8sQmkXEAiHTEDrYUK9pAblb2iWnvyTDKpvryNyJsIa2u?=
 =?us-ascii?Q?hl2yluRZ8BI2VoYebB67XKyzeDoBZKhCgEX1xkLSKCxlrwH73CY4ek21OA6n?=
 =?us-ascii?Q?G6Pm8TCbGqSYbvsvlCbN4egD53yIQpQJJEA69LyPyMDQekWiPxj473hnZSvs?=
 =?us-ascii?Q?QSStbX186IX1WSzOsPH7C/7zD3DJuTP+lJGYHpl15Fn9hGuKO9ScFwEC+Old?=
 =?us-ascii?Q?TD17opfuOXhkkLfHEEwXmF6TkbkKhJbHAY1BzNRO7kepAmMgQ3C7otIIUbLK?=
 =?us-ascii?Q?3nKih47LHupUPYvEO/Yox4qPrLXxNESrBb1DcZLFtNkDAaoEqjqfNiq+tQ5A?=
 =?us-ascii?Q?MK4eswCzGqybLwgZ7FH5gnQwR/Lq7FSeVP4bEdAOXju0gfiYovu1URsqTdA/?=
 =?us-ascii?Q?ar2s48QCByr9OygOYq4lBdmzKKq3wummVOKobO7e9b73b8OYefoC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7f7fde-4391-470b-0eb9-08ded2a33b36
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 10:19:24.9895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7CI0ynjT5B6bICPSxHxdtHgxIFcNegVf3Mn4jS+gGcqmCu/pbB8ZndMvkhP/ReGXPKW/0xP5pBk+3xT24iYWpq/utqNKPb5EhlTAP7E1eC9ZDwNNVI58V/wwaVjWdjt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8192

From: Shengjiu Wang <shengjiu.wang@nxp.com>

The back-end consumes data in units of the number of channels. When the
maxburst value is not evenly divisible by the channel count, the DMA
transfer length does not align with the FIFO frame boundary, causing
wrong data to be copied and audible noise at the end of the stream.

This is specific to eDMA: eDMA only responds to DMA requests from the
back-end, whereas SDMA handles requests from both the front-end and the
back-end and is not affected.

For eDMA, when the back-end maxburst is not evenly divisible by the
channel count, align it to the nearest valid boundary:
- If maxburst >= channel count, override to the channel count so each
  transfer corresponds to exactly one audio frame.
- If maxburst < channel count, override to 1 to avoid partial-frame
  transfers.

Retain the original maxburst for SDMA or when it already aligns with
the channel count.

Fixes: c05f10f28ef6 ("ASoC: fsl_asrc: Add support for imx8qm & imx8qxp")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_asrc_dma.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index 5aa96af994c4..38f2b7c63133 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -288,6 +288,26 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
 	config_be.dst_addr_width = buswidth;
 	config_be.dst_maxburst = dma_params_be->maxburst;
 
+	/*
+	 * For eDMA, the back-end may report a maxburst size that is not evenly
+	 * divisible by the channel count. This causes the DMA transfer length
+	 * to misalign with the FIFO boundary, resulting in wrong data and
+	 * audible noise. Align maxburst to the nearest valid boundary:
+	 * - If maxburst >= channel count, override to the channel count so
+	 *   each transfer equals exactly one audio frame.
+	 * - If maxburst < channel count, override to 1 to avoid partial-frame
+	 *   transfers.
+	 */
+	if (asrc->use_edma && (dma_params_be->maxburst % params_channels(params))) {
+		if (dma_params_be->maxburst >= params_channels(params)) {
+			config_be.src_maxburst = params_channels(params);
+			config_be.dst_maxburst = params_channels(params);
+		} else {
+			config_be.src_maxburst = 1;
+			config_be.dst_maxburst = 1;
+		}
+	}
+
 	memset(&audio_config, 0, sizeof(audio_config));
 	config_be.peripheral_config = &audio_config;
 	config_be.peripheral_size  = sizeof(audio_config);
-- 
2.34.1



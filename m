Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5255606A330
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=UhqVvPPB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJMnW2SvRz2xLh;
	Tue, 03 Nov 2026 06:53:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793649183;
	cv=pass; b=opGhYSq2b5NgMmz5pnn3n+ivMeZCnOHcV+7cBI+pecOYFNDDY6kYL1QAeYM7ypQbi+SmxVTao1r1vBXXNiznwchn8KcqVky+9eaEFBK9wreEhSyoVljkOoY5pHC0H9Vf91jT+0VbtpZ4iScQIjqAdV2G+fG/H9A7oKXYJ5yzsbS+GuvW78AgI5MVrRAzrEjZXngGJPQY87lunwwfZmN5u/p824snp66DwwdjNcP0xA9TyU2nUq3uzj7ORoUqDK8LLgXoErQePTKT8xcBY03Xa5s6gCEA/8axHujbBK+Mu9P0uk/w29YmUtL9Qd+xkOHFU0OC1qvP8F15NQUYduzFeQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793649183; c=relaxed/relaxed;
	bh=X3wivh8RoVRyqznj0vKvpYqmlNEdu05DfkZ/ENPqJt4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iugPXtOpJTrGtH/7liIyzqNK810YCEDSE30i/tD6w2gNQyFmn23M8wsw5OE62UCeDWu+t+709eMa3noV0Ye177NBG/nlQMGnQTgGhP3ZXHx5D2C+csQmpIv2935+8iVD6nnb7X/O/9SIvrtNvLXDJaBTRc//E8nvQp78GnIb1kwqav3G1k0KdRXqrEd/aL3ub+uS3TtglO3ajUJyUG4avtDCvSBk1pEAEq7aiOKGiJure4Wq9TvUiedODLpe+xeANY7ZhMdXgR9IQFO1aObWPyHSbes7YUQX9heqQcpiTsi7duD4yCVJ909hulttTjXquBLHepBDEqMR0bZ1Wxar1w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=UhqVvPPB; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=UhqVvPPB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJMnT6YzHz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 06:53:01 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHkLIccpdrBm745gyHEoR4dNMpWTvYWw1BdpF3ZYZF/hVu38dHEgqKe3Ay5bIIvsFmDHZ7ciVpZNPP/4S76QUg5qs1sAZ4wxhnh3cUiO2rvKarTvmgR6oG9SnvT0sV5EijCID3fNDQNG5W8FOPvVf6aKDRrOnT443UCbbCdDI0fSJh1luRsuiHjNfFVtGboYsYSpCTS8mTBtJtg5L0cVav0ksP/HRpFjE6Qey5mIGyiFt2LDLsF7q46knWnRcu8SCgubWV7phNd9tmFWq9dWOkn/3EeEBV9xMmkSM9rGA6QuqPr1jU34OB2ZcAqRsQwZ8cUQK7FILIm44Zw8f72qLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3wivh8RoVRyqznj0vKvpYqmlNEdu05DfkZ/ENPqJt4=;
 b=XNZb/oNyxYGcXe48/XoptDVMqWuUmCpprAuJGyyTmfKahfQiLfRm8zZOX+7AHWZUSZCfO4d8Gv9Oq7bBSxPmuHxqGvi8nz3v5xN2bEaUoiCFrHqjsFyvKUiOE4DNtT8UFiTC3Vt2SYrn4J5mofPcZp7vAe+FA3CZl4+309g3JluBPoHuke2ro2pwgNObwG9yZ3Am05Z7paLuKs169cmEJ84SRVf8CHX8j6Deu1a09pWwfY4IqXnDWxtys7HM1cI3eBjrP1Nyierr1xZyeksPp9xHvva6HEekpY0XFe0nTVZKOfJQvRFo1AEttt8l7QFlkhDEqg480q1yPsE6wkeQHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3wivh8RoVRyqznj0vKvpYqmlNEdu05DfkZ/ENPqJt4=;
 b=UhqVvPPBev5IZN/rjVhikQfiV0qqvsmYAGXSqsUn28IM6JY5it9k/ACO6ET0c9222LBZA5VEL8LzrLcFKkuBXkCIBidL/75I3T+ymebsB9V1RagrePLN6gEaAnNoSaLx97BNg877nGe9IyX76FWax86dHeCNKXVpDxXbd0CGcXtVm5D5T4vnIWWzKfnVW+6P1teo6R3dFLMTIEwKrs2E3ee6dRVX5WgnixiMAILuzGfBEIuj2nz65OahQsf0iDCNmE+pjPhKKebW4zlWkI8SgoXHzmlyD7YuqWdzkLfsvMxjQ5q9UB00Rlv9AROMYZZQnmksxU0DGHcZTyGLERxevA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DB9PR04MB9282.eurprd04.prod.outlook.com (2603:10a6:10:36e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 19:52:34 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 19:52:34 +0000
From: Frank.Li@oss.nxp.com
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org (open list:FREESCALE SOC SOUND DRIVERS),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC SOUND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev,
	vkoul@kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 1/1] ASoC: fsl_asrc_m2m: use dma_chan directly for dma_async_issue_pending()
Date: Mon,  2 Nov 2026 14:52:27 -0500
Message-ID: <20261102195228.4084438-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH3PEPF000040A7.namprd05.prod.outlook.com
 (2603:10b6:518:1::49) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DB9PR04MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f63529b-2f93-44e0-cd52-08df391ad698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|7416014|1800799024|376014|261021123027099003|261021121427099003|261022105027099003|261009223027099003|921020|261026140227099003|261028144727099003|11063799006|10067099003|56012099006|261102123227099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	5UF8j0kUKiveatyrwnLwTh/itQMKZHRBuboQBfsvokbIPEwLSE3Tggv2sj33YmJJJAFnR+0beIJX6MkePrE9GmupH8xiox6Psm/rhkTzVHlQnvT9nNWFVlU0UKOK1ji2QiYYYuySOhC+ji9eGpRh3An+DLbx2QRYu6YCvfDAovHFk1Gvh8yBB8rOgp/vkenPWCuYxGaxmbfh5TEkNq9h++emnBxbnjGhYjjCrbahQKR7HL0kpHOXs7l9OqZ5z5OKmpNmRNyWexJOqND1a8SLmZ+OrlhtLBSSKd+5+C5KsyhBaBS47ZOUsyM3LTY/phvnasTDxLZ0G0FU/oIxd0Wx1Y3Ji+3cB+LafpwFHbfa/LXG4WqQNyAic366W/Yw02svxn+9/6eZo5pHWZCHpmW58jFGyBVlAr4nZhaqyrloCp++vofPoHl8nmoFE8YTX3VDnZDWF7yqzXTRHrVtgjLwe+q6BaLphB8tuyEpbX2aOkU2b+bgJNioBt6NO3bGOaBjK5C70OgEHhK/zV53ZPZyMfr5trWL1NFI61zf1tUFtvc+KgEectOFsCJQhJGrJGSxMqkBZHVPTF+a0ietL1gSAbC//GOpyGkEdaJEhNKGYc/NcA3K49b5zi//Gp3LRiy2DVFUtHj40xkuAzsSlLJ3mmp18m9ImDzQ8ofXfS42pvOy51JwN0eSVw0CtuFLaBaeBZKOG/+TYa4lY91kzIgwWQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(7416014)(1800799024)(376014)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(921020)(261026140227099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(261102123227099003)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LOF6VuVQUFyW1fvMbg/r/DWwhec7pAiljwC/4o7ohzC/RBoRhpvZUktk2lOW?=
 =?us-ascii?Q?kK8vT3+TZSny+SmGxHU8XtuWxw5DP1vfFZBeLLQ2OlfLEolCOIpFvgwg3+t9?=
 =?us-ascii?Q?WxY05nW15oloMlsEa6oWVTVXtPVPteHS88G6TtPHxPpIbR1qvO/vwf/V00zS?=
 =?us-ascii?Q?/xbLrYC5pKNEfwm8lFFNynKeNB8GgQmnxVwdTaNfc1IwENI0Sci4dm+G3G8f?=
 =?us-ascii?Q?3FC9UUVK+BGZ7XOEXEazUD59RJRHQTIZrPlKwAhoZhdVn9mFgemlnG3m6Zz6?=
 =?us-ascii?Q?5y/ComWGPmjg1FCou/rVZl2/ooqU+z2UbVmZQszr3NnRouUbGvD1lPPD86kw?=
 =?us-ascii?Q?27mI14mkvm7vKSFB4gk6Qe0xZaAjutgtqV/+FJdePQT6ob7z8K8Q9iG3Ky0h?=
 =?us-ascii?Q?t3JYV2xWyIwx998MY6gN+Mxj0uj9Dy+iljP7oRo6zPowYklJBj57mQwAVh9e?=
 =?us-ascii?Q?V7BEs0U7y77iazmYGeySeE0QqBMO2u5ghClq3fLLn8Vw0N7FMd9LiA+KlB+v?=
 =?us-ascii?Q?ElCG/SP8E5oKx+Euvvw6fx7g4TucIvpqBXEFbk1x5uLzygiW3DHv3I/Jup+S?=
 =?us-ascii?Q?AHen/85vLS744S/p3dySCTcrwAHoMc/+WN+u2hrN804LvJtTDpWE3pymCpFk?=
 =?us-ascii?Q?oLN0UopSKn+74LrNVhV2A6ABvASZE9otOP8M7DbPvpKgCQWjiOYq/ZiDBSJf?=
 =?us-ascii?Q?aMAvt6uc9mZB/ubBPTLJugUiYzvh91LCw3PwzC5J+mgPP5ujEkswlQHEZjyU?=
 =?us-ascii?Q?8R8G0v6F6Ng0PdgB/QHHNB+A6oA93aLA5h1IVBENkMWGYo4zCs41/ZEmKpSC?=
 =?us-ascii?Q?bOdYYzEHyCm2jUJwDEd8HTIr6pYV1ro6FugkmUpcNhDNa/hXpCnznsGfTNCY?=
 =?us-ascii?Q?6BwjnUP4ZjQZjKamIPyh7JdrMfSB4o5qTMerlFUZ1xmNBvD9FJ6FNbxgABi6?=
 =?us-ascii?Q?XATEzDuK0wlJ3/mZcdNx81Mdmk3jDqrestRBAUXkaCv7uKILt1k/1XHGuWl5?=
 =?us-ascii?Q?WSR4EZ17kRWnmvG3cn6s1h28PyxU6L0mZcuqdYVX0oMVygnL+omRIIUgPzcn?=
 =?us-ascii?Q?GR0S7+mlw1ecl2CxXBZ8RQKUMggW6e75jLHp8N+kSYUEPhYcQQ5dyENjWflR?=
 =?us-ascii?Q?WOHBU+E+7LkSUxlAGI0vCXR1sJGlvXwkDS9v99Ea2TPhKhCWWgKjgPTIdnts?=
 =?us-ascii?Q?AFLPqqdI1gVLlNI0wv/HEfFrUYBVbYHLb+Ejyba9oJGIQ2LRQS1JFonpQK+X?=
 =?us-ascii?Q?3WccpuZNmmi+cxsWrihhRkm52xLW5zltHHO03MS3RoDwsjebmjwQ7Iwvd7mR?=
 =?us-ascii?Q?gPmYJ9DVB38TzqGeq2CRI4QG/hPi2p4szzf2Pg5D0YB11/nOAbJGLViKHWFI?=
 =?us-ascii?Q?FdhLwdEaxBGwPBWuzKXQoNctzeXoUvzSfL3qgjjfc1QMVzanz9wpalaWM7gO?=
 =?us-ascii?Q?052srAbfhZV8kMQsk2XlzPvinxbZo6daCHMenpuJA2nZszMwG+OvoLYUG7zM?=
 =?us-ascii?Q?+nVs6Dr8am0lXyRqDhfRyoSq///phcXwona36zy1Abbb0/8IiRVC3fRB08XV?=
 =?us-ascii?Q?kuDzG6Hkgl9xtjMd2Y7MlcexPqUEKVlN26lSQsZobZdIsUP4dhKkVcBgmqJG?=
 =?us-ascii?Q?GtNJxrtcQS7iWJkS/lc19x9U37I+hJk8zbcAmw4oTLzcbLdTaIUhKSMXVsmn?=
 =?us-ascii?Q?j8b3gGuJZ0oG2TI4yIDJI2CgV53VnnvMhuGVSopwSe12X+Ou/MuegLQTYV6b?=
 =?us-ascii?Q?hY53yonEPl0SIFQuTck+f4fkFsN+KUt4DzzTZ+plXQHvIXyDDjXL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f63529b-2f93-44e0-cd52-08df391ad698
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 19:52:34.2748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pr1+pnasqmQAlhRHfE43H2H4VjXV5rN8XgVMgV/M15TumpkEjjuCMARDwqwjxD0Qr/cik/0l8riXc6kVDF5zjif+wI25fgs9vE06hda9TDiErN5fYr3mAy8rlwsQ2Qzj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9282
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Li <Frank.Li@nxp.com>

Use pair->dma_chan[] directly instead of pair->desc[]->chan when calling
dma_async_issue_pending(), which is more straightforward and avoids
dereferencing the descriptor to get the channel.

Prepare to make struct dma_async_tx_descriptor private.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 sound/soc/fsl/fsl_asrc_m2m.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc_m2m.c b/sound/soc/fsl/fsl_asrc_m2m.c
index c6970a7e88f3f..796a78124765f 100644
--- a/sound/soc/fsl/fsl_asrc_m2m.c
+++ b/sound/soc/fsl/fsl_asrc_m2m.c
@@ -257,12 +257,12 @@ static int asrc_m2m_device_run(struct fsl_asrc_pair *pair, struct snd_compr_task
 
 	/* Submit DMA request */
 	dmaengine_submit(pair->desc[IN]);
-	dma_async_issue_pending(pair->desc[IN]->chan);
+	dma_async_issue_pending(pair->dma_chan[IN]);
 	if (out_dma_len > 0) {
 		if (asrc->start_before_dma && asrc->m2m_output_ready)
 			asrc->m2m_output_ready(pair);
 		dmaengine_submit(pair->desc[OUT]);
-		dma_async_issue_pending(pair->desc[OUT]->chan);
+		dma_async_issue_pending(pair->dma_chan[OUT]);
 	}
 
 	if (!asrc->start_before_dma)
-- 
2.43.0



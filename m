Return-Path: <linuxppc-dev+bounces-26765-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB7CC79FA0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 08:17:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfGyb4rBVz2yqT;
	Tue, 08 Sep 2026 18:17:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788855463;
	cv=pass; b=lC+L8Bclld6lYn1nIa0kl6JS2WFEGIFoDO0kNwesB4FxosIYZ1XHIVuP+AXEZqO2oiRhckSzeWSaiKSjU1QzD1eD6Ss+38lSbs/hOCE36jWQ5kMEULyTtnhE67mpK+TGknojDo+qIV5u7zxB0WBtrosgX8uvTg6i3uifnmx0JGVF/sEwNJEMG4k2lFB6egANmulCOwDnSz3NMTWfWG1XtIANQedFQw9BHwJtyy7gamcrAsJZ0u0s1XwtySy2G4AWmYMsFtq5wuLSIvVK6+g+FzA4aXu2ToxfsW/p0HdakY9hZ3Q8pGiIcbVlNKfuSTh2nPi2sgcYF8oct8rAoHoLhA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788855463; c=relaxed/relaxed;
	bh=tE8ZVF77Q8olof0Q3h+z5+sV11+Hg/Pz6SdsPrODRLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=inbtmwKAbBifj2EWkkgn6zhYrajlpIaZ3N0fPwnJA0DOopySV3pWaz4Oyyfu2tKwfeOLsm0aX666B3prUsL36EbEX+rcnS08CSTrLDmDpDB+f3agFR4njsWJQ0TwvQI1mzJLiljMNwJh9uR3TISEsyL+RHOPxgsgY0L4RBlk+jEBKu39dOD61qz8Y8S4sl87lMePGuBpKDEtJE3WhZ2EO6E7OS/ucwtsGJyH41GT2DpM3YKOyALBdm8J0j16gKA5q0enE/awIueS33e7GUedvfebHI1FmWmTf3kzTryxMQoftrlIOT3bgQszbO/mVqs1aUiSQZCrCKSD1D53ryrDow==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ZKrwtX66; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ZKrwtX66;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfGyZ4yXjz2ywR
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 18:17:42 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPvqi3l7Xm8tqSNmekKwMkgPPbvxmgCdlNQihLHs6dWERTf9cSI0/nULWRKS0cW0F0nAsEz6z8W8Vpj7jE3TwzDlEj6bLwkDODeMvgteteNOVuBBPeUvsAevJw1PEbUD1bCV9P13jzcEB1tAgKGRA2UrgEZKshIjZNmjaqvO9dv8adInZ+x28osM09IPnz54Ja7uVIQscmwrbcEYx2+YLsIgWdfNsVogNncA4iCxg3mMIdU5CelI4tR17HUvpjX4Aq+DlWwxvncGrYmPxX2xUSYy1s1Jp86X/tm6Xd38Piqqqo8p/GpVaSTs5gEOZ1AkNg9CALg5gKgCBkN18sqQeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tE8ZVF77Q8olof0Q3h+z5+sV11+Hg/Pz6SdsPrODRLM=;
 b=xZ5LB/lasTBpHy29j2RiSNbWjEnEIboGC1fIjBT5p9VxtaFE5rAM6JABZmK6cvqXdBl2qrlm20KxVO72YHCChsKlcNUGmKnpJt3nB/RptidSgMai/H5YvBLJ2jFhi5Mh0s3nDkQVh9NFDbdG3BigIy3VKKiidc+4y3cL8kPOt30CP8LJ+vxdhvrHwm0H95MizCxmMgCU5wa8jcvtEXAwfxGF83QmlH7KhfDPGE+U98XWUruwTXiJkPcsqHxD0QRUltGHxtEeb7MG0wP9UE2Vz5RBrbZ605Fm51/pu0ND+U0CwkTwfZEXNp/xOQIJGGKLG1hQdf3SwhR5xKYRsK5mLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tE8ZVF77Q8olof0Q3h+z5+sV11+Hg/Pz6SdsPrODRLM=;
 b=ZKrwtX66iyy6KHx9UtvlB3H5oHlPiI8n4U4SitgeyN+i9gft9CNOPYav/z5Vthj9/rJLCdkUuhe2RKyUo9aAi4bu949W36S7O14RFMW3wUuo6fWcgXsVsj8psH/9Az1159bSvVHnE+Ciopku9RyXztfJ1lsyjGUqUqGjKWl8g1Blfm5Bkjg/3Df4zk/TUfcm0fN8rGYvUF9LYJ9zxyTjIxlYNFHtY5RosYKPNh8rCbPUm/hw0Rw6YVe2XTTbeJY5Pb2vQ/D0WL/TKCHV4RW+m4w/cnFj+oGaRuxC9ctFbsu7focbgOa81/+LvsQQblTXDNccX5byc1jYVWlDwRwcjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by VI0PR04MB754002.eurprd04.prod.outlook.com (2603:10a6:800:364::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 08:17:24 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 08:17:24 +0000
From: shengjiu.wang@oss.nxp.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	shawnguo@kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	nicoleotsuka@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linuxppc-dev@lists.ozlabs.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: [PATCH v5 5/5] ASoC: fsl_easrc: expose individual DAIs per conversion path
Date: Tue,  8 Sep 2026 16:21:40 +0800
Message-Id: <20260908082140.1316872-6-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908082140.1316872-1-shengjiu.wang@oss.nxp.com>
References: <20260908082140.1316872-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0058.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::17) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|VI0PR04MB754002:EE_
X-MS-Office365-Filtering-Correlation-Id: 900e138d-3d75-491b-d285-08df0d819c81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|366016|1800799024|376014|10067099003|6133799003|18002099003|22082099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	UF9org7daUlvP/iGtxRSV7IEV8h47zNVRcCamIDh4UGYEWYITDfSXR6qgHKBLEFVKf0sbKCkgMqTzBro4xY+lXgIXGAj4RMpF4RSZY6Z1CMCpJnCulozivKzebXLUlj/9qi8xilj97OvCTsA9swr7o59lzoSeQ7q+gXSeviKe0+s73mhONnRrtX0RmLomyMPN9NNUA7XRkJLF7VUoT1D9yv5BmpVVE26rFA8gg1ZxicjZEZBI71+iVDdIO1oZ/9m86NfmYgGLvM7rxo4AeuBumePBo9PkpM1OUlPOW6xlAVxlTsa9t0jqvBo25LTwl8k/6WiFekcFR9Ll7UVyBvrxfZoZBq3/2sSItQ2Y826NefTqenjCPjl9oXjani21NT9g8UhsI2Jkwj09tiLGrHD96pifEIebp3zZA9lD6ORxPd3J0tWHTewTozdt+OK2zhRzl8Vp7xA9SNqPjGas4/x4L1412Cn4BSYQUPYmbIffnhOJvV0utnwRJBYK9spdVXWh9lUrRK6PDj1GnBmjsZ7IG4kOYwMe3xRnd1fokfuz6XxyzrN/aoiVn+FIK0IoudhgbNjCwPcV9WdlTOO0QPdFqs5o7Hy68ALGEAyB+DZNGA+LOazYyxaQvRCit9eMjIfgpH6Rce9J+yrbIfAlpcC4l4vHpehUheplOCB7BoMybCe3F7ajLm8e5oKyl9zCw0loDugCiYcPn++r7+M5G2IYg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rH16LI2avDfEeg4QUw/8LuLJsI4cI0k0g8UjQTuZpqwueMVfL2hGm96bqM1U?=
 =?us-ascii?Q?74CKlPa7aSvHoNPhzF72zvATqQdN0sRUqmWwZweD8C3bWfftZI/kT0YvLwGZ?=
 =?us-ascii?Q?caWNWNyGmxA8ulKH5jam52HmpnD+cjaroNzxOWdqCN6dL5M3kwOM9DAtpVva?=
 =?us-ascii?Q?K3sYef6LpceKh3SOZA1QsrBHAtKVdiOuNDPz+EoLixzkBquk7255DNYx8OoQ?=
 =?us-ascii?Q?AQXxYonaA3dOSVCBQ0p6L3UlqeDpOocI4TtWKTTaIEmFVNWU6gyZwCTy8y/+?=
 =?us-ascii?Q?sVUe5nZAfUcjSr8LwZRfzxhDXKu28XRcpIvwqWJ1QyhfZ+yp6C5v1OCTbuV/?=
 =?us-ascii?Q?EiceP3foflL+qiFA5DZjyYSXws/RwBxCFNsAV1Cil1NooFnTu+3O/td+NAt3?=
 =?us-ascii?Q?btfmdTzKjNlW8cBDDRmLhxGfb05UperS9gEojIHxkt6FQXhBzNgfajGpknl7?=
 =?us-ascii?Q?56C7gXssYLX/6ZLK4N/ZvOuMVW8mVcZt2fjOPXnn7YrS8/mJgMxvxUYw3V+X?=
 =?us-ascii?Q?Sxu6PKYUoZ41B0lVqChKzrVRkzJTxMM70mycLvuPmusv2Z4QzrWfPgFnsABr?=
 =?us-ascii?Q?0dZntKGIpL+ZmvwZ+zszsP5Sg02DLIUw1vA5slHbUiNTr+d1GRA/AnPp6TjI?=
 =?us-ascii?Q?dhpHL922C9iH9A5fed9nRoXkExYLmLY9LMMD7b5YQBVhQRyPvoBZSjcxPV+7?=
 =?us-ascii?Q?RlcS2zvI3jYIK7DBaNbQoKwMMY1HoPCRxjlALFw8Kmjy7l4egPl5HJGt46w7?=
 =?us-ascii?Q?GaPBsmud495FzXmzinZFvGQxV64xw8yXBp313dj9fYG1Z1Wh9ulNDSzCkd8M?=
 =?us-ascii?Q?DcsSszQsF4IY52JqQG5+tgIIC0C5FMzLgP2x4PM/g8syNL453CDWyXK9U4hg?=
 =?us-ascii?Q?1Rbup1IXUxsd8hgcj+sAY17W6WDT4OmSHrcl/glR+2vHTSTv68yKAmAl/gh7?=
 =?us-ascii?Q?T3RhChl18LD83yR/deqInpyDGWsZKRGQx9ot55JmGvhdfw5WoTEuLoZCgjs0?=
 =?us-ascii?Q?cf0Z/RAT7Iam0Pa+0e9NBzxyRQjRpmf8XoFBgdXPlBw7sMh9+roFJdcvP8Mc?=
 =?us-ascii?Q?N8Uk4I60CT4tA4zg7Psn2AK+bTUuGJgPOZ/oZoygNd1pU8Z1z+ASa74dOKHG?=
 =?us-ascii?Q?rBMwo7OcKULbu6Wn19gf0cFecTen4JaAYIoMOJVlq7xmqvKsFDRxAb7lJ19o?=
 =?us-ascii?Q?o0fEwLCDKJKJKWaIKaLsBLZNDDj8SNWklySOQKK/s3VNtEWz6Zr35B+BBG4z?=
 =?us-ascii?Q?fbIIjn3j9ifdA+bzkoteQXVo7UynzjxEvbz1ZhHs8WAUkpUOP/ZEKtTbF7rZ?=
 =?us-ascii?Q?XSpk7ShM27yW42qWpYWXCNzxToR9sDv45E6gn1UWg/b0cHS6fZ8dmlj6Gzud?=
 =?us-ascii?Q?YnkDtjra0Q7iZc6zaKeMDOYjhyl+9OLaj80lQZjDMKH8Yux2SOWmo1fQi4M6?=
 =?us-ascii?Q?UI7ZMJqdCB/bcDqXzC6U0KTfPfQqjyxRHfnPjpWma6QZ3v6bJVIDAoWrTOq9?=
 =?us-ascii?Q?Ad/KFjw8q2uBXAYzIVjg7LwLUWvzuNtanDPnzAm0K7dmO8PSqLFhkn8+svKY?=
 =?us-ascii?Q?n6o+gM8w5d5NQsNcQApkSHqVOQmiPM598PXNFI8suR4c3dzTnATJqhIOsV+C?=
 =?us-ascii?Q?yRZqJ7/8+pFEIylyf5UAfEahGy/5T2abTmmKQtDo4FWyGTGojmpVGBPy5y08?=
 =?us-ascii?Q?srKoZYladFmt1XwcaSw7bjRG7JBiUQunFkt/j74+vPrHW9BcQ+1229iYrHuQ?=
 =?us-ascii?Q?fzOO3Ll2JYDJMiURXgScO7kXuKGa1rrVc42DFBCuS2AS4o93s8/a?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900e138d-3d75-491b-d285-08df0d819c81
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 08:17:24.0140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gUvPL/auo2BL1UCd+0gQWJAoQuPxlnA1Tad7BNTFhGaJbGBn/H1JHvPPaOi46ln3YUUyJQTqlZOS3lUxRIlxDKAVS4LopI+i2GXnuVpafJMQJefNnXx80bqD8ia9MaR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB754002

From: Shengjiu Wang <shengjiu.wang@nxp.com>

The i.MX EASRC hardware supports four independent conversion contexts
(A, B, C, D). The driver previously registered a single DAI with generic
stream names "ASRC-Playback" and "ASRC-Capture", which prevents
multiple independent conversion paths from being used simultaneously.

Replace the single fsl_easrc_dai instance with an array of four DAI
drivers to allow up to four independent conversion paths to be active
at the same time:

  easrc-0 -- ASRC-Playback / ASRC-Capture (backward compatible)
  easrc-1 -- ASRC1-Playback / ASRC1-Capture
  easrc-2 -- ASRC2-Playback / ASRC2-Capture
  easrc-3 -- ASRC3-Playback / ASRC3-Capture

easrc-0 retains the original generic stream names to preserve backward
compatibility with existing machine drivers and board configurations.
Each DAI retains the same channel, rate and format capabilities as the
original, including IEC958 subframe support on the capture side. Update
the devm_snd_soc_register_component() call to register all four DAIs.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_easrc.c | 112 +++++++++++++++++++++++++++++++-------
 1 file changed, 92 insertions(+), 20 deletions(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index a6ac94055b17..cd22ea3e03bc 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1589,27 +1589,99 @@ static const struct snd_soc_dai_ops fsl_easrc_dai_ops = {
 	.hw_free	= fsl_easrc_hw_free,
 };
 
-static struct snd_soc_dai_driver fsl_easrc_dai = {
-	.playback = {
-		.stream_name = "ASRC-Playback",
-		.channels_min = 1,
-		.channels_max = 32,
-		.rate_min = 8000,
-		.rate_max = 768000,
-		.rates = SNDRV_PCM_RATE_KNOT,
-		.formats = FSL_EASRC_FORMATS,
+static struct snd_soc_dai_driver fsl_easrc_dai[] = {
+	{
+		.name = "easrc-0",
+		.playback = {
+			.stream_name = "ASRC-Playback",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS,
+		},
+		.capture = {
+			.stream_name = "ASRC-Capture",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE,
+		},
+		.ops = &fsl_easrc_dai_ops,
 	},
-	.capture = {
-		.stream_name = "ASRC-Capture",
-		.channels_min = 1,
-		.channels_max = 32,
-		.rate_min = 8000,
-		.rate_max = 768000,
-		.rates = SNDRV_PCM_RATE_KNOT,
-		.formats = FSL_EASRC_FORMATS |
-			   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE,
+	{
+		.name = "easrc-1",
+		.playback = {
+			.stream_name = "ASRC1-Playback",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS,
+		},
+		.capture = {
+			.stream_name = "ASRC1-Capture",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE,
+		},
+		.ops = &fsl_easrc_dai_ops,
+	},
+	{
+		.name = "easrc-2",
+		.playback = {
+			.stream_name = "ASRC2-Playback",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS,
+		},
+		.capture = {
+			.stream_name = "ASRC2-Capture",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE,
+		},
+		.ops = &fsl_easrc_dai_ops,
+	},
+	{
+		.name = "easrc-3",
+		.playback = {
+			.stream_name = "ASRC3-Playback",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS,
+		},
+		.capture = {
+			.stream_name = "ASRC3-Capture",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE,
+		},
+		.ops = &fsl_easrc_dai_ops,
 	},
-	.ops = &fsl_easrc_dai_ops,
 };
 
 static const struct snd_soc_component_driver fsl_easrc_component = {
@@ -2234,7 +2306,7 @@ static int fsl_easrc_probe(struct platform_device *pdev)
 	regcache_cache_only(easrc->regmap, true);
 
 	ret = devm_snd_soc_register_component(dev, &fsl_easrc_component,
-					      &fsl_easrc_dai, 1);
+					      fsl_easrc_dai, ARRAY_SIZE(fsl_easrc_dai));
 	if (ret) {
 		dev_err(dev, "failed to register ASoC DAI\n");
 		goto err_pm_disable;
-- 
2.34.1



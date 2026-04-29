Return-Path: <linuxppc-dev+bounces-20248-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03ECEFF886F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 02:13:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g517j4bJBz2yps;
	Wed, 29 Apr 2026 12:13:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777428833;
	cv=pass; b=HxKjlKJ/kT38BeIHk+RuRB0gmOryQ8KwqTw0PlZDezRo/sV/Hp3DLJ1/ydAJMzFhXkJlap3d1KwA/0Lqaj51BfwjqL/xXv7qMuoctOk/GK47w9jR68pUeUGXUh6+QaHiRUWw+yEJm1QBfqIRuffFoVC8xupXsjdR0Gth4usu6BLBoUNEKMjHXwtah3dyTZ7GdLaS5x5H/R2TYTB30/2hlEB3OEs0jUIKG6/qmGPMi4naZn/pKxJFzlMMiPqbolV0Tp1MjBmc4BaEIKJMq/WVFMb3bzkeRVpfX4m1Wga1AOiRwmO7h8SEM9wAzmmAIfV4JrD9pTS8LRqgKW9Vg5g6+Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777428833; c=relaxed/relaxed;
	bh=KFd0F/841kfYa32lwmbOBIuMXbkDA/pp6wib+AqD/c8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EFfPn8ceZ/72N+q6ypKEJ7+ghYKQwNR4GX7FHBncw5J0XG4OYFCZvlWcaJc4F5VyjlDi/wJUM0WY9F+a2xIAVTBAw1MLT13bM7M3PWcnom6O3G4fJpMaOKxk7yYhjCyf04l9+wsZRejAnGB1hxZfAV7iwHAENjcMrIIY+YXrUZLhY44cVXgfD+oPu7bcyvD4gsKcI8Kv41BqsM19lripFrE3M0iXQrcY5+q5hk3wr01gxy15vwxuRWVIchgRMSPusxjEwu1zakfDzD3azGPMZSSZPe46CRlFVl9eHRE26XKAtqz6OfcIUcJ3Biv7e+Ibf+d1mHuzBlPOKc5ByW1KOQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=bqaeEblX; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=bqaeEblX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g517g1BlCz2xTh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 12:13:50 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCaevOxAzLISu0vzXxoHtjLUWY40p8nfVa9Gl/l+Y8vMsJWbPmNFQtYqNhe8k++Wwjd1HmW2bY60WOsJ/SlHvyGmyu5ksXULY6MMtHuPLuuX3npC7LR98VMeGAQyrmDU52YiiEFdeC5jdLW6ZWz/TbcTxg9B0br0T0QvUZlaqw+m4ZfyFwWy9lFc/5mR3ElJy26swa5UWnfCY22rzLfdPb04YUYwY9zN6wzh0vI6TGyYrnMJ7RMAj+aS2czEHqQhSJ17YjjCynZLMSQWqDUC9AZL1xf06oqEwpdEsnCDRHo8inUBIL/1ixZq759JyVT6ie2f/CTnWGqYDdWD/f2YmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFd0F/841kfYa32lwmbOBIuMXbkDA/pp6wib+AqD/c8=;
 b=qM2fDc6KtgdDYua5aA1L97JjhVJW4IC1nS/25U1E0oYxPgfBgBDrCyZmZmEghB5pvWTGwutEZu7UtFUH9BLGXMCCowppaB18YjkisNAh/eHsU08JIOJsTXvxyI3FdCJwmNfDnPYjR16Qzv9ZjamTHX5iPg8WkVnm8ZVp8SfeIfUQWWFrNkHisGqG8nK8ZJf3IEY1mLtvUQZmKhx3d0HTa4Og8r6b5g4eLTyrKmUCJilhWIdrwFT2grp8L1EzP71Q8t37yg2a+LnqdNhbcKbP6q/MbB0MbJ/FxstOzoNdaU9U0H2mI1oRdDkWQIom5v0cN4Eq8LQbXAC/paGz4rRUEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFd0F/841kfYa32lwmbOBIuMXbkDA/pp6wib+AqD/c8=;
 b=bqaeEblX14nR5txbDw6yZTy6PwKSxQxRtjLGGqX1gzm/C0e518Nz5HM3jLvXdREhZcnGmyReZGORKZCwUSGe2OlLA9fZIhLCfPapHjNEfzNUgIJhcO1+uZsBHacxNHVxlFfyruApMWUvEg7160SNFQOh2xF/R2zyLzo20MrFE6irKJXl8GAu8z/8jdkSixnXJhGN1Wh8eSR/dh2Du13IjbbxiYY+kie/9Cn5mjoHqjcZzph4uXQtPdgV70OcPA2Qd8hiV7x99PDNHsi+7fzKjOBIo66EheOklgxsacUPIxz6qVL2/m3ZCAL3hoBKiKu6LQFSRWTXJQh0w1ganxPagg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::22)
 by AM9PR04MB8276.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 02:13:20 +0000
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc]) by AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc%5]) with mapi id 15.20.9769.016; Wed, 29 Apr 2026
 02:13:20 +0000
From: Chancel Liu <chancel.liu@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	shumingf@realtek.com,
	rander.wang@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/3] ASoC: soc-core: Add core support for ignoring suspend on selected DAPM widgets
Date: Wed, 29 Apr 2026 11:12:49 +0900
Message-ID: <20260429021252.691263-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0139.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c8::11) To AM9PR04MB8353.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ef::22)
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8353:EE_|AM9PR04MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: eb0fa4a7-f6f3-4d18-3710-08dea594e24d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|376014|366016|921020|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	yOL1mjZRbynG8oZwEayE7tBxe0/1mNRUt7Bx0t1E2IbWn3lIOdg4xQTRE5sDHf737jGgeKLoNRmsnMYfPfqaTY9Rpo/BmV/XcFRGenFEu60gEGYQdI/d04t6sC2MZCfDnVj4HcF0hsCRL88qppnYhc/B/r+hmMiKWy11cQH4fMoj6KRk3bA4vio/AUixEyiSPW5iOCCTMiVufw0THY9q/lif0nwF8c4HjgHygkHdvBBEaPv5PPkf9bx2HSDQOjnXdYLPw1SXDku7/r90clRjHKXuq3XgMT0jCyF7gR+5Tj53ogPT/5dbVqa+YKwE6lAGvPopWnbN8FF8NdVB6ftyEBW6h7XqPVbSDng89kjO8wKXJIBa5v/EKIoLZQTOLNUbRysjoNYwfiUJHwe8uCs/cFuUNxNYS0sT9zWskustpz0ciRx7ixjx5K1/5t99eSOUY3ckUPkUcR3cAhl/FHksj0e82vmPu/4eBdBVPQQqz+5mjmXxPHBk0oL2NyExs8CHncZGYRU9o2XxE93n6wAgOl4v7vJwsbf0zIRugE1XsqXOBa0YxlJU8tWQpYJ3XfBxh5X7ZYVwee3KyZYoiKh3yd46VuKxWoHTNQcQGB0e0G1UR6HcnqYbjI7iX45gkRq8GLcwLpwWh7VAWWWNVeNgZg7cIAFVkKWYTo1viCts2ELbv947zebnNAd4DM9nGnoqNU8DqRoMKuY+uq+TRbtQzjOkUtBlAQL7ETyBqeOTv+1eWcBrtwt18fA9aoI2gYXpj2r9ytyL5WRz+eVPfV99azEzwX0a3/d/MvTdC867I6aNH6iHVmV/oB4CAnlJS99H
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8353.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tGKYgroz0esxwkah15Vu3T7OrcPlKfgjOy+5a2OBJ6UAVRy3522BTv/jwJzs?=
 =?us-ascii?Q?SWmVIz7/3GjK3ciJ4nL1t73aVz8Lh1zadm08s4UM+ijdlTg0auUVoLiblHWU?=
 =?us-ascii?Q?lhypOvLc6s6pFFkNzLwVXW39tz4uUDFV+OwzJtoZHANpI+me6b8zPwAdj71T?=
 =?us-ascii?Q?iFbW5OlemMOleNL28WG9kgUB6AroknkPfodDFP9ja/XcFiKm4A0iC+8fbOeT?=
 =?us-ascii?Q?F8EvISwVClWWz7/vrE0aVTIvb4LhVRA29dWOVJqwy6FuxbUDFPFOO0GS9Ol6?=
 =?us-ascii?Q?c2gttCSefx8YYoSXcmDxcPCorpdRIl3/SnRH+h0Ufcr2/65BvhNjHTNuzErZ?=
 =?us-ascii?Q?eOR99s21gRa3XCJJPGSv2GfuILWSlz5uSh4B477P1UFMcnykQe53gsCRLzJa?=
 =?us-ascii?Q?TK/yhga1KnuMXp+JyonlUG4RpwvDMozI+3hRyYNx9smsFxAKBObjdGYYnloX?=
 =?us-ascii?Q?soim7rN7YMwA+l/oeGI0qIgLj9jFf7ShoMiWO9sGGxE6lcqYwc1P2AyHOGAo?=
 =?us-ascii?Q?rJKA0t4V9oc7vbhFXdDLO+U+CpD46MqNeTNuhuLQoVIBEWqp3Lk1Ck683Agl?=
 =?us-ascii?Q?Cjf9laSZ8W+7RyMenrckDDZHJ1OZvsQqYh/NoNegkSCcVuGorSdgqqe0wC7W?=
 =?us-ascii?Q?4gW+A7ZR2kKGARQZd2tj/jc++UCSKorcA27avpW/sRLF5/pkkVIiwUhmY8tP?=
 =?us-ascii?Q?1++v56pwrWxZ3THZv3kjApQQPj03ItxjF3OqnFy73EFjcGS/EVIkMHmCVAZF?=
 =?us-ascii?Q?nTx2+EqB9vGXQ9av4vKLdtFfODevGDv8bUMFCTNlTc8In7ve42UXRBCDge5I?=
 =?us-ascii?Q?TuRPqiHEtRCVcGhARIE0MOqkOBbSwsl3Pp1lODyzc4/vunKa0+VxJduBDDx6?=
 =?us-ascii?Q?u31GGKJuF8GE+8yw4xQZIytlISOfqvbbfKuC7zb++16pGf6rJvyOJFiwMbGn?=
 =?us-ascii?Q?Nzt7kXCS9L+/afFDEN5Gy1JkGRLYPzMmk8VAZJ73C5chU087VzM0YIl5FauA?=
 =?us-ascii?Q?rnDWRz4O/PGRvAvnkpiYuRfZuy5TehC6uUupa3ldmK/18/0SoroyDn1fESls?=
 =?us-ascii?Q?V13gDPJA0Ct7loTOgDJSlFrjzldhV1a5R+GAz3lB9Wd4O2Bu1RmRDenTJrkV?=
 =?us-ascii?Q?YM/nX8VorEQIiugbrq7fKGcIdy1QuPPN+F/Ei1ixvmpNcaBNHcEhD6FL1xBt?=
 =?us-ascii?Q?mU8nLYTNck1g2Ji8MADT1u3mI/MPiUeHF2N2U65XX7/Yf4Flv9ev6kBZxQ5h?=
 =?us-ascii?Q?Jy3y7JDrbSdzzKHjyugmep1vdNjB1RTfoL29hLIR+dWnU24lCwnKSQj6vYdt?=
 =?us-ascii?Q?lEIF+bAMXUqif861+BY972gNBQ8b40txwKFXPC9nm4bH0Zy8FIzO+fNYSJ8f?=
 =?us-ascii?Q?Jq27ah8FC7SzTI7lbMTTAwohRhM+NE9rSCmIX69SAmUM1ur4sSp11geoqx8F?=
 =?us-ascii?Q?KxmbtSsEnpAIHEUqiBglp4yDkgKIiCwMmfXUeVqiQOnVIOL2JScIH7TkKRMo?=
 =?us-ascii?Q?RgQkxIetAjIt8hDIX6UZwRuuJNJvoKVuMY+NqWmSauEWTxn6kqIESAR0cGRc?=
 =?us-ascii?Q?VmK4aLz9zRy5EfkG6xpfRYqmqjgDRFKtNnM/1pJiNAXmUMgyqZdJ//hY2ip4?=
 =?us-ascii?Q?s5Bq1LZvJOGPl4/tcKuBUwoAy/CjJ4IzBAMlT+jxRUs5nSblnZ7utMlNa3lu?=
 =?us-ascii?Q?2zFFZQ2sDm8Rpq/x/uTISMfHLYiICW8aaGooK1mEtUrd4+PXuc6SovHq8Q05?=
 =?us-ascii?Q?EaEAMwwwew=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0fa4a7-f6f3-4d18-3710-08dea594e24d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8353.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 02:13:20.4963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsK1ssZQMs/ZB6CFFoRyDgQedLsJ6ARZAx7VJyoFWcfJ+SnRUxu4dslKv7lJpYfOcjF/AM9uyAJqWOXImgQGKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8276

Some audio systems require specific DAPM widgets to remain powered
during system suspend. Introduce a generic and reusable mechanism in
the ASoC core to mark selected DAPM widgets as ignore_suspend.

The unified mechanism consists of two parts:
1. Parse and store the name list of widgets to ignore suspend in
struct snd_soc_card

The list of widgets can be provided either by the machine driver or
parsed from Device Tree. Different machines have different routing and
power requirements. Each machine can specify its own widgets to ignore
suspend through DT property. It enables flexible policy without hard
code. A new helper, snd_soc_of_parse_ignore_suspend_widgets() is added
for this purpose.

2. Apply ignore_suspend flags during snd_soc_bind_card()

After all components have been probed and all DAPM widgets have been
registered, snd_soc_bind_card() performs a unified lookup of the
configured widget names across all DAPM contexts of the card and marks
the matching widgets with ignore_suspend = 1.

Switch to use core ignore-suspend-widgets support for imx-rpmsg driver.

Changes in v3:
- Reword first patch subject to use snd_soc_dapm_widget_name_cmp()
- Use goto fail for error handling in imx_rpmsg_probe() to ensure proper
cleanup of of_node references

The v2 series is a rework of the previous "[PATCH] ASoC: imx-rpmsg:
Fix ignore-suspend-widgets only applied to codec DAPM".
Changes in v2:
- Rework to use a unified core mechanism instead of machine driver
specific code

Chancel Liu (3):
  ASoC: dapm: Fix widget lookup with snd_soc_dapm_widget_name_cmp()
  ASoC: soc-core: Add core support for ignoring suspend on selected DAPM
    widgets
  ASoC: fsl: imx-rpmsg: Switch to core ignore-suspend-widgets support

 include/sound/soc-dapm.h  |  1 +
 include/sound/soc.h       |  5 +++++
 sound/soc/fsl/imx-rpmsg.c | 26 ++++++++---------------
 sound/soc/soc-core.c      | 43 +++++++++++++++++++++++++++++++++++++++
 sound/soc/soc-dapm.c      | 43 ++++++++++++++++++++++++++++-----------
 5 files changed, 89 insertions(+), 29 deletions(-)

--
2.50.1



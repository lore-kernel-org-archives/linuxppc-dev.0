Return-Path: <linuxppc-dev+bounces-27884-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC39C982DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 03:30:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hplww5cJSz30VX;
	Tue, 22 Sep 2026 13:30:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790047840;
	cv=pass; b=gBugzPZoo5U709NA6GAuc0Y9ClB6ALaAdcbGf2pmWj9D5hMNMXB2o6C0bdtcCHhpVvaOxGfWWvI6sA4/QEWMLtk4Yu9/xp6U/L8nQwnFTWB9f6qbZoFsA21tDbwZAPyLPKK36Tw5NFo+gUMMwYwzatrTpQpcYuwKC470F5Li7tihltoECF6TlbLsKvRLyN4JjNJgVX1B9kOOlB1MqlfRxt7DzQOmXkUpsXlpr5YTjL49bUM13MxyDX6hTfOYJbaBKx6FvHFRxDxkA4SqVZ8tkt2aSn3DTCcZK4r2y3dWFYmonKC14vdk7r+CF3NlSyPAWvPtADPKpH5iZaqLpXBWGw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790047840; c=relaxed/relaxed;
	bh=39WlTcuu3/QuQEHjx8xHoO0yguTZClzcEBYm8dafVik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L/8pPK28QgyHtVasmRFaNOv3PHPq5jVcBj6TRpNEhymFltmq0OpWZ/foF24Q+8nfoVK2N9g4R24Bxwr8g/xJf5l9ozLU9MFgXEzQ0dM3WoyTyicVQxzeKhaUtq4668ve/J0OFdJrzzoFwgq0nmgvXP69RPzRXf/qyhPZCqV5H8wZPy7N/0yUY1LA15yC0wW3CuG4SfEeMLzK1T0Y1SUHLUuxEXhADtGL1KAv/LV9uv7XELKb9bfBDMg6YeQKDJUdbW1hcP1Vf8uJAbhwMa/UGyNXJ1CgIMys2O6nBdvlYaCzBoh06WbHcL1rk5hmMIs2c0zV92HwWD5l7mosvsW2tA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=tvHav6vn; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=tvHav6vn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hplwv5Pnnz303F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 13:30:39 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ful1fxAFAOXNTy7jqpSEfAtUY53KApjdwkIPKRQRRGmDLm12JidDW5MMTRxEXx2v6yqfUZNkHiocqkYEouVAu5amyr9jQZmuhqpGXTxrZkIht3Xh2+N8adtK0Rs9DcyIf70YIX24TsxN5YYc4Fn9ZT99PoZdFaNXKNnr/ejuplgCGZpFKZN6dh4Sd7a5YKn856sL4qE2p+6J8eNyNne2CY5LHIkhGS8AK10ErNI2AbPq5rAOeZ57yCjFz+Bnlr6qcDyc7ItwxdK2qVEJGOVpncY/wLWHRIqOSTx0dtAsWLuYDrYB/PvLb6sAedMc8OiK1NEcLYs+fTZsOgCjpWD4lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39WlTcuu3/QuQEHjx8xHoO0yguTZClzcEBYm8dafVik=;
 b=cr/ixR1t79Jttg2GYmtMXV/2SR2OkZmLzmy5nogbkTt88VIgsRFNJmU0cWqiSqdzqywqcs2DmZFCZqq37rfnJFZEhuFX8c+o71qJiA4QECspKOnXU2nFjYIMYv5tlBwHFu/P0rGvHlgbChUI1ZNb9ilgDTOR4oS741SNpKzJGL50wRgNRuICIFQREfRppYexzZykYSPhXX1cQyaRzN+C0jzZdyLoNycFbqz/zZjFo30j9vEXd8+f7dK0zEyQUR8lpzIbF7kvcGgdDfVa9vHuRpdY23DfNzK6FCRsVxALsj7geqrabcdh3AOO5YOIYbiG/fpoSXBOhrHM5E3+VKpRXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39WlTcuu3/QuQEHjx8xHoO0yguTZClzcEBYm8dafVik=;
 b=tvHav6vnzZTfQOl36yxUCEu0pDq9+ALwV0YCOYfEZtgNanAPg0RhpeW+euK+AvcGreg6tjchLhXj8Lza51yWl3CqK9el5/dCmE5e14bZ943LSijULXsrzqg7mzlgzxg68Gy/yowhbLdIr512k3XU+WciJNfIEkuUOqCWYV28LSKTCT1gnwMbYks6QZzGXdvB4RSRgbOYxYBUBz77c7dpfwyvZiGN2UCKjZU/vbqsKfWsgPwshmNXYkS7GO0yf5HKnpjZ1bnpjOEPRkdNEUSTHEQYcuMJ7ouJCKHiLowbx22a8ApvFlVGgvizG3CuBEMjcgXL7QmptUiMWciUGCyQTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by GV1PR04MB10941.eurprd04.prod.outlook.com (2603:10a6:150:201::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 03:30:15 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0428.011; Tue, 22 Sep 2026
 03:30:15 +0000
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
Subject: [RESEND PATCH v5 4/5] ASoC: fsl_asrc: expose individual DAIs per conversion path
Date: Tue, 22 Sep 2026 11:34:27 +0800
Message-Id: <20260922033428.1690822-5-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922033428.1690822-1-shengjiu.wang@oss.nxp.com>
References: <20260922033428.1690822-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0052.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::13) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|GV1PR04MB10941:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed04684-eec4-4352-7b1e-08df1859d147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|23010399003|921020|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Q0R3Kro/WhBNqS8BKmlAy2m+YIN+rj6EtPLLN2wJfrH5nu1K7MDAG1NDWU+3jyIwQpBcSPiE5HfogWbZFaqK8VOleQ0Vwliqpmv8hyW0G1vE6YeKkhU/Q2SJPup7Xv+t+DZL5c9CNXsGkCQUod/iq60Y/E5Vnv9YDzfVBHC6hcsyMLOvuIIoeE14mVt1Ts5CHvLKpC47TQpeLzYBXey+Kzu07oB2moOFt7P6vOUnXGUJ5D52PJNQYRVpadsuikILPTM5hjK6cWw2H1ccXTul0lkHvh+U8MzZIQCxkCIYCfvPGkGACzEd50JlZDBe6v4Q97y2ZDvJT2SqtCs9d60NXcI9gK3D5SRFl0iuaUWFQGvPRYz47qK2BjuqR+DbJKorAkrIpQwJSXhMUgWQwRyZmwvwtCiMZCr1XsEqgn5Nfw3hUgYA+Nyia8suFbENZyQz+VjegEuLW2lVqGLWjMIngxNwfzj9vCfxWrZLtaqF2Lbr+52mAIGyc9K84xB+67Y+2nUpU7tfHXDYxxIvLvCytNNYkZTluh1L9gSu/0kg4lp4qJg0PTKta0DO4Sml97QSc0eFWd84GJywSJNTWK7ISL1UqznCC5MXo89NN+qjp94Fu0Z7wL9MPqZr+uqwhv4QxKMy6IRrXtnUFOcwLtt/KCsSYJFMvs3lghOrN7XhOD1V1Ofpi31R9VtYUSrzHFVS6Gg+DTwJGp+Dm4VwCGRYmQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(23010399003)(921020)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QmXYxvIMFFhH4Y7KimfriLmyYqKCIPNZQWlYz7IABHg/PrflPtEkomLmNapf?=
 =?us-ascii?Q?mIsiUSGVAqXWYRAOwgEsy3c+UlJ6i9L8GQT58SLZD/CyTPVFMWAn5wFguBrF?=
 =?us-ascii?Q?uugfL0joGOaZlloLJeZoZMa0s8tdtT/GbEbW3fozu+ZUb7G1oNrv7gKvEvD0?=
 =?us-ascii?Q?Sa8paJZcz699B4KNOD+SZZCnhi5qM234G3Po3my5cwGcqdJ6BrO/qFMUrLR0?=
 =?us-ascii?Q?0FvVsg6FvVPvH0OX0MWHYIi848nSzY5eAdAMqlk/kITIrCk1Sz2hd7PfqtUF?=
 =?us-ascii?Q?Th8Ce44+QeHMFc1swC0sSIzTfBBPDGtUV0pBTJqKKAYK62xCcaZeKmkFmo3I?=
 =?us-ascii?Q?vsiFDJOzp6yaiYt0hnqet8NSGA3Sh7ICzz5ogA6hddLMyeHd50jEbSIIUEsv?=
 =?us-ascii?Q?Mj2fUKf0NItXz0l7nbPFgN2srSKfAWpjI84OO8RwjD0ug9XOkGaDV/gSD+5v?=
 =?us-ascii?Q?cEV3ivJ4h0uQXvbxQ17/WNO+MLAFXGJe9S+R6MlvXFYi9vCijrRuC+cH1oNg?=
 =?us-ascii?Q?dDVTNOWTc+E9uABnfG5FocEvXH635vE768KphGqyS+/Zq2E1l9ICoNAu3clV?=
 =?us-ascii?Q?czquLx44c+bSPbStwYRGxj/Q2M/wn0pYgdI+ArakZYuvTimbKs0ygTyT8YjB?=
 =?us-ascii?Q?iK0nAMlBtWXslkNIjWkxgp3rcOM45/A+Of7dEonH1407eqJuGqQ00zdEijrN?=
 =?us-ascii?Q?wUIjGG4nFgjFhXUaMXj6fFVx0au+FXwXb1RM8qVBqVPp9hHnpfsTpEEllVPT?=
 =?us-ascii?Q?q0rePKWXzj+86PLEeFLBMj1DwiwfW0RPzUyMCW7T1eCeoWhjRAyX4CrvRohx?=
 =?us-ascii?Q?Ud5Rn2yf9wXsJkBR2obn/UNZ/jtl22XFSWWFa32m62ag9iWm1Vck4q/0VjNG?=
 =?us-ascii?Q?foNqLvQfjQyE3rw4CwqGEiNg/PzzlZwBJVR8z2HxwjAtV/XMGk76zW94WEcx?=
 =?us-ascii?Q?JTvV5a9bjo/bMpmzAA6WP050jXm3w+DWPz++vyG8o7h+7tGfvDQ7dEPtd9SG?=
 =?us-ascii?Q?psmnsiRcIGcMYVj2cl/xWCiMh19zIHk3TS6FP8M9rfWaprJyk7njsNauxDBs?=
 =?us-ascii?Q?0JSMQwDYKxq++/aiBV5DsvFS81nbxCk80MD+HDhpKvVakzVB6wEJWcBizsTd?=
 =?us-ascii?Q?xzfE37brUdsNH9djoYrWq42N9mXGaDblxlG6NNa4Kz3SPw2T0IRl29cgmyCR?=
 =?us-ascii?Q?xYH5mP/Korb60v53UKP52Gh9uaqmUuWkeIcE1Gv/2gvbfh8aDK1BpgjRrAYY?=
 =?us-ascii?Q?bLMnlECYSsbP1q9waEud8QTBaHK9iflfRzckOte2a4OvuMxaOcLtJfgfsW/H?=
 =?us-ascii?Q?cahestB5DXhq2kqfeDQ544/loZTQBHWT1XqqNGpl95Z4hDMA0duBKbc5/EKQ?=
 =?us-ascii?Q?8t2gP1EjYMXrEOiJTiZzgGmCwL6el6LhhUoWsRLK82DuLcvS6WSHARtYy3R4?=
 =?us-ascii?Q?admsAO+Fjd1EZCXBE7FZaHs7Iut2z/LdCTtzCpHHQZY1JuteYOXDs1N2g0WF?=
 =?us-ascii?Q?gqFg1lyNaxcsqbWwz0eAucD3/LI5SGSAfQ8pqqxdMsL/6nK6E0CMS6XWJb3R?=
 =?us-ascii?Q?Bp8ClWFbr1aXc9TFvj7EkG+HSbWmtKwt8QpAyAooLjVfW63rzSILmfm403qg?=
 =?us-ascii?Q?QynlmZLiz/Z45h0OBqx7UEAv5e2sgxo6pdILHQESzqyQf6He3uTp6RECNISa?=
 =?us-ascii?Q?v+u5RI+rK3JAantipOrguVuDr1Hy1uAE8RqmadFCiKL/iV26QYtPRfWXH8Ta?=
 =?us-ascii?Q?W691md70PQBBrNdeqT4k1eMCcQZ+iCh4b1BcQdmU6XsPnDtMsU4+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed04684-eec4-4352-7b1e-08df1859d147
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 03:30:15.3123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35yREG4kdHB7tcfxAoczFFHqEtf8AFJ23eyaQFjzHYlbU5oY0ZO6xwKU59JKOGCmwNJQa8CmZSb/fGWeJHqhWugEv32nbm14o1eGtgC1SmOKkDkCqFB3fq9u9eVd3oYz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10941

From: Shengjiu Wang <shengjiu.wang@nxp.com>

The i.MX ASRC hardware supports three independent conversion pairs
(A, B, C). The driver previously registered a single DAI with generic
stream names "ASRC-Playback" and "ASRC-Capture", which prevents
multiple independent conversion paths from being used simultaneously.

Replace the single fsl_asrc_dai instance with an array of three DAI
drivers to allow up to three independent conversion paths to be active
at the same time:

  asrc-0 -- ASRC-Playback / ASRC-Capture (backward compatible)
  asrc-1 -- ASRC1-Playback / ASRC1-Capture
  asrc-2 -- ASRC2-Playback / ASRC2-Capture

asrc-0 retains the original generic stream names to preserve backward
compatibility with existing machine drivers and board configurations.
Each DAI retains the same channel, rate and format capabilities as the
original. Update the devm_snd_soc_register_component() call to register
all three DAIs.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c | 89 +++++++++++++++++++++++++++++++---------
 1 file changed, 69 insertions(+), 20 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 6007786aca66..56604fa1613a 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -792,27 +792,76 @@ static const struct snd_soc_dai_ops fsl_asrc_dai_ops = {
 				 SNDRV_PCM_FMTBIT_S16_LE | \
 				 SNDRV_PCM_FMTBIT_S24_3LE)
 
-static struct snd_soc_dai_driver fsl_asrc_dai = {
-	.playback = {
-		.stream_name = "ASRC-Playback",
-		.channels_min = 1,
-		.channels_max = 10,
-		.rate_min = 5512,
-		.rate_max = 192000,
-		.rates = SNDRV_PCM_RATE_KNOT,
-		.formats = FSL_ASRC_FORMATS |
-			   SNDRV_PCM_FMTBIT_S8,
+static struct snd_soc_dai_driver fsl_asrc_dai[] = {
+	{
+		.name = "asrc-0",
+		.playback = {
+			.stream_name = "ASRC-Playback",
+			.channels_min = 1,
+			.channels_max = 10,
+			.rate_min = 5512,
+			.rate_max = 192000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_ASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_S8,
+		},
+		.capture = {
+			.stream_name = "ASRC-Capture",
+			.channels_min = 1,
+			.channels_max = 10,
+			.rate_min = 5512,
+			.rate_max = 192000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_ASRC_FORMATS,
+		},
+		.ops = &fsl_asrc_dai_ops,
+	},
+	{
+		.name = "asrc-1",
+		.playback = {
+			.stream_name = "ASRC1-Playback",
+			.channels_min = 1,
+			.channels_max = 10,
+			.rate_min = 5512,
+			.rate_max = 192000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_ASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_S8,
+		},
+		.capture = {
+			.stream_name = "ASRC1-Capture",
+			.channels_min = 1,
+			.channels_max = 10,
+			.rate_min = 5512,
+			.rate_max = 192000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_ASRC_FORMATS,
+		},
+		.ops = &fsl_asrc_dai_ops,
 	},
-	.capture = {
-		.stream_name = "ASRC-Capture",
-		.channels_min = 1,
-		.channels_max = 10,
-		.rate_min = 5512,
-		.rate_max = 192000,
-		.rates = SNDRV_PCM_RATE_KNOT,
-		.formats = FSL_ASRC_FORMATS,
+	{
+		.name = "asrc-2",
+		.playback = {
+			.stream_name = "ASRC2-Playback",
+			.channels_min = 1,
+			.channels_max = 10,
+			.rate_min = 5512,
+			.rate_max = 192000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_ASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_S8,
+		},
+		.capture = {
+			.stream_name = "ASRC2-Capture",
+			.channels_min = 1,
+			.channels_max = 10,
+			.rate_min = 5512,
+			.rate_max = 192000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_ASRC_FORMATS,
+		},
+		.ops = &fsl_asrc_dai_ops,
 	},
-	.ops = &fsl_asrc_dai_ops,
 };
 
 static bool fsl_asrc_readable_reg(struct device *dev, unsigned int reg)
@@ -1393,7 +1442,7 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 		goto err_pm_get_sync;
 
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_asrc_component,
-					      &fsl_asrc_dai, 1);
+					      fsl_asrc_dai, ARRAY_SIZE(fsl_asrc_dai));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register ASoC DAI\n");
 		goto err_pm_get_sync;
-- 
2.34.1



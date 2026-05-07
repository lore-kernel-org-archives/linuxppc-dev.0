Return-Path: <linuxppc-dev+bounces-20539-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E9ECD342C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 01:38:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9vzR6Pzhz30BC;
	Thu, 07 May 2026 11:38:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778117923;
	cv=pass; b=KHgkRXTmnBXrV5ob0s6orvKvwYx651a3+ZdOfLhhtBvFAxM0F5q8URR8t2RRHMipam84x4XXJ191tRdnl5Pm+6teUXSdFdVPhNN6Km7uDgg0SvV9pbJKp1cZTs2Yuor2KtTXctrUmuLhH2pT6bSMFBWc6qfOqdmEIcCzN8pZs/fHlTtiW4FmtlonQ01nEDstejLH0xy2uX68Ge+Q3NA8kVwM9BTjqJNVt9GZtN1cNU5sm9z4GuHPXis2uRv+6R3LumSXiQtlp+RkzmoU3WES7IT1TANw/ByeUjjvhCMEcJHWXGGusuKluUREOwBqPjXjU/Mp38adG86ePFxkrqYUNg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778117923; c=relaxed/relaxed;
	bh=iAD4EcvYTeP2cXqrJeQ2CUQFMiIt5yCxaTk4tuvx+LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=goOTaj8Z6mLIWRZeGed0MFyncMaamGxm+W0lVEsqaorr7OmyI3+FZjysUgs3e0P1BQXKM+r2FsYhPlX/omDB9WC6Sl+1foH8VM1NsSJ1wWX/ybZ5b85NLWjmRQpzYtaEUmfaMkoe+gSv6vA6BIxGvPLlX8dqnPWmSVz6hJaPsC0KpYdA/VYLwtnltb3S0MINXZW4MrEf6RoGHjYRrfGvoHm5wrw0sRJA3VU+HUF/nO9tkxSMSnShKUqpvqkygA856SuAIPBlehjm925sYoieBPPo/V/HE42Vp2TaS3zgLuUL1BYbXTgKNDqEi6Z2Rx9+SAOf2TFXeJnHTID5G2x1xQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=IV9TXnHI; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=IV9TXnHI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9vzQ4zsnz30Pp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 11:38:42 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVVRqN1i13hkYWUL+4PsD/tV6uAOlsK8B35hz789xIRAoRaGLhtwUSYomC5PKn4OzIRSlebnueyAtDm9YP0kaVYkW4ehenhU2kaXRpCDPKDeLyRXra132uZcKvuaZ0m9PVoj2LYY7634Maot5EkyfjpCgD2VWXDypjYnGyNyu/cEzaEUEnMb40SqF1Ckkjn4ZnvdukJIBTgDJkYuxLMZhkCLHIvVQy84pfm6TJYpkh9xB6Z8zeDFcDsARTgb+6yQ3AzCd0NnL3qS2JIEuYULG+7iAqVMYptuErva9lrD8iR2uB3h6VFK8MyXKJQhj8DskS6AM5s4rENovBzZ5sCUxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAD4EcvYTeP2cXqrJeQ2CUQFMiIt5yCxaTk4tuvx+LY=;
 b=jLtfHEc43JrLqeiXPAHKqKK0CCLN3iQl12XWwQfJ2JXCtrfHtIpaf5xTd5Ls3gJz7H292Sg1F3mAV477/glNc75Sj+Gwq6kLhfwMayprtzlIcvFQ9iYqcWGEsHBFVeqh7WIexUVlEXkcA3drfdCR3552be/bZ8XQS0BYEttSyAVYf5tPvc8KCoZRPbRHkl7aOg6fmZa5LDn8mf0DOS3/wboC/9uFajPiV89051Zhsy2aTjFOukYc00Fx02cAyCQDWbrwIhIKYI8D5gF7JHoTQDo8C0yEubazSrcg6HVI6AuxYHz2WZsMfJwaztri4vIj2DpX/6OKPOWnecQOBOyPKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAD4EcvYTeP2cXqrJeQ2CUQFMiIt5yCxaTk4tuvx+LY=;
 b=IV9TXnHI+KwnW2WIDR+ld4o1ydHHC1RaowCRBgDvERk8KHp1f+ea22z4NkO9eJJGQ3uP5JIh8tpqna3XSANjlUfWYpAHT/ySu5bfV2RdDEcrWL1rfBgeNHfggekgpdkW0R47e8C/FFHlyYTUP8ZrmB2+VXDQ9kmPDrAA/ywwP7bZ5wRyXJfSaZ3ZezoetoQ7HBiOTfyRnjTr5Iw0vF1gsWn7b2FFdGAtOAH+tQlAtFXcaR+hoqncaVQoYcaEsFEM7Cnd3/OLasfbP1lKqNYPAs+W8gKfTVai+M1avZNhcprMnzEhUilk1F1ILpyq8bSJ/ipUxn9F0gCjl58z3a9j+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::22)
 by PA2PR04MB10514.eurprd04.prod.outlook.com (2603:10a6:102:41e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 01:38:24 +0000
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc]) by AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc%5]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 01:38:24 +0000
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
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	shumingf@realtek.com,
	pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/3] ASoC: soc-core: Add core support for ignoring suspend on selected DAPM widgets
Date: Thu,  7 May 2026 10:36:53 +0900
Message-ID: <20260507013654.2945915-3-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260507013654.2945915-1-chancel.liu@nxp.com>
References: <20260507013654.2945915-1-chancel.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0087.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bf::14) To AM9PR04MB8353.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8353:EE_|PA2PR04MB10514:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec2e5e5-2e71-49af-3dd8-08deabd95414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|52116014|366016|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	YX2oIFh08GykbtrnRYy/T6BCkS5e0SPZ+qxRvG6LH5x0bVV6lHI67DAHiiP4savaHVC6WlLiNBVjQv7QF88y44rwm6ysO7qbnDyu0k2Hx5HH1X9DhpCapKmQcSz3/8f0nbXyQWMgurZNzlg52H0vVXt/rXFGO31xkCPYWvRNMhColACZfFJ5rY7A2aaLLsDEx419X186fnoCxGR5m3CcMU0siEuHO/WU5nxArPtP/hILNykkT0W2jEAoPSFpUA6JMQ5lKduoLQbc1N9yjysrMREsTw1dGCiQjoPggBI1eqvBVeBSJ44RrlUYTC5bEj46jk3TR3RxeqAvZ8qyG0q0CsvfL5GiLXX8L6187Wn4fJBPbDuFWIc1pwNr7VxjoAPg9MJPBtL3YbfzVFNOjY+aZ+bggeCV2WRyTuRy8xDjm4UnMCvS8OdkYSS8NI7ZvbLPf3jMlB4U6DXJB+3E6VQyI70mWPAAkHt+NF88PLqunp6Ab/3S01AlPPJ8WBJ9zaCLRnEuPcIKablxpM164pSqfKlPiSRgqSY/zjxa08hymuua1zv+dkL0R51YF6/xEFwzCRBTKR3KNT8psOi4JB4DwYv8J+Joqfpt0XI4UzsRANP7GYFgq3gusRj9s6vv3KQbJI0cbTYhw/YU0srPdS2SuqlYtS6SoJRqm54jFWrZtPnF/67h1uWHfOefHNWd9/vO4t8WlEZAFPIwahOre0iw8OiDxgxvXP+dRAMiZcdc/4/b2vqGoM1SHeMqEuqJZ26D90ZZpXgZl6mNWv97XwhMdw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8353.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(52116014)(366016)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ir9QyJIS/Nyq/Ho8SUKdrS9Xv2KUDgpjZTjL9OCgi5GY649dSXutBZRFgLOJ?=
 =?us-ascii?Q?P0HeLuOYbQBYVIzTRHWxNchFaqtixEIFToaJa5FQaHW16JfsgpwwCZFUgPVJ?=
 =?us-ascii?Q?7R/xM8z43DRnXj8pktN23UBbBsX+5R2cdfmZBKqVza//gsUOXuZ3hU4pGwfc?=
 =?us-ascii?Q?C2UCLk4HGAO8b3GyoZL0CowBQtRH+19LJrRy+CbNiBdxKRodt1NRIvCMTm6U?=
 =?us-ascii?Q?p/JcJc8JKsNzwsDTk1YUYGGs5HqSIhlPY0ZMpEpP76vsK80tEgcONyeOpKQh?=
 =?us-ascii?Q?Sqd5EPO/yx2/t4t9W/2oPBFnllBZkULp7pZiJ1jHaEMOZTDF+cukphrttj/G?=
 =?us-ascii?Q?4PYq2A6eHRJCGLM/jT6kqjdz5T4wLeudrzR0am5k5vfFkyO0/W5Eql517w9s?=
 =?us-ascii?Q?3JsnEVuAf4IrZsvGpzDnF32ZO/TF+XXadmY93PIYG6fJbcl9MGGK+9icd8V5?=
 =?us-ascii?Q?41yYtSqoJvaqWwDIK24Tn0DoSzzrYMvOqtO+44deHIdoMHboRpixZ4S/Elfp?=
 =?us-ascii?Q?w8OdXxYLnmuJrvsUT3ZJ2PLk35FiREen9UrjPn+nesgHiHLTp4ZrnVaRQPWc?=
 =?us-ascii?Q?5fETvRDpsaYBFCoRd8CTLzgtljxyr8dyEpCdRt0bLy1hVNuxZ0e1awIB8fQa?=
 =?us-ascii?Q?5ECq8FBQ+ESCo/r7ZwwljM7KjGsh+qHZuPikbgXc71a1IjjDtEfzs/KxsXsD?=
 =?us-ascii?Q?3escCGbE3p1Z9/LaGES+g9x0bLrVcQX5AsKu9B/cSFFHehZVhWMm1mMooOd1?=
 =?us-ascii?Q?xbkoD+ZHlccTWLIBznWzNXs0e1TzehS7ZaUDsB6UOwMS4Q5dDwdJ6A0YKen4?=
 =?us-ascii?Q?RUdIT8FdQ2sfnXgyUTgoCadPKn5fBTLroyyeapbiWai0nA2Zy8xLYU5/6Yuo?=
 =?us-ascii?Q?6eAw+UunWZOfVkEDMQpYtmAKrPCPK2TI8+icEbzMv37SSxkufybpHZI0kfqY?=
 =?us-ascii?Q?JrucdoTie7FHzdq2rbhKyVSjSVVx2nACR4pq9WolxqQH6ey6vfjBLbsH1p03?=
 =?us-ascii?Q?QHkyFNDYroSEAXIgZLgn1eIFqOzv5/Vqbpj3O1CxNB+ch87G6B2r6BYc1BXd?=
 =?us-ascii?Q?61nftY5HenOMeFi9nkBU1ZlypcnGtBRmj+rhNy2W3jxJ4VbmgVqBD3udBMB2?=
 =?us-ascii?Q?zAXeppvJ9pt5DYtKawXko5NBcYNidcxkJ6wtgLYPMzFnjnKOhmdvmgEmHPW5?=
 =?us-ascii?Q?ijWGQ6aVp0+7uMvcjPVrqvDiFI/VftGWxYks3D9brNH0fUg/K3OCvFNqKE6/?=
 =?us-ascii?Q?AIto9yLL6RDcQNB/qZ9Dn0PSs58ZWdEwLiQdZiBTV6ewaLr+r4N2WuysS3Dg?=
 =?us-ascii?Q?NQFI/ho0MISBdPrqRolb25IgJ3gDVX64paRRV1Gxkzem/+Il2i4JEZb6Mvdz?=
 =?us-ascii?Q?9cffjAqldn7XuZQkUEpQSQYnr/m3LiS2WwdGxWopdYDL0R3q8YU4lyFQKLdu?=
 =?us-ascii?Q?QKsjicjHqIyjA73Gq/3cQdg66N0YK+w0TA/RB1OXuYhpcMr+3zWZhd54bJI2?=
 =?us-ascii?Q?5YnUPxgMIT7imJAZ+HY2iA7O+E1sElhB3Nt8kO75CGkyN1ErzofCCHomvAYo?=
 =?us-ascii?Q?sR+aWSdh4hyLjvBQI6BJ4wevORaZpsBfoPc0fFOyb6WOn+0fo0w+LqUp+Dqo?=
 =?us-ascii?Q?/W7sG5wQ6CxrQGZhBaG7xjXtp902K8NZz3RGjfreQttU9yOnfX/ft+uSVH1C?=
 =?us-ascii?Q?aKXcPrIzecIydWQK8hX/9ZsomXc8nEctdms1uYB85kI5EW+WRK9ZgUttz1AD?=
 =?us-ascii?Q?SbjLUct95g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec2e5e5-2e71-49af-3dd8-08deabd95414
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8353.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 01:38:24.0856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJx/t6b5IrFPqu7RVWM0rJh4r9I0O+bR9XDHudgf05A/DbilnSOenTWOzlZfQBrIKgpHB6AQw/FcuFmKvSWytA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10514

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

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 include/sound/soc-dapm.h |  1 +
 include/sound/soc.h      |  5 +++++
 sound/soc/soc-core.c     | 43 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/soc-dapm.c     | 30 ++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index c1e4f467efda..b0a135b9af50 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -636,6 +636,7 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm, struct snd_s
 void snd_soc_dapm_free_widget(struct snd_soc_dapm_widget *w);
 int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card);
 void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card);
+int snd_soc_dapm_ignore_suspend_widgets(struct snd_soc_card *card);
 
 int snd_soc_dapm_update_dai(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params, struct snd_soc_dai *dai);
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 5e3eb617d832..7d6fa79f48e3 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1057,10 +1057,14 @@ struct snd_soc_card {
 	int num_dapm_widgets;
 	const struct snd_soc_dapm_route *dapm_routes;
 	int num_dapm_routes;
+	const char **ignore_suspend_widgets;
+	int num_ignore_suspend_widgets;
 	const struct snd_soc_dapm_widget *of_dapm_widgets;
 	int num_of_dapm_widgets;
 	const struct snd_soc_dapm_route *of_dapm_routes;
 	int num_of_dapm_routes;
+	const char **of_ignore_suspend_widgets;
+	int num_of_ignore_suspend_widgets;
 
 	/* lists of probed devices belonging to this card */
 	struct list_head component_dev_list;
@@ -1339,6 +1343,7 @@ void snd_soc_of_parse_node_prefix(struct device_node *np,
 int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 				   const char *propname);
 int snd_soc_of_parse_aux_devs(struct snd_soc_card *card, const char *propname);
+int snd_soc_of_parse_ignore_suspend_widgets(struct snd_soc_card *card, const char *propname);
 
 unsigned int snd_soc_daifmt_clock_provider_flipped(unsigned int dai_fmt);
 unsigned int snd_soc_daifmt_clock_provider_from_bitmap(unsigned int bit_frame);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3fecf9fc903c..705181dae472 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2289,6 +2289,10 @@ static int snd_soc_bind_card(struct snd_soc_card *card)
 	if (ret < 0)
 		goto probe_end;
 
+	ret = snd_soc_dapm_ignore_suspend_widgets(card);
+	if (ret < 0)
+		goto probe_end;
+
 	snd_soc_dapm_new_widgets(card);
 	snd_soc_card_fixup_controls(card);
 
@@ -3294,6 +3298,45 @@ int snd_soc_of_parse_aux_devs(struct snd_soc_card *card, const char *propname)
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_aux_devs);
 
+int snd_soc_of_parse_ignore_suspend_widgets(struct snd_soc_card *card,
+					    const char *propname)
+{
+	struct device_node *np = card->dev->of_node;
+	int num_widgets;
+	const char **widgets;
+	int i;
+
+	num_widgets = of_property_count_strings(np, propname);
+	if (num_widgets < 0) {
+		dev_err(card->dev,
+			"ASoC: Property '%s' does not exist\n", propname);
+		return -EINVAL;
+	}
+
+	widgets = devm_kcalloc(card->dev, num_widgets, sizeof(char *), GFP_KERNEL);
+	if (!widgets)
+		return -ENOMEM;
+
+	for (i = 0; i < num_widgets; i++) {
+		const char *name;
+		int ret = of_property_read_string_index(np, propname, i, &name);
+
+		if (ret) {
+			dev_err(card->dev,
+				"ASoC: Property '%s' could not be read: %d\n",
+				propname, ret);
+			return -EINVAL;
+		}
+		widgets[i] = name;
+	}
+
+	card->num_of_ignore_suspend_widgets = num_widgets;
+	card->of_ignore_suspend_widgets = widgets;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_of_parse_ignore_suspend_widgets);
+
 unsigned int snd_soc_daifmt_clock_provider_flipped(unsigned int dai_fmt)
 {
 	unsigned int inv_dai_fmt = dai_fmt & ~SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a26771c8e6ee..4e3feb43836c 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4604,6 +4604,36 @@ void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
 	}
 }
 
+int snd_soc_dapm_ignore_suspend_widgets(struct snd_soc_card *card)
+{
+	struct snd_soc_dapm_widget *w;
+	int i;
+
+	for (i = 0; i < card->num_ignore_suspend_widgets; i++) {
+		w = dapm_find_widget(snd_soc_card_to_dapm(card),
+				     card->ignore_suspend_widgets[i], true);
+		if (!w) {
+			dev_err(card->dev, "ASoC: DAPM unknown ignore suspend widget %s\n",
+				card->ignore_suspend_widgets[i]);
+			return -EINVAL;
+		}
+		w->ignore_suspend = 1;
+	}
+
+	for (i = 0; i < card->num_of_ignore_suspend_widgets; i++) {
+		w = dapm_find_widget(snd_soc_card_to_dapm(card),
+				     card->of_ignore_suspend_widgets[i], true);
+		if (!w) {
+			dev_err(card->dev, "ASoC: DAPM unknown ignore suspend widget %s\n",
+				card->of_ignore_suspend_widgets[i]);
+			return -EINVAL;
+		}
+		w->ignore_suspend = 1;
+	}
+
+	return 0;
+}
+
 static void dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream, int event)
 {
 	struct snd_soc_dai *dai;
-- 
2.50.1



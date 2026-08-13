Return-Path: <linuxppc-dev+bounces-25800-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5160C5B572
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 06:55:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLGM94QLCz2yfp;
	Thu, 13 Aug 2026 16:55:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786604101;
	cv=pass; b=eEiDA4hxmcBPv2B+EU9Ncd3ststf5x1e0gojfkRxoSn8LgqzLRshlTaJ8H+Aa7EQDlXmcFZn4JDD0PZxSUv1xaqyUqWN2m/qesatUPWe9EXSXA13ujZwAtSZ5llmRjKcMWiICeIvD5VEXcG2CP20Nqath/ZUe8KCWTBa5W5aR6n0nCET+STDdL9/tswZv+hAS5Xynx4SRnlQtgU/w+wePxMl/sK/r5ffsHjZ/Dyxu76bkZ/LxTwf12F1X5OI4JncBDjD9MIYtWTbVFOFqkMnFfVOacDnb7P/7pY6Y1PlEbituqcOLD9OmTPkrArmNp13FRwuT0oawsHPWWZqxR4yYw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786604101; c=relaxed/relaxed;
	bh=/CzRYmgvEgHhL4sL39EzP/B1mwsZaNash8DX3LTcnRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wnq++Pb3WY0AcbHedk2AOFaVhSjRnMfAmZQJpZCqNSW4hisZhd3raozvoC3mCpmMo3FgpUyjnonp/6ueApW+oGT5L04H60HZVkiUCm+EnXjk5Xq5PY7SsX4arWAvpInxMRyXUMtHSt03RvpFiIXiOvcCQfpQhTxIDnQ9B0i2TKZelqr6SdGiSi/aLIB/1fPh2E8GhdSKV3IGddvta4br0/Gz8dvXWj8XalzOKYgNNHy+7syJqnKTvlqsvcmA6yl3UfxwrhsY5tPdkh57SDzG6xnvVlGp8QmU26vL226mKoEgUfny/I3nszvkFCWLi2PzZ29HXcl39ZhaP2tXZPvNmQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=vpy3tsYH; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=vpy3tsYH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLGM8457Kz2yfR
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 16:55:00 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdlWUbOI36p2Hw+fKgn7MxWC0eDA67BwEWZsZ3g0aM7KLnaq50tAI+Mmk5zONvz1Fu6Vmd0rmHhBVxG+8vtdNSppng39yPl2qtwTnrQ1elSmMM8csINstxtCj4pHArZbGc8wb754LWt1NnCMGNdiUdAH/0iifcwUHDOgMLOX8tq/VcqOL7pkJLnCq4ATSIhO60kjFkoGmCcxp6yCeZDZb5SXiGp8ZSU3fdzgV4aa5wbN7vRfaJ5e44zTOsLT4h6C//GqW2FJhmowcFD71hcTFKtnoSfl788wjl7iMahtqiqMEGl56iZYrvauJgyxtXTSOC3KuFwsfYQ+RWBULYv76A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CzRYmgvEgHhL4sL39EzP/B1mwsZaNash8DX3LTcnRc=;
 b=pczT2aXD75MCMHAA6XaFDjGhwRYPl5MxZtvaNZ/kYhnjRsbbEOK1nIGEbMVxrElPe67zttrpu53D1C8wOdE2/v2DC7QlxNNXwe3KOIKH9ip7hW+Qkaeq54mHD18EqHS9/DfTrJ5AcwgVOc+05GZ0HcMJ5EUTpyKsEu/cOIn4unBZm4M220Vjt/aLPQnUgXtzh/99rIe0vt+poJUtx1Ri0zLo5ZUlzUUoi8uxsxCI9z6kfysLDTVM3dCc3boZGdCsWhHNBjIggTl0zqI8FCc/3jaFbTqs2yylc5s872xthhprGaoBcfEoW9L6i5db6t0BBfp3VY/lqw1Z/V5DeuDu3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CzRYmgvEgHhL4sL39EzP/B1mwsZaNash8DX3LTcnRc=;
 b=vpy3tsYHhRg6vjDvd0gwypx/2i6b5vRBvJ5iReFb89+s56xVAyu15vJkNudcXWrBQhZPy1b77la2v3GWyPaEbp3MB0DcueM0aEf1lPHBPaBw4xjzNrN4EvVIgCSVxtf8igpg88JZQxmBUBFnHi2PRrzqlZRJRAfsewJ6aGYlTMKjb1sxDCh/xoX+uk6jzUkmljphYdunaagtFph7WekKPLHbeuIV+g3jjrcIJYW+NhaLkrl7iw15xN6TmlGlft2ONTAwfyTrUd8W2T7FOvQbEBSxDeQ0ct4B1LTF8HZxqG5lBdbXO9+6HX5eYYhCdFvTcfCljFuYUhjTBlGSgsC+CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by AM7PR04MB7158.eurprd04.prod.outlook.com (2603:10a6:20b:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 06:54:29 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 06:54:29 +0000
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
Subject: [PATCH v4 3/5] ASoC: fsl_asrc/fsl_easrc: move DMA params into pair/context struct
Date: Thu, 13 Aug 2026 15:00:18 +0800
Message-Id: <20260813070020.719810-4-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260813070020.719810-1-shengjiu.wang@oss.nxp.com>
References: <20260813070020.719810-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|AM7PR04MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: e05e7462-0c26-48a9-41b8-08def907b901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|19092799006|1800799024|921020|6133799003|10067099003|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	o5fMOaVwpnX7t/WIcBMitB0Mk4KTtesx6f/GVdjLdHXZdAsPsLs02g0MWuQNk75qXr1pjyL0UNSfMra/LEmaaelTx9vp8MoEd32d8/M9TEY1m4Arwm8oQ8t6I/J6CsyQRRP340Ep2HvJTHtrk5kfwa7KxNJddS61Dxl65TgOQq/jK4y0M6Sf/FgSCsp6TzGwLp+S/8Tm6ZoDmwykCdrkpVbIjHY6C7tPJwWlEux6k2cePJINs7ZNaAt5EB2xde2mHRKmMB/cS8m9uLBTdJGHltbpKZ16YlhgYN9w1QjEKMYJNMvcDGjRSZLLi3nqwWHjaoJpkDNjgkjt4zJjNq/d5xc/XCTPocey0ixdhojERfE1vZpXM23t4sv/LOXHXcMT6VONtfEBNhmUd0rUMPgDyn5TnR6przlgXmefvGMvqi4bx5rfcxR1Bkf+njFG0820WNuYubVdUrW9WfrMz5I67M7U3Jll31oSwNCrq2fzTFYuiLunPh7Pjujeo43oXmlZMaHE9y8bbmJL+GlZKvVQ1wIJiGXCPOx0XpsfHvihpB15yguBXp6mZ5D2V+dEDQUTXvYTgruVW+977r4mxrEgNKh12ymUjxgxL/QvWbDezYVEmxVsECqNaSOp4RqU/I7+c4kqDDNLwRu3zqn/XuEBxfF9fm4hXm0mZer9cViC3sR5Z90ylOf3BKzmbeZDLLMpgYxFcI7mF2BHQlN51iZTuw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(19092799006)(1800799024)(921020)(6133799003)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uyIhKFa57HTvkZ4c2de87C4iWyQOZX+pQUwjgsn5GGAlBwpn/z0vBzhheDp3?=
 =?us-ascii?Q?tkcXn0zO+v4Zl8NyR4J7Lxs+sX/uha+T0yZ9nsf56adl+3574DaXjfPlNHhO?=
 =?us-ascii?Q?ZcLeU0NG0h8DKcBtZm1DyoV5svo3ytum8Y93WXDKbBlNveypbF/rEb9CxTx9?=
 =?us-ascii?Q?7ATC3l1B02CxtWkfhxoORoFUDrK5rFHjXsFX+J5eTN8VvtUjwKfgmojuOTak?=
 =?us-ascii?Q?D70eXiGzqcUX1nOWgRvOojQg0P/FYfeaUg5zxPPupV7AijQZYvmTRW1FKGH5?=
 =?us-ascii?Q?pEpwc5mzj7r3TN+rrOZo9dO4STS0X61NkPiO7mnCHcJKtjKAeUiel4sBRaIk?=
 =?us-ascii?Q?wATTaeZJV3So5V5YvRHjBjtbJktAvAeRDl4KDwRys7VhzlcDDD6TFQhAS2WU?=
 =?us-ascii?Q?EVJBnOvclIMxbYuvBdr+vEl+W5ufnsU0VtU83VdG0pscZE/pJTkSV6DuCRHV?=
 =?us-ascii?Q?85K0HaX7vbklOOWFowhgeUj36wiVF/QN0jQf2vuJJSBe1GLxNJMXPv1UC1lH?=
 =?us-ascii?Q?4skCbTTYuLiQmiLG+/omI9eCqu5KwINEzlfL256JurDJExlhQJVaRGiTKKWj?=
 =?us-ascii?Q?mlf4AEYpfGlvJw69zofeBq2OFFtRBQaAOSnRb8wnsKgV0NDSVdht9GkXiq4j?=
 =?us-ascii?Q?byM0RnSmhevogr7CyE+qMfTtCq4SHHBYjGXGDqvJwQHqehI3GHqJJj5PPcDt?=
 =?us-ascii?Q?O8RsZpa+pKohVr+VuJflRq522SHQXINo4ACEKqPxSLdCX/k5rNF/ZOWGeL7E?=
 =?us-ascii?Q?IlSavE2UiIyFtvB9zSYFBMXjXxZaMfxYJ3b4w8gk7z+KIBBoP+dfGh7Q9Ko/?=
 =?us-ascii?Q?yKRXjn1pz1imlxj1C1VP9A1kBkJk0/aj3OUpltBn6QKALTiK6mYi7SdzI15m?=
 =?us-ascii?Q?KasRkZMj/ZpSFTQ/UGb2uwDW70HuDxPRMKXJMbOcG5olOw5Vq48flKbhjq6I?=
 =?us-ascii?Q?tX2/R1Ho+BjBC+eS/la4oK7fJXQ31d6pVduumXoY1nwB6QG1WrZ3dbt9qYg1?=
 =?us-ascii?Q?UQcAVUhcYRF5SlKRHSWEbJkhgsLsoNwE4LepNAOPpu4D3NVZ+V1jNxPrC4Dz?=
 =?us-ascii?Q?iNzBV656OSwTUjbNj0XYSNJb/s603KclerLmhGEc4RVJNO8K+DJ+wa5Lrodk?=
 =?us-ascii?Q?9mTQrCXhK5NExvhnnr7fVLzgWflOIvtO4Gg2iGo2Ke6yfOYamIq2vPmXzH2c?=
 =?us-ascii?Q?7ri8C1NwaKYwJS+VifA0EIxvkerKtHfQTk1ncZZ6n3hMlefyG7LwQmlR8rbY?=
 =?us-ascii?Q?6+grDfjsLq5XnjdVLo1DtK6qedzoPds6HWeCpGadjMgpZ//sdfPCcw7ps4XO?=
 =?us-ascii?Q?6zCq89GSKP1qdrFU7lJxbgpGFgyKWJm+ovNh7F9ygw4Zsp0fK7iMml2MoTsC?=
 =?us-ascii?Q?nz7aErVYXzUM10Zz+uMyByfQUtXIBtKhvO1iLo7ToWT/2sEko1CtUCSyGzdZ?=
 =?us-ascii?Q?gzYiQg1B+nypYY57dP6wOf7SeNCMIXezqfEQvaTc5z4RVBT7zB3iqYf3Lqkf?=
 =?us-ascii?Q?No/5tKaHi/nfeZivt5CK/Kf9nvzdMlIVsrDgQPO1vU6C4tZErao7YFUa8xlq?=
 =?us-ascii?Q?jjlwwT5akFvCDFFWuIBe491p0y7/D4gxTKIHlUtW01Bd3ya4yQnDaJjW3lJn?=
 =?us-ascii?Q?JfJJsx6Fx0oqfa6vDEB4WzRf/2M42FMi0h04pS3s4c5WkpbqdPb8ulM9KvnV?=
 =?us-ascii?Q?mLtWieFIDoZAZEre2b88knZMngmPEb7HuNj/27MrmYt9cH4X+7jUuY7Vkzuf?=
 =?us-ascii?Q?TylUOYR4B07cbc+TKtD/OFQbkTlF9we94pMfallLRNOv/0PJvo47?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05e7462-0c26-48a9-41b8-08def907b901
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 06:54:29.8521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCvQNPlzQMnCdysieYgLNLfIohgIB0CLViTWK/GSwnw44/K2sCLdE7O14XUQu/PWwewkeNFX1jn920qB3OrnLqRpWg/Xi84fgACxnDhlclADSbipDsmT9bX8Ua19hAN9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7158

From: Shengjiu Wang <shengjiu.wang@nxp.com>

The shared dma_params_tx/rx fields in struct fsl_asrc were a single
instance written by every concurrent fsl_asrc_dma_hw_params() call.
With multiple DAIs registered (one per pair/context), parallel stream
open+hw_params races would corrupt addr and maxburst for all active
streams.

Fix by moving dma_params into struct fsl_asrc_pair so each pair owns
its own copy. Initialise them in fsl_asrc_dma_startup() where
the pair is allocated, which makes the per-DAI probe callbacks in
fsl_asrc.c and fsl_easrc.c redundant; remove those as well.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c        | 11 -----------
 sound/soc/fsl/fsl_asrc_common.h |  7 +++----
 sound/soc/fsl/fsl_asrc_dma.c    | 14 ++++++++++++++
 sound/soc/fsl/fsl_easrc.c       | 11 -----------
 4 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index df4817ae91b1..2755ee57c6a1 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -781,18 +781,7 @@ static int fsl_asrc_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
-static int fsl_asrc_dai_probe(struct snd_soc_dai *dai)
-{
-	struct fsl_asrc *asrc = snd_soc_dai_get_drvdata(dai);
-
-	snd_soc_dai_init_dma_data(dai, &asrc->dma_params_tx,
-				  &asrc->dma_params_rx);
-
-	return 0;
-}
-
 static const struct snd_soc_dai_ops fsl_asrc_dai_ops = {
-	.probe		= fsl_asrc_dai_probe,
 	.startup	= fsl_asrc_dai_startup,
 	.hw_params	= fsl_asrc_dai_hw_params,
 	.hw_free	= fsl_asrc_dai_hw_free,
diff --git a/sound/soc/fsl/fsl_asrc_common.h b/sound/soc/fsl/fsl_asrc_common.h
index c8a1a2b5915d..4e6b00cb5d63 100644
--- a/sound/soc/fsl/fsl_asrc_common.h
+++ b/sound/soc/fsl/fsl_asrc_common.h
@@ -53,6 +53,7 @@ struct fsl_asrc_m2m_cap {
  * @dma_data: private dma data
  * @pos: hardware pointer position
  * @req_dma_chan: flag to release dev_to_dev chan
+ * @dma_params: DMA parameters for transmit/receive channel
  * @private: pair private area
  * @complete: dma task complete
  * @sample_format: format of m2m
@@ -76,6 +77,8 @@ struct fsl_asrc_pair {
 	unsigned int pos;
 	bool req_dma_chan;
 
+	struct snd_dmaengine_dai_dma_data dma_params;
+
 	void *private;
 
 	/* used for m2m */
@@ -92,8 +95,6 @@ struct fsl_asrc_pair {
 /**
  * fsl_asrc: ASRC common data
  *
- * @dma_params_rx: DMA parameters for receive channel
- * @dma_params_tx: DMA parameters for transmit channel
  * @pdev: platform device pointer
  * @regmap: regmap handler
  * @paddr: physical address to the base address of registers
@@ -128,8 +129,6 @@ struct fsl_asrc_pair {
  * @private: private data structure
  */
 struct fsl_asrc {
-	struct snd_dmaengine_dai_dma_data dma_params_rx;
-	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct platform_device *pdev;
 	struct regmap *regmap;
 	unsigned long paddr;
diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index 2f662bdf14d0..15f2dccc3584 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -392,6 +392,20 @@ static int fsl_asrc_dma_startup(struct snd_soc_component *component,
 
 	runtime->private_data = pair;
 
+	/*
+	 * Point the cpu DAI dma_data at the per-pair params so that
+	 * concurrent hw_params calls on different pairs each write to
+	 * their own struct and do not race on addr/maxburst.  Use the
+	 * per-direction setters so that a concurrent open of the other
+	 * direction on the same DAI does not NULL out its pointer.
+	 */
+	if (tx)
+		snd_soc_dai_dma_data_set_playback(snd_soc_rtd_to_cpu(rtd, 0),
+						  &pair->dma_params);
+	else
+		snd_soc_dai_dma_data_set_capture(snd_soc_rtd_to_cpu(rtd, 0),
+						 &pair->dma_params);
+
 	/* Request a dummy pair, which will be released later.
 	 * Request pair function needs channel num as input, for this
 	 * dummy pair, we just request "1" channel temporarily.
diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 77c5009cc01f..d23ee482924b 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1582,18 +1582,7 @@ static int fsl_easrc_hw_free(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int fsl_easrc_dai_probe(struct snd_soc_dai *cpu_dai)
-{
-	struct fsl_asrc *easrc = dev_get_drvdata(cpu_dai->dev);
-
-	snd_soc_dai_init_dma_data(cpu_dai,
-				  &easrc->dma_params_tx,
-				  &easrc->dma_params_rx);
-	return 0;
-}
-
 static const struct snd_soc_dai_ops fsl_easrc_dai_ops = {
-	.probe		= fsl_easrc_dai_probe,
 	.startup	= fsl_easrc_startup,
 	.trigger	= fsl_easrc_trigger,
 	.hw_params	= fsl_easrc_hw_params,
-- 
2.34.1



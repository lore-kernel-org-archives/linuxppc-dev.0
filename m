Return-Path: <linuxppc-dev+bounces-25347-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578BDC5518F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 09:56:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDppN1nnbz2yLY;
	Tue, 04 Aug 2026 19:56:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785837372;
	cv=pass; b=Ap2HD7btxqKqNLrs1rbc+REPa+uwga1vUVmrKuQBmW4NH1LHbO+NHDD1+yYWoKYemFRiY4kQ4afHkQojIeB/cAdntcmWAuzenSAgWh2VSOHK6LrJohN6dYo/jrPh8XPH9dH2lZOgfa7T46WQdspHLd//Eux54IGBZtg86bAMDtppqxisKLo1NnaTPxbbklVCEGHukWpWYYxTcDp3OA0kQ3RZcsOoFjnDYDMdMTXGR4+QF++SXL4TWR0tG0b04hj5FUglkUU27XVqWYa9KcKx1GrZggv3/9DqeiVylZzvLUkSI7ixRfRDJRjQXAaVx7qgYlRocbkkcbGK67pfM1iodA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785837372; c=relaxed/relaxed;
	bh=/oxjEhcd90sIwT8oacfo/mQ+G4Ay48k/aqmt/lOs02A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jullsIuUqF5eTDKqzIEEO/dYaQzFSQm+oy+t3BCqxbbXpSJ6nbXNppea2OTgyl5NCj6X7P6QmG5HopeLM68OhYHgWpFaMPR+ap3oHJ4wXg9A4u4rGn3Se0Uzll5bifiJpKlMuLdjutaWRO/kLWHBJD1au1eHq/fyHHxLEEk9aMiIv2mX/mrpptySUmk8DgdHElPixXJ5mPbfcllnU6/RLy2UhPGfgaGEZfUZ8jBx4RQRxviiSzCRRwG5inciVkIQH5zgonTF8S2yUTgjhF04U3eFOnFhtEe+/5pwj1w89bRJIUPjOKqxgvI8p3W4tsrkWjseNXRdJ10asU16dI8N0A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=qzlTiAh2; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=qzlTiAh2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDppL2XrSz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 19:56:09 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPmf1P6qbPgysUQUMHQn8aL2fPUeNORG0HjVJ15HuR/yoQ4ciIz7qydL7PU2Q27c/b/YEOk/aciXRVNJUo6/kBE38nPwvNmXazR4DID0+pNaW80IDayoBkguxM9EH7ZNaN9YaE4/RpMfOo8Yf3k/jf1ypzWV4CHeo9I7deFtUu4Db1CUrE+JneUgXqeRxK4AzVqmw1C+dkVodOn43cqyaRrMax0ZCEBsnRdS8n7nbM7i2ECPnIgCvvfj1MDaH8mXLMOAcCoaC/fYDFbkqUqPsvcwMvoAmAs+wHxNtHSYnUIlkfMfaBbuTKMcou7MmaZ+yX3DAC1K08b5x9ifV9tjJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oxjEhcd90sIwT8oacfo/mQ+G4Ay48k/aqmt/lOs02A=;
 b=CIMq2BNpp1dkA3Dcrxs4T5SsgPIw1zd1gomOmHZ9x4CJNwantIzz3ZkU2tRS1hPfAtCdX+uIuPWWUDLEsZIFJjK7HJBXHS/k0U3OSgf5JfotPvuMjkMUOg4Q17fAv5DwQxON7RDoWUEckpTHK8AG+n9NtySEAZBJsYpbxfIXPirzPMFZ7hmfqwwxUXNrOrVHrX4iIQhdQQHXDDgyx+jwZVtCph1Zp4rlnZzlPyRk0CFgDzxTUem1gi3i82eiRzV+cgcUOD2S+Dv7GhNnlNlIXtlSP0Z1GpIw2ZGT87Jtpp8gEpjT3BgygvqW2R2f+fnLwJGXy4yS/5HRCtFviPhWmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oxjEhcd90sIwT8oacfo/mQ+G4Ay48k/aqmt/lOs02A=;
 b=qzlTiAh23qVz2VAgUpikbXEKuLXMGd6hFjv/weI2NsuKxrwETuoh2Aal52USDX/6BtgDGUZVZuGQZSFS3PP5Ry3sM22qLb/GqSZVxumot6L+ZmngmcXr5Z3MvgzLRIsGuRKaZGcoHI0TLKpKRJn20kzmN760icX4X81mG1DZMEMNqqbjFUs5COdUMSy4d6bDwsFx93VEAR8+0oYFW/Mh29fAfRxL7X23jc/D/3wWFvSif9nDv7qJuCygypHBJfIl+fawUxaXHJRtHnYaRz0fBJCv4j1M37iKtvesR2D5+X8WmbuVmvEgdErL0aJFzpjTjOXubidFeBN4RUvaPMjSVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by DU0PR04MB9465.eurprd04.prod.outlook.com (2603:10a6:10:359::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 09:55:44 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 09:55:44 +0000
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
Subject: [PATCH v3 0/5] ASoC: fsl_asrc/fsl_easrc: expose per-pair/context DAIs and fix DMA race
Date: Tue,  4 Aug 2026 18:02:13 +0800
Message-Id: <20260804100218.49587-1-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0029.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::16) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|DU0PR04MB9465:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f696ea9-3d05-4f6b-77a4-08def20e8d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|23010399003|1800799024|366016|18002099003|11063799006|56012099006|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	TYyXzRtT8d+zsvr1ELUWXI0ubhfkkBNE7hRBe1Qu95T1VuolKSq1YIiMzDwkbKNAWh+iEbadiL/LYuZoXdqd+XFdM5qeMyx869xYWylTBNCJGQvkC49RFQbVVGoDV7D6scAoLr7keVhC0JcaET+Zuy1arw2OEFr/B2MKuz2Ni/TU/hDMosTyXbnkTvbqtFOHEYgETqYFtCdPFviIdDkjey9vsJm9S8Ag1rmYbgzrU/kKXtKaEaqkJo3rYJCljIpIBGLqZows78aVo2fOT5B/usCpRjiiReqL9m9m0Zb5BijZezPw1bBaIqI3yZ/Gs3YJEUaV7taZFcfwZ+p3vieYipsEmU1NoDAzuGnbtz5MEWhtBadJNIrZvI8BbVpoQKcuKLxi7O9Ys7B7x+khfGYMKUACItI11+V8F2EE7rISOUyCsSGo22Y3qYYeeq1DPy1GhGnbipOPAQ7ZZ6ADcPK9WZVNZYwAmbxtHLHLsekzZZ3Rogauka7PdPistG9lVOgNjupgGNHeO1b7poso4yn3zOxB307MXWGoKIjCnfuZH3DYqkuHn3WLiu7K5fYBWC3yaPLxkfXGLrs3fyEX+uOQ3vW4dUy15K6btoNHr6TbeewqvelSEkwoJkZYWxTi7ZUqurEaUICO+Ur9jutRR7zJu1Ubx9z267K6OJuZfAZrRP2FJGRXsYKIjERQSh9wU7oHrXFX65NLmhhB3wf92xZzPQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(23010399003)(1800799024)(366016)(18002099003)(11063799006)(56012099006)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tuXJCmw62UzpzsIidqQFkBBLH1tSAz8/2RGNVdmjtj3R6Ude7/Ch792h8PZW?=
 =?us-ascii?Q?190nFD911bdiQWcB8OdakUKjKvtveYfuzWU40lDNHzDD0JwajXESRMICl4iz?=
 =?us-ascii?Q?seL/V5kxBmFvLmWBNusos9kf0XylMi3gm8c7MpuB4M6W633rhw1ozlanOYBH?=
 =?us-ascii?Q?q86+F8MglU3fsoBt6SX2tWX3vIHNo4uku+cJPRptB2tR9EYKxvzDciYOtYRD?=
 =?us-ascii?Q?HGF9WDcShwoE+nb6xoKVyXDgCU+qMK615BlqSFqRZUAPWOkrv3zVf1/XZJWo?=
 =?us-ascii?Q?9zFSx1ULcB0I6lC3c6mj9H3o9ScNDub+TSBqjaX8mT7+VBjMC5u4X6VAm7MG?=
 =?us-ascii?Q?veU1r05caBLecVbGY/OmfD8AFyxixSVeQiLfVrHttd5Lv9Ss7FTjdDSvs7zp?=
 =?us-ascii?Q?9kdnfcx6b4R/fEmACK8IPjUE3SmSztjBfNfbz3vtt9vPUh4eOHEypYg/wIKB?=
 =?us-ascii?Q?rAl/vYh11LkydmUSpSPJZzou2Rn1bxuPvyCO2DcdQT1uElfMpY2x8XYBh0h0?=
 =?us-ascii?Q?u8qb1Lse5mKudeyMxu9SvgopNmnE8sUznl+LrKuM1E1RHXeQ4Sm0mde2Uzvs?=
 =?us-ascii?Q?NzuhqIlIXyuKuxafax0ckBAZVemzh+1+Qcsg4ScOTP0fVUiK6DIdWd2yS4zK?=
 =?us-ascii?Q?ucTfqfu056hKbvTmB/Dg7J73U9x3/i9oZQUqy/4VArtX7R/MT5gePXyS138p?=
 =?us-ascii?Q?4JRcPyPlGiH5FNQ9OY8sPUaEz3IoU771S05lrD+HY8E6wxd8EZwAV/gXI7wq?=
 =?us-ascii?Q?XMcFonb6TkV5skxEcTzdPzALn4Cj9q7b5+y1s3qKBbnStLYXh/KHjktaPSOS?=
 =?us-ascii?Q?JyqYFOBWO7V+y/1NvF5uZq9gTnlnUFyVeFs/eLq7zai5UERRJiXy7jxDMWCJ?=
 =?us-ascii?Q?BICKpQpcp3inqb+Q6qDkOUezgZHFBB+AwMbeueGRr7MD06L+HlWnWf+im0yR?=
 =?us-ascii?Q?x3whMoPKLWsZk9ZUr/cjW6EzwHYJorpL14y5ZiQKJi2yZws8ZXDMWIKfY2vL?=
 =?us-ascii?Q?E2nYGXgh/7BrvcknhyGUFn/lOUcgvjSV9qPeGL8jFrt+8FUcel5gBQ6Xzwkb?=
 =?us-ascii?Q?+wrwDrBD2shPz7JzICAq8ubHMjPf6/mqkV3coLjmqEuzJp9CcRREQxhS2kVB?=
 =?us-ascii?Q?t9S0Y56szVC9AI3B3/6185FxhyVbXtc+Xr6eI2vD/XLklV29mYBMF7UN9USY?=
 =?us-ascii?Q?xo0X0qh37Sg7g+YzICzsLU09CPS/Sc+U9kamwWyKsSh5pMLyhFarNliLzUva?=
 =?us-ascii?Q?XCXH9LQCeNGXcxbDZLpQuEzpwtZ+gnnWSyIclqtiopFAQkxEglUJc/8TiPNP?=
 =?us-ascii?Q?Y5Otyt5qvBUjlFbFnjBNlwKLHIEyxEMntZpGpV4c2jbsYYV0RrXjfjsVWYI/?=
 =?us-ascii?Q?TE99KajRMvkFYMGvJ4GtHyzCnVRPWL2bHNcDu2du6r6T4VJeU7wVcyK2bYU5?=
 =?us-ascii?Q?Y+76ds74CZF0XOIEL7CZilXurl6INToGphPm4nZaCpFqMckViHiyvA7pUqaJ?=
 =?us-ascii?Q?xdoYzM4zhMHNGkdbEmUdLW30y0ujZ09h3dLZtN2QeYjIwXmtsienz1w/ThYO?=
 =?us-ascii?Q?cVBwoS/RP5ay9MjUeKWGPtvPBjdGLYprgK0RSINt/spE+v9dGV6HQgUgWmwv?=
 =?us-ascii?Q?MXROKEwWjvHXZjLlV6L/dYORl8hunIhUfJktQfeiGX/jEqful/sHfqu293xa?=
 =?us-ascii?Q?Iui8GKiiiw99smIJ2glPZkRvBtMCiqAloSdM16UfsYJmyW+es24S8IR9aCrA?=
 =?us-ascii?Q?2wWrfwlZEk1HVbDwKrLg4OWZ/phAmaNyTHYCtLxExLQOmZIgpZJB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f696ea9-3d05-4f6b-77a4-08def20e8d00
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:55:44.4514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TXiRsWGGhFStqBifDQXneqzKR2uhpjolqye+9W7pMtb/rjtNHyXCmPssJTZvjXiptt2TLKRL2oDM07S4PNDAX5cAIzOGCela4VBhT+2jhrExUNh+LgTZYWO7eQCoK3R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9465

From: Shengjiu Wang <shengjiu.wang@nxp.com>

This series extends the i.MX ASRC and EASRC drivers to expose one DAI
per hardware conversion pair/context, allowing multiple independent
conversion paths to be active simultaneously.

Patches 1-2 update the DT bindings to add a ports container so each
conversion path can be wired independently in the audio graph.  The old
single port property is kept but marked deprecated.

Patch 3 moves dma_params into struct fsl_asrc_pair so each pair owns its
own copy, and registers it with the cpu DAI using per-direction setters in
fsl_asrc_dma_startup().  This removes the per-DAI probe callbacks from
fsl_asrc.c and fsl_easrc.c, which are no longer needed.

Patches 4-5 expose the individual DAIs: fsl_asrc registers three DAIs
(asrc-0/1/2) and fsl_easrc registers four (easrc-0/1/2/3).  The first
DAI in each driver retains the original generic stream names for
backward compatibility with existing machine drivers.

Changes since v2:
- add ports example to original example case in yaml file as port is
  deprecated 
- remove the label in example.

Changes since v1:
- Patch 3 is new: moves dma_params into struct fsl_asrc_pair (one per pair)
- Per-direction snd_soc_dai_dma_data_set_playback/capture used instead
  of snd_soc_dai_init_dma_data to avoid clearing the other direction
- dma_params_tx/rx removed from struct fsl_asrc; single dma_params per
  pair suffices because each pair is unidirectional
- per-DAI probe callbacks removed (startup now sets dma_data)
- Cover letter and commit messages updated to reflect the above
- DAI names changed: paira/pairb/pairc -> asrc-0/asrc-1/asrc-2,
  ctxa/ctxb/ctxc/ctxd -> easrc-0/easrc-1/easrc-2/easrc-3; use index-based
  naming consistent with port@N in the DT binding
- Stream names changed: ASRCB/ASRCC/ASRCD -> ASRC1/ASRC2/ASRC3; align with
  the index-based DAI names above
- Binding port descriptions updated: pair A/B/C -> conversion path 0/1/2;
  hardware-agnostic wording to match port@N numbering

Shengjiu Wang (5):
  ASoC: dt-bindings: fsl,imx-asrc: update port binding to support
    multiple paths
  ASoC: dt-bindings: fsl,easrc: add ports binding for multiple
    conversion paths
  ASoC: fsl_asrc/fsl_easrc: move DMA params into pair/context struct
  ASoC: fsl_asrc: expose individual DAIs per conversion path
  ASoC: fsl_easrc: expose individual DAIs per conversion path

 .../devicetree/bindings/sound/fsl,easrc.yaml  |  45 +++++++
 .../bindings/sound/fsl,imx-asrc.yaml          |  45 ++++++-
 sound/soc/fsl/fsl_asrc.c                      | 100 +++++++++-----
 sound/soc/fsl/fsl_asrc_common.h               |   7 +-
 sound/soc/fsl/fsl_asrc_dma.c                  |  14 ++
 sound/soc/fsl/fsl_easrc.c                     | 123 +++++++++++++-----
 6 files changed, 263 insertions(+), 71 deletions(-)

-- 
2.34.1



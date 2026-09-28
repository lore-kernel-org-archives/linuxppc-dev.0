Return-Path: <linuxppc-dev+bounces-28373-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E2AC98328
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 06:08:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htW7Q6mdKz30dj;
	Mon, 28 Sep 2026 16:07:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790575666;
	cv=pass; b=E2BkxRdysB7Ympysc2W7ahlYoUywzhEiYIQzj6thvA9ygXHz+oZW6bypuZ64AnCfLxCy23SWm9Lt0FzZffMbWupittG67Vh5pmABhvQGrAhRr9TWA8fpw6N2bioUp1O0j5AkfDTqVlzd/JElrOno9n0nENpY3pFqjg7BHfiy2n1LcCG4xXwA3TiV0TruhicY214fUvBrHPJVUovk6moX/Ml6jRThP9YdYZRXUecP49M/4OzhKA7HxEgLz8FMV9ZRrANRFbacUirZrHXPp5WraxReplVut3bD04yGvpHicghiNALLe0hpieNTgFTekMhRq5jYjgC2Bxe81vORNJQT3Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790575666; c=relaxed/relaxed;
	bh=tc2anIJVm1IV5UMGSGsbJ/lb7y6ZRHrakDVR0BsJ4eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QYrpKCFnEygP9CqO16clK9S+17YhfUnquNmcUKicE5jjCmhGH57mtK7ImJ0EaBB6FwapvwnGG9ArAtGyl1NvRt0qPnwVZIei6swVkuUoGjwZ7G3APEcekwsVIb+WJuoMCHt/2pDuawHdo0eJY71pcrqPOKhVZCC6hYN57PTTa0NwJP4ZUqH43YSfWMvyNk1omJp4vRlGzuX2tidfFMEKFD4bGlIszbGzljNRR5kpGVB7qtX/74wPW0qBDEnZ+7JAfv7O0R7/pXiO/YGMr+4XqXHgBgVl7+KJ2SbQf7KN2xmUzLCAH4xeJYqYKLutJ9/+dFyF0ahufQiPvmw1S/oCsQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=YCY7w5dm; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=YCY7w5dm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htW7P66SVz3bSF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 16:07:45 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSX9wwU7RymgADXq8Ef7Lrsp+dvWG0330GX1uMEX9Vnb//fDAUFcwrXBM38oyjyIvPG+tgR+QjRUYL5yPk2QV7HBaTkcWOcTkHKBYPIo3HTwAQqn+hpzdaKOeYPJf+Nl+9hY3H/z6jmaTpHZo9EDRJx3YZjhfXmrAe579a/y67CYF8WrAmghP/SQDkaXd9MNYfLG+Edy8PPEswsF13kMG7bvzW+xjD8stBqrJhbQEwYbFyN6/C9y6EN/+lwV+lzSDnfB9FoJay3FPxz+xq/EN1Dqss36HdOLNQsXJGRYv9IhMVgXDlb7Ep3GLzHZpmzoV11PPCm6qMLQRMSAzMZRLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tc2anIJVm1IV5UMGSGsbJ/lb7y6ZRHrakDVR0BsJ4eg=;
 b=EwDqGQkZ/ONCc4Bt5I6n37dFv7WZum3qZQpMGZxLPmtXt/pvD12aFsjCUPoR3OB2wpJraHTrG9hjddJM9dtm/JLGbCVWWRQswTLC9wgNn1c6oIh5MIhwM2Igxi3A6M6GjjJN5hYvKzeHfmksdRwBCrdoiSS7ZWHI51KYj42MIGACvJxp9kzG/9iyEFIZYiwWqqh/Ef2pn7SnWCM0HmHsc9vKTbftMoq5H/q+a0kRLum/y+v5sPoqhS3/wvhAJiKJk5AZb5OzSTlnd5Ty1TO86wJRAsKmuVUpcYLhddO6Bv2o/1UeXx5eKswyGN2gs/TDPmMwYns972bTZ7tQeNw0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tc2anIJVm1IV5UMGSGsbJ/lb7y6ZRHrakDVR0BsJ4eg=;
 b=YCY7w5dmPqm8uOO9/14YyU4Cw7ffi3sexAyJ/kBZ3RDGvPdG23z+CMg7c8BC5LdEuvB5HpIDVH5TWnG64te52rSmcpgC1Im25F4dCFA26EWNzZzgXHifEY9pCjk0EYKnXirFF0f1GHoBYB3DrvxrsV/PXNb8KPBvdVuNrjbAwx0gPgOEZkf7IIdCi9cYokGEotk1BqzZZAuvt5lWFLoPSo+pLt/nYOjSiyRzLD7KJfOi+cXC6LB6auMpx6N/eSC6Qtpyl2VH1xZCKgx5TATRAe5Jw4P/pVSwEz3Y22d7nib8wj9J7grsF56PCDISx+kAhSPqBGmTkdVp7SFDPSOOYA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by PA1PR04MB10721.eurprd04.prod.outlook.com (2603:10a6:102:489::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 06:07:41 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 06:07:41 +0000
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
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v6 3/5] ASoC: fsl_asrc/fsl_easrc: move DMA params into pair/context struct
Date: Mon, 28 Sep 2026 14:11:47 +0800
Message-Id: <20260928061149.1844121-4-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928061149.1844121-1-shengjiu.wang@oss.nxp.com>
References: <20260928061149.1844121-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0119.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::7) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|PA1PR04MB10721:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e8604d-584c-4536-5dae-08df1d26ce2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|23010399003|921020|3023799007|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kmtBKQSe5Hiod3tqeU5D/GJA2zoQjQJDa8VOyqJIbC6TU+Tk4jjGKThdA2yOmmVCwBj8Im1s6hpScwO4CilH2CpGHitmeAdlBQ0kOLmqvswIozdqIdYTwuPAcNzIrYGQQ1Dgdv3ipEfvYJHsLuCxKJFIfJREdOWu14OqLeZFJO/D1h9gQndQ4qMpIV9J8uS4PhSRKQ9I4pnXku2gWNYigTJpb5DnLvGC0E7Q7ggeN2hMGh9FNLk8/zkmvNne1rjx3Lun+9D+OKd3cu+ltshjfh12f05eOszryf0B8H67M4x5d2uAKjBSC/Q4D7vmU5FYpI95Hv82GUvKA+JHplSH6p81TkmmXdm4UYWbLcyLv+82P0kwNXIVGWpaAJh+zSbpoNmuFPj2ckG3Q9UAZoBy3MBqComTPuExKrcYyXNcCxadzZ5Z706KZ5YVarspz4sNiQenRMl6SGD4xrMxKBF5DeDwB8x7eysPI3YD11ZNeu63feJR6hnKIT49IZOvDEljunCTbXDQtEXtsQ56EL/YFJlV9QW7wuA1abmccsoWl838i0nUlru9r6/pqSC8Cvs3I4DFYvzGIzfhoWEZDZRgK3H9QXjx/bsRTa1lqc8DxdqJfKBPXvTzLiymYCmhHX8+B39uxjCvA2j427hehUx/RzBjUMd2r1CBNI5WEQNKrBqrYXivObD97/VX5epE60xYJ6q5aFRJzMbSC2nPlXxX2Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(23010399003)(921020)(3023799007)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vMDT0uwZ2czkLdYmw5cl25vxDhYv63HGXgKQiUHGwPMDn1wjDXUE+vLVrbSF?=
 =?us-ascii?Q?2kYua/VD26Yd6eE6XlmQS+IvzDNn/rZ72UOgAOSV3U5szcRk4NXfJb+Pr0GK?=
 =?us-ascii?Q?Wltpj7MnXdwTCm26ly+7FBoIYthZde5h8R2bR7QGz87Se/3xfYfv3q6cDFjn?=
 =?us-ascii?Q?ogp1F63yYsQoSCfV+Ot3uZRumSGSoNP6ka28/KoTAfa5+ct8aKQV8Ywdf/0E?=
 =?us-ascii?Q?8js/h575Nh64ILQpyqPvssQ9omg6ci6ogBfALe2oL08FzahsQogpur1zrJPq?=
 =?us-ascii?Q?bvV/PGa86rgOZsoL/0AlPRqs5+DhITssosaVFCWc+x1tZjvU0ZMsVc4eCNN3?=
 =?us-ascii?Q?ME+4Q8ug6tLHqyBSvTjPzG/31H6Qh8YuBQv/4SqbADQR6sfNlKMswVPekcq7?=
 =?us-ascii?Q?wx20ARRymHjCcYtLRDYop4yZ3qfG8AbZ2sdkRAYTUhpLuvXbh3amMYe6OeGE?=
 =?us-ascii?Q?965BlQehyPcCFJoiopAkEDNbJD/lhXtJc418m1cKsjFgLwXmKP4vkk+TVc0+?=
 =?us-ascii?Q?rmBQLyXQIuoFdlXpp06Dz/Riy1Amh/pw2jUhaTgXz985G+l/xfQ7Q3t2XpQq?=
 =?us-ascii?Q?JoD7Z5d29gzRXGp1t2XHtiUjvj8fJNfnDLfdl+KDZc+Q8o7Brv9M5a63RRGc?=
 =?us-ascii?Q?ll+qhqfVARWSFf2l9GTgoyWBaDv1ANzQ49zAwJ/x2pSQ7GYp8PApVgD5t2Vt?=
 =?us-ascii?Q?ADyjEX/xGZX6LKWFIvYmlGlq9fItXbYwRZzcu6nMmiMDT7x7VLcPhSiVvJQe?=
 =?us-ascii?Q?SGS7fw2CPqVORiay1QcLd/0PHsmDP+aXjbwHE+fRRQJ7tEjhTm+WEMZih/wN?=
 =?us-ascii?Q?D+oASNJts8FNJY2uYYIASP5W8f4EsELn2wUfF2XEOsUu3Y/KzgUOPK8oWIh/?=
 =?us-ascii?Q?SwNz1mb7FXw38NizPpIQTxMCKmaDaRPwY/PlrDVQflUg/O18YjMN7ZK6uvgZ?=
 =?us-ascii?Q?zt0916sSVWoYVSayU42NehoAIdG6jGMEHfhWxyBw7+S0eQKOfXsoGL6spnw7?=
 =?us-ascii?Q?tn2k7sIwqpnq+Awza+FH67poBV3j0U4LcheHkn8jTSvUevwM9Tfc1RDAkBT6?=
 =?us-ascii?Q?c7jHo5MHqqdwzMwewF1KMDxfLph4Rri8bSEPKSncRFw1diGgS+7+mq/qbnVN?=
 =?us-ascii?Q?hyAEWu3LfPHahPce9je5oKCTlruxSzkh9IY+dWMmUyD18urNakduXinFWgoA?=
 =?us-ascii?Q?p0Gzb+Au4Jcl0DBjQPwUDh2WkvMsRGFm7Nd0VCKXpU4Km8swPPPrvTcTJZ9j?=
 =?us-ascii?Q?hp5HQhWdsM3cutc04pix7F4by05xC04KSgSaEqml9+nJJFE5sxku+tQ5xlPV?=
 =?us-ascii?Q?/J+8b4UZU+W9waaNWlQSy0e/ad99BcxX5vB3iba6A8W064Akw/+lnpmuBLpD?=
 =?us-ascii?Q?NrlD5Fr5E9a31k94Gt+LLGNI3gk4IvxTuHYaPmf6s/MfXjI7i1o2QF0J4gmN?=
 =?us-ascii?Q?2Yzky14tW6jY4pq9pCCcCEktW9eqlrQM8fEybI9Hri21DFqiCxDH6IE+m21N?=
 =?us-ascii?Q?CrYmfKEkSheXwXysJVz3JrKN39SRXNYFG1Ue8ORxlihsGYMU82bic8iIjmB+?=
 =?us-ascii?Q?zX2FODSvXXxdfmyMu1AqxrDnwNv6uHpBD7XwHN8WNkVRBrMQvp2TOAXIjHSl?=
 =?us-ascii?Q?mehZZozcsz0Pzbh413Szbcl2p+QMXCvF8dvXeUWAMe5ymgThpOvYySjuQJwp?=
 =?us-ascii?Q?ccAgYL6IZ7bz6xKqK7UolWT/Ajgq+Ffrk4h4PgMy43ibwu5Ii69NiKhe9NTK?=
 =?us-ascii?Q?B/o0t/hpG1hFP/ZW1m9MjjRz5jnI2ldN+wP6s2PWmNu7SXOZcX1a?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e8604d-584c-4536-5dae-08df1d26ce2f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 06:07:41.8164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnJ3MYX6hF3N4pD5vG4C1uOsDuosj4wNTZZYUyEHNyhkaM3o/mcNksZZZpJDd6H+kWmxIUOBYnQPMlfmV0TQnKX8TPQ7nZdL2Qpd5rkHzR60g87sKYOoFT5Es2dej2/i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10721

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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c        | 11 -----------
 sound/soc/fsl/fsl_asrc_common.h |  7 +++----
 sound/soc/fsl/fsl_asrc_dma.c    | 14 ++++++++++++++
 sound/soc/fsl/fsl_easrc.c       | 11 -----------
 4 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index cc304abbc8bd..9be903dc75e4 100644
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
index 0aa5db8973d6..b417de6abebe 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -400,6 +400,20 @@ static int fsl_asrc_dma_startup(struct snd_soc_component *component,
 
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
index d30cc3e90215..4401c4e100b3 100644
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



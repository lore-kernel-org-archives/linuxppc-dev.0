Return-Path: <linuxppc-dev+bounces-25802-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FEBC5B572
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 06:55:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLGMD3Tfpz2yk0;
	Thu, 13 Aug 2026 16:55:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786604104;
	cv=pass; b=mxxtRyADoRCl5/AC+NyfwBF7P7hlbPKQMxmMCL9DFbiQMJy74v1Ni4M9uwDLdsEJLNUVN6zpzeLIynsvukUGN9sR6VnEixqtfO925nTRVWgEVofsKAYb0vhsUAt6as4TFMIHjRVHGSxmOQmB3Z5JqHyLPo7B5qKSFsQ8yjhUr5e45GhEIIFaolEvf4d+k0ipepFlKzUhOjKtgJ+7boxTzXSMfP5YTQuSuHHwWNaxj7RZz2HRd0xophMAyKIx1Fki0N8CcE6riUUKJ+BvJ4esKhitY437PAIoweVlEoTM3vPpVELo3dc2dUGMZ/T3+qwnztBXs0Ifj3ixQgJZ8D+Spg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786604104; c=relaxed/relaxed;
	bh=HUrEleeYnaMpLux4g93s6uxQVTUZ/liDOoBhBcdt2xk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UkRDoW4aEQIRvSNZwveaU+jaDW7gsTgUbTtRwCG5bI6kFd6ADYgwPTm+hu5jPyxOIlLHFDCLoZps3zW07oGsoU26rZvnTuror9H3dQkoYUuczBDVnjSBz6BUeIyMpq3DgclNR6TFnmcWhM6pJGFTRYakErE4z2wsk7EfYvnD4MoLBcTx1rS99TpXXxqXlFuKHO5l80hXupenyC3439de6ICm5uPua5OLRk6mK68t++bxrLZaKXas30Nt9phJN+qZrhvkPOsnH7YHlT3DCDurNwnf0F4lYgv3Y2EEfmkjEZek9e8XuW/E3MFvL41liUvVc1aFUSsuuJjCDPsdOhacYA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=RpRPC1WM; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=RpRPC1WM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLGMB73d7z300g
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 16:55:02 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TuUU2Fzjh8jTuV6ofvMFUYBV9kuMaUuxxrHbFZcQGHvxJ+sht2p9mG/H7Ddts2sA5fD7eAOgLeISh7fFlUtqeZu6aOIojrrMgVeqPIa42CjzD7+e9uKblqA3mQO2hmyV7/IYecLnM/RKCGRwF5r7891uTwSOKwft0Dnm09umPcWwwSTLHM9vr5FfkLzMUId96Frw2KOGV/frxKAfvsr8xrf/f9+AzGJFK3hFb+iLe42kjFaKmF1wL8c0Yww2/EmrVZpoPb8gxhIHRgm2uYMj7MMG/JQdiV7WJcsZSrZQwo2tNGCdZYBQS7SHa+YXy1e8edAXRbsePzjP6+3c1kCtDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUrEleeYnaMpLux4g93s6uxQVTUZ/liDOoBhBcdt2xk=;
 b=hrXOHvYaAK7vIeUxIRDkVOEA0WapMBXT94je8K7QYolSr1XyixLb7QXgAuSK8AodzCNjgCY148azOdRJa8K5gclzmOSnxExDlxuDe9n6fuR1W7xn8ToH7PgM97GfYcOnjuRIVkN6Nui9Ei4f7vQYqxSm6p4jYl+ZKJAE1p7aOootpNRcJ30Q2QffwXV7P/NktfyQCm35f7sXAzho7c0pSZr+DL3rYEM5uZMIrCVN1mVA84X9YASGkfyQnmjKSY+2Ls+JjnjPPxhWgAzwhhI/VjbjRnwiuCJLMJ0iptRj2zHd5+AyR8TfhBTcV+172icQtEsIrEWd/tfMIg4MJEspbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUrEleeYnaMpLux4g93s6uxQVTUZ/liDOoBhBcdt2xk=;
 b=RpRPC1WMHVLLGnbpQLV/VXPC8/5LqWxpf/MPa4j3FVDIn2iMILpHNzyXcvdwpdGCr1ZSr4Rt1NYR2mQdm8jywGO8ZcaQezYcEoY6Pye0gowonhWHLetrfVf3ae91ePVmL2ioSY6c6em5BKJlDkUko8YGc+zBQ+S8r77/X5Az7B9ZsCACSzesGi2wNRyjU4p6b6Nr8Ynzjr0//RudDw2FPAiJjlfQy8MIhDt6aHnR8kGvfXP6NzS607Vp/zbYHp+TbpT4elxT3+Mmff5wRUnWIGihDcWy8EAEw0I/7isXrpfwwvz1R4z29lKdZ+TfwkCTKF3JwfAODvYvzvrQxA8Cow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by AM7PR04MB7158.eurprd04.prod.outlook.com (2603:10a6:20b:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 06:54:36 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 06:54:36 +0000
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
Subject: [PATCH v4 4/5] ASoC: fsl_asrc: expose individual DAIs per conversion path
Date: Thu, 13 Aug 2026 15:00:19 +0800
Message-Id: <20260813070020.719810-5-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260813070020.719810-1-shengjiu.wang@oss.nxp.com>
References: <20260813070020.719810-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0050.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::19)
 To PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
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
X-MS-Office365-Filtering-Correlation-Id: 86adfff0-31af-4353-a2bb-08def907bcba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|19092799006|1800799024|921020|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	M31PJ6cSdkqbjc02hgKq9pjy515bad2FW6TkmPs4PY/L5mhlq3dOIGTWXkdnNTis0u1OG2y4Iv/VqVtR4S2KKeFbwZ5h/Hbgx8fdyaA/CE74d8f1aq0HdUUuAdsVPMy952+7LlFORSLuBP1s1AzwwwU457fVXXLTnkTnwW3zLZFH+TDwc1pJ5p+kEiNnDhev5Mx7pA04/GQxXmjlDmM/KvSkYGrQwWZ7U2HuB2L1OqVQ9EBRjTC3TmKPq5PYx2MWqPLKH6gn3po2Bcu/wemN8bBqaYgLvyF1FCvpSUgxbs7NUXEegMJWm9P9mKUfZjB3PFuGBvCk7B+Nlvwhk5yQGRX0ePL1dsqPrf/S7JD1+E5Kd42bV1bt1mnruhPfup/9e0ZVKCWT2zVAi7i4+WgOBj/dtPQ9JpnKPNmlal/hbzDv9aUlloHnv7EzZyM++JUTNfkY1EkRTl0gKWdK/W4o4b8kQcsy+fiGXQn9dk37lvFym7b7M6PSWeZ251OqKggoLy4pPcyfXk94DvGEyWp3OGlltvffGPLc7FizUXYUXYQTQPQ2qxud3SBQJdJHaC1iJHxzaPBWEBhMy5SZnJBAVvSu2YIw/d8Yw9sGMgqcGoUwZ+3La8A/4OjAvVt6YvOGlBLkhxRtaSSSpfpuKms+wmQr4TuKkzKfYYMDx7qUutocSrTxF5FUkcz0v/+s6dOrW1+wGHD6Ny00pv3fHQHDEg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(19092799006)(1800799024)(921020)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9WvjQ7DJN3SRVrCQVRUtkCT+aPNRf0xh/tzq0PRDBBDZNGRM+7ePCrj4TMlE?=
 =?us-ascii?Q?Y4iNvn/7wGm3aCg4pW5XxMTidsJ5TV6J7OPtIKvwXQEs/zZ1ztg/vYhv9T5m?=
 =?us-ascii?Q?4p91Wc7DA7vYvfdwxfsCWAFbTt1ITlhunE8qDl9GvfFnhEg+/PFzeeFnpnJe?=
 =?us-ascii?Q?4PMOqhakGuaXaHP3sTOHbKaaENlZdeVqzHrBEVy0LxhBcEWHBvvn2stOmy7q?=
 =?us-ascii?Q?AvoOk0zVwPc0vlUZRxccxwdNAamchb3Lo0nwNnfpGiFhwQOd3poiPwWjZX8v?=
 =?us-ascii?Q?HaXR5aTMx8B+cQ7sJhcfisQ5+nnrVAlnGyUw/VdrmqLb9fttpbjMrh1rjAhd?=
 =?us-ascii?Q?hGUHUqYDQHFBGUuVxpg7/8vLiRZzE1eBivr+42gfmLvS7CuLuUe8g8S8h5Ux?=
 =?us-ascii?Q?8yTiRFok66fvNXj/2yrTXz8AsQdgVPtMcKbnEI6T9cYPTEse2nT4VR6yWPhF?=
 =?us-ascii?Q?61df9Ty+CXYPjOX/fTsy78QhW08WqTigNd6sq1DY8oPEaJpPp6Xe7n04Ptuk?=
 =?us-ascii?Q?YIZfVzTALHy0NN6A6qUb3kQdN6m/GGo/v8K9Y2H5tQdmhv7kC8zyX+goosfC?=
 =?us-ascii?Q?77Yku7exF1ZyrBoJ3jq4MvAaIP3SKRDbvU/DK/8OrQWYvEnPLw7qmdoGu2kq?=
 =?us-ascii?Q?qmFtr4G1ZlDNwT5FwtHl9w2UjEQhS0Aq267iGDMWSaHAogGeN4lK2BMWz/9n?=
 =?us-ascii?Q?QgYC/DznnWKIbPKikMAc9o707pC8b5SvWIRIqMM0x5+oUwFDYP5oCRer/b5U?=
 =?us-ascii?Q?Rb/4FFrZXPO2g2ZEur1tQNnWCSUQH/cGc039EXvRvzuBClKLf9NqU2ApKYw0?=
 =?us-ascii?Q?PzIYG5SNnG3BW+OudsLg9g2S04mNAlVbdZ5z9JALguYZMi/EYzOWq3UF8SMI?=
 =?us-ascii?Q?BmGfp53270mEbEXEGS+VPC0mnfFq7H1atI4yhI9H+psZ9v2a2ffpen+Rbr3n?=
 =?us-ascii?Q?fcac7Q3HAOzTLwXV70ilutUmjfIJbcbqznv99vO4FOtzSHmCddnCv+W9hY4v?=
 =?us-ascii?Q?kqjWpQb0bIoTgYbSDaQnyUAM9EJQznbnaiZbznqmoZDbX83muJ28vUAFF/vJ?=
 =?us-ascii?Q?1VM8MBwek02tmfYKUms1rpeT4tqYJDSdtmUIZar2Rn4i8AAHsnhoKKqcZ1pT?=
 =?us-ascii?Q?QajnWi1nWZlk0jhN12G3raPYAdOTSzmK+FCjWMcunlsr+jFigNOBcrumu7Cl?=
 =?us-ascii?Q?S3h0+0xURmLn4qrb0yddITDd+UWj4iGSLwQEjNuUbzlnUxE7e3dNBLdHfAyU?=
 =?us-ascii?Q?TTi3J8nFel1HRWW95Hk+EmKLEvaNIlNRcEsLBg2Q66UHhoUY0H5DaBXhj+Q8?=
 =?us-ascii?Q?+WGwQRxo05uFz1PO2NBQ1RspUvTBwkKfgHiFy8TwOU3KjVLTrz9L/XRia4zQ?=
 =?us-ascii?Q?jfqitsabLGCsxUxFMBQ6YLegI2RgoN0KwnffcbBZp+WBct1I/6TZjuRFdqrD?=
 =?us-ascii?Q?fKCm3k2R7JfFHiLksSQSbfE5CC1SKmid4/pfojjSXbFDWbF3NdUAN/0fai+E?=
 =?us-ascii?Q?t6jI2oP1J/V+mz9U/lHcB8wAygfIfWpCXCGmmPwG4xmQ3uGElqDA8RUNqipK?=
 =?us-ascii?Q?8Ri34q7IZjriPTYFiE/0hyBTOP/hBLPLUbTFR/jnhGSlVpxZRkbB30e6pFbf?=
 =?us-ascii?Q?Kd7B4dBMEIbHIt+FxhnhwcJAopEz8KF0TOYWg9KvoPVaTGEe+L6xbf5hJgXI?=
 =?us-ascii?Q?oSgPrR7ppGJ/3hR3TZRCCc/v4Iiazb2XPfPCfG/W5iR6v5mf/qcbbal1tbgx?=
 =?us-ascii?Q?F4w2BPPdUnPw1xlSFJKcaXbo33AUSfRItQWaa/PodiQmcZ+UjnBG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86adfff0-31af-4353-a2bb-08def907bcba
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 06:54:36.2597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TiO7xFvpL49tEExmuGozBZmrdk7EsNEEWJn2+PBoyBpkj7IyP5nJdT+jNph3wuRWPrlfZUeVDQsY6kIecrM2dXx1fbhozAHr8IOBiXLvmsnYO6F2RteH/e8jyYEQQTUr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7158

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
index 2755ee57c6a1..a5d6c4c1e929 100644
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



Return-Path: <linuxppc-dev+bounces-25350-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D706DC55ABA
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 09:56:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDppf0pwwz3brc;
	Tue, 04 Aug 2026 19:56:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785837386;
	cv=pass; b=Vcwk81EWxnxb/z65c39Jl3BTAFE+LO63K1RAmtKI92K9E4t1F/KIJ4RbCt+AgQxm99UEZCiHnP6ASwrX9IFCsTaMziC5WOUSOe3kWPivowb6bLpbSMB3hAIiriwqM4HPORgN7d1CzE73JGiM3QXqnjOv7j6ec97O0mkyr8NiTu+qKNlgSwN8HCGXVwQRbUQln47xnWk8OPUjhrhNMiwVClLojX2Ex2/6Z9+yynERWdOZTyQRi6AnUx3frEwiGEN6hnH8d0Co3UlYEUbsWZpfELYqyBc3YkhUFFMMjuhsETiZjkAmvBx4fmTpSEV58VrCw1CTi6PdpTqwkv2nBZJ06A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785837386; c=relaxed/relaxed;
	bh=H7HZjz9j2YrH8YBMPSnaFDc66rzC1WuM/wSLZj4YIXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hDe6JVbWL5c38aaLEy7O9HP7QKkP7H0abMZ95PqprCGju8pBrsWf21WVB6vZztI6BPQi+4HIgSUY48OZ5FImiCO5G9uel93WlelAfhJgFMQaMM0vna6Haz+3xwgfKa/IiBuzhMy9UI9piGFjKgWIbz0s+TE1DKfuEX65N2NeBrNj2Ssm1euSqGNpqo/l4nu4NJd3LB2M8FKRanxICWikBq85ja+yLjOyrFZ+6ZMxkXLRtG9Thdugg3UR2rn0JKmrAUWlGIlvkeqyzuFhND3uOO3xQdwWEUv2KczViJZL1Mqm4wMF2rMNJh02UKVq90zsVKE2ZKNzHG/fpoz3z66jvQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=piwWdeBF; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=piwWdeBF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDppd02FSz3bqV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 19:56:24 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PtVY0OJV/qkgvUvOf0/BsLPJfESyV2Jb/5Yd1dFtQTx6WRCg2v/uG4RiAvq1fe7sv/QVKGz+OkRezoQMi86Xaeq+bj6Sd5RdXcJu+IyXYy8WZxxWAsuZJ04OmzzCZcBonlD1AVgvVvcdfWgdnO+JvHLY4amNwzfmbm5uKVh54ZpcLil/zVcDp1YHhpazzsiWUKAgGo7CeclN4Le2PRyPNe7dFgwWrioZVPQBD10j8AqFjA+kFCnyeZ+9ej3Z5Ea9rLTRBNVHcSaYG0l8PmjOqBuEXvq3t9SrXVkhvmEhE8t8zgv0jhlvmfBElfsS/tpSIpVFcRlECja9VzIGrLSGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7HZjz9j2YrH8YBMPSnaFDc66rzC1WuM/wSLZj4YIXI=;
 b=S6JbBkrbGOKOGrNQy/F0JyueMDPPj2sWr8krBK/EakSilLfMRdRCp9ieWqQjL9AkmvSiAjRNWxFSiaGLV8gsmNgquFeO1iHe+x4K2iSL9IJyqnVhxK/Pt6PivhReRYrcqQ6fD3RytlUUuwxhc6WVei7nrgI7kt4AwcbveBflyyBO2mwuhOb+/+T3bR5rxUmc7QfppT2F1pIbwEzGhTjx/F4ozbX94pm8fBTSvZQeFl/EuEH4PndpjTe81F+v0muJafFkFJK03+FSHuWbgd67gVtCZ6F7teOgtbt7OKY/fnrzLx1DXKpD7NekdaIskyL3xQJh16cqwAl778YrMmFfUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7HZjz9j2YrH8YBMPSnaFDc66rzC1WuM/wSLZj4YIXI=;
 b=piwWdeBFb3083bayJe/0pfLiYAwWFpCscpzZUzeneYHG5H1wFG8OSHpJsQAsobLr7bkeyO1MBZ1+XG1M/MQVGfuhz5h4fb7bSXQnq4axbH+FdnUI9L04A2scwJ7lhAgH5AlB+fMTJ+H9vYjiG31in8k42FBMc4B6tea/9SdrePdbDxHBoBgadmZGaSqnw4Npe42JhL8R0dc/lI3ZDcUrOfVsnH/DD9Um1Nm10aDSjFhuyp/bpu8cRXZAd0SCX5kAC28/jhc3kfznTXuc/UeaamvQHQ0bOzrF0THjBZvmgBMTikHV6SMHBQ4Kwmkhpciui8sLY+KZYZmfxn+ds/wOlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by VI0PR04MB10592.eurprd04.prod.outlook.com (2603:10a6:800:266::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 09:56:06 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 09:56:06 +0000
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
Subject: [PATCH v3 3/5] ASoC: fsl_asrc/fsl_easrc: move DMA params into pair/context struct
Date: Tue,  4 Aug 2026 18:02:16 +0800
Message-Id: <20260804100218.49587-4-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804100218.49587-1-shengjiu.wang@oss.nxp.com>
References: <20260804100218.49587-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|VI0PR04MB10592:EE_
X-MS-Office365-Filtering-Correlation-Id: c949e897-2541-4f8f-a5b2-08def20e99e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|10067099003|921020|56012099006|22082099003|18002099003|6133799003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	dBzT2ATleXGN6p65oSCTWDZ6tk2VXQoqQvyadrmX1tQvh+BhHleZVw7mtv1bQUXYLvI4H4ADKBJCnfSqRAYkwv8/5tpr9fwMBthWx8OJBwMvJxy67dCrJPhhI0a8apci2CE/TOcXUcT0IHMYKAA++blUsD7BrwMkK79y0rK3Y6Ece2p4i5NcyLNQPBdgy4xMOZrFtu4+K90gQw6NEjyAR7X7/TLENtdO8MalZ+GFUHDFfQcDDouNoMz8U+Om/7oBoX0GQk0zMNAWJYxbllQmRJS7HED7P9BdEeSQh582hKMcK2kOZM6v1rEb79y4V6PKERiILDpKqAPsb1G6HP1wdV4pQVBBYwAfszKmLKyK9L1dqr7zgF0VZtTffpwygIWkyw9ctZkFdlY0HdE06vm+bC4B9QgRkfDCCxPfT9LvZe6MF5bu7IqNDHVLCwZRfuU7HNw6ug+8ABYVlWmriPLgBODcfX/V5GMPqibtZReMRun7fx+cKBY1m8waPUqmaZAh0MEui1NRIiDgVkIEDPgUoFSBW0bkeHe6dLST/oR29b15FKJULheW16bWYOGhmB/5VChgtuY8C9dR3K21UZ4lD3KfEzJKJQLl4VpErnm6nsnOytCL6f4jQ4bRKjE9k8BwYFhZFLsskYd3HHPoR8kfY3iNH7/jZNwvfYRF1lOqe3VUZsTbvNWpZrnSAOoZJGaTCIk9Df8tauTA7dlu3eXy7w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(921020)(56012099006)(22082099003)(18002099003)(6133799003)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9iRLciGsGYaD4uKcx+t7b6EwYbO/SubHpeVZSYN/PYJMna7c3wIC095/ghO4?=
 =?us-ascii?Q?Ia+vXxjGDSr8pMuhJo/m5yd+pJtq2BYz9P44zIRQoP0tjo4CBhKbShk5xv90?=
 =?us-ascii?Q?Ct73594M8xr4VsILvwYDYSb06eEGA1y6zeS7IS4nWv/FG9o+5tbZVvuU9oJJ?=
 =?us-ascii?Q?xve/NQ6WoHeAt3gV0bdLE8JrG+kCautAiCsdwJ5nCx+SR1E85bujDhw2dB1o?=
 =?us-ascii?Q?bZw7JfeigZM13lVEHuO2UXQbqizoq1ekqJNMsTw2WFQDPuQBdXW4Lul0qeuK?=
 =?us-ascii?Q?vmrhHLXnsrqDvbNKBT8LEUT+yGCIqllm2RyrlY9APDNxGqrMLnk3iVIMgCth?=
 =?us-ascii?Q?fbyUYVJTFjIyH42DGc1Jp4Y8/HagsCQD0UiVu6zDL0MoMbIxyA/mxP8WI4ji?=
 =?us-ascii?Q?bWtSsuxj5ee/Aw6XpBK1qLkvynA+2m3qIR1zKncFZABQB6ptNe+rBX9killu?=
 =?us-ascii?Q?nmzyr134DMxY98Yeg3KYsKhNZMSpGxzQeRiMmpvken0Rdloeor724c1l8kFa?=
 =?us-ascii?Q?RnYmbTg97x+926FAboUwJy0rrEN0nsHK3gO9QMvxaEh9dqrdQeTDvFijpSZF?=
 =?us-ascii?Q?jXs140YXxxRbe/+4suVpxgaLRHfDbnKsrjZ11gUP0vueBwDoGIE03WKf9/JX?=
 =?us-ascii?Q?gdXexjVAdJGBZHVNDay7vWRfHF0IoOCJuPoe25k5cmaNE0bEVfCdR0W2+2WR?=
 =?us-ascii?Q?ALf+2o75dd5afS4xjFN998cjSWFaJRRHTnVZMXlfb0UPAXYzP8Ahiwr3byKd?=
 =?us-ascii?Q?zmsqi/Vm8IoV1ZfRuydFvMS8rVlHL3S2Hvrtmq8knZ3RU9/BBLCWtUpNuwyK?=
 =?us-ascii?Q?kGcUKhtn2KceSjWytXsz7QtHxE97qv/VkFT2zE9FKDLcz023qRCfEenm6Okb?=
 =?us-ascii?Q?kACoAtGc3euA0BqkY7Ori3wcurF8fVDhXjtRcY5Rdb+7fwwHwyxQLVasiZin?=
 =?us-ascii?Q?ualFOW8w9GheOPTer9gckFF55BP1bHNbsLp+h9kr0TmJS92U122BBLX1bb4C?=
 =?us-ascii?Q?lTkByMmas/gyN82x/JJRkqd4T0AYE8ENNz0MPOR0E4CkyxFIaTBdAZamk9XO?=
 =?us-ascii?Q?4YX812yM0HUmriFhuaRcBVCJPTtbuwPn5Feksmq7tFcamgXa7NfYhfYuClbA?=
 =?us-ascii?Q?8btDsylwXXdPXOBdqkeYeVSKl+cBosaxVnz5dO5grcD5eQ+o5cBmWoWThFmi?=
 =?us-ascii?Q?1LGkIgP98Wi4txtGDBgTapPMesIaFznTzRflxEJkQceD0GoC5OhOiTYcIf2g?=
 =?us-ascii?Q?hm6m51K1N5YMcFBDcfShPJw+gTYnwI5BQooNp0fg6IwFa2RuXvGQY7WME/g9?=
 =?us-ascii?Q?M/X5sOwx2pBFKzeJCEXxvs3scofplQhcBa95QM9GmGt7k2G5tESh82M+prRY?=
 =?us-ascii?Q?Mzmqb5kYfYUzXzxsUqZMooVAqPf3jvXwf48UIk8zl7eltH5bpBcy46iEhj+d?=
 =?us-ascii?Q?wWwVTL4zlYWyDJ6wJrQSL+C6D/r5TBm4aWHsIuRGsByA+7lSn/IN9zYV6tmb?=
 =?us-ascii?Q?KQ304wQD6R3Cp0vMXzu7sAoghM87ypHbk2RKtF/0RSqOIDnztwk76lZDvnh1?=
 =?us-ascii?Q?JqBoxH9YZVzv4E3sMWyfbOQWvA14Alo1TQBq66JjQ1eHDc4LabVxx6ijddYA?=
 =?us-ascii?Q?XjRaQntG9NpIUVE4zI8R8eeTLxZnpinRP80NY2SJHyRkLFbKKZtNkqZ4mQc7?=
 =?us-ascii?Q?7r3gcHJpwUMaI7CJU/cXNKOs0rGFDRYdnkkxUCYwp4dZz26vtkamqFzbHsSg?=
 =?us-ascii?Q?ZJ1Fy4k4l6CQ5T7ZsSfa8tTq+maELgdlqUSGjdeoHrfAYNDbUauy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c949e897-2541-4f8f-a5b2-08def20e99e2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:56:06.1613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxVco7QDeeVEmDz19tlE2hneep6PQ4oXY6oSkjuMmWkhDcJ7f5+3JDPxlepjlbkZtbzQ3DCFblcyXqQ0Uk3qInyo5Ts5EIWhfTmswNPTg6UziUWAMp8skwOTzpsoOV9m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10592

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
index 38f2b7c63133..64d66420e7ad 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -390,6 +390,20 @@ static int fsl_asrc_dma_startup(struct snd_soc_component *component,
 
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
index bb9e036c7937..f1249da0658c 100644
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



Return-Path: <linuxppc-dev+bounces-24701-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32555C4453D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 02:19:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5FFM14mlz2yVZ;
	Thu, 23 Jul 2026 12:19:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784773191;
	cv=pass; b=Xjy+zaKBnIDLet1WDkcdSMKM3lIvYzwlO+VxNVe+2uSRAOgOkux9PfL96NdSXeptZwtviXLnnB4Q4wDgd6ByhpA2hv8CCoMe9kOTMwtSjqg/3/FkjULLn9x9J+f1l+GbFVrpw7fW9UhW5qa3NFxOpgwDVu9tamkwftckijqDtKMX41z/pZ1GhvUzE2WCAkNxkyVgaMNApeoTrsFosksMB0v+JpolL7ChZ2y8k83lFxnAjdpD9zdMtKCES12V+ea6isiEELjuodyix2X4Tlhyb/OKNuwL7QQ6/poZ0+aAqv/E/cR2I29yrLk5Okrpvw9I0I4U/CU2c141xFUzppOGZQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784773191; c=relaxed/relaxed;
	bh=odU49gaNKfhLbaLF4HQb/V23rFFj/D0ldwSbgKQBPmI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Pr/3alckMvwhBsyAWC827KBDkA+IOgq9SmnqXnpLHS/i6SJEpr3X5ZM8ITCUUMW0hQY+K3v24Yx4cIDJCbXYEJu1o3/HV2TKnnDcAHHRwxiqXQT+e+6xdeL6ta8BGM0FQMzgKMIA8bKIF8lGk9QtvfQPQ7Rmz/3ibcBjv+BBKipBuXPKmnLwqPi1bQMEu0KKhgjHvC6YO3YjXgxKCFgin+Z74P+v56CgzPVLdeL87X8/ne5oTR20jHtz/xfUZ32JxEdFOOLcgcxt7QQeDDZGG0xR5eD2TaiVXU9WWHlNahgcAaMTZaLxuY4QVayHcks+PTm3q8GMJOi9EWmVe4vugA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FXLNyT+A; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FXLNyT+A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5FFK41hWz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 12:19:48 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gb06Cntv4QQfPztepqWG/vQKydKWfPhLpAde02Y4wArKR0wLdPZ1Tgqj7ml6IvlIV1zi42vei0mrELAvViYHIBfWTIOETVd2TxQa+pvb++szvZ63PQzjCxBDEb/djoo0X49Z2jR7S2Jksy1eZIB+Gv7hH2ROkohONQBTrDPLt9ouzCdFdo+A8UDcai9tNcQzG15YrzXpZ3Aia4BkySW1j2yKQuobtmwGWePm/vjeHisxJu2JJJYo6o852zxkpcKALkuJAhVrNyyRbyS5FgRkTHVaFUZuOBHWU2LZv77bEtM2bt7azzYaG9LrEkD63FS9qH6cMygTE97L4NenHl9LqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odU49gaNKfhLbaLF4HQb/V23rFFj/D0ldwSbgKQBPmI=;
 b=xY5SmWqFikV1FZNvD/Pp9Eu9TDHwX/ecXrIOjuhhIKYBc15ornWAR/VOH5GbPcibXIa4RVGyYShyyfqHIF7qkeAa5b/JDf4P77m8+hR+nQaxCBlOMHfmQFwTR9frdr/eNVLOdmNNPH3MoxZrimCw3rWZXS9NWG8kkpQ989zc2uvpOnRZ39beZymmquFYLGLMG/gBbsQ/OJs+P7IL8ev8N9zQ67QdAQ2lV5SrglQUC1ZBD/9BfFUeREgZWkPucjz52OJl670k/mToRxavAEbWTrpW6EW1s0n72EOOjrUPNfbGXCzBBwoHViR8i5lxIsPAeDqu4bJtblXGDjZozyBNLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odU49gaNKfhLbaLF4HQb/V23rFFj/D0ldwSbgKQBPmI=;
 b=FXLNyT+Ajenw8EBN1li2J3AY6Zo0XGCOcc/5gUM7j9SwFmBJkhdR7c1wsiMKf+oKpLeHiI204D2yMzcDjiuV3TE0F/UBRLWEs/2JyrZIf9Q95ExZlq2k9NJHtu2hHHjaA+iuCtmHzL+WE1giGOTTlWBdYFOdV71kQT2Yw1kcxVV0odUYcilK5XHbqcmBzr01oAynanbJY+0cQKbu1Yy25BAGZHmaTkclzPXn7PHDAOQaZWx+JzXKAGjb9SfsnPv8V+w+Q0fQx7+9pA4HJKyeV4TSONxTh0CbZQC12ID5XiMFIgBWiPHsQFpH8DrNjYjRG6X8Ms3KPiValFO4x+M2yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by DU0PR04MB9252.eurprd04.prod.outlook.com (2603:10a6:10:353::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:19:16 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 02:19:16 +0000
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
Subject: [PATCH v2 0/5] ASoC: fsl_asrc/fsl_easrc: expose per-pair/context DAIs and fix DMA race
Date: Thu, 23 Jul 2026 10:23:08 +0800
Message-Id: <20260723022313.1905051-1-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: OS7PR01CA0244.jpnprd01.prod.outlook.com
 (2603:1096:604:24b::15) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|DU0PR04MB9252:EE_
X-MS-Office365-Filtering-Correlation-Id: a0157649-d239-4afe-a6e6-08dee860cb44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|19092799006|1800799024|366016|921020|6133799003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JcGI7zcUzYT0U3jwIu2yvzK/A2QwuCW0OitYmr894Im6wCA3Ykf6Zu60dNuESwQ7jhNeIwS6wf1jODVyL8C4+V9N9Zt1ZvJz0FK8bfNneyxB9yLx5ZuQh5ynLQ/J7mfOOD6mU1DWO5+vuN4HGA/JBIhx7x1PnvTYmsGYijAr0auP9ooENxgM2K71OEdpLlQE9nONNp7M1F0sphNBqhFTI8RA8bffouemx+82s63fi5O+Vu/bWkkMQKRviZwnRjDL3aRpIgr09+NQizJtq8tTSsodZLeowHocQ3FfXUKS76xRmESkdYppszcMXofRlqhUf0sbregwA+SnG24VmA1HxIGLd0tHDPh22iW8apmvQe9L/0rUN1teZB77Hha7yEdIAxH2psCrEs5j5Rz9m1dK9QDB2uxgFASTM06Y+Hl8DtCe3mx1R6CsIQADuqECESzl3Go9UWNO6e+aVguSt9q8eacYGdI/DSe2Mvy5Hc1QycLQZ1sU5kR4AJc46eTTs2XbOI4Ehxmkd2qazO6mqKw6Lpm9I3wlnpa1NTijA0ZcN58vzlrG82Z3q4kXXJvSx619p35FCkGVu9uki88RlaBncSIRk7JmoFWGGhRVb0e4rGe7meGhoB7YnS7pkdAJd4hBNodQBuHKFXeuBo2Thm1eCsiNDF5mfNn+LVCuTLbag07h9lyuc6Xgt+6fOfii+4g8uYM3XdQkrEE/Q0gqGW6AGA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(19092799006)(1800799024)(366016)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I+xzSicIAd8EwNFvKgIWW7gosN1Ae4SVdH26dHgj7lSdIQDaIaU6g3W9CF6D?=
 =?us-ascii?Q?QO3yDcRgEpxQANFm2IEYPGyzDaSeJvj71JTnTOzeFBQtXZgS5ulsF9ogthCO?=
 =?us-ascii?Q?GRDitO+5ZlKIbwLDrrzbSGHw68dcJtkOpq95/rr0gvfhGkQakCMTHElucWX8?=
 =?us-ascii?Q?XbGQBbYnFxXEHgj+1FxTydOKJnkvhEsGJKaspWSqs+ekw1wGTxdvue1C/3a/?=
 =?us-ascii?Q?beHrZUiwo7QKFFTBBA/JT+1jMV6G5fgZL6zKvu6JHLIHNnKhdZfgZJe54aZI?=
 =?us-ascii?Q?vbbJtMADkfWnJw89tRAteYQqqQPpEcwREv2MgC2RGpvbCVAGE1xfMar1bA5x?=
 =?us-ascii?Q?m1Jpj/O0Z+Z+coZLFiwrlBsSjYH+y6XWhdDlCvm+M3v/YzfDIGXAsuis4W2T?=
 =?us-ascii?Q?/UF59eQPe0/+QoMnftZYujkZMsZtN3PoIOT04UWp/u5+KvSnpiXFEwhu+e19?=
 =?us-ascii?Q?+50NjcaMg/DY2sBFhDhxpC0djUsjzkxk0klY7DaQlXj2UTyANyypi0iBIQXL?=
 =?us-ascii?Q?naJedKx4r2wA3Ti+Uzk4nmpWWeK1aHeKl8wsZ235+hFjokIX2+sxSGe8fpSr?=
 =?us-ascii?Q?kZ7kVyYlSvLj6YWEi/biB2CEK8ZsPZTxZJz2AhTRVY74uMR0Y5f9dHyIlnSc?=
 =?us-ascii?Q?ns8xwfzZLv+ov61/Z5DwTYsYIIH8Suh4mdfAiAhaFb1SFqUBMbKIqtRD8TLp?=
 =?us-ascii?Q?cQJx+fYSqkhBxFfbsQy3uPjZjxnWJxOGKSVWmOz+fblBSsMTFSLMYU1gnhjJ?=
 =?us-ascii?Q?NeRfp8NiMWaxdI1GyOx6CXGpK3NX0p8+1bj1xvKJzSmx0ZE4W8cczIjdv4Uj?=
 =?us-ascii?Q?Y/VfYoyn61yVKan+Q/WZwvp/tFXH3mDjC91e7KpJskPmXL5GUOYxmHDPtaZH?=
 =?us-ascii?Q?F7+NnM+sc/L06dQe3AQrQBR3tMUKeFQ5+cR4sgj3fzMeP+YB57W2K6aTgE7F?=
 =?us-ascii?Q?HVM9erGBKLWa0d+56gTFR6AkVEMNeiz2aBVSUYFG0CaJ+QnLYim18lzffNLl?=
 =?us-ascii?Q?k5GgDRskDBEVGVIaiV5CUklUVNemRRWfXSVcWDvfBmPQJlKtxoYi9itWG+f3?=
 =?us-ascii?Q?3g6vYucHjCbxuGlR4Z9rzTFYGcNVsWIgRvAOByDmiAUumC9dTVFPFrIdCmyo?=
 =?us-ascii?Q?8kaQxWrbo9jOGUiKQ2Ogn1908L0MJRP8XgsXwfeUPyl+UEcnokQsCL4uLXZB?=
 =?us-ascii?Q?oOxwDsC15SmMz946203Hn9bkuOiDm1Jjx1sthuOejeKniUS2ldGukZGLqR87?=
 =?us-ascii?Q?tizhvfRVBkRmSFSsPz4PqopLieIIx8zABXmnQNuloy1knGvW/8q2HXBSnMzC?=
 =?us-ascii?Q?1Nmii8su5xUddp93zuKw/dr/Wua3P3ej/1VToeA/qkfDYvKf44W8c/JgSZoJ?=
 =?us-ascii?Q?vOOjNoL24oataeknAHSTxcZQ36Thl/wiuO3jLm3tBPZBr5fHqba99DcDbhu4?=
 =?us-ascii?Q?oXZT+bkfO9GcDYsv0X2Ug5TNZze22NNzDPRuZZ/uqRCSBSAZ63+HTYE3ofMf?=
 =?us-ascii?Q?wFseK2opUuA56VidbTvOO7rIK0CHN8tgjrR4JnAEBSAXt2EGZtsedbVknil5?=
 =?us-ascii?Q?D/PKzSIUFXHjEqIHnJJnUBPTpXjeA/sabZyK2aM9HRyephl0WZKeXuiFQGVT?=
 =?us-ascii?Q?EgZFBsLC9kOE3ekFBKmLAhEJ8O2jWf9lv0bsmMEFuzailVi5+0yTGoR6EzfZ?=
 =?us-ascii?Q?AeKKWDm8JyHlgI+nU5tzHwPx+JgqgL5Brt4O9kdRyWXPXSGRX/yU/lDIY1Ug?=
 =?us-ascii?Q?ykwMI3O1Fc9mqmR+cdtOf9HMQt6NnrzVd75lXxiBuG7y1AVGpwv6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0157649-d239-4afe-a6e6-08dee860cb44
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 02:19:16.0410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwIu6Xnn2ByHqsLOwopq90P9cEyigh1iPu4ws15Fabsr3YVKf4SZNiCv770D9j2RKpvMjqn7Sr6vhrrDKy0aljdXyZFsVO8jJEyEXoh5iuX+/zjV5YX6TgzBXF6Dj3+0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9252

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
- Stream names changed: ASRCB/ASRCC/ASRCD -> ASRC1/ASRC2/ASRC3; align with the
  index-based DAI names above
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

 .../devicetree/bindings/sound/fsl,easrc.yaml  |  68 ++++++++++
 .../bindings/sound/fsl,imx-asrc.yaml          |  70 ++++++++++
 sound/soc/fsl/fsl_asrc.c                      | 100 +++++++++-----
 sound/soc/fsl/fsl_asrc_common.h               |   7 +-
 sound/soc/fsl/fsl_asrc_dma.c                  |  14 ++
 sound/soc/fsl/fsl_easrc.c                     | 123 +++++++++++++-----
 6 files changed, 316 insertions(+), 66 deletions(-)

-- 
2.34.1



Return-Path: <linuxppc-dev+bounces-20249-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9BBFF886F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 02:14:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g517k5VPRz2yrZ;
	Wed, 29 Apr 2026 12:13:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777428834;
	cv=pass; b=RnMuRiJ7bFZFaw4pSDPnkk2O41BzLGa3YklUcEbcod1nUH08osyrCqVerLRi6CGJsBEhh5g5+FbgJBHBuNuC/+Z2Co7/jJ4w0waGreCpVPpKucId5KsmMFyH6aIV3gi5sbuWDFeZwFxGL3c4uwTXZ5ujIHvZa2ji/xlv3BXx7wir4ig4ikfjrh14k+08WqmzUkOiSx6m8UEXH5AL6ynuMTjK7uPWV56tiuQq6GFiZLd8U/xRntwy4kBWnc/h3m+TmA/5BAfx13jJk//061xTJNNl2ZiHAHAA/JnweC9A+iYRB5LkhRaBSNRDla8hDQEdWJhAlCVhf+vVr5c4tOU4LQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777428834; c=relaxed/relaxed;
	bh=+NiZXx5o09MZvlnA1QZ7+qeVByGgJPwITiV3THo2zG0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jcZqbb8vm9z86w6N3l3B/XnqUlZRbb0xj9etYHjC2CPOo+xGVDk6wyAmDgaBSlmrLDF7kPiIYed4XgxSJvkZ7IyZTTGjZLFtI4YTCUwiw7WuS7cLArumfNB1SGt+/T7CZEb8LZISAS5fvkAy0YOI65BpwAqylLhVsaJKRC+hXMnL8S26ywF+NOLvgWhdZQfx1HOPEXZ27nUPBxnmSPHimSSSHWCHLLMsAfB8EsBMg8NwBs3YJd+IjepgS8tUmGJ5989vCDHV6OPojIPKGDGZ8VGBgF8DmWBB6C8/SR74CAS03QYKtH1B1MbP6j54/ex938B5fTvv1HpQlelxfvozeQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=oCjlxD0B; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=oCjlxD0B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g517j6SFjz2yqf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 12:13:53 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRAg00qB8SPROPZJy7BYXBzjPWphnlWxKS/CI2EOcwa9Wh1HLip5hsl6FWV8FBXZ/197gYBVfXGxiIaTdVbe4aqeBC3WnVVDgGlJqvRmqGbHlBrF2y703Gu3gPjEDcONHlIYbTGdS7ey1uSr5hX26soSNJKp/G9bDPDl1p3A7cuN+hFZZacsbp08cr2zKzS6jy2hJegrX2oP394KhGGh2MKk8s88E/9cXa7VpqEcIVQS48sK9n8tfm5qy9ESjcvb8q8FFHTC/yv3k9dg7g6v8y9pI3bTjyBWvB5x7V4/TDEOcJ+2wcrvxngeTQxiJBHI5/2VJtf/dtm1Ig0Vrs1+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NiZXx5o09MZvlnA1QZ7+qeVByGgJPwITiV3THo2zG0=;
 b=VF7eOpu6M6vdL661l3dsXHs5MTuJ08AvCbONhMyckVEPod8QP7YKevgO0yL9fL5wmJqxGiH3w/ojxSgFKV4Th6euyETXtGOIdtAiMzmlIjPsEaMBlxvritKkcYBOLlYL+NPU/4bP0K73gdcYrtiHVYnNP2gxn5ubqxzhokrw32h4Esd/IIp21GiEVdSZgV0bI/qhxIkT4qp9ckUmzMu5bMovFtHdh63m8zqRkr8XQXZfDDbYHmfQPnQKhT7TTVoiWPxEwrUCyKHyADsaf6jazRVGNMbSftjH6XmYFYCupxgJwY8NyzKXOF/lz4BkMtOgYSuD58h8H9gA3bvjZkNxTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NiZXx5o09MZvlnA1QZ7+qeVByGgJPwITiV3THo2zG0=;
 b=oCjlxD0BscY6+3jLjJehzKkJr3GfGOghpqveVQ+YT1CfR+j/DRzLZTZGBqvszTeJW85xQX6/CUvR5tepvDqU+ux1+MQ2nXO7cFENc4V7ls4oriQiVYAfPAC4ZAVXxDl5Mxd2lcLxlIZ/6TRir9/Aw9uv+f3pFVVvqDwTSZKYiu3CKpdn4SF1eH6A1okWQNIiXOHQBKJM1ZWd/0OsFAS4XoaV7kNQW6ZxHfuuNHbdij3aXxp2nxYB1hjhoZDkqMwIVfE+4NlJi3AYPqsGqAArpTS1w591ogdS+QfNBzspGPy5K8iG2FFjN4UMqGHo2LS+2CRA2zrFnsB+yUHbtt8A0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::22)
 by AM9PR04MB8276.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 02:13:25 +0000
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc]) by AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc%5]) with mapi id 15.20.9769.016; Wed, 29 Apr 2026
 02:13:25 +0000
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
Subject: [PATCH v3 1/3] ASoC: dapm: Fix widget lookup with snd_soc_dapm_widget_name_cmp()
Date: Wed, 29 Apr 2026 11:12:50 +0900
Message-ID: <20260429021252.691263-2-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260429021252.691263-1-chancel.liu@nxp.com>
References: <20260429021252.691263-1-chancel.liu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7cb1c0b8-40a5-46d0-7af3-08dea594e554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|376014|366016|921020|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	qDY95o++/vGpJQVX1za15O1fVHqJOSEcMEtlIFRLyK5x0v2WQBkzh7WnYFV4Wj/uji/EZgHpRcM7wN3b0zE/8hbP59u5/m2V2IhPUzi6nA5qtcv4My7kYDwMyg01b3Ahlw89oaqo9NocXxZ6X+cHXr/T5YwimHQAMiIFs3JA87VCqmIVYEMWW2FSU1EJCMd9cNWi1HoNUUcFJSMdCIB8D7kTzq/Jl/pUzu3KmEqGd1hdAUXV6csal8YpRvsmC44+2Ubuw2HtrhydXf/GplV05lQ3gCly+4gGXScz9dB6Cz+j1BJECmMZXpC8raEpaZO1+jzY41ovGHqA9ibTZDMz8V/c2LkV74jHGPd8qhu6phz4nIYrQqYkSZYLiv1rmgFJq1OPNva0ruZdTZLhxNnHsvwWpM8MlJS66+jQ9DK7Z+t4j29UW73Q5M2pqDySnPOxstGA4gBwJNwn4VNqSCXg5v39OyFqyniNXEVBg0O1WHOatXiQyMwKZFERyLhPd42ztYYJGQa9uq9qvOGyd0vUreOKL94bEmU45BuXq6aZ268XtyhuJbwh1G3ljD9FhyYvFS0bnBEsUxrjc7ItWegOsRci1S16cl1H4mF4AwvZ9hw3pkuoaCMN7yftqudMEonvRKrRvr4UIPkWpdmK9ELjn8eqRIrMrApW5uRbYybIHs6Rs2MF/cuzD9JDVTvFxP47HAR7Y7C1QBD1fi55BxwZlf2lx+Vx/E5EU3IM5Qcr0A6EolBZ3avQSHYldOTfUH73xecauRLPq2VVw65AGtN965gHeW3RWZz6F3MM8HjzjEAbdv5nUr+66WsICS/AIm+0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8353.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y21CKXLHArDtaynSHYI7ImQ54dyhzaKvOLAbenMwP+2ovqXSMzBK5Ftb5SR2?=
 =?us-ascii?Q?crKbC3RXWr7NUEqFReBaWNdCXJh5M+qRxTKWvlV+rZlkXml6HQ7lhCBItpcs?=
 =?us-ascii?Q?rJ+gHc15LiJLlkjFvY8x7i213BAzPupKTfmbQok8uesN2RLQ6783IdILMlFA?=
 =?us-ascii?Q?voiFBFB+kFBLtP37ut1Cmp8vVZ2XNx5ipbhaV0e6GknBRRfpz0RoJoImnd8Q?=
 =?us-ascii?Q?ZaA/OoRuzYpUSph2K5Ym2kez/2/CHX2HV37cy+681Dmqb4nEUSy12iZFO1Nc?=
 =?us-ascii?Q?leRAVArqcpP3xmMEQgvpjjwrg1taRLr5uzT2ho4GEsCUqYui0j7E2hw3LbqR?=
 =?us-ascii?Q?zrBFB5SAw98OG5aAOWS3/mCLxpAVTdnql6/TYiCr45jlU+lgjDzt+6vBZeI7?=
 =?us-ascii?Q?hFnfHZlrnBFLCoXD1L69vsStcK8nmiEG6ofHLPqEymY9zNUPjbr+6YU2tR2C?=
 =?us-ascii?Q?OTVe+VKQnzYy8hMh9VMM7ts0GQVfQT+mWXWToba00Sfo584mnwd17eiVKn9n?=
 =?us-ascii?Q?+gl63o+lzyb6nZUMMS+KP53ai+3r50fSMHm5ygR9Q0j9/2SzyF5NUUi9ckmt?=
 =?us-ascii?Q?+NxT9jHk87MdPBKWPRiJuESQItAp+RI+b/XwW1rvB2Tj2r1NlKbnKdip4Uqg?=
 =?us-ascii?Q?ryAHSDqCBElWkarjIWjMpZmITuEx1D9bYIupn24/oo6UJ4ArW8RTQEkt3M3e?=
 =?us-ascii?Q?91D37GaVxS7xQHkha2OCKIBM1DAvxj+ce+5CJW5mTeppUb0VFz3VGlKTCp+U?=
 =?us-ascii?Q?50rCfJuHHVwzxAvhtgMm9Gzadms9pBAZ2/18lIHFwsg43G7MkbVDe/JCQPnw?=
 =?us-ascii?Q?IJ1cLa5Kpf1Ay7y2shXY/Vdl1QLx9z2bHqhmVbFjGbiL2nBiklQmPbSF/2Wn?=
 =?us-ascii?Q?cVIu2JeYaTM9sVLGQFOd1QFO/K+Ak2TL36HUVCDdU/WqEgZvZ+vl0srhUY5M?=
 =?us-ascii?Q?dqtJ94d82My/beR4q9l33nUaZjwPIfx/IRp9TktlQWc+3HsdBGCnDqPXtWqf?=
 =?us-ascii?Q?frglNNraX5RGj3NShkYm4GLfcbn8WjFxc0rFsrfZSq4LaabHHlBJMgixFhwj?=
 =?us-ascii?Q?J/OvOheVF+a8GGaXFzHaQQlWRcsQ5loYrhupbU75TcF2/tsssI4C6x0nT/PO?=
 =?us-ascii?Q?SgQ2RbZuNcDC2LOpN9NcF6kx9AGU7+epiHEevuxJJgpovO3qhQ4tfQqY1yCW?=
 =?us-ascii?Q?B+mnMPInSGBE1oHglS1KAOkuIyVL6oPPzkNfFEwgqxjaBKlib8gBqvf1tOPj?=
 =?us-ascii?Q?tw5UdjGXz2VCi/iSm2Z5IYZyvbYWghXJsSMCrj/hXi2WJvGAMZvqeeP/m6f7?=
 =?us-ascii?Q?UFQ9tXk3oujS4tOzUUMUK61PZ0wo/P+TKlGmDC76MZMZvkBCB/AGCCi7kuaR?=
 =?us-ascii?Q?85YGr7XZen866jHPQay2ojQqntm+WLSP2mJvzLNkRCp4YRZ1NJOw8jJ8ShZC?=
 =?us-ascii?Q?giSEU/U7hprWJjRvUdoeKUctKlGk0ne40aSrwxFSWnbzIrgCjsINi3NI474q?=
 =?us-ascii?Q?Anrtl7+CbOO15AN5iCyIzFa+6sV1tH3SAmH0zQm+Qy0yjmv2mvlvXj/vQ9rq?=
 =?us-ascii?Q?PEh1NAmNhx7D/+MIMicP0s+VF4/ZYjMl9gJ77X0ohHT9h4amG3jFakZe06IZ?=
 =?us-ascii?Q?8FTZr/QOzCKvfEVYxSC0JhUd3XWf8/8ilkchcH+vh+vMT8LLMF/PN8qebbk0?=
 =?us-ascii?Q?tTJQrEzv+9NezoLScIWqth9cWfs5kgprockbBIgQIpc9ml3BtS3WyxdZ21sX?=
 =?us-ascii?Q?khLbXcWn8g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb1c0b8-40a5-46d0-7af3-08dea594e554
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8353.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 02:13:25.5736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkH6cq2TDWQ3sdx/Sh+Cp+mwPobtnu1y7VJ5Hw1UtSxc4hli6Co6sZfp+MkzRd/zhnSrfZLxv58DLI7OzyGUoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8276

Currently dapm_find_widget() manually constructs a prefixed widget name
based on the provided DAPM context and compares it using strcmp(). This
happens to work in most cases because callers usually know which DAPM
context the target widget belongs to and pass in the matching DAPM
context.

However, this assumption breaks when search_other_contexts is enabled.
In such cases, callers may intentionally pass a different DAPM context,
while searching for a widget that actually belongs to another DAPM
context.

For example, when searching for a "DAC" widget, the widget belongs to
the codec DAPM and be registered with a codec prefix, while the caller
passes card->dapm and intends to search across all DAPM contexts. The
current implementation incorrectly applies the caller card DAPM causing
the lookup to fail even though the widget exists on the card.

Use snd_soc_dapm_widget_name_cmp() instead, which compares widget names
using the widget's own DAPM context and prefix. It fixes widget lookup
failures when searching across different DAPM contexts on the card.

Fixes: ae4fc532244b ("ASoC: dapm: use component prefix when checking widget names")
Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
Assisted-by: Cody:Claude-3.5-Sonnet
---
 sound/soc/soc-dapm.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d6192204e613..c5b80d9ed64b 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2906,20 +2906,9 @@ static struct snd_soc_dapm_widget *dapm_find_widget(
 {
 	struct snd_soc_dapm_widget *w;
 	struct snd_soc_dapm_widget *fallback = NULL;
-	char prefixed_pin[80];
-	const char *pin_name;
-	const char *prefix = dapm_prefix(dapm);
-
-	if (prefix) {
-		snprintf(prefixed_pin, sizeof(prefixed_pin), "%s %s",
-			 prefix, pin);
-		pin_name = prefixed_pin;
-	} else {
-		pin_name = pin;
-	}
 
 	for_each_card_widgets(dapm->card, w) {
-		if (!strcmp(w->name, pin_name)) {
+		if (!snd_soc_dapm_widget_name_cmp(w, pin)) {
 			if (w->dapm == dapm)
 				return w;
 			else
-- 
2.50.1



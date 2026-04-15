Return-Path: <linuxppc-dev+bounces-19759-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3078FA0C48
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 08:21:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwYyJ4WLWz2yvY;
	Wed, 15 Apr 2026 18:21:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776241288;
	cv=pass; b=i7WhUGZt4nuOd0v9HPBVNoDjnOPYUeu4YYiEqPPHHBvZnBH6UCcl3IrhM1l1529HmsabQxu+O04O6seblpQHSmLKQJq5d7lmfgZZfMAFFh7aKme4giZiCCe3RX1iMkBumwFB8eMKges+gjEVCn/fUdAntXFerJSYrwancITbZHNNUv5Iv+BR4NYtLVKChKsBzY8IIzEFV5tI5sbWn3kNoLUv05HxZMVfCUKIU6I5i0NKw7ER5Y5Zw1MhGKOVutXySKjsxjg8IjnWkVsD0kF43QKUQnxWaPgRwpdmRDSlguQF889+7tpoxkY/a8h2CqoO08iBhCmMrSfXzwf/w84z+A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776241288; c=relaxed/relaxed;
	bh=+NiZXx5o09MZvlnA1QZ7+qeVByGgJPwITiV3THo2zG0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xma+iGnh80RI4oDyQJ/3MW/JWNQxavoMx1HBmBiVJA30xn2YNruvJ7BYqGSBvWEdpE7jFTvARPdJFQPOjmXV5UntQaq5IJxZbHf+x+et4NrGgMMIEg7p0GhZqj5H+KmZk4ktFCiXJVKd5dUlDAwpytyuwHByA6Dn49NThiTzwQWFvPu9UlivDtfS+YUsEPnMDJgYuBFUi4dIJT0VUutdxjAk5CjyukrCGmv1OJhIeCDED6yGVedfAxDLV8RU27PiymEVUheMtd6PmIL4l+VTyn81e3ORhhM71kJ2VGijRRoSjlrgn9fQvCqrenEhTNhh5F2kOfksfmGAjP3RQNN5fA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=NLltFKbW; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=NLltFKbW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwYyH5mTjz2xSB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 18:21:27 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzJlltzczC5sxPZ6JwRtUKjG1W3/nbtvdaEFphvgO+42wf0LDXK+gRVqXVMvH34qtFV2RS+1QuFsh4oK42eqZNWhTG1YVh+QdZMLNZfYTfK6JMzXN5hgMYh/66q89H47pmS0EjfupuUaaPs7FD2a/Yr0Btt7g8nwxi1hIKE46a2Rpsv8YeP9SyFRIyB/XsqGSNEo+XbdaXraDTg1GX9oe0Q1twFjFTkYGLvGkRlgDxM+RMMwvVa0NdvagdmfMn1Uj6ZaPqXCHWqNm+EJNWuQKZYpDxqwTkmueQO+qm4b6mhcGQG0itL1UbtoePZKYN7aXi5TYeTy79WUwgpj3IcBEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NiZXx5o09MZvlnA1QZ7+qeVByGgJPwITiV3THo2zG0=;
 b=h+G4vtIEUIZ2Nn37AMtSZxqmB+uDd+rGOVLvr5Bf8eYmm3+bNo+rBCDXKdR8dxpkgUlSxRoaByQAVPH0QGkzyauTKqtf2fqIrtIbKhY3WuOGDWsCYtcC3ISI7bb/VfKGJbM+PReGFvVyctCH7lHOyo6+XoB8KVGMy+y08f9wWclFOv+y9fYVeFSraTSM1afkf3CbhQEmtJVZBWc+DjWfqEKQs89EGzUeqh4TQzx2Ni87PphAOUYmad8DYO9od8sXN+2BDW7IDgazryaE1fxNGR+PkqBdlsUO6XSdymf9KHnagZC+Ep9P2y8c6+UzAwhARCoCFVib8wMzslG7zTU+BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NiZXx5o09MZvlnA1QZ7+qeVByGgJPwITiV3THo2zG0=;
 b=NLltFKbWVdrdfxhUAdHmF9z6NIt7RQ1eaXfTKO9JNz+E4INDEDUgP980DwduAZmaqrWVUnGnl5MRcOpQjdGwM6TrrUsJmPiaLqxLJO5ITuVzWxSDjxWE6Be4j+gF+WhR6OuMPsnM7tFfkWRHGc/OX+tQRfRLNIO1AYqkV5gARBSdsNk9H32FKxCQzXKEkT3iuuRU3YMUXJQla00bJdVTN8gmrTOAdj1+jmGY68lBiOOqIczbYCvuj++IYzK5GWP7h/2hcKtUw5IcPnEGf7tXyLhco01UbPo/5Zar0P94pbjW+84AsuCwxsVH3lNAXk2mXnC1Rc2GHE4dM1F81Qfwbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::22)
 by DU4PR04MB10530.eurprd04.prod.outlook.com (2603:10a6:10:55a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 08:20:33 +0000
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc]) by AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc%5]) with mapi id 15.20.9769.016; Wed, 15 Apr 2026
 08:20:33 +0000
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
Subject: [PATCH v2 1/3] ASoC: dapm: Fix widget lookup with prefixed names across DAPM contexts
Date: Wed, 15 Apr 2026 17:19:40 +0900
Message-ID: <20260415081942.4183108-2-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260415081942.4183108-1-chancel.liu@nxp.com>
References: <20260415081942.4183108-1-chancel.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0029.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::6) To AM9PR04MB8353.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8353:EE_|DU4PR04MB10530:EE_
X-MS-Office365-Filtering-Correlation-Id: 947c025b-6a3d-4fb0-89c2-08de9ac7dd32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pJf6eH1nvLs324Lkf8gkz57wsG+lZQBRGlen+rjdcujQSqZ8rS2tgLMGsXoj8Ry6zswr024lDf0FdmtCj3JXrhwa3Q/xJ5alvwX0XJqtwH0jC9j1tXyN2HSvME61aXSS7Y8LimCaAm/tkUwmPBp4RfpyO0lrcV8bpeF46dM4T7g0D+CwvswitT7dEE1tnD8YSWsNe70A90tiZC6rLFqOKZ8V9uYjvvwTavI57yGy1feGTfsER9p0dVBlU5UPPapjSiVQB/NtFbHILoS+H8/0XWpW7u6IW4WLhgrV2jGQycxqnqOfu72oVtJtZs1vT9Mg3zlJv93MPP5A4x1Zjv0qNz5/TnrpLhB5CDrwe5u8MDRJXuoqzilhMzTtf2T3QiPgucHkYJpro4ecSL2fPg9JNeAByuCKFTCB2Sz9S4jwVsMiQgrCJy1Qxvxiw0bp40uUWJ+gQJQ4H/zy/2chFm7iAGNdSxK90o4TapoYg9V+gnRp5IJLzzdL0FltCycfkPDGzt9uw/hdkXZQkj9JyftZ6eqnNXi24GXofeJL2efWdk5xZBsHnpNHA4qSvydIX0Pp7l0pWWmn62FnLpiPi+qMWzkzJAjMOuXHExUcALOYwB1xQWWqWdmg2HcCUrmPCmCCGE1P7BCo5stIUb768wReqnTAdk/y28z7xGh+SJ/DCCcl9O3+ABT8iGHGKBxnnFAd8WUjV/tIGiTUcZEBX07DhYRMr1ForrU1yV/nsyLKpI0asFK9/Uy76xT+Dzh7xjvWelXyeHSi6fn6pXdLvYhZFMW30qRzzNO+T6JDZuOfjMabUaKp1urdXcrlA57i6RgW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8353.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BbikMlXyj7itiSS7tjDL1mn8GxM9IH9m7wUzSKn2d+3uW8mXNdiVo75FDBax?=
 =?us-ascii?Q?ZIQ1SlJBIqwML5sX5ic55I0IiDixZEAM2XpVZ86AruNiCOwfOqRHEK+QGgvK?=
 =?us-ascii?Q?IKkBsMHWoiiPT/vfTDmUWrSriGl8NRSORXHpABboXjL9cGh3nBBGQFnxYlP7?=
 =?us-ascii?Q?bGVbPVRl3zdWikkqd2RTXSkAe4aF030L6ENyLMIjHJIvRHokXarpFdtzzOaY?=
 =?us-ascii?Q?c2nnP5QohesEXtIqG5qMv42PFoOTTBiJ3A+fby7DpxuSPKhbVgGXzRGJlwsT?=
 =?us-ascii?Q?DvTz4esLfivPoLWyLor2nWvNZENaYMfDeWC/hVXaWBSF3MIGVNJJq5Sfm+aR?=
 =?us-ascii?Q?9L9GryhHSrTEkXau8KLzRKSHUmRlbnf4c/W5eupt8S5XHQJzvr+kWQtdKj3x?=
 =?us-ascii?Q?t3Es7VmWHoVuEK0Haep/STD8Rq3dvEfsnBsIi5zj2O+TfwQnWpaLo+kKcfPG?=
 =?us-ascii?Q?xk4wAFgJ8dWNrrO98ckGWz30oDoEOvhG0krxIOv9mRxvp25ZXcTj21WUZiIN?=
 =?us-ascii?Q?iIBjVOni1KvlWZjujhJ+yDqpau49PCAryw/oaaJbn8AUU4XrT9nuqE/l230L?=
 =?us-ascii?Q?fRHJzat4LgRAnuYqzBjpUMMBzyu4CnzG7SjB1r0Uzhx5Ws7AJSTFqFQnIAgv?=
 =?us-ascii?Q?P4UqhSID448Kxp85wK5loiR+GpeZZVlhqbroLzlKkDQa8SxdaDKcQpdIESIi?=
 =?us-ascii?Q?L3w2Rpu36LT3XlGyZ/OCYqsliFybMmGHliSCb99vHklcqCN6AGzEPxnRBK7i?=
 =?us-ascii?Q?Q9+0Rw6/DSOcfNCO5IQEqMIjQiFkoUDNs66HS5vrZy4fICRWJLq11ZZ8OETx?=
 =?us-ascii?Q?se9XPA4byvbw5iilQTNV5Opx7g2BnT8iq7KvCw8walVOS2DC70VW8o3MAt0v?=
 =?us-ascii?Q?CB9xjJHb7RDfReVTnex9Cpg/njhqBfcPG8ZzUjz31tm5ImbEW325tiPiHKxM?=
 =?us-ascii?Q?w0l0aGi8jJyFinyU18HB/Koc/GNZVbBp6omNmXDKMzdaDHEgbrSD9FFwcBEW?=
 =?us-ascii?Q?C8/0PsgqWpsDMcQuUQMZfidhI4x5jFCTozhtlEMI9Qtbc1LVHdHKCf8lWNp7?=
 =?us-ascii?Q?lkdWpzMH1bfGobCq9VacAW8aQ/k8FcHBCXkFitTMW73SmwSknd2SI2Ev2IeW?=
 =?us-ascii?Q?pjg8Ht2Fo/I468ydTNGW4HLBIpUua9G+bFPV6f0VnPP557Uk1kt3xKZO6lJ2?=
 =?us-ascii?Q?vry3K56Aa/YmNoB1nkL/o7dgzeERQ1zYovu2om8NGY3um64smVgoChAO8smg?=
 =?us-ascii?Q?k303BjAK7SAr0xIbbgpAu6AH1f5Q4kqH6ssXNy1KAi+8e1IXi44o+tJ2+KED?=
 =?us-ascii?Q?oBxliHutO7AtmSAi23TBnIon6ovI4vLNbEIqMbZ8SmTfq3lm3LGHLphf9d9M?=
 =?us-ascii?Q?KYrREnE6j60v0M9hFzAtACT/9OBKmkr9DkRUDFUx0qjd7HzBHFCtVKYXIeAL?=
 =?us-ascii?Q?+8rbLk8Usrd2CavtHQ2u0W73cXG7Uj/1F8Ey3i39GRYqfSPp6hd6STmJxZU4?=
 =?us-ascii?Q?mRitDsvPMvhT81EXvgODE3fRavs/doMkaqJc5XanHKAPXE2WqK/aZLEJuO96?=
 =?us-ascii?Q?mNL/1VXlzl34op/OECBiHk+d3ILXpC+8WjBEhAJf3GaExj6JJcBXiakSnTot?=
 =?us-ascii?Q?exc1p1lysepNbpAA+e0G6zpdTNkA5dHdDL6AhhGt4kB3+Vhs0kVyBodsgoZo?=
 =?us-ascii?Q?n37iIj6kcmlWmL1HRbS3SBWvD5TJi/hqu0hdsclHXVwpCuRggEr09jI/7is/?=
 =?us-ascii?Q?MexKhsNf0g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947c025b-6a3d-4fb0-89c2-08de9ac7dd32
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8353.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 08:20:33.4555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqar89p5vbFt4V9JGLwt76jDcvL2oaX5TDYAICVUomiewQsF5fPXYSHVII9xz7Ua9yw8AgBoEPS5rIAzIBgctg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10530

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



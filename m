Return-Path: <linuxppc-dev+bounces-20538-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E5ECD342C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 01:38:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9vzQ2fCmz2xGY;
	Thu, 07 May 2026 11:38:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778117922;
	cv=pass; b=T1a5AcjNxvWjEwPQIhvgFtAGl3fJLVkYCojFZjzot9FOVfhnJYIGbtcF4ve1VLzwWCi0d4lVT9zMkKwQh2X6lZjuNMbNkSzAllXkPvjPlmWFfXlJ0sZA6CxsRy4oDsG1mfIc9M/Djz1qLSYRnE5g/ANsB9V4WlmLUlizjPcg+WRza6JSXj9+D6Mo5x32HI2DxUlZY44ndSYVIrI+yQ3m3DNShu0/uMsK93Bsg9ZCAAZPywSn/xN7N/o1ZCXJtTp5wvolyXljoaJrqQig2cYpMZfJlmuUEf5puUDP1CkRTZuQTXllRILw72KMOSsOL2zeP731oHVwl/L0LqClIn2bZw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778117922; c=relaxed/relaxed;
	bh=glTG0ThCLDduxOOOOfFYsw56YxCEixkmSVcCypHOEww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mED4K6ZLPL99IIM9j1kRNEhAnhQbX9XWohNPhOfY+SGGgVzhY9gHwriREioemYzJclYG78JNN1MrXq8yOLRMg/bSg2uIjiGkV3c1Jly5ZdgiS508NO/G/mUHsxhttkTqiu7EC6OpcqjWcp+hAOTkoQuOe/kzr5AhZncTRR5YfSdvTIpNCwcEOC7ZNdd5rIKb5PlwS44mpK2TnG17h+cHf2iuSHsAOPgCtWpW/pbbzBtUjVLKKmSSW3Up0bLW7toMhJ3SGZPeLhhbJcICo+tpkk/7PzK/RThpwVqKoobXUvPPzNvq426aa8YtUBetDt5C/GdPCzjvevuoPCzwY/gB8Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Lr2l/dVm; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Lr2l/dVm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9vzN5z8sz30BC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 11:38:40 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Isl0p+tfDprF+leICZScicOe/sxKfeqAdFMOlmn+Rm8zZupJQqjk8aVC0WLjkPt13TsueeYAaGx4RIuY8iLEJok997RTbD6MqtvDnfvn2nlJr6MvjS3Q8WXuIEf7oPANrQcHgVEDf2w9PyRMUIGzrESDCI+5ojuymWDxMhYzyXLjqdQbyb8Hr32KkaMJiOeZX5fPzrgdSewMSrfcgSFNDBaPqWIqOFBuRGf/Fd5ybfSocfvDbGN0CtdbzoDVBvaTdzxLV21hkTzvKX5nPG7Dz6vR2vkwP9V1t45GfxlIWhE7EggTk7iFk6FLuFESq5NBK9UTjXkqss7TnKFYteNPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glTG0ThCLDduxOOOOfFYsw56YxCEixkmSVcCypHOEww=;
 b=UVd1zs5bLtYBz9lxvlOe0qwVefMeInf76XnpvH3MOa7QPe4IUkHVsuTB9oV0cCMxBEA7OKgXzHIHw4dTrsSrTCgxeDz5Q+2yp1w/nwqtd2dP4lwnpjJ0so7MeJwqKlMkl9tiH2HOBqW3WNkQyYQR8MXgVTBqm7MsuEGvBeuKNIuGCZNduaTCUIOTlwlxB+z+fcQyHAqO3ulk1Arn1Eo3aNtj3TcAN8tT7y5Sj6R+A4JzsGKW93GrxZmkIhgWgNHzgL02pv+b9Ps8kK4GPDkMHPB4e4b80D7bgPuT1NujeRJM7N/JJJvNrB4+tjy2Rrb2TvfXlFIMqbHQWcOembfSpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glTG0ThCLDduxOOOOfFYsw56YxCEixkmSVcCypHOEww=;
 b=Lr2l/dVm2us9wtxPHfVrMQavyfiEWrtX2aoYlS95z6s6jsnnTfB167/bBHR7lKYEALTdyHHFZc3XhIvJUzljlM7Yv8u4XhG4ZWygYp7ArZf4GjqPDuivlzWwOW4e+E8ClU4gqujP+PFoHasdgTCzrMtooRADI9NqKJ2Iog45xi87sQ7j13GCzZjZGykcCXm8h2J7kGDYY119fp3kLzifY35PwYUSx5yHepl/Ur7V9pHH1QjzWHBfzN+5h7la1a/ufiL3i+8Cs2FDLEyx/z04ktBMiPvIrkI3tYfvZMqQYtmIb4XQ5F7v+JaA30KDFErNDFMwYOk0R53RsLgxhc9oUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::22)
 by PA2PR04MB10514.eurprd04.prod.outlook.com (2603:10a6:102:41e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 01:38:18 +0000
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc]) by AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc%5]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 01:38:18 +0000
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
Subject: [PATCH v4 1/3] ASoC: dapm: Fix widget lookup with prefixed names across DAPM contexts
Date: Thu,  7 May 2026 10:36:52 +0900
Message-ID: <20260507013654.2945915-2-chancel.liu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5cb19c47-557d-4b69-cc2c-08deabd950ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|52116014|366016|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	rDLdk+qGjTsYHcA7vvlpKvWWV1JolBKHX4GrreOWHY6/aNm/+3Gpj+FZLw+GnBP1VeF4Z6i5VLxbFJe2TAzXHgr5LRJxMnFgaRBr4Of/IA8j3P4DE5+zomsHlRQA41uk9G2cG+K3vKpOtSwW0HGplxT2eADGtYLG3FAnmUJrXwHDnkNrnc0fUbie//fGRctO1EbZCvQGLazlSGBUQusUBHVtdvCBerYEsyxekGvwMabj90aZROiLRK1VpwOGQEslfkOMSgE9fec+j5S9A59bTcRDEjwYGEO8BIyghtna+BBPUGWIpeIPkRtq81BrldvaH9t0sfgZmlpWMZNUBoAERp6VheW+avZ89f9z19FBftC522trZ9GevlRMUqbhM+ntSTryomMqrN/WmPmZEoEtt5ThdNqUqfjAbbnw8hbPY6GAdFKWAVJeVjg01irj8zIzPpV7tOZp8Se0N19lL2bmyECCGEwhKclW+I75eir8bBnSzDY+5gjb5DlmnnvMuGVcPZeXD8cbR+zut0dPGCyLBG6l/8ZIJI4tHsxXvvoJim+Q49czSga2ILvLm3MzVDuodh9kM7kjk2Sd4aTZfOh53djZzBmPKLzy2LROfLfa5fEz5/Z/+HXHFTry+tRKwWMtG31DMpyybq0YRtwSgdfE+HnOGbS0gDzyTajxzWafCb0l/3V9resJHZcrNpZO6on67h+e8fbePKWdSUWeioFdNjZMK7pJIZZhsuxTfTJKpq8mzzZvlh5Vfu2aG/nowLQmHe1F8bNy/PvaDykMj+93gw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8353.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(52116014)(366016)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kSQymjcs9sF63TwyvlQst3xjg30BEuVYwU5H1d1MYThB7+3mesLs0Qq6Bxht?=
 =?us-ascii?Q?fpQAMo3RClv7Q/f8RxRbY+z6SxrU5AuF3V7nMlkSY0lDah8dhRRzJaTMHPh5?=
 =?us-ascii?Q?3PZKQbHMV26RceX4LrFhZEpDtMHfSTS+cXXi/vssJt7Y8ODklmIS8QrrQSZr?=
 =?us-ascii?Q?ZFjpTiT8Ym9mEBFTrUcu7Y0OXyN23wjAR7M7rCUWeji6JUcSF9doSCUnG4qN?=
 =?us-ascii?Q?KMumTu9yQ/TS+4+shbomfYZzFJQZ2eZS72uuPd7/u2KksQSX/dZqGUyipx3E?=
 =?us-ascii?Q?BRrCs8NRtcu/lBA2/4y9vvR/wq3++Ctbe1Jyx8KZrmfnypy58XMeXcc0AR8F?=
 =?us-ascii?Q?cilY4ePqpE5DK1kCGZPjMwoxbuMsSZiVYKZh1znOfvDj/5L/70lpRKjzYYAo?=
 =?us-ascii?Q?DPQ8pewSpHue4ynz5PmPm0UBgLGNOeadWdM8q6GJWrYE1xpb36OcB65Uwtml?=
 =?us-ascii?Q?jJ7q1MmqCWKO0h4Wr39c3c6ZQ6L4WhPI2fjkFQ/ZtqDVlufKP3DAP0AXJiuz?=
 =?us-ascii?Q?zjFQ+CSqOdsN/L61wazn4dN2N7ZrO+UWqvyYT9Gzm2gJxlotfA6B+UF11cy1?=
 =?us-ascii?Q?qAwuQeoIRxYlkLQ+PPiehteUHgouuwXtywCJvNvtD+q56BFu/bNb4Lu+CVjp?=
 =?us-ascii?Q?Ik9ojeJ4qzC7n64T+WNMbt4lcyEDz2bUYIbR/eO/Teo5LBfh5XIt3OujH6go?=
 =?us-ascii?Q?jLEMBL4VHmx8FYlzPfAleSZYWA5J1t3UFDP9hA6kgrvA/hChwtVsPB73ajxv?=
 =?us-ascii?Q?A93uTuUIb8Hot9fY4BkX0/wjqlQmct+AJTFbAuYlsLM7FFMEWZLVTv6dnsmR?=
 =?us-ascii?Q?mSwU1uEzQczMosBAMz7paNaSPiAxTTH/zM51YL2p3u6ejpCMAirABxSv8K7B?=
 =?us-ascii?Q?8JoM4F0jQkuulh9NV7dVZxh4Wk1x25K+oxPGmOlnYOUhe8FyjfQszcZSLyIW?=
 =?us-ascii?Q?o+6wrh7j7cKG/Vcj6sCuA1vN2ad/lIDaAIsY48kBCD1Rb8dadVXV7mP67hoI?=
 =?us-ascii?Q?jNTdqPtasa44sGtkcGaq2iFNXBovPIJLRuyx2u9orIVGx8ipHemuwanLeorW?=
 =?us-ascii?Q?TYtuRLoPahWKE/uGPjnR2w5T+LjV2HhdrFdmnC6kyQaLEA+JL8NE0FrpKt36?=
 =?us-ascii?Q?1rS611q0ZolAxPF/2pq+O8+teTZ1wkVfxcJ1bAMuKk6TLSnPGTlzXj0fH7lu?=
 =?us-ascii?Q?OVM0cJqa7EV+zBnD//wkt1diUZYBBx7jqfw4RZ4Vq0GgKjAecJW6yMlyUIWk?=
 =?us-ascii?Q?sBSoiuZPYzIeUniquGLmQn2JYsJFT4oUuJnQfEp6DPDUxLyehVSz3KdNmn0k?=
 =?us-ascii?Q?WcU3J/g5eE8Y7PXPpafd5aPPiqfD0ZieW4KhctKIkaSZeqSIa87yw8HfJs98?=
 =?us-ascii?Q?gh2TLDponIasMO24A/0pAvz+wABZO2JW1hON0w/lVAd63ey0Kk0f78kbO4Ul?=
 =?us-ascii?Q?mBG1kXbCUz9qr9V2N+biMZ4iED8LzbsEuYc2kQKUmvBVPqj9iESvS/9XEV5G?=
 =?us-ascii?Q?8xEAxZ2kGYAmwlg1/978FIGTo9SY+vcN0G2KAdwBDqqhx5OcUdQ4WQ+OQrhP?=
 =?us-ascii?Q?rNmSz5pGorRBbLS6N+FXl7m7B7+sLkJfm5drjIUxFT5skwkel6udk2GEZEA9?=
 =?us-ascii?Q?0vCk9tIWEj2JRsA8d0EJjoC8lVZBNysZD4CZ74US/3tBf00eETDL6XF7ps8Y?=
 =?us-ascii?Q?c4ChrjHVj/4hX7B3vpQ3MGOH4NhNaTqTS4KdbeKr3Kn1jJE4y4I/sflxQzIH?=
 =?us-ascii?Q?nplBH1HDxw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb19c47-557d-4b69-cc2c-08deabd950ce
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8353.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 01:38:18.6224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wiWnORXBPnbtofDf3ti33I55MvlZzvImLZX260PKqemJJEn1pPL+Jri6tPfz/G5KMeSJfL8jiqxoeMYAOU/iPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10514

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

Improve the matching strategy to support both use cases:
1. When the caller provides a fully qualified name with prefix, perform
   exact string matching. This preserves the ability to use prefixes for
   disambiguation.
2. When the caller provides a bare widget name without prefix, try exact
   matching first, then fall back to prefix-stripped comparison using
   snd_soc_dapm_widget_name_cmp().

To determine whether the pin name includes a prefix, a new helper
function snd_soc_dapm_pin_has_prefix() is introduced. It checks if the
pin name starts with any known component prefix on the card.

This fixes widget lookup failures when searching across different DAPM
contexts while maintaining backward compatibility for explicitly
prefixed lookups.

Fixes: ae4fc532244b ("ASoC: dapm: use component prefix when checking widget names")
Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
Assisted-by: Cody:Claude-4.5-Sonnet
---
 include/sound/soc-dapm.h |  1 +
 sound/soc/soc-dapm.c     | 49 ++++++++++++++++++++++++++++++----------
 2 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 4f8fb7622a13..c1e4f467efda 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -685,6 +685,7 @@ int snd_soc_dapm_sync_unlocked(struct snd_soc_dapm_context *dapm);
 int snd_soc_dapm_force_enable_pin(struct snd_soc_dapm_context *dapm, const char *pin);
 int snd_soc_dapm_force_enable_pin_unlocked(struct snd_soc_dapm_context *dapm, const char *pin);
 int snd_soc_dapm_ignore_suspend(struct snd_soc_dapm_context *dapm, const char *pin);
+bool snd_soc_dapm_pin_has_prefix(struct snd_soc_card *card, const char *pin);
 void snd_soc_dapm_mark_endpoints_dirty(struct snd_soc_card *card);
 
 /* dapm path query */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d6192204e613..a26771c8e6ee 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2906,20 +2906,18 @@ static struct snd_soc_dapm_widget *dapm_find_widget(
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
+	bool pin_has_prefix = snd_soc_dapm_pin_has_prefix(dapm->card, pin);
+	bool match;
 
 	for_each_card_widgets(dapm->card, w) {
-		if (!strcmp(w->name, pin_name)) {
+		match = false;
+
+		if (!strcmp(pin, w->name))
+			match = true;
+		else if (!pin_has_prefix && !snd_soc_dapm_widget_name_cmp(w, pin))
+			match = true;
+
+		if (match) {
 			if (w->dapm == dapm)
 				return w;
 			else
@@ -4872,6 +4870,33 @@ int snd_soc_dapm_ignore_suspend(struct snd_soc_dapm_context *dapm,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_ignore_suspend);
 
+/**
+ * snd_soc_dapm_pin_has_prefix - check if given pin has a known prefix
+ * @card: card to be checked
+ * @pin: pin name
+ *
+ * Returns true if given pin has a known prefix
+ */
+bool snd_soc_dapm_pin_has_prefix(struct snd_soc_card *card, const char *pin)
+{
+	struct snd_soc_component *component;
+	const char *prefix;
+	size_t prefix_len;
+
+	for_each_card_components(card, component) {
+		prefix = component->name_prefix;
+		if (!prefix)
+			continue;
+
+		prefix_len = strlen(prefix);
+		if (!strncmp(pin, prefix, prefix_len) && pin[prefix_len] == ' ')
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_pin_has_prefix);
+
 /**
  * snd_soc_dapm_free - free dapm resources
  * @dapm: DAPM context
-- 
2.50.1



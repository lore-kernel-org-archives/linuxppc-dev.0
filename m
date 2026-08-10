Return-Path: <linuxppc-dev+bounces-25662-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0940DC5AC82
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 09:39:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJV7y4Hxsz3048;
	Mon, 10 Aug 2026 19:39:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786354750;
	cv=pass; b=VLDebCCsa/SeCs1RtRhHd7uuU+mD9e9ZlsclEQIYBBfH+CSY8+t6JDgnhtiIbFzPE0tPYXZmjHFThFI5onlewY9M7xcUzXlJAIypfY6jVeQrZ8wH2AYOkL7FXSSu1MgoeVutthXO7C+8+xUlKDstYoLSsmhIMoDjJqagFBOgTsCLS/RdX1xIU0wQEXTQIoGjPIUL4Mlv+R/Eo/hRkcvXtG1k4NJ++AmyYeAdQeJG+/nXu3h+pwxxhNix6GK7WtXlbAQkky6l+DI1taVq7bsS2MTohYgC7vtklhMN6YTXrTUv0F+u6v5ruwhWcjqpMTCa6WaUe0SOsH1SASL6pLNwqg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786354750; c=relaxed/relaxed;
	bh=bsIKNKSA13eVzZIJuCraYTxCU76NlMZ16UyY9azveMg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NkDA1FOVAlaCjFWsUPSV2GrqH4ZclYtcXr9XAaYH1xWIWTVVPkgqWtt8mxg4NvxLFVCNFEPn51w7MUlXWeO8osdCqbsgKTqhbvhu0F5ltGLEAtTYYRnHmtL+CwYkw70YwmGDF2TjTKlkNPwyZeP56LITRlbGAxhEO0/o3of6C7hdacD3bW9VYBMX463fccZC6hb1zAwSokerUHME/3mHqhql8A0iQ9Yw6yMJPIdS6AbhQtodpWrFnrpxhsjz/ogNUaWfDDrLzyy7JOGETViDbaOb/nwJjsTepAJqli01y88+a7mDE1hwY7QROWtfw38zAvH6LtqVWIXyujWUChAPpw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ByfVXvHt; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ByfVXvHt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJV7x0r4Qz300V
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 19:39:08 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtsLTLPtw2Esqstzu+40w0FAAyigmeVNiVgLaqzzx3+aqmT/nzRwWmS3QvNtmiyXmwmatFx9b0J9YmSogwWroLT87Bti5F0rk0LJz5vNxqNixNav7xCHdeURL7PKqquYJ34ZxMDWWTqxUWd71ZQm7rDAKO211OwRx264e6NmxUiGy+9NIbJ5b0CMvlhHFwFL2Z33/0JptPX/ZDKwtmRI5kSyzyq3KgcCkdQ8QDvHaJt7Oqv70tRY6HOQw4in1kS40nPbnlKxw9p5yKBkoEmDV9Fu8YG7JVK0JA2oGtYKzKwZryxo/VOXaq2HvPUnfZZgGUmwyPexu6+nB8h/vU5sjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsIKNKSA13eVzZIJuCraYTxCU76NlMZ16UyY9azveMg=;
 b=YIzxxob+g1e1ImVQC6qfhbU1JEetg7MYLVn0kiE8S9kcJzd0xQJzZ5qrkFrtCUC8Xg9st/3XFTWZeyHharQRI4Yyiv36ZJOeWobbokf5Dcrf0V7zkDYMM4/719RaGq4E/awvFoIc0ghNURnWcsTRt/YPX54c4V5/vD4Tl+Hc3l8DedOx2+kSl7QizfKgGjpJ8zWPTEcQgyd7Yl7+Mc9S5wWq/EFW/B0diHoHmRmNU7t2f7Uh1eswlZM0BPc7oyp1K40KGVRzkPrM+hnanJcHm4FsZcw0ch22GFHVHTQnx3yyGmeGk0xb7nYs4HY95UKI/iDgmE9QvcGkx2tud9L9Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsIKNKSA13eVzZIJuCraYTxCU76NlMZ16UyY9azveMg=;
 b=ByfVXvHt5bEW/4bUXsDuLynC7YYFP4KN5OSeUn5t0YGN9oRGlTdE9AhfJywhT8BvmEEZwW7FdlBJwrxFV3fpYY6yNvnF3gpap7Iveb3YNe4FdABllsJSsA2Out2DY6+fQBrHtfyUG/9qFx/IydwlvAg/9CqFV3IiSylTlcJBHj6iKP+D/BHvVaWnLAZv6HUtEAE5fIKG2kESFLqyFopmKuxCsG8kJUTFw/ZMIwKPjwZ/TQFW2fEeXXxFFL+wc352h7aGIeq9eKrJwo5i2d3hslgKFrBDsPv9gCoS2jb0n4ma0aMvjqwZo+gnNkwGQ8XPDfAwQgWYpba8niZot1whww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB10021.eurprd04.prod.outlook.com
 (2603:10a6:150:112::20) by DU7PR04MB11162.eurprd04.prod.outlook.com
 (2603:10a6:10:5b3::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 09:38:42 +0000
Received: from GVXPR04MB10021.eurprd04.prod.outlook.com
 ([fe80::d247:853:3e16:1994]) by GVXPR04MB10021.eurprd04.prod.outlook.com
 ([fe80::d247:853:3e16:1994%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 09:38:42 +0000
From: Chancel Liu <chancel.liu@oss.nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: hui.wang@canonical.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ASoC: fsl-asoc-card: Restructure to support deferrable card binding
Date: Mon, 10 Aug 2026 18:35:28 +0900
Message-ID: <20260810093834.1511749-1-chancel.liu@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0094.KORP216.PROD.OUTLOOK.COM (2603:1096:101:3::9)
 To GVXPR04MB10021.eurprd04.prod.outlook.com (2603:10a6:150:112::20)
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
X-MS-TrafficTypeDiagnostic: GVXPR04MB10021:EE_|DU7PR04MB11162:EE_
X-MS-Office365-Filtering-Correlation-Id: 4750c0a2-319e-4b21-091d-08def6c329ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|7416014|1800799024|366016|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	xz3e8AXHhWNR6hDN6Bg5d9ZCEtB12aHD5aiP/UNNCYykHjDGfglJW4aTJCyhzxYQMzcN8rWkJC6gl+Gm3bF/KkHbACN/8KcdNGCwqIAF/Fz5vY8lEI84BqyHXd2ChfWlSZyRziEp1ESRt4JipANuqFV32Bfe7k5KtBMAgzJ2rNUDAcH2XrHK6quYP1OKivoWu+TksFaeRAqkPijGUVMugGrlBqSSDL9NRI4ozvBjJ3FrOcXoD3olsF/0XtkMRysBxNKoMAWFGC3gCQkMozM3RhCiPxqzOBmoisQpedrl1aIh0AfUpbAKIJSTLR0SHkSYvdQ3Bsd2wqXDRjO6GQavxU/Z/vzUlJEW7ICVfHa+UImtBeOtog2RvDsqJB23+dvRB8uDY//SHLx4k6lzhdbEMZjSTS/gchTkRreg86uETbI7M8OqOYSlpR97TA7OJyslvw+2VnE/nNIAk2A5gSLDCYWVSNV1CzbWxxSO1MJK0JX98475JpqxzN+GnWH9R2iJHszx9gligTh/Y2ln1FWyhmZXQxs8UZNplBs/hNhAcNmLp04k3FJtY5M/p/5J2vmzPwgAgsqEq3+nq5u3Z50/0Xk1MlMX61X092IHtouAFuXWDVa7i0XUSXWMbwF2LtCzbwfaz5wD3OjTZyL24gc0fLIH9o0Yx9bgFL9/cyM1kmM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB10021.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8XJ38p67/VCQPPMAFk/wO3GhYiblov5TM5uxOz7cHtDnGlnX2pIU3oBdeEiX?=
 =?us-ascii?Q?aAW4O5gcG8QM7/6+cs9FmI9dl4P7hGT4DV0M18T+auaYeQPU03N/GA+Tyal8?=
 =?us-ascii?Q?pjQDud4ZuzPkxJf2BU0lnNenjEHyIQ/h2PtaBJIcf0yV/pNWU8msktab0QWS?=
 =?us-ascii?Q?tKjsbItXGk6tmf4SB1lTG3T+UFBcufUeD75qwSlQaiK0I3K1GP0U+J3BpeJB?=
 =?us-ascii?Q?tCIuaEVAdNVIcmsdcW4LrJF8q9ISCJimRACGEp84Y5owMtXbK37R7/Q2rFSS?=
 =?us-ascii?Q?hqXop7xbLb9QHwAdibQ/XBUR0lETnKC96HxRVmeMqXvgdTJGApqtbsbDda93?=
 =?us-ascii?Q?CjSVaqGwmqRS6rPTq02woEZGq0yVYTrUky0/HuYgT8vttPAUZZPViuno0Oro?=
 =?us-ascii?Q?FgjciR371JAMMSaZcoD5F4i1I9zOCXbNGYoK23XZF+A/J88N5s4yWdb4k3jM?=
 =?us-ascii?Q?SM9RT0LwHxDYBjT8zTcuKE+YGvta6Cbq8HthOMiIvikhkZdfWnk8rPyea2k/?=
 =?us-ascii?Q?aKRv1bu4a3w5ulhd3qfxMt7vGCFg6m5S3wTzFV8qAGpFGVf86B3ACpZiNf9l?=
 =?us-ascii?Q?HR7m2pqXMIirDWHeOBh5Lp9rpvq998AapGI4mBQ4ikBSFI6Tx+Jd4YH2qhhQ?=
 =?us-ascii?Q?okaHC3WDnuRGnHnGpr0GGJ9770eS49gFQG6nGvJ4kINGTYmVqTlwWwZ4eVL1?=
 =?us-ascii?Q?gEA/B1wgbwDxu1hI2MZItorcEiilD27B58hfdccX8rbSN3B5Tpsv8kwCtWU0?=
 =?us-ascii?Q?wzujvWxhx9bVAMUGO2nsz+z0Pax7vuOkNrNafaxeabdtxGw4PAw38DqwzSXK?=
 =?us-ascii?Q?j4DLjgbl3G+ZHSbg5NpifnZGJaYRvYEPiY5A9/Sit1KELO183pLyg6j+DkP6?=
 =?us-ascii?Q?Y4ZVWA3Kt5amwlk4hSdcD0EAQhKnxm0EFVq1P08Inb3ce2NATLMnjHiKHd1H?=
 =?us-ascii?Q?bSoLkfSvMpQFoY/f+SantjuFNZf2kzrBdrP6+Y+YGRkb8+gAzsNW5xH0oW/p?=
 =?us-ascii?Q?N7nnY1rsTjBCoWCkxzPnjahoP8sMWw2Me/7gSW9Eiiz7xE3S9BOhNh4VU/WW?=
 =?us-ascii?Q?aqE5tHjzZpqKwoQ9+Mxuf/uu/6snd7qusvSSvXqN9SWisg6CWN8ccVbrlLrb?=
 =?us-ascii?Q?jYrFBsQr43RIA+3C/qkpTasqRW3NN54DRFoAfKPeheZu7Ui6ZA9VoD7y53dy?=
 =?us-ascii?Q?DKdtFbq97gaKiU1bABW7vhijKfaJA40ymfY1hFhGj6Bc4AApMIBj+eGala7u?=
 =?us-ascii?Q?Hufxale8y4/ifZLvbDsHi/eexndxkpGiAWv8o7tbKS021Mwy5AUGo8sW8kv7?=
 =?us-ascii?Q?4qo/BcQhuBSYEsDVzCIorRcc9l9Zf7iy+HXKdtCht12ra8a63Glmz4nBf9Lm?=
 =?us-ascii?Q?NSGr+oQ9LvRSvzappOqecpcDpJR8CZiAk/acANxZeim2gB5OlYj33Far/dLE?=
 =?us-ascii?Q?6em1MFyVgivrdtmF7CeWJqSIZfQIHLCr3piJpv36eSIpH1xbsFLRZque4BLT?=
 =?us-ascii?Q?PSkWIlVRU76FD3EHEr+yEd1BGf6wz4ECwvgtDEakRKtOIjE0uk3ol2ynfQn/?=
 =?us-ascii?Q?xui+ZDXIATcOQMo4PjPxpKU316XMD0KRoJe2aDX/x6UjwErgvfr4OElp4V9d?=
 =?us-ascii?Q?Yc+4mLetoX5D9/aXSNDz0HvI0ob5fi41LyN9Zx7NVZPAY/NY39rluSbBc0Sl?=
 =?us-ascii?Q?soa34KPSU1z2+WyUzOPeja1eqUu3Q0bxlVTgDgK7GypTj5g6m3EJd4rMIZnr?=
 =?us-ascii?Q?bNelT+6DyD0VG8wxRu/MpyBx3uzSmUQvHpuj8Cac2iNDNpPBvlmR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4750c0a2-319e-4b21-091d-08def6c329ce
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB10021.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 09:38:42.4072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dj/2DC5t8vy+tBwVfUIQrk1wl0Y7x8tLr/ZlIFw9fHqD7Wloss0kIy85NQS1wM2tYQqUAIv2Xi6/MPier+LmRhMceKvrZofdTOaOyhVRDEBUQB8K/eQw4V0yGo3dws2m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11162

From: Chancel Liu <chancel.liu@nxp.com>

The ASoC core has evolved over several kernel releases to support
deferrable card binding: when a component is not yet available,
devm_snd_soc_register_card() no longer propagates -EPROBE_DEFER back to
the machine driver. Instead the card is placed on an internal deferred
list and rebound automatically once the missing component registers.
As a result, registering a sound card no longer guarantees that all CPU
and codec components have already probed successfully.

This exposed two regressions in fsl-asoc-card:

1. The machine driver caches codec MCLK rate during probe(). On platforms
   where the MCLK is derived from the CPU DAI clock and its final rate is
   applied via assigned-clocks in the CPU DAI node, probing before the CPU
   DAI driver completes leaves fsl-asoc-card with a stale mclk_freq.

2. If a card defers due to a missing component, it queues the card onto
   the unbind_card_list and returns 0. The driver then proceeds to call
   simple_util_init_jack(). At this point, the snd_card pointer is NULL.

Patch 1 drops mclk management for nau8822 from this machine driver.

Patch 2 is a pure refactoring with no functional change. the large if/else
chain of of_device_is_compatible() calls in probe() is
replaced by a platform data table approach.

Patch 3 moves all component-dependent initialisation and jacks out of
probe() and into late_probe(), which is the correct place under the
deferrable binding model.

Chancel Liu (3):
  ASoC: fsl-asoc-card: Drop mclk management for nau8822
  ASoC: fsl-asoc-card: Move static compatible data to platform data
  ASoC: fsl-asoc-card: Move bound-component setup to late_probe

 sound/soc/fsl/fsl-asoc-card.c | 728 ++++++++++++++++++++++------------
 1 file changed, 465 insertions(+), 263 deletions(-)

--
2.50.1



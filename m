Return-Path: <linuxppc-dev+bounces-25663-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50998C5AD4E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 09:39:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJV7z4snYz30F9;
	Mon, 10 Aug 2026 19:39:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786354751;
	cv=pass; b=FigL4IgroL6h5pxosyszSnweyEGvWx6L/JVLBTLNmvFHWbCswbW0NtOR0I2N7sz8eBQFxKzzUXqOcYW5P+smENrKHKpAC//NhoBk1i4qWLbPX7O8dPSMGlKC5wZ8FIs3hAGvfUOM9KShFr5Fo1FMPA3u8JGfvHrM1taNnfS/wDhMdLj09o5nUXWG6A2uC0asvfoB/2xaxu//t3Y8z9YrUmJTpXHi+3N2+EVX+5OQGTumD1tHSXcdxX6PEcvTydaBUru6ziJ3O62F2dDtTzE+q4spEGDoJE4ZWz23/bf0GD5KKwPg96YbG0WDUobsjOguXP84fYfpaTtyh4RWNA/iyQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786354751; c=relaxed/relaxed;
	bh=doc/0BLfF6vJdaNQ41N5hl1TQqnDlBRU286ct6hr7Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cfH6zieVM09zLT1BvIw/RO9O8X9bc/W5BqBuMN9xjOlefRMD4pZiUsfGMfJKnevehSMzBsCqNbX7eg9ocul4SkxCM5BJwTZl67zter1g03yUYbZcQAC5TAocsU9/a/s9kNjE0QsZXVkihcg1CntDucvjwd9b55wVM/kXz3dkMPX9UHcPAeM49RurGctglapIzSkPvID3llXzqcN+/shFq+TD0GdxhWRMzTrCDqk5J+Kd+3lDSwIcO8LOLeeMQoHry5dZKkEFsqsABQnvZ4FGK5FVsMLyquM74BkYrXcuEQbRTyix7krXtqLPFZ52yCB6nKtj/E1hNQ/bRmPa5oWRGw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=oFALUMhi; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=oFALUMhi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJV7y65JVz30Bt
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 19:39:10 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mN+r42bHU4fjXMtheMAdgnKTVNhJ1BrrDKT8czJwYl+iqi7fQaa1P7AEFQSe5llbfo/w7b09et7fU3OeadeE/yWPhuu3HsCr9VapSzJNoCLsZRLxcFY0Eqbw38w4rkWRMWjpvO0stbptzTabIQWjmxjrAHeRKmg5LGvPLVRIA5xOAB56Y6EmvcfAw6P0oi9vjUOtE7gj8pAY2XFH5uxCoTsoMyPzOkeVG6lNGhr6GWgwKfSfFvV6ovckAkSvZBL1sMjr2GoU9x4W2+jjdOgafGyEsGpaksqHscWxsfONU0QbxJomV984x3hj+VXD+YrZWyJoXa6c1KC8NYZPq3W8DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doc/0BLfF6vJdaNQ41N5hl1TQqnDlBRU286ct6hr7Po=;
 b=mOJGfOI6wCh2uDBSpkICPHX5nZKtBJxGJvxqfPJvyAWpe40kzD/uU3hRqKvsh2QoR5Xh9s3CsBMQcsi0YyoYsQ9gw8JjxErhQi+U9msuRu7lciU8hr7cOJmMpDZA9r7oZlZIutxvrboEpabL4t7t5VjtBgI06OouQhQz5R9nqXt6Wm970Tq0ue9LpNwGfr5urKRn0EizHi3IH3sgB552Sk1ibFITvdgV3svNV3ZdD3kf8EtV5SBTAAOfbKyQClM1ITk/78XfAZoxNJ/lYA1L23aHsHTMHiLUnwONRtKpXLFyG6dTUHZqgyEqwYleaBKKdsHyZUqoJ7jN7zOxMoMk2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doc/0BLfF6vJdaNQ41N5hl1TQqnDlBRU286ct6hr7Po=;
 b=oFALUMhi9diS4gMyuE7V4Br3f/zpdPEQFyktZH81S8D3YLEayvLYhMuHEajD2ezpIQzJeF+f+s2iJ7O9gqY4EY5Oudwd7gux47G9u2ZCMktSMkBsLqG/wxVXAk+YMvC3naW5nM5ECpFR9msNGZtt88RdHXRCiNRuMcyILy85sUua9hfdngkT5UY/GU/TmE+RFMKglvid17KZts6tyePrT9I3CccsQgSoKDgW86fmxmmT/uAUr9XaTfqVn0s8zImzb6w01V+b/txDSgKIghaZ7U9AwbfXzkfuiIzd8elKIV3U4nW0qymqeZccZFQD0A/JV+PFIDK7nfmHOm6Z5gmZOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB10021.eurprd04.prod.outlook.com
 (2603:10a6:150:112::20) by DU7PR04MB11162.eurprd04.prod.outlook.com
 (2603:10a6:10:5b3::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 09:38:49 +0000
Received: from GVXPR04MB10021.eurprd04.prod.outlook.com
 ([fe80::d247:853:3e16:1994]) by GVXPR04MB10021.eurprd04.prod.outlook.com
 ([fe80::d247:853:3e16:1994%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 09:38:49 +0000
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
Subject: [PATCH 1/3] ASoC: fsl-asoc-card: Drop mclk management for nau8822
Date: Mon, 10 Aug 2026 18:35:29 +0900
Message-ID: <20260810093834.1511749-2-chancel.liu@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260810093834.1511749-1-chancel.liu@oss.nxp.com>
References: <20260810093834.1511749-1-chancel.liu@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0103.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::18) To GVXPR04MB10021.eurprd04.prod.outlook.com
 (2603:10a6:150:112::20)
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
X-MS-Office365-Filtering-Correlation-Id: e08cbe4d-e526-4505-23dc-08def6c32e6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|7416014|1800799024|366016|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	YXxyBwsTMlYPP5G1nM+fDGuTzU+olPxnyLZ4H3bdciOC+JmyW0Z5wjMSla7n8EwHcDa+7iV/0PtHyOh4RVUd6l2MMFy40XNaGvg0wIVLW+ok+4sI2lXm2Sfv45WiTRZin4oTTpqZCFYAzS7fW+I13lmmJ6pS1kBArQ++/RI/m+lRrITD0Xlr9oyQSach++3BuCtNz3UYy7mtCyWKftARdYsiaT8DiJXxoCC9nw+UerWw5/eTheFCnbyOZhbEvlThIthiiTg8tAZFZ6Nm+TGZgR0UnpJ9rpH9PtppUwB5/S1Q55s6zN0Wy0ft8GQqqKgPuJUjRoyRS6HMQHuWjk2LffnEU3HC6jSSffwUicSSlY68A6jYllKsn7af6HkpKVvDRe3JKYL7alK2rhJoWPdkJjqKjVeV3H1AoGWFjIaLejLVJ6pHqost6J2sn5Bu1MbxL9D6NZCl4IFaHeuEgIFmBGW7bDGY1lH/55x/MFWHPAN5yeUdTb/o7RG4zvLD1EKhE0JBnKeUTdzf++Jc41cnA8MkettzsJBj0Hri+hWx/9jCWL4I6nV5lVYwLdQyNVDU33hpxSuHNPkFbV9tqOmwLP/tdrNXZSgZSpHFkC1zy2gj+Hxmhq7IStpiQri/+XKcQknXG01s44TxsBsvM3NJDiIJ8JW8u5Kav7lsAVoHgp0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB10021.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rAUa1UZCQEql1ZcJDm0ZUZHDqgfq7WFQTfvFkH9FmWcuqKGQtzPFDahedjof?=
 =?us-ascii?Q?xypz51BjdRpUEkgdiQiutdppDWqRAzJwErpi/tPQkp8daduqDDjQ5pup/lEJ?=
 =?us-ascii?Q?M4DxsZr2Ur8/YtGOhd4NwVpbBgRCArDNptIoBBcpFQTaNvfiDdtYl0ElH1ez?=
 =?us-ascii?Q?24xmLSuxhqzPgl41B6Oy4FeJyXw4GMcM5yqVutX/Zy6ujG3Qnqj9ncg4epOY?=
 =?us-ascii?Q?1enbefUzRxfX8WZZWTWFEam+hcPnGGwgiwkbUsd6q7ujhEsztWqjzLu+EpD6?=
 =?us-ascii?Q?1+Wl0JX43gNDUw1JQYtGTkx0iY3j3jjP5Eup8SNonQNCZOEALr5HlHOWOEM1?=
 =?us-ascii?Q?2j6Sx3mgCnFhLVx7zCvshMwTfxNl7QgRuHdtGpQMbhx8BGmxiwSpmyIfe+vd?=
 =?us-ascii?Q?EcmdrcmGj2MRWAKF4A03Kax6z3eDT+HJrpuzne+baricxWEKTHZvXFYlVR+G?=
 =?us-ascii?Q?+Q1Wfzr3EMPW6qLrP6aodUydgUoa3swzGqi/fUJxPFupWZlI8Bl5Tp8FmQ6I?=
 =?us-ascii?Q?I+g3AAcp4/jqpiIO8yUTIh9HewpP/EtULZEJK3lzv9gLWw7trq0zEAunTXq1?=
 =?us-ascii?Q?QzRPAPM0alMJQi1za3U72Qdwh0ClHF6JuR5R1FA19jlkJ+HyDr4qHwkpxAS6?=
 =?us-ascii?Q?aWKAatbDfd/NIQH5e3dyfCc6/GzeWgTHgfl3VncE+LcG49VUA8Dz/JJk//1M?=
 =?us-ascii?Q?juLfQXU+AmA9D8iKpTLlQ63y7QW27bG0u4808ujkdYFkfzbnTmMmPZ+VzUN/?=
 =?us-ascii?Q?E+KP8/iM0ibYee1oIvgd72Eq5ZgHA/W0S8WMAUQxDY5fLBaLXBmMPGf2W+kb?=
 =?us-ascii?Q?VhSyf/FCSJEiGq+cLimWt5p7IUMO/rYvDXZxB0UPOHGNBsTIZcTZVsSM81G0?=
 =?us-ascii?Q?9qDr3gCQk/zIZcqwkcsvBhDOMb7BDDeY0Os2ONUCK+vKorvlJOREhU5Nc2U/?=
 =?us-ascii?Q?yeNMMKEZncMRLvMsRQZCYpZkemkpDNWfXg8UADCsIowbrR6asezJ0oE51xwR?=
 =?us-ascii?Q?zy6jauYZObvKggHjicH+xceXshjmAtOr9aiN53z0xmPBbenCNfahj8Q18FMB?=
 =?us-ascii?Q?5ztN0DUWVqe0D+A0x+MkjrhdtrBaZYH1ktOF7Rk1UYDowC5tl7ooWLuwLuse?=
 =?us-ascii?Q?lVv0H/dxdp+ZnJu1p4IfM8JxUOQTElDvG2gTLecstFR8q36mfyn6jes5dAlL?=
 =?us-ascii?Q?9Xyt/+BsSMjpxq9VubhIj6SZhjKSQ8hvhyqYIiu+wOi7seZ0yQX8nWBvhXE4?=
 =?us-ascii?Q?uoiRnFivjp9Hdkmxge2V1J/zGHougD1FqHIIRsK9je0EOpej+ZQb9ChFyy7E?=
 =?us-ascii?Q?4PjwxBGfa62ctTkE3NQOAWHE6mq95C2YMoRI2XKX8+RD/L0Ke4w0nZZmYuJY?=
 =?us-ascii?Q?LbZb4a78J8ayOf6mJ/HsRRbbUrjiUxm0WgY/VhoGKAk3PeZvMshak3dMTFQo?=
 =?us-ascii?Q?VERuYbkGp84/m+hRD8weYuFIvfMg6XxsGSqB9XY0c7N8c1DWUoXHjkGNmaJE?=
 =?us-ascii?Q?0fWiCaRh+s2OeoNpU0CJTUHuGPRQBOMkcTeRWW0e99yFLjNXpPjx7lCB8p2F?=
 =?us-ascii?Q?zVokDSQueE2g6UQmKe2mwdyLdE5nqoWnIED8zWjHTWWZSbgRoFHjO2yGivLv?=
 =?us-ascii?Q?nWcdWtWr2aUYHSM48xrc0052H4xpcuWFPNOQZYo5riWCw5QVjUzWJH81mPqA?=
 =?us-ascii?Q?CacuI9xWZ/4B6a3pw2ea3MeH0P6YNV7px/e3qYJgdDVoJSeu3rpQi1np/YS2?=
 =?us-ascii?Q?ABE3cpWk0PNt3r+Z4qWYoNPCdn3DHVHoof8qNgCfCYyty6HPfQPx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08cbe4d-e526-4505-23dc-08def6c32e6f
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB10021.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 09:38:49.4662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4g7dTzAaFTd3fcZd9ilngg6AkUwRwPp2jjUDiHUbNF6583VtR/Rwb5oqbh7gp+pp+910aabnE3YgaDLWGQQLqVwmss3oZV0153YXZJ1mQ36Q5zRfJ2z1hnkBtyQ7SiRk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11162

From: Chancel Liu <chancel.liu@nxp.com>

commit 93f12a7568269 ("ASoC: nau8822: add MCLK support") added MCLK
handling directly in the nau8822 codec driver. The machine driver no
longer needs to acquire and enable the codec MCLK on its behalf.

Remove MCLK management in this machine driver that was introduced by
commit 1075df4bdeb32 ("ASoC: fsl-asoc-card: add nau8822 support"). This
avoids a potential double-enable and removes clock resource management
from the machine driver where it does not belong.

Additionally, the sound card may be unbound and rebound multiple times
during its lifetime. Managing a codec clock resource in the machine
driver would require careful cleanup in the card remove path to avoid
reference count leaks. Leaving clock management to the codec driver,
which has the same lifetime as the codec device, is the correct
ownership model.

The nau8822 compatible entry, DAI name, and PLL/FLL clock ID
configuration are kept unchanged.

Assisted-by: VeroCoder:claude-sonnet-4-6
Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 709543308fe9..4c245aaf2847 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -69,7 +69,6 @@ static const struct snd_pcm_hw_constraint_list cs42888_channel_constraints = {
 
 /**
  * struct codec_priv - CODEC private data
- * @mclk: Main clock of the CODEC
  * @mclk_freq: Clock rate of MCLK
  * @free_freq: Clock rate of MCLK for hw_free()
  * @mclk_id: MCLK (or main clock) id for set_sysclk()
@@ -80,7 +79,6 @@ static const struct snd_pcm_hw_constraint_list cs42888_channel_constraints = {
  *                 to stay within PLL frequency limits
  */
 struct codec_priv {
-	struct clk *mclk;
 	unsigned long mclk_freq;
 	unsigned long free_freq;
 	u32 mclk_id;
@@ -680,9 +678,6 @@ static int fsl_asoc_card_late_probe(struct snd_soc_card *card)
 			dev_err(dev, "failed to set sysclk in %s\n", __func__);
 			return ret;
 		}
-
-		if (!IS_ERR_OR_NULL(codec_priv->mclk))
-			clk_prepare_enable(codec_priv->mclk);
 	}
 
 	return 0;
@@ -933,8 +928,6 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		priv->codec_priv[0].fll_id = NAU8822_CLK_PLL;
 		priv->codec_priv[0].pll_id = NAU8822_CLK_PLL;
 		priv->dai_fmt |= SND_SOC_DAIFMT_CBP_CFP;
-		if (codec_dev[0])
-			priv->codec_priv[0].mclk = devm_clk_get(codec_dev[0], NULL);
 	} else if (of_device_is_compatible(np, "fsl,imx-audio-wm8904")) {
 		codec_dai_name[0] = "wm8904-hifi";
 		priv->codec_priv[0].mclk_id = WM8904_FLL_MCLK;
-- 
2.50.1



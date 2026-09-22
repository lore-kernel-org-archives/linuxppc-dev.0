Return-Path: <linuxppc-dev+bounces-27883-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD364C982FE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 03:30:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hplwM4fMCz30Pn;
	Tue, 22 Sep 2026 13:30:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790047811;
	cv=pass; b=Lh0fXT1SLIZmbp2YlxIWizkkPE2FZjeE639sxLXGpH+Sh+m/N/uCsuUBHSecyEk680beifebxSKc8Cuc7ane6Y6QeABBQcIBzub1nuiLE6nDEjhWt3UUCF7o4BoA+onOjQFrfuaD+rmg0M1A6gjTSHdtq/ABBsDZgSkrD1nRfHSc70IxFymaN/GhvwaOVuU3I3Yl3NZwtVzQtePDDQqCOSbLwf/prNbBhhZAfwKa8kbvqbneWP2w37eC3xTFMPuQ8Fpg3cUoYZujA6KM2s7OpCFSyuwS9YaDE4Uf+lBEbOBzuchJ5spzRCIuN0ZrLyxx9Npn8GOZyvG05iYY62N5SA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790047811; c=relaxed/relaxed;
	bh=Ry+w/778D294TYkxlaRlm7LMKClJ/rRgUHmdIC59y5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ECVp6Chlr++F90jfEYdWqg/GjA+Hf4fWnRh7eKQNSDe1U/qdEWe4lgwulUVxtBvJUGbFAspmEArI2V5PekoNIEvFeN3ZgzP5IJuAL0/GgZ9XSDxGwbg62MJU48fkuM/TVulBTqMeVFxI7q8N0TW7G/cyUE7kjc1Lh/Zygxoi032wcNi3Q1rCyDPgWa2hDh8kgzKW23wSo8UudC8EpvrA2aiTrkMr6qXsukFWZBjrZ93L10NA8cQSAYcwJoryW+E2/MkIfG2uHCVFjIYy7Xf7JbucSlB5sR5j1a853Od1yayofirCk/tuf/ibnd3ayU7hVHk5vjf6VOUSNxS0Vzd/nA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=frR/PIoD; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=frR/PIoD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hplwL2S9Yz30V2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 13:30:10 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFPCVSFlH971jkN3RP5MwMVQ/I/QOCtc1QPI68CS46PCAPWLMw0CJzemxu/3OTm4egN9nWdClGqnmiXpPf2bSaRFi2gGwovMlG4jnxbPBLFLfEZndhRZAcTVkH5lJpqkqrPv7zzxAxVo6MwjkLTaOL8Wq45zPe8rv+weBrmeDf0VjwLS7iwOiZ44TKszEWf+xihGs9CFD8lNcBWW6Pc49DHQzNkoIS7ssvIFbEtVpqaS+D1xRo4wltC8jGqQF/B5FX4ceOYLL4siczT9ZI5PBj3FaNRWa3dQbbYn/rn1coi6UNd5cqbHJpDjqWV5oNBzjal7nepTzpHrzHC2BNVxBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ry+w/778D294TYkxlaRlm7LMKClJ/rRgUHmdIC59y5s=;
 b=GFG/GC4mhCplOF2yP8TFmPMCbVw6DBuXI3tYAPDBFiz3DICGQb7eOSQTw6bVhTFGzapEB0x64cQLApatfloJrHMcmsYTVH98j67Vd3Wv5K+hMQCIHU+U235oM4a9x8mnFSGGbXlRCRJHusrXdqbnj9y7/i3J+eYYPfXl0kAZOdF8LowhdVgWh7zZSqoyD71s8JX1I5XebC1oIoEXUtzw9uj/oYgnTQEhqhTkUH9v6vZXReABx2fNd3hwWPF52xTHrRzXivM5TraXY/UdLcmtUz4JwaHOn1T8JDp/4SwxBtasuL3X4PqU+aslZqk+JOvWxn26fh0wXmJaQBYAmT/6mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ry+w/778D294TYkxlaRlm7LMKClJ/rRgUHmdIC59y5s=;
 b=frR/PIoDkbbjrf/P+KnLyRrwX7eaJiQZXnnxzvSSHBaEYeADfNqZMR8sZ7e279+IMfri6rL7sYTv5RGH21iArRsPeoAL40KezEW/YpbU2U8mZRbPvAKky07BmEfQbnQW6mljjo0hV04fjtjn8YkgJJ8yz23zysxSbmiI271M0OK5Ms3Yk/nNUN+MjtSvwcyt43IjKIekJeMN/8DrGOkDk4jUM6LicHMiuEZcOSI6joLhbOtauu5pAPnkUwl5tcVBKY9H6+e5zAryzEqsbU9OuJiwPQ15jh6Kf1vHZF4iG0N16kKqchCHXltu5tTLal0JCaYbhJa0ollSRwJn+m04dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by GV1PR04MB10941.eurprd04.prod.outlook.com (2603:10a6:150:201::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 03:30:07 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0428.011; Tue, 22 Sep 2026
 03:30:07 +0000
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
Subject: [RESEND PATCH v5 3/5] ASoC: fsl_asrc/fsl_easrc: move DMA params into pair/context struct
Date: Tue, 22 Sep 2026 11:34:26 +0800
Message-Id: <20260922033428.1690822-4-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922033428.1690822-1-shengjiu.wang@oss.nxp.com>
References: <20260922033428.1690822-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::8) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|GV1PR04MB10941:EE_
X-MS-Office365-Filtering-Correlation-Id: 05721b3d-c7fd-4e76-ceee-08df1859cc7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|23010399003|921020|3023799007|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YnG6+GZKLN0/ko0Zt71aiKqPTACVl4Uq8D6llFRfKr8i5Z4oda9gAG+5LwPykhL2as1caOx4HCPg4QwZHNDeGJefvO3tb58Q+n/X6MG4YMmDCZOTIEofZ9aOIvzgR5l8I3VzHZ+eaYXtZN6Qt1JJj28CDuiXF44/0fMfCeRBWTeVyhlu2ECiOw48LnBNbhdylinwZZFI19uwEgX/oW7KPRJaK19WNXAmkI/Rpx7tnsnYgAeWwiCDZCksFQ0hH3GrU21dqQY4lSqXoTE68KA0mtTG8fztzi1+r5DPKkAv2bCsWUWgqBt1xS0Oq2FWusoI+ExHWADjDedwgMKUFFGWFrTo2J8TrOsW5zFa/yHzdqc0vo4jxT+p0MamEY12/KBhTljuFFhg6pUzKcoz716uYmQBg4Bw8eziHwC3+t9FIkJV4OQuPSakTL4rjShtD8mU6EexAWzdAUzgcDuEElFWLl4Z7Exbebbf9NUj8L+IhKjZEl8RYjJDPDa3Ahlc0SHspMpjvcvHhS0GAqju8iez3yAcElpuK6oyRNc39mbpVrVukwDN2iEEhK9MzzC85jjpK6OEiXj5rWARAnlo46zRtrmq0mgDf9aD+ISciY2fyQ9syhUi6V1dJBo8eSmW9W6nywg0v/3LGJ3JocwXxcsdMXR2BYyuQanQVhce1RI3wrrtESVHo39oVcHZ52nZ4rx6Ga3ZQxPkLcync2IJ6ttivg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(23010399003)(921020)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vTAwSVUQA2e6W5MmIKxMDfIS5L6zzoqZIMraw8fkIVuZ8BsDgW/yaNFgAXbC?=
 =?us-ascii?Q?ebgGb1QMvMEcZc4rK84sdgJzjG1nEvDOYKrwTVKoQjYLGRCe1shtEQTcbkYX?=
 =?us-ascii?Q?+hkq/VI64Tg9cEsLLRSlKLrVYz8xnrnzJN2m8cqk0sRuV51+3pZGL9lqT8Ql?=
 =?us-ascii?Q?yCgjT3P4sTjpSru3CoPs710nv7rUBWFFryIGY3W6Fo8mpRkQz3NOQPzxsNk3?=
 =?us-ascii?Q?zKL/0xW2YKHmI2yKybxl3auunUl3oLsw8fw5KXGFaFyxCdxWv5w3xml+rS3C?=
 =?us-ascii?Q?oOluPCYIr1vR4jmSXXkvzdqcdeA+wSKBCkh5aTMn5YTYtv4BgSL0KYHeMuhX?=
 =?us-ascii?Q?ErcT1ElhGfJRsVOsy44inPiOnd4l0pjeBqVYWzzocSFc+6Tmhi0YrcnEgyYX?=
 =?us-ascii?Q?uMiV9h0aFhqwBngnPrMzJuzkCCYgsup3Ei6zAFxmF9s4yjfAXp5YmbcwIZaA?=
 =?us-ascii?Q?W7sOcy13Bk9cLbPj0CEWYDXQPTKxLib0li2N1Aqi4qoenxy1duk22K1m//7z?=
 =?us-ascii?Q?PgqXTz3FQBIxH2lkB8ozeals76HUMVfHDU9VzTkJQ08m8rsg7g+D0VWUIzE6?=
 =?us-ascii?Q?NJReK0flVM8r+X1P+EhM7CxcnLAF0oV+5WghhUFQemmLjnCyCX11+I7T41PK?=
 =?us-ascii?Q?Sl8XHicUQcviX0vWVxyq59GK2ncGiPTDQJHTf3czf2l94eCpaYw2HsTjuAxN?=
 =?us-ascii?Q?n9RNX8ZxKlj/OhxTJZCI3my7X8j2eNhh/vOo5HgW8iNZNF6Hys7t3j2c7WKX?=
 =?us-ascii?Q?MAIrzqTZiPBWjiUL3ZYIRZsJJDmBVyCYfOlPU+NNJwz1K53Gtw6hSC6CrAWJ?=
 =?us-ascii?Q?T8NL2oM4Sm+kt8cj78fJcr+wwzD8Q28I1Gok2JOgyBduPwcyW4miPDeIH+y6?=
 =?us-ascii?Q?/RB/+2IVw9lXAi10rpTl9zhndbFJe0nWj/6kN3ye+biJlPT5OuaOQRoJfu6E?=
 =?us-ascii?Q?55Sqm7BEimdbKagqRZfBlUaP/Z8ON//Eza5CIdl2UCdp21YGeIknD05tVLo+?=
 =?us-ascii?Q?VhUH84VD+HRGFOx+4WKmWBuKIzNtwpOiUh+VL9jSh8xGlNlCItlPm5Q+Qoad?=
 =?us-ascii?Q?HG22sJ+b+ghiFjWYhHpwaaTJAWxxe6Fvau3lhD1ImYT0E4HLPGFHcShwsWka?=
 =?us-ascii?Q?8Z9IWRhRzAycT3exanQoB5KT0qPkedvE9PY/XlYL/ptfevNkuhZ7mHPiQIRn?=
 =?us-ascii?Q?4kcZ5UPGEt/a2OP3+IiptZBYexJA+AvLEtTRwqFgngAeqUymRv1f09opDEG8?=
 =?us-ascii?Q?IxVTTrVgaXOBsSX+oK8vrw58aeGQdtAPfjfIsOp3AyNgCygVKR0xGudoNSaT?=
 =?us-ascii?Q?jaqm8CNEWaqXDrKLuq1gNW1rw+sohJzdX0bvbyPtAX1zjQVTLfPXu7xpD7jF?=
 =?us-ascii?Q?x7dsolOy62X5wQQnXjmiJxjm6WazUt7DP50VjgknTupf/sJVUcEYG4a9J3v6?=
 =?us-ascii?Q?2Fl+t+CVTC9MOPNlIt/Rc07P7t00Ky5cAuHDr/vaCKpL8/jCKBvWtoyezfYD?=
 =?us-ascii?Q?P/wL5r9BszNtAyWfhFaBZK6372vIsaJVxi/xwVu9cmk5FRoqg14QZWX/+tyI?=
 =?us-ascii?Q?aaBUM1ICase3RWWmrfqAxawHrQXN39TvQAvhCghcnpYXjIc7wUPhdJz1Pd/z?=
 =?us-ascii?Q?eqawM+vVVjRIubZ4YoAmBTnMmfNzk/z9/fCZhHL7x54jMpdk0xFjGK2V32Lz?=
 =?us-ascii?Q?IXY4IEWRLm5Y2w4lSSvPkgKaZ8AU5qNnqQWsQaEgEngHm7ufDksQgdSwQCxX?=
 =?us-ascii?Q?MLNKl9s9dKioVy5N9W5GSyZFXYP/10M+VgUFi+l4zdXE4iEwoeim?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05721b3d-c7fd-4e76-ceee-08df1859cc7e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 03:30:07.3037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfcXyN2lXjFUSQLgl+9cnMNpMtoh7WFFRx3sWHXkYDy2smwNTV1cZbUPveQnqRzvSO3w2ZH9BSeL2k+sVG/c603sLbqJO/7p8IfF0XZBYHz3oAkxxUK51gPetIDtPQae
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10941

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
---
 sound/soc/fsl/fsl_asrc.c        | 11 -----------
 sound/soc/fsl/fsl_asrc_common.h |  7 +++----
 sound/soc/fsl/fsl_asrc_dma.c    | 14 ++++++++++++++
 sound/soc/fsl/fsl_easrc.c       | 11 -----------
 4 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index d80afe1bf4be..6007786aca66 100644
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
index 2f662bdf14d0..15f2dccc3584 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -392,6 +392,20 @@ static int fsl_asrc_dma_startup(struct snd_soc_component *component,
 
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
index aced16d1228a..a6ac94055b17 100644
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



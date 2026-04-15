Return-Path: <linuxppc-dev+bounces-19751-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C926FA0C2D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 06:07:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwVyy0r45z2yvb;
	Wed, 15 Apr 2026 16:06:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776233210;
	cv=pass; b=GO+egrrLbT9DehVt6Lh4G4/MKnYNO7my3I3udEKMMCJaCFqHuO8YjdAXqbzEP+8qf/2oVlBjEwMAt4SynRgmPtGfjdVXRTieUvrJittP4pl25iNOneXCtWb0T21BQolcHo7cp0wNJBvJq9uoTmdMr9gEQd7P4UOOL7IlhPC6UWQTbwTJ1G5m7Wd8CiR4E8Yho0zVF93y3u4l39mJloodFzlqw2QoXu9EGSEh8ibaWDaEHTS1a/GdoGHYnBbzv7FlOaSM2aTwa4RyS2TUlshdsE39cmQf+KyXRcCpAW0NHo0wZTBykE5aVKD7mS4nfUT/af8gV0EqZx4FwmRszM9Yyg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776233210; c=relaxed/relaxed;
	bh=XN1eWleX3WsJNDBk2xaHqHNzbZjf6E1gbEqnSncSPFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vx7R+Ako2Pb6uFUET+uYlOCd9sCxZUCknIcImAU4PujvW/nYjMp80jx0NfqByLg75HaPR38uHMzlExa+dk9aLdjA8kBSqNQhZxa9UzS1W49ueevT1cVnIPzPbRRJhF2HXzg2w07ptBvAVVr4DWAKNePDo26Ka8B4/+QmLZUFqbY4iNn94LDSlHTrz0LB5g1J7YsYl9lW7wRZARNb4oIjyduJiVX8kcX7RTjRPJSlp7FuG6PrKkw9ntem7RNz6L/UsqqhciCPKr9dHyvBK++bMmAbiuriZqDQTE46SuT92BWu5gj7cHgOFhIHObwSpCkA1eqZg/xkARmLwNbWAzL7xw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=iCHbjb2O; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=iCHbjb2O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwVyw5x5yz3069
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 16:06:48 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYpua6QuO1HnmsclkN3Hy2gduVmNUCBg2cyaJet4uQcxhqZZ+vm3fkPqWEvTGhGowdEID0u0aOUS93hnD+7GxDxf3PllDIpOQydArKU/lvTXPIEu1pjsA9e+9CEoHvhYOG7LwBCNqaD6fSMs3c0zYXiBhrmGeGKnUMiP++4M8qZKG44ituvRhJFQfGgY7Q1ZMZKn+HUs1cFWiPUNK8TObPZZHpx9F7T7kHkt3TLakz2RYp+54+zkLjHmScmXCOnoslUx/zx8s2uhJ3TWkoFy6FwMmFOYTZSAk3gzckFuoNyUSE2kUX0+GULL1CSerND9Q/2A/+LljQLqHTabEIwV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XN1eWleX3WsJNDBk2xaHqHNzbZjf6E1gbEqnSncSPFY=;
 b=utbWQiauI0GxbsfI+N1Pql9Ggc7Sw/Qiojnp5O6jHv6CBvYZW93EAKv/PtbuhB1s77C0f+VA/u7lWnHeLU+7bcX+7gpQ2BJaKrYxhCBlYM6ZmQSArKBW33dKK5RVvFA7vlUPiiRo1EkzTm4P94ZEKTZ3HlY9dIcOBnNbW19OhmbnTky/gqIWIPAR+3wCSE0IUZOu4vPImKyqHMspp7JG1QjkIxlUUXtgEOfbHlPpo86XsQohawh7y+cmDMbPVx5CsHx4EekCg7S1T1yQ+CB9sCBufWDsSwro0NVqJm0KQSts2XU7wt3yAl/Yp1aEfYGNfLd9ILQXNHrE161UUDAQUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XN1eWleX3WsJNDBk2xaHqHNzbZjf6E1gbEqnSncSPFY=;
 b=iCHbjb2OwTfvVS/8EroqL5/fu7WwrcgqXG3V2H3Xuu8hcciMESLlAAQSsxPsQSEIp1mIrIrrsgXZKGixRNuuhCQDYkOjD8k3gZ4/zQnn0k7HKOQo9R1dCE8c5ku7mL4ugAMKav8b+zcEsDwJPK96XTabBEtcDY3Nb8ciDRiKoNfdPisUd4UOL+HTcNeOQ4K/o2lWGxvUZoGSS9c+QiVZVTYrTa2FbfmUcgKwNj3CJ9ompkvd6lOQDuDDVijs+Y1knamImxTHI/8GiuNqE05EOjtxzvjxKOQR9hrJOyjNQF1nU6BRoggF3JWaJIEy4OaTLtVzFz1lNOeECGdIUC3ZIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by PA4PR04MB8062.eurprd04.prod.outlook.com (2603:10a6:102:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 06:06:24 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 06:06:24 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 net 2/2] net: enetc: fix NTMP DMA use-after-free issue
Date: Wed, 15 Apr 2026 14:08:33 +0800
Message-Id: <20260415060833.2303846-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415060833.2303846-1-wei.fang@nxp.com>
References: <20260415060833.2303846-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To AM8PR04MB7284.eurprd04.prod.outlook.com
 (2603:10a6:20b:1dc::8)
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7284:EE_|PA4PR04MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3425bb-556f-4954-721a-08de9ab51f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|19092799006|1800799024|366016|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	VqeNxuyctLGeL47f8nNXDaEknt9fVZlmIfhfibdUETh2uhU/CC4JIe0epsHz2DLxBlaRTsaIos2PTFKmtnSUX3KT+YByXw3isKyRtTiG+JR2iAk2NsvsMEa4vWZtqGgi8JvA5vvyvFGE9vQSbfKg6x4bA+sEzkRR88ZAncrCqBpd8/1uBNPfjokUAZnNR1gw/yK+byCoJAEPrMfaN4E/g7hAnvYFaqCOufntXz4Rwd/fet7HrtOH94NBl0vWb8RR76cMhyE59o7m9SZgS4gB5MGSHPC2SAyYZQw2tnlYdwJVFUyExm9CfPcOubT/vkar3kJ27aeFt/yG+6vhMja+USH9Hk/VASQwnZq76039Jkh2BGIq0ontfXcnuC7T8052wUKDNMMfwUpIXhnxAKM4J5HCRJMDfUQlR62/9fmjvajVvg+C/B1vLem86pBA4hjc1p0FaQVNvajnMH+gG0ZHCQqjkvu9uxf/fVBiiKO/lM4HVsXKrKtLhyTvaqgavuIMIgXPobXE5l2c/KsRxFgnmMp+J2A15l4ObT/TqrWGYmP1YmjYDTLALhLUGdh2oloWWMCDmC8jqghSQmJg9XGAtmDkxOLqvxj4SetZiXXti4LAykesu0/cTHSOwEXH8RGfFOHkxDVoa2aXz/uNaJattMqZ9SHUqPgAvXbHKkBuR1jK20SolTY6zB+KUiudpQbNrWYpgc+xjMKR+OuIjsEyrx7VaJGlJs06qJriId7wlC5rOWjLg6euDP7ogB5QchYLPRdej9+4a1EyND0MCdVkYG0Neal21e4b5NT+0n6myJc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lYA7izt4rRUR6YN8f0l/+5Qi5coDxAuu2kKKKqU7ensqB4pHJiLrlyinE8O7?=
 =?us-ascii?Q?xQeHY7pl+gm/x9g9raOA0NDQZe4re6BWIx4AlOnAGQZZG5R6Nq/pSeI9JPHi?=
 =?us-ascii?Q?LdFoE5ZmvfugiwlpsdlxN+/MgOqN3MYRWpdThE+ViAsv4d03lWfHdwgJ6Shy?=
 =?us-ascii?Q?SyuuoWFXhAByxIgv0gdY1gJoluq8eFQa/TfuY37tSbnpW7QWdBfB9hVCFm2R?=
 =?us-ascii?Q?vi8QQcDonsGI5RKVBHyp/Jr6dTFeXzR3ZZNCgihFME5/i6p1eofq5JOh5e4R?=
 =?us-ascii?Q?gDomWsmI9pdEeP8YuzeUXKrKPwPFwJ8jB4oThJtnhD8SuqwkKKYtLjxXCngZ?=
 =?us-ascii?Q?jbD3dwjZBxjTMSQyt+TgDmHKLTHL+zDqWgv2p+xH+yJKEvQG3I3JIVOMiKx3?=
 =?us-ascii?Q?nHPxXWMYzEDSjRyKyX7Ty38G6WyEBcIIex7VkUWRQgGp56d+xBVwLTE7opBU?=
 =?us-ascii?Q?6vr2CUjKHrps3VNGtJ047LUBKoCktraEEVFWdS6abv99aVaDnPzCbgzcLpO1?=
 =?us-ascii?Q?bS6ORKxsPcZwHCWJVml5Kc2HPkcc8RoKZxh8dHWZTKLLIp1+7b3Bnik9+rHP?=
 =?us-ascii?Q?7OYTevZBFv2r9xsCLM6ZeKzL8oR4yA3fVWEHci8qx64S1D2bKuds3wCRz9y4?=
 =?us-ascii?Q?dKojG+SbRuXjjp7h1dkL0MI/UR2TeneqGHd45Fn8MEkLgkCPzPbu/2NpYMRx?=
 =?us-ascii?Q?A0gWqSV2Li2KxBiMPP0i2H4QeAau/5+gEROwqGDHO/GsbsZpf0qazAzSnjnN?=
 =?us-ascii?Q?5WLRob+FZ8cyqTyzwwhzi8+ySE/21ddH+BZoR264yTD8CplqKfC0QvzuYA+2?=
 =?us-ascii?Q?kvbhLQic6+0ZmIbXEQxQEFpdH3AroX84yGNYgYm1SR2D6bAXUImRy9jHv65g?=
 =?us-ascii?Q?ILgYKVT1ovg6f0Um9ykAlCXx9+sUYikgw6DDa1XbBiKdEpBFlWYfeWLZI32Z?=
 =?us-ascii?Q?j5vwVmrmJbza+qzcTxdbgIyGcui2OCFmWGXKjhqop65RUaWzuyBPjd+8zWgR?=
 =?us-ascii?Q?nmsEBrp9iMh0PvKLzNEEmVLiogCV1nZpLcBOSaAqiaseIW8fsx7ZWRQp1tcC?=
 =?us-ascii?Q?kPpXGCdvhBPeWPdmEy9kV4h7HE7CDNzBAAPA5yrgv3SrAMG42IfohJxtO6kA?=
 =?us-ascii?Q?YLIvVqyb0pgBwUstj027NjzoOuuep7bjF4llZeSmAAA2OwtGaOKX/YDWN0ui?=
 =?us-ascii?Q?BWo4Kvu2tMKGKfigzv3+qfSOIET18tUfM1N6vWzJ/Yr/MmPwj4eXcgs2AVip?=
 =?us-ascii?Q?kFvHzzAJebClqZ4mTqKzVoQFrfVWsV04Y1nfoOf2hI/wkYpQOSzlumUiVlC0?=
 =?us-ascii?Q?7xyWMCst59tN4JgaqItGNDJ6band6iP2FUnE7YDsAdXQArADbRTny9yxfQ/O?=
 =?us-ascii?Q?AIc8e1aBdEAK0n/9VdqdSrC46hdCHSrxfcVRY6Bl8rirHNYqYLcG5w1vhOX8?=
 =?us-ascii?Q?2x67GWSbSn87au6XpsQjvF92HOMRLV8qlFvgVXofDQt5KY7q9ClqAeGxNXnw?=
 =?us-ascii?Q?RdYoP3VkPpqr/mNiMMhXhCgeVONiEStv62rfGaf7RapapTsujxyeakQ+vKQF?=
 =?us-ascii?Q?+QJAZv20Z2budGXnI1IBcWEf7+5DBro0RtfOj6Sf34a64CH/0bMpH3uGNAp7?=
 =?us-ascii?Q?2/Ab7F0gessu9pmFTKv0pV1/8ynkOTzxf0qQvFhD2n/pyXnKHkaHjR8KUmyQ?=
 =?us-ascii?Q?DfTD0dq2NDM+OdaS2egvty3IPcU1Ofy2i98n9iZcKQr+yEKLwbkEC7Uu9imZ?=
 =?us-ascii?Q?waq21urXMQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3425bb-556f-4954-721a-08de9ab51f5d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 06:06:24.2254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0mDHgAy3st5+Pk88fkcJk8F86HQ1CRFiiu89j9DQfl5XW21K3ZvO/M7gRDIho2GWmtHjpPq2IruAIpFCS7ZFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8062

The AI-generated review reported a potential DMA use-after-free issue
[1]. If netc_xmit_ntmp_cmd() times out and returns an error, the pending
command is not explicitly aborted, while ntmp_free_data_mem()
unconditionally frees the DMA buffer. If the buffer has already been
reallocated elsewhere, this may lead to silent memory corruption. Because
the hardware eventually processes the pending command and perform a DMA
write of the response to the physical address of the freed buffer.

To resolve this issue, this patch does the following modifications:

1. Convert cbdr->ring_lock from a spinlock to a mutex

The lock was originally a spinlock in case NTMP operations might be
invoked from atomic context. After downstream support for all NTMP
tables, no such usage has materialized. A mutex lock is now required
because the driver now needs to reclaim used BDs and release associated
DMA memory within the lock's context, while dma_free_coherent() might
sleep.

2. Introduce software command BD (struct netc_swcbd)

The hardware write-back overwrites the addr and len fields of the BD,
so the driver cannot rely on the hardware BD to free the associated DMA
memory. The driver now maintains a software shadow BD storing the DMA
buffer pointer, DMA address, and size. And netc_xmit_ntmp_cmd() only
reclaims older BDs when the number of used BDs reaches
NETC_CBDR_CLEAN_WORK (16). The software BD enables correct DMA memory
release. With this, struct ntmp_dma_buf and ntmp_free_data_mem() are no
longer needed and are removed.

3. Require callers to hold ring_lock across netc_xmit_ntmp_cmd()

netc_xmit_ntmp_cmd() releases the ring_lock before the caller finishes
consuming the response. At this point, if a concurrent thread submits
a new command, it may trigger ntmp_clean_cbdr() and free the DMA buffer
while it is still in use. Move ring_lock ownership to the caller to
ensure the response buffer cannot be reclaimed prematurely. So the
helpers ntmp_select_and_lock_cbdr() and ntmp_unlock_cbdr() are added.

These changes eliminate the DMA use-after-free condition and ensure safe
and consistent BD reclamation and DMA buffer lifecycle management.

Fixes: 4701073c3deb ("net: enetc: add initial netc-lib driver to support NTMP")
Link: https://lore.kernel.org/netdev/20260403011729.1795413-1-kuba@kernel.org/ # [1]
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 214 ++++++++++--------
 .../ethernet/freescale/enetc/ntmp_private.h   |   8 +-
 include/linux/fsl/ntmp.h                      |   9 +-
 3 files changed, 134 insertions(+), 97 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index b188eb2d40c0..70bbc5d2d5d4 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -7,6 +7,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/fsl/netc_global.h>
 #include <linux/iopoll.h>
+#include <linux/vmalloc.h>
 
 #include "ntmp_private.h"
 
@@ -42,6 +43,12 @@ int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 	if (!cbdr->addr_base)
 		return -ENOMEM;
 
+	cbdr->swcbd = vcalloc(cbd_num, sizeof(struct netc_swcbd));
+	if (!cbdr->swcbd) {
+		dma_free_coherent(dev, size, cbdr->addr_base, cbdr->dma_base);
+		return -ENOMEM;
+	}
+
 	cbdr->dma_size = size;
 	cbdr->bd_num = cbd_num;
 	cbdr->regs = *regs;
@@ -52,7 +59,7 @@ int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 	cbdr->addr_base_align = PTR_ALIGN(cbdr->addr_base,
 					  NTMP_BASE_ADDR_ALIGN);
 
-	spin_lock_init(&cbdr->ring_lock);
+	mutex_init(&cbdr->ring_lock);
 
 	cbdr->next_to_use = netc_read(cbdr->regs.pir);
 	cbdr->next_to_clean = netc_read(cbdr->regs.cir) & NETC_CBDRCIR_INDEX;
@@ -71,10 +78,24 @@ int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(ntmp_init_cbdr);
 
+static void ntmp_free_data_mem(struct device *dev, struct netc_swcbd *swcbd)
+{
+	if (unlikely(!swcbd->buf))
+		return;
+
+	dma_free_coherent(dev, swcbd->size + NTMP_DATA_ADDR_ALIGN,
+			  swcbd->buf, swcbd->dma);
+}
+
 void ntmp_free_cbdr(struct netc_cbdr *cbdr)
 {
 	/* Disable the Control BD Ring */
 	netc_write(cbdr->regs.mr, 0);
+
+	for (int i = 0; i < cbdr->bd_num; i++)
+		ntmp_free_data_mem(cbdr->dev, &cbdr->swcbd[i]);
+
+	vfree(cbdr->swcbd);
 	dma_free_coherent(cbdr->dev, cbdr->dma_size, cbdr->addr_base,
 			  cbdr->dma_base);
 	memset(cbdr, 0, sizeof(*cbdr));
@@ -94,40 +115,59 @@ static union netc_cbd *ntmp_get_cbd(struct netc_cbdr *cbdr, int index)
 
 static void ntmp_clean_cbdr(struct netc_cbdr *cbdr)
 {
-	union netc_cbd *cbd;
-	int i;
+	int i = cbdr->next_to_clean;
 
-	i = cbdr->next_to_clean;
 	while ((netc_read(cbdr->regs.cir) & NETC_CBDRCIR_INDEX) != i) {
-		cbd = ntmp_get_cbd(cbdr, i);
+		union netc_cbd *cbd = ntmp_get_cbd(cbdr, i);
+		struct netc_swcbd *swcbd = &cbdr->swcbd[i];
+
+		ntmp_free_data_mem(cbdr->dev, swcbd);
+		memset(swcbd, 0, sizeof(*swcbd));
 		memset(cbd, 0, sizeof(*cbd));
 		i = (i + 1) % cbdr->bd_num;
 	}
 
+	dma_wmb();
 	cbdr->next_to_clean = i;
 }
 
-static int netc_xmit_ntmp_cmd(struct ntmp_user *user, union netc_cbd *cbd)
+static void ntmp_select_and_lock_cbdr(struct ntmp_user *user,
+				      struct netc_cbdr **cbdr)
+{
+	/* Currently only ENETC is supported, and it has only one command
+	 * BD ring.
+	 */
+	*cbdr = &user->ring[0];
+
+	mutex_lock(&(*cbdr)->ring_lock);
+}
+
+static void ntmp_unlock_cbdr(struct netc_cbdr *cbdr)
+{
+	mutex_unlock(&cbdr->ring_lock);
+}
+
+static int netc_xmit_ntmp_cmd(struct netc_cbdr *cbdr, union netc_cbd *cbd,
+			      struct netc_swcbd *swcbd)
 {
 	union netc_cbd *cur_cbd;
-	struct netc_cbdr *cbdr;
-	int i, err;
+	int i, err, used_bds;
 	u16 status;
 	u32 val;
 
-	/* Currently only i.MX95 ENETC is supported, and it only has one
-	 * command BD ring
-	 */
-	cbdr = &user->ring[0];
-
-	spin_lock_bh(&cbdr->ring_lock);
-
-	if (unlikely(!ntmp_get_free_cbd_num(cbdr)))
+	used_bds = cbdr->bd_num - ntmp_get_free_cbd_num(cbdr);
+	if (unlikely(used_bds >= NETC_CBDR_CLEAN_WORK)) {
 		ntmp_clean_cbdr(cbdr);
+		if (unlikely(!ntmp_get_free_cbd_num(cbdr))) {
+			ntmp_free_data_mem(cbdr->dev, swcbd);
+			return -EBUSY;
+		}
+	}
 
 	i = cbdr->next_to_use;
 	cur_cbd = ntmp_get_cbd(cbdr, i);
 	*cur_cbd = *cbd;
+	cbdr->swcbd[i] = *swcbd;
 	dma_wmb();
 
 	/* Update producer index of both software and hardware */
@@ -135,17 +175,16 @@ static int netc_xmit_ntmp_cmd(struct ntmp_user *user, union netc_cbd *cbd)
 	cbdr->next_to_use = i;
 	netc_write(cbdr->regs.pir, i);
 
-	err = read_poll_timeout_atomic(netc_read, val,
-				       (val & NETC_CBDRCIR_INDEX) == i,
-				       NETC_CBDR_DELAY_US, NETC_CBDR_TIMEOUT,
-				       true, cbdr->regs.cir);
+	err = read_poll_timeout(netc_read, val,
+				(val & NETC_CBDRCIR_INDEX) == i,
+				NETC_CBDR_DELAY_US, NETC_CBDR_TIMEOUT,
+				true, cbdr->regs.cir);
 	if (unlikely(err))
-		goto cbdr_unlock;
+		return err;
 
 	if (unlikely(val & NETC_CBDRCIR_SBE)) {
-		dev_err(user->dev, "Command BD system bus error\n");
-		err = -EIO;
-		goto cbdr_unlock;
+		dev_err(cbdr->dev, "Command BD system bus error\n");
+		return -EIO;
 	}
 
 	dma_rmb();
@@ -157,40 +196,29 @@ static int netc_xmit_ntmp_cmd(struct ntmp_user *user, union netc_cbd *cbd)
 	/* Check the writeback error status */
 	status = le16_to_cpu(cbd->resp_hdr.error_rr) & NTMP_RESP_ERROR;
 	if (unlikely(status)) {
-		err = -EIO;
-		dev_err(user->dev, "Command BD error: 0x%04x\n", status);
+		dev_err(cbdr->dev, "Command BD error: 0x%04x\n", status);
+		return -EIO;
 	}
 
-	ntmp_clean_cbdr(cbdr);
-	dma_wmb();
-
-cbdr_unlock:
-	spin_unlock_bh(&cbdr->ring_lock);
-
-	return err;
+	return 0;
 }
 
-static int ntmp_alloc_data_mem(struct ntmp_dma_buf *data, void **buf_align)
+static int ntmp_alloc_data_mem(struct device *dev, struct netc_swcbd *swcbd,
+			       void **buf_align)
 {
 	void *buf;
 
-	buf = dma_alloc_coherent(data->dev, data->size + NTMP_DATA_ADDR_ALIGN,
-				 &data->dma, GFP_KERNEL);
+	buf = dma_alloc_coherent(dev, swcbd->size + NTMP_DATA_ADDR_ALIGN,
+				 &swcbd->dma, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	data->buf = buf;
+	swcbd->buf = buf;
 	*buf_align = PTR_ALIGN(buf, NTMP_DATA_ADDR_ALIGN);
 
 	return 0;
 }
 
-static void ntmp_free_data_mem(struct ntmp_dma_buf *data)
-{
-	dma_free_coherent(data->dev, data->size + NTMP_DATA_ADDR_ALIGN,
-			  data->buf, data->dma);
-}
-
 static void ntmp_fill_request_hdr(union netc_cbd *cbd, dma_addr_t dma,
 				  int len, int table_id, int cmd,
 				  int access_method)
@@ -241,37 +269,39 @@ static int ntmp_delete_entry_by_id(struct ntmp_user *user, int tbl_id,
 				   u8 tbl_ver, u32 entry_id, u32 req_len,
 				   u32 resp_len)
 {
-	struct ntmp_dma_buf data = {
-		.dev = user->dev,
+	struct netc_swcbd swcbd = {
 		.size = max(req_len, resp_len),
 	};
 	struct ntmp_req_by_eid *req;
+	struct netc_cbdr *cbdr;
 	union netc_cbd cbd;
 	int err;
 
-	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
 	if (err)
 		return err;
 
 	ntmp_fill_crd_eid(req, tbl_ver, 0, 0, entry_id);
-	ntmp_fill_request_hdr(&cbd, data.dma, NTMP_LEN(req_len, resp_len),
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, NTMP_LEN(req_len, resp_len),
 			      tbl_id, NTMP_CMD_DELETE, NTMP_AM_ENTRY_ID);
 
-	err = netc_xmit_ntmp_cmd(user, &cbd);
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
 	if (err)
 		dev_err(user->dev,
 			"Failed to delete entry 0x%x of %s, err: %pe",
 			entry_id, ntmp_table_name(tbl_id), ERR_PTR(err));
-
-	ntmp_free_data_mem(&data);
+	ntmp_unlock_cbdr(cbdr);
 
 	return err;
 }
 
-static int ntmp_query_entry_by_id(struct ntmp_user *user, int tbl_id,
-				  u32 len, struct ntmp_req_by_eid *req,
-				  dma_addr_t dma, bool compare_eid)
+static int ntmp_query_entry_by_id(struct netc_cbdr *cbdr, int tbl_id,
+				  struct ntmp_req_by_eid *req,
+				  struct netc_swcbd *swcbd,
+				  bool compare_eid)
 {
+	u32 len = NTMP_LEN(sizeof(*req), swcbd->size);
 	struct ntmp_cmn_resp_query *resp;
 	int cmd = NTMP_CMD_QUERY;
 	union netc_cbd cbd;
@@ -283,10 +313,11 @@ static int ntmp_query_entry_by_id(struct ntmp_user *user, int tbl_id,
 		cmd = NTMP_CMD_QU;
 
 	/* Request header */
-	ntmp_fill_request_hdr(&cbd, dma, len, tbl_id, cmd, NTMP_AM_ENTRY_ID);
-	err = netc_xmit_ntmp_cmd(user, &cbd);
+	ntmp_fill_request_hdr(&cbd, swcbd->dma, len, tbl_id, cmd,
+			      NTMP_AM_ENTRY_ID);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, swcbd);
 	if (err) {
-		dev_err(user->dev,
+		dev_err(cbdr->dev,
 			"Failed to query entry 0x%x of %s, err: %pe\n",
 			entry_id, ntmp_table_name(tbl_id), ERR_PTR(err));
 		return err;
@@ -300,7 +331,7 @@ static int ntmp_query_entry_by_id(struct ntmp_user *user, int tbl_id,
 
 	resp = (struct ntmp_cmn_resp_query *)req;
 	if (unlikely(le32_to_cpu(resp->entry_id) != entry_id)) {
-		dev_err(user->dev,
+		dev_err(cbdr->dev,
 			"%s: query EID 0x%x doesn't match response EID 0x%x\n",
 			ntmp_table_name(tbl_id), entry_id, le32_to_cpu(resp->entry_id));
 		return -EIO;
@@ -312,15 +343,15 @@ static int ntmp_query_entry_by_id(struct ntmp_user *user, int tbl_id,
 int ntmp_maft_add_entry(struct ntmp_user *user, u32 entry_id,
 			struct maft_entry_data *maft)
 {
-	struct ntmp_dma_buf data = {
-		.dev = user->dev,
+	struct netc_swcbd swcbd = {
 		.size = sizeof(struct maft_req_add),
 	};
 	struct maft_req_add *req;
+	struct netc_cbdr *cbdr;
 	union netc_cbd cbd;
 	int err;
 
-	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
 	if (err)
 		return err;
 
@@ -329,14 +360,15 @@ int ntmp_maft_add_entry(struct ntmp_user *user, u32 entry_id,
 	req->keye = maft->keye;
 	req->cfge = maft->cfge;
 
-	ntmp_fill_request_hdr(&cbd, data.dma, NTMP_LEN(data.size, 0),
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, NTMP_LEN(swcbd.size, 0),
 			      NTMP_MAFT_ID, NTMP_CMD_ADD, NTMP_AM_ENTRY_ID);
-	err = netc_xmit_ntmp_cmd(user, &cbd);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
 	if (err)
 		dev_err(user->dev, "Failed to add MAFT entry 0x%x, err: %pe\n",
 			entry_id, ERR_PTR(err));
-
-	ntmp_free_data_mem(&data);
+	ntmp_unlock_cbdr(cbdr);
 
 	return err;
 }
@@ -345,31 +377,31 @@ EXPORT_SYMBOL_GPL(ntmp_maft_add_entry);
 int ntmp_maft_query_entry(struct ntmp_user *user, u32 entry_id,
 			  struct maft_entry_data *maft)
 {
-	struct ntmp_dma_buf data = {
-		.dev = user->dev,
+	struct netc_swcbd swcbd = {
 		.size = sizeof(struct maft_resp_query),
 	};
 	struct maft_resp_query *resp;
 	struct ntmp_req_by_eid *req;
+	struct netc_cbdr *cbdr;
 	int err;
 
-	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
 	if (err)
 		return err;
 
 	ntmp_fill_crd_eid(req, user->tbl.maft_ver, 0, 0, entry_id);
-	err = ntmp_query_entry_by_id(user, NTMP_MAFT_ID,
-				     NTMP_LEN(sizeof(*req), data.size),
-				     req, data.dma, true);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = ntmp_query_entry_by_id(cbdr, NTMP_MAFT_ID, req, &swcbd, true);
 	if (err)
-		goto end;
+		goto unlock_cbdr;
 
 	resp = (struct maft_resp_query *)req;
 	maft->keye = resp->keye;
 	maft->cfge = resp->cfge;
 
-end:
-	ntmp_free_data_mem(&data);
+unlock_cbdr:
+	ntmp_unlock_cbdr(cbdr);
 
 	return err;
 }
@@ -385,8 +417,9 @@ EXPORT_SYMBOL_GPL(ntmp_maft_delete_entry);
 int ntmp_rsst_update_entry(struct ntmp_user *user, const u32 *table,
 			   int count)
 {
-	struct ntmp_dma_buf data = {.dev = user->dev};
 	struct rsst_req_update *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
 	union netc_cbd cbd;
 	int err, i;
 
@@ -394,8 +427,8 @@ int ntmp_rsst_update_entry(struct ntmp_user *user, const u32 *table,
 		/* HW only takes in a full 64 entry table */
 		return -EINVAL;
 
-	data.size = struct_size(req, groups, count);
-	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	swcbd.size = struct_size(req, groups, count);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
 	if (err)
 		return err;
 
@@ -405,15 +438,15 @@ int ntmp_rsst_update_entry(struct ntmp_user *user, const u32 *table,
 	for (i = 0; i < count; i++)
 		req->groups[i] = (u8)(table[i]);
 
-	ntmp_fill_request_hdr(&cbd, data.dma, NTMP_LEN(data.size, 0),
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, NTMP_LEN(swcbd.size, 0),
 			      NTMP_RSST_ID, NTMP_CMD_UPDATE, NTMP_AM_ENTRY_ID);
 
-	err = netc_xmit_ntmp_cmd(user, &cbd);
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
 	if (err)
 		dev_err(user->dev, "Failed to update RSST entry, err: %pe\n",
 			ERR_PTR(err));
-
-	ntmp_free_data_mem(&data);
+	ntmp_unlock_cbdr(cbdr);
 
 	return err;
 }
@@ -421,8 +454,9 @@ EXPORT_SYMBOL_GPL(ntmp_rsst_update_entry);
 
 int ntmp_rsst_query_entry(struct ntmp_user *user, u32 *table, int count)
 {
-	struct ntmp_dma_buf data = {.dev = user->dev};
 	struct ntmp_req_by_eid *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
 	union netc_cbd cbd;
 	int err, i;
 	u8 *group;
@@ -431,21 +465,23 @@ int ntmp_rsst_query_entry(struct ntmp_user *user, u32 *table, int count)
 		/* HW only takes in a full 64 entry table */
 		return -EINVAL;
 
-	data.size = NTMP_ENTRY_ID_SIZE + RSST_STSE_DATA_SIZE(count) +
-		    RSST_CFGE_DATA_SIZE(count);
-	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	swcbd.size = NTMP_ENTRY_ID_SIZE + RSST_STSE_DATA_SIZE(count) +
+		     RSST_CFGE_DATA_SIZE(count);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
 	if (err)
 		return err;
 
 	/* Set the request data buffer */
 	ntmp_fill_crd_eid(req, user->tbl.rsst_ver, 0, 0, 0);
-	ntmp_fill_request_hdr(&cbd, data.dma, NTMP_LEN(sizeof(*req), data.size),
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, NTMP_LEN(sizeof(*req), swcbd.size),
 			      NTMP_RSST_ID, NTMP_CMD_QUERY, NTMP_AM_ENTRY_ID);
-	err = netc_xmit_ntmp_cmd(user, &cbd);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
 	if (err) {
 		dev_err(user->dev, "Failed to query RSST entry, err: %pe\n",
 			ERR_PTR(err));
-		goto end;
+		goto unlock_cbdr;
 	}
 
 	group = (u8 *)req;
@@ -453,8 +489,8 @@ int ntmp_rsst_query_entry(struct ntmp_user *user, u32 *table, int count)
 	for (i = 0; i < count; i++)
 		table[i] = group[i];
 
-end:
-	ntmp_free_data_mem(&data);
+unlock_cbdr:
+	ntmp_unlock_cbdr(cbdr);
 
 	return err;
 }
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 3459cc45b610..f8dff3ba2c28 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -14,6 +14,7 @@
 #define NETC_CBDR_BD_NUM	256
 #define NETC_CBDRCIR_INDEX	GENMASK(9, 0)
 #define NETC_CBDRCIR_SBE	BIT(31)
+#define NETC_CBDR_CLEAN_WORK	16
 
 union netc_cbd {
 	struct {
@@ -56,13 +57,6 @@ union netc_cbd {
 	} resp_hdr; /* NTMP Response Message Header Format */
 };
 
-struct ntmp_dma_buf {
-	struct device *dev;
-	size_t size;
-	void *buf;
-	dma_addr_t dma;
-};
-
 struct ntmp_cmn_req_data {
 	__le16 update_act;
 	u8 dbg_opt;
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 916dc4fe7de3..83a449b4d6ec 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -31,6 +31,12 @@ struct netc_tbl_vers {
 	u8 rsst_ver;
 };
 
+struct netc_swcbd {
+	void *buf;
+	dma_addr_t dma;
+	size_t size;
+};
+
 struct netc_cbdr {
 	struct device *dev;
 	struct netc_cbdr_regs regs;
@@ -44,9 +50,10 @@ struct netc_cbdr {
 	void *addr_base_align;
 	dma_addr_t dma_base;
 	dma_addr_t dma_base_align;
+	struct netc_swcbd *swcbd;
 
 	/* Serialize the order of command BD ring */
-	spinlock_t ring_lock;
+	struct mutex ring_lock;
 };
 
 struct ntmp_user {
-- 
2.34.1



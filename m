Return-Path: <linuxppc-dev+bounces-24438-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31ABEC44512
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 02:13:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3PFK2JBKz3c72;
	Mon, 20 Jul 2026 12:13:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784513605;
	cv=pass; b=i8w/SX02JgQvpIGw5nCctTC1rhE/RYzGzDscSuw+OqJJ78J7zSEI/Q1C8TH49uVZnmr7GoV/oY+Q5A/OE8d2sHjFpjSx/sSSUHevAB3UW254gBIjDPKsordyNPUaceupX+gnlBQM0vyRUa5B8bUXOLcFifg6egx/JBKNYQ3mY8PKwE6DJzPpJtj8AxZqrfrxRKMRHrNn4myW6vCagySKWwY3Q65S+9kIqB5vNwMZgTEQlPyHuXtaXM8txzhpNaB5186UjGAuSNKhDPN+GbZoQfGX06kJnAef/rPJ3r+6wxs4nR70ZhLOmg1Uka0ym/ED8jt0OG2RirhUWhye89BUIw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784513605; c=relaxed/relaxed;
	bh=KLTF9WBAGeAwf9k55IX0Wuhsh8qjn6IELVpYq/SKvck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ad5wJUu4TA49e6wUXQGMuNZNWaM+vNt1yrEpiQv75FW//laftB87Vtg47SQgMLCHzxyaekXj95vQtG3rO+xBJdP3EX+PZEcbW36unww4SzljYC2mizRuktlWTzvWkapSWe8o73eR8i/wr3ojFinj5YW4eEBjMekaer3iQg+sPGry1PU3bhHo4fqp++71X+bOQwf47qEKKP1C0qq10lNeSajc6etCld4cSsBG7j/6Zvd+tDkQakDZam7mI0LKQtiK8DdXWvr+77NW0G12Z7KweRO0505RfZbC3dlPPDj+9I2VYSscHuH3Oc3imAMJUZlQKPPyQ9Tm4HQ1rdN1LliLLg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=haOOA0H4; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=haOOA0H4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3PFJ3m1gz3c5q
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 12:13:24 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDn4z+fmtc2PlIVJny/pD4xcRROMD8lRZ8N06RMJ3PT++W8BHuRhWWhd3gi/hS7dAmIjFJkfYR2QM8wf9zc/n0z6/XQKCDUVpLazDQXzIK1V8K5KgdZ08CeQP3a0m/f3xyeMFOcksQMRpWv5Zg4rijxjTtZA4Yhbz+UdgADgrKL+dmq9nwVZNLoeiooxV/oKsus1DhP1WQjJMyxDTvIW7o3ZOndtU6fO1wfWofzpjHurlJ4A6FHGm36S2bEKkS+64wrItZL/7q1vUTyuEjLn2Ny5UsVlmnG+ByL2ep2BAU7/Ghf7rOpPDnhdUmIntMdtevJ5Vn8VsDV4ohhn4bSfPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLTF9WBAGeAwf9k55IX0Wuhsh8qjn6IELVpYq/SKvck=;
 b=ush1p1FR5Dm+Uv9bbuJHB1nhs6nFd8cGluAyAfFnm8JsCixh0GII5wwG2S4dbkcy/9vqowQQBQ0BPIdMLyqFx6J0RNC+nXdjZnZZMQFarL8xZoJRkq6tIZu2/BUczUkSnDYMWvDuD5CbJHyIty3J1uyR/JH7P4o0fPWzHYZ0iK6DKJTUrjzdYjg6umDsXOqnxxOXe2jzG9J8PWyACiFESg522ogwTY3M0W5MnZCVFrRrgBKmZsnFPFcaMj9pe6NRWUFV/H3FDFhM+w3JDEwQEa1CL4Z9dh81WQwG3yHiCQEbZlVtLrk8z0pGnaE/2Xb+SINW3LsuYg0xQlKDWBwbTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLTF9WBAGeAwf9k55IX0Wuhsh8qjn6IELVpYq/SKvck=;
 b=haOOA0H4doPFsZnYwlWmExeS9hUR0ckc8IlwquP+74zendTX7qWgAtr4Dn4gP444pg4aSoNO897FETQsGwQMwOKpS5da7sWo89jWZxFHVuC7z0a/0A79zufl9f3l7RhWQjJRrvbKk8jdHqUU2VjQ+bdHeh5FqA8SSi62OWafrPWOEGURs2nsm5/KmKPiSW2S2QMetyyfLPhi2htyj/99uX2x2ZAQysw4sAqLpLteFHu5MpbNFf8kUOCpAZFPqzsOIjlBC4mHJxYLoYuhbFIODwS89DuqrBVaFj03IE/FTvtUpoKSYmYS79Mq+i3AkpBQiy58gXYHrSJjT+As6Repsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GV1PR04MB10872.eurprd04.prod.outlook.com (2603:10a6:150:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Mon, 20 Jul
 2026 02:13:17 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 02:13:16 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com,
	chleroy@kernel.org,
	maxime.chevallier@bootlin.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH RESEND v4 net-next 13/14] net: enetc: use alloc_etherdev_mqs() to create netdev for VF driver
Date: Mon, 20 Jul 2026 09:43:15 +0800
Message-Id: <20260720014317.1059359-14-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GV1PR04MB10872:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c747a2-8512-4ddd-6238-08dee604760b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|19092799006|921020|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	PAjuFvkRs/36ancDcnyJ/5VSXpL3EFkQwBBhx3UeLi91LRwRHt7SIS5FgUDt4+JERZa/5cXglr5Z66EeVfDjqdlP+txsqWP8btWci4ZFQL6o54eD6NI1xcRVtmhSHIWGIxdhl/fK++sCMfjkzkpFLWB/+58xfcZ4YxkkUKLP5pyJz2rGWKHrdZldYhfHAJMCk1ylvUujH8czUy/RdVUtroqiv/w2v0vKDD5e3GZq9DVyDseMqJ8X75GyRv0/ZYkLqTjxGZAcmfgolHxB1yWfNlwnP3xLI/1VKxjN+xxetH6OvcaFX4P7TMUnOAzvHyhNOCInczwf7x2KRhyZkK9Akt5oYeIAwlKXZit3Nl0Q1qtgbsRDRvCFmDZIpJb1SEN31MNG2nEzAeQJWzQNu1D52Y3dSzi7cQp0dG8ti4SgedfMwTJ0VcJ/oHr/pEYHbC2dLlWaxKWq/7tR6B+kQmAYvf7gaveTe8ev2uAyuAb8rfyBG6g+nAj2ar7ctFpM6k+OsOkdyPnXmKt0g1c8TRSmM+CY2F/fAg2Qz79gbotCMnJoB0AWwZsijUXKmMA3YK3K52W2WdUJRelDA07i5YwgdLnVTUwPeYUSGn4bCWS+Pae7kTXmkW7TPLewwhEWmAOnmXxLEsqnRBAtEIZ91ikzQ2v9aUZ1iCKxIWrtSxl/zV5JCisF/G1K3rTqapguWE6dSvW6OYlL3rcGqCsHR6sYdA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(19092799006)(921020)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YFY7MF0MbwVT+Ht83R9LVLkHRU115zAsdFlDg8Jrt8og554E7xzwJUsy75IE?=
 =?us-ascii?Q?its+fcbhBEwuaeRrbP9LO23EcICQyv5x+0aj4jxF7XaYvFcAo1mfWShBm3v2?=
 =?us-ascii?Q?rjeFvwNLxhFzuQYFTn0D0YNSl2YCcibLR3aWBM6F1Ryi8acPo0VifrEyCXYU?=
 =?us-ascii?Q?boA7cD9NCk0D6xvvqWv6X/5SN0uQwFfCTgHyynYWYHQVanSWWOEwHi9n9Amc?=
 =?us-ascii?Q?sD5J+Kpg9rimczwgUdzHPzDhL9qDHbwVTZlVxHbNav8CSBekkK8cfvt6Mkup?=
 =?us-ascii?Q?cJjoLd62mnAdIb1bbAkw8eIAh6RxpKsc6q/f53AJi2LauX36uAzxygnQ7lQm?=
 =?us-ascii?Q?dOVzHteq7eYC/V/zR5fOpWioq1/p23r5Gj5XaeD6v3VrtCxDEa+qPLi428vq?=
 =?us-ascii?Q?YTf9STXY900lS0TGPZqWBdXjv9t2ezMkvekyVWODMcSCUxqbrqggLzvCIGU+?=
 =?us-ascii?Q?CEnaFWytyNApMv4+f+rdFQc3MIx83eOb+8SnJjWc+RKZgGr5NsNkrPj8O/t+?=
 =?us-ascii?Q?2WYs/SnORdqYHV+YXjOD3wznsC2sYM6IhA9GHVfPP0wTMavnrPI+0+mE2L6W?=
 =?us-ascii?Q?IYQV0r5Tk7qcXpopR1PczUYv67jcE+68TRNnnpmItBqvBpMn9xVgisPL2OQR?=
 =?us-ascii?Q?1tteBAms8YmMSTYmgt8PZc2IIgMx8jr91RmfyvJcm91m8UTm/LiARuLaUrg2?=
 =?us-ascii?Q?4gT2t1yX8aHGl12U9vnCKC/1s0ED9mk3P/C+3LREX1MaR1Uwgx6IVDVkhOPo?=
 =?us-ascii?Q?dpwunZxkX82KsPDn4aMltw4vJtdskWTWJK0oMq8CXUrLSUSeACCSUD9WyUiO?=
 =?us-ascii?Q?THualH+0cxlN+KrplyKFSLeMPY7+IKOfqMrRROGmji8SY8AUze7vXQ61KWml?=
 =?us-ascii?Q?wfZWTn9272woPxdNoLPJVR9jJJJxeXZpnNES3cpWQ0bNDT4e4EvHMdpbAsmF?=
 =?us-ascii?Q?/3EVBoPdwDol12rn32KVuKGdE60+paoyCeU+JsOltIDSqlobLsYD3kWjPEzu?=
 =?us-ascii?Q?yGrxg8FP9EVliK5TgbNWqOKtiI7H2UsBlxVfDEoK9n9uJcOS/5wnDnjV8ju4?=
 =?us-ascii?Q?Y+/FbvLFULIPrfdSZtNPoGnVSs3RqvOrXqG15XHGAH15rNYY22ATsrA4k4fG?=
 =?us-ascii?Q?xihv7nNUQ2C2KhZnHFEvvtJqtl39dWQ1OEkxTPiczIJZjMgSXgPDFQq4fclc?=
 =?us-ascii?Q?MsirXKOjNaliGksVQlssFy5BZDCx22wLGVIFTST66Z4tuckb01dfSf28tz9A?=
 =?us-ascii?Q?Enq+BCUI8japNhoeDzUG2JSPzmd7V1KCXoa7U2qqfNbe+EgYB5sgmh2tONIM?=
 =?us-ascii?Q?fBDpxbcfaYL2QIGDogIAzz0TlfzRHLzgbHI7GrbONp4JTo90STQtnFoZFDqi?=
 =?us-ascii?Q?S1F77tblEd87YwSME4Lr992iZpOZWsvRhkSlYV8MHsX0+xw6+u1PAnXCDfK2?=
 =?us-ascii?Q?Kta7uhzz9/kfHb/cQ1YMq5k1vrAWWEQuEn7tq4MWXj1MnXnonINqtbRSikE7?=
 =?us-ascii?Q?1/d9fYe2dENfChmcxwu6dnVBagS6smGTqSlKv2zL8W2p7atgZGgX8MD3D/wf?=
 =?us-ascii?Q?91bcpSrc0F6oRss262Eynz3KcG+nN2tMZHIn1cPFIiuEXFzDZdsNV0GMhY5I?=
 =?us-ascii?Q?15rE6/X/oG20IWcoS6uaWp8vz3hlzBwAr73evqawO0ZQb+/bmVarv9ZiTjCu?=
 =?us-ascii?Q?8TPu9Y1bVQHj3vvuEnhfzDOhxB1YoNP4nHvC67fjf2dUd6rh6FnnCthJiEgc?=
 =?us-ascii?Q?3R4GwKB2WewIenP4ztJE+60hvjkxxGYxuJkuGrNfWqjW4auIcxib?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c747a2-8512-4ddd-6238-08dee604760b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 02:13:16.9190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z037v0wrdLW+ZlNLcVDM8aKfSxrHKtUMzNIqUnVSAUCZSQJNvaOgQxfNmVoNLFlhN73RGISNAa5dl31igmpKpSk0tNcP5r/LoPNq2X9Ag0l3ZEjA419ZQZIqYPgZftKV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10872

From: Wei Fang <wei.fang@nxp.com>

The VF driver uses alloc_etherdev_mq() with ENETC_MAX_NUM_TXQS as the
queue count, which forces the TX and RX queue counts to be equal and
uses a compile-time constant rather than the actual hardware capability.

After enetc_get_si_caps() is called, si->num_tx_rings and
si->num_rx_rings reflect the actual number of rings assigned to the VF
by the PF. For the ENETC VF on LS1028A and the upcoming i.MX95/94, their
SoCs have no more than 6 CPUs, and the number of TX/RX rings allocated
to the VF is less than 8.

Therefore, switch to alloc_etherdev_mqs() so that the TX and RX queue
counts are set independently, each capped at ENETC_MAX_NUM_TXQS, based
on the actual number of rings assigned to the VF by the PF.

Note that if future SoCs have more than 6 CPUs and more than 6 RX rings
allocated to VFs, the size of the int_vector array in struct
enetc_ndev_priv will need to be modified. Similarly, if more than 8 TX
rings are allocated to each int_vector, ENETC_MAX_NUM_TXQS will also
need to be modified.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_vf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 9cdb0a4d6baf..7dcb4a0246f5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -317,7 +317,14 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 
 	enetc_get_si_caps(si);
 
-	ndev = alloc_etherdev_mq(sizeof(*priv), ENETC_MAX_NUM_TXQS);
+	/* Currently, the supported SoCs have a max of 6 CPUs and the VFs
+	 * have less than 6 RX/TX rings. So no issues for these supported
+	 * SoCs, but for future SoCs which have more CPUs or more TX/RX
+	 * rings, all the related logic needs to be improved.
+	 */
+	ndev = alloc_etherdev_mqs(sizeof(*priv),
+				  min(si->num_tx_rings, ENETC_MAX_NUM_TXQS),
+				  min(si->num_rx_rings, ENETC_MAX_NUM_TXQS));
 	if (!ndev) {
 		err = -ENOMEM;
 		dev_err(&pdev->dev, "netdev creation failed\n");
-- 
2.34.1



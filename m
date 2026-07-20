Return-Path: <linuxppc-dev+bounces-24427-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267FEC44512
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 02:12:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3PD52styz2yY1;
	Mon, 20 Jul 2026 12:12:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784513541;
	cv=pass; b=VHs3rlPHEbsO91W39BxDQd4kb0mwyef9F/drZV2o1k6c3g2dVQPCiLJu4K542g2e6sVxyYWWZLRDrC12Bhqgjqpw0bS/SYfREvrgQ7m8nT51hWyHxM/UkplMIDMOlGZVZeVmZuXOjhENlbFIalnOPmdYqsSLkEA3WYQt4nO0yf8WpOIH+w0qwhT4k8OdGvsiSznKYrkyAyzWmll9Ftx+9k/MfLwsxanUP90I2r4TojX20yuzPUCtMc72cT5ZX6D2tI0ecDvSPrvGChL1yXRhDKKAINttkgSxqLBDK1VbO7MYrI+AAiCYYBWwcQRhYNtiZYzrJNMufCI0bRuC6En0TQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784513541; c=relaxed/relaxed;
	bh=uf7R3hDgk51Q5WBhT1WZQt5pblRb/WvzPKESaRYdXgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bx4DQbEwVIP0YHn1+98natTCeKiAppC3HSnvEmmRy9uQrSHmR1xDzspqzMG2l6HL+Rvs2IsPOcbdeTPNnRwiA4f53ArYFXOlMbbCds4dAJ+sBK5J0jsaEZ1qhinzYS31tctwq5YHHcOBjLnalYoK/44G0uRUlLNedXo1gXwcTjcitoJE6/0NOBrkfp0LD9rOPFp3v44wDF839pWilQ2tEz1RYzj5ERMhmAb9tHiKTqWmddeW/xMwQXGAk3UPn9WHv+UkVJd+wzyBiQ5JPzqBhQiGtZ83yF2tj1JpthiP+VjGADkpURZA8p7mjInJNXIsJ2Umhtjt+/ufmWmeZBDfUg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Haq8sOzU; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Haq8sOzU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3PD40TS1z2ygX
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 12:12:20 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZi/0CTrItcFG9cju4J/92vhN1sprsGQQgoiHIkq0bIJSuI3E/cFSI2Mey5uX2xsSCnOXBHrkrwCS6pS/8hMWryKBikToq71pcxwHKQfifDjuCs/fzQiWLf6sHHGzWNBFktKvqqukDWRn1zwgECpkO6zhKTWb+ZA+lAw/xn7n1AY7bUJ5gt+BxmXtKIq+hV9ZtiYVnkAk9d9iWmp+lSFfKkgfoFwAr73aoIplIorszOHXvA3SLFueDUhoRStecm38oYbUEvWDoMHXDgG/0S7zoeaEWuYyrsydJaYPynNC5Z5RlceiuuKImQlKLYJ9B0D3mTzuaStg2BQk3g/6O7EHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uf7R3hDgk51Q5WBhT1WZQt5pblRb/WvzPKESaRYdXgs=;
 b=AgNWlDQs+fa2n/NQm6WMKH5FjadkG1w7ythSYSz+OW5mTl9Ep9OLBtw1t4QVEhaD5PJyiJJ/hIR9QK5kaybI0ABFuKYLuHrxypshn50maWj0NHlkFxoTVRZjUw3zAclu4Hg8GeHSRBSXzgBpCoqxLixxIl6jRXcx4iZCTvu3U9QvzIqvLKOc9UFCYflWUkPjF7JxVpaji2T+DgRjXNcL2p4EYBHXSOu7fqoUBcgCLLhnyulsD/9ldSDdyhT4QwED5qoNP7OF+SbwwiZSqpTKGf4jGFNP8bTopKRrRmkyXZtVN6+8eNFwcvnV1TNkrDbjgjntNdyvAkKV9Kd0PiqqyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uf7R3hDgk51Q5WBhT1WZQt5pblRb/WvzPKESaRYdXgs=;
 b=Haq8sOzUnR8akHQhNVvsR/rK2p6Vx283Ge/Xhxh3HJiPSwknG/3AQaf5om6n5/WmA29jRBemm/nLu2IpaqnorPXRYD1l18RcNAttts16mwJwSVS2aC5wRZbNALDuJU5yUKdpPoOLI0rbI/a6x+4eutGE8oPBL/9Epslmxp+phGWbG8Bwo4hYzODwjhKhdOY+f+vA+8sy93dx8YYHgpyKBHgONrMDYY4KQW8RqHgGgYM5y8xnTUlIVxIuGqseyUFl5KkN0HGJ7K1Tq8Yh5FZx+5p+7WVSKhoKVIxactQVQDnVgGcdQ8A2sdDiIL/xODphsWll1gq3B3FAcXfgY0T3mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DB9PR04MB11580.eurprd04.prod.outlook.com (2603:10a6:10:608::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 02:12:05 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 02:12:05 +0000
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
Subject: [PATCH RESEND v4 net-next 02/14] net: enetc: extract common helpers for MAC hash filter configuration
Date: Mon, 20 Jul 2026 09:43:04 +0800
Message-Id: <20260720014317.1059359-3-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DB9PR04MB11580:EE_
X-MS-Office365-Filtering-Correlation-Id: 722ebb39-37ff-4e8e-2512-08dee6044b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|376014|7416014|6133799003|10067099003|11063799006|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	D4FbhRAs11/a09NvK5CAzuRHFBxZ1dV7dNvvQ+RVVTTP4c/mj78rxOO++mFJp04fQLWP0ccJ165UXn1wKCGGp0aoZAGleV4g7uzMse3t1CppSL1+/B4jmcVVPEPEg5zUDohUk1st1s8gHhaokTnONaw5/DuiwvQeISnKYm0rjnVM35IZgcStUNrKWRqh7p06OAtINT9c4keq8wn2ySjiyQpkPrIpZLnYX6oGNrAyIXYKM/2JRzHSlu/YGVg5tsVd7MSU3dYc2Gg2h6A23c5+w1kdZ4kUwHJviFqZFkBssWs8C8470uyogcZEsZA8g1Hj8yakWbPGQszJvghl9ZwMLoaDL2NedntA0n0WUSm0aaPl2vCWShXj08i4J3PGV0nnMMYghzaAU3eqSRyj23laHZxX4Ht7FZHG/aqb+/YKRdrQ6K4+BhQy4+m2E1Pwrasl1eM2Rr4OSh2oKTBF1SWCsFlj34RaC4FLarbC90UGNgQRH5jxPuRP7Ek3vTbrNgpznNWp1A74STN1BM+1Smh/qfabehf1QGD3n3oq0quFACNg5CLe/6jHXyxZkqRiMonf1rLBCORcz2ZdsePhhYcB40FjZtZnacGKCoVn5U9EBAQJQJ5g2zVtiBn0oXKtzCjXmsIf8IgT6+RISCtKu9VmfRIBVulhMK/ULpr9Rpmb/k0chKjgeSOwHxghm3s2Txyd+OkKIHA90iU4Jojrr9TzIw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(376014)(7416014)(6133799003)(10067099003)(11063799006)(56012099006)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bUrR8e1+pTrvGY3+ug2SvGJR07MtrGvFKsdAswAsQEOsru/X2pzecZ8111is?=
 =?us-ascii?Q?aFV3PGiyW2uNF7v9ZQs7uPqZcKb2zQ7wSeHBv2hoetAJJEwJJkD0SD2m2xG2?=
 =?us-ascii?Q?YwCsc441ClhzCnWMQ4/xkU09MDqc20aV0SvXJK/gZt2M7GKcgoEUcPB4RSYr?=
 =?us-ascii?Q?820c4LEQmvAdVu5mkCxr5FfpDdCXJ99+wRgUQ6r+luh+NOoIlhxV3/Cal6It?=
 =?us-ascii?Q?IhcQXhV6dbodl6+CeuUsbe6p9U1U7kJF/TBvRqmersS/d1AKUmEa5umpFjZp?=
 =?us-ascii?Q?IKYKjvaAJEj8CmnHVmVNTbFPns9Z4Z5YQ5RpjKvaG/py2nmmapKUMrPWj5iz?=
 =?us-ascii?Q?qhUYLYaEQjgLunRmZqz8VU7CAyQOSuyYcOVvWw8WpV8MsiNlS54x8IrmyRmQ?=
 =?us-ascii?Q?PKkQPa0n+4ZriiXnwwHg56DBHMNtvuG20tEsWRmQAmY5mZ1i0fJ0kyCj5jHe?=
 =?us-ascii?Q?8k09TaKmp/+N8mIh4kXfx7EGmar/mAeKq4q0KNFPtxZjDuCTTjBDreHUkfNy?=
 =?us-ascii?Q?kHqdFrmFu3SSNAO/nmYxXmRl5uAsmS1WRQKV7lKiZj6GDl8u7VJGWTYai9Ml?=
 =?us-ascii?Q?kEc6q6xRp4EstHW3q6Ppjn2WWyeIuFMz+iUh4/5RTBT5m+h5DH+kO9Ue7k8r?=
 =?us-ascii?Q?VIimduZQM9rPTwwQzqqyWt5Zky/ZUfjOG5ZYrNVbBaJdLlQjdMCYkMnG1SdR?=
 =?us-ascii?Q?sSRn77ufODlf/kpH6y4GMGpP0AyE3SmM3Wp9NySELGFZQ3RGRb7ruM2iE1M9?=
 =?us-ascii?Q?pnK7qT23eKelrASS3TOYXS2K5uSJjAlsQZiyIhrfdXOfjWttIuOkPuvtiokd?=
 =?us-ascii?Q?k+OHCt6GxJ6zGvx/BAiM69Q7HlIey6oQ81Z8tifI7xk5NkhXOQRYzN9bM17Y?=
 =?us-ascii?Q?TZ3J9vtsTuBsm5VwkOxoB9zo6UmGTCtXe9aAX2l4jRTIbRfQdHVhBSbBDFM2?=
 =?us-ascii?Q?WP1dI3fB2OnsKnYqo14nfFLvyXWqMh7VlZ+yWuVC2J1ppi9oTW3527dJn4Vx?=
 =?us-ascii?Q?LXmuTF6xaO+yFwIn23HlE0w7Q20/2GG3nNUicU7rIjzKp/XZGJis32l6kIo6?=
 =?us-ascii?Q?Bxa7VJrboH6ptX7Z8v7L3BqgKouKtjtt3mOc4LT/jKAL9ky7+0mW4QtLdWPb?=
 =?us-ascii?Q?yo34MwqmfADY2B40+eMO8ywyTZQmLp+BWL9B5h1/ojdJUtHksmZD8UZt9Vfc?=
 =?us-ascii?Q?sZ2ZqP03jY7t/q9ggPPosYD7CM8979XhkCulr9awSIomVyy0hDj5pQ6MthA6?=
 =?us-ascii?Q?WJTW+zKi7QzqLwLc165S/OAnpT50L4CQ4Mwr/xGwMXQvQPhWK2kZRAybwYJn?=
 =?us-ascii?Q?hWxDhguIeRyPiXbchaHadlpPSl0tr/TFWgAhU9T3W0FLRDCNv+/ndM/18SL6?=
 =?us-ascii?Q?W/qxcPBmeGOFi5aFoULvNdUwmz9aqydxoPrxyniqAYLTH37WRQ6treCJIu2Y?=
 =?us-ascii?Q?itS5M+vXTSCftPEADS+Kqus+KsDucq0k4fsPX4+DxCB4dZo4izPbeVQ0d5Jk?=
 =?us-ascii?Q?E2yEpiool2iZq8HLNF+JvFDkTVCldinCoi2JrGRdA3v/TZeHo06HR+N9z7U2?=
 =?us-ascii?Q?R6oai8+RlM8zNz8fqJGN06NdePX4P1yQBhAtyMjQTIRnWAGw0uAfF42ZP0yV?=
 =?us-ascii?Q?JOBlrVEgLnF3ETxXUvUqzODFaHIMsLEAdQ2VRWwsXsvNF4Q5j5G++CXy+hbg?=
 =?us-ascii?Q?Vgr6RtB5i3cfRkQM8+6mFzG4JDuTqopTv1uFFmac1tdXzOeBseolnQa85oJX?=
 =?us-ascii?Q?Dnkt0Di2ZMvaWM9T7wWjbdXgg0rLbO3sng5oOpVerMeh2XQQUOTv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722ebb39-37ff-4e8e-2512-08dee6044b28
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 02:12:04.9919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epJx6lqx5m3CigA7patlQ9yHzb07ZSFz6rTLWRYG0xKQNhBy3ELDxm3FuKbwSi7NDc+nkun419abzUxCYBtRPGyS3uCBjtgsRV12w2Fe09z/MSi5aDanD08SPIKQZ1p/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11580

From: Wei Fang <wei.fang@nxp.com>

The PSIUMHFR and PSIMMHFR registers in ENETC v4 have the same bit layout
as in ENETC v1. The only difference between the two hardware generations
is the register address offsets.

Since the register functionality is identical, the MAC hash filter
configuration code can be shared between the ENETC v1 and v4 drivers.
Extract two new common helper functions, enetc_set_si_uc_hash_filter()
and enetc_set_si_mc_hash_filter(), into enetc_pf_common.c. These helpers
select the correct register offset based on the hardware revision via
is_enetc_rev1().

Remove v1-specific enetc_clear_mac_ht_flt() and enetc_set_mac_ht_flt()
from enetc_pf.c, and v4-specific enetc4_pf_set_si_uc_hash_filter() and
enetc4_pf_set_si_mc_hash_filter() from enetc4_pf.c, as they are now
superseded by the shared implementations.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 43 +++++++---------
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 51 +++++--------------
 .../freescale/enetc/enetc_pf_common.c         | 40 +++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  2 +
 4 files changed, 73 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 304ec069654d..48a74db90ed5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -75,20 +75,6 @@ static void enetc4_pf_get_si_primary_mac(struct enetc_hw *hw, int si,
 	put_unaligned_le16(lower, addr + 4);
 }
 
-static void enetc4_pf_set_si_uc_hash_filter(struct enetc_hw *hw, int si,
-					    u64 hash)
-{
-	enetc_port_wr(hw, ENETC4_PSIUMHFR0(si), lower_32_bits(hash));
-	enetc_port_wr(hw, ENETC4_PSIUMHFR1(si), upper_32_bits(hash));
-}
-
-static void enetc4_pf_set_si_mc_hash_filter(struct enetc_hw *hw, int si,
-					    u64 hash)
-{
-	enetc_port_wr(hw, ENETC4_PSIMMHFR0(si), lower_32_bits(hash));
-	enetc_port_wr(hw, ENETC4_PSIMMHFR1(si), upper_32_bits(hash));
-}
-
 static void enetc4_pf_set_loopback(struct net_device *ndev, bool en)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
@@ -147,11 +133,12 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf)
 	int max_num_mfe = pf->caps.mac_filter_num;
 	struct enetc_mac_filter mac_filter = {};
 	struct net_device *ndev = pf->si->ndev;
-	struct enetc_hw *hw = &pf->si->hw;
 	struct enetc_mac_addr *mac_tbl;
+	struct enetc_si *si = pf->si;
 	struct netdev_hw_addr *ha;
 	int i = 0, err;
 	int mac_cnt;
+	u64 hash;
 
 	netif_addr_lock_bh(ndev);
 
@@ -159,7 +146,7 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf)
 	if (!mac_cnt) {
 		netif_addr_unlock_bh(ndev);
 		/* clear both MAC hash and exact filters */
-		enetc4_pf_set_si_uc_hash_filter(hw, 0, 0);
+		enetc_set_si_uc_hash_filter(si, 0, 0);
 		enetc4_pf_clear_maft_entries(pf);
 
 		return 0;
@@ -186,11 +173,13 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf)
 	/* Set temporary unicast hash filters in case of Rx loss when
 	 * updating MAC address filter table
 	 */
-	enetc4_pf_set_si_uc_hash_filter(hw, 0, *mac_filter.mac_hash_table);
+	bitmap_to_arr64(&hash, mac_filter.mac_hash_table,
+			ENETC_MADDR_HASH_TBL_SZ);
+	enetc_set_si_uc_hash_filter(si, 0, hash);
 	enetc4_pf_clear_maft_entries(pf);
 
 	if (!enetc4_pf_add_maft_entries(pf, mac_tbl, i))
-		enetc4_pf_set_si_uc_hash_filter(hw, 0, 0);
+		enetc_set_si_uc_hash_filter(si, 0, 0);
 
 	kfree(mac_tbl);
 
@@ -206,8 +195,9 @@ static void enetc4_pf_set_mac_hash_filter(struct enetc_pf *pf, int type)
 {
 	struct net_device *ndev = pf->si->ndev;
 	struct enetc_mac_filter *mac_filter;
-	struct enetc_hw *hw = &pf->si->hw;
+	struct enetc_si *si = pf->si;
 	struct netdev_hw_addr *ha;
+	u64 hash;
 
 	netif_addr_lock_bh(ndev);
 	if (type & ENETC_MAC_FILTER_TYPE_UC) {
@@ -216,8 +206,9 @@ static void enetc4_pf_set_mac_hash_filter(struct enetc_pf *pf, int type)
 		netdev_for_each_uc_addr(ha, ndev)
 			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
 
-		enetc4_pf_set_si_uc_hash_filter(hw, 0,
-						*mac_filter->mac_hash_table);
+		bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
+				ENETC_MADDR_HASH_TBL_SZ);
+		enetc_set_si_uc_hash_filter(si, 0, hash);
 	}
 
 	if (type & ENETC_MAC_FILTER_TYPE_MC) {
@@ -226,8 +217,9 @@ static void enetc4_pf_set_mac_hash_filter(struct enetc_pf *pf, int type)
 		netdev_for_each_mc_addr(ha, ndev)
 			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
 
-		enetc4_pf_set_si_mc_hash_filter(hw, 0,
-						*mac_filter->mac_hash_table);
+		bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
+				ENETC_MADDR_HASH_TBL_SZ);
+		enetc_set_si_mc_hash_filter(si, 0, hash);
 	}
 	netif_addr_unlock_bh(ndev);
 }
@@ -480,7 +472,6 @@ static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
 	struct enetc_si *si = container_of(work, struct enetc_si, rx_mode_task);
 	struct enetc_pf *pf = enetc_si_priv(si);
 	struct net_device *ndev = si->ndev;
-	struct enetc_hw *hw = &si->hw;
 	bool uc_promisc = false;
 	bool mc_promisc = false;
 	int type = 0;
@@ -501,12 +492,12 @@ static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
 	enetc_set_si_mc_promisc(si, 0, mc_promisc);
 
 	if (uc_promisc) {
-		enetc4_pf_set_si_uc_hash_filter(hw, 0, 0);
+		enetc_set_si_uc_hash_filter(si, 0, 0);
 		enetc4_pf_clear_maft_entries(pf);
 	}
 
 	if (mc_promisc)
-		enetc4_pf_set_si_mc_hash_filter(hw, 0, 0);
+		enetc_set_si_mc_hash_filter(si, 0, 0);
 
 	/* Set new MAC filter */
 	enetc4_pf_set_mac_filter(pf, type);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index a97d2e2dd07b..db2a800a7aaf 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -80,37 +80,6 @@ static void enetc_add_mac_addr_em_filter(struct enetc_mac_filter *filter,
 	filter->mac_addr_cnt++;
 }
 
-static void enetc_clear_mac_ht_flt(struct enetc_si *si, int si_idx, int type)
-{
-	bool err = si->errata & ENETC_ERR_UCMCSWP;
-
-	if (type == UC) {
-		enetc_port_wr(&si->hw, ENETC_PSIUMHFR0(si_idx, err), 0);
-		enetc_port_wr(&si->hw, ENETC_PSIUMHFR1(si_idx), 0);
-	} else { /* MC */
-		enetc_port_wr(&si->hw, ENETC_PSIMMHFR0(si_idx, err), 0);
-		enetc_port_wr(&si->hw, ENETC_PSIMMHFR1(si_idx), 0);
-	}
-}
-
-static void enetc_set_mac_ht_flt(struct enetc_si *si, int si_idx, int type,
-				 unsigned long hash)
-{
-	bool err = si->errata & ENETC_ERR_UCMCSWP;
-
-	if (type == UC) {
-		enetc_port_wr(&si->hw, ENETC_PSIUMHFR0(si_idx, err),
-			      lower_32_bits(hash));
-		enetc_port_wr(&si->hw, ENETC_PSIUMHFR1(si_idx),
-			      upper_32_bits(hash));
-	} else { /* MC */
-		enetc_port_wr(&si->hw, ENETC_PSIMMHFR0(si_idx, err),
-			      lower_32_bits(hash));
-		enetc_port_wr(&si->hw, ENETC_PSIMMHFR1(si_idx),
-			      upper_32_bits(hash));
-	}
-}
-
 static void enetc_sync_mac_filters(struct enetc_pf *pf)
 {
 	struct enetc_mac_filter *f = pf->mac_filter;
@@ -122,12 +91,16 @@ static void enetc_sync_mac_filters(struct enetc_pf *pf)
 	for (i = 0; i < MADDR_TYPE; i++, f++) {
 		bool em = (f->mac_addr_cnt == 1) && (i == UC);
 		bool clear = !f->mac_addr_cnt;
+		u64 hash;
 
 		if (clear) {
-			if (i == UC)
+			if (i == UC) {
 				enetc_clear_mac_flt_entry(si, pos);
+				enetc_set_si_uc_hash_filter(si, 0, 0);
+			} else {
+				enetc_set_si_mc_hash_filter(si, 0, 0);
+			}
 
-			enetc_clear_mac_ht_flt(si, 0, i);
 			continue;
 		}
 
@@ -135,7 +108,7 @@ static void enetc_sync_mac_filters(struct enetc_pf *pf)
 		if (em) {
 			int err;
 
-			enetc_clear_mac_ht_flt(si, 0, UC);
+			enetc_set_si_uc_hash_filter(si, 0, 0);
 
 			err = enetc_set_mac_flt_entry(si, pos, f->mac_addr,
 						      BIT(0));
@@ -147,11 +120,15 @@ static void enetc_sync_mac_filters(struct enetc_pf *pf)
 				 err);
 		}
 
+		bitmap_to_arr64(&hash, f->mac_hash_table,
+				ENETC_MADDR_HASH_TBL_SZ);
 		/* hash table filter, clear EM filter for UC entries */
-		if (i == UC)
+		if (i == UC) {
 			enetc_clear_mac_flt_entry(si, pos);
-
-		enetc_set_mac_ht_flt(si, 0, i, *f->mac_hash_table);
+			enetc_set_si_uc_hash_filter(si, 0, hash);
+		} else {
+			enetc_set_si_mc_hash_filter(si, 0, hash);
+		}
 	}
 }
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index b0c0dc668e34..3597cb81a7cc 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -131,6 +131,46 @@ void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc)
 }
 EXPORT_SYMBOL_GPL(enetc_set_si_mc_promisc);
 
+void enetc_set_si_uc_hash_filter(struct enetc_si *si, int si_id, u64 hash)
+{
+	int psiumhfr0_off, psiumhfr1_off;
+	struct enetc_hw *hw = &si->hw;
+
+	if (is_enetc_rev1(si)) {
+		bool err = si->errata & ENETC_ERR_UCMCSWP;
+
+		psiumhfr0_off = ENETC_PSIUMHFR0(si_id, err);
+		psiumhfr1_off = ENETC_PSIUMHFR1(si_id);
+	} else {
+		psiumhfr0_off = ENETC4_PSIUMHFR0(si_id);
+		psiumhfr1_off = ENETC4_PSIUMHFR1(si_id);
+	}
+
+	enetc_port_wr(hw, psiumhfr0_off, lower_32_bits(hash));
+	enetc_port_wr(hw, psiumhfr1_off, upper_32_bits(hash));
+}
+EXPORT_SYMBOL_GPL(enetc_set_si_uc_hash_filter);
+
+void enetc_set_si_mc_hash_filter(struct enetc_si *si, int si_id, u64 hash)
+{
+	int psimmhfr0_off, psimmhfr1_off;
+	struct enetc_hw *hw = &si->hw;
+
+	if (is_enetc_rev1(si)) {
+		bool err = si->errata & ENETC_ERR_UCMCSWP;
+
+		psimmhfr0_off = ENETC_PSIMMHFR0(si_id, err);
+		psimmhfr1_off = ENETC_PSIMMHFR1(si_id);
+	} else {
+		psimmhfr0_off = ENETC4_PSIMMHFR0(si_id);
+		psimmhfr1_off = ENETC4_PSIMMHFR1(si_id);
+	}
+
+	enetc_port_wr(hw, psimmhfr0_off, lower_32_bits(hash));
+	enetc_port_wr(hw, psimmhfr1_off, upper_32_bits(hash));
+}
+EXPORT_SYMBOL_GPL(enetc_set_si_mc_hash_filter);
+
 void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 			   const struct net_device_ops *ndev_ops)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index a619fb8fed9c..bf9029b0a017 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -19,6 +19,8 @@ int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_init_sriov_resources(struct enetc_pf *pf);
 void enetc_set_si_uc_promisc(struct enetc_si *si, int si_id, bool promisc);
 void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc);
+void enetc_set_si_uc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
+void enetc_set_si_mc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1



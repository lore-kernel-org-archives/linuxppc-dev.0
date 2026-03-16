Return-Path: <linuxppc-dev+bounces-18235-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD50F4643A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 09:42:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ99W5bsRz2xpn;
	Mon, 16 Mar 2026 20:42:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773654143;
	cv=pass; b=n9q9hG9uhuesZZE9cpeAIdrJ6zsp1D7oP9W12B0ER15DD72dgUnOGIrAXJnzEw7SgjkaGQHpbJ/zZ1XACVtRwS+RG62AlgbVqFNH01aLApFYCZFnyed7ImzWZAJq66DIGhPWwRKUyG6LKgMqNgJANg4aGj27hZXuRyzpN7J2tAdGi/sVguX45pIpc9qGIkshg2dTP7zFJtcCgLj/igfwEzXBxkr3t6g2wcEvZwYWKRiIX4+VsNefjS1+ijIEs/1Kj2SaNmT2pl5C9IllUdPIjWUHTHN2UshcZqT5iI1a7FY0OMnNUQsvsAfq9rhFUoWQ3YSYmo0jryaze5WFJfGRZA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773654143; c=relaxed/relaxed;
	bh=6SxnyLWkH2SjcB21lIu/S1P5yzePJsBjqUoxpfWUcXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oEiHELEmpV9cZI2tkW3mmhimmdV2Kssd97klT1ewR28Qbhgf/WaKhuRQNsoIymmoz/D1q9Tu/l/syjR9y6fwJMnoEZaUJPrMAPLW4tSN0362N1YcI7nUkpX2zgVXq8PSTUnQadyC2GefWUUtoruq7vp2HhY8zhxSm5KeavLz+9tjaRCSQeeEhEVnlUhwG/lx4mWXOnUcdgYtdGz6BYTGy2I0mVVbyqQZmA6sO/4mcbqnqs9dqnkDuujHE6muNbE+CrI0oijTOnGDxoIrn92sRmVJxpu4IvrRQrDKhvlSoi0emhdGkuiFD66Q7iU+Ola8khO5ttD3XCPDy4JyLwH3fA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Z4e+c7aK; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Z4e+c7aK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ99V5JTXz30M6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 20:42:22 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCsWKYoHrIDIgDVhx9zoJYBQ5jt5A45RJ/0/+Bu9LQFjZJde4ZURt8phUKGIZ4vaATyn1U/s2JhfuQFzpR/W4qd+DYawtrclounGkxxeMu5Nye8IuuRuoePIvyS1WA8HmYdn+Ow7Ns8CjCvu0PvWfpigE2Wtb5vB3Bp1DZ9JQLkjSvhdyXnTuumqTneUCYAK4nk7JTW+ZQOC9CdJdr4QnIEdAszLOLKX3XO4NA78O0DYYyLXwoZskKEsrvllB8xAl3D5ZeP3v74N4MdZoMWyAb4VFV0zor3aEPIE4dRYxpsRmlryXLogCzHRw2alTdDC20LNeolc3ODVvebyZKtGjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SxnyLWkH2SjcB21lIu/S1P5yzePJsBjqUoxpfWUcXc=;
 b=Hm39EfOnh9y3aZ+WeauzjIkUarYpLMDUtDobgrdMnUCpE2eQX6ydv3dUsMCJiqg6pQyB31q4pTTLb7lfqEOoLA26LlQzm86zR25K3XueWnruwwZwfsh5f25NaGIsrOGJF6tizFTJKxu/Q/dRaWF6vYZYK9Dj3XiMh2GmVHaESx7sE6ZTD+HIuqnovFDbLi2scKzD7262qD3f163C7OIu/QgubxKOvwD/iJzIMQRpAAuWuV5RIVXSgZeZbE0cylrGh+39iaYlBwKG7Wp314gpAQFgOoSUo7nujekX2YxC3h/ugNpUyX9AJQjdRQoRZHVDjbZFULnBcfoKbRD59Q5t2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SxnyLWkH2SjcB21lIu/S1P5yzePJsBjqUoxpfWUcXc=;
 b=Z4e+c7aKlSxu+DmsmNJrPIsG/Wg/dOdyyuKdsdXMlCbS1UkTuEnMF3vFKwXdKhg6BXc/AUCgC3/p/LmXI2nmBZtkRjkFho26B40tQm4UFhBxIW+9haPSdSqLC7ISawLTvxnmL9hvuDIfSy8IAWfrp1093FD+Vapc1UoLixS1/oYt/XvefjqExyTps4w0lqfz4WtvAMZgvCbQynoGUlnuwox14QbUrjMZM0Pbw8VT8Ocn331g2LPvyk1e48H+nXzA36g+oRWtNOwmLKQ23tRPUGO1n5CaVuZ5czZamZQwL8VaM+8EfeN9lWswch9Mzil3JAd6SS8lJCNh5gYrlDa6hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7953.eurprd04.prod.outlook.com (2603:10a6:20b:246::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 09:41:35 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 09:42:06 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 14/14] net: dsa: netc: add support for the standardized counters
Date: Mon, 16 Mar 2026 17:41:52 +0800
Message-Id: <20260316094152.1558671-15-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316094152.1558671-1-wei.fang@nxp.com>
References: <20260316094152.1558671-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM8PR04MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 8152cb1b-8146-4752-96b5-08de8340489a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|921020|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Xto4fGqT1FGKtY0iRVGr9wM6fCW92KazFXzSJV7cWtDm6xUPymjj50ETdMBT7qpv7y/Kf2ZKqJoiKCAgcO+tZ1QwB3byRGrNSgc9QS0A9nIP+vGA6+CSFZjlKZFAHfXb9ph+NnmT80pFJcXDMAILEoJABFwuWf7zgPKJXtpsNEn89itPx1hCrd1EjFEYzquMkoXySldm1629VtPMuT20F3x5Se3q6Ms6x8DAzZrawAwqhdpJhvlKDwtTdqV5r2lBwD//1qtJtl5fHwoLSuyjyc79OFGt4Il+vm6Ovsw2KzMTZwaYhAl9ht5lI2MDFjJHiPg1o5oP+uclIebu9wmdL80K4oLsvLANxK6aEPD+zc9LhMaUt2E7jS6jjDIz6+pJlKOlwIW8TlDSZ+pI4OObKBZWfGF9ztvU12QV9dict1wndhuAfdB+H5G+YeEX02QCtUttxA+xkNqGCoKkOII71dCIGTwpMUSIFAzH8YU9rQrwMFHq/ISaLGltAACvy9XGQfO0pJfnWPJ8XaCjhkWkx/TcMKsKRP82aXyxht4R67qUZSeSNzaHE9tZVvTHrpuq0Z/lF8pEkZ32Qd1jVuX3LBXGkjecNabOlheifw3kwpl/JtcDRvqLnvIv9+hj36Kb/AKXysP4t1KtMUVIk9NBZH6kkG2kSZ02jlACUE/aNSaMy0esrlrJa/wlwmN8hM07RFZpxLEziXvCMM/NvJ4KR7GDsKX1OxXlXazW5Z6AscAnRDV6Fjn0mmzlpU+Lp5iMNMD5RXFAE4mYXhvdEBH9nsOH/d8ytTrVv1rUwo+eONafppepBOGlmD2m2AG4wKlV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hVpMB47xJ4/K4qqJHKTfOT9HUgWTtWnTsLhzdaajTQvGNZCTIpkLykPp3XNP?=
 =?us-ascii?Q?xMB38EYubbTU+ExQGe0p/TsXQmUmCtJWldl1G+dAw0bpABEB3aexdZ15icd1?=
 =?us-ascii?Q?DC+jRKIZFCMDk+EN2nYrxEw6zlptqMBHbTqIHFf+E5nW0lMadBpyDqiz3cYw?=
 =?us-ascii?Q?tN113SMwE9/jad07jaLB4xftChUXVtOFpAbMLk4YCUCgFrprqnJ+efcLe30A?=
 =?us-ascii?Q?0/uZ2e/ODUw911PdT97EN9m8OLJO9lo6qS5lHvWA1OSYt34NPslV5IH9hbYA?=
 =?us-ascii?Q?3jfbFwbZ18r7jE8RQhSCB1MFCJOPwU1wJyb9T98KFBUFr7yFrlGjZVqoSb54?=
 =?us-ascii?Q?ilT0bIczSktX+B3pd/MrYau3KE9RptgoyQbtx6dFXAioUUBesVYnCfZyje8k?=
 =?us-ascii?Q?AkuoUjONM6AnlOKsHUdcsxu8aJ+NuHMkjFhyahNmPvDgmU/hP7524MRMiR4q?=
 =?us-ascii?Q?NwMMJlQt72H4ewatU7xwhwfSMgoIiltxybzyP4i4aSsNJEW9jq5JZW8QFdY6?=
 =?us-ascii?Q?onKXCMSSmQ5AuUVQU5qNjyrMMSnIeVBMmDu4fcN6LDmA8WpKx9xHaWas2QqO?=
 =?us-ascii?Q?uEUQZpG62CaLe9n5DwFo5TUPQBur1Oi1TaqBlkvczbZGCUPlA1cG02yvfJoP?=
 =?us-ascii?Q?x+zI1Qv5Eavq+Ai/mHZQt2FVtE94n3ADLBQjHs70MROVzLB6JfnnoIzc6/R5?=
 =?us-ascii?Q?NcfIGKD9Ib9DaAAe2oaNSdqgKkBSY174NnPce92rQDa2nq+J8+Edt/2qB4lW?=
 =?us-ascii?Q?sgHTVf0+I0C3ASwmJ8eBMKEawUcs5D/mxcbEY376p72gox2Smt3m9lPH1Hj1?=
 =?us-ascii?Q?7+knrX4Wyf/gFpITXKl0zIZcoi3SZUGHq43awItofMLNoKS3ICVmxoUdEKx6?=
 =?us-ascii?Q?MX/+OmPu57bbJ8E47ljsN0gcPZC/jQHSPES3/UaT9a706TVPNnKHiSSEWqA+?=
 =?us-ascii?Q?+WsFzcSRKZ5p190LZ9VVOsQaptfhE4fcSMIQKwDMQezhaOHDz0+/9Fz4Nf1W?=
 =?us-ascii?Q?t2mCD/DFVCPaOGzbRTtcQlUJQwT2fxuf5ZN7+0LfBhU3MbOelidSZkAd/jhp?=
 =?us-ascii?Q?qtnAWeMGPcCiGMO4L8IdOtMKUVit2L3X6a6yKud6iqJstMbOZaPuX2K7b+ua?=
 =?us-ascii?Q?I+UdlvGx9O4/0izH+bd/6SXe4BjJpJnfPznYh7od0xaLeYWZtC8Nw3w1VtE8?=
 =?us-ascii?Q?trSgCN1RR35Ntj1I4qjrxiFVl4IX8iK6zomMVGs49rVd28901caC1Zv+vVZp?=
 =?us-ascii?Q?I7wd8oGXzb+kfrE8z+28wmAyWmf3b5AGT2VShJBuLkHrnD/OfQpE+GPIuNx9?=
 =?us-ascii?Q?EGfzSZJrJLS4Sik2yqKmh08rRHYhuS1XUtTLMfLV/6Ngyt7IYtFVi346jo2t?=
 =?us-ascii?Q?+cPpvw4Xa7Bf9uIKDfTtWQ5+4MvMZ0VOf2R8wTBI8gtFEDszuApEWoTJUuEl?=
 =?us-ascii?Q?CoyqIheU2pV5KJfXtlfCs5tbP10IjYFUnO15czO8MjaBxkSOGQam86WLd/f6?=
 =?us-ascii?Q?mDwQfrM0VtwMpt5Mxdo2r9ssrzE4BROeRRzEoDJP37hWh+pxkC664Oyg5xtu?=
 =?us-ascii?Q?7Yvn87ZCPkZT9N51YiNHi89P1YwUXlY2L/rk1lLd1hi1jY3hLTSQzkYu/W6O?=
 =?us-ascii?Q?1frdmMMl8b0ei6rYKo7/loS0iJYTZf3+1JJ3jLrw9pvXlaxHlx89vSFLaqO+?=
 =?us-ascii?Q?ulh6W0LyL4JB0g8Mv0CClV2BLgomPuRFPlnQfS5c7rrG0wBOQSRk4WGTsatL?=
 =?us-ascii?Q?LkQc72N2pg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8152cb1b-8146-4752-96b5-08de8340489a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 09:42:06.0292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GViPWbHHRnDrHTnxSQBqO3LBxn0Bl5jj5nlB1800ha6n/tTucSUsHTXFHm8ziX+WMQVArZu7GjmiLKSor3pQkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7953

Each user port of the NETC switch supports 802.3 basic and mandatory
managed objects statistic counters and IETF Management Information
Database (MIB) package (RFC2665) and Remote Network Monitoring (RMON)
counters. And all of these counters are 64-bit registers. In addition,
some user ports support preemption, so these ports have two MACs, MAC
0 is the express MAC (eMAC), MAC 1 is the preemptible MAC (pMAC). So
for ports that support preemption, the statistics are the sum of the
pMAC and eMAC statistics.

Note that the current switch driver does not support preemption, all
frames are sent and received via the eMAC by default. The statistics
read from the pMAC should be zero.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/Makefile         |   2 +-
 drivers/net/dsa/netc/netc_ethtool.c   | 192 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_main.c      |   4 +
 drivers/net/dsa/netc/netc_switch.h    |  17 +++
 drivers/net/dsa/netc/netc_switch_hw.h | 153 ++++++++++++++++++++
 include/linux/fsl/netc_global.h       |   6 +
 6 files changed, 373 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/dsa/netc/netc_ethtool.c

diff --git a/drivers/net/dsa/netc/Makefile b/drivers/net/dsa/netc/Makefile
index 4a5767562574..f40b13c702e0 100644
--- a/drivers/net/dsa/netc/Makefile
+++ b/drivers/net/dsa/netc/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_NET_DSA_NETC_SWITCH) += nxp-netc-switch.o
-nxp-netc-switch-objs := netc_main.o netc_platform.o
+nxp-netc-switch-objs := netc_main.o netc_platform.o netc_ethtool.o
diff --git a/drivers/net/dsa/netc/netc_ethtool.c b/drivers/net/dsa/netc/netc_ethtool.c
new file mode 100644
index 000000000000..8e5861543d30
--- /dev/null
+++ b/drivers/net/dsa/netc/netc_ethtool.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP NETC switch driver
+ * Copyright 2025-2026 NXP
+ */
+
+#include <linux/ethtool_netlink.h>
+
+#include "netc_switch.h"
+
+static void netc_port_pause_stats(struct netc_port *np,
+				  enum netc_port_mac mac,
+				  struct ethtool_pause_stats *stats)
+{
+	if (mac == NETC_PORT_PMAC && !np->caps.pmac)
+		return;
+
+	stats->tx_pause_frames = netc_port_rd64(np, NETC_PM_TXPF(mac));
+	stats->rx_pause_frames = netc_port_rd64(np, NETC_PM_RXPF(mac));
+}
+
+void netc_port_get_pause_stats(struct dsa_switch *ds, int port,
+			       struct ethtool_pause_stats *pause_stats)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct net_device *ndev;
+
+	switch (pause_stats->src) {
+	case ETHTOOL_MAC_STATS_SRC_EMAC:
+		netc_port_pause_stats(np, NETC_PORT_EMAC, pause_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		netc_port_pause_stats(np, NETC_PORT_PMAC, pause_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
+		ndev = dsa_to_port(ds, port)->user;
+		ethtool_aggregate_pause_stats(ndev, pause_stats);
+		break;
+	}
+}
+
+static const struct ethtool_rmon_hist_range netc_rmon_ranges[] = {
+	{   64,   64 },
+	{   65,  127 },
+	{  128,  255 },
+	{  256,  511 },
+	{  512, 1023 },
+	{ 1024, 1522 },
+	{ 1523, NETC_MAX_FRAME_LEN },
+	{ }
+};
+
+static void netc_port_rmon_stats(struct netc_port *np,
+				 enum netc_port_mac mac,
+				 struct ethtool_rmon_stats *stats)
+{
+	if (mac == NETC_PORT_PMAC && !np->caps.pmac)
+		return;
+
+	stats->undersize_pkts = netc_port_rd64(np, NETC_PM_RUND(mac));
+	stats->oversize_pkts = netc_port_rd64(np, NETC_PM_ROVR(mac));
+	stats->fragments = netc_port_rd64(np, NETC_PM_RFRG(mac));
+	stats->jabbers = netc_port_rd64(np, NETC_PM_RJBR(mac));
+
+	stats->hist[0] = netc_port_rd64(np, NETC_PM_R64(mac));
+	stats->hist[1] = netc_port_rd64(np, NETC_PM_R127(mac));
+	stats->hist[2] = netc_port_rd64(np, NETC_PM_R255(mac));
+	stats->hist[3] = netc_port_rd64(np, NETC_PM_R511(mac));
+	stats->hist[4] = netc_port_rd64(np, NETC_PM_R1023(mac));
+	stats->hist[5] = netc_port_rd64(np, NETC_PM_R1522(mac));
+	stats->hist[6] = netc_port_rd64(np, NETC_PM_R1523X(mac));
+
+	stats->hist_tx[0] = netc_port_rd64(np, NETC_PM_T64(mac));
+	stats->hist_tx[1] = netc_port_rd64(np, NETC_PM_T127(mac));
+	stats->hist_tx[2] = netc_port_rd64(np, NETC_PM_T255(mac));
+	stats->hist_tx[3] = netc_port_rd64(np, NETC_PM_T511(mac));
+	stats->hist_tx[4] = netc_port_rd64(np, NETC_PM_T1023(mac));
+	stats->hist_tx[5] = netc_port_rd64(np, NETC_PM_T1522(mac));
+	stats->hist_tx[6] = netc_port_rd64(np, NETC_PM_T1523X(mac));
+}
+
+void netc_port_get_rmon_stats(struct dsa_switch *ds, int port,
+			      struct ethtool_rmon_stats *rmon_stats,
+			      const struct ethtool_rmon_hist_range **ranges)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct net_device *ndev;
+
+	*ranges = netc_rmon_ranges;
+
+	switch (rmon_stats->src) {
+	case ETHTOOL_MAC_STATS_SRC_EMAC:
+		netc_port_rmon_stats(np, NETC_PORT_EMAC, rmon_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		netc_port_rmon_stats(np, NETC_PORT_PMAC, rmon_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
+		ndev = dsa_to_port(ds, port)->user;
+		ethtool_aggregate_rmon_stats(ndev, rmon_stats);
+		break;
+	}
+}
+
+static void netc_port_ctrl_stats(struct netc_port *np,
+				 enum netc_port_mac mac,
+				 struct ethtool_eth_ctrl_stats *stats)
+{
+	if (mac == NETC_PORT_PMAC && !np->caps.pmac)
+		return;
+
+	stats->MACControlFramesTransmitted =
+		netc_port_rd64(np, NETC_PM_TCNP(mac));
+	stats->MACControlFramesReceived =
+		netc_port_rd64(np, NETC_PM_RCNP(mac));
+}
+
+void netc_port_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
+				  struct ethtool_eth_ctrl_stats *ctrl_stats)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct net_device *ndev;
+
+	switch (ctrl_stats->src) {
+	case ETHTOOL_MAC_STATS_SRC_EMAC:
+		netc_port_ctrl_stats(np, NETC_PORT_EMAC, ctrl_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		netc_port_ctrl_stats(np, NETC_PORT_PMAC, ctrl_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
+		ndev = dsa_to_port(ds, port)->user;
+		ethtool_aggregate_ctrl_stats(ndev, ctrl_stats);
+		break;
+	}
+}
+
+static void netc_port_mac_stats(struct netc_port *np,
+				enum netc_port_mac mac,
+				struct ethtool_eth_mac_stats *stats)
+{
+	if (mac == NETC_PORT_PMAC && !np->caps.pmac)
+		return;
+
+	stats->FramesTransmittedOK = netc_port_rd64(np, NETC_PM_TFRM(mac));
+	stats->SingleCollisionFrames = netc_port_rd64(np, NETC_PM_TSCOL(mac));
+	stats->MultipleCollisionFrames =
+		netc_port_rd64(np, NETC_PM_TMCOL(mac));
+	stats->FramesReceivedOK = netc_port_rd64(np, NETC_PM_RFRM(mac));
+	stats->FrameCheckSequenceErrors =
+		netc_port_rd64(np, NETC_PM_RFCS(mac));
+	stats->AlignmentErrors = netc_port_rd64(np, NETC_PM_RALN(mac));
+	stats->OctetsTransmittedOK = netc_port_rd64(np, NETC_PM_TEOCT(mac));
+	stats->FramesWithDeferredXmissions =
+		netc_port_rd64(np, NETC_PM_TDFR(mac));
+	stats->LateCollisions = netc_port_rd64(np, NETC_PM_TLCOL(mac));
+	stats->FramesAbortedDueToXSColls =
+		netc_port_rd64(np, NETC_PM_TECOL(mac));
+	stats->FramesLostDueToIntMACXmitError =
+		netc_port_rd64(np, NETC_PM_TERR(mac));
+	stats->OctetsReceivedOK = netc_port_rd64(np, NETC_PM_REOCT(mac));
+	stats->FramesLostDueToIntMACRcvError =
+		netc_port_rd64(np, NETC_PM_RDRNTP(mac));
+	stats->MulticastFramesXmittedOK =
+		netc_port_rd64(np, NETC_PM_TMCA(mac));
+	stats->BroadcastFramesXmittedOK =
+		netc_port_rd64(np, NETC_PM_TBCA(mac));
+	stats->MulticastFramesReceivedOK =
+		netc_port_rd64(np, NETC_PM_RMCA(mac));
+	stats->BroadcastFramesReceivedOK =
+		netc_port_rd64(np, NETC_PM_RBCA(mac));
+}
+
+void netc_port_get_eth_mac_stats(struct dsa_switch *ds, int port,
+				 struct ethtool_eth_mac_stats *mac_stats)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct net_device *ndev;
+
+	switch (mac_stats->src) {
+	case ETHTOOL_MAC_STATS_SRC_EMAC:
+		netc_port_mac_stats(np, NETC_PORT_EMAC, mac_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		netc_port_mac_stats(np, NETC_PORT_PMAC, mac_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
+		ndev = dsa_to_port(ds, port)->user;
+		ethtool_aggregate_mac_stats(ndev, mac_stats);
+		break;
+	}
+}
diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 15dd8d89f66d..bb8e89bae758 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -1470,6 +1470,10 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.port_mdb_add			= netc_port_mdb_add,
 	.port_mdb_del			= netc_port_mdb_del,
 	.port_set_host_flood		= netc_port_set_host_flood,
+	.get_pause_stats		= netc_port_get_pause_stats,
+	.get_rmon_stats			= netc_port_get_rmon_stats,
+	.get_eth_ctrl_stats		= netc_port_get_eth_ctrl_stats,
+	.get_eth_mac_stats		= netc_port_get_eth_mac_stats,
 };
 
 static int netc_switch_probe(struct pci_dev *pdev,
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 7ebffb136b2f..825601847c89 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -70,6 +70,11 @@ struct netc_port {
 	struct ipft_entry_data *host_flood;
 };
 
+enum netc_port_mac {
+	NETC_PORT_EMAC = 0,
+	NETC_PORT_PMAC,
+};
+
 struct netc_switch_regs {
 	void __iomem *base;
 	void __iomem *port;
@@ -110,6 +115,7 @@ struct netc_switch {
 
 /* Write/Read registers of Switch Port (including pseudo MAC port) */
 #define netc_port_rd(p, o)		netc_read((p)->iobase + (o))
+#define netc_port_rd64(p, o)		netc_read64((p)->iobase + (o))
 #define netc_port_wr(p, o, v)		netc_write((p)->iobase + (o), v)
 
 /* Write/Read Switch global registers */
@@ -135,4 +141,15 @@ static inline void netc_del_fdb_entry(struct netc_fdb_entry *entry)
 
 int netc_switch_platform_probe(struct netc_switch *priv);
 
+/* ethtool APIs */
+void netc_port_get_pause_stats(struct dsa_switch *ds, int port,
+			       struct ethtool_pause_stats *pause_stats);
+void netc_port_get_rmon_stats(struct dsa_switch *ds, int port,
+			      struct ethtool_rmon_stats *rmon_stats,
+			      const struct ethtool_rmon_hist_range **ranges);
+void netc_port_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
+				  struct ethtool_eth_ctrl_stats *ctrl_stats);
+void netc_port_get_eth_mac_stats(struct dsa_switch *ds, int port,
+				 struct ethtool_eth_mac_stats *mac_stats);
+
 #endif
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index 7ef870fbba4d..9be859d20675 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -193,6 +193,159 @@ enum netc_stg_stage {
 #define   SSP_1G			2
 #define  PM_IF_MODE_ENA			BIT(15)
 
+/* Port MAC 0/1 Receive Ethernet Octets Counter */
+#define NETC_PM_REOCT(a)		(0x1100 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Octets Counter */
+#define NETC_PM_ROCT(a)			(0x1108 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Alignment Error Counter Register */
+#define NETC_PM_RALN(a)			(0x1110 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Valid Pause Frame Counter */
+#define NETC_PM_RXPF(a)			(0x1118 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Frame Counter */
+#define NETC_PM_RFRM(a)			(0x1120 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Frame Check Sequence Error Counter */
+#define NETC_PM_RFCS(a)			(0x1128 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive VLAN Frame Counter */
+#define NETC_PM_RVLAN(a)		(0x1130 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Frame Error Counter */
+#define NETC_PM_RERR(a)			(0x1138 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Unicast Frame Counter */
+#define NETC_PM_RUCA(a)			(0x1140 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Multicast Frame Counter */
+#define NETC_PM_RMCA(a)			(0x1148 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Broadcast Frame Counter */
+#define NETC_PM_RBCA(a)			(0x1150 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Dropped Packets Counter */
+#define NETC_PM_RDRP(a)			(0x1158 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Packets Counter */
+#define NETC_PM_RPKT(a)			(0x1160 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Undersized Packet Counter */
+#define NETC_PM_RUND(a)			(0x1168 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 64-Octet Packet Counter */
+#define NETC_PM_R64(a)			(0x1170 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 65 to 127-Octet Packet Counter */
+#define NETC_PM_R127(a)			(0x1178 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 128 to 255-Octet Packet Counter */
+#define NETC_PM_R255(a)			(0x1180 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 256 to 511-Octet Packet Counter */
+#define NETC_PM_R511(a)			(0x1188 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 512 to 1023-Octet Packet Counter */
+#define NETC_PM_R1023(a)		(0x1190 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 1024 to 1522-Octet Packet Counter */
+#define NETC_PM_R1522(a)		(0x1198 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive 1523 to Max-Octet Packet Counter */
+#define NETC_PM_R1523X(a)		(0x11a0 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Oversized Packet Counter */
+#define NETC_PM_ROVR(a)			(0x11a8 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Jabber Packet Counter */
+#define NETC_PM_RJBR(a)			(0x11b0 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Fragment Packet Counter */
+#define NETC_PM_RFRG(a)			(0x11b8 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Control Packet Counter */
+#define NETC_PM_RCNP(a)			(0x11c0 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Dropped Not Truncated Packets Counter */
+#define NETC_PM_RDRNTP(a)		(0x11c8 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Ethernet Octets Counter */
+#define NETC_PM_TEOCT(a)		(0x1200 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Octets Counter */
+#define NETC_PM_TOCT(a)			(0x1208 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Valid Pause Frame Counter */
+#define NETC_PM_TXPF(a)			(0x1218 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Frame Counter */
+#define NETC_PM_TFRM(a)			(0x1220 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Frame Check Sequence Error Counter */
+#define NETC_PM_TFCS(a)			(0x1228 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit VLAN Frame Counter */
+#define NETC_PM_TVLAN(a)		(0x1230 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Frame Error Counter */
+#define NETC_PM_TERR(a)			(0x1238 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Unicast Frame Counter */
+#define NETC_PM_TUCA(a)			(0x1240 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Multicast Frame Counter */
+#define NETC_PM_TMCA(a)			(0x1248 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Broadcast Frame Counter */
+#define NETC_PM_TBCA(a)			(0x1250 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Packets Counter */
+#define NETC_PM_TPKT(a)			(0x1260 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Undersized Packet Counter */
+#define NETC_PM_TUND(a)			(0x1268 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 64-Octet Packet Counter */
+#define NETC_PM_T64(a)			(0x1270 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 65 to 127-Octet Packet Counter */
+#define NETC_PM_T127(a)			(0x1278 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 128 to 255-Octet Packet Counter */
+#define NETC_PM_T255(a)			(0x1280 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 256 to 511-Octet Packet Counter */
+#define NETC_PM_T511(a)			(0x1288 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 512 to 1023-Octet Packet Counter */
+#define NETC_PM_T1023(a)		(0x1290 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 1024 to 1522-Octet Packet Counter */
+#define NETC_PM_T1522(a)		(0x1298 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit 1523 to TX_MTU-Octet Packet Counter */
+#define NETC_PM_T1523X(a)		(0x12a0 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Control Packet Counter */
+#define NETC_PM_TCNP(a)			(0x12c0 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Deferred Packet Counter */
+#define NETC_PM_TDFR(a)			(0x12d0 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Multiple Collisions Counter */
+#define NETC_PM_TMCOL(a)		(0x12d8 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Single Collision */
+#define NETC_PM_TSCOL(a)		(0x12e0 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Late Collision Counter */
+#define NETC_PM_TLCOL(a)		(0x12e8 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Excessive Collisions Counter */
+#define NETC_PM_TECOL(a)		(0x12f0 + (a) * 0x400)
+
 #define NETC_PEMDIOCR			0x1c00
 #define NETC_EMDIO_BASE			NETC_PEMDIOCR
 
diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
index fdecca8c90f0..5b8ff528d369 100644
--- a/include/linux/fsl/netc_global.h
+++ b/include/linux/fsl/netc_global.h
@@ -5,6 +5,7 @@
 #define __NETC_GLOBAL_H
 
 #include <linux/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 static inline u32 netc_read(void __iomem *reg)
 {
@@ -16,4 +17,9 @@ static inline void netc_write(void __iomem *reg, u32 val)
 	iowrite32(val, reg);
 }
 
+static inline u64 netc_read64(void __iomem *reg)
+{
+	return ioread64(reg);
+}
+
 #endif
-- 
2.34.1



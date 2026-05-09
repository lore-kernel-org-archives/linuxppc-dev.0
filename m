Return-Path: <linuxppc-dev+bounces-20647-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE6BCD343F
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2026 10:29:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gCMg96Mzbz2yFt;
	Sat, 09 May 2026 20:29:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778322581;
	cv=pass; b=V9GXXDwV50pbwsE17MS1qp22q7uKZbc8uyKwnp+19CVmhghVd8V8BP3KhJA+rCayTCbOUsZdCT3xMcx3mSMpJDJv7bLnMhufs2Scenvd7fC97jiqcxXf0UkOTAHhCJcHWT2ieR4StBKtnE7Xrwk6rtmF/UK3TQ4UuIXRKzBBz/Pdbmut7x0MzwReDKa5bb5OTUTGYScN4wTXU+XsA0hRM5UvjzMbCxohKvaFERR1Lzx5K/SPJ6BjTvDNSCnj9n9CjgyhEX4mArcSoKBCBJtkWVIhLfB+VCLtwmRpE5VWZKkLYRv/UkAWvwsEFFjvuV2GIsZc2M0EKTLGLEKbiATvQg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778322581; c=relaxed/relaxed;
	bh=pS/gXCRD74gK9HSAuhkaQK3Y2u0LGgjAR2QA6My9Rdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SejvCw0QRSRzhVZ2unfS/Bkhsl5SMX2/1afvW1wvu4W8W+oQfPMv5+Eoo7DKQ05YBOXrD7dUmI17tFidsw+IiHDNde4KUqgwO8hjZb+m/6T4xh8GjAgu9HfV9ZKeJxW7YmM5A/K5nq+oS1jYhj5SC95GgJg6+2NwdLx3pYo1DwdxxKehQ/2a2iTGzCbmyVbg/BzA7glUg+NcIHPCN9kwIKIOlK4LhyLaoV/TL6LV2OrAXcoPWvdlxXVTtzpJwk/OQFdmaTO0B9S4p8wPgr6f9V0F9cWDbla/BGHNihVbVZ4lgUueo3ag7HN3p5cUBMiAnSNNTNX2ypPkpeY9+ear3Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=FwgDzRqS; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=FwgDzRqS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gCMg83h3Rz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2026 20:29:40 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlLXNzkBfXHYFF/jhcaBz8tgNnepEBFs2dCqfKROTXvIiHuRpt9cYOrl//c1PB9OG2kuxRevzg7sYemgy+PNFbAzO31FgHOT7+hGHYGBv124l8AvQWOa7+to6oxBgS3Qe4Zw0q7Yi2HLuKiO60+4fLhoGEwDzMdHrQcVF8a9K2NgigUb3Lnz5OwkGYEIrA+av0M3bhg8M6Qle2YKFGOXKL8rDtTwCl9eB/9nHOswsWgGc+ShBMLO8/salvVYj0hI2axuH0LieFcyKDtxnRJutWaM/L6IWjjFope4wOnW32c/Ecn7i0j6ka1nM/QfXLDmGJBWW7wE+vt+4SZanRzFrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pS/gXCRD74gK9HSAuhkaQK3Y2u0LGgjAR2QA6My9Rdg=;
 b=measkdIzf3V9/F7O5vyno9ILiInZ7byccLDqoEE8UkktfVkZNkQmpomtOiU15rmZYdhTvvtErtgYJhel3KSkqnidSP+lGL/LKmchpZnkeBVC/py2wSlkv8ud59GF6Xie3mgxINA+AdcmE5lNQcdC4mYctNC/BN89ZY7HRMNsHl3AheNj/Zak65tAJvthDJGeH8UFNLUeRDfSMpDzJmmkHr9KvQo1qX18S/ybhsRiU0c+mMtQXVM1coagp53URWzY6bR/oiVZ36Xmjez8Vbo9yVE9iHX03g0b03npuk3i5sWImIWjgLnpACOEihIH+mFroktSh+WTruKFN1/n01RYYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pS/gXCRD74gK9HSAuhkaQK3Y2u0LGgjAR2QA6My9Rdg=;
 b=FwgDzRqS0Jt4X2uCjMqhJeZuOoxCmGykIzSaJz7LoQknEwHVTNCPXzllIFuEUlR/zlTOXkPsAub48oSZVIfWoe0wLxXkLhjrzM//8aams99CxQNaawrjapHUq1rlOPWEGLohyNqG2vD7APnavr+jo1C32+h2o4I4Sqtu4CY/maPRDGggAu+bZhuycLzA3X9QLkZMazsqzrtpD3m0GpidhDLZzzioJlnycVb8FRZ0az08UVy6Tdh4VkS+bpymmzSeu8DjTUVYfu+xkRsbv0N9RMVRaFB/4273RiPqKNRGEjyXgvQkaiB34uSXs5l8s9K5V20ilfXlwg5gxc9sB6nU8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by DU4PR04MB10385.eurprd04.prod.outlook.com (2603:10a6:10:56d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 10:29:18 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 10:29:17 +0000
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
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v6 net-next 14/15] net: dsa: netc: add support for the standardized counters
Date: Sat,  9 May 2026 18:29:53 +0800
Message-Id: <20260509102954.4116624-15-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509102954.4116624-1-wei.fang@nxp.com>
References: <20260509102954.4116624-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|DU4PR04MB10385:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb62232-be28-4b5e-c141-08deadb5d31f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|19092799006|18002099003|22082099003|921020|38350700014|56012099003;
X-Microsoft-Antispam-Message-Info:
	nPFrol6yH4+TmvRES6ntO80TSwjbUFDVWVlZB7TYDpEVC7fu0yZlHjz1D281uTqqff/Xy10/mrijy4oyMtWfQl6z8ZZVPBrMZbQSrG3GwaEESgjsLD1xG6gP7pILBmY0RyBYYGxq4ERAMKBvZK/SlpJ+AuDGYx+0EiOZwodHrNnXtJZnFUuydN121ztGvVmDBFcoEN4IKFgbVv4jmBepLVM/wS5YOpypWA0UzgXChKkJGs3bpI1QKMeelhcOCGXZ8H39dqlh0NrcZ3jPRJP8462dDnJEfvkMSX/qYKLZ5DsUY6B2EkuAWeJttjo9OJbB1sQFIMoHyWdBVxJ/u9ZIJrBbnNMrFzCC0QQdqhIuW6N14zAFaYjDJU4UZoKCKrDS74Wkt47HJo/iUvaivv9RXAPHVJ+gGBSZtuyjvcrtsOfmh96IsW6n8FdNaagir/eyLuH0cuJD8f/IIJRURLH64kZ4h0L24BxEXfHJMmyXs0guJQePReVDmUxF2DVAXsWujOGbD9lBEceKc5fHi+ZAp2Wgz3A1w0ZouoHgdx9is9kDMapiC6EhLVV4rgotBvfueUxeO9P+Pj2EZue4RvRSM80Wo45I69KTlJRgo63gEk8feDXjWrjcaxeK6cUCUl/VXWIrndTsm+Z16BkxAXqq8t6egrSTEIqhhyx8KIFTNOtvLLR8ujPW6RZ7rO+vCbvmDZbow7CGdcB0s2I/Ye7UI1c6V/qJbmcx58USBGaGwfn7Xi/y49hvpY/L8WACRfmQfT2XAmLrSNxcjYyZJMk9zA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(19092799006)(18002099003)(22082099003)(921020)(38350700014)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?22XjnA8pL9oX4g2sYF+dHftTrEahuB4c1ilqJ/mu3OP4SHlISNUFcpmg8N0M?=
 =?us-ascii?Q?D5Xs+1kce4hUdyOqF5A5ufQAAa4JLTicwUep4r2y0czJtC7Fw5QvppqDX0p/?=
 =?us-ascii?Q?6CQWmoi8VbN8ophJusaK251ItVMXGRFFjfQnpxOmPtdZioaKH9L2sPxuUGg0?=
 =?us-ascii?Q?lWDctyy3XtF86hpH8HlBvwo/7nRsrNaEttjpnIY+oTZxHRbmem9mD8Q2MZYu?=
 =?us-ascii?Q?U4p7G2RPLAc0ubzso0qDj24MKqiM6ITFGkfw8lO+GqifUyCdTG9qe7wWZUij?=
 =?us-ascii?Q?OX1oRaB3eAMeSMwTDxFmzymH13JDfZHOiJ4RmqkWf0oWdbpsgQvfcfxnJdsM?=
 =?us-ascii?Q?96AcTtRBvUTBlVLMAv5thg4eBxCDVOHMs8o5HYhFv8Vzv+fYR03oorbPAJrg?=
 =?us-ascii?Q?yz3phXkV0fFrl75VNMd50rAoe/eWiIYKfaFixHh5VKuZpFl4efdHUYymaJOW?=
 =?us-ascii?Q?e/Vnr4WOvpKhRCuZuhaOQUJz5eRbDB/cE9R/aSjh7YJDFqiYJ3ikCldtprfU?=
 =?us-ascii?Q?gJPPkZZesfxV2a1qkpbwMqXPjkMXl4b9edRelTwuNQxWbt4daqBgy4PP4Gcq?=
 =?us-ascii?Q?1sDA04v8WCfIfP2Rns3A47b+0Bl8/CCD0xeDPQdq4lA2j9T1PuU16EW4AmIf?=
 =?us-ascii?Q?xvAq1aqS72px3ExPpFNqQ+58ycZsRZCiWz1qoJDUeQSh3SgqT1DV975PcL8E?=
 =?us-ascii?Q?1NVzKJnYIKBA4eRUE1BGuUBVtdn0x3XxDQeVcXyLMapggFoOkH0jd0DseRhj?=
 =?us-ascii?Q?2NuyTrZ0y6c96l51gPrWrawD/CnGHWycHkSJyLIwEGZqWPdW3GJfFRe72ura?=
 =?us-ascii?Q?7XRASTF9X1yVw4WRHmmyg0kJOeQBIMQ/zF79A243LLakrzaPil6/xPr9QvdN?=
 =?us-ascii?Q?RxrxNPUI6/v+7E93urxLfsfWaYrFtshcIGEF5UU3ZMxZERLU+7rMQx182RPf?=
 =?us-ascii?Q?Re6r1tL6I640mdWmF2dWyEtusr/0R1Marq1IpzOIAiFo8sK9uYjACweQq/Uf?=
 =?us-ascii?Q?U9Ju9/y1N8RMHtO7+sx+4zDJqqWXMKS4IPNwakHxP6VjWq5sR3DJQJk07F9I?=
 =?us-ascii?Q?JRhk+XSL3fcdDMt5S2OUgBlK2TjRDXL9Fc+Ky/VSpWd93XMJ5OXo5XaZQHKn?=
 =?us-ascii?Q?bk1pnXUgFOHBd1AxYGT/S7r84GJDvj24N3IgRGA2ToiIVyg1AxFNKT2exP1P?=
 =?us-ascii?Q?TOQim5c60wofznUF1p4R7FsRg6o/i2Pj8E9OaTdD2jV7rRLeACGVJ1ShBbiQ?=
 =?us-ascii?Q?lnGRVyLAjGZ3zQvKRdo4w73fWl+8ATp5uFspstIR94qeHb6fWK4XEfmxOel3?=
 =?us-ascii?Q?k/y6ggoADbsZZ3RiTb1/OkPXNNx3UtUwoXxOXSQtXOR3iJhT4O7lqxVlTg8u?=
 =?us-ascii?Q?qsMveVekO7g4hvmENdqjmkiRWG7b2CG1KraeBAzG6LXBXxxJfvbn/7//vy9P?=
 =?us-ascii?Q?RldhM5V44HnI0ZnAOnj/AsgR8f4vO9IL7aqezVTssR+0WIuegwA2C5DPLy9m?=
 =?us-ascii?Q?PY1J1MPYxffMQ8yaXr8kekrWlywh6YYDCMhbRq7I0Pkb+QPCNJmf7S6s8pDG?=
 =?us-ascii?Q?jz0WzyvHtSwv7/J+gEPuy43h3Tfbq/RiXu7xH2oIsspDBbBD0j7jkg27RmKV?=
 =?us-ascii?Q?+eMyRoJSLQ9EyOw7dIGeFH2VW2Edh7dw8aLWYzsl5N7ZJdeeVbRZFT+RisW7?=
 =?us-ascii?Q?GgvujgOgNvzhqLk/Dg1vJk1Iq7XLp7RpTCOewSQZNmK5EFRX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb62232-be28-4b5e-c141-08deadb5d31f
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 10:29:17.8572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tg/4S0gVkS1AK/th6Is6NIETWRznVQ2FAP+Gv0ZiQua67fGQp+Gw2nBJaP8Iqt8KKFU+4r3bYWJL72Rh7jzjow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10385

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
 drivers/net/dsa/netc/netc_ethtool.c   | 190 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_main.c      |   4 +
 drivers/net/dsa/netc/netc_switch.h    |  12 ++
 drivers/net/dsa/netc/netc_switch_hw.h | 120 ++++++++++++++++
 include/linux/fsl/netc_global.h       |   6 +
 6 files changed, 333 insertions(+), 1 deletion(-)
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
index 000000000000..ac8940b5a85c
--- /dev/null
+++ b/drivers/net/dsa/netc/netc_ethtool.c
@@ -0,0 +1,190 @@
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
+static void netc_port_pause_stats(struct netc_port *np, int mac,
+				  struct ethtool_pause_stats *stats)
+{
+	if (mac && !np->caps.pmac)
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
+		netc_port_pause_stats(np, 0, pause_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		netc_port_pause_stats(np, 1, pause_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
+		ndev = dsa_to_port(ds, port)->user;
+		ethtool_aggregate_pause_stats(ndev, pause_stats);
+		break;
+	}
+}
+
+static void netc_port_rmon_stats(struct netc_port *np, int mac,
+				 struct ethtool_rmon_stats *stats)
+{
+	if (mac && !np->caps.pmac)
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
+		netc_port_rmon_stats(np, 0, rmon_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		netc_port_rmon_stats(np, 1, rmon_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
+		ndev = dsa_to_port(ds, port)->user;
+		ethtool_aggregate_rmon_stats(ndev, rmon_stats);
+		break;
+	}
+}
+
+static void netc_port_ctrl_stats(struct netc_port *np, int mac,
+				 struct ethtool_eth_ctrl_stats *stats)
+{
+	if (mac && !np->caps.pmac)
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
+		netc_port_ctrl_stats(np, 0, ctrl_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		netc_port_ctrl_stats(np, 1, ctrl_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
+		ndev = dsa_to_port(ds, port)->user;
+		ethtool_aggregate_ctrl_stats(ndev, ctrl_stats);
+		break;
+	}
+}
+
+static void netc_port_mac_stats(struct netc_port *np, int mac,
+				struct ethtool_eth_mac_stats *stats)
+{
+	if (mac && !np->caps.pmac)
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
+	stats->FramesWithExcessiveDeferral =
+		netc_port_rd64(np, NETC_PM_TEDFR(mac));
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
+		netc_port_mac_stats(np, 0, mac_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		netc_port_mac_stats(np, 1, mac_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
+		ndev = dsa_to_port(ds, port)->user;
+		ethtool_aggregate_mac_stats(ndev, mac_stats);
+		break;
+	}
+}
diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 43486b464c17..338f2421ccb4 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -1463,6 +1463,10 @@ static const struct dsa_switch_ops netc_switch_ops = {
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
index 4a9bf69907e9..40e54af0c356 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -124,6 +124,7 @@ struct netc_switch {
 
 /* Write/Read registers of Switch Port (including pseudo MAC port) */
 #define netc_port_rd(p, o)		netc_read((p)->iobase + (o))
+#define netc_port_rd64(p, o)		netc_read64((p)->iobase + (o))
 #define netc_port_wr(p, o, v)		netc_write((p)->iobase + (o), v)
 
 /* Write/Read Switch global registers */
@@ -149,4 +150,15 @@ static inline void netc_del_fdb_entry(struct netc_fdb_entry *entry)
 
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
index caf5977c5100..f8d436ad9623 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -173,6 +173,126 @@ enum netc_stg_stage {
 #define   SSP_10M			1
 #define   SSP_1G			2
 
+/* Port MAC 0/1 Receive Ethernet Octets Counter */
+#define NETC_PM_REOCT(a)		(0x1100 + (a) * 0x400)
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
+/* Port MAC 0/1 Receive Multicast Frame Counter */
+#define NETC_PM_RMCA(a)			(0x1148 + (a) * 0x400)
+
+/* Port MAC 0/1 Receive Broadcast Frame Counter */
+#define NETC_PM_RBCA(a)			(0x1150 + (a) * 0x400)
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
+/* Port MAC 0/1 Transmit Excessive Deferral Packet Counter */
+#define NETC_PM_TEDFR(a)		(0x1210 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Valid Pause Frame Counter */
+#define NETC_PM_TXPF(a)			(0x1218 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Frame Counter */
+#define NETC_PM_TFRM(a)			(0x1220 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Frame Error Counter */
+#define NETC_PM_TERR(a)			(0x1238 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Multicast Frame Counter */
+#define NETC_PM_TMCA(a)			(0x1248 + (a) * 0x400)
+
+/* Port MAC 0/1 Transmit Broadcast Frame Counter */
+#define NETC_PM_TBCA(a)			(0x1250 + (a) * 0x400)
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



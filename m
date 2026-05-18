Return-Path: <linuxppc-dev+bounces-21094-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE74CD4F49
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 08:25:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJrTl3PHsz2yRM;
	Mon, 18 May 2026 18:25:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779092731;
	cv=pass; b=k9qgCimBMzRcBWVa+IeU/3eydVf/Qj/+FWoZlUES+lSDLxtrMgtCPdENXfewOpxrDh8DpUT+A4ugwQgCLMMjHINGlS40OKDXq0Vdlp6eSdMaQdQzTe1/EdGpE3Mib331Bp8biEzpQmJgqaPpJbPTkxpDrGMCfxh403qSppx+KXD3Qbtj8mp+YAypnVLWwk1s0uPziLjCiYZvOCRIyVqIixG0eo/XvGDO26XS7EyliORcBpGJFf4oBxdFbcgQCQqC3WcjGvek2k1/Jvf4p34CJbj79oGHZdwDeGHV1sSldYqhAuphdqXzntrVv9lJeaUbc4MpVWnXbu/cn53KdUaeLg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779092731; c=relaxed/relaxed;
	bh=EIqUGwxPpCxMtdW3tf8PcotPcwon6/iwnYO/Awlhijg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L4dAUyPxM6lQ4fBRQvEieGvauFrjZZ/ZFH0RxoFnXIt4eNXVRXDL7hMIgIGpJw2bQUF3phR3yTCMGmd62prHvsw15ivOoy75NGij8orOm4wfD2gdloQH2zC7TtgYQXAIC5E2pFxdhXBjsKV0W4kNPcfL6wJndiWVOZW/1gbwHpvRa25z0mO1Kazp8Od/+AGZx+1mB9LHux1BCnvNhXrXgAkLsVFNHZM/ZTlFYzdQOWYYWsRRWa1RPCb9fwnylEYkFdTm9pRGZ3Bmk0OcYhP86BeCB6zKty3XtysV/PaSCJ9IPv7yjbuSneFj3URg5pBIz1X7Ox1Av2nLBv2xWamu6g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=J6EprUCy; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=J6EprUCy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJrTk17T7z2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 18:25:30 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdYAUQXDVDAVsdlnoXo+Ca9MxDggEkR9psyr+w/tuUTPWTyugNbFxRKOgmlGiNjmc3PMCDbH7v9DrxHsJKiqMU5+08IrW5I7M0XuFI2MDSyrHO1uQo7NgSwEyjglk2BkKcfjTsX+z/W9tiVqam2QAtsUY1YHOasxi4te73fYMSe7YevQzSgirnSdM4yy3r4esbhqz1qAzA7FjHqz6iiks+50I8xgiamFd/HDd8F7XGw/h60fEjSGQ6SwIw3DVUjpIs03t46LsYYYjQO789FVZgutw7NQIFQZHuEkwP+bEJUxjBSAI97dI2OhrdlhCNHI+FooGBRAl5HLGOAUGElNEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIqUGwxPpCxMtdW3tf8PcotPcwon6/iwnYO/Awlhijg=;
 b=IvZsML2olc4A1B30oXCaoUzSp8wLhTFW9Xta89ZxNFnIxRBUP8gr2IRfl1J1JuuKfVKW3pGLctnWrIeR14qLyFxvaWVCcKQzcTPFinaTHBcC7AmXIsIE3mGOKqBYJXF+ZU7gSWJC3l0/jl0IjDoPyTaOw0elGup6xgsAbSKkGfYmo4bPdCGtg8a8WglupqutL9i9kQ+U2YHESSFmV1Wkb1FVJYhbzk8LDHSiILo7Mc4vBp0KvfQopBxVyrB8xluy9r0YdGnO0aq9vEGhKBnOGiZluuwSilG2xW28d1iJDp2UbXpVyzj3RfYHY8OOrpwdz5J7wVEEUsyyNvFhdImAjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIqUGwxPpCxMtdW3tf8PcotPcwon6/iwnYO/Awlhijg=;
 b=J6EprUCyjRpQ6vOyAlokq944DLFpPfJND96gOBN9gOxIOPbCMxYIWJgxpCItjuhtzPebI5ODobp7VH0jx/sp7Ij8ygLMdoWEN9H/QScN2ot3kT1ZDgG5lDpOcqIYubee0nGEDN7sAEUK++6X2+CIoOhk/GCc91qeT+EKoBRVloSbf3k5ttYPrFav+sw0n+YfTQg/q5khW4OUlzj+iGXE91h9VMse8eITMtiyfh2TMAZcoDONGQ+yu13iasp3KVQP0F7QP2uaJJ3xWgltFt5aWEVZGUZz1VhHHm3ujGkOu4xCIrUR0DuV2l4gMhAzfilGxKoa1y30yEPQh0zCES99Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 18 May
 2026 08:25:04 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 08:25:04 +0000
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
Subject: [PATCH v8 net-next 14/15] net: dsa: netc: add support for the standardized counters
Date: Mon, 18 May 2026 16:25:05 +0800
Message-Id: <20260518082506.1318236-15-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518082506.1318236-1-wei.fang@nxp.com>
References: <20260518082506.1318236-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|AM9PR04MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: da4dfddd-03e4-4062-2798-08deb4b6f5d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|38350700014|921020|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	ONu4+/V62HZFw2tUPFTEip2z3oeIT6fbNIwniFG21p0A2p7hHLgXelpBFoXGkYqem5R0X3jvrTZuNQVVwa8GyfOZJyj7p4BHmtWojRuXGT/GwnNjdC4BCgP9Jk5RoZiB+eyb2D2Vez6b/Fr7dfqouGQaTTHXULoCRHysPdv2n6Dr9c4gx/f0m4LMdKRvv7zND5iDhSX1f0B3SBHRmrUbEFbrcYfLSs1Wn6B3ys7SFfNi4DgcLUA+6XXGQZ3Y9larne6lVoTIiDiVa3xdKhGgdYzCB5G1tMRufROERpfjuU3n2hNJ6eAhJRP9GptFqTktPT4qWJ5+YYLY4C7rBMMkxF1Zk4qhVwwsn++v/t3JH+2iGwtDawnGFZIhs+ZGQFwvvSmDeuAqmaNPqTCoCbpLPMh86An0rABWG0PnR/dSinJzENGCKBcK3iHdnEkk2fZbzLrvO6iKjEcBVVaxNPxHHVYmzBFELwJGyoqvmJkkhx6AiZ7ZRTOVAsDNyz1jtZDPou2sa+sfMXrzRlP31Mat8c/tNk2iH4Ero7dhXtZsCuFqLq1K1j0NHXmF1gFxgCWOKt9q3Py3zTZAaSooeKhyD2FW2+ldQl0pTHqwl/+q6KVW6lSOvA3VX04gfc7YXdLKG0RmZCPEIF9WIZlI16wtmbBRTQAJ5GlNYSWduQBLPjKu5kYgvj3fXR99UR8+886dDYtnFrF4HE4LGwh15MFJT5IFiWKZYtw44vt/lvNbhdTpYWfpjaVYKE4LAmtm5gGB2X4p+VaZP0brv+HcJfNc0A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014)(921020)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?15Iybgb4dNG78yTbi26QcIMiLqks+ndWv/nnRccNdEu6/YkU91sYM6M8xYOQ?=
 =?us-ascii?Q?a8VIw3KiToEAz/Mc1XJ+x6J9+ediJQ5jq6vXtwbf/Qhb6sed5LySRwhMAtyY?=
 =?us-ascii?Q?7+258VSa/tiBHcksw5ZpQ2P4SH98EQSh1WuxSQ9z3Ng4qfqN/QGrKTuQcXKO?=
 =?us-ascii?Q?m/F5GAm7F/1ywNTtA8hSkBA3B2wQ/R8N4WV4RphzGtmUmFkgCd3ovvtAAHZH?=
 =?us-ascii?Q?lPjKOEkbER1YqoEMXwMoSmQzL7YpLPmmBtWyVOxOLgcDJS6OYH3xL5c80RC1?=
 =?us-ascii?Q?nG6PEzz06gchXHhoIN1PstP4CjFUUqc5PABYmti2vKLcV6+atAuOzaoD2r/f?=
 =?us-ascii?Q?rmchC6cU3+XRYK66OznQzjM5gueq8CNz0aQAp14Ra+TCpXmjLS1lWZJE1vWV?=
 =?us-ascii?Q?DCHr7SYXjgqE4IKsCCiuS2fyEYZKSC1KWt4ujXilYfA4c9mDGtNqW55PkiWw?=
 =?us-ascii?Q?uC925DFKunwSMtVU8QnpdDSk0YchtbYUBBvwjBmf+NT3/w+5QQ7w610TM4sR?=
 =?us-ascii?Q?U5+NLZdAKJSqO82Gxa5q4cAra1bS8GR7hmjlyCAseIi8Ll4xlwlZL9xtq28+?=
 =?us-ascii?Q?X982ES4+9DQJoV0/WIbDGCBjlQVWCNA2SxLuodjnJ/bGuTkZ7CZIDV8QDesE?=
 =?us-ascii?Q?7GtYY6FyifJvu/P//CeIcXBhiHzyoF9M6ge0oAbpTSPkcVSxhJgxHVzAb+pA?=
 =?us-ascii?Q?QDdPm1P0HltDHT2xFJOgc0Yz1ew1deEtJOCeVOYNwERch8SpCnYYLZR5gyT6?=
 =?us-ascii?Q?mxQFA/SuJRbFzc4w7Cn59ORTUL9QFMXksA6DllxqdI8qNRVVMj4YGoMT0WFS?=
 =?us-ascii?Q?z+aI4WZKPJOPYCTc3ffQxqTGwDdbyI2paekx97ywTzlbzHM2moAJ59gUoYll?=
 =?us-ascii?Q?qMaSLRu2AEKKVnUyvWbK1RX0WAkpshatk/LNDvHPv434fUMaMqOgH7SqUM6X?=
 =?us-ascii?Q?hz1bFJACOAzVzFjTbXpQCbR72sgXSBkUPTcfbeojCA4WXgbBMnmO6NWojS7j?=
 =?us-ascii?Q?9/dSsDHiOIv/1XhDghC2b9IIYlP++9Oe8AKEAYZad5G7OKi02gz9xBCDo4W/?=
 =?us-ascii?Q?Io2m34F1x7lzDiGPT9WWUic5q2hpFjn4nd9VJTCvFvsD+BkKREz/WKUw6GEW?=
 =?us-ascii?Q?+ync1bPRgRxL9uH9eT7AR83Y5aML/YiQm0ZIx6+X6VvjrlPszNL/CXwlnklL?=
 =?us-ascii?Q?r5V24aC9NGVARN9lyU3Y/sNp+ZsGty//mL7JRAP+MmvoExHm6PTk8g5DcUZs?=
 =?us-ascii?Q?Xoah4ltLZLuq0be6bj9yIS9l9jGmipbNKz3xZldFy6YVNNezL0iPW6GmKg7W?=
 =?us-ascii?Q?U+nVWATvmXGDeXd77YnfM1TUZxDBReZ8w6GUSBKG8ghIsb+FfFFtdKAFUebI?=
 =?us-ascii?Q?AV+EUa6QTniUgqBzwi4Kx0vfjJlOhFjIOGcskMvzr2W471VySin4c2N6z36F?=
 =?us-ascii?Q?FHgdKYYb0p+MM9aVasdY8Cw8PEJCnHRiqDC4hUhBRAWeZJtfbpLj9cjpQFBX?=
 =?us-ascii?Q?oM7fKM2B6AtwX7b9QV8wvnF8U3uxgxzNKCN+jGSqXOQzyC7m8FmaKSsMmgT/?=
 =?us-ascii?Q?fChGSaZ8SfO5TD/7ib/DMco8SORQosDrgCukP49y6ev4bvaY+rRhWRdSCQM2?=
 =?us-ascii?Q?zWs9B3/JVLVeH92RlY56HoMr/ZwaktwsjtimPIKdy5VKwM8eaLYMIkHGevqy?=
 =?us-ascii?Q?B19ThL9b8KJx15MEF+j6eg/Mj+MbnKEIVMER/jpK4YPE2trU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da4dfddd-03e4-4062-2798-08deb4b6f5d1
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:25:03.8953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dM2tKYcUBfVEX4zHfced+ussk1EgAnKZWUZc/3t0TBhqUu+LLlgv7IauyvkSUoCFesVruiBPmvEEROwbgq6hog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8938

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
index bc1962b38cda..f3ab0c7646da 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -1487,6 +1487,10 @@ static const struct dsa_switch_ops netc_switch_ops = {
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
index f587c5031c70..ed83201d128b 100644
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
index 78335c399955..f4e8ef983c21 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -184,6 +184,126 @@ enum netc_stg_stage {
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



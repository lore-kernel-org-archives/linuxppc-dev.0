Return-Path: <linuxppc-dev+bounces-20815-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BF6CD343F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 03:04:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFdbL71Sdz2yQL;
	Wed, 13 May 2026 13:04:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778641454;
	cv=pass; b=lKC5gJEjF/HQijgFBIyslQST+kr+1TU5ncXOrv2/3Rn37z9TeqeaahaTi2feJhe4Jlc4QhdbL2/31/YrgliW0eXIVlg5aEQAWcef9PyNAKhPuvQ5b8VaMmPQxc1Z6i+oafv7kOCrus+gp1eDZGDRamWTdJpiyAbnZfj165n38Z8KhxqqpyI9VRUxkiV16szJWM9es3n41eFSoB7EYBOhoJk1pMxkbGGgr3yOgiL/jLZssMCJ1jZgQT+VaEL7ztnlxX3+7tX4CJQEf7VD8bzmMWwu8FvaNtHZ923h9DHVvTdkmE9qZfBZvsjrrTnvS5i+pi0lhcJYMi/a4z5Gy/CSsg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778641454; c=relaxed/relaxed;
	bh=p0ANZRQntYuZYgMXukeOAqU8vA6rZxl2ou2vm6/we9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P2n4r2kwewdR+3BFd48GJL+2NBoESMmRFm6uADQBjOivpma6LrHDSsxrSOgk7vWQZwMxH1QXZogq+nC6ps3TcrCQxtzONP0AjYgNAklX20YXwIejAVhAEaiNkYMWEopwI/lm6cgLwymqgwUYQtpPptSRvzzKhTC97masCYgDolzVeBjopKOPwT0d0WFi8tQQW6VGZayekcc53iW/2EBlGAeUpsXpfZGG2vuezQHxouBK272uhjToHo007ODspB9OgYy03Mo//hmPiyO12xfoujz9BTP5JjSA3kMpYrjrNr67lC9jH+NYn+R+SjWLY3Vo1E3LNyiXJUrdKk5cGVCD0A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ghLuM+r/; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ghLuM+r/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFdbK5Xklz2yQG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 13:04:13 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwfoKp9Jbacauw3dBb4IGwtkPYUZ+d+RQeteATssewjTm+8JU+5+vE7ps25kPqXh6FYM94CUtmlmoSO2LlpONy8c85nuDQ2TA8/CfUZrWMBO3U1DLFEeh7veE/OPimzPMJRNM/szHxF5fSawczYWBCU+MJ2/f0DOZDXIEqGM8/NN90vBE5h5dp5QW6sqJ951LvE7V115DD1IKVqMw7VcYARLqRep8tTyCYPjkXSR9NdtHtp9AdM3wNhREuV024JK7PkmGHu0+oHdzrcfpt2d7bo8V/IPlTnaMbw1fEYJVzKt3cG49krbvuo1/ivz9yDK7qXKQDL+u/e80zMODrJS9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0ANZRQntYuZYgMXukeOAqU8vA6rZxl2ou2vm6/we9E=;
 b=f80Vb4z17g8TB21cTjfNvIXUgNJ1T1SLwG7SxdKUQ4ww2BBK3pzkwu7noP50sMRJ5K1oVqSkiG1pWZD6f5GVJbo3aZz9KUTkClU4gD7ACnOKR2Z1lx5/VF59CZGDnEuCPRh4bl/Je5enNTn/0eYNsQdmXinNXWVY3WSr/NBe2wMnb1NqACkWml9hgkLaQfpENEvoZ8rUFyw6NsAGDaG0TtdKakR+kW4nYD34Z+kUlt1ZRF5lGXM9jghwysGGx26J5ma6mr/8Tsgz1EgAD+r7CdPUGBUC8/m7fsQ9tu5vqhuY1jAA/6ujKa/laG+vqbsgi5XN7dQlkIEKivVoG6bfpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0ANZRQntYuZYgMXukeOAqU8vA6rZxl2ou2vm6/we9E=;
 b=ghLuM+r/rvpGmNYLzRB1oh6NLuCedAKxpUNo1AeanAuj0z8iCkQJROPG9SPqIgANbf4bSVOB7qzfYQPlEuM0KsizZO+QTAsTB/tVF7I+jC/W03h+7fOKkWhAbXyYQ5XdAzXpUSr4xXeGUYI9FxZF39JEWPXmMqy+tHO6npug7/6lCtpZ3LFFLWSK8lrMHGv7yXUnQByD1OK2e3yBHtTgTGYWtM6/a3ZWYKf8qHslRJnpXeHK8J8L0W8YVIb/BbawpI/S/5DCn+gTAOj56H0wi33CQ3MbMvv1N5s0qI/Geh5d5YnOXLK3t20pJb9xybxTjsPHGIk1E9sj/Oq6wxUOlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by GV1PR04MB11525.eurprd04.prod.outlook.com (2603:10a6:150:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 03:04:09 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 03:04:09 +0000
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
Subject: [PATCH v7 net-next 14/15] net: dsa: netc: add support for the standardized counters
Date: Wed, 13 May 2026 11:04:53 +0800
Message-Id: <20260513030454.1666570-15-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513030454.1666570-1-wei.fang@nxp.com>
References: <20260513030454.1666570-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0029.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|GV1PR04MB11525:EE_
X-MS-Office365-Filtering-Correlation-Id: 57335a73-f6fd-4d83-4ba0-08deb09c4d95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|56012099003|18002099003|22082099003|11063799003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	G7qbAXbqYobTRoq0PwK8MQVgYKENZ9wbubQn4xOQuUa0IyvH2z+DGShXaFZ40Tb9/2rgkfAmJg/6KH9NRTKpbrom7p/dSB6XRpsR9T1IJKpZSEMbhKmts8+bumVH5pvrHsxYTeOwJL2F5Z8G9MFDiDKPsHXKYuUkGI3BYHbbw2L9XL9ig6XFJd9HgqMEAacM/NhFcV00c9WtS/ORoe9adE9I2wYFhY4f0JQ/CDUEo+ebNktQMOpY7PlA9KQwY4ZfGDrRGgSngNYTmem2R7I5Jb3N5IIsngKvHOc/dTbvRUTdcd4QoHMKebizou20WAh5JR99ejlkbTiRA5qa7SmS5BhEPf1gT6Ahh4L0tQziwTG51NOhRjqsgLE+TspcTPbkgH9sbCTqRWHskDdx008J7itUvxgdvMXKyzoYgEkM5QRULTNaqRVQLidr6S1Gv3kbrFcvSAnfSHKQpLeMVRzQSmqnPxAAJGWjiP8/1Iqp264+/TCphy/XMShb0VfJrwzy0HqQ5Jm/QK3XBM6SkurwK+jeRtWUsiOkxrWvu5AZ3Q/qAFIdV6fYBR5X6oUjPNM3M74iBDtwwYkhY9VzOpE2NhroF+73+fL0Y3FQAuCB274lQzZiMslDL3RyQ0mZKcqkiDEyx93V4W3BMiZ/wdHyKBdbG54skhV7BOKG25J5F4b6921EPy3lSxlPwChvS/zhfqJGzkOmf1XeEIcvJCEitSctJiYKNipoUUegerdMDaJ2yC3okoEbVmiPEyy1c4ExHLI1BC+liaq9RUCpc7ggcQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(56012099003)(18002099003)(22082099003)(11063799003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1BPB/mcrtLSjCcbq5QL4RdQoAmakgKUBvTyneijYHYjmVTRTA7Oy+rWxkGjf?=
 =?us-ascii?Q?jTnaLG/b7AenUej6JNa6vbpEndaXIHdnsQ4mNfnyyU12COspV7FGYFI6EfPW?=
 =?us-ascii?Q?W6JYiCLanAP753BbUiHcjgg4J7JyCoei5DysR3zFYW7Od9f6ZbBdPbybdVV4?=
 =?us-ascii?Q?SblwJfKRcnF5T8M/UyU9loXc5IktLb4NP9jN9bXOvXNZ4B4jNZBdR6t8YSJZ?=
 =?us-ascii?Q?jtrXdsFuSrrk12GuVNk/Tl6iGq2s7FyST73FZSCJqC29SvcOVcadn0WoB4Pf?=
 =?us-ascii?Q?kbkgUFfnR0ihbH/I1o1KUq82a2owfuLbcEnYML6GP/S1uzyUYA26KNFbm+Sg?=
 =?us-ascii?Q?AsQtAZYAro/7uJu4CVP9m1WBhr/rdqkoW++O4MbEHuiQNFR3KVoHB0+96Y0T?=
 =?us-ascii?Q?Qd+R+B+tIbLHpZG8vOFp+bO2JGLN/AzSWRv2ynO8Rkvmu4zgUVeVZfGR7eog?=
 =?us-ascii?Q?VuOQS7al7Vx59OJHyv5UHeQ4vm52Wx9ZNjVz7T5KQXfXNe3N3wF8ZzMfHcZr?=
 =?us-ascii?Q?qOnKE0jzZ3A2gJeiE2pj7xo4CtNWSUrOc1ZGCKD773fZS27uBif+lEDOy9Ce?=
 =?us-ascii?Q?xFBTstat+9+q4+zwj3iwHIxBk+7A7dJeuN1aZ9PxqvGZITmaBFecqQE5Oyn7?=
 =?us-ascii?Q?1ybWXZk8r65PRJF0FQUMQ3WolehPxJH6UrKPnOc2+16QwKI7oTG6nioY6pxY?=
 =?us-ascii?Q?GbVPlBPoNos+X44PafHyP3BFHKbBEjl5CgRJ8YqiL/jeaNS6zfCxXqGtYJig?=
 =?us-ascii?Q?UgBiJrZfeuQa3eTtnZMxqJ1OgEO1CVFKDrCNOAksFnnK1QPk84DjlhvNOxCD?=
 =?us-ascii?Q?C7CSGBUcyscHd0jpoxbKB4EQUJju2hfRoAruMh1gP5LHM57CUMdnPVEb6M/4?=
 =?us-ascii?Q?Li7LkKS1SFMOUmQ2L8xcjGE7dAy6yrquxuz/pnCv2ZDwRvEKM5OYPmPJyvJ4?=
 =?us-ascii?Q?6ZhtO4PisEihInfjUglUOjmGZ/K2DSqS92ofOQ9C5yg8i6nqkcrT1x07H6kb?=
 =?us-ascii?Q?IdSQHBWPergKi47TwP+120/GFYm8Ht4lcJBFO/+yGnHj/E1P1Q2qTWuEGEpF?=
 =?us-ascii?Q?IUdTaDS3id184VT4YO4oNpaMqPDs1hJAs9tM0u6jduh8Dwpx57dL4Y7enFak?=
 =?us-ascii?Q?dmI0AuL/6fkxgnCLttWQ7KcnfJ3YrUXIQNnnj+PQweTP3sy/X/VHmcwV7R0O?=
 =?us-ascii?Q?AjMkiWHhNgJP83aEG38bZKrabGpF7mbo2TvNXYR9VBXB6zBkAG41xKUqWFsk?=
 =?us-ascii?Q?BDRZNRwIvgCRD2N0aaNeGoMb09fdbmWbVnnvcDfzLDaBmy1UKbmBauFSv6AU?=
 =?us-ascii?Q?HA4MVLOBH4igiczcm7e+EX4P/zYeF7EPbMxEa0RyZNKZiTooO3ezFV0Ax4ZQ?=
 =?us-ascii?Q?4eEXR+7VArShC/IkyFj98Xf/AvH3QlPROYHE7o3VExk2lt1X/WLRUXlbDaG1?=
 =?us-ascii?Q?GDgIbISykJdS/vgf917bN6h0xRxra+fPNftyDMHaWDFQvRk9FNNpP6rNcj3E?=
 =?us-ascii?Q?1dliZmzgJU8XFxdxdGWeuuq5tUHlNHaZkpLaVgC6yI+HxAITvQpDKbkzQ3CD?=
 =?us-ascii?Q?UpG5+1OjAvR+0Q1sn/CHmoPvRK/vJIVYvbF5qFji+1tdWLNtzcK9cxF8ImR3?=
 =?us-ascii?Q?9tBp5XL5NV8dGHnOQcNYf82mH053HL6g5HQiOxux2mhMgkh8F7DNkD7QVcEN?=
 =?us-ascii?Q?DM6C3QU4NPKfBkt6NFVkQJ1Rz8G4zUdThfUuuEMiGU2+xgRA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57335a73-f6fd-4d83-4ba0-08deb09c4d95
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 03:04:09.7943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YuZkBIhb68wJ6/cYm4DUHOmWSMwvAkEsXn3oPUnwYHWQpHrtSdJrmtLE5JVI4yFKZzLqqLCax2Yiq8dtzfrNwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11525

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
index 7a4064849693..d79bd18b7e6e 100644
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



Return-Path: <linuxppc-dev+bounces-20808-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAFBCD37AC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 03:03:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFdZd70YJz2xl0;
	Wed, 13 May 2026 13:03:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778641417;
	cv=pass; b=OTJVsiRSaHi/xCRdeuBPhHkcbcGDvvBz6xW3e6MxtZaQ9zdhILFJutbMzIgZBZ10MHWw15nZzFpQ7G2spB9OR4poeH89U+83OLYkWuQk1zW9Bhg3Fj5DPjRWLgVML07yXod+B1T+2y1CHWgltCur84roWj6Aa9P4B3pBlKh0i/9zufX+2sotwRcYoEMEiVONwHra1fJPqx6bmz3lPIXtp7RZW+Eu+ynxkK2NDhY2+0y/XDovrIA2kNYkd8rDRL/weJdKXRvX8VNZPOxdPfx5b7Ko4RA9VTUJk7JDk1jdGXCCkPOTnuJK7SqQjiQpsSFBxBlZhQ3zjbVPLLAMMp5eYA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778641417; c=relaxed/relaxed;
	bh=UUG8jsQUB6gJnEpLgpYORvMwtrnyXIsT7f888lopK3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FAFywXwj9DxP/WaGlN8xLpl8T/ebxAmwTzw3+wgKgd8XgERK6U4SDtMI8lYSE6KPaRptIxLnonCS/8ROYn/Ew9xJHh4ehy1WmZf+LWX7kL9uPjD84BagLFFb8A9iugu1ATvvaHYUe5y+cqVFwhCpp6mME86pkcbNzeZmiXQiNC7qLRElw6oM0Oxi1qRhAbC3SBQd8sZcQyJcRoNPjLQpBxdOc7E8H7ZZebBVgWItNKOeC0C7psAiph8ggRQXv3p05oLm5plCVzWwzJfOoT4YrHtGDp+VFU8HuC9CB4yA0NB00eTd4whw0zrk0YUYETvAPDGFntqO2aOho/kDS08SBg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Nk8iQvTR; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Nk8iQvTR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFdZd0CsSz2yFQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 13:03:37 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpUDTsrGaQKk3McxB5PRNvLo5kIkcAY9eOJCzAVcoP6XTQcSejAh1b7H81DSdxobixXb1AI4aaenNATa507ZdAcZYixTvY9uha7O4ecOnZGsL9DO0h03Dpypc8xyQEjH+hgW5Owrh4zntVYXjRH2fSCPEd0JCJQHFrhngBrJCCipwTN7k6XooJpuBewgnvRjet/gkFO9BS7HbAyqcO9xh0kOqwPDVI2fwxpEMBNmuazrM9+z5LCeQHmzjkkqK3bc5nf9OQLMZbwBrn33vfahc3dcK6zXo5SEcu5oXjXljOzHWibXBy5kRNNZBnSTP0Vg2UCsdnzWoKTRsc0X8Fo+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUG8jsQUB6gJnEpLgpYORvMwtrnyXIsT7f888lopK3M=;
 b=vUj0lzHNvnx1YSlZ6LRnDmpMsUX1b8Hy/G0ZoNIUNAOMkjIhKpYfposna6WtYLQMn8CSZBegNx82A7lsczXj5JQ3lhoBlCdkV1pJYoIJLSUMwt7yQ13MputBDkWmchO0BrX3QjyxQBIYWDJhCRTVXpvNH/G5o/w1gDn/RmV9qj0Qa1Jrink1WmqZxRf7TIl6aFnGA+omz771yn1JR0xtocmPO6ysouwZ9hgkjuQ2DPbli++XsNXYxb1vBuxw2EbJGtsq2Ye/a6OOfXVcOxLo3NPoechw00hYrCPNkpynGJLGjf7AyBhrAMWTXftqfGka2Qe5Z0mT16TvTqEPmP0gYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUG8jsQUB6gJnEpLgpYORvMwtrnyXIsT7f888lopK3M=;
 b=Nk8iQvTRyK2Iik3XpeiZAnmfPqaiVmynwGDIuKFBgf04FAW/tFTlgWUro+UrYo92qngvzC/ft5xP9awZVTbqaakHOVjQUapPRZQ9r6HnUEsd2LkJy33VCNVZV25srybjleD5YkiVAZD4q+3qLyTpMPT+hVs9lIcHZGHlkYRkfDJ29LLfiEnKJeVRUWsuEGu6yfG2ALidLl7nn83iNndlZBbx5rURD+bR2fu2yoZBN3AuWNQFGkNq4Ts7v6n9mIxTpiGQYxQF5aR9AaBSkIIpEb1YD1mtshVeOkDE0lPEO47dT/cDQFWOAm+4s4MZFbZ9nhBQ9tlxqvyAclRvc7ieeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by GV1PR04MB11525.eurprd04.prod.outlook.com (2603:10a6:150:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 03:03:17 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 03:03:17 +0000
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
Subject: [PATCH v7 net-next 07/15] net: enetc: add support for "Add" and "Delete" operations to IPFT
Date: Wed, 13 May 2026 11:04:46 +0800
Message-Id: <20260513030454.1666570-8-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b67582b6-6739-4253-37ce-08deb09c2e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|56012099003|18002099003|22082099003|3023799003|11063799003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	TSfIPmzCKRMXM/271ZJwba98RkqCwhfMeUVo52PuILBqB9mv4WcAfjEloqIOoEk8Ls85E9o+QAv/dG2YPJXFlLT2d9fB28rX5ZX+/oZ8IkgBtHfuYHeBIIi2dx/IW9OFjh38m0qFtHtgVfqSmozaOripQkwFN0JnKWFhOzkaOlRouzZ70oZE1VFlcHOKq9ZqCrWkhnTm0Lf4yBmEK4LF03tUA6FPG22J/aqAxelVWjjlpvb1T1Z6vJbIauajCMdQXBlIkFmDxPCY5COC/RKh7MMO5ODm1xdlxlg64ro4Xp++3Udb/LQEgJ7EymotPuYaWmG9oPC1OMdXnEoIn9JKf0HqAEckRb6vpFYukHiG14nLBlfdHS3hkyd06Nr1lhAwoHvldeHoYAzo5CGQVNX5mvkPas+YQEN7+kQ/R+iLNd053qQsdqsR8vf5+2n/icptnVTzXpKvEvv3BlrdZ8UNUBa8oQLU3GCZ/WP5Es9UrS9d2Kik58GsftEuRpDRPD5fVFpd5a+2Iahs21FS2HzpjXQvO2YqLdv1T6qRLTvqKNpE5ewLonIAcX3fAd9pP3izeJ0bPiiaE/tByQUx5iNt+sDSQ6d5sJvAnEPdNw87IEY4j0EXjKXczzMjOi2soaGlRRge4r0IpexOZ0MmE/AA7qZ9lCWA3kwgigAM2WtDIC3WMABnF7Pz4YFXT+VTp9RqrEQVgJ/g34Nblf0B62tJQmhBFKf48J+FSKedQGr2sgco6whTg0L//v4yw+HGoAb31cXwDd+9j1xo76zokFrtQQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(56012099003)(18002099003)(22082099003)(3023799003)(11063799003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N7xoH64b90FEljrJ3qZzMLdZx1+lc7gJBq7NijgzT8EDEG/X8nTJs1J9w6nx?=
 =?us-ascii?Q?JzeoJ0aQbU+/GT1oSCEsENZQesFbYDLA+orZ5FOWkSXgBlkYwVMfan+Evae1?=
 =?us-ascii?Q?OZmzqG+eJFPdE1osgwEoaC0/C6EgybTbpdBShI0PkmmK0MpSAVKSZmjkCZ84?=
 =?us-ascii?Q?3zQaF7+KjsUD+2/e5JMkN8YEI4Bf+Wc605Wg2vsXJDxNTjNl1Ln0EyTa6D4d?=
 =?us-ascii?Q?LuGJ3Xi79DTMz7pZy7JcEteZ4NGEHDNSK8eUGQy4QQ0KnpXJLBhuymdPDsD7?=
 =?us-ascii?Q?cpIXO870acqEWRivSoA9ot+5eEOjKTONIE6Jb2ebi9xGSbnCpWKuoAUDHkJX?=
 =?us-ascii?Q?jRcReJGHn8slsEEp2d5e8xGAQeSN+2fm8mwN4SxNbYvR/Aoc7HIj86ZwRK6P?=
 =?us-ascii?Q?9dmwZjJpO0BgzcTZeaiFRWrkc0tZhqT0Oh1znlmV+wE3A8L3iXBOmkkCzwl+?=
 =?us-ascii?Q?2Av/CoNNdSnm97x/KA8Q/JyuOQbfJw5hipYMcrkVFb7tYGDbXqzVQCWX71To?=
 =?us-ascii?Q?gkj5LvJQWoMEaMj8E4wnVIIdXaq6h002aUnhtEm3mSzk2Z0EHK5TXieSZ1km?=
 =?us-ascii?Q?ehA+dnZLEQL0YBN+3KURnt4XXS3rms/DhYxaDx2O19HfRKvbjUHgTPvAsLOO?=
 =?us-ascii?Q?DR2vBtbIDCyzg/FGkVRTmdQCYmTP2vCOabssTjvzqqkpNw9jt2Zpckc14eVp?=
 =?us-ascii?Q?o0UGg4qyOaQGQgc3SwU/RuNLrOcfMT2puM1/frHTMhP0y+S8la6Qn8ZBYlLk?=
 =?us-ascii?Q?6mKNsY/mk4ifE9f5mYD5+1Z8IvA+y9OygMHIcOL1vRsmy/YOXiIgxlZQb+UE?=
 =?us-ascii?Q?Q/4GfDR6L728ujo4PcvFJIkzI6ZNmeHI+5GtCIDp478SGTsMAmvBmMGPL0/u?=
 =?us-ascii?Q?g1VOY2igKUG2lml1ThkX5bXluLFxsHE+pw8PfKRFYjwPp37zw6mcWwDbn37F?=
 =?us-ascii?Q?455Ty/lxDXalAC5wLhkEUHXEDp+jrpQV8RtzMeQIRVzzttWCYKpds4/D2iao?=
 =?us-ascii?Q?XxECH2lLAMQ5Bp+GOw8yPYa/xK25byCnEjEA85tgZDdaMIa8MErKIwcFd8iN?=
 =?us-ascii?Q?oolbr7eZUZli34MmSIzjmzs+p7rKX10W8Ddw0U/ikVAmYTOQvIBbB1hIU9/c?=
 =?us-ascii?Q?/uo0POS38tgn/ddyuJioQfjsFvMH720Y872BipSoxmyh+K9JSgYCsmA3X/Pj?=
 =?us-ascii?Q?VjzPrvzgb2Ya7EkEt+eHslPoBhgNzZyx811ABS0Xl6tiKX88NtG5M0zwNaGA?=
 =?us-ascii?Q?bHTDAahKVJMMV81Bkhi8Jr3p5+UMN9bbhF+9NkT3X4yC4jWyrKmS9a0IsAe0?=
 =?us-ascii?Q?dW0ssndcokSoyZ63vMg1d7K0gMTu7pQQPmMM84rsd3YZ/SiTzAmzQTcDnVKz?=
 =?us-ascii?Q?0n0tlJ7Vi2wGqrTxzQb6pzUBjJ57Oa0OAo/tdj3rDZKqxdhr1uA0vHVBkzGY?=
 =?us-ascii?Q?cLfcMGooAnDKQYRggONsSEvRRCAf9xdWGOImiCSgUn0jJfbA1d31EvKvvfUO?=
 =?us-ascii?Q?ITmfFBy5BuXnrvZpNhZwJJZqNfC9Ig2/uTh4apyDt8Wc6tBHv3AlC9ykkhMq?=
 =?us-ascii?Q?+5r+X9ByGqRdpnhDYHqqoIPPCI1bMW1PGgLFE9F17N8K+l4Y6XOm0lqYBUje?=
 =?us-ascii?Q?1vMe/yg4/JVLBM5sfbTT865BeUIMrmndqxo0F0tOCvzaOgttAq9IORIV0U28?=
 =?us-ascii?Q?9ntDrZ2c81FYP8ZYHKaJ1KEqtIUjtYd0bqgTUjGFYiYGn74XI11baW79U9Mm?=
 =?us-ascii?Q?kB64/WZmDQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67582b6-6739-4253-37ce-08deb09c2e96
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 03:03:17.7936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYX+tyeya9Y40kjnT2koi8ZMOfnmg7uha6PyotHkjzrpgrQWVXk+DfDweYRkcjRYhr6avnrgKF3YVU8Qse9syg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11525

The ingress port filter table (IPFT )contains a set of filters each
capable of classifying incoming traffic using a mix of L2, L3, and L4
parsed and arbitrary field data. As a result of a filter match, several
actions can be specified such as on whether to deny or allow a frame,
overriding internal QoS attributes associated with the frame and setting
parameters for the subsequent frame processing functions, such as stream
identification, policing, ingress mirroring. Each entry corresponds to a
filter. The ingress port filter entries are added using a precedence
value. If a frame matches multiple entries, the entry with the higher
precedence is used. Currently, this patch only adds "Add" and "Delete"
operations to the ingress port filter table. These two interfaces will
be used by both ENETC driver and NETC switch driver.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 80 ++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   | 36 +++++++
 include/linux/fsl/ntmp.h                      | 93 +++++++++++++++++++
 3 files changed, 209 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index ad89be85b185..635032d24dc7 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -21,6 +21,7 @@
 /* Define NTMP Table ID */
 #define NTMP_MAFT_ID			1
 #define NTMP_RSST_ID			3
+#define NTMP_IPFT_ID			13
 #define NTMP_FDBT_ID			15
 #define NTMP_VFT_ID			18
 #define NTMP_BPT_ID			41
@@ -271,6 +272,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "MAC Address Filter Table";
 	case NTMP_RSST_ID:
 		return "RSS Table";
+	case NTMP_IPFT_ID:
+		return "Ingress Port Filter Table";
 	case NTMP_FDBT_ID:
 		return "FDB Table";
 	case NTMP_VFT_ID:
@@ -513,6 +516,83 @@ int ntmp_rsst_query_entry(struct ntmp_user *user, u32 *table, int count)
 }
 EXPORT_SYMBOL_GPL(ntmp_rsst_query_entry);
 
+/**
+ * ntmp_ipft_add_entry - add an entry into the ingress port filter table
+ * @user: target ntmp_user struct
+ * @entry: the entry data, entry->cfge (configuration element data) and
+ * entry->keye (key element data) are used as input. Since the entry ID
+ * is assigned by the hardware, so entry->entry_id is a returned value
+ * for the driver to use, the driver can update/delete/query the entry
+ * based on the entry_id.
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ipft_add_entry(struct ntmp_user *user,
+			struct ipft_entry_data *entry)
+{
+	struct ipft_resp_query *resp;
+	struct ipft_req_ua *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*resp);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Note that NTMP_GEN_UA_STSEU is used to reset the statistics of
+	 * the entry. The STSE_DATA is not present in the request data for
+	 * 'Add' operation.
+	 */
+	ntmp_fill_crd(&req->crd, user->tbl.ipft_ver, NTMP_QA_ENTRY_ID,
+		      NTMP_GEN_UA_CFGEU | NTMP_GEN_UA_STSEU);
+	req->ak.keye = entry->keye;
+	req->cfge = entry->cfge;
+
+	len = NTMP_LEN(sizeof(*req), swcbd.size);
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_IPFT_ID,
+			      NTMP_CMD_AQ, NTMP_AM_TERNARY_KEY);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err) {
+		dev_err(user->dev, "Failed to add %s entry, err: %pe\n",
+			ntmp_table_name(NTMP_IPFT_ID), ERR_PTR(err));
+
+		goto unlock_cbdr;
+	}
+
+	resp = (struct ipft_resp_query *)req;
+	entry->entry_id = le32_to_cpu(resp->entry_id);
+
+unlock_cbdr:
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_ipft_add_entry);
+
+/**
+ * ntmp_ipft_delete_entry - delete a specified ingress port filter table entry
+ * @user: target ntmp_user struct
+ * @entry_id: the specified ID of the ingress port filter table entry
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ipft_delete_entry(struct ntmp_user *user, u32 entry_id)
+{
+	u32 req_len = sizeof(struct ipft_req_qd);
+
+	return ntmp_delete_entry_by_id(user, NTMP_IPFT_ID,
+				       user->tbl.ipft_ver,
+				       entry_id, req_len,
+				       NTMP_STATUS_RESP_LEN);
+}
+EXPORT_SYMBOL_GPL(ntmp_ipft_delete_entry);
+
 /**
  * ntmp_fdbt_add_entry - add an entry into the FDB table
  * @user: target ntmp_user struct
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 64df49e9a3ef..0a9b87286105 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -99,6 +99,42 @@ struct rsst_req_update {
 	u8 groups[];
 };
 
+/* Ingress Port Filter Table Response Data Buffer Format of Query action */
+struct ipft_resp_query {
+	__le32 status;
+	__le32 entry_id;
+	struct ipft_keye_data keye;
+	__le64 match_count; /* STSE_DATA */
+	struct ipft_cfge_data cfge;
+} __packed;
+
+struct ipft_ak_eid {
+	__le32 entry_id;
+	__le32 resv[52];
+};
+
+union ipft_access_key {
+	struct ipft_ak_eid eid;
+	struct ipft_keye_data keye;
+};
+
+/* Ingress Port Filter Table Request Data Buffer Format of Update and
+ * Add actions
+ */
+struct ipft_req_ua {
+	struct ntmp_cmn_req_data crd;
+	union ipft_access_key ak;
+	struct ipft_cfge_data cfge;
+};
+
+/* Ingress Port Filter Table Request Data Buffer Format of Query and
+ * Delete actions
+ */
+struct ipft_req_qd {
+	struct ntmp_req_by_eid rbe;
+	__le32 resv[52];
+};
+
 /* Access Key Format of FDB Table */
 struct fdbt_ak_eid {
 	__le32 entry_id;
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index d74714a402f6..f68551045b60 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -7,6 +7,7 @@
 #include <linux/if_ether.h>
 
 #define NTMP_NULL_ENTRY_ID		0xffffffffU
+#define IPFT_MAX_PLD_LEN		24
 
 struct maft_keye_data {
 	u8 mac_addr[ETH_ALEN];
@@ -34,6 +35,7 @@ struct netc_tbl_vers {
 	u8 fdbt_ver;
 	u8 vft_ver;
 	u8 bpt_ver;
+	u8 ipft_ver;
 };
 
 struct netc_swcbd {
@@ -73,6 +75,94 @@ struct maft_entry_data {
 	struct maft_cfge_data cfge;
 };
 
+struct ipft_pld_byte {
+	u8 data;
+	u8 mask;
+};
+
+struct ipft_keye_data {
+	__le16 precedence;
+	__le16 resv0[3];
+	__le16 frm_attr_flags;
+#define IPFT_FAF_OVLAN		BIT(2)
+#define IPFT_FAF_IVLAN		BIT(3)
+#define IPFT_FAF_IP_HDR		BIT(7)
+#define IPFT_FAF_IP_VER6	BIT(8)
+#define IPFT_FAF_L4_CODE	GENMASK(11, 10)
+#define  IPFT_FAF_TCP_HDR	1
+#define  IPFT_FAF_UDP_HDR	2
+#define  IPFT_FAF_SCTP_HDR	3
+#define IPFT_FAF_WOL_MAGIC	BIT(12)
+	__le16 frm_attr_flags_mask;
+	__le16 dscp;
+#define IPFT_DSCP		GENMASK(5, 0)
+#define IPFT_DSCP_MASK		GENMASK(11, 6)
+#define IPFT_DSCP_MASK_ALL	0x3f
+	__le16 src_port; /* This field is reserved for ENETC */
+#define IPFT_SRC_PORT		GENMASK(4, 0)
+#define IPFT_SRC_PORT_MASK	GENMASK(9, 5)
+#define IPFT_SRC_PORT_MASK_ALL	0x1f
+	__be16 outer_vlan_tci;
+	__be16 outer_vlan_tci_mask;
+	u8 dmac[ETH_ALEN];
+	u8 dmac_mask[ETH_ALEN];
+	u8 smac[ETH_ALEN];
+	u8 smac_mask[ETH_ALEN];
+	__be16 inner_vlan_tci;
+	__be16 inner_vlan_tci_mask;
+	__be16 ethertype;
+	__be16 ethertype_mask;
+	u8 ip_protocol;
+	u8 ip_protocol_mask;
+	__le16 resv1[7];
+	__be32 ip_src[4];
+	__le32 resv2[2];
+	__be32 ip_src_mask[4];
+	__be16 l4_src_port;
+	__be16 l4_src_port_mask;
+	__le32 resv3;
+	__be32 ip_dst[4];
+	__le32 resv4[2];
+	__be32 ip_dst_mask[4];
+	__be16 l4_dst_port;
+	__be16 l4_dst_port_mask;
+	__le32 resv5;
+	struct ipft_pld_byte byte[IPFT_MAX_PLD_LEN];
+};
+
+struct ipft_cfge_data {
+	__le32 cfg;
+#define IPFT_IPV		GENMASK(3, 0)
+#define IPFT_OIPV		BIT(4)
+#define IPFT_DR			GENMASK(6, 5)
+#define IPFT_ODR		BIT(7)
+#define IPFT_FLTFA		GENMASK(10, 8)
+#define  IPFT_FLTFA_DISCARD	0
+#define  IPFT_FLTFA_PERMIT	1
+/* Redirect is only for switch */
+#define  IPFT_FLTFA_REDIRECT	2
+#define IPFT_IMIRE		BIT(11)
+#define IPFT_WOLTE		BIT(12)
+#define IPFT_FLTA		GENMASK(14, 13)
+#define  IPFT_FLTA_RP		1
+#define  IPFT_FLTA_IS		2
+#define  IPFT_FLTA_SI_BITMAP	3
+#define IPFT_RPR		GENMASK(16, 15)
+#define IPFT_CTD		BIT(17)
+#define IPFT_HR			GENMASK(21, 18)
+#define IPFT_TIMECAPE		BIT(22)
+#define IPFT_RRT		BIT(23)
+#define IPFT_BL2F		BIT(24)
+#define IPFT_EVMEID		GENMASK(31, 28)
+	__le32 flta_tgt;
+};
+
+struct ipft_entry_data {
+	u32 entry_id; /* hardware assigns entry ID */
+	struct ipft_keye_data keye;
+	struct ipft_cfge_data cfge;
+};
+
 struct fdbt_keye_data {
 	u8 mac_addr[ETH_ALEN]; /* big-endian */
 	__le16 resv0;
@@ -162,6 +252,9 @@ int ntmp_rsst_update_entry(struct ntmp_user *user, const u32 *table,
 			   int count);
 int ntmp_rsst_query_entry(struct ntmp_user *user,
 			  u32 *table, int count);
+int ntmp_ipft_add_entry(struct ntmp_user *user,
+			struct ipft_entry_data *entry);
+int ntmp_ipft_delete_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
 			const struct fdbt_keye_data *keye,
 			const struct fdbt_cfge_data *cfge);
-- 
2.34.1



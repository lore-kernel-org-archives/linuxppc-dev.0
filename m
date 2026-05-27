Return-Path: <linuxppc-dev+bounces-21572-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FCECD5BD0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 12:13:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQT5X2TK3z2ySC;
	Wed, 27 May 2026 22:12:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779875995;
	cv=pass; b=V495W3Sxm/QIuEk5wqOvd+vqyjqtymsD2mb8WxkLyd0Gz3mDbphh4sGDSBqSnB1t62kbxMWS+lM7bKaHdgoRD4x2Ez9KoM6NbaO1FmgSH82ijy3VzR/ArOwtM98/E7WYcSKBu1C7XGcj1qR2zZhqt/KP++xIW40bVuTekk2+ud0bI0oIWrziBu34whSYLEm0OhB/EPH6UVn5T3QkJdY1W81an9Svb7/VXnCHCMatr6bdB0ELZZk2XEvjyK6UIUeehLqc4lzRhD0dux4zIWfzl/Trhax2sGG1USaEPBm7P0LqSDPjpphW+O2YVWZ0tAq+ypndz7jKuhuLzMuSNNysaw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779875995; c=relaxed/relaxed;
	bh=Rjk/zgPv+rmP/dyI9PQW2klp+51hCuC3B1OQGDO31qM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Na60FNqpHZxI2UK4W5GuxZq96mwcu1GWOAwgGNDjNlSp0h+iLQGnkirVBlI3V0+24CHeHUJ0X2RUUKdeB/oi/zkPVSvcjBW1RNwdfRP5aUTmo74w5yzV12Lct96zfJMVMo6TCqQaMVy6UviuHk/oAJgNsTRHOIdvQu2bASM7ASxeAWl6DtDmDbJ0PaFXfJUCUzGQwEWXQf7ZnfQJr8nuvp+T7KEH/kBsv4AbPsPAU3mMMKjXG5sKxaRHbsy7Hknycr2cJ/Cx59h+A4xhWRchQnvV6aEGgdTpG1Lkq5Fb2tonZIYM+xWeGsVia1zoUoLgQmPvh5wA2DS2j0lr+4yMHg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FbEShFg5; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FbEShFg5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQQ8V7234z2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 19:59:54 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZLHUgYLl7woKtTEeNR/K4OOu8tWHyVaS5MVek7GGryjQiPM3QS2fXU54l3GpeqQX79jTz5uqclunkCYJzRqsspqhH+SXyI89JdMdSyZvSROIoTCfikpLtMHvaSmmNTslxgV2t4x4KAsmjFgxDffs4KYY+/MJygK3UywJWuSOZUNqchUubCjw+WlSemd9JMGvwReRWgMfBC2vvI7Kb2B0B7BjGDy9EJhr2cnR6yPIdkHxljqNglHVXKwjWOFAqDbNY9wXXW3e6Wsbk2woJLVZw4zb/mJviRJQQC/A+zZqFJQzzEfFDP5RNx7ylpAuH/xfUzrTMSnrYXi3BzlQJwlcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rjk/zgPv+rmP/dyI9PQW2klp+51hCuC3B1OQGDO31qM=;
 b=v+l+xF0jbU1bRCBnfHbu1k+tHnW5GdsFlgageA+Ug0H32zq9HPPXYBzJrQA8j9e/+IVGgVIs2dZ3Fi0gnM0QpVXNwDkTdSnPf802B/eb+Ddlrnq+dn5NYNOYdv4Icavf56qp9QVde7F2u9PwHK38o/MO2orfCqJg4rvVldhKqtLCXKlgoTzQWfWQMk2SpXsM+7ivqTy8U3Ln/F4IYCKf7cU0+9uI9JrvP0uVZ+6KMTwAVJTrNUcq2XHv8h1lVD4DYcYAr0Dfrd1/1AW4Dhrqi2kwmo+VkbL7a37JbB9TeANGKCBOFNKT0QQD1talQVJ0my5n0ZYmLup6Yn7khPJZ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rjk/zgPv+rmP/dyI9PQW2klp+51hCuC3B1OQGDO31qM=;
 b=FbEShFg5qK6PW7HeWvLaCLG3Y1jj2TYyu9Xi0HqKpwV7+kU80du36ji/UVO9urLsCLj92dUwhShR+iDG3YxgLHzX1x5a0J0Z8e4yBMmGf6kkGVbqmX9LBDcZcA1fnbLGYrryjao4oZO/fnRDRzKI79Hdoh8NSCMvD7VWFClFik3wLT5wUjtlpnxn4wKypi/EqmuTj7BhDDJHWp9SAO7E/Y+MYpy7TcTgEJxthJ+/HMwUwJit+QrXbOfKhIU3Ufg7B2EEYrtEgb/th+CjT7vWlUBuypFMRCbslIfljSxutrM8LPorgpIzrFqogyhUW7pTVd4OcyxOLESVsrc2CMED4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AMBPR04MB12205.eurprd04.prod.outlook.com (2603:10a6:20b:758::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 09:59:41 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0048.019; Wed, 27 May 2026
 09:59:41 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 4/9] net: enetc: add "Update" operation to the egress count table
Date: Wed, 27 May 2026 18:02:12 +0800
Message-Id: <20260527100217.794987-5-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527100217.794987-1-wei.fang@oss.nxp.com>
References: <20260527100217.794987-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AMBPR04MB12205:EE_
X-MS-Office365-Filtering-Correlation-Id: b7df3cc9-140a-428e-68de-08debbd6abfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|11063799006|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	UVO1EXq/PRLvKgJewW2acRvS+Mf8PGOtPEg/fCzadl78TRlOE9MCVAmr3DdPsuvw0LKD0GsESB/DeYtUFy2cF+c9IbWXb4ABS86dajTNtLEEFzpyB0CQ1OYLpoNeKYzhArnf2abHegcHHw+4gQZgXEeZf3euWD2Sj6OG4PStjGJU2FAcvLtYvy4BEavamz5/A9co2jBFtBJ5SkM7V9suCoiJytuua2VBp0Yd0Vh7bOyQ2ZnE6xdoVuthiRW0J26pevfaEQNOcwz9IctzrIUojW6YWJYI2edjdAZs/YIXce6STBnBNS1QSxJ2AaE4fzpkmXwhi+gy8m+UqlYSQfq0NvEjUN1bUca0Y15c0pLB1/fNTpGTemwBdJkjSiA0YjmROPGEc0ehcweivJWGsiwN9du3p+6/vWWqpZWANdMYAzoku0iy1C4TWcMLDn35BIQR6W0E8iZGK0YA2TdM50ecRDP3aUeGQS89LGYjEPboyzQ9vZPl4ABy+ap0Ox3UH+fYditWME0GlYSaKp7Lgv+evDiPFfBBL0ZqcKyJImaGweoL+jptBtQImkC3BuII5IrxVM9bprxUnv2Qj12c9t3UPvK2HXM3GF1STrEgT20k0CU/KqDZRoC3lUOU86l9xeqFEeoid4r53ygaqwC0v4gHnGYUol0b5ctUkxUmjSzjx6QTq+dTUNdsxmFVR2IK/l3AyW0tTbFUaVy1ogGh7K2kAe2U2VtQGT4jg+mrhARE9n0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(11063799006)(56012099006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GBwPTVC7rLCDr9DTkulmXVnsYQHprcVOhBqgBsnCmTA9beGyYi9+WvUzQmwM?=
 =?us-ascii?Q?kMrc2XAotZ8MX5xleSQVx+c47OrJ2aVACX7GPPR6dcpZtSvPBz9V8yy75JmO?=
 =?us-ascii?Q?xkYlDkM4dvI5BvrKsPFu6ikzHhFk/AUfz+DGafdnauk3xBzxFv9hQJnDt7cv?=
 =?us-ascii?Q?CB3y4YeQFwmUQtzEegi8toX4bWmj7QcWSETm6kgDXatczwbETU4G3qIJflw5?=
 =?us-ascii?Q?N1UbzhkNa8IyNXdxmh7SxikiBOJqbtvhyZP/vtWnn221iIqckCY6Y8vuZ0La?=
 =?us-ascii?Q?BhHY4cuS4suWBzQ0kwEGOVoxEmoMv2Zp3lKGQYSsIX3Lfe1mdfxMNVTZssyj?=
 =?us-ascii?Q?Npk720iwKxgM1xj/t19OkuNCn8a0aR1IyrGBtsQjFV8k8Jjw/YSnnpyeurVz?=
 =?us-ascii?Q?79y4sSnY4U5ob/WYFPL23x2jo4VtGl9ONxzQl5c4IT4cZcCN8MvaqLYWeUHX?=
 =?us-ascii?Q?eNWIQei3JxwGan4zvXSUxYdb+e794IbXFkzC/tTdvNUC4jHnmBh+LwdUn3s9?=
 =?us-ascii?Q?QyADyUjkHVxq0G/tNCQ4OV3mV96nuFkIJGv2Y9yuUOpea3Vul4cC7VdPlQ88?=
 =?us-ascii?Q?IZBQqk4WcmpTzKJxeMF5sp9Z+T309XgZX8ooENfk9lNQvlkI5nIydKDytPQT?=
 =?us-ascii?Q?2wqGhz8UsLMlLCtgOfEQ7eTyuPI27xIh34/BbXDuCdttplgsAceX0wwRLoqf?=
 =?us-ascii?Q?LAIxQ9LcJTnqiH5uQ32uviXJHfS+Mtiw7ZvX89nl0Lj+NPpjY6gEyoPSieRt?=
 =?us-ascii?Q?wc0lkYIUBtTo9zxeprrFDOhsuyLpcch80I92sNcIiWOVwqvuZaZ162wLDA49?=
 =?us-ascii?Q?bZWO5DI5AsJeR9z+7D4w29E5P/t5ArDrd0JsbMKNgrsIFBqwKlnBqwGBA9UU?=
 =?us-ascii?Q?M7NUAiF88zbBzossPQiUkNnw5EGpI01YEJxvnFhWw4Lf+b06IIXYy5aI8YKc?=
 =?us-ascii?Q?8LHA/o3ZHLWwMhSh++WbYt4vFMcga0Y3iAQBuQte5IvYZuSv4GxyNLLOX1/a?=
 =?us-ascii?Q?bxKZndZlbKDuRHmw4fzh9YvJ5RYPsRXcVWDGMPNLU97JiNoKzmjYFhbSxkLv?=
 =?us-ascii?Q?rn611OOVXn27/wFINXPUzyaazJILcev+EhafUJKXz6w9WI2NagAxhPrRvVSO?=
 =?us-ascii?Q?8EAvaJ0KvX9iuVAwsG2ClK5oDHN5egaEIUbhBHVPGZaaaO12We4w6IbL9ybM?=
 =?us-ascii?Q?SrX2zRD7v73jufoxCiqi9VbfuZbdA0qpUggH6LIrIgaM2GKC7HMMoEuXU1rO?=
 =?us-ascii?Q?s+i3x4LL0yy37RDSVBotDTu/M55D9uzKozdlqWfrlLg6MznuRJTHfm4jbUMi?=
 =?us-ascii?Q?dvmSddW+hTzHlIuLjHB3wiIZXNDzwkb+Fu85SxQxLAPtgOcdHm9nt4iupvYv?=
 =?us-ascii?Q?s287TPvdOPA3PRoZmIcidAgus8/xzOqu0/zDeNXR6Xlt25PtbEhu//HNul/o?=
 =?us-ascii?Q?U6+Vve3kDby+L313fB0i1rLJwCdbeufmCt7HW320Gh5d68slUsiaslAzk0ml?=
 =?us-ascii?Q?xpU3qAhr6p6vmn+T6qD+TgfzzBNWOdOww8304XXod+RXWqxbmG+KV68ysUi3?=
 =?us-ascii?Q?+StxrHhjWG8oxyn9RTninnY5ag5YBsMy8ZX5IqeceEu1RcyHtP4IfDWEMnsz?=
 =?us-ascii?Q?sZsdCV7lrCsjglnuyuqoNptL+L86NrSb5odL5yGWkjGX3wfLxZC1S05vvAxU?=
 =?us-ascii?Q?FSE29FFHQaZu2Ib4rgEUJZEIn68IPsPoyOQWLb1e+tm5spiDJ9jzILcDoSq5?=
 =?us-ascii?Q?oMg22pnR7SGqfqtXq8AILXodSh+bneEJqACmNU+L2eTl8aKpJvn9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7df3cc9-140a-428e-68de-08debbd6abfb
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 09:59:41.7429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txF/Yq31D9PpdCBeLei3zgKC0PFi7yHNASZ9yLkJfpPkCxQ521O+K/2MBJTA63RemEBcPUOx+gDacbbl427dlgQmLtBNzTSfKPwa9Daa4cTP4WB+MI+0g6JcaOI3jDtl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12205

From: Wei Fang <wei.fang@nxp.com>

The egress count table is a static bounded index table, egress related
statistics are maintained in this table. The table is implemented as a
linear array of entries accessed using an index (0, 1, 2, ..., n) that
uniquely identifies an entry within the array. Egress Counter Entry ID
(EC_EID) is used as an index to an entry in this table. The EC_EID is
specified in the egress treatment table.

Egress count table entries are always present and enabled. The table
only supports access via entry ID, which is assigned by the software.
And it supports Update, Query and Query followed by Update operations.
Currently, only Update operation is supported.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c | 45 +++++++++++++++++++++
 include/linux/fsl/ntmp.h                    |  7 ++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 6f81f90af7b0..60e2ed68ed62 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -25,6 +25,7 @@
 #define NTMP_FDBT_ID			15
 #define NTMP_VFT_ID			18
 #define NTMP_ETT_ID			33
+#define NTMP_ECT_ID			39
 #define NTMP_BPT_ID			41
 
 /* Generic Update Actions for most tables */
@@ -33,6 +34,7 @@
 
 /* Specific Update Actions for some tables */
 #define FDBT_UA_ACTEU			BIT(1)
+#define ECT_UA_STSEU			BIT(0)
 #define BPT_UA_BPSEU			BIT(1)
 
 /* Query Action: 0: Full query. 1: Query entry ID, the fields after entry
@@ -287,6 +289,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "VLAN Filter Table";
 	case NTMP_ETT_ID:
 		return "Egress Treatment Table";
+	case NTMP_ECT_ID:
+		return "Egress Count Table";
 	case NTMP_BPT_ID:
 		return "Buffer Pool Table";
 	default:
@@ -1202,6 +1206,47 @@ int ntmp_ett_delete_entry(struct ntmp_user *user, u32 entry_id)
 }
 EXPORT_SYMBOL_GPL(ntmp_ett_delete_entry);
 
+/**
+ * ntmp_ect_update_entry - reset the statistics element data of the
+ * specified egress counter table entry
+ * @user: target ntmp_user struct
+ * @entry_id: entry ID
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ect_update_entry(struct ntmp_user *user, u32 entry_id)
+{
+	struct ntmp_req_by_eid *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd_eid(req, user->tbl.ect_ver, 0, ECT_UA_STSEU, entry_id);
+
+	/* Request header */
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, NTMP_LEN(swcbd.size, 0),
+			      NTMP_ECT_ID, NTMP_CMD_UPDATE, NTMP_AM_ENTRY_ID);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to update %s entry 0x%x, err: %pe\n",
+			ntmp_table_name(NTMP_ECT_ID), entry_id, ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_ect_update_entry);
+
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge)
 {
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index d433b2317123..e3d4ea015391 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -37,6 +37,7 @@ struct netc_tbl_vers {
 	u8 bpt_ver;
 	u8 ipft_ver;
 	u8 ett_ver;
+	u8 ect_ver;
 };
 
 struct netc_swcbd {
@@ -232,6 +233,11 @@ struct ett_cfge_data {
 	__le32 esqa_tgt_eid;
 };
 
+struct ect_stse_data {
+	__le64 enq_frm_cnt;
+	__le64 rej_frm_cnt;
+};
+
 struct bpt_bpse_data {
 	__le32 amount_used;
 	__le32 amount_used_hwm;
@@ -294,6 +300,7 @@ int ntmp_vft_delete_entry(struct ntmp_user *user, u16 vid);
 int ntmp_ett_add_or_update_entry(struct ntmp_user *user, u32 entry_id,
 				 bool add, const struct ett_cfge_data *cfge);
 int ntmp_ett_delete_entry(struct ntmp_user *user, u32 entry_id);
+int ntmp_ect_update_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge);
 #else
-- 
2.34.1



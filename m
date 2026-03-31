Return-Path: <linuxppc-dev+bounces-19069-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8111061B2E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 11:29:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flQqg2q82z2ynH;
	Tue, 31 Mar 2026 22:29:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774956543;
	cv=pass; b=G+vTSYTY/+lRm4UmJ5aQpayWZ7/jrnBKw09azGTiYhrYqv5UNHvCE+E5zzOabysWuHC09UCXZAtmZgM7RZLuJAp4TXS6iXO6Ld4w1+JZQtu+G/SJj5f8z5ITTntBCJFpFO2fJReK6oi8VjhqPZSrZZg5qgt2qNPpFyVeUqrPIlnU8m1tWmmHsHXukGBna4Lc1VVTMu1O3fRiFQPXd2wvOaP1TbI8NH6MuY+/ntOUqnoDy7hMxJqxabqLT/vU8J0IUJ8EZx0Nkmm/pejpnke3E4hnJSm6lmhoAc0dbI06kK7O9Ad/Aku/nfGC58a/XIB7zlDLELhDEnFuJlgKMWtDGw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774956543; c=relaxed/relaxed;
	bh=6y3HQpKxjRYaGQ3xgchWqZ6D8uYAKr7T5IFBIK/KRjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RcsqQzBZPnI6nD4MSL8L74KGHMdhTHQIrf5eGE0PIeCEZV53YI0teP8zNS8x6Q4Koi2xzxEtDGL8H5B5hyJL9E4R3LIOC0AbzmbK5ALEmjxYcR9GcHCRqbv3badEERefj6JFagtRgq3m+jMjXBlmQK2QIgg+17rdnv5qR5ACiLwXinUw4LtPWS69OrCzfQaN1l1siwt8Km5nmHpxQZBLpPFsZ8dHwubyStUZ/Vpd0O01MbdlHJRizBAGaioD5E6XEEwe4LBrMxDQTDB+eabzMqWOLce9BeuEjN4H85b8LCh2jd4h3I1s7oqzJFhO85hst94QGtkKVj7GQXPWVcwIvw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=LliXZDLT; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=LliXZDLT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flQqf2jBLz2yqP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 22:29:02 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBybP0s6JPYe+YIjzYiL+jIYbrUC5Uswuw02FukoSlfbfGTjy/O9tFZggqvxnnS8IMCG79Z8G/YWzaf6rDancm06LoNvw79N7jc+jFA7/n/a/H7z5ohc5qvTGR0rHfYHb4cVVbU2e/yU35HnpmTsvUbcawRTasPg/3w4Ebll2YsZIiltm2leVdWxgKO+eaXHshys1GEls8/rQJ1TrSIVj+F98YDpWEpiPXUuFPXBKKyByEZQwLdyAHaVs40x3hhNyEhQize586Kt66EvK+hAqu1UOSy+9MC5qpaiyqEgJEsCLZdPB5iIACoEcb+680XW7uzfaPPuntu9fvRhasV80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6y3HQpKxjRYaGQ3xgchWqZ6D8uYAKr7T5IFBIK/KRjE=;
 b=BeygV6BW+Bd2q9+nZcHIprEPXOia95u5wln7Lm4cVruuAqtjwJSginroWd0TkjHtGbyRCBLU7uQTrXA1KS5hhH16aQ1GMMMuepmL/HZnNh5YtuqrvldizaxG6eKr/iQ+HIqxu9lQmmY5wDhRG/oKFiMnHJFCmB43HDMcH4rt31tzCKseEkv9qTS4dTOMaUbziOwAVQWhm3GEG36LywBoqKGuzcXJAq9D7gCjl0aL6HHTNyh5OfXsk/kq1+phM9s7DUStXNsCXyILjpDiB6ZgbUucvMPyWaxWtOylRZw/ptVDMo+sVo4cyDa8bixnDBzfFbtksjK6rp0nCu4dN/T2xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6y3HQpKxjRYaGQ3xgchWqZ6D8uYAKr7T5IFBIK/KRjE=;
 b=LliXZDLTmio5atg5KqCbKj5OmP3zqX1J79vBZTz+31uyr2qMFuV1DhjPP3nviTsjTZ6JH/5Er3KxrSgjk4Lt0943sds9lwSqm2IY5cq1IShC507WFHAY9jGFFWXJRo0KgASk7/Gj0dCBJoFGqEcZ/DXx4byigILUDcMsk2cPj8oH/VWB5mPqWTafud5lKplaCsUe2M0JWQ4lHZXv5lB4RgUu14Aoqnea1/Ce9U/7dVzP1XiLrqzIHxfwSXo6HrWoyIuBIIyOPrg3hZ8AgFQ2hOApfqO9ULKdfAxNsmfiKAkvN7l1YKhnOfqxJkMh3zFyEEbsU5eAwmdkqfHiS7xcAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by PA1PR04MB11406.eurprd04.prod.outlook.com (2603:10a6:102:4f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 11:28:59 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 11:28:59 +0000
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
	andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v4 net-next 04/14] net: enetc: add basic operations to the FDB table
Date: Tue, 31 Mar 2026 19:30:15 +0800
Message-Id: <20260331113025.1566878-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331113025.1566878-1-wei.fang@nxp.com>
References: <20260331113025.1566878-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0151.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::14) To AM8PR04MB7284.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7284:EE_|PA1PR04MB11406:EE_
X-MS-Office365-Filtering-Correlation-Id: 58755c63-8cc0-49cb-ba62-08de8f18b3a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|366016|7416014|1800799024|18002099003|56012099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	//6us5m0xAMG5rWY/Y2oXv5YFjgopKvOlEBhlR3Bu7kHxSwcas1ZO0zjiJUBUDjGpkGUjE9LY/2JhuqXo6u/03w1sbMMhL4XZYImo4SuwdPPq4EgmBbbCOofJ6whMvIBB6m90BXkLhuMj+R3Xv4nltSuJkcr6VGQL7dQ+GvFiHZ+HmSj8n8u+HA7yLacpIQe96D9xnF3AXOx6AW538o86uaytzhFCjptQCJLrEKovytsqhkKGXpvQHysrwsapm1oCZkdFvMnjp3NtWU+euQPyDx3AfONoM0GhWQA/nxAC1UgsXNwH5td1lUimSl+94nnyyINgFnh2eQ2yfgofAE00F1KslNR0qSPJhvXoIWgM2w2qRerhqHAHqBmXAK9nhkGyaudttYgr+zyN6gQTum9N94ADtaNw+srIyMqMM4y9bIm6prD3shArewxV71uECuWsr9i1Ery2bJTx18mZIfvK1Jc489OnDG43hfS6lR+BGuTVi8MtrKOTTNChdfKPIXGLehnl7lXFS/Bs0mJJKZ7G73gBhRs7QzVYp/oCNtL1EOUIxmPiH4HoyZV01XFFO6kSFT2kZN8OERpWDXGZA7mxYPr4TfApqJ9V9GDEtdjXaf4x9D73IZ3FbqWykZMQR8eKeESyNVIMtZ3Zh69RMcUAJnJCldRLk609VAd6WPcrlod3qt4h18NIUdGQBn9V03sMcpefxwZjr5Xi9wHNdb7Uh4+pjv4bd9oqO6pkfwFoaDXgBHzEnoj+FDqDNqdaaUN6So95sf/VsXNfVQE0pGCnJOgm9+dk2iWbcy5+eFaf7ML0MlpNXjxe/Bs+9eA9QWL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(366016)(7416014)(1800799024)(18002099003)(56012099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ByBJZlTKl2wVfFi3KYufwUC8OzuELnQWkKvy5umf73zVjX8csDnGQGjccLp9?=
 =?us-ascii?Q?KdGGJK9r5qtuzmBXFRd8derItE8OaNjwK2nXSWvvtmYdpnzvXlpBE9MhYgef?=
 =?us-ascii?Q?VIhMazjwUfSl1Mf3RxK6JaDT2sXjE9SbmZ/I5Q3VJIi+7bggBAXr+IiIJUQJ?=
 =?us-ascii?Q?NvHuC9ljf8bq96tybnU1IGIGZst7LINV6ZHOzrIrV/EUbVL8pR70Uh7dZg45?=
 =?us-ascii?Q?p/TAFVYwKouJCAV4kc4f2/OHG3FHXjbemyjlEcQLDOcZBaFfyo5XUVBhYZbc?=
 =?us-ascii?Q?9QMpOLbPyso6GhuDzQ3C33dOQZx8rQXoOR9Jr8R07mJfTgQGrVP9WyFE++6y?=
 =?us-ascii?Q?K26VVzTM8j56TV4tugxf9Ec7B7H8e7V9gJ2Bb2XKzFHzgmD2IFj4C44ftvxp?=
 =?us-ascii?Q?q8kdFuMvLRPlq42UFBsva/1eM1haiqCaibg5+Lh0WGd/kosTftVN7RP7TWQd?=
 =?us-ascii?Q?/GR0w5t31MywROWsc2mvXAl1mdf/rEDQ3pgsYfE53NSO4IB0FnZe8Qe7nyGe?=
 =?us-ascii?Q?A9pmvspAcrhjkI7vW9laZ8Xlw7ZehAmrtVgCcgoXIuPvWp8sBVD3jX8nu5uP?=
 =?us-ascii?Q?HuM/Izt02L1J4dzB1jL6FIV3U3SUhbq5e5rsp9M9qLyH9eLSNVd3aE0mKdIm?=
 =?us-ascii?Q?NY5KGzFKwbW6RMpblrDxazNemPMlAeq1uiFTPvA+BkLuXl3PbYr3m7g8wwPc?=
 =?us-ascii?Q?L0EXs+quIVMU7t2jeCaC8xRZ/qsG9Bhl5Qr3oW2URy1scrI43GLSJDPeCnfU?=
 =?us-ascii?Q?plWpNfr27k/OI3GHIN0NjM5NlvCrbPr0VCFjJrgUPHgrqmWodlp9hJ3IjZfc?=
 =?us-ascii?Q?sNs7Vfxq/s1I4CIkNp2yquWU+9wHfnHEWB/njajkKb6hAiZCpipqtKr9NvM/?=
 =?us-ascii?Q?faqYeM+fIRn1/fMEB4YJMBmU8vu/bH2dDR5pfvNG0tdvcqkdSk6Af2L4gbEc?=
 =?us-ascii?Q?Xrju29CsSY6cPTQJLIq0tVUh7e0FciLghrQB4dIZpDtl0jCIEeMh/XV3ToWd?=
 =?us-ascii?Q?w2bndi1rTpIMyEvDsle33253vBEiHTE2Nb12FRveKtgoxH0NPLpK2I9H06n1?=
 =?us-ascii?Q?oMHWkdIdP17/zYEjayJ8M/LxjzEH99aaqDdKiJdoTNg1hDIOB/q8oHUkNyMR?=
 =?us-ascii?Q?jWNzU1lieqr1EbmtnT3PBVft2TH9VAKgyrtdYjfsJm5b26F0M9SaVjVuiMhy?=
 =?us-ascii?Q?9x+iujOe1HhDNC85PG5ZE6kSCTra9zfCeOCdnLLB1keo2YzrtMhAvMx8BC1g?=
 =?us-ascii?Q?EiR11TFlI3nUGd2ccs0eFBMw+82AlRfNbbSngPEYixd6u4UW3CeRaPWVshB8?=
 =?us-ascii?Q?z2XJDctYjsOystHR0om4p/mWHSiouxVhKF8Z/d3rIdIN7zwKq4NQyatSFy75?=
 =?us-ascii?Q?kVBrtkxkmRkMfC4gnQKew9EuhJjguaAm4zpXFN5HOW2X7fom1ZDxAy6KlN15?=
 =?us-ascii?Q?AD/ea8javTKKeZBJ0AhaG9FFOrR5R262ePc1NfrBgCtW1IuQ8Y8A3/MugKa+?=
 =?us-ascii?Q?E44kcqL3JlMVUQphfG4T3sicGd6bkuzjcq8HrpFGTUYQ08Bw7AEOb5AhuR5J?=
 =?us-ascii?Q?mh/2n+PlWYsj7S5r9Q6KiEpJoGTmKNaTF79VvseK9E8sGtadSVxItiVcjo5S?=
 =?us-ascii?Q?y8NzYqDnQW2ai68Ms4DJ+PXfI6G/smFeypdvUS12y9GSqvlEpSp1LtD7TiyF?=
 =?us-ascii?Q?nL1wxC2JC19CrQNfODbKM8SM+sItu8Di40vG+UScw6AYrDzd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58755c63-8cc0-49cb-ba62-08de8f18b3a9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 11:28:59.2254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfBkquzPbU5xsA0i2WE6Ln2j0LbSqCqptND6FVyub6XNzfRA8BQkamJC16p2MSA85C6F93eWTgTO40HBk92VuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11406

The FDB table is used for MAC learning lookups and MAC forwarding lookups.
Each table entry includes information such as a FID and MAC address that
may be unicast or multicast and a forwarding destination field containing
a port bitmap identifying the associated port(s) with the MAC address.
FDB table entries can be static or dynamic. Static entries are added from
software whereby dynamic entries are added either by software or by the
hardware as MAC addresses are learned in the datapath.

The FDB table can only be managed by the command BD ring using table
management protocol version 2.0. Table management command operations Add,
Delete, Update and Query are supported. And the FDB table supports three
access methods: Entry ID, Exact Match Key Element and Search. This patch
adds the following basic supports to the FDB table.

ntmp_fdbt_update_entry() - update the configuration element data of a
specified FDB entry

ntmp_fdbt_delete_entry() - delete a specified FDB entry

ntmp_fdbt_add_entry() - add an entry into the FDB table

ntmp_fdbt_search_port_entry() - Search the FDB entry on the specified
port based on RESUME_ENTRY_ID.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 201 +++++++++++++++++-
 .../ethernet/freescale/enetc/ntmp_private.h   |  61 +++++-
 include/linux/fsl/ntmp.h                      |  69 +++++-
 3 files changed, 328 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 703752995e93..a4a99954baf2 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
  * NETC NTMP (NETC Table Management Protocol) 2.0 Library
- * Copyright 2025 NXP
+ * Copyright 2025-2026 NXP
  */
 
 #include <linux/dma-mapping.h>
@@ -20,11 +20,15 @@
 /* Define NTMP Table ID */
 #define NTMP_MAFT_ID			1
 #define NTMP_RSST_ID			3
+#define NTMP_FDBT_ID			15
 
 /* Generic Update Actions for most tables */
 #define NTMP_GEN_UA_CFGEU		BIT(0)
 #define NTMP_GEN_UA_STSEU		BIT(1)
 
+/* Query Action: 0: Full query, 1: Only query entry ID */
+#define NTMP_QA_ENTRY_ID		1
+
 #define NTMP_ENTRY_ID_SIZE		4
 #define RSST_ENTRY_NUM			64
 #define RSST_STSE_DATA_SIZE(n)		((n) * 8)
@@ -225,6 +229,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "MAC Address Filter Table";
 	case NTMP_RSST_ID:
 		return "RSS Table";
+	case NTMP_FDBT_ID:
+		return "FDB Table";
 	default:
 		return "Unknown Table";
 	}
@@ -453,5 +459,198 @@ int ntmp_rsst_query_entry(struct ntmp_user *user, u32 *table, int count)
 }
 EXPORT_SYMBOL_GPL(ntmp_rsst_query_entry);
 
+/**
+ * ntmp_fdbt_add_entry - add an entry into the FDB table
+ * @user: target ntmp_user struct
+ * @entry_id: returned value, the entry ID of the new added entry
+ * @keye: key element data
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
+			const struct fdbt_keye_data *keye,
+			const struct fdbt_cfge_data *cfge)
+{
+	struct ntmp_dma_buf data = {
+		.dev = user->dev,
+		.size = sizeof(struct fdbt_req_ua),
+	};
+	struct fdbt_resp_query *resp;
+	struct fdbt_req_ua *req;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, NTMP_QA_ENTRY_ID,
+		      NTMP_GEN_UA_CFGEU);
+	req->ak.exact.keye = *keye;
+	req->cfge = *cfge;
+
+	len = NTMP_LEN(data.size, sizeof(*resp));
+	/* The entry ID is allotted by hardware, so we need to perform
+	 * a query action after the add action to get the entry ID from
+	 * hardware.
+	 */
+	ntmp_fill_request_hdr(&cbd, data.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_AQ, NTMP_AM_EXACT_KEY);
+	err = netc_xmit_ntmp_cmd(user, &cbd);
+	if (err) {
+		dev_err(user->dev, "Failed to add %s entry, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+		goto end;
+	}
+
+	if (entry_id) {
+		resp = (struct fdbt_resp_query *)req;
+		*entry_id = le32_to_cpu(resp->entry_id);
+	}
+
+end:
+	ntmp_free_data_mem(&data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_add_entry);
+
+/**
+ * ntmp_fdbt_update_entry - update the configuration element data of the
+ * specified FDB entry
+ * @user: target ntmp_user struct
+ * @entry_id: the specified entry ID of the FDB table
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_update_entry(struct ntmp_user *user, u32 entry_id,
+			   const struct fdbt_cfge_data *cfge)
+{
+	struct ntmp_dma_buf data = {
+		.dev = user->dev,
+		.size = sizeof(struct fdbt_req_ua),
+	};
+	struct fdbt_req_ua *req;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, NTMP_GEN_UA_CFGEU);
+	req->ak.eid.entry_id = cpu_to_le32(entry_id);
+	req->cfge = *cfge;
+
+	/* Request header */
+	len = NTMP_LEN(data.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, data.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_UPDATE, NTMP_AM_ENTRY_ID);
+	err = netc_xmit_ntmp_cmd(user, &cbd);
+	if (err)
+		dev_err(user->dev, "Failed to update %s entry, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+
+	ntmp_free_data_mem(&data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_update_entry);
+
+/**
+ * ntmp_fdbt_delete_entry - delete the specified FDB entry
+ * @user: target ntmp_user struct
+ * @entry_id: the specified ID of the FDB entry
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id)
+{
+	u32 req_len = sizeof(struct fdbt_req_qd);
+
+	return ntmp_delete_entry_by_id(user, NTMP_FDBT_ID,
+				       user->tbl.fdbt_ver,
+				       entry_id, req_len,
+				       NTMP_STATUS_RESP_LEN);
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_delete_entry);
+
+/**
+ * ntmp_fdbt_search_port_entry - Search the FDB entry on the specified
+ * port based on RESUME_ENTRY_ID
+ * @user: target ntmp_user struct
+ * @port: the specified switch port ID
+ * @resume_entry_id: it is both an input and an output. As an input, it
+ * represents the FDB entry ID to be searched. If it is a NULL entry ID,
+ * it indicates that the first FDB entry for that port is being searched.
+ * As an output, it represents the next FDB entry ID to be searched.
+ * @entry: returned value, the response data of the searched FDB entry
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
+				u32 *resume_entry_id,
+				struct fdbt_entry_data *entry)
+{
+	struct ntmp_dma_buf data = {
+		.dev = user->dev,
+		.size = sizeof(struct fdbt_req_qd),
+	};
+	struct fdbt_resp_query *resp;
+	struct fdbt_req_qd *req;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, 0);
+	req->ak.search.resume_eid = cpu_to_le32(*resume_entry_id);
+	req->ak.search.cfge.port_bitmap = cpu_to_le32(BIT(port));
+	/* Match CFGE_DATA[PORT_BITMAP] field */
+	req->ak.search.cfge_mc = FDBT_CFGE_MC_PORT_BITMAP;
+
+	/* Request header */
+	len = NTMP_LEN(data.size, sizeof(*resp));
+	ntmp_fill_request_hdr(&cbd, data.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_QUERY, NTMP_AM_SEARCH);
+
+	err = netc_xmit_ntmp_cmd(user, &cbd);
+	if (err) {
+		dev_err(user->dev,
+			"Failed to search %s entry on port %d, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), port, ERR_PTR(err));
+		goto end;
+	}
+
+	if (!cbd.resp_hdr.num_matched) {
+		entry->entry_id = NTMP_NULL_ENTRY_ID;
+		*resume_entry_id = NTMP_NULL_ENTRY_ID;
+		goto end;
+	}
+
+	resp = (struct fdbt_resp_query *)req;
+	*resume_entry_id = le32_to_cpu(resp->status);
+	entry->entry_id = le32_to_cpu(resp->entry_id);
+	entry->keye = resp->keye;
+	entry->cfge = resp->cfge;
+	entry->acte = resp->acte;
+
+end:
+	ntmp_free_data_mem(&data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_search_port_entry);
+
 MODULE_DESCRIPTION("NXP NETC Library");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 34394e40fddd..8999eafe1920 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /*
  * NTMP table request and response data buffer formats
- * Copyright 2025 NXP
+ * Copyright 2025-2026 NXP
  */
 
 #ifndef __NTMP_PRIVATE_H
@@ -11,6 +11,7 @@
 #include <linux/fsl/ntmp.h>
 
 #define NTMP_EID_REQ_LEN	8
+#define NTMP_STATUS_RESP_LEN	4
 #define NETC_CBDR_BD_NUM	256
 
 union netc_cbd {
@@ -27,6 +28,7 @@ union netc_cbd {
 #define NTMP_CMD_QUERY		BIT(2)
 #define NTMP_CMD_ADD		BIT(3)
 #define NTMP_CMD_QU		(NTMP_CMD_QUERY | NTMP_CMD_UPDATE)
+#define NTMP_CMD_AQ		(NTMP_CMD_ADD | NTMP_CMD_QUERY)
 		u8 access_method;
 #define NTMP_ACCESS_METHOD	GENMASK(7, 4)
 #define NTMP_AM_ENTRY_ID	0
@@ -101,4 +103,61 @@ struct rsst_req_update {
 	u8 groups[];
 };
 
+/* Access Key Format of FDB Table */
+struct fdbt_ak_eid {
+	__le32 entry_id;
+	__le32 resv[7];
+};
+
+struct fdbt_ak_exact {
+	struct fdbt_keye_data keye;
+	__le32 resv[5];
+};
+
+struct fdbt_ak_search {
+	__le32 resume_eid;
+	struct fdbt_keye_data keye;
+	struct fdbt_cfge_data cfge;
+	u8 acte;
+	u8 keye_mc;
+#define FDBT_KEYE_MAC		GENMASK(1, 0)
+	u8 cfge_mc;
+#define FDBT_CFGE_MC		GENMASK(2, 0)
+#define FDBT_CFGE_MC_ANY		0
+#define FDBT_CFGE_MC_DYNAMIC		1
+#define FDBT_CFGE_MC_PORT_BITMAP	2
+#define FDBT_CFGE_MC_DYNAMIC_AND_PORT_BITMAP	3
+	u8 acte_mc;
+#define FDBT_ACTE_MC		BIT(0)
+};
+
+union fdbt_access_key {
+	struct fdbt_ak_eid eid;
+	struct fdbt_ak_exact exact;
+	struct fdbt_ak_search search;
+};
+
+/* FDB Table Request Data Buffer Format of Update and Add actions */
+struct fdbt_req_ua {
+	struct ntmp_cmn_req_data crd;
+	union fdbt_access_key ak;
+	struct fdbt_cfge_data cfge;
+};
+
+/* FDB Table Request Data Buffer Format of Query and Delete actions */
+struct fdbt_req_qd {
+	struct ntmp_cmn_req_data crd;
+	union fdbt_access_key ak;
+};
+
+/* FDB Table Response Data Buffer Format of Query action */
+struct fdbt_resp_query {
+	__le32 status;
+	__le32 entry_id;
+	struct fdbt_keye_data keye;
+	struct fdbt_cfge_data cfge;
+	u8 acte;
+	u8 resv[3];
+};
+
 #endif
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 916dc4fe7de3..a9f3e6cbf422 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -1,11 +1,13 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/* Copyright 2025 NXP */
+/* Copyright 2025-2026 NXP */
 #ifndef __NETC_NTMP_H
 #define __NETC_NTMP_H
 
 #include <linux/bitops.h>
 #include <linux/if_ether.h>
 
+#define NTMP_NULL_ENTRY_ID		0xffffffffU
+
 struct maft_keye_data {
 	u8 mac_addr[ETH_ALEN];
 	__le16 resv;
@@ -29,6 +31,7 @@ struct netc_cbdr_regs {
 struct netc_tbl_vers {
 	u8 maft_ver;
 	u8 rsst_ver;
+	u8 fdbt_ver;
 };
 
 struct netc_cbdr {
@@ -61,6 +64,36 @@ struct maft_entry_data {
 	struct maft_cfge_data cfge;
 };
 
+struct fdbt_keye_data {
+	u8 mac_addr[ETH_ALEN]; /* big-endian */
+	__le16 resv0;
+	__le16 fid;
+#define FDBT_FID		GENMASK(11, 0)
+	__le16 resv1;
+};
+
+struct fdbt_cfge_data {
+	__le32 port_bitmap;
+#define FDBT_PORT_BITMAP	GENMASK(23, 0)
+	__le32 cfg;
+#define FDBT_OETEID		GENMASK(1, 0)
+#define FDBT_EPORT		GENMASK(6, 2)
+#define FDBT_IMIRE		BIT(7)
+#define FDBT_CTD		GENMASK(10, 9)
+#define FDBT_DYNAMIC		BIT(11)
+#define FDBT_TIMECAPE		BIT(12)
+	__le32 et_eid;
+};
+
+struct fdbt_entry_data {
+	u32 entry_id;
+	struct fdbt_keye_data keye;
+	struct fdbt_cfge_data cfge;
+	u8 acte;
+#define FDBT_ACT_CNT		GENMASK(6, 0)
+#define FDBT_ACT_FLAG		BIT(7)
+};
+
 #if IS_ENABLED(CONFIG_NXP_NETC_LIB)
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs);
@@ -76,6 +109,15 @@ int ntmp_rsst_update_entry(struct ntmp_user *user, const u32 *table,
 			   int count);
 int ntmp_rsst_query_entry(struct ntmp_user *user,
 			  u32 *table, int count);
+int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
+			const struct fdbt_keye_data *keye,
+			const struct fdbt_cfge_data *cfge);
+int ntmp_fdbt_update_entry(struct ntmp_user *user, u32 entry_id,
+			   const struct fdbt_cfge_data *cfge);
+int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id);
+int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
+				u32 *resume_entry_id,
+				struct fdbt_entry_data *entry);
 #else
 static inline int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 				 const struct netc_cbdr_regs *regs)
@@ -116,6 +158,31 @@ static inline int ntmp_rsst_query_entry(struct ntmp_user *user,
 	return 0;
 }
 
+static inline int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
+				      const struct fdbt_keye_data *keye,
+				      const struct fdbt_cfge_data *data)
+{
+	return 0;
+}
+
+static inline int ntmp_fdbt_update_entry(struct ntmp_user *user, u32 entry_id,
+					 const struct fdbt_cfge_data *cfge)
+{
+	return 0;
+}
+
+static inline int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id)
+{
+	return 0;
+}
+
+static inline int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
+					      u32 *resume_entry_id,
+					      struct fdbt_entry_data *entry)
+{
+	return 0;
+}
+
 #endif
 
 #endif
-- 
2.34.1



Return-Path: <linuxppc-dev+bounces-20307-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE7AFF887E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 02:48:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5drx20h6z2xPL;
	Thu, 30 Apr 2026 12:48:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777517297;
	cv=pass; b=VfXsjFpFZS9kIOANjHMU9nZ4mHSTycHmV1iT+rInCG/pUqMmijVCXkveJ4uCWU+LGWZ7dQx/tcmRdVORhRkWP2bexKBVWuySaNSj/A9S99qlIggVAsBamtYunXeDNg9ZGjy0QiMf388iDdb6CZN4wTXqCGtOqFGxd1n5Fcg/hVJNSbMtCYkFjSodoZYnA4dpKWuvHOVxqWWjlNlsit5scrwlIrupZPFt9H2RvBjbLAVnq5cQ1ba9qCwxJAk+2D6kAjU8nALESYNvyOyJ5Nh5GKwSjoVuwjNhPPl9MfdjelPgQ5Z0N/FKwlDDBZ7OJdoRayChYWyxsopND1NtgIN2eg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777517297; c=relaxed/relaxed;
	bh=gsFfoZWYXBm2hXNnHI+THDU1pcEvkVF1IrF/i74VPzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D/kbanA2VLo9lrDucO1p8XLHcHDS0Zq5AQMjZ23zipihkDPIQ0djPIXuyKLsxPakRdhgbExutUHaRzUYv0yPjbAzsyEHjJKTgc2QeAiS9XLx3qN1i0USuyJvcXpdaHSjGQIbDSexWFKIItQjbeylz7GWOqhrngKvoArOGfh/VZEwokT6fOBS5l+gSqzOZYsm6B4z/wEWep5WMrfplOXcjuy3vBtJacvWq8xarGYu+RYnu26EyKr2e5AvIaG7WxjZVNhLQ8hT0uJ4J1SaIzeawBd34uAriXlaaoQJHmhXaen/6QB9RzZ35uQcBNW86hJKOgsR8EBHmi8d1Vxi9PfSlA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Gqy5C7Ee; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Gqy5C7Ee;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5drv6vR6z2xNT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 12:48:15 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNBPLx/Z3c+6PSu43FJksWdl7Pilp+p26rV938C1xPlHqLUZs+m93NiLZyVxeFt8CgCC/uxEjmkOq1KWsM7P3GyO6MNuBA2U5RBNkZyaDH6nPWX0lgdsHsYYPo7c8WWtHDO9fprnA1EFtn60Bk1eowzjblHVyyvZLd2YtZA+GhNzkBkPmrw5HkPhSOu4hz7Ipzv4PPRaYtM84X5c+9ITrGY4ByUvAZV9l3+hmHQuuR3wSMtkNJUGsp+NzqyyGBAUmmTjL8IX+l+RU0AuuK1EAm+tqntOoViooDYohkJt/TARdl4DhBRdBQnbJqubimZl/5B1IlD0+DKDHKA6e8e0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsFfoZWYXBm2hXNnHI+THDU1pcEvkVF1IrF/i74VPzg=;
 b=TnLgN6p9LIB+aOOY0rs8VbZXZyY0FPiS8AwHWlv7v181oFY45bKMDrWBOBZA2QPO/KcrQby8pdlzmPFN36OMV8wcW6tHPBGLaP0rQ1pvI/IEXEBQq8Fp0M3XhNRojoVEia1iQ65x9Z+xcUoz09IfIxyilZTIBeNBYCUyJEbpyq+dg2ORIJxIEIaoqb9eE/PR4hT3siwJeR5Lc/F0KL8RUvcNjgcC25+KQCKw7PFAvBH1i46WKaXoBynQCw7vdBNUsDQTUAJgpNzinJGgQozq6a/lpVvW/2eahumhCUkD2dZ2S+lJ7b1Xfh2zFSeWJXBY3vGrk0jjIsG0H2YSQwugww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsFfoZWYXBm2hXNnHI+THDU1pcEvkVF1IrF/i74VPzg=;
 b=Gqy5C7EeZjS7gkPjbKRg/4IeT/kKa8TAivVfhW2szDBJlD0lcEgWAzg2LySENqBVe1L/A405WXpfZAnrwXHeBpVWOYe2mTrk0pK42UmdL/Jl5/T/XwOKM85APV+MoIGGvStFjigOMayiVgncoH83Bu2ej2d3LkaMbdyop2uxDKwlcfnr2RFypguNnwuxz3ll8gT8gtQIJTJknJ5nOr0+0FkS7ml7Ly+XONn4DUUQyWXNSk2rvjNpBH8x8zESKpoxafW2GZMhdJ/962NcGsbu6AMpsk16gSVVrCe/P1HjgTnoWoyhmGRNxIk5w66W+RuojfTiHBm0yxDiEOTfdCkYYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PAXPR04MB8608.eurprd04.prod.outlook.com (2603:10a6:102:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 02:47:52 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 02:47:52 +0000
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
Subject: [PATCH v5 net-next 04/15] net: enetc: add basic operations to the FDB table
Date: Thu, 30 Apr 2026 10:49:34 +0800
Message-Id: <20260430024945.3413973-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430024945.3413973-1-wei.fang@nxp.com>
References: <20260430024945.3413973-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PAXPR04MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f2c570-d82d-40ad-90cb-08dea662dfac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KWJMFDsfFQ76MgvOvcKb3+Vxls13bJYPNVKpda0aOh9vaGA8ky6pcIfu6ak4wjHx0xHqCC5pLK5uAC+/jLZq3eK6auwJ0zXuqh/0Sp3VWkW8QOLf7/58zMtAn/x+MguPHPwQUhq0ONbQX9GHdWZRfiPMSSkBdEKBqIKWVwbYVD6x0oZLMH78zu0R4iHtlHcOgtSin8dT0/Bof9cI1DMRe5yvcwIj+AKt8MlT0a45mVyjzSPphNXutuLazGCRcJFY4OyU9uQKNVJ/0h1QoubJayEGhbSUyHI5Zj0zjmAhalO0+XPxQF7zN8ImmYY1SRhQ/xcdpZja2KgrhpIjchT6giZoSAkNceLQvTSugOVKeyXpwBSPb8jKOC7rCfthnyM0xwk+7tCVO9gtV/LIyvXP4njn0o+5ZgIQwtnsf88wUg5PyPF2aUTBzlDk5SULw3d21zCS3vVXYiTlPK7w4mtyMnIzLMZHxG+PRggAd473nkboRMeXnS/xSGeRdujf2MmSfGjhOmCmoKvUM7k0BfbHSn1+L2sn8kioR3jlhDZswY816pfoh483+FYc3eQgLVRTGD0Xp65ooxKOWp5Q4XzjQ7ULqBGDz2i4V4x1DNFGFet3nPIamzg1sWJy/5WE+I396GNGxd7voWwM4JjGvR6mjqyaU0MUNgQDMwlnkll52m5ZancG6RA1GWCBYuR6Q9wd6SBk4BQsQEDbfzyl6X2ZQKoRyx0cK7lpoxp9wOaOUBgxUignTn64INzxJzE+Ox3Mb1XjoATjEYl7YOKjpR+5K6rzepUjLW1gu0zvRAluMODZ16Z9QngGNHjPzq6GONuL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BvFB6umCcZXTx8lPqIPbI2LPx1VQVHi5S2kxb4tyH8leofUC2bCC3z5iMKf6?=
 =?us-ascii?Q?SkqL9L0nRmr6Z5BFgnOyr33LXmLb9fKVLaW6ycZ9nCf/aRW1PamxuP7tYIvJ?=
 =?us-ascii?Q?PkRalNzDC10hvN6qcwpG0Jygh2oy65g+uZPYJvzm04DS3NEbRAmES6sKolW9?=
 =?us-ascii?Q?JRYfOTVj/a4UBVdvfv2mTPJpLgSJ86QoiQiAN5xM5PlHW5Z+YaBenjgIgatC?=
 =?us-ascii?Q?0t3AFWwZOsSthGCdwAXvkJK7kbHnM3fUFjB8qLA0tzMIwzubBCXIRPvDBCA/?=
 =?us-ascii?Q?7o6q7VmngXdM0Ed7IGmxO5If4XGz2Pqbj+i8nVLdHiLPI/5dOKjKiB2N/n9r?=
 =?us-ascii?Q?vjpTOVJ1TBOpiR/oslZ683eHDO4rlkg8TlBjRWn+UWf+AyJCIvtmNt7EWc09?=
 =?us-ascii?Q?AUTTIZngP/9Lc8MgMtoQEE1IssLNnbSK0C5MVMXkrV179USrLEjLu31mvX0d?=
 =?us-ascii?Q?0Eql0NVRYGqUEnX1FpsFn8QMqykQYWG7/x6T5GvEWG/1m/rpPjexiaidAzGf?=
 =?us-ascii?Q?n+/bzulouuaXTuw3uAEACTHRGuRmv27VyazoAiqu1U+N7C8FddqJEQgu4j7z?=
 =?us-ascii?Q?/JQ1mtREbszb4L4AG2XW7FWFrxQkHGjWfuziayc3lyN5SVDTv73MVXBpAC2G?=
 =?us-ascii?Q?6HTmajfX4oxIMC+wDMtSMKABySEG1nK1BAxYWxGTNJmblq8AggQQDpOHFn6Y?=
 =?us-ascii?Q?W0AoaXXxE0sRBl+tbLnVOA2pcd2KvgHbPzYqI/L4iTYeE+36MzFxqbRkj/VH?=
 =?us-ascii?Q?xHDNSiRM50+v92f4GaOlHkHN7UyErwrVgQZqabWjvQqb7YKEEX2kQQ8N8mRl?=
 =?us-ascii?Q?rWtQLVRhq2fqujBLayrLeyHopBFBrSXsh5b7GeM69ZY/Wp4lU3dARb2v3paN?=
 =?us-ascii?Q?qw9WqiRYATd8wCy3AZJneIZupo/QYNXLZl/g7jrPLP6tu7ecSwJgIab0YZkx?=
 =?us-ascii?Q?cyxf6DUi4n2a/Imj2Xmk3uL6vtkMU4XZMVgy71lL0LqaNq9Mnsz0rT3DOzSa?=
 =?us-ascii?Q?9tqNBa/XZCNz8PJ8XiLwm0sFsBTv1tlpV1IA4DBOtRpuoiRQAQHMY5fYoIJH?=
 =?us-ascii?Q?xwnNByByN2g/deMzrqsQhff66CQMbWSHqj3bwMcBKDewhMiinVRCjnYnmhxf?=
 =?us-ascii?Q?5baDKfwQzKNSLxl5OvPLqY/kw+8EkVeRfMIe9Wukz7pEkKxQfM6EtLtQV5cH?=
 =?us-ascii?Q?vL9XM8aRmjRomSCKoPek4uFWnhRNfe1Dw/KBR+TsBIN1jRljEF0M9i1wh1Ut?=
 =?us-ascii?Q?WSzl0q1ZvKm0kcP4PTNmoww0SV0xEwfFjkqhYj13TzmYoTmxMymTXhfmMHsD?=
 =?us-ascii?Q?TXr3oaJUW6jijWbfBQng297gGZB/oHDwfNpAccH8W/xsYlDhsrzTKPlHMrVa?=
 =?us-ascii?Q?kV8nTfViPdQriC1NtSf6BZgEdQclMnwG007pRlojyiYyKroNv9t6Ek0wMty/?=
 =?us-ascii?Q?tfY66ZpfsYpi42bXDD+dDULNfIbP1lgB0GMU/5Y5zE8B0VNhq+v9mUTQYa/j?=
 =?us-ascii?Q?5d07829A1NNidRi2lW90C0wR4rnagejKbAwm8E1i9PpWPNCBEOOHe/s4/SXM?=
 =?us-ascii?Q?ORqu0EwGtBMMijNylOZcKL2hZFiZDqZE35AH+b8baWbrfZRzqSEPajYzVngA?=
 =?us-ascii?Q?7nUKSt2f6FloG/yuKL7JYwEyLpjOKS2nVsvS01nbloKLRcGXQwotyZG3NLnn?=
 =?us-ascii?Q?2k0uHmJZFQwyVJMoX68huQrIbFq20qH2chmiKurkskjCRzLZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f2c570-d82d-40ad-90cb-08dea662dfac
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 02:47:52.6405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mf7AL4FPYJw8WsshTl2WafAo8JPaQCBCvMTFOuyDSPoFJnWDqFuGrreEQEfbLsIhV68VkYFJ2MWhij8ZArINmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8608

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
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 203 +++++++++++++++++-
 .../ethernet/freescale/enetc/ntmp_private.h   |  61 +++++-
 include/linux/fsl/ntmp.h                      |  44 +++-
 3 files changed, 305 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index c94a928622fd..4ed8d783a9a2 100644
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
@@ -21,11 +21,15 @@
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
@@ -260,6 +264,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "MAC Address Filter Table";
 	case NTMP_RSST_ID:
 		return "RSS Table";
+	case NTMP_FDBT_ID:
+		return "FDB Table";
 	default:
 		return "Unknown Table";
 	}
@@ -496,5 +502,200 @@ int ntmp_rsst_query_entry(struct ntmp_user *user, u32 *table, int count)
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
+	struct fdbt_resp_query *resp;
+	struct fdbt_req_ua *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, NTMP_QA_ENTRY_ID,
+		      NTMP_GEN_UA_CFGEU);
+	req->ak.exact.keye = *keye;
+	req->cfge = *cfge;
+
+	len = NTMP_LEN(swcbd.size, sizeof(*resp));
+	/* The entry ID is allotted by hardware, so we need to perform
+	 * a query action after the add action to get the entry ID from
+	 * hardware.
+	 */
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_AQ, NTMP_AM_EXACT_KEY);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err) {
+		dev_err(user->dev, "Failed to add %s entry, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+		goto unlock_cbdr;
+	}
+
+	if (entry_id) {
+		resp = (struct fdbt_resp_query *)req;
+		*entry_id = le32_to_cpu(resp->entry_id);
+	}
+
+unlock_cbdr:
+	ntmp_unlock_cbdr(cbdr);
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
+	struct fdbt_req_ua *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, NTMP_GEN_UA_CFGEU);
+	req->ak.eid.entry_id = cpu_to_le32(entry_id);
+	req->cfge = *cfge;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_UPDATE, NTMP_AM_ENTRY_ID);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev, "Failed to update %s entry, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
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
+	struct fdbt_resp_query *resp;
+	struct fdbt_req_qd *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
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
+	len = NTMP_LEN(swcbd.size, sizeof(*resp));
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_QUERY, NTMP_AM_SEARCH);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err) {
+		dev_err(user->dev,
+			"Failed to search %s entry on port %d, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), port, ERR_PTR(err));
+		goto unlock_cbdr;
+	}
+
+	if (!cbd.resp_hdr.num_matched) {
+		entry->entry_id = NTMP_NULL_ENTRY_ID;
+		*resume_entry_id = NTMP_NULL_ENTRY_ID;
+		goto unlock_cbdr;
+	}
+
+	resp = (struct fdbt_resp_query *)req;
+	*resume_entry_id = le32_to_cpu(resp->status);
+	entry->entry_id = le32_to_cpu(resp->entry_id);
+	entry->keye = resp->keye;
+	entry->cfge = resp->cfge;
+	entry->acte = resp->acte;
+
+unlock_cbdr:
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_search_port_entry);
+
 MODULE_DESCRIPTION("NXP NETC Library");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index f8dff3ba2c28..b0b5805ac4f6 100644
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
 #define NETC_CBDRCIR_INDEX	GENMASK(9, 0)
 #define NETC_CBDRCIR_SBE	BIT(31)
@@ -30,6 +31,7 @@ union netc_cbd {
 #define NTMP_CMD_QUERY		BIT(2)
 #define NTMP_CMD_ADD		BIT(3)
 #define NTMP_CMD_QU		(NTMP_CMD_QUERY | NTMP_CMD_UPDATE)
+#define NTMP_CMD_AQ		(NTMP_CMD_ADD | NTMP_CMD_QUERY)
 		u8 access_method;
 #define NTMP_ACCESS_METHOD	GENMASK(7, 4)
 #define NTMP_AM_ENTRY_ID	0
@@ -97,4 +99,61 @@ struct rsst_req_update {
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
index 83a449b4d6ec..4cfff835954e 100644
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
 
 struct netc_swcbd {
@@ -68,6 +71,36 @@ struct maft_entry_data {
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
@@ -83,6 +116,15 @@ int ntmp_rsst_update_entry(struct ntmp_user *user, const u32 *table,
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
-- 
2.34.1



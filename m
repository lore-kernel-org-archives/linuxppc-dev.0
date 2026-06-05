Return-Path: <linuxppc-dev+bounces-22076-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407F1CD6E79
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 01:46:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWkmS34T1z3bxR;
	Fri, 05 Jun 2026 11:46:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780623960;
	cv=pass; b=H3M1HxQ3PTh7bQZt50GrAaH5IkVe24ig3WM3mCO8k2XSsfSgh5q+m0mik/Oex3apar1oatl7cY0sOuGjpuo+UedJKSMNvVrD7NNl//iD2oxNtgjgxR7gk9tJTVYzftdwHnuDGRV1DcaiD3caJRB15QgXsbO/N1giPh22MGHB43G4nxQJimrz76kqUUo9Pq/Th/Ih+MykB1eAjFSgmDxAu2QG2I7LJq2VhVRNBzHEkR8PpS64Yg8P3mZCoDkIXH41Cu/yOpz2A9J8Fij5GNp9w7xkBjakEwmWcSvxlgfuVt47VmxBaK6jxlN6dx0xQ2GHgWZXVKTIzFaIzZm5VIzFhA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780623960; c=relaxed/relaxed;
	bh=3xEuNbFobIfq47a7fzRigST3BA251er9sMioTh4rLKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V6/E1tjOy9kD0D34wGpqbbMmfRpOybT6hHt6ulCut4NZcF65Ptockri3ziO23wiL2JpqVT+0oHVCem9wrzld+9ybBnaNCkbWUTS4GabhKTVZFHOEYbSFY06nYuq7uAG4JPs17R4nd+uBJPCqjRPhySfRnzMkrnCBKe5qfV83THmiwX5xVbqFSzhc0FL0NlEeWD+a4iL582S6kU3Wpk0/2YtovqWVxVmpXfjHfqrBPDiQGvBqhCCP2aic1RVJXozxDL9w2KNAgOtzYG7RY/TfJB30FBUWr0sO+KDDQKYF5frLbzOTmjqwG8b/b39Q3fv6dOtXHLJIkl+ER5sQSKXYbw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=xfn3leJ/; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=xfn3leJ/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWkmR5NtDz3bpM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 11:45:59 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFHm15UyQdUAwUXwSxbTYacp9g7py7csJ87vnW79KTYXhl26VxjQEdBU7QLLlZC0ckdCELvhbqI+2+RsAWAO7tW8r0OStRF5T8VZtqfBtGKtgqcmcC92QVpI9IqHK8cJvWkLeYec3NuaiBubZ9PyVTYPWVXywu9T2ZnvAEnAvXmSAiqUI2qEjVM6hQ2iOo69QeL1fE1pgfk3JTcQckSnFQXHALFvSGRiA+bMGvs65Foo3OJF68JZIRfP6QScTmSiGCeGsUM2Y0ul9HxQGRZRjL8X3QHZ1dudMMiG7MyTv3oIkA+1wfNeoMOVrD3tqZacu36gPRAGoipkCD2uCLxNow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xEuNbFobIfq47a7fzRigST3BA251er9sMioTh4rLKY=;
 b=REDEIFEMPYVP7uJ+ixC1B4fQv4oTGTFcPQDL+O6Y2RQWAd8H3kQRK0V7SDaphkij8O367brGO1G8iNu+8IQSUo88+y8G7vnVYq6jkXcKT/jdEOzpZzB/0xa6ZMdlw11CtFQcqwdSHTezeNcc2Kp1ogxhaBjJwp6BV12mbtOvA02AADpwyil2AJLEbFF6M1O1VcVr6EJoqYBkYrqYZlcC2itiAODbZVWZd5YEvS9mH9RgwJd7olu2EngZvebWWobaA47CouICpoAKi3nCqpMZUz/d/hjzIuiyHPQxLPGl/DQ3LMdFT5C5VQQdHIYwkaGi95dfTWdhoWgb9yhcKbzTaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xEuNbFobIfq47a7fzRigST3BA251er9sMioTh4rLKY=;
 b=xfn3leJ/mxr9CxN1mW5H/tGroLEmPR1rNQE5kAuvwge47Ykeo9u4QKWfU1OgxSdSS9P9yz8r1ooZkDsuAMRX/auO/9hZx6sw77aflqDMBi82hjWUglN/M27RfMG1zVvsNGNAFhQUDJmhjo2+4FaUGEq3lRXEL8aQSTjGpWRjxLRyrutPd8WOzjIn8dwlZIHKNlv0fJQkdUiMwC4TUpclneg6j6BlhbO4JjjC6WfRyIU/pUI8RLbFPA17jj3qzgwpO1fRYZTJfprvEOH2XNfCqiD7DD3qmMESW6QWUf2hfQKqXDIHVTW3jqw5SMbI8zODdYiGzVNIKykB4ciC+H71Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB9375.eurprd04.prod.outlook.com (2603:10a6:102:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 01:45:37 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 01:45:37 +0000
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
	olteanv@gmail.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 net-next 6/9] net: enetc: add helpers to set/clear table bitmap
Date: Fri,  5 Jun 2026 09:48:05 +0800
Message-Id: <20260605014808.686024-7-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605014808.686024-1-wei.fang@oss.nxp.com>
References: <20260605014808.686024-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB9375:EE_
X-MS-Office365-Filtering-Correlation-Id: 55bc8207-b7b4-459a-e585-08dec2a423ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|1800799024|376014|366016|921020|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	QpgycvCz8hCxDtEIZNF+X2bDZhvAfu7Ys2bD5+6FTGSr9YkRZllNk2UIeUrbGwdaYzuNNIv4uadtwGSg0C4kVy3H4pGSwNapI3y8wf2HeGPVIC9poP7Smawr9yyhVnhMo/6Yppy6/PtVB6oBwoXA4rYVBMHe1xKeEj33KAy6lXxwt0oEQi3ptLHeWogqUy1rLmlb7Qo8AwbY1awD3Ta6uyKefymasZ7aTAqiddiIcKJv4uee971HfvMjFJs2UTMjdEvH19W+l2HyHMzUV02SMl/THjidQcnh6KNeKnDK5SbRRo2OEOQRPkYsGv09bKZasejqqPExKBeiHwoRSOG1qtQyYcbbBLAiqf8WHERhg59yF10frTeRF1bA2qUD2XWTsaj+xAAzLDJoLS2nJI8F6xkuf8iSkZoxzdKw1Q1e0FeC5r3EaxgYtcyRkw5ocjtaNtxIA4rT/pnn268gK9yfZqRWihtustAF9ZUbrd0y582qnbfW7Ca1a/+i/vlFuZuJYetPQfATXP0CegLAFIsyrcRt5QogTBn/Yaz3tWHBSta4IPlJ+1gPMEwiDagoqQdpuswOopIdnJR63St1Y7+RefMQkE8izLDmBKO/WPXoGJLKkTIhX4RoDGkGY2pZCkDeDlTjIwzQDruNPoZzHdl0C3pQWFqDxgr0bz3OjO4CXhBtM2qWIPYRJQBD2cC1wbz6uHP/fZHDZanpZxiW5S2obenhlgHrKmsNW17IZVl4YCI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(1800799024)(376014)(366016)(921020)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hLiTfLVvXnX8cm6mMsamF6ybhDYhWnUA+sOTfAdG26g4Zx2McpI+jZ7CJoDW?=
 =?us-ascii?Q?pJ/6vQmA4hfxCvlve2xHx5UDBMMxYbtu2PrxaQuddWegWbLwB4NUi0KcMj/f?=
 =?us-ascii?Q?ME604j7GtqIhe61UwMaz/QRBWICdOq22sPRdMMMDyGj/gRTTbGCDE/YlM8V6?=
 =?us-ascii?Q?7st+V0pGFoWSfmCWE90lHKAf2EXWUjnT5mE9nyDCdp8tEnetYGVLKIVFRm6i?=
 =?us-ascii?Q?Xh2kFBwlzpg7Mn19trlT1syHyF3oBNE258OnQZ0KpQ0GxbWQN+kXvZSEU88G?=
 =?us-ascii?Q?xAqB/iq03A1FbgNaj4plAYAs7GQaGAYsJQHn024xD+Zxwayw67pztQ71K/jA?=
 =?us-ascii?Q?kli8vFJhxZdEABtcim3f3YwLsV9USlp1CSgt7fXhqoJnmODTpvqFZ1d/Q2o4?=
 =?us-ascii?Q?+zDT6uzjzHIDFam+2MQQ++v8EPmgiZZjc2RbZ8Sk/cuULwOUvK67VSYQ+2gO?=
 =?us-ascii?Q?78xrTRsl66nuXaQ1mIuzuVoHSniigy+atM+AI2ePjjUsQdkAepIu2fPWlZ0N?=
 =?us-ascii?Q?v6nOPzgsy44KhtOnquOY0kFKWgN/WrYjGX48HErg5iiffsiZGc3QS5xI1isu?=
 =?us-ascii?Q?bOyiZCRnOMqTTXTGKtIKg51Rq0fO+6AVPKgup03O5Ki5Hl8d9GzqNlSOdafx?=
 =?us-ascii?Q?ftypESJc0SIhcWP2a/Pj7dOhdC4x8cOvDgCkAT2PeVGmcXP5fHjseP7ls7C7?=
 =?us-ascii?Q?cCpJKe78klPLGU/vMd7OLqyfWmg8DvMVp6l2zIsz8MG6X7uhtdfLnOe6ItJD?=
 =?us-ascii?Q?8KLIkZHEW0K/C5PhgZAKangQijjXv3P7fL+TNRnFh6nZHg8AHJ1Ilhpfq3Cz?=
 =?us-ascii?Q?bHgR8fzymbbyPB0WIVCDoMVQyraMfbGMR2AWIABqmbYJLzp4AJyaLO0Uvr6s?=
 =?us-ascii?Q?TvGytL3c3Aeo5oyJ9jMPn2EXHXTFZew/nZ/LBIIisg2nKvDm4R86rdIrD4NM?=
 =?us-ascii?Q?Lk9KVJiUptLHB63Uumyx6eQ7CDmzdjRnZciVIp1MxoOJUM/C6jIorFiml0qE?=
 =?us-ascii?Q?TYvy1wwnKRMAQP4FpdYF3p6HrDcO0gdbBlNhJ4Kk0cBuTBKmIbTt6FrvSJQl?=
 =?us-ascii?Q?SI7R7EqAYkf86SdDObCyZDdKHjTLDJcktiRZf97dyIpnIEinitGPvUs/H09E?=
 =?us-ascii?Q?WoUBOY3AbgY15t42P++GCdf7JBzLPFHkbLKUz9fjx668NVmkahrZ778DS1MP?=
 =?us-ascii?Q?E2E9DwhbiFdH5n3+R+JqkAQYUpe/gzkKHS7zLJj4Z2stn5w0vEizyDDbkFT6?=
 =?us-ascii?Q?gsiLWRBDk2hJb8z1CjXVtY3Qx9yahbswdKb+6E9E9I/7gZ1htK7cNx6dH3EQ?=
 =?us-ascii?Q?5akuAwJtJJXCN4XucUAsijE1T/yahMCSWaLWVPLlKy15xgaIpo81I2/3BYdk?=
 =?us-ascii?Q?Al/RaqVYctMZNBvNhE5jSROtn2gQNsg/HqimEh3kN6BlOTT8iPFuUbTqXZ7P?=
 =?us-ascii?Q?/eLv80wPpY+t8aKGRUrBLZb7Ctz8CcGrP7n+c7++d1nttFktJKvlB4bxgeCe?=
 =?us-ascii?Q?CrKPtT6cWgLRumz85yKOdeKNe/kynWKJ48leMy5jyCfPZWsSOAqYYofSRxEc?=
 =?us-ascii?Q?Fy4yAhfaFd2ZQKIxQOMOLJjq5EvHArYIVoP7y1xCp9ccmNQT/2NDlKanDEma?=
 =?us-ascii?Q?ow4sJMQ4JRxs7lv+oMpDQ4HVSaI2sds2kLXcDZjjrmQkh2qyc0rHHZI3n99e?=
 =?us-ascii?Q?+7JIFQPq7axm0DOPqLXPeGb394oE4Lmgf3AAYGZ4R1vhtMuvYiirkaUb4eZQ?=
 =?us-ascii?Q?m8Jdu6kLNJq8FrLi0sg/7K7CKLMKN6tQKu8EbmDUD4qR7/Rxy6+B?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55bc8207-b7b4-459a-e585-08dec2a423ee
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 01:45:36.9206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQjQ7jKE9H0VyiSpBo0fHGbnSdkXz0M9Mk2Y6oCHzLl5+E8LwExyPsoGN/VTx2xSk3W0L76L9Yyv4ljNaGjhDsmjduWzGqfH7OpcCJ9VYK3bptlBukCvH/ZRitSGSsN4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9375

From: Wei Fang <wei.fang@nxp.com>

NTMP index tables require software to allocate and manage entry IDs.
Add two bitmap helper functions to facilitate this management:

ntmp_lookup_free_eid(): finds the first zero bit in the given bitmap,
sets it to mark the entry as in-use, and returns the corresponding entry
ID. Returns NTMP_NULL_ENTRY_ID if no free entry is available.

ntmp_clear_eid_bitmap(): clears the bit associated with the given entry
ID in the bitmap to mark the entry as free. It is a no-op if the entry
ID is NTMP_NULL_ENTRY_ID.

Both functions are exported for use by other modules, such as the NETC
switch driver which needs to manage group index bitmaps for the Egress
Treatment Table (ETT) and Egress Count Table (ECT).

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c | 24 +++++++++++++++++++++
 include/linux/fsl/ntmp.h                    |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 601435966ed1..9f38f885ebb5 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -47,6 +47,30 @@
 #define RSST_STSE_DATA_SIZE(n)		((n) * 8)
 #define RSST_CFGE_DATA_SIZE(n)		(n)
 
+u32 ntmp_lookup_free_eid(unsigned long *bitmap, u32 size)
+{
+	u32 entry_id;
+
+	entry_id = find_first_zero_bit(bitmap, size);
+	if (entry_id == size)
+		return NTMP_NULL_ENTRY_ID;
+
+	/* Set the bit once we found it */
+	set_bit(entry_id, bitmap);
+
+	return entry_id;
+}
+EXPORT_SYMBOL_GPL(ntmp_lookup_free_eid);
+
+void ntmp_clear_eid_bitmap(unsigned long *bitmap, u32 entry_id)
+{
+	if (entry_id == NTMP_NULL_ENTRY_ID)
+		return;
+
+	clear_bit(entry_id, bitmap);
+}
+EXPORT_SYMBOL_GPL(ntmp_clear_eid_bitmap);
+
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs)
 {
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index e8b1bd802f19..4d329488763d 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -266,6 +266,8 @@ struct bpt_cfge_data {
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs);
 void ntmp_free_cbdr(struct netc_cbdr *cbdr);
+u32 ntmp_lookup_free_eid(unsigned long *bitmap, u32 size);
+void ntmp_clear_eid_bitmap(unsigned long *bitmap, u32 entry_id);
 
 /* NTMP APIs */
 int ntmp_maft_add_entry(struct ntmp_user *user, u32 entry_id,
-- 
2.34.1



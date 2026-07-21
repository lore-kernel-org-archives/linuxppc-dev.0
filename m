Return-Path: <linuxppc-dev+bounces-24623-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12529C44538
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 23:17:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4YDh5Tnjz2yps;
	Wed, 22 Jul 2026 09:16:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784675812;
	cv=pass; b=BZtl78TorvknWYdpsWEavFRbHyWUy3nU5m64wh5NNlPvEjsd2pObnNRVf8/qzxxaQg4nkvu3wDz0Y99o8j5lZuebuavJ5LW6d4XtfAXp240mYUAZmZF18gAGDNQBwwq/SruV3RxMdOqHntoi8hYO7Z4gP7qLjbfrDnSnsxNy8DebL5DouIyJw4QlS6zJTycBlvgbRx0ZtC92PvL5jhDle2nS3HkUxW+k0sWHY21bnKiKYvBE9rCTQVtoMI/2VPZOlQ7+kGrbThfrmkFdt5tiRtLqjZ5HMPaXzmmKdckaBtCHcXrkETVJ52DYybCwN15zOstlgMyYDZnANzDQAH5Bkw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784675812; c=relaxed/relaxed;
	bh=t+g0e+Hb5UAKjandlK+7YhB4+rYzl3Z0RX0jeuzCbVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YRFj0HGvxpK4gU9ZmBwxKZUrKdZJmuXWwJZpuT07O/fylLTzGHR9py7rSYAm8FcbWmBHIrWXo5AK6C7TBey/nmrjeaBo/WvW2gWWKvDonFMHODXbt8YPh5+0xaTN9ieA1pdIcXTZU5iLSkHdTl7J8nA4SscT/IoBLial8ta/YdLpd2cefwmJ9VjLLeZPZYyjFvVOgL1FXPdTBPFRdT0kBUe4pP5q1jeziQzvtgOl2TreotD3CfFhmxRXJBtgB6wE++NRp4+nloWidjigPSaWIS8A2DUK2sXLyXVLLLQ4+2BO2gL/YFjC3rjm9sIFAVv57tcKESUAJoQSgk6VjfcOyA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=HDN9VI5d; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=HDN9VI5d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4YDg0xKxz2yjx
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 09:16:51 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MeihQWzMdGrKa73OEmP98mnI78GIlgIbkvkg1PuDTUlBWt/1H9l/TyxJeaWASu+JiSA/d+Tv0/ysesMzHwtYDlxHBLWQc0/SATO8mu9PFN5Ajr82hNbSVTXvMpUwlBRUjePzQYaR+NKmpJrrI2DZmlD6mqldA9MR54HrUrsaqin39ac/X6BVUpJrI9y8f+K+lDYC98aw0LVJ9gxIpyyQXPKzUlVCoV51Ts0HY5cbkK65qeJ6in5HooR26ZIjjLGfSjlFsWIiNPfuktlzRiAe4HBtiM/eGESrQ+KRYDANDQ+zHRTMXwIiAU60hgdSvGlneyXbCag//MCdf/uhiKeKkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+g0e+Hb5UAKjandlK+7YhB4+rYzl3Z0RX0jeuzCbVY=;
 b=drK1mGzcaQnN0AeybA+DDHYWiGXNYBGM8mMAMBxKF8ckBabFgiTVwIVU1I/+oMwEtuklx+dc/0jbeY5c4NQtxAeVqwVb5oJpfRVm+E7J/kqr+j1b2gUGI/cisbGJe1UYxkDGXFricHQ6uPAPWU5tSTPVla2chXjwmD8Gcmg5RaQYhp7dWtqMUosByvtQ23zXjSSId/rVQwuzP5+0xZ3GuMimtwWa0nrUuk4igQwOTySlWlaLRMh0spx3+fHnQ4zfpoBmqwAGDjLruLQhTOtEjb40pOyin6H9wuqwE8En0dKdbRd+EjB0rj4HE8/2QbtvlvV/WFGYLwtjRF+CDCd80A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+g0e+Hb5UAKjandlK+7YhB4+rYzl3Z0RX0jeuzCbVY=;
 b=HDN9VI5d41ggCWgS2yZAFfgeU6amfh2lIG9jIF6Fr9zQ+kovflCFePY/qfJZ3cBXmGzsxd+DImh72QJd01jUa/O7djIORwfTgnhqdCpFKyH05/6U4/TrkzdroxsaVE5tn95bbkirOE4IpRU99zLMRwe2YbphfoMTxUHDj0RntSwpbjywtO/Ok3rOSSJjOe8f4PfqG3LVZJPZLTbKhi8/vorVpiijINcV+x4PDn1g6el1jDrP3gqg6ERJZN3d+6qwnxNLG5ncKDm82UuUnet1U7qXUuj8OGm613WKk/VKxCT49LPRq5DF4xMq2/6Cq3s9NtWpP+bLnGmSGwPmtoI8BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by VI0PR04MB11817.eurprd04.prod.outlook.com (2603:10a6:800:2ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 23:16:22 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 23:16:22 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tanjeff Moos <tanjeff.moos@westermo.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 phy-next 5/9] soc: fsl: guts: make it easier to determine on which SoC we are running
Date: Wed, 22 Jul 2026 02:15:59 +0300
Message-Id: <20260721231603.67865-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721231603.67865-1-vladimir.oltean@nxp.com>
References: <20260721231603.67865-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0010.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::12) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|VI0PR04MB11817:EE_
X-MS-Office365-Filtering-Correlation-Id: a6fba0f8-0e02-43e1-235f-08dee77e13fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|19092799006|1800799024|366016|6133799003|11063799006|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	tc0AtHBv1ZlRlGp1+4fnyblX7rI98aGewGM1pcxJvGZujuN2CNFQ6pgJV/Cf3ys9+Xs08kCdyxBIpfVM7CLR568v3y3Tzk2JVPjV7yHdLrqYf/0l56ehFNIdqMzjakGNhXAsH+GK9wZ/zQwEutstE2EHFkxJt2pJ0+yK7/ghka4tfgqR6Ds0da8X1elkEjNlDiGwd5AHkQAc7FVC09vrepABDCFBXqRBtIA9rxOIJSUBSZxWmI0IIoqsUohwqJ5mkI7P32CiPJd9t41I/HXRJxb1YmWejr2uBMz8WroYaqlxhyF7s4QoZCHk4pZ4H0ZmtklKqza9pKZ9vr7xbTYQ4hueTMj2InlvtCfwTPcTCrYs2iNGqvj+wylabLEx6+mmT40sk0CyM+mNmMvIKYFO+EHkDmkpV8uzlWdtBlhPEmpj4CFnjb+nv+LwGdqc2wrJo1G9b3n4OC6yqUJoyBArQltpmJcdC2A69aHjlO9Nf+tRIwa4JqzqezRntESbFmkyq+/whoy7mFP0dqiUszf2M5IM18wBVaaUiyOHpjuhdXM7BdquMN6zaYe0MOMX2e/NCm+uHU/2p1PV+cstNkO0HSR0lzwVzAcPXZ4kE605E+LhmOGR4qWheYYW0So2wwrxQLI2IawzMzxyDAobR7C8yR8M8JCoExeVXhJOrGL5Fak=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(19092799006)(1800799024)(366016)(6133799003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FeLdPDJ2oMA8am5leWS+CsUJL5Gy4Af6KjQc6LZ5lY65cBD/vGGZjapgl4A8?=
 =?us-ascii?Q?dAbf3DanMciWcHAw7cD7fltE3YPvZ1r8NYeUd+p7OcV2MnPZVkY8AC3cAf3o?=
 =?us-ascii?Q?d0zdCFTw4BziNDaMC0K/O5h5TSpRO0YnPdZF1slZgXsNirY6gB/XFH90jBCm?=
 =?us-ascii?Q?VxUK9F5aqR4IasSMa1xWWvWJAlyu0nNiGIR54durCnzZ6KNU86lzSxK/oLT7?=
 =?us-ascii?Q?vjRdrPnb0Dw3RE7b0inaaQWGGlR5LFtXd8eAYrZeXquqP66tiRJ0awCHvoCE?=
 =?us-ascii?Q?ujK+YGh6R82F8I1UbSbfdC9vTR8njWPObgTF+tCD4zAb56jxdZ6+NYzldgF5?=
 =?us-ascii?Q?QLX8O1jUtP7O4kma40kLxGpMtlyqdbnYqKJFu4zMY/uUCXKPzhe4q1nNRODC?=
 =?us-ascii?Q?ZYWNkfQHm6Mmpm/a81cLPNQDtFvo0eKjAQkE9aw/RTYQDWQ77RrxkiNSw3kB?=
 =?us-ascii?Q?WaDWBlMFBES6bbYl/SxQtsp8kAEHoCz1Us9YgGDp+Pf3OfD2bMcD32ET1XrU?=
 =?us-ascii?Q?jVxfK9e+Wz6zB6LFv1249LZEfOSp+EzEmWGpKy9k61WUfzpzNULOBwh7bH19?=
 =?us-ascii?Q?qa1EWldzBNY/SmpiA32VUrLgszkOJ7FqbLp6u2n7Wsp0p2pn3E5ewTHid+D5?=
 =?us-ascii?Q?XAGUpOGs2DHPTBayAu+mrR+bC6Jcgwzj7RxwdXdeVzucEl7HqwBIGjMhKug8?=
 =?us-ascii?Q?Fu+Gb2mQ/2nII/h1U8EZHumJ2Gfw/nCLzZqMvE2bFtxmWImYxPfRkmaBVhd9?=
 =?us-ascii?Q?YBcvPCTQ4iTgWrOtM+IUjdQUJncloGnbcLRycpIylezSsk/evgYFdD4RTX3l?=
 =?us-ascii?Q?tyMQ1543NiKiiv9no1yaDfBz6Rh8o8EfOifznEFlp90Se0/+uuEHmYNlEg4b?=
 =?us-ascii?Q?LiOKStAxJEw6KoPbHSID8oHACuFbJP3fKGm6cHHfE20ZjatlmCTODH/pIn34?=
 =?us-ascii?Q?GtFtT96MeKBUbibSDGfF5WjK0IQclp5aYS5xsa3OCWBMXX/ipV4RzxYz0yx5?=
 =?us-ascii?Q?E/XtXX3W3TJi+uxQ1zEE01ZHUgkmzelWgSvyQqBAchV7lhP9qOiKhutVt4M0?=
 =?us-ascii?Q?R5+i6LqwRuUz70VcOCxt5QoGhMv5lWMO1YSIhDP1bBeceuI7mg5i1yNAo4M6?=
 =?us-ascii?Q?JR5d4b16o9XSfJQLCDq1mAJmO27Pfbq+GIB7QJJ069OudgsCr7tx+tc5Tod1?=
 =?us-ascii?Q?NXOS9nGhLKyWD/dTR2RJvIQj585R6ufw1OnsIg+QbxRjJSWqEQlFjncew1OY?=
 =?us-ascii?Q?l+D2VMrEOUX0O050gHBlao8d9XQiGJjyA09BWovzDIYh8xiNQy0QRFvpJy+r?=
 =?us-ascii?Q?MCgB91I6O6fvtubsX3OJtYvJVEcAP0v4DyCr97cQd9vHucrYOQFXZ5g2ZKRv?=
 =?us-ascii?Q?jP3BDE5W/1uJiLDLD+y0ivi8E/DfCXGkJQvUALgqsq0YEVBL0jCQ7WEyOgqO?=
 =?us-ascii?Q?6+Xh3N1Wyr9MmfmhwkMZaqtOikmNZRzZzJbdxPsfXh2sA3It7/7Fj+Lpmtfr?=
 =?us-ascii?Q?u0udR7zQQn489NmFWAWagLIZRuBx1LibEkTiSyL1Oev7E3l2SHbTQL04aaQg?=
 =?us-ascii?Q?LG3k1HpxJ5AuUE4GrBKYLqeh/+1LWa3aWo3/W921GAwCq7S0wmCje51qHGjs?=
 =?us-ascii?Q?8y/IRM+9hyF3Sku8PPEmSrM6XtRUEuItV+T2AVesTjanWQrOA8OP8KjSWHhh?=
 =?us-ascii?Q?ZHJ5UXzRcp9lKk8ROaV1B6/vgvS4XkC+Wl1wcw08zgPYPh120s3/lSZIi0Mj?=
 =?us-ascii?Q?H1rYnIXGAQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fba0f8-0e02-43e1-235f-08dee77e13fd
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 23:16:22.1452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +APHbQiqt59yRRvYoQ84v1arCJbAHaA7w/iy6yVPDCfULCBwSwfHtNoEWR0J1H0gFoF17AZo338DE2tTwkp3/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11817

From: Ioana Ciornei <ioana.ciornei@nxp.com>

The guts driver will need to easily determine on which SoC it's running
when it will need to perform RCW override at runtime. The guts driver
knows this already because fsl_guts_init() reads the QorIQ/Layerscape
architectural System Version Register (SVR), but it doesn't save this
for later lookups.

Add a new qoriq_die enum to be used as an index in the fsl_soc_die
array. A new fsl_soc_die_match_one() function is also added so that we
can directly determine if the SVR is a match with a specific die.
The SVR value read from the DCFG CCSR is also kept in the global soc
structure so that it can be accessed when needed.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v3->v4: adapt to different error handling scheme
v1->v3: none
---
 drivers/soc/fsl/guts.c | 47 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 8e5c3cae811e..15674c6734c6 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -27,6 +27,23 @@ struct fsl_soc_data {
 	u32 uid_offset;
 };
 
+enum qoriq_die {
+	DIE_T4240,
+	DIE_T1040,
+	DIE_T2080,
+	DIE_T1024,
+	DIE_LS1043A,
+	DIE_LS2080A,
+	DIE_LS1088A,
+	DIE_LS1012A,
+	DIE_LS1046A,
+	DIE_LS2088A,
+	DIE_LS1021A,
+	DIE_LX2160A,
+	DIE_LS1028A,
+	DIE_MAX,
+};
+
 /* SoC die attribute definition for QorIQ platform */
 static const struct fsl_soc_die_attr fsl_soc_die[] = {
 	/*
@@ -34,21 +51,25 @@ static const struct fsl_soc_die_attr fsl_soc_die[] = {
 	 */
 
 	/* Die: T4240, SoC: T4240/T4160/T4080 */
+	[DIE_T4240] =
 	{ .die		= "T4240",
 	  .svr		= 0x82400000,
 	  .mask		= 0xfff00000,
 	},
 	/* Die: T1040, SoC: T1040/T1020/T1042/T1022 */
+	[DIE_T1040] =
 	{ .die		= "T1040",
 	  .svr		= 0x85200000,
 	  .mask		= 0xfff00000,
 	},
 	/* Die: T2080, SoC: T2080/T2081 */
+	[DIE_T2080] =
 	{ .die		= "T2080",
 	  .svr		= 0x85300000,
 	  .mask		= 0xfff00000,
 	},
 	/* Die: T1024, SoC: T1024/T1014/T1023/T1013 */
+	[DIE_T1024] =
 	{ .die		= "T1024",
 	  .svr		= 0x85400000,
 	  .mask		= 0xfff00000,
@@ -59,46 +80,55 @@ static const struct fsl_soc_die_attr fsl_soc_die[] = {
 	 */
 
 	/* Die: LS1043A, SoC: LS1043A/LS1023A */
+	[DIE_LS1043A] =
 	{ .die		= "LS1043A",
 	  .svr		= 0x87920000,
 	  .mask		= 0xffff0000,
 	},
 	/* Die: LS2080A, SoC: LS2080A/LS2040A/LS2085A */
+	[DIE_LS2080A] =
 	{ .die		= "LS2080A",
 	  .svr		= 0x87010000,
 	  .mask		= 0xff3f0000,
 	},
 	/* Die: LS1088A, SoC: LS1088A/LS1048A/LS1084A/LS1044A */
+	[DIE_LS1088A] =
 	{ .die		= "LS1088A",
 	  .svr		= 0x87030000,
 	  .mask		= 0xff3f0000,
 	},
 	/* Die: LS1012A, SoC: LS1012A */
+	[DIE_LS1012A] =
 	{ .die		= "LS1012A",
 	  .svr		= 0x87040000,
 	  .mask		= 0xffff0000,
 	},
 	/* Die: LS1046A, SoC: LS1046A/LS1026A */
+	[DIE_LS1046A] =
 	{ .die		= "LS1046A",
 	  .svr		= 0x87070000,
 	  .mask		= 0xffff0000,
 	},
 	/* Die: LS2088A, SoC: LS2088A/LS2048A/LS2084A/LS2044A */
+	[DIE_LS2088A] =
 	{ .die		= "LS2088A",
 	  .svr		= 0x87090000,
 	  .mask		= 0xff3f0000,
 	},
 	/* Die: LS1021A, SoC: LS1021A/LS1020A/LS1022A */
+	[DIE_LS1021A] =
 	{ .die		= "LS1021A",
 	  .svr		= 0x87000000,
 	  .mask		= 0xfff70000,
 	},
 	/* Die: LX2160A, SoC: LX2160A/LX2120A/LX2080A */
+	[DIE_LX2160A] =
 	{ .die          = "LX2160A",
 	  .svr          = 0x87360000,
 	  .mask         = 0xff3f0000,
 	},
 	/* Die: LS1028A, SoC: LS1028A */
+	[DIE_LS1028A] =
 	{ .die          = "LS1028A",
 	  .svr          = 0x870b0000,
 	  .mask         = 0xff3f0000,
@@ -109,6 +139,7 @@ static const struct fsl_soc_die_attr fsl_soc_die[] = {
 static struct fsl_soc_guts {
 	struct ccsr_guts __iomem *dcfg_ccsr;
 	bool little_endian;
+	u32 svr;
 } soc;
 
 static unsigned int fsl_guts_read(const void __iomem *reg)
@@ -119,11 +150,16 @@ static unsigned int fsl_guts_read(const void __iomem *reg)
 	return ioread32be(reg);
 }
 
+static bool fsl_soc_die_match_one(u32 svr, const struct fsl_soc_die_attr *match)
+{
+	return match->svr == (svr & match->mask);
+}
+
 static const struct fsl_soc_die_attr *fsl_soc_die_match(
 	u32 svr, const struct fsl_soc_die_attr *matches)
 {
 	while (matches->svr) {
-		if (matches->svr == (svr & matches->mask))
+		if (fsl_soc_die_match_one(svr, matches))
 			return matches;
 		matches++;
 	}
@@ -202,7 +238,6 @@ static int __init fsl_guts_init(void)
 	const struct of_device_id *match;
 	struct device_node *np;
 	u64 soc_uid = 0;
-	u32 svr;
 	int ret;
 
 	np = of_find_matching_node_and_match(NULL, fsl_guts_of_match, &match);
@@ -217,7 +252,7 @@ static int __init fsl_guts_init(void)
 	}
 
 	soc.little_endian = of_property_read_bool(np, "little-endian");
-	svr = fsl_guts_read(&soc.dcfg_ccsr->svr);
+	soc.svr = fsl_guts_read(&soc.dcfg_ccsr->svr);
 	of_node_put(np);
 
 	/* Register soc device */
@@ -231,7 +266,7 @@ static int __init fsl_guts_init(void)
 	if (ret)
 		of_machine_read_compatible(&soc_dev_attr->machine, 0);
 
-	soc_die = fsl_soc_die_match(svr, fsl_soc_die);
+	soc_die = fsl_soc_die_match(soc.svr, fsl_soc_die);
 	if (soc_die) {
 		soc_dev_attr->family = kasprintf(GFP_KERNEL, "QorIQ %s",
 						 soc_die->die);
@@ -243,14 +278,14 @@ static int __init fsl_guts_init(void)
 		goto err_free_soc_dev_attr;
 	}
 
-	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "svr:0x%08x", svr);
+	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "svr:0x%08x", soc.svr);
 	if (!soc_dev_attr->soc_id) {
 		ret = -ENOMEM;
 		goto err_free_family;
 	}
 
 	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%d.%d",
-					   (svr >>  4) & 0xf, svr & 0xf);
+					   (soc.svr >>  4) & 0xf, soc.svr & 0xf);
 	if (!soc_dev_attr->revision) {
 		ret = -ENOMEM;
 		goto err_free_soc_id;
-- 
2.34.1



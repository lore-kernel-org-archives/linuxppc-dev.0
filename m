Return-Path: <linuxppc-dev+bounces-22075-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8CBCD6E79
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 01:46:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWkm04Ftlz3bsZ;
	Fri, 05 Jun 2026 11:45:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780623936;
	cv=pass; b=CMW3Hoe/1YiEg2WWxJQOk41iEdr/xh3FtLKwAiG0iJM4R5LI92F5r6u7RIqE3aX2OW0V5HC+LZE4iCGgj6rLhlXJ/qtY/fYlJsn8fUWUb4G+GVO8S1xNn8LqCmvOY2Z1oU+sZqRWEOalaVjF0xJVCIC71ZGY1Jb4iuMgw5a7755MBM8WGNMQG704zYybfDE357tQD8C8AKb904Cy65mWbmReEZIlWPiM+elnVQaDE+7NEEV6vakrzPC4L5Dny6vrqCJkNYnU3OLdzCvGMfzKIcy5vcMF8VVBp2wOPOgw/RYPn8LZrQd//ihqk/mzJQsWtk/6Zq+2T7R8JX8UiVJSzw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780623936; c=relaxed/relaxed;
	bh=izhzbpCs4dZ++AWfRc/YrENezh0oAOUxeEIHzzS8pBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CYbMJEbzKrRMCBVl5BHIOFtFnGCJDpLu4CyUakVCNLtKn2c57ldf4H77C4PILD0qjvz0SB9FdzhhYrXkzvgFE3GHEnf7UNVUZvo4EvAf4Uc1ucI5syP1aapCzBQGF3gD9H5sWvhZDrda8cvK4fwH1a1PxxasU4IV4o7YdNeX9gj2iXWZNwHy58aqfK+35erq8gZ2L9lNx9NWIfZ9pm/KItwGfvjAMbYddQLYjEtgt0F7RnOLvUR5JIfcDIlYh32c+yjIrK5ljBg1Do5QpvaXZko7+7m88uTlD7iYsDJXDWpqEuP/GdOHKgau0BXc8o0+NH76/Xrio1aP51oFypQFYA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ACI5Xqsc; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ACI5Xqsc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWklz47lxz3btY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 11:45:35 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNR+EUMicQGbtMFYSEDnaYaEJjx+M3Jrygz7HZDmLC7Y64MT6xawL+9TK2/L3d0MIndY8TPqQfdwWhA8AYxhoDobB0t8fP2Ro0/g7Z1QrU9aeolPAShMinhQisMRfbvO6ohO5DJl/vXqik0orZWMf+0BXFiVh8sLxJ6iJJBdSIz9unNihTKn/aQqsmUqUi7DSY3mAfsDZ79J9lRaHcH9a0KsPh5RV22EPgeuZSRjLMu+ZO7/b7DkJBZBGq9XijoOO44k7lSxBhO96mWF89r6vWBfFFgVVK4R4u4gHCro30b+z639asD795pRcpmwtZkIwBPcBY4MNWb8LGLHtsgtZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izhzbpCs4dZ++AWfRc/YrENezh0oAOUxeEIHzzS8pBA=;
 b=uxjmbNGNGnzIE+ynCtfb9pXQcX6LeZkuDoIrFxVIX6s+269sFADumcZbFx1hyvdWKpTwYPx9ErLhOSnqFDAKOxoRTU+IdAM8U0PTOnfX0FUw0j/o+eyJzK4wfVST7ePOud2GO7tbD0yFP47j6Qu4OK+Awoo97keO6nYT6lAM2Vcy1Qp/XRW/09wT89yZHaK7NnhRf3GknZ82ETN4w6ZgdX7zoLAiqcc+jMHJkocrjGYCZNKelBudDK+BuhDK/kdsIGF+EL1aLybgwiCBndXRvBvIu/htxPSo/Nfh+d0Ev7EVNoZADczMvyLdg35LXFsdMZyZLoQ9i53Yw+XISYyuQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izhzbpCs4dZ++AWfRc/YrENezh0oAOUxeEIHzzS8pBA=;
 b=ACI5XqschdgdjRfA0/y4rO1nUtnYJ8klzDtXv5kSy7ZelM6yDQGwDO1ytboYnEwW+NrKWlymszb18LPgX+DPVD8nc10uotBLXXMzogPUG0veDTdpSRL+461bTbdIiSzTcnncWt50NTr/cMoam4ekdLdoWJOLJmTcxNVCQfTO4Dpr4x4B1aUQBFm+BI1EBFSr73mHlnnsNnXVuj9NO20COkQn78vTDxtSWO4BiaKzddIdLWSl0jDaY7qpfl3pFMdPGHRYp5m+XW00R/Wth86W0iwe7XokVXZmn3MU9Tlob/khEKAgUc9Nv20shNAhxBda7S5kyHNHd3jCd0Px9DlKoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB9375.eurprd04.prod.outlook.com (2603:10a6:102:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 01:45:31 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 01:45:31 +0000
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
Subject: [PATCH v3 net-next 5/9] net: dsa: netc: initialize the group bitmap of ETT and ECT
Date: Fri,  5 Jun 2026 09:48:04 +0800
Message-Id: <20260605014808.686024-6-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605014808.686024-1-wei.fang@oss.nxp.com>
References: <20260605014808.686024-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 8b1b2937-5928-48d1-2686-08dec2a420c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|1800799024|376014|366016|921020|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	bnrxwlpxODsFwLEhtpQLxieOZBIz/jFmMLrozay1ETbhj7fHRGEUX2xopNYzurUQaRNINktC5kRjmPamzB/+GLhfGQ+4jZJrdacpaZkOX8TpZc+7EFYTjIIIIaDCTfp8GC11/+SLmh4b8eOULYmJ846nw5cgWZPZCPM4R6M+FDijqEx5JoMZbw4J11Lzefhq2yTOFXrYSfV1lJcrfUfHeAVTWK81ZOA9IKwQlddciDw1f51Wyy300XNqiR0Fp2MonQGfP2v2pQcSevinpThcmrTvySYf60hWwh7HlGlxak+YwqT+VbeV0P7YCbDW6MB2fXHuYej7OgPC0k5ajvS4M++lCVMbZXq9veGNo2B6+WhgY/e+fcI+boBdSW/absWPG8VzxfRV5zlqr++W6C2dZI0SUcKyV/9BXZypD5YpdRwC0pSOKfibbv/x7kt2Fr/8ZyFuFwudVqJ3Dtjp6tSwLHlLAsS8dImQ2HNdILb5qT6G+E/r28yaZDrA6O4GO3poeSzjdUUUaQbMZjvexOvv/iR9IamqGK5Q98K3tigBOVyy2azskESGHb9inu5CarjURdQ0IVDB2+pEXYkccu3MvMiTYDZwcXY5AmfnnHN6+Scg6sALnxqSrJGXZUxrM9djAMTcoHrNQR8I1YDkg/igIWwdS37TiNOTRP9t0Mt+pZCGdrm2oPXrEZ6A7xugjP0Ux3t6pOMxAZQtwoAC07uBMqRhyCavDSQ1ZiiAm5gFxKI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(1800799024)(376014)(366016)(921020)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KnEA10Co3QrOaCyAzjPZpnYKjyrSSPEn4Ra4o26JOpOwfy/P1LQXwLBPcrqs?=
 =?us-ascii?Q?UzsQvoUNoKE/dRQH422r24E6CL/yWcE/r2HHrSA08Pajus5n1inSFm2Q0tTQ?=
 =?us-ascii?Q?f01D63XjFZLWt07cAW+pZ1qp2hsUm73SK2ovDPWGXgJBCqpmhqd+1DCU1sR0?=
 =?us-ascii?Q?cSgfJemhoJZVnx5CJ1v0MAYncCvr2y4IxneoSYekjFQP/TP2hRab9fUjv201?=
 =?us-ascii?Q?iWL80Ux7se31ONEXNxkEvfwYUxx0hRzL4nIE9ie8ED44LE1hPLRJgckCQbui?=
 =?us-ascii?Q?KmrqCyUV9FYGkrzCy+x3Z7aDYRIok8CnG3rBhJ5EdnpqCZO+7upT986lpPxQ?=
 =?us-ascii?Q?E7dloq2tGLGL4h7PNbPPAYIm0+j5tNDWfz+RVCPFBypkvpolm0p+dW80iGQC?=
 =?us-ascii?Q?hqz7+v56g6Jbd3PfWJErs54LVXK8wwjc9PGfVoshC+bX2UQnmKZXFxzaNuWK?=
 =?us-ascii?Q?Z2JFwkx9C6sV/WXNR8Xmhk7OCFlsdG6jONCQWAGd9pRQecVkha1RPqMuk8JL?=
 =?us-ascii?Q?J0wq4TxR3ZYpRUUmdaQjHHTQVgDYLEomXWQcJ+o+IJqyxmKRjRB3MWk9OrIK?=
 =?us-ascii?Q?g3JfZvdtVKuJpjLWg3Uy/ha2j1I1EiMefrdC8v4k+vvktQXibTqWA7/WSr7e?=
 =?us-ascii?Q?PqVIG/iNZuYwctyq9WO/1tC5/CtGh4K6zKqKWsWJbjOwIWYMhzuh4ph0qdBf?=
 =?us-ascii?Q?l0Fyte9z48bNi6l6KcGTn9Z/31ayjX3AuclDBPzdeOxj8mrn/wa7rQHqGgWj?=
 =?us-ascii?Q?G4UR+awj7wl1U/rl4GlKCn9LkUtvZGnJatHovA+J1PSKDzAUiXXTB3jdOI0k?=
 =?us-ascii?Q?a+QsIU+dW4fkWx/tHDEn00D5gDdAreawsFKFu5Afc8+1q07TqO4gKMMrCahM?=
 =?us-ascii?Q?CrQiCUWYtRBSkgqvtL+C5CtP99ASZPfjyfDRuNhF693rauTj5EyxZ1PtjnBI?=
 =?us-ascii?Q?gELEQVYuNNaKh6ibt6BOYsQK8hVja/Rhbm5R0gjSImwsMOUhyCjGCC5goNqx?=
 =?us-ascii?Q?s/kfQ5YfNhWLTA5qGh66tnkG8y9ePZE7smYkhQHPyJv3r3a/mqQMHSk5Yghf?=
 =?us-ascii?Q?hqb9AZNZY+mZX7vLV2XEGv+VOFz0SIEHguS2U1kOZocQDjx6JAbj/UDx/5Qp?=
 =?us-ascii?Q?S6xEu0JGL0l37SxLtKEQgKvIqiNodPnxHuj6n1ggjbNmCM+ZJo45ajXFCx7Q?=
 =?us-ascii?Q?WMJTgOgQ4xsHEIeDg9xH+QoKBMNssMzd/OWr0ZjchnI8tLl31UcJYNHcbAdP?=
 =?us-ascii?Q?RBqzgaiIdxUaiNfYB11G9BsGwsEo7lj1IVFtmDzSb5dmhjn6ZW82ftynC9Ll?=
 =?us-ascii?Q?+ihvLEsscMsz8nywE4JdbUUvgVbYw72PB6u4pde36DKpUYJK1naZ9k5IwEv5?=
 =?us-ascii?Q?jPqgecedSKxhHFFwhF5qn6+K97YOV/2Xr+ucEk9x9PYUEaLq2bA1nGpeq7nw?=
 =?us-ascii?Q?0DaDIPxjOThn8P+u+SFdLmS8/Ib5PmKO16C6Wagai7m74rsr5f8ekXL5OV0M?=
 =?us-ascii?Q?5mclFuGA/ZUnwiK67NJQsfdiJo0epY6gqIdAUHI04yDCnML254s0fdiG9oQB?=
 =?us-ascii?Q?btunNeixq9mqZ+bKoehBL0GifU9fBnbt/0ZdTEgDgsd340HPXxId4ULfv7k8?=
 =?us-ascii?Q?U4BlOBqSl4pO5jZ0/qDQd7ibYCOaX366mrRNdElOdHPCZRXrSunLRpw2knQe?=
 =?us-ascii?Q?WOO00JLsxqxGqMtxHc3iOhJdkyww8OORzaC24PqlZiSQfCBiAJqcTnqecq1+?=
 =?us-ascii?Q?37W/1C7A5RQmkc/MtMuVqw8V50d/Ib5iEszr3SmImn8pWtVMLC7P?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1b2937-5928-48d1-2686-08dec2a420c8
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 01:45:31.6496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZsSeek7hTVn6u+sC1D0YScjgdZ2CxyQz+o+Jlk7nsYB1hzGDdtw6fc0Bez6AjrNqXdeQJv/NKjIXCVNe7ViQYuaB8m80ViB9c44cTtH9M5tIcO5B8L2JVO3d8EsPTDUl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9375

From: Wei Fang <wei.fang@nxp.com>

The Egress Treatment Table (ETT) and Egress Count Table (ECT) are both
index tables whose entry IDs are allocated by software. Every num_ports
entries form a group, where each entry in the group corresponds to one
port. To facilitate group allocation and management, initialize the group
index bitmaps for both tables based on hardware capabilities reported by
ETTCAPR and ECTCAPR registers.

The bitmap size per table is calculated as the total number of hardware
entries divided by the number of available ports, which gives the number
of groups available for software allocation. A set bit in the bitmap
represents a group index that has been allocated.

These bitmaps will be used by subsequent patches that add VLAN support.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c      | 90 ++++++++++++++++++++++++++-
 drivers/net/dsa/netc/netc_switch_hw.h |  6 ++
 include/linux/fsl/ntmp.h              |  7 +++
 3 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index fa7dd307ce13..d4475ad7ed6c 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -323,16 +323,104 @@ static void netc_remove_all_cbdrs(struct netc_switch *priv)
 		ntmp_free_cbdr(&ntmp->ring[i]);
 }
 
+static u32 netc_num_available_ports(struct netc_switch *priv)
+{
+	struct dsa_port *dp;
+	u32 num_ports = 0;
+
+	dsa_switch_for_each_available_port(dp, priv->ds)
+		num_ports++;
+
+	return num_ports;
+}
+
+static int netc_init_ntmp_bitmap_sizes(struct netc_switch *priv)
+{
+	u32 num_ports = netc_num_available_ports(priv);
+	struct netc_switch_regs *regs = &priv->regs;
+	struct ntmp_user *ntmp = &priv->ntmp;
+	u32 val;
+
+	if (!num_ports)
+		return -EINVAL;
+
+	val = netc_base_rd(regs, NETC_ETTCAPR);
+	ntmp->ett_bitmap_size = NETC_GET_NUM_ENTRIES(val) / num_ports;
+	if (!ntmp->ett_bitmap_size)
+		return -EINVAL;
+
+	val = netc_base_rd(regs, NETC_ECTCAPR);
+	ntmp->ect_bitmap_size = NETC_GET_NUM_ENTRIES(val) / num_ports;
+	if (!ntmp->ect_bitmap_size)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int netc_init_ntmp_bitmaps(struct netc_switch *priv)
+{
+	struct ntmp_user *ntmp = &priv->ntmp;
+
+	ntmp->ett_gid_bitmap = bitmap_zalloc(ntmp->ett_bitmap_size,
+					     GFP_KERNEL);
+	if (!ntmp->ett_gid_bitmap)
+		return -ENOMEM;
+
+	ntmp->ect_gid_bitmap = bitmap_zalloc(ntmp->ect_bitmap_size,
+					     GFP_KERNEL);
+	if (!ntmp->ect_gid_bitmap)
+		goto free_ett_gid_bitmap;
+
+	return 0;
+
+free_ett_gid_bitmap:
+	bitmap_free(ntmp->ett_gid_bitmap);
+	ntmp->ett_gid_bitmap = NULL;
+
+	return -ENOMEM;
+}
+
+static void netc_free_ntmp_bitmaps(struct netc_switch *priv)
+{
+	struct ntmp_user *ntmp = &priv->ntmp;
+
+	bitmap_free(ntmp->ect_gid_bitmap);
+	ntmp->ect_gid_bitmap = NULL;
+
+	bitmap_free(ntmp->ett_gid_bitmap);
+	ntmp->ett_gid_bitmap = NULL;
+}
+
 static int netc_init_ntmp_user(struct netc_switch *priv)
 {
+	int err;
+
 	netc_init_ntmp_tbl_versions(priv);
 
-	return netc_init_all_cbdrs(priv);
+	err = netc_init_ntmp_bitmap_sizes(priv);
+	if (err)
+		return err;
+
+	err = netc_init_ntmp_bitmaps(priv);
+	if (err)
+		return err;
+
+	err = netc_init_all_cbdrs(priv);
+	if (err)
+		goto free_ntmp_bitmaps;
+
+	return 0;
+
+free_ntmp_bitmaps:
+	netc_free_ntmp_bitmaps(priv);
+
+	return err;
 }
 
 static void netc_free_ntmp_user(struct netc_switch *priv)
 {
 	netc_remove_all_cbdrs(priv);
+	netc_free_ntmp_bitmaps(priv);
 }
 
 static void netc_switch_dos_default_config(struct netc_switch *priv)
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index 1d976882a6cc..1404ae41c7bc 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -36,6 +36,12 @@
 #define  DOSL3CR_SAMEADDR		BIT(0)
 #define  DOSL3CR_IPSAMCC		BIT(1)
 
+#define NETC_ETTCAPR			0x18c4
+#define NETC_ECTCAPR			0x18ec
+/* Index table NUM_ENTRIES mask */
+#define NETC_NUM_ENTRIES		GENMASK(15, 0)
+#define NETC_GET_NUM_ENTRIES(v)		FIELD_GET(NETC_NUM_ENTRIES, (v))
+
 /* Hash table memory capability register, the memory is shared by
  * the following tables:
  *
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 1222901f48a7..e8b1bd802f19 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -3,6 +3,7 @@
 #ifndef __NETC_NTMP_H
 #define __NETC_NTMP_H
 
+#include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/if_ether.h>
 
@@ -70,6 +71,12 @@ struct ntmp_user {
 	struct device *dev;
 	struct netc_cbdr *ring;
 	struct netc_tbl_vers tbl;
+
+	/* NTMP table bitmaps for resource management */
+	u32 ett_bitmap_size;
+	u32 ect_bitmap_size;
+	unsigned long *ett_gid_bitmap; /* only valid for switch */
+	unsigned long *ect_gid_bitmap; /* only valid for switch */
 };
 
 struct maft_entry_data {
-- 
2.34.1



Return-Path: <linuxppc-dev+bounces-24930-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1122DC531F9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 10:43:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8X9c6Vc6z2yrt;
	Tue, 28 Jul 2026 20:43:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785235380;
	cv=pass; b=dXqcoDFkACZPYJXoClncOfS1NF6ae8KFbPh8G4UnkibwdbCD+F3OVqpnD7Z1cJG99KRz7qeUrRHdB12K8rdRptx3LAJrPuNomtc55E7bgzbw3NHRMVxK6i7v7VcwwSVZD4/O+CCA6Wl8+BkeJ/g+D9dAL6fPhzEz55GFjzED/W4NG46y3ryn/6v5HmYIuduxy8L3ybSCXrQZxb7WBOX0igJ5SNsJo9zuJq9Rni1VfUs5npWsUEBERW40aJf/POQb26wCTm5dWgwiPHBdAUuj8Z2dK5/UbKI2Euxp9UaXUCSX5g2JB/Q6dUJh+ZVzwj3clKo7aFLZhnDq3Mr3vE5XNw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785235380; c=relaxed/relaxed;
	bh=msyugM1rdQGah/lV7BFbdl85Dot5pNHhQNoUia96vVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZFgR69eVVcNxNpqwun0nzDDM623eKMXVKk+X87Vfd8Ry+WVRZFkM+aTkuVpiutD6hZnTljG1BUkAZQTedRAxrPRN4nNUX0M4IU9jMGjAGSoTM83m8Wx5bkn+JuZxLdMY+qpoHVWgBUgSAtT/UiHV8Bfy3Zf9ptkIxfSUj6SzAvnFFkSDpcQpU51xU0sUJwS2bBIyZ6ROemiWpoW1fFxStwJS3dxNJDS+qpiV1W9HiD4TvIFTjZSBmLdmF+16h7AxnyaF6DcyrQCZS+bzkRb2HSRoc5ADVVAXCqsnKOpFC81I5WIxtlSyjDinXPmq+jh52uzkk11hcnClVbO+LQXVAQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=RwiB6ytX; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=RwiB6ytX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8X9c0tQcz2yr6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 20:43:00 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbkUKE3WbfpD+5Lz87C6XCmnViG/V+32Z5U2qr7cCkkGfl1Skrn5d5pb0X/xWWcBJqL4ycsZjS4VwOlX1mWzB0agA3UmSiMG08r+oab5p0iNUyoHf5g1QR4WIIQMDtUtgxAX1dzQiqetKu1/MLu0aOA6uQNGizfj8qaIguiBhkVgIGyfG8MCWGQokU2ragGt3JeVnK4+NOnnOQtkmkDuRW5atDl8ixTJXcTY7sv6NfwKaBl3EDofX/b9qYxAGwdtGpYrfe8eGInVxVOzPBe0qPt1zmAKFgNis6F5mgIJxfrRWCMSleiTrWb7l4RrqYXDvNhBMrTaWxsx0RDYxkqXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msyugM1rdQGah/lV7BFbdl85Dot5pNHhQNoUia96vVk=;
 b=gCFg7c/60M44J9mbDeYmysZ06lbXZLtafrfIT+HaBFGR/O33dSZmObNXslDgwQ9MfUmu694GBfpivC08FuO7YD9pCHBmP5QMbjpDeaRxwNToh7giB67PrCVB7ObrqQGs8FUCqRMILa/oQp66DX9GBWRGstU5uDmrMCwlDhqYqCLPeYVKhq3SxH0unPu5HKMG+iTr2IPuXDUXVt33HGBXKjgXNar/7YPx9TCvwRiiKS2JNDs9TfTcy2B8BhtLWr+LwhpHxgBOqZqjd6OLPH7S2ftMV+GARdlJlrg82ZxJ5fB57OR8/HiaILnD/z2IfBKYx+Sv9QcyHZua3/TT/6w7+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msyugM1rdQGah/lV7BFbdl85Dot5pNHhQNoUia96vVk=;
 b=RwiB6ytXjdM6xH4FTSTn5ApUbv71n6c+juKCS78M3CBiVERIigLpbi8hItIebI+rrKcZWxXsOe3Mpw+GFjPd+EqlOm75+tzidYZ0d5bgmisI7AwO5l68h1q7eMmn4nz/d3r+jJzw6JLp+e+bhqaOkjhE6TwiWaBAHaOSoQtSf6KV4H2rQ13HLuc2Tt8kJRuxAhEhp7PYU7hVmhP5u+THoxhEuiY/1BQLZPSBZU3rymTfaPxmW+cusOXSRSOT0TWGk+FM7S6CX5NIYu5b1bVPySLV57ZoXx+I76QNBv6ntX3wzCzYBy1Flpu60E3h8Ixhan3YMXXFYsy25Jhg0pw1sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by GV2PR04MB11835.eurprd04.prod.outlook.com (2603:10a6:150:2fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 10:42:34 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 10:42:33 +0000
From: wei.fang@oss.nxp.com
To: richardcochran@gmail.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: wei.fang@nxp.com,
	chleroy@kernel.org,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 5/7] net: dsa: netc: enable ingress port filtering lookup by default
Date: Tue, 28 Jul 2026 18:45:46 +0800
Message-Id: <20260728104548.3301214-6-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728104548.3301214-1-wei.fang@oss.nxp.com>
References: <20260728104548.3301214-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::18) To DBAPR04MB7207.eurprd04.prod.outlook.com
 (2603:10a6:10:1b2::17)
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
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|GV2PR04MB11835:EE_
X-MS-Office365-Filtering-Correlation-Id: d43d474f-afa0-477e-c536-08deec94ee32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|1800799024|7416014|376014|56012099006|10067099003|11063799006|6133799003|18002099003|22082099003|3023799007|921020;
X-Microsoft-Antispam-Message-Info:
	MCJZF8UbpuM+yTUnMiXjO2LswcZ9WYDrbZSO3+7MBInfQ3wZlWz2z9SxmqQJyXue/ZgyLgtFVwNYgrTGY3mKoq31qaN2zkFf0AXI39URvNg7rmIVhch9IYtXNfaAcCtS1PrVK9jr1fRccfY340Ti8hd4AI11nye32OxQdYa05agYFV/wUB0rDnY4xw2q7KkCUGJglN6A/dbBT80T6Lin7qDBRQD/n6zptd8V4IuHgndZ6OyKWRLzTz+qBqIUE3iAxT0IMJe0BH1pkoFnnPzF4UULOWl/jIufVMBB/BePICYL5Gq4yZrnVRH7lHjwz2B0XmyUeZTBCjEGZrcSiCBSNHVXDWtEnZQNIG0Ir6jaj4hXCIyPlUfqo3hhr+oqnJN4rZFA5WCKt//xU2QZk0oKA+llx6tFVRhWSKRQ+A8glCOobKLyZRnY7EFe9IWmeSiAVotweJVuuFQVnBT9ylmo1KWuIqnF75OkwW2Hb8DiPCT/xyhUGD4k6cD71ECDfs/KmBQzVDURDpUml2TcRtpPG2ZOQ2RuBXWeAi9SkQd8k0dgKTTkM183qmB4oowuMUb4DdgL1AemfJGwm//DGAxbaf95kI473vY9ImFFaz6peypxQLbL0JJXVhSHGk/DLvrLbV+y+bhBtD4mKz1Abnn1p1l3m5yqzMLPHXqZxHd3twnft2Oaf4uAwXHkPMSIGJu1ffBaXv92ryVzxt+IjxXR4Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(3023799007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vZCFkLRvTCYjMZ8pHPYPWyON3RxHrf/QlM9X3SqrwXT3OxaRvFuaCLdRnLRR?=
 =?us-ascii?Q?2BHRNozU74ETkN+7KK7EuPj/YIrX2wjHWZdHZYl+YJFQUdpkkTZcVDVFwnjM?=
 =?us-ascii?Q?WNDlQFRmvL4EVVAR90hylJ01HVBisBju8YSqNAr1JaXeZo6rUFAkx0QDWFf3?=
 =?us-ascii?Q?RMNgZdZ9VtroP/5YKifE0eYxurbx7/Nhpt0sJ9VC8akJ7LEP3D0+GcYVuDdo?=
 =?us-ascii?Q?XfR2UoA7HLbLTabyRTH3mdIOQcMK94rMy9aVubGuHft+GDhV65CLMzGOCoCs?=
 =?us-ascii?Q?pt+Pi+inR/gfpv9fS2snJ0DGV5fj++3MEecbkhCJUIostRNI7ZbyfjWqOeM3?=
 =?us-ascii?Q?qPoLGQP48qz8JD9CFBTNjWrVsl8M3Uf6nFoy51E1shdVrEo3cq3IQMY/m5cS?=
 =?us-ascii?Q?is2dGQ8l8V1p0sskeyYo78hlQTXoBquBFu01mIRdV+bXwRyz/PmKKkjj1n3N?=
 =?us-ascii?Q?yAzSDi/utS/OQsk8YzWGRYQSEINdLNvClX1D9IC19PMgSesS+fCI+4X7RmMC?=
 =?us-ascii?Q?8FXs53jb08qMuUiP64oSKxqLo75Rw9x0b+cNvQgnNbaZMzRoJXT0CpN3PjSW?=
 =?us-ascii?Q?Y6DQiDCXEtTZGGOBevMdnJH0DccyTyBYH56RrAZy37Q64xWoSJ4Hqm6wFNjO?=
 =?us-ascii?Q?I462LqUTtucy3MEdt1tGvxn9kxQ2rnirf5SsPKV3Uii5gWfuD8eVi8lQrW99?=
 =?us-ascii?Q?lGJqor8lQeRHmXQ57fjsgYZ5wYtDoQt4QJ97yR05sbLt8Vg9HNlK4lxzNvEU?=
 =?us-ascii?Q?lET/lTzNA0Ejdahuvt3NdjBOGZAHnAvj67eeiyKDmLqlq1636uPPbwTzCfJ1?=
 =?us-ascii?Q?Yf/mMoJm1sw21H3GUKoxgfNdFyTPpSdz6jjXwvfEiBbfNl16DEGiPAH3amjO?=
 =?us-ascii?Q?5nX+W3zDkcNdyFpxklqJJ0DTxCDyhaPHbEalSvgA90WgyWU4lkOVHfhwof48?=
 =?us-ascii?Q?8h2CfPh9GdXYa+RRcVwHTDVhZR2Iin09cVMTmMeTqH1BWcyaEzeKiNBcvpdc?=
 =?us-ascii?Q?OIEKrR6+WmM3L6XbQGqfQVEc7aC9dHxY+H5Tq+nssOFP/yG3kJxTBOw5Ee8E?=
 =?us-ascii?Q?F0ycxSzLf6q+W72uOqddrDaVSiiWZRIapitktZywW81/zInpouLjKjA9EIKn?=
 =?us-ascii?Q?Q7qoXKlclN3k0USNzX/3fOMryMuh0Nzlo2JIPyyBM59AyNRyeoqTZsghfPpG?=
 =?us-ascii?Q?BawWu8dK/WgnLJ6NHju5byjDIYX9evwBrSIL6Y6BsK3QPxW4OjNiYQFAtrBL?=
 =?us-ascii?Q?/51Gl+GxgUd4ecwXCkQ9PAjDwiDLW24uOzYaqQY7oGo20OsodLRF1NIGxTUY?=
 =?us-ascii?Q?cvYz6z68oFDvDMbEFBCu32bUwS11444gCfJcWgG29Ji+zPIGNaHxoU3YvMOH?=
 =?us-ascii?Q?9pW5L9BsSmWMy+b9sO563zE/Ih3fVWve55m8TIlY4qsAdAHdBzQW3bR9Cr4o?=
 =?us-ascii?Q?0AYw7tVEDUhwuedyG40BITpclrtW8QOANw+57+eLYaucvIb9XhbJ1Ms9LnKa?=
 =?us-ascii?Q?ML2l9caJSzpU/WeQlKV3/ahXbzeJX0t2n+7sADk+8wJp3M+d4aSMnzoYwVGJ?=
 =?us-ascii?Q?usOx61MitjcrCHZRJp7IhhQLCFY4PehhrzCsyAb2RPsGYooAVumJp4q/jGq7?=
 =?us-ascii?Q?fLXTbOWXeGpO9DE5OTW+vzprPoCE7L4xtQ17CE6wG7JAWvvxLtzDQhPzty3r?=
 =?us-ascii?Q?8Cb9BNz7V4nyw8nOWC3e2271hBfzqIwXYcvLLSN1Zzi2wgC9CDXB/oAkiqzL?=
 =?us-ascii?Q?syhdWX6lTtDFzv8Ty+fRliWT6IjjE7mqkNNjp71kogMMnGu1C8XE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43d474f-afa0-477e-c536-08deec94ee32
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 10:42:32.9969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqSA2JnBlULA39g+fF4iuxYRpPDkh3hAweSqps2AkryjTQVEvLZOGKzIgt1RomWXztdaaj6ndN3XHz6+6CLg5YmOIGqdkGmkcwcFDp0Xmenvyp79/ZbXTGLpgEUiABJC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11835

From: Wei Fang <wei.fang@nxp.com>

The ingress port filtering lookup function involves performing a lookup
against the ingress port filter table (IPFT). If the frame matches an
entry, subsequent frame processing functions will perform corresponding
operations based on the parameters specified in that entry. If no entry
matches the frame, the frame is allowed in, and passed to the next frame
processing function. Therefore, the ingress port filtering lookup is
enabled by default to simplify code logic, eliminating the need to track
whether the current IPFT has already added an entry for the port.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index d326a00104e1..9cb9e618661e 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -555,6 +555,12 @@ static void netc_port_fixed_config(struct netc_port *np)
 	netc_port_rmw(np, NETC_PCR, PCR_L2DOSE | PCR_L3DOSE,
 		      PCR_L2DOSE | PCR_L3DOSE);
 
+	/* Enable ingress port filter table lookup, if no match is found,
+	 * the frame is allowed and passed to the next frame processing
+	 * function.
+	 */
+	netc_port_wr(np, NETC_PIPFCR, PIPFCR_EN);
+
 	/* Set the quanta value of TX PAUSE frame */
 	netc_mac_port_wr(np, NETC_PM_PAUSE_QUANTA(0), NETC_PAUSE_QUANTA);
 
@@ -1708,8 +1714,6 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
 	int err;
 
 	if (!uc && !mc) {
-		/* Disable ingress port filter table lookup */
-		netc_port_wr(np, NETC_PIPFCR, 0);
 		np->uc = false;
 		np->mc = false;
 
@@ -1753,8 +1757,6 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
 	np->uc = uc;
 	np->mc = mc;
 	np->ipft_hf_eid = host_flood->entry_id;
-	/* Enable ingress port filter table lookup */
-	netc_port_wr(np, NETC_PIPFCR, PIPFCR_EN);
 
 free_host_flood:
 	kfree(host_flood);
@@ -1779,7 +1781,6 @@ static void netc_port_remove_host_flood(struct netc_port *np, u32 entry_id)
 		np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
 		np->uc = false;
 		np->mc = false;
-		netc_port_wr(np, NETC_PIPFCR, 0);
 	}
 }
 
-- 
2.34.1



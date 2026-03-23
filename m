Return-Path: <linuxppc-dev+bounces-18574-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAADD58CDD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 06:07:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffN400YPjz2yYq;
	Mon, 23 Mar 2026 17:07:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774246032;
	cv=pass; b=PMi61xRESYRh4zVZjfXQg/7O/zckpwZWdHs0fuVF9j+Pf4VvZDuQFzwuouL9rPn+mE4bTnOof7U5mVcQ65lXOKPJWJjDgrVw+j1Qdfs/1tsK02aF6rfcgH9Zv+G46m78PYxT5K9BGhKLXUxRjuQhw3y/hGDYI/KeqmDrpiedI2bH1TFlO82CwOUbpQylZ5Zka7lf4RPJ3C6RqFvahsVufrt4aIPGARi9HmTsEOi02Ztlclw2hUe0xNuqx0KycLFAd6fh8s8BMFfvoP+/359ZsUzRZNAEL4qpah8qVFjB761BleiiGZ0WKpluXEcXwH01GCwhI9Gho2z07q6UN3W3Og==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774246032; c=relaxed/relaxed;
	bh=TVX/wrHm3G4dGqNAC5ffQGFcekO9fLvQl9oiAcEDw5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TBUPbsq/wAlsSY6rSkqlAaLfjXDUB0j46c6AmO+buu5EaDVwpjssFkYBUS4MbCZc3Cht27XUqTO4v2LydtwTnxS19oqo+YRUJIt8y0sWqgliJ8H/2Qfccgj5rQfGd6Kg84P7tT1psh3WRnC7PD276pSQPDo+xR/wHbBvAbR82+yXG2s9UOMqqdpKzP05iyk77wpZ3Fyu8kJrM/pryxZABwEAIWVkzEtUubUx2YFUezYBQ85I8uPz7vLjLw546satX2+X5aHnxHEwUy0wQkqEESVpExO04t6XiknxFJe41/2OAMeqDrZUoAP7yCJ0q/Y45RhoOYkji69UsZkQv6gDDQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=dlotShcy; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=dlotShcy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffN3y66WLz2ySc
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 17:07:10 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JO0WNdaxUFKiPcVhyUxY/wCbNOQTLsVMJShIrBInyhaonSN69kRdX3UrZ78Sm62gaWk0R1BQaEP6mJt1NEz3PzNCG+MVDdL+HXRLOt/jEoBgtCq14uWMm5eXUdUzVyEQRKEBQX2r2HSVrn/MoPo581aKyD6ztkrezkXUaHGtONUWbLF67CvVUbP0Kc16YLxC0mzxWyHBaEkCmz5q+JKWetEq3WuR3IL+mvUnd5GdaueRpDk42xyvNe0AiWPUcX0lD2RVhqb2jCDqv0wP/QI/lTJ7jF7z7+YOE1wz9SgWL+BD/8IgQ1B0EmoRJjAOVs1XRjg4rWuLQpGpE1IafEgSoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVX/wrHm3G4dGqNAC5ffQGFcekO9fLvQl9oiAcEDw5Q=;
 b=wT05kRVf6ru+PG90QAuJcemmKuY5v8gWsEyZnX1wtPnyZhy7Woellbb+aFZgRloMKcYX/PdbbYUQYx9YKaE6Tv5svURVD/LfbEfKG7Z/zNDNPnDGfOHEyADvy0lQDpEfZAnbsGPPhKVR5qCYa6EJy6uQWMri8sF+DMobAWiIEsUrHD4UhJRlaxQFK6duU+5PMMyLXtVjN/A3ITtVwChgDH+aIFA3ANMOuj998bbAGfzcMvh2e73MnZqv45K59vnqTYQg8sreYBDExWPEFbIbNXkjyYGHUN9N0t3dydDXiijFEXevjU3x6/dD9IbhiBaZ7SNA8EXbsjVtoExlHWINHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVX/wrHm3G4dGqNAC5ffQGFcekO9fLvQl9oiAcEDw5Q=;
 b=dlotShcy8Bxbaxurz2Y5aNp5Gv7qgZYLOM87VekP2I0zAyZETNYC1dlnEM5EwR85dsh6OaFU/O4pvxp+n8CFgM5gBJKL4JQTYOOrXVfV84VHWGSR1v8k5j7l4wDRXc5cGW1+nl6x34burT2L57xN8TSmbre9XeJNLYKQBnkpMk7nCfGjztJkYsF9SVaIE69QaY3qoMn5a8LHErJBdrZ/BHliDWqCZKefjgOdtNB069M8BaBBfs82u0BaIYTQwEvabYWG6SkLA+195AJJ0ggPi6dX6ofmRG7S6PjvIYY2LFEjqg9ghQdsY3W0Kdh+a2VgxDd/GAT5IoG0FD37KM5Ewg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by PAXPR04MB8911.eurprd04.prod.outlook.com (2603:10a6:102:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 06:06:18 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 06:06:41 +0000
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
Subject: [PATCH v2 net-next 05/14] net: enetc: add support for the "Add" operation to VLAN filter table
Date: Mon, 23 Mar 2026 14:07:43 +0800
Message-Id: <20260323060752.1157031-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323060752.1157031-1-wei.fang@nxp.com>
References: <20260323060752.1157031-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::17) To AM9PR04MB8505.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::14)
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8505:EE_|PAXPR04MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: b207e17d-ebfa-41b5-a811-08de88a25a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|921020|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NBdHDM5r4vxMpqnZ0V3EGDhwjDkWmuM5mCaI4ar+X5NLsAkAdA4Z2ZoLvAHAFtUtsMfnF3WYuk9R+ZOb3lIDYLNPMx/lCQ3xpfPMIrnXYP32zvXkvbYgcSmOeCLyliLnqB/7Ifx4c9zpDKhgksBv5F7J/ThvnAne1fJwnCD+Iog1cBrvYfI7XMV/9ZY2P6Bp0mb5Ac2xe1FrXzCRLUe5nuqXOPNMiIXEYZivSWNirwtT7h3XncmWAL+7lDM/ffe6HmQYcYeUQrCmVjMUNMkhBxzMhUmgP2P7WrkUZLPPjjmvTC03qoVlJiShBnt6kq2AMaq6HRDmzPNjbq7/LoqRqCODk6xZUt+DB2a16p86czfwM9WxS8Z6tWNJEzQS+xUb4qPSotgfMFVmRrHuo8K9bZbjj0wAlVoNOzN2WMLJrwH74cL1RxM9a1/2ZWhyAMwO+DxXjsKD7D8eNGyQdTt7xmA3xyuHi6V/n1HqHBiD1ctkFSRDOYuXvytcG6MLgE12IL3rGvqqOu76mQJ4hUpugRdOgAIxwObpECEStpZL17B4Iic+iDSKvoccb38+l49pn4yBAsoXOLnR6xJBBvzidVV9MtDdR5gdcQra38z3/34wt50OhgkcW/1H+mX+ioVX6pri/+jOiL3qEwvnmWqqHyayN1b6Q3JEwL5+9O/6u4A5KMmVRmjxEW2b9Iat/ACacLzAwWJkScjSuYpJdB4Qq2pPVIyBT9wCLIgy1uOpA/Uaiy2Y041Cr116dunOPfK8oylApK3ZlhPslPH45ud+YCy+T3Mb/JX3dmqnR28cAMezw407erJ9bbX1qwwtimyl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(921020)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sW7X+U5VUpG4nYykDCPxFoiXurKvI5bEM3ZddZcbbcuz0nhXFzrlrIjS4ioN?=
 =?us-ascii?Q?nB/djTHawf+IH+4QjVKY/P+VjQTHoa5YCBmBjF3lIAsDcH7tjKDK9y0y7Q9a?=
 =?us-ascii?Q?0in8AhJ7n8Hlo83y5Xn5aDEh3mA4+H5nF5Y6GJi+fuebB9rjNS4eGZ0f5v9g?=
 =?us-ascii?Q?v78VS6K3wgukUOsA9LOPiCYPjLEevH31jVNiliV36iH6dFvi2s0oj/dHzuT/?=
 =?us-ascii?Q?38m3boLl268nGgZWUShs49SliFeZTZRDGvQQ3GG6LrVp6c/V84SgpunrA6UL?=
 =?us-ascii?Q?KHw8JzJf5BKEAmWDz85op9dV3ouCfp8HZD7RPw/VBXRQ+GA51FojH8r32qlZ?=
 =?us-ascii?Q?r97WV84HLf2IbsfyG8Sn5X4Z8g/mxpQoybxqF6rLAWRYdLjaGnyb6eTWpa9J?=
 =?us-ascii?Q?jX2S5zGuFq4ZotCHE/MWhLEowyYy1m9qRa6FSv9ddll0BWPrNgf5M4kRafo4?=
 =?us-ascii?Q?gXYSxlnEJg9hCha8CesDHEFHmX5GntR5wOdnw2dD1UTJHcKI8R20S90wzPiZ?=
 =?us-ascii?Q?cCE3H2Bvs30GZ7f26rbR9kqWjHcCKTpy/gQZ1gzSYXgHaamxbaIuJ6zzK3Bp?=
 =?us-ascii?Q?ts3H4fLgYGs6h5d8XdnxavtJLhzJxpXk+OCb3OTttFSk7GZw/OBqwup/9nv/?=
 =?us-ascii?Q?R0T/VPoHBhOZ+X/CdBBXenTOgYZnMILuizTf7sc+bdu7yMcwSsiCNqokwyCv?=
 =?us-ascii?Q?DLYEugIjr2jlartt/zmuERKej74hiPSDAIJ/nK73Ozgk65YHUy/xEf9oFHhq?=
 =?us-ascii?Q?RNWGwJiCDV/w9ZAMCVeNz/NO/UAUFoQXBbWvSTAxuWRNCnyDwxq7Gn13I5ha?=
 =?us-ascii?Q?gDnLrW6RNApK7j6WalreUxlw5KDf4b0zKNMGQsAcqPy+bvZet0/Qomap3A8z?=
 =?us-ascii?Q?TJLSmVNCZICgJITWjQOR5lGQg80ITu2bH2dg4KuDS9et3tB+YeQOQpHWIbIu?=
 =?us-ascii?Q?siKRu3LPSUjSN2H7aIU17ZPkWUmPtkX5NWJccgw0IsXgSzkWnX7H/W1/BWEL?=
 =?us-ascii?Q?ugPLzQroPPEeuqyTPePmcgDA/zD4Ez0KamY3sONa6njdciR7Go2cKJQsNmr0?=
 =?us-ascii?Q?KMKPDxChmj37GgrE40g0vZV9xdOcEgAIcIq9MCB/RCh77ltTogYxxlBTXksS?=
 =?us-ascii?Q?/J5dEWwwGDUR7TdP3/yRB03PMIVt9XuE9R41is9+/yJU2wFBW8KEdOj9TNdt?=
 =?us-ascii?Q?+s9qmzmlgFwjDB/csvTNd0jqx3NautLl+lVUokDTB6QRtk85ojhipv1X9Z+P?=
 =?us-ascii?Q?0CB82UnaMa9lYNEvdIjVY1NMtIZJll/T3vtq0orAFS+/YOD/yLl1ZGsv+rO8?=
 =?us-ascii?Q?JrFnJ31eqnDQ6S5AUtetdEGRVNR1mAaCzDkn6IB0EV4N5tGQLhTwHrW8UQ2v?=
 =?us-ascii?Q?eQa5z2QckGUlSs/PS6ijf6ZOFjm5FfD6AqDKBslihvQ2OHn6oV9xg58gCEnp?=
 =?us-ascii?Q?FqjH+vqKlZqLy76m5zgMTxXzR7mxfbbAf9ns2Ks0S5uNmVepsvavicvI0lQp?=
 =?us-ascii?Q?8wsFV6zNojlX7cZjvMTk+ycnS9NpNJKiAfV17sfhVvuFShiqjNmMPT4hTZU0?=
 =?us-ascii?Q?Ey0F6Y0tIN9qz2Xeo+Mz1mdtXJB7R/6OrdzpTJue/zSzKO0+6TPtqgNDMGxg?=
 =?us-ascii?Q?VAacFX7v4wR6WUjNvt0IY0cPmkf+Cx9z+ExK6/rwPGsmTbosjCW/do8+vgnW?=
 =?us-ascii?Q?/1CV6woOo8+tkhrtUKQ/x4HL8dNlljbPam9sE2UrjH6USGw2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b207e17d-ebfa-41b5-a811-08de88a25a82
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 06:06:41.9204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWTRO+7GIMk1lkGT6NR01OwJrAMSIc5npd8F1Sun8qewX8SUwGB6K8XgPGxr1WCYeDp9jyqMBkQXZ1MwGF8Kyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8911

The VLAN filter table contains configuration and control information for
each VLAN configured on the switch. Each VLAN entry includes the VLAN
port membership, which FID to use in the FDB lookup, which spanning tree
group to use, the egress frame modification actions to apply to a frame
exiting form this VLAN, and various configuration and control parameters
for this VLAN.

The VLAN filter table can only be managed by the command BD ring using
table management protocol version 2.0. The table supports Add, Delete,
Update and Query operations. And the table supports 3 access methods:
Entry ID, Exact Match Key Element and Search. But currently we only add
the ntmp_vft_add_entry() helper to support the upcoming switch driver to
add an entry to the VLAN filter table. Other interfaces will be added in
the future.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 50 +++++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   | 19 +++++++
 include/linux/fsl/ntmp.h                      | 30 +++++++++++
 3 files changed, 99 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index f6f4316169b6..e8c94157ceb1 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -21,6 +21,7 @@
 #define NTMP_MAFT_ID			1
 #define NTMP_RSST_ID			3
 #define NTMP_FDBT_ID			15
+#define NTMP_VFT_ID			18
 
 /* Generic Update Actions for most tables */
 #define NTMP_GEN_UA_CFGEU		BIT(0)
@@ -231,6 +232,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "RSS Table";
 	case NTMP_FDBT_ID:
 		return "FDB Table";
+	case NTMP_VFT_ID:
+		return "VLAN Filter Table";
 	default:
 		return "Unknown Table";
 	}
@@ -652,5 +655,52 @@ int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 }
 EXPORT_SYMBOL_GPL(ntmp_fdbt_search_port_entry);
 
+/**
+ * ntmp_vft_add_entry - add an entry into the VLAN filter table
+ * @user: target ntmp_user struct
+ * @vid: VLAN ID
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
+		       const struct vft_cfge_data *cfge)
+{
+	struct ntmp_dma_buf data = {
+		.dev = user->dev,
+		.size = sizeof(struct vft_req_ua),
+	};
+	struct vft_req_ua *req;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.vft_ver, 0,
+		      NTMP_GEN_UA_CFGEU);
+	req->ak.exact.vid = cpu_to_le16(vid);
+	req->cfge = *cfge;
+
+	/* Request header */
+	len = NTMP_LEN(data.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, data.dma, len, NTMP_VFT_ID,
+			      NTMP_CMD_ADD, NTMP_AM_EXACT_KEY);
+
+	err = netc_xmit_ntmp_cmd(user, &cbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to add %s entry, vid: %u, err: %pe\n",
+			ntmp_table_name(NTMP_VFT_ID), vid, ERR_PTR(err));
+
+	ntmp_free_data_mem(&data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_vft_add_entry);
+
 MODULE_DESCRIPTION("NXP NETC Library");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 9e2a18cf3507..8f94572eaf0d 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -160,4 +160,23 @@ struct fdbt_resp_query {
 	u8 resv[3];
 };
 
+/* Access Key Format of VLAN Filter Table */
+struct vft_ak_exact {
+	__le16 vid; /* bit0~11: VLAN ID, other bits are reserved */
+	__le16 resv;
+};
+
+union vft_access_key {
+	__le32 entry_id; /* entry_id match */
+	struct vft_ak_exact exact;
+	__le32 resume_entry_id; /* search */
+};
+
+/* VLAN Filter Table Request Data Buffer Format of Update and Add actions */
+struct vft_req_ua {
+	struct ntmp_cmn_req_data crd;
+	union vft_access_key ak;
+	struct vft_cfge_data cfge;
+};
+
 #endif
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index ba56d4ae0ff4..6fb2c8c525de 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -32,6 +32,7 @@ struct netc_tbl_vers {
 	u8 maft_ver;
 	u8 rsst_ver;
 	u8 fdbt_ver;
+	u8 vft_ver;
 };
 
 struct netc_cbdr {
@@ -94,6 +95,27 @@ struct fdbt_entry_data {
 #define FDBT_ACT_FLAG		BIT(7)
 };
 
+struct vft_cfge_data {
+	__le32 bitmap_stg;
+#define VFT_PORT_MEMBERSHIP	GENMASK(23, 0)
+#define VFT_STG_ID_MASK		GENMASK(27, 24)
+#define VFT_STG_ID(g)		FIELD_PREP(VFT_STG_ID_MASK, (g))
+	__le16 fid;
+#define VFT_FID			GENMASK(11, 0)
+	__le16 cfg;
+#define VFT_MLO			GENMASK(2, 0)
+#define VFT_MFO			GENMASK(4, 3)
+#define VFT_IPMFE		BIT(6)
+#define VFT_IPMFLE		BIT(7)
+#define VFT_PGA			BIT(8)
+#define VFT_SFDA		BIT(10)
+#define VFT_OSFDA		BIT(11)
+#define VFT_FDBAFSS		BIT(12)
+	__le32 eta_port_bitmap;
+#define VFT_ETA_PORT_BITMAP	GENMASK(23, 0)
+	__le32 et_eid;
+};
+
 #if IS_ENABLED(CONFIG_NXP_NETC_LIB)
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs);
@@ -118,6 +140,8 @@ int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 				u32 *resume_entry_id,
 				struct fdbt_entry_data *entry);
+int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
+		       const struct vft_cfge_data *cfge);
 #else
 static inline int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 				 const struct netc_cbdr_regs *regs)
@@ -183,6 +207,12 @@ static inline int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 	return 0;
 }
 
+static inline int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
+				     const struct vft_cfge_data *cfge)
+{
+	return 0;
+}
+
 #endif
 
 #endif
-- 
2.34.1



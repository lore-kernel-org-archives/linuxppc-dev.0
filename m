Return-Path: <linuxppc-dev+bounces-22071-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A9ACD6E6E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 01:45:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWklt3ngLz2xLk;
	Fri, 05 Jun 2026 11:45:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780623930;
	cv=pass; b=SATTc8a6RmuozTq5qfSXq7xHM+iALd//nZHwb4E5SZSWQNXVWTsRo/sq7/NVXwTsBp5xeoo0gl3cVzazqn+TEX44J35EzCCEJYCbMGgDJzZqdeYW5bgF3wObJonmKCqVR5X/X4Xf3pLYmps+tS0M0mzq8WQ6ibzzHFhzJEz63FwjmqHdtrfvbsnyvjUuG44CXhyeQ956PpBGDhHxBBRWvrUa/3GrVkjUY7uceasCSPezBE7yUd3H6tLY2v3FoaZCuCYn7TEZCmwHCxKLUcyoNopN38xBntoa5u3M6JABYhVvqTVKUaie+e9WzU8zpc+e+BzCcW6Zg3bMTPilNdh2/g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780623930; c=relaxed/relaxed;
	bh=lAUhzvi8NbszROiGJ3s8aDYnWtzWcAo7Drdl7nvwpbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fg2oNCoypSmICpYpiKUwMZJMXAdGtUs6/yEvZPnMwBOyQRQLg4J+Yv8tNXRIFg0r7S8FVSDKyn31JKZxxkzqL3X6A/D9gAi9zRj1n7/YkQ7pq9Zay2HzFtsEp+PNf6XZM9sRViKhMip7jYb66+vl8jFaqJgkUj/NNQ/55HA+z4c8nPsqaiPcw8DEPHWucttf4BKgc4AeWAaI0COOYwu7vA0LAaTuSz/TZs0M3dBWlyjJ6mRyVYHl1Gcjttlh9BDgbgcGNX1nSTLssVsECx7fdSQKa/OSWiWv2J52GrFn0hljBSiBtDaf1amDHexVz4slws6Blro1Szanyoogy4blcw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=H++oK5Ge; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=H++oK5Ge;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWkls0m0pz2ysW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 11:45:29 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZCXlzx9oam8sGzoa3emZvXiW1We2tI5J0z4S337Lq5t/yNQiuP6i7+Ll75bb2MWnT4Argxan1WRKCtn5q6ytP+C1MqnYFJdvwXmaVXI6z411Y43QnorbUyXkxA+J/zkXENymKUDRUvMYPN4B626/+Npl/cKzFuEPKyVwUbxummuZu+mSd2SJW8c4vHRFO4MdQITdDy8W7dE1uBLaWE/KLtuaYl1S321BelRgNSykpq5UyeJaqXeLnG7/+mGwzUXz+VDBS9VnqJCfXra/dZkB0Zjdaidp5hslwBI75KROKyCs/4KlLYftmgamc8JWjGeNVQrNzZDYn6QWCZOEoobhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAUhzvi8NbszROiGJ3s8aDYnWtzWcAo7Drdl7nvwpbU=;
 b=m0ysJI43oIehBH/ZLF3IqMXMYQBjsuxYUBOhL+yP1YrmSRszLnrXSRy7XQ9YnC+mDikQgjEOwwJPHUrU3mK+nTvlsUjBHaIdYJbQkSM37qUxbAoT7aBfpWWGi+N77CgbC1xwIg9WCk4CKNo28XhrkrlTdMtAMv8c764ID87BtUjBY5vOvnAbbHnfb0c6a+pcUgxR5egs85KmjKEAg4ctF8t2LFyierMJLcFMOSjiuLrbrmLyjcmcUX5Qzhr0O+0/WbZdF5X670Q2qGt1z5/OsoRMfWnuTBTX3655GDkDQXBn5WEg2qspkBd3Lgp4TqyCaeD/kGApOGtrQqn4rKYqVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAUhzvi8NbszROiGJ3s8aDYnWtzWcAo7Drdl7nvwpbU=;
 b=H++oK5GeWR8T2TSLksR57ap4r7Rz6ZgZTuK35TriSvEYX0YS3ZSPlJTNDrzmA0artW1hcNvV/LvhivzJ2IxQA+F4JGjaZ80tpqFwHi1miMDfyR3jCNSWseavdhFRdnKHkpluqLbS44Gbw3go17jofwEb8ehvgXgMRDJCdDLSDhY89HVYhxeaFIdiGuFyDj7XPYW63KXfFJyLdvBkpu7mNXfQYIDlku9eRE/7t63awyLL4FW6L71kjuO997OFU09AjSxCMSByYzJQgVNaoxBnp6+yW/XRKunD0EhmeZB7TOhZFcCtXu337UfAY3vtHXBifGGSyz2TyvCfW12t7c3ahg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB9375.eurprd04.prod.outlook.com (2603:10a6:102:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 01:45:08 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 01:45:08 +0000
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
Subject: [PATCH v3 net-next 1/9] net: enetc: add interfaces to manage dynamic FDB entries
Date: Fri,  5 Jun 2026 09:48:00 +0800
Message-Id: <20260605014808.686024-2-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605014808.686024-1-wei.fang@oss.nxp.com>
References: <20260605014808.686024-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: ab061122-48d5-4429-c346-08dec2a412e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|1800799024|376014|366016|921020|3023799007|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	7Qxe1Ig+uaR7UamktqE09EyMoYeAsthVQXn+dtwSYycygqTC8zo1ZCrhbG9FEP7077rcv4T9OZPAr1JAc6xa9RCnN5uel8keHMDbNPaI5Wq19+PC/eCg6RIfNDW/ZkeQNvAxKO0+D5+eq+R+oZWaZmw6tTsQig/vQex+J4nvc/ikM5nRO9PxLGBhjRMG2ZLYRlmGKxXFYORBScW8yHkWiyilvQs8lw/rXAjjqJ2sdGGWesDb+JgyyOD2ifbbo/qQYY+8aFtzPLRIrsuIRLc35gnahrPPlduGVIQDiw5qSnYkWFmISOf00Xk0ju8/hrWgs0JsbSD8SB9cDom/UdNcTQpawSeXNwyfAN6nXWgEFHiW2bmMytrDZwemdbc2hkvhW95foU8c2Gp2JzD4WOd+NHoPxJFX+d1aITgIyZ63RTfFP9zO3whZMibTDFotkqMbd+PPw7CuCNoeJA8Mi4p+RgaFR3gD9dS++2Ai+1O1bUiCCW2423R6lFiGDe1s/gzNFsw6yMKJedSZvtTVPXNBYs2EY9R23bCrH/FsvaaDRijEzUhnn+M36mfQ7ucQ/7/Vn+DLlVw1YhPUkRYfBQmtfYBgUqlxnueGAYTJ5OtvhBY5N7CKDhYbovkiJO7dmvfpm6q7ng7aprkUoy7nR3aCFWC3nDMH/RuY8YtEocWWpSpxH8mO0uIb4CrCVrAe42Hnm9erB8wcnyDwM1iS2fOc20pq78ru2hG7Ffz7NvPDXDk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(1800799024)(376014)(366016)(921020)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hs3IttptY4XYJZo1PVW0MjhCWzhuX/Pukji7Giq2F67ZimRbtfLhYFB8+421?=
 =?us-ascii?Q?LEgbIq6ZzF9VNL3hg9QrltwnB7PF8yPE0tZ/0W98viNW7yp2xV6GBwI0Qbfp?=
 =?us-ascii?Q?THM0acM6KWESPOQOWkh85TYyudepvlhsottxl1j4XXAlB0OYEN640R4pj/aw?=
 =?us-ascii?Q?L0J+O4aHmfo4l6B6gDtVRWNAFdNOogGZLoKsTTyndbpZW7qV8t1IpSsVM4hL?=
 =?us-ascii?Q?fDPQVO4XsvFSmjSwfKbdWcr0kGHvgN+DIpEDidzAq7ck96wDBcfnwdCgYJf4?=
 =?us-ascii?Q?ZbqwXilR4zvXLRWG8Twhfd7DCcO34SWzstqGEFNnwWi9W4lZUOE3tVyvB6JM?=
 =?us-ascii?Q?aq9c0bvApnb5D+BuA9z4Vo97RDuKYx6RFdXw7JVybOkmt80LdO29ceUgPnLs?=
 =?us-ascii?Q?Y4gKVM5C4pE9kh5Y8B9NpMcvCNeWHA9G+992vZdpyDZxUz9SK3pES7e6K/xA?=
 =?us-ascii?Q?qyd0fY2E0peJJg29/gAtw2wethRw+Cr09ESIQdyqy2hkIgdc3BMOXdOl4VJZ?=
 =?us-ascii?Q?DWPCCBc6PnJnmIK9Hm6O76mDWnZqPPt7KEEE8JvaL8iWeuNMhsPCrbQ5bK5k?=
 =?us-ascii?Q?YU/KB6JczuuGTAuxGEy/sQ04HceaPuFxboUCq5tim2fDXTIArFxo7hIFKwva?=
 =?us-ascii?Q?5AsUWjnAAAj3Xp9myTQIlTR25l3x5/uFQ1yuzmLvyAmx6QP3ATkdt9zYDXgS?=
 =?us-ascii?Q?ovNcQiY7toCIcrpAdlIzGwGBCqQce8d6FAPAtg+3limR65dMV9sx755obKSq?=
 =?us-ascii?Q?UU4a6rk/K4fPqH0he6l9RnBtovJyMHadGd9yeYTiDbH2UTNImvIO4yZDmo3m?=
 =?us-ascii?Q?jKBCMo9UqURmVzNMP2+1uiDCYtzXmHZm6WDmYUng8HZhoHZ55qgsfhZhVn9K?=
 =?us-ascii?Q?Rvq8xUNpXmdBWxxbxD/2xqxxyhFG3JyyRvnbv4EENhFDXsEtJ4gZe716XTrB?=
 =?us-ascii?Q?xHyrC3XOLF6ocuzMTCAFj0Buv3MG6SqKPGOGZC7rRGGIJ+gcKdc2OKZsYovH?=
 =?us-ascii?Q?7ioU/JzeB474cDzPd1P2P3A/98LrqliHqFNFORpJmxxvfegskKj8YW90+ym5?=
 =?us-ascii?Q?WtyrE6Mnel4DWOBIA4KDa36xMZw5i7N3APcxuVtBN085+gT6hgFu/y2gqF2F?=
 =?us-ascii?Q?7FpV6yefZwA0mRgnsE80T+ZYGAK6z5A1YQog7jdxqWwUcOPKUL3MlffygP4i?=
 =?us-ascii?Q?M983DAkc7TDvdzD25xzA6cFzoADxrBkZopeZgJHsgpM7BQOfHUWKeg6hpS78?=
 =?us-ascii?Q?U1nSNTL+nzQ3Hra9HyNBrXl8NbYxNCN+9+tzQStSF2as0kke+XGuPFpzVdZz?=
 =?us-ascii?Q?FSjBHTCim3/IdPr/GwDYULzAIg94ldL9Nf58WssrM4j/Pt+lZ/1ShtgG032A?=
 =?us-ascii?Q?VTT0OJX8gtkpCdHB9+2tH53+bZUh0Xs5kPq5WyH+vbAJvUTWb0zNj0eOggfY?=
 =?us-ascii?Q?Nsu+GWxycV+x007zIQesZLUoBDp8z+0tD2AsY8pqsJfeD5u/dZq9xfakvd+H?=
 =?us-ascii?Q?17/snYHIPu7axnTvPDeKKSY8f5EFy6S55lCkNTxNOBx6pjyxOzrgWkjRTSjc?=
 =?us-ascii?Q?2yy1z1GKbVhz66qlK5e0fefTCkWSR2oQtFswVURqmHxDNupUWpx/X6ez5Ucy?=
 =?us-ascii?Q?x/M4We7XAPCsdS1tGEl2lwqGEMklfgKRQ4Eku83I86XhTDh2meOoyYYdstTx?=
 =?us-ascii?Q?2CdKlmHQSQUdrsi/6B5k1RNARkNRsw0MKnr8D5zM3qiPbn1hxPg6w57yRdwE?=
 =?us-ascii?Q?fH2b05kNQmCelp/TRlZKXwqI1NcdQwqvSARsYQE8vXXp0e6+oIEp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab061122-48d5-4429-c346-08dec2a412e5
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 01:45:08.4415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSZIsJZrh35GSizifHRjzN5Vmb/vwFJRIyqc94nOstFh9Rkv0d3k8lqfzRglkeqCS9ttD0BW0cwhtDvKrmqlOHMp6+czvghoudm+mL8uHwtn3TLY3LPCGhRm02opvV+g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9375

From: Wei Fang <wei.fang@nxp.com>

Add three interfaces to manage dynamic entries in the FDB table:

ntmp_fdbt_update_activity_element(): Update the activity element of all
dynamic FDB entries. For each entry, if its activity flag is not set,
which means no packet has matched this entry since the last update, the
activity counter is incremented. Otherwise, both the activity flag and
activity counter are reset. The activity counter is used to track how
long an FDB entry has been inactive, which is useful for implementing
an ageing mechanism.

ntmp_fdbt_delete_ageing_entries(): Delete all dynamic FDB entries whose
activity flag is not set and whose activity counter is greater than or
equal to the specified threshold. This is used to remove stale entries
that have been inactive for too long.

ntmp_fdbt_delete_port_dynamic_entries(): Delete all dynamic FDB entries
associated with the specified switch port. This is typically called when
a port goes down or is removed from a bridge.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 162 ++++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   |   4 +-
 include/linux/fsl/ntmp.h                      |   3 +
 3 files changed, 167 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index f71cad943424..bda26fe93b8d 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -31,6 +31,7 @@
 #define NTMP_GEN_UA_STSEU		BIT(1)
 
 /* Specific Update Actions for some tables */
+#define FDBT_UA_ACTEU			BIT(1)
 #define BPT_UA_BPSEU			BIT(1)
 
 /* Query Action: 0: Full query. 1: Query entry ID, the fields after entry
@@ -793,6 +794,167 @@ int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 }
 EXPORT_SYMBOL_GPL(ntmp_fdbt_search_port_entry);
 
+/**
+ * ntmp_fdbt_update_activity_element - update the activity element of all
+ * the dynamic entries in the FDB table.
+ * @user: target ntmp_user struct
+ *
+ * A single activity update management could be used to process all the
+ * dynamic entries in the FDB table. When hardware process an activity
+ * update management command for an entry in the FDB table and the entry
+ * does not have its activity flag set, the activity counter is incremented.
+ * However, if the activity flag is set, then both the activity flag and
+ * activity counter are reset. Software can issue the activity update
+ * management commands at predefined times and the value of the activity
+ * counter can then be used to estimate the period of how long an FDB
+ * entry has been inactive.
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_update_activity_element(struct ntmp_user *user)
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
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, FDBT_UA_ACTEU);
+	req->ak.search.resume_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+	req->ak.search.cfge.cfg = cpu_to_le32(FDBT_DYNAMIC);
+	req->ak.search.cfge_mc = FDBT_CFGE_MC_DYNAMIC;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	/* For activity update, the access method must be search */
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_UPDATE, NTMP_AM_SEARCH);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to update activity of %s, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_update_activity_element);
+
+/**
+ * ntmp_fdbt_delete_ageing_entries - delete all the ageing dynamic entries
+ * in the FDB table
+ * @user: target ntmp_user struct
+ * @act_cnt: the target value of the activity counter
+ *
+ * The matching rule is that the activity flag is not set and the activity
+ * counter is greater than or equal to act_cnt
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_delete_ageing_entries(struct ntmp_user *user, u8 act_cnt)
+{
+	struct fdbt_req_qd *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	if (act_cnt > FDBT_ACT_CNT)
+		return -EINVAL;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, 0);
+	req->ak.search.resume_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+	req->ak.search.cfge.cfg = cpu_to_le32(FDBT_DYNAMIC);
+	req->ak.search.acte = act_cnt;
+	/* Exact match with ACTE_DATA[ACT_FLAG] AND
+	 * match >= ACTE_DATA[ACT_CNT]
+	 */
+	req->ak.search.acte_mc = FDBT_ACTE_MC;
+	req->ak.search.cfge_mc = FDBT_CFGE_MC_DYNAMIC;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_DELETE, NTMP_AM_SEARCH);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to delete ageing entries of %s, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_delete_ageing_entries);
+
+/**
+ * ntmp_fdbt_delete_port_dynamic_entries - delete all dynamic FDB entries
+ * associated with the specified switch port
+ * @user: target ntmp_user struct
+ * @port: the specified switch port ID
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_delete_port_dynamic_entries(struct ntmp_user *user, int port)
+{
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
+	req->ak.search.resume_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+	req->ak.search.cfge.port_bitmap = cpu_to_le32(BIT(port));
+	req->ak.search.cfge.cfg = cpu_to_le32(FDBT_DYNAMIC);
+	/* Match CFGE_DATA[DYNAMIC & PORT_BITMAP] field */
+	req->ak.search.cfge_mc = FDBT_CFGE_MC_DYNAMIC_AND_PORT_BITMAP;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_DELETE, NTMP_AM_SEARCH);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to delete dynamic %s entries on port %d, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), port, ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_delete_port_dynamic_entries);
+
 /**
  * ntmp_vft_add_entry - add an entry into the VLAN filter table
  * @user: target ntmp_user struct
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 0a9b87286105..ad532b059ba8 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -155,8 +155,8 @@ struct fdbt_ak_search {
 #define FDBT_KEYE_MAC		GENMASK(1, 0)
 	u8 cfge_mc;
 #define FDBT_CFGE_MC		GENMASK(2, 0)
-#define FDBT_CFGE_MC_ANY		0
-#define FDBT_CFGE_MC_DYNAMIC		1
+#define FDBT_CFGE_MC_ANY	0
+#define FDBT_CFGE_MC_DYNAMIC	1
 #define FDBT_CFGE_MC_PORT_BITMAP	2
 #define FDBT_CFGE_MC_DYNAMIC_AND_PORT_BITMAP	3
 	u8 acte_mc;
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 88166f9ad3a2..5db078e1caa0 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -263,6 +263,9 @@ int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 				u32 *resume_entry_id,
 				struct fdbt_entry_data *entry);
+int ntmp_fdbt_update_activity_element(struct ntmp_user *user);
+int ntmp_fdbt_delete_ageing_entries(struct ntmp_user *user, u8 act_cnt);
+int ntmp_fdbt_delete_port_dynamic_entries(struct ntmp_user *user, int port);
 int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 		       const struct vft_cfge_data *cfge);
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
-- 
2.34.1



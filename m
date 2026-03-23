Return-Path: <linuxppc-dev+bounces-18576-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4A9D58CDF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 06:07:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffN424qQ2z2yfs;
	Mon, 23 Mar 2026 17:07:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774246034;
	cv=pass; b=T0bTQlWNymAHIpE4wxQufOKyqBE2P4n/MeP+53ugxL9/DrqS4FSauz6Xyd55UerqZpRz70S5RDuzV2ruhp2NS3Iiz4fqwplhXpoQRumRaNmengzlr6kjkLwW/MgqFoshHogVvylEr4wf4P6GQzWD4NNmRKA/ILu1AVpEcrY/owXtKcIYX6/ezL9kuPTRR3fyWDohAgTGcazoOPWGlE9b1CkfdrDo4DXbsV/chd2MerXofLfMD7O9nDI6R7Zx3a2LxgKxLjbSNd9z0stb9WcKkRqYEpFjXCL/6JYM/RiE1guSogQ8/VAqCBStfXM1TIvoPYazpZGR/hcoRUBoU+7zlw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774246034; c=relaxed/relaxed;
	bh=pKEUnRJ5C1qQcspSblD9yav6rNUhmBFQRiaqsPx2hd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EmwijVcIEOZXACYcfnwEm+wnwNqdRhhqpy42lcnYmiBeGFBdA/i2RorJIOeNDGrAhpEMKMU5Z2p+CXMcJpOBZu2pznkHIGoup91dsJRLF3oseOYe0jRQG6bgkt1NIs1TRveIusXKUWJY07EI+M5NcBdmxlQk6ShmpZ1toodvLpo+gePVqf6R7BHa46EJ9Oijux7H4URKTDEHOj62ru/CeCjIM7IV/t3ExnNCasrl0IpE2dubgDI7X2JP1Xjjj0C6QC7ozugG2Lt3RyC48vafw/TnS1uUcxYr/CLZWLhH8hJjhdAmGxYNyQPSI3CC6QvZMZP+dlL/FNTh6C/fb+QRwg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Oc3J6wAx; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Oc3J6wAx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffN414wGqz2ytv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 17:07:13 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+YMlK+6JBpNzl5v56CPXP7R4sqotsro5U7Lgcx4BpPuyATCF3RzXyLQd//NKxwLRsL2P82HRtxBm8R7zKnxyEVgwWVKbW4monJXLqkq7wnV11ghRtEgXmSxrOR8UkSD4vfLfXqKRyMCw3q7ntJRavdlhlf6WtfNEMxxg9GNRWe8bNazuRTW8nwPmdLBuE+qjXfxRicFquVluaynLpPZppMLpTSDolTWCk16hu1TaScyN9bdNupnjqX4/ZZf7+56KbNPBGg9rM32IwgTSMI6H+XHd0RCh4sSjpzmRak6xsydpW+C6xsDAP6UQAYvwK5GSsUu4B4d5xyW3y/2FCZuMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKEUnRJ5C1qQcspSblD9yav6rNUhmBFQRiaqsPx2hd8=;
 b=eu6y8ilZrS13WSmYqVjP8rE5I3Rnpf6N9SjhIFmiH6JTvcoezf3oZr9HBmi44zc8+B7NJBPNizx+BWNJBaD2Q8xTriKbzp1YKtcMj7HyITdoUUKuE7AxlENYu4vZ5AZgrTTlRnjHie55plr0Kpn9Hxvw8eZ2mxExiO+AWzn9nWwekvaPCAN2UT+NyCv7WrkLz/D0dGKqARevq8imvaNK2c+/N37HYMmpGvEOYti52Nm7MrkuHNfwSF2/p3s9jOGJP8G5v3ou5I0NbCTDLsgfkDf1IjJXYVl2tikZ9KYKPHig2QxCqpffpXhuhFYeewy/RIk2pTZq4QEyomUMv6OOkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKEUnRJ5C1qQcspSblD9yav6rNUhmBFQRiaqsPx2hd8=;
 b=Oc3J6wAxt+IyKjSHs9RH7RnqkJWe7RaYph2Dhpy0z2CEavYdayMNrbGQHPppAEAkWyBIbsWc9V6UyM2pad/b9pVpqnj5LZkjlIgfJtvFrlTdhOI+cgs0UbeFPytjeMoVinMzxhnhXOrm4y/JW1TliVU41625RCK5nTuSwvORHAuZ/EqHQLcckWISmoQAG09xCDitumjwOXrKASjCbYyJYTSQWWXRqR5lgvaHG1O7B+MTOdlYoJicTQQifeWL37eQIxwj1zIyX23NXocld6ux3g0AeUo1CwBPnReGLaOlptSwAs0jhHZTvFthoHiBXY0zakQNY7WJaACqjpmEKG2gEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by PAXPR04MB8911.eurprd04.prod.outlook.com (2603:10a6:102:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 06:06:32 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 06:06:56 +0000
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
Subject: [PATCH v2 net-next 07/14] net: enetc: add support for "Add" and "Delete" operations to IPFT
Date: Mon, 23 Mar 2026 14:07:45 +0800
Message-Id: <20260323060752.1157031-8-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6c052a08-f832-4ed7-b122-08de88a2633c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|921020|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	b6U5hZnIwH837X/LasrQM4c0J7/yL11wdCa+e92GrhC8ooFQGamTn6vcJ0DZ7qLs5+onxFwak1wiUgfHhOOw4oYbeqrXIhCZRuVIMK3iEJLZDkC6fzuNdOI/ELsZFYPdsnLDqCmlyoxKMqi/4AzJj4DokASDMm8sfz9/J4Pp9SDIcLpxwuUFAnyhc6Fm3NBL4VNXwhbFWLaNTgF3n/yUTpwa+/V7ZoPChTSQC4hSHVX8Rhp2Ibzw6fseBHsxjm4w9bEfzeBePlxoL+YOrfhl+rpDyBGngGe6gowJqj8VMTKAnvUgcuvIGhiwVW/XhYr7XRRALjoKSdYacTX8AkqMznnByrdZWYxMudQi2v9gpK27SZIzGZQWqU3Odkq3JfIhFb9RrzuMW20VGnmEGOK9fMMp1TcCWWj8teGgxgtmzUgPNTDypA3SbWYBd/pjwP928Pz//RgkduRxtZmqXmRypvCZtPRKZVt1tUIQLOLh9VgLpc8dbtJVXIDL84b9g0uOk+Sj5bpZEhjm+TiMkrF/qzTtICrGHPnuZPvr8muU5GWyuNsywF1PwdYWBW63rpGvAA35ornOL1MrUXCQ5Z+UgMncA5Qln1y3mj6a104mM3WQv5KctHZZOrMaRnoSA17sfN54wVMuUtR5PkB96Ea88ip+Bx/bvRLrzkvtaK2H8/YUlcJWNPjOvj0FgV7ScTjPyYX46m57GetA7VNwTimV6OONXgBM4Oj0tvjgY64SyVrJ053WEcUKCdPeuY+yu9VSKul7oj9XnRpbbziUl4el8wJGiqZcKGwRrdNOgBt84yyMSWP69RA/4//UzlKse9rT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(921020)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8vQCh7/oC3j69IcdKdNy4Z6wZGEtvqHYWmtG7SKxPZbRfQE2M9g9IU3pHRYu?=
 =?us-ascii?Q?lJ9tki42O7FADcz763n3GCAr8Z2xy6Csak52m9Xit7eTitqWDNuZERnOL6CN?=
 =?us-ascii?Q?K76xR0Wt6DT65jKiIwkyHdgkGAX9zv8Yoi4OTVXPW0PoI2UxMz1xyTC3NJ/o?=
 =?us-ascii?Q?gmN7F56TyV9cPy1MPk/qVQ3Ur6plL9JF5B7kWHDxPceyXN8ugxY/4sPwr1G1?=
 =?us-ascii?Q?pvd7Dunxqo6kNkZmcQg9UiUAnOudOlRxXBpB6aRNz4b2V//4/uzjAl4lO4hf?=
 =?us-ascii?Q?6oqKp1f7l1IkD2mQyGDeZIM1zOJox/Oo+c3SfxsOS8AgcdNX1ID92UaNWwgj?=
 =?us-ascii?Q?EJIVfWS/vzpPx8slmYu5we/kwTnWlo/8WQUX5QKA+6P0SwUsrT4TLbZaZ3R/?=
 =?us-ascii?Q?zDBvqd0aUNhLhZdygSHhu2FCqpD0NTNO51f0X+BQrLaJE5DuuQaKkmseKx/o?=
 =?us-ascii?Q?/4j2mfTfCMcJLaKrYC9E5Z1c9GTkOw9nmt+6Ev0QP7OqgIh0D/ZQfQdMvi/B?=
 =?us-ascii?Q?dsBh3UfbPF4TGoYKPpGMznkJKvwTbb6V0PoTntS6EOEU0pyzfNFsSRf+NN0U?=
 =?us-ascii?Q?g6D9BNTwd5KqUze7hZ3vyOsQLKG56s7KP0K0cliiNaI+mdL5OkGg4UVK2bAY?=
 =?us-ascii?Q?FFS2Fj620JYOEbbpJMunMgnGcnbKYMKIa2CU06tGE3OKANv01jMvR2y0pxId?=
 =?us-ascii?Q?o176Snz293BWNL3KwPKxlOUcFHsiJf+3z01QhU5BJc2qpD7qzQOXhvUNIPv8?=
 =?us-ascii?Q?Z+nXwGuciZoWKH0QLhCfRlj9L8Zfw0BG92E30syxoNZDVPnm+7SPSEsUgLgE?=
 =?us-ascii?Q?+iVJozKXaqYAxZf83Ilz0u1h7X7sfjZQhMoQpViVfrmxVw4bvFz3+RCfgIzP?=
 =?us-ascii?Q?NyxDRAlYNrFNrmicvGeHkx3bQ7EhnGHgP3wYIZZNcaUgY0RM6UHUgI2DLCH5?=
 =?us-ascii?Q?g76u2aWLblW0oyqijj30i9MFj2+ZLsJ+uPhUi4fV6MPosWGGuOQpV7L6Yrik?=
 =?us-ascii?Q?em1tO1Gn1WP9zPP6ALZd0XEYvd7WLkjxlmocx71Aw3fMzIySO8XBkBdGIvI3?=
 =?us-ascii?Q?BkgsDeB9sc279grsKi0vkkaQ1RaBkmUepov2JmyVUvMDN4NZeiZ8ugFpo+ir?=
 =?us-ascii?Q?fzbeMs+c9faffREqBjKpm99nHO3Y8DkrDY0ubv5pPXSnhc0y4VFuBBdU+0Fq?=
 =?us-ascii?Q?G5K5Tk9/pKZPYu+lhV06vogyjH2jfWcmlmiJgtJuhM4n85CfXiL9fIpvmwII?=
 =?us-ascii?Q?fqARu+f61SyFWAP7xt59NcKS6qnPwD9HEfySAcCeydSp7qx3N7CGmizhkSkK?=
 =?us-ascii?Q?frC52TX2MiyBtRj+VO0wL0ZEZoUsxNnwlWPEFucGRw9oU/K7pKJfLUTxSGf0?=
 =?us-ascii?Q?ioHDWg0vy7He7ium0+Ff1O2OX7Xg6wKk53LFsiT/+JT6EC+olL3GKn+AYrvY?=
 =?us-ascii?Q?AySU+GKuug0ZhmbZ1zVDQyZGDEm2PxBS2zgy6WNQjYkhrCifU7iE1z0IJkov?=
 =?us-ascii?Q?JfrQGpU+QXTIY+a5nrKT0zUtylcKautlpBb513crZduQLbsOY8xIuVA4m+um?=
 =?us-ascii?Q?BFsVrnOuIIU5yaFNtF2bgSBSJ0MnpLVpzyhDhE8+VkFjOI6w8vz90s+3IZKV?=
 =?us-ascii?Q?PMXaEQOkBYBbiGwpIqUfDRshZKBXokv3wd/tQDWcBMPLj7txWL2EMig3hsm2?=
 =?us-ascii?Q?2eY7QhqJu4EiE79uZjT92QGuSO8f5JpkISAm8o+TLHBcL7pP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c052a08-f832-4ed7-b122-08de88a2633c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 06:06:56.7230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A45FXd8++mcnxA6wsnGRjxOuv54UJMvLO5SDPC54vX7YAk5efzWSr+dMq49HMYJY9CzSU68IQdMWmBb0zOJJZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8911

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
 drivers/net/ethernet/freescale/enetc/ntmp.c   |  76 +++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   |  36 ++++++
 include/linux/fsl/ntmp.h                      | 104 ++++++++++++++++++
 3 files changed, 216 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index ef38ebe94da8..9fc3422137fc 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -20,6 +20,7 @@
 /* Define NTMP Table ID */
 #define NTMP_MAFT_ID			1
 #define NTMP_RSST_ID			3
+#define NTMP_IPFT_ID			13
 #define NTMP_FDBT_ID			15
 #define NTMP_VFT_ID			18
 #define NTMP_BPT_ID			41
@@ -234,6 +235,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "MAC Address Filter Table";
 	case NTMP_RSST_ID:
 		return "RSS Table";
+	case NTMP_IPFT_ID:
+		return "Ingress Port Filter Table";
 	case NTMP_FDBT_ID:
 		return "FDB Table";
 	case NTMP_VFT_ID:
@@ -468,6 +471,79 @@ int ntmp_rsst_query_entry(struct ntmp_user *user, u32 *table, int count)
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
+	struct ntmp_dma_buf data = {
+		.dev = user->dev,
+		.size = sizeof(struct ipft_resp_query),
+	};
+	struct ipft_resp_query *resp;
+	struct ipft_req_ua *req;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	if (err)
+		return err;
+
+	ntmp_fill_crd(&req->crd, user->tbl.ipft_ver, NTMP_QA_ENTRY_ID,
+		      NTMP_GEN_UA_CFGEU | NTMP_GEN_UA_STSEU);
+	req->ak.keye = entry->keye;
+	req->cfge = entry->cfge;
+
+	len = NTMP_LEN(sizeof(*req), data.size);
+	ntmp_fill_request_hdr(&cbd, data.dma, len, NTMP_IPFT_ID,
+			      NTMP_CMD_AQ, NTMP_AM_TERNARY_KEY);
+
+	err = netc_xmit_ntmp_cmd(user, &cbd);
+	if (err) {
+		dev_err(user->dev, "Failed to add %s entry, err: %pe\n",
+			ntmp_table_name(NTMP_IPFT_ID), ERR_PTR(err));
+
+		goto end;
+	}
+
+	resp = (struct ipft_resp_query *)req;
+	entry->entry_id = le32_to_cpu(resp->entry_id);
+
+end:
+	ntmp_free_data_mem(&data);
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
index c5f6dca7b660..9411ec9f1777 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -103,6 +103,42 @@ struct rsst_req_update {
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
index 925a455935b0..f6d3bb2e318d 100644
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
 
 struct netc_cbdr {
@@ -66,6 +68,94 @@ struct maft_entry_data {
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
+#define IPFT_DSCP_MASK		GENMASK(11, 0)
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
@@ -155,6 +245,9 @@ int ntmp_rsst_update_entry(struct ntmp_user *user, const u32 *table,
 			   int count);
 int ntmp_rsst_query_entry(struct ntmp_user *user,
 			  u32 *table, int count);
+int ntmp_ipft_add_entry(struct ntmp_user *user,
+			struct ipft_entry_data *entry);
+int ntmp_ipft_delete_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
 			const struct fdbt_keye_data *keye,
 			const struct fdbt_cfge_data *cfge);
@@ -208,6 +301,17 @@ static inline int ntmp_rsst_query_entry(struct ntmp_user *user,
 	return 0;
 }
 
+static inline int ntmp_ipft_add_entry(struct ntmp_user *user,
+				      struct ipft_entry_data *entry)
+{
+	return 0;
+}
+
+static inline int ntmp_ipft_delete_entry(struct ntmp_user *user, u32 entry_id)
+{
+	return 0;
+}
+
 static inline int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
 				      const struct fdbt_keye_data *keye,
 				      const struct fdbt_cfge_data *data)
-- 
2.34.1



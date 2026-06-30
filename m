Return-Path: <linuxppc-dev+bounces-23166-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855ADC43327
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 07:49:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqFdv6Z3lz2yrT;
	Tue, 30 Jun 2026 17:49:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782805747;
	cv=pass; b=jX1+Ho+NDIX6caPeoLY1oXeSJpctRNWkt8A/kj4CNqZJ+3brB00ob8Jh+zQG6fvzP9NsLExQuxev2Gvg2PpQkGXG8E444MmyQi3/l6L/YfrHLLRY8K+uwPBCsPeUcmvoR1URmbU/nPOPNout3DB1Ezgyet7XFReStydHAXcRMGzNSsuTnQYPuk0r8pORtrW8NhDisfXxiOYWOaNtc66PBiDFdg/SZud4++MiRi5I95AB5MytTNJ9liK2i7kOSzLVH+SagOI9nqNmjmqzaHOlHn3StpBp+T1eGQNSUQxJqWCcDFgo5dDrvSxxZaatMEl2FtDHgBTiTcv03+AkHFQLaA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782805747; c=relaxed/relaxed;
	bh=K6uEoZVelqqiPHG5MINFGev4roHy4M8lixp1YqZumD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g9ScEaJxMmYvinYnXdDBxhwujwZV5uZfGozggOzN1Wqr3trtQZ7rTTRbUHqft4hkFhIEmeJjvzpru4XGE9wP/2HJTCZprBMMeMZXcxXcgliJyDxC1GK+nIL+Y9903+1oTtE4m/vDGP4JyIsKqsO+1ZerNjy263Nau/LIg1rHL9jvv6sHpXYseGJT0T44H69pdn+RLwkqz2zEHrD+IqMsovzy7pnNIr1zMF9CjY35HPwvyGzIccS2YoQcbLVxEd+n1VnAMxdgN+RZ2m5b6HDxlrtsqMuclqcS8wb8VauILTvOhQaKhaZYjOT/jHu5pYpIHYiOMEwPTAM8mYh4s/zmYg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=HncSFShO; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=HncSFShO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqFdv1Xjsz2yqw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 17:49:07 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nx7xwsS9XgwYodNeQLgdRRwCoaZ24yvhebHP+AMXUqS3b6ZUpiDWIoIXeCt3DUlLrJXunynDQD966bH0MkW+rJTvj39SHl6ISiHraHVDuLDapHd610Fj2ZInhzOXEex2aljejB4Ddy7zyHBz6bHe7+k04uwgLxINGZMKa29CyJ6Qb2/gLSSWh3zeAWLkXCF+Tl3m9HqQyoLA5fGPpdtqopyt64W2vThmCbA/neHsczoph9Uq+jRoeiWsvj8sSOC1gc+4uB8uKkPQaTPsEIm53vsTpku32kF65iN3gITrZfzeDCJfibPgpplLTz6+32LD2xbcmpLoc2vOucYb7VN4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6uEoZVelqqiPHG5MINFGev4roHy4M8lixp1YqZumD0=;
 b=sxjuWv3ejZNq33zLbb6jpSjHFEy1+ij9Bh6nDDzVLXX4oyPx5jc/pOl2M9ycVi7BopbMhkHBkewXtJ1cargic/j5CsoOgDZurlwWL3JPQj5NPLR9THlj6Dj7UPImDXuwMPvjPA+3nlqXmIeQlve+1l2bl+0c5HN0ks1dXVQyRLE57HUWyZ+OeIlBBYSbLKVUmSJG82uIyoexWAf2dZHhXO9tWj7bxAV8ltugumMyXWeDidb51ybDBk+lsG/B6/H81IhuFQ1+cP3L88F4Syw3XaRJVazSjASVRz3VqlTFo1k+aC8K14KvgrCFIDMNQUrk8iPAsj0QYyS1ND5OWKBl+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6uEoZVelqqiPHG5MINFGev4roHy4M8lixp1YqZumD0=;
 b=HncSFShOEA9WQwLDpXu0HJowlZ+n8R4oDygeGHkuifAYp5uEyTsEVj7ctesYPnqpt3mqifxa7oNdRPijtQy5UT8USHdBlG79oiLxaIdzY8kXOm+fblDKRopBYZbP05fA+l2cgOBNgIv9UeZTPSeB2/NWbXaSyca9xHDueeP7giYIjEvB8Qpwrqlbbe6SxCc7k6DOkn6F2MJyWQjcE8cUa309hyB5hXCyutFyxSF9EX9SViu2az9GU8YY25XwlcYJkdcdM9dA5vbCvyNSOfQ+zgygtuptsg+t4pX7IoCeyEGZNzlhRxbOUFuzOpdKYdJwpj1fwh0Fn5gYN8ANJ12vaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU0PR04MB9561.eurprd04.prod.outlook.com (2603:10a6:10:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:49:04 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 07:49:04 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com,
	chleroy@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 05/14] net: enetc: use PCI device name for debugfs directory
Date: Tue, 30 Jun 2026 15:20:27 +0800
Message-Id: <20260630072036.382761-6-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630072036.382761-1-wei.fang@oss.nxp.com>
References: <20260630072036.382761-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096::25) To
 VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU0PR04MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db379c4-79ac-433e-a3ea-08ded67c0ec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|23010399003|19092799006|1800799024|22082099003|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	Okqh6EjoqGG0AoMDanD9AK7RmKA1gawby+5oXJTRIPooPU4vKIf2nXYkE/B9akyvgoGYNUym2i/zB60lRKjWS3ZiUpGqUcWqFHuDeQomSlbGqwuPvJfLaQcWNuHbrmdgvDs5No1VsZdMNqoKfuYesUVTMwFx5lhO/uKGmSF07uLYy4Oub65BEtyF5woozQHF1CQIbMRTAlBDwOa8q41Acsb9LmkLZnZPTiPciUXysCGjVcQ9x9k7Ik76ohGVgc0IP5YkqvuCWLCPXOCwOX4aI+IH9OxhCfWafoKa5pxMOLPXI6YTJBFlEMaL4luIBelWLoQXTA0U6N8ma3FYdYr4fInnCsfyscZEuAcX0SosN7jGDD24i/PbHwmC8/M8cSDwpxym6EHjwfF9xaQZttSSbAuFCknR18HZXlwYtKG6RA9LSWrpeDbnFDvcyvPcQ22sb6tEO08nD00JTIza0k3NO4AzSZoGckXS8mOZlMVPssfs2Nwf9J0SDPFNJaV0bsEiZEv+5JnCXuLydhqTjmf33sWdG15tWXrKGm9hk29O9L6IV3KYOEftGRnPITv97YlztSs5f8wEzYMOSDKqdXQ+jDuclHvWEY+Sci2/yZBp1A9QG+9QoSnhFRNJfCJWngHbMYbN5xya9S+qCpE/vOg3EakPWYs6iYneKd4MEl4DWXTHhEGe8sDubRYFhTITz/PV+e83YAzVAsDNBoP3YlLXkg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(19092799006)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8r1m9+mjypqs82vleyQM+m8HnraJXxIWccRHx3RpG0TV9PPtbUkERNMCpRsb?=
 =?us-ascii?Q?O+3e3r5CjjKi+keyAokeII6SFJXiFw0NfCWFCoKzlQw/3PKMxCZsvnQnF/fs?=
 =?us-ascii?Q?xhWPl+KkjvNvC/2tFmMFe9+JlC90Lac/erN2ssUpGYnixUTP4uJ+zbK3+xD3?=
 =?us-ascii?Q?yEEJmpSbuv2T/la4Or7iHR7MuJk9z2mvv9ij1mhK+RVzYJca4zyZmQ7azIZs?=
 =?us-ascii?Q?ajMZmMsBXbyyQb3nD4VVpoPA1u+wBgG+nJIliKisoXabR/kG3K30q+KK+3SK?=
 =?us-ascii?Q?+78wVi/PHuAqVsQ7ZMovCvteaijbBMntsx4fih/TGXzkWs49KCcWTY8S3Na1?=
 =?us-ascii?Q?tKwpCbJz73frUw7xidnJcUHwW1cWLPe1w5BIiENN3Tr06MlJ4cAlnX2UHsfm?=
 =?us-ascii?Q?pjYPj2ZXuYCdje2GBQGiWtvC9+AvYgrshUl1VZuT6qIbsa+iNi41XateCM1e?=
 =?us-ascii?Q?RpsS3I1AQB1FtnCvLgg3hhqtWIcYQhfyKyJgvTUjE755IhxouEqSZfwsnXnk?=
 =?us-ascii?Q?+5M4m5HDb8BAFHo1utB9RTQO5bb5ET1L+0RQxkUsKAohtugxnssWrHb/fkg3?=
 =?us-ascii?Q?e33HcpZsXrmu7RP/Bj+BMMqq+ihDxsq20M/epD5+64XZXnWzyRFtxqh5usuQ?=
 =?us-ascii?Q?HcYlENdQfLn3kFl+9CxyYyWnwd44Yu54yMT0lGUIxTelhuJcJ2zGmsOdJ8fp?=
 =?us-ascii?Q?5mUX3sMQ8JPJ36S3no9LwDX06TlxFLJ0ftU937EaeI0SM+QB9wcN+LzgwpZn?=
 =?us-ascii?Q?vSvkmg5xBZpiCkvFy9yb/KR9wd5h6FrJR4AOmf0RXTZrqH1e/MjOywtbsVUV?=
 =?us-ascii?Q?AmLfNrxDZRgCB0uFpRM6FrZycmZqwKJsNAf2ZHhl7hu2nUi3JguMCTopo9Vw?=
 =?us-ascii?Q?VN7dTwS+n+EedWf+RU4AORsicljwptO7RIWsjTIHuxeJ1iZKFw4/YADCI9NZ?=
 =?us-ascii?Q?UNwCimyiNNAFypYoXCBq8NZtem9T81yNmdyZRMXnQgMxDSrjdgpbNG2qKsJR?=
 =?us-ascii?Q?6vWtaAm6ZOa6HqlVmik5OZMMIKCzAMt/QL7SZly4vYvCKrrb8qp2JnllhPrE?=
 =?us-ascii?Q?PE9998Wbdcbnr3uYv5s2+AuUGVPLF4b4sQTCSObVTorJxkk3/FQziZTFI/Mv?=
 =?us-ascii?Q?MWXWTN8oWuALgxIPfMf9zg8AimdHjYuR1vRj2OlE2yz4PahOxHlWgl+malYO?=
 =?us-ascii?Q?g4BuQutnNQXE3rogUgkQ6ijloZ1oECZDaGmJGf9XyE/5zBEvuE5DQAQ8G5l8?=
 =?us-ascii?Q?YNS4j6fghzjJuZLJmuVr7B9VRIjkvK6queeFjDc6gP6z8M8c3h6WWQqZkgND?=
 =?us-ascii?Q?R9Y/8fmDMkXrf+4tivREm5npldvL8IbVlsHrYQ9ht0wQuqxfMw76tbqr53P7?=
 =?us-ascii?Q?1M3XHWCs6K0h2jrU5wdBApg2+uy7VhS1KoncFtKmqlceozNCYz1BcPPeQbya?=
 =?us-ascii?Q?/69ChTfwr/LPQ4kt6l7XOfp/89VXayHThB6vJqWMGGgVGviPXk5sUel7vsX9?=
 =?us-ascii?Q?O0kNJ8L4UjQeW7sp1aoAw5I456rwleJRT1m+gBtWJccAvokd1krm2RSaHTxd?=
 =?us-ascii?Q?s5U5ZTRqWgwbvM6U1l0WdnWpyN0zyN2nO6gaKQPFKjBgG25HSOuPN9kXVKAk?=
 =?us-ascii?Q?IvsPF32mndq2SZyVDNcCEYb9YaqRmFr4GojtM/XhZ54Oj1XHBNqQ5GTIjgU7?=
 =?us-ascii?Q?0eSWfHK2wi6FnxWxdGYj0PVKshSiqPWIWxkcpo52XYCyMKCRUvtg9wyLl9em?=
 =?us-ascii?Q?TAv735jhtVB4AFB8kJOqHQXHQjwrdNaP/e8CDccs/WMW1B1CIAt/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db379c4-79ac-433e-a3ea-08ded67c0ec0
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:49:04.6138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Udkp7GXXSvc8aFFUEur2ThNvbfQCTpnT7wlL5tXDztLmY6Bxe17/L0hs9DBsFMxTB6LcEuyf6CGWeqQb3Fndx5lpFlazBjqw88W0HaZ8Qmp1mf/Ounnsyuid9WUxLjI3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9561

From: Wei Fang <wei.fang@nxp.com>

enetc_create_debugfs() is called right after register_netdev(), at which
point ndev->name still holds the format template "eth%d" rather than the
final assigned name (e.g., via udev rules).

Use pci_name() instead of netdev_name() to name the debugfs directory.
The PCI device name is unique, stable, and available from the start,
making it a more reliable identifier for the debugfs entry.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
index 4a769d9e5679..be378bf8f74d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
@@ -81,10 +81,9 @@ DEFINE_SHOW_ATTRIBUTE(enetc_mac_filter);
 
 void enetc_create_debugfs(struct enetc_si *si)
 {
-	struct net_device *ndev = si->ndev;
 	struct dentry *root;
 
-	root = debugfs_create_dir(netdev_name(ndev), NULL);
+	root = debugfs_create_dir(pci_name(si->pdev), NULL);
 	if (IS_ERR(root))
 		return;
 
-- 
2.34.1



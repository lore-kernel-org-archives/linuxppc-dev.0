Return-Path: <linuxppc-dev+bounces-26259-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D43C61DE2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 08:20:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYMPP3Gx1z2yvS;
	Mon, 31 Aug 2026 18:20:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788164425;
	cv=pass; b=GtoVGLf7OF4c4tjZmaV/fLiZEt7+oE1qHVWR8FSU0PQM4RfeyQOIHa9cza/LScZQL/0Hu0VnooVDyrL5KsfvgHUWabQjNbinacW1Dv6GBpd3k8RUvSXgVRVssNA9MOIQdx7wwktez5iL23V0LG/d/a5h0yJaJX3wEzbRhW7P5Ga+8tT3XwiQexitcazy3psK7y2RVJhce6NWSY4dLH3zLKpp6wPGKsyMFryUWt2rhFZRQ6Wq51Q3t8WNB6O+BW8b7/3kQW84BL8caNsKMzgs7kmO6aS4rg9uknEKXvsZplBrNnaes2vCcaz/zCHvidnzjWR4zeRNv71lZymZ02eqaQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788164425; c=relaxed/relaxed;
	bh=dUUTVoKF73qN9xCaIGE9utmPgrdLCgoMoqDyrvqHrrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ROOWCDvtORP9SEulR1wTP2/FDLwQwbKROKJtHiWpPvKzFex4WoPD3nMAanyZ1TW90GY1/mQkuNAPWYUs/9zMHm5/p07trH8XtgR2NUxisRpEQNamm6NNU8jz6WWovKCAZ4QFkkbCngYQoX33HJsFSJs5G38HRyGHZbeGIa4RL7nEnMGh8IMAyLYLoV7RsyxnwB1co703wS+cBY5O/FDh/qzOKZTYcyGYRzBCz28Fb/FnV+iE/tjPh1igjKTQ9DUKfc3IkuFw6XpKqA2BHw8X4tFuF+Lfoa6y43dZU/WPFFD/ViGqn3wJpe3YxBb2aokDdzy1tTZCMORqb0JvDvOeAA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=HdXWXhNP; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=HdXWXhNP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYMPN4ynSz2yrL
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 18:20:24 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erqzOYWCd8il4CRUcDorp3QWN7oGsWOY2SM53ZVkOBJOqRH5FsqxsK3NQYxsbjMQYzeGAkuetIn4D+e5em/tG2QcUtcVNCyKR/w1uj4Ul+mpPBxXtyCsC4STIWIfjAUywMpiC0+SKQl02BTPtBqZfYpGnAZpS+CpDShhccdnzINfAst2TEcApxilI4JB9uLUghi4yiNBCa2wVfOa1iHacTxHwfgzwt6QrdMg2Y02YJwzi48eclT12XPJ06Bc6TAxxQ4cSLjCpJm0Q0wx4cZn+3Mp0Rss9Xmm2dLTLPBJShqNJlNsOg2upf+/BGX3LF9AnJKxpY1AuqIdQYNJSUXNQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUUTVoKF73qN9xCaIGE9utmPgrdLCgoMoqDyrvqHrrA=;
 b=pLg0j8jhw5whTI7Syg+CstOrfWmZZI63y4DyG5Ee0SDp0fDKzBo7aZDnavup/wl4CEt9/bdth6Pb/xKtmbZ7hKcUwcsp0KETQzHtt5xu+cBsZoHrlF7THNV5BV+YetKAxRl52kpeavUR4ENUggKQF63N0L/dxw8nfXc+SKOBuWeMgMxq0WFRgrPvRpy0yuR/C3O2rRX7puwfqq1VUphcUPqKluJyPhZABhH1eSRDzpLUOqjmb/zrJmwTIy4+TUGjdtBK5RnPfAaeNv2vSGChPBZEuUnnfr6dBh/Wnh2zIFwZ3kwwsavDPj7RtKcvLq0QDJH3xv58JHRBBXccdu5SxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUUTVoKF73qN9xCaIGE9utmPgrdLCgoMoqDyrvqHrrA=;
 b=HdXWXhNPC0b+bE+p1eU2n43xDK7fpeZtrcHphMDXP0mZiKfhp187guaZ89H7PCrf8P9jLokw4OBrL0BFHUV4Pw9GQ0ZyeV6vFmuImJVzErEhOfApKfI2424YjFCDRUOv0jhw2RaxKfVtfJJqICyVclhh7jrIIDQdjwRxIThIjdCH/WS1g9k82k6jQm0ViVT8x8Nu2n3nmUuFUcZxADFYh0uRrE09s8wmWUMurJaEd59tJ+foagXak0bHPPkI4AG0Y8QZpKk95p509TlOYJrulsMc1iGRTsv23ABSwahI2SNUKPaNrjd6O0Y6qdqKYAHTWBE6lHeECTPmqhfNo0xVDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by ZR6PR04MB349300.eurprd04.prod.outlook.com (2603:10a6:910:da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 08:20:01 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 08:20:00 +0000
From: wei.fang@oss.nxp.com
To: xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	richardcochran@gmail.com
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 net-next 5/8] net: dsa: netc: check return value of ntmp_ipft_delete_entry()
Date: Mon, 31 Aug 2026 16:23:32 +0800
Message-Id: <20260831082335.1184605-6-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831082335.1184605-1-wei.fang@oss.nxp.com>
References: <20260831082335.1184605-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|ZR6PR04MB349300:EE_
X-MS-Office365-Filtering-Correlation-Id: cac34283-9f03-48eb-153b-08df0738a6a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|23010399003|3023799007|10067099003|11063799006|5023799004|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YpKpQAo24fCxdVBGMV5n46TE+/aypORkMsfFVZ6B++RR/7i9pOn7zHWf8BmPC9Ie+vGtZBCC/m/M4fB9E/2V4NAn32kVy8MGg+0zZV+P9d1FDd4bw8gcVftjqz9PMIEqq1AZNsF1/xH9SULQHBk3WDXo9RD3iE+TSgyRrYdIN0gme173P+oA/ltUpN594JGvVBZ6AriwfR2HWZ4u5FkWUVO4wo0MP/Sumlx9QyEAefXo+/2vSxNq8TpbCgwXpG6T4WAFsb0Zg2Gg6j8tRYzQwVeM63ZdbsE5kQkEvu7CL1e2R4kA8ljT5khtM6PMCV7lUOSupxF9nRomHtKdw7XG812YzWziwMQ3L+sbaRNOjHZ+cCY77x1NxgYE3P09pauYpFkp+c3DnKZPFYWcL18GOK0jtNm5L9jr0Scrm0kiM4A3BGCu0v7WT+7B1i7mAM9pviUwHBrq1lAVBJ0xxY/22NY08vKS/KAa0vD8LPBBCPJCUT5Li6UV3wSHc29xq0WA1Rrv408y8gFyKBREkRM1xdGgUzwEsX2+t9EUs1lkGTb9XuRGBMPW2UswxdVpU3gEweF3Q+TjnYAW8To95tBHECRMhobY1ypyP/e8xNW6oqFffpurtRYxDvwwIt43EERtgjxkzATVOXLy9DUYdIkS+qO3Vq6gKJiQZSKM35GWfmfiKDmehPIZrO8IpLZYl3MaMtsRI8tdiPa/KdX1ndhG4A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(23010399003)(3023799007)(10067099003)(11063799006)(5023799004)(56012099006)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mrW35XQuDiZIZ9RZPwPMVRVQfoZ6J+e8CZ350LD6aMIzIJQJzNpKPgHMWkBX?=
 =?us-ascii?Q?SMYU4cmq2Fc5q/LhEbbOCeiGA7h2dR8bk63RDYnTKONY6XUUbnyuB9MON9k4?=
 =?us-ascii?Q?GzflLbcyU1pe4nhLTwtAnOngXdnj/7/zK2ZRk2gfTeU8tZECLLVKLhx76Qmy?=
 =?us-ascii?Q?x9uIuspBrQrcM7nZ2UVZQpX7VRgZaFDV6B7K6wxjEgjjJjEL/uy167b5oyVL?=
 =?us-ascii?Q?77Z5clfJUO0Wt4ohw7r1Cpm9zXdnA9xmEsVsT3pRlsD8tLqhgo/lQ/E3PCOT?=
 =?us-ascii?Q?V+25qTbnf6COKVzXe2EUyd1aGJPGpJ9m4flrWzm1vbcGUGH4SdRBsjTCOaTM?=
 =?us-ascii?Q?fYOLggcS+1V+hKj6O2Gdb9tpn8qzX06VdjRY1gY9psrePshW0R5lpwv5lKwR?=
 =?us-ascii?Q?XIoiq0zwFIRbMdgGqQO1gX3bXQgfNWsBkm3NyK78IvHTNOw5E9f3TYh/fMRm?=
 =?us-ascii?Q?v0CZBcremwRk2xq1Ph/71EUjZrMKPfO8ThQbCTHaKYJSP8jRC9+LVqfchmJ/?=
 =?us-ascii?Q?os/+g5LD3t9+lpKIbxZ0RsDL5F0jndpYeeb8/yjzBY7UpfgQEMaWOvLfRm8e?=
 =?us-ascii?Q?4sacUb63H+NgV3LURAxAeewqp4h+U6ElhweWEBbrSyvqvOtKnLFJKqTFyZU3?=
 =?us-ascii?Q?Vx88BgGqAGZUepahPtzON2u/UsAM0LZi9Ynsjqch8o1e/HKdvkorsFTDOMWU?=
 =?us-ascii?Q?aylDkDrKUPnhvEHh+8q1eVg9N/pk0SwecKkUeDCi5nhnKy1oKUFoiqbxuteF?=
 =?us-ascii?Q?C4girB0+6xR9UhUgnH/gBzp9+RlZemF82QWDJo6hX1PaxZbNdg/ctOr+6yqt?=
 =?us-ascii?Q?bv2+VCIe0IQR7XxKOYNjDi15nb8UR8B0ChHQ5LVmUdIM4+Mw5YkE000egO+9?=
 =?us-ascii?Q?82QcCg9dgdbOCOlcv4bE4+xaS1b+1N8RFZcdDBG3l0t1iBaoraUZ7AEQfvNQ?=
 =?us-ascii?Q?TlAIbDSjMD34G87wmHYBeoEkg/Q64QOLt9vkgxf3bFe7RA87G5m+/UOy/dCV?=
 =?us-ascii?Q?fdgO/e46dBVYnweQdamdjkbeQniYvd8t/VQKZDJ50ReVBK5THJiyKdmNsj2w?=
 =?us-ascii?Q?WkJ7q96AFqzSJ49HOaQclc7NkuYx4TNAdKOMX3HuReLr1lsnMPRbLabkZ+KG?=
 =?us-ascii?Q?Y2l8y7Naz9FXIElk3zO+Iq3RkcBmcpc+iPA76qa4kC5L0I+Z0nT5RMue+NhT?=
 =?us-ascii?Q?bSCS5Ee3RVM1HF+HH2xprLPtZKkFfsRO+tfHNT4bVGNhXjpViDRBNMRUApgz?=
 =?us-ascii?Q?cq0pIyOZTKD76+IEQhflRhd7nkh/50CRvfm4rETP34KoTEOx/gKXZ2sEiW3P?=
 =?us-ascii?Q?v44FGVujoS9kRJzQsp3XSYhZlVQfE5X6dFm3gGsTZ3oDybMoT17Ponngyhn2?=
 =?us-ascii?Q?sz9t5dEusWI85hN0wS4TjPzE1i2p/8uamt3O06LQqIMMR9mBPvCa4NcZJFMu?=
 =?us-ascii?Q?6Ukf2vJ/UU/QsUPGIdMKH2LkCj9Vihg0MOQ15FgPSuJGL0jRnDDe7YLsYtw1?=
 =?us-ascii?Q?O0GJ7sFWtyCNVm5/frq0EIoWLJN6C+MEFpHQSLFg9dvYPlAi3sCaWYjQ50Xu?=
 =?us-ascii?Q?OACRkED/BIdxEgfJxMvlkbhAWp5lCiJDKKijhqoHVYQaD8GQoKbuFwHP51Fy?=
 =?us-ascii?Q?/1bjNL9Ak0Xrz+fc1KQUAva81M5yWY8x9nZWx5cjzpllcdaZuMVOcBOF4XpQ?=
 =?us-ascii?Q?PXAdqoP9pff2RJgKkW4uZIwKTC8NJ7sacLtdz4ZtBTl4ipZWsq93K75wTXvx?=
 =?us-ascii?Q?BEapnIweJej4jr2idk4B4vCkZuNlReIoD6bC8WOukbFKxmt1w6w/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac34283-9f03-48eb-153b-08df0738a6a9
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 08:20:00.7457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9TkXSXIfWaGUSRfyUnWEYmpgu6D+cfdQeX+iBALAO4h2b6zNKgS+V0vvPI+PoT2OD3joDA5iz+IE2Wth2EEkK/JzgL1r4fyU7yIq5OFZw9gXUX58YpfX0REHA5LuVOM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR04MB349300

From: Wei Fang <wei.fang@nxp.com>

ntmp_ipft_delete_entry() can fail, e.g. when DMA memory allocation fails.
The driver previously ignored the return value, so a failed deletion
would leave the IPFT entry untracked and impossible to clean up later.

Convert netc_port_remove_host_flood() from void to int and propagate the
error to all callers. In netc_port_add_host_flood_rule(), delete the old
entry before adding the new one, and guard against adding a new entry
when the old one still exists. In netc_port_set_host_flood() and
netc_port_bridge_join(), handle deletion failures and add rollback paths
to restore the host flood entry on error.

Note that the rollback itself may also fail, in which case there is
nothing more the driver can do. This is an acceptable limitation because
such failures only occur under resource exhaustion conditions that are
already abnormal, and the host flood feature is not critical to basic
packet forwarding.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c | 93 ++++++++++++++++++++++----------
 1 file changed, 64 insertions(+), 29 deletions(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index d326a00104e1..2171c83f3640 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -1707,15 +1707,23 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
 	u32 cfg;
 	int err;
 
-	if (!uc && !mc) {
-		/* Disable ingress port filter table lookup */
-		netc_port_wr(np, NETC_PIPFCR, 0);
-		np->uc = false;
-		np->mc = false;
+	if (np->ipft_hf_eid != NTMP_NULL_ENTRY_ID) {
+		/* The old rule is the same as the new rule, return directly.
+		 * But if the existing rule differs from the requested one,
+		 * return an error.
+		 */
+		if (np->uc == uc && np->mc == mc)
+			return 0;
 
-		return 0;
+		dev_err(priv->dev,
+			"The old host flood rule has not been removed from port %u\n",
+			np->dp->index);
+		return -EINVAL;
 	}
 
+	if (!uc && !mc)
+		return 0;
+
 	host_flood = kzalloc_obj(*host_flood);
 	if (!host_flood)
 		return -ENOMEM;
@@ -1762,32 +1770,33 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
 	return err;
 }
 
-static void netc_port_remove_host_flood(struct netc_port *np, u32 entry_id)
+static int netc_port_remove_host_flood(struct netc_port *np)
 {
 	struct netc_switch *priv = np->switch_priv;
-	bool disable_host_flood = false;
+	u32 entry_id = np->ipft_hf_eid;
+	int err;
 
 	if (entry_id == NTMP_NULL_ENTRY_ID)
-		return;
+		return 0;
 
-	if (np->ipft_hf_eid == entry_id)
-		disable_host_flood = true;
+	err = ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
+	if (err)
+		return err;
 
-	ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
+	np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
+	np->uc = false;
+	np->mc = false;
+	netc_port_wr(np, NETC_PIPFCR, 0);
 
-	if (disable_host_flood) {
-		np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
-		np->uc = false;
-		np->mc = false;
-		netc_port_wr(np, NETC_PIPFCR, 0);
-	}
+	return 0;
 }
 
 static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 				     bool uc, bool mc)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
-	u32 old_entry_id;
+	bool old_uc = np->uc;
+	bool old_mc = np->mc;
 
 	/* Do not add host flood rule to ingress port filter table when
 	 * the port has joined a bridge. Otherwise, the ingress frames
@@ -1795,7 +1804,12 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 	 * will be redirected directly to the CPU port.
 	 */
 	if (dsa_port_bridge_dev_get(np->dp)) {
-		netc_port_remove_host_flood(np, np->ipft_hf_eid);
+		if (!netc_port_remove_host_flood(np))
+			return;
+
+		dev_err(ds->dev,
+			"Failed to delete host flood rule on bridge port %u\n",
+			port);
 
 		return;
 	}
@@ -1804,19 +1818,29 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 		return;
 
 	/* IPFT does not support in-place updates to the KEYE element,
-	 * we need to add a new entry and then delete the old one. So
-	 * save the old entry ID first.
+	 * we need to delete the old one and then add the new rule. If
+	 * the deletion fails, return immediately.
 	 */
-	old_entry_id = np->ipft_hf_eid;
+	if (netc_port_remove_host_flood(np)) {
+		dev_err(ds->dev,
+			"Failed to delete old host flood rule on port %u\n",
+			port);
+
+		return;
+	}
 
 	if (netc_port_add_host_flood_rule(np, uc, mc)) {
 		dev_err(ds->dev, "Failed to add host flood rule on port %d\n",
 			port);
-		return;
-	}
 
-	/* Remove the old host flood entry */
-	netc_port_remove_host_flood(np, old_entry_id);
+		/* Try to restore the old flood rule, if the recovery fails,
+		 * there is nothing else we can do; this is a limitation.
+		 */
+		if (netc_port_add_host_flood_rule(np, old_uc, old_mc))
+			dev_err(ds->dev,
+				"Failed to restore host flood rule on port %d\n",
+				port);
+	}
 }
 
 static int netc_single_vlan_aware_bridge(struct dsa_switch *ds,
@@ -1981,6 +2005,8 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	struct netc_port *np = NETC_PORT(ds, port);
 	struct netc_switch *priv = ds->priv;
 	u16 vlan_unaware_pvid;
+	bool uc = np->uc;
+	bool mc = np->mc;
 	int err;
 
 	if (!bridge.num) {
@@ -1992,6 +2018,12 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	if (err)
 		return err;
 
+	err = netc_port_remove_host_flood(np);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to delete host flood rule");
+		return err;
+	}
+
 	netc_port_set_mlo(np, MLO_NOT_OVERRIDE);
 
 	if (br_vlan_enabled(bridge.dev))
@@ -2005,8 +2037,6 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	netc_port_set_pvid(np, vlan_unaware_pvid);
 
 out:
-	netc_port_remove_host_flood(np, np->ipft_hf_eid);
-
 	if (atomic_inc_return(&priv->br_cnt) == 1)
 		schedule_delayed_work(&priv->fdbt_ageing_work,
 				      READ_ONCE(priv->fdbt_ageing_delay));
@@ -2016,6 +2046,11 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 disable_mlo:
 	netc_port_set_mlo(np, MLO_DISABLE);
 
+	if (netc_port_add_host_flood_rule(np, uc, mc))
+		dev_err(ds->dev,
+			"Failed to restore host flood rule on port %u\n",
+			port);
+
 	return err;
 }
 
-- 
2.34.1



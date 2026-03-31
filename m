Return-Path: <linuxppc-dev+bounces-19068-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF091061B32
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 11:29:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flQqf0kKmz2ypY;
	Tue, 31 Mar 2026 22:29:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774956542;
	cv=pass; b=cJ4hmeRGCN57t0xmriIfGnI0o94lxIJHpqk47sCoEDJ9Zgn1z2VVP0LRKVJemOD8deQM3wyywcMfCrturBfjLT37fkcplfznYskCC2T0iiXFMnLlLEWuSKArHHJ+UcKMKjdzm3d1ssMqg97T18fYwl6yAZapQB7dc7Qxy0dBEuVfZXnlK6AB55CxV73rbE34tjNUk4ZZTm6/akneL/ngAJmngwsnVL7Jky2cXnP1Pw4vrav8Hwkf6rvxJZDZ+txY06o0Auh9MXGbdbVb2aePpzdbKy3dThy3/WFiqL+m/RUHeE63GU/4GBvG09nbXMLMWN8KkK3xi8IzWCVWmUMZoQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774956542; c=relaxed/relaxed;
	bh=tziJeOEw/BS+e7YU+4V7x/VXYezCf1g2NlxkGwA58ng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N6REgd4P2THoewgmNpo8FwSnjqvIE7EXuVxOr9Pg/d5X/3dBogjsnnXffCYk0QkRLS6fM3j7oOIQf9dsgwUcIJr07MCzWe4aqdmTX8fw3VP8dOn2hFT/uumDKFU95f8Vmk6syrdKRvTDJPZgsAuV8y11WYlkNSBUlUhaJgvtgKtCR5hX244DqtoNaXLi91Ugx/MC4+egCSKDwnbitH4ExJEfAsoox3P6DnHl8OQTbx19MHWRQaWg4VrwTzwvGlAFNVn1szUA0P6R/PbNwQcKnJg4BeXruSt1H77yCH+6KPvODGmOVmTod24DXCh8Ws7E0aR4cMyKeb1otT1x1fQw7g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=OVH02gLz; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=OVH02gLz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flQqc6RVCz2ynH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 22:29:00 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igtjQjjq5KtBHWH23nvChnXmKKNq2s8qj45gGryelrCyEtmHXDgd3FGq9KlC/DVABF38FQSFRj76zgNhxaAjiVc3rUtFpHQ0EB+pklMiyZtWuSioHOQEZNDA1IobUE4yezydmwmfhMTy/EGSg/m1YD8ARnybE1CTOPrkDre9zJtf+/O5/5SFViPOp4WMxq4z/1qbpld7GayIjrLMrPPN9spkoqX+G+xGtYZZgGRtqsi6nMSOW8Yq88JLFBpakUccd15PAcfm+HVJxlzrvaxvEzK4A+pUs44E3rpcHtaHqsTcYKtusqg5znZbs7Bcr61mkv6rCgwOawpEfLnDjAr9rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tziJeOEw/BS+e7YU+4V7x/VXYezCf1g2NlxkGwA58ng=;
 b=quQ6utFdeKMJdV244JrEJ+QIV3EvxbxU3cw+MS/J1z55yp+oBiyQn/dWaSeciVRKQ8AgxTlQLOInPOthJmIYGpDWXNn5eUQNFPc6ig8Kh1AUs1yPSrC1sXhBwgQ9yeZbaFg0aOBXll6vjytPUmwqIExZqS8PjymYaaUDbaPKe6FPyiv/IcCYJyJG2Kwoq+OgMh3j/hbuTveIXcY0gQxbulbYGcKvAHu+5KH7VKYK3EIIGTWwE2a0J8oqYo2nO+osYv9pAmwbk6P5Eicm3GC/PlmWZd0ZJlsbamLtZULbokA1a2+lr6x04zUjTUwC0PDnZ+QD1dK3QrY6wzXuwVhLtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tziJeOEw/BS+e7YU+4V7x/VXYezCf1g2NlxkGwA58ng=;
 b=OVH02gLz1xX/VRqqWoHb3qk1Vas2qnncuuG8Lo+99oX8YYxb+A4p4ARx5+DCpGWAxPCoEj3vs4ndczujcwuJFGAF0KMSEX7i/vfiIcFb/3UE0T7C6xKzVjFF1QW/NrLXbLSmFVr6WKHy/rgeV50FwOHrXETgrBmg0Uf4/zwRaTa1Xw+7jSkKiOiNQ+kV8YCgcXr/sTsapdkLfcbJy38HG1yRoKo+ZnoigbeGT5r6gP5IRAPpjddjJvo/ffKz5cmTUefQTqfM33z6+DX6A36z7KplhurxPtCuprqK1nKWoADJb7yQMJb8Ly8qVlU5Uem/9FBEWt8GKPjzoX5gx/6qGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by PA1PR04MB11406.eurprd04.prod.outlook.com (2603:10a6:102:4f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 11:28:52 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 11:28:52 +0000
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
Subject: [PATCH v4 net-next 03/14] net: enetc: add pre-boot initialization for i.MX94 switch
Date: Tue, 31 Mar 2026 19:30:14 +0800
Message-Id: <20260331113025.1566878-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331113025.1566878-1-wei.fang@nxp.com>
References: <20260331113025.1566878-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0151.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::14) To AM8PR04MB7284.eurprd04.prod.outlook.com
 (2603:10a6:20b:1dc::8)
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7284:EE_|PA1PR04MB11406:EE_
X-MS-Office365-Filtering-Correlation-Id: a72505c6-10e0-4c17-1c34-08de8f18af62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|366016|7416014|1800799024|18002099003|56012099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	aSKs0LFoo2SE6IFibvkF4TIvUlGB4BxFnsm85kaI6VrcRlHpy7rdQHpGOvy352T56tJuhOUw7+dDuQ/h517rWvzO/nOFj8C86OH+MGhYn9H8NLjdMxBWQNmsTKzWmAA89qCisaoMzzXRV5wnhXz3dhmTdyh9VC8Z8FHgo5slYtDCDjeBTh27h4bcrrJ7v219wM0fsMFPEGdEeOaJw2VK9dC+6uAklv94n8P22iWXO3M0XWljZTFGiaYHzziTirulsyjsKKDtKYMKxRCzCSXvg1taxeVGx2MDLbqCjW8vXxnxLe7lh6Fminh9iABVeNwds4tJoEEUuo3YefXYfEujInCAf5ptd/nGQaxe8GphnN+4a1OULVdJuF8B7WxTfHeVxByax2XsX81GFUulfsDPV47eUyyZbE6utQ/BqfKOVRMbIKsWbRzNfUTX6rnpY+xXu3SNBc9B3w302y6m+jUfiXgKUhotKypj74Hc1hYFHT2t0nXUm0AoOs895u862vgDweRRYPZjv9oNnUtVnJwD83lYvh8qQUluSWmgYyOZmh3IRVszmxvmOGJAGVhyWGH2MBZkIHsnFYsFjRWBqGDsbUA0yDcqSUzaqdxQ9SAGdO7X2pMFrXzLER5IPQF7W420cz73pehmcRULacjd+lcqSxBOMyH7UpN7TdjTliwJq6xVtozh0HUih+Y7bWaP75untSwD8Fv5FJACGNeZVIfpYMU6gzSudiArVY3i0f9P2LcSeqf282g2BykHWnPZnoDJj2McELMC2BqNOXv8t9B4WKXhxDjXVFCfP8a0tAwU3y4suIWV7KuXySDvbFeMVGkM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(366016)(7416014)(1800799024)(18002099003)(56012099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NxNS69CGIeWWAFaoHpCr4aiWwlWnzw78YsUPwIJYDkCgAUzOt3Tf+pHHRogF?=
 =?us-ascii?Q?TTnCxw4CndLULOAEp2SHmTcSNNppi0wOLdUqVJtHSW30VBxxvH+9lNKrv6hb?=
 =?us-ascii?Q?BKBwroXAxNCwTfmNDawUBgpXpZVOy6EXxf3QAk5qJ3jhZIjBhXkOJ1Q717hM?=
 =?us-ascii?Q?kpBaIhlhl9OK4UBjVLofWYFbFxieytyBnxLd4lnhvE+AyVZH0TR6pNM39ytv?=
 =?us-ascii?Q?ojCCk0IKOVTl/oqGoW7JKTRKcdcI9/K63ehQI1gUKWV32/VBxoiIBFrKtmGG?=
 =?us-ascii?Q?TeR7RgA+fRZxc/oiiTnwYlu9wKTi0O0FIECVxX0wItxmd8+Q7IhQLRysUugV?=
 =?us-ascii?Q?z096iaRO6+OGKsD/IIxxmZi50uCPwOCkg8T+Q8xWkhJuuBsk0L1z0KhQad3f?=
 =?us-ascii?Q?GapD3HGJgAypmPpy0nmDb64p/hpE2JcHHe1wzoV727eyzlfL59dUK0IACKKf?=
 =?us-ascii?Q?vemuIny8ij8Kvq22FklOopAPuUMjzP1+wo1vhL4+AT8VGBdmuY4mORZpxv/Y?=
 =?us-ascii?Q?gZBilsu+d0Lu48xiIkia+sf/uwAlSR6pLtU1zMwp+sAWqDHcZlv8NJ3gUA5z?=
 =?us-ascii?Q?FFy5wh6rF+F1kaZA4IrruuEpP0kAj1/5Kx7qP1mQ1v9JlOZCMPecQNX4lxQD?=
 =?us-ascii?Q?J9j9qSVtcCbRrWkTIyfkBihPeY3OXYFQkRkCnHW8bd5kdS1wrJbpn2GP8GlO?=
 =?us-ascii?Q?zHa/1ba92f/Lc9af7w/GCqhwHmNNnCIXq0CE79LSkxihbkkUssS0qn7+tYx8?=
 =?us-ascii?Q?IHObIcqhhO8CjBu8iKKOPuQc2bBRHtonwwGUOTjrJKPKCH2zz0a/LV+PwjSP?=
 =?us-ascii?Q?gId8zfZkPeb5Z1LWeYFh6odLAi4SWXnHI9YDbC/LiPIaWfH+CKCda7g/sON7?=
 =?us-ascii?Q?Sfg7TgZCuUfOFpVl0V0FeQj4bq7IeviAM7uguj5r1eNZPf56jjZV0gyHA9Eg?=
 =?us-ascii?Q?KdoD4UZ4oYxzDfQ72FD5yhGGYbjaA+RsmWSzeD9Oxzf3ouEuocF5/sw0wWr2?=
 =?us-ascii?Q?dWCKhb4G1O2x1p5AOe5ePzsGgs3Bo+qddabkHnPtqYYfLedNyfCEYk1F/nvV?=
 =?us-ascii?Q?eZa8E7ROHBsuzCLdGJypi1oymFriaGgAw4lWQIk1WAcgCRig9A7sVVvB9OZl?=
 =?us-ascii?Q?8VjY1KWo9QY5ZR2MHpWznOcWLKJnOgn7pSyZC/yN3/Ge/LAFRcfKkJ8Hrs7n?=
 =?us-ascii?Q?ihpV4O4Ur8lefqROuDAQQ60rPNIIQANqg7PPDoXCdfrLmAFSqvFXw0yEa4Sr?=
 =?us-ascii?Q?EDCL5mWDn3TmezQiGxxdHzwbJvSrDCQPU7lqrfvJy3fOi9J6xImEn4bj8L5W?=
 =?us-ascii?Q?CUidY2FJOPhG3dbWVpEaecn7NgDjGcZ46S6rL4hfzZ2Zp3sPqwzlxRz3qeSz?=
 =?us-ascii?Q?0YFQs1XH6rWPQQ4NGilSbo/w9sQN++cQoQuiuJtvPV6Bo5VayR+7woNHfuo2?=
 =?us-ascii?Q?GGllVQsTLdKUqccmQauTSc8CUvf+JxSk7cB5wScy1CtN8XV1wUY+z4Kp5G1n?=
 =?us-ascii?Q?0E6sXqOJf+rrgTb+YaiJfgER9+mLv3lFF+TuuJyAprhPvZVvfu6NK3ID5cOi?=
 =?us-ascii?Q?0+IUk6WIyo/USPgwnBXSTpard1mfxiy0rew7e0ySXOzsj3ZGsWEAmRJ3e+ks?=
 =?us-ascii?Q?96Fc7i9xFf2Ys1iktDS0UlAQ8iEd9hRm3ewTLMeXegU65rfgcX9z9aMwxlcx?=
 =?us-ascii?Q?jJkMAsBFHRfaDtyrZYnB52teEchwJeFEL8VaYx8RPlXm+E0m?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72505c6-10e0-4c17-1c34-08de8f18af62
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 11:28:51.9497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SETRupl9bg4yfUY1+eqZdZeh9flADfUN+GxO6krcWiXhu+j480jBrI5xUOkg8PMeP1dRj0jjzbIVNjpuh21jQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11406

Before probing the NETC switch driver, some pre-initialization needs to
be set in NETCMIX and IERB to ensure that the switch can work properly.
For example, i.MX94 NETC switch has three external ports and each port
is bound to a link. And each link needs to be configured so that it can
work properly, such as I/O variant and MII protocol.

In addition, the switch port 2 (MAC 2) and ENETC 0 (MAC 3) share the same
parallel interface, they cannot be used at the same time due to the SoC
constraint. And the MAC selection is controlled by the mac2_mac3_sel bit
of EXT_PIN_CONTROL register. Currently, the interface is set for ENETC 0
by default unless the switch port 2 is enabled in the DT node.

Like ENETC, each external port of the NETC switch can manage its external
PHY through its port MDIO registers. And the port can only access its own
external PHY by setting the PHY address to the LaBCR[MDIO_PHYAD_PRTAD].
If the accessed PHY address is not equal to LaBCR[MDIO_PHYAD_PRTAD], then
the MDIO access initiated by port MDIO will be invalid.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 188 ++++++++++++++++--
 1 file changed, 166 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
index 92a0f824dae7..c21230f7a7fb 100644
--- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -261,40 +261,112 @@ static int imx94_link_config(struct netc_blk_ctrl *priv,
 }
 
 static int imx94_enetc_link_config(struct netc_blk_ctrl *priv,
-				   struct device_node *np)
+				   struct device_node *np,
+				   bool *enetc0_en)
 {
 	int link_id = imx94_enetc_get_link_id(np);
 
 	if (link_id < 0)
 		return link_id;
 
+	if (link_id == IMX94_ENETC0_LINK && of_device_is_available(np))
+		*enetc0_en = true;
+
 	return imx94_link_config(priv, np, link_id);
 }
 
+static struct device_node *netc_get_switch_ports(struct device_node *np)
+{
+	struct device_node *ports;
+
+	ports = of_get_child_by_name(np, "ports");
+	if (!ports)
+		ports = of_get_child_by_name(np, "ethernet-ports");
+
+	return ports;
+}
+
+static int imx94_switch_link_config(struct netc_blk_ctrl *priv,
+				    struct device_node *np,
+				    bool *swp2_en)
+{
+	struct device_node *ports;
+	int port_id, err = 0;
+
+	ports = netc_get_switch_ports(np);
+	if (!ports)
+		return -ENODEV;
+
+	for_each_available_child_of_node_scoped(ports, child) {
+		if (of_property_read_u32(child, "reg", &port_id) < 0) {
+			err = -ENODEV;
+			goto end;
+		}
+
+		switch (port_id) {
+		case 0 ... 2: /* External ports */
+			err = imx94_link_config(priv, child, port_id);
+			if (err)
+				goto end;
+
+			if (port_id == 2)
+				*swp2_en = true;
+
+			break;
+		case 3: /* CPU port */
+			break;
+		default:
+			err = -EINVAL;
+			goto end;
+		}
+	}
+
+end:
+	of_node_put(ports);
+
+	return err;
+}
+
 static int imx94_netcmix_init(struct platform_device *pdev)
 {
 	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
 	struct device_node *np = pdev->dev.of_node;
+	bool enetc0_en = false, swp2_en = false;
 	u32 val;
 	int err;
 
 	for_each_child_of_node_scoped(np, child) {
 		for_each_child_of_node_scoped(child, gchild) {
-			if (!of_device_is_compatible(gchild, "pci1131,e101"))
-				continue;
-
-			err = imx94_enetc_link_config(priv, gchild);
-			if (err)
-				return err;
+			if (of_device_is_compatible(gchild, "pci1131,e101")) {
+				err = imx94_enetc_link_config(priv, gchild,
+							      &enetc0_en);
+				if (err)
+					return err;
+			} else if (of_device_is_compatible(gchild,
+							   "pci1131,eef2")) {
+				err = imx94_switch_link_config(priv, gchild,
+							       &swp2_en);
+				if (err)
+					return err;
+			}
 		}
 	}
 
-	/* ENETC 0 and switch port 2 share the same parallel interface.
-	 * Currently, the switch is not supported, so this interface is
-	 * used by ENETC 0 by default.
+	if (enetc0_en && swp2_en) {
+		dev_err(&pdev->dev,
+			"Cannot enable swp2 and enetc0 at the same time\n");
+		return -EINVAL;
+	}
+
+	/* ENETC 0 and switch port 2 share the same parallel interface, they
+	 * cannot be enabled at the same time. The interface is set for the
+	 * ENETC 0 by default unless the switch port 2 is enabled in the DTS.
 	 */
 	val = netc_reg_read(priv->netcmix, IMX94_EXT_PIN_CONTROL);
-	val |= MAC2_MAC3_SEL;
+	if (!swp2_en)
+		val |= MAC2_MAC3_SEL;
+	else
+		val &= ~MAC2_MAC3_SEL;
 	netc_reg_write(priv->netcmix, IMX94_EXT_PIN_CONTROL, val);
 
 	return 0;
@@ -610,6 +682,77 @@ static int imx94_enetc_mdio_phyaddr_config(struct netc_blk_ctrl *priv,
 	return 0;
 }
 
+static int imx94_ierb_enetc_init(struct netc_blk_ctrl *priv,
+				 struct device_node *np,
+				 u32 phy_mask)
+{
+	int err;
+
+	err = imx94_enetc_update_tid(priv, np);
+	if (err)
+		return err;
+
+	return imx94_enetc_mdio_phyaddr_config(priv, np, phy_mask);
+}
+
+static int imx94_switch_mdio_phyaddr_config(struct netc_blk_ctrl *priv,
+					    struct device_node *np,
+					    int port_id, u32 phy_mask)
+{
+	int addr;
+
+	/* The switch has 3 external ports at most */
+	if (port_id > 2)
+		return 0;
+
+	addr = netc_get_phy_addr(np);
+	if (addr < 0) {
+		if (addr == -ENODEV)
+			return 0;
+
+		return addr;
+	}
+
+	if (phy_mask & BIT(addr)) {
+		dev_err(&priv->pdev->dev,
+			"Found same PHY address in EMDIO and switch node\n");
+		return -EINVAL;
+	}
+
+	netc_reg_write(priv->ierb, IERB_LBCR(port_id),
+		       LBCR_MDIO_PHYAD_PRTAD(addr));
+
+	return 0;
+}
+
+static int imx94_ierb_switch_init(struct netc_blk_ctrl *priv,
+				  struct device_node *np,
+				  u32 phy_mask)
+{
+	struct device_node *ports;
+	int port_id, err = 0;
+
+	ports = netc_get_switch_ports(np);
+	if (!ports)
+		return -ENODEV;
+
+	for_each_available_child_of_node_scoped(ports, child) {
+		err = of_property_read_u32(child, "reg", &port_id);
+		if (err)
+			goto end;
+
+		err = imx94_switch_mdio_phyaddr_config(priv, child,
+						       port_id, phy_mask);
+		if (err)
+			goto end;
+	}
+
+end:
+	of_node_put(ports);
+
+	return err;
+}
+
 static int imx94_ierb_init(struct platform_device *pdev)
 {
 	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
@@ -625,17 +768,18 @@ static int imx94_ierb_init(struct platform_device *pdev)
 
 	for_each_child_of_node_scoped(np, child) {
 		for_each_child_of_node_scoped(child, gchild) {
-			if (!of_device_is_compatible(gchild, "pci1131,e101"))
-				continue;
-
-			err = imx94_enetc_update_tid(priv, gchild);
-			if (err)
-				return err;
-
-			err = imx94_enetc_mdio_phyaddr_config(priv, gchild,
-							      phy_mask);
-			if (err)
-				return err;
+			if (of_device_is_compatible(gchild, "pci1131,e101")) {
+				err = imx94_ierb_enetc_init(priv, gchild,
+							    phy_mask);
+				if (err)
+					return err;
+			} else if (of_device_is_compatible(gchild,
+							   "pci1131,eef2")) {
+				err = imx94_ierb_switch_init(priv, gchild,
+							     phy_mask);
+				if (err)
+					return err;
+			}
 		}
 	}
 
-- 
2.34.1



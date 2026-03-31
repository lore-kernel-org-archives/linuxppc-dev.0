Return-Path: <linuxppc-dev+bounces-19076-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88F71061B32
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 11:30:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flQs10Z74z2yft;
	Tue, 31 Mar 2026 22:30:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774956612;
	cv=pass; b=BIrZkVHYm670M1MeZdahRQoSPJodKFJZAOMd8F9Z/HdLO/LKtaS8uqt+7iU2R4PkxSr64QPrwfQGsFrnzg5OgY08NDpCPwjCeVOLvW5SwqdYJV+IVwaqdqo7NXj3o4BeQs7xmPMYoLyIC/rJkWAHbrvmiTLSwHY2LZ+OOfXuRz3l01Qno3mo5il5vchSAbm4kOP9biX8lyaUfRSjWuW/1QCi0PHPCK5jF6baQolqtE66nGIjSJSlwsIfQNYrXBRQMAwWTqBxL+FczBN31Gt6pcVT1oJ2mxBlszLeg892i38swMJpFutO0fyKMMsmIatUzDoagEO27Z0EH+ApN8h9bA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774956612; c=relaxed/relaxed;
	bh=HkMF1aoHeOeVrDs0DDXBJ6pqtj3IjxmrFndsEhCO494=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R48cjZWGcB5Mwg70Rxq93u6ynel79jkkFEQVSwlMr/Mw7OF9XwcGFuvwxOTS48oUQfBCkyDFBOsuiKuGMZULh2MsRgQVPBfs8iT7IW7dUrkr1mdTKaUZdm+7KysmTMNHF4UrKqcIc9z40CiO1f9xMD7yZAanMeK/RXMH4gY94T/gTfV086JvWsByBF7fRd1sm4Cfx/9DMOwnjDGOoUFs1Kq8hVbvqunBmQXpRB8R+RdYph114PKS4d4s9hxQt+X9tTYJjpUHzz+GZT6q/yfBVNRU51ZKVTmsm72VbZmZi3g7BigF0N/dx0Ey7RXi8aobyHa8msEzePef5/SdtaYWmA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=HRckaSu7; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=HRckaSu7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flQrz0W45z2yhZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 22:30:11 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZvadaCcdUAL/8TyH+jRxB7KS5n/WAyVESkpkLzkScCew7pSccJWcFx8og9lrXuN0cknylM0o7YUixO1LEw3GeX5E0dQdyFmgU6sCVU87pBRXqaXA91kfnXkd0rlgF+Oc4ql9ohLoVVEN0qvRm/Pm0yH8Ph6UqNlxh03OurN3m2wtmOUJGk3ydEaC3efDci6gtsaF62PCJr+eRCel4tqot0HQurjiob1QUo3RuOUe+Rm9rmnTnKVwrjtRFnej/e+/vWa5E7HuysQNOjh/S9fzvmKkN7jyZ/vALYFQUrjNecfy/Gile9YjwGzd8MYRzAHpDfBq6DaJhe981ZCtgZfynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkMF1aoHeOeVrDs0DDXBJ6pqtj3IjxmrFndsEhCO494=;
 b=HPO4qRUoUIJxmCzzE37tZESaE5EaSHHMrm+EFoBeNxcUHLHnBhUL4i7CyER+dN2QOEQ77xbgmD+UCFque7xA4VJCaR47RUdQKkxRVURMUDkrRTo8QFGhIU690UP/3Z2BisP3fgIgjHdXeZVQJk/WAaCDH0ZZkj+gxHhEbkhhfF18iZro1hnrnsjyGb9Dk1VZ+9N6Lor3bFmdOkGsex7gu3RLKv1CWmAfRO9CCZR0DC6Ici0AcsS5IxOsQVFJjVqvBlmeixzIWCynxtxEWgx4WpWcVfqqUj9Y71DvlUw4kPEHi0axhV9j/2ndxPY4Ta3SbCsfZWldtG0AZEA5P8m+xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkMF1aoHeOeVrDs0DDXBJ6pqtj3IjxmrFndsEhCO494=;
 b=HRckaSu7i53Hvoo3oWLDhuSUOpBMXOcFQAvtmZo2FkBXQeEI3+2l59SY8qxChU1l+o9CBBUWKg6UVJkkhw37YMTmvAvL2Dkrt7e9P/kRUPkDPmwLF91KmW8F9EIHj7KMNJT/5H5vR7I7WzfaGC1qL4PoEmbk8zexlmXb9klN6JWWmlPVEn/VpfwUa2NN806c+6QVitFGSeKSy8/He130DPjFMZ2HonZ5VMW+6FS1GRXsqLC06WH8xnJTShTOSGvPfEQ+epYsgHl8MGzBh8zzuBF7AbPCF4rKvOEGogO0lmL7ChsFhcroOtxnZEPAeCM1RN67aGQ6l8wXvwXhK3Rhsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by PA1PR04MB11406.eurprd04.prod.outlook.com (2603:10a6:102:4f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 11:29:50 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 11:29:50 +0000
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
Subject: [PATCH v4 net-next 11/14] net: dsa: netc: add phylink MAC operations
Date: Tue, 31 Mar 2026 19:30:22 +0800
Message-Id: <20260331113025.1566878-12-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 664baac4-f29d-4bcc-58d7-08de8f18d219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|366016|7416014|1800799024|18002099003|56012099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	Vb4PCUII1bL7zk2V6mZmC9Z5QjJIgMmUruO986FFrAQo03XPZ8E3qIasJcxuBis8dQo6FsZ99yXDKTLtw8EXWMIIIwJUnzeu4HUCd5+CvqY27ducvvkWGrhmFP1QoXS6rFzXFI732mS47JSYspZGGTXk3TS8w6oCWj6WWebjxpV4K3GTx3tWSoAnDd13bMNVkGV7SZYucsD/14BXHyciwevVNKU+p2jz/kjHjnNyXtoyJL4Xhzt9hU/nYJugZdAD9Pi+nWd4n5S3dJY2LHhwLextaMDkLIAB46twB443tx5Pyf+J/8lSItMPtzIGATM//vjr+1YgiF5tYOqFQyEnU8kDAZC4aHxnP/Wy6UMyxSXct5iX8Fh5oAn0DY6a65MSGsI5P0WAAYUcb+u9fznjncNVNDO9yI89qJeKnUDNpndSz0POivDwcX6SLOn7SWsk/m1Y8Jrx3MC8hR+PuuCCQyT9uDVFbzLyKmSWOBcmRbZ9Ab3DjRNjivr4IFBHTfzMKRbCToVnrVQ9fIrVxhTO2gnDfFdDS8UZzjR34yyuaPKVykz8SI971r59Hv5FcxnmNeGQLqKRKcFpgd4qFAZRedjiEL0fnLOIruGLOQ9C+KD7jzC/93IT9/lW+JoRjtum7NoSb68dbzFz5itRQ3AGC49ahx8vVIhOK9+Q+HU0Yqqd3J+ufvjZWUhainPTh3qNy0GzNHNbWa15un3WoZnDEFCu/8BJ1cPe/V7pIO1pk5c3Tedkp8rokPFiZeL0Lbt7G09d6U0v0qtOIz6eK4v12Cak3507jCszP6xK1hwek2S7z5+qWrSaO5/xxKOIXBkn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(366016)(7416014)(1800799024)(18002099003)(56012099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5OcTXfYKjRjstLsT76ZhXOKWYUrQl1NmNnD/tYsryRU7tSWGu921Gr9RJUaK?=
 =?us-ascii?Q?PUH4RJx0wA43O5KZRk6amNSfVlWjzW/+u2TpC9Z+ILUaO1hBvoyDSy/c7DNQ?=
 =?us-ascii?Q?BFYbTEmo1303M6wjoVtDsTw+uJBijNBseJwzPyUVEXFBrV4e0Wz3SuUqTrbu?=
 =?us-ascii?Q?gdifo7ho7YdI89heI7gE5h/013L9VeJAa+0KIdt8SLArpex50q6aKHtQwhSW?=
 =?us-ascii?Q?n2cqff9XFacYLhff/93e/v1PTYoYasyWgQc2CJuImlCf3hPi/1LlbwVNcUPW?=
 =?us-ascii?Q?0Ss3ulJnkQG8H4LCW9LJpEpdrreJLmEg3EL+3GZaobbnnhYDmAI0pEcNXXnX?=
 =?us-ascii?Q?t1Itc0CH19NSfhwtM+diJcSL3gClBJeHVACGYmHYzmHuoww5z2A+Vj+tvUmW?=
 =?us-ascii?Q?nJnlm4ft+gtNMwKtj70RoQXEVTNL3c+rDd/IkVAb1pKfCGZNb6kEs/1ZnOKE?=
 =?us-ascii?Q?NmlppmM8buVCGtrn3SWRjH9LdR7co2Hx1TjCMNxxsRqhikTPAl9fXzMV2GTW?=
 =?us-ascii?Q?8/XnIpj2bk4vzPBltLzJSCu8esFhe5bo57UPR0Dq+qlP5zQYuJYWWL+ThOXS?=
 =?us-ascii?Q?JYLLUXskfTEaxg6bvXaQwtmHHgHzdq2F28rtyThzsvDvTAA8TRugNWHTCQM2?=
 =?us-ascii?Q?CAYjJOkSF6MBYFDKHWKe4PrZouRITKhnfqC01MDJS+CX1L8Uq679d4Ld1Suz?=
 =?us-ascii?Q?JVAoA4H6qA7ToW/5eccWYU+Y7Oiq2grASNyC8wRm7MnzKQ8rXjqr4E0aLiIT?=
 =?us-ascii?Q?H1OVXD4xYPT6jn37c0VGYc9tNhIjTtFVKEtBI9BuBrE4XfI3LskU0tT1h9fk?=
 =?us-ascii?Q?OOwBOragAdJPXgslyYdgUdAWWPl/43YJ4CYuro/76tmCJ8O76NFPJeJyAIhl?=
 =?us-ascii?Q?zWtbBq3VXaVFYq6tia6exaQ45lrrQYJZlatyJANPuF3gPq38iqn6bbFqGwZC?=
 =?us-ascii?Q?EFeLGns2IN+U/wSIAlMXrwFiqz7KxsBqA1PgCuc9ZWNLxbB9fEe7p2RTRyx+?=
 =?us-ascii?Q?iz9pNPTlqoLhKtGEH113bb2rq0d807xmarViViCIiphAahLuvzsidzlicRDV?=
 =?us-ascii?Q?ZnvBsVx7UZ3Mdy2EHUMu3HVIiyNULFmxhosD6ZMGg/95VOqHn+9uK4tG+t5L?=
 =?us-ascii?Q?dAojSDuxFWTLahMbVYaHtICbbpRyj3Ce9Qj2Ex0Xr86VrRzAVIEQf6LXkdbM?=
 =?us-ascii?Q?jupaNQz4N20s8kMhQY6X5gT8w2LPGDPxeyU7tDvxEPd8MEyp2VaiVzsOFRKq?=
 =?us-ascii?Q?AVnHcGcB9SmbK8gx1IgAF/nAEmEok+4CzFQmtHYXABqaNIdaG4sCvLyGikEl?=
 =?us-ascii?Q?+ojC9zSco6EaikoFwy8OE3JF1vWjkP9te2TzbHCWlZE84bV3AwVrGBhbnrLE?=
 =?us-ascii?Q?SatHT7MKlBUdU+Ax7Xwj5KAlsfuaGUkxhAGERrEc3DAMwdqQn4glZ5YF2agz?=
 =?us-ascii?Q?bCQ4UxKM0c7OjyHOSUFqLto6Xwr2SFigTbYMY20HDAC20N2f0Rt0RhOCj93v?=
 =?us-ascii?Q?7ragqfgNEl5cRkUqmfOcJd536uv91DT3zWrUWBPSST3BwFYwJdC2rU0YEl39?=
 =?us-ascii?Q?P1pFKgRZuk1lt2NnI5vKQdNRQfdm/tKGYrPZOlASaCE9Q0mjj5Oe0ZCGE9lx?=
 =?us-ascii?Q?o6ZS0ivMIkp2fclG6cEJiXRMu6TG4uVxcQWGauTxIvxnOaP7p/nT6oUe4ZSw?=
 =?us-ascii?Q?7N3pduD7QkFyG9UD6/MLvAx2p+UX/syxOanCOdfFuQhXJCWJ3xXge/uxfdYV?=
 =?us-ascii?Q?L7F4nTgttg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 664baac4-f29d-4bcc-58d7-08de8f18d219
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 11:29:50.1018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWFDGOVpmVS+BYpVdQnNeNssSpv/seaGF+iAUEMDklYp3DA2e5g1Vjw74M+dDSCoc2I4sf6eeO4fAJ44D6PDbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11406

Different versions of NETC switches have different numbers of ports and
MAC capabilities, so add .phylink_get_caps() to struct netc_switch_info,
so that each version of the NETC switch can implement its own callback
to obtain MAC capabilities. In addition, related interfaces of struct
phylink_mac_ops are added, such as .mac_config(), .mac_link_up(), and
.mac_link_down().

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c      | 179 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_platform.c  |  41 ++++++
 drivers/net/dsa/netc/netc_switch.h    |   4 +
 drivers/net/dsa/netc/netc_switch_hw.h |  21 +++
 4 files changed, 245 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 5828fd3e342e..f11f5d0f6a6d 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -569,10 +569,188 @@ static void netc_switch_get_ip_revision(struct netc_switch *priv)
 	priv->revision = val & IPBRR0_IP_REV;
 }
 
+static void netc_phylink_get_caps(struct dsa_switch *ds, int port,
+				  struct phylink_config *config)
+{
+	struct netc_switch *priv = ds->priv;
+
+	priv->info->phylink_get_caps(port, config);
+}
+
+static void netc_port_set_mac_mode(struct netc_port *np,
+				   unsigned int mode,
+				   phy_interface_t phy_mode)
+{
+	u32 mask = PM_IF_MODE_IFMODE | PM_IF_MODE_REVMII;
+	u32 val = 0;
+
+	switch (phy_mode) {
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		val |= IFMODE_RGMII;
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		val |= IFMODE_RMII;
+		break;
+	case PHY_INTERFACE_MODE_REVMII:
+		val |= PM_IF_MODE_REVMII;
+		fallthrough;
+	case PHY_INTERFACE_MODE_MII:
+		val |= IFMODE_MII;
+		break;
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_2500BASEX:
+		val |= IFMODE_SGMII;
+		break;
+	default:
+		break;
+	}
+
+	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
+}
+
+static void netc_mac_config(struct phylink_config *config, unsigned int mode,
+			    const struct phylink_link_state *state)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+
+	netc_port_set_mac_mode(NETC_PORT(dp->ds, dp->index), mode,
+			       state->interface);
+}
+
+static void netc_port_set_speed(struct netc_port *np, int speed)
+{
+	netc_port_rmw(np, NETC_PCR, PCR_PSPEED, PSPEED_SET_VAL(speed));
+}
+
+static void netc_port_set_rgmii_mac(struct netc_port *np,
+				    int speed, int duplex)
+{
+	u32 mask, val;
+
+	mask = PM_IF_MODE_SSP | PM_IF_MODE_HD | PM_IF_MODE_M10;
+
+	switch (speed) {
+	default:
+	case SPEED_1000:
+		val = FIELD_PREP(PM_IF_MODE_SSP, SSP_1G);
+		break;
+	case SPEED_100:
+		val = FIELD_PREP(PM_IF_MODE_SSP, SSP_100M);
+		break;
+	case SPEED_10:
+		val = FIELD_PREP(PM_IF_MODE_SSP, SSP_10M);
+		break;
+	}
+
+	if (duplex != DUPLEX_FULL)
+		val |= PM_IF_MODE_HD;
+
+	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
+}
+
+static void netc_port_set_rmii_mii_mac(struct netc_port *np,
+				       int speed, int duplex)
+{
+	u32 mask, val = 0;
+
+	mask = PM_IF_MODE_SSP | PM_IF_MODE_HD | PM_IF_MODE_M10;
+
+	if (speed == SPEED_10)
+		val |= PM_IF_MODE_M10;
+
+	if (duplex != DUPLEX_FULL)
+		val |= PM_IF_MODE_HD;
+
+	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
+}
+
+static void netc_port_mac_rx_enable(struct netc_port *np)
+{
+	netc_port_rmw(np, NETC_POR, PCR_RXDIS, 0);
+	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_RX_EN,
+			  PM_CMD_CFG_RX_EN);
+}
+
+static void netc_port_wait_rx_empty(struct netc_port *np, int mac)
+{
+	u32 val;
+
+	if (read_poll_timeout(netc_port_rd, val, val & PM_IEVENT_RX_EMPTY,
+			      100, 10000, false, np, NETC_PM_IEVENT(mac)))
+		dev_warn(np->switch_priv->dev,
+			 "MAC %d of swp%d RX is not empty\n", mac,
+			 np->dp->index);
+}
+
+static void netc_port_mac_rx_graceful_stop(struct netc_port *np)
+{
+	u32 val;
+
+	if (is_netc_pseudo_port(np))
+		goto check_rx_busy;
+
+	if (np->caps.pmac) {
+		netc_port_rmw(np, NETC_PM_CMD_CFG(1), PM_CMD_CFG_RX_EN, 0);
+		netc_port_wait_rx_empty(np, 1);
+	}
+
+	netc_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_RX_EN, 0);
+	netc_port_wait_rx_empty(np, 0);
+
+check_rx_busy:
+	if (read_poll_timeout(netc_port_rd, val, !(val & PSR_RX_BUSY),
+			      100, 10000, false, np, NETC_PSR))
+		dev_warn(np->switch_priv->dev, "swp%d RX is busy\n",
+			 np->dp->index);
+
+	netc_port_rmw(np, NETC_POR, PCR_RXDIS, PCR_RXDIS);
+}
+
+static void netc_mac_link_up(struct phylink_config *config,
+			     struct phy_device *phy, unsigned int mode,
+			     phy_interface_t interface, int speed,
+			     int duplex, bool tx_pause, bool rx_pause)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct netc_port *np;
+
+	np = NETC_PORT(dp->ds, dp->index);
+	netc_port_set_speed(np, speed);
+
+	if (phy_interface_mode_is_rgmii(interface))
+		netc_port_set_rgmii_mac(np, speed, duplex);
+
+	if (interface == PHY_INTERFACE_MODE_RMII ||
+	    interface == PHY_INTERFACE_MODE_REVMII ||
+	    interface == PHY_INTERFACE_MODE_MII)
+		netc_port_set_rmii_mii_mac(np, speed, duplex);
+
+	netc_port_mac_rx_enable(np);
+}
+
+static void netc_mac_link_down(struct phylink_config *config,
+			       unsigned int mode,
+			       phy_interface_t interface)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+
+	netc_port_mac_rx_graceful_stop(NETC_PORT(dp->ds, dp->index));
+}
+
+static const struct phylink_mac_ops netc_phylink_mac_ops = {
+	.mac_config		= netc_mac_config,
+	.mac_link_up		= netc_mac_link_up,
+	.mac_link_down		= netc_mac_link_down,
+};
+
 static const struct dsa_switch_ops netc_switch_ops = {
 	.get_tag_protocol		= netc_get_tag_protocol,
 	.setup				= netc_setup,
 	.teardown			= netc_teardown,
+	.phylink_get_caps		= netc_phylink_get_caps,
 };
 
 static int netc_switch_probe(struct pci_dev *pdev,
@@ -613,6 +791,7 @@ static int netc_switch_probe(struct pci_dev *pdev,
 	ds->num_ports = priv->info->num_ports;
 	ds->num_tx_queues = NETC_TC_NUM;
 	ds->ops = &netc_switch_ops;
+	ds->phylink_mac_ops = &netc_phylink_mac_ops;
 	ds->priv = priv;
 
 	priv->ds = ds;
diff --git a/drivers/net/dsa/netc/netc_platform.c b/drivers/net/dsa/netc/netc_platform.c
index abd599ea9c8d..8271c27d1dfc 100644
--- a/drivers/net/dsa/netc/netc_platform.c
+++ b/drivers/net/dsa/netc/netc_platform.c
@@ -11,8 +11,49 @@ struct netc_switch_platform {
 	const struct netc_switch_info *info;
 };
 
+static void imx94_switch_phylink_get_caps(int port,
+					  struct phylink_config *config)
+{
+	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+				   MAC_1000FD;
+
+	switch (port) {
+	case 0 ... 1:
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  config->supported_interfaces);
+		config->mac_capabilities |= MAC_2500FD;
+		fallthrough;
+	case 2:
+		config->mac_capabilities |= MAC_10 | MAC_100;
+		__set_bit(PHY_INTERFACE_MODE_MII,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_RMII,
+			  config->supported_interfaces);
+		/* Port 0 and 1 do not support REVMII */
+		if (port == 2)
+			__set_bit(PHY_INTERFACE_MODE_REVMII,
+				  config->supported_interfaces);
+
+		phy_interface_set_rgmii(config->supported_interfaces);
+		break;
+	case 3: /* CPU port */
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+		config->mac_capabilities |= MAC_10FD | MAC_100FD |
+					    MAC_2500FD;
+		break;
+	default:
+		break;
+	}
+}
+
 static const struct netc_switch_info imx94_info = {
 	.num_ports = 4,
+	.phylink_get_caps = imx94_switch_phylink_get_caps,
 };
 
 static const struct netc_switch_platform netc_platforms[] = {
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index dac19bfba02b..eb65c36ecead 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -34,6 +34,7 @@ struct netc_switch;
 
 struct netc_switch_info {
 	u32 num_ports;
+	void (*phylink_get_caps)(int port, struct phylink_config *config);
 };
 
 struct netc_port_caps {
@@ -70,6 +71,9 @@ struct netc_switch {
 	struct ntmp_user ntmp;
 };
 
+#define NETC_PRIV(ds)			((struct netc_switch *)((ds)->priv))
+#define NETC_PORT(ds, port_id)		(NETC_PRIV(ds)->ports[(port_id)])
+
 /* Write/Read Switch base registers */
 #define netc_base_rd(r, o)		netc_read((r)->base + (o))
 #define netc_base_wr(r, o, v)		netc_write((r)->base + (o), v)
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index 11cb124ce4bf..881122004644 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -71,6 +71,10 @@
 #define  PCR_TXDIS			BIT(0)
 #define  PCR_RXDIS			BIT(1)
 
+#define NETC_PSR			0x104
+#define  PSR_TX_BUSY			BIT(0)
+#define  PSR_RX_BUSY			BIT(1)
+
 #define NETC_PTCTMSDUR(a)		(0x208 + (a) * 0x20)
 #define  PTCTMSDUR_MAXSDU		GENMASK(15, 0)
 #define  PTCTMSDUR_SDU_TYPE		GENMASK(17, 16)
@@ -127,6 +131,23 @@ enum netc_mfo {
 #define NETC_PM_MAXFRM(a)		(0x1014 + (a) * 0x400)
 #define  PM_MAXFRAM			GENMASK(15, 0)
 
+#define NETC_PM_IEVENT(a)		(0x1040 + (a) * 0x400)
+#define  PM_IEVENT_RX_EMPTY		BIT(6)
+
+#define NETC_PM_IF_MODE(a)		(0x1300 + (a) * 0x400)
+#define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
+#define   IFMODE_MII			1
+#define   IFMODE_RMII			3
+#define   IFMODE_RGMII			4
+#define   IFMODE_SGMII			5
+#define  PM_IF_MODE_REVMII		BIT(3)
+#define  PM_IF_MODE_M10			BIT(4)
+#define  PM_IF_MODE_HD			BIT(6)
+#define  PM_IF_MODE_SSP			GENMASK(14, 13)
+#define   SSP_100M			0
+#define   SSP_10M			1
+#define   SSP_1G			2
+
 #define NETC_PEMDIOCR			0x1c00
 #define NETC_EMDIO_BASE			NETC_PEMDIOCR
 
-- 
2.34.1



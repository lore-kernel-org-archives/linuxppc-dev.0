Return-Path: <linuxppc-dev+bounces-20314-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA496FF8875
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 02:49:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5dsc5TtCz2yjg;
	Thu, 30 Apr 2026 12:48:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777517332;
	cv=pass; b=aDh1wcJeV/15JzK5Nzxe3E4m3gcVVcT9Fl/zAjxOHM7675Gt90CNzauwxBFxbrF6YJb0pUiayxtHqsZkYqA+HCCAnEYt/01pJMU8xyQiJh2y5+F0bVsMGT4EIQ7H5U8dA8JwA0+67Y0HeWfFAFn9Nb4JHM8JJpkxnwqwLZ3zo+tS92n4FgWuCOF4pcIEmvvuaR6YnOu8YrnQyHOeKmCIcaE7taPtNoqQiWAmAkaHayAXeRhnWqKn+l0uB3AI7qjN4/arGIvofZkSDR/wEwEun052fW54kVIxWm3cSSD7Ypz2pCmDeqFOg6Tb8w7ySlULiiHYGGL2+OWsQsF7oWN1nw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777517332; c=relaxed/relaxed;
	bh=scrisMzMwHW3nalchf3MHRRsjin059kDS5eiWt60XHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cArYuIJ0Yv9k0RCLcZrTg2gS0SWX4i1OveIRjHMq1CWLVSZ1ItpevLTtnZYVFzTUMYOFlKcVhCy8cu4ByFpndKnfmE4Lkq/JA+jfxzerhTVJjrvb1pZCHawHZjrqYrXUiHD/DxBn9MLBGv51FUYKC2i8UUPlXvDSk6qPfcCpPiL7gfXhL5Vkj2Qgwr20wiIYapu2hmL3R+mF4XJRKF49uteb6IgOvSOuYr00hzW0Dr0qd+dBNl/ww9syuJFfQ7EjoAPyUvAN5JicsbDTkiReqX24d3q9EBAIv/O9FlHZgdZ+E/+foWDlDFap22mmrIUzgmFXyJ3gfkguJ8aiVCpMuw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=NHN1ME9Y; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=NHN1ME9Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5dsb4XNtz2ynT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 12:48:51 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqIvjZgthDCw23wFsHxnRLtS2zdSj33lMq5B9Q6ZvCbDYBGEqhmZNMWKWxrO3wQ97s+Ndti9iAxeKhTfQcEu9hL/iOkbF9f+6MplsUrAjEEi5gpeW5qsD2F1UeC5X0FwhhlneSvf4sDhonOW0wiQX5foWr1PhQhHwLeo9246PQzJwpoYLqWutYoGoV5ZBy56GWYwVuptAA0QCqidL/8cCXDzd5i1HTrDFutgUPYY0sIM5mv8lKOhVuTemKBkmwhmCS9O6ebg87725SufqYPJv6ZD1LdDQwNYRnFogkYzcM3ve6S+R5pMM5pt3kTyyQd6Z4JP5mHaQ1iij6YmDqRrUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scrisMzMwHW3nalchf3MHRRsjin059kDS5eiWt60XHc=;
 b=VLge3fMfc2oJL1DUpwOryR2jkQ+N2bFzhIEeKMRYNSJUxeQ5yrKplUNGyEE93CU/eOCgey+utJBwDAq3aB1tIp9ehim4qTyzK+/W3NUnpqvlunuTuPH7KYrcyakoBZcR1vzMZM7cYnvAGoAyk0VTVae9O0lhkyZCDSPgwMEFuygWhZqPmRWxg8sYyTJnW1yuijbkgu2XPvW7yXX5AnceiWuU59Y1Q1V/Pd8G2uhff8BvwRSIKVTeNFzQssnXkX/sxODnKYFpqK5sq1vIGOVe1Y1HsdIK4dW/w33BS0ZY8SeuU9BtLwMQjNDPQTZ6DupMkLh9tBj10bP/t4Fg4ReNAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scrisMzMwHW3nalchf3MHRRsjin059kDS5eiWt60XHc=;
 b=NHN1ME9YcLEj7HsK/Ki7iCw5yCLssDss9xLy9LUGbURFeQGaLH/3YLCSDsoPBooMTMs0fwDkqgbLwQRsAWW3obLuLx5gtQpWz2smWsFixHYYZySoVR8XJuiVT5Iqz956NcLD5exh+xHmTO5oxNnu0FHsFxtUEixBObMWYaFF3MCotzxa9Wx6b21s4ooBzHe5y1ACqdqBSAePF5PbyFWqaNT1bIyNhq2sZtnznffCdJjiA9c50QwjrlliBU18p4vXpBxjqmiXavRJRi2SUxC7kT58TT9pCUuKzFK5hJP/qgvvV3CaCOLMkm5hwLg/V3sJaUKqGLLwCyQ0aRKZef+Elg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PAXPR04MB8608.eurprd04.prod.outlook.com (2603:10a6:102:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 02:48:46 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 02:48:46 +0000
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
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v5 net-next 11/15] net: dsa: netc: add phylink MAC operations
Date: Thu, 30 Apr 2026 10:49:41 +0800
Message-Id: <20260430024945.3413973-12-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430024945.3413973-1-wei.fang@nxp.com>
References: <20260430024945.3413973-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PAXPR04MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ec37ba-32ad-42e6-29c5-08dea662ff9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3RiT6b05sZI8CZBTnIbos2oJSTE6SHJq+du95CBi3/tngwJW/CV+0Xdjc4G7s1Joc2w7fMm/jbfCEqWhB5HVNuLrf9Zbtokn/GmvSaHitVU/EHcv/7/QfpHnT4E44WvgPI0E09ZBLxmNkxyd7C4/F4snxdnf/6O5fAiqDTDJZCvIsvo4WalpmsyguPyzqCF0NBgPCvkIsGR1bDsAifIzua9ai7E/uMfV1SPFFKhUVFcKOzxdm0UxGrxxXwe08dnCrKHywrdlN7wcs6FnO1pjy3C1CpAhPpB0ATkkNof0EZS0VG4VdT9pNFpB7GRYWrlVuOzv0a92dnrvCpIYrkaf0VN5jvTYHfkTiSoXPcszjqBgo6TyLsTSEGv/o4LhvwdQVG3JyMV9Alw3qUro9u6bKmsO30N8tlhDoxJouY48P8zVUgqvlOEdQEX0lxcGRL2p68h/1ALdta3XpnF1lRHqxNbfAxq5ECtg1IBt1gbBhVTv04icaIMwMd+xZfjf4BQGMYXNu8vOV9+kY78fhN6iAXLHUfuUc0y19zkqckCawkjyFJNsyf8Wqe24xudsdsjyzlaqPVjwZhhPhPPYZnZ0a4K+6xN+xRnss/Cgm5MmfHTf4IoAgLRIMipZouDUEwCqONpheSpzkdbTgdJYzwo5fTv3YkLy45F75gDygbnkUyGNqUwMetnu2wDrDWpQl3r5yxfGEm7txJoNGp2p987l3Vj0pqX3RTRtf0+75Oj857BS9t/G8i7jvw0KpiM38mdZMzllx6QdibyND5SRaQXYcujFVzBQL8yBp2o6QbFtwRDcxHLfyflb3CVl7EyZwddV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y0Z1wiwZgV9dH4H8Ow3xqHsJNcGiKlo3ij/L9FleS+0tb5WK1iDuOhs6qN/L?=
 =?us-ascii?Q?c0e9gsebaMGWQ+tWzjkTcQEpUBBRaqTDwu7swftKTPBmbXig8d6W1sa0nScw?=
 =?us-ascii?Q?3r22mgnMpHlcP9MmP2mb+viQxab7GM0JnXC2WQx/wb/gbGtEYZxE4FdtrfX+?=
 =?us-ascii?Q?AeRpWrqCGJczkJATkfMADag12/EfBt7qZzgqXrMIuH0NjVgM9FSgTBu2t4I+?=
 =?us-ascii?Q?dFFPbBL/d6hWFXUe6HIqq49DpcnGbZRjuNO0OlQj5WXf4uVuGBhN3cpveAQB?=
 =?us-ascii?Q?B4F+CGGWWMIf+LgBaZYZzxYE0WvAB87fY5Z/vnmqylpcl0Q684KezlDFhbbB?=
 =?us-ascii?Q?pR0v1uV1rrxhtV9TRTke+aj0CnVObGZHnPfXQDsB6N7BONZbbYEuuI2Zi6Z5?=
 =?us-ascii?Q?jtDWilI163NIK+7lQBH58EoTIb02WqDXTjqdZLY2q7qSWHmKVfqqPAql7NBe?=
 =?us-ascii?Q?gTZOCbf7e+YIO6zv8FHMLEWWgNuF0IBPdvrqWSiVpciFlVO9n3WVwNVpoc9M?=
 =?us-ascii?Q?hUDqM0NOIsvpCkFH/jjItfvOAn25l+h8biJ7pxUSM4SxgdZGvrF3Z2xYTLYT?=
 =?us-ascii?Q?QrYsfH//7AYvJKiBvKy1WgyZNor2NEeUWxb47ORYjHlRA0ygvoPz5/v4tJUX?=
 =?us-ascii?Q?btH49W5X0QhoIb6CZd1HhxFVaZj7cKEPOKoU3W5Uf3hf90V332BhH+AGC6HX?=
 =?us-ascii?Q?ykBvvk3aEiE6H2buFLDKbD79jdejaBonsYyafimMAsDJW9UTQNSSGgdrSyxC?=
 =?us-ascii?Q?WFLEgDhOtxAKgada1Dgsm37+erj+LKpb7iiDuOGGZQ7oMmmez3TxdBpialgK?=
 =?us-ascii?Q?dV+VnClqtoM7wKrcsAUX1/sVs9Ic8mEkUtDpkdY8xwT8EJrePYKuJJt45n27?=
 =?us-ascii?Q?j52lwKlF2GJVz18jGFgajuYfiO8DHqQLB2xfSFVxh5WMJNRHlxP6Z8lXcYqW?=
 =?us-ascii?Q?F8c7hI2t0m1HkjKBen7ukcKPgQI3be8rhXip879V0Fmk+jKrOaLZnAEg48Rh?=
 =?us-ascii?Q?IAEy0O/ODAjUrZfG/xPz+AQ8OxdVOLXAUMaz9o50U6fY4UwV232ltXEHLNT/?=
 =?us-ascii?Q?C1ObKK3nsySMu+C7UCvDrKdLoHhzRBZGbQMkTp6kZhBijCRvZIBrJUCWKLo4?=
 =?us-ascii?Q?ngVsARYTKhIhWmkm1lxOrw+3vFiF25WvNqC8kI0f3B8AeXAO5anPrb5BYOfY?=
 =?us-ascii?Q?9qPYmRchQPA117RGv69zNJHdJ8g3dKG0ZLuZWD6lf0h0fCFWhZeoYnq2ObKU?=
 =?us-ascii?Q?WCFHbcR4oIxVJ+hgvDQMfjQVgcZQFGt04mid0X1VUoKZ4B58BETelGMI8Xci?=
 =?us-ascii?Q?8mUl00ycgfcg4bPBB8xuTWU4oTMwseZctOmuZ3SPVIO7U+ejeEE3fSaS1ue+?=
 =?us-ascii?Q?1s0GXlZejg3Bj+f3Zh3UA+a+nlqoUFK7GYoUriqadQO+X9Qwp89FOM74mg3n?=
 =?us-ascii?Q?v4Dk43nkhiIGEwa7EYXcs2IoqTfeAuY5un9DMJEC3KNWZ05NaPRqnu8wvDiv?=
 =?us-ascii?Q?lvIc6RRsjyzDqbkePaP+bOjZVzpGKeBS1vBuRgkJWXhI5i3/zFrMAoA9SY68?=
 =?us-ascii?Q?NeoOIBNQ/Xa/jendSI22qlg4/H306q1M9XiWdbHcj1wpvQsWUZ/JeVirMPNV?=
 =?us-ascii?Q?LECFjRzcDoZxC5XLzYA+9qfHPQF/hodYq9uf5rVb+8qO7cVFkvr3B+JvaCbM?=
 =?us-ascii?Q?lLZun0dIkYT9GpavPUb7KVZUdrZ3ED5bw9v2e14DTErysfgx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ec37ba-32ad-42e6-29c5-08dea662ff9a
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 02:48:46.1677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJ+6PeGn5a12HLGxSMsbNk6Jdw6AdFQBj9b6+xyljda0+i0VZRcCemUd0cbE15DJ53ttOX4hw9MJQq3+EDLpIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8608

Different versions of NETC switches have different numbers of ports and
MAC capabilities. Add .phylink_get_caps() to struct netc_switch_info,
allowing each NETC switch version to implement its own callback for
obtaining MAC capabilities.

Implement the phylink_mac_ops callbacks: .mac_config(), .mac_link_up(),
and .mac_link_down(). Note that flow-control configuration is not yet
supported in .mac_link_up(), but will be implemented in a subsequent
patch.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c      | 243 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_platform.c  |  38 ++++
 drivers/net/dsa/netc/netc_switch.h    |   4 +
 drivers/net/dsa/netc/netc_switch_hw.h |  26 +++
 4 files changed, 311 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 90a2d8cfd3d2..edf50cb32cb6 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -44,6 +44,26 @@ static void netc_mac_port_wr(struct netc_port *np, u32 reg, u32 val)
 		netc_port_wr(np, reg + NETC_PMAC_OFFSET, val);
 }
 
+static void netc_mac_port_rmw(struct netc_port *np, u32 reg,
+			      u32 mask, u32 val)
+{
+	u32 old, new;
+
+	if (is_netc_pseudo_port(np))
+		return;
+
+	WARN_ON((mask | val) != mask);
+
+	old = netc_port_rd(np, reg);
+	new = (old & ~mask) | val;
+	if (new == old)
+		return;
+
+	netc_port_wr(np, reg, new);
+	if (np->caps.pmac)
+		netc_port_wr(np, reg + NETC_PMAC_OFFSET, new);
+}
+
 static void netc_port_get_capability(struct netc_port *np)
 {
 	u32 val;
@@ -522,10 +542,232 @@ static void netc_switch_get_ip_revision(struct netc_switch *priv)
 	priv->revision = FIELD_GET(IPBRR0_IP_REV, val);
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
+	netc_port_rmw(np, NETC_POR, POR_RXDIS, 0);
+	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_RX_EN,
+			  PM_CMD_CFG_RX_EN);
+}
+
+static void netc_port_wait_rx_empty(struct netc_port *np, int mac)
+{
+	u32 val;
+
+	/* PM_IEVENT_RX_EMPTY is a read-only bit, it is automatically set by
+	 * hardware if RX FIFO is empty and no RX packet receive in process.
+	 * And it is automatically cleared if RX FIFO is not empty or RX
+	 * packet receive in process.
+	 */
+	if (read_poll_timeout(netc_port_rd, val, val & PM_IEVENT_RX_EMPTY,
+			      100, 10000, false, np, NETC_PM_IEVENT(mac)))
+		dev_warn(np->switch_priv->dev,
+			 "swp%d MAC%d: RX is not idle\n", np->dp->index, mac);
+}
+
+static void netc_port_mac_rx_graceful_stop(struct netc_port *np)
+{
+	u32 val;
+
+	if (is_netc_pseudo_port(np))
+		goto rx_disable;
+
+	if (np->caps.pmac) {
+		netc_port_rmw(np, NETC_PM_CMD_CFG(1), PM_CMD_CFG_RX_EN, 0);
+		netc_port_wait_rx_empty(np, 1);
+	}
+
+	netc_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_RX_EN, 0);
+	netc_port_wait_rx_empty(np, 0);
+
+	if (read_poll_timeout(netc_port_rd, val, !(val & PSR_RX_BUSY),
+			      100, 10000, false, np, NETC_PSR))
+		dev_warn(np->switch_priv->dev, "swp%d RX is busy\n",
+			 np->dp->index);
+
+rx_disable:
+	netc_port_rmw(np, NETC_POR, POR_RXDIS, POR_RXDIS);
+}
+
+static void netc_port_mac_tx_enable(struct netc_port *np)
+{
+	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_TX_EN,
+			  PM_CMD_CFG_TX_EN);
+	netc_port_rmw(np, NETC_POR, POR_TXDIS, 0);
+}
+
+static void netc_port_wait_tx_empty(struct netc_port *np, int mac)
+{
+	u32 val;
+
+	/* PM_IEVENT_TX_EMPTY is a read-only bit, it is automatically set by
+	 * hardware if TX FIFO is empty. And it is automatically cleared if
+	 * TX FIFO is not empty.
+	 */
+	if (read_poll_timeout(netc_port_rd, val, val & PM_IEVENT_TX_EMPTY,
+			      100, 10000, false, np, NETC_PM_IEVENT(mac)))
+		dev_warn(np->switch_priv->dev,
+			 "swp%d MAC%d: TX FIFO is not empty\n",
+			 np->dp->index, mac);
+}
+
+static void netc_port_mac_tx_graceful_stop(struct netc_port *np)
+{
+	netc_port_rmw(np, NETC_POR, POR_TXDIS, POR_TXDIS);
+
+	if (is_netc_pseudo_port(np))
+		return;
+
+	netc_port_wait_tx_empty(np, 0);
+	if (np->caps.pmac)
+		netc_port_wait_tx_empty(np, 1);
+
+	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_TX_EN, 0);
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
+	netc_port_mac_tx_enable(np);
+	netc_port_mac_rx_enable(np);
+}
+
+static void netc_mac_link_down(struct phylink_config *config,
+			       unsigned int mode,
+			       phy_interface_t interface)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct netc_port *np;
+
+	np = NETC_PORT(dp->ds, dp->index);
+	netc_port_mac_rx_graceful_stop(np);
+	netc_port_mac_tx_graceful_stop(np);
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
@@ -564,6 +806,7 @@ static int netc_switch_probe(struct pci_dev *pdev,
 	ds->num_ports = priv->info->num_ports;
 	ds->num_tx_queues = NETC_TC_NUM;
 	ds->ops = &netc_switch_ops;
+	ds->phylink_mac_ops = &netc_phylink_mac_ops;
 	ds->priv = priv;
 	priv->ds = ds;
 
diff --git a/drivers/net/dsa/netc/netc_platform.c b/drivers/net/dsa/netc/netc_platform.c
index abd599ea9c8d..bb4f92d238cb 100644
--- a/drivers/net/dsa/netc/netc_platform.c
+++ b/drivers/net/dsa/netc/netc_platform.c
@@ -11,8 +11,46 @@ struct netc_switch_platform {
 	const struct netc_switch_info *info;
 };
 
+static void imx94_switch_phylink_get_caps(int port,
+					  struct phylink_config *config)
+{
+	config->mac_capabilities = MAC_1000FD;
+
+	switch (port) {
+	case 0 ... 1:
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
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
index 0419f7f9207e..7d9afb493053 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -67,6 +67,14 @@
 #define  PQOSMR_VQMP			GENMASK(19, 16)
 #define  PQOSMR_QVMP			GENMASK(23, 20)
 
+#define NETC_POR			0x100
+#define  POR_TXDIS			BIT(0)
+#define  POR_RXDIS			BIT(1)
+
+#define NETC_PSR			0x104
+#define  PSR_TX_BUSY			BIT(0)
+#define  PSR_RX_BUSY			BIT(1)
+
 #define NETC_PTCTMSDUR(a)		(0x208 + (a) * 0x20)
 #define  PTCTMSDUR_MAXSDU		GENMASK(15, 0)
 #define  PTCTMSDUR_SDU_TYPE		GENMASK(17, 16)
@@ -123,6 +131,24 @@ enum netc_mfo {
 #define NETC_PM_MAXFRM(a)		(0x1014 + (a) * 0x400)
 #define  PM_MAXFRAM			GENMASK(15, 0)
 
+#define NETC_PM_IEVENT(a)		(0x1040 + (a) * 0x400)
+#define  PM_IEVENT_TX_EMPTY		BIT(5)
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



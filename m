Return-Path: <linuxppc-dev+bounces-18232-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E360F4643A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 09:42:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ99F1FH0z2yjw;
	Mon, 16 Mar 2026 20:42:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773654129;
	cv=pass; b=cwZkCtyDunMB1o/5Cs1C9weu9hXOGYjOB/n59hTtj+s1TttlwguLLsgU+DBx7wyvbJGBR2Dnc2a8C1H8x5tZauZQAEkeDF7ztPbQ6hAKdTjf94GYtzQ4L1xAoGDckSm7v0IbqCLtCmw1xOFCuluafJ568DVNim0x/fhLuTRDRJpiSwatBZbEFZVeOoyWtDpF4sTKkHKuK/VpXwM2CktNahC93UQhBYo6VNEG5syKgy9ZeC3rE1G6XSaWJsjJRj/O3bV/P04aGZMt2RAD1GG82Lj6uHpDC4XKywMNhPDUY9hQykXwmiP8WLxpaJ4uv6W0AoDnZZLuhyaI+KrlUR43mg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773654129; c=relaxed/relaxed;
	bh=YU6/N6AzHLHwoGSaPHo7wKgcwwxBox33kgbqNZW6N/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NOQYwo6WEucmcDTACasz+1+On5v2BxBuviVeobhQ1pZfZJQcB3q4eezAmE3AHZkGEnG/WoA/T4qFD1Et7Ih64q40rz3CgAY/NLtXL4uiAfXWTh13IhuAcdq2gbyidSt9yjZB3i/m5upBHkLvQ8OiQlVZGBhRO7txSY4zDb3eAb/fWS8kihBSAg3tuhGREcMV5+uVO0LzGa0tUDqsZoshs/0LjOS79d1ob4oNNZBTd817Et1HtEzBorXm6NY/nbyrwt0+vB/LyasIdyI1eA5wZc5j7Ynj3gMVT92PfSp8/vjlCzr6mEj0GIk/Nz5vJiraCioWtP61tcNJvLxcNJRKOw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=DYCiNYnM; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=DYCiNYnM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ99D12SWz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 20:42:08 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDvAGd646hJJXJqL1QK+WN7tCEuuo1XYvW/rGEFx7qZuLdWFfdigMThpRVKM5sDmhVn8taPpmybpRaYmEX4nNnx3y1nsJvEXuMjzk7s/+SPHvw7vdVe7/sRCqOZLamXTgnwSKjxy4WE49GaVwqBvfnO2XRaONH4sCAG7io3q/vQGWzXKVZ/8f3cO73hvJ/z+UrUKlKlVf8/Rf2gV9M8ae/jEW06Klsja47qEAcOGEFLDr5J58lEINpry7Eq6HX1OFHpFElMjefUqQ1w4KuzoB0JIrn/9joAksqhMXswSOqARCx3Ff96MsdTJgjt1A3YvMgfJt/t8eLin1RIo6Zy2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YU6/N6AzHLHwoGSaPHo7wKgcwwxBox33kgbqNZW6N/Q=;
 b=ELpfz82lHwUFQ/h83b4/8dRJtOH9l9hMSjftmgh0YwO+76LyoLpZOmDMJCYMQNVEBhScKfLuL8STpdFPpnC2Xj8rHtjw65kh+QnBh6huktB4SI5yEKU02aDigZk6xXve/37R8qr+qtcSfPt50BNjYByigyYPqMcFnoZx5dLepddsLnfWpVf8cR4fTNArMpaKj9bXCfjrP2ic7j7tGbebOq9zXqWk+1GiIdX0B8yC9hfPnxQV4fPtMjxGsVRleMKft2pCd69GHb2wAuikWxQMuUK4q/nVGwBJFP+XLBlfBzoB5MO1q1qA7Z3iERMK/FrPXwwaVxt5VFZCNWXL+06RZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YU6/N6AzHLHwoGSaPHo7wKgcwwxBox33kgbqNZW6N/Q=;
 b=DYCiNYnMkGIzu0Ec700Rj4/Moeisv1VOxi54WGkhv21Xkxa60dge8KU0MiRRFLg7QP1AP4JrvOO12jg3Hq00Eq+/WNZG8vDGWvW/47Kt3V3BClHHLmxufSrMnEQzOBP8+cfQuUQX7bv2c6c8Bk0Yr4GpG4U1zv77kTdQBB57wGvx4uoRnCdK3Pwe3ZL52//A2mGrLS7YDLaAgFmrmo72NGrrWq6ETr42eGSBbDL9Nt8gwfh0xmmxlB/CACkvxefjUySvaJ8pK7pddUzHNdzgqFb2J63tGALWogJtU514JlAizBJ5y4wBz1o0LLU2VQntBoZDduuTIzEADKpr2Qw7GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8195.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 09:41:16 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 09:41:44 +0000
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
Subject: [PATCH net-next 11/14] net: dsa: netc: add phylink MAC operations
Date: Mon, 16 Mar 2026 17:41:49 +0800
Message-Id: <20260316094152.1558671-12-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316094152.1558671-1-wei.fang@nxp.com>
References: <20260316094152.1558671-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec9168f-b6f1-4537-5348-08de83403b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|52116014|921020|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	l+EFnnLPBLCDl6uGGiw4tCJaALwGqgtF7RXIAjU2LashVa3dhKZLsVOKQMIeVeCJyG+x20d30h6rXsC08JB+UpGxcrjF/b5o7vsuhVw3p6jny7ASxGxY1H+txA/GCfCfwXYAyLQTTmhEzm/mzoHin2+sJxvvA+TTweXNI5Z4vnzspA3UefAAe0Znm2ArZIdO6ppDLMmttDH5zdmby0k9j6gcM2q+recc4aVW35Y/Snr4Tgvi6rB/reNSLUXqmvCroH6f/wSCFjENxHgD2twh3mUgtJPCvh3i6JPmxeUF8C28l66usS5kUI4/mVKvVbogIfpNn4udx7lDXSPZyENPzTxWAM2wqCpCTb6MaecYXeTnRMNakV5WhKTGlkeTFsl+uWSg2ZcxOHr96hJ2cyKZaj/Vg35xy7D9McYQTytuNUeyMx2OJCcFFm2l4Q0D2xBH8j0y8Lga0K0wlQ6R2L4ywgqsyYs/i3dg58QmR6qfwfSFRbyGx68IL91fg3JQRcPFHa/seo1PEDI+cI2ZU1tiMQ5+383n+n2dtYkvmlD2he6MwiNRHrWPCUZhsySN+SDX43QxRGGyipoX+pxPqBACgt8ORIX6BiXa+AmyFOWwgeHluBnCVWkhM2YXJQiZJ5DUKoRXam092rgRBEu0FZVUA9GJX2v7+wxmfYzwtNCW0ouhl8B3FVjQBnPY3V3mzpu+nPGana8RrT+SzkJIdWo9IqLrqlG3nWsIZkj3pnZFMKAOtsshw35dN/iW9YPKVnVu+jTjZNWjj6PH8xAy0b3Y2PVH4c+ktXwUFwjcvyktkCL6NJfRaBFsslsVOxiLvwu1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yJ/7Tkkxc8az9SJFeOeFPdlsBm24GWAMjxmDEPpMrdGtIFGFSu+kP3Kj2/pD?=
 =?us-ascii?Q?VZTkZou+ljByWiiHFoBqOa7p7tulNbsaW1LknmKL+4q4f6r8JW2ixnQev3MS?=
 =?us-ascii?Q?myf1ppaV4foKsNC8AfWaxrzMqMV2KNeIQbNfyIcY0UmBqT4wzTSdKWLj2d7q?=
 =?us-ascii?Q?Qmp0hF9exW+yhTcpORgoHC89OVLUSawvjwbD9jRfe/skTq9rpaw7ykkVPK8M?=
 =?us-ascii?Q?WQ7PTmljnsB5aAby/Qg2u0+fukl0ZzKrv4L+KlbBClN+eW7tlV7pSosapIsU?=
 =?us-ascii?Q?MiereGaobwT1j0rmlL4vjnW5pOWXEGsNDSkqdKtMKcOi2F8hVsbBdDpt++be?=
 =?us-ascii?Q?bVBSDF6kxEVAl9nty/QsSXLqeHBRtXL9YfBnmLKJF5xlvlkyBNschMA8JdZS?=
 =?us-ascii?Q?UyLIJ7AdfNZ5GjSdAJ2Axlb1kno/hMLbEHMZ0tu0GPl0In7IfjuTE+JN9G8I?=
 =?us-ascii?Q?Dvah2NgDCM2zCVPv/kS5VlAr41jLEZ+rcxQv9GLT2Cyp8xu8Poi7yGhyLd70?=
 =?us-ascii?Q?lmznke3qPF8LX7ohNnj43gRex3ns9SAHoOxBuZetgYdF5M+P6bchQWAMNZDf?=
 =?us-ascii?Q?n7pT/6XxQUgtPst6uSpGaFKmA4Dhy7QoOgBN2qF7ETaxFX584sRnmYl0R9S+?=
 =?us-ascii?Q?l2wqGkMkyfGhR43V2+3tE0ff0nXBukmu6qysvRLkHCoXxuW+7fUrpxRDe1pM?=
 =?us-ascii?Q?I2W+DbU1rGt0+JSyI4PEAcRFTWPkA3BqgL2uUC/zj/QGpnjIsMCx6Rl4qo2F?=
 =?us-ascii?Q?2M5JpX/VtU/oK05ng4HWcZyTgzil/FX96L6Vgfv3FLGXaShxTmJAMJHZ4ZVU?=
 =?us-ascii?Q?+GDVZdEVwPUnkalLrZq/HlqkYDD8hPHKg9iOr++V6StM+7ir2n5oPqePBXW2?=
 =?us-ascii?Q?pmLxvrzPBgbD3G7whfRQNMVoBBJmbxQhZPfdVGW/17dtStVTCupLW+Hu6OYH?=
 =?us-ascii?Q?oBIjSisVpAMe5zGnBktx1bzp9yk2fRskAm+1lmai7/8wGz7liKb3do0bOjOZ?=
 =?us-ascii?Q?7XLbUwlTWUhaVYZgFCwEhI2C2lQPFGHo42a7m8GZhzf+xwWubPzaJcYV6QT6?=
 =?us-ascii?Q?CFoD0a4xMZRZEQhj+sde004HHOBCEPE6+RFtfHkdFr4wQNJhu5W8YySUmxLk?=
 =?us-ascii?Q?tF7Tf+wwc/7YkTkFR1Q7bL9BA0min01nEzLfIArXDM0ecaleqNQxVlb5IjB5?=
 =?us-ascii?Q?5PnyXGC6MVbDZA8Ikcka3mtoBrkd7FDPRDQB2XglRm37a95UcJ9lRCBQ5AKO?=
 =?us-ascii?Q?y6bSfDaOJwr/J7GhF0cyGuUTl0cZvkxhD2m6wjWs9U2gF3dPzNhfQ0tEuFZW?=
 =?us-ascii?Q?qncNmAVWO+pOvt0rDno/4ybXBd7+TWqRwr2uzEwhAZhS/L4fw/+ympsGcVSK?=
 =?us-ascii?Q?Ww2xhlYNFg4reLQ/0urtXcYURZTrpi0mEd0b1H3K4EyDLpfSZ8imiWcUzlB+?=
 =?us-ascii?Q?PfdFvaUjeNmnnXu/HBCKkKVCzyZtoUTGRw2obngn/AfiC1Ithk2v4dnR92JP?=
 =?us-ascii?Q?P5VfWuDhjz9PXjj6nFhj/Dm1FjCeS2EO4bSQqdM0n7EalKueosAHHhNR8FQF?=
 =?us-ascii?Q?M2JMMRFeVKXY7owfHijGtGESAFok1cA/Bdyx/WII0YA2/Hs81R2/UWf3H6aP?=
 =?us-ascii?Q?yBSDeOZ91Oxc7gCvBYX38YS9/UoWcFusGaJp29IjvlSZN9FHwQwa3EL9XV+3?=
 =?us-ascii?Q?RGWydfvlyJ5i6VH6As7BR1z2x/o7JHCPctGBmVUP8GMgDjHLfXeVdUrhANSy?=
 =?us-ascii?Q?k/sa3z48tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec9168f-b6f1-4537-5348-08de83403b84
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 09:41:44.5500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TEWfd5sgvpgcBpaECk619F6N9ijCrFlfmGupKK9GZXfToXHcCNywRBS8EWXfrnC1G9ZhZgweg4QEK0zob1Ol5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8195

Different versions of NETC switches have different numbers of ports and
MAC capabilities, so add .phylink_get_caps() to struct netc_switch_info,
so that each version of the NETC switch can implement its own callback
to obtain MAC capabilities. In addition, related interfaces of struct
phylink_mac_ops are added, such as .mac_config(), .mac_link_up(), and
.mac_link_down().

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c      | 212 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_platform.c  |  40 +++++
 drivers/net/dsa/netc/netc_switch.h    |   4 +
 drivers/net/dsa/netc/netc_switch_hw.h |  25 +++
 4 files changed, 281 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index bc7d48b99610..884ee899fc89 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -595,10 +595,221 @@ static void netc_switch_get_ip_revision(struct netc_switch *priv)
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
+	u32 mask = PM_IF_MODE_IFMODE | PM_IF_MODE_ENA;
+	u32 val = 0;
+
+	switch (phy_mode) {
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		val |= IFMODE_RGMII;
+		/* Enable auto-negotiation for the MAC if its
+		 * RGMII interface supports In-Band status.
+		 */
+		if (phylink_autoneg_inband(mode))
+			val |= PM_IF_MODE_ENA;
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
+/* If the RGMII device does not support the In-Band Status (IBS), we need
+ * the MAC driver to get the link speed and duplex mode from the PHY driver.
+ * The MAC driver then sets the MAC for the correct speed and duplex mode
+ * to match the PHY. The PHY driver gets the link status and speed and duplex
+ * information from the PHY via the MDIO/MDC interface.
+ */
+static void netc_port_force_set_rgmii_mac(struct netc_port *np,
+					  int speed, int duplex)
+{
+	u32 mask, val;
+
+	mask = PM_IF_MODE_ENA | PM_IF_MODE_SSP | PM_IF_MODE_HD |
+	       PM_IF_MODE_M10 | PM_IF_MODE_REVMII;
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
+static void net_port_set_rmii_mii_mac(struct netc_port *np,
+				      int speed, int duplex)
+{
+	u32 mask, val = 0;
+
+	mask = PM_IF_MODE_ENA | PM_IF_MODE_SSP | PM_IF_MODE_HD |
+	       PM_IF_MODE_M10;
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
+static void netc_port_set_hd_flow_control(struct netc_port *np, bool en)
+{
+	if (!np->caps.half_duplex)
+		return;
+
+	/* The HD_FCEN is used in conjunction with the PM_HD_FLOW_CTRL
+	 * register, which has a default value, so currently we do not
+	 * set it in the driver. The half duplex flow control works by
+	 * the backpressure, and the backpressure is essentially just
+	 * a long preamble transmitted on the link intended to create
+	 * a collision and get the half duplex link partner to defer.
+	 */
+	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_HD_FCEN,
+			  en ? PM_CMD_CFG_HD_FCEN : 0);
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
+	if (phy_interface_mode_is_rgmii(interface) &&
+	    !phylink_autoneg_inband(mode)) {
+		netc_port_force_set_rgmii_mac(np, speed, duplex);
+	}
+
+	if (interface == PHY_INTERFACE_MODE_RMII ||
+	    interface == PHY_INTERFACE_MODE_REVMII ||
+	    interface == PHY_INTERFACE_MODE_MII) {
+		net_port_set_rmii_mii_mac(np, speed, duplex);
+	}
+
+	netc_port_set_hd_flow_control(np, duplex == DUPLEX_HALF);
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
@@ -639,6 +850,7 @@ static int netc_switch_probe(struct pci_dev *pdev,
 	ds->num_ports = priv->info->num_ports;
 	ds->num_tx_queues = NETC_TC_NUM;
 	ds->ops = &netc_switch_ops;
+	ds->phylink_mac_ops = &netc_phylink_mac_ops;
 	ds->priv = priv;
 
 	priv->ds = ds;
diff --git a/drivers/net/dsa/netc/netc_platform.c b/drivers/net/dsa/netc/netc_platform.c
index abd599ea9c8d..8d3fb5151902 100644
--- a/drivers/net/dsa/netc/netc_platform.c
+++ b/drivers/net/dsa/netc/netc_platform.c
@@ -11,8 +11,48 @@ struct netc_switch_platform {
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
index 03b49857c854..6d7758631e61 100644
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
@@ -145,6 +149,27 @@ enum netc_mfo {
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
+#define  PM_IF_MODE_RGMII_RX_SKW	BIT(10)
+#define  PM_IF_MODE_RGMII_TX_SKW	BIT(11)
+#define  PM_IF_MODE_CLK_STOP		BIT(12)
+#define  PM_IF_MODE_SSP			GENMASK(14, 13)
+#define   SSP_100M			0
+#define   SSP_10M			1
+#define   SSP_1G			2
+#define  PM_IF_MODE_ENA			BIT(15)
+
 #define NETC_PEMDIOCR			0x1c00
 #define NETC_EMDIO_BASE			NETC_PEMDIOCR
 
-- 
2.34.1



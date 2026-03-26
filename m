Return-Path: <linuxppc-dev+bounces-18806-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077DC109E54B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 06:29:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhDPS4TmVz30B7;
	Thu, 26 Mar 2026 17:28:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774506524;
	cv=pass; b=idOaOii+N1Yx5w2cH2BjTx0b2uMwytbm69ZT5dxsF/hiuds6IxE38x9h6iSAKRYpDyZcH2/KDAC4elkAw62Mmany8+mjf43jy3jke5OuNS4ZWlZsSZzf3UzNyQeGv94OwV9Q9LYKnXblSXl1Voy5q305E+i7uFBrwkVXC56kSZpNwxhIbc89P+FOgC79oRL/CwjYG45XGRUREqxNpgooGayWALA8L2RxdpJI3qNNRJ9pNquKKk9Ly5OzW81TEIjJns6NHXZkR3J6uBBwDL83sOE2vr/r7bbP5WwcBHVA9d15furPsQQ0ZSSE+Ax3Pnn6jb0gBrevNDAgyWVc1b6GrQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774506524; c=relaxed/relaxed;
	bh=oqoeeUeQs94pCwHeizzvSYYBLJhpvBS5eR+sc3tiq1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H3hBDs1VLhgFYo0TOyOGwmcMKa6gTSdvAtpUpzz0I9pqXyQBURted9XOM8a5W8SItzH14ruHN4HfsrN5quB8py5xOR8zBxbeUnbd5Hvc2bykMvZEKx7FKF0VlBFieMdpqyWLTlBWY+a/dNhBroTRTC6R8BQv5hFdn9j99sEEmT+3S7IPZGEUCdktW9LKsSZvyO5D93g6IVluQDsa3/HI0zt8fLjKObD/lHJGc439PJiFd8dmKM5OPUs60LnQIqQh5WtN3++yNwyFMdIvg6t5wZ++KUTiaTnebF4fiiOQPEW8dL40r30C9O8DCARbn6Tzp3g8wJFjOJnjkXq5N76UZw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=cwjnmJ0K; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=cwjnmJ0K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhDPR4jMPz3069
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 17:28:43 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8VWDByUuITAQsUW2guywArUyCd0cFrmAv2RdVX3mnWwIaYG8RDTfGb41m91qEgHD8jdhmgN3Mykh9TtEnD2QMalldWJJrYnZ7UAjSfkHMWSz/U13PnO4OHRKm4vJxo8BKixYoFyluYZoTKexthYNQSuGPhMINdDFRnBHmKmQIsqywNGsqvjVkOTySvm/w0XsgxStrnfgcB3TpU/EXjk55dZ0YCgk5oyynvk/+wd4GPD+TKTmRAuLKyAbB9dgqntnVtqtFLwz64QheyqFXdu5nXRPtUfbYpQokgnTMvVXvmfo5InPtVoXVnWBaB3wiYrllOC91qdKmlJAwrCU1S1kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqoeeUeQs94pCwHeizzvSYYBLJhpvBS5eR+sc3tiq1A=;
 b=RSqZslmzFgaq6tGeAeTb+uuXy+/8d/L+9byGm16LeOqMfXjxL6GmVJaC4ivUGbpHPe8uSrTLR54lejnlCKP1iZKVZzryo5mPC+6rVLSixoEkGTeJWR4DQkMeJ0pltwVFE4+dmiu7KHyW8TPjJVdBXZ4GB4oGU8X0zSVecYuGfIIwNaDmFbfUM0zATKbLZejSDDnaqwE7oD/hfsRvy8JDQSAb7soRSM3S+nFwSeBjnVCSKuH1P1AY+/LDFsCQJY6bNDh76NnppwFn7lIU3odKeZaijNZrLyqfRc/U4rDDwZLcf+NmBtjbs9he8Km7Z3CYvWMqlvXqWeTx0ahOyTjLLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqoeeUeQs94pCwHeizzvSYYBLJhpvBS5eR+sc3tiq1A=;
 b=cwjnmJ0KChlFkxxc+oUsnmOQbYlCgYA9TL9DCajDw6TWbWycvKlZ214Ek89W8K6+2RCaydt8f/8E/dDzOWp7+INfPmnDfVHsCgth++/JwKxhdbM2L6+WA8YyGO0sn0i4Wft8l4IC2poTpYE417g3WSyBjpv5+PQdkUioOUqUMB8+0jTBdHMpLp31NEY+wDJL44aPD0hX3isoVpOUwd2M9Bi1k5kgcN+BBSvGqLf6WQML16vXjfVWRNVkN9AB40a8LDpSpMU3+iFOafp5CoS2yKJ/nTSam2jmpCNsCuiJ+gOxaRTipzarIo4TK7M6rpyB0Lt5NxaqgoNEVLJmzxYf3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8355.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 06:28:40 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 06:28:40 +0000
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
Subject: [PATCH v3 net-next 11/14] net: dsa: netc: add phylink MAC operations
Date: Thu, 26 Mar 2026 14:29:14 +0800
Message-Id: <20260326062917.3552334-12-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326062917.3552334-1-wei.fang@nxp.com>
References: <20260326062917.3552334-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: f183b1db-926f-441a-3b4a-08de8b00eb98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8x1bTyP6kFO5brNhC97oEBtHuXQoTQOcchuUTAHn1IYZWxSj5IeH9fnysW6hddvxs5+Eb5YNYtxS6qjEpJNhCFpgn838OSWeGRC85dwG+Jxllppqg9J5zRo+UohRo2LZOfLDdM39yGS+rL18CCevWt5zbg3U9fRLyuXKwJalKb/GxmsTvHHavhP85Y5gUBzB1C+LnpwImIKOI53vpXGQYA1NhR0AAk0dZmasvSIZdEgWyWxyOCGnPrHRzIpYzyQL5uA22i4EM2I3snRTcXcmLVNFwrwZbAACxqJH81iJBsEHpdgqlAml07IY5rfZDOCIJsbN/wxOCjkSt1tzh7h8/PrC8uPEj1u0g4u1rO8vM4hNpOQ6txfLYWfnMc/O5I2Fe9uJy/0rJEXJ59aUpJ79syEL4B0IASxEQqXTIwRzPdZnA5AtSc4WBMj39fPTlx+iWNON5QI0eiKPmmBznm8M0rqPERv8fWejuqSGJMRi0xZsLK1qnQY60fy5capGXmC3r8Nf5HyJdc1CAItgXE7txwjMqFU5v1AtR/W9XWmKAcUBlxSH3tgcItzFj6TTNv7TH005dT5M9PX/b7ZMQeLT26v3hD9l0w5598RT5rC6S9+AKVmX/eSC5zxGBGyu3Ubc8hDxkfYxrr1UKxATXkkBLGMV1G1d2H5Sk5qnJKVQzDJb0rdkoYAI0SoXLDKc0X0FctxIaJbbOWOWCkPIujZmP590s7aehpTv003KqipmF/icuQFv7qjfSpEz4sW02/HDn7E/w/5/qKrOVPtYXJLaLyXGTedwTd+u+wijuE1AVbhWktbpxDuRIpd9yLG2YSoI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wEE+EU3V6F06Rlg9JBiz7mqtgSya2LTTd4VsRKanVkgVS7Ckb/QFY5J3ulIl?=
 =?us-ascii?Q?PKRGVdm4lT5W1i9lU8Km4DWIxOYGiRXNGmpfjybgRDpRTZqrSTgjuNtEl0+2?=
 =?us-ascii?Q?FSoD/pAUaiBCQMAaP/kBloVbd0dMbsIIEi11GAvJHHihBSgtqCItV2Z4hp/c?=
 =?us-ascii?Q?uQUa6MIR0wmGX+lG4wFUpm5CCzjw8EYcHtP6GDGVyDiwxfsuSUMgKAEnic0z?=
 =?us-ascii?Q?L9r+Ndwhx7ZwqfnFf0LBK9dcZQy7yc3wX4ETX08kBdbMlLVu0R8Of64yw4nd?=
 =?us-ascii?Q?oSNqQ1lgpBKRk+TckjiX7t+gXphxtoLFF3w9J/hJeBZCAVc3o1udsyF9hdnj?=
 =?us-ascii?Q?zk9HURAipvYzAypZ4+IBoVNM2pz2WgMe6rPimGJLQ/c+7Zb/QKVU2BNUSbBp?=
 =?us-ascii?Q?6PVMx2Nxz3m8dLVmSYXjGpV2fzl1rOZ1oqu27ymQFukOLtdCnEMvcXJlE0W8?=
 =?us-ascii?Q?jfGGWR+Ff3dadri0V3HWaKF30P3v422qpy7j+MUxKseoWKmTe3sb8JtOylhP?=
 =?us-ascii?Q?bxvwDDt92/QncynTQ/STs031k6m3hvJmt6N/U49bHAsbOpXtP3II85Fyj+uv?=
 =?us-ascii?Q?CJrktB4f4x2BnMVoZseQq5w5sCB7mqb1mzjPkbCCLW0XsY82SoqvbPXB19wq?=
 =?us-ascii?Q?eP0racVjQdFmDvnV3X193H4pY6KGpFGaO/z3BqbCgKmKGt6tNlDI9vvfBvTw?=
 =?us-ascii?Q?mjDwp1HY5xoqLM1Ingswkioib3s4OFQ038zotMASQSstN+lm0kbHDEeMfe08?=
 =?us-ascii?Q?cgKazb2wVNBoYJJPP1d/TxiieReMX0YG0ZBLtkYQcpJRHczP8/lAfqXJ/TR7?=
 =?us-ascii?Q?if/nHl8pdAapuSaFG6Yb2/BWU8Zuq/6MxBMumNKVIcxOCRM/npe4a3AqhX7U?=
 =?us-ascii?Q?pjcIFs+Z3SjYclVY1XSv0lno2H0YupLM4GDF+uajeNABAfOiFprD+ZchsPbq?=
 =?us-ascii?Q?qogv3yRcnes3F7OAfrOGK3qw+G4ZDUZ79cTbaBBE2NcZyEPPX5lPsoVfISc3?=
 =?us-ascii?Q?SL7Wf2OKeFb50YUyQUzrlOnQZhIIE2TC1O1IlE52njDV32o2pN5QSN2GXbzc?=
 =?us-ascii?Q?bGvkbf90f0m7kqB5ku02M0NTTnIqYzkJ0kCowgbagOtYXelrolW3a2oXGYlz?=
 =?us-ascii?Q?56lHThblpY5JwCoSMTxTl6dxk6/85iZEuYydsToasNdtl3ufSJCX+lIpm5Xi?=
 =?us-ascii?Q?NKvmLR2fz1WHCIwJWbXz24v7PTCPe7XPpkiInGq+/ZzldCPrMW5R0A5RmQD+?=
 =?us-ascii?Q?6JhggxaFmPXz5MwdGbR22VFgho8S1c6FBJgnfkYz2pvfhRs1eB0s+BcvjqtZ?=
 =?us-ascii?Q?xgVGmhJg3GtLrMBVuHm9Yo5kuZrg1r/DJ7paFiX9rADN6e0lXy7J1B4QF0oh?=
 =?us-ascii?Q?uZ5EQZk2yDOQPFJ270t9vffwwrv2geXXFZmwGvX7/3koupgohLlhWIgKihpu?=
 =?us-ascii?Q?tdooiT1jTBN9WGiVLzWi6BiitmGnFoJtf8VGZ/am+9qgKSB3fGIS+19AoCfo?=
 =?us-ascii?Q?ZlzjTz/PADwVTR77gCDE8ytLG4PylV4NNq0IBN24fAwkBpKvdMOYGhWgLpxc?=
 =?us-ascii?Q?EZTeRxc36WaP7Q0rQ3Ku0fjaUdAWx5REPiaUfRlmtSpFSzS82CAL3Ed4JCrP?=
 =?us-ascii?Q?i2pKAfEFmPrLExbfjMrZVAcpWMVN0H7KBtlx/5I/Mr4op4cWgL9GNnvcSA8W?=
 =?us-ascii?Q?RTmmx1uZ/+GOxesffGlzIq0Ht4CAnE/DgqL3G6wU5N6K56Kj0n1LLDCSGXxK?=
 =?us-ascii?Q?AuyWAKK0+g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f183b1db-926f-441a-3b4a-08de8b00eb98
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 06:28:40.4455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VyYPafjiVp0089S6zEeoE28d3N3a0IKWFK1OydEoDGrXd2p6S22/nFmmWxQmYRc8tUF/sNg8kz1fyAwaXnHSlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8355

Different versions of NETC switches have different numbers of ports and
MAC capabilities, so add .phylink_get_caps() to struct netc_switch_info,
so that each version of the NETC switch can implement its own callback
to obtain MAC capabilities. In addition, related interfaces of struct
phylink_mac_ops are added, such as .mac_config(), .mac_link_up(), and
.mac_link_down().

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c      | 179 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_platform.c  |  40 ++++++
 drivers/net/dsa/netc/netc_switch.h    |   4 +
 drivers/net/dsa/netc/netc_switch_hw.h |  21 +++
 4 files changed, 244 insertions(+)

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



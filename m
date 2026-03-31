Return-Path: <linuxppc-dev+bounces-19073-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41571061B32
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 11:29:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flQrM628mz2yvP;
	Tue, 31 Mar 2026 22:29:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774956579;
	cv=pass; b=KZx/N2mDBzlBu3K4CO5vKu4uFu3ZJVR072rYm+2bSy+VIKaNroFq9w/ZJeMPdbtGQ6Tmg5QB/7MsE6KoSg0GwApWL3dMv+KersRVRMoOkXwISdCFRgZYNh7V9q4DBC488hmNnzU3NvG5fcrklIKdbqfXdyJ8EVpqiYcWEeR+/EVwc8vlf7P05c9whevyIDm/Gs9p4KqCsd4o+3vAz/kqrqw/6oB5exO6FDgB+KEjHqb3C82GVwd5eCxjbPtwVjfvIci68RyvfM0dfpsZQ3f+Gq5M7tKprB9SOjwTeYK7mmqx9zKaZye6x8CWzKV8WzGZ65ZxsRvjgUxudJJcE0zypw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774956579; c=relaxed/relaxed;
	bh=hA0A79YWETmRTGTqe7Mp/rjfjw1D2YkkH7VrA8J4Fio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jmkQDiNKLinJuahvLtDq6YgbpzCGnwypN5vimaE/niSUgZzFyp87mwKhXbOr6bUh0rgzfMfEMgVK+i/qBYUcXwd00J/JuYN1c4cr3EAOWN8oOxl4iekDyeU3sXSwURt46UCm4hckG0ZdMlLHSapBty/AvvkOPD9vfte0kxoruylz1+8fYqJTkYjx+alN66RD1cBBCQF/CMGM8Qfen1i99E2pv+PCldKNAsN02+i05WECM90VVht+NxsBLJOlGTLKNSdjnSIDnb1IU9Vul3nutM65kW+nz54nYR2+sf0Wr+pt9OZzuu1QB3MpU/OcqvKth8Bt61FTq+ju5o5Akgcltw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=OR6LrabK; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=OR6LrabK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flQrM1X71z2yvC
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 22:29:39 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kixb3EARgcwpcpggws4OYe3g6+9D5rGCdIszc68/s5N2vRunfcFtLXRAVJUCk35kWH0luxKPGuJHKcykYAbiwWgDrSU5vZIz+C60teSz6MOCuOV7cR0J+Yraxzy7alWEZpRqL9ewsx9Dy+1HP24UQ5wFTLRx19DOxIyZAE8iX6+Gci/5wIVuK/VC8ZzFoQL8OpoPA2LO4lIdAWZlHpdbfKAui2o/0IL+6PWeUoyp1jP2wTvihZVxNImweB/SCUVRE2WiVeTd1jkZSS+9LfydwtGMEwvuVeI4sGOCdd+4uLyV3wQ//LQI/lH9PBMdPkpkFbGX1sd9HpeS7Dk54dNSVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hA0A79YWETmRTGTqe7Mp/rjfjw1D2YkkH7VrA8J4Fio=;
 b=feoQ6BLoxe/qziyLCQ40vJijTwcEhfRnSCeHA9c+YIiBDsKu53FMdpfqKRKa6xanrxIEa3jxhBlyCAbf00rL0CzXiFVrvBTEMAxpd+Q2JxrWI5oiaoD54Gt+UZwv+70iqbzDfoDdS7BBNMfCd1cyVy/PeX5fokhQ1yFVHUne1IGhur/S8Ld5rYvfccuonYaCA4dzhSTngo3apXFFQ+a5H53UvUymlHpmABN655rwVEASfTxjzfnzEgAiS79a8au35PG/rNju825ZTZDFhNEBvLVARf2cpp9f7p4MLG9hqmTeEVGG551qm0Yfz7SR+m69AeqU4THIq0UsNuWc+LSL6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hA0A79YWETmRTGTqe7Mp/rjfjw1D2YkkH7VrA8J4Fio=;
 b=OR6LrabKg8RWNqbyieX96gIBYwj0/PXE2NXU62ddOUe4vdTdr8EbjDv6tRD2bmmEwI11EItv4UriGx2gCX0iG/rE0NTrBWUraLCuk6Ruqx8dHxwLVo1995zwZJynPPAna2yqCDxPYqod/OCpPIhrvK6/pd0GJs03+hAH9mBreXgsvPjlHveBC3nQBRRambQGSpt4cfNT97dqvqilc0sxTHesOOs7P6LGGplabFNKtjEvEvlcOPLEVyaEW3rrYmHIa9FrRHl3r+o2h6zqp6whllaQMMatlyT51//2RMGvwWD1OnU+QrtBn0ppimCGYuX8ajDU1x/siHDOGB50O5L7jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by PA1PR04MB11406.eurprd04.prod.outlook.com (2603:10a6:102:4f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 11:29:28 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 11:29:28 +0000
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
Subject: [PATCH v4 net-next 08/14] net: enetc: add multiple command BD rings support
Date: Tue, 31 Mar 2026 19:30:19 +0800
Message-Id: <20260331113025.1566878-9-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ef7486b7-1dbd-4ec2-9770-08de8f18c525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|366016|7416014|1800799024|18002099003|56012099003|22082099003|38350700014|20052099010|921020;
X-Microsoft-Antispam-Message-Info:
	VWk7ersje6dwx0Yc+LhsibjP/a4ICY9VH+by3dlFLJh2OG/lisqjnoATvnJ/yLRTF8kF/0N/FVb6EnRe36JPZSB9Sm8doPOYSylRGufgxyf3UFWNkO4PMWiqZXRQ5PM8cwfjFCEBsXRpB/0tCEXcnV7y3tt45wIFmTwwO17bxopMQGdXlozBbkJmhN6I9+z6oER615kBVDPigdx7uG63FLQ4OOV6ME0U9UyKixRUsBD1V2WXcH/XTYMQXPJ5unCuBf7tt6x7MI/ZEV+Bt7q5eJ1awt/2OxMS3BRsm/ukRJ1bfBgel5ra0Mm2A8wJcCVlVZQfT1Ggpws2ZRVbfS/koP5ubNJcf++cgtChG05mWto+bzvbEX8Rd1NYd97JknCLmnRTkrMM8GuZMyaFRdiRsEEC1eqUBqREArtkLazrvI7N0IWvOsT8IIyWMvQyWRswUv3AW6jA8FNJviLrbQKgXH+F2Fs913wGWCOLM/T9PogSPB6jU6zPxjBDLxg14d3T3Sz8EToAQjYx0bqDKilaDIKZbwb0eqXXbQ3dgROqGOxu5AzvDa/HHtxk8b6/Yok5JsXXzLYZ0FJI7ejkbfrl1Fp7NA6fEfh0VfIsEOj2r7yGVKMACQ9A6I6gijIF2ecvH0x+MgWXZfkzegmh5czgkxaYOlAEcVYGl2ePG6llOd2ZkEPRZ1FmSJkLOgE+XA++OQQM/bzv4WHf04jw/v/j+LnyIkSfP/FInYzfm6symOLp6y+NFAU/lNhDrKwDI9gUsXa7Ei3anXaE5XYHyFiOjAehogVQk1WDOZWsZjjtFevP22DF9Hc2Lr0c1pKk0m0m
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(366016)(7416014)(1800799024)(18002099003)(56012099003)(22082099003)(38350700014)(20052099010)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b1B6ZHowvfFxW0Qp4aK415wBIQcM8cNBF14T6Oa9AiqGHDuBZrNJRitcm0W7?=
 =?us-ascii?Q?4m/uBEMfeRk/CFJyfJVcw1VcoMivHbNNlcoVWOf9KrbDitriMpCrUhBc/x/p?=
 =?us-ascii?Q?6+fTys1gYyQJCtw/S099LSzzlfuDYlC2on9RN289Ge1/vdAJHK6xXqLnDZoW?=
 =?us-ascii?Q?DL+rALWw1eCkkeWiIdP50SJenkoMb1csEvpZEILZp9ruPCwebLzpd1TUF2PF?=
 =?us-ascii?Q?EDiXlfOUK7epbbNxn0kGqxF7B+0tORgxH5742f5Czy/mbH37vxmA6DTxPqq2?=
 =?us-ascii?Q?sDbYXzx7blVXn0+QUfhkYrfg3fxishApVd3PmpB7h1ZFh9epzkFbNkD15SYQ?=
 =?us-ascii?Q?m5C9R5698MhyIAAVk7KOdnWIo4n09Ow4Ycn53/FqjZ51344oPHEbaRwxQ0QT?=
 =?us-ascii?Q?8Gw5jLFNNCjtngbgBoSrdiLX+EEb4YcS6VCaOseiyyOxm4N2O++tedYx82CV?=
 =?us-ascii?Q?qVmvj74efcce/dzx5p/z3WhW+QPByFV1hCQK8HA+nBELfD+yBCkDDswqDova?=
 =?us-ascii?Q?wR+B69g8jK1KlI61cybIz+ouKFTcVUT4+Nj+oCFtLF06Nmrrah9dqliOy9fp?=
 =?us-ascii?Q?kY7hH7nVuhLvGReXR1s+8bH348XCDuWomTWxEYbUDFMoQ5vG/g2m/EIiwQ4y?=
 =?us-ascii?Q?HMKCGcysOdiCFWqQZnp9nv9tA6gU+7YKdAQ10PR0Z7TYNe+t4xqQD3hoqlXX?=
 =?us-ascii?Q?AtS1NI4EaDUAR33m3/MBfKennvZaDPvr6K2XK2ZqJGb+cGc9oH6ntFE4bt8N?=
 =?us-ascii?Q?PF+vcMgeMRjoVohyBNeaydu0oH62LmVi24iYGVe83s1HsYzkJCx2hOgPKttk?=
 =?us-ascii?Q?53U1B1WWVFMOsK6XerBpuDAETG7Y67UbXU7FthfdvqlJyN0rzZkeHPKnjgA/?=
 =?us-ascii?Q?XPGlvcgAO6Ddb9+OhemAfDL2i93RGssUeODr1kjb/zsp20gG7Y0GoszOP1+v?=
 =?us-ascii?Q?mXh4mtOCKPpr8zMnUthCmFpQ1XqxHc5cui/saRSOLW6sNdnGCmv9UclZtbHm?=
 =?us-ascii?Q?p57j5uTLDV6ASzRiuqpDnnbyryNKu/RrKNHAK0VpfRdTn6I0CIMEUSEWSN5u?=
 =?us-ascii?Q?w/oDxvRBhUwnrIsoPKORMQDfnBYGHS/cW/Uj093QNxJjhdmPW8szr7/UxlyO?=
 =?us-ascii?Q?MLOOeUpZ1ojE3gIYw1c6HJb1zt2Vc27hm1dmueoZ+j5zWA6wo73PPBCsQ2vX?=
 =?us-ascii?Q?dHMqQojMNNwOdAx4Iwo8ZmQqChTCPqCdJZz1EZ9Gd63ye7xtcGkD8L3zJlLN?=
 =?us-ascii?Q?aA34hcRAoIZ2ADXIpBazIE6nC2hSj0y5BE+3Vuq8BsUhlzROopSt/QZs3xRx?=
 =?us-ascii?Q?db1NY0zUuhTQW63NnVz5q0/v+hfvPqOILy9vqbLm159zvUNngkkMO9tiexcl?=
 =?us-ascii?Q?frYuI3XAFffwwLdyL2zHPd5wwFM6xKWm/lv6UMgTpAJqI9Q/ajNYcVqmB1QA?=
 =?us-ascii?Q?1ji9J2bfeauLKcPvoY/jhnDuBpgE4Npa62IfZWoXr3D95QbLvyYc85Zc1gKr?=
 =?us-ascii?Q?5PBn6+olpFJstifEV/91ssOc51n/kry9+St0Ou+6oByD73+TQ6/EnkcDgKPm?=
 =?us-ascii?Q?0QnY2JBXqfU3EpLcoo7pKaZ7ffNOzQu0fdJcTCT1S8SEaPOEZVI8sToV2i6n?=
 =?us-ascii?Q?/yNtqvBAVwEa0LvnMA2NjYHI3Hxv59f/plNVuCrckDC+drY7/DUJrCBa4JEj?=
 =?us-ascii?Q?NDHk4aIJzWFIb0qbgzZnosTeOEnpaIoXpJpyCEzo7d8duG9e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7486b7-1dbd-4ec2-9770-08de8f18c525
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 11:29:28.4608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +bwB/IWcY1Sw9gs/tcpGtPPdKvXwClne06qr4xuK2oajnuO72KdagTTilbWSpMG0Qu/gOK508/BiV0se67aClw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11406

All the tables of NETC switch are managed through the command BD ring,
but unlike ENETC, the switch has two command BD rings, if the current
ring is busy, the switch driver can switch to another ring to manage
the table. Currently, the NTMP driver does not support multiple rings.
Therefore, netc_select_cbdr() is added to select a appropriate ring to
execute the command for the switch.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 960d5be8ec42..5679b866af48 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -125,12 +125,21 @@ static int netc_xmit_ntmp_cmd(struct ntmp_user *user, union netc_cbd *cbd)
 	u16 status;
 	u32 val;
 
-	/* Currently only i.MX95 ENETC is supported, and it only has one
-	 * command BD ring
+	for (i = 0; i < user->cbdr_num; i++) {
+		cbdr = &user->ring[i];
+		if (spin_trylock_bh(&cbdr->ring_lock))
+			break;
+	}
+
+	/* If all command BD rings are locked, we need to select
+	 * one of them and wait for it.
 	 */
-	cbdr = &user->ring[0];
+	if (i == user->cbdr_num) {
+		int cpu = raw_smp_processor_id();
 
-	spin_lock_bh(&cbdr->ring_lock);
+		cbdr = &user->ring[cpu % user->cbdr_num];
+		spin_lock_bh(&cbdr->ring_lock);
+	}
 
 	if (unlikely(!ntmp_get_free_cbd_num(cbdr)))
 		ntmp_clean_cbdr(cbdr);
-- 
2.34.1



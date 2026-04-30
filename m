Return-Path: <linuxppc-dev+bounces-20310-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEDDFF887E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 02:48:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5ds11fmcz2ySJ;
	Thu, 30 Apr 2026 12:48:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777517301;
	cv=pass; b=VHZ8NLV4k/ZHARNFpDOqc/JBFFNiald38LhfGwsKHh2QoMuPmkY9iNrqI+t+juCAh7pfMPvE0L3Olvy8P0oO53lp6eco4oJQB7TMOrjixsZUmgiOUu1F8aJmMNnD7AFSjP7sQaXuoB9r7FGhZMumcx5up601nfMEiGvlHRfgNaxlIerl9v7/1gPoTU7SQr3e2V/HMhaUNLKnl8H7e6ldLb5A+fKxoiwK2YUpRvxKljVYSkLFXgl1v/9yc9CJqW1/CXKqg6IFmrIRcdK78X7OBhdT719e1TWgwGw8QxW9RH0rp+y2/THYNe/X8EGILWFDc1lQbvRvGFcZtJT4jblCqA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777517301; c=relaxed/relaxed;
	bh=3F82EnJZj57Cir2Zm510gDyJbU7i2d3Vdu/nV0JQFYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h8gGvyxX7611GA2JQVq56c5HMW3SX/ydyKi43k3YdZds4kzuyWdP1e4F22S35C62O/6cyJrU228SV6CVyn/1I62poE9dLFxeSiY70KqF3xgFZuUMLbCb3IYVwYQQECC8sIHKlje83y3VDt1sDNWhFM9ImlZ9xh77+tktVZK7vXmaes3UX54c7WkjzJDtZBrUnpQvhUopj+mzwMmGkoqfqKSECoA2OvxJmoZ0D9OsT1Jx9yD9R3eZs3HomQ4b9SWiHgVNm1dpZT2Go4HeUZH8WN0NiAlYsN9HgJiVzSXStwCWfxVBe/9lnv8SlIicxQorpR1QkSFXgaD7ifevYaPsdw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ReJUT+GN; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ReJUT+GN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5ds00hYkz2yXj
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 12:48:20 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tfamf2PvLg1Zbfp9D8mkm0drF+uMPF9TgkZYJoqhcZ5GWxmIZPmVjzz4q0z5nX7/CDHXlkuEbd0v9Oj/6aGEs5KbMhFkTjC2TtVqIknnGglwaXmUnlnKTUjPKfLWKijpv0VHyqLhZ8ZZrGQG+5AqyqjY4jsUfI2RzDvdH2hxd5Iq71h2v9Mani/7PqhhR48RHcXAbnEldYW8rNcytzWXNs64zCYSpcDYvioVhP/cGMBt9UC1cgf+I7glFPMgud+T+eixs1IIRkxZkpfB19AwnN68AIRbUwpIdfpATzlq2h0fSbXOw5jCS1SAAhvpEhcVJrZdplgoFhZ0vT7J/AgJLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3F82EnJZj57Cir2Zm510gDyJbU7i2d3Vdu/nV0JQFYI=;
 b=iKwluJE+bY0a2ajV+bfHp5Qlxiz5NmjrIssPPLYmRpu4bS+WzQzbd57HNGXACLXS/dUPquIue8l2aiPCBs/xjK0Tm9zyJoTaOB0cZ7fViXPKsGVmfsBY9qU6QJI37AYeMgc3hktrcjJjfQK06ULU7xAq+GvF1sSoSs06KnYCSs6aqDb10gzz0qH6TqqT2sINgBgPMxS+pd5k1Xgvv5NVunM496LnWCJX2bHCZPg/kkiIMUu2652qjpTks8XlZpl91E7m/z4MOUllkIcMY1Jom755TnBUrcT5kZS7pYnos2jawCoPv0r7pqxn79WEwNCeyrgtMD9yMznHaaPQ28qxJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3F82EnJZj57Cir2Zm510gDyJbU7i2d3Vdu/nV0JQFYI=;
 b=ReJUT+GNc2AzB6fs49PxwD/lFdDud131FD5HQAwg/Gs9zvgbmaoKlUvoShCxnijpoviAoazDCIF6AgqMDatcjtw4vk2BBZ8xary448qdYgR84yQf9Z3aU35bnv/hc/drxQKK9cQRHj5mxc9fgAksSZNCT4f4XiSiobnz9xNVEt6jHS4roJJL+h912nJxfiw91DEz9YkhEgPdPmGvJF48z5kmkP5OO3JJrrthM3IXdRg1VZ1pRWeNGA5JxfnlruZSM41XC95Uddmp3M4RQcp28t0ugm3TUUpahnprF/sZ+JeEB0XGRk2jtC0Iohs6mJr0y3iNmVQK+KhcZw3g9SEDKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PAXPR04MB8608.eurprd04.prod.outlook.com (2603:10a6:102:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 02:48:15 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 02:48:15 +0000
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
Subject: [PATCH v5 net-next 07/15] net: enetc: add support for "Add" and "Delete" operations to IPFT
Date: Thu, 30 Apr 2026 10:49:37 +0800
Message-Id: <20260430024945.3413973-8-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6360fa2f-71c4-41da-c217-08dea662ed5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yX5bRZBzrIuisOsOtmBpB6RimZeiW+rQeIGSuJt8UX8+aM7nE4Mz0ncQeaBOgJGD3Gg+Q7k6Zb5dDujOUG6VyQbveUwPsiwzBhxXED3dvszIttuC35XTUAtjhA9cjqv1jEypN7ndTcykZd4EdN8ASjo2cz4FprcClbUsN+7fufo7La7XwLKfIidL2BfQPgTdE0uBfvvp+DsUNrAwWeo1onMjOHUZu4x+mtrLEm/HY42ggBVt+jW2YVZkGcBoZH6SBOHdv36ofDHV/Gm4ZN97AWpfJTjbW80aoRIw4Vf8oWj/WCtAC3/mf77bSEAV6FZpbqhkKv4NM5UOmRmjBpJHAuBonnuYzyyJN+f2xsw0ob3OVT48hNe28/Bg7koljtwnyuMxTJhjIfU4ZZzcUDPRR57V45Q5IL9sdZWvl5y62d1Bm9FvvXXOw1UT3C3E3RI0nsMMSEHjdwF1b93hBXB1iw9Fao540Jcvmbdo2H3O0LcUvUpAOd9t1c0AT3TKZw9SahHtg/MWKs/1weByU9RK7CyWP+s/4uMB5jYwgzhV/wygk6XClzBtl9bhIPar8K+3l7lXvQ4pwknuYNgItGOV/cCSGKitDCH90Hhtuf6UlTX1YQcmcEc1r7J0tUWx5tQSFg7N2tPV6LvkUjRKmi65AOxgkKgZEON8OHSTxBjjv006mYzdFsNr01zVt4yvkaXdCWvnMqa1xg7n5nz9q+u9mTQjCA2BiPSzhEGaL8Yq1ShMBIu5ROwawSi3g5XedD+Tl3ACugdbwCzppSZMM1OuZ1gQcm0fjnDQ8MuZGKPLHXe+mzKqqFAo2Xg8VkBLyMom
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f88wfRbBgZ2t3rxiE3DH9G4kE2eU8A/qXny9A9JUv0TqCsVMEE0bYO5czmjd?=
 =?us-ascii?Q?b7Tzw5VqecRW5mhI45qOQFPcOTUa8h5np3TBUr3nEO9FodFSamY3F0IS9JAj?=
 =?us-ascii?Q?ZkjgdLBOR6Dy2n7B1FaI+JBJqVbMlTbSYUg1oRhkmBPKnWe2SfA2Ki6jOxPl?=
 =?us-ascii?Q?OpRkc++CUUt96ScGNlUtnNJ96PETuLFz3VTIwLimPIgUOxQQXclIDj1Q+JmG?=
 =?us-ascii?Q?pTvT/fFaV8V/XhO0QUXt3hXgQlcB+HcdBmiWRoYcw8aUQkCc8L5opI7erqIO?=
 =?us-ascii?Q?JNuyeo6Ct9U4aWlNtmJJnT1f/J8p4TBoPrXT7vqpNu0bvjSFjNTpM/gwbhgI?=
 =?us-ascii?Q?iJKswIhSaQ+9C0wPU4NRrQ64D6KD4GpSehMP/bFQPp6HaxnJD8uL8WVxpLZM?=
 =?us-ascii?Q?sGoRBn4Mszpzzw7O/2NEsfmBdZ8Pl3iX4JzVarZJJE1sa/pGbsF0W/hNiOiT?=
 =?us-ascii?Q?kfpGdUCPyMbrlCJ4GJ4T4+332V/bV27aM8gBzeMly/3V0AdoSpQjdoi5cPhe?=
 =?us-ascii?Q?AhbdM4HdoZopcYwkdx6V3DHZJMkBUhRmBk651PkP1j3Zm3fUBOCtZJyr+695?=
 =?us-ascii?Q?vJ+SW/w3K1dvP0y6zXBxYFAZAX/p3VKPgi0MwpZXwciZsj4jfuuCu53L0S1y?=
 =?us-ascii?Q?dxU3rZ0WDA5ZWMnPeNl3wiX+wzJjWgTwBEHQTMx0qTrHH7xbqzwxq2S4KaAR?=
 =?us-ascii?Q?NnxhTa8MvJs5yMiLsixr4ymOUI+diBmYijWTiLDFTV31MZTGn6vfU3rF9BYL?=
 =?us-ascii?Q?kj3IFmjx4QOsxnzNvY4eXtmtcqGwYcb2YMfFyjM9vLOw7bqen4iv8pf0WLw/?=
 =?us-ascii?Q?SXzIFGIp0nInxIwYP5uA2wpIPEGi8YTLhFT6H5G2flj2mo6/XIAFIaByqKYO?=
 =?us-ascii?Q?k9IX9qkctHnd8qnufrh+f3MwFoRGxTrITcFuNS59WghcTlf1dSZ2AmaAO2Sk?=
 =?us-ascii?Q?+9mv8/8VycBfrppwFoWO5vKyrBaptRx9PcAS80udO/reg5GzLBYU1VLQEkya?=
 =?us-ascii?Q?CGU9cQEC458m+zlf+heJZY8XRYvCBtyizZ4oESwHW2CpLxWB0/kGWPZCGnLx?=
 =?us-ascii?Q?oSx1vfXiLrCdY+bGrocE3Z4sGYz+Lys4ceetckHgwVGnQPxIqwZ9cFimIdUz?=
 =?us-ascii?Q?mhmLt9Fw86RsjOxmz/do2tN50esmSAufObotErrekjBC1ytltB+XvOaB+0ub?=
 =?us-ascii?Q?54yeKAB4QFiUT9vjaUIeQFcCylLMWyCsYoM6j9GFVDZLeeBoEawrQNorkXIE?=
 =?us-ascii?Q?uFRziueAsNfeXTz77K+TmRuKR7wU46lnKrQgDjFrEPkAZkkbqcJvMy2pyovQ?=
 =?us-ascii?Q?3B5mGKa1mgKGpZyzoqAHPRyEpnz2rwycppvz4tfQOGvT3Wu+BSRjK45q/wrL?=
 =?us-ascii?Q?OrkTAvvGsXSZ5RPCIKvvgJtWdf2V6o40nF/PxU22aRVwKf/36e0uxdrg6Dol?=
 =?us-ascii?Q?Cg9m2bIepf29XokBIjuwiJNyI9c3eCwnasA261E+bwPL+hLbSxHglNCyYwaR?=
 =?us-ascii?Q?NuYXRqud4icQgQFxscB8+58RLqYV5Raagq78COvNtnf0ckrlxe1PUoPcdISp?=
 =?us-ascii?Q?levhddb6tX7PlE9hLaVJYxuQvISJO4drlyXif0tVtyx/9f7tVolr/KUpVIMb?=
 =?us-ascii?Q?XertPhl8A3hVWDjHd5qW6+6z23OwOePj8P89fZMl06WpjipzEsT3N9EoI+XH?=
 =?us-ascii?Q?oDx+tDxfJnYUdLxUf83xM1FfuF9Y2l5OJg288DNz0wLVO4mu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6360fa2f-71c4-41da-c217-08dea662ed5d
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 02:48:15.3275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vD2IMnTJBY9vAs1+vc2paoyn0zcadWSeCWNEGPwFZYlje3LcTnyqkNtHCUJVU2wU2zwgNpcPtet9EllPNOyj0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8608

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
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 76 +++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   | 36 +++++++
 include/linux/fsl/ntmp.h                      | 93 +++++++++++++++++++
 3 files changed, 205 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 39d7a14a8bef..add8e30a6061 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -21,6 +21,7 @@
 /* Define NTMP Table ID */
 #define NTMP_MAFT_ID			1
 #define NTMP_RSST_ID			3
+#define NTMP_IPFT_ID			13
 #define NTMP_FDBT_ID			15
 #define NTMP_VFT_ID			18
 #define NTMP_BPT_ID			41
@@ -269,6 +270,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "MAC Address Filter Table";
 	case NTMP_RSST_ID:
 		return "RSS Table";
+	case NTMP_IPFT_ID:
+		return "Ingress Port Filter Table";
 	case NTMP_FDBT_ID:
 		return "FDB Table";
 	case NTMP_VFT_ID:
@@ -511,6 +514,79 @@ int ntmp_rsst_query_entry(struct ntmp_user *user, u32 *table, int count)
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
+	struct ipft_resp_query *resp;
+	struct ipft_req_ua *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*resp);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	ntmp_fill_crd(&req->crd, user->tbl.ipft_ver, NTMP_QA_ENTRY_ID,
+		      NTMP_GEN_UA_CFGEU | NTMP_GEN_UA_STSEU);
+	req->ak.keye = entry->keye;
+	req->cfge = entry->cfge;
+
+	len = NTMP_LEN(sizeof(*req), swcbd.size);
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_IPFT_ID,
+			      NTMP_CMD_AQ, NTMP_AM_TERNARY_KEY);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err) {
+		dev_err(user->dev, "Failed to add %s entry, err: %pe\n",
+			ntmp_table_name(NTMP_IPFT_ID), ERR_PTR(err));
+
+		goto unlock_cbdr;
+	}
+
+	resp = (struct ipft_resp_query *)req;
+	entry->entry_id = le32_to_cpu(resp->entry_id);
+
+unlock_cbdr:
+	ntmp_unlock_cbdr(cbdr);
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
index 64df49e9a3ef..0a9b87286105 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -99,6 +99,42 @@ struct rsst_req_update {
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
index d74714a402f6..f68551045b60 100644
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
 
 struct netc_swcbd {
@@ -73,6 +75,94 @@ struct maft_entry_data {
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
+#define IPFT_DSCP_MASK		GENMASK(11, 6)
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
@@ -162,6 +252,9 @@ int ntmp_rsst_update_entry(struct ntmp_user *user, const u32 *table,
 			   int count);
 int ntmp_rsst_query_entry(struct ntmp_user *user,
 			  u32 *table, int count);
+int ntmp_ipft_add_entry(struct ntmp_user *user,
+			struct ipft_entry_data *entry);
+int ntmp_ipft_delete_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
 			const struct fdbt_keye_data *keye,
 			const struct fdbt_cfge_data *cfge);
-- 
2.34.1



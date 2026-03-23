Return-Path: <linuxppc-dev+bounces-18575-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD25D58CDD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 06:07:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffN412gKdz2ySc;
	Mon, 23 Mar 2026 17:07:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774246033;
	cv=pass; b=MXvzcGMGdiDwK9TZR9sGkEJwmMUhNXJGwYRe92xs19r8xHv8GqAfbkeNYZ7qwu8CNipds9qPIOu+JfwL4L5ENq4iN1Dz1VRbp/3cvwF2N14icFWb3ovyGRVWIRqz42Z3aTJ2ubRSRkpQvhf2qHMpMtaC+yTw0DcrjrVGS0nYg8vgB+lGFYd3sr3lnQ0SDAKbjzcZH9gBiC3de/Clgya4NUQ2SF/H4V9HZZvX81lamDQzcINM+Qx0nxlQ/m8baO7yZ8dec6SbTK5EhHqHz30OT7pnCCdv5LV9/26jW80ciGwDaZFWr3kxtTuDUAs/zr9AR9ghM69zzhT42WwqTUlBIQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774246033; c=relaxed/relaxed;
	bh=04MC9DKeiJNQWmiQVCBlARtp6YQElKTmx28dmv44TNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MOLJ2jjiZ6JPBNlKma/ph2l2M9Mv33/76iIlFJtmxkrz1nRSEFMr2cPxCdg4ct9BERY4bvZ5gb2Nb4W9lcdQtYLAHNaM+G8yMZC7aW8QlXVMYoilYr1Rpha0TpBVjmcw+jzLGxmRw1fWAgfAcYIdSiQKbbZAlIEg/HgYh7ygoxpKu13WqsuoL/HX/3OlXyoEB2OdU///IjWwAwTHh4dycp7Xe5Kw/YyOigCgcnWzoxspjLIoOnNsoso1HHr3XLx/DDGHGFLvx5Cflhwu8G4TB56zeOuCV8HDJHtndjkLHCcpgo8nngSbNfZXRNHpD7lO/UmnSRq0yWAEqvOQDFpzmg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=aBcAMcGT; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=aBcAMcGT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffN402dTxz2yfs
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 17:07:12 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cg5lPV/xA8seJshoyuGzSmfbNxGVDDMkPYxMdY5DbsdlpG+LH2HDeSDj+zCYcPvCNAM7VCr2SwQ0ZLmTOT/f2mai0yPWQskSHDLieLaZgp0T9/EaZvQR9Sote0U1kZ8tywqJdib6D3eExMHpPywJjXbrBTgypRhZiTnccbFbBwqQuC978s++mk1+4pkANX2xCTWJsuXFHIh4S6j5NXbtLCXujWPIhWreRDzBq2yfwNi1ckreV9HzATvPwnI89oD2J0Jmg4psa9guwYxYjM3bB1xIaPB9460udA8rp1QjO9hJrExmZTNHQeOp7Vxr6AM1xWFRkFWmmg7uJAAKgBBTxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04MC9DKeiJNQWmiQVCBlARtp6YQElKTmx28dmv44TNc=;
 b=hwj7v/YiDWLBWk6EBexZUnUi9gXJna/yyVqEj4VKvAXK0iqwITuPofkHzmRWHEWLkP9GKwjiJufnEa8RjIZ0LZYzuYEw96D34Gxr5xLC8Ds/POUxQPsiZj4xAIKkflWbqahTwhF82yc0/Z8AaWU41p7kLVUjZkAMvw/4IJoCnUAe0qhwCeWlyTNIpoPcDZKYzeHPnkz2CxQ5pJX5dKugKvwkJs0USToD6Zi7ly2U+D1lI0sDxC339fpTlSO3tynCkMSkmZV17NdqNhLF6uBIFzYddLgmVhwxZD1kM3Tzz3COzmB6Fo0YTg/EtdKsaY8LJX+JvTz/7hX/Gu8IA3BsPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04MC9DKeiJNQWmiQVCBlARtp6YQElKTmx28dmv44TNc=;
 b=aBcAMcGTB7ZpJjV+seBGeT16KZDzzNyp5PKmY7QyLtL/RQuHaFsg3UgVpNvFAK44Y8qBrCLYSrZpqgVaA86+LxUuk1wB/0Cruj/6P4cAzgo5XwaZaI9SYvqMqyw/Wi5y5DB9XtCADDxA61GMZnOEMIWA3naRJItvuXp+JdHIN2a0RCuNBl96Mqwc0n0R94R4nBMmVQajzwUwv7bf1HQ5Wr6mAL6vvIxTpO5KM4pMArlAmX3Tk2n6/sRLarOgZ1ldu+Uc3uGk+ZtBckPgZlsH7Ammpm3pFHaRiLi3YAVTVgtz4nAXrYqujGd47WnFp7uKgvzY5/pEA5JLwd0BRWKQKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by PAXPR04MB8911.eurprd04.prod.outlook.com (2603:10a6:102:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 06:06:25 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 06:06:49 +0000
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
Subject: [PATCH v2 net-next 06/14] net: enetc: add support for the "Update" operation to buffer pool table
Date: Mon, 23 Mar 2026 14:07:44 +0800
Message-Id: <20260323060752.1157031-7-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3d701a6f-4919-4232-b0bd-08de88a25eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|921020|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	d1ida/3QjTmS9qj9Y5bUSrmxavh5N2mX6nUHVEWTDWcfbk3vSJLRHfsH0MypY6UlJscOBOUYx5GHeOqnvu6K44/laGRZidWGcaJiGgboB0aK7ZD6J9qLkIBg3e6t0bLTnMMyqCpTWZJpIBSUIcrc9TV1xMppvNZt4CKD5igI/DR6kwTc6IUotROWpveLeEoZTbBKXhnWkTw1nhr70pQ2D/7wCFA8AOGtXKfdYlOlJ1DcQnYTXOfmbl9GasvIeZjQhawY5aIqnCUpi01OxFb5n/417SKxQAMlDyxZYn8uMBnKFPGLbr+jjEqO+NDVC9jkjTG6+NIjdoneMjaLuEOy2vpxYZTvI+piawu8SiDwQphXghSgcvhFCULFux84ch3WvGvZnKdARQSRt1Vq8VI/9C06WNijSsSJz7R2Q1ZpmFP1z1xVbJj6N1OvBWFOf/pu0OvDpL7KHxlusK1K4pr+XUhpJvJ0puV9Ulp/QuyDvKUeTRARg9zFjt3d7zFJpQbhx0MlfShDdKprtn57IsbVQvjDOyCSQOMLIDAnRRh0AdybhXzxjd9zRks+qPXE6UmybCPLa3TkfvxSgAb7iFBIiI8e/VivqrzACY0BEAwR+rAS/2z0L8QpoZVyrcs4fPUu/m4RebKCeZObIxdGiP8qfE8cM9DmNHqFDc/9GrdojV+oIGWsEaeMcSE9hcgJX1pFlAR6QhT2ZIXUOfBfjDgXK/gBfjeDc1uHw70FZkZWWcmYP6bg5sU81GxKTbt8Te+juW0TqukH4fBCksbwZxTP/hFf7kSA9cHVeY8dQ1EETybPiYmMHcIvrm7YPifrqvKq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(921020)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nnjnXBm2DbN6MZZJ8mdQyR36ZBamPdDP07i7a6LdwKw09ZGcJthNs1M4GiLd?=
 =?us-ascii?Q?kv08H4rUdF54yRmD1ZNseK+AF1Keowb3UlypGjPHUwuSMJc9105pqG4OvTxe?=
 =?us-ascii?Q?+ApIZFlyGhUS9ZyL3DLpCNc+MqloPNmEmg+T1a+Nw4f3DW6XY2jVlWzMWlE3?=
 =?us-ascii?Q?iAcOD0YTsNya172Op6+qs19u7m6+9VYBVjID4NaSdt3mk2HEexR/PB4Fw9WY?=
 =?us-ascii?Q?lCSaEwu3j787KYQKq9nA2RsqYyrSBLAhnj6TM0C3iQkMEsUsqtOEpyC6tzBh?=
 =?us-ascii?Q?UESiSB7U/PHiznl8E/dlE1W8R1tprNP++Z+26OCwYHzzXJTShE5GSP96651v?=
 =?us-ascii?Q?Lium7gz4osGNaspToeBdZ9L2ns7n4qez73RbXjkdvY307QBmAskffilutDov?=
 =?us-ascii?Q?b0KeuZLFSRDJlblqFJAIeG55OCtLHnQGRutiafCfWD1ERS2n5E520/xiBWFE?=
 =?us-ascii?Q?BTclvFRsN3/Gjiwn1iAniMEpn8yBCFDzoWQmtiCIrZPa/ow2/+oyGGPOm7S5?=
 =?us-ascii?Q?f4F7OR9lj7E90ZK0JvOmVcMtMpfUaZ6ZsyHzSf089rEaimn5Z1JcRfIEP86g?=
 =?us-ascii?Q?ZZSvRe514mR41E8i3ml0PDtg2k2seLxbZQU4ugmjUNBGmokCsLTG0RYyX0GV?=
 =?us-ascii?Q?yNAcct0uKUCUWnqdmiyC4fRdnlbz66z9bNI3YLhQ1hJPyqGgQ+4CizMyo4o/?=
 =?us-ascii?Q?P0ZuN0lrH4ceH2jiV5rxoUds4m+QcNKKSkcjfk3Nm4aF6Eesc/+7I2JTzdom?=
 =?us-ascii?Q?XhMzgN5UBO9QmL1fWc+eYwaxBKRK0bt0a55ntTmBB3E+bM044w1VsZ5xdE7l?=
 =?us-ascii?Q?EYIZtJdQscSWaAhb1PEXJbLUYwh4nJsKcdzfCDh4hcrPr+iysgcGfBkR6Fin?=
 =?us-ascii?Q?HTmqJ1Ch7QFsJjhLNHkAY0p3xWlfDHZKhxUWtv1nFNIfboXlK+kcicp8fX+w?=
 =?us-ascii?Q?Sfu3jRxFSJNxuOPGzvaiR7p3yFxbqtvFRxe/5YrEZVlmXMYGLfuk4hTNOW2s?=
 =?us-ascii?Q?ZFdVE0BaTOgPqJE7aOrMXFR28GBy92BOLg2eWskhK9Z1o2zrVXHl67aeJj48?=
 =?us-ascii?Q?D5ARbyEjHrPOSWYt1Uz7UfWvTwRdPFA+K5w9qAjKx8vCAtg4U3twPaQy2k06?=
 =?us-ascii?Q?LiwGc2dn1vuCyfYXP0Sl+A61aq4cOytsI1CW+NRHeC7B40qglv1eFyfFoiuP?=
 =?us-ascii?Q?0xohpzjOGi5EFze23odtsSkIXHcvQgyrck3WY3i7IdKfX7jGDnXzF727YoXr?=
 =?us-ascii?Q?DFlpK7zCv+vnfS9XLygIdU1BMbIE2iP6okts+4vZDg1J0muEZz7ZXi9CWA0c?=
 =?us-ascii?Q?9bnCKAakkHi/WMSoFO9WSbvfkWqS6/3z44+fLR3O+JEnxvTkRzdkin81I1OT?=
 =?us-ascii?Q?7cRfD7YiivibavVlMHNkExx5Tll9cxWulK8IE2/4NN92ZLiNYJt3UjfuXQSv?=
 =?us-ascii?Q?gF0dey+jvx4M6l0Qg7Ga1fE+68iNDr4zkprlbiW//WKggB3DsWP6sbetm9ne?=
 =?us-ascii?Q?Sr33+RoiW4xL0bxkjnAmTcqkcyWOd2TX/EX1DYcktyvxDlI0jZAee4VZ7Amn?=
 =?us-ascii?Q?v8bP+UK2J548PP+v5vCvDsD1JzpRaEs0F5LFrp1S/TMWlW6KyxDLDd/kQnt5?=
 =?us-ascii?Q?J89OpDZl+YirpqoyktwoI8FMZ+9iYxE1qfjxUETlc9PtZiGypi4r+j/YptpT?=
 =?us-ascii?Q?617peS236ylDA4PVAMBe09i6/WYMMn3CEcr9vpplrGS9+tbG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d701a6f-4919-4232-b0bd-08de88a25eb3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 06:06:49.3525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68plBwLTVjRvtPlU/6d1Qzw3rJpHZ9eLfWoV/QHBl7QBzwNqZ+gpr1RdP2gh9z/jvu3EJjKSsEEr3z0l1XPSrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8911

The buffer pool table contains buffer pool configuration and operational
information. Each entry corresponds to a buffer pool. The Entry ID value
represents the buffer pool ID to access.

The buffer pool table is a static bounded index table, buffer pools are
always present and enabled. It only supports Update and Query operations,
This patch only adds ntmp_bpt_update_entry() helper to support updating
the specified entry of the buffer pool table. Query action to the table
will be added in the future.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 39 +++++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   |  6 +++
 include/linux/fsl/ntmp.h                      | 32 +++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index e8c94157ceb1..ef38ebe94da8 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -22,11 +22,15 @@
 #define NTMP_RSST_ID			3
 #define NTMP_FDBT_ID			15
 #define NTMP_VFT_ID			18
+#define NTMP_BPT_ID			41
 
 /* Generic Update Actions for most tables */
 #define NTMP_GEN_UA_CFGEU		BIT(0)
 #define NTMP_GEN_UA_STSEU		BIT(1)
 
+/* Specific Update Actions for some tables */
+#define BPT_UA_BPSEU			BIT(1)
+
 /* Query Action: 0: Full query, 1: Only query entry ID */
 #define NTMP_QA_ENTRY_ID		1
 
@@ -234,6 +238,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "FDB Table";
 	case NTMP_VFT_ID:
 		return "VLAN Filter Table";
+	case NTMP_BPT_ID:
+		return "Buffer Pool Table";
 	default:
 		return "Unknown Table";
 	}
@@ -702,5 +708,38 @@ int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 }
 EXPORT_SYMBOL_GPL(ntmp_vft_add_entry);
 
+int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
+			  const struct bpt_cfge_data *cfge)
+{
+	struct ntmp_dma_buf data = {
+		.dev = user->dev,
+		.size = sizeof(struct bpt_req_update),
+	};
+	struct bpt_req_update *req;
+	union netc_cbd cbd;
+	int err;
+
+	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	if (err)
+		return err;
+
+	ntmp_fill_crd_eid(&req->rbe, user->tbl.bpt_ver, 0,
+			  NTMP_GEN_UA_CFGEU | BPT_UA_BPSEU, entry_id);
+	req->cfge = *cfge;
+	ntmp_fill_request_hdr(&cbd, data.dma, NTMP_LEN(data.size, 0),
+			      NTMP_BPT_ID, NTMP_CMD_UPDATE, NTMP_AM_ENTRY_ID);
+
+	err = netc_xmit_ntmp_cmd(user, &cbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to update %s entry 0x%x, err: %pe\n",
+			ntmp_table_name(NTMP_BPT_ID), entry_id, ERR_PTR(err));
+
+	ntmp_free_data_mem(&data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_bpt_update_entry);
+
 MODULE_DESCRIPTION("NXP NETC Library");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 8f94572eaf0d..c5f6dca7b660 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -179,4 +179,10 @@ struct vft_req_ua {
 	struct vft_cfge_data cfge;
 };
 
+/* Buffer Pool Table Request Data Buffer Format of Update action */
+struct bpt_req_update {
+	struct ntmp_req_by_eid rbe;
+	struct bpt_cfge_data cfge;
+};
+
 #endif
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 6fb2c8c525de..925a455935b0 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -33,6 +33,7 @@ struct netc_tbl_vers {
 	u8 rsst_ver;
 	u8 fdbt_ver;
 	u8 vft_ver;
+	u8 bpt_ver;
 };
 
 struct netc_cbdr {
@@ -116,6 +117,29 @@ struct vft_cfge_data {
 	__le32 et_eid;
 };
 
+struct bpt_bpse_data {
+	__le32 amount_used;
+	__le32 amount_used_hwm;
+	u8 bpd_fc_state;
+#define BPT_FC_STATE		BIT(0)
+#define BPT_BPD			BIT(1)
+} __packed;
+
+struct bpt_cfge_data {
+	u8 fccfg_sbpen;
+#define BPT_SBP_EN		BIT(0)
+#define BPT_FC_CFG		GENMASK(2, 1)
+#define BPT_FC_CFG_EN_BPFC	1
+	u8 pfc_vector;
+	__le16 max_thresh;
+	__le16 fc_on_thresh;
+	__le16 fc_off_thresh;
+	__le16 sbp_thresh;
+	__le16 resv;
+	__le32 sbp_eid;
+	__le32 fc_ports;
+};
+
 #if IS_ENABLED(CONFIG_NXP_NETC_LIB)
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs);
@@ -142,6 +166,8 @@ int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 				struct fdbt_entry_data *entry);
 int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 		       const struct vft_cfge_data *cfge);
+int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
+			  const struct bpt_cfge_data *cfge);
 #else
 static inline int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 				 const struct netc_cbdr_regs *regs)
@@ -213,6 +239,12 @@ static inline int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 	return 0;
 }
 
+static inline int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
+					const struct bpt_cfge_data *cfge)
+{
+	return 0;
+}
+
 #endif
 
 #endif
-- 
2.34.1



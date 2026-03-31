Return-Path: <linuxppc-dev+bounces-19070-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7E41061B32
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 11:29:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flQqp4BhZz2ydQ;
	Tue, 31 Mar 2026 22:29:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774956550;
	cv=pass; b=izG5FG9vGEq//xsjY5j84iOqoO17ceUTx3inb3MXaUD2nF6gL9+ojGOzLoT1nIVgYA//n4fdSUqtYaFW1eTY4Op8mY6BxYiqOMVqc1YP1atKzBryJb6ahX8zS/g51d51Yc7ps7gF3lHCYx6M4NPuIJugqLLL+zC9HOZW5kAsQggFdfD2OWZXnAO18is6FP70n9t0JDu/rAr3WFNAa2CrSqdTT/w8mA2DWbjTECU5W5/b8n2OyiudoW2BBxLtH1004m/JbNxOitQg9cuXyfwta+mx9xipbLFx/pPVqhHhCKSDNHX3g4tJQapFtpTYj7M69PqK3OgSyBDLErEHLTR6gA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774956550; c=relaxed/relaxed;
	bh=3ZeZ3dPwS0u+xryUhVkkEBmIqoBeIJKKHZEGRC4U5Ck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EvWd1C6DwSEqPpBBIT5LdXpru5fb3Vk8xoXVQNpdR75iF1/hsmtmEBjVs+tiVercpiMY+iazRYshEz6tFT/b0MvcOyqR4ETwamkpT57s9Ri6qA6DHZ5RgbYFgWfopqEUaI2joM/h2wjCU0l6bi6J1npG50E9mxCPn1O5uMLXe5aPZ+lDu3ssD8wcbmZgcjS8h3Ir6jZ3pCiqQe+tpZnKDcsvVjwC3jFKRyrc2ZYajJel/syBQWLYSSOzApNOMCOtouww47MLn5M6B/RaPijQFQU9FzO0L4dPEn3WceMGCflQub1cmy4nZMiyF6v41GCEWZGv/H78brpvvlDNrThtbQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=hWy73E0p; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=hWy73E0p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flQqn4pWTz2ybQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 22:29:09 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3PYjR1iNbIJQPNQquS5IMQXgww43FVtDAkRaps76suMgNfLuR6CAHOpds4cynWCf7jxXkVDiMOYC2Tq0fBDaqlnui1bczdaCM25aIIV/7yNHOrMuZ3vbCi7UAOhH0BPGo1HzLluNA7VxZWkNUggueD9sGa7JApuhtkrfZZ3xk4vFKQVn1K7DCIG9PLgc0Gvk5nwCtHMuUKfKR102Fx8hZ6y2bgOPM7iQdEjG25rITcrTzG4XLTAuYHzkVlL8Gy2NBhSNfKc0udkQgDwXIHQwLZdNFeR1dnpY6NME2I6eRxGmaq153ZnwRsGaDsAIgfddkNhtRZIKGICCmSqLw2XLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZeZ3dPwS0u+xryUhVkkEBmIqoBeIJKKHZEGRC4U5Ck=;
 b=BDh1dFMgfgOpsDwmB9tnE+7b2ctSdRxL8OYzLmwyFLNkj7oKzzWy933U8GPOz3cv9GXD6PhrjeRheUofuT9Zl3CfSGznubEkx0GqBcynwe2Zo6ICazOi0Xxi/NBXe2biVdf0l23RyfBeM+uUVKERI4Rwj17xcjFpbDTlijDrw4uWF0bgL3QR/smMFKbExyx/GFaFinZczpNcVMki1bCdEOMswr943lNviIoW9cIPr+xySWgqh84kLHebj6ib06tVahJODjExb2Yjrg5dnab8yUBXm0fSRspSQbIW64XpG1dTKa0WOyov4a5ZkzjNy2xB+e7X8AT4YadTAHyRDAiL+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZeZ3dPwS0u+xryUhVkkEBmIqoBeIJKKHZEGRC4U5Ck=;
 b=hWy73E0pRWOiZcN62jQVrSjx7WstBrKpB9iltv9pBc+tuuag/+/Sq1B4PtmZKf+CQo8aNb0wh6a7PTnPihr5NhR9DvA92vOAqNtqbXBqcqWnppBNPKI1MesTBOQNgji2kiEWLsImRYUM0nDwpNszTRKdtWNThgjB9M5Nh9ETTiEjqFjEXC7ZK0AwCdxuriGYyl42s8a/E0tffd87sbuy7g6ztQmIxhynFegCZd3B75z+hyKGwgJva8xem7uq7Y9iQaaCzn28m+q0bAJmTveKbMoKmRFte9T5Ba0r/BMWMeKa24SgtsaIgQ4iY0T01NvewFYhtIO1mwsx5SS2x9Nt7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by PA1PR04MB11406.eurprd04.prod.outlook.com (2603:10a6:102:4f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 11:29:06 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 11:29:06 +0000
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
Subject: [PATCH v4 net-next 05/14] net: enetc: add support for the "Add" operation to VLAN filter table
Date: Tue, 31 Mar 2026 19:30:16 +0800
Message-Id: <20260331113025.1566878-6-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e242f238-09bc-447f-24f8-08de8f18b81f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|366016|7416014|1800799024|18002099003|56012099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	50ZZwgKXsYrn0f7wPj4gNCbXN6cgGQ4V0cIm7vmv/2lXfyFUCkUHzXzTITsyVlRWfReuiIg04q2HrBGXif5jm+h7ucR1hYUGry0A+V662BUFH9DZ3x9MuRXTeMt4s1O37waFYivusyfNdM3o4Cmoq3zGR+K+Op/NW/gCRKJ4Urg3YU7Ei2DKCNGNlM00DnczNRboHfZif9OrNKxaBbFe1z5aLtub6ZNmuuFzbUkUviQ1lzs4EpcPBD5MJN415BC2zO2S2VlbX3RILdSA5NkUarJLzg60QO36WtQhs4UcFH5wNQNVEZgtHxVsXkyhpg7wpiNGRFjDzsW3vV1xLZSmMLnHB+7lftygmjYSGFKVvr3kbjln/ClhRwh8S95C6RIXVQmSxeAejLqU8AEaOGrFQ2uP+Xo+Oaad6BtblwuwixPR40GZ4Fqc1b6a0jb7T3jQWUKHz8za00Dg1KF5wR3347619gdOUO9aW/Zzb/O4G/KRuAttNwb0zgQJjoxZMdz3tF1aLXSS/pDImnLEWDxcE9b/W8Xi6XxxD89YsEO/hehQqm63YkN3NZWrBOmYGapNk+zVU00iFyTs0+AjK5dU1/jzLj4elon0ZB52X8YBVfuHrLo9ZJq0Lu8fJQexX5RViSu+bn0YcU443AVdsLrjtF7qTp5Tn8Wau4s49NDB4ZwhyPU0rMJBvyOrXiMV/Ey3kUZDmXgsplV+pogAdLZVs0D1aBludaKCfdZNgJEorDd9pPUduHeSZ3tQg2dkRumc1rF/dRNZhD9JSaHx67ny1OeFLcrwxwUAdVNnS07r9/vEw4VxW/wfsKJTm/mYs2F2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(366016)(7416014)(1800799024)(18002099003)(56012099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YxMWn8G9ALreC6/xMRj0qEygsv2lLV3VuoTv4+rBYmuX1oMDhx0qRLzPTdB0?=
 =?us-ascii?Q?SRpgqyOOJi4vZsadC0yBY9QhOFApfzT7ppECdEHYwtgJshfxD5+/TnfyjsWE?=
 =?us-ascii?Q?bqU4tixqOsjEFevw8DY9JIEETSrdRKfbRZNSY5pvlzlWhRuCsU2o2mkARf2v?=
 =?us-ascii?Q?V+8S8io3sXkVCk/q61itQ1Ap/EE8g3k8VA8DRVgl7up/tvX7dsitjj/hboWo?=
 =?us-ascii?Q?ixXbxsqkF+uiqBL4IG0wFtRQPqQGEN/hle1jHAb1d5joiGoDgnDqnd681Pz9?=
 =?us-ascii?Q?y0ydFkmERn8p5GgY9jy0u2bI/d2343Y+++XoCvWBJNpT+sY9V3BFT477FMxJ?=
 =?us-ascii?Q?yMgHdsrn1/1r60RzJrs5/TtSxOhNpWscY450Qv2TKhixwVTIn1BxQKv1oOsW?=
 =?us-ascii?Q?MqE3o2NzDgbRzlKWU5fr0/Hi646gcLZt72nPOfmJve+xeQj6cwvITgbUpT39?=
 =?us-ascii?Q?taROUKPt/hs1ZPdxolVzIellKx+4z63aUJMWsNhNsma5tHUQbnLsKWtFyJMa?=
 =?us-ascii?Q?lAbBX9S3fxz14vJuomT8cEBTd9m4ZHPf3nkgXN07uoNGvHc6CKAbw2M5egZZ?=
 =?us-ascii?Q?F+JU+/POWrMLpT7zaS/VFpkGF/L5mHKRNFBB+9yjOmpkfngpNI2yyeuk3lSR?=
 =?us-ascii?Q?HvSM6qbCs2zZ/1r7cq2enAHHpskLkgcs09qe8dY3vdC+0UJED7s7p+/fh+ju?=
 =?us-ascii?Q?RAgZO8B4zn1PNoQi536jRDEUck4o2887u26OVKa556gUitPXzkZ50x3EyeC1?=
 =?us-ascii?Q?iGmbqL0WuqyRgxk1x/ea3SMtXbXbj9I00C2REUHx8LQaEz6gufYcTzqEIBmn?=
 =?us-ascii?Q?6hJG94CidA6Two9gKSZtQkl+Gqm1Z9QtCNr1WHp5RBxjYIMx6XExC2Oa1L4t?=
 =?us-ascii?Q?0xW4y/6I6Y3db+hdmKXiuKZg4Lu5vVMVIWAUoPfqBYfq5t7nuOnRV+r1f1Q9?=
 =?us-ascii?Q?9rHij1SFEKcGQrO5zgyyOk33Pv9ovLQCGii+IZ14+tCYWGnaBwyN9D1cEVfW?=
 =?us-ascii?Q?OsGGzkGuq7LaCq6UbYJd3ImdaokeUboo0cl5RwQac99WRbVNX33pQo9Iw4ei?=
 =?us-ascii?Q?4eztvnM5WDQ3ihn+mFTga3j3t/jUqIsZYhfb8Xm2OKDajKqpYeZ8etbzkqJa?=
 =?us-ascii?Q?77PPg56oyz9CKd9BtfElW22nwO+M9oaQpDHCew7PZMKDSz6+oHTFML9rZyu9?=
 =?us-ascii?Q?FPTo3QDsQC3uRniH0alocNXpgCAYiti/8UEUAI91VjO8zKiyDylOAtrt8zhq?=
 =?us-ascii?Q?TtzixT28Nj+cxdoHeLpDkLr5h3YtER7CeFhd3/r5WbX8CFjhIYXLjV98DNWw?=
 =?us-ascii?Q?Cr1hafBHpKYVBRYbLlqTULnvQsnJAd9DWDvhArB1UfrHCa2B4cZsbs8CHc9R?=
 =?us-ascii?Q?MtPDnj2vW7/l8XQNa9/ImrWn06AnmHeDvx9zItLCEA1dhXWJyQv7rhz+Vpd1?=
 =?us-ascii?Q?+pnZZRI0d0OsdcAy7B5o4IKh1g1h2PeX1MUz/CFGIqup4+emJdqVMEeevPC0?=
 =?us-ascii?Q?Yc3WVrGa0hlbCpLvQ75mllzVs7r6yucMbqwrHTa6yEqdRIxOrvXcZoH9L/Hh?=
 =?us-ascii?Q?ep4BI0IT3KrI43pBUncamHxikPMEUJh1bZLQ39BN/7jWgI/NCgvw9x6qeKdC?=
 =?us-ascii?Q?K1TpNQ8ww/yEqZMvFTW/ygyTyXzqvdG5LOxr/I0nosPhqLPVUQ2HLs8HpvB2?=
 =?us-ascii?Q?zXyU7f1qQDmdamZyjxdBjmILpwfmmZSV6LdkdLw2InVySRJE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e242f238-09bc-447f-24f8-08de8f18b81f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 11:29:06.5453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8xUrn/vEd5Zze0KtjyorVw6rri/94coqaxStv107K5cdCdnby7TUqsQvgNntomTLSs+VXz2b4pNs08bM7x3hOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11406

The VLAN filter table contains configuration and control information for
each VLAN configured on the switch. Each VLAN entry includes the VLAN
port membership, which FID to use in the FDB lookup, which spanning tree
group to use, the egress frame modification actions to apply to a frame
exiting form this VLAN, and various configuration and control parameters
for this VLAN.

The VLAN filter table can only be managed by the command BD ring using
table management protocol version 2.0. The table supports Add, Delete,
Update and Query operations. And the table supports 3 access methods:
Entry ID, Exact Match Key Element and Search. But currently we only add
the ntmp_vft_add_entry() helper to support the upcoming switch driver to
add an entry to the VLAN filter table. Other interfaces will be added in
the future.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 50 +++++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   | 19 +++++++
 include/linux/fsl/ntmp.h                      | 30 +++++++++++
 3 files changed, 99 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index a4a99954baf2..d7d8a37078d1 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -21,6 +21,7 @@
 #define NTMP_MAFT_ID			1
 #define NTMP_RSST_ID			3
 #define NTMP_FDBT_ID			15
+#define NTMP_VFT_ID			18
 
 /* Generic Update Actions for most tables */
 #define NTMP_GEN_UA_CFGEU		BIT(0)
@@ -231,6 +232,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "RSS Table";
 	case NTMP_FDBT_ID:
 		return "FDB Table";
+	case NTMP_VFT_ID:
+		return "VLAN Filter Table";
 	default:
 		return "Unknown Table";
 	}
@@ -652,5 +655,52 @@ int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 }
 EXPORT_SYMBOL_GPL(ntmp_fdbt_search_port_entry);
 
+/**
+ * ntmp_vft_add_entry - add an entry into the VLAN filter table
+ * @user: target ntmp_user struct
+ * @vid: VLAN ID
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
+		       const struct vft_cfge_data *cfge)
+{
+	struct ntmp_dma_buf data = {
+		.dev = user->dev,
+		.size = sizeof(struct vft_req_ua),
+	};
+	struct vft_req_ua *req;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.vft_ver, 0,
+		      NTMP_GEN_UA_CFGEU);
+	req->ak.exact.vid = cpu_to_le16(vid);
+	req->cfge = *cfge;
+
+	/* Request header */
+	len = NTMP_LEN(data.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, data.dma, len, NTMP_VFT_ID,
+			      NTMP_CMD_ADD, NTMP_AM_EXACT_KEY);
+
+	err = netc_xmit_ntmp_cmd(user, &cbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to add %s entry, vid: %u, err: %pe\n",
+			ntmp_table_name(NTMP_VFT_ID), vid, ERR_PTR(err));
+
+	ntmp_free_data_mem(&data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_vft_add_entry);
+
 MODULE_DESCRIPTION("NXP NETC Library");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 8999eafe1920..d2a6399b0a36 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -160,4 +160,23 @@ struct fdbt_resp_query {
 	u8 resv[3];
 };
 
+/* Access Key Format of VLAN Filter Table */
+struct vft_ak_exact {
+	__le16 vid; /* bit0~11: VLAN ID, other bits are reserved */
+	__le16 resv;
+};
+
+union vft_access_key {
+	__le32 entry_id; /* entry_id match */
+	struct vft_ak_exact exact;
+	__le32 resume_entry_id; /* search */
+};
+
+/* VLAN Filter Table Request Data Buffer Format of Update and Add actions */
+struct vft_req_ua {
+	struct ntmp_cmn_req_data crd;
+	union vft_access_key ak;
+	struct vft_cfge_data cfge;
+};
+
 #endif
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index a9f3e6cbf422..2aedea17307f 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -32,6 +32,7 @@ struct netc_tbl_vers {
 	u8 maft_ver;
 	u8 rsst_ver;
 	u8 fdbt_ver;
+	u8 vft_ver;
 };
 
 struct netc_cbdr {
@@ -94,6 +95,27 @@ struct fdbt_entry_data {
 #define FDBT_ACT_FLAG		BIT(7)
 };
 
+struct vft_cfge_data {
+	__le32 bitmap_stg;
+#define VFT_PORT_MEMBERSHIP	GENMASK(23, 0)
+#define VFT_STG_ID_MASK		GENMASK(27, 24)
+#define VFT_STG_ID(g)		FIELD_PREP(VFT_STG_ID_MASK, (g))
+	__le16 fid;
+#define VFT_FID			GENMASK(11, 0)
+	__le16 cfg;
+#define VFT_MLO			GENMASK(2, 0)
+#define VFT_MFO			GENMASK(4, 3)
+#define VFT_IPMFE		BIT(6)
+#define VFT_IPMFLE		BIT(7)
+#define VFT_PGA			BIT(8)
+#define VFT_SFDA		BIT(10)
+#define VFT_OSFDA		BIT(11)
+#define VFT_FDBAFSS		BIT(12)
+	__le32 eta_port_bitmap;
+#define VFT_ETA_PORT_BITMAP	GENMASK(23, 0)
+	__le32 et_eid;
+};
+
 #if IS_ENABLED(CONFIG_NXP_NETC_LIB)
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs);
@@ -118,6 +140,8 @@ int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 				u32 *resume_entry_id,
 				struct fdbt_entry_data *entry);
+int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
+		       const struct vft_cfge_data *cfge);
 #else
 static inline int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 				 const struct netc_cbdr_regs *regs)
@@ -183,6 +207,12 @@ static inline int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 	return 0;
 }
 
+static inline int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
+				     const struct vft_cfge_data *cfge)
+{
+	return 0;
+}
+
 #endif
 
 #endif
-- 
2.34.1



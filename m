Return-Path: <linuxppc-dev+bounces-20805-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE49CD37AC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 03:03:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFdZ307X5z2yS6;
	Wed, 13 May 2026 13:03:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778641386;
	cv=pass; b=E8UlRJtd+yeRmreo2jwHetjnujea/lk+FX2VYI58+6MzkGc1Mjr4fv1mkWJwhItg4Q7Z/xGpZWpNwTa6RnqZ/gzgXzVcgl2moGxk8b3XG+ttySMUxV/E+ShkvJhxhDZe4oHd6++queQpcj7UtVxmN9XEaOxKrX10n0VpVJFjDVs8iRdPAbrq/N1skSurVBkvmP5OqTAl14Q4dwQesutClR9CTUqUbgDEL7T35Vgu4YaFeGnEWE8NheC2+IymVCO63Cu/LDHcu2dKY8xGPeYm98wwnYpIyOa+otpZEVP+kpePDocrePRzLaIcStH2PmmJWM40WFF0qtDng4VmS/GIOw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778641386; c=relaxed/relaxed;
	bh=kSc8Q48CjHF7K1oPYUnmKGERCq0WRSdQS9aH8eNEY8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fRGIHD2ob/pkR/GjKo8SVo/JKNbPRfUE+zHL0DGvzNCn840U549dt9QAiVtoM37sshXkJeLcbVpBrxOZvIv4wxKweZxEplODOFncxmuTQQOx69T4soky1mAHvml5ZNuwvyOM0pyxtokNM/WvKuVZqaP+3M+YufxIzlGZ4WXVG92icTmSyZ+JGWbE/cBumMwduY1yNladyPgJMC1232A8IxxTRY4M2aHZTp5DNXEtnL+kXpoGghiXVDJ0PPdWPldClIXm5sbqn99B1GfDtguFXflyT8WvKHREZF10v009SlILJdoHwHpNH2C0f2wA1CHxVNMhhgMriJfE2mSqqeJcTg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=m7wwyuk1; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=m7wwyuk1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFdZ168FWz2yTP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 13:03:05 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMWzXRZk2jxPw0b2svQ9zgDYcfGWZebJA/oKLgZmlEqITq5TJopm2dsySoizAwJFAvRblIbPNbibiCxCW5Vbk+b9BYjY0hkzdEfJnGcCPcCDJwrq6gjRbA/VXIHSGhq0imoAeneIJNUPYHJXwJrLcDQ6B93rc5NuO5NyazYkwsCtvCnTckVwAnZByi93n0S/10r+P/P0pZOHxyGha5ydNUyKmp0pmJL98VnXNxt9EXU0bu6e8ZOZy22IwXGlXQn9uev09uwziMA4Z6v0PXd1PMS7LjbIzuf4g4yggpDLbAL6rQjcMfwKsaE7hA9BfjcfYvlTyor81laxlLbJqNObMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSc8Q48CjHF7K1oPYUnmKGERCq0WRSdQS9aH8eNEY8A=;
 b=Uj9LMQBUzkkIyhSKLM3/1vrVhIp797KN9rT0GIN8RqOzVx3FGWjs+gBxW0CBEFBduBazAp/EHYDqzzJOdxAx/cgiDXbC6i2dMZV7HGvbqqVtk2EtEcGEK6tMQRPZsPd1RD4AgqpAhuasaUzQj3ToR29AwNwv5Zgczu95uY5QtGRccy87ruNTaD4dGhLnNjpNwyARomLmUWKgJXO9xnIjzmx19UIUyhk6UL80nYg7xju5YQk2Mr+ZBXRMK29hkrgGoerddLB6xQlLvAWc4LrOQq6ton39l2r4epM6EQkI1nM+jEgrVYDFhzaLcbf3XveMfAlpaMm0DipDtsEUyGcGCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSc8Q48CjHF7K1oPYUnmKGERCq0WRSdQS9aH8eNEY8A=;
 b=m7wwyuk1EobJYB4s0lDib/fdjnwiHqGkyLimqwo4O1fNc8f+KSksQNfPNJ32EgB9Yi3xgQTopFW+Po+m0PLUX0b6ERunUE5VOfP59rl7C0sxHSpRdNeOA92Pq6UoZ69UwIxD34U/nDrYupqB3v9OrmSyWNZJwZGPtAJnjiV+bpTLFg30Lz48E7CUw31Ob2fMkU49HR6UPGgV8LjMT5XfG3tsKBKP8kdwEnT7N87qGxT9Kmxd3hbJ64/dmMzbPL3nPEPzPLWlF4WVlMwXDcX0DOsnfTntF+m2Y7UWyvi27vrGHobN9SDBnTTLfmbdbtDdbKQY9scrUrja/TandGvrCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by GV1PR04MB11525.eurprd04.prod.outlook.com (2603:10a6:150:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 03:02:56 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 03:02:56 +0000
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
	maxime.chevallier@bootlin.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v7 net-next 04/15] net: enetc: add basic operations to the FDB table
Date: Wed, 13 May 2026 11:04:43 +0800
Message-Id: <20260513030454.1666570-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513030454.1666570-1-wei.fang@nxp.com>
References: <20260513030454.1666570-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0029.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|GV1PR04MB11525:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8c6181-97ec-4bae-4bd6-08deb09c2184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|56012099003|18002099003|22082099003|3023799003|11063799003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	kLx5NA3FuOibaDJnoBQuFegU5wZZ1Zn5ozohcXzpTdB1bLKXjg94wPVGrqvITnb+lSw+E/UsS9/yRdhZWZP8qMk5P6Ex0rocj1Bj8NTicRJFbWD6qiFyJ7KdjkopUKike2Vvm3VVeVWA9dLlORkCaFgbLyQGUk+pAjiAgUdEnPeNG/AczRckUbw0XrXqSYa/8XEvy/bmRlE61z6lz0HC4R3JcBBgsNY/aM87PfXKfqIBxpC5vHpQTw726p4xuXANF2Pwa6R4WtVBQGJpohyeLJ1t/Q8PzZmppMhnsh2q0XSoVzZeC1GG2/8PFo0/HWlkFbiQ2v8XyaRt8tXubD9/aob3eEKLOkU6iMBaIA4yiPahlVYjua6KBHNm60dUr8tauxw9QXfBuWvy8HA45QCkX2pijQLhUSKWXn/PPXA1tpdhIflypMClZgsIUSvEZfxjJ/299E4WvXS8L+1FVN6fsa5Fb0H4mUlfnOKlaZe8tWy7Wchlgw5XVLtNYBUdqFwpYLjWdjI9puocxk5AEFo4KEHFTzJA6aX4r+oyfsoxQjIJ3e2se4kEKGFhZuSgidWQBBv1MuNquJfyAywUdlR10XAmT+FCSRARFG8hvI8gWUaGOcvSoq0T0FeGLaVj2Es84NG5Wnmm6XM0AOQPctt2FhlWtCJAhZ+Rr1qfV12b2IQxls4bYEoieaARsQpYK9ZTcL/ZM/3RYOXoCRmpKazJ/hTCzxajLxf8gqoL17rq/HMoHFsRW9tMH82+Thmbv9bGJ+g3cIYMILZHjrlCwiyB/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(56012099003)(18002099003)(22082099003)(3023799003)(11063799003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BUX0YmoOWlr76/irBACaRdOWDk6q87UAym3PmXSVqfpZjpOINhYMkC+T9TkB?=
 =?us-ascii?Q?xM3PKg1mFnFrGESILL4RX0An1K9O01+c2Fe6GzJvU1f0DtOfBL4WFNJa/Uu1?=
 =?us-ascii?Q?trwNm5AemEyeGXpzG4RiAgOXO1sA0N8Y391QDCkpR95xlFjvGQ80fGC7d4nJ?=
 =?us-ascii?Q?w2qWNHBTDdw5h4Ne7MUR+iyZGoNmBujCUyoILH4hYGU+9StZ17X2bwfqD0xV?=
 =?us-ascii?Q?H0mvyKjnV/MSxja08qjrb571vMRTIVEzFGi6yiv0l3CMJIcpR1AJJyXvkVm+?=
 =?us-ascii?Q?SmCpMWvh5af6hra4QXSdL7RwsprmqGoN7aOB8lvB8MklgqKfLsI1fTe0oLM4?=
 =?us-ascii?Q?Hmhc8UTilSVtO2mAI+a1mcbpQEuX7jbNGqJb6ZG/Xj8UeDTjwBeFD8sCiHrC?=
 =?us-ascii?Q?9FDWcZhYrflZ9R8Rlm1z/01ZI/Zk82HRZeTVyWfBqGSjbxl6aD5BLLPdCB9w?=
 =?us-ascii?Q?7ocQDbPzM2Qx65599gbJMW5YJDXekCJzIBRBF9POaJqGNfT5yopbmPJ8Amb6?=
 =?us-ascii?Q?zkb3JJop4ZxSxxdZBb/VyTwPhV7uhIx/9+p+xeia/o9UDiPfvMqh7OfOyS+V?=
 =?us-ascii?Q?N3wUSh/tiIVtviLS0mMV4TrEGuJtUFLEqoEg5k60+IVV14k7+yjp5BkmzZJx?=
 =?us-ascii?Q?tGJTk+8TX03GV9uc9Vvt4Xg5jyeXqlj0lLPIU1Jg3NIv8zgaSSeCrJTVENFh?=
 =?us-ascii?Q?xS389GxA/NtJBy1kd+XiXMGlau3sdWVceooBeX7XudgDspLEuab72K8Qvu0C?=
 =?us-ascii?Q?zMlKQVIFqs5f4EhShlqWU0S7dlBj2wO+xFmdpnMxn1UDDlF0LZZEian5JUAV?=
 =?us-ascii?Q?fATv/XRbXmrBI70hjiNr9CDd7cs7cTV5vtvOWSc50K+/LZbjAw/RhLk9txCk?=
 =?us-ascii?Q?xRIrQAno9gtOx/YWgHAdo9ANPN0ImbjI2uOrgZ4/t58I1olWCQv9EBXHM+8c?=
 =?us-ascii?Q?OrrQAYiytAf7u29viuRcj42M71x8EdbmgDjR03eQtWFJUi6hXMnrgPtNWXng?=
 =?us-ascii?Q?SrrsFTtOEyi8gs0M+dRfOHN0ibaYgzLhQA/xOrtX/n5hBgbQ4nnGaPhBz1nw?=
 =?us-ascii?Q?Ow4QxZzf4eO5tMzUDhzQ5KBjoUXajIJJQuJUvANslBES4Ptg1S/SPJaIJjjc?=
 =?us-ascii?Q?Kup1OiLVIzbA2EEVzEr2WeffbQKk+4ftLEgL6LQVXNTPUvaJ0/x+10BMsy+l?=
 =?us-ascii?Q?r+WrYnkZxmrePLItn59dof1sxWJV8GgNtjOvJdaTe7LEHRjiLz7DdpRDnT4l?=
 =?us-ascii?Q?mBGUNgAWkMCG/z08m2zM/Nd4gi7vD1ReKS5VTwlF+41KNdvI/kXElGcgTwow?=
 =?us-ascii?Q?ijfmp4k9XNXcA3wnSrqhPWfxSuogpy/mOqRJrnj5wc9txfUNXCavCwQmz/ni?=
 =?us-ascii?Q?fxZ+XtpEj1AxdDEBDod47T5GF+KmVjTFEnGevctUR2R9PY6oeeK67hGU5Tx3?=
 =?us-ascii?Q?uKgU8wAcb6BhgkQsobnhxwtMTIqmo7zZSj63NUGTFlUlUQGxYJgP5ZryEIlB?=
 =?us-ascii?Q?KHyfBUPrdtDpVMxC3VNc22bdajqaTNlo49c86PVSWcPjePKH8Rp0a7PHGKYb?=
 =?us-ascii?Q?J4g6bBg9hPrs2tSsnXolguD+lCwQ1/kpSjPfFhBZRJEbSFNd0HJEzB5Ec+C+?=
 =?us-ascii?Q?R+JVtoHTsfKsY3O7DBjxJzS0zytNfUXsiEa7QyKaolE01hj5vlmQ2uQdcE+d?=
 =?us-ascii?Q?0a13Mxq4ssuepO01ngU8bb3k8+HQ+eLnevgeMCXOo/Dlcuzs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8c6181-97ec-4bae-4bd6-08deb09c2184
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 03:02:55.9611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymR2P0Ivxo1T2W/uyp19an3vLgSCnQVrbSoJ6WaqffKS/Uc1Xm3amJJrMJonKvmnxH/92OnPQVoB0tL6EWnM3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11525

The FDB table is used for MAC learning lookups and MAC forwarding lookups.
Each table entry includes information such as a FID and MAC address that
may be unicast or multicast and a forwarding destination field containing
a port bitmap identifying the associated port(s) with the MAC address.
FDB table entries can be static or dynamic. Static entries are added from
software whereby dynamic entries are added either by software or by the
hardware as MAC addresses are learned in the datapath.

The FDB table can only be managed by the command BD ring using table
management protocol version 2.0. Table management command operations Add,
Delete, Update and Query are supported. And the FDB table supports three
access methods: Entry ID, Exact Match Key Element and Search. This patch
adds the following basic supports to the FDB table.

ntmp_fdbt_update_entry() - update the configuration element data of a
specified FDB entry

ntmp_fdbt_delete_entry() - delete a specified FDB entry

ntmp_fdbt_add_entry() - add an entry into the FDB table

ntmp_fdbt_search_port_entry() - Search the FDB entry on the specified
port based on RESUME_ENTRY_ID.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 205 +++++++++++++++++-
 .../ethernet/freescale/enetc/ntmp_private.h   |  61 +++++-
 include/linux/fsl/ntmp.h                      |  44 +++-
 3 files changed, 307 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index c94a928622fd..6074eeafd5a2 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
  * NETC NTMP (NETC Table Management Protocol) 2.0 Library
- * Copyright 2025 NXP
+ * Copyright 2025-2026 NXP
  */
 
 #include <linux/dma-mapping.h>
@@ -21,11 +21,17 @@
 /* Define NTMP Table ID */
 #define NTMP_MAFT_ID			1
 #define NTMP_RSST_ID			3
+#define NTMP_FDBT_ID			15
 
 /* Generic Update Actions for most tables */
 #define NTMP_GEN_UA_CFGEU		BIT(0)
 #define NTMP_GEN_UA_STSEU		BIT(1)
 
+/* Query Action: 0: Full query. 1: Query entry ID, the fields after entry
+ * ID are not returned.
+ */
+#define NTMP_QA_ENTRY_ID		1
+
 #define NTMP_ENTRY_ID_SIZE		4
 #define RSST_ENTRY_NUM			64
 #define RSST_STSE_DATA_SIZE(n)		((n) * 8)
@@ -260,6 +266,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "MAC Address Filter Table";
 	case NTMP_RSST_ID:
 		return "RSS Table";
+	case NTMP_FDBT_ID:
+		return "FDB Table";
 	default:
 		return "Unknown Table";
 	}
@@ -496,5 +504,200 @@ int ntmp_rsst_query_entry(struct ntmp_user *user, u32 *table, int count)
 }
 EXPORT_SYMBOL_GPL(ntmp_rsst_query_entry);
 
+/**
+ * ntmp_fdbt_add_entry - add an entry into the FDB table
+ * @user: target ntmp_user struct
+ * @entry_id: returned value, the entry ID of the new added entry
+ * @keye: key element data
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
+			const struct fdbt_keye_data *keye,
+			const struct fdbt_cfge_data *cfge)
+{
+	struct fdbt_resp_query *resp;
+	struct fdbt_req_ua *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, NTMP_QA_ENTRY_ID,
+		      NTMP_GEN_UA_CFGEU);
+	req->ak.exact.keye = *keye;
+	req->cfge = *cfge;
+
+	len = NTMP_LEN(swcbd.size, sizeof(*resp));
+	/* The entry ID is allotted by hardware, so we need to perform
+	 * a query action after the add action to get the entry ID from
+	 * hardware.
+	 */
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_AQ, NTMP_AM_EXACT_KEY);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err) {
+		dev_err(user->dev, "Failed to add %s entry, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+		goto unlock_cbdr;
+	}
+
+	if (entry_id) {
+		resp = (struct fdbt_resp_query *)req;
+		*entry_id = le32_to_cpu(resp->entry_id);
+	}
+
+unlock_cbdr:
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_add_entry);
+
+/**
+ * ntmp_fdbt_update_entry - update the configuration element data of the
+ * specified FDB entry
+ * @user: target ntmp_user struct
+ * @entry_id: the specified entry ID of the FDB table
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_update_entry(struct ntmp_user *user, u32 entry_id,
+			   const struct fdbt_cfge_data *cfge)
+{
+	struct fdbt_req_ua *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, NTMP_GEN_UA_CFGEU);
+	req->ak.eid.entry_id = cpu_to_le32(entry_id);
+	req->cfge = *cfge;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_UPDATE, NTMP_AM_ENTRY_ID);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev, "Failed to update %s entry, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_update_entry);
+
+/**
+ * ntmp_fdbt_delete_entry - delete the specified FDB entry
+ * @user: target ntmp_user struct
+ * @entry_id: the specified ID of the FDB entry
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id)
+{
+	u32 req_len = sizeof(struct fdbt_req_qd);
+
+	return ntmp_delete_entry_by_id(user, NTMP_FDBT_ID,
+				       user->tbl.fdbt_ver,
+				       entry_id, req_len,
+				       NTMP_STATUS_RESP_LEN);
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_delete_entry);
+
+/**
+ * ntmp_fdbt_search_port_entry - Search the FDB entry on the specified
+ * port based on RESUME_ENTRY_ID
+ * @user: target ntmp_user struct
+ * @port: the specified switch port ID
+ * @resume_entry_id: it is both an input and an output. As an input, it
+ * represents the FDB entry ID to be searched. If it is a NULL entry ID,
+ * it indicates that the first FDB entry for that port is being searched.
+ * As an output, it represents the next FDB entry ID to be searched.
+ * @entry: returned value, the response data of the searched FDB entry
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
+				u32 *resume_entry_id,
+				struct fdbt_entry_data *entry)
+{
+	struct fdbt_resp_query *resp;
+	struct fdbt_req_qd *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, 0);
+	req->ak.search.resume_eid = cpu_to_le32(*resume_entry_id);
+	req->ak.search.cfge.port_bitmap = cpu_to_le32(BIT(port));
+	/* Match CFGE_DATA[PORT_BITMAP] field */
+	req->ak.search.cfge_mc = FDBT_CFGE_MC_PORT_BITMAP;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, sizeof(*resp));
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_QUERY, NTMP_AM_SEARCH);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err) {
+		dev_err(user->dev,
+			"Failed to search %s entry on port %d, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), port, ERR_PTR(err));
+		goto unlock_cbdr;
+	}
+
+	if (!cbd.resp_hdr.num_matched) {
+		entry->entry_id = NTMP_NULL_ENTRY_ID;
+		*resume_entry_id = NTMP_NULL_ENTRY_ID;
+		goto unlock_cbdr;
+	}
+
+	resp = (struct fdbt_resp_query *)req;
+	*resume_entry_id = le32_to_cpu(resp->status);
+	entry->entry_id = le32_to_cpu(resp->entry_id);
+	entry->keye = resp->keye;
+	entry->cfge = resp->cfge;
+	entry->acte = resp->acte;
+
+unlock_cbdr:
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_search_port_entry);
+
 MODULE_DESCRIPTION("NXP NETC Library");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index f8dff3ba2c28..b0b5805ac4f6 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /*
  * NTMP table request and response data buffer formats
- * Copyright 2025 NXP
+ * Copyright 2025-2026 NXP
  */
 
 #ifndef __NTMP_PRIVATE_H
@@ -11,6 +11,7 @@
 #include <linux/fsl/ntmp.h>
 
 #define NTMP_EID_REQ_LEN	8
+#define NTMP_STATUS_RESP_LEN	4
 #define NETC_CBDR_BD_NUM	256
 #define NETC_CBDRCIR_INDEX	GENMASK(9, 0)
 #define NETC_CBDRCIR_SBE	BIT(31)
@@ -30,6 +31,7 @@ union netc_cbd {
 #define NTMP_CMD_QUERY		BIT(2)
 #define NTMP_CMD_ADD		BIT(3)
 #define NTMP_CMD_QU		(NTMP_CMD_QUERY | NTMP_CMD_UPDATE)
+#define NTMP_CMD_AQ		(NTMP_CMD_ADD | NTMP_CMD_QUERY)
 		u8 access_method;
 #define NTMP_ACCESS_METHOD	GENMASK(7, 4)
 #define NTMP_AM_ENTRY_ID	0
@@ -97,4 +99,61 @@ struct rsst_req_update {
 	u8 groups[];
 };
 
+/* Access Key Format of FDB Table */
+struct fdbt_ak_eid {
+	__le32 entry_id;
+	__le32 resv[7];
+};
+
+struct fdbt_ak_exact {
+	struct fdbt_keye_data keye;
+	__le32 resv[5];
+};
+
+struct fdbt_ak_search {
+	__le32 resume_eid;
+	struct fdbt_keye_data keye;
+	struct fdbt_cfge_data cfge;
+	u8 acte;
+	u8 keye_mc;
+#define FDBT_KEYE_MAC		GENMASK(1, 0)
+	u8 cfge_mc;
+#define FDBT_CFGE_MC		GENMASK(2, 0)
+#define FDBT_CFGE_MC_ANY		0
+#define FDBT_CFGE_MC_DYNAMIC		1
+#define FDBT_CFGE_MC_PORT_BITMAP	2
+#define FDBT_CFGE_MC_DYNAMIC_AND_PORT_BITMAP	3
+	u8 acte_mc;
+#define FDBT_ACTE_MC		BIT(0)
+};
+
+union fdbt_access_key {
+	struct fdbt_ak_eid eid;
+	struct fdbt_ak_exact exact;
+	struct fdbt_ak_search search;
+};
+
+/* FDB Table Request Data Buffer Format of Update and Add actions */
+struct fdbt_req_ua {
+	struct ntmp_cmn_req_data crd;
+	union fdbt_access_key ak;
+	struct fdbt_cfge_data cfge;
+};
+
+/* FDB Table Request Data Buffer Format of Query and Delete actions */
+struct fdbt_req_qd {
+	struct ntmp_cmn_req_data crd;
+	union fdbt_access_key ak;
+};
+
+/* FDB Table Response Data Buffer Format of Query action */
+struct fdbt_resp_query {
+	__le32 status;
+	__le32 entry_id;
+	struct fdbt_keye_data keye;
+	struct fdbt_cfge_data cfge;
+	u8 acte;
+	u8 resv[3];
+};
+
 #endif
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 83a449b4d6ec..4cfff835954e 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -1,11 +1,13 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/* Copyright 2025 NXP */
+/* Copyright 2025-2026 NXP */
 #ifndef __NETC_NTMP_H
 #define __NETC_NTMP_H
 
 #include <linux/bitops.h>
 #include <linux/if_ether.h>
 
+#define NTMP_NULL_ENTRY_ID		0xffffffffU
+
 struct maft_keye_data {
 	u8 mac_addr[ETH_ALEN];
 	__le16 resv;
@@ -29,6 +31,7 @@ struct netc_cbdr_regs {
 struct netc_tbl_vers {
 	u8 maft_ver;
 	u8 rsst_ver;
+	u8 fdbt_ver;
 };
 
 struct netc_swcbd {
@@ -68,6 +71,36 @@ struct maft_entry_data {
 	struct maft_cfge_data cfge;
 };
 
+struct fdbt_keye_data {
+	u8 mac_addr[ETH_ALEN]; /* big-endian */
+	__le16 resv0;
+	__le16 fid;
+#define FDBT_FID		GENMASK(11, 0)
+	__le16 resv1;
+};
+
+struct fdbt_cfge_data {
+	__le32 port_bitmap;
+#define FDBT_PORT_BITMAP	GENMASK(23, 0)
+	__le32 cfg;
+#define FDBT_OETEID		GENMASK(1, 0)
+#define FDBT_EPORT		GENMASK(6, 2)
+#define FDBT_IMIRE		BIT(7)
+#define FDBT_CTD		GENMASK(10, 9)
+#define FDBT_DYNAMIC		BIT(11)
+#define FDBT_TIMECAPE		BIT(12)
+	__le32 et_eid;
+};
+
+struct fdbt_entry_data {
+	u32 entry_id;
+	struct fdbt_keye_data keye;
+	struct fdbt_cfge_data cfge;
+	u8 acte;
+#define FDBT_ACT_CNT		GENMASK(6, 0)
+#define FDBT_ACT_FLAG		BIT(7)
+};
+
 #if IS_ENABLED(CONFIG_NXP_NETC_LIB)
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs);
@@ -83,6 +116,15 @@ int ntmp_rsst_update_entry(struct ntmp_user *user, const u32 *table,
 			   int count);
 int ntmp_rsst_query_entry(struct ntmp_user *user,
 			  u32 *table, int count);
+int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
+			const struct fdbt_keye_data *keye,
+			const struct fdbt_cfge_data *cfge);
+int ntmp_fdbt_update_entry(struct ntmp_user *user, u32 entry_id,
+			   const struct fdbt_cfge_data *cfge);
+int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id);
+int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
+				u32 *resume_entry_id,
+				struct fdbt_entry_data *entry);
 #else
 static inline int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 				 const struct netc_cbdr_regs *regs)
-- 
2.34.1



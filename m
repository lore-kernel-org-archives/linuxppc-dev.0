Return-Path: <linuxppc-dev+bounces-21851-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2B1CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 07:21:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV2Lr0WGmz3bxl;
	Tue, 02 Jun 2026 17:21:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780384884;
	cv=pass; b=KfUWYwo85NsXr1cKikLqrY1d6Ak+/FOfBjF6+6Vk/Y+1atpmLEcvh5Go3bLjtXleUqTSPrngw5+us8SdpNxmcnsNVKQtOhG0PiwuQZH7nQkj9QagrZanRBQiqkflkuSxeDgE2yFcaYq5VTZr5jl54A0chAZJF0arS/qOrh1PmyI9qgMQXEjnUTkim87DsoUCgwekP9pz/yFLQHPj1DCanzBwaO1m18ZhlFFYa17EEAoWZ4Zr7NgoOo3R/bEBTBOU8s+SRP2Amb0LirWTwTe+5KD73CsP+xeRvNCUPOI/s2v51i22YfYN6wiIYt+mqCw3XhdCzRO771i0OYV+58ylUQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780384884; c=relaxed/relaxed;
	bh=SEs1U9efK9z0WeWv84HlI8X/mo7hvn7JuGAfcwOAGzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lqobcQMG8BtApFEompC29LKLPrwtamHCUR84gFxbuYau7ccKKwT0tBhQsyLsp/Zt482Z5jbQwI1wX9IkwZvG2Y2ZUgVIxf3W6vwgyyPT6y7i+hOlVKmIi7T8vW5hR1RWzYgmbqKF6g1E9LPFOV2wJgYQzbPdQ9gGr/7I8AflDxzOZ1uXzRe/GiUvFCHCkbDn3QM8kYsHMp3HXcPzVMW6EHw5eW8UZE0u8QCyBZvAZohSzqn9Pll+4y0bvJvAvGbgZnHIreC2jyVe15Esiewgnz1SI6jhGFNi9oKhrPej0j40cJNyjOZDTPr49pgQByUKJTFD1/RdJhDDKS3mtShwog==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QQwSBGq4; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QQwSBGq4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV2Lq0q49z3c0H
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 17:21:23 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQkvID4hRyGySJdyoWLN4ByJDRug/be8Gc6nHXmyOLiDEQ2puYw0yRWaVZTqWxOIOFeshubcxLFbu1ZjnvRitnpydT82HFGFmqKiAfI6sIEc8CwhbNT1bj5OwaPgovHQ69HfhcAgsAnETHJcFOGxDLU28OitpZo4zIxM5Ezbg4ZTjW4et9WYqWg2WI0h1fnsNKFxErhGFdwMjMl8NskonPUWdtZgtrN0DxB4PfbaV97bPwoCjovmgT0tFy9ZomEaduVSW9xbH1SeASNNi1rcqdVVtY9kFa4xaGN6lG9igOraeHKiUxQV+URi1AbVYPohzcM/ipoLqNo415VWdx1Qag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEs1U9efK9z0WeWv84HlI8X/mo7hvn7JuGAfcwOAGzs=;
 b=b8iqh53QfrD23onWcEo/G9/iNekb+n7n2A6GRqjdZkVNFbc8EuwVNGlPoM8hHeWjPZZuWELT+lfoB4z9itz3MxWkF4d3Z9aJi+iv/azlMpnSZR04VtJ/KOvrlKI60DGNHv5Sld+dKEC+R14L1IDPbNuaugCPNVGG1gsl2VlPMgrwuL55gdbvAfBjtmsQFeShghx94T9yqV5MfN5xNgG2VCD+bHlaw2cRTC7cYw71Xs/pqBivBOZozLu58/u6JlU4mB6ktn9G0JhPWtvUv4qKrbklZPapRMUxa5h7Vdum413qH5uNFAkAdbrkyq99cTK1jA6raxw9wrEIQ0uEeBVOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEs1U9efK9z0WeWv84HlI8X/mo7hvn7JuGAfcwOAGzs=;
 b=QQwSBGq4XEUrZi9n6pDHBTmuyQ1WxHp0Rrgq0a2wED3llJenBVRwGQrrSjV8A8l02yjt38lt8NWyZKvVcfl6OwFin5bMmNx6Cx3WotWeDiQ/TLyzov0iD++Ebvil0tDaFmles38Wk/IzArqQzKiFpDsPTdbwjHciEuBbvG8QXVFaZJrUGniORGngl5jJSOZC9f5WddUStxrvPI380RhZzG7PoENwsAYNJ4TWYkUSaemgXMRDNbmK+uwvp7V7EP/xt7m/MMUitLls3Km+fDMKU9R2idbbvQ1ws8nnkehOVrvtD/dd0pXhPpCoVvnWw7QoM26pQmceqjcsn1SfTlFXFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM9PR04MB7684.eurprd04.prod.outlook.com (2603:10a6:20b:287::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 07:21:09 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 07:21:09 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 net-next 9/9] net: dsa: netc: implement dynamic FDB entry ageing
Date: Tue,  2 Jun 2026 15:23:13 +0800
Message-Id: <20260602072313.3162120-10-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602072313.3162120-1-wei.fang@oss.nxp.com>
References: <20260602072313.3162120-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0216.apcprd04.prod.outlook.com
 (2603:1096:4:187::18) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AM9PR04MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 5389801c-f6da-4493-225c-08dec07784b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|19092799006|376014|921020|6133799003|3023799007|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RZrFifGRziMEV9WE5LIlaYyPV8cMuJ7OYmMtzEX2R2GdobVQ+aFb7bAyIME3j3dbUWY8uF1Ub8Aie/nQYDZx5gRdxU4v7XlLvkPxrrsJI7NCClJ3CWqrfLQkQ7IamyT55Xhsc9tA4R4qEMpUboTcyZgFqZqS9gfCjn1A8qSPg7MPQD3SGYr6V6jPd0Hm2vQs5ch8hp+p4cZalPiLyGqwKjQCvDTJro3wy/dwSddT9vrXWjf8gpyh8ejhMlaE8v8375weDQnr33GvfxxS9bb9R/EGEFIKTUW2U+QVr0O8jkhYGfBGXFJP9iQBROI2YEJgJSTgDLx1c0nEv+i9CHRLXQxRZMQQt21unCO1Z63DAc9kjsQH/Is5BiPdOcKix6PQFvCOWr06zSUT4Pxqfh3hIeUh+W+XcgLtpRHySVM1LI2rZ0KkBwpXvkLzsHCQGSNLMtPvEGg1x5qx12ZlJzm16sLV4a87bod8yNVDT14uecxhTlMcsWMepEC0Uqlv4SxB5mvVOGslVEkaAYM4wmvLICftp9wPNUZ8hy4IXwQTJpKuA4ACtiKDvWIvQxspnGoArXKvHt64tcUaCwnbA/FLTpVuc7fVxhBAuDBAiAK+grrQF/XpCNf5eKsmLjau+ljTwkZx+mlS9FM7+0o6WNASft5QZHyJnpbyItfhITxMvJKRDuhLJhXQm58Ok7bqaHGXe25RJ/KNnSh18t7EEO4k9xjY4aodBUZcCC7oGyJ703c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(19092799006)(376014)(921020)(6133799003)(3023799007)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qv2Xd1EHaGnhf87Dd5O1sEGMrUwqgJh5Ium4Vdm8Nk016rODtViGadO+5GKq?=
 =?us-ascii?Q?ITXl2VuMq1v33y1CJA65124egod3GR64TaGZdJGPeDQ1q81iLnlEwW8VKpvG?=
 =?us-ascii?Q?Ck4An/svegGwwe2KqatMMP/7laO/vwHKqe/b2f+A1V74KvAgt+jO2q+iFy1F?=
 =?us-ascii?Q?r/jj9iHxjl1Uu9qNne54m7ZjQZ3jJ8S0koCjRFLl3tuwvDf9DS/8aSBCeni8?=
 =?us-ascii?Q?MIygoSIs4ocyNe5RW6P8RoV/RbpICQ8DGk0f8Gj4+meJi2w0VYLAjUUax5dk?=
 =?us-ascii?Q?HwapBEAsO3gBVvB7uqc5aZicQs9a45vGFqeffF+DRKNuAb4exD8ZAmjAJD4T?=
 =?us-ascii?Q?beXbHJVD8lZsFrinXfeK/V6VtpKz9jx+g8jLAhm9mllkeZ6xzLQbfWcrzzAd?=
 =?us-ascii?Q?k97/PunyxtvgqH/1EU/60ar9on4k4UoJpKe9UPWZuCxtkt/8Tayuky6R8Hc2?=
 =?us-ascii?Q?CJKELUmbTBkNqfvZXx0vjrzvug4ARp3i6px4q+Vm0j9lrtBWHNuUZPid1qmD?=
 =?us-ascii?Q?epjEByso8HnoN9UyMOR5RNLIgEr4quCLFroKKasETMPWVJThpFwSp2AhDvFE?=
 =?us-ascii?Q?/3GfGI2k/oA/171yOrkmLLIRAiVInDMNyK3Dfllo6S0r2p3et8EUZVVJRGes?=
 =?us-ascii?Q?ZU5FMi/JpWWu6tVPe04w9xf491zNR2zFJwaE9//oxz+gYKL/zIwzpZv4Wqgn?=
 =?us-ascii?Q?DW5d6aKDyspivYz2XKqotrM4MaJtdLMaoOe9JHPZuD17AJLaCJw4eIt22+km?=
 =?us-ascii?Q?Qi8mjIBYaNXZM5/gyMOJ/3Zgfc+VbZHzC6tA0ZU6rGVl87FfqTUnpRAORV1C?=
 =?us-ascii?Q?ktP9ivQ6FkML7R6alDjFbWRodeKkRnC3Nlfy1vBVx+C7dO7PhKLxOJM/hGGt?=
 =?us-ascii?Q?gW7r598a4MPvCypQ0GcVpNU5h5W0Aar7Z3cHGZCUyNfYaB69SPfZjBhT/MU/?=
 =?us-ascii?Q?9VixLjHYcn1SWdn05xuubAlDz15KfZoUSIbYckT8BDeGfepuggI+TFfK86eF?=
 =?us-ascii?Q?NXAKdZGDgvfUL5DZP1CQkGtuC4zhoLIz6d/VK8PJtPVU15Omb6uu28X7jBDT?=
 =?us-ascii?Q?xFiocQ+Afpcztc/glY6gZ3q2l4DhfzRhG8qml/cVzcjgcAWpxL/kbAntR4/z?=
 =?us-ascii?Q?6qFSZyrPz+/PKMriZ3qTRWeZgye0J9bVseZgAQeS9Q6uSDn7B5h7FSgoC3f5?=
 =?us-ascii?Q?+KgtS+88gEJuJBt65USPSpwpgtjzhSklfwU8GqCP8Wt3JukYTY11LAj9c2PM?=
 =?us-ascii?Q?xjxYzOeNA9UbtTEM3EI8DjtwaVsMiRQnm7IT700noQAtKyR0pxegVppHp3c/?=
 =?us-ascii?Q?BF7IKO50FikFwvlTVKX9+50LTZKvAhNSTH2Qpnh97jdiPXS8ihHCjH40nQ01?=
 =?us-ascii?Q?Z5Yw7OoK/Tx70YEHlwjiXzTckPRiBRwBAPmhQ/P0USNcVySZR90LMIYMz9Ee?=
 =?us-ascii?Q?botEUBhz5ptgUVLVrFZqdkngMslwe4jL6viRimAPPumKdupGhTErpMcpPnnh?=
 =?us-ascii?Q?4/HtUmLZ4oGbMe3hRujCYKVdsjPjQdfoCdbH7p/RmaT7fUELNRj1smUbviMX?=
 =?us-ascii?Q?tS3i0iiwWTVZT4m1peNSCsiD+J/rE4010/ODKoFWSvLdJmpmIRlWX/pJHrXM?=
 =?us-ascii?Q?gVOoUKmBc+K/G/x3B+QNJB8I4SDtfrN9dztbzz+Drk4NlVTHSP/yQop4NJvH?=
 =?us-ascii?Q?8TShn9BIEjErZrR3IHp8FG3H4W2CMqpkmmijzr2ALBmHO59w4hyrQKSCCvfF?=
 =?us-ascii?Q?pCyiWI2E/dglUHycyuhabuv+CkodLDhmD100UEXyBPtQrzeG4kTS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5389801c-f6da-4493-225c-08dec07784b8
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 07:21:09.5665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/63J6QDfYeFDiiwss+ZLZR7dnOSAZXtJUyawJK3U6o5Bp0b8ifzRFIc3lOyZ6t0XZcalayn0QxnxEWBJiYLIpt/N7ZitR86EyyMHuxhIP30EhslIHalEfWys4CRVLf3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7684

From: Wei Fang <wei.fang@nxp.com>

The NETC switch does not age out dynamic FDB entries automatically.
Without software management, stale entries persist after topology
changes and cause incorrect forwarding.

Add a delayed work that periodically removes entries that have not been
refreshed within the specified cycles. The effective aging time is:

  ageing_time = fdbt_ageing_delay * 100

Default values are 3s interval and 100 cycles (300s total), matching
the IEEE 802.1Q default ageing time. The work starts when the first
port joins a bridge (tracked via br_cnt) and is cancelled when the
last port leaves. All FDB operations are serialized under fdbt_lock.

When a port leaves the bridge, its dynamic FDB entries are flushed
right away in port_bridge_leave(), without waiting for the ageing
cycle. Additionally, when a link down event is detected on a port,
netc_mac_link_down() will also clear the port's dynamic FDB entries
via netc_port_remove_dynamic_entries(). Non-bridge ports have no
dynamic FDB entries, so this call is always safe.

Implement set_ageing_time and port_fast_age DSA operations to allow
the bridge layer to reconfigure aging parameters and trigger per-port
flushes on demand.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c   | 90 ++++++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h |  7 +++
 2 files changed, 97 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 5b58ce06beb8..3737a852cafc 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -447,6 +447,25 @@ static void netc_free_ntmp_user(struct netc_switch *priv)
 	netc_free_ntmp_bitmaps(priv);
 }
 
+static void netc_clean_fdbt_ageing_entries(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct netc_switch *priv;
+
+	priv = container_of(dwork, struct netc_switch, fdbt_ageing_work);
+
+	/* Update the activity element in FDB table */
+	mutex_lock(&priv->fdbt_lock);
+	ntmp_fdbt_update_activity_element(&priv->ntmp);
+	/* Delete the ageing entries after the activity element is updated */
+	ntmp_fdbt_delete_ageing_entries(&priv->ntmp, NETC_FDBT_AGEING_THRESH);
+	mutex_unlock(&priv->fdbt_lock);
+
+	if (atomic_read(&priv->br_cnt))
+		schedule_delayed_work(&priv->fdbt_ageing_work,
+				      READ_ONCE(priv->fdbt_ageing_delay));
+}
+
 static void netc_switch_dos_default_config(struct netc_switch *priv)
 {
 	struct netc_switch_regs *regs = &priv->regs;
@@ -861,6 +880,10 @@ static int netc_setup(struct dsa_switch *ds)
 
 	INIT_HLIST_HEAD(&priv->fdb_list);
 	mutex_init(&priv->fdbt_lock);
+	priv->fdbt_ageing_delay = NETC_FDBT_AGEING_DELAY;
+	atomic_set(&priv->br_cnt, 0);
+	INIT_DELAYED_WORK(&priv->fdbt_ageing_work,
+			  netc_clean_fdbt_ageing_entries);
 	INIT_HLIST_HEAD(&priv->vlan_list);
 	mutex_init(&priv->vft_lock);
 
@@ -925,6 +948,7 @@ static void netc_teardown(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
 
+	disable_delayed_work_sync(&priv->fdbt_ageing_work);
 	netc_destroy_all_lists(priv);
 	netc_free_host_flood_rules(priv);
 	netc_free_ntmp_user(priv);
@@ -1948,6 +1972,7 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 				 struct netlink_ext_ack *extack)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
+	struct netc_switch *priv = ds->priv;
 	u16 vlan_unaware_pvid;
 	int err;
 
@@ -1974,20 +1999,42 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	np->host_flood = NULL;
 	netc_port_wr(np, NETC_PIPFCR, 0);
 
+	if (atomic_inc_return(&priv->br_cnt) == 1)
+		schedule_delayed_work(&priv->fdbt_ageing_work,
+				      READ_ONCE(priv->fdbt_ageing_delay));
+
 	return 0;
 }
 
+static void netc_port_remove_dynamic_entries(struct netc_port *np)
+{
+	struct netc_switch *priv = np->switch_priv;
+
+	/* Return if the port is not available */
+	if (!np->dp)
+		return;
+
+	mutex_lock(&priv->fdbt_lock);
+	ntmp_fdbt_delete_port_dynamic_entries(&priv->ntmp, np->dp->index);
+	mutex_unlock(&priv->fdbt_lock);
+}
+
 static void netc_port_bridge_leave(struct dsa_switch *ds, int port,
 				   struct dsa_bridge bridge)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
 	struct net_device *ndev = np->dp->user;
+	struct netc_switch *priv = ds->priv;
 	u16 vlan_unaware_pvid;
 	bool mc, uc;
 
 	netc_port_set_mlo(np, MLO_DISABLE);
 	netc_port_set_pvid(np, NETC_STANDALONE_PVID);
 
+	if (atomic_dec_and_test(&priv->br_cnt))
+		cancel_delayed_work_sync(&priv->fdbt_ageing_work);
+
+	netc_port_remove_dynamic_entries(np);
 	uc = ndev->flags & IFF_PROMISC;
 	mc = ndev->flags & (IFF_PROMISC | IFF_ALLMULTI);
 
@@ -2007,6 +2054,44 @@ static void netc_port_bridge_leave(struct dsa_switch *ds, int port,
 	netc_port_del_vlan_entry(np, vlan_unaware_pvid);
 }
 
+static int netc_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
+{
+	struct netc_switch *priv = ds->priv;
+	unsigned long delay_jiffies;
+
+	/* The dynamic FDB entry is deleted when its activity counter reaches
+	 * NETC_FDBT_AGEING_THRESH (100). Each delayed_work tick increments
+	 * the counter by 1 if the entry is inactive.
+	 *
+	 * Therefore:
+	 *   msecs (ms)    = NETC_FDBT_AGEING_THRESH * delay_ms (ms)
+	 *   delay_ms      = msecs / NETC_FDBT_AGEING_THRESH
+	 *   delay_jiffies = (delay_ms / 1000) * HZ
+	 *                 = (msecs * HZ) / (1000 * NETC_FDBT_AGEING_THRESH)
+	 *
+	 * Use DIV_ROUND_CLOSEST_ULL to perform a single nearest-jiffy
+	 * rounding, avoiding the two-step rounding error of the intermediate
+	 * delay_ms approach.
+	 *   Maximum error = +/-0.5 jiffy * 100 = 50000/HZ ms.
+	 */
+	delay_jiffies = DIV_ROUND_CLOSEST_ULL((u64)msecs * HZ,
+					      1000 * NETC_FDBT_AGEING_THRESH);
+	WRITE_ONCE(priv->fdbt_ageing_delay, delay_jiffies);
+
+	if (atomic_read(&priv->br_cnt))
+		mod_delayed_work(system_percpu_wq, &priv->fdbt_ageing_work,
+				 READ_ONCE(priv->fdbt_ageing_delay));
+
+	return 0;
+}
+
+static void netc_port_fast_age(struct dsa_switch *ds, int port)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	netc_port_remove_dynamic_entries(np);
+}
+
 static void netc_phylink_get_caps(struct dsa_switch *ds, int port,
 				  struct phylink_config *config)
 {
@@ -2261,6 +2346,7 @@ static void netc_mac_link_down(struct phylink_config *config,
 	np = NETC_PORT(dp->ds, dp->index);
 	netc_port_mac_rx_graceful_stop(np);
 	netc_port_mac_tx_graceful_stop(np);
+	netc_port_remove_dynamic_entries(np);
 }
 
 static const struct phylink_mac_ops netc_phylink_mac_ops = {
@@ -2290,6 +2376,8 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.port_vlan_del			= netc_port_vlan_del,
 	.port_bridge_join		= netc_port_bridge_join,
 	.port_bridge_leave		= netc_port_bridge_leave,
+	.set_ageing_time		= netc_set_ageing_time,
+	.port_fast_age			= netc_port_fast_age,
 	.get_pause_stats		= netc_port_get_pause_stats,
 	.get_rmon_stats			= netc_port_get_rmon_stats,
 	.get_eth_ctrl_stats		= netc_port_get_eth_ctrl_stats,
@@ -2338,6 +2426,8 @@ static int netc_switch_probe(struct pci_dev *pdev,
 	ds->phylink_mac_ops = &netc_phylink_mac_ops;
 	ds->fdb_isolation = true;
 	ds->max_num_bridges = priv->info->num_ports - 1;
+	ds->ageing_time_min = 1000;
+	ds->ageing_time_max = U32_MAX;
 	ds->priv = priv;
 	priv->ds = ds;
 
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 982c8d3a3fbf..4abef8b383bd 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -50,6 +50,9 @@
 /* PAUSE refresh threshold: send refresh when timer reaches this value */
 #define NETC_PAUSE_THRESH		0x7FFF
 
+#define NETC_FDBT_AGEING_DELAY		(3 * HZ)
+#define NETC_FDBT_AGEING_THRESH		100
+
 struct netc_switch;
 
 struct netc_switch_info {
@@ -124,6 +127,10 @@ struct netc_switch {
 	struct ntmp_user ntmp;
 	struct hlist_head fdb_list;
 	struct mutex fdbt_lock; /* FDB table lock */
+	struct delayed_work fdbt_ageing_work;
+	/* (fdbt_ageing_delay * ageing_act_cnt) is ageing time */
+	unsigned long fdbt_ageing_delay;
+	atomic_t br_cnt;
 	struct hlist_head vlan_list;
 	struct mutex vft_lock; /* VLAN filter table lock */
 
-- 
2.34.1



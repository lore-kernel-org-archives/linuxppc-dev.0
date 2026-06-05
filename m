Return-Path: <linuxppc-dev+bounces-22078-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7255CD6E75
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 01:46:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWkmX0jGYz3bpm;
	Fri, 05 Jun 2026 11:46:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780623964;
	cv=pass; b=kb4yOUgfl0Ck7/jEsCNQouC5wBr5QJmemHzlsIcuk+jBH6vEoa3Vs/oBAKu5/ff3gtXKR2QXmRV3YAkr+HnoTp0VIxze+UvBK6bbHzdMl5yCToTFP2KE2eBLyH9JyKwynfebKLpatVkmJjRnAtDjRGoXLtcljYNuTdOkclNMrqFRdnXG1MJrToeG7CU/6Z2wOqfHv8Nrrzhu8fteEUiCbd6ASWPYWdC7FVkT+Wf+/o7nDdysGhq0v4XN/RIBjzsr40/t1VfkdEphfIQgi5nRWoWLKFJkZe1zDIi1n2aCig0xyrM9/IRhPCJSMjE53U08VhNaddt/Ctm+uilZ3qfQRw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780623964; c=relaxed/relaxed;
	bh=H6ZF7Kd5Ei35BEhLG8EB9s1YJuYy1utMQtIICzgHSrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KUu18OxK2lobmBP+NEYk/B0671rB4jBabJc7dEzWbxP2Kxvx5WHIqCifrEoO5FDC2po4LDvZFbEZH33G4q29GE7PNwCRvVkohjVk6Cxb2O+8IElCFUntfav2nme1UVz+eYoGqbFno2SUEeMeHsPP+PojATIXVIrXgn8Fgxd7xfO2AUkf3DE4y8PQtXN6IDUI0K5dwzmkc1FgwSnxNJrqxroetuD3nSiMDP5it9DDwlY9OUdHn3S2dczpOArG/cAqbiFz0YL8CGwi/jgY6SEh8HNMypxFsxYYK8RyWCecdIYQbBZ8bFNcPnW19DE4lL00ftHwriyz+F/QRsck08kWkA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=RXVof0Mm; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=RXVof0Mm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWkmV4rBqz3c1Q
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 11:46:02 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OafMTzsJs2B9r55ayKUKBBFxdfklBkh/mz38BozkQs1z72OT9xN8vdQjud4OvHbG92jm7NXd2jELizme2hCbzNbhLlGftm1yxgXkbBrUiuhPPnscRjG5tKQlE5jT1Xx8dbi+oqYXDY1SZZSc+8qAbCsyIt9vuTlpKoBanCund401qhpCHnKAP5vQmTu2oGs2mYWvR30zc787gF1vz8IXRGrPleajjwbZ/fjZgu0sVSKgRQBZj1xurGPiOUiFlH/ikWFuxrAcHhwvWysGzLzXxB4s+BgKUdTbZQXr/KuyszK57GaI+ngtjsE21fMH5i8b7CCaIxzkw6BcGQd4s4baKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6ZF7Kd5Ei35BEhLG8EB9s1YJuYy1utMQtIICzgHSrM=;
 b=H7oVnYPgzMEtn3G6nttvEiLos73w44K4aOn7p6EyonFEpu1XQvEIeg5sdJWRnq/34MGq1Big/D5CoyGx+Ut6DwWE4UyTZNNgcMhQ/rSz9IFd80KSEcuaFA7vHWmzj3VClqJFwHq3Zqd946vHt9YX1RQFb3tA8AM1sKABOYIsLAG96hnMHbBaW6C2RLgntSb7taneb9WbTf7+R+BX6RRv2yOILJFlk7QflQ5tDBnd9LVlGoQuh1nXzfbUfi1xcw6vYVX6TKKV/nshMtxieGCC+ma7qhjA2hpm90bot4DxMwzYCpmTl6f86VjkrQaUJZqo0YsGFK9BDk07RMyofYBcNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6ZF7Kd5Ei35BEhLG8EB9s1YJuYy1utMQtIICzgHSrM=;
 b=RXVof0Mmd2n4ZMjJFt8uk8qQF1O9qw0oupUq1kBiHJ31aTJMuxW40fsnpC5X4jMGFPWzrhqw/nidjcYsqbUtji43gDXpvJZIOMRpjEGO/IPFwXZvK3W1OwGGLgdBvBM/ofSQNTcHvve4LlnQFcJM78HzSYW8xkPZ7GcfzJ1LDBFlswVdff+3mT8Hc+sFmS4CtmxaXLXCax335uWO0m1xiem53SgGDLoVFj/pliQ/MgTeT44EJLxlGs5M/cZVyp2Dw1h4LiDxilDMpEbrooVOyfFUhRCE418FzUJru6iXVWoXTpTkziZ8GTMA8+imn0wcrJ1Xt4XC8j4G5YQPhzwOzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB9375.eurprd04.prod.outlook.com (2603:10a6:102:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 01:45:49 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 01:45:49 +0000
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
Subject: [PATCH v3 net-next 8/9] net: dsa: netc: add bridge mode support
Date: Fri,  5 Jun 2026 09:48:07 +0800
Message-Id: <20260605014808.686024-9-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605014808.686024-1-wei.fang@oss.nxp.com>
References: <20260605014808.686024-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB9375:EE_
X-MS-Office365-Filtering-Correlation-Id: 651b409c-5d33-42f5-b686-08dec2a42b66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|1800799024|376014|366016|921020|6133799003|3023799007|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	b2r6PjfLGf4T3PognYcHFVden9sBXBWUQ+jzef8X3Z2UqReJeij0FgoJtwMh4119YuO43g+pq70UqZBTazfrUn5KRYrDRPjkj/HNFMaKTnTU+ewhA1DJ5AyR1iaQ95M0f75Wzx/sVdiVbkHVr210iktaKBvEIdN9laAtrQA5gVFZNhc4yg23OhfJQ58EpoNLHlI873iBwd/clnSwXJuABhdxPCnqxO5VPN9bj7GYKJbt5bpwkMgS+4N3R4YmjjA2mCIcq9Igjgm6KuGoB6OQ8oVjqfe4aOCVf/HvHlMaGZm6mOnQrdCTXiQOqg0MeXquuQcSNyflCwUkw0VsWGRj7Do//md+Ue9ogkF0pPoiUKBivZuITPde5+lhtMZi2/2lCWCPm9FEl3u2wV+4UhExcJwtEvTJGfHIotr63iORPNaM/A1pQ2IPUQ2/xaNt8AkmF7E+R10LRVnwh5gQ39VtsGhNOpwDUgXNpp8NNLWphztJiSSdwiG/BIqM4cMtxoQBYZbSsnxQjFMm6Vd/lP97Q08XRkPkh8z/oaBNvwgYnFQ3wuG++uXZfxw7E2ma2yWmMqtTRjZPOotkA55iB6YBKL9FdEgM3L8AAxG0F0/Ez9EcnYMHGUIbj8z3XaiV5pV9MtQeB2AtX0u3osOzW7GvjVJaoC6LjXYxdTvZacyq8oAfC40Oc70sGrXXwGRD8Inx+gTON1mXPelhViakn+phO2mtuNeHmU3CzldN/DRcBQo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(1800799024)(376014)(366016)(921020)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Npq397fIO6DHZ+x8kZnQ+6zs8wezB5KaTqoNVEeYsMHd62nwZJ5RsO0zpYnw?=
 =?us-ascii?Q?cNbXP/o/v0WGRLbeyNPTJaR7HXNo2HbH/uJH/Z8CUH3NyE3/9RfrSorY+xxh?=
 =?us-ascii?Q?kJOyk+HBIbSKbYFbWtDLW9o0I8gQifeggxCtE8c/S9/0dFgoziySL4kO4qaH?=
 =?us-ascii?Q?VN4xcC48axZhq6oWmQ0BqPvN8nt4IacJ/B/iXtGiDgLKNY+rxmu8rq/HBLYh?=
 =?us-ascii?Q?/vsyhzZGkI0mNOpfzlxeABxdKS1fovRMXdO/hn62VWTwSvBvwCf4NOfX5A0G?=
 =?us-ascii?Q?jweuunHKViuCOLF6N7LyfvWgJtkjO2hOrggYHAhaUgEV2WwnEniVFQzoP79i?=
 =?us-ascii?Q?J/fSNrHbHvhNViUSZFfLvobPv0eSsepf+tAo6MA64uTXb8AzzLRROkETUbry?=
 =?us-ascii?Q?OP/aXhFb4OdycMp/lJ2Qc1rMgzT2oBMKeFMy3vWgcfCqyRT8gsT1o7nOFPT7?=
 =?us-ascii?Q?vDaSuxPi6b1l3VN6K/ruh6N5B36Of9Nj0WmWjeDwTDEWgBlK/uBpOEHSOIdW?=
 =?us-ascii?Q?SACFgQnSCuPQmMIS1q2W43auAeUNhsqSZmIIPpLr673plIAqLby4/H3X1k7V?=
 =?us-ascii?Q?nHW4+c44pe+yHhNBj8oeyMbvcB8Xdje5vfm6btQQhKPMOHL7kLFsfJqNQArR?=
 =?us-ascii?Q?3PexTXaQGatY7ct7hoxFf+AXy5ptZU4C7/W9Swwu7jkqlfp94U139j8ez52L?=
 =?us-ascii?Q?OCNPu48I65Qs8XJIJn4tKwj9gXn72FRkLhjaTWsidJ2xSHUWKD1Vlw5odtPF?=
 =?us-ascii?Q?foF1ioC8aRcdnCGLPdvLESQLBqM2zWJ1BTERlqxnesiUOi8Pg2RmUj9/mHSh?=
 =?us-ascii?Q?ivBxl8jlwKQO8Pj4nK1840Nz/qO9XoGQdaaFWnY2H0up8d4mDU8xKjYXVv+S?=
 =?us-ascii?Q?qk3FOyXfj9C292C7jc6dMbLvmPAWYUuXYzcWPRH7rzGeVl6A8kXbs8thvpw1?=
 =?us-ascii?Q?E9Edju8Mp9lNNRGSnstptWCH7+S8lR/QibV1n+TReYRGH4rgl14Z/wa983jA?=
 =?us-ascii?Q?mP4asYckCmroTQruOforI1bqmR3WM6070ANKakq9dbca5+8DlBXA3Dv5S4Gs?=
 =?us-ascii?Q?F5CblLw2nq52np8KdgKl7x1jN3IWeebh8uLDGZ0fqochPQXB3+cyhF0N5sis?=
 =?us-ascii?Q?lE5U9/PiWzOv+jO2Nj0c7VVq82jbhGrZpDtBa+Ee2w4/Pb/LXKJ6X+YIfxWW?=
 =?us-ascii?Q?Nzl7enzinmFbUsSHmVbLCbIprwgFhcAbvu4pucgRwcff8pYmXwylvBQjVwDE?=
 =?us-ascii?Q?ZTZaaS4o+q4a5j/d4bo3GMov8PO2rCVge9KTZprHEX/dVun9VkJToxbxrA/P?=
 =?us-ascii?Q?A56euk+nYdUgbE1WujrnhiBLW7TQkRFGgiUoFz0G+sPmafvO5ww/3GjoZMWl?=
 =?us-ascii?Q?EHGvIRHqvUbzx8nQNWjqg9EQnc9rp1yDUW5t7x9HEzW8P4esuyVOY9rEfdsU?=
 =?us-ascii?Q?Xjq+gbfT4hrP2KaIRNAWfqNztfwA9Wb3pAnQ2NS2bKZvNPK7cD3/96uwAa91?=
 =?us-ascii?Q?6fdbbVOEoAE4F9algJrqWNwUbBR64BQCYRG2b+BSWL/nkZI+BMHORtZaV261?=
 =?us-ascii?Q?C6KjrxD6A6CXyODRZhZMp6JQLdqKpaqa0dNHaYaiAWJ9z+BCYnQwlLBLsaNS?=
 =?us-ascii?Q?2dUkaVu9ZJb0fR5WhidbHwb3iNgRs0aeNk5mSlHfWmyAOM7JhkyEWXAdvWMF?=
 =?us-ascii?Q?tgPgXGCIPOTHdUCBQaZ4GhgmKtR6N7JvQBvUeuZv7iaPQUcGr5Ffk7oGEc6g?=
 =?us-ascii?Q?udp9Nl49qc6jXD0v442s5luE4Sv1fYS4Wev6E5ab8Ao353lWw3Kc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651b409c-5d33-42f5-b686-08dec2a42b66
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 01:45:49.2969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRpQBZmhaxy91HyNk+PsT6RQ5uyhBmCHMR3etHZtUss+EMd4Rs+sKB/7+N6YaYFgogZbkVP7tR8ryKWYOBk633hSgik1mhaypOR395UTbV2M9zpkVPSK2fB5/OFwEnvk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9375

From: Wei Fang <wei.fang@nxp.com>

Wire up the port_bridge_join, port_bridge_leave and port_vlan_filtering
DSA callbacks to support both VLAN-unaware and VLAN-aware bridge modes.

For VLAN-unaware bridges, each bridge instance is assigned a dedicated
internal PVID via NETC_VLAN_UNAWARE_PVID(bridge.num), counting down
from VID 4095. A VFT entry is created for this PVID with hardware MAC
learning and flood-on-miss forwarding enabled. The CPU port is included
as a VFT member so frames can reach the host. The reserved VID range is
blocked in port_vlan_add to prevent user-space conflicts.

Only one VLAN-aware bridge is supported at a time; this constraint is
enforced in port_bridge_join and port_vlan_filtering. The per-port PVID
is tracked in software and written to the BPDVR register whenever VLAN
filtering is active.

When a port leaves the bridge, its dynamic FDB entries are flushed right
away in port_bridge_leave(), without waiting for the ageing cycle. When
a link down event occurs on a port, netc_mac_link_down() will also clear
the port's dynamic FDB entries via netc_port_remove_dynamic_entries().
Non-bridge ports have no dynamic FDB entries, so this call is always
safe. Additionally, .port_fast_age() callback is added to flush the
dynamic FDB entries associated to a port.

Host flood rules are removed from the ingress port filter table when a
port joins a bridge to avoid bypassing FDB lookup and MAC learning.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c   | 353 +++++++++++++++++++++++++++--
 drivers/net/dsa/netc/netc_switch.h |   2 +
 2 files changed, 339 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 1e1873528ccc..b61152c16e7b 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -509,6 +509,17 @@ static void netc_port_set_mlo(struct netc_port *np, enum netc_mlo mlo)
 	netc_port_rmw(np, NETC_BPCR, BPCR_MLO, FIELD_PREP(BPCR_MLO, mlo));
 }
 
+static void netc_port_set_pvid(struct netc_port *np, u16 pvid)
+{
+	netc_port_rmw(np, NETC_BPDVR, BPDVR_VID, pvid);
+}
+
+static void netc_port_set_vlan_aware(struct netc_port *np, bool aware)
+{
+	netc_port_rmw(np, NETC_BPDVR, BPDVR_RXVAM,
+		      aware ? 0 : BPDVR_RXVAM);
+}
+
 static void netc_port_fixed_config(struct netc_port *np)
 {
 	/* Default IPV and DR setting */
@@ -534,7 +545,7 @@ static void netc_port_default_config(struct netc_port *np)
 	netc_port_fixed_config(np);
 
 	/* Default VLAN unaware */
-	netc_port_rmw(np, NETC_BPDVR, BPDVR_RXVAM, BPDVR_RXVAM);
+	netc_port_set_vlan_aware(np, false);
 
 	if (dsa_port_is_cpu(np->dp))
 		/* For CPU port, source port pruning is disabled */
@@ -695,10 +706,16 @@ static int netc_port_del_fdb_entry(struct netc_port *np,
 
 	entry = netc_lookup_fdb_entry(priv, addr, vid);
 	if (unlikely(!entry))
-		/* Currently only single port mode is supported, MAC learning
-		 * is disabled, so there is no dynamically learned FDB entry.
-		 * We need to support deleting dynamically FDB entry when the
-		 * bridge mode is supported.
+		/* The hardware-learned dynamic FDB entries cannot be deleted
+		 * through .port_fdb_del() interface.
+		 * For NTF_MASTER path: Since hardware-learned dynamic FDB
+		 * entries are never synchronized back to the bridge software
+		 * database. br_fdb_delete() -> br_fdb_find() cannot find the
+		 * FDB entry, so .port_fdb_del() will not be called.
+		 * For NTF_SELF path: dsa_user_netdev_ops does not implement
+		 * ndo_fdb_del(), so rtnl_fdb_del() falls back to
+		 * ndo_dflt_fdb_del(), which only supports NUD_PERMANENT static
+		 * entries and rejects all others with -EINVAL.
 		 */
 		goto unlock_fdbt;
 
@@ -1276,6 +1293,16 @@ static int netc_port_add_vlan_entry(struct netc_port *np, u16 vid,
 	entry->ect_gid = NTMP_NULL_ENTRY_ID;
 
 	bitmap_stg = BIT(index) | VFT_STG_ID(0);
+	/* If the VID is a VLAN-unaware PVID, the CPU port needs to be
+	 * a member of this VLAN.
+	 */
+	if (dsa_port_is_user(np->dp) &&
+	    vid >= NETC_VLAN_UNAWARE_PVID(priv->ds->max_num_bridges)) {
+		struct dsa_port *cpu_dp = np->dp->cpu_dp;
+
+		bitmap_stg |= BIT(cpu_dp->index);
+	}
+
 	cfg = FIELD_PREP(VFT_MLO, MLO_HW) |
 	      FIELD_PREP(VFT_MFO, MFO_NO_MATCH_FLOOD);
 
@@ -1313,11 +1340,16 @@ static int netc_port_add_vlan_entry(struct netc_port *np, u16 vid,
 	return err;
 }
 
-static bool netc_port_vlan_egress_rule_changed(struct netc_vlan_entry *entry,
+static bool netc_port_vlan_egress_rule_changed(struct netc_switch *priv,
+					       struct netc_vlan_entry *entry,
 					       int port, bool untagged)
 {
 	bool old_untagged = !!(entry->untagged_port_bitmap & BIT(port));
 
+	/* VLAN-unaware VIDs have no egress rules, so return 'false' */
+	if (entry->vid >= NETC_VLAN_UNAWARE_PVID(priv->ds->max_num_bridges))
+		return false;
+
 	return old_untagged != untagged;
 }
 
@@ -1340,7 +1372,8 @@ static int netc_port_set_vlan_entry(struct netc_port *np, u16 vid,
 	}
 
 	/* Check whether the egress VLAN rule is changed */
-	changed = netc_port_vlan_egress_rule_changed(entry, port, untagged);
+	changed = netc_port_vlan_egress_rule_changed(priv, entry, port,
+						     untagged);
 	if (changed) {
 		entry->untagged_port_bitmap ^= BIT(port);
 		err = netc_port_update_vlan_egress_rule(np, entry);
@@ -1404,6 +1437,17 @@ static int netc_port_del_vlan_entry(struct netc_port *np, u16 vid)
 	cfge = &entry->cfge;
 	vlan_port_bitmap = FIELD_GET(VFT_PORT_MEMBERSHIP,
 				     le32_to_cpu(cfge->bitmap_stg));
+	/* If the VID is a VLAN-unaware PVID, we need to clear the CPU
+	 * port bit of vlan_port_bitmap, so that the VLAN entry can be
+	 * deleted if no user ports use this VLAN.
+	 */
+	if (dsa_port_is_user(np->dp) &&
+	    vid >= NETC_VLAN_UNAWARE_PVID(priv->ds->max_num_bridges)) {
+		struct dsa_port *cpu_dp = np->dp->cpu_dp;
+
+		vlan_port_bitmap &= ~BIT(cpu_dp->index);
+	}
+
 	/* If the VLAN only belongs to the current port */
 	if (vlan_port_bitmap == BIT(port)) {
 		err = ntmp_vft_delete_entry(&priv->ntmp, vid);
@@ -1509,17 +1553,50 @@ static int netc_port_max_mtu(struct dsa_switch *ds, int port)
 	return NETC_MAX_FRAME_LEN - VLAN_ETH_HLEN - ETH_FCS_LEN;
 }
 
+static struct net_device *netc_classify_db(struct dsa_db db)
+{
+	switch (db.type) {
+	case DSA_DB_PORT:
+		return NULL;
+	case DSA_DB_BRIDGE:
+		return db.bridge.dev;
+	default:
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+}
+
+static u16 netc_vlan_unaware_pvid(struct dsa_port *dp)
+{
+	u32 br_num;
+
+	if (!dsa_port_bridge_dev_get(dp))
+		return NETC_STANDALONE_PVID;
+
+	br_num = dsa_port_bridge_num_get(dp);
+
+	/* The br_num is supposed to be 1 ~ ds->max_num_bridges, see
+	 * dsa_bridge_num_get(). Since max_num_bridges is non-zero,
+	 * so dsa_port_bridge_create() will return an error if
+	 * dsa_bridge_num_get() returns 0.
+	 */
+	if (WARN_ON(!br_num))
+		return NETC_STANDALONE_PVID;
+
+	return NETC_VLAN_UNAWARE_PVID(br_num);
+}
+
 static int netc_port_fdb_add(struct dsa_switch *ds, int port,
 			     const unsigned char *addr, u16 vid,
 			     struct dsa_db db)
 {
+	struct net_device *br_ndev = netc_classify_db(db);
 	struct netc_port *np = NETC_PORT(ds, port);
 
-	/* Currently, only support standalone port mode, so only
-	 * NETC_STANDALONE_PVID (= 0) is supported here.
-	 */
-	if (vid != NETC_STANDALONE_PVID)
-		return -EOPNOTSUPP;
+	if (IS_ERR(br_ndev))
+		return PTR_ERR(br_ndev);
+
+	if (!vid)
+		vid = netc_vlan_unaware_pvid(np->dp);
 
 	return netc_port_set_fdb_entry(np, addr, vid);
 }
@@ -1528,10 +1605,14 @@ static int netc_port_fdb_del(struct dsa_switch *ds, int port,
 			     const unsigned char *addr, u16 vid,
 			     struct dsa_db db)
 {
+	struct net_device *br_ndev = netc_classify_db(db);
 	struct netc_port *np = NETC_PORT(ds, port);
 
-	if (vid != NETC_STANDALONE_PVID)
-		return -EOPNOTSUPP;
+	if (IS_ERR(br_ndev))
+		return PTR_ERR(br_ndev);
+
+	if (!vid)
+		vid = netc_vlan_unaware_pvid(np->dp);
 
 	return netc_port_del_fdb_entry(np, addr, vid);
 }
@@ -1567,6 +1648,8 @@ static int netc_port_fdb_dump(struct dsa_switch *ds, int port,
 		cfg = le32_to_cpu(cfge->cfg);
 		is_static = (cfg & FDBT_DYNAMIC) ? false : true;
 		vid = le16_to_cpu(keye->fid);
+		if (vid >= NETC_VLAN_UNAWARE_PVID(ds->max_num_bridges))
+			vid = 0;
 
 		err = cb(keye->mac_addr, vid, is_static, data);
 		if (err)
@@ -1669,12 +1752,23 @@ static void netc_port_remove_host_flood(struct netc_port *np,
 					struct ipft_entry_data *host_flood)
 {
 	struct netc_switch *priv = np->switch_priv;
+	bool disable_host_flood = false;
 
 	if (!host_flood)
 		return;
 
+	if (np->host_flood == host_flood)
+		disable_host_flood = true;
+
 	ntmp_ipft_delete_entry(&priv->ntmp, host_flood->entry_id);
 	kfree(host_flood);
+
+	if (disable_host_flood) {
+		np->host_flood = NULL;
+		np->uc = false;
+		np->mc = false;
+		netc_port_wr(np, NETC_PIPFCR, 0);
+	}
 }
 
 static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
@@ -1683,6 +1777,17 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 	struct netc_port *np = NETC_PORT(ds, port);
 	struct ipft_entry_data *old_host_flood;
 
+	/* Do not add host flood rule to ingress port filter table when
+	 * the port has joined a bridge. Otherwise, the ingress frames
+	 * will bypass FDB table lookup and MAC learning, so the frames
+	 * will be redirected directly to the CPU port.
+	 */
+	if (dsa_port_bridge_dev_get(np->dp)) {
+		netc_port_remove_host_flood(np, np->host_flood);
+
+		return;
+	}
+
 	if (np->uc == uc && np->mc == mc)
 		return;
 
@@ -1704,12 +1809,85 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 	netc_port_remove_host_flood(np, old_host_flood);
 }
 
+static int netc_single_vlan_aware_bridge(struct dsa_switch *ds,
+					 struct netlink_ext_ack *extack)
+{
+	struct net_device *br_ndev = NULL;
+	struct dsa_port *dp;
+
+	dsa_switch_for_each_available_port(dp, ds) {
+		struct net_device *port_br = dsa_port_bridge_dev_get(dp);
+
+		if (!port_br || !br_vlan_enabled(port_br))
+			continue;
+
+		if (!br_ndev) {
+			br_ndev = port_br;
+			continue;
+		}
+
+		if (br_ndev == port_br)
+			continue;
+
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Only one VLAN-aware bridge is supported");
+
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int netc_port_vlan_filtering(struct dsa_switch *ds,
+				    int port, bool vlan_aware,
+				    struct netlink_ext_ack *extack)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	u16 pvid;
+	int err;
+
+	err = netc_single_vlan_aware_bridge(ds, extack);
+	if (err)
+		return err;
+
+	pvid = netc_vlan_unaware_pvid(np->dp);
+	if (pvid == NETC_STANDALONE_PVID) {
+		vlan_aware = false;
+		goto bpdvr_config;
+	}
+
+	if (vlan_aware) {
+		/* The FDB entries associated with unaware_pvid do not need
+		 * to be deleted, so that when switching from VLAN-aware to
+		 * VLAN-unaware mode, these FDB entries do not need to be
+		 * re-added.
+		 */
+		err = netc_port_del_vlan_entry(np, pvid);
+		if (err)
+			return err;
+
+		pvid = np->pvid;
+	} else {
+		err = netc_port_set_vlan_entry(np, pvid, false);
+		if (err)
+			return err;
+	}
+
+bpdvr_config:
+	netc_port_set_vlan_aware(np, vlan_aware);
+	netc_port_set_pvid(np, pvid);
+
+	return 0;
+}
+
 static int netc_port_vlan_add(struct dsa_switch *ds, int port,
 			      const struct switchdev_obj_port_vlan *vlan,
 			      struct netlink_ext_ack *extack)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
+	struct dsa_port *dp = np->dp;
 	bool untagged;
+	int err;
 
 	/* The 8021q layer may attempt to change NETC_STANDALONE_PVID
 	 * (VID 0), so we need to ignore it.
@@ -1717,20 +1895,157 @@ static int netc_port_vlan_add(struct dsa_switch *ds, int port,
 	if (vlan->vid == NETC_STANDALONE_PVID)
 		return 0;
 
+	if (vlan->vid >= NETC_VLAN_UNAWARE_PVID(ds->max_num_bridges)) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "VID %d~4095 reserved for VLAN-unaware bridge",
+				       NETC_VLAN_UNAWARE_PVID(ds->max_num_bridges));
+		return -EINVAL;
+	}
+
 	untagged = !!(vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED);
+	err = netc_port_set_vlan_entry(np, vlan->vid, untagged);
+	if (err)
+		return err;
+
+	if (vlan->flags & BRIDGE_VLAN_INFO_PVID) {
+		np->pvid = vlan->vid;
+		if (dsa_port_is_vlan_filtering(dp))
+			netc_port_set_pvid(np, vlan->vid);
+
+		return 0;
+	}
 
-	return netc_port_set_vlan_entry(np, vlan->vid, untagged);
+	if (np->pvid != vlan->vid)
+		return 0;
+
+	/* Delete PVID */
+	np->pvid = NETC_STANDALONE_PVID;
+	if (dsa_port_is_vlan_filtering(dp))
+		netc_port_set_pvid(np, NETC_STANDALONE_PVID);
+
+	return 0;
 }
 
 static int netc_port_vlan_del(struct dsa_switch *ds, int port,
 			      const struct switchdev_obj_port_vlan *vlan)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
+	int err;
 
 	if (vlan->vid == NETC_STANDALONE_PVID)
 		return 0;
 
-	return netc_port_del_vlan_entry(np, vlan->vid);
+	err = netc_port_del_vlan_entry(np, vlan->vid);
+	if (err)
+		return err;
+
+	if (np->pvid == vlan->vid) {
+		np->pvid = NETC_STANDALONE_PVID;
+
+		/* Set the port PVID to NETC_STANDALONE_PVID if the VLAN-aware
+		 * bridge port has no PVID. The untagged frames will not be
+		 * forwarded to other user ports, as NETC_STANDALONE_PVID VLAN
+		 * entry has disabled MAC learning and flooding, and other user
+		 * ports do not have FDB entries with NETC_STANDALONE_PVID.
+		 */
+		if (dsa_port_is_vlan_filtering(np->dp))
+			netc_port_set_pvid(np, NETC_STANDALONE_PVID);
+	}
+
+	return 0;
+}
+
+static int netc_port_bridge_join(struct dsa_switch *ds, int port,
+				 struct dsa_bridge bridge,
+				 bool *tx_fwd_offload,
+				 struct netlink_ext_ack *extack)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	u16 vlan_unaware_pvid;
+	int err;
+
+	if (!bridge.num) {
+		NL_SET_ERR_MSG_MOD(extack, "Bridge number 0 is unsupported");
+		return -EINVAL;
+	}
+
+	err = netc_single_vlan_aware_bridge(ds, extack);
+	if (err)
+		return err;
+
+	netc_port_set_mlo(np, MLO_NOT_OVERRIDE);
+
+	if (br_vlan_enabled(bridge.dev))
+		goto out;
+
+	vlan_unaware_pvid = NETC_VLAN_UNAWARE_PVID(bridge.num);
+	err = netc_port_set_vlan_entry(np, vlan_unaware_pvid, false);
+	if (err)
+		goto disable_mlo;
+
+	netc_port_set_pvid(np, vlan_unaware_pvid);
+
+out:
+	netc_port_remove_host_flood(np, np->host_flood);
+
+	return 0;
+
+disable_mlo:
+	netc_port_set_mlo(np, MLO_DISABLE);
+
+	return err;
+}
+
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
+static void netc_port_bridge_leave(struct dsa_switch *ds, int port,
+				   struct dsa_bridge bridge)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct net_device *ndev = np->dp->user;
+	u16 vlan_unaware_pvid;
+	bool mc, uc;
+
+	netc_port_set_mlo(np, MLO_DISABLE);
+	netc_port_set_pvid(np, NETC_STANDALONE_PVID);
+	np->pvid = NETC_STANDALONE_PVID;
+
+	netc_port_remove_dynamic_entries(np);
+	uc = ndev->flags & IFF_PROMISC;
+	mc = ndev->flags & (IFF_PROMISC | IFF_ALLMULTI);
+
+	if (netc_port_add_host_flood_rule(np, uc, mc))
+		dev_warn(ds->dev,
+			 "Failed to restore host flood rule on port %d\n",
+			 port);
+
+	if (br_vlan_enabled(bridge.dev))
+		return;
+
+	vlan_unaware_pvid = NETC_VLAN_UNAWARE_PVID(bridge.num);
+	/* There is no need to check the return value even if it fails.
+	 * Because the PVID has been set to NETC_STANDALONE_PVID, the
+	 * frames will not match this VLAN entry.
+	 */
+	netc_port_del_vlan_entry(np, vlan_unaware_pvid);
+}
+
+static void netc_port_fast_age(struct dsa_switch *ds, int port)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	netc_port_remove_dynamic_entries(np);
 }
 
 static void netc_phylink_get_caps(struct dsa_switch *ds, int port,
@@ -1987,6 +2302,7 @@ static void netc_mac_link_down(struct phylink_config *config,
 	np = NETC_PORT(dp->ds, dp->index);
 	netc_port_mac_rx_graceful_stop(np);
 	netc_port_mac_tx_graceful_stop(np);
+	netc_port_remove_dynamic_entries(np);
 }
 
 static const struct phylink_mac_ops netc_phylink_mac_ops = {
@@ -2011,8 +2327,12 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.port_mdb_add			= netc_port_mdb_add,
 	.port_mdb_del			= netc_port_mdb_del,
 	.port_set_host_flood		= netc_port_set_host_flood,
+	.port_vlan_filtering		= netc_port_vlan_filtering,
 	.port_vlan_add			= netc_port_vlan_add,
 	.port_vlan_del			= netc_port_vlan_del,
+	.port_bridge_join		= netc_port_bridge_join,
+	.port_bridge_leave		= netc_port_bridge_leave,
+	.port_fast_age			= netc_port_fast_age,
 	.get_pause_stats		= netc_port_get_pause_stats,
 	.get_rmon_stats			= netc_port_get_rmon_stats,
 	.get_eth_ctrl_stats		= netc_port_get_eth_ctrl_stats,
@@ -2060,6 +2380,7 @@ static int netc_switch_probe(struct pci_dev *pdev,
 	ds->ops = &netc_switch_ops;
 	ds->phylink_mac_ops = &netc_phylink_mac_ops;
 	ds->fdb_isolation = true;
+	ds->max_num_bridges = priv->info->num_ports - 1;
 	ds->priv = priv;
 	priv->ds = ds;
 
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 9ff334301fbc..982c8d3a3fbf 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -33,6 +33,7 @@
 #define NETC_MAX_FRAME_LEN		9600
 
 #define NETC_STANDALONE_PVID		0
+#define NETC_VLAN_UNAWARE_PVID(br_id)	(4096 - (br_id))
 
 /* Threshold format: MANT (bits 11:4) * 2^EXP (bits 3:0)
  * Unit: Memory words (average of 20 bytes each)
@@ -79,6 +80,7 @@ struct netc_port {
 	u16 enable:1;
 	u16 uc:1;
 	u16 mc:1;
+	u16 pvid;
 	struct ipft_entry_data *host_flood;
 };
 
-- 
2.34.1



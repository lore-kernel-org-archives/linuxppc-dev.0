Return-Path: <linuxppc-dev+bounces-19077-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D73D1061B32
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 11:30:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flQs95ZlFz2yl2;
	Tue, 31 Mar 2026 22:30:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774956621;
	cv=pass; b=ciG1MetHOvkjMlGHWbiO3P9devz5S9aKjZcm2lBATHPA6pALTia9j1UfNZXRghYeebZqhFjF3YLcS/fHWGtPjy+2EvbClas0KvFt7yKsL50ZgJG6rKVonnahLBS4B2FwzH2yQrhjLrmDIDzjS60xyjStKm/pxNSmFNG8tYfUaIA1h7edMOwplmNZMVS2pcYOqT1U5S7jL4XGYulSQh4XK3s8jyg1wvlt0TGGJr95x+jdzNA4Yu93hPYqiQFsQPUsz6inVr9GfOOvwz4c7EOQakJCUxedLMpxvIqzUcZ2F2OVaEpB55s9nRumXvc4U+A85xtHrxHovrRQnev5Bi5U+A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774956621; c=relaxed/relaxed;
	bh=xmHvBUmVU20yc5EpzfL97T4Jip0rZQBOGpCZeBwrrfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LWH3HTbKUhn5m4cvDhd+GewcxpJ7pvuWHfeI5G7n+6xrBJxbbSLmhQjJgoa6hr59Xrrlb9OMJQjjXfiElK3D0VP4LN+heFjWt80VfsEZPBAHifwKH/53kSjdP6kHHTLdRATpddwLaGXsUUl7Nkbu2yLlRu2QCpa48Djz6zGuHl3qpC04rOwIBgC/D1rDgEVEIbiTOTNQsaRzbIGrdtQqkkZZV+ubQm/+I5p+f4XeVZQriv44oHb3qNPl2GOmdlPjaw3rPrahtMUvSDgKIDBlcuQ1uxtjh1RT/MXv3GDXtMEnjXGgwuzUFnbxuB/Evf4DCKtbqYDJlmMdW6yDoohQpg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=bp9z3mvy; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=bp9z3mvy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flQs83Ptqz2ydn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 22:30:20 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/FZNa8lgU1YRcDl2VtToij/SwxfqGiiFqvod27aZ5M/YomfyqO7ZV6+HOd1ZXtue3+3xIY90qq29cfI3rah936JKsqnyYafRZC0nXsw5n21CxJSOWub0JtVw5/lsOFwSwe+YZSrcWrOZImJ7dKC6o0MYkjy2io4gcfC79ta1eIE6hFbrpMDP0MtOQIyoFJH4os+iOBHXSmIQlvo/P9ee/f8iysAQ7PnX7IqrF0OEkegJVRUYgc39t5e9NsH1qGlVnMGxasT69Krg6G1VuSd98hLcQfSI72iZa7HKfkGHb6lt07A6xip76he40dMG6KwzQJbyukT/V+kEwcmwM3seg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmHvBUmVU20yc5EpzfL97T4Jip0rZQBOGpCZeBwrrfo=;
 b=ZMXU8jD4lRGR7eik3wcYLnpywJdSzX0Xtw6DfKjXUvZRXZxC1PV7DEYFH3Bvr94zmcrCg8weoF7GidQkGn6Huqumx+jz3DbY521RaZXZ4bS+qy6RA+B+I/Wai0W1GBvFNdrfjykOxBNCkVisML8l1KwvVpLo216yBEUeM9i/PJE4tjH+1tKzCepYeOthSIvIk0P7GrVUV+XnrBmPKf7nDvY/KLkDzxgKIBAwIrYz8UqsFT8e9zS84e7bNGotn3uopRs8x9hMRBDrPRP2l6XJwJwIPQ7ZI04BdZWbgCQ2bWwtqo2aEcOs7Ul5u6abQWMcFW5ZgHn/ki0wsBFIqYmowA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmHvBUmVU20yc5EpzfL97T4Jip0rZQBOGpCZeBwrrfo=;
 b=bp9z3mvyj4CDCPx/xSglIwZM5AYqZJAN1e/jGWSbDWXcVlVwrSyqyJ1RYl8FjqoQJPnbDxPd/WRv9lgzr5K0Q8adRecP8J5XJ7tiz9n7kJ8Koe3xQ7IoPQ5zDy/+E92+43sYArvFtPEWZWEY+ueqBAVBImyvg8S+IoZZ5hjHW8Wc2V7niaM8Ae7bk8POGMPi+z3KuvSE9SMcwCV0KBOI1wtYQQJGmUVYrA16EVcIXH1WWALtkNEdlFHsi4jOsam0Sm6dcXXJRnP6c1Fk7RKtR9Dc+OwFjeLRiohV7Bay+2hWn8ZvkV8ifddovHq5Z9KNgRJDGjPD2pJ0TOqNnaf5LQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by DU4PR04MB12064.eurprd04.prod.outlook.com (2603:10a6:10:63f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 11:29:57 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 11:29:57 +0000
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
Subject: [PATCH v4 net-next 12/14] net: dsa: netc: add more basic functions support
Date: Tue, 31 Mar 2026 19:30:23 +0800
Message-Id: <20260331113025.1566878-13-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7284:EE_|DU4PR04MB12064:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f2725fc-3d1d-43e2-6f7f-08de8f18d647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|52116014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jG8l6ekWSfDlmAsfD9xEMDNIEM1w0uWf7UXSuYPjc88Ax88J2xOEwUE0RRPX/4YJAhLG9k5Ju0tNTthqnkNqLUI8XmW3jdVzisJUK6lWNjlxSt23at5DmM3hWZ2/6TQHkuFNvTUKOcdBYGT1qWKlBMWiraiPpGBuE6qUQ62B2xEX22oxF+Sgw6hBo6Xb8wg6w+qpIK6Pt+PMdRrQqyt6jV4SnctARxGIumFoFYJ10rIzPBrmM7Hcm2LH+oYe5S+zvcGnw5+Q3icUyy71qXQIm+8fn6xhMvd1Bct1xCLTc9ohnErkpbTBvoemX3CNdJ+glypru8BvDW51VOKWwe/8r3OUl/bWcRR/tqmPH5QNvyRtFsQG9mDgQjRbcDaDV1Jl1CVPw2c7btm3cXeEaFE7Q/KgSwilRYryscIzSNs+GWd74ux/cstKyeEP+/scWUCRTRrFP1AvpjPsmDTw/JjgbPxqHIbyfkWbXJVaAYj23DBZ0RH2KYIcA02NMD/R+Y3Yp+o8a8eLjjZSGA219nauAPL8z35WnaJeO5Um94OPk36XdUHwM5deTlo4mfZrYhPh66HR8JtkGLBnok9oFK33mLNy/veMKof1rE4BEywEUB8J75yNcKCAu/wmFvJGrSLOZ5LxSam6Onusf81RgDjEFOYTPMKCkZDAbWQ2tmBdNGwS4nk74bqKurt24DWoos02spQnVSz5O3wB9uEOthDcUAnNwFjU7yl9OkRPoYjXVKk5gnCmiezQnh7hC4n/a0owoKEmN5pf3UkLWe02VFgEaF5M0bFFiO25CPGaCDgOdYbgi/bsNCUTFXYuk7cccX2M
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?72uy+q0W1rtUmFrAITFzczEGKTMJeewXijE1fPVBUC1Ch8jnpu6WH/EwEmF8?=
 =?us-ascii?Q?XPkzIzd6aVCTD15TIBDp8u2iboProphhY8/N1r3VNSZBrqL/hTvDa3Gs1/la?=
 =?us-ascii?Q?Uia4/a5W8Q/qVk6ktSIP6QVZibgVrpgiiosIFT4o9H8YRt/s9DEW8u+LQxpB?=
 =?us-ascii?Q?etFAylpV9SHbl6PYBTA6QNSqSbkdxU+yqY54yoaybKT2rNBJ0OWAgtADfYhy?=
 =?us-ascii?Q?Th6/56lQ1m9bNmmbH5O9bx2dNRXEVkVMe/evDwIXYgYVWtQPT3bpNXrUbC7u?=
 =?us-ascii?Q?b4m91aAgE4g9EdQmMbEZaO6yKJvllAScp/yEYWM9P0iqRtvnPf/jCQsj3sn7?=
 =?us-ascii?Q?gH1CShgpM9B7i4BMKfxHVJRwu9yUf9E1bx3VbScBvJBPyEz3K1R7I/3UzexZ?=
 =?us-ascii?Q?a9au5c03EVVaxFcMX/2TSSfKfHzrAxoUgSN3wQeX3zKQuAKkwX1ZyOMT51N9?=
 =?us-ascii?Q?CfegcEtEseUNiIhUFWaHfnJLcd1xmMe925bcicsemPCgDBZKUVuPzjXPzbCS?=
 =?us-ascii?Q?YFZ3I9SSQ8DkTFlRcYez5fOagC8eIGUAUgRo1Xhusi717NWEyhM11dIZG8vw?=
 =?us-ascii?Q?iSN88TyobXyXakoxHa5jj8zQO4Rzz6w8YDpF3UEAFqO0fX9nRcP0Ub9ns+6d?=
 =?us-ascii?Q?cNojbdkPBTmAnVdgE90DB1m755FIsEEX86HceIJGkeaveFFqfN3u4VyKj1lb?=
 =?us-ascii?Q?+IQRAMkV95DProIweeUnq66C2UWDTg+8TKczGx5y7AReOIhIgKiQ0anuCokA?=
 =?us-ascii?Q?L0s+rNJuY4DEdELJPQnpXJx4IUWJQpnDiDmvTNchBwnaNmWVnrdV3j05Z9xD?=
 =?us-ascii?Q?AkAsoLLyxPC3/gPqb6aMLou6QIFB7lhR5SRFEU1qHuyMO4HCxz+QoMh3gMdl?=
 =?us-ascii?Q?aDnLGeDIKkjzG4mOSHnX4L35GRIwECSFZzqox5GCuP1BObj1XIkoV8Zm2k2+?=
 =?us-ascii?Q?PQhJU1zxG92qwMJVlMksCpdLVLBAjgC7cSKaFR/eHmz212c58nhBagVgwZGg?=
 =?us-ascii?Q?FLI4cdrJBo0Op2UQxvToDe84qXciXkTg9S3fcQy6vHPUMqa82+YnxuBYf4pG?=
 =?us-ascii?Q?+s8LHDGo16Cs2k/uBLrccEpfy/rALdiIGTViTOVT8dBLGtV4xB+iaVwpQQzp?=
 =?us-ascii?Q?x8pJeSrQSy7FT03+ilJK5RZaqRFXKG+cCyXoCEmRXjyaMcrqKL4pTVbnFQkS?=
 =?us-ascii?Q?hV+OX7Hf+AABYGzAEeG8JQg/dLjJd8SoMpaxieqKRxgpqowG+0jYt9rhdmR2?=
 =?us-ascii?Q?k6kaWcqvZ4r56fRyxKDWTf374KcgVitqo7KCMjfGTtNA0n/h0638nNusWGLz?=
 =?us-ascii?Q?ebmLBYj/T52NZfLpxx53giqHVfhdfGChAIBvKKiFrjQW+15nEq1KwgpRJvg+?=
 =?us-ascii?Q?qZgTz3kROolatgw7JKzMcJBX3KkYsYge6P/lY5IuA5X/KQ6SQMRGT5Ep6jv/?=
 =?us-ascii?Q?zp1CtyM5XVOI5nIaQ8ECBnMAdCOiECOdQm+rUufIQ9MBwTuKOmDM1TdE/VKc?=
 =?us-ascii?Q?tF3wO9hf9CROOspfWtDH0K+l5LuImu/LzuuANaFqJuJrZTx0RCBBmPMIEwev?=
 =?us-ascii?Q?aJm5+lBuEsMjdtg0A9crMv0GVJbAugTtYdMaPD3zGwGAEQ5kvJthJFJzqO8X?=
 =?us-ascii?Q?bUiFY82cmYL8QMBtvl5uRAaeI29S9UsrHShJMuy7XFw9BDnBxyLhe+0GQnO7?=
 =?us-ascii?Q?BjxYTv10F8Iw11zT7dWl0YHB7ssPm9wzgW9xJxlReZ0i56LmYbFu+xgvuYUC?=
 =?us-ascii?Q?aoTIwMcD5g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2725fc-3d1d-43e2-6f7f-08de8f18d647
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 11:29:57.2796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPrWAvft1mjYRxajfANWm2Y3dz152AaUZ+v6a/UcwrZGY8AzIQoNUU5ts5qgWxo5HPpX/yd+tfUsiyQ74P2D+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12064

This patch expands the NETC switch driver with several foundational
features, including FDB and MDB management, STP state handling, MTU
configuration, port setup/teardown, and host flooding support.

At this stage, the driver operates only in standalone port mode. Each
port uses VLAN 0 as its PVID, meaning ingress frames are internally
assigned VID 0 regardless of whether they arrive tagged or untagged.
Note that this does not inject a VLAN 0 header into the frame, the VID
is used purely for subsequent VLAN processing within the switch.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c      | 540 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h    |  33 ++
 drivers/net/dsa/netc/netc_switch_hw.h |  11 +
 3 files changed, 584 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index f11f5d0f6a6d..3609d83ac363 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -7,11 +7,36 @@
 #include <linux/clk.h>
 #include <linux/etherdevice.h>
 #include <linux/fsl/enetc_mdio.h>
+#include <linux/if_bridge.h>
 #include <linux/if_vlan.h>
 #include <linux/of_mdio.h>
 
 #include "netc_switch.h"
 
+static struct netc_fdb_entry *
+netc_lookup_fdb_entry(struct netc_switch *priv,
+		      const unsigned char *addr,
+		      u16 vid)
+{
+	struct netc_fdb_entry *entry;
+
+	hlist_for_each_entry(entry, &priv->fdb_list, node)
+		if (ether_addr_equal(entry->keye.mac_addr, addr) &&
+		    le16_to_cpu(entry->keye.fid) == vid)
+			return entry;
+
+	return NULL;
+}
+
+static void netc_destroy_fdb_list(struct netc_switch *priv)
+{
+	struct netc_fdb_entry *entry;
+	struct hlist_node *tmp;
+
+	hlist_for_each_entry_safe(entry, tmp, &priv->fdb_list, node)
+		netc_del_fdb_entry(entry);
+}
+
 static enum dsa_tag_protocol
 netc_get_tag_protocol(struct dsa_switch *ds, int port,
 		      enum dsa_tag_protocol mprot)
@@ -386,6 +411,212 @@ static void netc_port_default_config(struct netc_port *np)
 	netc_port_rmw(np, NETC_POR, PCR_TXDIS, 0);
 }
 
+static u32 netc_available_port_bitmap(struct netc_switch *priv)
+{
+	struct dsa_port *dp;
+	u32 bitmap = 0;
+
+	dsa_switch_for_each_available_port(dp, priv->ds)
+		bitmap |= BIT(dp->index);
+
+	return bitmap;
+}
+
+static int netc_add_standalone_vlan_entry(struct netc_switch *priv)
+{
+	u32 bitmap_stg = VFT_STG_ID(0) | netc_available_port_bitmap(priv);
+	struct vft_cfge_data *cfge;
+	u16 cfg;
+	int err;
+
+	cfge = kzalloc_obj(*cfge);
+	if (!cfge)
+		return -ENOMEM;
+
+	cfge->bitmap_stg = cpu_to_le32(bitmap_stg);
+	cfge->et_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+	cfge->fid = cpu_to_le16(NETC_STANDALONE_PVID);
+
+	/* For standalone ports, MAC learning needs to be disabled, so frames
+	 * from other user ports will not be forwarded to the standalone ports,
+	 * because there are no FDB entries on the standalone ports. Also, the
+	 * frames received by the standalone ports cannot be flooded to other
+	 * ports, so MAC forwarding option needs to be set to
+	 * MFO_NO_MATCH_DISCARD, so the frames will discarded rather than
+	 * flooding to other ports.
+	 */
+	cfg = FIELD_PREP(VFT_MLO, MLO_DISABLE) |
+	      FIELD_PREP(VFT_MFO, MFO_NO_MATCH_DISCARD);
+	cfge->cfg = cpu_to_le16(cfg);
+
+	err = ntmp_vft_add_entry(&priv->ntmp, NETC_STANDALONE_PVID, cfge);
+	if (err)
+		dev_err(priv->dev,
+			"Failed to add standalone VLAN entry\n");
+
+	kfree(cfge);
+
+	return err;
+}
+
+static int netc_port_add_fdb_entry(struct netc_port *np,
+				   const unsigned char *addr, u16 vid)
+{
+	struct netc_switch *priv = np->switch_priv;
+	struct netc_fdb_entry *entry;
+	struct fdbt_keye_data *keye;
+	struct fdbt_cfge_data *cfge;
+	int port = np->dp->index;
+	u32 cfg = 0;
+	int err;
+
+	entry = kzalloc_obj(*entry);
+	if (!entry)
+		return -ENOMEM;
+
+	keye = &entry->keye;
+	cfge = &entry->cfge;
+	ether_addr_copy(keye->mac_addr, addr);
+	keye->fid = cpu_to_le16(vid);
+
+	cfge->port_bitmap = cpu_to_le32(BIT(port));
+	cfge->cfg = cpu_to_le32(cfg);
+	cfge->et_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+
+	err = ntmp_fdbt_add_entry(&priv->ntmp, &entry->entry_id, keye, cfge);
+	if (err) {
+		kfree(entry);
+
+		return err;
+	}
+
+	netc_add_fdb_entry(priv, entry);
+
+	return 0;
+}
+
+static int netc_port_set_fdb_entry(struct netc_port *np,
+				   const unsigned char *addr, u16 vid)
+{
+	struct netc_switch *priv = np->switch_priv;
+	struct netc_fdb_entry *entry;
+	int port = np->dp->index;
+	u32 port_bitmap;
+	int err = 0;
+
+	mutex_lock(&priv->fdbt_lock);
+
+	entry = netc_lookup_fdb_entry(priv, addr, vid);
+	if (!entry) {
+		err = netc_port_add_fdb_entry(np, addr, vid);
+		if (err)
+			dev_err(priv->dev,
+				"Failed to add FDB entry on port %d\n",
+				port);
+
+		goto unlock_fdbt;
+	}
+
+	port_bitmap = le32_to_cpu(entry->cfge.port_bitmap);
+	/* If the entry already exists on the port, return 0 directly */
+	if (unlikely(port_bitmap & BIT(port)))
+		goto unlock_fdbt;
+
+	/* If the entry already exists, but not on this port, we need to
+	 * update the port bitmap. In general, it should only be valid
+	 * for multicast or broadcast address.
+	 */
+	port_bitmap ^= BIT(port);
+	entry->cfge.port_bitmap = cpu_to_le32(port_bitmap);
+	err = ntmp_fdbt_update_entry(&priv->ntmp, entry->entry_id,
+				     &entry->cfge);
+	if (err) {
+		port_bitmap ^= BIT(port);
+		entry->cfge.port_bitmap = cpu_to_le32(port_bitmap);
+		dev_err(priv->dev, "Failed to set FDB entry on port %d\n",
+			port);
+	}
+
+unlock_fdbt:
+	mutex_unlock(&priv->fdbt_lock);
+
+	return err;
+}
+
+static int netc_port_del_fdb_entry(struct netc_port *np,
+				   const unsigned char *addr, u16 vid)
+{
+	struct netc_switch *priv = np->switch_priv;
+	struct ntmp_user *ntmp = &priv->ntmp;
+	struct netc_fdb_entry *entry;
+	int port = np->dp->index;
+	u32 port_bitmap;
+	int err = 0;
+
+	mutex_lock(&priv->fdbt_lock);
+
+	entry = netc_lookup_fdb_entry(priv, addr, vid);
+	if (unlikely(!entry))
+		goto unlock_fdbt;
+
+	port_bitmap = le32_to_cpu(entry->cfge.port_bitmap);
+	if (unlikely(!(port_bitmap & BIT(port))))
+		goto unlock_fdbt;
+
+	if (port_bitmap != BIT(port)) {
+		/* If the entry also exists on other ports, we need to
+		 * update the entry in the FDB table.
+		 */
+		port_bitmap ^= BIT(port);
+		entry->cfge.port_bitmap = cpu_to_le32(port_bitmap);
+		err = ntmp_fdbt_update_entry(ntmp, entry->entry_id,
+					     &entry->cfge);
+		if (err) {
+			port_bitmap ^= BIT(port);
+			entry->cfge.port_bitmap = cpu_to_le32(port_bitmap);
+			goto unlock_fdbt;
+		}
+	} else {
+		/* If the entry only exists on this port, just delete
+		 * it from the FDB table.
+		 */
+		err = ntmp_fdbt_delete_entry(ntmp, entry->entry_id);
+		if (err)
+			goto unlock_fdbt;
+
+		netc_del_fdb_entry(entry);
+	}
+
+unlock_fdbt:
+	mutex_unlock(&priv->fdbt_lock);
+
+	return err;
+}
+
+static int netc_add_standalone_fdb_bcast_entry(struct netc_switch *priv)
+{
+	const u8 bcast[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+	struct dsa_port *dp, *cpu_dp = NULL;
+
+	dsa_switch_for_each_cpu_port(dp, priv->ds) {
+		cpu_dp = dp;
+		break;
+	}
+
+	if (!cpu_dp)
+		return -ENODEV;
+
+	/* If the user port acts as a standalone port, then its PVID is 0,
+	 * MLO is set to "disable MAC learning" and MFO is set to "discard
+	 * frames if no matching entry found in FDB table". Therefore, we
+	 * need to add a broadcast FDB entry on the CPU port so that the
+	 * broadcast frames received on the user port can be forwarded to
+	 * the CPU port.
+	 */
+	return netc_port_set_fdb_entry(NETC_PORT(priv->ds, cpu_dp->index),
+				       bcast, NETC_STANDALONE_PVID);
+}
+
 static int netc_setup(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
@@ -404,19 +635,61 @@ static int netc_setup(struct dsa_switch *ds)
 	if (err)
 		return err;
 
+	INIT_HLIST_HEAD(&priv->fdb_list);
+	mutex_init(&priv->fdbt_lock);
+
 	netc_switch_fixed_config(priv);
 
 	/* default setting for ports */
 	dsa_switch_for_each_available_port(dp, ds)
 		netc_port_default_config(priv->ports[dp->index]);
 
+	err = netc_add_standalone_vlan_entry(priv);
+	if (err)
+		goto free_lock_and_ntmp_user;
+
+	err = netc_add_standalone_fdb_bcast_entry(priv);
+	if (err)
+		goto free_lock_and_ntmp_user;
+
 	return 0;
+
+free_lock_and_ntmp_user:
+	mutex_destroy(&priv->fdbt_lock);
+	netc_free_ntmp_user(priv);
+
+	return err;
+}
+
+static void netc_destroy_all_lists(struct netc_switch *priv)
+{
+	netc_destroy_fdb_list(priv);
+	mutex_destroy(&priv->fdbt_lock);
+}
+
+static void netc_free_host_flood_rules(struct netc_switch *priv)
+{
+	struct dsa_port *dp;
+
+	dsa_switch_for_each_user_port(dp, priv->ds) {
+		struct netc_port *np = priv->ports[dp->index];
+
+		/* No need to clear the hardware IPFT entry. Because PCIe
+		 * FLR will be performed when the switch is re-registered,
+		 * it will reset hardware state. So only need to free the
+		 * memory to avoid memory leak.
+		 */
+		kfree(np->host_flood);
+		np->host_flood = NULL;
+	}
 }
 
 static void netc_teardown(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
 
+	netc_destroy_all_lists(priv);
+	netc_free_host_flood_rules(priv);
 	netc_free_ntmp_user(priv);
 }
 
@@ -569,6 +842,261 @@ static void netc_switch_get_ip_revision(struct netc_switch *priv)
 	priv->revision = val & IPBRR0_IP_REV;
 }
 
+static int netc_port_enable(struct dsa_switch *ds, int port,
+			    struct phy_device *phy)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	int err;
+
+	if (np->enable)
+		return 0;
+
+	err = clk_prepare_enable(np->ref_clk);
+	if (err) {
+		dev_err(ds->dev,
+			"Failed to enable enet_ref_clk of port %d\n", port);
+		return err;
+	}
+
+	np->enable = true;
+
+	return 0;
+}
+
+static void netc_port_disable(struct dsa_switch *ds, int port)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	/* When .port_disable() is called, .port_enable() may not have been
+	 * called. In this case, both the prepare_count and enable_count of
+	 * clock are 0. Calling clk_disable_unprepare() at this time will
+	 * cause warnings.
+	 */
+	if (!np->enable)
+		return;
+
+	clk_disable_unprepare(np->ref_clk);
+	np->enable = false;
+}
+
+static void netc_port_stp_state_set(struct dsa_switch *ds,
+				    int port, u8 state)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	u32 val;
+
+	switch (state) {
+	case BR_STATE_DISABLED:
+	case BR_STATE_LISTENING:
+	case BR_STATE_BLOCKING:
+		val = NETC_STG_STATE_DISABLED;
+		break;
+	case BR_STATE_LEARNING:
+		val = NETC_STG_STATE_LEARNING;
+		break;
+	case BR_STATE_FORWARDING:
+		val = NETC_STG_STATE_FORWARDING;
+		break;
+	default:
+		return;
+	}
+
+	netc_port_wr(np, NETC_BPSTGSR, val);
+}
+
+static int netc_port_change_mtu(struct dsa_switch *ds,
+				int port, int mtu)
+{
+	u32 max_frame_size = mtu + VLAN_ETH_HLEN + ETH_FCS_LEN;
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	if (dsa_is_cpu_port(ds, port))
+		max_frame_size += NETC_TAG_MAX_LEN;
+
+	netc_port_set_max_frame_size(np, max_frame_size);
+
+	return 0;
+}
+
+static int netc_port_max_mtu(struct dsa_switch *ds, int port)
+{
+	return NETC_MAX_FRAME_LEN - VLAN_ETH_HLEN - ETH_FCS_LEN;
+}
+
+static int netc_port_fdb_add(struct dsa_switch *ds, int port,
+			     const unsigned char *addr, u16 vid,
+			     struct dsa_db db)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	/* Currently, we only support standalone port mode, so all VLANs
+	 * should be converted to NETC_STANDALONE_PVID.
+	 */
+	return netc_port_set_fdb_entry(np, addr, NETC_STANDALONE_PVID);
+}
+
+static int netc_port_fdb_del(struct dsa_switch *ds, int port,
+			     const unsigned char *addr, u16 vid,
+			     struct dsa_db db)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	return netc_port_del_fdb_entry(np, addr, NETC_STANDALONE_PVID);
+}
+
+static int netc_port_fdb_dump(struct dsa_switch *ds, int port,
+			      dsa_fdb_dump_cb_t *cb, void *data)
+{
+	struct netc_switch *priv = ds->priv;
+	u32 resume_eid = NTMP_NULL_ENTRY_ID;
+	struct fdbt_entry_data *entry;
+	struct fdbt_keye_data *keye;
+	struct fdbt_cfge_data *cfge;
+	bool is_static;
+	u32 cfg;
+	int err;
+	u16 vid;
+
+	entry = kmalloc_obj(*entry);
+	if (!entry)
+		return -ENOMEM;
+
+	keye = &entry->keye;
+	cfge = &entry->cfge;
+	mutex_lock(&priv->fdbt_lock);
+
+	do {
+		memset(entry, 0, sizeof(*entry));
+		err = ntmp_fdbt_search_port_entry(&priv->ntmp, port,
+						  &resume_eid, entry);
+		if (err || entry->entry_id == NTMP_NULL_ENTRY_ID)
+			break;
+
+		cfg = le32_to_cpu(cfge->cfg);
+		is_static = (cfg & FDBT_DYNAMIC) ? false : true;
+		vid = le16_to_cpu(keye->fid);
+
+		err = cb(keye->mac_addr, vid, is_static, data);
+		if (err)
+			break;
+	} while (resume_eid != NTMP_NULL_ENTRY_ID);
+
+	mutex_unlock(&priv->fdbt_lock);
+	kfree(entry);
+
+	return err;
+}
+
+static int netc_port_mdb_add(struct dsa_switch *ds, int port,
+			     const struct switchdev_obj_port_mdb *mdb,
+			     struct dsa_db db)
+{
+	return netc_port_fdb_add(ds, port, mdb->addr, mdb->vid, db);
+}
+
+static int netc_port_mdb_del(struct dsa_switch *ds, int port,
+			     const struct switchdev_obj_port_mdb *mdb,
+			     struct dsa_db db)
+{
+	return netc_port_fdb_del(ds, port, mdb->addr, mdb->vid, db);
+}
+
+static int netc_port_add_host_flood_rule(struct netc_port *np,
+					 bool uc, bool mc)
+{
+	const u8 dmac_mask[ETH_ALEN] = {0x1, 0, 0, 0, 0, 0};
+	struct netc_switch *priv = np->switch_priv;
+	struct ipft_entry_data *host_flood;
+	struct ipft_keye_data *keye;
+	struct ipft_cfge_data *cfge;
+	u16 src_port;
+	u32 cfg;
+	int err;
+
+	if (!uc && !mc)
+		return 0;
+
+	host_flood = kzalloc_obj(*host_flood);
+	if (!host_flood)
+		return -ENOMEM;
+
+	keye = &host_flood->keye;
+	cfge = &host_flood->cfge;
+
+	src_port = FIELD_PREP(IPFT_SRC_PORT, np->dp->index);
+	src_port |= IPFT_SRC_PORT_MASK;
+	keye->src_port = cpu_to_le16(src_port);
+
+	/* If either only unicast or only multicast need to be flooded
+	 * to the host, we always set the mask that tests the first MAC
+	 * DA octet. The value should be 0 for the first bit (if unicast
+	 * has to be flooded) or 1 (if multicast). If both unicast and
+	 * multicast have to be flooded, we leave the key mask empty, so
+	 * it matches everything.
+	 */
+	if (uc && !mc)
+		ether_addr_copy(keye->dmac_mask, dmac_mask);
+
+	if (!uc && mc) {
+		ether_addr_copy(keye->dmac, dmac_mask);
+		ether_addr_copy(keye->dmac_mask, dmac_mask);
+	}
+
+	cfg = FIELD_PREP(IPFT_FLTFA, IPFT_FLTFA_REDIRECT);
+	cfg |= FIELD_PREP(IPFT_HR, NETC_HR_HOST_FLOOD);
+	cfge->cfg = cpu_to_le32(cfg);
+
+	err = ntmp_ipft_add_entry(&priv->ntmp, host_flood);
+	if (err) {
+		kfree(host_flood);
+		return err;
+	}
+
+	np->uc = uc;
+	np->mc = mc;
+	np->host_flood = host_flood;
+	/* Enable ingress port filter table lookup */
+	netc_port_wr(np, NETC_PIPFCR, PIPFCR_EN);
+
+	return 0;
+}
+
+static void netc_port_remove_host_flood(struct netc_port *np)
+{
+	struct netc_switch *priv = np->switch_priv;
+
+	if (!np->host_flood)
+		return;
+
+	ntmp_ipft_delete_entry(&priv->ntmp, np->host_flood->entry_id);
+	kfree(np->host_flood);
+	np->host_flood = NULL;
+	np->uc = false;
+	np->mc = false;
+	/* Disable ingress port filter table lookup */
+	netc_port_wr(np, NETC_PIPFCR, 0);
+}
+
+static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
+				     bool uc, bool mc)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	if (np->uc == uc && np->mc == mc)
+		return;
+
+	/* IPFT does not support in-place updates to the KEYE element,
+	 * so we need to delete the old IPFT entry and then add a new
+	 * one.
+	 */
+	if (np->host_flood)
+		netc_port_remove_host_flood(np);
+
+	if (netc_port_add_host_flood_rule(np, uc, mc))
+		dev_err(ds->dev, "Failed to add host flood rule on port %d\n",
+			port);
+}
+
 static void netc_phylink_get_caps(struct dsa_switch *ds, int port,
 				  struct phylink_config *config)
 {
@@ -751,6 +1279,17 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.setup				= netc_setup,
 	.teardown			= netc_teardown,
 	.phylink_get_caps		= netc_phylink_get_caps,
+	.port_enable			= netc_port_enable,
+	.port_disable			= netc_port_disable,
+	.port_stp_state_set		= netc_port_stp_state_set,
+	.port_change_mtu		= netc_port_change_mtu,
+	.port_max_mtu			= netc_port_max_mtu,
+	.port_fdb_add			= netc_port_fdb_add,
+	.port_fdb_del			= netc_port_fdb_del,
+	.port_fdb_dump			= netc_port_fdb_dump,
+	.port_mdb_add			= netc_port_mdb_add,
+	.port_mdb_del			= netc_port_mdb_del,
+	.port_set_host_flood		= netc_port_set_host_flood,
 };
 
 static int netc_switch_probe(struct pci_dev *pdev,
@@ -792,6 +1331,7 @@ static int netc_switch_probe(struct pci_dev *pdev,
 	ds->num_tx_queues = NETC_TC_NUM;
 	ds->ops = &netc_switch_ops;
 	ds->phylink_mac_ops = &netc_phylink_mac_ops;
+	ds->fdb_isolation = true;
 	ds->priv = priv;
 
 	priv->ds = ds;
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index eb65c36ecead..4b229a71578e 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -30,6 +30,8 @@
 
 #define NETC_MAX_FRAME_LEN		9600
 
+#define NETC_STANDALONE_PVID		0
+
 struct netc_switch;
 
 struct netc_switch_info {
@@ -43,6 +45,11 @@ struct netc_port_caps {
 	u32 pseudo_link:1;
 };
 
+enum netc_host_reason {
+	/* Software defined host reasons */
+	NETC_HR_HOST_FLOOD = 8,
+};
+
 struct netc_port {
 	void __iomem *iobase;
 	struct netc_switch *switch_priv;
@@ -50,6 +57,11 @@ struct netc_port {
 	struct dsa_port *dp;
 	struct clk *ref_clk; /* RGMII/RMII reference clock */
 	struct mii_bus *emdio;
+
+	u16 enable:1;
+	u16 uc:1;
+	u16 mc:1;
+	struct ipft_entry_data *host_flood;
 };
 
 struct netc_switch_regs {
@@ -58,6 +70,13 @@ struct netc_switch_regs {
 	void __iomem *global;
 };
 
+struct netc_fdb_entry {
+	u32 entry_id;
+	struct fdbt_cfge_data cfge;
+	struct fdbt_keye_data keye;
+	struct hlist_node node;
+};
+
 struct netc_switch {
 	struct pci_dev *pdev;
 	struct device *dev;
@@ -69,6 +88,8 @@ struct netc_switch {
 	struct netc_port **ports;
 
 	struct ntmp_user ntmp;
+	struct hlist_head fdb_list;
+	struct mutex fdbt_lock; /* FDB table lock */
 };
 
 #define NETC_PRIV(ds)			((struct netc_switch *)((ds)->priv))
@@ -91,6 +112,18 @@ static inline bool is_netc_pseudo_port(struct netc_port *np)
 	return np->caps.pseudo_link;
 }
 
+static inline void netc_add_fdb_entry(struct netc_switch *priv,
+				      struct netc_fdb_entry *entry)
+{
+	hlist_add_head(&entry->node, &priv->fdb_list);
+}
+
+static inline void netc_del_fdb_entry(struct netc_fdb_entry *entry)
+{
+	hlist_del(&entry->node);
+	kfree(entry);
+}
+
 int netc_switch_platform_probe(struct netc_switch *priv);
 
 #endif
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index 881122004644..c6a0c0a8ff8a 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -67,6 +67,9 @@
 #define  PQOSMR_VQMP			GENMASK(19, 16)
 #define  PQOSMR_QVMP			GENMASK(23, 20)
 
+#define NETC_PIPFCR			0x0084
+#define  PIPFCR_EN			BIT(0)
+
 #define NETC_POR			0x100
 #define  PCR_TXDIS			BIT(0)
 #define  PCR_RXDIS			BIT(1)
@@ -122,6 +125,14 @@ enum netc_mfo {
 #define  BPDVR_RXVAM			BIT(24)
 #define  BPDVR_TXTAGA			GENMASK(26, 25)
 
+#define NETC_BPSTGSR			0x520
+
+enum netc_stg_stage {
+	NETC_STG_STATE_DISABLED = 0,
+	NETC_STG_STATE_LEARNING,
+	NETC_STG_STATE_FORWARDING,
+};
+
 /* Definition of Switch ethernet MAC port registers */
 #define NETC_PMAC_OFFSET		0x400
 #define NETC_PM_CMD_CFG(a)		(0x1008 + (a) * 0x400)
-- 
2.34.1



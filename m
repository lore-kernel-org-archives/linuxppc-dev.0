Return-Path: <linuxppc-dev+bounces-22525-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50374CD98C7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 19:41:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbtL00rS8z3c2q;
	Fri, 12 Jun 2026 05:40:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781206856;
	cv=pass; b=JwQnjymLvFSS2A5JyUd7Vo7piNPRue0PC94NOXwNbVBfzXv7qnddcMAnBbBVCgbOWUavpQ/OaSr+sjqYQfA4urAbys7YHxDnX1YY1+8sFoqpVIpSQSxCk6eN9WQob6HtQ0qGkzRh4wC357DsnT39eWN1nINy2vZvjsR1kfTtZYRgw81qXLSw58e1lF7BzMPKjjedGiQsrDiLJZlZo+m2ggM2qljIjUSHvKZVt6t5F10FhjmMAc+zYjZ2+w2HI9HBpn6iU1RAxQbzVhbbqlr/SQXw+gePZOH0Qbirseu+ptUw2ieEb7idCNXo2LCjryMb/4CVSLBisLvFaQqCsrzC/g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781206856; c=relaxed/relaxed;
	bh=C4MUnE4qFC4d+DmJlHjnQ2FdW7UYxcoYvMsyKRZt3AM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k2ejBI/MBWEcZ32krfqvCjSIpMXrpQZGHzGAcSh+ppSGVeX4ic3PoWZH97YyzcnJarNDhx5y3vR8WLuIe5XSFOcy5Vm8/ALz6T55fQwYiMhrqJjHHND9hYcYahfIidoZoNFvXbPuxesw+dV3LmQC5SYOCojnZQPI6UTMIUkf6KP/sGXXj4h1zRPtTGgd/B5n9CYy7MORRug7PA+Bg1DCc6s/mCg78+GuQEMFmwG7SlVIALqI2yHK29XLsVxUusMyKtkjlUNMs6hYiNYGch98/KZvNgny9M2uy9Iml2A0/BetfGwGRH/dDpCaZ+VanIlAt4L8YKh+K5nqGcGuqvHx5g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=oEuJjLsf; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=oEuJjLsf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbtKy4yzyz3c1L
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 05:40:54 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e42C01NsGLtydoIA4uIZdWfDgrky8U1XKWkE5rPZdzVT3uoJJ+2pQwczn5Djv2Z2qV2QUAlJKTVg5fHXQNEVNRlIvFPDqqDAS+UOuULtfzj/t6QLzjsMUqtVmbsAWEfGOMHml9bBD54Odgc16aA0VbX2lvq68y3tAWKC4V5cmK6HDPsolwORsvfG1wpIeUPbVpL5Xp2r0QZ0juexzv7q1CAKvmhZo1cXGOfV12r2s5d17z4TBwi+Ckr45wqT+QkLw6Tow5LJfmG/dK4CW6WsncwXZflUvhvNsPWJDTdgDMHVwkfi3XLZcd+ur6fxVfNcCL5Kpo/t8IdMrpHDxrr9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4MUnE4qFC4d+DmJlHjnQ2FdW7UYxcoYvMsyKRZt3AM=;
 b=wqmKj4ehIMBQ9NuWRWMkqURXAB2MqbV6kh05x4+ia7FTlgMM8w+M8hYMDqIIQTlzOZcgAHNLgpsH7e6i5+hxuyjNRm8JmxU0q2Yw7U6FfmYsJm6GedCjmeVtM9pY5dJhE0LqfkkxUae9qw9bVFd0j+red/7yDQxw6Y+ZJIpbMn/wH4oLml6lHQ7Tdanu3gYRjUMM+BdPcOLiqweC2fcz2Txi1QpSORVvFRV9Id3Jfq4+jPJZq6Vx59fXyqx1GlgWjm4jLMq24/y6089Xp41MlymFmfDEszJKMLmNLmtg7cCRajP5jma9Q4nUY3HDlEfzznHo0JrQvFJpoQop26NHBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4MUnE4qFC4d+DmJlHjnQ2FdW7UYxcoYvMsyKRZt3AM=;
 b=oEuJjLsf2Q04EDI8bXjObq0MspuS4/I/SF+qA58ZNOhQqxDiKLMEKl/U+4LrinpZtSmFnnYUq5ofCANsveYhNj/pzNLscmQybwug5rbTb2pUsPzuP8TwBew68lKl5my2KnIwra02Q03ElgBEd9/O5Na1hwPJ3xRohlXNpYgIXX6selw/OZyNzd02I7wqLmpUj0Vo/uULn0EM3E1efuD+5S5K6+Mfm/S7iBYwEzR0nWE/NQ8YUcLEbjuH1WDJafaDVbT0AOUbtVYWju2yYGmwlq81sAeHgrabmylL0P1acvoKH4im0ufcxDfaSpfIJKz7RzZ3cNQQX5yWVjKO4gbqIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by GVXPR04MB11017.eurprd04.prod.outlook.com (2603:10a6:150:21c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 19:40:33 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 19:40:33 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tanjeff Moos <tanjeff.moos@westermo.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 phy-next 8/8] phy: lynx-10g: use RCW override procedure for dynamic protocol change
Date: Thu, 11 Jun 2026 22:39:40 +0300
Message-Id: <20260611193940.44416-9-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611193940.44416-1-vladimir.oltean@nxp.com>
References: <20260611193940.44416-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::19) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|GVXPR04MB11017:EE_
X-MS-Office365-Filtering-Correlation-Id: 9711df4a-017d-436f-6409-08dec7f14d46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|19092799006|366016|7416014|23010399003|1800799024|18002099003|6133799003|22082099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	x8jXjepjHha+NsRfF9z4haP7OlDf2T9316ItCSeB1oTcc8ZnGxEGL9VfCZdMtOgyatVTYRdE4FDjBmfkDOK0+GbegIFzaOhc1qxbJpsuSBgtdcH+G33C4Z/YIp0NQyYlu6wmkiH6idCd9IEp74Nt1WDvjXsI7zSvkuHgy4PncA3t0KcKrG/fr2TngAp036yB0C5nXxUiVhUdqWrE78+i9BJ+vLwCDAC6jbYhWuXbsYjOHC0hMbl0Eixu5mmInP1UgWKAQ6MvuLd5wQ039bHflhT9ECvH1gCyXTtpjKmdKZu9Zhfyw748dwMvCoS9FtL4TiP3uV+/wEWSZ1Rr6aTTtNQjaZa3nbyp7mwciwIz2BZGnpo+FCRms1dlF9jdzrtaqw1CtDUV3dGLPwgqPZMU+iFRCQJ20N6MQFOZbxUN8syckXgd+wuhXpW0aLAmN2ZvB9jrNELjQbcbSELJ9KafgfXzptmrEZmpTXb9WnXaWhUgr0bzeVrVKl5eFJ50tjPnBNdY5o9mhdlsa0FyWS7jOvrbjsFKP+UMjcMMVL6ZC4Cas9Bq+Qkpm7uOVFZw0A5hXv//wq0odt8XkJVF/E5kn5wMfmOiMZYO0ES7GIkjLTBaMjsMGJV6Iq+N+/ZK/Luk9O0o0Pm/k1xdaapEl95Mp1SHULGZGtjikIDp+JojH+oAOs77Ob1vnUUBpUQ6wlImuc7NP/kSmq+SAYdZ+jgnRg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(19092799006)(366016)(7416014)(23010399003)(1800799024)(18002099003)(6133799003)(22082099003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aY0kbN248GYvjlMwsIn4P1ZJRvhN+gGMxn1IFjDs0U4+arni2KKLN7RsXNYU?=
 =?us-ascii?Q?aV/H+Q6GFgP7oQ47xnEQfr0xJW0Now7C8EDqgOfBDe3A5JTfHu5G1ujkGyq5?=
 =?us-ascii?Q?owca3JY4IYUw8ZJWdXQwzEj8M5LWR7JXhnSeREUhZh9r/xTxQv9CYduAy0Y+?=
 =?us-ascii?Q?sgxf37wx2m3/GtwlZ/XzKnSpTO5EjR+apvheJCvZkdy/iULRp3SeM291pNfR?=
 =?us-ascii?Q?JfCuQh+f8MAk0gAEyK+h/8RZi59zKpr1JycisNqeiIHZqeIK02sKY8/y5tEl?=
 =?us-ascii?Q?sPB3v8q5Nx9TcUBFJ2iH78/uIDS19EMA/uTu0Tigc9XgYuGe74iOTv2kz3gU?=
 =?us-ascii?Q?V6NNGVXfMR2VFkZg7v03frQi5FzWmKOsFqq+4qOCfatmJt21cZz1o4mXafmq?=
 =?us-ascii?Q?2BZKA12YMQBlaypMpxgPD6WD8faZ5NOZ42OjCXs0cJV2YKxff9p+Enxger1F?=
 =?us-ascii?Q?gN9T290zdvqCRDHy7+7phgs3YbQsVlFcwN+SmWtxhk/Ysp4YqNARsiboCnxc?=
 =?us-ascii?Q?ogtDccNC/ZNWXduAV+Xz2C7YDLqS9ELHiHpKSYRdfMS38I6Rvd3DuovEhABR?=
 =?us-ascii?Q?JG4F8/eLlYQy3uoE6E3DNQOcG7ZByDvxE8DDwNmfLyhm2TpEHuxiOcLgYLst?=
 =?us-ascii?Q?1qbmSl2UaKawbbauug/4U3oYq0OpmXAakFjElSvnL4B579Rc4vzkdJPxL87o?=
 =?us-ascii?Q?hNRfoa2ns+IENvdO317CXbPzkDNaeiPjlEQMxH3KJ3dqAtHg/63BBIRzfRJa?=
 =?us-ascii?Q?6u5dw4c7/U5MoJROB2h3V8ziDbQ0nzFizQQQhovwEZ938nAuXTiFtLu6IBv/?=
 =?us-ascii?Q?hZ3yErSKO9olzCnoGVIIIeJkXmUsj47VIn1h65OfRwwY0y2WbzkUUo01328b?=
 =?us-ascii?Q?d8ANkbm8i7RWT7TonXAvdHCMuX3oHzu9yMQ/1+IfEefjwlZvAlAhjqTIW1b3?=
 =?us-ascii?Q?/mN6k69MqLZEp6KDfmkllashFKzqQtXVtvx62uGScoN7rQpQzdM6K7oiIBsR?=
 =?us-ascii?Q?vuBTXGP4ygGCqoWfLqVQOKOPp6jXEzGSt4LKEEBoq3QdxghXxL6kntdly08e?=
 =?us-ascii?Q?S0hdCqmZOyxQuu+0N/aXUBqaDLer41CO00zrIlGToQqA56psSygAkVRHKwGd?=
 =?us-ascii?Q?Qo8WX1IdYJFMDD+bD1pEcnzoOslTjJxoSQ0XfJ3OalOmH0ZsS1EX8KdQVuFm?=
 =?us-ascii?Q?99YOIPXwC+iZ6jGoONtbxgFfAokE9nfi26mUAWT9t9KJo2Opkybr5XyGKTKU?=
 =?us-ascii?Q?DsQ8UFm5FpZnO11oC/AXyCdvDS1139CXkctvAa3t6aWt57kFGoqO96OysVC8?=
 =?us-ascii?Q?Z1QAS+0T16hAOdx7gANzDRUJEiqLaFp78Q1/0/icanQ70tY2XrYqQ4GEv97M?=
 =?us-ascii?Q?hhp/kx7wO69qI/ScKK6IoABu2zS5iReNdKgqGJ34vQRK2zsP+u4hnw5/gjFM?=
 =?us-ascii?Q?lyu704Y48ZuCv/POx+6n+xp3pSVlKxTErTrFUyTWdcBMct7yWqqMacFUfSEJ?=
 =?us-ascii?Q?4BiMzDG4jC81uMDXORGC/U/SEd3jkCldReyFA0bI3v5fY1cY2JSptf81zN7E?=
 =?us-ascii?Q?Ag2/A9IM0TxYt7goFuWxuGfYSmIVJa5xR4y0u8PGsllB5Q2h/ZJG9SU1AJeA?=
 =?us-ascii?Q?T2o7XdhLLYHktCX/pjMgPocKDk0MnynNz4q4WNENBLWV8d5pVLFCkO51tl6B?=
 =?us-ascii?Q?wkNA1siLblyzOv85Z0Shj2EGAgXUzW8gh6ZvJantt837KemAs4jKkn2i2/kT?=
 =?us-ascii?Q?nwPuSWJCnxIYtFozmyXWIHxPi4R4hNVmFmUwSstpmr14DxetWSAo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9711df4a-017d-436f-6409-08dec7f14d46
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 19:40:33.2116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4BgKjDUeJFz67P2PaE2HP0XbKaoUIVAPTh15kwTRDBxV1/MO2aPskQ9ydFq2H9+OBCqGZNYYYMRGbZp+VAVdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11017

Up until this patch, the only protocol change supported was between
1000Base-X/SGMII and 2500Base-X. The others require an RCW override
procedure which was lacking.

Since now the guts driver provides the means of applying this procedure,
make use of it and remove any comment which mentioned the limitation.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/phy/freescale/Kconfig            |  1 +
 drivers/phy/freescale/phy-fsl-lynx-10g.c | 24 +++++++++++++++---------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kconfig
index 5bf3864fbe64..d4e189fffbf8 100644
--- a/drivers/phy/freescale/Kconfig
+++ b/drivers/phy/freescale/Kconfig
@@ -58,6 +58,7 @@ config PHY_FSL_LYNX_10G
 	tristate "Freescale Layerscape Lynx 10G SerDes PHY support"
 	depends on OF
 	depends on ARCH_LAYERSCAPE || COMPILE_TEST
+	select FSL_GUTS
 	select GENERIC_PHY
 	select PHY_FSL_LYNX_CORE
 	help
diff --git a/drivers/phy/freescale/phy-fsl-lynx-10g.c b/drivers/phy/freescale/phy-fsl-lynx-10g.c
index 38def160ef1a..5ece7889aed7 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-10g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-10g.c
@@ -8,6 +8,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/workqueue.h>
+#include <linux/fsl/guts.h>
 
 #include "phy-fsl-lynx-core.h"
 
@@ -446,6 +447,7 @@ static void lynx_10g_lane_read_configuration(struct lynx_lane *lane)
 	}
 
 	lynx_10g_backup_pccr_val(lane);
+	fsl_guts_lane_init(priv->info->index, lane->id, lane->mode);
 }
 
 static int ls1028a_get_pccr(enum lynx_lane_mode lane_mode, int lane,
@@ -1167,14 +1169,7 @@ static bool lynx_10g_lane_mode_needs_rcw_override(struct lynx_lane *lane,
 
 	/* Major protocol changes, which involve changing the PCS connection to
 	 * the GMII MAC with the one to the XGMII MAC, require an RCW override
-	 * procedure to reconfigure an internal mux, as documented here:
-	 * https://lore.kernel.org/linux-phy/20230810102631.bvozjer3t67r67iy@skbuf/
-	 * This is SoC-specific, and not yet implemented in drivers/soc/fsl/guts.c.
-	 *
-	 * So the supported set of protocols depends on the initial lane mode.
-	 *
-	 * Minor protocol changes (SGMII <-> 1000Base-X <-> 2500Base-X or
-	 * 10GBase-R <-> USXGMII) are supported.
+	 * procedure to reconfigure an internal mux.
 	 */
 	if ((lynx_lane_mode_uses_gmii_mac(curr) &&
 	     lynx_lane_mode_uses_xgmii_mac(new)) ||
@@ -1189,6 +1184,7 @@ static int lynx_10g_validate(struct phy *phy, enum phy_mode mode, int submode,
 			     union phy_configure_opts *opts)
 {
 	struct lynx_lane *lane = phy_get_drvdata(phy);
+	struct lynx_priv *priv = lane->priv;
 	enum lynx_lane_mode lane_mode;
 	int err;
 
@@ -1197,7 +1193,8 @@ static int lynx_10g_validate(struct phy *phy, enum phy_mode mode, int submode,
 		return err;
 
 	if (lynx_10g_lane_mode_needs_rcw_override(lane, lane_mode))
-		return -EINVAL;
+		return fsl_guts_lane_validate(priv->info->index, lane->id,
+					      lane_mode);
 
 	return 0;
 }
@@ -1205,6 +1202,7 @@ static int lynx_10g_validate(struct phy *phy, enum phy_mode mode, int submode,
 static int lynx_10g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 {
 	struct lynx_lane *lane = phy_get_drvdata(phy);
+	struct lynx_priv *priv = lane->priv;
 	bool powered_up = lane->powered_up;
 	enum lynx_lane_mode lane_mode;
 	int err;
@@ -1225,6 +1223,13 @@ static int lynx_10g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	if (powered_up)
 		lynx_10g_lane_halt(phy);
 
+	if (lynx_10g_lane_mode_needs_rcw_override(lane, lane_mode)) {
+		err = fsl_guts_lane_set_mode(priv->info->index, lane->id,
+					     lane_mode);
+		if (err)
+			goto out;
+	}
+
 	err = lynx_10g_lane_disable_pcvt(lane, lane->mode);
 	if (err)
 		goto out;
@@ -1314,6 +1319,7 @@ static struct platform_driver lynx_10g_driver = {
 };
 module_platform_driver(lynx_10g_driver);
 
+MODULE_IMPORT_NS("FSL_GUTS");
 MODULE_IMPORT_NS("PHY_FSL_LYNX");
 MODULE_AUTHOR("Ioana Ciornei <ioana.ciornei@nxp.com>");
 MODULE_AUTHOR("Vladimir Oltean <vladimir.oltean@nxp.com>");
-- 
2.34.1



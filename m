Return-Path: <linuxppc-dev+bounces-23349-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE80C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 03:26:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grMjh58b2z2yr1;
	Thu, 02 Jul 2026 13:26:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782962776;
	cv=pass; b=fLlRnPCDUonkl9Zu2WDJcSXkUJArYHLBeE1hPhpqUqrQHr81vwkM5uBJi4e8wbzHrYN08eYIkkARTE4P/g2I9G61gM7ljZf/GxJtkU20Lb8nnALadvznKftZQwlG8PVfLdWX8limPqn04OTXGy/L4NIbZFe9APcT8p2JUSEiWGPp5SuqJoXhICm98aIYXO2KkTF0x/WRlYvaSDXnCl7Ga1n2XZaL2TuREmBq6QSTq16FzkugAbJ1LMspY13IZ2DJuAyibSIyO1t92jwXSKEblJvqjggQDtK3XX0+gUtBHjRgs0o3xVbI5r/qQXMqI9Tcg9wxDLLSbqaneSxx/GPQnQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782962776; c=relaxed/relaxed;
	bh=yPkDVo6MUZRROroOIf8F2+jVfKg/zz31KoKbsURS1bM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nakDfxt6/xluNKlmIE9EF6Jil5WClkR587aTNHlGIQjgIQjCJD2gtfv5HvvpGWrPdHaP2kVlXh1EDFJEOOQXHdtoTd3CygU0+BQOOpcyNr0y/Uy0PAMm7UGzToftuNpsH9XPfjV+Dyxnrm9kjYPrXKOI/m6bLozEeKs1QeWZtygrbDa36J+/CyJCRwcHne7k68SMIIcONUhC3hNP9uU66pqbWj1gm/TDSyb1g2RhtsFpm8hNiNcnTrhgfp7mExPbiij+f6ZB+d0IYvG9ac8NMJyKasskJng0ZwEoo/IzGb498atW0tMT7pX72/Tn4qBmKLEisM8hcU6UEobl7ZEj+Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=YGN5n2Q9; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=YGN5n2Q9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grMjg516pz2yvB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 13:26:15 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lu7DBMBDooDqShgK//2AaVvswlW+x+V3dM+BGeWCKzwEsRwyyx/kAkWXzDY1ZnqOlVV3rAArmXAnSLBSPMvzAxcztt/h6xG2pW6Rucr+4RF2W+VGUUE0mV7LOA0XNF5SVqEcsYiZd34lC7owFD7jS2nlWwgjXKjwILhpMyuhEoH8SYbcKcgAQfCtPDmCTwmNTxXEXjvYwgPzRWZiZ733jw7a40ydQwtCNNUpU9XqoSonnnkcJzwSXDDUzYktcnRzBEXgw2p8buCisBzoyTg3sAYgkBI7mGPrlCD+GWxdB51irqrcCanMpyay9PUTwkTqxSG0gydbmYdVG0rTWBAfIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPkDVo6MUZRROroOIf8F2+jVfKg/zz31KoKbsURS1bM=;
 b=uhsbJPI7Upa1y3bkwWnL7/je2KUlOMMsQnQ2xnKsFnhnCh9dmQMidw4QQvd+2MW6spInVAHu1Eby50/W2jRMMVbW1gvD18r9hyXR/wwYesHRE/pM3gQ46PXE5D6LcCuS3OgGwI8CDoV99vXt3R5sTQdDrFFXpcD28ZbxxEJEXyBQyOYrSBaOAJmk/pSnuPG0oCI8RWu+/WE31fC7rl/7ri3qZ3c4qI3ZNlte2dqCdY9tcm8+XXF796qHGKI9wyOMJM9VdDfmvYe7R7w/zpSK3pBHqzQ1U07Lrhc9+Tat+kouGXCk9tQC2AVo/BF2TPxN9ogQifM+Ly1VcZjp9D8ECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPkDVo6MUZRROroOIf8F2+jVfKg/zz31KoKbsURS1bM=;
 b=YGN5n2Q9PS51k0vbLr0KR2atv/ql7Oa8ESePWmQgltf8YDSNwOBdho1DsUHYcOSRRqB1uNUxCL7hzOtVWAjcmoyKnW9Tbv398omuZ2rr5WnBnnaCXi/hrvhJIwouKJTXmFda4Ydoy77rZ99uktcM1LNtVF66dh5sQ3QhmWS6QthinR3pz4Nk9BPj7rQR6vgvhJpM84FsIYaGKXJ+BZiJQByfSld32drP5LIVrMNpuSG1OvO6Re3IDGYAg/AX0W5PUe7ttxhdYEj5RonSrVun4wMcwj2GcCD6COzCGe2ohd92TDoI46HBXdI206lfeaQ0UbKMRLfN26FzwFL2J7f4RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GVXPR04MB10248.eurprd04.prod.outlook.com (2603:10a6:150:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 03:25:57 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 03:25:57 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com,
	chleroy@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 net-next 07/14] net: enetc: differentiate phylink capabilities for pseudo-MAC and standalone MAC
Date: Thu,  2 Jul 2026 10:57:07 +0800
Message-Id: <20260702025714.456233-8-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702025714.456233-1-wei.fang@oss.nxp.com>
References: <20260702025714.456233-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0209.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::8) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GVXPR04MB10248:EE_
X-MS-Office365-Filtering-Correlation-Id: fd276502-32e7-4cb6-8c9c-08ded7e9a1b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|921020|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VVV3+76q52ClqXsoOPCnu5URgcC/KTNd6fk55RMC9GyiR9HIjRO29sRoIj4ihzadTUOxjUedoPdwEdc+8rCtnrhNY9xCo7+e4QdgksI8d/y9PqFZ8Oip0uZa/YOIldTzK68hLKw2t5Wo3F9HKKVMh4Td2CtjWHqnJxIrAcDAb1MC4T/1/JFOfQinDxjYKx0aA4EVR5V8b5WpzkLt6/+fH0Z6awImvEnVLBFqXzUmOZ9D8KsVKelGvF6/amZ+PDjmGxrYLalyu7psGGnFLNFi9YZpJvsQ5ms92Spccn5JJtW5Lk6vdY5houtwLFNBcgUzdr2BJZLgbMxWWTOKirOyxomz28pv22qXWqbfMOUqdle/mhAJpPL5hjgxXcJxOz9QOMC81v1LGwlJk+OGWUAhSUtdZA8i8S4F6pefnG7sCHEhzHh+zK51g+d3fqLM5ygjBfCpoOmvZ4h37Uoj15kF2QIjLH0xoD64tnnXWZnk5PvJwO/NSIaNxqnR5pwigisVj6CCf/cS+xqJPdJBpKQEdk35A5BQqvqE3BPXLNfCH00a7UIqjmKcoS9JSZk29aWQHNpR8FWoKq/L5dAeg/1BE8GeqduPJYU8k8XxpJXoaC4fZsppm4a1QP4V0PahfVvVT8Q6YckxVlBWpzFsq+4MpsG8D+LbgqbdU+iLP5iu73c7AKTnY/cDZon0HgLM+ctnp2LnJuGzmATOlI2Z3gMH9w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qXF/jz48RVuu2maRU5/7UHa4EmjFPMSJIY9uaFK6hCNAPoUftFHTKdG2u1qN?=
 =?us-ascii?Q?4oVAM2ewPI/9WmY9a49/uWZcjpS9yZBGJLogZRWb473nwX4RICp2csGSLlyA?=
 =?us-ascii?Q?KOHoc1u+43Cb5o7SUzwnXK8tWOpVBKEpyvh8sZ0EOoaLDjx99GFp7veiAIMv?=
 =?us-ascii?Q?fSt84C2CUknIbRYwqJ2Y3JDs9DFRWl13Ph+X2xlVE9+KADfrp8I1uNiN5dRt?=
 =?us-ascii?Q?tiQTThAHiW8yMhSIJtmo9YZuzA6zTB8yB3GMRTbjyc8/mzO4WWC11HAlmwdm?=
 =?us-ascii?Q?QqPqEir7DtodyulNzxOZMNJeGZtKlwCtn7LleARoVFjGwYfyKPZgm0yaC8yh?=
 =?us-ascii?Q?56aOcYFCHvAHvKXgrtAWs4NUL8f580ZX/tpzIlK+mLLVWnoJKkUNai47psss?=
 =?us-ascii?Q?MFAvADivY0CPr4QAAfRcUWdG6tcAEuGO6IestIyO31XVpzlYUFElhXAQMCLW?=
 =?us-ascii?Q?F14rEO9n9UdSPHFmzZ7Ida1T+S5yCEyDLe4C/jwk4SAmPdZY2hS61Jn8LHkw?=
 =?us-ascii?Q?lzK+lhuNGBpivoEenxIB/0tAIyG84rkuBDlK4JrTqgN07AdT6LlvqLB0N4u+?=
 =?us-ascii?Q?Szw8Em+qETRziLyAZHudO4JyGZtP+pn3cbr8q/mzc0XMzJwxeAOyiMCCz8Wz?=
 =?us-ascii?Q?3k2fLT72vpRODUl9ALy3Dtc/aQ9aTgDpkbX2VfFqvBR/TzYJ7aExOurs2naU?=
 =?us-ascii?Q?GMymSPrKpDBn3zR1PkdIghikcRR+ZI+CfU7G4qvo+0v+DsKZoRVFLznW4jCb?=
 =?us-ascii?Q?wBvmYj1coqI4icpmk4+FaqK9nlSkdrP/rKPhedn3NdI68UZRwWO6D/Rnk7rN?=
 =?us-ascii?Q?ThHxY5dulp3+cF34h6iPQvHf/vTjhDq6mSBbu8zdA54jHH3oL8yzIBs6YMdT?=
 =?us-ascii?Q?CM2LopuOOy3e3akUgGhhnIBBAhcQlYe8UMvk2Fn4lbU5Yw7R2OprFa+CCl3m?=
 =?us-ascii?Q?dKKu/cU2tnpVbfmHHQt7QKuAjJPxYOoM1/CT5SoYEQoL7E+SNBcB6y70/yc8?=
 =?us-ascii?Q?l9sxPOzn/TvUs3x/SOu6E0FsRIO3Lw0O049rwe2vlbMLRpQLbSOV7KqJXVUD?=
 =?us-ascii?Q?NStEhypT1mRp9Z5iyHESUC2nz7HzeCEqa0EssEiarNHxZcGEZxS16SwfQKD7?=
 =?us-ascii?Q?Rb5TgToI8AVJSolZC2qKLrsSa4kOzZ7VN3/HaMxgqbafd1egloo82jTm1qDv?=
 =?us-ascii?Q?3/5SJrXa2RgA3ezdBeifzMML6bN3SiKz72SrWYzhLc/hmwfQjD6qxRI0wW4U?=
 =?us-ascii?Q?HYtC+lyIJtWlPuxO/j40eryzazMsKrDpnGfN9cN0/wl1IqvZpM+tVdmKURQf?=
 =?us-ascii?Q?cJfDrdBsoIHa5RnPbjJwmcb82O0gajOcDBiRnUsHr+5xvFpnSk67LT32v5qA?=
 =?us-ascii?Q?MU3A4bODk8MSDBw9VcsOX2SyltEHt2zkPUc7xfIsz3B8J3F7RTx0dmJSkHJa?=
 =?us-ascii?Q?bW9qDgZ39M4bwI+gwvLt8ErckJH032qFZc0S6lNRgQZEUX+CSLGtlmtJbARe?=
 =?us-ascii?Q?hemnAOa78Yx7wXoxQH7pSr6DOUbRIhZtwQiVmrHmeFiWtNNQhlqxTIB9/XgR?=
 =?us-ascii?Q?gpwT/lU15oxtbqJmvoQbXs4VC8x3tt8XwXnurw3Sy0+GQpRdFZi3gqlB9LcI?=
 =?us-ascii?Q?TUFdZvu2VlJ8m0b8Z676Hq0nOPM0Ylh6RRwrZz0L5FkHK8MeOd30R9Gg3xpZ?=
 =?us-ascii?Q?BrTH9jLiFbfWhp8gmKtpVLHhiMO08JCndi3cbH52a9qb5kxRonbujnnX/i5+?=
 =?us-ascii?Q?QT04unwe4LHEkza5Z+Vf0T2eMvRH7CinRzLoQKhxj+PLqj3Hlv98?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd276502-32e7-4cb6-8c9c-08ded7e9a1b1
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 03:25:57.4576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KikS0qPGDGzlxzNweWIeL/3z3x388cQjGa+hrEd01mifwEzlWDcBX+FhLFl70uHlgVBmgE9FpL/NEp/N7Y7jAhaLT7r38QNr+ADcfL57Jy9yuX1iebtfxXva9oRVNOp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10248

From: Claudiu Manoil <claudiu.manoil@nxp.com>

The ENETC pseudo-MACs are proprietary internal links that do not
implement any standard MII interface, so restrict their supported PHY
interface modes to PHY_INTERFACE_MODE_INTERNAL only.

Since pseudo-MACs can operate at any speed between 10Mbps and 25Gbps
in multiples of 10Mbps, set their MAC capabilities to cover the full
range of standard full-duplex speeds: 10/100/1000/2500/5000/10000/
20000/25000 Mbps.

For standalone ENETC, expand the supported interface modes to include
10GBASER and XGMII in addition to the existing RGMII, SGMII, 1000BASEX,
2500BASEX and USXGMII modes, with MAC capabilities up to 10G. MAC_1000
is replaced with MAC_1000FD to explicitly exclude 1000M half-duplex,
which is not supported.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  2 +-
 .../freescale/enetc/enetc_pf_common.c         | 47 ++++++++++++++-----
 2 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 06a9f1ee0970..8839cfb49bcf 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/* Copyright 2017-2019 NXP */
+/* Copyright 2017-2019, 2025-2026 NXP */
 
 #include <linux/timer.h>
 #include <linux/pci.h>
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 3597cb81a7cc..6ccf9b909054 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/* Copyright 2024 NXP */
+/* Copyright 2024-2026 NXP */
 
 #include <linux/fsl/enetc_mdio.h>
 #include <linux/of_mdio.h>
@@ -359,7 +359,9 @@ static bool enetc_port_has_pcs(struct enetc_pf *pf)
 	return (pf->if_mode == PHY_INTERFACE_MODE_SGMII ||
 		pf->if_mode == PHY_INTERFACE_MODE_1000BASEX ||
 		pf->if_mode == PHY_INTERFACE_MODE_2500BASEX ||
-		pf->if_mode == PHY_INTERFACE_MODE_USXGMII);
+		pf->if_mode == PHY_INTERFACE_MODE_USXGMII ||
+		pf->if_mode == PHY_INTERFACE_MODE_10GBASER ||
+		pf->if_mode == PHY_INTERFACE_MODE_XGMII);
 }
 
 int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node)
@@ -400,25 +402,44 @@ int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
 {
 	struct enetc_pf *pf = enetc_si_priv(priv->si);
 	struct phylink *phylink;
+	unsigned long mac_caps;
 	int err;
 
 	pf->phylink_config.dev = &priv->ndev->dev;
 	pf->phylink_config.type = PHYLINK_NETDEV;
-	pf->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
-		MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
 
 	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_SGMII,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_USXGMII,
-		  pf->phylink_config.supported_interfaces);
-	phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
 
+	mac_caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
+	if (!enetc_is_pseudo_mac(priv->si)) {
+		mac_caps |= MAC_10 | MAC_100 | MAC_1000FD | MAC_2500FD;
+
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  pf->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+			  pf->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  pf->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_USXGMII,
+			  pf->phylink_config.supported_interfaces);
+
+		if (!is_enetc_rev1(priv->si)) {
+			mac_caps |= MAC_5000FD | MAC_10000FD;
+			__set_bit(PHY_INTERFACE_MODE_10GBASER,
+				  pf->phylink_config.supported_interfaces);
+			__set_bit(PHY_INTERFACE_MODE_XGMII,
+				  pf->phylink_config.supported_interfaces);
+		}
+
+		phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
+	} else {
+		mac_caps |= MAC_10FD | MAC_100FD | MAC_1000FD | MAC_2500FD |
+			    MAC_5000FD | MAC_10000FD | MAC_20000FD |
+			    MAC_25000FD;
+	}
+
+	pf->phylink_config.mac_capabilities = mac_caps;
 	phylink = phylink_create(&pf->phylink_config, of_fwnode_handle(node),
 				 pf->if_mode, ops);
 	if (IS_ERR(phylink)) {
-- 
2.34.1



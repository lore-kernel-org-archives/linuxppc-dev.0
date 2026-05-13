Return-Path: <linuxppc-dev+bounces-20811-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62965CD343F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 03:04:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFdb93jQyz2yFP;
	Wed, 13 May 2026 13:04:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778641445;
	cv=pass; b=mL7BHzrW877c7G/oe2AkDQN+0Oauj5/FYnUpY3Ptf8r9Hdbgt56BFaeeWNANhwK7CKXiqucpkNWPZxCd+Ye0IYz6ZZXw8MMWpW3yzpjCxkjsFDKJf8IbOQ3IoeM234rkUysjH7t+s0WevZF6Czp5hD79+cOS87J0Zk3z1f8c5+rToe1aj8C0Pa2XzOcUt13uW6eIRXXM0NpgiB7siIvE9eQPw0La81WZn2GnUngu0ZB5qx+CDdDEIvkYeBXXQqi/LXDFYbuOfVhHw/8BaCVQDl/LJvRZlOH9ZrBXt8X8/iWkUX+sGo2/onIQsHkOkF9JG+kw5bJs4MohZDZ3jnKFyQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778641445; c=relaxed/relaxed;
	bh=1+H0v3Nn4FnV2C1+KgW+MEehhxDrOf2K9/nfWjw6Og0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZS4Dn3lH2fk57fiaMQV1nOedzc3BA5in6h/TsJm3RcKVMWJSnF14xQ97BdFWD+6K7Ix0YV0VskvYgh3nVWW0Orvlel+cczBdx4W/4+uq1SQahlXpqFnB9HHb8kgKRu3uGaVtcIg7xc1QDhDQ/p9JP8K/1fLaeNJJZFNp520PtrcjUoVptmbnn5G09aALc+eTX/z7XKcex721jRtCK5CCQdG/PiTCIhd19u+nvUr//ygNRjz23D3Z5Z+rN+cx17wzyrtS+LGeWZ005W6Dpl4rOXOkT+PWWrWi+p53auHm4e5tiEcjADOFH71dnTiHYwmVQ7JTJ+WS+44jPuHgg8gyXw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=F279MTGl; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=F279MTGl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFdb74J5dz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 13:04:03 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpwHgSoNg+ImZV00z2CCk0OXqcR2FGTPfqVzbAniX4Z3FP5RTVNaBqPBj6pNQWep6g6f6Rx1CAldctlRogNTVms+qjaDYK6JyetseG1AV+O05rFxdVs9+EsNKIV7AdqUTEnCFwODEUhSk/gKN0MJ9YuOK50gOfY4lDcBoXN/ZgS2j0EwzdUlLRYZd8kVIs1xdlZZk12cLEmaMI5A+Y9HFrjCZMyweheCP8zzur+4yDXC8tvpsp38p3wCjrJ+GUR2WvisX1eTxIneBGduN9IK8IOD8fACc6JWsBOMYvKvgU8XvaP5UnxkDb3go2vgjbxDIfr+BmzEasHAk+pfSylDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+H0v3Nn4FnV2C1+KgW+MEehhxDrOf2K9/nfWjw6Og0=;
 b=P9lFRDv2w2dxREVgbyrNOlACUpAc7OzH8c3FZRUElUFtNhXN7DZrXVzz276ApoBNS+pnhrU6gxzgXm0E8Q672RnFt1UGpbOFyRZFOzI50yT8So5jLaqK2ZrDLxwcRoDgXOYFUPX6spQD8FHDhls/eJvyZ4ZVMGq6j+9yEFznUPBwnZMAx9JCWQ0AueaPdH4W9qDalW6V2H0fJH1gqywMmk5GAqS0tEuOG2GWrXa3nEnxqY+remz2f5oPjHFOz3WowYKQwHANWiKo9BKWLVhDpwGD2pxD+Dgk/ohR595OSFHwBF7EvlH8d6oCuUPYPKoC3JfgdeJAZLbBkTobzTuuYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+H0v3Nn4FnV2C1+KgW+MEehhxDrOf2K9/nfWjw6Og0=;
 b=F279MTGlg7dtiJYSuNNOG628Nhjm3pd7sJ++o4JZ52UaJwji4uTueSIteFJjvenMoiu6Y9tNVaq4UwgJblnIJv29o0jk8cjNt82w3Vne+77/ATUmHtAToDe8uLMRRwW8NIwu4Db2cHuF9kMagn34Z9Vk7Ixe19Bv3f0KBlqjNr2PtF3QvH5s/d+rgEg7Miwn5cAHgl1XjBfYDcb9leWf5jSrrapZ6szwa3Jph/ZEjP+YJ2+pbHPB91+bISLZqG/vMjpEw5BR/3NXUbBPl9tCmyOYOUIhtFgRF2aiFfuJhFjzHyYXPo0kjZ6V9AgosSBC0s74bWoGblZS+BfKAl/MBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by GV1PR04MB11525.eurprd04.prod.outlook.com (2603:10a6:150:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 03:03:40 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 03:03:40 +0000
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
Subject: [PATCH v7 net-next 10/15] net: dsa: netc: introduce NXP NETC switch driver for i.MX94
Date: Wed, 13 May 2026 11:04:49 +0800
Message-Id: <20260513030454.1666570-11-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: fe2a2400-c704-4b05-8dcd-08deb09c3bc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|56012099003|18002099003|22082099003|3023799003|11063799003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	5hVIe3tNjEc8mK5Fv27hnjSUHTXaqYdQbRHb3uLgjKwHvs0MVkpI5jGSz3x5f3a5OZCkyr6QoFweWcnxwDXWjMhagateZIX9MnZqudzj3DFAm06sgLAHgMh3u9D09hlyxDTMy67n8OAdm5wrgl4yYQWApBriegb09vFx0DFgULjL2mHpiQKGJWy5G5RifAsbfkJ5PjpRMMwXlaE2BRUV3OP3gnkfobkJ00aQ+g999Zu4Mpt1bq2l1trpzfwljWTb5XKneev4MQCNIzGWKuzqyS24EFhjVX1urlh1GwX7W6nmEtWEIxDlW3dvcUohCme2Y4MhitYglAK/qxk/hpCebNxqIRAUfLiJjy6c2m0Jhn3iodZR20diZFuKhinoplzz/X9O7GCxnKgpWzcmoP5ZdEojljYWkryhs+QaQhkQvLmytbdOh0mAoGSyeRdxUKd2b2eoG/lKEKzLX27z29rY7pyujpKr6z8s2iUjZTqI4ECEJ8/quzbi7dmp6zU7QfruY45D/hbXkUYnbBAMMEUshFGK74YiMpB8d2kVoe4BzD/4D7P0z36qtJ9zPT+VrkQMsrQcMX7J3o9lRGakbRbvD++RJUYrZZwycFXZv9UmFOBgFUKzLWLZC4nt5LnfoQexYXh6fP91VhAvhkPVabLZ9qTYr4X6bDs2x7/qz3eKGEos1cL5tiDtHQ6nxqxrqznap69iwjQ+Yqg+PRGmOFi4BnfbI+/6OwGyGSYxEJRN6qvjF9UpXBH+PvLpv4E48c/QQgpV1q+UesD9mFvdHmHJ/A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(56012099003)(18002099003)(22082099003)(3023799003)(11063799003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cECLqt5aHtN2QZIqtTdgH7tll6d6ZHOkN2aSL3XnhbPK41ZCeKkJwWSr9aRE?=
 =?us-ascii?Q?0LVZCOIAYZHD2kRF39uBj1d7owKdJomRjyUBfsgTE6pcddEBKaMw9js/RSUV?=
 =?us-ascii?Q?Kz/UUxkFFrAukAOxR4w5JIK3d76Lv5SbGoYXZLYCMIwCU0+lN1LUEayuAVUz?=
 =?us-ascii?Q?oVe2Xl8RS6ya7sOOy7ILCy3jIRwEPYsueWuq7lBTWFcm3TnOSBmyHs0JhRoy?=
 =?us-ascii?Q?vPfNqdDDC7S2xQN5nyXEBRzO/Ps/VY9tz3faQWzRfihBsh7OH7vCr2fPW0nK?=
 =?us-ascii?Q?tB8x3jRiXojXaKFx5OWno0nJTUgsqR9tB1UNS8D9Yc8Z+oogisfrR6nsiJ2V?=
 =?us-ascii?Q?H+D/IbvRt6nMILN/I5us69mYNBDpXLmOGledwGcs5oWm1rJ2hUJFAbgtX9Pa?=
 =?us-ascii?Q?xcM/SUrGJmmxJ+TKRmjATJfOOOIerQJl6dfhPO8DVOT1To70K86+UZbR20Tr?=
 =?us-ascii?Q?P2GsR4318f4+dj6bhRaDpUo5sCzGmQVfBIcWCZJ8MJfdOSPnmQtoayEcs8eN?=
 =?us-ascii?Q?F9xmhm/Q8z3imcGkeNoTvCipaDawCdMshDlq63ywDtlS13lgBIDH6lblZJ5+?=
 =?us-ascii?Q?pvpvn7EUj3tFPLhcUb/zl8nXnz+5ctr74rG4PwoX/FCAngA7ZAl59E1PQrsV?=
 =?us-ascii?Q?CYcwydr7RLJACnG9of7Srx2yLxcwKMa00fzY5NBsVusuh0roQVi8P+CXcIJ7?=
 =?us-ascii?Q?o4o3xLItkdkbhG69qWrE6DKrpqVNf5rJtWhbhTd6SYOWPkJExEgkrU1W7dsg?=
 =?us-ascii?Q?21PIWPvR4KUUz0wcyBKD1g9KCIE/lf7iIfGz66nLxxTtAv9Ukk/OO+F+NkHS?=
 =?us-ascii?Q?CS+6ZTd7Rlwi+ypNQmF2Tm3Ire4EwYRHWLnCyAJDI11QsunvytT/iPzvL6fg?=
 =?us-ascii?Q?Nar4INtTxwm7i9OmTDwgftFY9L0YJ3WmLGMo7PDsUfQh9DyZzngYKmmeSnMa?=
 =?us-ascii?Q?YSgSu4P0puyXIBi/UTUc7sOQAj+nrAJ2xgehksw93TTklgZSPULcCUOtAZ9U?=
 =?us-ascii?Q?0I+WAa0gIniW55rAy/9ZVD6Ojkc+L1romTFIbzoZ22JBkqvECbba6L07/Ckt?=
 =?us-ascii?Q?HyzPCmzMVpBZv3iTtkZRQbYtM4hyfBxrXzJMxH/PqfLbMZGdlvp1pJFC+GJv?=
 =?us-ascii?Q?SpHalC1B+s6rk5EI0+29QAQcAqcvVrnXHK4idnfG8sgPQKu1OPC8NUm++KNy?=
 =?us-ascii?Q?8OwUdOC/bedG+UPJH3KJXou6B++f4sXQn7EmQbp/ZJgxa/isMSIMmcKit1If?=
 =?us-ascii?Q?dKYh/zU5XIIhxwfwJ9KWnyYdqmEbtxZ0EVkQN96PkWEIj9aQZpLf+IC6UsCo?=
 =?us-ascii?Q?svzSvpdN8kt+4Ik0HAzzpPUUOV9TA0jytbD48AwlB/ggUICbmJiFkJ5OZDTR?=
 =?us-ascii?Q?5LcVjpJh5Y1rTOwTrx/YnL71jKvs3bg9AZ57upq5akGmJi76PrOA0FtFzx49?=
 =?us-ascii?Q?5a1BMuIlG/4sDRP1JHRwCFNdJuDUNpA46ToAmireXbkkaDJ3X8UhJfg4BILT?=
 =?us-ascii?Q?GhVV6AvNzJAPbdFQGsAZXBVmMUrYEiyqHMuggPni4R0Ai59SH/T/FlW8XrT7?=
 =?us-ascii?Q?L6w/nYqcnHlIMVhDyo4q+wjs+uXVraezGAgBTM4Zb6U56kGy/KLjk91i6+3j?=
 =?us-ascii?Q?4+QXieHVyIZ4K/xYLlNADlRsiddw4XF6sKE+yLwSHoVo2g3mx0Rfk+Bojx5m?=
 =?us-ascii?Q?4Zh/u4utvZgczJCseQBieUdZyE0bZqYUEGTJ+YbJw3V0ijT5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2a2400-c704-4b05-8dcd-08deb09c3bc9
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 03:03:40.1404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kbtk0/8D6DD3+8z01+S2VeOKyZuyYZYcqhtWtwhm/J5ouNjN5+7ihLFkMnA9o5AVZdipl5TboTDs2UzroqI0Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11525

For i.MX94 series, the NETC IP provides full 802.1Q Ethernet switch
functionality, advanced QoS with 8 traffic classes, and a full range of
TSN standards capabilities. The switch has 3 user ports and 1 CPU port,
the CPU port is connected to an internal ENETC. Since the switch and the
internal ENETC are fully integrated within the NETC IP, no back-to-back
MAC connection is required. Instead, a light-weight "pseudo MAC" is used
between the switch and the ENETC. This translates to lower power (less
logic and memory) and lower delay (as there is no serialization delay
across this link).

Introduce the initial NETC switch driver with basic probe and remove
functionality. More features will be added in subsequent patches.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 MAINTAINERS                           |  11 +
 drivers/net/dsa/Kconfig               |   2 +
 drivers/net/dsa/Makefile              |   1 +
 drivers/net/dsa/netc/Kconfig          |  15 +
 drivers/net/dsa/netc/Makefile         |   3 +
 drivers/net/dsa/netc/netc_main.c      | 600 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_platform.c  |  49 +++
 drivers/net/dsa/netc/netc_switch.h    |  92 ++++
 drivers/net/dsa/netc/netc_switch_hw.h | 133 ++++++
 9 files changed, 906 insertions(+)
 create mode 100644 drivers/net/dsa/netc/Kconfig
 create mode 100644 drivers/net/dsa/netc/Makefile
 create mode 100644 drivers/net/dsa/netc/netc_main.c
 create mode 100644 drivers/net/dsa/netc/netc_platform.c
 create mode 100644 drivers/net/dsa/netc/netc_switch.h
 create mode 100644 drivers/net/dsa/netc/netc_switch_hw.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5bbbbde6b907..78d0a6038086 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19290,6 +19290,17 @@ F:	Documentation/devicetree/bindings/clock/*imx*
 F:	drivers/clk/imx/
 F:	include/dt-bindings/clock/*imx*
 
+NXP NETC ETHERNET SWITCH DRIVER
+M:	Wei Fang <wei.fang@nxp.com>
+R:	Clark Wang <xiaoning.wang@nxp.com>
+L:	imx@lists.linux.dev
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
+F:	drivers/net/dsa/netc/
+F:	include/linux/dsa/tag_netc.h
+F:	net/dsa/tag_netc.c
+
 NXP NETC TIMER PTP CLOCK DRIVER
 M:	Wei Fang <wei.fang@nxp.com>
 M:	Clark Wang <xiaoning.wang@nxp.com>
diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 39fb8ead16b5..4ab567c5bbaf 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -76,6 +76,8 @@ source "drivers/net/dsa/mv88e6xxx/Kconfig"
 
 source "drivers/net/dsa/mxl862xx/Kconfig"
 
+source "drivers/net/dsa/netc/Kconfig"
+
 source "drivers/net/dsa/ocelot/Kconfig"
 
 source "drivers/net/dsa/qca/Kconfig"
diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index f5a463b87ec2..d2975badffc0 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -21,6 +21,7 @@ obj-y				+= lantiq/
 obj-y				+= microchip/
 obj-y				+= mv88e6xxx/
 obj-y				+= mxl862xx/
+obj-y				+= netc/
 obj-y				+= ocelot/
 obj-y				+= qca/
 obj-y				+= realtek/
diff --git a/drivers/net/dsa/netc/Kconfig b/drivers/net/dsa/netc/Kconfig
new file mode 100644
index 000000000000..0f246ac9e018
--- /dev/null
+++ b/drivers/net/dsa/netc/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NET_DSA_NETC_SWITCH
+	tristate "NXP NETC Ethernet switch support"
+	depends on ARM64 || COMPILE_TEST
+	depends on NET_DSA && PCI
+	select NET_DSA_TAG_NETC
+	select FSL_ENETC_MDIO
+	select NXP_NTMP
+	select NXP_NETC_LIB
+	help
+	  This driver supports the NXP NETC Ethernet switch, which is embedded
+	  as a PCIe function of the NXP NETC IP. But note that this driver is
+	  is only available for NETC v4.3 and later versions.
+
+	  If compiled as module (M), the module name is nxp-netc-switch.
diff --git a/drivers/net/dsa/netc/Makefile b/drivers/net/dsa/netc/Makefile
new file mode 100644
index 000000000000..4a5767562574
--- /dev/null
+++ b/drivers/net/dsa/netc/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_NET_DSA_NETC_SWITCH) += nxp-netc-switch.o
+nxp-netc-switch-objs := netc_main.o netc_platform.o
diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
new file mode 100644
index 000000000000..8e3a3230226c
--- /dev/null
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -0,0 +1,600 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP NETC switch driver
+ * Copyright 2025-2026 NXP
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/fsl/enetc_mdio.h>
+#include <linux/if_vlan.h>
+#include <linux/of_mdio.h>
+
+#include "netc_switch.h"
+
+static enum dsa_tag_protocol
+netc_get_tag_protocol(struct dsa_switch *ds, int port,
+		      enum dsa_tag_protocol mprot)
+{
+	return DSA_TAG_PROTO_NETC;
+}
+
+static void netc_port_rmw(struct netc_port *np, u32 reg,
+			  u32 mask, u32 val)
+{
+	u32 old, new;
+
+	WARN_ON((mask | val) != mask);
+
+	old = netc_port_rd(np, reg);
+	new = (old & ~mask) | val;
+	if (new == old)
+		return;
+
+	netc_port_wr(np, reg, new);
+}
+
+static void netc_mac_port_wr(struct netc_port *np, u32 reg, u32 val)
+{
+	if (is_netc_pseudo_port(np))
+		return;
+
+	netc_port_wr(np, reg, val);
+	if (np->caps.pmac)
+		netc_port_wr(np, reg + NETC_PMAC_OFFSET, val);
+}
+
+static void netc_port_get_capability(struct netc_port *np)
+{
+	u32 val;
+
+	val = netc_port_rd(np, NETC_PMCAPR);
+	if (val & PMCAPR_HD)
+		np->caps.half_duplex = true;
+
+	if (FIELD_GET(PMCAPR_FP, val) == FP_SUPPORT)
+		np->caps.pmac = true;
+
+	val = netc_port_rd(np, NETC_PCAPR);
+	if (val & PCAPR_LINK_TYPE)
+		np->caps.pseudo_link = true;
+}
+
+static int netc_port_create_emdio_bus(struct netc_port *np,
+				      struct device_node *node)
+{
+	struct netc_switch *priv = np->switch_priv;
+	struct enetc_mdio_priv *mdio_priv;
+	struct device *dev = priv->dev;
+	struct enetc_hw *hw;
+	struct mii_bus *bus;
+	int err;
+
+	hw = enetc_hw_alloc(dev, np->iobase);
+	if (IS_ERR(hw))
+		return dev_err_probe(dev, PTR_ERR(hw),
+				     "Failed to allocate enetc_hw\n");
+
+	bus = devm_mdiobus_alloc_size(dev, sizeof(*mdio_priv));
+	if (!bus)
+		return -ENOMEM;
+
+	bus->name = "NXP NETC switch external MDIO Bus";
+	bus->read = enetc_mdio_read_c22;
+	bus->write = enetc_mdio_write_c22;
+	bus->read_c45 = enetc_mdio_read_c45;
+	bus->write_c45 = enetc_mdio_write_c45;
+	bus->parent = dev;
+	mdio_priv = bus->priv;
+	mdio_priv->hw = hw;
+	mdio_priv->mdio_base = NETC_EMDIO_BASE;
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-p%d-emdio",
+		 dev_name(dev), np->dp->index);
+
+	err = devm_of_mdiobus_register(dev, bus, node);
+	if (err)
+		return dev_err_probe(dev, err,
+				     "Cannot register EMDIO bus\n");
+
+	np->emdio = bus;
+
+	return 0;
+}
+
+static int netc_port_create_mdio_bus(struct netc_port *np,
+				     struct device_node *node)
+{
+	struct device_node *mdio_node;
+	int err;
+
+	mdio_node = of_get_child_by_name(node, "mdio");
+	if (mdio_node) {
+		err = netc_port_create_emdio_bus(np, mdio_node);
+		of_node_put(mdio_node);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int netc_init_switch_id(struct netc_switch *priv)
+{
+	struct netc_switch_regs *regs = &priv->regs;
+	struct dsa_switch *ds = priv->ds;
+
+	/* The value of 0 is reserved for the VEPA switch and cannot
+	 * be used. So 'dsa,member' is a required property for NETC
+	 * switch, the member is used to specify the switch ID, which
+	 * cannot be zero. This way, the hardware switch ID and the
+	 * software switch ID are consistent.
+	 */
+	if (ds->index > FIELD_MAX(SWCR_SWID) || !ds->index) {
+		dev_err(priv->dev, "Switch index %d out of range\n",
+			ds->index);
+		return -ERANGE;
+	}
+
+	netc_base_wr(regs, NETC_SWCR, ds->index);
+
+	return 0;
+}
+
+static int netc_init_all_ports(struct netc_switch *priv)
+{
+	struct device *dev = priv->dev;
+	struct netc_port *np;
+	struct dsa_port *dp;
+	int err;
+
+	priv->ports = devm_kcalloc(dev, priv->info->num_ports,
+				   sizeof(struct netc_port *),
+				   GFP_KERNEL);
+	if (!priv->ports)
+		return -ENOMEM;
+
+	/* Some DSA interfaces may set the port even it is disabled, such
+	 * as .port_disable(), .port_stp_state_set() and so on. To avoid
+	 * crash caused by accessing NULL port pointer, each port is
+	 * allocated its own memory. Otherwise, we need to check whether
+	 * the port pointer is NULL in these interfaces. The latter is
+	 * difficult for us to cover.
+	 */
+	for (int i = 0; i < priv->info->num_ports; i++) {
+		np = devm_kzalloc(dev, sizeof(*np), GFP_KERNEL);
+		if (!np)
+			return -ENOMEM;
+
+		np->switch_priv = priv;
+		np->iobase = priv->regs.port + PORT_IOBASE(i);
+		netc_port_get_capability(np);
+		priv->ports[i] = np;
+	}
+
+	dsa_switch_for_each_available_port(dp, priv->ds) {
+		np = priv->ports[dp->index];
+		np->dp = dp;
+
+		if (dsa_port_is_user(dp)) {
+			err = netc_port_create_mdio_bus(np, dp->dn);
+			if (err) {
+				dev_err(dev, "Failed to create MDIO bus\n");
+				return err;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static void netc_init_ntmp_tbl_versions(struct netc_switch *priv)
+{
+	struct ntmp_user *ntmp = &priv->ntmp;
+
+	/* All tables default to version 0 */
+	memset(&ntmp->tbl, 0, sizeof(ntmp->tbl));
+}
+
+static int netc_init_all_cbdrs(struct netc_switch *priv)
+{
+	struct netc_switch_regs *regs = &priv->regs;
+	struct ntmp_user *ntmp = &priv->ntmp;
+	int i, err;
+
+	ntmp->cbdr_num = NETC_CBDR_NUM;
+	ntmp->dev = priv->dev;
+	ntmp->ring = devm_kcalloc(ntmp->dev, ntmp->cbdr_num,
+				  sizeof(struct netc_cbdr),
+				  GFP_KERNEL);
+	if (!ntmp->ring)
+		return -ENOMEM;
+
+	for (i = 0; i < ntmp->cbdr_num; i++) {
+		struct netc_cbdr *cbdr = &ntmp->ring[i];
+		struct netc_cbdr_regs cbdr_regs;
+
+		cbdr_regs.pir = regs->base + NETC_CBDRPIR(i);
+		cbdr_regs.cir = regs->base + NETC_CBDRCIR(i);
+		cbdr_regs.mr = regs->base + NETC_CBDRMR(i);
+		cbdr_regs.bar0 = regs->base + NETC_CBDRBAR0(i);
+		cbdr_regs.bar1 = regs->base + NETC_CBDRBAR1(i);
+		cbdr_regs.lenr = regs->base + NETC_CBDRLENR(i);
+
+		err = ntmp_init_cbdr(cbdr, ntmp->dev, &cbdr_regs);
+		if (err)
+			goto free_cbdrs;
+	}
+
+	return 0;
+
+free_cbdrs:
+	for (i--; i >= 0; i--)
+		ntmp_free_cbdr(&ntmp->ring[i]);
+
+	return err;
+}
+
+static void netc_remove_all_cbdrs(struct netc_switch *priv)
+{
+	struct ntmp_user *ntmp = &priv->ntmp;
+
+	for (int i = 0; i < NETC_CBDR_NUM; i++)
+		ntmp_free_cbdr(&ntmp->ring[i]);
+}
+
+static int netc_init_ntmp_user(struct netc_switch *priv)
+{
+	netc_init_ntmp_tbl_versions(priv);
+
+	return netc_init_all_cbdrs(priv);
+}
+
+static void netc_free_ntmp_user(struct netc_switch *priv)
+{
+	netc_remove_all_cbdrs(priv);
+}
+
+static void netc_switch_dos_default_config(struct netc_switch *priv)
+{
+	struct netc_switch_regs *regs = &priv->regs;
+	u32 val;
+
+	val = DOSL2CR_SAMEADDR | DOSL2CR_MSAMCC;
+	netc_base_wr(regs, NETC_DOSL2CR, val);
+
+	val = DOSL3CR_SAMEADDR | DOSL3CR_IPSAMCC;
+	netc_base_wr(regs, NETC_DOSL3CR, val);
+}
+
+static void netc_switch_vfht_default_config(struct netc_switch *priv)
+{
+	struct netc_switch_regs *regs = &priv->regs;
+	u32 val;
+
+	val = netc_base_rd(regs, NETC_VFHTDECR2);
+
+	/* If no match is found in the VLAN Filter table, then VFHTDECR2[MLO]
+	 * will take effect. VFHTDECR2[MLO] is set to "Software MAC learning
+	 * secure" by default. Notice BPCR[MLO] will override VFHTDECR2[MLO]
+	 * if its value is not zero.
+	 */
+	val = u32_replace_bits(val, MLO_SW_SEC, VFHTDECR2_MLO);
+	val = u32_replace_bits(val, MFO_NO_MATCH_DISCARD, VFHTDECR2_MFO);
+	netc_base_wr(regs, NETC_VFHTDECR2, val);
+}
+
+static void netc_port_set_max_frame_size(struct netc_port *np,
+					 u32 max_frame_size)
+{
+	netc_mac_port_wr(np, NETC_PM_MAXFRM(0),
+			 max_frame_size & PM_MAXFRAM);
+}
+
+static void netc_switch_fixed_config(struct netc_switch *priv)
+{
+	netc_switch_dos_default_config(priv);
+	netc_switch_vfht_default_config(priv);
+}
+
+static void netc_port_set_tc_max_sdu(struct netc_port *np,
+				     int tc, u32 max_sdu)
+{
+	u32 val = FIELD_PREP(PTCTMSDUR_MAXSDU, max_sdu) |
+		  FIELD_PREP(PTCTMSDUR_SDU_TYPE, SDU_TYPE_MPDU);
+
+	netc_port_wr(np, NETC_PTCTMSDUR(tc), val);
+}
+
+static void netc_port_set_all_tc_msdu(struct netc_port *np)
+{
+	for (int tc = 0; tc < NETC_TC_NUM; tc++)
+		netc_port_set_tc_max_sdu(np, tc, NETC_MAX_FRAME_LEN);
+}
+
+static void netc_port_set_mlo(struct netc_port *np, enum netc_mlo mlo)
+{
+	netc_port_rmw(np, NETC_BPCR, BPCR_MLO, FIELD_PREP(BPCR_MLO, mlo));
+}
+
+static void netc_port_fixed_config(struct netc_port *np)
+{
+	/* Default IPV and DR setting */
+	netc_port_rmw(np, NETC_PQOSMR, PQOSMR_VS | PQOSMR_VE,
+		      PQOSMR_VS | PQOSMR_VE);
+
+	/* Enable L2 and L3 DOS */
+	netc_port_rmw(np, NETC_PCR, PCR_L2DOSE | PCR_L3DOSE,
+		      PCR_L2DOSE | PCR_L3DOSE);
+}
+
+static void netc_port_default_config(struct netc_port *np)
+{
+	netc_port_fixed_config(np);
+
+	/* Default VLAN unaware */
+	netc_port_rmw(np, NETC_BPDVR, BPDVR_RXVAM, BPDVR_RXVAM);
+
+	if (dsa_port_is_cpu(np->dp))
+		/* For CPU port, source port pruning is disabled */
+		netc_port_rmw(np, NETC_BPCR, BPCR_SRCPRND, BPCR_SRCPRND);
+	else
+		netc_port_set_mlo(np, MLO_DISABLE);
+
+	netc_port_set_max_frame_size(np, NETC_MAX_FRAME_LEN);
+	netc_port_set_all_tc_msdu(np);
+}
+
+static int netc_setup(struct dsa_switch *ds)
+{
+	struct netc_switch *priv = ds->priv;
+	struct dsa_port *dp;
+	int err;
+
+	err = netc_init_switch_id(priv);
+	if (err)
+		return err;
+
+	err = netc_init_all_ports(priv);
+	if (err)
+		return err;
+
+	err = netc_init_ntmp_user(priv);
+	if (err)
+		return err;
+
+	netc_switch_fixed_config(priv);
+
+	/* default setting for ports */
+	dsa_switch_for_each_available_port(dp, ds)
+		netc_port_default_config(priv->ports[dp->index]);
+
+	return 0;
+}
+
+static void netc_teardown(struct dsa_switch *ds)
+{
+	struct netc_switch *priv = ds->priv;
+
+	netc_free_ntmp_user(priv);
+}
+
+static bool netc_port_is_emdio_consumer(struct device_node *node)
+{
+	struct device_node *mdio_node;
+
+	/* If the port node has phy-handle property and it does
+	 * not contain a mdio child node, then the port is the
+	 * EMDIO consumer.
+	 */
+	mdio_node = of_get_child_by_name(node, "mdio");
+	if (!mdio_node)
+		return true;
+
+	of_node_put(mdio_node);
+
+	return false;
+}
+
+/* Currently, phylink_of_phy_connect() is called by dsa_user_create(),
+ * so if the switch uses the external MDIO controller (like the EMDIO
+ * function) to manage the external PHYs. The MDIO bus may not be
+ * created when phylink_of_phy_connect() is called, so it will return
+ * an error and cause the switch driver to fail to probe.
+ * This workaround can be removed when DSA phylink_of_phy_connect()
+ * calls are moved from probe() to ndo_open().
+ */
+static int netc_switch_check_emdio_is_ready(struct device *dev)
+{
+	struct device_node *ports, *phy_node;
+	struct phy_device *phydev;
+	int err = 0;
+
+	ports = of_get_child_by_name(dev->of_node, "ethernet-ports");
+	if (!ports) {
+		dev_err(dev, "Cannot find the ethernet-ports node\n");
+		return -EINVAL;
+	}
+
+	for_each_available_child_of_node_scoped(ports, child) {
+		/* If the node does not have phy-handle property, then the
+		 * port does not connect to a PHY, so the port is not the
+		 * EMDIO consumer.
+		 */
+		phy_node = of_parse_phandle(child, "phy-handle", 0);
+		if (!phy_node)
+			continue;
+
+		/* Note that from the hardware perspective, the switch ports
+		 * do not support sharing the MDIO bus defined under one port.
+		 * Each port can only access its own external PHY through its
+		 * port MDIO bus.
+		 */
+		if (!netc_port_is_emdio_consumer(child)) {
+			of_node_put(phy_node);
+			continue;
+		}
+
+		phydev = of_phy_find_device(phy_node);
+		of_node_put(phy_node);
+		if (!phydev) {
+			err = -EPROBE_DEFER;
+			goto out;
+		}
+
+		put_device(&phydev->mdio.dev);
+	}
+
+out:
+	of_node_put(ports);
+
+	return err;
+}
+
+static int netc_switch_pci_init(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct netc_switch_regs *regs;
+	struct netc_switch *priv;
+	void __iomem *base;
+	int err;
+
+	pcie_flr(pdev);
+	err = pcim_enable_device(pdev);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to enable device\n");
+
+	err = pcim_request_all_regions(pdev, KBUILD_MODNAME);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to request regions\n");
+
+	/* The command BD rings and NTMP tables need DMA. No need to check
+	 * the return value, because it never returns fail when the mask is
+	 * DMA_BIT_MASK(64), see dma-api-howto.rst.
+	 */
+	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+
+	if (pci_resource_len(pdev, NETC_REGS_BAR) < NETC_REGS_SIZE) {
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid register space size\n");
+	}
+
+	base = pcim_iomap(pdev, NETC_REGS_BAR, 0);
+	if (!base)
+		return dev_err_probe(dev, -ENXIO, "pcim_iomap() failed\n");
+
+	pci_set_master(pdev);
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->pdev = pdev;
+	priv->dev = dev;
+
+	regs = &priv->regs;
+	regs->base = base;
+	regs->port = regs->base + NETC_REGS_PORT_BASE;
+	regs->global = regs->base + NETC_REGS_GLOBAL_BASE;
+	pci_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static void netc_switch_get_ip_revision(struct netc_switch *priv)
+{
+	struct netc_switch_regs *regs = &priv->regs;
+	u32 val = netc_glb_rd(regs, NETC_IPBRR0);
+
+	priv->revision = FIELD_GET(IPBRR0_IP_REV, val);
+}
+
+static const struct dsa_switch_ops netc_switch_ops = {
+	.get_tag_protocol		= netc_get_tag_protocol,
+	.setup				= netc_setup,
+	.teardown			= netc_teardown,
+};
+
+static int netc_switch_probe(struct pci_dev *pdev,
+			     const struct pci_device_id *id)
+{
+	struct device_node *node = dev_of_node(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct netc_switch *priv;
+	struct dsa_switch *ds;
+	int err;
+
+	if (!node)
+		return dev_err_probe(dev, -ENODEV,
+				     "No DT bindings, skipping\n");
+
+	err = netc_switch_check_emdio_is_ready(dev);
+	if (err)
+		return err;
+
+	err = netc_switch_pci_init(pdev);
+	if (err)
+		return err;
+
+	priv = pci_get_drvdata(pdev);
+	netc_switch_get_ip_revision(priv);
+
+	err = netc_switch_platform_probe(priv);
+	if (err)
+		return err;
+
+	ds = devm_kzalloc(dev, sizeof(*ds), GFP_KERNEL);
+	if (!ds)
+		return -ENOMEM;
+
+	ds->dev = dev;
+	ds->num_ports = priv->info->num_ports;
+	ds->num_tx_queues = NETC_TC_NUM;
+	ds->ops = &netc_switch_ops;
+	ds->priv = priv;
+	priv->ds = ds;
+
+	err = dsa_register_switch(ds);
+	if (err)
+		return dev_err_probe(dev, err,
+				     "Failed to register DSA switch\n");
+
+	return 0;
+}
+
+static void netc_switch_remove(struct pci_dev *pdev)
+{
+	struct netc_switch *priv = pci_get_drvdata(pdev);
+
+	if (!priv)
+		return;
+
+	dsa_unregister_switch(priv->ds);
+}
+
+static void netc_switch_shutdown(struct pci_dev *pdev)
+{
+	struct netc_switch *priv = pci_get_drvdata(pdev);
+
+	if (!priv)
+		return;
+
+	dsa_switch_shutdown(priv->ds);
+	pci_set_drvdata(pdev, NULL);
+}
+
+static const struct pci_device_id netc_switch_ids[] = {
+	{ PCI_DEVICE(NETC_SWITCH_VENDOR_ID, NETC_SWITCH_DEVICE_ID) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, netc_switch_ids);
+
+static struct pci_driver netc_switch_driver = {
+	.name		= KBUILD_MODNAME,
+	.id_table	= netc_switch_ids,
+	.probe		= netc_switch_probe,
+	.remove		= netc_switch_remove,
+	.shutdown	= netc_switch_shutdown,
+};
+module_pci_driver(netc_switch_driver);
+
+MODULE_DESCRIPTION("NXP NETC Switch driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/dsa/netc/netc_platform.c b/drivers/net/dsa/netc/netc_platform.c
new file mode 100644
index 000000000000..abd599ea9c8d
--- /dev/null
+++ b/drivers/net/dsa/netc/netc_platform.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP NETC switch driver
+ * Copyright 2025-2026 NXP
+ */
+
+#include "netc_switch.h"
+
+struct netc_switch_platform {
+	u16 revision;
+	const struct netc_switch_info *info;
+};
+
+static const struct netc_switch_info imx94_info = {
+	.num_ports = 4,
+};
+
+static const struct netc_switch_platform netc_platforms[] = {
+	{ .revision = NETC_SWITCH_REV_4_3, .info = &imx94_info, },
+	{ }
+};
+
+static const struct netc_switch_info *
+netc_switch_get_info(struct netc_switch *priv)
+{
+	int i;
+
+	/* Matching based on IP revision */
+	for (i = 0; i < ARRAY_SIZE(netc_platforms); i++) {
+		if (priv->revision == netc_platforms[i].revision)
+			return netc_platforms[i].info;
+	}
+
+	return NULL;
+}
+
+int netc_switch_platform_probe(struct netc_switch *priv)
+{
+	const struct netc_switch_info *info = netc_switch_get_info(priv);
+
+	if (!info) {
+		dev_err(priv->dev, "Cannot find switch platform info\n");
+		return -EINVAL;
+	}
+
+	priv->info = info;
+
+	return 0;
+}
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
new file mode 100644
index 000000000000..a6d36dcebc6d
--- /dev/null
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright 2025-2026 NXP
+ */
+
+#ifndef _NETC_SWITCH_H
+#define _NETC_SWITCH_H
+
+#include <linux/dsa/tag_netc.h>
+#include <linux/fsl/netc_global.h>
+#include <linux/fsl/ntmp.h>
+#include <linux/of_device.h>
+#include <linux/of_net.h>
+#include <linux/pci.h>
+
+#include "netc_switch_hw.h"
+
+#define NETC_REGS_BAR			0
+#define NETC_REGS_SIZE			0x80000
+#define NETC_MSIX_TBL_BAR		2
+#define NETC_REGS_PORT_BASE		0x4000
+/* register block size per port  */
+#define NETC_REGS_PORT_SIZE		0x4000
+#define PORT_IOBASE(p)			(NETC_REGS_PORT_SIZE * (p))
+#define NETC_REGS_GLOBAL_BASE		0x70000
+
+#define NETC_SWITCH_REV_4_3		0x0403
+
+#define NETC_TC_NUM			8
+#define NETC_CBDR_NUM			2
+
+#define NETC_MAX_FRAME_LEN		9600
+
+struct netc_switch;
+
+struct netc_switch_info {
+	u32 num_ports;
+};
+
+struct netc_port_caps {
+	u32 half_duplex:1; /* indicates whether the port support half-duplex */
+	u32 pmac:1;	  /* indicates whether the port has preemption MAC */
+	u32 pseudo_link:1;
+};
+
+struct netc_port {
+	void __iomem *iobase;
+	struct netc_switch *switch_priv;
+	struct netc_port_caps caps;
+	struct dsa_port *dp;
+	struct mii_bus *emdio;
+};
+
+struct netc_switch_regs {
+	void __iomem *base;
+	void __iomem *port;
+	void __iomem *global;
+};
+
+struct netc_switch {
+	struct pci_dev *pdev;
+	struct device *dev;
+	struct dsa_switch *ds;
+	u16 revision;
+
+	const struct netc_switch_info *info;
+	struct netc_switch_regs regs;
+	struct netc_port **ports;
+
+	struct ntmp_user ntmp;
+};
+
+/* Write/Read Switch base registers */
+#define netc_base_rd(r, o)		netc_read((r)->base + (o))
+#define netc_base_wr(r, o, v)		netc_write((r)->base + (o), v)
+
+/* Write/Read registers of Switch Port (including pseudo MAC port) */
+#define netc_port_rd(p, o)		netc_read((p)->iobase + (o))
+#define netc_port_wr(p, o, v)		netc_write((p)->iobase + (o), v)
+
+/* Write/Read Switch global registers */
+#define netc_glb_rd(r, o)		netc_read((r)->global + (o))
+#define netc_glb_wr(r, o, v)		netc_write((r)->global + (o), v)
+
+static inline bool is_netc_pseudo_port(struct netc_port *np)
+{
+	return np->caps.pseudo_link;
+}
+
+int netc_switch_platform_probe(struct netc_switch *priv);
+
+#endif
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
new file mode 100644
index 000000000000..0419f7f9207e
--- /dev/null
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -0,0 +1,133 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright 2025-2026 NXP
+ */
+
+#ifndef _NETC_SWITCH_HW_H
+#define _NETC_SWITCH_HW_H
+
+#include <linux/bitops.h>
+
+#define NETC_SWITCH_VENDOR_ID		0x1131
+#define NETC_SWITCH_DEVICE_ID		0xeef2
+
+/* Definition of Switch base registers */
+#define NETC_CBDRMR(a)			(0x0800 + (a) * 0x30)
+#define NETC_CBDRBAR0(a)		(0x0810 + (a) * 0x30)
+#define NETC_CBDRBAR1(a)		(0x0814 + (a) * 0x30)
+#define NETC_CBDRPIR(a)			(0x0818 + (a) * 0x30)
+#define NETC_CBDRCIR(a)			(0x081c + (a) * 0x30)
+#define NETC_CBDRLENR(a)		(0x0820 + (a) * 0x30)
+
+#define NETC_SWCR			0x1018
+#define  SWCR_SWID			GENMASK(2, 0)
+
+#define NETC_DOSL2CR			0x1220
+#define  DOSL2CR_SAMEADDR		BIT(0)
+#define  DOSL2CR_MSAMCC			BIT(1)
+
+#define NETC_DOSL3CR			0x1224
+#define  DOSL3CR_SAMEADDR		BIT(0)
+#define  DOSL3CR_IPSAMCC		BIT(1)
+
+#define NETC_VFHTDECR1			0x2014
+#define NETC_VFHTDECR2			0x2018
+#define  VFHTDECR2_ET_PORT(a)		BIT((a))
+#define  VFHTDECR2_MLO			GENMASK(26, 24)
+#define  VFHTDECR2_MFO			GENMASK(28, 27)
+
+/* Definition of Switch port registers */
+#define NETC_PCAPR			0x0000
+#define  PCAPR_LINK_TYPE		BIT(4)
+#define  PCAPR_NUM_TC			GENMASK(15, 12)
+#define  PCAPR_NUM_Q			GENMASK(19, 16)
+#define  PCAPR_NUM_CG			GENMASK(27, 24)
+#define  PCAPR_TGS			BIT(28)
+#define  PCAPR_CBS			BIT(29)
+
+#define NETC_PMCAPR			0x0004
+#define  PMCAPR_HD			BIT(8)
+#define  PMCAPR_FP			GENMASK(10, 9)
+#define   FP_SUPPORT			2
+
+#define NETC_PCR			0x0010
+#define  PCR_HDR_FMT			BIT(0)
+#define  PCR_NS_TAG_PORT		BIT(3)
+#define  PCR_L2DOSE			BIT(4)
+#define  PCR_L3DOSE			BIT(5)
+#define  PCR_TIMER_CS			BIT(8)
+#define  PCR_PSPEED			GENMASK(29, 16)
+#define   PSPEED_SET_VAL(s)		FIELD_PREP(PCR_PSPEED, ((s) / 10 - 1))
+
+#define NETC_PQOSMR			0x0054
+#define  PQOSMR_VS			BIT(0)
+#define  PQOSMR_VE			BIT(1)
+#define  PQOSMR_DDR			GENMASK(3, 2)
+#define  PQOSMR_DIPV			GENMASK(6, 4)
+#define  PQOSMR_VQMP			GENMASK(19, 16)
+#define  PQOSMR_QVMP			GENMASK(23, 20)
+
+#define NETC_PTCTMSDUR(a)		(0x208 + (a) * 0x20)
+#define  PTCTMSDUR_MAXSDU		GENMASK(15, 0)
+#define  PTCTMSDUR_SDU_TYPE		GENMASK(17, 16)
+#define   SDU_TYPE_PPDU			0
+#define   SDU_TYPE_MPDU			1
+#define   SDU_TYPE_MSDU			2
+
+#define NETC_BPCR			0x500
+#define  BPCR_DYN_LIMIT			GENMASK(15, 0)
+#define  BPCR_MLO			GENMASK(22, 20)
+#define  BPCR_UUCASTE			BIT(24)
+#define  BPCR_UMCASTE			BIT(25)
+#define  BPCR_MCASTE			BIT(26)
+#define  BPCR_BCASTE			BIT(27)
+#define  BPCR_STAMVD			BIT(28)
+#define  BPCR_SRCPRND			BIT(29)
+
+/* MAC learning options, see BPCR[MLO], VFHTDECR2[MLO] and
+ * VLAN Filter Table CFGE_DATA[MLO]
+ */
+enum netc_mlo {
+	MLO_NOT_OVERRIDE = 0,
+	MLO_DISABLE,
+	MLO_HW,
+	MLO_SW_SEC,
+	MLO_SW_UNSEC,
+	MLO_DISABLE_SMAC,
+};
+
+/* MAC forwarding options, see VFHTDECR2[MFO] and VLAN
+ * Filter Table CFGE_DATA[MFO]
+ */
+enum netc_mfo {
+	MFO_NO_FDB_LOOKUP = 1,
+	MFO_NO_MATCH_FLOOD,
+	MFO_NO_MATCH_DISCARD,
+};
+
+#define NETC_BPDVR			0x510
+#define  BPDVR_VID			GENMASK(11, 0)
+#define  BPDVR_DEI			BIT(12)
+#define  BPDVR_PCP			GENMASK(15, 13)
+#define  BPDVR_TPID			BIT(16)
+#define  BPDVR_RXTAGA			GENMASK(23, 20)
+#define  BPDVR_RXVAM			BIT(24)
+#define  BPDVR_TXTAGA			GENMASK(26, 25)
+
+/* Definition of Switch ethernet MAC port registers */
+#define NETC_PMAC_OFFSET		0x400
+#define NETC_PM_CMD_CFG(a)		(0x1008 + (a) * 0x400)
+#define  PM_CMD_CFG_TX_EN		BIT(0)
+#define  PM_CMD_CFG_RX_EN		BIT(1)
+
+#define NETC_PM_MAXFRM(a)		(0x1014 + (a) * 0x400)
+#define  PM_MAXFRAM			GENMASK(15, 0)
+
+#define NETC_PEMDIOCR			0x1c00
+#define NETC_EMDIO_BASE			NETC_PEMDIOCR
+
+/* Definition of global registers (read only) */
+#define NETC_IPBRR0			0x0bf8
+#define  IPBRR0_IP_REV			GENMASK(15, 0)
+
+#endif
-- 
2.34.1



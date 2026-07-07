Return-Path: <linuxppc-dev+bounces-23691-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B611C44500
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 08:48:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvZcb5TmNz3c7M;
	Tue, 07 Jul 2026 18:47:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783414079;
	cv=pass; b=eOeseCKV64dRvBF147D55mrpU9RDIkSfoNXmTO5vdwCaCqcxkBQTAXTFhrsn/4bLRzWW6yMU8UgKG2upsQjJ0z2ggJCEakQFKOOK++6G1gYuGWnGevamFBph007gy/KFUEd1N/4IQugd8wnqttxJqwTMclinDWniMp6KPYU/sAhMVK6HELHCB7P9fV64gleopgKA3kJuBDki82YatUDyZAePnolXRQPfRxrxVYYjOWb7PQlrLnnvwJEyBQgYeolF8tldm1PdqxQxeS2VEDUpOpOXyM/rMZOcPwXo4kuvaFhYbvqluFvswmFbVyrx4TgGdhIyxuvAQ7DjnCmwig4i1A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783414079; c=relaxed/relaxed;
	bh=lXObFrFI4ieHCs+YnoMphsXVCjKXrlVokbXMdZ6VFnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CO3Hd94Cp4fxSQoKpker/6dh8hrW7kX0okz4WfN/PT1f8jjYv+uMrNu8e/tIyftGHlPK9yW3h5biuyj7Xnt/Mvyr8gniJCv+jpecX+53EKCXhQA7qUnTB++w38N0hhm9+xzaLtwYOd/Hv/GfqyeXOMuwmNWd0pBUryb5UFRrWWq668o8OaeEPXHjbRNHkprItA5OrSzegzwyvyuGShEf2NGMg2Hw2WnU1DKcAbzovm3A7pfg+dznQMEW7aEI0NI778e1WJLrWthtFsVw5N3as3he0mGZrAU4BRSSv+/FpeV97L0nAFTu9kAHyh9iKZ+K1MSNjNYzC+mSF2mmjcObwg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=OyossVDV; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=OyossVDV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvZcZ6rCVz3c6P
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 18:47:58 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/hgvy2h+S5CQd6OnIpq8gX/cwkP9H+KcODVzp8KMsZXW5VC59bPAgNxu+URgWpbBPPDO9F1WsB3L8mZ+cULskLx5OBMLpoP1VK6UfyKhaJAO8oL3V77BIPxBZKSIVTvbEzP7743LP8JXauKizMp1hB9sagr5pcKqW2H7Iwf9IxhegP4DbZh74mJJa/8Oxr7QTEO+7KfzWapE7oNFKCIeF/vAQxcElSJXJ6UW0SSj7MYRzTUknQ8cnXcIzkby47TsabOclsyeFuGDJ5qNmNsRsh9Lj6KoBVLpI3E9/4tJr5+gdFaMytbxqq3CpNCf1xRXhDjApwLG7uRhdDVIw0OqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXObFrFI4ieHCs+YnoMphsXVCjKXrlVokbXMdZ6VFnM=;
 b=QnnmXQGTrYUTIEnJ5CU1Lfd/gQew1MPVJd8SyOF8OJOYYNk3oBgIK985OVGps6FXHXwqBkblyDDnlFp3EWCEy33Unbyp5Pz2vJh0ChJTCq+r8EceAG3IY9qUiVmBQytQhGMtdXYH8NTtb1I0+Os0+lesTBev/REbXy7THDItSFBdk35h5xvFyROQn1ZoVAbyfzjr2li0XzUbpI4nJYaASPUtquFXp8LOii9hhmhRCocXf/x35bzQ/qiyTzGRV28DvH2vAglyfaQ08jx9yW2imwtAcdn9BGckcp6v2AC6E97L8LsXz9+3ZJlPZx9rYLxhxxcIA4l0zaa9E2xiF28Geg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXObFrFI4ieHCs+YnoMphsXVCjKXrlVokbXMdZ6VFnM=;
 b=OyossVDVbg6JO3uuA8pYbvKRZF2IYWzoY+3swcNnLndbazC18LAqvuwoTRDb4ZC8t2hdyWuxrOYgLs0XOAHCzRWpujJxD259Zdqyx8q0CEDwZCI5PRAfyJKxJrHrvx9Yt7U5Y3dz1vY0U+GxUtwoHIpph4fNBLioDpr7J0WnPbpDeye9KvynVwHWaBHJnHTVvjbAMM59ViXqxivjKi+LFYAWPv4PLALv3VaVz/6hAUuoAVaGWVrRjQj6baUiH6pvjJoo1HwfDiQOP46/ivhdpzGjNtGJeJ2SF0Nn481UUXPplI/0j2Et0cTX17ZXn7uUZ5xiuraPS+956zednJFY6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:47:41 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:47:41 +0000
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
	chleroy@kernel.org,
	maxime.chevallier@bootlin.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 net-next 08/14] net: enetc: remove invalid code from enetc4_pl_mac_link_up()
Date: Tue,  7 Jul 2026 16:18:28 +0800
Message-Id: <20260707081834.710730-9-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707081834.710730-1-wei.fang@oss.nxp.com>
References: <20260707081834.710730-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VI1PR04MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a0cd6db-a66e-4697-805d-08dedc0467bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|19092799006|56012099006|22082099003|11063799006|18002099003|3023799007|921020;
X-Microsoft-Antispam-Message-Info:
	S7Nj+7RNnHg5EEtBrLdnLeyN0bJG92S3uWGjusN4a32iqtl5WzlzIkHmNQDcBVHIpUcDWpjwfLu9KVAbTVOnCEltXVNnHWEUJ42usTfDc5HSqOlPQflb6vdIQ9Qv0Y3egbrEDdhqk6ROv1vEWr1LYeio3wtuoy4iWipllsY/xUTFhVmF5Op7lM16m+I46EU5/tr11BORSOVwNRkkbuUobH0PXPMxGP9P/PF0y1yZDbDmjSAHAEu0NE2lgmRb/j2Nsk46UMHrHpjbY39JlDOjAM3InZXjetWXywMDiYuat87bQ0ntPaiehKkl70yfiw10y7lhAadn0xFj5BeOA7rE8qwVXbJPpGNdO/sL/gCt3gJFnTbk7PfLo3e3RwyHlX/HLR95bAD7FD1ZGApo6TtSZ1JFN2OSd7oMTeW5vQc+sIQdacuGgv155jj5UPo8ZNUTAfN8ETAi0mtO/UUtMXDZyZzBRG/lG5stbYWVwnf5uanV+wks6mT3G9OQa9Ujkuh2Vt+sVhvAU8rxBoYMMtNfLX9XQAwitP1Lbt3P3vjcHn1+rFCQ4JuktGPZAswRX+o/+Jb0Phw/AXLZpDNoixP251zApoY5szeJEJZ//rIb+bAl8iyibVsBIsRQCJyg/E6BSGfQJv6JgFRPRIa4FC67/mubzB3psVLvUR79hIPHOay9dqrNgdxstiXIAE0fGnf1bs4OziJ4dZhv9eiCDDSkdA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(19092799006)(56012099006)(22082099003)(11063799006)(18002099003)(3023799007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?85nrV/I2vhR//SC4ve+M6UqZXwFAyoXmAl+v54UYihSPT3/iS5SfV3Ojll5Q?=
 =?us-ascii?Q?Xq5YlbbtAKtrG6Xi/XVkC4KRs/xpT5gi1hFEkDJCZUdSOEWaaGi5rlODD5rX?=
 =?us-ascii?Q?8QSQVg92YFH3C/mnsHr+3tyXEk/uu8ZEDP96DNgixFj7SArW0BvJpVzchjif?=
 =?us-ascii?Q?o9kYoWBJ7hfbq8NJ/FxuztKut5LtkcYfk51u2JYxhnTTXfAZUEVhXtgoKB6f?=
 =?us-ascii?Q?1Zy2Zl8xYA5wQ0nR9xQDsg385xq+eMZml5OCiTQIyBsJQQ6b6XQEe0ICLFRi?=
 =?us-ascii?Q?qVQrP6SyLOYob2b5tTuBq57pRBZafD5cqgYKFg/HP145JWrYeEVVnMUZCIIn?=
 =?us-ascii?Q?JfvIn5Ru5x9JADSuROvShH/Vboz1i9F5FZNqQbxP6D38UuZh0C37YJX03CNy?=
 =?us-ascii?Q?JUJhPsumTmfUYMj/6DiRNUCSL0pXxKv0mweaD7MtAUOu367jZY0vtHxXmE9I?=
 =?us-ascii?Q?TVLCALsc0dSZ1nBJtmrcjpBLYtFQKNcL9wm76kMyindkrC4WNTvMn7MZRg1I?=
 =?us-ascii?Q?Bh7nmaG5Y/wUVgN9T/tPCKC35zCAgMQbw0HE7NNNUbWubTjdnIWHQDtuMlcz?=
 =?us-ascii?Q?SNKb8sFo5VVImM7EhtqFV40KM+WcH3vIPgEC5ZOdYMtX0gMEu9ZceekPu14U?=
 =?us-ascii?Q?WSQ332LObeJXEm3+M78hlfyjdS1Cdulncj0TStKPwcZhkbEHyzdkwN5uIRjV?=
 =?us-ascii?Q?0wZFu7BXOsraK9WhDbejjxXLTWJeCl7/x6YP3g/sHPZ7/n4HHMW5YW7gbxdo?=
 =?us-ascii?Q?KAekt/3wTe3rObQllZJbVc/osfFnDUfD0xxm6rOSof+fW9JvCxjJ/NTJDonu?=
 =?us-ascii?Q?wV2ao5/VmIUs4LFSSwXd6YBGE9Sbr+JBCROLZlEPanqhw2i6G84nW990zuoI?=
 =?us-ascii?Q?iZP2cjMFVLTgDWcguVVwP/oapw+py2GvBzaJhuoMInfPt87k+SUNp5yUMRZ6?=
 =?us-ascii?Q?4t9ggmaBbv+CEOqV83vAIxl6uXL6gOrwjz3I6uI5GGM0opCVQ5uM158xGAWQ?=
 =?us-ascii?Q?DiatURZpxHtLL08YZ9NiF6IIl4ZPQh40mVEV5I7EuatbZ5wbPLSblVnBNTym?=
 =?us-ascii?Q?F4gFA0dFmhG91gq7s4diDK1sj720XiiF3+isa36BUyeOp8Q/lWKkjTtDEhqZ?=
 =?us-ascii?Q?T+2zpA+6eGjLZwTIAdKV0lKG7RKEWs0+nWvLU2MlSNc/m3xiK9AiHKABsNus?=
 =?us-ascii?Q?Qq4IsQd/cgzl8tSq7dD+8nBxkEul7Fzi92TjbuYOWmg7lgvWb4pKzkbA53RA?=
 =?us-ascii?Q?DGUKYYS692G0XekwBhs920MnDjPm9pKQKwbhBwExAhyjitMigPJvpbS1jFyg?=
 =?us-ascii?Q?lgP57s5zXM26R2M1mH2m6YpKNPVLHSfkhQMhWsfT9T9EJJHobG2E4Vfqkphy?=
 =?us-ascii?Q?JiY7/wOiVBpL/G7p0Vb9c/6C6ibnaIOU6cUa0YZ9Eax6IAml7JTi3ZA3Vizq?=
 =?us-ascii?Q?aRDpCZmhXqqQ/nqyTyYu7TD62qSz4s8mpZn3QkLKyqkwOI/eHj54e9/Kr97i?=
 =?us-ascii?Q?E6a5bMaDHzY2IBTDXHth8nNbWSRKW30M2qjZjqDUUF3CsqwZBabM417/UUAU?=
 =?us-ascii?Q?3wVBeSxmkHxNg6M0wIeBHsYXTkAvMioLwV0Vv6E2jBVvQS8yr2MTknvzYxlD?=
 =?us-ascii?Q?AnfhLLs9hrs10cAGhbf81xCW/YqASnRFv6Uybn8H8xllB9bCpA4zdpZnRu2b?=
 =?us-ascii?Q?jLGDptMCEm3OzlGgQwbGHVm07o95foa9g7v1nOreAB+rwifQ+CrcHVlI0Acr?=
 =?us-ascii?Q?GnuhGZ//nQwtHj8Xzhg/9577Z6MNDCrTERMPZe8rcJnL0uKRRfK1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0cd6db-a66e-4697-805d-08dedc0467bd
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:47:41.3498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guGkR3n7TV8D169/xOI2sB4Q5tLESac1vc4mn24Z/HmFpxUVMOSim5YxWtQjkQ4aaFumR61GV0VdKFx6HgSnpKcpJZtqMVbvQpVxv/1yZ61jnFV0bKo6pEOjvZ1Z07SK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182

From: Wei Fang <wei.fang@nxp.com>

When adding phylink MAC operations support to the NETC switch driver,
Russell King pointed out several pieces of invalid logic in the
.mac_link_up() implementation (see [1] and [2]):

1) Half-duplex backpressure is not supported by the kernel, Ethernet
   relies on packet dropping for congestion management.

2) phylink_autoneg_inband() is unnecessary, as RGMII in-band status is
   not supported.

3) TX and RX pause are disabled in half-duplex mode, so there is no
   need to override them in .mac_link_up().

The same invalid logic is also present in enetc4_pl_mac_link_up(), so
remove the invalid code from it.

Given enetc4_set_hd_flow_control() is removed, pf->caps.half_duplex has
also become useless and should therefore be removed as well.

Link: https://lore.kernel.org/imx/acEIQqI-_oyCym8O@shell.armlinux.org.uk/ # 1
Link: https://lore.kernel.org/imx/acEFwqmAvWls_9Ef@shell.armlinux.org.uk/ # 2
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  2 -
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 38 +------------------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 -
 3 files changed, 1 insertion(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index dea1fd0b8175..09025e7a2a3a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -135,7 +135,6 @@
 #define ENETC4_PSIVHFR1(a)		((a) * 0x80 + 0x2064)
 
 #define ENETC4_PMCAPR			0x4004
-#define  PMCAPR_HD			BIT(8)
 #define  PMCAPR_FP			GENMASK(10, 9)
 
 /* Port capability register */
@@ -198,7 +197,6 @@
 #define  PM_CMD_CFG_CNT_FRM_EN		BIT(13)
 #define  PM_CMD_CFG_TXP			BIT(15)
 #define  PM_CMD_CFG_SEND_IDLE		BIT(16)
-#define  PM_CMD_CFG_HD_FCEN		BIT(18)
 #define  PM_CMD_CFG_SFD			BIT(21)
 #define  PM_CMD_CFG_TX_FLUSH		BIT(22)
 #define  PM_CMD_CFG_TX_LOWP_EN		BIT(23)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 75ee117e9b1d..859b02f5170a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -29,9 +29,6 @@ static void enetc4_get_port_caps(struct enetc_pf *pf)
 	val = enetc_port_rd(hw, ENETC4_ECAPR2);
 	pf->caps.num_rx_bdr = (val & ECAPR2_NUM_RX_BDR) >> 16;
 	pf->caps.num_tx_bdr = val & ECAPR2_NUM_TX_BDR;
-
-	val = enetc_port_rd(hw, ENETC4_PMCAPR);
-	pf->caps.half_duplex = (val & PMCAPR_HD) ? 1 : 0;
 }
 
 static void enetc4_get_psi_hw_features(struct enetc_si *si)
@@ -588,11 +585,6 @@ static void enetc4_mac_config(struct enetc_pf *pf, unsigned int mode,
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		val |= IFMODE_RGMII;
-		/* We need to enable auto-negotiation for the MAC
-		 * if its RGMII interface support In-Band status.
-		 */
-		if (phylink_autoneg_inband(mode))
-			val |= PM_IF_MODE_ENA;
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		val |= IFMODE_RMII;
@@ -695,22 +687,6 @@ static void enetc4_set_rmii_mac(struct enetc_pf *pf, int speed, int duplex)
 	enetc_port_mac_wr(si, ENETC4_PM_IF_MODE(0), val);
 }
 
-static void enetc4_set_hd_flow_control(struct enetc_pf *pf, bool enable)
-{
-	struct enetc_si *si = pf->si;
-	u32 old_val, val;
-
-	if (!pf->caps.half_duplex)
-		return;
-
-	old_val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
-	val = u32_replace_bits(old_val, enable ? 1 : 0, PM_CMD_CFG_HD_FCEN);
-	if (val == old_val)
-		return;
-
-	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
-}
-
 static void enetc4_set_rx_pause(struct enetc_pf *pf, bool rx_pause)
 {
 	struct enetc_si *si = pf->si;
@@ -886,13 +862,11 @@ static void enetc4_pl_mac_link_up(struct phylink_config *config,
 	struct enetc_pf *pf = phylink_to_enetc_pf(config);
 	struct enetc_si *si = pf->si;
 	struct enetc_ndev_priv *priv;
-	bool hd_fc = false;
 
 	priv = netdev_priv(si->ndev);
 	enetc4_set_port_speed(priv, speed);
 
-	if (!phylink_autoneg_inband(mode) &&
-	    phy_interface_mode_is_rgmii(interface))
+	if (phy_interface_mode_is_rgmii(interface))
 		enetc4_set_rgmii_mac(pf, speed, duplex);
 
 	if (interface == PHY_INTERFACE_MODE_RMII)
@@ -904,18 +878,8 @@ static void enetc4_pl_mac_link_up(struct phylink_config *config,
 		 */
 		if (priv->active_offloads & ENETC_F_QBU)
 			tx_pause = false;
-	} else { /* DUPLEX_HALF */
-		if (tx_pause || rx_pause)
-			hd_fc = true;
-
-		/* As per 802.3 annex 31B, PAUSE frames are only supported
-		 * when the link is configured for full duplex operation.
-		 */
-		tx_pause = false;
-		rx_pause = false;
 	}
 
-	enetc4_set_hd_flow_control(pf, hd_fc);
 	enetc4_set_tx_pause(pf, priv->num_rx_rings, tx_pause);
 	enetc4_set_rx_pause(pf, rx_pause);
 	enetc4_mac_tx_enable(pf);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 6f15f9ea1664..7e886dc49997 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -17,7 +17,6 @@ struct enetc_vf_state {
 };
 
 struct enetc_port_caps {
-	u32 half_duplex:1;
 	int num_vsi;
 	int num_msix;
 	int num_rx_bdr;
-- 
2.34.1



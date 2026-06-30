Return-Path: <linuxppc-dev+bounces-23161-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762E7C43327
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 07:49:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqFdm5pcKz2yZ6;
	Tue, 30 Jun 2026 17:49:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782805740;
	cv=pass; b=itKB2gY0VSu0lXHbLSzy/Y4JAl18dm9/5wZUi8pQaPgspE1eN7Ls0aNemf4jsF9u9uEo8qPd2Dj/cX2hxpNc0rTX2erYMNLY5bXBTTV8tAxISDhfPSPdHhce9bn5SN1yjKpLe6LdEVtg+YbrfrsjLWd5GLbJAVdr3bAvlM4vNUHwjqGRcETAC4PfW1NvwYht8gj3CzU9cABe+V9i99+JVEDiRIBfdCAz07pXiUHY9S/OywtRSwCz8TUlnC96tG/TGevERlEWrlJXAqzvwv8irhj1i8UY3y24RZS3A+fPm4rMw9tuzyE6laBnATf3OyVXe0huEwzuFrBmnzObWNClzQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782805740; c=relaxed/relaxed;
	bh=nQROpfKmhKQFMcsw+dERv5Wwde6NBM7rPw9ZrfNFpVM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=isYdUvoktUd5Wb3V+72wTNZXtUl6Ah9vnyEHP+VHB9Rqz9UpfeF6jZrpsB8vBmjNxDTqqrXfT6xHTx4ecNDtsro/jTmvqDZF1iF/gaCG7vjFt/bkAhDXk5QjVdd+XAqhu3kReDJoUCydqgzTTLKdmWz4xjC4y677EOHCTZcfFyiKxtt90R+WJPvqazJi8FziAirBOtl+iO63bYaeOkTC2VLnymXPBlCdVagW5aHxY95EFxEwwz+ua7RBfSxPRrOe/Ao0BlG4affMqHSFZKZ5P4NCEjLmWW4y3tulmaPXWnPQc7E3cXcu75ipS4OROM32mohS6CIN2/+/iiRWqKlyyw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gMbP6wlx; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gMbP6wlx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqFdl4F3mz2yYs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 17:48:58 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=px7cYoY5QqGgUVjlSFSu0x9CY9kivg8dRWEeV2JqKJsVYoFksHkcrqRJH8qvtcRds5S/2WW7HDtP2nKiDpwMzBS02b/ZqrnhaA3fWE0OGfsakzBPfksE8rAd6ewPrHwqz+YD3K8ZjpgBI4sba0YeUCVyGZxTLEoeATJIxkxKoFXkne3B9uu47V9ps/+4qmsWx4gQEao3rfra/f2R+2y6Qvkl11j92/Mn39tRKhiErfW21sbs7JcGnQ4VmWFhoriwrtJGk7r6ZPs0B1UPuBR/3dE9q9XZd+JdmEx7wNMVvEuqC7d0VE6V3KLH8/Lzkltmqh2wTuXdG4ZsfvPxgiQToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQROpfKmhKQFMcsw+dERv5Wwde6NBM7rPw9ZrfNFpVM=;
 b=fc9oHWkZmq88ihU9RrrXGBwD4FfYxpkZ/MO+R5itTgqwfz2HlOvmGLzysLAglNApfEpvVRs1dBthe83YDmIheeq0r5s1UkN+5U75fxek84ZI51EYkg8PTRtaB9fyK+6FAZC6o7jX/RgbPFo5jPWdXlbFN4yl8b2LNdMXiDwcSmbOSFzW60t8PF4XBSm8HqcjJVhoq+1gQVCZ4qbZzrThvy/NFpBYjSJzMt1VXV2DlNTgMd4eg+1RKFa1RFL4WGYnFWPvgZj1kyqjoE+wTgaL7hHVFznExAg0py12xI+8ZFY5mc7gKxYPW2usxOCpk0W1E5+s1Wvv4oUePRhDkfPCpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQROpfKmhKQFMcsw+dERv5Wwde6NBM7rPw9ZrfNFpVM=;
 b=gMbP6wlxtg2dfGYV+yjVxSznvuZEi4rGPyfFPS31bOqn/r41OmGynB+ljzLiWWQ8itWFo/AoGR7gHNSCOPbxFC+czcs1FzwtQFnPpwPoy2I0vktJV6zx1P5M8IWwXyB40BX5hdZ3Ek+JczpoAkd33dDkYWSlAqfdF5MBxuvkC+RWzqR3mGQM6wxZbNJ7CtFFrDHVZ+Y3I0jqymSyqBMJYlmG7CO+mtgcOQn0u/o79CvVJhoh2zg5guHvhGuHThyXhKqGXyepHrWkSiOmhxN7lAWjfXO65bc8R/BseNZP9HfJ9qPw9ZTwE3eiF3pgAL4UIK+GOy/PQxJYdgJlMMSlyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU0PR04MB9561.eurprd04.prod.outlook.com (2603:10a6:10:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:48:33 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 07:48:33 +0000
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
Subject: [PATCH net-next 00/14] net: enetc: cleanups and improvements
Date: Tue, 30 Jun 2026 15:20:22 +0800
Message-Id: <20260630072036.382761-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU0PR04MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b3cd7a5-b549-49f5-f929-08ded67bfbdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|19092799006|6133799003|921020|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	5ZTR7D7fL188CvWfG5PU0mrCeKsarM9opf29TKSXkTDWDMCio5YSdOiC8DQ8dBe1OhNfi5WqjdsNKfBUQj1xr6MfqlWmpP2A9NBJ+hrhVdt2xs4v+kO67WTtlKFFtT75pjCAU3N51wJbZvhDYWNttxpSTEbzdbF4K+1rCBMRoNrervjMFANJhizG77OyOQjim5JovrAMmdyEz/+5y3MbUN/1Hx5GCyOe6BgT8j88uqnjxtcsicPFZlUxYdtOwHliB3CWcdeWUPadyVMy8AyudeHbtpW8bF4ARN4PDkYVNoXlD9dqM/ZWwLIw3LrNuzWDdePD85Gz0PBt61BLnWAyBiJpzK8gez38aIGMSQKgSFEjsy8Q8QJ1kEiutKYE5q1XUxwQ3DpnnI1Zti0nYoocHj6oz3l/3kVVXJa+ShaFtpHSGLXfUO5WXSuEUsm1rOPZJdfHsz0yF7uxjJuvkywRWNZ2cgcZqUmxSgJgVXjW/zGuR12Hwbw52R2osyDfDoZLLdqsqG/hC8PDtxNoZnuwRIZOBVpeBYodVS2GSUDScDomVLoPyUosz/3eW83PkmL8/nS+44H38GsCJDXm4tT/OhfhEOuO2HWw2mvECh44UoA+cRuUr7nAbRktWtJdEdMU2zFTqZ7ODGSx/BIzfw73x+ph9lSUSC4NRNkn+DyoNl56PzS9xQy9n3cG1ruD+FSN1qN/eeewYbqIdJ6ebFT6gg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(19092799006)(6133799003)(921020)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5N4E4/0nR6m3QBgil42YVGTjzHZk8lhbUlH9G+ADeXrPHujYyKAVwaPfa1sD?=
 =?us-ascii?Q?V0f2hn3fDAY8jOyCocM9UQioA4YYlb5C0ObWQ5tiHpkwDqQKJcF6/lzek1u1?=
 =?us-ascii?Q?Tnn1rt2agB33SJZNfTZL1cz+Bz+eT4goKtExKG5S8u0I1ZDX3tpLvnUiyaI9?=
 =?us-ascii?Q?R3YCt8++8/AUJzuVw6XxfPDlHGY6dV1uA1yc31yxtFHZI1UMBQ8LZFDEfN1j?=
 =?us-ascii?Q?HLH0R7iHhkHtTEb+OOaKZqjtWuWSTAZcC5+0/0z/xP7LmubXaExO0Bdm2dxI?=
 =?us-ascii?Q?M/CmqsteXTJ01JuTjgfNcIir6i9vC0VrVIlrtPxOwHhtZMVI2CQ8RnAzVtxg?=
 =?us-ascii?Q?5ocJvWPiQfqLMf82+x3prV8AjlUjnKLDq6T/v5Dmrbq2Cyi3qnc3oherPCht?=
 =?us-ascii?Q?2/dw3b7IY2MwTOQqKn+x8RiV+VdG9H1rvQwTp8sGdCNExoSzOba9DBdVrtIC?=
 =?us-ascii?Q?7HUVVHFC2AU1IySe5BIELqNPzROufGU24iv4XMWrU8dfOoHX4vCMWHFZxuoS?=
 =?us-ascii?Q?iBgfi/JqC/e3gK/1hHzLQzXUAIspSpD8BNtE8j7DDUftrX6oIBGeyleKigGh?=
 =?us-ascii?Q?YI+nypoz6bAiVlEu2X3yu+vvTTUJ4hvq9evhS2ij7h0Cevo+KO3SubC4DZ8S?=
 =?us-ascii?Q?hCyFJqUa2MQcDAReu59FhDUMY5TlFjLhRf88z9g1iDKpj2bWSC9sKTYheg7d?=
 =?us-ascii?Q?pXRMFzkWnQq0ftEiCXr+bdrEqCvHshB5R+YLKrwg5sUaSgt3zMJqyKtDU8oQ?=
 =?us-ascii?Q?dLNIdGzyw49yZDwnY3kR0RxfZzChhfeinjtr8gq8zQQPx0+5ZR0YvFoaEzgS?=
 =?us-ascii?Q?s3eLkFl21uzcHju8611xhqxYv18JLqSdWJqLXFYpBGyPVFI7La7dVrMblB6N?=
 =?us-ascii?Q?T92bjc8P5RoUDheir0naDjbXKrdfBIzc+rWPEcnD/YSoVFDX3sVPb2QLPGUz?=
 =?us-ascii?Q?G0WFYeRb5M7PBCT49eM62+A4i6fZ2H0oYASAe5nGrT0qtRN+NT5f5l2Fw+Xr?=
 =?us-ascii?Q?TFYiqahWFLhlRPFE+dlGj6qR4dohBZWDbflXwLcxbDdYXZ/eouYhMveQtXbv?=
 =?us-ascii?Q?PoGoEzVXhNOoYKraefIsGPF5Uf6q/9TViOTA9f6CbQlz6NTSUVw/3jHg2rMV?=
 =?us-ascii?Q?IEP2BWeSDWhMBGEcrDwR9UOAXlXiZo2AsZkjZGql/lSWxbGizfsq820lWnYp?=
 =?us-ascii?Q?mlvv4lj9hjtrMU7PwBT1fWpCLpSsIloJBg7k3kC1WOhQ4O5XNQ90ZBZZdYjA?=
 =?us-ascii?Q?lRr1e5yPkGDn4DY1cJUjCRy1Gs9tfY4CdphFI+yDUoUvThQxSUBk5xojyA87?=
 =?us-ascii?Q?EXoawexvKVzpMGz/t39Mj0j5t9iMQrBfrXZMBFCW9vMg/62n3Mu6t6bp/WMF?=
 =?us-ascii?Q?D+tx2js7bjKuProyVSqzgH1Mg8+fwpOFH7A908n0USKa4ut+RiAseHOgqLUN?=
 =?us-ascii?Q?WvvsU+a8Gol4AhRIJy238EAqcXfEFhtipMx4liXmR9Adou86BxxY80yd8vjq?=
 =?us-ascii?Q?euA50PBJ+loMQsW2pi2ZNFHEl+OuXNX9VuC0ajcq/XB4cIews8B4cQ+s1qQ+?=
 =?us-ascii?Q?simyy2gxuBD1dmfMXzPkEYoboFF5+9RKP8tuCfdaTvDi29j0smbE1vF8JKac?=
 =?us-ascii?Q?9JrvNazTXfuB6mFDUSh2KlYTXivncapqmwA9pZZzEgH+F6F2nCPhdq4AiqTp?=
 =?us-ascii?Q?r6BOoT0yZwo4daKfCti9l5wFX9JpZ8qDEy4dHKD0EAi1CWvHLz+LAM7713XY?=
 =?us-ascii?Q?m3purMHz1Zi4vtu5+JDIWM6LUKWdjCrLmXoXi4NXPNqT/w2a/smU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3cd7a5-b549-49f5-f929-08ded67bfbdd
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:48:33.1582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HapINlF7I4Zexejh1elsDVl9RxSrnCM8RQHjLZ+aPZWtIgljfD6yYAg/03HUq+kBzlrjle9dfHk0WczF2MusGxB8dsnvZTbnl8XDf5OuKPykcG9brjVkenGCv0j9EraS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9561

From: Wei Fang <wei.fang@nxp.com>

The first group of patches (1, 2, 5-7) eliminates code duplication
between the ENETC v1 and v4 drivers. Since both hardware generations
share identical register layouts for MAC promiscuous mode, MAC hash
filters, and VLAN promiscuous mode - differing only in register address
offsets - common helper functions are extracted into enetc_pf_common.c
and shared by both drivers.

Patch 3 converts ndo_set_rx_mode() to ndo_set_rx_mode_async(), removing
the dedicated workqueue that was previously needed to defer MAC address
list updates to a sleepable context.

Patch 4 replaces counter-based MAFT entry tracking with a bitmap, which
keeps hardware and software state in sync and avoids partial failures
during entry allocation.

Patches 8 and 9 fix phylink-related issues: removing invalid code from
enetc4_pl_mac_link_up() and properly differentiating phylink capabilities
between pseudo-MAC and standalone MAC.

The remaining patches (10-14) are minor cleanups: removing a redundant
VLAN promiscuous mode initialization in probe, using the PCI device name
for the debugfs directory, simplifying port speed configuration, removing
a redundant num_vsi field, using alloc_etherdev_mqs() for the VF driver,
and using kzalloc_flex() for a flexible array allocation.

Claudiu Manoil (1):
  net: enetc: differentiate phylink capabilities for pseudo-MAC and
    standalone MAC

Wei Fang (13):
  net: enetc: extract common helpers for MAC promiscuous mode setting
  net: enetc: extract common helpers for MAC hash filter configuration
  net: enetc: convert ndo_set_rx_mode() to ndo_set_rx_mode_async()
  net: enetc: improve MAFT entry management with bitmap tracking
  net: enetc: use PCI device name for debugfs directory
  net: enetc: simplify enetc4_set_port_speed()
  net: enetc: remove invalid code from enetc4_pl_mac_link_up()
  net: enetc: remove enetc4_set_default_si_vlan_promisc()
  net: enetc: refactor SI VLAN promiscuous mode configuration
  net: enetc: move enetc_set_si_vlan_promisc() to enetc_pf_common.c
  net: enetc: remove redundant num_vsi field from enetc_port_caps
  net: enetc: use alloc_etherdev_mqs() to create netdev for VF driver
  net: enetc: use kzalloc_flex() for enetc_psfp_gate allocation

 drivers/net/ethernet/freescale/enetc/enetc.h  |   4 +-
 .../ethernet/freescale/enetc/enetc4_debugfs.c |  42 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |   6 +-
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 410 +++++++-----------
 .../ethernet/freescale/enetc/enetc_ethtool.c  |   2 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  12 +-
 .../net/ethernet/freescale/enetc/enetc_pf.c   |  93 +---
 .../net/ethernet/freescale/enetc/enetc_pf.h   |   5 -
 .../freescale/enetc/enetc_pf_common.c         | 145 ++++++-
 .../freescale/enetc/enetc_pf_common.h         |   5 +
 .../net/ethernet/freescale/enetc/enetc_qos.c  |   4 +-
 .../net/ethernet/freescale/enetc/enetc_vf.c   |   3 +-
 include/linux/fsl/ntmp.h                      |   2 +
 13 files changed, 345 insertions(+), 388 deletions(-)

-- 
2.34.1



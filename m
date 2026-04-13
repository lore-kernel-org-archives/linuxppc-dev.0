Return-Path: <linuxppc-dev+bounces-19668-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18742EBFD10
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 07:51:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvKNc0L7Nz2yrg;
	Mon, 13 Apr 2026 17:51:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776066687;
	cv=pass; b=k4HrXiVGxvhBYp9MmgC2N1VM/4OuPE4MHdQCcIvgXnr8k8X7YnQxMuEX5LpgSvS7ZI9fmKOKIECr+jgtC5cgoNWLt07HbL6TFNpNFKMCkB9kQ7Yzh4NCMuAxWcomGQOfpcQOmHPsFdmRhMtVXzee1Iw2xwBHkqHYYRLXO/CMIDNasymjHLrs89lF8LRMVH/RoyNlj8X2LasZddiCkO1XQNhwIQTUBrMTmNkmJtdeIKdgxZi74OQeM0w+jl69I5M9CJJ5Et8FM6NoGwtPULm8FM5vs8GEoNSglJ5NOm6XzOqCvz899Gs/zs8J5vHvj+C6vfsvdYrruYFJlLpPm0q/ig==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776066687; c=relaxed/relaxed;
	bh=NVlcMmeLWEJsMVz/tTFkQ2TLrqhq+YR2GJPfI66YfDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KonkG8jplXUSSwNAZ66R+tPZwWRdziuTfaM0+7TbgqKMOA03hoddz+YADzcZFxDuH365R5gDovq0cLUzzSJASIOaToSsS1pk2k2UXeplJIYsEPSwCGjzjsXFie/MdRQgsDKsEv8ERD/qrIdY4/frA7GU6d3C9oBTZhnMk9K9bbj2ZpHo6K9AQIyhcWSTJ3WF9Xq6kKWcuFm4OQI7+03U925a0T5agodyS08ZIUCv7sFMNhAAdlRE/gmnkZjDWeM+GK+1jw3tI701se6fXDybG5l+0Nk9DfdbRbcGCwxTJHas2pHtKnoW/HGmDsrrL2kT6Mm7JTQ6RY/7QOMUOSkhLg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=O6Ql6WQn; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=O6Ql6WQn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvKNZ3Gknz2yv2
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 17:51:26 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slWHGO7t/DSdzFuiQVLbTOa92NWqkI21VZSZRcsJ67Z7SBsTrmsT3OjaiwGMVhfRc/Bj5U1riWPrSjEI69L58jYjJzDtg84CIYFMigPWjlGsERbuQo9LzPUvpP7RqcKxrYhIEkW+TfECu1MGtSSX8H8kQXheGPqLc37mkp1en+l79/SWgngQEeMnhw8ZMBkGD5QQE/Wm0gmREyLPPrr35EWkRFN3wTy9ICqfU/DRcQkoGUXfkBN6+xaDFDSac2uyCX3stRPIPX5aa0hFslNya2FwLguEDcFqMo5c3yTWi8wZ/dtrz0axAnEmtMSAhkIG59SCjrulmge76TX4uC4/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVlcMmeLWEJsMVz/tTFkQ2TLrqhq+YR2GJPfI66YfDM=;
 b=Rk1NH9QyghZKS6GSqh75yaorWg2raWvh+j+f+7giu+P80q6rVM166kN8eUdyY32otkaDu4TDHgbYef2x8Zs05lNTjWAb5yRcaQ0mWk+URVsExdv+Shz8x46GkJ55efuQqIx/Ni9tBTvPmsU7Fe+TCHlRExmVLPzGxO+2oR5V1lQYb5OokmOnQR2oiy79uGfYBdPbjFxNXruoQpUuUCrSq5pV5a474E98XPyLJPpjY8Qz26O4C+mbvsJZEOLYjip7XEKONyPVWJ2QrQ2KVBRA3fYSKSkKtKpIShzzsWtyTpYI0XF0cTiyT3Nfcw3BEHtYRAs8azKRzwXxQg7cpRPdcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVlcMmeLWEJsMVz/tTFkQ2TLrqhq+YR2GJPfI66YfDM=;
 b=O6Ql6WQnS3hxd7ZFdnBs7FpNhejziXnMIJrymV9SM3u+UOk8DmAf/IyV3m0Q0lsZD1rsWq1CkW/4VOnMJ9agimgzmtru/E/FhnrJiCeh93dlwcl27H7eaMmr6oDwZdDvtrx3BaDPx8ndaBbH1X0hMTh6uYCrbGHlp/0cUeDXQV/fi97zqaLyndHCPxQCdNFUOV8UYPVLJbYtR0hPUak1EccHEKjsPgMSTxeG5DlZxpFo5nWyIL6Krtndk8pIiMmT6J9o9oLv5zpRUjbJj+rhhp0aqIbh5hk903zJf+oCzH8cBi3dE7EjTwoPOtQx7i56GG+EB4KrL/r812b3OCfvog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by DBAPR04MB7463.eurprd04.prod.outlook.com (2603:10a6:10:1ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 13 Apr
 2026 07:51:06 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 07:51:06 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net 2/2] net: enetc: fix NTMP DMA use-after-free issue
Date: Mon, 13 Apr 2026 15:52:50 +0800
Message-Id: <20260413075250.281653-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413075250.281653-1-wei.fang@nxp.com>
References: <20260413075250.281653-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0236.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::10) To AM8PR04MB7284.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7284:EE_|DBAPR04MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f9cf77-5439-4df1-7e8a-08de99316ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	q9gJKUBvfzfmAJ05O7exqnRLWDRdh7l9IiG2Ndt9f1/ZXUztRgaRbHNN2U2lnrv4pb1zt5KyK53PeVN9pTqIO8L0KxFBZxYtwFdTsYMswjqicsoJZBe0ll2O75DFiaXzttpWcxtDCF4YZJVjlb6KeQqx65W2MdzoM4fNeUK1javrbI2Z6FKj1Uz8BlQz9Zu9JZ8sCYEW55G1OtU1rcOEATkg1I4uSa9PmQVtpKLatwvGHVeHrzb4MX9mLvHSxgVN4MxggXNl0FmJcuvm7BVm9oHPSN5TKoqqDAaOa7PcyBs60Lu/A5aGCemw8ukQBmmZc7vNFWypx1KGPEm7IHbHadYCQKVcrBFTb6KlrwM1E11L07NTP+Bd5XSHUDLzix6KS194VnjW1xq9tZTOliGLEjNR9iXNSGjjza+ewLcNAHz2gSFLjhbKrfwBfkUrkygEgYmeoDkKcqIqd2ZWigIAuqafVpYOMdNBwmvoWBx9IxG0emzfMFUmtL0lLFCIg/Jv9Oki3ahpXeW9lJ2vKjvoLz2Dv5fH81sWj2dRg+D+sMcxRV/gmsoZzs7B8uOW+e0r4kDyYWoicMJJpgh6dTPOHSd6Uo8Lca/HuigUDMHHBBgD9fvuUIxLkOJUeNP51a11cvTLGHKBOYC9yIj/f84bZ4nHrm/+8owdBT4jYOhxMdr0MpVsXVDzksaCT/wFP/hoqdE7GlJz7ycIx0Uvn/+w2OSYa/7hxtJvP9yD5ikPPn2DJAa/Kfpqi6ZiztQAuJUn99wcBD8QTnZTVhDoIfJvTQtsqhuoA1g+LVdChz/Y50I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jtFlF6fD/i1NxwvOyWHzDbCn10QfxyWB/CVG9P1R4gubrLYggo8iiQ2Adbn/?=
 =?us-ascii?Q?lhanFqhPb7inF5SfEn6TIJjTeKaPqcqQOrmHZaFp1hB46vVmhk5qFursF3cM?=
 =?us-ascii?Q?ygA/uXUc8XvqVJN8eByBwjuiKbsU6Q/hLnWmkGZTOhtfrGB4FmC2sO/QQ5oV?=
 =?us-ascii?Q?33Dit7Uth8QAbSViaAPjkDK++v2Z7TN2qz/mxq3YIZcM5WtTlyMaZGtx+RMd?=
 =?us-ascii?Q?RjPe4UjHmoc378bICgTaXBuMyTFlEKHgiCOFkjf7hhFUaiO5moqbEdYqjkIK?=
 =?us-ascii?Q?FaiOE2XlRjZ3vJchUIBOdbZHRiXsLg+1UEb1ubgvI7NzwuC6fYq/to7J2tPR?=
 =?us-ascii?Q?lWzfj6ymbqswbmU/9xVQMdp4zLBWUKbuMmgqSM4jIXER+Xo+eFT4ZwPXv6Xv?=
 =?us-ascii?Q?sa2js3iByB1Hj/oZ0N1btF6x0AP4SxPP+0DMnVg0BxkXwaMXbPsWfH8Hvorj?=
 =?us-ascii?Q?dD0S1sG1JIHdWK68FSgvWcwKSV5+/AmG12lrR1KaraPya5ww33uUynQ+zYQC?=
 =?us-ascii?Q?0fLcD1YoioIpLZOU4vmFd50j8BNWe3+ynsw1UQhrw4yh2b6ZJ+KKOG9P2m6f?=
 =?us-ascii?Q?+K3yjsCaM4t9e6kgkGVObossDPflAGdHEflK5Y0bBrouId73kQTZ5PIvjBEz?=
 =?us-ascii?Q?FW8ZB1kfnE5SahqrujFIE5mu68qC+N8R19VPBBG5CyHpz6FJAdYHTYaf61N1?=
 =?us-ascii?Q?x2zPpGyE1dPQi1krEX5a2A8HjvvGEonXJaQ7nBHUv9aQ13H/DjBs2VLid40M?=
 =?us-ascii?Q?hxd9kiroTV7qOYkpYkFKkJZ0D+jDUON07PHMpdGoPLTt4L6asjhOazyXkUXP?=
 =?us-ascii?Q?9D3lKI7z6bK+lZ6TkJNkZEEzRy4Wgt2mr4+YqK0DffdXREGtHZDS9/zG+A6u?=
 =?us-ascii?Q?0BBhiFtMRkL8U3sKD0n256EG2ayuFAjENin49KbWKZzQcEre+k2uCULR25Tf?=
 =?us-ascii?Q?ugzSx0vJjeQNp0LF4P/UC+Z50mTPL6G6Y3VY6tIQVOlu8HPo04qf3qasG10n?=
 =?us-ascii?Q?Dr5dcWUfqHGHZUGrrA447dy0CevQGhavqZWIqrnQODw1iii1N5k5AD2bSUp0?=
 =?us-ascii?Q?pvZivblfzz7XdnC8ESMbzkbICNyqyWCe5P5/eHdLa6R/94h7hJmR9Z6MzMIq?=
 =?us-ascii?Q?3gYnyGYvDCsrXwdkbpuaHnYNKbssnLuX4AYVB8Bl1dRplUgyjVEw+w3ObH7r?=
 =?us-ascii?Q?d3wzOMkeu0NB+a/VUMXhqperqiIhWdk/H3b/DRBFxks1ohClCPzLOgZg9ExN?=
 =?us-ascii?Q?D9WhaYX0HVkdT5tQPcweBA3PyIQYGxj8QkYVZxuAyYnxfuIATUiXTzgGbhgl?=
 =?us-ascii?Q?bx8pOAM+9Nrn2g/VDWu4Mt5HopQQK2nesW5RhKHTrpHP4kJPRSJPCncFDbbY?=
 =?us-ascii?Q?vI196PCRiGo/9kKeXcBInN9kL70sTgEA3HOp4s9lMeR5fmhr2SX2kNLBFVwM?=
 =?us-ascii?Q?k4GV8iSKscmcQU/yHOToFhf1kfmevxgFfOHkWsE0yA85vntGtW8Q9tFqCbTr?=
 =?us-ascii?Q?+njYlfZ6Ry0D8kSs6MXvaoJ13rdL5eFFAHt4kuM03OfigyzmeyGBo4mJtN0i?=
 =?us-ascii?Q?1pHUAwOf0bG1GuDjr31pu2gP6AXdLFuM6kg6ZxU4qez5ppOPle8BuMYob/yy?=
 =?us-ascii?Q?U9VhzwBrzv6LTWyCeJPlpKZfVBovHHd3uP/+AKAR7ToOWxtHx+8SZNQleePm?=
 =?us-ascii?Q?ckD662Ox4xCtWQPnCGjUAYIAuPjyxoeFbFbG3Hdzwq8WpkQPLzyhAiSvLr3X?=
 =?us-ascii?Q?D6loQgVTNg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f9cf77-5439-4df1-7e8a-08de99316ab6
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 07:51:05.9991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cs7LsRBhwOZHrKKHkzE77RIFmGXBC0rklh01aTQ0ExGbDvDhA2KWF5DM36uJZ0Ve56q0RqJ+EdtzpPoGkIqHvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7463

The AI-generated review reported a potential DMA use-after-free issue
[1]. If netc_xmit_ntmp_cmd() times out and returns an error, the pending
command is not explicitly aborted, while ntmp_free_data_mem()
unconditionally frees the DMA buffer. If the buffer has already been
reallocated elsewhere, this may lead to silent memory corruption. Because
the hardware eventually processes the pending command and perform a DMA
write of the response to the physical address of the freed buffer.

To resolve this issue, this patch does the following modifications:

1. Convert cbdr->ring_lock from a spinlock to a mutex

The lock was originally a spinlock in case NTMP operations might be
invoked from atomic context. After downstream support for all NTMP
tables, no such usage has materialized. A mutex lock is now required
because the driver now needs to reclaim used BDs and release associated
DMA memory within the lock's context, while dma_free_coherent() might
sleep.

2. Introduce software command BD (struct netc_swcbd)

The hardware write-back overwrites the addr and len fields of the BD,
so the driver cannot rely on the hardware BD to free the associated DMA
memory. The driver now maintains a software shadow BD storing the DMA
buffer pointer, DMA address, and size. And netc_xmit_ntmp_cmd() only
reclaims older BDs when the number of used BDs reaches
NETC_CBDR_CLEAN_WORK (16). The software BD enables correct DMA memory
release. With this, struct ntmp_dma_buf and ntmp_free_data_mem() are no
longer needed and are removed.

These changes eliminate the DMA use-after-free condition and ensure safe
and consistent BD reclamation and DMA buffer lifecycle management.

Fixes: 4701073c3deb ("net: enetc: add initial netc-lib driver to support NTMP")
Link: https://lore.kernel.org/netdev/20260403011729.1795413-1-kuba@kernel.org/ # [1]
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 158 ++++++++++--------
 .../ethernet/freescale/enetc/ntmp_private.h   |   8 +-
 include/linux/fsl/ntmp.h                      |   9 +-
 3 files changed, 93 insertions(+), 82 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 1b1ff0446d0a..3efc65443113 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -7,6 +7,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/fsl/netc_global.h>
 #include <linux/iopoll.h>
+#include <linux/vmalloc.h>
 
 #include "ntmp_private.h"
 
@@ -42,6 +43,12 @@ int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 	if (!cbdr->addr_base)
 		return -ENOMEM;
 
+	cbdr->swcbd = vcalloc(cbd_num, sizeof(struct netc_swcbd));
+	if (!cbdr->swcbd) {
+		dma_free_coherent(dev, size, cbdr->addr_base, cbdr->dma_base);
+		return -ENOMEM;
+	}
+
 	cbdr->dma_size = size;
 	cbdr->bd_num = cbd_num;
 	cbdr->regs = *regs;
@@ -52,7 +59,7 @@ int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 	cbdr->addr_base_align = PTR_ALIGN(cbdr->addr_base,
 					  NTMP_BASE_ADDR_ALIGN);
 
-	spin_lock_init(&cbdr->ring_lock);
+	mutex_init(&cbdr->ring_lock);
 
 	cbdr->next_to_use = netc_read(cbdr->regs.pir);
 	cbdr->next_to_clean = netc_read(cbdr->regs.cir) & NETC_CBDRCIR_INDEX;
@@ -71,10 +78,25 @@ int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(ntmp_init_cbdr);
 
+static void ntmp_free_data_mem(struct device *dev, struct netc_swcbd *swcbd)
+{
+	dma_free_coherent(dev, swcbd->size + NTMP_DATA_ADDR_ALIGN,
+			  swcbd->buf, swcbd->dma);
+}
+
 void ntmp_free_cbdr(struct netc_cbdr *cbdr)
 {
 	/* Disable the Control BD Ring */
 	netc_write(cbdr->regs.mr, 0);
+
+	for (int i = 0; i < cbdr->bd_num; i++) {
+		struct netc_swcbd *swcbd = &cbdr->swcbd[i];
+
+		if (swcbd->dma)
+			ntmp_free_data_mem(cbdr->dev, swcbd);
+	}
+
+	vfree(cbdr->swcbd);
 	dma_free_coherent(cbdr->dev, cbdr->dma_size, cbdr->addr_base,
 			  cbdr->dma_base);
 	memset(cbdr, 0, sizeof(*cbdr));
@@ -94,24 +116,28 @@ static union netc_cbd *ntmp_get_cbd(struct netc_cbdr *cbdr, int index)
 
 static void ntmp_clean_cbdr(struct netc_cbdr *cbdr)
 {
-	union netc_cbd *cbd;
-	int i;
+	int i = cbdr->next_to_clean;
 
-	i = cbdr->next_to_clean;
 	while ((netc_read(cbdr->regs.cir) & NETC_CBDRCIR_INDEX) != i) {
-		cbd = ntmp_get_cbd(cbdr, i);
+		union netc_cbd *cbd = ntmp_get_cbd(cbdr, i);
+		struct netc_swcbd *swcbd = &cbdr->swcbd[i];
+
+		ntmp_free_data_mem(cbdr->dev, swcbd);
+		memset(swcbd, 0, sizeof(*swcbd));
 		memset(cbd, 0, sizeof(*cbd));
 		i = (i + 1) % cbdr->bd_num;
 	}
 
+	dma_wmb();
 	cbdr->next_to_clean = i;
 }
 
-static int netc_xmit_ntmp_cmd(struct ntmp_user *user, union netc_cbd *cbd)
+static int netc_xmit_ntmp_cmd(struct ntmp_user *user, union netc_cbd *cbd,
+			      struct netc_swcbd *swcbd)
 {
 	union netc_cbd *cur_cbd;
 	struct netc_cbdr *cbdr;
-	int i, err;
+	int i, err, used_bds;
 	u16 status;
 	u32 val;
 
@@ -120,14 +146,21 @@ static int netc_xmit_ntmp_cmd(struct ntmp_user *user, union netc_cbd *cbd)
 	 */
 	cbdr = &user->ring[0];
 
-	spin_lock_bh(&cbdr->ring_lock);
+	mutex_lock(&cbdr->ring_lock);
 
-	if (unlikely(!ntmp_get_free_cbd_num(cbdr)))
+	used_bds = cbdr->bd_num - ntmp_get_free_cbd_num(cbdr);
+	if (unlikely(used_bds >= NETC_CBDR_CLEAN_WORK)) {
 		ntmp_clean_cbdr(cbdr);
+		if (unlikely(!ntmp_get_free_cbd_num(cbdr))) {
+			err = -EBUSY;
+			goto cbdr_unlock;
+		}
+	}
 
 	i = cbdr->next_to_use;
 	cur_cbd = ntmp_get_cbd(cbdr, i);
 	*cur_cbd = *cbd;
+	cbdr->swcbd[i] = *swcbd;
 	dma_wmb();
 
 	/* Update producer index of both software and hardware */
@@ -135,10 +168,9 @@ static int netc_xmit_ntmp_cmd(struct ntmp_user *user, union netc_cbd *cbd)
 	cbdr->next_to_use = i;
 	netc_write(cbdr->regs.pir, i);
 
-	err = read_poll_timeout_atomic(netc_read, val,
-				       (val & NETC_CBDRCIR_INDEX) == i,
-				       NETC_CBDR_DELAY_US, NETC_CBDR_TIMEOUT,
-				       true, cbdr->regs.cir);
+	err = read_poll_timeout(netc_read, val, (val & NETC_CBDRCIR_INDEX) == i,
+				NETC_CBDR_DELAY_US, NETC_CBDR_TIMEOUT,
+				true, cbdr->regs.cir);
 	if (unlikely(err))
 		goto cbdr_unlock;
 
@@ -155,36 +187,28 @@ static int netc_xmit_ntmp_cmd(struct ntmp_user *user, union netc_cbd *cbd)
 		dev_err(user->dev, "Command BD error: 0x%04x\n", status);
 	}
 
-	ntmp_clean_cbdr(cbdr);
-	dma_wmb();
-
 cbdr_unlock:
-	spin_unlock_bh(&cbdr->ring_lock);
+	mutex_unlock(&cbdr->ring_lock);
 
 	return err;
 }
 
-static int ntmp_alloc_data_mem(struct ntmp_dma_buf *data, void **buf_align)
+static int ntmp_alloc_data_mem(struct device *dev, struct netc_swcbd *swcbd,
+			       void **buf_align)
 {
 	void *buf;
 
-	buf = dma_alloc_coherent(data->dev, data->size + NTMP_DATA_ADDR_ALIGN,
-				 &data->dma, GFP_KERNEL);
+	buf = dma_alloc_coherent(dev, swcbd->size + NTMP_DATA_ADDR_ALIGN,
+				 &swcbd->dma, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	data->buf = buf;
+	swcbd->buf = buf;
 	*buf_align = PTR_ALIGN(buf, NTMP_DATA_ADDR_ALIGN);
 
 	return 0;
 }
 
-static void ntmp_free_data_mem(struct ntmp_dma_buf *data)
-{
-	dma_free_coherent(data->dev, data->size + NTMP_DATA_ADDR_ALIGN,
-			  data->buf, data->dma);
-}
-
 static void ntmp_fill_request_hdr(union netc_cbd *cbd, dma_addr_t dma,
 				  int len, int table_id, int cmd,
 				  int access_method)
@@ -235,37 +259,36 @@ static int ntmp_delete_entry_by_id(struct ntmp_user *user, int tbl_id,
 				   u8 tbl_ver, u32 entry_id, u32 req_len,
 				   u32 resp_len)
 {
-	struct ntmp_dma_buf data = {
-		.dev = user->dev,
+	struct netc_swcbd swcbd = {
 		.size = max(req_len, resp_len),
 	};
 	struct ntmp_req_by_eid *req;
 	union netc_cbd cbd;
 	int err;
 
-	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
 	if (err)
 		return err;
 
 	ntmp_fill_crd_eid(req, tbl_ver, 0, 0, entry_id);
-	ntmp_fill_request_hdr(&cbd, data.dma, NTMP_LEN(req_len, resp_len),
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, NTMP_LEN(req_len, resp_len),
 			      tbl_id, NTMP_CMD_DELETE, NTMP_AM_ENTRY_ID);
 
-	err = netc_xmit_ntmp_cmd(user, &cbd);
+	err = netc_xmit_ntmp_cmd(user, &cbd, &swcbd);
 	if (err)
 		dev_err(user->dev,
 			"Failed to delete entry 0x%x of %s, err: %pe",
 			entry_id, ntmp_table_name(tbl_id), ERR_PTR(err));
 
-	ntmp_free_data_mem(&data);
-
 	return err;
 }
 
 static int ntmp_query_entry_by_id(struct ntmp_user *user, int tbl_id,
-				  u32 len, struct ntmp_req_by_eid *req,
-				  dma_addr_t dma, bool compare_eid)
+				  struct ntmp_req_by_eid *req,
+				  struct netc_swcbd *swcbd,
+				  bool compare_eid)
 {
+	u32 len = NTMP_LEN(sizeof(*req), swcbd->size);
 	struct ntmp_cmn_resp_query *resp;
 	int cmd = NTMP_CMD_QUERY;
 	union netc_cbd cbd;
@@ -277,8 +300,9 @@ static int ntmp_query_entry_by_id(struct ntmp_user *user, int tbl_id,
 		cmd = NTMP_CMD_QU;
 
 	/* Request header */
-	ntmp_fill_request_hdr(&cbd, dma, len, tbl_id, cmd, NTMP_AM_ENTRY_ID);
-	err = netc_xmit_ntmp_cmd(user, &cbd);
+	ntmp_fill_request_hdr(&cbd, swcbd->dma, len, tbl_id, cmd,
+			      NTMP_AM_ENTRY_ID);
+	err = netc_xmit_ntmp_cmd(user, &cbd, swcbd);
 	if (err) {
 		dev_err(user->dev,
 			"Failed to query entry 0x%x of %s, err: %pe\n",
@@ -306,15 +330,14 @@ static int ntmp_query_entry_by_id(struct ntmp_user *user, int tbl_id,
 int ntmp_maft_add_entry(struct ntmp_user *user, u32 entry_id,
 			struct maft_entry_data *maft)
 {
-	struct ntmp_dma_buf data = {
-		.dev = user->dev,
+	struct netc_swcbd swcbd = {
 		.size = sizeof(struct maft_req_add),
 	};
 	struct maft_req_add *req;
 	union netc_cbd cbd;
 	int err;
 
-	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
 	if (err)
 		return err;
 
@@ -323,15 +346,13 @@ int ntmp_maft_add_entry(struct ntmp_user *user, u32 entry_id,
 	req->keye = maft->keye;
 	req->cfge = maft->cfge;
 
-	ntmp_fill_request_hdr(&cbd, data.dma, NTMP_LEN(data.size, 0),
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, NTMP_LEN(swcbd.size, 0),
 			      NTMP_MAFT_ID, NTMP_CMD_ADD, NTMP_AM_ENTRY_ID);
-	err = netc_xmit_ntmp_cmd(user, &cbd);
+	err = netc_xmit_ntmp_cmd(user, &cbd, &swcbd);
 	if (err)
 		dev_err(user->dev, "Failed to add MAFT entry 0x%x, err: %pe\n",
 			entry_id, ERR_PTR(err));
 
-	ntmp_free_data_mem(&data);
-
 	return err;
 }
 EXPORT_SYMBOL_GPL(ntmp_maft_add_entry);
@@ -339,33 +360,27 @@ EXPORT_SYMBOL_GPL(ntmp_maft_add_entry);
 int ntmp_maft_query_entry(struct ntmp_user *user, u32 entry_id,
 			  struct maft_entry_data *maft)
 {
-	struct ntmp_dma_buf data = {
-		.dev = user->dev,
+	struct netc_swcbd swcbd = {
 		.size = sizeof(struct maft_resp_query),
 	};
 	struct maft_resp_query *resp;
 	struct ntmp_req_by_eid *req;
 	int err;
 
-	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
 	if (err)
 		return err;
 
 	ntmp_fill_crd_eid(req, user->tbl.maft_ver, 0, 0, entry_id);
-	err = ntmp_query_entry_by_id(user, NTMP_MAFT_ID,
-				     NTMP_LEN(sizeof(*req), data.size),
-				     req, data.dma, true);
+	err = ntmp_query_entry_by_id(user, NTMP_MAFT_ID, req, &swcbd, true);
 	if (err)
-		goto end;
+		return err;
 
 	resp = (struct maft_resp_query *)req;
 	maft->keye = resp->keye;
 	maft->cfge = resp->cfge;
 
-end:
-	ntmp_free_data_mem(&data);
-
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(ntmp_maft_query_entry);
 
@@ -379,8 +394,8 @@ EXPORT_SYMBOL_GPL(ntmp_maft_delete_entry);
 int ntmp_rsst_update_entry(struct ntmp_user *user, const u32 *table,
 			   int count)
 {
-	struct ntmp_dma_buf data = {.dev = user->dev};
 	struct rsst_req_update *req;
+	struct netc_swcbd swcbd;
 	union netc_cbd cbd;
 	int err, i;
 
@@ -388,8 +403,8 @@ int ntmp_rsst_update_entry(struct ntmp_user *user, const u32 *table,
 		/* HW only takes in a full 64 entry table */
 		return -EINVAL;
 
-	data.size = struct_size(req, groups, count);
-	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	swcbd.size = struct_size(req, groups, count);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
 	if (err)
 		return err;
 
@@ -399,24 +414,22 @@ int ntmp_rsst_update_entry(struct ntmp_user *user, const u32 *table,
 	for (i = 0; i < count; i++)
 		req->groups[i] = (u8)(table[i]);
 
-	ntmp_fill_request_hdr(&cbd, data.dma, NTMP_LEN(data.size, 0),
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, NTMP_LEN(swcbd.size, 0),
 			      NTMP_RSST_ID, NTMP_CMD_UPDATE, NTMP_AM_ENTRY_ID);
 
-	err = netc_xmit_ntmp_cmd(user, &cbd);
+	err = netc_xmit_ntmp_cmd(user, &cbd, &swcbd);
 	if (err)
 		dev_err(user->dev, "Failed to update RSST entry, err: %pe\n",
 			ERR_PTR(err));
 
-	ntmp_free_data_mem(&data);
-
 	return err;
 }
 EXPORT_SYMBOL_GPL(ntmp_rsst_update_entry);
 
 int ntmp_rsst_query_entry(struct ntmp_user *user, u32 *table, int count)
 {
-	struct ntmp_dma_buf data = {.dev = user->dev};
 	struct ntmp_req_by_eid *req;
+	struct netc_swcbd swcbd;
 	union netc_cbd cbd;
 	int err, i;
 	u8 *group;
@@ -425,21 +438,21 @@ int ntmp_rsst_query_entry(struct ntmp_user *user, u32 *table, int count)
 		/* HW only takes in a full 64 entry table */
 		return -EINVAL;
 
-	data.size = NTMP_ENTRY_ID_SIZE + RSST_STSE_DATA_SIZE(count) +
-		    RSST_CFGE_DATA_SIZE(count);
-	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	swcbd.size = NTMP_ENTRY_ID_SIZE + RSST_STSE_DATA_SIZE(count) +
+		     RSST_CFGE_DATA_SIZE(count);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
 	if (err)
 		return err;
 
 	/* Set the request data buffer */
 	ntmp_fill_crd_eid(req, user->tbl.rsst_ver, 0, 0, 0);
-	ntmp_fill_request_hdr(&cbd, data.dma, NTMP_LEN(sizeof(*req), data.size),
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, NTMP_LEN(sizeof(*req), swcbd.size),
 			      NTMP_RSST_ID, NTMP_CMD_QUERY, NTMP_AM_ENTRY_ID);
-	err = netc_xmit_ntmp_cmd(user, &cbd);
+	err = netc_xmit_ntmp_cmd(user, &cbd, &swcbd);
 	if (err) {
 		dev_err(user->dev, "Failed to query RSST entry, err: %pe\n",
 			ERR_PTR(err));
-		goto end;
+		return err;
 	}
 
 	group = (u8 *)req;
@@ -447,10 +460,7 @@ int ntmp_rsst_query_entry(struct ntmp_user *user, u32 *table, int count)
 	for (i = 0; i < count; i++)
 		table[i] = group[i];
 
-end:
-	ntmp_free_data_mem(&data);
-
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(ntmp_rsst_query_entry);
 
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 7a53db8740db..5ae6f8b92700 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -13,6 +13,7 @@
 #define NTMP_EID_REQ_LEN	8
 #define NETC_CBDR_BD_NUM	256
 #define NETC_CBDRCIR_INDEX	GENMASK(9, 0)
+#define NETC_CBDR_CLEAN_WORK	16
 
 union netc_cbd {
 	struct {
@@ -55,13 +56,6 @@ union netc_cbd {
 	} resp_hdr; /* NTMP Response Message Header Format */
 };
 
-struct ntmp_dma_buf {
-	struct device *dev;
-	size_t size;
-	void *buf;
-	dma_addr_t dma;
-};
-
 struct ntmp_cmn_req_data {
 	__le16 update_act;
 	u8 dbg_opt;
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 916dc4fe7de3..83a449b4d6ec 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -31,6 +31,12 @@ struct netc_tbl_vers {
 	u8 rsst_ver;
 };
 
+struct netc_swcbd {
+	void *buf;
+	dma_addr_t dma;
+	size_t size;
+};
+
 struct netc_cbdr {
 	struct device *dev;
 	struct netc_cbdr_regs regs;
@@ -44,9 +50,10 @@ struct netc_cbdr {
 	void *addr_base_align;
 	dma_addr_t dma_base;
 	dma_addr_t dma_base_align;
+	struct netc_swcbd *swcbd;
 
 	/* Serialize the order of command BD ring */
-	spinlock_t ring_lock;
+	struct mutex ring_lock;
 };
 
 struct ntmp_user {
-- 
2.34.1



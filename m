Return-Path: <linuxppc-dev+bounces-23682-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66B3C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 08:47:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvZbj6vzYz2xm3;
	Tue, 07 Jul 2026 18:47:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783414033;
	cv=pass; b=LEfmagRw8gPqEmckLvFPJEYHXzW/MJ6fn6wQpIzZkqWxp3A0YhKxd45pMK61BPyZnR5d1xrhD2GE7bflrUq33AK52IGS9Ab5nltq2qY9BQ72/KDJM53LUOX7DzkkBZnpj20+dkM9IkqCFcMHfxuccM5FH8JFRUGsTPaqM5wsVh7hn8U2mdC5PTRKBiLSgywovZyrKQtcCeHr7vwjOdEG9N5hAdXeHKAc6enN86cIQm/trODWSGbwG+GIbA1D9er5lJVZ70dSNKXsRzL+epTeLR0i3tIVPHeZ2kYviNBdvjjz5rxw8HYcAAsGCgCmJwAIza2VyKcVMqk9pRYN6VWtEw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783414033; c=relaxed/relaxed;
	bh=VgPnzfXMfKg4CJENz6fu8LczSELELf1lTHmWEHwhssw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bLCP9yQVCcUUPnhHfJ8CsPtjh84TV0+s5ST3q2zaNFksXcvSnvRLabvlN8e07tz3NhODq7sHsWyENqXYBpJHy3bqIyQBYlSEh5uz2CSRPdoBK1d8yVZeWgT5CpY4Kqk8T8gbQjxUUDs6FqYByKk1axMvb0vHt/TErR0xo+FdeHlxSpJXygM0Vgs34MC6g1xR8y4+dnKZTq8GYZT2beguKzZ/V7KNoHQ7m2H1PEUmKElXZft+39l5tr6Cx+ssqfcVib1ds+oUWGefVC2E9yyz+sWY5I1G+9lJAmaaEOpE+cQsCpxoE8xZgOUYr89BEOejNukAJ1woMTeCV3p69hFL8A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gMSRLXcs; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gMSRLXcs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvZbh0mnWz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 18:47:11 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJac1pqNnqhJ34oyd7oX5H+x72P/d/65+D4PWv7DZe4W7d2xbMr1FEUqbg1clATxQnTchsDLwzkygzX/FMAhgaJqZPhAPdxuFof6Gp2I+I9GgFY9ZW5Qi5UQaIKN0r8kyasp+vq84TnuRQiJs/n+m6jLfCl/KGwqKFxh1ecouXOlTmntBcG1lC5i3tx49f/GgjUSEhPRqO0nDdZbIvEzIHqIQeXifXNR9WtzIqcNSe4vRX6sDlNUO570gDBGDu9OGpC/HiCMK/23Ws7eF/U+emijpe5aqRVmEFg19jShVvf/ffLT/kTijlo/lNfEKjEWHHQq37jVX9Zt3lVBnoR4+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgPnzfXMfKg4CJENz6fu8LczSELELf1lTHmWEHwhssw=;
 b=p5Ac9OBvMFcu66ObPykaYKatOObHakI7rWUdEwXVK1FO5ZMwodLxMcFVjzss85iyrcywn8jehaUaS/abX3K7H4L5HCuWcy5XP8sbSxdvPt5LHDwmYuW/5PNL6GwOJS2/A94daHJVRh+iQPBnCHDxpNDMX6DYI+kHJY+jXNjpBJF7p8/k/jiyFSirjgDqQGAD8St2j0QvVU1WptrZW1bjvNJWBOKyy8r7y96X4s7ZnqQsRpkZZ/DS9rZkuTw+oXAzkmqf/CbThubgMBM0S73lPJRb8SiAhpLbwEEea0tFRy9gwRwr9pnyUQjabgluTPEPSE1LzqOEXSbd8AWL2SXC7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgPnzfXMfKg4CJENz6fu8LczSELELf1lTHmWEHwhssw=;
 b=gMSRLXcs6fbuEBDPTRr0EDubFqkV8S1UkJxjD2zqE74JD6aDHfybnxKXRNyMlmRFMLFxcVH2y1fg30xBjpZN0BgtMVaRRAN94QwoA3v1HqDIgtkUhcWWFXlCxMo/IyouERPd94gnJSdWyUeXZepL/eqLB9XlTBWWUZrN3En+3ovyYHKXjRBuF5m/WzcVm5bFKovDjTuGcvZARxZxkwgmw9xWUID0LEAGyySLf6mPhmGxD1OSqbSk5LLPM2RJFu5ptI68i6wOURsfmHBXmLyZKxI/4j/VQNUxyrAIxVzmQ8ZvgV9CB4K6os+bgyRCoZ0MBqDoz96F+m8uQHOvx0jBow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:46:45 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:46:45 +0000
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
Subject: [PATCH v4 net-next 00/14] net: enetc: cleanups and improvements
Date: Tue,  7 Jul 2026 16:18:20 +0800
Message-Id: <20260707081834.710730-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0204.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::16) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 45d2ded5-5cc5-4792-d6e7-08dedc044657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|19092799006|56012099006|6133799003|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	ezb7ZCQN8mm7gY54HrozLnnqpv7Rj/lraoBXjXh9owygq1P8Jl1B5kXqa8peaa8cXyWueSj4AyBEmlqPPcJL32IlHCqeyv2YWAemHruVu4/VA6rkRNEDP02ijdGxWDja2B7fDoDYAXBpvCYoKkleYTfjN66ROOqiT6V92i9Tq82Vt+jLMVpPzwMXZ+8WPubWj6yof9THue4VxLMFgSf/1FAsLX4zFY4QxSzeN8ob1xj5gB4gPaIGEYc6xVBAfkHf/PFeDokM1ZIC6tK2chy+WIg8dXMxNBoKx4oMUxbPXUUpi7JjkGF67tbAL36N+NEKKTltGTkCGqS8txqUqTIb8d088hTJml92k71bgx1s0LT0BJ8Ps+eHdHBQK2VuTOU7HZ0ZVJ6nUCfd2VLqcEl3lDABU2I2HlzC2/5I6XDQUjUgxrJdgfzBZGkSOe46iOJCQR8xv1Ung+/siBnWVVpkv5mPsQnRi5YUlxi03kP668iFpf827q/yfuzo6Qrvmw7bQtSd6QrkGD41tafXxTcnXc+HpQKpk4Krt5GgprGJ822SxxCVD385WJ7jF3zI1MHm88ASlHW4m8sbZ5IDA0VUTXN2ig/5D5edBQllQZaxsL4vOiMdQzPi0uSSQi+w+A79HHbEIA5mEdC6luRrPww3QA9hyvOECKnMAw4J6n1wzScrIO5metQaPL0sB1ozLW4v6K7vtIal5SnnK1czC09cTQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(19092799006)(56012099006)(6133799003)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lJNOUuUAc2qg7gdolJJ+N08fxPlADZxnOgpdVr031f/pEe/8rO+5mxB7D48N?=
 =?us-ascii?Q?FqqAVTrkvmDZOpln8aXiL2zaXXOhog2jYg7hcMHlU1qRf+ivceVAfJGsC3/I?=
 =?us-ascii?Q?xKSXGmXIZDBH3f9RBmVFODVzi+YHFckAgl2YnV8bVEsZi4kofqvx1FFvVwl0?=
 =?us-ascii?Q?kemDdx8s17qgBhQtdzVwlWdpb1wABw0mjeVmK6/C1z/eou4s2leSC/xfeJMp?=
 =?us-ascii?Q?WZkaF10uE8vUOp0i09oCpBlqRXSmO3T1Y3BY1luJUZwLDWL7yokbiVgWz4nR?=
 =?us-ascii?Q?z9Ocz9w/LSWiV9Rjb3hdfAIS5WLMlWz5rJ7UvlFPBIxXnU0FA0DStTsJRt0k?=
 =?us-ascii?Q?DOMiIJsky6ygWuNyPsiR8lQBf0/gSoTh2oZfBjZsq+N2F9vwppVLwzjT/vRI?=
 =?us-ascii?Q?wmT6RiM9Aq4BaeS8l+9nw4PNoyFVxXR5PBXHhtDbNLhiZvksta3UENpiItnG?=
 =?us-ascii?Q?XUBCAG5H5DQjnKQI7mwfDF+o5iB70Gy1ob8W9HKrgtJD2tXN8KAaw/aUss2D?=
 =?us-ascii?Q?HmCevKphScXANszESqLWxj2dDLTCOQOVRiDgV4gyqMTHjlOTlbEkbW4q9hDf?=
 =?us-ascii?Q?G/EctVf0H/39EkflOgLv4EvYYV3v/jHhlCwN3LxBICIWmD66MgXQrWAAdVRD?=
 =?us-ascii?Q?6iWTx3XK3iNKogpro8aQkQC230ZUT0+3rJg/TENf6Ays9PwBzUsuM3oKYrPu?=
 =?us-ascii?Q?BLsEA+B3ZLzy8EG2ke5ek7v7/mslPGhV42zwfOihQsyKtMLfWeYDehEDByT2?=
 =?us-ascii?Q?2Ugj5nHdTdfmipk2OkjP1ZSWAoFcxqRS5x2aiEa/Ln7xRcvq603pG9X/egPo?=
 =?us-ascii?Q?UyRQR7ED+q1ee/VZjM5X5M2ZBCm5K4ZOkphlyMEfMx7eEy78pnZ7Vzh7DBvc?=
 =?us-ascii?Q?59rPcjpeKJMKquJinp42h6da2qYWEW0e/7VfvCmY8YaPqdixewm6OAjkE1Qb?=
 =?us-ascii?Q?qXikEA3c6ela0iRsWhYFvK8CQ6dO/OIHlAau80NTHw9uN+bSoCXjOy5vGt6O?=
 =?us-ascii?Q?prSCf4rO4COh9bsRX9Sc9TxeO7sNn1yzAZmE+nobNthuQBgm2LcJQkc2Xh20?=
 =?us-ascii?Q?7P+yqJHMbvlXHMuHKH7SmzdNyQqP2geN4JZnYGAUkku8QLl+nPB4aNEimKUr?=
 =?us-ascii?Q?JNG3IG3DmviHbVlD0PD+xmRpEv23wVmyRxoEr9FL5xh+6pGX08lvHLFAhhKf?=
 =?us-ascii?Q?9QoNQbleHzewh6IpnX+7mWGEMVMW/vtGqgDCrYU9si/1uqKoa8j/R85WapHJ?=
 =?us-ascii?Q?Hz3gTkp/JgWsO14HAR9iwTBcbK8IMS4jc0HXPGVBYGU0IJnCbENbXgQay228?=
 =?us-ascii?Q?JwVmxzyhmVkp4pGj4Y6Nq9kNzpdDKQaeZZq4xvIT7FkqpjpGbgJ7O+GHEtlH?=
 =?us-ascii?Q?UHvmFeL8j11IHmoNXhQ5Vz16Za0U+F8iwd6jy/GMm6eJbLqHmPrmzco33MAh?=
 =?us-ascii?Q?1KkNIyGhIuw23zMfzAopJ8GORNOfDlzHSbNe4qSCffvnMd2KTOch8WWdl4O/?=
 =?us-ascii?Q?AaEeoM2RI36e+mg+zPSw4Pa9zyCQIzeRUJPHA+zTI2cckbh/8K8yLXZ4a6Ov?=
 =?us-ascii?Q?kr98e9PLUGbzh0CYUV93EC7RxDbLSaHkYyGkYhWFlvNP3gLZZnAqTd8vvBqR?=
 =?us-ascii?Q?s4vg4wrpz510YXZIZ2LbOaUzC/IBPjJkfT0nXUHr4a+KABoslMma4h/MP/3I?=
 =?us-ascii?Q?DPPLPBzORcukLXZ/NJvuFDkSadBF3prtMeRUr9NGwYgZQ+LH281Wpw24+N5r?=
 =?us-ascii?Q?Qaf3dcRcXvyCGgPoE9mHPqH2B9L1xGXiq4czTH4aYZv8MKUtstFt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d2ded5-5cc5-4792-d6e7-08dedc044657
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:46:45.4544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2DuEGJf+liqkbcieDvqsn9vqQ3/+6MVuImymsG2sfepajDrTwjNxsq9JBRVtfTUtH+7/eVWsisDtJ3bQHlkUF9ANrftbrKqhQfpA30TU7pIl1Y9VEKtjT94wgvGsylE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182

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

---
v4:
1. Improve enetc4_set_si_msix_num()
2. Update commit messages
v3 link: https://lore.kernel.org/imx/20260703101328.550714-1-wei.fang@oss.nxp.com/
v2 link: https://lore.kernel.org/imx/20260702025714.456233-1-wei.fang@oss.nxp.com/
v1 link: https://lore.kernel.org/imx/20260630072036.382761-1-wei.fang@oss.nxp.com/
---

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
  net: enetc: open-code enetc4_set_default_si_vlan_promisc()
  net: enetc: refactor SI VLAN promiscuous mode configuration
  net: enetc: move enetc_set_si_vlan_promisc() to enetc_pf_common.c
  net: enetc: remove redundant num_vsi field from enetc_port_caps
  net: enetc: use alloc_etherdev_mqs() to create netdev for VF driver
  net: enetc: use kzalloc_flex() for enetc_psfp_gate allocation

 drivers/net/ethernet/freescale/enetc/enetc.h  |   4 +-
 .../ethernet/freescale/enetc/enetc4_debugfs.c |  42 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |   6 +-
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 471 ++++++++----------
 .../ethernet/freescale/enetc/enetc_ethtool.c  |   2 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  12 +-
 .../net/ethernet/freescale/enetc/enetc_pf.c   |  94 +---
 .../net/ethernet/freescale/enetc/enetc_pf.h   |   6 -
 .../freescale/enetc/enetc_pf_common.c         | 150 +++++-
 .../freescale/enetc/enetc_pf_common.h         |   5 +
 .../net/ethernet/freescale/enetc/enetc_qos.c  |   4 +-
 .../net/ethernet/freescale/enetc/enetc_vf.c   |   9 +-
 include/linux/fsl/ntmp.h                      |   2 +
 13 files changed, 411 insertions(+), 396 deletions(-)

-- 
2.34.1



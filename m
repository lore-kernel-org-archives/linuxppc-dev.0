Return-Path: <linuxppc-dev+bounces-23354-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E69C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 03:27:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grMkH4TBlz305P;
	Thu, 02 Jul 2026 13:26:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782962807;
	cv=pass; b=dzftmTlQ+aMzivXqY9/ReYFr5HuhXo8tasxVRRxg8PN7OS6STlJQtmyQwX7LZbDUIJbQqGH0qpOFn3dWQIuujJiU/6RecAjum7Jiqb8ZBVGDC04i5m+KOtM+G40gysM2nimclNBhyqfCXlfAlE8+oJNGBDbUmMYeYUUBj1eWDIX1xl6CzLRARcvvt/ihAPLvUCOdgWu0PYQqd818gZ0nm9McFkpUwuOof9iOdyUQKatUdJcVS63k/VJmrHryBiCiGRI+6JTQj+LGhQjijGtjdZuHqc/Hzm95SpnTodF7Ue2ry4RVzBCc3OPgLyZ3IrBcPbHydtomdowy3mczm6JO8g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782962807; c=relaxed/relaxed;
	bh=L/++opfkmp2G/XemzUYCyBRwqhc/X8zD/Edk6tc57Ns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XxxJWwgoWoTt3/OHU6OU/hv6wjsBTqSxoh6kq6AD/vxMy0Xk7ggqzIoU9kQrnNVwjcRxPUNZXPtNyC5AFaE8nQV3lS4i/HJIlBar1m6onOwleKLJ2cStTC0hrBxv+BFLrF+NweR2uRULaM6U6H0Gbq9cWJJ8mhi3OYMqV0vKoojp0gQ/yUGOyTUGTY9276zeGTEBsedvldOZYA5U9oBFC9/+jo3VgBL2nS6zEgyj3QP8hmI8IxONf5wCmnaiHeCjNNSboVqrzVsw9ZFww9tjhs0Xf7r/EBvs8IEYbHzsAKS7Zwf8OM6V3tAjKRjz/3Q/7/Sot+XHroIULGF+JAVGZg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DAUOUzJQ; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DAUOUzJQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grMkG1prsz30D3
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 13:26:46 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNjxg+i3L81tSiuUf5SsoNNfDGNHIkgZna+SnkTowNtnn2wKEjJoYhWBtPflSjDG3X5piVQinAjaFDNVVYf4bwYLApXVfZqsZpZYy6xNGe0IA+AS2r6LBOQSgvS/oea1SppPe4Mu6z27FqlUY9G6+aJ9ryi8xSGJssvMnVoIa4zJqepBel7MI+ht8AKNe7gklxvXM12jhoBRZAj/7NSCoMw4gIpZo777V8GcWbBTz3ycO/c1EsDlFG8P4VxH7fPvlXSgaQc5sqeGr++4COfWZLtaPXC4s1kWjKyPuMcCbFVZ2Et26mPtg2994w1rgEhKLN7lVXUpD0DoAA8vqAjP7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/++opfkmp2G/XemzUYCyBRwqhc/X8zD/Edk6tc57Ns=;
 b=dsfMhstD401Jj5uzWE0BqzQSoVNRrjoPtJUzGYSFVol0Mmqj1t7DvKxE+/6Yn997GGeYvImGaWFFcPg+5x1AEK3WoEdA1C4L1wGP45pioMyuxeAdyRS4s/4CTahIeFy/gLQNgEdx0xZNAmekHL46WhoWI1kmSPrxdQuAQ3fWPqglgKo/DMCh2Cyi8f7TWveE811y9RMIHoq4eqR2RhvH7dtLaVjJvKdwLcTcy6Qk7Ji7fnu1GUgHH9kACOYFFHcw2DrGlVwSkt0KIULyeBLvlMXx729p9G/lzKBQTAdyzCHc7NdvAy3F5kBTYV8gq1dY/LA8tpLE/h3oB3lFL77fFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/++opfkmp2G/XemzUYCyBRwqhc/X8zD/Edk6tc57Ns=;
 b=DAUOUzJQiEu5tmiKGgcJ5e+TcxKyI72CcPW4670xkRAmgszah8Or8A1Hk3WV+zRobH8a37ngz+WMhAaQRXJwxDK4rziWvz00bEPNrJuhycQNzLq36J/gyTb7pop2aTe9GFRI7odKEqMKnQelTt12ZO60rvN3ENo7ZxzkaCQJfCsj4NV3nSrUQ1l1wFnWh682/IN+Hn1fzmCxc0f2nC+qG1AGhP0EAr/tpMcW8agJU0moxCSdBYqUpB50Gobx5Shq1/xVDLMIsQxUSf6QcMCLvb7+2Y/j9PuZlFa2oSSaa4xKvq4HbYkPbXw9tC6a/QOi2RkrRIwKrgjxA+ljlFDgZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GVXPR04MB10248.eurprd04.prod.outlook.com (2603:10a6:150:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 03:26:38 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 03:26:38 +0000
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
Subject: [PATCH v2 net-next 12/14] net: enetc: remove redundant num_vsi field from enetc_port_caps
Date: Thu,  2 Jul 2026 10:57:12 +0800
Message-Id: <20260702025714.456233-13-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702025714.456233-1-wei.fang@oss.nxp.com>
References: <20260702025714.456233-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0145.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::15) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 646d8b05-8d83-4ffa-f059-08ded7e9b9c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|921020|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JqDd84PDeGN3/7Qe0g7RDY1uoT4z7In2rdBVqah6MK46xa5irnHCSvoMsPF7nM3/vP0CRT0IaXV/YygA8Al35M6WumSM0HdULGW8xBUHMLRRDueuzvmtLhDUWrq5FVMjW/oRt36MY/bkOF/3CjL+p2hlZ+KDtLTnK6T7KDlxA8gAH20ac5i3PEG6ImJJG+IxpmTMtkyfnbQAYW0tiWi/DNnh3vEwxj1q+US0juMfAaiCGbrDbP/844Xin52VnwpKsv9JLO0MDPZyPj4EySIKPSCUZzfKa0KzOZcYJKbDNJBipvXO4jfumOD/miViYyVP8Rk8iFOpnye+uC7h4bbq0AVXbxS6cSNl5xUi1SIK2vm8ajQq+skpSIpvtmCwbeqkIr+wUVevGxp4f61TMGMlPtQzk/2C4zxXXHIfQrhlC31w9iAcpi7v+IQ7s0cqifwnhUQhLu32wEbnICzOcBy1XGpqLn2VACGbsA8BnUfs+lxdhqs3MsB1N5CCMJk5I9g/mTDMhqnZm/mSRWgfGH+IRW1O051oFgCJwpHngpuL6tW1JM5ShBfSPvPqsjP9ND9+Y0aNO4kG8ydyZzmXoz6eJCAj/PsCrtB4p4mcbpR4EQrlGi+INT7PFxUtbm+s6+jxQlgCwnc3DYRmejS5dqgCkYxA9G4KlAs+X7vIKl2Xc5UObHPTKQQaq09Jb/gCKFFJc1HMbOGDRfRV4k64AXgmQQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L5oQbzJa2hHM8Y2oGHsedAr7ko1usMD9l9vP76OfPmGZGzkmrZVr5CVCIjGr?=
 =?us-ascii?Q?0hFCTpiZ3bVsoz3OUY+jGUbEF/2xoU/WkBV731D72nAc3q7Brj9HWiL9e7Oe?=
 =?us-ascii?Q?bIS/aF8ubie0QhUiSKu/1B/efEo1OF9em7enNY0cqBt5IaunsTT4/xLz8ppC?=
 =?us-ascii?Q?5Tl476VYvxypCuBuP0Er+kRY9nMNxJVvyNgMFNuB7xm4JulO28Xeryu1L1gi?=
 =?us-ascii?Q?GOoGzdkdd43vuyW5VSYeVLhsdi8VCbdHkZut5CKaURQ3coi4EH/4UMxLxF8Q?=
 =?us-ascii?Q?+2G6WDfkFMKcJMPPwr2maELB/3XFEUauxWxwhtVHx1AeIrMO6Rj1+2HHD3yd?=
 =?us-ascii?Q?e82v9TffWySbhhGKd4yKXcN3ss4VzWU0tDqhEncM6mDaiLGkEGyjVsIRSBLj?=
 =?us-ascii?Q?mLG9UX0fQK6t5pJouI/1/dtCwdpYBE+z3uBDf6xxQvD7KBxjmuW/wbLIS+xj?=
 =?us-ascii?Q?9jLzOhOxxvBbg6DhjHA7dl4hhTYWZR7viK2mUKWLrv2LnRrWPQenWvHvhgpO?=
 =?us-ascii?Q?JIcqbPhMOF9Ay5aZJnotzZfZbx9rAowksuH9MOzPvDPNX6qdpkWHwJ9By/4h?=
 =?us-ascii?Q?2pNsSfWFy8dTTAmJqMtjkGKoPu6mjv5WDCqFVBG2elii2P4CTI7ZsFwyUxeU?=
 =?us-ascii?Q?tBAZ2RT7tEz/R8BTLAT3Bf721JX1rwYOtvrzFD2oBCBn/G24OqGNcu4Ljlp/?=
 =?us-ascii?Q?UcIuUPTxvIDsI1J6vob+sUemWJaj1CEHClKXCL2UEAhJIMgZ3BjWs0FQQUmZ?=
 =?us-ascii?Q?W2H22drzpiJeerEqJfmVO1ccP9cD8x3qcUTSe9UfzIYn/CnudDx2YSy9Xk9b?=
 =?us-ascii?Q?yWh/KShqd23wubzSF1fri9ZfpMaVIH6FxAooicHOj1y7rrpfz+jcBt6MPEvR?=
 =?us-ascii?Q?QjlDZx/cl9R9f0QFiCGEe9YHToVTYGgwQ2Z0zg3DrO+LoOQNiWmCYm2vljRt?=
 =?us-ascii?Q?16qGrSxYcM7pWMpSMxKre/7iQk96IehquUZyWDHsm91NukY04qcEtKOnZrWQ?=
 =?us-ascii?Q?ieobmrxoFJMZ0lhjsGgx+wEdjpI5XdHBisGYpwPOWXRw/QxgXcSV3is4rDWY?=
 =?us-ascii?Q?/xc40tzeTvGJJmNLq3RX0Td4xH50AGGE/3qoZTgMeDro94ijJ44q/P82zE0d?=
 =?us-ascii?Q?GqTpedE8GSoqUL95fYWXhVAfJ33HTImD8wVPhUjWXhGWFAzS0D7ZntcPWH+4?=
 =?us-ascii?Q?iexk55rstDwR/j1Msxri3jtbbiv4xH+kjGvOgE/t+jVyUB4vZxtBb8u8zkB1?=
 =?us-ascii?Q?H50jDoqjTNgkahj8/UG0jU0TV67gcdCmbrHA0ZX+9bczr4ZGCt6pmwGxxu/A?=
 =?us-ascii?Q?eYS5QhkZs9f4rSX2XjtOCmTJcI/CXKfHxqvwacvBCP3aAxlld0Ry/EZ8H5Ne?=
 =?us-ascii?Q?8Hcrz2YkcOZlg/CoY21Dbq++CPFFJjOWtYZjb4RwSNMlqEGtT+otr1iSgQvP?=
 =?us-ascii?Q?NW5vUW0mFvzWqfpvl7yaUDNQ4U7gwCFKFipXrwJaxl41g8v/VuAGaypyGrWq?=
 =?us-ascii?Q?0ddo3jFCJocMv83fJi1TJ0Z9UY9CkT40TDlPZFCkcG3X3FyEFT2nxdVUZZLy?=
 =?us-ascii?Q?dP9VxwVhq08zLjusyCYTvroK26U5htxLhTIavslNVdTT6OSij7zuM18a9NPV?=
 =?us-ascii?Q?JZfcECJroGoMHCQA48Kjw3tDlSwgwaaFu/HloipfoXIbxJg23hQZYBfeQhMF?=
 =?us-ascii?Q?uF28spjF4fczWMuxJRYcfGKlZPnoyu+EXbMzl5A8xLMPKIVWXQYYDwI/++BQ?=
 =?us-ascii?Q?Qgy6K+idTKdPVyh956CBAmnH7haJ0YRyIvpOGh0hO7HGWpuGTnFM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646d8b05-8d83-4ffa-f059-08ded7e9b9c8
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 03:26:37.9999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Fu+wsTAgZDJgoCdUXstzQhOziJa0HJ5xsLd8WNwlAmKYRYFUtOcLeauXUbAbXZAPg/RcLl7WkvZrAezYLTvOR/cNRRtB1kYwTwkp5ib9iTY4IA/QgjOjXzS2tsWTYou
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10248

From: Wei Fang <wei.fang@nxp.com>

The num_vsi field in struct enetc_port_caps is populated by reading the
NUM_VSI field of the ECAPR1 register, which reports the number of VSIs
supported by the ENETC4 port. This value is equivalent to the total
number of VFs reported by the PCI SR-IOV capability, which is already
stored in pf->total_vfs during probe via pci_sriov_get_totalvfs().

Since pf->total_vfs carries the same information and is already
available throughout the driver, there is no need to read and cache
num_vsi separately in the port capabilities structure. Remove the
num_vsi field from enetc_port_caps and the associated ECAPR1_NUM_VSI
macro, and replace all uses of pf->caps.num_vsi with pf->total_vfs in
the ring allocation, MSI-X configuration, SI enable, and debugfs code
paths.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/enetc4_debugfs.c | 13 +++----
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  1 -
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 37 +++++++++----------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 -
 4 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
index be378bf8f74d..5029038bf99f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
@@ -28,17 +28,14 @@ static void enetc_show_si_mac_hash_filter(struct seq_file *s, int i)
 
 static int enetc_mac_filter_show(struct seq_file *s, void *data)
 {
-	struct enetc_si *si = s->private;
-	struct enetc_hw *hw = &si->hw;
+	struct enetc_pf *pf = enetc_si_priv(s->private);
+	struct enetc_hw *hw = &pf->si->hw;
+	int num_si = pf->total_vfs + 1;
 	struct maft_entry_data maft;
 	struct ntmp_user *user;
-	struct enetc_pf *pf;
 	u32 val, entry_id;
-	int i, num_si;
 	int err = 0;
-
-	pf = enetc_si_priv(si);
-	num_si = pf->caps.num_vsi + 1;
+	int i;
 
 	val = enetc_port_rd(hw, ENETC4_PSIPMMR);
 	for (i = 0; i < num_si; i++) {
@@ -52,7 +49,7 @@ static int enetc_mac_filter_show(struct seq_file *s, void *data)
 	for (i = 0; i < num_si; i++)
 		enetc_show_si_mac_hash_filter(s, i);
 
-	user = &si->ntmp_user;
+	user = &pf->si->ntmp_user;
 	rtnl_lock();
 
 	if (bitmap_empty(user->maft_eid_bitmap, user->maft_num_entries))
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 7a3ccc94b036..72b54fe02e65 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -50,7 +50,6 @@
 #define  ECAPR1_NUM_MCH			GENMASK(9, 8)
 #define  ECAPR1_NUM_UCH			GENMASK(11, 10)
 #define  ECAPR1_NUM_MSIX		GENMASK(22, 12)
-#define  ECAPR1_NUM_VSI			GENMASK(27, 24)
 #define  ECAPR1_NUM_IPV			BIT(31)
 
 #define ENETC4_ECAPR2			0x8
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index d919a8645fb1..c47ee2049aac 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -23,7 +23,6 @@ static void enetc4_get_port_caps(struct enetc_pf *pf)
 	u32 val;
 
 	val = enetc_port_rd(hw, ENETC4_ECAPR1);
-	pf->caps.num_vsi = (val & ECAPR1_NUM_VSI) >> 24;
 	pf->caps.num_msix = ((val & ECAPR1_NUM_MSIX) >> 12) + 1;
 
 	val = enetc_port_rd(hw, ENETC4_ECAPR2);
@@ -258,34 +257,35 @@ static void enetc4_default_rings_allocation(struct enetc_pf *pf)
 {
 	struct enetc_hw *hw = &pf->si->hw;
 	u32 num_rx_bdr, num_tx_bdr, val;
+	int num_vfs = pf->total_vfs;
 	u32 vf_tx_bdr, vf_rx_bdr;
 	int i, rx_rem, tx_rem;
 
-	if (pf->caps.num_rx_bdr < ENETC_SI_MAX_RING_NUM + pf->caps.num_vsi)
-		num_rx_bdr = pf->caps.num_rx_bdr - pf->caps.num_vsi;
+	if (pf->caps.num_rx_bdr < ENETC_SI_MAX_RING_NUM + num_vfs)
+		num_rx_bdr = pf->caps.num_rx_bdr - num_vfs;
 	else
 		num_rx_bdr = ENETC_SI_MAX_RING_NUM;
 
-	if (pf->caps.num_tx_bdr < ENETC_SI_MAX_RING_NUM + pf->caps.num_vsi)
-		num_tx_bdr = pf->caps.num_tx_bdr - pf->caps.num_vsi;
+	if (pf->caps.num_tx_bdr < ENETC_SI_MAX_RING_NUM + num_vfs)
+		num_tx_bdr = pf->caps.num_tx_bdr - num_vfs;
 	else
 		num_tx_bdr = ENETC_SI_MAX_RING_NUM;
 
 	val = enetc4_psicfgr0_val_construct(false, num_tx_bdr, num_rx_bdr);
 	enetc_port_wr(hw, ENETC4_PSICFGR0(0), val);
 
-	if (!pf->caps.num_vsi)
+	if (!num_vfs)
 		return;
 
 	num_rx_bdr = pf->caps.num_rx_bdr - num_rx_bdr;
-	rx_rem = num_rx_bdr % pf->caps.num_vsi;
-	num_rx_bdr = num_rx_bdr / pf->caps.num_vsi;
+	rx_rem = num_rx_bdr % num_vfs;
+	num_rx_bdr = num_rx_bdr / num_vfs;
 
 	num_tx_bdr = pf->caps.num_tx_bdr - num_tx_bdr;
-	tx_rem = num_tx_bdr % pf->caps.num_vsi;
-	num_tx_bdr = num_tx_bdr / pf->caps.num_vsi;
+	tx_rem = num_tx_bdr % num_vfs;
+	num_tx_bdr = num_tx_bdr / num_vfs;
 
-	for (i = 0; i < pf->caps.num_vsi; i++) {
+	for (i = 0; i < num_vfs; i++) {
 		vf_tx_bdr = (i < tx_rem) ? num_tx_bdr + 1 : num_tx_bdr;
 		vf_rx_bdr = (i < rx_rem) ? num_rx_bdr + 1 : num_rx_bdr;
 		val = enetc4_psicfgr0_val_construct(true, vf_tx_bdr, vf_rx_bdr);
@@ -302,26 +302,25 @@ static void enetc4_allocate_si_rings(struct enetc_pf *pf)
 static void enetc4_set_si_msix_num(struct enetc_pf *pf)
 {
 	struct enetc_hw *hw = &pf->si->hw;
-	int i, num_msix, total_si;
+	int num_si = pf->total_vfs + 1;
+	int i, num_msix;
 	u32 val;
 
-	total_si = pf->caps.num_vsi + 1;
-
-	num_msix = pf->caps.num_msix / total_si +
-		   pf->caps.num_msix % total_si - 1;
+	num_msix = pf->caps.num_msix / num_si +
+		   pf->caps.num_msix % num_si - 1;
 	val = num_msix & PSICFGR2_NUM_MSIX;
 	enetc_port_wr(hw, ENETC4_PSICFGR2(0), val);
 
-	num_msix = pf->caps.num_msix / total_si - 1;
+	num_msix = pf->caps.num_msix / num_si - 1;
 	val = num_msix & PSICFGR2_NUM_MSIX;
-	for (i = 0; i < pf->caps.num_vsi; i++)
+	for (i = 0; i < pf->total_vfs; i++)
 		enetc_port_wr(hw, ENETC4_PSICFGR2(i + 1), val);
 }
 
 static void enetc4_enable_all_si(struct enetc_pf *pf)
 {
 	struct enetc_hw *hw = &pf->si->hw;
-	int num_si = pf->caps.num_vsi + 1;
+	int num_si = pf->total_vfs + 1;
 	u32 si_bitmap = 0;
 	int i;
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 574ab4e76d8b..9c36ba50a7f0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -18,7 +18,6 @@ struct enetc_vf_state {
 
 struct enetc_port_caps {
 	u32 half_duplex:1;
-	int num_vsi;
 	int num_msix;
 	int num_rx_bdr;
 	int num_tx_bdr;
-- 
2.34.1



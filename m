Return-Path: <linuxppc-dev+bounces-25632-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D931C5AC82
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2026 03:19:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hH5pY0BMsz303F;
	Sat, 08 Aug 2026 13:19:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786159156;
	cv=pass; b=CcI31XUfXMKAP3Ddtkigc67o33dGX3SgoN2vvRBkBpDDG8trD3ZNglLp90jZaN7MfuvR8RqkrjuMpjsy9pTVjezsRL0t76uTSKP9EYPicLBvmP6qERcohbO/5JOb1oxpaxUekw4XIlyn80XkqlXLDLEN6nIG2QP3/jcz+CqEqVZ6PKwFgZ1AwSPfWXiC8XQwZOP0IZu/uwpH7EILQqGwsxB0dEglSj7eVEQJJsK/6VmS0Z5uQ5VNqMZiQOkQVwcnt8wt+P20h0f/6ZS3cnWYGPrA11UMpLQovkCUy6D6FAb8ViUlbkG4Yib4s4EkpgCWi3VLZSkLYp+Wnn+YSY1kAw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786159156; c=relaxed/relaxed;
	bh=drl76DskGKMqnwdzjFSesblvpA8GHEV5bCjEYjrWQVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nhERGjj1A9nv+mT9aTz2A6DVzJqGIISuQqEUhXdlJSslsWOwUcsYcyNsh19xa1cePXJzQF3SXMKhwMqXuEAa8Y80unq88LR/AVhoChzfpFAwgkKEFtOIH68gweiTywOLfzy4sCVQu3HaoCmxRYlC7p8UsLZYQoJa2jyr9gfpZpj7jzrwWumxgkJITWzZou1JjVCWpxIm44kH+QduAbC1T4X1XCS95ZhvcRwjcm5YQ41QXAtWP6yihQ62iEK+H5QjJPBtUCUsmdOvrEyAG5VlFYNrlxmOJH9Z8QgcQqbZLh5p4WTVo71lp3SFFP6B8qRU+46DizyRTHNRy2ftuQqCQg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=aFppd3cQ; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=aFppd3cQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hH5pW16wXz300B
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 13:19:15 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qnz+gF4AVyINe5HdDbZ8dbhP8x2TjuDGEMfuN+MYExZGHrjyWhprPM4ZuzjY9KwoLzTgKmRdGTEW5aGfgEqrl+9v0KqXZTTpbjaXGehr4gW78+XqLUQvoaZIe7OaXubGU4AJc7TAZLIXjeBjUPodF7zppC9IKGVbDhjA/Lefqi9YS8b8ydy8jXXkK1oUjtO+zp8CTlCo6smdliNKF6wPHUWPP7XlqVtSKRP77h8dpztvAxA9vyDP2hn02+3JXekZsrZ6CtEVrQ5t2VJCWebtZUPFygYp3IlpN5kHp+WRMyKrOmYP9MP2QBtpiYI82k9X1ETTlNieIpvhq9t2eYg07g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drl76DskGKMqnwdzjFSesblvpA8GHEV5bCjEYjrWQVQ=;
 b=NIJhw0h6xxCsQOIqDcIK2AsJNXhiBM3kxrH1iz7ix6IPT/IMV4MZUqR22tvnIdspm7w6fHh/iFnR6wx7albgPNgENtlUaN8lQYl8LHh1+0eisrOsugc75A4I3yhWvMMpSszFUr6+27omyRbywX4gZtjh/lFj0G+ZJ5b9/wo2sxQ3OQcQdsN9NfrfzNVRiV59Uf8udM8NAbV5g5h+RoD08JKCMfTYdSnmgAojQmC7DXTf1+Cqf7TVBX4yW0sIGzAKv5XKEYHXVS1/dtjnTwK57IRif7UZ1otFpnhGFJ2qH3/M02fz5lxWQ2dEmKQoKQ6aw76a7S8L0GBuRBPxMB+WmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drl76DskGKMqnwdzjFSesblvpA8GHEV5bCjEYjrWQVQ=;
 b=aFppd3cQu5B8HR/8E6OkjiwnbgFJiHW02BkGVXFVWeZVxNlUt/H4/A6WFLn6zvnzbbWCdMu1RsxKAx8Wtkm97pExJx5ViptAarUtcgL+D0VlKr4daK3H9++Uu7FZ+lvpWJDkuwviMcswxAnyLDh2wdIPW5NTGxlQaLmHq2kBNa/1eCYlbMb6t4ADNmRuv1cKqsVYkADMVw5plXJKgPFKB7aduqNWgRhnE657o6y8t2MmY1Q5/oYmAFi6xiW5+94mIEFnJeHGwGDydHMo+HczZODI3U4lGKCTo1bzPm8fpK0K6qErpLsKz6qm5zTaBznjj+aI+11eMNW81S/kyHsDgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU2PR04MB8936.eurprd04.prod.outlook.com (2603:10a6:10:2e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Sat, 8 Aug
 2026 03:18:55 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0292.022; Sat, 8 Aug 2026
 03:18:55 +0000
From: wei.fang@oss.nxp.com
To: xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	richardcochran@gmail.com
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 net-next 7/7] net: dsa: netc: add PTP one-step timestamping support
Date: Sat,  8 Aug 2026 11:21:46 +0800
Message-Id: <20260808032146.2335723-9-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260808032146.2335723-1-wei.fang@oss.nxp.com>
References: <20260808032146.2335723-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU2PR04MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: a4fffd87-5bd8-471f-c35d-08def4fbc745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|366016|19092799006|18002099003|22082099003|5023799004|56012099006|11063799006|3023799007|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	ZvgFMDRcwuRajYmI811c61cv5DYnOdVV8QLlmEBmLZp0CAMzez0OC5e6mwNNIDFTvkogKLnhsCpbVhGoBfDRu9t04haTQN7bMkB0GTudPrepU76PE21TqMOlLY1JJNERfIqGjrxsVtNKvhsK1q20ppEf1A9lMf3+zTFjvjCC+dc0AkVE9DuOBZaXnqvKCt9g+7SWKMLVAvyVIQHyjo2tOtnoIzlGQhC31NSj2iUx4LHGNc+T9d2XGxtQ4f+R6WdHfjWBtxjOQ26n3mhcB833u0bPvPSde7QYr4ZXuS0VJwxAhHaJjH9EgMKZUil/23e6Fq/T7kaxK54bjf2I8Vlyc71wsDDYa+hJlLg0Ff+Z1sl5Yj1bS631DcnM5+AXfrYvm2QxPihWgbJdGFOo3f/jtuXYaNyKkEtna51HV9yyW2bYlAY/FkS80AsCJsvdkekvnX4SIc3LTEdCYnLuBkmN+5OztPACaywMrrLBopnQWOG6XWKBWFcknQp6ydhqcg2kiDD3pqG7WJVPYrg2fEyFjulBiC5oECDZFS+hZuI3AtvL4BsC13mIOVqs/E0hgK6ocz8kqRF9CzxTurIQgU++1620yIeCSb2jkz02sSOW09Iy4Fu5cmvEqeI1xP0e5es/qKpZpGscOJeilLcDJ36xvRP/8snvlyRO2Tdh+HiQlI+UKC/Nu36NhLEShA+pnMOVM1m+WGR4DcgMgyejbqa1Ow==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(19092799006)(18002099003)(22082099003)(5023799004)(56012099006)(11063799006)(3023799007)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mJHjd2hLwX7KxcUhTANls9TZUM4OfExObki+au8Zh//i8yMp46AjEqXEPRY7?=
 =?us-ascii?Q?KxN3qjfvK+i+g8kJzGdmeysILm5geUP7lku7L+LbnlaYPCWx+x331bOJmXK0?=
 =?us-ascii?Q?n1VK+nR70AcmKPZ3VLIvYU6ZPhIYM7JkCuct0f+bD1wkToctw0/8clolmwgy?=
 =?us-ascii?Q?WmyjVBXBrLBPVMyD0BE8e7L2VYf8x6a9w9cbcx+yXxGcRLJFBQWi9mUGKgvS?=
 =?us-ascii?Q?4RvZcc5WQADW3n5NOGyXk/S0jTC+tsv0yzuHLyuLJuEYUexrhf7axShFMkCM?=
 =?us-ascii?Q?btWgehAnAL+bXWcIM7g5tO6yke2625vsNeJIWepvu4deDlSFyTiGW0ZNtjST?=
 =?us-ascii?Q?yHqeR5JAb6CTB9y8EpotUcZBZz9+iAcYt+6WzH25Qb4MGAcmskQyTlzzQ0qk?=
 =?us-ascii?Q?tq0Rox7/zqwq3F90P50D+24ygiSsRTfgRUBmumUYP5t3ZyM1bM9+2uJ4B4g9?=
 =?us-ascii?Q?AsS+BxRlj6S3FQqXidiLLVIhPMlByGWOh5fZHcxdUAIA4xXA1R9sR8GQdJpq?=
 =?us-ascii?Q?o6Vv40EGXXBIv9DayOpMitj9zPU4HCV1OiVZi6AM8cMKcDnXDjl3IEmcbu4H?=
 =?us-ascii?Q?FtwieTOXrTfIIGcV9vhzuHLCUE5h9JRWJogoMtJEnY3wHgFe8+auLJoAkAIZ?=
 =?us-ascii?Q?8oXy3HoxETn+HOKgJmJQqaOF6Dlm8x2JXiEuXj2ldOp4ijbcMGKFGxEiQRoJ?=
 =?us-ascii?Q?YjvscA1mMBYndF9lydLbvELGTVkXXr2OM3auOANMaTPNpZbqN47tyz9fjBFG?=
 =?us-ascii?Q?TzlaAmXAU6zFo6wamnvQUwtXz6HO8jxPR8NFWxeQW90eJRyXF2HMYc9JJlio?=
 =?us-ascii?Q?HFIs3GQf92IQzQv+o+CPtxEfs8s/9R7WbCI+CML3c/ZKozm9LvVj6KwoAxfs?=
 =?us-ascii?Q?YkLGvknKbYJD7V2gQ/MsgypX2dfs3wIR2yrhlU025yxegRiKhs8kARejdZQu?=
 =?us-ascii?Q?M918W31rimjSOLXi7FK2mq9m6GJTaI3aIlNAiy7LiP9rplIk6TQuPK/yRrXn?=
 =?us-ascii?Q?7lAa84LoheKsWxzhamsa+WBDaNum2UPLH4HHi6FOi2wqY0ROytaPwXQXOCg2?=
 =?us-ascii?Q?b0ldXIaLxVfjfS3fCmtAhAkBlgpEeutMdOGSnRgGG+/PJJUmYbMwKkIfFCKj?=
 =?us-ascii?Q?hp9pVMJ2awArdwB/8f7KiwcF7FiGE6FF27sdhYdaMThteWpKJvOq5x9temPo?=
 =?us-ascii?Q?1JZD6wPkpC46hsusZXYKcswbFrfw6AbZsgAsn4edoWaE3DR7d3w96iV41hqS?=
 =?us-ascii?Q?CBX9b1EeM+DtEf1ubBscOQRjoCuZEJfdptlbwseh+a66pzQ5+vTxHDGq2lr7?=
 =?us-ascii?Q?KUFHDHdn5BF4uY8YM93R/zg71p3mmd5BnpMrNBxMInHcyoEP0yDVXXtrpNfT?=
 =?us-ascii?Q?5C+9iEJu3EQrNwia7YclFwUtFoMXVMloEBkfaqN6a/qEFn0risUWZ+fNZQml?=
 =?us-ascii?Q?cARaLE6Qkx0PU0jNGR6/UBmj5L8Bte6Y2OiFQl/WnOmciitvPq2LguPL4bZ9?=
 =?us-ascii?Q?lL1fWgLZdmkK3Esq+mE6hqfh1GLW8FCKbtjS/qTWVsrUEm/5LOb8vXJIBHf2?=
 =?us-ascii?Q?ySLhknlHbvTjlaizn8fALkJCRdo1tMhuz6oD6647Lta2LuRCm86XSyAOjZr9?=
 =?us-ascii?Q?UlE731Y/znsahvsraT2SneAyIkr1u7VWU2TsY+cDmT/dJUIDTfpPADxNpn1Y?=
 =?us-ascii?Q?OB7Zt1PI6c4Ho6VMBpxlgUbTjAt3vHP7BVAevYuLoEwdtt3l437BcMUHKgvo?=
 =?us-ascii?Q?Ph1Zt0+rn88EgrhvRGnu8K4Sb3AiGOJZmj9LQXEjLtpQdz7e9rW7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4fffd87-5bd8-471f-c35d-08def4fbc745
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2026 03:18:55.3067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3u1OSQENn+4ORKU2BT2XF0BhBIvBJf4OYIEEMa81a+Wfg69KjeViANl9Txor5eAqvcvlQbAxeScQV3KCIl5I4LxGTdEZf0xpdz7SRjxD0pMiItqfz1IbXoa0hkhZdAnN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8936

From: Wei Fang <wei.fang@nxp.com>

The NETC switch supports one-step TX timestamping for PTP Sync frames.
The MAC captures the SFD transmit time, adds the residence time to the
correction field at the offset given by PM_SINGLE_STEP[OFFSET], and
writes the result back before the frame leaves the wire. The software
timestamp (low 30 bits of the PTP Timer value) is carried in the
To_Port SubType 1 tag.

PM_SINGLE_STEP is a per-port register that can describe only one
in-flight frame at a time, and programming it requires reading the
current PTP time, which may sleep. Both constraints rule out handling
one-step Sync on the xmit path.

Instead, defer transmission to a per-port process-context work. The
xmit path classifies the frame in netc_port_txtstamp(): a genuine
one-step Sync (twoStepFlag cleared) has its PTP header offsets cached
in the skb control block; frames that cannot be handled as one-step
fall back to the two-step path or are sent as normal frames.
netc_xmit() hands the classified frame to the switch driver via the
onestep_sync_enqueue tagger callback, which queues it and kicks the
work if no frame is currently in flight.

The work dequeues one frame at a time, reads a fresh PTP time,
programs PM_SINGLE_STEP, updates the originTimestamp field, and
transmits the frame directly to the conduit via the onestep_sync_xmit
tagger callback, bypassing dsa_user_xmit() to avoid double-counting
TX stats. Only one frame is in flight at a time: the frame carries a
TX-completion destructor that reschedules the work when the conduit
frees the skb, keeping PM_SINGLE_STEP always matched to the frame
being transmitted.

The one-step context is reference-counted and its lifetime is decoupled
from the devm-allocated netc_port. In-flight skbs hold a reference via
their destructor, so the context outlives port disable until the conduit
frees the last in-flight skb. Port disable clears @active and purges the
queue under work_lock; a work that runs afterwards observes @active
cleared and returns without touching the freed port resources.

Assisted-by: Wchat:claude-opus-4-8
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c      |  61 +++-
 drivers/net/dsa/netc/netc_ptp.c       | 418 +++++++++++++++++++++++++-
 drivers/net/dsa/netc/netc_switch.h    |  48 +++
 drivers/net/dsa/netc/netc_switch_hw.h |   5 +
 include/linux/dsa/tag_netc.h          |  22 ++
 net/dsa/tag_netc.c                    |  70 ++++-
 6 files changed, 615 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 4e139ffc2f76..55664045ba19 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -74,6 +74,7 @@ static int netc_connect_tag_protocol(struct dsa_switch *ds,
 		return -EPROTONOSUPPORT;
 
 	tagger_data = ds->tagger_data;
+	tagger_data->onestep_sync_enqueue = netc_port_onestep_sync_enqueue;
 	tagger_data->twostep_tstamp_handler = netc_port_twostep_tstamp_handler;
 
 	return 0;
@@ -94,7 +95,7 @@ static void netc_port_rmw(struct netc_port *np, u32 reg,
 	netc_port_wr(np, reg, new);
 }
 
-static void netc_mac_port_wr(struct netc_port *np, u32 reg, u32 val)
+void netc_mac_port_wr(struct netc_port *np, u32 reg, u32 val)
 {
 	if (is_netc_pseudo_port(np))
 		return;
@@ -252,6 +253,21 @@ static void netc_get_switch_capabilities(struct netc_switch *priv)
 	priv->num_bp = FIELD_GET(BPCAPR_NUM_BP, val);
 }
 
+static void netc_free_user_ports(struct netc_switch *priv)
+{
+	struct dsa_switch *ds = priv->ds;
+	struct dsa_port *dp;
+
+	dsa_switch_for_each_user_port(dp, ds) {
+		struct netc_port *np = NETC_PORT(ds, dp->index);
+
+		if (np->onestep) {
+			netc_onestep_put(np->onestep);
+			np->onestep = NULL;
+		}
+	}
+}
+
 static int netc_init_all_ports(struct netc_switch *priv)
 {
 	struct device *dev = priv->dev;
@@ -292,13 +308,13 @@ static int netc_init_all_ports(struct netc_switch *priv)
 
 		err = netc_port_get_info_from_dt(np, dp->dn, dev);
 		if (err)
-			return err;
+			goto free_user_ports;
 
 		if (dsa_port_is_user(dp)) {
 			err = netc_port_create_mdio_bus(np, dp->dn);
 			if (err) {
 				dev_err(dev, "Failed to create MDIO bus\n");
-				return err;
+				goto free_user_ports;
 			}
 
 			/* The ipft_hf_eid is initialized to an invalid entry
@@ -314,11 +330,16 @@ static int netc_init_all_ports(struct netc_switch *priv)
 			 */
 			err = netc_port_ptp_init(np);
 			if (err)
-				return err;
+				goto free_user_ports;
 		}
 	}
 
 	return 0;
+
+free_user_ports:
+	netc_free_user_ports(priv);
+
+	return err;
 }
 
 static void netc_init_ntmp_tbl_versions(struct netc_switch *priv)
@@ -941,7 +962,7 @@ static int netc_setup(struct dsa_switch *ds)
 
 	err = netc_init_ntmp_user(priv);
 	if (err)
-		goto put_ptp_timer;
+		goto free_user_ports;
 
 	INIT_HLIST_HEAD(&priv->fdb_list);
 	mutex_init(&priv->fdbt_lock);
@@ -980,6 +1001,8 @@ static int netc_setup(struct dsa_switch *ds)
 	mutex_destroy(&priv->fdbt_lock);
 	mutex_destroy(&priv->vft_lock);
 	netc_free_ntmp_user(priv);
+free_user_ports:
+	netc_free_user_ports(priv);
 put_ptp_timer:
 	pci_dev_put(priv->tmr_dev);
 
@@ -1005,6 +1028,19 @@ static void netc_free_ports_resources(struct netc_switch *priv)
 			continue;
 
 		netc_port_purge_txtstamp_queue(np);
+
+		/* dsa_tree_teardown() calls dsa_tree_teardown_ports() before
+		 * dsa_tree_teardown_switches(), so netc_port_disable() is
+		 * executed before netc_teardown() and purges onestep->queue,
+		 * so here we only need to drop the port's owner reference.
+		 * In-flight one-step skbs still hold references via the
+		 * destructor; the context (and its work) is freed only after
+		 * the conduit frees the last in-flight skb. By then np may
+		 * be gone, but the work no longer dereferences np because
+		 * onestep->active has been cleared.
+		 */
+		netc_onestep_put(np->onestep);
+		np->onestep = NULL;
 	}
 }
 
@@ -1559,6 +1595,7 @@ static int netc_port_enable(struct dsa_switch *ds, int port,
 			    struct phy_device *phy)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
+	struct netc_onestep *onestep = np->onestep;
 	int err;
 
 	if (np->enable)
@@ -1571,6 +1608,12 @@ static int netc_port_enable(struct dsa_switch *ds, int port,
 		return err;
 	}
 
+	if (onestep) {
+		mutex_lock(&onestep->work_lock);
+		onestep->active = true;
+		mutex_unlock(&onestep->work_lock);
+	}
+
 	np->enable = true;
 
 	return 0;
@@ -1579,6 +1622,7 @@ static int netc_port_enable(struct dsa_switch *ds, int port,
 static void netc_port_disable(struct dsa_switch *ds, int port)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
+	struct netc_onestep *onestep = np->onestep;
 
 	/* When .port_disable() is called, .port_enable() may not have been
 	 * called. In this case, both the prepare_count and enable_count of
@@ -1588,6 +1632,13 @@ static void netc_port_disable(struct dsa_switch *ds, int port)
 	if (!np->enable)
 		return;
 
+	if (onestep) {
+		mutex_lock(&onestep->work_lock);
+		onestep->active = false;
+		netc_port_purge_onestep_queue(onestep, true);
+		mutex_unlock(&onestep->work_lock);
+	}
+
 	clk_disable_unprepare(np->ref_clk);
 	np->enable = false;
 }
diff --git a/drivers/net/dsa/netc/netc_ptp.c b/drivers/net/dsa/netc/netc_ptp.c
index 1384a6f31d1c..d0423b3c8c33 100644
--- a/drivers/net/dsa/netc/netc_ptp.c
+++ b/drivers/net/dsa/netc/netc_ptp.c
@@ -4,13 +4,270 @@
  * Copyright 2025-2026 NXP
  */
 
+#include <linux/kref.h>
 #include <linux/ptp_classify.h>
 #include <linux/ptp_clock_kernel.h>
+#include <linux/slab.h>
 
 #include "netc_switch.h"
 
 #define NETC_NUM_TS_REQ_ID		16
 #define NETC_TXTSTAMP_TIMEOUT		(5 * HZ)
+#define NETC_MAX_STEP_OFFSET		0x1ff
+
+static void netc_port_set_onestep_control(struct netc_port *np,
+					  bool csum_update, int offset)
+{
+	u32 val;
+
+	val = PM_SINGLE_STEP_EN | FIELD_PREP(PM_SINGLE_STEP_OFFSET, offset);
+	if (csum_update)
+		val |= PM_SINGLE_STEP_CH;
+	netc_mac_port_wr(np, NETC_PM_SINGLE_STEP(0), val);
+}
+
+static void netc_onestep_destroy_work(struct work_struct *work)
+{
+	struct netc_onestep *onestep = container_of(work, struct netc_onestep,
+						    destroy_work);
+
+	/* refcnt reaching zero does not by itself mean onestep->work has
+	 * stopped: the last in-flight skb destructor calls schedule_work(&work)
+	 * *before* the netc_onestep_put() that drops the final reference, so at
+	 * the moment refcnt hits zero onestep->work may still be pending or
+	 * running on another CPU. destroy_work and work are distinct work_structs
+	 * and can run concurrently, so cancel_work_sync() is required to drain
+	 * onestep->work before mutex_destroy()/kfree() below, otherwise a
+	 * still-running work would touch freed memory. No new schedule_work(&work)
+	 * can occur after this point because no references remain, so this
+	 * cancel is final.
+	 */
+	cancel_work_sync(&onestep->work);
+	mutex_destroy(&onestep->work_lock);
+	kfree(onestep);
+}
+
+static void netc_onestep_release(struct kref *ref)
+{
+	struct netc_onestep *onestep = container_of(ref, struct netc_onestep,
+						    refcnt);
+
+	/* This may be called from the skb destructor in softirq context
+	 * (napi_consume_skb()), where cancel_work_sync() must not be used.
+	 * Defer the final teardown to process context.
+	 */
+	schedule_work(&onestep->destroy_work);
+}
+
+static void netc_onestep_get(struct netc_onestep *onestep)
+{
+	kref_get(&onestep->refcnt);
+}
+
+void netc_onestep_put(struct netc_onestep *onestep)
+{
+	kref_put(&onestep->refcnt, netc_onestep_release);
+}
+
+static void netc_onestep_skb_destructor(struct sk_buff *skb)
+{
+	struct netc_onestep *onestep = skb_shinfo(skb)->destructor_arg;
+
+	/* skb has been transmitted by hardware. Schedule work to send the next
+	 * queued one-step Sync packet, then release this skb's reference on the
+	 * context. If the port has already been torn down and this is the last
+	 * reference, the context is freed via netc_onestep_release().
+	 */
+	schedule_work(&onestep->work);
+	netc_onestep_put(onestep);
+}
+
+static void netc_port_program_onestep(struct netc_port *np,
+				      struct netc_onestep *onestep,
+				      struct sk_buff *skb,
+				      u64 tstamp)
+{
+	u16 correction_offset = NETC_SKB_CB(skb)->correction_offset;
+	u16 tstamp_offset = NETC_SKB_CB(skb)->timestamp_offset;
+	u8 *hdr = skb_mac_header(skb);
+	bool csum_update = false;
+	__be32 new_sec_l, new_ns;
+	__be16 new_sec_h;
+	u64 sec;
+	u32 ns;
+
+	NETC_SKB_CB(skb)->tstamp = tstamp;
+	NETC_SKB_CB(skb)->ptp_flag = NETC_PTP_FLAG_ONESTEP;
+
+	/* Update originTimestamp field of Sync packet
+	 * - 48 bits seconds field
+	 * - 32 bits nanoseconds field
+	 */
+	sec = div_u64_rem(tstamp, NSEC_PER_SEC, &ns);
+	new_sec_h = htons((sec >> 32) & 0xffff);
+	new_sec_l = htonl(sec & 0xffffffff);
+	new_ns = htonl(ns);
+
+	if (NETC_SKB_CB(skb)->is_udp) {
+		__be32 old_sec_l, old_ns;
+		struct udphdr *uh;
+		__be16 old_sec_h;
+
+		if (skb->ip_summed == CHECKSUM_PARTIAL) {
+			csum_update = true;
+			goto update_timestamp;
+		}
+
+		if (unlikely(!skb_transport_header_was_set(skb)))
+			uh = (struct udphdr *)(hdr + tstamp_offset -
+					       sizeof(struct ptp_header) -
+					       sizeof(struct udphdr));
+		else
+			uh = udp_hdr(skb);
+
+		/* For IPv4, a UDP checksum of zero on the wire means "no
+		 * checksum". For IPv6, its UDP checksum is mandatory and
+		 * never zero.
+		 */
+		if (!uh->check)
+			goto update_timestamp;
+
+		old_sec_h = __get_unaligned_t(__be16, hdr + tstamp_offset);
+		old_sec_l = __get_unaligned_t(__be32, hdr + tstamp_offset + 2);
+		old_ns = __get_unaligned_t(__be32, hdr + tstamp_offset + 6);
+		inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
+					 new_sec_h, false);
+		inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
+					 new_sec_l, false);
+		inet_proto_csum_replace4(&uh->check, skb, old_ns,
+					 new_ns, false);
+		csum_update = true;
+	}
+
+update_timestamp:
+	__put_unaligned_t(__be16, new_sec_h, hdr + tstamp_offset);
+	__put_unaligned_t(__be32, new_sec_l, hdr + tstamp_offset + 2);
+	__put_unaligned_t(__be32, new_ns, hdr + tstamp_offset + 6);
+
+	netc_port_set_onestep_control(np, csum_update, correction_offset);
+
+	/* Orphan the skb to release the socket send buffer quota immediately.
+	 * This is safe because sock_wfree() does not access skb->data or any
+	 * frame content. After skb_orphan(), we install our own destructor so
+	 * that when the conduit driver frees the skb after TX completion, we
+	 * get notified to send the next queued Sync packet.
+	 */
+	skb_orphan(skb);
+	netc_onestep_get(onestep); /* in-flight reference */
+	skb_shinfo(skb)->destructor_arg = onestep;
+	skb->destructor = netc_onestep_skb_destructor;
+}
+
+static u64 netc_get_phc_time(struct netc_switch *priv)
+{
+	if (unlikely(!priv->tmr_dev))
+		return 0;
+
+	return netc_timer_get_current_time(priv->tmr_dev);
+}
+
+void netc_port_onestep_work(struct work_struct *work)
+{
+	struct netc_onestep *onestep = container_of(work, struct netc_onestep,
+						    work);
+	struct netc_tagger_data *tagger_data;
+	struct netc_switch *priv;
+	struct netc_port *np;
+	struct sk_buff *skb;
+	u64 tstamp;
+
+	/* Serialize the whole hardware access against port disable. work_lock
+	 * is a mutex (this runs in process context and netc_get_phc_time() may
+	 * sleep). If the port has been disabled, bail out immediately; np and
+	 * priv are only dereferenced after the @active check passes, so they
+	 * are always valid here.
+	 */
+	mutex_lock(&onestep->work_lock);
+	if (unlikely(!onestep->active)) {
+		netc_port_purge_onestep_queue(onestep, true);
+		goto unlock_work;
+	}
+
+	/* Send only one queued Sync per run. The shared SINGLE_STEP register
+	 * must match the frame currently being transmitted, so the next frame
+	 * is programmed only after this one completes TX, when its skb
+	 * destructor reschedules this work. Dequeue under onestep->queue_lock,
+	 * and if the queue has drained, release the in-flight slot so a later
+	 * frame from the xmit path kicks the work again.
+	 */
+	spin_lock_bh(&onestep->queue_lock);
+	skb = __skb_dequeue(&onestep->queue);
+	if (!skb) {
+		onestep->in_flight = false;
+		spin_unlock_bh(&onestep->queue_lock);
+		goto unlock_work;
+	}
+	spin_unlock_bh(&onestep->queue_lock);
+
+	np = onestep->np;
+	priv = np->switch_priv;
+	tstamp = netc_get_phc_time(priv);
+	if (unlikely(!tstamp)) {
+		/* The PTP timer is not available, so there is no correct
+		 * timestamp to program. Drop this frame and re-kick to process
+		 * the remaining queued frames.
+		 *
+		 * netc_port_program_onestep() has not run for this skb yet, so
+		 * netc_onestep_skb_destructor() is not installed on it. Freeing
+		 * it therefore does not reschedule the work, so the work must be
+		 * rescheduled explicitly to keep draining the queue.
+		 */
+		dev_dbg_ratelimited(priv->dev,
+				    "Port %d PTP timer unavailable, drop Sync\n",
+				    np->dp->index);
+		kfree_skb(skb);
+		schedule_work(&onestep->work);
+		goto unlock_work;
+	}
+
+	/* Reuse the offsets cached at enqueue time; only the timestamp is
+	 * read fresh so it reflects the actual TX moment.
+	 */
+	netc_port_program_onestep(np, onestep, skb, tstamp);
+
+	/* Tag and hand the frame directly to the conduit via the tagger,
+	 * bypassing dsa_user_xmit() so the TX stats are not counted twice.
+	 * And there is no need to check if tagger_data is NULL, because
+	 * dsa_tree_teardown_ports() executes before
+	 * dsa_switch_teardown_tag_protocol(), so tagger_data cannot be
+	 * NULL when onestep->active is set.
+	 */
+	tagger_data = priv->ds->tagger_data;
+	tagger_data->onestep_sync_xmit(skb, np->dp->user);
+
+unlock_work:
+	mutex_unlock(&onestep->work_lock);
+}
+
+static int netc_port_onestep_alloc(struct netc_port *np)
+{
+	struct netc_onestep *onestep;
+
+	onestep = kzalloc_obj(*onestep);
+	if (!onestep)
+		return -ENOMEM;
+
+	kref_init(&onestep->refcnt); /* port (owner) reference */
+	np->onestep = onestep;
+	onestep->np = np;
+	mutex_init(&onestep->work_lock);
+	spin_lock_init(&onestep->queue_lock);
+	__skb_queue_head_init(&onestep->queue);
+	INIT_WORK(&onestep->work, netc_port_onestep_work);
+	INIT_WORK(&onestep->destroy_work, netc_onestep_destroy_work);
+
+	return 0;
+}
 
 int netc_port_ptp_init(struct netc_port *np)
 {
@@ -21,7 +278,7 @@ int netc_port_ptp_init(struct netc_port *np)
 	spin_lock_init(&np->tstamp_lock);
 	__skb_queue_head_init(&np->skb_txtstamp_queue);
 
-	return 0;
+	return netc_port_onestep_alloc(np);
 }
 
 static int netc_get_phc_index(struct netc_switch *priv)
@@ -45,7 +302,8 @@ int netc_get_ts_info(struct dsa_switch *ds, int port,
 				 SOF_TIMESTAMPING_RX_HARDWARE |
 				 SOF_TIMESTAMPING_RAW_HARDWARE;
 
-	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
+	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON) |
+			 BIT(HWTSTAMP_TX_ONESTEP_SYNC);
 
 	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
 			   BIT(HWTSTAMP_FILTER_PTP_V2_EVENT) |
@@ -262,6 +520,22 @@ void netc_port_purge_txtstamp_queue(struct netc_port *np)
 	__skb_queue_purge(&free_list);
 }
 
+void netc_port_purge_onestep_queue(struct netc_onestep *onestep,
+				   bool clear_flight)
+{
+	struct sk_buff_head free_list;
+
+	__skb_queue_head_init(&free_list);
+
+	spin_lock_bh(&onestep->queue_lock);
+	skb_queue_splice_init(&onestep->queue, &free_list);
+	if (clear_flight)
+		onestep->in_flight = false;
+	spin_unlock_bh(&onestep->queue_lock);
+
+	__skb_queue_purge(&free_list);
+}
+
 int netc_port_hwtstamp_set(struct dsa_switch *ds, int port,
 			   struct kernel_hwtstamp_config *config,
 			   struct netlink_ext_ack *extack)
@@ -278,6 +552,7 @@ int netc_port_hwtstamp_set(struct dsa_switch *ds, int port,
 	switch (config->tx_type) {
 	case HWTSTAMP_TX_ON:
 	case HWTSTAMP_TX_OFF:
+	case HWTSTAMP_TX_ONESTEP_SYNC:
 		break;
 	default:
 		return -ERANGE;
@@ -316,6 +591,9 @@ int netc_port_hwtstamp_set(struct dsa_switch *ds, int port,
 	if (config->tx_type == HWTSTAMP_TX_OFF)
 		netc_port_purge_txtstamp_queue(np);
 
+	if (config->tx_type != HWTSTAMP_TX_ONESTEP_SYNC)
+		netc_port_purge_onestep_queue(np->onestep, false);
+
 	config->rx_filter = rx_filter;
 
 	return 0;
@@ -439,9 +717,100 @@ bool netc_port_rxtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb,
 	return false;
 }
 
+static void netc_port_prepare_onestep_sync(struct netc_port *np,
+					   struct sk_buff *skb,
+					   u32 ptp_class, bool *twostep)
+{
+	struct netc_switch *priv = np->switch_priv;
+	u16 correction_offset, tstamp_offset;
+	struct ptp_header *ptp_hdr;
+	u8 msg_type, twostep_flag;
+	bool is_udp = false;
+	u32 pkt_type;
+	u8 *pkt_hdr;
+
+	if (unlikely(skb_linearize(skb))) {
+		NETC_SKB_CB(skb)->ptp_flag = NETC_PTP_FLAG_DROP;
+		return;
+	}
+
+	ptp_hdr = ptp_parse_header(skb, ptp_class);
+	if (unlikely(!ptp_hdr)) {
+		NETC_SKB_CB(skb)->ptp_flag = NETC_PTP_FLAG_DROP;
+		dev_dbg_ratelimited(priv->dev,
+				    "Port %d failed to parse Sync header\n",
+				    np->dp->index);
+		return;
+	}
+
+	msg_type = ptp_get_msgtype(ptp_hdr, ptp_class);
+	twostep_flag = ptp_hdr->flag_field[0] & 0x2;
+
+	pkt_hdr = skb_mac_header(skb);
+	correction_offset = (u8 *)&ptp_hdr->correction - pkt_hdr;
+	tstamp_offset = (u8 *)ptp_hdr + sizeof(*ptp_hdr) - pkt_hdr;
+
+	/* Ensure that the entire originTimestamp field is present in the
+	 * linear buffer of the skb and the correction_offset must be within
+	 * the hardware capability.
+	 */
+	if (unlikely(tstamp_offset + 10 > skb_headlen(skb) ||
+		     correction_offset > NETC_MAX_STEP_OFFSET)) {
+		NETC_SKB_CB(skb)->ptp_flag = NETC_PTP_FLAG_DROP;
+		dev_dbg_ratelimited(priv->dev,
+				    "Port %d PTP offset check error\n",
+				    np->dp->index);
+		return;
+	}
+
+	/* Only a Sync frame with the twoStepFlag cleared can use one-step
+	 * timestamping. A frame that requests two-step (or is not a Sync)
+	 * carries different on-wire fields, so this is a real classification;
+	 * report it through *twostep so the caller falls back to the two-step
+	 * path.
+	 */
+	if (msg_type != PTP_MSGTYPE_SYNC || twostep_flag != 0) {
+		*twostep = true;
+		return;
+	}
+
+	/* This is a genuine one-step Sync frame. skb_shinfo()->destructor_arg
+	 * is later used to pass the np->onestep pointer to
+	 * netc_onestep_skb_destructor() for TX completion notification.
+	 * MSG_ZEROCOPY also uses destructor_arg (via skb_zcopy_init()) to
+	 * track user-space page references. Overwriting it in that case would
+	 * leak the ubuf_info reference and prevent user pages from being
+	 * released. PTP applications do not use MSG_ZEROCOPY, but guard
+	 * against it defensively.
+	 */
+	if (skb_zcopy(skb)) {
+		NETC_SKB_CB(skb)->ptp_flag = NETC_PTP_FLAG_DROP;
+		dev_dbg_ratelimited(priv->dev,
+				    "Port %d one-step Sync not supported on zerocopy skb\n",
+				    np->dp->index);
+		return;
+	}
+
+	pkt_type = ptp_class & PTP_CLASS_PMASK;
+	if (pkt_type == PTP_CLASS_IPV4 || pkt_type == PTP_CLASS_IPV6)
+		is_udp = true;
+
+	/* Cache the parsing results so the tagger xmit path and the deferred
+	 * work do not need to re-parse the PTP header, and so that
+	 * netc_port_program_onestep() can derive these parameters from the
+	 * skb.
+	 */
+	NETC_SKB_CB(skb)->correction_offset = correction_offset;
+	NETC_SKB_CB(skb)->timestamp_offset = tstamp_offset;
+	NETC_SKB_CB(skb)->is_udp = is_udp;
+	NETC_SKB_CB(skb)->ptp_flag = NETC_PTP_FLAG_ONESTEP;
+}
+
 void netc_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
+	int tx_type = READ_ONCE(np->ptp_tx_type);
+	bool twostep = false;
 	u32 ptp_class;
 
 	NETC_SKB_CB(skb)->ptp_flag = 0;
@@ -449,6 +818,49 @@ void netc_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)
 	if (ptp_class == PTP_CLASS_NONE)
 		return;
 
-	if (READ_ONCE(np->ptp_tx_type) == HWTSTAMP_TX_ON)
+	if (tx_type == HWTSTAMP_TX_ONESTEP_SYNC)
+		netc_port_prepare_onestep_sync(np, skb, ptp_class, &twostep);
+
+	if (tx_type == HWTSTAMP_TX_ON || twostep)
 		netc_port_txtstamp_twostep(np, skb);
 }
+
+void netc_port_onestep_sync_enqueue(struct dsa_switch *ds, int port,
+				    struct sk_buff *skb)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct netc_onestep *onestep = np->onestep;
+	bool kick = false;
+
+	/* This runs in the xmit path (softirq / BH-disabled), so it must not
+	 * sleep: only queue the frame here and let netc_port_onestep_work()
+	 * program the SINGLE_STEP register and transmit it from process
+	 * context. The shared SINGLE_STEP register can describe only one frame
+	 * at a time, so at most one one-step Sync may be in flight. Track that
+	 * with @in_flight under onestep->queue_lock.
+	 *
+	 * Enqueue the frame and, only if no frame is currently in flight, claim
+	 * the in-flight slot and kick the work. When a frame is already in
+	 * flight, just queue: its skb destructor will kick the work to send the
+	 * next one once it completes TX, so the frames are transmitted strictly
+	 * one at a time in order.
+	 *
+	 * PTP Sync frames are periodic, low-rate control-plane frames and only
+	 * reach this TX path when the local socket requested hardware TX
+	 * timestamping on a one-step port, so the queue cannot be flooded and
+	 * needs no depth cap.
+	 */
+	spin_lock_bh(&onestep->queue_lock);
+	__skb_queue_tail(&onestep->queue, skb);
+	if (!onestep->in_flight) {
+		onestep->in_flight = true;
+		kick = true;
+	}
+	spin_unlock_bh(&onestep->queue_lock);
+
+	/* Ownership is transferred to the queue; netc_xmit() stops processing
+	 * this skb. The work will program and transmit it.
+	 */
+	if (kick)
+		schedule_work(&onestep->work);
+}
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 86fd15889733..98d4842441df 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -9,6 +9,7 @@
 #include <linux/dsa/tag_netc.h>
 #include <linux/fsl/netc_global.h>
 #include <linux/fsl/ntmp.h>
+#include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/of_net.h>
 #include <linux/pci.h>
@@ -87,6 +88,44 @@ enum netc_host_reason {
 	NETC_HR_PTP_TRAP   = 9,
 };
 
+/* One-step Sync serialization context.
+ *
+ * Its lifetime is decoupled from the devm-allocated netc_port. An in-flight
+ * one-step Sync skb keeps a reference on this context via its skb destructor,
+ * so the context outlives the port teardown until the conduit frees the last
+ * in-flight skb after TX completion. Once the port is disabled, @active is
+ * cleared and the work stops touching any devm memory (netc_port/netc_switch)
+ * or the unregistered user netdev or the tagger_data.
+ */
+struct netc_onestep {
+	struct netc_port *np;
+	struct kref refcnt;
+	/* Process-context lock: serializes the deferred TX work against port
+	 * teardown, so the work never touches the devm-allocated netc_port /
+	 * netc_switch or the unregistered user netdev after teardown. Held
+	 * across netc_get_phc_time(), which may sleep, hence a mutex.
+	 */
+	struct mutex work_lock;
+	/* Serialize access to in_flight and queue */
+	spinlock_t queue_lock;
+	bool active;	/* set when port is enabled, under @work_lock */
+	/* In-flight slot: true while one one-step Sync frame is programmed
+	 * into the shared SINGLE_STEP register and being transmitted. Only one
+	 * frame may be in flight at a time, so the next queued frame is sent
+	 * only after the current one completes TX (its skb destructor kicks
+	 * the work). Accessed under queue_lock, from both the softirq xmit
+	 * path and the process-context work.
+	 */
+	bool in_flight;
+	/* Pending one-step Sync frames. Enqueued from the softirq xmit path and
+	 * dequeued by the process-context work; the list is serialized by
+	 * queue_lock together with @in_flight.
+	 */
+	struct sk_buff_head queue;
+	struct work_struct work;	/* drains @queue */
+	struct work_struct destroy_work; /* frees the context in process ctx */
+};
+
 struct netc_port {
 	void __iomem *iobase;
 	struct netc_switch *switch_priv;
@@ -106,6 +145,8 @@ struct netc_port {
 	spinlock_t tstamp_lock;
 	/* skb queue for two-step timestamp frames */
 	struct sk_buff_head skb_txtstamp_queue;
+	/* one-step Sync serialization context (ref-counted, kzalloc'd) */
+	struct netc_onestep *onestep;
 	int ptp_tx_type;
 	int ptp_rx_filter;
 	u32 ptp_ipft_eid[NETC_PTP_MAX];
@@ -212,6 +253,7 @@ static inline void netc_del_vlan_entry(struct netc_vlan_entry *entry)
 }
 
 int netc_switch_platform_probe(struct netc_switch *priv);
+void netc_mac_port_wr(struct netc_port *np, u32 reg, u32 val);
 
 /* ethtool APIs */
 void netc_port_get_pause_stats(struct dsa_switch *ds, int port,
@@ -243,5 +285,11 @@ void netc_port_twostep_tstamp_handler(struct dsa_switch *ds, int port,
 bool netc_port_rxtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb,
 			unsigned int type);
 void netc_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb);
+void netc_onestep_put(struct netc_onestep *onestep);
+void netc_port_purge_onestep_queue(struct netc_onestep *onestep,
+				   bool clear_flight);
+void netc_port_onestep_work(struct work_struct *work);
+void netc_port_onestep_sync_enqueue(struct dsa_switch *ds, int port,
+				    struct sk_buff *skb);
 
 #endif
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index 1404ae41c7bc..37d1dd7ec2c7 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -203,6 +203,11 @@ enum netc_stg_stage {
 #define   SSP_10M			1
 #define   SSP_1G			2
 
+#define NETC_PM_SINGLE_STEP(a)		(0x10c0 + (a) * 0x400)
+#define  PM_SINGLE_STEP_CH		BIT(6)
+#define  PM_SINGLE_STEP_OFFSET		GENMASK(15, 7)
+#define  PM_SINGLE_STEP_EN		BIT(31)
+
 /* Port MAC 0/1 Receive Ethernet Octets Counter */
 #define NETC_PM_REOCT(a)		(0x1100 + (a) * 0x400)
 
diff --git a/include/linux/dsa/tag_netc.h b/include/linux/dsa/tag_netc.h
index da200e3ba8ad..5ac5e2e72dff 100644
--- a/include/linux/dsa/tag_netc.h
+++ b/include/linux/dsa/tag_netc.h
@@ -10,13 +10,23 @@
 #include <net/dsa.h>
 
 #define NETC_TAG_MAX_LEN			14
+#define NETC_PTP_FLAG_ONESTEP			BIT(0)
 #define NETC_PTP_FLAG_TWOSTEP			BIT(1)
+#define NETC_PTP_FLAG_DROP			BIT(2)
 
 struct netc_skb_cb {
 	unsigned long ptp_tx_time;
 	u64 tstamp;
 	u8 ptp_flag;
 	u8 ts_req_id;
+	/* One-step Sync parsing results, computed in netc_port_txtstamp()
+	 * and reused in the tagger xmit path and the deferred work, to avoid
+	 * re-parsing the PTP header. Valid only while
+	 * ptp_flag == NETC_PTP_FLAG_ONESTEP.
+	 */
+	u16 correction_offset;
+	u16 timestamp_offset;
+	bool is_udp;
 };
 
 #define NETC_SKB_CB(skb)	((struct netc_skb_cb *)((skb)->cb))
@@ -26,10 +36,22 @@ struct netc_skb_cb {
  * @twostep_tstamp_handler: Called by the tagger when a two-step transmit
  *	timestamp response is received, to deliver the timestamp to the
  *	switch driver.
+ * @onestep_sync_enqueue: Called from the tagger xmit path for a one-step Sync
+ *	frame. The switch driver takes ownership of the skb and queues it for
+ *	deferred transmission from process context, where the shared
+ *	PM_SINGLE_STEP register can be programmed and the PTP timer read
+ *	(which may sleep). The tagger must not touch the skb after this call
+ *	and returns NULL to dsa_user_xmit().
+ * @onestep_sync_xmit: Called by the switch driver to transmit a deferred
+ *	one-step Sync frame directly to the conduit, bypassing dsa_user_xmit().
  */
 struct netc_tagger_data {
 	void (*twostep_tstamp_handler)(struct dsa_switch *ds, int port,
 				       u8 ts_req_id, u64 ts);
+	void (*onestep_sync_enqueue)(struct dsa_switch *ds, int port,
+				     struct sk_buff *skb);
+	netdev_tx_t (*onestep_sync_xmit)(struct sk_buff *skb,
+					 struct net_device *ndev);
 };
 
 #endif
diff --git a/net/dsa/tag_netc.c b/net/dsa/tag_netc.c
index 9f9a61d8133b..91548fb7ed1b 100644
--- a/net/dsa/tag_netc.c
+++ b/net/dsa/tag_netc.c
@@ -16,6 +16,8 @@
 #define NETC_TAG_TO_PORT		1
 /* SubType0: No request to perform timestamping */
 #define NETC_TAG_TP_SUBTYPE0		0
+/* SubType1: Request to perform one-step timestamping */
+#define NETC_TAG_TP_SUBTYPE1		1
 /* SubType2: Request to perform two-step timestamping */
 #define NETC_TAG_TP_SUBTYPE2		2
 
@@ -31,6 +33,7 @@
 /* NETC switch tag lengths */
 #define NETC_TAG_FORWARD_LEN		6
 #define NETC_TAG_TP_SUBTYPE0_LEN	6
+#define NETC_TAG_TP_SUBTYPE1_LEN	10
 #define NETC_TAG_TP_SUBTYPE2_LEN	6
 #define NETC_TAG_TH_SUBTYPE0_LEN	6
 #define NETC_TAG_TH_SUBTYPE1_LEN	14
@@ -44,6 +47,7 @@
 #define NETC_TAG_SWITCH			GENMASK(2, 0)
 #define NETC_TAG_PORT			GENMASK(7, 3)
 #define NETC_TAG_TS_REQ_ID		GENMASK(3, 0)
+#define NETC_TAG_TIMESTAMP		GENMASK(29, 0)
 
 struct netc_tag_cmn {
 	__be16 tpid;
@@ -52,6 +56,12 @@ struct netc_tag_cmn {
 	u8 switch_port;
 } __packed;
 
+struct netc_tag_tp_subtype1 {
+	struct netc_tag_cmn cmn;
+	u8 resv;
+	__be32 timestamp;
+} __packed;
+
 struct netc_tag_tp_subtype2 {
 	struct netc_tag_cmn cmn;
 	u8 ts_req_id;
@@ -118,6 +128,17 @@ static void netc_fill_tp_tag_subtype0(struct sk_buff *skb,
 				NETC_TAG_TP_SUBTYPE0_LEN);
 }
 
+static void netc_fill_tp_tag_subtype1(struct sk_buff *skb,
+				      struct net_device *ndev)
+{
+	u32 ts = FIELD_PREP(NETC_TAG_TIMESTAMP, NETC_SKB_CB(skb)->tstamp);
+	struct netc_tag_tp_subtype1 *tag;
+
+	tag = netc_fill_common_tp_tag(skb, ndev, NETC_TAG_TP_SUBTYPE1,
+				      NETC_TAG_TP_SUBTYPE1_LEN);
+	tag->timestamp = htonl(ts);
+}
+
 static void netc_fill_tp_tag_subtype2(struct sk_buff *skb,
 				      struct net_device *ndev)
 {
@@ -129,6 +150,42 @@ static void netc_fill_tp_tag_subtype2(struct sk_buff *skb,
 	tag->ts_req_id = FIELD_PREP(NETC_TAG_TS_REQ_ID, ts_req_id);
 }
 
+static netdev_tx_t netc_onestep_sync_xmit(struct sk_buff *skb,
+					  struct net_device *dev)
+{
+	/* This deferred one-step Sync frame already went through
+	 * dsa_user_xmit()'s skb_ensure_writable_head_tail() and eth_skb_pad()
+	 * before it was queued in netc_xmit(), and nothing has cloned it or
+	 * shrunk its head/tail room since. So the head/tail room is still
+	 * guaranteed and the skb is still writable; only the tag needs to be
+	 * pushed before handing it directly to the conduit, bypassing
+	 * dsa_user_xmit() so that dev_sw_netstats_tx_add() is not invoked a
+	 * second time for the same frame.
+	 */
+	netc_fill_tp_tag_subtype1(skb, dev);
+
+	return dsa_enqueue_skb(skb, dev);
+}
+
+static void netc_onestep_sync_enqueue(struct sk_buff *skb,
+				      struct net_device *ndev)
+{
+	struct dsa_port *dp = dsa_user_to_port(ndev);
+	struct netc_tagger_data *tagger_data;
+
+	tagger_data = dp->ds->tagger_data;
+	if (unlikely(!tagger_data->onestep_sync_enqueue)) {
+		kfree_skb(skb);
+		return;
+	}
+
+	/* Hand the one-step Sync to the switch driver, which takes ownership
+	 * and queues it for deferred transmission from its work. The tagger
+	 * must not touch the skb after this point.
+	 */
+	tagger_data->onestep_sync_enqueue(dp->ds, dp->index, skb);
+}
+
 static struct sk_buff *netc_xmit(struct sk_buff *skb,
 				 struct net_device *ndev)
 {
@@ -138,9 +195,19 @@ static struct sk_buff *netc_xmit(struct sk_buff *skb,
 	if (likely(!ptp_flag)) {
 		netc_fill_tp_tag_subtype0(skb, ndev);
 		return skb;
+	}
+
+	if (ptp_flag == NETC_PTP_FLAG_ONESTEP) {
+		/* The switch driver takes ownership of the one-step Sync and
+		 * queues it for deferred TX; the deferred work tags it subtype 1
+		 * and transmits it directly to the conduit. Return NULL so
+		 * dsa_user_xmit() stops processing this skb.
+		 */
+		netc_onestep_sync_enqueue(skb, ndev);
+		return NULL;
 	} else if (ptp_flag == NETC_PTP_FLAG_TWOSTEP) {
 		netc_fill_tp_tag_subtype2(skb, ndev);
-	} else {
+	} else { /* NETC_PTP_FLAG_DROP */
 		kfree_skb(skb);
 		return NULL;
 	}
@@ -317,6 +384,7 @@ static int netc_connect(struct dsa_switch *ds)
 	if (!tagger_data)
 		return -ENOMEM;
 
+	tagger_data->onestep_sync_xmit = netc_onestep_sync_xmit;
 	ds->tagger_data = tagger_data;
 
 	return 0;
-- 
2.34.1



Return-Path: <linuxppc-dev+bounces-25624-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29BDC5AC80
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2026 03:18:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hH5np5RC3z2xyh;
	Sat, 08 Aug 2026 13:18:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786159118;
	cv=pass; b=HbHRWWUU2V0HP70nnKh+BVRM1ctegfK3zcZekjHqkPE9V3vU6FRGe85vgoSxjrg5klcWOmYelVklPgEcuuLBegesK3HMUoGAvB1bY1adZwE6vGeENOw3gqE9CQGqiVDYhC8cQObp8wprp3mpTSmcinsh6eX9St97WMiOdQfzGVcV+q/AvjkL7jebhl4BtrWk1G+7q8HykDuEQWmnvtHP6TKkOsAln6E243PdwCawbDUFkjaSin/btm8aD3+0lF2Yc5+oGNgnDVSiYtest26p4YOhMED/eJJ3+zLvjKwa55X46+QxwJbU7pYZ97LUqD51SMK18o2znye/dY3I74J/Mw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786159118; c=relaxed/relaxed;
	bh=XXCljUM2bkC7Sf7DGrcy+76bCmL3QibJHvm3FWTg2Ao=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JK0QxbRTE/AqWu5B9seJBv7rXjlJhN73zo5MEzRYy4B2OT4MCI8guaK6fUGF+tVMXfi7mY35drl73HhkoG5Oo2Qw/9AXkrTp5CghC05uTP/IpN8Dug78dIMb1vzKd2OMRGZSb2nNeUxrT1BvjWwqniqLrX8OyqqIy7xwgZdliatA9xNzzi/Hi/3Z2FBUOzj5kb06xWJTG0TmDkCBWVXbIKVtQuxfdlM7GEqIyDR2nYvzzggaK1t1jMHlNEBsrY163ysZl0I/YEvfQYjxWz8s5bcvhCjrrqNpvQ+Afg81NoaUezu5Tq5jR8PCsOvUQq+cB8ZTOXFL/lLlKrgDNJxERg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gSpEwHn1; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gSpEwHn1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hH5nm71kZz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 13:18:36 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7PkaG+sjEB40ITjdkXAgEF4hFUuKfVsS8ez5KkToHWPwu3eBTRY1u/XydOmrkxU1CDlVd+lrFa87mR4q7AJofidkw9lEE2WJNahvuCTy5Mx8tdvLZxzsfbAb3QBOtxCEBAKHb3VIQ10MmXZ3Nsr4kedu3ULxpQpv3Z+Xrp/rT4QEaKTTjp3KinqL0hYvWWdvIF1VjvT7cGxEFnbV4bFy8JLmmIC6oiAAnBAJLrPW83ILnysrg0WOGiyvMWYg60j1JNAjFg4DdbRIlU3cwHtym2HXEM0UBLLh4lZ11+UU+//qYKJ5WGI+jkQGT6EAOX/CufGNmWdKXBJ1jhCBoFRmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXCljUM2bkC7Sf7DGrcy+76bCmL3QibJHvm3FWTg2Ao=;
 b=KL/wEel/8DxsVeK36XzvuDQkU11uKY5peiXCW7pBvH8/hcRWKVwsini5g04Js8RiNUkwJUO6H7UWODgLdlB7BDnnS85Mw/qk+gIX5owXLF7ZfZa+5vDJxdCztobIOdfBq2sEW7xd/A/16ifMx7blDIRqmWBTmZMhrNPPZcVDYXvKO7XlDgurYhy6CAlBF32lJdLVeGNmHFC61IdE/wiZxaVl5g0250htj3fAlGnwZlFezew4O19o1iJsptQbilQL2M0IA0yzBpQO4o8aZDx4w+N91OtK3GkGWBtPt7tBrCoV43ApBtlbA7DDACOpRUAi7Vx2XbVqFGyfhtmZJPDvOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXCljUM2bkC7Sf7DGrcy+76bCmL3QibJHvm3FWTg2Ao=;
 b=gSpEwHn1USwFSXuoaoTbpXG9pb/K7QBxuz7RjIbIFpDptxDl3VvARuR1kWeSVGXE6r7OVPjfWM9nJWHF70JJ6wVtLggoqB5rX4jXG7F90JLeSz0HM1at1aVcDy6ljxTFAeovOrYF8K6vPCK/0e1rW+1ZaOSKBX4i5FPaeciV+RUlDeay4JGnUK61DrxS0QdpO2vRtp8uiqFF8KI4f3IoHu8Chc4eH6qge4NB49iGhjgVDj9uqRB28rcAkoOpjsH2gojgJA8mWJn2ThwC3/28x5z5UCv8k7rZ9Tw5sxFpgDTJbOS06YdaVeGfHhHWXDR6pFxGg5O0V0lnkjWA4UbIAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU2PR04MB8936.eurprd04.prod.outlook.com (2603:10a6:10:2e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Sat, 8 Aug
 2026 03:18:10 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0292.022; Sat, 8 Aug 2026
 03:18:09 +0000
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
Subject: [PATCH v2 net-next 0/7] net: dsa: netc: add PTP support for NETC switch
Date: Sat,  8 Aug 2026 11:21:38 +0800
Message-Id: <20260808032146.2335723-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: a8375c21-f414-4530-a950-08def4fbab09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|366016|19092799006|18002099003|56012099006|11063799006|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	edvqmU2dOI6+fOvuD3kdX9TYHKcnY+Gz0jbjh+6rtGWjHwU9dqMZN8B4NwQYrpEDXiSaZX84K/IJTPedIU8sYaOTxXjL7G9VoOUXMQc3UqnHgAcD5B+z6aiP8tZtA/d9OPR5Cn+c9L22i8So0LFjIE3LBhqBSJv7HyJBWfv20APg0XlhCoz6M3KsrcYMKmTwjOV/5dFR+hj5i+h3lTod731dR3nteRJ48JSCeORlxi3h3nLkiV+97MkhoH5pUlvTYZLw4PbTAeruWOfz6hdWodcUPqp1g23TZnFsGmmRwv0OEfH9D5n52wibKQzHME3D09uy2B9g8MvdQt6MTNOZlFL/1yT8qXLgGYpd9onU2VmvRGxBTAqphoemMWE1a+hzWXS7qSmz0tgzQSkpMvV56TdjaMuL1smjw8fY5pB9z5jFTmmZEx8iPxueItv2CpI2yoNxGSkrxxPxMFVFS3AjaqNb9N8IEW5zNMYV9+AZlIjVwGCm9f/C29caixLmCjGZGE7suIWoHL8SFLimJetjyjYiq8qC09S9y7+OIsOAB9RJgrHZogajQJhaCMWCWAhcZHnOZRcvaU5jnkhAql3zANN7Kzo0ELVKdaYhx7K5Li95cyvvYcevf2kLgcs6Y7eJy+wsNNNjtlajxssOryRih2DDo38e9ugz/ikWa8gOYOO980Sl5WK2Y3xH2XMc8Jk+na41kk9ZjNvBb5JYgajT7g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(19092799006)(18002099003)(56012099006)(11063799006)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZmZN0+eMAk4WK4l0SmgjG5nT3hAvo37yJaafPWKQVP2Qd5ACrs3DtdBWoZ1S?=
 =?us-ascii?Q?Z2Ay0tMCkxu8MzSwQrgIK9w+Q7vbk6Fg1PUQxAbNUlGhbQm01Bk0reYNmwHM?=
 =?us-ascii?Q?VedmICpKG6m3kVx9zvvQsgS1pDI5U+hH3ebueeQhJo3ej7pVbrF0/7wE+YXD?=
 =?us-ascii?Q?5HufMFI8c28T9XGeTMhw6kRQQ0K3Ioksw/bxSlgtRL1nWinwjS8L6OvLxzLY?=
 =?us-ascii?Q?iXK5TzM4kfJ0DwzSzshmA8jkRs5ahqlT12MLrwwQh9XlqLQHuxaxeOPIx0J5?=
 =?us-ascii?Q?QeRaVZ+Erm4iwwLaFzoJMSzNjmUa2LUMiEiAo7RGh9pZ8UIRGDm5fMmu8ho4?=
 =?us-ascii?Q?X7/Hj/mTry4nlcnpe9XBhtPLupQqpOzMtcVgJrm4Tp1cMVhsVYDg9RRN3915?=
 =?us-ascii?Q?Ls4VgwfLlNBjMDIo5qcgVJ2V+J418z1L/OWtbwE/IIAr2ypI5dtMpmj186N/?=
 =?us-ascii?Q?jIaKBwm5nVoNd0akgvpyKGEXfNjPMhmD4PBCGoDFLLQfNZ/g88v6Dg/tRlIT?=
 =?us-ascii?Q?vhNHTS4hCyHl10YZK6bZqABkUuph0u1f0FKWpMGDygODVwu2BG3/3AiBnKJI?=
 =?us-ascii?Q?aDP7SLXi84E97WDCoNH/tqkGgHp4mexWLGb4ANqmoFi+xV7ZAFpU+LnUJTG3?=
 =?us-ascii?Q?ah1I9aWu7lAWGRl7dIsqSDcEXAeOiUuYau1Ef12Nba3tjs3GTU82zo0r/+Sp?=
 =?us-ascii?Q?G8tdUf3JHKXSaLYjH+2qa9Jcc3zH2HDXnqI8uEyEnnvarkzc4byETfNKbfgH?=
 =?us-ascii?Q?ywum0DWojvptDXjhWCQxyGenmZUxC6AaItqfzhXm0LHwlCzONmmXLVYGnPkO?=
 =?us-ascii?Q?IGcG4CXC2PLS44PeH+w/FQm21IP5tbCZcQJbxlhB6CO0jR/QIJlssR6Nj0QM?=
 =?us-ascii?Q?Q2kYjy5cJOPeZejMdE3u7Uakc43sdJzUcL0fL2qVl/3d5cXWgtxyX8pA2r2A?=
 =?us-ascii?Q?ZFLdPMqR1JRUR9aG8LoTpluflKVX05cL9k5Fj53+tRRuXI36EYsTtTqunBVK?=
 =?us-ascii?Q?4651Qv+8nzrlep8Ev336hW1FU2fzB0wK88svDtcWM4l1PIoh9y4godLKqITs?=
 =?us-ascii?Q?fron/5BqtcUAIFHJoOWnWiUAvQ+f/4coh8ITI0wZsrH7fkK6yUpJHpZNsa7r?=
 =?us-ascii?Q?F6w38YbK0lRrwUgtuHGAngUlH2u73CBWKTIfpjLaZXmk+4nERgl+sp6xeJO1?=
 =?us-ascii?Q?oVHt65D2bs5d+5Kk96Te6NXUrmKBqk4+1FnK5ZpwAlUzgIa0iBCVt3HcUxcr?=
 =?us-ascii?Q?e1mGSzWk7+urDx5+9n0QkrnGR39xGA4mCSdkIho77zHDJH/gnogXjkzbyNsp?=
 =?us-ascii?Q?enbEMSauSbpRTYFlcBTYFDqAW9yLexzKDwWmbbtlPTl5l0Z9W0zSywocaqFy?=
 =?us-ascii?Q?r3KTId9bpv93UnCtlRhuFlkEC6x/lqSG/ZHscR3UuZ6JCAmh+cjPxVokyzCs?=
 =?us-ascii?Q?wsnmxD2jNgnGRUOymdErz+TrZyoyXGJqYaNokAG0tg9YtZ7yIj97kBWQNfcu?=
 =?us-ascii?Q?4khIdT+/kBZ722BSsc+xuxbElHMxN0kUkfOA+On11URzFATB9XgUPquhJN7H?=
 =?us-ascii?Q?kNAtdCgKvJWLrp7PzOKmfVWOOZOA7kZ3Bs5I0qxT26Rqu8Aebgc3V7MKBwno?=
 =?us-ascii?Q?78DtB9Y2dgm1sCfpZAi8M5mb9DWhSM7QEdl9nx5DSYm7cth0AjN66h0DKC5L?=
 =?us-ascii?Q?dcrf9m8NoA880C6+nKIQexvIA9TG/dsA9MLQ4IEs02RqmCDOQwjqM8e58fB8?=
 =?us-ascii?Q?1f2hgQvcQmsaLUTZSHid3c8rZTF9GN8FQmQJoy5wIIkfRajvTwBN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8375c21-f414-4530-a950-08def4fbab09
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2026 03:18:09.3405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/QSMsBHC+XsK5EE7jjtXSqNCpsKmyD1xtAcoXPQOEaMN7kH+Xnni5/9VO0bYMSHz/Bl8hkROR7oihPNkLsAgE/3a1xwIN2eabMIJ2qRySWV+iZ2r3yurWsHjQ0B9dok
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8936

From: Wei Fang <wei.fang@nxp.com>

This series adds PTP hardware timestamping support to the NETC switch
DSA driver. The NETC switch has no time registers of its own; it shares
the PTP time base of the NETC Timer, which is a separate PCIe function
driven by the ptp_netc timer driver. The series therefore first prepares
the timer driver to expose the current PTP time to other drivers, then
builds RX, two-step TX and one-step TX timestamping on top of it in the
switch driver and its DSA tagger.

The series is organized in two parts.

Preparation of the NETC Timer driver (patches 1-3):

  1) Convert the open-coded 64-bit register accesses to the
     ioread64_lo_hi()/iowrite64_lo_hi() helpers, wrapped in
     netc_timer_rd64()/netc_timer_wr64(), to reduce boilerplate and make
     the access width explicit. No functional change.

  2) Drop the pcie_flr() call in probe. Per the reference manual, function
     level reset does not apply to the Timer as a supporting function, so
     the call has no effect.

  3) Export netc_timer_get_current_time() so the switch driver, a separate
     PCIe function, can read the shared PTP time. The helper is declared
     in <linux/fsl/netc_global.h> under CONFIG_PTP_NETC_V4_TIMER with a
     stub returning 0 when the timer is disabled, so callers need no hard
     dependency on the timer driver, and returns 0 when the timer has not
     probed or is gone so the caller can handle it gracefully.

NETC switch PTP support (patches 4-7):

  4) Track the host flood rule by entry ID instead of by ipft_entry_data
     pointer, freeing the descriptor as soon as the hardware entry is
     committed. This removes a long-lived heap allocation and lets
     netc_free_host_flood_rules() go away, in preparation for the
     timestamping rules added next.

  5) Enable the ingress port filtering lookup (IPFT) by default. A frame
     that matches no entry is simply passed on, so leaving the lookup
     always enabled simplifies the logic and avoids tracking whether a
     port already has an IPFT entry, which the RX timestamping rules rely
     on.

  6) Add two-step TX timestamping and RX timestamping. RX installs IPFT
     rules that redirect PTP frames (L2, L4 over IPv4/IPv6, event and
     general) to the CPU port; the hardware prepends a To_Host tag with
     the 64-bit ingress timestamp, which the tagger hands to
     netc_port_rxtstamp(). Two-step TX clones the skb, allocates a 4-bit
     request ID carried in a To_Port subtype 2 tag, and completes the
     clone when the hardware echoes the ID and transmit timestamp back in
     a To_Host response frame.

  7) Add one-step TX timestamping for PTP Sync frames. The MAC updates the
     correction field in flight using the per-port PM_SINGLE_STEP register,
     which is a single register that must be programmed per frame, so
     one-step Sync transmission is serialized per port with a per-port PTP
     spinlock guarding an in-flight slot and a deferral queue.

---
v2:
1. Change IS_ENABLED to IS_REACHABLE in netc_global.h
2. Move spin_lock_init() before pci_set_drvdata() in
   netc_timer_pci_probe()
3. Add device_lock() in netc_timer_get_current_time() to avoid
   use-after-free
4. Remove SOF_TIMESTAMPING_*_SOFTWARE flags
5. Use READ_ONCE/WRITE_ONCE to access np->ptp_tx_type
6. Clear NETC_SKB_CB(skb)->tstamp in netc_rcv()
7. Set np->ptp_tx_type at the end of netc_port_hwtstamp_set()
8. netc_port_txtstamp_twostep() return type changed from int from void
9. Add netc_port_purge_txtstamp_queue, which is called in
   netc_port_hwtstamp_set() when HWTSTAMP_TX_OFF is set
10. Remove clone from struct netc_skb_cb
11. Get ts_req_id from skb->cb (since clone is removed from netc_skb_cb)
    in netc_fill_tp_tag_subtype2()
12. Change the return type of netc_rx_tstamp_process() to int and add
    pskb_may_pull() to check whether the Ethertype header is in the
    linear buffer of the skb
13. netc_get_phc_index() return -1 instead of -ENODEV when priv->tmr_dev
    is NULL
14. Refactor the entire patch 7, introduce struct netc_onestep and
    related interfaces, such as netc_onestep_get/put/release and so on
v1 link: https://lore.kernel.org/imx/20260728104548.3301214-1-wei.fang@oss.nxp.com/
---

Wei Fang (7):
  ptp: netc: use ioread64_lo_hi/iowrite64_lo_hi for 64-bit register
    access
  ptp: netc: remove unnecessary pcie_flr() call in probe
  ptp: netc: export netc_timer_get_current_time() for cross-driver use
  net: dsa: netc: use entry ID instead of pointer to track host flood
    rule
  net: dsa: netc: enable ingress port filtering lookup by default
  net: dsa: netc: add PTP two-step timestamping support
  net: dsa: netc: add PTP one-step timestamping support

 drivers/net/dsa/netc/Kconfig          |   1 +
 drivers/net/dsa/netc/Makefile         |   3 +-
 drivers/net/dsa/netc/netc_main.c      | 183 ++++--
 drivers/net/dsa/netc/netc_platform.c  |   1 +
 drivers/net/dsa/netc/netc_ptp.c       | 866 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h    |  91 ++-
 drivers/net/dsa/netc/netc_switch_hw.h |   5 +
 drivers/ptp/ptp_netc.c                | 110 ++--
 include/linux/dsa/tag_netc.h          |  43 ++
 include/linux/fsl/netc_global.h       |  10 +
 net/dsa/tag_netc.c                    | 214 ++++++-
 11 files changed, 1428 insertions(+), 99 deletions(-)
 create mode 100644 drivers/net/dsa/netc/netc_ptp.c

-- 
2.34.1



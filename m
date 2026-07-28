Return-Path: <linuxppc-dev+bounces-24926-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D106C54EFC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 10:42:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8X944tm1z2xyk;
	Tue, 28 Jul 2026 20:42:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785235352;
	cv=pass; b=IH0DH3vaWTjk38NYuE7uL6RaqbYn/sKvcNr5/FfafCIBz6MS0Oin/AyadwhERlGPCgkhXvHxhclQg+dG09iXIo7tQ5m2Odm0IWkU16UsLPuu1F/Z34J1BPbs4VsRyaXm9SfT+2eYYI1g65Lldrol9pyOd1ozP8Lmg524uuR1ztWI76GPcd3bX+RXtu9BaylYe2w+pyvUvgutjAgmTtuzErBGkQHtT/rTBQnNN4kts8EB7AsNUPPZENhGiYt7G2fF5hBGlOzfBmzHS7AwLWcC7KCZn3XDNwX3A5eZbM9cdtaFG/VlLYEmAc1ZrEZTv+0UP049w7LmTlrRwSkpTxpLwA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785235352; c=relaxed/relaxed;
	bh=BT3wuPCocpfi1iaj68+sMtkg3RuwN5M4ai11tGNyBYs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Niuq6xEEK7jUx5q/Hloc0EOs1z4ETDHbKqEUb9QSHtQSySIPzcoeOU18NVH1mud40Fwjrr6jO+yZfP5PH/51HacHrsOUfjCyYwzz0JYKIu6MGBIponTHiahGqtAKhWYLBopjhP1EpCyaVT74t7W8kGe12DDjh7F4kkrY2D5Cd3v7YhfA9ujCG2FH2gZcywLqBlLlxUvRZO8fv+4jlv5UX5VNufmcgYQaRstiL0uD5Z3dviJexW38WW257LiccuLDXB0fEcKhkNhgZx93fFwRr7mjpvyHi0D2a20hitfuUYDaoq/m48DDNXqbu+9E4alOxVc/RMLEXs6O5csucFbP7Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DGVEq5A1; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DGVEq5A1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8X9343C7z2xlQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 20:42:31 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSQHd0zm/tsZl3GZe4ETUrDzmqx8WBo9YcfcaGkY4mUVlmR72I/l+XJR/Do3fLo/u65ZpCHo4QriU1jzH/LXsORFeTLxSNz6uuJHKoNdkSWkYnD2yKkHEkr+Qesszk9LFMxHX9aQfRVy3+W7Jk7fY4eaakg7XJO2YT+cBpl6Yf0ymolOypHW64PckX8VixAtsS9Z/tZA6zJE/NKRmwZ4elSIR7KtTVZCi3si3M+8qD3EBneYMoeqNGfik8sdvkgyUT5mjR4ZwE3c1C/7IZoDLMQRex4qC175KRnqPvZpKXttEwxQfLRtkDdlKBtFLr2tBoNY435HttaJIv9XfcfJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BT3wuPCocpfi1iaj68+sMtkg3RuwN5M4ai11tGNyBYs=;
 b=G1fKREojBVydhDaTMKVYIxv+CoVbGO7uuyOcnBtR9rXpDzD4uyITVvOHJ9MFNbq+5FleDUJPxIbTHgHO/cteFBhL2nHqXDP2EqNjvNirPHf/qoU/Sjx5rdgTOkQNO7T92wqxNpNH5/H6quPMtlur5Xs4HsFRZVve3LJMcf+HOYG70n7hk+2nBcTdiZ9q1gb6qoKL8Op/I4GLxLSO6Jhmt0KC06Y+3emaJcJRltrCTj0UKUnOY8EWz1yQHPli6XgLq5aytaqOy35DNb8KzXcUZNqvOpnxx52b1qb4tK0kdVxRar/QdiCI1ZWH2dSGBf8Olqzv3dRzbvxaucvBg1Reww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BT3wuPCocpfi1iaj68+sMtkg3RuwN5M4ai11tGNyBYs=;
 b=DGVEq5A1CVdCcA570691MLNvRNkCks6hkkGZojPS5dQE9m23bPLBKL2+sLxPRKsL8anxweT0YiuIJ7M+Hp9UtyUaKi3ldZKayGXmFx/QGclp0S2o1T9x2nmaRA3uWYGup9aC6vil5W5SWdQELjD54F16rFj6yjnWISpWkPqRes7KppGkw8CgKhRlZV8/vpJHlLiwjHmrjaS1D2vXw3+hVgQSDyvteC8hyg2XzrF4uxZ5kjAkBHe3uMFqasDTcBRElPKTWx8l/h6rLkCKkY7pYDsIyLvCqHVPyjTAJIIONUYRAOCcfRXr/kPfoUjwwhyM9CFTv6sMZjld23wAHXQP2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by GV2PR04MB11835.eurprd04.prod.outlook.com (2603:10a6:150:2fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 10:42:06 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 10:42:06 +0000
From: wei.fang@oss.nxp.com
To: richardcochran@gmail.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: wei.fang@nxp.com,
	chleroy@kernel.org,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 0/7] net: dsa: netc: add PTP support for NETC switch
Date: Tue, 28 Jul 2026 18:45:41 +0800
Message-Id: <20260728104548.3301214-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::7) To DBAPR04MB7207.eurprd04.prod.outlook.com
 (2603:10a6:10:1b2::17)
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
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|GV2PR04MB11835:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a0de393-3861-4cfc-d587-08deec94de17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|1800799024|7416014|376014|56012099006|10067099003|11063799006|6133799003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	RTkmYBLVYC/H0LktXtpBl22N04edRoTLyiJx8Dvpe5HmeOjMNIsWhOEoKSixmDCfiBCJLRJcmHUNbe7JZgDnuhVBdkmAii+sYJLNbDhdueQTVOGkAcpwsDB4HZvbVNyWPQCOxKR1/dJS2C9YYz28xAMVL3xMYIPNcqstWfbQXvrP2b1aZPyJjrh4h5n1mZ8qQyQVSefsMfOpIdGKePPimxrZG7ovgEcOH0c+mT34WJGxntaagMukiKlymeQKFqTJVd4NeLuEhcUjpS0lA5eTwByFg6S9aWeYaO9t6ps6qel49ueXvjNJFMv7tBtQCI+hUq/zC2UN+Hyhd7aPxuT/DtSgY30rda65NGhyjxcPBbNYc6InMFc1bx/2Pqjsozqs6Hqfh68cUCf6JV9nCazQznTJj6JvapJB2WZ2lZaB2lbwCTWaZnyaZ6eb/DatvnaMmDNyqj+TLX7rweTHo02mCTf9EaBVWiZruRXK1jbowkUXS+8bu8bs/xtusH4zu2OfeYoPMoYtdhosDvuKf2X7xOYGvGHNBHFrw9/7PFkeERUnrjzdVlJlUyILwSLVW9+nj73ks5DzuZkEZkUZyGct+RmCXbe6qI4E54tud2eQbVdKBxyk5AlnHQhhlaXcY4IxSzj29WwxuyXI3LJkQBZPzDlz0DVxUZPuCZhUNhcuCN+7cDoM8HitWzt4zoc5lIFIxqgdtljaCRVybYr1qGqq5w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5uIUsLl4iXAbEnDXVOP0/O5WsM6MotPDg1jloCf+gbgd/E0tqLvReyBLVKHe?=
 =?us-ascii?Q?nuXozJgRQO1XQpYpEOXmFPEwno7DfVhnqaj5AD+et5pws33EcVrgOtcm0pPv?=
 =?us-ascii?Q?XVpZVvdV9OnsiDP8EVDw7dY9oHKSLq2zAj2RBvFv7MSjcErX2W9IMAdjmuTA?=
 =?us-ascii?Q?Gn9jmd3iEAeDDpjU+eN/A914C8mT2hx3fWsj/0urxX/hsUkj9YQhckhS0c7P?=
 =?us-ascii?Q?/xLeIzxSuwb6pbtiV6x/6VcwY8RTmAl2dGTq2qch0U4p7v5zadOgnonUUZDq?=
 =?us-ascii?Q?TroeiIcM94HpdYjbYpJEuff/4xjB/78OuKXPSQQV5BM4nuUnqCNbPDNFrklF?=
 =?us-ascii?Q?WYW7YiWEFO2gIXDTIxli5gYZ0RwwlKYr8nyFrWWtRkoaDrEJPe8p6G5bSWha?=
 =?us-ascii?Q?GjHbtLSBo9hyqeYgiQdzcvDe9G+4x7sY8sGe15ZT9eo3iD19sNCoWByJj0mT?=
 =?us-ascii?Q?YFqYifCo6knu48hfvb7qVqXFr4YwL08Fq9nyXrg8a+H6BP61pNFOUhwD/IfO?=
 =?us-ascii?Q?ZsYI9J2+mKrAaEEG/iXSsqLF0em6mKA1d6tW6blaAkXIc7VA/YN9d18lHvbn?=
 =?us-ascii?Q?ZHCsPfKJN9VmYPZmMUQEtBZkRWAFzg7XtRxNc3wsk17GpF+M99jUpuhT9gQA?=
 =?us-ascii?Q?j0ErmmU/yB5sjWJ/BQfAhkG3JYPb0yXvWNJ6IZlkkSnQJYegCvXwy9mFyZm9?=
 =?us-ascii?Q?jFo3ppr5i1B3jIjxCN+51+F6j1MWVX3J4K4wwGXvDPLYNtm3mOXkkXS+K2K9?=
 =?us-ascii?Q?FFGXZRN99bLopBCwuDOT5pWwdJICBpEN3LaddQ03DIZaxjMnQP7UjyqOBjjm?=
 =?us-ascii?Q?uWA8quNptkB59d2cRTXRFb8G9FxkKBTjGm6m6pfhMWmk9qZpkxQEldXobRjJ?=
 =?us-ascii?Q?rgWy34piN8If53a6LDHKbNl5aiqbV0TA1ZvkTgnFezdBJKwSJvbpPpdCtyWW?=
 =?us-ascii?Q?61i1WCep7aq7qqhF87UxoyKKgb63pfB0udWONVv5SQop6M25QkonTJPBcDTj?=
 =?us-ascii?Q?PqJivEg0+o5OuWi/SEgZ4dmdWzEbp+UwqG5NQ2ZozrXK1zJfgPlHql6atafK?=
 =?us-ascii?Q?v9n3BamWTkvVag0sDdrJ+EWSeUpFHxyDb9I/fgDzLY5hqOdu3MuA5rN3IjlM?=
 =?us-ascii?Q?t0a95pJxpe1cSIw4cwMksqqp41K6MP9PNU6pDAXBFPcQclkS+jr9ubZBfB7n?=
 =?us-ascii?Q?wPzksxqNZ95xL5Ikm9z0JbeNzjhRhYz0JkyUWgd+p47bmpC/TvgsXa+7lYOz?=
 =?us-ascii?Q?uJPA5aZFUVVN4pA3ETE4P0KxHUlPwUcxzXzKjIlQrqxQORnTYC5Q44S1nyqI?=
 =?us-ascii?Q?jExI1mzjPlVvDVqu0W76TbfA32uzhNTkZi0k9StLNPnBwV1G1B8aM7t98zIU?=
 =?us-ascii?Q?yay/YcqMmN7GhgGUDFx+ghm5uhSW0rh+kmnJtzlrBXbN4oR0CJ6pkk8uPP40?=
 =?us-ascii?Q?LHUjLbeicnOfwB2s6Iyq0xXRCLGG05xO+e1LxzzDsJ9U0zWcMCQHepHS3cCJ?=
 =?us-ascii?Q?IYQIlaqTfYvF2Bc3v5fWxwyaMA5aQgsMEJY2zVHVfCdwr954hWeq8v0ZTpqC?=
 =?us-ascii?Q?y8ra0pgZPaDTn4/aWRQg2nyJLrNEa+j3INPM4soxg7sBAWjW8HGFEtEMHrrF?=
 =?us-ascii?Q?EqMl5V1wmpeI1gzDGzFz/4O1kgUOZeeu1WhjSrBXSN8gV43BKoXbPcekRi8q?=
 =?us-ascii?Q?06ezBZOtaDsypeenRLnsqcqE80Fu+LXkNVv7gxrkazDNFM29tMjmFrhyUJRa?=
 =?us-ascii?Q?9bvHYXTVL0t8Jl7DuvQPR3g6zdZcjplmCS4DxiT01wtrzANWbh0e?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0de393-3861-4cfc-d587-08deec94de17
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 10:42:06.1234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWAT2I22Kq9DZz0yeOlnmnudTiucXdxvmJ4szBHkE79xqmKksE38FpeMW5XQLhdZYln/ooSVCK9bGr5Luh4u/obPNI/4T4Y4KhZ+vQ26M6JK8lCgqpa/rBOpCnSHh82G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11835

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
     spinlock guarding an in-flight slot and a deferral queue. This patch
     switches the Kconfig dependency to PTP_NETC_V4_TIMER because it reads
     the shared PTP time through the helper exported in patch 3.

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
 drivers/net/dsa/netc/netc_main.c      | 135 ++++--
 drivers/net/dsa/netc/netc_platform.c  |   1 +
 drivers/net/dsa/netc/netc_ptp.c       | 663 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h    |  49 +-
 drivers/net/dsa/netc/netc_switch_hw.h |   5 +
 drivers/ptp/ptp_netc.c                |  86 ++--
 include/linux/dsa/tag_netc.h          |  42 ++
 include/linux/fsl/netc_global.h       |   9 +
 net/dsa/tag_netc.c                    | 192 +++++++-
 11 files changed, 1091 insertions(+), 95 deletions(-)
 create mode 100644 drivers/net/dsa/netc/netc_ptp.c

-- 
2.34.1



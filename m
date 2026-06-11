Return-Path: <linuxppc-dev+bounces-22444-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68055CD98C5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 02:13:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbR5461SYz3c3l;
	Thu, 11 Jun 2026 12:13:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781143992;
	cv=pass; b=NRsuapDIP9P0DGWqI0+tPtCoI7eS1hRDCC5da5xz6bVKD4I2rnbNHhwjLlfXiq41Wj5uSp/wavCZ3mVW6aX0di6bvyKP8aiEIn2jxPfwEEc2EZWlM6z8OcseMP0faicQC5DiIsifz1sOhxvoUU5Q+0wvt3EgopqDf/Ip3Tr8uXt1RlMPJc6PJYdGlb+/kKbMVMlXj7Qz4k+MZRguvgWU9X1g2+l6cCcWRRpxMaViU0BNak++yTczt/FrtEAazNqR+cIY6bRh46h59SPpxa3WCLxYhFS89baCqpQKRDO5q+YR/yQj5wujIh7E+C+7g4d+rZTwXXzGRnwqI68+vUbbog==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781143992; c=relaxed/relaxed;
	bh=iF6TkmFRfaf5l6HR+cXFQg15y2JHC3YeysGsx6rF12Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VwHnD1kzIsYoMDcdRW7qze6pMjHknYgJLVPe8/Ya5paylBFB/B5A5fc47L9x8kJB66q812CB/AxiYjlrIAUf1XLWKJQnZy6BoA5kksArOVUZnMXDineeV66awPqCtV8DEnJXvewA+84wsFqvSPgwcVd2S8tgarQwqZxmFv6yD/K/Vjq28u6qQuGQEcTcGvwvAOF7Ir8T9jKzb/AzCllkCa4EuyEcv/mJlL1UyaF6MBaqw/qeHbhFKTrT+01UTdij7TeUVFGAfDV+zezYYrqYk/srz6uXilyRmn0kkJwuouQ9f17aYMKnObhu3s+lgaEoI6HbyD4mSF4KX32BufmR4w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DfOgWwha; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DfOgWwha;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbR532cnTz3brV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 12:13:11 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwAYVycJlmQOjwLAptknS1L02yF8auSKIwOzVUVp2yBksWlr0hFkJZNHUo0mG+9OP4CWZ4bqw0LncqSrgnjSXEH1S5IUeSjCrWLwsuTIM8QSBUOv8lBUWkUMSoiuqNBkjMpmPiXyMXOtiTtZJZLgj09edvX/vvOBXUvKinYhoTpWDIV8rVVSH4VAcT4oc89iJWyvowzZn4QTZlKYIFzHsoC16NpX9xuEcP/nvqfptpoI7hTbuWgpAWT8ziH3fs/Bds7APHwv6nhEngakbiGo3hieEisGCv3iSGj6Td34ERAiTNs/Wb0SUejT8Qr/uybL5yF+b77ZZbs1jf6h9+yhtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iF6TkmFRfaf5l6HR+cXFQg15y2JHC3YeysGsx6rF12Y=;
 b=JKCfbMGQtbvdYp7aRfdRljIahL4FeVk26MnjCs0Z7TBzKFGe71uyghITT0ktA1xZjfQK5ra1mQTQRmlmFFJjIfRO3dzX+Gau9IcQSN1y26YIDfhdEzEXq4VyVPD5eEANeZ10vdsT2s0laG3kHZeSvs1RUrsub0CNvxLQbEoILOudEYXheHrrWoi2GpFr8JoIajoeh8tnj1DXu7U1xYTxJVj/4pXJvFZfIGdaSyYjzD8YSwHIxNj/OthAky3Id9m73D/vBsWsivD0UBYnjKNtEK08/ZWDkpTiC069eJJk8Vd+KOQPlvLwP9/JqtB0E6TdQ6CD1EzVYz1vkGue0/Wcbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF6TkmFRfaf5l6HR+cXFQg15y2JHC3YeysGsx6rF12Y=;
 b=DfOgWwhaMpNVpnhJaPd2yGoUy2y0T643r5nhm58VTO+aWDvjkc9NhFm8PqYC1k5aRQhRW6u5Y7AKCEjJ0odj+MKzixe3vHYuWmX7A1RJ1z+G8fPxk0XwsKo6xFuPQFymhFKzyEMfBkkuOvlwmWio8GumypL+T8LBYLWYEZuLZXfWxbwTthzdSvWH/hgOi2gflVtzcAdJ0+kcPZMx15+G+X2efqRbF2wFdxfkAGtWGH0+B4D0b9o5iq5qean3PS+/K5sriWPIgWcQgd1KJeEPUZFUOziAsnQc+fmFIg9vHv3tqq/gONnEHYv6VGuVSWkyI6KOfCT+9m2OtzpZRhpxuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PA4PR04MB9709.eurprd04.prod.outlook.com (2603:10a6:102:26b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Thu, 11 Jun
 2026 02:12:47 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 02:12:47 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 net-next 8/9] net: dsa: netc: add bridge mode support
Date: Thu, 11 Jun 2026 10:14:57 +0800
Message-Id: <20260611021458.2629145-9-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611021458.2629145-1-wei.fang@oss.nxp.com>
References: <20260611021458.2629145-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0246.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::13) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PA4PR04MB9709:EE_
X-MS-Office365-Filtering-Correlation-Id: c09dc22d-f065-42c0-3938-08dec75eee3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|19092799006|7416014|376014|1800799024|56012099006|921020|3023799007|11063799006|5023799004|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PR3AQHfDPv8djRItOogp7AAELXTkHyQ/GAjDEkX4zd72gfbN3mA9MZzPM/t7SsGGU6Gj0LoD5aJdZwALo1YO/m5S8sVsfbs7ZG3JDkvddiEBLQU6qEBo73NE8TewBcqyDOw70fOa7ASbTW5iPyCdBCdcGnm6odOrYk4rz+obp4wQjHc/6B5+FcrE2muO/Pmd8EpbW1xZUmhElNm1WkKBzoUMOf/FGPqjAOM0wyT1R7s3wuMgd3beuiDQhxQfDWQpEKxpRE5JT3vMCfazVeXHEZXvUlGXc9BdH2GA1HI6pS08eVv5hM565z0G7p9O2534z96e7Qup/pEvdZ49aJIR00ctCArIxPJFFKZYHJVT75/BlnEMOqsMaAmbJdj2thQahisvI+lEnRcQdPiPv+NMWkU+8UMdz2MkoSdaXioQ/NiRR9EXqQv6/jg1djP5/3LXqDxReKmiaSv/WwILB5osXz3AkLYSAZlgveqDqWM9vRup0saSoILfvVBr2KvndvSKG30uFA9Ox47AykED1je3hC3C25n82Y78y1lqwzUbNNx5+sskvuHnnZXzudsTzphIryNvxEKnVIexuwREMlFN4FladWjTpVAOBcZjf53oiMt6PiDSCuTwyDQq5aixXvZ0fSQa6g3ZCVCgoNTODILTHiADoA/DIgrmd/5NrZh22wN2zWUpj4Gvr6U586xyqiG8hd3nfvrAONTfwaSzus5xpdyrZdICQuVKQJNKL0QgEVk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(19092799006)(7416014)(376014)(1800799024)(56012099006)(921020)(3023799007)(11063799006)(5023799004)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jpoyiCt+Nnjxwt7IZa64yQrX9Wapq2F8I80UCthupGN+qIg6CHBEiY8B+Us0?=
 =?us-ascii?Q?RMJD9fI1Ovpx96qjzpcJFIPc1jPfTIvzzbXD/TfYaZtiPFQraac2ILM0Nn7+?=
 =?us-ascii?Q?DVV58YL/Nmydgtec2E8/CoR7oC1ZYfMXcKBhjPAuEWEWvCMKaufezmU5dWNv?=
 =?us-ascii?Q?JeF5lXAROHtjOaaVccQHAg/AM0b3WuSeHkGVmnDARBMCpmajrXNFeYe8/sa5?=
 =?us-ascii?Q?pW9TpwsWY1kMt8tlK0N16UJtH31p/Wdanf16LJisvqrjlwn59VasMqn1LE1k?=
 =?us-ascii?Q?JBmAWA7N2QCph7YPFl9y4kaISs2fOdeFTjxRmaOtjy7WRSL9U+vZTcrC99F8?=
 =?us-ascii?Q?GQpOP0IZM8hvpEdoEXK+EjC7H0dWbVVjCDXPAQKK4gmauavCjjbrQTPPhiPo?=
 =?us-ascii?Q?2Tl2lQEru8AgtUz/ZMeApLcOg9Mxd1Zr+IInAd/AY8CR6RdDN8YQaSrqSGXi?=
 =?us-ascii?Q?PYn9h1KbA0mj7uWtZI31tEGfV67d1BSh5/TK2Cs+h/QvcsedO3iBpCwP8pG5?=
 =?us-ascii?Q?A47ViZccl5ITE4kwUaMyxuhAgu1PbITCC6CWmFjSPtK5lpDPk/U87+KLBHkB?=
 =?us-ascii?Q?NpvVj/48kr0cCGAM/zuPzlaOKbYqCqcrTgYLCXzEdYof/xlIp29w4Cng1yrL?=
 =?us-ascii?Q?7bBIPBU+AZBWrX4gb6gttvG+SYQzaQvHfiKH1ZZXepTiTrmYd5tHdVGPlYYt?=
 =?us-ascii?Q?hKJRHkuBdrQVYzfgLL3PSmtOvYkrvqNSQpJ7q5UDJ67IhMdg9BQyOo99gy5q?=
 =?us-ascii?Q?podnkFSB5F7XCGcPsuhHxT6HQFjVC+UFOkprXAfqqnoBZKZyjO3ZWwdcD4P+?=
 =?us-ascii?Q?qL0B/gNizBZ0rubGVvHTApIDVoxmHMKBSmtzYrVk+aLSvcNFEQyuaLsHlKwK?=
 =?us-ascii?Q?0o80YTOcv5PHRQnd5COJZxENi0xtcDS06D/2fK8vleFTa0ixdqnxRZLZsUju?=
 =?us-ascii?Q?vPYbu6Dv4FfXBrVPD6RzDjJctwlMgeDNOBu+Ixxy5XTcWIJJBmutEX6cLbrL?=
 =?us-ascii?Q?VmWcqvCUwDhu8c5fEJsSbOU1mGThxMkpl79wv/MTV+pP18hSebMEm+v6bLtI?=
 =?us-ascii?Q?GUQijKRxnVSyD7fCUGtSDX79sBc9SQytdS2omXFdJECRXhHACIMIDb4OZiu+?=
 =?us-ascii?Q?mrbIwltasZ3DjSSx600hkD4Ft0HDOJKVVtvjsFdk3nSYqryOWWF6xvo+9SKy?=
 =?us-ascii?Q?cjVUvoSZ7OBq+2TBrGr871uVpopOFuwY+eitqgFM8Rvompu6p7qr+8TIQeFX?=
 =?us-ascii?Q?ifxgUm5KZyl/QwJ6EYj2QazSNWlCaI/mkLaYyxhMjzyRxpf6Xkh62hCL8/dq?=
 =?us-ascii?Q?ZYWkx/C1MNxW/+79+wwaYKiRDsAOEzhQ7LiMETpaGRV2JyVeldd5rhb0/uWp?=
 =?us-ascii?Q?DcC3MPru3sV2jfTHw7ru2PeLGhnbGTuApVf9U+3pT9ocgtgoUfnEU8GSXROE?=
 =?us-ascii?Q?TedXyG6ccO1wgTceozorzglAgS+P92KmbIi6SWXyeRBE/QFeQ5P7utXizYTZ?=
 =?us-ascii?Q?YAa6qSx3SfOZNwnz1ahLXqJD75tAd/Bm6vNX0VyhjiaN8GweEl+whQ5ZBA9O?=
 =?us-ascii?Q?wx7vzgEYiAWvY4IIrjl1mehD0D2kSGtcxc1mSB4BNxaxeW7sDGiSomNkjXv9?=
 =?us-ascii?Q?hbLoA6tihePc5NNXITi43sOK/mzBBsD+ebQ6cFoHqdTAFiO0eTR3FVOwDRuU?=
 =?us-ascii?Q?gRpA54z25G0qiTcTxJ8O+Rlu3nEP8veBnF3eD13yUFLBoOPXYi0cCvBgZ6WI?=
 =?us-ascii?Q?LKdiva9JY1bqKOgcOMczpLGLVkaxTHwtAlh7CzPqTzNwVvnz9fbG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c09dc22d-f065-42c0-3938-08dec75eee3e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 02:12:47.2434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acryS0A3mA7NYKZW0hbLVvqsLp7R/qHgix7DPMDwHAVXoI0WjxQQySoQnN+3UUhXHxgtrIcpHX6o7Z6Hd9DOMIIYnSCpD3+5tGmsMkF8uzwzPfnvG+p7qpeUGq/s/gXR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9709

From: Wei Fang <wei.fang@nxp.com>

Wire up the port_bridge_join, port_bridge_leave and port_vlan_filtering
DSA callbacks to support both VLAN-unaware and VLAN-aware bridge modes.

For VLAN-unaware bridges, each bridge instance is assigned a dedicated
internal PVID via NETC_VLAN_UNAWARE_PVID(bridge.num), counting down
from VID 4095. A VFT entry is created for this PVID with hardware MAC
learning and flood-on-miss forwarding enabled. The CPU port is included
as a VFT member so frames can reach the host. The reserved VID range is
blocked in port_vlan_add to prevent user-space conflicts.

Only one VLAN-aware bridge is supported at a time; this constraint is
enforced in port_bridge_join and port_vlan_filtering. The per-port PVID
is tracked in software and written to the BPDVR register whenever VLAN
filtering is active.

When a port leaves the bridge, its dynamic FDB entries are flushed right
away in port_bridge_leave(), without waiting for the ageing cycle. When
a link down event occurs on a port, netc_mac_link_down() will also clear
the port's dynamic FDB entries via netc_port_remove_dynamic_entries().
Non-bridge ports have no dynamic FDB entries, so this call is always
safe. Additionally, .port_fast_age() callback is added to flush the
dynamic FDB entries associated to a port.

Host flood rules are removed from the ingress port filter table when a
port joins a bridge to avoid bypassing FDB lookup and MAC learning.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c   | 377 +++++++++++++++++++++++++++--
 drivers/net/dsa/netc/netc_switch.h |   2 +
 2 files changed, 363 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 9382e7b68e65..b375dba9fff0 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -509,6 +509,17 @@ static void netc_port_set_mlo(struct netc_port *np, enum netc_mlo mlo)
 	netc_port_rmw(np, NETC_BPCR, BPCR_MLO, FIELD_PREP(BPCR_MLO, mlo));
 }
 
+static void netc_port_set_pvid(struct netc_port *np, u16 pvid)
+{
+	netc_port_rmw(np, NETC_BPDVR, BPDVR_VID, pvid);
+}
+
+static void netc_port_set_vlan_aware(struct netc_port *np, bool aware)
+{
+	netc_port_rmw(np, NETC_BPDVR, BPDVR_RXVAM,
+		      aware ? 0 : BPDVR_RXVAM);
+}
+
 static void netc_port_fixed_config(struct netc_port *np)
 {
 	/* Default IPV and DR setting */
@@ -534,7 +545,7 @@ static void netc_port_default_config(struct netc_port *np)
 	netc_port_fixed_config(np);
 
 	/* Default VLAN unaware */
-	netc_port_rmw(np, NETC_BPDVR, BPDVR_RXVAM, BPDVR_RXVAM);
+	netc_port_set_vlan_aware(np, false);
 
 	if (dsa_port_is_cpu(np->dp))
 		/* For CPU port, source port pruning is disabled */
@@ -695,10 +706,16 @@ static int netc_port_del_fdb_entry(struct netc_port *np,
 
 	entry = netc_lookup_fdb_entry(priv, addr, vid);
 	if (unlikely(!entry))
-		/* Currently only single port mode is supported, MAC learning
-		 * is disabled, so there is no dynamically learned FDB entry.
-		 * We need to support deleting dynamically FDB entry when the
-		 * bridge mode is supported.
+		/* The hardware-learned dynamic FDB entries cannot be deleted
+		 * through .port_fdb_del() interface.
+		 * For NTF_MASTER path: Since hardware-learned dynamic FDB
+		 * entries are never synchronized back to the bridge software
+		 * database. br_fdb_delete() -> br_fdb_find() cannot find the
+		 * FDB entry, so .port_fdb_del() will not be called.
+		 * For NTF_SELF path: dsa_user_netdev_ops does not implement
+		 * ndo_fdb_del(), so rtnl_fdb_del() falls back to
+		 * ndo_dflt_fdb_del(), which only supports NUD_PERMANENT static
+		 * entries and rejects all others with -EINVAL.
 		 */
 		goto unlock_fdbt;
 
@@ -1277,6 +1294,16 @@ static int netc_port_add_vlan_entry(struct netc_port *np, u16 vid,
 	entry->ect_gid = NTMP_NULL_ENTRY_ID;
 
 	bitmap_stg = BIT(index) | VFT_STG_ID(0);
+	/* If the VID is a VLAN-unaware PVID, the CPU port needs to be
+	 * a member of this VLAN.
+	 */
+	if (dsa_port_is_user(np->dp) &&
+	    vid >= NETC_VLAN_UNAWARE_PVID(priv->ds->max_num_bridges)) {
+		struct dsa_port *cpu_dp = np->dp->cpu_dp;
+
+		bitmap_stg |= BIT(cpu_dp->index);
+	}
+
 	cfg = FIELD_PREP(VFT_MLO, MLO_HW) |
 	      FIELD_PREP(VFT_MFO, MFO_NO_MATCH_FLOOD);
 
@@ -1314,11 +1341,16 @@ static int netc_port_add_vlan_entry(struct netc_port *np, u16 vid,
 	return err;
 }
 
-static bool netc_port_vlan_egress_rule_changed(struct netc_vlan_entry *entry,
+static bool netc_port_vlan_egress_rule_changed(struct netc_switch *priv,
+					       struct netc_vlan_entry *entry,
 					       int port, bool untagged)
 {
 	bool old_untagged = !!(entry->untagged_port_bitmap & BIT(port));
 
+	/* VLAN-unaware VIDs have no egress rules, so return 'false' */
+	if (entry->vid >= NETC_VLAN_UNAWARE_PVID(priv->ds->max_num_bridges))
+		return false;
+
 	return old_untagged != untagged;
 }
 
@@ -1341,7 +1373,8 @@ static int netc_port_set_vlan_entry(struct netc_port *np, u16 vid,
 	}
 
 	/* Check whether the egress VLAN rule is changed */
-	changed = netc_port_vlan_egress_rule_changed(entry, port, untagged);
+	changed = netc_port_vlan_egress_rule_changed(priv, entry, port,
+						     untagged);
 	if (changed) {
 		entry->untagged_port_bitmap ^= BIT(port);
 		err = netc_port_update_vlan_egress_rule(np, entry);
@@ -1405,6 +1438,17 @@ static int netc_port_del_vlan_entry(struct netc_port *np, u16 vid)
 	cfge = &entry->cfge;
 	vlan_port_bitmap = FIELD_GET(VFT_PORT_MEMBERSHIP,
 				     le32_to_cpu(cfge->bitmap_stg));
+	/* If the VID is a VLAN-unaware PVID, we need to clear the CPU
+	 * port bit of vlan_port_bitmap, so that the VLAN entry can be
+	 * deleted if no user ports use this VLAN.
+	 */
+	if (dsa_port_is_user(np->dp) &&
+	    vid >= NETC_VLAN_UNAWARE_PVID(priv->ds->max_num_bridges)) {
+		struct dsa_port *cpu_dp = np->dp->cpu_dp;
+
+		vlan_port_bitmap &= ~BIT(cpu_dp->index);
+	}
+
 	/* If the VLAN only belongs to the current port */
 	if (vlan_port_bitmap == BIT(port)) {
 		err = ntmp_vft_delete_entry(&priv->ntmp, vid);
@@ -1510,17 +1554,50 @@ static int netc_port_max_mtu(struct dsa_switch *ds, int port)
 	return NETC_MAX_FRAME_LEN - VLAN_ETH_HLEN - ETH_FCS_LEN;
 }
 
+static struct net_device *netc_classify_db(struct dsa_db db)
+{
+	switch (db.type) {
+	case DSA_DB_PORT:
+		return NULL;
+	case DSA_DB_BRIDGE:
+		return db.bridge.dev;
+	default:
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+}
+
+static u16 netc_vlan_unaware_pvid(struct dsa_bridge *bridge)
+{
+	u32 br_num;
+
+	if (!bridge)
+		return NETC_STANDALONE_PVID;
+
+	br_num = bridge->num;
+
+	/* The br_num is supposed to be 1 ~ ds->max_num_bridges, see
+	 * dsa_bridge_num_get(). Since max_num_bridges is non-zero,
+	 * so dsa_port_bridge_create() will return an error if
+	 * dsa_bridge_num_get() returns 0.
+	 */
+	if (WARN_ON(!br_num))
+		return NETC_STANDALONE_PVID;
+
+	return NETC_VLAN_UNAWARE_PVID(br_num);
+}
+
 static int netc_port_fdb_add(struct dsa_switch *ds, int port,
 			     const unsigned char *addr, u16 vid,
 			     struct dsa_db db)
 {
+	struct net_device *br_ndev = netc_classify_db(db);
 	struct netc_port *np = NETC_PORT(ds, port);
 
-	/* Currently, only support standalone port mode, so only
-	 * NETC_STANDALONE_PVID (= 0) is supported here.
-	 */
-	if (vid != NETC_STANDALONE_PVID)
-		return -EOPNOTSUPP;
+	if (IS_ERR(br_ndev))
+		return PTR_ERR(br_ndev);
+
+	if (!vid)
+		vid = netc_vlan_unaware_pvid(br_ndev ? &db.bridge : NULL);
 
 	return netc_port_set_fdb_entry(np, addr, vid);
 }
@@ -1529,10 +1606,14 @@ static int netc_port_fdb_del(struct dsa_switch *ds, int port,
 			     const unsigned char *addr, u16 vid,
 			     struct dsa_db db)
 {
+	struct net_device *br_ndev = netc_classify_db(db);
 	struct netc_port *np = NETC_PORT(ds, port);
 
-	if (vid != NETC_STANDALONE_PVID)
-		return -EOPNOTSUPP;
+	if (IS_ERR(br_ndev))
+		return PTR_ERR(br_ndev);
+
+	if (!vid)
+		vid = netc_vlan_unaware_pvid(br_ndev ? &db.bridge : NULL);
 
 	return netc_port_del_fdb_entry(np, addr, vid);
 }
@@ -1568,6 +1649,8 @@ static int netc_port_fdb_dump(struct dsa_switch *ds, int port,
 		cfg = le32_to_cpu(cfge->cfg);
 		is_static = (cfg & FDBT_DYNAMIC) ? false : true;
 		vid = le16_to_cpu(keye->fid);
+		if (vid >= NETC_VLAN_UNAWARE_PVID(ds->max_num_bridges))
+			vid = 0;
 
 		err = cb(keye->mac_addr, vid, is_static, data);
 		if (err)
@@ -1670,12 +1753,23 @@ static void netc_port_remove_host_flood(struct netc_port *np,
 					struct ipft_entry_data *host_flood)
 {
 	struct netc_switch *priv = np->switch_priv;
+	bool disable_host_flood = false;
 
 	if (!host_flood)
 		return;
 
+	if (np->host_flood == host_flood)
+		disable_host_flood = true;
+
 	ntmp_ipft_delete_entry(&priv->ntmp, host_flood->entry_id);
 	kfree(host_flood);
+
+	if (disable_host_flood) {
+		np->host_flood = NULL;
+		np->uc = false;
+		np->mc = false;
+		netc_port_wr(np, NETC_PIPFCR, 0);
+	}
 }
 
 static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
@@ -1684,6 +1778,17 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 	struct netc_port *np = NETC_PORT(ds, port);
 	struct ipft_entry_data *old_host_flood;
 
+	/* Do not add host flood rule to ingress port filter table when
+	 * the port has joined a bridge. Otherwise, the ingress frames
+	 * will bypass FDB table lookup and MAC learning, so the frames
+	 * will be redirected directly to the CPU port.
+	 */
+	if (dsa_port_bridge_dev_get(np->dp)) {
+		netc_port_remove_host_flood(np, np->host_flood);
+
+		return;
+	}
+
 	if (np->uc == uc && np->mc == mc)
 		return;
 
@@ -1705,12 +1810,90 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 	netc_port_remove_host_flood(np, old_host_flood);
 }
 
+static int netc_single_vlan_aware_bridge(struct dsa_switch *ds,
+					 struct netlink_ext_ack *extack)
+{
+	struct net_device *br_ndev = NULL;
+	struct dsa_port *dp;
+
+	dsa_switch_for_each_available_port(dp, ds) {
+		struct net_device *port_br = dsa_port_bridge_dev_get(dp);
+
+		if (!port_br || !br_vlan_enabled(port_br))
+			continue;
+
+		if (!br_ndev) {
+			br_ndev = port_br;
+			continue;
+		}
+
+		if (br_ndev == port_br)
+			continue;
+
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Only one VLAN-aware bridge is supported");
+
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int netc_port_vlan_filtering(struct dsa_switch *ds,
+				    int port, bool vlan_aware,
+				    struct netlink_ext_ack *extack)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	u16 pvid;
+	int err;
+
+	/* Before calling port_vlan_filtering(), br_vlan_filter_toggle() has
+	 * already updated the BROPT_VLAN_ENABLED bit of br->options. So the
+	 * VLAN filtering status of the switch ports can be checked by the
+	 * br_vlan_enabled() function.
+	 */
+	err = netc_single_vlan_aware_bridge(ds, extack);
+	if (err)
+		return err;
+
+	pvid = netc_vlan_unaware_pvid(np->dp->bridge);
+	if (pvid == NETC_STANDALONE_PVID) {
+		vlan_aware = false;
+		goto bpdvr_config;
+	}
+
+	if (vlan_aware) {
+		/* The FDB entries associated with unaware_pvid do not need
+		 * to be deleted, so that when switching from VLAN-aware to
+		 * VLAN-unaware mode, these FDB entries do not need to be
+		 * re-added.
+		 */
+		err = netc_port_del_vlan_entry(np, pvid);
+		if (err)
+			return err;
+
+		pvid = np->pvid;
+	} else {
+		err = netc_port_set_vlan_entry(np, pvid, false);
+		if (err)
+			return err;
+	}
+
+bpdvr_config:
+	netc_port_set_vlan_aware(np, vlan_aware);
+	netc_port_set_pvid(np, pvid);
+
+	return 0;
+}
+
 static int netc_port_vlan_add(struct dsa_switch *ds, int port,
 			      const struct switchdev_obj_port_vlan *vlan,
 			      struct netlink_ext_ack *extack)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
+	struct dsa_port *dp = np->dp;
 	bool untagged;
+	int err;
 
 	/* The 8021q layer may attempt to change NETC_STANDALONE_PVID
 	 * (VID 0), so we need to ignore it.
@@ -1718,20 +1901,176 @@ static int netc_port_vlan_add(struct dsa_switch *ds, int port,
 	if (vlan->vid == NETC_STANDALONE_PVID)
 		return 0;
 
+	if (vlan->vid >= NETC_VLAN_UNAWARE_PVID(ds->max_num_bridges)) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "VID %d~4095 reserved for VLAN-unaware bridge",
+				       NETC_VLAN_UNAWARE_PVID(ds->max_num_bridges));
+		return -EINVAL;
+	}
+
 	untagged = !!(vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED);
+	err = netc_port_set_vlan_entry(np, vlan->vid, untagged);
+	if (err)
+		return err;
+
+	if (vlan->flags & BRIDGE_VLAN_INFO_PVID) {
+		np->pvid = vlan->vid;
+		if (dsa_port_is_vlan_filtering(dp))
+			netc_port_set_pvid(np, vlan->vid);
 
-	return netc_port_set_vlan_entry(np, vlan->vid, untagged);
+		return 0;
+	}
+
+	if (np->pvid != vlan->vid)
+		return 0;
+
+	/* Delete PVID */
+	np->pvid = NETC_STANDALONE_PVID;
+	if (dsa_port_is_vlan_filtering(dp))
+		netc_port_set_pvid(np, NETC_STANDALONE_PVID);
+
+	return 0;
 }
 
 static int netc_port_vlan_del(struct dsa_switch *ds, int port,
 			      const struct switchdev_obj_port_vlan *vlan)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
+	int err;
 
 	if (vlan->vid == NETC_STANDALONE_PVID)
 		return 0;
 
-	return netc_port_del_vlan_entry(np, vlan->vid);
+	if (vlan->vid >= NETC_VLAN_UNAWARE_PVID(ds->max_num_bridges))
+		return -EINVAL;
+
+	err = netc_port_del_vlan_entry(np, vlan->vid);
+	if (err)
+		return err;
+
+	if (np->pvid == vlan->vid) {
+		np->pvid = NETC_STANDALONE_PVID;
+
+		/* Set the port PVID to NETC_STANDALONE_PVID if the VLAN-aware
+		 * bridge port has no PVID. The untagged frames will not be
+		 * forwarded to other user ports, as NETC_STANDALONE_PVID VLAN
+		 * entry has disabled MAC learning and flooding, and other user
+		 * ports do not have FDB entries with NETC_STANDALONE_PVID.
+		 */
+		if (dsa_port_is_vlan_filtering(np->dp))
+			netc_port_set_pvid(np, NETC_STANDALONE_PVID);
+	}
+
+	return 0;
+}
+
+static int netc_port_bridge_join(struct dsa_switch *ds, int port,
+				 struct dsa_bridge bridge,
+				 bool *tx_fwd_offload,
+				 struct netlink_ext_ack *extack)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	u16 vlan_unaware_pvid;
+	int err;
+
+	if (!bridge.num) {
+		NL_SET_ERR_MSG_MOD(extack, "Bridge number 0 is unsupported");
+		return -EINVAL;
+	}
+
+	err = netc_single_vlan_aware_bridge(ds, extack);
+	if (err)
+		return err;
+
+	netc_port_set_mlo(np, MLO_NOT_OVERRIDE);
+
+	if (br_vlan_enabled(bridge.dev))
+		goto out;
+
+	vlan_unaware_pvid = NETC_VLAN_UNAWARE_PVID(bridge.num);
+	err = netc_port_set_vlan_entry(np, vlan_unaware_pvid, false);
+	if (err)
+		goto disable_mlo;
+
+	netc_port_set_pvid(np, vlan_unaware_pvid);
+
+out:
+	netc_port_remove_host_flood(np, np->host_flood);
+
+	return 0;
+
+disable_mlo:
+	netc_port_set_mlo(np, MLO_DISABLE);
+
+	return err;
+}
+
+static void netc_port_remove_dynamic_entries(struct netc_port *np)
+{
+	struct netc_switch *priv = np->switch_priv;
+
+	/* Return if the port is not available */
+	if (!np->dp)
+		return;
+
+	mutex_lock(&priv->fdbt_lock);
+	ntmp_fdbt_delete_port_dynamic_entries(&priv->ntmp, np->dp->index);
+	mutex_unlock(&priv->fdbt_lock);
+}
+
+static void netc_port_bridge_leave(struct dsa_switch *ds, int port,
+				   struct dsa_bridge bridge)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct net_device *ndev = np->dp->user;
+	u16 vlan_unaware_pvid;
+	bool mc, uc;
+
+	netc_port_set_mlo(np, MLO_DISABLE);
+	netc_port_set_pvid(np, NETC_STANDALONE_PVID);
+	np->pvid = NETC_STANDALONE_PVID;
+
+	netc_port_remove_dynamic_entries(np);
+	uc = ndev->flags & IFF_PROMISC;
+	mc = ndev->flags & (IFF_PROMISC | IFF_ALLMULTI);
+
+	if (netc_port_add_host_flood_rule(np, uc, mc))
+		dev_warn(ds->dev,
+			 "Failed to restore host flood rule on port %d\n",
+			 port);
+
+	/* When a port leaves a VLAN-aware bridge, dsa_port_bridge_leave()
+	 * follows the sequence below:
+	 *
+	 * 1. dsa_port_bridge_destroy() is called to set dp->bridge to NULL.
+	 * 2. dsa_broadcast() is called, which eventually invokes
+	 *    ds->ops->port_bridge_leave()
+	 * 3. dsa_port_switchdev_unsync_attrs() is called, which triggers
+	 *    dsa_port_reset_vlan_filtering() and ultimately calls
+	 *    ds->ops->port_vlan_filtering() to transition the port from
+	 *    VLAN-aware mode to VLAN-unaware mode.
+	 *
+	 * At step 3, since dp->bridge has already been set to NULL in step 1,
+	 * netc_port_vlan_filtering() will detect this and skip the creation
+	 * of an unaware PVID entry in the VLAN filter table. Therefore, it is
+	 * safe to return directly here.
+	 */
+	if (br_vlan_enabled(bridge.dev))
+		return;
+
+	vlan_unaware_pvid = NETC_VLAN_UNAWARE_PVID(bridge.num);
+	/* There is no need to check the return value even if it fails.
+	 * Because the PVID has been set to NETC_STANDALONE_PVID, the
+	 * frames will not match this VLAN entry.
+	 */
+	netc_port_del_vlan_entry(np, vlan_unaware_pvid);
+}
+
+static void netc_port_fast_age(struct dsa_switch *ds, int port)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	netc_port_remove_dynamic_entries(np);
 }
 
 static void netc_phylink_get_caps(struct dsa_switch *ds, int port,
@@ -1988,6 +2327,7 @@ static void netc_mac_link_down(struct phylink_config *config,
 	np = NETC_PORT(dp->ds, dp->index);
 	netc_port_mac_rx_graceful_stop(np);
 	netc_port_mac_tx_graceful_stop(np);
+	netc_port_remove_dynamic_entries(np);
 }
 
 static const struct phylink_mac_ops netc_phylink_mac_ops = {
@@ -2012,8 +2352,12 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.port_mdb_add			= netc_port_mdb_add,
 	.port_mdb_del			= netc_port_mdb_del,
 	.port_set_host_flood		= netc_port_set_host_flood,
+	.port_vlan_filtering		= netc_port_vlan_filtering,
 	.port_vlan_add			= netc_port_vlan_add,
 	.port_vlan_del			= netc_port_vlan_del,
+	.port_bridge_join		= netc_port_bridge_join,
+	.port_bridge_leave		= netc_port_bridge_leave,
+	.port_fast_age			= netc_port_fast_age,
 	.get_pause_stats		= netc_port_get_pause_stats,
 	.get_rmon_stats			= netc_port_get_rmon_stats,
 	.get_eth_ctrl_stats		= netc_port_get_eth_ctrl_stats,
@@ -2061,6 +2405,7 @@ static int netc_switch_probe(struct pci_dev *pdev,
 	ds->ops = &netc_switch_ops;
 	ds->phylink_mac_ops = &netc_phylink_mac_ops;
 	ds->fdb_isolation = true;
+	ds->max_num_bridges = priv->info->num_ports - 1;
 	ds->priv = priv;
 	priv->ds = ds;
 
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 9ff334301fbc..982c8d3a3fbf 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -33,6 +33,7 @@
 #define NETC_MAX_FRAME_LEN		9600
 
 #define NETC_STANDALONE_PVID		0
+#define NETC_VLAN_UNAWARE_PVID(br_id)	(4096 - (br_id))
 
 /* Threshold format: MANT (bits 11:4) * 2^EXP (bits 3:0)
  * Unit: Memory words (average of 20 bytes each)
@@ -79,6 +80,7 @@ struct netc_port {
 	u16 enable:1;
 	u16 uc:1;
 	u16 mc:1;
+	u16 pvid;
 	struct ipft_entry_data *host_flood;
 };
 
-- 
2.34.1



Return-Path: <linuxppc-dev+bounces-22304-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBB3CD8C85
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 03:28:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZDrC57KXz3c2Z;
	Tue, 09 Jun 2026 13:27:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780975675;
	cv=pass; b=X4k1bCEiAuOXEsjkZA5W8wnOG8piFkWYWGj/M+QzrAzOCPj2KOV1MjdKgu9vOPj7CcuTpxI+0hfJHNNGdoOuQd/gMq8uCek/WVXrkSLQNYZsbAfkorUrRSJ6kA0yv2F2oXX2RmTT+zeIOR3maVuZ87CUOdAQTGYvdv1Xufoc8z58LewYgqitdeCXODgrybBpyY+Pkc3ytavkIBktjWWeIo3TtnmDsvnyvP1MLnTO9w0VZT8xG4SHfWF9vKSV4lX72I6OfIUHYX4HaGttHpVcIoejBbq+rUcNU+EPr71Yn++EXKUs1OUWVj4KjJ0/SmqTcZe5cwupdU4qNhJx5O2XLQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780975675; c=relaxed/relaxed;
	bh=ZaSRD3huykSTRQv/ntNUnxiA8EIMXKb5/7uswP/uUvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dR5950LE1gy/E4uELbwV0yzMXtWT2FWEMWwCh2madw7fdosVCbfaFAs6gWp+N+iCjTPRdc7FFvE7zYC+HniTsxkkRB3t9A9YghxuncmQXlcoBz3VKT7nhs5Be2AmybzRU3d83H7ABme4aiisRMtwvBGwnjunZQwC08DDR8G3NfzOsnS7zTLKY0oa/T8A2C31siXQkCgE/5nSBVb2iX5JKdyTgiibsr+2POONMJZuR46qFDVYZA4mvG5wL4WqWlsp1e/f0BzpkatiH8+99cLI9/ZV/Fz5E3onD5UjitBKSawjVNfa4WNVMcV9tjT8IpMzsj4IdcdaEioPy37ulrQxEw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=sW1lPQ4I; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=sW1lPQ4I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZDrB2YCdz3c1L
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 13:27:54 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=taNlt6+p32J7m2ioxDGRY5DVatjrXLQ4fuzsjyMNnNjIixm6uIrsIuvIYArd5IbOsprWg9sa3zIDKS+vm14ZuMr1rqqAebRdSQL7GN/EhCXTFM4/wQu8rkqTW0EiHhFDbPGoA77ZO1dqpG6cYcAzv+5KEhJaL3x4hCTCPkVwNbXH0tLlEqP2pS2t12E9qMAlKgsiDaHSL2jzzNihI/VI2X7pyE3qHMlESKvUeNt44anY89G2q8GXppYO+7WTkRvIUFyWMrgr9IoJq86fwUYvZxZsmieWrVY0Q1CA3sgOo5/8T9SGqVerYeBHYmP7HQf5+Wt/v8RDDEnkZ0CYW4uyyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaSRD3huykSTRQv/ntNUnxiA8EIMXKb5/7uswP/uUvk=;
 b=iJU+QJDqKXEf4aQ6rJ4xj7AMR+vfgsYjjrTrzriinchykdyZPeekyf+Cb/Azkw/tT4d4pnzN+SO+YOFQ5kLErmuDPse3FMailD/z1D9teec89VoaH3Z01lX/FE7fddcLS1sRnz/oK8bj4S6+fIQA5uSRxxrqOnoYuCz1dSXuQEZd5yxkUQG0UVL5j2NfvnZv1pZwh+xo5ay7FFiEml4VthfUHHh/hHppyE1g+ViFfYYF5rlmiMq492i1L6JGtLFj5HOGeQC2fhHYUY0LBzsShqGS3q1sOEQZYEN4S3DBzgbFW9v0vohVdia+PN/U39y8EkDyY0RY2Wp7FJJ6VgUcxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaSRD3huykSTRQv/ntNUnxiA8EIMXKb5/7uswP/uUvk=;
 b=sW1lPQ4IUTwOBiIbs9YNeJ3CKSyaTLCkZxKvCEy33QLJ5wf/eT6W1jNM9BSb7yObFgsUelnY/qJABwByQUNaNc+cxX+Rzas4yoH0JsQcsaNQmc3bnWh3mG1YE9TKnfVxCgooJ1ixg25uEwlc/H/wc7g3KiRZOMg9wRbPHMOoMGSMAUo6ht2jz3DSO9UoUGavfkM3HP8EoBNgsYBMQM0hU05X82WPZ314/bkzgoY8Y71ryKcrGeFcqbQi7GTPOobcvPzBaPOEX2kM2lFypfbuxx5TM4VyjG0Jf7iTN4qggk00AeFgkRKZfLJbuRhmweRbnHXEa41w47OQ8p2Psfm5Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 9 Jun
 2026 03:27:45 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 03:27:45 +0000
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
Subject: [PATCH v4 net-next 8/9] net: dsa: netc: add bridge mode support
Date: Tue,  9 Jun 2026 11:29:54 +0800
Message-Id: <20260609032955.2066089-9-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609032955.2066089-1-wei.fang@oss.nxp.com>
References: <20260609032955.2066089-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0191.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::14) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AS8PR04MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: df32f346-b041-4148-520f-08dec5d7126f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|7416014|1800799024|3023799007|22082099003|18002099003|921020|11063799006|56012099006|6133799003|5023799004;
X-Microsoft-Antispam-Message-Info:
	dzgn+HisdUMiI7rUY5xBlElbUoCIE8RtOpXrLRF2FlMqRiKOVWO+MFoEZsfP0gHGqZf/iAP9JCibsY5R2uDXqJTCbIJFd9kXjuC5+AdX8T1vKCcA6/j7cAsdACP3kPqqTU5s/ScH62O5wgJMnOlXvD4E9nzArzTXvdEM93XeRDL1R4ArsRCKyrNYbnsSLW5AZgYyYjiESTPXX8+BFbb0ZlIkbwwxSieQgz/Uf8mkWAki/vZNArv5kpj68UzVpJrinuVxRrwREzxH3zzE+SLGeul2tZk2T6Jv25l6MfrFMzv8UeHNNOdM3YOGPe1LNz1utEMODiy42KnO57z5Yut0Gks0q7/WvbifZWihOxrKpy5P1DoZAb0ropBPqsRtbSb2lqgBtvtjHd4df59uMxN0dBtsY2ZsCfDpY3oxWMvln82/Vy9My7JSjorYI4blNk+Z2YaXAFzL2sLIxn7qxSA6dcK3beNxnWzVjg3p/H6swFvS0HlbsCXlxhRdxS41vNAcCTzKrZH0OaUyKGbzTvsCbufLiDNsIzJFCTkWpQi80igw5aMHhopsVZyRuPD4PTA+B+H3ApAhkhLKlCXXabcrtj29OYCFWiCpfHdtVpkTg6QSalWw7zLQzTj0/bxLH8uiy9D34Q5BsJyuzMwLBVlenf9TuaKArvygWHRgDq9NNcUL1dE64m2pTIy/7QvtifswGkC6ULHJCD/DK4aB1yAuX6F+8sNA6QQTBsf+TrrVmbk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(7416014)(1800799024)(3023799007)(22082099003)(18002099003)(921020)(11063799006)(56012099006)(6133799003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?flfJ31GFe4U+GcrsAI54fFsIfB+17dRp3o3L2cbB0XALzBNBrWt2kiZltILa?=
 =?us-ascii?Q?RGCFA1s2PZjA4xjQ5RvoOyG/GliAPSLunD9+5y6yggXY2F6hxdD9HVXfjNni?=
 =?us-ascii?Q?3a4YVqsXNtLh90TBCnZqhYx6YScPw4R7/TElwtzsBwV0BSVYq3cCKx/1n12S?=
 =?us-ascii?Q?nEagnmzIMbpJ0ivM6NTYkhpj87Mh+0ej1fJEzVMZlI2uI+OY12amlPQ3omiz?=
 =?us-ascii?Q?Iu7wmwJakbt1Pe2Vd9UdquocNzxnX5AhVXwG4ktKDpmrFkWqXuoys4uppaGE?=
 =?us-ascii?Q?Ml27ercolqblDsx64zt6sroOwGzrnaEeabqw1mcaBHh85GyMQmjyZjLzTf6e?=
 =?us-ascii?Q?OsoREEW9Y9ofoEff9NqtV8+8LAPZRMEoB2qAH0asogRpMJRmKmdle2Hh3Ip5?=
 =?us-ascii?Q?Zk0pzkj9RVkkib1y6emRSlinh7qy7TrKQ9+YgTJwF/LivxrPDI4wqi2gH34Z?=
 =?us-ascii?Q?TfxNwotRuJmhYI0VF0BBGemmN2ZQTk0vCEZ4v3PiazrW7noeibnmGC2dpob1?=
 =?us-ascii?Q?HbiC0y7lCueUUM6PtSkiPCMNdmDfuVl1ipV1qKVLIF5HHdfJKpnx6zqrKtIx?=
 =?us-ascii?Q?LmymtnNqGG0rdH9z3WvKao2mINgm1A7645UqWITgJBTjV0a4qcQPsCRq2fX8?=
 =?us-ascii?Q?dDtkRmE10zFzGkVELoDsVTxZ2G6qlnltXx68AR1duqZrtMX9IzNP4z8IVxVb?=
 =?us-ascii?Q?Qa57PJnmTjboALZ7qc1/imhySnW6iHul7Q//NmlwGvECeCEz59QsYUANN5ih?=
 =?us-ascii?Q?hmwaOnOmEFr8N2NXkAezYthdRSrMcHfXj+RaHtdHqkzYCDewf8JWBmr8GZz7?=
 =?us-ascii?Q?zaB3btbOmo+oht16ovMzuZs2szNkVADKV1LiWdCI5S1aCkcD0m282STZfZh+?=
 =?us-ascii?Q?j8kXTqJdOBJK3wLdc1oBFpN71NnBgZVHCo5eZQ56AVBjMwMlX/I0YiZpjBIj?=
 =?us-ascii?Q?FkjTABGKEQmrcsn4CX5pc2Mri3vOPbJbBoTngOFO8DxYYiuOF8rywqZxUHoT?=
 =?us-ascii?Q?gzV+dMxpRcRTQ6q/FFpjQHObv+Gjf0lGimHnvr6ox1RCmBMtVnYenTNA9163?=
 =?us-ascii?Q?PLo3UzkuhkARI1V6gm342un9QeIUNtq6sbgkiP3Bl8WuTNHASJbbx5/FsUnN?=
 =?us-ascii?Q?Uv05fEUSyf4Rpt4LxGLyLDTMAp45axktTCejkNSkCCL5VzNFfPRqPeuxLK95?=
 =?us-ascii?Q?6Bf70GUNoydvTvAB9dBaZdF+H3c2htNqJ0r600JLDtkdEHlgIG2i+rkg80Gx?=
 =?us-ascii?Q?voa0opdnn9yUZeRHNfnwZLnosmG6U0LJJ5GyTMxyK4SS6cU8hhjaJ+JEvFyb?=
 =?us-ascii?Q?4+zi+1A3YxkhGl6Pt9VjLj+VovMdZP87ecdeR7GqwXfb2yNVv8sCeolNwr+t?=
 =?us-ascii?Q?HgoFpmRWT5bt2336vnjgBD5c8JcBw+WvEssWtcaaNR8j6AylaJrmiLsxEaD0?=
 =?us-ascii?Q?IFJ39RRjJyxvFQJiAQH0KN7xXsIux6ccRsXlpfesS6VcqiwVFsz4eGYWkM0E?=
 =?us-ascii?Q?q2HPyuGLyKc2KaSS8I+mZoPYCuOrThK3J8dxL8BfqFrsoVCgfh6hG28cAcka?=
 =?us-ascii?Q?ahERzgndVpGx62ffzadHW3to4FTvj3+eHH0+aiE1jSxOts90wsOZzKsbn0Sq?=
 =?us-ascii?Q?QvsgME4NC5iDHS2s7Y9Fg4FJmYpIh3qLpyvQVTqCq1oILOCDbLjWrHSIclSl?=
 =?us-ascii?Q?IuzThgD6o+luqoPYvyiJp3xVDO9pQih9FX9vEnh1Crxi93xTXMmTYZhvRWh1?=
 =?us-ascii?Q?NDWBU0EOeCCPQQsoFDYj+jStY6Dw1YAeIqHl9TCTz9Pncn8kOhgq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df32f346-b041-4148-520f-08dec5d7126f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 03:27:45.3416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNrLXBfWnLMdn0e+JX+sPv/enzAAb5TBumtWhHrFZci7LbxZ6Ud+tTlirRKu9TVSuu9kmnz/L9aTG2NqPY4yBDr005rm/WIXjfo7oLLXWUzdvK8hnIVoRruMrptE6ZxS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8946

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
index fcca22da08d8..299a9e76b9aa 100644
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



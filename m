Return-Path: <linuxppc-dev+bounces-18799-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48196109E54B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 06:28:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhDNw01gNz2xlf;
	Thu, 26 Mar 2026 17:28:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774506495;
	cv=pass; b=SoZwJIsOXXmTfb9zoUWdkjaf9yZxzQMFz0TQvU1z4TnrL2VWUbWHUVv+bxqbZ4JZYwMB6LDq1gky5PpeBkSTX8GrJtHBywWRbdZKonAcqDtJPljefyA2JLUGvJLMHg1mLlUBfGTjZoYAICvfGrdszLysReCZJx6S+Wyhy21ghf3mwk6gHMmoIX3AgceV4kX2azAc8EaG1yt/Xi7tjwpm1kkwaGhJUNRfSt0ZY8+9+AtFkulOM5BDvdOBW5Mg31mVufmbwiVLus0WN7ml3fH60r+1aPjpEpHUrwnrL2HYRoI0XXqt4uomYnhAh1TuRLySorCxfPjYfm7padXauBX4kw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774506495; c=relaxed/relaxed;
	bh=6y3HQpKxjRYaGQ3xgchWqZ6D8uYAKr7T5IFBIK/KRjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mExWw7HrzYMjVi+Ja2TG79AACDDV9+KYi9xHWVbWgpfKo2NvnAPJkmi7CRge3E23q1wGfapgXjDHVYToTI0+oNfKpCU+w/FqcPpbGgUsk1Xu1Dje0ei0rlxey2lCIL7COkY8sVDBvKBShuuigP3ozOYWxQDqhIvhRZjrVs40PGEeYQ9p9I9qVGeAzMgUa8JIypABooPjPVGLPg8+queQCMhcVSF0/tl+kmgkbXw1/yIDjtlP/rjQE3VpCfZZ9++CcPyJR1AJ+PiJaxHXQLLzM59cqivR4Q13KKVuxr/wP/eZYdWtSo79B+ot90EJ5+yH9IELGS8XJiXkA/CZjqvgaQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=N5bIh3dV; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=N5bIh3dV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhDNt4TYPz2xlM
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 17:28:14 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLD9YwubIcsIUqR749SGjlC16ETk4LelzTPUnoW+2F8TlmdeaDooyggMHqZbqoX+CjPIEzv67yykoHbq9eO3NBgr+KJFV8A27BUzCNKWNaK2CrPcax9H5OcwfAoIbLPg2Y48fZ17+ITds5wDSEuAfOPTTkDHrC+IsFMsFve9RRIaPw5W/Gq41L5Gex2ZNxN6NUt0YgVuicUrBihhGT6c6bCwWZCr3B9C3HtpW2Mk05Zk3/ZhpCspU9s6psk413T5o3qtN3wst2sf+iyxMKZu1yAyG+wrbr74cnzuYqiEHpt4N4zrRwCgZRqtsZNLWKzu/8PmvyGQM2l/CjDufbelng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6y3HQpKxjRYaGQ3xgchWqZ6D8uYAKr7T5IFBIK/KRjE=;
 b=o+xikrnMx2Q3nEdxVU8FAuf/CsRTacKZcQ0apE+p8RM6yFIFN2wbxnsS+6scjXP71d8WTCZ6U1gRSyDhwHq8X9L1z6ijoB3VCXDxVM0CjQ0Dz5hUd5al6LnvA5+PkDWeDCm2i0S7O8cGpEgaJpd29tv+BT8gLwzMtsD6JURS0jz/FkICUHZzMrua1w1gN8Pr4Os06uEG45DDQOotFyMaTDTVQjhnez3kds2z5wv8jQHi6pawXyK79lQgXjCZGbRy2br5vqjq7PTbShzy4ealo9/scygoP4Ras0a8iLXembQrrYztxqTP6zl6tcy09Dr4JVrvxdhiQUTlQhFfV9OsAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6y3HQpKxjRYaGQ3xgchWqZ6D8uYAKr7T5IFBIK/KRjE=;
 b=N5bIh3dVHtASkS3luKmU8yN3NABuLGRoLk5SxezfvCArUCcNXHUEnsMcdvIvtomhvd6SO9kmWRvlX34ioAG4XEOOtOcC5jgcnoZ5Sx7qs+cfroEh8k9rIcEdy9HexEx7X1jy19fTsyVi5iPq47QE4pKamp26tyD9AlCelT1QDUapHib+3BRTEgns9SIO5II3Ef//lI+yFjhHuFWXkV8VBO3olqLEjm8b38cqOGdoGeh2VYHnCXtcMVtsdgPVP+jNM0o1TunVwJ+KIUvYSALGXR8TqAPL85h7W+6YORQdq/m7HX6mxIyTkeih17WVl2i6XCbhmqae0cmzK8M6IyKRlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA2PR04MB10309.eurprd04.prod.outlook.com (2603:10a6:102:41f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Thu, 26 Mar
 2026 06:27:50 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 06:27:49 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v3 net-next 04/14] net: enetc: add basic operations to the FDB table
Date: Thu, 26 Mar 2026 14:29:07 +0800
Message-Id: <20260326062917.3552334-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326062917.3552334-1-wei.fang@nxp.com>
References: <20260326062917.3552334-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA2PR04MB10309:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d83de8-388c-432a-0daf-08de8b00cd07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|52116014|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	GarDQtIvM9/PYdKw2ObbZNmCAV+2XoXUm4wVms4943Yd5cSOHoTn8KfgScBSLSdOgIyaUv7x4C9R2l0Gn1NUdjcOdtHv4BDGUkgQQbPkdLnY+P4yuMhS+KkBIt3JPx2UUiXoZz0OYu6pFufxXnxCBFHC6wyAeGE4rlr8RWiZYHKs3O8LB3LjRhePHM7PtEI2P7+a4X/izEV4WxceC8f70NMzqTXOtrtHXUfRC82jSO+FYnsmsX9ZOFLEYXaBXackv02tD66b9sCapgm00i7e8S2a+Jf74fDZhujmEkaQlWcmoLrXkxl7NX0PA5YEZYKyY99wP3BmxE8kY9vedOYAEIQsdLvwxR7DN4bwI7T3U0Itz6YD4C/rK1JOMdzR+eljT8wsCTdlieY2/F8Su5SO5mJQ6nFyAR1sV0zmDBejuaRFWiGQFy0L36KsW9z6IZ/j4XBdFUgM0ylz53AfP9Rnpo0j/OKEzZ6e7uJQQi7E6rs28/dIeFwMrDr70ymBhRSQ2wkrm6oBzHh0DU9uryKK55+OeUCZ+u+iKly3BP/kLQjBeSw9QUp8tS7/xprS6a/49n7U/TUSjESW6bzL+xAfAhsuE0Ljp3LbXIHaFnT8VyiqJw7JN+DK4tWEJgHJIMvpKVb3g0uwSBB+8/ObKB+c8/Id3BxzskphqBHnYmGIDzMQuTXpgtjot4kFc3gNKWbV6ZhZjFGhgqhIZoOqoJVjF+yY3czqYZ4utocrORYFoyMHb4NiprfzGQiXJcKCBCYO3RBmbIHkzugo+LMqzmcq93GeCBEx0qG++O+aog1iItf4bdLSG9hzKuQbXfsqFImr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(52116014)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/ASZsiRo0EByOvjgRpTrxqi4EYHo7zrsPA/PjcQo+bFFHQtjTbULUKSosrtp?=
 =?us-ascii?Q?jkK/GbMvbx9V1JYRkVxxmgoSq0QYOBw+vMYHboGrvPwUFvXU7QcQz4wdJuY9?=
 =?us-ascii?Q?l3A0VNvL34Du6zYk9n0dK7BshxDdZu7KOw7ID2Xe/ilMXUan5xn9JbFBauvg?=
 =?us-ascii?Q?xTYm5AL3am2NC547o0Qm/rIdpKiO4nObHjDWZszfxrlltaKZmYrcIyeCLJ/N?=
 =?us-ascii?Q?AxUbOJ6a6lPIZ3ku7MQkrYca0dLAsJMS3q91+D+Gun4jF9DYbwJ1yXfd9OVq?=
 =?us-ascii?Q?g5t/lswHqrSGbombmrf1cYKVPdbTZt1CudAEnOmYlvTZsb2y81mrffIxrJJ2?=
 =?us-ascii?Q?FKLaRYVjunF3DShVRH6Pr6hI2/Tv5q2GOHGyWNcjWpQhLr62RhHqYFC6P5ma?=
 =?us-ascii?Q?DgaSFgZyNQ1qLb8yAWzedru8qJN0XUiu4HorVyxqahGTOkvhekQyVUHThDnl?=
 =?us-ascii?Q?33Mq7o1Xk2uj6oI2VxbltAUar+GHNoJynoMwA1Fu00GS3rXN/zS1hPcFxgqj?=
 =?us-ascii?Q?aTEtfkF2YB25H6D1ALRFQPwgzPFKPERWKc3YnunN2aShqrkiBTMD2UlT81ui?=
 =?us-ascii?Q?g8WKAHk1r7QLqW4oXlo4ftpHf8iu4HpQtUqEOqsfVuf1bhnrvYKm9anb+opk?=
 =?us-ascii?Q?HZdh8GeX7PRbGAWTHgdozmpzPDbsdddrLJQrHNrjbteFmdF6HdhpIgy9Nr8n?=
 =?us-ascii?Q?lrdYkSWu7eVESXK54k/K3AV4ffYJaP05A3vctDdkpkmtdRzISbQbwv15rnGd?=
 =?us-ascii?Q?/z1m0p6MQmf5EZE47ERj+9H9jjVkM3+VPJb3mUr7Rh7Cxrp7XS8XY4c0qaR7?=
 =?us-ascii?Q?cQROxSMaQDb1Gm9BZXn1S6gq3mPY9P+WbIerQ1JSeOJnlOeeQ0NeA65tvydB?=
 =?us-ascii?Q?YSlrBsAOG4tPhaFWHRcri8jQW0JFtmYjdwVlpFdAacStg6jQdANniw09FL2X?=
 =?us-ascii?Q?NngLfGDUGKBHDn7UzmJe+BxjE2ukYCVVppQJgGl8yg+0ThcW5xAOZ/nd47er?=
 =?us-ascii?Q?VJrYbbPe1fc6ZYyr/+03wOoTfHHiWR8WRWpJ/y+4E0WfjPjZeKgm7POOI2I8?=
 =?us-ascii?Q?rHpoHMG/hQym8i3Q/Gipeo4MKYhpV46o0frDIabxIHxyBTZ1MeqddS3QqgEt?=
 =?us-ascii?Q?REwdO8Y8ToKLgjrrNrf4ZJ5dPb19Gc5cDwOIkDIJmZx0NJROua+7U3aYAX9Q?=
 =?us-ascii?Q?wT2jm60vTWzFsA+dbWEUg06M6djSqNCvKI3I/UvYYGerJ0pSSorVRSSJ0663?=
 =?us-ascii?Q?Kcd1b7GwXZQ+a/IFmqiY+UeAcBP5K02wFk+atoOgj9P+9U9c50jQDbRbCu4C?=
 =?us-ascii?Q?HPfsvMnDs6TxnvMYZXkA7P+BKo9EJaA1O7UtX2b3ZloBi2czB+IeuGn5hrc4?=
 =?us-ascii?Q?L+iA9+YxRz2ygIFr4ofT8davXC3EDZG7DDYHrRTQfySoc28GHaO+HMcKLvK/?=
 =?us-ascii?Q?clN3PjewiTsicGL0RgVV9iImiFGvwkjQOF2SRpXFGsUl8s+iOeS+iJWUwSme?=
 =?us-ascii?Q?qxz9bOKqq9/KQDn15Aaulte582/oizLw/YP5siEKrLdy527trkv9kJl0n0T5?=
 =?us-ascii?Q?4rIRRR7SnKjYFP2WDcH7YIVhc1l/+MZ68Fm4CeQ/iQEMgIIGaF9+LKHqjIsq?=
 =?us-ascii?Q?Z1UrKGcwGVDHooHBf8wDthsLoQYjajStRX9QBwNZBEn2a3F3LwsgV6NntST3?=
 =?us-ascii?Q?J5eQHIYZugzsxZV9DdBLNhGA6c4kZrMoFyJAh33eeX/16W2Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d83de8-388c-432a-0daf-08de8b00cd07
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 06:27:49.6568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGOj+C7pjmVC7ABOn12cXn0f33RgssMa/S2QNyi0M4KZACaBkxUkLcJM1YTEPURJ18KO2LpCeKL26gCmKc8YAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10309

The FDB table is used for MAC learning lookups and MAC forwarding lookups.
Each table entry includes information such as a FID and MAC address that
may be unicast or multicast and a forwarding destination field containing
a port bitmap identifying the associated port(s) with the MAC address.
FDB table entries can be static or dynamic. Static entries are added from
software whereby dynamic entries are added either by software or by the
hardware as MAC addresses are learned in the datapath.

The FDB table can only be managed by the command BD ring using table
management protocol version 2.0. Table management command operations Add,
Delete, Update and Query are supported. And the FDB table supports three
access methods: Entry ID, Exact Match Key Element and Search. This patch
adds the following basic supports to the FDB table.

ntmp_fdbt_update_entry() - update the configuration element data of a
specified FDB entry

ntmp_fdbt_delete_entry() - delete a specified FDB entry

ntmp_fdbt_add_entry() - add an entry into the FDB table

ntmp_fdbt_search_port_entry() - Search the FDB entry on the specified
port based on RESUME_ENTRY_ID.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 201 +++++++++++++++++-
 .../ethernet/freescale/enetc/ntmp_private.h   |  61 +++++-
 include/linux/fsl/ntmp.h                      |  69 +++++-
 3 files changed, 328 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 703752995e93..a4a99954baf2 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
  * NETC NTMP (NETC Table Management Protocol) 2.0 Library
- * Copyright 2025 NXP
+ * Copyright 2025-2026 NXP
  */
 
 #include <linux/dma-mapping.h>
@@ -20,11 +20,15 @@
 /* Define NTMP Table ID */
 #define NTMP_MAFT_ID			1
 #define NTMP_RSST_ID			3
+#define NTMP_FDBT_ID			15
 
 /* Generic Update Actions for most tables */
 #define NTMP_GEN_UA_CFGEU		BIT(0)
 #define NTMP_GEN_UA_STSEU		BIT(1)
 
+/* Query Action: 0: Full query, 1: Only query entry ID */
+#define NTMP_QA_ENTRY_ID		1
+
 #define NTMP_ENTRY_ID_SIZE		4
 #define RSST_ENTRY_NUM			64
 #define RSST_STSE_DATA_SIZE(n)		((n) * 8)
@@ -225,6 +229,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "MAC Address Filter Table";
 	case NTMP_RSST_ID:
 		return "RSS Table";
+	case NTMP_FDBT_ID:
+		return "FDB Table";
 	default:
 		return "Unknown Table";
 	}
@@ -453,5 +459,198 @@ int ntmp_rsst_query_entry(struct ntmp_user *user, u32 *table, int count)
 }
 EXPORT_SYMBOL_GPL(ntmp_rsst_query_entry);
 
+/**
+ * ntmp_fdbt_add_entry - add an entry into the FDB table
+ * @user: target ntmp_user struct
+ * @entry_id: returned value, the entry ID of the new added entry
+ * @keye: key element data
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
+			const struct fdbt_keye_data *keye,
+			const struct fdbt_cfge_data *cfge)
+{
+	struct ntmp_dma_buf data = {
+		.dev = user->dev,
+		.size = sizeof(struct fdbt_req_ua),
+	};
+	struct fdbt_resp_query *resp;
+	struct fdbt_req_ua *req;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, NTMP_QA_ENTRY_ID,
+		      NTMP_GEN_UA_CFGEU);
+	req->ak.exact.keye = *keye;
+	req->cfge = *cfge;
+
+	len = NTMP_LEN(data.size, sizeof(*resp));
+	/* The entry ID is allotted by hardware, so we need to perform
+	 * a query action after the add action to get the entry ID from
+	 * hardware.
+	 */
+	ntmp_fill_request_hdr(&cbd, data.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_AQ, NTMP_AM_EXACT_KEY);
+	err = netc_xmit_ntmp_cmd(user, &cbd);
+	if (err) {
+		dev_err(user->dev, "Failed to add %s entry, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+		goto end;
+	}
+
+	if (entry_id) {
+		resp = (struct fdbt_resp_query *)req;
+		*entry_id = le32_to_cpu(resp->entry_id);
+	}
+
+end:
+	ntmp_free_data_mem(&data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_add_entry);
+
+/**
+ * ntmp_fdbt_update_entry - update the configuration element data of the
+ * specified FDB entry
+ * @user: target ntmp_user struct
+ * @entry_id: the specified entry ID of the FDB table
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_update_entry(struct ntmp_user *user, u32 entry_id,
+			   const struct fdbt_cfge_data *cfge)
+{
+	struct ntmp_dma_buf data = {
+		.dev = user->dev,
+		.size = sizeof(struct fdbt_req_ua),
+	};
+	struct fdbt_req_ua *req;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, NTMP_GEN_UA_CFGEU);
+	req->ak.eid.entry_id = cpu_to_le32(entry_id);
+	req->cfge = *cfge;
+
+	/* Request header */
+	len = NTMP_LEN(data.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, data.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_UPDATE, NTMP_AM_ENTRY_ID);
+	err = netc_xmit_ntmp_cmd(user, &cbd);
+	if (err)
+		dev_err(user->dev, "Failed to update %s entry, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+
+	ntmp_free_data_mem(&data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_update_entry);
+
+/**
+ * ntmp_fdbt_delete_entry - delete the specified FDB entry
+ * @user: target ntmp_user struct
+ * @entry_id: the specified ID of the FDB entry
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id)
+{
+	u32 req_len = sizeof(struct fdbt_req_qd);
+
+	return ntmp_delete_entry_by_id(user, NTMP_FDBT_ID,
+				       user->tbl.fdbt_ver,
+				       entry_id, req_len,
+				       NTMP_STATUS_RESP_LEN);
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_delete_entry);
+
+/**
+ * ntmp_fdbt_search_port_entry - Search the FDB entry on the specified
+ * port based on RESUME_ENTRY_ID
+ * @user: target ntmp_user struct
+ * @port: the specified switch port ID
+ * @resume_entry_id: it is both an input and an output. As an input, it
+ * represents the FDB entry ID to be searched. If it is a NULL entry ID,
+ * it indicates that the first FDB entry for that port is being searched.
+ * As an output, it represents the next FDB entry ID to be searched.
+ * @entry: returned value, the response data of the searched FDB entry
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
+				u32 *resume_entry_id,
+				struct fdbt_entry_data *entry)
+{
+	struct ntmp_dma_buf data = {
+		.dev = user->dev,
+		.size = sizeof(struct fdbt_req_qd),
+	};
+	struct fdbt_resp_query *resp;
+	struct fdbt_req_qd *req;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, 0);
+	req->ak.search.resume_eid = cpu_to_le32(*resume_entry_id);
+	req->ak.search.cfge.port_bitmap = cpu_to_le32(BIT(port));
+	/* Match CFGE_DATA[PORT_BITMAP] field */
+	req->ak.search.cfge_mc = FDBT_CFGE_MC_PORT_BITMAP;
+
+	/* Request header */
+	len = NTMP_LEN(data.size, sizeof(*resp));
+	ntmp_fill_request_hdr(&cbd, data.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_QUERY, NTMP_AM_SEARCH);
+
+	err = netc_xmit_ntmp_cmd(user, &cbd);
+	if (err) {
+		dev_err(user->dev,
+			"Failed to search %s entry on port %d, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), port, ERR_PTR(err));
+		goto end;
+	}
+
+	if (!cbd.resp_hdr.num_matched) {
+		entry->entry_id = NTMP_NULL_ENTRY_ID;
+		*resume_entry_id = NTMP_NULL_ENTRY_ID;
+		goto end;
+	}
+
+	resp = (struct fdbt_resp_query *)req;
+	*resume_entry_id = le32_to_cpu(resp->status);
+	entry->entry_id = le32_to_cpu(resp->entry_id);
+	entry->keye = resp->keye;
+	entry->cfge = resp->cfge;
+	entry->acte = resp->acte;
+
+end:
+	ntmp_free_data_mem(&data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_search_port_entry);
+
 MODULE_DESCRIPTION("NXP NETC Library");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 34394e40fddd..8999eafe1920 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /*
  * NTMP table request and response data buffer formats
- * Copyright 2025 NXP
+ * Copyright 2025-2026 NXP
  */
 
 #ifndef __NTMP_PRIVATE_H
@@ -11,6 +11,7 @@
 #include <linux/fsl/ntmp.h>
 
 #define NTMP_EID_REQ_LEN	8
+#define NTMP_STATUS_RESP_LEN	4
 #define NETC_CBDR_BD_NUM	256
 
 union netc_cbd {
@@ -27,6 +28,7 @@ union netc_cbd {
 #define NTMP_CMD_QUERY		BIT(2)
 #define NTMP_CMD_ADD		BIT(3)
 #define NTMP_CMD_QU		(NTMP_CMD_QUERY | NTMP_CMD_UPDATE)
+#define NTMP_CMD_AQ		(NTMP_CMD_ADD | NTMP_CMD_QUERY)
 		u8 access_method;
 #define NTMP_ACCESS_METHOD	GENMASK(7, 4)
 #define NTMP_AM_ENTRY_ID	0
@@ -101,4 +103,61 @@ struct rsst_req_update {
 	u8 groups[];
 };
 
+/* Access Key Format of FDB Table */
+struct fdbt_ak_eid {
+	__le32 entry_id;
+	__le32 resv[7];
+};
+
+struct fdbt_ak_exact {
+	struct fdbt_keye_data keye;
+	__le32 resv[5];
+};
+
+struct fdbt_ak_search {
+	__le32 resume_eid;
+	struct fdbt_keye_data keye;
+	struct fdbt_cfge_data cfge;
+	u8 acte;
+	u8 keye_mc;
+#define FDBT_KEYE_MAC		GENMASK(1, 0)
+	u8 cfge_mc;
+#define FDBT_CFGE_MC		GENMASK(2, 0)
+#define FDBT_CFGE_MC_ANY		0
+#define FDBT_CFGE_MC_DYNAMIC		1
+#define FDBT_CFGE_MC_PORT_BITMAP	2
+#define FDBT_CFGE_MC_DYNAMIC_AND_PORT_BITMAP	3
+	u8 acte_mc;
+#define FDBT_ACTE_MC		BIT(0)
+};
+
+union fdbt_access_key {
+	struct fdbt_ak_eid eid;
+	struct fdbt_ak_exact exact;
+	struct fdbt_ak_search search;
+};
+
+/* FDB Table Request Data Buffer Format of Update and Add actions */
+struct fdbt_req_ua {
+	struct ntmp_cmn_req_data crd;
+	union fdbt_access_key ak;
+	struct fdbt_cfge_data cfge;
+};
+
+/* FDB Table Request Data Buffer Format of Query and Delete actions */
+struct fdbt_req_qd {
+	struct ntmp_cmn_req_data crd;
+	union fdbt_access_key ak;
+};
+
+/* FDB Table Response Data Buffer Format of Query action */
+struct fdbt_resp_query {
+	__le32 status;
+	__le32 entry_id;
+	struct fdbt_keye_data keye;
+	struct fdbt_cfge_data cfge;
+	u8 acte;
+	u8 resv[3];
+};
+
 #endif
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 916dc4fe7de3..a9f3e6cbf422 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -1,11 +1,13 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/* Copyright 2025 NXP */
+/* Copyright 2025-2026 NXP */
 #ifndef __NETC_NTMP_H
 #define __NETC_NTMP_H
 
 #include <linux/bitops.h>
 #include <linux/if_ether.h>
 
+#define NTMP_NULL_ENTRY_ID		0xffffffffU
+
 struct maft_keye_data {
 	u8 mac_addr[ETH_ALEN];
 	__le16 resv;
@@ -29,6 +31,7 @@ struct netc_cbdr_regs {
 struct netc_tbl_vers {
 	u8 maft_ver;
 	u8 rsst_ver;
+	u8 fdbt_ver;
 };
 
 struct netc_cbdr {
@@ -61,6 +64,36 @@ struct maft_entry_data {
 	struct maft_cfge_data cfge;
 };
 
+struct fdbt_keye_data {
+	u8 mac_addr[ETH_ALEN]; /* big-endian */
+	__le16 resv0;
+	__le16 fid;
+#define FDBT_FID		GENMASK(11, 0)
+	__le16 resv1;
+};
+
+struct fdbt_cfge_data {
+	__le32 port_bitmap;
+#define FDBT_PORT_BITMAP	GENMASK(23, 0)
+	__le32 cfg;
+#define FDBT_OETEID		GENMASK(1, 0)
+#define FDBT_EPORT		GENMASK(6, 2)
+#define FDBT_IMIRE		BIT(7)
+#define FDBT_CTD		GENMASK(10, 9)
+#define FDBT_DYNAMIC		BIT(11)
+#define FDBT_TIMECAPE		BIT(12)
+	__le32 et_eid;
+};
+
+struct fdbt_entry_data {
+	u32 entry_id;
+	struct fdbt_keye_data keye;
+	struct fdbt_cfge_data cfge;
+	u8 acte;
+#define FDBT_ACT_CNT		GENMASK(6, 0)
+#define FDBT_ACT_FLAG		BIT(7)
+};
+
 #if IS_ENABLED(CONFIG_NXP_NETC_LIB)
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs);
@@ -76,6 +109,15 @@ int ntmp_rsst_update_entry(struct ntmp_user *user, const u32 *table,
 			   int count);
 int ntmp_rsst_query_entry(struct ntmp_user *user,
 			  u32 *table, int count);
+int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
+			const struct fdbt_keye_data *keye,
+			const struct fdbt_cfge_data *cfge);
+int ntmp_fdbt_update_entry(struct ntmp_user *user, u32 entry_id,
+			   const struct fdbt_cfge_data *cfge);
+int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id);
+int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
+				u32 *resume_entry_id,
+				struct fdbt_entry_data *entry);
 #else
 static inline int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 				 const struct netc_cbdr_regs *regs)
@@ -116,6 +158,31 @@ static inline int ntmp_rsst_query_entry(struct ntmp_user *user,
 	return 0;
 }
 
+static inline int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
+				      const struct fdbt_keye_data *keye,
+				      const struct fdbt_cfge_data *data)
+{
+	return 0;
+}
+
+static inline int ntmp_fdbt_update_entry(struct ntmp_user *user, u32 entry_id,
+					 const struct fdbt_cfge_data *cfge)
+{
+	return 0;
+}
+
+static inline int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id)
+{
+	return 0;
+}
+
+static inline int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
+					      u32 *resume_entry_id,
+					      struct fdbt_entry_data *entry)
+{
+	return 0;
+}
+
 #endif
 
 #endif
-- 
2.34.1



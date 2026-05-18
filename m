Return-Path: <linuxppc-dev+bounces-21093-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90427CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 08:25:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJrT95JXyz3cdB;
	Mon, 18 May 2026 18:25:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779092701;
	cv=pass; b=gqg1vP0VdWDbBfx+S9BqIyHjgnTiNqBNQf8DpjbRlDSDF1LyOhlASFp4Plz4VfNsVKnLDnNVcLxPZ7cy4Q3YkAAbPgNZZQf3hKB7fl/y3lDpbwS96T6McHV90CcG5Yj+v8ahXT73RWcO5p06N5mvdvKJwDiyuU0KbD7zR/aunVw9XUeKjKB9pgidrUhbLsDTOAu3QKt2lK1DQiOEtfvbtL2S5wQw57OSEisvBbI/dD66l40biGGKq3bjmbhyJU+/HQ5/3D3FwvMbMEDsoSwJrM1H+qW4Gq5s49wP03nIacCnuNAMPC95vM8J8QUBD+372o5qg0HdeJn1yoLSBqrC4Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779092701; c=relaxed/relaxed;
	bh=aLjGEWz7do7c+1HbFG6x2EXWtDryHlscsfuhOH55xAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XtAPpjdubKKX/AMzolz7BImcK3JHKvCQz1oCS/o1n2s0bw9QYwrtbXUI6yvPuFAyw8XQLlim5mBTbFpH3Hn0E9U86Lc+OOSoD0SidGYW7/0u6Zgw7VBL/uR0h33RsVKeG7b3x4JY5zTYKWkbQGkxLFY+Q9dCiFrS+ZLn9DJoaKY4TINHUO7eqtqXSj+twEl+3e0szQMmw12pcYg0iiknHIMQ5CEKbQLv2nPT5S41ZeENsZLZG0obLcKMV8dgFpAUNY6DYqKI/PPNDwcuHYF/4X2K5ccALwkrfTopQ+kAK/3b/3y/Pc4A1EbbjPNLg6VEbMeKXmwo3HazcaM3bU8ngg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=GObjlvK/; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=GObjlvK/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJrT837xFz3cbl
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 18:25:00 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGq10gBPNobYHyuqZeG60DSW2evBlE65mEmxoVKZvH/EHUFPoWDOwA0YKYUtiEEfEE+Wd9E4LFWn0BbDl9/WrR7AqrVYJ6Ww04KNSSyrEfTq4w3CytzFNdZbSrHRJsUakitJFEQ3WPNerpMhASQ5SJTSku1g+yz/5qugTNys8C8a/qoo+kgYsIU2EJywxsrbiYHeqDY0u4v7smUF59BWp10zJMdryKu4ZY0CyM+jkDy/WMXiNK9spvqiSX0jwGlc3AJfgGSQzsCZbg1upwERFb53q1LQd8/ZvhGneU/bbJC36y8VNTXx/LUaWqGbujvFczWQM1hzvODfRw9aEx1+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLjGEWz7do7c+1HbFG6x2EXWtDryHlscsfuhOH55xAM=;
 b=PnlXtmt5Ucop1c5bvB76pxrZJGSg0pI9rV4pjbAMjGRDI58xjppxlg8303wCgZ1HsCKzMjdD+7L2n7tDSMMA3tHpFJ/kPPP5KqZ5QENxDsoHBOrTxOArt50cHOwjs9hUdOYpdSXHGnpih0U4hNP8Pw+wIGhapvt3RIVQ4yrWv6rqC7kyZzc6Ri/5iX4yGbuP8mHSZlL5ObPhv+aWANCy1YnSob60KFGWMiMBPyiWXPiEWxj1aodl5rzA0+GSV5Pves8OgRwmaxO3Sfes6KV1LQ1Di9uIjX+NCyZvYGzomam0rdFGnURMAxs4Q656ixD/agw1XaYOc0GH/WG+jwh11Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLjGEWz7do7c+1HbFG6x2EXWtDryHlscsfuhOH55xAM=;
 b=GObjlvK/rBp6ebPNEEvYehr+DUKEEgWhKc5TI/ai2QYY5eyKMtROktRqnS3pY3duxl2UV6+W5a7sRCxBahL57T1AA9Zy5uwyx4t+FHVVdORS3pK2RmLCLtXSoiXGQcaeKEvPrvoTkDylH9GqB3GKmFESYpehX5pdY3E8zALqR2b8e124dK+jDSpOtLLJjcVRmyxY4eQ2G0mdFBeH0xAnhUsGBB6vE6BsRCWajTN8v/eKtLfl+oEGzMzXdrxTLv3Iff9c1c8DKmRlM5w1y6hDG0J8ib9km1bbAdlruKuQbqbP24XDXCsbk8utJIyNuRjbEG2qpNKHF2uiNyu6kKWTfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 18 May
 2026 08:24:53 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 08:24:53 +0000
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
	maxime.chevallier@bootlin.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v8 net-next 13/15] net: dsa: netc: initialize buffer pool table and implement flow-control
Date: Mon, 18 May 2026 16:25:04 +0800
Message-Id: <20260518082506.1318236-14-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518082506.1318236-1-wei.fang@nxp.com>
References: <20260518082506.1318236-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|AM9PR04MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: 245da048-ad3f-4e4c-6467-08deb4b6ef88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|38350700014|921020|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	MpaXE5PRQwi23EeGI9XgPQ0F3ptBmjWysv5rxv1D1qim/PWbxQEA7aomi7Tta5YcvUE0s6g5Sd9RN258GIg0LoDCBFYWs2csHBGnkVB87YNjEmUoEtP5Dewy01nzcVEdYxE8UuqLBi2XsB6mps7ONHhfCK60xw9OlHuLPiN8oWlkhzn3dVh9t+Ed9M9mvmMU/nNXMeHkCE+gcAfpMiJ+QOdwcXe7+cpc8RYeuiJZth9EIxevuLKkL2yQhJRexuOmdMHBjdPjFRogBCzKxfd/P8MzyabCB1Giy1PQ5rWMj082WJgfBWIHit4q2k3kG6v0OwZr0D6Ho0sf5ONNoECAmuZkDGqrzOTMEW4yysE/aq78rVTkZdlQEotJfRUuaafxZq3DT/+nYiWCBTYG+IEmjuIDO6Bq48D+cyiV39j4N9aShPVobavYYvuVokR2z2BFOD1F4y93ceUd/sljmpVpmmArWGwUel0Pw4tdl2bHcYqC3IbQ8gFbfG+Ew5yuLG7Gq3GCA6ajuxX0a+0NbHRDxMYHQkc0U8j1HvFhXEMOXtjsLoSVKhIG/0mWKEqJ5EuziEw/nKMy/7so8VGskCJ9KeImGeldBGeRbEtMGUtT6RhZOfdoUi7bfDE6E2hRekMbNdL7EYZI4tSXePFn+FmvldELj4v6gHaFvu405glNArZbiNEMy1kJOi28HKi+XjN3WSfdVp95yCj3YAvMHjYJfaOTgE8GghTtyE7UbPIBrlciCdPwNH159HnTda+4IrhiP3FL4MrBi2K9HegIYRj5zA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014)(921020)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9m/XK7oEWUN9sKWXsuIVimS5pQKxHYnw8nUek4FDGc+ux3k0YBgdCeo0LZD2?=
 =?us-ascii?Q?ToJP5kGR6+s89Q/iBhfsICO0I0VA4G6S4tQHThViMGAAGVahklM9c4NT4kTv?=
 =?us-ascii?Q?7t+LuK6iMa7o4uuprR/20HNxqBagvxSS0nAYgcKM0Ev/jAum8qOCtVNHxYEq?=
 =?us-ascii?Q?tRyLZSFtATTkyNf5cRNxEzQJFCY6vbxcxQtYGnMFVSE4ynyFYFY95tkRJxHM?=
 =?us-ascii?Q?QEX+tRi7kmi9tjULVsUc+HtPtXzRtC7AKFvGJLK0v1DU/qyzo3P4R8PTf5Pk?=
 =?us-ascii?Q?TH8xEDynZeYdTW6n+aVhFofdp26ahpd91kGZ3JJCKgYhPgpmECcxRkFg9etU?=
 =?us-ascii?Q?NI79LdgvjbDinKDbI/a02QusVe8W0K1AX0lKmKu/t3pmHni83O2jhtVUpcbn?=
 =?us-ascii?Q?4dfztw6rLUEdW5EdvIbZFggacHZmVu4rpOUkBxBd6G1/wUZPp/KlBWSfxxcP?=
 =?us-ascii?Q?qwcXpe9XJjLTuM8lYDBA7sNVTnlqvqvj9ui8w58NWYq4uJeKft6lKD+iTx96?=
 =?us-ascii?Q?xkVG/eiajy8pPbOSypZzWyN7uoaZlT6p6pMcJYtwnv3Vf6to5YZQuDaYumgh?=
 =?us-ascii?Q?yxwdTH/GNoN00f9UM2xfpMv6dTXbimdwGyJC/wJevUAJeIRu8aZ/GwVu8+e8?=
 =?us-ascii?Q?nTrS87+fYTDUDtx1OwkTssuzXUeG0a3eJbYO3i1kmfbz0vJLqg4M3botaMRE?=
 =?us-ascii?Q?EO/pnLbAzkjUkMNSzF3HqbR1lzVQI1PP+Hnkk/tRqa7udIz4I+QWniJBhvQ6?=
 =?us-ascii?Q?GAMjUAh29P4n7aLaRYM2kz4dqCnpV9waDkMvnkZXOQD/b7M3kjPMN4B2SOyZ?=
 =?us-ascii?Q?GpqWx1qg9CTB63DEiQr1x7uvOXk0vMjITx5V5qmaSBMY+HIeQm2pjUuS8NiG?=
 =?us-ascii?Q?KxhQY1NZx3qCv+m81o7t/vL9ReBsIC6dBFB8phV/VWwcVZ8rtzcL2t72IIJA?=
 =?us-ascii?Q?lYKYKhkFVcDSEwHdpbY77kq/abT1av4rJw1EctlaBhzA6w0HIBrC20VDTmCu?=
 =?us-ascii?Q?kYrICQf/ah+y5IGU8m8Ve0PTxncDEYyTd7GhT6tXITb99Ey3IQp5NGmiNlkh?=
 =?us-ascii?Q?um91yUambAEvhN1Dz3ELVxhnmj/FhypF/HrOgrufakbMDb3Bcfm54YIxY5Nj?=
 =?us-ascii?Q?qkqgmbApOFzV+oXU0cZiByiKOXLzo2UTgm0/gRALvKQFhpIO9v7PxWWmG5iG?=
 =?us-ascii?Q?V04k3MejjFk54YvV6Grd7p0W37QX6EiM+dY6ZHGkVAGwhsAm4OShEkGg2wiV?=
 =?us-ascii?Q?YdQGgCEiRePMQ8AdsXOTpGlWXyeBTFhcZHRLEiyvGg+zLqMLxTn2hN9FCQKa?=
 =?us-ascii?Q?LfHbrnR/ALoDXm4mM76detqymepDlTM/vCPTJGRttwsKNTbWGLsVem7flGQK?=
 =?us-ascii?Q?j6iVC/Ku5Q/cT3305PVmyM8tKHJXDPFw4LGpal/Pek/dyxdfntHswus0JPQa?=
 =?us-ascii?Q?GDkt3iyTiKAkJMeBaFJVpGY3G8QaVZd2tnSOJRkmrbyMwqPPprl6e1w77c+2?=
 =?us-ascii?Q?+3Q0n/oshbjEjk9+F62Rn/RSSr/aSXJGTu2YBTt/T7VqXg8YeGA5FqB4sjtf?=
 =?us-ascii?Q?ITXZbxXRclqUQt9dHPtrErwzrcI4d1jpSf39NUDRIKHwux+YHoaXiTiTUUPQ?=
 =?us-ascii?Q?zQy0aiNblyEjRaJovYYsDkLHKYoA4NE7egTIg0ryWzOrwmKX1uwOo5vnRA4e?=
 =?us-ascii?Q?bDbIZXv6+gGf0RLf/3PhIvydr7c5TIPwAYXiCOoQSUOZrZCM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245da048-ad3f-4e4c-6467-08deb4b6ef88
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:24:53.2271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXw2+6l1KWhmiO5+/9ySs8Tmpwwxc5NEOQKKPJrOUWrXjO3oGsfB+bpwfoV04h4FILScRYLbxIfkAOZIrIxQMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8938

The buffer pool is a quantity of memory available for buffering a group
of flows (e.g. frames having the same priority, frames received from the
same port), while waiting to be transmitted on a port. The buffer pool
tracks internal memory consumption with upper bound limits and optionally
a non-shared portion when associated with a shared buffer pool. Currently
the shared buffer pool is not supported, it will be added in the future.

For i.MX94, the switch has 4 ports and 8 buffer pools, so each port is
allocated two buffer pools. For frames with priorities of 0 to 3, they
will be mapped to the first buffer pool; For frames with priorities of
4 to 7, they will be mapped to the second buffer pool. Each buffer pool
has a flow control on threshold and a flow control off threshold. By
setting these threshold, add the flow control support to each port.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c      | 130 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_platform.c  |   2 +-
 drivers/net/dsa/netc/netc_switch.h    |  19 ++++
 drivers/net/dsa/netc/netc_switch_hw.h |  10 ++
 4 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 9dcaa04d9a65..bc1962b38cda 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -212,6 +212,9 @@ static void netc_get_switch_capabilities(struct netc_switch *priv)
 
 	val = netc_base_rd(regs, NETC_HTMCAPR);
 	priv->htmcapr_num_words = FIELD_GET(HTMCAPR_NUM_WORDS, val);
+
+	val = netc_base_rd(regs, NETC_BPCAPR);
+	priv->num_bp = FIELD_GET(BPCAPR_NUM_BP, val);
 }
 
 static int netc_init_all_ports(struct netc_switch *priv)
@@ -403,6 +406,15 @@ static void netc_port_fixed_config(struct netc_port *np)
 	/* Enable L2 and L3 DOS */
 	netc_port_rmw(np, NETC_PCR, PCR_L2DOSE | PCR_L3DOSE,
 		      PCR_L2DOSE | PCR_L3DOSE);
+
+	/* Set the quanta value of TX PAUSE frame */
+	netc_mac_port_wr(np, NETC_PM_PAUSE_QUANTA(0), NETC_PAUSE_QUANTA);
+
+	/* When a quanta timer counts down and reaches this value,
+	 * the MAC sends a refresh PAUSE frame with the programmed
+	 * full quanta value if a pause condition still exists.
+	 */
+	netc_mac_port_wr(np, NETC_PM_PAUSE_THRESH(0), NETC_PAUSE_THRESH);
 }
 
 static void netc_port_default_config(struct netc_port *np)
@@ -636,6 +648,79 @@ static int netc_add_standalone_fdb_bcast_entry(struct netc_switch *priv)
 				       bcast, NETC_STANDALONE_PVID);
 }
 
+static void netc_port_set_pbpmcr(struct netc_port *np, u64 mapping)
+{
+	u32 pbpmcr0 = lower_32_bits(mapping);
+	u32 pbpmcr1 = upper_32_bits(mapping);
+
+	netc_port_wr(np, NETC_PBPMCR0, pbpmcr0);
+	netc_port_wr(np, NETC_PBPMCR1, pbpmcr1);
+}
+
+static void netc_ipv_to_buffer_pool_mapping(struct netc_switch *priv)
+{
+	int bp_per_port = priv->num_bp / priv->info->num_ports;
+	int q = NETC_IPV_NUM / bp_per_port;
+	int r = NETC_IPV_NUM % bp_per_port;
+	int num = q + r;
+
+	/* IPV-to-buffer-pool mapping per port:
+	 * Each port is allocated 'bp_per_port' buffer pools and supports 8
+	 * IPVs, where a higher IPV indicates a higher frame priority. Each
+	 * IPV can be mapped to only one buffer pool, from hardware design
+	 * perspective, bp_per_port will not be greater than 8. So 'q' will
+	 * not be 0.
+	 *
+	 * The mapping rule is as follows:
+	 * - The first 'num' IPVs share the port's first buffer pool (index
+	 * 'base_id').
+	 * - After that, every 'q' IPVs share one buffer pool, with pool
+	 * indices increasing sequentially.
+	 */
+	for (int i = 0; i < priv->info->num_ports; i++) {
+		u32 base_id = i * bp_per_port;
+		u32 bp_id = base_id;
+		u64 mapping = 0;
+
+		for (int ipv = 0; ipv < NETC_IPV_NUM; ipv++) {
+			/* Update the buffer pool index */
+			if (ipv >= num)
+				bp_id = base_id + ((ipv - num) / q) + 1;
+
+			mapping |= (u64)bp_id << (ipv * 8);
+		}
+
+		netc_port_set_pbpmcr(priv->ports[i], mapping);
+	}
+}
+
+static int netc_switch_bpt_default_config(struct netc_switch *priv)
+{
+	if (priv->num_bp < priv->info->num_ports)
+		return -EINVAL;
+
+	priv->bpt_list = devm_kcalloc(priv->dev, priv->num_bp,
+				      sizeof(struct bpt_cfge_data),
+				      GFP_KERNEL);
+	if (!priv->bpt_list)
+		return -ENOMEM;
+
+	/* Initialize the maximum threshold of each buffer pool entry */
+	for (int i = 0; i < priv->num_bp; i++) {
+		struct bpt_cfge_data *cfge = &priv->bpt_list[i];
+		int err;
+
+		cfge->max_thresh = cpu_to_le16(NETC_BP_THRESH);
+		err = ntmp_bpt_update_entry(&priv->ntmp, i, cfge);
+		if (err)
+			return err;
+	}
+
+	netc_ipv_to_buffer_pool_mapping(priv);
+
+	return 0;
+}
+
 static int netc_setup(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
@@ -665,6 +750,10 @@ static int netc_setup(struct dsa_switch *ds)
 	dsa_switch_for_each_available_port(dp, ds)
 		netc_port_default_config(priv->ports[dp->index]);
 
+	err = netc_switch_bpt_default_config(priv);
+	if (err)
+		goto free_lock_and_ntmp_user;
+
 	err = netc_add_standalone_vlan_entry(priv);
 	if (err)
 		goto free_lock_and_ntmp_user;
@@ -1218,6 +1307,45 @@ static void netc_port_set_rmii_mii_mac(struct netc_port *np,
 	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
 }
 
+static void netc_port_set_tx_pause(struct netc_port *np, bool tx_pause)
+{
+	struct netc_switch *priv = np->switch_priv;
+	int port = np->dp->index;
+	int i, j, num_bp;
+
+	num_bp = priv->num_bp / priv->info->num_ports;
+	for (i = 0, j = port * num_bp; i < num_bp; i++, j++) {
+		struct bpt_cfge_data *cfge = &priv->bpt_list[j];
+		struct bpt_cfge_data old_cfge = *cfge;
+
+		if (tx_pause) {
+			cfge->fc_on_thresh = cpu_to_le16(NETC_FC_THRESH_ON);
+			cfge->fc_off_thresh = cpu_to_le16(NETC_FC_THRESH_OFF);
+			cfge->fccfg_sbpen = FIELD_PREP(BPT_FC_CFG,
+						       BPT_FC_CFG_EN_BPFC);
+			cfge->fc_ports = cpu_to_le32(BIT(port));
+		} else {
+			cfge->fc_on_thresh = cpu_to_le16(0);
+			cfge->fc_off_thresh = cpu_to_le16(0);
+			cfge->fccfg_sbpen = 0;
+			cfge->fc_ports = cpu_to_le32(0);
+		}
+
+		if (ntmp_bpt_update_entry(&priv->ntmp, j, cfge)) {
+			*cfge = old_cfge;
+			dev_warn(priv->dev,
+				 "Failed to %s TX pause of buffer pool %d (swp%d)\n",
+				 tx_pause ? "enable" : "disable", j, port);
+		}
+	}
+}
+
+static void netc_port_set_rx_pause(struct netc_port *np, bool rx_pause)
+{
+	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_PAUSE_IGN,
+			  rx_pause ? 0 : PM_CMD_CFG_PAUSE_IGN);
+}
+
 static void netc_port_mac_rx_enable(struct netc_port *np)
 {
 	netc_port_rmw(np, NETC_POR, POR_RXDIS, 0);
@@ -1319,6 +1447,8 @@ static void netc_mac_link_up(struct phylink_config *config,
 	    interface == PHY_INTERFACE_MODE_MII)
 		netc_port_set_rmii_mii_mac(np, speed, duplex);
 
+	netc_port_set_tx_pause(np, tx_pause);
+	netc_port_set_rx_pause(np, rx_pause);
 	netc_port_mac_tx_enable(np);
 	netc_port_mac_rx_enable(np);
 }
diff --git a/drivers/net/dsa/netc/netc_platform.c b/drivers/net/dsa/netc/netc_platform.c
index bb4f92d238cb..34aeb6fceb3c 100644
--- a/drivers/net/dsa/netc/netc_platform.c
+++ b/drivers/net/dsa/netc/netc_platform.c
@@ -14,7 +14,7 @@ struct netc_switch_platform {
 static void imx94_switch_phylink_get_caps(int port,
 					  struct phylink_config *config)
 {
-	config->mac_capabilities = MAC_1000FD;
+	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE | MAC_1000FD;
 
 	switch (port) {
 	case 0 ... 1:
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index bef356500329..f587c5031c70 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -28,11 +28,27 @@
 
 #define NETC_TC_NUM			8
 #define NETC_CBDR_NUM			2
+#define NETC_IPV_NUM			8
 
 #define NETC_MAX_FRAME_LEN		9600
 
 #define NETC_STANDALONE_PVID		0
 
+/* Threshold format: MANT (bits 11:4) * 2^EXP (bits 3:0)
+ * Unit: Memory words (average of 20 bytes each)
+ * NETC_BP_THRESH = 0x8c3, MANT = 0x8c, EXP = 3. Threshold: 1120 words
+ * NETC_FC_THRESH_ON = 0x733, MANT = 0x73, EXP = 3. Threshold: 920 words
+ * NETC_FC_THRESH_OFF = 0x263, MANT = 0x26, EXP = 3. Threshold: 304 words
+ */
+#define NETC_BP_THRESH			0x8c3
+#define NETC_FC_THRESH_ON		0x733
+#define NETC_FC_THRESH_OFF		0x263
+
+/* PAUSE quanta: 0xFFFF = 65535 quanta (each quanta = 512 bit times) */
+#define NETC_PAUSE_QUANTA		0xFFFF
+/* PAUSE refresh threshold: send refresh when timer reaches this value */
+#define NETC_PAUSE_THRESH		0x7FFF
+
 struct netc_switch;
 
 struct netc_switch_info {
@@ -94,6 +110,9 @@ struct netc_switch {
 
 	/* Switch hardware capabilities */
 	u32 htmcapr_num_words;
+	u32 num_bp;
+
+	struct bpt_cfge_data *bpt_list;
 };
 
 #define NETC_PRIV(ds)			((struct netc_switch *)((ds)->priv))
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index 5137187ee8a0..78335c399955 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -12,6 +12,12 @@
 #define NETC_SWITCH_DEVICE_ID		0xeef2
 
 /* Definition of Switch base registers */
+#define NETC_BPCAPR			0x0008
+#define  BPCAPR_NUM_BP			GENMASK(7, 0)
+
+#define NETC_PBPMCR0			0x0400
+#define NETC_PBPMCR1			0x0404
+
 #define NETC_CBDRMR(a)			(0x0800 + (a) * 0x30)
 #define NETC_CBDRBAR0(a)		(0x0810 + (a) * 0x30)
 #define NETC_CBDRBAR1(a)		(0x0814 + (a) * 0x30)
@@ -152,6 +158,7 @@ enum netc_stg_stage {
 #define NETC_PM_CMD_CFG(a)		(0x1008 + (a) * 0x400)
 #define  PM_CMD_CFG_TX_EN		BIT(0)
 #define  PM_CMD_CFG_RX_EN		BIT(1)
+#define  PM_CMD_CFG_PAUSE_IGN		BIT(8)
 
 #define NETC_PM_MAXFRM(a)		(0x1014 + (a) * 0x400)
 #define  PM_MAXFRAM			GENMASK(15, 0)
@@ -160,6 +167,9 @@ enum netc_stg_stage {
 #define  PM_IEVENT_TX_EMPTY		BIT(5)
 #define  PM_IEVENT_RX_EMPTY		BIT(6)
 
+#define NETC_PM_PAUSE_QUANTA(a)		(0x1054 + (a) * 0x400)
+#define NETC_PM_PAUSE_THRESH(a)		(0x1064 + (a) * 0x400)
+
 #define NETC_PM_IF_MODE(a)		(0x1300 + (a) * 0x400)
 #define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
 #define   IFMODE_MII			1
-- 
2.34.1



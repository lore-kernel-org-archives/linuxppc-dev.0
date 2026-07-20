Return-Path: <linuxppc-dev+bounces-24436-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECB7C44512
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 02:13:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3PFG4wXmz2yll;
	Mon, 20 Jul 2026 12:13:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784513602;
	cv=pass; b=AXaAC5mC2sDoMskdmauL6PrQYQKkTQI4zuiAtraosC/Yl8vYBk40NzCk6GW5skUYAjl9Kbz+W6SZ9wiFNcOhv6frA5iRBtEgTOQGnlOT6DYQKRqNfuH5f6FvH2ga/PC+kW4CzllA/80UkIA28EBirkuXe7bLt+8CNacqQx1/ruUOjkLSkVMwqWjKFUP2ygkNhC1+WtJqUb8/2epN3xlYIhHMChiFjOoIim0kDbCHxjt9dUndLlAbCqXQ5G8O8rsWU8k66UxrWP1a3sL/KcfFGznTcnv/XGZKylaNKVGYbs86q43rhVPA+r/AM+sUOuy16sGW4sHOS7s3MzzhLjMH3A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784513602; c=relaxed/relaxed;
	bh=T+y78fiqMkApwkZWG4to5BCfnVS+OQEVvEE68nctz6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bI1b+XQ9lJlPgSGLckdo5eKJDnh28kF9Zx90GGhd+R4FGoCenTlmVrIYEn2dLfYKVrDkeDN5V34D5JqEuAZ0EHNYGKHPP2SDyl3DHtfXrV/lLaQV0YHZhtjNbGU5uIx84A1ORq5AVuzy9bGomUvANYuAs8LjDre7nnQXZMUjIaSmEobMdRHyrcDrhwYB+3SB4aR6sabDgk99lnbzIc/ugMYAYZ2bU5B1i8a4zi6ZTZb25h1mmCWz76I4QHgmUaNuNr+r3RDDHjZNO2sKl1pud/3t1hHH+xJJRpc1fizVjqdX4iBrnHvZbhKIxx30AOPaFaYsB7QOOiSMGCZsNGtbyA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=F1MV70he; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=F1MV70he;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3PFF5hbnz3c3v
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 12:13:21 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSVuSHKwsL7we5fbLu4bJj2px8VPuMu6mPGsymOx4c1N3cHciWFr9emJ8vh24k8Ni/48Im43JfyS1k1Oo300JillB+GXXFQye1qiSGq9v2uG8RGgynC45HinIof7axz8ORYjoNxRoP4NK2XKrIq0tLF9m6Si5QmFtJUitL2LNDbKPi8Hr9Ln7WsxV5tGSeYT1fA4NOwnWGAQpWSiJwUUe2+EXE7IqZea8Lkf2SAHWVCcQ1WEk8H+aQCVRXBCKMR9UR2AM6RV5uiGZiuThJhc6nO5yXsKY+Bdm/+0eYJW1NM3IzodWpbs29R0+J+8ltGi4NFbeuFPUnpcBqleG1gNhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+y78fiqMkApwkZWG4to5BCfnVS+OQEVvEE68nctz6g=;
 b=bo1XR00c/1EAmscT5K2xg/WOd+Oa4r+QpKH3/+4nBzY35lDBPR1a74lVx8ZVITJIwdvQ3Bkc+82is5cblZmGTtvM2azO3W/K/XIdJdHYs5qpv6Nuk1Ih2/5Xna+6SJp3YXZ5ASbJMS3EO+BSnoh/Ap33vUd39Yrla55dpeSZN1zCxVvDNoWvz6jwzTk3it39NzejyFDmQ3bCe5iGQCJ6pgwPiUtUA8+9HFVRHXVbAIcE18wF2drYQEZRlow5sQC8n8tT2E9NgrlsrOEUAAshON9/lAzpa8cS7HJaG/wrfcl9X7zqGiFvFrr9p1h1QIKBL3dAOh6Kv2pPz6U9BRQjgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+y78fiqMkApwkZWG4to5BCfnVS+OQEVvEE68nctz6g=;
 b=F1MV70hek1eMTnoPcpmPQGW0buNVR0LO4jCKi85cN32N4nIHqqCtM/G9MDWuPB7KBIcvvL63/wzdKcDPl7HFHn+gqvPdzE6WJNNNU0Y7Q3HBibZJ6lVtgHlGROLFWWId57JalZN/1xdJIx0LwpE7PkoBDnMc/pxo1OKYoAtCKwKwKQBeFckJAbivaYYrz2efPZBlGrxpjHLpQefocOUjNIiAXZj+f8HU8aFrxla3JDIhSoOC//hftVFyn6hpoCe33+HhSbwCuN0j1Gi58+B/2yrV611urukd/wBHpefFZVBMmR2tm90hlkweF+MRW5G2BFbSN+w3sfP0qqOAczCBcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GV1PR04MB10872.eurprd04.prod.outlook.com (2603:10a6:150:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Mon, 20 Jul
 2026 02:13:03 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 02:13:03 +0000
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
Subject: [PATCH RESEND v4 net-next 11/14] net: enetc: move enetc_set_si_vlan_promisc() to enetc_pf_common.c
Date: Mon, 20 Jul 2026 09:43:13 +0800
Message-Id: <20260720014317.1059359-12-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::11) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GV1PR04MB10872:EE_
X-MS-Office365-Filtering-Correlation-Id: 2902719b-e20e-4dab-525e-08dee6046e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|19092799006|921020|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	zP11ekuWUS2nQf9pAd9TGG7qfy7d7p6JsEZvkO+yT7h0WjrnrfunpZseO+sUfwrJYwD5vQskxm2+NhR66OgNItegZdhx6tMsMpvuqXiT6VpTHi7NcP1p0s9Ck/Llix+S/WAD/5wj1p2+SrJCKWJzX/EFgM3jL8ovPy57XWFAT9dfZuYON4BlVcULneH8Wi20D+GrdwEomiBJSyKkktNb2WXXFFjI2InCduK4KGRBBVhKqyciejBETChnYOBm5fNklt266EHqltUrDESYwoRVWupiHfiBTLgRdGAwfVYzkW0Cfs1zrk79pBshC9bUyO/r7dYeIsLwXVOO6h0316/NhLxuY8kOr4xlOzDzeEO434OAVL7oeKwzL14SKTAWcRZJWFa7IqmgPmSwHCHaZEu+iYW5BBg1DXxu6LVunDExOwXdaetkL6TzuYTqePphRzUwbJRZHhqETx/iWh9p27C2S4Jb4vA89k2hLqRJU93MVz0TwZHjQ7xcH6I5EHf2dmjwjDAXCXLm1QiVJdjwUB4J4lVNNwdSHm14/YUZunRRapPW0r6pEU6jwT3lPImsaFHo8VBfsCioe0dW5i70Bx7fljQMRLA2gvBUZDWSNH28l2SvN5TKdsaMMBolTHtA8/FoQ1kbfeTPMe83EFuGxC8lujZ7GqW0NEIWYLGsFbgmp/TRd8of+BuZvnsvqf+qB7ZsBlw59KFR6hrOKxgTT1gs1Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(19092799006)(921020)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Of2Yyp7DxFBoZcqtZVvNgPDg5qf/0XgqxgRbi4/kWhUKnwB1zlKLGcLxFme9?=
 =?us-ascii?Q?Jmqj1/ua1Pe0gxNuNvzlFfASAJ+F2NZva3gYVhsui56vpNjMitd+7pxndTf3?=
 =?us-ascii?Q?I2lQO0uIGjsBZ4ogG2M2aqhpliz2DQ48Or20EfxhDCMzxiIZV4DsVDB/xtwI?=
 =?us-ascii?Q?G30miTlKtBGD/Pvc/mYvIClrxh16XhmtKYdeCIu8/D7NjIy4WiIeU4uc6cY/?=
 =?us-ascii?Q?40urBAZlWy+Y5TG8HCfy4uUtJmnGqlvhyrQ1nmb9+YsXxX3MU7z6n99pmrAT?=
 =?us-ascii?Q?AHj55UzmWQM6ICwhixGCqmfm6ptqJhP37No1GjlU7Pz0JpaqAMtdIFizRNAY?=
 =?us-ascii?Q?LP8y6R2PkhIcYSKle9DeFvm/4DsaFwpygwGe7ExlfaxhYpL/Ugv/EdINXvLG?=
 =?us-ascii?Q?B/XW8D3mW8je9vniYCeCZLp+BvedQ6e2xnhVX2zxsrWML4k50Yg7qbB3hUNW?=
 =?us-ascii?Q?H88QLSREhTWmLg5YoRs+uuYaW+ixnGNsFat2V3dQ2K/GacCV8OLUwhKQnZGa?=
 =?us-ascii?Q?t1+pOhpnVlbQFfV1qovD8qspBMTLG08pbK2pkwt76KC6q+T6mfJ4t/d6GZDv?=
 =?us-ascii?Q?HO/ZVjwePqsYeefpoccR0rHPoq5Os49qhgj4Lj31wGri3mcgRDDy+sjbVz/S?=
 =?us-ascii?Q?zgiRqg3ml4cM3VvOVAo5KYoQt79l8uHlBb33vL8lpG6U4NKbW0laeSUEvDUJ?=
 =?us-ascii?Q?9LiXBvJt1yAhE1N5KMc/JiGJtcsoENeQhmqO5pVegiUG0RSReLmz4lIeZDdD?=
 =?us-ascii?Q?VRUFK46s6WbbRi2sAbhFCkUz302x+ZAMnvPLxAGHsvdnGsVpWOEthd4UnyjJ?=
 =?us-ascii?Q?VLH59XaVq98q4oC9bMuoTEtGinKDLngPpogdmS6GbPgqKVSohtaK3zpsjZm4?=
 =?us-ascii?Q?Q7Iw4SkRj6wDZ8GM/hYQx4jGXskyv4S1wMH52dNWG6qOfjBSdpwvxQhYVwin?=
 =?us-ascii?Q?i6Og0+lQxpp2qp/JIoP2IUcKjYBjhkd6JzDu5hCM9Nq9XBsWJriEGJ9yTDzg?=
 =?us-ascii?Q?X4MRbpceJzLLAQHf2LsJxZWJ+YrYkhZgfo163j2Teefir7WwHv3KPnyqUSGu?=
 =?us-ascii?Q?l5Fnkl2ACEwJyyEEF8g2ps4MI/CQDr1s2xHUH9+I4789h9goMIUa6e6VUc5G?=
 =?us-ascii?Q?mSd/BaoHOuTm8RrXaM278Rib4qTO1vofjCJVyklL967elkXw9AtTzjcpo/k6?=
 =?us-ascii?Q?Aejq0v3Yfst4NYVxNPSYcQano2uCk06vSIG3bziOD7Rsk4dGHtALXjSnBUIb?=
 =?us-ascii?Q?5Q/XJdt75SJ+CN8sA1zNTQ4j/RgszmghJQfLVm5/omGIMeyjxmUcfKQEY2sy?=
 =?us-ascii?Q?eDO8J7osiS3wAaFoaNITQxAd+nQJ5wef4WS0yhWpFSXuXv2zLz9zra3/oyLx?=
 =?us-ascii?Q?OAtHrWBBrj9K/RMeNxGIswkEA6s1LO6tSHnzR2d1rC6Y1e4r4Dp2RL0BQtmp?=
 =?us-ascii?Q?YAxUmCnuRi2lZcT8feYVTxuYhkQJ2DpBAtwbuxxMfRjbitApeGRHA255RizR?=
 =?us-ascii?Q?eXyCXlut1wRHo2TeXCAzfk5+26wqEZ0QUDEtgXJejyHEU/XOJvQGQnZ7zujg?=
 =?us-ascii?Q?Z4VCOqNbVSsCM8OGZ0JYApKdtObMorr70qvxJihu6i7KpGQoW4gINnY0Anba?=
 =?us-ascii?Q?ekWpVH5wNl4C27e4H+ZJUDx/L7sQjdxPpVH9EkUYBmvjWmRx60rtrWUWS4M7?=
 =?us-ascii?Q?pA1Mj3msNiZkhu3als6rrFzOTnJqgeix/rg2nw5UPko1jXpu24KFspjG4W0o?=
 =?us-ascii?Q?BsIvlNi/ZBbyz9vxXLflv6ZlgudTdMAH/Tbgv+ytZ8/P28RyguUE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2902719b-e20e-4dab-525e-08dee6046e2b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 02:13:03.7109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: khFwXbPTHur8qVVTiWsptIPOqS3iJdbwsqlGqKp4zZ8vmrNxTYUVGblRe+sUWqk/1DPE1WP4knOeH/L+n8cUAvcv+jSNq/xanLYgGTT2yRn3JX50O3nllS4GlxBqYOXW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10872

From: Wei Fang <wei.fang@nxp.com>

The PSIPVMR in ENETC v4 has the same bit layout and functionality as the
PSIPVMR register in ENETC v1: bit n (n <= 15) controls VLAN promiscuous
mode for SI n. The only difference between the two hardware generations
is the register address offset.

Since the register functionality is identical, the VLAN promiscuous mode
setting code can be shared between ENETC v1 and v4 drivers.

Move enetc_set_si_vlan_promisc() from enetc_pf.c to enetc_pf_common.c
and export it so that it can be shared between the two drivers. Add a
revision check using is_enetc_rev1() to select the correct register
offset (ENETC_PSIPVMR for v1 and ENETC4_PSIPVMR for v4) while keeping
the same logic.

Remove the v4-specific enetc4_pf_set_si_vlan_promisc() from enetc4_pf.c
and replace its call site with the new common enetc_set_si_vlan_promisc()
to eliminate code duplication.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 17 ++------------
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 16 --------------
 .../freescale/enetc/enetc_pf_common.c         | 22 +++++++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  1 +
 4 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 505e4abf6c37..cab79f81d6fe 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -295,18 +295,6 @@ static void enetc4_allocate_si_rings(struct enetc_pf *pf)
 	enetc4_default_rings_allocation(pf);
 }
 
-static void enetc4_pf_set_si_vlan_promisc(struct enetc_hw *hw, int si, bool en)
-{
-	u32 val = enetc_port_rd(hw, ENETC4_PSIPVMR);
-
-	if (en)
-		val |= BIT(si);
-	else
-		val &= ~BIT(si);
-
-	enetc_port_wr(hw, ENETC4_PSIPVMR, val);
-}
-
 /* Allocate the number of MSI-X vectors for per SI. */
 static void enetc4_set_si_msix_num(struct enetc_pf *pf)
 {
@@ -352,7 +340,7 @@ static void enetc4_configure_port_si(struct enetc_pf *pf)
 
 	/* Enforce VLAN promiscuous mode for all SIs */
 	for (int i = 0; i < pf->caps.num_vsi + 1; i++)
-		enetc4_pf_set_si_vlan_promisc(hw, i, true);
+		enetc_set_si_vlan_promisc(pf->si, i, true);
 
 	/* Disable SI MAC multicast & unicast promiscuous */
 	enetc_port_wr(hw, ENETC4_PSIPMMR, 0);
@@ -518,12 +506,11 @@ static int enetc4_pf_set_features(struct net_device *ndev,
 {
 	netdev_features_t changed = ndev->features ^ features;
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_hw *hw = &priv->si->hw;
 
 	if (changed & NETIF_F_HW_VLAN_CTAG_FILTER) {
 		bool promisc_en = !(features & NETIF_F_HW_VLAN_CTAG_FILTER);
 
-		enetc4_pf_set_si_vlan_promisc(hw, 0, promisc_en);
+		enetc_set_si_vlan_promisc(priv->si, 0, promisc_en);
 	}
 
 	if (changed & NETIF_F_LOOPBACK)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index afc02ed62c77..a509929f89f2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -42,22 +42,6 @@ static void enetc_pf_destroy_pcs(struct phylink_pcs *pcs)
 	lynx_pcs_destroy(pcs);
 }
 
-static void enetc_set_si_vlan_promisc(struct enetc_si *si, int si_id,
-				      bool promisc)
-{
-	struct enetc_hw *hw = &si->hw;
-	u32 val;
-
-	val = enetc_port_rd(hw, ENETC_PSIPVMR);
-
-	if (promisc)
-		val |= PSIPVMR_SI_VLAN_P(si_id);
-	else
-		val &= ~PSIPVMR_SI_VLAN_P(si_id);
-
-	enetc_port_wr(hw, ENETC_PSIPVMR, val);
-}
-
 static void enetc_set_isol_vlan(struct enetc_hw *hw, int si, u16 vlan, u8 qos)
 {
 	u32 val = 0;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 781b22198ca8..d32a195a04c9 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -171,6 +171,28 @@ void enetc_set_si_mc_hash_filter(struct enetc_si *si, int si_id, u64 hash)
 }
 EXPORT_SYMBOL_GPL(enetc_set_si_mc_hash_filter);
 
+void enetc_set_si_vlan_promisc(struct enetc_si *si, int si_id, bool promisc)
+{
+	struct enetc_hw *hw = &si->hw;
+	int psipvmr_off;
+	u32 val;
+
+	if (is_enetc_rev1(si))
+		psipvmr_off = ENETC_PSIPVMR;
+	else
+		psipvmr_off = ENETC4_PSIPVMR;
+
+	val = enetc_port_rd(hw, psipvmr_off);
+
+	if (promisc)
+		val |= PSIPVMR_SI_VLAN_P(si_id);
+	else
+		val &= ~PSIPVMR_SI_VLAN_P(si_id);
+
+	enetc_port_wr(hw, psipvmr_off, val);
+}
+EXPORT_SYMBOL_GPL(enetc_set_si_vlan_promisc);
+
 void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 			   const struct net_device_ops *ndev_ops)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index bf9029b0a017..8243ce0de57f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -21,6 +21,7 @@ void enetc_set_si_uc_promisc(struct enetc_si *si, int si_id, bool promisc);
 void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc);
 void enetc_set_si_uc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
 void enetc_set_si_mc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
+void enetc_set_si_vlan_promisc(struct enetc_si *si, int si_id, bool promisc);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1



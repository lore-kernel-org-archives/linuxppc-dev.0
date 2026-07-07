Return-Path: <linuxppc-dev+bounces-23693-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756B3C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 08:48:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvZcd6hlFz3bsq;
	Tue, 07 Jul 2026 18:48:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783414081;
	cv=pass; b=Rfv996md6LgNphveH8oEhtutKNyf2RbYX6dqvV9I3N6L8+vSvNcxYe6ZnYhRSrdM8ZZbTYV5sJeP2KlVdjc+o3X1kenBFKZjEYu5Uo4HVBg5gLT7OIgku1ySd7gFjcpXTwsh6kvRB/6DrVWTWavWIprG0orqONQ3snXD4CDDYy0JP7CsA/tc1R6+0ACdfU0fv7C5u5cl2lqhEZ1VaaQCrTcB0wh+eMB9cWxH9VnZgfwVWTR5Y19zln0jMUc75IMGKSVC2VP8a5VDTt1Ev6wPKo7UxNffktWvP9BTontauFMZhrniuaERzfAviEKZL48Q/FZTX6OOY4ocAYowaDsVLg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783414081; c=relaxed/relaxed;
	bh=8CT8bO+ZvGjCsF5hZO2ObMW4OE9iaBDYdR5oCZ9JbCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QHwNq5axKKEsXeKLLEHski3Y6+ElnG9T1bwIh13TkHE+KFtyuwCCaPD8Md+gtRq2YI0htKQq8HjkSI+bK998Mwik8557ioL98uBomZESk8W+0/P7AFa4n37jNb0Hv5ZYRpOF6hbnOmDVd1h+HxWJCCW0ORq0ljqGPMwolRLtr+nE3hX/EaoB/z0C3sDyfnvTlKu3IGTTBndf4fXcusmpH6uwq9gL86lmfNncvfZjmJzU1Gt7ztQLo+4LTMFji2wdDsDInDSTTOjrpa3dzCdyv5cTnS2Dgq83+TSaYOg10GCcD8XYfA4JZmiF8x26GWFXqfax3eOdvlIIZnBo9DbfFw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=NWGwDO22; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=NWGwDO22;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvZcc71q1z3c98
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 18:48:00 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E83/hpa1fFAMN8DjbROJrQB4z2jcj9B1HGEVG9nIORpBTOMfSFOCwWvPE4wURPwwUMGpDFF8+QM2xJbgWtEJK0imdVA4nTg0pMnPluZ950H1oxCrJBrP94xGP48Gkaxi+J+ZwP01kJVGqin5qCdT0ANocIy5XMflNpoiCmdkme0t+HOwS1xlnoiA++2TQraQwWyhculpJ6014lXhnSue/LNmrJjVHfNzl/RHztcdAe9vrrhtTL0YmHU9H1k0IhlM9FI6wrxfSYT/pCEFMvP6Srmhu3zXxA0zVFbx2tYTWcZWNitjINQsKr+ntC4jSAzgmMWVdXmNc3EA8WuTEbCSIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CT8bO+ZvGjCsF5hZO2ObMW4OE9iaBDYdR5oCZ9JbCY=;
 b=Pq0oJVg8mqICAsjr3NcolM2RzDt9xDSwGMveLUNjRx/NS5L78DMUWn/yyJY5CLxnGAR2x1VR8wB1z95EVZXI3DIEjeMB2SoRddtsEe3BDXIpTGWk+g36oJKxdh5NZCd/owyo0bfyOi6XT1voohPMsSd9mi2B/vNgRYmX30br6K2rCcXWxInzwnTilHb3M5x2t/v/smQgNSm0+l4DkfF92pFDeOVnDVw5qKjjW9509fqo2IC+OuDY1ziI7jLmKj0TiQ3pVPpY0bYEyE1hsZ94o7/U2XIxMO75jK0jo9mHx/iKCij/snHQouIi/rS4010mKz6X7fVgtQQ9oDy1UW3vdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CT8bO+ZvGjCsF5hZO2ObMW4OE9iaBDYdR5oCZ9JbCY=;
 b=NWGwDO22Vlxe0HoFPS23ede8U168Iee9Ni535kneOS2JeuTBNvP4IkZyWb7GBS/ayUS5dl7Zx4XKyEYIGxc8115fqvgPP4LDx+3d4g+m3vBoI3t2QdtJh5knguRadOVG/AccLMQFHtY5Igdudvwks+dCNq9JVlBvycOOb53bJKQPqO9KYW2mlcPvAb48IfloY258OntrWr3TmCDI/4zikvwZnNsYm5WI6uOoByotQ7G3VEB5Ld+FnJ4bSdQbfPDXvaa9q4bkgS8dBeVqwqWj0IVRoUbaReH58/gAR3k4xb3O47aRl1yHRM0zjn4DgRo3Ky/+xPnBc9A1clBXbJSmNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:47:53 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:47:53 +0000
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
Subject: [PATCH v4 net-next 10/14] net: enetc: refactor SI VLAN promiscuous mode configuration
Date: Tue,  7 Jul 2026 16:18:30 +0800
Message-Id: <20260707081834.710730-11-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707081834.710730-1-wei.fang@oss.nxp.com>
References: <20260707081834.710730-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
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
X-MS-Office365-Filtering-Correlation-Id: 2cb942d8-e272-4f92-7582-08dedc046edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|19092799006|56012099006|6133799003|22082099003|11063799006|18002099003|5023799004|921020;
X-Microsoft-Antispam-Message-Info:
	1cM9hPYjRqfPBJx6NycCH8ulCAz58SjChvV9QdWmc0K5HE4Www7/k3lGjp5RgW9kb4VzyTGkPBUEJeHGWUIHz5Cbtav2nmoYwc9L4pjFjlTwy6bMWkO9VHGwK48/rqB5cLMcuz7eIyjqGc8VUB8lDFI4y4aq1ZnasoP0pwL6MwDafGlzox6gWnBXI8oZGT8t4tWKZWKHKoiZHFuDbiv3v7cVaUHd/edi3VwRBzBzlET/iQQtLA8fOPv+L5EbLbX6suN+F2XfPJvqs2JiSGUp/Xvk2Jtqg+pTate0+XvkNO7+vvAKDQ+VPjw5egbPe6G24VtpU9ApEJfngsMATLmPrX0Gl0M7Nx5W12PZUrPG9U57buMAddg5bPRojrnc8MDPW+SsmJxFPOWfRi4TwaAiFukctAn4mkpSwdDqXeHGH43RqCjVHxhKBora8X6jVImV7VY0kZt67Af7jOrPDfkzhh0IdvTZD9USnat6rRKB5OWUy6k3tIGlR8g80jczmApfDee87tU0k0JB/vQ4oWLO9ja0Fd2rpyfpVPyuNlH8g/2Yyay7NSFap4metY2ez9n4i9W/Rm1KlB/JI4apnxK4tdbR77NMFAKsnIOrxZfAA/i/pE4fDG7GHUelQbTC634xBrp4ga6qPbXcoKy5xwSU6rZShG2eRRzxJ9WCfgKWwzul72+p4bJtg+EBTH/cSKwUnheQF+RgDQR3/4iBJ/V4TQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(19092799006)(56012099006)(6133799003)(22082099003)(11063799006)(18002099003)(5023799004)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+XZlp+G99ZXu+MM6l3BcE79OCOJIe/3DAUFawxkaXMAcWmAbLOFKlfiuQZO0?=
 =?us-ascii?Q?+OayM+Zi60bSOu0dlSgXdB3HZIoQA9Z1RgMTR0DgM1FYbaW3GEn7Cx2T+g2l?=
 =?us-ascii?Q?ATuUQH3gApl9HdCnnYDgjZ9bAyWNnoViFHtvulonprQdT8Fe0PqrTXXTiEFW?=
 =?us-ascii?Q?H53L8tZib0i3q+pdvUwMG9N3WUZgR/SPFCgdlf5rivAJltFhaVLS6aa2CGd7?=
 =?us-ascii?Q?nks2ueGR0EYCXAKODO2co1RzCtQD5Wd08WeQqsj8qfwgL09QLb0aPB4C5FzA?=
 =?us-ascii?Q?T/lz4vMIxmYqWLJ343du1+ylTKgNbOlMqzTpwBkZANO3YBLiwRhfm0jvkEgP?=
 =?us-ascii?Q?xm3yE6SSh/oewi6oV9WJXBT7qoNdDlN4lLPsUBWFf3OaJmu08nzqbOdwfd/j?=
 =?us-ascii?Q?7wTFIuGtmPOFtFWkjZGIImxKr/g10cQGRzM8pAjSFuPqQiu+mGtZYyvB4JKy?=
 =?us-ascii?Q?nVzAvGLZjENDTy9g+3Frd0kyDgHk0gvcKdz8JtZSz0z7pEy6WRnkSs/P27ay?=
 =?us-ascii?Q?G4ac1dBMJa/fM3mUauzfQ2NXy0/xlJDt/T7ZaBM0RzzRSE0xbff5zUreZRtz?=
 =?us-ascii?Q?u8vmkr9H0Xc6AmGbJLpQOl0VNUeejNtdnggzjAWOEACfhBC6xjXP8G97U3n5?=
 =?us-ascii?Q?q94/p6cO135gKSiE6up6ZCzuIJyTh7l451IkfmGK5C0Eb36Dgji0g3848RCv?=
 =?us-ascii?Q?fpYe6Nnj42tGIrGiL29QOWz5yVA77xDgd/fT2VpjdBPkYZR8TNUiaw4qbxnT?=
 =?us-ascii?Q?s2luUdDBCyqWMnAhuga534nZc3jthtSNXZEOen1WlSNtfJj/oEQ0o+/V4qRS?=
 =?us-ascii?Q?C77xNNDVi3I9RlW74UsR/xgDVbhNBUROisK9PTYNy5pQrwabcF87Z/W6uZ18?=
 =?us-ascii?Q?lo4u72mjIm6vqS1wPweTaihiWGE3SbbZVLZoswHMQTQ+++cST+WpYQARCKxP?=
 =?us-ascii?Q?laCuvIkcq5Tqnj/L4eVq07kjCHmCp0dZa9JJA8Ny2FpIrqFUvYleQ9ivh1Rm?=
 =?us-ascii?Q?PwqOt2CVWBYUrI+CcQspNae4Rynb6hWleXjq7g0WL2rJtahYL1Pqqt7/gI6d?=
 =?us-ascii?Q?dlcqbtkyODBIcZZG7TfE/IcyEie9ZPXH1OWasIJ6LJWrPnAkoKPt89Lx5aFO?=
 =?us-ascii?Q?qu/6PORdM6h1c8nLEsDSm5UQgb+ETB/QqgFWNS4FfWVL5BwWs5DN+5py6C/8?=
 =?us-ascii?Q?B850xDdGDV/lrrK1j+EL6A2L2A3833GQq8RXSOClkgsixLH3zAw3MCd1gOib?=
 =?us-ascii?Q?0XUiqonDIbPk5lAgO/9huYjBe+FX8uMQVSEBiNRnmSXjNnQhSPAZ2fAGICoK?=
 =?us-ascii?Q?Qy2vPasNtUAfypwbjHgtNvgYKKs9lWf1wvKlu3hKKPiX/Tk3JaF+tIcOmAgU?=
 =?us-ascii?Q?CAX5/JJifUOinz2T+NPuryGoFkxjSmigapahYY4lhDQB0+/LcsH7r1elPoLu?=
 =?us-ascii?Q?VY4SwPDsR10eI2EIXCWUG4UJA15NFwIAAMknrGQKf6LZio+r2SuO28Z9MtpH?=
 =?us-ascii?Q?jkplh8gxh5mD8oZbPydlE4ZquPgBmnTkhNPMt+iBaDVkbEuqCLgSXnswRfYb?=
 =?us-ascii?Q?M8KVGuDjDcKNkWh3arUtlR6jL5ZNoCzC5lFAMu6K9Uv1rDkGHFdxBN5cFhd7?=
 =?us-ascii?Q?uH9kNGjXeX7b4DEshrDyHnQROswq0bECVw2TpSx+HqXKs6BRU8heO1TGWxJK?=
 =?us-ascii?Q?0iV7sXfVhdObgw3vhxZ+mq41cP2ALvHng56mGNlouuP8MnmoQCTeNC1o/9ov?=
 =?us-ascii?Q?S2I3wm/gvt3bJMCjjAdiE23utki6Sw+mqIbhdUI7lQOJ/Z1PBHCj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb942d8-e272-4f92-7582-08dedc046edb
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:47:53.2437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hfAXV1dIM7IQnMs1WuSt1sir0ITMyu62A+P2iknMmzBz4iIIaXmMihfCMHwvgohuGgxRQd91y6P7GNsGEi0vH8C+39B+CFXp9+c+k4rWOthmTBGm+lzWT71w0bJiIMsw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182

From: Wei Fang <wei.fang@nxp.com>

Remove the enetc_set_vlan_promisc(), enetc_enable_si_vlan_promisc() and
enetc_disable_si_vlan_promisc() functions, and introduce a new unified
function enetc_set_si_vlan_promisc() to enable or disable VLAN
promiscuous mode for a specific SI. This simplifies the logic and makes
the interface more straightforward. The vlan_promisc_simap field in
struct enetc_pf is no longer needed to track the current state.

As ENETC V4 only changes the address offset of PSIPVMR register compared
to V1 without any functional difference, enetc_set_si_vlan_promisc() can
be moved to enetc_pf_common.c in the future with minor adjustments to be
reused by the ENETC V4 driver

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  5 ++-
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 36 ++++++++-----------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 -
 3 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 66bfda60da9c..16da732dc5de 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -185,9 +185,8 @@ enum enetc_bdr_type {TX, RX};
 #define  PSIPMMR_SI_MAC_MP(n)	BIT((n) + 16)
 
 #define ENETC_PSIPVMR		0x001c
-#define ENETC_VLAN_PROMISC_MAP_ALL	0x7
-#define ENETC_PSIPVMR_SET_VP(simap)	((simap) & 0x7)
-#define ENETC_PSIPVMR_SET_VUTA(simap)	(((simap) & 0x7) << 16)
+#define  PSIPVMR_SI_VLAN_P(n)	BIT(n) /* n = SI index */
+
 #define ENETC_PSIPMAR0(n)	(0x0100 + (n) * 0x8) /* n = SI index */
 #define ENETC_PSIPMAR1(n)	(0x0104 + (n) * 0x8)
 #define ENETC_PVCLCTR		0x0208
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index db2a800a7aaf..afc02ed62c77 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -42,24 +42,20 @@ static void enetc_pf_destroy_pcs(struct phylink_pcs *pcs)
 	lynx_pcs_destroy(pcs);
 }
 
-static void enetc_set_vlan_promisc(struct enetc_hw *hw, char si_map)
+static void enetc_set_si_vlan_promisc(struct enetc_si *si, int si_id,
+				      bool promisc)
 {
-	u32 val = enetc_port_rd(hw, ENETC_PSIPVMR);
+	struct enetc_hw *hw = &si->hw;
+	u32 val;
 
-	val &= ~ENETC_PSIPVMR_SET_VP(ENETC_VLAN_PROMISC_MAP_ALL);
-	enetc_port_wr(hw, ENETC_PSIPVMR, ENETC_PSIPVMR_SET_VP(si_map) | val);
-}
+	val = enetc_port_rd(hw, ENETC_PSIPVMR);
 
-static void enetc_enable_si_vlan_promisc(struct enetc_pf *pf, int si_idx)
-{
-	pf->vlan_promisc_simap |= BIT(si_idx);
-	enetc_set_vlan_promisc(&pf->si->hw, pf->vlan_promisc_simap);
-}
+	if (promisc)
+		val |= PSIPVMR_SI_VLAN_P(si_id);
+	else
+		val &= ~PSIPVMR_SI_VLAN_P(si_id);
 
-static void enetc_disable_si_vlan_promisc(struct enetc_pf *pf, int si_idx)
-{
-	pf->vlan_promisc_simap &= ~BIT(si_idx);
-	enetc_set_vlan_promisc(&pf->si->hw, pf->vlan_promisc_simap);
+	enetc_port_wr(hw, ENETC_PSIPVMR, val);
 }
 
 static void enetc_set_isol_vlan(struct enetc_hw *hw, int si, u16 vlan, u8 qos)
@@ -441,10 +437,9 @@ static void enetc_configure_port(struct enetc_pf *pf)
 
 	/* split up RFS entries */
 	enetc_port_assign_rfs_entries(pf->si);
-
 	/* enforce VLAN promisc mode for all SIs */
-	pf->vlan_promisc_simap = ENETC_VLAN_PROMISC_MAP_ALL;
-	enetc_set_vlan_promisc(hw, pf->vlan_promisc_simap);
+	for (int i = 0; i < pf->total_vfs + 1; i++)
+		enetc_set_si_vlan_promisc(pf->si, i, true);
 
 	enetc_port_wr(hw, ENETC_PSIPMMR, 0);
 
@@ -466,12 +461,9 @@ static int enetc_pf_set_features(struct net_device *ndev,
 	}
 
 	if (changed & NETIF_F_HW_VLAN_CTAG_FILTER) {
-		struct enetc_pf *pf = enetc_si_priv(priv->si);
+		bool promisc = !(features & NETIF_F_HW_VLAN_CTAG_FILTER);
 
-		if (!!(features & NETIF_F_HW_VLAN_CTAG_FILTER))
-			enetc_disable_si_vlan_promisc(pf, 0);
-		else
-			enetc_enable_si_vlan_promisc(pf, 0);
+		enetc_set_si_vlan_promisc(priv->si, 0, promisc);
 	}
 
 	if (changed & NETIF_F_LOOPBACK)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 7e886dc49997..1bd3063a3be3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -45,7 +45,6 @@ struct enetc_pf {
 	struct work_struct msg_task;
 	char msg_int_name[ENETC_INT_NAME_MAX];
 
-	char vlan_promisc_simap; /* bitmap of SIs in VLAN promisc mode */
 	DECLARE_BITMAP(vlan_ht_filter, ENETC_VLAN_HT_SIZE);
 	DECLARE_BITMAP(active_vlans, VLAN_N_VID);
 
-- 
2.34.1



Return-Path: <linuxppc-dev+bounces-23343-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5287AC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 03:25:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grMj13Tnwz2yhv;
	Thu, 02 Jul 2026 13:25:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782962741;
	cv=pass; b=DcHWDV6+H7YtfsDGk7COMe5JS3bry0Uqi3JNK5S7NLHVFJ0NfxnpyDrdVw3384mGSgPuAEqBN8X6MHkruqWUUR9z/3H+cnxMTuALYi3+JB28mp43HiaMiII2Pud/nJDMVJTC0vOiu6K7Bowf/OYfkTUeavvB5lO99p6kqU9zrIGELNovjGdQzTgAownmbSPovPewOB0Mg/GhW8VdNUoLH/C/3czt4azw/ZLsBiKGjApVVUUGZIL1dIzHgMK0GewalGJ9CRSI2xfrL3hEAnsHVrxGwCzv1xLa52IVIs5rkcjqcBwFaTuvWDN3bkjBZitQ1Y9qx8o+op10XW4UjEIG0g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782962741; c=relaxed/relaxed;
	bh=GCXpVfilOobuwtQo1MG+AfHJM40d4RwVXZ+w/PwLVOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uzv1aBZetUE/7FNS0fv76k74P/cbdYn/D+MhJ3m7IgOAnfLCyiPTEmc4k8yMklk1GWpsNWSFEaKzPpRswU9+KkO40/9OdIot37TUyRveKTtVqZSOI76G7y8weCaUqC1NdyyUrql+BSuxZzjEk2un3cIdWfEpFZqeljLNl0hFNHADgB04for0FrV8GX1+eonvsJ5dKxaAoXDB6pori6bpN5QlyJqqnDw7+GM3sGHQEy5VQTtgBvqHJE7siZ8Hk2owhKbyGngCF0KuoUS/2CMguPXCqtpQFlAhXZTRMAncs82dHEBvLCx+VxvRn4xy1vWPBpxKD3thagNWTURhDl9SUA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=mggVtbVj; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=mggVtbVj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grMj00rhmz2ygW
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 13:25:40 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPdtgqmCDYXtwMCcua916iaWGd1dLjHTWw5CDuE2+LafCAKTPzFFmmBV9esvBd3nx/3SB86ayid9Pgdp2HAcNz7dHFh0AhJw0grw2Pe3JV/4ESwVBFSs4L1bk2UlMTtanTWPoMWgjB9Ma/u9YyZPiUnyJd37wVRxZhebWvomXqRVAJVy0K3y5f//LyEmRBwt7my0R8sCd8uwAupxkKCc2laK1NPtT2Bnlgdt+BAAhi/I8xPYU5WPHuGr1CFMnKqn6FqaCRfgQl27F2hecBZiCEkzD1bq3pEFTqf4hzZ5QXcxGr7i6yeFH1Qyzjh1SG/vWf9hnEcV80Cr3ZuiAa4RgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCXpVfilOobuwtQo1MG+AfHJM40d4RwVXZ+w/PwLVOY=;
 b=JdKxokewmA36i51oHEPAlgq4QioJhiwG4aiOltwI36y4bqyoMEgmwxCNsOdwBqTk+7EFVuVmjtbLRqsYcb4mhkOTXN6db8ODXJNlGv/rXV+bb0I0Lx1wxSsRlet1LdBfmzvfOWjmhjl3BABiE86Idg1wkiPdVyReCTDmH2FlEpQrMOE0lDH+NcWzNC4zi2sRT1HhHuIH5fvH8QjvG4seyw8rtixsjv+mNj3wDBtxhk9Tz1HSiDX9f/ZkOi12gpVzhArrw7yPtWJwqRIdCZ2ZjqwSjuFRPh5RGtt6qc4I+55gS8tcP/bNiLt1o9aXHzxcLk1Ygu1CNoeVznHlsw4HJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCXpVfilOobuwtQo1MG+AfHJM40d4RwVXZ+w/PwLVOY=;
 b=mggVtbVjyop1IVwjAKcGoTKSGf+s2X8NtAw/03qIkjVp8WNBZNhoQ14dBE04MlKXIMxeS3r1d9ll3FnxdRIFIYtWpP/HfyeeIZylx9J14uSgyqAmrYda/E7gJaSIJN0VHUwzVn4t67n9nploBnO5Y3xZctrVrxexdca32G9w6JGOZfbbL7JL9b37kYOND7caOqVVVyoO1BHCTfpb4AgJGWLCCCd0e52NRjS2EtzCjVn2RYyJ/BIcnOQHwL6cXsbpBUXaLOAoh4Gkz+r2Q/UVEdah8DbVPauWdtaSC7+9/8PBj4umzrsFv4jdJmfSeLqa0Ul0im5PLmcFzIamv1W46w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GVXPR04MB10248.eurprd04.prod.outlook.com (2603:10a6:150:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 03:25:18 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 03:25:18 +0000
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
Subject: [PATCH v2 net-next 01/14] net: enetc: extract common helpers for MAC promiscuous mode setting
Date: Thu,  2 Jul 2026 10:57:01 +0800
Message-Id: <20260702025714.456233-2-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702025714.456233-1-wei.fang@oss.nxp.com>
References: <20260702025714.456233-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0323.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:222::13) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: c59f3d32-c2d1-4c6f-290a-08ded7e98a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|921020|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mVNTz4NmbcOXg7PpuH2sjmVktaMapGCWhPGixOM20XQgl2REEflYtm29CVBCS3pCIafxyiWc40rj0XHoAbl2i+1H+Yfxo0vXw34M8KeDT3pAn6xEULSIaTdxtjRdFKKfdG1t6EkazBTnKIRpgHspe5GHA4Oki80HPsysg+/F1vq6gURrfQrqk2u2wizqOdf1P3dXJmFapEOxem9ZiajSqEACH80mDAEt2XUvAa3lWsqzDBFp47uyt13fK3XTPXOF9buEjJkRLbtdB4v0dKF90hdp9BKLcTCWfGazdGRgX6687xLizj8JXUA/fMI8hsImQTcZkuUwVRFpNOJRNs49YJcsORTGqcXfMo20Tj2IVrGWHLUJPEy5MsAPlsyHNo2daoVdFoHnhg2cEJPaiq0AU5cSqttMxUhyotMhnE/3twlJopwcIG1WXEj1GJf7PtvDEJt0cNVmeQ619qGQ4X+CGQWdHtWRHbEeqgjr1usM+Kjob5OBXe9i3Xco5I8vPTgMJrcJG8UBsD65oVtmAq6CZUKGkYvSx+zLZatjJs2lv0A9dyM7vY0ODwXbvgjtP/OUhpK/dmVFTYLv+l6cMhOTaowKbG9UO4/N4oJKgogLl7t6OPFfhDACze/fGxidaHYO8BZHjP9NY0q2GSXxIO2rI0cBim401w3/m9xUK91UL7W2X/e2iw0yPTY3bvBJ5gCwUUeBvl1/U/2j2UBmMpE3hw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JQWqh3a4BU+l9ODK4MA1ErY/YXIHboZSyZxS3t1s9f+/E2ggeUxrNIY3/4kJ?=
 =?us-ascii?Q?SAwdTh7e4joCWspfvrcOD8vBVRIwc6xKMXFgQB7QZN3NoKRgsxmKBKTWug2p?=
 =?us-ascii?Q?RvAlnzlbIkeEP14gcUBEi4jf59Bypymt6kbWi3gr/3WkLcAbg2h30Ywa5ywd?=
 =?us-ascii?Q?HxMQWiOAM8dlKaSW2ly/ak0gmMsPB1xEC2xy7XZjj2MTe+2W+0uGN9mgv5Fp?=
 =?us-ascii?Q?6BewidPQCnQBMt1iXTGAF6z2mUjj10HnbqFAk7G3Zwu779bnGzwg7Gw8TQE7?=
 =?us-ascii?Q?kXZpD5akaB+vgnh9TDdlj/6Jd8F3baslvQgTCAOZCiquFnQub/ywsD/yzbWG?=
 =?us-ascii?Q?rg1p32CSstqiB6G+fZbXcIvQDP2haCvx3n87KdJ0WF97oszsSV76m2FE09mV?=
 =?us-ascii?Q?Q0OZw8qjDO2KbX8Z3V7+3fVuLL+iMEICerI/B5v+i9R/nJrlH7o2BN/H0gla?=
 =?us-ascii?Q?Jnvn1qbCzT0R5ndKgxcoBDzk1wSD1uVjb4OLtHtTSoRcp7Z5cazXgU1YiIIr?=
 =?us-ascii?Q?wFarN8oQQ/NtRZtKczSolXRCqrAW+u+Em7smep11xVAXV0092r/AYsb+bH4c?=
 =?us-ascii?Q?/RHKtTfoaeam04BNdXOp0ZN2mIBOybLAcn9RtoHClVVVTLq2g4jqFHh8NTgp?=
 =?us-ascii?Q?/KqoejCjup+s/GKEFIyMb6xSQ72iYMwxT25ul/Y3jOOUJSDQA7zic4eNasoU?=
 =?us-ascii?Q?OADE/buEryTloSRC24eiIO84HDu1WCe1Q5nbSAzc4c0ZwWjdm5wC0uHTl3tw?=
 =?us-ascii?Q?p6ws6dbO5GEJLXK0ejB0tMTcepPhce3F4HLDqM36O6xwK2MzS1+x76urq8FF?=
 =?us-ascii?Q?LpNT+fPxkPs4qr4d5jzY9opKYpv4RQx/cLG7lubZShnwBAeul4bvQBekM7Jw?=
 =?us-ascii?Q?F9CBgk9dyY8NMyJ9vzJgBeomZQ+9QhpLA+Inungpeo0JW58cNJ2pV5RsTm8A?=
 =?us-ascii?Q?0+08LQKhy/s+jAhRz178r44BifI9omtJE6mlYyr3oyj99xfKn+WzuPfEhI1o?=
 =?us-ascii?Q?mguYkgGkfJsJ+DvlfsFt630pWra3R/4vXSD7a28LMRn7BsaXtYezZUQbUQfn?=
 =?us-ascii?Q?9B1GQazIGVcrHspwuBZDa4nVtKFbQsnrRTsxLHKpkL84mlYfO8nSYCkHD3tp?=
 =?us-ascii?Q?zMaty0A4HYdrabqmweTKnMxPhNCMoSvSmRAA775AXkJKOQuJLkffnHDyevzT?=
 =?us-ascii?Q?ntBDXGIVpc0eNpAbLoW/hax6rDiQiAlqHoiFCWJRR3S7ThHot5c3xlRbZ/5s?=
 =?us-ascii?Q?CKzB73+sN1FrwuOy2AzJrk6+AeEs+UXLLJlAwsSfPVpJCgReJC9lt577KHTS?=
 =?us-ascii?Q?TFDNNkGWOUI+zK+jGukSp+UD8EzzUNDqSpbze+ukz6mx+mvNT+rP3By+wRux?=
 =?us-ascii?Q?AsdnzSWxB53JBL2grW/y9ft4MwTGNpJ3YoX9TwzUJoMBLp+kQY5fowr9vGmH?=
 =?us-ascii?Q?GC8Wgx1Z0MaSLs17lCNWvqRj6HMRxpEkpK42NizDDGHzktDE0oumUUXDiPHD?=
 =?us-ascii?Q?vCqZP69r3eSRNe02xP/QJ+NCC2zVk17aBFEEGreqmjFV9Ol+DDGc91fY2g8r?=
 =?us-ascii?Q?hSgqIwd87NkG35ERl7KFw72GafAOsmmBDMEBOI/JJZp0+tsuQ1lnVqLL/0oo?=
 =?us-ascii?Q?CsPHZV9vuW+sXR8UStRNr21pge3Gp2CkrrTR8ogRO8Yxj/5vUIqaKmMrcHI2?=
 =?us-ascii?Q?4vdRxkeANm3Tu8rJYeQlBmRQaIFJmFGP+yZwbG9l8Vswa6EE80DCIL38q7bF?=
 =?us-ascii?Q?dZ8WNN/MXKHl513bxtnkD6x3KaIHf1F28Z0w667Bhkgq/+uyGXR9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c59f3d32-c2d1-4c6f-290a-08ded7e98a26
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 03:25:18.0326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcZBa/yFU3dqlnHa8NTscPdVSCr65iTBuVO1bVZpVGcgW3WDm03RUbEYXLE1AkMneTXkXoviiO/EC9T0Ybr2Er27StLRhuC7nrJwCEpeMR7T5ACswZIDxP/ZrscMoCMd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10248

From: Wei Fang <wei.fang@nxp.com>

The PSIPMMR (Port Station Interface Promiscuous MAC Mode Register) in
ENETC v4 has the same bit layout as the PSIPMR register in ENETC v1: bit
n controls unicast promiscuous mode for SI n, and bit (n + 16) controls
multicast promiscuous mode for SI n. The only difference between the two
hardware generations is the register address offset.

Since the register functionality is identical, the MAC promiscuous mode
setting code can be shared between ENETC v1 and v4 drivers.

Rename ENETC_PSIPMR to ENETC_PSIPMMR in enetc_hw.h to match the actual
register name used in the reference manual, and extract two new common
helper functions, enetc_set_si_uc_promisc() and
enetc_set_si_mc_promisc(), into enetc_pf_common.c. These helpers select
the correct register offset based on the hardware revision via
is_enetc_rev1().

Remove the v4-specific enetc4_pf_set_si_mac_promisc() function from
enetc4_pf.c and the duplicate PSIPMMR_SI_MAC_UP/MP macro definitions
from enetc4_hw.h, as they are now superseded by the shared code.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  2 -
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 21 +--------
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  2 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  7 +--
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 11 ++---
 .../freescale/enetc/enetc_pf_common.c         | 44 +++++++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  2 +
 7 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index f18437556a0e..6a8f2ed56017 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -69,8 +69,6 @@
 
 /* Port Station interface promiscuous MAC mode register */
 #define ENETC4_PSIPMMR			0x200
-#define  PSIPMMR_SI_MAC_UP(a)		BIT(a) /* a = SI index */
-#define  PSIPMMR_SI_MAC_MP(a)		BIT((a) + 16)
 
 /* Port Station interface promiscuous VLAN mode register */
 #define ENETC4_PSIPVMR			0x204
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 437a15bbb47b..304ec069654d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -75,24 +75,6 @@ static void enetc4_pf_get_si_primary_mac(struct enetc_hw *hw, int si,
 	put_unaligned_le16(lower, addr + 4);
 }
 
-static void enetc4_pf_set_si_mac_promisc(struct enetc_hw *hw, int si,
-					 bool uc_promisc, bool mc_promisc)
-{
-	u32 val = enetc_port_rd(hw, ENETC4_PSIPMMR);
-
-	if (uc_promisc)
-		val |= PSIPMMR_SI_MAC_UP(si);
-	else
-		val &= ~PSIPMMR_SI_MAC_UP(si);
-
-	if (mc_promisc)
-		val |= PSIPMMR_SI_MAC_MP(si);
-	else
-		val &= ~PSIPMMR_SI_MAC_MP(si);
-
-	enetc_port_wr(hw, ENETC4_PSIPMMR, val);
-}
-
 static void enetc4_pf_set_si_uc_hash_filter(struct enetc_hw *hw, int si,
 					    u64 hash)
 {
@@ -515,7 +497,8 @@ static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
 		type = ENETC_MAC_FILTER_TYPE_ALL;
 	}
 
-	enetc4_pf_set_si_mac_promisc(hw, 0, uc_promisc, mc_promisc);
+	enetc_set_si_uc_promisc(si, 0, uc_promisc);
+	enetc_set_si_mc_promisc(si, 0, mc_promisc);
 
 	if (uc_promisc) {
 		enetc4_pf_set_si_uc_hash_filter(hw, 0, 0);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 71f376ef1be1..07b7832f2427 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -29,7 +29,7 @@ static const u32 enetc_rxbdr_regs[] = {
 };
 
 static const u32 enetc_port_regs[] = {
-	ENETC_PMR, ENETC_PSR, ENETC_PSIPMR, ENETC_PSIPMAR0(0),
+	ENETC_PMR, ENETC_PSR, ENETC_PSIPMMR, ENETC_PSIPMAR0(0),
 	ENETC_PSIPMAR1(0), ENETC_PTXMBAR, ENETC_PCAPR0, ENETC_PCAPR1,
 	ENETC_PSICFGR0(0), ENETC_PRFSCAPR, ENETC_PTCMSDUR(0),
 	ENETC_PM0_CMD_CFG, ENETC_PM0_MAXFRM, ENETC_PM0_IF_MODE
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index bf99b65d7598..66bfda60da9c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -180,9 +180,10 @@ enum enetc_bdr_type {TX, RX};
 #define ENETC_PMR_PSPEED_1000M	BIT(9)
 #define ENETC_PMR_PSPEED_2500M	BIT(10)
 #define ENETC_PSR		0x0004 /* RO */
-#define ENETC_PSIPMR		0x0018
-#define ENETC_PSIPMR_SET_UP(n)	BIT(n) /* n = SI index */
-#define ENETC_PSIPMR_SET_MP(n)	BIT((n) + 16)
+#define ENETC_PSIPMMR		0x0018
+#define  PSIPMMR_SI_MAC_UP(n)	BIT(n) /* n = SI index */
+#define  PSIPMMR_SI_MAC_MP(n)	BIT((n) + 16)
+
 #define ENETC_PSIPVMR		0x001c
 #define ENETC_VLAN_PROMISC_MAP_ALL	0x7
 #define ENETC_PSIPVMR_SET_VP(simap)	((simap) & 0x7)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 2d687bb8c3a0..a97d2e2dd07b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -159,21 +159,17 @@ static void enetc_pf_set_rx_mode(struct net_device *ndev)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_pf *pf = enetc_si_priv(priv->si);
-	struct enetc_hw *hw = &priv->si->hw;
 	bool uprom = false, mprom = false;
 	struct enetc_mac_filter *filter;
 	struct netdev_hw_addr *ha;
-	u32 psipmr = 0;
 	bool em;
 
 	if (ndev->flags & IFF_PROMISC) {
 		/* enable promisc mode for SI0 (PF) */
-		psipmr = ENETC_PSIPMR_SET_UP(0) | ENETC_PSIPMR_SET_MP(0);
 		uprom = true;
 		mprom = true;
 	} else if (ndev->flags & IFF_ALLMULTI) {
 		/* enable multi cast promisc mode for SI0 (PF) */
-		psipmr = ENETC_PSIPMR_SET_MP(0);
 		mprom = true;
 	}
 
@@ -211,9 +207,8 @@ static void enetc_pf_set_rx_mode(struct net_device *ndev)
 		/* update PF entries */
 		enetc_sync_mac_filters(pf);
 
-	psipmr |= enetc_port_rd(hw, ENETC_PSIPMR) &
-		  ~(ENETC_PSIPMR_SET_UP(0) | ENETC_PSIPMR_SET_MP(0));
-	enetc_port_wr(hw, ENETC_PSIPMR, psipmr);
+	enetc_set_si_uc_promisc(priv->si, 0, uprom);
+	enetc_set_si_mc_promisc(priv->si, 0, mprom);
 }
 
 static void enetc_set_loopback(struct net_device *ndev, bool en)
@@ -474,7 +469,7 @@ static void enetc_configure_port(struct enetc_pf *pf)
 	pf->vlan_promisc_simap = ENETC_VLAN_PROMISC_MAP_ALL;
 	enetc_set_vlan_promisc(hw, pf->vlan_promisc_simap);
 
-	enetc_port_wr(hw, ENETC_PSIPMR, 0);
+	enetc_port_wr(hw, ENETC_PSIPMMR, 0);
 
 	/* enable port */
 	enetc_port_wr(hw, ENETC_PMR, ENETC_PMR_EN);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 6e5d2f869915..b0c0dc668e34 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -87,6 +87,50 @@ int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf)
 }
 EXPORT_SYMBOL_GPL(enetc_setup_mac_addresses);
 
+void enetc_set_si_uc_promisc(struct enetc_si *si, int si_id, bool promisc)
+{
+	struct enetc_hw *hw = &si->hw;
+	int psipmmr_off;
+	u32 val;
+
+	if (is_enetc_rev1(si))
+		psipmmr_off = ENETC_PSIPMMR;
+	else
+		psipmmr_off = ENETC4_PSIPMMR;
+
+	val = enetc_port_rd(hw, psipmmr_off);
+
+	if (promisc)
+		val |= PSIPMMR_SI_MAC_UP(si_id);
+	else
+		val &= ~PSIPMMR_SI_MAC_UP(si_id);
+
+	enetc_port_wr(hw, psipmmr_off, val);
+}
+EXPORT_SYMBOL_GPL(enetc_set_si_uc_promisc);
+
+void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc)
+{
+	struct enetc_hw *hw = &si->hw;
+	int psipmmr_off;
+	u32 val;
+
+	if (is_enetc_rev1(si))
+		psipmmr_off = ENETC_PSIPMMR;
+	else
+		psipmmr_off = ENETC4_PSIPMMR;
+
+	val = enetc_port_rd(hw, psipmmr_off);
+
+	if (promisc)
+		val |= PSIPMMR_SI_MAC_MP(si_id);
+	else
+		val &= ~PSIPMMR_SI_MAC_MP(si_id);
+
+	enetc_port_wr(hw, psipmmr_off, val);
+}
+EXPORT_SYMBOL_GPL(enetc_set_si_mc_promisc);
+
 void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 			   const struct net_device_ops *ndev_ops)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index 57d2e0ebd2b0..a619fb8fed9c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -17,6 +17,8 @@ void enetc_set_default_rss_key(struct enetc_pf *pf);
 int enetc_vlan_rx_add_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_init_sriov_resources(struct enetc_pf *pf);
+void enetc_set_si_uc_promisc(struct enetc_si *si, int si_id, bool promisc);
+void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1



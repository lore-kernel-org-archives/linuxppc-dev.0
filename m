Return-Path: <linuxppc-dev+bounces-24434-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0877DC44523
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 02:13:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3PDj44TRz3c2H;
	Mon, 20 Jul 2026 12:12:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784513573;
	cv=pass; b=BD9LzbjVSwWgzmAvwWFrVSMdgG4lHCracI2DY4Kb3ab2wmW2/vuNOeoogY1HBgxB8uZ3MjEAF3xoIea715+3G3PCltn0kVDcpj+Krcp9vXjvIDXBmApFV3u0ZpW2XLttcJpPGGWXopwfwXNmlzBPA63Gw1qdeqr2qcisSkbPle4hiJk8Tct+0jKsbu8No51XiJOL+PgkX4xnBKiu5drXEwih7H8zuDP1l6Cr2cVW/j79gHJLWiW4DTQXH1Gx7sTs7KeknZXNShpsI3ztS20OnDKsoaMkzX8aT1hI8bH/oYrZt0Qi77t/ma+F73qVHOAh6e412wajHz/Lh7w5PuVQkQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784513573; c=relaxed/relaxed;
	bh=RmvpWVF47jUc8h9psj97e6zsVGtTYxdvQZtCviyJaDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XPwsoiGaT9PG9IYjFmsn5pM60pXWsm6KyYctoDpyV6KCABUx1u0LM/mcmW+z1pTO09b0JIukZguwxt6j9fxO+u/mi8pZyKyKRggUbTjY8ddqcb9e7QqvNb24jRU1fu67eIkeExO0DemmnI3DDaRfx3c2mhSl4HOhHuLq+txsDjjpc0RBTBFBXnkach+hQihD2Qqr7e9RiToFUwskJh1b8N8kkA4MnxgDbF381G1gjjrJxU+YpvSFbkme9kF5ztC0s5sXZiARv52M2YYOabzGNB3PJEeKhlZabYb/hsDA933LXbLR8ECUbniL4nb+2+cmfIGf+ql/4laob2DOj7+8mQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=m4nYSd3v; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=m4nYSd3v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3PDh6fLSz3c1B
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 12:12:52 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V47KCQ37VmrYeIqsdNNRtW11aOU8tOAZcv8OSewXgoxYFu6wrLdkTxf5+lKxVSnOtGSmzv5nq79TRc7DbVcbDywFOXsJyLU7BrFEWkzmmroWrNJxd1kbsrECfdjvTqdubSEflnEeqflx5NMzv0KWSpJNeieBpY3N+HA2msfJKkn7BG2egaw+oNu37yb+iCRnXsRYLxDr06e5iiEirYaK+AGcAuxy+VZvQr5nTkTjPXzpaPWHjteH6BGgVPrFELTC1UBa57rRC+9HTLE3Ejh7bpeIeCr2hbPGiSjN0QxokRqZNmDbipO1takPUGKOtJRvw0jC2R9oSLFR06+0/YKsMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmvpWVF47jUc8h9psj97e6zsVGtTYxdvQZtCviyJaDU=;
 b=csKq+vIMPQVmUomDH/WoD2aZiQ2FDwfdSZq4hbpHEetB54bN7s4PBseVrk3EEfbgJEt/sHnJLc3Vss4Y4dIRF64f23tNFINQ2fyVJN2GeC0gGnEuOkgDPfZHiKSVrzkF+kEBZZqoI1yQhcfmekCIlighvsCGKZeHt7DjSPTQKJydhZRtj2KL39uv6R/GDIamR8bOObK2cwHjfthudJ3PK03PDorUWC47xVx4yeKU1aK1Cj4uzRXKYbj3/+3lz5BuR6U1hfkYONCzHdHdPSvDLfvpU7VNgwEmmUlYNE+Ub9YKjzbuNkZBLEkGz/ba+g+jk2iPcD98Z+ItdwzRRJghzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmvpWVF47jUc8h9psj97e6zsVGtTYxdvQZtCviyJaDU=;
 b=m4nYSd3vjd9fPyiZYhhl90eUdAUiqbS1zYTfnNDCf2gV4hoQxz4/QNVArNA+81gbZhBZ8WIRxPXY/GqLoxE1tOYRa+qUtcaC67qD+ztnUM8DZRImrUGBNDJ8qMWlR2yI0J1fe72dO5mI2NeWzXNrZYrV7ZBMIIlV7of/ANjfc+Mld9QUz1KPey4xD4L4ep4S3IvEh1n4LxwUrhN/VLjeHfUH9234qjGfIU8hTiv2J5rDr8S2KDI5DcRpDC8VzAPouJyPfAqOwnuuXspN1dZgqdtA4qJVMwmedIKYalM5aunRa27WpNn9U+o9TCM97AYN3UrvjjZMOGgS2FrXrb8PGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GV1PR04MB10872.eurprd04.prod.outlook.com (2603:10a6:150:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Mon, 20 Jul
 2026 02:12:50 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 02:12:50 +0000
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
Subject: [PATCH RESEND v4 net-next 09/14] net: enetc: open-code enetc4_set_default_si_vlan_promisc()
Date: Mon, 20 Jul 2026 09:43:11 +0800
Message-Id: <20260720014317.1059359-10-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0170.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::20) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: ccd9d83b-15d7-42be-17c0-08dee6046631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|19092799006|921020|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	D88F/tO2ExOpOM+y1iNjuBTZHV6qK9J3HICntuPV7Vei3UpwWWjZKHY3Kxkx4os4yEgxPgyKPTq2sizDqnK7Kba6K7mls2MjduGW3IvpbejUfa2j7yVQy82JAgLzRRfWSDlYD/+fb4hwwtzOw3iLp0n2sUh8b19X+3Io3cb2eCafPONj7Q0BJkR//COFn5lg3b5xyTlRtZjc1f+vHHujJdr5qzlhAaZWQJDMcZSh/NOWiVk/QSWhhqx52qhgr1VGhjObA7qidQIKg/RpNfFNzqAdceSqQv6UvxTNBv4wJJdcrHxLLFWk9zrujthmWdv2IyXCD6zmSbjEPRTiZR+lDFX6su7OrzWsohIGZ+u0cl/A4L88H+iCAUslILXKb5IpK8mcGOL3aMWYX4OKgNjJkms7VT5nA6o8VePpDX6482aCQbVazd+Ge0lNc/Qz4b/Q6EtEI9g8hdtm0rWepor+tjtKWLwCpk5cmk3UlQJcmyhRQ1fz7hJ65r4QZE9RAXyL3pvMYND4PSZbIC/5uR86vKiuNGCyJP7Iwq8r+JLKgGlTfXN6ZGm6s523CyrbILjcndFDw7wFHaqTW1Lkiz73FR+pBDJe+dG7c6f5x9kYKYf+UaXQ7IEHHQzsIF9HQ8mQ4q8Ny6v7NnPbDEJO7/hDiwxC1wZnVxcsb4JPDw/h6IUzJr/w6pvl1PUxkVswGlQVPGoBZ3DgNA5X99aza9vbwQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(19092799006)(921020)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rb/NnJzfJVpGN/YX483lLwJm9P9vSnMrd7e1cr4i9ddwNptFCwXhMPQZ4/hS?=
 =?us-ascii?Q?2c1TwlRtX6c9Iv8rqPUh3RuKsb1cxF6njEtO6RSeVvpMLSM2D2LSnhwVkamI?=
 =?us-ascii?Q?1WEeO7t9nGlHL6mOAiSUxh11hqm7tB5HmdPLt4eIa/QOfX5iGEubc9vv+oTK?=
 =?us-ascii?Q?JK1BeaLO7pH5bg9wPITSvDGdz1/hVhmUIobWfoFGf0oY+6zEIR8614BrR7l4?=
 =?us-ascii?Q?ionOzUpzAAT5Z6Nu4z56Esh0m21UrJlmmbS2xl0+tw4KR929FCqx9/MX3Mt/?=
 =?us-ascii?Q?uavRR4veBUYXyPSEviF2IoqAz1yXJMCT6WWl6yLx7HoTPxradPP9Els7iEYJ?=
 =?us-ascii?Q?Jg4u71ahhWnqQ/D94W6Uyg6FpokvwKW7cDeZju4jBk0inMCTtvO5rksnREVc?=
 =?us-ascii?Q?yjbii3xjW2Y1wXmNe5aMJNG+wVM1aKUFdWPMkqOHFo6YCS6gFL8dJFcCqzXS?=
 =?us-ascii?Q?gmlVTmFg8s1SN6KkrlXYlfPsdEh3S7+4FxoHaQ3rgRb1jr3f8OSqrdJu1G44?=
 =?us-ascii?Q?t9xJP9ckdp7VigJwZMi5nLkYePaLCUyhP5wLcWCMP8BIsZVOjH16x3kJ+BK4?=
 =?us-ascii?Q?GF3ZljXG8WPNJedogsW0/nLuxIjBj/DLT5AxcaCraE3A30dEz29+kZRYuD4u?=
 =?us-ascii?Q?iU85RLaIU4sMMxtQbZSHzTRtRo2y74gEUgQqjk3D3Iy8yCfWEW6MSmR7L4+a?=
 =?us-ascii?Q?/OA7TE/L7faPiMJhK1d2tgwOduZNJSrorZmDo+DiR6cuRubMfdLngaovjZih?=
 =?us-ascii?Q?8mBWNX5S8fLMibjN4QDMrEBToTkVB/rUZJ4IZdLDmxmQMIYLnl1mkAVWEb0G?=
 =?us-ascii?Q?Ewu8ga3PSDTu2BTPPdS+GAXfdxw605ZImgsItXuDL/MB5oSmbx/p7lXZbaEs?=
 =?us-ascii?Q?v5dtYkUBPHYFQ4IIBId56RGMjrt41GKwbF6Lti3go3Vg43VvbljVdezBBfu6?=
 =?us-ascii?Q?f7RghR2sshKM/+Vo55n0LdhWDWQCtinE3je1zFPKWVdOB6/8eS70hnNGdM7x?=
 =?us-ascii?Q?AtCqGlbmVvDZBwAxbXT5VHpT7O6692WBp567+O81k3arWV4pj8x8yqT27hI7?=
 =?us-ascii?Q?dPdTj67TpsSbSDeHc0GkGkTj+9ku4JuRDzUQj5DpS92IGPU+K0PgCt5Xm/VA?=
 =?us-ascii?Q?rWcLQ2dGPKnfaPk9Y2wRkFPVFpNDEV0GPGnCFG1D1OJ4RTX85BKZku4cPLOM?=
 =?us-ascii?Q?KtsyKIggLoc5S5Mzfluz2ISRElrPhLU5N+Ge1JLlN3d2slvNx7SFQjME13B4?=
 =?us-ascii?Q?7FCVLTl23l7g3qBIvj0/jiL5eJfdVvN39q6kZF7b6oEFgvX4DUtOLPS6EqPB?=
 =?us-ascii?Q?rwr88YvcMsFcAnmI/EIBiqUDel2EKU3hlh992RokjtexIFwoCnf8pfUCOH71?=
 =?us-ascii?Q?h2azsMqbMTpfQdT+PnD3Uf1WPNWfu9n/UFcpxzUQycgSrlClxljw+AMEAA/n?=
 =?us-ascii?Q?wLOyEfjJjpNBwaxjJUBW/nFTxry453Tpu1ALJzjgxZhm7C0ruTbzEiK38AE5?=
 =?us-ascii?Q?D709ABsZY/uJxy274ZqmFmH0m+71ZXFB0g895OCEgnC7P8e76VMXRA6o1ipZ?=
 =?us-ascii?Q?LhWhGNBn9Y4dZiQDCjChkEIPL4bB9jBudTL9TLq4HPE4XuyDPwTw4Iau4gfT?=
 =?us-ascii?Q?wIt3ZMMwle6XbcJvoWZqofnhHJnSTPXdFL6CVFSX47VHiTa6epeR9KxwyEYq?=
 =?us-ascii?Q?ss81T0GKO48QmkkjQEiiv0uEQa++Il4HeuvW7D3T7mCROKAGEaVzue5JWThM?=
 =?us-ascii?Q?weZIRM4WRfW3ril+EcvEGJ4C9azAcbFOjgVn6VKYQb1gwPqOGbxQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd9d83b-15d7-42be-17c0-08dee6046631
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 02:12:50.2978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nELWnF2Hh7Stnr7N/VcBk9XCLSJwOQ15XQCNSSVLvAKGn+8/iD8eSOmHbIbRcqct/DtCsS6vcCOakEu2rY+nNoJovzmeI9GPjdfwP16x62OOq9vLbAmmloaRiDhR2vDH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10872

From: Wei Fang <wei.fang@nxp.com>

The function enetc4_set_default_si_vlan_promisc() is only called once,
from enetc4_configure_port_si(). Open-code the loop at the call site
and remove the single-use wrapper.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 859b02f5170a..505e4abf6c37 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -307,17 +307,6 @@ static void enetc4_pf_set_si_vlan_promisc(struct enetc_hw *hw, int si, bool en)
 	enetc_port_wr(hw, ENETC4_PSIPVMR, val);
 }
 
-static void enetc4_set_default_si_vlan_promisc(struct enetc_pf *pf)
-{
-	struct enetc_hw *hw = &pf->si->hw;
-	int num_si = pf->caps.num_vsi + 1;
-	int i;
-
-	/* enforce VLAN promiscuous mode for all SIs */
-	for (i = 0; i < num_si; i++)
-		enetc4_pf_set_si_vlan_promisc(hw, i, true);
-}
-
 /* Allocate the number of MSI-X vectors for per SI. */
 static void enetc4_set_si_msix_num(struct enetc_pf *pf)
 {
@@ -361,7 +350,9 @@ static void enetc4_configure_port_si(struct enetc_pf *pf)
 	/* Outer VLAN tag will be used for VLAN filtering */
 	enetc_port_wr(hw, ENETC4_PSIVLANFMR, PSIVLANFMR_VS);
 
-	enetc4_set_default_si_vlan_promisc(pf);
+	/* Enforce VLAN promiscuous mode for all SIs */
+	for (int i = 0; i < pf->caps.num_vsi + 1; i++)
+		enetc4_pf_set_si_vlan_promisc(hw, i, true);
 
 	/* Disable SI MAC multicast & unicast promiscuous */
 	enetc_port_wr(hw, ENETC4_PSIPMMR, 0);
-- 
2.34.1



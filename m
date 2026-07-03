Return-Path: <linuxppc-dev+bounces-23493-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B08C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 10:43:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gs9N30lQtz30Fy;
	Fri, 03 Jul 2026 20:43:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783075427;
	cv=pass; b=D93WrdHCY7zXUYh+B6xMSpP/8R65S7s7HkP4570ZOAlo1uu201K8R2oBhKp5D8l9qzZM0utRsdiWmz87e/cFGfhigl46hoKEz2h4xMg2ZValckyHFm0QdOcNvOvttvbML8vUOECgaCuhOMpdcWcauQaXKCwBltxFvuZe3bK3dynxDb4G5LWZxSV4+umtWlZKTG7PsIO9spmJZeagpGiZknalzEwijJC+JJ4eiR5i9BJ2BqLwMaEAzbL56uVMp1DuuMneC3dUJ1MJ7D0C7ZQsNqoQJ689NKoc89nJSYCIxNNi0orqG7MjzFb97ol/DGcAAOP/lABHpRouVnDhubPzkQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783075427; c=relaxed/relaxed;
	bh=KLTF9WBAGeAwf9k55IX0Wuhsh8qjn6IELVpYq/SKvck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lbg1X9cd3ZNIKChZizHgL14ZepwEmgSNuArvUaTG1mvxUkOBBP2LdrzHBBIQUc1r5QJvZtR5SxbALTGzn4mGImm1VGbft7s5tYtUXaNxzduHELRKMdgcMnBhvJe+kg9hdnPOAn3A1iBZaX57rBGP8JDgAH+Ol65bKVwr9kCAU6/KtpMrkixAbFh/xXQsme4dRDYKwssZbz0sf0/v52Ue0NCsQQOGR111QjTtDJaXXPNjo7H7g1diie4qk2OSjVdsKFM3ThGKTJbvhaHi7XzrGUNI02jgQdWnor+tAltuGmWJWt9MktJ11dtnoY8kKZ9F22fv1hJlC6QL8+AhjrZ/fA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Or2QsXN/; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Or2QsXN/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gs9N231Y8z30Cd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 20:43:46 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWScYLmFnuGd7Aggjo83SzI4elT1O1hVM+tyqHN8kSLhGqxgoXsII8SdVApDmRfF5dNW+csxZYXDIRg+ugTaA3CW7U/ZDS5gk9Kk86Y2tDiYaD4CHHvBAsId5Fm5Yk4Z0kJdeDH4adwBLvaHVSXgzkbEbdx0gdNZedekkFSGmb1yExZvC3U88N2O3Ft2RwIWanbYM9I3s+0OspQnUFqly93Rbkuj/DWEi+V+gfWMqodubg614uYbBE7sgBitKuBRve4FwdunSox9SknQ4uRdnMrzKOSl6UA2zejDZ0KDQkQR8Krqt5SYAn9Tb0Up/8uCttdiwwD92+6eojcpH40S8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLTF9WBAGeAwf9k55IX0Wuhsh8qjn6IELVpYq/SKvck=;
 b=yH67PQ2DnM0MdbQUhI/Qfv64HXvSYfP+FueiyNrqNcKnaGf+mfdhiimi7tcy3aAA9Kk/3w/QLoLVmjuc166ONQoBFs7z8fjUQ0BrtmEpcsEoQ72gg3m1xhIp8SEjvQpLgylHSbF0I5g/BFFdJeMt7Y91MplTlEP8lL6puj6u1EWdcyFii86gN/uNLXdkLAhu6tP8CVXf24Svbp2xHnEKoiRwTE2FkV7Lnxh9TukGo5DTzoBx6E8YpdX9LNUiOI3W9Wv12A8Rc+pCPD2zss25g0GAM3eUiuMfyNYgPwkhXIdqXLiERJCOPOfRG7m6LXPUg+QhHmrHAp5dmaXPVbkArg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLTF9WBAGeAwf9k55IX0Wuhsh8qjn6IELVpYq/SKvck=;
 b=Or2QsXN/AeSH+xlbFzXz2nGOKG12NbOHpURhP3k8E5jc+XvvIhyaEF28pina+o0ukDItSicj90nNLzjm79h6nh1SrGQwIyl0PpPFpd9+jJoQn8Ff16FZl2oyebg2gKz2d9OC117sMx7+2x4UeCik3w94AN4jPRFYPhY+4Oh4AcEHZYHBdwfw9Qn3hw8gW9wgDf5b7l/m+C1DkFUiIrc/0aphxLVv31zfZQsdmALh9SMUUEur6PHZKo7Z3FShwukdx/lCjr7kuPpvklt1t8FNqYEEis2Sc2CPVpIqDBr9H5KitEu8LrXDtJ/b3NGdtC7/pUqW4dHASEaY2xCBsfjVcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PA1PR04MB10867.eurprd04.prod.outlook.com (2603:10a6:102:483::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 10:43:28 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:43:28 +0000
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
Subject: [PATCH v3 net-next 13/14] net: enetc: use alloc_etherdev_mqs() to create netdev for VF driver
Date: Fri,  3 Jul 2026 18:13:27 +0800
Message-Id: <20260703101328.550714-14-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703101328.550714-1-wei.fang@oss.nxp.com>
References: <20260703101328.550714-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::9) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PA1PR04MB10867:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba522d6-e9d3-4df0-560c-08ded8efeab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|19092799006|1800799024|366016|921020|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EkdTP86C1ky+5KqsimISQEoYnAUgAGVHJPvZ+CsISY1uqhjt0UlIYx/nq9HayFcTBIz9GYuEY8wgwmyCqY7fEY/FjC8krep/EvSqYhrfExd8qZxF6BwCLhu8CPIw90FIvh1BSthCjeSNv8uETBb1RHBPf0Tp5D2NdnfkcbIfowKHYNFsxPu8SxW3GvlqmrRoLQCkM3p3JuyzbPtq5HbWSGo0PweJqi34H/fwLJ7+3ldsUgyfYf6bJWFuMHg4O9HbJmmLvxaq7dAouKzYobQ3fflVlN84ftK08M68UVWAQ8DbeoQjNOtz25xJGUH+hE20AC1M55WuYm75osv+PZalqe4/dK7125E8tRXZEH9lRqy3EGq/uNxP2IC8h3aAr/Jf9RN9vZ8m7zqiPEY0a/i7NV1ckXABb2WPrHEBqJyTMeuqjQ8TOqSYbcTxIHbipU/fBLqoofY3KaUYK/MjljtOGdZb082Oxq3CD9R+KaaKbAtyDbR8pfF4extixo3ky7wVCwgtuGcEqSogfNSgb8LXTe+EaBRVHB491iKZF/7ARePkHT0l0L4GiIlbjP+aXv20shBz6eGorWx3OEiuw70nZ0padTuwmVbF7HaCmIXpm6CJc07wBd6Nt4+gMBTwF6xQaaJetaJqC1Qt/3R/6OIsZ8sk0lPsAWFmha7y6wNUVGvCv4nisoJFFO2sNhWZ2PjUUzBqd6FyCITcmarZZXFwCg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(19092799006)(1800799024)(366016)(921020)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rs2lHIACmAnwA/WaSnX0ecIlwH+XRbdzNmCT5yTeH7zGCqMvSsKLXiP+7q/9?=
 =?us-ascii?Q?cYVl7K10DMPVdaGdV66YlBZPQKS7fLPzzxxje31BTSijODyzXp9/fJLLEDak?=
 =?us-ascii?Q?LEve4pp1FGW6GjnWPQA6jJxsFD6Eh3vp17YrZAy4djJ2ohxILKzYPjB5li+P?=
 =?us-ascii?Q?lEmaAIfA2yPgZzNpVLUWmCTXfPm54cQVL4fq3+w7QYTL5dWK+NrlBzYonFWT?=
 =?us-ascii?Q?5KFBQsOn6kWx6+yrixgIzpoPyxtKa6ruUM6sMyVv9NFnHFX/4caiuFG56wqe?=
 =?us-ascii?Q?sByEAKi3N8a8QEUmlTDHZvqepVSaVmZzP7mDl9yWwVGHcm8LkwImi5u6e8s1?=
 =?us-ascii?Q?4UnbhpPWixsinN+fP4FRN0Xpot+IwvhGGoaNDMeDPQ6xzUPZoARzOuVrWbhW?=
 =?us-ascii?Q?o4aWIz/s96eZ7OkkqZkbeVz3cl2ad2dIKXIL+l0gh0n73uAJLRsSXJFxTx2n?=
 =?us-ascii?Q?0fcox11wC6pTnRPzsvlZrxFFYykw+C+mcZqqr+ZVnaki5Dza0QXI8fak2KOj?=
 =?us-ascii?Q?2hodiJO/+d8/UQsreU9c/Wu5UhBBx7Wqj0y047IpaHsl9hP3qtDbbt5R5TEi?=
 =?us-ascii?Q?de9yUQ2ldgL6vdsER94cd3xzEsdH3hE0699+59DFOGjikRTIha0VUBZxBJjP?=
 =?us-ascii?Q?3MpItGpA4ApaXEOKjUSB+hv3XalyzeUx37IUXrd9Inw5Fl47c6Mugjyt2+2p?=
 =?us-ascii?Q?tQdUniOFg/L0eeFEAxSc7mdGQOae2BD2uRAdxcEn/eKOjHowKLc56htX3IDu?=
 =?us-ascii?Q?4ni8cZLksEgY/R9P4HyBFMqEoildDxwF5kueN72S7L2Emw7o9BYpBg/swYle?=
 =?us-ascii?Q?NZm1m84JrkN13iWRvXwIuHfSQMqyHXblMwTRRqLCgcoHZZ/MBRg7FfiSoCwQ?=
 =?us-ascii?Q?GlYPZSnCvPr7euZIsVIpISMt4pAhS0LsbSAixMB5UKWxZ2r6aBLNOjg7B9zx?=
 =?us-ascii?Q?V1uVCOWaPzupCcVlJXw0NhEWXpcmUrtax5XjguxM3q6zPbNC5PKhDbsuJqkI?=
 =?us-ascii?Q?Nj5Wt86BjYEBNv2kKQbog3YkqkO95cm0mckuXfe7GDPjDQnZ7z3sETSMBf5Z?=
 =?us-ascii?Q?mZ9w1x9fcqG2k7QX/N6U9Z0h2Vv2zoE0NsnUeyW64l8Bnk0RZM9EsaE8GTSC?=
 =?us-ascii?Q?Zvww7y02vnarhCzIK6BcjSbz/JCNdLiBV4CyDYlJLiom5oxpaeir+lqOPvmt?=
 =?us-ascii?Q?7AV6lXStyRz4h0f615j4EVhc5GbmFuVQsMGvmNofNWg5r/gSN/G6ysNMMOxd?=
 =?us-ascii?Q?YykdXDgqKYkrJWp/UY8KLPEqkH69gdCLgEtbGQp/ImW2QsgZnYJEkORf4Zco?=
 =?us-ascii?Q?IsYo8v+iO6Tvv2jFR+6V+LJ+GrEEbav0FXZwERLzTHJo45SjI6B1EG3vnvFY?=
 =?us-ascii?Q?qtn/giHzGJIBMG/dknFo27V/Y144HRcjEnE/fZhfGdY7SNACD2rpAI/VClxL?=
 =?us-ascii?Q?DDCPQn2B6lilZqRyXiy1+Rn9qDBXLsspTGIDWbU7HADPAiw0glwcFTGsfbuJ?=
 =?us-ascii?Q?APuN6JuM5m7zKEX0xJ9Gcb3y0X5NORBNxSl3FDaWzlVI9TYVq9CDWeHpPJpA?=
 =?us-ascii?Q?tcRZEMiPURZUT9vynELWPfE5q2IgUjEmr6Wc9lW2Nc8czKxv6u1o+I6zHEFz?=
 =?us-ascii?Q?5YxAojn3unHFexiIUKqCPmlvuSK/39GvWUVCUVue4DemppVE4dFnEJof4goc?=
 =?us-ascii?Q?I9AnDyDmNzZSYHwso0jsxREZI5+4dDb0Ax2IXo1zpmISr9SclquYttSffpNc?=
 =?us-ascii?Q?rtSt3ItpOOsjwp0IJDMPxGVIp6pnxq1/TgPUueXJSHgzz3+82XqD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba522d6-e9d3-4df0-560c-08ded8efeab7
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:43:28.1005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /duycGP3XxKIcZGGd5GxaPGyPgXDFVQANQeMSAqfd7KBcIL4t9Fqjd2PZwkY0Do27rkCeIsswRCIj2256fzc+2IuptdOdsAI+seVogSFhS7Epf3ptsyCv8s4t40y8Hjn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10867

From: Wei Fang <wei.fang@nxp.com>

The VF driver uses alloc_etherdev_mq() with ENETC_MAX_NUM_TXQS as the
queue count, which forces the TX and RX queue counts to be equal and
uses a compile-time constant rather than the actual hardware capability.

After enetc_get_si_caps() is called, si->num_tx_rings and
si->num_rx_rings reflect the actual number of rings assigned to the VF
by the PF. For the ENETC VF on LS1028A and the upcoming i.MX95/94, their
SoCs have no more than 6 CPUs, and the number of TX/RX rings allocated
to the VF is less than 8.

Therefore, switch to alloc_etherdev_mqs() so that the TX and RX queue
counts are set independently, each capped at ENETC_MAX_NUM_TXQS, based
on the actual number of rings assigned to the VF by the PF.

Note that if future SoCs have more than 6 CPUs and more than 6 RX rings
allocated to VFs, the size of the int_vector array in struct
enetc_ndev_priv will need to be modified. Similarly, if more than 8 TX
rings are allocated to each int_vector, ENETC_MAX_NUM_TXQS will also
need to be modified.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_vf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 9cdb0a4d6baf..7dcb4a0246f5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -317,7 +317,14 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 
 	enetc_get_si_caps(si);
 
-	ndev = alloc_etherdev_mq(sizeof(*priv), ENETC_MAX_NUM_TXQS);
+	/* Currently, the supported SoCs have a max of 6 CPUs and the VFs
+	 * have less than 6 RX/TX rings. So no issues for these supported
+	 * SoCs, but for future SoCs which have more CPUs or more TX/RX
+	 * rings, all the related logic needs to be improved.
+	 */
+	ndev = alloc_etherdev_mqs(sizeof(*priv),
+				  min(si->num_tx_rings, ENETC_MAX_NUM_TXQS),
+				  min(si->num_rx_rings, ENETC_MAX_NUM_TXQS));
 	if (!ndev) {
 		err = -ENOMEM;
 		dev_err(&pdev->dev, "netdev creation failed\n");
-- 
2.34.1



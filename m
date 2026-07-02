Return-Path: <linuxppc-dev+bounces-23355-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFB9C43327
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 03:27:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grMkK0GbZz30VH;
	Thu, 02 Jul 2026 13:26:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782962808;
	cv=pass; b=itJB0cima3kN/Ka9svOcpc0Fl7VPyPyVaqNQ9gTh87Z7Er3kCL+zodD8OGhQfJJ3//rKg3N7Qajxvs1nrSDgCOYUjMo3H+dQxoJNJEDCeMcE5vMwrVA/T6YoMB8hzvqUZIansI4CJvBwEfdJKEJb15g5dC9Ul/Xhr6S/3/eM6Dqig/ML7K9N+hutS/DSCQ5YpXe++sRkAGoV1jaZVQNN/cW7va5WQ3Z4B1frutDDsPXqltLDPYIy33Tk1Qi+7F59wz9nSNo0lLTpztrpAZ5z1KYxba1QXkdM4Cg+OFopxKX/b2/J5/lwGOAtqjq/IAet4q8k4QsSAqRspQtUAHeB3w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782962808; c=relaxed/relaxed;
	bh=d4vGB2gg+iH4NN3NJaXhXlCloSOjTmNor2yla4grRrk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gh+hu5pM983YlzAco//GEJrBKcxsTnMhAe4MvtGlzY9x3TU7IgSrMuJi4FZ7n8AJZwx3MELJ2VlodZTT6aMrL3SbFvimT+b0ZFzPYYcN2rUCusbeFnNlev4yaT1OCGEci8oH6NNxzzD5bXclPUHLLKF7uNnS5UH85uuph7/ZAYSkDDN5c0A8h25YSjFkN2t/f8+1iUpfDQ1b9iKTusFoDKwAfOr+vVSZQCFzYViGBvfi8hcP/QOwikDZ3f4BkzFH2WxsRug8KguVsezuze7ZF3pXbaXmjtNfv+qN9Q2afp9w75eAi8P3NPDJhwOTqwoell/LS1s3/KEtQapVDJh2yA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gkD51p5e; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gkD51p5e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grMkH6Y0Fz30GV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 13:26:47 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOD9lLkiJy2NGgPjaWr5u5CTHj09A6gwYTSMvQYiVgGCLIze8QdRPcB4I1YfL4GS4fRBr4+djNo8Po30sm1PRhdsoqXbzWiqHfac0TiYT9CrYV4isKKUM6bQFpTWPtUTjLQNLFBrW6CyD9Hr3bkzJczGTXLyY6drqDJfzhzt9JvdhXEzCWZQfp7Uuw6S66oKtR6jZO3NE6bpZ5Q46IusxdMZyZQJFLocIlPSeo1oNxnD6ObPKHuFW2/HwkUT4nWozU8DvmaMcLNBQkjRLHZc05cWRJ1EoK6TfbyiAlVtAeq8AfYU+roWtyeZVdLGO4j5F35qQICKxNvQBH5fO6dl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4vGB2gg+iH4NN3NJaXhXlCloSOjTmNor2yla4grRrk=;
 b=Znv9pxZZLe2sbbobcI3Qt4U5XFxVGvz6vOiDb0TTsIGpmGjpfOhiIa0sMXxBQI+6DvJgi16ELcu3nobuJsZEARP3YH0kIs0AQ2Lt1TsizwQO3Rdpc7anodsGdLeqBBT0Kwa1wcf0hgGfmk7WwtjekwRPmI7Eb3e6XG57Ajdj4/YXArrOm1EBHEFtt+jYMTrJ4CoC746JvZ9h9BORvYAnOU/Ub8rSW4AVqS+tZdtqBIYNUYIeG92sJVydLp6Dzsihkpsl8o7td8BNZT/Aq2sNDhbcKj6Rh3j+NJzWHzxowlz1Uw9ASCTEZHptWuc+csbMq9kJeUrgSFWwTAPf2osXCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4vGB2gg+iH4NN3NJaXhXlCloSOjTmNor2yla4grRrk=;
 b=gkD51p5e5jMNJa5Qcpr77tadAxxkOGWiVj36vWlGjwMPlGzxlUzEZu5epV/EgGRYUwUu1mKyQcHcEekmCuJhkUN+OBEKMJIWsIAyItyWyuusxywuqs6JuDeJJM8mK5QMSC6SECYV3QJGm2BR91H8UTdXOKFKXRoiQZ8bOZL2hfJonfa8jX+2cK52lPjD9cNhCZ2HG5g7V9ZrGmpTTkIbPXdV0c8PJa9lMysNhyK8XOLeCiD4FL6uxfwHexFfJV5qGHqe7iPyHgVnkqKVQbBYLEZpzn0zo5rxFjIpxrfy2cuVpyQ6CX5YFePY5iDsh8jtnvy6EfwIG8jivO/VyXnhnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GVXPR04MB10248.eurprd04.prod.outlook.com (2603:10a6:150:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 03:26:44 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 03:26:44 +0000
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
Subject: [PATCH v2 net-next 13/14] net: enetc: use alloc_etherdev_mqs() to create netdev for VF driver
Date: Thu,  2 Jul 2026 10:57:13 +0800
Message-Id: <20260702025714.456233-14-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702025714.456233-1-wei.fang@oss.nxp.com>
References: <20260702025714.456233-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0276.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f2::19) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 35d05969-ce99-4aae-83f6-08ded7e9bdc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|921020|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qsSztug0gDgLLNjfupPcN0wf0ShLuuIjDfSebnAYBEmiQ318TSwVPpm4LwnCdqSKmmWxKblPeiVOLUmKdkz/vGyTwHAgwCZ7U2ajKLfjqU9lukO84555MbXHKDKc6Ek0WrLX+KwGzMVlbYr2M7lhYzg2n8xDINi2yJRep0yHukQQU70NItOov7DClqDx+jf9+MEsDQXjuv1muR4L6WvSmfw5Qx8q9C3rTJOWuUMFwXTJPA6MHIhFK2XHQcgG1dHEvaZFKpy1rxsZ+38q6MyvDFRfRsytp79Lrxjt/EssLnV4O/XM9/B56JpqVgFi3oKy50SND3Z34jp66zX2rbPeJn4O9eUQLmXBEVtbp83FgxmisleGnXxkWQ88BRPJOlmgHZGsVDabeCsMmqDn4dyavJoXXAdHws1tjS4nw2rGwhf89UPlKjIroOz5LAt+h5aLlQyOmwae4CZvVqCc9G2jkLVB9c+SaJWBErImlsFmpzkyEUpm5mYDNxPomkofsTUVG7xZpXZ1HrBdcnBa5m4b0GJ1pTy5FTrf+WAI9KSyZqhSL7yzocm+0Q7VGqIK9mzXOnpWDNGasAuHJatkeFwb6v6ihV9EXW5Z8WLZo6/HgIet3u7gH4/ZDMnZBwPf+Gk1cVkRxNNWNvFM9rpjcqDcg9fgt8hTyyh+kBd8p7JfWMsOun0GEjzGuxbUFzLZJKyeV7CrJOul22Yff6LBy/USBA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ekO/1BLgctphECUhqTKv7Ky1G5ybH7SVD+llDvS/qlMFYqDAzPJMLK0VAxFN?=
 =?us-ascii?Q?9NGh/ezpfUXMjUXwgj+eJbf+Y0yowcQA65aBWbqDykx1C97z7DXfoi+Y/x2u?=
 =?us-ascii?Q?lFhztgAvgOmDmk+Uim0p1HWoa5ELcUTzV6RdBpjWKGlNDkecoTAxb6cgzzgb?=
 =?us-ascii?Q?BrcIcJL/eeppb/+qPgBIemcog+6tTE/E5M4ShJwOPjK6PmxOkwbflb7kdI6V?=
 =?us-ascii?Q?N4gOxLvk4bJLWGot9if/c3ShZWELlsas4KIpkjzIDjQQyVy/fcNc60wNEYCu?=
 =?us-ascii?Q?Qzm50t8hOuQKfSbI0ZZ3eOa32no8wInssnqtKN6FDsBQG7iUMGxmkK+eC3Bu?=
 =?us-ascii?Q?yw1iIFB1/Cbq041Dl9zWVwjGkQ5bvncNWjLjdhGtwy1qAq6Ba72yS1+Pfqy7?=
 =?us-ascii?Q?Nyx4bRspF+Ve0eRG/3rdvB6Iz2ymVsjSanjqkKoK24w0bDfQNImWN66r6ss6?=
 =?us-ascii?Q?dWc52ETZLvLZdb3iAX72mzh6W57HxRZCPcxxJgkn8MAo3D8KBuCBGQv9FweS?=
 =?us-ascii?Q?Cvydc4Ec0dDzgv/4bk0Jni0084pmTXXQK23zKwh+hmA6Nr1dTy1WiuSP87XO?=
 =?us-ascii?Q?jlZYEDAhvYmxqe0QxSNzVoHTrooYsuYnwiD4RacuG9/AWn1WYLQx4SJIFbN3?=
 =?us-ascii?Q?XtnN55RJy3moEJGmHdzDZnqW19QCCL6/si650rTWmw8JPGeHtuRKLmO4jvwc?=
 =?us-ascii?Q?jzpzu6s5ChiN0bYloWYCPiMJs/Ki7DT+hIZcqctp84PSP0YaDwNvLf+C/Kxs?=
 =?us-ascii?Q?Nh4NjZINGPd5XD1EZOL6FApSQOYkSALlLoVMaNFU12nA0fb4ZcgXXBbfhluY?=
 =?us-ascii?Q?vNS+Em3wSvfJkCEv+0l2AkWIeAv03my7SA59eTGYu98A0gJkv69wak4ePDQz?=
 =?us-ascii?Q?0seHeSxwWoyQttFrTu8xuxBBZnZtspp/lRMc5kyx9MfxoARCOJ6u6RvUO6rm?=
 =?us-ascii?Q?MQ7kvII8CJBawCigal07YpCVZae7+cJ732CY21FJ+j4XXpMkemPScWA6VcGu?=
 =?us-ascii?Q?woE99ju1YdOs59rerY884Jwq8LuCLDxK+fKqrDcEdjEnYzvp3iyDcrhgSwVF?=
 =?us-ascii?Q?RoITP5vAVgiuEccbnobiGL3hv1Zf0GNnz6ypA0nuRLzssd2HpZeKrmqqcu/o?=
 =?us-ascii?Q?XztOZVzdzKMYoECPfqj9EtChZ4zXGc07RN/D86JLxxG/Cy3srk5IpMrwytzz?=
 =?us-ascii?Q?7DyE+szNasdkh7HrqcWSPoXno5h0VANodjDUa6snA5WqH/cTYJD1EeSDM5IL?=
 =?us-ascii?Q?x9a2XCPNM6boTZkfWPTupged/oMc9uH/gehBuxNetplQi+0e8DCL66PTwhzm?=
 =?us-ascii?Q?nxc0iIBpkw9KBQsOkDQKqy+PdFtUd/dDfooKp3wwxQ31bc0mHa0vEC3XRYCq?=
 =?us-ascii?Q?oHw2AjWdmdueRnbNyc9xXbeI6nLHTlMD43dUSKgl26g64SAFeVgM0gCGoseA?=
 =?us-ascii?Q?6sFOp2rrdUA9YDyjXKICDe+3gFFVx6siykSQlbDjc7+2tUh3syZ3v7B5QFEu?=
 =?us-ascii?Q?mhizK6bzCY/LV2zD1U4gsvTO0xbpiNJrfAbv6YsDLoU8T99GmKLe0lLmax0A?=
 =?us-ascii?Q?iw+zyFn60ZBlNaUxr6ks0PeBmAM42PFdirsboGulfmhzoMEVS8CqJN6cweuB?=
 =?us-ascii?Q?KOgsaq2B0Tm9dKCdTHYXYAN1aIC7G6UtU3CSDGpPHcl24q22WFl+yxMLJS4w?=
 =?us-ascii?Q?YkzwsJVrGOAsVdWk6ePTS8fdPEbZ368/eYdYcoFIQZrThSVrRexKhE+ZhHDB?=
 =?us-ascii?Q?lAU2VNDJ5ydaoe1+ELqjEJIWQXmDolkoaGucfA8KqRVHIr0ppglG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d05969-ce99-4aae-83f6-08ded7e9bdc3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 03:26:44.7222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/AqRuf4i9kRTUlICIvhhJZ0aMibM9lXP9AcCxCj8nB07+94KBBsYl5j7AEIod71IXviuuMh6xN30LEj7Lag6SDKT4m6s27kGls90w8H3v6ADUrqQ+cXdyWshQbACn2E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10248

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
counts are set independently based on the real hardware values, avoiding
unnecessary queue structure allocation when the VF has fewer rings than
ENETC_MAX_NUM_TXQS.

Note that if future SoCs have more than 6 CPUs and more than 6 RX rings
allocated to VFs, the size of the int_vector array in struct
enetc_ndev_priv will need to be modified. Similarly, if more than 8 TX
rings are allocated to each int_vector, ENETC_MAX_NUM_TXQS will also
need to be modified.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_vf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 9cdb0a4d6baf..3df515a6e333 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -317,7 +317,8 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 
 	enetc_get_si_caps(si);
 
-	ndev = alloc_etherdev_mq(sizeof(*priv), ENETC_MAX_NUM_TXQS);
+	ndev = alloc_etherdev_mqs(sizeof(*priv), si->num_tx_rings,
+				  si->num_rx_rings);
 	if (!ndev) {
 		err = -ENOMEM;
 		dev_err(&pdev->dev, "netdev creation failed\n");
-- 
2.34.1



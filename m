Return-Path: <linuxppc-dev+bounces-23696-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE14CC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 08:48:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvZdB2TwKz3cMB;
	Tue, 07 Jul 2026 18:48:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783414110;
	cv=pass; b=CKxEMz7DZypkMcoPkXqKT3yFJrGB7WgpPkMGEUrdXhuFYGnYkivm8aHMuITAxk++LGGpRT8CYU6zELdgyLZFjC4qtx2YZHpMI4XAHwn0yvigYOTyPdRIBEEEgDip5JKzO65IabSBN78PXOVglMT2YsZQvduEyZgjSXVjkmL/YqcLOSXobRPd6QgBYTSKFkfbhf+/RccPW2vrCq8q80ex4R7i/mRKB3xepZRBcB20LsTbn9Emgcu3QqDmFdqzPIe1IkJHCoLQh082ozqfQKoYfveI6618cOQXbqRE/yNZx+vuqokURvMi/yiW4sUo/BM7m19KnpGsi9D1r4MKUgzjYA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783414110; c=relaxed/relaxed;
	bh=KLTF9WBAGeAwf9k55IX0Wuhsh8qjn6IELVpYq/SKvck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Onb5VgswfKK7idOk/T7TQLDKn//ndsPGsR7KSgeN2/oigPdOWWizIOtBHIo+WnN0EIZbnQ03B8x7lyLL18oaZbBpL73RdBQkqoYmFckQ8kgLA79qKtxLFHXI9bgU7b39zYy6k3sJsyOQhPCsT69NiV3I1QY797Tmdrmfq6zRJsQsgo1lDc8fYVkvRhEdmzptkUiV4mVYb69e70u8aghulQ2298EvgoBZUBQBtgQL9lKVSwCpDPn6mGvvs3JjEu0oBFbVTGpdYSlW8p5V5KI3r+SvbNk1CsNo5Eu27OZ979jO8DHgu0Qbm0dEI2Wu5BmbR+h33CcH4hL1K1v5+fz5Ww==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=URymIN/k; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=URymIN/k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvZd93vDzz3cPN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 18:48:29 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoa8Ex1bh0Osx+j6ieGKGn4JCcs6t5o7SvVVF/RPZju2k4ocbcX1kpfIVA78WLBDgBgk+sQhStIy9yUq5VWrX84/hd0Vp2AbYB8TDcGwGkZ+pAesMXOWDaLvwSrW30poSQv5tV1LSwHZ4r8Uk2+GP+rYU8vVa8P9mYxVm39C0wcPPD4011RmHxmT84wNbVbhppoTmqsaYOqMC3x3/fO/uhmAb8YBrP1grjPqybVAE4rnebgLzecMXR2X23oC8/DjVI2mIhva1Utqf3C4XFUk+CRfQBPd14r3rukjEnhdWbuUYOxtqvIZj6GaJ0r4l5Gpasya9UsAnj0fwKwHmr82ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLTF9WBAGeAwf9k55IX0Wuhsh8qjn6IELVpYq/SKvck=;
 b=M4UsNYIcaFkBeb+iAWdrP++C/YcBBZ80KRidDlH4zxDvYG9mvT5MRaRCaR8o3JXOaoqUat9x0jqcHSOJL5W8BowxC1EBqNOVbQP5chFAjkKVsFKD7WnHxCXazIzgwhDq11Q9dqv9GdSaXRX4KO2uNXE8dnCLmv/HddH0MBG41MtehPjc1EPxl+YVgLeKk0LAxMvzuMO84mHQyU4llLaaEIHosNgBqp0viWG+2cyBEtglKwDEzM2on/0oJ8VHxmuRb1VaEiQBH91ILIBR5O0c+w/UPzsrm6in+687zV5VaHamFqeDm6f5eTmdkXXuo21bd245lceCHYx5yDByb9xgyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLTF9WBAGeAwf9k55IX0Wuhsh8qjn6IELVpYq/SKvck=;
 b=URymIN/kAakyM4b/TYSiEqh9P4heVdFrLhbHunvVhZWbfNCF6goQ2W5gWA8XEMQnknRVHoHe2UPOo9ZieZdOsnzpUH6ATohGCmW+0KA/L1Jgwu6FVe7LVf7VeSJlcco6ZlqN3DhzeL6AhQXt+jfVwW4eBb6shdvKP5yFjoWApDq1m8v7cMqln+C86f1iZDsIDkstLk332/8S7R9ic7EvkYonlA5RCEKCXGmQwZnIu6IohbfoQgpS1mIXW0FXvlBBae0f8ozN4gC4WK7pzDJ+Xgkp55vx5I5gV0vltiOwH+sbPX2TF9NVUuAc039jJAeb7WlqQWCmLBqfDFi3oXkrBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:48:12 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:48:11 +0000
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
Subject: [PATCH v4 net-next 13/14] net: enetc: use alloc_etherdev_mqs() to create netdev for VF driver
Date: Tue,  7 Jul 2026 16:18:33 +0800
Message-Id: <20260707081834.710730-14-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707081834.710730-1-wei.fang@oss.nxp.com>
References: <20260707081834.710730-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VI1PR04MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c30acc1-33e3-4266-ce29-08dedc0479b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|19092799006|56012099006|22082099003|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	G5RmKhspaERoPxQ+P9kA1Qm8LIsuo1V0CT3m5YCTq2N1o2XbZh8U7wVhDEAzBAlC8AoNTBuNK97G428Mr8O/HruAb9sewd0fwCzYCOe3wxbT+F9eZmh/akCIUbumSf9IO9+1xGg100Ygmo1JgSN2S7lYee3bEICCmQzF/iMDQrV+E60FJ0rE11ebsbur7pelzcbfOZAocyRhquBK8Bjh5Fhn9Twht9l5s/9djNrGeyftCGhcGMAN3JqziOtvoGhUDvpYTEeIn/Vd7aQkvVxtcbs+3SDwCJnqlLM4P99ZC+x91TUa4sc8C1Vq74UY88K5DNtChGx6e1Dc9RtQ2XAFpAiR9WV4e9+YPaP+ATe9Ge9WGs2Jt4EC1/6L8GDXoFQ/H3KC1Of3+yPmZED2e/rNPCIkUAIVxX+Hcah0gmDnE7CfbpDcQug9vONuUXvbk7NidZb7Ex3FwOSrtHS+/J4QgwboIqOfZRED8oYhGmnDChk4Ko42/OAM68hAGMJTvwGUVEAm7cfcJoBOj+I7tgDvFomKPawiDG8DU40TaBIcBqudQvFujI2Toh1J/YJImc0Hy2W9smY05+knUgxpzdkgzaLuzbH50LvhAP5eTSU+WBagj5a4iK3v+gx8w7qUlnAHTm08DOYYwBMXitGjnCUY3jgQ+0N8AwyAfHZ6fhC9JwRNVCeez4VrBtArlu0Crm/kuEw2ZzmOYI0GPG6EAsqpBg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(19092799006)(56012099006)(22082099003)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UNElAaRVwsYsbpeCNHmd9kvj24SZDUfeZTAUXperjjLfagRza4jVrCxVbojH?=
 =?us-ascii?Q?gxUFmycL8XVWwdh2x+uG1BjGAI43W1F/pKCXfp/lrkNke70V3dgIQ4Po4n0D?=
 =?us-ascii?Q?QbGotzPKsZ1oxy+Vzk5uw/ryjUo+eHt3Ne8ISYcg2URYzp0x+icZokyWwA0D?=
 =?us-ascii?Q?qUNXDucQDlQmt76+5crf+VfP984/o1AnRawQ/d7vvrzmZgQt7bNm4/bnIwst?=
 =?us-ascii?Q?G0U9V+tqxZdPEpFKF2V70sKuTs2pH22vLuX5Cm+kplVjTsuxUtI0Yl3zoU//?=
 =?us-ascii?Q?hh6lnFJv0GTdGkTnp8QsdnbyAeDBXnLX7vRIT2428PcRysQHgXiw4ZFLscte?=
 =?us-ascii?Q?CSvEnR/xBA2EwYWYnqGzTfjjbWuPolbGWziLgqCI1BUlpdVO1b6ysucA0ChE?=
 =?us-ascii?Q?YidVt9KaX/MCQBW627+5pBviUl5/jbAlqYE8XKmcBrX3MTMcrSTzXQjkbRNK?=
 =?us-ascii?Q?Hkga/ymowO5Gl1zjzTDol/kpqQxH4cDbd/6rEj/dLxuLaFxxvE64i/VIid/u?=
 =?us-ascii?Q?S/TOpNPXPJNK52JtQGf3tqTpzUKHRONjHtkr7yFb1avZoHt3qD364cLp8ORp?=
 =?us-ascii?Q?D5tgJQuQG5AcIOsDeZJ79Ssi/BGr55MAoDUEzg50nruFuGhV/IRJTz91E/bY?=
 =?us-ascii?Q?9tLmHvEqqK36NXay2hKKaZRY6mmt74WarBfvlhLEr7SqvWILl6Tcv5Vgt0Cm?=
 =?us-ascii?Q?nnJsJ/pqurCLTl17O3I95Gkeq40sAKRlQpH8fR+xUfeV7mnKhLpszrLktMBx?=
 =?us-ascii?Q?2lYC0BmxIoA1+t/5CiEtSjXJgsDnNHa5axPGfHLl3E+XCovGaENI9BlaTNWy?=
 =?us-ascii?Q?0ZMHOz21hfpbgOvJuDnArzznhtblPl+p1Oa6loV/fpYmyVf1WIgLI38r6ACa?=
 =?us-ascii?Q?cJR1ULmSwE6voennTNo/XQOiJRfBZAuyJ5kAvgA/kqC3SfkvlnPsFK3wSe6D?=
 =?us-ascii?Q?/E6Xa62FYFtiKycMTpiKjE9k8HK54d+pSMakM4NVr7OZcGBbkksLN3RwpqMa?=
 =?us-ascii?Q?awrZxKzMw208yTgB9nv6Y+v7Wx1/A60wuwijNlcuOzLyTvFVOX8pJJ74IHfL?=
 =?us-ascii?Q?F5PvGWYl79mbatquPGNDbCMK3GEteOYHrgQm0lMdwkHQ6eVBK/z6h3ecqoCk?=
 =?us-ascii?Q?BT36WGYXGwLvSpuuhYMJv6o3bU5ZDLp1OfPIpqLNXTD8ta/N4+4rnTqEn8GN?=
 =?us-ascii?Q?WVOffqqtAt+vC6FXW+IB+C46CRVib9HH2rQ3TrfwYxyoIzyE1WO4TuRhATgu?=
 =?us-ascii?Q?77vObYWa1KgvHvbZVIqrlJIBVUEeh7YCvTaObF9tdCzSwEyssV5H9Ozx2R+r?=
 =?us-ascii?Q?y5sDvoj70UAlP1/sneMipGRTODunIJJjpr/mgUYpJytVH+UPWKV/fBGMYtGG?=
 =?us-ascii?Q?IiXOrweDP13IdaztOWSOdJ9RnKKIPZ1OpHbg7CK6xY1E9pb19nPqkcwID5d4?=
 =?us-ascii?Q?AKVkTwrk/ust7Ouk2uf97WgugEghs4KH1SS9a9sTKXLqDn1yWtXM0yGMxkxW?=
 =?us-ascii?Q?VDKhTcoQ7WTMuZr11/saRqPleMrb8xALneUHwUu2x2WhNMlEZE7cidT7fYL8?=
 =?us-ascii?Q?JJlABPvYCjL4ZysY34Q8eyICLhiH/mc6uiMbfI4TWvuWRmAQfjwJ6d2LyFDy?=
 =?us-ascii?Q?vUEGIZDAYV1bFT3OcNt4qhcT4pWjn4PUZXTNmG4UbdeitH9o1o9nOS4Vmwst?=
 =?us-ascii?Q?rqyvcohDNwNZ9EXbpmDy0T5el+kbChcFlPh6MF0XrgAYpy46BD06Av+YZtGg?=
 =?us-ascii?Q?f3inZBMVruTjQ65GEfQO6PF00aUKr+jjsxGxK4pfoZ7g01k+Nkpf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c30acc1-33e3-4266-ce29-08dedc0479b4
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:48:11.4828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7TC0JzcLUTjWU96b80PXMKgrC+KAiDMpBeEKIKokbl9Z22LCCHwNN4rdfUOpU6zBwX9Tek3OLe/kUydGzF+t88KmazyAMXwYoeSXpyauH5JqJI1yRv850eSwoR/bix9N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182

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



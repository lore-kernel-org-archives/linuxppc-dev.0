Return-Path: <linuxppc-dev+bounces-20804-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40369CD343F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 03:03:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFdZ14DgTz2ySl;
	Wed, 13 May 2026 13:03:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778641385;
	cv=pass; b=m0gDo6A4j3z0Hqgthct1PYOzNOEhrkCTcyM50k20PubHoHpit1KfM/ZUCGqGKCfLAOwhOy3bop98YdZBCvJOMdgGC0bMRwzcggIpce4UQKqi8VLmJhDSLxdu/rtQWam3Z1/PPojzQ2LRQ3/0cSXd+ICH03dSucd31FEhYnObWOj+UpPjQgdDDYDRwlUE/WKoa7m4g7QNGWnAHs7a+MHTSnkwTs/Zv0C0RsiYUf92LfdqxMZOHmpWN4ZLUukyI3ijuSxRcm7hYvn8jpEkRgEmTgIT58c8yelxWfPgCJdh2wGnZ8XxmUQCqJzEMJ4WKdtB3MCztvlfTKYH1Re9lkNpCg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778641385; c=relaxed/relaxed;
	bh=+OkTituhj851UTH98eKeCkJCczBoTU+PcRf+naGINh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HIwtk+hKKgt87zBVYYu7IWrtN/iwxk/9X48wCvAerMH20eYxAMeQ60XsykW7Wqk6fw+vTUi19Ns9D7IbenG3OFOrMnorg2WKS5oNSrg9EnfW2t1CACsKpqdD2NuR2Dytuo0hd+NcXqHJKDr11OfNd9plFWYpvnQtiV5nU7JHKWkBl8J62jkqSxPPxI2Q3L9P2M1M4zNdExom+QzK803X6l8L697+z3JthvntoYId+UtE67/jmbV4WcrA7v4rellvrU7emM9I+0k/eb0wSo5TwsstK7RD9Phj+r72oilkgUhlcD9zRFRTG7UPPyWs3HSbNWCKJXouZAqKO1WWTEfkeQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=aez/4exG; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=aez/4exG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFdZ04YGyz2yS6
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 13:03:04 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pci/HAzGCxRsONV6uyisP6sbeTxkRbqLoSKeilHX1IYhAO0RJSbXvKYgPpQwVN1XX8ZU1fhwSn0MSA/WN/fpBh50fO4yFd8cTLOKA8AqzPQe3iUTEkteZkbSO2Vxtm8rtzjsj31oeOrclm50aBnHyGnAZwfCRE1+Vj7tdd2qq/Q1JODOd6jZVeExEAS7omU00D09dqDBWhtj63KaeaWQFjw5JY8LT8nDRuos5e3ZFr71CXhkRTQiOtnggBk94Zsf32ODxvsSz1myXS6f7GWl9WIDA/afkas0nb/KjBUkg7oBhdWQNC94pPKe2Xx+HpgQBn85DRCzYsQDCk3v3iRUxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OkTituhj851UTH98eKeCkJCczBoTU+PcRf+naGINh0=;
 b=CwWVWUoiF9xGTWRjOQea/uw9HnlgfVVA2LF23ApFQiCzpn/LlWhA3+lNABEMNd8uYs/bd9luH7cHpZyl6wP56OQlkK5K4h8fmK4D0T0m8+hz3N1KNzXVQiWMPAZp4ayMXaapyVKAJz8Xq0RaTOYzQKBUnnsN6OqbqhhBYxneqWFclCo9okZck0dHVZHu8YEQMn/cu7MRq6bBLpJQI2FPNjXkGHW3p1MEKC6FChAqG2GW1ZDWSBMTB8W/eCTeByO23/cnQRtbBhPtZ7Xg8OLOzDvdPMYKMwSRtvCytmWJAiFYkgng41pdQry/JWfiUpZ0veGAJ9zhONIwBh1zT/AlKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OkTituhj851UTH98eKeCkJCczBoTU+PcRf+naGINh0=;
 b=aez/4exGZFiXBt6FDtj5OHFLbOksMfcbq2bRw+/qg+NwwCUt59QRXt/iDw1SvFPgZHdoarikeeMMouu7/miZy+6Dxn0P40pyHRSfggUYHSQUPjePyMbeOkOS6wIO2tnXepH0AoJ16SESglOc7pTKlsassWPj8BFp5XevXf9YXrtAR+zmlJfiOs5p+ITSgFz3FWXzNnsvqCT4ram6b09L+hfVafv1r/phMn8Qjbs2tHXfUd5DPTIhAeixSXx92sfflvZXACJ3nxWHdlot2W4yOW3tXYa9/7jNQN4nvdyTdeYc0LBzVbkO3FLslf4NXA1wXtn22jBcmYcnIbYC2Z3IMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by GV1PR04MB11525.eurprd04.prod.outlook.com (2603:10a6:150:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 03:02:48 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 03:02:48 +0000
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
Subject: [PATCH v7 net-next 03/15] net: enetc: add pre-boot initialization for i.MX94 switch
Date: Wed, 13 May 2026 11:04:42 +0800
Message-Id: <20260513030454.1666570-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513030454.1666570-1-wei.fang@nxp.com>
References: <20260513030454.1666570-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0029.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|GV1PR04MB11525:EE_
X-MS-Office365-Filtering-Correlation-Id: 105c390a-30b7-4f00-5394-08deb09c1d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|56012099003|18002099003|22082099003|3023799003|11063799003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	7GJJl5DaMOxbO+9T8s9leuGe1Aifr1zxzWHw+uQS66OxvtVgrUZqIh/ZZs1JnPZow55BStHbsh9CvFpopRRl4Np158sp74dgzOihLTcKxBg9m7vkXKK0sL2KRVHiU0mzIUFIqYcHg3KRLTG5mzxztkcy6q4WN1pRU8wl6xabq+bsZP6PsMkB/Wu3IFTnaBiD8ffEXTAKdmJHtx4cr5tgTPePAJ4h6zC4ZYDbNUggfqSY0RZ4NIicNpu5iDKV584CV3vUaZ6OER/mL8T3JyjR75kM9oLXXOGIf5QjzuQ70SXM1XnORHQsQBHUiml3u08DTBFzzc8ZpsqallOG9C0NzYRiGCPEtyfThXEXORpfVHN6G6C8hz53hYVl8oee4S7rBC5UdQZciOv8XAyGcR32/rc43snToNhoCKqQyxKgBXYrJOIzPcNi1ZpOrTs+O5PQgzFN5TvCSJqYpYzZRoc16iBd6kxEAxrZD+sQoeqY88oUkl/VG6Qs+Q7UWATeTi7MHtwxigq3d95/Fg+5IKziEZjF2mZMx4+zxqdvrU/Sq/Ukm7C3Ea2OmKBkfz17BvxIJYhLutSAYm1+b2aBLoUOiounAK1kAyiTJQhVbpqbaY/EAxd2spd0OhxQzsJ1YI5ihBgqUlJF6lv0ajK9z0ECFix2dKA+Vx3F54fDdatLf7rYBZlmhqLjZnUxf0GI/+/liX/uCoBKCKu7pKrPrRI8GDpXXDaTsHqmDNUkYr1vSGKlMk/MvH/yH/yIxKJkZ/XXqHYbIc7k5+ROAfv+8nOuDg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(56012099003)(18002099003)(22082099003)(3023799003)(11063799003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S3iNBrP3Xaa4Oi8oCPwjIrrgeOkrIxUUbBCK1Psp5uo8ayGwX8SWFytY9Q3t?=
 =?us-ascii?Q?6ax501EAuZZJvGUB2tOzv2SrwnXbHf/8kGNqxhUMiTg3BTp/QsK3xpCOf+8c?=
 =?us-ascii?Q?oqRJ8g9d8AGd1yaGsS1YlhfguhbSqVQPTCo7U5tTadTc8zHOXVefgvA4Yau4?=
 =?us-ascii?Q?OOj4prlKitLplP2QBS7wuwnHxuhdJOVBDEwjZb+oqTRnzGJan3hNRp4xB5J0?=
 =?us-ascii?Q?MrjVA0tcU56KXU+Mq564e/Y8u6neQIAgOazfWmJu8A1W51VkzhzfMiJtGVBh?=
 =?us-ascii?Q?IiZm5f6KRdg+KjFU9MUpfFjipjssTeQVEi9yP1IYm3mmQ0PDDYEoLxoNdRdz?=
 =?us-ascii?Q?Vn3fEd3g1VZ6PN/QuP30gYj1c/prueIiPTnr0+L7ObGTvgTwJdmcv19voZev?=
 =?us-ascii?Q?PrRUY634O3DlwCjtv9IilVrOgmxlrkONS15vbMu5qYU+MwQFimd1Q8Qb6Uw4?=
 =?us-ascii?Q?syL2CI0wXAdggLUeIChT+ZxNcOYH8TwMu60OmNirx2+8yz2bX2nzcYD+BjgJ?=
 =?us-ascii?Q?xztcmObWNcs9dSb4pqGXOT09wqqrTdgELYdbfh0Bwdbc2er+I6jrVmdo0xkw?=
 =?us-ascii?Q?alBY94AMwSI8DIYp1gCkkDglHJDo6sUo3CPwCBt0cQ9yIf49znCSKz12xjuV?=
 =?us-ascii?Q?pMWFmfn1mM1S1oatBDmkXyh8/EEuDoeobsO5jHP3Xg4/JbwgSQzim85h0BbU?=
 =?us-ascii?Q?AaLBWh3MnYGmXKqxcuq4VZH5wXC1p2GjwGXmDlzW9g234cd9+5z7WQcHU7E1?=
 =?us-ascii?Q?UNgV7g6Sl6rvOOi8DmIWMsLKeHmOjEDTc7aa76Kg49GvH3p7smBQJdlHq/fA?=
 =?us-ascii?Q?APkrKiV9xRX2aFS9gf68QlpMuYka55cz8EEt27fOXAkECJ62leBPvC+bV7MT?=
 =?us-ascii?Q?904e50HuO3b7Va3PVq4SPyqO9G6pTqjJZ1HAHmyxZ3vK4DF7EP4bztFD5wni?=
 =?us-ascii?Q?/P4wZkOp+MrLAtnDJTSA/A90RnjgnalslXQPx9pXwGLe9jisP+FbP6KzaWdb?=
 =?us-ascii?Q?jhQjDSGxEysKssC8wiShHN/h9adNpB/VZ6tr/3DL8Cae8EXLeeKORHla50pZ?=
 =?us-ascii?Q?+H+4hRfc84Tutl+wDt6V078S171xMlRk2lLDZKo7WD+Bp+J+mJS7RkNuKQbY?=
 =?us-ascii?Q?qUmcEkxt3r3a/sXVdoV6WGdp5sbS6F/7i8SPXTTg6Hm6K0BBigR6sSb86aHG?=
 =?us-ascii?Q?BTQzZ6ZID5XFnrUHiqh16inHE9DQky1u+i4+2fCavia7DGPffxI1sb9BxTcq?=
 =?us-ascii?Q?L0yvMCxzvHeyVVtAke8Xifz27xqoSz5zf/7ND1qryrmcHr0SjcCwfq73EFvn?=
 =?us-ascii?Q?EMXURLBo0TW7YbMcSPx+XWCa8SaRzxyROpaGBuV4iqIkSMiwhIT7HDcwRFf4?=
 =?us-ascii?Q?Is+aBWHe4wCWccAFwRyxaFqQfhQEU+g5HwK/7sC3Gmpyz+fxPgsciAK1vDFW?=
 =?us-ascii?Q?xPd9ZsG3mXlmgCzvKDqFZamN34FDSgMUe8njuEAXVCaAZ9+s5ewmwtc6rDLt?=
 =?us-ascii?Q?/HrtRXRndFN3U9VoNNrqPsMwf8JETDx1Ds3Wa2T6aexV0OVMesg1AorhWHlY?=
 =?us-ascii?Q?Mo5KWxv/sATi18K5mMkpZdJlH6xyQWfkrrguWVbhb687ZBq7xU9MOLrV2jXF?=
 =?us-ascii?Q?HldKbZ/PCLeBY6Y3fb+pFFfjs6KzXE6RCVcz5dLsbZQNWq015nd/YzhT0icw?=
 =?us-ascii?Q?O2KspJhbSOcXuVNW6PQL7P4qqBlqVMp0PseUv9Nujd9C+aDB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105c390a-30b7-4f00-5394-08deb09c1d3c
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 03:02:48.5811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKZa9sh2IzmL10Ta+rmba9KwxLNGbqXWOgk8uh9Q2fptd1oHU/9zd3vK5A41GtcwUuuU9eG/TBon6BpqdW5Yng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11525

Before probing the NETC switch driver, some pre-initialization needs to
be set in NETCMIX and IERB to ensure that the switch can work properly.
For example, i.MX94 NETC switch has three external ports and each port
is bound to a link. And each link needs to be configured so that it can
work properly, such as I/O variant and MII protocol.

In addition, the switch port 2 (MAC 2) and ENETC 0 (MAC 3) share the same
parallel interface, they cannot be used at the same time due to the SoC
constraint. And the MAC selection is controlled by the mac2_mac3_sel bit
of EXT_PIN_CONTROL register. Currently, the interface is set for ENETC 0
by default unless the switch port 2 is enabled in the DT node.

Like ENETC, each external port of the NETC switch can manage its external
PHY through its port MDIO registers. And the port can only access its own
external PHY by setting the PHY address to the LaBCR[MDIO_PHYAD_PRTAD].
If the accessed PHY address is not equal to LaBCR[MDIO_PHYAD_PRTAD], then
the MDIO access initiated by port MDIO will be invalid.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 185 +++++++++++++++---
 1 file changed, 163 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
index 92a0f824dae7..c7eb0234c785 100644
--- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -261,40 +261,108 @@ static int imx94_link_config(struct netc_blk_ctrl *priv,
 }
 
 static int imx94_enetc_link_config(struct netc_blk_ctrl *priv,
-				   struct device_node *np)
+				   struct device_node *np,
+				   bool *enetc0_en)
 {
 	int link_id = imx94_enetc_get_link_id(np);
 
 	if (link_id < 0)
 		return link_id;
 
+	if (link_id == IMX94_ENETC0_LINK && of_device_is_available(np))
+		*enetc0_en = true;
+
 	return imx94_link_config(priv, np, link_id);
 }
 
+static int imx94_switch_link_config(struct netc_blk_ctrl *priv,
+				    struct device_node *np,
+				    bool *swp2_en)
+{
+	struct device_node *ports;
+	u32 port_id;
+	int err = 0;
+
+	ports = of_get_child_by_name(np, "ethernet-ports");
+	if (!ports)
+		return -ENODEV;
+
+	/* The switch may be owned by a guest OS, in this case, the switch
+	 * node in the host OS will be disabled, but we still hope that the
+	 * host OS could do some configurations for the switch, as the
+	 * netc_blk_ctrl is owned by host OS. So of_device_is_available()
+	 * is not needed here.
+	 */
+	for_each_available_child_of_node_scoped(ports, child) {
+		if (of_property_read_u32(child, "reg", &port_id) < 0) {
+			err = -ENODEV;
+			goto end;
+		}
+
+		switch (port_id) {
+		case 0 ... 2: /* External ports */
+			err = imx94_link_config(priv, child, port_id);
+			if (err)
+				goto end;
+
+			if (port_id == 2)
+				*swp2_en = true;
+
+			break;
+		case 3: /* CPU port */
+			break;
+		default:
+			err = -EINVAL;
+			goto end;
+		}
+	}
+
+end:
+	of_node_put(ports);
+
+	return err;
+}
+
 static int imx94_netcmix_init(struct platform_device *pdev)
 {
 	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
 	struct device_node *np = pdev->dev.of_node;
+	bool enetc0_en = false, swp2_en = false;
 	u32 val;
 	int err;
 
 	for_each_child_of_node_scoped(np, child) {
 		for_each_child_of_node_scoped(child, gchild) {
-			if (!of_device_is_compatible(gchild, "pci1131,e101"))
-				continue;
-
-			err = imx94_enetc_link_config(priv, gchild);
-			if (err)
-				return err;
+			if (of_device_is_compatible(gchild, "pci1131,e101")) {
+				err = imx94_enetc_link_config(priv, gchild,
+							      &enetc0_en);
+				if (err)
+					return err;
+			} else if (of_device_is_compatible(gchild,
+							   "pci1131,eef2")) {
+				err = imx94_switch_link_config(priv, gchild,
+							       &swp2_en);
+				if (err)
+					return err;
+			}
 		}
 	}
 
-	/* ENETC 0 and switch port 2 share the same parallel interface.
-	 * Currently, the switch is not supported, so this interface is
-	 * used by ENETC 0 by default.
+	if (enetc0_en && swp2_en) {
+		dev_err(&pdev->dev,
+			"Cannot enable swp2 and enetc0 at the same time\n");
+		return -EINVAL;
+	}
+
+	/* ENETC 0 and switch port 2 share the same parallel interface, they
+	 * cannot be enabled at the same time. The interface is set for the
+	 * ENETC 0 by default unless the switch port 2 is enabled in the DTS.
 	 */
 	val = netc_reg_read(priv->netcmix, IMX94_EXT_PIN_CONTROL);
-	val |= MAC2_MAC3_SEL;
+	if (!swp2_en)
+		val |= MAC2_MAC3_SEL;
+	else
+		val &= ~MAC2_MAC3_SEL;
 	netc_reg_write(priv->netcmix, IMX94_EXT_PIN_CONTROL, val);
 
 	return 0;
@@ -610,6 +678,78 @@ static int imx94_enetc_mdio_phyaddr_config(struct netc_blk_ctrl *priv,
 	return 0;
 }
 
+static int imx94_ierb_enetc_init(struct netc_blk_ctrl *priv,
+				 struct device_node *np,
+				 u32 phy_mask)
+{
+	int err;
+
+	err = imx94_enetc_update_tid(priv, np);
+	if (err)
+		return err;
+
+	return imx94_enetc_mdio_phyaddr_config(priv, np, phy_mask);
+}
+
+static int imx94_switch_mdio_phyaddr_config(struct netc_blk_ctrl *priv,
+					    struct device_node *np,
+					    u32 port_id, u32 phy_mask)
+{
+	int addr;
+
+	/* The switch has 3 external ports at most */
+	if (port_id > 2)
+		return 0;
+
+	addr = netc_get_phy_addr(np);
+	if (addr < 0) {
+		if (addr == -ENODEV)
+			return 0;
+
+		return addr;
+	}
+
+	if (phy_mask & BIT(addr)) {
+		dev_err(&priv->pdev->dev,
+			"Found same PHY address in EMDIO and switch node\n");
+		return -EINVAL;
+	}
+
+	netc_reg_write(priv->ierb, IERB_LBCR(port_id),
+		       LBCR_MDIO_PHYAD_PRTAD(addr));
+
+	return 0;
+}
+
+static int imx94_ierb_switch_init(struct netc_blk_ctrl *priv,
+				  struct device_node *np,
+				  u32 phy_mask)
+{
+	struct device_node *ports;
+	u32 port_id;
+	int err = 0;
+
+	ports = of_get_child_by_name(np, "ethernet-ports");
+	if (!ports)
+		return -ENODEV;
+
+	for_each_available_child_of_node_scoped(ports, child) {
+		err = of_property_read_u32(child, "reg", &port_id);
+		if (err)
+			goto end;
+
+		err = imx94_switch_mdio_phyaddr_config(priv, child,
+						       port_id, phy_mask);
+		if (err)
+			goto end;
+	}
+
+end:
+	of_node_put(ports);
+
+	return err;
+}
+
 static int imx94_ierb_init(struct platform_device *pdev)
 {
 	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
@@ -625,17 +765,18 @@ static int imx94_ierb_init(struct platform_device *pdev)
 
 	for_each_child_of_node_scoped(np, child) {
 		for_each_child_of_node_scoped(child, gchild) {
-			if (!of_device_is_compatible(gchild, "pci1131,e101"))
-				continue;
-
-			err = imx94_enetc_update_tid(priv, gchild);
-			if (err)
-				return err;
-
-			err = imx94_enetc_mdio_phyaddr_config(priv, gchild,
-							      phy_mask);
-			if (err)
-				return err;
+			if (of_device_is_compatible(gchild, "pci1131,e101")) {
+				err = imx94_ierb_enetc_init(priv, gchild,
+							    phy_mask);
+				if (err)
+					return err;
+			} else if (of_device_is_compatible(gchild,
+							   "pci1131,eef2")) {
+				err = imx94_ierb_switch_init(priv, gchild,
+							     phy_mask);
+				if (err)
+					return err;
+			}
 		}
 	}
 
-- 
2.34.1



Return-Path: <linuxppc-dev+bounces-23352-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64990C43327
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 03:26:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grMkC6lVpz2ygX;
	Thu, 02 Jul 2026 13:26:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782962803;
	cv=pass; b=o2w2TucvswQLSlvVujO9L9epBtD27/8V8ilFlRBBE4RdZygzCrsZdhbtSu+p+u9ypM+oPgXm8vXqU5k9D2mfthYAU80MGTb2imaggTjpdQ1WqGl4hHJPDhS3PiVBuwuDRGaGtmnACnfKbC2h0P1LBRrfsAMzuv2bWa4MKh8G8V0OkqLoCsCfWBnYNJoq3v02JJlzluttTteytmCGmLI9yIkpwLvAymJQDqdciQg4h7CUEFeUqoV9IJeYje7dL4iQNQuRUgBvZS5dH2LwdCkhlyK3mn0xN8MZbQSZhBEhd95bvg9CZXQaMIw/80nV8jeUyNrKtSNN/4+e5Gs6y8GnLA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782962803; c=relaxed/relaxed;
	bh=ry3dFK71fybVUZimY1nsp69jg29Ugxd+1zZFlEL6aes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QhX/wn+tp9Z718PcAFYiADlKRPysSRN5cBVLosWW19CIUnDiXkbcLDo0vzb/E/DEKbD4Ny8bCJgt8UzYJscyTEmJA98WxKOAI8Tuzp9FARSlOekAsm0G25gmSkuqbwMQzBbhxXZyYumQOPSlBjO/ZaHC5zJNat5ZxiKkNns/waqtkVbRUNSM2AawRVUJTPW2jxgbuv+E0W+1k2YEgl94cia4iG9MeELsZw40qdFSiOKwpGafUq78RqN2vi1c78XoxqXgIoBtYklN5sqaUwrcZxsV5Af9sNDwsCrCzoRfNbOqAPncOWZtKNGNdrlwv6LNTg0Zh7zJ6iCTbckGqbI9iw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DZgYA/iY; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DZgYA/iY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grMkB6VYYz304r
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 13:26:42 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=velXcihrkOeY5SK3YPjHVhJUjl6N6y7zoIMSULnehk1r2V0pWwb0f5rWDDr2gmU4kElV6FIQ97YrOvZEBMg88ESQmJoFjGQWEqkGcW5d0kMFUZVGP61qpd3szqZhDQ8vn4THz8r6XEIOzNWo5pioY22wYaEEgAt90nm9JSKfAmPra1h4Yg+y4ffQEF/KOOLZqK+MccvWCwHx5nFTthhUErOPduYvuHp1paHehqxhLbrskEXjG7uS6pJocP4+nnzVIVM8QoWLn/eqDpOp87G41CBoO6j9cuCn6CdrFP81bgyeeiwVaht7fXUlchEdsk3mwmtYWZxzRoiZ9WRiwoojxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ry3dFK71fybVUZimY1nsp69jg29Ugxd+1zZFlEL6aes=;
 b=YbLc+dBmFWULpL1+VFSqZA8QMna3La07Ho2Q3kp5y4bryH8EhznHrGG4/966ur2lix81/3ltwTJIshlJJ8l2EBMEK8m/pFCw7uwAd1EiEigMaBKbn0u9Cd6YwTOF6TYqwhHf1P7wBF2k/ZmuIA95MyLXc/gTULDFEujlqvqiHlYXbIdaZPEXkoalAHzxBvI/Rage8jI6I5w3YK6tnmzIRn+jXeM7Z7P360WPHVfojzV2kmuz7Z0YOIB0b7d+PSpOTu/GhNKDmW1bHrG/UTVp/v6U8eHTXNMZWFvAMuDGaKyn5ppbNKMyY6zgWFVgh/EIutYpOS3v54fHzD7slRd/Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ry3dFK71fybVUZimY1nsp69jg29Ugxd+1zZFlEL6aes=;
 b=DZgYA/iY8XvatoeECoYf1+TJvahKM4CqeZGFwQhT99Ebdpi4XxatriV7iJGFSsG8JelSj2nvmzA+U0cww8MYQ7AMYXEtZgCPLi/TH9yGvMCqJydlrdTEjS4uSHZNJI73rJRmzxWeHlLplL47Jlphi3nP1qEPgokg3CExYWLoTwWeD8kF2bx15r6YTA9M9jrV9xDthK10ROPQkhZl496LDsgr9vOSKzE4F7g4chpM4/uG//oWk3dzFs0jIoi/3n6+Vkl7TBbrM9B+aSEcG0HNoAwpW4eNIZgFGyKgcas9QFzJToV7YWzmh5dmrDBiKqBEsxrUEXEtQc5i6wULxJc9Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GVXPR04MB10248.eurprd04.prod.outlook.com (2603:10a6:150:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 03:26:19 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 03:26:19 +0000
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
Subject: [PATCH v2 net-next 10/14] net: enetc: refactor SI VLAN promiscuous mode configuration
Date: Thu,  2 Jul 2026 10:57:10 +0800
Message-Id: <20260702025714.456233-11-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702025714.456233-1-wei.fang@oss.nxp.com>
References: <20260702025714.456233-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0083.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::15) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: cd781a42-7fe9-4fdf-5abd-08ded7e9aed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|921020|6133799003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MHDvizVlg1Y1ms41rQCBDeukeiGoRgfLL6E1x7cH77mykNMqvDBZLUeXMiOPBbFTpb/0Wje9yL45kL36W/o55gL02/M3/DYS5ufpHF1aTS1nh8mD91EXES8QBziX0my/A+WaTsc5qSDqnDaJ0iwxl6YN4ccS+M7kundu++rTclTws8Of7NBHXpYHMugJImR3enzP4wS7F1ptonJRcpYGoaCtEjZ3rnkvOuSSBqisqCMWNk5QsegXLq/PCL0bBzDVKy9uPZ6rQz/Z9X/kRCHVWdQvbtO8bTMzJTsUxBqdRJLwR96PQDsMSo/6hdNZ4DaTwQImx4zukrrWW+Dsp8r77l2pRzfm2YaDGKaQotGX0VGDPSBEyFzhx6XRjJqMIwQ/lnVPJcsBfR21ixnkiH/GW3SE7mSAKHrcSmiMt7d47dr8g6OXDwHW2zBaZspwDU1f+yLAW8EtKEBepdQofeeGwu0lMhS2juLnFTabY+MW3Om3OtmFoTTJu0pADE69vMLlnrddTCXB+U97jNnQIAq08Jrzmqgh1XGXXQenV9ThgP2+DP17XJrvHokshKDRXN2OU+4qewnhMm2UKxMN6/GYEaS3OP1s5nivIX5gcRDpL+IZ3Z3rLMLBrmjlFO7vw0IR7GziK2BzN8ShcdzaUv5i39IZsjyKLXqeuO+KkEJw74XWyN0voXZ/kvEEc4Rrz7Zu+ccJwbzAMAOMiUAhqhqdfA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(6133799003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4sT42Jfo6soAaWq8OXRSBA4ICvBny04vIdOFMZLEo6vsLypJFgHcGDXAcntC?=
 =?us-ascii?Q?AyNERhHgxbfBRMz23PDGHbmYSLZifjwbPGVozAnm0GOO13ZTiZo5+iVTNjQU?=
 =?us-ascii?Q?8fEVzkKvck0dY8YFlxUAKIbqk9T6pWccZ8+Gm+RIo1K2lGwzIM0xmEAB2oYY?=
 =?us-ascii?Q?3R+er2pXmBApk8fSapelPGXNsB93upPxotE9CJGGpS+GVSvm3a1aqxjEu7Pk?=
 =?us-ascii?Q?T6qYhBenQgbfJw36kWJysdsVJuvmuzEua24gMy4aBe8ksmolZbdhIVpgqrju?=
 =?us-ascii?Q?0mhVveSIegJn9Uo/kJ42DjQ/sVPB5MjLDUIzup+CvnV6XW4aYuEtO2GmJgiv?=
 =?us-ascii?Q?/3GiDqS9pghH5IwaXtSoMMWq8fEX0jtw51oNxS0MMvvGgTk0RV3DHsN036LU?=
 =?us-ascii?Q?uIUs10FjRaYhQQ392ILl3Qo9vogUNxqc+jOnTOKQDwv1wHLcQePkHDgEjHwR?=
 =?us-ascii?Q?/y1J2XLj13sbTv2eq1FrMN2mfkCGtfDJihgSbdGkPBzRUE8G8V+V4S70Q8wc?=
 =?us-ascii?Q?SV9v73yDu8LZ4A+JKk/72qH5/RC3Bz7AujfeLiBoZUJ4+tMIb0c3l5iyWeZd?=
 =?us-ascii?Q?AiNV7XS+wuSivUDNYMS/PhybnghIaXrcYl0ptT7SYY5qLP6UQ/wG10ZuewBO?=
 =?us-ascii?Q?0+YR9DnWiEuTUBh8jym4vOAi7IDDCOyN4br8AYw3z9qmurPYeZY9Qhgvr5u1?=
 =?us-ascii?Q?nHIakvt95bGUOBWott3WEA2lQbRpCXooYFx3FagvSCJcrzx1c06YM7TFLuTy?=
 =?us-ascii?Q?QuqlVaq766rJ7pJ/o+I2JMJWsBrrzScraGBZiVWY13ujSNEhJaqyqv6XNxkN?=
 =?us-ascii?Q?QbL1AChj4eQoAS47a6enfTe9+2BpnWxwr8D4h8qEpz3QEzsNTbxwR3kK4s6L?=
 =?us-ascii?Q?NHU/ou55zAVzBUxy5un1bIUtlidGoWghxE0/V/3uapAfjtyzovzmB2kVtxLx?=
 =?us-ascii?Q?3D1Mwm9+Am6DAU+DzSCk2GpJKmvnJPFS/b4EZ9sWrnmBo/MZXvV8h9/nFzqQ?=
 =?us-ascii?Q?bZLkVboYnWzs5GHSODdLKZK9lLqeNPxp7gU+nHI2/ZATclTUrMeTzWezi53D?=
 =?us-ascii?Q?mlD3CML3/rV2Q59UBuVgyQ0WGPqMsX+2cpKgN4EgdfAT0uDq0vfCQS/m+E3q?=
 =?us-ascii?Q?GFbdb3UCCt6HRSRw9/ia/vtZdnR08j264QDiZ9A5sm4RgzgaTjFrlirMcmge?=
 =?us-ascii?Q?cZ/oCUOseWo6j1cZJFWzhBR1CkjgGAbgn2ybUpgFSLJgYdC61XLSfH5pvZmg?=
 =?us-ascii?Q?JL9WaEpCW4pOiGLeCOku6yIWXS3v3FSkfWiyxqy/UFNRr8V/+Iri6DlXLGnm?=
 =?us-ascii?Q?vrfjfj9JHOptDWeH7bk47KR3kvGqkdhgTPrW6KpiQP2y04Nm36MAtbNkrvgO?=
 =?us-ascii?Q?Nddwc39kfiiWHV5XPzu+eDZGF0LBOUNOTlpumF8IeCYs6jnFw2GIbEicMWHP?=
 =?us-ascii?Q?93BPzyYw0coHjhpesVr25un0oRlJNNLqF2YL5Y/rGif2jnde3tjC9CQIS8VF?=
 =?us-ascii?Q?dUSGp+nIlrd9FDQwsLq2ez3M48Jq+DlDNKXOb1b9WD79VWCGzIN9rkcFIBBC?=
 =?us-ascii?Q?S5KCc8wCdIkz9YI7e7L7fH0UyLGozAZcXclJvuRIwb4F4ZIFH9OidNwCpnqy?=
 =?us-ascii?Q?j5N6//Cp0iKsH/vQRI/YI3u+9Wpxl0zkd0MP4M3+KSxovyQxavUUxRFCJQWB?=
 =?us-ascii?Q?CsML1s/zJxNm1TFca49OOIPweCbU6rwf8BqFex/Tr5Vamaa0q564UKRQT9J8?=
 =?us-ascii?Q?i2iqjP2qTzevjWPsIhbuJY11rdShUr6fVjJxGPnX6/VWRCaiU+/1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd781a42-7fe9-4fdf-5abd-08ded7e9aed5
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 03:26:19.4895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PxiPR3LoeKvjZvo4KTF+5aE7KhzFqtY9H6LvfdtoUzG3bz2Xh14XGH+QQ6Y9EraSj2TXNR7CZ3XDjRscTI/oWByX2aBQcvjDZdJUs27bNUC8530EytEavXniap4tEqL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10248

From: Wei Fang <wei.fang@nxp.com>

Since a PCI FLR (Function Level Reset) is performed during probe, and
the hardware enables VLAN promiscuous mode for all SIs by default after
reset, there is no need to explicitly set it in enetc_configure_port().
Remove the redundant initialization of vlan_promisc_simap and the call
to enetc_set_vlan_promisc() from enetc_configure_port().

Remove the enetc_set_vlan_promisc(), enetc_enable_si_vlan_promisc() and
enetc_disable_si_vlan_promisc() functions, and introduce a new unified
function enetc_set_si_vlan_promisc() to enable or disable VLAN
promiscuous mode for a specific SI. This simplifies the logic and makes
the interface more straightforward.

As ENETC V4 only changes the address offset of PSIPVMR register compared
to V1 without any functional difference, enetc_set_si_vlan_promisc() can
be moved to enetc_pf_common.c in the future with minor adjustments to be
reused by the ENETC V4 driver

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  5 ++-
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 35 +++++++------------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 -
 3 files changed, 14 insertions(+), 27 deletions(-)

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
index db2a800a7aaf..096ccb35508c 100644
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
@@ -442,10 +438,6 @@ static void enetc_configure_port(struct enetc_pf *pf)
 	/* split up RFS entries */
 	enetc_port_assign_rfs_entries(pf->si);
 
-	/* enforce VLAN promisc mode for all SIs */
-	pf->vlan_promisc_simap = ENETC_VLAN_PROMISC_MAP_ALL;
-	enetc_set_vlan_promisc(hw, pf->vlan_promisc_simap);
-
 	enetc_port_wr(hw, ENETC_PSIPMMR, 0);
 
 	/* enable port */
@@ -466,12 +458,9 @@ static int enetc_pf_set_features(struct net_device *ndev,
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
index 6f15f9ea1664..574ab4e76d8b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -46,7 +46,6 @@ struct enetc_pf {
 	struct work_struct msg_task;
 	char msg_int_name[ENETC_INT_NAME_MAX];
 
-	char vlan_promisc_simap; /* bitmap of SIs in VLAN promisc mode */
 	DECLARE_BITMAP(vlan_ht_filter, ENETC_VLAN_HT_SIZE);
 	DECLARE_BITMAP(active_vlans, VLAN_N_VID);
 
-- 
2.34.1



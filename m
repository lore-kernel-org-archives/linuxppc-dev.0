Return-Path: <linuxppc-dev+bounces-23169-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAFFC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 07:49:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqFfd1nzcz300B;
	Tue, 30 Jun 2026 17:49:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782805785;
	cv=pass; b=FugqQ/um3XjyZ+ETOYsNI/BOS0tz1GJzMz4C5P0GLGniRb1EmJFPZx6bvVIKRHwGYeeM1Je8V3Fd+BwQGlSuFihSjnz1rF3KE3kt3PDiUfZSizVHnAwqdZb/g7q5uZHVeysC5mNErj3ZyPy/COBP0sOw/JuotWf/wvDjEgR6aUEBCDmGGHHshWdB0JLSPs9AmRhKYuL4fzF09rNHDUGKZ5XA6s2PF+hbi6kVl1q3PHIBG9XGoDoB3KxaQDEUD+67gNySuHnnl7juyTPNSUequOvkbD1R/Sn526EcIxNwlF+nYwX1mQw/8NGBNIrIYjqyAhdf3bRFqaXC/f5h/ZBbsQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782805785; c=relaxed/relaxed;
	bh=la4Jl+DQWoNfBe5MsS38IJXSCWVf24NUmxmEqIAo+Jc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E+RB4YXvhRMKdd/MxxFfv+jdR7jSt8Ajz5+fwFIQ43dM+36SpoAKa8+/LKRmjK3JV3//Bb2/8oKHRRKhIDmxw7b1JUr/tJMtdqcaxy5z1bGmJDqIKSApy9Fxfc3LUuFQQtgkisw/iXljTO8kfzh+Y1gCtZyh7fC2JtsQZvr99S2DOT+4SC0DF6cQq8TRCr5cyHlqgDrF44/XIbAw0ia9fcSKkgBNTwhGEy1tje61ts1VRwR7WjVyHFOFGtt+cTklsWJSNuYyZPWbfTrS5YUwzhDFqMdo6Nq1nJxgM3l+l61iP+dYSMVNrJa3W2VBbKG4zPw/MyUHfa1vyyXOzxn61A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=lNpEwLjc; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=lNpEwLjc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqFfc2pcCz2yx7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 17:49:44 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXMu5T5tXdme1i9rDQyjpT2iU/hmJEHa8XQO3ywaxCWNPZ0FMU23ziPDOKErdI94Qy/AXcNLJZ2StEYTiuGHj3qZAuq5WpYVrDgZhpy9q0RGDn5wCL0WZBFRGMnk8xBD5flhS8OPufaCaV4nwNwRc0JEp5C0X731mGz1C9Eh02NIb3NNPwIgN6ikTGoT2Icy+e7FQTujV1UEzcmZ5gerezTvc2goWbjgQ8O9mnnPFAbqp1PrOGxwPbHT4YAYSZ8yT+GGYZXQ/xjoLwWqBFJObO0L60mIrSofuPwzl5RnX2KeP3hWe9ER0kp7GwEMEtS/ckzi7YqRk286EwP5EqvE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=la4Jl+DQWoNfBe5MsS38IJXSCWVf24NUmxmEqIAo+Jc=;
 b=ODmSA3R8iFJi7rgfJCqEszMkjVE6jl6BBX5moxLW9npxgvufA4Cpp61b7n3P4tzXAbbdkBlEoVsFIGSleTiunPXrOHkYhh+tQUiK6XkGRp4zi5NYjR5g+3vWxmfTpwRNn/12HKUlRx7Ri3fGSAuekO90o8HliOU/brgVF2TqXVcodTez6wmkcg03lx44iM2g17ibXYmD4qKsu6wR/2w6rWXTsvN/HAV+GBYCehHG8PQLoVJlAf8dNTKsiVDXYS9WdYXm/b0vrUzvv3z6Nkhi7lig4ps7sbWHGAgDn1D9s6QevZIjHcOkBc31RCLZb3TL3ZaGTlNHec7uA3rP3edcnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=la4Jl+DQWoNfBe5MsS38IJXSCWVf24NUmxmEqIAo+Jc=;
 b=lNpEwLjcoHQSkvaOmHpyO2DsQWZq8qlqr7Fi/9qKtMP8IwwEkscMUiWfRE3I1Jni4Vchasm7KN/yhvVQpzd4SyiBBbn/yRpAfV5Pl78V9O4/ZgeNFlHKAs/fsXCaMU5ZlAezOSB+t0db/K0AaltCoL6ALl7RO2Ec9tVc/mhaSOAmbrNx/jMNylLKEd7/oI2blTdGwAJgsYGd13YtME6TpfpeNFvvPmmvoPiRPe2lGvNG4tJxdENt/P6zbl3VsGx/eTlt/AdaHYEUxntf0z4AOnGjHI6p93scoa4We/jNLWaaojIKg71YmFzW93YeZkU23LiuCPQKOCwzMOl4F6ardQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU0PR04MB9561.eurprd04.prod.outlook.com (2603:10a6:10:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:49:23 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 07:49:23 +0000
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
Subject: [PATCH net-next 08/14] net: enetc: remove invalid code from enetc4_pl_mac_link_up()
Date: Tue, 30 Jun 2026 15:20:30 +0800
Message-Id: <20260630072036.382761-9-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630072036.382761-1-wei.fang@oss.nxp.com>
References: <20260630072036.382761-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096::22) To
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU0PR04MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bbdc720-a960-4824-da54-08ded67c19ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|23010399003|19092799006|1800799024|22082099003|18002099003|11063799006|56012099006|921020|3023799007;
X-Microsoft-Antispam-Message-Info:
	z41jv8VcD9gmYGB7j5pVtTGQOmFlr4IXJBFhY7UE7W0wen8+IOTLHvls/R/t+Ay3MfZGekqQhrBzLoJdnUzQUOv+V73jJM9Jh266WnO4USqCPEAbdyUxjHZ0h9ExDygrsTMC8gs8V0Mm8DqvheyaN7A8yr488BcaU37INK13UG/5/JqdWQBNP9DbG9Q/5BCc9RkgFPUGmBHLw7k8b2dAJ2DIWmOd9uKP/WW24rRUcJbtQyYzwo2pWaXmOKs5zXL0jvu2sCR+lvBaTmMKBMI1A1DW2/Cf9SazGdGprP56UlQ5kOuD3VxDZ+E1mEuKp0JHdLfEe/0uPc5Kit38HCG28mb5+uuhXgo4NXiLx14WVYZAAx/80zsUDu26J4Fy7eRrEmovTSQV+YX4TuKquLmXByNAZETrb1qQ/8Lq+RoF7taPTXq5NNHlqa8EF4LPFQf0GEj14h5s1jaYft9c7j44ASb/iWOnn+CuR/pP0/1nWdlIZ0Wyc5oEEsJZR4TBNE9lKyt/xTCCIqu+ZnhUD1rs7GKiYmf41A1hszhdfvltqI+iN0SROaO2fzaKuwWGypAPkb0MFQtgETz/wirz5i2Ri3/xEPG+qrTG7lAaJw8BVjRVjkJVmCrvwH+Co0TWzVvM++1GtAl8mn5zurzpIN/Jf+RdVmOvDmC+QPFgs3kVhWEut+yKaB8Zb4wrrMZOFkP1bCRVNQZcD1+YVGtzb8/0YQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(19092799006)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(921020)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LRKn8YIKQOs9W17yRJWO4kPZpSzdEZnh1VSlyXqZwosRRwxOeJEkw1SCm9K6?=
 =?us-ascii?Q?Clx6iDfZdIitD+I5px3dxeqJeKN0TfkhvjddBS8dcPsaZhw1p2ED7XLXxVl6?=
 =?us-ascii?Q?kDIxSDZ26dY7nLsE6p3FlH6Nwm8Xhfihkp16bdcF+aV+EKW5ii4g/55P+scv?=
 =?us-ascii?Q?7Fi3YiObK4wmH4tj2vsvNSK33B07sjYN1PGeitNBu56KYQyNQ7URQTgghxXX?=
 =?us-ascii?Q?UZUBeFxSe4/s01Ry0Yu0LY2jl5P9bA5LiZl7Np8YXBdq6VIEzrwoqOdUrUcU?=
 =?us-ascii?Q?KkUZeIviIP4OpodASmY03Sm1/78VZwiGadvV9KKC4BEokV2lLyuAsokRlqJo?=
 =?us-ascii?Q?zZJfgP6hAw/U0bE/bd8BEY6xs7xvPOH8HkTJUye5u1lx3749mupolSfpUXcR?=
 =?us-ascii?Q?YCbyhBhIqwScFnXAJHCAsHIRi/0GPGq10tMoL0ZubNFjhra57zbyn/eQjsFG?=
 =?us-ascii?Q?7PpVHTHQ/g6dVjQ0hgoHB7svAWYQ5dtXG//1xltwWId/xneA8uJ2cO5Z3h0C?=
 =?us-ascii?Q?YWE/YuciROjm1tRCBCQ8jfZXNV7MY5s9etbSbbNr1bI+fx3X/tNQ8W3F0xMW?=
 =?us-ascii?Q?6+rRNnUscLYya3tKSWB7z9AXWKviZc8dnMWMuJNqciYLzV1zcHsdJMd7EKjg?=
 =?us-ascii?Q?AO4KdG026ku42OYt29LmiUly5eV4Y4otO871Qt93W4dQ9Cyh3g/FZl0HgOfp?=
 =?us-ascii?Q?YU6qvsHw8o3KD0IzK2KXeu+HLt1qZcP0+VS4r2yK3qWky2LnDKR5fJzdFad/?=
 =?us-ascii?Q?rfuEzz78VP8TmJJEZR6J9eAf6SuVAmkWLuFhGvm6KstfsgsTsTNVWWcrXO+0?=
 =?us-ascii?Q?JRDhQR0yLDc3QGmnlhu9eRuDr7xdvT5gEHpn9S9JKACbQBtGSPpspndyDhPN?=
 =?us-ascii?Q?Pieq0zNMgxv7J6XATGQZNEg6L9MuZfEZg3Lh4leHIYcR5I1D/ZwVgwQdgezJ?=
 =?us-ascii?Q?2aVBOpFT6+cT1hdoWbHJuVL15U96GqXxDJ/DIi5nk9iB94N/zyOF8lJfkMQ+?=
 =?us-ascii?Q?Y/E3UTIaj12wbg/dprRiQ8kbUIJ52WirKmld3egf1YCZrk0k5tHZshEs1KrQ?=
 =?us-ascii?Q?07HOU1j9GIcHs9aQHZDR7y8LSZWE9w1xQADVJKJ5NruqRXo+pwIF2Wi4jQTN?=
 =?us-ascii?Q?wt9qMU/CSAZs/9usesVHxeMdr6MHM/Hjhq1SnFM7qRSJqqfYNP2UAohSAkOH?=
 =?us-ascii?Q?WB08Fryryo8YkJXbdfn/CwDlV2i6IyPQ65WgMZA826ad86I2dZagu9+zEboI?=
 =?us-ascii?Q?sQrdQrT8Zqx6sof0SHHt1g/4QAdcXG9XsRgwrAAv20X8OLPDNiSXVE0k7/ey?=
 =?us-ascii?Q?TwFFnajwII2iIcPQH4L13BHaj5v8eKE4Dmgiu23BDxTjHm3h5XXuhRTwmFAl?=
 =?us-ascii?Q?9f5z8FudCwxbK4ZvFgtssk83YEOHkjxNLjwehm10+0x8fvDjzq+xru7e1rmM?=
 =?us-ascii?Q?4VOUvHQE/+0HRJruP6lmTPKbgULNu5Oec0GQ6NYE5rJ8CTYDpAa8tYDJMyNh?=
 =?us-ascii?Q?FJjpN+2qgOD1QhtAYEcJ/kcLtYVbkwLKCVeecM6zsPEb+9+rg4V685CjNLA3?=
 =?us-ascii?Q?4NCTfXemLp2YiX13+7CawuKc6TXsH3KH9X+caKr+jWBaS/4RaXTgRo6BVHZa?=
 =?us-ascii?Q?AOiLJYg3JOSKk4t10Myiy3CCxfEobc7uPnmHNDBymd+aYUTeUj8MrT5XyR0E?=
 =?us-ascii?Q?pmlW7+6+aCBgEanREo8iSGCCBb9znz8WE3akOxppfreAntzdRqOa2dt3lMQ/?=
 =?us-ascii?Q?wGl8/Aawdpv8NigTXlD51w+u2qjfdC/eOf9xz+SRDCp5z4BYT+Jt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbdc720-a960-4824-da54-08ded67c19ea
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:49:23.3618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14wkONB6Uk2ur9nlWNlpx7zA2YkHAJYHnJ+vY1ESms6Rnn3jdTo9Vx+wW8RAz8qVWdsWgJ8Hf1BESjOG+wzVukyEFyzjZY9hsBSnr7HEagITRO+Hm5PLOs2RQ3pdtynO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9561

From: Wei Fang <wei.fang@nxp.com>

When adding phylink MAC operations support to the NETC switch driver,
Russell King pointed out several pieces of invalid logic in the
.mac_link_up() implementation (see [1] and [2]):

1) Half-duplex backpressure is not supported by the kernel, Ethernet
   relies on packet dropping for congestion management.

2) phylink_autoneg_inband() is unnecessary, as RGMII in-band status is
   not supported.

3) TX and RX pause are disabled in half-duplex mode, so there is no
   need to override them in .mac_link_up().

The same invalid logic is also present in enetc4_pl_mac_link_up(), so
remove the invalid code from it.

Link: https://lore.kernel.org/imx/acEIQqI-_oyCym8O@shell.armlinux.org.uk/ # 1
Link: https://lore.kernel.org/imx/acEFwqmAvWls_9Ef@shell.armlinux.org.uk/ # 2
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  1 -
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 35 +------------------
 2 files changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index dea1fd0b8175..7a3ccc94b036 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -198,7 +198,6 @@
 #define  PM_CMD_CFG_CNT_FRM_EN		BIT(13)
 #define  PM_CMD_CFG_TXP			BIT(15)
 #define  PM_CMD_CFG_SEND_IDLE		BIT(16)
-#define  PM_CMD_CFG_HD_FCEN		BIT(18)
 #define  PM_CMD_CFG_SFD			BIT(21)
 #define  PM_CMD_CFG_TX_FLUSH		BIT(22)
 #define  PM_CMD_CFG_TX_LOWP_EN		BIT(23)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index b21ff362c31e..67aaf188d325 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -588,11 +588,6 @@ static void enetc4_mac_config(struct enetc_pf *pf, unsigned int mode,
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		val |= IFMODE_RGMII;
-		/* We need to enable auto-negotiation for the MAC
-		 * if its RGMII interface support In-Band status.
-		 */
-		if (phylink_autoneg_inband(mode))
-			val |= PM_IF_MODE_ENA;
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		val |= IFMODE_RMII;
@@ -690,22 +685,6 @@ static void enetc4_set_rmii_mac(struct enetc_pf *pf, int speed, int duplex)
 	enetc_port_mac_wr(si, ENETC4_PM_IF_MODE(0), val);
 }
 
-static void enetc4_set_hd_flow_control(struct enetc_pf *pf, bool enable)
-{
-	struct enetc_si *si = pf->si;
-	u32 old_val, val;
-
-	if (!pf->caps.half_duplex)
-		return;
-
-	old_val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
-	val = u32_replace_bits(old_val, enable ? 1 : 0, PM_CMD_CFG_HD_FCEN);
-	if (val == old_val)
-		return;
-
-	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
-}
-
 static void enetc4_set_rx_pause(struct enetc_pf *pf, bool rx_pause)
 {
 	struct enetc_si *si = pf->si;
@@ -881,13 +860,11 @@ static void enetc4_pl_mac_link_up(struct phylink_config *config,
 	struct enetc_pf *pf = phylink_to_enetc_pf(config);
 	struct enetc_si *si = pf->si;
 	struct enetc_ndev_priv *priv;
-	bool hd_fc = false;
 
 	priv = netdev_priv(si->ndev);
 	enetc4_set_port_speed(priv, speed);
 
-	if (!phylink_autoneg_inband(mode) &&
-	    phy_interface_mode_is_rgmii(interface))
+	if (phy_interface_mode_is_rgmii(interface))
 		enetc4_set_rgmii_mac(pf, speed, duplex);
 
 	if (interface == PHY_INTERFACE_MODE_RMII)
@@ -899,18 +876,8 @@ static void enetc4_pl_mac_link_up(struct phylink_config *config,
 		 */
 		if (priv->active_offloads & ENETC_F_QBU)
 			tx_pause = false;
-	} else { /* DUPLEX_HALF */
-		if (tx_pause || rx_pause)
-			hd_fc = true;
-
-		/* As per 802.3 annex 31B, PAUSE frames are only supported
-		 * when the link is configured for full duplex operation.
-		 */
-		tx_pause = false;
-		rx_pause = false;
 	}
 
-	enetc4_set_hd_flow_control(pf, hd_fc);
 	enetc4_set_tx_pause(pf, priv->num_rx_rings, tx_pause);
 	enetc4_set_rx_pause(pf, rx_pause);
 	enetc4_mac_tx_enable(pf);
-- 
2.34.1



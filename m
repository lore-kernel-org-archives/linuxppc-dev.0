Return-Path: <linuxppc-dev+bounces-23486-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B71C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 10:42:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gs9Lx5tzvz2yrX;
	Fri, 03 Jul 2026 20:42:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783075369;
	cv=pass; b=NVKg2DYjKMkG4YdRCd7znCMnooJYOqHKI3BFgGmweOEn0qF18oBTd5TOda3elN0MCBCKCgGsgUGedJRqDaz2d0ngQQ7QsoHtFVy5FCiJEz8TuRLrYY/2oddVmlgSbfweCCnjaLrb+gSvBBJDHmd8fftW6l9fE8Aspn7+6FsjfXOwMwxTF9cqbmY9mjR/de52CnYto/Sbk+Wbva+Sb4A6msvTYsWvOkLy8wnqZ3lOlun88dBQIBQxXv7z6/CMK8YZZntMNfguTNj76O58wmz/0D5HVg4SCYIpRILn6c8+rY0e6BOMKv6wlczC3GFNhKrKf62X6jei7YFa8KRs+Kqo6Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783075369; c=relaxed/relaxed;
	bh=Zpnnp1ejX5Oa/Yy6yvmaD7X3n2NEc28KsJx7aRM5cgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PinElTG6JZ8BAbtSApHazucKvNw4pSy0T6ReHnUJOZILadIzCiQU0+WptMZu0qVaGYUHcqohecb4VpVoqbM9vBIFIFMxdpbv/eW7gq/vwxbClkKvIxBwH95A6gdynpQVAmCcnRz35l1+GZSAwr0e8WuyCCz8XLUHaMxhU+98lcgS8Ay/1oli7uQVoRz0MzfeB5cDsbK+WkVXtJtQ4pzHkz9DswqnmM5Sjg9+9A7Pqv9YQs6y5o1rGSkfhtLk99bfd9lV0KtEyd+lIMsSYkH4G6pC6js0ERsse2hheNqDdp2B/HZy6c9HBBYBSlqcvCGaIANiVbl0wHauAKw8uEVFng==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=tRZFzyMa; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=tRZFzyMa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gs9Lx0t5kz2yr2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 20:42:49 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8y7tmQ4Tqn2rrzIPfVBNhmbVaaLyi2DCEJxYHHSiFY2BJRIJpOmo09fXwZPK4AKjsiYgFxBorzAvlj2NW5aA7oObuoJU8BzRaETSPTVUA+HXm9F4SKjULpu6QG+HOa0/S3DMLJA0agFt+l6f3v08a0am9iiqLZ4S1Csd8p5fx17Jq3qKiNSqMBh2SLP0J/MV6ZDPXjEMg0ixcTdrHtWd21GA+09fZv+hLQANFhC+xEIr7ZLYxh+smrU8H/1X7su1rCav2dIfBRep72rLXDpkm6GNZ1qbC1Tvn8WXRyiN/DJPxrA4ZAU0eeC73OM1Jecqz4rR2g1Ai0rbEjJczmEGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zpnnp1ejX5Oa/Yy6yvmaD7X3n2NEc28KsJx7aRM5cgQ=;
 b=ll/eUVrXcBsnDPXREbTac3yU+svcOTSKa4BP6AFiuM62MiUk70Zd954RNExepV2MvqT6mS6P6FISVUvlb5RcGtkNBDEXL6UToxXkGZST6LA4FfjZF+z75tAFoZkmxw5EeDLyGQGxNIiUCtvgEIr0uCw+xTnp66PFoDLJyghurob/2pAAOG08wMv1EzNvKYCNfYv0Xf//5gEE1pOl3ZQ2JqOJXtBqfyOE9F+CF2VZiWfoA/u59tDvh3H31wyWk21DBjH54l1WMmWXD5w+9xBGC9DzFqr5LmksBFHt6bBDBv+HJeOaXGyb00RwexoJ8wvyyCSEpP/1ZDshn2isDiP6bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zpnnp1ejX5Oa/Yy6yvmaD7X3n2NEc28KsJx7aRM5cgQ=;
 b=tRZFzyMaVOMF+YS2eeC1F0q3bFChi/PzsR0ZKb49kuxbfcpO/u3kI7l64f7WUUQdIrDcj/GBUBOKXgz2XVyymiVm9+HcI5MVEKM8lVC9a7tjc0C9qrz5KtV7+wwAmDOQP7kcYItr4WkRGMI7rLLp+kOIMzDT/PvBkuidDxeLoTJ341cWVr9z5D5ER/3IEL6perUx3bdVbIoVN/opz0x1AQA7COnpaonEY/zY0gZiDo95xRkFc5zdMjVab8OAYVbEagHOlrFDQPsOxJrOS0kjUpvu0YyUXpQmvIiiYQW28uAjnkgw6M+zbsOr+zeBkXNgoKt5HVZh/DLuogBeMrYi8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU4PR04MB10741.eurprd04.prod.outlook.com (2603:10a6:10:581::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 10:42:30 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:42:30 +0000
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
Subject: [PATCH v3 net-next 06/14] net: enetc: simplify enetc4_set_port_speed()
Date: Fri,  3 Jul 2026 18:13:20 +0800
Message-Id: <20260703101328.550714-7-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703101328.550714-1-wei.fang@oss.nxp.com>
References: <20260703101328.550714-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::16) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU4PR04MB10741:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cde019a-a07b-4337-d8a2-08ded8efc813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|23010399003|366016|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	cH6c33kuDrFguI8CwmbhfPSxeuQlNjG2ni+bzeV9UFjWR6KahS91FW1q9drUlWF07ESSV43eBy1qULMbVtiTTj+z81Io9Qt8fERvfFnx9hHAuKWUPDbXt4eseAEEkNmZ4Of1Cu/t+yIKGcP5fcnkpSeuoFthNezd8d8687ETcyv3m0s4/V108K2scewbmgp+rXASUctdktBZ71mkHOUdQ0F1adUrOIDypufAZNoiIrtRvLdN1mDRLdliNF42VlbgM1T+xWZjOOrpmtrzj7etY/xTTEwEe7VfwwF3ZMG1OVug8K55O+8bNefK8yLoJ579oPjY83XvK41advL7CDzL/Ov5fwXuBN8QnYjRcQrO7FGVvCVXZE6Y8oWfp51HbLDtk/uNvjRH0NO73suIQRRvz7hlk3MBfospXh0zHQ5SdcmYvG1xNqED4ssXM2Mof7P7RqkPJmqUjccoj/qNvcR2/Sr70ZxubzwFva0nOUW16iLxDgiVVT29+nKZxLP4ueXC23gQJOUu1HA7oz7zCaLgp4WAmnR21rrYtyMLqAyW/SYIBuzwG38KKD2gU9NrKzokls+Ud5yHdpNrMLWgbQA5uesrhgsXkBPIoJH13ajbj3L1Yx5Log8EkMCyczJTvaLf7Cfc/hvcC2kvqVyjrF1rF77NO7LlWZvytsnUOTYPMKhGlU/XwQIGfVEUnd3K4sKjy9RcPYqovfN9pY1DxW7CRQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(23010399003)(366016)(921020)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lnLlZrT+omQHL6F/hv66HEATxPXz5jxsHsqWfy1VLeGULc9X0xbi8QRx1FDu?=
 =?us-ascii?Q?b7SswmcHKtydqdNbEGRcn2XjTqABiQZju62PSb4+sxepJyGa23ar54jsMedp?=
 =?us-ascii?Q?d4T86sKdQSSCq6LK9C8bTwnzO55L3xC8xRl9X1tHrXwwFM9gCOc5HeVK/7GQ?=
 =?us-ascii?Q?R/CH1AX5xedP0gInLc2H1KKv4Ehwjldacoatj2EFGsL0oOPFp0qlXGaXGzLZ?=
 =?us-ascii?Q?Z0yzkMMg46zvGJdF2fl3AesxOJEPiZvqRmiM2KVKuY/5m1Benl860kZ/Vi5l?=
 =?us-ascii?Q?V8QENF6sLNOfkd/dov1QO8e1Yvl3vNZxDeiY22Chz7Mn+6TKp2gXpE/rocWj?=
 =?us-ascii?Q?RKEDn2emSVHC7NRKgc1D5ObLZAo0s0tOiK8Q3E9r8lCJbA00I895XKaCmeG4?=
 =?us-ascii?Q?a79iWDLeNIoqtK5sykiB5FHsnRPUgXqhypxaRJy1XCgOug10SYq97jD5c/Zj?=
 =?us-ascii?Q?XkmfFVPk+Ag1/mM40WL7em+S70dm1uDAHRYskj22McyiVSbW3OXzgyZShY/T?=
 =?us-ascii?Q?uDUgjfxcxqsLtqKBgCVzoajT/0Em+cIJgDOwf2pn3dbWkt5bll2HLWtBOI4D?=
 =?us-ascii?Q?qWOzPwS+qfMMuAujNtebaSs3tbSaKSqoKypF3WQM0anu0dMuJMiT2TYPj7xw?=
 =?us-ascii?Q?yQtuUi4KB2eT9LOercjZHgwqr/80HEHDi6EYH44z4VYlpD7tpthY5WHvszSj?=
 =?us-ascii?Q?Fb4930gEpENgIvt20n43d41KhCpiIKYoxiW5uANrNNJSSrM796lYVjkPmTXF?=
 =?us-ascii?Q?pMqngskb05gCTQ+JK80gY+cVJbtjpLdKeV8bE+PearpCTpJF72GUO+Izok0l?=
 =?us-ascii?Q?6VIOMPH8hYxFAGMGdptBjO4sZX4dKj9O4h3cOTU3CqqUjQNPogNIiPIAA6qy?=
 =?us-ascii?Q?YY7Go0Cxtp0aqFDkERmW7hj/GQ0LUrTr1kw51wZq980Yd/AM5WEcgTOr+FvZ?=
 =?us-ascii?Q?xXdTlLI/AjBye7FqoNPkMN43hZSXK6OAah83F90uQLF3/ab7hs5ndxAqbJs5?=
 =?us-ascii?Q?erY5dpp7P84m1QJfzx2kRkEX0g0S4ZfJM3IU9j+pn4ShEDksAh02E8Jwp26d?=
 =?us-ascii?Q?ywZba4E6NvxuzgKToH47RdvADcm1z/LyFRaXmUKXWZiI6rVVNw0WFw+/CCOL?=
 =?us-ascii?Q?m3Y2IbeVJR1ZL3WW3R8psDr4mbqKnTYfv0B2O0lVMPzT9lvG/FAvIVyxXkwm?=
 =?us-ascii?Q?PzLV0crPlWJ2cGrLtDD/79/BPa2FpcTETN0pUvtqFBhYCQeLD/hnQdtAqXDP?=
 =?us-ascii?Q?yL0j+e6rGk7K26eKTf2YTgzJ7uQJbtFw4asa2NLjaLlbAkiNySf5qs5OoK2y?=
 =?us-ascii?Q?fhyFRhLGbOL5mJwSemLx5V6ZKYM2tmK51v9QY8StOi9uhXQpSX8+WpQamobA?=
 =?us-ascii?Q?rbPp7+r/kadhZjvPCWmoxuZkObQYoV5BJRcBzcCf74xrXpP5hCdDCpij28Bc?=
 =?us-ascii?Q?MeWQXU9MGj3rLL3KV0C1mkGIll/Jx5DSyuefxvdrk+unwvWkNwsJeYaQrkye?=
 =?us-ascii?Q?T4t2Qp2t/kKviTX6kJYmpE5LEfhV9XDd9I5ct1NendpMDrK4T5brPWMVxBZH?=
 =?us-ascii?Q?RVUPVa248bId4HS3Fqo3OHuhlHqtr4z+vein/MitKAudR/AmmSeYI2loEdfr?=
 =?us-ascii?Q?V6VR43u+G3Si2etJIpDMqkcfaEd4QUD/4g3lQlH+yRu/idI1VCFq4YHxgeUe?=
 =?us-ascii?Q?PtEnTExuunaWGdBLXN732sB8eVEBLBYhvSd/Dw3CnXsOaGO1MN3J403yIfwk?=
 =?us-ascii?Q?FvKeHGsiExsyws1FAbgxAEOVaLR1BC6Zcw0K+40P6CbsjXrSeNZj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cde019a-a07b-4337-d8a2-08ded8efc813
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:42:29.9780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSdT1SX7K4A/1O0NmuycQW3iPMP+T5MhnthLwUmm5gCXE0go1XFdXO2qhyOMQbqiqKB39FKNL/lRi0Eappwb4ZqmUSP6+oxPHvtI/pUhSrnpbSeHHn5vWLll5TIehpbl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10741

From: Wei Fang <wei.fang@nxp.com>

Since phylink may pass SPEED_UNKNOWN to mac_link_up, handle it
explicitly by defaulting to SPEED_10, then replace the switch statement
with a direct call to PCR_PSPEED_VAL(). Also update PCR_PSPEED_VAL() to
use FIELD_PREP() for proper field masking instead of an open-coded shift.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  2 +-
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 25 +++++++------------
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 6a8f2ed56017..dea1fd0b8175 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -148,7 +148,7 @@
 #define  PCR_L2DOSE			BIT(4)
 #define  PCR_TIMER_CS			BIT(8)
 #define  PCR_PSPEED			GENMASK(29, 16)
-#define  PCR_PSPEED_VAL(speed)		(((speed) / 10 - 1) << 16)
+#define  PCR_PSPEED_VAL(s)		FIELD_PREP(PCR_PSPEED, ((s) / 10 - 1))
 
 /* Port MAC address register 0/1 */
 #define ENETC4_PMAR0			0x4020
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index b966637572a7..f24269a48c26 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -628,26 +628,19 @@ static void enetc4_set_port_speed(struct enetc_ndev_priv *priv, int speed)
 	u32 old_speed = priv->speed;
 	u32 val;
 
+	/* If the speed is unknown, use the minimum value */
+	if (speed == SPEED_UNKNOWN) {
+		speed = SPEED_10;
+		dev_warn(priv->dev, "Speed unknown, default is 10Mbps\n");
+	}
+
 	if (speed == old_speed)
 		return;
 
-	val = enetc_port_rd(&priv->si->hw, ENETC4_PCR);
-	val &= ~PCR_PSPEED;
-
-	switch (speed) {
-	case SPEED_100:
-	case SPEED_1000:
-	case SPEED_2500:
-	case SPEED_10000:
-		val |= (PCR_PSPEED & PCR_PSPEED_VAL(speed));
-		break;
-	case SPEED_10:
-	default:
-		val |= (PCR_PSPEED & PCR_PSPEED_VAL(SPEED_10));
-	}
-
-	priv->speed = speed;
+	val = enetc_port_rd(&priv->si->hw, ENETC4_PCR) & (~PCR_PSPEED);
+	val |= PCR_PSPEED_VAL(speed);
 	enetc_port_wr(&priv->si->hw, ENETC4_PCR, val);
+	priv->speed = speed;
 }
 
 static void enetc4_set_rgmii_mac(struct enetc_pf *pf, int speed, int duplex)
-- 
2.34.1



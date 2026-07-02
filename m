Return-Path: <linuxppc-dev+bounces-23348-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FE6C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 03:26:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grMjg2qkdz2yv0;
	Thu, 02 Jul 2026 13:26:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782962775;
	cv=pass; b=iJqc31V8EWupBGBXIFD6eJl8+YafOuqBMkyZMTtfN49hPve081oc0Orp4QmmQKXre4CcKxeKsL+axnEH/UpyH9weg82mXrLiK155H0zimCcmyXY4ydMlrxtEr4g27M//JR2Wjgv38agYAziv+Hk2AdfkcMLKM2liPp+bSKoDsEWKq5+0sn3lAOtzFSt0eTjMSTT7j+DcXWSQl8Eiwh8cybx3zha1FCN0iuQUcV9XUR8Rx0uvSufGrWPFrtbSkrjplNRT73r+03eO/vlfeY043PgZELh/5nNVa7D5X1Y7/6mWmQlMwVyRnyNQ0tynCX4s8phc3k0T0IsNdM6miKW4Lg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782962775; c=relaxed/relaxed;
	bh=BBckIUPkLfR8cnEtlwmNwqsqpeI4bzf7/E9bl30V9K8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Le6REOWto+H61sz2NukLjmy2jvngikve/HQQUzT9P4W7XCSQ+TEyP+bjuOZvpQEax1AoBcWdhKZkqjWygrmKCNHl1bUfc9+xAv+rIkeHA8DPd1jIIQTWgYdWCuRoa+NNXIlW/FbY2eVyCxxgH4nue3/EhJrH+IoZ9vpZhTxbdRrlV1yjqFRnQG28MlfQSphfWOXLDBpQilkBCAFho9VCXq/EZyapfQbx2BaiL48S1PVFC7u/Vdt0CPUVzbjS2CSNue/XN+HKX8horu8s5eb8B+3xNvtbbhArALTYhKQZPjwi1tmY/Y2XkS9HGEoT5qCzeJxtzps457e2AfaJrPVQ2Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DoWQb/CY; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DoWQb/CY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grMjf4Zv9z2yr1
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 13:26:14 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8S+H620CYJjTN8zJiFQa6Cx4unZgV9WMM6/Zm3KJkP95mP9sVUD/LG/jCDkUuWqojXVv78g0ThoQOpc0911+aVggaglAYTRL7kVTS57bd6fw2X20TmcOntbMQ5wzKnwG1JhtLTSuiVZCHeqVG2iya/8oM6k3dB0Sxh/6p/RVxpUHIK0zfUji7PFafbkqBUEArELurdYbhR3Jy5elPSVuBJjF2UhMgIGEbzXi4lDseoqQqzKhKtnBXX+WGvNuAoSUVeU1JRq+iK1ZKhvCYn3VJwt8EbQuVODw7T86G2waCRpZaLCucA1oNoFI8R0UlZChe0RAnP3+BsMPxCMReaoxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBckIUPkLfR8cnEtlwmNwqsqpeI4bzf7/E9bl30V9K8=;
 b=TbJ6VwFHjd+XB2EvpfQOm5rKDZWHQxCXCM/3UV2UkXTs9QOPcN/F4iGfnZUlgqoDSL4J1igH9w7+psYQmokPh/6RM2Onvm2C6NoIYR1OHIPwR8tBzDCyaCkCeCLoQ+hhhDH9ztQhMlBb+gq2EPPQi3dHlGiylFriF5hyKyCBODJQmbDyv11x8y9Yo6NJy+KjspJaHuXaQ76k6ijE9jJlxZIchsRDuGTlu+iWTQWxQeBrIzElMtStBQ9jTf+SfkC8eKMd4iOaBNjJxBbfSdr4VRFozGik4/sUII2IMcJyPFRxE73u7o3VlSzrit+PZ0tfhKhISSqL8ur/y6QpeVGuzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBckIUPkLfR8cnEtlwmNwqsqpeI4bzf7/E9bl30V9K8=;
 b=DoWQb/CYk0r8AxVIYzXCgvLLPW2XnXbeQ8TZI5ZPpG/tATDNWaOCmpWm0t+KoFy0LYqQIrCdRye3QlJVkh0HJWC/kNorwEGzEeMfx8UFFByiLWz+H0ZPpCvOmpVOjtbqYNwseH8ik+/9WxGBgo4n+ASrtY4SP3t0/ff3pYh3AWRUZCQFt39x7JuKBipIj3+2P07a3I4Wdfjpn2C97RkFht9Wyo2sP2ftAmVsd37bEKXf+4PjWq8Rvht/XTFs+T7Fvge5s5lEIGNMDBOXFFpd+whpGmCap5Er6jBKtpHaqF+Z1g14IVPG9xSK4z9NVBQUfn8vntjUW6MMLxfPa48Y9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GVXPR04MB10248.eurprd04.prod.outlook.com (2603:10a6:150:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 03:25:50 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 03:25:50 +0000
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
Subject: [PATCH v2 net-next 06/14] net: enetc: simplify enetc4_set_port_speed()
Date: Thu,  2 Jul 2026 10:57:06 +0800
Message-Id: <20260702025714.456233-7-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702025714.456233-1-wei.fang@oss.nxp.com>
References: <20260702025714.456233-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0032.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::10) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 4e058c31-05a6-4173-3593-08ded7e99db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|921020|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Fpq82XZbZCcdx2RQyhCV8phw78taGn5Mrbd3sH67OFedoGd3rJIkNtJr6zI39ydmAuGGbcfRdp87qHatOVQ0R9xtpDMqOLv3Mp0dc4hK6G2flXAoEQ50/IsK0qKFQ4j+7uqmLotxow8rahkf3AsPMWMNT5bGM3l+onjjWg51mG9kr4QN0BLt1Tw8G8DKlcmm9V0lIMX5zdB/RYQr4+GbFPZYLloXDK+WONskef95vqy0NxTKphUS04Lw7wcBb95FlmTmkyvHt9d6EL5M5MhyPHBhKZwX/yHyFscFbtW+UthLjxouLl6oTQDzURTWVtDwtkSKner3vW3NBvRVhuJlTIP9948R0Tajc7mEYK55r9tL+au239a5+ccb9fXu9V3HMZaib0SiW6LuYjPhfU/xXBH2Usn0zeYoX0UC6oGa/y+bro+dSQckEi5/7q8LpJa8740wJ+p666tM2fHyQZvlnIbkxl9n9ipEPhPp48oZRb5lCze12gPFEBCuPSW7sXkoX3ZeUkbd1du5r5D+Vqq44UeVSyA1cSF2KG3ce1vKuP7WrKPjViXhLFxx+5phsNU5Y68TftlijUInAVGMxG6kdMC0u9te1GjkLwtYBCEFCqtAZN9vmJcyv4Vrb5jmx1opSuzywqdEI3/jvAgxoxeE4jUV/0dtOGRtkn6u5DcZIj9ZKG8c2LazDGsTEjcFqh1+r+XgT1ybI1xXpLCDnBDnuA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VwJ8Ietj0xPpj//M9bdnrJs+miKGVw+KBqHtUDmjGoUmAhK94Yyphn7lzwK5?=
 =?us-ascii?Q?FgHnugunA27pW7HD0shno5y3OoXu1vWjo8CtLT2hRa4xlxsyi1oPZj5C9p2q?=
 =?us-ascii?Q?++n7uYjEQBEumlYRsN6Do/qFWK75xu8rkRVDQ9ykv5pptA8/SNYcAbuCmsxR?=
 =?us-ascii?Q?cVAEUiIQUuJnRGSkGKDKz+g8Lrnw+bx408TQGRBTYBkIlbNAppDZ0mzDM0Cv?=
 =?us-ascii?Q?yPa3xMzgV73H5Rb1mazgkJHOvzwLld4+N1smBkZutSrJReMfc6Yw1Ao2EJLu?=
 =?us-ascii?Q?lSrihcHgWrV9G2G0BnGgvJUL8t9mUDk4cLHrFv7l/heOQv+cfk9K8o2eeKs/?=
 =?us-ascii?Q?N7NYgIXp3DfrLKePTpIZghKMbsONOBnhViaZG0z83FgWDd7w9l61ixQk2x6X?=
 =?us-ascii?Q?RcA+jceNky5PhLyJG8kS0lxdimYgTbzQ9Eqn62qC6/9lebx3foroqP297Gkc?=
 =?us-ascii?Q?cU9rIhZjADpMj4am5/x9tBLT/UG4MtSQBbEcLCSjcNoQ5Eum48+H30H/YpM4?=
 =?us-ascii?Q?QT5H5Aszwr0hppfTDd7kewYMpfMlMolG7gJaNsf0DE+ZJTihZDFLSxAjMv3i?=
 =?us-ascii?Q?ZvnLuuDQiseBGsJaDTgz8uC3lzGQOWa8he6Uf+yWPdJoW3rlubyQqVJfQLUb?=
 =?us-ascii?Q?zNXPAB+kyB/qBVUKq2PYnajnBmfsYsfSjQADkxIr1TcKRdDV22tUVr0JiNHT?=
 =?us-ascii?Q?/bMT7IraTYTk7TfeEJkLkBuPkyWF9GBDVvipEGSIi6JE4DnFuxw3/bBxacxK?=
 =?us-ascii?Q?E3I4/SI5PkY3v9yTgNWmLYWF3P1zUnW83p8DtscI3GyWuBzY/lJhJ6cZXjRF?=
 =?us-ascii?Q?jFmMY6H71ZegL4Z3ikMcu9Frx73N3GHDUmCd/m7CL3m39CcxBLPznEf0kzPv?=
 =?us-ascii?Q?ePTmxYyHnJF/tgfxWJFfkdeMAbPb7KyDyaBePy/RNqZ+kIK0eW49X1Ovl7ds?=
 =?us-ascii?Q?C59KOz+BKt8VgoJzCVR6L7OajLQ2sOGUKMScLFls1nNaB4UGiIIH3vP9W4Z/?=
 =?us-ascii?Q?H12s9vaIIHE75F/WCxhhC+ZN7giMD0nceUNRiL102CI7VZygF2UfFqbE8qIG?=
 =?us-ascii?Q?/AAbmy0l72sSBk17ceJlQaNYIPv8Fd+bqTrV0x4OiJ0jdejeFwAQ1SEXO7LM?=
 =?us-ascii?Q?q9WKqQdoPMjnOSm84559AethVP+RdVSABoAvlBVgrQmdsI+2E+6EaJ1g2J43?=
 =?us-ascii?Q?InM34jwQOF4u85Kb9ozyu97hrcfWA3jFoPfQ5Z2IR/kD0fvCdmyHYRWltdbd?=
 =?us-ascii?Q?xuiDz86mfgqWfpGKfnYMAsM2zhtd3a21KPdJulenfiDu31EoDP06ETU0QVoC?=
 =?us-ascii?Q?Fys/nn6/cm92OMmLrk3nL48/+LzE3m5NJdBBg9hn2kjU/asJYV7xh2cI12Sq?=
 =?us-ascii?Q?BJDw9laoWvGCarxWOvwMciDaXVSGuA0f2eA/z17Na3NT0m2WWocnQ17Vzl3Y?=
 =?us-ascii?Q?Pb8f05buEifrNr+1Mi2Xwtxi5doVVRui1VhlXd4jV/aVcmwkZaqo4WyZQ2xx?=
 =?us-ascii?Q?c/93C11R6zKL/Ss8Z5pUvNJr+AYki0XUEBphF6wTvau4fjIuNtelVLOPifFn?=
 =?us-ascii?Q?bkL+7Dw1co0W9ePFS5zUo/4jd5Waq2Dl80fJ6KAIM/RuZ0C6tV+Z8cHXoy+Y?=
 =?us-ascii?Q?Ijf5Pfl/FMOPyTy45AnwxGaxt3zyKufW396aREY9wac+BTiejreBlUOtVyfV?=
 =?us-ascii?Q?5iDtuVIPd5UZ9SjqllH9ldPX4bQdY6KQ1GItFcrDgUW5KXWizym52YZCfU/l?=
 =?us-ascii?Q?VbMMChNBilIt5u3bWEQ3vmuHXchS1WODgGYFAUJ+19Uph4v+AUdi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e058c31-05a6-4173-3593-08ded7e99db7
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 03:25:50.7743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XT5xTv2MwcQ+VfEnPCl45bPMTYJJ0EyUlnt79B+3+qHe3NGHPMxLISQtGeitQ4J+SbvQ7awkR/m9WEWWnJb2D5c2sigTQ2+C9bdZyPfzOiHCrxaohKoHrAUS36HTz99E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10248

From: Wei Fang <wei.fang@nxp.com>

Since phylink only passes valid speed values to mac_link_up, the switch
statement with its default fallback to SPEED_10 is unnecessary. Replace
it with a direct call to PCR_PSPEED_VAL(). Also update PCR_PSPEED_VAL()
to use FIELD_PREP() for proper field masking instead of an open-coded
shift.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  2 +-
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 19 +++----------------
 2 files changed, 4 insertions(+), 17 deletions(-)

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
index b966637572a7..db7bad2c3cbd 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -631,23 +631,10 @@ static void enetc4_set_port_speed(struct enetc_ndev_priv *priv, int speed)
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



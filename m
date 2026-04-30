Return-Path: <linuxppc-dev+bounces-20306-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84687FF8875
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 02:48:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5drT2B7sz2xnk;
	Thu, 30 Apr 2026 12:47:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777517273;
	cv=pass; b=AsWGtvshwMwuAOrGTA0g3JQLQvFwRVuY5oxAiHoIQfY7bnRgIak+/+6b+u3b2vWEFSeN+fnYakOMnQ4bQVodQM4JJ/HGAClw6LVZYNECOpAEOsocpTFgz9c0b5QNWSTcqhqmzFuIj6E2ARkchAsp3TFUJu2unYa7Q8chzm/MF4mynEH2TP/Z6ik4MqWVb0TNJ6w/uEJVrpH1Pv5tJCM0DdZAvDZDcWQSSXkIwb572xGLkGflQTbIo0UGpuLdwHW0ocSk9gMJOPLw0Z0pMwSNa5xA1/Zp84fsHATpT1tbN0fAdnffnc7Yt5C9KmCCWl9lGrFz29AOsXEPB3+BOd1HAA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777517273; c=relaxed/relaxed;
	bh=+OkTituhj851UTH98eKeCkJCczBoTU+PcRf+naGINh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X5E7D8Fn6ef1W+X8+zYNPUiWQ5T7Cb2pSY9q1dquw1ylIFakNWSSB+0ZG9P3swAPqvThd7jrn6wNAplGxEySnCHNEH0bhn/AecpZ6bb6+0OaJxCgHdH8kFJQdMr/NcLvHPWS6cCVvDMUqdXXKCcYrlMWabwNBhH8bvmc1v7+OHDJKAdh9VL7qoAfeX+z0ffTZMBuvHN9/Cm27aPspL3dqFw41mMjxQrmt1MGBsSWIiDWcs4oTbeqzV+j+A0dENnpObfzNa/BrKJEpJdrxcE/est0GJNXmEOqtJzKUFpZnXnCFfwN1t7X3951ZRqDz/hhWr2M90HOvjz/jnqE7F3+Mg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=VAEX0TDk; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=VAEX0TDk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5drS2mf4z2y7Y
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 12:47:52 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1JXbqIGrxz/5FO0/fX0W1dLQjyn+0Zubl6p0XYzfod3qZrs+t+I2mxihV2vck7S6h2YekmNwbKyqyHw86W6rylUTODvpBMgi8e1d+4A0XR8HLXKAUzttHjdWwWrelXuBSu1dMoiemQPgrFaRt0i/Ph37/vFrbONMLbO/xlEFLYRZ1DMceV+wckk8HXWXRxPrFH+q5xTA1cwxrgQ0YZGwqfuNcQoGT8MgkOdEOs2HgTEaev62K2jttnCmbpUAXSAQdbs4RC0vTPv0e0FtzAfQBMoSll/bfnWOUHBDWIk7oG/hRMJYjOIfdHtXbhUxTDG0zKbF+ryWcRnt3Zv0uuKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OkTituhj851UTH98eKeCkJCczBoTU+PcRf+naGINh0=;
 b=bcZbWMOCpiqzA7ib2poNOW/7za7Cy6AW+HNKeHzZp/ZwtICcZKwwzZaIOJr+4mPiqbgrdQXgCXiFXmYLl7M4yaoVeGzyx1AL09HqNMQT7npnUu4Ld3LLGEhzFTxNxokNghkziMhohxYrAc7Z7I1dnpDFK8gdb/rzq5qSEaHBj67G8+o+E6nU4E2lCT4vfW1AM4oZ29NzRq3pYypjsUvxGf0LC1CNVjsnGMRhPnT6E6JDP7ua8FXC7lN69LmpUSCtuON8zW19MVMcMv5lws0HNsHRzUBbOdfrK1ZsTy6G01EnnKX24+WTZLoH/mMlyk/1d/f5WUZf2XhbHBrzFMIv1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OkTituhj851UTH98eKeCkJCczBoTU+PcRf+naGINh0=;
 b=VAEX0TDkYa9rzfkuJ51bCS4f/aSa6OuNZFanqODsu4jwKRdsetYEadaUMLwq+ENpG0id/TnpTb5jqUQdbs5K7DKm/hr7QpRnm5lTU6h1FTXr/XnERfGogJK8u9+gZYp5a1wDiz6MnJzBut0cKnW12JXTWWFyVRwn4CJiLhZO8UGmD66tsxQNxxUCSblIQjfjS1pCBjuDQYDkRG9D3Dxd2i+dXF3CJarhQkjlUu8QpX+GBEQHLtfSA12QjFKLaudiLh3tJZX4Yq9ZxB32ZFXFi6jVI/nMZlF1H9DaLkcCiV7qtFrVOXwMrpF/B3oFbCd2yyvi2dhCZ9uFPqyGO5RiGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PAXPR04MB8608.eurprd04.prod.outlook.com (2603:10a6:102:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 02:47:45 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 02:47:44 +0000
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
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v5 net-next 03/15] net: enetc: add pre-boot initialization for i.MX94 switch
Date: Thu, 30 Apr 2026 10:49:33 +0800
Message-Id: <20260430024945.3413973-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430024945.3413973-1-wei.fang@nxp.com>
References: <20260430024945.3413973-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PAXPR04MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 838ae86f-a3d2-46de-d543-08dea662db34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/pEKFQkX7zHcX4Tmzde3LfsA3zPllXtUwubzV5dMKRne7Xw1E7zp/m6BO7Mmk0xffzNn9tFl/mGY1VQg1Y7p7TyVc71Fz3wfDCnivvfYRI1UKajkCbkPNEtZqMGl3sYqatPtGCEMfE1kmRYX0SEh5P711Iv0syp+vTnwn+Tl7lVbnrNnsO2tOZeISMJUigo9vmXi6zoWmyJgB5QzFtYlpXiMyyWRHkshg5u+R80uNKs2qaOE/gqa7Rus/mxxPeo8PMZxXz1mpbAil5EdEbT7cFosYTPvlvOWU+CElegsIno4jn5GfpEdJsP5F+XVSr2qUNIJb/xIg8nbCRhiQ8Ih1cTxEsfFToBGvL1eyxdfgKMp02QCp4iPLYCM7MTQTNFVa7Td6TUJfN+L/YFoi4vJmTYjbNzWZh00Yut3Fp1cbALFKOk+F9ZaEmdiLpg6k5QL8i4lU7AmS8MFASi9HV8BGqo3WyS+CyY6EqwRUg1yTZJrzESG+/cm8stmrlVq3Sd82U/nRnO2SN+WiUMR+s0C78i5k0CS8NXWMZabHev/v03vLuVJN7+ZXxEpMVZxVkAtTx0yCJjt1hhX53/O05yud8liJNB/8OOBm2nZk/9nZJJyY6pulzU30za2P5wsgRUw7U1IQk0mGlMtTnZ5542LRTS12nfgqGO9YSXa+l1b8BgUw2+g9u8Cqv0pTKX/8kPEtIJ7smhiBu/gnKRvw3sC2g1P+QnEXRLGjMJ7zC75G0KnmRP5KfY+mTtbrtoNsU8pvtxrDN6Xu8Amijb1lVEK3iK2var/ObFFRuKHOSN/B0dwzC/8COKKugYdt/ihr9I8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yi/5ejUdr7V5FigPG2ALNQ0abk9EY/xMSTSazqokIFIpIN0/Z/DtITUStzsO?=
 =?us-ascii?Q?3lGgJGbreHD2zq8fE26qnAR8r41yA/kb03HomXyewNFdWbGxrKiLZhrpQ2/D?=
 =?us-ascii?Q?yKy67gCBEDD0+ErMNUTJdgUEzZLgkb186NUDYZXKpjuxMgYzzQomGyDnbSIJ?=
 =?us-ascii?Q?2rqv4CA/0g/gzOfxAUTR4A/Z5uAf0XDD6Bu7uY4icbp5T2vbeM6pg2+mfM5Q?=
 =?us-ascii?Q?MObNxKRnQqtITi0KDjI13cG1mH24K3Ckv1iv7fsG8syQixuq1DgamZ0m8okO?=
 =?us-ascii?Q?gG5TQEXl1ensdc0Xt8Fhp2eRfQaETXnbt6Wj1tzHhZMfj32mQL6+nit3HDuB?=
 =?us-ascii?Q?405iKtGaasB2Hbg8NwCTKWvY8XLMSd0dEMz6ltxSe/0MBugthbbnRZf4mz3m?=
 =?us-ascii?Q?D4BkJXVDogMMtlGuzKRJ1u7yThzdl3A6EEmh4XkjHfaPC2Shc3jDnwrQcmES?=
 =?us-ascii?Q?Txb/tzvb+kuLrehuFMx9nfZsOwNqgv40JPwDsyjKBPznHaBr5JYgQBxMeBuq?=
 =?us-ascii?Q?ETPtZONlr1jwylY/M8BEVRceWLn4f8nxFWhxZCyICD/Yukn+X3bvaNJf7Ea+?=
 =?us-ascii?Q?RU4C0Yor+A6cZeWq85ml4wZwX40l/wVXEIx+REBoW6vltl2K7Av/JiWybpep?=
 =?us-ascii?Q?wJ3lXA1Fpp1FiAjOk34WgY7Qy0Jt6zJ6zmT31xR1iTIg0GDjNO51Q8q+AB6X?=
 =?us-ascii?Q?7mFxOxZPmBRLs++b5jOHMnCEplyUDb0+35Vl2AUO5WCOes30W8Ici7Q9S0cj?=
 =?us-ascii?Q?nMJni4L9ePtYvrb9Ss7G5ca1t3KGBE1I5UYdVU5j6J7add4N6Gj0SN/P48pO?=
 =?us-ascii?Q?OWlKGkOBOBtMX47YIo9Makjsv2jcF31fDDb/Xg+d81EUuG917DpLJvUlM4gn?=
 =?us-ascii?Q?k2s8L2L7D9SGGA6ybUId3Vvydaj3/0S8FaW6pHPioOs73cviWSeVqFi/tdxW?=
 =?us-ascii?Q?IzWaKayi0d6CmS5AHmBOHykcBCGP4p1QJEZJ2P0xVsJSWYTuC+0tdQ+sTdca?=
 =?us-ascii?Q?FXKQZ0++6e4yV8Oo7eutC4XQkxtoIg/DnRfdJyHkQZh5tRYOMOh9uk9dTYV8?=
 =?us-ascii?Q?7v3Xt3sDlrxvWUqSVztJJXpyoK+EpJIl80AI+o7ASGONKYLtqLizU/8vn1b9?=
 =?us-ascii?Q?i3uZ8dh8S5PlbcNX0ICVGZtD+C66WN7+RaQBs+vRbv54X9x1uWPXTAwDNEZd?=
 =?us-ascii?Q?B0BkBS66Oqpv+IdUCK4RLUnOaXuJ1ih4f3KefSQdVNcBD7KZn+xYs5rUMN5R?=
 =?us-ascii?Q?4cbAvRMbEcOmqERp/FMqz3IFMhi6PoSG5RXUR9N6kyhIOklp8d6AsDOk+q7H?=
 =?us-ascii?Q?lrd6mxAlzIXHBDQkCXbmV3HLIc6MF1qOcH8ipLHrAx1yM/rGvjjd8n4JM3OP?=
 =?us-ascii?Q?apU1a2ZdOb6mbVC5CQUWYt6r6PkRq8Q763fCwfkEKsYQTS7yAXTvHE1YnIz4?=
 =?us-ascii?Q?ld44KTH5EiL7Xu5BDRLBjcEtZnUXV7McEaP7WHdBcjIqtdE2Rl5dqxYXvCXl?=
 =?us-ascii?Q?+Dx5sDInVymdlfVbI4+cvZae3Pf+e6JH5VTlEUBjTWnuWGWn3uvMRizWx6gn?=
 =?us-ascii?Q?PS68pgDwyV8yOvjWUZn38ijgSkb6luem9tSW9ooekJNNdKCF6af7DrfVHCSW?=
 =?us-ascii?Q?bOwq3KtEf2QdxCMolyelg7Ih0WCPoFt7KCB3q5KcGACgvRilSB9LGMq3fWK6?=
 =?us-ascii?Q?0cPzkYR36EMKIEYPH2obv9Tz3aEUqaed6ze4IuzWa29NmyX1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 838ae86f-a3d2-46de-d543-08dea662db34
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 02:47:44.8801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sL9leD3+SxoCgrMkoAfA31tSkH4IsvmyIb6BdwRFrDhndUzPbyjtszuDUsTvyHPYSrxqFgvMgSa/gVO37tp7BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8608

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



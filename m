Return-Path: <linuxppc-dev+bounces-20636-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4106CD3447
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2026 10:28:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gCMdY1ttBz2yQn;
	Sat, 09 May 2026 20:28:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778322497;
	cv=pass; b=MpzqB0HrpIciT0wzbw7CMNEb6XaQBlHAag9ML2Rb1iqDRylF/opwaFJuydjbchs3c8s19gT4nMtKJc0gkXvSlMKou5NizWGiX80lGWY+rTnbun4ymgGjyTMaTLe0K3wYGgezrQT4E4QEqxxXVeoWPKEUFcexVFresS8ZNFV7LbzTnsnL3IjWvQ9+en/WgyzGum6Dd+Ae2g2YdQZLsfKYQEZQH+rv7PgqaNClU3jUuln8gFER0k+galrMcgtCCn/6up44/YK0qXkbp7aIv6ecjp6Kxp/5YNW/3cW9Y9J1ROzk4eqMRNpS6kX8SaGUM2pGSVCMYZtBXzd+FcR+MAg5Eg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778322497; c=relaxed/relaxed;
	bh=+OkTituhj851UTH98eKeCkJCczBoTU+PcRf+naGINh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EmfYiO2Zu2m8MYEQ7yuCnzL/HtALaMmP6a9JldcKE9ZL4cbOJV7GWGkspRAzKtHI3Yk4LgQlZ3a96pxxz2L6hJvDOzV/AYrVAQJpuHypVbNvMFfot1cjJFIUg1L/0Ukp2HY3Oh7gupW1VW3pNvoUKnz2lXYA//VC5n7h/Ri/i5blDSJ8ayubbaIdpootAGRTl+PNBvVDFncZLjc9IrnJ7zzuUQJHpCm8dZRWqQ02aUWJmgrpvWmZX4je0LlLw+W4TxQ0L2CRYSwGEVMbISpoOw+8CbnBGH0WokeSsX8NnQnUeivguN6islme4SvZLMsG4kCRZlgQP4/hYykiAIBrvw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=VXTtYZaD; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=VXTtYZaD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gCMdX2qQpz2yKw
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2026 20:28:16 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjL5lyYx6vcRZ32+Ra2PsHbCoWoS0O59PgKHgWKAOQKjQsvDDBgtzBQbue8ULiwHKhFCJeAZnELFeHzCphMuUD2LX+1thY9ICKx9DQ65mO8GfmHXN7OL/t+zJ19XuOJaJsUwuxSi9ZGudQSt4lhGTSM8qnDXXylqXExIUef1wgEx2nNU8wxjJTuTQOKG48P3IB8910IdJwV7g5MbhTZsPL3jMFru4o6ukbJtkX6gg81b/Wgebh3oOnWa0rhJSUBqD2wEv3KBF35/tYtQ240Bx+WB1KfvBP6/KlksrSay71R+NvZuUjYN9Wv0/5c90OoKmofioSQmcrMk9dTc71CxQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OkTituhj851UTH98eKeCkJCczBoTU+PcRf+naGINh0=;
 b=N+7yUFVh1cR0AJ2re/62SnIbhXyPUt8pIfgJiM+M7D4hRavmwK+H0cHQRvFuLNN1ngFwCRi0706Z0D187iGb9OMHYhru8hcecg3tsSHU/uTHsMFKf5IYJ7/wOP1U6LPAshOKaD/c2Ey/fxFeZlyQdn+PToM3Uf3aBEbNTEgE4W9+vyeyTWIYNKI4UhNm86y7qAFG5A6LdaR+4JGsALEaXzo08TroP/XBchk+Hpe42Idi/I7DyxCqEBYCjYHjaLuyx/iWBHT6mYrR+gHKbhKEZ8ahiotZ5ADvpWIMvyrbXC0EFYc34mhUSKPcbGi6xhGzP7U9iu37/YHZ6OXdwrGVKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OkTituhj851UTH98eKeCkJCczBoTU+PcRf+naGINh0=;
 b=VXTtYZaDWFxaToE45RRnxBaNdIhtOwyqp2QOQzTbWB0Y1DXWJFjizyseNWrc7W+SZJEEkqZH60vqWyRM8/mlAfuzUlNGksk99HkXbvapy09/aQioQLRMZHmT55IUfDZ8z2rbqPNlNkNP6j5h270+mCMi7qrz8wW5cd6OEq52HPF2NspfSRsZePsHm8LTLggGYFSQ58QwZ6KVuSYrQhfLKGOGOesokwXOyWo6+hhV7Q0d2KRW0gqjn0dhLuF1u27ADHc/9yF1stAW+6GGnqnWKrMjyFcxj8LPp2U7zI4eDEmE5rzrKoO8SXCn2+lmLOUeG5OxvMDJHa9wuUprVdIQJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PA1PR04MB10604.eurprd04.prod.outlook.com (2603:10a6:102:48e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 10:28:02 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 10:28:02 +0000
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
Subject: [PATCH v6 net-next 03/15] net: enetc: add pre-boot initialization for i.MX94 switch
Date: Sat,  9 May 2026 18:29:42 +0800
Message-Id: <20260509102954.4116624-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509102954.4116624-1-wei.fang@nxp.com>
References: <20260509102954.4116624-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To DBBPR04MB7500.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PA1PR04MB10604:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f965fc2-76f3-4121-225e-08deadb5a5df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|19092799006|18002099003|22082099003|38350700014|921020|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	Q7UkQc1k0LbTUqCKLiWLxL6em9m5qUqvYa7HJ6J1+LOX0TYbMB+IhcFrktlT6XN5CdeBTY62+8AeunmD2dMigd96+jDgraX66wOlZm7cDYIwTeltPphXxT0U5v4k/03mWBBCKpCinNxRcxRcojUW3ptUqE2xV0VlI/TUrg/+VndwoEA3BMv0cJbN3FRZqZkq5pcFnVVuu/RAff3ZT+rV319CdotaQNNJDhZaeqSG77dXEGBE+Z7yePEy0UK6rEpJnEhdz0+o76EwVSAaScaCYvhksZorOofqa20Kk0YqQCtamxrr7CPrZGnzJb+hrbUpswbkrVpFcy9L/7TDvfXnPspf5WbexB2Urf+sWAt0lUmiFF2VG+jIeEs5ZFSMI/RSAQNJ9PISlXmWleUV+Iztq7yKKbzLF15awCzuW42BTHE4zd6IBLw+l/5Mgwy/lPzjx9btrCCKttrV4jodmdA+V5u1xTneJKRRLk/Z9+deCdMm2koeDylRg//9s4L0CMJD8a6Q6lgb6cfqKtkQFR05Bh8Exbui0aOeZL/ci57aT0vZ/E24mX5slXKyETp29j4BW7QisUh/x4mHdwQcA6xD9yAPe/ffBUIb1qDUJrzr3/eaBuJxrGhHu/LdZPgC0S6amAYm3vLT1u5kQwEVv/kUkpIuEHQsZ+aRV7YY2mtiZbGYr0wWh2anUWLwZXfjflYlMN1QZX2grfro7gKm1wvuFU9M+Rz29DuGUkEaY1UEZNMFl0SbvVCeAAvwDohoBkiznk9Bb6SaN7SX6WlZY+Y0+Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(19092799006)(18002099003)(22082099003)(38350700014)(921020)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zT4xHQskGFcyiEFeA2W+jMMbZzYvc2Ve/aaHiULh+z+N12Ol6ye1qW12y2nQ?=
 =?us-ascii?Q?wTPSncGGRxrTEPQpFyAnSTDuQdupe3fBUV0WzxosxZVLesxfuDOzs//373Bu?=
 =?us-ascii?Q?rqF6ewdmkhwZkz7CTZMHz/4Pu4HR/Ra9ew9rAprsriC7KTPNqa0VUXVKz0BI?=
 =?us-ascii?Q?fYRvravADszebP0R56m2KAv0SAXlaf9d8Up+N+eQYUsjU+Wm/j9El7MwDRo1?=
 =?us-ascii?Q?GhVrsiUGyiCrUmhezKdKIt3ncWGAJ6OzeUkEa+gRgVOHezJShGUX1krLyYY7?=
 =?us-ascii?Q?hvX0JaXk5cfrjUtwPDYWYYFBr5RFxqHfIX2XVdPfp36PO06lzIST+yHgd6VE?=
 =?us-ascii?Q?ZTSECtnM6dN7w5BtecYV1ABpbm0GZk2X+kw4mPVAEqgiB4O9EWsIYS/YEPlf?=
 =?us-ascii?Q?UzNN1Xuy48kAqZXYI+nJPdCNdxN3TkJ5w9RHu+xpnJSAb/IZSLgtenVWqdGN?=
 =?us-ascii?Q?++XEoM4OzSPcF8Ovo3j8K5eBVOzenaksIiMEqC+BfnnTPMgj/8dEH69WQsYt?=
 =?us-ascii?Q?9DWxLk3fNVURXph+hrcOcouVjoZKmkXie6Uc1m5706W3ieSf9KLrWsPpuYiH?=
 =?us-ascii?Q?0B4L2NInA2mF2zF9EPnqLsOexRaWGbDiRSr3nU0DY+W2hi7tnQtRCWph/wj6?=
 =?us-ascii?Q?kS2X7Jo1SSny8oVVf034FRsylBRB2en2teoqFLiPnEc7fNf4ftv7hzG8IxwQ?=
 =?us-ascii?Q?OrurTL3qoC1JSgmbBtkG6H9tYH9VLLjQqPReDBOQEMosJc3gD8xTOq5yPQiT?=
 =?us-ascii?Q?D41+WjzWWyiJNhjL5yjJhZphNbCm4C9UcEGB3Rx9RHmbl0NAZ2+LVrQ1PI6/?=
 =?us-ascii?Q?sODcPX0iFsQC+HWldjpkfub5AwQKMT3+kkCo/nOZNl3NfrN+c4dBBI1NsmMK?=
 =?us-ascii?Q?xh+HXuUuVss4yvlLyHAnZhCb/C8un0iG7DDmb0G7P0OOoGIaA2oBwToPpndw?=
 =?us-ascii?Q?695RH4oJ+gYsTtCn4felkeoVdObJ0aoIb/y1YSdr/kO0kM1nHt6ZIRKVoOk9?=
 =?us-ascii?Q?TuNxzifdWVFKVUxyLRuh/jZ9KwzV41lCq/Lw8qKfOaiPLuS5sAxFN2Ny5GyH?=
 =?us-ascii?Q?Doxxxsx8agABGMKh3FLCgQEC9lZkJWfj44pymRfFrOnwmYv11TNmdtMuQa/4?=
 =?us-ascii?Q?UML5bWjTT2dbJOhn9cebPwvo2jpSC2aZTDwkb6NlTVceFoYbXtkDVrxDT6hE?=
 =?us-ascii?Q?eZ02o1Pz6KNofOXerSc8xQajbJxO5XClfops1rBIORuDevXQo7LZV/w5fi+D?=
 =?us-ascii?Q?1kIbdnBCnOWutnwLbqlwPNs7uHyJ5KbfMHcHpBjHPoM4n1V0KMjvidaW8Ise?=
 =?us-ascii?Q?5W2Whhw5Jj/TQVFxtxsn6xF/2XFDL/J3ba6Ez+qHpYDcOpsTRFLzr1JMSlBe?=
 =?us-ascii?Q?SdGQRpIJBh+/NQ/AAxAG9J3Xk2YrldhmnLHkBtNC4y+GFmlainWt/4iSfUgS?=
 =?us-ascii?Q?5GNJTdzW7VhOPzOlV2Gm/07OrriisV47vBrWUQrOq5kFfFMi3zz5Bh5uwW5J?=
 =?us-ascii?Q?7yAP1O0dpnPCSafJLkvLz9anexPwIkQsP2VnqzMJQoiqTmkVEryY4Pdj/Hrw?=
 =?us-ascii?Q?iTzHdRL1fIE2bcqBDXuU5sHuGTcKxcUm0ZX2FoWnSQ+5j/L2MOVj6iP1xnm/?=
 =?us-ascii?Q?mkCxiMBkQ7r/L+/HhdbjQdkY0gRC3ILuna4wJyOrwM02VJBazrgFPdlatBP7?=
 =?us-ascii?Q?GL4//ImHF3ApayeUMXax154IIWM4hdeI0lI4TCz0mlFp5PNF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f965fc2-76f3-4121-225e-08deadb5a5df
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 10:28:02.2221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czYNLVjqLGePUIlwiHVyKMWPzHJqkI1W3anOafz/kHQ/Ai6HJLWXu5Mcmv1FWMe/qnYE25P35VxqMlKTfxR9xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10604

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



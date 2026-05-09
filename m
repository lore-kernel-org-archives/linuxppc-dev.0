Return-Path: <linuxppc-dev+bounces-20644-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CBECD37B2
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2026 10:29:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gCMfY4kTfz2ypk;
	Sat, 09 May 2026 20:29:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778322549;
	cv=pass; b=MO+RNX9B0rpNvIwv0rcc6mTcc97SgeUD78LyQLG6/kBPUHNQ2vFmHUF8OrTpBuzOqF4TuzowlluvyCUa/i/mgQgN8EdCHtCtsl5beaG6BFHrsaQo48R2wHk+k3kWx10zJ8QXkZBnGZq/3FkZ+Ox4WdDSBomtw54GAUxqFnxMNVzRqUYN2vvS3fXqmTnmsz0mT9iB1VPZNQcm248TifYgNrg6xXS+g0SD2tkywc6xdxvtGNtGg28Kdh4lcuLwepErb+i8orkd8cip9kkbt5GL4NFXrgM65PBtwUUzhDW2unHLH+TEnyv18jv/g6Ihthf6Wq5WM8eGucyD6339VcNcIg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778322549; c=relaxed/relaxed;
	bh=AEq2MVRBr9sXKqNCYS5vqje8wWVWoUCsdsSf+yKu24s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=om9WhpSsuVNHT2CZEDY5kp3AvhTYvdLVXeM1DuXXMREYzXnY2n1D8R43poQECAaOvYYvT27HSN595ljeJi+YFUn4KgAlcWAJy5mVSFx117w5jZJSBWctJx0+rMtFDgEs1XsqhZIirQMcq012hO71ocgVNSq3Sb+HKvnXj+tE7KszMb66aU+6pFEb0hjxJYWaIETtCpnBOcMhlwRTgpnscpcr+iiKY0QpUHxRN8hh9gcvlJ05RPRVhrrceR35dvri5AokCR+Gnzm2ENLX2D0S4Pi1eXXiVOm8McWhkkO1cobOkIR+C5Alm6ZqrTrnanHzWRHapovnd5XVlCKGYF2jYw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=S5bcskaB; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=S5bcskaB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gCMfX47c6z2ynC
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2026 20:29:08 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6VIWVwA3Wn5QwveGo49imFKmlyJFy3BAtqwtqBgDqZPBIRyxSd2I8ehBjI633YeMbir8nq7Vzpx74UQyMzvI2JE5n9FVeygHuNzmhRRJrBvqohjWKWGeJ9k7h8voaXUINAE4dHSvMYq6n4Uk2inRbOczMrhCnsOsP1F1jeEw/S1KnLHkBE/zLWjeOMF1SbASfv2bG7QXVhV4jcTMVl2oAOskk7i1x/v1L46ilEW5a2JvjveuVJPAN2lEzaH9xrCbfjRRM+QOM8gox0ruOg+ZfpddcSoSRIR3K9jkEgUbvwy9Bvi0qE2FnqdVna8HVWsjB+Ay8KEelGSiuhHSfuHeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEq2MVRBr9sXKqNCYS5vqje8wWVWoUCsdsSf+yKu24s=;
 b=mpu3CQqmPgrClD15LM8E4fcf397521XWLtVBbPggFPUwDZmeEl0/A5v54gpCpaJycAxLtfFvRCUPYTp/RMxqorQL4mPIbaEpvoch7OOrItvNFVU5EOu6jEJfzE0RFMnueRG2vHzgQygDCeJ71sXunvFUM17FrkL0bvNkeukg1epAqQSkrORwS7/GiWNdu2gWkDanFhhk/WagKhdtdCd5zgoKYTAxR19K3ammvVnkeT8sXHGm5hS+KG5GstY6ZODjGnqgY5jR22F8sBUg6UIH3O1e23uBNe8cDg69gWboMyaGE1pUXotoh3cujWPRMTbdwZXjsW/YB3lBVOd/xfjJsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEq2MVRBr9sXKqNCYS5vqje8wWVWoUCsdsSf+yKu24s=;
 b=S5bcskaBb18JRr/oJspuHvJUFJnay6v65M+zpOqK+eznxsVCYzplSUvr/HBHTqMzJKXISiUK5wJctcuo9uaiO0DHzvgEI0OLLQgVHsPPPiaShOo7O+ze70CWCqZUap0TuFZ+zGNITSDhSwhOsERBQx+6/FW03l6BzghbLwRr5EyGJrRL+BoZJwSLeCKz2WS6P7AuRimzhbEMSAWEN6EGMnf7MUH5puppUFKBA3rrTViTKlQ/G8zyIfw6I74PLZzk7mcUTAq07t2tRnIe13ei9iBN+STFX77P5duRy56xv3RBtEFBo97oIwHG5muwjji23/eCYTsk7rAN+bc69ZiQww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by DU4PR04MB10385.eurprd04.prod.outlook.com (2603:10a6:10:56d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 10:28:57 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 10:28:57 +0000
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
Subject: [PATCH v6 net-next 11/15] net: dsa: netc: add phylink MAC operations
Date: Sat,  9 May 2026 18:29:50 +0800
Message-Id: <20260509102954.4116624-12-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|DU4PR04MB10385:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc1c9be-3d9b-4721-12b8-08deadb5c6f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|19092799006|18002099003|22082099003|921020|38350700014|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	dOnIFrhm7bhdhyA94oNVlXwbdoziuxDYWmkUhOFo5bQnI/2B9rMrux4uhjoxyjhnXQkkGOsc41FEccmyoSYp1x1vWY6H7C9PaDXstP3eQS07gWErFBHSjAk7BYIGsvAxwc6oCL3YPCEYP2O1Nd+w6emLZGS/a5Dv0nc4/5IhVungUHTOZtiFqBRGCIz/HZwUUIn9Fpm481SwakZzRWcM1ufI4L1r47LgdD7U0EvpVsvYO0TbVFkKhmDCe/48TzwQCYj2vRsfKlznlGEZ3HZt29Suv3zq7bYHnbZJshOd4pb5JN2XjGUQ5E3AocaoYaE3nivseGZEhY7KW6jSMBofqzi8z3dJ7dORrSmkMGRaJcIMnbhNsuOERE5lZ10RF5fGvaWXtrog8ddr9U+3HV5UlevvJnpv9NG+svxJnjflVhJCbalZRG42hC00AiwNuejYjImGl70PePU7ly9QBy56q6gDwmHIL4MMKzPAXskoUmnIDePE4MQeMrzn/QTWhX/xJC9bukBfwz9XplnE3hL7ml5WKsivD/TiYA7kfjbPGw/2FaouzLOWjsn7uWDEImSXiBAxR5WthI9ha7FHH2USfS3BjdTGaAPCEwIgB5evE0MS5ikgDAxUtgAxMumPpFbypDQ8Ox/jOLi5cxubhhUOu6bMDwMnGM17DeyJNJjBk2E9LZRVwd6RfN9wWiETFUUvWjGynYmQQ6rhO+r45oxKDiwUB5popWdLH24CORQq/t8mp4g8LZ333r1uGq6vd+emBrjE0Y6VpiRaX2M/ukIYoQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(19092799006)(18002099003)(22082099003)(921020)(38350700014)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BKk99HKDp28JzYjVgttcMcaGLojKvqGcm9PuB++2TN0NMpkJ9j1kX+bAY5sv?=
 =?us-ascii?Q?rmVzunz5RaxvXPR5R8sBUUdbCdTXG8JJW37J08qcJYkR3XwN838eDTjTBNAz?=
 =?us-ascii?Q?gbKA2iSlIWY62sI6NVv2FQJuZ3rmzJCbMM2qWbi7D7YXBydPjbU0pp2iGWkP?=
 =?us-ascii?Q?/TY+2sf1O31mp9tX3HBdMYW8+vXGdecl1WJHfc09tgwctQHkvpJ2IudAqI8r?=
 =?us-ascii?Q?UPuEWF26bqiEKgK+3h2MhakdkxAL+4HiPgI9C0wtn+dEdekcuC4aE598OI+S?=
 =?us-ascii?Q?mkbUyaqukQKeXpxFR0nbKK+oYELOiuBuVXSlsL2nATmPs7i5NpKgflJVaNCg?=
 =?us-ascii?Q?+BdDtH0QGFQZK8P76d4SVJLi4Jq0gTBcLN247zar00EhT4UtxAGu08GSmsXA?=
 =?us-ascii?Q?/gCd3pDW3G4Db0HIYhsyxAnsx4gxeGfqSzjI0lm4xEmHssfRWYAhPsEsDAmv?=
 =?us-ascii?Q?jJQdOtiF4lMy8WoiwWK4mEO8aI9q9a3e1MMZYss/MKhVEQsGQ3dh6pTApi29?=
 =?us-ascii?Q?VVs2aHJMn45iMUIjpwRgjNSE5S9mkLB73ggH1tmQLExZQtsHOh7BlvUAMKgf?=
 =?us-ascii?Q?s0t5x9lTT8qwnHsHfigt80fOr65ou779NERlg+vS1R9JsdMFBmmeDBvTg2Tq?=
 =?us-ascii?Q?DvZZCEjzvv0ndcJ8gUzuK2uaPxD2xmliWJe0sfAvhQWlbEYucHQ8k2IMkq2G?=
 =?us-ascii?Q?ttzHJTN2+f0MSgOnxf4Fhwr+14ejIkxp7SdVy+9r+n30y96vzzTc1Vw7vEGe?=
 =?us-ascii?Q?lcw2CZvjxT8yYiY46Dd5zstuN92HNMhVtJJ9bY/WMaHYz+ezuNt1FoJae9C/?=
 =?us-ascii?Q?TyAPoz5wTT7/q0kLYeSOFDLdO5ZTrSQ6qzROKTtvwRLuSvum5noKFePA+gAF?=
 =?us-ascii?Q?KGU2q9eFgbddA4jjg2SKxzR1m3zHh7eIuXvo6vzri79vffXOHbQYtF+qCGYf?=
 =?us-ascii?Q?REYMHrNhQuF5GGmcULc/dMHIQT3YeWMNMACAKyrKN6yh2jGvSVw+Ohlgacsd?=
 =?us-ascii?Q?aLaYbKkhMrZMIzpBzedwneSGhYZEfUhSFS3MmJ1dCZMdf+pHI+rLlV9LTnMa?=
 =?us-ascii?Q?dUPDAbab0p5NdSwIcPhEhnHbgnqqGBfaxm33MELhSWUMUEQ6QDTpFauwO/hL?=
 =?us-ascii?Q?GgxVV//cqG6kYZqtkPUmiYA+/Bs43YIWq6N44R2nkg/hbfidGPr1HBKdBO2M?=
 =?us-ascii?Q?DwtRJN1jSHNhX0YY74F/+Uy6Xh5KodREimcYhtT7HLvvnC5cqoL+vRxZIsop?=
 =?us-ascii?Q?sntF9Nd0t/ek6hUD8jYDTmcye4F/QUEdRGGkhJ0G+MdITx/ZYesGA+UTub1j?=
 =?us-ascii?Q?TOdIo3gCIhA8g2N5jKxTOlK06vapJF0oNuSiPvISdcFM7CBKl4sDSIwQdczs?=
 =?us-ascii?Q?wisGIVu7PO96zRlGpNr68xgItwYIWVy7hkFFwm94Lz9p8+7y8iLnxptgwc88?=
 =?us-ascii?Q?Jh4Wx/0D1L4kcqKzQi2xDhEMp4TgldgEjf8Qns1CWY3oxgIT13lvUJLJQa5m?=
 =?us-ascii?Q?prLaI76Prktol19KDTxhng38hnS0IJdWCSsjP2tpdayk97eXpb0tMJdvpD4Y?=
 =?us-ascii?Q?z82cBFQeSPlPZdpsoUOxSL7DT3Mr4aNMf+A9Th8dr6tIBvH1EmWOf4oq4Ujx?=
 =?us-ascii?Q?HO0RDWVsswzALw3L/bFkn+5VlIKpMiOfHZ8z3/A4Alc/hpKhDsrfx38OgSUj?=
 =?us-ascii?Q?ESRrWhFuUwPjRH0dnw24v+3zatD5iXK9kcKyUOIZv3r9ccpu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc1c9be-3d9b-4721-12b8-08deadb5c6f2
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 10:28:57.3573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uaO/tDQJtksyeU2nW8j0zShcnBCWH+ZJzEEmxMWSF5BAmE5iv3pSSong/clboDsCJK+FrIz3fi3mZ6nhuCZH8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10385

Different versions of NETC switches have different numbers of ports and
MAC capabilities. Add .phylink_get_caps() to struct netc_switch_info,
allowing each NETC switch version to implement its own callback for
obtaining MAC capabilities.

Implement the phylink_mac_ops callbacks: .mac_config(), .mac_link_up(),
and .mac_link_down(). Note that flow-control configuration is not yet
supported in .mac_link_up(), but will be implemented in a subsequent
patch.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/dsa/netc/netc_main.c      | 243 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_platform.c  |  38 ++++
 drivers/net/dsa/netc/netc_switch.h    |   4 +
 drivers/net/dsa/netc/netc_switch_hw.h |  26 +++
 4 files changed, 311 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 8e3a3230226c..8c1317b72a81 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -43,6 +43,26 @@ static void netc_mac_port_wr(struct netc_port *np, u32 reg, u32 val)
 		netc_port_wr(np, reg + NETC_PMAC_OFFSET, val);
 }
 
+static void netc_mac_port_rmw(struct netc_port *np, u32 reg,
+			      u32 mask, u32 val)
+{
+	u32 old, new;
+
+	if (is_netc_pseudo_port(np))
+		return;
+
+	WARN_ON((mask | val) != mask);
+
+	old = netc_port_rd(np, reg);
+	new = (old & ~mask) | val;
+	if (new == old)
+		return;
+
+	netc_port_wr(np, reg, new);
+	if (np->caps.pmac)
+		netc_port_wr(np, reg + NETC_PMAC_OFFSET, new);
+}
+
 static void netc_port_get_capability(struct netc_port *np)
 {
 	u32 val;
@@ -507,10 +527,232 @@ static void netc_switch_get_ip_revision(struct netc_switch *priv)
 	priv->revision = FIELD_GET(IPBRR0_IP_REV, val);
 }
 
+static void netc_phylink_get_caps(struct dsa_switch *ds, int port,
+				  struct phylink_config *config)
+{
+	struct netc_switch *priv = ds->priv;
+
+	priv->info->phylink_get_caps(port, config);
+}
+
+static void netc_port_set_mac_mode(struct netc_port *np,
+				   unsigned int mode,
+				   phy_interface_t phy_mode)
+{
+	u32 mask = PM_IF_MODE_IFMODE | PM_IF_MODE_REVMII;
+	u32 val = 0;
+
+	switch (phy_mode) {
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		val |= IFMODE_RGMII;
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		val |= IFMODE_RMII;
+		break;
+	case PHY_INTERFACE_MODE_REVMII:
+		val |= PM_IF_MODE_REVMII;
+		fallthrough;
+	case PHY_INTERFACE_MODE_MII:
+		val |= IFMODE_MII;
+		break;
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_2500BASEX:
+		val |= IFMODE_SGMII;
+		break;
+	default:
+		break;
+	}
+
+	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
+}
+
+static void netc_mac_config(struct phylink_config *config, unsigned int mode,
+			    const struct phylink_link_state *state)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+
+	netc_port_set_mac_mode(NETC_PORT(dp->ds, dp->index), mode,
+			       state->interface);
+}
+
+static void netc_port_set_speed(struct netc_port *np, int speed)
+{
+	netc_port_rmw(np, NETC_PCR, PCR_PSPEED, PSPEED_SET_VAL(speed));
+}
+
+static void netc_port_set_rgmii_mac(struct netc_port *np,
+				    int speed, int duplex)
+{
+	u32 mask, val;
+
+	mask = PM_IF_MODE_SSP | PM_IF_MODE_HD | PM_IF_MODE_M10;
+
+	switch (speed) {
+	default:
+	case SPEED_1000:
+		val = FIELD_PREP(PM_IF_MODE_SSP, SSP_1G);
+		break;
+	case SPEED_100:
+		val = FIELD_PREP(PM_IF_MODE_SSP, SSP_100M);
+		break;
+	case SPEED_10:
+		val = FIELD_PREP(PM_IF_MODE_SSP, SSP_10M);
+		break;
+	}
+
+	if (duplex != DUPLEX_FULL)
+		val |= PM_IF_MODE_HD;
+
+	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
+}
+
+static void netc_port_set_rmii_mii_mac(struct netc_port *np,
+				       int speed, int duplex)
+{
+	u32 mask, val = 0;
+
+	mask = PM_IF_MODE_SSP | PM_IF_MODE_HD | PM_IF_MODE_M10;
+
+	if (speed == SPEED_10)
+		val |= PM_IF_MODE_M10;
+
+	if (duplex != DUPLEX_FULL)
+		val |= PM_IF_MODE_HD;
+
+	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
+}
+
+static void netc_port_mac_rx_enable(struct netc_port *np)
+{
+	netc_port_rmw(np, NETC_POR, POR_RXDIS, 0);
+	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_RX_EN,
+			  PM_CMD_CFG_RX_EN);
+}
+
+static void netc_port_wait_rx_empty(struct netc_port *np, int mac)
+{
+	u32 val;
+
+	/* PM_IEVENT_RX_EMPTY is a read-only bit, it is automatically set by
+	 * hardware if RX FIFO is empty and no RX packet receive in process.
+	 * And it is automatically cleared if RX FIFO is not empty or RX
+	 * packet receive in process.
+	 */
+	if (read_poll_timeout(netc_port_rd, val, val & PM_IEVENT_RX_EMPTY,
+			      100, 10000, false, np, NETC_PM_IEVENT(mac)))
+		dev_warn(np->switch_priv->dev,
+			 "swp%d MAC%d: RX is not idle\n", np->dp->index, mac);
+}
+
+static void netc_port_mac_rx_graceful_stop(struct netc_port *np)
+{
+	u32 val;
+
+	if (is_netc_pseudo_port(np))
+		goto rx_disable;
+
+	if (np->caps.pmac) {
+		netc_port_rmw(np, NETC_PM_CMD_CFG(1), PM_CMD_CFG_RX_EN, 0);
+		netc_port_wait_rx_empty(np, 1);
+	}
+
+	netc_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_RX_EN, 0);
+	netc_port_wait_rx_empty(np, 0);
+
+	if (read_poll_timeout(netc_port_rd, val, !(val & PSR_RX_BUSY),
+			      100, 10000, false, np, NETC_PSR))
+		dev_warn(np->switch_priv->dev, "swp%d RX is busy\n",
+			 np->dp->index);
+
+rx_disable:
+	netc_port_rmw(np, NETC_POR, POR_RXDIS, POR_RXDIS);
+}
+
+static void netc_port_mac_tx_enable(struct netc_port *np)
+{
+	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_TX_EN,
+			  PM_CMD_CFG_TX_EN);
+	netc_port_rmw(np, NETC_POR, POR_TXDIS, 0);
+}
+
+static void netc_port_wait_tx_empty(struct netc_port *np, int mac)
+{
+	u32 val;
+
+	/* PM_IEVENT_TX_EMPTY is a read-only bit, it is automatically set by
+	 * hardware if TX FIFO is empty. And it is automatically cleared if
+	 * TX FIFO is not empty.
+	 */
+	if (read_poll_timeout(netc_port_rd, val, val & PM_IEVENT_TX_EMPTY,
+			      100, 10000, false, np, NETC_PM_IEVENT(mac)))
+		dev_warn(np->switch_priv->dev,
+			 "swp%d MAC%d: TX FIFO is not empty\n",
+			 np->dp->index, mac);
+}
+
+static void netc_port_mac_tx_graceful_stop(struct netc_port *np)
+{
+	netc_port_rmw(np, NETC_POR, POR_TXDIS, POR_TXDIS);
+
+	if (is_netc_pseudo_port(np))
+		return;
+
+	netc_port_wait_tx_empty(np, 0);
+	if (np->caps.pmac)
+		netc_port_wait_tx_empty(np, 1);
+
+	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_TX_EN, 0);
+}
+
+static void netc_mac_link_up(struct phylink_config *config,
+			     struct phy_device *phy, unsigned int mode,
+			     phy_interface_t interface, int speed,
+			     int duplex, bool tx_pause, bool rx_pause)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct netc_port *np;
+
+	np = NETC_PORT(dp->ds, dp->index);
+	netc_port_set_speed(np, speed);
+
+	if (phy_interface_mode_is_rgmii(interface))
+		netc_port_set_rgmii_mac(np, speed, duplex);
+
+	if (interface == PHY_INTERFACE_MODE_RMII ||
+	    interface == PHY_INTERFACE_MODE_REVMII ||
+	    interface == PHY_INTERFACE_MODE_MII)
+		netc_port_set_rmii_mii_mac(np, speed, duplex);
+
+	netc_port_mac_tx_enable(np);
+	netc_port_mac_rx_enable(np);
+}
+
+static void netc_mac_link_down(struct phylink_config *config,
+			       unsigned int mode,
+			       phy_interface_t interface)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct netc_port *np;
+
+	np = NETC_PORT(dp->ds, dp->index);
+	netc_port_mac_rx_graceful_stop(np);
+	netc_port_mac_tx_graceful_stop(np);
+}
+
+static const struct phylink_mac_ops netc_phylink_mac_ops = {
+	.mac_config		= netc_mac_config,
+	.mac_link_up		= netc_mac_link_up,
+	.mac_link_down		= netc_mac_link_down,
+};
+
 static const struct dsa_switch_ops netc_switch_ops = {
 	.get_tag_protocol		= netc_get_tag_protocol,
 	.setup				= netc_setup,
 	.teardown			= netc_teardown,
+	.phylink_get_caps		= netc_phylink_get_caps,
 };
 
 static int netc_switch_probe(struct pci_dev *pdev,
@@ -549,6 +791,7 @@ static int netc_switch_probe(struct pci_dev *pdev,
 	ds->num_ports = priv->info->num_ports;
 	ds->num_tx_queues = NETC_TC_NUM;
 	ds->ops = &netc_switch_ops;
+	ds->phylink_mac_ops = &netc_phylink_mac_ops;
 	ds->priv = priv;
 	priv->ds = ds;
 
diff --git a/drivers/net/dsa/netc/netc_platform.c b/drivers/net/dsa/netc/netc_platform.c
index abd599ea9c8d..bb4f92d238cb 100644
--- a/drivers/net/dsa/netc/netc_platform.c
+++ b/drivers/net/dsa/netc/netc_platform.c
@@ -11,8 +11,46 @@ struct netc_switch_platform {
 	const struct netc_switch_info *info;
 };
 
+static void imx94_switch_phylink_get_caps(int port,
+					  struct phylink_config *config)
+{
+	config->mac_capabilities = MAC_1000FD;
+
+	switch (port) {
+	case 0 ... 1:
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  config->supported_interfaces);
+		config->mac_capabilities |= MAC_2500FD;
+		fallthrough;
+	case 2:
+		config->mac_capabilities |= MAC_10 | MAC_100;
+		__set_bit(PHY_INTERFACE_MODE_MII,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_RMII,
+			  config->supported_interfaces);
+		/* Port 0 and 1 do not support REVMII */
+		if (port == 2)
+			__set_bit(PHY_INTERFACE_MODE_REVMII,
+				  config->supported_interfaces);
+
+		phy_interface_set_rgmii(config->supported_interfaces);
+		break;
+	case 3: /* CPU port */
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+		config->mac_capabilities |= MAC_10FD | MAC_100FD |
+					    MAC_2500FD;
+		break;
+	default:
+		break;
+	}
+}
+
 static const struct netc_switch_info imx94_info = {
 	.num_ports = 4,
+	.phylink_get_caps = imx94_switch_phylink_get_caps,
 };
 
 static const struct netc_switch_platform netc_platforms[] = {
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index a6d36dcebc6d..ac9743da2a1e 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -35,6 +35,7 @@ struct netc_switch;
 
 struct netc_switch_info {
 	u32 num_ports;
+	void (*phylink_get_caps)(int port, struct phylink_config *config);
 };
 
 struct netc_port_caps {
@@ -70,6 +71,9 @@ struct netc_switch {
 	struct ntmp_user ntmp;
 };
 
+#define NETC_PRIV(ds)			((struct netc_switch *)((ds)->priv))
+#define NETC_PORT(ds, port_id)		(NETC_PRIV(ds)->ports[(port_id)])
+
 /* Write/Read Switch base registers */
 #define netc_base_rd(r, o)		netc_read((r)->base + (o))
 #define netc_base_wr(r, o, v)		netc_write((r)->base + (o), v)
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index 0419f7f9207e..7d9afb493053 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -67,6 +67,14 @@
 #define  PQOSMR_VQMP			GENMASK(19, 16)
 #define  PQOSMR_QVMP			GENMASK(23, 20)
 
+#define NETC_POR			0x100
+#define  POR_TXDIS			BIT(0)
+#define  POR_RXDIS			BIT(1)
+
+#define NETC_PSR			0x104
+#define  PSR_TX_BUSY			BIT(0)
+#define  PSR_RX_BUSY			BIT(1)
+
 #define NETC_PTCTMSDUR(a)		(0x208 + (a) * 0x20)
 #define  PTCTMSDUR_MAXSDU		GENMASK(15, 0)
 #define  PTCTMSDUR_SDU_TYPE		GENMASK(17, 16)
@@ -123,6 +131,24 @@ enum netc_mfo {
 #define NETC_PM_MAXFRM(a)		(0x1014 + (a) * 0x400)
 #define  PM_MAXFRAM			GENMASK(15, 0)
 
+#define NETC_PM_IEVENT(a)		(0x1040 + (a) * 0x400)
+#define  PM_IEVENT_TX_EMPTY		BIT(5)
+#define  PM_IEVENT_RX_EMPTY		BIT(6)
+
+#define NETC_PM_IF_MODE(a)		(0x1300 + (a) * 0x400)
+#define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
+#define   IFMODE_MII			1
+#define   IFMODE_RMII			3
+#define   IFMODE_RGMII			4
+#define   IFMODE_SGMII			5
+#define  PM_IF_MODE_REVMII		BIT(3)
+#define  PM_IF_MODE_M10			BIT(4)
+#define  PM_IF_MODE_HD			BIT(6)
+#define  PM_IF_MODE_SSP			GENMASK(14, 13)
+#define   SSP_100M			0
+#define   SSP_10M			1
+#define   SSP_1G			2
+
 #define NETC_PEMDIOCR			0x1c00
 #define NETC_EMDIO_BASE			NETC_PEMDIOCR
 
-- 
2.34.1



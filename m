Return-Path: <linuxppc-dev+bounces-21080-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C268CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 08:23:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJrQt2xVxz3bt2;
	Mon, 18 May 2026 18:23:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779092582;
	cv=pass; b=QcjV5fe90JD9HTx+JU+bRAqix+wmMggbD8413ktfZbDnU9LzsUUp1aCpd29guUo7e1J8IlhI92wkg3Ki25mDDZGQrqv2RigmLCgmuE45T+xxibR94e2HHdPVPiH5fpmgtjsocDCV/NiqeJfQfarjAtkIPmFHc0+6DwU9JMbR5mYuT3Wuv2oSmAjxnFNtxFUa2ybIBhDRUVkqU2R4QGbn3fBAEqJx2XOL7fEHT98NyndntbM7gkgiHQgLyfuIpNWwKs797yMkw9U2N6CO10jRW37fRnZL8T9zY6Z2UzEYPaaZdos3xKsya2W5xYxkhAyyF6Z+tpI21hhkXxNDj8fdfA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779092582; c=relaxed/relaxed;
	bh=1QIpneJD6m/S/80aesbxQwAdUvv860RySfeuq8k7Lt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P9wZoX0gkBb+/g/KM9jLCVqTpACsqFQNXxgyQyk/SwE/Mk557lUtWYZy1VAfNY1AluwasFs0kXJUY9sKoscA6bhIGLH0DOnOtd1vXnMOz+Ec/oIuLg46zCvJTd88ugBGgIb4xUiI6jMf74/YD+QWuaDFlFow7MOVovWLpnC6ZxcHde4hbJ8mGtoW7DRZiJVofKtE2cydJBFqZ7hVdX69o5WFi9hokdAYzMK38otYfSsGeZoQs/8lFOWw5azb6WekLMp4weulABo7/kV7ook7LTqGsIwPmlLoSJRSH1r5heDVXrbgUheCR6q9Z4aCY2fTKXAaHPZLJJfun+gV/Oa8ww==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Y9g/r4/v; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Y9g/r4/v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJrQs3TRLz3bs5
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 18:23:01 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqvRwALxcA0NJWwMovsv4ZWl9T2w/YJdGb8PAZzDPiWGaO71wjBSMLHoNl6A5szZS1dnM5DMNJVOVm19pbjhENKq+y44V3z0uTF5h/h4jNGedBgcXmejRP99gHclBIlBDLcgMUGowpSxlwRuqL/Wg4jN/KYqPJK5wHZsm4Q/FKbPJcn4EZHwDmGjkVL4QvWKwTxPVsAVtOK5Ay5y+/NFSf80WJeg4vI9pAoQ7EEiFy0jtaIPge7Q8Mt4Fcu1wiW0M577L3rAWDPR9suLUW1ObPalhA2NyxOH00iuckNA23kNuU/RnMSje5dqge8cfk0kkT6MhG4+1A6FNGxBTCgoUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QIpneJD6m/S/80aesbxQwAdUvv860RySfeuq8k7Lt4=;
 b=MLz4I8PcThvqVKOQ2zgepYhY+W/DjmYkLXo4oQMaYpHBYEij+2ZXupPPw6Q32x1WzGyiM2sa6QbrQRcERrR+YAuo8zvMKQ90JLHAL52xSVcSr4OAX4TYM31JQAoqRmpLK2ehTWt/aOsj6FfixL6CORcPn7YsOwAsV5iuUt3yeV+nKy7QXEmYrRc8a3+TE9ASrDvxIkFko92Gx1WHNEXRskF+sgepEiVWSvgxgODZwAB8Pnc8CQWvGIF5RDb5ofHevqeDI+JpCfnX1kI4VsRnkmaFXxt/XHAzf8faArLiZdl3qhnpuxYe4scJ1BJvaexUqcwvyVKPyT8AOfYfBRchvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QIpneJD6m/S/80aesbxQwAdUvv860RySfeuq8k7Lt4=;
 b=Y9g/r4/v415ln3i28mJchMbC4omdwuk5YKUU0NddkB22i2pm1mgLG5amOlY3/3V2sF2WvQk5ekxaikGelXXpBkGyLk6wQzRpc5MLAvG3nN/pqwJwfyK1JSNH+WXBXHawKdzc5pW0qIuR5XTO6i+Ix0mmkflQEP3XqI2ZCF6fjD+ehGq7W1U4/MZfGnRc4bf2OB4Gmd19rmCifm6IsPD0HXJhN4aj2tcGTrO8Sr42YoLxwXp8fy4dH0XP0RU9p+S5aPiT8dT5d5d3NY6zCAMidw49KOpsUstmfNY0EDttvKvpiIVllFcSMCZ6JueXTXZJGvT1n4Aq9H2UtStrXv2Jlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AM9PR04MB7713.eurprd04.prod.outlook.com (2603:10a6:20b:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 08:22:44 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 08:22:44 +0000
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
Subject: [PATCH v8 net-next 01/15] dt-bindings: net: dsa: update the description of 'dsa,member' property
Date: Mon, 18 May 2026 16:24:52 +0800
Message-Id: <20260518082506.1318236-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518082506.1318236-1-wei.fang@nxp.com>
References: <20260518082506.1318236-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|AM9PR04MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: 744bffb9-dfc6-4d33-3578-08deb4b6a2fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|19092799006|366016|38350700014|921020|18002099003|56012099003|22082099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	+4HwMVhDXdwA93eHeUV3laDFeKZWq6XQr0hwlipljv8pbFhOTurxtCrdYORxLdn+pkhXCUkLpyKW1j8Vse9KW3JWDk4gY1/lF2RUZD87PF1QyljAl1C7iwUJx2c6rBE96ZtSHrF94nHqchzU/P0KDd+w+KO7174x2g3Q7puEXBscSVQSi0kZm55TXNCzuOa7KtMydCLST8dYpJ4+icQ3Er6Z1Hlh9MS7BL5u75az9AwNVLdiYOD/zPYn9OUhEMd/snwr/qC/M3yyzmE9JLb2itUQnEtt2+1n81mT3G0Ov7kawFpRtiY8cBYnnNgDWlBbSwopB/U2PipR867q+MPQ1YfLcrB8NfoOS9KkfLPQdVfZQvloLRccqo5hK7Osdg9yF7cqoZAzMO+tVYqIUl/LJeTLMDUmMGzh8HCRhs25OGsgpzfxSYDkSoToKjoEKsXUcRSpU/k8gHLVARSTP1jdrNG7LlzzKZ9yy32EKGVGCOur4n+OhGPtgtQAr1IGq1GVX7hzoq4kbQRFFbcJA2XiWX57KEvhUzzIUsuI9SujyWdaKsjN7d2M12X1o8pz4KJIeJ27NAPshaOc0W1LTYvAJ6CmEUwX4+8phVzian/WdaCbHKs/V6vyCC0gFI8LC+PmQqachdggGZU1teJ/yfg7L5CXIQn1FSuOGEGZ4SMoVicOQlBmXSQpJ1tzDnf7sTp2853iSmu6abNumxU4askONXp5DzY7EaBKqdmFfcWMWNIddphmECXeVPtbCg+8wg/ECai1T+pqpn4qFlHvfu/Agg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(19092799006)(366016)(38350700014)(921020)(18002099003)(56012099003)(22082099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YUJnZiTMr3HuI2S96zP/I9Qjaj2exjiv2NbhPqIKxGqqdSUhbJS4dE6bvIXN?=
 =?us-ascii?Q?b4zAtyphDykN0gnLcTxAx/f7wcgw/kM4AfW5Pb09qoizrK0EkPMaWIybcxT1?=
 =?us-ascii?Q?HRKpJnwee/+ajKF2NREuP+7ypkpg/RSlz9bYD8ui7VJI0M2pdEXGiCX2V48i?=
 =?us-ascii?Q?zMC8X8yyI46Q5A68agZCtCKzGtCmJqwvdBiaU8LJIA0xgLdVX2UzeN/Qb2Fb?=
 =?us-ascii?Q?JKfhPt+Xpa8D90kK7zipEsiwHuiKV1CMHznCGHQGGMNpPU7DPEUGx0D9dBmq?=
 =?us-ascii?Q?RtaPZOh0F2PJEw7pv2OYF32UN4MfXTF865OtUz8KVmyLbkMnabS/ziXGDkBJ?=
 =?us-ascii?Q?Ycndc06WyoVl4g14O22LUODx2qj9/og830NSyP348h7sBJv9FGrMgMLVsZOv?=
 =?us-ascii?Q?qL3DxuZSWVTop3t0Y9fjyht7E0xyH7Z6NuKP9P671aYAyjEQgUElv6r6T7MT?=
 =?us-ascii?Q?3LXZDf/wlnQ3dWnzo4Kk6kchsRMBrenOutfh/Qr90y9DPY9KVtRa8UKlLBXI?=
 =?us-ascii?Q?YP2oWPmV0Fd/YooZICYNZtM4b9gqfqsQEMPp6HgHZszN4iUIAeUv9D/tqwIz?=
 =?us-ascii?Q?Gnncho4QOkqC+3KsPEWPaZE9XvWncfB2eA5R7GcFCwHZIsYIE3UFzbSOOTwU?=
 =?us-ascii?Q?00tWmNWfO/XwOdmmG1Q1ENtdpPCoV9ThF4pMtteLZkvFGYTcq19YpKUwYpNH?=
 =?us-ascii?Q?OlPsp0AJVLVjcwrGAHVxd5AOxHD3BJo64bLiq8rnkKeobt2sDtLSD2BMLQYz?=
 =?us-ascii?Q?vEr3kscKg/RisGQcJziy2DzHNzqGJ+aO0O4hor9vHxJC385RrpBGP1jaBfux?=
 =?us-ascii?Q?e+l6eaictNZA/EHZXG0W2wF+GU7ViDz2uTx1EG6yDRknVnkMbI8Vr0U1joXu?=
 =?us-ascii?Q?l1hrHGs5xx6/MsZo0sXsUbFTAnZcc+kGP+meUb7fuWd5Rt06CEkJ/dC7oe99?=
 =?us-ascii?Q?RMoCz6Eb6Q1R0ipNK26gnAw/dxs03C/UVVLC8AKWvJa9gT7di0V80+ld01RD?=
 =?us-ascii?Q?FSp4l+f4Y2b240tg+CbCqltlE++EfmCRu+IGdvBQuqWyxR+X67dihLE2OABk?=
 =?us-ascii?Q?Qi8jNXdmw0qOXBdV7j8t0NV+6OVGLhgHoM8bT3/rOHLtCNoNrEfbqCz0NVVI?=
 =?us-ascii?Q?UvexDhyKkI2Xxusf6FzWCPuxXvZyhBQgOixKkwdxZv6jSVy21l+TtO+ni3LI?=
 =?us-ascii?Q?wc8H1vsGP5CxBl4aaSoTraa+UpHQ6Frg1nNqIAltmTezGubb8H55fUluKpHV?=
 =?us-ascii?Q?fTBLAbSugrRExZ521Vi0U4XX7D09Fg2CzF4bel/17hBHZFjQwEK+a3ePPXY/?=
 =?us-ascii?Q?ZxzAnWC5wso/SXfn3ESe0AbqbPDuebU73O11FUKkhAOyHBKMYcjlowSR67nm?=
 =?us-ascii?Q?36gMuwtUVjUdbdXNkbi2C+DoKtUl7uU2BYlFxWH4AGkuaSCeZOvns+COix+E?=
 =?us-ascii?Q?H6UPt4HSYgDrEoyaFWTjuFzv/rf8KHk1CJBwWUMDp4SWTP8snREroSs478PY?=
 =?us-ascii?Q?+BoDqybKuOaa7+nXYIzDeu3x8zVm1qqPnNZ6yRW+IMFZboOTuIkmCsFDvPED?=
 =?us-ascii?Q?Cf+Jit5Ao4kXb3wE37Zd6lnQK3DTadtFrnzFK5FSVp8QyHjjTH9kuf5POCw5?=
 =?us-ascii?Q?iTrbzt6JDAT8AwIM1SW9/BT5XfGsihSe27uP7YzvoC/htH0eyYfVPuIcnjRu?=
 =?us-ascii?Q?sakni79IEU1HlkNc40Q84sJYQSbIY7RfPcDvhXXwJqIgDsKoLicpbgn6mOAf?=
 =?us-ascii?Q?QhLcCxXK6A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744bffb9-dfc6-4d33-3578-08deb4b6a2fa
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:22:44.7069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZz+qeV78slqeR8hHxLJfZnkXgo0GrpTm1PIMYxtig3MeWl3XGN3mrxOm5y/hnRkXeGH6y7WqnAz2SZLvIKkwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7713

The current description indicates that the 'dsa,member' property cannot
be set for a switch that is not part of any cluster. Vladimir thinks
that this is a case where the actual technical limitation was poorly
transposed into words when this restriction was first documented, in
commit 8c5ad1d6179d ("net: dsa: Document new binding").

The true technical limitation is that many DSA tagging protocols are
topology-unaware, and always call dsa_conduit_find_user() with a
switch_id of 0. Specifying a custom "dsa,member" property with a
non-zero switch_id would break them.

Therefore, for topology-aware switches, it is fine to specify this
property for them, even if they are not part of any cluster. Our NETC
switch is a good example which is topology-aware, the switch_id is
carried in the switch tag, but the switch_id 0 is reserved for VEPA
switch and cannot be used, so we need to use this property to assign
a non-zero switch_id for it.

Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/dsa/dsa.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/dsa.yaml b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
index 2abd036578d1..801e1411e5c2 100644
--- a/Documentation/devicetree/bindings/net/dsa/dsa.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
@@ -28,7 +28,11 @@ properties:
       A two element list indicates which DSA cluster, and position within the
       cluster a switch takes. <0 0> is cluster 0, switch 0. <0 1> is cluster 0,
       switch 1. <1 0> is cluster 1, switch 0. A switch not part of any cluster
-      (single device hanging off a CPU port) must not specify this property
+      (single device hanging off a CPU port) does not usually need to specify
+      this property, and then it becomes cluster 0, switch 0. For a topology
+      aware switch, its switch index can be specified through this property,
+      even if it is not part of any cluster. Also, topology-unaware switches
+      must always be defined as index 0 of their cluster.
     $ref: /schemas/types.yaml#/definitions/uint32-array
 
 additionalProperties: true
-- 
2.34.1



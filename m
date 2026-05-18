Return-Path: <linuxppc-dev+bounces-21081-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D510ACD4F55
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 08:23:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJrQv6Qlxz3bs5;
	Mon, 18 May 2026 18:23:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779092583;
	cv=pass; b=D8FrGXG8nY4zc9b9cUNDVCYmtsaIUNlh2Q89Zkmekx/wcFOC7FWK5r6y0A3zgglb0xyKPqj0Gep3wu/VkIopAs/yO/xt6Faali7EVPNJ9EfY2xFwQ2Kap7qAZiGriz6dpKiwJg3HFsgWVu554EEZ+GgSm7sUPtx2646X8l0FOt8oIPeQPonMFuJCd/tdrVFb22jr/EG73SDf/neLwEm+E8vP4oM8sSAo4aq/KzofiNeNs3UT6lJ5toQIPfP9v3xMAOpydrd8mpZWvmv2+hDavA02J7AH6j2S4evv0/DPkLsqer9/bRAp7uKg9uQfhrAAxXtarH0jCiojs/RMar7V8A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779092583; c=relaxed/relaxed;
	bh=V3voDZ0BuJ9tq1vIoWPDfpf+3DqJH36ktgseQNif49Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WPepb+5AopuWMgmEZwf2KPwdwVtdzUOdkLkXzSjY7CR21OHWkCPiIz2dSM/Q/Qh2YOxSxKU5AjPQfPV2CdMe1mEVomEll/kNJIZpUAXJ7MVRTjeZaiBGDA7oDwGpXPOdW+iwSQ9uielu2x7lyqMJFPMC2ZGb0CL9UKCzZSOEZ2IpEimHs9VEnmvQW7FbSOCE560JeHkjJhCe6too0ZGct9GHnb0bjTIvaUtFVJ1N3NBqmEKFfuD22m7Kyh6cdKDU0uh6EoF4mWmOeZwjNKLDdRqg/gYMbGreuR1xAkoMvBOsdIAILPiB2zqqogya7sdV7C1CcGWM1AClAmQuFx5icQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Bt26xTS3; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Bt26xTS3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJrQt4Z9zz3btk
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 18:23:02 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDC2p58OW9UF42LyVUx/mjRcnNIT1KONz9KFVJyu0vlAUukuUf71P9m99rt+K4UBZeOIagHnjTolRzs3dB4YDOg75EDTZrhBtaXE/07lwee4wZ7brpqrjAKTmq7c3nw6k2IDRNy9T8P7anKF9tRdxsoUU0SqPrE7wz4yzQJMgKYHe5RSbGMn5C6dGA8DWUWjXYQZWO7hROogn82Zv39HxDUf/B5eOZK2ov+iHLJam9QNYpCxCcNtId8ec+/JHsssTUxJIugxM5z9/7ADAnP6dbnXLBEFPFbo10Db/sWkejP0l5Sdd83AlGiPSTkc8xhvkpasWXchJU+z+T22XGZLjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3voDZ0BuJ9tq1vIoWPDfpf+3DqJH36ktgseQNif49Q=;
 b=Tf98lgSH9hJ0El7JL7FIDQ9Bue+VIDmeoPF0nhqCU0MkdxIpGZmiFXY9X2bmnR24kg5EpecKLaL2Eiq9v00TI6XU04/XkDs7AXIdT7vfPXNAcnsfNLl6iC7Y96X4atWbbClIbNYD0YPvLPzkioPlOcVN44eqODyEcCXmc7OmCLJsB/qNzzUFQVF1s1hVQXkuA6crJSjVN00WGa3n1HHEbhvv0ZVIAzUoV4Oq95lIllzIJ8wVdg67OvXQTiaWj9fWDSa4Bg08XnM8KoD2hd/KrMmAa0h5g6Ir5wK4evmlfW2jfXxoqMC1lpXkog+d1riylrELq4JhflD8Z6EA+FU0dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3voDZ0BuJ9tq1vIoWPDfpf+3DqJH36ktgseQNif49Q=;
 b=Bt26xTS3MiCtCU+BttZpR/dupEBs5hm9ZksU3bFW95CZr2lruNdaQy0Zj917eTjnZv3+pF6hG2XRE/wIu1ZfpmnnLbDuwV4BsKsnLyRJteb+6bTweNrmWRZGJi3O5Wp3DqI58v7zrZrQoq+Tm/eW30LScuDBI0SwZHOGjjHVjJasVFX4IY1dPG3L0ZsJXYBwCzN+gDk3QFhrMcK6PVZmNp4I1eaTSvZtdxUOfMeHpPEwCpY/tAoJ3Cb4MIPI+qww+tjoeZ+STy8DmU1/tv3GoAyAjY3wX1ixD5GoBZWG6NhbHH+5LWN3PD6/BEgeMNwXmDsknU6n1fyHViqTSM0KDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AM9PR04MB7713.eurprd04.prod.outlook.com (2603:10a6:20b:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 08:22:55 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 08:22:55 +0000
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
Subject: [PATCH v8 net-next 02/15] dt-bindings: net: dsa: add NETC switch
Date: Mon, 18 May 2026 16:24:53 +0800
Message-Id: <20260518082506.1318236-3-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 73c55c18-6a9d-41d1-9799-08deb4b6a97a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|19092799006|366016|38350700014|921020|18002099003|56012099003|22082099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	8esSNVk2kVtnmdYuqAvfHPVePDagEZCuP/536ramnMjbHR9J/O5iLN5zjBDzbboNLZGYAxCNhw6v7LK6YRNc7VAP+knWKVL1O8NE03ocanU9LRWRa8ILws1gknDtnZLcr1o+4ovhXg7xL76zLiLaFEVe6gRFa5qNgILHx+l1WnVBF7yGOhfu0vFR99O6SseuyaxOzDL7BA4weMQ7ave+Z4rAjme0a9ezxqpPGcYQBJmASjDKJs+XwUac0mEm6pmkrDGGcCLDUVwkdIMkgITcjzMyK6t4QvGtP6SDuz9ypiPsbajiVesTvQtFVtUf6vASritn1RQwpDknMmRE+GQGAoi7RYrhJ9H9uIwd+2N+rCnwAnZVdGkK3hq1ZpUlHSvHvjUMYLHag6b/l1IvfBJwzOUD0cIoaXZwTiJjxf1B8yM7PYtAghL8q+FQyo9KPvD6sS06eM/NdwjBAGOIaKCcg10uOB3xjtVM+L47Q7KGz/bbRE7egO3Pp+APYiMHf6mKON5gNHwvhaftwTbFzLhDABKS5Vh99VAlTmfYtqt9X5pwjkThHZMixt/lkD0FWe9TcngOQPtCDRsYXvtPWsqsOMg/Ymi1zdp+XfniDclMS6OUsNteOT/CintjitM+DRMEnPWMDZFhsfd+RiRW+WWteX58UrQl53by0ey6BjAHLR8Q99NzrM8XR6aVOeMkf1eBEJhyJVxl7uJkhSj/Vvo79A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(19092799006)(366016)(38350700014)(921020)(18002099003)(56012099003)(22082099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gsmIy/+UIA7k79MJKugKhZyUQ2kzsQkPxh1pCyv5bnRvJRIFOTT8GODzJVi1?=
 =?us-ascii?Q?xl6hbkuVnZyjL16otzS7CecDmTfxAbZsvgjet0S7gRbvOzrXpLjva0+LIZRP?=
 =?us-ascii?Q?slBLHq0K7ygwOsgrvpnl81cNEYn6jQ1RlQaZSlxiexxB7KKJ7KbFFqUlvo3P?=
 =?us-ascii?Q?N2rmkb21klbskXCGypH6WYsUWpUIS3rLCC9JbaKTxnTet27FahDVuydRHw2b?=
 =?us-ascii?Q?BaOQL9/g53ZC5mv1KIivlgJULaenKJ/aczmwm7TXEPZGHdQ6ESw083t8DH02?=
 =?us-ascii?Q?YPg/LpBtfk95wsKx829BGwif3Ytsw1OKDpiFxWb1XZHOxl6tAtz+HxlWce3E?=
 =?us-ascii?Q?92PfVgLByPvLxLpilmHUrwkFWn1N9lI2XRsc0c3RQwfSeazo6Hp5qpKyAFWa?=
 =?us-ascii?Q?PyfiQ1oj4zZmP7s5s78rGuHetbnTyE7M1QEi5GLrgRxWn4zNfRWtWOgKKvR4?=
 =?us-ascii?Q?G7TP0niYEdNcevxm5Ceu4jHu9XI2Q+ijUu5acZaQgf5yg+PC/bcDN5Uvtj45?=
 =?us-ascii?Q?lmRiMqn6DhsbMtEQLRJqtKvn5OnxQhmloeh843Fvzq86gSQ+Rw0fpH9AIeDJ?=
 =?us-ascii?Q?LrCfTPMKCYlvymx/hMrdVl42oKLTj0Abo2xYKHIihuMbBOmOeeqUjhFdAl8i?=
 =?us-ascii?Q?sgrY4otcFfvedUpFWlgl/RYBAsJgjpS7C9pVcCV/6i+sDEMs08ZUfaLeJsK9?=
 =?us-ascii?Q?SsKzySNQzBVj6QBsxg2pvCTddwxvqN0s7Zm66OJadovHWWExaTiELHsZrc0M?=
 =?us-ascii?Q?yORWY9CQwHWgsm27nVar5gXbOZxfp2w8V9QkG1IHeTyWYfiIzGX5oUjhXmal?=
 =?us-ascii?Q?MeUIT3+aHvZOLWeCP6bZMgMoh7zvAMLCVxAkn+42EK+vzJweisAfeosE0egX?=
 =?us-ascii?Q?Bd8N6s/6XK+Tox1/wjPPS02OxMOQjaafbNVxPcBmB1fVSAsJrJfVPkCoGp72?=
 =?us-ascii?Q?OQHrjKatKjDjPojUaU96Zxopvm5xGenqPDZ2tD2MzSAepkl4Ely4XUtHxQ1h?=
 =?us-ascii?Q?lv5x5D9/kc2Q5tA4A5gQte0+doNwbrTdgpH1zATLWAfRlPnagu+N3RiN2pls?=
 =?us-ascii?Q?hc6lK28JE6T8Uy0Hn5LSxqpeM+cAkUTy5NcXWrNfBEQ06/VhICmXEAXvXoSC?=
 =?us-ascii?Q?GqVC+FBUPGo5XKYXrnGujuc7fV8WfD0hg/bs6p88yt4Hi0jECGIfL9g5O17F?=
 =?us-ascii?Q?jda+Qw0HZulRKkkgK4HY3ohRNUw4RkF7CUDg/758ptRGZARvq9TKrNMG5W0o?=
 =?us-ascii?Q?QooHaZT5vILdPUxy7vMvlIHC/jd+uPouQU6m/g68iJni/VuTEHkX80nxrQ02?=
 =?us-ascii?Q?U79wx5Q2P2yIDXQ2slxqkNGocBVJnNxlHSwrIQL1/384bXK10No3qikPHg/z?=
 =?us-ascii?Q?a57cl9brSvExdDBHTc6gHFSJTPC82wtBTKNvKrSMepp7uuF9ZH3nvnexfiTY?=
 =?us-ascii?Q?y+MYsDBz82TZ+2WR3MkDjZCCVh33RSevVaAZ66xUhewikte7SugAg3AEh+EY?=
 =?us-ascii?Q?uNbAqGjZx+kLS9ILZx5C3Be/gj8ThkwUjf4h/WTyrDbiDLrhJo06IiZuDJg/?=
 =?us-ascii?Q?Q5W7jbyRoTsJAHj4tmTfVS/YWQesjwZb8WtIVJgDPg3XZoxMA46oGAzETHSG?=
 =?us-ascii?Q?vNtaBpIOARMwqzEUSz1fF0NSa2B3BWLVdNIwr98kKfwELvL16fvrown+KBeZ?=
 =?us-ascii?Q?8hzQx9y27zMNJ1qidDZCmLN3gV7WEflc/xhIKIbmjuzb5LqzuEsijMc8Dmgh?=
 =?us-ascii?Q?40ACrp8Xqg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c55c18-6a9d-41d1-9799-08deb4b6a97a
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:22:55.6505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFbonSByiE8f/OaakmUASXl4QPQfBYMrqEdPCQjybPyKwLoFly7W0XvQFZRF9rVb2cAt65d/S7snmrDUhnFnng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7713

Add bindings for NETC switch. This switch is a PCIe function of NETC IP,
it supports advanced QoS with 8 traffic classes and 4 drop resilience
levels, and a full range of TSN standards capabilities. The switch CPU
port connects to an internal ENETC port, which is also a PCIe function
of NETC IP. So these two ports use a light-weight "pseudo MAC" instead
of a back-to-back MAC, because the "pseudo MAC" provides the delineation
between switch and ENETC, this translates to lower power (less logic and
memory) and lower delay (as there is no serialization delay across this
link).

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/net/dsa/nxp,netc-switch.yaml     | 131 ++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
new file mode 100644
index 000000000000..1b35e4cbd049
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/nxp,netc-switch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NETC Switch family
+
+description: >
+  The NETC presents itself as a multi-function PCIe Root Complex Integrated
+  Endpoint (RCiEP) and provides full 802.1Q Ethernet switch functionality,
+  advanced QoS with 8 traffic classes and 4 drop resilience levels, and a
+  full range of TSN standards capabilities.
+
+  The CPU port of the switch connects to an internal ENETC. The switch and
+  the internal ENETC are fully integrated into the NETC IP, a back-to-back
+  MAC is not required. Instead, a light-weight "pseudo MAC" provides the
+  delineation between the switch and ENETC. This translates to lower power
+  (less logic and memory) and lower delay (as there is no serialization
+  delay across this link).
+
+maintainers:
+  - Wei Fang <wei.fang@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - pci1131,eef2
+
+  reg:
+    maxItems: 1
+
+  dsa,member:
+    description: >
+      The property indicates DSA cluster and switch index. For NETC switch,
+      the valid range of the switch index is 1 ~ 7, the index is reflected
+      in the switch tag as an indication of the switch ID where the frame
+      originated. The value 0 is reserved for ENETC VEPA switch, whose ID
+      is hardwired to zero.
+    items:
+      - true
+      - minimum: 1
+        maximum: 7
+
+  ethernet-ports:
+    type: object
+    patternProperties:
+      "^ethernet-port@[0-9a-f]$":
+        type: object
+        $ref: dsa-port.yaml#
+
+        properties:
+          clocks:
+            items:
+              - description: MAC transmit/receive reference clock.
+
+          clock-names:
+            items:
+              - const: ref
+
+          mdio:
+            $ref: /schemas/net/mdio.yaml#
+            unevaluatedProperties: false
+            description:
+              Optional child node for switch port, otherwise use NETC EMDIO.
+
+        unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - dsa,member
+  - ethernet-ports
+
+allOf:
+  - $ref: /schemas/pci/pci-device.yaml
+  - $ref: dsa.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pcie {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        ethernet-switch@0,2 {
+            compatible = "pci1131,eef2";
+            reg = <0x200 0 0 0 0>;
+            dsa,member = <0 1>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&pinctrl_switch>;
+
+            ethernet-ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                ethernet-port@0 {
+                    reg = <0>;
+                    phy-handle = <&ethphy0>;
+                    phy-mode = "mii";
+                };
+
+                ethernet-port@1 {
+                    reg = <1>;
+                    phy-handle = <&ethphy1>;
+                    phy-mode = "mii";
+                };
+
+                ethernet-port@2 {
+                    reg = <2>;
+                    clocks = <&scmi_clk 103>;
+                    clock-names = "ref";
+                    phy-handle = <&ethphy2>;
+                    phy-mode = "rgmii-id";
+                };
+
+                ethernet-port@3 {
+                    reg = <3>;
+                    ethernet = <&enetc3>;
+                    phy-mode = "internal";
+
+                    fixed-link {
+                        speed = <2500>;
+                        full-duplex;
+                        pause;
+                    };
+                };
+            };
+        };
+    };
-- 
2.34.1



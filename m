Return-Path: <linuxppc-dev+bounces-18223-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777A9F4643A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 09:41:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ97m20Wjz2xpn;
	Mon, 16 Mar 2026 20:40:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773654052;
	cv=pass; b=K/z2jGJN3uQaM2VmCJ3wCuKt1Nhk+9TPJHhPJTZdX/YJ/XwU0JEoipzl2poc7IEX4TKdRDe1ipaBpRudYfe5v2LLJ94bDn1Y53S42tRjA7sAjaNUWP0uevv/0z9HYB2lH3wrw5A7os8bO4z4wNg3KCannTybs48ABWi6cPs/d17o6Vw/QthRM9n7fI/MvT9as7ZzHz98RBfp3mIRch/ptaFo+mXHPsFPMr2ZVG4QXc4pbfFuIUPJL2A/VMEX9R09boaLUZVH9yqmG4jJog+HSE0FFBfnt1gU1aGAJ6Mue86KuETm607P3v9hx37ASvf6jTfOzLbn2FHEYIqexvA1Eg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773654052; c=relaxed/relaxed;
	bh=a3lA+buWVqvFbhrL4R8YakAI+mmdhNbJ1BspEFt/csw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YqCD9w2r/poezLi8zSBiDnL5Zq/gcz+xO7t9Qwy7sV1R5yFyhmFvXhTfvgt8EtQmb8ktrlCEY3xGLeCTJ9HuiQTDNHp0TyMbIqXvkBanbtOG0U/keF2aj2z59p96oA8Susi275BbsIz36Gr6DZxqoc/0Ic1ibOG2Kw29Qp+HDfPWjlnbymvLhAdH94byIAa63pQUeBf39Hlvlxi6wO3waWbGG3KOi8nT53ISaJzdLgl8Fx7XgRwWcZ6fStfwBN2CbSTyVXqc0f5T4dQyMKMnCibnr0zpCx+cha1Tlh3F4YyfVO5Eee+FBFDtE4lCPH+zmYICOfBJJc3Ia7cFg5p8zg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Wh9pxQna; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Wh9pxQna;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ97l31M8z2yjn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 20:40:51 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtGc9CqWmkMSkd8bnlvO16B6lUeJ/ZmlIz8dpAeIvuv3di3ApOdCJCMR0Zhd5bKzoOpP1PwhsiakwXxmW0RaqwmVB38o4kWgbWK5ct/yiYx3MU3UpEypTJQ545DXnp3vFhf7/NOefgZ8i3rWqT3PYXdsQx6Kxa1cdtC+z+oWeq8b9ngGUlpllyDCoTPM55NLea/v+XnIhYqzLD2l87T8PEDAYBBYfwNxZMXRD5zzDmJPA2RxjpCPaUuM7wPAX1hgzwOoBL5E+hIDGpTFHmeHIC35qopkCMhDWVwAK9X6mlIWEDjox8gr31myXPOLoo/7WFehLSxcIuheTOyjCPOlGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3lA+buWVqvFbhrL4R8YakAI+mmdhNbJ1BspEFt/csw=;
 b=SFK1gt1sBpEKsV6WHyFWXhEsaZIYwXool2ds/ZOxEYEd8gYGaPAmjstHSzBA46mam5sQgBsNDjUNYvxPzCLzaJhpqq7KE/1JjpJfMlbH9+06k0TtgG1qzw2bTxJR+Ho1ob1jzIzZ2Ab5RiA2Fw+kkBXq4EhKadxSirfhMGoBtV/8gr8RCuxYGutm8pGUr32zX5moXR0hNT1FIc18GcdonoIc1MnmMLLGAHQb2zbcydq3lT2YDeW7hZH474H3twCGMYWn9V06ZP7+QLm4f3F6ULYzoguu0yAht8R7Jc4faIMRxB7bP63gCqmoc+5uPG5FMQXnUPsYRVBoZAsRrlmWdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3lA+buWVqvFbhrL4R8YakAI+mmdhNbJ1BspEFt/csw=;
 b=Wh9pxQna3jPh+kABylJDAe1KCbAqaDg2NZjBI+oVZIlDV+6nU0Q3TS4P93MQUxkF1o2rNOkbqnpBHvsc+GrWgLgkLse4clJfuZF7jIfAY42wQiS/GEaRi2N0yHIj4KRynr2vXtintruiQ6vEXea6fhFXlCPZEJihQVGWoizAx7lu9aJeFzA60msvrmx24gZKUqg9/vd6/OAP4knFHK0EqLfZd//HNQyAozrPCtSsGdUpkD2ViXEtE7eirPZcnhITTYRr5JuQgmdhXk7IaViGQixpw8Hm6Q1RmylYGfQDOdIY5kvfHMsxBDdBPYlsSvZ2yXtbQhd5g5Voflxl43ULog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by MRWPR04MB12119.eurprd04.prod.outlook.com (2603:10a6:501:97::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 09:40:30 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 09:40:40 +0000
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
Subject: [PATCH net-next 02/14] dt-bindings: net: dsa: add NETC switch
Date: Mon, 16 Mar 2026 17:41:40 +0800
Message-Id: <20260316094152.1558671-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316094152.1558671-1-wei.fang@nxp.com>
References: <20260316094152.1558671-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|MRWPR04MB12119:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1d3a13-fd65-4f3c-29cd-08de834015d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|52116014|1800799024|366016|38350700014|18002099003|921020|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	p8XH2+yJYqsDc+BCUEtExD7oDScg7aWLompbAD2sUlx+AGT/TcphRoSRmftszYE+bbHNmY2McFSXRxFezwAafw+e8/Yj/5Y2RySikweEt/u513JGtsJ+WmkLvouh3SDHOCrE5X8IVhJbiJZtXx/oJIca5w+rLXmDXivSKnVC3S6s90zrVN87k1mypBHNUtRZBQ9Egx25zD2CeI02CSysr300klIVXzRgurGPQTjcQlPlv2ilQ1vJB1/gqjYo4wzBDYCnNcPYB6TxI59EULvEq9ojAwmn28Agwpzctr4qkyVPLZqJP0NIpERX2ABgd0gdJmJirtQJnTL14WlX/60J1V2CRJ10257TfimuQ2u0/Gb3vISZaLvbCmqt16lF+Z4d8sAiU99niobiOht6CPXGICtfdo47iKCrpPeN+zLY3PLfbQFrv3ZEbMQF70jngTRUF+qCmYhdd5yz06DSLqNOoXeiYE/RwJKzW0k/iwVsXzrs4e3FK302vLZT393PVlOyNcjeOTkrrWzNlzjh6gtMuFM4N+NQD/gC41mPPLWjPUujx7cfEz72oBICJbvbpGpaO74QmZ8oA9mONk1J41yfxwpVcdG/AqbF3Q3FSspaH434JNFIJHhBBX7yi1kDpP/HnbyA8AY5v57ySKE6a8F8ilAuixIXR3MP2r0NImzuF74ZRI5pBgHAaMiIFodNrt6z4yfRtsecNz4OEUzEpmIwrht6TpnRm10jkjUVz1l751B6IyxYOvMpwR+7OYzhX1IIkz7p4RN8CD4LBK36C0KdUA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(18002099003)(921020)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zkZJtCnQXKA0eyE5D08crtMiY34GzcjDAp1CiOi1JC0iQslK75EPdsjQzcxg?=
 =?us-ascii?Q?+QOdd36XABhyWBsm/3rNn8/HmwoqurdieVcvHIX1FNPTOaaBbGwX001IOVBM?=
 =?us-ascii?Q?tL2eXBim6KbErOCcbrPoO64TzoLWfJEDCpSQMD1TpfIDH+48dv9KE2aLf5w8?=
 =?us-ascii?Q?uBGlxAIyEmZvCrts0VBlRBRMtHMqvmlFplPN8oLokekc8aM6Wr1DwizpEQtz?=
 =?us-ascii?Q?6kwOISyzIg3qpeOUrs6Fsj4HGXPtFwl/Q0PpTWTRpVm2U0TuV8PHDCP+SMJG?=
 =?us-ascii?Q?3IIIqgHzw8q4dFn0OU1/ZRbARgcG8/ay+gGncGbMD8jlCac3cSPtzxtrNfi6?=
 =?us-ascii?Q?0P6lwqar19Dzx7mAh2V1YUaHUjWXY0BDKQceQPQ9LZEbRrIJZ4byBwmtVb1G?=
 =?us-ascii?Q?+j0QRWdA7+5C6NKxVcNg81yqqviww+X2ZvPngcSn3jvof6EJSKx5oDhohImy?=
 =?us-ascii?Q?NWy49tk2cuePs1XW7EXRJvon9mq/ydwzYctsFzlHn0AcPe8dtQTmFAy8R7BJ?=
 =?us-ascii?Q?bYx/RVVeS/dNKtFtZShKzW11x+WykjTksYZ6705quEzD+nYPnRRbzC5ZABQV?=
 =?us-ascii?Q?R1gkHzMb91lvKooeyeSDt87DstodvQP02cGgZx1I+yRm5DzHyAchWO3FxuQL?=
 =?us-ascii?Q?XaL6jVKVPCkNJw+2gL7lgG9keE5hsvgRDURRaOdY685AScLqZwFy4np48Bil?=
 =?us-ascii?Q?JTudUJF/sWK2LtZ+w8rscEcJmWJiLaINbTzoN2liCGF7MoZ0CRh5oBkS/fPP?=
 =?us-ascii?Q?1lqJPW2WuHmin3fjM7NZmOJX8oF/IuAlp3Tgpcqb/VeZhPjHBhhB4bOk7dFB?=
 =?us-ascii?Q?4Y7hJlM7GX4xL9P2GsrQoyTE4B1+73C1cNUP3I4KS8Q8iMTsaK5/2pTGRSmd?=
 =?us-ascii?Q?jh0km10o0QDeBHAziMj6P9db1e5xmC4KELQaFNuQHbtSey1CJp590hu+YIYg?=
 =?us-ascii?Q?2LYZ6FwGst3CCOJ2NDI3+pj7D3U2HFNxqPx5qfWgL+c26vUUZPv73IXiwBGG?=
 =?us-ascii?Q?PBsiIdKCnqyewdxeFx3dAa66fx9PclTGienpr0sM5IKMmRseQZ2UiEqoy9vf?=
 =?us-ascii?Q?TmMRqJ9LERcW5aB5GnHStfK42iCW5Pt8nMGuBGExw38GFBpQR4EzVv2m0GUU?=
 =?us-ascii?Q?Zc86ik9HGsIM5uN7UNgvDZZlvLZzcaYwwPf3CDxsQpRoc7fQr7pMgJ6AIRoK?=
 =?us-ascii?Q?WAmy9vVJBBTPIgAoTq8T6cdFRHXEWowvIv3yijTaax0NvE9nOz2AGWHdpzOB?=
 =?us-ascii?Q?KsGwljy+7y0jjGwCyOUpPedfHH4MmdSBAgl9TUxOu+GleBw7yxQMBMRkfPWz?=
 =?us-ascii?Q?OltDEQaP8n/p2sVrBYif8c3sILFbXJbKXxNQrHnoPw1HpbiJK6K9RJSU0C7d?=
 =?us-ascii?Q?vGYkapQQpsu28exRczUWGnwXdnvFkaDV6QvECE2QDm62BAE/v9P5WvTpFkPY?=
 =?us-ascii?Q?MJZYirmN5avXCpGi+luHdtfAuKD14sxltYCst0B42QnD/mViMgc03o9wHx8k?=
 =?us-ascii?Q?xzTo5iak2eKni2sCAPK/P0Qx1hDMotCaOsLiywjh68CIEXE9ULXZ0JNJbmPt?=
 =?us-ascii?Q?kbVR155UtLM0seABcQUvmJ4GGkNyEZ4n12hwu/4wOXSN0Rg3WzBrGogtmlMx?=
 =?us-ascii?Q?UUx5eVCK/xlmQ1c0MfgvJ8412IvbTBKJH6EP+KDh82pz/Lsixb81D5VaEp24?=
 =?us-ascii?Q?66ioQECMSXJo1CpwZF3Lwi+bbMsez/qNMnqor4QPQFikHFd6daoe+nBYwkzr?=
 =?us-ascii?Q?RqtWX4tGwg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1d3a13-fd65-4f3c-29cd-08de834015d0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 09:40:40.2257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RrQBpY5ixGZttOQdk73RNDWvq6/aTxXL2PQBVXpNXSm2X9Z0/TK2kIu8p3pPsdiyeBMuXFNp5NzvViieelEFTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12119

Add bindings for NETC switch. This switch is a PCIe function of NETC IP,
it supports advanced QoS with 8 traffic classes and 4 drop resilience
levels, and a full range of  TSN standards capabilities. The switch CPU
port connects to an internal ENETC port, which is also a PCIe function
of NETC IP. So these two ports use a light-weight "pseudo MAC" instead
of a back-to-back MAC, because the "pseudo MAC" provides the delineation
between switch and ENETC, this translates to lower power (less logic and
memory) and lower delay (as there is no serialization delay across this
link).

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../bindings/net/dsa/nxp,netc-switch.yaml     | 127 ++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
new file mode 100644
index 000000000000..a0ec42923652
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/nxp,netc-switch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NETC Switch family
+
+description:
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
+    description:
+      The property indicates DSA cluster and switch index. The valid range of
+      the switch index is 1 ~ 7, the value 0 is the reserved for VEPA switch.
+
+$ref: dsa.yaml#
+
+patternProperties:
+  "^(ethernet-)?ports$":
+    type: object
+    additionalProperties: true
+    patternProperties:
+      "^(ethernet-)?port@[0-9a-f]$":
+        type: object
+
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
+
+allOf:
+  - $ref: /schemas/pci/pci-device.yaml
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
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    phy-handle = <&ethphy0>;
+                    phy-mode = "mii";
+                };
+
+                port@1 {
+                    reg = <1>;
+                    phy-handle = <&ethphy1>;
+                    phy-mode = "mii";
+                };
+
+                port@2 {
+                    reg = <2>;
+                    clocks = <&scmi_clk 103>;
+                    clock-names = "ref";
+                    phy-handle = <&ethphy2>;
+                    phy-mode = "rgmii-id";
+                };
+
+                port@3 {
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



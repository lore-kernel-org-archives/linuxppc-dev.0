Return-Path: <linuxppc-dev+bounces-20803-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C80CCD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 03:03:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFdZ02j15z2y2B;
	Wed, 13 May 2026 13:03:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778641384;
	cv=pass; b=AHcMEYaAsKPK9hj7NL4kVuf6M8FrdgQ6U7BfEBq6gtpaadnBZ2iKSAfOyb3MgTDUiBM/2ARbZ8jv481s42BW0eqFk5F6hs/Gvc6aF1RtFV3ojXRUJTCqakBNuHMHUZAcxZdzFIvElCujm/qH7dDC0KjY6Tj2Bv5VMTADQA1HEMu2mymU+HQN+tXWXSCTyg5uBRksYW+M4DahMXIHIPYQJqWYiIjj4bid+V6CE8L7KoFfLg+iUUWgasXzTLRPgcHPPt4MB7U8zAinWG4lVC0PpNXyedZFwN77B8ozbWAkOo/DAQKYpegQWUXWxXzZbY+pZ3Ut0cc8hZ2uwN+RASTS6w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778641384; c=relaxed/relaxed;
	bh=V3voDZ0BuJ9tq1vIoWPDfpf+3DqJH36ktgseQNif49Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ikn3PrvDgOsws8EWJ5GRNEg+KMbR1EKVDq3JZMOnEqT4ZrWlKxFg8kifV0WgEKZlnfIu8LSF3asp2tz4LQPgu3GYfomYs3/B0dfT1O9ypIHNkDyXt+Ta9ddfNb+cvgpmnhKAMfgt7FS0jekW2AblSPdfIA0r36U564vgd0/DiTyQJrj1dM5Z3l+yiQ84cSLZVcEh25bksqr6Qfvtu2PlFNq36Zgmq3vJAwv2bayoDofcxkhNOcn9aTMlIHH8EHf2KLNOmxnlk9uuMbzVI6DPLXBD/8Xz3lXgl9+2pNHkWnUCN3zoSn9EEI1XJ76w71EBSfdmAY6JiCY2wtGTdP5Nag==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=hAcfSV8T; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=hAcfSV8T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFdYy5r92z2yHT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 13:03:02 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s15tgoxjdk9WlfNEsW45J+n4a7IveqybcPvWaQCxD/acuH/F0EwPWSWGxydp/tv1OqEilJFYQv41RKfpMeWAH431aikukPpTkm5WKN9BZO1wmGFMaZwEve2IbgOv6KRHz+GivPH0O4c71lgPNfx1of859qVJmwJ3TZyGoH7dY5fJ8/zE/1c1w7u0abZkVplKmzTtW+tknkg0O57MkvO79R77yHLDNb1cRJlF17g9n/TFmBT6ERRRtAySZgxXyjCLQqYp/TwbVNLLfPzG6GgZavVBweFN4xO3tWVk4KH2GyVowk7t9e7EyHUCetsTfnZ5cVcCpr80eQjHMEDMy9KZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3voDZ0BuJ9tq1vIoWPDfpf+3DqJH36ktgseQNif49Q=;
 b=llmdKAV+sismq48xK6OFQ7w+Zs5IBQXldxqOBLj/N1OaBWMgq5oy5EhrZnQbyCC+K0i7ijCmHNj9K8LwyTgo5R0Rz8Jx7wYXQls+3P31mMOfg4uqHGKRcgje6b7NEHTOV71JDfGW3lhJId1IVnPw+Wqin3vfWvuJCN+PrliSuJ1gsfPHMy1PUtlTp2wFXOvVmDIiuLN1OW0u0CTMjOHoy/Ud4N0tUT2nIJjaK5iuFE4/F+iMAvI3JdqUZAJm7WLOsmk5pt608YfS446tLTE+jwqltrT87fcYQBU3eyQDJvuJQPnN8EOH2oD8Bwr2dMAiBb3KQK/Mt4OZME5V2YywtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3voDZ0BuJ9tq1vIoWPDfpf+3DqJH36ktgseQNif49Q=;
 b=hAcfSV8T+I85LA85DbOC6PmsQMDL7ZRGJU/Y0gHyW4JbhlbNC1/ox2Iqim//fa/xFTyijiP2u/PiDwgJKgF7V98k2t6uW9VYH4kwTHbbAf4dFDA6r0ulPTj/rloattLS6rEDsPO3pAtzJrLV2IbTP2tpfOu3SXFBo+CGFosReTDijDIG5RKM55nhqmzbqXrYX4d97dmwse90+pGosUOSudYtGfOrQzXpJIbzwoRvTUzrfb3J4jD+qg/XIvydD4A0zjZSkrUBBNn4FEoyff2es9roNLhSCfDwekYcMITIt+dkOZ8y0VR1TT15nVen2DiiOccdVnfCvqT5yAiBvU+Y0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by GV1PR04MB11525.eurprd04.prod.outlook.com (2603:10a6:150:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 03:02:41 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 03:02:41 +0000
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
Subject: [PATCH v7 net-next 02/15] dt-bindings: net: dsa: add NETC switch
Date: Wed, 13 May 2026 11:04:41 +0800
Message-Id: <20260513030454.1666570-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513030454.1666570-1-wei.fang@nxp.com>
References: <20260513030454.1666570-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0029.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|GV1PR04MB11525:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bce7a05-1b22-42d4-d923-08deb09c18c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|56012099003|18002099003|22082099003|3023799003|11063799003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	j0pHNRbaqPdBwW0Le+/8XfG6dRnJLKIU1gGJxZ9migp58I1mIPlcDhWpBUh3uNmsMFk4gPQJxRBrsj3nX1ej5UJQJd9Tgfvz5/zEqbJNihlyk5ivO2f0YlK11T/LQc2ZDo2BlEk+qa0xVIBtlwu37dtHiVA2LsExc0VFAqVWaqhtz13TFEGg8FwIxk90N33dIWYjtxQnymf3OPp9ViDxUrPAnqx7TwcvKZJYL3H26m1YbxNxDDjIRDLdLu6tG/uml0HBirgKm9qwGRrb3XGL6GEnL9HHFy+POq7v6PUGsjHcEaHOer+cTFf0UwiarP8/mBhcAo45eC5L4Rn98/ApTCrwH1CfQ7k+CDNoKPsnnx6OhhgzN3ZgPaUR9/FoYXN+6OCru2tbNnbjpbjl8tB4KfBmbHZgjMOQdLNlK/P2MhBo+fKxiwpmQeIZjE7E7riUPGdHs02ujdZEwO1+A0h9DP/iHJtZ+URpCs2SW7fRBMcYlyoyUGuzDUnM82vUAbY5x+ZmqkOZzSPZjRUHDzvbQbWMfv1d8XBAjs7n/O5Gihcuc4Mb6oQtzA9wv99RTBwv3TuyqLsn6iKGYnbS0alMUemBDK86eeI39oZTr8LPT9mMVCtqsJSt5b8141LJzxyGu2JclV8uEOGZOCGo5IasKVoRnIZF2MtmtK1n01H/bfLFb6xiheY9bSYrEZgg49ysXgm7SSEvpBpciw2FwT/qLw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(56012099003)(18002099003)(22082099003)(3023799003)(11063799003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?10Js8ELh+XyMgNATwnR2R4l2YOVu8s1WVJvvpAy2GT57Wf6HVAkqQqg36SUr?=
 =?us-ascii?Q?hl25rfCWYfFFx/mPpOdsBt6Hji03PC7RZ64F6LSCG7VOw7kqy6bX0vizhJCB?=
 =?us-ascii?Q?vzsxUtRqDZ4DAcT5V+XvgHFB4RWOpNon67nQzRNj/KKCB3mpK/MgVn/rArnP?=
 =?us-ascii?Q?Biy1k3JqMCFttoAiYqy3LSHDprm+I1hbyvUx9W2iMcSp6jO+liljhAHH2yIf?=
 =?us-ascii?Q?Dcrm4AOtjThPklm4NW3qvuo6u3tb/trAGdi5UAMeYbiy4Qfxrj8oKUryfpAu?=
 =?us-ascii?Q?o2vjjHXettJ6XM46SO0/pPEE+fpriMhqbaEKO7tXetQugoj0ozzyydTYqy7H?=
 =?us-ascii?Q?NHZluSmkZ846qYHEcFe+dRO20TOLVRI8JoEt1poTeT8zG8Ql3qX5caRnHlOz?=
 =?us-ascii?Q?bJSHXQRK4qiyIVFqFwwAm8nO1oK6E4Gi813RYVHbbrOWQod5t9hvG7oE4vJf?=
 =?us-ascii?Q?w7Mx5fijcHiRYWDX3DjaTpiHFspo0DsRwe3upL8OYuI234hwhUqZeZOotR+v?=
 =?us-ascii?Q?oDw7FjsMtIfFd7i3KPnNOsoQrdOFRflGZnooK+6BfENChLwFGp37mrUfnm3k?=
 =?us-ascii?Q?c1PUnb82bUFGdNl5m/wDVjG8WQ0GbPSGn/E5ZBKKvna9VG8rUgGNdbcar4OD?=
 =?us-ascii?Q?8HR5CfuLJf4iulAIQQThEXhGefPFKI7FN53rXeQ6DPiDgW8LRpzhlEbZPRVF?=
 =?us-ascii?Q?mR0DCzfKgetQg6TkAIR+o99MWQsAYlpArQT+Zoz3w6FsVz12pFxRGB5ymEDI?=
 =?us-ascii?Q?qdr/MOxqkFgB7IMdAGWYGsbASkx6+1/xx0u9ghWIDFdbaABx/MjQiROUUTI0?=
 =?us-ascii?Q?HNr+D1AgxqAkMka5urVowsvWkztKez6HqAQBppbc2ulUssQ39VvdJNFDS9xj?=
 =?us-ascii?Q?SIkF8fo3Cby3DE7Xr/dQa+bXPqspw7VIvZJ20BTT4TysP7UmQma1OMlvHpkU?=
 =?us-ascii?Q?tsrmqBXBy4ieIZpLlnlyZLWUNRKov5IzxdvutyjIqYG3WNHu3cTJ+lOnlbN1?=
 =?us-ascii?Q?Fzhv+hNphVAkjNmJ7Gvt0gEVkN6GZO6z63krM+PRqLE/xhQ0D2OzwnRYV7t2?=
 =?us-ascii?Q?UgIHDVDGoxKy9HTx9Io62u20QfkKA8KZx2Io0LtyCrcKvwHw091w+DkfzA3u?=
 =?us-ascii?Q?NUKj/PGR4M+IgbE/f69/JPt++vXcpVIMfXAtzr0HTSAyHEAbzbDi0Eo8XLrR?=
 =?us-ascii?Q?P8v3Evv9MHdupPtZPIcYAD1H1ycIbzjASdSlhWXhW3Rhv7DDxcU2AcKB1u8A?=
 =?us-ascii?Q?CtXrrqoDou8UcF0mG4Xn8pjFYkgeUD3GmYSLE568gs9PL2tzyDVGTJlEh+4r?=
 =?us-ascii?Q?DVQ73SEGjZnexzYiziR8Z6CAXyPZty9CuL7gLGCD+sc/Yn0TJ4ui3ePJFfQz?=
 =?us-ascii?Q?OozS4wR4SbV/o6vN/n7HZxBoa8a0u1So9HGDxaX/ATGJ0aVAdHiYODa6YXIM?=
 =?us-ascii?Q?dHUPZQrh8joFDTwyzGQp/eXk5Pc/FIwK5+xAy7h24tZL/8DiurH6mBdl/fUx?=
 =?us-ascii?Q?G780lhmHXkM5Eb49HHqZ3XgucOhRc/tiIhc4lTkcr7LEvV39Nk9XCdteK3iJ?=
 =?us-ascii?Q?qWpf7/QTODQFmV0iZhdabRuQkCgHcWzqBmv2y5MjFIE6bSoPoub4h36e5OXI?=
 =?us-ascii?Q?knDFDqirs3uHWwu+bVUTEgeyA2F5433xWn7D3LIri8NUV6ifPo+aSOlCXIZ1?=
 =?us-ascii?Q?ytDGUn5cjtnocMZVvNAUb5HJzLMNq2g160KL4Fg65gD9dFI5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bce7a05-1b22-42d4-d923-08deb09c18c3
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 03:02:41.1859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zovtsnm45C1y8MGuJnx4cryYxLPw9z6YT26XGMWJO42n/YQuNcv+A63A2l//D78NOE/67/xvb32RLatuP/Aciw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11525

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



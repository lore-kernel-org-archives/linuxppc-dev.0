Return-Path: <linuxppc-dev+bounces-20635-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2159CD343F
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2026 10:28:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gCMdX0vbQz2y2B;
	Sat, 09 May 2026 20:28:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778322496;
	cv=pass; b=IrnLLLyiTb6mg2wbGPKZh67QQVj63W2tMLCSvBCGMy1LwqMwcA0U25sK0yiktpVtk6Ljtgg3D5ghZG5XtPenkThytdoyTMonDwzE0wCL6EIyTLJwS59lJU22bMZRE713gNsVdHIgcEm1yEUmfZRASEBnD40zOc0DN9V2Sdl1li3npTaGYykwJCWIusSW1Rio+c+7Ljtx48Zi54CucKBKa7Dn9q8HXJ6F9L/u7J9lRdIMAW7RUaj6xlRzhWs0GztcRldQlBrYqhIAHvn0RkykjCC48aG7WFzib/KrkBJG0cpMVxozy0lFmyLulVBMUTHt6MERMTRiJi3tD9vafUtXaA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778322496; c=relaxed/relaxed;
	bh=stQ+D8tZg2Fh/ZZG5r4NLscoN9hcRkZ7YoGLApPhd1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iRdi4h9TQOwZxpLCr36tZjAr4rBgnTUi49uYyAwvcptdH2rGvJ9K3vRaM1WUpAG8qAJJWdZnfWLyCwhKJDPnixGkkdY+4gn84NJ0hpdY6uDbx1BMc+m1XiZ98mgr0BbdckmeIHBpgrqKCThY8czXFG80GNgNMR0TtcNG/ZxJsxP0BkmAizGC51dhPBMRiyLGcvgzVFxYVeut2mdlEMhf3hE0Mx2XHGbxZaJ/EuP5MEDbURzh2OpvEx65izqvF0d6MnAvn/fAkFWIAVa6TNEdOGAGdTWcJcOaPsiKK38UaZxcFkXsVQ1kM4dMeJM559JgKFWp4qncIGjQYGnYoA0tHA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=aE7p9Som; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=aE7p9Som;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gCMdV3x5yz2yF7
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2026 20:28:14 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uu5RUeSpEj0Nj9pJBx1eUTjkQxjwSWsNi3og0J7deDivK5Vbqu+2D5FTGdMdqruKeSdblTcnS9bCFOOqtVMYS9tJWRdgR66Mue4Lz8DSPbHKEj/1L1YPzd/TRhk6IT8dTgJfd5xsoKc8bupJMIi1JLhVrYdM3aq4n4madXZMnjkLfFYZAE16Qr4rPciB9Pu55noYPk0Ipp9ssf+n0L6VEWu75g/FAmk1YfkEXYPajeDyt8HRO1fwFmGiot2lATd4oZmudEySu4IyK6fE6ZXDZ7N3cRlWEo6Yoi9obpoInQ9t2oWtJ1UgXIUyRisuDSgituut4iwiRUW//zqp5Stdow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stQ+D8tZg2Fh/ZZG5r4NLscoN9hcRkZ7YoGLApPhd1o=;
 b=OXLEFzLaguJBteGChAxefJJ8tVx0AaI/hzHCxlMlCO4U/L0tYDfkn0sWLogV5Y8H43xo5nzeqr8mdKLOOZszaEmdpTuccI9Q6DxQdq3eD4Kyat/GPg5AEvBzLPpTFlM5qwfa11wkRyooDZ+WBBil3LlOkRQJ6IAZ6u7qCkxty+IygMAHB6JC+I+w0cUmIYfQpDS6UILPqzqelRhFEQhofpOXiqhjtOWjtjFrS6RirwUTdPVK6SWhfJUXNJKdac5spbw6qGFYcqlcvvWcINVSE4KrmV6mJcztC9iqp4EkaDAPuPzdCFrd8xtXPWpJfImz6P6XtDGjKf/YdsIly7wzeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stQ+D8tZg2Fh/ZZG5r4NLscoN9hcRkZ7YoGLApPhd1o=;
 b=aE7p9Somy1jFMLWgnrgA1YBrD5Mu481c123cXZhnLqiOY1/NcU7mbUX/gwxf2jUMvqXO+qrMk7JKsehtqdPHPQbQBnYcbRCg3xK/pQR460sxHYHJpdz632h4dqVf3Oj5kBuNRUEt/UdDUncqh5QUc+adTXkoqzbvlqOShv1i1qqGXfsqE/37gwq11D/5F+Z6mrFJPsjeSf4JdwxARfhZeMoUQ5U5BszUAZwqGqzZukF50WSWC2wE8VXTCZSNQeCvTqLUU8e8QgCxhfwF08+5T9BwL8M1oPL7b0Dprq8d5/43vqx2GyOJwxgxrdwH8s3EdieNRXWa+FHNbeYIYZcrDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PA1PR04MB10604.eurprd04.prod.outlook.com (2603:10a6:102:48e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 10:27:54 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 10:27:54 +0000
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
Subject: [PATCH v6 net-next 02/15] dt-bindings: net: dsa: add NETC switch
Date: Sat,  9 May 2026 18:29:41 +0800
Message-Id: <20260509102954.4116624-3-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 76b11dc9-646c-4e6c-676f-08deadb5a1a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|19092799006|18002099003|22082099003|38350700014|921020|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	fmR7UTJcvT+pYKLGrgI7OadbMhngiwuzpR/k0zs7shUVW6nQxxyW0B47PlMyw27Y8kaPrdkZoRVDb+VNhVpqKkjeax0uJljYd0KZ9/AnLMOY2X6zQb7m6qWyXmLPavKqdfy5XOi9L2UNr+2xIDG+xcHU7WNd/HoPvwVESGWYEKC0Nr6pZ7Ru0KmQK2r53uFYy62tHOypum9D1AylCZWkTudX/kBoeHxq+Y2SVpBYXvcWjqeAw9wV7/xqZxnTlv6xCORX99Vs8bWYNVj/uf6aSVWrMDjnnpwbo34qU7vWLk1DebM+CW0jDaHEPhstYcCcIIHk+Qmbj/GqAHsise0BgmaWGmRfXJnCtl3j9ilkYMK2/TdqKFQuyQN6tQ/7HpdT6xPCisRiig5NJiSQAG22JWJKKxhWRlLhXmhpPxK7UpMRWkR43Q4ox+JiN0dBPw7eGevMJQ9uNL7wydUMVouMRHqbmz8YURlOg5c1lEqzK8SiaTXkUiwijNoxlHq9hJAjBS1wME+O5MGW3Ys27AbP8uApsDLBy8HzwluTYc2VdadoAf4I1tt4zp0N78o8CTOJy3qnYt8wc1isIMSqUpUfa0KFIcob03S9arDd2SSS1W2+PxbDqkrPvWIy8+4dQmQP0UKEnygYAmnIDRiucoD3+if4YMLfUgOtX2IhEiS5Y3srvfdfaWmqc07KjdkXp7tBBu/tO1rlK6DQaLU6aJLaIQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(19092799006)(18002099003)(22082099003)(38350700014)(921020)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eFkMl75s6X0dk1zUoqsfAbarQ/D8SKPAJB5wXhSfCD6NLwk6a3DO6GB1IGMI?=
 =?us-ascii?Q?sm155kcwj8pbcs+JtLaYRp60ZrqxwPEOqUEq94xSuiHPsyExbnCiqmQhzkaV?=
 =?us-ascii?Q?XpOpB0M0xwVVFzCru7357U5gzW3yxysZPFIl4SU1c6GcT49qKUPQFAsvgKhF?=
 =?us-ascii?Q?6xH7H26BvBA3zHC1MHNJKJLRDFXWM2ITg9nHUk5Ad3eKPeB9DRNZ6kmBknyL?=
 =?us-ascii?Q?fXkbfpb7+m9MhrV5/I3vOEfj6r0bMCzLYaJ4lAlNoVw3RDVR2NHS+bxsByNk?=
 =?us-ascii?Q?32gL7Jrfw01En5eRDS9vugWb+EYx/obhUsPJDJ0BFHc6UIsl6g3TW6CzWnnA?=
 =?us-ascii?Q?cvuyFjOM+OR55NsnMFvEZ+0qtLFWgjw4ndSO4qNmO95K1998k6QR/cIA8uag?=
 =?us-ascii?Q?uWNJ62wGazVJD/F+yGv7HjyLK9FB+7LlsuROvW/a6mMXFn0xS5lk1GIlMDQW?=
 =?us-ascii?Q?Uta8rvu5k9GOLT46n6JpEJa74VdHUy3rAnUvRL6Bahnme1+YhOKLdwVLBQzj?=
 =?us-ascii?Q?c7lsBrLmzUQIK03V1e7/r4hnPj2sgx2V6PyLXHNRVk7z4GkRDmnN2ZGdIRjP?=
 =?us-ascii?Q?V9b2esyQp8aAvvISXZJhwpC+D2hcwymyPDy4USg3a9ATtoOSPXZ0PmE9H7IY?=
 =?us-ascii?Q?Ddtw1N/T14aiQE8dzxUe39AbBR5fVKk+pWNE/jOWUJqgmdYDkh5WuOHLP0pa?=
 =?us-ascii?Q?sVau7qOmcmU03AXr+DoWsuC2lIA+CrgRxVxIURyKwNNMqPETar5las+7Mnit?=
 =?us-ascii?Q?mmX8n7g9fou6graEyZiI31QPh+XggyWCvPc9LMqGegdDadCe7SNxBghJUwv2?=
 =?us-ascii?Q?RnRS/eDnl68UbA+0Yxkmo/cS2rf/5yRH6nZxRrzSSx2+ycX3TrcfXH7s8JoO?=
 =?us-ascii?Q?XhSR2acauS8CF2bUsBExcyey4lhA0U/6YWeSayvxee54FroFuxon5VNa9RO0?=
 =?us-ascii?Q?wrYBjpJgEDYV9rPxJebbp9wAXCr2YCsQ04xpVU5ZiYUxDRc+MwPvny6VLVLY?=
 =?us-ascii?Q?iJdX6XB4QmqkFIL/KmNkZ3H8gUpva6yNrxQFnVBkopyMn7XJPw2sCOvbwDld?=
 =?us-ascii?Q?uPuheGY7JXVbVjGQwwMbv8Pxv4VT2jzcE8t3XD90GgARJRXeGHrr6Xoq7gJz?=
 =?us-ascii?Q?2mfy7XTjL8rT2kek+Lx0D77RZVat3kULVrdFOT6rV1HHrnCvQfLiwY/p7j5d?=
 =?us-ascii?Q?4LHU8j9pXL/LTgtla4HNQHdoszi8lbXqYPufjgRa0KBADFgbFgWTh5Ok/4+H?=
 =?us-ascii?Q?E6sYF4bHrDtY+822bORMShTWDUut5MvE1jqv/4VzZBCyUcxiwfQluhMVt5Y9?=
 =?us-ascii?Q?3iflxcrHsO4OaMne2DxLXptx31174c/tk4ctqSNrC48fvSkKR9O/iVFEcDUH?=
 =?us-ascii?Q?FpkCVKHZRdxs9N+skDIxi+wY+Wci1ROCEO0t4rgqxnEej1zljV2fZ2/pNP0S?=
 =?us-ascii?Q?sc7VC1sOs/iVOCFKVvedGwxI4JB/nC7XXi9crNSz7f53c/K+I1CKqPqm4jNj?=
 =?us-ascii?Q?eZZAtrCotLa8oEuhTjIYgDauNCANUFZG6YC5HFqKIzZh5LXnSQnUbnU6IWyM?=
 =?us-ascii?Q?wAxPutx9B63iLr2GWV7WGPeL7DT9gZFXNf2v9FGxyashbn2e+wUSIbgIK5ub?=
 =?us-ascii?Q?qg7HEq0pF20SDQcjNLOMfQ7DgMv5KDtgNOo8JV+z6zN1mjk4OqeCFOOFj1W4?=
 =?us-ascii?Q?wfVm+TW+bv2ZUZYIK0gwigYr3YrqV5R7td7wl4eACn4pBrGo5bsr8rqyzCdX?=
 =?us-ascii?Q?CffpgKwwdg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b11dc9-646c-4e6c-676f-08deadb5a1a0
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 10:27:54.7682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysJF3J6MQLMYIYUxIPmQv3u3cHgNCZnUg9lpwzJ4SYRTJhpXzCzujqW+2zgWvmFprAtMTocZoitJmTgOJAnixw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10604

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
 .../bindings/net/dsa/nxp,netc-switch.yaml     | 127 ++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
new file mode 100644
index 000000000000..988688bf4467
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



Return-Path: <linuxppc-dev+bounces-18571-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE93D58CDF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 06:06:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffN3M6jRsz2yYy;
	Mon, 23 Mar 2026 17:06:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774245999;
	cv=pass; b=kf9atHmSEdjJugweclS1WR23m/WrUGwuupWmhGjM1WlzSImdQL8FzQ9782oEFTVSX1XS3YkB5QLBgDimS+wP315iRoSplHvf1UNL7I7BqqAldWcBCpI7v42jGKPKjigYsKcGFlKMVPcG19ySDcIntfXUgtRl3mCKvTJhpnIae6RITAB1tU31lNw8CoAiKm6GoG9Bk74viHBc2PKET/CBJ1RZGPORR9PpGkmej0x5koHQ/6Qto1Id6+D+8oczQprdBKUeLQp5xq0cwJEdCujeDK/ECeYej6g/ZqBQK/mMC8sPLA/2OGbXWZmibAM9SchTQ7steom6m9DlC6I082qC0Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774245999; c=relaxed/relaxed;
	bh=5viBy26cWwHioxqlHBlsPtDamqawl8PUf+BgL8en42Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CYB1K2Nuyhev5BDhQLvVWH4QzhiYkortpctnIFJsGVzTop0jXKmR0rATkx0LSQyK3cIldeRGKoUDSKrCPDHKzWCaBtb5St1OsFdNpttuGIWwjTsLQPaasy/8iZOy4QxeSiEg5nZyv2MTJ8ObwVLuXRoz6GQ7q9weawhNS1s71C8phLzGlBxx+2yI1Q1PACUlh4jpDDQjctRICWPO+9CqcjzUkgsrWNwUQjpAIlFseNvNIxGuYe3vUNd86CSZn851DdbC7vOOIcPGLAP+M/p//tysddXupLbNJOocztpqlJrqifJW46AupjSe8tTBNtQM5vV9BCTDc1W4IxLy14edhg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=V1X/3uOl; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=V1X/3uOl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffN3L3vKqz2ygl
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 17:06:38 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRiVAEu8ZvGKxHfjfP2LlBBFMpJzxLsxOGgtPMQTO0K/QRqN1JyP4/7t3SU4TRQ6Yulq9DSCAODr7l2g3f0LP5s7MXzg6tUFGGo4qndGG+h29Wa998T+s/juvqNyzO0EYzhVKxU2RH5+M2YWPuVYl9GojxyFjb4vHumyTlaMvWL7ReOFUNiiyXX3po+05szsOVtwRpOAerO/dYZl62pSo2qZREIgUrcrRPyxi/1BbD788WmEbZjDQNqPQkTSzRKCtARrUvi1ljS5bFzvWbn7jHdy4n0/Z72q+wBs/mhlzKg0hbehHQJv8pWtZGKKPyvVIM/z+HGjnkiN+wLytXa/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5viBy26cWwHioxqlHBlsPtDamqawl8PUf+BgL8en42Q=;
 b=PUXUZXou2djkyUQudVoUKXSkqkj6A//0imL54yd4a41rT5+1BLtA1zCplYB8JDLOlT0tmIuj8rfvIMaZ1wo+A0ShXOMdbJCvogY7agddjujcgFgyRmrJA2gR6JjhtvNL5goQwwVItLKuYA8wHdSj7wnY8+oLnpmseqK9VmZtJQ0EbUy1i1W3U78aRKyePODnp0qk9nLMc7CnxPif63qrPsh6kbVjG5TXepqSJSZIodRIGkPUpqRmYfDoWB8X1eHV1cVY7XrNtvlGhvG6l2zVD2YFMP8LdT6zi5wszkoeDpv1a6A4D/GIEhznXy0EBN+pW92uJPSalFhvFl96iRZjrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5viBy26cWwHioxqlHBlsPtDamqawl8PUf+BgL8en42Q=;
 b=V1X/3uOlqIKCXHSNoGOvBqBdlTkMF7sQYfEjtJlnREYAILLKZourJ9GVPpjyXGzElwhsQo36Uo0nVhqv//v6PS5GTx3dITxc3yfmxTyFSXsDAPw0fWZniso/gtosixPlk4RYS8SevfVu+GktOLiEkaO5kM2H7nonLBOLGexdMLk0jepRWJDYNZAMs1uD89KEUJDIiXsXjXMzp3Whx87rxInrcdYuCtH+tvWe49ii2HuDsDFb4yRfA0gOn7CKUk7/O6TB2QZ3Mxf7PrpwKMsz9DohfkqWh3vrgiOKR6fWtN1XkUaAi+AVeuHbUaBR8gVJc0v5Z6DsOVpfEj4ycXLCAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by PAXPR04MB8911.eurprd04.prod.outlook.com (2603:10a6:102:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 06:05:53 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 06:06:16 +0000
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
	andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net-next 02/14] dt-bindings: net: dsa: add NETC switch
Date: Mon, 23 Mar 2026 14:07:40 +0800
Message-Id: <20260323060752.1157031-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323060752.1157031-1-wei.fang@nxp.com>
References: <20260323060752.1157031-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::17) To AM9PR04MB8505.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::14)
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8505:EE_|PAXPR04MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: 557aaa86-84cc-42e6-2961-08de88a24ad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|921020|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	N5FnAhVryDPspSs3uhefMBtz+SjgDPGQj6Z+GLTzFkYMG/iws3hV8iiCdw4AHq8xFaOz/L2Y7aoZoeNdjdhZwDOjRSOkZL6Y94HVBn8Bj9uqoORdiiizgcZ1gxaUOWLsJKU9BVJMcW60GBHbR2Sgb7S0eeCvIbD6r8np10JNnh23QD1jcxIxRbHfoei4riPBinepJoaCrPCm/39aUcfu8/PvIr/4vKy71JV/9VI2jRcwWvasZ1WUGKJjinug1YwRFR0TaqTbNzFXJ6sul9R2DELhUj0T2sp/sMM4I3MhGTvcy1IpFmyqEoguTn4bKaGvCZGLbjRZJNp938jMDT/txXdrTkmcKWiNrUy6ioIg8MZEngMPDahX4/ykSURDXix9HdCmJmAFctU9xhKdtm3gd2uub/j1m8o+bQWxCYXEA9MBKz6cV9ksf1EfZaTkYE7+pxzykXeIGOYY1baecza4eGDkpD5pqr4F84VuAxL0ULqTgKP8FtISiMBlVu6rzjbOdsM7E9W6OF9zwP7dnpwXfxFK+7OGga0K/tPNP0oyUCKHO1xpGzkU6qwQRkj1v4X6y3j6JYvL1wbEg0wXab/hfnGSeneZFqVs5PUK4FkJOUCSXCqi+Dd6hmck/8XJz9EXsyiSkHBIVoRZrK0rXXCNbNjFj5nXBg/aSELKdPvxohSyLxH/XZ1v2MYuMXlVZVmsQG4XFCBkl2XdBa1ZmEwIrunH7VEIejFUT4vVrd679QSqbsDq5JFGkjgfHLTD606Q58kq7mtH40gHrnc+KNFNcw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(921020)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TAWChFuzKxjguTp1QGRmhtEoDoyuiQNhqfFXyGPOEoQC/YVu5tCaZWaHIeNj?=
 =?us-ascii?Q?6DWZkDXysoGilVfw71uzuq/aFKjyBLRFD3qoMJqlH9RE6nCKmf2h09/kvknT?=
 =?us-ascii?Q?qAJNvQF5KJEVMYQrX3NZHdxwO30ST4iulnwgCEssEvBN2Uzfgw/vECyIBA+J?=
 =?us-ascii?Q?Kjf1AQxT/0grbE2ChqgjwjiLWrhd1trKju5Y9uUxtoGZrC5pFd9nFCSvcPfF?=
 =?us-ascii?Q?rcJUSayNkDqLbjeyhXrW7fw9C6/2QB6k+L09Xs9LUqxOYC/Sd0Yz0bqO2HbG?=
 =?us-ascii?Q?bHwSAiXB9awXLoAeaLVh59Rw1HSRNApdTetl+6BQy/GZ4XqzLBEST47rhwD8?=
 =?us-ascii?Q?KP8/hZq0fz56CEKrXTDyhmgKXnyK9d6bSkxUXt0y47B5jurRTLqctZCggXDu?=
 =?us-ascii?Q?YvColahOQXsBdSB5WcwYQhIl1rYxMODa8S18UmTwXjNSveSUSfmbXMeQ4b+W?=
 =?us-ascii?Q?Cc8Y3+vI3tCBIet4KUFd1KxJtTGkAt3lkzPQzPas9lf0Al82mAK6DZvvaWZM?=
 =?us-ascii?Q?Ec/sU05yeAo2U+5cICwXUVxePegbVnW3ouhuTPX/cr9Hwz4mhwsv04gxBT0W?=
 =?us-ascii?Q?Tct/ovoEmAi3VfVUVG0yOL64j0OmWUnnl4poNZUtvz5s/EaluIDSK+jH6wZt?=
 =?us-ascii?Q?QY9hgNpnxVh9uQ5kYBA2Fp8GLguzbrxpiN1KaRrFhIhrdwXkhfpxKhkw5dBy?=
 =?us-ascii?Q?fzdo3Ak3rLiM0AnI42txEXsNnR33ajwYBOY3bt7+Nsnj3i7KjOclJLq7d7Ep?=
 =?us-ascii?Q?a+ZU7cJfR37QUL2CYj8tCbopRw2f2Fa3bvPs5fNmjDK+QtwWHa3E8KA5bCzm?=
 =?us-ascii?Q?9Lo9am9gmmevUvSJMeTI28VtyDIBRjGPWigm1o+3wET0evlSpdBiTAf7bGeD?=
 =?us-ascii?Q?q5Yuvdou/vegbU0mKplI7EP6NMtAfqgbRLZE3nu00ntpPwosuLHrwP0s+teu?=
 =?us-ascii?Q?K05WJb4NiAalUXRrv8za5c7SCJKXGNjdI/+PdX5d6yrMjtgSPcELKyxQldrr?=
 =?us-ascii?Q?wEWPI/mAm8ewZEgG2YDbJHeZ1jlQXcMm6jTTS/3WBusGiVs6DzoMtBKk0hzd?=
 =?us-ascii?Q?IV17Y/v4quP4s21WEvXVsPVtmJu4MC/ydW2c9Ivfcqwxy2fVDWQB4SXbavN+?=
 =?us-ascii?Q?owIZuzPDMv6/UKUf/BY/HkIR0RF47S8xnSw2i60G0pZd2u+edX2RpTbDSAos?=
 =?us-ascii?Q?RwUiiLqkOHK5QTNN9y44wWI9zigazZnztcbKvZzX0CpGYFXVZaDY/VRAYFPk?=
 =?us-ascii?Q?pC1AlTa73GKbPj1g7Mbaxi+UtgcdnUQk6j6FLCnnDWjKYKgfZKXAQob61QDo?=
 =?us-ascii?Q?SfXtWdkWnRgN7xcFXq9wHmF/eW22bD/tXJnN1mPwVWVRP9wc5L+Eqc9syZRk?=
 =?us-ascii?Q?Dwci2OvU+WhH9h07NpZB94du3o5RBBQNbSU4cQ2+OpJI6coXTpVrRLNkG48g?=
 =?us-ascii?Q?WO2jchqAs/TD0NQ12YZlrEIl13w7C5wT7HG7X+o86TeHBVqVOXXP9qu5tiTj?=
 =?us-ascii?Q?Ngrbvf+fpXFZgHQbmhjGFsCf57YjaWwH57/jeoCGh+v7N+jrdJuQUb4LNTVM?=
 =?us-ascii?Q?j4CMaeFMpAS53emYqGC2BEnfN8A2BucsodB02P0oFOjJUP1FrbcbOMIFB7tB?=
 =?us-ascii?Q?Fazyg/wQ+jSfDXa2126zUJ9A3SmZB0dyypBpcZT18RAD56h4bZGvXeermmjd?=
 =?us-ascii?Q?bqBADmCemCIYtlHKwV/D1XQvq5Vu61TnHpAK+5ROcYIfJgB2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 557aaa86-84cc-42e6-2961-08de88a24ad0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 06:06:16.4133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9YjPThsFDukhoLpvvWFxLTgIMba+eAuOrMXwA6gzLYZQRwYcakQPugvrvV+iTOGRODCU2+ftWDlF0f39yYxVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8911

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
 .../bindings/net/dsa/nxp,netc-switch.yaml     | 128 ++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
new file mode 100644
index 000000000000..df09e02e1863
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
@@ -0,0 +1,128 @@
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
+      The property indicates DSA cluster and switch index. For NETC switch,
+      The valid range of the switch index is 1 ~ 7, the value 0 is reserved
+      for VEPA switch.
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



Return-Path: <linuxppc-dev+bounces-20963-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8C4CD4851
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2026 09:18:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGvQK0k8tz2yFW;
	Fri, 15 May 2026 14:30:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=52.101.70.47 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778819449;
	cv=pass; b=MvxZmjUfk154Gy1lrYgP8hnMQRBjriJrFfqLwr1T5SJP8zOPjrfgf8OVXCCspXjqSvb9zWOOzdo9zHAsYOFTc+vP00GdxIHXQKvolM9b47n0uC6RCmUIpVc0PLlL0XiJdx2uUYz/6u8VooCuszCmYM5CQCPichlTqJaa8ocMaSoqLyAUUOxA+tzInGoT9WvyYndQ4kMhgMpXjEdDJbpQoMnVYyMLPjMbFLZtlD4BABrkpwLktr/3mKbgragLus5kpUZhRLK3+QxcxnGupFGjPlGspcF8JJbyeEX5r4pb+SLENmuOOy0igphdiANIEVhnGBNxjWaVbbc9Yfx7fjQczg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778819449; c=relaxed/relaxed;
	bh=JmRz2FQR+E7INjCpVZO6lijeFe7y1PzPkR+xJ2ryLMk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KTFvOwqCdLX2w0rKLKDJ7wopLXXavSvQwCyDda9tq+DeDnNvK0HtZWonljB8vBrTTIno4eRF4CQe6MUCNSzBT1S98ppQbwa7RwP1lZyg8Y+4uCiwKIxskqLg7BL/daHuPFlu1uff95EyttlUn0stPFGog3ShY+JT8bETNKIttaCZiAdFfU5tHuXUQ1F7zZ9tGKOqngp5LKknWAWvKEfI30uNJ5TTUU7Nlw20hO3Dbmz5s5as9Rmap5fZyKM4nBUboRDVhpuq06AUfZ4QfH4Bs+M0SYdD4L4mtafIa6x99faTbyhBnfpSUzjCPr7couBRAPxsVODI6+WpTB9mxbj0PA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=PpY2y7Se; dkim-atps=neutral; spf=pass (client-ip=52.101.70.47; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=PpY2y7Se;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nxp.com (client-ip=52.101.70.47; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011047.outbound.protection.outlook.com [52.101.70.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGvQ406Dlz2yFC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2026 14:30:34 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7pBd7QPBIBctHZ7GXh2CSy93QodWlbIdfJF46eONJnJa7Lcg8+d+3R/KUIRGV0FhtY0RUq9fg28tqD5dvRfvKAWnazb6D9QoSxQG6tmpXlK+EmJ9NrTNcSi9nnxbGx6+4vbRyhVcF+dR+QE2eRZO23TVOyUOr41Fj8pwhJ5qQoeHVv6sLvRjlamQZoB8DY5ByR5/hymSuLWo85/FKjxLmhFMpV7IFrT3FbkuBuuh7giqqs00CNGfleo5uyRiII8cRv2+6kmSPKEXLKDqVunYnS54XoMyIWpHN1i7uPTXiW+RP2bbRK8ddZLAJv5KuvSJ2lBevFvTyQT+d5+bDQUIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmRz2FQR+E7INjCpVZO6lijeFe7y1PzPkR+xJ2ryLMk=;
 b=FiaXACpLUL9jaLUstymrxQMtbufdeWz6GB5aDTa4LShaYMkMH68ugh0S6QPFMR+OULhwJvNYh426CSJYQV+k//WGaiwSb5a9mGl5keaJKxBk85b35t1BHXTgZCWV2638f/dEUwVYl97KNOHIB8B7k3BuHm7JnMxbECxNDIArBg04BM2FJ10DCM2sxEw6nnWHIZhi7w7bJcGIyBaftiIYTF+hdCId0oVd3Bz6HzJGCJdiJs64bA/V3ZfOj1nw5k5mcDv/D3KeIG25CFWQ4RN+CUAN+ym5h19b2u/cltVfOrpIOyIxpLKQ6/Y5wzL27ribSJ5vI+xTfrcKHeej0MhOiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmRz2FQR+E7INjCpVZO6lijeFe7y1PzPkR+xJ2ryLMk=;
 b=PpY2y7SeCB2v0GzWqc8zJup00xFCv2alAPMlkw0ekrk6VLkVwvobSbhZvD2LVDD+Gv0LBf9PjJlAqGybRP1mEQy+DfKCV7/mKiwUPfkcJhLT3NIa86EDWTm0fF5uWoYc/HHM1xCkIqT+uohB/61RAIA0G7YnXFduln07Q30TPN3sw/ygUzfWiL0kgHV59HO4lvQFIIQTqpTGLWWFMOXT63nYNkKMOi4lb+LbuUZ3dHgOQKHGzZ5BaLEVAY2aLBEzfKJ0TE5kiqOUtZCFRBxgo+/069uXf+8Ww20YLxR6EZkiRcujZp0t3dXrosDpFl7ZLSVrT+Hj2JtEjucLOcb0SA==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by DBBPR04MB7929.eurprd04.prod.outlook.com (2603:10a6:10:1ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 03:36:22 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 03:36:22 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, Frank Li <frank.li@nxp.com>,
	"chleroy@kernel.org" <chleroy@kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com" <olteanv@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH v7 net-next 10/15] net: dsa: netc: introduce NXP NETC
 switch driver for i.MX94
Thread-Topic: [PATCH v7 net-next 10/15] net: dsa: netc: introduce NXP NETC
 switch driver for i.MX94
Thread-Index: AQHc4oUZiwWgjwtsAkaDFGy/HKvxcLYOcgMg
Date: Fri, 15 May 2026 03:36:22 +0000
Message-ID:
 <DBBPR04MB75008DCC18E2A10C9949294188042@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260513030454.1666570-1-wei.fang@nxp.com>
 <20260513030454.1666570-11-wei.fang@nxp.com>
In-Reply-To: <20260513030454.1666570-11-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|DBBPR04MB7929:EE_
x-ms-office365-filtering-correlation-id: 4edd179d-c703-4abf-8a7d-08deb2332258
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|366016|1800799024|921020|38070700021|56012099003|11063799003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 9V0EyLbB4GFAFuM+AALiHTMCMTtJi37tqtAOg+re9U/h07PHdl7mEjds8PwNA6cCA8kTChsE6zxFksx62Xgcub/Ey6OLYX7X34BWcTYPzfldlbiPEMuck+bi4qUQ/Z+L6cu0uQgbHpq6ZaZ4cHhRzUSUUr3ThFLzhwmybUiD5ik5rDKT0e8Z0UBJLgtz+WMVlYXyVhaTwWG2PsApJDHYjbij2AG3hQQ3J6QoxYccHxigI3ArdafbR1ENySh96zNXG/BhSp6L2fL7IIIqInAKdBV5diPZDjFSzOoameEPNdPDruQG6mTXV/eC9kn4nUhgrNdv9/vwalRhV3W/tMSNSOXL7O444zcTUEPG6e8ewjRzw0sIKyaScCLsIHF7NPl5SumjVioTEbL/c2PFSLiIBZlpuLnzAQNVq1VNMhgfx4LY25bx2nd0MC4L0r9rEu0VsI3eigUlWCZwv9m2S7WP2jseSVO27H7ubEzKAiUSisJPz0VWs5ltGVoAzzBGPibtNdOPQyySl+Ey3aeBrTtTeWjLLw3OHIh1/5gw/WKa+bwMT6D5PfjWYF8Rn8qFVcAIi/CvcoNJlCIAFj3IeClnhUoPD8H8Tad1mJ/dmaw9dByoNDpTrDZcXz32M89b80zrLhrWai8OpIE06OP79ahzq0JcBtKxhJA4ct+LoNYRE3vyr+UWc3U78qW9ECL/Y8ICrRxuPVi6PISP1DMeQEgF+0yy9VWoAXAsYRyWz1IUbAsMlabUZO3bgY1JCAJ49j6kPV2OcPcldtokYSMTW9i82g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(1800799024)(921020)(38070700021)(56012099003)(11063799003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5wl7EOxv/13qHmXGDKKxs0YzUTU8m6jSBrixdhur9uY25lue2t8JyrMCpAlr?=
 =?us-ascii?Q?WnePGRSV/UhFqbm8zd+aNToGOnrnuvhOtCa1J0+dizeJtl7B584IpViWMAv6?=
 =?us-ascii?Q?GPKQsV22/sNjmQ7FrFZ19wp0WZq5/G4/3/SpY025ZyPrtTSliSsyynmoj4Uf?=
 =?us-ascii?Q?fR1dQ1YmP0FjJAoqD8lVx/HUnqDRbQ5tYzbQ2Nv4KBlxJK2px/TDuN7nvKfr?=
 =?us-ascii?Q?cChRc2Eyq/UcisYOKkKRWhw3DPVVa3eAO11qvLJaldxEcTKc8XfdgwOSfNRk?=
 =?us-ascii?Q?BBxRz7UPOzFxx0pvGCGAg9jxYrJGNT2KpTS2Sm/zGTn8v2KYzeyQzUjDqlLu?=
 =?us-ascii?Q?Lq7LX6GMfOcz/YTo1E/PSxwDvrzhTOIA2F23chBshYOI9KcM/g9nXfMnljE3?=
 =?us-ascii?Q?tcz/oCWYisohj/c4yXkFx9w/MfjVe0EBEA08aVvw9GNZO2zhM2XjmuHcEVcr?=
 =?us-ascii?Q?SarEntOjSwglZyq+KpxmfJN8HQtFcaB2VK+sXHaJ7Q+f5jWoEkzGZ99MFlKF?=
 =?us-ascii?Q?J+q88CgdfOvSX6VcefXCh2oYSyDQ3iqjMSB6XwxiKVZlMiyo9BRais3cqV5c?=
 =?us-ascii?Q?k6ddJXqIq+vObZx1CuaLmHOM5PRket06k297sUV1Rl+LqcLhEAhOssm24/8h?=
 =?us-ascii?Q?TVWp/47qPYIpOJP3IXzbSWpUPwgTDcQUmLk/pQkdysGt67ovIiyRnWilxCWs?=
 =?us-ascii?Q?yWjJQa+WPX9b2+zXr7T73XIw1iAucOaIU+C+2K7kSSUu66uREnsNkQt+9jPM?=
 =?us-ascii?Q?jPAeh5/IlV9uyQpg9zdaiGg+1xynWv4WdqT1icVDXe1kmfTP5TqyJjf2I/XB?=
 =?us-ascii?Q?n7wzikD+b3UhQiwKBylZcuobi+vmdq5NJJNGYg3AhJlbAufZCimNAkcexdCQ?=
 =?us-ascii?Q?3z5Qu/zuWU5uYipfWXusAL7umZky2ohWL3punA+b9juUqOAsSTwQrcQI3hdZ?=
 =?us-ascii?Q?Je+o1dy1qt1pD8fmKhPLC6XD1MjNQoifeksoyjVzMyi48Iwoq2LL2ThVtE3S?=
 =?us-ascii?Q?Pes2MONYKG4QRq3kA7aB8snr3jp2ow4LeVhdNWC4yPuhft+jpCgRLy2SSMJJ?=
 =?us-ascii?Q?kEpZ31VzyhD6i5uv/vmwt6RfRel5KJ0xBk5ikwjy4ART0dbytHoeYey8f144?=
 =?us-ascii?Q?Dg8+/CxplxXWHS17izjm2G0KVleuufX4e4mjcAp8/p6+ylroXPXjwpc9KH/e?=
 =?us-ascii?Q?h6SSs8RSJt+/Y/tndRg1usFWpIFZHXJ0FwVFcQKWAjrrg8JxnWdDmdEE5eTL?=
 =?us-ascii?Q?Ej1OrP3gINvAIaSXBGeaQl/pO92JCS4P4LHhpNNo/9Iq1e7e3BUtaGWv75AA?=
 =?us-ascii?Q?pLa8RPlxeTTxCYCfSbJl/N/G6gC24JJ7cVbyrDDQ2V1iaiDXKTx+Sl+kDhKV?=
 =?us-ascii?Q?/Ed3+mHAPLDIR1YUt+jYLj+aBs8/HMGuC7c8Z9CfkWNMsLoAMIQ3NBk0x9H8?=
 =?us-ascii?Q?v0FXrenhMKraKATWTWDK76pls0dz0Ka6udAySSXAGsnTE+c/bERTF47rhoor?=
 =?us-ascii?Q?4Yqzivw4YFXiHbKjZz3OD0USo0Ji3FSHsh8IgxHy9gabSmEEt8tZk0VKaqnf?=
 =?us-ascii?Q?dlfBu0XXqtVzRj+DphfiD3vtCts8hPDVYsHvnuJUu363+pJTUuCz8cvY1sdD?=
 =?us-ascii?Q?PdhK0TCxu3oiCsKKi5Cijyc14Ev3VkEwEX5g9WjqIhFj2WiD+6vf2UFFIYkh?=
 =?us-ascii?Q?YOcQgsyiSOiAN54K1bdbDPbQD7JwE2PqgASi3kG3tw5W6cT8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4edd179d-c703-4abf-8a7d-08deb2332258
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 03:36:22.2209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ocP2ad0V3xa5lj9vDgsWg01S3TsyV2qVNmNuomLYxQ4BGY67czClragDrRKirVIdmsd9rGYwEk0+HKyu5wel7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7929

> diff --git a/drivers/net/dsa/netc/Kconfig b/drivers/net/dsa/netc/Kconfig =
new file
> mode 100644 index 000000000000..0f246ac9e018
> --- /dev/null
> +++ b/drivers/net/dsa/netc/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only config NET_DSA_NETC_SWITCH
> +	tristate "NXP NETC Ethernet switch support"
> +	depends on ARM64 || COMPILE_TEST
> +	depends on NET_DSA && PCI
> +	select NET_DSA_TAG_NETC
> +	select FSL_ENETC_MDIO
> +	select NXP_NTMP
> +	select NXP_NETC_LIB
> +	help
> +	  This driver supports the NXP NETC Ethernet switch, which is embedded
> +	  as a PCIe function of the NXP NETC IP. But note that this driver is
> +	  is only available for NETC v4.3 and later versions.

Sashiko reported there is a duplicated "is" in the help text. I will fix in=
 v8.

--
pw-bot: cr


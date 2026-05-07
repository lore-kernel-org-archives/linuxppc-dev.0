Return-Path: <linuxppc-dev+bounces-20541-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3158CD342C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 02:08:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9wf50KLzz2xm1;
	Thu, 07 May 2026 12:08:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778119724;
	cv=pass; b=bo/9Xq7OO7ljjnD9F29/fydp24C8Y1pEImmqvOiI1OAxIuawCV5cfIw9aa5O0tmGLmGU1S/9WmAclyJUpyg9wl68rJGQPid8YNf5fHN7/RQfiSHMDLlgqnR+zT95HCICTx3FAYBTnj2qy1HyG4LbvBlGvwBGmAnmxHujyOezGECq3xnW5Dwqdba7O3gvKmAIwcq+DI8Yazi1HOR0qVUFVtoQVowkQq1kV4mAqZJY57MJzfHO1ewp2gFqkl7jaRmdY8mUL0SlIYmjT52XiIUJA8zzahYTGFOUM7z6rKyg0FVHgR3fv7+F7dm1jFPQhKYHeeFBnqWk0/px1Vq8cyb/lw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778119724; c=relaxed/relaxed;
	bh=ouxuxkb2XL/1BdZHuL17sgoRhDhsBbMfXFLBNuX0ULw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J0rZgqlamMXdc3+tkkelhqBP8LYIGVS3YaZYM5YMinG71rWm5diG3D0jsbuAPd1iO3hdmXPA9ux171f9aCoh9mjlU+kgbSPvZzQNRZVmCU5LIKlu9aL6/rB85ZojNNhcHEIGCaqaaOwvqzMMYp5rxfItAi3A+RItmApFOX/JZYGuoN4tHCmkmyO2tWn5b43MJxLhb22YfzJvcDTnqikNlayVri4/T1qoZDghsyn1K3I2dRUcJuCjmVRoupCLEEcB8cgMkMkrq14i6USQqjNKqLVvm7RdLmdcKLjd5GRBYkDezVM0RrqfskY12CqOcXhSClG8IQ9aBiVOQUHqQmqJ8w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=N2jcTQmp; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=N2jcTQmp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9wf04nxSz2xlm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 12:08:40 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8Diog+4X+TkiIkOn78aAxSftT8eDZmN2meUWF1w5HuDrPROcEki5lCxRMPQ/Hq+uUKmwwBktc6gZnJVHpiFtT8FF/JUX7A0VYmauvuUvExltzY+ArqgcPfYHIafy8G3R3TczQk12Wp4gJi1XhQmAubxJwrbN6Y282WNKv5Scj2XbcysUlupPq5AlzsKBNMbmsb9MYNy8tOk1dLRLjr1mlvWlQtcghRj+/1iVTvyqMmQoO7xoc+71RqF6EKUYJDaZ1dobsmr2asXPfwxNgzivtbG6eeks1VeRKEMRwb4yMRbLw+7NcY43yyywfzYV5q9Q6E1VswlJqwxfBLfDh5+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouxuxkb2XL/1BdZHuL17sgoRhDhsBbMfXFLBNuX0ULw=;
 b=kbS5MoloCpO8CRnYHS8knPB+aIFXrnqlEm7U/y7EIIR8GyyVXItxOAZBaQF7zJlMCrM3d/20EA2Adaw1ZzGTMgwAHWw4+cUd++v/P6JFAIhRCLdEVBwsrlY3MYiel2jCNjuoqSf6PaippwRWxffV2pFH8w9fg1ad7UDG9N3aywWW+NznioQNoIy7ud8q4mC2poCTdrCGGu2WVnvR9CFcg77ktnnWCWw7Y3zkKxwrMsFzniiRY3UcoL9+p1aRjmn1m6B3uW7tU7scTcHwW6cp8dkZBeccad7YuiyEu9EfLDFWsEM/UU6pKVAMxTgiokArwT+CV2I4NPr7FUN+bMq9JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouxuxkb2XL/1BdZHuL17sgoRhDhsBbMfXFLBNuX0ULw=;
 b=N2jcTQmp8xDxkmOniWSuzxKwhFTyZ2016l40sqmCi9dxC+FjKnDvv5amUPzE6rM0Ma53M8CMG89FHVFnoYGixM0NKQAx1RN9JPBA9Uqm0hdzqSO1zNKUwBnUPuuFiyurhISWaZqer8ekbb9qZDWjoR1+sxUvA8QZsBlQgumClURjV106bHihMB1v3P5/+uDiDohldexFmG4Dp5BmHOWD+Jhnl3vgVJUPzRSEr0JSlUDCy9iRa2pX08fzTT3aVXFSCKH29SuUgSZJ6sjTmuPCnaarEehNwcV614DeSI8CgN4DttQu91jjhxU8mYB2yYzN/BJbpVsZ03FOAVg540EcYQ==
Received: from AM9PR04MB7491.eurprd04.prod.outlook.com (2603:10a6:20b:283::7)
 by PA1PR04MB10700.eurprd04.prod.outlook.com (2603:10a6:102:48e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 02:08:15 +0000
Received: from AM9PR04MB7491.eurprd04.prod.outlook.com
 ([fe80::3203:e51d:557b:a195]) by AM9PR04MB7491.eurprd04.prod.outlook.com
 ([fe80::3203:e51d:557b:a195%6]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 02:08:15 +0000
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
	<horms@kernel.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH v5 net-next 12/15] net: dsa: netc: add FDB, STP, MTU, port
 setup and host flooding support
Thread-Topic: [PATCH v5 net-next 12/15] net: dsa: netc: add FDB, STP, MTU,
 port setup and host flooding support
Thread-Index: AQHc2EvhWB5l3RgFg0WQ0IZZ22fm2rYB2AYA
Date: Thu, 7 May 2026 02:08:15 +0000
Message-ID:
 <AM9PR04MB749190BBD0C9389F17242090883C2@AM9PR04MB7491.eurprd04.prod.outlook.com>
References: <20260430024945.3413973-1-wei.fang@nxp.com>
 <20260430024945.3413973-13-wei.fang@nxp.com>
In-Reply-To: <20260430024945.3413973-13-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7491:EE_|PA1PR04MB10700:EE_
x-ms-office365-filtering-correlation-id: 7174be37-a000-4bec-ddd8-08deabdd7ff4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|921020|38070700021|3023799003|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 bk4EPG9VXr5y42c5XZ/NZ4C90H1g2TPRFpJhR8xFleUkfD2rBcmcuTAAAu7pLqGaYeeUsf0si/i7NGSzyEhOW3NMP31gkdiOC/P8ByMhsVOXC2H8oGNY0R7aHhdmjwK/zcgXtMH5+ArC6bIOmuLMHuVtcwYaKMGWtE3m+zCJV+ip6TscVOGzRLCAxDX+RIsoy1+83ld50s8GX50tlxTskfR5qgUoaq5eHgGJo6nfIVltzfLvzy/siO+KeTt0GXs2C32Dk5CQLq2jaaiG+SXtkfpRU8mIN1w1uMKPTGFKKCtrRJCnFeZppIkkoa6BekHXjIcnmhY59yTjINNPY6QdSWUkh5AjpsqfacUuhHYzjSA7ZDEbyqDRuGD+u+YnZLCD7j3IjfJbdBEiLcDCoWk/pKDGEhT4LO/aD6jyGxk5u2FPpN5RbEtyZlu51bj1LvXI3uyUplXiET4Pr24l9QyAdEGrrXqAALfIijA8FKyhWu+nKlbwitOPkI+NoscQloPVi0/Bq2aN8ud5ojSETI2wxayWZ9gVCvp4hAWVD68v5xNxgYuCZncXSDapSpF6TkNm4refq5w6dLTpsCI8e5N3h79nDagrOUW0JAJnKMKy7CRzUzR7DmCBGAx112oudE361topKtGIozg20scC+ox0mZN40eC7S2T6M2yZEqjulh81ekHnsfVOccrIcySLGbHs/+/M96/9jYtVBI/ytWSXkq6aKjYbw7Suwip6OFlkFXTBCdgAWoupE5XKvjkM/54kDfNsSKEuXy18A+LK4z8UNA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7491.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(921020)(38070700021)(3023799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?koi8-r?Q?VryC8cbo/QoT6AflwiStQBsAmsxj4s4gSwTaZ3Ztf+3EHpWOWZBvv4i8N4SI9X?=
 =?koi8-r?Q?G9rPSS+QdAdmTQwoSJ84wLQPBJnvpRMT1oZHWYlm1sO8XpnKe5BZOwNaNOnMw2?=
 =?koi8-r?Q?9n1oVPxml7aLiT2L8vxrnaYSFGvVTl5/DzXfHOmCCSEYGIvZhg4yAQ0+7vjf2B?=
 =?koi8-r?Q?nEl3juh9TxyiTjAh1LX4NL0kq+3GHUoHUqx874ZeVW4UzChtz95Sb93UgF/Z8R?=
 =?koi8-r?Q?Cx5s0dcfmQlbaIx8X4p2KqRg557dkRPeRT12+UxT8XlDm7H5zWE/XNni0ayf0u?=
 =?koi8-r?Q?1X98fRGE1DwyLeXf8OzZMpsABZn0oSbUB9iYtsxdjvXExaxB9nhhlZZrZHsq8I?=
 =?koi8-r?Q?Rh1Xa6PxSF1Hnez01Kq/itMU4M4pfuB0Zj+6dSh5PVx7RbTBhBDfvcmnl8dVXH?=
 =?koi8-r?Q?VWg1YSaMFNeksY2zujwdlEMw9gKGMudtcXlB0GNs5iYZAExXxCsQJNNHcq69B/?=
 =?koi8-r?Q?ATurhET1BkYRaP79cTpydvxguMzxcKzErfaF7bdQuG3j95Qb7GwXFUsDwWtcS8?=
 =?koi8-r?Q?VtVSO+DFaoPFy2ttcy4KgMol/SPVQCQID8D0DDHdzSn19VWvWu39fpTrVzHuU+?=
 =?koi8-r?Q?VUq8PSWBsEZYPffRbDCdCQoAYCUIn+Kf7GUq0yvy9IIHe+XOrnrPW6N8/mT5wK?=
 =?koi8-r?Q?nOO6tuiIEOAMUXchJA+dzUKZZ725pVVqspYarjbhZYW2kbYpXtyXqpe0ADT6k8?=
 =?koi8-r?Q?oIv0QbS1YUy14tSI28jEa8+QT6qbZA8E2bxXDrxaenaCehZK83sKPeb9gFoHfC?=
 =?koi8-r?Q?YTdPmqKaRngH2A8kD8C5wagV+MU6ZQ58MM+9tML2zxhNyCYtpwR5/kRuIQe4G6?=
 =?koi8-r?Q?JU4L90UUWsBvFM2KgOjinTK+AFcE+Zf1LC7aOgNXBYE4HkjhXx6ZTestsslnZS?=
 =?koi8-r?Q?tlkkxkdgAw7KOoK023pk/R6wlY/u0KDAlGQCT95DtcQEArS8CMXctAiM9nlLKf?=
 =?koi8-r?Q?0PT8pg9yVVwhFTQDbojrxLYLdqCSyTV//VqPulRy/A2clComxQBJKFstWtpTNz?=
 =?koi8-r?Q?u2cXCZdw+0CUxu31fgsfLnLJK+nGvX8QCs7n6wI4iZCcgUajbt92PPXBv8ZsoF?=
 =?koi8-r?Q?TiZguflyuu/NjKl2DCteJctjMqrhylDcbMcnCCIN/iOY3ZL44O79WmbakWF9zu?=
 =?koi8-r?Q?4FCYk8/rra8jNUpJo2E1iCplRWaTogV8mwV26e+POKgj/d8Powgx86hWdx5ISW?=
 =?koi8-r?Q?vBAQrN/ZLrRBnWscr0wCWXOoNvS0Z+fWRUzsvd+ERQgvtiIsDs03wEcC3wIMan?=
 =?koi8-r?Q?OzPQKWcw5rrBOQWj/vigy0690pX97Hdpona2dXoQGI8H+NVs0P1yWcgDkI/8Wr?=
 =?koi8-r?Q?e58sYvq6P1Ogh7z9Vr0UrCIvVynuz7LTNIoEKIPMItikpVkzKKJbdYK4i29LxA?=
 =?koi8-r?Q?Kpt0ug28MIP/Qg7Dehwn823k30Uoo602v60d4w1k/tcufL8vkEh4RH0cqF6ztu?=
 =?koi8-r?Q?By7iMevmw068gAMneU6MZ1mCoqR20o55pj+xCRfACRPOZeKZcPXKQlAkZXvQLH?=
 =?koi8-r?Q?ePythZoIT0O4a5txAXKHL35OHyEQfxODAxp0UnBfIBnnKk24TIsCdlEcptcDOd?=
 =?koi8-r?Q?jRIjajeAm3uuPmIfoA9UPiZWHFXCYLEt+4qxF+pBEJG3Wc2ZnifYlZDBdKikRS?=
 =?koi8-r?Q?Oal4bril08KOzYDdEnBUB7U/t8yeT0KoB5WkXXOI8ar0JXClpzvPm3?=
Content-Type: text/plain; charset="koi8-r"
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7491.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7174be37-a000-4bec-ddd8-08deabdd7ff4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 02:08:15.5537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Zad/03NodU12suX0ldKfctPcAopAte54QXPQJKKone5Y8EkH405KgrSusMXs3+0LyQo8apzul3kYkFtvyu6VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10700

There are some false positives reported by Sashiko, see the comments
from Sashiko and my response inline. Other comments are useful and
I will add improvements in v6.

>  static int netc_setup(struct dsa_switch *ds)
>  {
>  	struct netc_switch *priv =3D ds->priv;
> @@ -393,6 +627,8 @@ static int netc_setup(struct dsa_switch *ds)
>  	if (err)
>  		return err;
>=20
> +	netc_get_switch_capabilities(priv);
> +
>  	err =3D netc_init_all_ports(priv);

Sashiko says:
Since the DSA subsystem can call setup() and teardown() multiple times
(for example, if the CPU master interface is unbound and rebound), does
calling netc_init_all_ports() here leak memory?

Looking at netc_init_all_ports(), it uses devm_kcalloc() and devm_kzalloc()
for the priv->ports array and port structures. Because devm_ allocations
are tied to the PCI device lifetime, they won't be freed during teardown(),
which could lead to a memory leak on each rebind.

Response: Analysis of the DSA core driver reveals the following call stack
for setup():

netc_switch_probe()
	=84=80=80dsa_register_switch()
		 =84=80=80 dsa_switch_probe()
			   =84=80=80 dsa_tree_setup()
				     =84=80=80 dsa_tree_setup_switches()
						   =84=80=80 dsa_switch_setup()

netc_setup() is only called when the switch driver probes, so it will not
be called multiple times during the lifetime of the DSA switch device.

[...]


> +static int netc_port_fdb_add(struct dsa_switch *ds, int port,
> +			     const unsigned char *addr, u16 vid,
> +			     struct dsa_db db)
> +{
> +	struct netc_port *np =3D NETC_PORT(ds, port);
> +
> +	/* Currently, only support standalone port mode, so only
> +	 * NETC_STANDALONE_PVID (=3D 0) is supported here.
> +	 */
> +	if (vid !=3D NETC_STANDALONE_PVID)
> +		return -EOPNOTSUPP;
> +
> +	return netc_port_set_fdb_entry(np, addr, vid);
> +}

Sashiko says:
Does this implementation break network isolation between standalone ports?

The driver sets ds->fdb_isolation =3D true in netc_switch_probe(), which
means it must isolate FDB entries per standalone port or bridge. However,
the isolation context (struct dsa_db db) is ignored here and all entries
are placed in NETC_STANDALONE_PVID (0).

If the same MAC address is added to multiple standalone ports, such as an
IPv6 multicast group, the single FDB entry in VID 0 is updated to include
all these ports in its port_bitmap. A frame matching this MAC arriving on
one standalone port will then be switched in hardware to the other
standalone ports, instead of keeping the traffic properly isolated.

Response: Currently, the NETC switch only supports single port mode, so
all the FDB entries are only added to the CPU port, they will not be added
to the user ports. So this is a false positive.



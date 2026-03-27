Return-Path: <linuxppc-dev+bounces-18842-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6527D10A1E63
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 02:09:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhkcP6fnMz2xmX;
	Fri, 27 Mar 2026 13:09:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774577397;
	cv=pass; b=WC4YLsYmLk+op1MSdz7zbHouiO57YqsXrEKCAoRIxm4p8xl4CzQQsu1ZsHcvxVGfH1X2HM+BjzZE6o2kiflbz6x2m11NccQQ5NlKlhHFmkaackv7OjAcSukvgeBtUvjB76fuIdkoyA9rUZJiKIiyuwi+soS78PvoTPzlJEvxSZ5/dJhJSsvzPWk0RZGthz84wjeM6bV/uGceIvQA4ZdLfuHZg946ATm0NwmAmxSkogB1zz8bOxSEC8rjjRpTIGg1YsLUOUze+v7MpaZ9jrcq5N58jKenKZjrhA5ogv2c3WpPWKuiZB2lzlrTUc31nf58MexaSn4conArB9B6ELR4sA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774577397; c=relaxed/relaxed;
	bh=kmgNoMsBFB0Av275v1YiL0J71l8nAs5LT4Ra84zm3vg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T8o/A62LrTVJjCZQ3lIOn0XbvzkKUdVPSlHzzNeuCv9nrPlHyDKnSC0onzrDjrF17z1uhBghtIgdsCKFIvaaMUfsLNrS8j+9ULDEsV3SF0h/XlUDkVk396BCpbinZi+rsxat4DJytSsYfjGUybDa11Z0xb7+3Fs/twzGVLsVl9O4wc5pTqwJL97wraLAJrHCpgjsA+cJaxxoZKITXTRg1200ChdJ6L99TX1Zh4w21dpse1E59yWcDkvG9YOlsSUGqeI75iN6La/hIPl5uaTv0gDgy2kfcHTPnWrri760LffTno9MOKWOV3klLFDsqxP7JLxtv7Bazdt1prN9WIw8YA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=dfVO1F0/; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=dfVO1F0/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhkcN1M8lz2xR4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 13:09:55 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmDtMJbZf2v8jpixnAmkQx+JVN9zy9dK1Xx09MXQExkOUeB+qb/4fL7oDZ3NIChv3OAjFRbr2z2H++VzBtH3t564dRdAyRNzHKUHxeRX/WlWw4sYi9hKEuS+kcAieSs0MMzJPZ7854Ma4jchVBWyULRzgedXNanq2tTsiaseLWu+4eVrPRKYUixLwt4GdEh9Veb+C7RDYZUxuJikoke8q3vma6/6FIW73ihHjYl97faNHaPS2wnfFUoh6N0oEyOVA7ODYvw8DklxdHRPVwbP0oZNHM5ox69Q2n25NQ2a4/tSB0xJuA+PpVR29CZ01XMzOJCHICHgQ08ziuMOLaqOOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmgNoMsBFB0Av275v1YiL0J71l8nAs5LT4Ra84zm3vg=;
 b=yp4hIEYe/vk+z7/leo9/eRqCT/uOutQePSQz45T3BxfI7yd3vJuYFNKaVqrkIKomNW57BMoIfaLKJZ2DPurdf889CAYmm4eCmEmEOH5OBKGdUspKRbgl8Wvh+BBwZ/wO6/pZGdXjQVWPWxqng+cAh8ncQsqpquabYKGKHzd9254lzCd8ezWWKnt7YVZqk6uatHG9fxfBh379GlY6kFZnZwMwfmUfomFFbIeZsGEQeX5JGcXIKsYik/IVSfXwDZGKJDn3vjbfnvyIoR7VTOazXr7co6To6FEZiVHWqUhK8p43U0LZd/6Oy4vX7857IcnS6iuhqJshw8oCWLmc1I+qEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmgNoMsBFB0Av275v1YiL0J71l8nAs5LT4Ra84zm3vg=;
 b=dfVO1F0/u3L6NH+Qf4Ks2AoxKSQYav1RopvnfD7VKMMXv09fH9t3DfBHNHe4OecAqq3WEVf4oWgiUAhgtFIdy3K9NgtyyOEjLwPk4lHRKrYwyfR+B1AnB+A+m7zhewriUGS5Bv7Eepz0s/csk8ahFVe8ikg+6WnLBOxs5V80nYPsBDg7+vJ4jknyslr+GX07MQWFGT6pVrgLxw2oe/ypRRZ4FzD0+T2sUWcCaCOiUJz2CL5005uZ8KPw12q+vkkuDwLE6IJUdXEokGQ8ymMQz73Y4cSi2UcCNQ9PLe73RB9y4Ay3kcF/D48eOVSr6VBUcpW1ehC3q2VpTpomT24b7Q==
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Fri, 27 Mar
 2026 02:09:26 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e%6]) with mapi id 15.20.9745.023; Fri, 27 Mar 2026
 02:09:25 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "chleroy@kernel.org"
	<chleroy@kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH v3 net-next 02/14] dt-bindings: net: dsa: add NETC switch
Thread-Topic: [PATCH v3 net-next 02/14] dt-bindings: net: dsa: add NETC switch
Thread-Index: AQHcvOmiCqGqD8E13EaBFJCRDGW3MrXBPkuAgABjMsA=
Date: Fri, 27 Mar 2026 02:09:25 +0000
Message-ID:
 <AM9PR04MB8505D880CDAD79A8AF107E248857A@AM9PR04MB8505.eurprd04.prod.outlook.com>
References: <20260326062917.3552334-1-wei.fang@nxp.com>
 <20260326062917.3552334-3-wei.fang@nxp.com>
 <acWR0QwRSnupmCvI@lizhi-Precision-Tower-5810>
In-Reply-To: <acWR0QwRSnupmCvI@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8505:EE_|DBBPR04MB7946:EE_
x-ms-office365-filtering-correlation-id: 8cd3a518-c330-42b8-153e-08de8ba5dee2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|366016|56012099003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info:
 GlJBBQeoUmtD3w8t8FPNdYxdxRHzO33cf1lOVuVKL/Ky6LuJ/QKvvJSNpNzHKCXICm6ygrlVoaJzDijek/knGqkjHg96wuIWwpUsa9dKWKVyJW2r0ro8xaYC2FsaxST3qcoDkN05y9PNfvYxokyzWNGY6eUw1e+nPDs8m5M6Rlr4Fda/4JBwK+tSaFMidW4VBFyfF/jMGdK1pWuS8DHJzw67KFcPMWihIFtkm5hqzSCx53y44LwGikkCl7Ybk7Y/TJ0uEf9d6dDE/99/AqDBMx6nZi34YJrVP1UtGBxhpmG0NwmhpoQBMnq/vZEciU3iz5ssf23gfVKeVlUl7OzeEhAmhbQZMch5rtVo+daOpaw1DaTda3XIc2oEXIaPv/lYh34dh/P4in9cq2dOyrtkczGaLSHUk4T4O+MF2yrJPsyBtdvaGdocJCpmULcfsc2nN2Lsi4SF8NcJVaYnN68eVMr8JBetSGQO2CRdO1BtVV49amVVJyWA29C982NEK65fwXqH0YeDFIlV/J1tLctjSTzSVvSA9y9p31AbQ3p9areiTot/frik6GGU9EizQQZ4KQq4JOoWdNYggThxnFxaCb8nzpwwI3yXp4C86US1vyEUQzY92AYNX5wQlyDvYOkzWw0q77KylmyXfzs3IbgynObqDhEw8NLs9/XTS1+lH1txP3wbHGtVtbvspU+beVsZTf4z+8PbJE3/tRKUmP5uOZEQqNzoAz6T28KRI1Eg2wA6ET3+W6qx8bPS3e+OMDuV
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(366016)(56012099003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?krxOn/Mesc/dxqFU1WqDUiYhwN8rdbRDK7UbVjHNXOMpiKdbN0LOSVTW7FTs?=
 =?us-ascii?Q?7JP7iPGHgcz9b0yNbMGiE3SIAP0Vu7BzLt67k8FcBCzdeWwgBPZtmsWy32OD?=
 =?us-ascii?Q?Wf1DvtNft+FEBhe66U6oxTi+NwEWUVl52t+gtD7hS+DRaGaO5FkSyrufBIQv?=
 =?us-ascii?Q?aXd43R6Te++5H79jEXPnYN11WUkrLz+a9X5rDtOW4CwvvoYxir3oVCxPa+Lk?=
 =?us-ascii?Q?R0tipuXHzqknD5VWZlBWKODBLWBc8j0+icxneNvcBYIfUwRWzbneeWjTuDvL?=
 =?us-ascii?Q?6wU6VwtTWvkpIpNUk2FYsufsWBqzC/nDMqRJQ23L3V86d/t80Xf7WWsZK2Tz?=
 =?us-ascii?Q?93QOY9xMkxCg9EbtDsT7j8ThBeWtFUf5zS45suoXg1wDabV5N5q+20JFVT5t?=
 =?us-ascii?Q?JObCPliavBJrpWh3GYosErD7lcgEbaUw8sVkZivDvxx6yflONMFyqdQea5wh?=
 =?us-ascii?Q?Yw/LqEWrLaBIZ1qUjZLCLhBsAuYD5rHEs7p29BpjfiymbFj4lq0QWTLc80uq?=
 =?us-ascii?Q?1/YLI8EAtYTLFL4gR5dPrVCmmuPrAm5QKs2ypPGjiflZMEZT52Y97EmLH6Hg?=
 =?us-ascii?Q?fcp5MVspxk8c550VKp7U9qxstCWSM7kNQLTQJ6ZGsEMA1oIThTN5zsA+5Ex4?=
 =?us-ascii?Q?1TKMgTS6KqqELOX/snVO8blejytfhwAUqyIaxG/7TL8QgFbfHn36np/hMj7Q?=
 =?us-ascii?Q?96kyBTGi9HdfZ5UJxrK48v2jVl21ZqU8HiGMR6u7AytSIXxsMcRZqilR8R1z?=
 =?us-ascii?Q?yG6GUKQ86hWR7xsjf2fC8wSOgMOhWer4v9KawAH50XorfNlEhgxWnThPE8MG?=
 =?us-ascii?Q?eQX+l8I0fs7YsN19ctQNdTMk+giXPNWeTqs8+DE8zvCW1EibMX3d93i4j5n3?=
 =?us-ascii?Q?TVG7mUco6nbu6Wckh2cmplKQMmfK1B+cwjDBGDSbitfK2t/glzsqibRVOFkf?=
 =?us-ascii?Q?rE/lQAka5ruH0eJIkSRSOM1izYt3+pUi9v0JNTKIf0c3pH9VrND7W7NiVQMm?=
 =?us-ascii?Q?5LxriPPDQSJH22wu5hv2GrEk9ienAa1EarG9OXNZ6dbRKrh058jyCdEEkuIp?=
 =?us-ascii?Q?REwK+TL6mDRxwBaOlJiCkQwTbcXEnEI4znzutgIRxVTjKolwNFj3I2eHu8c1?=
 =?us-ascii?Q?q4x3GFtcacjYboqiQNW09HHfZay3RMYfIWE4NkQQ45FGFRXMThCXbnTTldZC?=
 =?us-ascii?Q?rM6W+MKRKtgaSqBCYaQMTtlrQQaym33ktqu49zrPMyhKTs2YD0Nr1a0HPnUT?=
 =?us-ascii?Q?/kRpORWvaz9R1h3NKXMWNUFYp8k0ZAAIf7M0Do6GfVT42ka1S+kpCoFmlo88?=
 =?us-ascii?Q?bQX3n5xVQ5TJocmH2mamtmUYMos3Yf3Ezc0tV7yX1lRjzk27VgIssualegjO?=
 =?us-ascii?Q?YcWle0fu4IsIk9J9yjKDl6k1oqjGqEzQHCpaeSvqgV+YsatkSItylWhkndNg?=
 =?us-ascii?Q?ZfALv+Y3ajq+owkior/OGh7sOUgDCZWAFnpIJYFh/eaqVj11MZcJ1HF1OWW8?=
 =?us-ascii?Q?vC4kpeEHdy4P14JBj3mtxhsSlp/uMd4e1GD4rhcig26tWxfHmfIq8Rb9J0p7?=
 =?us-ascii?Q?MmDBUX+XJdlX1AXWDPfV0dBeBlsEfNtO0pEdzAOgCFWCTDFlPCBtbOHMEKlC?=
 =?us-ascii?Q?39a2e07VNYVvJIUwjdxuXfEk/3kDbb+OKcecMbMWwDDJhLO2ir4EBBY9hiqX?=
 =?us-ascii?Q?/DA+eAiR4e3peVjqcc2zJe/gNvVAP2yf9iCyDO52UGvf3Jri?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd3a518-c330-42b8-153e-08de8ba5dee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 02:09:25.7979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fd2iwcNwsBQWxeEkfoCmfgw2ly/s5fjwgW3m7bG4QSqKG4fhLjxjuuJ381wbVwxEcy+04oZBi98gaAMcg9DaEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

> On Thu, Mar 26, 2026 at 02:29:05PM +0800, Wei Fang wrote:
> > Add bindings for NETC switch. This switch is a PCIe function of NETC
> > IP, it supports advanced QoS with 8 traffic classes and 4 drop
> > resilience levels, and a full range of  TSN standards capabilities.
> > The switch CPU
>=20
> Nit: double space before TSN.

Thanks for catching this, I will fix it.

>=20
> > port connects to an internal ENETC port, which is also a PCIe function
> > of NETC IP. So these two ports use a light-weight "pseudo MAC" instead
> > of a back-to-back MAC, because the "pseudo MAC" provides the
> > delineation between switch and ENETC, this translates to lower power
> > (less logic and
>=20
> what's means "this translates", do you means "this help reduce power and
> latency."

This sentence is excerpted from the NETC Block Guide. It is equivalent to
"it means".

>=20
> > memory) and lower delay (as there is no serialization delay across
> > this link).
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> >  .../bindings/net/dsa/nxp,netc-switch.yaml     | 130 ++++++++++++++++++
> >  1 file changed, 130 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
> > b/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
> > new file mode 100644
> > index 000000000000..e34a4e3504c3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
> > @@ -0,0 +1,130 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/dsa/nxp,netc-switch.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NETC Switch family
> > +
> > +description:
>=20
> Nit use ">" for multi paragraph.

Okay, I suppose I also need to add '>' to the below description of
"dsa,member" property.

>=20
> others look good
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>=20
> > +  The NETC presents itself as a multi-function PCIe Root Complex
> > + Integrated  Endpoint (RCiEP) and provides full 802.1Q Ethernet
> > + switch functionality,  advanced QoS with 8 traffic classes and 4
> > + drop resilience levels, and a  full range of TSN standards capabiliti=
es.
> > +
> > +  The CPU port of the switch connects to an internal ENETC. The
> > + switch and  the internal ENETC are fully integrated into the NETC
> > + IP, a back-to-back  MAC is not required. Instead, a light-weight
> > + "pseudo MAC" provides the  delineation between the switch and ENETC.
> > + This translates to lower power  (less logic and memory) and lower
> > + delay (as there is no serialization  delay across this link).
> > +
> > +maintainers:
> > +  - Wei Fang <wei.fang@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - pci1131,eef2
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  dsa,member:
> > +    description:
> > +      The property indicates DSA cluster and switch index. For NETC sw=
itch,
> > +      the valid range of the switch index is 1 ~ 7, the index is refle=
cted
> > +      in the switch tag as an indication of the switch ID where the fr=
ame
> > +      originated. The value 0 is reserved for ENETC VEPA switch, whose=
 ID
> > +      is hardwired to zero.
> > +
> > +$ref: dsa.yaml#
> > +
> > +patternProperties:
> > +  "^(ethernet-)?ports$":
> > +    type: object
> > +    additionalProperties: true
> > +    patternProperties:
> > +      "^(ethernet-)?port@[0-9a-f]$":
> > +        type: object
> > +
> > +        $ref: dsa-port.yaml#
> > +
> > +        properties:
> > +          clocks:
> > +            items:
> > +              - description: MAC transmit/receive reference clock.
> > +
> > +          clock-names:
> > +            items:
> > +              - const: ref
> > +
> > +          mdio:
> > +            $ref: /schemas/net/mdio.yaml#
> > +            unevaluatedProperties: false
> > +            description:
> > +              Optional child node for switch port, otherwise use NETC
> EMDIO.
> > +
> > +        unevaluatedProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - dsa,member
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-device.yaml
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    pcie {
> > +        #address-cells =3D <3>;
> > +        #size-cells =3D <2>;
> > +
> > +        ethernet-switch@0,2 {
> > +            compatible =3D "pci1131,eef2";
> > +            reg =3D <0x200 0 0 0 0>;
> > +            dsa,member =3D <0 1>;
> > +            pinctrl-names =3D "default";
> > +            pinctrl-0 =3D <&pinctrl_switch>;
> > +
> > +            ports {
> > +                #address-cells =3D <1>;
> > +                #size-cells =3D <0>;
> > +
> > +                port@0 {
> > +                    reg =3D <0>;
> > +                    phy-handle =3D <&ethphy0>;
> > +                    phy-mode =3D "mii";
> > +                };
> > +
> > +                port@1 {
> > +                    reg =3D <1>;
> > +                    phy-handle =3D <&ethphy1>;
> > +                    phy-mode =3D "mii";
> > +                };
> > +
> > +                port@2 {
> > +                    reg =3D <2>;
> > +                    clocks =3D <&scmi_clk 103>;
> > +                    clock-names =3D "ref";
> > +                    phy-handle =3D <&ethphy2>;
> > +                    phy-mode =3D "rgmii-id";
> > +                };
> > +
> > +                port@3 {
> > +                    reg =3D <3>;
> > +                    ethernet =3D <&enetc3>;
> > +                    phy-mode =3D "internal";
> > +
> > +                    fixed-link {
> > +                        speed =3D <2500>;
> > +                        full-duplex;
> > +                        pause;
> > +                    };
> > +                };
> > +            };
> > +        };
> > +    };
> > --
> > 2.34.1
> >


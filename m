Return-Path: <linuxppc-dev+bounces-19487-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4226FD5F98
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 08:36:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frGcQ5g3Hz2yVP;
	Wed, 08 Apr 2026 18:36:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775637366;
	cv=pass; b=Klh4yBCGlgk4EFklBIlsk8pbYQoTOnShaO9aTEmbCCeye6L3eqt73EaC/VcTlsJ0YIPcjy7hHA6uNJyuwicJDsAUD/LseT/bkq1sC/W3cz0mMUfTQkJYXQk+VhVEVOgTPpuo48FGefF9doKbDOvuAWrpwOyQzTAD8GtfeVC/+2FtN+NNToVDXcqoCYJNj9JNLpRBxFXwS6fv1nMDFMe3PPbfoOVEIp4iRExFKGxWPOdUZG4IWx3qZ75lh+7nrWNIlCjcWJG2GkwIp56qux1UzidsRyGat3dtoxFt0weV1+AoAww2qADNk4L9UoWzYnvBdv+UY0ga1L4ltSnJ63Ev6g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775637366; c=relaxed/relaxed;
	bh=pXbnSHQqmV0/aVnONGzIEHVXb+vsBAgbtY2mwbyuEm4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vky9PlNzswSsFde/aD4PSgbTh0Vml1OEj8KLcw4xtNCLyKmO5KyYzySHdd/x11R0AHDwo4nv4qE89O9IL6Y6SRmFs2Zhq+29YEkqqaf/hFpePb7BzoxGQPlwUc68sjwNSdy2QqexgEqiVAsdjg1Mquhv+0aq5oWUyGr6ljVKKC4+qRdB4LPf3+PV26eeh6xnOve2WB/Sp30JcgBQNSFYUFNHZp4SiIuCAStgaIoQQuqUWWiZzkyfStdFRU6U/Gl26IbVbXRp8r1wYyQCOoayz+cpbIgQxaUAh5NVJ5lzrKDtENMRcCEPLeA3j68HtGUtXFS6dBQvAovStaXsQEu+fw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Pe5f2rLp; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Pe5f2rLp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frGcP2SkYz2yC9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 18:36:04 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hiSy+H73Ko9+8MncaIqoOcEN6TUWqFQ7gYpXFumiz6/bdP9i4k4MC9+fsIS4EZ8O0002csxZFUbLY6LB+hAj/uenQKXqKPnU6tJduDlHRChUO160iLMraeROMBKMdHAmxiEdUZhuO54fjoWX8HwcmLXVppY177EG7NRHDIw9nupDrgufiSRSVijxsrOHPHg/+Ee3cveTvXyfMfHDGx3znm00x/dowsc1p4eRkNxNuYRTyv+nfkFK8EAOIm14lyHZ4RjH6oiwRbfak66OZrU4cIdYRvzJqmiZNVaPBW6QmYsNUxIVCNjR0mYmI2XE+aLpObj5krBIhV2ZxaqjtfYgRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXbnSHQqmV0/aVnONGzIEHVXb+vsBAgbtY2mwbyuEm4=;
 b=BskXMpnd3V04vL42Nv54sIxPGLhMM+cwPwJ/37pUu8pp0wYmLkeF7HDnonYwTEyoiHDnEP3SRRvxIAGkZyEyhvire6V3kFJaGAhqabHtBU0BHtgF3SMk/guGvDKgW53H2SeRsFcAUMTJoE4ggUKPK+DmzmNTIE1z9lUUjQ6LqhZnkS50wNYQFRUL+eByjPyyb0enYHk8pVID06u5/Ryu6tWGWdnxq0mtVorH6RmK1l888uTWrAKt3AF9K61ENP/11SRPigtAu7LSuWf00iIInK2jINRToapVE5SMwo3UgJESQEMTE+fQ8FmBX9v8g9J16TbJ2qoMM32zC1bOjpA9uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXbnSHQqmV0/aVnONGzIEHVXb+vsBAgbtY2mwbyuEm4=;
 b=Pe5f2rLp+KKXbkPTWHCkvkkBWOHzsJgROBG5pYhg/ufTEmAZ9x/CdhMBnkP5+RWpJnx2eV5E0TskDMXb04EOSH2q2ukKlKL1iKa6jLqakBNEUX3H9EkbY4DabI3sNQADybNBEYJZdJuNcs/UUQQIZWMb91m8Kur5okQFLHJE8E2uqN7butTir5cguMv8Zcs/q7ApThmuXH76BFzbP0NBsKZ1jS33w4h0DhMj3o51sL3SS6JRr/W/ZfhNnTOyNu3MwrSiBk2jsmIhaaXG9YxrqwgdhqY/LyaLNtwHvDXgYQ+cuvEHWbs/iMbVE5mcEGCN/SVcxKXH+GeG/kvC8mP27w==
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by VI1PR04MB7133.eurprd04.prod.outlook.com (2603:10a6:800:126::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 08:35:33 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 08:35:32 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, Frank
 Li <frank.li@nxp.com>, "chleroy@kernel.org" <chleroy@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH v4 net-next 09/14] net: dsa: add NETC switch tag support
Thread-Topic: [PATCH v4 net-next 09/14] net: dsa: add NETC switch tag support
Thread-Index: AQHcwQGnBHohH8Ym5UWBzU905T1AvbXMjUwAgAhMYzA=
Date: Wed, 8 Apr 2026 08:35:31 +0000
Message-ID:
 <AM8PR04MB72840381B3C4C3A0A63BEB76885BA@AM8PR04MB7284.eurprd04.prod.outlook.com>
References: <20260331113025.1566878-10-wei.fang@nxp.com>
 <20260403011736.1795610-1-kuba@kernel.org>
In-Reply-To: <20260403011736.1795610-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR04MB7284:EE_|VI1PR04MB7133:EE_
x-ms-office365-filtering-correlation-id: 5c241562-ce57-4361-5eea-08de9549cc02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 sJho69hb19PSUWlJmRlDbxfwoImKnlnBALqBBTc6EhW8OmZCytJpz4dbasx3JHjybm8Ur/Ig8PuuVnfC7sdqAW/tMdZna0+3a6JQRrmsIDQia8SbZPVep7Kaw9BomfamCr/ALGQnvC3d7No1xQeMu2KHpXz6xYFy9xoc9P/2e3sHYRcVkV3tckLNKJ9VYBdU3saabxpMYYDmzmm8k0GRr2tXmMNMcb7GNNKDEjz/qXf8GQrmdnCiPxVWZsC9oU8p9dC/4rzpHOKm10Ca/d9jHCNW1KwbLITuPi9Ehp2R7/26/qfINCc8ZNLGErEHHR/YxuG+SvwBIxxW2cm9fpu8h/O2ZXYyr2m7pJBFO0YW1A++4GIdmPNDcwsyHf4+SvGgg336M+1SWIRsiYefV1+9M3p11olZcnWYMGL5woMmuQdx4L1KMIpGa3+j9G2TPUUr0lYL2KWlUcUmlqoZV829j4ZyCArJDdqQjWm87VOKhbHS/hfbPSVJ4IMJNmMaugqkiBWbOn8XgLXTtw3VYDxNdgnMlbUZU9c5UfsR6VGUHlCnGcPBqwdFcQjyRkuZAqe7qQRrtVaimwHasBdiJTMJdkYu7G4nGVe1kekKDVLGe7QS0ytM9wEsGJnveQqeJ4OzdOdMcNlfZxGLcFFrxGzMJjMWzoaiVEAtGkkvUBF8q95qGTA7DqkuhGzN1wyfvn41xYPxuL9btSSqTjrFqL3xWXeMX9X7W6Nc7hPjwRg8QpWtWbSvZPcAsAh1JSR7D+XG81k5RmXTAs0MXRa4D7rUIDnR9CgzySLW4g6p8DLnuXA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Cj01t5mXVo378lEd1Z015hW6pRKG3Gv/FLNt1GLb1yh1tFqtHsdosnbzsOgc?=
 =?us-ascii?Q?QpCnf4LG2f2VZ2ErE1PnRXnk8mAYad8TnFnsbcV/qG4NnxY3zp1WHmTbiDZy?=
 =?us-ascii?Q?YcYjPdSQ7aOpej0ZGU793S62aB0pI5B01KCvYSlGNnJ2Xs9brawCBaMnc4lM?=
 =?us-ascii?Q?t0royd1No6zXmVtINfXrSkXI/aNh5v8j8Gkg2VZqZT6EYqXhgfZDsWXU855X?=
 =?us-ascii?Q?/QpdN/a4j7Yex7JqWxNgc1grohWF6e8Yt6FEBMo7MFuJcwxHxL+SpIuAwUuG?=
 =?us-ascii?Q?XkSSRVjlCZo4XXiduoowThrlxHlNQSDqOn8myyJ8vN53DFE9H290/2GuMSP5?=
 =?us-ascii?Q?m+MBYlW3LLl1Si85XtaHyWq6lRDGskXnj11VLtgZ8+KeXX04XurMWCU6GGZx?=
 =?us-ascii?Q?8RRDIcymG21ZrYjNlOzlSbL0IMKdkba8Tn+LY4wzTFzewpuUcOiiu/wtiXOJ?=
 =?us-ascii?Q?EZJjZuZoGGNOW5fJkGsegVfaWNBSGxTrjAk12o1m6OWxRJKiES1E03NEiLyA?=
 =?us-ascii?Q?gfgwnhhHqc/laRSfdlh1cKvqgNcbr4lJXb5pNLhrT/gCJeZ+5OHbs6Hi7CxN?=
 =?us-ascii?Q?mLKe7trTk2uSVqgD1QGjhLS/RxoYqyEnGc8BXv9KJjm1yJuSptIeQSglmHZI?=
 =?us-ascii?Q?Ev4PcJskVaf3Z5yIqD+jW7PSVO+GG7YnTbmDP301OlocrVXoOOaDA484YNAT?=
 =?us-ascii?Q?E63wZkNA54adtA6hfEfJ9Sr9BBtdSrP2Gh/WrKrx3QBwOAl2pI14Hd35Q5BI?=
 =?us-ascii?Q?ia3PgUHKEj7xj8zJmWVxMlybmgBZcnVk8ohkvWdQ2UyQKwXpucQ20u+3qWgF?=
 =?us-ascii?Q?qJ6XHpE4fWSN0rjQBPj8ukLmuwATFC24EXadWaXcvXAur/TfgJ8odV/3TagJ?=
 =?us-ascii?Q?Hx7Ee17v2XO+MMxdHuJttxRYqZXjSXUfmf9HTqWMedZ835Jy0M3ZUJRosN4A?=
 =?us-ascii?Q?IMTTD9t63lQ9aWgaRMt15IhnW9+9dJKzNWxGdau1MuVHfmb22CLTENLxXWGJ?=
 =?us-ascii?Q?azgNh6O1zCNAaDQqNtbuIqyGhMVEmyo+PugVQmqVvlkgfn1Fch38evJrw+/9?=
 =?us-ascii?Q?vdBlph3f+1vTL6TcaTN7RYg8oI+6iYb6WLMUzvdtC0rJkqenO+3SlgUZ66oa?=
 =?us-ascii?Q?C3XCViYGVLtN1mGbrf+74jw95KIx1AgEusF3gRXlht+0kuHpW82gKscIoTHp?=
 =?us-ascii?Q?Tre8kDc4VAKKMjJEcN/f06ICwZx6qUC5MHRWVENltfPaM/iGa3Pm2wOHmOfo?=
 =?us-ascii?Q?jPL26atqp1KpjWJ88qvVGyyjBN6uAD5rMFun25CugGHZoL1IM4Zaxhe4ZTcJ?=
 =?us-ascii?Q?e9ykv46RiDXFElqTvvPyvsD75vrBzx8kWthNXwrw9jQRWr/Xo+VpDAtqFQjY?=
 =?us-ascii?Q?Wn9knJhsEGDpHia4pPkHB7X/dzBsygtA3Lyld8bMPcKUWtPTsIg5ZLaRVcoM?=
 =?us-ascii?Q?PFvycNjmG4Js5QDjmXpfkIUBvxvXnW85yWU377FDgeLu40VsEP2d6rsf1zNO?=
 =?us-ascii?Q?pN0ZA0psi9Q8CufHWalqdtdQQBx20d6i9NGI8VAZZBBKNRTs34UjZBX6elCK?=
 =?us-ascii?Q?uagN9o2QL7hfM/kAKHZODRmg4rv+riOWCz/OS0c+pngGj7CyRcXWJuPbsu0C?=
 =?us-ascii?Q?jL4NqdrWbnamjfiULeFs0dlUG5v1wzfKW6we6Tk2xST6uHDnNAlriMqJWjK/?=
 =?us-ascii?Q?pVvsZWjIbsrVh9ZsSWl7Ld5JyOeVcd4uRqUDO8Cj8Y8wrmi1?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c241562-ce57-4361-5eea-08de9549cc02
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 08:35:31.9711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nf+9dbL7k7nY5xXMzXqXLX6PCTsiFiFK962eMa+0rjC/Xj7Gxzt71QC52bmzVtFV4NK+Yu0Pf7sQ7Nwltaailw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7133

> > diff --git a/net/dsa/tag_netc.c b/net/dsa/tag_netc.c
> > new file mode 100644
> > index 000000000000..addd41f7f1b6
> > --- /dev/null
> > +++ b/net/dsa/tag_netc.c
> [ ... ]
> > +static void *netc_fill_common_tp_tag(struct sk_buff *skb,
> > +				     struct net_device *ndev,
> > +				     u8 subtype, int tag_len)
> > +{
> > +	struct dsa_port *dp =3D dsa_user_to_port(ndev);
> > +	u16 queue =3D skb_get_queue_mapping(skb);
> > +	u8 ipv =3D netdev_txq_to_tc(ndev, queue);
>=20
> What happens here if the interface doesn't have traffic classes configure=
d?

netdev_txq_to_tc() will return 0 if not TC configured, I mean ndev->num_tc =
is
0.

>=20
> By default, netdev_txq_to_tc() returns -1. Because ipv is an unsigned 8-b=
it
> integer, this casts to 255.

Okay, this is a potential bug when we add TC_SETUP_QDISC_MQPRIO
support. I will fix it.

>=20
> When this is later passed to FIELD_PREP(NETC_TAG_IPV, ipv) in
> netc_fill_common_tag(), the macro blindly masks the variable, silently
> forcing the IPV field to 7 (the maximum priority) for all default,
> unconfigured traffic. Valid TC values greater than 7 would also be silent=
ly
> truncated.
>=20
> Does this code bypass the intended QoS mechanisms?

No, configure IPV to send packets according to the expected TC.

>=20
> > +	void *tag;
> > +
> > +	skb_push(skb, tag_len);
> > +	dsa_alloc_etype_header(skb, tag_len);
> > +
> > +	tag =3D dsa_etype_header_pos_tx(skb);
> > +	memset(tag + NETC_TAG_CMN_LEN, 0, tag_len - NETC_TAG_CMN_LEN);
> > +	netc_fill_common_tag(tag, NETC_TAG_TO_PORT, subtype,
> > +			     dp->ds->index, dp->index, ipv);
>=20
> Will this break communication for standard single-switch setups?
>=20
> The driver passes dp->ds->index as the hardware switch ID here, which
> defaults to 0 for the first switch in a DSA tree. However, on the receive
> path, frames stamped with switch ID 0 are rejected.
>=20
> If the physical switch hardware uses an ID greater than 0, frames will fa=
il
> the lookup in dsa_conduit_find_user() on receive because the software ind=
ex
> is 0.

We added the 'dsa,member' property to the netc switch DT-binding doc, speci=
fying
that the 'member' (switch index) value cannot be 0. Furthermore, the netc s=
witch
driver also checks the switch index to ensure it is not 0. Therefore, the s=
oftware index
and hardware index are equal.

>=20
> > +
> > +	return tag;
> > +}
> [ ... ]
> > +static struct sk_buff *netc_rcv(struct sk_buff *skb,
> > +				struct net_device *ndev)
> > +{
> > +	struct netc_tag_cmn *tag_cmn;
> > +	int tag_len, sw_id, port;
> [ ... ]
> > +	if (tag_cmn->qos & NETC_TAG_QV)
> > +		skb->priority =3D FIELD_GET(NETC_TAG_IPV, tag_cmn->qos);
> > +
> > +	sw_id =3D NETC_TAG_SWITCH & tag_cmn->switch_port;
>=20
> This isn't a bug, but is there a reason to use a raw bitwise AND for sw_i=
d
> instead of using FIELD_GET(NETC_TAG_SWITCH, ...) to match how the port
> field is extracted just below this?

I think either is fine, the final result is the same. I just wrote it this =
way for
convenience during implementation.



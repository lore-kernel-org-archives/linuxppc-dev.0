Return-Path: <linuxppc-dev+bounces-18748-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472781093176
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2026 01:56:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgVQJ5y3bz2ynn;
	Wed, 25 Mar 2026 12:56:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774403816;
	cv=pass; b=dqzVF1i8o3Etko2iTRjZo+8axnmsA2dY0TFf3GYJZQvztqJRldwpIGoFQ3Al3wv3yE4fBWRqXLOIx4JX3UsAm9mZryelmtbqOOhZN/jd4ukoorNk3M90/cLy2ta9yJAwwpXWfJ+Qp2oae27bVwO3Uiw2tDNLKMSozKACoGqI34b4BaUAI/FBkLaLihXoRIREhPrfXEEeHi33CjmDw9D85OtVnU3yJe8aJBRYK+AHJG0fY9ug6NunZPYFasAhvgfMwARC5Jr+w6tgnE12i2Lg20PtYMKKI5bai3JQdVDlpCAguPLp4rH7apdyZv0wriyl2pEqZMiiU3p97ZiIqIBMgg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774403816; c=relaxed/relaxed;
	bh=LipyGb1uaKFgVErsUBU6k7iGPDKWaO01Rw4TAi07lm0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GmeC9kseiujBdgBkxO+2qjQ1Vtw9DkBZxKYGxsBAH1tMXldgGmjRGgVXA/EAGAQgFy23VI+no2+cPgNDt9BC5vfMwMit0BTBzEycSebZ/qa7o/yzDq2r6u2Gen46qtqeukZJYJ670fsycaNLN7JYOPPMfNO1uIJUJdewkJ+O3G6Bt9zqgYX8GRWe5nRFjuAjVHOVTP7FXVfK0E5HMr6FsSlSm5942xNwt3Vqy7Vh1nTG/xhlONwr8OrwhblNx1xuxwulXXhXn8aJtROPJtnnowATwrs3WNJOPMmoWJL9LKzJstUvRhNQUUaSBiyBCSKEGhLqfYhO2es3p/RJXtG97Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=EiZEzkyX; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=EiZEzkyX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgVQJ0TfRz2yng
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 12:56:55 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GR0J9tXUuEFcUSGMcBu5afd0zYXIVTLV3IqxjxlUgAP7flMl1l/f1LDmOwF5Z02lfigGLo1mO/xc8RUXl0LztmkwzKAq4AwQwi5kQ4HtPTf8dxawFo3qBdCRcPO0dNCSvh+VaT+0dX7xDDY3lyDxW3dbEBAGk80E7fJcjqDdKGJ7lmd1Rjig4BdRoea6cKMDvr4JNHRQS+2QOXXh2Ouw6Iy59pkVnmyvAGOkuKK6Myq1N8dw790eWaww7CGN71z35LFIm7Ow5sAKhqSCklqI1ob6al8no/pYZiC+/1wptMqnBhVp5y9zg/NffR/hiM/UVcNPZR1bXKwN3mXuiSayuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LipyGb1uaKFgVErsUBU6k7iGPDKWaO01Rw4TAi07lm0=;
 b=FO1os2AhvCewQnkRKmV1yXmWpuZ94GGjtGKaQC/5z+854GsPN47wsZnvsf4XdvzTAO+FYNHm1tYw0qwaqYuMXVSjA1zYs/k8/u2bEmHi4I8iVdJt0J5xKOrc+JFYLU6kX5mRksctbD4rlgFRwiCJeu3R5N0Sb8Coz8y8l+IPszNn7XTSqjD4EuWavpzcdLp47MYenH4VOIdGyMy2pvyC+/UjYY9uNqn2AZZSrqcTCtNTT98unDFuHIyhYNAFEfWVa+axt5cOuFcjdRlWO7HeoHOZofYkNm/yZ4OP4Eagt3QWs/q0chyrvKdIdJh8zf2bLQ7SjGfNxcMGWHfVBLhOLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LipyGb1uaKFgVErsUBU6k7iGPDKWaO01Rw4TAi07lm0=;
 b=EiZEzkyXc0LGOWmrHBlJrQZl+0zNSMa47NOgggmUjuEJbYdhjwcHYtCYiJlwXvjDBL/gPnAesi1zA1ex7AAg0DH9RniD/nvK6KlbaME9sF0hKgRS3ZAW419gaG/9pyYzbkl9onz4jliDzqjX9hz0JjLiemjHu0L8JVN/zTBnZ0QU/h3nVMOztdVDPh5sO1knCDsW/e0l9DyqzXp74XVmw0PapTjVzYDQLPamxHXa6SZzuRVjw6v8e6+H4FKxvIzWy5+sUElt2bsY89A5FGlwd8IS6Cvx23zG3IXwDmbdikJbRzCkDO0CaPTgeltn69fWUmYi5D1WRtWcSBDL21PCbQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7202.eurprd04.prod.outlook.com (2603:10a6:20b:1da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 01:56:30 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 01:56:30 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Simon Horman <horms@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kuba@kernel.org" <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "edumazet@google.com" <edumazet@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"chleroy@kernel.org" <chleroy@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Clark Wang
	<xiaoning.wang@nxp.com>, "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH v2 net-next 08/14] net: enetc: add multiple command BD
 rings support
Thread-Topic: [PATCH v2 net-next 08/14] net: enetc: add multiple command BD
 rings support
Thread-Index: AQHcuotFNlR1yxQ4VUK/tt2odlv6rrW96awAgACV4qA=
Date: Wed, 25 Mar 2026 01:56:30 +0000
Message-ID:
 <PAXPR04MB8510F3131FA262918E4329678849A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260323060752.1157031-9-wei.fang@nxp.com>
 <20260324165804.245011-1-horms@kernel.org>
In-Reply-To: <20260324165804.245011-1-horms@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM8PR04MB7202:EE_
x-ms-office365-filtering-correlation-id: ec803d3f-2b6e-47f5-916f-08de8a11bc21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|19092799006|1800799024|56012099003|20052099010|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 rq74nPPxcL72SY/BORtZhJEAOzrtNX8jxioK35ew8VPh4ssiD0vQ0A/1C01P2v00Jjeefn54a1fLVe4eUIduB9MbKKjo0UifvdjIZSgP9Ho+FVk6MT0/NeajFVNtfJUPfuqbUJlLbaCKgonrDB8xP7xUXw35NJE1q1dWqOSL8I6Lua9nZBoaHnmz//zdIAe/gARsVO3Coow2JvTC/zXtF+FQU8uK9XcQPeB1uaN+iX3IF0dthexvthZfH3rMA+KXYxSjYh8fGbjn1cQMswpD9HqlEbJ4pJORBQuEm8NyAoLIn8TNi/UdLaGAd8bGOg9oBnAOpPSJq8B7o5lO3mDLtmHAFF6mCEbmDOKxbaHQlNdcxevNh8Ji2NAil8jRoUC8uva50F6zWI7YH8ivhUZO35dtfoy/G7inIzw6pMpQPazqulYH7P/fjEauVBk4R0bDDwGb7s+lnq7QWRVpEAA448t4v+ZNfA/x9XdEOZh3SMr9cB7n7wOb7BGJemUxKdn4ZwEG6Qo0cj9csBrZp7vqFGQ5qTdVb15JUdoReiGxtfHocsz30ZC8+LS/XKmnp0ZNZvOCDw0kl8wsLc5AjkTPqREDCl9nCuC169WcWnP84s0RRsKaw9DC7G/yKL/fvMxbr4Qv4W++RXTgSInZFX28/f67DEuKxqHh+oMeAp5U4PQ24Wr5CSBFmljEirLN6akMnp+sadj8WiEwtnwvigcSCO9C8puhh358eh/S0ex2IhTrQKpiyrLVFMvApw9rOJWNbfkpNpjo2R2PF4sKLf53KcMOVBxoDW5ofiw+o0DsJlk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(19092799006)(1800799024)(56012099003)(20052099010)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aYbVLvqhI9cVsuWd9nUtz5dAJg7kBNE98tlw/w3ZHbKwtPvV1Lt4ywA5hQtK?=
 =?us-ascii?Q?Q8awA5rQVDc42nicurZ4b8S+xxbKc6k0EPtW+HMx/IxWLjnEUhY9YmQ/eCL9?=
 =?us-ascii?Q?AJBvh6lYMSSD+/9VoIYt41Q4/bedZ77IUoV5J8Iy9N5Ze6bSHE429HYIK/8I?=
 =?us-ascii?Q?nviPXu27VckHMz7mLxub739JJEoOdo2zbisVEz3IBC8wvfgHoCdMv759uY5R?=
 =?us-ascii?Q?+auiHY6ENFler92M1KmW5XIU3H6o3z1b3r1l8HodGDm+FVBu9S/KHAG23RAD?=
 =?us-ascii?Q?J8rl8EP1NCK4xGXmnYdxPH+GVSR9SABzA7qj50lA+7fAKYMynZI2q0pYwgDf?=
 =?us-ascii?Q?7Xr2adiNt9kLw0y+HPPRAERu70pDLQjKjIIeSWDrcmVqVlF5VIjgmvww7rf6?=
 =?us-ascii?Q?nW64S6AWZmSYoLB4KQYDmKeiyeiSa0oI9Yy97CtgSW9Kzn8w5pboRptStoAV?=
 =?us-ascii?Q?K25R+zlho0qmfd22rah3ebKV8/XKNZ+1jlocCLsA8yL7bfaRHIJ14E0OP57R?=
 =?us-ascii?Q?+rjEWDaengHMTPIu5Ui1XlVOmA33tUFK9HDCqRZdLWBtnxrJkvNGmpqLXoFV?=
 =?us-ascii?Q?m1kGYIudyv3VES5xTFvrsDGNLOt4f8vL1Mruk7LaLGkPOxBMBxYDRX+YEuaa?=
 =?us-ascii?Q?CffQNRU9d3PVSx11traz4fNCtwARZjXsXhJ9OV8glzpR4yl73S/dG+tRg7Uy?=
 =?us-ascii?Q?/dnACE3FtmE/zkqaIc+4i3XtSgPWnQDySqRrBbdp7gEqbHnZLP3iSukOmtFQ?=
 =?us-ascii?Q?u2sYO4SgVb2owTP05wv57thVdc7WwHsv3yflGYbw2YC9FpyOIJHXbT94oZm6?=
 =?us-ascii?Q?SpyU4E2ekex/JLfyG4fYaG0CbPOBtValghUwZ0Wl38AL3EtwRnvJUaYRlzMs?=
 =?us-ascii?Q?JYmvv07kEWLNaD5JmpxcEX50xq/KRBajbllUZhnsn6tDPCX74FCt+eTJ3O3a?=
 =?us-ascii?Q?9+LNZ3009rX1/FfJN8W1XV3+VgccXNwM+06xtobsbxsp6n6TJVxKbURiiLRe?=
 =?us-ascii?Q?wuePg18zlYIzq6/8Qz9mTYqMBAWRxjoWNBE6VeDHdbEF/2Mndnb3Mxn+ung1?=
 =?us-ascii?Q?+qCgxX0Avplnk5GizZ8+asLsUCAwDwduiiln49G2J4gdTlzOgqC9VwDxm8oa?=
 =?us-ascii?Q?CxFX6fgZ8FFfOmvZIY4P7pF9V6w8AzGxRhOn3t/9ZksshQCkP63sdXlSDu7+?=
 =?us-ascii?Q?42cmof6pSdRj3osromJm+jsOi+lNdMDw/twDK0KSG04ZfgSnpSPYJckq1pIo?=
 =?us-ascii?Q?eYdklt/xd48g7OsRyFjzT4WztIojnFVBndvTKgdqs2JjO836OJnhUBkEyWBn?=
 =?us-ascii?Q?bbs5bHMcXV8EVljS0eWsR7LbfrEg77y6Fzvokn0hj9KrBTVKez0YGfXUTY2n?=
 =?us-ascii?Q?dlNQgMNYBwUA+li71XlrW107pKZsy0LqshvjA48AstdDNKG0H6ZBfgDL8lAC?=
 =?us-ascii?Q?vCrdlY8gtRHf8PFr2R9yDOT18yXrjLF7UklE2e06RgRY6CmNuavT9VAsSFM/?=
 =?us-ascii?Q?NBSN9SUyBEIYaxeTN1ItC7LpLeakEZ9/ldivMVqrDyeuLw53yBP7H8v1iChc?=
 =?us-ascii?Q?HszY6UCGbMwHlPFZeCbDNlVSoRXpEjW1yrgp/OZ9wyfNDnE7FEjRGOz8WvFH?=
 =?us-ascii?Q?4X1aMSqSv4QAulpvw7r3lgx4TTfTqqjJb+PKhyCKoc1qIDTP1O6Z227/+43s?=
 =?us-ascii?Q?r4u8+sVn9wnhRF6XQ3f/A3O242ecWWFZRmRW7hZDy/ujt5qZ?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec803d3f-2b6e-47f5-916f-08de8a11bc21
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 01:56:30.8065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VQExwxvJGqqUn1/UscOZ/PItk2Exd4dS7nAGCTCqzHdobTchxaU7Aa1YcKED795Kl7CR7tzNh4nqFk/ejM2dcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7202

> > +static struct netc_cbdr *netc_select_cbdr(struct ntmp_user *user)
> > +{
> > +	int cpu, i;
> > +
> > +	for (i =3D 0; i < user->cbdr_num; i++) {
> > +		if (spin_is_locked(&user->ring[i].ring_lock))
> > +			continue;
> > +
> > +		return &user->ring[i];
> > +	}
>=20
> Frank Li raised a concern about the use of spin_is_locked() here. Is this
> lockless check reliable across all architectures? spin_is_locked() behavi=
or
> varies across configurations - it can return false negatives on UP builds=
 and
> may not provide the ordering guarantees needed for lockless checks.
>=20
> Would spin_trylock() be more appropriate here? Or if this racy check is
> intentional and acceptable, should it be documented why the potential rac=
e is
> safe in this context?

I missed this comment in v1 for some reasons, I will improve this, thanks



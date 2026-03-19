Return-Path: <linuxppc-dev+bounces-18403-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EF91088E63
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 02:48:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbqs16wDbz2yZ5;
	Thu, 19 Mar 2026 13:48:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773888533;
	cv=pass; b=C5W5y/ks+zLd2JtndxX9uToSYzOtpG158Sfr9IN0NkW7gTT6W6kyFMktSiUSGRPxlA7yjPvTE0LxFQbTw9vVA4qS30aI3N0ljUrcb+gidEq9bzWl8i5+r5DIu+ffkw8Vtp1m+J0whVK+5ufM3EXZZ10AQhZ6nDqWSgj6wxTmdCzaiCmXLu+WVrdg944zGwxZ/oNxBSZw76lCxkbcDEZ4sireiRWYFpGP9/61pDom05wuzLMY06RyBjynK9xIJAG7vMVINl7mdLTC35dshNFhZa5jqAgCXnfM1yL2xSCf7TCbCsSNNBcnwkaF/Tfh0jL0t6kUQdBcOxAl8dZLi5Y2hg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773888533; c=relaxed/relaxed;
	bh=gq8MPB1isOeFiGybYUHtJAjlPVEK1tAEpIt1cScU16A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dUKpAiNj1tQbpTwrjwpEMcFJxYamo01IpSvDWzI286WzZDAiV7ecSHI+KYX0NPV9LYUacErx2fKqEQ+2lZOdGsUtgcMuLqDofK8vZowWIvbZ5U5CZikXm7U4B6AZoswFCcCB0jkrpBuv6OJa5nrlRioodbaEhNPgAfNhDoiXxxtw/LvW9TzifY7bgSeM2PQlEmIksIjzQqNho68y/XyddEsfgwU3ORH1wTfygUo+/3TrEQ1FaWy53QawIeb9BloigyOUoArcA+/EiY59iE7axoMoDNrAFjuiSunNekGqtgn1P0tSJQHC3/OM+jcdfdJQI3/Ns6TkeeUPvk+zR2/UCQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=OvW9073o; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=OvW9073o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbqs05Vpgz2xVT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 13:48:52 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQk1VJ+Tm13JgsAx4/YFGq3oiSyz0n09YSuEzRDcrxS5D7dCBfIQSfteLLPUM392EfXc47ze3sUjcfwkuluOuyk+1r6V6OKu8+7N3d+GRpGKs/v3gGmKAyGYadaf5cchCtSbPjkhE6QccWujTJ3UYEp8W9zeSA3AB39erH4f302yOhmJnuRZZ+gylS3QPJNrLkp0/23fTiHpF9bBgccJ9fgidfc/8E25bbuKW+HHj5aLeXQmFr01q8nCBFMqYTx8tjxpjiCKOtr3ZqtP3AE9YY3XvLDdnsvO+uaXKMTil9rWMlAeNiR1w2hddyomIOHB+vrxxq1JcLHLsYbuageRvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gq8MPB1isOeFiGybYUHtJAjlPVEK1tAEpIt1cScU16A=;
 b=XW6kwX/z+1XzU/Gqli33JqJqBxY7jkoSv4fxrvihzTkQ67VzisMl5d8Gq1R/YjS58UmAlVUmPEHNSe7v0UXkfprWDuAmo7Ppj5kvqY4qn0nUCd51e7V4bWyHTuQ992UArmNcwTgXRjjxlyZ/k13hzBE1JnurS7Mgs8cO4+Jt5Aj71lm8Q/He0p09HlTvCDS2B3ViDvAHcpg29voVYSPvJeM32j1sRQGmE7VsixZIuaxp9LdNotpvKWmSD1XXynpOqg8YRoW0aSIDPu54NHVXxzJIAYbfDher/oA0nWgtATbDWKfY+MczAOCiwte3VmDUUj5YaO9FSHPQgow62ZRQ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gq8MPB1isOeFiGybYUHtJAjlPVEK1tAEpIt1cScU16A=;
 b=OvW9073oO58Q3g/2cZQ/sLf5OmfSFGPVC3sNx93Hf5dI7UmiuzOjeZyeZPUBA7bO/q+QlQIAFAdgGFRCmdOgSZJCwDqf4oyiM7StNplaSnN9Fa2FfiQOdScNBDG2PORvTPZIdVg48rSUPJWBVXiR7yqE5bcmH6gwbZRJ1uvAC53CCLvn/5F8LG4wfhpBLXYR2dshEZppLrSRuBv1I8NgUKnn6TDwOwtxerpVYYu1lROa775XmsKBGHZ4LeJzXO3Uo1qtmzKf1blppOq7FYMtkEtSV85rrKDGlUc5qfXCRIUUVVBA7iNpot6sZG/y87uzx+r0rrrJSojdYj/xnUYfHw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA2PR04MB10373.eurprd04.prod.outlook.com (2603:10a6:102:416::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 02:48:26 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 02:48:23 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"edumazet@google.com" <edumazet@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Frank Li <frank.li@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	"robh@kernel.org" <robh@kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, Clark Wang <xiaoning.wang@nxp.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "chleroy@kernel.org" <chleroy@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [net-next,10/14] net: dsa: netc: introduce NXP NETC switch driver
 for i.MX94
Thread-Topic: [net-next,10/14] net: dsa: netc: introduce NXP NETC switch
 driver for i.MX94
Thread-Index: AQHctuUb/Fe9SCkKDEK7tta4eDFZArW1Jgiw
Date: Thu, 19 Mar 2026 02:48:23 +0000
Message-ID:
 <PAXPR04MB85104613AA8EDC3169D28DD0884FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260316094152.1558671-11-wei.fang@nxp.com>
 <20260318143930.1890017-1-horms@kernel.org>
In-Reply-To: <20260318143930.1890017-1-horms@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA2PR04MB10373:EE_
x-ms-office365-filtering-correlation-id: 64f8fab5-a9b3-4a02-b7e7-08de8561fd15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 9vm6ezmKZUjLp1qGKjQgApfvQSOPq/e6lVxoQPqyL86jJXDKZELcXlxw93AGxWEOD9WqJ638D1+b7vsL8WQ4oYPTCZqIJWsYYtrDGmBy7ZG8e9ZDJNGsIjewd5yN66qxbYE/Ikgs0Di5bJpKbqpG9HzSrLHBOrv4fJ117JnsH6g1QFL57hd/f1WUZdGQqOwsjCX1oY3uoxqMTG395YLqJPJastewM/Wqaqp0CFHAax0w7y/U7MDokQTSudXU0ajQgbuz3GBPpPWA4T9r49LUimHytcnHM5CmrJ6F9OqVaBn/p53u0/DntXLZzjIyKP6x5rPTqj1rFts4fpJBO9aGdm3WP6QaNBWR6OKTmkAt6aPZWLXSnGMI4S/e0d2kpB9pRcnK4UP/O8l7RLbxKFpRP6aG5ucD8d8XF5rEMAkhk3zSNYJpdLf65JuXn4xoI5ti9JJUY27h0KI3eOyZiFnmMCprulF+50gXpjJLYUNJh+R29h0NIwZNY0ZlD12aBnekMTM5ElNSxXvGmYt48GXu6RPbPLGlBkThd9SihK8n5usENYsheXhFc33nc12igELsQIvZM5f4UTPp86kzaI4N4X/yq4MAtPx0uTLdEsnVbV3wvWHmYxLegflmvyflhOch6Cf4D8GW/c2TzecL5jWWylLywDBVxr4E/c8wbQrzMyo0JZ09yjyCrjOMdw8xOtn0SStEI11W6AhEaamwoSn6+MzeIb9zDWLIVnDeSZMilez42wsoD4iEcLV8ywkIV4ra
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Hq49FxfvHeywjoMIHKywFLYgjJa74whlvwK0lK34a9x8HmMhFrgC8LVhhDff?=
 =?us-ascii?Q?wgmj2fEgG62EhUzxTmZd3shuu6OAbd3A1o7IKTQgIJCki5QNECaNWlEQUnCi?=
 =?us-ascii?Q?bUP2sMzSPk6UZ0efllWOFiOJpvzxeK0ShxM3nHDvjtB6GemlpUSKAWaEa1kl?=
 =?us-ascii?Q?BMC8j2vmU6rd4W2bplTTEDr7fZHQrSfukEQR+YCGXwYDzG+UupvQFi0Y3s6e?=
 =?us-ascii?Q?yMViD4fDO2avfQjbCXOVenThqCsAPQvBVd25OIaLJi+fFz+edFkorYwj8fa4?=
 =?us-ascii?Q?eX5Ipi7q3kLvMmBos/M7RqwYcvf9gJeQAKuG1NhzEgm9FMJNdo2dZLM9XdQi?=
 =?us-ascii?Q?+EjcexTHFDiGsNRvgD08VYu6OPQPgGZ0nDxeD3TYQ2SzAg8duiSPESZBP03b?=
 =?us-ascii?Q?FLSjybD7GA00HH/w1TNzrO9sEaHnCsVHGGh4WoQ94vZxhk0NtXyO5ILAH2O5?=
 =?us-ascii?Q?idbB6d7xWEbvh9f9aJ854UYMrj+UrSYi0nwnk4VtEO6htTLqwTsA1EQL58/d?=
 =?us-ascii?Q?kTUy2OVhl62h2z0hkKnCXSVHMvWxiOWOOt8VyNldGKKpq1LmPWxocObJYaWJ?=
 =?us-ascii?Q?+ahOGSXxtwa+tS6feP6hct9wwVADG8oBmQy7ZIW07NrydLLfS1ch01YLOt4B?=
 =?us-ascii?Q?/M+G39O5wTondTJW34T2xrICCvvwtpbqdSdfVmmkEe567rk/Jtp4cpRTHlFx?=
 =?us-ascii?Q?Ph8qlC722EmOesjFiG5vI8VP+TSXxxrb4qJSQiDyQpFMWbGQAs7GmfxxW0Yz?=
 =?us-ascii?Q?g/1vh8eka8ho4U/ku0L3rPi5CyffDhh7QP/v4kS7RjRFtyDp9yeufyMGH0tN?=
 =?us-ascii?Q?U3NR8aZ+tAXyrEIktfAZJ9DujIb+w1eb0TQnBkhCqGkcIeMJwA9vE2LOKLL4?=
 =?us-ascii?Q?bTOoezAlwb3ULmQhq/9aF0bBgx5CXi4EYyQPPR69naeuSs88ap2+hersAjfx?=
 =?us-ascii?Q?mgbshz22r2AU4WAXs9a79E/3w38cclnSC1OEXfBucXDhxH8fSuAUkcAlJN+K?=
 =?us-ascii?Q?t/HI/pR+oq5qtFOxqIBY9fB+c64dqEVV84PQZYw48QFM+oM9GUMhSUQ16sTA?=
 =?us-ascii?Q?5q6zbGyhK+BTsAysrNOwAu1oK94lrUkEb/gXuTromLS17EozECUyxrPfYPma?=
 =?us-ascii?Q?mg+S+kr12TJA+WK5bR7k1AR6kz5rcbShUg9OuHfix4H+ix/wgJ5R9YvURHMh?=
 =?us-ascii?Q?rqKYzqwW4b3YDRiy6TuBzItESW/pELCpkhH11oc0qW62Gwuam66c6aH61B+J?=
 =?us-ascii?Q?U5EytrTptnKunGJ/rh+kQA4jWbTzOH0aaUNDgMA17Kqi5uI0VFjGJwndpEYk?=
 =?us-ascii?Q?aJCEJnR4updHKY0HSFkfy/qiuLJqYtfajBwLme3qWkJbr+BcOyGanC9cI/QS?=
 =?us-ascii?Q?u82J9AMD4qi0XMZ0GGt1wx9aByrCFIZomZB7h3LvwRLRfc6TG3rJWqA6OX1N?=
 =?us-ascii?Q?s1F5PrkWh8BLUbm7tijEM9aAJ6o6gHd4mPP6v/sYPXU2YSFI8nkkLpf25Zci?=
 =?us-ascii?Q?Zj7QR/KgyudDytUC6h40SGQqy7oyE9QVg7K+k8W/KjTupY9Jar2dR09jlPY/?=
 =?us-ascii?Q?gq8wzTEDWOHJh+Hbstdg1HAmqOEaQIcz8CTsw5/y5OJo7y7Op5olk7JfWCM4?=
 =?us-ascii?Q?fTBL/pxo1+pn8weXA81q/VoUn04CKFNuuWeEb9lZSWMgFhX7v5vw/zLJk5uj?=
 =?us-ascii?Q?DfQEEFiCiaJXi32aGH0+pk7IuZhFEDC7ajJaQHOL2bv376F2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f8fab5-a9b3-4a02-b7e7-08de8561fd15
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 02:48:23.7413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B8c2MUwjELvF76hftdyHlmUbsf2wKnas/Jui1zJ2bkPjhJTQyLNxkKox5YBlTXkJG2Kg/53RdJ1rYomh2jXo/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10373

> > @@ -0,0 +1,698 @@
> > +static int netc_port_create_emdio_bus(struct netc_port *np,
> > +				      struct device_node *node)
> > +{
> > +	struct netc_switch *priv =3D np->switch_priv;
> > +	struct enetc_mdio_priv *mdio_priv;
> > +	struct device *dev =3D priv->dev;
> > +	struct enetc_hw *hw;
> > +	struct mii_bus *bus;
> > +	int err;
> > +
> > +	hw =3D enetc_hw_alloc(dev, np->iobase);
> > +	if (IS_ERR(hw))
> > +		return dev_err_probe(dev, PTR_ERR(hw),
> > +				     "Failed to allocate enetc_hw\n");
> > +
> > +	bus =3D devm_mdiobus_alloc_size(dev, sizeof(*mdio_priv));
> > +	if (!bus)
> > +		return -ENOMEM;
> > +
> > +	bus->name =3D "NXP NETC switch external MDIO Bus";
> > +	bus->read =3D enetc_mdio_read_c22;
> > +	bus->write =3D enetc_mdio_write_c22;
> > +	bus->read_c45 =3D enetc_mdio_read_c45;
> > +	bus->write_c45 =3D enetc_mdio_write_c45;
> > +	bus->parent =3D dev;
> > +	mdio_priv =3D bus->priv;
> > +	mdio_priv->hw =3D hw;
> > +	mdio_priv->mdio_base =3D NETC_EMDIO_BASE;
> > +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-p%d-emdio",
> > +		 dev_name(dev), np->dp->index);
> > +
> > +	err =3D devm_of_mdiobus_register(dev, bus, node);
> > +	if (err)
> > +		return dev_err_probe(dev, err,
> > +				     "Cannot register EMDIO bus\n");
> > +
> > +	np->emdio =3D bus;
> > +
> > +	return 0;
> > +}
> > +
> > +static int netc_port_create_mdio_bus(struct netc_port *np,
> > +				     struct device_node *node)
> > +{
> > +	struct device_node *mdio_node;
> > +	int err;
> > +
> > +	mdio_node =3D of_get_child_by_name(node, "mdio");
> > +	if (mdio_node) {
> > +		err =3D netc_port_create_emdio_bus(np, mdio_node);
> > +		of_node_put(mdio_node);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void netc_port_free_mdio_bus(struct netc_port *np)
> > +{
> > +	if (np->emdio)
> > +		mdiobus_unregister(np->emdio);
>                          ^^^^
>=20
> Does this cause a double unregister? The MDIO bus is registered with
> devm_of_mdiobus_register() in netc_port_create_emdio_bus(), which
> installs a devres action that automatically calls mdiobus_unregister()
> during device removal.
>=20
> However, netc_port_free_mdio_bus() also explicitly calls
> mdiobus_unregister(np->emdio).
>=20
> During device removal:
>=20
>   netc_switch_remove()
>     -> dsa_unregister_switch()
>       -> dsa_switch_teardown()
>         -> netc_teardown()
>           -> netc_free_mdio_bus()
>             -> netc_port_free_mdio_bus()
>               -> mdiobus_unregister()  // first call
>=20
> Then devres cleanup fires:
>=20
>   devm_mdiobus_unregister()
>     -> mdiobus_unregister()  // second call
>       -> WARN_ON_ONCE(bus->state !=3D MDIOBUS_REGISTERED)
>=20
> The second call triggers a warning at drivers/net/phy/mdio_bus_provider.c=
:675
> because the bus state is already MDIOBUS_UNREGISTERED. With
> panic_on_warn=3D1, this causes a kernel panic.

Good catch, I changed mdiobus_register() to devm_of_mdiobus_register(), but=
 I
forgot to remove mdiobus_unregister(). I will fix this issue.

>=20
> The same double-unregister occurs on the error path of
> netc_init_all_ports(), where netc_free_mdio_bus() is called, but devres
> will also fire during device teardown.
>=20
> > +}
>=20
> [ ... ]
>=20
> > +static int netc_switch_pci_init(struct pci_dev *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct netc_switch_regs *regs;
> > +	struct netc_switch *priv;
> > +	int err;
> > +
> > +	pcie_flr(pdev);
> > +	err =3D pci_enable_device_mem(pdev);
> > +	if (err)
> > +		return dev_err_probe(dev, err, "Failed to enable device\n");
> > +
> > +	/* The command BD rings and NTMP tables need DMA */
> > +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>                                        ^^^^
>=20
> Is the return value being checked? The comment states "command BD rings
> and NTMP tables need DMA", confirming DMA is essential for this driver.

No need to check the return value, because dma_set_mask_and_coherent()
never return fail when DMA_BIT_MASK(64).

See https://elixir.bootlin.com/linux/v7.0-rc4/source/Documentation/core-api=
/dma-api-howto.rst#L269

>=20
> The function can fail with -EIO when dma_supported() returns false for
> the 64-bit mask (from dma_set_mask() in kernel/dma/mapping.c:902).
>=20
> The sibling enetc driver from the same NXP NETC subsystem checks this
> return value in enetc.c:
>=20
>   err =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>   if (err) {
>       ...
>       goto err_dma;
>   }
>=20
> If the 64-bit DMA mask setup fails, the DMA mask remains at the default,
> and subsequent DMA operations for NTMP table management (added in later
> commits) may silently fail or produce incorrect results on systems with
> memory above 4GB.
>=20



Return-Path: <linuxppc-dev+bounces-20507-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075F2CD3439
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 08:21:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9SyH4tTwz2xdh;
	Wed, 06 May 2026 18:21:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778055671;
	cv=pass; b=SHKTgiAg+IqSfaQHAWMcLMOEKCuYD6nQOQQk1/sDf0qllkIZrtdI8/kO6LjgPbfQJJKTMV3eZP2eLp3v0GCVH6wHLq9P7FoiXxP0jBV5It9grxjwUhYiyqW5vN1e+dZZyDehLuipKBPqqJptxuyOgfKrtMpAjf2ezAgmQFQWCYsYKhGcL1C9W9qz9wzWW6Hb0IQfqM/uHyiaSswDbpH9XwICg3cyqBRHBPsqDLx4pNktmHJ3+ASow0Pe5MGYNVZ5RtV5Yc6g9JRIGTFBHIWSttglwr8I2CMajKxJ4QDT2uTyGOxn7uaK+m3exO+rTdolZ4wp8NZL1uJJyKR3Itj4Ww==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778055671; c=relaxed/relaxed;
	bh=v5iRsWVBxuxE3wropxKlvZpmI8CJiv7FmPNRX3l8yD8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m/E0oUlhx2tHhQArnF/k7KWKn9a75HhuGewBk7J/hF34phigvJc8lUTx4+b++iFxxJdIHVCDhMozKQ2fwToo0zFi1lJDnO0gPP5CCkmKZRLl+Ct6IgYRUX9RZMRPhurUlI9Sco+GY6l7PY113Tvx18nIn+0Y7Q6msEz9PGb3ZxP4QzrZBTm1Os9AHMUGmIoN5iaMvvuX69yUQ7kJRwgghSmQdumEnmOMTrN8wh3DJoo1xKsJEQ+l9YH2u4WvKMObFFV6PY2hZDkHvvXMVmplTgaAWYCJsoUsGU2DX7TDMOQqbqxJ2Nw+3TR+9FZGDudA0RJE9XB1g/kMltj9m0KG3w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=lDdlw5Ac; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=lDdlw5Ac;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9SyG5GCXz2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 18:21:10 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUkbA2RLpO5txRV9R1oSH65eX9AqrFT/W/E0uR7iwQccyMtv1zIf7OBEnz08IG1WzriZjNJ9X53B0PuglrwYmpyQkbhH1QduEWorBl64KMrO1FNiVZSbqPpUdg1407SHJpLnk1a7ugKwZFugOPHFua+pEuOO/ZetVhrMyMoPu7WKY5EM2OzaKeNOq70dAfvibHB0TqMC3ZHiXud3v5tsuOfFGjIHP0k8TAjg/EBCuR2zhq5xeITWApA4k9HBtOtzO/+PK9hCtRVF/IVaCmcBp1d7PvsVarnVHl/EKMeiECIo9i5BTsjdNSv6PJxrDJyVoigMWlgyiZTA5YcUHu9T2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5iRsWVBxuxE3wropxKlvZpmI8CJiv7FmPNRX3l8yD8=;
 b=pTxP86OIitxQHvXPWMGmfqb2RCwRndOUwqbd+tBlRQZdN7tQT3AzYeGkgTAPrKyVmzaoNbHrPvjaXq+jfyG0ys1sXweA870+XhJLuAzru7XaGv1d5tORSja224thPszn4C4H+WsnuMv+gshRIo/lDXcmIeInbcg2/wHR+jkuLC7BORwavEuGtNow/VV63y2WYMGcnU3sDTsNUwZ51DfpafLvcgP5ygvbAgJ+XHv4twmTogUPJwP23I6qkq2tLOCkXr72pT+Vo7gUUbR8abElSdwQDe3kBjC4qykbkUVdgb/O/cCDCThlgMUjzX/SngGjYlly5OQ+tOk7GBKIGDA67Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5iRsWVBxuxE3wropxKlvZpmI8CJiv7FmPNRX3l8yD8=;
 b=lDdlw5AcipoHj6I/ltbjEDEhW671O+zu5Ce/itfPgihZa8flYqPmfoXExmQtj2zqhHbO+cuBKmJGNH0ODtr4gNcQcLmr2PzuizqNI//Qjrpzo9lAEEtejWHmHs5tr1InrfD/dvpJ1DrZuVcoMjdqT7xUQbLx80K7G8lPuP+eRITcrBcryXzbRRER6Jzvp9geUtx1Th/g62vHc0X6Dl5Iig5bswCDXxxE2F5zV1ULPLO1HwRrG3fI0lVYe7rHBkLQe2geuTqr6ck3R9Nhp2QeLPSbv1kykvVbpqfQ86WkDMSg9p6gSAF7hyDSoN0PQYEsYHGuKPcBTTuS7X3VrUof0Q==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AM8PR04MB7425.eurprd04.prod.outlook.com (2603:10a6:20b:1d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 08:20:49 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 08:20:49 +0000
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
Subject: RE: [PATCH v5 net-next 11/15] net: dsa: netc: add phylink MAC
 operations
Thread-Topic: [PATCH v5 net-next 11/15] net: dsa: netc: add phylink MAC
 operations
Thread-Index: AQHc2EvdRzdmP5L41Ee8UAxFPap3yrYArdig
Date: Wed, 6 May 2026 08:20:49 +0000
Message-ID:
 <DBBPR04MB7500E0F877E0D3BA5DAD89EF883F2@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260430024945.3413973-1-wei.fang@nxp.com>
 <20260430024945.3413973-12-wei.fang@nxp.com>
In-Reply-To: <20260430024945.3413973-12-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|AM8PR04MB7425:EE_
x-ms-office365-filtering-correlation-id: 7c3f2d51-9cb6-4ecb-332f-08deab486156
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|366016|921020|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 oyR8JvPbXsyE8EJBxC3DgJtbCgbFjY0l/rtllCVVgZpdvh1tXwf7+Eg5PpekJNxpka4CEJ5ZDSrtgktFmX1bKNXYMwhrVDAEoMCycdtl0qRoUHBJYtSXTePmH8NeXRtVX/SJIycFIyjzzQ5dfmrfxGtsJXzufNtj2WnFLpzTraCXzw7mJEXkoJcy8yHOhSjvfhXnCoX9TpNlRWahLIf5nGLtQR8KFzN9Xp6qLz4LHVV1032vXy0Fo0yaufNdCIGPY5w3463AzpR5FXcowTe8ez2D4yPHEfGIdKYcPgvJOFpmCBjHdqPI3BNrtG7nrVuOvNhcmkVMNVAZP6p2xU3g0ICRUoeBJuIJTnL3Ef7vShvC5AOcMZ0FKKeUbDSdR0c/WCuNhPDn9tjSt8OPK1AaytrJw+uG/NIX3fJT/e5oefLq49EVCYRAtwKV5frwy/dB4GjHzmRHuP3Mf9agrwvqPqhuUYvXUYX8OlprUwvC9fOAB5dRHvh4ttYszGTN/48OQBKYA5jBtp9bCpLUOJWb/U56gSXf++/YX584mNilrS8V5km5N1PczsyCQVgn0u2/Xv5UWm3EH1sVnnYyuSIw7WANk+6kgNnAhIZA7fE1hTP8NtAslYIl05S8VrkhoGlH0JvtxezAz9rjOGUQdCukUHrVdz2+dILBqnWFjNqaq1H7IBf0RtZTwjhFOxVQuTNJB73JbmM0v9EzizMLDpVvgzBftsjsdKv55BBpnt6AgSlW0UrhXZQTdRBckaH5a9o/yub5ulLPIo8nGg6ad1Xqlw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(366016)(921020)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vV9Q+mH5G162DZDZhN/NEU/d7zXtmBLPlrFASwZS00HE8O79Oig7Ukrto1J2?=
 =?us-ascii?Q?7UvquXUb9B1bfIhRhApDOa0VOxaWP0WKPlclX3rGQy5aX5Vyjmdm7BilOCap?=
 =?us-ascii?Q?18+xlVqJjMWYOFb4dNU2qV/ezjE3V3awjbLo3vpkrf1c1/a7u77vPpL45/KV?=
 =?us-ascii?Q?MvHzUSwAWaDXouQMtL94lS/KI8leiWQF7aLXDjPBbLQlQtzWPwy1xLc7iQMO?=
 =?us-ascii?Q?Uuld1MwdE+hqZXcEVB7BLzshencVV2FXFmwolhVQoQjjpVU98u4wnXJHOT/b?=
 =?us-ascii?Q?HtThujGYlknGnE3neE1dCiQS+8jGQWt1WBphx52tc1tYAeoxRkzbqpE1JkBJ?=
 =?us-ascii?Q?zwylewLrFuMYf+Ysu1PLMXmNEOx1ajT+cBbLqw9qkf7t2GBwuDmnNI0E6tcJ?=
 =?us-ascii?Q?atEwMSec99PFDwPvEnXdMDp/pM6sr5N5PLE3KOsMW5ZBT6lah3ghoxobfjTU?=
 =?us-ascii?Q?At3HUY5m/PVTlCqwn8+wrK+DIgxosTy04+7V3weBTRm9SHNETh406xcq3lSF?=
 =?us-ascii?Q?ZeAyJ+9NRRp4j8ypi9EDRNXrEWkcYSxHNILO2XRaM2+i5Z0aZG8UDnvIXBM+?=
 =?us-ascii?Q?W66zqk+7qJlFrAmvCkSaOMmv3wXmsspmwT3VNRiNeeen783w35iXi3A/4XvR?=
 =?us-ascii?Q?sc5/LegMgYL8HaIKw+VfmCvaDPFdFokoJrrt/hiQvm1xrsGthaS/w38bJtXe?=
 =?us-ascii?Q?FxhH+aPr55lTYuWbQf/j4NtJf2fBSbALl0WYMRyhCq15nKESX41rJUgnkaVB?=
 =?us-ascii?Q?iWFm2xfvYB7Ky4256m77XXGKucNj73P3tmvX2WBQ89k5L8EYYZxgnenUD31X?=
 =?us-ascii?Q?G2h8MeoxHptKlkpxI9C5W4phJs+OR64comOqvUf6yI5O8ikCJpkERhrd3EEY?=
 =?us-ascii?Q?UuYTqOMxAP4uiXChFeDTRdXxKwemh7E+xHoQY811pl5dL/CS6Nld2uBvAZ28?=
 =?us-ascii?Q?A8zMrMiZP2CQiPzbGT78vMbWj/T7p7A020SSSrp1HY/YcPaup4303zvLr1VJ?=
 =?us-ascii?Q?pBrKINKKMYTVUBqddCpcmy0Y5Q0YtvRUPHwLGdCfB8ox37hQt6dnNm1McM3R?=
 =?us-ascii?Q?14XQ58XwUUrJvYVthXyzJx1/42EHPV/jyhyBtLnl8WUyc0u6H7y1IwdOUGNl?=
 =?us-ascii?Q?KGnMEUfnPgIGcJU3+zUzE2VvTuGOARxT0NhFhYhl3SV6hzElLdg3egPmbfzi?=
 =?us-ascii?Q?uAhaBqz5t2YIU7RpNHxZOBSca+0yu1nHeYqerP7ZomzDeVcqqx5G3sMs2u2O?=
 =?us-ascii?Q?XYtasyR7Z7UIGVJ/alWtPwR5rhYovTbner3NJ9Ktnvlp6akXppSfA5Cgcg+j?=
 =?us-ascii?Q?OADsbvpCvON2eXETm+sk2hCsucDFtx93M80Bpg2QFet/Y33WRfhWI/0GDFqE?=
 =?us-ascii?Q?pNsaW+NmYJ+fNc9mwqjCm2h9x1O8ALpEISdEObEmqM7/6u2iawuVcYBL5bHl?=
 =?us-ascii?Q?f+43jDqbbmOd++K8vBZU7P3C0bjdA17rYLJ9FzsSXP9nnfaKKRC9xZCrrG5r?=
 =?us-ascii?Q?tVAsxqEGGqyoxog7AuzC8vn6ej9maEhsokSys052eDUx1XscOjAGyxe+3fuf?=
 =?us-ascii?Q?9NYXue4oc7HLMmytan2e/elLNFsc2RTAWOHb94KAP9aD61c5zmeO+Q12yEto?=
 =?us-ascii?Q?XuJwjaHm68ltEOaXzN8qjO+JGPLBZkoTEknAPeOGA1y/jhdcdRp3ISbFVrOF?=
 =?us-ascii?Q?lf2/IlEDlEVZms+t/iWifXE97cngY6ELVJJmSBt3ig8+Kw2L?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3f2d51-9cb6-4ecb-332f-08deab486156
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 08:20:49.1980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SGJyUaMeNbDY3g6pslV5FhoGae934zxkkaveghZKNC7c2utw3tKZixJ92VDbHElIQ2kSkyvc9N5FmVprqfVHew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7425

There are some comments from Sashiko and see my response inline.

> +static void netc_mac_port_rmw(struct netc_port *np, u32 reg,
> +			      u32 mask, u32 val)
> +{
> +	u32 old, new;
> +
> +	if (is_netc_pseudo_port(np))
> +		return;
> +
> +	WARN_ON((mask | val) !=3D mask);
> +
> +	old =3D netc_port_rd(np, reg);
> +	new =3D (old & ~mask) | val;
> +	if (new =3D=3D old)
> +		return;
> +
> +	netc_port_wr(np, reg, new);
> +	if (np->caps.pmac)
> +		netc_port_wr(np, reg + NETC_PMAC_OFFSET, new);

Does this code risk corrupting the pseudo-MAC (PMAC) configuration?

By reading the original register value exclusively from the primary MAC
(MAC 0) and writing the resulting new value to both MAC 0 and the PMAC,
any independent configuration stored in the unmasked bits of the PMAC could
be blindly overwritten.

Additionally, if the new value matches the old value for MAC 0, the functio=
n
returns early. Could this leave the PMAC permanently out of sync if its sta=
te
needed updating but MAC 0 did not?

The pmac means preemption MAC not the pseudo MAC, I will add a comment
to the pmac definition. The purpose of netc_mac_port_rmw() is to make
pMAC and eMAC configurations the same. So this is a false positive.

[...]

> +static void netc_port_mac_tx_graceful_stop(struct netc_port *np) {
> +	netc_port_rmw(np, NETC_POR, POR_TXDIS, POR_TXDIS);
> +
> +	if (is_netc_pseudo_port(np))
> +		return;
> +
> +	netc_port_wait_tx_empty(np, 0);
> +	if (np->caps.pmac)
> +		netc_port_wait_tx_empty(np, 1);
> +
> +	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_TX_EN,
> 0); }

Can this sequence race with the Port actively pushing the remainder of a pa=
cket
to the MAC?

The code disables the Port TX (POR_TXDIS) and then immediately waits for th=
e
MAC TX FIFO to empty. However, without polling the PSR_TX_BUSY bit in NETC_=
PSR
to ensure the port has finished its work (similar to how PSR_RX_BUSY is che=
cked
in netc_port_mac_rx_graceful_stop), it appears the MAC TX FIFO could
momentarily empty while the port is still pushing data.

Would this lead to prematurely disabling the MAC TX (PM_CMD_CFG_TX_EN =3D 0=
) and
potentially truncating egress packets or leaving the hardware in an invalid
state?

This is also a false positive, the procedures for configuring graceful stop=
 for TX
and RX are different, and they are all configured in accordance with the NE=
TC
reference manual.



Return-Path: <linuxppc-dev+bounces-18401-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84831088E5E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 02:02:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbpq2012Qz2yZ5;
	Thu, 19 Mar 2026 13:02:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773885725;
	cv=pass; b=QE1lpaUpKRF4dw1m56thYeLBqQH1RMbnRw64ACZkTuPOqY/y0qhh9cbBdLef5Ae45oorXNYeSKlGXMeP1SqCxsVgCh5nIetv80fHOO3wwfjwaap+Q2MsSylia8ad4LjTMO2/RObvINCHVy5DmD+xCvIrJZrbCG6S9N2bklZvqZAlXHjNYJx7SRauxlmXpiPAzXpcShhsxohlk8MWxTDX6Ijyf2GAi5Mc/LYoKqUqPPqfqztUE3qnKnLtv1MJEXiMZm3s7xf8K9YfGYRO1PX4JFikv0zseGyd9oGJkJJf+h9/olQo3dAk5IxVeAAcY9PRluM2BBNsOMuMmZAQtB53DQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773885725; c=relaxed/relaxed;
	bh=Ux/B5ft0ciVtBVF/Y9dTNq/HeACtD3BsAvCxH90ZBXA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hlBV7AvyB6Yi0iMQ2Pd6Bn5FxjrRKNiF2l0BUGgsv0FZ4QtVdmU8o+tBlDr2hrv7H5SXqKtb0zm22BikYtSbYcFN61aB4/wv9Gs8tpQrLmMeEZCeWOg7o2kcUD0mO1BIQqEf0z+7IwDPM3Kgptcc0wYwiODjc2ao8YjKyYdaiKYYi2VBTmm6LJ5an2TxLZmRlO2hLKMyCWliBIl2GjKZbGMDhMi7BqJxUPPEP2tBhzEu5VjQR5QkfptUtOqcjpcbSDE8/j5jiVFffVOJTHenxa86M3L0UYyRMIvYdf3urwEVGvF1l1Aph++Iw5IvikmxLgW6mmEoACtZPmXOLR8+GQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=VFJv7k4/; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=VFJv7k4/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbpq00Knlz2xZK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 13:02:02 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srp+DdkTs3Zuc+/qrZKdqa83v5jtIgFQ4Z0e0McJfMuwIRMd/pRpIVHQhzDwYpEDo3f/zlfbc42oPQkVKhxWpIiL/4ostbEn4nWD9YzP6Zo+fciE6DQf0s8kznMaILSido7Z9055o2kwYRjYZESPep1jl6HKoh/0Rjk8R0eCpQCKYId2YL7XU2d1pEjMxzVFcr973VvcAjv4dIcsGt3qIUxXOL790cDMvIU0JNLk1bzH9QFVlo/0vl56fSHMV0Jt/VUB+Cn8j/GQFnYU9vyqZ0gxdvTfYC7uWLhyvlHN0BesUxyF5AcJC1RJ7kLA4X5J5ssL0PqbekGJ+m76+L4Fhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ux/B5ft0ciVtBVF/Y9dTNq/HeACtD3BsAvCxH90ZBXA=;
 b=FilghwWyDTY5enEqYt2QBhTsCfkOPbmFMF3eM1/gs2W7Iff5PekDrTjjnVbBBDm042jSW/cBMvLz4eGRLK9opmUz2dz6QOEDJhDgV3CzISUTTvqJJNPv0aH/+vNiEkUgPjttHcA4xImhGZSdVNBhUqlE73cLoClW6Vw0jtephOOmlE5Ne64tIDNVPoJ5PnR7tmWOc8f4vu2zI0BA72Pw7ey4RZ3G3lry2Ax33fF1R0RuBBgI3OxMbRrVbbXsIyjFx013eQgBwJPk/C19Q+dKTJth1sjTXEJwQY092lsQJ5SfcXJIiw4u8PuSo+mUm/VdAJE8m9Sb51r/jO8Zpg3v9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ux/B5ft0ciVtBVF/Y9dTNq/HeACtD3BsAvCxH90ZBXA=;
 b=VFJv7k4/BQ73oLTF+x44LnSs5+ZC+BFEnXOHscMibFv0uZiSMkihuO8vQj5Rtb2e8OKtdqaKcZ41tw93/MCF11tSnuMKWrf9zC8kAhXGQDRqn7VOmjyLSPXP8ASgN55jZv47E9xvV+dIaPM5YNa6nrHtdSA20XdkVj4P8MaH1mE7qOdPL4qZCjp8+/9eBzI+noo6yR5Dxs8j9kUs9kfU8DVkeMNI9po0MTNhJYGzNKBS6iB4FZG/f2fJyJmrCr/0hx6lLMubiAxUyy/tmEI4ojoVG0TWyX4xPPGVY0sglVLCEtBYpPCyy9J38PFiPuycte+f9Z613zKF7joUWwX8xg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB6862.eurprd04.prod.outlook.com (2603:10a6:803:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 02:01:35 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 02:01:33 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Simon Horman <horms@kernel.org>
CC: "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "chleroy@kernel.org"
	<chleroy@kernel.org>, "edumazet@google.com" <edumazet@google.com>, Frank Li
	<frank.li@nxp.com>, "kuba@kernel.org" <kuba@kernel.org>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "robh@kernel.org" <robh@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>
Subject: RE: [net-next,11/14] net: dsa: netc: add phylink MAC operations
Thread-Topic: [net-next,11/14] net: dsa: netc: add phylink MAC operations
Thread-Index: AQHctuYdi2RS4ohQoEi1ABW3N7J/OrW1GkGw
Date: Thu, 19 Mar 2026 02:01:33 +0000
Message-ID:
 <PAXPR04MB8510EC449C87545449418ED1884FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260316094152.1558671-12-wei.fang@nxp.com>
 <20260318144651.1891670-1-horms@kernel.org>
In-Reply-To: <20260318144651.1891670-1-horms@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI1PR04MB6862:EE_
x-ms-office365-filtering-correlation-id: df88fd56-f2f1-45c2-1f26-08de855b7215
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|19092799006|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 nO1hitNVNFHplyfyFnhIEL03CqSwOf/obGMyxfEvEAcW1grqSLY61lHSdTfYfWPxKwX+LgCJqXxcYHLInEVUoDSE0KGcCWNfO1e5GP1xpc2uj1EiK84bJFeajuUYksAfktpMDmNnztT3QtuDnmBa50gSBplfLOfyItKM3erY79NvAEnp1OnpB1aDn9ijVO0IsJ4afH4fAiDqztD2ID+mkChceGy3o/IGmZo4wLnlqU9IgUMDyqyxO2UMt8zG4gYtjrCZOLJEiEqJPozOhocW5uciLu+16BjlnDUu2062wivUf27VETJnLYCD1bv2rj6cndaj9YlqkgQKUvS06UF3T0h4ZHO31tSVpuoV0Abos4L/6Gr/+oeSaEhOXL49DjK/+eqKaJ/jM9tAeFdDWgP5wjgBtZZqYljt63rbSh/Bam+K9k6NcRDxmkcWZrJn35F/XD2TN2XG0PBd1ke6yqkR5heSXOwiyuRkQHiNg2BVcJ93ICyhHhwDRX40iCqvFtZ0RMawOGtZXhKWv7oAmMVXgyIjeaaUi86Yk8xPa+fkFEbKTqjbpKOdh7XkflECvzoKyobh03+WUKUvO7Lwy6aHs2UM0AGlaTFCQ4vwKaNXYy73iyXawRsHqWf23rT0FZJCulIcW86KKwiZcFBGGx/v2l8DYKkzrbsKYMzlYwV/VuQWN0brvDhnKTUqJ6cpDOH0H2qUppenJ4fxpL9vwHzlwo5kwGNSsS8dWCUCFKF+3iuwEKz83RxFeFLa4BaBo135coRwMVUJTzTvevjIdmoFTCCXD7w14PQUb0rnUHvoiv4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(19092799006)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?og/xGaGK10khvmfNssLMTtuxA2VFvkPiJN/JD7JtLGkG+y2JuPrHX1MtIZXF?=
 =?us-ascii?Q?oBWu1nwzCpf1PmI82SocMP9XGQHzyvsLfkf0h922yuZfcqs9CfPSm1f9iEOv?=
 =?us-ascii?Q?3VOJlpv18WXa5FDM/2RHgiU9Qp/TpjwqYefZ+wnUE3DEmdjm5f5ut/nnKAOx?=
 =?us-ascii?Q?6KerHpPll47SSPtBkVtDofE4cl9HGYoF/7mO1wwvZVHYisZIX765mQy9vz6L?=
 =?us-ascii?Q?cEfy3irb1d+rmiRngEFUohG7wFH8aAV2QKxHn+JOFPk5XOJJUDixPZ/E9DNU?=
 =?us-ascii?Q?mmgsen4IE4t6agN/SLdhWUfG2zy3tXg5eQ7kRHNc3LRz59PEzEAN1HMTxSDI?=
 =?us-ascii?Q?qXbrTGQbQlDAtD7wrxQsFaZW97i1qjoRk/z10oyBFR1/I3LPsgOViV7boyDa?=
 =?us-ascii?Q?bVY64zG5vXBovO8pkquA7si718Yd34GIr/ZiAtuHZjjUnnVhFybMN4zJbdCu?=
 =?us-ascii?Q?0pqpbqhS/c+HISYmO/4vFcneMTrr6zKyNzV+Lwg89AtD1xffdhq2Dg/f3i69?=
 =?us-ascii?Q?cfcdnpD9TwW4ZOzNE9lkIVIZZ1nmo2XhPGa+Vcfj/ifKXhIJ0nkB9b+xWeIA?=
 =?us-ascii?Q?YWQBX7ykSvABk3PMj/Nv4AJuPI0w8m7Kk9miPYQGbSZ/fS7yXJPgOqbXJMPy?=
 =?us-ascii?Q?T8pxINDtIadCqw5HcozWeQpadWBBoPX+9slwze3io2Pze0GPtULVIHTwAUgS?=
 =?us-ascii?Q?Yd/UpN209xnch/c9UKPRgK5T3QQdPKYOEZYGnPLX1uS1tMToZOo+z/r/1hys?=
 =?us-ascii?Q?HF0xi1HJAojFSjKLiRPSHw8Qhzl2KkKzESVnhMqADw1486mGly8ManET5V3S?=
 =?us-ascii?Q?+p16DU7LyRTNxtUM2m8IkHmIpBQCAZt3o7rFS7CBtLJubqk7tfYtQl7h0WFS?=
 =?us-ascii?Q?mIANTBWU8/Rgo6UIa2v1OBLMGSeyje4AnURJ70ckINbxo9rf8kbQpoyGUNyX?=
 =?us-ascii?Q?dEEFLzcm815OScUXL7Mex1Q04B0zHfTVFjFLKaEHcTAuxlwNacMb4hQq5AOX?=
 =?us-ascii?Q?B5IisxKKaeglQYs6XDn/bPq0BJzczjhGPLJJzwv/Y4AAkfN2AFKV1EnjV9hR?=
 =?us-ascii?Q?P7z3SMZ32bwYcrjShuYfb5dsywOCpOk8S9EwhOFaAF5Uk2KDidrFeAT8Y7OJ?=
 =?us-ascii?Q?cGvqtciF/nUsDpuFAGj1yj49gby/w14BTsfkYf66ckRg45bgeaeJR1Lv7XyM?=
 =?us-ascii?Q?1WhcvaVByT86Tr7RLPDu04LrI6uN7WbVbgrcHQcg3ls4lYbRZpVf3debz04l?=
 =?us-ascii?Q?W+cX+kgREd2V3mvgbLnP2oSheCDGYCdafmqXXqLbTa9q/Nqg4sropGXILTt4?=
 =?us-ascii?Q?fNm/c2vq6CvO2sFvnQxFTl8yJuDmlMt/fP3+x4hSzCbJ40g/NKQdgFL4xOG/?=
 =?us-ascii?Q?F+0uvKaL/GeUAlpmXDzTIIVwSELbSqjJH4LsaC7N4YlqINFPtNP4vvf1Is4o?=
 =?us-ascii?Q?uEfB8hcaYQdom25RhOZS0uSqLgZHoRBw7dxvVPZ2TGs7XhX2gc5v7MPwvTUD?=
 =?us-ascii?Q?SKj11n/B30pkS6LnZFG7akuHgtViqLg0h7tO9U6cFANT0lqjLK3HJ9HpvtO7?=
 =?us-ascii?Q?aJbr6SimWgFEEbLRSasVZQTiGH9MA5gDw52gHs/mFJpgpEIYKp3H0ISPEEE2?=
 =?us-ascii?Q?F1Hlb/lVGadpiuCcgIwQBwIw0KL/0NeSPO4LS0A5pEZTsk1rpms3t5v9YvQi?=
 =?us-ascii?Q?KIGmsPoB3zMZ3okcn3PAG5amaJc4U1QllTae+ZbT/qr8aEDP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df88fd56-f2f1-45c2-1f26-08de855b7215
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 02:01:33.5304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0RyQEeTl/VW1u+Z1bBIHgkT0NiZaUnQvPmhC6RY0etIaskPOlrYk7Pf4Ekq9DYw3/FYiwEGjaiJuDDHJSGL09g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6862

> > +static void netc_phylink_get_caps(struct dsa_switch *ds, int port,
> > +				  struct phylink_config *config)
> > +{
> > +	struct netc_switch *priv =3D ds->priv;
> > +
> > +	priv->info->phylink_get_caps(port, config);
> > +}
> > +
> > +static void netc_port_set_mac_mode(struct netc_port *np,
> > +				   unsigned int mode,
> > +				   phy_interface_t phy_mode)
> > +{
> > +	u32 mask =3D PM_IF_MODE_IFMODE | PM_IF_MODE_ENA;
> > +	u32 val =3D 0;
> > +
> > +	switch (phy_mode) {
> > +	case PHY_INTERFACE_MODE_RGMII:
> > +	case PHY_INTERFACE_MODE_RGMII_ID:
> > +	case PHY_INTERFACE_MODE_RGMII_RXID:
> > +	case PHY_INTERFACE_MODE_RGMII_TXID:
> > +		val |=3D IFMODE_RGMII;
> > +		/* Enable auto-negotiation for the MAC if its
> > +		 * RGMII interface supports In-Band status.
> > +		 */
> > +		if (phylink_autoneg_inband(mode))
> > +			val |=3D PM_IF_MODE_ENA;
> > +		break;
> > +	case PHY_INTERFACE_MODE_RMII:
> > +		val |=3D IFMODE_RMII;
> > +		break;
> > +	case PHY_INTERFACE_MODE_REVMII:
> > +		val |=3D PM_IF_MODE_REVMII;
> > +		fallthrough;
> > +	case PHY_INTERFACE_MODE_MII:
> > +		val |=3D IFMODE_MII;
> > +		break;
>=20
> Does the mask need to include PM_IF_MODE_REVMII? Looking at
> netc_port_set_mac_mode(), the mask is set to:
>=20
>     u32 mask =3D PM_IF_MODE_IFMODE | PM_IF_MODE_ENA;
>=20
> which expands to GENMASK(2,0) | BIT(15) =3D 0x8007. When the REVMII
> case sets val |=3D PM_IF_MODE_REVMII (BIT(3)), this makes val =3D 0x9.
>=20
> In netc_mac_port_rmw(), there's a check:
>=20
>     WARN_ON((mask | val) !=3D mask)
>=20
> This check would fire on every REVMII configuration since 0x800F !=3D 0x8=
007.
>=20
> Additionally, REVMII is reachable because imx94_switch_phylink_get_caps()
> advertises PHY_INTERFACE_MODE_REVMII as supported for port 2. When
> transitioning FROM REVMII to another mode, PM_IF_MODE_REVMII (BIT(3))
> won't be cleared since it's not in the mask, leaving stale configuration.
>=20
> Should the mask be:
>=20
>     u32 mask =3D PM_IF_MODE_IFMODE | PM_IF_MODE_REVMII |
> PM_IF_MODE_ENA;

Thanks for pointing this issue, I will fix it.

>=20
> > +	case PHY_INTERFACE_MODE_SGMII:
> > +	case PHY_INTERFACE_MODE_2500BASEX:
> > +		val |=3D IFMODE_SGMII;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
> > +}
>=20
> [ ... ]
>=20
> > +static void netc_port_force_set_rgmii_mac(struct netc_port *np,
> > +					  int speed, int duplex)
> > +{
> > +	u32 mask, val;
> > +
> > +	mask =3D PM_IF_MODE_ENA | PM_IF_MODE_SSP | PM_IF_MODE_HD |
> > +	       PM_IF_MODE_M10 | PM_IF_MODE_REVMII;
> > +
> > +	switch (speed) {
> > +	default:
> > +	case SPEED_1000:
> > +		val =3D FIELD_PREP(PM_IF_MODE_SSP, SSP_1G);
> > +		break;
> > +	case SPEED_100:
> > +		val =3D FIELD_PREP(PM_IF_MODE_SSP, SSP_100M);
> > +		break;
> > +	case SPEED_10:
> > +		val =3D FIELD_PREP(PM_IF_MODE_SSP, SSP_10M);
> > +		break;
> > +	}
> > +
> > +	if (duplex !=3D DUPLEX_FULL)
> > +		val |=3D PM_IF_MODE_HD;
> > +
> > +	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
> > +}
> > +
> > +static void net_port_set_rmii_mii_mac(struct netc_port *np,
>=20
> This isn't a bug, but should this function be named
> netc_port_set_rmii_mii_mac() instead of net_port_set_rmii_mii_mac()?
> All other functions in this driver use the netc_ prefix
> (netc_port_set_speed, netc_port_force_set_rgmii_mac,
> netc_port_set_mac_mode, etc.).

Oh, sorry for this typo, I will correct the name.



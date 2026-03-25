Return-Path: <linuxppc-dev+bounces-18746-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D53A1093175
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2026 01:54:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgVLv6z4Jz2yng;
	Wed, 25 Mar 2026 12:53:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774403639;
	cv=pass; b=LdQFATlEkujeIykdFeh9G23LR0TeG8ahEMpz++DHJe99g8PafkkR8ir55pineFj1GhmNPQaVSFQ2oQ7nevAcs171AWsYvG/7NO6tMklcFwSNm5akY0AeccZkbnznFL1Ju2lors7nOL6pg7PuGMRkc/cXz0f2AANg9YmfULrfUbeaFI59vAIpbhTJe1C520Wvpk7GpHFOfExL+lMWISCZhtFIhvvA7AIuoTFGjqSktDU2swLbZYTJKoIF39FSE+uhczZmxAbiabkI7O0lPFU0Hg82+/8BwqgBe9nolA8pQ4kqM8gVfBi7zUE3alVTaMuWFl5wSN79nczDPQhWZOl7ew==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774403639; c=relaxed/relaxed;
	bh=wDppV0/PVtQMkWNtR+DOHowtE6IeHsFRTHyY8wN2sWU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jv5iQ5hPqf9o9LOfDp3WNJWS3NSZ4HFea3IunVoe02+o6O20HmL1Brn7TXKk1v1xbQ76JH7dJtV7jfJj8Kp7BH+xFRg5aOt8j1wfi1iJwCIIor7iK5wuE6Ik5Zb3gl20x8DLKaJwA2dclue/1MOMRx3yOKKX0qNvTn9hzliI69HQcNf0Q+bMBHFYfV0fhXHqgwmHBgbSqe+783oHUSZ2daa4ABRtRXM1hao+uHD0lKa4ZCMJOhpBu2e6GCKoRTaWiYglHneQPpzciEebU5WnsYwmCsRjlxanTh9oKzFtJrfSuqHA8WaZjXUWVYZEoNUg80m7Fh683VlsvJPB/knTyw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=dZq/nCLa; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=dZq/nCLa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgVLs55RTz2ygh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 12:53:57 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhSlFQq7qgQgq4zUE6aqhZ0EKK/a+yos//WBo9vgn/kPQTnLKqHYoGKRjkQH7iiUyY8UhkozcJHT0MCKXo0g5mTC9Qs0ulX8yT3AjOedtmXVCJ6iDt3xDt2YVSZ96FR8wuml1xlscXlHvhd3LhzeuL30LB5njjmY7TOKP/obVw7VqNPYasAUPZXIQOpiTgDSa0DY3rYvigTe3hKvUPbNWNbV3sccnNRp1nzcjacOIoPA9thSjc38ZAVlW6Oj8aCswxmW+vA/nj6xPxn0/DXGGnB2UU/wSrHG4IS3F+7ah8BQa8RJ9etMv14wKX2vdVZRXJM7ibjtINsiV3Xs3mCReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDppV0/PVtQMkWNtR+DOHowtE6IeHsFRTHyY8wN2sWU=;
 b=nRhCiUVFy3FViqV9bF7uBwhjOpAB39DmWNetKab2xKMWUU+3r2HQqoKVRCrxnjz3IKHoSSD03HUznrCOwPu26g+AToT+pl7o2FsIGigkWQjrId4l8Bg9nO+0Jvmi7ZX8U6Trnrwwdq2AFypQFyuk3d0i/RvpEJxFMwXWC4m7X5n2GvWop3AXRy8utI6uo6rX1xhgLkpj3Hjh2ZjELYAgqYI509M7IgpsgXHlEkUz1Nz/w8ZHAg5u0tLUVcVS8/24riBH+q/aqjXNkttDIqamnoLqt0qtW86H/4oGEsksK2EuKzdKYO0DdVFzt+DN8ch5kVUyfFeVqU9mWNmPUdrgJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDppV0/PVtQMkWNtR+DOHowtE6IeHsFRTHyY8wN2sWU=;
 b=dZq/nCLavmmvfraGUmDDRl7boWYBVa1PqsGDVJEJasvpVNMKTUbMBZqXTTgKUUAU2r4w/snJN6niH0dPL8MWULfYpOAYqBos1BsyZaEkpTRZ6wy2Dx8zYckjFKSj4lGOueFzfPL2jKfuVv9uBSs3NV7ytBEqg1Raw3Rrzf/nNCxGlgF9QuZCHqbyLKfeDnBU3ZY+ut2xIvmqWSp6oTrLNLRugwT+E1tXqza1LlYAr5n0sn/oaViUz5iRvti5pifto52eOCQWtXeTkWEGU8Gesx90cCkjnqXt0hH5HeObz8nlRyGMlVBqmlteCICTRCaqU1l3P5N/+iY0kgwFGSL4lQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7202.eurprd04.prod.outlook.com (2603:10a6:20b:1da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 01:53:32 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 01:53:32 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Simon Horman <horms@kernel.org>
CC: Clark Wang <xiaoning.wang@nxp.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"chleroy@kernel.org" <chleroy@kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Frank Li <frank.li@nxp.com>,
	"robh@kernel.org" <robh@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2 net-next 13/14] net: dsa: netc: initialize buffer bool
 table and implement flow-control
Thread-Topic: [PATCH v2 net-next 13/14] net: dsa: netc: initialize buffer bool
 table and implement flow-control
Thread-Index: AQHcuote84lxYz/saUypBRN66PVRZbW95VIAgACYkLA=
Date: Wed, 25 Mar 2026 01:53:32 +0000
Message-ID:
 <PAXPR04MB8510C8FA7D3E0635EC23E2178849A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260323060752.1157031-14-wei.fang@nxp.com>
 <20260324164234.238201-1-horms@kernel.org>
In-Reply-To: <20260324164234.238201-1-horms@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM8PR04MB7202:EE_
x-ms-office365-filtering-correlation-id: 6b126050-cd03-4d14-bef0-08de8a1151c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|19092799006|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 iMLCGKbe1evIbv8dm8/JR72lHW6gljniCGxlRBlVk+0QMtbiMz/GJ4Owru31weNOKW+Mb8k6DkgYrxFOiFCvS97JGEK0PLop1U+tdZvIKdvaYCAfIdKks9Pu7p23hw98dzskDl9bj41MIFH5zGDCawgdpZi5+U6mHNWii4rrwin1J1fg/BZUUc+IshfCinOaCPMSbfALD5O4xHYdL1zFfpd/C/qH7Xn84yQcdHbjYvDuLoU31hNcvF/XIvIffh6uKLuq2tBMy6CUMBqB9l09tdFaF23kzqFj7BEWi/7uBQP89AmbScvq84MAnN1eAov04kq8ZJmq3jR0jaEulVA+aiNzJT0N8KS0OVC118S5LyxPUOVzUchzNcjo06/eDqqaXKXoPZ1oGsqmUQ2GODFHM4by9kirGL9BXa/v49TYBktcVHWH+/pfiN+SHph7ZQqVn0PkfhOv0kjZdjPJJlcnSuQMFH+fF56sGlTPJUcls/8EE/QBurUvbnGbBqUnvrNJACZFa2RU62iU6zn66nSYMKSlivxeuLCmocuE8NIG7arHEk8KUxuZDio0O4HvgHTA7O4vEYjK3fDZv4J1alvPa/pu1EWxTaQS6cdfE0L8L1Hd0uDXVicsBzR/+047XFPY1fvjcSJAIItTRLJYZZBcUMOWoF2c2lD1/SLmO85aP7zdgwKKJqWYwSbJoVa+vVTwP/UD5+x0Fyihf8HqrCFixFThKsm/h9m3gS9TiNKH6/PPgr+1+kAX2eMCIFjbxfcIFrros4c3L61av/afgl7WOCuX9UU4VpWtBzoVLoaFdQE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(19092799006)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?g4jLznmHFxWYc6m8LzKds/hEkLPvJRnWepDYKrKJlz3wTNjAf4S5OBlkAwzi?=
 =?us-ascii?Q?J0Zw0SrWuvF3VF6S6kQU2iYYRkSSjOZw6pQuAXr/90OvqWE/nc6uwJzTPA0j?=
 =?us-ascii?Q?PcJvZEcG140Q8RPTm1kv3oLO925qBJ+mNqqU++tDBv05rwMGWggR3IYkN5/Y?=
 =?us-ascii?Q?+oq44NYRZK6B2oyJwKtutY2bzPHfG4dUZZG5kK5P2i5fxF4D0hnRyEF0wmNG?=
 =?us-ascii?Q?S1e9lS19neZ/DO0ULChW15U8OhpNCxZ9rsrlIlQ8GXgJMPyEAr2cZl+tFDnF?=
 =?us-ascii?Q?YHTUp5RsWvukMcforptSwaTdaMAIv9yXVGSu2TnwcPdX3kgCm16BvIC26RQI?=
 =?us-ascii?Q?xKPhUsFy+uYh1f4yDbGtOKN85FVjOLv4lRZsSVcGx+fYgRz4NimYdZ5P8hlm?=
 =?us-ascii?Q?+zzJtpM1MJ/oXVsxwqBGi9+vNEl62qwfVlxAwy6CDLYrwSHmQZ8YNRzFbo56?=
 =?us-ascii?Q?NH63ialX+2bRS1RTpoVdphSutDbj9eTEsV3GfsNedRbw7C5sPIfzKP3/Kthy?=
 =?us-ascii?Q?7FU9O4mTc7MfKWTTMAMHKUOh0i0IIrzbwXquywanjUPwOohetUydnLcD3H7b?=
 =?us-ascii?Q?sZ6/dJxVgalyOAKCkVNOXT2kjGYiTGlbgByrDNzs+2bTeh9QPZElRs2TIrvs?=
 =?us-ascii?Q?S8Rw/F/OEWO3LRWDztrAQwCNCJhk8fQo4+GMutlCfdUAAVdPboT+DtrjYqYH?=
 =?us-ascii?Q?rOeEX9ys0jZI5Va4b3F4U6pvlfP6312FNspw8owzZFAfjtIMbLFsg3gYw4cN?=
 =?us-ascii?Q?XCqXg2t2HwiKcb9AmRLcxYCk/gFp7m4YFS8Qro0sielGHzkj2oXMm2DPfQrm?=
 =?us-ascii?Q?mM/Nbaf6qQ+lrsEcBbr9J/igx97jVdhQVonvIKpshUCr0PVL9oVWde2XXooU?=
 =?us-ascii?Q?I6f0B97FounfKzsy88EkuEFeM/scn1qHh26mdScyTuWp08QGphwAZ0tQbEYw?=
 =?us-ascii?Q?zD04PBozWeYC5HlKxhWKhikF+FJV3u+/26GQBNfemJpyUOssB4ZwIQdov09S?=
 =?us-ascii?Q?x8xJzAL0QcqZ2FiK0lyuwHz63NFRTcM75nG4FGfUr1VA4KT5F1kmPR7OqmR+?=
 =?us-ascii?Q?QDstYPaDiy0fdi6HWETtLc6CyklXbmyFSJTgb64V1zNFmeMzV5CBAd6wSk3U?=
 =?us-ascii?Q?Z8hFZoB6DI90IfnbFDtTnJTI42FSi0/UQGUndFE5srVjJqIyHBjZDbj4BIhx?=
 =?us-ascii?Q?ukuZCTbYJoR19lfDfw3s52ZdtivM6Q2lfW/ayDiMBugb++VmQnanh1yBf6AX?=
 =?us-ascii?Q?IAVZo3P7EuCXWb4cyTye4JzGhOW/JBHIAH8+TxCvtkinopkKGaI+MjgsNsNr?=
 =?us-ascii?Q?JWvqIsZU8DbRJNvgkJuD9rcTckYA15P5J0wZfG8krYznnvjjLx4CZQ0kUGK2?=
 =?us-ascii?Q?MmyxZ0bLy4sjpvyNAwIxMo+Ce21XVPYcqTLRdzbP0hGT0a7vKii2HiHvSoOq?=
 =?us-ascii?Q?CPLbOtlNTfCNPFsogLSwjkns9mSsmJyGhG5h5JjNE/Lfr3GCqk94I1SYyLgC?=
 =?us-ascii?Q?iyCRShPwhSrqOTwRzgRNUyY/AfPW5FOitLyhqiibvrmucL8LOAvNAa1EKm95?=
 =?us-ascii?Q?Qg79GOhTuO2S2sSno6bDKOCp+JaFx46Pz1tmH9DWyiX8AgzwNUuDTwcfJ8yS?=
 =?us-ascii?Q?8h9AmbF0tz1WlshGklfczuB3QZSAkzASnAJ7fP3i7XZuveq6UHPtbnNKIAy/?=
 =?us-ascii?Q?hZQK2xjietvw8VxMqySk7hSGVTnonI4+rKuk5NqWrZkws3dw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b126050-cd03-4d14-bef0-08de8a1151c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 01:53:32.3772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KfTzxF/R8v234/WkQ1o2t1R6W62ruLA6253gaW2VHjzvqJaGIaMnq4bmpBo4xtgna8pW8xKQWs4OOaOue0Pzow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7202

> > +static u32 netc_get_buffer_pool_num(struct netc_switch *priv)
> > +{
> > +	return netc_base_rd(&priv->regs, NETC_BPCAPR) & BPCAPR_NUM_BP;
> > +}
> > +
> > +static void netc_port_set_pbpmcr(struct netc_port *np, u64 mapping)
> > +{
> > +	u32 pbpmcr0 =3D lower_32_bits(mapping);
> > +	u32 pbpmcr1 =3D upper_32_bits(mapping);
> > +
> > +	netc_port_wr(np, NETC_PBPMCR0, pbpmcr0);
> > +	netc_port_wr(np, NETC_PBPMCR1, pbpmcr1);
> > +}
> > +
> > +static void netc_ipv_to_buffer_pool_mapping(struct netc_switch *priv)
> > +{
> > +	int num_port_bp =3D priv->num_bp / priv->info->num_ports;
> > +	int q =3D NETC_IPV_NUM / num_port_bp;
> >                ^^^^
>=20
> Can this cause a division by zero?  If netc_get_buffer_pool_num() reads

From hardware perspective, num_bp is more than num_ports, so num_port_bp
will not be zero. Let me think how to improve it to avoid such false positi=
ve.

> the hardware register NETC_BPCAPR and returns 0, then num_port_bp would
> be
> 0 and this division would crash the kernel.
>=20
> The call chain is:
>=20
> netc_setup()
>   netc_switch_bpt_default_config()
>     priv->num_bp =3D netc_get_buffer_pool_num()
>     netc_ipv_to_buffer_pool_mapping()
>       num_port_bp =3D priv->num_bp / priv->info->num_ports;
>       q =3D NETC_IPV_NUM / num_port_bp;  <- division by zero
>=20
> Should netc_switch_bpt_default_config() validate that priv->num_bp is
> non-zero before proceeding?
>=20
> > +	int r =3D NETC_IPV_NUM % num_port_bp;
> > +	int num =3D q + r;
> > +
> > +	/* IPV-to-buffer-pool mapping per port:
>=20
> [ ... ]
>=20
> > +static int netc_switch_bpt_default_config(struct netc_switch *priv)
> > +{
> > +	priv->num_bp =3D netc_get_buffer_pool_num(priv);
> > +	priv->bpt_list =3D devm_kcalloc(priv->dev, priv->num_bp,
> > +				      sizeof(struct bpt_cfge_data),
> > +				      GFP_KERNEL);
> > +	if (!priv->bpt_list)
> > +		return -ENOMEM;
> > +
> > +	/* Initialize the maximum threshold of each buffer pool entry */
> > +	for (int i =3D 0; i < priv->num_bp; i++) {
> > +		struct bpt_cfge_data *cfge =3D &priv->bpt_list[i];
> > +		int err;
> > +
> > +		cfge->max_thresh =3D cpu_to_le16(NETC_BP_THRESH);
> > +		err =3D ntmp_bpt_update_entry(&priv->ntmp, i, cfge);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	netc_ipv_to_buffer_pool_mapping(priv);
> > +
> > +	return 0;
> > +}
> > +
>=20
> [ ... ]
>=20
> > @@ -1224,6 +1313,40 @@ static void netc_port_set_hd_flow_control(struct
> netc_port *np, bool en)
> >  			  en ? PM_CMD_CFG_HD_FCEN : 0);
> >  }
> >
> > +static void netc_port_set_tx_pause(struct netc_port *np, bool tx_pause=
)
> > +{
> > +	struct netc_switch *priv =3D np->switch_priv;
> > +	int port =3D np->dp->index;
> > +	int i, j, num_bp;
> > +
> > +	num_bp =3D priv->num_bp / priv->info->num_ports;
> > +	for (i =3D 0, j =3D port * num_bp; i < num_bp; i++, j++) {
> > +		struct bpt_cfge_data *cfge;
> > +
> > +		cfge =3D &priv->bpt_list[j];
> > +		if (tx_pause) {
> > +			cfge->fc_on_thresh =3D cpu_to_le16(NETC_FC_THRESH_ON);
> > +			cfge->fc_off_thresh =3D cpu_to_le16(NETC_FC_THRESH_OFF);
> > +			cfge->fccfg_sbpen =3D FIELD_PREP(BPT_FC_CFG,
> > +						       BPT_FC_CFG_EN_BPFC);
> > +			cfge->fc_ports =3D cpu_to_le32(BIT(port));
> > +		} else {
> > +			cfge->fc_on_thresh =3D cpu_to_le16(0);
> > +			cfge->fc_off_thresh =3D cpu_to_le16(0);
> > +			cfge->fccfg_sbpen =3D 0;
> > +			cfge->fc_ports =3D cpu_to_le32(0);
> > +		}
> > +
> > +		ntmp_bpt_update_entry(&priv->ntmp, j, cfge);
> >                 ^^^^
>=20
> Should the return value of ntmp_bpt_update_entry() be checked here?
>=20
> Simon Horman noted in v1 review that other NTMP table operations in the
> driver propagate errors from the update functions. While this was fixed
> in netc_switch_bpt_default_config() in v2, the same issue remains here.
>=20
> If the hardware update fails (for example, DMA allocation failure or
> hardware timeout), the driver's bpt_list will have flow control values th=
at
> do not match the actual hardware state, potentially causing incorrect flo=
w
> control behavior.

Okay, I will improve it.



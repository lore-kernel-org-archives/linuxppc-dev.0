Return-Path: <linuxppc-dev+bounces-21711-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80B6CD6E43
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 11:42:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRhKc0xHYz2yQL;
	Fri, 29 May 2026 21:42:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780054932;
	cv=pass; b=d62H/7V5oB4Aj7cI+NNU5h+TeEJ6NZNbRxfZ2N9jFTQffFj22k5iQ5dlC+ErT7//VTNc5HTkl0T0dLmKQTZBtJvhP8S8dQPrBq3bKfl0kwNVUzh/iVyBlUzehMZOgqxUlMxY+WYAlV6gdXmDfk0qFQowmKbd5RccLtDF+0NQwzWHSu3K5gMqQXnqZV1N3jDZX/LOXcY89DqJe7lKjlGhbIobtsYR9Xaqx2F6bP/SjYKSEMHU9Any2+Nx3mvsfCLiYiN8LCMBd4zPS5pVR/tBzD4z0Lp7PCng+vkwxcyHG6JoHAymTFU5KNl/YSwhM6K7Km3jFvbtwgfrkN1KHQpLvQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780054932; c=relaxed/relaxed;
	bh=hInrqHjBg7z/n9KhlwfRg9vIne9TyAKckq8s2VowQno=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K5vpjNTy6csH6X01hdCYb1a3FTpY9JHEx6UKEwS0jV0yB61/S/meemdvqBxh+orYfcjmp/11PJfXCDCYBluozMAKHineqkt6qXRxCTYc4Nb6aXoiGF3eEhwOMfgtc+8KXYOP9IFjPqgBfbbeaWeiiEKFt/NqlNVEnu2qAKiXxBCxAf4/TcQM7YxbZb5k8dqFFOmHQfQq8poZRw+uy5JDG+O8ccdMZf0+44sIKHIo4xC35KbIvrLv+tPYvA8dwj8ApiQc4bPB5ZuRzsiVgPCHcuNSxm4AzRrG2mfZRRI2l5SVvJdgC8Cpx+QbVwjGliAZDkFEn0bNd1p8Cu3Y36jo1g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=RFuxUPv+; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=RFuxUPv+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRhKZ3D70z2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 21:42:09 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y31Jsk9y4IDwxA0ZOEiLJHYH9rHdv4f4g1ZBQgZIjPrLpHJ21wREuSX6T7vuFqJ6fkg94VqpKISJc2OWPiO9cFeLfvhtrJgdH6Q1vWTAO2FvdL9yDH5tl5yj5ytupnzPeIlm1k65YkPVJnVkf8MKz51e0kMGfoXkPvQcPhLc54gfkoYdW2tpIufVVLYfU+SSpdC4U0srLDb/doXEt4v+LF8s8OJGDbN5DA5W0+LUA50F9YhaZt09NbSxGFf1uENhA0/7u9Xbc4s/lmENqJHwOoLoAiM0QYcuCB4hP1sfQSrCZVMz83r7Qm81eKdYlX3TJ0Bw3KRvddfBWoxXQFEPEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hInrqHjBg7z/n9KhlwfRg9vIne9TyAKckq8s2VowQno=;
 b=n0DFjPW7r6uNrYgjMP4lDAxft2YtptCRYks/diaYM2qRXqznqy5d0E+cjR2fOEsnuW3xvlyZRNtD0ghW9Sk6S6gX4dYVw2XerCJ85ftVjUai3y8xZjwi7+Z4SvOVt9KScE4/Y99yimv5bkKkPNcQ607V7cVHeYQAkm+mI6gNS8sQAyJ1qqjMqb/j5vXlKHKXPo0Rmob06ibFPHtOXDURjPubebvzlpVjUnd7hnrFojwQGXqy4uAsbifF0yjYr267veUDL4bqZSjCNX9RbsocS3DDmpeL3EnUvdsb+anmNqEQhDGTO+rxyRobxOhHoorvZ8CkEiYEQXnGQ3oxFljlXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hInrqHjBg7z/n9KhlwfRg9vIne9TyAKckq8s2VowQno=;
 b=RFuxUPv+uVXw4w5UWBUDbRN3vbi2w0i8Pv85HwzB2doPUpD4QFx5ZauMmgzGkZdP9+Z+K/F+3JpJvSeUZBymJgur43sL8PTMgWceL4UUIcjD7c3mKNSdFe9Olss4DzC2dLwUwJoilNwAqXOO6xl9EP31F5uOb6Cgwu1JluMpfWI5PGO0HZGX3+nngGfhMJhrgMIhRCC2IZUHW1+jzvPAcuTwJW7TF5XQUpbiMVLVtufBsdzRFErxWI068XVM9DvL8r1wcs4ovnxr+ErBaTap7RAHalu6+fbj/M8XQ8FcUqBzkLOI/D2fcsxp1SPg7imJHeRl/rOxhtvoYVqsf9f56A==
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::22)
 by GV1PR04MB9197.eurprd04.prod.outlook.com (2603:10a6:150:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 11:41:43 +0000
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc]) by AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc%5]) with mapi id 15.20.9870.023; Fri, 29 May 2026
 11:41:43 +0000
From: Chancel Liu <chancel.liu@nxp.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>, "Xiubo.Lee@gmail.com"
	<Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>,
	"nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Chancel Liu (OSS)"
	<chancel.liu@oss.nxp.com>
Subject: RE: Re: [PATCH] ASoC: fsl_sai: Fix 32 slots TDM broken by integer
 shift UB in xMR write
Thread-Topic: Re: [PATCH] ASoC: fsl_sai: Fix 32 slots TDM broken by integer
 shift UB in xMR write
Thread-Index: AQHc72AfURLdifOC3Uyxaha2zeOCbA==
Date: Fri, 29 May 2026 11:41:43 +0000
Message-ID:
 <AM9PR04MB8353DA21759A12509CDED8BDE3162@AM9PR04MB8353.eurprd04.prod.outlook.com>
References: <20260529085020.3727790-1-chancel.liu@nxp.com>
 <c5591024-0d8e-4c41-9e35-56689fa94731@kernel.org>
In-Reply-To: <c5591024-0d8e-4c41-9e35-56689fa94731@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8353:EE_|GV1PR04MB9197:EE_
x-ms-office365-filtering-correlation-id: 81ececaa-64d4-490a-7e6e-08debd774184
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|19092799006|38070700021|4143699003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 ArS3wuXfipSbVK/JIKxJEENJJKLVMNALALJkM0FnX8GMfosLqCJiPQc79Um8GO+exyq3j+Tv4Itk3ED9Lma+KsWZEB9yzh+24AAB2kQbQVXXyytUPpfwhqZpFvtbpAinf1ToKgMuju3MbhXtSLej1KAKkZyMWHDA1A/sQi1rGNzrY6vgy9uK9BlvSmChKDlS7qHvYyqfvHlMTMGiOWCRuQISikxrLiy/10RSxd4xEx2KmXM36iNTtq5zkHh9WpjKyPGNYL2HKrpIkhuWCbWxZ+mHfYTHJJ5wHrRExDS1Goa8W0zvA/9lNF4lINJWWCCpw2SPziZQsnAXL1Nw0VDEyFie/KyJdfgaONB9JInpNt7LUF19vgz9GGG2KIjU2yXAacDbapDjSWXLMcTqyU+Jk1cdk+CPKUz0K4vvTwy9sAXr1HnlXeVU3INXynJBu8Eu3Yvz71P7Vz2wom/O/7HQ0jX+4L5hiui9s331rxBTXLdSwjCvQcBZ+ekJm03xU3Dq2FEjAbK1TYPEK39dBqH2zpjbeQ7BbaP326vSgloAHckiRiAQ11YsT6poOJEt52xumYyycl64DRk6El7AEg9cBdVgQVhw8WLEMlkejhpwXhu5EVATxgThlSE+okqJDoK+TitUzBoF5tyLBqPs1MoKncBf05DfCpfbzYFVvKsrLCRBrGJOLryBTFOSZiwcNOXsLt/1+DmxWLdqdSxNqsT2G6xqN4tV/cQpnbWSC8EhD6fLq7HmtzKyMN7COccZoAwT
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8353.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(19092799006)(38070700021)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6hs13INWDHxibtKh0YXjfJS89LAMlXHp5btXY3QqTYk3Uqz0ly3u+kxph4gK?=
 =?us-ascii?Q?liTOQ/JbOH6TmXyWLmn4sOL42eAIbxTLvKv7pc41iCfJlabasi6KKsf9ZpWY?=
 =?us-ascii?Q?/DZt+s/GeKIZcbQpcaapVi5AvfvZbBpnj/cKmGHX+gMjNqn0nZ4XPfwW217J?=
 =?us-ascii?Q?RXMF/5Mr12b+E4kfMtpD6vfdI88z7J2hxveM2Gc75xsjvrRy5HKIRBBUVGyq?=
 =?us-ascii?Q?6d2AegXyds79FTHZHSVI84LP9cTqYsyUrz4CbRFplNMEF35MSP8s+eAsNJ0B?=
 =?us-ascii?Q?5NOVX2zMFaBXKjlaiud0QNTpIV+lnSoxaq6mIbp9ACS0OftQCqnEUaIiLreG?=
 =?us-ascii?Q?owsdXoHnoLTWKzQaNLkFiNp8LqSsM40IJxFIHjCrl5yB6qQERTB5weI4MRtm?=
 =?us-ascii?Q?ivL24HG7HWAdxGqLyK95pYtYJfqRxb1rDi3DnXd/dmtzJzOMruIqGbs4Tk68?=
 =?us-ascii?Q?7bNIOmPnHpUgazpG4x87ABa6/O59VSRhzMeYdiltBabqHJZZgrsPVP2wXmFY?=
 =?us-ascii?Q?qvtUp0nG6Ijnp1CaSN0YRn882+usY9F/QL4bgANf0qGxOMH5JEoYFtTbKFm7?=
 =?us-ascii?Q?MPyPmZAiGtYOW0VOGFya8O+N+fGUmMAonJOPdIywNfiWLCA5EgPMr4pmj3oR?=
 =?us-ascii?Q?FRDGdYMjknnJTx9JUkxZqbIci8/u+QX5W157TkgYNOpkB6hSbXlLqHw9yA9u?=
 =?us-ascii?Q?9OKB4TxbHvgTreNQ2YT3/+eeId8iqbFgnSlkN2NO0xv6u1waNGHQprqT4uR+?=
 =?us-ascii?Q?uzH1MU5ILQhyoof1YD7qZSRj4KsLHPR5R+Hs2iI96EpPVFddFQRz+ZT380TU?=
 =?us-ascii?Q?aUUK5ifZC0sXo+3OKxeGkm97yS0lr8RoxFRzmEADcD4F8Q6DVtEMbUD2oczM?=
 =?us-ascii?Q?xxH3ZosXVPB4rJYZJq4quDD9iyZfFEwQ4hlc+YYrglFPSAkhJsAQ1JOFlh1o?=
 =?us-ascii?Q?JTu+X2yKX4G+cWwOD1E3Sz4dC7lxYeaf/pQwyRiT81uetgInoniAmzjCeoeG?=
 =?us-ascii?Q?7I47ZkxwzHZ6EWw2ZareqyDMKuWVVCqWXp8Lq63swYlk+lCVJvlCNQ1IDALi?=
 =?us-ascii?Q?joKtpIY08UzeGQT7HlXl0ZtZ/0xPBm4zQjdbDuIW7k3Mnh2CG6fNINIyuKNS?=
 =?us-ascii?Q?/dG4wirot/g5ZpXSrmtQmlK8br5bCU1jK3EDGbnVMM/7yj+maDmAfTDBXHPV?=
 =?us-ascii?Q?8Zo+AHOmr3ycy0ws/KrrKOYyEMgsh/mQZEHg+E5eSJRKCT8VUi4BgxXfr4XV?=
 =?us-ascii?Q?zvj7KJ+S2Qtf3pTgNXgYmTLosWe+QSmrmv+Glt+XB8DcyPVoHTs4WwJlLTWC?=
 =?us-ascii?Q?o9hy/9eLSzcc6dHozdqj/W5rTpTmrcgT1Rzc650kZguIq+S9AC6oQVKGJDoG?=
 =?us-ascii?Q?xYhE2WMj9kWrDgt8bCcgFKHIZYC9jkJvvbQ3UGmOpaNjNsFtxUeg9Cw8OB4s?=
 =?us-ascii?Q?5i+njIspcDUWQt6hCtvrO2ed3LSdq4IIeJlUaC/hFQcfcrMeImzmFDf4Do1o?=
 =?us-ascii?Q?Y+gRUnBlQ/J6SnRhRBXcmzb/h1AuEHVoiAUz0MrhCq/F4E2LGgh6/B1d4B+x?=
 =?us-ascii?Q?uk2IytUFcfZbJDP/pW+AdqvnSB0a+qT+lLTfyRadedmlV/2od3HjO0V9X0eW?=
 =?us-ascii?Q?RD7M/WmjDKbve31vNc7HUX5lefs2mB1qy8XeG48Oz0eceLB2/TkXhq52SB3q?=
 =?us-ascii?Q?DsRgZl91smvqe9zgdm9pcXYzgzSgVTwz7lm+tWNlNNhf1An0?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8353.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ececaa-64d4-490a-7e6e-08debd774184
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 11:41:43.0725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 04xG/ycYN6S9pLSvYFLod4FMlhkFg8PJ61reP5rJDG2eYrOUeJ9gPdwh8x/qgUYOqMcwUvnRxJchJQnZqjjpMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9197

> > When configuring 32 slots TDM (channels =3D=3D slots =3D=3D 32), the xM=
R (Mask
> > Register) write used:
> > ~0UL - ((1 << min(channels, slots)) - 1)
> >
> > The literal '1' is a signed 32-bit int. Shifting it by 32 positions is
> > undefined behaviour which may set this register to 0xFFFFFFFF, masking
> > all 32 slots.
> >
> > Use 1ULL so the shift is carried out in 64 bits. For 32 slots this
> > produces a zero mask after truncation to the 32-bit register:
> > ~0ULL - ((1ULL << 32) - 1)
> >    =3D 0xFFFFFFFFFFFFFFFF - (0x100000000 - 1)
> >    =3D 0xFFFFFFFFFFFFFFFF - 0xFFFFFFFF
> >    =3D 0xFFFFFFFF00000000
> >    -> Truncates to 0x00000000
> > Behaviour for fewer than 32 slots is unchanged.
>=20
> Why not use macro GENMASK_U32() instead ?
>

Thanks for this reminder. OK, I will switch to the clearer and safer
GENMASK_U32() macro:
	regmap_write(sai->regmap, FSL_SAI_xMR(tx),
		     ~GENMASK_U32(min(channels, slots) - 1, 0));

Regards,=20
Chancel Liu

> >
> > Fixes: 770f58d7d2c5 ("ASoC: fsl_sai: Support multiple data channel
> > enable bits")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> > ---
> >   sound/soc/fsl/fsl_sai.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c index
> > d6dd95680892..821e3bd51b6e 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -797,7 +797,7 @@ static int fsl_sai_hw_params(struct
> snd_pcm_substream *substream,
> >                                  FSL_SAI_CR4_FSD_MSTR,
> > FSL_SAI_CR4_FSD_MSTR);
> >
> >       regmap_write(sai->regmap, FSL_SAI_xMR(tx),
> > -                  ~0UL - ((1 << min(channels, slots)) - 1));
> > +                  ~0ULL - ((1ULL << min(channels, slots)) - 1));
> >
> >       return 0;
> >   }



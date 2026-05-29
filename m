Return-Path: <linuxppc-dev+bounces-21676-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DCBCD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 01:53:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRRGM2yB0z2xYk;
	Fri, 29 May 2026 11:53:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780019611;
	cv=pass; b=JWvM1SP7c/pTtqckevnqrfLosH59Ym1rKFL6a1G1c/WiZQ7jixI1dz1sKFkj6/RhHrLYumfPokowSUx3jE8QmEpsAJbY27cUSrxWZyDheC39sjrJ2gkskz0i6lDQPcsq48SkhbTwKNxQtZ5d34RIPNQO+dsw64tsS/N6Ex90kezQ5A0Kmi1aCHxgZ7MQt16ECiCy2bcVUjwFjxnJuikThWW74BKmy2izW0wAybrb5TK7Tn93JcxZNXEx/PVPPsQrc8Kqi8QGLWF/MbAF/173Tjs+EdjmUAOdJVq9c82/6uBC/S0/r34mkB7rk2bS5jnNHW0XgWwNWfuyAvwIkd5AIQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780019611; c=relaxed/relaxed;
	bh=wTLP9lQVI5caKh+Ud9thgBOmF32F9OXEBKx2OoLxUL0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kciFKtUaWH3q6cSs5V7VDxJ0cN6Itt2jyBpAfojcRR/fcFBExKANKxNnItGpfbQlFZCYyDslLP9j2CBj4m2OOdyg19AU2ZKWmdBvan0DqHAqZ5WdlDnZVJ3haxsZijcSZ9Qk/VXI0NiXkR+t7dwSRYNSrQBVIbAjTLrIp0859h19d6QOQbk3chFU281qTrmzYPbsZvm0Ff5c4Wiw5Mx40r4ejXqRSnXT9I2CbpSmZmSlGudivsjX7f820aUXMAgAE5+2unwQQIHzpQsPCt/kk4dp3oVITZXsWRhWi6WLUzwzSbjUQ6T4BsFhAkE1jX8Bd4b6dPUVFnhuidUuRyD7mw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=kGdWxmST; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=kGdWxmST;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRRGK2hM9z2xM6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 11:53:28 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9x1s3zYDbONnSSfBtX+8rifZFsKl//k8oDUskWXbo8HhWKn1AzUBJ9SEYIJA8tPSR0/J1dBUeUy6uE4qqzLS4bw1yrr83VgPWQqG1UFy1GnZiaC99m/ASjKpvcYMnzy5YeOBxEDqD98mWkwFDuVvPEkDdw5/rohE0hFNjp8U7RyiCIBQIijH4A2LU2FtICSM5q9xZeyJFxkr5m5Rc3Co46m+SJbghN6HNQNZI14yUDvrs2z7liDiqOr1Ck8GTTiARsw+J9kqjthFSrWcUggnQHQNG2e6v9IPlexnf48PznuPPbIFKByFLWIi8foZhwPA9zeh3woc9oFcWK+l+Lcwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTLP9lQVI5caKh+Ud9thgBOmF32F9OXEBKx2OoLxUL0=;
 b=mCraE6VLJ56hBtSNGi7xXFMEe18v9X06feuJzzOOcubmpxAIPUIPGjaRvlwlOwU9zLM6vrl5kDVky6yJ1qxyX86mxM/Xq0q0NQalIKPseiS/n4n5VSK9o1cLPBIPGSIjlKHq7rr0WBFdvXA+mIgyWrhbnqoKuOvfF0Mwd7GErqHnzOwoZ3bWARFsEJGKTZyWA/X0zgmMotkDcZYbHV6qULA3G0EyK6KNIjfi5GbMFycEPaiBbklkhCRlRbpPnSqkzaWRN9i2Q+u5BVYTbeRONoYAE9gy/XhPB9wtiAXL0C3LzxVrflmg1HQd3HbtZ4Wrk/bzaz9V26QOrqYgC4YAHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTLP9lQVI5caKh+Ud9thgBOmF32F9OXEBKx2OoLxUL0=;
 b=kGdWxmSTyQc2AvaDzh9X7cPmbfIlzu3mjCiq6KRbIS/tdlfTx+BbJCI/iLtFxko+HNFreftS3oT64I1mTgledR6KbGAw1umorLU99AW+AIEvRJswYEWhtHTqYOg3rsCvaKuYRrh617EhNSpVYc25hJwrLz7kWvxsS0kwhKJP/3W0bhwgqmDP6UvH41FNA4wRnIXG4tnlUqpiUyZ8c3W9JS7M08JwwKMXVcRjLGsKKEcsObaP/SplJzyVEuWxoxNxpT0LkoiBc/IRYSkY0AS7GbYbw8spG32TCC6v5PwoqooVGK1DazPD3ZyITwrSogmOMCT6nmZE51sNi7pBGn0QIg==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AM8PR04MB7729.eurprd04.prod.outlook.com (2603:10a6:20b:24c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Fri, 29 May
 2026 01:53:04 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 01:53:04 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"chleroy@kernel.org" <chleroy@kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"olteanv@gmail.com" <olteanv@gmail.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH net-next 0/9] net: dsa: netc: add bridge mode support
Thread-Topic: [PATCH net-next 0/9] net: dsa: netc: add bridge mode support
Thread-Index: AQHc7b9839CWsLJWGUGw7TxqVF516rYkPx1g
Date: Fri, 29 May 2026 01:53:04 +0000
Message-ID:
 <DBBPR04MB7500385FABFC6DB0DF9792DF88162@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260527100217.794987-1-wei.fang@oss.nxp.com>
In-Reply-To: <20260527100217.794987-1-wei.fang@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|AM8PR04MB7729:EE_
x-ms-office365-filtering-correlation-id: 5623044f-62de-469a-0366-08debd2505c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|19092799006|1800799024|376014|18002099003|22082099003|38070700021|921020|56012099006|11063799006;
x-microsoft-antispam-message-info:
 HeptXSbFpITEkyxY30lSYrBa5t1cNHWNPAYfOje48gT95PzjSxVbqonIovHtD33BIYChshXxrOFoAcWpa2MKbuLTCuGFbyfskrZJ9KpuIlQZwBCrjiepXFebjuU6GP3Z3IdrWXB502SWXmFJr1mKFEYjqsvn2k7vXAtHei+nkq4l31a51UxuM78MYeYzI03PnrKBRUAYEPQi6fycGIcWmEB6jigUSnin7PpJRbEue9ncY8tMnj882SfDkBbfsnapu8aFcejAiYcGYhA2oZ7JL5lS3P8yZxJpqp7uO/T/rDAytR/+VFbU0YCUL4DXtL3/nrsfHapQriXj78rHXF1mgNf1BSCjGj8bel9BaVSwh/iYfWnfqNhrWIi5DrCOOLkwH+Wt6JsufxRXqyQnwmmW3+6E1lfGU1+ctU2HWFVTrKtIFAfJcfJrZTUWViUQqq8OOCjo/G8rMbhjC1cUK5+GkXJvcgnVpL+7OcdMMhF2Xg9wdJHKGGMWTWv2DJSS80QsTnaz0bL73oRTngKtKjxns7m88Ctxy/nXf7oTWJwdDEh3/NODOO4OBPKO/DQBFLQCFmx7AODvVBVC9S8eBLPqQxqntTtsl/cxrJUBK2NPlDqX6ox2wKGqMCMWOj4LEjT0W2xNQBiglOmoND4l7G7YdvmVnnJ73bb2IBr0XPYKN/jzm6Dckx0bAyGcWkcRCf9gtoU4oaeGAq+FfNrgzre1Uw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(19092799006)(1800799024)(376014)(18002099003)(22082099003)(38070700021)(921020)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+JO1GE79I+klgz8vBq7NOSGIn8fcfhmOBnpcqk9e5d/6ZfGUF0UJZXdpniLE?=
 =?us-ascii?Q?B6stSw+kBJHgw//XfAatouEdFBxniPGWeSCY2+SmH5ImPQGaJg7BnURLlvck?=
 =?us-ascii?Q?ksJFnImtQc7jADCAGdba2iHgNs9yYOOazNaSf9TaNZPxSOt8M4TWMr2WvdrP?=
 =?us-ascii?Q?GydIes816tRCUiqjZNvULUhikMCsRg0qDRvL5tK+btVgYpX2lGSFSBVVep5w?=
 =?us-ascii?Q?qQ5flkGhOwQJ2Rsycoz/APbdz2O7zlqPGv1nHV05CmVAZDt/iui2w2I4tp3P?=
 =?us-ascii?Q?0VXVsw8zJ856exVZJU0p13+HRHc3T69tOpAQLLlYZ3ei1eVe5ehlVajLodUh?=
 =?us-ascii?Q?IGi/ZAml1mRAhWCWsI3lrmvVS2Dq7a6OTRIHmR5tl0LTZzwfRvbt9NJyD/6/?=
 =?us-ascii?Q?9hsoM92EaL0jm9GVJ3+m0ZdUvxgt6vAjit2d1C5SVk0zhmIUfY9QLcw+INsg?=
 =?us-ascii?Q?Wqu97bstkkmD2uXfRfmQVPWIKwM9RaY3c8du/+Qm6r3ydM/UoAxQZYB8JSQp?=
 =?us-ascii?Q?lWs/OSNCeKhcQdXbBzZuw1Sr78dTTpVNuyL18CcO7LuuwIKqo1LV2H1GB1Ce?=
 =?us-ascii?Q?ttfOYgp5upDIol/jLBvmJvBphYrhBsbc/bhYkShps9/g3oouj3bd4GvjoLXn?=
 =?us-ascii?Q?ZZNDgjFUqbSDcYXUcAYN475jiXuEuCuFGm9VCSm5DY24K+VFRIi7pJ1lHvh7?=
 =?us-ascii?Q?YcWjmGZdFY/5p0yR5Yj3ONcM/tlwhy69aBnn/zI3XV1ADYHqtJLZchXwXslX?=
 =?us-ascii?Q?3tBnccwvXzbJDEWb2bdbRCmr8+7KJeeZSZmtxuPxSL9nSLCbGQYMXmsX+9xR?=
 =?us-ascii?Q?uJ0V+moCsAL93j0JJOLxWda4KZV0WJDlQc8fA45V/GOmfASvLGXSSvok32P/?=
 =?us-ascii?Q?fpd013+aNPf1hd48LHtt9keKXSIvxpAV97of1bREdDLPJaIzxOToRipB7KGL?=
 =?us-ascii?Q?9Tst33+HVN+RLFiknOiI9BycWASmu1zNeDubZa1EjBsyQ87W9FLsthJPnDnj?=
 =?us-ascii?Q?+oH+KzBD5w2gQAPiEjjeZR5+djg6rC+ayv4zXMxfNjtfUJl1ed71ow3YYUf7?=
 =?us-ascii?Q?jqr7rFhTsS0fY2ygNATZPwwOey3JvFotLjo6UrrO17sZcPPzt5z+14f3LJJh?=
 =?us-ascii?Q?KwTh+TgZKnyzE796gN7sbSoQmLMAb2G94kY6yKvGssqjGpAAyJi0sjUps70E?=
 =?us-ascii?Q?tYoqyQOXOqUqzUJmeulSzUXLVyRv9sGGJrfjDtAfhdaMkeYetP05N3jy396L?=
 =?us-ascii?Q?s5MW6ojFdOBGEpJlB+9Em+iiBfuru0i9sthJEYmTodX6otnQFJ6bQSa6BFX2?=
 =?us-ascii?Q?01LiJXyTSBZAeB6jEOOPA0ZXkElP8FPsjTtuNZQjaxTvHERhWZGiK4wAB022?=
 =?us-ascii?Q?hlpM5V9Bzo4eLxzldrVGO4GbwpnlCMQ/GO7gzAyq+FmnZlCff2fG4V049xZG?=
 =?us-ascii?Q?wNLy4R+DUkocY+yCITlguozlIYtRa84tiZ58c4u4Cye0V8jAdn0NGduYeP0b?=
 =?us-ascii?Q?CK341m5dfK87cOYO0Sp3qgjXlFoR+9vWGu7v4gu24Pi+2CKkUiVALH1qfAlf?=
 =?us-ascii?Q?V0RHXzWTDJaNpqJ/LYX1qhD/8ZZrkpUTV3A5kjEnHFqUozzd0JMqxGOcfleE?=
 =?us-ascii?Q?fvaKPS5bIEMaJPgQSVd0v9EPyc84W16AB2E6xOGGCZqGfOVlImDe9dPdvpei?=
 =?us-ascii?Q?+/t7JxGptB5ZUHfs0p3+ve4w3hqpsdHv4bGPyZ/+ZVE9ncae?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5623044f-62de-469a-0366-08debd2505c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 01:53:04.1376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yk4G1cVOLSzoR5G0VWIxuSsnGPDGTvX2XWEm5J16JWI3omyNa2oPNE2REq6EQuJP/bpCiSyrSzGl9ha7SInJVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7729

> This series adds bridge mode support to the NETC DSA switch driver,
> covering both VLAN-aware and VLAN-unaware operation.
>=20
> The NETC switch manages forwarding through a set of hardware tables
> accessed via NTMP: the FDB table (FDBT), VLAN filter table (VFT), egress
> treatment table (ETT), and egress count table (ECT).  The series extends
> the NTMP layer with the operations required for bridging, then builds the
> DSA bridge callbacks on top.
>=20
> Since all switch ports share the VFT, so only one VLAN-aware bridge is
> supported.
>=20
> FDB aging is managed in software.  A periodic delayed work sweeps the
> table using the hardware activity element mechanism, with a default aging
> time of 300 seconds matching the IEEE 802.1Q standard.  Per-port entries
> are also flushed immediately on bridge leave and link-down events.
>=20
> Wei Fang (9):
>   net: enetc: add interfaces to manage FDB entries
>   net: enetc: add "Update" and "Delete" operations to VLAN filter table
>   net: enetc: add interfaces to manage egress treatment table
>   net: enetc: add "Update" operation to the egress count table
>   net: dsa: netc: initialize the group bitmap of ETT and ECT
>   net: enetc: add helpers to set/clear table bitmap
>   net: dsa: netc: add VLAN filter table and egress treatment management
>   net: dsa: netc: add bridge mode support
>   net: dsa: netc: implement dynamic FDB entry aging
>=20
>  drivers/net/dsa/netc/netc_main.c              | 882
> +++++++++++++++++-
>  drivers/net/dsa/netc/netc_switch.h            |  34 +
>  drivers/net/dsa/netc/netc_switch_hw.h         |   6 +
>  drivers/net/ethernet/freescale/enetc/ntmp.c   | 431 +++++++++
>  .../ethernet/freescale/enetc/ntmp_private.h   |  14 +
>  include/linux/fsl/ntmp.h                      |  60 ++
>  6 files changed, 1413 insertions(+), 14 deletions(-)
>=20
> --
> 2.34.1

Sashi reported some issues for this series:
[1] https://sashiko.dev/#/patchset/20260527100217.794987-1-wei.fang%40oss.n=
xp.com
[2] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260527100217.7949=
87-1-wei.fang%40oss.nxp.com

Some of them are indeed potential issues, I will fix them in next version.
Any other comments are welcome, thanks.

--
pw-bot: cr



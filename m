Return-Path: <linuxppc-dev+bounces-19485-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7627DFD5F8C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 07:25:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frF3Q17rgz2ydn;
	Wed, 08 Apr 2026 17:25:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775633154;
	cv=pass; b=GLnkQzpN+nPiUI0c3H5OsZRI8oFlIKE8NvusY5ncVnQx1bbLuJXaWC5RL7PmUCaYVY/JByqTRAELn8VPy77qKobTMBwtDcK8dNvwmd1EQvov7f2EIateijvy45omwKfLawRR6YUU8XQ/15g6a/g5KZdQbpm+4lpljEjrUmQSnvwqaPlte0yTA1iA84dHV6v0EbDjwinDYcFMYWApTZf+JRvnCiKdqFTFdXDSbwSxoqtYEnDRUEVFkXl0o3JnyAzcHfzKw5YWVJAAE22/+C8foXMLnVrOXwVHHEtM/lFfX6sWVY1POuAcE7XPl/+RiRqixKHuVgvlUDn8xMwbgNPAGA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775633154; c=relaxed/relaxed;
	bh=HvRruFTubeUXwF7018FqnGWqqNJJbdSSp9kFmoNCGJw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k/c8KhwZu899vLcnbW8wO8UOIvGFOQnOyiRtlh1+N6vcuIFS8aRtq2rYGXrw7kqPXDDQGgF6iD92LaD17uUWsnQOV26jfxRCILUzRhsiR2S1u/OBIrMTfOltSzj3KzVH4Q9YCG9CBl6NX4bx15sz+rYUK1OicLy6/Am2OdbfMH3q2Jdtq/ssv8cfaC5WBhOZ6OK4roxBlvS6Ce6NzpxaYN7leElWRAPYEa2y+CqIHCyfliZ00Mqrv3FcPeqx5N6SsAXd+278iRXAT8agSFUZxUaJA37+Cz2HDTCKbQBOg/6nEBpjShllg3CHxKKw/7v1nK+C/kJYPUGa8z5PSLSw9A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=SrTgWgiw; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=SrTgWgiw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frF3P2fhhz2yVP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 17:25:53 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHEJkJBeYxSRwjNPbk8MkdjngnFxaK7JBXiMVSsEnYfgOyUwxDFOWq+h2BGabbkTAKn9692um7oy742UXB5/+IWlK+elgZZOy9MITeZ8Q8dNYYPy6hri/k8bwyGBAMwk2yQw3GYN+ZE5hP4A6ou2/SKocW0tWhFihBj6Wg5Jwtut4TGGs0gsVp8wG/dXCLW+yUOLD7kZxd0JgfQOhdEcDtkiTXQMpzkq1VsQlkcl0p0jbWWbOq8GhiwKcOceiCI1EiUZ4HxRJqnB+6FySnebLKn0dJo1h/BtyiYs+Lr1UAM33CkC1aW4p/U99O2FB/wHAYpYPKdXLsYDLbl9JQNGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvRruFTubeUXwF7018FqnGWqqNJJbdSSp9kFmoNCGJw=;
 b=egdZYSiIb6fNgACKbui9113bmUPVpOVixynuL9XHCQvoW8nBm5EPDCKOYlZdDzH+FrXKZN31zkCkkNl92el9KwNiiva9CVeaDupv4TO7Vt10wJto11vAfWoSU4uwaB3U4jmVluvzhpJRJAQnxh3ph+OFAMppgVWuEFTOKH+rPUhqvKW7NMZLcG+QZHcox7qG02RF1LnZO/TGy9SJ0tund2pHaVBnL+3npmr2LFcIQMido0HlRhKPU7U8xIO9D8OtwhBHmHZWvmGwyhGfk99Ug57ypaYxqp0n177OEWNRlCOvwmf0Asrqh5Rx14e5xR/nmS7PLYFxxmxJNH3iixA21A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvRruFTubeUXwF7018FqnGWqqNJJbdSSp9kFmoNCGJw=;
 b=SrTgWgiwCB0p4Jq6liER24FSM/J+OWfr6fND7zWYW8NxA+IeH1QiJZiXt4boULUAnC9lK/Uawyu47r75IPDDWoCB3Syw3405SJZiwneIR/2nAIWOKcSKpRL/XYcn5hU5JqW5Rwi7J+ugiZEB0Q/aUpYLI05jbIk5C+T1pzTNWEHKaZENObw/WCRs+QPV7YrmYD0wzBgacfWKaAbffCfPpgeWvE2xhFtitGrw1hizSwlKOcl+FaiMm9H80qvQxK6AjYP/VK7uIZONUUvHnQyQ9levbvoOChReZC9Ny8F4l7dGMwEyYzp1iN1/bQV4R3QRyzVpgpsgfMA6FCh4haH52A==
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by AMBPR04MB12284.eurprd04.prod.outlook.com (2603:10a6:20b:720::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 07:25:30 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 07:25:30 +0000
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
Subject: RE: [PATCH v4 net-next 06/14] net: enetc: add support for the
 "Update" operation to buffer pool table
Thread-Topic: [PATCH v4 net-next 06/14] net: enetc: add support for the
 "Update" operation to buffer pool table
Thread-Index: AQHcwQGZFwszpqrtMEiEzU4AtN1Lo7XMjUaAgAhAGZA=
Date: Wed, 8 Apr 2026 07:25:29 +0000
Message-ID:
 <AM8PR04MB728420A74353D3DB9BA8182F885BA@AM8PR04MB7284.eurprd04.prod.outlook.com>
References: <20260331113025.1566878-7-wei.fang@nxp.com>
 <20260403011731.1795517-1-kuba@kernel.org>
In-Reply-To: <20260403011731.1795517-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR04MB7284:EE_|AMBPR04MB12284:EE_
x-ms-office365-filtering-correlation-id: c474d570-d397-4e07-ac08-08de9540034a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|19092799006|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 WkqwsKy/Y8Gzgvjlg5HoP6Omfj1HR8fNY9KnXaO8/KCwfn5y2krDlIF89Ocz44PLSrx1nB/izKty6uHJg9XQtKSWsR/Ee4+AgaH1ctGLXc9d79lmDwjcppNrtp8+a+8cQe9uP4do3fpYonFGCOQu5hQnkgYnFewGY6JMPnSPhruKKMs5riJjO/u7PpEiGPN+qLori3VgHFL+U10ZoPO4KVFGUGSF68NWz7n7VHgkx8EGEZ7IfNyb+daPg2yq5ZXiAOoZImYb8FbIdXB+vY46vN2suNgLe/TbNuuJHaDqIZ1lzd2cxUsi4C7h6nv83nBBPs9OiElG82qJGjVonzil4FFx4cjfzHFKQL7w2ypByBSN0tzjNt4hkSKtg0kRJ4KztA1GUkFT3JFK1foAYrKVUR7y5FMeN4DsVB3Gkjx7Rrgu9IAHeo+NVzD2EftNolFzv/LRZFC8Vxfc0erEzgqYT8gm/t7diggw/RBMsbjI1Wf+H+Y99LH9YyDmc/uAZvKWW0tHAz2GudG462q/Q1Ew6Y1LAOXGEiRHvNVguLcUU51iWV8AQF2Liua7n1IcrXQvwQEVzZnp+H8usEHZCQpPnVdVRxuuZrZrGwrcW2ydrF8TRahRCrAIDtZK2IvcB6mWeab3dXLXvcQ6cw6GUYVfaauKrvWKeqxEC+qOnYjjWYSBPkRKHpTPe4gjCa7+ULcNcffMTBzPATX25G66DGohffbN2hsxHXnu8ShI8c4veOd9Q3F0LyjI67VZI7gux5MaNdp9x0Pi+YQuphRIPRfSCvJF4mcMD9OY7Nq5oOLz4Zg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(19092799006)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cHXMnkVTsF/cegrmgQmAtmoxuuaj57tQKqHAl8YGFh7xgytf/6/gzc+AWFDP?=
 =?us-ascii?Q?n6Q5jj4+RgRIWVr5XgWeMz5I0wFi0ZcBqf3C3BMtz0B9OaoyePZmkQUQjTLD?=
 =?us-ascii?Q?sMZq2mgwPCOqKemkls6paQ9lUCSw+ThOV8Gxr4V8pEPKXKjYmkE34y/CTwIf?=
 =?us-ascii?Q?vvugJ48ME3LtqT59kGzMsNZz+oNjqMWVKDEPPYCJwBRRdDA5PjWAOPVz4Q12?=
 =?us-ascii?Q?KbC7wy259FmcaH5whP0cExfBtYR78V7wUE6t9Lzc67rncwtfkTPBpxR3l/yI?=
 =?us-ascii?Q?vCp7gr31fniMsD5iaPU86p7jKgkYD6rpZAhOi8iyJsECYyLJO8/3UtqVQg91?=
 =?us-ascii?Q?w+f8o4U2IhzQHisc3jsLYXUL02h8nS/Lwir8fG+9AWlzsm0oHIO2F/l3eF3a?=
 =?us-ascii?Q?x7sdzzgjnMoQWcqA7ngjx0pzq6qrJRU6gtLqXsAHuzbWclflnT9VqEGVAuBi?=
 =?us-ascii?Q?X/HRy2H4JpIFctAUHjMg0nbaw8id8awVlrlu/D5keh02lkvgtPURha/uhXiu?=
 =?us-ascii?Q?fe2pNKeaBxAMsztKp1dOoog/+51hYw5/AmX9n+S05Y0qjpqY1O8T6lx9WMYu?=
 =?us-ascii?Q?9yPuzF2WrIiyEomXOzrJkjLC4Dw4DRD2pGqmfPGAF+yaci9jgIQHsoX8/Um3?=
 =?us-ascii?Q?u7VH9riw5tTofaXqrhAfi29m9QnLVQmmTvr37dXFe7w8dWNdDwplpU9ChsAS?=
 =?us-ascii?Q?MlXyetpnB2j3cg+bROxoHlC4V1/u428vX5C5g/XPS/EhAAjEPfDaPLi74Wxr?=
 =?us-ascii?Q?EYuaLNEXT9hxmPSGbr1hFFZJbRKaT1UK1K4ybc8I7kX/TGcWD0EEVABnEUEl?=
 =?us-ascii?Q?jHGbUroo2Vt6WDBfq9ywRe6JQ1KUNMq66SI9MOyRrgebkIqyCWof0kiEQbD0?=
 =?us-ascii?Q?Vd6M/fMiBxKTU2uqB7XiFezIGApqP+K/yamYu4rQYM/l0Xm2Rk/2ZzLqI0JL?=
 =?us-ascii?Q?DV8OKTKpBx9/9D8khCMYld4/ePgVw+rd/xLX1zvPuscefkv5NrOU2BUJJNrS?=
 =?us-ascii?Q?bG3AUO9ISFsIquOG5Nb7Cj/g2lh9cwe0SXOvQyP/YrL9Gu8TkSZPtU7+U6Jc?=
 =?us-ascii?Q?ZsGdVgEAB6JL7C2U2douQdbWgYoGBnGikD3JriPkHfDXXzEH7BbQEy0W17tH?=
 =?us-ascii?Q?aEue+P0IUMM88jUr04MPCyVMf15LitrT+y5UuNGmo3QNRyE+DRIOsKt8u8XX?=
 =?us-ascii?Q?YMMPn44rNirdi6obG8B8+aypgX9g2bi1QHbALVRYFUdalO+Hf7XwHglzQdYg?=
 =?us-ascii?Q?hP1uxb34xfwxFKz1iUbvoZeiWZRMJWGb3SkQpZZT/er5aj1AkwH3d+RtSHij?=
 =?us-ascii?Q?5AvfUiQYH6eVZvnenVFbzqGozdOv7oKoJ/DWM+LW12hP8xclWKWZyr+pi3he?=
 =?us-ascii?Q?mytVJVgguJEgvuXMc0MORTyImgfSfb2WLY391srnobo6/9SXzyawxuTJx6YN?=
 =?us-ascii?Q?xBVyYo9q4lrOP83fAtH6kRGDP9NW8PIsY7biMujVyTxPo/CBdzR8NX9jzUdY?=
 =?us-ascii?Q?H9q91IO7PiViNFF3myo4gNBR64R+jfAq34ONCdDnm9kW8bHFlDuw9/Rev62i?=
 =?us-ascii?Q?h8rVmD96xlYQNUnwuZpSbrEForGYrCiEutvDdp8wjKQZQiA1M9Y2mgv77R3Z?=
 =?us-ascii?Q?mfp1Wn9DYvdoXY5LoYEYFvBKM4nICXZBstKxI520zQ75yJeYGqJBaewV8hTH?=
 =?us-ascii?Q?Jn/tpxmi/YtybgJf1Uz3tkApPWDhNdQQfcb7R/wztlLvRpyk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c474d570-d397-4e07-ac08-08de9540034a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 07:25:29.8598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IQSihLcDfl4O1P2JJ9HY3QVFQiBrH/gbxZN5K1RHgf43FfQRHNVGd5lpSvQ8d4gBAuc4h2ZcLNHz23y9qIroSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12284

> > @@ -702,5 +708,38 @@ int ntmp_vft_add_entry(struct ntmp_user *user,
> u16 vid,
> >  }
> >  EXPORT_SYMBOL_GPL(ntmp_vft_add_entry);
> >
> > +int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
> > +			  const struct bpt_cfge_data *cfge)
> > +{
> > +	struct ntmp_dma_buf data =3D {
> > +		.dev =3D user->dev,
> > +		.size =3D sizeof(struct bpt_req_update),
> > +	};
> > +	struct bpt_req_update *req;
> > +	union netc_cbd cbd;
> > +	int err;
> > +
> > +	err =3D ntmp_alloc_data_mem(&data, (void **)&req);
> > +	if (err)
> > +		return err;
> > +
> > +	ntmp_fill_crd_eid(&req->rbe, user->tbl.bpt_ver, 0,
> > +			  NTMP_GEN_UA_CFGEU | BPT_UA_BPSEU, entry_id);
>=20
> Does this update action mask match the size of the request buffer?
>=20
> The mask includes both NTMP_GEN_UA_CFGEU and BPT_UA_BPSEU, which
> instructs
> the hardware to update both the configuration entry and the status entry.
> However, struct bpt_req_update only contains the configuration data,
> omitting the status data.
>=20
> If the hardware attempts to read the missing BPSE data, could it reject
> the command due to an undersized request length, or read beyond the
> intended payload into zero-initialized DMA padding? This might overwrite
> critical buffer pool tracking variables like amount_used_hwm.
>=20
> If only the configuration is being updated, should the BPT_UA_BPSEU flag
> be removed?

The BPSE_DATA is a set of statistics and status records kept by the hardwar=
e
(internal buffer), and does not require the user to provide additional data=
 to
the hardware for updates. Therefore, for the 'update' operation, the reques=
t
buffer does not need to provide BPSE_DATA data.



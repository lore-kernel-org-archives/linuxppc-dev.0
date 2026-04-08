Return-Path: <linuxppc-dev+bounces-19489-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09638FD5F6A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 08:59:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frH7n4Kkgz2yDk;
	Wed, 08 Apr 2026 18:59:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775638789;
	cv=pass; b=Il9Fg1C1psVoAro9cHrMmzsrLmh/4S9HvHx/7MA5yj21f4Yv9GouO17AmY5qJd/kkTk4s1g750M63xvuTr2dAgpSjWo0Ji76HpmdgxNBmYksvvNWv9J3TJ7WHZJD7UB6AFsZ2fh4atj3biiN3UcnUprksahZVrOb/FUj/nC8u8dQsl6mZTVLj77FchBydRpuU8S9PTNPM3yXxtudlJhA2CvlxSTks8RttSTCwf6+WCldE4l00wJfjF2TiqcWCWUM09TObXuaXk2jeRew4tNizOY//JOrRfoP5Qm/jRKd2JbEj86MTItafFGYWiwYZhttdGucJqfA/HpN5GfFnQ9WyQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775638789; c=relaxed/relaxed;
	bh=Ht+rPhWyMe3UW5A+lG+keRfUcxvrk24jWY22nD6V3is=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LLUXxBEqOX3yhjMBKjzNALkwt/+V8iAoMhlUrhgHV86pWE+5Pd4xiyEGjexQbXtODbFVmge1z4Xt3WsxVEKz4la6GpggN3eKj9wrZ3qXnayXIfR6CKbSbWB1XNT6Qw+oqyRK52Qqkn4+D8jDHl2ZVknmgdNQbhaELmW+nHe/ymCBAWvlFvvhuBK3R53+FbUz5AezBlaFFYrlUYSIQSddBT9Hyt14hYN8Rn5LwThi7aSSR06gWxhVPXNsDjXt18nN5dZfyhj2GcqegmiyK1VxtWQCANh5h5A0mKhq80mBAjFXuX/hpROZZMnucK84/9NUs3hsF2+lfXjcf7D3nHJzTw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=iHWH5hbc; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=iHWH5hbc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frH7m1pFSz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 18:59:47 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rj9zBnmRgM6nhiH5ODMoYG6hvkZr6985JiuCEue8odSbrdIQsiYZQuR+0sl9mJszbwXrmtaz9041+dkUG5XWMVqV0tnw5oUiWDY8fSOPidHjyN0JbGkWBcJf1PQjY3kUQEMWO29TyCicqll4ZN8I6eRQDkOOkIW3qldaZlywzgDxL/wVgBIsubtTY41pzDgwVKXdiRzJ2FT8BMtMq/PZHFuLKgZXQ7S7FtlfkRNXiAbla2nlZPGydQqSvEXT9POy7HdjX2m6cskgOPhV4kXYShXssa7LnumNY94Qv2WzlqbRgOmYnbBCgDmCBjfWyXlDQ7sHT7we9OUGVMC/l8IxTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ht+rPhWyMe3UW5A+lG+keRfUcxvrk24jWY22nD6V3is=;
 b=QyQ8PrwnOLPFNgJCDuuq3TTJNrbfOJqVAU76MWUh5WaLUkj0M4J6lVVZmhh2f44lndUCaSrOLwOfoRS0g5R6D7NDYxb5H4WViZz2P+WXnVci1LLKc6QIsOM2x9QIIu8OxX9WuRXPrIslDbKSCijbbN/k8cQlQmJ1OULFMnJPWae7MQJlS68eZn0mYyaiftw+X7h8nkR7B/k2EUQkzA2QRmhAOO5aDKQeUBj0YD4yq9yxGqsAIGHLNMFFxne+q1erSFDU5oxrXJEj1BREk4vklj6Y1I7ewWTSAEFBaNq80zmVMSDnvPCjAiOpJHVQS60/SiAybzDNS6jl4+ngBgz5wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ht+rPhWyMe3UW5A+lG+keRfUcxvrk24jWY22nD6V3is=;
 b=iHWH5hbcOLH6hYwe/qMaTjB5KM40+MH1/+qLwrKTO1btAJygHXhlCyDapIKBdu4eOsw+PV6mVpCc0Dq7NCcfDPXj7HsDFmU6+TK6vz1HFByovx98N61bFzwRelF/TmkHIUwQ3s3WRGyY8OBFV0tHRQAErPaJHfLpbl/5IaDcyg91DbxgfTNBf9oNI815HM3NnadGPgjnqmGPdCfuTcBUR+iRdDKR2/Zznyd0XzXsNdbeKB3FplAvFBI/iIPr2NwMlbg0aCU58R4ivmRbp63kFXYAOKr2vbTHi7DdaIXf6IcyJ6aRDsHMykaEv14pAgY7uGlQTOoVyTd7TUK3qB1l7A==
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 08:59:24 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 08:59:24 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean
	<vladimir.oltean@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, Frank Li <frank.li@nxp.com>,
	"chleroy@kernel.org" <chleroy@kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH v4 net-next 10/14] net: dsa: netc: introduce NXP NETC
 switch driver for i.MX94
Thread-Topic: [PATCH v4 net-next 10/14] net: dsa: netc: introduce NXP NETC
 switch driver for i.MX94
Thread-Index: AQHcwQGr6p6cQRIC50ifKdNlYVQM5LXMjU4AgAhWcVA=
Date: Wed, 8 Apr 2026 08:59:24 +0000
Message-ID:
 <AM8PR04MB72840DBFC7F3FD578DFF6AF8885BA@AM8PR04MB7284.eurprd04.prod.outlook.com>
References: <20260331113025.1566878-11-wei.fang@nxp.com>
 <20260403011738.1795644-1-kuba@kernel.org>
In-Reply-To: <20260403011738.1795644-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR04MB7284:EE_|AM7PR04MB7157:EE_
x-ms-office365-filtering-correlation-id: 5791bda8-1944-403c-b2a4-08de954d21c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|7416014|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 H3lByri3K01dHqYAJkes3Nceqs4YTmqCDt3PjB2y74tGOIYMl1170Ri5JOh2pJFAsAFhKwDlVMTYuULXrRDYpAbVl1/w0LwPwmzZW0hJTyCbKAKefh4NjFsM9SINlpEksJy1HepZRtld0wTmJDZF0M+lK8yWMV3NlkPwGChJlFLzDtUGdCteEX34xs+qXYMSjiY6Ylqynb/XeA6WAaBMQVBkxaVkx2AEKYETXYQdQimKsrFK1y/ZYY3IiqQrhKS+KpVluOd7etcSP2wrNIM7ss9hozVa5V4ZFzPNbFiGsCmcV07+dARm7R03M3WJ5IN8GwpMQoYz6x1OnC8R41moCYp+apAnOoqc9t2rLhKd0FkUj6SCGbhQ+QoiMYcpqH8dpBzYCIbAWuktlbbhlaIGKRixYM1SxK+7eGcM863H/KCaXlN9BB/iQ1vJ08jnO017mHypwupGh/1tkLbVgcyPIdkP7wXJiCBR+cO8nj9GqcLqmmQ7zdUvE/MiFlmR7krleu2lUs02at2qyIpLkNzY8BOng9XJd646ruF7lQVsS2clu+OJKn5rFntFw/Fq3Cvp2MssRsia2cAqF+7p/x6hx65cD2Yo8lFhmbM097VPg3KLAunzMffMoLF7Kz2H0VCIm1FE9/KATslv0PAjwXZms/IibhVSzLR5HLcLV9kuetWKlPn8AR9QXKKmJNaetB4/SBG+Yyl77CvrNUczeJ3xxny44nV/YOE0ygDFoyLm3a4vzsYnxP/Q6IVvy0L9ZCxVhexuwoAigDrP6Voe51ZyMLu5IdnInDI5RXGWqRUBwpc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gVqnNiy8ekPLW97cOSz16ZHD8BjO5aLP8VB5V+1Obe5mNRKi7lIMHQpg5X7S?=
 =?us-ascii?Q?bpoturLjD26QB503g+AjxCMbsrzhf6PsuqO7Y7cLqEWN0jotIlKLCxANMg++?=
 =?us-ascii?Q?vdPzDhfZuRIxml4HTpIp89ARLR9phsnhQIj52zmjjHpKnP119uMCMwwAnMjp?=
 =?us-ascii?Q?SYHaLxJLH7tW9NtLxz/9jCgaKKcfTWC0j2LtHfZiBNwdw7rG6JyAvdLgToAW?=
 =?us-ascii?Q?rvVdd+mwTWCFOR8wqTvNYNl5QhBstBH0DBQ4ye6F7JoaPLpg3+0eHWk8i1lR?=
 =?us-ascii?Q?Id1oE5rMmZL4gbgdPe+jTlb1V+7eD8mb7UqJ/UPJ72Oeb0456E1uYHAnBROR?=
 =?us-ascii?Q?oaTvSZ3Nagq0Gi/LAbnAcAXjQc7Noo/h+RE948jahsVxTZZVMXVA5Yet/jR1?=
 =?us-ascii?Q?xSc86Ia/aYvQpTIsk/zALM+/RiP2QWElN+3w4OWEeLbVZ9aHhgofMOSZWP2K?=
 =?us-ascii?Q?7T6mRCf/Sr9usqpgc9yzuJVQDaTrOsVpKJZLGfprpMeiyj8e6YrkoW2aWEnl?=
 =?us-ascii?Q?Cm1hbJ/a43XsNH/TyGa7Rx5wbdkcdTp7QlWnxJRh9h3eGe53zikncrT38GeU?=
 =?us-ascii?Q?QgDLwwzchhqU/XKyGd0xfI5U3JoaF/goTketzP/2XrucEBTFW/7Xbbvt1PNS?=
 =?us-ascii?Q?wnIMVFUheS1TxCgnwNjfEJp/VNd3Kz4So+oDDd65JxxdgyMmW3z78IWHLB9a?=
 =?us-ascii?Q?Byf0lQoaX9EnUxzIohBONo+FK5ENdb5WQ7r32EM5Y//aOMMzgMkZmwLSkIjv?=
 =?us-ascii?Q?eQiNW81ulh6nHq1uLYOY6aTICNFsXkXjKTZ5wixpcKbRoPx+n0/5Mq6I/pau?=
 =?us-ascii?Q?q6DQ0AsxBaeGQH4Y+ZRLq3mTZqBNjHOs+xgs0Nbubqlj8n3zq0mVJshWSetN?=
 =?us-ascii?Q?XJG65DbR5yc9AEcDvucrxf4w9uZdSIs9Uf4mDSHbgUVlk9iKbk1lRMZpMEGL?=
 =?us-ascii?Q?CaamZYmq9OwbKAgCu/cU6KGcLgTmpGrirEtfTh5Vxov/s1ymE9BGLAMDoDYQ?=
 =?us-ascii?Q?niNDfj608jn+P4ODXNNwo/DrAfk0OdlkLBsaEZY9wovW3Vioj8igfWo1Mcrb?=
 =?us-ascii?Q?vivwe+HUHUcpmnSC8ULlcenaSkEh8YdEFu0yadJ3IXueHAeeeY/2rYJF59po?=
 =?us-ascii?Q?SuD1BUORF9PEAkAHaw+5ZMWojeiQjz+WgbRgT+ZwrGT9ZhXNqLC28egxMaMH?=
 =?us-ascii?Q?3jrIclUAHU0QRx+G8NNfINwJLYdhc3apPqzADVQY9Ft37LYe2Rk274+vkpQj?=
 =?us-ascii?Q?rQxVaRfZfuJ3RKWB4s0fHoxXE/BjjMxAyx1H3m7eMMNNKtxndwJOldbQzODi?=
 =?us-ascii?Q?rO1u4My2ZGApIW+Jh7YDWryLoAf1mI0xeJhDjJRiYh1zrzHOrDfmUnApZwTT?=
 =?us-ascii?Q?lVtqE2rV5JhHJe/7wSh0sbKSdNb0slAXH8fKaLxB6zuCdi9p5rVW3sbsdSDI?=
 =?us-ascii?Q?WHAyg0+1bi02UyvTVL2H8AebmHrTwpX13U6zxH2xzlpNj8r+g3mOI5vAD0A9?=
 =?us-ascii?Q?nN9BGuEVzkqjogpL7c66IeJVWILkSszs7voayg+OJnlDvZ6Mw9duT9DV07J/?=
 =?us-ascii?Q?A8/5N5fTXZzHqW6dT1DZGHkWrKRnT00lkVTJiMeyVJPZHzPFc0ULxSPhaDvT?=
 =?us-ascii?Q?R5/fZgBzyHwYGUKqChsOTiCTOyTMvUa0A23/XF5qNWOBWi2uSduGvu0srGG8?=
 =?us-ascii?Q?1GzdXa4FytF+YlVFbRyGgGxS57m1vl/oZ1HRH+qnsEvmL9DU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5791bda8-1944-403c-b2a4-08de954d21c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 08:59:24.3946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qyr/n6eqJphGwf+gh1rqMMdQhcf/yhx9r1wV2a2jtbKrmgD4Dx3maGjZKGDaTWyVh2aQhuTfZVf84i3uqRVRlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7157

> > +static int netc_init_switch_id(struct netc_switch *priv)
> > +{
> > +	struct netc_switch_regs *regs =3D &priv->regs;
> > +	struct dsa_switch *ds =3D priv->ds;
> > +
> > +	/* The value of 0 is reserved for the VEPA switch and cannot
> > +	 * be used.
> > +	 */
> > +	if (ds->index > SWCR_SWID || !ds->index) {
> > +		dev_err(priv->dev, "Switch index %d out of range\n",
> > +			ds->index);
> > +		return -ERANGE;
> > +	}
>=20
> Does this check cause the probe to fail unconditionally for standard
> single-switch topologies?
>=20
> The DSA core typically assigns ds->index =3D 0 by default for the first s=
witch.
> Because !ds->index evaluates to true for index 0, this setup function wil=
l
> always fail unless the dsa,member property is explicitly overridden in th=
e
> device tree.

As I mentioned in another mail, we added the 'dsa,member' property to the
netc switch DT-binding doc, specifying that the 'member' (switch index) val=
ue
cannot be 0. And 'dsa,member' is a required property for netc switch.

>=20
> Could the driver translate the hardware ID internally, for example by wri=
ting
> ds->index + 1 to NETC_SWCR, rather than forcing this hardware-specific
> restriction onto the software DSA index?

The current approach is based on Vladimir's suggestion. I need to confirm w=
ith
Vladimir which approach is better.

Hi Vladimir,

What are your thoughts on this suggestion? Is this approach better?

>=20
> [ ... ]
> > +	for_each_available_child_of_node_scoped(ports, child) {
> > +		/* If the node does not have phy-handle property, then
> > +		 * the port does not connect to a PHY, so the port is
> > +		 * not the EMDIO consumer.
> > +		 */
> > +		phy_node =3D of_parse_phandle(child, "phy-handle", 0);
> > +		if (!phy_node)
> > +			continue;
> > +
> > +		if (!netc_port_is_emdio_consumer(child)) {
> > +			of_node_put(phy_node);
> > +			continue;
> > +		}
> > +
> > +		phydev =3D of_phy_find_device(phy_node);
> > +		of_node_put(phy_node);
> > +		if (!phydev) {
> > +			err =3D -EPROBE_DEFER;
> > +			goto out;
> > +		}
>=20
> Could this logic cause an infinite probe deferral loop for ports sharing =
an
> internal MDIO bus?
>=20
> The netc_port_is_emdio_consumer() function assumes any port node without
> an
> mdio child is an EMDIO consumer waiting for an external controller. Howev=
er,
> if multiple sibling ports on the same switch share a single internal MDIO=
 bus
> defined under one port, the other ports will lack an mdio child node.
>=20
> This would cause those ports to be mistakenly treated as external EMDIO
> consumers, calling of_phy_find_device(). Because the internal MDIO bus is=
 not
> registered until later in netc_setup(), the PHY device cannot be found, a=
nd
> the driver returns -EPROBE_DEFER.
>=20
> Since netc_setup() is never reached, the MDIO bus is never registered,
> causing an infinite deferral loop. Could the driver more accurately ident=
ify
> whether the PHY belongs to its own switch before deferring?

This case will not be true, from the hardware perspective, the switch ports
do not support share a single internal MDIO bus defined under one port.
The internal MDIO bus of a port can only access its own external PHY. So
a switch port must either use EMDIO to access its PHY or its internal MDIO
bus to access its PHY.

>=20
> > +
> > +		put_device(&phydev->mdio.dev);
> > +	}
> > +
> > +out:
> > +	of_node_put(ports);
> > +
> > +	return err;
> > +}
> > +
> > +static int netc_switch_pci_init(struct pci_dev *pdev)
> > +{
> [ ... ]
> > +	regs->base =3D pci_ioremap_bar(pdev, NETC_REGS_BAR);
> > +	if (!regs->base) {
> > +		err =3D -ENXIO;
> > +		dev_err(dev, "pci_ioremap_bar() failed\n");
> > +		goto release_mem_regions;
> > +	}
> [ ... ]
> > +static void netc_switch_pci_destroy(struct pci_dev *pdev)
> > +{
> > +	struct netc_switch *priv =3D pci_get_drvdata(pdev);
> > +
> > +	iounmap(priv->regs.base);
> > +	pci_release_mem_regions(pdev);
> > +	pci_disable_device(pdev);
> > +}
>=20
> Does unmapping the memory here introduce a use-after-unmap issue when the
> MDIO bus is unregistered?
>=20
> The driver registers the MDIO bus using devm_of_mdiobus_register(), meani=
ng
> devres cleans it up asynchronously after the remove function returns or w=
hen
> probe fails.
>=20
> However, in netc_switch_pci_destroy(), the driver explicitly unmaps the P=
CI
> I/O memory via iounmap(). Since netc_switch_pci_destroy() is called
> synchronously inside the remove function and probe error paths, the memor=
y is
> unmapped before the MDIO bus is unregistered by devres.
>=20
> When devres eventually unregisters the MDIO bus, it detaches PHY devices,
> which often perform MDIO transactions during removal. Because the
> underlying
> memory priv->regs.base is already unmapped, these MDIO read/write callbac=
ks
> could trigger a synchronous external abort or kernel panic.
>=20
> Would it be better to use pcim_iomap() to tie the memory mapping lifecycl=
e to
> devres, ensuring it outlives the MDIO bus?

Great, I will pcim_iomap().



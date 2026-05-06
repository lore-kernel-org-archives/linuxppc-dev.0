Return-Path: <linuxppc-dev+bounces-20506-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7D2CD342C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 08:04:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9SZW6Ldlz2xpp;
	Wed, 06 May 2026 18:04:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778054643;
	cv=pass; b=DKTWQDKSL4r4F8URjLcdnb80Ur0LyU1BbB2hKuV3QoJdY/4x/XAWcC1BzdN5Ka/uOVi/NCad5C8j8PlpbVKFlwUK0I6OzTmuQZlf6cZ68YXeikx5y/Cw1Fie4AvU9SUIITKtFttjSf/IT0OPaNGHASSACI0Me7SFlDgBNhuj0qg/UCMvnYN1sCqurYatk1tIC0nvKQmqDcdWAMcODVYKbTRXoWSazQN4KT6T9DVSTTmJQAiAtCLIXde4qt3Tn37a9dSxPjVQiMvmd3vRupzsI+FPSAWrL31BSSbo/uJxNBtPo8b0KkDJGq9S10oggR3KKSz4YS/vdB7TbFbC/BTNNw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778054643; c=relaxed/relaxed;
	bh=J4xMo0pPXdaiwf0AMsGRkdhnuWle7alHMf3gkriypu4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UzjaUcCk5ZxEhA9YiD1LinbuGWaX91DXjWOpFRLt0D2J9CqiPrLnWXoMOn+sLqGdxm0SF2LJqCmklilWo9VSkrgwY6ZzBFXtcHZt0KHQUqgl1XciPFOVW/iFtsvWkONK7RPkqdv7rVV0Nhf+M+U3kgSig72Lj0UrFMkaCFyFerFjKgmEnKB63Z4dyOanVrOf7g8fhOGKJ+8bZd14C31ZG4DoXgHqVfIioCDSQoLrXzuZWa7QthERKPHZ1dERLhvtQxUMNhp7hdS7x52QyKR64cXqafZSGER0UYtS9jEShaRzPVPT2Vjs5VCMcdY6c8nFgstSii/8AeOl0D11Kf4Rsw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=elSCnqBx; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=elSCnqBx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9SZV4RRpz2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 18:04:02 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODmzEjQwgiPwC/U8Mc2tsrsxfZKDTqDHsLXg3vLj2ShZd6Xh8n2MxqobGDNzh+dOku/rIhJ4f9EqSNJZDOKRSkxZTGExsd34/QcskWBZfdlyjpY9yEJrrw94xTRlOEE3XX8A5GWVggierKl/qcQXBalTErZzkc/JMw2n3o7yrUa6mMeJFfd6mywzd137pGNnq/SK++lNftTV5RLca89yl5VIfNUE93LXExkYCf6/V8b2zYQUyWhsqN68WuX0gN7OLlAVLqEToqBfKCmn6FEloz0Q1RTPb0ut+WCMDcbeKYA9Rbfmroc2kFw0sqI7c37nQYx8+QW6RuZjK6ZxuR6kNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4xMo0pPXdaiwf0AMsGRkdhnuWle7alHMf3gkriypu4=;
 b=a/SzrPsMiSdKIHujun08PQGkx+SoDYpU0Ze9I9L6rF42GFf256ITJu+YB4BECWw43TU9MJSImj9gczOHpSjXIppPhg4tmEGCQTJHtPtljgCzkgVUZnH8cMgp3E56fWrx8+lxSkOo3Y65I6BcDkkVR5OAkpegAv6eq6WROTARHcwWwClUicwVdqEE4PdP6wh2Yg6m2LOxWTiBrRLD48bEMfTriUxoXbEaSSYP9XFxEJ/7oF2GoNAV2s5fBVjNIvIMbp45NgHrdkrJcJJMl+fVD/nQbDaWy3q3HU4WTOWC5yRM1S3InVJW5QU0NcUNbm6VEEOo4jDRLx3Q+MmK/6s11w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4xMo0pPXdaiwf0AMsGRkdhnuWle7alHMf3gkriypu4=;
 b=elSCnqBxEigk3hLARelSxMuew/Mw26EfrEoTyX2QFT8IIsMR5+UaSXTDcyZa+yG65VPh5a8huhqQvZN1rzRcy9UfJS06uUzwj9ksQHJkscHZVcvxA4n4ivB60+SqjjfT0sDvz/EuQ+MWn347Dbccbd9uPzounYhjsc+FNUmnDC7iBfetDhKZYz+K2upiTEHgJaQF7wa2N3q0rXdEDVlMdw5iO0TVhjjEcghTPzHczZbxaGRY7gFcVMWUTI2gVCYunBAFUG9CcUs8VfGQCp3pQhPFI02g9rJWwgkixB5EAt8uReUmMlUM30ujzP3mL/p+KrOHEzPoGClznfWatAlO0g==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AS8PR04MB7957.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 08:03:34 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 08:03:34 +0000
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
Subject: RE: [PATCH v5 net-next 10/15] net: dsa: netc: introduce NXP NETC
 switch driver for i.MX94
Thread-Topic: [PATCH v5 net-next 10/15] net: dsa: netc: introduce NXP NETC
 switch driver for i.MX94
Thread-Index: AQHc2EvYkI4rMyDxsUSMr4nHz2GO57YAqezQ
Date: Wed, 6 May 2026 08:03:34 +0000
Message-ID:
 <DBBPR04MB750039D8341BBD56061E44FC883F2@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260430024945.3413973-1-wei.fang@nxp.com>
 <20260430024945.3413973-11-wei.fang@nxp.com>
In-Reply-To: <20260430024945.3413973-11-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|AS8PR04MB7957:EE_
x-ms-office365-filtering-correlation-id: baba4929-b33c-4a73-e1d5-08deab45f8ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|7416014|921020|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 P/Nz9QhIUont7UM/Lfbget7JMS/LfFxjBnfaKUP9bev7TW1wle+fZRWzBRiKaG+OBFdsYNpgeFGkBGfqk9U7LivR6Aj+OV31cZBQxvM8GCtipP6GMiS5BvvB8HmuEb5RVs8xXJynGDOssbro4rpFq8KhKdNcaMZkG96hQ/+krfU17y2nvKvCBFnS5KMZRzZI3yzwyClHvv9ZyHzg2EC+sOGeQ2wUUMRqsyTEplv1s0gw7QZyT6wJtPs4bfqXyM4Bkq0rySEm+DWLlQmW9YVxNEngEOBpmgY7nnwyvNk4rYizOWYlsNAd0Pns648GymEYltVORMINIWkYueeL4ygm98XUkzd1zw2mTC5Sjw8hIFl6nH6SIyUJoOCBRDNY9F2SUie2pSspAytregIiz1bv2Eiqs6g349++NpsONA/4LaAbLIn7m/OHkQs4KpuOrmjLKK7B7MYMGKGwOPr1ZXvKo5x219mNzOOq0WLA/obotrQOGlUxOoT16JhP5EF0IDJTVoJKtdbmuxmZ31/NbHolZsggXRPQ1UF4h1ag+wP/8tIjF8xkBZddNOkGsUuQ/tKcn++lhPYKsettVvBPdJMcrQ2zB/+79MtTuPgQrQfy6PCvjdnA7oYDUNwrCAPjYgbZsoVGnk60CEO6HF4LaKsnyF5ZtmTixjFgvj/GY2WE+WD5scj4AXE1UqrEHSS+5toXNlLUjbkCAJGvqsdbjZ2Czc8eIdbDMDxKMqk8MrcJlLbkxSpbeb1K1Qc7B5IBAY8s4DtuPEjIab6UapdClc6AzQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(921020)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0q5yb8F4XPvBtBakFWbCLkVExzKbVLSoDk80DVR3ysBWEDgOStL3oGONXs+j?=
 =?us-ascii?Q?yzHIRvaIO4xXZqV/cZsLvClP2lmGd7SZL0TI1MhsXMHiOU4TOY5vRVU3Rp6d?=
 =?us-ascii?Q?kOg244b6aWqVVpgjgYdiG5JojXDBTBlDuTfOz5YeWu9qTudWCnZgjvRVdzxe?=
 =?us-ascii?Q?1on/f3EjLSpQCaip6X3gpYalY5jX+gVEGs3NDNwYBjgRcgSqxr/6BkeUBFfV?=
 =?us-ascii?Q?Iw0tGYZQmFzFcoTr6ifX/QF6YBBMXyyfAueV4CabxpXqBDVw4oTCHH4kjLpB?=
 =?us-ascii?Q?6ObZo5/7y9CtJCudzcZB/P0+9GQMA9wYkUB8c3cVzqf0smDLzJyJpcFrCQmH?=
 =?us-ascii?Q?TVAdhrfT+UteJmu32PBeS1Lwj9HsbGj2zwFYGyy+DYAPtUiaUkij0dtcnFij?=
 =?us-ascii?Q?A92NfB0v6uUbmNwRopEwLIzlUwwMh0Rg+sqa2e/3xS0IqqbQQOe21dTM0xoo?=
 =?us-ascii?Q?UJ/T+jDft/YiO7yymPP7bdAl8dnMhDH4AkvGj+q8H/eXeW873CPcWSs9vWYr?=
 =?us-ascii?Q?5ARJ95TWmh7MUL41n4ALHtZFz1zfhaH5f4LkMyXYJGDdLQJJj/jTXVmtxbuF?=
 =?us-ascii?Q?jmCVPYF7+eGm2p9eRV0Rl4xL6zAp0+nPuzLOxEcNuc0vQy4hWSE0PWNPtn8n?=
 =?us-ascii?Q?qZa6KH8vt83IsVJ3H0KWWEHY6p6QuL/CyrQ/oj2LDo+r6rPdDl8FESP5OBQ3?=
 =?us-ascii?Q?gk16kCDXvVbwxH795bRxzXlBGGp7ZtpXYYupG/Ak2iM9GTCU9+tQt+N2SBWN?=
 =?us-ascii?Q?i7KFufy5Pf/uPXRKA5aUTAh9NqOoA4/+kGQsDdq29O1IGUnsbSwmRQ61rk2x?=
 =?us-ascii?Q?b6k4eQA4+BR9+zYSZt8gGG/iJjusk4128KTgYVh/AJtaOzIFMDOWbdXeyG2s?=
 =?us-ascii?Q?bfE24ISnvuVFBG7kbqdMYzJpQlh/1ue9H/O7S+8vOVt9C0J1Pm+OjT4mKgCk?=
 =?us-ascii?Q?FS4xuwRuAZHFb3dBUgPssQMNnpOsArL5lUDyk6ERMJJyUHs0FfW/VnzESvDD?=
 =?us-ascii?Q?JTIe8n+QgJgoho4KsZVDXsDEUZCsjWjITeWTxr0YBc9VLnyWs1bk8X7DliHD?=
 =?us-ascii?Q?dw4SWtKxN0VoxaZWafItw2D9KH7AMHeMsFD0u8aBtHdACNJKy868c1nmOC2A?=
 =?us-ascii?Q?sIUbl9C+tjG5/WKL5gOny2jjg0/lsHeEC2bAfyYVszgMpiHdWYdObzCr2Mqm?=
 =?us-ascii?Q?hb3RKs3BNpm/mqcvCOE0dnuP45maL70KPOyX2zO3k75Am4NxnqMjLgxIQp2m?=
 =?us-ascii?Q?+bWw0SiZm6p9tLI6gQ5Bym7ypxPJP8AKAXwT/FZ4p/QnJ2IvaXpMMHxxO+Pi?=
 =?us-ascii?Q?MJxlK/zEXPwThIotV/miUA6Ab1uxLkenitPHHc3viL7LuIT7THagHQg6CezA?=
 =?us-ascii?Q?SfElxTW7hREb2TKwndOcMZJf0h1Cpx7AZDx9+mBYji2jBE9RCdbLt+O8oYzY?=
 =?us-ascii?Q?+GCvv2QkTbY+JsE6PDWRGKXBwiaEjeNIeD49Gv/6NRwgbkHibRurvIk8lo8N?=
 =?us-ascii?Q?IcLwOm9ecBMQ4Rpysf3Wn+B0sWMo/k9dt7JW+GL8HT6+2PNCSju0iZSg2isQ?=
 =?us-ascii?Q?kQWMGygrgPxfYsMnR2EZD32DxTIPjzY+0pckXTvsVbaGvJPzU1i6F5Wd9J9z?=
 =?us-ascii?Q?uW00o5jbZBzzA5FJyanymE241YEa4aNRmU/AZv3RQJZHPQBbh7568aAaltfd?=
 =?us-ascii?Q?4WVc27Ua7fY0nBqfCQ6+Xje05uO1S65ByMwcQw/zcYhUEZwh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: baba4929-b33c-4a73-e1d5-08deab45f8ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 08:03:34.6833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HXnVVvpy/dUDN3xF4KUrrcV++UzIwbjxN8Sc1Ng0t01YnZ57MrmuMgWsHvD1z+n7Nc+xRgvFogJb3p4DCmh9qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7957

There are some comments from Sashiko, and see my response inline.

> +static int netc_init_all_ports(struct netc_switch *priv)
> +{
> +	struct device *dev =3D priv->dev;
> +	struct netc_port *np;
> +	struct dsa_port *dp;
> +	int err;
> +
> +	priv->ports =3D devm_kcalloc(dev, priv->info->num_ports,
> +				   sizeof(struct netc_port *),
> +				   GFP_KERNEL);
> +	if (!priv->ports)
> +		return -ENOMEM;
> +
> +	/* Some DSA interfaces may set the port even it is disabled, such
> +	 * as .port_disable(), .port_stp_state_set() and so on. To avoid
> +	 * crash caused by accessing NULL port pointer, each port is
> +	 * allocated its own memory. Otherwise, we need to check whether
> +	 * the port pointer is NULL in these interfaces. The latter is
> +	 * difficult for us to cover.
> +	 */
> +	for (int i =3D 0; i < priv->info->num_ports; i++) {
> +		np =3D devm_kzalloc(dev, sizeof(*np), GFP_KERNEL);

These devm_* allocations are tied to the PCI device (dev), but happen in a
call chain invoked by the DSA setup() callback:
netc_setup()
  netc_init_all_ports()
    devm_kcalloc(...)
    devm_kzalloc(...)
    netc_port_create_mdio_bus()
      netc_port_create_emdio_bus()
        devm_mdiobus_alloc_size(...)
        devm_of_mdiobus_register(...)
Because the DSA setup() and teardown() callbacks can execute multiple times
over the device's lifetime (e.g., when the DSA conduit interface is unbound
and rebound), these devm_* allocations won't be freed during teardown().

Will this cause memory leaks and MDIO bus registration failures due to sysf=
s
collisions on subsequent setup() calls?

I checked the DSA core driver with Cody help, the .teardown() is only calle=
d
when .setup() fails or the switch device is removed. So .setup() and .teard=
own()
are not called multiple time over the switch's lifetime, this should be a f=
alse
positive.

[ ... ]
> +static int netc_switch_pci_init(struct pci_dev *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct netc_switch_regs *regs;
> +	struct netc_switch *priv;
> +	void __iomem *base;
> +	int err;
> +
> +	pcie_flr(pdev);

Will this pcie_flr() call wipe the PCI configuration space and BARs?

Since pcie_flr() is called without first saving and later restoring the sta=
te
with pci_save_state() and pci_restore_state(), the BARs might remain zeroed=
.
Could subsequent calls to pcim_iomap() and MMIO accesses then fail to decod=
e
at the hardware level, resulting in target aborts?

This is a false positive, the pcie_flr() is called when initializing the sw=
itch
to clear the configuration from U-boot or the last binding.



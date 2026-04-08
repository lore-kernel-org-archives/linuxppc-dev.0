Return-Path: <linuxppc-dev+bounces-19490-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486481073C85
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 09:45:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frJ8G3yKqz2yDk;
	Wed, 08 Apr 2026 19:45:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775641518;
	cv=pass; b=m91dzLFw18O2hgJgaKJXiBq0gH58frSzFikYb/zR2bxEyvQXy+yQuHL/13vL3t98x68qsIdAsvcIP0rla1ZiI4mIuDM6DLWNIGR9bocf4bps4iD04nI92xhs9HTjHxa0u5K5kXrhRIZcZDHz84TMbcaAlvtIFRYTKB7MPY0TDIerApRCgHjXh06I97baVoFuR/eUW5k0v9y9yBMF8WO26TXl4pMSuVIAWWEON3V1UlRaKv1XjjDBYkzKhV9JGZM/hwMEsELe8Ytdv5G7BP9BYMAzmx5x/ZcmvCq+KrZ8AOPftskCHXgM7Ux1jfAgPe1BqKaGWBspFaMzPvML8KetoQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775641518; c=relaxed/relaxed;
	bh=cqkMj/z9YLf1xcoPo8qRCjJAL0AYkEHiBoA0k21NQak=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UHk2mDzrypgXRdKbvLIFOlSyfMvMeN/YOxGPXJZqqv1I3TCkmd0+7wB91mbbQhmptTZKPQd2qRwehzt4edZOyEWu9XdMf5AEV+ss12OFYNXMGXehRgTeRtNmWYzSy08mHftR4xNFKUxJXz8QfGdqzN48WLMZ5H0Z0BIGKGbBglySVBf0pnasPt6IlNM0aVlUtqE86gLmS2e6dLxi7u2BVRdaPD+pHVs2v9tvqcIOMEwBBDtVDR1R8Y5CTgloE013HStJX4WHjHnFTc35Yr0UZ3RwdEO0I9ybbrlbDsyb0oNwPX0JDoPb2N/2XhyhLIpO33XElasqeq3DyfW0FiWh8w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=eSDclOdP; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=eSDclOdP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frJ8D5WVfz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 19:45:16 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBQcLHCvFtUN6WCiqY47uOkIesC5eP//HmYDexCNSc6ofZjdvUifTcsD4wkpc1vaw5aVTE4ZDlDzmVHIPBpuLPo57hcOPRjMIaGOHKd+ZjOATetXr87iW34CvNpqGNq619/mKkj293dnhr47X0XWv4MF0C0xW0fAEZyFZkgLgD0Vxoc6hOajOvPNCkMau++9gLSyva/OYn7en6UQtH7KF79hIvQH8uPXn3kF+z44XxepGbLD3N9stM9mSo73XUY9tSCdQw4p69hpf7RkwKnUvu1tjbkXdiFQAltOWcYbiws64Y3tb1JRx0A3XRilQxBmaF+UFwm0o3gTzlLeVuouhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqkMj/z9YLf1xcoPo8qRCjJAL0AYkEHiBoA0k21NQak=;
 b=Zk2a4LL4KGBUfYfPfiN7mfdu6ansT2aWGQbJoxSR38EVpj1a0Y7vb224Zwhk8gclJTJHrFSEzkudmMpsxR5ZzVYtoTasiSGHP0Az5kZe+IpiBGrYhLtYXXkL0OQ71TpmNes66kdKVNgV/dpRC7xi/K/2IJ1F3UM03dleuy33Ofad8NMSe15hWqxQrdmmruY8SvGQmygNkaTEp55DVZUZ0+ZMrVrDrKU/ul94baQqSDZbZT5P65Xecc2QbqL257qehEeurnciu83u4bq49BjicP7n5lOXhXYxtEP8wImgAuHYKXMpsACzTYc2+GrTon7QcJZdr1zz/OEOZIW5oIQVZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqkMj/z9YLf1xcoPo8qRCjJAL0AYkEHiBoA0k21NQak=;
 b=eSDclOdPWInOdvTuWF2UjUeEaoKP96fyWh1BBsi3QO+DV1pNKKLKQB8XAjSqHHEN8ieNmzpjhtjbtz/8qZ33y4sN0c8gzbnv5+jv3tO1N993C4Ml2sOZfk8WMyIhPf83WP6RMtiK6E+1pNf2e/HBy+IuP+Tpx2yqM0d+Rp5dCJ0xmBDTNvA9PCXiiFwwFbalW3QdGlObgs5nNUeeDWo9379/UHSv8IrcIu/yJXzxbp2IaQWJgXebSO+fOpgnwwbUcfm+C+9h5xVkgIgIKgWyuE/9ZoENHihvItbowgVPe7SwiEt5pk6YrPpE8C4ZmRV3cxIJVRdiFb6GCUHY/FKamg==
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by VI0PR04MB10592.eurprd04.prod.outlook.com (2603:10a6:800:266::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 09:44:44 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 09:44:44 +0000
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
Subject: RE: [PATCH v4 net-next 11/14] net: dsa: netc: add phylink MAC
 operations
Thread-Topic: [PATCH v4 net-next 11/14] net: dsa: netc: add phylink MAC
 operations
Thread-Index: AQHcwQGvQKsKh1G3FkuUy4SjctygFrXMjVAAgAhdnYA=
Date: Wed, 8 Apr 2026 09:44:44 +0000
Message-ID:
 <AM8PR04MB7284FECA252137F74F32EFFA885BA@AM8PR04MB7284.eurprd04.prod.outlook.com>
References: <20260331113025.1566878-12-wei.fang@nxp.com>
 <20260403011740.1795694-1-kuba@kernel.org>
In-Reply-To: <20260403011740.1795694-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR04MB7284:EE_|VI0PR04MB10592:EE_
x-ms-office365-filtering-correlation-id: c5c7be12-23e2-4413-8bee-08de95537719
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|18002099003|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info:
 OrkY3751x0BgL5hAYVjty9Cf1fNjsrig8gBJ9TiF/X7jayiG/BpmM6Y0XfXuuQuiJ18rriPxgBICjiLyWi52MvtwOfZhOnzqTi+tQPFecMUETpQZAmsFh76ho8a90GvlEkGY7aIXLIPDqCfNzNivoirZb0Hk7cR0QVSK0G6NFqo8nwPe4l86cLkFvu1lKlmidpjO8C56/QrIHs1YO4TX+EsQZCg9x6MleyZ8a8qiL0RBHaR36UJQuA/Ir0CHOv4gluKVg29HcXjjgW+Eg136zO9CUYfwlTKFMi0RsStVhZzOw1Yk1UQZJKkrdTtpDz3Z3fIr3TvVoE12B31cHHvO0PvIpcll9E+DrIL0AvoRavBEtn2E2NsneQo+gKNV/zJ4O7UhE/zQmX3SYhWblB4Oa9S8in//kOCZnv+MP+VLtY1EZwBHRWAmdrtN+ra/dm+fHGYWNB6/yHQnjGIQrbxgim9+U2CGi4k1H9YAUfG00/2zvJBegAJxnPy1+IPIAjdfHAX7/OJWNUhGwloAawsb38UOfj27Uk9hCT87pusau5nYewM5UnsAcq7TZkQpsksGZ5uYSGt7KxTiHU6crfcZSk49kKd/SEXacY+COydmg2Gox/8aGWXJJ3l8bDY3Ta6QKHY2OW3u7BkKMCCe+BB+U4dYEyLoKJoAfWysCY+5qLHXmMzUUEZXphZRP8xaCdmePEhfUX2UHGMAMB3GvKTGe+piqu2kqX7oGJsOrM7Hmo/GwKJCIBF3CZKhsOIoQxyhcCpX7PtfXkLFzq38eorVeUxL+m51KMxiNWrVVmWQn1I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(18002099003)(38070700021)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1NwDr/0TM5CWrC8MTXqCTEBhbS/ysrYjibcyTIizswG9DlZJ/m3yfOO7/603?=
 =?us-ascii?Q?uKHEaVn4znK3gJoByGz+zO39SQvV4A+QFaRQ2gMW7ycMHx+MqrDWNgR/8TYU?=
 =?us-ascii?Q?Rjglsg7ueHa57z5FKrf/zjP3FHGqLt1dInmWjhfnvocMNevSRCV0ZZAhoahe?=
 =?us-ascii?Q?a997+BJDFQqqaCWz6LqExbn1Hd7fiCTL2Rnlf13PZLpNnoOr6pdn2wnqfklJ?=
 =?us-ascii?Q?lO590Vzr2X5EJHpezT/OuuK7PBjyg3XEvlUasjfOuHL1WhycrMnKW0TXkr9I?=
 =?us-ascii?Q?xVrkdipqsIcyOcpKHBMH6X53f4SC+O4/zVAYBw7lxgwql9OhUcFoOsgwhX+s?=
 =?us-ascii?Q?J2l/WyTs0eTy/wQ2UP1QaSqTMuq25cEiQ8G7HR/goBhsAu4XOtFEy0OLH07I?=
 =?us-ascii?Q?SP7UrpS+rrV8lyG/uf6HgNpM/5fj3V1lncTGrcO39nJso8cijEgHo/ryPhGg?=
 =?us-ascii?Q?OT0JSZ6jGLf2U6xOhkVTvHKkZulLuxbzH6oAdzGLwWTHwD+4hwnVQGh619AN?=
 =?us-ascii?Q?xZp0Elg7jHEhI8cUEnfMYvIlFsc8EURNofLqZo2YCW9PNFlceTeHgPwRE7hx?=
 =?us-ascii?Q?gxpW2HQGjpD3JvACUifjJjThr3XFrxb2YDBJB4onU1a+4vY2LdLAIPw4F69p?=
 =?us-ascii?Q?zBSl/ZV5YdpA9GFUkKBlCIKNLGgyTTY/64TDV7lzZ3NQgGr4hOGY2v//jQeF?=
 =?us-ascii?Q?o3iEHvpI8UqA6unD0Dh5qKj7ukzzp6SABq6o5/xDmp+GdzC+NfhMLApP9PUG?=
 =?us-ascii?Q?crOvuVUZQkRkrNM65TTVG3WtBI6gFApqPSre9EOv9W4YlUlsw+cVmKF32igQ?=
 =?us-ascii?Q?vjKIhdt9NnSIH+kkOTSA2VDj1c7vnJo/Fj6Yhcoss8bUxPWpZtSH+BPIrWNp?=
 =?us-ascii?Q?bo1WluECA/qyOFmq6X6Q42zpMosBN4BufAdm8nxh7RnvtPzH66pdd5Z7DH33?=
 =?us-ascii?Q?QQ+X1HzvwYnvdywzgce+gNHHVpZAiSN5HpoytfQE4UirG/eHkT15fBySh1Jl?=
 =?us-ascii?Q?v7Ffb+/kJ3l7H/1P30adlMW05rkt+MufHj6xUihw5+phnlfMCzEC8BcVGeRt?=
 =?us-ascii?Q?v28TRcZCuS663zUqhXhOc9ltEjw+4CfDNZLzj5lLk7aQqWyTbF49Z6Nt7zoU?=
 =?us-ascii?Q?ivsGl0DkhGU2S3N+kkZAtJCXTTNrfqXvx0pp6td6kcjZUb7CCsvDKUQe1QJF?=
 =?us-ascii?Q?jpPMM1bLCGKMxwADouPEgHDBtcFO4r8dwEy8Ls51LMGpGhMzW6cirzDoLFzr?=
 =?us-ascii?Q?oAb9qEFt9edlm3QDZhvJyTPrA+xgfoPqwhibfoOtMtBU+97wIjezRrSCjGH1?=
 =?us-ascii?Q?K5urx5Kb0rghst6BnEs/6qWYd0y9qfiGXLBf1hea0s1d7U7bZgz7HEXGg7yw?=
 =?us-ascii?Q?YqvvUrDZ/GlGDxJKL0L8vks3zXtJotKsqvtvoK0G82SmyimjrBbXRP4m3/bl?=
 =?us-ascii?Q?QTeajVQ1fhZ1BmGoSOIFQiGkBxq5S+SJTQgP1C8OyB/wwckydLhUs/jRbLC+?=
 =?us-ascii?Q?MDB587Rmmdn1En2B+x4SU+ch7kDOU+swdEVktsjZtbbejrKk/revHtvH+nI9?=
 =?us-ascii?Q?lrCBu3vL7nVDExHADPguaPvEXB+Gcnoy1/NVz5UWQDY090CdWxHt79sNM8WR?=
 =?us-ascii?Q?GO888bPGfW9krLzPuW3MYEkmIXUpVSsHk6kycBJAv8I4ji5SZo+byejBiB7w?=
 =?us-ascii?Q?7R6BtHtaS6upnszodg5nz8l4lLDJ/IYUBk1kPsHzFTMFvEAS?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c7be12-23e2-4413-8bee-08de95537719
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 09:44:44.6101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hccfQUgPuG9+rYeHm4bAGxMGYeXS9/IJGMG0gZad8vnk5GcAKc+wIET8UV/ozDK510IJCL96XWc6Nv3X1BHo0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10592

> > +static void netc_port_mac_rx_enable(struct netc_port *np)
> > +{
> > +	netc_port_rmw(np, NETC_POR, PCR_RXDIS, 0);
> > +	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_RX_EN,
> > +			  PM_CMD_CFG_RX_EN);
> > +}
>=20
> Pseudo ports (like the CPU port) bypass PMAC register accesses during
> graceful stop via is_netc_pseudo_port(). Should there be a similar check
> here, and in netc_port_set_mac_mode(), to prevent accessing physical MAC
> registers on pseudo ports?

netc_mac_port_rmw() has checked whether the port is pseudo MAC. See
below.

static void netc_mac_port_rmw(struct netc_port *np, u32 reg,
			      u32 mask, u32 val)
{
	u32 old, new;

	if (is_netc_pseudo_port(np))
		return;

	[...]
}
>=20
> Additionally, when np->caps.pmac is true, netc_port_mac_rx_graceful_stop(=
)
> disables the preemption MAC via NETC_PM_CMD_CFG(1). Should this function
> re-enable it when bringing the link back up?

netc_mac_port_rmw() also set preemption MAC if the port supports preemtion.

static void netc_mac_port_rmw(struct netc_port *np, u32 reg,
			      u32 mask, u32 val)
{
	[...]
	if (np->caps.pmac)
		netc_port_wr(np, reg + NETC_PMAC_OFFSET, new);
}

>=20
> > +static void netc_port_wait_rx_empty(struct netc_port *np, int mac)
> > +{
> > +	u32 val;
> > +
> > +	if (read_poll_timeout(netc_port_rd, val, val & PM_IEVENT_RX_EMPTY,
> > +			      100, 10000, false, np, NETC_PM_IEVENT(mac)))
> > +		dev_warn(np->switch_priv->dev,
> > +			 "MAC %d of swp%d RX is not empty\n", mac,
> > +			 np->dp->index);
> > +}
>=20
> Is NETC_PM_IEVENT a sticky write-1-to-clear register? If the RX FIFO had
> previously emptied during normal operation, could this bit already be set=
,
> causing read_poll_timeout() to return immediately without waiting?

NETC_PM_IEVENT[RX_EMPTY] is a read only bit. It will be cleared
if Rx FIFO not empty or Rx packet receive in process. And it will be
set if Rx FIFO is empty and no Rx packet receive in process.

>=20
> > +static void netc_port_mac_rx_graceful_stop(struct netc_port *np)
> > +{
> > +	u32 val;
> > +
> > +	if (is_netc_pseudo_port(np))
> > +		goto check_rx_busy;
> > +
> > +	if (np->caps.pmac) {
> > +		netc_port_rmw(np, NETC_PM_CMD_CFG(1), PM_CMD_CFG_RX_EN,
> 0);
> > +		netc_port_wait_rx_empty(np, 1);
> > +	}
> > +
> > +	netc_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_RX_EN, 0);
> > +	netc_port_wait_rx_empty(np, 0);
> > +
> > +check_rx_busy:
> > +	if (read_poll_timeout(netc_port_rd, val, !(val & PSR_RX_BUSY),
> > +			      100, 10000, false, np, NETC_PSR))
> > +		dev_warn(np->switch_priv->dev, "swp%d RX is busy\n",
> > +			 np->dp->index);
> > +
> > +	netc_port_rmw(np, NETC_POR, PCR_RXDIS, PCR_RXDIS);
> > +}
>=20
> For pseudo ports, the code jumps directly to check_rx_busy and polls for
> PSR_RX_BUSY to clear. Since PCR_RXDIS is only set after the polling
> completes, will the RX pipeline continue accepting traffic and cause this
> poll to always timeout on an active link?

For the pseudo ports, no need to check the PSR_RX_BUSY bit, only need
to set PCR_RXDIS bit to discard RX packets. I will improve it.

>=20
> > +static void netc_mac_link_up(struct phylink_config *config,
> > +			     struct phy_device *phy, unsigned int mode,
> > +			     phy_interface_t interface, int speed,
> > +			     int duplex, bool tx_pause, bool rx_pause)
> > +{
> > +	struct dsa_port *dp =3D dsa_phylink_to_port(config);
> > +	struct netc_port *np;
> > +
> > +	np =3D NETC_PORT(dp->ds, dp->index);
> > +	netc_port_set_speed(np, speed);
> > +
> > +	if (phy_interface_mode_is_rgmii(interface))
> > +		netc_port_set_rgmii_mac(np, speed, duplex);
> > +
> > +	if (interface =3D=3D PHY_INTERFACE_MODE_RMII ||
> > +	    interface =3D=3D PHY_INTERFACE_MODE_REVMII ||
> > +	    interface =3D=3D PHY_INTERFACE_MODE_MII)
> > +		netc_port_set_rmii_mii_mac(np, speed, duplex);
> > +
> > +	netc_port_mac_rx_enable(np);
> > +}
>=20
> The callback imx94_switch_phylink_get_caps() advertises MAC_ASYM_PAUSE
> and
> MAC_SYM_PAUSE capabilities. Is it expected that tx_pause and rx_pause are
> ignored here? If flow control is implemented in a subsequent patch, shoul=
d
> the advertisement be deferred until then?

Okay, I will move the advertisement to the subsequent patch.



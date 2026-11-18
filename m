Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8093606A32A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 03:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=b8boaKYc
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTnFV42Zdz2xNC;
	Wed, 18 Nov 2026 14:31:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794972686;
	cv=pass; b=CI1JCSuACZXysdvK4t0Gqs7IhY6d79exK1WBX3RFdf6gq5Q4wUyhKdGy2GRh34fs5QaGOhnMiYnfAjdRwcV/mxggQcnWCf8jrm7qNS0Uyms9n1IBM19Adtlz3ywpXWB+R/rkV5ub7Smarulg8+f9c9tsNIr3mQhzQfZepHrjnO8EBm70T3m0UmgNQO1CCeFt+mtTHszJZUgx38L4lv4YvDdZ0K2vbd9VKlwv6kU7bPtZUhziJzNluzbSIi5w3l4jvKJxqmJVBygtVBVwGv8sPvaPDNHZsrj9KRP9gZ+RZlv94Gs6I7zk2mkuoNnZr9mBpDNi+o3V44WeTRIab8xx9Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794972686; c=relaxed/relaxed;
	bh=nZJRzdOnPGIPkVjQ+uy8BK/QKtGsCBJQJnVpvx9GCkc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UmNXX6c3B3eSYMbOw956jiqWLo98S/s7mEbJKv0hr0VUVm8GHX7IMg37xvoxP/bHhIMg/5UnQYxuIv8NYO1G45YRZlHCA6v3pqdIUr/9hgLWmlcgRVW3H8rHsTa4uAep8itgeCpcNBDwFBkar+rTqE9phhGJI8TElo9FfjNB2yJznO1Q6LcwNEgF9xphj8cdHpCVVQQP+daaE08qAB7huasts1QPpGySxVnjgZ8kojx7/CvQXj5surdIvyOL85A2X7AXNYvHhHKmhBUD+sa3WKzejWf01LC2Mw32duwdkQq5EaGLQqWvi1Lg/kyd7AaDAXTFIO6/AbCIIxugC/0uGA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=b8boaKYc; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=b8boaKYc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTnFT5SnFz2xLG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 14:31:24 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4vC1rTUtT0zjXdkqu4Q4g/igM8am2+neqMvRG14rqjkFpQ6pXCKgNCTFGlpRatkbUSVRXoaXz2kbsNRN27UFQXZ+H8ZI+UXlH0vCF7U3phd4DWVlenlBrvABq5XD1ZcyLqLXT+JU8SlVRr9CqfS3bURhHEvKoX6SGqBBM3SaVScY+Cu2NcymeE3tuG6rbyG94bitDZkGE0PnlYo1RMZAWTxyCQoOWqyMi9upXAVx/prKIIJBOH9aip92ipkW9yB1wR9xBSZA+8ivL3cRZpuAtF9xyUL395q/IFv7XVKxDB/joEsR44spUncHy+aR/Itcunbx6rY6waWXtiJxQPJ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZJRzdOnPGIPkVjQ+uy8BK/QKtGsCBJQJnVpvx9GCkc=;
 b=aNJC9r30FVrPCBiws8nXWca9dxpciOEXpOmoTJRAkcrVVp1WjeRJ24yIEw8enIQT8q0aAsUI1cSzE8QcgN7QaKWod9vGqIfEcHoiRi/+pyjXWyLZ4rOjhgqQH3wvTGrnvWrkFAsk/conbR9kFjpC6jUpvY6kh34VBzqgKNmdIFlNQUVam3aDKNwyLVIZRpVY/a5vDo3LKwvY7zcAO+Az23Z6YaI/NS8RQLejUWSvdTXdA5qAT5fQGMHlsQ61n7c95KefdanYqh/zwn7g4lD8Fg+c3kP6TkhGv+3IpQHfsYSMS7UmGwOBgO7ap/PWObwFAKWqaBWYwo8MllXBM7fvrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZJRzdOnPGIPkVjQ+uy8BK/QKtGsCBJQJnVpvx9GCkc=;
 b=b8boaKYceoyT51gWpjJ8L2x0e1nVpk2y3EtA0tEGhKRaeDF9Xp2VPpvpEQkr8j+blfTnxwDxT1bfoFtNXzMuHB+dIjpMWbkQwuMg7feJiurayvcX8Dbn9J/9cstsnToyHSI3K8C5Fg0G9LcC4aS0ImL7MNdGUuTf2MF4fvXoJlXJqAcP75aROVTdh74pxUZVVe5bB3tzLC+g/phuwIJenUtf3o5SHSYVaYEmSGKeroo1FK1e58VOFZb44YUYLbHOvAAEz+bmfE+qVhyiRiJpTO+WOC0UQ1dFtOP9S8jWqE5kmYY8l+2QnBrDTVXcyAvnD0aREvQpqgC+LLzQWxFQoQ==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by AM9PR04MB7507.eurprd04.prod.outlook.com (2603:10a6:20b:2d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 03:31:06 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%7]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 03:31:06 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>, "Wei Fang
 (OSS)" <wei.fang@oss.nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "linusw@kernel.org" <linusw@kernel.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v7 net-next 4/9] net: dsa: netc: tie setup resources and
 reset to DSA setup/teardown
Thread-Topic: [PATCH v7 net-next 4/9] net: dsa: netc: tie setup resources and
 reset to DSA setup/teardown
Thread-Index: AQHdcaUp7fm1sZNO3EeaP61F0EkNK7cuwWKAgAR0DPA=
Date: Wed, 18 Nov 2026 03:31:06 +0000
Message-ID:
 <AS4PR04MB933808275FD0FD2B966A4729887A2@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20261111062753.1397582-5-wei.fang@oss.nxp.com>
 <179472746345.2199510.13684304240938201686@kernel.org>
In-Reply-To: <179472746345.2199510.13684304240938201686@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|AM9PR04MB7507:EE_
x-ms-office365-filtering-correlation-id: d02138da-70e5-4f86-1988-08df45246129
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|23010399003|7416014|366016|22082099003|18002099003|261009223027099003|11063799006|5023799004|56012099006|4143699003|261102123227099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|261028144727099003|10067099003|38070700021;
x-microsoft-antispam-message-info:
 UEwRAFzKTHnJT9TAmyUAelaE0jedaUlBAVzASP3ptJRcNAAy9vfTG/xgXHEtdGRMSXh4h8ZPPznxhyOTia0r4DD7fZqTbRQ8fjy87btsMspw5raKsbd/vv5550ngmxRPVLkOye9UenqjQC5rpwvAANafyNlHpz30PqHRUHcGsWxeJ4QyNfnlEdu5GKmdY/cLrxoUunI5gIUnki9XQ0DmyiCDWieUqQ9HC5cq0I2m56jyPB5I1s31XsnHGDvoGBnaMILEntSn1esBrKl1hulEwjOO1R2EKoVZD24oIbcWyKklOTq/3FnwKDMmSuxcMItmfml+ROa02YfFL4IB8rL/Qoenw7dAwCWHEO3J+hzTSKG+ET2NBycjj/I3m01FlYooUm1z7+2jZtw+weJIlNsxL6S0LPHYUv7/9Uzvn9UAIB9iDCTPjb22pJk2iHRSzhWtODBoXXIv0GvYk06IJxRCzZpZ/ihFhcikKS4NOy4/X7T7SjfWcVN6aqzqXeuaB8DvCWd1wXH2yvUgnkOFQXUYMZ2n4hfXGkhn73jMww3ykeiUXhYqDqCqHLs1KWULKoWdQugE86bHWOW4OpV5ggr1BvcI9/voQW8V2jYceWG7w248vqjR/i5kAj334NtP3EnsFtcaIFgWr8hanpb5E77wyzaYgDsbedig4zKPpNoupxOgzuF2/P0nK71jWDTaipBEYGcV0gb5/+NKkS9KQ/1zpA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(23010399003)(7416014)(366016)(22082099003)(18002099003)(261009223027099003)(11063799006)(5023799004)(56012099006)(4143699003)(261102123227099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261028144727099003)(10067099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zYu4mUdjwNM9coHDBAxEcY6Z8fFuIo7aCf41BdxdqDbHUeSMVE0T9K57+P4J?=
 =?us-ascii?Q?yOEtXIWtRjZPSJKcHsz/ooJ8+dyZEPZpY1LTMtM5MdmNCIMV3xaBKP477AFX?=
 =?us-ascii?Q?A6Y2H5gPw128Q2pD5qy1hEfZg0ExbASL6KlAXM9nqBz/cIU82twf1HT5YybW?=
 =?us-ascii?Q?lz/ymZrzm1q16Af05ilhLEKaUxlTLV0WF4xRgLCUg9+piM5KEMgLaWI+tESj?=
 =?us-ascii?Q?5YM+Aum0SoTuX9bw1/yRGCYgqVKHQyotj13xKVAEuaxXlMZvL0OGOKC1i3gl?=
 =?us-ascii?Q?s+1jOewRCMyliA/TK3Mzrzac2d6cdR7tbxgC/fwgDfZ4+91wusmOY2zQJGt2?=
 =?us-ascii?Q?Chbbx52+Rj4erwjV8u7HqTl/W5DZsYxzGX5Xn76dH0qOkbE7HxDcrw4TDo6Y?=
 =?us-ascii?Q?JSgNt4cSSaWo+lKrZnpp+BH9vKbZ5drYGBBDb+RE/efZguM/iBd0iKjQnZs/?=
 =?us-ascii?Q?5NqhoQ0uxjusSnlxefLkF6cs1TK/jqw6tbF6dc/ynk0F7IlfrAoZrvjSlE5A?=
 =?us-ascii?Q?j6XRgY91ph15bXvwaI88BivY9LMKa9tbKUyKN9vXx3+nE+WCBCtYsxsV+ldv?=
 =?us-ascii?Q?D4CKN37xsgalgqL9pT7cWRLcIJRV6yLmadybNPqn+1farl+T0V5HNfNUSCV+?=
 =?us-ascii?Q?aGaAyZiOgy2jrayI6CWpM1AkUQz1DrkuBxrY9lfevBpVAJnDAjolG+sBa0Yi?=
 =?us-ascii?Q?Qm23aUtaIuZuL2ocXlI4vwOkSUFlklizbFPG+Updt+IcOl/ah5qmVN9e6a1i?=
 =?us-ascii?Q?M5COJnr4zHw9wi7Hn+KIODMipWtBuAXVJ0UrQU48oe0d8NRIqeEiaY+SMxdd?=
 =?us-ascii?Q?FKHDLx5g66dMg3hZELFEVTBER7yantC4usRKGkzCpEbeGX8l6+4PnxektnId?=
 =?us-ascii?Q?diM1M9TUJ2jK1aVrnEQVNrtnWYUHXgn3F0UwJMAPBrScvpTW/xidHxfZvapZ?=
 =?us-ascii?Q?nntD9sw8By9GdnvHCDBK/3MfLRJzFRe/wMnZZP1dlX4Jf2scK7psaY4tso0o?=
 =?us-ascii?Q?onX624yV4VTBenOY91fiuNCqUKXprkT2eBP1ZbIJUSE4ddTTDh01vntyxpfL?=
 =?us-ascii?Q?FCJQ4sB3+5jMhzJPCawAoQwqjPtYZn7wq3nnAWmTMK2Mu6Eujbq0fyjlgeye?=
 =?us-ascii?Q?vhqQo1ZsZmFO9TPyz0XGmgQYqqpjn9B21s6pB3ismB9i95HGV4pBpVsx7qMi?=
 =?us-ascii?Q?aTJyTLPImsCH5So+pskIexHXfAIYPTBjhZ0tsh0Pk4ahARH1QN+S2bCEx5t9?=
 =?us-ascii?Q?hSKjVyzjZ+hQBn2XecRqSqMNukgxiZRCcCadcp/wWs56SjvZZjGIrI8iMeCq?=
 =?us-ascii?Q?K6mxKnoF5OuG+X7UqJnlb+JpB5a8G4ubj2qQW/c3KZvyVvgCk5sU2BcERqJk?=
 =?us-ascii?Q?e2p85Bvdc8PoRLz01XKdAtofi5uuVnonu0F5qwirRNc6xvz3EoqGlu/AzIlt?=
 =?us-ascii?Q?J5sTZPGQEBPX8xNDoiSUdpS+3pJXBAMJoxu35ieYj19qwOdhgnLQtrLchtMt?=
 =?us-ascii?Q?xij8vqofSkJQ55gzTc+/Ps8QVbJgX/TFNG7piM2EziYQ0wqim72fIoNMuDTx?=
 =?us-ascii?Q?Teu7Q6AGj1C1UmUJurefQU6Hm3tb6mxqPCojoSozADZm/vKasDUWPdlx2WNf?=
 =?us-ascii?Q?WJNuhHvHEXkBntLZ1QgO8IKKjhecszA0nt13p0Vj4uW+3c2u2MhFFtlrc5S3?=
 =?us-ascii?Q?w6UT5liygUG4lNTmg3Q4Xz4uxjFuGoDAlQvKzRa1UJz5cDKV?=
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9338.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02138da-70e5-4f86-1988-08df45246129
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 03:31:06.0469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ldZ0BrUejbE/NleOi7vFPgcJLfuWZhAu3OCxRu/lnd7/y5zpLqJHCvh3LUfJ/ib8IxFTCEIMMYICwI9v6JjIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7507
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> > +static int netc_switch_reset(struct netc_switch *priv)
> > +{
> > +	struct pci_dev *pdev =3D priv->pdev;
> > +	int err;
> > +
> > +	if (!priv->configured) {
> > +		/* The hardware will be configured after netc_switch_reset()
> > +		 * is called, so set priv->configured to true.
> > +		 */
> > +		priv->configured =3D true;
> > +		return 0;
> > +	}
>=20
> [Severity: Medium]
> Can the first netc_setup() start on stale hardware tables if the FLR in
> probe failed?
>=20
> The commit message says:
>=20
>     The probe path already performs a FLR in netc_switch_pci_init(), so
>     the first setup will skip the reset because the priv->configured flag
>     is not set.
>=20
> But netc_switch_pci_init() ignores the pcie_flr() return value:
>=20
> drivers/net/dsa/netc/netc_main.c:netc_switch_pci_init() {
>     ...
> 	pcie_flr(pdev);
> 	err =3D pcim_enable_device(pdev);
>     ...
> }
>=20
> pcie_flr() can fail. It returns -ENOTTY if config space is not
> accessible or if pci_dev_wait() times out. It can also fail through
> pci_dev_reset_iommu_prepare() for an ATS-capable device behind an
> IOMMU.
>=20
> Suppose that happens after an unbind/rebind:
>=20
> netc_switch_probe()
>   netc_switch_pci_init()
>     pcie_flr()            <- fails, error ignored
>   dsa_register_switch()
>     netc_setup()
>       netc_switch_reset() <- returns 0 early, !priv->configured
>=20
> The FDB, VLAN filter, IPFT, BPT and ETT entries from the previous binding
> would then stay in hardware. netc_setup() builds empty software state on
> top of them, and the driver has no record of those entries to remove.
>=20
> Later setups treat an FLR failure as fatal, so a failed first FLR is
> handled differently. Should the probe path check the pcie_flr() result
> and fail probe? Alternatively, priv->configured could be set only after
> a successful FLR, so that the first setup retries the reset.

I think this is a false positive, or it is a theoretical issue. For NETC sw=
itch,
it supports FLR, and the FLR time is hardwired 32.768us. If a time out
occurs in FLR, that should be a hardware issue.




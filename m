Return-Path: <linuxppc-dev+bounces-27913-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4D5C982FA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 10:35:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpxLq43M2z2yQJ;
	Tue, 22 Sep 2026 20:35:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790073315;
	cv=pass; b=TpjqC8fWo6aRhka4jOgVDUAo2SwjBTcQHcBqMGR+NlMwrIHjRyTlGew8s+dd1Va+9Oz7Vgn6LzeWdhpWecmaPA36msqqGmIUQ9o7yM8Tz0DXXF9QNGHAU3ph7YuylTvnvsvfKlR7fJa68JbBrkl3v9DHtkuEXf7NH9zM3M5qUbWh87J7vMf1R0koe7Tr9exBX01eVEcQeI41zL1hjnETkuZxwDFDO0XdixRw+B+N0KYqXoeUiqwjeobI8D6uJAu0++9LbEzeQrn/L1uMvffhLfP6NYhGa3wkXczsHZskUivy9mGyHpwzx/3Kbo49pa+CVIr+UZula1v+CJP8PxVyFg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790073315; c=relaxed/relaxed;
	bh=a8tNNnkZ/m1cx3dyVgQ2tecPL9EX8kBmQqkLFAkQtFM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K/JVUkPEdPGmGpzbJnKUhjc1S5xs4lYqBvwwD9/MAsZZYu66Lf9n2xh7U5S1IpnU7nbGMGFpmTwyfQCv+AvzInSWlkWcLXDALbwabnBZmyr/qdIvuJ6LbDwSOZ+SWDnt19ewwC9dxi0ZP4yAv9jhHHBVhlxTw309SdjzkaOqJVYopulLRJJvlyCpTSLNhxUq53SphebXzyI1Klx5yxIg4f+8/SsApkp8SgldmygMRQszdA106tTVJIS7CgAuO6cZWAue/BCsWi72cy62rF8hy+CXefge6o38r6YuxJWTuGK4xIwR6Sc4K6ESN4G3WqrhmZQB7nsD0lt7WZBWZ7nIkA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=QgWmjR4c; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=QgWmjR4c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpxLp1jlpz2yFK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 20:35:13 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMxq6rOAfCAilMqn06rlKmQFxm0C16VVNnFzwwrL6yKi2a0t0P8gmF+RAbeBPjkM2SgN+yqonGxHrnnVjaXpTCthV3GzimPDLraRkbnVkgDslJpuDizSgv0adl72KMX0HQzxWp5IbL/o7oKhdhJw8sZgYz/I6Vm1LEqbtEjDYi06C0K+QOkjK/qyFf93gcKdvFfCOu+wNpJvDu5Kw4GTeLhNV8HpdWtEI54w/eV4R9s9Pd6ktxI1z1Gg5NsUSXRGU8xMKIv/NgkD27icKUuJ4VLwQFfDCO6nHxyF7zorKlvAcVKiFIRiP+MhjZUOYdmNikQjKqrYb/XzIND/fTp03w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8tNNnkZ/m1cx3dyVgQ2tecPL9EX8kBmQqkLFAkQtFM=;
 b=luzKoPCXW09y6CRIMn9rv+BW0lHVRqzjKulN7aXcoNlVNC2FHj7IqKqTwWNu/k7GvvHcTNvBN4TXDEy1V2dh9zNj+5qpuBC8YyDQdaabqEzBzDQB0s5SAd/rvLuiwtn8oyrg/esN2DkSIddf8f13VzAaurktBOl8DdEypSc5N9Zw+Wn//y1ep/xMFkiMnAepQrqxNu0cyumVk6h8qdsEr2D4rMHXRfMnx4kId9ZmXrJqLruWAngi5D/gESF0LBLMt2WkePIHARCciRcU4f4Oq343slw8CbclPtysF4KOeUWuBX69GRFtMiNdYkgET00UMnvwM9W3ZT2TO3KY4GyCcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8tNNnkZ/m1cx3dyVgQ2tecPL9EX8kBmQqkLFAkQtFM=;
 b=QgWmjR4cu9tFsGDp3HmMhshHWtidD5KVu1WAajqJ+WvO0WOHmMUDdfJJk5ybhYslyxeZqmwV0CGWp9pOpq99NcBE+ixp6HZHTePAf27Sd2JV2RT5fyrmyl+mhG+KLSm1XAPANDRS5sFBZ3luzv9XNvUKKF12fxYZwQDNC1+Gawg6ZlLtwd26cLPycBesxmfpOCHylwNM2oB801BfCZsx/cJhcPZSS/iQ/js480EwSWA+kzieETAXgVJpulW862q0h1JvKOSC0z3uLaFk0xXqKaURfiEQkWpQuO+GIc/LSW6Mnc0/jw/CMeSHZUuHGKorh3xhuOj88fhUTEg9Vni7Dw==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by VI1PR04MB7197.eurprd04.prod.outlook.com (2603:10a6:800:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 10:34:49 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%6]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 10:34:49 +0000
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
Subject: RE: [PATCH v4 net-next 5/8] net: dsa: netc: check return value of
 ntmp_ipft_delete_entry()
Thread-Topic: [PATCH v4 net-next 5/8] net: dsa: netc: check return value of
 ntmp_ipft_delete_entry()
Thread-Index: AQHdRz7atl5Aa7Z4IEGFbkUNOuNk1LbaSXwAgAAcwWA=
Date: Tue, 22 Sep 2026 10:34:49 +0000
Message-ID:
 <AS4PR04MB93384B139F7957A2755DB00E88832@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20260918072852.501420-6-wei.fang@oss.nxp.com>
 <179006555627.2160803.12045711758819504557@kernel.org>
In-Reply-To: <179006555627.2160803.12045711758819504557@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|VI1PR04MB7197:EE_
x-ms-office365-filtering-correlation-id: 9d605d4d-89dc-468d-0a17-08df189520f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|23010399003|376014|7416014|366016|38070700021|6133799003|10067099003|5023799004|11063799006|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 Gz7C88pVMcXYaM/zAKNl056R3XfN+RGsUarto8IXYJ4LZAfw28/jxXMnu2mUk2+qpHLDki3MMqZU6Lb5ebf7L7Ca8Yh1/PAwZtIRiK8u4nYH/9i3fPxeAMwXcG6KIzl9CYtndaZtrDiNbn4YVxOy4KciYhTSSy+lusycIWGE/hiMDUt0htV+aPJ14CkNUXK3ay7J2Wktq3nP9tVJdwwF6kK/v6XW5VJSuRmSSxHUurPNPlIx7C1y5rVB3lnizkmXrze6KAkLB0rxYSbbatnq4aCri+18KBWhKQCoht/5Pguni9OFyvE048gTFnjN7/pB1ocB7TQu1YZmE1ULhsrVsJVgWKLrRlE0z0BnbwCcjiBxnJV4nCfVoaLcTZ7PbMoXH0hHqah8t4w+WVgr2WqzjFepSFdy4a5L6J/UV5F+IMZJEP/UfiMu9q/tVV1bxom6rNhLguvQgqOMhH6C6m00pzVGKRBVO/f/cqgO0BvAQ6ApfffAM1L+tXUrJavjLsTTFCg9S6bJkNMV5JW54nWZZjEPGXI6/fvQ8fXFE9POACNWhF1NABb7LyKqz1CsMagL+kdycjZP9nbyr2J/C9TLLhJToZrXHFv76B2C4N1IxNcODJIwKFdoF5szMlmGg/OpyWzD865dzPuYw0jHhGGX9AFwh4g4UvSBDlEtEbNclN0N0LmUscWvpA0HMikunkVh8X1GMk0UHfONI61AdwMhugcq5Wn+HipFWK/Kx8GTUhs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(7416014)(366016)(38070700021)(6133799003)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SvrnGP9UVzP1i96E5qxRqLG8eXiIikQWEGJ/YRVYznVmiwRIMVkkCdVnrGYp?=
 =?us-ascii?Q?f1JIT2baVB2+m+IF5bVumaFZd8YFKabO3wKAZ0hsdrYTiMIyZ4TW0shHH58G?=
 =?us-ascii?Q?YE6eHRMw9Thf28qqjr7cwmTJHM80/kWwGp8k3DSQRdKfkl+m8tM/FXGt0ni1?=
 =?us-ascii?Q?RjWmPQzv7Bp2yyAhAMbnjZe6+ZwWM6xK1wpup0iWs9WjVOtcN85yZc9iIXls?=
 =?us-ascii?Q?Aas3MXFaQy9mJX9Nn/mCyAo39u+8uSCPZBeSexV3vrudxRz1rl0kQ4S4/H65?=
 =?us-ascii?Q?szltgK5yWc4/384YybdFLrLKkc0j3bBy1J/CWkHcDNTqFH3VONCusn4kJzRn?=
 =?us-ascii?Q?n+YKe3azNz2kdaVXw2LjodI9058bXKD6C+oeFL0/bG4FFsDKluBjWv7Ix6hd?=
 =?us-ascii?Q?odH4qGwICAvShjzcl4TTaRAHPIBcvtACtzd/e6pn9jkdQzYHTX51zKOWWGfz?=
 =?us-ascii?Q?DOL2yVKdLCW3o6nQnvZ67SwjTFdVFiOCiCcgsrH8lJO+aDEXpuwM4gbLHns3?=
 =?us-ascii?Q?5qwIbbgW/YDItD/fTILGsbluS+/3C/G3QrtuLGxCg+qncLRlYc1+Gau9WH1c?=
 =?us-ascii?Q?KDEAYH0wRcYG6+CXHNaaI9ssG4PuVoEYRJ+mSfP/jtC1Fp0Q9v/6c/vkzb5c?=
 =?us-ascii?Q?NTilnyY2PSSNY8YFfwADnvfGVSoPaEpwuXm/S16UU5wEmhoVPgSwNNzKUStj?=
 =?us-ascii?Q?yqcTtOgtL7BU4HFtzfoAFusYoHy+BjhrVXhu/LlNewXq86XYeAYkSe7hinbq?=
 =?us-ascii?Q?eXhQVI+ih9i+yIJVjGJazYpEoKFh7Y05dlBC/aDCTOgEQ0e9/WTcUAk5F+oN?=
 =?us-ascii?Q?Q3IRx0wgnUV7G2PKaPurVIjvvi7ZAjARn9FBGXlSqbVt8JebBVfl6HH2vXE2?=
 =?us-ascii?Q?VD7Rx4JBfppiX9uZt444zHQpyQytYcrm8d36Iz8Z7Nkk6RZZQj/Oqcoa96rN?=
 =?us-ascii?Q?7R3jj6vsXzMgBFgXkhBwbAoxd68uG0z8NQ+9g0MhG9i7FznhkNocHn38CXvo?=
 =?us-ascii?Q?d7h7q1PcIzFtxnILd4uinjiVGgupW7WeP1SzmXfsD3YZUJZk/DGn2DmFllgx?=
 =?us-ascii?Q?3IkOdaBzN8mBXo2cwqfSVHd5YioXLW+3lsC98dfhwJSVFvYTptr0avosXKs6?=
 =?us-ascii?Q?dpv90Q9RPouxJa3fvkFLbUU8T1NwuE+tAUht5ABcHCNrX4l1afGE2DkJSz1h?=
 =?us-ascii?Q?w5OkZzSGKt8FnDAN1dxk8qXnwCBArSC2DKbcHUgKJ+m/by71LP3O/WHj9Rda?=
 =?us-ascii?Q?6/Sq5e+SN6Tnldytu4DWxXKRh+fT7vk5HkMhFJ08ld6wE+RpfW+l0NJYZlsC?=
 =?us-ascii?Q?78fHNk4sS391tH1kx7q/0ac6S6K3bjns+prw9hN8s/MVW3ElR2qb/o4k8ZsP?=
 =?us-ascii?Q?oKyRAfcsOkrckWYSUrJBkDMn8VMM4reb9tYZoMWDI+aIzTRMJ+JVjBeb+jfR?=
 =?us-ascii?Q?c2KFxuqAlF4AONriUDdAf8tqeQrEfqiCMSJWydhfwr5716P1EBkEVzJ9j0wd?=
 =?us-ascii?Q?E1FlH49ECwwcBYRG1wUBj6MS18wvlRsXaHHdJHsLIpV1dwxwAoax4gT6vX/c?=
 =?us-ascii?Q?naKx47J8ArX2u34cBDR0/Hg7DigTL6fDcW3b1LVybHhcSxftAKURoYb+XHym?=
 =?us-ascii?Q?pE/tDNIsNrV3jc5kLDyEMtUxl/3q52mJxlyXZw1I4nZbaLJNw3uYcjTHSFfn?=
 =?us-ascii?Q?jIBaMWbNQHQFRvEAXHoQWnf5NPMgidpLc3SySdWcrOiVAd1M?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9338.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d605d4d-89dc-468d-0a17-08df189520f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 10:34:49.1846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8MQytAxI0BLZN5iyyYYNdoYOfV/0U+sbhmSMKBCvoFky0Vn3DG/XSbZVV+B5Q9ha0wWgCxaPj8+bQVOGIVZMSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7197

> > ntmp_ipft_delete_entry() may fail, but the driver ignored its return
> > value, so a failed deletion left the IPFT entry untracked and
> > impossible to clean up later. This is harmless today because the port
> > also disables its ingress port filter table lookup, so the leftover
> > entry is never matched.
>=20
> [Severity: Medium]
> Is the "harmless today" statement accurate for the replacement path that
> this patch reorders?

The harmless meaning here is that when host flooding is disabled, even if
hardware entries are not deleted, the flooding rules that have not been
deleted will not take effect because IPFT lookup is disabled. I will improv=
e
the commit message to make it clear.

>=20
> In the pre-patch netc_port_set_host_flood(), the new rule was added
> first, which sets np->ipft_hf_eid to the new entry ID and writes
> NETC_PIPFCR =3D PIPFCR_EN, and only afterwards was the old ID deleted:
>=20
> 	old_entry_id =3D np->ipft_hf_eid;
>=20
> 	if (netc_port_add_host_flood_rule(np, uc, mc)) {
> 	...
> 	/* Remove the old host flood entry */
> 	netc_port_remove_host_flood(np, old_entry_id);
>=20
> The old helper only disabled the lookup when the deleted ID matched the
> tracked one:
>=20
> 	if (np->ipft_hf_eid =3D=3D entry_id)
> 		disable_host_flood =3D true;
>=20
> Since np->ipft_hf_eid had already been updated to the new entry, that
> condition was false here, so NETC_PIPFCR =3D 0 was never written.  Doesn'=
t
> that mean a failed delete left an active, untracked IPFT redirect entry
> with the lookup still enabled, rather than an entry that "is never
> matched"?
>=20
> For the promisc to allmulti-only transition (uc=3D1,mc=3D1 to uc=3D0,mc=
=3D1) the
> stale entry has an empty DMAC mask, so it matches every frame from that
> source port and redirects it to the host.  Would the port then stay
> effectively promiscuous after userspace disabled promiscuous mode, with
> the ternary IPFT entry leaked permanently because its ID is no longer
> recorded anywhere?
>=20
> The delete can fail in practice: ntmp_ipft_delete_entry() ->
> ntmp_delete_entry_by_id() -> ntmp_alloc_data_mem() can return -ENOMEM
> from dma_alloc_coherent(GFP_KERNEL), and netc_xmit_ntmp_cmd() can
> return
> -EBUSY, -ETIMEDOUT (read_poll_timeout() on cbdr->regs.cir) or -EIO.
>=20
> Could the changelog be updated to describe the actual impact?
>=20
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
>=20
> [Severity: Low]
> Should this carry a Fixes: tag?  The ignored return value together with
> the add-before-delete ordering came in with commit
> 46d6407692c80b258ecba3af831130a6f6e2feea ("net: dsa: netc: add FDB,
> STP, MTU, port setup and host flooding support"), which is already in
> the tree, and the effect described above (a port keeping a redirect the
> current RX flags no longer request, plus a leaked TCAM entry) is user
> visible.

This is only a theoretical issue; we haven't encountered this problem in
practice. I think it's acceptable as an improvement rather than a bug fix.

>=20
> > diff --git a/drivers/net/dsa/netc/netc_main.c
> b/drivers/net/dsa/netc/netc_main.c
> > index c590931a4e1b..082ed9405868 100644
> > --- a/drivers/net/dsa/netc/netc_main.c
> > +++ b/drivers/net/dsa/netc/netc_main.c
>=20
> [ ... ]
>=20
> > @@ -1761,32 +1755,31 @@ static int netc_port_add_host_flood_rule(struct
> netc_port *np,
> >  	return err;
> >  }
> >
> > -static void netc_port_remove_host_flood(struct netc_port *np, u32 entr=
y_id)
> > +static int netc_port_remove_host_flood(struct netc_port *np)
> >  {
> >  	struct netc_switch *priv =3D np->switch_priv;
> > -	bool disable_host_flood =3D false;
> > +	u32 entry_id =3D np->ipft_hf_eid;
> > +	int err;
> >
> >  	if (entry_id =3D=3D NTMP_NULL_ENTRY_ID)
> > -		return;
> > +		return 0;
> >
> > -	if (np->ipft_hf_eid =3D=3D entry_id)
> > -		disable_host_flood =3D true;
> > +	err =3D ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
> > +	if (err)
> > +		return err;
> >
> > -	ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
> > +	np->ipft_hf_eid =3D NTMP_NULL_ENTRY_ID;
> > +	np->uc =3D false;
> > +	np->mc =3D false;
> > +	netc_port_wr(np, NETC_PIPFCR, 0);
>=20
> [ ... ]
>=20
> > @@ -1803,19 +1801,24 @@ static void netc_port_set_host_flood(struct
> dsa_switch *ds, int port,
> >  		return;
> >
> >  	/* IPFT does not support in-place updates to the KEYE element,
> > -	 * we need to add a new entry and then delete the old one. So
> > -	 * save the old entry ID first.
> > +	 * we need to delete the old one and then add the new rule. If
> > +	 * the deletion fails, return immediately.
> >  	 */
> > -	old_entry_id =3D np->ipft_hf_eid;
> > -
> > -	if (netc_port_add_host_flood_rule(np, uc, mc)) {
> > -		dev_err(ds->dev, "Failed to add host flood rule on port %d\n",
> > +	if (netc_port_remove_host_flood(np)) {
> > +		dev_err(ds->dev,
> > +			"Failed to delete old host flood rule on port %d\n",
> >  			port);
> > +
> >  		return;
> >  	}
> >
> > -	/* Remove the old host flood entry */
> > -	netc_port_remove_host_flood(np, old_entry_id);
> > +	/* Restoring the previous configuration is pointless because
> > +	 * .port_set_host_flood() returns void, so the upper layer cannot
> > +	 * detect the error and the RX flags have changed.
> > +	 */
> > +	if (netc_port_add_host_flood_rule(np, uc, mc))
> > +		dev_err(ds->dev,
> > +			"Failed to add host flood rule on port %d\n", port);
>=20
> [Severity: Medium]
> With the new ordering, what happens to host flooding when the add fails?
>=20
> netc_port_remove_host_flood() has already deleted the entry and cleared
> the tracked state:
>=20
> 	np->ipft_hf_eid =3D NTMP_NULL_ENTRY_ID;
> 	np->uc =3D false;
> 	np->mc =3D false;
> 	netc_port_wr(np, NETC_PIPFCR, 0);
>=20
> netc_port_add_host_flood_rule() can then fail on kzalloc_obj() returning
> NULL, or on ntmp_ipft_add_entry() returning -ENOMEM/-EBUSY/-ETIMEDOUT/
> -EIO from the command BD transaction.  In that case the port ends up
> with no host flood entry at all while the netdev still has IFF_PROMISC
> or IFF_ALLMULTI set, and only a dev_err() is emitted.
>=20
> Before this change the add ran first, so an add failure left the
> previous working rule installed and np->uc/np->mc untouched.
>=20
> Since .port_set_host_flood() is void and is only reached from
> dsa_user_change_rx_flags() -> dsa_user_manage_host_flood(), nothing
> reports or retries the failure.  Does host unicast/multicast flooding
> for that port then stay silently off until userspace toggles the RX
> flags again?
>=20
> The comment says restoring the previous configuration is pointless.  For
> the common promisc to allmulti transition the old rule is a superset of
> what is now requested, so wouldn't keeping it still satisfy the new
> request and be better than delivering nothing?

The failure mode you describe is real, but it's a deliberate trade-off:

IPFT does not support in-place updates to the KEYE element, so the old
entry must be deleted before the new one is added. Keeping the "add-first,
delete-later" order would force each port to track two or more host flood
rules when the old deletion fails, which this patch intentionally moves awa=
y
from - especially since IPFT will soon serve other features (PTP trapping,
flow policing) where disabling the port's whole lookup is no longer accepta=
ble.

The impact is bounded. An add failure only happens under memory pressure
or a command-BD error (rare), and the effect is that the port's host floodi=
ng is
temporarily off until userspace toggles the RX flags again - a recoverable
functional degradation, not a memory-safety issue.

>=20
> [Severity: Low]
> Separately, is the window with no rule installed a concern even when
> both operations succeed?  Between the delete and the add the port has no
> host flood redirect, and the gap covers a full synchronous NTMP command
> BD transaction for the delete (dma_alloc_coherent(GFP_KERNEL) plus
> netc_xmit_ntmp_cmd() polling through read_poll_timeout()), a
> kzalloc_obj() that may enter direct reclaim, and a second command BD
> transaction for the add, which only re-arms the redirect at the end:
>=20
> 	err =3D ntmp_ipft_add_entry(&priv->ntmp, host_flood);
> 	if (err)
> 		goto free_host_flood;
> 	...
> 	/* Enable ingress port filter table lookup */
> 	netc_port_wr(np, NETC_PIPFCR, PIPFCR_EN);
>=20
> During that interval, frames that only reach the CPU through the host
> flood redirect (multicast under IFF_ALLMULTI when going from
> (uc=3D0,mc=3D1) to (uc=3D1,mc=3D1), or unknown-DA unicast under IFF_PROMI=
SC)
> are dropped.  The old add-then-delete ordering kept a matching entry
> armed at every instant.

Yes, the window is real, but I suppose it is acceptable when switching the
configuration. As stated above, the "delete-first, add-later" order is a
trade-off. Otherwise, each port may need to track two or more host flood
rules when the old deletion fails.

>=20
> [ ... ]
>=20
> > @@ -2015,6 +2024,11 @@ static int netc_port_bridge_join(struct
> dsa_switch *ds, int port,
> >  disable_mlo:
> >  	netc_port_set_mlo(np, MLO_DISABLE);
> >
> > +	if (netc_port_add_host_flood_rule(np, uc, mc))
> > +		dev_err(ds->dev,
> > +			"Failed to restore host flood rule on port %u\n",
> > +			port);
>=20
> [Severity: Low]
> This isn't a bug, but port is declared int by the .port_bridge_join
> prototype, and the two other messages added by this patch use %d for
> the same value ("Failed to delete old host flood rule on port %d" and
> "Failed to add host flood rule on port %d").  Should this one use %d as
> well?

Yes, this should be improved.



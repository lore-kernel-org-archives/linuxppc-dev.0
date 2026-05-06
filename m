Return-Path: <linuxppc-dev+bounces-20508-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC280CD342C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 08:28:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9T6H3kcKz2xdh;
	Wed, 06 May 2026 18:28:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778056087;
	cv=pass; b=emJ9QS2CWBgGB77Ezb98hIh/kfbIyHAVMpZKIci8GnV5el9X8UKecKUgrf30srgiZ548Xt1nUBOXH3yxNOKAv73BcDaT94Zas9QEysWDcqzu0vfteiAfvHCSr9Ot4dRf+SylRs02SpXInF/dRWACHz7uhDuZ0Nm7dX+oLNI8o1cw8OusDFMnh0v9HsUY2BIUFgN4O2ZOXt9uqCgXI64ORyJmHLNFa8rSSCMcJTjJEmQMcfuuls7k3ePNI+KlMofXBGVDzqZMIh0p0qCGk1D1rCvgOqQlKkUoFEtBrPXpR6VzihkGcSt7lx4hE3lH4ZlR0U4skKapvmmTZ5WmfWhNvw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778056087; c=relaxed/relaxed;
	bh=lOMP63VHRv6ZXzoIXW/OiUDw8YNfv9JOn3IVHrNuTBE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bg4vLDDg0k4C+2rqWXffMKC7GGJ0zKB7iuFDGnKzdyq4OlhQRUS2Qk1yz1ZtPeJ+N3x58mKrEs0TmNX/dKqN7/dYVxtAdzah/pl0gonAdSRuy1GdDMVO/gF1+svZ9arIQpreYyU7oywCVnZTROFebxDDJMm1ax1PLPMBo5TqAR/nrW8wjrEgUjc6ILwzoJm4FlHqaoG7HYJg8ohMepPfSjv6afdBt0NbJgtoSSl6iVfbS5hk1Or9C5qlxCaSIJSntLXO0LCjSZlL8CcgGY/JRse38ZfWcVs8S15hT1EXaMjGhJYORvabsugc0LC+dtY8oZWq8995kSF01i1aeG+XDw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; dkim=pass (2048-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=selector1 header.b=XTJdgneD; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org) smtp.mailfrom=hitachienergy.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=selector1 header.b=XTJdgneD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=hitachienergy.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9T6F5nn6z2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 18:28:05 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5mlJon9QcToTttmbn5qFLzx5Y7r0xWSm9JnawdEM2s8+HWD5D1onuC1O7UdF+nqwq6UeW4+jeASyF+u3ZAYDbBa+kukJPIlD/BNd0Q5WXV7iEsGZaJPbj3MuQvmZ4Kt7Yl8SzErTIs5O9YqU2f78/JMvinS5kyIT6oHmkSau+Be3c6z8PzqrwE4Cux0Nf9bvWlZWFuCn6UPNZMM1b6lL9DV5Hq5iJKtoS2bbM1MRbTvnk94bnXJKVFX8p/DY1xrok/5IDp6avMelAkdx7uIUIOGnWa/DXoPQ88LBfzY8pHlcPaVp00iaquApedLcX4hrZ0WDDx8goK3nJXam8g1ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOMP63VHRv6ZXzoIXW/OiUDw8YNfv9JOn3IVHrNuTBE=;
 b=e1OBZ7RjuJAHkJaSVWn5xDyAekY90oZCoLMJN6VrYjuZp12JAu7qao7eLTwrUA4cpf3T0CkDtegcNGAFN9VYFuV2y3RMCL4carLAAD8lVF8EabnYNJPoR0ACJmaeKc061l/C2A83DxfkqEqvFO+l8R29JrZtHgdZ+WN2tyLb/902mgJYLJIxFstozxwVnebTI/FM98EgJ83NqUzRzKXPSDeGW/724mG/P7kAaiHbw1ovhZy82wJj5igqpbpxCU5O+QQteSUEoSMVygMM7yP019u5iugM2LCFac0+OPWDat7YGSujQE3JYsOwd5HJxf9/XlyzUvxLDopKe3IU3OXR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachienergy.com; dmarc=pass action=none
 header.from=hitachienergy.com; dkim=pass header.d=hitachienergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachienergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOMP63VHRv6ZXzoIXW/OiUDw8YNfv9JOn3IVHrNuTBE=;
 b=XTJdgneDSvNZYLDsIhp1wzCBZm0kgFSYsjK92jNyBQu8W89ekabBEUpeqqpZidvTK2qBk9KJHFuvjX8YUrEiign9pOlVvOL/22Y8vafo6dtrM4BbE2Eoouc0sJJ1pKxu6xlSg7dEkZxBr+t7FS4X4m8jaynwQw2JUbj2dnovQS/H0k6ZwVjl2JTBWFZsja5QX0cdPUuhusVWc+ko8HO+eM/DZVXPc6x2Yr+BQmlytzTJAlwSXm7/WBnFS8mhiyPQMalybVLIjFkaJGpqEAHVp3FcQ/dFDp1eMyMQ/JN5JW/MSu1bw2jOd+rS/UpG+qnXpxRVqhjokyYuUu1Rtg5+Bg==
Received: from AM0PR06MB10396.eurprd06.prod.outlook.com (2603:10a6:20b:6fd::9)
 by VI1PR06MB6735.eurprd06.prod.outlook.com (2603:10a6:800:183::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 08:27:40 +0000
Received: from AM0PR06MB10396.eurprd06.prod.outlook.com
 ([fe80::f64e:6a20:6d85:183f]) by AM0PR06MB10396.eurprd06.prod.outlook.com
 ([fe80::f64e:6a20:6d85:183f%5]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 08:27:40 +0000
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "qiang.zhao@nxp.com"
	<qiang.zhao@nxp.com>, "horms@kernel.org" <horms@kernel.org>
Subject: RE: [PATCH net] net: wan: fsl_ucc_hdlc: free tx_skbuff in
 uhdlc_memclean
Thread-Topic: [PATCH net] net: wan: fsl_ucc_hdlc: free tx_skbuff in
 uhdlc_memclean
Thread-Index: AQHc2+C9zkursVznM0ykjVaFtNrz0rX+6qiAgAAws/CAAP/8AIAAijmQ
Date: Wed, 6 May 2026 08:27:40 +0000
Message-ID:
 <AM0PR06MB10396510359D3108860402A16F73F2@AM0PR06MB10396.eurprd06.prod.outlook.com>
References: <20260504161145.2217950-1-holger.brunck@hitachienergy.com>
	<3e1a653b-81bc-4008-8f84-77c823aeef49@kernel.org>
	<AM0PR06MB103966EF99B706158C49CB3EAF73E2@AM0PR06MB10396.eurprd06.prod.outlook.com>
 <20260505164736.26d203a8@kernel.org>
In-Reply-To: <20260505164736.26d203a8@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachienergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR06MB10396:EE_|VI1PR06MB6735:EE_
x-ms-office365-filtering-correlation-id: e0f42130-d0f2-4352-c6e2-08deab49567f
x-he-o365-outbound: HEO365Out
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 lDdgyjOg3n0ChfwsByuPstA+vo0K6wmLPTRnkcvJHlBQFssglxWEyFT0SHRQL55Ld3EPPN3Dxs9r0E59vSI25g5QyJepSSfU4UPVd7fj137GvS9Ai5cBFaEgxZJWvrJczaZYgljntld7xhEo4WxAbUQWW/oqx+/s2xWGNA9Jc5XcxUlUFpP26hVHbnTcrYHoPuPlaJM5msLaSEOLWikZGIZJdv9r0dPJFvgOanGuW2puLJParXAxVr2pEdab1G1d7XG9zx7zKtoAOwltaCL+cx2ubupUsCs1ydgptxPrT5QfLp+TOqlH3CxNqhevYcLRJXq5iFIOyHlOe2ng7qbgQbd79tMShXZJtpQaMmkfwpU+5CGn2xxpJKN1KGGuZaZbOgqj0IvKo+brmbHMQ+XvUwCdb9WMij5szlRaMd2UE6wMeQuK30njbOj4guhsA27LRzNjxiAkbfNlTU1nqh/4eZ1SMySyUjQu2O78Rf3hNcBT47stLfkc/gcDUTKB4LotBVF8W51+W/gCSJIQUwut3H2V69QllwxEu78VmPWcFDWXZOMz6j4vrBd2Q2MIHjQCDbfbygc7FSohSQ34hCPCP3rOejYLwMpnn0pixbQ7+7go/oP072nFSXSX1NZ5epocMzm5OAllZDd72+8UpnA30HN++LuG4olneM+oNXZATqTZ2a5wG82aZ2stORtixk60
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR06MB10396.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?23EQ0hqEJX6zAgcJBJonWNQwVZtBQlhZeH66/SooRU39VEOXC+lUVtgnWog+?=
 =?us-ascii?Q?hQb2p5JsL3KXZOa4/6TdSL+KEpD52itCiDUNPm1bjhsmBu3lD6x1SNxQUvM0?=
 =?us-ascii?Q?+g+cMRAPpOm1TTZY0HI84I+i8qNwITsVe7sOHnA3ftSStMBy6ICImKp44hWv?=
 =?us-ascii?Q?k857gNfh25xDqFZr903Xv+LNdECgOc6ZZJCMYSnLZ8M1uxyVFez1QM7Ul3tF?=
 =?us-ascii?Q?WEzV9yBlMQONO3kbhYdbvq7pKT/WT7jG7BgpSSegiZ8XUUA3ocLwgMgMSTHb?=
 =?us-ascii?Q?9svHA+HN15ncluQHX6cC/FiR0jecwP6+jLZO6ofuf1pNHcKTpKkj2NvMsX70?=
 =?us-ascii?Q?e9sCAh5pi/JG0/0xvZTmKutBR8bMkLXUbLj2MJOpe6H0mfHVbSVqzpqNfB8Z?=
 =?us-ascii?Q?2yLjCv1thoae3uPGX/hWuWz30xmwt1JwQsMPcizTXtwN117a5MAPGHi6YdPt?=
 =?us-ascii?Q?ZPfs8S+kz4ZLV3Ga/+IMSUPNabhn2E7rK8b+SMLyZYrs71jYGKylJPjs4HtL?=
 =?us-ascii?Q?Ek3hWxt0Lr0tb2WbEPnruCHO0xUyAPlZTobwJ9P07gXJKTxPbfk4dUhkbKQC?=
 =?us-ascii?Q?f6gU7sQnrSONhiNfXe5Z5PEOxUuiJIX/BEqO29U4KA75ShrXidpMYQreiGcI?=
 =?us-ascii?Q?/g+QLeiZKxhLaMnNK0ikVYbD+ISH4HbkRreIPFAkyahJx0rEgLzQDmAvbGlN?=
 =?us-ascii?Q?IdsIMR8dTlmHc5mUzZrkJwjszcm+Sn0TK7Il4tJevTYSN9ARsQp6nvhg1ViK?=
 =?us-ascii?Q?x9jyMDfvaDNO1ptlUfW0KYQqiMKKb7Y5q9S+W5dRWLLmOCxfJ/fYN/zQDtcF?=
 =?us-ascii?Q?7kPUY/cRIm6EPnZgc2zilrAj7hqbJt3BlIgXlhdn8IQXZX5YXsKmoN53z3oW?=
 =?us-ascii?Q?MbskWUs4ILPOUgSgcsLq1IeFTbzhJaeReeeYt/s6KPKfCypFtrTRUR0t/QJi?=
 =?us-ascii?Q?hBzUx107XkUS2nthWMT2yDRh/g9FIJRBNmru5ZIhOwYBJRkR/RNoMXf5+IOp?=
 =?us-ascii?Q?iqYkcRoq1xJk29bbgU4y4tbqzuja2Mkile4eoY2ZEP3bhUoavhJbpsr7ErwB?=
 =?us-ascii?Q?PugxnLNQJhNIzOO82kmrUvcpIexe2QeRMA/jiK/V3LFNXqmWYecovZFDllWA?=
 =?us-ascii?Q?ZTprWmh12xSACCjnbyUYElHdL1yy6Mz1NtSplbAqM6ZfYRsN/FZfb+cfGN5j?=
 =?us-ascii?Q?xrM6IqeHW9otTJBD2VGIjAUnDhdQy1mYLbXly0AlCd19NzF4PnDLj1pa1eBs?=
 =?us-ascii?Q?XaYmLUjfYUioYTVbGO5yjfju5IcY2x4geT3swz7qu16EuKREEJhR8KVu+H7F?=
 =?us-ascii?Q?y43hcQ8sE8RC6/k7DkTzWvzJbr8I7H/ylW5/1iKu0q8B2M/oMlVClCobSAEG?=
 =?us-ascii?Q?td3YhP/MKRgRIsD28RG87g3fo8slMcjO15sfJ0pU32hqgszKqItyVc8d55YO?=
 =?us-ascii?Q?DzhF2L6D/ju5bVL3DkimqDXPuHQiIvBJOJCHON2Pyufg8eTWabaSJGeOZeiw?=
 =?us-ascii?Q?lBEUKd7JqJZ4WuofpEJ9Mvewj9Yv594xI3gosG/w5WnIFe3J1tPavABRjJIV?=
 =?us-ascii?Q?+tQWBUqTlhnUw4i/8gOfYUuNdfcJ3Of7ypZdD2ydUq8hG7j6JuKbhjJsxz7P?=
 =?us-ascii?Q?93fJ79SciFz4gctUm8xQiKQfNqQnNCDjS+XEAVnEDYQXJ+4s9Y1enRqxv68+?=
 =?us-ascii?Q?KLSjJV7oyT+Zox+iWTKlMi+00F5PtUz7wR8zvFqGVS5O4T3WNlGq4K6X8zFq?=
 =?us-ascii?Q?Trd+cXuH+Mh7FC/sfDwRVv2XoTc5Z8E=3D?=
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
X-OriginatorOrg: hitachienergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR06MB10396.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f42130-d0f2-4352-c6e2-08deab49567f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 08:27:40.5107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KQ5+Wq15JuxFkpezuPln3HYQPplHSrku84yssKpQ1XuPcEYQxdxMNd9CKer+Zh7rhSmlvDs7TcVz3ikikbbKLE7Q7ZxUzZkR8PYmK6hH6WA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6735

 > On Tue, 5 May 2026 08:33:34 +0000 Holger Brunck wrote:
> > > I don't think you can just kfree() an skb like this.
> > >
> > > I think you have to call dev_kfree_skb_any() instead.
> >
> > yes you are right or at least dev_kfree_skb() as the error handling
> > code in ucc_hdlc_tx does.
>=20
> Please make it clear in the commit message how you discovered the issue a=
nd
> how you tested your patches.

currently the driver is broken if you compile it as a module and try to rel=
oad it.
The issue was discovered by a sashiko review for a previous patch of me:
 https://sashiko.dev/#/patchset/20260429114208.941011-1-holger.brunck%40hit=
achienergy.com

Still there are further issues remaining in the driver. I will update the p=
atch and
the commit message.

Best regards
Holger



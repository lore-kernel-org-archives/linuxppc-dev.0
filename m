Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2538FC32789
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 06:51:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE062081D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 06:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AMKDAGD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE062081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42q0ZC6FcSzF3BB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 17:51:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="AMKDAGD2";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.81; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=xiaowei.bao@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="AMKDAGD2"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00081.outbound.protection.outlook.com [40.107.0.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42q0WC3Cw4zF1x0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 17:48:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wrRwXnL/unugt79BHXsMevAXPy5/MpOfcWfAJIfrKI=;
 b=AMKDAGD2inCGjyaJkGfTbTidKxW0UWkMRvrHzViCuBj6c4WDFOyw+fQ7Lx8s8V9bKP5jxNAmH5ou6z9K4AryMjLm1K1x85QSYNuH6o0e9w0PZncFp5gU+VmO2INcDVyY+akAELhNMAgw8XOzcmYb/bBW/+Gq9wWWT1JXf4ShMho=
Received: from HE1PR04MB1497.eurprd04.prod.outlook.com (10.163.176.23) by
 HE1PR04MB1578.eurprd04.prod.outlook.com (10.164.48.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Tue, 6 Nov 2018 06:48:27 +0000
Received: from HE1PR04MB1497.eurprd04.prod.outlook.com
 ([fe80::4070:91bb:7cd2:1f63]) by HE1PR04MB1497.eurprd04.prod.outlook.com
 ([fe80::4070:91bb:7cd2:1f63%3]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 06:48:27 +0000
From: Xiaowei Bao <xiaowei.bao@nxp.com>
To: Kishon Vijay Abraham I <kishon@ti.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org"
 <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "arnd@arndb.de"
 <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "M.h. Lian" <minghuan.lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, Roy
 Zang <roy.zang@nxp.com>, "kstewart@linuxfoundation.org"
 <kstewart@linuxfoundation.org>, "cyrille.pitchen@free-electrons.com"
 <cyrille.pitchen@free-electrons.com>, "pombredanne@nexb.com"
 <pombredanne@nexb.com>, "shawn.lin@rock-chips.com"
 <shawn.lin@rock-chips.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 5/6] pci: layerscape: Add the EP mode support.
Thread-Topic: [PATCH 5/6] pci: layerscape: Add the EP mode support.
Thread-Index: AQHUbFPBC6aEqg5WuUCTs5ZVrmqyDqUxAPsAgAA8nBCAB2zBkIAAHa2AgAAAvtCACCmfgIAAANHAgAFh7ACAAAXk4A==
Date: Tue, 6 Nov 2018 06:48:26 +0000
Message-ID: <HE1PR04MB14972FA5A46885370788B9B7F5CB0@HE1PR04MB1497.eurprd04.prod.outlook.com>
References: <20181025110901.5680-1-xiaowei.bao@nxp.com>
 <20181025110901.5680-5-xiaowei.bao@nxp.com>
 <d9d07e05-556b-a56d-bb7f-eaec9fb739b8@ti.com>
 <HE1PR04MB1497DF7D9428A5C791CB6A03F5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
 <HE1PR04MB14979058170FA16A7465FF9EF5CD0@HE1PR04MB1497.eurprd04.prod.outlook.com>
 <a85a6900-2478-0750-6f33-2e787cf80d1d@ti.com>
 <HE1PR04MB1497DF7378927C9BB5DF3E15F5CD0@HE1PR04MB1497.eurprd04.prod.outlook.com>
 <8ec7f502-e058-2c28-9140-5d125e4af6ff@ti.com>
 <HE1PR04MB1497DABC689F9A4A97FD4DF0F5CA0@HE1PR04MB1497.eurprd04.prod.outlook.com>
 <dfedeaec-9a3b-632e-af37-cb1963dcae7c@ti.com>
In-Reply-To: <dfedeaec-9a3b-632e-af37-cb1963dcae7c@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HE1PR04MB1578;
 6:Qnjn1hYig6SHdvQEqVbXQIANuoUGtttO9Nhyv/Z06zqBWXtT4wZgW2Z0ZG0RBVTrUecqwmUXD9Ym8E064FU8pnh0o2IySIfx/iZLpsvx4yspMGQ4zDjDVI8+nJpD2Yw/0f92Z104qXeViBfBmz1QaxtyqoDs4rNnx9AeGbXrZ3Y7LfPLf5kDOQ68fevmVIbLuSyeORROlbXqesi13rD80IPc4aVMo5+ojNzOCIkpZAKlxU4zGDcInFstpyelv0WGcH2nWY/i1T7DlrSvxPryeK65VdsnJQtQ8Jg6kb/s20c4Skt9hSMJ7XCBcTNkNbjsoGUijQHjbjzNik0S6EhFqgeq/IRSevnOpfPOzq6v82+K2eAzsMHPidymvIF0AFxEkcsP2tBJkCAbtjrEbUpBHel3RXC0OPWdNyHV5JDYfZ0iCeNQjJEou0xWsbBtRucjAJZiJUUYr5AOEvz2GRkiAA==;
 5:4+GaTwZqWu+JG/Dz0/X33Vj9Gf2ctdDydxyjH7Xs47jQElbd6Ym9VWLaikbg9o1/7YZ89koCa97yYovF557LD+oFdCl5cHsL7m9odPD8pGWmBo/g0acZJ5tAPY59J+VrM1mOneGVvL6rFZ0JHXxhU9tUxVf1+NZ+Xb0F9mu8xeE=;
 7:tQAmceX9m4i8oDlp0lZ2Y0p1LzxeQ+eAMMTGqo4Py82mXqKVYYtQPdPwjP+z4V3Hlrx8ZGtmTSTMVYFGTh3Xmku/+3RbSEZLpl302W0QKVsGXRwinmrbYwapPIFf/NqNz/raOFS4VhdSWMSq7dMtZw==
x-ms-office365-filtering-correlation-id: fb02b7b3-ce00-4d47-db53-08d643b3db0c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR04MB1578; 
x-ms-traffictypediagnostic: HE1PR04MB1578:
x-microsoft-antispam-prvs: <HE1PR04MB157857A86CFEE28C3D0D069FF5CB0@HE1PR04MB1578.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(180628864354917)(58145275503218)(9452136761055)(258649278758335)(65623756079841)(31051911155226)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:HE1PR04MB1578; BCL:0; PCL:0; RULEID:; SRVR:HE1PR04MB1578; 
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(396003)(366004)(39860400002)(136003)(189003)(13464003)(199004)(86362001)(575784001)(74316002)(110136005)(8936002)(2501003)(7696005)(76176011)(6506007)(2201001)(53546011)(53936002)(93886005)(5660300001)(2906002)(25786009)(4326008)(6246003)(2900100001)(316002)(99286004)(229853002)(105586002)(7416002)(106356001)(71190400001)(14454004)(14444005)(68736007)(256004)(6436002)(6116002)(8676002)(3846002)(81166006)(81156014)(478600001)(44832011)(11346002)(55016002)(446003)(66066001)(97736004)(305945005)(7736002)(33656002)(476003)(71200400001)(186003)(9686003)(486006)(26005)(102836004)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR04MB1578;
 H:HE1PR04MB1497.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VGiV0wm38/MutOyxFyy2oLfSmOhyfnWhb/VmFSonfH9GMcFGOydvG7fA+KmPbr3QtIBQa+IDqIjl5FHPOyPvaDqYqZzBtrYYr6rNYKYQ0qU1hJ1iwUgfeD0Gt6yYp9e6izqPSgISJ7vDT1LCGXU8i5EvprJ4uln3jNLVjVCg2q9zpqE1FK+cU2LY8sJPmau0bssLw+wER6+0Y52PsznCqckNZlo/haj4e3EirfEKXWjUr7oV+mp+rSJq4YY1ucoMoO2tENDvZKn9MyKABVjjVeEOjkni4R4wZQygLcBP1iziYjeDpCTHxAja7sjfDLzNJJCyKwDtaZGCctlhp9TD32F+m4i2RtOk5+gaUvSw3n8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb02b7b3-ce00-4d47-db53-08d643b3db0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 06:48:26.7329 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1578
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Jiafei Pan <jiafei.pan@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgS2lzaG9u77yMDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLaXNob24g
VmlqYXkgQWJyYWhhbSBJIDxraXNob25AdGkuY29tPiANClNlbnQ6IDIwMTjlubQxMeaciDbml6Ug
MTQ6MDcNClRvOiBYaWFvd2VpIEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT47IGJoZWxnYWFzQGdv
b2dsZS5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IHNoYXdu
Z3VvQGtlcm5lbC5vcmc7IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsgbG9yZW56by5waWVy
YWxpc2lAYXJtLmNvbTsgYXJuZEBhcm5kYi5kZTsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7
IE0uaC4gTGlhbiA8bWluZ2h1YW4ubGlhbkBueHAuY29tPjsgTWluZ2thaSBIdSA8bWluZ2thaS5o
dUBueHAuY29tPjsgUm95IFphbmcgPHJveS56YW5nQG54cC5jb20+OyBrc3Rld2FydEBsaW51eGZv
dW5kYXRpb24ub3JnOyBjeXJpbGxlLnBpdGNoZW5AZnJlZS1lbGVjdHJvbnMuY29tOyBwb21icmVk
YW5uZUBuZXhiLmNvbTsgc2hhd24ubGluQHJvY2stY2hpcHMuY29tOyBsaW51eC1wY2lAdmdlci5r
ZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eHBw
Yy1kZXZAbGlzdHMub3psYWJzLm9yZw0KQ2M6IEppYWZlaSBQYW4gPGppYWZlaS5wYW5AbnhwLmNv
bT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggNS82XSBwY2k6IGxheWVyc2NhcGU6IEFkZCB0aGUgRVAg
bW9kZSBzdXBwb3J0Lg0KDQooUmVtb3ZlZCBOaWtsYXMgYXMgbWFpbHMgdG8gaGltIGlzIGJvdW5j
aW5nKQ0KDQpIaSwNCg0KUGxlYXNlIGZpeCB5b3VyIGVtYWlsIGNsaWVudC4gUmVmZXIgRG9jdW1l
bnRhdGlvbi9wcm9jZXNzL2VtYWlsLWNsaWVudHMucnN0DQoNCk9uIDA1LzExLzE4IDI6NDUgUE0s
IFhpYW93ZWkgQmFvIHdyb3RlOg0KPiANCj4gDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IEtpc2hvbiBWaWpheSBBYnJhaGFtIEkgPGtpc2hvbkB0aS5jb20+DQo+IFNlbnQ6
IDIwMTjlubQxMeaciDXml6UgMTY6NTcNCj4gVG86IFhpYW93ZWkgQmFvIDx4aWFvd2VpLmJhb0Bu
eHAuY29tPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgDQo+IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFy
ay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7IExlbyBMaSANCj4gPGxlb3lh
bmcubGlAbnhwLmNvbT47IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGFybmRAYXJuZGIuZGU7
IA0KPiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgTS5oLiBMaWFuIDxtaW5naHVhbi5saWFu
QG54cC5jb20+OyBNaW5na2FpIA0KPiBIdSA8bWluZ2thaS5odUBueHAuY29tPjsgUm95IFphbmcg
PHJveS56YW5nQG54cC5jb20+OyANCj4ga3N0ZXdhcnRAbGludXhmb3VuZGF0aW9uLm9yZzsgY3ly
aWxsZS5waXRjaGVuQGZyZWUtZWxlY3Ryb25zLmNvbTsgDQo+IHBvbWJyZWRhbm5lQG5leGIuY29t
OyBzaGF3bi5saW5Acm9jay1jaGlwcy5jb207IA0KPiBuaWtsYXMuY2Fzc2VsQGF4aXMuY29tOyBs
aW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyANCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IA0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnDQo+IENjOiBKaWFm
ZWkgUGFuIDxqaWFmZWkucGFuQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNS82XSBw
Y2k6IGxheWVyc2NhcGU6IEFkZCB0aGUgRVAgbW9kZSBzdXBwb3J0Lg0KPiANCj4gSGksDQo+IA0K
PiBPbiAzMS8xMC8xOCA0OjA4IFBNLCBYaWFvd2VpIEJhbyB3cm90ZToNCj4+DQo+Pg0KPj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+IEZyb206IEtpc2hvbiBWaWpheSBBYnJhaGFtIEkg
PGtpc2hvbkB0aS5jb20+DQo+PiBTZW50OiAyMDE45bm0MTDmnIgzMeaXpSAxMjoxNQ0KPj4gVG86
IFhpYW93ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29tPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsN
Cj4+IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtl
cm5lbC5vcmc7IExlbyBMaQ0KPj4gPGxlb3lhbmcubGlAbnhwLmNvbT47IGxvcmVuem8ucGllcmFs
aXNpQGFybS5jb207IGFybmRAYXJuZGIuZGU7IA0KPj4gZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc7IE0uaC4gTGlhbiA8bWluZ2h1YW4ubGlhbkBueHAuY29tPjsgDQo+PiBNaW5na2FpIEh1IDxt
aW5na2FpLmh1QG54cC5jb20+OyBSb3kgWmFuZyA8cm95LnphbmdAbnhwLmNvbT47IA0KPj4ga3N0
ZXdhcnRAbGludXhmb3VuZGF0aW9uLm9yZzsgY3lyaWxsZS5waXRjaGVuQGZyZWUtZWxlY3Ryb25z
LmNvbTsNCj4+IHBvbWJyZWRhbm5lQG5leGIuY29tOyBzaGF3bi5saW5Acm9jay1jaGlwcy5jb207
IA0KPj4gbmlrbGFzLmNhc3NlbEBheGlzLmNvbTsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsg
DQo+PiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgDQo+PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4cHBj
LWRldkBsaXN0cy5vemxhYnMub3JnDQo+PiBDYzogSmlhZmVpIFBhbiA8amlhZmVpLnBhbkBueHAu
Y29tPg0KPj4gU3ViamVjdDogUmU6IFtQQVRDSCA1LzZdIHBjaTogbGF5ZXJzY2FwZTogQWRkIHRo
ZSBFUCBtb2RlIHN1cHBvcnQuDQo+Pg0KPj4gSGksDQo+Pg0KPj4gT24gMzEvMTAvMTggODowMyBB
TSwgWGlhb3dlaSBCYW8gd3JvdGU6DQo+Pj4NCj4+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+Pj4gRnJvbTogWGlhb3dlaSBCYW8NCj4+PiBTZW50OiAyMDE45bm0MTDmnIgyNuaX
pSAxNzoxOQ0KPj4+IFRvOiAnS2lzaG9uIFZpamF5IEFicmFoYW0gSScgPGtpc2hvbkB0aS5jb20+
OyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPj4+IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRs
YW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7IExlbyANCj4+PiByb2JoK0xpDQo+Pj4g
PGxlb3lhbmcubGlAbnhwLmNvbT47IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGFybmRAYXJu
ZGIuZGU7IA0KPj4+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBNLmguIExpYW4gPG1pbmdo
dWFuLmxpYW5AbnhwLmNvbT47IA0KPj4+IE1pbmdrYWkgSHUgPG1pbmdrYWkuaHVAbnhwLmNvbT47
IFJveSBaYW5nIDxyb3kuemFuZ0BueHAuY29tPjsgDQo+Pj4ga3N0ZXdhcnRAbGludXhmb3VuZGF0
aW9uLm9yZzsgY3lyaWxsZS5waXRjaGVuQGZyZWUtZWxlY3Ryb25zLmNvbTsNCj4+PiBwb21icmVk
YW5uZUBuZXhiLmNvbTsgc2hhd24ubGluQHJvY2stY2hpcHMuY29tOyANCj4+PiBuaWtsYXMuY2Fz
c2VsQGF4aXMuY29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyANCj4+PiBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgDQo+Pj4gbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eHBwYy1kZXZAbGlzdHMub3ps
YWJzLm9yZw0KPj4+IENjOiBKaWFmZWkgUGFuIDxqaWFmZWkucGFuQG54cC5jb20+DQo+Pj4gU3Vi
amVjdDogUkU6IFtQQVRDSCA1LzZdIHBjaTogbGF5ZXJzY2FwZTogQWRkIHRoZSBFUCBtb2RlIHN1
cHBvcnQuDQo+Pj4NCj4+Pg0KPj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+
PiBGcm9tOiBLaXNob24gVmlqYXkgQWJyYWhhbSBJIDxraXNob25AdGkuY29tPg0KPj4+IFNlbnQ6
IDIwMTjlubQxMOaciDI25pelIDEzOjI5DQo+Pj4gVG86IFhpYW93ZWkgQmFvIDx4aWFvd2VpLmJh
b0BueHAuY29tPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4+PiByb2JoK2R0QGtlcm5lbC5vcmc7
IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8gDQo+Pj4gcm9i
aCtMaQ0KPj4+IDxsZW95YW5nLmxpQG54cC5jb20+OyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29t
OyBhcm5kQGFybmRiLmRlOyANCj4+PiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgTS5oLiBM
aWFuIDxtaW5naHVhbi5saWFuQG54cC5jb20+OyANCj4+PiBNaW5na2FpIEh1IDxtaW5na2FpLmh1
QG54cC5jb20+OyBSb3kgWmFuZyA8cm95LnphbmdAbnhwLmNvbT47IA0KPj4+IGtzdGV3YXJ0QGxp
bnV4Zm91bmRhdGlvbi5vcmc7IGN5cmlsbGUucGl0Y2hlbkBmcmVlLWVsZWN0cm9ucy5jb207DQo+
Pj4gcG9tYnJlZGFubmVAbmV4Yi5jb207IHNoYXduLmxpbkByb2NrLWNoaXBzLmNvbTsgDQo+Pj4g
bmlrbGFzLmNhc3NlbEBheGlzLmNvbTsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgDQo+Pj4g
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IA0KPj4+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXhwcGMtZGV2
QGxpc3RzLm96bGFicy5vcmcNCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIDUvNl0gcGNpOiBsYXll
cnNjYXBlOiBBZGQgdGhlIEVQIG1vZGUgc3VwcG9ydC4NCj4+Pg0KPj4+IEhpLA0KPj4+DQo+Pj4g
T24gVGh1cnNkYXkgMjUgT2N0b2JlciAyMDE4IDA0OjM5IFBNLCBYaWFvd2VpIEJhbyB3cm90ZToN
Cj4+Pj4gQWRkIHRoZSBQQ0llIEVQIG1vZGUgc3VwcG9ydCBmb3IgbGF5ZXJzY2FwZSBwbGF0Zm9y
bS4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogWGlhb3dlaSBCYW8gPHhpYW93ZWkuYmFvQG54
cC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvTWFrZWZp
bGUgICAgICAgICAgICB8ICAgIDIgKy0NCj4+Pj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaS1sYXllcnNjYXBlLWVwLmMgfCAgMTYxDQo+Pj4+ICsrKysrKysrKysrKysrKysrKysrKysr
Kw0KPj4+PiAgMiBmaWxlcyBjaGFuZ2VkLCAxNjIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMo
LSkgIGNyZWF0ZSBtb2RlDQo+Pj4+IDEwMDY0NCBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2ktbGF5ZXJzY2FwZS1lcC5jDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9NYWtlZmlsZQ0KPj4+PiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L01ha2VmaWxlDQo+Pj4+IGluZGV4IDVkMmNlNzIuLmIyNmQ2MTcgMTAwNjQ0DQo+Pj4+IC0tLSBh
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL01ha2VmaWxlDQo+Pj4+ICsrKyBiL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL01ha2VmaWxlDQo+Pj4+IEBAIC04LDcgKzgsNyBAQCBvYmotJChD
T05GSUdfUENJX0VYWU5PUykgKz0gcGNpLWV4eW5vcy5vDQo+Pj4+ICBvYmotJChDT05GSUdfUENJ
X0lNWDYpICs9IHBjaS1pbXg2Lm8NCj4+Pj4gIG9iai0kKENPTkZJR19QQ0lFX1NQRUFSMTNYWCkg
Kz0gcGNpZS1zcGVhcjEzeHgubw0KPj4+PiAgb2JqLSQoQ09ORklHX1BDSV9LRVlTVE9ORSkgKz0g
cGNpLWtleXN0b25lLWR3Lm8gcGNpLWtleXN0b25lLm8NCj4+Pj4gLW9iai0kKENPTkZJR19QQ0lf
TEFZRVJTQ0FQRSkgKz0gcGNpLWxheWVyc2NhcGUubw0KPj4+PiArb2JqLSQoQ09ORklHX1BDSV9M
QVlFUlNDQVBFKSArPSBwY2ktbGF5ZXJzY2FwZS5vIA0KPj4+PiArcGNpLWxheWVyc2NhcGUtZXAu
bw0KPj4+PiAgb2JqLSQoQ09ORklHX1BDSUVfUUNPTSkgKz0gcGNpZS1xY29tLm8NCj4+Pj4gIG9i
ai0kKENPTkZJR19QQ0lFX0FSTUFEQV84SykgKz0gcGNpZS1hcm1hZGE4ay5vDQo+Pj4+ICBvYmot
JChDT05GSUdfUENJRV9BUlRQRUM2KSArPSBwY2llLWFydHBlYzYubyBkaWZmIC0tZ2l0IA0KPj4+
PiBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1sYXllcnNjYXBlLWVwLmMNCj4+Pj4g
Yi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbGF5ZXJzY2FwZS1lcC5jDQo+Pj4+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+Pj4+IGluZGV4IDAwMDAwMDAuLjNiMzNiYmMNCj4+Pj4gLS0t
IC9kZXYvbnVsbA0KPj4+PiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbGF5
ZXJzY2FwZS1lcC5jDQo+Pj4+IEBAIC0wLDAgKzEsMTYxIEBADQo+Pj4+ICsvLyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPj4+PiArLyoNCj4+Pj4gKyAqIFBDSWUgY29udHJvbGxl
ciBFUCBkcml2ZXIgZm9yIEZyZWVzY2FsZSBMYXllcnNjYXBlIFNvQ3MNCj4+Pj4gKyAqDQo+Pj4+
ICsgKiBDb3B5cmlnaHQgKEMpIDIwMTggTlhQIFNlbWljb25kdWN0b3IuDQo+Pj4+ICsgKg0KPj4+
PiArICogQXV0aG9yOiBYaWFvd2VpIEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT4gICovDQo+Pj4+
ICsNCj4+Pj4gKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCj4+Pj4gKyNpbmNsdWRlIDxsaW51
eC9pbml0Lmg+DQo+Pj4+ICsjaW5jbHVkZSA8bGludXgvb2ZfcGNpLmg+DQo+Pj4+ICsjaW5jbHVk
ZSA8bGludXgvb2ZfcGxhdGZvcm0uaD4NCj4+Pj4gKyNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNz
Lmg+DQo+Pj4+ICsjaW5jbHVkZSA8bGludXgvcGNpLmg+DQo+Pj4+ICsjaW5jbHVkZSA8bGludXgv
cGxhdGZvcm1fZGV2aWNlLmg+ICNpbmNsdWRlIDxsaW51eC9yZXNvdXJjZS5oPg0KPj4+PiArDQo+
Pj4+ICsjaW5jbHVkZSAicGNpZS1kZXNpZ253YXJlLmgiDQo+Pj4+ICsNCj4+Pj4gKyNkZWZpbmUg
UENJRV9EQkkyX09GRlNFVAkJMHgxMDAwCS8qIERCSTIgYmFzZSBhZGRyZXNzKi8NCj4+Pg0KPj4+
IFRoZSBiYXNlIGFkZHJlc3Mgc2hvdWxkIGNvbWUgZnJvbSBkdC4NCj4+Pj4gKw0KPj4+PiArc3Ry
dWN0IGxzX3BjaWVfZXAgew0KPj4+PiArCXN0cnVjdCBkd19wY2llCQkqcGNpOw0KPj4+PiArfTsN
Cj4+Pj4gKw0KPj4+PiArI2RlZmluZSB0b19sc19wY2llX2VwKHgpCWRldl9nZXRfZHJ2ZGF0YSgo
eCktPmRldikNCj4+Pj4gKw0KPj4+PiArc3RhdGljIGJvb2wgbHNfcGNpZV9pc19icmlkZ2Uoc3Ry
dWN0IGxzX3BjaWVfZXAgKnBjaWUpIHsNCj4+Pj4gKwlzdHJ1Y3QgZHdfcGNpZSAqcGNpID0gcGNp
ZS0+cGNpOw0KPj4+PiArCXUzMiBoZWFkZXJfdHlwZTsNCj4+Pj4gKw0KPj4+PiArCWhlYWRlcl90
eXBlID0gaW9yZWFkOChwY2ktPmRiaV9iYXNlICsgUENJX0hFQURFUl9UWVBFKTsNCj4+Pj4gKwlo
ZWFkZXJfdHlwZSAmPSAweDdmOw0KPj4+PiArDQo+Pj4+ICsJcmV0dXJuIGhlYWRlcl90eXBlID09
IFBDSV9IRUFERVJfVFlQRV9CUklER0U7IH0NCj4+Pj4gKw0KPj4+PiArc3RhdGljIGludCBsc19w
Y2llX2VzdGFibGlzaF9saW5rKHN0cnVjdCBkd19wY2llICpwY2kpIHsNCj4+Pj4gKwlyZXR1cm4g
MDsNCj4+Pj4gK30NCj4+Pg0KPj4+IFRoZXJlIHNob3VsZCBiZSBzb21lIHdheSBieSB3aGljaCBF
UCBzaG91bGQgdGVsbCBSQyB0aGF0IGl0IGlzIG5vdCBjb25maWd1cmVkIHlldC4gQXJlIHRoZXJl
IG5vIGJpdHMgdG8gY29udHJvbCBMVFNTTSBzdGF0ZSBpbml0aWFsaXphdGlvbiBvciBDb25maWd1
cmF0aW9uIHJldHJ5IHN0YXR1cyBlbmFibGluZz8NCj4+PiBbWGlhb3dlaSBCYW9dIFRoZXJlIGhh
dmUgbm90IGJpdHMgdG8gY29udHJvbCBMVFNTTSBzdGF0ZSB0byB0ZWxsIHRoZSBSQyBpdCBpcyBj
b25maWd1cmVkLiBUaGUgc3RhcnQgbGluayBpcyBhdXRvIGNvbXBsZXRlZC4NCj4+PiBbWGlhb3dl
aSBCYW9dIEhpIEtpc2hvbiwgaXMgdGhlcmUgYW55IGFkdmljZT8NCj4+DQo+PiBJZiB0aGVyZSBp
cyBubyBIVyBzdXBwb3J0LCBJIGRvbid0IHRoaW5rIGFueXRoaW5nIGNvdWxkIGJlIGRvbmUgaGVy
ZS4gVGhpcyBjb3VsZCByZXN1bHQgaW4gUkMgcmVhZGluZyBjb25maWd1cmF0aW9uIHNwYWNlIGV2
ZW4gYmVmb3JlIEVQIGlzIGZ1bGx5IGluaXRpYWxpemVkLg0KPj4gW1hpYW93ZWkgQmFvXSBUaGUg
Ym9vdGxvYWRlciBoYXZlIGluaXRpYWxpemVkIHRoZSBFUCBkZXZpY2UgYW5kIHNldCB0aGUgY29u
ZmlnIHJlYWR5IGJpdCwgYW5kIHRoZSBrZXJuZWwgZG9uJ3QgbmVlZCB0byBkbyBhbnl0aGluZy4N
Cj4gDQo+IFdoYXQgZG9lcyBib290bG9hZGVyIGluaXRhbGl6ZT8gVGhlIEVQIGRyaXZlciBoZXJl
IHdpbGwgcmVpbml0aWFsaXplIGV2ZXJ5dGhpbmcgcmlnaHQ/DQo+IFtYaWFvd2VpIEJhb10gVGhl
IGJvb3Rsb2FkZXIgaW5pdGlhbGl6ZSBCQVIgc2l6ZSwgb3V0Ym91bmQgd2luZG93LCBpbmJvdW5k
IHdpbmRvdyBhbmQgc2V0IHRoZSBjb25maWcgcmVhZHkgYml0Lg0KDQpIb3cgd2lsbCBib290bG9h
ZGVyIGtub3cgdGhlIEJBUiBzaXplPyBUaGUgQkFSIHNpemUgaXMgYmFzZWQgb24gdGhlIGZ1bmN0
aW9uIGRyaXZlci4gSG93IGRvZXMgYm9vdGxvYWRlciBjb25maWd1cmUgdGhlIE9CIHdpbmRvdz8g
VGhlIE9CIHdpbmRvdyBpcyBjb25maWd1cmVkIGJhc2VkIG9uIHRoZSBzaXplIGFuZCBhZGRyZXNz
IGdpdmVuIGJ5IHRoZSBob3N0IGR5bmFtaWNhbGx5IGF0IHJ1bnRpbWUuDQoNClRoYW5rcw0KS2lz
aG9uDQpbWGlhb3dlaSBCYW9dIFdlIHVzZSB0aGUgYm9vdGxvYWRlciBpcyB1LWJvb3QsIHdlIGlt
cGxlbWVudCB0aGUgRVAgYmFzZSBmZWF0dXJlIGluIHRoZSB1LWJvb3QsIGUuZy4oTUVNIHNwYWNl
IGFjY2VzcyhSQzw9PkVQKSwgQ09ORklHIHNwYWNlIGFjY2VzcyhSQz0+RVApKSwgd2Ugc2V0IHRo
ZSBFUCBCQVIgc2l6ZSBsaWtlIGtlcm5lbChzZXQgdGhlIFBDSV9CQVNFX0FERFJFU1NfbiByZWdp
c3RlciwgYnV0IGRpZmZlcmVudCBzaXplKSwgYW5kIHRoZSBvdXRib3VuZCB3aW5kb3dzIGFsc28g
YmUgc2V0LCBhbmQgdGhlIGJhciBzaXplIHdpbGwgYmUgY292ZXIgYnkgdGhlIEVQIGZyYW1ld29y
ayBkcml2ZXIgd2hlbiBrZXJuZWwgc3RhcnQgdXAuDQpJIGhhdmUgdG8gc2V0IHRoZSBkd19wY2ll
X29wcywgaWYgZG9uJ3QgY29uZmlnIHRoZSBkd19wY2llX29wcyB0aGVyZSB3aWxsIGhhdmUgY2Fs
bCB0cmFjZSwgYmVjYXVzZSB0aGUgRFcgZHJpdmVyIHdpbGwgY2FsbCB0aGUgd3JpdGVfZGJpIG9y
IHJlYWRfZGJpIGZ1bmN0aW9uIGRpcmVjdGx5IGJ1dCBub3QgY2hlY2sgdGhlIGR3X3BjaWVfb3Bz
IHdoZXRoZXIgaXMgbnVsbC4gSSByZWZlciB0byB0aGUgcGNpZS1kZXNpZ253YXJlLXBsYXQuYyB0
byBpbXBsZW1lbnQgaXQuIEkgZG9uJ3Qga25vdyB3aGF0IHlvdSBzYWlkIGFib3V0IHRoaXMsIGNv
dWxkIHlvdSB0ZWxsIG1lIHRoZSBlZmZlY3QsIFRoYW5rcyBhIGxvdC4NCg0KVGhhbmtzDQpYaWFv
d2VpDQoNCg==

Return-Path: <SRS0=9RGo=SD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5641C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 11:18:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6650920870
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 11:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vr0p3BNV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6650920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44XqZk4MfczDqNw
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 22:18:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe05::605;
 helo=eur02-he1-obe.outbound.protection.outlook.com;
 envelope-from=laurentiu.tudor@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="vr0p3BNV"; 
 dkim-atps=neutral
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02on0605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe05::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44XqWm3N2SzDqMy
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Apr 2019 22:15:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDt5c24JPvCkZ8d3qoJs6NM2wV3q/Wis/3lE1GmNXRA=;
 b=vr0p3BNV3dO/1bfIWJn7YcmzAki6fDFvxCQBCOi9qdC5J1tmRHMxVsvN2mcxV9A0fGOXu5XMq7DMtmLUrTQIqUzOX/RJpTYXi3fVZBdnuEBaX6oQunexi1A4tfNZ1v2aS8BRlSEO4muSXUnto13f4nCcEhwcy7Qs90E+gczjjzQ=
Received: from DB7PR04MB5132.eurprd04.prod.outlook.com (20.176.235.28) by
 DB7PR04MB4459.eurprd04.prod.outlook.com (52.135.137.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.19; Mon, 1 Apr 2019 11:15:21 +0000
Received: from DB7PR04MB5132.eurprd04.prod.outlook.com
 ([fe80::2cac:cc2f:6528:54f7]) by DB7PR04MB5132.eurprd04.prod.outlook.com
 ([fe80::2cac:cc2f:6528:54f7%5]) with mapi id 15.20.1750.021; Mon, 1 Apr 2019
 11:15:21 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH 02/13] soc/fsl/bman: map FBPR area in the iommu
Thread-Topic: [PATCH 02/13] soc/fsl/bman: map FBPR area in the iommu
Thread-Index: AQHU5je+GYAdWERgxkCiU6HsMs84n6YjHN8AgAQMkqA=
Date: Mon, 1 Apr 2019 11:15:21 +0000
Message-ID: <DB7PR04MB513214FB393EF3C514A26F21EC550@DB7PR04MB5132.eurprd04.prod.outlook.com>
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
 <20190329140014.8126-3-laurentiu.tudor@nxp.com>
 <CADRPPNTPZ1xhYr_YKZvrXVJhVqhV9RNAu6ekVHDeOudXTZx3=g@mail.gmail.com>
In-Reply-To: <CADRPPNTPZ1xhYr_YKZvrXVJhVqhV9RNAu6ekVHDeOudXTZx3=g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d2e78c9-430d-416b-cea0-08d6b6935469
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DB7PR04MB4459; 
x-ms-traffictypediagnostic: DB7PR04MB4459:
x-microsoft-antispam-prvs: <DB7PR04MB4459B2A59B8B40169C7920E8EC550@DB7PR04MB4459.eurprd04.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(366004)(13464003)(199004)(189003)(86362001)(97736004)(44832011)(478600001)(81156014)(53936002)(4326008)(76176011)(55016002)(8936002)(9686003)(6246003)(6636002)(8676002)(81166006)(2906002)(71200400001)(71190400001)(68736007)(6862004)(6116002)(14454004)(3846002)(66066001)(6436002)(52536014)(7736002)(33656002)(74316002)(5660300002)(305945005)(54906003)(316002)(256004)(106356001)(26005)(105586002)(561944003)(7696005)(25786009)(6506007)(476003)(486006)(446003)(11346002)(102836004)(186003)(53546011)(229853002)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR04MB4459;
 H:DB7PR04MB5132.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EFS563r0UZW+l0OoMUvXUfcu1bXVamfwcbYSl4UXHyKhn5aZJ6lyzxPObrBmrFdv5GfgzwnbymxyzLTLgENTFlLjeus6hi/0ACv+5C5//db2+g/JDPJNGU9/3C9WKsgz1ZzDP7wMqXwvw+dOuBG6F8qKC+fROIaOhFxEvBY1m6Lmk+D2gvJOV2vLnvDBQTDQzErQ8bkN/LErLgSjpczQlvHqjoqQ3A1wrDPDv5YK1yhf6rZjAo0JLF6ffe362+BYtLPea7GpdHvlTmq4pFV1rVjsNz7hLh0C2seMQv4lIZNiOSvRhCWhMK/lGmUgARvftQBhpysspT1jJKeSaaJjm6KWqgfwWQZ3d/vNepX8aiMnhkVp62l/lUdr2zZtklWMpIQUgc6oQRC8TPbak8iB4vkG7g9fdFRvhmi2jptxxl8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2e78c9-430d-416b-cea0-08d6b6935469
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 11:15:21.1151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4459
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
Cc: Madalin-cristian Bucur <madalin.bucur@nxp.com>,
 Netdev <netdev@vger.kernel.org>, Roy Pledge <roy.pledge@nxp.com>,
 lkml <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Camelia Alexandra Groza <camelia.groza@nxp.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>, "moderated list:ARM/FREESCALE IMX /
 MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgTGVvLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExpIFlhbmcg
W21haWx0bzpsZW95YW5nLmxpQG54cC5jb21dDQo+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMjksIDIw
MTkgMTE6MTYgUE0NCj4gDQo+IE9uIEZyaSwgTWFyIDI5LCAyMDE5IGF0IDk6MDMgQU0gPGxhdXJl
bnRpdS50dWRvckBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IExhdXJlbnRpdSBUdWRv
ciA8bGF1cmVudGl1LnR1ZG9yQG54cC5jb20+DQo+ID4NCj4gPiBBZGQgYSBvbmUtdG8tb25lIGlv
bW11IG1hcHBpbmcgZm9yIGJtYW4gcHJpdmF0ZSBkYXRhIG1lbW9yeSAoRkJQUikuDQo+ID4gVGhp
cyBpcyByZXF1aXJlZCBmb3IgQk1BTiB0byB3b3JrIHdpdGhvdXQgZmF1bHRzIGJlaGluZCBhbiBp
b21tdS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IExhdXJlbnRpdSBUdWRvciA8bGF1cmVudGl1
LnR1ZG9yQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvc29jL2ZzbC9xYm1hbi9ibWFu
X2Njc3IuYyB8IDExICsrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRp
b25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvZnNsL3FibWFuL2JtYW5f
Y2Nzci5jDQo+IGIvZHJpdmVycy9zb2MvZnNsL3FibWFuL2JtYW5fY2Nzci5jDQo+ID4gaW5kZXgg
N2MzY2M5NjgwNTNjLi5iMjA5Yzc5NTExYmIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zb2Mv
ZnNsL3FibWFuL2JtYW5fY2Nzci5jDQo+ID4gKysrIGIvZHJpdmVycy9zb2MvZnNsL3FibWFuL2Jt
YW5fY2Nzci5jDQo+ID4gQEAgLTI5LDYgKzI5LDcgQEANCj4gPiAgICovDQo+ID4NCj4gPiAgI2lu
Y2x1ZGUgImJtYW5fcHJpdi5oIg0KPiA+ICsjaW5jbHVkZSA8bGludXgvaW9tbXUuaD4NCj4gPg0K
PiA+ICB1MTYgYm1hbl9pcF9yZXY7DQo+ID4gIEVYUE9SVF9TWU1CT0woYm1hbl9pcF9yZXYpOw0K
PiA+IEBAIC0xNzgsNiArMTc5LDcgQEAgc3RhdGljIGludCBmc2xfYm1hbl9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiA+ICAgICAgICAgaW50IHJldCwgZXJyX2lycTsN
Cj4gPiAgICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gICAgICAg
ICBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUgPSBkZXYtPm9mX25vZGU7DQo+ID4gKyAgICAgICBz
dHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW47DQo+ID4gICAgICAgICBzdHJ1Y3QgcmVzb3VyY2Ug
KnJlczsNCj4gPiAgICAgICAgIHUxNiBpZCwgYm1fcG9vbF9jbnQ7DQo+ID4gICAgICAgICB1OCBt
YWpvciwgbWlub3I7DQo+ID4gQEAgLTIyNSw2ICsyMjcsMTUgQEAgc3RhdGljIGludCBmc2xfYm1h
bl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiA+DQo+ID4gICAgICAg
ICBkZXZfZGJnKGRldiwgIkFsbG9jYXRlZCBGQlBSIDB4JWxseCAweCV6eFxuIiwgZmJwcl9hLCBm
YnByX3N6KTsNCj4gPg0KPiA+ICsgICAgICAgLyogQ3JlYXRlIGFuIDEtdG8tMSBpb21tdSBtYXBw
aW5nIGZvciBGQlBSIGFyZWEgKi8NCj4gPiArICAgICAgIGRvbWFpbiA9IGlvbW11X2dldF9kb21h
aW5fZm9yX2RldihkZXYpOw0KPiA+ICsgICAgICAgaWYgKGRvbWFpbikgew0KPiA+ICsgICAgICAg
ICAgICAgICByZXQgPSBpb21tdV9tYXAoZG9tYWluLCBmYnByX2EsIGZicHJfYSwgZmJwcl9zeiwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIElPTU1VX1JFQUQgfCBJT01NVV9X
UklURSB8IElPTU1VX0NBQ0hFKTsNCj4gPiArICAgICAgICAgICAgICAgaWYgKHJldCkNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICBkZXZfd2FybihkZXYsICJmYWlsZWQgdG8gaW9tbXVfbWFw
KCkgJWRcbiIsDQo+IHJldCk7DQo+ID4gKyAgICAgICB9DQo+IA0KPiBMaWtlIFJvYmluIGhhcyBw
b2ludGVkIG91dCwgY291bGQgeW91IGV4cGxhaW4gd2h5IHRoZSBtYXBwaW5nIGluIHRoaXMNCj4g
cGF0Y2ggYW5kIG90aGVyIHNpbWlsYXIgcGF0Y2hlcyBjYW5ub3QgYmUgZGVhbHQgd2l0aCB0aGUg
ZG1hIEFQSXMNCj4gYXV0b21hdGljYWxseT8gIElmIHRoZSBjdXJyZW50IGJxbWFuIGRyaXZlciBk
b2Vzbid0IHVzZSB0aGUgZG1hIEFQSXMNCj4gY29ycmVjdGx5LCB3ZSBuZWVkIHRvIGZpeCB0aGF0
IGluc3RlYWQgb2YgZG9pbmcgdGhlIG1hcHBpbmcNCj4gZXhwbGljaXRseS4NCg0KUGxlYXNlIHNl
ZSBteSByZXBseSB0byBSb2Jpbi4NCkFzIGEgc2lkZSBjb21tZW50LCBpZiB3ZSB3YW50IHRvIGNv
bnZlcnQgdG8gZG1hIGFwaSBpdCB3aWxsIGJlIGludGVyZXN0aW5nIHRvIHNlZSBob3cgd2UnbGwg
ZGVhbCB3aXRoIHRoZSBxbWFuIHBvcnRhbCBkZXZpY2VzIGFzIHRoZXkgcmVxdWlyZSBhIHNtbXUg
bWFwcGluZyBmb3IgYW4gYXJlYSBvZiB0aGVpciByZWdpc3RlciBibG9jayAod2hlcmUgc3Rhc2hp
bmcgZ29lcykuIFByb2JsZW0gaXMgdGhleSB0cmVhdGVkIGFzIGRpc3RpbmN0IGRldmljZXMsIHRo
ZSBhZGRyZXNzIHdoZXJlIHRoZXkgc2hvdWxkIGRtYSBjYW5ub3QgYmUgY29uZmlndXJlZCBpbmRl
cGVuZGVudGx5IGZvciBlYWNoIG9uZSBvZiB0aGVtLiBJIHRoaW5rIEkgY2FuIGNhbWUgdXAgd2l0
aCBhIHByb3Bvc2FsIGJ1dCBwcm9iYWJseSB3aWxsIG5vdCBsb29rIHZlcnkgcHJldHR5Lg0KDQot
LS0NCkJlc3QgUmVnYXJkcywgTGF1cmVudGl1DQoNCj4gPiArDQo+ID4gICAgICAgICBibV9zZXRf
bWVtb3J5KGZicHJfYSwgZmJwcl9zeik7DQo+ID4NCj4gPiAgICAgICAgIGVycl9pcnEgPSBwbGF0
Zm9ybV9nZXRfaXJxKHBkZXYsIDApOw0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4NCg==

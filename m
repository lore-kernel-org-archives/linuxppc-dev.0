Return-Path: <SRS0=9RGo=SD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBB0C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 11:06:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB2A20870
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 11:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MG6qxafY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB2A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44XqKm2K8DzDqL4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 22:06:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.7.51; helo=eur04-he1-obe.outbound.protection.outlook.com;
 envelope-from=laurentiu.tudor@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="MG6qxafY"; 
 dkim-atps=neutral
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70051.outbound.protection.outlook.com [40.107.7.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44XqHg0FqjzDqKS
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Apr 2019 22:04:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYVyKEK6+1WtPIyDBln9Z5HfFisec00JLZUQNhfwjxQ=;
 b=MG6qxafYn5PHTAfm9d0mNGPkrFnzoWMaXCJ1bxyg9XHxwakSSBXvDKFeRFHqADxwlfm7iMy4mx6CLWJ7snVC8Z5xXjJY/0xcwj1jriWfbY8P2p8NPwMer5wDxwB10BGFTrOaHS7saxoHxvrUGb7wTgL7mE0zw7IEg5BjiCEUbYY=
Received: from DB7PR04MB5132.eurprd04.prod.outlook.com (20.176.235.28) by
 DB7PR04MB3995.eurprd04.prod.outlook.com (52.134.107.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Mon, 1 Apr 2019 11:04:52 +0000
Received: from DB7PR04MB5132.eurprd04.prod.outlook.com
 ([fe80::2cac:cc2f:6528:54f7]) by DB7PR04MB5132.eurprd04.prod.outlook.com
 ([fe80::2cac:cc2f:6528:54f7%5]) with mapi id 15.20.1750.021; Mon, 1 Apr 2019
 11:04:52 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Robin Murphy <robin.murphy@arm.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Madalin-cristian Bucur <madalin.bucur@nxp.com>, Roy
 Pledge <roy.pledge@nxp.com>, Camelia Alexandra Groza <camelia.groza@nxp.com>, 
 Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH 02/13] soc/fsl/bman: map FBPR area in the iommu
Thread-Topic: [PATCH 02/13] soc/fsl/bman: map FBPR area in the iommu
Thread-Index: AQHU5je+GYAdWERgxkCiU6HsMs84n6YisRcAgAR0QJA=
Date: Mon, 1 Apr 2019 11:04:52 +0000
Message-ID: <DB7PR04MB51324E728B91663DECC6FD87EC550@DB7PR04MB5132.eurprd04.prod.outlook.com>
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
 <20190329140014.8126-3-laurentiu.tudor@nxp.com>
 <b747c418-a495-56e0-c106-a8ec8e82ccb9@arm.com>
In-Reply-To: <b747c418-a495-56e0-c106-a8ec8e82ccb9@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7e866d2-75b0-4142-5a43-08d6b691dddf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DB7PR04MB3995; 
x-ms-traffictypediagnostic: DB7PR04MB3995:
x-microsoft-antispam-prvs: <DB7PR04MB3995F826E4F4A4979C9508EDEC550@DB7PR04MB3995.eurprd04.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(396003)(136003)(39860400002)(376002)(189003)(199004)(13464003)(53546011)(55016002)(102836004)(8676002)(76176011)(6506007)(97736004)(54906003)(110136005)(99286004)(53936002)(305945005)(7736002)(316002)(6636002)(229853002)(5660300002)(66066001)(6436002)(81166006)(106356001)(81156014)(7696005)(26005)(74316002)(9686003)(14454004)(2906002)(6246003)(25786009)(186003)(478600001)(3846002)(105586002)(52536014)(4326008)(71200400001)(71190400001)(6116002)(44832011)(68736007)(11346002)(446003)(86362001)(14444005)(486006)(33656002)(8936002)(476003)(2501003)(256004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR04MB3995;
 H:DB7PR04MB5132.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mcX1jRNZujg9RZBbxK30b0vbva3N7iw2/iB4hdy+nd0VQx5jxm8IThqeko6M/RkXUuvbnDrIW36TtdzOI7pfO84rZJCQqqUeQkmj8kwBdbu7w1wl8riMBHAyTu8n5hhH35yltfjw+BL0IwSEQL8CZ9Dc0ahvTGrQLmj2COXOv8hg1bZEPB6jb+eEm6Jf5WolugOSGmcZj9tzhjrBWMHF7dKJHZW6OlEF5W+TjFCgzGgA1DXydyN6ruYJYl1f82BSE944oW1jwKrHPPC4IJXQzq14SZy62O6MitbNAnb9bgZcbdodVt7f3aW1thwaR+z+nrV/waUIJyfz0C6OzH2Ok1df5b1c9yVKzifzoaiWPdSSh6191W08yQuRobdQvtaQg2tyTs8GcYpM9zKOzBeZw0/GO1rrDsb/Al0VqVXOzyE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e866d2-75b0-4142-5a43-08d6b691dddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 11:04:52.7548 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB3995
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
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "davem@davemloft.net" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgUm9iaW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4g
TXVycGh5IFttYWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IEZyaWRheSwgTWFy
Y2ggMjksIDIwMTkgNDo1MSBQTQ0KPiANCj4gT24gMjkvMDMvMjAxOSAxNDowMCwgbGF1cmVudGl1
LnR1ZG9yQG54cC5jb20gd3JvdGU6DQo+ID4gRnJvbTogTGF1cmVudGl1IFR1ZG9yIDxsYXVyZW50
aXUudHVkb3JAbnhwLmNvbT4NCj4gPg0KPiA+IEFkZCBhIG9uZS10by1vbmUgaW9tbXUgbWFwcGlu
ZyBmb3IgYm1hbiBwcml2YXRlIGRhdGEgbWVtb3J5IChGQlBSKS4NCj4gPiBUaGlzIGlzIHJlcXVp
cmVkIGZvciBCTUFOIHRvIHdvcmsgd2l0aG91dCBmYXVsdHMgYmVoaW5kIGFuIGlvbW11Lg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogTGF1cmVudGl1IFR1ZG9yIDxsYXVyZW50aXUudHVkb3JAbnhw
LmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvc29jL2ZzbC9xYm1hbi9ibWFuX2Njc3IuYyB8
IDExICsrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2ZzbC9xYm1hbi9ibWFuX2Njc3IuYw0K
PiBiL2RyaXZlcnMvc29jL2ZzbC9xYm1hbi9ibWFuX2Njc3IuYw0KPiA+IGluZGV4IDdjM2NjOTY4
MDUzYy4uYjIwOWM3OTUxMWJiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvc29jL2ZzbC9xYm1h
bi9ibWFuX2Njc3IuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL2ZzbC9xYm1hbi9ibWFuX2Njc3Iu
Yw0KPiA+IEBAIC0yOSw2ICsyOSw3IEBADQo+ID4gICAgKi8NCj4gPg0KPiA+ICAgI2luY2x1ZGUg
ImJtYW5fcHJpdi5oIg0KPiA+ICsjaW5jbHVkZSA8bGludXgvaW9tbXUuaD4NCj4gPg0KPiA+ICAg
dTE2IGJtYW5faXBfcmV2Ow0KPiA+ICAgRVhQT1JUX1NZTUJPTChibWFuX2lwX3Jldik7DQo+ID4g
QEAgLTE3OCw2ICsxNzksNyBAQCBzdGF0aWMgaW50IGZzbF9ibWFuX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ID4gICAJaW50IHJldCwgZXJyX2lycTsNCj4gPiAgIAlz
dHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICAgCXN0cnVjdCBkZXZpY2Vfbm9k
ZSAqbm9kZSA9IGRldi0+b2Zfbm9kZTsNCj4gPiArCXN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFp
bjsNCj4gPiAgIAlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCj4gPiAgIAl1MTYgaWQsIGJtX3Bvb2xf
Y250Ow0KPiA+ICAgCXU4IG1ham9yLCBtaW5vcjsNCj4gPiBAQCAtMjI1LDYgKzIyNywxNSBAQCBz
dGF0aWMgaW50IGZzbF9ibWFuX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYp
DQo+ID4NCj4gPiAgIAlkZXZfZGJnKGRldiwgIkFsbG9jYXRlZCBGQlBSIDB4JWxseCAweCV6eFxu
IiwgZmJwcl9hLCBmYnByX3N6KTsNCj4gPg0KPiA+ICsJLyogQ3JlYXRlIGFuIDEtdG8tMSBpb21t
dSBtYXBwaW5nIGZvciBGQlBSIGFyZWEgKi8NCj4gPiArCWRvbWFpbiA9IGlvbW11X2dldF9kb21h
aW5fZm9yX2RldihkZXYpOw0KPiANCj4gSWYgdGhhdCdzIGV4cGVjdGVkIHRvIGJlIHRoZSBkZWZh
dWx0IGRvbWFpbiB0aGF0IHlvdSdyZSBncmFiYmluZywgdGhlbg0KPiB0aGlzIGlzICppbmNyZWRp
Ymx5KiBmcmFnaWxlLiBUaGVyZSdzIG5vdGhpbmcgdG8gc3RvcCB0aGUgSU9WQSB0aGF0IHlvdQ0K
PiBmb3JjaWJseSBtYXAgZnJvbSBiZWluZyBhdXRvbWF0aWNhbGx5IGFsbG9jYXRlZCBsYXRlciBh
bmQgY2F1c2luZyBzb21lDQo+IG90aGVyIERNQSBtYXBwaW5nIHRvIGZhaWwgbm9pc2lseSBhbmQg
dW5leHBlY3RlZGx5LiANCg0KQWdyZWUgaGVyZSwgd2UgcHJldHR5IG11Y2ggcmVseSBvbiBsdWNr
IHdpdGggdGhpcyBpbXBsZW1lbnRhdGlvbi4gQXMgYSBzaWRlIG5vdGUsIEkndmUgYWxzbyBleHBl
cmltZW50ZWQgdXNpbmcgZG1hX21hcF9yZXNvdXJjZSgpIGluc3RlYWQgb2YgZGlyZWN0bHkgY2Fs
bGluZyBpbnRvIGlvbW11IGFwaSBhbmQgdGhpbmdzIHdvcmtlZCBmaW5lLCBidXQgc2VlIGJlbG93
IC4uLg0KDQo+IEZ1cnRoZXJtb3JlLCBoYXZlIHlvdSB0cmllZCB0aGlzIHdpdGggImlvbW11LnBh
c3N0aHJvdWdoPTEiPw0KDQpZZXMuIFRoZSBpb21tdV9tYXAoKSBjYWxscyBmYWlsIGFuZCB0aGUg
ZHJpdmVycyBpc3N1ZSB3YXJuaW5nIG1lc3NhZ2VzLCBidXQgYXBhcnQgZnJvbSB0aGF0IEkgZG9u
J3Qgc2VlIGFueSBpc3N1ZXMuDQoNCj4gVGhhdCBzYWlkLCBJIHJlYWxseSBkb24ndCB1bmRlcnN0
YW5kIHdoYXQncyBnb2luZyBvbiBoZXJlIGFueXdheSA6Lw0KPg0KPiBBcyBmYXIgYXMgSSBjYW4g
dGVsbCBmcm9tIHFibWFuX2luaXRfcHJpdmF0ZV9tZW0oKSwgZmJwcl9hIGNvbWVzIGZyb20NCj4g
ZG1hX2FsbG9jX2NvaGVyZW50KCkgYW5kIHRodXMgd291bGQgYWxyZWFkeSBiZSBhIG1hcHBlZCBJ
T1ZBIC0gaXNuJ3QNCj4gdGhpcyB0aGUgc3R1ZmYgdGhhdCBSb3kgY29udmVydGVkIHRvIG5pY2Vs
eSB1c2Ugc2hhcmVkLWRtYS1wb29sIHJlZ2lvbnMNCj4gYSB3aGlsZSBhZ28/DQoNCkkgbXVzdCBz
YXkgdGhhdCBJJ20gYWxzbyB1bmNsZWFyIG9uIHRoaXMuIFRoZSB0aGluZyBpcyB0aGF0IEkgZG9u
J3QgZ2V0IHRvIHNlZSBhIHNtbXUgbWFwcGluZyBiZWluZyBjcmVhdGVkIGZvciB0aGUgcmVzZXJ2
ZWQgbWVtb3J5IGFzIHJlc3VsdCBvZiBjYWxsaW5nIGRtYV9hbGxvY19jb2hlcmVudCgpLiBJSVJD
LCBhdCB0aGUgdGltZSB3aGVuIEkgbG9va2VkIGF0IHRoaXMgSSBjb25jbHVkZWQgdGhhdCB0aGUg
Y2FsbCB0byBkbWFfYWxsb2NfY29oZXJlbnQoKSBzaW1wbHkgcmV0dXJucyB0aGUgcGh5cyBhZGRy
ZXNzIG9mIHRoZSBkZXZpY2UncyByZXNlcnZlZCBtZW1vcnkgd2l0aG91dCBjcmVhdGluZyBhIHNt
bXUgbWFwcGluZyB0byBiYWNrIGl0IHVwLiBNYXliZSBteSB1bmRlcnN0YW5kaW5nIHdhcyBub3Qg
Y29ycmVjdCBvciBwZXJoYXBzIHRoZXJlJ3MgYW4gaXNzdWUgd2l0aCB0aGlzIHNoYXJlZC1kbWEt
cG9vbCBtZWNoYW5pc20gd2hlcmUgaW5zdGVhZCBvZiBjcmVhdGluZyBhIG1hcHBpbmcgaW4gdGhl
IHNtbXUgYW5kIHJldHVybiBhbiBJT1ZBIGl0IGp1c3QgcmV0dXJucyB0aGUgcGh5c2ljYWwgYWRk
cmVzcyBvZiB0aGUgcmVzZXJ2ZWQgbWVtb3J5IGFyZWEuDQoNCi0tLQ0KVGhhbmtzICYgQmVzdCBS
ZWdhcmRzLCBMYXVyZW50aXUNCg0KPiANCj4gPiArCWlmIChkb21haW4pIHsNCj4gPiArCQlyZXQg
PSBpb21tdV9tYXAoZG9tYWluLCBmYnByX2EsIGZicHJfYSwgZmJwcl9zeiwNCj4gPiArCQkJCUlP
TU1VX1JFQUQgfCBJT01NVV9XUklURSB8IElPTU1VX0NBQ0hFKTsNCj4gPiArCQlpZiAocmV0KQ0K
PiA+ICsJCQlkZXZfd2FybihkZXYsICJmYWlsZWQgdG8gaW9tbXVfbWFwKCkgJWRcbiIsIHJldCk7
DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAgCWJtX3NldF9tZW1vcnkoZmJwcl9hLCBmYnByX3N6KTsN
Cj4gPg0KPiA+ICAgCWVycl9pcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOw0KPiA+DQo=

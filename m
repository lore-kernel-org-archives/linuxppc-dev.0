Return-Path: <yangbo.lu@nxp.com>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0072.outbound.protection.outlook.com [104.47.0.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4116Q70LnbzF2yr
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2018 21:48:44 +1000 (AEST)
From: "Y.b. Lu" <yangbo.lu@nxp.com>
To: Richard Cochran <richardcochran@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Madalin-cristian Bucur
 <madalin.bucur@nxp.com>, Rob Herring <robh+dt@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 09/10] dpaa_eth: add support for hardware timestamping
Date: Wed, 6 Jun 2018 11:48:31 +0000
Message-ID: <DB6PR0401MB2536C69465964BB0BD1A4203F8650@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <20180604070837.19265-1-yangbo.lu@nxp.com>
 <20180604070837.19265-10-yangbo.lu@nxp.com>
 <20180604134920.ezhe6jz5ntpnqyzj@localhost>
 <DB6PR0401MB2536376432EC481473A5B4A3F8660@DB6PR0401MB2536.eurprd04.prod.outlook.com>
 <20180605135748.mlarwiyzf2oe27ax@localhost>
In-Reply-To: <20180605135748.mlarwiyzf2oe27ax@localhost>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SGkgUmljaGFyZCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNo
YXJkIENvY2hyYW4gW21haWx0bzpyaWNoYXJkY29jaHJhbkBnbWFpbC5jb21dDQo+IFNlbnQ6IFR1
ZXNkYXksIEp1bmUgNSwgMjAxOCA5OjU4IFBNDQo+IFRvOiBZLmIuIEx1IDx5YW5nYm8ubHVAbnhw
LmNvbT4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IE1hZGFsaW4tY3Jpc3RpYW4gQnVj
dXINCj4gPG1hZGFsaW4uYnVjdXJAbnhwLmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5l
bC5vcmc+OyBTaGF3biBHdW8NCj4gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBEYXZpZCBTIC4gTWls
bGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAwOS8xMF0gZHBhYV9ldGg6IGFkZCBzdXBwb3J0IGZvciBoYXJkd2FyZSB0aW1l
c3RhbXBpbmcNCj4gDQo+IE9uIFR1ZSwgSnVuIDA1LCAyMDE4IGF0IDAzOjM1OjI4QU0gKzAwMDAs
IFkuYi4gTHUgd3JvdGU6DQo+ID4gW1kuYi4gTHVdIEFjdHVhbGx5IHRoZXNlIHRpbWVzdGFtcGlu
ZyBjb2RlcyBhZmZlY3RlZCBEUEFBIG5ldHdvcmtpbmcNCj4gcGVyZm9ybWFuY2UgaW4gb3VyIHBy
ZXZpb3VzIHBlcmZvcm1hbmNlIHRlc3QuDQo+ID4gVGhhdCdzIHdoeSB3ZSB1c2VkIGlmZGVmIGZv
ciBpdC4NCj4gDQo+IEhvdyBtdWNoIGRvZXMgdGltZSBzdGFtcGluZyBodXJ0IHBlcmZvcm1hbmNl
Pw0KPiANCj4gSWYgdGhlIHRpbWUgc3RhbXBpbmcgaXMgY29tcGlsZWQgaW4gYnV0IG5vdCBlbmFi
bGVkIGF0IHJ1biB0aW1lLCBkb2VzIGl0IHN0aWxsDQo+IGFmZmVjdCBwZXJmb3JtYWNlPw0KDQpb
WS5iLiBMdV0gSSBjYW4ndCByZW1lbWJlciBhbmQgZmluZCB0aGUgb2xkIGRhdGEgc2luY2UgaXQg
aGFkIGJlZW4gYSBsb25nIHRpbWUuDQpJIGp1c3QgZGlkIHRoZSBpcGVyZiB0ZXN0IHRvZGF5IGJl
dHdlZW4gdHdvIDEwRyBwb3J0cy4gSSBkaWRu4oCZdCBzZWUgYW55IHBlcmZvcm1hbmNlIGNoYW5n
ZXMgd2l0aCB0aW1lc3RhbXBpbmcgY29kZSDwn5iKDQpTbywgbGV0J3MgbWUgcmVtb3ZlIHRoZSBp
ZmRlZiBpbiBuZXh0IHZlcnNpb24uDQpUaGFua3MgYSBsb3QuDQoNCg0KPiANCj4gVGhhbmtzLA0K
PiBSaWNoYXJkDQo=

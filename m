Return-Path: <B36685@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
 [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 82DF21007D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2011 14:17:03 +1100 (EST)
From: Liu Shengzhou-B36685 <B36685@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 2/2 v2] mtd/nand: Add ONFI support for FSL NAND controller
Date: Wed, 7 Dec 2011 03:16:53 +0000
Message-ID: <3F453DDFF675A64A89321A1F352810216B074A@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1323161655-19050-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1323161655-19050-2-git-send-email-Shengzhou.Liu@freescale.com>
 <4EDE4E1D.4030408@freescale.com>
In-Reply-To: <4EDE4E1D.4030408@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFdvb2QgU2NvdHQtQjA3NDIx
DQo+IFNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIgMDcsIDIwMTEgMToxNyBBTQ0KPiBUbzogTGl1
IFNoZW5nemhvdS1CMzY2ODUNCj4gQ2M6IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBs
aW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gZHdtdzJAaW5mcmFkZWFkLm9yZzsgR2Fs
YSBLdW1hci1CMTE3ODANCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzIgdjJdIG10ZC9uYW5kOiBB
ZGQgT05GSSBzdXBwb3J0IGZvciBGU0wgTkFORA0KPiBjb250cm9sbGVyDQo+IA0KPiBPbiAxMi8w
Ni8yMDExIDAyOjU0IEFNLCBTaGVuZ3pob3UgTGl1IHdyb3RlOg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL210ZC9uYW5kL2ZzbF9lbGJjX25hbmQuYw0KPiBiL2RyaXZlcnMvbXRkL25hbmQvZnNs
X2VsYmNfbmFuZC5jDQo+ID4gaW5kZXggNGY0MDVhMC4uYjRkYjQwNyAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL210ZC9uYW5kL2ZzbF9lbGJjX25hbmQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbXRk
L25hbmQvZnNsX2VsYmNfbmFuZC5jDQo+ID4gQEAgLTM0OSwxOSArMzQ5LDI0IEBAIHN0YXRpYyB2
b2lkIGZzbF9lbGJjX2NtZGZ1bmMoc3RydWN0IG10ZF9pbmZvICptdGQsDQo+IHVuc2lnbmVkIGlu
dCBjb21tYW5kLA0KPiA+ICAJCWZzbF9lbGJjX3J1bl9jb21tYW5kKG10ZCk7DQo+ID4gIAkJcmV0
dXJuOw0KPiA+DQo+ID4gLQkvKiBSRUFESUQgbXVzdCByZWFkIGFsbCA1IHBvc3NpYmxlIGJ5dGVz
IHdoaWxlIENFQiBpcyBhY3RpdmUgKi8NCj4gPiAgCWNhc2UgTkFORF9DTURfUkVBRElEOg0KPiA+
IC0JCWRldl92ZGJnKHByaXYtPmRldiwgImZzbF9lbGJjX2NtZGZ1bmM6IE5BTkRfQ01EX1JFQURJ
RC5cbiIpOw0KPiA+ICsJY2FzZSBOQU5EX0NNRF9QQVJBTToNCj4gPiArCQlkZXZfdmRiZyhwcml2
LT5kZXYsICJmc2xfZWxiY19jbWRmdW5jOiBOQU5EX0NNRCAleFxuIiwNCj4gY29tbWFuZCk7DQo+
ID4NCj4gPiAgCQlvdXRfYmUzMigmbGJjLT5maXIsIChGSVJfT1BfQ00wIDw8IEZJUl9PUDBfU0hJ
RlQpIHwNCj4gPiAgCQkgICAgICAgICAgICAgICAgICAgIChGSVJfT1BfVUEgIDw8IEZJUl9PUDFf
U0hJRlQpIHwNCj4gPiAgCQkgICAgICAgICAgICAgICAgICAgIChGSVJfT1BfUkJXIDw8IEZJUl9P
UDJfU0hJRlQpKTsNCj4gPiAtCQlvdXRfYmUzMigmbGJjLT5mY3IsIE5BTkRfQ01EX1JFQURJRCA8
PCBGQ1JfQ01EMF9TSElGVCk7DQo+ID4gLQkJLyogbmFuZF9nZXRfZmxhc2hfdHlwZSgpIHJlYWRz
IDggYnl0ZXMgb2YgZW50aXJlIElEIHN0cmluZyAqLw0KPiA+IC0JCW91dF9iZTMyKCZsYmMtPmZi
Y3IsIDgpOw0KPiA+IC0JCWVsYmNfZmNtX2N0cmwtPnJlYWRfYnl0ZXMgPSA4Ow0KPiA+ICsJCW91
dF9iZTMyKCZsYmMtPmZjciwgY29tbWFuZCA8PCBGQ1JfQ01EMF9TSElGVCk7DQo+ID4gKwkJLyog
cmVhZHMgOCBieXRlcyBvZiBlbnRpcmUgSUQgc3RyaW5nICovDQo+ID4gKwkJaWYgKE5BTkRfQ01E
X1JFQURJRCA9PSBjb21tYW5kKSB7DQo+IA0KPiBpZiAoY29tbWFuZCA9PSBOQU5EX0NNRF9SRUFE
SUQpIHsNCj4gDQo+ID4gKwkJCW91dF9iZTMyKCZsYmMtPmZiY3IsIDgpOw0KPiA+ICsJCQllbGJj
X2ZjbV9jdHJsLT5yZWFkX2J5dGVzID0gODsNCj4gPiArCQl9IGVsc2Ugew0KPiA+ICsJCQlvdXRf
YmUzMigmbGJjLT5mYmNyLCAyNTYpOw0KPiA+ICsJCQllbGJjX2ZjbV9jdHJsLT5yZWFkX2J5dGVz
ID0gMjU2Ow0KPiA+ICsJCX0NCj4gDQo+IEFueSBoYXJtIGluIGFsd2F5cyB1c2luZyAyNTY/DQo+
IA0KPiAtU2NvdHQNCltTaGVuZ3pob3VdIEZvciBOQU5EX0NNRF9SRUFESUQgY29tbWFuZCwgdGhl
IHRvdGFsIGJ5dGVzIG9mIGVudGlyZSBJRCBzdHJpbmcgYXJlIDgsIHRoZXJlIGFyZSBub3QgMjU2
IGJ5dGVzIHNvIG1hbnksIGl0J3MgdW5uZWNlc3NhcnkgYW5kIGxvb2tzIG5vdCBzbyB3ZWxsIGxv
Z2ljYWxseSB0byBhbHdheXMgdXNpbmcgMjU2LCB0aG91Z2ggaXQgd29ya3MuDQoNCg0K

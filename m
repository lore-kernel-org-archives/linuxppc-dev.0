Return-Path: <r58472@freescale.com>
Received: from TX2EHSOBE010.bigfish.com (tx2ehsobe005.messaging.microsoft.com
 [65.55.88.15]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 8653E1007D7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 18:37:27 +1100 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: Liu Shuo-B35362 <B35362@freescale.com>, "dwmw2@infradead.org"
 <dwmw2@infradead.org>, "Artem.Bityutskiy@nokia.com"
 <Artem.Bityutskiy@nokia.com>, Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 3/3] mtd/nand : workaround for Freescale FCM to support
 large-page Nand chip
Date: Thu, 24 Nov 2011 07:37:21 +0000
Message-ID: <3F607A5180246847A760FD34122A1E052DC4CD@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1322095306-13156-1-git-send-email-b35362@freescale.com>
 <1322095306-13156-3-git-send-email-b35362@freescale.com>
In-Reply-To: <1322095306-13156-3-git-send-email-b35362@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiBTdWJqZWN0OiBbUEFUQ0ggMy8zXSBtdGQvbmFuZCA6IHdvcmthcm91bmQgZm9yIEZyZWVzY2Fs
ZSBGQ00gdG8gc3VwcG9ydA0KPiBsYXJnZS1wYWdlIE5hbmQgY2hpcA0KPiANCj4gRnJvbTogTGl1
IFNodW8gPGIzNTM2MkBmcmVlc2NhbGUuY29tPg0KPiANCj4gRnJlZXNjYWxlIEZDTSBjb250cm9s
bGVyIGhhcyBhIDJLIHNpemUgbGltaXRhdGlvbiBvZiBidWZmZXIgUkFNLiBJbiBvcmRlcg0KPiB0
byBzdXBwb3J0IHRoZSBOYW5kIGZsYXNoIGNoaXAgd2hvc2UgcGFnZSBzaXplIGlzIGxhcmdlciB0
aGFuIDJLIGJ5dGVzLA0KPiB3ZSByZWFkL3dyaXRlIDJrIGRhdGEgcmVwZWF0ZWRseSBieSBpc3N1
aW5nIEZJUl9PUF9SQi9GSVJfT1BfV0IgYW5kIHNhdmUNCj4gdGhlbSB0byBhIGxhcmdlIGJ1ZmZl
ci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExpdSBTaHVvIDxiMzUzNjJAZnJlZXNjYWxlLmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogTGkgWWFuZyA8bGVvbGlAZnJlZXNjYWxlLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL210ZC9uYW5kL2ZzbF9lbGJjX25hbmQuYyB8ICAyMTENCj4gKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0NCj4gIDEgZmlsZXMgY2hhbmdlZCwgMTk0IGluc2Vy
dGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRk
L25hbmQvZnNsX2VsYmNfbmFuZC5jIGIvZHJpdmVycy9tdGQvbmFuZC9mc2xfZWxiY19uYW5kLmMN
Cj4gaW5kZXggZDYzNGM1Zi4uYzk2ZTcxNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvbmFu
ZC9mc2xfZWxiY19uYW5kLmMNCj4gKysrIGIvZHJpdmVycy9tdGQvbmFuZC9mc2xfZWxiY19uYW5k
LmMNCg0KW3NuaXBdDQoNCj4gK3N0YXRpYyB2b2lkIGlvX3RvX2J1ZmZlcihzdHJ1Y3QgbXRkX2lu
Zm8gKm10ZCwgaW50IHN1YnBhZ2UsIGludCBvb2IpDQo+ICt7DQo+ICsJc3RydWN0IG5hbmRfY2hp
cCAqY2hpcCA9IG10ZC0+cHJpdjsNCj4gKwlzdHJ1Y3QgZnNsX2VsYmNfbXRkICpwcml2ID0gY2hp
cC0+cHJpdjsNCj4gKwlzdHJ1Y3QgZnNsX2VsYmNfZmNtX2N0cmwgKmVsYmNfZmNtX2N0cmwgPSBw
cml2LT5jdHJsLT5uYW5kOw0KPiArCXZvaWQgKnNyYywgKmRzdDsNCj4gKwlpbnQgbGVuID0gKG9v
YiA/IDY0IDogMjA0OCk7DQo+ICsNCj4gKwlpZiAob29iKQ0KPiArCQlkc3QgPSBlbGJjX2ZjbV9j
dHJsLT5idWZmZXIgKyBtdGQtPndyaXRlc2l6ZSArIHN1YnBhZ2UgKiA2NDsNCj4gKwllbHNlDQo+
ICsJCWRzdCA9IGVsYmNfZmNtX2N0cmwtPmJ1ZmZlciArIHN1YnBhZ2UgKiAyMDQ4Ow0KPiArDQo+
ICsJc3JjID0gZWxiY19mY21fY3RybC0+YWRkciArIChvb2IgPyAyMDQ4IDogMCk7DQo+ICsJbWVt
Y3B5X2Zyb21pbyhkc3QsIHNyYywgbGVuKTsNCg0KTWlnaHQgYmUgc2FmZXIgdG8gdXNlIF9tZW1j
cHlfZnJvbWlvKCkNCg0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBidWZmZXJfdG9faW8oc3Ry
dWN0IG10ZF9pbmZvICptdGQsIGludCBzdWJwYWdlLCBpbnQgb29iKQ0KPiArew0KPiArCXN0cnVj
dCBuYW5kX2NoaXAgKmNoaXAgPSBtdGQtPnByaXY7DQo+ICsJc3RydWN0IGZzbF9lbGJjX210ZCAq
cHJpdiA9IGNoaXAtPnByaXY7DQo+ICsJc3RydWN0IGZzbF9lbGJjX2ZjbV9jdHJsICplbGJjX2Zj
bV9jdHJsID0gcHJpdi0+Y3RybC0+bmFuZDsNCj4gKwl2b2lkICpzcmMsICpkc3Q7DQo+ICsJaW50
IGxlbiA9IChvb2IgPyA2NCA6IDIwNDgpOw0KPiArDQo+ICsJaWYgKG9vYikNCj4gKwkJc3JjID0g
ZWxiY19mY21fY3RybC0+YnVmZmVyICsgbXRkLT53cml0ZXNpemUgKyBzdWJwYWdlICogNjQ7DQo+
ICsJZWxzZQ0KPiArCQlzcmMgPSBlbGJjX2ZjbV9jdHJsLT5idWZmZXIgKyBzdWJwYWdlICogMjA0
ODsNCj4gKw0KPiArCWRzdCA9IGVsYmNfZmNtX2N0cmwtPmFkZHIgKyAob29iID8gMjA0OCA6IDAp
Ow0KPiArCW1lbWNweV90b2lvKGRzdCwgc3JjLCBsZW4pOw0KPiArDQo+ICsJLyogU2VlIHRoZSBp
bl84KCkgaW4gZnNsX2VsYmNfd3JpdGVfYnVmKCkgKi8NCj4gKwlpbl84KGVsYmNfZmNtX2N0cmwt
PmFkZHIpOw0KDQpTaG91bGQgYmUgc2FmZXIgdG8gcmVhZCBiYWNrIHRoZSBsYXN0IGNoYXIuDQoN
Ci0gTGVvDQo=

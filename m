Return-Path: <B36685@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D12D92C0790
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2012 16:36:24 +1000 (EST)
From: Liu Shengzhou-B36685 <B36685@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH] PCI: use dev->irq instead of dev->pin to enable non
 MSI/INTx interrupt
Date: Wed, 18 Jul 2012 06:36:14 +0000
Message-ID: <3F453DDFF675A64A89321A1F35281021770F9B@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1342492551-13766-1-git-send-email-Shengzhou.Liu@freescale.com>
 <5005A3D2.5060504@freescale.com>
In-Reply-To: <5005A3D2.5060504@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFdvb2QgU2NvdHQtQjA3NDIx
DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAxOCwgMjAxMiAxOjQyIEFNDQo+IFRvOiBMaXUgU2hl
bmd6aG91LUIzNjY4NQ0KPiBDYzogYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbGludXgtcGNpQHZnZXIu
a2VybmVsLm9yZzsgbGludXhwcGMtDQo+IGRldkBsaXN0cy5vemxhYnMub3JnDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdIFBDSTogdXNlIGRldi0+aXJxIGluc3RlYWQgb2YgZGV2LT5waW4gdG8gZW5h
YmxlIG5vbg0KPiBNU0kvSU5UeCBpbnRlcnJ1cHQNCj4gDQo+IE9uIDA3LzE2LzIwMTIgMDk6MzUg
UE0sIFNoZW5nemhvdSBMaXUgd3JvdGU6DQo+ID4gT24gc29tZSBwbGF0Zm9ybXMsIHJvb3QgcG9y
dCBoYXMgbmVpdGhlciBNU0kvTVNJLVggbm9yIElOVHggaW50ZXJydXB0DQo+ID4gZ2VuZXJhdGVk
IGluIFJDIG1vZGUuIEluIHRoaXMgY2FzZSwgd2UgaGF2ZSB0byB1c2Ugb3RoZXIgaW50ZXJydXB0
KGkuZS4NCj4gPiBzeXN0ZW0gc2hhcmVkIGludGVycnVwdCkgZm9yIHBvcnQgc2VydmljZSBpcnEg
dG8gaGF2ZSBBRVIsIEhvdC1wbHVnLA0KPiA+IGV0Yywgc2VydmljZXMgdG8gd29yay4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFNoZW5nemhvdSBMaXUgPFNoZW5nemhvdS5MaXVAZnJlZXNjYWxl
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvcGNpZS9wb3J0ZHJ2X2NvcmUuYyB8ICAg
IDkgKysrKysrKy0tDQo+ID4gIDEgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaWUvcG9ydGRy
dl9jb3JlLmMNCj4gPiBiL2RyaXZlcnMvcGNpL3BjaWUvcG9ydGRydl9jb3JlLmMgaW5kZXggNzU5
MTViMy4uYTg1NTI1NCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9wY2llL3BvcnRkcnZf
Y29yZS5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvcGNpZS9wb3J0ZHJ2X2NvcmUuYw0KPiA+IEBA
IC0yMTIsOCArMjEyLDEzIEBAIHN0YXRpYyBpbnQgaW5pdF9zZXJ2aWNlX2lycXMoc3RydWN0IHBj
aV9kZXYgKmRldiwgaW50DQo+ICppcnFzLCBpbnQgbWFzaykNCj4gPiAgCWlmICghcGNpZV9wb3J0
X2VuYWJsZV9tc2l4KGRldiwgaXJxcywgbWFzaykpDQo+ID4gIAkJcmV0dXJuIDA7DQo+ID4NCj4g
PiAtCS8qIFdlJ3JlIG5vdCBnb2luZyB0byB1c2UgTVNJLVgsIHNvIHRyeSBNU0kgYW5kIGZhbGwg
YmFjayB0byBJTlR4ICovDQo+ID4gLQlpZiAoIXBjaV9lbmFibGVfbXNpKGRldikgfHwgZGV2LT5w
aW4pDQo+ID4gKwkvKg0KPiA+ICsJICogV2UncmUgbm90IGdvaW5nIHRvIHVzZSBNU0ktWCwgc28g
dHJ5IE1TSSBhbmQgZmFsbCBiYWNrIHRvIElOVHguDQo+ID4gKwkgKiBJZiBuZWl0aGVyIE1TSS9N
U0ktWCBub3IgSU5UeCBhdmFpbGFibGUsIHRyeSBvdGhlciBpbnRlcnJ1cHQuIChPbg0KPiA+ICsJ
ICogc29tZSBwbGF0Zm9ybXMsIHJvb3QgcG9ydCBkb2Vzbid0IHN1cHBvcnQgZ2VuZXJhdGluZyBN
U0kvTVNJLVgvSU5UeA0KPiA+ICsJICogaW4gUkMgbW9kZSkNCj4gPiArCSAqLw0KPiA+ICsJaWYg
KCFwY2lfZW5hYmxlX21zaShkZXYpIHx8IGRldi0+aXJxKQ0KPiA+ICAJCWlycSA9IGRldi0+aXJx
Ow0KPiANCj4gV2hhdCBhYm91dCB0aGUgb3RoZXIgdXNhZ2Ugb2YgZGV2LT5waW4gYSBmZXcgbGlu
ZXMgdXA/DQo+IA0KPiAtU2NvdHQNClllcywgaXQgc2hvdWxkIGJlIGNvbnNpc3RlbnQgd2l0aCBi
b3R0b20sIGRvbmUgaW4gdjIuDQpUaGFua3MsDQpTaGVuZ3pob3UNCg==

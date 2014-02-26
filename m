Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0242.outbound.protection.outlook.com [207.46.163.242])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 210352C009F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 14:26:20 +1100 (EST)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [rtc-linux] [PATCH] rtc/ds3232: Enable ds3232 to work as wakeup
 source
Date: Wed, 26 Feb 2014 03:26:13 +0000
Message-ID: <c10089db611947fbabdad33c7d921e02@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1390281891-9632-1-git-send-email-dongsheng.wang@freescale.com>
 <20140225140705.fe9f7038bbffbfbde899e0f7@linux-foundation.org>
 <3eba8b896e624b698ab8291399c5a1b0@BN1PR03MB188.namprd03.prod.outlook.com>
 <1393384830.6733.987.camel@snotra.buserror.net>
In-Reply-To: <1393384830.6733.987.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "a.zummo@towertech.it" <a.zummo@towertech.it>,
 "chenhui.zhao@freescale.com" <chenhui.zhao@freescale.com>,
 "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAyNiwgMjAxNCAxMToyMSBBTQ0KPiBUbzog
V2FuZyBEb25nc2hlbmctQjQwNTM0DQo+IENjOiBBbmRyZXcgTW9ydG9uOyBydGMtbGludXhAZ29v
Z2xlZ3JvdXBzLmNvbTsgYmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnOw0KPiBhLnp1bW1vQHRvd2Vy
dGVjaC5pdDsgWmhhbyBDaGVuaHVpLUIzNTMzNjsgbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5v
cmcNCj4gU3ViamVjdDogUmU6IFtydGMtbGludXhdIFtQQVRDSF0gcnRjL2RzMzIzMjogRW5hYmxl
IGRzMzIzMiB0byB3b3JrIGFzIHdha2V1cA0KPiBzb3VyY2UNCj4gDQo+IE9uIFR1ZSwgMjAxNC0w
Mi0yNSBhdCAyMTowOSAtMDYwMCwgV2FuZyBEb25nc2hlbmctQjQwNTM0IHdyb3RlOg0KPiA+DQo+
ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQW5kcmV3IE1vcnRv
biBbbWFpbHRvOmFrcG1AbGludXgtZm91bmRhdGlvbi5vcmddDQo+ID4gPiBTZW50OiBXZWRuZXNk
YXksIEZlYnJ1YXJ5IDI2LCAyMDE0IDY6MDcgQU0NCj4gPiA+IFRvOiBydGMtbGludXhAZ29vZ2xl
Z3JvdXBzLmNvbQ0KPiA+ID4gQ2M6IFdhbmcgRG9uZ3NoZW5nLUI0MDUzNDsgYS56dW1tb0B0b3dl
cnRlY2guaXQ7IFpoYW8gQ2hlbmh1aS1CMzUzMzY7DQo+IGxpbnV4cHBjLQ0KPiA+ID4gZGV2QGxp
c3RzLm96bGFicy5vcmcNCj4gPiA+IFN1YmplY3Q6IFJlOiBbcnRjLWxpbnV4XSBbUEFUQ0hdIHJ0
Yy9kczMyMzI6IEVuYWJsZSBkczMyMzIgdG8gd29yayBhcyB3YWtldXANCj4gPiA+IHNvdXJjZQ0K
PiA+ID4NCj4gPiA+IE9uIFR1ZSwgMjEgSmFuIDIwMTQgMTM6MjQ6NTEgKzA4MDAgRG9uZ3NoZW5n
IFdhbmcNCj4gPGRvbmdzaGVuZy53YW5nQGZyZWVzY2FsZS5jb20+DQo+ID4gPiB3cm90ZToNCj4g
PiA+DQo+ID4gPiA+ICsJaWYgKGNsaWVudC0+aXJxICE9IE5PX0lSUSkgew0KPiA+ID4NCj4gPiA+
IHg4Nl82NCBhbGxtb2Rjb25maWc6DQo+ID4gPg0KPiA+ID4gZHJpdmVycy9ydGMvcnRjLWRzMzIz
Mi5jOiBJbiBmdW5jdGlvbiAnZHMzMjMyX3Byb2JlJzoNCj4gPiA+IGRyaXZlcnMvcnRjL3J0Yy1k
czMyMzIuYzo0Mjc6IGVycm9yOiAnTk9fSVJRJyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhp
cw0KPiA+ID4gZnVuY3Rpb24pDQo+ID4gPiBkcml2ZXJzL3J0Yy9ydGMtZHMzMjMyLmM6NDI3OiBl
cnJvcjogKEVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlzIHJlcG9ydGVkDQo+ID4gPiBvbmx5
IG9uY2UNCj4gPiA+IGRyaXZlcnMvcnRjL3J0Yy1kczMyMzIuYzo0Mjc6IGVycm9yOiBmb3IgZWFj
aCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluLikNCj4gPiA+DQo+ID4gPiBOb3QgYWxsIGFyY2hpdGVj
dHVyZXMgaW1wbGVtZW50IE5PX0lSUS4NCj4gPiA+DQo+ID4gPiBJIHRoaW5rIHRoaXMgc2hvdWxk
IGJlDQo+ID4gPg0KPiA+ID4gCWlmIChjbGllbnQtPmlycSA+IDApIHsNCj4gPiA+DQo+ID4gPiBi
dXQgSSdtIG5vdCBzdXJlIC0gaWlyYywgeDg2IChhdCBsZWFzdCkgdHJlYXRzIHplcm8gYXMgIm5v
dCBhbiBJUlEiLg0KPiA+ID4gQnV0IEkgdGhpbmsgc29tZSBhcmNoaXRlY3R1cmVzIHBlcm1pdCBJ
UlEgMC4gIFRoZXJlIHdhcyBkaXNjdXNzaW9uIG1hbnkNCj4gPiA+IHllYXJzIGFnbyBidXQgSSBk
b24ndCB0aGluayBhbnl0aGluZyBnb3QgcmVzb2x2ZWQuDQo+ID4gPg0KPiA+IEkgdGhpbmsgdGhp
cyBpcyB3aHkgTk9fSVJRIGlzIGRlZmluZWQgaW4ga2VybmVsLCB0aGF0IHNob3VsZCBiZSByZXNv
bHZlZCB0aGlzDQo+IGlzc3VlLg0KPiA+DQo+ID4gU29ycnksIEkgZG9uJ3Qga25vdyB3aHkgc29t
ZSBhcmNoaXRlY3R1cmVzIGRpZG4ndCBkZWZpbmUgdGhpcyBtYWNybz8NCj4gDQo+IE5PX0lSUSBp
cyBkZXByZWNhdGVkIChzZWUgImdpdCBsb2cgLVNOT19JUlEiIGZvciB0aGUgdHJlbmQgb2YgcmVt
b3ZpbmcNCj4gdXNlcyBvZiBpdCwgYXMgd2VsbCBhcyBzaXR1YXRpb25zIHdoZXJlIGl0IGdpdmVz
IHRoZSB3cm9uZyByZXN1bHRzKS4NCj4gImlmIChjbGllbnQtPmlycSA+IDApIiBpcyBjb3JyZWN0
Lg0KPiANClRoYW5rcy4NCg0KLURvbmdzaGVuZw0KDQo+IC1TY290dA0KPiANCg0K

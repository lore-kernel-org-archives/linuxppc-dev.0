Return-Path: <Gang.Liu@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0146.outbound.protection.outlook.com [65.55.169.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 784611A01A9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 13:52:54 +1000 (EST)
From: "Gang.Liu@freescale.com" <Gang.Liu@freescale.com>
To: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>, Scott Wood
 <scottwood@freescale.com>
Subject: RE: [PATCH] fsl-rio: add support for mapping inbound windows
Date: Wed, 17 Sep 2014 03:37:04 +0000
Message-ID: <ceb96583f1a64e5d99326b1c391a4cbe@CY1PR0301MB0666.namprd03.prod.outlook.com>
References: <1407246752-21639-1-git-send-email-martijn.de.gouw@prodrive-technologies.com>
 <1407274663.7427.7.camel@snotra.buserror.net>
 <53E9D4C0.5030203@prodrive-technologies.com>
In-Reply-To: <53E9D4C0.5030203@prodrive-technologies.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "Alexandre.Bounine@idt.com" <Alexandre.Bounine@idt.com>,
 "Barry.Wood@idt.com" <Barry.Wood@idt.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "stef.van.os@prodrive-technologies.com"
 <stef.van.os@prodrive-technologies.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SXQgbG9va3MgZ29vZCBmb3IgbWUuDQoNCkxpdSBHYW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogTWFydGlqbiBkZSBHb3V3IFttYWlsdG86bWFydGlqbi5kZS5nb3V3
QHByb2RyaXZlLXRlY2hub2xvZ2llcy5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAxMiwg
MjAxNCA0OjQ4IFBNDQo+IFRvOiBXb29kIFNjb3R0LUIwNzQyMQ0KPiBDYzogbGludXhwcGMtZGV2
QGxpc3RzLm96bGFicy5vcmc7IEFsZXhhbmRyZS5Cb3VuaW5lQGlkdC5jb207DQo+IHN0ZWYudmFu
Lm9zQHByb2RyaXZlLXRlY2hub2xvZ2llcy5jb207IEJhcnJ5Lldvb2RAaWR0LmNvbTsgTGl1IEdh
bmctDQo+IEIzNDE4Mg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBmc2wtcmlvOiBhZGQgc3VwcG9y
dCBmb3IgbWFwcGluZyBpbmJvdW5kIHdpbmRvd3MNCj4gDQo+IE9uIDA4LzA1LzIwMTQgMTE6Mzcg
UE0sIFNjb3R0IFdvb2Qgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDE0LTA4LTA1IGF0IDE1OjUyICsw
MjAwLCBNYXJ0aWpuIGRlIEdvdXcgd3JvdGU6DQo+ID4+IEFkZCBzdXBwb3J0IGZvciBtYXBwaW5n
IGFuZCB1bm1hcHBpbmcgb2YgaW5ib3VuZCByYXBpZGlvIHdpbmRvd3MuDQo+ID4+DQo+ID4+IFNp
Z25lZC1vZmYtYnk6IE1hcnRpam4gZGUgR291dw0KPiA+PiA8bWFydGlqbi5kZS5nb3V3QHByb2Ry
aXZlLXRlY2hub2xvZ2llcy5jb20+DQo+ID4NCj4gPiBDb3VsZCB5b3UgZWxhYm9yYXRlIGluIHRo
ZSBjaGFuZ2Vsb2cgb24gd2hhdCB0aGlzIGZpeGVzIG9yIG1ha2VzDQo+ID4gcG9zc2libGU/ICBF
LmcuIGRpZCB0aGUgZHJpdmVyIHByZXZpb3VzbHkgbm90IHN1cHBvcnQgaW5ib3VuZA0KPiA+IHRy
YW5zYWN0aW9ucyBhdCBhbGwsIG9yIGRpZCBpdCBhc3N1bWUgdGhlIHdpbmRvdyB3YXMgc2V0IHVw
IGJ5IGENCj4gPiBib290bG9hZGVyPw0KPiANCj4gU29tZXRoaW5nIGxpa2U6DQo+IA0KPiBmc2wt
cmlvOiBhZGQgc3VwcG9ydCBmb3IgbWFwcGluZyBpbmJvdW5kIHdpbmRvd3MNCj4gDQo+ICAgICAg
QWRkIHN1cHBvcnQgZm9yIG1hcHBpbmcgYW5kIHVubWFwcGluZyBvZiBpbmJvdW5kIHJhcGlkaW8g
d2luZG93cy4NCj4gICAgICBUaGlzIGFsbG93cyBmb3IgZHJpdmVycyB0byBvcGVuIHVwIGEgcGFy
dCBvZiBsb2NhbCBtZW1vcnkgb24gdGhlDQo+ICAgICAgcmFwaWRpbyBuZXR3b3JrLiBBbHNvIGFw
cGxpY2F0aW9ucyBjYW4gdXNlIHRoaXMgYW5kIHRyYW5mZXIgYmxvY2tzDQo+ICAgICAgb2YgZGF0
YSBvdmVyIHRoZSBuZXR3b3JrLg0KPiANCj4gPg0KPiA+IExpdSBHYW5nLCBjb3VsZCB5b3UgcmV2
aWV3IHRoaXM/DQo+IA0KPiBJJ2xsIHdhaXQgZm9yIHRoZSByZXZpZXcgYmVmb3JlIEkgcG9zdCBh
IG5ldyB2ZXJzaW9uLg0KPiANCj4gR3IsIE1hcnRpam4NCj4gDQo+IA0KPiAtLQ0KPiBNYXJ0aWpu
IGRlIEdvdXcNCj4gRW5naW5lZXINCj4gUHJvZHJpdmUgVGVjaG5vbG9naWVzIEIuVi4NCj4gTW9i
aWxlOiArMzEgNjMgMTcgNzYgMTYxDQo+IFBob25lOiAgKzMxIDQwIDI2IDc2IDIwMA0K

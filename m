Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wTqTj2fFCzDqbx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 May 2017 00:01:12 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Arnd Bergmann' <arnd@arndb.de>, Chris Packham
 <Chris.Packham@alliedtelesis.co.nz>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "mchehab@kernel.org" <mchehab@kernel.org>, Borislav Petkov <bp@alien8.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH 3/3] EDAC: mv64x60: replace in_le32/out_le32 with
 ioread32/iowrite32
Date: Fri, 19 May 2017 14:01:04 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFFFAB9B@AcuExch.aculab.com>
References: <20170512042002.18524-1-chris.packham@alliedtelesis.co.nz>
 <20170512042002.18524-4-chris.packham@alliedtelesis.co.nz>
 <20170517181021.yfctrok7f25d5bu5@pd.tnic>
 <7c7bfec63342409ebd58913836a0739a@svr-chch-ex1.atlnz.lc>
 <CAK8P3a0BFBJhDmS5r3O_x8d8Ws18vxresaULPBoN3JX49_LT3g@mail.gmail.com>
In-Reply-To: <CAK8P3a0BFBJhDmS5r3O_x8d8Ws18vxresaULPBoN3JX49_LT3g@mail.gmail.com>
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

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAxNyBNYXkgMjAxNyAyMjo0MA0KPiANCj4gT24g
V2VkLCBNYXkgMTcsIDIwMTcgYXQgMTE6MTYgUE0sIENocmlzIFBhY2toYW0NCj4gPENocmlzLlBh
Y2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4gd3JvdGU6DQo+ID4gT24gMTgvMDUvMTcgMDY6MTgs
IEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gPiBPbmUgdGhpbmcgSSB3b3VsZCBsaWtlIGNvbmZp
cm1hdGlvbiBvbiBpcyBpcyBpbl9sZTMyIC0+IGlvcmVhZDMyIHRoZQ0KPiA+IGNvcnJlY3QgY2hh
bmdlPyBJIHRvc3NlZCB1cCBiZXR3ZWVuIGlvcmVhZDMyIGFuZCByZWFkbC4gTG9va2luZyBhdA0K
PiA+IG12NjQzeHhfZXRoLmMgd2hpY2ggc3VwcG9ydHMgYm90aCB0aGUgTVY2NDNYWCBhbmQgT3Jp
b24gaXQncyB1c2luZyByZWFkbA0KPiA+IHNvIHBlcmhhcHMgSSBzaG91bGQgYmUgdXNpbmcgdGhh
dC4NCj4gDQo+IFRoZXJlIGlzIG5vIGVhc3kgYW5zd2VyOiBvbiBwb3dlcnBjLCByZWFkbCBpcyB1
c2VkIGZvciBQQ0ksDQo+IHdoaWxlIGluX2xlMzIgaXMgdXNlZCBmb3Igb24tY2hpcCBkZXZpY2Vz
LCBzbyBpbl9sZTMyIGlzIHRoZQ0KPiByaWdodCBvbmUgaW4gcHJpbmNpcGxlLiBUaGUgbWFpbiBk
aWZmZXJlbmNlIGlzIHRoYXQgcmVhZGwgY2FuDQo+IHdvcmsgd2l0aCBDT05GSUdfRUVIIG9uIHBz
ZXJpZXMsIGJ1dCBpbl9sZTMyIGlzIGNoZWFwZXIuDQo+IA0KPiBPbiBBUk0gYW5kIG1vc3Qgb3Ro
ZXIgYXJjaGl0ZWN0dXJlcywgcmVhZGwgaXMgdXNlZCBmb3IgYm90aA0KPiBQQ0kgYW5kIG9uLWNo
aXAgZGV2aWNlcywgc28gdGhhdCdzIHdoYXQgcG9ydGFibGUgY29kZSB0ZW5kcw0KPiB0byB1c2Uu
DQo+IA0KPiBpb3JlYWQzMiBpcyByZXF1aXJlZCB0byBiZWhhdmUgdGhlIHNhbWUgd2F5IGFzIHJl
YWRsDQo+IG9uIGFsbCBfX2lvbWVtIHBvaW50ZXJzIHJldHVybmVkIGZyb20gaW9yZW1hcCgpLCBi
dXQNCj4gaXMgYW4gZXh0ZXJuIGZ1bmN0aW9uIG9uIHBvd2VycGMgYW5kIGNhbiBiZSBtb3JlDQo+
IGV4cGVuc2l2ZSB3aGVuIENPTkZJR19HRU5FUklDX0lPTUFQIGlzIHNldC4NCg0KV2hhdCBhYm91
dCB4ODY/DQpJc24ndCBpb3JlYWQzMigpIGFuIGV4dGVybiBmdW5jdGlvbiB0aGF0IGNoZWNrcyBm
b3IgJ2lvJyBhZGRyZXNzZXMNCnRoYW4gbmVlZCAnaW5iJyAoZXRjKSBpbnN0cnVjdGlvbnMgcmF0
aGVyIHRoYW4gbWVtb3J5IG9uZXMuDQpJZiB3ZSBrbm93IGEgUENJIHNsYXZlIGlzbid0ICdpbycg
c2hvdWxkIGJlIGJlIHVzaW5nIGlvcmVhZDMyKCkgb3IgcmVhZGwoKT8NCkRvbid0IHNvbWUgYXJj
aGl0ZWN0dXJlcyBoYXZlIGRpZmZlcmVudCBlbmZvcmNlZCBiYXJyaWVycyBpbiBib3RoIHRoZXNl
Pw0KDQoJRGF2aWQNCg0KDQoNCg==

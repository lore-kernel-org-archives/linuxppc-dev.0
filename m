Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wHjB2KkDzDrCl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 01:30:05 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christophe LEROY' <christophe.leroy@c-s.fr>, Geert Uytterhoeven
 <geert@linux-m68k.org>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "Linux Kernel
 Mailing List" <linux-kernel@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Geoff Levand <geoff@infradead.org>
Subject: RE: [PATCH v2] powerpc/64: Fix build failure with GCC 8.1
Date: Tue, 29 May 2018 15:24:21 +0000
Message-ID: <1bfdea64b0cc4be2970e296684c097dc@AcuMS.aculab.com>
References: <f5f2de3e1a39613f7303bfdc0d2f2210d4c91910.1527573345.git.christophe.leroy@c-s.fr>
 <CAMuHMdVSKigQPUQH=BVc2fRSRmuEThLaf+V9ghMPDT9_m1C6BA@mail.gmail.com>
 <1fa5b220-4d21-b4cd-33bf-8a3ce3178063@c-s.fr>
 <CAMuHMdXwO1_wrrTi40UmZC4o6KjvP0LF38m45n0ZNA2pDb_7Qg@mail.gmail.com>
 <3a438dd8-49c3-ad39-e2a1-040e0ce67279@c-s.fr>
In-Reply-To: <3a438dd8-49c3-ad39-e2a1-040e0ce67279@c-s.fr>
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

RnJvbTogQ2hyaXN0b3BoZSBMRVJPWQ0KPiBTZW50OiAyOSBNYXkgMjAxOCAxMDozNw0KLi4uDQo+
ID4+Pj4gLSAgICAgICBzdHJuY3B5KG5ld19wYXJ0LT5oZWFkZXIubmFtZSwgbmFtZSwgMTIpOw0K
PiA+Pj4+ICsgICAgICAgbWVtY3B5KG5ld19wYXJ0LT5oZWFkZXIubmFtZSwgbmFtZSwgc3Rybmxl
bihuYW1lLA0KPiA+Pj4+IHNpemVvZihuZXdfcGFydC0+aGVhZGVyLm5hbWUpKSk7DQo+ID4+Pg0K
PiA+Pj4NCj4gPj4+IFRoZSBjb21tZW50IGZvciBudnJhbV9oZWFkZXIubGdudGggc2F5czoNCj4g
Pj4+DQo+ID4+PiAgICAgICAgICAgLyogVGVybWluYXRpbmcgbnVsbCByZXF1aXJlZCBvbmx5IGZv
ciBuYW1lcyA8IDEyIGNoYXJzLiAqLw0KPiA+Pj4NCj4gPj4+IFRoaXMgd2lsbCBub3QgdGVybWlu
YXRlIHRoZSBzdHJpbmcgd2l0aCBhIHplcm8gKHRoZSBzdHJ1Y3QgaXMNCj4gPj4+IGFsbG9jYXRl
ZCB3aXRoIGttYWxsb2MpLg0KPiA+Pj4gU28gdGhlIG9yaWdpbmFsIGNvZGUgaXMgY29ycmVjdCwg
dGhlIG5ldyBvbmUgaXNuJ3QuDQo+ID4+DQo+ID4+IFJpZ2h0LCB0aGVuIEkgaGF2ZSB0byBmaXJz
dCB6ZXJvaXplIHRoZSBkZXN0aW5hdGlvbi4NCj4gPg0KPiA+IFVzaW5nIGt6YWxsb2MoKSBpbnN0
ZWFkIG9mIGttYWxsb2MoKSB3aWxsIGRvLg0KPiA+DQo+ID4gU3RpbGwsIHBhcGVyaW5nIGFyb3Vu
ZCB0aGVzZSB3YXJuaW5ncyBzZWVtcyB0byBvYnNjdXJlIHRoaW5ncywgSU1ITy4NCj4gPiBBbmQg
aXQgaW5jcmVhc2VzIGNvZGUgc2l6ZSwgYXMgeW91IGhhZCB0byBhZGQgYSBjYWxsIHRvIHN0cm5s
ZW4oKS4NCj4gDQo+IFJpZ2h0IGJ1dCB0aGVuLCB3aGF0IGlzIHRoZSBiZXN0IHNvbHV0aW9uIHRv
IGVsaW1hdGUgdGhhdCB3YXJuaW5nID8NCg0KVGltZSB0byBhZGQgdGhlIElfcmVhbGx5X21lYW5f
c3RybmN5KCkgZnVuY3Rpb24uDQoNCglEYXZpZA0KDQo=

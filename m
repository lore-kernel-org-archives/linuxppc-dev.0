Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A512E1A1D61
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Aug 2015 02:25:06 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Robert Baldyga' <r.baldyga@samsung.com>, "balbi@ti.com" <balbi@ti.com>
CC: "nicolas.ferre@atmel.com" <nicolas.ferre@atmel.com>,
 "robert.jarzmik@free.fr" <robert.jarzmik@free.fr>, "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>, "devel@driverdev.osuosl.org"
 <devel@driverdev.osuosl.org>, "cernekee@gmail.com" <cernekee@gmail.com>,
 "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
 "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
 "Peter.Chen@freescale.com" <Peter.Chen@freescale.com>,
 "dahlmann.thomas@arcor.de" <dahlmann.thomas@arcor.de>,
 "johnyoun@synopsys.com" <johnyoun@synopsys.com>,
 "linux-geode@lists.infradead.org" <linux-geode@lists.infradead.org>,
 "haojian.zhuang@gmail.com" <haojian.zhuang@gmail.com>,
 "andrzej.p@samsung.com" <andrzej.p@samsung.com>, "linux-omap@vger.kernel.org"
 <linux-omap@vger.kernel.org>, "petr.cvek@tul.cz" <petr.cvek@tul.cz>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org"
 <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "daniel@zonque.org" <daniel@zonque.org>
Subject: RE: [PATCH v5 02/46] usb: gadget: add endpoint capabilities flags
Date: Fri, 31 Jul 2015 15:51:52 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CB71091@AcuExch.aculab.com>
References: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
 <1438351258-31578-3-git-send-email-r.baldyga@samsung.com>
In-Reply-To: <1438351258-31578-3-git-send-email-r.baldyga@samsung.com>
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

RnJvbTogUm9iZXJ0IEJhbGR5Z2ENCj4gU2VudDogMzEgSnVseSAyMDE1IDE1OjAwDQo+IEludHJv
ZHVjZSBzdHJ1Y3QgdXNiX2VwX2NhcHMgd2hpY2ggY29udGFpbnMgaW5mb3JtYXRpb24gYWJvdXQg
Y2FwYWJpbGl0aWVzDQo+IG9mIHVzYiBlbmRwb2ludHMgLSBzdXBwb3J0ZWQgdHJhbnNmZXIgdHlw
ZXMgYW5kIGRpcmVjdGlvbnMuIFRoaXMgc3RydWN0dXJlDQo+IHNob3VsZCBiZSBmaWxsZWQgYnkg
VURDIGRyaXZlciBmb3IgZWFjaCBvZiBpdHMgZW5kcG9pbnRzLCBhbmQgd2lsbCBiZQ0KPiB1c2Vk
IGluIGVwYXV0b2NvbmYgaW4gbmV3IGVwIG1hdGNoaW5nIG1lY2hhbmlzbSB3aGljaCB3aWxsIHJl
cGxhY2UgdWdseQ0KPiBndWVzc2luZyBvZiBlbmRwb2ludCBjYXBhYmlsaXRpZXMgYmFzaW5nIG9u
IGl0cyBuYW1lLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUm9iZXJ0IEJhbGR5Z2EgPHIuYmFsZHln
YUBzYW1zdW5nLmNvbT4NCj4gLS0tDQo+ICBpbmNsdWRlL2xpbnV4L3VzYi9nYWRnZXQuaCB8IDIx
ICsrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3VzYi9nYWRnZXQuaCBiL2luY2x1
ZGUvbGludXgvdXNiL2dhZGdldC5oDQo+IGluZGV4IDY4ZmI1ZTguLmE5YTQ5NTkgMTAwNjQ0DQo+
IC0tLSBhL2luY2x1ZGUvbGludXgvdXNiL2dhZGdldC5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgv
dXNiL2dhZGdldC5oDQo+IEBAIC0xNDEsMTAgKzE0MSwyOSBAQCBzdHJ1Y3QgdXNiX2VwX29wcyB7
DQo+ICB9Ow0KLi4uDQo+ICtzdHJ1Y3QgdXNiX2VwX2NhcHMgew0KPiArCXVuc2lnbmVkIHR5cGVf
Y29udHJvbDoxOw0KPiArCXVuc2lnbmVkIHR5cGVfaXNvOjE7DQo+ICsJdW5zaWduZWQgdHlwZV9i
dWxrOjE7DQo+ICsJdW5zaWduZWQgdHlwZV9pbnQ6MTsNCj4gKwl1bnNpZ25lZCBkaXJfaW46MTsN
Cj4gKwl1bnNpZ25lZCBkaXJfb3V0OjE7DQo+ICt9Ow0KDQpXaXRoIHRoZSB3YXkgdGhpcyBpcyB1
c2VkIChlZyBiZWxvdyBmcm9tIDEzLzQ2KQ0KDQorDQorCQlpZiAoaSA9PSAwKSB7DQorCQkJZXAt
PmVwLmNhcHMudHlwZV9jb250cm9sID0gdHJ1ZTsNCisJCX0gZWxzZSB7DQorCQkJZXAtPmVwLmNh
cHMudHlwZV9pc28gPSB0cnVlOw0KKwkJCWVwLT5lcC5jYXBzLnR5cGVfYnVsayA9IHRydWU7DQor
CQkJZXAtPmVwLmNhcHMudHlwZV9pbnQgPSB0cnVlOw0KKwkJfQ0KKw0KKwkJZXAtPmVwLmNhcHMu
ZGlyX2luID0gdHJ1ZTsNCisJCWVwLT5lcC5jYXBzLmRpcl9vdXQgPSB0cnVlOw0KDQpJIHRoaW5r
IGl0IHdvdWxkIGJlIG1vcmUgb2J2aW91cyBpZiB5b3UgdXNlZCBhIHU4IGFuZCBleHBsaWNpdCBi
aXRtYXNrcy4NClRoZSBpbml0aWFsaXNhdGlvbiAoYXMgYWJvdmUpIHdvdWxkIHRoZSBiZSBleHBs
aWNpdGx5IGFzc2lnbmluZyAnbm90IHN1cHBvcnRlZCcNCnRvIHRoZSBvdGhlciBmaWVsZHMuDQpU
aGUgY29tcGlsZXIgd2lsbCBhbHNvIGdlbmVyYXRlIG11Y2ggYmV0dGVyIGNvZGUuLi4NCg0KCURh
dmlkDQoNCg==

Return-Path: <r58472@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 92CEA2C0079
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 20:34:01 +1000 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: RE: [PATCH 1/2] cpuidle: fix cpu idle driver as a module can not
 remove
Date: Wed, 24 Jul 2013 10:33:53 +0000
Message-ID: <94F013E7935FF44C83EBE7784D62AD3F097A90F5@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1374571681-31911-1-git-send-email-dongsheng.wang@freescale.com>
 <8766398.Myt5gdDlbY@vostro.rjw.lan>
 <ABB05CD9C9F68C46A5CEDC7F15439259FDCB28@039-SN2MPN1-023.039d.mgd.msft.net>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259FDCB28@039-SN2MPN1-023.039d.mgd.msft.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Wang Dongsheng-B40534 <B40534@freescale.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtcG0tb3duZXJA
dmdlci5rZXJuZWwub3JnIFttYWlsdG86bGludXgtcG0tDQo+IG93bmVyQHZnZXIua2VybmVsLm9y
Z10gT24gQmVoYWxmIE9mIFdhbmcgRG9uZ3NoZW5nLUI0MDUzNA0KPiBTZW50OiBXZWRuZXNkYXks
IEp1bHkgMjQsIDIwMTMgMTA6MjYgQU0NCj4gVG86IFJhZmFlbCBKLiBXeXNvY2tpDQo+IENjOiBk
YW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnOyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
cHBjLQ0KPiBkZXZAbGlzdHMub3psYWJzLm9yZw0KPiBTdWJqZWN0OiBSRTogW1BBVENIIDEvMl0g
Y3B1aWRsZTogZml4IGNwdSBpZGxlIGRyaXZlciBhcyBhIG1vZHVsZSBjYW4gbm90DQo+IHJlbW92
ZQ0KPiANCj4gDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTog
UmFmYWVsIEouIFd5c29ja2kgW21haWx0bzpyandAc2lzay5wbF0NCj4gPiBTZW50OiBXZWRuZXNk
YXksIEp1bHkgMjQsIDIwMTMgNTozMyBBTQ0KPiA+IFRvOiBXYW5nIERvbmdzaGVuZy1CNDA1MzQN
Cj4gPiBDYzogZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwu
b3JnOyBsaW51eHBwYy0NCj4gPiBkZXZAbGlzdHMub3psYWJzLm9yZw0KPiA+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggMS8yXSBjcHVpZGxlOiBmaXggY3B1IGlkbGUgZHJpdmVyIGFzIGEgbW9kdWxlIGNh
bg0KPiA+IG5vdCByZW1vdmUNCj4gPg0KPiA+IE9uIFR1ZXNkYXksIEp1bHkgMjMsIDIwMTMgMDU6
Mjg6MDAgUE0gRG9uZ3NoZW5nIFdhbmcgd3JvdGU6DQo+ID4gPiBGcm9tOiBXYW5nIERvbmdzaGVu
ZyA8ZG9uZ3NoZW5nLndhbmdAZnJlZXNjYWxlLmNvbT4NCj4gPiA+DQo+ID4gPiBUaGUgbW9kdWxl
IGNhbiBub3QgYmUgcmVtb3ZlZCB3aGVuIGV4ZWN1dGUgInJtbW9kIi4gcm1tb2Qgbm90IHVzZQ0K
PiA+ID4gIi0tZm9yY2UiLg0KPiA+ID4NCj4gPiA+IExvZzoNCj4gPiA+IHJvb3Q6fiMgcm1tb2Qg
Y3B1aWRsZS1lNTAwDQo+ID4gPiBpbmNzWzldLCBkZWNzWzFdDQo+ID4gPiBybW1vZDogY2FuJ3Qg
dW5sb2FkICdjcHVpZGxlX2U1MDAnOiBSZXNvdXJjZSB0ZW1wb3JhcmlseSB1bmF2YWlsYWJsZQ0K
PiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFdhbmcgRG9uZ3NoZW5nIDxkb25nc2hlbmcud2Fu
Z0BmcmVlc2NhbGUuY29tPg0KPiA+DQo+ID4gQ2FuIHlvdSBwbGVhc2UgY2hlY2sgdGhlIGN1cnJl
bnQgbGludXgtbmV4dCBicmFuY2ggb2YgdGhlIGxpbnV4LXBtLmdpdA0KPiA+IHRyZWUgYW5kIHNl
ZSBpZiB0aGF0IGRvZXNuJ3QgY29uZmxpY3Qgd2l0aCB0aGUgbWF0ZXJpYWwgaW4gdGhlcmU/DQo+
ID4NCj4gPiBBbHNvIHBsZWFzZSBleHBsYWluIGluIHRoZSBjaGFuZ2Vsb2cgaG93IHlvdXIgY2hh
bmdlcyBoZWxwIHRvIGZpeCB0aGUNCj4gPiBwcm9ibGVtLg0KPiA+DQo+IFllcywgTGludXgtbmV4
dCBicmFuY2ggYWxzbyBoYXZlIHRoaXMgcHJvYmxlbS4NCj4gDQo+IFNob3VsZCBJIGJhc2Ugb24g
TGludXgtbmV4dCB0byBmaXggdGhpcyBwcm9ibGVtPw0KDQpJIHRoaW5rIERvbmdzaGVuZyBpcyB0
cnlpbmcgdG8gbWFrZSB0aGUgcGxhdGZvcm0gY3B1aWRsZSBkcml2ZXIgYXMgYSBrZXJuZWwgbW9k
dWxlLg0KDQpNeSBxdWVzdGlvbnMgYXJlOg0KSXMgdGhlIGNwdWlkbGUgZHJpdmVyIHN1cHBvc2Vk
IHRvIHdvcmsgYXMgYSBtb2R1bGU/DQpPciBpdCBjYW4gb25seSBiZSBidWlsdC1pbiBsaWtlIG1h
bnkgY3VycmVudCBkcml2ZXJzIGRvPw0KDQpSZWdhcmRzLA0KTGVvDQo=

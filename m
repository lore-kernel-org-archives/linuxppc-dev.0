Return-Path: <B32167@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B49D02C02A9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2013 17:22:19 +1000 (EST)
From: Jain Priyanka-B32167 <B32167@freescale.com>
To: tiejun.chen <tiejun.chen@windriver.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: RE: [PATCH] powerpc/32bit,PREEMPT:Load TI_FLAGS to check NEED_RESCHED
Date: Mon, 27 May 2013 07:21:54 +0000
Message-ID: <AC83832D6324604BB08FAE5A33553F190B3B7B27@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1369636076-2644-1-git-send-email-Priyanka.Jain@freescale.com>
 <51A300F4.80103@windriver.com>
 <AC83832D6324604BB08FAE5A33553F190B3B7A4C@039-SN2MPN1-012.039d.mgd.msft.net>
 <51A308D2.6040101@windriver.com>
In-Reply-To: <51A308D2.6040101@windriver.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

WWVzLA0KQmVuIGlzIGFsc28gcG9pbnRpbmcgdG8gc2FtZSB0aGluZy4NCkkgd2lsbCBzZW5kIGFu
b3RoZXIgcGF0Y2ggd2l0aCBjaGFuZ2VzIHN1Z2dlc3RlZCAod2l0aCBib3RoIHN1YmplY3QgYW5k
IGRlc2NyaXB0aW9uIG1vZGlmaWVkKSB3aGljaCB3aWxsIHN1cGVyc2VkZSB0aGlzIHBhdGNoLg0K
DQpSZWdhcmRzDQpQcml5YW5rYQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IHRpZWp1bi5jaGVuIFttYWlsdG86dGllanVuLmNoZW5Ad2luZHJpdmVyLmNvbV0NCj4gU2Vu
dDogTW9uZGF5LCBNYXkgMjcsIDIwMTMgMTI6NDkgUE0NCj4gVG86IEphaW4gUHJpeWFua2EtQjMy
MTY3DQo+IENjOiBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsgV29vZCBTY290dC1CMDc0
MjENCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gcG93ZXJwYy8zMmJpdCxQUkVFTVBUOkxvYWQgVElf
RkxBR1MgdG8gY2hlY2sNCj4gTkVFRF9SRVNDSEVEDQo+IA0KPiBPbiAwNS8yNy8yMDEzIDAyOjU1
IFBNLCBKYWluIFByaXlhbmthLUIzMjE2NyB3cm90ZToNCj4gPg0KPiA+IElmIHdlIGdvIHNvbWUg
bW9yZSBsaW5lcyB1cCBpbiB0aGUgc2FtZSBmaWxlLCB0aGUgY29kZSBpcw0KPiA+DQo+ID4gcmVz
dW1lX2tlcm5lbDoNCj4gPiAgICAgICAgICAvKiBjaGVjayBjdXJyZW50X3RocmVhZF9pbmZvLCBf
VElGX0VNVUxBVEVfU1RBQ0tfU1RPUkUgKi8NCj4gPiAgICAgICAgICBDVVJSRU5UX1RIUkVBRF9J
TkZPKHI5LCByMSkNCj4gPiAgICAgICAgICBsd3ogICAgIHI4LFRJX0ZMQUdTKHI5KQ0KPiA+ICAg
ICAgICAgIGFuZGlzLiAgcjgscjgsX1RJRl9FTVVMQVRFX1NUQUNLX1NUT1JFQGgNCj4gDQo+IE9r
YXksIGJ1dCBjb3VsZCB5b3UgZml4IHRoaXMgZGlyZWN0bHkgbGlrZToNCj4gDQo+IGRpZmYgLS1n
aXQgYS9hcmNoL3Bvd2VycGMva2VybmVsL2VudHJ5XzMyLlMNCj4gYi9hcmNoL3Bvd2VycGMva2Vy
bmVsL2VudHJ5XzMyLlMgaW5kZXggZTUxNGRlNS4uNDQ5ODQ2NyAxMDA2NDQNCj4gLS0tIGEvYXJj
aC9wb3dlcnBjL2tlcm5lbC9lbnRyeV8zMi5TDQo+ICsrKyBiL2FyY2gvcG93ZXJwYy9rZXJuZWwv
ZW50cnlfMzIuUw0KPiBAQCAtODUxLDcgKzg1MSw3IEBAIHJlc3VtZV9rZXJuZWw6DQo+ICAgICAg
ICAgIC8qIGNoZWNrIGN1cnJlbnRfdGhyZWFkX2luZm8sIF9USUZfRU1VTEFURV9TVEFDS19TVE9S
RSAqLw0KPiAgICAgICAgICBDVVJSRU5UX1RIUkVBRF9JTkZPKHI5LCByMSkNCj4gICAgICAgICAg
bHd6ICAgICByOCxUSV9GTEFHUyhyOSkNCj4gLSAgICAgICBhbmRpcy4gIHI4LHI4LF9USUZfRU1V
TEFURV9TVEFDS19TVE9SRUBoDQo+ICsgICAgICAgYW5kaXMuICByMCxyOCxfVElGX0VNVUxBVEVf
U1RBQ0tfU1RPUkVAaA0KPiAgICAgICAgICBiZXErICAgIDFmDQo+IA0KPiAgICAgICAgICBhZGRp
ICAgIHI4LHIxLElOVF9GUkFNRV9TSVpFICAgIC8qIEdldCB0aGUga3Byb2JlZCBmdW5jdGlvbg0K
PiBlbnRyeSAqLw0KPiANCj4gVGllanVuDQoNCg==

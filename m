Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680046.outbound.protection.outlook.com [40.107.68.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Dx2F3ClqzF0BV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 18:27:47 +1000 (AEST)
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "malat@debian.org" <malat@debian.org>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH] powerpc/time: Calculate proper wday
Date: Tue, 18 Sep 2018 08:27:41 +0000
Message-ID: <04f53f748f1804e5175884ff6e37e210b80d0f06.camel@infinera.com>
References: <20180829075458.10145-1-joakim.tjernlund@infinera.com>
 <CA+7wUsxbYGAuwE--AukCCYA8H4CQj1tv31nAOv256u9tkDENKg@mail.gmail.com>
In-Reply-To: <CA+7wUsxbYGAuwE--AukCCYA8H4CQj1tv31nAOv256u9tkDENKg@mail.gmail.com>
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

T24gVHVlLCAyMDE4LTA5LTE4IGF0IDEwOjA4ICswMjAwLCBNYXRoaWV1IE1hbGF0ZXJyZSB3cm90
ZToNCj4gDQo+IA0KPiBPbiBXZWQsIEF1ZyAyOSwgMjAxOCBhdCAxMDowMyBBTSBKb2FraW0gVGpl
cm5sdW5kIDxqb2FraW0udGplcm5sdW5kQGluZmluZXJhLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiB0
b190bSgpIGhhcmRjb2RlcyB3ZGF5IHRvIC0xIGFzICJOby1vbmUgdXNlcyB0aGUgZGF5IG9mIHRo
ZSB3ZWVrIi4NCj4gPiBCdXQgcmVjZW50bHkgcnRjIGRyaXZlciBkczEzMDcgZG9lcyBjYXJlIGFu
ZCB0cmllcyB0byBjb3JyZWN0IHdkYXkuDQo+ID4NCj4gPiBBZGQgd2RheSBjYWxjdWxhdGlvbihz
dG9sZW4gZnJvbSBydGNfdGltZTY0X3RvX3RtKSB0byB0b190bSgpIHRvIHBsZWFzZSBkczEzMDcu
DQo+IA0KPiBJcyB0aGlzIHN0aWxsIGFuIGlzc3VlIGFmdGVyOg0KPiANCj4gMzRlZmFiZTQxODk1
IHBvd2VycGM6IHJlbW92ZSB1bnVzZWQgdG9fdG0oKSBoZWxwZXINCg0KTm8sIGl0IGlzIG5vdCBh
biBpc3N1ZSBhbnltb3JlLiBZb3UgY2FuIGRyb3AgdGhpcyBwYXRjaC4NCg0KIEpvY2tlDQoNCj4g
DQo+ID8NCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSm9ha2ltIFRqZXJubHVuZCA8am9ha2ltLnRq
ZXJubHVuZEBpbmZpbmVyYS5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvcG93ZXJwYy9rZXJuZWwv
dGltZS5jIHwgOCArKystLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCA1IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9rZXJu
ZWwvdGltZS5jIGIvYXJjaC9wb3dlcnBjL2tlcm5lbC90aW1lLmMNCj4gPiBpbmRleCBmZTZmM2Ey
ODU0NTUuLmY0YTA5ZWUwMTk0NCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3Bvd2VycGMva2VybmVs
L3RpbWUuYw0KPiA+ICsrKyBiL2FyY2gvcG93ZXJwYy9rZXJuZWwvdGltZS5jDQo+ID4gQEAgLTEx
NjAsNiArMTE2MCw5IEBAIHZvaWQgdG9fdG0oaW50IHRpbSwgc3RydWN0IHJ0Y190aW1lICogdG0p
DQo+ID4gICAgICAgICBkYXkgPSB0aW0gLyBTRUNEQVk7DQo+ID4gICAgICAgICBobXMgPSB0aW0g
JSBTRUNEQVk7DQo+ID4NCj4gPiArICAgICAgIC8qIGRheSBvZiB0aGUgd2VlaywgMTk3MC0wMS0w
MSB3YXMgYSBUaHVyc2RheSAqLw0KPiA+ICsgICAgICAgdG0tPnRtX3dkYXkgPSAoZGF5ICsgNCkg
JSA3Ow0KPiA+ICsNCj4gPiAgICAgICAgIC8qIEhvdXJzLCBtaW51dGVzLCBzZWNvbmRzIGFyZSBl
YXN5ICovDQo+ID4gICAgICAgICB0bS0+dG1faG91ciA9IGhtcyAvIDM2MDA7DQo+ID4gICAgICAg
ICB0bS0+dG1fbWluID0gKGhtcyAlIDM2MDApIC8gNjA7DQo+ID4gQEAgLTExODAsMTEgKzExODMs
NiBAQCB2b2lkIHRvX3RtKGludCB0aW0sIHN0cnVjdCBydGNfdGltZSAqIHRtKQ0KPiA+DQo+ID4g
ICAgICAgICAvKiBEYXlzIGFyZSB3aGF0IGlzIGxlZnQgb3ZlciAoKzEpIGZyb20gYWxsIHRoYXQu
ICovDQo+ID4gICAgICAgICB0bS0+dG1fbWRheSA9IGRheSArIDE7DQo+ID4gLQ0KPiA+IC0gICAg
ICAgLyoNCj4gPiAtICAgICAgICAqIE5vLW9uZSB1c2VzIHRoZSBkYXkgb2YgdGhlIHdlZWsuDQo+
ID4gLSAgICAgICAgKi8NCj4gPiAtICAgICAgIHRtLT50bV93ZGF5ID0gLTE7DQo+ID4gIH0NCj4g
PiAgRVhQT1JUX1NZTUJPTCh0b190bSk7DQo+ID4NCj4gPiAtLQ0KPiA+IDIuMTYuNA0KDQo=

Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.185])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB05C1A0E2D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2015 01:59:12 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christophe Leroy' <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, "scottwood@freescale.com"
 <scottwood@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] powerpc: add support for csum_add()
Date: Fri, 22 May 2015 15:57:38 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CB3D471@AcuExch.aculab.com>
References: <cover.1432047904.git.christophe.leroy@c-s.fr>
 <1d1362c8aa696e316d3ba97dce2342df6f6ee6cf.1432047904.git.christophe.leroy@c-s.fr>
In-Reply-To: <1d1362c8aa696e316d3ba97dce2342df6f6ee6cf.1432047904.git.christophe.leroy@c-s.fr>
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

RnJvbTogTGludXhwcGMtZGV2IENocmlzdG9waGUgTGVyb3kNCj4gU2VudDogMTkgTWF5IDIwMTUg
MTY6MTkNCi4uLg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL2NoZWNr
c3VtLmggYi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vY2hlY2tzdW0uaA0KPiBpbmRleCA1ZTQz
ZDJkLi5lOGQ5ZWY0IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vY2hl
Y2tzdW0uaA0KPiArKysgYi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vY2hlY2tzdW0uaA0KPiBA
QCAtMTMwLDYgKzEzMCwyMiBAQCBzdGF0aWMgaW5saW5lIF9fc3VtMTYgY3N1bV90Y3B1ZHBfbWFn
aWMoX19iZTMyIHNhZGRyLCBfX2JlMzIgZGFkZHIsDQo+ICAJcmV0dXJuIGNzdW1fZm9sZChjc3Vt
X3RjcHVkcF9ub2ZvbGQoc2FkZHIsIGRhZGRyLCBsZW4sIHByb3RvLCBzdW0pKTsNCj4gIH0NCj4g
DQo+ICsjZGVmaW5lIEhBVkVfQVJDSF9DU1VNX0FERA0KPiArc3RhdGljIGlubGluZSBfX3dzdW0g
Y3N1bV9hZGQoX193c3VtIGNzdW0sIF9fd3N1bSBhZGRlbmQpDQo+ICt7DQo+ICsjaWZkZWYgX19w
b3dlcnBjNjRfXw0KPiArCXU2NCByZXMgPSAoX19mb3JjZSB1NjQpY3N1bTsNCj4gKw0KPiArCXJl
cyArPSAoX19mb3JjZSB1NjQpYWRkZW5kOw0KPiArCXJldHVybiAoX19mb3JjZSBfX3dzdW0pKCh1
MzIpcmVzICsgKHJlcyA+PiAzMikpOw0KPiArI2Vsc2UNCj4gKwlhc20oImFkZGMgJTAsJTAsJTE7
Ig0KPiArCSAgICAiYWRkemUgJTAsJTA7Ig0KPiArCSAgICA6ICIrciIgKGNzdW0pIDogInIiIChh
ZGRlbmQpKTsNCj4gKwlyZXR1cm4gY3N1bTsNCj4gKyNlbmRpZg0KDQpJJ2QgaGF2ZSB0aG91Z2h0
IGl0IGJldHRlciB0byB0ZXN0IGZvciB0aGUgY3B1IHR5cGUgd2hlcmUgeW91IHdhbnQgdGhlDQon
YXNtJyB2YXJpYW50LCBhbmQgdGhlbiBmYWxsIGJhY2sgb24gdGhlIEMgdmVyc2lvbiBmb3IgYWxs
IG90aGVycy4NCkkga25vdyAod2VsbCBzdXNwZWN0KSB0aGVyZSBhcmUgb25seSB0d28gY2FzZXMg
aGVyZS4NCg0KSSdkIGFsc28gaGF2ZSB0aG91Z2h0IHRoYXQgdGhlIDY0Yml0IEMgdmVyc2lvbiBh
Ym92ZSB3b3VsZCBiZSBnZW5lcmFsbHkgJ2dvb2QnLg0KDQoJRGF2aWQNCg0K

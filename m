Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.185])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EAAB21A0BFE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 22:10:02 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christophe Leroy' <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, "scottwood@freescale.com"
 <scottwood@freescale.com>
Subject: RE: [PATCH v2 07/11] powerpc/8xx: macro for handling CPU15 errata
Date: Tue, 20 Jan 2015 11:09:08 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CACEFD9@AcuExch.aculab.com>
References: <20150120095735.A55671A5E86@localhost.localdomain>
In-Reply-To: <20150120095735.A55671A5E86@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbSBDaHJpc3RvcGhlIExlcm95DQo+IEhhdmluZyBhIG1hY3JvIHdpbGwgaGVscCBrZWVwIGNs
ZWFyIGNvZGUuDQoNCkl0IG1pZ2h0IHJlbW92ZSBhbiAjaWYgYnV0IGl0IGRvZXNuJ3QgcmVhbGx5
IGhlbHAuDQpBbGwgaXQgbWVhbnMgaXMgdGhhdCBhbnlvbmUgcmVhZGluZyB0aGUgY29kZSBoYXMg
dG8gaHVudCBmb3INCnRoZSBkZWZpbml0aW9uIGJlZm9yZSBwcm9jZWVkaW5nLg0KDQpTb21lIGNv
bW1lbnQgYWJvdXQgd2hhdCAoYW5kIHdoeSkgdGhlIGV4dHJhIGNvZGUgaXMgbmVlZGVkDQptaWdo
dCBoZWxwLg0KDQouLi4NCj4gKw0KPiArI2lmZGVmIENPTkZJR184eHhfQ1BVMTUNCj4gKyNkZWZp
bmUgRE9fOHh4X0NQVTE1KHRtcCwgYWRkcikJXA0KPiArCWFkZGkJdG1wLCBhZGRyLCBQQUdFX1NJ
WkU7CVwNCj4gKwl0bGJpZQl0bXA7CQkJXA0KPiArCWFkZGkJdG1wLCBhZGRyLCBQQUdFX1NJWkU7
CVwNCg0KWW91J3ZlIGV2ZW4gdHJhbnNjcmliZWQgdGhpcyBpbmNvcnJlY3RseS4NCg0KQ2xlYXJs
eSBub3QgdGVzdGVkIDotKQ0KDQoJRGF2aWQNCg0KPiArCXRsYmllCXRtcA0KPiArI2Vsc2UNCj4g
KyNkZWZpbmUgRE9fOHh4X0NQVTE1KHRtcCwgYWRkcikNCj4gKyNlbmRpZg0KPiArDQo+ICBJbnN0
cnVjdGlvblRMQk1pc3M6DQo+ICAjaWZkZWYgQ09ORklHXzh4eF9DUFU2DQo+ICAJbXRzcHIJU1BS
Tl9EQVIsIHIzDQo+IEBAIC0zMDQsMTIgKzMxNSw3IEBAIEluc3RydWN0aW9uVExCTWlzczoNCj4g
IAlFWENFUFRJT05fUFJPTE9HXzANCj4gIAltdHNwcglTUFJOX1NQUkdfU0NSQVRDSDIsIHIxMA0K
PiAgCW1mc3ByCXIxMCwgU1BSTl9TUlIwCS8qIEdldCBlZmZlY3RpdmUgYWRkcmVzcyBvZiBmYXVs
dCAqLw0KPiAtI2lmZGVmIENPTkZJR184eHhfQ1BVMTUNCj4gLQlhZGRpCXIxMSwgcjEwLCBQQUdF
X1NJWkUNCj4gLQl0bGJpZQlyMTENCj4gLQlhZGRpCXIxMSwgcjEwLCAtUEFHRV9TSVpFDQo+IC0J
dGxiaWUJcjExDQo+IC0jZW5kaWYNCj4gKwlET184eHhfQ1BVMTUocjExLCByMTApDQo+IA0KPiAg
CS8qIElmIHdlIGFyZSBmYXVsdGluZyBhIGtlcm5lbCBhZGRyZXNzLCB3ZSBoYXZlIHRvIHVzZSB0
aGUNCj4gIAkgKiBrZXJuZWwgcGFnZSB0YWJsZXMuDQo+IC0tDQo+IDIuMS4wDQo+IA0KPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBMaW51eHBwYy1k
ZXYgbWFpbGluZyBsaXN0DQo+IExpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnDQo+IGh0dHBz
Oi8vbGlzdHMub3psYWJzLm9yZy9saXN0aW5mby9saW51eHBwYy1kZXYNCg==

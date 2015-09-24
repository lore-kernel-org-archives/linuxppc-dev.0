Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F7361A0026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 21:42:33 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christophe Leroy' <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, "scottwood@freescale.com"
 <scottwood@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 08/25] powerpc/8xx: Map IMMR area with 512k page at a
 fixed address
Date: Thu, 24 Sep 2015 11:41:25 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CBA15B8@AcuExch.aculab.com>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <bfa8400abd8b5174942616aae5876a55242f5468.1442939410.git.christophe.leroy@c-s.fr>
In-Reply-To: <bfa8400abd8b5174942616aae5876a55242f5468.1442939410.git.christophe.leroy@c-s.fr>
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

RnJvbTogQ2hyaXN0b3BoZSBMZXJveQ0KPiBTZW50OiAyMiBTZXB0ZW1iZXIgMjAxNSAxNzo1MQ0K
Li4uDQo+IFRyYWRpdGlvbmFseSwgZWFjaCBkcml2ZXIgbWFuYWdlcyBvbmUgY29tcHV0ZXIgYm9h
cmQgd2hpY2ggaGFzIGl0cw0KPiBvd24gY29tcG9uZW50cyB3aXRoIGl0cyBvd24gbWVtb3J5IG1h
cHMuDQo+IEJ1dCBvbiBlbWJlZGRlZCBjaGlwcyBsaWtlIHRoZSBNUEM4eHgsIHRoZSBTT0MgaGFz
IGFsbCByZWdpc3RlcnMNCj4gbG9jYXRlZCBpbiB0aGUgc2FtZSBJTyBhcmVhLg0KPiANCj4gV2hl
biBsb29raW5nIGF0IGlvcmVtYXBzIGRvbmUgZHVyaW5nIHN0YXJ0dXAsIHdlIHNlZSB0aGF0DQo+
IG1hbnkgZHJpdmVycyBhcmUgcmUtbWFwcGluZyBzbWFsbCBwYXJ0cyBvZiB0aGUgSU1NUiBmb3Ig
dGhlaXIgb3duIHVzZQ0KPiBhbmQgYWxsIHRob3NlIHNtYWxsIHBpZWNlcyBnZXRzIHRoZWlyIG93
biA0ayBwYWdlLCBhbXBsaWZ5aW5nIHRoZQ0KPiBudW1iZXIgb2YgVExCIG1pc3NlczogaW4gb3Vy
IHN5c3RlbSB3ZSBnZXQgMHhmZjAwMDAwMCBtYXBwZWQgMzEgdGltZXMNCj4gYW5kIDB4ZmYwMDMw
MDAgbWFwcGVkIDkgdGltZXMuDQoNCklzbid0IHRoaXMgYSBtb3JlIGdlbmVyYWwgcHJvYmxlbT8N
Cg0KSWYgdGhlcmUgYXJlIG11bHRpcGxlIHJlbWFwIHJlcXVlc3RzIGZvciB0aGUgc2FtZSBwaHlz
aWNhbCBwYWdlDQpzaG91bGRuJ3QgdGhlIGtlcm5lbCBiZSBqdXN0IGluY3JlYXNpbmcgYSByZWZl
cmVuY2UgY291bnQgc29tZXdoZXJlDQphbmQgcmV0dXJuaW5nIGFkZHJlc3MgaW4gdGhlIHNhbWUg
dmlydHVhbCBwYWdlPw0KVGhpcyBzaG91bGQgcHJvYmFibHkgaGFwcGVuIHJlZ2FyZGxlc3Mgb2Yg
dGhlIGFkZHJlc3MuDQpJIHByZXN1bWUgaXQgbXVzdCBiZSBkb25lIGZvciBjYWNoZWFibGUgbWFw
cGluZ3MuDQoNCldoZXRoZXIgdGhpbmdzIGxpa2UgdGhlIElNTVIgc2hvdWxkIGJlIG1hcHBlZCB3
aXRoIGEgbGFyZ2VyIFRMQg0KaXMgYSBzZXBhcmF0ZSBtYXR0ZXIuDQoNCglEYXZpZA0KDQo=

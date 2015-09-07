Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D4E931A2A7F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2015 01:06:03 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christophe Leroy' <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, "scottwood@freescale.com"
 <scottwood@freescale.com>, "sojkam1@fel.cvut.cz" <sojkam1@fel.cvut.cz>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] powerpc32: memcpy: only use dcbz once cache is enabled
Date: Mon, 7 Sep 2015 15:04:56 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CB8E958@AcuExch.aculab.com>
References: <20150907142444.CA8F31A241A@localhost.localdomain>
In-Reply-To: <20150907142444.CA8F31A241A@localhost.localdomain>
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

RnJvbTogQ2hyaXN0b3BoZSBMZXJveQ0KPiBTZW50OiAwNyBTZXB0ZW1iZXIgMjAxNSAxNToyNQ0K
Li4uDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvbGliL2NvcHlfMzIuUyBiL2FyY2gvcG93
ZXJwYy9saWIvY29weV8zMi5TDQo+IGluZGV4IDJlZjUwYzYuLjA1YjMwOTYgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gvcG93ZXJwYy9saWIvY29weV8zMi5TDQo+ICsrKyBiL2FyY2gvcG93ZXJwYy9saWIv
Y29weV8zMi5TDQo+IEBAIC0xNzIsNyArMTcyLDE2IEBAIF9HTE9CQUwobWVtY3B5KQ0KPiAgCW10
Y3RyCXIwDQo+ICAJYmVxCTYzZg0KPiAgNTM6DQo+IC0JZGNieglyMTEscjYNCj4gKwkvKg0KPiAr
CSAqIER1cmluZyBlYXJseSBpbml0LCBjYWNoZSBtaWdodCBub3QgYmUgYWN0aXZlIHlldCwgc28g
ZGNieiBjYW5ub3QgYmUNCj4gKwkgKiB1c2VkLiBXZSBwdXQgZGNidCBpbnN0ZWFkIG9mIGRjYnou
IElmIGNhY2hlIGlzIG5vdCBhY3RpdmUsIGl0J3MganVzdA0KPiArCSAqIGxpa2UgYSBub3QuIElm
IGNhY2hlIGlzIGFjdGl2ZSwgYXQgbGVhc3QgaXQgcHJlZmV0Y2hzIHRoZSBsaW5lIHRvIGJlDQog
ICAgICAgICAgICAgICAgXl5eIG5vcCA/Pw0KDQoJRGF2aWQNCg0KPiArCSAqIG92ZXJ3cml0dGVu
Lg0KPiArCSAqIFdpbGwgYmUgcmVwbGFjZWQgYnkgZGNieiBpbiBtYWNoaW5lX2luaXQoKQ0KPiAr
CSAqLw0KPiArX0dMT0JBTChwcGMzMl9tZW1jcHlfZGNieikNCj4gKwlkY2J0CXIxMSxyNg0KPiAr
DQo+ICAJQ09QWV8xNl9CWVRFUw0KPiAgI2lmIEwxX0NBQ0hFX0JZVEVTID49IDMyDQo+ICAJQ09Q
WV8xNl9CWVRFUw0KPiAtLQ0KPiAyLjEuMA0KDQo=

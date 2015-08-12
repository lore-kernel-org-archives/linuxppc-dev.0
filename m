Return-Path: <David.Laight@ACULAB.COM>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9048F1A0567
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 20:27:10 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Cyril Bur' <cyrilbur@gmail.com>, Daniel Axtens <dja@axtens.net>
CC: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, "mikey@neuling.org"
 <mikey@neuling.org>, "imunsie@au.ibm.com" <imunsie@au.ibm.com>
Subject: RE: [PATCH v2 05/10] cxl: Refactor adaptor init/teardown
Date: Wed, 12 Aug 2015 10:14:27 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CB794DF@AcuExch.aculab.com>
References: <1438061323-20710-1-git-send-email-dja@axtens.net>
 <1438061323-20710-6-git-send-email-dja@axtens.net>
 <20150811160120.01815326@camb691>
In-Reply-To: <20150811160120.01815326@camb691>
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

RnJvbTogQ3lyaWwgQnVyDQo+IFNlbnQ6IDExIEF1Z3VzdCAyMDE1IDA3OjAxDQouLi4NCj4gWW91
IGhhdmUgYSBkaWxlbWEgd2l0aCB0aGUgdXNlIG9mIHVnbHkgaWYgKHJjID0gZm9vKCkpLiBJIGRv
bid0IGxpa2UgaXQgYnV0IHRoZQ0KPiBmaWxlIGlzIGxpdHRlcmVkIHdpdGggaXQuDQo+IA0KPiBM
b29rcyBsaWtlIHRoZSBtYWpvcml0eSBvZiB1c2VzIGluIHRoaXMgZmlsZSB0aGUgY29uZGl0aW9u
YWwgYmxvY2sgaXMgb25seQ0KPiBvbmUgbGluZSB0aGVuIGl0IG1ha2VzIHNlbnNlIChvciBhdCBs
ZWFzdCBpbiB0ZXJtcyBvZiBudW1iZXJzIG9mIGxpbmVzLi4uIGZhaXINCj4gZW5vdWdoKSwgaG93
ZXZlciwgaWYgeW91IGhhdmUgYSBjb25kaXRpb25hbCBibG9jayBzcGFubmluZyBtdWx0aXBsZSBs
aW5lcywgSQ0KPiBkb24ndCBsaWtlLg0KLi4uDQo+ID4gIAlrZnJlZShhZGFwdGVyKTsNCj4gPiAg
fQ0KPiA+DQo+ID4gLXN0YXRpYyBzdHJ1Y3QgY3hsICpjeGxfYWxsb2NfYWRhcHRlcihzdHJ1Y3Qg
cGNpX2RldiAqZGV2KQ0KPiA+ICtzdGF0aWMgc3RydWN0IGN4bCAqY3hsX2FsbG9jX2FkYXB0ZXIo
dm9pZCkNCj4gPiAgew0KPiA+ICAJc3RydWN0IGN4bCAqYWRhcHRlcjsNCj4gPiArCWludCByYzsN
Cj4gPg0KPiA+ICAJaWYgKCEoYWRhcHRlciA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBjeGwpLCBH
RlBfS0VSTkVMKSkpDQo+ID4gIAkJcmV0dXJuIE5VTEw7DQo+ID4NCj4gPiAtCWFkYXB0ZXItPmRl
di5wYXJlbnQgPSAmZGV2LT5kZXY7DQo+ID4gLQlhZGFwdGVyLT5kZXYucmVsZWFzZSA9IGN4bF9y
ZWxlYXNlX2FkYXB0ZXI7DQo+ID4gLQlwY2lfc2V0X2RydmRhdGEoZGV2LCBhZGFwdGVyKTsNCj4g
PiAgCXNwaW5fbG9ja19pbml0KCZhZGFwdGVyLT5hZnVfbGlzdF9sb2NrKTsNCj4gPg0KPiA+ICsJ
aWYgKChyYyA9IGN4bF9hbGxvY19hZGFwdGVyX25yKGFkYXB0ZXIpKSkNCj4gDQo+IEh1bWYNCj4g
DQo+ID4gKwkJZ290byBlcnIxOw0KPiA+ICsNCj4gPiArCWlmICgocmMgPSBkZXZfc2V0X25hbWUo
JmFkYXB0ZXItPmRldiwgImNhcmQlaSIsIGFkYXB0ZXItPmFkYXB0ZXJfbnVtKSkpDQo+IA0KPiBI
dW1mDQo+ID4gKwkJZ290byBlcnIyOw0KPiA+ICsNCj4gPiAgCXJldHVybiBhZGFwdGVyOw0KPiA+
ICsNCj4gPiArZXJyMjoNCj4gPiArCWN4bF9yZW1vdmVfYWRhcHRlcl9ucihhZGFwdGVyKTsNCj4g
PiArZXJyMToNCj4gPiArCWtmcmVlKGFkYXB0ZXIpOw0KPiA+ICsJcmV0dXJuIE5VTEw7DQo+ID4g
IH0NCi4uLg0KDQpUaGUgZnVuY3Rpb24gYWJvdmUgZG9lc24ndCBldmVuIHVzZSB0aGUgJ3JjJyB2
YWx1ZS4NCg0KCURhdmlkDQo=

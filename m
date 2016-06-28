Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rf9jx1HKSzDqrj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 02:09:40 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Ravi Bangoria' <ravi.bangoria@linux.vnet.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "acme@kernel.org" <acme@kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
CC: "ananth@in.ibm.com" <ananth@in.ibm.com>, "naveen.n.rao@linux.vnet.ibm.com"
 <naveen.n.rao@linux.vnet.ibm.com>, "dja@axtens.net" <dja@axtens.net>
Subject: RE: [PATCH 3/4] perf annotate: add powerpc support
Date: Tue, 28 Jun 2016 16:07:10 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F4E67FA@AcuExch.aculab.com>
References: <1467113807-29571-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1467113807-29571-4-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
In-Reply-To: <1467113807-29571-4-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
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

RnJvbTogUmF2aSBCYW5nb3JpYQ0KPiBTZW50OiAyOCBKdW5lIDIwMTYgMTI6MzcNCj4gDQo+IFBv
d2VycGMgaGFzIGxvbmcgbGlzdCBvZiBicmFuY2ggaW5zdHJ1Y3Rpb25zIGFuZCBoYXJkY29kaW5n
IHRoZW0gaW4gdGFibGUNCj4gYXBwZWFycyB0byBiZSBlcnJvci1wcm9uZS4gU28sIGFkZCBuZXcg
ZnVuY3Rpb24gdG8gZmluZCBpbnN0cnVjdGlvbg0KPiBpbnN0ZWFkIG9mIGNyZWF0aW5nIHRhYmxl
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTmF2ZWVuIE4uIFJhbyA8bmF2ZWVuLm4ucmFvQGxpbnV4
LnZuZXQuaWJtLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUmF2aSBCYW5nb3JpYSA8cmF2aS5iYW5n
b3JpYUBsaW51eC52bmV0LmlibS5jb20+DQo+IC0tLQ0KPiAgdG9vbHMvcGVyZi91dGlsL2Fubm90
YXRlLmMgfCA2NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNjQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L3Rvb2xzL3BlcmYvdXRpbC9hbm5vdGF0ZS5jIGIvdG9vbHMvcGVyZi91dGlsL2Fubm90YXRlLmMN
Cj4gaW5kZXggMzZhNTgyNS4uOTZjNjYxMCAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvcGVyZi91dGls
L2Fubm90YXRlLmMNCj4gKysrIGIvdG9vbHMvcGVyZi91dGlsL2Fubm90YXRlLmMNCj4gQEAgLTQ3
Niw2ICs0NzYsNjggQEAgc3RhdGljIGludCBpbnNfX2NtcChjb25zdCB2b2lkICphLCBjb25zdCB2
b2lkICpiKQ0KPiAgCXJldHVybiBzdHJjbXAoaWEtPm5hbWUsIGliLT5uYW1lKTsNCj4gIH0NCj4g
DQo+ICtzdGF0aWMgc3RydWN0IGlucyAqaW5zX19maW5kX3Bvd2VycGMoY29uc3QgY2hhciAqbmFt
ZSkNCg0KSXQgd291bGQgYmUgYmV0dGVyIGlmIHRoZSBmdW5jdGlvbiBuYW1lIGluY2x1ZGUgJ2Jy
YW5jaCcuDQoNCj4gK3sNCj4gKwlpbnQgaTsNCj4gKwlzdHJ1Y3QgaW5zICppbnM7DQo+ICsNCj4g
KwlpbnMgPSB6YWxsb2Moc2l6ZW9mKHN0cnVjdCBpbnMpKTsNCj4gKwlpZiAoIWlucykNCj4gKwkJ
cmV0dXJuIE5VTEw7DQo+ICsNCj4gKwlpbnMtPm5hbWUgPSBzdHJkdXAobmFtZSk7DQo+ICsJaWYg
KCFpbnMtPm5hbWUpDQo+ICsJCXJldHVybiBOVUxMOw0KDQoJWW91IGxlYWsgJ2lucycgaGVyZS4N
Cg0KPiArDQo+ICsJaWYgKG5hbWVbMF0gPT0gJ2InKSB7DQo+ICsJCS8qIGJyYW5jaCBpbnN0cnVj
dGlvbnMgKi8NCj4gKwkJaW5zLT5vcHMgPSAmanVtcF9vcHM7DQo+ICsNCj4gKwkJLyoNCj4gKwkJ
ICogLSBGZXcgc3RhcnQgd2l0aCAnYicsIGJ1dCBhcmVuJ3QgYnJhbmNoIGluc3RydWN0aW9ucy4N
Cj4gKwkJICogLSBMZXQncyBhbHNvIGlnbm9yZSBpbnN0cnVjdGlvbnMgaW52b2x2aW5nICdjdHIn
IGFuZA0KPiArCQkgKiAgICd0YXInIHNpbmNlIHRhcmdldCBicmFuY2ggYWRkcmVzc2VzIGZvciB0
aG9zZSBjYW4ndA0KPiArCQkgKiAgIGJlIGRldGVybWluZWQgc3RhdGljYWxseS4NCj4gKwkJICov
DQo+ICsJCWlmICghc3RybmNtcChuYW1lLCAiYmNkIiwgMykgICB8fA0KPiArCQkgICAgIXN0cm5j
bXAobmFtZSwgImJyaW5jIiwgNSkgfHwNCj4gKwkJICAgICFzdHJuY21wKG5hbWUsICJicGVyIiwg
NCkgIHx8DQo+ICsJCSAgICBzdHJzdHIobmFtZSwgImN0ciIpICAgICAgICB8fA0KPiArCQkgICAg
c3Ryc3RyKG5hbWUsICJ0YXIiKSkNCj4gKwkJCXJldHVybiBOVUxMOw0KDQoJTW9yZSBpbXBvcnRh
bnRseSB5b3UgbGVhayAnaW5zJyBhbmQgJ2lucy0+bmFtZScgaGVyZS4NCglBbmQgb24gb3RoZXIg
cGF0aHMgYmVsb3cuDQoNCi4uLg0KDQoJRGF2aWQNCg0K

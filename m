Return-Path: <B40534@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 146262C00E1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 14:01:39 +1000 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, "daniel.lezcano@linaro.org"
 <daniel.lezcano@linaro.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "michael@ellerman.id.au"
 <michael@ellerman.id.au>, "srivatsa.bhat@linux.vnet.ibm.com"
 <srivatsa.bhat@linux.vnet.ibm.com>, "preeti@linux.vnet.ibm.com"
 <preeti@linux.vnet.ibm.com>, "svaidy@linux.vnet.ibm.com"
 <svaidy@linux.vnet.ibm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH V2 5/6] cpuidle/powerpc: Backend-powerpc idle driver for
 powernv and pseries.
Date: Wed, 31 Jul 2013 04:01:31 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259FF29B4@039-SN2MPN1-021.039d.mgd.msft.net>
References: <20130731025840.19448.24468.stgit@deepthi>
 <20130731025934.19448.16658.stgit@deepthi>
In-Reply-To: <20130731025934.19448.16658.stgit@deepthi>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "rjw@sisk.pl" <rjw@sisk.pl>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gDQo+IC1zdGF0aWMgaW50IHBzZXJpZXNfY3B1aWRsZV9hZGRfY3B1X25vdGlmaWVyKHN0
cnVjdCBub3RpZmllcl9ibG9jayAqbiwNCj4gK3N0YXRpYyBpbnQgcG93ZXJwY19jcHVpZGxlX2Fk
ZF9jcHVfbm90aWZpZXIoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuLA0KPiAgCQkJdW5zaWduZWQg
bG9uZyBhY3Rpb24sIHZvaWQgKmhjcHUpDQo+ICB7DQo+ICAJaW50IGhvdGNwdSA9ICh1bnNpZ25l
ZCBsb25nKWhjcHU7DQo+ICAJc3RydWN0IGNwdWlkbGVfZGV2aWNlICpkZXYgPQ0KPiAtCQkJcGVy
X2NwdV9wdHIocHNlcmllc19jcHVpZGxlX2RldmljZXMsIGhvdGNwdSk7DQo+ICsJCQlwZXJfY3B1
X3B0cihwb3dlcnBjX2NwdWlkbGVfZGV2aWNlcywgaG90Y3B1KTsNCj4gDQo+ICAJaWYgKGRldiAm
JiBjcHVpZGxlX2dldF9kcml2ZXIoKSkgew0KPiAgCQlzd2l0Y2ggKGFjdGlvbikgew0KPiBAQCAt
MjM1LDE2ICsyNzAsMTYgQEAgc3RhdGljIGludCBwc2VyaWVzX2NwdWlkbGVfYWRkX2NwdV9ub3Rp
ZmllcihzdHJ1Y3QNCj4gbm90aWZpZXJfYmxvY2sgKm4sDQo+ICB9DQo+IA0KPiAgc3RhdGljIHN0
cnVjdCBub3RpZmllcl9ibG9jayBzZXR1cF9ob3RwbHVnX25vdGlmaWVyID0gew0KPiAtCS5ub3Rp
Zmllcl9jYWxsID0gcHNlcmllc19jcHVpZGxlX2FkZF9jcHVfbm90aWZpZXIsDQo+ICsJLm5vdGlm
aWVyX2NhbGwgPSBwb3dlcnBjX2NwdWlkbGVfYWRkX2NwdV9ub3RpZmllciwNCj4gIH07DQo+IA0K
SSB0aGluayBEYW5pZWwgbWVhbnMgbW92ZSB0aGUgbm90aWZpZXIgdG8gY3B1aWRsZSBmcmFtZXdv
cmssIG5vdCBqdXN0IHBvd2VycGMuDQoNCkFuZCBzaG91bGQgYmUgcmVtb3ZlIGFsbCBhYm91dCAq
ZGV2aWNlKi4gSWYgdGhlIG5vdGlmaWVyIGhhbmRsZSB1c2luZyBkZXZpY2UsDQp5b3UgY2FuIHVz
ZSAiY3B1aWRsZV9kZXZpY2VzIi4NCg0KLSBkb25nc2hlbmcNCg0KPiAtc3RhdGljIGludCBfX2lu
aXQgcHNlcmllc19wcm9jZXNzb3JfaWRsZV9pbml0KHZvaWQpDQo+ICtzdGF0aWMgaW50IF9faW5p
dCBwb3dlcnBjX3Byb2Nlc3Nvcl9pZGxlX2luaXQodm9pZCkNCj4gIHsNCj4gIAlpbnQgcmV0dmFs
Ow0KPiANCj4gLQlyZXR2YWwgPSBwc2VyaWVzX2lkbGVfcHJvYmUoKTsNCj4gKwlyZXR2YWwgPSBw
b3dlcnBjX2lkbGVfcHJvYmUoKTsNCj4gIAlpZiAocmV0dmFsKQ0KPiAgCQlyZXR1cm4gcmV0dmFs
Ow0KPiANCj4gLQlwc2VyaWVzX2NwdWlkbGVfZHJpdmVyX2luaXQoKTsNCj4gLQlyZXR2YWwgPSBj
cHVpZGxlX3JlZ2lzdGVyX2RyaXZlcigmcHNlcmllc19pZGxlX2RyaXZlcik7DQo+ICsJcG93ZXJw
Y19jcHVpZGxlX2RyaXZlcl9pbml0KCk7DQo+ICsJcmV0dmFsID0gY3B1aWRsZV9yZWdpc3Rlcl9k
cml2ZXIoJnBvd2VycGNfaWRsZV9kcml2ZXIpOw0KPiAgCWlmIChyZXR2YWwpIHsNCj4gLQkJcHJp
bnRrKEtFUk5fREVCVUcgIlJlZ2lzdHJhdGlvbiBvZiBwc2VyaWVzIGRyaXZlciBmYWlsZWQuXG4i
KTsNCj4gKwkJcHJpbnRrKEtFUk5fREVCVUcgIlJlZ2lzdHJhdGlvbiBvZiBwb3dlcnBjIGRyaXZl
ciBmYWlsZWQuXG4iKTsNCj4gIAkJcmV0dXJuIHJldHZhbDsNCj4gIAl9DQo+IA0KPiAgCXVwZGF0
ZV9zbXRfc25vb3plX2RlbGF5KC0xLCBwZXJfY3B1KHNtdF9zbm9vemVfZGVsYXksIDApKTsNCj4g
DQo+IC0JcmV0dmFsID0gcHNlcmllc19pZGxlX2RldmljZXNfaW5pdCgpOw0KPiArCXJldHZhbCA9
IHBvd2VycGNfaWRsZV9kZXZpY2VzX2luaXQoKTsNClNob3VsZCBiZSByZW1vdmUgYWxsICpkZXZp
Y2UqLCB1c2luZyBjcHVpZGxlX3JlZ2lzdGVyLg0KDQotIGRvbmdzaGVuZw0KDQo=

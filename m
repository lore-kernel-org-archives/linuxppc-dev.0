Return-Path: <zhiqiang.hou@nxp.com>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0076.outbound.protection.outlook.com [157.56.112.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D9AE01A0166
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 14:57:13 +1100 (AEDT)
From: Zhiqiang Hou <zhiqiang.hou@nxp.com>
To: Zhiqiang Hou <Zhiqiang.Hou@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>
CC: Scott Wood <scottwood@freescale.com>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "robh@kernel.org" <robh@kernel.org>,
 "Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>
Subject: RE: [PATCH] powerpc/fsl-pci: Correct the comparison of the LTSSM
Date: Mon, 1 Feb 2016 03:57:05 +0000
Message-ID: <HE1PR04MB0906BB81802E707FEF34619B84DE0@HE1PR04MB0906.eurprd04.prod.outlook.com>
References: <1451893517-20934-1-git-send-email-Zhiqiang.Hou@freescale.com>
In-Reply-To: <1451893517-20934-1-git-send-email-Zhiqiang.Hou@freescale.com>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SGksDQoNCkFueSBjb21tZW50cz8NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBaaGlxaWFuZyBIb3UgW21haWx0bzpaaGlxaWFuZy5Ib3VAZnJlZXNjYWxlLmNvbV0NCj4g
U2VudDogMjAxNsTqMdTCNMjVIDE1OjQ1DQo+IFRvOiBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJz
Lm9yZzsgYmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnOyBwYXVsdXNAc2FtYmEub3JnOw0KPiBtcGVA
ZWxsZXJtYW4uaWQuYXUNCj4gQ2M6IFNjb3R0IFdvb2QgPHNjb3R0d29vZEBmcmVlc2NhbGUuY29t
PjsgYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsNCj4gcm9iaEBrZXJuZWwub3JnOyBNaW5na2Fp
Lkh1QGZyZWVzY2FsZS5jb207IEhvdSBaaGlxaWFuZw0KPiA8WmhpcWlhbmcuSG91QGZyZWVzY2Fs
ZS5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gcG93ZXJwYy9mc2wtcGNpOiBDb3JyZWN0IHRoZSBj
b21wYXJpc29uIG9mIHRoZSBMVFNTTQ0KPiANCj4gRnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFu
Zy5Ib3VAZnJlZXNjYWxlLmNvbT4NCj4gDQo+IE9ubHkgdGhlIHZhbHVlIFBDSUVfTFRTU01fTDAg
c3RhbmRzIGZvciB0aGUgbGluayBpcyB1cCwgaW5zdGVhZCBvZiA+PQ0KPiBQQ0lFX0xUU1NNX0ww
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAZnJlZXNj
YWxlLmNvbT4NCj4gLS0tDQo+ICBhcmNoL3Bvd2VycGMvc3lzZGV2L2ZzbF9wY2kuYyB8IDIgKy0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9zeXNkZXYvZnNsX3BjaS5jIGIvYXJjaC9wb3dlcnBj
L3N5c2Rldi9mc2xfcGNpLmMgaW5kZXgNCj4gNjEwZjQ3Mi4uMTU5NWY1NSAxMDA2NDQNCj4gLS0t
IGEvYXJjaC9wb3dlcnBjL3N5c2Rldi9mc2xfcGNpLmMNCj4gKysrIGIvYXJjaC9wb3dlcnBjL3N5
c2Rldi9mc2xfcGNpLmMNCj4gQEAgLTczLDcgKzczLDcgQEAgc3RhdGljIGludCBmc2xfcGNpZV9j
aGVja19saW5rKHN0cnVjdCBwY2lfY29udHJvbGxlciAqaG9zZSkNCj4gIAkJCQkJICAgICAgIFBD
SUVfTFRTU00sIDQsICZ2YWwpOw0KPiAgCQllbHNlDQo+ICAJCQllYXJseV9yZWFkX2NvbmZpZ19k
d29yZChob3NlLCAwLCAwLCBQQ0lFX0xUU1NNLCAmdmFsKTsNCj4gLQkJaWYgKHZhbCA8IFBDSUVf
TFRTU01fTDApDQo+ICsJCWlmICh2YWwgIT0gUENJRV9MVFNTTV9MMCkNCj4gIAkJCXJldHVybiAx
Ow0KPiAgCX0gZWxzZSB7DQo+ICAJCXN0cnVjdCBjY3NyX3BjaSBfX2lvbWVtICpwY2kgPSBob3Nl
LT5wcml2YXRlX2RhdGE7DQo+IC0tDQo+IDIuMS4wLjI3Lmc5NmRiMzI0DQoNClRoYW5rcywNClpo
aXFpYW5nDQo=

Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.183])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420DD1A08CB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 00:06:35 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Joakim Tjernlund' <Joakim.Tjernlund@transmode.se>,
 "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>
Subject: RE: [PATCH 05/11] powerpc/8xx: Optimise access to swapper_pg_dir
Date: Tue, 6 Jan 2015 12:08:09 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CAC1765@AcuExch.aculab.com>
References: <20141216150338.D4F0A1A5E0A@localhost.localdomain>
 <1420482826.25047.26.camel@transmode.se>
In-Reply-To: <1420482826.25047.26.camel@transmode.se>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "scottwood@freescale.com" <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiBPbiBUdWUsIDIwMTQtMTItMTYgYXQgMTY6MDMgKzAxMDAsIENocmlzdG9waGUgTGVyb3kgd3Jv
dGU6DQo+ID4gQWxsIGFjY2Vzc2VkIHRvIFBHRCBlbnRyaWVzIGFyZSBkb25lIHZpYSAwKHIxMSku
DQo+ID4gQnkgdXNpbmcgbG93ZXIgcGFydCBvZiBzd2FwcGVyX3BnX2RpciBhcyBsb2FkIGluZGV4
IHRvIHIxMSwgd2UgY2FuIHJlbW92ZSB0aGUNCj4gPiBvcmkgaW5zdHJ1Y3Rpb24uDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGMtcy5m
cj4NCj4gDQo+IE5pY2UgOikNCj4gQWNrZWQtYnk6IEpvYWtpbSBUamVybmx1bmQgPGpvYWtpbS50
amVybmx1bmRAdHJhbnNtb2RlLnNlPg0KPiANCj4gPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL3Bvd2Vy
cGMva2VybmVsL2hlYWRfOHh4LlMgfCAyMiArKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMva2VybmVsL2hlYWRfOHh4LlMgYi9hcmNoL3Bvd2Vy
cGMva2VybmVsL2hlYWRfOHh4LlMNCj4gPiBpbmRleCBhZTA1ZjI4Li5hYTQ1MjI1IDEwMDY0NA0K
PiA+IC0tLSBhL2FyY2gvcG93ZXJwYy9rZXJuZWwvaGVhZF84eHguUw0KPiA+ICsrKyBiL2FyY2gv
cG93ZXJwYy9rZXJuZWwvaGVhZF84eHguUw0KPiA+IEBAIC0zMjIsMTMgKzMyMiwxMiBAQCBJbnN0
cnVjdGlvblRMQk1pc3M6DQo+ID4gICAgICAgICBtZnNwciAgIHIxMSwgU1BSTl9NX1RXLyogR2V0
IGxldmVsIDEgdGFibGUgYmFzZSBhZGRyZXNzICovDQo+ID4gICNpZmRlZiBDT05GSUdfTU9EVUxF
Uw0KPiA+ICAgICAgICAgYmVxICAgICAzZg0KPiA+IC0gICAgICAgbGlzICAgICByMTEsIChzd2Fw
cGVyX3BnX2Rpci1QQUdFX09GRlNFVClAaA0KPiA+IC0gICAgICAgb3JpICAgICByMTEsIHIxMSwg
KHN3YXBwZXJfcGdfZGlyLVBBR0VfT0ZGU0VUKUBsDQo+ID4gKyAgICAgICBsaXMgICAgIHIxMSwg
KHN3YXBwZXJfcGdfZGlyLVBBR0VfT0ZGU0VUKUBoYQ0KPiA+ICAzOg0KPiA+ICAjZW5kaWYNCj4g
PiAgICAgICAgIC8qIEluc2VydCBsZXZlbCAxIGluZGV4ICovDQo+ID4gICAgICAgICBybHdpbWkg
IHIxMSwgcjEwLCAzMiAtICgoUEFHRV9TSElGVCAtIDIpIDw8IDEpLCAoUEFHRV9TSElGVCAtIDIp
IDw8IDEsIDI5DQo+ID4gLSAgICAgICBsd3ogICAgIHIxMSwgMChyMTEpLyogR2V0IHRoZSBsZXZl
bCAxIGVudHJ5ICovDQo+ID4gKyAgICAgICBsd3ogICAgIHIxMSwgKHN3YXBwZXJfcGdfZGlyLVBB
R0VfT0ZGU0VUKUBsKHIxMSkvKiBHZXQgdGhlIGxldmVsIDEgZW50cnkgKi8NCj4gPg0KDQpPbiB0
aGUgZmFjZSBvZiBpdCB0aGF0IGZyYWdtZW50IGRvZXNuJ3QgbG9vayByaWdodCB3aGVuIENPTkZJ
R19NT0RVTEVTIGlzIHVuZGVmaW5lZC4NCg0KCURhdmlkDQoNCg==

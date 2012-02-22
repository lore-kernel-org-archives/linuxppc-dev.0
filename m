Return-Path: <B13201@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 40AF7B6EE8
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Feb 2012 13:29:18 +1100 (EST)
From: Liu Yu-B13201 <B13201@freescale.com>
To: tiejun.chen <tiejun.chen@windriver.com>
Subject: RE: [PATCH v5 3/4] KVM: PPC: epapr: install ev_idle hcall for e500
 guest
Date: Wed, 22 Feb 2012 02:29:10 +0000
Message-ID: <4CA99838F21AB847ACC344051E23170905749AB6@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1329799573-8820-1-git-send-email-yu.liu@freescale.com>
 <1329799573-8820-2-git-send-email-yu.liu@freescale.com>
 <1329799573-8820-3-git-send-email-yu.liu@freescale.com>
 <4F4377AD.4000501@windriver.com>
In-Reply-To: <4F4377AD.4000501@windriver.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Wood Scott-B07421 <B07421@freescale.com>, "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogdGllanVuLmNoZW4gW21h
aWx0bzp0aWVqdW4uY2hlbkB3aW5kcml2ZXIuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFy
eSAyMSwgMjAxMiA2OjU0IFBNDQo+IFRvOiBMaXUgWXUtQjEzMjAxDQo+IENjOiBhZ3JhZkBzdXNl
LmRlOyBrdm0tcHBjQHZnZXIua2VybmVsLm9yZzsga3ZtQHZnZXIua2VybmVsLm9yZzsNCj4gbGlu
dXhwcGMtZGV2QG96bGFicy5vcmc7IFdvb2QgU2NvdHQtQjA3NDIxDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjUgMy80XSBLVk06IFBQQzogZXBhcHI6IGluc3RhbGwgZXZfaWRsZSBoY2FsbCBmb3IN
Cj4gZTUwMCBndWVzdA0KPiANCj4gTGl1IFl1IHdyb3RlOg0KPiA+IElmIHRoZSBndWVzdCBoeXBl
cnZpc29yIG5vZGUgY29udGFpbnMgImhhcy1pZGxlIiBwcm9wZXJ0eS4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IExpdSBZdSA8eXUubGl1QGZyZWVzY2FsZS5jb20+DQo+ID4gLS0tDQo+ID4gdjU6
IG5vIGNoYW5nZQ0KPiA+DQo+ID4gIGFyY2gvcG93ZXJwYy9rZXJuZWwvZXBhcHJfaGNhbGxzLlMg
ICB8ICAgMjkNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgYXJjaC9wb3dl
cnBjL2tlcm5lbC9lcGFwcl9wYXJhdmlydC5jIHwgICAxMSArKysrKysrKysrLQ0KPiA+ICAyIGZp
bGVzIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL2tlcm5lbC9lcGFwcl9oY2FsbHMuUw0KPiA+IGIvYXJj
aC9wb3dlcnBjL2tlcm5lbC9lcGFwcl9oY2FsbHMuUw0KPiA+IGluZGV4IDY5N2IzOTAuLjcyZmEy
MzQgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9wb3dlcnBjL2tlcm5lbC9lcGFwcl9oY2FsbHMuUw0K
PiA+ICsrKyBiL2FyY2gvcG93ZXJwYy9rZXJuZWwvZXBhcHJfaGNhbGxzLlMNCj4gPiBAQCAtMTUs
NiArMTUsMzUgQEANCj4gPiAgI2luY2x1ZGUgPGFzbS9wcGNfYXNtLmg+DQo+ID4gICNpbmNsdWRl
IDxhc20vYXNtLW9mZnNldHMuaD4NCj4gPg0KPiA+ICsjZGVmaW5lIEhDX1ZFTkRPUl9FUEFQUgkJ
KDEgPDwgMTYpDQo+ID4gKyNkZWZpbmUgSENfRVZfSURMRQkJMTYNCj4gDQo+IFdoeSBub3QgdXNl
ICdFVl9JRExFJyBkaXJlY3RseT8NCj4gDQo+ID4gKw0KPiA+ICtfR0xPQkFMKGVwYXByX2V2X2lk
bGUpDQo+ID4gK2VwYXByX2V2X2lkbGU6DQo+ID4gKwlybHdpbm0JcjMscjEsMCwwLDMxLVRIUkVB
RF9TSElGVAkvKiBjdXJyZW50IHRocmVhZF9pbmZvICovDQo+ID4gKwlsd3oJcjQsVElfTE9DQUxf
RkxBR1MocjMpCS8qIHNldCBuYXBwaW5nIGJpdCAqLw0KPiA+ICsJb3JpCXI0LHI0LF9UTEZfTkFQ
UElORwkvKiBzbyB3aGVuIHdlIHRha2UgYW4gZXhjZXB0aW9uICovDQo+ID4gKwlzdHcJcjQsVElf
TE9DQUxfRkxBR1MocjMpCS8qIGl0IHdpbGwgcmV0dXJuIHRvIG91ciBjYWxsZXIgKi8NCj4gPiAr
DQo+ID4gKwl3cnRlZWkJMQ0KPiA+ICsNCj4gPiAraWRsZV9sb29wOg0KPiA+ICsJTE9BRF9SRUdf
SU1NRURJQVRFKHIxMSwgSENfVkVORE9SX0VQQVBSIHwgSENfRVZfSURMRSkNCj4gDQo+IEFuZCBj
b3VsZCB0aGlzIGxpbmUgYmUgc2ltcGxpZmllZCBhcyBzb21ldGhpbmcgbGlrZSB0aGlzOg0KPiAN
Cj4gTE9BRF9SRUdfSU1NRURJQVRFKHIxMSwgRVZfSENBTExfVE9LRU4oRVZfSURMRSkpDQo+IA0K
PiBJZiBzbywgZXZlbiB3ZSBjYW4gcmVtb3ZlIHRoZSBwcmV2aW91cyBIQ19WRU5ET1JfRVBBUFIg
ZGVmaW5pdGlvbiBhcyB3ZWxsLg0KPiANCg0KQmVjYXVzZSB0aGUgZXBhcHJfaGNhbGxzLmggY29u
dGFpbnMgQyBmdW5jdGlvbnMsDQpzbyBpdCBjYW5ub3QgYmUgaW5jbHVkZWQgYnkgYXNzZW1ibHkg
Y29kZS4NCg0KVGhhbmtzLA0KWXUNCg==

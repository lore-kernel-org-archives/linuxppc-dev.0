Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0183.outbound.protection.outlook.com [207.46.163.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C5ABF1A0097
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 06:02:38 +1000 (EST)
From: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH v3] KVM: PPC: e500mc: Enhance tlb invalidation condition
 on vcpu schedule
Date: Tue, 17 Jun 2014 20:02:29 +0000
Message-ID: <924c92bfa28a4d4096c3cbe0f7219123@BY2PR03MB508.namprd03.prod.outlook.com>
References: <1403032176-28362-1-git-send-email-mihai.caraman@freescale.com>
 <1403032706.6603.776.camel@snotra.buserror.net>
 <37af68eb6855437892a438eec213d788@BY2PR03MB508.namprd03.prod.outlook.com>
 <1403034451.6603.788.camel@snotra.buserror.net>
In-Reply-To: <1403034451.6603.788.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXb29kIFNjb3R0LUIwNzQyMQ0K
PiBTZW50OiBUdWVzZGF5LCBKdW5lIDE3LCAyMDE0IDEwOjQ4IFBNDQo+IFRvOiBDYXJhbWFuIE1p
aGFpIENsYXVkaXUtQjAyMDA4DQo+IENjOiBrdm0tcHBjQHZnZXIua2VybmVsLm9yZzsga3ZtQHZn
ZXIua2VybmVsLm9yZzsgbGludXhwcGMtDQo+IGRldkBsaXN0cy5vemxhYnMub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjNdIEtWTTogUFBDOiBlNTAwbWM6IEVuaGFuY2UgdGxiIGludmFsaWRh
dGlvbg0KPiBjb25kaXRpb24gb24gdmNwdSBzY2hlZHVsZQ0KPiANCj4gT24gVHVlLCAyMDE0LTA2
LTE3IGF0IDE0OjQyIC0wNTAwLCBDYXJhbWFuIE1paGFpIENsYXVkaXUtQjAyMDA4IHdyb3RlOg0K
PiA+ID4gPiAtc3RhdGljIERFRklORV9QRVJfQ1BVKHN0cnVjdCBrdm1fdmNwdSAqLCBsYXN0X3Zj
cHVfb25fY3B1KTsNCj4gPiA+ID4gK3N0YXRpYyBERUZJTkVfUEVSX0NQVShzdHJ1Y3Qga3ZtX3Zj
cHUgKiBbS1ZNUFBDX05SX0xQSURTXSwNCj4gPiA+IGxhc3RfdmNwdV9vbl9jcHUpOw0KPiA+ID4N
Cj4gPiA+IEhtbSwgSSBkaWRuJ3Qga25vdyB5b3UgY291bGQgZXhwcmVzcyB0eXBlcyBsaWtlIHRo
YXQuICBJcyB0aGlzDQo+IHNwZWNpYWwNCj4gPiA+IHN5bnRheCB0aGF0IG9ubHkgd29ya3MgZm9y
IHR5cGVvZj8NCj4gPg0KPiA+IFllcywgQUZBSUsuDQo+ID4NCj4gPiA+IE5vIHNwYWNlIGFmdGVy
ICoNCj4gPg0KPiA+IENoZWNrcGF0Y2ggY29tcGxhaW5zIGFib3V0IHRoZSBtaXNzaW5nIHNwYWNl
IDspDQo+IA0KPiBDaGVja3BhdGNoIGlzIHdyb25nLCB3aGljaCBpc24ndCBzdXJwcmlzaW5nIGdp
dmVuIHRoYXQgdGhpcyBpcyB1bnVzdWFsDQo+IHN5bnRheC4gIFdlIGRvbid0IG5vcm1hbGx5IHB1
dCBhIHNwYWNlIGFmdGVyICogd2hlbiB1c2VkIHRvIHJlcHJlc2VudCBhDQo+IHBvaW50ZXIuDQoN
ClRoaXMgaXMgbm90IHNvbWV0aGluZyBuZXcuIFNlZSBbUEFUQ0ggMDQvMTBdIHBlcmNwdTogY2xl
YW51cCBwZXJjcHUgYXJyYXkNCmRlZmluaXRpb25zOg0KDQoJaHR0cHM6Ly9sa21sLm9yZy9sa21s
LzIwMDkvNi8yNC8yNg0KDQotTWlrZQ0K

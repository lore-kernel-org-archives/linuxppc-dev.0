Return-Path: <mihai.caraman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0237.outbound.protection.outlook.com [207.46.163.237])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8EC141A0324
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 06:36:13 +1000 (EST)
From: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>
To: Scott Wood <scottwood@freescale.com>, Alexander Graf <B36701@freescale.com>
Subject: RE: [PATCH v3] KVM: PPC: e500mc: Enhance tlb invalidation condition
 on vcpu schedule
Date: Tue, 17 Jun 2014 20:36:05 +0000
Message-ID: <074d849370834f748fe442ed851c0dad@BY2PR03MB508.namprd03.prod.outlook.com>
References: <1403032176-28362-1-git-send-email-mihai.caraman@freescale.com>
 <1403032706.6603.776.camel@snotra.buserror.net>
 <37af68eb6855437892a438eec213d788@BY2PR03MB508.namprd03.prod.outlook.com>
 <1403034451.6603.788.camel@snotra.buserror.net>
 <924c92bfa28a4d4096c3cbe0f7219123@BY2PR03MB508.namprd03.prod.outlook.com>
 <1403035510.6603.801.camel@snotra.buserror.net>
In-Reply-To: <1403035510.6603.801.camel@snotra.buserror.net>
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
PiBTZW50OiBUdWVzZGF5LCBKdW5lIDE3LCAyMDE0IDExOjA1IFBNDQo+IFRvOiBDYXJhbWFuIE1p
aGFpIENsYXVkaXUtQjAyMDA4DQo+IENjOiBrdm0tcHBjQHZnZXIua2VybmVsLm9yZzsga3ZtQHZn
ZXIua2VybmVsLm9yZzsgbGludXhwcGMtDQo+IGRldkBsaXN0cy5vemxhYnMub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjNdIEtWTTogUFBDOiBlNTAwbWM6IEVuaGFuY2UgdGxiIGludmFsaWRh
dGlvbg0KPiBjb25kaXRpb24gb24gdmNwdSBzY2hlZHVsZQ0KPiANCj4gT24gVHVlLCAyMDE0LTA2
LTE3IGF0IDE1OjAyIC0wNTAwLCBDYXJhbWFuIE1paGFpIENsYXVkaXUtQjAyMDA4IHdyb3RlOg0K
PiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFdvb2QgU2NvdHQt
QjA3NDIxDQo+ID4gPiBTZW50OiBUdWVzZGF5LCBKdW5lIDE3LCAyMDE0IDEwOjQ4IFBNDQo+ID4g
PiBUbzogQ2FyYW1hbiBNaWhhaSBDbGF1ZGl1LUIwMjAwOA0KPiA+ID4gQ2M6IGt2bS1wcGNAdmdl
ci5rZXJuZWwub3JnOyBrdm1Admdlci5rZXJuZWwub3JnOyBsaW51eHBwYy0NCj4gPiA+IGRldkBs
aXN0cy5vemxhYnMub3JnDQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzXSBLVk06IFBQQzog
ZTUwMG1jOiBFbmhhbmNlIHRsYiBpbnZhbGlkYXRpb24NCj4gPiA+IGNvbmRpdGlvbiBvbiB2Y3B1
IHNjaGVkdWxlDQo+ID4gPg0KPiA+ID4gT24gVHVlLCAyMDE0LTA2LTE3IGF0IDE0OjQyIC0wNTAw
LCBDYXJhbWFuIE1paGFpIENsYXVkaXUtQjAyMDA4DQo+IHdyb3RlOg0KPiA+ID4gPiA+ID4gLXN0
YXRpYyBERUZJTkVfUEVSX0NQVShzdHJ1Y3Qga3ZtX3ZjcHUgKiwgbGFzdF92Y3B1X29uX2NwdSk7
DQo+ID4gPiA+ID4gPiArc3RhdGljIERFRklORV9QRVJfQ1BVKHN0cnVjdCBrdm1fdmNwdSAqIFtL
Vk1QUENfTlJfTFBJRFNdLA0KPiA+ID4gPiA+IGxhc3RfdmNwdV9vbl9jcHUpOw0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gSG1tLCBJIGRpZG4ndCBrbm93IHlvdSBjb3VsZCBleHByZXNzIHR5cGVzIGxp
a2UgdGhhdC4gIElzIHRoaXMNCj4gPiA+IHNwZWNpYWwNCj4gPiA+ID4gPiBzeW50YXggdGhhdCBv
bmx5IHdvcmtzIGZvciB0eXBlb2Y/DQo+ID4gPiA+DQo+ID4gPiA+IFllcywgQUZBSUsuDQo+ID4g
PiA+DQo+ID4gPiA+ID4gTm8gc3BhY2UgYWZ0ZXIgKg0KPiA+ID4gPg0KPiA+ID4gPiBDaGVja3Bh
dGNoIGNvbXBsYWlucyBhYm91dCB0aGUgbWlzc2luZyBzcGFjZSA7KQ0KPiA+ID4NCj4gPiA+IENo
ZWNrcGF0Y2ggaXMgd3JvbmcsIHdoaWNoIGlzbid0IHN1cnByaXNpbmcgZ2l2ZW4gdGhhdCB0aGlz
IGlzDQo+IHVudXN1YWwNCj4gPiA+IHN5bnRheC4gIFdlIGRvbid0IG5vcm1hbGx5IHB1dCBhIHNw
YWNlIGFmdGVyICogd2hlbiB1c2VkIHRvIHJlcHJlc2VudA0KPiBhDQo+ID4gPiBwb2ludGVyLg0K
PiA+DQo+ID4gVGhpcyBpcyBub3Qgc29tZXRoaW5nIG5ldy4gU2VlIFtQQVRDSCAwNC8xMF0gcGVy
Y3B1OiBjbGVhbnVwIHBlcmNwdQ0KPiBhcnJheQ0KPiA+IGRlZmluaXRpb25zOg0KPiA+DQo+ID4g
CWh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDA5LzYvMjQvMjYNCj4gDQo+IEkgZGlkbid0IHNheSBp
dCB3YXMgbmV3LCBqdXN0IHVudXN1YWwsIGFuZCBjaGVja3BhdGNoIGRvZXNuJ3QgcmVjb2duaXpl
DQo+IGl0LiAgQ2hlY2twYXRjaCBzaG91bGRuJ3QgYmUgYmxpbmRseSBhbmQgc2lsZW50bHkgb2Jl
eWVkIHdoZW4gaXQgc2F5cw0KPiBzb21ldGhpbmcgc3RyYW5nZS4NCg0KSSBhZ3JlZSB3aXRoIHlv
dSBhYm91dCB0aGUgc3ludGF4IGFuZCBJIGtub3cgb3RoZXIgY2FzZXMgd2hlcmUgY2hlY2twYXRj
aA0KaXMgYSBtb3Jvbi4gRm9yIHNpbWlsYXIgY29ybmVyIGNhc2VzIGNoZWNrcGF0Y2ggbWFpbnRh
aW5lcnMgZGlkIG5vdCB3YW50ZWQNCihvciBmb3VuZCBpdCBkaWZmaWN1bHQpIHRvIG1ha2UgYW4g
ZXhjZXB0aW9uLiBJIHdvdWxkIGFsc28gbGlrZSB0byBzZWUgQWxleA0Kb3BpbmlvbiBvbiB0aGlz
Lg0KDQotTWlrZQ0KDQoNCg==

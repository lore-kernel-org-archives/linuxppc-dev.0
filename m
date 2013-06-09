Return-Path: <B40534@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 421AE2C041F
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Jun 2013 17:57:47 +1000 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: [PATCH v2 2/2] powerpc/hibernate: PPC64 fix user threads access
 to kernel space
Date: Sun, 9 Jun 2013 07:57:37 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259F6E5D5@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1370755352-29901-1-git-send-email-dongsheng.wang@freescale.com>
 <1370760236.3766.481.camel@pasglop>
 <ABB05CD9C9F68C46A5CEDC7F15439259F6D57B@039-SN2MPN1-021.039d.mgd.msft.net>
 <1370763946.14883.24.camel@pasglop>
In-Reply-To: <1370763946.14883.24.camel@pasglop>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "anton@enomsg.org" <anton@enomsg.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmVuamFtaW4gSGVycmVu
c2NobWlkdCBbbWFpbHRvOmJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZ10NCj4gU2VudDogU3VuZGF5
LCBKdW5lIDA5LCAyMDEzIDM6NDYgUE0NCj4gVG86IFdhbmcgRG9uZ3NoZW5nLUI0MDUzNA0KPiBD
Yzogam9oYW5uZXNAc2lwc29sdXRpb25zLm5ldDsgYW50b25AZW5vbXNnLm9yZzsgV29vZCBTY290
dC1CMDc0MjE7DQo+IGdhbGFrQGtlcm5lbC5jcmFzaGluZy5vcmc7IGxpbnV4cHBjLWRldkBsaXN0
cy5vemxhYnMub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi8yXSBwb3dlcnBjL2hpYmVy
bmF0ZTogUFBDNjQgZml4IHVzZXIgdGhyZWFkcw0KPiBhY2Nlc3MgdG8ga2VybmVsIHNwYWNlDQo+
IA0KPiBPbiBTdW4sIDIwMTMtMDYtMDkgYXQgMDc6NDQgKzAwMDAsIFdhbmcgRG9uZ3NoZW5nLUI0
MDUzNCB3cm90ZToNCj4gPiBTbyB3ZSBqdXN0IG5lZWQgc2V0IHNldF9jb250ZXh0KCkgaW4gcmVz
dG9yZV9tbXVfY29udGV4dCgpLg0KPiA+DQo+ID4gdm9pZCByZXN0b3JlX21tdV9jb250ZXh0KHN0
cnVjdCBtbV9zdHJ1Y3QgKm5leHQpIHsNCj4gPiAgICAgICAgIHNldF9jb250ZXh0KG5leHQtPmNv
bnRleHQuaWQsIG5leHQtPnBnZCk7IH0NCj4gDQo+IFdlIHByb2JhYmx5IGFsc28gd2FudCB0byBm
bHVzaCB0aGUgVExCLCBqdXN0IGluIGNhc2UgdGhlIGJvb3Qga2VybmVsIGhhcw0KPiBsZWZ0ICJz
b21ldGhpbmciIHRoZXJlICh0aG91Z2ggSSB3b3VsZG4ndCBleHBlY3QgaXQgdG8gaGF2ZSBydW4g
dXNlcnNwYWNlDQo+IGl0J3Mgbm90IGNvbXBsZXRlbHkgaW1wb3NzaWJsZSkuDQo+IA0KWWVzLCBi
dXQgVExCIGhhcyBhbHJlYWR5IGludmFsaWRhdGVkLg0KU2VlIG15IG90aGVyIHBhdGNoOg0KaHR0
cDovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLzI1MDAwNi8NCg0KPiBDaGVlcnMsDQo+IEJl
bi4NCj4gDQo+IA0KDQo=

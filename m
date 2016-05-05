Return-Path: <kevin.tian@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by lists.ozlabs.org (Postfix) with ESMTP id 3r0v546vgbzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 22:15:52 +1000 (AEST)
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>, David Laight
 <David.Laight@ACULAB.COM>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "joro@8bytes.org" <joro@8bytes.org>, "warrier@linux.vnet.ibm.com"
 <warrier@linux.vnet.ibm.com>, "zhong@linux.vnet.ibm.com"
 <zhong@linux.vnet.ibm.com>, "nikunj@linux.vnet.ibm.com"
 <nikunj@linux.vnet.ibm.com>, "eric.auger@linaro.org" <eric.auger@linaro.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>, "gwshan@linux.vnet.ibm.com"
 <gwshan@linux.vnet.ibm.com>, "alistair@popple.id.au" <alistair@popple.id.au>,
 "ruscur@russell.cc" <ruscur@russell.cc>
Subject: RE: [PATCH 5/5] vfio-pci: Allow to mmap MSI-X table if interrupt
 remapping is supported
Date: Thu, 5 May 2016 12:15:46 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D15F8474A4@SHSMSX101.ccr.corp.intel.com>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1461761010-5452-6-git-send-email-xyjxie@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F842512@SHSMSX101.ccr.corp.intel.com>
 <f7d73ac3-470d-a0d2-0a97-05be630480dd@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F842653@SHSMSX101.ccr.corp.intel.com>
 <e064a6a7-a8dc-f71f-1725-f31e03581b8d@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F847150@SHSMSX101.ccr.corp.intel.com>
 <063D6719AE5E284EB5DD2968C1650D6D5F4B52B5@AcuExch.aculab.com>
 <4be013bc-e81b-84c5-06d3-e1b3f46b3227@linux.vnet.ibm.com>
In-Reply-To: <4be013bc-e81b-84c5-06d3-e1b3f46b3227@linux.vnet.ibm.com>
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

PiBGcm9tOiBZb25namkgWGllIFttYWlsdG86eHlqeGllQGxpbnV4LnZuZXQuaWJtLmNvbV0NCj4g
U2VudDogVGh1cnNkYXksIE1heSAwNSwgMjAxNiA3OjQzIFBNDQo+IA0KPiBIaSBEYXZpZCBhbmQg
S2V2aW4sDQo+IA0KPiBPbiAyMDE2LzUvNSAxNzo1NCwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KPiAN
Cj4gPiBGcm9tOiBUaWFuLCBLZXZpbg0KPiA+PiBTZW50OiAwNSBNYXkgMjAxNiAxMDozNw0KPiA+
IC4uLg0KPiA+Pj4gQWN1dHVhbGx5LCB3ZSBhcmUgbm90IGFpbWVkIGF0IGFjY2Vzc2luZyBNU0kt
WCB0YWJsZSBmcm9tDQo+ID4+PiBndWVzdC4gU28gSSB0aGluayBpdCdzIHNhZmUgdG8gcGFzc3Ro
cm91Z2ggTVNJLVggdGFibGUgaWYgd2UNCj4gPj4+IGNhbiBtYWtlIHN1cmUgZ3Vlc3Qga2VybmVs
IHdvdWxkIG5vdCB0b3VjaCBNU0ktWCB0YWJsZSBpbg0KPiA+Pj4gbm9ybWFsIGNvZGUgcGF0aCBz
dWNoIGFzIHBhcmEtdmlydHVhbGl6ZWQgZ3Vlc3Qga2VybmVsIG9uIFBQQzY0Lg0KPiA+Pj4NCj4g
Pj4gVGhlbiBob3cgZG8geW91IHByZXZlbnQgbWFsaWNpb3VzIGd1ZXN0IGtlcm5lbCBhY2Nlc3Np
bmcgaXQ/DQo+ID4gT3IgYSBtYWxpY2lvdXMgZ3Vlc3QgZHJpdmVyIGZvciBhbiBldGhlcm5ldCBj
YXJkIHNldHRpbmcgdXANCj4gPiB0aGUgcmVjZWl2ZSBidWZmZXIgcmluZyB0byBjb250YWluIGEg
c2luZ2xlIHdvcmQgZW50cnkgdGhhdA0KPiA+IGNvbnRhaW5zIHRoZSBhZGRyZXNzIGFzc29jaWF0
ZWQgd2l0aCBhbiBNU0ktWCBpbnRlcnJ1cHQgYW5kDQo+ID4gdGhlbiB1c2luZyBhIGxvb3BiYWNr
IG1vZGUgdG8gY2F1c2UgYSBzcGVjaWZpYyBwYWNrZXQgYmUNCj4gPiByZWNlaXZlZCB0aGF0IHdy
aXRlcyB0aGUgcmVxdWlyZWQgd29yZCB0aHJvdWdoIHRoYXQgYWRkcmVzcy4NCj4gPg0KPiA+IFJl
bWVtYmVyIHRoZSBQQ0llIGN5Y2xlIGZvciBhbiBpbnRlcnJ1cHQgaXMgYSBub3JtYWwgbWVtb3J5
IHdyaXRlDQo+ID4gY3ljbGUuDQo+ID4NCj4gPiAJRGF2aWQNCj4gPg0KPiANCj4gSWYgd2UgaGF2
ZSBlbm91Z2ggcGVybWlzc2lvbiB0byBsb2FkIGEgbWFsaWNpb3VzIGRyaXZlciBvcg0KPiBrZXJu
ZWwsIHdlIGNhbiBlYXNpbHkgYnJlYWsgdGhlIGd1ZXN0IHdpdGhvdXQgZXhwb3NlZA0KPiBNU0kt
WCB0YWJsZS4NCj4gDQo+IEkgdGhpbmsgaXQgc2hvdWxkIGJlIHNhZmUgdG8gZXhwb3NlIE1TSS1Y
IHRhYmxlIGlmIHdlIGNhbg0KPiBtYWtlIHN1cmUgdGhhdCBtYWxpY2lvdXMgZ3Vlc3QgZHJpdmVy
L2tlcm5lbCBjYW4ndCB1c2UNCj4gdGhlIE1TSS1YIHRhYmxlIHRvIGJyZWFrIG90aGVyIGd1ZXN0
IG9yIGhvc3QuIFRoZQ0KPiBjYXBhYmlsaXR5IG9mIElSUSByZW1hcHBpbmcgY291bGQgcHJvdmlk
ZSB0aGlzDQo+IGtpbmQgb2YgcHJvdGVjdGlvbi4NCj4gDQoNCldpdGggSVJRIHJlbWFwcGluZyBp
dCBkb2Vzbid0IG1lYW4geW91IGNhbiBwYXNzIHRocm91Z2ggTVNJLVgNCnN0cnVjdHVyZSB0byBn
dWVzdC4gSSBrbm93IGFjdHVhbCBJUlEgcmVtYXBwaW5nIG1pZ2h0IGJlIHBsYXRmb3JtDQpzcGVj
aWZpYywgYnV0IGF0IGxlYXN0IGZvciBJbnRlbCBWVC1kIHNwZWNpZmljYXRpb24sIE1TSS1YIGVu
dHJ5IG11c3QNCmJlIGNvbmZpZ3VyZWQgd2l0aCBhIHJlbWFwcGFibGUgZm9ybWF0IGJ5IGhvc3Qg
a2VybmVsIHdoaWNoDQpjb250YWlucyBhbiBpbmRleCBpbnRvIElSUSByZW1hcHBpbmcgdGFibGUu
IFRoZSBpbmRleCB3aWxsIGZpbmQgYQ0KSVJRIHJlbWFwcGluZyBlbnRyeSB3aGljaCBjb250cm9s
cyBpbnRlcnJ1cHQgcm91dGluZyBmb3IgYSBzcGVjaWZpYw0KZGV2aWNlLiBJZiB5b3UgYWxsb3cg
YSBtYWxpY2lvdXMgcHJvZ3JhbSByYW5kb20gaW5kZXggaW50byBNU0ktWCANCmVudHJ5IG9mIGFz
c2lnbmVkIGRldmljZSwgdGhlIGhvbGUgaXMgb2J2aW91cy4uLg0KDQpBYm92ZSBtaWdodCBtYWtl
IHNlbnNlIG9ubHkgZm9yIGEgSVJRIHJlbWFwcGluZyBpbXBsZW1lbnRhdGlvbiANCndoaWNoIGRv
ZXNuJ3QgcmVseSBvbiBleHRlbmRlZCBNU0ktWCBmb3JtYXQgKGUuZy4gc2ltcGx5IGJhc2VkIG9u
IA0KQkRGKS4gSWYgdGhhdCdzIHRoZSBjYXNlIGZvciBQUEMsIHRoZW4geW91IHNob3VsZCBidWls
ZCBNU0ktWCANCnBhc3N0aHJvdWdoIGJhc2VkIG9uIHRoaXMgZmFjdCBpbnN0ZWFkIG9mIGdlbmVy
YWwgSVJRIHJlbWFwcGluZyANCmVuYWJsZWQgb3Igbm90Lg0KDQpUaGFua3MNCktldmluDQo=

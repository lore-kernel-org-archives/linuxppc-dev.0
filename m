Return-Path: <kevin.tian@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qzW5V2V0HzDr4Z
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 16:11:25 +1000 (AEST)
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "corbet@lwn.net" <corbet@lwn.net>, "warrier@linux.vnet.ibm.com"
 <warrier@linux.vnet.ibm.com>, "zhong@linux.vnet.ibm.com"
 <zhong@linux.vnet.ibm.com>, "nikunj@linux.vnet.ibm.com"
 <nikunj@linux.vnet.ibm.com>, "gwshan@linux.vnet.ibm.com"
 <gwshan@linux.vnet.ibm.com>
Subject: RE: [PATCH] vfio-pci: Allow to mmap sub-page MMIO BARs if the mmio
 page is exclusive
Date: Tue, 3 May 2016 06:11:20 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D15F8425FE@SHSMSX101.ccr.corp.intel.com>
References: <1461759740-5072-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F84131D@SHSMSX101.ccr.corp.intel.com>
 <00243350-1ccc-75e5-8cd8-a58dfe14637f@linux.vnet.ibm.com>
In-Reply-To: <00243350-1ccc-75e5-8cd8-a58dfe14637f@linux.vnet.ibm.com>
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
U2VudDogVHVlc2RheSwgTWF5IDAzLCAyMDE2IDE6NTIgUE0NCj4gDQo+ID4+ICsNCj4gPj4gKwkJ
aWYgKCEocmVzLT5zdGFydCAmIH5QQUdFX01BU0spKSB7DQo+ID4+ICsJCQkvKg0KPiA+PiArCQkJ
ICogQWRkIHNoYWRvdyByZXNvdXJjZSBmb3Igc3ViLXBhZ2UgYmFyIHdob3NlIG1taW8NCj4gPj4g
KwkJCSAqIHBhZ2UgaXMgZXhjbHVzaXZlIGluIGNhc2UgdGhhdCBob3QtYWRkIGRldmljZSdzDQo+
ID4+ICsJCQkgKiBiYXIgaXMgYXNzaWduZWQgaW50byB0aGUgbWVtIGhvbGUuDQo+ID4+ICsJCQkg
Ki8NCj4gPj4gKwkJCXNoYWRvd19yZXMgPSBremFsbG9jKHNpemVvZigqc2hhZG93X3JlcyksIEdG
UF9LRVJORUwpOw0KPiA+PiArCQkJc2hhZG93X3Jlcy0+cmVzb3VyY2Uuc3RhcnQgPSByZXMtPmVu
ZCArIDE7DQo+ID4+ICsJCQlzaGFkb3dfcmVzLT5yZXNvdXJjZS5lbmQgPSByZXMtPnN0YXJ0ICsg
UEFHRV9TSVpFIC0gMTsNCj4gPiBXaGF0IGFib3V0IHJlcy0+c3RhcnQgbm90IHBhZ2UgYWxpZ25l
ZCBzbyB5b3UgZW5kIHVwIHN0aWxsIGhhdmluZw0KPiA+IGEgcG9ydGlvbiBiZWZvcmUgcmVzLT5z
dGFydCBub3QgZXhjbHVzaXZlbHkgcmVzZXJ2ZWQ/DQo+IA0KPiBEbyB5b3UgbWVhbiBhZGQgYSAn
ZHVtbXknIHJlc291cmNlIHRvIHJlc2VydmUgdGhlIHBvcnRpb24NCj4gYmVmb3JlIHJlcy0+c3Rh
cnQgaWYgcmVzLT5zdGFydCBub3QgcGFnZSBhbGlnbmVkPw0KPiANCj4gQnV0IHdvdWxkIGl0IGhh
cHBlbiB0aGF0IHRoZXJlIGlzIGEgbWVtIGhvbGUgaW4gdGhlIHBvcnRpb24NCj4gYmVmb3JlIHJl
cy0+c3RhcnQ/IFRoZSByZXNvdXJjZSBzaG91bGQgaGF2ZSBiZWVuIGFzc2lnbmVkDQo+IGludG8g
dGhlIGhvbGUgYXQgdGhlIGJlZ2lubmluZy4NCj4gDQoNCkp1c3QgYSBxdWljayB0aG91Z2h0LiBB
bm90aGVyIGRldmljZSBtaWdodCBvY2N1cHkgdGhhdCByYW5nZSANCmJlZm9yZSBpbml0aWFsaXpp
bmcgdGhpcyBkZXZpY2UsIGFuZCB0aGVuICdhbm90aGVyIGRldmljZScgaXMgaG90DQpyZW1vdmVk
IGxhdGVyLi4uIA0KDQpUaGFua3MNCktldmluDQo=

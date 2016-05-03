Return-Path: <kevin.tian@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qzWL415tZzDvpG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 16:22:19 +1000 (AEST)
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "joro@8bytes.org" <joro@8bytes.org>, "warrier@linux.vnet.ibm.com"
 <warrier@linux.vnet.ibm.com>, "zhong@linux.vnet.ibm.com"
 <zhong@linux.vnet.ibm.com>, "nikunj@linux.vnet.ibm.com"
 <nikunj@linux.vnet.ibm.com>, "eric.auger@linaro.org" <eric.auger@linaro.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>, "gwshan@linux.vnet.ibm.com"
 <gwshan@linux.vnet.ibm.com>, "David.Laight@ACULAB.COM"
 <David.Laight@ACULAB.COM>, "alistair@popple.id.au" <alistair@popple.id.au>,
 "ruscur@russell.cc" <ruscur@russell.cc>
Subject: RE: [PATCH 5/5] vfio-pci: Allow to mmap MSI-X table if interrupt
 remapping is supported
Date: Tue, 3 May 2016 06:22:15 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D15F842653@SHSMSX101.ccr.corp.intel.com>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1461761010-5452-6-git-send-email-xyjxie@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F842512@SHSMSX101.ccr.corp.intel.com>
 <f7d73ac3-470d-a0d2-0a97-05be630480dd@linux.vnet.ibm.com>
In-Reply-To: <f7d73ac3-470d-a0d2-0a97-05be630480dd@linux.vnet.ibm.com>
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
U2VudDogVHVlc2RheSwgTWF5IDAzLCAyMDE2IDI6MDggUE0NCj4gDQo+IE9uIDIwMTYvNS8zIDEz
OjM0LCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gDQo+ID4+IEZyb206IFlvbmdqaSBYaWUNCj4gPj4g
U2VudDogV2VkbmVzZGF5LCBBcHJpbCAyNywgMjAxNiA4OjQzIFBNDQo+ID4+DQo+ID4+IFRoaXMg
cGF0Y2ggZW5hYmxlcyBtbWFwcGluZyBNU0ktWCB0YWJsZXMgaWYgaGFyZHdhcmUgc3VwcG9ydHMN
Cj4gPj4gaW50ZXJydXB0IHJlbWFwcGluZyB3aGljaCBjYW4gZW5zdXJlIHRoYXQgYSBnaXZlbiBw
Y2kgZGV2aWNlDQo+ID4+IGNhbiBvbmx5IHNob290IHRoZSBNU0lzIGFzc2lnbmVkIGZvciBpdC4N
Cj4gPj4NCj4gPj4gV2l0aCBNU0ktWCB0YWJsZSBtbWFwcGVkLCB3ZSBhbHNvIG5lZWQgdG8gZXhw
b3NlIHRoZQ0KPiA+PiByZWFkL3dyaXRlIGludGVyZmFjZSB3aGljaCB3aWxsIGJlIHVzZWQgdG8g
YWNjZXNzIE1TSS1YIHRhYmxlLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBZb25namkgWGll
IDx4eWp4aWVAbGludXgudm5ldC5pYm0uY29tPg0KPiA+IEEgY3VyaW91cyBxdWVzdGlvbiBoZXJl
LiBEb2VzICJhbGxvdyB0byBtbWFwIE1TSS1YIiBlc3NlbnRpYWxseQ0KPiA+IG1lYW4gdGhhdCBL
Vk0gZ3Vlc3QgY2FuIGRpcmVjdGx5IHJlYWQvd3JpdGUgcGh5c2ljYWwgTVNJLVgNCj4gPiBzdHJ1
Y3R1cmUgdGhlbj8NCj4gPg0KPiA+IFRoYW5rcw0KPiA+IEtldmluDQo+ID4NCj4gDQo+IEhlcmUg
d2UganVzdCBhbGxvdyB0byBtbWFwIE1TSS1YIHRhYmxlIGluIGtlcm5lbC4gSXQgZG9lc24ndA0K
PiBtZWFuIGFsbCBLVk0gZ3Vlc3QgY2FuIGRpcmVjdGx5IHJlYWQvd3JpdGUgcGh5c2ljYWwgTVNJ
LVgNCj4gc3RydWN0dXJlLiBUaGlzIHNob3VsZCBiZSBkZWNpZGVkIGJ5IFFFTVUuIEZvciBQUEM2
NA0KPiBwbGF0Zm9ybSwgd2Ugd291bGQgYWxsb3cgdG8gcGFzc3Rocm91Z2ggdGhlIE1TSS1YIHRh
YmxlDQo+IGJlY2F1c2Ugd2Uga25vdyBndWVzdCBrZXJuZWwgd291bGQgbm90IHdyaXRlIHBoeXNp
Y2FsDQo+IE1TSS1YIHN0cnVjdHVyZSB3aGVuIGVuYWJsaW5nIE1TSS4NCj4gDQoNCkEgYml0IGNv
bmZ1c2VkIGhlcmUuIElmIGd1ZXN0IGtlcm5lbCBkb2Vzbid0IG5lZWQgdG8gd3JpdGUNCnBoeXNp
Y2FsIE1TSS1YIHN0cnVjdHVyZSwgd2hhdCdzIHRoZSBwb2ludCBvZiBwYXNzaW5nIHRocm91Z2gN
CnRoZSB0YWJsZSB0aGVuPw0KDQpJIHRoaW5rIHRoZSBrZXkgd2hldGhlciBNU0ktWCB0YWJsZSBj
YW4gYmUgcGFzc2VkIHRocm91Z2gNCmlzIHJlbGF0ZWQgdG8gd2hlcmUgaHlwZXJ2aXNvciBjb250
cm9sIGlzIGRlcGxveWVkLiBBdCBsZWFzdA0KZm9yIHg4NjoNCg0KLSBXaGVuIGlycSByZW1hcHBp
bmcgaXMgbm90IGVuYWJsZWQsIGhvc3QvaHlwZXJ2aXNvciBuZWVkcw0KdG8gY29udHJvbCBwaHlz
aWNhbCBpbnRlcnJ1cHQgbWVzc2FnZSBpbmNsdWRpbmcgdmVjdG9yL2Rlc3QvZXRjLg0KZGlyZWN0
bHkgaW4gTVNJLVggc3RydWN0dXJlLCBzbyB3ZSBjYW5ub3QgYWxsb3cgYSBndWVzdCB0byANCmFj
Y2VzcyBpdDsNCg0KLSB3aGVuIGlycSByZW1hcHBpbmcgaXMgZW5hYmxlZCwgaG9zdC9oeXBlcnZp
c29yIGNhbiBjb250cm9sDQppbnRlcnJ1cHQgcm91dGluZyBpbiBpcnEgcmVtYXBwaW5nIHRhYmxl
LiBIb3dldmVyIE1TSS1YDQphbHNvIG5lZWRzIHRvIGJlIGNvbmZpZ3VyZWQgYXMgcmVtYXBwYWJs
ZSBmb3JtYXQuIEluIHRoaXMNCm1hbm5lciB3ZSBhbHNvIGNhbm5vdCBhbGxvdyBkaXJlY3QgYWNj
ZXNzIGZyb20gZ3Vlc3QuDQoNClRoZSBvbmx5IHNhbmUgY2FzZSB0byBwYXNzIHRocm91Z2ggTVNJ
LVggc3RydWN0dXJlLCBpcyBhDQptZWNoYW5pc20gc2ltaWxhciB0byBpcnEgcmVtYXBwaW5nIGJ1
dCB3L28gbmVlZCB0byBjaGFuZ2UNCm9yaWdpbmFsIE1TSS1YIGZvcm1hdCBzbyBkaXJlY3QgYWNj
ZXNzIGZyb20gZ3Vlc3Qgc2lkZSBpcw0Kc2FmZS4gSXMgaXQgdGhlIGNhc2UgaW4gUFBDNjQ/DQoN
ClRoYW5rcw0KS2V2aW4NCg==

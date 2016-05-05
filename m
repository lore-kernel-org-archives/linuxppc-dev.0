Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0qz22vNmzDq7j
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 19:55:26 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: "'Tian, Kevin'" <kevin.tian@intel.com>, Yongji Xie
 <xyjxie@linux.vnet.ibm.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
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
Date: Thu, 5 May 2016 09:54:07 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F4B52B5@AcuExch.aculab.com>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1461761010-5452-6-git-send-email-xyjxie@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F842512@SHSMSX101.ccr.corp.intel.com>
 <f7d73ac3-470d-a0d2-0a97-05be630480dd@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F842653@SHSMSX101.ccr.corp.intel.com>
 <e064a6a7-a8dc-f71f-1725-f31e03581b8d@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F847150@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D15F847150@SHSMSX101.ccr.corp.intel.com>
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

RnJvbTogVGlhbiwgS2V2aW4NCj4gU2VudDogMDUgTWF5IDIwMTYgMTA6MzcNCi4uLg0KPiA+IEFj
dXR1YWxseSwgd2UgYXJlIG5vdCBhaW1lZCBhdCBhY2Nlc3NpbmcgTVNJLVggdGFibGUgZnJvbQ0K
PiA+IGd1ZXN0LiBTbyBJIHRoaW5rIGl0J3Mgc2FmZSB0byBwYXNzdGhyb3VnaCBNU0ktWCB0YWJs
ZSBpZiB3ZQ0KPiA+IGNhbiBtYWtlIHN1cmUgZ3Vlc3Qga2VybmVsIHdvdWxkIG5vdCB0b3VjaCBN
U0ktWCB0YWJsZSBpbg0KPiA+IG5vcm1hbCBjb2RlIHBhdGggc3VjaCBhcyBwYXJhLXZpcnR1YWxp
emVkIGd1ZXN0IGtlcm5lbCBvbiBQUEM2NC4NCj4gPg0KPiANCj4gVGhlbiBob3cgZG8geW91IHBy
ZXZlbnQgbWFsaWNpb3VzIGd1ZXN0IGtlcm5lbCBhY2Nlc3NpbmcgaXQ/DQoNCk9yIGEgbWFsaWNp
b3VzIGd1ZXN0IGRyaXZlciBmb3IgYW4gZXRoZXJuZXQgY2FyZCBzZXR0aW5nIHVwDQp0aGUgcmVj
ZWl2ZSBidWZmZXIgcmluZyB0byBjb250YWluIGEgc2luZ2xlIHdvcmQgZW50cnkgdGhhdA0KY29u
dGFpbnMgdGhlIGFkZHJlc3MgYXNzb2NpYXRlZCB3aXRoIGFuIE1TSS1YIGludGVycnVwdCBhbmQN
CnRoZW4gdXNpbmcgYSBsb29wYmFjayBtb2RlIHRvIGNhdXNlIGEgc3BlY2lmaWMgcGFja2V0IGJl
DQpyZWNlaXZlZCB0aGF0IHdyaXRlcyB0aGUgcmVxdWlyZWQgd29yZCB0aHJvdWdoIHRoYXQgYWRk
cmVzcy4NCg0KUmVtZW1iZXIgdGhlIFBDSWUgY3ljbGUgZm9yIGFuIGludGVycnVwdCBpcyBhIG5v
cm1hbCBtZW1vcnkgd3JpdGUNCmN5Y2xlLg0KDQoJRGF2aWQNCg0K

Return-Path: <kevin.tian@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id 3r0qYK3hrqzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 19:36:36 +1000 (AEST)
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
Date: Thu, 5 May 2016 09:36:31 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D15F847150@SHSMSX101.ccr.corp.intel.com>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1461761010-5452-6-git-send-email-xyjxie@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F842512@SHSMSX101.ccr.corp.intel.com>
 <f7d73ac3-470d-a0d2-0a97-05be630480dd@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F842653@SHSMSX101.ccr.corp.intel.com>
 <e064a6a7-a8dc-f71f-1725-f31e03581b8d@linux.vnet.ibm.com>
In-Reply-To: <e064a6a7-a8dc-f71f-1725-f31e03581b8d@linux.vnet.ibm.com>
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

PiBGcm9tOiBZb25namkgWGllDQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAwMywgMjAxNiAzOjM0IFBN
DQo+IA0KPiBPbiAyMDE2LzUvMyAxNDoyMiwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+IA0KPiA+PiBG
cm9tOiBZb25namkgWGllIFttYWlsdG86eHlqeGllQGxpbnV4LnZuZXQuaWJtLmNvbV0NCj4gPj4g
U2VudDogVHVlc2RheSwgTWF5IDAzLCAyMDE2IDI6MDggUE0NCj4gPj4NCj4gPj4gT24gMjAxNi81
LzMgMTM6MzQsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+Pg0KPiA+Pj4+IEZyb206IFlvbmdqaSBY
aWUNCj4gPj4+PiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDI3LCAyMDE2IDg6NDMgUE0NCj4gPj4+
Pg0KPiA+Pj4+IFRoaXMgcGF0Y2ggZW5hYmxlcyBtbWFwcGluZyBNU0ktWCB0YWJsZXMgaWYgaGFy
ZHdhcmUgc3VwcG9ydHMNCj4gPj4+PiBpbnRlcnJ1cHQgcmVtYXBwaW5nIHdoaWNoIGNhbiBlbnN1
cmUgdGhhdCBhIGdpdmVuIHBjaSBkZXZpY2UNCj4gPj4+PiBjYW4gb25seSBzaG9vdCB0aGUgTVNJ
cyBhc3NpZ25lZCBmb3IgaXQuDQo+ID4+Pj4NCj4gPj4+PiBXaXRoIE1TSS1YIHRhYmxlIG1tYXBw
ZWQsIHdlIGFsc28gbmVlZCB0byBleHBvc2UgdGhlDQo+ID4+Pj4gcmVhZC93cml0ZSBpbnRlcmZh
Y2Ugd2hpY2ggd2lsbCBiZSB1c2VkIHRvIGFjY2VzcyBNU0ktWCB0YWJsZS4NCj4gPj4+Pg0KPiA+
Pj4+IFNpZ25lZC1vZmYtYnk6IFlvbmdqaSBYaWUgPHh5anhpZUBsaW51eC52bmV0LmlibS5jb20+
DQo+ID4+PiBBIGN1cmlvdXMgcXVlc3Rpb24gaGVyZS4gRG9lcyAiYWxsb3cgdG8gbW1hcCBNU0kt
WCIgZXNzZW50aWFsbHkNCj4gPj4+IG1lYW4gdGhhdCBLVk0gZ3Vlc3QgY2FuIGRpcmVjdGx5IHJl
YWQvd3JpdGUgcGh5c2ljYWwgTVNJLVgNCj4gPj4+IHN0cnVjdHVyZSB0aGVuPw0KPiA+Pj4NCj4g
Pj4+IFRoYW5rcw0KPiA+Pj4gS2V2aW4NCj4gPj4+DQo+ID4+IEhlcmUgd2UganVzdCBhbGxvdyB0
byBtbWFwIE1TSS1YIHRhYmxlIGluIGtlcm5lbC4gSXQgZG9lc24ndA0KPiA+PiBtZWFuIGFsbCBL
Vk0gZ3Vlc3QgY2FuIGRpcmVjdGx5IHJlYWQvd3JpdGUgcGh5c2ljYWwgTVNJLVgNCj4gPj4gc3Ry
dWN0dXJlLiBUaGlzIHNob3VsZCBiZSBkZWNpZGVkIGJ5IFFFTVUuIEZvciBQUEM2NA0KPiA+PiBw
bGF0Zm9ybSwgd2Ugd291bGQgYWxsb3cgdG8gcGFzc3Rocm91Z2ggdGhlIE1TSS1YIHRhYmxlDQo+
ID4+IGJlY2F1c2Ugd2Uga25vdyBndWVzdCBrZXJuZWwgd291bGQgbm90IHdyaXRlIHBoeXNpY2Fs
DQo+ID4+IE1TSS1YIHN0cnVjdHVyZSB3aGVuIGVuYWJsaW5nIE1TSS4NCj4gPj4NCj4gPiBBIGJp
dCBjb25mdXNlZCBoZXJlLiBJZiBndWVzdCBrZXJuZWwgZG9lc24ndCBuZWVkIHRvIHdyaXRlDQo+
ID4gcGh5c2ljYWwgTVNJLVggc3RydWN0dXJlLCB3aGF0J3MgdGhlIHBvaW50IG9mIHBhc3Npbmcg
dGhyb3VnaA0KPiA+IHRoZSB0YWJsZSB0aGVuPw0KPiANCj4gV2Ugd2FudCB0byBhbGxvdyB0aGUg
TVNJLVggdGFibGUgYmVjYXVzZSB0aGVyZSBtYXkgYmUNCj4gc29tZSBjcml0aWNhbCByZWdpc3Rl
cnMgaW4gdGhlIHNhbWUgcGFnZSBhcyB0aGUgTVNJLVggdGFibGUuDQo+IFdlIGhhdmUgdG8gaGFu
ZGxlIHRoZSBtbWlvIGFjY2VzcyB0byB0aGVzZSByZWdpc3RlciBpbiBRRU1VDQo+IHJhdGhlciB0
aGFuIGluIGd1ZXN0IGlmIG1tYXBwaW5nIE1TSS1YIHRhYmxlIGlzIGRpc2FsbG93ZWQuDQoNClNv
IHlvdSBtZWFuIGNyaXRpY2FsIHJlZ2lzdGVycyBpbiBzYW1lIE1NSU8gQkFSIGFzIE1TSS1YDQp0
YWJsZSwgaW5zdGVhZCBvZiB0d28gTU1JTyBCQVJzIGluIHNhbWUgcGFnZSAodGhlIGxhdHRlciBJ
DQpzdXBwb3NlIHdpdGggeW91ciB3aG9sZSBwYXRjaHNldCBpdCB3b24ndCBoYXBwZW4gdGhlbik/
DQoNCj4gDQo+ID4gSSB0aGluayB0aGUga2V5IHdoZXRoZXIgTVNJLVggdGFibGUgY2FuIGJlIHBh
c3NlZCB0aHJvdWdoDQo+ID4gaXMgcmVsYXRlZCB0byB3aGVyZSBoeXBlcnZpc29yIGNvbnRyb2wg
aXMgZGVwbG95ZWQuIEF0IGxlYXN0DQo+ID4gZm9yIHg4NjoNCj4gPg0KPiA+IC0gV2hlbiBpcnEg
cmVtYXBwaW5nIGlzIG5vdCBlbmFibGVkLCBob3N0L2h5cGVydmlzb3IgbmVlZHMNCj4gPiB0byBj
b250cm9sIHBoeXNpY2FsIGludGVycnVwdCBtZXNzYWdlIGluY2x1ZGluZyB2ZWN0b3IvZGVzdC9l
dGMuDQo+ID4gZGlyZWN0bHkgaW4gTVNJLVggc3RydWN0dXJlLCBzbyB3ZSBjYW5ub3QgYWxsb3cg
YSBndWVzdCB0bw0KPiA+IGFjY2VzcyBpdDsNCj4gPg0KPiA+IC0gd2hlbiBpcnEgcmVtYXBwaW5n
IGlzIGVuYWJsZWQsIGhvc3QvaHlwZXJ2aXNvciBjYW4gY29udHJvbA0KPiA+IGludGVycnVwdCBy
b3V0aW5nIGluIGlycSByZW1hcHBpbmcgdGFibGUuIEhvd2V2ZXIgTVNJLVgNCj4gPiBhbHNvIG5l
ZWRzIHRvIGJlIGNvbmZpZ3VyZWQgYXMgcmVtYXBwYWJsZSBmb3JtYXQuIEluIHRoaXMNCj4gPiBt
YW5uZXIgd2UgYWxzbyBjYW5ub3QgYWxsb3cgZGlyZWN0IGFjY2VzcyBmcm9tIGd1ZXN0Lg0KPiA+
DQo+ID4gVGhlIG9ubHkgc2FuZSBjYXNlIHRvIHBhc3MgdGhyb3VnaCBNU0ktWCBzdHJ1Y3R1cmUs
IGlzIGENCj4gPiBtZWNoYW5pc20gc2ltaWxhciB0byBpcnEgcmVtYXBwaW5nIGJ1dCB3L28gbmVl
ZCB0byBjaGFuZ2UNCj4gPiBvcmlnaW5hbCBNU0ktWCBmb3JtYXQgc28gZGlyZWN0IGFjY2VzcyBm
cm9tIGd1ZXN0IHNpZGUgaXMNCj4gPiBzYWZlLiBJcyBpdCB0aGUgY2FzZSBpbiBQUEM2ND8NCj4g
Pg0KPiA+IFRoYW5rcw0KPiA+IEtldmluDQo+IA0KPiBBY3V0dWFsbHksIHdlIGFyZSBub3QgYWlt
ZWQgYXQgYWNjZXNzaW5nIE1TSS1YIHRhYmxlIGZyb20NCj4gZ3Vlc3QuIFNvIEkgdGhpbmsgaXQn
cyBzYWZlIHRvIHBhc3N0aHJvdWdoIE1TSS1YIHRhYmxlIGlmIHdlDQo+IGNhbiBtYWtlIHN1cmUg
Z3Vlc3Qga2VybmVsIHdvdWxkIG5vdCB0b3VjaCBNU0ktWCB0YWJsZSBpbg0KPiBub3JtYWwgY29k
ZSBwYXRoIHN1Y2ggYXMgcGFyYS12aXJ0dWFsaXplZCBndWVzdCBrZXJuZWwgb24gUFBDNjQuDQo+
IA0KDQpUaGVuIGhvdyBkbyB5b3UgcHJldmVudCBtYWxpY2lvdXMgZ3Vlc3Qga2VybmVsIGFjY2Vz
c2luZyBpdD8NCg0KVGhhbmtzDQpLZXZpbg0K

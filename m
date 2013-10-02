Return-Path: <jacob.e.keller@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by ozlabs.org (Postfix) with ESMTP id 0C0482C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 06:51:02 +1000 (EST)
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH RFC 40/77] ixgbevf: Update MSI/MSI-X interrupts
 enablement code
Date: Wed, 2 Oct 2013 20:50:51 +0000
Message-ID: <1380747051.32715.7.camel@jekeller-desk1.amr.corp.intel.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <338c9012577acf694eb23622902185584987bd8f.1380703263.git.agordeev@redhat.com>
In-Reply-To: <338c9012577acf694eb23622902185584987bd8f.1380703263.git.agordeev@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "VMware,
 Inc." <pv-drivers@vmware.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 Andy King <acking@vmware.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "iss_storagedev@hp.com" <iss_storagedev@hp.com>,
 "linux-driver@qlogic.com" <linux-driver@qlogic.com>, Tejun Heo <tj@kernel.org>,
 Bjorn
 Helgaas <bhelgaas@google.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
 "Mason, Jon" <jon.mason@intel.com>, Solarflare linux
 maintainers <linux-net-drivers@solarflare.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 "e1000-devel@lists.sourceforge.net" <e1000-devel@lists.sourceforge.net>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 "linux390@de.ibm.com" <linux390@de.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

T24gV2VkLCAyMDEzLTEwLTAyIGF0IDEyOjQ4ICswMjAwLCBBbGV4YW5kZXIgR29yZGVldiB3cm90
ZToNCj4gQXMgcmVzdWx0IG9mIHJlY2VudCByZS1kZXNpZ24gb2YgdGhlIE1TSS9NU0ktWCBpbnRl
cnJ1cHRzIGVuYWJsaW5nDQo+IHBhdHRlcm4gdGhpcyBkcml2ZXIgaGFzIHRvIGJlIHVwZGF0ZWQg
dG8gdXNlIHRoZSBuZXcgdGVjaG5pcXVlIHRvDQo+IG9idGFpbiBhIG9wdGltYWwgbnVtYmVyIG9m
IE1TSS9NU0ktWCBpbnRlcnJ1cHRzIHJlcXVpcmVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxl
eGFuZGVyIEdvcmRlZXYgPGFnb3JkZWV2QHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaW50ZWwvaXhnYmV2Zi9peGdiZXZmX21haW4uYyB8ICAgMTggKysrKysrKy0t
LS0tLS0tLS0tDQo+ICAxIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaXhn
YmV2Zi9peGdiZXZmX21haW4uYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JldmYv
aXhnYmV2Zl9tYWluLmMNCj4gaW5kZXggZmEwNTM3YS4uZDUwNmEwMSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaXhnYmV2Zi9peGdiZXZmX21haW4uYw0KPiArKysg
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9peGdiZXZmL2l4Z2JldmZfbWFpbi5jDQo+IEBA
IC0xNzQ5LDggKzE3NDksNyBAQCB2b2lkIGl4Z2JldmZfcmVzZXQoc3RydWN0IGl4Z2JldmZfYWRh
cHRlciAqYWRhcHRlcikNCj4gIHN0YXRpYyBpbnQgaXhnYmV2Zl9hY3F1aXJlX21zaXhfdmVjdG9y
cyhzdHJ1Y3QgaXhnYmV2Zl9hZGFwdGVyICphZGFwdGVyLA0KPiAgCQkJCQlpbnQgdmVjdG9ycykN
Cj4gIHsNCj4gLQlpbnQgZXJyID0gMDsNCj4gLQlpbnQgdmVjdG9yX3RocmVzaG9sZDsNCj4gKwlp
bnQgZXJyLCB2ZWN0b3JfdGhyZXNob2xkOw0KPiAgDQo+ICAJLyogV2UnbGwgd2FudCBhdCBsZWFz
dCAyICh2ZWN0b3JfdGhyZXNob2xkKToNCj4gIAkgKiAxKSBUeFFbMF0gKyBSeFFbMF0gaGFuZGxl
cg0KPiBAQCAtMTc2MywxOCArMTc2MiwxNSBAQCBzdGF0aWMgaW50IGl4Z2JldmZfYWNxdWlyZV9t
c2l4X3ZlY3RvcnMoc3RydWN0IGl4Z2JldmZfYWRhcHRlciAqYWRhcHRlciwNCj4gIAkgKiBSaWdo
dCBub3csIHdlIHNpbXBseSBjYXJlIGFib3V0IGhvdyBtYW55IHdlJ2xsIGdldDsgd2UnbGwNCj4g
IAkgKiBzZXQgdGhlbSB1cCBsYXRlciB3aGlsZSByZXF1ZXN0aW5nIGlycSdzLg0KPiAgCSAqLw0K
PiAtCXdoaWxlICh2ZWN0b3JzID49IHZlY3Rvcl90aHJlc2hvbGQpIHsNCj4gLQkJZXJyID0gcGNp
X2VuYWJsZV9tc2l4KGFkYXB0ZXItPnBkZXYsIGFkYXB0ZXItPm1zaXhfZW50cmllcywNCj4gLQkJ
CQkgICAgICB2ZWN0b3JzKTsNCj4gLQkJaWYgKCFlcnIgfHwgZXJyIDwgMCkgLyogU3VjY2VzcyBv
ciBhIG5hc3R5IGZhaWx1cmUuICovDQo+IC0JCQlicmVhazsNCj4gLQkJZWxzZSAvKiBlcnIgPT0g
bnVtYmVyIG9mIHZlY3RvcnMgd2Ugc2hvdWxkIHRyeSBhZ2FpbiB3aXRoICovDQo+IC0JCQl2ZWN0
b3JzID0gZXJyOw0KPiAtCX0NCj4gKwllcnIgPSBwY2lfbXNpeF90YWJsZV9zaXplKGFkYXB0ZXIt
PnBkZXYpOw0KSSB3b3VsZCBwcmVmZXIgdG8gdXNlIHNvbWV0aGluZyBvdGhlciB0aGFuICJlcnIi
IGhlcmUgc2luY2UgdGhlIHZhbHVlDQppc24ndCByZWFsbHkgYW4gZXJyb3IgaWYgaXQncyBncmVh
dGVyIHRoYW4gMC4gSG93ZXZlciwgaXQncyBub3QgcmVhbGx5IGENCmJpZyBpc3N1ZSwgc2luY2Ug
eW91IGltbWVkaWF0ZWx5IGNvbnZlciB0byB1c2luZyB2ZWN0b3JzIG9uIHRoZSBuZXh0DQpsaW5l
IG9mIGNvZGUuLiBJIHRoaW5rIGl0cyBhbHJpZ2h0IG92ZXJhbGwuDQoNClJlZ2FyZHMsDQpKYWtl
DQoNCj4gKwlpZiAoZXJyIDwgMCkNCj4gKwkJcmV0dXJuIGVycjsNCj4gIA0KPiArCXZlY3RvcnMg
PSBtaW4odmVjdG9ycywgZXJyKTsNCj4gIAlpZiAodmVjdG9ycyA8IHZlY3Rvcl90aHJlc2hvbGQp
DQo+IC0JCWVyciA9IC1FTk9TUEM7DQo+ICsJCXJldHVybiAtRU5PU1BDOw0KPiAgDQo+ICsJZXJy
ID0gcGNpX2VuYWJsZV9tc2l4KGFkYXB0ZXItPnBkZXYsIGFkYXB0ZXItPm1zaXhfZW50cmllcywg
dmVjdG9ycyk7DQo+ICAJaWYgKGVycikgew0KPiAgCQlkZXZfZXJyKCZhZGFwdGVyLT5wZGV2LT5k
ZXYsDQo+ICAJCQkiVW5hYmxlIHRvIGFsbG9jYXRlIE1TSS1YIGludGVycnVwdHNcbiIpOw0KDQoN
Cg==

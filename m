Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by lists.ozlabs.org (Postfix) with SMTP id 194C21A0005
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jul 2014 19:22:05 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 20786-04 for <linuxppc-dev@lists.ozlabs.org>;
 Thu,  3 Jul 2014 10:22:01 +0100 (BST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Bjorn Helgaas' <bhelgaas@google.com>, Alexander Gordeev
 <agordeev@redhat.com>
Subject: RE: [PATCH 1/3] PCI/MSI: Add pci_enable_msi_partial()
Date: Thu, 3 Jul 2014 09:20:52 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1726BF4E@AcuExch.aculab.com>
References: <cover.1402405331.git.agordeev@redhat.com>
 <4fef62a2e647a7c38e9f2a1ea4244b3506a85e2b.1402405331.git.agordeev@redhat.com>
 <20140702202201.GA28852@google.com>
In-Reply-To: <20140702202201.GA28852@google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogQmpvcm4gSGVsZ2Fhcw0KPiBPbiBUdWUsIEp1biAxMCwgMjAxNCBhdCAwMzoxMDozMFBN
ICswMjAwLCBBbGV4YW5kZXIgR29yZGVldiB3cm90ZToNCj4gPiBUaGVyZSBhcmUgUENJIGRldmlj
ZXMgdGhhdCByZXF1aXJlIGEgcGFydGljdWxhciB2YWx1ZSB3cml0dGVuDQo+ID4gdG8gdGhlIE11
bHRpcGxlIE1lc3NhZ2UgRW5hYmxlIChNTUUpIHJlZ2lzdGVyIHdoaWxlIGFsaWduZWQgb24NCj4g
PiBwb3dlciBvZiAyIGJvdW5kYXJ5IHZhbHVlIG9mIGFjdHVhbGx5IHVzZWQgTVNJIHZlY3RvcnMg
J252ZWMnDQo+ID4gaXMgYSBsZXNzZXIgb2YgdGhhdCBNTUUgdmFsdWU6DQo+ID4NCj4gPiAJcm91
bmR1cF9wb3dfb2ZfdHdvKG52ZWMpIDwgJ011bHRpcGxlIE1lc3NhZ2UgRW5hYmxlJw0KPiA+DQo+
ID4gSG93ZXZlciB0aGUgZXhpc3RpbmcgcGNpX2VuYWJsZV9tc2lfYmxvY2soKSBpbnRlcmZhY2Ug
aXMgbm90DQo+ID4gYWJsZSB0byBjb25maWd1cmUgc3VjaCBkZXZpY2VzLCBzaW5jZSB0aGUgdmFs
dWUgd3JpdHRlbiB0byB0aGUNCj4gPiBNTUUgcmVnaXN0ZXIgaXMgY2FsY3VsYXRlZCBmcm9tIHRo
ZSBudW1iZXIgb2YgcmVxdWVzdGVkIE1TSXMNCj4gPiAnbnZlYyc6DQo+ID4NCj4gPiAJJ011bHRp
cGxlIE1lc3NhZ2UgRW5hYmxlJyA9IHJvdW5kdXBfcG93X29mX3R3byhudmVjKQ0KPiANCj4gRm9y
IE1TSSwgc29mdHdhcmUgbGVhcm5zIGhvdyBtYW55IHZlY3RvcnMgYSBkZXZpY2UgcmVxdWVzdHMg
YnkgcmVhZGluZw0KPiB0aGUgTXVsdGlwbGUgTWVzc2FnZSBDYXBhYmxlIChNTUMpIGZpZWxkLiAg
VGhpcyBmaWVsZCBpcyBlbmNvZGVkLCBzbyBhDQo+IGRldmljZSBjYW4gb25seSByZXF1ZXN0IDEs
IDIsIDQsIDgsIGV0Yy4sIHZlY3RvcnMuICBJdCdzIGltcG9zc2libGUNCj4gZm9yIGEgZGV2aWNl
IHRvIHJlcXVlc3QgMyB2ZWN0b3JzOyBpdCB3b3VsZCBoYXZlIHRvIHJvdW5kIHVwIHRoYXQgdXAN
Cj4gdG8gYSBwb3dlciBvZiB0d28gYW5kIHJlcXVlc3QgNCB2ZWN0b3JzLg0KPiANCj4gU29mdHdh
cmUgd3JpdGVzIHNpbWlsYXJseSBlbmNvZGVkIHZhbHVlcyB0byBNTUUgdG8gdGVsbCB0aGUgZGV2
aWNlIGhvdw0KPiBtYW55IHZlY3RvcnMgaGF2ZSBiZWVuIGFsbG9jYXRlZCBmb3IgaXRzIHVzZS4g
IEZvciBleGFtcGxlLCBpdCdzDQo+IGltcG9zc2libGUgdG8gdGVsbCB0aGUgZGV2aWNlIHRoYXQg
aXQgY2FuIHVzZSAzIHZlY3RvcnM7IHRoZSBPUyBoYXMgdG8NCj4gcm91bmQgdGhhdCB1cCBhbmQg
dGVsbCB0aGUgZGV2aWNlIGl0IGNhbiB1c2UgNCB2ZWN0b3JzLg0KPiANCj4gU28gaWYgSSB1bmRl
cnN0YW5kIGNvcnJlY3RseSwgdGhlIHBvaW50IG9mIHRoaXMgc2VyaWVzIGlzIHRvIHRha2UNCj4g
YWR2YW50YWdlIG9mIGRldmljZS1zcGVjaWZpYyBrbm93bGVkZ2UsIGUuZy4sIHRoZSBkZXZpY2Ug
cmVxdWVzdHMgNA0KPiB2ZWN0b3JzIHZpYSBNTUMsIGJ1dCB3ZSAia25vdyIgdGhlIGRldmljZSBp
cyBvbmx5IGNhcGFibGUgb2YgdXNpbmcgMy4NCj4gTW9yZW92ZXIsIHdlIHRlbGwgdGhlIGRldmlj
ZSB2aWEgTU1FIHRoYXQgNCB2ZWN0b3JzIGFyZSBhdmFpbGFibGUsIGJ1dA0KPiB3ZSd2ZSBvbmx5
IGFjdHVhbGx5IHNldCB1cCAzIG9mIHRoZW0uDQouLi4NCg0KRXZlbiBpZiB5b3UgZG8gdGhhdCwg
eW91IG91Z2h0IHRvIHdyaXRlIHZhbGlkIGludGVycnVwdCBpbmZvcm1hdGlvbg0KaW50byB0aGUg
NHRoIHNsb3QgKG1heWJlIHJlcGxpY2F0aW5nIG9uZSBvZiB0aGUgZWFybGllciBpbnRlcnJ1cHRz
KS4NClRoZW4sIGlmIHRoZSBkZXZpY2UgZG9lcyByYWlzZSB0aGUgJ3VuZXhwZWN0ZWQnIGludGVy
cnVwdCB5b3UgZG9uJ3QNCmdldCBhIHdyaXRlIHRvIGEgcmFuZG9tIGtlcm5lbCBsb2NhdGlvbi4N
Cg0KUGxhdXNpYmx5IHNvbWV0aGluZyBzaW1pbGFyIHNob3VsZCBiZSBkb25lIHdoZW4gYSBzbWFs
bGVyIG51bWJlciBvZg0KaW50ZXJydXB0cyBpcyBhc3NpZ25lZC4NCg0KCURhdmlkDQoNCg==

Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by lists.ozlabs.org (Postfix) with SMTP id 410FC1A005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jul 2014 18:34:48 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 21820-01 for <linuxppc-dev@lists.ozlabs.org>;
 Tue,  8 Jul 2014 09:34:44 +0100 (BST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Bjorn Helgaas' <bhelgaas@google.com>, Alexander Gordeev
 <agordeev@redhat.com>
Subject: RE: [PATCH 1/3] PCI/MSI: Add pci_enable_msi_partial()
Date: Tue, 8 Jul 2014 08:33:17 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1726E211@AcuExch.aculab.com>
References: <cover.1402405331.git.agordeev@redhat.com>
 <4fef62a2e647a7c38e9f2a1ea4244b3506a85e2b.1402405331.git.agordeev@redhat.com>
 <20140702202201.GA28852@google.com>
 <063D6719AE5E284EB5DD2968C1650D6D1726BF4E@AcuExch.aculab.com>
 <20140704085816.GB12247@dhcp-26-207.brq.redhat.com>
 <CAErSpo7QWc35seoMhJA+H1_=MkKWYMdeYG=hT=i1v=iz8d5ezA@mail.gmail.com>
In-Reply-To: <CAErSpo7QWc35seoMhJA+H1_=MkKWYMdeYG=hT=i1v=iz8d5ezA@mail.gmail.com>
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

RnJvbTogQmpvcm4gSGVsZ2Fhcw0KLi4uDQo+ID4+IEV2ZW4gaWYgeW91IGRvIHRoYXQsIHlvdSBv
dWdodCB0byB3cml0ZSB2YWxpZCBpbnRlcnJ1cHQgaW5mb3JtYXRpb24NCj4gPj4gaW50byB0aGUg
NHRoIHNsb3QgKG1heWJlIHJlcGxpY2F0aW5nIG9uZSBvZiB0aGUgZWFybGllciBpbnRlcnJ1cHRz
KS4NCj4gPj4gVGhlbiwgaWYgdGhlIGRldmljZSBkb2VzIHJhaXNlIHRoZSAndW5leHBlY3RlZCcg
aW50ZXJydXB0IHlvdSBkb24ndA0KPiA+PiBnZXQgYSB3cml0ZSB0byBhIHJhbmRvbSBrZXJuZWwg
bG9jYXRpb24uDQo+ID4NCj4gPiBJIG1pZ2h0IGJlIG1pc3Npbmcgc29tZXRoaW5nLCBidXQgd2Ug
YXJlIHRhbGtpbmcgb2YgTVNJIGFkZHJlc3Mgc3BhY2UNCj4gPiBoZXJlLCBhcmVuJ3Qgd2U/IEkg
YW0gbm90IGdldHRpbmcgaG93IHdlIGNvdWxkIGVuZCB1cCB3aXRoIGEgJ3dyaXRlJw0KPiA+IHRv
IGEgcmFuZG9tIGtlcm5lbCBsb2NhdGlvbiB3aGVuIGEgdW5jbGFpbWVkIE1TSSB2ZWN0b3Igc2Vu
dC4gV2UgY291bGQNCj4gPiBvbmx5IGV4cGVjdCBhIHNwdXJpb3VzIGludGVycnVwdCBhdCB3b3Jz
dCwgd2hpY2ggaXMgaGFuZGxlZCBhbmQgcmVwb3J0ZWQuDQo+IA0KPiBZZXMsIHRoYXQncyBob3cg
SSB1bmRlcnN0YW5kIGl0LiAgV2l0aCBNU0ksIHRoZSBPUyBzcGVjaWZpZXMgdGhlIGENCj4gc2lu
Z2xlIE1lc3NhZ2UgQWRkcmVzcywgZS5nLiwgYSBMQVBJQyBhZGRyZXNzLCBhbmQgYSBzaW5nbGUg
TWVzc2FnZQ0KPiBEYXRhIHZhbHVlLCBlLmcuLCBhIHZlY3RvciBudW1iZXIgdGhhdCB3aWxsIGJl
IHdyaXR0ZW4gdG8gdGhlIExBUElDLg0KPiBUaGUgZGV2aWNlIGlzIHBlcm1pdHRlZCB0byBtb2Rp
Znkgc29tZSBsb3ctb3JkZXIgYml0cyBvZiB0aGUgTWVzc2FnZQ0KPiBEYXRhIHRvIHNlbmQgb25l
IG9mIHNldmVyYWwgdmVjdG9yIG51bWJlcnMgKHRoZSBNTUUgdmFsdWUgdGVsbHMgdGhlDQo+IGRl
dmljZSBob3cgbWFueSBiaXRzIGl0IGNhbiBtb2RpZnkpLg0KPiANCj4gQm90dG9tIGxpbmUsIEkg
dGhpbmsgYSBzcHVyaW91cyBpbnRlcnJ1cHQgaXMgdGhlIGZhaWx1cmUgd2UnZCBleHBlY3QNCj4g
aWYgYSBkZXZpY2UgdXNlZCBtb3JlIHZlY3RvcnMgdGhhbiB0aGUgT1MgZXhwZWN0cyBpdCB0by4N
Cg0KU28geW91IG5lZWQgdG8gdGVsbCB0aGUgZGV2aWNlIHdoZXJlIHRvIHdyaXRlIGluIG9yZGVy
IHRvIHJhaXNlIHRoZQ0KJ3NwdXJpb3VzIGludGVycnVwdCcuDQoNCglEYXZpZA0KDQo=

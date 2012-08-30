Return-Path: <B32616@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4F57B2C015E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2012 16:20:30 +1000 (EST)
From: Liu Qiang-B32616 <B32616@freescale.com>
To: Dan Williams <djbw@fb.com>
Subject: RE: [PATCH v7 0/8] Raid: enable talitos xor offload for improving
 performance
Date: Thu, 30 Aug 2012 06:20:05 +0000
Message-ID: <BCB48C05FCE8BC4D9E61E841ECBE6DB70FC695@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1344500375-8457-1-git-send-email-qiang.liu@freescale.com>
 <20120809170307.GG14264@ovro.caltech.edu>
 <BCB48C05FCE8BC4D9E61E841ECBE6DB70E3D47@039-SN2MPN1-013.039d.mgd.msft.net>
 <CAA9_cme4tHrx14JaSaHwgcGq79qQK5bv8E205fbC3ega5OpUiQ@mail.gmail.com>
 <BCB48C05FCE8BC4D9E61E841ECBE6DB70FC3CA@039-SN2MPN1-011.039d.mgd.msft.net>
 <1346251975.27020.2.camel@localhost.localdomain>
In-Reply-To: <1346251975.27020.2.camel@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
 "arnd@arndb.de" <arnd@arndb.de>, "Ira W.
 Snyder" <iws@ovro.caltech.edu>, "vinod.koul@intel.com" <vinod.koul@intel.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW4gV2lsbGlhbXMgW21haWx0
bzpkamJ3QGZiLmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMjksIDIwMTIgMTA6NTMg
UE0NCj4gVG86IExpdSBRaWFuZy1CMzI2MTYNCj4gQ2M6IHZpbm9kLmtvdWxAaW50ZWwuY29tOyBh
cm5kQGFybmRiLmRlOyBoZXJiZXJ0QGdvbmRvci5hcGFuYS5vcmcuYXU7DQo+IGdyZWdraEBsaW51
eGZvdW5kYXRpb24ub3JnOyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsgbGludXgtDQo+
IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWNyeXB0b0B2Z2VyLmtlcm5lbC5vcmc7IEly
YSBXLiBTbnlkZXINCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAwLzhdIFJhaWQ6IGVuYWJsZSB0
YWxpdG9zIHhvciBvZmZsb2FkIGZvcg0KPiBpbXByb3ZpbmcgcGVyZm9ybWFuY2UNCj4gDQo+IE9u
IFdlZCwgMjAxMi0wOC0yOSBhdCAxMToxNSArMDAwMCwgTGl1IFFpYW5nLUIzMjYxNiB3cm90ZToN
Cj4gPiBIaSBEYW4sDQo+ID4NCj4gPiBQaW5nPw0KPiA+IENhbiB5b3UgYXBwbHkgdGhlc2UgcGF0
Y2hlcz8gVGhhbmtzLg0KPiA+DQo+IA0KPiBJJ20gd29ya2luZyBteSB3YXkgdGhyb3VnaCB0aGVt
Lg0KPiANCj4gVGhlIGZpcnN0IHRoaW5nIEkgbm90aWNlIGlzIHRoYXQgeG9yX2NoYW4tPmRlc2Nf
bG9jayBpcyB0YWtlbg0KPiBpbmNvbnNpc3RlbnRseS4gIEkuZS4gc3Bpbl9sb2NrX2lycXNhdmUo
KSBpbiB0YWxpdG9zX3Byb2Nlc3NfcGVuZGluZygpDQo+IGFuZCBzcGluX2xvY2tfYmgoKSBldmVy
eXdoZXJlIGVsc2UuICBIYXZlIHlvdSBydW4gdGhlc2UgcGF0Y2hlcyB3aXRoDQo+IGxvY2tkZXA/
DQpUaGFua3MgZm9yIHlvdXIgcmVwbHkuDQpMT0NLREVQIGlzIGVuYWJsZWQgYXMgeW91IHN1Z2dl
c3RlZCwgdGhlcmUgaXMgbm90IGFueSBpbmZvIGFib3V0ICJpbmNvbnNpc3RlbnQgbG9jayBzdGF0
ZSIgZGlzcGxheWVkLg0KSSBkb24ndCBrbm93IHdoZXRoZXIgaXQncyBlbm91Z2guDQoNCkknbSBj
b25mdXNlZCBhYm91dCB0aGUgYXR0cmlidXRlIG9mIERNQV9JTlRFUlJVUFQsIG15IHVuZGVyc3Rh
bmRpbmcgaXMgdGhpcyBpbnRlcmZhY2UgaXMgb25seSB1c2VkIHRvIHRyaWdnZXIgYW4gaW50ZXJy
dXB0IChtYWtlIHN1cmUgYWxsIGZvcm1lciBvcGVyYXRpb25zIGFyZSBmaW5pc2hlZCBiZWZvcmUg
c3dpdGNoaW5nIHRvIG90aGVyIGNoYW5uZWxzKSwgYnV0IGZzbC1kbWEgd2lsbCB0cmlnZ2VyIGFu
IGludGVycnVwdCBieSAiUHJvZ3JhbW1lZCBFcnJvciIuIEknbSB3b25kZXJpbmcgd2hldGhlciBv
dGhlciBoYXJkd2FyZSBhcmUgc2FtZSB3aXRoIGZzbC1kbWEgKHRoZSBpbnRlcnJ1cHQgaXMgYSBu
b3JtYWwgaW50ZXJydXB0LCBidXQgbm90IGFuIGVycm9yKSBpLmUuIHhzY2FsZS1pb3A/DQpJZiBv
dGhlciBoYXJkd2FyZSBhbHNvIHRyaWdnZXIgYW4gaW50ZXJydXB0IGJ5IGFuIGFibm9ybWFsIGVy
cm9yLCBtYXliZSBteSBwYXRjaCAyLzggc2hvdWxkIGJlIHJldmVydGVkIGJlY2F1c2UgaXQgdmlv
bGF0ZXMgdGhlIHJ1bGVzIG9mIHRoaXMgYXR0cmlidXRlLg0KDQpCVFcsIGNvdWxkIHlvdSBwbGVh
c2UgcmVwbHkgaW4gdGhlIHBhdGNoIGlmIHlvdSBoYXZlIGFueSBjb21tZW50cy4gVGhhbmtzLg0K
DQo+IA0KPiAtLQ0KPiBEYW4NCj4gDQo+IA0KDQo=

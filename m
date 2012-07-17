Return-Path: <B32616@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 217ED2C016B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 14:03:19 +1000 (EST)
From: Liu Qiang-B32616 <B32616@freescale.com>
To: Li Yang-R58472 <r58472@freescale.com>
Subject: RE: [PATCH v3 3/4] fsl-dma: change release process of dma
 descriptor for supporting async_tx
Date: Tue, 17 Jul 2012 04:03:06 +0000
Message-ID: <BCB48C05FCE8BC4D9E61E841ECBE6DB70C2748@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1342411709-29895-1-git-send-email-qiang.liu@freescale.com>
 <CADRPPNS-cOwCTVYnjq==W-f1-AAWctyOFg_6bkSDZPtM8Jf+Lw@mail.gmail.com>
In-Reply-To: <CADRPPNS-cOwCTVYnjq==W-f1-AAWctyOFg_6bkSDZPtM8Jf+Lw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>, Vinod Koul <vinod.koul@intel.com>,
 "herbert@gondor.hengli.com.au" <herbert@gondor.hengli.com.au>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1jcnlwdG8tb3duZXJA
dmdlci5rZXJuZWwub3JnIFttYWlsdG86bGludXgtY3J5cHRvLQ0KPiBvd25lckB2Z2VyLmtlcm5l
bC5vcmddIE9uIEJlaGFsZiBPZiBMaSBZYW5nDQo+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMTcsIDIw
MTIgMTE6MzcgQU0NCj4gVG86IExpdSBRaWFuZy1CMzI2MTYNCj4gQ2M6IGxpbnV4LWNyeXB0b0B2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBJcmEgVy4NCj4g
U255ZGVyOyBWaW5vZCBLb3VsOyBoZXJiZXJ0QGdvbmRvci5oZW5nbGkuY29tLmF1OyBEYW4gV2ls
bGlhbXM7DQo+IGRhdmVtQGRhdmVtbG9mdC5uZXQNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAz
LzRdIGZzbC1kbWE6IGNoYW5nZSByZWxlYXNlIHByb2Nlc3Mgb2YgZG1hDQo+IGRlc2NyaXB0b3Ig
Zm9yIHN1cHBvcnRpbmcgYXN5bmNfdHgNCj4gDQo+IE9uIE1vbiwgSnVsIDE2LCAyMDEyIGF0IDEy
OjA4IFBNLCBRaWFuZyBMaXUgPHFpYW5nLmxpdUBmcmVlc2NhbGUuY29tPg0KPiB3cm90ZToNCj4g
PiBGaXggdGhlIHBvdGVudGlhbCByaXNrIHdoZW4gZW5hYmxlIGNvbmZpZyBORVRfRE1BIGFuZCBB
U1lOQ19UWC4NCj4gPiBBc3luY190eCBpcyBsYWNrIG9mIHN1cHBvcnQgaW4gY3VycmVudCByZWxl
YXNlIHByb2Nlc3Mgb2YgZG1hDQo+ID4gZGVzY3JpcHRvciwgYWxsIGRlc2NyaXB0b3JzIHdpbGwg
YmUgcmVsZWFzZWQgd2hhdGV2ZXIgaXMgYWNrZWQgb3INCj4gPiBuby1hY2tlZCBieSBhc3luY190
eCwgc28gdGhlcmUgaXMgYSBwb3RlbnRpYWwgcmFjZSBjb25kaXRpb24gd2hlbiBkbWENCj4gPiBl
bmdpbmUgaXMgdWVzZCBieSBvdGhlcnMgY2xpZW50cyAoZS5nLiB3aGVuIGVuYWJsZSBORVRfRE1B
IHRvIG9mZmxvYWQNCj4gVENQKS4NCj4gPg0KPiA+IEluIG91ciBjYXNlLCBhIHJhY2UgY29uZGl0
aW9uIHdoaWNoIGlzIHJhaXNlZCB3aGVuIHVzZSBib3RoIG9mIHRhbGl0b3MNCj4gPiBhbmQgZG1h
ZW5naW5lIHRvIG9mZmxvYWQgeG9yIGlzIGJlY2F1c2UgbmFwaSBzY2hlZHVsZXIgd2lsbCBzeW5j
IGFsbA0KPiA+IHBlbmRpbmcgcmVxdWVzdHMgaW4gZG1hIGNoYW5uZWxzLCBpdCBhZmZlY3RzIHRo
ZSBwcm9jZXNzIG9mIHJhaWQNCj4gPiBvcGVyYXRpb25zIGR1ZSB0byBhY2tfdHggaXMgbm90IGNo
ZWNrZWQgaW4gZnNsIGRtYS4gVGhlIG5vLWFja2VkDQo+ID4gZGVzY3JpcHRvciBpcyBmcmVlZCB3
aGljaCBpcyBzdWJtaXR0ZWQganVzdCBub3csIGFzIGEgZGVwZW5kZW50IHR4LA0KPiA+IHRoaXMg
ZnJlZWQgZGVzY3JpcHRvciB0cmlnZ2VyDQo+ID4gQlVHX09OKGFzeW5jX3R4X3Rlc3RfYWNrKGRl
cGVuZF90eCkpIGluIGFzeW5jX3R4X3N1Ym1pdCgpLg0KPiA+DQo+ID4gQ2M6IERhbiBXaWxsaWFt
cyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPiA+IENjOiBWaW5vZCBLb3VsIDx2aW5vZC5r
b3VsQGludGVsLmNvbT4NCj4gPiBDYzogTGkgWWFuZyA8bGVvbGlAZnJlZXNjYWxlLmNvbT4NCj4g
PiBDYzogSXJhIFcuIFNueWRlciA8aXdzQG92cm8uY2FsdGVjaC5lZHU+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogUWlhbmcgTGl1IDxxaWFuZy5saXVAZnJlZXNjYWxlLmNvbT4NCj4gDQo+IEFsc28gc2Vw
YXJhdGUgdGhlIGZ1bmN0aW9uIG9yZGVyaW5nIGNoYW5nZSBhbmQgcmVhbCBjb2RlIGNoYW5nZSBp
bnRvDQo+IGRpZmZlcmVudCBwYXRjaGVzIHdoZW4geW91IHdvcmsgb24gdGhlIG5leHQgcGF0Y2gg
c2V0Lg0KQWNjZXB0LCBJIHdpbGwgc3BpbHQgaXQgdXAgaW4gdjQuIFRoYW5rcy4NCg0KPiANCj4g
LSBMZW8NCj4gLS0NCj4gVG8gdW5zdWJzY3JpYmUgZnJvbSB0aGlzIGxpc3Q6IHNlbmQgdGhlIGxp
bmUgInVuc3Vic2NyaWJlIGxpbnV4LWNyeXB0byINCj4gaW4gdGhlIGJvZHkgb2YgYSBtZXNzYWdl
IHRvIG1ham9yZG9tb0B2Z2VyLmtlcm5lbC5vcmcgTW9yZSBtYWpvcmRvbW8gaW5mbw0KPiBhdCAg
aHR0cDovL3ZnZXIua2VybmVsLm9yZy9tYWpvcmRvbW8taW5mby5odG1sDQoNCg==

Return-Path: <alexander.steffen@infineon.com>
Received: from smtp2.infineon.com (smtp2.infineon.com
 [IPv6:2a00:18f0:1e00:4::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yH5yr3FXYzDrG0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 20:16:19 +1100 (AEDT)
From: <Alexander.Steffen@infineon.com>
To: <julia.lawall@lip6.fr>, <zohar@linux.vnet.ibm.com>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
 <andriy.shevchenko@linux.intel.com>, <elfring@users.sourceforge.net>,
 <linux-integrity@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <benh@kernel.crashing.org>, <clabbe.montjoie@gmail.com>,
 <jarkko.sakkinen@linux.intel.com>, <jgunthorpe@obsidianresearch.com>,
 <jsnitsel@redhat.com>, <kgold@linux.vnet.ibm.com>, <mpe@ellerman.id.au>,
 <nayna@linux.vnet.ibm.com>, <paulus@samba.org>, <PeterHuewe@gmx.de>,
 <stefanb@linux.vnet.ibm.com>
Subject: RE: [PATCH 3/4] char/tpm: Improve a size determination in nine
 functions
Date: Wed, 18 Oct 2017 09:16:12 +0000
Message-ID: <9c1c9a5fa0ce4e978d0bd2571d88e57d@infineon.com>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <83a166af-aecc-649d-dfe3-a72245345209@users.sourceforge.net>
 <1508238182.16112.475.camel@linux.intel.com>
 <c8d37c0407a949c1abb35cfd79c17f58@infineon.com>
 <1508244757.4234.60.camel@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1710171456360.5035@hadrien>
 <1508253453.4234.81.camel@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1710171725080.5035@hadrien>
In-Reply-To: <alpine.DEB.2.20.1710171725080.5035@hadrien>
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

PiBPbiBUdWUsIDE3IE9jdCAyMDE3LCBNaW1pIFpvaGFyIHdyb3RlOg0KPiANCj4gPiBPbiBUdWUs
IDIwMTctMTAtMTcgYXQgMTQ6NTggKzAyMDAsIEp1bGlhIExhd2FsbCB3cm90ZToNCj4gPiA+DQo+
ID4gPiBPbiBUdWUsIDE3IE9jdCAyMDE3LCBNaW1pIFpvaGFyIHdyb3RlOg0KPiA+ID4NCj4gPiA+
ID4gT24gVHVlLCAyMDE3LTEwLTE3IGF0IDExOjUwICswMDAwLCBBbGV4YW5kZXIuU3RlZmZlbkBp
bmZpbmVvbi5jb20NCj4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+IFJlcGxhY2UgdGhlIHNw
ZWNpZmljYXRpb24gb2YgZGF0YSBzdHJ1Y3R1cmVzIGJ5IHBvaW50ZXINCj4gZGVyZWZlcmVuY2Vz
DQo+ID4gPiA+ID4gPiA+IGFzIHRoZSBwYXJhbWV0ZXIgZm9yIHRoZSBvcGVyYXRvciAic2l6ZW9m
IiB0byBtYWtlIHRoZQ0KPiBjb3JyZXNwb25kaW5nDQo+ID4gPiA+ID4gPiA+IHNpemUNCj4gPiA+
ID4gPiA+ID4gZGV0ZXJtaW5hdGlvbiBhIGJpdCBzYWZlciBhY2NvcmRpbmcgdG8gdGhlIExpbnV4
IGNvZGluZyBzdHlsZQ0KPiA+ID4gPiA+ID4gPiBjb252ZW50aW9uLg0KPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGlzIHBhdGNoIGRvZXMgb25lIHN0eWxlIGluIGZhdm9y
IG9mIHRoZSBvdGhlci4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEkgYWN0dWFsbHkgcHJlZmVyIHRo
YXQgc3R5bGUsIHNvIEknZCB3ZWxjb21lIHRoaXMgY2hhbmdlIDopDQo+ID4gPiA+DQo+ID4gPiA+
IFN0eWxlIGNoYW5nZXMgc2hvdWxkIGJlIHJldmlld2VkIGFuZCBkb2N1bWVudGVkLCBsaWtlIGFu
eSBvdGhlcg0KPiBjb2RlDQo+ID4gPiA+IGNoYW5nZSwgYW5kIGFkZGVkIHRvIERvY3VtZW50YXRp
b24vcHJvY2Vzcy9jb2Rpbmctc3R5bGUucnN0IG9yIGFuDQo+ID4gPiA+IGVxdWl2YWxlbnQgZmls
ZS4NCj4gPiA+DQo+ID4gPiBBY3R1YWxseSwgaXQgaGFzIGJlZW4gdGhlcmUgZm9yIG1hbnkgeWVh
cnM6DQo+ID4gPg0KPiA+ID4gMTQpIEFsbG9jYXRpbmcgbWVtb3J5DQo+ID4gPiAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCj4gPiA+IC4uLg0KPiA+ID4gVGhlIHByZWZlcnJlZCBmb3JtIGZvciBwYXNz
aW5nIGEgc2l6ZSBvZiBhIHN0cnVjdCBpcyB0aGUgZm9sbG93aW5nOg0KPiA+ID4NCj4gPiA+IC4u
IGNvZGUtYmxvY2s6OiBjDQo+ID4gPg0KPiA+ID4gCXAgPSBrbWFsbG9jKHNpemVvZigqcCksIC4u
Lik7DQo+ID4gPg0KPiA+ID4gVGhlIGFsdGVybmF0aXZlIGZvcm0gd2hlcmUgc3RydWN0IG5hbWUg
aXMgc3BlbGxlZCBvdXQgaHVydHMgcmVhZGFiaWxpdHkNCj4gYW5kDQo+ID4gPiBpbnRyb2R1Y2Vz
IGFuIG9wcG9ydHVuaXR5IGZvciBhIGJ1ZyB3aGVuIHRoZSBwb2ludGVyIHZhcmlhYmxlIHR5cGUg
aXMNCj4gY2hhbmdlZA0KPiA+ID4gYnV0IHRoZSBjb3JyZXNwb25kaW5nIHNpemVvZiB0aGF0IGlz
IHBhc3NlZCB0byBhIG1lbW9yeSBhbGxvY2F0b3IgaXMgbm90Lg0KPiA+DQo+ID4gVHJ1ZSwgdGhh
bmtzIGZvciB0aGUgcmVtaW5kZXIuIMKgSXMgdGhpcyBjb21tb24gaW4gbmV3IGNvZGU/IMKgSXMg
dGhlcmUNCj4gPiBhIHNjcmlwdC8gb3Igc29tZSBvdGhlciBhdXRvbWF0ZWQgd2F5IG9mIGNhdGNo
aW5nIHRoaXMgdXNhZ2UgYmVmb3JlDQo+ID4gcGF0Y2hlcyBhcmUgdXBzdHJlYW1lZD8NCj4gPg0K
PiA+IEp1c3QgYXMgeW91J3JlIGRvaW5nIGhlcmUsIHRoZSBwYXRjaCBkZXNjcmlwdGlvbiBzaG91
bGQgcmVmZXJlbmNlIHRoaXMNCj4gPiBpbiB0aGUgcGF0Y2ggZGVzY3JpcHRpb24uDQo+IA0KPiBU
aGUgY29tbWVudCBpbiB0aGUgZG9jdW1lbnRhdGlvbiBzZWVtcyBoYXZlIGJlZW4gdGhlcmUgc2lu
Y2UgTGludXgNCj4gMi42LjE0LA0KPiBpZSAyMDA1LiAgVGhlIGZhY3QgdGhhdCBhIGxvdCBvZiBj
b2RlIHN0aWxsIGRvZXNuJ3QgdXNlIHRoYXQgc3R5bGUsIDEyDQo+IHllYXJzIGxhdGVyLCBzdWdn
ZXN0cyB0aGF0IGFjdHVhbGx5IGl0IGlzIG5vdCBwcmVmZXJyZWQsIG9yIG5vdCBwcmVmZXJyZWQN
Cj4gYnkgZXZlcnlvbmUuICBQZXJoYXBzIHRoZSBwYXJhZ3JhcGggaW4gY29kaW5nIHN0eWxlIHNo
b3VsZCBqdXN0IGJlDQo+IGRyb3BwZWQuDQoNCk9yIG1heWJlIGV2ZXJ5b25lIGp1c3QgY29waWVk
IGV4aXN0aW5nIGNvZGUsIHdoaWNoIGRpZCBub3QgZm9sbG93IHRoYXQgcGF0dGVybiwgYmVjYXVz
ZSBub2JvZHkgYm90aGVyZWQgdG8gZml4IG9sZCBjb2RlIDstKQ0KDQooVGhpcyBpcyB0cnVlIGF0
IGxlYXN0IGZvciB0cG1fdGlzX3NwaSwgd2hlcmUgSSB3YXMgaW52b2x2ZWQgaW4gaXRzIGNyZWF0
aW9uLikNCg0KQWxleGFuZGVyDQo=

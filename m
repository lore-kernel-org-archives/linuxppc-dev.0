Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by lists.ozlabs.org (Postfix) with SMTP id 564851A000D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 19:20:52 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 04167-03 for <linuxppc-dev@lists.ozlabs.org>;
 Wed, 25 Jun 2014 10:20:50 +0100 (BST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Wei Yang' <weiyang@linux.vnet.ibm.com>, Alexey Kardashevskiy
 <aik@ozlabs.ru>
Subject: RE: [RFC PATCH V3 06/17] ppc/pnv: allocate pe->iommu_table dynamically
Date: Wed, 25 Jun 2014 09:20:11 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D17264AD8@AcuExch.aculab.com>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1402365399-5121-7-git-send-email-weiyang@linux.vnet.ibm.com>
 <53A94DA8.6020206@ozlabs.ru> <20140625011211.GA5785@richard>
 <53AA4C32.7060004@ozlabs.ru> <20140625052758.GA8873@richard>
In-Reply-To: <20140625052758.GA8873@richard>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "benh@au1.ibm.com" <benh@au1.ibm.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "gwshan@linux.vnet.ibm.com" <gwshan@linux.vnet.ibm.com>,
 "qiudayu@linux.vnet.ibm.com" <qiudayu@linux.vnet.ibm.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "yan@linux.vnet.ibm.com" <yan@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogV2VpIFlhbmcNCj4gT24gV2VkLCBKdW4gMjUsIDIwMTQgYXQgMDI6MTI6MzRQTSArMTAw
MCwgQWxleGV5IEthcmRhc2hldnNraXkgd3JvdGU6DQo+ID5PbiAwNi8yNS8yMDE0IDExOjEyIEFN
LCBXZWkgWWFuZyB3cm90ZToNCj4gPj4gT24gVHVlLCBKdW4gMjQsIDIwMTQgYXQgMDg6MDY6MzJQ
TSArMTAwMCwgQWxleGV5IEthcmRhc2hldnNraXkgd3JvdGU6DQo+ID4+PiBPbiAwNi8xMC8yMDE0
IDExOjU2IEFNLCBXZWkgWWFuZyB3cm90ZToNCj4gPj4+PiBDdXJyZW50IGlvbW11X3RhYmxlIG9m
IGEgUEUgaXMgYSBzdGF0aWMgZmllbGQuIFRoaXMgd2lsbCBoYXZlIGEgcHJvYmxlbSB3aGVuDQo+
ID4+Pj4gaW9tbXVfZnJlZV90YWJsZSBpcyBjYWxsZWQuDQo+ID4+Pg0KPiA+Pj4gV2hhdCBraW5k
IG9mIHByb2JsZW0/IFRoaXMgdGFibGUgaXMgcGVyIFBFIGFuZCBQRSBpcyBub3QgZ29pbmcgYW55
d2hlcmUuDQo+ID4+Pg0KPiA+Pg0KPiA+PiBZZXMsIGZvciBCdXMgUEUsIHRoZXkgd2lsbCBhbHdh
eXMgc2l0IGluIHRoZSBzeXN0ZW0uIFdoZW4gVkYgUEUgaW50cm9kdWNlZCwNCj4gPj4gdGhleSBj
b3VsZCBiZSByZWxlYXNlZCBvbiB0aGUgZmx5LiBXaGVuIHRoZXkgYXJlIHJlbGVhc2VkLCBzbyBk
byB0aGUgaW9tbXUNCj4gPj4gdGFibGUgZm9yIHRoZSBQRS4NCj4gPg0KPiA+aW9tbXVfdGFibGUg
aXMgYSBwYXJ0IG9mIFBFIHN0cnVjdC4gV2hlbiBQRSBpcyByZWxlYXNlZCwgaW9tbXVfdGFibGUg
d2lsbA0KPiA+Z28gd2l0aCBpdCBhcyB3ZWxsLiBXaHkgdG8gbWFrZSBpcyBhIHBvaW50ZXI/IEkg
d291bGQgdW5kZXJzdGFuZCBpdCBpZiB5b3UNCj4gPmFkZGVkIHJlZmVyZW5jZSBjb3VudGluZyB0
aGVyZSBidXQgbm8gLSBpb21tdV90YWJsZSdzIGxpZmV0aW1lIGlzIGVxdWFsIHRvDQo+ID5QRSBs
aWZldGltZS4NCj4gPg0KPiANCj4gWWVzLCBpb21tdV90YWxiZSdzIGxpZmUgdGltZSBlcXVhbHMg
dG8gUEUgbGlmZXRpbWUsIHNvIHdoZW4gcmVsZWFzaW5nIGEgUEUgd2UNCj4gbmVlZCB0byByZWxl
YXNlIHRoZSBpb21tdSB0YWJsZS4gQ3VycmVudGx5LCB0aGVyZSBpcyBvbmUgZnVuY3Rpb24gdG8g
cmVsZWFzZQ0KPiB0aGUgaW9tbXUgdGFibGUsIGlvbW11X2ZyZWVfdGFibGUoKSB3aGljaCB0YWtl
cyBhIHBvaW50ZXIgb2YgdGhlIGlvbW11X3RhYmxlDQo+IGFuZCByZWxlYXNlIGl0Lg0KPiANCj4g
SWYgdGhlIGlvbW11IHRhYmxlIGluIFBFIGlzIGp1c3QgYSBwYXJ0IG9mIFBFLCBpdCB3aWxsIGhh
dmUgc29tZSBwcm9ibGVtIHRvDQo+IHJlbGVhc2UgaXQgd2l0aCBpb21tdV9mcmVlX3RhYmxlKCku
IFRoYXQncyB3aHkgSSBtYWtlIGl0IGEgcG9pbnRlciBpbiBQRQ0KPiBzdHJ1Y3R1cmUuDQoNCldo
YXQgYXJlIHRoZSBzaXplcyBvZiB0aGUgaW9tbXUgdGFibGUgYW5kIHRoZSBQRSBzdHJ1Y3R1cmU/
DQpJZiB0aGUgdGFibGUgaXMgYSByb3VuZCBudW1iZXIgb2YgcGFnZXMgdGhlbiB5b3UgcHJvYmFi
bHkgZG9uJ3Qgd2FudCB0bw0KZW1iZWQgaXQgaW5zaWRlIHRoZSBQRSBzdHJ1Y3R1cmUuDQoNCglE
YXZpZA0KDQo=

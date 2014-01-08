Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0209.outbound.protection.outlook.com [207.46.163.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1E0782C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jan 2014 14:51:22 +1100 (EST)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: Jiang Liu <jiang.liu@linux.intel.com>, Yijing Wang
 <wangyijing@huawei.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: RE: [PATCH 1/2] pci: Fix root port bus->self is NULL
Date: Wed, 8 Jan 2014 03:51:14 +0000
Message-ID: <0dcbb762af7a411984315b0ee5313718@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1389081848-26506-1-git-send-email-dongsheng.wang@freescale.com>
 <52CBBA86.7020401@huawei.com> <52CBC0B6.1090904@linux.intel.com>
 <80033eb36b0f40d682aeecc8b99dbd95@BN1PR03MB188.namprd03.prod.outlook.com>
 <52CCB8E9.6020501@linux.intel.com>
In-Reply-To: <52CCB8E9.6020501@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "galak@codeaurora.org" <galak@codeaurora.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmlhbmcgTGl1IFttYWls
dG86amlhbmcubGl1QGxpbnV4LmludGVsLmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5
IDA4LCAyMDE0IDEwOjMzIEFNDQo+IFRvOiBXYW5nIERvbmdzaGVuZy1CNDA1MzQ7IFlpamluZyBX
YW5nOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyByandAcmp3eXNvY2tpLm5ldA0KPiBDYzogV29vZCBT
Y290dC1CMDc0MjE7IGdhbGFrQGNvZGVhdXJvcmEub3JnOyBaYW5nIFJveS1SNjE5MTE7IGxpbnV4
LQ0KPiBwY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gcGNpOiBGaXggcm9vdCBwb3J0IGJ1cy0+c2VsZiBp
cyBOVUxMDQo+IA0KPiANCj4gDQo+IE9uIDIwMTQvMS83IDE3OjUxLCBEb25nc2hlbmcuV2FuZ0Bm
cmVlc2NhbGUuY29tIHdyb3RlOg0KPiA+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wcm9i
ZS5jIGIvZHJpdmVycy9wY2kvcHJvYmUuYyBpbmRleA0KPiA+Pj4+IDM4ZTQwM2QuLjdmMmQxYWIg
MTAwNjQ0DQo+ID4+Pj4gLS0tIGEvZHJpdmVycy9wY2kvcHJvYmUuYw0KPiA+Pj4+ICsrKyBiL2Ry
aXZlcnMvcGNpL3Byb2JlLmMNCj4gPj4+PiBAQCAtMTQ3Miw2ICsxNDcyLDkgQEAgaW50IHBjaV9z
Y2FuX3Nsb3Qoc3RydWN0IHBjaV9idXMgKmJ1cywgaW50IGRldmZuKQ0KPiA+Pj4+ICAJaWYgKCFk
ZXYtPmlzX2FkZGVkKQ0KPiA+Pj4+ICAJCW5yKys7DQo+ID4+Pj4NCj4gPj4+PiArCWlmIChwY2lf
cGNpZV90eXBlKGRldikgPT0gUENJX0VYUF9UWVBFX1JPT1RfUE9SVCkNCj4gPj4+PiArCQlidXMt
PnNlbGYgPSBkZXY7DQo+ID4+Pg0KPiA+Pj4gSW4gdGhpcyBjYXNlLCBidXMgaXMgdGhlIHBjaSBy
b290IGJ1cyBJIHRoaW5rLCBzbyB3aHkgc2V0IGJ1cy0+c2VsZg0KPiA+Pj4gPSByb290DQo+ID4+
IHBvcnQgPw0KPiA+Pj4gImJ1cy0+c2VsZiIgc2hvdWxkIHBvaW50ZXIgdG8gdGhlIHBjaSBkZXZp
Y2UgdGhhdCBicmlkZ2Ugb3V0IHRoaXMgYnVzLg0KPiA+PiBZZXMsIHRoaXMgcGF0Y2ggc2VlbXMg
d3JvbmcuIElmIGRldiBpcyByb290IHBvcnQsIGJ1cyBzaG91bGQgYmUgcm9vdA0KPiA+PiBidXMs
IHNvIHdlIHNob3VsZG4ndCBzZXQgcm9vdF9idXMtPnNlbGYgPSBwY2lfZGV2X29mX3Jvb3RfcG9y
dC4NCj4gPj4NCj4gPiBXaHkgdGhlIHJvb3QgYnVzLT5zZWxmIHBvaW50ZXIgdG8gdGhlIGJyaWRn
ZT8NCj4gPiBJZiBjaGlsZCBidXMgY3JlYXRlIGZyb20gcm9vdCBidXMsIHRoZSBjaGlsZC0+c2Vs
ZiB3aWxsIGdldCB0aGUgYnJpZGdlKHJvb3QNCj4gcG9ydCkgcGNpIGRldmljZS4NCj4gPg0KPiA+
PiBBY3R1YWxseSBQQ0kgY29yZSBoYXMgY29ycmVjdGx5IHNldHVwIHBjaV9idXMtPnNlbGYgZm9y
IHNlY29uZGFyeSBidXMNCj4gPj4gb2YgUENJZSByb290IHBvcnQuDQo+ID4gWWVzLCByaWdodC4g
QnV0IHRoZSByb290LWJ1cy0+c2VsZiBpcyBOVUxMLiBJIHRoaW5rIHRoZSByb290IGJ1cw0KPiA+
IHNob3VsZCBnZXQgcm9vdCBwb3J0IHBjaSBkZXZpY2UgZm9yIGl0c2VsZi4gSWYgdGhlcmUgaXMg
bm8gYnJpZGdlIGF0IGJvYXJkIGhvdw0KPiB0byBnZXQgdGhlIHJvb3QgcG9ydCBkZXZpY2U/DQo+
IEhpIERvbmdzaGVuZywNCj4gCVBDSSByb290IGJ1cyByZXByZXNlbnRzIFBDSSBob3N0IGJyaWRn
ZSwgd2hpY2ggaGFzIG5vIGNvcnJlc3BvbmRpbmcgUENJDQo+IGRldmljZS4NCj4gDQpZZXMsIGFn
cmVlLiBJZiBtb3JlIHRoYW4gb25lIGJyaWRnZSBvbiB0aGUgcm9vdCBidXMsIHRoaXMgcGF0Y2gg
aXMgd3JvbmcuDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcuIDopDQoNCi1Eb25nc2hlbmcNCg0K
PiA+DQo+ID4gLURvbmdzaGVuZw0KPiA+DQo+ID4+DQo+ID4+IFRoYW5rcyENCj4gPj4gR2VycnkN
Cj4gPj4NCj4gPg0KPiANCg0K

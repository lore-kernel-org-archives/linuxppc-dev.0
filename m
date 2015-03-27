Return-Path: <Amit.Tomar@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0117.outbound.protection.outlook.com [207.46.100.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A8A3B1A06B9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 00:21:14 +1100 (AEDT)
From: Amit Tomar <Amit.Tomar@freescale.com>
To: Wolfram Sang <wsa@the-dreams.de>
Subject: RE: [PATCH] i2c/mpc: Fix ISR return value
Date: Fri, 27 Mar 2015 12:47:10 +0000
Message-ID: <BL2PR03MB44973331DBA9AE4940F125A83090@BL2PR03MB449.namprd03.prod.outlook.com>
References: <BL2PR03MB449C87445D2FD1F15E9D33483310@BL2PR03MB449.namprd03.prod.outlook.com>
 <20150205193612.GG15307@katana>
In-Reply-To: <20150205193612.GG15307@katana>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ID4+SSBjYW4ndCBhcHBseSB0aGUgcGF0Y2guIFRoZXJlIHNlZW0gdG8gYmUgd2hpdGVzcGFjZSBw
cm9ibGVtcy4gUGxlYXNlIGZpeCB0aGUgcGF0Y2ggb3IgeW91ciBtYWlsIHNlbmRpbmcuDQoNClNv
cnJ5IGZvciB0aGUgRGVsYXllZCByZXNwb25zZSBhbmQgSXQncyBteSBCYWQgYXMgSSBkaWRuJ3Qg
cGFzcyBpdCB0aHJvdWdoIGNoZWNrcGF0Y2guDQoNCkkgd291bGQgc2VuZCBhIGZyZXNoIHBhdGNo
Lg0KDQpUaGFua3MNCkFtaXQuDQogDQoNCj4gLS0tDQo+IGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMt
bXBjLmMgfMKgwqDCoCAzICsrLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1t
cGMuYyANCj4gYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLW1wYy5jIGluZGV4IDBlZGY2MzAuLjdh
MzEzNmYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtbXBjLmMNCj4gKysr
IGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1tcGMuYw0KPiBAQCAtOTUsOCArOTUsOSBAQCBzdGF0
aWMgaXJxcmV0dXJuX3QgbXBjX2kyY19pc3IoaW50IGlycSwgdm9pZCANCj4gKmRldl9pZCkNCj4g
wqDCoMKgwqDCoMKgwqAgaTJjLT5pbnRlcnJ1cHQgPSByZWFkYihpMmMtPmJhc2UgKyBNUENfSTJD
X1NSKTsNCj4gwqDCoMKgwqDCoMKgwqAgd3JpdGViKDAsIGkyYy0+YmFzZSArIE1QQ19JMkNfU1Ip
Ow0KPiDCoMKgwqDCoMKgwqDCoCB3YWtlX3VwKCZpMmMtPnF1ZXVlKTsNCj4gK8KgwqAgwqDCoCAg
cmV0dXJuIElSUV9IQU5ETEVEOw0KPiDCoMKgwqAgfQ0KPiAtwqAgcmV0dXJuIElSUV9IQU5ETEVE
Ow0KPiArIMKgcmV0dXJuIElSUV9OT05FOw0KPiB9DQo+IA0KPiAvKiBTb21ldGltZXMgOXRoIGNs
b2NrIHB1bHNlIGlzbid0IGdlbmVyYXRlZCwgYW5kIHNsYXZlIGRvZXNuJ3QgDQo+IHJlbGVhc2UN
Cj4gLS0NCj4gMS43LjkuNQ0KPiAgDQo+IC0tDQo+IFRvIHVuc3Vic2NyaWJlIGZyb20gdGhpcyBs
aXN0OiBzZW5kIHRoZSBsaW5lICJ1bnN1YnNjcmliZSBsaW51eC1pMmMiIA0KPiBpbiB0aGUgYm9k
eSBvZiBhIG1lc3NhZ2UgdG8gbWFqb3Jkb21vQHZnZXIua2VybmVsLm9yZyBNb3JlIG1ham9yZG9t
byANCj4gaW5mbyBhdCAgaHR0cDovL3ZnZXIua2VybmVsLm9yZy9tYWpvcmRvbW8taW5mby5odG1s
DQo=

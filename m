Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0148.outbound.protection.outlook.com [65.55.169.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB01D1A0225
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 15:28:15 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "lauraa@codeaurora.org" <lauraa@codeaurora.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "olof@lixom.net"
 <olof@lixom.net>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "Xiaobo Xie" <X.Xie@freescale.com>
Subject: RE: [RFC] genalloc:add an gen_pool_alloc_align func to genalloc
Date: Fri, 10 Jul 2015 05:28:06 +0000
Message-ID: <SN1PR0301MB1550139916D439D875E436D39B9F0@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1436428063-893-1-git-send-email-B45475@freescale.com>
 <1436480372.2658.153.camel@freescale.com>
In-Reply-To: <1436480372.2658.153.camel@freescale.com>
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

DQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXb29kIFNjb3R0LUIw
NzQyMQ0KPiBTZW50OiBGcmlkYXksIEp1bHkgMTAsIDIwMTUgNjoyMCBBTQ0KPiBUbzogWmhhbyBR
aWFuZy1CNDU0NzUNCj4gQ2M6IGxhdXJhYUBjb2RlYXVyb3JhLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgbGludXhwcGMtDQo+IGRldkBsaXN0cy5vemxhYnMub3JnOyBha3BtQGxp
bnV4LWZvdW5kYXRpb24ub3JnOyBvbG9mQGxpeG9tLm5ldDsNCj4gY2F0YWxpbi5tYXJpbmFzQGFy
bS5jb207IFhpZSBYaWFvYm8tUjYzMDYxDQo+IFN1YmplY3Q6IFJlOiBbUkZDXSBnZW5hbGxvYzph
ZGQgYW4gZ2VuX3Bvb2xfYWxsb2NfYWxpZ24gZnVuYyB0byBnZW5hbGxvYw0KPiANCj4gT24gVGh1
LCAyMDE1LTA3LTA5IGF0IDE1OjQ3ICswODAwLCBaaGFvIFFpYW5nIHdyb3RlOg0KPiA+IEBAIC01
NDEsMTMgKzU2MiwxNCBAQCBFWFBPUlRfU1lNQk9MKGdlbl9wb29sX2ZpcnN0X2ZpdF9vcmRlcl9h
bGlnbik7DQo+ID4gICAqIHdoaWNoIHdlIGNhbiBhbGxvY2F0ZSB0aGUgbWVtb3J5Lg0KPiA+ICAg
Ki8NCj4gPiAgdW5zaWduZWQgbG9uZyBnZW5fcG9vbF9iZXN0X2ZpdCh1bnNpZ25lZCBsb25nICpt
YXAsIHVuc2lnbmVkIGxvbmcgc2l6ZSwNCj4gPiAtICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcg
c3RhcnQsIHVuc2lnbmVkIGludCBuciwgdm9pZCAqZGF0YSkNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIHN0YXJ0LCB1bnNpZ25lZCBpbnQgbnIsDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqZGF0YSwgdW5zaWduZWQgbG9uZyBh
bGlnbl9tYXNrKQ0KPiA+ICB7DQo+ID4gICAgICAgdW5zaWduZWQgbG9uZyBzdGFydF9iaXQgPSBz
aXplOw0KPiA+ICAgICAgIHVuc2lnbmVkIGxvbmcgbGVuID0gc2l6ZSArIDE7DQo+ID4gICAgICAg
dW5zaWduZWQgbG9uZyBpbmRleDsNCj4gPg0KPiA+IC0gICAgIGluZGV4ID0gYml0bWFwX2ZpbmRf
bmV4dF96ZXJvX2FyZWEobWFwLCBzaXplLCBzdGFydCwgbnIsIDApOw0KPiA+ICsgICAgIGluZGV4
ID0gYml0bWFwX2ZpbmRfbmV4dF96ZXJvX2FyZWEobWFwLCBzaXplLCBzdGFydCwgbnIsDQo+IGFs
aWduX21hc2spOw0KPiA+DQo+ID4gICAgICAgd2hpbGUgKGluZGV4IDwgc2l6ZSkgew0KPiA+ICAg
ICAgICAgICAgICAgaW50IG5leHRfYml0ID0gZmluZF9uZXh0X2JpdChtYXAsIHNpemUsIGluZGV4
ICsgbnIpOw0KPiANCj4gV2hhdCBhYm91dCB0aGUgb3RoZXIgY2FsbCB0byBiaXRtYXBfZmluZF9u
ZXh0X3plcm9fYXJlYSgpPw0KDQpBbGwgb3RoZXJzIHdpbGwgcGFzcyB0aGUgYWxpZ25fbWFzayB0
byBiaXRtYXBfZmluZF9uZXh0X3plcm9fYXJlYS4NCg0KPiANCj4gLVNjb3R0DQoNCg==

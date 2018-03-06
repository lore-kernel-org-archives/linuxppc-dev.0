Return-Path: <nipun.gupta@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0082.outbound.protection.outlook.com [104.47.1.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwPJK2RDFzF1Jl
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 15:42:07 +1100 (AEDT)
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
CC: "will.deacon@arm.com" <will.deacon@arm.com>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "joro@8bytes.org" <joro@8bytes.org>, Leo Li
 <leoyang.li@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Bharat Bhushan <bharat.bhushan@nxp.com>,
 "stuyoder@gmail.com" <stuyoder@gmail.com>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>
Subject: RE: [PATCH 5/6] dma-mapping: support fsl-mc bus
Date: Tue, 6 Mar 2018 04:41:56 +0000
Message-ID: <HE1PR0401MB24251E99564CAA526F719ECCE6D90@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1520260166-29387-6-git-send-email-nipun.gupta@nxp.com>
 <20180305150814.GA15918@lst.de>
 <7b4f9972-6aaa-fc9d-3854-d48b19a8051c@arm.com>
 <20180305183938.GB20086@lst.de>
 <1729ae21-d08c-b413-51a3-f22c394b388d@arm.com>
In-Reply-To: <1729ae21-d08c-b413-51a3-f22c394b388d@arm.com>
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

DQoNCj4gRnJvbTogUm9iaW4gTXVycGh5IFttYWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+
IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDA2LCAyMDE4IDA6MjINCj4gDQo+IE9uIDA1LzAzLzE4IDE4
OjM5LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gPiBPbiBNb24sIE1hciAwNSwgMjAxOCBh
dCAwMzo0ODozMlBNICswMDAwLCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+ID4+IFVuZm9ydHVuYXRl
bHkgZm9yIHVzLCBmc2wtbWMgaXMgY29uY2VwdHVhbGx5IHJhdGhlciBsaWtlIFBDSSBpbiB0aGF0
IGl0J3MNCj4gPj4gc29mdHdhcmUtZGlzY292ZXJhYmxlIGFuZCB0aGUgb25seSB0aGluZyBkZXNj
cmliZWQgaW4gRFQgaXMgdGhlIGJ1cyAiaG9zdCIsDQo+ID4+IHRodXMgd2UgbmVlZCB0aGUgc2Ft
ZSBzb3J0IG9mIHRoaW5nIGFzIGZvciBQQ0kgdG8gbWFwIGZyb20gdGhlIGNoaWxkDQo+ID4+IGRl
dmljZXMgYmFjayB0byB0aGUgYnVzIHJvb3QgaW4gb3JkZXIgdG8gZmluZCB0aGUgYXBwcm9wcmlh
dGUgZmlybXdhcmUNCj4gPj4gbm9kZS4gV29yc2UgdGhhbiBQQ0ksIHRob3VnaCwgd2Ugd291bGRu
J3QgZXZlbiBoYXZlIHRoZSBvcHRpb24gb2YNCj4gPj4gZGVzY3JpYmluZyBjaGlsZCBkZXZpY2Vz
IHN0YXRpY2FsbHkgaW4gZmlybXdhcmUgYXQgYWxsLCBzaW5jZSBpdCdzIGFjdHVhbGx5DQo+ID4+
IG9uZSBvZiB0aGVzZSBydW50aW1lLWNvbmZpZ3VyYWJsZSAiYnVpbGQgeW91ciBvd24gbmV0d29y
ayBhY2NlbGVyYXRvciINCj4gPj4gaGFyZHdhcmUgcG9vbHMgd2hlcmUgdXNlcnNwYWNlIGdldHMg
dG8gY3JlYXRlIGFuZCBkZXN0cm95ICJkZXZpY2VzIiBhcyBpdA0KPiA+PiBsaWtlcy4NCj4gPg0K
PiA+IEkgcmVhbGx5IGhhdGUgdGhlIFBDSSBzcGVjaWFsIGNhc2UganVzdCBhcyBtdWNoLiAgTWF5
YmUgd2UganVzdA0KPiA+IG5lZWQgYSBkbWFfY29uZmlndXJlIG1ldGhvZCBvbiB0aGUgYnVzLCBh
bmQgbW92ZSBQQ0kgYXMgd2VsbCBhcyBmc2wtbWMNCj4gPiB0byBpdC4NCj4gDQo+IEhtbSwgb24g
cmVmbGVjdGlvbiwgMTAwJSBhY2sgdG8gdGhhdCBpZGVhLiBJdCB3b3VsZCBuZWF0bHkgc3VwZXJz
ZWRlDQo+IGJ1cy0+Zm9yY2VfZG1hICphbmQqIG1lYW4gdGhhdCB3ZSBkb24ndCBoYXZlIHRvIGVm
ZmVjdGl2ZWx5IHB1bGwgcGNpLmgNCj4gaW50byBldmVyeXRoaW5nLCB3aGljaCBJJ3ZlIG5ldmVy
IGxpa2VkLiBJbiBoaW5kc2lnaHQgZG1hX2NvbmZpZ3VyZSgpDQo+IGRvZXMgZmVlbCBsaWtlIGl0
J3MgZ3Jvd24gaW50byB0aGlzIG9kZCBjaG9rZSBwb2ludCB3aGVyZSB3ZSBtdW5nZQ0KPiBldmVy
eXRoaW5nIGluIGp1c3QgZm9yIGl0IHRvIGF3a3dhcmRseSB1bnBpY2sgdGhpbmdzIGFnYWluLg0K
PiANCj4gUm9iaW4uDQoNCisxIHRvIHRoZSBpZGVhLg0KDQpTb3JyeSBmb3IgYXNraW5nIGEgdHJp
dmlhbCBxdWVzdGlvbiAtIGxvb2tpbmcgaW50byBkbWFfY29uZmlndXJlKCkgSSBzZWUgdGhhdA0K
UENJIGlzIHVzZWQgaW4gdGhlIHN0YXJ0IGFuZCB0aGUgZW5kIG9mIHRoZSBBUEkuDQpJbiB0aGUg
ZW5kIHBhcnQgcGNpX3B1dF9ob3N0X2JyaWRnZV9kZXZpY2UoKSBpcyBjYWxsZWQuDQpTbyBhcmUg
dHdvIGJ1cyBjYWxsYmFja3Mgc29tZXRoaW5nIGxpa2UgJ2RtYV9jb25maWdfc3RhcnQnICYgJ2Rt
YV9jb25maWdfZW5kJw0Kd2lsbCBiZSByZXF1aXJlZCB3aGVyZSB0aGUgZm9ybWVyIG9uZSB3aWxs
IHJldHVybiAiZG1hX2RldiI/DQoNClJlZ2FyZHMsDQpOaXB1bg0K

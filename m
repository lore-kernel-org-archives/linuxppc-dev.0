Return-Path: <R61911@freescale.com>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe005.messaging.microsoft.com
	[213.199.154.208]) by ozlabs.org (Postfix) with ESMTP id 8E489B70F3
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Sep 2010 20:15:52 +1000 (EST)
Received: from mail5-am1 (localhost.localdomain [127.0.0.1])	by
	mail5-am1-R.bigfish.com (Postfix) with ESMTP id 7A48C160046B	for
	<linuxppc-dev@ozlabs.org>; Mon,  6 Sep 2010 10:15:47 +0000 (UTC)
Received: from am1ehsmhs003.bigfish.com (unknown [10.3.201.248])	by
	mail5-am1.bigfish.com (Postfix) with ESMTP id 2AA2246804B	for
	<linuxppc-dev@ozlabs.org>; Mon,  6 Sep 2010 10:15:47 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o86AFY2M026631	for
	<linuxppc-dev@ozlabs.org>; Mon, 6 Sep 2010 03:15:44 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP
	id o86ATRF0022265	for <linuxppc-dev@ozlabs.org>;
	Mon, 6 Sep 2010 05:29:28 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: RE: [PATCH 1/3][MTD] P4080/eLBC: Make Freescale elbc interrupt common
	to elbc devices
Date: Mon, 6 Sep 2010 18:15:30 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A1B3898@zch01exm23.fsl.freescale.net>
In-Reply-To: <20100906094414.GA27034@oksana.dev.rtsoft.ru>
References: <1281063096-26598-1-git-send-email-tie-fei.zang@freescale.com>
	<20100903112755.GA11847@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A1B378F@zch01exm23.fsl.freescale.net>
	<20100906082142.GB13755@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A1B3872@zch01exm23.fsl.freescale.net>
	<20100906094414.GA27034@oksana.dev.rtsoft.ru>
From: Zang Roy-R61911 <r61911@freescale.com>
To: "Anton Vorontsov" <cbouatmailru@gmail.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	Lan Chunhe-B25806 <B25806@freescale.com>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	akpm@linux-foundation.org, Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW50b24gVm9yb250c292
IFttYWlsdG86Y2JvdWF0bWFpbHJ1QGdtYWlsLmNvbV0NCj4gU2VudDogTW9uZGF5LCBTZXB0ZW1i
ZXIgMDYsIDIwMTAgMTc6NDQgUE0NCj4gVG86IFphbmcgUm95LVI2MTkxMQ0KPiBDYzogbGludXgt
bXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IExhbiBDaHVuaGUtQjI1ODA2OyBsaW51eHBwYy1kZXZA
b3psYWJzLm9yZzsNCj4gYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsgR2FsYSBLdW1hci1CMTE3
ODA7IFdvb2QgU2NvdHQtQjA3NDIxDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXVtNVERdIFA0
MDgwL2VMQkM6IE1ha2UgRnJlZXNjYWxlIGVsYmMgaW50ZXJydXB0IGNvbW1vbg0KPiB0byBlbGJj
IGRldmljZXMNCj4gDQo+IE9uIE1vbiwgU2VwIDA2LCAyMDEwIGF0IDA1OjI0OjM1UE0gKzA4MDAs
IFphbmcgUm95LVI2MTkxMSB3cm90ZToNCj4gWy4uXQ0KPiA+ID4gbXhtciA9ICZmc2xfbGJjX2N0
cmxfZGV2LT5yZWdzLT5tY21yOw0KPiA+IFRoYXQgbWFrZXMgc2Vuc2UuICBBIGdsb2JhbCBvciBs
b2NhbCB2YXJpYWJsZSBmb3IgZnNsX2xiY19jdHJsX2Rldi0+cmVncz8NCj4gV2hpY2ggb25lIGlz
IGJldHRlcj8NCj4gDQo+IFRoZSBsZXNzIGdsb2JhbCB2YXJpYWJsZXMsIHRoZSBiZXR0ZXIuIFNv
LCBJJ2Qgdm90ZSBmb3INCj4gYSBsb2NhbCBvbmUuDQpJIGFsc28gcHJlZmVyIGxvY2FsIG9uZS4N
Cj4gDQo+ID4gPiBbLi4uXQ0KPiA+ID4gPiA+ID4gK3N0YXRpYyBpbnQgX19kZXZpbml0IGZzbF9s
YmNfY3RybF9wcm9iZShzdHJ1Y3Qgb2ZfZGV2aWNlICpvZmRldiwNCj4gPiA+ID4gPiA+ICsJCQkJ
CSBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkICptYXRjaCkNCj4gPiA+ID4gPiA+ICt7DQo+ID4g
PiA+ID4gPiArCWludCByZXQgPSAwOw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gbm8gbmVlZCBmb3Ig
dGhlIGluaXRpYWwgdmFsdWUgaGVyZS4NCj4gPiA+ID4gQW55IGhhcm0/DQo+ID4gPg0KPiA+ID4g
UHJvYmFibHkgbm90IGFzIGdjYyB3aWxsIGxpa2VseSBvcHRpbWl6ZSBpdCBhd2F5LA0KPiA+ID4g
YnV0IGl0J3Mgbm90IG5lZWRlZCwgc28gd2h5IGtlZXAgaXQgdGhlcmU/DQo+ID4gaGFiaXQuDQo+
IA0KPiA7LSkNCjotKC4NClRoYW5rcyBmb3IgYWxsIHlvdXIgY29tbWVudHMuIFRoYXQgaXMgdmFs
dWFibGUuDQpJIHdpbGwgdXBkYXRlIHRoZSBwYXRjaCBhY2NvcmRpbmcgdG8geW91ciBjb21tZW50
IGFuZCB0aGUgbmV3IHBsYXRmb3JtIGRldmljZSBhcmNoLg0KUm95DQo=

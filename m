Return-Path: <R61911@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
	[213.199.154.205]) by ozlabs.org (Postfix) with ESMTP id E877FB70F4
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Sep 2010 18:39:14 +1000 (EST)
Received: from mail78-am1 (localhost.localdomain [127.0.0.1])	by
	mail78-am1-R.bigfish.com (Postfix) with ESMTP id 9009FE0296	for
	<linuxppc-dev@ozlabs.org>; Mon,  6 Sep 2010 08:39:09 +0000 (UTC)
Received: from am1ehsmhs008.bigfish.com (unknown [10.3.201.240])	by
	mail78-am1.bigfish.com (Postfix) with ESMTP id 173701A7004B	for
	<linuxppc-dev@ozlabs.org>; Mon,  6 Sep 2010 08:39:09 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o868cui2015727	for <linuxppc-dev@ozlabs.org>;
	Mon, 6 Sep 2010 01:39:06 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP
	id o868d1jx024547	for <linuxppc-dev@ozlabs.org>;
	Mon, 6 Sep 2010 03:39:02 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: RE: [PATCH 2/3][MTD] P4080/nand: Only make elbc nand driver detect
	nand flash partitions
Date: Mon, 6 Sep 2010 16:38:51 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A1B385B@zch01exm23.fsl.freescale.net>
In-Reply-To: <20100906080938.GA13755@oksana.dev.rtsoft.ru>
References: <1281063096-26598-1-git-send-email-tie-fei.zang@freescale.com>
	<1281063096-26598-2-git-send-email-tie-fei.zang@freescale.com>
	<20100903114357.GC11847@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A1B37B0@zch01exm23.fsl.freescale.net>
	<20100906080938.GA13755@oksana.dev.rtsoft.ru>
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
ZXIgMDYsIDIwMTAgMTY6MTAgUE0NCj4gVG86IFphbmcgUm95LVI2MTkxMQ0KPiBDYzogbGludXgt
bXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IExhbiBDaHVuaGUtQjI1ODA2OyBsaW51eHBwYy1kZXZA
b3psYWJzLm9yZzsNCj4gYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsgR2FsYSBLdW1hci1CMTE3
ODA7IFdvb2QgU2NvdHQtQjA3NDIxDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8zXVtNVERdIFA0
MDgwL25hbmQ6IE9ubHkgbWFrZSBlbGJjIG5hbmQgZHJpdmVyIGRldGVjdA0KPiBuYW5kIGZsYXNo
IHBhcnRpdGlvbnMNCj4gDQo+IE9uIE1vbiwgU2VwIDA2LCAyMDEwIGF0IDEyOjQ5OjE3UE0gKzA4
MDAsIFphbmcgUm95LVI2MTkxMSB3cm90ZToNCj4gPiA+IE9uIEZyaSwgQXVnIDA2LCAyMDEwIGF0
IDEwOjUxOjM1QU0gKzA4MDAsIFJveSBaYW5nIHdyb3RlOg0KPiA+ID4gWy4uLl0NCj4gPiA+ID4N
Cj4gPiA+ID4gK3N0YXRpYyBzdHJ1Y3QgZnNsX2VsYmNfZmNtX2N0cmwgKmVsYmNfZmNtX2N0cmw7
DQo+ID4gPiA+ICsNCj4gPiA+DQo+ID4gPiBBcmUgeW91IHN1cmUgdGhhdCB5b3Ugd2FudCBpdCBh
cyBhIGdsb2JhbCB2YXI/IEEgYml0IHNjYXJ5IGNoYW5nZS4NCj4gPiA+DQo+ID4gPiBPaCwgeW91
IHByb2JhYmx5IGRvbid0IG5lZWQgaXQsIGFzIHlvdSBjYW4gZ2V0IGl0IGZyb20NCj4gPiA+IGZz
bF9sYmNfY3RybF9kZXYtPm5hbmQ/DQo+ID4gR2V0IGl0IGZvcm0gZnNsX2xiY19jdHJsX2Rldi0+
bmFuZCBvciBhc3NpZ24gaXQgdG8NCj4gPiBmc2xfbGJjX2N0cmxfZGV2LT5uYW5kIGluIHByb2Jl
Pw0KPiANCj4gSSBtZWFudCB0byBnZXQgaXQgZnJvbSBmc2xfbGJjX2N0cmxfZGV2LT5uYW5kLiBJ
LmUuIGluDQo+IHByb2JlKCkgeW91IGRvOiBmc2xfbGJjX2N0cmxfZGV2LT5uYW5kID0gZWxiY19m
Y21fY3RybCwgc28NCj4geW91IHByb2JhYmx5IGRvbid0IG5lZWQgdGhlIGdsb2JhbCB2YXIuDQo+
IA0KPiAoZnNsX2xiY19jdHJsX2RldiBzZWVtcyB0byBiZSBnbG9iYWwgYXMgd2VsbCwgZHVoLiBX
ZWxsLA0KPiBvbmUgdmFyaWFibGUgbGVzcyBpbiB0aGUgZ2xvYmFsIG5hbWUgc3BhY2UuIEJ1dCBJ
J2QNCj4gcHJvYmFibHkgdXNlIGxiY19ucC0+ZGF0YSB0byBzdG9yZSB0aGUgTEJDIHByaXZhdGUN
Cj4gc3RydWN0KS4NClRoYXQgbWFrZXMgc2Vuc2UuDQo+IA0KPiBTY290dCBzZWVtIHRvIGJlIGZp
bmUgd2l0aCBpdCBhcyB0aGVyZSBhcmUgcHJvYmFibHkgbm8NCj4gcGxhbnMgdG8gdG8gYWRkIHNl
dmVyYWwgbG9jYWxidXMgY29udHJvbGxlcnMgaW50byB0aGUgU29Dcy4NCj4gDQo+IEJ1dCwgSSBz
YXcgYSBjdXN0b20gYm9hcmQgd2l0aCB0d28gTVBDODJ4eCBTb0NzIGNvbm5lY3RlZA0KPiB0b2dl
dGhlciwgb25lIGFzIGEgbWFzdGVyIChjb3JlICsgcGVyaXBoZXJhbCBkZXZzKSwgYW5kDQo+IG90
aGVyIGFzIGEgc2xhdmUgKGl0cyBjb3JlIHdhcyBoYWx0ZWQsIGFuZCBvbmx5IHNsYXZlJ3MNCj4g
Q1BNIHBlcmlwaGVyYWwgZGV2aWNlcyB3ZXJlIHVzZWQgYnkgdGhlIG1hc3RlciBDUFUpLg0KPiAN
Cj4gSSB0aGluayBpdCBpcyBwb3NzaWJsZSB0byBjb25uZWN0IHR3byAob3IgbW9yZSkgU29DcyBp
bg0KPiBhIHN1Y2ggd2F5IHNvIHRoYXQgdHdvIG9yIG1vcmUgTEJDIGNvbnRyb2xsZXJzIHdvdWxk
DQo+IGJlIHZpc2libGUgZm9yIHRoZSBMaW51eC4NClRoYXQgaXMgYW4gaW50ZXJlc3RpbmcgY2Fz
ZS4gRG8geW91IGhhdmUgYW55IHRob3VnaHQgaGVyZT8NClRoYW5rcy4NClJveQ0K

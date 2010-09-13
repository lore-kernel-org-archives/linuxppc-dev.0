Return-Path: <R61911@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by ozlabs.org (Postfix) with ESMTP id 77B06B6F14
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Sep 2010 17:22:45 +1000 (EST)
Received: from mail34-tx2 (localhost.localdomain [127.0.0.1])	by
	mail34-tx2-R.bigfish.com (Postfix) with ESMTP id BBF221A03F1	for
	<linuxppc-dev@ozlabs.org>; Mon, 13 Sep 2010 07:22:41 +0000 (UTC)
Received: from TX2EHSMHS041.bigfish.com (unknown [10.9.14.244])	by
	mail34-tx2.bigfish.com (Postfix) with ESMTP id 8D1CBAC8053	for
	<linuxppc-dev@ozlabs.org>; Mon, 13 Sep 2010 07:22:39 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o8D7MFop008444	for <linuxppc-dev@ozlabs.org>;
	Mon, 13 Sep 2010 00:22:26 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP
	id o8D7YkcX015351	for <linuxppc-dev@ozlabs.org>;
	Mon, 13 Sep 2010 02:34:47 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: RE: [PATCH v2 3/3][MTD] P4080/mtd: Fix the freescale lbc issue with
	36bit mode
Date: Mon, 13 Sep 2010 15:22:10 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A1FC150@zch01exm23.fsl.freescale.net>
In-Reply-To: <AANLkTik3ViwjmOFfm6GUwmuzMkO75+2pCUdnC0z8A7Jb@mail.gmail.com>
References: <1284027632-32573-1-git-send-email-tie-fei.zang@freescale.com><1284027632-32573-2-git-send-email-tie-fei.zang@freescale.com><1284027632-32573-3-git-send-email-tie-fei.zang@freescale.com>
	<AANLkTik3ViwjmOFfm6GUwmuzMkO75+2pCUdnC0z8A7Jb@mail.gmail.com>
From: Zang Roy-R61911 <r61911@freescale.com>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: Wood Scott-B07421 <B07421@freescale.com>, dedekind1@gmail.com,
	Lan Chunhe-B25806 <B25806@freescale.com>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	akpm@linux-foundation.org, dwmw2@infradead.org,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogZ2VlcnQudXl0dGVyaG9l
dmVuQGdtYWlsLmNvbSBbbWFpbHRvOmdlZXJ0LnV5dHRlcmhvZXZlbkBnbWFpbC5jb21dIE9uDQo+
IEJlaGFsZiBPZiBHZWVydCBVeXR0ZXJob2V2ZW4NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJl
ciAwOSwgMjAxMCAxOTowNiBQTQ0KPiBUbzogWmFuZyBSb3ktUjYxOTExDQo+IENjOiBsaW51eC1t
dGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgV29vZCBTY290dC1CMDc0MjE7IGRlZGVraW5kMUBnbWFp
bC5jb207IExhbg0KPiBDaHVuaGUtQjI1ODA2OyBsaW51eHBwYy1kZXZAb3psYWJzLm9yZzsgYWtw
bUBsaW51eC1mb3VuZGF0aW9uLm9yZzsNCj4gZHdtdzJAaW5mcmFkZWFkLm9yZzsgR2FsYSBLdW1h
ci1CMTE3ODANCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAzLzNdW01URF0gUDQwODAvbXRkOiBG
aXggdGhlIGZyZWVzY2FsZSBsYmMgaXNzdWUgd2l0aA0KPiAzNmJpdCBtb2RlDQo+IA0KPiBPbiBU
aHUsIFNlcCA5LCAyMDEwIGF0IDEyOjIwLCBSb3kgWmFuZyA8dGllLWZlaS56YW5nQGZyZWVzY2Fs
ZS5jb20+IHdyb3RlOg0KPiA+IEZyb206IExhbiBDaHVuaGUtQjI1ODA2IDxiMjU4MDZAZnJlZXNj
YWxlLmNvbT4NCj4gPg0KPiA+IFdoZW4gc3lzdGVtIHVzZXMgMzZiaXQgcGh5c2ljYWwgYWRkcmVz
cywgcmVzLnN0YXJ0IGlzIDM2Yml0DQo+ID4gcGh5c2ljYWwgYWRkcmVzcy4gQnV0IHRoZSBmdW5j
dGlvbiBvZiBpbl9iZTMyIHJldHVybnMgMzJiaXQNCj4gPiBwaHlzaWNhbCBhZGRyZXNzLiBUaGVu
IGJvdGggb2YgdGhlbSBjb21wYXJlZCBlYWNoIG90aGVyIGlzDQo+ID4gd3JvbmcuIFNvIGJ5IGNv
bnZlcnRpbmcgdGhlIGFkZHJlc3Mgb2YgcmVzLnN0YXJ0IGludG8NCj4gPiB0aGUgcmlnaHQgZm9y
bWF0IGZpeGVzIHRoaXMgaXNzdWUuDQo+IA0KPiA+IMKgLyoqDQo+ID4gKyAqIGZzbF9sYmNfYWRk
ciAtIGNvbnZlcnQgdGhlIGJhc2UgYWRkcmVzcw0KPiA+ICsgKiBAYWRkcl9iYXNlOiBiYXNlIGFk
ZHJlc3Mgb2YgdGhlIG1lbW9yeSBiYW5rDQo+ID4gKyAqDQo+ID4gKyAqIFRoaXMgZnVuY3Rpb24g
Y29udmVydHMgYSBiYXNlIGFkZHJlc3Mgb2YgbGJjIGludG8gdGhlIHJpZ2h0IGZvcm1hdCBmb3IN
Cj4gdGhlIEJSDQo+ID4gKyAqIHJlZ2lzdGVycy4gSWYgdGhlIFNPQyBoYXMgZUxCQyB0aGVuIGl0
IHJldHVybnMgMzJiaXQgcGh5c2ljYWwgYWRkcmVzcw0KPiBlbHNlDQo+ID4gKyAqIGl0IHJldHVy
bnMgMzRiaXQgcGh5c2ljYWwgYWRkcmVzcyBmb3IgbG9jYWwgYnVzKEV4YW1wbGU6IE1QQzg2NDEp
Lg0KPiA+ICsgKi8NCj4gPiArdW5zaWduZWQgaW50IGZzbF9sYmNfYWRkcihwaHlzX2FkZHJfdCBh
ZGRyX2Jhc2UpDQo+ICAgICBeXl5eXl5eXl5eXl4NCj4gU2hvdWxkbid0IHRoaXMgYmUgdTMyIG9y
IF9fYmUzMiwgZm9yIGNvbnNpc3RlbmN5IHdpdGggdGhlIGFjdHVhbA0KPiBjb21wYXJpc29ucyBi
ZWxvdz8NCl9fYmUzMiBpcyBiZXR0ZXIuDQpUaGFua3MuDQpSb3kNCg==

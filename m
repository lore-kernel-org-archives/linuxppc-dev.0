Return-Path: <B21284@freescale.com>
Received: from TX2EHSOBE010.bigfish.com (tx2ehsobe005.messaging.microsoft.com
	[65.55.88.15]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C59FEB70CB
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Oct 2010 13:30:28 +1100 (EST)
Received: from mail27-tx2 (localhost.localdomain [127.0.0.1])	by
	mail27-tx2-R.bigfish.com (Postfix) with ESMTP id 9C7411480A2	for
	<linuxppc-dev@ozlabs.org>; Fri,  8 Oct 2010 02:15:21 +0000 (UTC)
Received: from TX2EHSMHS008.bigfish.com (unknown [10.9.14.247])	by
	mail27-tx2.bigfish.com (Postfix) with ESMTP id 5DF3BA78056	for
	<linuxppc-dev@ozlabs.org>; Fri,  8 Oct 2010 02:15:21 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	o982FQJD005815	for
	<linuxppc-dev@ozlabs.org>; Thu, 7 Oct 2010 19:15:26 -0700 (MST)
Received: from zmy16exm20.fsl.freescale.net (zmy16exm20.ap.freescale.net
	[10.211.3.23])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o982VJAd019103	for <linuxppc-dev@ozlabs.org>;
	Thu, 7 Oct 2010 21:31:20 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: RE: [PATCH v3 6/7] mtd: m25p80: add a read function to read page by
	page
Date: Fri, 8 Oct 2010 10:15:26 +0800
Message-ID: <73839B4A0818E747864426270AC332C3057F6138@zmy16exm20.fsl.freescale.net>
In-Reply-To: <20100930150633.GA13741@oksana.dev.rtsoft.ru>
References: <841976.76219.qm@web180306.mail.gq1.yahoo.com>
	<AANLkTinBDdEyMDt3KoauNdmTCz1ZAJ5mZ23iMWiwsUm4@mail.gmail.com>
	<AANLkTi=GydTyhf3TOzCZOtrme1Jh0UmNDHqTVP59q=LH@mail.gmail.com>
	<20100930150633.GA13741@oksana.dev.rtsoft.ru>
From: Hu Mingkai-B21284 <B21284@freescale.com>
To: Anton Vorontsov <cbouatmailru@gmail.com>, Grant Likely
	<grant.likely@secretlab.ca>
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	Gala Kumar-B11780 <B11780@freescale.com>, linux-mtd@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW50b24gVm9yb250c292
IFttYWlsdG86Y2JvdWF0bWFpbHJ1QGdtYWlsLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIFNlcHRl
bWJlciAzMCwgMjAxMCAxMTowNyBQTQ0KPiBUbzogR3JhbnQgTGlrZWx5DQo+IENjOiBEYXZpZCBC
cm93bmVsbDsgbGludXhwcGMtZGV2QG96bGFicy5vcmc7IEh1IE1pbmdrYWktQjIxMjg0OyBsaW51
eC0NCj4gbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IEdhbGEgS3VtYXItQjExNzgwOyBzcGktZGV2
ZWwtDQo+IGdlbmVyYWxAbGlzdHMuc291cmNlZm9yZ2UubmV0DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjMgNi83XSBtdGQ6IG0yNXA4MDogYWRkIGEgcmVhZCBmdW5jdGlvbiB0byByZWFkIHBhZ2Ug
YnkNCj4gcGFnZQ0KPiANCj4gT24gVGh1LCBTZXAgMzAsIDIwMTAgYXQgMTE6NDE6NDBQTSArMDkw
MCwgR3JhbnQgTGlrZWx5IHdyb3RlOg0KPiA+IE9uIFRodSwgU2VwIDMwLCAyMDEwIGF0IDExOjE2
IFBNLCBHcmFudCBMaWtlbHkNCj4gPiA8Z3JhbnQubGlrZWx5QHNlY3JldGxhYi5jYT4gd3JvdGU6
DQo+ID4gPiBPbiBUaHUsIFNlcCAzMCwgMjAxMCBhdCA3OjQ2IFBNLCBEYXZpZCBCcm93bmVsbCA8
ZGF2aWQtYkBwYWNiZWxsLm5ldD4gd3JvdGU6DQo+ID4gPj4NCj4gPiA+PiAtLS0gT24gVGh1LCA5
LzMwLzEwLCBNaW5na2FpIEh1IDxNaW5na2FpLmh1QGZyZWVzY2FsZS5jb20+IHdyb3RlOg0KPiA+
ID4+DQo+ID4gPj4+IEZyb206IE1pbmdrYWkgSHUgPE1pbmdrYWkuaHVAZnJlZXNjYWxlLmNvbT4N
Cj4gPiA+Pj4gU3ViamVjdDogW1BBVENIIHYzIDYvN10gbXRkOiBtMjVwODA6IGFkZCBhIHJlYWQg
ZnVuY3Rpb24gdG8gcmVhZA0KPiA+ID4+PiBwYWdlIGJ5IHBhZ2UNCj4gPiA+Pg0KPiA+ID4+IE5B
Sy4NCj4gPiA+Pg0KPiA+ID4+IFdlIHdlbnQgb3ZlciB0aGlzIGJlZm9yZS4NCj4gPiA+DQo+ID4g
PiBZZXMsIEkgYWdyZWUgd2l0aCBEYXZpZCBvbiB0aGlzLiDCoElmIGxhcmdlIHRyYW5zZmVycyBk
b24ndCB3b3JrLA0KPiA+ID4gdGhlbiBpdCBpcyB0aGUgU1BJIG1hc3RlciBkcml2ZXIgdGhhdCBp
cyBidWdneS4NCj4gPg0KPiA+IEJ5IHRoZSB3YXksIGRvZXMgdGhpcyBmaXggeW91ciBwcm9ibGVt
Pw0KPiA+DQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xODQ3NTIvDQo+
IA0KPiBJdCBzaG91bGRuJ3QuIEFGQUlLLCBlU1BJIGlzIFBJTy1vbmx5IGNvbnRyb2xsZXIsIGFu
ZCB0aGUgb3ZlcnJ1biBmaXggaXMgZm9yIHRoZQ0KPiBETUEgbW9kZS4NCj4gDQo+IFRoYW5rcywN
Cj4gDQo+IHAucy4gQnR3LCBpbiBwYXRjaCAzLzcsIGlzX2RtYV9tYXBwZWQgYXJndW1lbnQgb2Yg
ZnNsX2VzcGlfYnVmcygpIGlzIHVubmVlZGVkLg0KPiANCg0KWWVzLCB0aGUgaXNfZG1hX21hcHBl
ZCBpc24ndCBuZWVkZWQsIEknbGwgcmVtb3ZlIGl0Lg0KDQpUaGFua3MsDQpNaW5na2FpDQo=

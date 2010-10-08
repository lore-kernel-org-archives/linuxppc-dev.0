Return-Path: <B21284@freescale.com>
Received: from TX2EHSOBE002.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DA389B70D8
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Oct 2010 17:38:12 +1100 (EST)
Received: from mail7-tx2 (localhost.localdomain [127.0.0.1])	by
	mail7-tx2-R.bigfish.com (Postfix) with ESMTP id 3F4351A286A9	for
	<linuxppc-dev@ozlabs.org>; Fri,  8 Oct 2010 06:38:07 +0000 (UTC)
Received: from TX2EHSMHS005.bigfish.com (unknown [10.9.14.242])	by
	mail7-tx2.bigfish.com (Postfix) with ESMTP id 8A6F34280D7	for
	<linuxppc-dev@ozlabs.org>; Fri,  8 Oct 2010 06:36:39 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	o986acV5004957	for
	<linuxppc-dev@ozlabs.org>; Thu, 7 Oct 2010 23:36:38 -0700 (MST)
Received: from zmy16exm20.fsl.freescale.net (zmy16exm20.ap.freescale.net
	[10.211.3.23])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o986qbem021862	for <linuxppc-dev@ozlabs.org>;
	Fri, 8 Oct 2010 01:52:38 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: RE: [PATCH v3 2/7] spi/mpc8xxx: refactor the common code for SPI/eSPI
	controller
Date: Fri, 8 Oct 2010 14:37:00 +0800
Message-ID: <73839B4A0818E747864426270AC332C3057F6272@zmy16exm20.fsl.freescale.net>
In-Reply-To: <20101001112212.GA17505@oksana.dev.rtsoft.ru>
References: <1285833646-12006-1-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-2-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-3-git-send-email-Mingkai.hu@freescale.com>
	<20101001112212.GA17505@oksana.dev.rtsoft.ru>
From: Hu Mingkai-B21284 <B21284@freescale.com>
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Gala Kumar-B11780 <B11780@freescale.com>,
	linux-mtd@lists.infradead.org, Zang Roy-R61911 <R61911@freescale.com>,
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
IFttYWlsdG86Y2JvdWF0bWFpbHJ1QGdtYWlsLmNvbV0NCj4gU2VudDogRnJpZGF5LCBPY3RvYmVy
IDAxLCAyMDEwIDc6MjIgUE0NCj4gVG86IEh1IE1pbmdrYWktQjIxMjg0DQo+IENjOiBsaW51eHBw
Yy1kZXZAb3psYWJzLm9yZzsgc3BpLWRldmVsLWdlbmVyYWxAbGlzdHMuc291cmNlZm9yZ2UubmV0
OyBsaW51eC0NCj4gbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IEdhbGEgS3VtYXItQjExNzgwOyBa
YW5nIFJveS1SNjE5MTENCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAyLzddIHNwaS9tcGM4eHh4
OiByZWZhY3RvciB0aGUgY29tbW9uIGNvZGUgZm9yIFNQSS9lU1BJDQo+IGNvbnRyb2xsZXINCj4g
DQo+IE9uIFRodSwgU2VwIDMwLCAyMDEwIGF0IDA0OjAwOjQxUE0gKzA4MDAsIE1pbmdrYWkgSHUg
d3JvdGU6DQo+IFsuLi5dDQo+ID4gLXN0YXRpYyB2b2lkIG1wYzh4eHhfc3BpX2NoYW5nZV9tb2Rl
KHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQo+ID4gK3N0YXRpYyB2b2lkIGZzbF9zcGlfY2hhbmdl
X21vZGUoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkNCj4gPiAgew0KPiA+ICAJc3RydWN0IG1wYzh4
eHhfc3BpICptc3BpID0gc3BpX21hc3Rlcl9nZXRfZGV2ZGF0YShzcGktPm1hc3Rlcik7DQo+ID4g
IAlzdHJ1Y3Qgc3BpX21wYzh4eHhfY3MgKmNzID0gc3BpLT5jb250cm9sbGVyX3N0YXRlOw0KPiA+
IC0JX19iZTMyIF9faW9tZW0gKm1vZGUgPSAmbXNwaS0+YmFzZS0+bW9kZTsNCj4gPiArCXN0cnVj
dCBmc2xfc3BpX3JlZyAqcmVnX2Jhc2UgPSAoc3RydWN0IGZzbF9zcGlfcmVnICopbXNwaS0+cmVn
X2Jhc2U7DQo+IA0KPiBObyBuZWVkIGZvciB0aGVzZSB0eXBlIGNhc3RzICh0aGUgc2FtZSBpcyBm
b3IgdGhlIHdob2xlIHBhdGNoKS4NCj4gDQoNCkZpeCBpdC4NCg0KVGhhbmtzLA0KTWluZ2thaQ0K

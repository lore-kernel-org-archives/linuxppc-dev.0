Return-Path: <r61911@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2E4A1B70BD
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 10 Sep 2011 02:00:32 +1000 (EST)
From: Zang Roy-R61911 <r61911@freescale.com>
To: Anton Vorontsov <cbouatmailru@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>
Subject: RE: [PATCH] eSDHC: Access Freescale eSDHC registers by 32-bit
Date: Fri, 9 Sep 2011 16:00:22 +0000
Message-ID: <2239AC579C7D3646A720227A37E026811A2611@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1315569946-21386-1-git-send-email-tie-fei.zang@freescale.com>
	<20110909140701.GA9258@oksana.dev.rtsoft.ru>
In-Reply-To: <20110909140701.GA9258@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	Xu Lei-B33228 <B33228@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW50b24gVm9yb250c292
IFttYWlsdG86Y2JvdWF0bWFpbHJ1QGdtYWlsLmNvbV0NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1i
ZXIgMDksIDIwMTEgMjI6MDcgUE0NCj4gVG86IFphbmcgUm95LVI2MTkxMQ0KPiBDYzogbGludXgt
bW1jQHZnZXIua2VybmVsLm9yZzsgbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IGFrcG1A
bGludXgtDQo+IGZvdW5kYXRpb24ub3JnOyBYdSBMZWktQjMzMjI4OyBLdW1hciBHYWxhDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGVTREhDOiBBY2Nlc3MgRnJlZXNjYWxlIGVTREhDIHJlZ2lzdGVy
cyBieSAzMi1iaXQNCj4gDQo+IE9uIEZyaSwgU2VwIDA5LCAyMDExIGF0IDA4OjA1OjQ2UE0gKzA4
MDAsIFJveSBaYW5nIHdyb3RlOg0KPiA+IEZyb206IFh1IGxlaSA8QjMzMjI4QGZyZWVzY2FsZS5j
b20+DQo+ID4NCj4gPiBGcmVlc2NhbGUgZVNESEMgcmVnaXN0ZXJzIG9ubHkgc3VwcG9ydCAzMi1i
aXQgYWNjZXNzZXMsDQo+ID4gdGhpcyBwYXRjaCBlbnN1cmVzIHRoYXQgYWxsIEZyZWVzY2FsZSBl
U0RIQyByZWdpc3RlciBhY2Nlc3Nlcw0KPiA+IGFyZSAzMi1iaXQuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBYdSBsZWkgPEIzMzIyOEBmcmVlc2NhbGUuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFJveSBaYW5nIDx0aWUtZmVpLnphbmdAZnJlZXNjYWxlLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBLdW1hciBHYWxhIDxnYWxha0BrZXJuZWwuY3Jhc2hpbmcub3JnPg0KPiA+IC0tLQ0KPiANCj4g
VGhlIHBhdGNoIGxvb2tzIE9LLg0KPiANCj4gQWNrZWQtYnk6IEFudG9uIFZvcm9udHNvdiA8Y2Jv
dWF0bWFpbHJ1QGdtYWlsLmNvbT4NClRoYW5rcy4NCkFkZCBDaHJpcy4NCg0KPiANCj4gWy4uLl0N
Cj4gPiArc3RhdGljIHU4IGVzZGhjX3JlYWRiKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCBpbnQg
cmVnKQ0KPiA+ICt7DQo+ID4gKwlpbnQgYmFzZSA9IHJlZyAmIH4weDM7DQo+ID4gKwlpbnQgc2hp
ZnQgPSAocmVnICYgMHgzKSAqIDg7DQo+ID4gKwl1OCByZXQgPSAoaW5fYmUzMihob3N0LT5pb2Fk
ZHIgKyBiYXNlKSA+PiBzaGlmdCkgJiAweGZmOw0KPiA+ICAJcmV0dXJuIHJldDsNCj4gPiAgfQ0K
PiANCj4gVGhvdWdoLCBJIHdvbmRlciBpZiB3ZSBjb3VsZCBjaGFuZ2Ugc2RoY2lfYmUzMmJzX3Jl
YWR7Yix3fSwgaW5zdGVhZA0KPiBvZiBtYWtpbmcgdGhpcyBsb2NhbCB0byBlU0RIQy4NCj4gDQo+
IFRoZSB0aGluZyBpczogc2RoY2lfYmUzMmJzX3dyaXRlYigpIGlzIHVzaW5nIGNscnNldGJpdHNf
YmUzMiwNCj4gc28gdGhlIHdyaXRlIHZhcmlhbnQgYWxyZWFkeSB1c2VzIDMyLWJpdCBhY2Nlc3Nv
cnMsIHNvIG5vdGhpbmcgc2hvdWxkDQo+IGJyZWFrIGlmIHdlIHN3aXRjaCBzZGhjaV9iZTMyYnNf
cmVhZGIoKSB0byBpbl9iZTMyKCkuDQo+IA0KPiBCdXQgbWF5YmUgaXQncyBzYWZlciBpZiB3ZSBk
byB0aGlzIGluIGEgc2VwYXJhdGUgcGF0Y2gsIHNvIHRoYXQgaXQNCj4gY291bGQgYmUgZWFzaWx5
IHJldmVydGVkIHdpdGhvdXQgaW1wYWN0aW5nIGVTREhDIGlmIHNvbWV0aGluZyBhY3R1YWxseQ0K
PiBicmVha3MuDQo+IA0KPiBZb3UgZGVjaWRlLiA6LSkNCj4gDQo+IFRoYW5rcyENClRoZSBzdWdn
ZXN0aW9uIG1ha2VzIHNlbnNlLiBJJ2QgbGlrZSB0byBkbyB0aGlzIGluIGEgc2VwYXJhdGUgcGF0
Y2ggYWZ0ZXIgdGhpcyBwYXRjaCBhcHBsaWVkLg0KVGhhbmtzLg0KUm95DQo=

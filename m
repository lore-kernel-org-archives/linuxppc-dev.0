Return-Path: <R65777@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0185.outbound.messaging.microsoft.com [213.199.154.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0E7352C017C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Sep 2013 04:04:43 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 5/6 v5] kvm: booke: clear host tlb reference flag on
 guest tlb invalidation
Date: Fri, 20 Sep 2013 18:04:32 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D0717AEA1@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1379570566-3715-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1379570566-3715-6-git-send-email-Bharat.Bhushan@freescale.com>
 <1379624878.16231.3.camel@aoeu.buserror.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D07179BBE@039-SN2MPN1-011.039d.mgd.msft.net>
 <1379693889.16231.11.camel@aoeu.buserror.net>
In-Reply-To: <1379693889.16231.11.camel@aoeu.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMjAsIDIwMTMgOTo0OCBQTQ0KPiBUbzogQmh1
c2hhbiBCaGFyYXQtUjY1Nzc3DQo+IENjOiBXb29kIFNjb3R0LUIwNzQyMTsgYmVuaEBrZXJuZWwu
Y3Jhc2hpbmcub3JnOyBhZ3JhZkBzdXNlLmRlOw0KPiBwYXVsdXNAc2FtYmEub3JnOyBrdm1Admdl
ci5rZXJuZWwub3JnOyBrdm0tcHBjQHZnZXIua2VybmVsLm9yZzsgbGludXhwcGMtDQo+IGRldkBs
aXN0cy5vemxhYnMub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNS82IHY1XSBrdm06IGJvb2tl
OiBjbGVhciBob3N0IHRsYiByZWZlcmVuY2UgZmxhZyBvbiBndWVzdA0KPiB0bGIgaW52YWxpZGF0
aW9uDQo+IA0KPiBPbiBUaHUsIDIwMTMtMDktMTkgYXQgMjM6MTkgLTA1MDAsIEJodXNoYW4gQmhh
cmF0LVI2NTc3NyB3cm90ZToNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPiA+IEZyb206IFdvb2QgU2NvdHQtQjA3NDIxDQo+ID4gPiBTZW50OiBGcmlkYXksIFNlcHRl
bWJlciAyMCwgMjAxMyAyOjM4IEFNDQo+ID4gPiBUbzogQmh1c2hhbiBCaGFyYXQtUjY1Nzc3DQo+
ID4gPiBDYzogYmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnOyBhZ3JhZkBzdXNlLmRlOyBwYXVsdXNA
c2FtYmEub3JnOw0KPiA+ID4ga3ZtQHZnZXIua2VybmVsLm9yZzsga3ZtLXBwY0B2Z2VyLmtlcm5l
bC5vcmc7DQo+ID4gPiBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsgQmh1c2hhbiBCaGFy
YXQtUjY1Nzc3DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDUvNiB2NV0ga3ZtOiBib29rZTog
Y2xlYXIgaG9zdCB0bGIgcmVmZXJlbmNlDQo+ID4gPiBmbGFnIG9uIGd1ZXN0IHRsYiBpbnZhbGlk
YXRpb24NCj4gPiA+DQo+ID4gPiBUaGlzIGJyZWFrcyB3aGVuIHlvdSBoYXZlIGJvdGggRTUwMF9U
TEJfQklUTUFQIGFuZCBFNTAwX1RMQl9UTEIwIHNldC4NCj4gPg0KPiA+IEkgZG8gbm90IHNlZSBh
bnkgY2FzZSB3aGVyZSB3ZSBzZXQgYm90aCBFNTAwX1RMQl9CSVRNQVAgYW5kDQo+ID4gRTUwMF9U
TEJfVExCMC4NCj4gDQo+IFRoaXMgd291bGQgaGFwcGVuIGlmIHlvdSBoYXZlIGEgZ3Vlc3QgVExC
MSBlbnRyeSB0aGF0IGlzIGJhY2tlZCBieSBzb21lIDRLIHBhZ2VzDQo+IGFuZCBzb21lIGxhcmdl
ciBwYWdlcyAoZS5nLiBpZiB0aGUgZ3Vlc3QgbWFwcyBDQ1NSIHdpdGggb25lIGJpZw0KPiBUTEIx
IGFuZCB0aGVyZSBhcmUgdmFyeWluZyBJL08gcGFzc3Rocm91Z2ggcmVnaW9ucyBtYXBwZWQpLiAg
SXQncyBub3QgY29tbW9uLA0KPiBidXQgaXQncyBwb3NzaWJsZS4NCg0KQWdyZWUNCg0KPiANCj4g
PiAgQWxzbyB3ZSBoYXZlIG5vdCBvcHRpbWl6ZWQgdGhhdCB5ZXQgKGtlZXBpbmcgdHJhY2sgb2Yg
bXVsdGlwbGUgc2hhZG93DQo+ID4gVExCMCBlbnRyaWVzIGZvciBvbmUgZ3Vlc3QgVExCMSBlbnRy
eSkNCj4gDQo+IFRoaXMgaXMgYWJvdXQgY29ycmVjdG5lc3MsIG5vdCBvcHRpbWl6YXRpb24uDQo+
IA0KPiA+IFdlIHVzZXMgdGhlc2UgYml0IGZsYWdzIG9ubHkgZm9yIFRMQjEgYW5kIGlmIHNpemUg
b2Ygc3RsYmUgaXMgNEsgdGhlbg0KPiA+IHdlIHNldCBFNTAwX1RMQl9UTEIwICBvdGhlcndpc2Ug
d2Ugc2V0IEU1MDBfVExCX0JJVE1BUC4gQWx0aG91Z2ggSQ0KPiA+IHRoaW5rIHRoYXQgRTUwMF9U
TEJfQklUTUFQIHNob3VsZCBiZSBzZXQgb25seSBpZiBzdGxiZSBzaXplIGlzIGxlc3MNCj4gPiB0
aGFuIGd0bGJlIHNpemUuDQo+IA0KPiBXaHk/ICBFdmVuIGlmIHRoZXJlJ3Mgb25seSBvbmUgYml0
IHNldCBpbiB0aGUgbWFwLCB3ZSBuZWVkIGl0IHRvIGtlZXAgdHJhY2sgb2YNCj4gd2hpY2ggZW50
cnkgd2FzIHVzZWQuDQoNCklmIHRoZXJlIGlzIG9uZSBlbnRyeSB0aGVuIHdpbGwgbm90IHRoaXMg
YmUgc2ltcGxlL2Zhc3RlciB0byBub3QgbG9va3VwIGJpdG1hcCBhbmQgZ3Vlc3QtPmhvc3QgYXJy
YXk/DQpBIGZsYWcgaW5kaWNhdGUgaXQgaXMgMToxIG1hcCBhbmQgdGhpcyBpcyBwaHlzaWNhbCBh
ZGRyZXNzLg0KDQotQmhhcmF0DQoNCj4gDQo+IC1TY290dA0KPiANCg0K

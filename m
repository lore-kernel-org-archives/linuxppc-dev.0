Return-Path: <R65777@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0248.outbound.messaging.microsoft.com [213.199.154.248])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CA2A02C0100
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Sep 2013 04:11:56 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 5/6 v5] kvm: booke: clear host tlb reference flag on
 guest tlb invalidation
Date: Fri, 20 Sep 2013 18:11:46 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D0717AF10@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1379570566-3715-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1379570566-3715-6-git-send-email-Bharat.Bhushan@freescale.com>
 <1379624878.16231.3.camel@aoeu.buserror.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D07179BBE@039-SN2MPN1-011.039d.mgd.msft.net>
 <1379693889.16231.11.camel@aoeu.buserror.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0717AEA1@039-SN2MPN1-011.039d.mgd.msft.net>
 <1379700490.16231.19.camel@aoeu.buserror.net>
In-Reply-To: <1379700490.16231.19.camel@aoeu.buserror.net>
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
MjENCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMjAsIDIwMTMgMTE6MzggUE0NCj4gVG86IEJo
dXNoYW4gQmhhcmF0LVI2NTc3Nw0KPiBDYzogV29vZCBTY290dC1CMDc0MjE7IGJlbmhAa2VybmVs
LmNyYXNoaW5nLm9yZzsgYWdyYWZAc3VzZS5kZTsNCj4gcGF1bHVzQHNhbWJhLm9yZzsga3ZtQHZn
ZXIua2VybmVsLm9yZzsga3ZtLXBwY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4cHBjLQ0KPiBkZXZA
bGlzdHMub3psYWJzLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDUvNiB2NV0ga3ZtOiBib29r
ZTogY2xlYXIgaG9zdCB0bGIgcmVmZXJlbmNlIGZsYWcgb24gZ3Vlc3QNCj4gdGxiIGludmFsaWRh
dGlvbg0KPiANCj4gT24gRnJpLCAyMDEzLTA5LTIwIGF0IDEzOjA0IC0wNTAwLCBCaHVzaGFuIEJo
YXJhdC1SNjU3Nzcgd3JvdGU6DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4gPiBGcm9tOiBXb29kIFNjb3R0LUIwNzQyMQ0KPiA+ID4gU2VudDogRnJpZGF5LCBTZXB0
ZW1iZXIgMjAsIDIwMTMgOTo0OCBQTQ0KPiA+ID4gVG86IEJodXNoYW4gQmhhcmF0LVI2NTc3Nw0K
PiA+ID4gQ2M6IFdvb2QgU2NvdHQtQjA3NDIxOyBiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc7IGFn
cmFmQHN1c2UuZGU7DQo+ID4gPiBwYXVsdXNAc2FtYmEub3JnOyBrdm1Admdlci5rZXJuZWwub3Jn
OyBrdm0tcHBjQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IGxpbnV4cHBjLSBkZXZAbGlzdHMub3ps
YWJzLm9yZw0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCA1LzYgdjVdIGt2bTogYm9va2U6IGNs
ZWFyIGhvc3QgdGxiIHJlZmVyZW5jZQ0KPiA+ID4gZmxhZyBvbiBndWVzdCB0bGIgaW52YWxpZGF0
aW9uDQo+ID4gPg0KPiA+ID4gT24gVGh1LCAyMDEzLTA5LTE5IGF0IDIzOjE5IC0wNTAwLCBCaHVz
aGFuIEJoYXJhdC1SNjU3Nzcgd3JvdGU6DQo+ID4gPiA+IFdlIHVzZXMgdGhlc2UgYml0IGZsYWdz
IG9ubHkgZm9yIFRMQjEgYW5kIGlmIHNpemUgb2Ygc3RsYmUgaXMgNEsNCj4gPiA+ID4gdGhlbiB3
ZSBzZXQgRTUwMF9UTEJfVExCMCAgb3RoZXJ3aXNlIHdlIHNldCBFNTAwX1RMQl9CSVRNQVAuDQo+
ID4gPiA+IEFsdGhvdWdoIEkgdGhpbmsgdGhhdCBFNTAwX1RMQl9CSVRNQVAgc2hvdWxkIGJlIHNl
dCBvbmx5IGlmIHN0bGJlDQo+ID4gPiA+IHNpemUgaXMgbGVzcyB0aGFuIGd0bGJlIHNpemUuDQo+
ID4gPg0KPiA+ID4gV2h5PyAgRXZlbiBpZiB0aGVyZSdzIG9ubHkgb25lIGJpdCBzZXQgaW4gdGhl
IG1hcCwgd2UgbmVlZCBpdCB0bw0KPiA+ID4ga2VlcCB0cmFjayBvZiB3aGljaCBlbnRyeSB3YXMg
dXNlZC4NCj4gPg0KPiA+IElmIHRoZXJlIGlzIG9uZSBlbnRyeSB0aGVuIHdpbGwgbm90IHRoaXMg
YmUgc2ltcGxlL2Zhc3RlciB0byBub3QgbG9va3VwIGJpdG1hcA0KPiBhbmQgZ3Vlc3QtPmhvc3Qg
YXJyYXk/DQo+ID4gQSBmbGFnIGluZGljYXRlIGl0IGlzIDE6MSBtYXAgYW5kIHRoaXMgaXMgcGh5
c2ljYWwgYWRkcmVzcy4NCj4gDQo+IFRoZSBkaWZmZXJlbmNlIHdvdWxkIGJlIG5lZ2xpZ2libGUs
IGFuZCB5b3UnZCBoYXZlIGFkZGVkIG92ZXJoZWFkIChib3RoIHJ1bnRpbWUNCj4gYW5kIGNvbXBs
ZXhpdHkpIG9mIG1ha2luZyB0aGlzIGEgc3BlY2lhbCBjYXNlLg0KDQpNYXkgYmUgeW91IGFyZSBy
aWdodCAsIEkgd2lsbCBzZWUgaWYgSSBjYW4gZ2l2ZSBhIHRyeSA6KQ0KQlRXIEkgaGF2ZSBhbHJl
YWR5IHNlbnQgdjYgb2YgdGhpcyBwYXRjaC4NCg0KLUJoYXJhdA0KDQo+IA0KPiAtU2NvdHQNCj4g
DQoNCg==

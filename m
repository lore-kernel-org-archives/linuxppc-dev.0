Return-Path: <B02008@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 86BA81007D4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 21:41:52 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [RFC PATCH 03/17] KVM: PPC64: booke: Add EPCR support in sregs
Date: Wed, 27 Jun 2012 11:41:42 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF151D68@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-4-git-send-email-mihai.caraman@freescale.com>
 <4FEA3907.8080500@freescale.com>
In-Reply-To: <4FEA3907.8080500@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXb29kIFNjb3R0LUIwNzQyMQ0K
PiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMjcsIDIwMTIgMTozNSBBTQ0KPiBUbzogQ2FyYW1hbiBN
aWhhaSBDbGF1ZGl1LUIwMjAwOA0KPiBDYzoga3ZtLXBwY0B2Z2VyLmtlcm5lbC5vcmc7IGt2bUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4cHBjLQ0KPiBkZXZAbGlzdHMub3psYWJzLm9yZzsgcWVtdS1w
cGNAbm9uZ251Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAwMy8xN10gS1ZNOiBQUEM2
NDogYm9va2U6IEFkZCBFUENSIHN1cHBvcnQgaW4NCj4gc3JlZ3MNCj4gDQo+IE9uIDA2LzI1LzIw
MTIgMDc6MjYgQU0sIE1paGFpIENhcmFtYW4gd3JvdGU6DQo+ID4gQWRkIEtWTV9TUkVHU19FXzY0
IGZlYXR1cmUgYW5kIEVQQ1Igc3ByIHN1cHBvcnQgaW4gZ2V0L3NldCBzcmVncyBmb3INCj4gPiA2
NC1iaXQgaG9zdHMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaWhhaSBDYXJhbWFuIDxtaWhh
aS5jYXJhbWFuQGZyZWVzY2FsZS5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvcG93ZXJwYy9rdm0v
Ym9va2UuYyB8ICAgMTQgKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlcyBjaGFuZ2VkLCAxNCBp
bnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gv
cG93ZXJwYy9rdm0vYm9va2UuYyBiL2FyY2gvcG93ZXJwYy9rdm0vYm9va2UuYyBpbmRleA0KPiA+
IGY5ZmEyNjAuLmQxNWM0YjUgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9wb3dlcnBjL2t2bS9ib29r
ZS5jDQo+ID4gKysrIGIvYXJjaC9wb3dlcnBjL2t2bS9ib29rZS5jDQo+ID4gQEAgLTEwNTIsNiAr
MTA1Miw5IEBAIHN0YXRpYyB2b2lkIGdldF9zcmVnc19iYXNlKHN0cnVjdCBrdm1fdmNwdSAqdmNw
dSwNCj4gPiAgCXU2NCB0YiA9IGdldF90YigpOw0KPiA+DQo+ID4gIAlzcmVncy0+dS5lLmZlYXR1
cmVzIHw9IEtWTV9TUkVHU19FX0JBU0U7DQo+ID4gKyNpZmRlZiBDT05GSUdfNjRCSVQNCj4gPiAr
CXNyZWdzLT51LmUuZmVhdHVyZXMgfD0gS1ZNX1NSRUdTX0VfNjQ7MCAjZW5kaWYNCj4gPg0KPiA+
ICAJc3JlZ3MtPnUuZS5jc3JyMCA9IHZjcHUtPmFyY2guY3NycjA7DQo+ID4gIAlzcmVncy0+dS5l
LmNzcnIxID0gdmNwdS0+YXJjaC5jc3JyMTsgQEAgLTEwNjMsNiArMTA2Niw5IEBAIHN0YXRpYw0K
PiA+IHZvaWQgZ2V0X3NyZWdzX2Jhc2Uoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LA0KPiA+ICAJc3Jl
Z3MtPnUuZS5kZWMgPSBrdm1wcGNfZ2V0X2RlYyh2Y3B1LCB0Yik7DQo+ID4gIAlzcmVncy0+dS5l
LnRiID0gdGI7DQo+ID4gIAlzcmVncy0+dS5lLnZyc2F2ZSA9IHZjcHUtPmFyY2gudnJzYXZlOw0K
PiA+ICsjaWZkZWYgQ09ORklHXzY0QklUDQo+ID4gKwlzcmVncy0+dS5lLmVwY3IgPSB2Y3B1LT5h
cmNoLmVwY3I7DQo+ID4gKyNlbmRpZg0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIGludCBzZXRf
c3JlZ3NfYmFzZShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIEBAIC0xMDcxLDYgKzEwNzcsMTENCj4g
PiBAQCBzdGF0aWMgaW50IHNldF9zcmVnc19iYXNlKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwNCj4g
PiAgCWlmICghKHNyZWdzLT51LmUuZmVhdHVyZXMgJiBLVk1fU1JFR1NfRV9CQVNFKSkNCj4gPiAg
CQlyZXR1cm4gMDsNCj4gPg0KPiA+ICsjaWZkZWYgQ09ORklHXzY0QklUDQo+ID4gKwlpZiAoIShz
cmVncy0+dS5lLmZlYXR1cmVzICYgS1ZNX1NSRUdTX0VfNjQpKQ0KPiA+ICsJCXJldHVybiAwOw0K
PiA+ICsjZW5kaWYNCj4gDQo+IFRoaXMgbWVhbnMgdGhhdCBhIFFFTVUgdGFyZ2V0aW5nIGEgMzIt
Yml0IGd1ZXN0IHdvbid0IGJlIGFibGUgdG8gc2V0IGFueQ0KPiBzcGVjaWFsIHJlZ2lzdGVycywg
aWYgaXQgc2V0cyBmZWF0dXJlIGJpdHMgbWFudWFsbHkgcmF0aGVyIHRoYW4gZ2V0dGluZw0KPiB0
aGVtIGZyb20gR0VUX1NSRUdTLg0KDQpJIGhhZCBzb21lIGNvbmNlcm5zIGFib3V0IGhpcy4gSSBv
bmx5IGNoZWNrIHFlbXUgcHBjIGNvZGUgd2hpY2ggdXNlcyBnZXQvc2V0DQphcHByb2FjaCBhbmQg
SSBmb2xsb3dlZCB0aGUgQkFTRSBtb2RlbC4gTm93IEkgc2VlIHRoYXQgcWVtdSB4ODYgc2V0IHRo
ZW0gbWFudWFsbHkgOigNCldoeSBkbyB3ZSBjYXJlIGlmIHRoZSBjYWxsZXIgc2V0IG9yIG5vdCBC
QVNFPw0KDQotTWlrZQ0K

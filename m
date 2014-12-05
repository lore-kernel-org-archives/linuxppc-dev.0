Return-Path: <David.Laight@ACULAB.COM>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 564401A0BBB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 21:28:10 +1100 (AEDT)
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 2F2D0140100
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2014 21:28:08 +1100 (AEDT)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 09433-04 for <linuxppc-dev@ozlabs.org>;
 Fri,  5 Dec 2014 10:27:57 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Michael Ellerman' <mpe@ellerman.id.au>, "linuxppc-dev@ozlabs.org"
 <linuxppc-dev@ozlabs.org>
Subject: RE: [PATCH] powerpc/kernel: Make syscall_exit a local label
Date: Fri, 5 Dec 2014 10:27:22 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CA03452@AcuExch.aculab.com>
References: <1417774619-30858-1-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1417774619-30858-1-git-send-email-mpe@ellerman.id.au>
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

RnJvbTogTWljaGFlbCBFbGxlcm1hbg0KPiBDdXJyZW50bHkgd2hlbiB3ZSBiYWNrIHRyYWNlIHNv
bWV0aGluZyB0aGF0IGlzIGluIGEgc3lzY2FsbCB3ZSBzZWUNCj4gc29tZXRoaW5nIGxpa2UgdGhp
czoNCj4gDQo+IFtjMDAwMDAwMDAwMDAwMDAwXSBbYzAwMDAwMDAwMDAwMDAwMF0gU3lTX3JlYWQr
MHg2Yy8weDExMA0KPiBbYzAwMDAwMDAwMDAwMDAwMF0gW2MwMDAwMDAwMDAwMDAwMDBdIHN5c2Nh
bGxfZXhpdCsweDAvMHg5OA0KPiANCj4gQWx0aG91Z2ggaXQncyBlbnRpcmVseSBjb3JyZWN0LCBz
ZWVpbmcgc3lzY2FsbF9leGl0IGF0IHRoZSBib3R0b20gY2FuIGJlDQo+IGNvbmZ1c2luZyAtIHdl
IHdlcmUgZXhpdGluZyBmcm9tIGEgc3lzY2FsbCBhbmQgdGhlbiBjYWxsZWQgU3lTX3JlYWQoKSA/
DQo+IA0KPiBJZiB3ZSBpbnN0ZWFkIGNoYW5nZSBzeXNjYWxsX2V4aXQgdG8gYmUgYSBsb2NhbCBs
YWJlbCB3ZSBnZXQgc29tZXRoaW5nDQo+IG1vcmUgaW50dWl0aXZlOg0KPiANCj4gW2MwMDAwMDAx
ZmE0NmZkZTBdIFtjMDAwMDAwMDAwMjY3MTljXSBTeVNfcmVhZCsweDZjLzB4MTEwDQo+IFtjMDAw
MDAwMWZhNDZmZTMwXSBbYzAwMDAwMDAwMDAwOTI2NF0gc3lzdGVtX2NhbGwrMHgzOC8weGQwDQo+
IA0KPiBpZS4gd2Ugd2VyZSBoYW5kbGluZyBhIHN5c3RlbSBjYWxsLCBhbmQgaXQgd2FzIFN5U19y
ZWFkKCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEVsbGVybWFuIDxtcGVAZWxsZXJt
YW4uaWQuYXU+DQo+IC0tLQ0KPiAgYXJjaC9wb3dlcnBjL2tlcm5lbC9lbnRyeV82NC5TIHwgMTgg
KysrKysrKysrLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA5
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9rZXJuZWwvZW50
cnlfNjQuUyBiL2FyY2gvcG93ZXJwYy9rZXJuZWwvZW50cnlfNjQuUw0KPiBpbmRleCAwOTA1Yzhk
YTkwZjEuLmQ4ODI4ZTUwZGJlZiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9wb3dlcnBjL2tlcm5lbC9l
bnRyeV82NC5TDQo+ICsrKyBiL2FyY2gvcG93ZXJwYy9rZXJuZWwvZW50cnlfNjQuUw0KPiBAQCAt
MTc4LDcgKzE3OCw3IEBAIHN5c3RlbV9jYWxsOgkJCS8qIGxhYmVsIHRoaXMgc28gc3RhY2sgdHJh
Y2VzIGxvb2sgc2FuZSAqLw0KPiAgCW10Y3RyICAgcjEyDQo+ICAJYmN0cmwJCQkvKiBDYWxsIGhh
bmRsZXIgKi8NCg0KV2h5IG5vdCBhZGQgYSAnbm9wJyBoZXJlIGluc3RlYWQ/DQoNCj4gLXN5c2Nh
bGxfZXhpdDoNCj4gKy5Mc3lzY2FsbF9leGl0Og0KPiAgCXN0ZAlyMyxSRVNVTFQocjEpDQo+ICAj
aWZkZWYgU0hPV19TWVNDQUxMUw0KPiAgCWJsCWRvX3Nob3dfc3lzY2FsbF9leGl0DQo+IEBAIC0y
NzAsNyArMjcwLDcgQEAgc3lzY2FsbF9kb3RyYWNlOg0KLi4uDQoNCglEYXZpZA0KDQo=

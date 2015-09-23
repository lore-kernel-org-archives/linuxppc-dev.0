Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0140.outbound.protection.outlook.com [157.56.110.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AFE6D1A0329
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 12:01:37 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "lauraa@codeaurora.org" <lauraa@codeaurora.org>, Xiaobo Xie
 <X.Xie@freescale.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 Li Leo <LeoLi@freescale.com>, "paulus@samba.org" <paulus@samba.org>
Subject: RE: [PATCH v10 5/5] QE: Move QE from arch/powerpc to drivers/soc
Date: Wed, 23 Sep 2015 02:01:26 +0000
Message-ID: <SN1PR0301MB15500DC6A4EC68DD8D22CBC29B440@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1442560521-19354-1-git-send-email-qiang.zhao@freescale.com>
 <1442560521-19354-5-git-send-email-qiang.zhao@freescale.com>
 <20150921225611.GC12709@home.buserror.net>
 <SN1PR0301MB15505DD2F1230357BD91C15F9B450@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1442939995.19102.246.camel@freescale.com>
In-Reply-To: <1442939995.19102.246.camel@freescale.com>
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

T24gV2VuLCBTZXAgMjMsIDIwMTUgYXQgMTI6NDAgQU0gKzA4MDAsIFdvb2QgU2NvdHQtQjA3NDIx
IHdyb3RlOg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFdvb2QgU2Nv
dHQtQjA3NDIxDQo+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDIzLCAyMDE1IDEyOjQwIEFN
DQo+IFRvOiBaaGFvIFFpYW5nLUI0NTQ3NQ0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7DQo+IGxhdXJhYUBjb2RlYXVyb3Jh
Lm9yZzsgWGllIFhpYW9iby1SNjMwNjE7IGJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZzsgTGkNCj4g
WWFuZy1MZW8tUjU4NDcyOyBwYXVsdXNAc2FtYmEub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djEwIDUvNV0gUUU6IE1vdmUgUUUgZnJvbSBhcmNoL3Bvd2VycGMgdG8gZHJpdmVycy9zb2MNCj4g
DQo+IE9uIFR1ZSwgMjAxNS0wOS0yMiBhdCAwMzoyNCAtMDUwMCwgWmhhbyBRaWFuZy1CNDU0NzUg
d3JvdGU6DQo+ID4gT24gVHVlLCBTZXAgMjIsIDIwMTUgYXQgMDY6NTYgQU0gKzA4MDAsIFdvb2Qg
U2NvdHQtQjA3NDIxIHdyb3RlOg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+ID4gRnJvbTogV29vZCBTY290dC1CMDc0MjENCj4gPiA+IFNlbnQ6IFR1ZXNkYXksIFNl
cHRlbWJlciAyMiwgMjAxNSA2OjU2IEFNDQo+ID4gPiBUbzogWmhhbyBRaWFuZy1CNDU0NzUNCj4g
PiA+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eHBwYy1kZXZAbGlzdHMu
b3psYWJzLm9yZzsNCj4gPiA+IGxhdXJhYUBjb2RlYXVyb3JhLm9yZzsgWGllIFhpYW9iby1SNjMw
NjE7IGJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZzsNCj4gPiA+IExpIFlhbmctTGVvLVI1ODQ3Mjsg
cGF1bHVzQHNhbWJhLm9yZw0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTAgNS81XSBRRTog
TW92ZSBRRSBmcm9tIGFyY2gvcG93ZXJwYyB0bw0KPiA+ID4gZHJpdmVycy9zb2MNCj4gPiA+DQo+
ID4gPiBPbiBGcmksIFNlcCAxOCwgMjAxNSBhdCAwMzoxNToyMVBNICswODAwLCBaaGFvIFFpYW5n
IHdyb3RlOg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvZnNsL3FlL0tjb25maWcN
Cj4gPiA+ID4gYi9kcml2ZXJzL3NvYy9mc2wvcWUvS2NvbmZpZyBuZXcgZmlsZSBtb2RlIDEwMDY0
NCBpbmRleA0KPiA+ID4gPiAwMDAwMDAwLi4zMDEyNTcxDQo+ID4gPiA+IC0tLSAvZGV2L251bGwN
Cj4gPiA+ID4gKysrIGIvZHJpdmVycy9zb2MvZnNsL3FlL0tjb25maWcNCj4gPiA+ID4gQEAgLTAs
MCArMSwzMyBAQA0KPiA+ID4gPiArIGhlbHANCj4gPiA+ID4gKyAgIFRoZSBRVUlDQyBFbmdpbmUg
KFFFKSBpcyBhIG5ldyBnZW5lcmF0aW9uIG9mIGNvbW11bmljYXRpb25zDQo+ID4gPiA+ICsgICBj
b3Byb2Nlc3NvcnMgb24gRnJlZXNjYWxlIGVtYmVkZGVkIENQVXMgKGFraW4gdG8gQ1BNIGluIG9s
ZGVyDQo+ID4gPiBjaGlwcykuDQo+ID4gPiA+ICsgICBTZWxlY3RpbmcgdGhpcyBvcHRpb24gbWVh
bnMgdGhhdCB5b3Ugd2lzaCB0byBidWlsZCBhIGtlcm5lbA0KPiA+ID4gPiArICAgZm9yIGEgbWFj
aGluZSB3aXRoIGEgUUUgY29wcm9jZXNzb3IuDQo+ID4gPiA+ICsNCj4gPiA+ID4gK2NvbmZpZyBV
Q0NfU0xPVw0KPiA+ID4gPiArIGJvb2wNCj4gPiA+ID4gKyBkZWZhdWx0IHkgaWYgU0VSSUFMX1FF
DQo+ID4gPiA+ICsgaGVscA0KPiA+ID4gPiArICAgVGhpcyBvcHRpb24gcHJvdmlkZXMgcWVfbGli
IHN1cHBvcnQgdG8gVUNDIHNsb3cNCj4gPiA+ID4gKyAgIHByb3RvY29sczogVUFSVCwgQklTWU5D
LCBRTUMNCj4gPiA+ID4gKw0KPiA+ID4gPiArY29uZmlnIFVDQ19GQVNUDQo+ID4gPiA+ICsgYm9v
bA0KPiA+ID4gPiArIGRlZmF1bHQgeSBpZiBVQ0NfR0VUSA0KPiA+ID4gPiArIGhlbHANCj4gPiA+
ID4gKyAgIFRoaXMgb3B0aW9uIHByb3ZpZGVzIHFlX2xpYiBzdXBwb3J0IHRvIFVDQyBmYXN0DQo+
ID4gPiA+ICsgICBwcm90b2NvbHM6IEhETEMsIEV0aGVybmV0LCBBVE0sIHRyYW5zcGFyZW50DQo+
ID4gPg0KPiA+ID4gV2hhdCBkb2VzICJxZV9saWIiIG1lYW4gdG8gdGhlIGVuZCB1c2VyLCBvciB0
byBhbnlvbmUgYWZ0ZXIgdGhlIGNvZGUNCj4gPiA+IGlzIG1vdmVkIHRvIGRyaXZlcnMvc29jL2Zz
bC9xZT8NCj4gPg0KPiA+IFFlX2xpYiBoYXMgZnVuY3Rpb25zIGNvbmZpZ3VyaW5nIHVjYywgbWFu
YWdpbmcgbXVyYW0gYW5kIHNvIG9uLg0KPiA+IEl0IGlzIHRoZSBjb21tb24gZnVuY3Rpb25zIHRv
IGVuZCB1c2VyLg0KPiANCj4gSXQncyBub3QgZ29pbmcgdG8gYmUgY2FsbGVkIHFlX2xpYiBhbnlt
b3JlLiAgcy9wcm92aWRlcyBxZV9saWIgc3VwcG9ydCB0bw0KPiBVQ0MgL3Byb3ZpZGVzIHN1cHBv
cnQgZm9yIFFFIFVDQy8NCg0KT2sNCi1aaGFvDQo=

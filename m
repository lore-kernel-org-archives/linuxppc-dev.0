Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0114.outbound.protection.outlook.com [157.56.110.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A5E581A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 15:28:54 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "lauraa@codeaurora.org" <lauraa@codeaurora.org>, Xiaobo Xie
 <X.Xie@freescale.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 Li Leo <LeoLi@freescale.com>, "paulus@samba.org" <paulus@samba.org>
Subject: RE: [PATCH v10 3/5] CPM/QE: use genalloc to manage CPM/QE muram
Date: Wed, 23 Sep 2015 05:28:46 +0000
Message-ID: <SN1PR0301MB155040D7F785F40B2B07E6219B440@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1442560521-19354-1-git-send-email-qiang.zhao@freescale.com>
 <1442560521-19354-3-git-send-email-qiang.zhao@freescale.com>
 <20150921224720.GA12709@home.buserror.net>
 <SN1PR0301MB1550726A1D45051888E35EB59B450@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1442967567.19102.318.camel@freescale.com>
 <SN1PR0301MB1550F7AC5D2885AD97B30CE59B440@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1442980978.19102.321.camel@freescale.com>
In-Reply-To: <1442980978.19102.321.camel@freescale.com>
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

T24gV2VuLCBTZXAgMjMsIDIwMTUgYXQgMTI6MDMgQU0gKzA4MDAsIFdvb2QgU2NvdHQtQjA3NDIx
IHdyb3RlOg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFdvb2QgU2Nv
dHQtQjA3NDIxDQo+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDIzLCAyMDE1IDEyOjAzIFBN
DQo+IFRvOiBaaGFvIFFpYW5nLUI0NTQ3NQ0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7DQo+IGxhdXJhYUBjb2RlYXVyb3Jh
Lm9yZzsgWGllIFhpYW9iby1SNjMwNjE7IGJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZzsgTGkNCj4g
WWFuZy1MZW8tUjU4NDcyOyBwYXVsdXNAc2FtYmEub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djEwIDMvNV0gQ1BNL1FFOiB1c2UgZ2VuYWxsb2MgdG8gbWFuYWdlIENQTS9RRSBtdXJhbQ0KPiAN
Cj4gT24gVHVlLCAyMDE1LTA5LTIyIGF0IDIxOjIwIC0wNTAwLCBaaGFvIFFpYW5nLUI0NTQ3NSB3
cm90ZToNCj4gPiBPbiBXZW4sIFNlcCAyMywgMjAxNSBhdCA4OjE5IEFNICswODAwLCBXb29kIFNj
b3R0LUIwNzQyMSB3cm90ZToNCj4gPg0KPiA+ID4gPiA+ID4gIHsNCj4gPiA+ID4gPiA+IC0gaW50
IHJldDsNCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICsgdW5zaWduZWQgbG9uZyBzdGFydDsN
Cj4gPiA+ID4gPiA+ICAgdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPiA+ID4gPiA+ICsgdW5zaWdu
ZWQgbG9uZyBzaXplX2FsbG9jID0gc2l6ZTsgc3RydWN0IG11cmFtX2Jsb2NrICplbnRyeTsNCj4g
PiA+ID4gPiA+ICsgaW50IGVuZF9iaXQ7IGludCBvcmRlciA9IG11cmFtX3Bvb2wtPm1pbl9hbGxv
Y19vcmRlcjsNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAgIHNwaW5fbG9ja19pcnFzYXZlKCZj
cG1fbXVyYW1fbG9jaywgZmxhZ3MpOw0KPiA+ID4gPiA+ID4gLSByZXQgPSByaF9mcmVlKCZjcG1f
bXVyYW1faW5mbywgb2Zmc2V0KTsNCj4gPiA+ID4gPiA+ICsgZW5kX2JpdCA9IChvZmZzZXQgPj4g
b3JkZXIpICsgKChzaXplICsgKDFVTCA8PCBvcmRlcikgLSAxKQ0KPiA+ID4gPiA+ID4gKyA+Pg0K
PiA+ID4gPiA+IG9yZGVyKTsNCj4gPiA+ID4gPiA+ICsgaWYgKChvZmZzZXQgKyBzaXplKSA+IChl
bmRfYml0IDw8IG9yZGVyKSkNCj4gPiA+ID4gPiA+ICsgICAgICAgICBzaXplX2FsbG9jID0gc2l6
ZSArICgxVUwgPDwgb3JkZXIpOw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gV2h5IGRvIHlvdSBuZWVk
IHRvIGRvIGFsbCB0aGVzZSBjYWxjdWxhdGlvbnMgaGVyZT8NCj4gPiA+ID4NCj4gPiA+ID4gU28g
ZG8gaXQgaW4gZ2VuX3Bvb2xfZml4ZWRfYWxsb2M/DQo+ID4gPg0KPiA+ID4gQ291bGQgeW91IGV4
cGxhaW4gd2h5IHRoZXkncmUgbmVlZGVkIGF0IGFsbD8NCj4gPg0KPiA+IFdoeSBpdCBkb2VzIHRo
ZSBjYWxjdWxhdGlvbnM/DQo+ID4gSWYgdGhlIG1pbiBibG9jayBvZiBnZW5fcG9vbCBpcyA4IGJ5
dGVzLCBhbmQgSSB3YW50IHRvIGFsbG9jYXRlIGENCj4gPiBSZWdpb24gd2l0aCBvZmZzZXQ9Nywg
c2l6ZT04Ynl0ZXMsIEkgYWN0dWFsbHkgbmVlZCBibG9jayAwIGFuZCBibG9jaw0KPiA+IDEsIEFu
ZCB0aGUgYWxsb2NhdGlvbiB3aWxsIGdpdmUgbWUgYmxvY2sgMC4NCj4gDQo+IEhvdyBjYW4geW91
IGhhdmUgb2Zmc2V0IDcgaWYgdGhlIG1pbmltdW0gb3JkZXIgaXMgMiBieXRlcz8NCg0KT2Zmc2V0
IGhhcyBubyByZWxhdGlvbnNoaXAgd2l0aCBtaW5pbXVtIG9yZGVyLCBpdCBpcyBub3QgZGVjaWRl
ZCBieSBtaW5pbXVtIG9yZGVyLg0KSSB3YW50IHRvIGFsbG9jYXRlIGEgc3BlY2lmaWMgcmVnaW9u
IHdpdGggb2Zmc2V0PTcsIHRoZW4gYWxnbyB0byBjYWxjdWxhdGUgdGhlIGJsb2NrIGJpdC4NCkFu
ZCBJIGp1c3QgdGFrZSBpdCBmb3IgZXhhbXBsZSwgaXQgaXMgbm90IEkgcmVhbGx5IG5lZWQgdG8g
cmVnaW9uIG9mZnNldD03Lg0KDQpTbywgbm93IG1pbmltdW0gb3JkZXIgaXMgMiBieXRlcy4gSWYg
b2Zmc2V0PTcsIHNpemU9NGJ5dGVzIG5lZWRlZCwgaXQgYWN0dWFsbHkgYWxsb2NhdGUgNi0xMiB0
byBtZS4NCnNvIEkgbmVlZCB0byBjaGVjayBpZiBpdCBpcyBuZWNlc3NhcnkgdG8gcGx1cyBhIGJs
b2NrKDJieXRlcykgdG8gc2l6ZSBiZWZvcmUgYWxsb2NhdGlvbi4gIA0KDQotWmhhbw0K

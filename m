Return-Path: <bharat.bhushan@nxp.com>
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr40047.outbound.protection.outlook.com [40.107.4.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lcXF6Zc6zDqhb
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 13:37:33 +1000 (AEST)
From: Bharat Bhushan <bharat.bhushan@nxp.com>
To: Scott Wood <oss@buserror.net>, Rob Herring <robh@kernel.org>
CC: "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>, "kstewart@linuxfoundation.org"
 <kstewart@linuxfoundation.org>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "keescook@chromium.org"
 <keescook@chromium.org>, "tyreld@linux.vnet.ibm.com"
 <tyreld@linux.vnet.ibm.com>, "joe@perches.com" <joe@perches.com>
Subject: RE: [RFC 3/5] powerpc/mpic: Add support for non-contiguous irq ranges
Date: Wed, 8 Aug 2018 03:37:28 +0000
Message-ID: <AM5PR0401MB2545AF363F5DD258205177FC9A260@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
 <1532684881-19310-4-git-send-email-Bharat.Bhushan@nxp.com>
 <20180807180938.GA13623@rob-hp-laptop>
 <a20f27b15161164c829f771d2b085639f6709374.camel@buserror.net>
In-Reply-To: <a20f27b15161164c829f771d2b085639f6709374.camel@buserror.net>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2NvdHQgV29vZCBbbWFp
bHRvOm9zc0BidXNlcnJvci5uZXRdDQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDgsIDIwMTgg
MjozNCBBTQ0KPiBUbzogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEJoYXJhdCBCaHVz
aGFuDQo+IDxiaGFyYXQuYmh1c2hhbkBueHAuY29tPg0KPiBDYzogYmVuaEBrZXJuZWwuY3Jhc2hp
bmcub3JnOyBwYXVsdXNAc2FtYmEub3JnOyBtcGVAZWxsZXJtYW4uaWQuYXU7DQo+IGdhbGFrQGtl
cm5lbC5jcmFzaGluZy5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOw0KPiBrc3Rld2FydEBsaW51
eGZvdW5kYXRpb24ub3JnOyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsNCj4gZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBsaW51eC0N
Cj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsga2Vlc2Nvb2tAY2hyb21pdW0ub3JnOw0KPiB0eXJl
bGRAbGludXgudm5ldC5pYm0uY29tOyBqb2VAcGVyY2hlcy5jb20NCj4gU3ViamVjdDogUmU6IFtS
RkMgMy81XSBwb3dlcnBjL21waWM6IEFkZCBzdXBwb3J0IGZvciBub24tY29udGlndW91cyBpcnEN
Cj4gcmFuZ2VzDQo+IA0KPiBPbiBUdWUsIDIwMTgtMDgtMDcgYXQgMTI6MDkgLTA2MDAsIFJvYiBI
ZXJyaW5nIHdyb3RlOg0KPiA+IE9uIEZyaSwgSnVsIDI3LCAyMDE4IGF0IDAzOjE3OjU5UE0gKzA1
MzAsIEJoYXJhdCBCaHVzaGFuIHdyb3RlOg0KPiA+ID4gRnJlZXNjYWxlIE1QSUMgaC93IG1heSBu
b3Qgc3VwcG9ydCBhbGwgaW50ZXJydXB0IHNvdXJjZXMgcmVwb3J0ZWQgYnkNCj4gPiA+IGhhcmR3
YXJlLCAibGFzdC1pbnRlcnJ1cHQtc291cmNlIiBvciBwbGF0Zm9ybS4gT24gdGhlc2UgcGxhdGZv
cm1zIGENCj4gPiA+IG1pc2NvbmZpZ3VyZWQgZGV2aWNlIHRyZWUgdGhhdCBhc3NpZ25zIG9uZSBv
ZiB0aGUgcmVzZXJ2ZWQNCj4gPiA+IGludGVycnVwdHMgbGVhdmVzIGEgbm9uLWZ1bmN0aW9uaW5n
IHN5c3RlbSB3aXRob3V0IHdhcm5pbmcuDQo+ID4NCj4gPiBUaGVyZSBhcmUgbG90cyBvZiB3YXlz
IHRvIG1pc2NvbmZpZ3VyZSBEVHMuIEkgZG9uJ3QgdGhpbmsgdGhpcyBpcw0KPiA+IHNwZWNpYWwg
YW5kIG5lZWRzIGEgcHJvcGVydHkuDQo+IA0KPiBZZWFoLCB0aGUgc3lzdGVtIHdpbGwgYmUganVz
dCBhcyBub24tZnVuY3Rpb25pbmcgaWYgeW91IHNwZWNpZnkgYSB2YWxpZC1idXQtDQo+IHdyb25n
LWZvci10aGUtZGV2aWNlIGludGVycnVwdCBudW1iZXIuDQoNClNvbWUgaXMgb25lIGFkZGl0aW9u
YWwgYmVuZWZpdHMgb2YgdGhpcyBjaGFuZ2VzLCBNUElDIGhhdmUgcmVzZXJ2ZWQgcmVnaW9ucyBm
b3IgdW4tc3VwcG9ydGVkIGludGVycnVwdHMgYW5kIHJlYWQvd3JpdGVzIHRvIHRoZXNlIHJlc2Vy
dmVkIHJlZ2lvbnMgc2VhbXMgaGF2ZSBubyBlZmZlY3QuDQpNUElDIGRyaXZlciByZWFkcy93cml0
ZXMgdG8gdGhlIHJlc2VydmVkIHJlZ2lvbnMgZHVyaW5nIGluaXQvdW5pbml0IGFuZCBzYXZlL3Jl
c3RvcmUgc3RhdGUuDQoNCkxldCBtZSBrbm93IGlmIGl0IG1ha2Ugc2Vuc2UgdG8gaGF2ZSB0aGVz
ZSBjaGFuZ2VzIGZvciBtZW50aW9uZWQgcmVhc29ucy4NCg0KVGhhbmtzDQotQmhhcmF0DQoNCj4g
DQo+ID4gIFdlJ3ZlIGhhZCBzb21lIGludGVycnVwdCBtYXNrIG9yIHZhbGlkIHByb3BlcnRpZXMg
aW4gdGhlIHBhc3QsIGJ1dA0KPiA+IGdlbmVyYWxseSBkb24ndCBhY2NlcHQgdGhvc2UuDQo+IA0K
PiBGV0lXLCBzb21lIG9mIHRoZW0gbGlrZSBwcm90ZWN0ZWQtc291cmNlcyBhbmQgbXBpYy1tc2dy
LXJlY2VpdmUtbWFzaw0KPiBhcmVuJ3QgZm9yIGRldGVjdGluZyBlcnJvcnMsIGJ1dCBhcmUgZm9y
IHBhcnRpdGlvbmluZyAodGhvdWdoIHRoZSBmb3JtZXIgaXMNCj4gb2Jzb2xldGUgd2l0aCBwaWMt
bm8tcmVzZXQpLg0KPiANCj4gLVNjb3R0DQoNCg==

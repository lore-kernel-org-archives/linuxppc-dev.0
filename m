Return-Path: <bharat.bhushan@nxp.com>
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60082.outbound.protection.outlook.com [40.107.6.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lgdT0fXQzDqjk
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 15:57:15 +1000 (AEST)
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
Date: Wed, 8 Aug 2018 05:57:09 +0000
Message-ID: <AM5PR0401MB254583A97F24DBE1BACF1B1E9A260@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
 <1532684881-19310-4-git-send-email-Bharat.Bhushan@nxp.com>
 <20180807180938.GA13623@rob-hp-laptop>
 <a20f27b15161164c829f771d2b085639f6709374.camel@buserror.net>
 <AM5PR0401MB2545AF363F5DD258205177FC9A260@AM5PR0401MB2545.eurprd04.prod.outlook.com>
 <7526e100693e4db9bb3adf576254b2161086dfe8.camel@buserror.net>
In-Reply-To: <7526e100693e4db9bb3adf576254b2161086dfe8.camel@buserror.net>
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
MTE6MjEgQU0NCj4gVG86IEJoYXJhdCBCaHVzaGFuIDxiaGFyYXQuYmh1c2hhbkBueHAuY29tPjsg
Um9iIEhlcnJpbmcNCj4gPHJvYmhAa2VybmVsLm9yZz4NCj4gQ2M6IGJlbmhAa2VybmVsLmNyYXNo
aW5nLm9yZzsgcGF1bHVzQHNhbWJhLm9yZzsgbXBlQGVsbGVybWFuLmlkLmF1Ow0KPiBnYWxha0Br
ZXJuZWwuY3Jhc2hpbmcub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4ga3N0ZXdhcnRAbGlu
dXhmb3VuZGF0aW9uLm9yZzsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7DQo+IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsgbGludXgt
DQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlZXNjb29rQGNocm9taXVtLm9yZzsNCj4gdHly
ZWxkQGxpbnV4LnZuZXQuaWJtLmNvbTsgam9lQHBlcmNoZXMuY29tDQo+IFN1YmplY3Q6IFJlOiBb
UkZDIDMvNV0gcG93ZXJwYy9tcGljOiBBZGQgc3VwcG9ydCBmb3Igbm9uLWNvbnRpZ3VvdXMgaXJx
DQo+IHJhbmdlcw0KPiANCj4gT24gV2VkLCAyMDE4LTA4LTA4IGF0IDAzOjM3ICswMDAwLCBCaGFy
YXQgQmh1c2hhbiB3cm90ZToNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4g
PiBGcm9tOiBTY290dCBXb29kIFttYWlsdG86b3NzQGJ1c2Vycm9yLm5ldF0NCj4gPiA+IFNlbnQ6
IFdlZG5lc2RheSwgQXVndXN0IDgsIDIwMTggMjozNCBBTQ0KPiA+ID4gVG86IFJvYiBIZXJyaW5n
IDxyb2JoQGtlcm5lbC5vcmc+OyBCaGFyYXQgQmh1c2hhbg0KPiA+ID4gPGJoYXJhdC5iaHVzaGFu
QG54cC5jb20+DQo+ID4gPiBDYzogYmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnOyBwYXVsdXNAc2Ft
YmEub3JnOyBtcGVAZWxsZXJtYW4uaWQuYXU7DQo+ID4gPiBnYWxha0BrZXJuZWwuY3Jhc2hpbmcu
b3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gPiA+IGtzdGV3YXJ0QGxpbnV4Zm91bmRhdGlv
bi5vcmc7IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOw0KPiA+ID4gZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBsaW51eC0NCj4gPiA+
IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlZXNjb29rQGNocm9taXVtLm9yZzsNCj4gPiA+IHR5
cmVsZEBsaW51eC52bmV0LmlibS5jb207IGpvZUBwZXJjaGVzLmNvbQ0KPiA+ID4gU3ViamVjdDog
UmU6IFtSRkMgMy81XSBwb3dlcnBjL21waWM6IEFkZCBzdXBwb3J0IGZvciBub24tY29udGlndW91
cw0KPiA+ID4gaXJxIHJhbmdlcw0KPiA+ID4NCj4gPiA+IE9uIFR1ZSwgMjAxOC0wOC0wNyBhdCAx
MjowOSAtMDYwMCwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+ID4gPiA+IE9uIEZyaSwgSnVsIDI3LCAy
MDE4IGF0IDAzOjE3OjU5UE0gKzA1MzAsIEJoYXJhdCBCaHVzaGFuIHdyb3RlOg0KPiA+ID4gPiA+
IEZyZWVzY2FsZSBNUElDIGgvdyBtYXkgbm90IHN1cHBvcnQgYWxsIGludGVycnVwdCBzb3VyY2Vz
DQo+ID4gPiA+ID4gcmVwb3J0ZWQgYnkgaGFyZHdhcmUsICJsYXN0LWludGVycnVwdC1zb3VyY2Ui
IG9yIHBsYXRmb3JtLiBPbg0KPiA+ID4gPiA+IHRoZXNlIHBsYXRmb3JtcyBhIG1pc2NvbmZpZ3Vy
ZWQgZGV2aWNlIHRyZWUgdGhhdCBhc3NpZ25zIG9uZSBvZg0KPiA+ID4gPiA+IHRoZSByZXNlcnZl
ZCBpbnRlcnJ1cHRzIGxlYXZlcyBhIG5vbi1mdW5jdGlvbmluZyBzeXN0ZW0gd2l0aG91dA0KPiB3
YXJuaW5nLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGVyZSBhcmUgbG90cyBvZiB3YXlzIHRvIG1pc2Nv
bmZpZ3VyZSBEVHMuIEkgZG9uJ3QgdGhpbmsgdGhpcyBpcw0KPiA+ID4gPiBzcGVjaWFsIGFuZCBu
ZWVkcyBhIHByb3BlcnR5Lg0KPiA+ID4NCj4gPiA+IFllYWgsIHRoZSBzeXN0ZW0gd2lsbCBiZSBq
dXN0IGFzIG5vbi1mdW5jdGlvbmluZyBpZiB5b3Ugc3BlY2lmeSBhDQo+ID4gPiB2YWxpZC0NCj4g
PiA+IGJ1dC0NCj4gPiA+IHdyb25nLWZvci10aGUtZGV2aWNlIGludGVycnVwdCBudW1iZXIuDQo+
ID4NCj4gPiBTb21lIGlzIG9uZSBhZGRpdGlvbmFsIGJlbmVmaXRzIG9mIHRoaXMgY2hhbmdlcywg
TVBJQyBoYXZlIHJlc2VydmVkDQo+ID4gcmVnaW9ucyBmb3IgdW4tc3VwcG9ydGVkIGludGVycnVw
dHMgYW5kIHJlYWQvd3JpdGVzIHRvIHRoZXNlIHJlc2VydmVkDQo+ID4gcmVnaW9ucyBzZWFtcyBo
YXZlIG5vIGVmZmVjdC4NCj4gPiBNUElDIGRyaXZlciByZWFkcy93cml0ZXMgdG8gdGhlIHJlc2Vy
dmVkIHJlZ2lvbnMgZHVyaW5nIGluaXQvdW5pbml0DQo+ID4gYW5kIHNhdmUvcmVzdG9yZSBzdGF0
ZS4NCj4gPg0KPiA+IExldCBtZSBrbm93IGlmIGl0IG1ha2Ugc2Vuc2UgdG8gaGF2ZSB0aGVzZSBj
aGFuZ2VzIGZvciBtZW50aW9uZWQNCj4gcmVhc29ucy4NCj4gDQo+IFRoZSBkcml2ZXIgaGFzIGJl
ZW4gZG9pbmcgdGhpcyBmb3JldmVyIHdpdGggbm8gaWxsIGVmZmVjdC4NCg0KWWVzLCB0aGVyZSBh
cmUgbm8gaXNzdWUgcmVwb3J0ZWQNCg0KPiAgV2hhdCBpcyB0aGUgIG1vdGl2YXRpb24gZm9yIHRo
aXMgY2hhbmdlPw0KDQpPbiBTaW11bGF0aW9uIG1vZGVsIEkgc2VlIHdhcm5pbmcgd2hlbiBhY2Nl
c3NpbmcgdGhlIHJlc2VydmVkIHJlZ2lvbiwgU28gdGhpcyBwYXRjaCBpcyBqdXN0IGFuIGVmZm9y
dCB0byBpbXByb3ZlLg0KDQpUaGFua3MNCi1CaGFyYXQNCg0KPiANCj4gLVNjb3R0DQoNCg==

Return-Path: <nipun.gupta@nxp.com>
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr40077.outbound.protection.outlook.com [40.107.4.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41MYdD01KTzDqJh
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2018 22:17:19 +1000 (AEST)
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Robin Murphy <robin.murphy@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>, "bhelgaas@google.com" <bhelgaas@google.com>
CC: "hch@lst.de" <hch@lst.de>, "joro@8bytes.org" <joro@8bytes.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "shawnguo@kernel.org"
 <shawnguo@kernel.org>, "frowand.list@gmail.com" <frowand.list@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, Bharat Bhushan <bharat.bhushan@nxp.com>,
 "stuyoder@gmail.com" <stuyoder@gmail.com>, Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH 5/7 v5] bus: fsl-mc: support dma configure for devices on
 fsl-mc bus
Date: Fri, 6 Jul 2018 12:17:09 +0000
Message-ID: <HE1PR0401MB2425626DB35517BFD4FA9E15E6470@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
 <1526824191-7000-6-git-send-email-nipun.gupta@nxp.com>
 <b4cf1e86-0297-97ed-d10e-9b430ecb0bc7@arm.com>
In-Reply-To: <b4cf1e86-0297-97ed-d10e-9b430ecb0bc7@arm.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IFtt
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMywgMjAx
OCA5OjQ0IFBNDQo+IFRvOiBOaXB1biBHdXB0YSA8bmlwdW4uZ3VwdGFAbnhwLmNvbT47IHdpbGwu
ZGVhY29uQGFybS5jb207DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsgcm9iaEBrZXJuZWwub3JnOyBt
YXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IGdyZWdraEBs
aW51eGZvdW5kYXRpb24ub3JnOyBMYXVyZW50aXUgVHVkb3INCj4gPGxhdXJlbnRpdS50dWRvckBu
eHAuY29tPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbQ0KPiBDYzogaGNoQGxzdC5kZTsgam9yb0A4Ynl0
ZXMub3JnOyBtLnN6eXByb3dza2lAc2Ftc3VuZy5jb207DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7
IGZyb3dhbmQubGlzdEBnbWFpbC5jb207IGlvbW11QGxpc3RzLmxpbnV4LQ0KPiBmb3VuZGF0aW9u
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXhwcGMt
ZGV2QGxpc3RzLm96bGFicy5vcmc7IGxpbnV4LQ0KPiBwY2lAdmdlci5rZXJuZWwub3JnOyBCaGFy
YXQgQmh1c2hhbiA8YmhhcmF0LmJodXNoYW5AbnhwLmNvbT47DQo+IHN0dXlvZGVyQGdtYWlsLmNv
bTsgTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNS83
IHY1XSBidXM6IGZzbC1tYzogc3VwcG9ydCBkbWEgY29uZmlndXJlIGZvciBkZXZpY2VzDQo+IG9u
IGZzbC1tYyBidXMNCj4gDQo+IE9uIDIwLzA1LzE4IDE0OjQ5LCBOaXB1biBHdXB0YSB3cm90ZToN
Cj4gPiBUaGlzIHBhdGNoIGFkZHMgc3VwcG9ydCBvZiBkbWEgY29uZmlndXJhdGlvbiBmb3IgZGV2
aWNlcyBvbiBmc2wtbWMNCj4gPiBidXMgdXNpbmcgJ2RtYV9jb25maWd1cmUnIGNhbGxiYWNrIGZv
ciBidXNzZXMuIEFsc28sIGRpcmVjdGx5IGNhbGxpbmcNCj4gPiBhcmNoX3NldHVwX2RtYV9vcHMg
aXMgcmVtb3ZlZCBmcm9tIHRoZSBmc2wtbWMgYnVzLg0KPiANCj4gTG9va3MgbGlrZSB0aGlzIGlz
IHRoZSBmaW5hbCBhcmNoX3NldHVwX2RtYV9vcHMgb2ZmZW5kZXIsIHlheSENCj4gDQo+ID4gU2ln
bmVkLW9mZi1ieTogTmlwdW4gR3VwdGEgPG5pcHVuLmd1cHRhQG54cC5jb20+DQo+ID4gUmV2aWV3
ZWQtYnk6IExhdXJlbnRpdSBUdWRvciA8bGF1cmVudGl1LnR1ZG9yQG54cC5jb20+DQo+ID4gLS0t
DQo+ID4gICBkcml2ZXJzL2J1cy9mc2wtbWMvZnNsLW1jLWJ1cy5jIHwgMTUgKysrKysrKysrKyst
LS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2J1cy9mc2wtbWMvZnNsLW1jLWJ1cy5j
IGIvZHJpdmVycy9idXMvZnNsLW1jL2ZzbC1tYy0NCj4gYnVzLmMNCj4gPiBpbmRleCA1ZDgyNjZj
Li5mYTQzYzdkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYnVzL2ZzbC1tYy9mc2wtbWMtYnVz
LmMNCj4gPiArKysgYi9kcml2ZXJzL2J1cy9mc2wtbWMvZnNsLW1jLWJ1cy5jDQo+ID4gQEAgLTEy
Nyw2ICsxMjcsMTYgQEAgc3RhdGljIGludCBmc2xfbWNfYnVzX3VldmVudChzdHJ1Y3QgZGV2aWNl
ICpkZXYsDQo+IHN0cnVjdCBrb2JqX3VldmVudF9lbnYgKmVudikNCj4gPiAgIAlyZXR1cm4gMDsN
Cj4gPiAgIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW50IGZzbF9tY19kbWFfY29uZmlndXJlKHN0cnVj
dCBkZXZpY2UgKmRldikNCj4gPiArew0KPiA+ICsJc3RydWN0IGRldmljZSAqZG1hX2RldiA9IGRl
djsNCj4gPiArDQo+ID4gKwl3aGlsZSAoZGV2X2lzX2ZzbF9tYyhkbWFfZGV2KSkNCj4gPiArCQlk
bWFfZGV2ID0gZG1hX2Rldi0+cGFyZW50Ow0KPiA+ICsNCj4gPiArCXJldHVybiBvZl9kbWFfY29u
ZmlndXJlKGRldiwgZG1hX2Rldi0+b2Zfbm9kZSwgMCk7DQo+ID4gK30NCj4gPiArDQo+ID4gICBz
dGF0aWMgc3NpemVfdCBtb2RhbGlhc19zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRl
dmljZV9hdHRyaWJ1dGUNCj4gKmF0dHIsDQo+ID4gICAJCQkgICAgIGNoYXIgKmJ1ZikNCj4gPiAg
IHsNCj4gPiBAQCAtMTQ4LDYgKzE1OCw3IEBAIHN0cnVjdCBidXNfdHlwZSBmc2xfbWNfYnVzX3R5
cGUgPSB7DQo+ID4gICAJLm5hbWUgPSAiZnNsLW1jIiwNCj4gPiAgIAkubWF0Y2ggPSBmc2xfbWNf
YnVzX21hdGNoLA0KPiA+ICAgCS51ZXZlbnQgPSBmc2xfbWNfYnVzX3VldmVudCwNCj4gPiArCS5k
bWFfY29uZmlndXJlICA9IGZzbF9tY19kbWFfY29uZmlndXJlLA0KPiA+ICAgCS5kZXZfZ3JvdXBz
ID0gZnNsX21jX2Rldl9ncm91cHMsDQo+ID4gICB9Ow0KPiA+ICAgRVhQT1JUX1NZTUJPTF9HUEwo
ZnNsX21jX2J1c190eXBlKTsNCj4gPiBAQCAtNjMzLDEwICs2NDQsNiBAQCBpbnQgZnNsX21jX2Rl
dmljZV9hZGQoc3RydWN0IGZzbF9tY19vYmpfZGVzYw0KPiAqb2JqX2Rlc2MsDQo+ID4gICAJCQln
b3RvIGVycm9yX2NsZWFudXBfZGV2Ow0KPiA+ICAgCX0NCj4gPg0KPiA+IC0JLyogT2JqZWN0cyBh
cmUgY29oZXJlbnQsIHVubGVzcyAnbm8gc2hhcmVhYmlsaXR5JyBmbGFnIHNldC4gKi8NCj4gPiAt
CWlmICghKG9ial9kZXNjLT5mbGFncyAmDQo+IEZTTF9NQ19PQkpfRkxBR19OT19NRU1fU0hBUkVB
QklMSVRZKSkNCj4gDQo+IEFsdGhvdWdoIGl0IHNlZW1zIHdlIGRvIGVuZCB1cCB3aXRob3V0IGFu
eSBoYW5kbGluZyBvZiB0aGlzDQo+ICJub24tY29oZXJlbnQgb2JqZWN0IGJlaGluZCBjb2hlcmVu
dCBNQyIgY2FzZSwgYW5kIEknbSBub3Qgc3VyZSBob3cNCj4gZWFzaWx5IHRoYXQgY291bGQgYmUg
YWNjb21tb2RhdGVkIGJ5IGdlbmVyaWMgY29kZS4uLiA6LyBIb3cgaW1wb3J0YW50IGlzDQo+IHRo
ZSBxdWlyaz8NCg0KV2UgaGF2ZSBhbGwgdGhlIGRldmljZXMgYXMgY29oZXJlbnQgaW4gb3VyIFNv
QydzIG5vdyA6KSBTbyB0aGlzIGlzIGZpbmUuDQpXZSBoYXZlIGludGVybmFsbHkgZGlzY3Vzc2Vk
IGl0Lg0KDQpSZWdhcmRzLA0KTmlwdW4NCg0KPiANCj4gUm9iaW4uDQo+IA0KPiA+IC0JCWFyY2hf
c2V0dXBfZG1hX29wcygmbWNfZGV2LT5kZXYsIDAsIDAsIE5VTEwsIHRydWUpOw0KPiA+IC0NCj4g
PiAgIAkvKg0KPiA+ICAgCSAqIFRoZSBkZXZpY2Utc3BlY2lmaWMgcHJvYmUgY2FsbGJhY2sgd2ls
bCBnZXQgaW52b2tlZCBieSBkZXZpY2VfYWRkKCkNCj4gPiAgIAkgKi8NCj4gPg0K

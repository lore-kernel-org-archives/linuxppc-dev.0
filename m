Return-Path: <nipun.gupta@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0077.outbound.protection.outlook.com [104.47.2.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QsTj75WqzF1xg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2018 16:21:59 +1000 (AEST)
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Robin Murphy <robin.murphy@arm.com>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "frowand.list@gmail.com" <frowand.list@gmail.com>
CC: "will.deacon@arm.com" <will.deacon@arm.com>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "hch@lst.de" <hch@lst.de>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "joro@8bytes.org" <joro@8bytes.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "shawnguo@kernel.org"
 <shawnguo@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, Bharat Bhushan <bharat.bhushan@nxp.com>,
 "stuyoder@gmail.com" <stuyoder@gmail.com>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>, Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH 2/6 v2] iommu: of: make of_pci_map_rid() available for
 other devices too
Date: Wed, 18 Apr 2018 06:21:46 +0000
Message-ID: <HE1PR0401MB2425A73A3BFF84B15B764FC6E6B60@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1523960514-25457-1-git-send-email-nipun.gupta@nxp.com>
 <1523960514-25457-3-git-send-email-nipun.gupta@nxp.com>
 <41b32766-e21a-e946-6c8f-440e5c87d0ee@arm.com>
In-Reply-To: <41b32766-e21a-e946-6c8f-440e5c87d0ee@arm.com>
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
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDE3LCAy
MDE4IDEwOjIzIFBNDQo+IFRvOiBOaXB1biBHdXB0YSA8bmlwdW4uZ3VwdGFAbnhwLmNvbT47IHJv
YmgrZHRAa2VybmVsLm9yZzsNCj4gZnJvd2FuZC5saXN0QGdtYWlsLmNvbQ0KPiBDYzogd2lsbC5k
ZWFjb25AYXJtLmNvbTsgbWFyay5ydXRsYW5kQGFybS5jb207IGNhdGFsaW4ubWFyaW5hc0Bhcm0u
Y29tOw0KPiBoY2hAbHN0LmRlOyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgam9yb0A4Ynl0
ZXMub3JnOw0KPiBtLnN6eXByb3dza2lAc2Ftc3VuZy5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7
IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eHBwYy0NCj4g
ZGV2QGxpc3RzLm96bGFicy5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IEJoYXJhdCBC
aHVzaGFuDQo+IDxiaGFyYXQuYmh1c2hhbkBueHAuY29tPjsgc3R1eW9kZXJAZ21haWwuY29tOyBM
YXVyZW50aXUgVHVkb3INCj4gPGxhdXJlbnRpdS50dWRvckBueHAuY29tPjsgTGVvIExpIDxsZW95
YW5nLmxpQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi82IHYyXSBpb21tdTogb2Y6
IG1ha2Ugb2ZfcGNpX21hcF9yaWQoKSBhdmFpbGFibGUgZm9yDQo+IG90aGVyIGRldmljZXMgdG9v
DQo+IA0KPiBPbiAxNy8wNC8xOCAxMToyMSwgTmlwdW4gR3VwdGEgd3JvdGU6DQo+ID4gaW9tbXUt
bWFwIHByb3BlcnR5IGlzIGFsc28gdXNlZCBieSBkZXZpY2VzIHdpdGggZnNsLW1jLiBUaGlzIHBh
dGNoDQo+ID4gbW92ZXMgdGhlIG9mX3BjaV9tYXBfcmlkIHRvIGdlbmVyaWMgbG9jYXRpb24sIHNv
IHRoYXQgaXQgY2FuIGJlIHVzZWQNCj4gPiBieSBvdGhlciBidXNzZXMgdG9vLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogTmlwdW4gR3VwdGEgPG5pcHVuLmd1cHRhQG54cC5jb20+DQo+ID4gLS0t
DQo+ID4gICBkcml2ZXJzL2lvbW11L29mX2lvbW11LmMgfCAxMDYNCj4gPiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiANCj4gRG9lc24ndCB0aGlzIGJy
ZWFrICJtc2ktcGFyZW50IiBwYXJzaW5nIGZvciAhQ09ORklHX09GX0lPTU1VPyBJIGd1ZXNzIHlv
dQ0KPiBkb24ndCB3YW50IGZzbC1tYyB0byBoYXZlIHRvIGRlcGVuZCBvbiBQQ0ksIGJ1dCB0aGlz
IGxvb2tzIGxpa2UgYSBzdGVwIGluIHRoZQ0KPiB3cm9uZyBkaXJlY3Rpb24uDQoNClRoYW5rcyBm
b3IgcG9pbnRpbmcgb3V0Lg0KQWdyZWUsIHRoaXMgd2lsbCBicmVhayAibXNpLXBhcmVudCIgcGFy
c2luZyBmb3IgIUNPTkZJR19PRl9JT01NVSBjYXNlLg0KDQo+IA0KPiBJJ20gbm90IGVudGlyZWx5
IHN1cmUgd2hlcmUgb2ZfbWFwX3JpZCgpIGZpdHMgYmVzdCwgYnV0IGZyb20gYSBxdWljayBsb29r
IGFyb3VuZA0KPiB0aGUgbGVhc3Qtd29yc3Qgb3B0aW9uIG1pZ2h0IGJlIGRyaXZlcnMvb2Yvb2Zf
YWRkcmVzcy5jLCB1bmxlc3MgUm9iIGFuZCBGcmFuaw0KPiBoYXZlIGEgYmV0dGVyIGlkZWEgb2Yg
d2hlcmUgZ2VuZXJpYyBEVC1iYXNlZCBJRCB0cmFuc2xhdGlvbiByb3V0aW5lcyBjb3VsZCBsaXZl
Pw0KPiANCj4gPiAgIGRyaXZlcnMvb2YvaXJxLmMgICAgICAgICB8ICAgNiArLS0NCj4gPiAgIGRy
aXZlcnMvcGNpL29mLmMgICAgICAgICB8IDEwMSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAgaW5jbHVkZS9saW51eC9vZl9pb21tdS5oIHwgIDExICsr
KysrDQo+ID4gICBpbmNsdWRlL2xpbnV4L29mX3BjaS5oICAgfCAgMTAgLS0tLS0NCj4gPiAgIDUg
ZmlsZXMgY2hhbmdlZCwgMTE3IGluc2VydGlvbnMoKyksIDExNyBkZWxldGlvbnMoLSkNCj4gPg0K
DQpbLi4uXQ0KDQo+ID4gICBzdHJ1Y3Qgb2ZfcGNpX2lvbW11X2FsaWFzX2luZm8gew0KPiA+ICAg
CXN0cnVjdCBkZXZpY2UgKmRldjsNCj4gPiAgIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wOw0KPiA+
IEBAIC0xNDksOSArMjQ5LDkgQEAgc3RhdGljIGludCBvZl9wY2lfaW9tbXVfaW5pdChzdHJ1Y3Qg
cGNpX2RldiAqcGRldiwgdTE2DQo+IGFsaWFzLCB2b2lkICpkYXRhKQ0KPiA+ICAgCXN0cnVjdCBv
Zl9waGFuZGxlX2FyZ3MgaW9tbXVfc3BlYyA9IHsgLmFyZ3NfY291bnQgPSAxIH07DQo+ID4gICAJ
aW50IGVycjsNCj4gPg0KPiA+IC0JZXJyID0gb2ZfcGNpX21hcF9yaWQoaW5mby0+bnAsIGFsaWFz
LCAiaW9tbXUtbWFwIiwNCj4gPiAtCQkJICAgICAiaW9tbXUtbWFwLW1hc2siLCAmaW9tbXVfc3Bl
Yy5ucCwNCj4gPiAtCQkJICAgICBpb21tdV9zcGVjLmFyZ3MpOw0KPiA+ICsJZXJyID0gb2ZfbWFw
X3JpZChpbmZvLT5ucCwgYWxpYXMsICJpb21tdS1tYXAiLA0KPiA+ICsJCQkgImlvbW11LW1hcC1t
YXNrIiwgJmlvbW11X3NwZWMubnAsDQo+ID4gKwkJCSBpb21tdV9zcGVjLmFyZ3MpOw0KPiANCj4g
U3VwZXItbml0OiBBcHBhcmVudGx5IEkgbWlzc2VkIHJld3JhcHBpbmcgdGhpcyB0byAyIGxpbmVz
IGluIGQ4N2JlYjc0OTI4MSwgYnV0IGlmDQo+IGl0J3MgYmVpbmcgdG91Y2hlZCBhZ2FpbiwgdGhh
dCB3b3VsZCBiZSBuaWNlIDspDQoNClN1cmUuLiBJJ2xsIHRha2UgY2FyZSBvZiB0aGlzIGluIHRo
ZSBuZXh0IHZlcnNpb24gOikNCg0KUmVnYXJkcywNCk5pcHVuDQo=

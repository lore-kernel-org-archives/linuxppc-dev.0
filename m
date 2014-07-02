Return-Path: <Varun.Sethi@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0182.outbound.protection.outlook.com [207.46.163.182])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 77E701A001C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jul 2014 18:59:03 +1000 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: Emilian Medve <Emilian.Medve@freescale.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "joro@8bytes.org" <joro@8bytes.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>
Subject: RE: [PATCH 1/3] iommu/fsl: Fix PAMU window size check.
Date: Wed, 2 Jul 2014 08:58:45 +0000
Message-ID: <43e9c89d998b480b869b7ab4d9b4e52c@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1403618237-26248-1-git-send-email-Varun.Sethi@freescale.com>
 <1403618237-26248-2-git-send-email-Varun.Sethi__13822.953499812$1403630309$gmane$org@freescale.com>
 <53B3B8B9.30400@Freescale.com>
In-Reply-To: <53B3B8B9.30400@Freescale.com>
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

VGhhbmtzIEVtaWwuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRW1p
bCBNZWR2ZSBbbWFpbHRvOkVtaWxpYW4uTWVkdmVARnJlZXNjYWxlLmNvbV0NCj4gU2VudDogV2Vk
bmVzZGF5LCBKdWx5IDAyLCAyMDE0IDE6MTYgUE0NCj4gVG86IFNldGhpIFZhcnVuLUIxNjM5NTsg
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7DQo+IGpvcm9AOGJ5dGVzLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXhwcGMtDQo+IGRldkBsaXN0cy5vemxhYnMu
b3JnOyBhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEv
M10gaW9tbXUvZnNsOiBGaXggUEFNVSB3aW5kb3cgc2l6ZSBjaGVjay4NCj4gDQo+IE9uIDA2LzI0
LzIwMTQgMDg6NTcgQU0sIFZhcnVuIFNldGhpIHdyb3RlOg0KPiA+IGlzX3Bvd2VyX29mXzIgcmVx
dWlyZXMgYW4gdW5zaWduZWQgbG9uZyBwYXJhbWV0ZXIgd2hpY2ggd291bGQgbGVhZCB0bw0KPiA+
IHRydW5jYXRpb24gb2YgNjQgYml0IHZhbHVlcyBvbiAzMiBiaXQgYXJjaGl0ZWN0dXJlcy4NCj4g
Pg0KPiA+IF9fZmZzIGFsc28gZXhwZWN0cyBhbiB1bnNpZ25lZCBsb25nIHBhcmFtZXRlciB0aHVz
IHdvbid0IHdvcmsgZm9yIDY0DQo+ID4gYml0IHZhbHVlcyBvbiAzMiBiaXQgYXJjaGl0ZWN0dXJl
cy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFZhcnVuIFNldGhpIDxWYXJ1bi5TZXRoaUBmcmVl
c2NhbGUuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2lvbW11L2ZzbF9wYW11LmMgICAgICAg
IHwgICAgOCArKysrLS0tLQ0KPiA+ICBkcml2ZXJzL2lvbW11L2ZzbF9wYW11X2RvbWFpbi5jIHwg
ICAgMiArLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkNCj4gDQo+IFRlc3RlZC1ieTogRW1pbCBNZWR2ZSA8RW1pbGlhbi5NZWR2ZUBGcmVlc2Nh
bGUuY29tPg0KPiANCj4gT24gYSBQNDA4MCBEUyAoaS5lLiAzMi1iaXQgU29DKQ0KPiANCj4gDQo+
IENoZWVycywNCg==

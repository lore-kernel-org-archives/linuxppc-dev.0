Return-Path: <SRS0=9RGo=SD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E49DC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 10:20:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C1020880
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 10:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KlcAXfQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C1020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44XpHw6222zDqMs
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 21:20:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.7.43; helo=eur04-he1-obe.outbound.protection.outlook.com;
 envelope-from=laurentiu.tudor@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="KlcAXfQR"; 
 dkim-atps=neutral
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70043.outbound.protection.outlook.com [40.107.7.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44XpGC70dZzDqGp
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Apr 2019 21:18:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOenmEkosXGDyf7a+VqpcwX2uj6t7O5ObUc9y78rxcs=;
 b=KlcAXfQRyaxKFiupSlpaAEwVZc3G4gtRg4u5sfLri6x1MQjNviGiHwAU/4DCklRGjsqWCTF6A2m7K/EDeyrnJZ0cOuxqKvusCqYrkz1vgSmD6dTt8ybIxU4z7LHC70C/CWwSnbdXFv+vIhvitV0TkIMel5cT2cFHGYTiShowC1Y=
Received: from DB7PR04MB5132.eurprd04.prod.outlook.com (20.176.235.28) by
 DB7PR04MB5513.eurprd04.prod.outlook.com (20.178.106.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Mon, 1 Apr 2019 10:18:33 +0000
Received: from DB7PR04MB5132.eurprd04.prod.outlook.com
 ([fe80::2cac:cc2f:6528:54f7]) by DB7PR04MB5132.eurprd04.prod.outlook.com
 ([fe80::2cac:cc2f:6528:54f7%5]) with mapi id 15.20.1750.021; Mon, 1 Apr 2019
 10:18:33 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH 05/13] soc/fsl/bqman: page align iommu mapping sizes
Thread-Topic: [PATCH 05/13] soc/fsl/bqman: page align iommu mapping sizes
Thread-Index: AQHU5je/24+T4YtOUUiyQc6DfGY3UqYjKvWAgAPwlsA=
Date: Mon, 1 Apr 2019 10:18:33 +0000
Message-ID: <DB7PR04MB5132F8826AEE540386FA1A33EC550@DB7PR04MB5132.eurprd04.prod.outlook.com>
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
 <20190329140014.8126-6-laurentiu.tudor@nxp.com>
 <CADRPPNTh65rwPVVzJBWt-cNrbQWAoo0FeTGnCHDiqSxvARa_5g@mail.gmail.com>
In-Reply-To: <CADRPPNTh65rwPVVzJBWt-cNrbQWAoo0FeTGnCHDiqSxvARa_5g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55d404e7-a2cc-4708-2104-08d6b68b6538
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DB7PR04MB5513; 
x-ms-traffictypediagnostic: DB7PR04MB5513:
x-microsoft-antispam-prvs: <DB7PR04MB55136F62161A8FB67A1A8730EC550@DB7PR04MB5513.eurprd04.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(136003)(366004)(39860400002)(396003)(13464003)(199004)(189003)(86362001)(486006)(14444005)(6636002)(74316002)(99286004)(76176011)(68736007)(6116002)(305945005)(52536014)(81156014)(8676002)(256004)(6862004)(71200400001)(7736002)(2906002)(97736004)(5660300002)(55016002)(9686003)(6246003)(8936002)(4326008)(229853002)(81166006)(478600001)(44832011)(6436002)(53936002)(71190400001)(3846002)(25786009)(33656002)(106356001)(105586002)(476003)(66066001)(26005)(54906003)(316002)(53546011)(6506007)(446003)(7696005)(11346002)(102836004)(14454004)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR04MB5513;
 H:DB7PR04MB5132.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iC0+PF9zLNmVu2VxirzeoqYJIG8Njq3MMtvWjF0fFZ5r5U2R35G3lKLkCxA9BDdl21t8wrrxyBKBPfUcQ1lkjbjrqqEzjhz+reXzHkl2kMrCqhQvD0OIQbLdGPxKYu+IJ5B1UfdQK69OCzeX1gXj/8cQz5b3vcfPuDCZFuD9UWPvXZWkbaFRL+mboq9OsdUKoFfkmxo7epM4CnZmSN4GlGt0dvD/4qok3IdDNAYEkZIOLYr5u2R450l6shMSZYDBgq/JOobnwzwEpmKPr/aItD6eqNdgleEDPZWr/NCg/L6tPwJbz0aKfjxghD2NbRy/GV9j0SxKS0CMnSLulUsnZvwrGNdl243y1i/MKL846pJnJmxwoP+a1bGiC3NiH78f99979tAOidfOkkcaMVcVCHNlIVPG+Yor5X/caCTCWSk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d404e7-a2cc-4708-2104-08d6b68b6538
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 10:18:33.3309 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5513
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Madalin-cristian Bucur <madalin.bucur@nxp.com>,
 Netdev <netdev@vger.kernel.org>, Roy Pledge <roy.pledge@nxp.com>,
 lkml <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Camelia Alexandra Groza <camelia.groza@nxp.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>, "moderated list:ARM/FREESCALE IMX /
 MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgTGVvLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExpIFlhbmcg
W21haWx0bzpsZW95YW5nLmxpQG54cC5jb21dDQo+IFNlbnQ6IFNhdHVyZGF5LCBNYXJjaCAzMCwg
MjAxOSAxMjowNyBBTQ0KPiBUbzogTGF1cmVudGl1IFR1ZG9yIDxsYXVyZW50aXUudHVkb3JAbnhw
LmNvbT4NCj4gQ2M6IE5ldGRldiA8bmV0ZGV2QHZnZXIua2VybmVsLm9yZz47IE1hZGFsaW4tY3Jp
c3RpYW4gQnVjdXINCj4gPG1hZGFsaW4uYnVjdXJAbnhwLmNvbT47IFJveSBQbGVkZ2UgPHJveS5w
bGVkZ2VAbnhwLmNvbT47IENhbWVsaWENCj4gQWxleGFuZHJhIEdyb3phIDxjYW1lbGlhLmdyb3ph
QG54cC5jb20+OyBEYXZpZCBNaWxsZXINCj4gPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBMaW51eCBJ
T01NVSA8aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc+Ow0KPiBtb2RlcmF0ZWQgbGlz
dDpBUk0vRlJFRVNDQUxFIElNWCAvIE1YQyBBUk0gQVJDSElURUNUVVJFIDxsaW51eC1hcm0tDQo+
IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgbGludXhwcGMtZGV2IDxsaW51eHBwYy1kZXZA
bGlzdHMub3psYWJzLm9yZz47DQo+IGxrbWwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDUvMTNdIHNvYy9mc2wvYnFtYW46IHBhZ2UgYWxpZ24g
aW9tbXUgbWFwcGluZyBzaXplcw0KPiBJbXBvcnRhbmNlOiBIaWdoDQo+IA0KPiBPbiBGcmksIE1h
ciAyOSwgMjAxOSBhdCA5OjAxIEFNIDxsYXVyZW50aXUudHVkb3JAbnhwLmNvbT4gd3JvdGU6DQo+
ID4NCj4gPiBGcm9tOiBMYXVyZW50aXUgVHVkb3IgPGxhdXJlbnRpdS50dWRvckBueHAuY29tPg0K
PiA+DQo+ID4gUHJpb3IgdG8gY2FsbGluZyBpb21tdV9tYXAoKS9pb21tdV91bm1hcCgpIHBhZ2Ug
YWxpZ24gdGhlIHNpemUgb3INCj4gPiBmYWlsdXJlcyBzdWNoIGFzIGJlbG93IGNvdWxkIGhhcHBl
bjoNCj4gPg0KPiA+IGlvbW11OiB1bmFsaWduZWQ6IGlvdmEgMHguLi4gcGEgMHguLi4gc2l6ZSAw
eDQwMDAgbWluX3BhZ2VzeiAweDEwMDAwDQo+ID4gcW1hbl9wb3J0YWwgNTAwMDAwMDAwLnFtYW4t
cG9ydGFsOiBmYWlsZWQgdG8gaW9tbXVfbWFwKCkgLTIyDQo+ID4NCj4gPiBTZWVuIHdoZW4gYm9v
dGVkIGEga2VybmVsIGNvbXBpbGVkIHdpdGggNjRLIHBhZ2Ugc2l6ZSBzdXBwb3J0Lg0KPiANCj4g
VGhpcyB3aWxsIHNpbGVudGx5IGluY2Vhc2UgdGhlIGFjdHVhbCBzcGFjZSBtYXBwZWQgdG8gNjRL
IHdoZW4gdGhlDQo+IGRyaXZlciBpcyBhY3R1YWxseSB0cnlpbmcgdG8gbWFwIDRLLiAgV2lsbCB0
aGlzIHBvdGVudGlhbGx5IGNhdXNlDQo+IHNlY3VyaXR5IGJyZWFjaGVzPyAgSWYgaXQgaXMgcmVh
bGx5IHNhZmUgdG8gbWFwIDY0SywgcHJvYmFibHkgdGhlDQo+IGJldHRlciB3YXkgaXMgdG8gaW5j
cmVhc2UgdGhlIHJlZ2lvbiBzaXplIHRvIDY0ayBpbiB0aGUgZGV2aWNlIHRyZWUNCj4gZXhwbGlj
aXRseS4NCg0KTm90IHN1cmUgaWYgc3VjaCBzbWFsbCByZXNlcnZlZCBhcmVhcyBhcmUgcHJhY3Rp
Y2FsLCBzbyBJIHdvdWxkbid0IHdvcnJ5IA0KbXVjaC4gQXMgYW4gZXhhbXBsZSwgY3VycmVudGx5
IG9uIGxzMTA0NmEgd2UgcmVzZXJ2ZSB0aGUgZm9sbG93aW5nIG1lbW9yeToNCmJtYW4gMTZNQiwg
cW1hbiBmcWQgOE1CLCBxbWFuIHBkZnIgMzJNQi4NCkJ1dCBqdXN0IHRvIGJlIG9uIHRoZSBzYWZl
IHNpZGUsIG1heWJlIHdlIGNvdWxkIGFkZCBhbiBlcnJvciBjaGVjayBmb3IgDQpkZXZpY2UgdHJl
ZXMgdGhhdCBzcGVjaWZ5IDwgNjRLQiByZXNlcnZlZCBtZW1vcnkuDQoNCi0tLQ0KQmVzdCBSZWdh
cmRzLCBMYXVyZW50aXUNCg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTGF1cmVudGl1IFR1ZG9y
IDxsYXVyZW50aXUudHVkb3JAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9zb2MvZnNs
L3FibWFuL2JtYW5fY2Nzci5jICAgfCAyICstDQo+ID4gIGRyaXZlcnMvc29jL2ZzbC9xYm1hbi9x
bWFuX2Njc3IuYyAgIHwgNCArKy0tDQo+ID4gIGRyaXZlcnMvc29jL2ZzbC9xYm1hbi9xbWFuX3Bv
cnRhbC5jIHwgMiArLQ0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9mc2wvcWJtYW4v
Ym1hbl9jY3NyLmMNCj4gYi9kcml2ZXJzL3NvYy9mc2wvcWJtYW4vYm1hbl9jY3NyLmMNCj4gPiBp
bmRleCBiMjA5Yzc5NTExYmIuLjNhNmUwMWJkZTMyZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L3NvYy9mc2wvcWJtYW4vYm1hbl9jY3NyLmMNCj4gPiArKysgYi9kcml2ZXJzL3NvYy9mc2wvcWJt
YW4vYm1hbl9jY3NyLmMNCj4gPiBAQCAtMjMwLDcgKzIzMCw3IEBAIHN0YXRpYyBpbnQgZnNsX2Jt
YW5fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gPiAgICAgICAgIC8q
IENyZWF0ZSBhbiAxLXRvLTEgaW9tbXUgbWFwcGluZyBmb3IgRkJQUiBhcmVhICovDQo+ID4gICAg
ICAgICBkb21haW4gPSBpb21tdV9nZXRfZG9tYWluX2Zvcl9kZXYoZGV2KTsNCj4gPiAgICAgICAg
IGlmIChkb21haW4pIHsNCj4gPiAtICAgICAgICAgICAgICAgcmV0ID0gaW9tbXVfbWFwKGRvbWFp
biwgZmJwcl9hLCBmYnByX2EsIGZicHJfc3osDQo+ID4gKyAgICAgICAgICAgICAgIHJldCA9IGlv
bW11X21hcChkb21haW4sIGZicHJfYSwgZmJwcl9hLA0KPiBQQUdFX0FMSUdOKGZicHJfc3opLA0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVfUkVBRCB8IElPTU1VX1dS
SVRFIHwgSU9NTVVfQ0FDSEUpOw0KPiA+ICAgICAgICAgICAgICAgICBpZiAocmV0KQ0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgIGRldl93YXJuKGRldiwgImZhaWxlZCB0byBpb21tdV9tYXAo
KSAlZFxuIiwNCj4gcmV0KTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvZnNsL3FibWFu
L3FtYW5fY2Nzci5jDQo+IGIvZHJpdmVycy9zb2MvZnNsL3FibWFuL3FtYW5fY2Nzci5jDQo+ID4g
aW5kZXggZWVjNzcwMDUwN2UxLi44ZDNjOTUwY2U1MmQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9zb2MvZnNsL3FibWFuL3FtYW5fY2Nzci5jDQo+ID4gKysrIGIvZHJpdmVycy9zb2MvZnNsL3Fi
bWFuL3FtYW5fY2Nzci5jDQo+ID4gQEAgLTc4MywxMSArNzgzLDExIEBAIHN0YXRpYyBpbnQgZnNs
X3FtYW5fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gPiAgICAgICAg
IC8qIENyZWF0ZSBhbiAxLXRvLTEgaW9tbXUgbWFwcGluZyBmb3IgZnFkIGFuZCBwZmRyIGFyZWFz
ICovDQo+ID4gICAgICAgICBkb21haW4gPSBpb21tdV9nZXRfZG9tYWluX2Zvcl9kZXYoZGV2KTsN
Cj4gPiAgICAgICAgIGlmIChkb21haW4pIHsNCj4gPiAtICAgICAgICAgICAgICAgcmV0ID0gaW9t
bXVfbWFwKGRvbWFpbiwgZnFkX2EsIGZxZF9hLCBmcWRfc3osDQo+ID4gKyAgICAgICAgICAgICAg
IHJldCA9IGlvbW11X21hcChkb21haW4sIGZxZF9hLCBmcWRfYSwNCj4gUEFHRV9BTElHTihmcWRf
c3opLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVfUkVBRCB8IElP
TU1VX1dSSVRFIHwgSU9NTVVfQ0FDSEUpOw0KPiA+ICAgICAgICAgICAgICAgICBpZiAocmV0KQ0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGRldl93YXJuKGRldiwgImlvbW11X21hcChmcWQp
IGZhaWxlZCAlZFxuIiwNCj4gcmV0KTsNCj4gPiAtICAgICAgICAgICAgICAgcmV0ID0gaW9tbXVf
bWFwKGRvbWFpbiwgcGZkcl9hLCBwZmRyX2EsIHBmZHJfc3osDQo+ID4gKyAgICAgICAgICAgICAg
IHJldCA9IGlvbW11X21hcChkb21haW4sIHBmZHJfYSwgcGZkcl9hLA0KPiBQQUdFX0FMSUdOKHBm
ZHJfc3opLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVfUkVBRCB8
IElPTU1VX1dSSVRFIHwgSU9NTVVfQ0FDSEUpOw0KPiA+ICAgICAgICAgICAgICAgICBpZiAocmV0
KQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGRldl93YXJuKGRldiwgImlvbW11X21hcChw
ZmRyKSBmYWlsZWQgJWRcbiIsDQo+IHJldCk7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29j
L2ZzbC9xYm1hbi9xbWFuX3BvcnRhbC5jDQo+IGIvZHJpdmVycy9zb2MvZnNsL3FibWFuL3FtYW5f
cG9ydGFsLmMNCj4gPiBpbmRleCBkZmI2MmY5ODE1ZTkuLmJjZTU2ZGEyYjAxZiAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL3NvYy9mc2wvcWJtYW4vcW1hbl9wb3J0YWwuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvc29jL2ZzbC9xYm1hbi9xbWFuX3BvcnRhbC5jDQo+ID4gQEAgLTI5Nyw3ICsyOTcsNyBA
QCBzdGF0aWMgaW50IHFtYW5fcG9ydGFsX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4g
KnBkZXYpDQo+ID4gICAgICAgICAgICAgICAgICAqLw0KPiA+ICAgICAgICAgICAgICAgICBlcnIg
PSBpb21tdV9tYXAoZG9tYWluLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
YWRkcl9waHlzWzBdLT5zdGFydCwgYWRkcl9waHlzWzBdLQ0KPiA+c3RhcnQsDQo+ID4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICByZXNvdXJjZV9zaXplKGFkZHJfcGh5c1swXSksDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQQUdFX0FMSUdOKHJlc291cmNlX3Np
emUoYWRkcl9waHlzWzBdKSksDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJ
T01NVV9SRUFEIHwgSU9NTVVfV1JJVEUgfCBJT01NVV9DQUNIRSk7DQo+ID4gICAgICAgICAgICAg
ICAgIGlmIChlcnIpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgZGV2X3dhcm4oZGV2LCAi
ZmFpbGVkIHRvIGlvbW11X21hcCgpICVkXG4iLA0KPiBlcnIpOw0KPiA+IC0tDQo+ID4gMi4xNy4x
DQo+ID4NCg==

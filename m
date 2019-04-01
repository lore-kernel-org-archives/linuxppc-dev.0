Return-Path: <SRS0=9RGo=SD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747BBC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 10:43:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A3B2086C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 10:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gSE/pGCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A3B2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Xppx3mpNzDqLc
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 21:43:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.13.70; helo=eur01-he1-obe.outbound.protection.outlook.com;
 envelope-from=laurentiu.tudor@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="gSE/pGCu"; 
 dkim-atps=neutral
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr130070.outbound.protection.outlook.com [40.107.13.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44XpnB03ZLzDqJg
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Apr 2019 21:42:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYwCsOhjnHh41RLFO/hzyn8Be3hTzdZISSl4Xwn4K7A=;
 b=gSE/pGCudXKxozH2aFoKgPVNwDwBnI7e4qXKsEwK1iZUzbJaXswro+TlQIRA3igaBYO2yy6+Pw8mlQ0wHPN+NQ/zvSb8zp90ewLEATS/qkz492T3RRdrwwHuSGJG2yfV2pjB8SwHThHW6Vw4psTLgma4oYHipnE98X+hGOTJ2Kk=
Received: from DB7PR04MB5132.eurprd04.prod.outlook.com (20.176.235.28) by
 DB7PR04MB5115.eurprd04.prod.outlook.com (20.176.235.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Mon, 1 Apr 2019 10:41:57 +0000
Received: from DB7PR04MB5132.eurprd04.prod.outlook.com
 ([fe80::2cac:cc2f:6528:54f7]) by DB7PR04MB5132.eurprd04.prod.outlook.com
 ([fe80::2cac:cc2f:6528:54f7%5]) with mapi id 15.20.1750.021; Mon, 1 Apr 2019
 10:41:57 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: "jocke@infinera.com" <joakim.tjernlund@infinera.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Madalin-cristian Bucur
 <madalin.bucur@nxp.com>, Leo Li <leoyang.li@nxp.com>, Roy Pledge
 <roy.pledge@nxp.com>, Camelia Alexandra Groza <camelia.groza@nxp.com>
Subject: RE: [PATCH 13/13] dpaa_eth: fix SG frame cleanup
Thread-Topic: [PATCH 13/13] dpaa_eth: fix SG frame cleanup
Thread-Index: AQHU5jfD8H5a3yiJYkiA2xDu3oDM/KYiutAAgARnYHA=
Date: Mon, 1 Apr 2019 10:41:56 +0000
Message-ID: <DB7PR04MB513254918C98E96E2E61E22CEC550@DB7PR04MB5132.eurprd04.prod.outlook.com>
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
 <20190329140014.8126-14-laurentiu.tudor@nxp.com>
 <702d2baba6c2c131c1ae59607943eb8f8813d250.camel@infinera.com>
In-Reply-To: <702d2baba6c2c131c1ae59607943eb8f8813d250.camel@infinera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5335750e-95b3-4ad0-ddb2-08d6b68ea9e3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DB7PR04MB5115; 
x-ms-traffictypediagnostic: DB7PR04MB5115:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB7PR04MB51158851B91D99DA224A3EF6EC550@DB7PR04MB5115.eurprd04.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(39860400002)(376002)(346002)(136003)(13464003)(189003)(199004)(97736004)(68736007)(14454004)(8936002)(33656002)(5660300002)(53936002)(55016002)(2501003)(9686003)(6636002)(25786009)(106356001)(81166006)(478600001)(8676002)(186003)(76176011)(7696005)(102836004)(6506007)(26005)(6246003)(7736002)(105586002)(305945005)(81156014)(3846002)(74316002)(476003)(6436002)(99286004)(44832011)(2906002)(486006)(66066001)(11346002)(6116002)(54906003)(110136005)(52536014)(4326008)(256004)(14444005)(71200400001)(71190400001)(316002)(86362001)(229853002)(446003)(491001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR04MB5115;
 H:DB7PR04MB5132.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hefFuGoIDSMMGDaCy2CuEyS2k4qWQchZavxn0Fp/kKOjrJ7NqpNs8NoC8QShLwDDzUhv55kSFL9kvv/lqgE8uv1s2eQk/rZpeKe+4WUAhOcxhhwAayChqDQ+ThwuMu845J36XFgu/mSejedmhk28/w5bGWXrJAQ41P5SuKg7cUwECz5cL0Hkkv+G4HA9rZVtKrWIZKSc2DpzGrv2p2hm9LZj/6MHGgmvPd8croH4HmvFcjoip9mqANSCxqi2f9I38J30l3QvDLjtwnlSoWvJp6DjjjqRp+01TfDWZThpZSuwUGENHT39mD0GnDDsTcjSNhBV73Qk7cGTnFrcMU/ZS8ehOqulhwI0vcwqgSHOTqXAjBGbiKsJ3mCD2MyzfCkkVot5M20XfmYRIlsTzgyZPAlvHAAJ9+wE3S+oGjUHtAM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5335750e-95b3-4ad0-ddb2-08d6b68ea9e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 10:41:56.9796 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5115
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
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "davem@davemloft.net" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgSm9ha2ltLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvYWtp
bSBUamVybmx1bmQgW21haWx0bzpKb2FraW0uVGplcm5sdW5kQGluZmluZXJhLmNvbV0NCj4gU2Vu
dDogRnJpZGF5LCBNYXJjaCAyOSwgMjAxOSA1OjI1IFBNPiANCj4gDQo+IFNob3VsZCB0aGlzIG9u
ZSBnbyBzdGFibGUgNC4xNC80LjE5IHRvbz8NCg0KR29vZCBwb2ludC4gSSBhbHNvIHRoaW5rIGl0
IG1ha2VzIHNlbnNlIHRvIGNjOiBzdGFibGUuDQoNCi0tLQ0KQmVzdCBSZWdhcmRzLCBMYXVyZW50
aXUNCg0KPiBPbiBGcmksIDIwMTktMDMtMjkgYXQgMTY6MDAgKzAyMDAsIGxhdXJlbnRpdS50dWRv
ckBueHAuY29tIHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogTGF1cmVudGl1IFR1ZG9yIDxsYXVyZW50
aXUudHVkb3JAbnhwLmNvbT4NCj4gPg0KPiA+IEZpeCBpc3N1ZSB3aXRoIHRoZSBlbnRyeSBpbmRl
eGluZyBpbiB0aGUgc2cgZnJhbWUgY2xlYW51cCBjb2RlIGJlaW5nDQo+ID4gb2ZmLWJ5LTEuIFRo
aXMgcHJvYmxlbSBzaG93ZWQgdXAgd2hlbiBkb2luZyBzb21lIGJhc2ljIGlwZXJmIHRlc3RzIGFu
ZA0KPiA+IG1hbmlmZXN0ZWQgaW4gdHJhZmZpYyBjb21pbmcgdG8gYSBoYWx0Lg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogTGF1cmVudGl1IFR1ZG9yIDxsYXVyZW50aXUudHVkb3JAbnhwLmNvbT4N
Cj4gPiBBY2tlZC1ieTogTWFkYWxpbiBCdWN1ciA8bWFkYWxpbi5idWN1ckBueHAuY29tPg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZHBhYS9kcGFhX2V0aC5j
IHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUv
ZHBhYS9kcGFhX2V0aC5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2RwYWEv
ZHBhYV9ldGguYw0KPiA+IGluZGV4IGRhZWRlNzI3Mjc2OC4uNDA0MjBlZGM5Y2U2IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9kcGFhL2RwYWFfZXRoLmMN
Cj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZHBhYS9kcGFhX2V0aC5j
DQo+ID4gQEAgLTE2NjMsNyArMTY2Myw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqZHBhYV9j
bGVhbnVwX3R4X2ZkKGNvbnN0DQo+IHN0cnVjdCBkcGFhX3ByaXYgKnByaXYsDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcW1fc2dfZW50cnlfZ2V0X2xlbigmc2d0WzBdKSwg
ZG1hX2Rpcik7DQo+ID4NCj4gPiAgICAgICAgICAgICAgICAgLyogcmVtYWluaW5nIHBhZ2VzIHdl
cmUgbWFwcGVkIHdpdGggc2tiX2ZyYWdfZG1hX21hcCgpDQo+ICovDQo+ID4gLSAgICAgICAgICAg
ICAgIGZvciAoaSA9IDE7IGkgPCBucl9mcmFnczsgaSsrKSB7DQo+ID4gKyAgICAgICAgICAgICAg
IGZvciAoaSA9IDE7IGkgPD0gbnJfZnJhZ3M7IGkrKykgew0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgIFdBUk5fT04ocW1fc2dfZW50cnlfaXNfZXh0KCZzZ3RbaV0pKTsNCj4gPg0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgIGRtYV91bm1hcF9wYWdlKGRldiwgcW1fc2dfYWRkcigmc2d0
W2ldKSwNCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+DQoNCg==

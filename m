Return-Path: <SRS0=/GF9=P6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0169FC282C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 11:42:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F0BE20879
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 11:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N6BsXSPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0BE20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kRN515qFzDqNl
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 22:41:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.3.45; helo=eur03-am5-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="N6BsXSPR"; 
 dkim-atps=neutral
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30045.outbound.protection.outlook.com [40.107.3.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kRKc3GyQzDqMl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 22:39:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sE+lRYzy+iZjoT+44DvbSFnYeKLKJo45RC3pukq9gns=;
 b=N6BsXSPRyX5NNmjXArLs11waxRn6+eMrUwo7vxJutGtpnggOngkq5Tw5DvtpyxRN6kCd9e2cB5xrFqyeYzkvAdMDa+pRaSQHm9BWWzDt86GMH8OoVPUfgsjUkrdqn0yR85LQyYFNJUcB+2mWin1sKzZcK+HVSZIEZbHju325QEI=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB1679.eurprd04.prod.outlook.com (10.164.85.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Tue, 22 Jan 2019 11:39:39 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::e58a:8812:d380:2080]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::e58a:8812:d380:2080%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 11:39:39 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: "robh@kernel.org" <robh@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 0/4] Add NXP AUDMIX device and machine drivers
Thread-Topic: [PATCH v3 0/4] Add NXP AUDMIX device and machine drivers
Thread-Index: AQHUrmKoQmEVxQazyE68ciNiNCuyvqWzo60AgAFfkwCAAG0MAIAEbXuAgAFTwwA=
Date: Tue, 22 Jan 2019 11:39:39 +0000
Message-ID: <1548157178.13051.19.camel@nxp.com>
References: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
 <20190117161804.GA5760@bogus> <1547817384.11482.33.camel@nxp.com>
 <20190118194642.GA11798@Asurada-Nvidia.nvidia.com>
 <20190121152335.GA12284@bogus>
In-Reply-To: <20190121152335.GA12284@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB1679;
 6:fJqcMOtwW+Hay/XMc/h/J4FJ2libK2XOfzuE81OUR65K3Eq4bWe/xmetA/gORnJyZpfBeRV3oeal5SbDGfUlDzqzGzf4eemQZFvy7ZVBbCznSQH3HtyPjCY+btyo9DUCSvk/Kl3y7E1A3OEtqLiLhXjOccXS/uyrWia3bjZL4FhIqJye0T4uYKCSqDJLDpB77beUwtsQd5mss6C9sVWAweasI2PUQLJtng2xGnByh6tU3mHebnj4cjVRNsuV6QTiKNhAGf2EgkMhmHgppBW1f02bdX22S2VlAad9/6Ddo41sPueHefTUDybGrDw3FgQ9G2XCRgxO9mU9fJQ47TvmKpTfGxCPY0YPg3kh/OtGtMe8DIxM1v+nBj3JaHLcFRHQgl7KzMXzOKR8w5SIxDrhs1grlGWpai+yDkF4v1w8tFzWUqbFu9a3deqd0Nbp4ReZm4vA8zq3VRso5lbnsj5XpA==;
 5:qXuLI8ndoEtofpDPKQTNuP7BY/Dj3PaonFgqWfgN/R//IXqyQu6GxCbzj4S+9PzKHBYzjUCe+XLg09ZltUG86TA/sGNniwpgVyAH5k/QPOeEi4E7Ikv2+W9ac3WIYm0wSQ6AFiHpNFDAGcTgIzmjcUImZZBt7/0Py7ZcSyjFJwkQQwoynGuyUTcm0eI6XqA179PpjGaACkWe1ik3W0TZ6w==;
 7:dRF1OIDVkNgUR5VbxzRHjqWV0BWsbSAQDv/fRLe5XWe+YJWgxFviIfpjvaJeGMXGte/7e1EhntwHLsy/tQBZWqc9zq99WZH7SZJ+Np4tFjDC6OKFE8Mq/CIGMjncjFgRolt3Qcec76DgAVSoh2kJXg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 68ff5208-42be-4c74-af2f-08d6805e4b06
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB1679; 
x-ms-traffictypediagnostic: VI1PR04MB1679:
x-microsoft-antispam-prvs: <VI1PR04MB1679F6A10D5E0CCFCA094C6E92980@VI1PR04MB1679.eurprd04.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(366004)(346002)(376002)(39860400002)(51444003)(199004)(189003)(6436002)(478600001)(229853002)(26005)(186003)(86362001)(44832011)(4326008)(68736007)(71200400001)(71190400001)(6116002)(3846002)(6486002)(446003)(76176011)(6506007)(39060400002)(6246003)(25786009)(102836004)(14454004)(476003)(2616005)(53936002)(11346002)(6512007)(486006)(2501003)(36756003)(54906003)(93886005)(305945005)(316002)(2906002)(110136005)(8936002)(81156014)(81166006)(256004)(103116003)(99286004)(66066001)(105586002)(106356001)(217873002)(7416002)(97736004)(7736002)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB1679;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LoXgicwgGAIsBxx4kPH0GEP8gsBTRM9hlTkLX0Y2sEsJR+/RwVVBqhm7C7x+PVy7+jFgcjlHT6rZtDcKdxtNhUIWON3BhFB1qSjj1vtzR5XMNHhCJN0O3quk2SrBkudhNtvU8jzsC2InQbL1Yf4vWfIzWcQhXlkGBu2XqaFqrxZJJkPDpTlARECG8xcEfDwgqiC9sOC0LW1wHcM5auztezSVM1LqTEvqVfIHXY8KOIYCGn1Bh5KdgKjtfU342IzodZ2fsHFZ4csIbWSq4XTnHA6UvyUsyG7Ah6dT2RdaQ/vxfPjlnYROHy3Op1ZFpGBLRwfDIYyZjKNwo34if3PBgRQ2TxiFm+wGjAs/Mxl5PWSJ5mBXrDsuxk/BmIxvXjlyPztcBtfEIYrd+BcYptTV+Y21+ML+GfRCUrgPE8lkwZ0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <105BF5F48250E64DBF5FAE64C9C627EE@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ff5208-42be-4c74-af2f-08d6805e4b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 11:39:39.2108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1679
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "S.j. Wang" <shengjiu.wang@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Daniel Baluta <daniel.baluta@nxp.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "viorel.suman@gmail.com" <viorel.suman@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Cosmin Samoila <cosmin.samoila@nxp.com>, "perex@perex.cz" <perex@perex.cz>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgUm9iLA0KDQpPbiBMdSwgMjAxOS0wMS0yMSBhdCAwOToyMyAtMDYwMCwgUm9iIEhlcnJpbmcg
d3JvdGU6DQo+IE9uIEZyaSwgSmFuIDE4LCAyMDE5IGF0IDExOjQ2OjQyQU0gLTA4MDAsIE5pY29s
aW4gQ2hlbiB3cm90ZToNCj4gPiANCj4gPiBPbiBGcmksIEphbiAxOCwgMjAxOSBhdCAwMToxNjoy
NFBNICswMDAwLCBWaW9yZWwgU3VtYW4gd3JvdGU6DQo+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gMS4gTW92ZWQgImRhaXMiIG5vZGUgZnJvbSBtYWNoaW5lIGRyaXZlciBE
VFMgbm9kZSB0byBkZXZpY2UNCj4gPiA+ID4gPiBkcml2ZXINCj4gPiA+ID4gPiBEVFMgbm9kZQ0K
PiA+ID4gPiA+IMKgIGFzIHN1Z2dlc3RlZCBieSBSb2IuDQo+ID4gPiA+IFRoYXQgd2FzIG5vdCB3
aGF0IEkgc3VnZ2VzdGVkLiBZb3Ugc3RpbGwgaGF2ZSBhIHZpcnR1YWwgbm9kZQ0KPiA+ID4gPiB3
aGljaA0KPiA+ID4gPiBsb29rcyB0byBtZSB0byBiZSB1bm5lY2Vzc2FyeS4NCj4gPiA+IFRvIG1l
IHJlbW92aW5nIHZpcnR1YWwgbm9kZSBpbXBsaWVzIHRoYXQgQVVETUlYIG1hY2hpbmUgZHJpdmVy
DQo+ID4gPiAoaW14LQ0KPiA+ID4gYXVkbWl4LmMgKyB2aXJ0dWFsIG5vZGUpIHNoYWxsIGJlIHJl
bW92ZWQgYW5kIG1hY2hpbmUgZHJpdmVyIGNvZGUNCj4gPiA+IG1lcmdlZCBpbnRvIGRldmljZSBk
cml2ZXIgKGZzbF9hdWRtaXguYyArIGRldmljZSBub2RlKSAtIHBsZWFzZQ0KPiA+ID4gbGV0IG1l
DQo+ID4gPiBrbm93IGlmIG15IHVuZGVyc3RhbmRpbmcgaXMgd3JvbmcuDQo+ID4gV2UgY291bGQg
dXNlIGEgbm9uLURUIGNvbmZpZ3VyYXRpb24gcmlnaHQ/IEZyb20gdGhlIGRyaXZlciBsb2dpYywN
Cj4gPiBEVCBqdXN0IHJlZ2lzdGVycyBhIGRldmljZSBjb3JyZXNwb25kaW5nIHRvIHRoZSBtYWNo
aW5lIGRyaXZlciBzbw0KPiA+IHRoYXQgaXQgY2FuIHByb2JlKCkuIFdlIGNvdWxkIHJlZ2lzdGVy
IG9uZSBpbiBmc2xfYXVkbWl4IGluc3RlYWQuDQo+ID4gUGxlYXNlIHJlZmVyIHRvIGhvdyBmc2xf
c3NpIHJlZ2lzdGVycyB0aGUgc291bmQgY2FyZCBkZXZpY2UuIFRoZQ0KPiA+IG1hY2hpbmUgZHJp
dmVyIGNhbiBnZXQgYXVkbWl4X25wIGZyb20gdGhlIHBhcmVudCBkZXZpY2UgcG9pbnRlciwNCj4g
PiBhbmQgSSB0aGluayB0aGF0J3MgYWxsIHlvdSBuZWVkLg0KPiBZZXMuDQoNClRoYW5rIHlvdSwg
c2VudCBWNCB3aGljaCBpbXBsZW1lbnRzIHRoZSBhcHByb2FjaCBzdWdnZXN0ZWQgYnkgTmljb2xp
bi4NCg0KPiANCj4gPiANCj4gPiBPciBtYXliZSBzb21lb25lIGVsc2Ugd291bGQgcHJvdmlkZSBh
IGJldHRlciB3YXkuIEJ1dCBpdCdkIHdvcmsuDQo+IE9yIHRoZSBtYWNoaW5lIGRyaXZlciBjb3Vs
ZCBjcmVhdGUgdGhlIGF1ZG1peCBkZXZpY2UuIFRoYXQgcHJvYmFibHnCoA0KPiBtYWtlcyBsZXNz
IHNlbnNlLCBidXQgZWl0aGVyIHdheSB0aGVyZSBkb2Vzbid0IGhhdmUgdG8gYmUgYSAxLTHCoA0K
PiBjb3JyZXNwb25kZW5jZSBvZiBEVCBub2RlcyBhbmQgKHBsYXRmb3JtKSBkZXZpY2VzLg0KPiAN
Cj4gSSdtIG5vdCBhbiBBU29DIGV4cGVydCwgYnV0IHdoeSBjYW4ndCB0aGUgbWFjaGluZSBkcml2
ZXIganVzdCBjb250cm9sDQo+IHRoZSBhdWRtaXggZGlyZWN0bHkgKHdpdGggREFJcyBhcyBzZXBh
cmF0ZSBkcml2ZXJzKT8gSXMgdGhlIGF1ZG1peA0KPiBldmVyIGdvaW5nIHRvIGEgYmUgYSBjb21w
b25lbnQgZm9yIGEgZGlmZmVyZW50IG1hY2hpbmUgZHJpdmVyPw0KPiANCj4gUm9iDQoNCkN1cnJl
bnRseSBJJ20gbm90IGF3YXJlIG9mIGFueSBpbmZvcm1hdGlvbiB3aXRoIHJlZ2FyZCB0byBpZiBh
dWRtaXggaXMNCmV2ZXIgZ29pbmcgdG8gd29yayB3aXRoIG90aGVyIERBSXMgdGhhbiBTQUkuIEhv
d2VydmVyIGZyb20gYXVkbWl4IElQDQpibG9jayBpbnRlZ3JhdGlvbiBwZXJzcGVjdGl2ZSB0aGUg
b25seSByZXF1aXJlbWVudCBpcyB0aGF0IHRoZSBpbnB1dA0KREFJIG11c3QgYmUgY29ubmVjdGVk
IHRvIGF1ZG1peCBvdmVyIEkyUyBidXMsIHBvc3NpYmxlIERBSSBvcHRpb25zIGFyZQ0KU0FJLCBF
U0FJLCBldGMgLSBJIHRoaW5rIHRoZSBhcHByb2FjaCB0byBtaXggYm90aCBkZXZpY2UgYW5kIG1h
Y2hpbmUNCmRyaXZlcnMgaW50byBhIHNpbmdsZSBlbnRpdHkgaXMgbm90IHRoZSBiZXN0IHdheSB0
byBnby4NCg0KL1Zpb3JlbA==

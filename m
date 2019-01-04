Return-Path: <SRS0=Lr1k=PM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C084DC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 08:53:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A21A206C0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 08:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="E9IdMAnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A21A206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43WJVQ1dHhzDqM1
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 19:53:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.4.44; helo=eur03-db5-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="E9IdMAnF"; 
 dkim-atps=neutral
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr40044.outbound.protection.outlook.com [40.107.4.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43WJSh0LxWzDqFS
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 19:52:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGawG63QStCosIWpOBxiNfENII8JFveF9uin25RI5JE=;
 b=E9IdMAnFQ+F3aVaIGO/Jt+0xIiSddOov2v/j37AV3GiNaefA8pttxN6qhHr8Oc/yzHopvb+xPP71zWYRB+100d0MlozX6WS7vka4IN3NANZnTnYIpyUEXpQdzSuIupde6mftNnYCAG5rIMMeAQHMftJHE1Mdu7+qmPlXnAvXg+0=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB6015.eurprd04.prod.outlook.com (20.178.124.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Fri, 4 Jan 2019 08:52:10 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::ad47:75b9:3ed8:51f0]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::ad47:75b9:3ed8:51f0%6]) with mapi id 15.20.1495.005; Fri, 4 Jan 2019
 08:52:10 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>
Subject: Re: [RFC PATCH] ASoC: fsl: Add Audio Mixer CPU DAI driver
Thread-Topic: [RFC PATCH] ASoC: fsl: Add Audio Mixer CPU DAI driver
Thread-Index: AQHUlu7sas942UE1M06TLvqfe6BTx6WRUdAAgAx6LQCAAETjgIAA1tAA
Date: Fri, 4 Jan 2019 08:52:10 +0000
Message-ID: <1546591930.30300.13.camel@nxp.com>
References: <1545150569-14897-1-git-send-email-viorel.suman@nxp.com>
 <CAGoOwPQvc5w05NOVsp6Qw-Ee3CJJCcaU2Dtzwbf+7bUe_kFEbA@mail.gmail.com>
 <1546531006.14398.83.camel@nxp.com>
 <20190103200319.GA2586@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190103200319.GA2586@Asurada-Nvidia.nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB6015;
 6:8vujb5coyryKKAm2nbVQ84BxekQqgdXVWMhnuXVctY9ZAY5ydVWEB/YT0J2byF/xqRiF5R5atc87s2bSub/RMWLsUIOPff6o0NcSQs2k1af7iczahoAzcyTzGEyeYLe+BPboXOD0FVDb8KVRdvYm9zCK6ImAxHs7GIEwOjlLJLHn7RFl7pT9JgzaUWSGDy8fxbKZqd9vGLfVCRbKzNtuHCJSdmjtP33faJGvrahOXHkz/2hxN5CJTzN5Kgg+F5YAATXFZ0HqnF80hAPNQv2vgc/XSYbMAD+lvfZ172T6xQbNep75OzpqYMzpXxF9L2wdRmd1/vY40bh4AH3dhSbw+IjsyHs74F0eoAFb2euDgRJFRah44755JyKpTd5mzEyrMytJ5/f/59xjidHsaKESqzV6wrHeP6ljWyZrqyA6oAIxp6NsAN6U2d3S3d5wB5qDsh5rVtbl/5LFOIXszrSguw==;
 5:eurayAHEIOiJ/bqj6XiRSQUMz2XaDjZdRchai8QYoke1Hu/3eyiVcyvDpf8cd2Ilkes6oHD58J+uav3aTdKkMptiv3f3NEqm71zOAtXsDToCyeeLlROpWxqKsT2hmXv2FRzUGbVdAdrhUahQHSDzyp8SS4h7yT2O3qGh40YfQa8a00Jm7TRDitZxfVBNuUMiPiKpVm5RKqi4c7UkqAKofQ==;
 7:Tdis+8e6JKBTCgyCE45I3uYtC86GHL0MaKQas5ItMlPDBsfP6rkVwcL0ttyL85K4GG/W/lPqgg9s6qMaUF1xJknd66BFpizPQgcWt8mybVbffb8P+5gGlMuC6KS0kP4sORFwMTVakm49kC68e0gsOw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 72e6a198-8e8f-47b5-6a6a-08d67221ea27
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB6015; 
x-ms-traffictypediagnostic: VI1PR04MB6015:
x-microsoft-antispam-prvs: <VI1PR04MB601596FCF3823AB61713DA29928E0@VI1PR04MB6015.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB6015; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB6015; 
x-forefront-prvs: 0907F58A24
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(376002)(396003)(346002)(366004)(189003)(199004)(186003)(4326008)(106356001)(105586002)(25786009)(6916009)(66066001)(6246003)(39060400002)(6506007)(26005)(217873002)(316002)(7736002)(81156014)(1730700003)(54906003)(93886005)(305945005)(1411001)(14454004)(8676002)(102836004)(8936002)(81166006)(2906002)(446003)(2351001)(476003)(2616005)(68736007)(103116003)(1361003)(11346002)(5660300001)(36756003)(6436002)(6486002)(6512007)(486006)(478600001)(7416002)(86362001)(2501003)(97736004)(5640700003)(99286004)(71190400001)(6116002)(3846002)(53936002)(229853002)(71200400001)(44832011)(76176011)(256004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB6015;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: waRQjccH05gcFTSb5jXC8t1RivmclUouwWlxgzjP88qAB7krVL8q2/3SVoiufvhwjFX2TdGGsUC3bifMr63DC8zCduO62VIYv17KlZMxGRKE7iRDrRVL+KX8o+zxYNuWPL26dDn4LeA9OEy+DWVm+N01DJ78u+MvCWzC0CCV1wDCw5PM7EMe2AsO9F7lb6+OrfIgHZr1Qp4vpWx1U16PWX3Vlayox6b2u68+rqXaInzJ1ixTBxtjl7Xxi76BPkgyiiyfKWvcJGELxMe2VFItQ5V4A24s9Pf9eP+DlHDvvJClgo+ioeuduzTF+RgpIZ7E
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0422201DECF07843838F431D469F3788@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e6a198-8e8f-47b5-6a6a-08d67221ea27
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2019 08:52:10.6291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6015
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
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Daniel Baluta <daniel.baluta@nxp.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, "perex@perex.cz" <perex@perex.cz>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgTmljb2xpbiwNCg0KT24gSm8sIDIwMTktMDEtMDMgYXQgMTI6MDMgLTA4MDAsIE5pY29saW4g
Q2hlbiB3cm90ZToNCj4gSGksDQo+IA0KPiBPbiBUaHUsIEphbiAwMywgMjAxOSBhdCAwMzo1Njo0
NlBNICswMDAwLCBWaW9yZWwgU3VtYW4gd3JvdGU6DQo+ID4gDQo+ID4gPiANCj4gPiA+ID4gDQo+
ID4gPiA+IMKgc291bmQvc29jL2ZzbC9mc2xfYW1peC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfCA1NTQNCj4gPiA+ID4gKysrKysrKysrKysr
KysrKysrKysrDQo+ID4gPiA+IMKgc291bmQvc29jL2ZzbC9mc2xfYW1peC5owqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfCAxMDEgKysrKw0KPiA+
ID4gSSBhaW1uJ3QgYWdhaW5zdCB0aGUgbmFtaW5nIGhlcmUsIGJ1dCBpdCBzZWVtcyB0byBiZSBB
VURNSVggaW4NCj4gPiA+IFJNPw0KPiA+ID4gDQo+ID4gPiBXb3VsZCBpdCBiZSBiZXR0ZXIgdG8g
YWxpZ24gd2l0aCB0aGF0PyBJdCdzIHlvdXIgZGVjaXNpb24gdGhvdWdoLg0KPiA+IFRvIG1lICJB
VURNSVgiIHNvdW5kcyBtb3JlIGxpa2Ugc29tZSBSVEwgaGlnaCBsZXZlbCBpbnRlZ3JhdGlvbg0K
PiA+IG1vZHVsZSwNCj4gPiBJIHdvdWxkIHByZWZlciB0byBrZWVwIGl0IGFzIGl0IGlzIGlmIHRo
ZXJlIGlzIG5vIHN0cm9uZyByZWFzb24gdG/CoA0KPiA+IHJlbmFtZSBpdC4NCj4gV2UgaGFkIEFV
RE1VWCwgc28gIkFVRE1JWCIgZG9lc24ndCBzb3VuZCBiYWQgdG8gbWUgYXQgYWxsLiBUaGUgb25s
eQ0KPiByZWFzb24gdGhhdCB3ZSBhcmUgZGlzY3Vzc2luZyB0aGlzIGlzIGJlY2F1c2UgUk0gdXNl
cyBtb3JlICJBVURNSVgicw0KPiBvdmVyICJhbWl4InMuIEknZCBoYXZlIGNob3NlbiBBVURNSVgg
aWYgSSB3ZXJlIHlvdSwgeWV0IG5vdCBzdHJvbmdseQ0KPiBhcyBJIHNhaWQuIEFuZCBpdCBsb29r
cyBsaWtlIFJvYiBpcyBhc2tpbmcgeW91IHRvIHVzZSBBVURNSVggaW4gRFQNCj4gYmluZGluZyBk
b2MuDQoNCk9rLCBJJ2xsIGNoYW5nZSBpbiB0aGUgbmV4dCB2ZXJzaW9uIHRoZSBjb21wYXRpYmxl
IHN0cmluZyB0byAiYXVkbWl4Ig0KYXMgUm9iIHJlcXVlc3RlZC4NCg0KPiANCj4gPiANCj4gPiA+
IA0KPiA+ID4gPiANCj4gPiA+ID4gK0RldmljZSBkcml2ZXIgY29uZmlndXJhdGlvbiBleGFtcGxl
Og0KPiA+ID4gPiArPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPiA+
ID4gK8KgwqBhbWl4OiBhbWl4QDU5ODQwMDAwIHsNCj4gPiA+ID4gK8KgwqDCoMKgY29tcGF0aWJs
ZSA9ICJmc2wsaW14OHFtLWFtaXgiOw0KPiA+ID4gPiArwqDCoMKgwqByZWcgPSA8MHgwIDB4NTk4
NDAwMDAgMHgwIDB4MTAwMDA+Ow0KPiA+ID4gPiArwqDCoMKgwqBjbG9ja3MgPSA8JmNsayBJTVg4
UVhQX0FVRF9BTUlYX0lQRz47DQo+ID4gPiA+ICvCoMKgwqDCoGNsb2NrLW5hbWVzID0gImlwZyI7
DQo+ID4gPiA+ICvCoMKgwqDCoHBvd2VyLWRvbWFpbnMgPSA8JnBkX2FtaXg+Ow0KPiA+ID4gPiAr
wqDCoH07DQo+ID4gPiBGcm9tIHRoZSBkZXNjcmlwdGlvbiBvZiBEVCBhbmQgUk0sIEkgZG9uJ3Qg
c2VlIGhvdyBpdCBjb25uZWN0cyB0bw0KPiA+ID4gU0FJcy4NCj4gPiA+IA0KPiA+ID4gQXJlIHRo
ZXkgZml4ZWQgdG8gU0FJMCBhbmQgU0FJMSBpbiBpbXg4cW0/IFdvbmRlcmluZyBpZiBpdCdkIGJl
DQo+ID4gPiBiZXR0ZXIgdG8gaGF2ZSBzdWNoIGluZm9ybWF0aW9uIGluIHRoZSBkb2MuDQo+ID4g
UGxlYXNlIGNoZWNrIGNoYXB0ZXIgIjE2LjEuMi4yIEF1ZGlvIE1peGVyIiBpbiBSTTogaXQgaGFz
IHR3bw0KPiA+IGRlZGljYXRlZA0KPiA+IFNBSSBpbnRlcmZhY2VzLCBTQUk0IGFuZCBTQUk1LiBB
dWRpbyBNaXhlciBvcGVyYXRlcyBvbiBiaXQgY2xvY2sgb2YNCj4gPiBvbmUNCj4gPiBvZiB0aGVz
ZSBpbnRlcmZhY2VzLg0KPiBPSy4gSSBhbSBhY3R1YWxseSBtb3JlIHdvbmRlcmluZyBob3cgeW91
IGNvbm5lY3QgaXQgd2l0aCBTQUkgb24NCj4gdGhlIHNvZnR3YXJlIGxldmVsOiBmb3IgaW14OHFt
LCBTQUk0LzUgYXJlIHVzZWQsIGJ1dCBsYXRlciBTb0NzDQo+IG1pZ2h0IHVzZSBvdGhlciBTQUkg
YmxvY2tzLiBTbyBpdCBtaWdodCBiZSBuZWNlc3NhcnkgdG8gaW5kaWNhdGUNCj4gdGhlIGNvbm5l
Y3Rpb25zIGluIERULg0KDQpTZWUgYmVsb3cuDQoNCj4gDQo+ID4gDQo+ID4gPiANCj4gPiA+ID4g
DQo+ID4gPiA+ICtzdGF0aWMgaW50IGZzbF9hbWl4X2RhaV9zZXRfZm10KHN0cnVjdCBzbmRfc29j
X2RhaSAqZGFpLA0KPiA+ID4gPiB1bnNpZ25lZA0KPiA+ID4gPiBpbnQgZm10KQ0KPiA+ID4gPiAr
ew0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAvKiBGb3IgcGxheWJhY2sgdGhlIEFNSVggaXMgc2xh
dmUsIGFuZCBmb3IgcmVjb3JkIGlzDQo+ID4gPiA+IG1hc3Rlcg0KPiA+ID4gPiAqLw0KPiA+ID4g
PiArwqDCoMKgwqDCoMKgwqBzd2l0Y2ggKGZtdCAmIFNORF9TT0NfREFJRk1UX01BU1RFUl9NQVNL
KSB7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoGNhc2UgU05EX1NPQ19EQUlGTVRfQ0JNX0NGTToN
Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgY2FzZSBTTkRfU09DX0RBSUZNVF9DQlNfQ0ZTOg0KPiA+
ID4gU28gaXQncyB1c2VkIGVpdGhlciBmb3IgcGxheWJhY2sgb3IgY2FwdHVyZSBvbmx5LCBub3Qg
Ym90aCBhdA0KPiA+ID4gc2FtZQ0KPiA+ID4gdGltZT8NCj4gPiBGcm9tIElQIGZ1bmN0aW9uYWwg
cGVyc3BlY3RpdmUgQU1JWCBjYXB0dXJlIGlzIHRoZSByZXN1bHQgb2YgQU1JWA0KPiA+IHBsYXli
YWNrIC0gQU1JWCBvdXRwdXQgcmVwcmVzZW50cyB0aGUgcmVzdWx0aW5nIG1peGVkIGF1ZGlvIHN0
cmVhbQ0KPiA+IHJvdXRlZCB0byBTQUk0IFJYIHNpZ25hbHMgKGJpdCAmIGZyYW1lIGNsb2NrcyBh
bmQgZGF0YSkuIFNvIG9uY2Ugd2UNCj4gPiBoYXZlIHBsYXliYWNrIG9uIGVpdGhlciBTQUk0IG9y
IFNBSTUgKG9yIGJvdGgpIC0gd2UgY2FuIGNhcHR1cmUgdGhlDQo+ID4gQU1JWCBvdXRwdXQgb24g
U0FJNC4NCj4gQWgsIGl0IHNvdW5kcyBsaWtlIGEgbG9vcGluZyBibG9jayB0aGVuLCByZWNlaXZp
bmcgYmNsayBmcm9tIFNBSTQNCj4gLS0gc2xhdmUsIGFuZCByb3V0aW5nIHRoZSBiY2xrIGJhY2sg
dG8gU0FJNCAtLSBtYXN0ZXI7IFNBSTQgd29ya3MNCj4gYXQgQVNZTkMgbW9kZT8NCg0KUmlnaHQu
IEFuZCB5ZXMsIFNBSTQgd29ya3MgaW4gQVNZTkMgbW9kZS4NCg0KPiANCj4gPiANCj4gPiBJIGd1
ZXNzIGl0IHdvdWxkIGJlIG5pY2UgdG8gc2VuZCB0aGUgbWFjaGluZSBkcml2ZXIgYXMgcGFydCBv
ZiB0aGlzDQo+ID4gcGF0Y2hzZXQgYWxzbyAtIGl0IGRlZmluZXMgdHdvIGlucHV0IFNBSSBpbnRl
cmZhY2VzIGFzIGZyb250ZW5kcw0KPiA+IGFuZA0KPiA+IEFNSVggLSBhcyBiYWNrZW5kLiBVc2Vy
c3BhY2Ugc2VlcyBvbmx5IHR3byBTQUkgaW50ZXJmYWNlcyBleHBvc2VkLA0KPiA+IGJvdGgNCj4g
PiBvZiB0aGVtIGhhdmluZyBwbGF5YmFjayBlbmFibGVkLCBhbmQgb25seSBTQUk0IGhhdmluZyBj
YXB0dXJlDQo+ID4gZW5hYmxlZC4NCj4gRFBDTT8gU28geW91IGFyZSBoYXZpbmcgdGhlIGxpbmtz
IGluIHRoZSBzb3VuZCBEVCBub2RlcywgaS5lLiB0aGUNCj4gbWFjaGluZSBkcml2ZXI/DQoNClRo
ZSBtYWNoaW5lIGRyaXZlciBEVCBjb25maWd1cmF0aW9uIGxvb2tzIGxpa2U6DQo9PT09PT09PT09
PT09PT09DQpzb3VuZC1hbWl4LXNhacKgew0KwqAgY29tcGF0aWJsZSA9ICJmc2wsaW14LWF1ZGlv
LWFtaXgiOw0KwqAgbW9kZWwgPSAiYW1peC1hdWRpby1zYWkiOw0KwqAgZGFpcyA9IDwmc2FpND4s
IDwmc2FpNT47DQrCoCBhbWl4LWNvbnRyb2xsZXIgPSA8JmFtaXg+Ow0KfTsNCg0KVGhlIG51bWJl
ciBvZiBlbGVtZW50cyBpbiAiZGFpcyIgYXJyYXkgaXMgYXQgbGVhc3QgdHdvIGVsZW1lbnRzLCBE
QVBNDQpyb3V0ZXMgYXJlIGdlbmVyYXRlZCBkeW5hbWljYWxseSBpbiBtYWNoaW5lIGRyaXZlciBh
dCBwcm9iZSBhcyBmdW5jdGlvbg0Kb2YgbnVtYmVyIG9mIFNBSSBpbnN0YW5jZXMsIHRoZSBjYXB0
dXJlIGlzIGVuYWJsZWQgb25seSBmb3IgdGhlIGZpcnN0DQpTQUkgaW5zdGFuY2UgaW4gdGhlIGxp
c3QuDQoNCj4gDQo+IFRoYW5rcw0KPiBOaWNvbGluDQoNClJlZ2FyZHMsDQpWaW9yZWw=

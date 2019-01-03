Return-Path: <SRS0=6Lu7=PL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C752C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 13:49:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B6E421479
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 13:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lunNw5aB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6E421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Vq5X0Y1DzDqM4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 00:49:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.7.81; helo=eur04-he1-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="lunNw5aB"; 
 dkim-atps=neutral
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70081.outbound.protection.outlook.com [40.107.7.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Vq3h3z52zDqFD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 00:47:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLw9HlKF7ANpTdoQgsbLSJiqUJMdlqWWEDfEZQKM2XY=;
 b=lunNw5aBT6CYVHijjyjTR7WlQZQ2L7GdthhNZa4ei9kuwXkDMqAmxJokyE73EAlfs0V8s7Sbg4+J+sWyR3MZtmh9JBy/M1BTP6ABHGARFnOjNTWc1GxvXUiMx1UoKnA51w+d34fxOow2QjXIi3bEW/9Ba7cHxhmScKsbeEhnX2I=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB4942.eurprd04.prod.outlook.com (20.177.49.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 3 Jan 2019 13:47:16 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::ad47:75b9:3ed8:51f0]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::ad47:75b9:3ed8:51f0%6]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 13:47:16 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: "robh@kernel.org" <robh@kernel.org>
Subject: Re: [RFC PATCH] ASoC: fsl: Add Audio Mixer CPU DAI driver
Thread-Topic: [RFC PATCH] ASoC: fsl: Add Audio Mixer CPU DAI driver
Thread-Index: AQHUlu7sas942UE1M06TLvqfe6BTx6WU3VAAgAjJqYA=
Date: Thu, 3 Jan 2019 13:47:16 +0000
Message-ID: <1546523057.6408.8.camel@nxp.com>
References: <1545150569-14897-1-git-send-email-viorel.suman@nxp.com>
 <20181228233226.GA11728@bogus>
In-Reply-To: <20181228233226.GA11728@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB4942;
 6:tVl0scRrieFTWEaBGLSUlEzAxJ4pgcD0NJt9Vr7kbNjv2Jm/ODnjwzlPhPOdMNrq1xboi3CvEDCEgXOmzWkxQkt+IEfLfxI4yE3uI9BXf3nz7+ZlWGx2GkBp0vNmNXfLc0NqLMBJvjca2VsktYlONYwqICbKagkT8NToQ1zxSTwyrgdQULVZUzRwyxRm/20N0qiOkLF3I1sC82x1sIaBee9Vd1fRuRfE3bd0O+uPht6aOhfXTCK1YZdHyp6BC+X9TNH8YmuATqY27Dz7jrw7yJFttshVPn9NpCE+ay3PD4KZq1AW1AqJSejw0+TTDTAZglt7A1ImDVRCNNMZNHQHGap+xcoAFFUiOpfEO7XvY35uKZkfjbfK+psVInmz0ZJAkkzeNxqEMPFDl09v6KVbanlRbgCCx2sKndIB/VUQ/tMCagMiHsltHMO4SZBWZTtb4aatCTKdv0BvbPUNz/hVlQ==;
 5:M10RUz4xSZAe/muwMhiy/KzTpu3sSqhUUcRWJzcSYtYY1jD8ariFTJ/ZSg6TeP67iDnuqW0BwujtBEYZwjuOa9U8pp2+qVEQOyytWluYESZsARGotq3w49/DQHM21CfPoF/mJnddpxLFI0N9MNNARgUFmAS6NAfVw8cnSZa1YX/IhZb+V65cPgRSHDnnl2qFzDVNvpj9p3opsN5UGqNUZw==;
 7:c2THBjLVd1hYTw86soh0vAFJNApMYD9W1IMAJUd7MobR8kgyjcOJ+nRMCd4Bj39+M4w5ZDGJnO+K9uoPTog+7yXqlPUXOHeEADnjj8syqc8+yjY1v2Dwe7B2qs3ZiFqfxmLMF4bBxyJiqr9txIik4Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 95308d32-322c-4b2d-7b16-08d67181f941
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4942; 
x-ms-traffictypediagnostic: VI1PR04MB4942:
x-microsoft-antispam-prvs: <VI1PR04MB494259FCE8B4F08A1528F10B928D0@VI1PR04MB4942.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB4942; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB4942; 
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(7416002)(97736004)(5660300001)(256004)(14454004)(2501003)(54906003)(966005)(86362001)(478600001)(99286004)(44832011)(6436002)(6486002)(66066001)(11346002)(14444005)(446003)(476003)(217873002)(2616005)(5640700003)(316002)(486006)(68736007)(229853002)(3846002)(6116002)(8936002)(1730700003)(81156014)(81166006)(8676002)(7736002)(305945005)(6916009)(76176011)(6506007)(102836004)(186003)(26005)(71190400001)(6246003)(106356001)(6512007)(6306002)(71200400001)(2906002)(39060400002)(25786009)(105586002)(53936002)(2351001)(4326008)(4001150100001)(103116003)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4942;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qMkFNIy90BP3aInqUukIYT2YmJbw6PAC/a4TkWjVI3Ng9gxhH+7VBGUUPSIPfgNFtPJ2yWY6wGV2ZLl6haSSezj5Pt86P/66KN8gsihojyiNUs0hcBWJg+Hmu7Pn2l0BTGmv7h+9BgsCubkV8xnpfnITSaJvHQwZTHpSr/WoWDLGRKzmGMo+dZ0fUdnkgOF3nMHtzfj61i1gypzhVI5JIi4cSOqhVoxR9pJTWOh4/eERe/4h7lydnzrcEqcqOH/Crnt9kiWKMV3OK4MAveNdcJqzAqdL5H6o6sURCH0DQM2qguGP+iprg0ZExJQ/FNaR
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3716895533B6048A3EAA9A6C014E973@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95308d32-322c-4b2d-7b16-08d67181f941
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 13:47:16.4600 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4942
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Daniel Baluta <daniel.baluta@nxp.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, "perex@perex.cz" <perex@perex.cz>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgUm9iLA0KDQpPbiBWaSwgMjAxOC0xMi0yOCBhdCAxNzozMiAtMDYwMCwgUm9iIEhlcnJpbmcg
d3JvdGU6DQo+IE9uIFR1ZSwgRGVjIDE4LCAyMDE4IGF0IDA0OjMwOjAxUE0gKzAwMDAsIFZpb3Jl
bCBTdW1hbiB3cm90ZToNCj4gPiANCj4gPiBUaGlzIHBhdGNoIGltcGxlbWVudHMgQXVkaW8gTWl4
ZXIgQ1BVIERBSSBkcml2ZXIgZm9yIE5YUCBpTVg4IFNPQ3MuDQo+ID4gVGhlIEF1ZGlvIE1peGVy
IGlzIGEgb24tY2hpcCBmdW5jdGlvbmFsIG1vZHVsZSB0aGF0IGFsbG93cyBtaXhpbmcNCj4gPiBv
Zg0KPiA+IHR3byBhdWRpbyBzdHJlYW1zIGludG8gYSBzaW5nbGUgYXVkaW8gc3RyZWFtLg0KPiA+
IA0KPiA+IEF1ZGlvIE1peGVyIGRhdGFzaGVldCBpcyBhdmFpbGFibGUgaGVyZToNCj4gPiBodHRw
czovL3d3dy5ueHAuY29tL2RvY3MvZW4vcmVmZXJlbmNlLW1hbnVhbC9JTVg4RFFYUFJNLnBkZg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFZpb3JlbCBTdW1hbiA8dmlvcmVsLnN1bWFuQG54cC5j
b20+DQo+ID4gLS0tDQo+ID4gwqAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9mc2wsYW1p
eC50eHTCoMKgwqDCoMKgwqDCoMKgwqB8wqDCoDQ1ICsrDQo+IFRoaXMgc2hvdWxkIGJlIGEgc2Vw
YXJhdGUgcGF0Y2guDQoNCk9rLCB0aGFuayB5b3UsIHdpbGwgc3BsaXQgdGhpcyBpbnRvIHNldmVy
YWwgcGF0Y2hlcy4NCg0KPiANCj4gPiANCj4gPiDCoHNvdW5kL3NvYy9mc2wvS2NvbmZpZ8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHzC
oMKgwqA3ICsNCj4gPiDCoHNvdW5kL3NvYy9mc2wvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfMKgwqDCoDMgKw0KPiA+IMKg
c291bmQvc29jL2ZzbC9mc2xfYW1peC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgfCA1NTQNCj4gPiArKysrKysrKysrKysrKysrKysrKysNCj4g
PiDCoHNvdW5kL3NvYy9mc2wvZnNsX2FtaXguaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHwgMTAxICsrKysNCj4gPiDCoDUgZmlsZXMgY2hhbmdl
ZCwgNzEwIGluc2VydGlvbnMoKykNCj4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9mc2wsYW1peC50eHQNCj4gPiDCoGNy
ZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9zb2MvZnNsL2ZzbF9hbWl4LmMNCj4gPiDCoGNyZWF0ZSBt
b2RlIDEwMDY0NCBzb3VuZC9zb2MvZnNsL2ZzbF9hbWl4LmgNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL2ZzbCxhbWl4LnR4dA0K
PiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL2ZzbCxhbWl4LnR4
dA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMC4uMDQ5MTQ0Zg0K
PiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc291bmQvZnNsLGFtaXgudHh0DQo+ID4gQEAgLTAsMCArMSw0NSBAQA0KPiA+ICtOWFAg
QXVkaW8gTWl4ZXIgKEFNSVgpLg0KPiA+ICsNCj4gPiArVGhlIEF1ZGlvIE1peGVyIGlzIGEgb24t
Y2hpcCBmdW5jdGlvbmFsIG1vZHVsZSB0aGF0IGFsbG93cyBtaXhpbmcNCj4gPiBvZiB0d28NCj4g
PiArYXVkaW8gc3RyZWFtcyBpbnRvIGEgc2luZ2xlIGF1ZGlvIHN0cmVhbS4gQXVkaW8gTWl4ZXIg
aGFzIHR3bw0KPiA+IGlucHV0IHNlcmlhbA0KPiA+ICthdWRpbyBpbnRlcmZhY2VzLiBUaGVzZSBh
cmUgZHJpdmVuIGJ5IHR3byBTeW5jaHJvbm91cyBBdWRpbw0KPiA+IGludGVyZmFjZQ0KPiA+ICtt
b2R1bGVzIChTQUkpLiBFYWNoIGlucHV0IHNlcmlhbCBpbnRlcmZhY2UgY2FycmllcyA4IGF1ZGlv
DQo+ID4gY2hhbm5lbHMgaW4gaXRzDQo+ID4gK2ZyYW1lIGluIFRETSBtYW5uZXIuIE1peGVyIG1p
eGVzIGF1ZGlvIHNhbXBsZXMgb2YgY29ycmVzcG9uZGluZw0KPiA+IGNoYW5uZWxzDQo+ID4gK2Zy
b20gdHdvIGludGVyZmFjZXMgaW50byBhIHNpbmdsZSBzYW1wbGUuIEJlZm9yZSBtaXhpbmcsIGF1
ZGlvDQo+ID4gc2FtcGxlcyBvZg0KPiA+ICt0d28gaW5wdXRzIGNhbiBiZSBhdHRlbnVhdGVkIGJh
c2VkIG9uIGNvbmZpZ3VyYXRpb24uIFRoZSBvdXRwdXQgb2YNCj4gPiB0aGUNCj4gPiArQXVkaW8g
TWl4ZXIgaXMgYWxzbyBhIHNlcmlhbCBhdWRpbyBpbnRlcmZhY2UuIExpa2UgaW5wdXQNCj4gPiBp
bnRlcmZhY2VzIGl0IGhhcw0KPiA+ICt0aGUgc2FtZSBURE0gZnJhbWUgZm9ybWF0LiBUaGlzIG91
dHB1dCBpcyB1c2VkIHRvIGRyaXZlIHRoZSBzZXJpYWwNCj4gPiBEQUMgVERNDQo+ID4gK2ludGVy
ZmFjZSBvZiBhdWRpbyBjb2RlYyBhbmQgYWxzbyBzZW50IHRvIHRoZSBleHRlcm5hbCBwaW5zIGFs
b25nDQo+ID4gd2l0aCB0aGUNCj4gPiArcmVjZWl2ZSBwYXRoIG9mIG5vcm1hbCBhdWRpbyBTQUkg
bW9kdWxlIGZvciByZWFkYmFjayBieSB0aGUgQ1BVLg0KPiA+ICsNCj4gPiArVGhlIG91dHB1dCBv
ZiBBdWRpbyBtaXhlciBjYW4gYmUgc2VsZWN0ZWQgZnJvbSBhbnkgb2YgdGhlIHRocmVlDQo+ID4g
c3RyZWFtcw0KPiA+ICsgLSBzZXJpYWwgYXVkaW8gaW5wdXQgMQ0KPiA+ICsgLSBzZXJpYWwgYXVk
aW8gaW5wdXQgMg0KPiA+ICsgLSBNaXhlZCBhdWRpbw0KPiA+ICsNCj4gPiArTWl4aW5nIG9wZXJh
dGlvbiBpcyBpbmRlcGVuZGVudCBvZiBhdWRpbyBzYW1wbGUgcmF0ZSBidXQgdGhlIHR3bw0KPiA+
IGF1ZGlvDQo+ID4gK2lucHV0IHN0cmVhbXMgbXVzdCBoYXZlIHNhbWUgYXVkaW8gc2FtcGxlIHJh
dGUgd2l0aCBzYW1lIG51bWJlciBvZg0KPiA+IGNoYW5uZWxzDQo+ID4gK2luIFRETSBmcmFtZSB0
byBiZSBlbGlnaWJsZSBmb3IgbWl4aW5nLg0KPiA+ICsNCj4gPiArRGV2aWNlIGRyaXZlciByZXF1
aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ICs9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
Cj4gPiArwqDCoC0gY29tcGF0aWJsZQkJOiBDb21wYXRpYmxlIGxpc3QsIGNvbnRhaW5zDQo+ID4g
ImZzbCxpbXg4cW0tYW1peCINCj4gPiArDQo+ID4gK8KgwqAtIHJlZwkJCTogT2Zmc2V0IGFuZCBs
ZW5ndGggb2YgdGhlIHJlZ2lzdGVyDQo+ID4gc2V0IGZvciB0aGUgZGV2aWNlLg0KPiA+ICsNCj4g
PiArwqDCoC0gY2xvY2tzCQk6IE11c3QgY29udGFpbiBhbiBlbnRyeSBmb3IgZWFjaCBlbnRyeQ0K
PiA+IGluIGNsb2NrLW5hbWVzLg0KPiA+ICsNCj4gPiArwqDCoC0gY2xvY2stbmFtZXMJCTogTXVz
dCBpbmNsdWRlIHRoZSAiaXBnIiBmb3INCj4gPiByZWdpc3RlciBhY2Nlc3MuDQo+IEh1bW0sIG5v
IGF1ZGlvIHJlbGF0ZWQgY2xvY2tzPw0KDQpSaWdodCwgbm8gYXVkaW8gcmVsYXRlZCBjbG9ja3Mg
LSBBdWRpbyBNaXhlciBvcGVyYXRlcyBvbiB0aGUgY2xvY2tzDQpzdXBwbGllZCBieSBpbnB1dCBT
eW5jaHJvbm91cyBBdWRpbyBJbnRlcmZhY2VzLg0KDQo+IMKgDQo+IA0KPiA+IA0KPiA+ICsNCj4g
PiArwqDCoC0gcG93ZXItZG9tYWlucwk6IE11c3QgY29udGFpbiB0aGUgcGhhbmRsZSB0byB0aGUg
QU1JWA0KPiA+IHBvd2VyIGRvbWFpbiBub2RlDQo+ID4gKw0KPiA+ICtEZXZpY2UgZHJpdmVyIGNv
bmZpZ3VyYXRpb24gZXhhbXBsZToNCj4gPiArPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0NCj4gPiArwqDCoGFtaXg6IGFtaXhANTk4NDAwMDAgew0KPiA+ICvCoMKgwqDCoGNv
bXBhdGlibGUgPSAiZnNsLGlteDhxbS1hbWl4IjsNCj4gPiArwqDCoMKgwqByZWcgPSA8MHgwIDB4
NTk4NDAwMDAgMHgwIDB4MTAwMDA+Ow0KPiA+ICvCoMKgwqDCoGNsb2NrcyA9IDwmY2xrIElNWDhR
WFBfQVVEX0FNSVhfSVBHPjsNCj4gPiArwqDCoMKgwqBjbG9jay1uYW1lcyA9ICJpcGciOw0KPiA+
ICvCoMKgwqDCoHBvd2VyLWRvbWFpbnMgPSA8JnBkX2FtaXg+Ow0KPiA+ICvCoMKgfTsNCj4gPiAr
DQoNClJlZ2FyZHMsDQpWaW9yZWwNCg==

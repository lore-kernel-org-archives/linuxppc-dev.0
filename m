Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BC3C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 13:18:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0A9120652
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 13:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xSETCPxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A9120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43h1jB3pBxzDr1g
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 00:18:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.15.88; helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="xSETCPxc"; 
 dkim-atps=neutral
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150088.outbound.protection.outlook.com [40.107.15.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43h1g66fRgzDr0P
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 00:16:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzGlpatmHvfWciMkKxkKen0GIBWgUeZlhiUfVJ4ZJzM=;
 b=xSETCPxc+T+TrlRJ9FmrUw+DCQv2VeXXJEEmg5dRkgKOuJzpErmpRbb9QVwsQtjErDsxfXWANssnwBCDbBkrZ/ww8jjC/FNY86eU8P6mhbQJQ3mwQVhpVpnlBLrnIjBLKAFfnPg+ofexkraiSkk4VnEA7YTMG3pvW3DBKqxo51c=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB4783.eurprd04.prod.outlook.com (20.177.48.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Fri, 18 Jan 2019 13:16:25 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::e58a:8812:d380:2080]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::e58a:8812:d380:2080%2]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 13:16:24 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: "robh@kernel.org" <robh@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 0/4] Add NXP AUDMIX device and machine drivers
Thread-Topic: [PATCH v3 0/4] Add NXP AUDMIX device and machine drivers
Thread-Index: AQHUrmKoQmEVxQazyE68ciNiNCuyvqWzo60AgAFfkwA=
Date: Fri, 18 Jan 2019 13:16:24 +0000
Message-ID: <1547817384.11482.33.camel@nxp.com>
References: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
 <20190117161804.GA5760@bogus>
In-Reply-To: <20190117161804.GA5760@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB4783;
 6:S2dbYZiTFIHnXctzK0kauah9yNxce2yJYaZZlc9CBLvzqVpAMrFXCIOkBKhlk4udGArkyG2ffrDLXlZgScgXUe7C5m50wvEVeK+r+VB5ERpw43JjWZTVt/+Zg3xCZ87xdtJAqF/9bkzn5Y1ogA68HcWYcUXx4UjWibvE37zXowhdhGCpZDnuLsd3Cevnnj1l/jSivrX/vk3gUzL7qh0yJwqw63nkp4w8v54NLynSv3ERaUsyJDENExaoglfRHcDLT7W/qVWRI8lMScFSSzW4Ni5H+6pym/WDNA8FxgnIPpybeczECdJPeYmgMYSVloicjX1208lKtDOYe0Oo/QLC5H3AB8LHMxSkV+kuhMjVIe/QW35mtWhIdeGDl92oRK4x5r/lz85LRLQihT4/aCpxRkDbflWmDYZG/26qphfvknPBZLjOMHMc2M11D6675TLJJ3fH+boqV7lP1ujeoaA6Yw==;
 5:Ro3C0Z1Q3viq4pKF4Jo27Ea08CiYhP4cec/HNZj4f1ugNG1XeLPmE4CWdKcgJIVzHOfOi3JiBqrKO3u/bgD7Gzz0HLpAxXhRbXzfYNNgoF8fBW9xuV//VxApGi1x9bJ/ZNu14yD1caX0YzVxhxXBroE+LR+ZWrNyYEBu35J+KDrPtqaNUjOq3lfHemMYId8q2/MBKASvyYxpB2AbgmOa7g==;
 7:QjiF5HnOP2PDXEpLJLahJzIzR+s348OfYnopYrvEGftacU21KTFjmOQMcPZmIcWZk73ZmEly/xbx51GVIyDd/dsL2op7B0RwD927o6myasWZI9hkgFSP6xhDP04UxGDU0nyRMlIeNznYWQ5/ddH1pg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 61f32cbd-5171-4001-620c-08d67d4725c7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4783; 
x-ms-traffictypediagnostic: VI1PR04MB4783:
x-microsoft-antispam-prvs: <VI1PR04MB4783F2857FFD3D8007C6D282929C0@VI1PR04MB4783.eurprd04.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(136003)(39860400002)(346002)(376002)(199004)(189003)(36756003)(110136005)(81166006)(102836004)(26005)(14444005)(68736007)(478600001)(103116003)(476003)(66066001)(6436002)(6506007)(2501003)(316002)(71190400001)(6116002)(8936002)(76176011)(2616005)(99286004)(8676002)(71200400001)(6486002)(3846002)(7416002)(25786009)(229853002)(446003)(305945005)(11346002)(54906003)(4326008)(486006)(6246003)(81156014)(44832011)(5660300001)(97736004)(186003)(105586002)(14454004)(6512007)(106356001)(39060400002)(2906002)(217873002)(7736002)(256004)(86362001)(53936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4783;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0XKewtE9nFhs44gqc91KZjOyxhMq+MM7GT+ybXE779fSPEFKtSqIjDUzmC+6nqm3WdiKfo5l56Ox0HdQy/8s0wdUBh195FHRnVNhVufLl8rmjJoGDfehEPStZHPshnOt4cY7h86y5FRqKOuJPGly3rf9gGTX9BSvrARROQyRkjJ+QuYLCJpmH4Y8TWHxPawkQGNiCzS0aHkL5+iwHDdZEwZHRH4EHaE0cYHcreKKnyypK125jXgzM3cDMnI15Jl/WQmOtch5stef8Lty6Wt2Qnu1T0Qv/s/2HvZEisikVqSV+jC9IKFnYv1bOE36avwt0OB/gUAy5E7RZqM5kp4rjEsfUW/H3wPLuugBDLR5DszeY3FkKL8EktviTUtzT+OWAWb+3McQJL2hpYq+5RZDN7soXxL8RkrBd/ZX5gPJcf0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <92DBA4F10D09D34EB93E4BAF7B64843A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f32cbd-5171-4001-620c-08d67d4725c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 13:16:24.8227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4783
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

SGkgUm9iLCBOaWNvbGluLCBBbGwsDQoNCk9uIEpvLCAyMDE5LTAxLTE3IGF0IDEwOjE4IC0wNjAw
LCBSb2IgSGVycmluZyB3cm90ZToNCj4gT24gVGh1LCBKYW4gMTcsIDIwMTkgYXQgMTI6NDY6MjVQ
TSArMDAwMCwgVmlvcmVsIFN1bWFuIHdyb3RlOg0KPiA+IA0KPiA+IFRoZSBwYXRjaHNldCBhZGRz
IE5YUCBBdWRpbyBNaXhlciAoQVVETUlYKSBkZXZpY2UgYW5kIG1hY2hpbmUNCj4gPiBkcml2ZXJz
IGFuZCByZWxhdGVkIERUIGJpbmRpbmdzIGRvY3VtZW50YXRpb24uDQo+ID4gDQo+ID4gQ2hhbmdl
cyBzaW5jZSBWMjoNCj4gPiAxLiBNb3ZlZCAiZGFpcyIgbm9kZSBmcm9tIG1hY2hpbmUgZHJpdmVy
IERUUyBub2RlIHRvIGRldmljZSBkcml2ZXINCj4gPiBEVFMgbm9kZQ0KPiA+IMKgIGFzIHN1Z2dl
c3RlZCBieSBSb2IuDQo+IFRoYXQgd2FzIG5vdCB3aGF0IEkgc3VnZ2VzdGVkLiBZb3Ugc3RpbGwg
aGF2ZSBhIHZpcnR1YWwgbm9kZSB3aGljaA0KPiBsb29rcyB0byBtZSB0byBiZSB1bm5lY2Vzc2Fy
eS4NCg0KVG8gbWUgcmVtb3ZpbmcgdmlydHVhbCBub2RlIGltcGxpZXMgdGhhdCBBVURNSVggbWFj
aGluZSBkcml2ZXIgKGlteC0NCmF1ZG1peC5jICsgdmlydHVhbCBub2RlKSBzaGFsbCBiZSByZW1v
dmVkIGFuZCBtYWNoaW5lIGRyaXZlciBjb2RlDQptZXJnZWQgaW50byBkZXZpY2UgZHJpdmVyIChm
c2xfYXVkbWl4LmMgKyBkZXZpY2Ugbm9kZSkgLSBwbGVhc2UgbGV0IG1lDQprbm93IGlmIG15IHVu
ZGVyc3RhbmRpbmcgaXMgd3JvbmcuDQoNClRoZSBpbXBsaWNhdGlvbiBpcyB0aGF0IHRoaXMgbWFr
ZXMgQVVETUlYIGRldmljZSBkcml2ZXIgYm91bmRlZCB0byBhDQpwYXJ0aWN1bGFyIERBSSB0eXBl
IG9mIGludGVyZmFjZSAtIFNBSS4gVGhlIG9yaWdpbmFsIGludGVudGlvbiBpcyB0bw0Ka2VlcCBB
VURNSVggZGV2aWNlIGRyaXZlciBEQUktYWdub3N0aWMuDQoNCkluZGVlZCwgY3VycmVudGx5IHRo
ZSBjb25uZWN0aW9uIGJldHdlZW4gQVVETUlYIGFuZCBTQUkgSVAgYmxvY2tzIGluDQppLk1YOFFN
IGFuZCBpLk1YOFFYUCBpcyBmaXhlZCBpbnNpZGUgdGhlIFNvQywgYnV0IG9uIG90aGVyIHBsYXRm
b3JtcyB3ZQ0KbWF5IGV4cGVjdCBBVURNSVggdG8gYmUgY29ubmVjdGVkIGluc2lkZSB0aGUgU29D
IHRvIG90aGVyIElQIGJsb2NrcyAtDQp0byBFU0FJIGludGVyZmFjZSBmb3IgaW5zdGFuY2UuDQoN
CkF0IHRoaXMgbW9tZW50IGl0J3MgYSBiaXQgZGlmZmljdWx0IGZvciBtZSB0byBldmFsdWF0ZSBo
b3cgY3JpdGljYWwgaXMNCnRvIGtlZXAgdGhlIGRldmljZSBkcml2ZXIgREFJLWFnbm9zdGljLCBz
byBpZiB5b3UgdGhpbmsgaXQncyBiZXR0ZXIgdG8NCmdvIG5vdyB3aXRoIGEgU0FJIGJvdW5kZWQg
QVVETUlYIGRldmljZSBkcml2ZXIgLSBwbGVhc2UgY29uZmlybSwgSSdsbA0KbWVyZ2UgbWFjaGlu
ZSBkcml2ZXIgY29kZSBpbnRvIGRldmljZSBkcml2ZXIuDQoNClRoYW5rIHlvdSwNClZpb3JlbA0K
DQo+IA0KPiA+IA0KPiA+IA0KPiA+IENoYW5nZXMgc2luY2UgVjE6DQo+ID4gMS4gT3JpZ2luYWwg
cGF0Y2ggc3BsaXQgaW50byBkaXN0aW5jdCBwYXRjaGVzIGZvciB0aGUgZGV2aWNlIGRyaXZlcg0K
PiA+IGFuZA0KPiA+IMKgIERUIGJpbmRpbmcgZG9jdW1lbnRhdGlvbi4NCj4gPiAyLiBSZXBsYWNl
ZCBBTUlYIHdpdGggQVVETUlYIGluIGJvdGggY29kZSBhbmQgZmlsZSBuYW1lcyBhcyBpdA0KPiA+
IGxvb2tzIG1vcmUNCj4gPiDCoCBSTS1jb21wbGlhbnQuDQo+ID4gMy4gUmVtb3ZlZCBwb2xhcml0
eSBjb250cm9sIGZyb20gQ1BVIERBSSBkcml2ZXIgYXMgc3VnZ2VzdGVkIGJ5DQo+ID4gTmljb2xp
bi4NCj4gPiA0LiBBZGRlZCBtYWNoaW5lIGRyaXZlciBhbmQgcmVsYXRlZCBEVCBiaW5kaW5nIGRv
Y3VtZW50YXRpb24uDQo+ID4gDQo+ID4gVmlvcmVsIFN1bWFuICg0KToNCj4gPiDCoCBBU29DOiBm
c2w6IEFkZCBBdWRpbyBNaXhlciBDUFUgREFJIGRyaXZlcg0KPiA+IMKgIEFTb0M6IGFkZCBmc2xf
YXVkbWl4IERUIGJpbmRpbmcgZG9jdW1lbnRhdGlvbg0KPiA+IMKgIEFTb0M6IGZzbDogQWRkIEF1
ZGlvIE1peGVyIG1hY2hpbmUgZHJpdmVyDQo+ID4gwqAgQVNvQzogYWRkIGlteC1hdWRtaXggRFQg
YmluZGluZyBkb2N1bWVudGF0aW9uDQo+ID4gDQo+ID4gwqAuLi4vZGV2aWNldHJlZS9iaW5kaW5n
cy9zb3VuZC9mc2wsYXVkbWl4LnR4dMKgwqDCoMKgwqDCoMKgfMKgwqA1MCArKw0KPiA+IMKgLi4u
L2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvaW14LWF1ZG1peC50eHTCoMKgwqDCoMKgwqDCoHzC
oMKgMTggKw0KPiA+IMKgc291bmQvc29jL2ZzbC9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfMKgwqAxNiArDQo+ID4gwqBz
b3VuZC9zb2MvZnNsL01ha2VmaWxlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHzCoMKgwqA1ICsNCj4gPiDCoHNvdW5kL3NvYy9mc2wvZnNs
X2F1ZG1peC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqB8IDU1MQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKw0KPiA+IMKgc291bmQvc29jL2ZzbC9m
c2xfYXVkbWl4LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHwgMTAyICsrKysNCj4gPiDCoHNvdW5kL3NvYy9mc2wvaW14LWF1ZG1peC5jwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8IDMzNA0KPiA+ICsrKysr
KysrKysrKysNCj4gPiDCoDcgZmlsZXMgY2hhbmdlZCwgMTA3NiBpbnNlcnRpb25zKCspDQo+ID4g
wqBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3Mvc291bmQvZnNsLGF1ZG1peC50eHQNCj4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvaW14LQ0KPiA+IGF1ZG1peC50eHQNCj4g
PiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9zb2MvZnNsL2ZzbF9hdWRtaXguYw0KPiA+IMKg
Y3JlYXRlIG1vZGUgMTAwNjQ0IHNvdW5kL3NvYy9mc2wvZnNsX2F1ZG1peC5oDQo+ID4gwqBjcmVh
dGUgbW9kZSAxMDA2NDQgc291bmQvc29jL2ZzbC9pbXgtYXVkbWl4LmMNCj4gPiA=

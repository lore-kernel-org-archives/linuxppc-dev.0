Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3472EC10F11
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 11:07:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A24F12064A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 11:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rMJwTEgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24F12064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nkM537N7zDqRd
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 21:07:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.5.67; helo=eur03-ve1-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="rMJwTEgp"; 
 dkim-atps=neutral
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50067.outbound.protection.outlook.com [40.107.5.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nkKR49T6zDqJW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 21:06:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqW7gkRlsxh+s/U2USZA8gQcOJc0hczHMoyWRDGcp1w=;
 b=rMJwTEgpnjXe08XtmjTPRN4vNSxgc7kE9PILOU1DQA9ZKZuwONXIic/zN2zXFYvA6DSwfr3wV5iWdP2FXIOTMW+r86WDLO4b7ynWHjRWnQ4QDNM0XoDItjd/Qhdzmobfu4dbshuCvvvV9Obdvs97cETPOmkkO1FAUOPi6qPdP/c=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB4046.eurprd04.prod.outlook.com (10.171.182.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Mon, 22 Apr 2019 11:06:13 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888%3]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 11:06:12 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Daniel Baluta <daniel.baluta@nxp.com>, "broonie@kernel.org"
 <broonie@kernel.org>
Subject: Re: [PATCH 3/3 v3] ASoC: fsl_sai: Move clock operation to PM runtime
Thread-Topic: [PATCH 3/3 v3] ASoC: fsl_sai: Move clock operation to PM runtime
Thread-Index: AQHU+HnlxGRnmGIL1Um6QDOPF3aqQKZIBdYA
Date: Mon, 22 Apr 2019 11:06:12 +0000
Message-ID: <1555931172.31656.6.camel@nxp.com>
References: <20190421193853.10188-1-daniel.baluta@nxp.com>
 <20190421193853.10188-4-daniel.baluta@nxp.com>
In-Reply-To: <20190421193853.10188-4-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04dd2089-3b58-43d9-9942-08d6c7128852
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR04MB4046; 
x-ms-traffictypediagnostic: VI1PR04MB4046:
x-microsoft-antispam-prvs: <VI1PR04MB40469DC0066DC215EB6E7B0D92220@VI1PR04MB4046.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(136003)(366004)(39860400002)(396003)(346002)(199004)(189003)(2501003)(97736004)(256004)(6246003)(3450700001)(14444005)(36756003)(4326008)(6512007)(99286004)(53936002)(2906002)(43066004)(44832011)(6436002)(7416002)(8936002)(476003)(2616005)(486006)(5660300002)(6486002)(446003)(11346002)(102836004)(7736002)(6506007)(305945005)(76116006)(26005)(73956011)(66476007)(66556008)(14454004)(64756008)(66446008)(68736007)(229853002)(66946007)(6116002)(3846002)(86362001)(25786009)(316002)(110136005)(54906003)(66066001)(478600001)(76176011)(103116003)(71190400001)(71200400001)(8676002)(186003)(81156014)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4046;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1GKh8hd2tmgAFeUo3ys+4cfVpb9aOTaHtBH0/IfxaU+2eRLtiQOJKO4YzsAIlhzfKIh9YCv6aXfHY4GfXH1NORfVVKRiB3k7NE2SZuQvCO36aUT/nvGAfAUKYuhYD4RwAk48N02FU4GjtXA8yq3MccaAWc4XTzbdT5ToCPeSf2tXUtGpRC88wXoGBRhACSVd7fS1hsCh3aMFpz8BqDQekPoaaCPjLqAfit65yfCJNCgBVGF5pfb4yIuoQ3KcAPaKVBVMSp3KpP3/rc2HT8tMQSL8lXDH05HoEoj01ftE+yK2462CuaDDCTMmxbX2TT6BcPxRxozQ40KCFMaGuCv3ojmmbZpAmjSXnfqVnhBWE4UIP9cssCdSQScqHyugptCC3071SjSkXQ8mGzo3Z/WEsHEHxBleq1cAbEZeG6VO4s0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4EF202FE8D88542B4AA75DF110B1FA5@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04dd2089-3b58-43d9-9942-08d6c7128852
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 11:06:12.9226 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4046
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
Reply-To: Viorel Suman <viorel.suman@nxp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tiwai@suse.com" <tiwai@suse.com>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 dl-linux-imx <linux-imx@nxp.com>, "perex@perex.cz" <perex@perex.cz>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgRGFuaWVsLA0KDQpPbiBEdSwgMjAxOS0wNC0yMSBhdCAxOTozOSArMDAwMCwgRGFuaWVsIEJh
bHV0YSB3cm90ZToNCj4gRnJvbTogU2hlbmdqaXUgV2FuZyA8c2hlbmdqaXUud2FuZ0BueHAuY29t
Pg0KPiANCj4gVHVybiBvZmYvb24gY2xvY2tzIHdoZW4gZGV2aWNlIGVudGVycyBzdXNwZW5kL3Jl
c3VtZS4gVGhpcw0KPiBjYW4gaGVscCBzYXZpbmcgcG93ZXIuDQo+IA0KPiBBcyBhIGZ1cnRoZXIg
b3B0aW1pemF0aW9uLCB3ZSB0dXJuIG9mZi9vbiBtY2xrIG9ubHkgd2hlbiBTQUkNCj4gaXMgaW4g
bWFzdGVyIG1vZGUgYmVjYXVzZSBvdGhlcndpc2UgbWNsayBpcyBleHRlcm5hbGx5IHByb3ZpZGVk
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2hlbmdqaXUgV2FuZyA8c2hlbmdqaXUud2FuZ0BueHAu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFsdXRhQG54cC5j
b20+DQo+IC0tLQ0KPiDCoHNvdW5kL3NvYy9mc2wvZnNsX3NhaS5jIHwgNjAgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgNTAgaW5z
ZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvc291bmQvc29j
L2ZzbC9mc2xfc2FpLmMgYi9zb3VuZC9zb2MvZnNsL2ZzbF9zYWkuYw0KPiBpbmRleCA4NjIzYjdm
ODgyYjkuLjEzYTQ2MjM2MGVkMyAxMDA2NDQNCj4gLS0tIGEvc291bmQvc29jL2ZzbC9mc2xfc2Fp
LmMNCj4gKysrIGIvc291bmQvc29jL2ZzbC9mc2xfc2FpLmMNCj4gQEAgLTU5NiwxNSArNTk2LDgg
QEAgc3RhdGljIGludCBmc2xfc2FpX3N0YXJ0dXAoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpz
dWJzdHJlYW0sDQo+IMKgew0KPiDCoAlzdHJ1Y3QgZnNsX3NhaSAqc2FpID0gc25kX3NvY19kYWlf
Z2V0X2RydmRhdGEoY3B1X2RhaSk7DQo+IMKgCWJvb2wgdHggPSBzdWJzdHJlYW0tPnN0cmVhbSA9
PSBTTkRSVl9QQ01fU1RSRUFNX1BMQVlCQUNLOw0KPiAtCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZz
YWktPnBkZXYtPmRldjsNCj4gwqAJaW50IHJldDsNCj4gwqANCj4gLQlyZXQgPSBjbGtfcHJlcGFy
ZV9lbmFibGUoc2FpLT5idXNfY2xrKTsNCj4gLQlpZiAocmV0KSB7DQo+IC0JCWRldl9lcnIoZGV2
LCAiZmFpbGVkIHRvIGVuYWJsZSBidXMgY2xvY2s6ICVkXG4iLCByZXQpOw0KPiAtCQlyZXR1cm4g
cmV0Ow0KPiAtCX0NCj4gLQ0KPiDCoAlyZWdtYXBfdXBkYXRlX2JpdHMoc2FpLT5yZWdtYXAsIEZT
TF9TQUlfeENSMyh0eCksIEZTTF9TQUlfQ1IzX1RSQ0UsDQo+IMKgCQkJwqDCoMKgRlNMX1NBSV9D
UjNfVFJDRSk7DQo+IMKgDQo+IEBAIC02MjEsOCArNjE0LDYgQEAgc3RhdGljIHZvaWQgZnNsX3Nh
aV9zaHV0ZG93bihzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwNCj4gwqAJYm9v
bCB0eCA9IHN1YnN0cmVhbS0+c3RyZWFtID09IFNORFJWX1BDTV9TVFJFQU1fUExBWUJBQ0s7DQo+
IMKgDQo+IMKgCXJlZ21hcF91cGRhdGVfYml0cyhzYWktPnJlZ21hcCwgRlNMX1NBSV94Q1IzKHR4
KSwgRlNMX1NBSV9DUjNfVFJDRSwgMCk7DQo+IC0NCj4gLQljbGtfZGlzYWJsZV91bnByZXBhcmUo
c2FpLT5idXNfY2xrKTsNCj4gwqB9DQo+IMKgDQo+IMKgc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRf
c29jX2RhaV9vcHMgZnNsX3NhaV9wY21fZGFpX29wcyA9IHsNCj4gQEAgLTkzMiw2ICs5MjMsMTYg
QEAgc3RhdGljIGludCBmc2xfc2FpX3J1bnRpbWVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYp
DQo+IMKgew0KPiDCoAlzdHJ1Y3QgZnNsX3NhaSAqc2FpID0gZGV2X2dldF9kcnZkYXRhKGRldik7
DQo+IMKgDQo+ICsJaWYgKCFzYWktPmlzX3NsYXZlX21vZGUpIHsNClRoaXMgY2hlY2sgaXMgcmVk
dW5kYW50IGFzIHRoZSBiaXRzIGluwqBzYWktPm1jbGtfc3RyZWFtcyBhcmUgc2V0L3Vuc2V0IGZv
ciBtYXN0ZXINCm1vZGUgb25seSwgcGxlYXNlIGNoZWNrwqBmc2xfc2FpX2h3X3BhcmFtcyBhbmTC
oGZzbF9zYWlfaHdfZnJlZSBmdW5jdGlvbnMuDQoNCj4gKwkJaWYgKHNhaS0+bWNsa19zdHJlYW1z
ICYgQklUKFNORFJWX1BDTV9TVFJFQU1fQ0FQVFVSRSkpDQo+ICsJCQljbGtfZGlzYWJsZV91bnBy
ZXBhcmUoc2FpLT5tY2xrX2Nsa1tzYWktPm1jbGtfaWRbMF1dKTsNCj4gKw0KPiArCQlpZiAoc2Fp
LT5tY2xrX3N0cmVhbXMgJiBCSVQoU05EUlZfUENNX1NUUkVBTV9QTEFZQkFDSykpDQo+ICsJCQlj
bGtfZGlzYWJsZV91bnByZXBhcmUoc2FpLT5tY2xrX2Nsa1tzYWktPm1jbGtfaWRbMV1dKTsNCj4g
Kwl9DQo+ICsNCj4gKwljbGtfZGlzYWJsZV91bnByZXBhcmUoc2FpLT5idXNfY2xrKTsNCj4gKw0K
PiDCoAlyZWdjYWNoZV9jYWNoZV9vbmx5KHNhaS0+cmVnbWFwLCB0cnVlKTsNCj4gwqAJcmVnY2Fj
aGVfbWFya19kaXJ0eShzYWktPnJlZ21hcCk7DQo+IMKgDQo+IEBAIC05NDEsNiArOTQyLDI3IEBA
IHN0YXRpYyBpbnQgZnNsX3NhaV9ydW50aW1lX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0K
PiDCoHN0YXRpYyBpbnQgZnNsX3NhaV9ydW50aW1lX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYp
DQo+IMKgew0KPiDCoAlzdHJ1Y3QgZnNsX3NhaSAqc2FpID0gZGV2X2dldF9kcnZkYXRhKGRldik7
DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShzYWktPmJ1
c19jbGspOw0KPiArCWlmIChyZXQpIHsNCj4gKwkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZW5h
YmxlIGJ1cyBjbG9jazogJWRcbiIsIHJldCk7DQo+ICsJCXJldHVybiByZXQ7DQo+ICsJfQ0KPiAr
DQo+ICsJaWYgKCFzYWktPmlzX3NsYXZlX21vZGUpIHsNCj4gKwkJaWYgKHNhaS0+bWNsa19zdHJl
YW1zICYgQklUKFNORFJWX1BDTV9TVFJFQU1fUExBWUJBQ0spKSB7DQo+ICsJCQlyZXQgPSBjbGtf
cHJlcGFyZV9lbmFibGUoc2FpLT5tY2xrX2Nsa1tzYWktPm1jbGtfaWRbMV1dKTsNCj4gKwkJCWlm
IChyZXQpDQo+ICsJCQkJZ290byBkaXNhYmxlX2J1c19jbGs7DQo+ICsJCX0NCj4gKw0KPiArCQlp
ZiAoc2FpLT5tY2xrX3N0cmVhbXMgJiBCSVQoU05EUlZfUENNX1NUUkVBTV9DQVBUVVJFKSkgew0K
PiArCQkJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKHNhaS0+bWNsa19jbGtbc2FpLT5tY2xrX2lk
WzBdXSk7DQo+ICsJCQlpZiAocmV0KQ0KPiArCQkJCWdvdG8gZGlzYWJsZV90eF9jbGs7DQo+ICsJ
CX0NCj4gKwl9DQo+IMKgDQo+IMKgCXJlZ2NhY2hlX2NhY2hlX29ubHkoc2FpLT5yZWdtYXAsIGZh
bHNlKTsNCj4gwqAJcmVnbWFwX3dyaXRlKHNhaS0+cmVnbWFwLCBGU0xfU0FJX1RDU1IsIEZTTF9T
QUlfQ1NSX1NSKTsNCj4gQEAgLTk0OCw3ICs5NzAsMjUgQEAgc3RhdGljIGludCBmc2xfc2FpX3J1
bnRpbWVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gwqAJdXNsZWVwX3JhbmdlKDEwMDAs
IDIwMDApOw0KPiDCoAlyZWdtYXBfd3JpdGUoc2FpLT5yZWdtYXAsIEZTTF9TQUlfVENTUiwgMCk7
DQo+IMKgCXJlZ21hcF93cml0ZShzYWktPnJlZ21hcCwgRlNMX1NBSV9SQ1NSLCAwKTsNCj4gLQly
ZXR1cm4gcmVnY2FjaGVfc3luYyhzYWktPnJlZ21hcCk7DQo+ICsNCj4gKwlyZXQgPSByZWdjYWNo
ZV9zeW5jKHNhaS0+cmVnbWFwKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlnb3RvIGRpc2FibGVfcnhf
Y2xrOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICsNCj4gK2Rpc2FibGVfcnhfY2xrOg0KPiArCWlm
ICghc2FpLT5pc19zbGF2ZV9tb2RlICYmDQo+ICsJwqDCoMKgwqAoc2FpLT5tY2xrX3N0cmVhbXMg
JiBCSVQoU05EUlZfUENNX1NUUkVBTV9DQVBUVVJFKSkpDQo+ICsJCWNsa19kaXNhYmxlX3VucHJl
cGFyZShzYWktPm1jbGtfY2xrW3NhaS0+bWNsa19pZFswXV0pOw0KPiArZGlzYWJsZV90eF9jbGs6
DQo+ICsJaWYgKCFzYWktPmlzX3NsYXZlX21vZGUgJiYNCj4gKwnCoMKgwqDCoChzYWktPm1jbGtf
c3RyZWFtcyAmIEJJVChTTkRSVl9QQ01fU1RSRUFNX1BMQVlCQUNLKSkpDQo+ICsJCWNsa19kaXNh
YmxlX3VucHJlcGFyZShzYWktPm1jbGtfY2xrW3NhaS0+bWNsa19pZFsxXV0pOw0KPiArZGlzYWJs
ZV9idXNfY2xrOg0KPiArCWNsa19kaXNhYmxlX3VucHJlcGFyZShzYWktPmJ1c19jbGspOw0KPiAr
DQo+ICsJcmV0dXJuIHJldDsNCj4gwqB9DQo+IMKgI2VuZGlmIC8qIENPTkZJR19QTSAqLw0KPiDC
oA0KPiAtLcKgDQo+IDIuMTcuMQ0KPiA=

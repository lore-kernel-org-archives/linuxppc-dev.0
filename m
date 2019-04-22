Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C614C10F11
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 19:08:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05CF3206A3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 19:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="smiKPVvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05CF3206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nx2D6hB5zDqLP
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 05:08:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe1f::607;
 helo=eur01-ve1-obe.outbound.protection.outlook.com;
 envelope-from=daniel.baluta@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="smiKPVvS"; 
 dkim-atps=neutral
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nwv76yB0zDqHK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 05:02:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEX3x3e0ljlPC40jBK3AsnHXWxgmFWIH2s0yE3NhOR0=;
 b=smiKPVvS/axkGOg8ejIj8yYNWf0lvhdXXTzmsj+4Oc6wmCEhv0HD3ThQzLA6GYhLmZNsgYmxW+25rCPoyQuKRfBkvp70gBj+vgCSSwh/IXgn93WcUpLzEVY9D/NHEUBW5jTqlxPvHziglCVMB4j8REGhluahj5B/gYPAkl13g0g=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2815.eurprd04.prod.outlook.com (10.172.255.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Mon, 22 Apr 2019 19:02:30 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6%6]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 19:02:30 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Subject: [PATCH v3 3/3] ASoC: fsl_sai: Move clock operation to PM runtime
Thread-Topic: [PATCH v3 3/3] ASoC: fsl_sai: Move clock operation to PM runtime
Thread-Index: AQHU+T3vEZlYZN+pPk2qp55sbp9cMQ==
Date: Mon, 22 Apr 2019 19:02:30 +0000
Message-ID: <20190422190213.30726-4-daniel.baluta@nxp.com>
References: <20190422190213.30726-1-daniel.baluta@nxp.com>
In-Reply-To: <20190422190213.30726-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0114.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::43) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a377046-f2ed-4a72-ee3c-08d6c7551185
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR0402MB2815; 
x-ms-traffictypediagnostic: VI1PR0402MB2815:
x-microsoft-antispam-prvs: <VI1PR0402MB2815A3D71791268B8FDE1D0AF9220@VI1PR0402MB2815.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(376002)(366004)(396003)(346002)(39860400002)(199004)(189003)(2906002)(6512007)(53936002)(7736002)(305945005)(316002)(386003)(6506007)(99286004)(102836004)(52116002)(186003)(76176011)(8936002)(54906003)(50226002)(26005)(25786009)(4326008)(66066001)(8676002)(36756003)(6116002)(3846002)(6916009)(2501003)(81166006)(1730700003)(81156014)(68736007)(2351001)(5640700003)(14454004)(478600001)(71190400001)(64756008)(6486002)(66446008)(5660300002)(66556008)(97736004)(2616005)(476003)(44832011)(446003)(256004)(11346002)(14444005)(86362001)(66476007)(73956011)(66946007)(6436002)(7416002)(486006)(1076003)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2815;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GPI0IkzsfgKqLo9zlJdd2hWl11iTlaWWXQVLvEKGHogqStj9qwEQxRvNxOux3Ozsc9rJicUbjtcx/DaHaLH4I8r28T68qFmgspj6h+U45tBC00x4xW5tdFvXL0atLNwTvwGaRd5Gbv0lp5emXjnYkZxRaFcyZ/+Q7W7+3h0aZxzJRvw6qSAM0JHLb1HyutXeevDVB1u7Eq2FplXRM0i5B5O5jR1otdVykd5S+k72tDkJfrZEu/I9euO5gTaRiGwVkJmTn29qY7CEonUIu/xr+iF74GvUQmz3bpCJqH6D9lxkHNYBCG14iUAkbdjdwHlDgxo6xmJq6mNAqsBOhv4PPauuqkwechVSMFjm84GTzr5UtAYv4UU88Bh1c++oHD/I63cIEizXMLOaA1+xOT8jcSCCnOBenLBn5aFgnBtBWSI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a377046-f2ed-4a72-ee3c-08d6c7551185
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 19:02:30.3444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2815
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
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "S.j. Wang" <shengjiu.wang@nxp.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>,
 dl-linux-imx <linux-imx@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

RnJvbTogU2hlbmdqaXUgV2FuZyA8c2hlbmdqaXUud2FuZ0BueHAuY29tPg0KDQpUdXJuIG9mZi9v
biBjbG9ja3Mgd2hlbiBkZXZpY2UgZW50ZXJzIHN1c3BlbmQvcmVzdW1lLiBUaGlzDQpjYW4gaGVs
cCBzYXZpbmcgcG93ZXIuDQoNCkFzIGEgZnVydGhlciBvcHRpbWl6YXRpb24sIHdlIHR1cm4gb2Zm
L29uIG1jbGsgb25seSB3aGVuIFNBSQ0KaXMgaW4gbWFzdGVyIG1vZGUgYmVjYXVzZSBvdGhlcndp
c2UgbWNsayBpcyBleHRlcm5hbGx5IHByb3ZpZGVkLg0KDQpTaWduZWQtb2ZmLWJ5OiBTaGVuZ2pp
dSBXYW5nIDxzaGVuZ2ppdS53YW5nQG54cC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgQmFs
dXRhIDxkYW5pZWwuYmFsdXRhQG54cC5jb20+DQotLS0NCiBzb3VuZC9zb2MvZnNsL2ZzbF9zYWku
YyB8IDU0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tDQogMSBmaWxl
IGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0
IGEvc291bmQvc29jL2ZzbC9mc2xfc2FpLmMgYi9zb3VuZC9zb2MvZnNsL2ZzbF9zYWkuYw0KaW5k
ZXggODYyM2I3Zjg4MmI5Li43ZmQxYTgxZWMxYWEgMTAwNjQ0DQotLS0gYS9zb3VuZC9zb2MvZnNs
L2ZzbF9zYWkuYw0KKysrIGIvc291bmQvc29jL2ZzbC9mc2xfc2FpLmMNCkBAIC01OTYsMTUgKzU5
Niw4IEBAIHN0YXRpYyBpbnQgZnNsX3NhaV9zdGFydHVwKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVh
bSAqc3Vic3RyZWFtLA0KIHsNCiAJc3RydWN0IGZzbF9zYWkgKnNhaSA9IHNuZF9zb2NfZGFpX2dl
dF9kcnZkYXRhKGNwdV9kYWkpOw0KIAlib29sIHR4ID0gc3Vic3RyZWFtLT5zdHJlYW0gPT0gU05E
UlZfUENNX1NUUkVBTV9QTEFZQkFDSzsNCi0Jc3RydWN0IGRldmljZSAqZGV2ID0gJnNhaS0+cGRl
di0+ZGV2Ow0KIAlpbnQgcmV0Ow0KIA0KLQlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoc2FpLT5i
dXNfY2xrKTsNCi0JaWYgKHJldCkgew0KLQkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZW5hYmxl
IGJ1cyBjbG9jazogJWRcbiIsIHJldCk7DQotCQlyZXR1cm4gcmV0Ow0KLQl9DQotDQogCXJlZ21h
cF91cGRhdGVfYml0cyhzYWktPnJlZ21hcCwgRlNMX1NBSV94Q1IzKHR4KSwgRlNMX1NBSV9DUjNf
VFJDRSwNCiAJCQkgICBGU0xfU0FJX0NSM19UUkNFKTsNCiANCkBAIC02MjEsOCArNjE0LDYgQEAg
c3RhdGljIHZvaWQgZnNsX3NhaV9zaHV0ZG93bihzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1
YnN0cmVhbSwNCiAJYm9vbCB0eCA9IHN1YnN0cmVhbS0+c3RyZWFtID09IFNORFJWX1BDTV9TVFJF
QU1fUExBWUJBQ0s7DQogDQogCXJlZ21hcF91cGRhdGVfYml0cyhzYWktPnJlZ21hcCwgRlNMX1NB
SV94Q1IzKHR4KSwgRlNMX1NBSV9DUjNfVFJDRSwgMCk7DQotDQotCWNsa19kaXNhYmxlX3VucHJl
cGFyZShzYWktPmJ1c19jbGspOw0KIH0NCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IHNuZF9zb2Nf
ZGFpX29wcyBmc2xfc2FpX3BjbV9kYWlfb3BzID0gew0KQEAgLTkzMiw2ICs5MjMsMTQgQEAgc3Rh
dGljIGludCBmc2xfc2FpX3J1bnRpbWVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQogew0K
IAlzdHJ1Y3QgZnNsX3NhaSAqc2FpID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQogDQorCWlmIChz
YWktPm1jbGtfc3RyZWFtcyAmIEJJVChTTkRSVl9QQ01fU1RSRUFNX0NBUFRVUkUpKQ0KKwkJY2xr
X2Rpc2FibGVfdW5wcmVwYXJlKHNhaS0+bWNsa19jbGtbc2FpLT5tY2xrX2lkWzBdXSk7DQorDQor
CWlmIChzYWktPm1jbGtfc3RyZWFtcyAmIEJJVChTTkRSVl9QQ01fU1RSRUFNX1BMQVlCQUNLKSkN
CisJCWNsa19kaXNhYmxlX3VucHJlcGFyZShzYWktPm1jbGtfY2xrW3NhaS0+bWNsa19pZFsxXV0p
Ow0KKw0KKwljbGtfZGlzYWJsZV91bnByZXBhcmUoc2FpLT5idXNfY2xrKTsNCisNCiAJcmVnY2Fj
aGVfY2FjaGVfb25seShzYWktPnJlZ21hcCwgdHJ1ZSk7DQogCXJlZ2NhY2hlX21hcmtfZGlydHko
c2FpLT5yZWdtYXApOw0KIA0KQEAgLTk0MSw2ICs5NDAsMjUgQEAgc3RhdGljIGludCBmc2xfc2Fp
X3J1bnRpbWVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQogc3RhdGljIGludCBmc2xfc2Fp
X3J1bnRpbWVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCiB7DQogCXN0cnVjdCBmc2xfc2Fp
ICpzYWkgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCisJaW50IHJldDsNCisNCisJcmV0ID0gY2xr
X3ByZXBhcmVfZW5hYmxlKHNhaS0+YnVzX2Nsayk7DQorCWlmIChyZXQpIHsNCisJCWRldl9lcnIo
ZGV2LCAiZmFpbGVkIHRvIGVuYWJsZSBidXMgY2xvY2s6ICVkXG4iLCByZXQpOw0KKwkJcmV0dXJu
IHJldDsNCisJfQ0KKw0KKwlpZiAoc2FpLT5tY2xrX3N0cmVhbXMgJiBCSVQoU05EUlZfUENNX1NU
UkVBTV9QTEFZQkFDSykpIHsNCisJCXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShzYWktPm1jbGtf
Y2xrW3NhaS0+bWNsa19pZFsxXV0pOw0KKwkJaWYgKHJldCkNCisJCQlnb3RvIGRpc2FibGVfYnVz
X2NsazsNCisJfQ0KKw0KKwlpZiAoc2FpLT5tY2xrX3N0cmVhbXMgJiBCSVQoU05EUlZfUENNX1NU
UkVBTV9DQVBUVVJFKSkgew0KKwkJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKHNhaS0+bWNsa19j
bGtbc2FpLT5tY2xrX2lkWzBdXSk7DQorCQlpZiAocmV0KQ0KKwkJCWdvdG8gZGlzYWJsZV90eF9j
bGs7DQorCX0NCiANCiAJcmVnY2FjaGVfY2FjaGVfb25seShzYWktPnJlZ21hcCwgZmFsc2UpOw0K
IAlyZWdtYXBfd3JpdGUoc2FpLT5yZWdtYXAsIEZTTF9TQUlfVENTUiwgRlNMX1NBSV9DU1JfU1Ip
Ow0KQEAgLTk0OCw3ICs5NjYsMjMgQEAgc3RhdGljIGludCBmc2xfc2FpX3J1bnRpbWVfcmVzdW1l
KHN0cnVjdCBkZXZpY2UgKmRldikNCiAJdXNsZWVwX3JhbmdlKDEwMDAsIDIwMDApOw0KIAlyZWdt
YXBfd3JpdGUoc2FpLT5yZWdtYXAsIEZTTF9TQUlfVENTUiwgMCk7DQogCXJlZ21hcF93cml0ZShz
YWktPnJlZ21hcCwgRlNMX1NBSV9SQ1NSLCAwKTsNCi0JcmV0dXJuIHJlZ2NhY2hlX3N5bmMoc2Fp
LT5yZWdtYXApOw0KKw0KKwlyZXQgPSByZWdjYWNoZV9zeW5jKHNhaS0+cmVnbWFwKTsNCisJaWYg
KHJldCkNCisJCWdvdG8gZGlzYWJsZV9yeF9jbGs7DQorDQorCXJldHVybiAwOw0KKw0KK2Rpc2Fi
bGVfcnhfY2xrOg0KKwlpZiAoc2FpLT5tY2xrX3N0cmVhbXMgJiBCSVQoU05EUlZfUENNX1NUUkVB
TV9DQVBUVVJFKSkNCisJCWNsa19kaXNhYmxlX3VucHJlcGFyZShzYWktPm1jbGtfY2xrW3NhaS0+
bWNsa19pZFswXV0pOw0KK2Rpc2FibGVfdHhfY2xrOg0KKwlpZiAoc2FpLT5tY2xrX3N0cmVhbXMg
JiBCSVQoU05EUlZfUENNX1NUUkVBTV9QTEFZQkFDSykpDQorCQljbGtfZGlzYWJsZV91bnByZXBh
cmUoc2FpLT5tY2xrX2Nsa1tzYWktPm1jbGtfaWRbMV1dKTsNCitkaXNhYmxlX2J1c19jbGs6DQor
CWNsa19kaXNhYmxlX3VucHJlcGFyZShzYWktPmJ1c19jbGspOw0KKw0KKwlyZXR1cm4gcmV0Ow0K
IH0NCiAjZW5kaWYgLyogQ09ORklHX1BNICovDQogDQotLSANCjIuMTcuMQ0KDQo=

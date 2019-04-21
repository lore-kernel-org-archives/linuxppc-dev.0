Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BF5C10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 19:45:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 362F120870
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 19:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KfiJ4Cck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362F120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nKtl1qvZzDqRR
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 05:45:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.69; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=daniel.baluta@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="KfiJ4Cck"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00069.outbound.protection.outlook.com [40.107.0.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nKlw19xszDqTX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 05:39:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qL6ZZD3fwH+xgBMn5jL3E9WsCIWNJ9kqqLymxMnIOOw=;
 b=KfiJ4CckXicMtKXP4WgagqESekkQeJLJ0zxddpeA1rNgO7T5MINBwscI3LVwagQTBaz3S0gbnzG292kZ9gK0XgdsMpSf9NhVaufDhMJ/tiK9MBJURC1n1PVuv/qbMGLKqKT3rAqKAjiz3PFIk+MbnCfYZxu27a1N5juIzMcMcdI=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3470.eurprd04.prod.outlook.com (52.134.3.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Sun, 21 Apr 2019 19:39:11 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6%6]) with mapi id 15.20.1813.017; Sun, 21 Apr 2019
 19:39:11 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Subject: [PATCH 3/3 v3] ASoC: fsl_sai: Move clock operation to PM runtime
Thread-Topic: [PATCH 3/3 v3] ASoC: fsl_sai: Move clock operation to PM runtime
Thread-Index: AQHU+HnkH3aZLDNrm0yYRps8+ynKpg==
Date: Sun, 21 Apr 2019 19:39:10 +0000
Message-ID: <20190421193853.10188-4-daniel.baluta@nxp.com>
References: <20190421193853.10188-1-daniel.baluta@nxp.com>
In-Reply-To: <20190421193853.10188-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P18901CA0001.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::11) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e536efe8-d4aa-48dc-a3d0-08d6c691067d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR0402MB3470; 
x-ms-traffictypediagnostic: VI1PR0402MB3470:
x-microsoft-antispam-prvs: <VI1PR0402MB347088067EBD2A42D3AA4299F9210@VI1PR0402MB3470.eurprd04.prod.outlook.com>
x-forefront-prvs: 0014E2CF50
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(39860400002)(366004)(376002)(396003)(346002)(189003)(199004)(3846002)(6116002)(86362001)(71190400001)(71200400001)(44832011)(66476007)(64756008)(66556008)(66446008)(76176011)(66946007)(73956011)(6512007)(2906002)(6916009)(6486002)(50226002)(486006)(8936002)(476003)(2616005)(54906003)(11346002)(8676002)(305945005)(81156014)(6436002)(53936002)(1076003)(52116002)(1730700003)(7416002)(81166006)(7736002)(14444005)(256004)(5640700003)(186003)(102836004)(446003)(478600001)(14454004)(316002)(68736007)(4326008)(26005)(66066001)(2501003)(6506007)(25786009)(386003)(2351001)(99286004)(97736004)(36756003)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3470;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: c5vIJjM3i1gA4dQf4XNgfJnlcQmPzDB3r2rLdBni84tQfZRd9aZ0VhBqIc82/8LvYYVqma9fzSmIbTgOPxCY3dcXMDzSsmm1TEFizmhBnbgtAtPRZS+asMUHLKKlO6JFLxkByEh3uPAtQ5A0kR7AVCi/irk0zJEu1OlDH9ByH3SdG1qxqnqeUal0IcdUxQWQ5G/nqt2OueegF6QtlYW26dl6I3UsKLiZCYJyg0xF6H8O4Ru/iQ4WTFpYyzEIwbTSL2rkyuksJhUHqfP2qc2ItnDHYVCz69RrmvIiZqUb5o2bFxIflacIlT8w0mYNCuC9kBTGMiWE73OXfBrhzGwDgvelFKz1T/T20kys4GOTytxRT83XbfO1R7rS6SOXRHfWTOyE3H7yVY3avhluQTeb2Hsl40IBkSpjl7wivF/P7gE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e536efe8-d4aa-48dc-a3d0-08d6c691067d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2019 19:39:10.8904 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3470
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
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
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
YyB8IDYwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tDQogMSBmaWxl
IGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0
IGEvc291bmQvc29jL2ZzbC9mc2xfc2FpLmMgYi9zb3VuZC9zb2MvZnNsL2ZzbF9zYWkuYw0KaW5k
ZXggODYyM2I3Zjg4MmI5Li4xM2E0NjIzNjBlZDMgMTAwNjQ0DQotLS0gYS9zb3VuZC9zb2MvZnNs
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
ZGFpX29wcyBmc2xfc2FpX3BjbV9kYWlfb3BzID0gew0KQEAgLTkzMiw2ICs5MjMsMTYgQEAgc3Rh
dGljIGludCBmc2xfc2FpX3J1bnRpbWVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQogew0K
IAlzdHJ1Y3QgZnNsX3NhaSAqc2FpID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQogDQorCWlmICgh
c2FpLT5pc19zbGF2ZV9tb2RlKSB7DQorCQlpZiAoc2FpLT5tY2xrX3N0cmVhbXMgJiBCSVQoU05E
UlZfUENNX1NUUkVBTV9DQVBUVVJFKSkNCisJCQljbGtfZGlzYWJsZV91bnByZXBhcmUoc2FpLT5t
Y2xrX2Nsa1tzYWktPm1jbGtfaWRbMF1dKTsNCisNCisJCWlmIChzYWktPm1jbGtfc3RyZWFtcyAm
IEJJVChTTkRSVl9QQ01fU1RSRUFNX1BMQVlCQUNLKSkNCisJCQljbGtfZGlzYWJsZV91bnByZXBh
cmUoc2FpLT5tY2xrX2Nsa1tzYWktPm1jbGtfaWRbMV1dKTsNCisJfQ0KKw0KKwljbGtfZGlzYWJs
ZV91bnByZXBhcmUoc2FpLT5idXNfY2xrKTsNCisNCiAJcmVnY2FjaGVfY2FjaGVfb25seShzYWkt
PnJlZ21hcCwgdHJ1ZSk7DQogCXJlZ2NhY2hlX21hcmtfZGlydHkoc2FpLT5yZWdtYXApOw0KIA0K
QEAgLTk0MSw2ICs5NDIsMjcgQEAgc3RhdGljIGludCBmc2xfc2FpX3J1bnRpbWVfc3VzcGVuZChz
dHJ1Y3QgZGV2aWNlICpkZXYpDQogc3RhdGljIGludCBmc2xfc2FpX3J1bnRpbWVfcmVzdW1lKHN0
cnVjdCBkZXZpY2UgKmRldikNCiB7DQogCXN0cnVjdCBmc2xfc2FpICpzYWkgPSBkZXZfZ2V0X2Ry
dmRhdGEoZGV2KTsNCisJaW50IHJldDsNCisNCisJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKHNh
aS0+YnVzX2Nsayk7DQorCWlmIChyZXQpIHsNCisJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGVu
YWJsZSBidXMgY2xvY2s6ICVkXG4iLCByZXQpOw0KKwkJcmV0dXJuIHJldDsNCisJfQ0KKw0KKwlp
ZiAoIXNhaS0+aXNfc2xhdmVfbW9kZSkgew0KKwkJaWYgKHNhaS0+bWNsa19zdHJlYW1zICYgQklU
KFNORFJWX1BDTV9TVFJFQU1fUExBWUJBQ0spKSB7DQorCQkJcmV0ID0gY2xrX3ByZXBhcmVfZW5h
YmxlKHNhaS0+bWNsa19jbGtbc2FpLT5tY2xrX2lkWzFdXSk7DQorCQkJaWYgKHJldCkNCisJCQkJ
Z290byBkaXNhYmxlX2J1c19jbGs7DQorCQl9DQorDQorCQlpZiAoc2FpLT5tY2xrX3N0cmVhbXMg
JiBCSVQoU05EUlZfUENNX1NUUkVBTV9DQVBUVVJFKSkgew0KKwkJCXJldCA9IGNsa19wcmVwYXJl
X2VuYWJsZShzYWktPm1jbGtfY2xrW3NhaS0+bWNsa19pZFswXV0pOw0KKwkJCWlmIChyZXQpDQor
CQkJCWdvdG8gZGlzYWJsZV90eF9jbGs7DQorCQl9DQorCX0NCiANCiAJcmVnY2FjaGVfY2FjaGVf
b25seShzYWktPnJlZ21hcCwgZmFsc2UpOw0KIAlyZWdtYXBfd3JpdGUoc2FpLT5yZWdtYXAsIEZT
TF9TQUlfVENTUiwgRlNMX1NBSV9DU1JfU1IpOw0KQEAgLTk0OCw3ICs5NzAsMjUgQEAgc3RhdGlj
IGludCBmc2xfc2FpX3J1bnRpbWVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCiAJdXNsZWVw
X3JhbmdlKDEwMDAsIDIwMDApOw0KIAlyZWdtYXBfd3JpdGUoc2FpLT5yZWdtYXAsIEZTTF9TQUlf
VENTUiwgMCk7DQogCXJlZ21hcF93cml0ZShzYWktPnJlZ21hcCwgRlNMX1NBSV9SQ1NSLCAwKTsN
Ci0JcmV0dXJuIHJlZ2NhY2hlX3N5bmMoc2FpLT5yZWdtYXApOw0KKw0KKwlyZXQgPSByZWdjYWNo
ZV9zeW5jKHNhaS0+cmVnbWFwKTsNCisJaWYgKHJldCkNCisJCWdvdG8gZGlzYWJsZV9yeF9jbGs7
DQorDQorCXJldHVybiAwOw0KKw0KK2Rpc2FibGVfcnhfY2xrOg0KKwlpZiAoIXNhaS0+aXNfc2xh
dmVfbW9kZSAmJg0KKwkgICAgKHNhaS0+bWNsa19zdHJlYW1zICYgQklUKFNORFJWX1BDTV9TVFJF
QU1fQ0FQVFVSRSkpKQ0KKwkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHNhaS0+bWNsa19jbGtbc2Fp
LT5tY2xrX2lkWzBdXSk7DQorZGlzYWJsZV90eF9jbGs6DQorCWlmICghc2FpLT5pc19zbGF2ZV9t
b2RlICYmDQorCSAgICAoc2FpLT5tY2xrX3N0cmVhbXMgJiBCSVQoU05EUlZfUENNX1NUUkVBTV9Q
TEFZQkFDSykpKQ0KKwkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHNhaS0+bWNsa19jbGtbc2FpLT5t
Y2xrX2lkWzFdXSk7DQorZGlzYWJsZV9idXNfY2xrOg0KKwljbGtfZGlzYWJsZV91bnByZXBhcmUo
c2FpLT5idXNfY2xrKTsNCisNCisJcmV0dXJuIHJldDsNCiB9DQogI2VuZGlmIC8qIENPTkZJR19Q
TSAqLw0KIA0KLS0gDQoyLjE3LjENCg0K

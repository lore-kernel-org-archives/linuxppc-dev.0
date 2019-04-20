Return-Path: <SRS0=K0D4=SW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7F8C282DD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 16:04:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BABB20651
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 16:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P0CSoMLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BABB20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44md2Q51QfzDqTb
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 02:04:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.81; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=daniel.baluta@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="P0CSoMLe"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00081.outbound.protection.outlook.com [40.107.0.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44mcwN4sZCzDqJ2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Apr 2019 01:59:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5cEMUO1KurbKmR6e+jJZ/zLIeqiX0xnffzZZ7zOFiI=;
 b=P0CSoMLe61Oz0BgFOkQem3WyGgo+KWOoe+1XaX51OOUZI0A20OSIe1qjpVh3KUkST2A9sB693els+ClgxogcWbCz3L74kJwvebPZd87pY+nlDL82pRbGNTs3IpFp8em4p/Zh6EQxvrb2cktL4wu9cl23eBF+sIeW4PO7WkFNmO4=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2783.eurprd04.prod.outlook.com (10.172.255.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.11; Sat, 20 Apr 2019 15:59:05 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6%6]) with mapi id 15.20.1813.017; Sat, 20 Apr 2019
 15:59:05 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: fsl: Move clock operation to PM runtime
Thread-Topic: [PATCH 2/2] ASoC: fsl: Move clock operation to PM runtime
Thread-Index: AQHU95H6CnqPCJo73E6YBTN1iyGeSw==
Date: Sat, 20 Apr 2019 15:59:05 +0000
Message-ID: <20190420155846.10027-3-daniel.baluta@nxp.com>
References: <20190420155846.10027-1-daniel.baluta@nxp.com>
In-Reply-To: <20190420155846.10027-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VE1PR03CA0042.eurprd03.prod.outlook.com
 (2603:10a6:803:118::31) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4f9df21-848c-48e0-4f42-08d6c5a91d32
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR0402MB2783; 
x-ms-traffictypediagnostic: VI1PR0402MB2783:
x-microsoft-antispam-prvs: <VI1PR0402MB2783383853B341BEB4EE7816F9200@VI1PR0402MB2783.eurprd04.prod.outlook.com>
x-forefront-prvs: 0013079544
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(396003)(376002)(39860400002)(136003)(366004)(199004)(189003)(54906003)(99286004)(11346002)(73956011)(68736007)(7736002)(5640700003)(6116002)(3846002)(6512007)(305945005)(2906002)(2351001)(102836004)(446003)(386003)(6506007)(53936002)(2616005)(76176011)(186003)(486006)(52116002)(26005)(476003)(71200400001)(97736004)(5660300002)(6436002)(66556008)(2501003)(66066001)(14444005)(256004)(44832011)(66946007)(64756008)(36756003)(71190400001)(81156014)(81166006)(8676002)(316002)(66476007)(478600001)(1730700003)(6916009)(1076003)(14454004)(8936002)(86362001)(25786009)(66446008)(7416002)(4326008)(6486002)(50226002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2783;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1u7SxIlrp+jEl054r9ek0E8BrYr/HzqJP+eG3E1oRbUnv56Fi9JFRN0ZE/oH2UvX7rHkzgjKFCyL/LuaONO4tjUXaLKseBUD6SjHv1a8w3KiWCKzPgY1Y5emgaRJuKLPLc8lHeluu1+obzG6SqD0iuMkzp3cSUiSTgN4csiAP86Apy501Qt89CpDImMrMruZs7SNX4ox7FfVJsWb8j8W4tUt8dyKjut3eWevwrbixdxv6xrBfZZAT/R42uDMTOOYlvDyjePXyvP5hl1v6iypvaLcm96FqLziE4vLMz06tTmhIdHsToU4IWAkWH1eu4m1wdzbmZKSgNwT9vzpqMYVRehG7MRbh4MPqXc72/14zIklKPpdpyZaYSN4koaCGriPDVFJzS5jSqJvoOt3Inacj8ThWCKMQ+dHIrFpGWQpVDI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f9df21-848c-48e0-4f42-08d6c5a91d32
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2019 15:59:05.2637 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2783
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
biBjbG9ja3Mgd2hlbiBkZXZpY2UgZW50ZXJzIHN1c3BlbmQvcmVzdW1lLiBUaGlzDQpoZWxwcyBz
YXZpbmcgcG93ZXIuDQoNClNpZ25lZC1vZmYtYnk6IFNoZW5naml1IFdhbmcgPHNoZW5naml1Lndh
bmdAbnhwLmNvbT4NClNpZ25lZC1vZmYtYnk6IERhbmllbCBCYWx1dGEgPGRhbmllbC5iYWx1dGFA
bnhwLmNvbT4NCi0tLQ0KIHNvdW5kL3NvYy9mc2wvZnNsX3NhaS5jIHwgNTQgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNDQgaW5zZXJ0
aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvZnNsL2Zz
bF9zYWkuYyBiL3NvdW5kL3NvYy9mc2wvZnNsX3NhaS5jDQppbmRleCBhZWViMDdiNzQxNzcuLmEy
MjRjMDdjZTMxZiAxMDA2NDQNCi0tLSBhL3NvdW5kL3NvYy9mc2wvZnNsX3NhaS5jDQorKysgYi9z
b3VuZC9zb2MvZnNsL2ZzbF9zYWkuYw0KQEAgLTU5NCwxNSArNTk0LDggQEAgc3RhdGljIGludCBm
c2xfc2FpX3N0YXJ0dXAoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0sDQogew0K
IAlzdHJ1Y3QgZnNsX3NhaSAqc2FpID0gc25kX3NvY19kYWlfZ2V0X2RydmRhdGEoY3B1X2RhaSk7
DQogCWJvb2wgdHggPSBzdWJzdHJlYW0tPnN0cmVhbSA9PSBTTkRSVl9QQ01fU1RSRUFNX1BMQVlC
QUNLOw0KLQlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmc2FpLT5wZGV2LT5kZXY7DQogCWludCByZXQ7
DQogDQotCXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShzYWktPmJ1c19jbGspOw0KLQlpZiAocmV0
KSB7DQotCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBlbmFibGUgYnVzIGNsb2NrOiAlZFxuIiwg
cmV0KTsNCi0JCXJldHVybiByZXQ7DQotCX0NCi0NCiAJcmVnbWFwX3VwZGF0ZV9iaXRzKHNhaS0+
cmVnbWFwLCBGU0xfU0FJX3hDUjModHgpLCBGU0xfU0FJX0NSM19UUkNFLA0KIAkJCSAgIEZTTF9T
QUlfQ1IzX1RSQ0UpOw0KIA0KQEAgLTYxOSw4ICs2MTIsNiBAQCBzdGF0aWMgdm9pZCBmc2xfc2Fp
X3NodXRkb3duKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLA0KIAlib29sIHR4
ID0gc3Vic3RyZWFtLT5zdHJlYW0gPT0gU05EUlZfUENNX1NUUkVBTV9QTEFZQkFDSzsNCiANCiAJ
cmVnbWFwX3VwZGF0ZV9iaXRzKHNhaS0+cmVnbWFwLCBGU0xfU0FJX3hDUjModHgpLCBGU0xfU0FJ
X0NSM19UUkNFLCAwKTsNCi0NCi0JY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHNhaS0+YnVzX2Nsayk7
DQogfQ0KIA0KIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX3NvY19kYWlfb3BzIGZzbF9zYWlfcGNt
X2RhaV9vcHMgPSB7DQpAQCAtOTI1LDYgKzkxNiwxNCBAQCBzdGF0aWMgaW50IGZzbF9zYWlfcnVu
dGltZV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCiB7DQogCXN0cnVjdCBmc2xfc2FpICpz
YWkgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCiANCisJaWYgKHNhaS0+bWNsa19zdHJlYW1zICYg
QklUKFNORFJWX1BDTV9TVFJFQU1fQ0FQVFVSRSkpDQorCQljbGtfZGlzYWJsZV91bnByZXBhcmUo
c2FpLT5tY2xrX2Nsa1tzYWktPm1jbGtfaWRbMF1dKTsNCisNCisJaWYgKHNhaS0+bWNsa19zdHJl
YW1zICYgQklUKFNORFJWX1BDTV9TVFJFQU1fUExBWUJBQ0spKQ0KKwkJY2xrX2Rpc2FibGVfdW5w
cmVwYXJlKHNhaS0+bWNsa19jbGtbc2FpLT5tY2xrX2lkWzFdXSk7DQorDQorCWNsa19kaXNhYmxl
X3VucHJlcGFyZShzYWktPmJ1c19jbGspOw0KKw0KIAlyZWdjYWNoZV9jYWNoZV9vbmx5KHNhaS0+
cmVnbWFwLCB0cnVlKTsNCiAJcmVnY2FjaGVfbWFya19kaXJ0eShzYWktPnJlZ21hcCk7DQogDQpA
QCAtOTM0LDYgKzkzMywyNSBAQCBzdGF0aWMgaW50IGZzbF9zYWlfcnVudGltZV9zdXNwZW5kKHN0
cnVjdCBkZXZpY2UgKmRldikNCiBzdGF0aWMgaW50IGZzbF9zYWlfcnVudGltZV9yZXN1bWUoc3Ry
dWN0IGRldmljZSAqZGV2KQ0KIHsNCiAJc3RydWN0IGZzbF9zYWkgKnNhaSA9IGRldl9nZXRfZHJ2
ZGF0YShkZXYpOw0KKwlpbnQgcmV0Ow0KKw0KKwlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoc2Fp
LT5idXNfY2xrKTsNCisJaWYgKHJldCkgew0KKwkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZW5h
YmxlIGJ1cyBjbG9jazogJWRcbiIsIHJldCk7DQorCQlyZXR1cm4gcmV0Ow0KKwl9DQorDQorCWlm
IChzYWktPm1jbGtfc3RyZWFtcyAmIEJJVChTTkRSVl9QQ01fU1RSRUFNX1BMQVlCQUNLKSkgew0K
KwkJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKHNhaS0+bWNsa19jbGtbc2FpLT5tY2xrX2lkWzFd
XSk7DQorCQlpZiAocmV0KQ0KKwkJCWdvdG8gZGlzYWJsZV9idXNfY2xrOw0KKwl9DQorDQorCWlm
IChzYWktPm1jbGtfc3RyZWFtcyAmIEJJVChTTkRSVl9QQ01fU1RSRUFNX0NBUFRVUkUpKSB7DQor
CQlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoc2FpLT5tY2xrX2Nsa1tzYWktPm1jbGtfaWRbMF1d
KTsNCisJCWlmIChyZXQpDQorCQkJZ290byBkaXNhYmxlX3R4X2NsazsNCisJfQ0KIA0KIAlyZWdj
YWNoZV9jYWNoZV9vbmx5KHNhaS0+cmVnbWFwLCBmYWxzZSk7DQogCXJlZ21hcF93cml0ZShzYWkt
PnJlZ21hcCwgRlNMX1NBSV9UQ1NSLCBGU0xfU0FJX0NTUl9TUik7DQpAQCAtOTQxLDcgKzk1OSwy
MyBAQCBzdGF0aWMgaW50IGZzbF9zYWlfcnVudGltZV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2
KQ0KIAl1c2xlZXBfcmFuZ2UoMTAwMCwgMjAwMCk7DQogCXJlZ21hcF93cml0ZShzYWktPnJlZ21h
cCwgRlNMX1NBSV9UQ1NSLCAwKTsNCiAJcmVnbWFwX3dyaXRlKHNhaS0+cmVnbWFwLCBGU0xfU0FJ
X1JDU1IsIDApOw0KLQlyZXR1cm4gcmVnY2FjaGVfc3luYyhzYWktPnJlZ21hcCk7DQorDQorCXJl
dCA9IHJlZ2NhY2hlX3N5bmMoc2FpLT5yZWdtYXApOw0KKwlpZiAocmV0KQ0KKwkJZ290byBkaXNh
YmxlX3J4X2NsazsNCisNCisJcmV0dXJuIDA7DQorDQorZGlzYWJsZV9yeF9jbGs6DQorCWlmIChz
YWktPm1jbGtfc3RyZWFtcyAmIEJJVChTTkRSVl9QQ01fU1RSRUFNX0NBUFRVUkUpKQ0KKwkJY2xr
X2Rpc2FibGVfdW5wcmVwYXJlKHNhaS0+bWNsa19jbGtbc2FpLT5tY2xrX2lkWzBdXSk7DQorZGlz
YWJsZV90eF9jbGs6DQorCWlmIChzYWktPm1jbGtfc3RyZWFtcyAmIEJJVChTTkRSVl9QQ01fU1RS
RUFNX1BMQVlCQUNLKSkNCisJCWNsa19kaXNhYmxlX3VucHJlcGFyZShzYWktPm1jbGtfY2xrW3Nh
aS0+bWNsa19pZFsxXV0pOw0KK2Rpc2FibGVfYnVzX2NsazoNCisJY2xrX2Rpc2FibGVfdW5wcmVw
YXJlKHNhaS0+YnVzX2Nsayk7DQorDQorCXJldHVybiByZXQ7DQogfQ0KICNlbmRpZiAvKiBDT05G
SUdfUE0gKi8NCiANCi0tIA0KMi4xNy4xDQoNCg==

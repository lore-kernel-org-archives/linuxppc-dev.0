Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0801C10F14
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 02:39:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52027218A6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 02:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YcUDhJhv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52027218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nW560DX5zDqRg
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 12:39:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.2.85; helo=eur02-ve1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="YcUDhJhv"; 
 dkim-atps=neutral
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20085.outbound.protection.outlook.com [40.107.2.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nVwt39vZzDqQg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 12:32:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIDtGqsZ4hyusNI+iGVPGwIuHyOEDuPBAGu6BM305XQ=;
 b=YcUDhJhvuQXSEdYdfbwu6blectA5EglL+ywL49Z67lIT+7sUx1YINg8ylaAS8V2mFkd9lrgkwN+vad04YItYm1mDlkjMRS6kXSCyZIsmFrkuEY4ks9+5I2mG4HR6u2mlXdK8fv2g/bs2WEhSuFvzUr098Xc9+rxRGd4rxYy1zlM=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6605.eurprd04.prod.outlook.com (20.179.234.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Mon, 22 Apr 2019 02:32:38 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 02:32:38 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH V5 3/3] ASoC: fsl_asrc: Unify the supported input and output
 rate
Thread-Topic: [PATCH V5 3/3] ASoC: fsl_asrc: Unify the supported input and
 output rate
Thread-Index: AQHU+LOnfeMM+Ok1Uk2Gil7KYRZEdQ==
Date: Mon, 22 Apr 2019 02:32:38 +0000
Message-ID: <841aa2c4256e418759422affe6c138fa55cd1785.1555900078.git.shengjiu.wang@nxp.com>
References: <cover.1555900078.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1555900078.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0P153CA0044.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::32) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2ab3753-acff-4c94-cb6c-08d6c6cac96b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6605; 
x-ms-traffictypediagnostic: VE1PR04MB6605:
x-microsoft-antispam-prvs: <VE1PR04MB6605E2871B816BDBCD10FB51E3220@VE1PR04MB6605.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(346002)(376002)(366004)(39860400002)(396003)(199004)(189003)(316002)(4326008)(36756003)(19627235002)(68736007)(14444005)(256004)(25786009)(14454004)(2201001)(478600001)(8936002)(50226002)(97736004)(7736002)(6116002)(3846002)(11346002)(446003)(6436002)(81156014)(305945005)(8676002)(81166006)(186003)(2501003)(73956011)(66066001)(66446008)(6486002)(66946007)(66476007)(66556008)(64756008)(26005)(386003)(5660300002)(76176011)(6506007)(102836004)(2906002)(118296001)(99286004)(52116002)(486006)(110136005)(86362001)(54906003)(71190400001)(71200400001)(476003)(2616005)(6512007)(53936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6605;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Bknl0HNIaOaB8eh7HaGGztPR6CkjU951mrPL96Mx+oyyrEDAhmwedpEWbCkMamX+H2eEQEdbwPuvhFNvNFE6iIm3gu3KfM4B7OjbYkMuhl5ROOpGjDf84JeO2NM0jX2uERo94p+WFPXKmc7An2iw7+nCtKguJtD1hIBlErbHmdbcpN7wEUr4VOd9HkVYCD98on2oObCHSBQ+0EfQxa3RoZs9HH4K3EQBB7ysjQYjf7kabfEOuPgawdj3lWTpADB8WiIrEfL6/fTPZDjWR9TIRSVBo5fLlt4qStzIvvmfuKXeaH/Qq3a5nWmnl+LywkQxFU7KtgyTwS3bZ64V9pRD5nlFUI5i2ZVq1sQX72U/T14g/m2F2ATIh1oZfxPrypeRram3aCJIg1is0c7FGXl9Hz1CixUOETes1nrzsldSFUE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ab3753-acff-4c94-cb6c-08d6c6cac96b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 02:32:38.8214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6605
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

VW5pZnkgdGhlIHN1cHBvcnRlZCBpbnB1dCBhbmQgb3V0cHV0IHJhdGUsIGFkZCB0aGUNCjEya0h6
LzI0a0h6LzEyOGtIeiB0byB0aGUgc3VwcG9ydCBsaXN0DQoNClNpZ25lZC1vZmYtYnk6IFNoZW5n
aml1IFdhbmcgPHNoZW5naml1LndhbmdAbnhwLmNvbT4NCi0tLQ0KIHNvdW5kL3NvYy9mc2wvZnNs
X2FzcmMuYyB8IDMyICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNo
YW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
c291bmQvc29jL2ZzbC9mc2xfYXNyYy5jIGIvc291bmQvc29jL2ZzbC9mc2xfYXNyYy5jDQppbmRl
eCA0Njc1ZWE0ZTgyMDQuLjg1YzI3OGVmZmRhMSAxMDA2NDQNCi0tLSBhL3NvdW5kL3NvYy9mc2wv
ZnNsX2FzcmMuYw0KKysrIGIvc291bmQvc29jL2ZzbC9mc2xfYXNyYy5jDQpAQCAtMjcsMTMgKzI3
LDE0IEBADQogCWRldl9kYmcoJmFzcmNfcHJpdi0+cGRldi0+ZGV2LCAiUGFpciAlYzogIiBmbXQs
ICdBJyArIGluZGV4LCAjI19fVkFfQVJHU19fKQ0KIA0KIC8qIENvcnJlc3BvbmRpbmcgdG8gcHJv
Y2Vzc19vcHRpb24gKi8NCi1zdGF0aWMgaW50IHN1cHBvcnRlZF9pbnB1dF9yYXRlW10gPSB7DQot
CTU1MTIsIDgwMDAsIDExMDI1LCAxNjAwMCwgMjIwNTAsIDMyMDAwLCA0NDEwMCwgNDgwMDAsIDY0
MDAwLCA4ODIwMCwNCi0JOTYwMDAsIDE3NjQwMCwgMTkyMDAwLA0KK3N0YXRpYyB1bnNpZ25lZCBp
bnQgc3VwcG9ydGVkX2FzcmNfcmF0ZVtdID0gew0KKwk1NTEyLCA4MDAwLCAxMTAyNSwgMTIwMDAs
IDE2MDAwLCAyMjA1MCwgMjQwMDAsIDMyMDAwLCA0NDEwMCwgNDgwMDAsDQorCTY0MDAwLCA4ODIw
MCwgOTYwMDAsIDEyODAwMCwgMTc2NDAwLCAxOTIwMDAsDQogfTsNCiANCi1zdGF0aWMgaW50IHN1
cHBvcnRlZF9hc3JjX3JhdGVbXSA9IHsNCi0JODAwMCwgMTEwMjUsIDE2MDAwLCAyMjA1MCwgMzIw
MDAsIDQ0MTAwLCA0ODAwMCwgNjQwMDAsIDg4MjAwLCA5NjAwMCwgMTc2NDAwLCAxOTIwMDAsDQor
c3RhdGljIHN0cnVjdCBzbmRfcGNtX2h3X2NvbnN0cmFpbnRfbGlzdCBmc2xfYXNyY19yYXRlX2Nv
bnN0cmFpbnRzID0gew0KKwkuY291bnQgPSBBUlJBWV9TSVpFKHN1cHBvcnRlZF9hc3JjX3JhdGUp
LA0KKwkubGlzdCA9IHN1cHBvcnRlZF9hc3JjX3JhdGUsDQogfTsNCiANCiAvKioNCkBAIC0yOTIs
MTEgKzI5MywxMSBAQCBzdGF0aWMgaW50IGZzbF9hc3JjX2NvbmZpZ19wYWlyKHN0cnVjdCBmc2xf
YXNyY19wYWlyICpwYWlyKQ0KIAlpZGVhbCA9IGNvbmZpZy0+aW5jbGsgPT0gSU5DTEtfTk9ORTsN
CiANCiAJLyogVmFsaWRhdGUgaW5wdXQgYW5kIG91dHB1dCBzYW1wbGUgcmF0ZXMgKi8NCi0JZm9y
IChpbiA9IDA7IGluIDwgQVJSQVlfU0laRShzdXBwb3J0ZWRfaW5wdXRfcmF0ZSk7IGluKyspDQot
CQlpZiAoaW5yYXRlID09IHN1cHBvcnRlZF9pbnB1dF9yYXRlW2luXSkNCisJZm9yIChpbiA9IDA7
IGluIDwgQVJSQVlfU0laRShzdXBwb3J0ZWRfYXNyY19yYXRlKTsgaW4rKykNCisJCWlmIChpbnJh
dGUgPT0gc3VwcG9ydGVkX2FzcmNfcmF0ZVtpbl0pDQogCQkJYnJlYWs7DQogDQotCWlmIChpbiA9
PSBBUlJBWV9TSVpFKHN1cHBvcnRlZF9pbnB1dF9yYXRlKSkgew0KKwlpZiAoaW4gPT0gQVJSQVlf
U0laRShzdXBwb3J0ZWRfYXNyY19yYXRlKSkgew0KIAkJcGFpcl9lcnIoInVuc3VwcG9ydGVkIGlu
cHV0IHNhbXBsZSByYXRlOiAlZEh6XG4iLCBpbnJhdGUpOw0KIAkJcmV0dXJuIC1FSU5WQUw7DQog
CX0NCkBAIC0zMTAsNyArMzExLDcgQEAgc3RhdGljIGludCBmc2xfYXNyY19jb25maWdfcGFpcihz
dHJ1Y3QgZnNsX2FzcmNfcGFpciAqcGFpcikNCiAJCXJldHVybiAtRUlOVkFMOw0KIAl9DQogDQot
CWlmICgob3V0cmF0ZSA+PSA4MDAwICYmIG91dHJhdGUgPD0gMzAwMDApICYmDQorCWlmICgob3V0
cmF0ZSA+PSA1NTEyICYmIG91dHJhdGUgPD0gMzAwMDApICYmDQogCSAgICAob3V0cmF0ZSA+IDI0
ICogaW5yYXRlIHx8IGlucmF0ZSA+IDggKiBvdXRyYXRlKSkgew0KIAkJcGFpcl9lcnIoImV4Y2Vl
ZCBzdXBwb3J0ZWQgcmF0aW8gcmFuZ2UgWzEvMjQsIDhdIGZvciBcDQogCQkJCWlucmF0ZS9vdXRy
YXRlOiAlZC8lZFxuIiwgaW5yYXRlLCBvdXRyYXRlKTsNCkBAIC00ODUsNyArNDg2LDkgQEAgc3Rh
dGljIGludCBmc2xfYXNyY19kYWlfc3RhcnR1cChzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1
YnN0cmVhbSwNCiAJCXNuZF9wY21faHdfY29uc3RyYWludF9zdGVwKHN1YnN0cmVhbS0+cnVudGlt
ZSwgMCwNCiAJCQkJCSAgIFNORFJWX1BDTV9IV19QQVJBTV9DSEFOTkVMUywgMik7DQogDQotCXJl
dHVybiAwOw0KKw0KKwlyZXR1cm4gc25kX3BjbV9od19jb25zdHJhaW50X2xpc3Qoc3Vic3RyZWFt
LT5ydW50aW1lLCAwLA0KKwkJCVNORFJWX1BDTV9IV19QQVJBTV9SQVRFLCAmZnNsX2FzcmNfcmF0
ZV9jb25zdHJhaW50cyk7DQogfQ0KIA0KIHN0YXRpYyBpbnQgZnNsX2FzcmNfZGFpX2h3X3BhcmFt
cyhzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwNCkBAIC01OTgsNyArNjAxLDYg
QEAgc3RhdGljIGludCBmc2xfYXNyY19kYWlfcHJvYmUoc3RydWN0IHNuZF9zb2NfZGFpICpkYWkp
DQogCXJldHVybiAwOw0KIH0NCiANCi0jZGVmaW5lIEZTTF9BU1JDX1JBVEVTCQkgU05EUlZfUENN
X1JBVEVfODAwMF8xOTIwMDANCiAjZGVmaW5lIEZTTF9BU1JDX0ZPUk1BVFMJKFNORFJWX1BDTV9G
TVRCSVRfUzI0X0xFIHwgXA0KIAkJCQkgU05EUlZfUENNX0ZNVEJJVF9TMTZfTEUgfCBcDQogCQkJ
CSBTTkRSVl9QQ01fRk1UQklUX1MyMF8zTEUpDQpAQCAtNjA5LDE0ICs2MTEsMTggQEAgc3RhdGlj
IGludCBmc2xfYXNyY19kYWlfcHJvYmUoc3RydWN0IHNuZF9zb2NfZGFpICpkYWkpDQogCQkuc3Ry
ZWFtX25hbWUgPSAiQVNSQy1QbGF5YmFjayIsDQogCQkuY2hhbm5lbHNfbWluID0gMSwNCiAJCS5j
aGFubmVsc19tYXggPSAxMCwNCi0JCS5yYXRlcyA9IEZTTF9BU1JDX1JBVEVTLA0KKwkJLnJhdGVf
bWluID0gNTUxMiwNCisJCS5yYXRlX21heCA9IDE5MjAwMCwNCisJCS5yYXRlcyA9IFNORFJWX1BD
TV9SQVRFX0tOT1QsDQogCQkuZm9ybWF0cyA9IEZTTF9BU1JDX0ZPUk1BVFMsDQogCX0sDQogCS5j
YXB0dXJlID0gew0KIAkJLnN0cmVhbV9uYW1lID0gIkFTUkMtQ2FwdHVyZSIsDQogCQkuY2hhbm5l
bHNfbWluID0gMSwNCiAJCS5jaGFubmVsc19tYXggPSAxMCwNCi0JCS5yYXRlcyA9IEZTTF9BU1JD
X1JBVEVTLA0KKwkJLnJhdGVfbWluID0gNTUxMiwNCisJCS5yYXRlX21heCA9IDE5MjAwMCwNCisJ
CS5yYXRlcyA9IFNORFJWX1BDTV9SQVRFX0tOT1QsDQogCQkuZm9ybWF0cyA9IEZTTF9BU1JDX0ZP
Uk1BVFMsDQogCX0sDQogCS5vcHMgPSAmZnNsX2FzcmNfZGFpX29wcywNCi0tIA0KMS45LjENCg0K

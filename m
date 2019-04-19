Return-Path: <SRS0=ts8b=SV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83612C282DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 10:30:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4733218EA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 10:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gvhSrw7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4733218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lsgR4vCSzDqW0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 20:30:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.13.89; helo=eur01-he1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="gvhSrw7L"; 
 dkim-atps=neutral
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr130089.outbound.protection.outlook.com [40.107.13.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lsWz5DkVzDqRX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 20:23:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dECI7J9J8JH+Rb+CFeGCnYlZF8Smt2mZoTqpDWI5UHQ=;
 b=gvhSrw7LjB3i8nD9uDIj72Iqdn97xlJ63fWoIlvU8gJdzIDfbhLICnElz+DAUVqsPhEsKp3drVMVeAf1vcNiS3rXT+srna/TCp6m4dOu7CeOpT1M1cIL4tG284uhTPKpKhtB6mAqeSAV5UDTgzVUULFWJqMhnPaeXJJDqfENRBk=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6349.eurprd04.prod.outlook.com (10.255.118.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Fri, 19 Apr 2019 10:23:56 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1813.013; Fri, 19 Apr 2019
 10:23:56 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH V4 3/3] ASoC: fsl_asrc: Unify the supported input and output
 rate
Thread-Topic: [PATCH V4 3/3] ASoC: fsl_asrc: Unify the supported input and
 output rate
Thread-Index: AQHU9pn+NSRrZ2vEvkaToIFbRKid0Q==
Date: Fri, 19 Apr 2019 10:23:56 +0000
Message-ID: <b450010bb24e18e01b78d32067d6efdb572a9cc4.1555669068.git.shengjiu.wang@nxp.com>
References: <cover.1555669068.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1555669068.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR03CA0082.apcprd03.prod.outlook.com
 (2603:1096:203:72::22) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2551633b-7f5d-473a-6c56-08d6c4b120f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6349; 
x-ms-traffictypediagnostic: VE1PR04MB6349:
x-microsoft-antispam-prvs: <VE1PR04MB6349E6FD754D3AD94762354AE3270@VE1PR04MB6349.eurprd04.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(376002)(136003)(366004)(346002)(189003)(199004)(97736004)(73956011)(19627235002)(25786009)(26005)(2501003)(2906002)(71190400001)(478600001)(7736002)(102836004)(2201001)(71200400001)(256004)(6506007)(386003)(14444005)(52116002)(53936002)(99286004)(66446008)(68736007)(66066001)(66476007)(64756008)(66556008)(3846002)(6116002)(86362001)(6436002)(6512007)(6486002)(76176011)(186003)(2616005)(316002)(54906003)(476003)(4326008)(486006)(5660300002)(8676002)(36756003)(81156014)(81166006)(118296001)(11346002)(110136005)(446003)(305945005)(14454004)(8936002)(50226002)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6349;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ns4P3rhh//B/W3HSl8ai9JNSGQ/3J5Og5XBSnjR6Xet9Yn+ZRxJQ0VdN6LOe36QPBFsQKFuVLLr9LLC2GmCDoAm+P+a2+OkhFmHba2g6uva8FPZrfR6OLCn+Uy+i4/7rw+GM/nN2O3VgqaIiMhI99ibeq384Mrtj1F7aNjCOObP4uNPQ/ScpLvBV1MojRGqa2MVhVsiI/pEPCTb+jX6dQsupeIgoKtzsmDcgmw3aCjMT19PYWmvWmr9rtHpzApoPW+BsBScNI5DlWQNTdt6STf9zHcstIW2y5vn7awX/1zb9487jLEkGXY9DBrJhPhCEqe/6n1sXTDD8iLkTIuo+KAuOq+wEfgtyTtHQ1ilBtL1i5aIQxxFV6NTot5D0AHuf4M103pSsHjTl+15wofuQPcNLd5LEFYBI56g4BvpTF8Q=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2551633b-7f5d-473a-6c56-08d6c4b120f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 10:23:56.4609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6349
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
eCAyYzRiYmMzNDk5ZGIuLjBkMDZlNzM4MjY0YSAxMDA2NDQNCi0tLSBhL3NvdW5kL3NvYy9mc2wv
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
LA0KKwkubGlzdCA9IHN1cHBvcnRlZF9hc3JjX3JhdGUsDQogfTsNCiANCiAvKioNCkBAIC0yOTMs
MTEgKzI5NCwxMSBAQCBzdGF0aWMgaW50IGZzbF9hc3JjX2NvbmZpZ19wYWlyKHN0cnVjdCBmc2xf
YXNyY19wYWlyICpwYWlyKQ0KIAlpZGVhbCA9IGNvbmZpZy0+aW5jbGsgPT0gSU5DTEtfTk9ORTsN
CiANCiAJLyogVmFsaWRhdGUgaW5wdXQgYW5kIG91dHB1dCBzYW1wbGUgcmF0ZXMgKi8NCi0JZm9y
IChpbiA9IDA7IGluIDwgQVJSQVlfU0laRShzdXBwb3J0ZWRfaW5wdXRfcmF0ZSk7IGluKyspDQot
CQlpZiAoaW5yYXRlID09IHN1cHBvcnRlZF9pbnB1dF9yYXRlW2luXSkNCisJZm9yIChpbiA9IDA7
IGluIDwgQVJSQVlfU0laRShzdXBwb3J0ZWRfYXNyY19yYXRlKTsgaW4rKykNCisJCWlmIChpbnJh
dGUgPT0gc3VwcG9ydGVkX2FzcmNfcmF0ZVtpbl0pDQogCQkJYnJlYWs7DQogDQotCWlmIChpbiA9
PSBBUlJBWV9TSVpFKHN1cHBvcnRlZF9pbnB1dF9yYXRlKSkgew0KKwlpZiAoaW4gPT0gQVJSQVlf
U0laRShzdXBwb3J0ZWRfYXNyY19yYXRlKSkgew0KIAkJcGFpcl9lcnIoInVuc3VwcG9ydGVkIGlu
cHV0IHNhbXBsZSByYXRlOiAlZEh6XG4iLCBpbnJhdGUpOw0KIAkJcmV0dXJuIC1FSU5WQUw7DQog
CX0NCkBAIC0zMTEsNyArMzEyLDcgQEAgc3RhdGljIGludCBmc2xfYXNyY19jb25maWdfcGFpcihz
dHJ1Y3QgZnNsX2FzcmNfcGFpciAqcGFpcikNCiAJCXJldHVybiAtRUlOVkFMOw0KIAl9DQogDQot
CWlmICgob3V0cmF0ZSA+PSA4MDAwICYmIG91dHJhdGUgPD0gMzAwMDApICYmDQorCWlmICgob3V0
cmF0ZSA+PSA1NTEyICYmIG91dHJhdGUgPD0gMzAwMDApICYmDQogCSAgICAob3V0cmF0ZSA+IDI0
ICogaW5yYXRlIHx8IGlucmF0ZSA+IDggKiBvdXRyYXRlKSkgew0KIAkJcGFpcl9lcnIoImV4Y2Vl
ZCBzdXBwb3J0ZWQgcmF0aW8gcmFuZ2UgKDEvMjQsIDgpIGZvciBpbnJhdGUvb3V0cmF0ZTogJWQv
JWRcbiIsDQogCQkJCWlucmF0ZSwgb3V0cmF0ZSk7DQpAQCAtNDkwLDcgKzQ5MSw5IEBAIHN0YXRp
YyBpbnQgZnNsX2FzcmNfZGFpX3N0YXJ0dXAoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJz
dHJlYW0sDQogCQlzbmRfcGNtX2h3X2NvbnN0cmFpbnRfc3RlcChzdWJzdHJlYW0tPnJ1bnRpbWUs
IDAsDQogCQkJCQkgICBTTkRSVl9QQ01fSFdfUEFSQU1fQ0hBTk5FTFMsIDIpOw0KIA0KLQlyZXR1
cm4gMDsNCisNCisJcmV0dXJuIHNuZF9wY21faHdfY29uc3RyYWludF9saXN0KHN1YnN0cmVhbS0+
cnVudGltZSwgMCwNCisJCQlTTkRSVl9QQ01fSFdfUEFSQU1fUkFURSwgJmZzbF9hc3JjX3JhdGVf
Y29uc3RyYWludHMpOw0KIH0NCiANCiBzdGF0aWMgaW50IGZzbF9hc3JjX2RhaV9od19wYXJhbXMo
c3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0sDQpAQCAtNjAzLDcgKzYwNiw2IEBA
IHN0YXRpYyBpbnQgZnNsX2FzcmNfZGFpX3Byb2JlKHN0cnVjdCBzbmRfc29jX2RhaSAqZGFpKQ0K
IAlyZXR1cm4gMDsNCiB9DQogDQotI2RlZmluZSBGU0xfQVNSQ19SQVRFUwkJIFNORFJWX1BDTV9S
QVRFXzgwMDBfMTkyMDAwDQogI2RlZmluZSBGU0xfQVNSQ19GT1JNQVRTCShTTkRSVl9QQ01fRk1U
QklUX1MyNF9MRSB8IFwNCiAJCQkJIFNORFJWX1BDTV9GTVRCSVRfUzE2X0xFIHwgXA0KIAkJCQkg
U05EUlZfUENNX0ZNVEJJVF9TMjBfM0xFKQ0KQEAgLTYxNCwxNCArNjE2LDE4IEBAIHN0YXRpYyBp
bnQgZnNsX2FzcmNfZGFpX3Byb2JlKHN0cnVjdCBzbmRfc29jX2RhaSAqZGFpKQ0KIAkJLnN0cmVh
bV9uYW1lID0gIkFTUkMtUGxheWJhY2siLA0KIAkJLmNoYW5uZWxzX21pbiA9IDEsDQogCQkuY2hh
bm5lbHNfbWF4ID0gMTAsDQotCQkucmF0ZXMgPSBGU0xfQVNSQ19SQVRFUywNCisJCS5yYXRlX21p
biA9IDU1MTIsDQorCQkucmF0ZV9tYXggPSAxOTIwMDAsDQorCQkucmF0ZXMgPSBTTkRSVl9QQ01f
UkFURV9LTk9ULA0KIAkJLmZvcm1hdHMgPSBGU0xfQVNSQ19GT1JNQVRTLA0KIAl9LA0KIAkuY2Fw
dHVyZSA9IHsNCiAJCS5zdHJlYW1fbmFtZSA9ICJBU1JDLUNhcHR1cmUiLA0KIAkJLmNoYW5uZWxz
X21pbiA9IDEsDQogCQkuY2hhbm5lbHNfbWF4ID0gMTAsDQotCQkucmF0ZXMgPSBGU0xfQVNSQ19S
QVRFUywNCisJCS5yYXRlX21pbiA9IDU1MTIsDQorCQkucmF0ZV9tYXggPSAxOTIwMDAsDQorCQku
cmF0ZXMgPSBTTkRSVl9QQ01fUkFURV9LTk9ULA0KIAkJLmZvcm1hdHMgPSBGU0xfQVNSQ19GT1JN
QVRTLA0KIAl9LA0KIAkub3BzID0gJmZzbF9hc3JjX2RhaV9vcHMsDQotLSANCjEuOS4xDQoNCg==

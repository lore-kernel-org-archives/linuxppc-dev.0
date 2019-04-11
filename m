Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E290AC10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 09:44:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6239C206B7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 09:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c4heea4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6239C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fx1b46TtzDqQ0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 19:44:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.8.70; helo=eur04-vi1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="c4heea4F"; 
 dkim-atps=neutral
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80070.outbound.protection.outlook.com [40.107.8.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fww26yFvzDqPS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 19:39:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+MVm1V/x7SJ5cLfhEfEx7/QOiK+PsRDP3DsTIHN3Qc=;
 b=c4heea4Ff+dNAAQrU6LnLq+BEWZ3epxMo2ERrFGFLL/H7/D3sGZZ/357uLUUZM9Kx5oTXKVP+Rg+9RiX4/Pj43A4HLdn4NVJq/SbzZJ2I3L5MJWpgZVHuvyiHgJpVwGkg3hXvAexk8Gv8sPAFVHA3h9osVVhRZeO+srtsIT6UP8=
Received: from AM0PR04MB6468.eurprd04.prod.outlook.com (20.179.253.81) by
 AM0PR04MB5492.eurprd04.prod.outlook.com (20.178.115.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Thu, 11 Apr 2019 09:39:09 +0000
Received: from AM0PR04MB6468.eurprd04.prod.outlook.com
 ([fe80::107:1bdc:981e:e292]) by AM0PR04MB6468.eurprd04.prod.outlook.com
 ([fe80::107:1bdc:981e:e292%4]) with mapi id 15.20.1792.009; Thu, 11 Apr 2019
 09:39:09 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH V2 2/2] ASoC: fsl_asrc: Unify the supported input and output
 rate
Thread-Topic: [PATCH V2 2/2] ASoC: fsl_asrc: Unify the supported input and
 output rate
Thread-Index: AQHU8EppMuNFFQY80EyrmodXmkmWqQ==
Date: Thu, 11 Apr 2019 09:39:09 +0000
Message-ID: <b7f4c8dd00743ddd09c33def00c1759757b8e743.1554975348.git.shengjiu.wang@nxp.com>
References: <cover.1554975348.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1554975348.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK2PR02CA0160.apcprd02.prod.outlook.com
 (2603:1096:201:1f::20) To AM0PR04MB6468.eurprd04.prod.outlook.com
 (2603:10a6:208:16e::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 133b2430-25bb-4507-c514-08d6be618bf5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:AM0PR04MB5492; 
x-ms-traffictypediagnostic: AM0PR04MB5492:
x-microsoft-antispam-prvs: <AM0PR04MB54926453DBFC7D4169BB39B1E32F0@AM0PR04MB5492.eurprd04.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(366004)(376002)(39860400002)(396003)(189003)(199004)(52116002)(50226002)(36756003)(8936002)(2616005)(106356001)(476003)(6512007)(71190400001)(446003)(486006)(11346002)(66066001)(81166006)(81156014)(8676002)(118296001)(105586002)(14444005)(19627235002)(256004)(2201001)(68736007)(5660300002)(97736004)(6436002)(54906003)(14454004)(110136005)(6486002)(2906002)(86362001)(6116002)(3846002)(316002)(7736002)(305945005)(508600001)(2501003)(25786009)(102836004)(71200400001)(99286004)(186003)(26005)(76176011)(53936002)(386003)(4326008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5492;
 H:AM0PR04MB6468.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gReJVSqXsyzAJBpaJ7aNzdhDQWVDJ/6rnJcLjoWz+h/P6LsiuV6w/rMHZpkKwWhwNHrMFjvQo7v4X0HDkrYY2YNK6l9cHCFVu+uFZMEHPk0/zJ9j97jmBlw8zhmH3t7Z6TwlWftbLXuniwczkpvvhOYG+waH5RMai+eBzaVDV7o0FRb39E6E74pqWdyvqaiVv2+Gpk4cYPJ22ADxTJM+Wbj60X9TBD3Dla/hOrc9ScJy2zrd98G3k4tL4m2LCT9tpBYx0EWhw/kick2zq72kAi+BvXZ8I8VxlgxxN4HAtUwKXMQmlmfAEWW4K3Lh3O1KOKwZbig8i3uGgSPFUcGwcEBrwbpu6rgQQxeTtEs50KAb3ZQzCtoRElPlQG+VVQlBop/imiHKzF+UXDchgGw23g9vyK/zpImJSjmU04saoIY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 133b2430-25bb-4507-c514-08d6be618bf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 09:39:09.2441 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5492
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
X2FzcmMuYyB8IDI5ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5n
ZWQsIDE4IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvc291
bmQvc29jL2ZzbC9mc2xfYXNyYy5jIGIvc291bmQvc29jL2ZzbC9mc2xfYXNyYy5jDQppbmRleCA1
ODU3ZDM4M2Q5NjIuLjQ0YmNjNGE3YjIzYiAxMDA2NDQNCi0tLSBhL3NvdW5kL3NvYy9mc2wvZnNs
X2FzcmMuYw0KKysrIGIvc291bmQvc29jL2ZzbC9mc2xfYXNyYy5jDQpAQCAtMjcsMTMgKzI3LDE0
IEBADQogCWRldl9kYmcoJmFzcmNfcHJpdi0+cGRldi0+ZGV2LCAiUGFpciAlYzogIiBmbXQsICdB
JyArIGluZGV4LCAjI19fVkFfQVJHU19fKQ0KIA0KIC8qIENvcnJlc3BvbmRpbmcgdG8gcHJvY2Vz
c19vcHRpb24gKi8NCi1zdGF0aWMgaW50IHN1cHBvcnRlZF9pbnB1dF9yYXRlW10gPSB7DQotCTU1
MTIsIDgwMDAsIDExMDI1LCAxNjAwMCwgMjIwNTAsIDMyMDAwLCA0NDEwMCwgNDgwMDAsIDY0MDAw
LCA4ODIwMCwNCi0JOTYwMDAsIDE3NjQwMCwgMTkyMDAwLA0KK3N0YXRpYyB1bnNpZ25lZCBpbnQg
c3VwcG9ydGVkX2FzcmNfcmF0ZVtdID0gew0KKwk1NTEyLCA4MDAwLCAxMTAyNSwgMTIwMDAsIDE2
MDAwLCAyMjA1MCwgMjQwMDAsIDMyMDAwLCA0NDEwMCwgNDgwMDAsDQorCTY0MDAwLCA4ODIwMCwg
OTYwMDAsIDEyODAwMCwgMTc2NDAwLCAxOTIwMDAsDQogfTsNCiANCi1zdGF0aWMgaW50IHN1cHBv
cnRlZF9hc3JjX3JhdGVbXSA9IHsNCi0JODAwMCwgMTEwMjUsIDE2MDAwLCAyMjA1MCwgMzIwMDAs
IDQ0MTAwLCA0ODAwMCwgNjQwMDAsIDg4MjAwLCA5NjAwMCwgMTc2NDAwLCAxOTIwMDAsDQorc3Rh
dGljIHN0cnVjdCBzbmRfcGNtX2h3X2NvbnN0cmFpbnRfbGlzdCBmc2xfYXNyY19yYXRlX2NvbnN0
cmFpbnRzID0gew0KKwkuY291bnQgPSBBUlJBWV9TSVpFKHN1cHBvcnRlZF9hc3JjX3JhdGUpLA0K
KwkubGlzdCA9IHN1cHBvcnRlZF9hc3JjX3JhdGUsDQogfTsNCiANCiAvKioNCkBAIC0zMDUsMTEg
KzMwNiwxMSBAQCBzdGF0aWMgaW50IGZzbF9hc3JjX2NvbmZpZ19wYWlyKHN0cnVjdCBmc2xfYXNy
Y19wYWlyICpwYWlyKQ0KIAlpZGVhbCA9IGNvbmZpZy0+aW5jbGsgPT0gSU5DTEtfTk9ORTsNCiAN
CiAJLyogVmFsaWRhdGUgaW5wdXQgYW5kIG91dHB1dCBzYW1wbGUgcmF0ZXMgKi8NCi0JZm9yIChp
biA9IDA7IGluIDwgQVJSQVlfU0laRShzdXBwb3J0ZWRfaW5wdXRfcmF0ZSk7IGluKyspDQotCQlp
ZiAoaW5yYXRlID09IHN1cHBvcnRlZF9pbnB1dF9yYXRlW2luXSkNCisJZm9yIChpbiA9IDA7IGlu
IDwgQVJSQVlfU0laRShzdXBwb3J0ZWRfYXNyY19yYXRlKTsgaW4rKykNCisJCWlmIChpbnJhdGUg
PT0gc3VwcG9ydGVkX2FzcmNfcmF0ZVtpbl0pDQogCQkJYnJlYWs7DQogDQotCWlmIChpbiA9PSBB
UlJBWV9TSVpFKHN1cHBvcnRlZF9pbnB1dF9yYXRlKSkgew0KKwlpZiAoaW4gPT0gQVJSQVlfU0la
RShzdXBwb3J0ZWRfYXNyY19yYXRlKSkgew0KIAkJcGFpcl9lcnIoInVuc3VwcG9ydGVkIGlucHV0
IHNhbXBsZSByYXRlOiAlZEh6XG4iLCBpbnJhdGUpOw0KIAkJcmV0dXJuIC1FSU5WQUw7DQogCX0N
CkBAIC01MDIsNyArNTAzLDkgQEAgc3RhdGljIGludCBmc2xfYXNyY19kYWlfc3RhcnR1cChzdHJ1
Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwNCiAJCXNuZF9wY21faHdfY29uc3RyYWlu
dF9zdGVwKHN1YnN0cmVhbS0+cnVudGltZSwgMCwNCiAJCQkJCSAgIFNORFJWX1BDTV9IV19QQVJB
TV9DSEFOTkVMUywgMik7DQogDQotCXJldHVybiAwOw0KKw0KKwlyZXR1cm4gc25kX3BjbV9od19j
b25zdHJhaW50X2xpc3Qoc3Vic3RyZWFtLT5ydW50aW1lLCAwLA0KKwkJCVNORFJWX1BDTV9IV19Q
QVJBTV9SQVRFLCAmZnNsX2FzcmNfcmF0ZV9jb25zdHJhaW50cyk7DQogfQ0KIA0KIHN0YXRpYyBp
bnQgZnNsX2FzcmNfZGFpX2h3X3BhcmFtcyhzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0
cmVhbSwNCkBAIC02MjYsMTQgKzYyOSwxOCBAQCBzdGF0aWMgaW50IGZzbF9hc3JjX2RhaV9wcm9i
ZShzdHJ1Y3Qgc25kX3NvY19kYWkgKmRhaSkNCiAJCS5zdHJlYW1fbmFtZSA9ICJBU1JDLVBsYXli
YWNrIiwNCiAJCS5jaGFubmVsc19taW4gPSAxLA0KIAkJLmNoYW5uZWxzX21heCA9IDEwLA0KLQkJ
LnJhdGVzID0gRlNMX0FTUkNfUkFURVMsDQorCQkucmF0ZV9taW4gPSA1NTEyLA0KKwkJLnJhdGVf
bWF4ID0gMTkyMDAwLA0KKwkJLnJhdGVzID0gU05EUlZfUENNX1JBVEVfS05PVCwNCiAJCS5mb3Jt
YXRzID0gRlNMX0FTUkNfRk9STUFUUywNCiAJfSwNCiAJLmNhcHR1cmUgPSB7DQogCQkuc3RyZWFt
X25hbWUgPSAiQVNSQy1DYXB0dXJlIiwNCiAJCS5jaGFubmVsc19taW4gPSAxLA0KIAkJLmNoYW5u
ZWxzX21heCA9IDEwLA0KLQkJLnJhdGVzID0gRlNMX0FTUkNfUkFURVMsDQorCQkucmF0ZV9taW4g
PSA1NTEyLA0KKwkJLnJhdGVfbWF4ID0gMTkyMDAwLA0KKwkJLnJhdGVzID0gU05EUlZfUENNX1JB
VEVfS05PVCwNCiAJCS5mb3JtYXRzID0gRlNMX0FTUkNfRk9STUFUUywNCiAJfSwNCiAJLm9wcyA9
ICZmc2xfYXNyY19kYWlfb3BzLA0KLS0gDQoxLjkuMQ0KDQo=

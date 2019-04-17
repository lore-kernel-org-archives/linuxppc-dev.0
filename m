Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CD6C10F12
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 09:11:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 530D2206B6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 09:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Sd9J+Pb6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530D2206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kc123d8XzDqMq
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 19:11:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe09::62f;
 helo=eur03-ve1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="Sd9J+Pb6"; 
 dkim-atps=neutral
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03on062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe09::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kbvN2FkvzDqK9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 19:06:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejwozXe/qSLAFdUNNbkxWJLvWSxrTW3V3L3rr8d66Hw=;
 b=Sd9J+Pb6IfpV2sPmIJPqH5042KXcsq7+0xZXoT6y9li2m1mb60pGNFMEdfEnFSpRzpH1uTBivYs2nBSWk+cU8mdp26DKaA4YxlheUaQAlvYYW0gNMNeX81OpGdI/4Z14+czw+ClBN5WC6o2SLtDRQULKr3275gLFB8k/qKcE+98=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6640.eurprd04.prod.outlook.com (20.179.235.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Wed, 17 Apr 2019 09:06:21 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1792.018; Wed, 17 Apr 2019
 09:06:21 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH V3 2/2] ASoC: fsl_asrc: Unify the supported input and output
 rate
Thread-Topic: [PATCH V3 2/2] ASoC: fsl_asrc: Unify the supported input and
 output rate
Thread-Index: AQHU9PzTf5/RjOTGYEC7R83AVx/JJw==
Date: Wed, 17 Apr 2019 09:06:21 +0000
Message-ID: <494cdc7019d8e8d98c0e5837fc5f28624213288b.1555491598.git.shengjiu.wang@nxp.com>
References: <cover.1555491598.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1555491598.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::27) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2beb889-5285-4f22-4495-08d6c313f5bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6640; 
x-ms-traffictypediagnostic: VE1PR04MB6640:
x-microsoft-antispam-prvs: <VE1PR04MB664011A1B53577EE21EAD464E3250@VE1PR04MB6640.eurprd04.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(39860400002)(366004)(376002)(396003)(136003)(199004)(189003)(54906003)(53936002)(99286004)(118296001)(110136005)(186003)(102836004)(26005)(6506007)(386003)(8676002)(68736007)(478600001)(81166006)(81156014)(2201001)(50226002)(86362001)(6436002)(8936002)(305945005)(2501003)(6486002)(36756003)(7736002)(14454004)(71190400001)(256004)(105586002)(6116002)(19627235002)(25786009)(71200400001)(6512007)(97736004)(106356001)(5660300002)(14444005)(11346002)(76176011)(2616005)(446003)(476003)(486006)(316002)(2906002)(3846002)(4326008)(52116002)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6640;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ufSDeDyCxdMi4y5C8PCf+Z6ADz8r/U8xyyBe+NcBnlXmIbvJYMHv6uc4RyE7w9CA9BOsjVEH6yq+lsJiV5zLVU11FBGILQirps6fm8gZyqIaYH531H4kNN6qckRC4YvUiOlE5jdbNoVqyAcXvhSnYxZlqvhGpD7Zx0a1s4GuwVlL+qMzgckELtaUG06XkXzqFTC3Ed2/D6ujc2SJ0SWR4C9U20tIQpC2awyEFqrzFCRUEwzOmBMzs69oLSAXAiqABWMEDPUp0pCwiOmFVonsQ0JCSY9DI1D3IW2vdRwwHT5OF4zdgQOroTiJXAIAo0iDHthE9DMxwqj8UnrtuLEPvX9FKg5GVlkQAyLM6tbKC1RPAH3SiFaFmJelJhToLFFUaE0GG9aBbV+6iolrr4Y7mkkieFg0a7xtHtdCNVZubPM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2beb889-5285-4f22-4495-08d6c313f5bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 09:06:21.8993 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6640
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
X2FzcmMuYyB8IDMwICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFu
Z2VkLCAxOCBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL3Nv
dW5kL3NvYy9mc2wvZnNsX2FzcmMuYyBiL3NvdW5kL3NvYy9mc2wvZnNsX2FzcmMuYw0KaW5kZXgg
ZDM0ZDUzOWQwMWYyLi5iMGQxOWI3ODdiYjggMTAwNjQ0DQotLS0gYS9zb3VuZC9zb2MvZnNsL2Zz
bF9hc3JjLmMNCisrKyBiL3NvdW5kL3NvYy9mc2wvZnNsX2FzcmMuYw0KQEAgLTI3LDEzICsyNywx
NCBAQA0KIAlkZXZfZGJnKCZhc3JjX3ByaXYtPnBkZXYtPmRldiwgIlBhaXIgJWM6ICIgZm10LCAn
QScgKyBpbmRleCwgIyNfX1ZBX0FSR1NfXykNCiANCiAvKiBDb3JyZXNwb25kaW5nIHRvIHByb2Nl
c3Nfb3B0aW9uICovDQotc3RhdGljIGludCBzdXBwb3J0ZWRfaW5wdXRfcmF0ZVtdID0gew0KLQk1
NTEyLCA4MDAwLCAxMTAyNSwgMTYwMDAsIDIyMDUwLCAzMjAwMCwgNDQxMDAsIDQ4MDAwLCA2NDAw
MCwgODgyMDAsDQotCTk2MDAwLCAxNzY0MDAsIDE5MjAwMCwNCitzdGF0aWMgdW5zaWduZWQgaW50
IHN1cHBvcnRlZF9hc3JjX3JhdGVbXSA9IHsNCisJNTUxMiwgODAwMCwgMTEwMjUsIDEyMDAwLCAx
NjAwMCwgMjIwNTAsIDI0MDAwLCAzMjAwMCwgNDQxMDAsIDQ4MDAwLA0KKwk2NDAwMCwgODgyMDAs
IDk2MDAwLCAxMjgwMDAsIDE3NjQwMCwgMTkyMDAwLA0KIH07DQogDQotc3RhdGljIGludCBzdXBw
b3J0ZWRfYXNyY19yYXRlW10gPSB7DQotCTgwMDAsIDExMDI1LCAxNjAwMCwgMjIwNTAsIDMyMDAw
LCA0NDEwMCwgNDgwMDAsIDY0MDAwLCA4ODIwMCwgOTYwMDAsIDE3NjQwMCwgMTkyMDAwLA0KK3N0
YXRpYyBzdHJ1Y3Qgc25kX3BjbV9od19jb25zdHJhaW50X2xpc3QgZnNsX2FzcmNfcmF0ZV9jb25z
dHJhaW50cyA9IHsNCisJLmNvdW50ID0gQVJSQVlfU0laRShzdXBwb3J0ZWRfYXNyY19yYXRlKSwN
CisJLmxpc3QgPSBzdXBwb3J0ZWRfYXNyY19yYXRlLA0KIH07DQogDQogLyoqDQpAQCAtMjk2LDEx
ICsyOTcsMTEgQEAgc3RhdGljIGludCBmc2xfYXNyY19jb25maWdfcGFpcihzdHJ1Y3QgZnNsX2Fz
cmNfcGFpciAqcGFpcikNCiAJaWRlYWwgPSBjb25maWctPmluY2xrID09IElOQ0xLX05PTkU7DQog
DQogCS8qIFZhbGlkYXRlIGlucHV0IGFuZCBvdXRwdXQgc2FtcGxlIHJhdGVzICovDQotCWZvciAo
aW4gPSAwOyBpbiA8IEFSUkFZX1NJWkUoc3VwcG9ydGVkX2lucHV0X3JhdGUpOyBpbisrKQ0KLQkJ
aWYgKGlucmF0ZSA9PSBzdXBwb3J0ZWRfaW5wdXRfcmF0ZVtpbl0pDQorCWZvciAoaW4gPSAwOyBp
biA8IEFSUkFZX1NJWkUoc3VwcG9ydGVkX2FzcmNfcmF0ZSk7IGluKyspDQorCQlpZiAoaW5yYXRl
ID09IHN1cHBvcnRlZF9hc3JjX3JhdGVbaW5dKQ0KIAkJCWJyZWFrOw0KIA0KLQlpZiAoaW4gPT0g
QVJSQVlfU0laRShzdXBwb3J0ZWRfaW5wdXRfcmF0ZSkpIHsNCisJaWYgKGluID09IEFSUkFZX1NJ
WkUoc3VwcG9ydGVkX2FzcmNfcmF0ZSkpIHsNCiAJCXBhaXJfZXJyKCJ1bnN1cHBvcnRlZCBpbnB1
dCBzYW1wbGUgcmF0ZTogJWRIelxuIiwgaW5yYXRlKTsNCiAJCXJldHVybiAtRUlOVkFMOw0KIAl9
DQpAQCAtNDkzLDcgKzQ5NCw5IEBAIHN0YXRpYyBpbnQgZnNsX2FzcmNfZGFpX3N0YXJ0dXAoc3Ry
dWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0sDQogCQlzbmRfcGNtX2h3X2NvbnN0cmFp
bnRfc3RlcChzdWJzdHJlYW0tPnJ1bnRpbWUsIDAsDQogCQkJCQkgICBTTkRSVl9QQ01fSFdfUEFS
QU1fQ0hBTk5FTFMsIDIpOw0KIA0KLQlyZXR1cm4gMDsNCisNCisJcmV0dXJuIHNuZF9wY21faHdf
Y29uc3RyYWludF9saXN0KHN1YnN0cmVhbS0+cnVudGltZSwgMCwNCisJCQlTTkRSVl9QQ01fSFdf
UEFSQU1fUkFURSwgJmZzbF9hc3JjX3JhdGVfY29uc3RyYWludHMpOw0KIH0NCiANCiBzdGF0aWMg
aW50IGZzbF9hc3JjX2RhaV9od19wYXJhbXMoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJz
dHJlYW0sDQpAQCAtNjA2LDcgKzYwOSw2IEBAIHN0YXRpYyBpbnQgZnNsX2FzcmNfZGFpX3Byb2Jl
KHN0cnVjdCBzbmRfc29jX2RhaSAqZGFpKQ0KIAlyZXR1cm4gMDsNCiB9DQogDQotI2RlZmluZSBG
U0xfQVNSQ19SQVRFUwkJIFNORFJWX1BDTV9SQVRFXzgwMDBfMTkyMDAwDQogI2RlZmluZSBGU0xf
QVNSQ19GT1JNQVRTCShTTkRSVl9QQ01fRk1UQklUX1MyNF9MRSB8IFwNCiAJCQkJIFNORFJWX1BD
TV9GTVRCSVRfUzE2X0xFIHwgXA0KIAkJCQkgU05EUlZfUENNX0ZNVEJJVF9TMjBfM0xFKQ0KQEAg
LTYxNywxNCArNjE5LDE4IEBAIHN0YXRpYyBpbnQgZnNsX2FzcmNfZGFpX3Byb2JlKHN0cnVjdCBz
bmRfc29jX2RhaSAqZGFpKQ0KIAkJLnN0cmVhbV9uYW1lID0gIkFTUkMtUGxheWJhY2siLA0KIAkJ
LmNoYW5uZWxzX21pbiA9IDEsDQogCQkuY2hhbm5lbHNfbWF4ID0gMTAsDQotCQkucmF0ZXMgPSBG
U0xfQVNSQ19SQVRFUywNCisJCS5yYXRlX21pbiA9IDU1MTIsDQorCQkucmF0ZV9tYXggPSAxOTIw
MDAsDQorCQkucmF0ZXMgPSBTTkRSVl9QQ01fUkFURV9LTk9ULA0KIAkJLmZvcm1hdHMgPSBGU0xf
QVNSQ19GT1JNQVRTLA0KIAl9LA0KIAkuY2FwdHVyZSA9IHsNCiAJCS5zdHJlYW1fbmFtZSA9ICJB
U1JDLUNhcHR1cmUiLA0KIAkJLmNoYW5uZWxzX21pbiA9IDEsDQogCQkuY2hhbm5lbHNfbWF4ID0g
MTAsDQotCQkucmF0ZXMgPSBGU0xfQVNSQ19SQVRFUywNCisJCS5yYXRlX21pbiA9IDU1MTIsDQor
CQkucmF0ZV9tYXggPSAxOTIwMDAsDQorCQkucmF0ZXMgPSBTTkRSVl9QQ01fUkFURV9LTk9ULA0K
IAkJLmZvcm1hdHMgPSBGU0xfQVNSQ19GT1JNQVRTLA0KIAl9LA0KIAkub3BzID0gJmZzbF9hc3Jj
X2RhaV9vcHMsDQotLSANCjEuOS4xDQoNCg==

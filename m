Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C054CC282E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 04:58:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3212F2077C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 04:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DO5trgJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3212F2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nZ8b2pVRzDqMm
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 14:58:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.1.44; helo=eur02-he1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="DO5trgJK"; 
 dkim-atps=neutral
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10044.outbound.protection.outlook.com [40.107.1.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nZ1p3SxSzDqLL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 14:52:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/uEB3mv42VDHqr9ulG+MScO/mamsWOvVODjLbWuQDM=;
 b=DO5trgJK4JWaLPQ450VumE+tKFBP/uTsFutMWY0FiKYz+eOXzH3KQv9HkWCF8Uj+ZaY6Wq4dpBfLfsClDpHWfw+yripgUubk1ulkp5I7i3hxYkyWB4CMZldvtdD9ySFBPvJaXLHK2zdTNJrXEEd/2HXEAjcMgT8vkYBkXqdoH1I=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Mon, 22 Apr 2019 04:52:08 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 04:52:08 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH V6 3/3] ASoC: fsl_asrc: Unify the supported input and output
 rate
Thread-Topic: [PATCH V6 3/3] ASoC: fsl_asrc: Unify the supported input and
 output rate
Thread-Index: AQHU+Mcj6uPED7OwA0uPcTLFz9zP1A==
Date: Mon, 22 Apr 2019 04:52:08 +0000
Message-ID: <aa3757e2fb4ec4e1cf2b1fe3de651257a2a89350.1555908545.git.shengjiu.wang@nxp.com>
References: <cover.1555908545.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1555908545.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::15) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31b6162c-74e2-4e92-bdc2-08d6c6de4621
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6479; 
x-ms-traffictypediagnostic: VE1PR04MB6479:
x-microsoft-antispam-prvs: <VE1PR04MB6479C71404FDCBC759632F90E3220@VE1PR04MB6479.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(396003)(39860400002)(136003)(376002)(199004)(189003)(2201001)(486006)(26005)(99286004)(6436002)(5660300002)(186003)(316002)(66066001)(6486002)(86362001)(81156014)(81166006)(8676002)(118296001)(476003)(2616005)(11346002)(446003)(305945005)(7736002)(8936002)(50226002)(2501003)(97736004)(54906003)(3846002)(14454004)(76176011)(110136005)(19627235002)(4326008)(6512007)(2906002)(68736007)(478600001)(71200400001)(71190400001)(386003)(6506007)(53936002)(66556008)(52116002)(66476007)(256004)(36756003)(64756008)(73956011)(66446008)(66946007)(6116002)(102836004)(14444005)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6479;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ysafc4ldjYCsuRixJ1HZBLvp1qiNHLksdCXEggd5RnNNA8n6hlpWpMbhE3+BGhWQv437MZrsdidVH4V1cxOjM/Z3pSxOAROqMcTjWLI2fcYa2+eKRu48XPnsmfyTshtikw9a874WGalaDyXrvIdU+1Mqbq1THRklxZcls0OwSc4lA2O7U6uGuHniWigMIYmkoTAO1dt/OWPkiNY/v+M/tBeggg0YYRQkJxlu/NKnk2572qq2afJfn/e+cA/0d3wLDKws2O0HSNAx+xg788N+lHLZUM7PHg1vqcHFOlOouEx2UI9bdB0DS7zG5xqrkiQv1xWGLUzec/buIIpK6Rc3nulwUHA0Z6+8snD3o/O4GuH1FXqpoJEecYEVjL3PWyssf/wkVm8u7e89FHRpW57xWbt0mM1/RhaUlKBSQQWmE94=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b6162c-74e2-4e92-bdc2-08d6c6de4621
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 04:52:08.5412 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6479
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
aml1IFdhbmcgPHNoZW5naml1LndhbmdAbnhwLmNvbT4NCkFja2VkLWJ5OiBOaWNvbGluIENoZW4g
PG5pY29sZW90c3VrYUBnbWFpbC5jb20+DQotLS0NCiBzb3VuZC9zb2MvZnNsL2ZzbF9hc3JjLmMg
fCAzMiArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAx
OSBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL3NvdW5kL3Nv
Yy9mc2wvZnNsX2FzcmMuYyBiL3NvdW5kL3NvYy9mc2wvZnNsX2FzcmMuYw0KaW5kZXggYThkNjcx
MGYyNTQxLi5jYmJmNjI1N2YwOGEgMTAwNjQ0DQotLS0gYS9zb3VuZC9zb2MvZnNsL2ZzbF9hc3Jj
LmMNCisrKyBiL3NvdW5kL3NvYy9mc2wvZnNsX2FzcmMuYw0KQEAgLTI3LDEzICsyNywxNCBAQA0K
IAlkZXZfZGJnKCZhc3JjX3ByaXYtPnBkZXYtPmRldiwgIlBhaXIgJWM6ICIgZm10LCAnQScgKyBp
bmRleCwgIyNfX1ZBX0FSR1NfXykNCiANCiAvKiBDb3JyZXNwb25kaW5nIHRvIHByb2Nlc3Nfb3B0
aW9uICovDQotc3RhdGljIGludCBzdXBwb3J0ZWRfaW5wdXRfcmF0ZVtdID0gew0KLQk1NTEyLCA4
MDAwLCAxMTAyNSwgMTYwMDAsIDIyMDUwLCAzMjAwMCwgNDQxMDAsIDQ4MDAwLCA2NDAwMCwgODgy
MDAsDQotCTk2MDAwLCAxNzY0MDAsIDE5MjAwMCwNCitzdGF0aWMgdW5zaWduZWQgaW50IHN1cHBv
cnRlZF9hc3JjX3JhdGVbXSA9IHsNCisJNTUxMiwgODAwMCwgMTEwMjUsIDEyMDAwLCAxNjAwMCwg
MjIwNTAsIDI0MDAwLCAzMjAwMCwgNDQxMDAsIDQ4MDAwLA0KKwk2NDAwMCwgODgyMDAsIDk2MDAw
LCAxMjgwMDAsIDE3NjQwMCwgMTkyMDAwLA0KIH07DQogDQotc3RhdGljIGludCBzdXBwb3J0ZWRf
YXNyY19yYXRlW10gPSB7DQotCTgwMDAsIDExMDI1LCAxNjAwMCwgMjIwNTAsIDMyMDAwLCA0NDEw
MCwgNDgwMDAsIDY0MDAwLCA4ODIwMCwgOTYwMDAsIDE3NjQwMCwgMTkyMDAwLA0KK3N0YXRpYyBz
dHJ1Y3Qgc25kX3BjbV9od19jb25zdHJhaW50X2xpc3QgZnNsX2FzcmNfcmF0ZV9jb25zdHJhaW50
cyA9IHsNCisJLmNvdW50ID0gQVJSQVlfU0laRShzdXBwb3J0ZWRfYXNyY19yYXRlKSwNCisJLmxp
c3QgPSBzdXBwb3J0ZWRfYXNyY19yYXRlLA0KIH07DQogDQogLyoqDQpAQCAtMjkzLDExICsyOTQs
MTEgQEAgc3RhdGljIGludCBmc2xfYXNyY19jb25maWdfcGFpcihzdHJ1Y3QgZnNsX2FzcmNfcGFp
ciAqcGFpcikNCiAJaWRlYWwgPSBjb25maWctPmluY2xrID09IElOQ0xLX05PTkU7DQogDQogCS8q
IFZhbGlkYXRlIGlucHV0IGFuZCBvdXRwdXQgc2FtcGxlIHJhdGVzICovDQotCWZvciAoaW4gPSAw
OyBpbiA8IEFSUkFZX1NJWkUoc3VwcG9ydGVkX2lucHV0X3JhdGUpOyBpbisrKQ0KLQkJaWYgKGlu
cmF0ZSA9PSBzdXBwb3J0ZWRfaW5wdXRfcmF0ZVtpbl0pDQorCWZvciAoaW4gPSAwOyBpbiA8IEFS
UkFZX1NJWkUoc3VwcG9ydGVkX2FzcmNfcmF0ZSk7IGluKyspDQorCQlpZiAoaW5yYXRlID09IHN1
cHBvcnRlZF9hc3JjX3JhdGVbaW5dKQ0KIAkJCWJyZWFrOw0KIA0KLQlpZiAoaW4gPT0gQVJSQVlf
U0laRShzdXBwb3J0ZWRfaW5wdXRfcmF0ZSkpIHsNCisJaWYgKGluID09IEFSUkFZX1NJWkUoc3Vw
cG9ydGVkX2FzcmNfcmF0ZSkpIHsNCiAJCXBhaXJfZXJyKCJ1bnN1cHBvcnRlZCBpbnB1dCBzYW1w
bGUgcmF0ZTogJWRIelxuIiwgaW5yYXRlKTsNCiAJCXJldHVybiAtRUlOVkFMOw0KIAl9DQpAQCAt
MzExLDcgKzMxMiw3IEBAIHN0YXRpYyBpbnQgZnNsX2FzcmNfY29uZmlnX3BhaXIoc3RydWN0IGZz
bF9hc3JjX3BhaXIgKnBhaXIpDQogCQlyZXR1cm4gLUVJTlZBTDsNCiAJfQ0KIA0KLQlpZiAoKG91
dHJhdGUgPj0gODAwMCAmJiBvdXRyYXRlIDw9IDMwMDAwKSAmJg0KKwlpZiAoKG91dHJhdGUgPj0g
NTUxMiAmJiBvdXRyYXRlIDw9IDMwMDAwKSAmJg0KIAkgICAgKG91dHJhdGUgPiAyNCAqIGlucmF0
ZSB8fCBpbnJhdGUgPiA4ICogb3V0cmF0ZSkpIHsNCiAJCXBhaXJfZXJyKCJleGNlZWQgc3VwcG9y
dGVkIHJhdGlvIHJhbmdlIFsxLzI0LCA4XSBmb3IgXA0KIAkJCQlpbnJhdGUvb3V0cmF0ZTogJWQv
JWRcbiIsIGlucmF0ZSwgb3V0cmF0ZSk7DQpAQCAtNDg2LDcgKzQ4Nyw5IEBAIHN0YXRpYyBpbnQg
ZnNsX2FzcmNfZGFpX3N0YXJ0dXAoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0s
DQogCQlzbmRfcGNtX2h3X2NvbnN0cmFpbnRfc3RlcChzdWJzdHJlYW0tPnJ1bnRpbWUsIDAsDQog
CQkJCQkgICBTTkRSVl9QQ01fSFdfUEFSQU1fQ0hBTk5FTFMsIDIpOw0KIA0KLQlyZXR1cm4gMDsN
CisNCisJcmV0dXJuIHNuZF9wY21faHdfY29uc3RyYWludF9saXN0KHN1YnN0cmVhbS0+cnVudGlt
ZSwgMCwNCisJCQlTTkRSVl9QQ01fSFdfUEFSQU1fUkFURSwgJmZzbF9hc3JjX3JhdGVfY29uc3Ry
YWludHMpOw0KIH0NCiANCiBzdGF0aWMgaW50IGZzbF9hc3JjX2RhaV9od19wYXJhbXMoc3RydWN0
IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0sDQpAQCAtNTk5LDcgKzYwMiw2IEBAIHN0YXRp
YyBpbnQgZnNsX2FzcmNfZGFpX3Byb2JlKHN0cnVjdCBzbmRfc29jX2RhaSAqZGFpKQ0KIAlyZXR1
cm4gMDsNCiB9DQogDQotI2RlZmluZSBGU0xfQVNSQ19SQVRFUwkJIFNORFJWX1BDTV9SQVRFXzgw
MDBfMTkyMDAwDQogI2RlZmluZSBGU0xfQVNSQ19GT1JNQVRTCShTTkRSVl9QQ01fRk1UQklUX1My
NF9MRSB8IFwNCiAJCQkJIFNORFJWX1BDTV9GTVRCSVRfUzE2X0xFIHwgXA0KIAkJCQkgU05EUlZf
UENNX0ZNVEJJVF9TMjBfM0xFKQ0KQEAgLTYxMCwxNCArNjEyLDE4IEBAIHN0YXRpYyBpbnQgZnNs
X2FzcmNfZGFpX3Byb2JlKHN0cnVjdCBzbmRfc29jX2RhaSAqZGFpKQ0KIAkJLnN0cmVhbV9uYW1l
ID0gIkFTUkMtUGxheWJhY2siLA0KIAkJLmNoYW5uZWxzX21pbiA9IDEsDQogCQkuY2hhbm5lbHNf
bWF4ID0gMTAsDQotCQkucmF0ZXMgPSBGU0xfQVNSQ19SQVRFUywNCisJCS5yYXRlX21pbiA9IDU1
MTIsDQorCQkucmF0ZV9tYXggPSAxOTIwMDAsDQorCQkucmF0ZXMgPSBTTkRSVl9QQ01fUkFURV9L
Tk9ULA0KIAkJLmZvcm1hdHMgPSBGU0xfQVNSQ19GT1JNQVRTLA0KIAl9LA0KIAkuY2FwdHVyZSA9
IHsNCiAJCS5zdHJlYW1fbmFtZSA9ICJBU1JDLUNhcHR1cmUiLA0KIAkJLmNoYW5uZWxzX21pbiA9
IDEsDQogCQkuY2hhbm5lbHNfbWF4ID0gMTAsDQotCQkucmF0ZXMgPSBGU0xfQVNSQ19SQVRFUywN
CisJCS5yYXRlX21pbiA9IDU1MTIsDQorCQkucmF0ZV9tYXggPSAxOTIwMDAsDQorCQkucmF0ZXMg
PSBTTkRSVl9QQ01fUkFURV9LTk9ULA0KIAkJLmZvcm1hdHMgPSBGU0xfQVNSQ19GT1JNQVRTLA0K
IAl9LA0KIAkub3BzID0gJmZzbF9hc3JjX2RhaV9vcHMsDQotLSANCjEuOS4xDQoNCg==

Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750C8C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 08:37:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7DB20833
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 08:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s6Zl0Dk4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7DB20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dgf631PmzDqJg
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 18:37:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.7.79; helo=eur04-he1-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="s6Zl0Dk4"; 
 dkim-atps=neutral
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70079.outbound.protection.outlook.com [40.107.7.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dgbh5JjxzDqH2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 18:35:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkFS7fOKXY4eaBsvRVjQ21ozJNA3OcWuRPR29jAgAek=;
 b=s6Zl0Dk4SVWxtKS8ffhG9CEATj0dMzwXIWJoV1mKkEZo640uyei2Of0eHaioZoKMUA56ENBA4CKyG6hXeMVVHtL/KPdZ+uxOBLQLRnTp63wyPdAEZJr8p2a4y0z35UIV/SJJQZHYhmT3Yr0dlRNM+omRsJC/qflgxdim2y9KmPg=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB3983.eurprd04.prod.outlook.com (10.171.182.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Tue, 9 Apr 2019 08:35:35 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888%3]) with mapi id 15.20.1792.009; Tue, 9 Apr 2019
 08:35:35 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Julia Lawall
 <Julia.Lawall@lip6.fr>
Subject: [PATCH 2/2] ASoC: imx-audmix: fix object reference leaks in probe
Thread-Topic: [PATCH 2/2] ASoC: imx-audmix: fix object reference leaks in probe
Thread-Index: AQHU7q8zoMDMeUy2P0Ct5Mpi9gwjqg==
Date: Tue, 9 Apr 2019 08:35:35 +0000
Message-ID: <1554798876-20653-3-git-send-email-viorel.suman@nxp.com>
References: <1554798876-20653-1-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1554798876-20653-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VE1PR03CA0004.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::16) To VI1PR04MB4704.eurprd04.prod.outlook.com
 (2603:10a6:803:52::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cf04229-6667-4b5f-24d4-08d6bcc655fa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR04MB3983; 
x-ms-traffictypediagnostic: VI1PR04MB3983:
x-microsoft-antispam-prvs: <VI1PR04MB3983F3E1B277696FAB158210922D0@VI1PR04MB3983.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(366004)(39860400002)(396003)(136003)(189003)(199004)(305945005)(5660300002)(106356001)(4326008)(68736007)(105586002)(52116002)(14454004)(97736004)(186003)(36756003)(110136005)(54906003)(53936002)(81156014)(7736002)(8676002)(81166006)(25786009)(6486002)(50226002)(6512007)(7416002)(6436002)(8936002)(99286004)(2616005)(66066001)(11346002)(3846002)(6116002)(256004)(446003)(316002)(476003)(86362001)(2906002)(71190400001)(71200400001)(386003)(6506007)(486006)(478600001)(102836004)(76176011)(26005)(44832011)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB3983;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qits80QiWfjSpVuTC3sU4QBS6qrmvpG0fLKd4Hig4iMmY7NO0/0jbYdA7iWHtp2nJXbGYozP+UJWcafdx+KpdLnt0+pFB0a0NEGPhavWzINaUZmNdFO7RLOOy4pbXX6h3ssaECJVfNuX8Rr++RX6GEdnZQTWwqueyb52J92Prz+OZrUeuG6Lpq2xDpA3UMaaBCvMEmxADitfF4EGaa/VjBKBlXI2fDOXx6ELglBjx7443mwjIUBbG1ql30BfF/qJREtax85PXeDh7BuXuycUUnRhlz4pPP5gdUpoiV85Pj5sRtdN1JfNtK41Ofe1NOyV1TVyuLms9U/5Cnf24NHs18+1+9xZGJjDqYh8mdJCuuX7JLp+r1gnQ2IZ89e6kwhftuxiTcAwGzQBkG32J+i5n//UwcwXottYnZMGn3AyAlQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf04229-6667-4b5f-24d4-08d6bcc655fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 08:35:35.4839 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3983
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Viorel Suman <viorel.suman@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Viorel Suman <viorel.suman@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

UmVsZWFzZSB0aGUgcmVmZXJlbmNlIHRvIHRoZSB1bmRlcmx5aW5nIGRldmljZSB0YWtlbg0KYnkg
b2ZfZmluZF9kZXZpY2VfYnlfbm9kZSgpIGNhbGwuDQoNClNpZ25lZC1vZmYtYnk6IFZpb3JlbCBT
dW1hbiA8dmlvcmVsLnN1bWFuQG54cC5jb20+DQotLS0NCiBzb3VuZC9zb2MvZnNsL2lteC1hdWRt
aXguYyB8IDMxICsrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdl
ZCwgMTEgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9zb3Vu
ZC9zb2MvZnNsL2lteC1hdWRtaXguYyBiL3NvdW5kL3NvYy9mc2wvaW14LWF1ZG1peC5jDQppbmRl
eCA3OTgzYmQzLi43YzI0MDk1IDEwMDY0NA0KLS0tIGEvc291bmQvc29jL2ZzbC9pbXgtYXVkbWl4
LmMNCisrKyBiL3NvdW5kL3NvYy9mc2wvaW14LWF1ZG1peC5jDQpAQCAtMjAsMTAgKzIwLDcgQEAN
CiAjaW5jbHVkZSAiZnNsX2F1ZG1peC5oIg0KIA0KIHN0cnVjdCBpbXhfYXVkbWl4IHsNCi0Jc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldjsNCiAJc3RydWN0IHNuZF9zb2NfY2FyZCBjYXJkOw0K
LQlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICphdWRtaXhfcGRldjsNCi0Jc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqb3V0X3BkZXY7DQogCXN0cnVjdCBjbGsgKmNwdV9tY2xrOw0KIAlpbnQgbnVtX2Rh
aTsNCiAJc3RydWN0IHNuZF9zb2NfZGFpX2xpbmsgKmRhaTsNCkBAIC0xNDQsNyArMTQxLDcgQEAg
c3RhdGljIHN0cnVjdCBzbmRfc29jX29wcyBpbXhfYXVkbWl4X2JlX29wcyA9IHsNCiBzdGF0aWMg
aW50IGlteF9hdWRtaXhfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiB7DQog
CXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBwZGV2LT5kZXYub2Zfbm9kZTsNCi0Jc3RydWN0IGRl
dmljZV9ub2RlICphdWRtaXhfbnAgPSBOVUxMLCAqb3V0X2NwdV9ucCA9IE5VTEw7DQorCXN0cnVj
dCBkZXZpY2Vfbm9kZSAqYXVkbWl4X25wID0gTlVMTDsNCiAJc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqYXVkbWl4X3BkZXYgPSBOVUxMOw0KIAlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpjcHVfcGRl
djsNCiAJc3RydWN0IG9mX3BoYW5kbGVfYXJncyBhcmdzOw0KQEAgLTE3MSw2ICsxNjgsNyBAQCBz
dGF0aWMgaW50IGlteF9hdWRtaXhfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
CiAJCQlucC0+ZnVsbF9uYW1lKTsNCiAJCXJldHVybiAtRUlOVkFMOw0KIAl9DQorCXB1dF9kZXZp
Y2UoJmF1ZG1peF9wZGV2LT5kZXYpOw0KIA0KIAludW1fZGFpID0gb2ZfY291bnRfcGhhbmRsZV93
aXRoX2FyZ3MoYXVkbWl4X25wLCAiZGFpcyIsIE5VTEwpOw0KIAlpZiAobnVtX2RhaSAhPSBGU0xf
QVVETUlYX01BWF9EQUlTKSB7DQpAQCAtMjE2LDYgKzIxNCw3IEBAIHN0YXRpYyBpbnQgaW14X2F1
ZG1peF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJCWRldl9lcnIoJnBk
ZXYtPmRldiwgImZhaWxlZCB0byBmaW5kIFNBSSBwbGF0Zm9ybSBkZXZpY2VcbiIpOw0KIAkJCXJl
dHVybiAtRUlOVkFMOw0KIAkJfQ0KKwkJcHV0X2RldmljZSgmY3B1X3BkZXYtPmRldik7DQogDQog
CQlkYWlfbmFtZSA9IGRldm1fa2FzcHJpbnRmKCZwZGV2LT5kZXYsIEdGUF9LRVJORUwsICIlcyVz
IiwNCiAJCQkJCSAgZmVfbmFtZV9wcmVmLCBhcmdzLm5wLT5mdWxsX25hbWUgKyAxKTsNCkBAIC0y
MjMsNyArMjIyLDE0IEBAIHN0YXRpYyBpbnQgaW14X2F1ZG1peF9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KIAkJZGV2X2luZm8ocGRldi0+ZGV2LnBhcmVudCwgIkRBSSBGRSBu
YW1lOiVzXG4iLCBkYWlfbmFtZSk7DQogDQogCQlpZiAoaSA9PSAwKSB7DQotCQkJb3V0X2NwdV9u
cCA9IGFyZ3MubnA7DQorCQkJcHJpdi0+Y3B1X21jbGsgPSBkZXZtX2Nsa19nZXQoJmNwdV9wZGV2
LT5kZXYsICJtY2xrMSIpOw0KKwkJCWlmIChJU19FUlIocHJpdi0+Y3B1X21jbGspKSB7DQorCQkJ
CXJldCA9IFBUUl9FUlIocHJpdi0+Y3B1X21jbGspOw0KKwkJCQlkZXZfZXJyKCZjcHVfcGRldi0+
ZGV2LA0KKwkJCQkJImZhaWxlZCB0byBnZXQgREFJIG1jbGsxOiAlZFxuIiwgcmV0KTsNCisJCQkJ
cmV0dXJuIC1FSU5WQUw7DQorCQkJfQ0KKw0KIAkJCWNhcHR1cmVfZGFpX25hbWUgPQ0KIAkJCQlk
ZXZtX2thc3ByaW50ZigmcGRldi0+ZGV2LCBHRlBfS0VSTkVMLCAiJXMgJXMiLA0KIAkJCQkJICAg
ICAgIGRhaV9uYW1lLCAiQ1BVLUNhcHR1cmUiKTsNCkBAIC0yNzUsMjEgKzI4MSw2IEBAIHN0YXRp
YyBpbnQgaW14X2F1ZG1peF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJ
cHJpdi0+ZGFwbV9yb3V0ZXNbMiAqIG51bV9kYWkgKyBpXS5zaW5rICAgPSBjYXB0dXJlX2RhaV9u
YW1lOw0KIAl9DQogDQotCWNwdV9wZGV2ID0gb2ZfZmluZF9kZXZpY2VfYnlfbm9kZShvdXRfY3B1
X25wKTsNCi0JaWYgKCFjcHVfcGRldikgew0KLQkJZGV2X2VycigmcGRldi0+ZGV2LCAiZmFpbGVk
IHRvIGZpbmQgU0FJIHBsYXRmb3JtIGRldmljZVxuIik7DQotCQlyZXR1cm4gLUVJTlZBTDsNCi0J
fQ0KLQlwcml2LT5jcHVfbWNsayA9IGRldm1fY2xrX2dldCgmY3B1X3BkZXYtPmRldiwgIm1jbGsx
Iik7DQotCWlmIChJU19FUlIocHJpdi0+Y3B1X21jbGspKSB7DQotCQlyZXQgPSBQVFJfRVJSKHBy
aXYtPmNwdV9tY2xrKTsNCi0JCWRldl9lcnIoJmNwdV9wZGV2LT5kZXYsICJmYWlsZWQgdG8gZ2V0
IERBSSBtY2xrMTogJWRcbiIsIHJldCk7DQotCQlyZXR1cm4gLUVJTlZBTDsNCi0JfQ0KLQ0KLQlw
cml2LT5hdWRtaXhfcGRldiA9IGF1ZG1peF9wZGV2Ow0KLQlwcml2LT5vdXRfcGRldiAgPSBjcHVf
cGRldjsNCi0NCiAJcHJpdi0+Y2FyZC5kYWlfbGluayA9IHByaXYtPmRhaTsNCiAJcHJpdi0+Y2Fy
ZC5udW1fbGlua3MgPSBwcml2LT5udW1fZGFpOw0KIAlwcml2LT5jYXJkLmNvZGVjX2NvbmYgPSBw
cml2LT5kYWlfY29uZjsNCi0tIA0KMi43LjQNCg0K

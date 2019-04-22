Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABD7C10F11
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 19:07:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65017206A3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 19:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xZl6YJ2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65017206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nx0c2hzHzDq9p
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 05:07:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe1f::607;
 helo=eur01-ve1-obe.outbound.protection.outlook.com;
 envelope-from=daniel.baluta@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="xZl6YJ2k"; 
 dkim-atps=neutral
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nwv708CLzDqHK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 05:02:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQbr348hdlIG/WVBXd/HDcYL46Fa8R9qVum0dfFFreY=;
 b=xZl6YJ2kHkEq2MtqExQyEi0w3z/8iUpIrbEiSO/BhEjfYJjbb7X7djb0EsKQChnCNYndpxAUG6JTeQn2WwFYnNJSxRSej82WXz/GPFMY+45pqjoXPF0Z0noifhVXqmudAzAZBzzoD9SLRJ+96c4hQm89Ee63jt9SL/fAjNwsqf4=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2815.eurprd04.prod.outlook.com (10.172.255.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Mon, 22 Apr 2019 19:02:29 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6%6]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 19:02:29 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Subject: [PATCH v3 2/3] ASoC: fsl_sai: Add support for runtime pm
Thread-Topic: [PATCH v3 2/3] ASoC: fsl_sai: Add support for runtime pm
Thread-Index: AQHU+T3uWSULvj9plkCDwcPDgnoZEg==
Date: Mon, 22 Apr 2019 19:02:29 +0000
Message-ID: <20190422190213.30726-3-daniel.baluta@nxp.com>
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
x-ms-office365-filtering-correlation-id: 0187b151-05a0-4986-c90c-08d6c75510f5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR0402MB2815; 
x-ms-traffictypediagnostic: VI1PR0402MB2815:
x-microsoft-antispam-prvs: <VI1PR0402MB2815D2ED6B37D0C633ADC8B2F9220@VI1PR0402MB2815.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(376002)(366004)(396003)(346002)(39860400002)(199004)(189003)(23433003)(2906002)(6512007)(53936002)(7736002)(305945005)(316002)(386003)(6506007)(99286004)(102836004)(52116002)(186003)(76176011)(8936002)(54906003)(50226002)(26005)(25786009)(4326008)(66066001)(8676002)(36756003)(6116002)(3846002)(6916009)(2501003)(81166006)(1730700003)(81156014)(68736007)(2351001)(5640700003)(14454004)(478600001)(71190400001)(64756008)(6486002)(66446008)(5660300002)(66556008)(97736004)(2616005)(476003)(44832011)(446003)(256004)(11346002)(14444005)(86362001)(66476007)(73956011)(66946007)(6436002)(7416002)(486006)(1076003)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2815;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: c//cS5hQENOnB1zgnbTDManeGLR7tSIxJSNrx+tdYIH5v5J1fk4TwqaVeVw8a+hACrxN+h0UJPEkMsy75lxfbLp3YScUV/kRyRc5vy3xQCw4/RV5G8Ag94qL/iX45WxB29Cazrpsn0XxTcBMRRh8qmObVvCvAsnQxYYe4bbgudXnPmVZ43VqJzGY1sOY6xJkFXbHVN4loyG9rI5aYUSKr5HXTdj10N0zbi4Cg34wBgnL1FS4ejOFpzB3MFPigOo5edp42AHaTpvlKZLj+rKqQaD0Vet5hCFuIhpo0q6uNBtii71Edh0tR3m8R3l7LGJLCPu/x4gbSV1YNJbdlMy4TZdOtXsCgdz26eXYdQ/lAaV1j3gv7T/pOiroOs8Uu5irsRsvkSLVfkzNb01Ibi7egPE2w8T4VIEtRSS6MWQBQYs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0187b151-05a0-4986-c90c-08d6c75510f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 19:02:29.4467 (UTC)
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

QmFzaWNhbGx5IHRoZSBzYW1lIGFjdGlvbnMgYXMgZm9yIHN5c3RlbSBQTSwgc28gbWFrZSB1c2UN
Cm9mIHBtX3J1bnRpbWVfZm9yY2Vfc3VzcGVuZC9wbV9ydW50aW1lX2ZvcmNlX3Jlc3VtZS4NCg0K
U2lnbmVkLW9mZi1ieTogU2hlbmdqaXUgV2FuZyA8c2hlbmdqaXUud2FuZ0BueHAuY29tPg0KU2ln
bmVkLW9mZi1ieTogRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPg0KLS0tDQog
c291bmQvc29jL2ZzbC9mc2xfc2FpLmMgfCAyMiArKysrKysrKysrKysrKysrKy0tLS0tDQogMSBm
aWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1n
aXQgYS9zb3VuZC9zb2MvZnNsL2ZzbF9zYWkuYyBiL3NvdW5kL3NvYy9mc2wvZnNsX3NhaS5jDQpp
bmRleCBkOWRmOTg5NzVjZjguLjg2MjNiN2Y4ODJiOSAxMDA2NDQNCi0tLSBhL3NvdW5kL3NvYy9m
c2wvZnNsX3NhaS5jDQorKysgYi9zb3VuZC9zb2MvZnNsL2ZzbF9zYWkuYw0KQEAgLTksNiArOSw3
IEBADQogI2luY2x1ZGUgPGxpbnV4L2RtYWVuZ2luZS5oPg0KICNpbmNsdWRlIDxsaW51eC9tb2R1
bGUuaD4NCiAjaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVzcy5oPg0KKyNpbmNsdWRlIDxsaW51eC9w
bV9ydW50aW1lLmg+DQogI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5oPg0KICNpbmNsdWRlIDxsaW51
eC9zbGFiLmg+DQogI2luY2x1ZGUgPGxpbnV4L3RpbWUuaD4NCkBAIC05MDAsNiArOTAxLDggQEAg
c3RhdGljIGludCBmc2xfc2FpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQog
DQogCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIHNhaSk7DQogDQorCXBtX3J1bnRpbWVfZW5h
YmxlKCZwZGV2LT5kZXYpOw0KKw0KIAlyZXQgPSBkZXZtX3NuZF9zb2NfcmVnaXN0ZXJfY29tcG9u
ZW50KCZwZGV2LT5kZXYsICZmc2xfY29tcG9uZW50LA0KIAkJCSZmc2xfc2FpX2RhaSwgMSk7DQog
CWlmIChyZXQpDQpAQCAtOTExLDYgKzkxNCwxMSBAQCBzdGF0aWMgaW50IGZzbF9zYWlfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJCXJldHVybiBkZXZtX3NuZF9kbWFlbmdp
bmVfcGNtX3JlZ2lzdGVyKCZwZGV2LT5kZXYsIE5VTEwsIDApOw0KIH0NCiANCitzdGF0aWMgaW50
IGZzbF9zYWlfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQorew0KKwlwbV9y
dW50aW1lX2Rpc2FibGUoJnBkZXYtPmRldik7DQorfQ0KKw0KIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
b2ZfZGV2aWNlX2lkIGZzbF9zYWlfaWRzW10gPSB7DQogCXsgLmNvbXBhdGlibGUgPSAiZnNsLHZm
NjEwLXNhaSIsIH0sDQogCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDZzeC1zYWkiLCB9LA0KQEAg
LTkxOSw4ICs5MjcsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBmc2xfc2Fp
X2lkc1tdID0gew0KIH07DQogTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgZnNsX3NhaV9pZHMpOw0K
IA0KLSNpZmRlZiBDT05GSUdfUE1fU0xFRVANCi1zdGF0aWMgaW50IGZzbF9zYWlfc3VzcGVuZChz
dHJ1Y3QgZGV2aWNlICpkZXYpDQorI2lmZGVmIENPTkZJR19QTQ0KK3N0YXRpYyBpbnQgZnNsX3Nh
aV9ydW50aW1lX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KIHsNCiAJc3RydWN0IGZzbF9z
YWkgKnNhaSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KIA0KQEAgLTkzMCw3ICs5MzgsNyBAQCBz
dGF0aWMgaW50IGZzbF9zYWlfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQogCXJldHVybiAw
Ow0KIH0NCiANCi1zdGF0aWMgaW50IGZzbF9zYWlfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikN
CitzdGF0aWMgaW50IGZzbF9zYWlfcnVudGltZV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0K
IHsNCiAJc3RydWN0IGZzbF9zYWkgKnNhaSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KIA0KQEAg
LTk0MiwxNCArOTUwLDE4IEBAIHN0YXRpYyBpbnQgZnNsX3NhaV9yZXN1bWUoc3RydWN0IGRldmlj
ZSAqZGV2KQ0KIAlyZWdtYXBfd3JpdGUoc2FpLT5yZWdtYXAsIEZTTF9TQUlfUkNTUiwgMCk7DQog
CXJldHVybiByZWdjYWNoZV9zeW5jKHNhaS0+cmVnbWFwKTsNCiB9DQotI2VuZGlmIC8qIENPTkZJ
R19QTV9TTEVFUCAqLw0KKyNlbmRpZiAvKiBDT05GSUdfUE0gKi8NCiANCiBzdGF0aWMgY29uc3Qg
c3RydWN0IGRldl9wbV9vcHMgZnNsX3NhaV9wbV9vcHMgPSB7DQotCVNFVF9TWVNURU1fU0xFRVBf
UE1fT1BTKGZzbF9zYWlfc3VzcGVuZCwgZnNsX3NhaV9yZXN1bWUpDQorCVNFVF9SVU5USU1FX1BN
X09QUyhmc2xfc2FpX3J1bnRpbWVfc3VzcGVuZCwNCisJCQkgICBmc2xfc2FpX3J1bnRpbWVfcmVz
dW1lLCBOVUxMKQ0KKwlTRVRfU1lTVEVNX1NMRUVQX1BNX09QUyhwbV9ydW50aW1lX2ZvcmNlX3N1
c3BlbmQsDQorCQkJCXBtX3J1bnRpbWVfZm9yY2VfcmVzdW1lKQ0KIH07DQogDQogc3RhdGljIHN0
cnVjdCBwbGF0Zm9ybV9kcml2ZXIgZnNsX3NhaV9kcml2ZXIgPSB7DQogCS5wcm9iZSA9IGZzbF9z
YWlfcHJvYmUsDQorCS5yZW1vdmUgPSBmc2xfc2FpX3JlbW92ZSwNCiAJLmRyaXZlciA9IHsNCiAJ
CS5uYW1lID0gImZzbC1zYWkiLA0KIAkJLnBtID0gJmZzbF9zYWlfcG1fb3BzLA0KLS0gDQoyLjE3
LjENCg0K

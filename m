Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EB5C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 10:41:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 297A220830
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 10:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vjlEbidd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297A220830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fLLK0jfGzDqNj
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 20:41:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.65; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="vjlEbidd"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00065.outbound.protection.outlook.com [40.107.0.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fLFq5pZxzDqP2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 20:37:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7k8MdTq2WZP8IZ9fXNE30HwJBwh33rYsVy6IBwalXDw=;
 b=vjlEbiddAA2v0xNY49YC9QPbD5Qcw9qw3q3un83gYtP84fDadicfYVmoI4Q1v1tyNinNpUXd2BId8f8noghioXXKzhygiNZBcw/eUdPCbdT4yloByjbhnEhOdM693nvu9KZnT8C40poL4WhP/UFfOB3r/Q4ksREMCpHTP0zr2Y0=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB5549.eurprd04.prod.outlook.com (20.178.122.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Wed, 10 Apr 2019 10:37:29 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888%3]) with mapi id 15.20.1792.009; Wed, 10 Apr 2019
 10:37:29 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Takashi Iwai <tiwai@suse.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Julia Lawall
 <Julia.Lawall@lip6.fr>
Subject: [PATCH v3 1/4] ASoC: fsl_audmix: remove "model" attribute
Thread-Topic: [PATCH v3 1/4] ASoC: fsl_audmix: remove "model" attribute
Thread-Index: AQHU74llTOya3frf1k2uzJ2X5c1hIw==
Date: Wed, 10 Apr 2019 10:37:29 +0000
Message-ID: <1554892629-17646-2-git-send-email-viorel.suman@nxp.com>
References: <1554892629-17646-1-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1554892629-17646-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0085.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::11) To VI1PR04MB4704.eurprd04.prod.outlook.com
 (2603:10a6:803:52::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ab55d0a-5dd1-43fc-3f46-08d6bda087b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:VI1PR04MB5549; 
x-ms-traffictypediagnostic: VI1PR04MB5549:
x-microsoft-antispam-prvs: <VI1PR04MB554958A61EF62FA035A74355922E0@VI1PR04MB5549.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(136003)(396003)(366004)(39860400002)(199004)(189003)(105586002)(71190400001)(71200400001)(256004)(5660300002)(68736007)(106356001)(8676002)(81166006)(81156014)(508600001)(36756003)(66066001)(97736004)(102836004)(6506007)(486006)(25786009)(2616005)(11346002)(446003)(50226002)(386003)(26005)(4326008)(186003)(76176011)(14454004)(8936002)(6436002)(53936002)(7416002)(6486002)(2906002)(52116002)(6116002)(44832011)(54906003)(99286004)(3846002)(316002)(110136005)(86362001)(305945005)(6512007)(7736002)(476003)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5549;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: szUsqtwxWE4n07x3Lj5Iws9gSPSPaLTdnhrhD/VxvbQtEn4Z175vUjU13cvTr29+aeCAlLTbllXkiOBC4ZugaDdowgm/t3H1u+XFhy6VIaxBLTL1RQZ0r38Ob/FZtIyp0nOESjV62Jws6yHpyz6NW5aGk0qcY72Nhka9HhPd3RXFr1AKee8NFbGHvQx/EI9QkC0aJpIPmJwRgxhN6BGK3FczvrME2S1/eisHF9gh5ffeOWWEzWQhxJyTm+yjtRKSY5KivWQN5ZqBYCMSExriqLAS9Vkz6gv/hWECPN6MLkfhAzvdCXxUy0gj8spYTevLpcHHMjj3KeEaNVjO2KGnVwTDXtdyMJdI4hf5kklU+Q0M0wMJzcuPXi18RNHhzepZz8ODtEHUcN1RWeFd84IKyOj8Tc/cDRAtbOJ22DJ7diE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab55d0a-5dd1-43fc-3f46-08d6bda087b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 10:37:29.1666 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5549
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Viorel Suman <viorel.suman@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Viorel Suman <viorel.suman@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

VXNlICJvZl9kZXZpY2VfaWQuZGF0YSIgdG8gc3BlY2lmeSB0aGUgbWFjaGluZSBkcml2ZXINCmlu
c3RlYWQgb2YgIm1vZGVsIiBEVFMgYXR0cmlidXRlLg0KDQpTaWduZWQtb2ZmLWJ5OiBWaW9yZWwg
U3VtYW4gPHZpb3JlbC5zdW1hbkBueHAuY29tPg0KQWNrZWQtYnk6IE5pY29saW4gQ2hlbiA8bmlj
b2xlb3RzdWthQGdtYWlsLmNvbT4NCi0tLQ0KIHNvdW5kL3NvYy9mc2wvZnNsX2F1ZG1peC5jIHwg
NDMgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBj
aGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L3NvdW5kL3NvYy9mc2wvZnNsX2F1ZG1peC5jIGIvc291bmQvc29jL2ZzbC9mc2xfYXVkbWl4LmMN
CmluZGV4IGRhYmRlMDMuLmRjODAyZDUgMTAwNjQ0DQotLS0gYS9zb3VuZC9zb2MvZnNsL2ZzbF9h
dWRtaXguYw0KKysrIGIvc291bmQvc29jL2ZzbC9mc2xfYXVkbWl4LmMNCkBAIC00NDUsMTMgKzQ0
NSwyOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHJlZ21hcF9jb25maWcgZnNsX2F1ZG1peF9yZWdt
YXBfY29uZmlnID0gew0KIAkuY2FjaGVfdHlwZSA9IFJFR0NBQ0hFX0ZMQVQsDQogfTsNCiANCitz
dGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBmc2xfYXVkbWl4X2lkc1tdID0gew0KKwl7
DQorCQkuY29tcGF0aWJsZSA9ICJmc2wsaW14OHFtLWF1ZG1peCIsDQorCQkuZGF0YSA9ICJpbXgt
YXVkbWl4IiwNCisJfSwNCisJeyAvKiBzZW50aW5lbCAqLyB9DQorfTsNCitNT0RVTEVfREVWSUNF
X1RBQkxFKG9mLCBmc2xfYXVkbWl4X2lkcyk7DQorDQogc3RhdGljIGludCBmc2xfYXVkbWl4X3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogew0KIAlzdHJ1Y3QgZnNsX2F1ZG1p
eCAqcHJpdjsNCiAJc3RydWN0IHJlc291cmNlICpyZXM7DQorCWNvbnN0IGNoYXIgKm1kcnY7DQor
CWNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgKm9mX2lkOw0KIAl2b2lkIF9faW9tZW0gKnJlZ3M7
DQogCWludCByZXQ7DQotCWNvbnN0IGNoYXIgKnNwcm9wOw0KKw0KKwlvZl9pZCA9IG9mX21hdGNo
X2RldmljZShmc2xfYXVkbWl4X2lkcywgJnBkZXYtPmRldik7DQorCWlmICghb2ZfaWQgfHwgIW9m
X2lkLT5kYXRhKQ0KKwkJcmV0dXJuIC1FSU5WQUw7DQorDQorCW1kcnYgPSBvZl9pZC0+ZGF0YTsN
CiANCiAJcHJpdiA9IGRldm1fa3phbGxvYygmcGRldi0+ZGV2LCBzaXplb2YoKnByaXYpLCBHRlBf
S0VSTkVMKTsNCiAJaWYgKCFwcml2KQ0KQEAgLTQ4NywxOSArNTAzLDEyIEBAIHN0YXRpYyBpbnQg
ZnNsX2F1ZG1peF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJcmV0dXJu
IHJldDsNCiAJfQ0KIA0KLQlzcHJvcCA9IG9mX2dldF9wcm9wZXJ0eShwZGV2LT5kZXYub2Zfbm9k
ZSwgIm1vZGVsIiwgTlVMTCk7DQotCWlmIChzcHJvcCkgew0KLQkJcHJpdi0+cGRldiA9IHBsYXRm
b3JtX2RldmljZV9yZWdpc3Rlcl9kYXRhKCZwZGV2LT5kZXYsIHNwcm9wLCAwLA0KLQkJCQkJCQkg
ICBOVUxMLCAwKTsNCi0JCWlmIChJU19FUlIocHJpdi0+cGRldikpIHsNCi0JCQlyZXQgPSBQVFJf
RVJSKHByaXYtPnBkZXYpOw0KLQkJCWRldl9lcnIoJnBkZXYtPmRldiwNCi0JCQkJImZhaWxlZCB0
byByZWdpc3RlciBwbGF0Zm9ybSAlczogJWRcbiIsIHNwcm9wLA0KLQkJCQkgcmV0KTsNCi0JCX0N
Ci0JfSBlbHNlIHsNCi0JCWRldl9lcnIoJnBkZXYtPmRldiwgIlttb2RlbF0gYXR0cmlidXRlIG1p
c3NpbmcuXG4iKTsNCi0JCXJldCA9IC1FSU5WQUw7DQorCXByaXYtPnBkZXYgPSBwbGF0Zm9ybV9k
ZXZpY2VfcmVnaXN0ZXJfZGF0YSgmcGRldi0+ZGV2LCBtZHJ2LCAwLCBOVUxMLA0KKwkJCQkJCSAg
IDApOw0KKwlpZiAoSVNfRVJSKHByaXYtPnBkZXYpKSB7DQorCQlyZXQgPSBQVFJfRVJSKHByaXYt
PnBkZXYpOw0KKwkJZGV2X2VycigmcGRldi0+ZGV2LCAiZmFpbGVkIHRvIHJlZ2lzdGVyIHBsYXRm
b3JtICVzOiAlZFxuIiwNCisJCQltZHJ2LCByZXQpOw0KIAl9DQogDQogCXJldHVybiByZXQ7DQpA
QCAtNTUzLDEyICs1NjIsNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgZnNsX2F1
ZG1peF9wbSA9IHsNCiAJCQkJcG1fcnVudGltZV9mb3JjZV9yZXN1bWUpDQogfTsNCiANCi1zdGF0
aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBmc2xfYXVkbWl4X2lkc1tdID0gew0KLQl7IC5j
b21wYXRpYmxlID0gImZzbCxpbXg4cW0tYXVkbWl4IiwgfSwNCi0JeyAvKiBzZW50aW5lbCAqLyB9
DQotfTsNCi1NT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBmc2xfYXVkbWl4X2lkcyk7DQotDQogc3Rh
dGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgZnNsX2F1ZG1peF9kcml2ZXIgPSB7DQogCS5wcm9i
ZSA9IGZzbF9hdWRtaXhfcHJvYmUsDQogCS5yZW1vdmUgPSBmc2xfYXVkbWl4X3JlbW92ZSwNCi0t
IA0KMi43LjQNCg0K

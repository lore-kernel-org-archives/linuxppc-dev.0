Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E85FC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 11:17:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF53020818
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 11:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BFOcKG90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF53020818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fM7b3T1KzDqQV
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 21:17:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe0c::624;
 helo=eur04-db3-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="BFOcKG90"; 
 dkim-atps=neutral
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fLvZ64hjzDqNb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 21:06:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MctxggZmkPyOkmKAopS44v+JsLNR5zfdO1ZR7z9v8Bk=;
 b=BFOcKG90QsGdCuYcKRc4CILBIaklP/j3DtlOIvODgSq92HDzg3gIHP7AL/sQXipoH5pVva38zA9Kf0axRj/XH9A//L8yuXBhU/Dmu7NduAmdmk8EwTKwrXd0q3AIpCvqmUWkc5Yzr7jsZMBIwEuYBzP5/GOCp0+HiKKsc1Pdi0g=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB4574.eurprd04.prod.outlook.com (20.177.55.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Wed, 10 Apr 2019 11:06:41 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888%3]) with mapi id 15.20.1792.009; Wed, 10 Apr 2019
 11:06:41 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Takashi Iwai <tiwai@suse.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Julia Lawall
 <Julia.Lawall@lip6.fr>
Subject: [PATCH v4 4/4] ASoC: fsl_audmix: cache pdev->dev pointer
Thread-Topic: [PATCH v4 4/4] ASoC: fsl_audmix: cache pdev->dev pointer
Thread-Index: AQHU7414DWXUsXvcU0yn6Om9tlbh3g==
Date: Wed, 10 Apr 2019 11:06:39 +0000
Message-ID: <1554894380-25153-5-git-send-email-viorel.suman@nxp.com>
References: <1554894380-25153-1-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1554894380-25153-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0195.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::25) To VI1PR04MB4704.eurprd04.prod.outlook.com
 (2603:10a6:803:52::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f8e7cad-75cb-4c01-7dad-08d6bda49b0d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR04MB4574; 
x-ms-traffictypediagnostic: VI1PR04MB4574:
x-microsoft-antispam-prvs: <VI1PR04MB45748E89697148A6397815B5922E0@VI1PR04MB4574.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(39860400002)(376002)(136003)(346002)(189003)(199004)(386003)(6486002)(71190400001)(6506007)(97736004)(486006)(256004)(186003)(7416002)(26005)(102836004)(2616005)(446003)(36756003)(99286004)(476003)(44832011)(68736007)(110136005)(86362001)(316002)(71200400001)(11346002)(54906003)(66066001)(53936002)(508600001)(3846002)(106356001)(6116002)(105586002)(2906002)(6436002)(8936002)(50226002)(81166006)(5660300002)(7736002)(305945005)(6512007)(8676002)(4326008)(81156014)(14454004)(76176011)(52116002)(25786009)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4574;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pjByZJ1N845TVwzkeqyxHn+z0+BdHCaIkK5lp0ya07YyKYmoP/4p7+JLhLnLL7nIiWlAOrdmUv3cXwuzupanuukOJ2LGC39qO5PArnl2njYCXnjbkTYgWAO7FsfwKxB7Od6W9aGCP3WjDt8QhOBlLrwRSzZfPbAUNQeEMC+dtDVSUzKaRAWXXjbbQh1ICM05zmFeEjDIb27gQ6PyiJFHWSNEKrMLyUEkNJJAR3EMYP6G0H1DSfKtp9LPROcgXlOcI3aFZCajCCCRNihkcaAel2He0Yk6BeKdWS8dUsito9kZCuQ8b2CaVGqyHp/4/9+28M+zfcYEuOwvqBYeQySDXkRQPMW0FPC1xz2dySMa+P3G0y6Lkz+uI+flppvvfxqUN0p5qFfwDQYQZCkk5UeS+XyuRlDjeGUBS5SyQV+CBPs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8e7cad-75cb-4c01-7dad-08d6bda49b0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 11:06:39.5894 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4574
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

VGhlcmUgc2hvdWxkIGJlIG5vIHRyb3VibGUgdG8gdW5kZXJzdGFuZCBkZXYgPSBwZGV2LT5kZXYu
DQpUaGlzIGNhbiBzYXZlIHNvbWUgc3BhY2UgdG8gaGF2ZSBtb3JlIHByaW50IGluZm8gb3Igc2F2
ZQ0Kc29tZSB3cmFwcGVkIGxpbmVzLg0KDQpTaWduZWQtb2ZmLWJ5OiBWaW9yZWwgU3VtYW4gPHZp
b3JlbC5zdW1hbkBueHAuY29tPg0KU3VnZ2VzdGVkLWJ5OiBOaWNvbGluIENoZW4gPG5pY29sZW90
c3VrYUBnbWFpbC5jb20+DQotLS0NCiBzb3VuZC9zb2MvZnNsL2ZzbF9hdWRtaXguYyB8IDI3ICsr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25z
KCspLCAxNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9mc2wvZnNsX2F1
ZG1peC5jIGIvc291bmQvc29jL2ZzbC9mc2xfYXVkbWl4LmMNCmluZGV4IGRjODAyZDUuLjM4OTdh
NTQgMTAwNjQ0DQotLS0gYS9zb3VuZC9zb2MvZnNsL2ZzbF9hdWRtaXguYw0KKysrIGIvc291bmQv
c29jL2ZzbC9mc2xfYXVkbWl4LmMNCkBAIC00NTYsNiArNDU2LDcgQEAgTU9EVUxFX0RFVklDRV9U
QUJMRShvZiwgZnNsX2F1ZG1peF9pZHMpOw0KIA0KIHN0YXRpYyBpbnQgZnNsX2F1ZG1peF9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIHsNCisJc3RydWN0IGRldmljZSAqZGV2
ID0gJnBkZXYtPmRldjsNCiAJc3RydWN0IGZzbF9hdWRtaXggKnByaXY7DQogCXN0cnVjdCByZXNv
dXJjZSAqcmVzOw0KIAljb25zdCBjaGFyICptZHJ2Ow0KQEAgLTQ2Myw1MiArNDY0LDUwIEBAIHN0
YXRpYyBpbnQgZnNsX2F1ZG1peF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
IAl2b2lkIF9faW9tZW0gKnJlZ3M7DQogCWludCByZXQ7DQogDQotCW9mX2lkID0gb2ZfbWF0Y2hf
ZGV2aWNlKGZzbF9hdWRtaXhfaWRzLCAmcGRldi0+ZGV2KTsNCisJb2ZfaWQgPSBvZl9tYXRjaF9k
ZXZpY2UoZnNsX2F1ZG1peF9pZHMsIGRldik7DQogCWlmICghb2ZfaWQgfHwgIW9mX2lkLT5kYXRh
KQ0KIAkJcmV0dXJuIC1FSU5WQUw7DQogDQogCW1kcnYgPSBvZl9pZC0+ZGF0YTsNCiANCi0JcHJp
diA9IGRldm1fa3phbGxvYygmcGRldi0+ZGV2LCBzaXplb2YoKnByaXYpLCBHRlBfS0VSTkVMKTsN
CisJcHJpdiA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqcHJpdiksIEdGUF9LRVJORUwpOw0K
IAlpZiAoIXByaXYpDQogCQlyZXR1cm4gLUVOT01FTTsNCiANCiAJLyogR2V0IHRoZSBhZGRyZXNz
ZXMgKi8NCiAJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVN
LCAwKTsNCi0JcmVncyA9IGRldm1faW9yZW1hcF9yZXNvdXJjZSgmcGRldi0+ZGV2LCByZXMpOw0K
KwlyZWdzID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgcmVzKTsNCiAJaWYgKElTX0VSUihy
ZWdzKSkNCiAJCXJldHVybiBQVFJfRVJSKHJlZ3MpOw0KIA0KLQlwcml2LT5yZWdtYXAgPSBkZXZt
X3JlZ21hcF9pbml0X21taW9fY2xrKCZwZGV2LT5kZXYsICJpcGciLCByZWdzLA0KKwlwcml2LT5y
ZWdtYXAgPSBkZXZtX3JlZ21hcF9pbml0X21taW9fY2xrKGRldiwgImlwZyIsIHJlZ3MsDQogCQkJ
CQkJICZmc2xfYXVkbWl4X3JlZ21hcF9jb25maWcpOw0KIAlpZiAoSVNfRVJSKHByaXYtPnJlZ21h
cCkpIHsNCi0JCWRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byBpbml0IHJlZ21hcFxuIik7
DQorCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBpbml0IHJlZ21hcFxuIik7DQogCQlyZXR1cm4g
UFRSX0VSUihwcml2LT5yZWdtYXApOw0KIAl9DQogDQotCXByaXYtPmlwZ19jbGsgPSBkZXZtX2Ns
a19nZXQoJnBkZXYtPmRldiwgImlwZyIpOw0KKwlwcml2LT5pcGdfY2xrID0gZGV2bV9jbGtfZ2V0
KGRldiwgImlwZyIpOw0KIAlpZiAoSVNfRVJSKHByaXYtPmlwZ19jbGspKSB7DQotCQlkZXZfZXJy
KCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gZ2V0IGlwZyBjbG9ja1xuIik7DQorCQlkZXZfZXJyKGRl
diwgImZhaWxlZCB0byBnZXQgaXBnIGNsb2NrXG4iKTsNCiAJCXJldHVybiBQVFJfRVJSKHByaXYt
PmlwZ19jbGspOw0KIAl9DQogDQogCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIHByaXYpOw0K
LQlwbV9ydW50aW1lX2VuYWJsZSgmcGRldi0+ZGV2KTsNCisJcG1fcnVudGltZV9lbmFibGUoZGV2
KTsNCiANCi0JcmV0ID0gZGV2bV9zbmRfc29jX3JlZ2lzdGVyX2NvbXBvbmVudCgmcGRldi0+ZGV2
LCAmZnNsX2F1ZG1peF9jb21wb25lbnQsDQorCXJldCA9IGRldm1fc25kX3NvY19yZWdpc3Rlcl9j
b21wb25lbnQoZGV2LCAmZnNsX2F1ZG1peF9jb21wb25lbnQsDQogCQkJCQkgICAgICBmc2xfYXVk
bWl4X2RhaSwNCiAJCQkJCSAgICAgIEFSUkFZX1NJWkUoZnNsX2F1ZG1peF9kYWkpKTsNCiAJaWYg
KHJldCkgew0KLQkJZGV2X2VycigmcGRldi0+ZGV2LCAiZmFpbGVkIHRvIHJlZ2lzdGVyIEFTb0Mg
REFJXG4iKTsNCisJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIHJlZ2lzdGVyIEFTb0MgREFJXG4i
KTsNCiAJCXJldHVybiByZXQ7DQogCX0NCiANCi0JcHJpdi0+cGRldiA9IHBsYXRmb3JtX2Rldmlj
ZV9yZWdpc3Rlcl9kYXRhKCZwZGV2LT5kZXYsIG1kcnYsIDAsIE5VTEwsDQotCQkJCQkJICAgMCk7
DQorCXByaXYtPnBkZXYgPSBwbGF0Zm9ybV9kZXZpY2VfcmVnaXN0ZXJfZGF0YShkZXYsIG1kcnYs
IDAsIE5VTEwsIDApOw0KIAlpZiAoSVNfRVJSKHByaXYtPnBkZXYpKSB7DQogCQlyZXQgPSBQVFJf
RVJSKHByaXYtPnBkZXYpOw0KLQkJZGV2X2VycigmcGRldi0+ZGV2LCAiZmFpbGVkIHRvIHJlZ2lz
dGVyIHBsYXRmb3JtICVzOiAlZFxuIiwNCi0JCQltZHJ2LCByZXQpOw0KKwkJZGV2X2VycihkZXYs
ICJmYWlsZWQgdG8gcmVnaXN0ZXIgcGxhdGZvcm0gJXM6ICVkXG4iLCBtZHJ2LCByZXQpOw0KIAl9
DQogDQogCXJldHVybiByZXQ7DQotLSANCjIuNy40DQoNCg==

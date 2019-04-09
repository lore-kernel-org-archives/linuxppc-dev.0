Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FADC282CE
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 08:41:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B1DC20883
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 08:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s//d2iWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1DC20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dgjq1YRvzDqH4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 18:41:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.5.43; helo=eur03-ve1-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="s//d2iWU"; 
 dkim-atps=neutral
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50043.outbound.protection.outlook.com [40.107.5.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dgbl2sJXzDqH1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 18:35:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIOi0aXOnk4Ww6rHMC2vDAB6JLRJtoOZy4BXUig/maw=;
 b=s//d2iWUNDoxj79YjldQ5B+CUim78lR/AvTKeZo9N8G10+0Cxf6Ud4p8Rh7+RvjmZWEqhKhNTiV6ljgg+uI/NtZ4uGlTIa+LB6GkN4Z2FahU5XpOcF1zp6BlIGOYei0gcX0LTEfn5LB/QTNYJTGhm423LGS+H/jWOCwtnH4xSgU=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB3982.eurprd04.prod.outlook.com (10.171.182.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Tue, 9 Apr 2019 08:35:34 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888%3]) with mapi id 15.20.1792.009; Tue, 9 Apr 2019
 08:35:34 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Julia Lawall
 <Julia.Lawall@lip6.fr>
Subject: [PATCH 1/2] ASoC: fsl_audmix: remove "model" attribute
Thread-Topic: [PATCH 1/2] ASoC: fsl_audmix: remove "model" attribute
Thread-Index: AQHU7q8zRh1FbGktNEKV0aDW74+Gjw==
Date: Tue, 9 Apr 2019 08:35:34 +0000
Message-ID: <1554798876-20653-2-git-send-email-viorel.suman@nxp.com>
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
x-ms-office365-filtering-correlation-id: 32fb50fb-c1f4-4720-c217-08d6bcc65523
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:VI1PR04MB3982; 
x-ms-traffictypediagnostic: VI1PR04MB3982:
x-microsoft-antispam-prvs: <VI1PR04MB39822105394073F54131C0F1922D0@VI1PR04MB3982.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(136003)(376002)(346002)(39860400002)(199004)(189003)(11346002)(6512007)(8936002)(97736004)(486006)(8676002)(7416002)(81166006)(476003)(305945005)(446003)(53936002)(68736007)(7736002)(50226002)(6436002)(66066001)(86362001)(2616005)(316002)(6486002)(14454004)(36756003)(4326008)(2906002)(54906003)(106356001)(110136005)(71190400001)(105586002)(5660300002)(71200400001)(44832011)(186003)(6116002)(25786009)(3846002)(256004)(102836004)(26005)(52116002)(76176011)(99286004)(6506007)(386003)(81156014)(478600001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB3982;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: erAkZZad/AtxST3YHyiC93GrsR3wN3y5oKHmUIjrD3eNjClG3ktw0YE4TAtp0tmGQoWKQ7x89WvBQdLtTPvEwx+/JaIoamp0guogdLhyKIIbcEwzMhKygFDOBR4ecH9yRXBotuW/y6qyTYs/vQeGKT10lsuMMtHpNcSmUxOzwQkEdMQEGJ0PTDNJHatflgR2ULizBZeNCqreMlY57oRcl9w5Ehm+gksPO0qE4EkdMkHka87DGCaLa9/sSN64cjPgPGecKBPDyx/VhXnLxDYRniDBPscro7R/f4lPCQXVkss1alaGQZCaNuH1rqHmEOqep+svLpVOruTLulNQQCRSUIwZDtVT1EZQPjMkMLY9S3a8ufrwsFT57+V/LhQWF0TyQlgRmUhJllwm1j6QMLNjT7SpPxVWBsIi5cGyaUy3Zkg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fb50fb-c1f4-4720-c217-08d6bcc65523
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 08:35:34.3781 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3982
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

VXNlICJvZl9kZXZpY2VfaWQuZGF0YSIgdG8gc3BlY2lmeSB0aGUgbWFjaGluZSBkcml2ZXIsDQpp
bnN0ZWFkIG9mICJtb2RlbCIgRFRTIGF0dHJpYnV0ZS4NCg0KU2lnbmVkLW9mZi1ieTogVmlvcmVs
IFN1bWFuIDx2aW9yZWwuc3VtYW5AbnhwLmNvbT4NCi0tLQ0KIHNvdW5kL3NvYy9mc2wvZnNsX2F1
ZG1peC5jIHwgNjEgKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KIDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCAyOSBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9mc2wvZnNsX2F1ZG1peC5jIGIvc291bmQvc29jL2ZzbC9m
c2xfYXVkbWl4LmMNCmluZGV4IGRhYmRlMDMuLjJkMTBkOGIgMTAwNjQ0DQotLS0gYS9zb3VuZC9z
b2MvZnNsL2ZzbF9hdWRtaXguYw0KKysrIGIvc291bmQvc29jL2ZzbC9mc2xfYXVkbWl4LmMNCkBA
IC00NDUsNjEgKzQ0NSw3MCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHJlZ21hcF9jb25maWcgZnNs
X2F1ZG1peF9yZWdtYXBfY29uZmlnID0gew0KIAkuY2FjaGVfdHlwZSA9IFJFR0NBQ0hFX0ZMQVQs
DQogfTsNCiANCitzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBmc2xfYXVkbWl4X2lk
c1tdID0gew0KKwl7DQorCQkuY29tcGF0aWJsZSA9ICJmc2wsaW14OHFtLWF1ZG1peCIsDQorCQku
ZGF0YSA9ICJpbXgtYXVkbWl4IiwNCisJfSwNCisJeyAvKiBzZW50aW5lbCAqLyB9DQorfTsNCitN
T0RVTEVfREVWSUNFX1RBQkxFKG9mLCBmc2xfYXVkbWl4X2lkcyk7DQorDQogc3RhdGljIGludCBm
c2xfYXVkbWl4X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogew0KKwlzdHJ1
Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KIAlzdHJ1Y3QgZnNsX2F1ZG1peCAqcHJpdjsN
CiAJc3RydWN0IHJlc291cmNlICpyZXM7DQorCWNvbnN0IGNoYXIgKm1kcnY7DQorCWNvbnN0IHN0
cnVjdCBvZl9kZXZpY2VfaWQgKm9mX2lkOw0KIAl2b2lkIF9faW9tZW0gKnJlZ3M7DQogCWludCBy
ZXQ7DQotCWNvbnN0IGNoYXIgKnNwcm9wOw0KIA0KLQlwcml2ID0gZGV2bV9remFsbG9jKCZwZGV2
LT5kZXYsIHNpemVvZigqcHJpdiksIEdGUF9LRVJORUwpOw0KKwlvZl9pZCA9IG9mX21hdGNoX2Rl
dmljZShmc2xfYXVkbWl4X2lkcywgZGV2KTsNCisJaWYgKCFvZl9pZCB8fCAhb2ZfaWQtPmRhdGEp
DQorCQlyZXR1cm4gLUVJTlZBTDsNCisNCisJbWRydiA9IG9mX2lkLT5kYXRhOw0KKw0KKwlwcml2
ID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpwcml2KSwgR0ZQX0tFUk5FTCk7DQogCWlmICgh
cHJpdikNCiAJCXJldHVybiAtRU5PTUVNOw0KIA0KIAkvKiBHZXQgdGhlIGFkZHJlc3NlcyAqLw0K
IAlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0K
LQlyZWdzID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKCZwZGV2LT5kZXYsIHJlcyk7DQorCXJlZ3Mg
PSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXMpOw0KIAlpZiAoSVNfRVJSKHJlZ3MpKQ0K
IAkJcmV0dXJuIFBUUl9FUlIocmVncyk7DQogDQotCXByaXYtPnJlZ21hcCA9IGRldm1fcmVnbWFw
X2luaXRfbW1pb19jbGsoJnBkZXYtPmRldiwgImlwZyIsIHJlZ3MsDQorCXByaXYtPnJlZ21hcCA9
IGRldm1fcmVnbWFwX2luaXRfbW1pb19jbGsoZGV2LCAiaXBnIiwgcmVncywNCiAJCQkJCQkgJmZz
bF9hdWRtaXhfcmVnbWFwX2NvbmZpZyk7DQogCWlmIChJU19FUlIocHJpdi0+cmVnbWFwKSkgew0K
LQkJZGV2X2VycigmcGRldi0+ZGV2LCAiZmFpbGVkIHRvIGluaXQgcmVnbWFwXG4iKTsNCisJCWRl
dl9lcnIoZGV2LCAiZmFpbGVkIHRvIGluaXQgcmVnbWFwXG4iKTsNCiAJCXJldHVybiBQVFJfRVJS
KHByaXYtPnJlZ21hcCk7DQogCX0NCiANCi0JcHJpdi0+aXBnX2NsayA9IGRldm1fY2xrX2dldCgm
cGRldi0+ZGV2LCAiaXBnIik7DQorCXByaXYtPmlwZ19jbGsgPSBkZXZtX2Nsa19nZXQoZGV2LCAi
aXBnIik7DQogCWlmIChJU19FUlIocHJpdi0+aXBnX2NsaykpIHsNCi0JCWRldl9lcnIoJnBkZXYt
PmRldiwgImZhaWxlZCB0byBnZXQgaXBnIGNsb2NrXG4iKTsNCisJCWRldl9lcnIoZGV2LCAiZmFp
bGVkIHRvIGdldCBpcGcgY2xvY2tcbiIpOw0KIAkJcmV0dXJuIFBUUl9FUlIocHJpdi0+aXBnX2Ns
ayk7DQogCX0NCiANCiAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgcHJpdik7DQotCXBtX3J1
bnRpbWVfZW5hYmxlKCZwZGV2LT5kZXYpOw0KKwlwbV9ydW50aW1lX2VuYWJsZShkZXYpOw0KIA0K
LQlyZXQgPSBkZXZtX3NuZF9zb2NfcmVnaXN0ZXJfY29tcG9uZW50KCZwZGV2LT5kZXYsICZmc2xf
YXVkbWl4X2NvbXBvbmVudCwNCisJcmV0ID0gZGV2bV9zbmRfc29jX3JlZ2lzdGVyX2NvbXBvbmVu
dChkZXYsICZmc2xfYXVkbWl4X2NvbXBvbmVudCwNCiAJCQkJCSAgICAgIGZzbF9hdWRtaXhfZGFp
LA0KIAkJCQkJICAgICAgQVJSQVlfU0laRShmc2xfYXVkbWl4X2RhaSkpOw0KIAlpZiAocmV0KSB7
DQotCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gcmVnaXN0ZXIgQVNvQyBEQUlcbiIp
Ow0KKwkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gcmVnaXN0ZXIgQVNvQyBEQUlcbiIpOw0KIAkJ
cmV0dXJuIHJldDsNCiAJfQ0KIA0KLQlzcHJvcCA9IG9mX2dldF9wcm9wZXJ0eShwZGV2LT5kZXYu
b2Zfbm9kZSwgIm1vZGVsIiwgTlVMTCk7DQotCWlmIChzcHJvcCkgew0KLQkJcHJpdi0+cGRldiA9
IHBsYXRmb3JtX2RldmljZV9yZWdpc3Rlcl9kYXRhKCZwZGV2LT5kZXYsIHNwcm9wLCAwLA0KLQkJ
CQkJCQkgICBOVUxMLCAwKTsNCi0JCWlmIChJU19FUlIocHJpdi0+cGRldikpIHsNCi0JCQlyZXQg
PSBQVFJfRVJSKHByaXYtPnBkZXYpOw0KLQkJCWRldl9lcnIoJnBkZXYtPmRldiwNCi0JCQkJImZh
aWxlZCB0byByZWdpc3RlciBwbGF0Zm9ybSAlczogJWRcbiIsIHNwcm9wLA0KLQkJCQkgcmV0KTsN
Ci0JCX0NCi0JfSBlbHNlIHsNCi0JCWRldl9lcnIoJnBkZXYtPmRldiwgIlttb2RlbF0gYXR0cmli
dXRlIG1pc3NpbmcuXG4iKTsNCi0JCXJldCA9IC1FSU5WQUw7DQorCXByaXYtPnBkZXYgPSBwbGF0
Zm9ybV9kZXZpY2VfcmVnaXN0ZXJfZGF0YShkZXYsIG1kcnYsIDAsIE5VTEwsIDApOw0KKwlpZiAo
SVNfRVJSKHByaXYtPnBkZXYpKSB7DQorCQlyZXQgPSBQVFJfRVJSKHByaXYtPnBkZXYpOw0KKwkJ
ZGV2X2VycihkZXYsICJmYWlsZWQgdG8gcmVnaXN0ZXIgcGxhdGZvcm0gJXM6ICVkXG4iLA0KKwkJ
CW1kcnYsIHJldCk7DQogCX0NCiANCiAJcmV0dXJuIHJldDsNCkBAIC01NTMsMTIgKzU2Miw2IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBmc2xfYXVkbWl4X3BtID0gew0KIAkJCQlw
bV9ydW50aW1lX2ZvcmNlX3Jlc3VtZSkNCiB9Ow0KIA0KLXN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2Zf
ZGV2aWNlX2lkIGZzbF9hdWRtaXhfaWRzW10gPSB7DQotCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlt
eDhxbS1hdWRtaXgiLCB9LA0KLQl7IC8qIHNlbnRpbmVsICovIH0NCi19Ow0KLU1PRFVMRV9ERVZJ
Q0VfVEFCTEUob2YsIGZzbF9hdWRtaXhfaWRzKTsNCi0NCiBzdGF0aWMgc3RydWN0IHBsYXRmb3Jt
X2RyaXZlciBmc2xfYXVkbWl4X2RyaXZlciA9IHsNCiAJLnByb2JlID0gZnNsX2F1ZG1peF9wcm9i
ZSwNCiAJLnJlbW92ZSA9IGZzbF9hdWRtaXhfcmVtb3ZlLA0KLS0gDQoyLjcuNA0KDQo=

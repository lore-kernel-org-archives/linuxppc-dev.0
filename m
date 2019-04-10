Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE30CC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 10:46:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4943B20830
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 10:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gmeyMy3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4943B20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fLS15xD7zDqQZ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 20:46:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.15.50; helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="gmeyMy3R"; 
 dkim-atps=neutral
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150050.outbound.protection.outlook.com [40.107.15.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fLFw65wXzDqNN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 20:37:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFuBnTaDWCUk5Nzc2pHPVDkfsEOZvJqcgHo9ZnZ2QJ4=;
 b=gmeyMy3RoMW4DfOLyPKLnJfSRtkUPPVR95R40bdE1kKKZwoidUCgA48HevgWQE0W5+RpqSGPbi9SRogzBxKXDnyve6aY+NGQBDgeuLLf1dLDaEdOqfIw5BjRInC44d5yn/r31ziUbcFFdIktlydcqKTKIG/lqiawUChguhC3pR0=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB5311.eurprd04.prod.outlook.com (20.177.52.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Wed, 10 Apr 2019 10:37:32 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888%3]) with mapi id 15.20.1792.009; Wed, 10 Apr 2019
 10:37:32 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Takashi Iwai <tiwai@suse.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Julia Lawall
 <Julia.Lawall@lip6.fr>
Subject: [PATCH v3 4/4] ASoC: fsl_audmix: cache pdev->dev pointer
Thread-Topic: [PATCH v3 4/4] ASoC: fsl_audmix: cache pdev->dev pointer
Thread-Index: AQHU74lnSBF1izhvzUSSxWwigACyXQ==
Date: Wed, 10 Apr 2019 10:37:32 +0000
Message-ID: <1554892629-17646-5-git-send-email-viorel.suman@nxp.com>
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
x-ms-office365-filtering-correlation-id: 13789018-5281-4c50-cc96-08d6bda089c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR04MB5311; 
x-ms-traffictypediagnostic: VI1PR04MB5311:
x-microsoft-antispam-prvs: <VI1PR04MB5311D5F9B05E31113B536741922E0@VI1PR04MB5311.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(346002)(136003)(376002)(366004)(396003)(199004)(189003)(305945005)(386003)(256004)(186003)(7736002)(6512007)(25786009)(14454004)(52116002)(71200400001)(26005)(99286004)(110136005)(53936002)(102836004)(54906003)(36756003)(76176011)(4326008)(316002)(97736004)(486006)(11346002)(50226002)(446003)(68736007)(44832011)(6436002)(476003)(6506007)(106356001)(3846002)(2906002)(508600001)(6116002)(5660300002)(6486002)(8936002)(66066001)(71190400001)(7416002)(86362001)(8676002)(81156014)(81166006)(2616005)(105586002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5311;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VIX24OEREhVEAs4QB8iib0HhcqIOTRLT1U/1v4kf4UzNVc6zGfP6KUwI9cMBTfDeqmjJZcRHMTbE1pzVlqiu/JQl2Znhfwq4+fyekbAv4I750N+fDlFTbstyO8c+7b1d96XG9JE9p7RSQMirjiZc4jSmzXGvfUpYR5gNpmPu9oL7KOve+Ai4SYJUXcxl8SeoZtOGDbFkH+lBElWv0FD1IALgaJTjJBt3PwqNco3rF8aC3R7eIfzu70KvPtaCIXOybnu0gPXAN2/fyNk1kMVRO7iyFxC5Vs4dhLmNFuSq5HCP9zzsj6ao/UJaUnVayJ31ckiST3EUh7ZTzIJbZXBBJWiWjHKoFUiplhuOOCKv+49YWGZ24hpydEMBiLTkMP7HXX5I+dpR7Vxq0rKtkC4Tjejk+C7/OYKXIO/ZXmPHU10=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13789018-5281-4c50-cc96-08d6bda089c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 10:37:32.6971 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5311
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
c3VrYUBnbWFpbC5jb20+DQotLS0NCiBzb3VuZC9zb2MvZnNsL2ZzbF9hdWRtaXguYyB8IDI2ICsr
KysrKysrKysrKystLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMo
KyksIDEzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvc291bmQvc29jL2ZzbC9mc2xfYXVk
bWl4LmMgYi9zb3VuZC9zb2MvZnNsL2ZzbF9hdWRtaXguYw0KaW5kZXggZGM4MDJkNS4uMmQxMGQ4
YiAxMDA2NDQNCi0tLSBhL3NvdW5kL3NvYy9mc2wvZnNsX2F1ZG1peC5jDQorKysgYi9zb3VuZC9z
b2MvZnNsL2ZzbF9hdWRtaXguYw0KQEAgLTQ1Niw2ICs0NTYsNyBAQCBNT0RVTEVfREVWSUNFX1RB
QkxFKG9mLCBmc2xfYXVkbWl4X2lkcyk7DQogDQogc3RhdGljIGludCBmc2xfYXVkbWl4X3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogew0KKwlzdHJ1Y3QgZGV2aWNlICpkZXYg
PSAmcGRldi0+ZGV2Ow0KIAlzdHJ1Y3QgZnNsX2F1ZG1peCAqcHJpdjsNCiAJc3RydWN0IHJlc291
cmNlICpyZXM7DQogCWNvbnN0IGNoYXIgKm1kcnY7DQpAQCAtNDYzLDUxICs0NjQsNTAgQEAgc3Rh
dGljIGludCBmc2xfYXVkbWl4X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQog
CXZvaWQgX19pb21lbSAqcmVnczsNCiAJaW50IHJldDsNCiANCi0Jb2ZfaWQgPSBvZl9tYXRjaF9k
ZXZpY2UoZnNsX2F1ZG1peF9pZHMsICZwZGV2LT5kZXYpOw0KKwlvZl9pZCA9IG9mX21hdGNoX2Rl
dmljZShmc2xfYXVkbWl4X2lkcywgZGV2KTsNCiAJaWYgKCFvZl9pZCB8fCAhb2ZfaWQtPmRhdGEp
DQogCQlyZXR1cm4gLUVJTlZBTDsNCiANCiAJbWRydiA9IG9mX2lkLT5kYXRhOw0KIA0KLQlwcml2
ID0gZGV2bV9remFsbG9jKCZwZGV2LT5kZXYsIHNpemVvZigqcHJpdiksIEdGUF9LRVJORUwpOw0K
Kwlwcml2ID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpwcml2KSwgR0ZQX0tFUk5FTCk7DQog
CWlmICghcHJpdikNCiAJCXJldHVybiAtRU5PTUVNOw0KIA0KIAkvKiBHZXQgdGhlIGFkZHJlc3Nl
cyAqLw0KIAlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0s
IDApOw0KLQlyZWdzID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKCZwZGV2LT5kZXYsIHJlcyk7DQor
CXJlZ3MgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXMpOw0KIAlpZiAoSVNfRVJSKHJl
Z3MpKQ0KIAkJcmV0dXJuIFBUUl9FUlIocmVncyk7DQogDQotCXByaXYtPnJlZ21hcCA9IGRldm1f
cmVnbWFwX2luaXRfbW1pb19jbGsoJnBkZXYtPmRldiwgImlwZyIsIHJlZ3MsDQorCXByaXYtPnJl
Z21hcCA9IGRldm1fcmVnbWFwX2luaXRfbW1pb19jbGsoZGV2LCAiaXBnIiwgcmVncywNCiAJCQkJ
CQkgJmZzbF9hdWRtaXhfcmVnbWFwX2NvbmZpZyk7DQogCWlmIChJU19FUlIocHJpdi0+cmVnbWFw
KSkgew0KLQkJZGV2X2VycigmcGRldi0+ZGV2LCAiZmFpbGVkIHRvIGluaXQgcmVnbWFwXG4iKTsN
CisJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGluaXQgcmVnbWFwXG4iKTsNCiAJCXJldHVybiBQ
VFJfRVJSKHByaXYtPnJlZ21hcCk7DQogCX0NCiANCi0JcHJpdi0+aXBnX2NsayA9IGRldm1fY2xr
X2dldCgmcGRldi0+ZGV2LCAiaXBnIik7DQorCXByaXYtPmlwZ19jbGsgPSBkZXZtX2Nsa19nZXQo
ZGV2LCAiaXBnIik7DQogCWlmIChJU19FUlIocHJpdi0+aXBnX2NsaykpIHsNCi0JCWRldl9lcnIo
JnBkZXYtPmRldiwgImZhaWxlZCB0byBnZXQgaXBnIGNsb2NrXG4iKTsNCisJCWRldl9lcnIoZGV2
LCAiZmFpbGVkIHRvIGdldCBpcGcgY2xvY2tcbiIpOw0KIAkJcmV0dXJuIFBUUl9FUlIocHJpdi0+
aXBnX2Nsayk7DQogCX0NCiANCiAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgcHJpdik7DQot
CXBtX3J1bnRpbWVfZW5hYmxlKCZwZGV2LT5kZXYpOw0KKwlwbV9ydW50aW1lX2VuYWJsZShkZXYp
Ow0KIA0KLQlyZXQgPSBkZXZtX3NuZF9zb2NfcmVnaXN0ZXJfY29tcG9uZW50KCZwZGV2LT5kZXYs
ICZmc2xfYXVkbWl4X2NvbXBvbmVudCwNCisJcmV0ID0gZGV2bV9zbmRfc29jX3JlZ2lzdGVyX2Nv
bXBvbmVudChkZXYsICZmc2xfYXVkbWl4X2NvbXBvbmVudCwNCiAJCQkJCSAgICAgIGZzbF9hdWRt
aXhfZGFpLA0KIAkJCQkJICAgICAgQVJSQVlfU0laRShmc2xfYXVkbWl4X2RhaSkpOw0KIAlpZiAo
cmV0KSB7DQotCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gcmVnaXN0ZXIgQVNvQyBE
QUlcbiIpOw0KKwkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gcmVnaXN0ZXIgQVNvQyBEQUlcbiIp
Ow0KIAkJcmV0dXJuIHJldDsNCiAJfQ0KIA0KLQlwcml2LT5wZGV2ID0gcGxhdGZvcm1fZGV2aWNl
X3JlZ2lzdGVyX2RhdGEoJnBkZXYtPmRldiwgbWRydiwgMCwgTlVMTCwNCi0JCQkJCQkgICAwKTsN
CisJcHJpdi0+cGRldiA9IHBsYXRmb3JtX2RldmljZV9yZWdpc3Rlcl9kYXRhKGRldiwgbWRydiwg
MCwgTlVMTCwgMCk7DQogCWlmIChJU19FUlIocHJpdi0+cGRldikpIHsNCiAJCXJldCA9IFBUUl9F
UlIocHJpdi0+cGRldik7DQotCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gcmVnaXN0
ZXIgcGxhdGZvcm0gJXM6ICVkXG4iLA0KKwkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gcmVnaXN0
ZXIgcGxhdGZvcm0gJXM6ICVkXG4iLA0KIAkJCW1kcnYsIHJldCk7DQogCX0NCiANCi0tIA0KMi43
LjQNCg0K

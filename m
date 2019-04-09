Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFDCC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 11:33:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1AB620857
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 11:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SEFirZVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1AB620857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dlX94lS9zDqC9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 21:32:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.49; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="SEFirZVX"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00049.outbound.protection.outlook.com [40.107.0.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dlQK0VMZzDqJj
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 21:27:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2Ju+O4UGe6Y9ew5sPc51J2IVGIlIFdE3CIXc++UUIQ=;
 b=SEFirZVXUjYg3rzInFTKNYZGQmNwdgeqvz3bjxgWoNc2QI9C36mI07MnlSPpwL06qFqNjvHijuYhQIT7oax1Z/Yt9bJowcX3gCiNhSg4vYV2d0361ZhTvdABU6j6zYJAXtR+QLc/Xxa6V1ufVu+yBvLIsm0Cj0p8qVOv+BIYlqo=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB3086.eurprd04.prod.outlook.com (10.170.228.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Tue, 9 Apr 2019 11:27:39 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888%3]) with mapi id 15.20.1792.009; Tue, 9 Apr 2019
 11:27:39 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Takashi Iwai <tiwai@suse.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Julia Lawall
 <Julia.Lawall@lip6.fr>
Subject: [PATCH v2 1/3] ASoC: fsl_audmix: remove "model" attribute
Thread-Topic: [PATCH v2 1/3] ASoC: fsl_audmix: remove "model" attribute
Thread-Index: AQHU7sc9qpmulFGub0K/+sjdGTcqzQ==
Date: Tue, 9 Apr 2019 11:27:39 +0000
Message-ID: <1554809242-27475-2-git-send-email-viorel.suman@nxp.com>
References: <1554809242-27475-1-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1554809242-27475-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0187.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::17) To VI1PR04MB4704.eurprd04.prod.outlook.com
 (2603:10a6:803:52::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6a08f5c-6eb6-42a6-7f9d-08d6bcde5fc7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:VI1PR04MB3086; 
x-ms-traffictypediagnostic: VI1PR04MB3086:
x-microsoft-antispam-prvs: <VI1PR04MB3086CBE425240E356B79992E922D0@VI1PR04MB3086.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(39860400002)(366004)(396003)(376002)(189003)(199004)(106356001)(71200400001)(71190400001)(256004)(68736007)(5660300002)(8676002)(81156014)(81166006)(105586002)(478600001)(97736004)(66066001)(36756003)(102836004)(6506007)(7416002)(486006)(476003)(2616005)(11346002)(446003)(4326008)(8936002)(386003)(6512007)(26005)(186003)(14454004)(50226002)(25786009)(6436002)(53936002)(76176011)(2906002)(54906003)(3846002)(6116002)(99286004)(44832011)(52116002)(305945005)(316002)(110136005)(86362001)(6486002)(7736002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB3086;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 95i6TN7GaBzkU5P57jb+4ULHKIXyclcp3SSHC54zAkXb2aIdZ2F3l4pZndhNXdYV3oZ9nCEt1rS8kcZXYAqaHuMILVpvta9fRQGA/Ave8X5oZQDlxz4FISAkpBnMyimDBeEMuHsjnbVRfXzf1LVCLffMJfx70qLSkzQwxiumbyIVKhbWvQdO7JQmzDkP3Yx7kGjZodwOhIsX7JifTB/gzFTOnJdXPKMafpjwNzI0LkJRSpw/qM+oqX5kQoswPlcMZyNHEBpjqfo3bGL0JAgSMoLnUzXc69BJuJTeCNaKz4zybxUfNbK0wSvn1pYBTUeQPz3SrjO1h+h2WxukGLFVgKuom3RmJmj4ohbDcE8rO+POEBV10le11YU9yZtK9KFuXUQSB10Lr8GMfHQpZeZSOiNRSBfS7dKFDm6fAfmrs+4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a08f5c-6eb6-42a6-7f9d-08d6bcde5fc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 11:27:39.7927 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3086
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
U3VtYW4gPHZpb3JlbC5zdW1hbkBueHAuY29tPg0KLS0tDQogc291bmQvc29jL2ZzbC9mc2xfYXVk
bWl4LmMgfCA0MyArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tDQog
MSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvc291bmQvc29jL2ZzbC9mc2xfYXVkbWl4LmMgYi9zb3VuZC9zb2MvZnNsL2ZzbF9h
dWRtaXguYw0KaW5kZXggZGFiZGUwMy4uZGM4MDJkNSAxMDA2NDQNCi0tLSBhL3NvdW5kL3NvYy9m
c2wvZnNsX2F1ZG1peC5jDQorKysgYi9zb3VuZC9zb2MvZnNsL2ZzbF9hdWRtaXguYw0KQEAgLTQ0
NSwxMyArNDQ1LDI5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcmVnbWFwX2NvbmZpZyBmc2xfYXVk
bWl4X3JlZ21hcF9jb25maWcgPSB7DQogCS5jYWNoZV90eXBlID0gUkVHQ0FDSEVfRkxBVCwNCiB9
Ow0KIA0KK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGZzbF9hdWRtaXhfaWRzW10g
PSB7DQorCXsNCisJCS5jb21wYXRpYmxlID0gImZzbCxpbXg4cW0tYXVkbWl4IiwNCisJCS5kYXRh
ID0gImlteC1hdWRtaXgiLA0KKwl9LA0KKwl7IC8qIHNlbnRpbmVsICovIH0NCit9Ow0KK01PRFVM
RV9ERVZJQ0VfVEFCTEUob2YsIGZzbF9hdWRtaXhfaWRzKTsNCisNCiBzdGF0aWMgaW50IGZzbF9h
dWRtaXhfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiB7DQogCXN0cnVjdCBm
c2xfYXVkbWl4ICpwcml2Ow0KIAlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCisJY29uc3QgY2hhciAq
bWRydjsNCisJY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCAqb2ZfaWQ7DQogCXZvaWQgX19pb21l
bSAqcmVnczsNCiAJaW50IHJldDsNCi0JY29uc3QgY2hhciAqc3Byb3A7DQorDQorCW9mX2lkID0g
b2ZfbWF0Y2hfZGV2aWNlKGZzbF9hdWRtaXhfaWRzLCAmcGRldi0+ZGV2KTsNCisJaWYgKCFvZl9p
ZCB8fCAhb2ZfaWQtPmRhdGEpDQorCQlyZXR1cm4gLUVJTlZBTDsNCisNCisJbWRydiA9IG9mX2lk
LT5kYXRhOw0KIA0KIAlwcml2ID0gZGV2bV9remFsbG9jKCZwZGV2LT5kZXYsIHNpemVvZigqcHJp
diksIEdGUF9LRVJORUwpOw0KIAlpZiAoIXByaXYpDQpAQCAtNDg3LDE5ICs1MDMsMTIgQEAgc3Rh
dGljIGludCBmc2xfYXVkbWl4X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQog
CQlyZXR1cm4gcmV0Ow0KIAl9DQogDQotCXNwcm9wID0gb2ZfZ2V0X3Byb3BlcnR5KHBkZXYtPmRl
di5vZl9ub2RlLCAibW9kZWwiLCBOVUxMKTsNCi0JaWYgKHNwcm9wKSB7DQotCQlwcml2LT5wZGV2
ID0gcGxhdGZvcm1fZGV2aWNlX3JlZ2lzdGVyX2RhdGEoJnBkZXYtPmRldiwgc3Byb3AsIDAsDQot
CQkJCQkJCSAgIE5VTEwsIDApOw0KLQkJaWYgKElTX0VSUihwcml2LT5wZGV2KSkgew0KLQkJCXJl
dCA9IFBUUl9FUlIocHJpdi0+cGRldik7DQotCQkJZGV2X2VycigmcGRldi0+ZGV2LA0KLQkJCQki
ZmFpbGVkIHRvIHJlZ2lzdGVyIHBsYXRmb3JtICVzOiAlZFxuIiwgc3Byb3AsDQotCQkJCSByZXQp
Ow0KLQkJfQ0KLQl9IGVsc2Ugew0KLQkJZGV2X2VycigmcGRldi0+ZGV2LCAiW21vZGVsXSBhdHRy
aWJ1dGUgbWlzc2luZy5cbiIpOw0KLQkJcmV0ID0gLUVJTlZBTDsNCisJcHJpdi0+cGRldiA9IHBs
YXRmb3JtX2RldmljZV9yZWdpc3Rlcl9kYXRhKCZwZGV2LT5kZXYsIG1kcnYsIDAsIE5VTEwsDQor
CQkJCQkJICAgMCk7DQorCWlmIChJU19FUlIocHJpdi0+cGRldikpIHsNCisJCXJldCA9IFBUUl9F
UlIocHJpdi0+cGRldik7DQorCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gcmVnaXN0
ZXIgcGxhdGZvcm0gJXM6ICVkXG4iLA0KKwkJCW1kcnYsIHJldCk7DQogCX0NCiANCiAJcmV0dXJu
IHJldDsNCkBAIC01NTMsMTIgKzU2Miw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29w
cyBmc2xfYXVkbWl4X3BtID0gew0KIAkJCQlwbV9ydW50aW1lX2ZvcmNlX3Jlc3VtZSkNCiB9Ow0K
IA0KLXN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGZzbF9hdWRtaXhfaWRzW10gPSB7
DQotCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDhxbS1hdWRtaXgiLCB9LA0KLQl7IC8qIHNlbnRp
bmVsICovIH0NCi19Ow0KLU1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGZzbF9hdWRtaXhfaWRzKTsN
Ci0NCiBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBmc2xfYXVkbWl4X2RyaXZlciA9IHsN
CiAJLnByb2JlID0gZnNsX2F1ZG1peF9wcm9iZSwNCiAJLnJlbW92ZSA9IGZzbF9hdWRtaXhfcmVt
b3ZlLA0KLS0gDQoyLjcuNA0KDQo=

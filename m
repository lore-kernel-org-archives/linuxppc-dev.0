Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBDBC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 10:44:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D2DB20830
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 10:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="yDovSfjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2DB20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fLPl3R20zDqPf
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 20:44:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.15.50; helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="yDovSfjE"; 
 dkim-atps=neutral
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150050.outbound.protection.outlook.com [40.107.15.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fLFv5SSGzDqNN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 20:37:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHLfWL99Jd3f9+2McXqmoZGFc8zxEJqeCXM0AEjHsyo=;
 b=yDovSfjElo23cFxy6j8XpObXYRGyWZXGnz1t5pQr6z078UcIbvJCx2Lc8lJwaoZ+EXGm1pb2kAklhimDA2SAybjtznqvXL6ew9EkdvEQtTpMUpVVHrKMUQDXSznusJozmNSTGNMLbstl9fJbHKluumhjbdsmcvO2V/4uUFBoOGg=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB5311.eurprd04.prod.outlook.com (20.177.52.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Wed, 10 Apr 2019 10:37:31 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888%3]) with mapi id 15.20.1792.009; Wed, 10 Apr 2019
 10:37:31 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Takashi Iwai <tiwai@suse.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Julia Lawall
 <Julia.Lawall@lip6.fr>
Subject: [PATCH v3 3/4] ASoC: imx-audmix: fix object reference leaks in probe
Thread-Topic: [PATCH v3 3/4] ASoC: imx-audmix: fix object reference leaks in
 probe
Thread-Index: AQHU74lmAwDFsPbQ90OQFyNjLDrhBw==
Date: Wed, 10 Apr 2019 10:37:31 +0000
Message-ID: <1554892629-17646-4-git-send-email-viorel.suman@nxp.com>
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
x-ms-office365-filtering-correlation-id: 1c97b5d8-5969-4830-d2d8-08d6bda08917
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR04MB5311; 
x-ms-traffictypediagnostic: VI1PR04MB5311:
x-microsoft-antispam-prvs: <VI1PR04MB5311F35F8199B0CB0B85415B922E0@VI1PR04MB5311.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(39860400002)(346002)(136003)(376002)(366004)(396003)(199004)(189003)(305945005)(386003)(256004)(186003)(7736002)(6512007)(25786009)(14454004)(52116002)(71200400001)(26005)(99286004)(110136005)(53936002)(102836004)(54906003)(36756003)(76176011)(4326008)(316002)(97736004)(486006)(11346002)(50226002)(446003)(68736007)(44832011)(6436002)(476003)(6506007)(106356001)(3846002)(2906002)(508600001)(6116002)(5660300002)(6486002)(8936002)(66066001)(71190400001)(7416002)(86362001)(8676002)(81156014)(81166006)(2616005)(105586002)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5311;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lnooFoT5r9UXrq+AY+eyzGS/W3sEgNdHFVvF9kTuT11ssBrRTkhJ8ciecwUt2fDFTjN44cgY3SzoNQdW5P0s2dk6X7+vCrBvaiKiA2VVMWtTeA3nx7YgGsjZZSK3HTrSyhDYkuyz7KDwi+333XGRh5QeyhscStZ10uHG1FVudfzTc2bP5HUzpX41JiLtq0pQtPCpV2HMQRl2lGnMBeq2L4TZijV8XOxFmXMGUjRzcLMyOg/bZWSLIaIQvhYZW2rmqOKClQvqog11BRz9aa3hRPjGFckW/kkIvn0LMRCkx2S7lcbNnv2mOtLM+lMr4MbYjzTOeVi2bSPnOCEuVGf9/r1gmD2Rrz7dN7YoQTzBSJ7USxHvwY3aPQDvxKd5VLzxJdZ8sgKnPyt6bK0cw5zdA6U0tEiFq/XoK2We05GWCXw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c97b5d8-5969-4830-d2d8-08d6bda08917
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 10:37:31.4922 (UTC)
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

UmVsZWFzZSB0aGUgcmVmZXJlbmNlIHRvIHRoZSB1bmRlcmx5aW5nIGRldmljZSB0YWtlbg0KYnkg
b2ZfZmluZF9kZXZpY2VfYnlfbm9kZSgpIGNhbGwuDQoNClNpZ25lZC1vZmYtYnk6IFZpb3JlbCBT
dW1hbiA8dmlvcmVsLnN1bWFuQG54cC5jb20+DQpSZXBvcnRlZC1ieTogSnVsaWEgTGF3YWxsIDxK
dWxpYS5MYXdhbGxAbGlwNi5mcj4NCkFja2VkLWJ5OiBOaWNvbGluIENoZW4gPG5pY29sZW90c3Vr
YUBnbWFpbC5jb20+DQotLS0NCiBzb3VuZC9zb2MvZnNsL2lteC1hdWRtaXguYyB8IDQgKysrKw0K
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL3NvdW5kL3Nv
Yy9mc2wvaW14LWF1ZG1peC5jIGIvc291bmQvc29jL2ZzbC9pbXgtYXVkbWl4LmMNCmluZGV4IDc5
ODNiZDMuLjlhYWYzZTUgMTAwNjQ0DQotLS0gYS9zb3VuZC9zb2MvZnNsL2lteC1hdWRtaXguYw0K
KysrIGIvc291bmQvc29jL2ZzbC9pbXgtYXVkbWl4LmMNCkBAIC0xNzEsNiArMTcxLDcgQEAgc3Rh
dGljIGludCBpbXhfYXVkbWl4X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQog
CQkJbnAtPmZ1bGxfbmFtZSk7DQogCQlyZXR1cm4gLUVJTlZBTDsNCiAJfQ0KKwlwdXRfZGV2aWNl
KCZhdWRtaXhfcGRldi0+ZGV2KTsNCiANCiAJbnVtX2RhaSA9IG9mX2NvdW50X3BoYW5kbGVfd2l0
aF9hcmdzKGF1ZG1peF9ucCwgImRhaXMiLCBOVUxMKTsNCiAJaWYgKG51bV9kYWkgIT0gRlNMX0FV
RE1JWF9NQVhfREFJUykgew0KQEAgLTIxNiw2ICsyMTcsNyBAQCBzdGF0aWMgaW50IGlteF9hdWRt
aXhfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJCQlkZXZfZXJyKCZwZGV2
LT5kZXYsICJmYWlsZWQgdG8gZmluZCBTQUkgcGxhdGZvcm0gZGV2aWNlXG4iKTsNCiAJCQlyZXR1
cm4gLUVJTlZBTDsNCiAJCX0NCisJCXB1dF9kZXZpY2UoJmNwdV9wZGV2LT5kZXYpOw0KIA0KIAkJ
ZGFpX25hbWUgPSBkZXZtX2thc3ByaW50ZigmcGRldi0+ZGV2LCBHRlBfS0VSTkVMLCAiJXMlcyIs
DQogCQkJCQkgIGZlX25hbWVfcHJlZiwgYXJncy5ucC0+ZnVsbF9uYW1lICsgMSk7DQpAQCAtMjgw
LDYgKzI4Miw4IEBAIHN0YXRpYyBpbnQgaW14X2F1ZG1peF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KIAkJZGV2X2VycigmcGRldi0+ZGV2LCAiZmFpbGVkIHRvIGZpbmQgU0FJ
IHBsYXRmb3JtIGRldmljZVxuIik7DQogCQlyZXR1cm4gLUVJTlZBTDsNCiAJfQ0KKwlwdXRfZGV2
aWNlKCZjcHVfcGRldi0+ZGV2KTsNCisNCiAJcHJpdi0+Y3B1X21jbGsgPSBkZXZtX2Nsa19nZXQo
JmNwdV9wZGV2LT5kZXYsICJtY2xrMSIpOw0KIAlpZiAoSVNfRVJSKHByaXYtPmNwdV9tY2xrKSkg
ew0KIAkJcmV0ID0gUFRSX0VSUihwcml2LT5jcHVfbWNsayk7DQotLSANCjIuNy40DQoNCg==

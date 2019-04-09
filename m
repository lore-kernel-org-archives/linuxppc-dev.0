Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F44DC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 11:29:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF1720857
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 11:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OSNiQCGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF1720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dlSG0W5BzDqMT
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 21:29:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.6.51; helo=eur04-db3-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="OSNiQCGG"; 
 dkim-atps=neutral
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60051.outbound.protection.outlook.com [40.107.6.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dlQG72MbzDqJk
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 21:27:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CN2h3kDeze9CrlUJZ2HyX75qCHNNCF8VcNChwJhJM8=;
 b=OSNiQCGGIOHvnDhu2EOGaREzSJv2dA5tKL8ZubRnq4Iv24Aink61y+tLfcOPgCQ9Ld4Jpv9gQD0xk4H2pfPM5P2h/FavNbocW9oknbnIH+wKZVAxqKtXBL4W9Hec214Sk4ZU6qkjFCOPXBFbGuj/8ENcNZKVVHmNZJrtYc2G9lQ=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB5216.eurprd04.prod.outlook.com (20.177.51.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Tue, 9 Apr 2019 11:27:42 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888%3]) with mapi id 15.20.1792.009; Tue, 9 Apr 2019
 11:27:42 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Takashi Iwai <tiwai@suse.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Julia Lawall
 <Julia.Lawall@lip6.fr>
Subject: [PATCH v2 3/3] ASoC: imx-audmix: fix object reference leaks in probe
Thread-Topic: [PATCH v2 3/3] ASoC: imx-audmix: fix object reference leaks in
 probe
Thread-Index: AQHU7sc+9q6sLFqPvEazfy9Py2lM7g==
Date: Tue, 9 Apr 2019 11:27:42 +0000
Message-ID: <1554809242-27475-4-git-send-email-viorel.suman@nxp.com>
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
x-ms-office365-filtering-correlation-id: 98b606a0-705f-46a2-15c5-08d6bcde6131
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR04MB5216; 
x-ms-traffictypediagnostic: VI1PR04MB5216:
x-microsoft-antispam-prvs: <VI1PR04MB5216DE47F1358549609A82BC922D0@VI1PR04MB5216.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(366004)(396003)(346002)(39860400002)(376002)(189003)(199004)(386003)(6486002)(106356001)(5660300002)(6512007)(26005)(76176011)(44832011)(8936002)(7416002)(8676002)(81156014)(81166006)(3846002)(71190400001)(71200400001)(6506007)(105586002)(97736004)(86362001)(6116002)(68736007)(66066001)(102836004)(14454004)(99286004)(316002)(11346002)(2616005)(110136005)(486006)(478600001)(54906003)(256004)(36756003)(305945005)(7736002)(53936002)(476003)(4326008)(6436002)(446003)(2906002)(50226002)(25786009)(186003)(52116002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5216;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FWC/57vLScyCH9XwTHP4ash9QthHXueBXNaCJ8KwqwrPhdqLNyJuStOaDHNbc0EtaiDGSS78OKgpV6fNUDNXtncjmICfKvvN+Vof+krr7gnfxPgYX1kPsm3PtCvuKX/TM+jdMHWoiNuBJUZXIrtNRMAWesUjQ/hp+mOESPPP0VbOKoRyM/Pg64pOJErO87ewSRVGrJ8fGtJHYHj6twfumEmmgytBHz+JxOluO942h2E3ZHJVkSpm+3rfeCRgWGh3xcThzbnHjOlENfPu5JhQ9DL5WK93dzhNy/YfCDr6/G19V2tb0iTzPoG6q4SwkXRL3cG8KhBHslv9bdiJQyvunFk229Aq+iJZQGvxjhA5A6IRispFSeWm2TioKNR/7JpWnG28vH4GZfZ0qOfIqNDLzndY0fPG7BksrfMaLhKy7lg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b606a0-705f-46a2-15c5-08d6bcde6131
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 11:27:42.2755 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5216
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
dWxpYS5MYXdhbGxAbGlwNi5mcj4NCi0tLQ0KIHNvdW5kL3NvYy9mc2wvaW14LWF1ZG1peC5jIHwg
NCArKysrDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEv
c291bmQvc29jL2ZzbC9pbXgtYXVkbWl4LmMgYi9zb3VuZC9zb2MvZnNsL2lteC1hdWRtaXguYw0K
aW5kZXggNzk4M2JkMy4uOWFhZjNlNSAxMDA2NDQNCi0tLSBhL3NvdW5kL3NvYy9mc2wvaW14LWF1
ZG1peC5jDQorKysgYi9zb3VuZC9zb2MvZnNsL2lteC1hdWRtaXguYw0KQEAgLTE3MSw2ICsxNzEs
NyBAQCBzdGF0aWMgaW50IGlteF9hdWRtaXhfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCiAJCQlucC0+ZnVsbF9uYW1lKTsNCiAJCXJldHVybiAtRUlOVkFMOw0KIAl9DQorCXB1
dF9kZXZpY2UoJmF1ZG1peF9wZGV2LT5kZXYpOw0KIA0KIAludW1fZGFpID0gb2ZfY291bnRfcGhh
bmRsZV93aXRoX2FyZ3MoYXVkbWl4X25wLCAiZGFpcyIsIE5VTEwpOw0KIAlpZiAobnVtX2RhaSAh
PSBGU0xfQVVETUlYX01BWF9EQUlTKSB7DQpAQCAtMjE2LDYgKzIxNyw3IEBAIHN0YXRpYyBpbnQg
aW14X2F1ZG1peF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJCWRldl9l
cnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byBmaW5kIFNBSSBwbGF0Zm9ybSBkZXZpY2VcbiIpOw0K
IAkJCXJldHVybiAtRUlOVkFMOw0KIAkJfQ0KKwkJcHV0X2RldmljZSgmY3B1X3BkZXYtPmRldik7
DQogDQogCQlkYWlfbmFtZSA9IGRldm1fa2FzcHJpbnRmKCZwZGV2LT5kZXYsIEdGUF9LRVJORUws
ICIlcyVzIiwNCiAJCQkJCSAgZmVfbmFtZV9wcmVmLCBhcmdzLm5wLT5mdWxsX25hbWUgKyAxKTsN
CkBAIC0yODAsNiArMjgyLDggQEAgc3RhdGljIGludCBpbXhfYXVkbWl4X3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8g
ZmluZCBTQUkgcGxhdGZvcm0gZGV2aWNlXG4iKTsNCiAJCXJldHVybiAtRUlOVkFMOw0KIAl9DQor
CXB1dF9kZXZpY2UoJmNwdV9wZGV2LT5kZXYpOw0KKw0KIAlwcml2LT5jcHVfbWNsayA9IGRldm1f
Y2xrX2dldCgmY3B1X3BkZXYtPmRldiwgIm1jbGsxIik7DQogCWlmIChJU19FUlIocHJpdi0+Y3B1
X21jbGspKSB7DQogCQlyZXQgPSBQVFJfRVJSKHByaXYtPmNwdV9tY2xrKTsNCi0tIA0KMi43LjQN
Cg0K

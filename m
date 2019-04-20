Return-Path: <SRS0=K0D4=SW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C595C282DD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 16:03:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D879620651
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 16:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DgNxtboY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D879620651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44md0m5NrwzDqST
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 02:03:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.81; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=daniel.baluta@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="DgNxtboY"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00081.outbound.protection.outlook.com [40.107.0.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44mcwM5k03zDqJ2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Apr 2019 01:59:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+DHqJe3MiRmpX9U2CqCgij0+NicnYafvITYpGWCZhU=;
 b=DgNxtboYRYU8m0oqThvtsDOZ/pMb2tKwodEoG0eNrPy9lftB9AEBYwhy6YLSbdQvpTCMOKYBLQjryY6Mk4+Vb0TM22EoCb7B6ZqJzzIObUYvCW+TD+SRPM30kjZzdAypIkPFLZp0inR7EG/WWamZVzfkmtOjVPfdpv/BgMIU7+A=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2783.eurprd04.prod.outlook.com (10.172.255.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.11; Sat, 20 Apr 2019 15:59:04 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6%6]) with mapi id 15.20.1813.017; Sat, 20 Apr 2019
 15:59:04 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: fsl: sai: Add support for runtime pm
Thread-Topic: [PATCH 1/2] ASoC: fsl: sai: Add support for runtime pm
Thread-Index: AQHU95H6a78MC40khEqrtDvohSbOJA==
Date: Sat, 20 Apr 2019 15:59:04 +0000
Message-ID: <20190420155846.10027-2-daniel.baluta@nxp.com>
References: <20190420155846.10027-1-daniel.baluta@nxp.com>
In-Reply-To: <20190420155846.10027-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VE1PR03CA0042.eurprd03.prod.outlook.com
 (2603:10a6:803:118::31) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab641505-7ff8-4560-e205-08d6c5a91ca8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR0402MB2783; 
x-ms-traffictypediagnostic: VI1PR0402MB2783:
x-microsoft-antispam-prvs: <VI1PR0402MB27836AEFC3C4C5F4D42EFC6FF9200@VI1PR0402MB2783.eurprd04.prod.outlook.com>
x-forefront-prvs: 0013079544
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(396003)(376002)(39860400002)(136003)(366004)(23433003)(199004)(189003)(54906003)(99286004)(11346002)(73956011)(68736007)(7736002)(5640700003)(6116002)(3846002)(6512007)(305945005)(2906002)(2351001)(102836004)(446003)(386003)(6506007)(53936002)(2616005)(76176011)(186003)(486006)(52116002)(26005)(476003)(71200400001)(97736004)(5660300002)(6436002)(66556008)(2501003)(66066001)(14444005)(256004)(44832011)(66946007)(64756008)(36756003)(71190400001)(81156014)(81166006)(8676002)(316002)(66476007)(478600001)(1730700003)(6916009)(1076003)(14454004)(8936002)(86362001)(25786009)(66446008)(7416002)(4326008)(6486002)(50226002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2783;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BTIREBEISR4tUxV2M9tOUAK5W5RmmFoxWeH0s6a5wirqBEFQnhO2Moz2QHJ7njpsrO43EGmupuAwxXdMJNb2j4toKmrXuXLmkaz+M/c+k4e3zm4oD3MDQxItwiw5eO+TwCaqFljzxLyA9xgpGvJ5hIoOFOQGFtIzehBuJX/+QBFyb/y7J+WQVZqHW56hJmbk3bdwX/jns0yxBs6Cz3bc/HUKc9WKOQ0xWNzgxuoMnFscbeMEQQWm+i2exgTjuF3k68d2Fv/WdKlysUcxkGHChaSGLJbfIGmfoaw8MiAPJ0eJAC/xWDzVyyZKBett2oRXg+kmOpfLpETmg45tB9bbORJicypZojaXT0XSEU/fsV0lecsxclDJNGEPoSUKSOFMIS6J5wzV9XzrtHDQLoM9kZJRF5KAXOe02Iu2+JFBg9M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab641505-7ff8-4560-e205-08d6c5a91ca8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2019 15:59:04.4071 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2783
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
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 dl-linux-imx <linux-imx@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

QmFzaWNhbGx5IHRoZSBzYW1lIGFjdGlvbnMgYXMgZm9yIHN5c3RlbSBQTSwgc28gbWFrZSB1c2UN
Cm9mIHBtX3J1bnRpbWVfZm9yY2Vfc3VzcGVuZC9wbV9ydW50aW1lX2ZvcmNlX3Jlc3VtZS4NCg0K
U2lnbmVkLW9mZi1ieTogU2hlbmdqaXUgV2FuZyA8c2hlbmdqaXUud2FuZ0BueHAuY29tPg0KU2ln
bmVkLW9mZi1ieTogRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPg0KLS0tDQog
c291bmQvc29jL2ZzbC9mc2xfc2FpLmMgfCAxNiArKysrKysrKysrKy0tLS0tDQogMSBmaWxlIGNo
YW5nZWQsIDExIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9z
b3VuZC9zb2MvZnNsL2ZzbF9zYWkuYyBiL3NvdW5kL3NvYy9mc2wvZnNsX3NhaS5jDQppbmRleCBi
NTYzMDA0ZmI4OWYuLmFlZWIwN2I3NDE3NyAxMDA2NDQNCi0tLSBhL3NvdW5kL3NvYy9mc2wvZnNs
X3NhaS5jDQorKysgYi9zb3VuZC9zb2MvZnNsL2ZzbF9zYWkuYw0KQEAgLTksNiArOSw3IEBADQog
I2luY2x1ZGUgPGxpbnV4L2RtYWVuZ2luZS5oPg0KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4N
CiAjaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVzcy5oPg0KKyNpbmNsdWRlIDxsaW51eC9wbV9ydW50
aW1lLmg+DQogI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5oPg0KICNpbmNsdWRlIDxsaW51eC9zbGFi
Lmg+DQogI2luY2x1ZGUgPGxpbnV4L3RpbWUuaD4NCkBAIC04OTgsNiArODk5LDggQEAgc3RhdGlj
IGludCBmc2xfc2FpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogDQogCXBs
YXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIHNhaSk7DQogDQorCXBtX3J1bnRpbWVfZW5hYmxlKCZw
ZGV2LT5kZXYpOw0KKw0KIAlyZXQgPSBkZXZtX3NuZF9zb2NfcmVnaXN0ZXJfY29tcG9uZW50KCZw
ZGV2LT5kZXYsICZmc2xfY29tcG9uZW50LA0KIAkJCSZmc2xfc2FpX2RhaSwgMSk7DQogCWlmIChy
ZXQpDQpAQCAtOTE3LDggKzkyMCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lk
IGZzbF9zYWlfaWRzW10gPSB7DQogfTsNCiBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBmc2xfc2Fp
X2lkcyk7DQogDQotI2lmZGVmIENPTkZJR19QTV9TTEVFUA0KLXN0YXRpYyBpbnQgZnNsX3NhaV9z
dXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCisjaWZkZWYgQ09ORklHX1BNDQorc3RhdGljIGlu
dCBmc2xfc2FpX3J1bnRpbWVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQogew0KIAlzdHJ1
Y3QgZnNsX3NhaSAqc2FpID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQogDQpAQCAtOTI4LDcgKzkz
MSw3IEBAIHN0YXRpYyBpbnQgZnNsX3NhaV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCiAJ
cmV0dXJuIDA7DQogfQ0KIA0KLXN0YXRpYyBpbnQgZnNsX3NhaV9yZXN1bWUoc3RydWN0IGRldmlj
ZSAqZGV2KQ0KK3N0YXRpYyBpbnQgZnNsX3NhaV9ydW50aW1lX3Jlc3VtZShzdHJ1Y3QgZGV2aWNl
ICpkZXYpDQogew0KIAlzdHJ1Y3QgZnNsX3NhaSAqc2FpID0gZGV2X2dldF9kcnZkYXRhKGRldik7
DQogDQpAQCAtOTQwLDEwICs5NDMsMTMgQEAgc3RhdGljIGludCBmc2xfc2FpX3Jlc3VtZShzdHJ1
Y3QgZGV2aWNlICpkZXYpDQogCXJlZ21hcF93cml0ZShzYWktPnJlZ21hcCwgRlNMX1NBSV9SQ1NS
LCAwKTsNCiAJcmV0dXJuIHJlZ2NhY2hlX3N5bmMoc2FpLT5yZWdtYXApOw0KIH0NCi0jZW5kaWYg
LyogQ09ORklHX1BNX1NMRUVQICovDQorI2VuZGlmIC8qIENPTkZJR19QTSAqLw0KIA0KIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBmc2xfc2FpX3BtX29wcyA9IHsNCi0JU0VUX1NZU1RF
TV9TTEVFUF9QTV9PUFMoZnNsX3NhaV9zdXNwZW5kLCBmc2xfc2FpX3Jlc3VtZSkNCisJU0VUX1JV
TlRJTUVfUE1fT1BTKGZzbF9zYWlfcnVudGltZV9zdXNwZW5kLA0KKwkJCSAgIGZzbF9zYWlfcnVu
dGltZV9yZXN1bWUsIE5VTEwpDQorCVNFVF9TWVNURU1fU0xFRVBfUE1fT1BTKHBtX3J1bnRpbWVf
Zm9yY2Vfc3VzcGVuZCwNCisJCQkJcG1fcnVudGltZV9mb3JjZV9yZXN1bWUpDQogfTsNCiANCiBz
dGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBmc2xfc2FpX2RyaXZlciA9IHsNCi0tIA0KMi4x
Ny4xDQoNCg==

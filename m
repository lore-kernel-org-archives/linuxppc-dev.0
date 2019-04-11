Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1661EC10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 09:42:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824E32084D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 09:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ekcg+unx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824E32084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fwzy14blzDqQJ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 19:42:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.8.70; helo=eur04-vi1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="Ekcg+unx"; 
 dkim-atps=neutral
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80070.outbound.protection.outlook.com [40.107.8.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fww20X2WzDqPS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 19:39:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/ZEuF4NtMLE4WQ0iZHgZeV/Kk2ouMUetAw4cIRRmSo=;
 b=Ekcg+unxzPz/F0OBnpdEasIYHY89I3207fpfxqxgprfhkfpxrRKsmn7vt987s4ekWrDZ1+6skM5ggPhDV7HWAIcB7XPNJbkisz8MoL6TMJYZnOPPXRa2URDEXUbQzKVwp1rUT3jiYgnTLpheRPcPIZUnNCBeKo7CdLgGCFgajVU=
Received: from AM0PR04MB6468.eurprd04.prod.outlook.com (20.179.253.81) by
 AM0PR04MB5492.eurprd04.prod.outlook.com (20.178.115.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Thu, 11 Apr 2019 09:39:06 +0000
Received: from AM0PR04MB6468.eurprd04.prod.outlook.com
 ([fe80::107:1bdc:981e:e292]) by AM0PR04MB6468.eurprd04.prod.outlook.com
 ([fe80::107:1bdc:981e:e292%4]) with mapi id 15.20.1792.009; Thu, 11 Apr 2019
 09:39:06 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH V2 1/2] ASoC: fsl_asrc: replace the process_option table with
 function
Thread-Topic: [PATCH V2 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Thread-Index: AQHU8EpnMj7ynpC4/EOtw74lVQaA/A==
Date: Thu, 11 Apr 2019 09:39:06 +0000
Message-ID: <a04859bff36ba26cb4cb51ff092a3f2e2eca455d.1554975348.git.shengjiu.wang@nxp.com>
References: <cover.1554975348.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1554975348.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK2PR02CA0160.apcprd02.prod.outlook.com
 (2603:1096:201:1f::20) To AM0PR04MB6468.eurprd04.prod.outlook.com
 (2603:10a6:208:16e::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fced1889-ff37-46c6-374a-08d6be618a0e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:AM0PR04MB5492; 
x-ms-traffictypediagnostic: AM0PR04MB5492:
x-microsoft-antispam-prvs: <AM0PR04MB549280E2D396257EDCC0C7ECE32F0@AM0PR04MB5492.eurprd04.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(366004)(376002)(39860400002)(396003)(189003)(199004)(52116002)(50226002)(36756003)(8936002)(2616005)(106356001)(476003)(6512007)(71190400001)(446003)(486006)(11346002)(66066001)(81166006)(81156014)(8676002)(118296001)(105586002)(14444005)(256004)(2201001)(68736007)(5660300002)(97736004)(6436002)(54906003)(14454004)(110136005)(6486002)(2906002)(86362001)(6116002)(3846002)(316002)(7736002)(305945005)(508600001)(2501003)(25786009)(102836004)(71200400001)(99286004)(186003)(26005)(76176011)(53936002)(386003)(4326008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5492;
 H:AM0PR04MB6468.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: l/j20L6f9M2d7NQR08UsZShDko+IKdsMzIuB5FZLePNGsJK+3/rlQoi8vGe3AUnYdxgwH014GgkRVzoWE+T6fIEaQGpq4rVtUQecsCQVbPmD/0QU/KmC0au3jD0ZMCQL1fN5mMZd+365Zvz5ijZ7dZKbuR+iTsCXIxnMRt/bKrQ7OAjAigsZpQrNQ0tDQ3jDdrwXEAAjPd9FbZjY9zdGubeCcCooomGFNMX7o4uE5jaN8bN7+AL2EszOHtEpqcLO1Q3D/UoUPlNpQpcxZYyUSaYLQWhlHwwMsA4YTRMgpmtyy8siXSnEUXQjVbweiHHW65uWd7qENZIJNNao6QMjyPpHhxvF0GyNHSaUcsd1hJewpsx6VSvAEAS7+ihP98fpzoG9g7cB2A0m2pvpep9ugW7flxjbJML8/FKTmJxdpHc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fced1889-ff37-46c6-374a-08d6be618a0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 09:39:06.0909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5492
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

V2hlbiB3ZSB3YW50IHRvIHN1cHBvcnQgbW9yZSBzYW1wbGUgcmF0ZSwgZm9yIGV4YW1wbGUgMTJr
SHovMjRrSHoNCndlIG5lZWQgdXBkYXRlIHRoZSBwcm9jZXNzX29wdGlvbiB0YWJsZSwgaWYgd2Ug
d2FudCB0byBzdXBwb3J0IG1vcmUNCnNhbXBsZSByYXRlIG5leHQgdGltZSwgdGhlIHRhYmxlIG5l
ZWQgdG8gYmUgdXBkYXRlZCBhZ2Fpbi4gd2hpY2gNCmlzIG5vdCBmbGV4aWJsZS4NCg0KV2UgZ290
IGEgZnVuY3Rpb24gZnNsX2FzcmNfc2VsX3Byb2MgdG8gcmVwbGFjZSB0aGUgdGFibGUsIHdoaWNo
IGNhbg0KZ2l2ZSB0aGUgcHJlLXByb2Nlc3NpbmcgYW5kIHBvc3QtcHJvY2Vzc2luZyBvcHRpb25z
IGFjY29yZGluZyB0bw0KdGhlIHNhbXBsZSByYXRlLg0KDQpTaWduZWQtb2ZmLWJ5OiBTaGVuZ2pp
dSBXYW5nIDxzaGVuZ2ppdS53YW5nQG54cC5jb20+DQotLS0NCiBzb3VuZC9zb2MvZnNsL2ZzbF9h
c3JjLmMgfCA4NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0NCiAxIGZpbGUgY2hhbmdlZCwgNjcgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvZnNsL2ZzbF9hc3JjLmMgYi9zb3VuZC9zb2MvZnNsL2Zz
bF9hc3JjLmMNCmluZGV4IDBiOTM3OTI0ZDJlNC4uNTg1N2QzODNkOTYyIDEwMDY0NA0KLS0tIGEv
c291bmQvc29jL2ZzbC9mc2xfYXNyYy5jDQorKysgYi9zb3VuZC9zb2MvZnNsL2ZzbF9hc3JjLmMN
CkBAIC0yNiwyNCArMjYsNiBAQA0KICNkZWZpbmUgcGFpcl9kYmcoZm10LCAuLi4pIFwNCiAJZGV2
X2RiZygmYXNyY19wcml2LT5wZGV2LT5kZXYsICJQYWlyICVjOiAiIGZtdCwgJ0EnICsgaW5kZXgs
ICMjX19WQV9BUkdTX18pDQogDQotLyogU2FtcGxlIHJhdGVzIGFyZSBhbGlnbmVkIHdpdGggdGhh
dCBkZWZpbmVkIGluIHBjbS5oIGZpbGUgKi8NCi1zdGF0aWMgY29uc3QgdTggcHJvY2Vzc19vcHRp
b25bXVsxMl1bMl0gPSB7DQotCS8qIDhrSHogMTEuMDI1a0h6IDE2a0h6IDIyLjA1a0h6IDMya0h6
IDQ0LjFrSHogNDhrSHogICA2NGtIeiAgIDg4LjJrSHogOTZrSHogICAxNzZrSHogIDE5MmtIeiAq
Lw0KLQl7ezAsIDF9LCB7MCwgMX0sIHswLCAxfSwgezAsIDB9LCB7MCwgMH0sIHswLCAwfSwgezAs
IDB9LCB7MCwgMH0sIHswLCAwfSwgezAsIDB9LCB7MCwgMH0sIHswLCAwfSx9LAkvKiA1NTEySHog
Ki8NCi0Je3swLCAxfSwgezAsIDF9LCB7MCwgMX0sIHswLCAxfSwgezAsIDB9LCB7MCwgMH0sIHsw
LCAwfSwgezAsIDB9LCB7MCwgMH0sIHswLCAwfSwgezAsIDB9LCB7MCwgMH0sfSwJLyogOGtIeiAq
Lw0KLQl7ezAsIDJ9LCB7MCwgMX0sIHswLCAxfSwgezAsIDF9LCB7MCwgMH0sIHswLCAwfSwgezAs
IDB9LCB7MCwgMH0sIHswLCAwfSwgezAsIDB9LCB7MCwgMH0sIHswLCAwfSx9LAkvKiAxMTAyNUh6
ICovDQotCXt7MSwgMn0sIHswLCAyfSwgezAsIDF9LCB7MCwgMX0sIHswLCAxfSwgezAsIDF9LCB7
MCwgMX0sIHswLCAwfSwgezAsIDB9LCB7MCwgMH0sIHswLCAwfSwgezAsIDB9LH0sCS8qIDE2a0h6
ICovDQotCXt7MSwgMn0sIHsxLCAyfSwgezAsIDJ9LCB7MCwgMX0sIHswLCAxfSwgezAsIDF9LCB7
MCwgMX0sIHswLCAwfSwgezAsIDB9LCB7MCwgMH0sIHswLCAwfSwgezAsIDB9LH0sCS8qIDIyMDUw
SHogKi8NCi0Je3sxLCAyfSwgezIsIDF9LCB7MiwgMX0sIHswLCAyfSwgezAsIDF9LCB7MCwgMX0s
IHswLCAxfSwgezAsIDF9LCB7MCwgMX0sIHswLCAwfSwgezAsIDB9LCB7MCwgMH0sfSwJLyogMzJr
SHogKi8NCi0Je3syLCAyfSwgezIsIDJ9LCB7MiwgMX0sIHsyLCAxfSwgezAsIDJ9LCB7MCwgMX0s
IHswLCAxfSwgezAsIDF9LCB7MCwgMX0sIHswLCAxfSwgezAsIDB9LCB7MCwgMH0sfSwJLyogNDQu
MWtIeiAqLw0KLQl7ezIsIDJ9LCB7MiwgMn0sIHsyLCAxfSwgezIsIDF9LCB7MCwgMn0sIHswLCAy
fSwgezAsIDF9LCB7MCwgMX0sIHswLCAxfSwgezAsIDF9LCB7MCwgMH0sIHswLCAwfSx9LAkvKiA0
OGtIeiAqLw0KLQl7ezIsIDJ9LCB7MiwgMn0sIHsyLCAyfSwgezIsIDF9LCB7MSwgMn0sIHswLCAy
fSwgezAsIDJ9LCB7MCwgMX0sIHswLCAxfSwgezAsIDF9LCB7MCwgMX0sIHswLCAwfSx9LAkvKiA2
NGtIeiAqLw0KLQl7ezIsIDJ9LCB7MiwgMn0sIHsyLCAyfSwgezIsIDJ9LCB7MSwgMn0sIHsxLCAy
fSwgezEsIDJ9LCB7MSwgMX0sIHsxLCAxfSwgezEsIDF9LCB7MSwgMX0sIHsxLCAxfSx9LAkvKiA4
OC4ya0h6ICovDQotCXt7MiwgMn0sIHsyLCAyfSwgezIsIDJ9LCB7MiwgMn0sIHsxLCAyfSwgezEs
IDJ9LCB7MSwgMn0sIHsxLCAxfSwgezEsIDF9LCB7MSwgMX0sIHsxLCAxfSwgezEsIDF9LH0sCS8q
IDk2a0h6ICovDQotCXt7MiwgMn0sIHsyLCAyfSwgezIsIDJ9LCB7MiwgMn0sIHsyLCAyfSwgezIs
IDJ9LCB7MiwgMn0sIHsyLCAxfSwgezIsIDF9LCB7MiwgMX0sIHsyLCAxfSwgezIsIDF9LH0sCS8q
IDE3NmtIeiAqLw0KLQl7ezIsIDJ9LCB7MiwgMn0sIHsyLCAyfSwgezIsIDJ9LCB7MiwgMn0sIHsy
LCAyfSwgezIsIDJ9LCB7MiwgMX0sIHsyLCAxfSwgezIsIDF9LCB7MiwgMX0sIHsyLCAxfSx9LAkv
KiAxOTJrSHogKi8NCi19Ow0KLQ0KIC8qIENvcnJlc3BvbmRpbmcgdG8gcHJvY2Vzc19vcHRpb24g
Ki8NCiBzdGF0aWMgaW50IHN1cHBvcnRlZF9pbnB1dF9yYXRlW10gPSB7DQogCTU1MTIsIDgwMDAs
IDExMDI1LCAxNjAwMCwgMjIwNTAsIDMyMDAwLCA0NDEwMCwgNDgwMDAsIDY0MDAwLCA4ODIwMCwN
CkBAIC03OSw2ICs2MSw2MyBAQA0KIA0KIHN0YXRpYyB1bnNpZ25lZCBjaGFyICpjbGtfbWFwWzJd
Ow0KIA0KKy8qDQorICogU2VsZWN0IHRoZSBwcmUtcHJvY2Vzc2luZyBhbmQgcG9zdC1wcm9jZXNz
aW5nIG9wdGlvbnMNCisgKg0KKyAqIEZzaW46IGlucHV0IHNhbXBsZSByYXRlDQorICogRnNvdXQ6
IG91dHB1dCBzYW1wbGUgcmF0ZQ0KKyAqIHByZV9wcm9jOiByZXR1cm4gdmFsdWUgZm9yIHByZS1w
cm9jZXNzaW5nIG9wdGlvbg0KKyAqIHBvc3RfcHJvYzogcmV0dXJuIHZhbHVlIGZvciBwb3N0LXBy
b2Nlc3Npbmcgb3B0aW9uDQorICovDQorc3RhdGljIGludCBmc2xfYXNyY19zZWxfcHJvYyhpbnQg
RnNpbiwgaW50IEZzb3V0LCBpbnQgKnByZV9wcm9jLCBpbnQgKnBvc3RfcHJvYykNCit7DQorCWJv
b2wgZGV0X291dF9vcDJfY29uZDsNCisJYm9vbCBkZXRfb3V0X29wMF9jb25kOw0KKw0KKwkvKiBD
b2RpdGlvbiBmb3Igc2VsZWN0aW9uIG9mIHBvc3QtcHJvY2Vzc2luZyAqLw0KKwlkZXRfb3V0X29w
Ml9jb25kID0gKCgoRnNpbiAqIDE1ID4gRnNvdXQgKiAxNikgJiAoRnNvdXQgPCA1NjAwMCkpIHwN
CisJCQkJCSgoRnNpbiA+IDU2MDAwKSAmIChGc291dCA8IDU2MDAwKSkpOw0KKwlkZXRfb3V0X29w
MF9jb25kID0gKEZzaW4gKiAyMyA8IEZzb3V0ICogOCk7DQorDQorCS8qDQorCSAqIHVuc3VwcG9y
dGVkIGNhc2U6IFRzb3V0PjE2LjEyNSpUc2luLCBhbmQgVHNvdXQ+OC4xMjUqVHNpbi4NCisJICog
VHNvdXQ+MTYuMTI1KlRzaW4gLT4gRnNpbiAqIDggPiAxMjkgKiBGc291dA0KKwkgKiBUc291dD44
LjEyNSpUc2luICAtPiBGc2luICogOCA+IDY1ICogRnNvdXQNCisJICogVHNvdXQ+NC4xMjUqVHNp
biAgLT4gRnNpbiAqIDggPiAzMyAqIEZzb3V0DQorCSAqIFRzb3V0PjEuODc1KlRzaW4gIC0+IEZz
aW4gKiA4ID4gMTUgKiBGc291dA0KKwkgKi8NCisJaWYgKEZzaW4gKiA4ID4gMTI5ICogRnNvdXQp
DQorCQkqcHJlX3Byb2MgPSA1Ow0KKwllbHNlIGlmIChGc2luICogOCA+IDY1ICogRnNvdXQpDQor
CQkqcHJlX3Byb2MgPSA0Ow0KKwllbHNlIGlmIChGc2luICogOCA+IDMzICogRnNvdXQpDQorCQkq
cHJlX3Byb2MgPSAyOw0KKwllbHNlIGlmIChGc2luICogOCA+IDE1ICogRnNvdXQpIHsNCisJCWlm
IChGc2luID4gMTUyMDAwKQ0KKwkJCSpwcmVfcHJvYyA9IDI7DQorCQllbHNlDQorCQkJKnByZV9w
cm9jID0gMTsNCisJfSBlbHNlIGlmIChGc2luIDwgNzYwMDApDQorCQkqcHJlX3Byb2MgPSAwOw0K
KwllbHNlIGlmIChGc2luID4gMTUyMDAwKQ0KKwkJKnByZV9wcm9jID0gMjsNCisJZWxzZQ0KKwkJ
KnByZV9wcm9jID0gMTsNCisNCisJaWYgKGRldF9vdXRfb3AyX2NvbmQpDQorCQkqcG9zdF9wcm9j
ID0gMjsNCisJZWxzZSBpZiAoZGV0X291dF9vcDBfY29uZCkNCisJCSpwb3N0X3Byb2MgPSAwOw0K
KwllbHNlDQorCQkqcG9zdF9wcm9jID0gMTsNCisNCisJLyogdW5zdXBwb3J0ZWQgb3B0aW9ucyAq
Lw0KKwlpZiAoKnByZV9wcm9jID09IDQgfHwgKnByZV9wcm9jID09IDUpDQorCQlyZXR1cm4gLUVJ
TlZBTDsNCisNCisJcmV0dXJuIDA7DQorfQ0KKw0KIC8qKg0KICAqIFJlcXVlc3QgQVNSQyBwYWly
DQogICoNCkBAIC0yMzksOCArMjc4LDEwIEBAIHN0YXRpYyBpbnQgZnNsX2FzcmNfY29uZmlnX3Bh
aXIoc3RydWN0IGZzbF9hc3JjX3BhaXIgKnBhaXIpDQogCXUzMiBpbnJhdGUsIG91dHJhdGUsIGlu
ZGl2LCBvdXRkaXY7DQogCXUzMiBjbGtfaW5kZXhbMl0sIGRpdlsyXTsNCiAJaW50IGluLCBvdXQs
IGNoYW5uZWxzOw0KKwlpbnQgcHJlX3Byb2MsIHBvc3RfcHJvYzsNCiAJc3RydWN0IGNsayAqY2xr
Ow0KIAlib29sIGlkZWFsOw0KKwlpbnQgcmV0Ow0KIA0KIAlpZiAoIWNvbmZpZykgew0KIAkJcGFp
cl9lcnIoImludmFsaWQgcGFpciBjb25maWdcbiIpOw0KQEAgLTI4OSw2ICszMzAsMTIgQEAgc3Rh
dGljIGludCBmc2xfYXNyY19jb25maWdfcGFpcihzdHJ1Y3QgZnNsX2FzcmNfcGFpciAqcGFpcikN
CiAJCXJldHVybiAtRUlOVkFMOw0KIAl9DQogDQorCXJldCA9IGZzbF9hc3JjX3NlbF9wcm9jKGlu
cmF0ZSwgb3V0cmF0ZSwgJnByZV9wcm9jLCAmcG9zdF9wcm9jKTsNCisJaWYgKHJldCkgew0KKwkJ
cGFpcl9lcnIoIk5vIHN1cHBvcnRlZCBwcmUtcHJvY2Vzc2luZyBvcHRpb25zXG4iKTsNCisJCXJl
dHVybiByZXQ7DQorCX0NCisNCiAJLyogVmFsaWRhdGUgaW5wdXQgYW5kIG91dHB1dCBjbG9jayBz
b3VyY2VzICovDQogCWNsa19pbmRleFtJTl0gPSBjbGtfbWFwW0lOXVtjb25maWctPmluY2xrXTsN
CiAJY2xrX2luZGV4W09VVF0gPSBjbGtfbWFwW09VVF1bY29uZmlnLT5vdXRjbGtdOw0KQEAgLTM4
MCw4ICs0MjcsOCBAQCBzdGF0aWMgaW50IGZzbF9hc3JjX2NvbmZpZ19wYWlyKHN0cnVjdCBmc2xf
YXNyY19wYWlyICpwYWlyKQ0KIAkvKiBBcHBseSBjb25maWd1cmF0aW9ucyBmb3IgcHJlLSBhbmQg
cG9zdC1wcm9jZXNzaW5nICovDQogCXJlZ21hcF91cGRhdGVfYml0cyhhc3JjX3ByaXYtPnJlZ21h
cCwgUkVHX0FTUkNGRywNCiAJCQkgICBBU1JDRkdfUFJFTU9EaV9NQVNLKGluZGV4KSB8CUFTUkNG
R19QT1NUTU9EaV9NQVNLKGluZGV4KSwNCi0JCQkgICBBU1JDRkdfUFJFTU9EKGluZGV4LCBwcm9j
ZXNzX29wdGlvbltpbl1bb3V0XVswXSkgfA0KLQkJCSAgIEFTUkNGR19QT1NUTU9EKGluZGV4LCBw
cm9jZXNzX29wdGlvbltpbl1bb3V0XVsxXSkpOw0KKwkJCSAgIEFTUkNGR19QUkVNT0QoaW5kZXgs
IHByZV9wcm9jKSB8DQorCQkJICAgQVNSQ0ZHX1BPU1RNT0QoaW5kZXgsIHBvc3RfcHJvYykpOw0K
IA0KIAlyZXR1cm4gZnNsX2FzcmNfc2V0X2lkZWFsX3JhdGlvKHBhaXIsIGlucmF0ZSwgb3V0cmF0
ZSk7DQogfQ0KLS0gDQoxLjkuMQ0KDQo=

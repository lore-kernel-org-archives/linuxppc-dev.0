Return-Path: <SRS0=K0D4=SW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38164C282DD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 15:42:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D81F20850
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 15:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OCqsQJ6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D81F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44mcYJ5FYnzDqTV
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 01:42:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.8.49; helo=eur04-vi1-obe.outbound.protection.outlook.com;
 envelope-from=daniel.baluta@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="OCqsQJ6U"; 
 dkim-atps=neutral
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80049.outbound.protection.outlook.com [40.107.8.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44mcWZ5zx1zDqRv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Apr 2019 01:41:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBOqawfWzwu9DA2f0QOXFIfS0ma+Ue6OGErbNsBWkyc=;
 b=OCqsQJ6UqSMRfr0axHjP4AHY7HLC2lePk6yDA3jaOICL/Py2YB6PHhLkoizHuFb6safv9sjJSjjny0t7fa3+n3strMFZnWB7rCVIlBaSGEL6oTUjSZKg5g0b+fjWVW9dDbiMu0xyJWXyGmtLFSIoav39leThrdsvxArA6lWz1xg=
Received: from AM6PR0402MB3350.eurprd04.prod.outlook.com (52.133.21.17) by
 AM6PR0402MB3637.eurprd04.prod.outlook.com (52.133.28.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.11; Sat, 20 Apr 2019 15:41:04 +0000
Received: from AM6PR0402MB3350.eurprd04.prod.outlook.com
 ([fe80::f504:a635:91b3:1e7a]) by AM6PR0402MB3350.eurprd04.prod.outlook.com
 ([fe80::f504:a635:91b3:1e7a%3]) with mapi id 15.20.1813.013; Sat, 20 Apr 2019
 15:41:04 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Subject: [PATCH] ASoC: fsl: sai: Fix clock source for mclk0
Thread-Topic: [PATCH] ASoC: fsl: sai: Fix clock source for mclk0
Thread-Index: AQHU9492jGEFcTdxIEKDGilr5DVCtg==
Date: Sat, 20 Apr 2019 15:41:04 +0000
Message-ID: <20190420154038.14576-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0302CA0017.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::27) To AM6PR0402MB3350.eurprd04.prod.outlook.com
 (2603:10a6:209:a::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef57aa59-3319-49a1-b0f0-08d6c5a69904
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:AM6PR0402MB3637; 
x-ms-traffictypediagnostic: AM6PR0402MB3637:
x-microsoft-antispam-prvs: <AM6PR0402MB36378177A56288FFCC4EBC25F9200@AM6PR0402MB3637.eurprd04.prod.outlook.com>
x-forefront-prvs: 0013079544
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(396003)(346002)(39860400002)(136003)(189003)(199004)(4326008)(68736007)(6512007)(66066001)(256004)(316002)(99286004)(5640700003)(66946007)(386003)(6506007)(8936002)(66476007)(54906003)(66446008)(66556008)(64756008)(73956011)(102836004)(81166006)(50226002)(81156014)(97736004)(86362001)(1730700003)(6436002)(53936002)(52116002)(71200400001)(71190400001)(2501003)(6486002)(44832011)(486006)(476003)(8676002)(2616005)(305945005)(25786009)(7736002)(6916009)(7416002)(14454004)(26005)(1076003)(186003)(2906002)(5660300002)(478600001)(36756003)(3846002)(6116002)(2351001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0402MB3637;
 H:AM6PR0402MB3350.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gaG9t009IqWlJXIoYqkxU9x8TGG+z5eFsrqUbdeq3p5g1KC/Hw83aXDpymROqKs41fVLLPnrG4Osf6Tys6k7RSiRX8aCZkWNEKk6nzC++cOJ4/sqBsQd+PswRugkGecNBn0VrRSh4zVz/oKpY5tOPhw/QdAYg9j99O/Jgxj/tuYXThb0+IwiiaHKldM0BwK66j3oaOcmHcVdkVUyJmMfVpNN6PIMX6DU0/UbXYGqeK+6dFToHS8BYV76ZCj3kT82C7MhjpPoRpYTyRUf/Uuwn8ZiQs30e8P9DqtPmILlKJkSo5QAVW4CUhWO+LxTLtuhxaN35qtty4aBsoswuMeAAL45qTwSA+FfhxojiN78dXI517GSVYFgYqXFPG3s2+XcOtiJ7VpBGSB9wV3TgkNQyMykV/kn9Posp5s7OI6/16Q=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef57aa59-3319-49a1-b0f0-08d6c5a69904
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2019 15:41:04.5220 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3637
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

U0FJIHByb3ZpZGUgbXVsdGlwbGUgbWFzdGVyIGNsb2NrIHNvdXJjZSBvcHRpb25zIHNlbGVjdGFi
bGUNCnZpYSBiaXQgTVNFTCBvZiBUQ1IyL1JDUjIuDQoNCkFsbCBwb3NzaWJsZSBtYXN0ZXIgY2xv
Y2sgc291cmNlcyBhcmUgc3RvcmVkIGluIHNhaS0+bWNsa19jbGsNCmFycmF5LiBDdXJyZW50IGlt
cGxlbWVudGF0aW9uIGFzc3VtZXMgdGhhdCBNQ0xLMCBzb3VyY2UgaXMgYWx3YXlzDQpidXNjbGss
IGJ1dCB0aGlzIGlzIHdyb25nIQ0KDQpGb3IgZXhhbXBsZSwgb24gaS5NWDhRTSB3ZSBoYXZlOg0K
DQowMGIgLSBCdXMgQ2xvY2sgc2VsZWN0ZWQuDQowMWIgLSBNYXN0ZXIgQ2xvY2sgKE1DTEspIDEg
b3B0aW9uIHNlbGVjdGVkLg0KMTBiIC0gTWFzdGVyIENsb2NrIChNQ0xLKSAyIG9wdGlvbiBzZWxl
Y3RlZC4NCjExYiAtIE1hc3RlciBDbG9jayAoTUNMSykgMyBvcHRpb24gc2VsZWN0ZWQuDQoNCndo
aWxlIG9uIGkuTVg2U1ggd2UgaGF2ZToNCg0KMDBiIC0gTWFzdGVyIENsb2NrIChNQ0xLKSAxIG9w
dGlvbiBzZWxlY3RlZC4NCjAxYiAtIE1hc3RlciBDbG9jayAoTUNMSykgMSBvcHRpb24gc2VsZWN0
ZWQuDQoxMGIgLSBNYXN0ZXIgQ2xvY2sgKE1DTEspIDIgb3B0aW9uIHNlbGVjdGVkLg0KMTFiIC0g
TWFzdGVyIENsb2NrIChNQ0xLKSAzIG9wdGlvbiBzZWxlY3RlZC4NCg0KU28sIHRoaXMgcGF0Y2gg
d2lsbCByZWFkIG1jbGswIHNvdXJjZSBjbG9jayBmcm9tIGRldmljZSB0cmVlLg0KDQpTaWduZWQt
b2ZmLWJ5OiBTaGVuZ2ppdSBXYW5nIDxzaGVuZ2ppdS53YW5nQG54cC5jb20+DQpTaWduZWQtb2Zm
LWJ5OiBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFsdXRhQG54cC5jb20+DQotLS0NCiBzb3VuZC9z
b2MvZnNsL2ZzbF9zYWkuYyB8IDMgKy0tDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvc291bmQvc29jL2ZzbC9mc2xfc2FpLmMg
Yi9zb3VuZC9zb2MvZnNsL2ZzbF9zYWkuYw0KaW5kZXggZDJhNGRjNzQ0ZmQ3Li5mYWE4ZGU4N2Zm
ODMgMTAwNjQ0DQotLS0gYS9zb3VuZC9zb2MvZnNsL2ZzbF9zYWkuYw0KKysrIGIvc291bmQvc29j
L2ZzbC9mc2xfc2FpLmMNCkBAIC04MjksOCArODI5LDcgQEAgc3RhdGljIGludCBmc2xfc2FpX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQlzYWktPmJ1c19jbGsgPSBOVUxM
Ow0KIAl9DQogDQotCXNhaS0+bWNsa19jbGtbMF0gPSBzYWktPmJ1c19jbGs7DQotCWZvciAoaSA9
IDE7IGkgPCBGU0xfU0FJX01DTEtfTUFYOyBpKyspIHsNCisJZm9yIChpID0gMDsgaSA8IEZTTF9T
QUlfTUNMS19NQVg7IGkrKykgew0KIAkJc3ByaW50Zih0bXAsICJtY2xrJWQiLCBpKTsNCiAJCXNh
aS0+bWNsa19jbGtbaV0gPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgdG1wKTsNCiAJCWlmIChJ
U19FUlIoc2FpLT5tY2xrX2Nsa1tpXSkpIHsNCi0tIA0KMi4xNy4xDQoNCg==

Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFB6C10F11
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 02:55:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFCB3217D9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 02:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qqVmLmW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCB3217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44flyN079YzDqGq
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 12:55:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.7.72; helo=eur04-he1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="qqVmLmW3"; 
 dkim-atps=neutral
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70072.outbound.protection.outlook.com [40.107.7.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44flwZ3F9zzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 12:54:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFRZAj2fVDjtJKeeOGrQYfnkZacjrhxFHT4VJRAJRTQ=;
 b=qqVmLmW3AzJZBq+lYbEU55IhTXEY9AFFxa84dlKowdBlwnFia61PUo9Gp7XlJ/sahGg9RYjPLGv3+YXWhdObh72vbatOElBbPT0A7sRUH+Kdcpa27YFoRs0XFj4PEm8Eg6kbPBW4TXOb6eNgf4JjvIYJat9rYD8kRmY8/yyfwns=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6431.eurprd04.prod.outlook.com (20.179.232.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Thu, 11 Apr 2019 02:53:57 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%6]) with mapi id 15.20.1771.016; Thu, 11 Apr 2019
 02:53:57 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>, "gustavo@embeddedor.com"
 <gustavo@embeddedor.com>
Subject: [PATCH V3] ASoC: fsl_esai: Fix missing break in switch statement
Thread-Topic: [PATCH V3] ASoC: fsl_esai: Fix missing break in switch statement
Thread-Index: AQHU8BHOw6LtfQFF70KMm36/nLWEtg==
Date: Thu, 11 Apr 2019 02:53:56 +0000
Message-ID: <f1b910498324783f39b66a229c4abb80738097de.1554951087.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK2PR02CA0165.apcprd02.prod.outlook.com
 (2603:1096:201:1f::25) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 190675bc-7fe1-4914-bd8a-08d6be28f0a6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6431; 
x-ms-traffictypediagnostic: VE1PR04MB6431:
x-microsoft-antispam-prvs: <VE1PR04MB64317ADEF5945E581E3A8895E32F0@VE1PR04MB6431.eurprd04.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(376002)(396003)(39860400002)(366004)(346002)(189003)(199004)(4744005)(2501003)(36756003)(2616005)(2201001)(102836004)(316002)(6506007)(2906002)(118296001)(476003)(99286004)(305945005)(66066001)(186003)(81156014)(81166006)(256004)(26005)(52116002)(8676002)(14444005)(486006)(106356001)(5660300002)(508600001)(6486002)(8936002)(105586002)(6436002)(386003)(71200400001)(53936002)(71190400001)(7736002)(14454004)(97736004)(110136005)(6116002)(86362001)(4326008)(68736007)(50226002)(25786009)(6512007)(3846002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6431;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tYagBdO0zEpw0HO1F4686zCuaa+GAhAfknpvViQEjExUim1aHWgxYwjdXGGonnzuEE/evitWfhZ0pHgkOiMUmJ3THGpxPoU02Aejucb2W/PvlyvduCXoXsh3syxzY44XCOMbWstqvosq6VfJEi1WfKh05mS0xitJc9U5zb2gyN4IQ9pNVtHQxrr77yyK5HVknTG6kYJbEP7C9dLGfW/XCvXoUIYGxppG/ZLLrGUwimlYDSRjQ+1t5Y5UUqGr2iPEU4pmIJ6v80djuSQvGdLiTNWVQpQxF5OLHhckZo/THXrYAKR43NBc0gcAvtG+RlvWq8Pcx+7blEPwc2ym+X8X44D+BLe8reRdARy2X4idInOurg7xm8FrPYlWCZkR9C+zGm8iy5wx20hokygqK2ceuz2b432A7gAkEWJh9uL7mTU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 190675bc-7fe1-4914-bd8a-08d6be28f0a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 02:53:56.9585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6431
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Y2FzZSBFU0FJX0hDS1RfRVhUQUwgYW5kIGNhc2UgRVNBSV9IQ0tSX0VYVEFMIHNob3VsZCBiZQ0K
aW5kZXBlbmRlbnQgb2YgZWFjaCBvdGhlciwgc28gcmVwbGFjZSBmYWxsLXRocm91Z2ggd2l0aCBi
cmVhay4NCg0KRml4ZXM6IDQzZDI0ZTc2YjY5OCAoIkFTb0M6IGZzbF9lc2FpOiBBZGQgRVNBSSBD
UFUgREFJIGRyaXZlciIpDQoNClNpZ25lZC1vZmYtYnk6IFNoZW5naml1IFdhbmcgPHNoZW5naml1
LndhbmdAbnhwLmNvbT4NCkNjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4NCi0tLQ0KY2hhbmdl
cyBpbiB2Mw0KLSBhZGQgY2Mgc3RhYmxlDQotIGNoYW5nZSB0aGUgc3ViamVjdA0KDQogc291bmQv
c29jL2ZzbC9mc2xfZXNhaS5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvc291bmQvc29jL2ZzbC9mc2xfZXNhaS5j
IGIvc291bmQvc29jL2ZzbC9mc2xfZXNhaS5jDQppbmRleCAzNjIzYWE5YTZmMmUuLjE1MjAyYTYz
NzE5NyAxMDA2NDQNCi0tLSBhL3NvdW5kL3NvYy9mc2wvZnNsX2VzYWkuYw0KKysrIGIvc291bmQv
c29jL2ZzbC9mc2xfZXNhaS5jDQpAQCAtMjUxLDcgKzI1MSw3IEBAIHN0YXRpYyBpbnQgZnNsX2Vz
YWlfc2V0X2RhaV9zeXNjbGsoc3RydWN0IHNuZF9zb2NfZGFpICpkYWksIGludCBjbGtfaWQsDQog
CQlicmVhazsNCiAJY2FzZSBFU0FJX0hDS1RfRVhUQUw6DQogCQllY3IgfD0gRVNBSV9FQ1JfRVRJ
Ow0KLQkJLyogZmFsbCB0aHJvdWdoICovDQorCQlicmVhazsNCiAJY2FzZSBFU0FJX0hDS1JfRVhU
QUw6DQogCQllY3IgfD0gRVNBSV9FQ1JfRVJJOw0KIAkJYnJlYWs7DQotLSANCjEuOS4xDQoNCg==

Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C731C10F11
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:07:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B378020818
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BBd8DQUK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B378020818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fmCd3VQMzDqNv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 13:07:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.7.74; helo=eur04-he1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="BBd8DQUK"; 
 dkim-atps=neutral
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70074.outbound.protection.outlook.com [40.107.7.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fm9s36DlzDqDL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 13:05:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfmrgzwrB+CUG5F7KSmcUzeieZNEfzFUwBh9eQFiW/0=;
 b=BBd8DQUKhJtIylPMlW1ZVYDXo4t7Td1gmQu25QjSa22BwEUHHOURZw59eq8fHQk4KjGoUVN1LArXlwq+6cQ8k+xImP5n8BCJBDxVdBMrVxN+BlRRsylx+mbyn5I5Z258Mwu50PCLjbzTVfP04UnDnEo9jsWbl2ZeMd3Tof1EX0k=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.235.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Thu, 11 Apr 2019 03:05:28 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%6]) with mapi id 15.20.1771.016; Thu, 11 Apr 2019
 03:05:28 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>, "gustavo@embeddedor.com"
 <gustavo@embeddedor.com>
Subject: [PATCH V4] ASoC: fsl_esai: Fix missing break in switch statement
Thread-Topic: [PATCH V4] ASoC: fsl_esai: Fix missing break in switch statement
Thread-Index: AQHU8BNqkr8hG19y0ka8fOSQOK0Z5g==
Date: Thu, 11 Apr 2019 03:05:28 +0000
Message-ID: <6b953e991b303a26791facbb680efe25d3cc33c3.1554951841.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK2PR0401CA0023.apcprd04.prod.outlook.com
 (2603:1096:202:2::33) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 027c89f2-6f31-418e-b0c6-08d6be2a8cd0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6638; 
x-ms-traffictypediagnostic: VE1PR04MB6638:
x-microsoft-antispam-prvs: <VE1PR04MB6638D627BCC2A753EAD40209E32F0@VE1PR04MB6638.eurprd04.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(136003)(346002)(39860400002)(376002)(199004)(189003)(36756003)(99286004)(68736007)(53936002)(6506007)(25786009)(86362001)(118296001)(26005)(6486002)(6512007)(6436002)(106356001)(4326008)(50226002)(105586002)(52116002)(186003)(102836004)(316002)(386003)(3846002)(97736004)(305945005)(2906002)(2201001)(2616005)(4744005)(486006)(110136005)(2501003)(14444005)(66066001)(8676002)(476003)(14454004)(71200400001)(7736002)(508600001)(81166006)(81156014)(6116002)(256004)(8936002)(5660300002)(71190400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6638;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oPZuQWyitvBfmf0nFHahsOwyzVtEbSN4GO98Dz2hpiRK8AG+4ZN7JPha/fKVlgRzmxhVZENScL0+BCGJs8+IxKJtVz4XZzFWk/sLb98qlY0zU/KNNtzIug7VC4bsnbr7PRAKz5h2QOSjbYxQn9OTha/RPU9hPv8CFXrK2mVtiAjByAhbI9RVF7W7rThcGCuMzfTs9unNSOBVuFAr4cRziYQlUZC4IVmrXFDg/00JY0lGu4qydNnzbhmBkJbpc53ZEWqDFd4aeoethI31LfaOF191Ovu7pD0k/sfTCW5xAZwJz833miXldj725QqFlPmtZwrIIBPEK3FvnAnHO56JVmNC6X4x86fN2zRcOppuO6aBkJNCZq+cO0aPiYs5l5TLXWyyiGcEtnLFDJ5q+x+cmB7TuVx6AUNc2kUWCpGWJzc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 027c89f2-6f31-418e-b0c6-08d6be2a8cd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 03:05:28.6239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6638
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
LndhbmdAbnhwLmNvbT4NCkFja2VkLWJ5OiBOaWNvbGluIENoZW4gPG5pY29sZW90c3VrYUBnbWFp
bC5jb20+DQpDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+DQotLS0NCkNoYW5nZSBpbiB2NA0K
LSBBZGQgQWNrZWQtYnkgYW5kIGNjIHN0YWJsZQ0KLSBjaGFuZ2UgdGhlIHN1YmplY3QNCg0KIHNv
dW5kL3NvYy9mc2wvZnNsX2VzYWkuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9mc2wvZnNsX2Vz
YWkuYyBiL3NvdW5kL3NvYy9mc2wvZnNsX2VzYWkuYw0KaW5kZXggMzYyM2FhOWE2ZjJlLi4xNTIw
MmE2MzcxOTcgMTAwNjQ0DQotLS0gYS9zb3VuZC9zb2MvZnNsL2ZzbF9lc2FpLmMNCisrKyBiL3Nv
dW5kL3NvYy9mc2wvZnNsX2VzYWkuYw0KQEAgLTI1MSw3ICsyNTEsNyBAQCBzdGF0aWMgaW50IGZz
bF9lc2FpX3NldF9kYWlfc3lzY2xrKHN0cnVjdCBzbmRfc29jX2RhaSAqZGFpLCBpbnQgY2xrX2lk
LA0KIAkJYnJlYWs7DQogCWNhc2UgRVNBSV9IQ0tUX0VYVEFMOg0KIAkJZWNyIHw9IEVTQUlfRUNS
X0VUSTsNCi0JCS8qIGZhbGwgdGhyb3VnaCAqLw0KKwkJYnJlYWs7DQogCWNhc2UgRVNBSV9IQ0tS
X0VYVEFMOg0KIAkJZWNyIHw9IEVTQUlfRUNSX0VSSTsNCiAJCWJyZWFrOw0KLS0gDQoxLjkuMQ0K
DQo=

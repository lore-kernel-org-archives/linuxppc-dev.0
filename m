Return-Path: <SRS0=ts8b=SV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7F9C282DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 10:28:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5430218FE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 10:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OozXvIcP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5430218FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lsdc4xG6zDqVj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 20:28:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.13.89; helo=eur01-he1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="OozXvIcP"; 
 dkim-atps=neutral
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr130089.outbound.protection.outlook.com [40.107.13.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lsWy5c1pzDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 20:23:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipgvj3XGQP1hUVXvUGXDSgvrgZrs2HC13fEL/GhxzFo=;
 b=OozXvIcPULHF64QmVgAnnDVCpemsexHjBh2cdRkDJPn3vu4jbMKRCD2N1dNFIAcqdpIi0xrlz6UChLz5Bni1nbLYuKj7uMWw7lX98+PDefv9XDfjZxVX/63Hc7OpM3ee5jUqa0btxJ3qNNPYjtz6qYjuorwVbP8fEN2Ykq/C4zk=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6349.eurprd04.prod.outlook.com (10.255.118.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Fri, 19 Apr 2019 10:23:53 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1813.013; Fri, 19 Apr 2019
 10:23:53 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH V4 2/3] ASoC: fsl_asrc: replace the process_option table with
 function
Thread-Topic: [PATCH V4 2/3] ASoC: fsl_asrc: replace the process_option table
 with function
Thread-Index: AQHU9pn8ypK2cCcT5E2IJLHdJt9wog==
Date: Fri, 19 Apr 2019 10:23:53 +0000
Message-ID: <0f7a6907c73e110c797b478fedaba2fc47b5e994.1555669068.git.shengjiu.wang@nxp.com>
References: <cover.1555669068.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1555669068.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR03CA0082.apcprd03.prod.outlook.com
 (2603:1096:203:72::22) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78ebef55-7711-4773-b60a-08d6c4b11f1a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6349; 
x-ms-traffictypediagnostic: VE1PR04MB6349:
x-microsoft-antispam-prvs: <VE1PR04MB634984AD93516205F629BB98E3270@VE1PR04MB6349.eurprd04.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(376002)(136003)(366004)(346002)(189003)(199004)(97736004)(73956011)(25786009)(26005)(2501003)(2906002)(71190400001)(478600001)(7736002)(102836004)(2201001)(71200400001)(256004)(6506007)(386003)(14444005)(52116002)(53936002)(99286004)(66446008)(68736007)(66066001)(66476007)(64756008)(66556008)(3846002)(6116002)(86362001)(6436002)(6512007)(6486002)(76176011)(186003)(2616005)(316002)(54906003)(476003)(4326008)(486006)(5660300002)(8676002)(36756003)(81156014)(81166006)(118296001)(11346002)(110136005)(446003)(305945005)(14454004)(8936002)(50226002)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6349;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rZyCGSKgY/jU3iclIoJpsAa8AGL/hh/hIMC3D8EI37XH4J43m/wzKrgPWtKlu5sAlKS3o6EXkHr/fq887sTUfwYErV5dGrVC5mebNFWH8ROSPIUa8o9kezhEaU4boWv3UjIgViIhgbiz7z6SaDgi9NxABcTk2WXCGZuGtm6pIz9vkqAzJIAi1qsWHL1WAIAWvpw6qfj5D8iZZGITqkS1dhkHObb9sO9q2n86Ce7l6Ukb7VMv0oDvyWJVLD0glGaNZQJ1qwIjHRx/KzKro5Hz7OVTwJWXBjzbig0XKGPD50jXNCrfeHganre92bkXinevtCiOSAYDHLg5y5XuQbh7KHwpmNmMOkpYKhsqCcDwRYfLWcEW+ULE47vhZeiddPAGKvxEDk9kfG+7MpRhGIZz8mXvXpKMD0hYkFPoDwefGqg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ebef55-7711-4773-b60a-08d6c4b11f1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 10:23:53.4787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6349
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
c3JjLmMgfCA3NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0NCiAxIGZpbGUgY2hhbmdlZCwgNTUgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvZnNsL2ZzbF9hc3JjLmMgYi9zb3VuZC9zb2MvZnNsL2Zz
bF9hc3JjLmMNCmluZGV4IDViOGFkYzdmYjExNy4uMmM0YmJjMzQ5OWRiIDEwMDY0NA0KLS0tIGEv
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
CkBAIC04MCw2ICs2Miw1MSBAQA0KIHN0YXRpYyB1bnNpZ25lZCBjaGFyICpjbGtfbWFwWzJdOw0K
IA0KIC8qKg0KKyAqIFNlbGVjdCB0aGUgcHJlLXByb2Nlc3NpbmcgYW5kIHBvc3QtcHJvY2Vzc2lu
ZyBvcHRpb25zDQorICogVW5zdXBwb3J0IGNhc2VzOiBUc291dCA+IDguMTI1ICogVHNpbiwgVHNv
dXQgPiAxNi4xMjUgKiBUc2luDQorICoNCisgKiBpbnJhdGU6IGlucHV0IHNhbXBsZSByYXRlDQor
ICogb3V0cmF0ZTogb3V0cHV0IHNhbXBsZSByYXRlDQorICogcHJlX3Byb2M6IHJldHVybiB2YWx1
ZSBmb3IgcHJlLXByb2Nlc3Npbmcgb3B0aW9uDQorICogcG9zdF9wcm9jOiByZXR1cm4gdmFsdWUg
Zm9yIHBvc3QtcHJvY2Vzc2luZyBvcHRpb24NCisgKi8NCitzdGF0aWMgaW50IGZzbF9hc3JjX3Nl
bF9wcm9jKGludCBpbnJhdGUsIGludCBvdXRyYXRlLA0KKwkJCSAgICAgaW50ICpwcmVfcHJvYywg
aW50ICpwb3N0X3Byb2MpDQorew0KKwlib29sIHBvc3RfcHJvY19jb25kMjsNCisJYm9vbCBwb3N0
X3Byb2NfY29uZDA7DQorDQorCS8qIHNlbGVjdCBwcmVfcHJvYyBiZXR3ZWVuIFswLCAyXSAqLw0K
KwlpZiAoaW5yYXRlICogOCA+IDMzICogb3V0cmF0ZSkNCisJCSpwcmVfcHJvYyA9IDI7DQorCWVs
c2UgaWYgKGlucmF0ZSAqIDggPiAxNSAqIG91dHJhdGUpIHsNCisJCWlmIChpbnJhdGUgPiAxNTIw
MDApDQorCQkJKnByZV9wcm9jID0gMjsNCisJCWVsc2UNCisJCQkqcHJlX3Byb2MgPSAxOw0KKwl9
IGVsc2UgaWYgKGlucmF0ZSA8IDc2MDAwKQ0KKwkJKnByZV9wcm9jID0gMDsNCisJZWxzZSBpZiAo
aW5yYXRlID4gMTUyMDAwKQ0KKwkJKnByZV9wcm9jID0gMjsNCisJZWxzZQ0KKwkJKnByZV9wcm9j
ID0gMTsNCisNCisJLyogQ29uZGl0aW9uIGZvciBzZWxlY3Rpb24gb2YgcG9zdC1wcm9jZXNzaW5n
ICovDQorCXBvc3RfcHJvY19jb25kMiA9IChpbnJhdGUgKiAxNSA+IG91dHJhdGUgKiAxNiAmJiBv
dXRyYXRlIDwgNTYwMDApIHx8DQorCQkJICAoaW5yYXRlID4gNTYwMDAgJiYgb3V0cmF0ZSA8IDU2
MDAwKTsNCisJcG9zdF9wcm9jX2NvbmQwID0gaW5yYXRlICogMjMgPCBvdXRyYXRlICogODsNCisN
CisJaWYgKHBvc3RfcHJvY19jb25kMikNCisJCSpwb3N0X3Byb2MgPSAyOw0KKwllbHNlIGlmIChw
b3N0X3Byb2NfY29uZDApDQorCQkqcG9zdF9wcm9jID0gMDsNCisJZWxzZQ0KKwkJKnBvc3RfcHJv
YyA9IDE7DQorDQorCXJldHVybiAwOw0KK30NCisNCisvKioNCiAgKiBSZXF1ZXN0IEFTUkMgcGFp
cg0KICAqDQogICogSXQgYXNzaWducyBwYWlyIGJ5IHRoZSBvcmRlciBvZiBBLT5DLT5CIGJlY2F1
c2UgYWxsb2NhdGlvbiBvZiBwYWlyIEIsDQpAQCAtMjM5LDggKzI2NiwxMCBAQCBzdGF0aWMgaW50
IGZzbF9hc3JjX2NvbmZpZ19wYWlyKHN0cnVjdCBmc2xfYXNyY19wYWlyICpwYWlyKQ0KIAl1MzIg
aW5yYXRlLCBvdXRyYXRlLCBpbmRpdiwgb3V0ZGl2Ow0KIAl1MzIgY2xrX2luZGV4WzJdLCBkaXZb
Ml07DQogCWludCBpbiwgb3V0LCBjaGFubmVsczsNCisJaW50IHByZV9wcm9jLCBwb3N0X3Byb2M7
DQogCXN0cnVjdCBjbGsgKmNsazsNCiAJYm9vbCBpZGVhbDsNCisJaW50IHJldDsNCiANCiAJaWYg
KCFjb25maWcpIHsNCiAJCXBhaXJfZXJyKCJpbnZhbGlkIHBhaXIgY29uZmlnXG4iKTsNCkBAIC0y
ODksNiArMzE4LDEyIEBAIHN0YXRpYyBpbnQgZnNsX2FzcmNfY29uZmlnX3BhaXIoc3RydWN0IGZz
bF9hc3JjX3BhaXIgKnBhaXIpDQogCQlyZXR1cm4gLUVJTlZBTDsNCiAJfQ0KIA0KKwlyZXQgPSBm
c2xfYXNyY19zZWxfcHJvYyhpbnJhdGUsIG91dHJhdGUsICZwcmVfcHJvYywgJnBvc3RfcHJvYyk7
DQorCWlmIChyZXQpIHsNCisJCXBhaXJfZXJyKCJObyBzdXBwb3J0ZWQgcHJlLXByb2Nlc3Npbmcg
b3B0aW9uc1xuIik7DQorCQlyZXR1cm4gcmV0Ow0KKwl9DQorDQogCS8qIFZhbGlkYXRlIGlucHV0
IGFuZCBvdXRwdXQgY2xvY2sgc291cmNlcyAqLw0KIAljbGtfaW5kZXhbSU5dID0gY2xrX21hcFtJ
Tl1bY29uZmlnLT5pbmNsa107DQogCWNsa19pbmRleFtPVVRdID0gY2xrX21hcFtPVVRdW2NvbmZp
Zy0+b3V0Y2xrXTsNCkBAIC0zODAsOCArNDE1LDggQEAgc3RhdGljIGludCBmc2xfYXNyY19jb25m
aWdfcGFpcihzdHJ1Y3QgZnNsX2FzcmNfcGFpciAqcGFpcikNCiAJLyogQXBwbHkgY29uZmlndXJh
dGlvbnMgZm9yIHByZS0gYW5kIHBvc3QtcHJvY2Vzc2luZyAqLw0KIAlyZWdtYXBfdXBkYXRlX2Jp
dHMoYXNyY19wcml2LT5yZWdtYXAsIFJFR19BU1JDRkcsDQogCQkJICAgQVNSQ0ZHX1BSRU1PRGlf
TUFTSyhpbmRleCkgfAlBU1JDRkdfUE9TVE1PRGlfTUFTSyhpbmRleCksDQotCQkJICAgQVNSQ0ZH
X1BSRU1PRChpbmRleCwgcHJvY2Vzc19vcHRpb25baW5dW291dF1bMF0pIHwNCi0JCQkgICBBU1JD
RkdfUE9TVE1PRChpbmRleCwgcHJvY2Vzc19vcHRpb25baW5dW291dF1bMV0pKTsNCisJCQkgICBB
U1JDRkdfUFJFTU9EKGluZGV4LCBwcmVfcHJvYykgfA0KKwkJCSAgIEFTUkNGR19QT1NUTU9EKGlu
ZGV4LCBwb3N0X3Byb2MpKTsNCiANCiAJcmV0dXJuIGZzbF9hc3JjX3NldF9pZGVhbF9yYXRpbyhw
YWlyLCBpbnJhdGUsIG91dHJhdGUpOw0KIH0NCi0tIA0KMS45LjENCg0K

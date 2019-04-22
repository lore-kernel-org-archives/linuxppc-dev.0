Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA052C10F14
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 02:38:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5546A20859
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 02:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CAdkWPRA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5546A20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nW3C3YYJzDqRb
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 12:38:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.7.70; helo=eur04-he1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="CAdkWPRA"; 
 dkim-atps=neutral
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70070.outbound.protection.outlook.com [40.107.7.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nVwl18FpzDqRn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 12:32:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8drMaUcQRvRB/ymmCo0SSjLZrVpdzVYIegeIA2GYDNU=;
 b=CAdkWPRAfxvT08IYw+gmYSRk7Q0sK+H+T3Zz1eAbSA/3GknDxoJUVUfgQroTB+i2Q3xCdoXcczl117JmKtJH1aYKfbEpWmAgNqlwB66PFDHnmo9jRjHC8v4JpKtn87BV91rVd0dmCEokVWnquZVXVqROJX5MnEYIKqwq5ZkLVxg=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6605.eurprd04.prod.outlook.com (20.179.234.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Mon, 22 Apr 2019 02:32:35 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 02:32:35 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH V5 2/3] ASoC: fsl_asrc: replace the process_option table with
 function
Thread-Topic: [PATCH V5 2/3] ASoC: fsl_asrc: replace the process_option table
 with function
Thread-Index: AQHU+LOlrDUz+OcZBUSTKxz90NDEZg==
Date: Mon, 22 Apr 2019 02:32:35 +0000
Message-ID: <cc27c775aca3a9c1ffcd310429170bbd64b74a39.1555900078.git.shengjiu.wang@nxp.com>
References: <cover.1555900078.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1555900078.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0P153CA0044.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::32) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2dd7bfd0-d9ba-4f91-7298-08d6c6cac785
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6605; 
x-ms-traffictypediagnostic: VE1PR04MB6605:
x-microsoft-antispam-prvs: <VE1PR04MB66053E00F3DE95873EA65CA6E3220@VE1PR04MB6605.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(346002)(376002)(366004)(39860400002)(396003)(199004)(189003)(316002)(4326008)(36756003)(68736007)(14444005)(256004)(25786009)(14454004)(2201001)(478600001)(8936002)(50226002)(97736004)(7736002)(6116002)(3846002)(11346002)(446003)(6436002)(81156014)(305945005)(8676002)(81166006)(186003)(2501003)(73956011)(66066001)(66446008)(6486002)(66946007)(66476007)(66556008)(64756008)(26005)(386003)(5660300002)(76176011)(6506007)(102836004)(2906002)(118296001)(99286004)(52116002)(486006)(110136005)(86362001)(54906003)(71190400001)(71200400001)(476003)(2616005)(6512007)(53936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6605;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BFOQDjzQ2OGI2KF0V3FpYgq6Tx5TpyYbtOKmeReYr33JoMireiLyiqYXXUYB+b4gOqojUfvD8AcpPvNa4Pl5PQL6UwMm8aGlzhqmmgFkw/VUIjQglqAOp21HluuP8CksFKTVQQEJiZGtZsY1idwzWghG9mtQPty+LKV8DkULArzzeleRndUi3EirJ502PU3oFAWKvQ8xAjTp3XgllnqC/Ejfg/fKmbdzbb8gWKyR1MHqNIH8JPQZidGo8FsxvTFu24rR4yj2ABdiOoMvleEFUCLy6gJsalH+k2WxaYitsTZmMo5GNQzIdAYM4bRM0cwmXHjzaottvfCW6BecB1DyYpZMwYfnQQjAu0+ZYrkzUxZmZoeElcwZ0Y1lQTYoyGQ1ld2g7JAfldgZ1DtaV5zR1u6M6hcpCIGF/9ARvVH07No=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd7bfd0-d9ba-4f91-7298-08d6c6cac785
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 02:32:35.6301 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6605
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
c3JjLmMgfCA3MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0NCiAxIGZpbGUgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvZnNsL2ZzbF9hc3JjLmMgYi9zb3VuZC9zb2MvZnNsL2Zz
bF9hc3JjLmMNCmluZGV4IGVhMDM1YzEyYTMyNS4uNDY3NWVhNGU4MjA0IDEwMDY0NA0KLS0tIGEv
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
c2UgYWxsb2NhdGlvbiBvZiBwYWlyIEIsDQpAQCAtMjM5LDYgKzI2Niw3IEBAIHN0YXRpYyBpbnQg
ZnNsX2FzcmNfY29uZmlnX3BhaXIoc3RydWN0IGZzbF9hc3JjX3BhaXIgKnBhaXIpDQogCXUzMiBp
bnJhdGUsIG91dHJhdGUsIGluZGl2LCBvdXRkaXY7DQogCXUzMiBjbGtfaW5kZXhbMl0sIGRpdlsy
XTsNCiAJaW50IGluLCBvdXQsIGNoYW5uZWxzOw0KKwlpbnQgcHJlX3Byb2MsIHBvc3RfcHJvYzsN
CiAJc3RydWN0IGNsayAqY2xrOw0KIAlib29sIGlkZWFsOw0KIA0KQEAgLTM3NywxMSArNDA1LDEz
IEBAIHN0YXRpYyBpbnQgZnNsX2FzcmNfY29uZmlnX3BhaXIoc3RydWN0IGZzbF9hc3JjX3BhaXIg
KnBhaXIpDQogCQkJICAgQVNSQ1RSX0lEUmlfTUFTSyhpbmRleCkgfCBBU1JDVFJfVVNSaV9NQVNL
KGluZGV4KSwNCiAJCQkgICBBU1JDVFJfSURSKGluZGV4KSB8IEFTUkNUUl9VU1IoaW5kZXgpKTsN
CiANCisJZnNsX2FzcmNfc2VsX3Byb2MoaW5yYXRlLCBvdXRyYXRlLCAmcHJlX3Byb2MsICZwb3N0
X3Byb2MpOw0KKw0KIAkvKiBBcHBseSBjb25maWd1cmF0aW9ucyBmb3IgcHJlLSBhbmQgcG9zdC1w
cm9jZXNzaW5nICovDQogCXJlZ21hcF91cGRhdGVfYml0cyhhc3JjX3ByaXYtPnJlZ21hcCwgUkVH
X0FTUkNGRywNCiAJCQkgICBBU1JDRkdfUFJFTU9EaV9NQVNLKGluZGV4KSB8CUFTUkNGR19QT1NU
TU9EaV9NQVNLKGluZGV4KSwNCi0JCQkgICBBU1JDRkdfUFJFTU9EKGluZGV4LCBwcm9jZXNzX29w
dGlvbltpbl1bb3V0XVswXSkgfA0KLQkJCSAgIEFTUkNGR19QT1NUTU9EKGluZGV4LCBwcm9jZXNz
X29wdGlvbltpbl1bb3V0XVsxXSkpOw0KKwkJCSAgIEFTUkNGR19QUkVNT0QoaW5kZXgsIHByZV9w
cm9jKSB8DQorCQkJICAgQVNSQ0ZHX1BPU1RNT0QoaW5kZXgsIHBvc3RfcHJvYykpOw0KIA0KIAly
ZXR1cm4gZnNsX2FzcmNfc2V0X2lkZWFsX3JhdGlvKHBhaXIsIGlucmF0ZSwgb3V0cmF0ZSk7DQog
fQ0KLS0gDQoxLjkuMQ0KDQo=

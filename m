Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA19C10F12
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 09:09:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 923A0206B6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 09:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rajHH5Yl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923A0206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kbyv1k2BzDq5y
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 19:09:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe09::62f;
 helo=eur03-ve1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="rajHH5Yl"; 
 dkim-atps=neutral
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03on062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe09::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kbvM1WtLzDqK9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 19:06:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Rd60uVt2CecJrHeRIhVJATfsO24R/wO9a9prs/zx2E=;
 b=rajHH5Yl00yiwGWzm2TAD61wKy7KKjZ4yy026VcKHdYm6L/bNlWhg2f96vS6YZknmwc9RsJfZ4jPog8bpYTSrk6kDd+/zlijgb2D8IcVuG93BlxE3rVY2wSFRxb0jOAZXnjKtRiPjUcPmhmbSGFW9WJQHJXpJionD3vp255Ujyc=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6640.eurprd04.prod.outlook.com (20.179.235.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Wed, 17 Apr 2019 09:06:18 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1792.018; Wed, 17 Apr 2019
 09:06:18 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH V3 1/2] ASoC: fsl_asrc: replace the process_option table with
 function
Thread-Topic: [PATCH V3 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Thread-Index: AQHU9PzRFmO4WET4XkOHw7F0Vv6HFQ==
Date: Wed, 17 Apr 2019 09:06:18 +0000
Message-ID: <1eaeb882bdd69108c8ce897398c5c36ece6d49c5.1555491598.git.shengjiu.wang@nxp.com>
References: <cover.1555491598.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1555491598.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::27) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d876715e-f59e-4354-80ce-08d6c313f3b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6640; 
x-ms-traffictypediagnostic: VE1PR04MB6640:
x-microsoft-antispam-prvs: <VE1PR04MB6640FBBC557A1B7A2F391846E3250@VE1PR04MB6640.eurprd04.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(39860400002)(366004)(376002)(396003)(136003)(199004)(189003)(54906003)(53936002)(99286004)(118296001)(110136005)(186003)(102836004)(26005)(6506007)(386003)(8676002)(68736007)(478600001)(81166006)(81156014)(2201001)(50226002)(86362001)(6436002)(8936002)(305945005)(2501003)(6486002)(36756003)(7736002)(14454004)(71190400001)(256004)(105586002)(6116002)(25786009)(71200400001)(6512007)(97736004)(106356001)(5660300002)(14444005)(11346002)(76176011)(2616005)(446003)(476003)(486006)(316002)(2906002)(3846002)(4326008)(52116002)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6640;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cBwmO66ilfUYV0s0nEobalca0F6PL9X+o+1m1dMrwb/rka1HSCZ0m+/aEYwTSgNIRZP6000/tRGROlob4oLUSVmnYE+W7vknpakXKeFlEKLy548fzd7uZUjEnrb++xRQiFdtL2VUIJraSqTIwizlLqjH2Diz/FB0ZVVrSDlSAn9ToBrEo++xXwg7Eh1flDC7ItRWt/O2V82aB1WAzuo0KdgP5qr3TZGp9rOGnq9uhc5g3LRbMN1olXO/56m949lsHkap4MswnBY5ZS/cakGvzFho1fLjpuBIpSqgrBi9Qf2G/QWxN/IXi6BFqZDlGOKX59QlXTMwIbiR5sguM+btsOkbmkmRAMYJAD5MyBaH3Z1jKp7v7NDXk7AeqwMO8jvF7GIXjJlma0w68bMbMuX2q15o4v0P4zjfxXzXZ2Q0yW8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d876715e-f59e-4354-80ce-08d6c313f3b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 09:06:18.6039 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6640
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
c3JjLmMgfCA3OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0NCiAxIGZpbGUgY2hhbmdlZCwgNTggaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvZnNsL2ZzbF9hc3JjLmMgYi9zb3VuZC9zb2MvZnNsL2Zz
bF9hc3JjLmMNCmluZGV4IDBiOTM3OTI0ZDJlNC4uZDM0ZDUzOWQwMWYyIDEwMDY0NA0KLS0tIGEv
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
CkBAIC04MCw2ICs2Miw1NCBAQA0KIHN0YXRpYyB1bnNpZ25lZCBjaGFyICpjbGtfbWFwWzJdOw0K
IA0KIC8qKg0KKyAqIFNlbGVjdCB0aGUgcHJlLXByb2Nlc3NpbmcgYW5kIHBvc3QtcHJvY2Vzc2lu
ZyBvcHRpb25zDQorICoNCisgKiBpbnJhdGU6IGlucHV0IHNhbXBsZSByYXRlDQorICogb3V0cmF0
ZTogb3V0cHV0IHNhbXBsZSByYXRlDQorICogcHJlX3Byb2M6IHJldHVybiB2YWx1ZSBmb3IgcHJl
LXByb2Nlc3Npbmcgb3B0aW9uDQorICogcG9zdF9wcm9jOiByZXR1cm4gdmFsdWUgZm9yIHBvc3Qt
cHJvY2Vzc2luZyBvcHRpb24NCisgKi8NCitzdGF0aWMgaW50IGZzbF9hc3JjX3NlbF9wcm9jKGlu
dCBpbnJhdGUsIGludCBvdXRyYXRlLCBpbnQgKnByZV9wcm9jLA0KKwkJCSAgICAgaW50ICpwb3N0
X3Byb2MpDQorew0KKwlib29sIHBvc3RfcHJvY19jb25kMjsNCisJYm9vbCBwb3N0X3Byb2NfY29u
ZDA7DQorDQorCS8qIERvZXMgbm90IHN1cHBvcnQgY2FzZXM6IFRzb3V0ID4gOC4xMjUgKiBUc2lu
ICovDQorCWlmIChpbnJhdGUgKiA4ID4gNjUgKiBvdXRyYXRlKQ0KKwkJcmV0dXJuIC1FSU5WQUw7
DQorDQorCS8qIE90aGVyd2lzZSwgc2VsZWN0IHByZV9wcm9jIGJldHdlZW4gWzAsIDJdICovDQor
CWlmIChpbnJhdGUgKiA4ID4gMzMgKiBvdXRyYXRlKQ0KKwkJKnByZV9wcm9jID0gMjsNCisJZWxz
ZSBpZiAoaW5yYXRlICogOCA+IDE1ICogb3V0cmF0ZSkgew0KKwkJaWYgKGlucmF0ZSA+IDE1MjAw
MCkNCisJCQkqcHJlX3Byb2MgPSAyOw0KKwkJZWxzZQ0KKwkJCSpwcmVfcHJvYyA9IDE7DQorCX0g
ZWxzZSBpZiAoaW5yYXRlIDwgNzYwMDApDQorCQkqcHJlX3Byb2MgPSAwOw0KKwllbHNlIGlmIChp
bnJhdGUgPiAxNTIwMDApDQorCQkqcHJlX3Byb2MgPSAyOw0KKwllbHNlDQorCQkqcHJlX3Byb2Mg
PSAxOw0KKw0KKwkvKiBDb25kaXRpb24gZm9yIHNlbGVjdGlvbiBvZiBwb3N0LXByb2Nlc3Npbmcg
Ki8NCisJcG9zdF9wcm9jX2NvbmQyID0gKGlucmF0ZSAqIDE1ID4gb3V0cmF0ZSAqIDE2ICYmIG91
dHJhdGUgPCA1NjAwMCkgfHwNCisJCShpbnJhdGUgPiA1NjAwMCAmJiBvdXRyYXRlIDwgNTYwMDAp
Ow0KKwlwb3N0X3Byb2NfY29uZDAgPSBpbnJhdGUgKiAyMyA8IG91dHJhdGUgKiA4Ow0KKw0KKwlp
ZiAocG9zdF9wcm9jX2NvbmQyKQ0KKwkJKnBvc3RfcHJvYyA9IDI7DQorCWVsc2UgaWYgKHBvc3Rf
cHJvY19jb25kMCkNCisJCSpwb3N0X3Byb2MgPSAwOw0KKwllbHNlDQorCQkqcG9zdF9wcm9jID0g
MTsNCisNCisJcmV0dXJuIDA7DQorfQ0KKw0KKy8qKg0KICAqIFJlcXVlc3QgQVNSQyBwYWlyDQog
ICoNCiAgKiBJdCBhc3NpZ25zIHBhaXIgYnkgdGhlIG9yZGVyIG9mIEEtPkMtPkIgYmVjYXVzZSBh
bGxvY2F0aW9uIG9mIHBhaXIgQiwNCkBAIC0yMzksOCArMjY5LDEwIEBAIHN0YXRpYyBpbnQgZnNs
X2FzcmNfY29uZmlnX3BhaXIoc3RydWN0IGZzbF9hc3JjX3BhaXIgKnBhaXIpDQogCXUzMiBpbnJh
dGUsIG91dHJhdGUsIGluZGl2LCBvdXRkaXY7DQogCXUzMiBjbGtfaW5kZXhbMl0sIGRpdlsyXTsN
CiAJaW50IGluLCBvdXQsIGNoYW5uZWxzOw0KKwlpbnQgcHJlX3Byb2MsIHBvc3RfcHJvYzsNCiAJ
c3RydWN0IGNsayAqY2xrOw0KIAlib29sIGlkZWFsOw0KKwlpbnQgcmV0Ow0KIA0KIAlpZiAoIWNv
bmZpZykgew0KIAkJcGFpcl9lcnIoImludmFsaWQgcGFpciBjb25maWdcbiIpOw0KQEAgLTI4OSw2
ICszMjEsMTIgQEAgc3RhdGljIGludCBmc2xfYXNyY19jb25maWdfcGFpcihzdHJ1Y3QgZnNsX2Fz
cmNfcGFpciAqcGFpcikNCiAJCXJldHVybiAtRUlOVkFMOw0KIAl9DQogDQorCXJldCA9IGZzbF9h
c3JjX3NlbF9wcm9jKGlucmF0ZSwgb3V0cmF0ZSwgJnByZV9wcm9jLCAmcG9zdF9wcm9jKTsNCisJ
aWYgKHJldCkgew0KKwkJcGFpcl9lcnIoIk5vIHN1cHBvcnRlZCBwcmUtcHJvY2Vzc2luZyBvcHRp
b25zXG4iKTsNCisJCXJldHVybiByZXQ7DQorCX0NCisNCiAJLyogVmFsaWRhdGUgaW5wdXQgYW5k
IG91dHB1dCBjbG9jayBzb3VyY2VzICovDQogCWNsa19pbmRleFtJTl0gPSBjbGtfbWFwW0lOXVtj
b25maWctPmluY2xrXTsNCiAJY2xrX2luZGV4W09VVF0gPSBjbGtfbWFwW09VVF1bY29uZmlnLT5v
dXRjbGtdOw0KQEAgLTM4MCw4ICs0MTgsOCBAQCBzdGF0aWMgaW50IGZzbF9hc3JjX2NvbmZpZ19w
YWlyKHN0cnVjdCBmc2xfYXNyY19wYWlyICpwYWlyKQ0KIAkvKiBBcHBseSBjb25maWd1cmF0aW9u
cyBmb3IgcHJlLSBhbmQgcG9zdC1wcm9jZXNzaW5nICovDQogCXJlZ21hcF91cGRhdGVfYml0cyhh
c3JjX3ByaXYtPnJlZ21hcCwgUkVHX0FTUkNGRywNCiAJCQkgICBBU1JDRkdfUFJFTU9EaV9NQVNL
KGluZGV4KSB8CUFTUkNGR19QT1NUTU9EaV9NQVNLKGluZGV4KSwNCi0JCQkgICBBU1JDRkdfUFJF
TU9EKGluZGV4LCBwcm9jZXNzX29wdGlvbltpbl1bb3V0XVswXSkgfA0KLQkJCSAgIEFTUkNGR19Q
T1NUTU9EKGluZGV4LCBwcm9jZXNzX29wdGlvbltpbl1bb3V0XVsxXSkpOw0KKwkJCSAgIEFTUkNG
R19QUkVNT0QoaW5kZXgsIHByZV9wcm9jKSB8DQorCQkJICAgQVNSQ0ZHX1BPU1RNT0QoaW5kZXgs
IHBvc3RfcHJvYykpOw0KIA0KIAlyZXR1cm4gZnNsX2FzcmNfc2V0X2lkZWFsX3JhdGlvKHBhaXIs
IGlucmF0ZSwgb3V0cmF0ZSk7DQogfQ0KLS0gDQoxLjkuMQ0KDQo=

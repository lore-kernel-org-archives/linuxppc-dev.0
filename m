Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF3FC282E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 04:56:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29C5A20859
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 04:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j9/Y8oBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C5A20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nZ6w4Z6BzDqM4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 14:56:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.1.44; helo=eur02-he1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="j9/Y8oBt"; 
 dkim-atps=neutral
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10044.outbound.protection.outlook.com [40.107.1.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nZ1n3dlZzDqLL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 14:52:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEPRMVhFotuwbBTM6XJq+0/fB6SkrlhN6aSpKIdUYRY=;
 b=j9/Y8oBtDI2J2sFh7HmS4FWTCu6jPoiZQVBjbWmvq1nmfLr7X5FOD/g2Xyz3OoEzT83gvXFkoSh6maOUEuG/ZVi7DDuX/gIgf7RNEPuqr7a1zzM+38uoIYHtalsuLa6xy4B0BC4f/vfECRADxb9lBHY4JH0bwhIl9MM7TOa5iMc=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Mon, 22 Apr 2019 04:52:05 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 04:52:05 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH V6 2/3] ASoC: fsl_asrc: replace the process_option table with
 function
Thread-Topic: [PATCH V6 2/3] ASoC: fsl_asrc: replace the process_option table
 with function
Thread-Index: AQHU+Mch/8e5XsUVjk+CuLoPgFIYVw==
Date: Mon, 22 Apr 2019 04:52:05 +0000
Message-ID: <374677ba62cca3418d6a91ced60653d0976bbb41.1555908545.git.shengjiu.wang@nxp.com>
References: <cover.1555908545.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1555908545.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::15) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 283c63fe-2b48-4b0a-e81d-08d6c6de4435
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6479; 
x-ms-traffictypediagnostic: VE1PR04MB6479:
x-microsoft-antispam-prvs: <VE1PR04MB647943455A098ADF2DA8FAB0E3220@VE1PR04MB6479.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(396003)(39860400002)(136003)(376002)(199004)(189003)(2201001)(486006)(26005)(99286004)(6436002)(5660300002)(186003)(316002)(66066001)(6486002)(86362001)(81156014)(81166006)(8676002)(118296001)(476003)(2616005)(11346002)(446003)(305945005)(7736002)(8936002)(50226002)(2501003)(97736004)(54906003)(3846002)(14454004)(76176011)(110136005)(4326008)(6512007)(2906002)(68736007)(478600001)(71200400001)(71190400001)(386003)(6506007)(53936002)(66556008)(52116002)(66476007)(256004)(36756003)(64756008)(73956011)(66446008)(66946007)(6116002)(102836004)(14444005)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6479;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CwmWrwJydCy6kURZ96YAcFLtjXhqdTjsm3LDZGBEKnL5kzqTfpkH53LPZup9+PmgAeZdaFGnla6tYKQT00LkdqnU87x4vCU8mRaFVAS3MGF5T3ImuurrD4XklmJo/YMEg6uTxtzGxYPBZXrtF0Cfx0YCWUw4kAvHQtkEgRAZ2+pp0sGW/QGkUk3LqKuBtY406+Rlls4yMhzDd0qYsTio5mMUpJmqYE/dnDhMo3PZI/F3RQIBD13nMt2Gbic0aQn/tUZCNBYs1R8jlh9/7vFdKPNn70YqUn0/T3tdKXL4tOYUo7QJ9E3xL0uO+VAjF78inwuEyf6bwLAUnc4EUhSxH+uRcGLpuP/68bxQgHy8FbMmWVgdhyID8SZhsS8V6vj0u5lNoIUqJnifRjY8RmfDJ5MeqSadZ7yBm+V21yiqtdw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 283c63fe-2b48-4b0a-e81d-08d6c6de4435
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 04:52:05.3169 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6479
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
dSBXYW5nIDxzaGVuZ2ppdS53YW5nQG54cC5jb20+DQpBY2tlZC1ieTogTmljb2xpbiBDaGVuIDxu
aWNvbGVvdHN1a2FAZ21haWwuY29tPg0KLS0tDQogc291bmQvc29jL2ZzbC9mc2xfYXNyYy5jIHwg
NzEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tDQogMSBm
aWxlIGNoYW5nZWQsIDUxIGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvc291bmQvc29jL2ZzbC9mc2xfYXNyYy5jIGIvc291bmQvc29jL2ZzbC9mc2xfYXNyYy5j
DQppbmRleCBlYTAzNWMxMmEzMjUuLmE4ZDY3MTBmMjU0MSAxMDA2NDQNCi0tLSBhL3NvdW5kL3Nv
Yy9mc2wvZnNsX2FzcmMuYw0KKysrIGIvc291bmQvc29jL2ZzbC9mc2xfYXNyYy5jDQpAQCAtMjYs
MjQgKzI2LDYgQEANCiAjZGVmaW5lIHBhaXJfZGJnKGZtdCwgLi4uKSBcDQogCWRldl9kYmcoJmFz
cmNfcHJpdi0+cGRldi0+ZGV2LCAiUGFpciAlYzogIiBmbXQsICdBJyArIGluZGV4LCAjI19fVkFf
QVJHU19fKQ0KIA0KLS8qIFNhbXBsZSByYXRlcyBhcmUgYWxpZ25lZCB3aXRoIHRoYXQgZGVmaW5l
ZCBpbiBwY20uaCBmaWxlICovDQotc3RhdGljIGNvbnN0IHU4IHByb2Nlc3Nfb3B0aW9uW11bMTJd
WzJdID0gew0KLQkvKiA4a0h6IDExLjAyNWtIeiAxNmtIeiAyMi4wNWtIeiAzMmtIeiA0NC4xa0h6
IDQ4a0h6ICAgNjRrSHogICA4OC4ya0h6IDk2a0h6ICAgMTc2a0h6ICAxOTJrSHogKi8NCi0Je3sw
LCAxfSwgezAsIDF9LCB7MCwgMX0sIHswLCAwfSwgezAsIDB9LCB7MCwgMH0sIHswLCAwfSwgezAs
IDB9LCB7MCwgMH0sIHswLCAwfSwgezAsIDB9LCB7MCwgMH0sfSwJLyogNTUxMkh6ICovDQotCXt7
MCwgMX0sIHswLCAxfSwgezAsIDF9LCB7MCwgMX0sIHswLCAwfSwgezAsIDB9LCB7MCwgMH0sIHsw
LCAwfSwgezAsIDB9LCB7MCwgMH0sIHswLCAwfSwgezAsIDB9LH0sCS8qIDhrSHogKi8NCi0Je3sw
LCAyfSwgezAsIDF9LCB7MCwgMX0sIHswLCAxfSwgezAsIDB9LCB7MCwgMH0sIHswLCAwfSwgezAs
IDB9LCB7MCwgMH0sIHswLCAwfSwgezAsIDB9LCB7MCwgMH0sfSwJLyogMTEwMjVIeiAqLw0KLQl7
ezEsIDJ9LCB7MCwgMn0sIHswLCAxfSwgezAsIDF9LCB7MCwgMX0sIHswLCAxfSwgezAsIDF9LCB7
MCwgMH0sIHswLCAwfSwgezAsIDB9LCB7MCwgMH0sIHswLCAwfSx9LAkvKiAxNmtIeiAqLw0KLQl7
ezEsIDJ9LCB7MSwgMn0sIHswLCAyfSwgezAsIDF9LCB7MCwgMX0sIHswLCAxfSwgezAsIDF9LCB7
MCwgMH0sIHswLCAwfSwgezAsIDB9LCB7MCwgMH0sIHswLCAwfSx9LAkvKiAyMjA1MEh6ICovDQot
CXt7MSwgMn0sIHsyLCAxfSwgezIsIDF9LCB7MCwgMn0sIHswLCAxfSwgezAsIDF9LCB7MCwgMX0s
IHswLCAxfSwgezAsIDF9LCB7MCwgMH0sIHswLCAwfSwgezAsIDB9LH0sCS8qIDMya0h6ICovDQot
CXt7MiwgMn0sIHsyLCAyfSwgezIsIDF9LCB7MiwgMX0sIHswLCAyfSwgezAsIDF9LCB7MCwgMX0s
IHswLCAxfSwgezAsIDF9LCB7MCwgMX0sIHswLCAwfSwgezAsIDB9LH0sCS8qIDQ0LjFrSHogKi8N
Ci0Je3syLCAyfSwgezIsIDJ9LCB7MiwgMX0sIHsyLCAxfSwgezAsIDJ9LCB7MCwgMn0sIHswLCAx
fSwgezAsIDF9LCB7MCwgMX0sIHswLCAxfSwgezAsIDB9LCB7MCwgMH0sfSwJLyogNDhrSHogKi8N
Ci0Je3syLCAyfSwgezIsIDJ9LCB7MiwgMn0sIHsyLCAxfSwgezEsIDJ9LCB7MCwgMn0sIHswLCAy
fSwgezAsIDF9LCB7MCwgMX0sIHswLCAxfSwgezAsIDF9LCB7MCwgMH0sfSwJLyogNjRrSHogKi8N
Ci0Je3syLCAyfSwgezIsIDJ9LCB7MiwgMn0sIHsyLCAyfSwgezEsIDJ9LCB7MSwgMn0sIHsxLCAy
fSwgezEsIDF9LCB7MSwgMX0sIHsxLCAxfSwgezEsIDF9LCB7MSwgMX0sfSwJLyogODguMmtIeiAq
Lw0KLQl7ezIsIDJ9LCB7MiwgMn0sIHsyLCAyfSwgezIsIDJ9LCB7MSwgMn0sIHsxLCAyfSwgezEs
IDJ9LCB7MSwgMX0sIHsxLCAxfSwgezEsIDF9LCB7MSwgMX0sIHsxLCAxfSx9LAkvKiA5NmtIeiAq
Lw0KLQl7ezIsIDJ9LCB7MiwgMn0sIHsyLCAyfSwgezIsIDJ9LCB7MiwgMn0sIHsyLCAyfSwgezIs
IDJ9LCB7MiwgMX0sIHsyLCAxfSwgezIsIDF9LCB7MiwgMX0sIHsyLCAxfSx9LAkvKiAxNzZrSHog
Ki8NCi0Je3syLCAyfSwgezIsIDJ9LCB7MiwgMn0sIHsyLCAyfSwgezIsIDJ9LCB7MiwgMn0sIHsy
LCAyfSwgezIsIDF9LCB7MiwgMX0sIHsyLCAxfSwgezIsIDF9LCB7MiwgMX0sfSwJLyogMTkya0h6
ICovDQotfTsNCi0NCiAvKiBDb3JyZXNwb25kaW5nIHRvIHByb2Nlc3Nfb3B0aW9uICovDQogc3Rh
dGljIGludCBzdXBwb3J0ZWRfaW5wdXRfcmF0ZVtdID0gew0KIAk1NTEyLCA4MDAwLCAxMTAyNSwg
MTYwMDAsIDIyMDUwLCAzMjAwMCwgNDQxMDAsIDQ4MDAwLCA2NDAwMCwgODgyMDAsDQpAQCAtODAs
NiArNjIsNTIgQEANCiBzdGF0aWMgdW5zaWduZWQgY2hhciAqY2xrX21hcFsyXTsNCiANCiAvKioN
CisgKiBTZWxlY3QgdGhlIHByZS1wcm9jZXNzaW5nIGFuZCBwb3N0LXByb2Nlc3Npbmcgb3B0aW9u
cw0KKyAqIE1ha2Ugc3VyZSB0byBleGNsdWRlIGZvbGxvd2luZyB1bnN1cHBvcnRlZCBjYXNlcyBi
ZWZvcmUNCisgKiBjYWxsaW5nIHRoaXMgZnVuY3Rpb246DQorICogMSkgaW5yYXRlID4gOC4xMjUg
KiBvdXRyYXRlDQorICogMikgaW5yYXRlID4gMTYuMTI1ICogb3V0cmF0ZQ0KKyAqDQorICogaW5y
YXRlOiBpbnB1dCBzYW1wbGUgcmF0ZQ0KKyAqIG91dHJhdGU6IG91dHB1dCBzYW1wbGUgcmF0ZQ0K
KyAqIHByZV9wcm9jOiByZXR1cm4gdmFsdWUgZm9yIHByZS1wcm9jZXNzaW5nIG9wdGlvbg0KKyAq
IHBvc3RfcHJvYzogcmV0dXJuIHZhbHVlIGZvciBwb3N0LXByb2Nlc3Npbmcgb3B0aW9uDQorICov
DQorc3RhdGljIHZvaWQgZnNsX2FzcmNfc2VsX3Byb2MoaW50IGlucmF0ZSwgaW50IG91dHJhdGUs
DQorCQkJICAgICBpbnQgKnByZV9wcm9jLCBpbnQgKnBvc3RfcHJvYykNCit7DQorCWJvb2wgcG9z
dF9wcm9jX2NvbmQyOw0KKwlib29sIHBvc3RfcHJvY19jb25kMDsNCisNCisJLyogc2VsZWN0IHBy
ZV9wcm9jIGJldHdlZW4gWzAsIDJdICovDQorCWlmIChpbnJhdGUgKiA4ID4gMzMgKiBvdXRyYXRl
KQ0KKwkJKnByZV9wcm9jID0gMjsNCisJZWxzZSBpZiAoaW5yYXRlICogOCA+IDE1ICogb3V0cmF0
ZSkgew0KKwkJaWYgKGlucmF0ZSA+IDE1MjAwMCkNCisJCQkqcHJlX3Byb2MgPSAyOw0KKwkJZWxz
ZQ0KKwkJCSpwcmVfcHJvYyA9IDE7DQorCX0gZWxzZSBpZiAoaW5yYXRlIDwgNzYwMDApDQorCQkq
cHJlX3Byb2MgPSAwOw0KKwllbHNlIGlmIChpbnJhdGUgPiAxNTIwMDApDQorCQkqcHJlX3Byb2Mg
PSAyOw0KKwllbHNlDQorCQkqcHJlX3Byb2MgPSAxOw0KKw0KKwkvKiBDb25kaXRpb24gZm9yIHNl
bGVjdGlvbiBvZiBwb3N0LXByb2Nlc3NpbmcgKi8NCisJcG9zdF9wcm9jX2NvbmQyID0gKGlucmF0
ZSAqIDE1ID4gb3V0cmF0ZSAqIDE2ICYmIG91dHJhdGUgPCA1NjAwMCkgfHwNCisJCQkgIChpbnJh
dGUgPiA1NjAwMCAmJiBvdXRyYXRlIDwgNTYwMDApOw0KKwlwb3N0X3Byb2NfY29uZDAgPSBpbnJh
dGUgKiAyMyA8IG91dHJhdGUgKiA4Ow0KKw0KKwlpZiAocG9zdF9wcm9jX2NvbmQyKQ0KKwkJKnBv
c3RfcHJvYyA9IDI7DQorCWVsc2UgaWYgKHBvc3RfcHJvY19jb25kMCkNCisJCSpwb3N0X3Byb2Mg
PSAwOw0KKwllbHNlDQorCQkqcG9zdF9wcm9jID0gMTsNCit9DQorDQorLyoqDQogICogUmVxdWVz
dCBBU1JDIHBhaXINCiAgKg0KICAqIEl0IGFzc2lnbnMgcGFpciBieSB0aGUgb3JkZXIgb2YgQS0+
Qy0+QiBiZWNhdXNlIGFsbG9jYXRpb24gb2YgcGFpciBCLA0KQEAgLTIzOSw2ICsyNjcsNyBAQCBz
dGF0aWMgaW50IGZzbF9hc3JjX2NvbmZpZ19wYWlyKHN0cnVjdCBmc2xfYXNyY19wYWlyICpwYWly
KQ0KIAl1MzIgaW5yYXRlLCBvdXRyYXRlLCBpbmRpdiwgb3V0ZGl2Ow0KIAl1MzIgY2xrX2luZGV4
WzJdLCBkaXZbMl07DQogCWludCBpbiwgb3V0LCBjaGFubmVsczsNCisJaW50IHByZV9wcm9jLCBw
b3N0X3Byb2M7DQogCXN0cnVjdCBjbGsgKmNsazsNCiAJYm9vbCBpZGVhbDsNCiANCkBAIC0zNzcs
MTEgKzQwNiwxMyBAQCBzdGF0aWMgaW50IGZzbF9hc3JjX2NvbmZpZ19wYWlyKHN0cnVjdCBmc2xf
YXNyY19wYWlyICpwYWlyKQ0KIAkJCSAgIEFTUkNUUl9JRFJpX01BU0soaW5kZXgpIHwgQVNSQ1RS
X1VTUmlfTUFTSyhpbmRleCksDQogCQkJICAgQVNSQ1RSX0lEUihpbmRleCkgfCBBU1JDVFJfVVNS
KGluZGV4KSk7DQogDQorCWZzbF9hc3JjX3NlbF9wcm9jKGlucmF0ZSwgb3V0cmF0ZSwgJnByZV9w
cm9jLCAmcG9zdF9wcm9jKTsNCisNCiAJLyogQXBwbHkgY29uZmlndXJhdGlvbnMgZm9yIHByZS0g
YW5kIHBvc3QtcHJvY2Vzc2luZyAqLw0KIAlyZWdtYXBfdXBkYXRlX2JpdHMoYXNyY19wcml2LT5y
ZWdtYXAsIFJFR19BU1JDRkcsDQogCQkJICAgQVNSQ0ZHX1BSRU1PRGlfTUFTSyhpbmRleCkgfAlB
U1JDRkdfUE9TVE1PRGlfTUFTSyhpbmRleCksDQotCQkJICAgQVNSQ0ZHX1BSRU1PRChpbmRleCwg
cHJvY2Vzc19vcHRpb25baW5dW291dF1bMF0pIHwNCi0JCQkgICBBU1JDRkdfUE9TVE1PRChpbmRl
eCwgcHJvY2Vzc19vcHRpb25baW5dW291dF1bMV0pKTsNCisJCQkgICBBU1JDRkdfUFJFTU9EKGlu
ZGV4LCBwcmVfcHJvYykgfA0KKwkJCSAgIEFTUkNGR19QT1NUTU9EKGluZGV4LCBwb3N0X3Byb2Mp
KTsNCiANCiAJcmV0dXJuIGZzbF9hc3JjX3NldF9pZGVhbF9yYXRpbyhwYWlyLCBpbnJhdGUsIG91
dHJhdGUpOw0KIH0NCi0tIA0KMS45LjENCg0K

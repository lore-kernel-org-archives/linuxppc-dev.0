Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDFEC282CC
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 10:17:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 285DD2083B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 10:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DZh6arsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285DD2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43v0rf1qyyzDqMH
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 21:17:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe1f::623;
 helo=eur01-ve1-obe.outbound.protection.outlook.com;
 envelope-from=pankaj.bansal@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="DZh6arsr"; 
 dkim-atps=neutral
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43v0n84TlGzDqJQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 21:14:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjwTns9PSUkWQ5GbgWcUqonl9TZv6OTmqVQEXAMkPzY=;
 b=DZh6arsrl0R0MkBi6XXN4vp+q7S4nyQ5SxSHa7xQ6VeMUskOexVEFSZnMQKrsth53pMjVVQpDoQKwNKg5kX2XbGLfijUIhoeSrFhum1UfkvtysEAksyDOdxgaBoE7n5p4Ki6IvAZMIfukjYsoskqFv3xpafBpGqOQSoV2tfKqb8=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2030.eurprd04.prod.outlook.com (10.166.141.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Tue, 5 Feb 2019 10:14:41 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 10:14:41 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 1/2] dt-bindings: soc: fsl: Document Qixis FPGA usage
Thread-Topic: [PATCH v4 1/2] dt-bindings: soc: fsl: Document Qixis FPGA usage
Thread-Index: AQHUvTubgJLDSKArS0iRP7YRYODBng==
Date: Tue, 5 Feb 2019 10:14:40 +0000
Message-ID: <20190205153924.7204-2-pankaj.bansal@nxp.com>
References: <20190205153924.7204-1-pankaj.bansal@nxp.com>
In-Reply-To: <20190205153924.7204-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::29) To VI1PR0401MB2496.eurprd04.prod.outlook.com
 (2603:10a6:800:56::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [92.120.1.69]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0401MB2030;
 6:b4+N70u3CFVBQEF9m2hE3ZiPBDBHf0CT+abwfCjFhzzL6zXDQ2JbcqpsEPfWwRvYoPZXX4mzxVrKF0GVJaLGH6sWgVLKMYRkPgFTJvJiK/0RoSkC5YWuBDlYAZidyveG1Ktdws7ll/P8eyGGSTB5iG4GJm9bopQcg5ALWd4ckx7MwzjbpVNFW/FVVSku7KVctUydb8QAz0AVZE3BgXrYudqMxwaFbepPKmjGmDQownuj9i9273ayIifmrOl74tcCWcATqjwIsgKOST9PbM/xBp86idpdrnRH/CCsWOFj6sCkG8tihFVuS3b8BLdFrLtO4LwQE0IKeXuoImbrRLucMKfzCS9KgfGtNOAzKFUuwzXPuyL3GYSkdzqqpX1kF8g6ecA3i4isg1IME4VlS1Dw7VQNWQWUpzc+SChfZr66p1kWuaQmFrjspNCwlcDjTP3pXhMsTlU8kJPy5PTCD3LaTw==;
 5:KM52afWS5EpTsL+kuI5IxnN2sw3TUKj0mg4PDSbooY4qB96D3R5/E/7Gh6u0PI+FHR+DtH8zTaesO4WiF3EhV3TOi7/yf1Iud6m8CLIsl9vHmPAK8Xd70pm8chwR32XAhUKJ6xu89zMtnWIuU+Pw3cEdQqTLVLpNt3OaRB/wiIzphVXwqYGQjGklw4J5I6tmNV9s53px3mQpsr+KY7J2wA==;
 7:lJaT8baSTzHrgiqrt0H4TB64MaGx9y+ZhkCfPNcpyl7qOCTGDLXwnYzv5AY6DZgY1rTVRyTPdC2rYsqQYm98aXeXRo6BxDWkCk7hdTYLBgsrZsQt5FDIwFufqTKhqIrGOEV3kE+Bh3/ifm4I1PgaJQ==
x-ms-office365-filtering-correlation-id: 4abe4320-32ed-40cc-4051-08d68b52bdc9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0401MB2030; 
x-ms-traffictypediagnostic: VI1PR0401MB2030:
x-microsoft-antispam-prvs: <VI1PR0401MB2030C3E9E2DA36FF97BF1B90F16E0@VI1PR0401MB2030.eurprd04.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(376002)(366004)(136003)(346002)(199004)(189003)(25786009)(8676002)(2906002)(26005)(14454004)(102836004)(386003)(6506007)(99286004)(6436002)(6486002)(6512007)(4326008)(8936002)(71190400001)(81166006)(81156014)(71200400001)(256004)(105586002)(76176011)(36756003)(106356001)(52116002)(486006)(6116002)(3846002)(44832011)(446003)(7736002)(110136005)(11346002)(476003)(2616005)(68736007)(316002)(86362001)(53936002)(186003)(1076003)(50226002)(305945005)(478600001)(97736004)(54906003)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB2030;
 H:VI1PR0401MB2496.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7yvEOBh9QCi3nWo69VZKn7pQkYO3rW7SdC54hELr4CL00yqz9tGkuyDulGS9c61N9vUqEEjSPfdH6iTIdscStsX3ddvDkMK3s5C8x1pN/umpCJ61lfhj7fjcEh+hl/377RIdibeXLiwJdFj6dyeobKTeQeIy4cN/CtGyJqmDX0P44/fVCFivhlCCgEvLyX6lDsWPHtaOgalSSZnfp+eTn7RJBm41ko+ruh6kd/RF5le73Pcpl+Y9iVw0Ezmft5kubBZgs44mJbVbEkQn5au6pDhTppgyflIAVlOxt3a/gwEdo2ikJyznivuDIjLhLTweRG/KmdYPcv8MTWEtlLG21Dgbslm+9vGflBq2NJuOyCku555CWPU+pSQcQD87AOYxeMoCmzdBqVgXegSJm/OLqCawRfx+iPpCmbKCgLXZWAQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31172365421942458B85A799827935AC@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abe4320-32ed-40cc-4051-08d68b52bdc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 10:14:39.3594 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2030
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
Cc: "open list : OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
 Pankaj Bansal <pankaj.bansal@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

YW4gRlBHQS1iYXNlZCBzeXN0ZW0gY29udHJvbGxlciwgY2FsbGVkIOKAnFFpeGlz4oCdLCB3aGlj
aA0KbWFuYWdlcyBzZXZlcmFsIGNyaXRpY2FsIHN5c3RlbSBmZWF0dXJlcywgaW5jbHVkaW5nOg0K
4oCiIFJlc2V0IHNlcXVlbmNpbmcNCuKAoiBQb3dlciBzdXBwbHkgY29uZmlndXJhdGlvbg0K4oCi
IEJvYXJkIGNvbmZpZ3VyYXRpb24NCuKAoiBoYXJkd2FyZSBjb25maWd1cmF0aW9uDQoNClRoZSBx
aXhpcyByZWdpc3RlcnMgYXJlIGFjY2Vzc2libGUgb3ZlciBvbmUgb3IgbW9yZSBzeXN0ZW0tc3Bl
Y2lmaWMNCmludGVyZmFjZXMsIHR5cGljYWxseSBJMkMsIEpUQUcgb3IgYW4gZW1iZWRkZWQgcHJv
Y2Vzc29yLg0KDQpTaWduZWQtb2ZmLWJ5OiBQYW5rYWogQmFuc2FsIDxwYW5rYWouYmFuc2FsQG54
cC5jb20+DQotLS0NCg0KTm90ZXM6DQogICAgVjQ6DQogICAgLSBObyBDaGFuZ2UNCiAgICBWMzoN
CiAgICAtIEFkZGVkIGJvYXJkbmFtZSBiYXNlZCBjb21wYXRpYmxlIGZpZWxkIGluIGJpbmRpbmdz
DQogICAgLSBBZGRlZCBiaW5kaW5ncyBmb3IgTU1JTyBiYXNlZCBGUEdBDQogICAgVjI6DQogICAg
LSBObyBjaGFuZ2UNCg0KIC4uLi9iaW5kaW5ncy9zb2MvZnNsL3FpeGlzX2N0cmwudHh0ICAgICAg
ICAgIHwgNTMgKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDUzIGluc2VydGlv
bnMoKykNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
b2MvZnNsL3FpeGlzX2N0cmwudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NvYy9mc2wvcWl4aXNfY3RybC50eHQNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAw
MDAwMDAwMDAuLjVkNTEwZGYxNGJlOA0KLS0tIC9kZXYvbnVsbA0KKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9mc2wvcWl4aXNfY3RybC50eHQNCkBAIC0wLDAgKzEs
NTMgQEANCisqIFFJWElTIEZQR0EgYmxvY2sNCisNCithbiBGUEdBLWJhc2VkIHN5c3RlbSBjb250
cm9sbGVyLCBjYWxsZWQg4oCcUWl4aXPigJ0sIHdoaWNoDQorbWFuYWdlcyBzZXZlcmFsIGNyaXRp
Y2FsIHN5c3RlbSBmZWF0dXJlcywgaW5jbHVkaW5nOg0KK+KAoiBDb25maWd1cmF0aW9uIHN3aXRj
aCBtb25pdG9yaW5nDQor4oCiIFBvd2VyIG9uL29mZiBzZXF1ZW5jaW5nDQor4oCiIFJlc2V0IHNl
cXVlbmNpbmcNCivigKIgUG93ZXIgc3VwcGx5IGNvbmZpZ3VyYXRpb24NCivigKIgQm9hcmQgY29u
ZmlndXJhdGlvbg0KK+KAoiBoYXJkd2FyZSBjb25maWd1cmF0aW9uDQor4oCiIEJhY2tncm91bmQg
cG93ZXIgZGF0YSBjb2xsZWN0aW9uIChEQ00pDQor4oCiIEZhdWx0IG1vbml0b3JpbmcNCivigKIg
UkNXIGJ5cGFzcyBTUkFNIChyZXBsYWNlIGZsYXNoIFJDVyB3aXRoIGludGVybmFsIFJDVykgKE5P
UiBvbmx5KQ0KK+KAoiBEZWRpY2F0ZWQgZnVuY3Rpb25hbCB2YWxpZGF0aW9uIGJsb2NrcyAoUE9T
dC9JUlMsIHRyaWdnZXJlZCBldmVudCwgYW5kIHNvIG9uKQ0KK+KAoiBJMkMgbWFzdGVyIGZvciBy
ZW1vdGUgYm9hcmQgY29udHJvbCBldmVuIHdpdGggbm8gRFVUIGF2YWlsYWJsZQ0KKw0KK1RoZSBx
aXhpcyByZWdpc3RlcnMgYXJlIGFjY2Vzc2libGUgb3ZlciBvbmUgb3IgbW9yZSBzeXN0ZW0tc3Bl
Y2lmaWMgaW50ZXJmYWNlcywNCit0eXBpY2FsbHkgSTJDLCBKVEFHIG9yIGFuIGVtYmVkZGVkIHBy
b2Nlc3Nvci4NCisNCitGUEdBIGNvbm5lY3RlZCB0byBJMkM6DQorUmVxdWlyZWQgcHJvcGVydGll
czoNCisNCisgLSBjb21wYXRpYmxlOiBzaG91bGQgYmUgYSBib2FyZC1zcGVjaWZpYyBzdHJpbmcg
Zm9sbG93ZWQgYnkgYSBzdHJpbmcNCisgICBpbmRpY2F0aW5nIHRoZSB0eXBlIG9mIEZQR0EuICBF
eGFtcGxlOg0KKwkiZnNsLDxib2FyZD4tZnBnYSIsICJmc2wsZnBnYS1xaXhpcy1pMmMiDQorIC0g
cmVnIDogaTJjIGFkZHJlc3Mgb2YgdGhlIHFpeGlzIGRldmljZS4NCisNCitFeGFtcGxlIChMWDIx
NjBBLVFEUyk6DQorCS8qIFRoZSBGUEdBIG5vZGUgKi8NCisgICAgICAgIGZwZ2FANjYgew0KKwkJ
Y29tcGF0aWJsZSA9ICJmc2wsbHgyMTYwYXFkcy1mcGdhIiwgImZzbCxmcGdhLXFpeGlzLWkyYyI7
DQorCQlyZWcgPSA8MHg2Nj47DQorCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCisJCSNzaXplLWNl
bGxzID0gPDA+Ow0KKwl9DQorDQorKiBGcmVlc2NhbGUgb24tYm9hcmQgRlBHQQ0KKw0KK1RoaXMg
aXMgdGhlIG1lbW9yeS1tYXBwZWQgcmVnaXN0ZXJzIGZvciBvbiBib2FyZCBGUEdBLg0KKw0KK1Jl
cXVpcmVkIHByb3BlcnRpZXM6DQorLSBjb21wYXRpYmxlOiBzaG91bGQgYmUgYSBib2FyZC1zcGVj
aWZpYyBzdHJpbmcgZm9sbG93ZWQgYnkgYSBzdHJpbmcNCisgIGluZGljYXRpbmcgdGhlIHR5cGUg
b2YgRlBHQS4gIEV4YW1wbGU6DQorCSJmc2wsPGJvYXJkPi1mcGdhIiwgImZzbCxmcGdhLXFpeGlz
Ig0KKy0gcmVnOiBzaG91bGQgY29udGFpbiB0aGUgYWRkcmVzcyBhbmQgdGhlIGxlbmd0aCBvZiB0
aGUgRlBHQSByZWdpc3RlciBzZXQuDQorDQorRXhhbXBsZSAoTFMyMDgwQS1SREIpOg0KKw0KKyAg
ICAgICAgY3BsZEAzLDAgew0KKyAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImZzbCxsczIw
ODBhcmRiLWZwZ2EiLCAiZnNsLGZwZ2EtcWl4aXMiOw0KKyAgICAgICAgICAgICAgICByZWcgPSA8
MHgzIDAgMHgxMDAwMD47DQorICAgICAgICB9Ow0KKw0KLS0gDQoyLjE3LjENCg0K

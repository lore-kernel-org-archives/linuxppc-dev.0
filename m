Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC930C282D7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 11:40:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5957A2175B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 11:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MTWYbjJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5957A2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qLyT5NGjzDqV3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 22:40:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.54; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=pankaj.bansal@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="MTWYbjJE"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00054.outbound.protection.outlook.com [40.107.0.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qLqy6n5vzDqTL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 22:34:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZitJBQAwDO8twr25Y+e1tdi/8c/wJPksyOEI+RP4og0=;
 b=MTWYbjJE25cW6YyNZE9qUjFbGmCvy67JsyFkiPRoRf/9dNhQ7hZeJ4HIgk/GyAiy9RN78/TTchwsOenUZa7WVTTubtErwjrOCTEj9lsO0T+RE075UkB8Rt1r4dlO+tSJaKafzbsQ+mtrmynUHUqeGXLjtBOHTKBnNjcQybGJ8hM=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2509.eurprd04.prod.outlook.com (10.168.65.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Wed, 30 Jan 2019 11:34:29 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe%8]) with mapi id 15.20.1558.023; Wed, 30 Jan 2019
 11:34:29 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: Leo Li <leoyang.li@nxp.com>
Subject: [PATCH v2 1/2] dt-bindings: soc: fsl: Document Qixis FPGA usage
Thread-Topic: [PATCH v2 1/2] dt-bindings: soc: fsl: Document Qixis FPGA usage
Thread-Index: AQHUuI/CnulVew1FE06wfvNuXyQiJw==
Date: Wed, 30 Jan 2019 11:34:28 +0000
Message-ID: <20190130165916.8628-2-pankaj.bansal@nxp.com>
References: <20190130165916.8628-1-pankaj.bansal@nxp.com>
In-Reply-To: <20190130165916.8628-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR01CA0111.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::27)
 To VI1PR0401MB2496.eurprd04.prod.outlook.com
 (2603:10a6:800:56::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [92.120.1.69]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0401MB2509;
 6:UW3PqyycvmJlWgyLEfEG7Yp2sb2ozim8pR+jArH4s7eG4u8OhxMxVVw/QS9h0Wmg8LWSwmn31QZRXvFFkAcFXUFHOVd8L2Tk3W1ZDXAd1HXKzkaLLZEBMaVV7PPmU+bpO1yBoZrRsy7AcmvrTAZzENhdWNKgXforWecBdCyVcnHqVulAe/T95pYfQRt7gvbz2+WkXFaKXPjMUrhdtLxHULoNZ+4Tcn/IJc+/cWVFEdBSBJm1Q79jsEC8K+zVLOjd/bMAKRBLNLaO+YCuNn3gPyCx8XHhV2OcpzgP4omvUkh8KNx7biyO74mpDs7IZoFCXbI9/OOa4/gFuepPfun5auVivbTCdEuKlkzexw2R6fobQ5YE5MKSc8GM6+ZoorLOnJdDuDbNnvr2y6GpTSmSUZdnXOWbIvlc69nMKBKlPgfBo657ADFXjXi0iPGV286hrbUyKg+w3gsmNgy5tpkPfA==;
 5:ac/kuvEiWfF7NkTUOC5GTW1RY4WJ0XIrJC5nhOPisUb08gRskBA+JKmHQfBQlesVOs36RP9qO6dVBsBWy4FWQZ7qUl06JQGHgPYH9TJ5uL1+/mUrWYVmtaopzpRiERmDdI/Qmnbqr04pt97NIOGH/7n/+3/NRBJRp8SPcIXeT5M6pF+EQlL9GFc+qhdfgFxt4tlslh2UmKi3EWhAad0WHQ==;
 7:5q98QI8YBuoFcaQnMkkb4jLstcADK6rUzbDHnpDgxZCgm+tPsbFukXN9bJi6T2Sc1nx5y3n7TwdtZH5JzUO1sM7xSPwEd7JFapsJqZRENl8Zs88YgJpnNcoWMJmAg0ZoUhSKydXbjNxcCpaNeBMdUw==
x-ms-office365-filtering-correlation-id: 3aa793cd-d0b6-4bb4-ee5b-08d686a6e52a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0401MB2509; 
x-ms-traffictypediagnostic: VI1PR0401MB2509:
x-microsoft-antispam-prvs: <VI1PR0401MB2509855A84B1481C9F7A5604F1900@VI1PR0401MB2509.eurprd04.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(366004)(396003)(136003)(346002)(376002)(189003)(199004)(2906002)(105586002)(8676002)(478600001)(26005)(25786009)(97736004)(6636002)(54906003)(106356001)(6506007)(386003)(3846002)(316002)(102836004)(37006003)(14454004)(81166006)(81156014)(6116002)(36756003)(6486002)(6512007)(256004)(50226002)(7736002)(44832011)(1076003)(71190400001)(8936002)(68736007)(6436002)(66066001)(71200400001)(11346002)(99286004)(86362001)(4326008)(186003)(53936002)(446003)(486006)(2616005)(6862004)(52116002)(476003)(76176011)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB2509;
 H:VI1PR0401MB2496.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qCWzcqQhbmYoQkVVuxSXVrCt+kYlCSUVq2tcpGJdQ8A4VoK0Nbm2Fk0/AvJXp/Sn5vQYTYZVOFiLxZyOTekkXcBIeIg1TvxghFTF+rL2dRB1aEfTvXyWy3dtB7TYFJ3Ndtd5ew9sXNdgmyjjBR/9FKK/m1bWk//iHhoydoqWHhbJCBJkIfZt2bRqmfCUK/zgosBJudtEHWOvCnZOUZhii6k5O/7nVg7Tq4TW06g985+XMkfDWasPOcaLOZP0O6s/Avk0WCjQPcYfq0udud3iTkDLuByib8tl8XJ4QeT2iJ8B9g2mLjK6gjxspusMMdB+3DEKDVafK6gjXIwTYsPr6YLJpKmJNfaXw0/B6WmfjOygQw9Jh/aJLj0MUIwEpphWs3EALKVp8XcBo7CLIqPCNUcwt4dRwayTLG9f+FbVdO4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3A9734DF42D4C4996843DB557859D99@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa793cd-d0b6-4bb4-ee5b-08d686a6e52a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 11:34:27.7774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2509
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
Cc: Pankaj Bansal <pankaj.bansal@nxp.com>,
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
cC5jb20+DQotLS0NCg0KTm90ZXM6DQogICAgVjI6DQogICAgLSBObyBjaGFuZ2UNCg0KIC4uLi9i
aW5kaW5ncy9zb2MvZnNsL3FpeGlzX2N0cmwudHh0ICAgICAgICAgIHwgMzMgKysrKysrKysrKysr
KysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvZnNsL3FpeGlzX2N0cmwudHh0
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9mc2wvcWl4aXNfY3RybC50
eHQNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwMDAwMDAuLmJjMjk1MGNhYjcx
ZA0KLS0tIC9kZXYvbnVsbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NvYy9mc2wvcWl4aXNfY3RybC50eHQNCkBAIC0wLDAgKzEsMzMgQEANCisqIFFJWElTIEZQR0Eg
YmxvY2sNCisNCithbiBGUEdBLWJhc2VkIHN5c3RlbSBjb250cm9sbGVyLCBjYWxsZWQg4oCcUWl4
aXPigJ0sIHdoaWNoDQorbWFuYWdlcyBzZXZlcmFsIGNyaXRpY2FsIHN5c3RlbSBmZWF0dXJlcywg
aW5jbHVkaW5nOg0KK+KAoiBDb25maWd1cmF0aW9uIHN3aXRjaCBtb25pdG9yaW5nDQor4oCiIFBv
d2VyIG9uL29mZiBzZXF1ZW5jaW5nDQor4oCiIFJlc2V0IHNlcXVlbmNpbmcNCivigKIgUG93ZXIg
c3VwcGx5IGNvbmZpZ3VyYXRpb24NCivigKIgQm9hcmQgY29uZmlndXJhdGlvbg0KK+KAoiBoYXJk
d2FyZSBjb25maWd1cmF0aW9uDQor4oCiIEJhY2tncm91bmQgcG93ZXIgZGF0YSBjb2xsZWN0aW9u
IChEQ00pDQor4oCiIEZhdWx0IG1vbml0b3JpbmcNCivigKIgUkNXIGJ5cGFzcyBTUkFNIChyZXBs
YWNlIGZsYXNoIFJDVyB3aXRoIGludGVybmFsIFJDVykgKE5PUiBvbmx5KQ0KK+KAoiBEZWRpY2F0
ZWQgZnVuY3Rpb25hbCB2YWxpZGF0aW9uIGJsb2NrcyAoUE9TdC9JUlMsIHRyaWdnZXJlZCBldmVu
dCwgYW5kIHNvIG9uKQ0KK+KAoiBJMkMgbWFzdGVyIGZvciByZW1vdGUgYm9hcmQgY29udHJvbCBl
dmVuIHdpdGggbm8gRFVUIGF2YWlsYWJsZQ0KKw0KK1RoZSBxaXhpcyByZWdpc3RlcnMgYXJlIGFj
Y2Vzc2libGUgb3ZlciBvbmUgb3IgbW9yZSBzeXN0ZW0tc3BlY2lmaWMgaW50ZXJmYWNlcywNCit0
eXBpY2FsbHkgSTJDLCBKVEFHIG9yIGFuIGVtYmVkZGVkIHByb2Nlc3Nvci4NCisNCitSZXF1aXJl
ZCBwcm9wZXJ0aWVzOg0KKw0KKyAtIGNvbXBhdGlibGUgOiBzdHJpbmcsIG11c3QgY29udGFpbiAi
ZnNsLGZwZ2EtcWl4aXMtaTJjIg0KKyAtIHJlZyA6IGkyYyBhZGRyZXNzIG9mIHRoZSBxaXhpcyBk
ZXZpY2UuDQorDQorRXhhbXBsZXM6DQorCS8qIFRoZSBGUEdBIG5vZGUgKi8NCisgICAgICAgIGZw
Z2FANjYgew0KKwkJY29tcGF0aWJsZSA9ICJmc2wsbHgyMTYwYXFkcy1mcGdhIiwgImZzbCxmcGdh
LXFpeGlzLWkyYyI7DQorCQlyZWcgPSA8MHg2Nj47DQorCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsN
CisJCSNzaXplLWNlbGxzID0gPDA+Ow0KKwl9DQorDQotLSANCjIuMTcuMQ0KDQo=

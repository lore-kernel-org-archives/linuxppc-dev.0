Return-Path: <SRS0=X2ql=PB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179D5C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Dec 2018 03:44:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 456F4214C6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Dec 2018 03:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VhLhtYXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456F4214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43NQ8s4NdwzDqbB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Dec 2018 14:44:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="VhLhtYXw";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.4.63; helo=eur03-db5-obe.outbound.protection.outlook.com;
 envelope-from=peng.ma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="VhLhtYXw"; 
 dkim-atps=neutral
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr40063.outbound.protection.outlook.com [40.107.4.63])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43NQ635XCKzDqNj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Dec 2018 14:42:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7TA0u+61QSUpdMlrDw1pTolITQL7TleRN+mS5H5SxQ=;
 b=VhLhtYXwd8QsQjmesAFaHTikvAfwqci54VsPh8SyBVkgvvQltTojEbeOlGpDYaPwcLlSKFVMPx/uGBh9JXuwZ4nfkhKuX7Yvam/+KnASS9nq6TdngaJ50/U25HAime2qhPPd4T7AtafMrsuPBDqucg3T39aCXTcTHkhreAc3EE0=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.159) by
 VI1SPR8PMB97.eurprd04.prod.outlook.com (10.166.198.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Mon, 24 Dec 2018 03:42:09 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::9d3c:74fa:d05e:beca]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::9d3c:74fa:d05e:beca%4]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 03:42:09 +0000
From: Peng Ma <peng.ma@nxp.com>
To: Scott Wood <oss@buserror.net>, Leo Li <leoyang.li@nxp.com>, Zhang Wei
 <zw@zh-kernel.org>
Subject: RE: [PATCH] dmaengine: fsldma: Add 64-bit I/O accessors for powerpc64
Thread-Topic: [PATCH] dmaengine: fsldma: Add 64-bit I/O accessors for powerpc64
Thread-Index: AQHUma+xGuaZ+ksRL0q+1ylDeGrWfKWNQCqg
Date: Mon, 24 Dec 2018 03:42:09 +0000
Message-ID: <VI1PR04MB443154AEE42853B62234075EEDBB0@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20181222043445.GA29462@home.buserror.net>
In-Reply-To: <20181222043445.GA29462@home.buserror.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1SPR8PMB97;
 6:hmMhftUnVJ15qzylpnDX0/TxtpPyRFmrX0CJJIhLHBJkHQdYdiKavbfrskn13gIBBTCqTkY7juU+arMWXBvHxYuM5OeLF/lhl1JhotgjK/Rga4aAl5fBZPdM11w2dmUk/wQtoVDdkgWo/O4I/b7CPb+8rn9btAZys7pzV9YlP+3I3stRj7jC2sSKcWuC7OkWueUhN1GRHlNFJNL4b3fD5dIWt0QlNfjjrU7FWye8vshXcd0bCrM+Peq3GmtOB4FIgCwMIYr+YYOh91fIb3wRuCZWG9KHedF1/Sow6Gxfv32AZ3rVL8Vk3UCVaoJaiWvV0z6WnjPW6QRo3WZmg48VjOClv3OkX9528TrhaTPHrNaqPa1wSype+Ez2i+f5BUBk1LHO8ATkOXD2sp6TB5emTeZWm+vNXwyttYPdrrYS8hg7sUZWOvpGx4qK9ruiISImAxhJVPTNUtzTS9NRwhYpQg==;
 5:aWbBvQULMa6mHK9xVREa51RQhgW5GCmWdN5B3zwtTSYSRK5S1jGsqacDBpEjNlWbRBLSl2nOyFE7w2Anfy7+P+HxDm9vsZIDNm/MTKb75uvYEMycfS3RZVx+OvlfzTgPQ+fEpP1txw0h2JiXhDXrW6g76uBcxdeMY5M1xqXgccU=;
 7:tRDEOaOe74WMzYo3djAT5LIrysrLAheih4RnoqQQCcWmlDUv+ufwhtqfS/kAk8SXG+aDc/nEULmDBlG51fIfxVj+Keex9Ni6dzP6na52zHAKuB6UImEL09DC5tl4yN6SqD9SR3YjpXCqqyvX1HllmA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a3375c4c-a532-4e2a-2ef4-08d66951c868
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1SPR8PMB97; 
x-ms-traffictypediagnostic: VI1SPR8PMB97:
x-microsoft-antispam-prvs: <VI1SPR8PMB97951F299122DA9D66B9B3EDBB0@VI1SPR8PMB97.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:VI1SPR8PMB97; BCL:0; PCL:0; RULEID:; SRVR:VI1SPR8PMB97; 
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(396003)(136003)(346002)(366004)(39860400002)(13464003)(189003)(199004)(8936002)(7736002)(102836004)(6506007)(26005)(14444005)(105586002)(186003)(55016002)(25786009)(6246003)(305945005)(14454004)(256004)(66066001)(110136005)(44832011)(6436002)(4326008)(81156014)(76176011)(81166006)(486006)(33656002)(3846002)(6116002)(9686003)(8676002)(54906003)(7696005)(106356001)(99286004)(53936002)(5660300001)(71200400001)(71190400001)(316002)(11346002)(2906002)(229853002)(446003)(74316002)(478600001)(86362001)(68736007)(97736004)(476003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1SPR8PMB97;
 H:VI1PR04MB4431.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eiZPujYmId8/r6Zl73lep8MViGTrhEHTm8ZhLZzHrUAS+QYDShtOwPor9v8eLmkgM4E8ztgJ91tmIFUWBlFgzFxxSTx0qYLcrBfjsbU9ihTk3bGbek48U0ORv9UrF7HUk7uVj7PRG4bDcV8XMw0zHUCX+FsoTRC/goTBrUwjKC9I36MAWc29SNZKxbk8yjf01ayy99s8jc4gyPtCFv4hEHXlOLhdN0sSfNLCmofnG4jlOdxTUaIq81CH8R+opEWOX3XCCsLK+HYQ0VLACMpEpbGvVPNq9a5OyAFOJUnksvaDWJBEYnn3baev5gE9H6W2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3375c4c-a532-4e2a-2ef4-08d66951c868
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 03:42:09.3100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1SPR8PMB97
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
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 Wen He <wen.he_1@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgU2NvdHQsDQoNCllvdSBhcmUgcmlnaHQsIHdlIHNob3VsZCBzdXBwb3J0IHBvd2VycGM2NCwg
c28gY291bGQgSSBjaGFuZ2VkIGl0IGFzIGZhbGxvd3M6DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2RtYS9mc2xkbWEuaCBiL2RyaXZlcnMvZG1hL2ZzbGRtYS5oDQppbmRleCA4OGRiOTM5Li4wNTdi
YWJmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9kbWEvZnNsZG1hLmgNCisrKyBiL2RyaXZlcnMvZG1h
L2ZzbGRtYS5oDQpAQCAtMjAyLDM1ICsyMDIsMTAgQEAgc3RydWN0IGZzbGRtYV9jaGFuIHsNCiAj
ZGVmaW5lIGZzbF9pb3dyaXRlMzIodiwgcCkgICAgb3V0X2xlMzIocCwgdikNCiAjZGVmaW5lIGZz
bF9pb3dyaXRlMzJiZSh2LCBwKSAgb3V0X2JlMzIocCwgdikNCiANCi0jaWZuZGVmIF9fcG93ZXJw
YzY0X18NCi1zdGF0aWMgdTY0IGZzbF9pb3JlYWQ2NChjb25zdCB1NjQgX19pb21lbSAqYWRkcikN
Ci17DQotICAgICAgIHUzMiBmc2xfYWRkciA9IGxvd2VyXzMyX2JpdHMoYWRkcik7DQotICAgICAg
IHU2NCBmc2xfYWRkcl9oaSA9ICh1NjQpaW5fbGUzMigodTMyICopKGZzbF9hZGRyICsgMSkpIDw8
IDMyOw0KLQ0KLSAgICAgICByZXR1cm4gZnNsX2FkZHJfaGkgfCBpbl9sZTMyKCh1MzIgKilmc2xf
YWRkcik7DQotfQ0KLQ0KLXN0YXRpYyB2b2lkIGZzbF9pb3dyaXRlNjQodTY0IHZhbCwgdTY0IF9f
aW9tZW0gKmFkZHIpDQotew0KLSAgICAgICBvdXRfbGUzMigodTMyIF9faW9tZW0gKilhZGRyICsg
MSwgdmFsID4+IDMyKTsNCi0gICAgICAgb3V0X2xlMzIoKHUzMiBfX2lvbWVtICopYWRkciwgKHUz
Mil2YWwpOw0KLX0NCi0NCi1zdGF0aWMgdTY0IGZzbF9pb3JlYWQ2NGJlKGNvbnN0IHU2NCBfX2lv
bWVtICphZGRyKQ0KLXsNCi0gICAgICAgdTMyIGZzbF9hZGRyID0gbG93ZXJfMzJfYml0cyhhZGRy
KTsNCi0gICAgICAgdTY0IGZzbF9hZGRyX2hpID0gKHU2NClpbl9iZTMyKCh1MzIgKilmc2xfYWRk
cikgPDwgMzI7DQotDQotICAgICAgIHJldHVybiBmc2xfYWRkcl9oaSB8IGluX2JlMzIoKHUzMiAq
KShmc2xfYWRkciArIDEpKTsNCi19DQotDQotc3RhdGljIHZvaWQgZnNsX2lvd3JpdGU2NGJlKHU2
NCB2YWwsIHU2NCBfX2lvbWVtICphZGRyKQ0KLXsNCi0gICAgICAgb3V0X2JlMzIoKHUzMiBfX2lv
bWVtICopYWRkciwgdmFsID4+IDMyKTsNCi0gICAgICAgb3V0X2JlMzIoKHUzMiBfX2lvbWVtICop
YWRkciArIDEsICh1MzIpdmFsKTsNCi19DQotI2VuZGlmDQorI2RlZmluZSBmc2xfaW9yZWFkNjQo
cCkgICAgICAgICAgICAgICAgaW5fbGU2NChwKQ0KKyNkZWZpbmUgZnNsX2lvcmVhZDY0YmUocCkg
ICAgICBpbl9iZTY0KHApDQorI2RlZmluZSBmc2xfaW93cml0ZTY0KHYsIHApICAgIG91dF9sZTY0
KHAsIHYpDQorI2RlZmluZSBmc2xfaW93cml0ZTY0YmUodiwgcCkgIG91dF9iZTY0KHAsIHYpDQog
I2VuZGlmDQoNCkJlc3QgUmVnYXJkcywNClBlbmcNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPkZyb206IFNjb3R0IFdvb2QgPG9zc0BidXNlcnJvci5uZXQ+DQo+U2VudDogMjAxOMTqMTLU
wjIyyNUgMTI6MzUNCj5UbzogTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+OyBaaGFuZyBXZWkg
PHp3QHpoLWtlcm5lbC5vcmc+DQo+Q2M6IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBk
bWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOyBQZW5nIE1hDQo+PHBlbmcubWFAbnhwLmNvbT47IFdl
biBIZSA8d2VuLmhlXzFAbnhwLmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0hdIGRtYWVuZ2luZTogZnNs
ZG1hOiBBZGQgNjQtYml0IEkvTyBhY2Nlc3NvcnMgZm9yIHBvd2VycGM2NA0KPg0KPk90aGVyd2lz
ZSA2NC1iaXQgUFBDIGJ1aWxkcyBmYWlsIHdpdGggdW5kZWZpbmVkIHJlZmVyZW5jZXMgdG8gdGhl
c2UgYWNjZXNzb3JzLg0KPg0KPkNjOiBQZW5nIE1hIDxwZW5nLm1hQG54cC5jb20+DQo+Q2M6IFdl
biBIZSA8d2VuLmhlXzFAbnhwLmNvbT4NCj5GaXhlczogNjg5OTdmZmY5NGFmYSAoIiBkbWFlbmdp
bmU6IGZzbGRtYTogQWRkaW5nIG1hY3JvIEZTTF9ETUFfSU4vT1VUDQo+aW1wbGVtZW50IGZvciBB
Uk0gcGxhdGZvcm0iKQ0KPlNpZ25lZC1vZmYtYnk6IFNjb3R0IFdvb2QgPG9zc0BidXNlcnJvci5u
ZXQ+DQo+LS0tDQo+SXMgdGhlcmUgYW55IHJlYXNvbiB3aHkgaW9yZWFkWFhiZSgpIGV0YyBjYW4n
dCBiZSB1c2VkIG9uIFBQQyBhcyB3ZWxsPw0KPg0KPiBkcml2ZXJzL2RtYS9mc2xkbWEuaCB8IDcg
KysrKysrLQ0KPiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+DQo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2ZzbGRtYS5oIGIvZHJpdmVycy9kbWEvZnNs
ZG1hLmggaW5kZXgNCj44OGRiOTM5YzA0YTEuLmE5YjEyZjgyYjVjMyAxMDA2NDQNCj4tLS0gYS9k
cml2ZXJzL2RtYS9mc2xkbWEuaA0KPisrKyBiL2RyaXZlcnMvZG1hL2ZzbGRtYS5oDQo+QEAgLTIw
Miw3ICsyMDIsMTIgQEAgc3RydWN0IGZzbGRtYV9jaGFuIHsNCj4gI2RlZmluZSBmc2xfaW93cml0
ZTMyKHYsIHApCW91dF9sZTMyKHAsIHYpDQo+ICNkZWZpbmUgZnNsX2lvd3JpdGUzMmJlKHYsIHAp
CW91dF9iZTMyKHAsIHYpDQo+DQo+LSNpZm5kZWYgX19wb3dlcnBjNjRfXw0KPisjaWZkZWYgX19w
b3dlcnBjNjRfXw0KPisjZGVmaW5lIGZzbF9pb3JlYWQ2NChwKQkJaW5fbGU2NChwKQ0KPisjZGVm
aW5lIGZzbF9pb3JlYWQ2NGJlKHApCWluX2JlNjQocCkNCj4rI2RlZmluZSBmc2xfaW93cml0ZTY0
KHYsIHApCW91dF9sZTY0KHAsIHYpDQo+KyNkZWZpbmUgZnNsX2lvd3JpdGU2NGJlKHYsIHApCW91
dF9iZTY0KHAsIHYpDQo+KyNlbHNlDQo+IHN0YXRpYyB1NjQgZnNsX2lvcmVhZDY0KGNvbnN0IHU2
NCBfX2lvbWVtICphZGRyKSAgew0KPiAJdTMyIGZzbF9hZGRyID0gbG93ZXJfMzJfYml0cyhhZGRy
KTsNCj4tLQ0KPjIuMTcuMQ0K

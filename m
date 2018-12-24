Return-Path: <SRS0=X2ql=PB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DB2C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Dec 2018 05:32:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 175932173C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Dec 2018 05:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kiWGHu5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175932173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43NSY603yJzDqT5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Dec 2018 16:32:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="kiWGHu5r";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.5.60; helo=eur03-ve1-obe.outbound.protection.outlook.com;
 envelope-from=peng.ma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="kiWGHu5r"; 
 dkim-atps=neutral
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50060.outbound.protection.outlook.com [40.107.5.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43NSVL5G7JzDqQb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Dec 2018 16:30:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5IgmV1vkDGAYuGANOPwxXrxWyz30AZD5XI0mSNDeGk=;
 b=kiWGHu5rEZhQoqdKVeOGaqF+nC+82TEHunpKFJRcnVWDi2OQ8IeNmyHg37BJjxtBqobmYRH1RQo8Aq0DZlHfWMPUD6NPqLY7weF+55GrkplmhuUpJThFDN0JDF7aGL9DiAYnc5JzHDimK3O2GfFh3UacIU8CtCiXO3bGvD27wlg=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.159) by
 VI1PR04MB1613.eurprd04.prod.outlook.com (10.164.84.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.21; Mon, 24 Dec 2018 05:29:54 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::9d3c:74fa:d05e:beca]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::9d3c:74fa:d05e:beca%4]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 05:29:54 +0000
From: Peng Ma <peng.ma@nxp.com>
To: Scott Wood <oss@buserror.net>, Leo Li <leoyang.li@nxp.com>, Zhang Wei
 <zw@zh-kernel.org>
Subject: RE: [PATCH] dmaengine: fsldma: Add 64-bit I/O accessors for powerpc64
Thread-Topic: [PATCH] dmaengine: fsldma: Add 64-bit I/O accessors for powerpc64
Thread-Index: AQHUma+xGuaZ+ksRL0q+1ylDeGrWfKWNQCqggAAThICAAAqV0A==
Date: Mon, 24 Dec 2018 05:29:54 +0000
Message-ID: <VI1PR04MB4431C33B5155312CF7035584EDBB0@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20181222043445.GA29462@home.buserror.net>
 <VI1PR04MB443154AEE42853B62234075EEDBB0@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <193b66f8bcc52c4900144b4cd742cacd001c9830.camel@buserror.net>
In-Reply-To: <193b66f8bcc52c4900144b4cd742cacd001c9830.camel@buserror.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB1613;
 6:h0eAtXnJ5SD4tNgPssbxvjPqtMDkPNGgHle8vs7Bc/OPT7WJih4VWH5FQlA/jekMUI5zPlPBy3U9mZQ1wkKFcB4HDnUX80gK37WpBAIOW3J0RdrTlaNlxTPxr3yNyzXyv46pxFyjgCOaeta8MaOY9xlvOM673nOSZXC2oQrf0KV5SIEXwb2sg2W7HPZBzdzxGzXGdLh6USXP6G1u5cGzpPOFfahOI6rNGigxIv61HWbpJjMHCsDI0z9qVYcDsvyRkFcXf8A4yG/PFpyhBfc5Pm9cczInxJLV9eXOxUt5TjPIYG1ZOIEf5GWjB1M+7m7xFqKjmrmS8U8SorZ/sj+Grs0P1yY14KeDqhFGeMyyS5rT3iymFwybl1gRujs6hAIqGnV0wGKQboxbwnTZg/W572ek+5Z7jg+NcJlxrO8arI7A8HfU3hhqmLaY7iw+EL0otj98HKZk70uHcNk6U/lsIw==;
 5:ONd3/sgR9mtQU6OoPKC1mBWrs8PnF1WUA0QRqdrndINXH5/qYp5XNeOBi+kk48eV2KnynpJDGIBvBIFC9RSCB9KitSsSsIrYEVuPdbQvvsT4mlEfBxT8QLY3d1ViWhYzugGO4BofyxsR30hIXnD29ftVAFz1AAMY5FJuGRA0yJ4=;
 7:jDcR1ZrYzvPH2eS+4jG8KVsBTxQVk3yFlEy1jO8y+SZh5WNRfY+m261VcYHgdOcq3txujmiaijNI9K4xgv63c4Lzc5fvkzsVqN3e5Fhw+arjPTRSFxHCmDmjp81OczqYaoZ0Z2JJMMYDX7KzJACKxA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 97e2426d-0b1e-45c9-3bac-08d66960d5c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB1613; 
x-ms-traffictypediagnostic: VI1PR04MB1613:
x-microsoft-antispam-prvs: <VI1PR04MB1613BAFB94CACA470E14C676EDBB0@VI1PR04MB1613.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB1613; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB1613; 
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(39860400002)(366004)(136003)(396003)(346002)(13464003)(199004)(189003)(54906003)(110136005)(106356001)(478600001)(7696005)(14454004)(33656002)(476003)(11346002)(229853002)(6506007)(446003)(486006)(76176011)(66066001)(6246003)(6436002)(44832011)(4326008)(25786009)(316002)(53936002)(9686003)(55016002)(71190400001)(71200400001)(74316002)(102836004)(7736002)(305945005)(6116002)(3846002)(8676002)(81166006)(2906002)(105586002)(8936002)(4001150100001)(26005)(97736004)(256004)(68736007)(99286004)(14444005)(5660300001)(186003)(86362001)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB1613;
 H:VI1PR04MB4431.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aNlyEFpBeR4Nk6VtL+W8qDRbUntb4AYbQH7tzs0tX1SxujKU+XXRfonIuGo1oGv2uxk0yJWabM71v0gD+12Uol3y/jlZClC1ppeCGhQOvZi70y5eZoM81fPaqOgwm15xRqzk2AUeDeqo47uThAqZb3a+D1iW7Qt0owYa76BapQ5IBZPTog8gFwhDdE5R9tA60MsfG6+gL6/W/oH0VGdryF9N4aL6VWjSmi9TKT6dfKpixDKTcoLHRfvJpuk1xB+eU8+yXXs4Y9hPEt8MR3ch8cDCGjLfCaKstzU6+aqZsTJnPpd+YcZBoQor92qHYsxv
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e2426d-0b1e-45c9-3bac-08d66960d5c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 05:29:54.2999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1613
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

SGkgU2NvdHQsDQoNCk9oLCBJIGRpZCBub3Qgc2VlIHRoZSBpbl9YWDY0L291dF9YWDY0IHN1cHBv
cnRlZCBvbmx5IF9fcG93ZXJwYzY0X18ganVzdCBub3cuDQpUaGFua3MgZm9yIHlvdXIgcmVtaW5k
ZXIuDQoNCiNpZmRlZiBfX3Bvd2VycGM2NF9fDQoNCiNpZmRlZiBfX0JJR19FTkRJQU5fXw0KREVG
X01NSU9fT1VUX0Qob3V0X2JlNjQsIDY0LCBzdGQpOw0KREVGX01NSU9fSU5fRChpbl9iZTY0LCA2
NCwgbGQpOw0KDQovKiBUaGVyZSBpcyBubyBhc20gaW5zdHJ1Y3Rpb25zIGZvciA2NCBiaXRzIHJl
dmVyc2UgbG9hZHMgYW5kIHN0b3JlcyAqLw0Kc3RhdGljIGlubGluZSB1NjQgaW5fbGU2NChjb25z
dCB2b2xhdGlsZSB1NjQgX19pb21lbSAqYWRkcikNCnsNCiAgICAgICAgcmV0dXJuIHN3YWI2NChp
bl9iZTY0KGFkZHIpKTsNCn0NCg0Kc3RhdGljIGlubGluZSB2b2lkIG91dF9sZTY0KHZvbGF0aWxl
IHU2NCBfX2lvbWVtICphZGRyLCB1NjQgdmFsKQ0Kew0KICAgICAgICBvdXRfYmU2NChhZGRyLCBz
d2FiNjQodmFsKSk7DQp9DQojZWxzZQ0KREVGX01NSU9fT1VUX0Qob3V0X2xlNjQsIDY0LCBzdGQp
Ow0KREVGX01NSU9fSU5fRChpbl9sZTY0LCA2NCwgbGQpOw0KDQovKiBUaGVyZSBpcyBubyBhc20g
aW5zdHJ1Y3Rpb25zIGZvciA2NCBiaXRzIHJldmVyc2UgbG9hZHMgYW5kIHN0b3JlcyAqLw0Kc3Rh
dGljIGlubGluZSB1NjQgaW5fYmU2NChjb25zdCB2b2xhdGlsZSB1NjQgX19pb21lbSAqYWRkcikN
CnsNCiAgICAgICAgcmV0dXJuIHN3YWI2NChpbl9sZTY0KGFkZHIpKTsNCn0NCg0Kc3RhdGljIGlu
bGluZSB2b2lkIG91dF9iZTY0KHZvbGF0aWxlIHU2NCBfX2lvbWVtICphZGRyLCB1NjQgdmFsKQ0K
ew0KICAgICAgICBvdXRfbGU2NChhZGRyLCBzd2FiNjQodmFsKSk7DQp9DQoNCiNlbmRpZg0KI2Vu
ZGlmIC8qIF9fcG93ZXJwYzY0X18gKi8NCg0KQmVzdCBSZWdhcmRzLA0KUGVuZw0KPi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogU2NvdHQgV29vZCA8b3NzQGJ1c2Vycm9yLm5ldD4N
Cj5TZW50OiAyMDE45bm0MTLmnIgyNOaXpSAxMjo0Ng0KPlRvOiBQZW5nIE1hIDxwZW5nLm1hQG54
cC5jb20+OyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47IFpoYW5nIFdlaQ0KPjx6d0B6aC1r
ZXJuZWwub3JnPg0KPkNjOiBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsgZG1hZW5naW5l
QHZnZXIua2VybmVsLm9yZzsgV2VuIEhlDQo+PHdlbi5oZV8xQG54cC5jb20+DQo+U3ViamVjdDog
UmU6IFtQQVRDSF0gZG1hZW5naW5lOiBmc2xkbWE6IEFkZCA2NC1iaXQgSS9PIGFjY2Vzc29ycyBm
b3INCj5wb3dlcnBjNjQNCj4NCj5PbiBNb24sIDIwMTgtMTItMjQgYXQgMDM6NDIgKzAwMDAsIFBl
bmcgTWEgd3JvdGU6DQo+PiBIaSBTY290dCwNCj4+DQo+PiBZb3UgYXJlIHJpZ2h0LCB3ZSBzaG91
bGQgc3VwcG9ydCBwb3dlcnBjNjQsIHNvIGNvdWxkIEkgY2hhbmdlZCBpdCBhcw0KPj4gZmFsbG93
czoNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvZnNsZG1hLmggYi9kcml2ZXJzL2Rt
YS9mc2xkbWEuaCBpbmRleA0KPj4gODhkYjkzOS4uMDU3YmFiZiAxMDA2NDQNCj4+IC0tLSBhL2Ry
aXZlcnMvZG1hL2ZzbGRtYS5oDQo+PiArKysgYi9kcml2ZXJzL2RtYS9mc2xkbWEuaA0KPj4gQEAg
LTIwMiwzNSArMjAyLDEwIEBAIHN0cnVjdCBmc2xkbWFfY2hhbiB7DQo+PiAgI2RlZmluZSBmc2xf
aW93cml0ZTMyKHYsIHApICAgIG91dF9sZTMyKHAsIHYpDQo+PiAgI2RlZmluZSBmc2xfaW93cml0
ZTMyYmUodiwgcCkgIG91dF9iZTMyKHAsIHYpDQo+Pg0KPj4gLSNpZm5kZWYgX19wb3dlcnBjNjRf
Xw0KPj4gLXN0YXRpYyB1NjQgZnNsX2lvcmVhZDY0KGNvbnN0IHU2NCBfX2lvbWVtICphZGRyKSAt
ew0KPj4gLSAgICAgICB1MzIgZnNsX2FkZHIgPSBsb3dlcl8zMl9iaXRzKGFkZHIpOw0KPj4gLSAg
ICAgICB1NjQgZnNsX2FkZHJfaGkgPSAodTY0KWluX2xlMzIoKHUzMiAqKShmc2xfYWRkciArIDEp
KSA8PCAzMjsNCj4+IC0NCj4+IC0gICAgICAgcmV0dXJuIGZzbF9hZGRyX2hpIHwgaW5fbGUzMigo
dTMyICopZnNsX2FkZHIpOw0KPj4gLX0NCj4+IC0NCj4+IC1zdGF0aWMgdm9pZCBmc2xfaW93cml0
ZTY0KHU2NCB2YWwsIHU2NCBfX2lvbWVtICphZGRyKSAtew0KPj4gLSAgICAgICBvdXRfbGUzMigo
dTMyIF9faW9tZW0gKilhZGRyICsgMSwgdmFsID4+IDMyKTsNCj4+IC0gICAgICAgb3V0X2xlMzIo
KHUzMiBfX2lvbWVtICopYWRkciwgKHUzMil2YWwpOw0KPj4gLX0NCj4+IC0NCj4+IC1zdGF0aWMg
dTY0IGZzbF9pb3JlYWQ2NGJlKGNvbnN0IHU2NCBfX2lvbWVtICphZGRyKSAtew0KPj4gLSAgICAg
ICB1MzIgZnNsX2FkZHIgPSBsb3dlcl8zMl9iaXRzKGFkZHIpOw0KPj4gLSAgICAgICB1NjQgZnNs
X2FkZHJfaGkgPSAodTY0KWluX2JlMzIoKHUzMiAqKWZzbF9hZGRyKSA8PCAzMjsNCj4+IC0NCj4+
IC0gICAgICAgcmV0dXJuIGZzbF9hZGRyX2hpIHwgaW5fYmUzMigodTMyICopKGZzbF9hZGRyICsg
MSkpOw0KPj4gLX0NCj4+IC0NCj4+IC1zdGF0aWMgdm9pZCBmc2xfaW93cml0ZTY0YmUodTY0IHZh
bCwgdTY0IF9faW9tZW0gKmFkZHIpIC17DQo+PiAtICAgICAgIG91dF9iZTMyKCh1MzIgX19pb21l
bSAqKWFkZHIsIHZhbCA+PiAzMik7DQo+PiAtICAgICAgIG91dF9iZTMyKCh1MzIgX19pb21lbSAq
KWFkZHIgKyAxLCAodTMyKXZhbCk7DQo+PiAtfQ0KPj4gLSNlbmRpZg0KPj4gKyNkZWZpbmUgZnNs
X2lvcmVhZDY0KHApICAgICAgICAgICAgICAgIGluX2xlNjQocCkNCj4+ICsjZGVmaW5lIGZzbF9p
b3JlYWQ2NGJlKHApICAgICAgaW5fYmU2NChwKQ0KPj4gKyNkZWZpbmUgZnNsX2lvd3JpdGU2NCh2
LCBwKSAgICBvdXRfbGU2NChwLCB2KQ0KPj4gKyNkZWZpbmUgZnNsX2lvd3JpdGU2NGJlKHYsIHAp
ICBvdXRfYmU2NChwLCB2KQ0KPj4gICNlbmRpZg0KPg0KPlRoZW4geW91J2xsIGJyZWFrIDMyLWJp
dCwgYXNzdW1pbmcgdGhvc2UgZmFrZS1pdC13aXRoLXR3by0zMi1iaXQtYWNjZXNzZXMNCj53ZXJl
IGFjdHVhbGx5IG5lZWRlZC4NCj4NCj4tU2NvdHQNCj4NCg0K

Return-Path: <SRS0=E5N6=QB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2D5C282C0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 05:56:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EF09218D2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 05:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ni6bV5Na"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF09218D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43m7YT5d2zzDqN9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 16:55:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.14.52; helo=eur01-ve1-obe.outbound.protection.outlook.com;
 envelope-from=peng.ma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="ni6bV5Na"; 
 dkim-atps=neutral
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr140052.outbound.protection.outlook.com [40.107.14.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43m7Wh1GvXzDqKv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 16:54:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9wHtQCnGgW7cIY2R3vheBGa1YYSBCtbLT5oUVLWEzg=;
 b=ni6bV5Nam1Oz72tYMGyCtSvRBbfHsS3pNDXhqweqGZ5sXoZL/3mYag2VrB/PTwWgHR9mpK2q+wR/B8MPX+zT07nqGWjv+sZtxgiGAqJ419T7w+974Z2ruhZplEmk5qAz1uCjTZpf//gnyfMVYEvSbILFz1noyj8WPG5oB4hYQ6E=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.159) by
 VI1PR04MB6157.eurprd04.prod.outlook.com (20.179.27.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Fri, 25 Jan 2019 05:54:15 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::558f:3cb4:9a6a:8f84]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::558f:3cb4:9a6a:8f84%4]) with mapi id 15.20.1558.021; Fri, 25 Jan 2019
 05:54:15 +0000
From: Peng Ma <peng.ma@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Subject: RE: [PATCH] dmaengine: fsldma: Add 64-bit I/O accessors for powerpc64
Thread-Topic: [PATCH] dmaengine: fsldma: Add 64-bit I/O accessors for powerpc64
Thread-Index: AQHUma+xGuaZ+ksRL0q+1ylDeGrWfKWNQCqggAAThICAAAqV0IApW8SAgAj0qfA=
Date: Fri, 25 Jan 2019 05:54:15 +0000
Message-ID: <VI1PR04MB44311D9A8F8CD3A0143BCC99ED9B0@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20181222043445.GA29462@home.buserror.net>
 <VI1PR04MB443154AEE42853B62234075EEDBB0@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <193b66f8bcc52c4900144b4cd742cacd001c9830.camel@buserror.net>
 <VI1PR04MB4431C33B5155312CF7035584EDBB0@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <20190119125841.GE4635@vkoul-mobl>
In-Reply-To: <20190119125841.GE4635@vkoul-mobl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB6157;
 6:jns0fR4RxP5IrZYivUlmTR8ZgNp+nLoGIjqX4lnImtMqet32YAlXF6+L117lLe2+OEMPyX5Rh0pauSDxN8crOU4BxL04CZWhDp8WZXgFBk4GV7Qr6S3UmUIIqRqRjLM4fO1cFGgOt7wkmvNmOLYyiELYqDsfG9d5T7E1gNesqw7eXpPKKwGqMu0c5/wCsuaqx2AB9xk/udFwkRBJHwdZv3shOK6lXFwI6LBZyBdNlT3yFCCEJkSpwC68Rv37JQrL3TrBaF6f1vmpWIAID69/g/od8Q/MF3+cUqvI7iJ5mMPT27+LBTWhjKcWZYCeqgXd4izFHTbpHapDhuJJr5z6vjTR6zrM5kdWxN8ukUWxp6XfnIKjTrxYBSpYaF8dumIdOJEfCRU3wQoEZpURK1CAFSAvebGoKewId9Arug8Pwj0+5eTNMfqduyilFvay8pFZk5bu3Nu/U0S7bf1eBMG3zg==;
 5:epnsm43FlJJfTq1wc/Mzmkv5htz5qS/PAKKD7YC0sA8Y3sesjEzwvP1h0Oi8lnb0DSoojegtiq6O1hhJt41IIk7j3thHSMT9jNdqMuoyKoS0M5IUreraA50lW7ZBgOYL/qVzuL3s9HADTr3YHQiUPyWOhMep9sjA7eATQEdjudTu4/GLFAWREqrPKfidvt447Z9DGommm9S681o5QG7qEg==;
 7:8ze36rfHOBe2+i/0lPaCx2yjBKq0eQ7L+AnznMWuIFWkVyqoGUHpSCh1qTunSsWqkp6TmWH1lykegMs32X/cbDGv6SXTZvpgkVT5OjpPjAIa2YiXeN9IhzWHCdqgkzpQl3NYtKZKrF/sOWSn4or7Hw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d9a82b6e-8c7f-401d-a9d0-08d682898a1e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB6157; 
x-ms-traffictypediagnostic: VI1PR04MB6157:
x-microsoft-antispam-prvs: <VI1PR04MB6157F9BA74687B3B6E05F95AED9B0@VI1PR04MB6157.eurprd04.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(136003)(376002)(346002)(396003)(189003)(199004)(13464003)(3846002)(229853002)(2906002)(71190400001)(966005)(71200400001)(25786009)(44832011)(68736007)(8676002)(105586002)(102836004)(6916009)(33656002)(66066001)(106356001)(256004)(14454004)(4326008)(6116002)(6436002)(14444005)(6246003)(93886005)(55016002)(316002)(478600001)(53936002)(7696005)(7736002)(305945005)(446003)(26005)(9686003)(8936002)(486006)(6306002)(76176011)(11346002)(6506007)(186003)(86362001)(81156014)(81166006)(4001150100001)(476003)(74316002)(97736004)(54906003)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB6157;
 H:VI1PR04MB4431.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wYvuaISH6Xpc1/pvgu7MK4O4iLZreXymL7JGf+SmTw/cNruhFXGSfG2FIqwJTCdji4VxsvwlQTThedE2jlzrbAKnv2iPmYMiOi1qeHj3UnlxUX119vlCE2+zhrakw14N6yyBQsJLuhz1ksyl/hc6KbajSVcdpQtTD9G9Ym213iHaKH5Fu1u4MXk0BPAsjXHdhA/bxhqqxiQGvoYoNlUh+dOp4ERFrLCsOA0Wlr27CQLR3Abf6tTVjdpFwG0YEln04OGPLWQA9hp8MxQ7lHhIYrjd2X4HYhEjmAEoQ8pDr/CsDzPXOHHphtSo2zGc8THDNE+u49XqiMdXoc+atSScY23mVKPnLZqKo6CJW19eHRh8ffGJd4gqilhaSTvG008osNXELfHNUVJpfpHcIclv+7mUd2BSVWMRMk5Ww0BZ0vM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a82b6e-8c7f-401d-a9d0-08d682898a1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 05:54:15.7649 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6157
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
Cc: Wen He <wen.he_1@nxp.com>, Leo Li <leoyang.li@nxp.com>,
 Scott Wood <oss@buserror.net>, Zhang Wei <zw@zh-kernel.org>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgVmlub2QsDQoNClNvcnJ5IHRvIHJlcGxheSBsYXRlLg0KMTpUaGlzIHBhdGNoIGhhcyBhbHJl
YWR5IHNlbmQgdG8gdGhlIHBhdGNod29yay4NCglQbGVhc2Ugc2VlIHRoZSBwYXRjaCBsaW5rOiBo
dHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwNzQxNTIxLw0KMjpJIGhhdmUgYWxy
ZWFkeSBjb21waWxlIHRoZSBmc2wgcGF0Y2hlcyBvbiBhcm0gYW5kIHBvd2VycGMgYWZ0ZXIgcGF0
Y2hlZCBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwNzQxNTIxLw0KCVRoZSBj
b21waWxlIHdpbGwgc3VjY2Vzc2Z1bCwgcGxlYXNlIGxldCBtZSBrbm93IHRoZSByZXBvcnRlZCBy
ZWdyZXNzaW9uIHJlc3VsdHMsIHRoYW5rcyB2ZXJ5IG11Y2guDQoNCkJlc3QgUmVnYXJkcywNClBl
bmcNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogVmlub2QgS291bCA8dmtv
dWxAa2VybmVsLm9yZz4NCj5TZW50OiAyMDE55bm0MeaciDE55pelIDIwOjU5DQo+VG86IFBlbmcg
TWEgPHBlbmcubWFAbnhwLmNvbT4NCj5DYzogU2NvdHQgV29vZCA8b3NzQGJ1c2Vycm9yLm5ldD47
IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsgWmhhbmcgV2VpDQo+PHp3QHpoLWtlcm5lbC5v
cmc+OyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsNCj5kbWFlbmdpbmVAdmdlci5rZXJu
ZWwub3JnOyBXZW4gSGUgPHdlbi5oZV8xQG54cC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSF0g
ZG1hZW5naW5lOiBmc2xkbWE6IEFkZCA2NC1iaXQgSS9PIGFjY2Vzc29ycyBmb3INCj5wb3dlcnBj
NjQNCj4NCj5PbiAyNC0xMi0xOCwgMDU6MjksIFBlbmcgTWEgd3JvdGU6DQo+PiBIaSBTY290dCwN
Cj4+DQo+PiBPaCwgSSBkaWQgbm90IHNlZSB0aGUgaW5fWFg2NC9vdXRfWFg2NCBzdXBwb3J0ZWQg
b25seSBfX3Bvd2VycGM2NF9fIGp1c3QNCj5ub3cuDQo+PiBUaGFua3MgZm9yIHlvdXIgcmVtaW5k
ZXIuDQo+DQo+Q2FuIHlvdSBzZW5kIHRoZSBmb3JtYWwgcGF0Y2ggZm9yIHRoaXMuLi4NCj4NCj5G
V0lXLCBmc2wgcGF0Y2hlcyB3ZXJlIG5vdCBtZXJnZWQgbGFzdCBjeWNsZSBiZWNhdXNlIG9mIHJl
cG9ydGVkIHJlZ3Jlc3Npb24uLi4NCj4NCj4+DQo+PiAjaWZkZWYgX19wb3dlcnBjNjRfXw0KPj4N
Cj4+ICNpZmRlZiBfX0JJR19FTkRJQU5fXw0KPj4gREVGX01NSU9fT1VUX0Qob3V0X2JlNjQsIDY0
LCBzdGQpOw0KPj4gREVGX01NSU9fSU5fRChpbl9iZTY0LCA2NCwgbGQpOw0KPj4NCj4+IC8qIFRo
ZXJlIGlzIG5vIGFzbSBpbnN0cnVjdGlvbnMgZm9yIDY0IGJpdHMgcmV2ZXJzZSBsb2FkcyBhbmQg
c3RvcmVzDQo+PiAqLyBzdGF0aWMgaW5saW5lIHU2NCBpbl9sZTY0KGNvbnN0IHZvbGF0aWxlIHU2
NCBfX2lvbWVtICphZGRyKSB7DQo+PiAgICAgICAgIHJldHVybiBzd2FiNjQoaW5fYmU2NChhZGRy
KSk7DQo+PiB9DQo+Pg0KPj4gc3RhdGljIGlubGluZSB2b2lkIG91dF9sZTY0KHZvbGF0aWxlIHU2
NCBfX2lvbWVtICphZGRyLCB1NjQgdmFsKSB7DQo+PiAgICAgICAgIG91dF9iZTY0KGFkZHIsIHN3
YWI2NCh2YWwpKTsNCj4+IH0NCj4+ICNlbHNlDQo+PiBERUZfTU1JT19PVVRfRChvdXRfbGU2NCwg
NjQsIHN0ZCk7DQo+PiBERUZfTU1JT19JTl9EKGluX2xlNjQsIDY0LCBsZCk7DQo+Pg0KPj4gLyog
VGhlcmUgaXMgbm8gYXNtIGluc3RydWN0aW9ucyBmb3IgNjQgYml0cyByZXZlcnNlIGxvYWRzIGFu
ZCBzdG9yZXMNCj4+ICovIHN0YXRpYyBpbmxpbmUgdTY0IGluX2JlNjQoY29uc3Qgdm9sYXRpbGUg
dTY0IF9faW9tZW0gKmFkZHIpIHsNCj4+ICAgICAgICAgcmV0dXJuIHN3YWI2NChpbl9sZTY0KGFk
ZHIpKTsNCj4+IH0NCj4+DQo+PiBzdGF0aWMgaW5saW5lIHZvaWQgb3V0X2JlNjQodm9sYXRpbGUg
dTY0IF9faW9tZW0gKmFkZHIsIHU2NCB2YWwpIHsNCj4+ICAgICAgICAgb3V0X2xlNjQoYWRkciwg
c3dhYjY0KHZhbCkpOw0KPj4gfQ0KPj4NCj4+ICNlbmRpZg0KPj4gI2VuZGlmIC8qIF9fcG93ZXJw
YzY0X18gKi8NCj4+DQo+PiBCZXN0IFJlZ2FyZHMsDQo+PiBQZW5nDQo+PiA+LS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4+ID5Gcm9tOiBTY290dCBXb29kIDxvc3NAYnVzZXJyb3IubmV0Pg0K
Pj4gPlNlbnQ6IDIwMTjlubQxMuaciDI05pelIDEyOjQ2DQo+PiA+VG86IFBlbmcgTWEgPHBlbmcu
bWFAbnhwLmNvbT47IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsgWmhhbmcNCj5XZWkNCj4+
ID48endAemgta2VybmVsLm9yZz4NCj4+ID5DYzogbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5v
cmc7IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IFdlbiBIZQ0KPj4gPjx3ZW4uaGVfMUBueHAu
Y29tPg0KPj4gPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRtYWVuZ2luZTogZnNsZG1hOiBBZGQgNjQt
Yml0IEkvTyBhY2Nlc3NvcnMgZm9yDQo+PiA+cG93ZXJwYzY0DQo+PiA+DQo+PiA+T24gTW9uLCAy
MDE4LTEyLTI0IGF0IDAzOjQyICswMDAwLCBQZW5nIE1hIHdyb3RlOg0KPj4gPj4gSGkgU2NvdHQs
DQo+PiA+Pg0KPj4gPj4gWW91IGFyZSByaWdodCwgd2Ugc2hvdWxkIHN1cHBvcnQgcG93ZXJwYzY0
LCBzbyBjb3VsZCBJIGNoYW5nZWQgaXQNCj4+ID4+IGFzDQo+PiA+PiBmYWxsb3dzOg0KPj4gPj4N
Cj4+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9mc2xkbWEuaCBiL2RyaXZlcnMvZG1hL2Zz
bGRtYS5oIGluZGV4DQo+PiA+PiA4OGRiOTM5Li4wNTdiYWJmIDEwMDY0NA0KPj4gPj4gLS0tIGEv
ZHJpdmVycy9kbWEvZnNsZG1hLmgNCj4+ID4+ICsrKyBiL2RyaXZlcnMvZG1hL2ZzbGRtYS5oDQo+
PiA+PiBAQCAtMjAyLDM1ICsyMDIsMTAgQEAgc3RydWN0IGZzbGRtYV9jaGFuIHsNCj4+ID4+ICAj
ZGVmaW5lIGZzbF9pb3dyaXRlMzIodiwgcCkgICAgb3V0X2xlMzIocCwgdikNCj4+ID4+ICAjZGVm
aW5lIGZzbF9pb3dyaXRlMzJiZSh2LCBwKSAgb3V0X2JlMzIocCwgdikNCj4+ID4+DQo+PiA+PiAt
I2lmbmRlZiBfX3Bvd2VycGM2NF9fDQo+PiA+PiAtc3RhdGljIHU2NCBmc2xfaW9yZWFkNjQoY29u
c3QgdTY0IF9faW9tZW0gKmFkZHIpIC17DQo+PiA+PiAtICAgICAgIHUzMiBmc2xfYWRkciA9IGxv
d2VyXzMyX2JpdHMoYWRkcik7DQo+PiA+PiAtICAgICAgIHU2NCBmc2xfYWRkcl9oaSA9ICh1NjQp
aW5fbGUzMigodTMyICopKGZzbF9hZGRyICsgMSkpIDw8IDMyOw0KPj4gPj4gLQ0KPj4gPj4gLSAg
ICAgICByZXR1cm4gZnNsX2FkZHJfaGkgfCBpbl9sZTMyKCh1MzIgKilmc2xfYWRkcik7DQo+PiA+
PiAtfQ0KPj4gPj4gLQ0KPj4gPj4gLXN0YXRpYyB2b2lkIGZzbF9pb3dyaXRlNjQodTY0IHZhbCwg
dTY0IF9faW9tZW0gKmFkZHIpIC17DQo+PiA+PiAtICAgICAgIG91dF9sZTMyKCh1MzIgX19pb21l
bSAqKWFkZHIgKyAxLCB2YWwgPj4gMzIpOw0KPj4gPj4gLSAgICAgICBvdXRfbGUzMigodTMyIF9f
aW9tZW0gKilhZGRyLCAodTMyKXZhbCk7DQo+PiA+PiAtfQ0KPj4gPj4gLQ0KPj4gPj4gLXN0YXRp
YyB1NjQgZnNsX2lvcmVhZDY0YmUoY29uc3QgdTY0IF9faW9tZW0gKmFkZHIpIC17DQo+PiA+PiAt
ICAgICAgIHUzMiBmc2xfYWRkciA9IGxvd2VyXzMyX2JpdHMoYWRkcik7DQo+PiA+PiAtICAgICAg
IHU2NCBmc2xfYWRkcl9oaSA9ICh1NjQpaW5fYmUzMigodTMyICopZnNsX2FkZHIpIDw8IDMyOw0K
Pj4gPj4gLQ0KPj4gPj4gLSAgICAgICByZXR1cm4gZnNsX2FkZHJfaGkgfCBpbl9iZTMyKCh1MzIg
KikoZnNsX2FkZHIgKyAxKSk7DQo+PiA+PiAtfQ0KPj4gPj4gLQ0KPj4gPj4gLXN0YXRpYyB2b2lk
IGZzbF9pb3dyaXRlNjRiZSh1NjQgdmFsLCB1NjQgX19pb21lbSAqYWRkcikgLXsNCj4+ID4+IC0g
ICAgICAgb3V0X2JlMzIoKHUzMiBfX2lvbWVtICopYWRkciwgdmFsID4+IDMyKTsNCj4+ID4+IC0g
ICAgICAgb3V0X2JlMzIoKHUzMiBfX2lvbWVtICopYWRkciArIDEsICh1MzIpdmFsKTsNCj4+ID4+
IC19DQo+PiA+PiAtI2VuZGlmDQo+PiA+PiArI2RlZmluZSBmc2xfaW9yZWFkNjQocCkgICAgICAg
ICAgICAgICAgaW5fbGU2NChwKQ0KPj4gPj4gKyNkZWZpbmUgZnNsX2lvcmVhZDY0YmUocCkgICAg
ICBpbl9iZTY0KHApDQo+PiA+PiArI2RlZmluZSBmc2xfaW93cml0ZTY0KHYsIHApICAgIG91dF9s
ZTY0KHAsIHYpDQo+PiA+PiArI2RlZmluZSBmc2xfaW93cml0ZTY0YmUodiwgcCkgIG91dF9iZTY0
KHAsIHYpDQo+PiA+PiAgI2VuZGlmDQo+PiA+DQo+PiA+VGhlbiB5b3UnbGwgYnJlYWsgMzItYml0
LCBhc3N1bWluZyB0aG9zZQ0KPj4gPmZha2UtaXQtd2l0aC10d28tMzItYml0LWFjY2Vzc2VzIHdl
cmUgYWN0dWFsbHkgbmVlZGVkLg0KPj4gPg0KPj4gPi1TY290dA0KPj4gPg0KPj4NCj4NCj4tLQ0K
Pn5WaW5vZA0K

Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A490C282CE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 09:22:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE48E20883
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 09:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e83MHpY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE48E20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44d4gx1kXQzDqMH
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 19:22:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.60; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=laurentiu.tudor@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="e83MHpY6"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00060.outbound.protection.outlook.com [40.107.0.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44d4f11C2FzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2019 19:20:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aijNi1VW1VX60duJehbUG6ARJDCBnWRkoo/pdBcXTBo=;
 b=e83MHpY6e6NeorO9O3GBcSjG9OXhnUiGoUbLy2nID1/IraIDueNJyw0ETRJ9HOdb6AdXy6FIGrWRpv1yOhap4ULRNGYjumGN/5QfW+lEkGoV8S0QdKnW6NCLvG11GJ32AiaDz7klfv04HoVvew8O9r5ny7tJCrrz7UeVwaHvQa8=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1PR04MB4255.eurprd04.prod.outlook.com (52.134.31.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Mon, 8 Apr 2019 09:20:30 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::5c9b:12cc:80f2:1f42]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::5c9b:12cc:80f2:1f42%3]) with mapi id 15.20.1771.021; Mon, 8 Apr 2019
 09:20:30 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Roy Pledge <roy.pledge@nxp.com>, "stuyoder@gmail.com"
 <stuyoder@gmail.com>, Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH v2 1/2] bus: mc-bus: Add support for mapping shareable
 portals
Thread-Topic: [PATCH v2 1/2] bus: mc-bus: Add support for mapping shareable
 portals
Thread-Index: AQHU672dZi8FxaELgkO6Famf/qTYoaYyASKA
Date: Mon, 8 Apr 2019 09:20:30 +0000
Message-ID: <cf672a75-0f44-0202-b8f4-000fac80e97a@nxp.com>
References: <1554475256-4805-1-git-send-email-roy.pledge@nxp.com>
 <1554475256-4805-2-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1554475256-4805-2-git-send-email-roy.pledge@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0759183f-51de-4ec8-9412-08d6bc03724b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR04MB4255; 
x-ms-traffictypediagnostic: VI1PR04MB4255:
x-microsoft-antispam-prvs: <VI1PR04MB4255F2E7134A01F24A15E98CEC2C0@VI1PR04MB4255.eurprd04.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(346002)(136003)(396003)(39860400002)(199004)(189003)(6436002)(478600001)(68736007)(110136005)(54906003)(6636002)(8676002)(71190400001)(99286004)(26005)(6506007)(81166006)(53546011)(256004)(81156014)(105586002)(76176011)(186003)(106356001)(2906002)(31686004)(71200400001)(6116002)(102836004)(14454004)(3846002)(5660300002)(11346002)(2616005)(36756003)(44832011)(66066001)(53936002)(14444005)(476003)(2501003)(486006)(305945005)(446003)(86362001)(7736002)(25786009)(316002)(6246003)(6512007)(8936002)(31696002)(229853002)(4326008)(6486002)(97736004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4255;
 H:VI1PR04MB5134.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qTOpklRSeTnrot24Go3WO6O7jwbr487BL/t9pi76U4Xd7eu/vCS0+7D0N6xqxUmZBunsI/S6Mv3n/tvM3ERaQcWmdy5rH7NHvJoP7UUJhqZxQ+kng/oxuq1YLVi91sh+av2KkXsY+rim5Rf+lP+tHcGfM/0db9dQ7p4ZX9EC7yCUszBzeYdZLyogk9cMW7llDdIqNJO1S1XrjnjliQlOM7WxUKkBcx+Rpe/yR1JLzym/CP2/riraqboCq8D3vgBoDXd9b8fEe8aBf/fo0xScmv1ckK+91X1/3UuDge5j1eUv7z4uZmcouS6Arn64J8OZuuc21M4XFO1u671lVfVtzTwRklvlNb8ZUww8e4JM3mgLqM5SJPABQc4wh8YU63k2cNAvGhW4Grrf4gLiRQcgbE8/KMNWIza0+4FlR9qPskw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1796667EF73885429AA787608CA571DD@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0759183f-51de-4ec8-9412-08d6bc03724b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 09:20:30.6932 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4255
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgUm95LA0KDQpPbiAwNS4wNC4yMDE5IDE3OjQxLCBSb3kgUGxlZGdlIHdyb3RlOg0KPiBTdGFy
dGluZyB3aXRoIHY1IG9mIE5YUCBRQk1hbiBkZXZpY2VzIHRoZSBoYXJkd2FyZSBzdXBwb3J0cyB1
c2luZw0KPiByZWd1bGFyIGNhY2hlYWJsZS9zaGFyZWFibGUgbWVtb3J5IGFzIHRoZSBiYWNraW5n
IHN0b3JlIGZvciB0aGUNCj4gcG9ydGFscy4NCj4gDQo+IFRoaXMgcGF0Y2ggYWRkcyBzdXBwb3J0
IGZvciB0aGUgbmV3IHBvcnRhbCBtb2RlIGJ5IHN3aXRjaGluZyB0bw0KPiB1c2UgdGhlIERQUkMg
Z2V0IG9iamVjdCByZWdpb24gdjIgY29tbWFuZCB3aGljaCByZXR1cm5zIGJvdGgNCj4gYSBiYXNl
IGFkZHJlc3MgYW5kIG9mZnNldCBmb3IgdGhlIHBvcnRhbCBtZW1vcnkuIFRoZSBuZXcgcG9ydGFs
DQo+IHJlZ2lvbiBpcyBpZGVudGlmaWVkIGFzIHNoYXJlYWJsZSB0aHJvdWdoIHRoZSBhZGRpdGlv
biBvZiBhIG5ldw0KPiBmbGFnLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUm95IFBsZWRnZSA8cm95
LnBsZWRnZUBueHAuY29tPg0KDQpMb29rcyBnb29kIHRvIG1lOg0KDQpSZXZpZXdlZC1ieTogTGF1
cmVudGl1IFR1ZG9yIDxsYXVyZW50aXUudHVkb3JAbnhwLmNvbT4NCg0KLS0tDQpCZXN0IFJlZ2Fy
ZHMsIExhdXJlbnRpdQ0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvYnVzL2ZzbC1tYy9kcHJjLmMgICAg
ICAgICAgIHwgMzAgKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+ICAgZHJpdmVycy9i
dXMvZnNsLW1jL2ZzbC1tYy1idXMuYyAgICAgfCAxNSArKysrKysrKysrKysrLS0NCj4gICBkcml2
ZXJzL2J1cy9mc2wtbWMvZnNsLW1jLXByaXZhdGUuaCB8IDE3ICsrKysrKysrKysrKysrKy0tDQo+
ICAgMyBmaWxlcyBjaGFuZ2VkLCA1NSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYnVzL2ZzbC1tYy9kcHJjLmMgYi9kcml2ZXJzL2J1cy9m
c2wtbWMvZHByYy5jDQo+IGluZGV4IDFjM2Y2MjEuLjBmZTNmNTIgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvYnVzL2ZzbC1tYy9kcHJjLmMNCj4gKysrIGIvZHJpdmVycy9idXMvZnNsLW1jL2RwcmMu
Yw0KPiBAQCAtNDQzLDExICs0NDMsMzEgQEAgaW50IGRwcmNfZ2V0X29ial9yZWdpb24oc3RydWN0
IGZzbF9tY19pbyAqbWNfaW8sDQo+ICAgCXN0cnVjdCBmc2xfbWNfY29tbWFuZCBjbWQgPSB7IDAg
fTsNCj4gICAJc3RydWN0IGRwcmNfY21kX2dldF9vYmpfcmVnaW9uICpjbWRfcGFyYW1zOw0KPiAg
IAlzdHJ1Y3QgZHByY19yc3BfZ2V0X29ial9yZWdpb24gKnJzcF9wYXJhbXM7DQo+ICsJdTE2IG1h
am9yX3ZlciwgbWlub3JfdmVyOw0KPiAgIAlpbnQgZXJyOw0KPiAgIA0KPiAgIAkvKiBwcmVwYXJl
IGNvbW1hbmQgKi8NCj4gLQljbWQuaGVhZGVyID0gbWNfZW5jb2RlX2NtZF9oZWFkZXIoRFBSQ19D
TURJRF9HRVRfT0JKX1JFRywNCj4gLQkJCQkJICBjbWRfZmxhZ3MsIHRva2VuKTsNCj4gKwllcnIg
PSBkcHJjX2dldF9hcGlfdmVyc2lvbihtY19pbywgMCwNCj4gKwkJCQkgICAgICZtYWpvcl92ZXIs
DQo+ICsJCQkJICAgICAmbWlub3JfdmVyKTsNCj4gKwlpZiAoZXJyKQ0KPiArCQlyZXR1cm4gZXJy
Ow0KPiArDQo+ICsJLyoqDQo+ICsJICogTUMgQVBJIHZlcnNpb24gNi4zIGludHJvZHVjZWQgYSBu
ZXcgZmllbGQgdG8gdGhlIHJlZ2lvbg0KPiArCSAqIGRlc2NyaXB0b3I6IGJhc2VfYWRkcmVzcy4g
SWYgdGhlIG9sZGVyIEFQSSBpcyBpbiB1c2UgdGhlbiB0aGUgYmFzZQ0KPiArCSAqIGFkZHJlc3Mg
aXMgc2V0IHRvIHplcm8gdG8gaW5kaWNhdGUgaXQgbmVlZHMgdG8gYmUgb2J0YWluZWQgZWxzZXdo
ZXJlDQo+ICsJICogKHR5cGljYWxseSB0aGUgZGV2aWNlIHRyZWUpLg0KPiArCSAqLw0KPiArCWlm
IChtYWpvcl92ZXIgPiA2IHx8IChtYWpvcl92ZXIgPT0gNiAmJiBtaW5vcl92ZXIgPj0gMykpDQo+
ICsJCWNtZC5oZWFkZXIgPQ0KPiArCQkJbWNfZW5jb2RlX2NtZF9oZWFkZXIoRFBSQ19DTURJRF9H
RVRfT0JKX1JFR19WMiwNCj4gKwkJCQkJICAgICBjbWRfZmxhZ3MsIHRva2VuKTsNCj4gKwllbHNl
DQo+ICsJCWNtZC5oZWFkZXIgPQ0KPiArCQkJbWNfZW5jb2RlX2NtZF9oZWFkZXIoRFBSQ19DTURJ
RF9HRVRfT0JKX1JFRywNCj4gKwkJCQkJICAgICBjbWRfZmxhZ3MsIHRva2VuKTsNCj4gKw0KPiAg
IAljbWRfcGFyYW1zID0gKHN0cnVjdCBkcHJjX2NtZF9nZXRfb2JqX3JlZ2lvbiAqKWNtZC5wYXJh
bXM7DQo+ICAgCWNtZF9wYXJhbXMtPm9ial9pZCA9IGNwdV90b19sZTMyKG9ial9pZCk7DQo+ICAg
CWNtZF9wYXJhbXMtPnJlZ2lvbl9pbmRleCA9IHJlZ2lvbl9pbmRleDsNCj4gQEAgLTQ2MSw4ICs0
ODEsMTIgQEAgaW50IGRwcmNfZ2V0X29ial9yZWdpb24oc3RydWN0IGZzbF9tY19pbyAqbWNfaW8s
DQo+ICAgDQo+ICAgCS8qIHJldHJpZXZlIHJlc3BvbnNlIHBhcmFtZXRlcnMgKi8NCj4gICAJcnNw
X3BhcmFtcyA9IChzdHJ1Y3QgZHByY19yc3BfZ2V0X29ial9yZWdpb24gKiljbWQucGFyYW1zOw0K
PiAtCXJlZ2lvbl9kZXNjLT5iYXNlX29mZnNldCA9IGxlNjRfdG9fY3B1KHJzcF9wYXJhbXMtPmJh
c2VfYWRkcik7DQo+ICsJcmVnaW9uX2Rlc2MtPmJhc2Vfb2Zmc2V0ID0gbGU2NF90b19jcHUocnNw
X3BhcmFtcy0+YmFzZV9vZmZzZXQpOw0KPiAgIAlyZWdpb25fZGVzYy0+c2l6ZSA9IGxlMzJfdG9f
Y3B1KHJzcF9wYXJhbXMtPnNpemUpOw0KPiArCWlmIChtYWpvcl92ZXIgPiA2IHx8IChtYWpvcl92
ZXIgPT0gNiAmJiBtaW5vcl92ZXIgPj0gMykpDQo+ICsJCXJlZ2lvbl9kZXNjLT5iYXNlX2FkZHJl
c3MgPSBsZTY0X3RvX2NwdShyc3BfcGFyYW1zLT5iYXNlX2FkZHIpOw0KPiArCWVsc2UNCj4gKwkJ
cmVnaW9uX2Rlc2MtPmJhc2VfYWRkcmVzcyA9IDA7DQo+ICAgDQo+ICAgCXJldHVybiAwOw0KPiAg
IH0NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYnVzL2ZzbC1tYy9mc2wtbWMtYnVzLmMgYi9kcml2
ZXJzL2J1cy9mc2wtbWMvZnNsLW1jLWJ1cy5jDQo+IGluZGV4IGYwNDA0YzYuLjVjOWJmMmUgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvYnVzL2ZzbC1tYy9mc2wtbWMtYnVzLmMNCj4gKysrIGIvZHJp
dmVycy9idXMvZnNsLW1jL2ZzbC1tYy1idXMuYw0KPiBAQCAtNDg3LDEwICs0ODcsMTkgQEAgc3Rh
dGljIGludCBmc2xfbWNfZGV2aWNlX2dldF9tbWlvX3JlZ2lvbnMoc3RydWN0IGZzbF9tY19kZXZp
Y2UgKm1jX2RldiwNCj4gICAJCQkJImRwcmNfZ2V0X29ial9yZWdpb24oKSBmYWlsZWQ6ICVkXG4i
LCBlcnJvcik7DQo+ICAgCQkJZ290byBlcnJvcl9jbGVhbnVwX3JlZ2lvbnM7DQo+ICAgCQl9DQo+
IC0NCj4gLQkJZXJyb3IgPSB0cmFuc2xhdGVfbWNfYWRkcihtY19kZXYsIG1jX3JlZ2lvbl90eXBl
LA0KPiArCQkvKg0KPiArCQkgKiBPbGRlciBNQyBvbmx5IHJldHVybmVkIHJlZ2lvbiBvZmZzZXQg
YW5kIG5vIGJhc2UgYWRkcmVzcw0KPiArCQkgKiBJZiBiYXNlIGFkZHJlc3MgaXMgaW4gdGhlIHJl
Z2lvbl9kZXNjIHVzZSBpdCBvdGhlcndpc2UNCj4gKwkJICogcmV2ZXJ0IHRvIG9sZCBtZWNoYW5p
c20NCj4gKwkJICovDQo+ICsJCWlmIChyZWdpb25fZGVzYy5iYXNlX2FkZHJlc3MpDQo+ICsJCQly
ZWdpb25zW2ldLnN0YXJ0ID0gcmVnaW9uX2Rlc2MuYmFzZV9hZGRyZXNzICsNCj4gKwkJCQkJCXJl
Z2lvbl9kZXNjLmJhc2Vfb2Zmc2V0Ow0KPiArCQllbHNlDQo+ICsJCQllcnJvciA9IHRyYW5zbGF0
ZV9tY19hZGRyKG1jX2RldiwgbWNfcmVnaW9uX3R5cGUsDQo+ICAgCQkJCQkgIHJlZ2lvbl9kZXNj
LmJhc2Vfb2Zmc2V0LA0KPiAgIAkJCQkJICAmcmVnaW9uc1tpXS5zdGFydCk7DQo+ICsNCj4gICAJ
CWlmIChlcnJvciA8IDApIHsNCj4gICAJCQlkZXZfZXJyKHBhcmVudF9kZXYsDQo+ICAgCQkJCSJJ
bnZhbGlkIE1DIG9mZnNldDogJSN4IChmb3IgJXMuJWRcJ3MgcmVnaW9uICVkKVxuIiwNCj4gQEAg
LTUwNCw2ICs1MTMsOCBAQCBzdGF0aWMgaW50IGZzbF9tY19kZXZpY2VfZ2V0X21taW9fcmVnaW9u
cyhzdHJ1Y3QgZnNsX21jX2RldmljZSAqbWNfZGV2LA0KPiAgIAkJcmVnaW9uc1tpXS5mbGFncyA9
IElPUkVTT1VSQ0VfSU87DQo+ICAgCQlpZiAocmVnaW9uX2Rlc2MuZmxhZ3MgJiBEUFJDX1JFR0lP
Tl9DQUNIRUFCTEUpDQo+ICAgCQkJcmVnaW9uc1tpXS5mbGFncyB8PSBJT1JFU09VUkNFX0NBQ0hF
QUJMRTsNCj4gKwkJaWYgKHJlZ2lvbl9kZXNjLmZsYWdzICYgRFBSQ19SRUdJT05fU0hBUkVBQkxF
KQ0KPiArCQkJcmVnaW9uc1tpXS5mbGFncyB8PSBJT1JFU09VUkNFX01FTTsNCj4gICAJfQ0KPiAg
IA0KPiAgIAltY19kZXYtPnJlZ2lvbnMgPSByZWdpb25zOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9idXMvZnNsLW1jL2ZzbC1tYy1wcml2YXRlLmggYi9kcml2ZXJzL2J1cy9mc2wtbWMvZnNsLW1j
LXByaXZhdGUuaA0KPiBpbmRleCBlYTExYjRmLi4wMjBmY2MwIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2J1cy9mc2wtbWMvZnNsLW1jLXByaXZhdGUuaA0KPiArKysgYi9kcml2ZXJzL2J1cy9mc2wt
bWMvZnNsLW1jLXByaXZhdGUuaA0KPiBAQCAtNzksOSArNzksMTEgQEAgaW50IGRwbWNwX3Jlc2V0
KHN0cnVjdCBmc2xfbWNfaW8gKm1jX2lvLA0KPiAgIA0KPiAgIC8qIERQUkMgY29tbWFuZCB2ZXJz
aW9uaW5nICovDQo+ICAgI2RlZmluZSBEUFJDX0NNRF9CQVNFX1ZFUlNJT04JCQkxDQo+ICsjZGVm
aW5lIERQUkNfQ01EXzJORF9WRVJTSU9OCQkJMg0KPiAgICNkZWZpbmUgRFBSQ19DTURfSURfT0ZG
U0VUCQkJNA0KPiAgIA0KPiAgICNkZWZpbmUgRFBSQ19DTUQoaWQpCSgoKGlkKSA8PCBEUFJDX0NN
RF9JRF9PRkZTRVQpIHwgRFBSQ19DTURfQkFTRV9WRVJTSU9OKQ0KPiArI2RlZmluZSBEUFJDX0NN
RF9WMihpZCkJKCgoaWQpIDw8IERQUkNfQ01EX0lEX09GRlNFVCkgfCBEUFJDX0NNRF8yTkRfVkVS
U0lPTikNCj4gICANCj4gICAvKiBEUFJDIGNvbW1hbmQgSURzICovDQo+ICAgI2RlZmluZSBEUFJD
X0NNRElEX0NMT1NFICAgICAgICAgICAgICAgICAgICAgICAgRFBSQ19DTUQoMHg4MDApDQo+IEBA
IC0xMDAsNiArMTAyLDcgQEAgaW50IGRwbWNwX3Jlc2V0KHN0cnVjdCBmc2xfbWNfaW8gKm1jX2lv
LA0KPiAgICNkZWZpbmUgRFBSQ19DTURJRF9HRVRfT0JKX0NPVU5UICAgICAgICAgICAgICAgIERQ
UkNfQ01EKDB4MTU5KQ0KPiAgICNkZWZpbmUgRFBSQ19DTURJRF9HRVRfT0JKICAgICAgICAgICAg
ICAgICAgICAgIERQUkNfQ01EKDB4MTVBKQ0KPiAgICNkZWZpbmUgRFBSQ19DTURJRF9HRVRfT0JK
X1JFRyAgICAgICAgICAgICAgICAgIERQUkNfQ01EKDB4MTVFKQ0KPiArI2RlZmluZSBEUFJDX0NN
RElEX0dFVF9PQkpfUkVHX1YyICAgICAgICAgICAgICAgRFBSQ19DTURfVjIoMHgxNUUpDQo+ICAg
I2RlZmluZSBEUFJDX0NNRElEX1NFVF9PQkpfSVJRICAgICAgICAgICAgICAgICAgRFBSQ19DTUQo
MHgxNUYpDQo+ICAgDQo+ICAgc3RydWN0IGRwcmNfY21kX29wZW4gew0KPiBAQCAtMTk5LDkgKzIw
MiwxNiBAQCBzdHJ1Y3QgZHByY19yc3BfZ2V0X29ial9yZWdpb24gew0KPiAgIAkvKiByZXNwb25z
ZSB3b3JkIDAgKi8NCj4gICAJX19sZTY0IHBhZDsNCj4gICAJLyogcmVzcG9uc2Ugd29yZCAxICov
DQo+IC0JX19sZTY0IGJhc2VfYWRkcjsNCj4gKwlfX2xlNjQgYmFzZV9vZmZzZXQ7DQo+ICAgCS8q
IHJlc3BvbnNlIHdvcmQgMiAqLw0KPiAgIAlfX2xlMzIgc2l6ZTsNCj4gKwlfX2xlMzIgcGFkMjsN
Cj4gKwkvKiByZXNwb25zZSB3b3JkIDMgKi8NCj4gKwlfX2xlMzIgZmxhZ3M7DQo+ICsJX19sZTMy
IHBhZDM7DQo+ICsJLyogcmVzcG9uc2Ugd29yZCA0ICovDQo+ICsJLyogYmFzZV9hZGRyIG1heSBi
ZSB6ZXJvIGlmIG9sZGVyIE1DIGZpcm13YXJlIGlzIHVzZWQgKi8NCj4gKwlfX2xlNjQgYmFzZV9h
ZGRyOw0KPiAgIH07DQo+ICAgDQo+ICAgc3RydWN0IGRwcmNfY21kX3NldF9vYmpfaXJxIHsNCj4g
QEAgLTMzNCw2ICszNDQsNyBAQCBpbnQgZHByY19zZXRfb2JqX2lycShzdHJ1Y3QgZnNsX21jX2lv
ICptY19pbywNCj4gICAvKiBSZWdpb24gZmxhZ3MgKi8NCj4gICAvKiBDYWNoZWFibGUgLSBJbmRp
Y2F0ZXMgdGhhdCByZWdpb24gc2hvdWxkIGJlIG1hcHBlZCBhcyBjYWNoZWFibGUgKi8NCj4gICAj
ZGVmaW5lIERQUkNfUkVHSU9OX0NBQ0hFQUJMRQkweDAwMDAwMDAxDQo+ICsjZGVmaW5lIERQUkNf
UkVHSU9OX1NIQVJFQUJMRQkweDAwMDAwMDAyDQo+ICAgDQo+ICAgLyoqDQo+ICAgICogZW51bSBk
cHJjX3JlZ2lvbl90eXBlIC0gUmVnaW9uIHR5cGUNCj4gQEAgLTM0Miw3ICszNTMsOCBAQCBpbnQg
ZHByY19zZXRfb2JqX2lycShzdHJ1Y3QgZnNsX21jX2lvICptY19pbywNCj4gICAgKi8NCj4gICBl
bnVtIGRwcmNfcmVnaW9uX3R5cGUgew0KPiAgIAlEUFJDX1JFR0lPTl9UWVBFX01DX1BPUlRBTCwN
Cj4gLQlEUFJDX1JFR0lPTl9UWVBFX1FCTUFOX1BPUlRBTA0KPiArCURQUkNfUkVHSU9OX1RZUEVf
UUJNQU5fUE9SVEFMLA0KPiArCURQUkNfUkVHSU9OX1RZUEVfUUJNQU5fTUVNX0JBQ0tFRF9QT1JU
QUwNCj4gICB9Ow0KPiAgIA0KPiAgIC8qKg0KPiBAQCAtMzYwLDYgKzM3Miw3IEBAIHN0cnVjdCBk
cHJjX3JlZ2lvbl9kZXNjIHsNCj4gICAJdTMyIHNpemU7DQo+ICAgCXUzMiBmbGFnczsNCj4gICAJ
ZW51bSBkcHJjX3JlZ2lvbl90eXBlIHR5cGU7DQo+ICsJdTY0IGJhc2VfYWRkcmVzczsNCj4gICB9
Ow0KPiAgIA0KPiAgIGludCBkcHJjX2dldF9vYmpfcmVnaW9uKHN0cnVjdCBmc2xfbWNfaW8gKm1j
X2lvLA0KPiA=

Return-Path: <SRS0=ts8b=SV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4A7C282DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 13:44:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1B3222A2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 13:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sb2muPTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1B3222A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lxys0CSfzDqQk
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 23:44:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.6.81; helo=eur04-db3-obe.outbound.protection.outlook.com;
 envelope-from=laurentiu.tudor@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="sb2muPTk"; 
 dkim-atps=neutral
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60081.outbound.protection.outlook.com [40.107.6.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lxwD3t6JzDqBL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 23:41:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdOMdNJmJGOVzzRDliZ13hYceqbBlu9X588oBQ/37Es=;
 b=sb2muPTk29AUFBD27Emi7Ons964JYJObjoEZ1DvRmbWMLjf7MV4IwcUIFGurqc6aW4Oe3YZfSuUHyHZ2w/WwvI2mx0r8E9zMVyhgVe2bqXnNMkhq8H8NM+9TKYr3hXz67muslkr6Ge+beLdpTieQvQDyHu/BLIdLVANcOqwRogI=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1PR04MB5919.eurprd04.prod.outlook.com (20.178.205.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Fri, 19 Apr 2019 13:41:39 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::5c9b:12cc:80f2:1f42]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::5c9b:12cc:80f2:1f42%3]) with mapi id 15.20.1813.013; Fri, 19 Apr 2019
 13:41:39 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Robin Murphy <robin.murphy@arm.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Madalin-cristian Bucur <madalin.bucur@nxp.com>, Roy
 Pledge <roy.pledge@nxp.com>, Camelia Alexandra Groza <camelia.groza@nxp.com>, 
 Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH 02/13] soc/fsl/bman: map FBPR area in the iommu
Thread-Topic: [PATCH 02/13] soc/fsl/bman: map FBPR area in the iommu
Thread-Index: AQHU5je+GYAdWERgxkCiU6HsMs84n6YisRcAgCDsguA=
Date: Fri, 19 Apr 2019 13:41:38 +0000
Message-ID: <VI1PR04MB5134C8A672CD99F521DBFE7EEC270@VI1PR04MB5134.eurprd04.prod.outlook.com>
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
 <20190329140014.8126-3-laurentiu.tudor@nxp.com>
 <b747c418-a495-56e0-c106-a8ec8e82ccb9@arm.com>
In-Reply-To: <b747c418-a495-56e0-c106-a8ec8e82ccb9@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [213.233.110.112]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f1080e5-4da5-4fa6-733c-08d6c4ccbfd8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR04MB5919; 
x-ms-traffictypediagnostic: VI1PR04MB5919:
x-microsoft-antispam-prvs: <VI1PR04MB591919C806B5124532B976BFEC270@VI1PR04MB5919.eurprd04.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(13464003)(189003)(55016002)(73956011)(66946007)(6246003)(52536014)(99286004)(66066001)(478600001)(2906002)(9686003)(97736004)(68736007)(44832011)(76176011)(86362001)(64756008)(76116006)(66446008)(53936002)(316002)(7696005)(54906003)(6116002)(110136005)(14454004)(6636002)(256004)(229853002)(476003)(6436002)(186003)(11346002)(74316002)(81156014)(4326008)(7736002)(305945005)(25786009)(26005)(71190400001)(33656002)(71200400001)(53546011)(486006)(6506007)(81166006)(8676002)(3846002)(102836004)(446003)(8936002)(66476007)(2501003)(5660300002)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5919;
 H:VI1PR04MB5134.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BeFY///qE+RmwKpRlRJcQbMDG6Ojm0ES1+M6FnlZDN7AFfwPqkRA68Yel4C5A2BZA38ZKAEfl1itecVa5l+X+os/AuRHbPYLy4ZGAxoUwRyCftMZOOmFpLLFo7yBfLSkHiI8puUkfAts9wEV92UfWF1RxW5MaBabJ5yZv/j9rI7GYMAn5aizHP+ZQTGA6ZKkstQwz8J6iXMVkT2Harme/xs49FxgfnffoYxNnsAmTL5Wc0WJahLAz7Y8rXrIoO6tNp7XOXRSwgoMRh+RX5jO57Q+5wbT31pp0pI1r5Rs91rZ4K0v2PlLJ3HN5rRT9XwITBffXN6+aZrZRbXS3TA5OFFuqf+mdvUv/kgn5bnLfi0dmt09sEwrT00SW+39HTDnRJbfJ+wSEv4TdLIinJMAhtrEpzA9DQxlzKbWvKjsPxk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1080e5-4da5-4fa6-733c-08d6c4ccbfd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 13:41:38.8808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5919
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
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "davem@davemloft.net" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgUm9iaW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4g
TXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXJjaCAyOSwg
MjAxOSA0OjUxIFBNDQo+IA0KPiBPbiAyOS8wMy8yMDE5IDE0OjAwLCBsYXVyZW50aXUudHVkb3JA
bnhwLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBMYXVyZW50aXUgVHVkb3IgPGxhdXJlbnRpdS50dWRv
ckBueHAuY29tPg0KPiA+DQo+ID4gQWRkIGEgb25lLXRvLW9uZSBpb21tdSBtYXBwaW5nIGZvciBi
bWFuIHByaXZhdGUgZGF0YSBtZW1vcnkgKEZCUFIpLg0KPiA+IFRoaXMgaXMgcmVxdWlyZWQgZm9y
IEJNQU4gdG8gd29yayB3aXRob3V0IGZhdWx0cyBiZWhpbmQgYW4gaW9tbXUuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBMYXVyZW50aXUgVHVkb3IgPGxhdXJlbnRpdS50dWRvckBueHAuY29tPg0K
PiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9zb2MvZnNsL3FibWFuL2JtYW5fY2Nzci5jIHwgMTEgKysr
KysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvZnNsL3FibWFuL2JtYW5fY2Nzci5jDQo+IGIvZHJp
dmVycy9zb2MvZnNsL3FibWFuL2JtYW5fY2Nzci5jDQo+ID4gaW5kZXggN2MzY2M5NjgwNTNjLi5i
MjA5Yzc5NTExYmIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zb2MvZnNsL3FibWFuL2JtYW5f
Y2Nzci5jDQo+ID4gKysrIGIvZHJpdmVycy9zb2MvZnNsL3FibWFuL2JtYW5fY2Nzci5jDQo+ID4g
QEAgLTI5LDYgKzI5LDcgQEANCj4gPiAgICAqLw0KPiA+DQo+ID4gICAjaW5jbHVkZSAiYm1hbl9w
cml2LmgiDQo+ID4gKyNpbmNsdWRlIDxsaW51eC9pb21tdS5oPg0KPiA+DQo+ID4gICB1MTYgYm1h
bl9pcF9yZXY7DQo+ID4gICBFWFBPUlRfU1lNQk9MKGJtYW5faXBfcmV2KTsNCj4gPiBAQCAtMTc4
LDYgKzE3OSw3IEBAIHN0YXRpYyBpbnQgZnNsX2JtYW5fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZQ0KPiAqcGRldikNCj4gPiAgIAlpbnQgcmV0LCBlcnJfaXJxOw0KPiA+ICAgCXN0cnVjdCBk
ZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gICAJc3RydWN0IGRldmljZV9ub2RlICpub2Rl
ID0gZGV2LT5vZl9ub2RlOw0KPiA+ICsJc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluOw0KPiA+
ICAgCXN0cnVjdCByZXNvdXJjZSAqcmVzOw0KPiA+ICAgCXUxNiBpZCwgYm1fcG9vbF9jbnQ7DQo+
ID4gICAJdTggbWFqb3IsIG1pbm9yOw0KPiA+IEBAIC0yMjUsNiArMjI3LDE1IEBAIHN0YXRpYyBp
bnQgZnNsX2JtYW5fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gPg0K
PiA+ICAgCWRldl9kYmcoZGV2LCAiQWxsb2NhdGVkIEZCUFIgMHglbGx4IDB4JXp4XG4iLCBmYnBy
X2EsIGZicHJfc3opOw0KPiA+DQo+ID4gKwkvKiBDcmVhdGUgYW4gMS10by0xIGlvbW11IG1hcHBp
bmcgZm9yIEZCUFIgYXJlYSAqLw0KPiA+ICsJZG9tYWluID0gaW9tbXVfZ2V0X2RvbWFpbl9mb3Jf
ZGV2KGRldik7DQo+IA0KPiBJZiB0aGF0J3MgZXhwZWN0ZWQgdG8gYmUgdGhlIGRlZmF1bHQgZG9t
YWluIHRoYXQgeW91J3JlIGdyYWJiaW5nLCB0aGVuDQo+IHRoaXMgaXMgKmluY3JlZGlibHkqIGZy
YWdpbGUuIFRoZXJlJ3Mgbm90aGluZyB0byBzdG9wIHRoZSBJT1ZBIHRoYXQgeW91DQo+IGZvcmNp
Ymx5IG1hcCBmcm9tIGJlaW5nIGF1dG9tYXRpY2FsbHkgYWxsb2NhdGVkIGxhdGVyIGFuZCBjYXVz
aW5nIHNvbWUNCj4gb3RoZXIgRE1BIG1hcHBpbmcgdG8gZmFpbCBub2lzaWx5IGFuZCB1bmV4cGVj
dGVkbHkuIEZ1cnRoZXJtb3JlLCBoYXZlDQo+IHlvdSB0cmllZCB0aGlzIHdpdGggImlvbW11LnBh
c3N0aHJvdWdoPTEiPw0KPiANCj4gVGhhdCBzYWlkLCBJIHJlYWxseSBkb24ndCB1bmRlcnN0YW5k
IHdoYXQncyBnb2luZyBvbiBoZXJlIGFueXdheSA6Lw0KPiANCj4gQXMgZmFyIGFzIEkgY2FuIHRl
bGwgZnJvbSBxYm1hbl9pbml0X3ByaXZhdGVfbWVtKCksIGZicHJfYSBjb21lcyBmcm9tDQo+IGRt
YV9hbGxvY19jb2hlcmVudCgpIGFuZCB0aHVzIHdvdWxkIGFscmVhZHkgYmUgYSBtYXBwZWQgSU9W
QSAtIGlzbid0DQo+IHRoaXMgdGhlIHN0dWZmIHRoYXQgUm95IGNvbnZlcnRlZCB0byBuaWNlbHkg
dXNlIHNoYXJlZC1kbWEtcG9vbCByZWdpb25zDQo+IGEgd2hpbGUgYWdvPw0KPiANCg0KRmluYWxs
eSBmb3VuZCBzb21lIHRpbWUgdG8gbG9vayBpbnRvIHRoaXMsIHNvcnJ5IGZvciB0aGUgZGVsYXku
IEl0IHNlZW1zIHRoYXQgb24gdGhlIGNvZGUgcGF0aCB0YWtlbiBpbiBvdXIgY2FzZSAoZG1hX2Fs
bG9jX2NvaGVyZW50KCkgLT4gZG1hX2FsbG9jX2F0dHJzKCkgLT4gZG1hX2FsbG9jX2Zyb21fZGV2
X2NvaGVyZW50KCkgLT4gX19kbWFfYWxsb2NfZnJvbV9jb2hlcmVudCgpKSB0aGVyZSdzIG5vIGNh
bGwgaW50byB0aGUgaW9tbXUgbGF5ZXIsIHRodXMgbm8gbWFwcGluZyBpbiB0aGUgc21tdS4gSSBw
bGFuIHRvIGNvbWUgdXAgd2l0aCBhIFJGQyBwYXRjaCBlYXJseSBuZXh0IHdlZWsgc28gd2UgaGF2
ZSBzb21ldGhpbmcgY29uY3JldGUgdG8gZGlzY3VzcyBvbi4NCg0KLS0tDQpCZXN0IFJlZ2FyZHMs
IExhdXJlbnRpdQ0K

Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486C1C10F11
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 02:51:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6566217D9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 02:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tKEjXyF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6566217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fls45KKzzDqMk
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 12:51:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.1.45; helo=eur02-he1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="tKEjXyF5"; 
 dkim-atps=neutral
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10045.outbound.protection.outlook.com [40.107.1.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44flpD2fmyzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 12:48:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJGH+accLpH4ql/IbUklPYJggO6VHP70kcWGau120pU=;
 b=tKEjXyF5Qlxa+RbkCK/4dTRiXuZpU8JVO2QItccrG7CM6mj/iZtcGXnLht4IlyKqk9Z+Wzv1BwUE56/aSXu2vc2999umeNc7k9nCC/E6p03U5VIuZbt5Rx1xHtGuoms5rKZQwIEM1m7RSMZ7rfmoJllspLwu43c/71c0BxD0Xg8=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6623.eurprd04.prod.outlook.com (20.179.235.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Thu, 11 Apr 2019 02:48:25 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%6]) with mapi id 15.20.1771.016; Thu, 11 Apr 2019
 02:48:25 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, "timur@kernel.org"
 <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com"
 <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: RE: [EXT] Re: [PATCH V2] ASoC: fsl_esai: replace fall-through with
 break
Thread-Topic: [EXT] Re: [PATCH V2] ASoC: fsl_esai: replace fall-through with
 break
Thread-Index: AQHU70cTwow3EQ3buU2LP9490KzdXqY1dX6AgADNzLA=
Date: Thu, 11 Apr 2019 02:48:25 +0000
Message-ID: <VE1PR04MB6479B21F67A8989072035BF6E32F0@VE1PR04MB6479.eurprd04.prod.outlook.com>
References: <46e9b55edb223894392a90c7cdb6241a43cb9cff.1554864022.git.shengjiu.wang@nxp.com>
 <b68a4e3a-8568-0c6e-aa3a-947e62e4f0f5@embeddedor.com>
In-Reply-To: <b68a4e3a-8568-0c6e-aa3a-947e62e4f0f5@embeddedor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a3452a6-8163-4a21-3e6f-08d6be282b7d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6623; 
x-ms-traffictypediagnostic: VE1PR04MB6623:
x-microsoft-antispam-prvs: <VE1PR04MB6623D40C37C341EE6F4537CFE32F0@VE1PR04MB6623.eurprd04.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(396003)(39860400002)(376002)(136003)(366004)(189003)(199004)(256004)(53546011)(4326008)(476003)(2201001)(7696005)(76176011)(11346002)(6506007)(446003)(26005)(33656002)(53936002)(14444005)(2906002)(486006)(102836004)(99286004)(86362001)(186003)(3846002)(25786009)(110136005)(6246003)(71190400001)(316002)(6116002)(66066001)(7736002)(74316002)(9686003)(68736007)(105586002)(5660300002)(106356001)(97736004)(2501003)(508600001)(8936002)(8676002)(81166006)(305945005)(6436002)(81156014)(14454004)(52536014)(55016002)(229853002)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6623;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1n9kHm+tXxNqKdHUnGBaksmwmGLhl51Sxee/hFOu5SIIAFhw47HqijTPH6KsnFulpkqzblOzsttpkehe0nFrBd8VzVDZk9Ncw5yjNVrEVoJ9FcUvwIYvLvLtaGExyh1YuNq1kR+QVywr6OMUQ3A3WzecnkimSf8zMV0wnisrVCqGM+Uhtn2Cpc/JKYrfEVDqNPTPkH6meKK00oFgBC6jZIRKLyeXcyiUkGA1pAi4PeHNp0VN9qWT8JkWUxdGoiVZwCHwoqo/iUbRwRotdrjdOdnJcyHpW3CjJFQK3h+BOzKYGgqm/7VLdY2vQ0YKY1+/XDh6Q70kvEPgnF78hCTlHvMZ5hVAWbvIpbL42REmLz8cH6IEqi9YJ7WNnDgtd8aB4odnaBSSk6pd/bFyKOd4TO/SY9/eepFiB4yUPDjxZiU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3452a6-8163-4a21-3e6f-08d6be282b7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 02:48:25.6020 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6623
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkNCg0KPiANCj4gDQo+IE9uIDQvOS8xOSA5OjQyIFBNLCBTLmouIFdhbmcgd3JvdGU6DQo+ID4g
Y2FzZSBFU0FJX0hDS1RfRVhUQUwgYW5kIGNhc2UgRVNBSV9IQ0tSX0VYVEFMIHNob3VsZCBiZSBp
bmRlcGVuZGVudA0KPiBvZg0KPiA+IGVhY2ggb3RoZXIsIHNvIHJlcGxhY2UgZmFsbC10aHJvdWdo
IHdpdGggYnJlYWsuDQo+ID4NCj4gSSB0aGluayB5b3Ugc2hvdWxkIGNoYW5nZSB0aGUgc3ViamVj
dCBsaW5lIHRvOg0KPiANCj4gZml4IG1pc3NpbmcgYnJlYWsgaW4gc3dpdGNoIHN0YXRlbWVudA0K
PiANCj4gLi4uYmVjYXVzZSB5b3UgYXJlIGZpeGluZyBhIGJ1ZywgYW5kIGl0J3MgaW1wb3J0YW50
IHRvIHB1dCBlbXBoYXNpcyBvbiB0aGF0IGluDQo+IHRoZSBzdWJqZWN0IGxpbmUuDQo+IA0KPiBB
bHNvLCBub3RpY2UgdGhhdCB0aGlzIGJ1ZyBoYXMgYmVlbiBvdXQgdGhlcmUgZm9yIG1vcmUgdGhh
biA1IHllYXJzIG5vdywgc28NCj4geW91IHNob3VsZCBhbHNvIHRhZyB0aGlzIGZvciBzdGFibGUu
DQo+IA0KPiBUaGFua3MNCj4gLS0NCj4gR3VzdGF2bw0KPg0KDQpPaywgd2lsbCBzZW5kIHYzLg0K
DQogDQo+IA0KPiA+IEZpeGVzOiA0M2QyNGU3NmI2OTggKCJBU29DOiBmc2xfZXNhaTogQWRkIEVT
QUkgQ1BVIERBSSBkcml2ZXIiKQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hlbmdqaXUgV2Fu
ZyA8c2hlbmdqaXUud2FuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgaW4gdjINCj4g
PiAtIGZpeCB0aGUgZml4ZXMgdGFnLg0KPiA+DQo+ID4gIHNvdW5kL3NvYy9mc2wvZnNsX2VzYWku
YyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL2ZzbC9mc2xfZXNhaS5jIGIvc291
bmQvc29jL2ZzbC9mc2xfZXNhaS5jIGluZGV4DQo+ID4gYzc0MTBiYmZkMmFmLi5iYWQwZGZlZDZi
NjggMTAwNjQ0DQo+ID4gLS0tIGEvc291bmQvc29jL2ZzbC9mc2xfZXNhaS5jDQo+ID4gKysrIGIv
c291bmQvc29jL2ZzbC9mc2xfZXNhaS5jDQo+ID4gQEAgLTI1MSw3ICsyNTEsNyBAQCBzdGF0aWMg
aW50IGZzbF9lc2FpX3NldF9kYWlfc3lzY2xrKHN0cnVjdCBzbmRfc29jX2RhaQ0KPiAqZGFpLCBp
bnQgY2xrX2lkLA0KPiA+ICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAgY2FzZSBFU0FJ
X0hDS1RfRVhUQUw6DQo+ID4gICAgICAgICAgICAgICBlY3IgfD0gRVNBSV9FQ1JfRVRJOw0KPiA+
IC0gICAgICAgICAgICAgLyogZmFsbCB0aHJvdWdoICovDQo+ID4gKyAgICAgICAgICAgICBicmVh
azsNCj4gPiAgICAgICBjYXNlIEVTQUlfSENLUl9FWFRBTDoNCj4gPiAgICAgICAgICAgICAgIGVj
ciB8PSBlc2FpX3ByaXYtPnN5bmNocm9ub3VzID8gRVNBSV9FQ1JfRVRJIDogRVNBSV9FQ1JfRVJJ
Ow0KPiA+ICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4NCg==

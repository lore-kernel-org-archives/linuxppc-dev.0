Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8518EC10F14
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 07:22:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B58B62077C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 07:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WYD8Z/rY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58B62077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pFJQ61cdzDqQj
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 17:22:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.1.73; helo=eur02-he1-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="WYD8Z/rY"; 
 dkim-atps=neutral
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10073.outbound.protection.outlook.com [40.107.1.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pFGd0njBzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 17:20:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzYZ8k/xwFlpnxVTDLuD7P1dR1EuyUQ5Ze98w2LnEeA=;
 b=WYD8Z/rY0lzKAyuPKjL948Xne9K0ZApPHrbp3OytxPvE130IDDpdK3HBtvgWDGFPEeOfmTZ37EXw1HhYVE1X+luDQwKLzolz1Eqa+aR4bq8AHRu1zk4ENG3CaROLpVAUnoCv9FiZV1wVKAgfkRE0FUAwn76jiN7C+NUhConDDwc=
Received: from DB7PR04MB4699.eurprd04.prod.outlook.com (20.176.233.28) by
 DB7PR04MB4796.eurprd04.prod.outlook.com (20.176.233.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Tue, 23 Apr 2019 07:20:29 +0000
Received: from DB7PR04MB4699.eurprd04.prod.outlook.com
 ([fe80::410f:7b79:6b3c:1fe5]) by DB7PR04MB4699.eurprd04.prod.outlook.com
 ([fe80::410f:7b79:6b3c:1fe5%5]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 07:20:28 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Daniel Baluta <daniel.baluta@nxp.com>, "broonie@kernel.org"
 <broonie@kernel.org>
Subject: Re: [PATCH v3 0/3] Add runtime PM for SAI digital audio interface
Thread-Topic: [PATCH v3 0/3] Add runtime PM for SAI digital audio interface
Thread-Index: AQHU+T3tSn5Uzcioa0qU6cJ3oZM02aZJV5EA
Date: Tue, 23 Apr 2019 07:20:28 +0000
Message-ID: <1556004028.2595.2.camel@nxp.com>
References: <20190422190213.30726-1-daniel.baluta@nxp.com>
In-Reply-To: <20190422190213.30726-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d42e8eaf-5f72-46aa-c7e2-08d6c7bc29e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB7PR04MB4796; 
x-ms-traffictypediagnostic: DB7PR04MB4796:
x-microsoft-antispam-prvs: <DB7PR04MB47962176DF24F39A7500DEDB92230@DB7PR04MB4796.eurprd04.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(376002)(39860400002)(366004)(346002)(189003)(199004)(6512007)(4326008)(5660300002)(73956011)(8936002)(66946007)(76176011)(102836004)(76116006)(66476007)(43066004)(64756008)(476003)(66556008)(6506007)(86362001)(486006)(11346002)(26005)(2616005)(91956017)(66446008)(256004)(446003)(14444005)(68736007)(8676002)(186003)(81156014)(81166006)(36756003)(99286004)(6486002)(6436002)(97736004)(2906002)(71200400001)(316002)(7736002)(305945005)(6116002)(103116003)(110136005)(7416002)(54906003)(66066001)(71190400001)(2501003)(229853002)(53936002)(14454004)(478600001)(44832011)(25786009)(3450700001)(6246003)(3846002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR04MB4796;
 H:DB7PR04MB4699.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zAUx0aGBFLGqetBKh1xyFLnJsv9O1n9lG3YRARlRbq6Cb1kXKsUUh+xaS0mNdmMFXP4SqHWg+V90OMfCbU6mckohQgQCScl8+Zm5mwAuzpINRMmG/ARC6kpymzIs3iahYE/xIylHFEQrEGktlSNvxgW9HXqEU9D4a+JxEVb2WDfPgTA9TC2Pbua1K5uN7ioO8LMXgqtsedv9oVlA6x3sHHmmB8J0glE48uaGnK+q37S8vttJ3VoYOAnZFosLX8jGgRKPoqNXwfmArv4xdkaAX1SuVIcMbvCKRtYvM+dcY9JDYuizw+hRtnLYEbUusBAFdo+etEEX/Mb20HB+OPgDRyKpwpNgQODPbXMwsRYyhyhgf5fGgPckUn+tf2318QGP221BzIE2yuSJ7X3KKgxBGCKH61hgkQ6rVR/nvz8JV54=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49DC249CD2CE524181637C22138BD5A6@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d42e8eaf-5f72-46aa-c7e2-08d6c7bc29e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 07:20:28.7978 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4796
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
Reply-To: Viorel Suman <viorel.suman@nxp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "S.j. Wang" <shengjiu.wang@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tiwai@suse.com" <tiwai@suse.com>, dl-linux-imx <linux-imx@nxp.com>,
 "perex@perex.cz" <perex@perex.cz>, "festevam@gmail.com" <festevam@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Rm9yIHRoaXMgc2VyaWVzOg0KDQpSZXZpZXdlZC1ieTogVmlvcmVsIFN1bWFuIDx2aW9yZWwuc3Vt
YW5AbnhwLmNvbT4NCg0KT24gTHUsIDIwMTktMDQtMjIgYXQgMTk6MDIgKzAwMDAsIERhbmllbCBC
YWx1dGEgd3JvdGU6DQo+IEZpcnN0IHBhdGNoIGZpeGVzIGEgYnVnIGJ5IGNvcnJlY3RseSBzZXR0
aW5nIGlzX3NsYXZlX21vZGUsIHRoZW4NCj4gc2Vjb25kIHBhdGNoIGFkZHMgc3VwcG9ydCBmb3Ig
cnVudGltZSBQTSBhbmQgZmluYWxseSAzcmQgcGF0Y2ggbW92ZXMNCj4gY2xvY2sgaGFuZGxpbmcg
ZnJvbSBzdGFydHVwL3NodHVkb3duIGZ1bmN0aW9uIHRvIHJ1bnRpbWUgUE0gaGFuZGxlcnMuDQo+
IA0KPiBDaGFuZ2VzIHNpbmNlIHYyOiAoYWZ0ZXIgVmlvcmVsJ3MgY29tbWVudHMpDQo+IAktIG5v
IG5lZWQgdG8gY2hlY2sgZm9yIGlzX3NsYXZlX21vZGUgd2hlbiBlbmFibGluZy9kaXNhYmxpbmcg
dGhlIGNsb2Nrcw0KPiAJYmVjYXVzZSBzYWktPm1jbGtfc3RyZWFtcyBpcyBvbmx5IHNldCB3aGVu
IFNBSSBpcyBpbiBtYXN0ZXIgbW9kZS4NCj4gDQo+IENoYW5nZXMgc2luY2UgdjE6IChhZnRlciBO
aWNvbGluJ3MgY29tbWVudHMpDQo+IAktIGFkZGVkIHBhdGNoIDENCj4gCS0gYWRkZWQgZnNsX3Nh
aV9yZW1vdmUgaW4gb3JkZXIgdG8gY2FsbCBwbV9ydW50aW1lX2Rpc2FibGUNCj4gCS0gb25seSBk
aXNhYmxlL2VuYWJsZSBtY2xrIHdoZW4gU0FJIGluIG1hc3RlciBtb2RlLg0KPiANCj4gRGFuaWVs
IEJhbHV0YSAoMik6DQo+IMKgIEFTb0M6IGZzbF9zYWk6IFVwZGF0ZSBpc19zbGF2ZV9tb2RlIHdp
dGggY29ycmVjdCB2YWx1ZQ0KPiDCoCBBU29DOiBmc2xfc2FpOiBBZGQgc3VwcG9ydCBmb3IgcnVu
dGltZSBwbQ0KPiANCj4gU2hlbmdqaXUgV2FuZyAoMSk6DQo+IMKgIEFTb0M6IGZzbF9zYWk6IE1v
dmUgY2xvY2sgb3BlcmF0aW9uIHRvIFBNIHJ1bnRpbWUNCj4gDQo+IMKgc291bmQvc29jL2ZzbC9m
c2xfc2FpLmMgfCA3OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0K
PiDCoDEgZmlsZSBjaGFuZ2VkLCA2MyBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4g
DQo+IC0twqANCj4gMi4xNy4xDQo+IA==

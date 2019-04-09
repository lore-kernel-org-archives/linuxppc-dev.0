Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8079FC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 08:58:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B936A20880
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 08:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P+hWwkLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B936A20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dh5S4JYfzDqFS
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 18:58:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.14.79; helo=eur01-ve1-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="P+hWwkLS"; 
 dkim-atps=neutral
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr140079.outbound.protection.outlook.com [40.107.14.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dh373TcvzDqFS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 18:56:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyyxUsl4HoHT3XA8wr35YBd6ebO34tXLUeqZ6g0OAzg=;
 b=P+hWwkLSQDnSUzrMrm1T4X/BMOBJJpBu9bNCIiX54eWBHptI09TyIDB3Q2Ib3CPYNs8k9lMq67KofzuUSB7ToiEAHnZrFdplJj9B+mBpJAiMASF/bCqYn/7/LH3O56fGQhhTKe7lgFsZJa0LlZBa+Crw9RAQQsWdjQffXi1vlVE=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB4399.eurprd04.prod.outlook.com (20.177.55.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Tue, 9 Apr 2019 08:55:53 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888%3]) with mapi id 15.20.1792.009; Tue, 9 Apr 2019
 08:55:53 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com"
 <Xiubo.Lee@gmail.com>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "tiwai@suse.com" <tiwai@suse.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "shawnguo@kernel.org"
 <shawnguo@kernel.org>, "Julia.Lawall@lip6.fr" <Julia.Lawall@lip6.fr>,
 "perex@perex.cz" <perex@perex.cz>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>
Subject: Re: [PATCH 0/2] ASoC: fsl: audmix: fix two issues
Thread-Topic: [PATCH 0/2] ASoC: fsl: audmix: fix two issues
Thread-Index: AQHU7q8yBr+pG49UL0OPQueKZODeUqYzhrSA
Date: Tue, 9 Apr 2019 08:55:53 +0000
Message-ID: <1554800153.2729.5.camel@nxp.com>
References: <1554798876-20653-1-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1554798876-20653-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1085a39-bc18-4300-951e-08d6bcc92c2c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR04MB4399; 
x-ms-traffictypediagnostic: VI1PR04MB4399:
x-microsoft-antispam-prvs: <VI1PR04MB4399D17E4989994A9C5AB0B3922D0@VI1PR04MB4399.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(366004)(199004)(189003)(6506007)(103116003)(102836004)(476003)(446003)(11346002)(486006)(110136005)(76176011)(316002)(106356001)(2616005)(99286004)(256004)(2501003)(105586002)(71200400001)(25786009)(97736004)(54906003)(4326008)(3450700001)(26005)(44832011)(53936002)(71190400001)(43066004)(186003)(14454004)(81156014)(66066001)(229853002)(8676002)(3846002)(81166006)(8936002)(6512007)(6116002)(5660300002)(6486002)(2906002)(4744005)(86362001)(478600001)(6246003)(7416002)(36756003)(2201001)(68736007)(6436002)(305945005)(7736002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4399;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WZd5C2b1+4FtqaRdnffV+fwu53QuajMEiHIKdITvaOUy9FXEWtaEaoT1kHPhACIuUAdrpBgqpYX6eFgGpu1x726NXS4sU6RX/JfVTU/Jx1djwRNDAUHt7miCBSr93VwzZBifQjGonA4DHuHOX795I6o+4I87M3vPi1VgH4GwsCChWwqsXqSA/1XpexJPDWr+gFHbyFPd/zzG+QKQulY/X58LbVOK9qeIax5sDmD/M393/PoG/CChqcTNnydz/rf587hSLb7L4MeNThdHCEvnVkJjS2my6PxzMWmw4Ja7OyfCMcNRGiI17h+efgxfg2vl0u4SMBZ2NLLm8h7IjNpIV+zQ8D0xt5LxeYKeW9jo3PmsG/CZY9M1irXMreddPDgSE0dTNdTwAr5LboAwQ2yf/3NYRZ1YjBdoJXuQGCWwrzg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0599532AC1B14B4F96A1D6EB5C7FA96F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1085a39-bc18-4300-951e-08d6bcc92c2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 08:55:53.4751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4399
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "viorel.suman@gmail.com" <viorel.suman@gmail.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

UGxlYXNlIGlnbm9yZSB0aGlzIHNlcmllcywgdGhlIGRldmljZSBiaW5kaW5ncyBkb2N1bWVudGF0
aW9uLCBbMV0sDQpzdGlsbCBjb250YWlucyAibW9kZWwiIGF0dHJpYnV0ZS4gV2lsbCBzZW5kIFYy
Lg0KDQpbMV0gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL2ZzbCxhdWRt
aXgudHh0DQoNClJlZ2FyZHMsDQpWaW9yZWwNCg0KT24gTWEsIDIwMTktMDQtMDkgYXQgMDg6MzUg
KzAwMDAsIFZpb3JlbCBTdW1hbiB3cm90ZToNCj4gVGhlIGxhdGVzdCBhdWRtaXggcGF0Y2gtc2V0
ICh2NSkgaGFkIHRoZSAibW9kZWwiIGF0dHJpYnV0ZQ0KPiByZW1vdmVkIGFzIHJlcXVlc3RlZCBi
eSBOaWNvbGluIENoZW4sIGJ1dCBsb29rcyBsaWtlICh2NCkNCj4gdmVyc2lvbiBvZiBEQUkgZHJp
dmVyIHJlYWNoZWQgImZvci1uZXh0IiBicmFuY2ggLSBmaXggdGhpcy4NCj4gQXNzaWRlIG9mIHRo
aXMgZml4IG9iamVjdCByZWZlcmVuY2UgbGVha3MgaW4gbWFjaGluZSBwcm9iZSByZXBvcnRlZA0K
PiBieSBKdWxpYSBMYXdhbGwuDQo+IA0KPiBWaW9yZWwgU3VtYW4gKDIpOg0KPiDCoCBBU29DOiBm
c2xfYXVkbWl4OiByZW1vdmUgIm1vZGVsIiBhdHRyaWJ1dGUNCj4gwqAgQVNvQzogaW14LWF1ZG1p
eDogZml4IG9iamVjdCByZWZlcmVuY2UgbGVha3MgaW4gcHJvYmUNCj4gDQo+IMKgc291bmQvc29j
L2ZzbC9mc2xfYXVkbWl4LmMgfCA2MSArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
DQo+IC0tLS0tLS0tLS0tLQ0KPiDCoHNvdW5kL3NvYy9mc2wvaW14LWF1ZG1peC5jIHwgMzEgKysr
KysrKysrLS0tLS0tLS0tLS0tLS0NCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDQzIGluc2VydGlvbnMo
KyksIDQ5IGRlbGV0aW9ucygtKQ0KPiANCj4gLS3CoA0KPiAyLjcuNA0KPiA=

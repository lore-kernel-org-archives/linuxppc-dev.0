Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B6CC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 06:59:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82FF321848
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 06:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UmFtnqjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82FF321848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443Wn833cMzDqLc
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 17:59:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.13.88; helo=eur01-he1-obe.outbound.protection.outlook.com;
 envelope-from=xiaowei.bao@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="UmFtnqjh"; 
 dkim-atps=neutral
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr130088.outbound.protection.outlook.com [40.107.13.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443WlJ4GnlzDqD5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 17:57:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GbqqyOlSeWEW/dW4CAuEgaNDp614PzeI1mdf8ztBKI=;
 b=UmFtnqjhtfoPw7x72RzOhlRRwdX6f8TXJ29qPUpzeklFemOWy4Yq9vR3Yb48LOE2tuVylZCaIb3ysa/C5VlMmn5TnZN4dijuQL2YQSrB7COVSSKgLzuE3OiKaGWFmt7aSRCd/sJ3aBDW/Jpa+kVfLjtxhL5UUpBmbTZ+o7p9lpw=
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com (10.173.255.158) by
 AM5PR04MB3298.eurprd04.prod.outlook.com (10.173.255.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Tue, 19 Feb 2019 06:57:39 +0000
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::71c1:f568:492e:5224]) by AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::71c1:f568:492e:5224%5]) with mapi id 15.20.1622.018; Tue, 19 Feb 2019
 06:57:39 +0000
From: Xiaowei Bao <xiaowei.bao@nxp.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCHv6 1/4] dt-bindings: add DT binding for the layerscape PCIe
 controller with EP mode
Thread-Topic: [PATCHv6 1/4] dt-bindings: add DT binding for the layerscape
 PCIe controller with EP mode
Thread-Index: AQHUsh0wu+SS2+d7kEOaRuurfCJT/qXRlcWAgBVGN5A=
Date: Tue, 19 Feb 2019 06:57:39 +0000
Message-ID: <AM5PR04MB3299AE3A36D909AC192810D5F57C0@AM5PR04MB3299.eurprd04.prod.outlook.com>
References: <20190122063328.25228-1-xiaowei.bao@nxp.com>
 <20190205180247.GA13891@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190205180247.GA13891@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82631fad-0112-4bc5-74bf-08d6963789c5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM5PR04MB3298; 
x-ms-traffictypediagnostic: AM5PR04MB3298:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtBTTVQUjA0TUIzMjk4OzIzOk90QXNuRForZVRMenNJclNiYWRPT25MRzVQ?=
 =?gb2312?B?TEk4RWdTY2tNT2hKaGNwZ3BnR0dlU2NCRVVabE9Sc0V0UmhtVFptOFFYekFx?=
 =?gb2312?B?eW8yWWMrc3ZTVjJ0YXNUamN2TUxXb01zYVJTR3hJamlUdFd1clZBZjIvb0Ur?=
 =?gb2312?B?VFZlUWw5UndXQlVHbzZCSUFhRFNCQzlhM3V5eWxwYTB3ZzZwZFJ1SldqVWVD?=
 =?gb2312?B?WnJGckU2ODBRNUcrVGh4TWkxbktmTlpJWXV0ZWx2bEU4cUxhSmloSVpBWjk5?=
 =?gb2312?B?M1V2MTZOZTVRVUNON1dZZnpxajNZMm0rYjBBeXoxbXhzcWM3dittTTZkdjVx?=
 =?gb2312?B?VTR6WVA1Rk43SW9jYnVNL2hKbTJQMklZWlFUeGt4dnloQmp5bmYxMGNFbGtO?=
 =?gb2312?B?a1l4TVFGa25IU0NMNEF3ckVqdGpqSG1WZ0RidWFZWFBCU0NwRjN4RkFoTDR3?=
 =?gb2312?B?NE9ibE1rQm55b3o0TFg1VHAvczd3Q1hjSXAwSWNhN3UwVWxzLzB6RG9zRWt1?=
 =?gb2312?B?b2hHcjlVdE1UeWNxbjIvZzVRdnFBdnVNQlpTUXNlci8wVWYrYWU5NGphaVpN?=
 =?gb2312?B?VU9rN1VsZCt3bXJvcXprTVV0N1NWT1pXWi90ajRKUFhDMVFOYUdONmpJT29p?=
 =?gb2312?B?RW1xYlhlYm01L2hoemJHQXRXYVIvd1M2QUxGdGpaK1FGZk1kYnRJNmdhaXJM?=
 =?gb2312?B?RXM5L0tlVHZUNTNMc21yUGxBNjhOaGVvSFhEK1JHL0UxNmJ0NWxOckF1eEth?=
 =?gb2312?B?QWR5OUdiZzc1eTE4Y3NrWFNodnowSnF6ZnlkMTBKcHZxNUZ2MngrMmJoVXZS?=
 =?gb2312?B?a1F3blRMWWdZRUpnZXdlNE1MZm1qZzZRVUJ2cVdzdklZT29rKyttaHlnaEFE?=
 =?gb2312?B?ZkhMSjNIaGlNMlhmMUs0djJFRlI0a25teGY1a2tVS2N5dHdLdnh2Umc4V09x?=
 =?gb2312?B?LzlXNXV2UW1vN3drMDhmWXlNcUFuRFpwSk1wZjBkYXFraE5ab01UV2NoUEFH?=
 =?gb2312?B?YkNoME9zVU0wZTdqdXplNk9GMUNpQndEbTZNYXdFNytqdC9TVURtYXZWOE5n?=
 =?gb2312?B?eUlpWDhZUkJVTDJpL01nY0hrMmh1cDZkV0U1Nm1wSU9icGcyQTZiWks1cjF5?=
 =?gb2312?B?SFZkTjJrZmFoKzF2cDBya1pSRkFrTGRsZXRHejhPZzc1VFZrWjNSZCt6cUow?=
 =?gb2312?B?U1pPeDZwdFoyTjdlY0U5RzRHSDlYM3NFSHluN0tta0NvUjdRbEc3L25nSzht?=
 =?gb2312?B?KzBna0l4LytTR3NlZTV5WVVhcXIrbjlZSXViWHo0S3E5UjJZZTRWRUhVRG15?=
 =?gb2312?B?L3NCMkdZa1BaMnM2TGVaOXhWT0MyS3h2Nm4wMERmRzFuakU3MzFuNHJhdmEx?=
 =?gb2312?B?STlSamo4WEo1WTR5SmticHJYdHVna3VMS1E0THk5SnMyeGNmUWkxQjF2NmFa?=
 =?gb2312?B?S0RLMU1IWUZEQVZZMEN0Y2czMWREbUNjUWNOdWRNbGJHT1dQZ3hJUGZnRTRF?=
 =?gb2312?B?aENPQ2RVeWpOazl0QlExelI4TjVKRkwvSTFiVHlTRy9XbGFEcmpPcUU0QVpi?=
 =?gb2312?B?Z0h1ZHh5ZmNJcUtoYkpKYzVobGJzc2JjTFg2cVUzeGNvbC91MXk4UTdWMEpS?=
 =?gb2312?B?RVBOVnVrbnRHTnVFdlBiM3VZTWRwQlNaNmFBMUo5dkRnZGhDV1ZKRXMzaVJ0?=
 =?gb2312?Q?4L+bEzwvwEm5wnXHSl830J4GL/ak2ZdNQ0D4wrq?=
x-microsoft-antispam-prvs: <AM5PR04MB32988DEBACED042CD88850CFF57C0@AM5PR04MB3298.eurprd04.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(376002)(366004)(39860400002)(346002)(189003)(13464003)(199004)(11346002)(446003)(478600001)(26005)(486006)(316002)(8936002)(186003)(44832011)(229853002)(71190400001)(71200400001)(102836004)(74316002)(66066001)(86362001)(2906002)(106356001)(6916009)(53546011)(3846002)(14454004)(5660300002)(476003)(6116002)(6506007)(105586002)(6246003)(53936002)(99286004)(6436002)(4326008)(76176011)(7416002)(256004)(7736002)(97736004)(8676002)(54906003)(25786009)(9686003)(81156014)(68736007)(55016002)(305945005)(81166006)(33656002)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR04MB3298;
 H:AM5PR04MB3299.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RYD/TqfM7ILteOiI6I8obVsvjd+tBybKqpzN4l7ukqdarxkMOo2A6peGDNlXt6IeHw5nrqwPhyxg06x3Cxq6UqewjGsVtLwm11MwZqMgF4p4NWplS6+F/hMgSYg8y7DBQzgecJlMasmIaHs0w3wvVxBI6bxRJMaQN0+KfaZH7ytGvE8SmaDLadtfSL1v0mdlZqjROCSTWh/DlhQaGjtf+4ZuGDn67qUexKlhyf+46yUOdWAasPpDS8NaPRrU5xOM5pCEo2g0SFHHL66haytKVAfWS71VJ2X3H1ymcchcYPIKkIP3DxGyQR9IL6IOBg3sLQ7qC4MPZ7UCf6+jIMI1gDt0apKT4hEy3wB2A3UH02aW90/QBCgD4uTFPzISRjRKk7AKpjVpXlpyVhQgP0LoDAs4dvfpGET2q5F19PMS+m0=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82631fad-0112-4bc5-74bf-08d6963789c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 06:57:39.6139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3298
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, Roy Zang <roy.zang@nxp.com>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kishon@ti.com" <kishon@ti.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "cyrille.pitchen@free-electrons.com" <cyrille.pitchen@free-electrons.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "pombredanne@nexb.com" <pombredanne@nexb.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, Leo Li <leoyang.li@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
 Mingkai Hu <mingkai.hu@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMb3JlbnpvIFBpZXJhbGlzaSA8
bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT4gDQpTZW50OiAyMDE5xOoy1MI2yNUgMjowMw0KVG86
IFhpYW93ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29tPg0KQ2M6IGJoZWxnYWFzQGdvb2dsZS5j
b207IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtl
cm5lbC5vcmc7IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsga2lzaG9uQHRpLmNvbTsgYXJu
ZEBhcm5kYi5kZTsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IE0uaC4gTGlhbiA8bWluZ2h1
YW4ubGlhbkBueHAuY29tPjsgTWluZ2thaSBIdSA8bWluZ2thaS5odUBueHAuY29tPjsgUm95IFph
bmcgPHJveS56YW5nQG54cC5jb20+OyBrc3Rld2FydEBsaW51eGZvdW5kYXRpb24ub3JnOyBjeXJp
bGxlLnBpdGNoZW5AZnJlZS1lbGVjdHJvbnMuY29tOyBwb21icmVkYW5uZUBuZXhiLmNvbTsgc2hh
d24ubGluQHJvY2stY2hpcHMuY29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJz
Lm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSHY2IDEvNF0gZHQtYmluZGluZ3M6IGFkZCBEVCBiaW5k
aW5nIGZvciB0aGUgbGF5ZXJzY2FwZSBQQ0llIGNvbnRyb2xsZXIgd2l0aCBFUCBtb2RlDQoNCk9u
IFR1ZSwgSmFuIDIyLCAyMDE5IGF0IDAyOjMzOjI1UE0gKzA4MDAsIFhpYW93ZWkgQmFvIHdyb3Rl
Og0KPiBBZGQgdGhlIGRvY3VtZW50YXRpb24gZm9yIHRoZSBEZXZpY2UgVHJlZSBiaW5kaW5nIGZv
ciB0aGUgbGF5ZXJzY2FwZSANCj4gUENJZSBjb250cm9sbGVyIHdpdGggRVAgbW9kZS4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFhpYW93ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29tPg0KPiBSZXZp
ZXdlZC1ieTogTWluZ2h1YW4gTGlhbiA8bWluZ2h1YW4ubGlhbkBueHAuY29tPg0KPiBSZXZpZXdl
ZC1ieTogWmhpcWlhbmcgSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gUmV2aWV3ZWQtYnk6
IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiB2MjoNCj4gIC0gQWRk
IHRoZSBTb0Mgc3BlY2lmaWMgY29tcGF0aWJsZXMuDQo+IHYzOg0KPiAgLSBtb2RpZnkgdGhlIGNv
bW1pdCBtZXNzYWdlLg0KPiB2NDoNCj4gIC0gbm8gY2hhbmdlLg0KPiB2NToNCj4gIC0gbm8gY2hh
bmdlLg0KPiB2NjoNCj4gIC0gbm8gY2hhbmdlLg0KPiANCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BjaS9sYXllcnNjYXBlLXBjaS50eHQgICAgIHwgICAgMyArKysNCj4gIDEgZmlsZXMgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQ0KDQpBcHBsaWVkIHRoZSBzZXJp
ZXMgdG8gcGNpL2xheWVyc2NhcGUgZm9yIHY1LjEsIHRoYW5rcy4NCltYaWFvd2VpIEJhb10gSGkg
TG9yZW56bywgdGhhbmsgYSBsb3QuDQoNCkxvcmVuem8NCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2kudHh0IA0KPiBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2kudHh0DQo+
IGluZGV4IDliMmI4ZDYuLmUyMGNlYWEgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2kudHh0DQo+ICsrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2kudHh0DQo+IEBAIC0x
Myw2ICsxMyw3IEBAIGluZm9ybWF0aW9uLg0KPiAgDQo+ICBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0K
PiAgLSBjb21wYXRpYmxlOiBzaG91bGQgY29udGFpbiB0aGUgcGxhdGZvcm0gaWRlbnRpZmllciBz
dWNoIGFzOg0KPiArICBSQyBtb2RlOg0KPiAgICAgICAgICAiZnNsLGxzMTAyMWEtcGNpZSINCj4g
ICAgICAgICAgImZzbCxsczIwODBhLXBjaWUiLCAiZnNsLGxzMjA4NWEtcGNpZSINCj4gICAgICAg
ICAgImZzbCxsczIwODhhLXBjaWUiDQo+IEBAIC0yMCw2ICsyMSw4IEBAIFJlcXVpcmVkIHByb3Bl
cnRpZXM6DQo+ICAgICAgICAgICJmc2wsbHMxMDQ2YS1wY2llIg0KPiAgICAgICAgICAiZnNsLGxz
MTA0M2EtcGNpZSINCj4gICAgICAgICAgImZzbCxsczEwMTJhLXBjaWUiDQo+ICsgIEVQIG1vZGU6
DQo+ICsJImZzbCxsczEwNDZhLXBjaWUtZXAiLCAiZnNsLGxzLXBjaWUtZXAiDQo+ICAtIHJlZzog
YmFzZSBhZGRyZXNzZXMgYW5kIGxlbmd0aHMgb2YgdGhlIFBDSWUgY29udHJvbGxlciByZWdpc3Rl
ciBibG9ja3MuDQo+ICAtIGludGVycnVwdHM6IEEgbGlzdCBvZiBpbnRlcnJ1cHQgb3V0cHV0cyBv
ZiB0aGUgY29udHJvbGxlci4gTXVzdCBjb250YWluIGFuDQo+ICAgIGVudHJ5IGZvciBlYWNoIGVu
dHJ5IGluIHRoZSBpbnRlcnJ1cHQtbmFtZXMgcHJvcGVydHkuDQo+IC0tDQo+IDEuNy4xDQo+IA0K

Return-Path: <SRS0=Ntje=PC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB66BC64E79
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Dec 2018 02:01:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE74A217D6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Dec 2018 02:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g1SJKFPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE74A217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43NzqN3BxRzDqKN
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Dec 2018 13:01:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="g1SJKFPs";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.6.59; helo=eur04-db3-obe.outbound.protection.outlook.com;
 envelope-from=qiang.zhao@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="g1SJKFPs"; 
 dkim-atps=neutral
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60059.outbound.protection.outlook.com [40.107.6.59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43NzmL00DWzDqPj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Dec 2018 12:58:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zE2/9nvHqoqGZ5KQLE5uW+EJrjUwTjFW5v3q6DDb0rk=;
 b=g1SJKFPs0lCdKSo0rbxn83o7bIbb1W23++BhZAOwnYYkpprnrbjT3QPr5I0Vm/zegspHdBmY1W/gYTASkIaxwBI/8JBABIKplD/OS4joBh735Ls4ixTqgy3s8q3gbkPh9MQE/kFfilt3JKZJWbRTrT371WXrnFsKlenDVizhc0U=
Received: from VI1PR04MB3247.eurprd04.prod.outlook.com (10.170.232.160) by
 VI1PR04MB5039.eurprd04.prod.outlook.com (20.177.50.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Tue, 25 Dec 2018 01:58:48 +0000
Received: from VI1PR04MB3247.eurprd04.prod.outlook.com
 ([fe80::54b7:be4f:39b6:2b7c]) by VI1PR04MB3247.eurprd04.prod.outlook.com
 ([fe80::54b7:be4f:39b6:2b7c%6]) with mapi id 15.20.1446.027; Tue, 25 Dec 2018
 01:58:47 +0000
From: Qiang Zhao <qiang.zhao@nxp.com>
To: "wang.yi59@zte.com.cn" <wang.yi59@zte.com.cn>
Subject: RE: [PATCH] soc/fsl/qe: fix err handling of ucc_of_parse_tdm
Thread-Topic: [PATCH] soc/fsl/qe: fix err handling of ucc_of_parse_tdm
Thread-Index: AQHUgi9k5H27xmdca0WbW0aTsrjmYKVwqIOAgB48SsA=
Date: Tue, 25 Dec 2018 01:58:47 +0000
Message-ID: <VI1PR04MB3247C250649F9CB3490D83A491B40@VI1PR04MB3247.eurprd04.prod.outlook.com>
References: <1542869385-48337-1-git-send-email-wang.yi59@zte.com.cn>
 <CADRPPNQ97rNJPPL8f0yqhEqTRJw9FnR0U4YCCLxrx5nDB4Ydkg@mail.gmail.com>
In-Reply-To: <CADRPPNQ97rNJPPL8f0yqhEqTRJw9FnR0U4YCCLxrx5nDB4Ydkg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiang.zhao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5039;
 6:APB4Kx7PC4IoUBMLELYlTzgkGPkKp+z8N3tLfammH6i0ITGilSGunxnYzTrbZZLQXjq2wQVvLFfrLp0iuvJFKuADoqTCoTD3JV1v7x5uSUrP5v2jo5JxJsxNgJADSnl3OHhZGyVaV85tHGZz+GlkKM2gAlEtcXRKS55zxqrN5NyxMndh2HRdYvUgFAA5movf3l2DRNb+DfUj7qVQbGrLBUs+Ep/WTv6LAywH9QAENo9sQQZvonUim1LrcpY6PvHxgsueHZ6xr3ovr0Lc9/V7D/G6ECqm8OPaqMW6Ipwg8Ze80Lerwmh+8SBLg/ejM4FJgFcL22iDsYHj41RM1aEs5anNKXk4gCWKu637nGthJqYVPSZKrqHsMLG4dbEMiJF7eKEurDucHrvJ33wqp1dMzWenKLx3Awav7vqiE/zguhFFT2qYX0pvoLv5VdPFBrp6YfVaVa8RVi9pd5q2D1mhVg==;
 5:IxUhO3exQ9eSkG1Riuv5tRtJbrFxE7YT/kMa6wPE68qYp5+o3NwQjwrxjAJ53DFhcc9VAjRa8eMeHe2BZFBgb66I9GISvDPdP9rhN75QnIXA53gTTaD61knLWRCt4BeIBqC7uwtm5Oge8sfTKpd510TrIc890YHtmWOX2rVN/G0=;
 7:Bnb1PRYbzw4s/rZnYXguVqJXUdKhbhhRWg7viG6/zwAcBGx/iHvWpNZfNztRhscsxuusUQy455t1i1ZrLjtmYFS3HTJjPLVlf3kmavcw9Xfm0OS2j/iiWeEu1VQsTNh/4QSqjvXJnk87D1KeP05HdA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1c022390-b1d4-4bc7-0fcc-08d66a0c8256
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5039; 
x-ms-traffictypediagnostic: VI1PR04MB5039:
x-microsoft-antispam-prvs: <VI1PR04MB503960BFC665233077D8338191B40@VI1PR04MB5039.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(6055026)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB5039; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB5039; 
x-forefront-prvs: 08978A8F5C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(13464003)(54906003)(8936002)(2351001)(478600001)(6916009)(14454004)(26005)(33656002)(186003)(7696005)(76176011)(68736007)(102836004)(6506007)(316002)(53546011)(305945005)(25786009)(53936002)(99286004)(3846002)(6116002)(575784001)(86362001)(4326008)(7736002)(2906002)(6246003)(8676002)(81166006)(81156014)(55016002)(9686003)(6436002)(5640700003)(71200400001)(44832011)(71190400001)(106356001)(5660300001)(476003)(11346002)(229853002)(446003)(486006)(2501003)(66066001)(105586002)(74316002)(14444005)(97736004)(256004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5039;
 H:VI1PR04MB3247.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KSoBtAuc9QcBjNi9lmqZNgiuma4JIs8gIPZhNji31R0oc7yid0GnxAkXhdUyOE/AXIsmbbE2Tlqfb0UutRLw052QAjxad9Fae6edqjUcbmfYvRM6Skau6v40G46azHjF3L/Zt72sSoUBYZ+dYA5FPKpWHhPMO3B7TonU/M3Mtrj2oSVAgksASEg6FdisLxJ8EcbYuxS6y5sUe4wtSEfr0C7YOjzi1agbJAg5mk3tu2PCh2RjfEgPfG79r/YfIR7OJZhaAWxVomLlHKfO3XVACVE5qfCnRM9b8BN6BSNubSUFKEC4rkl4W6+jaY16u/rL
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c022390-b1d4-4bc7-0fcc-08d66a0c8256
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2018 01:58:47.6672 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5039
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
Cc: "zhong.weidong@zte.com.cn" <zhong.weidong@zte.com.cn>,
 lkml <linux-kernel@vger.kernel.org>, Leo Li <leoyang.li@nxp.com>,
 "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "wen.yang99@zte.com.cn" <wen.yang99@zte.com.cn>, "moderated
 list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgV2VuLA0KDQpXaWxsIHlvdSBzZW5kIGFub3RoZXIgdmVyc2lvbiB0byByZXNvbHZlIHRoZSBp
c3N1ZSBkZXNjcmliZWQgaW4gdGhlIGNvbW1lbnRzPw0KDQpCUg0KUWlhbmcNCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaSBZYW5nIDxsZW95YW5nLmxpQG54cC5jb20+
DQo+IFNlbnQ6IDIwMTjlubQxMuaciDbml6UgNDoxMA0KPiBUbzogd2FuZy55aTU5QHp0ZS5jb20u
Y24NCj4gQ2M6IFFpYW5nIFpoYW8gPHFpYW5nLnpoYW9AbnhwLmNvbT47IHpob25nLndlaWRvbmdA
enRlLmNvbS5jbjsgbGttbA0KPiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IGp1bGlh
Lmxhd2FsbEBsaXA2LmZyOyBsaW51eHBwYy1kZXYNCj4gPGxpbnV4cHBjLWRldkBsaXN0cy5vemxh
YnMub3JnPjsgd2VuLnlhbmc5OUB6dGUuY29tLmNuOyBtb2RlcmF0ZWQNCj4gbGlzdDpBUk0vRlJF
RVNDQUxFIElNWCAvIE1YQyBBUk0gQVJDSElURUNUVVJFDQo+IDxsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHNvYy9mc2wvcWU6IGZp
eCBlcnIgaGFuZGxpbmcgb2YgdWNjX29mX3BhcnNlX3RkbQ0KPiANCj4gT24gVGh1LCBOb3YgMjIs
IDIwMTggYXQgMjo0MiBQTSBZaSBXYW5nIDx3YW5nLnlpNTlAenRlLmNvbS5jbj4gd3JvdGU6DQo+
ID4NCj4gPiBGcm9tOiBXZW4gWWFuZyA8d2VuLnlhbmc5OUB6dGUuY29tLmNuPg0KPiA+DQo+ID4g
Q3VycmVudGx5IHRoZXJlIGFyZSAyIHByb2JsZW1zIHdpdGggdGhlIHVjY19vZl9wYXJzZV90ZG0g
ZnVuY3Rpb246DQo+ID4gMSxhIHBvc3NpYmxlIG51bGwgcG9pbnRlciBkZXJlZmVyZW5jZSBpbiB1
Y2Nfb2ZfcGFyc2VfdGRtLCBkZXRlY3RlZCBieQ0KPiA+IHRoZSBzZW1hbnRpYyBwYXRjaCBkZXJl
Zl9udWxsLmNvY2NpLCB3aXRoIHRoZSBmb2xsb3dpbmcgd2FybmluZzoNCj4gPiBkcml2ZXJzL3Nv
Yy9mc2wvcWUvcWVfdGRtLmM6MTc3OjIxLTI0OiBFUlJPUjogcGRldiBpcyBOVUxMIGJ1dA0KPiBk
ZXJlZmVyZW5jZWQuDQo+ID4gMixkZXYgZ2V0cyBtb2RpZmllZCwgc28gaW4gYW55IGNhc2UgdGhh
dCBkZXZtX2lvdW5tYXAoKSB3aWxsIGZhaWwgZXZlbg0KPiA+IHdoZW4gdGhlIG5ldyBwZGV2IGlz
IHZhbGlkLCBiZWNhdXNlIHRoZSBpb21hcCB3YXMgZG9uZSB3aXRoIGEgZGlmZmVyZW50DQo+IHBk
ZXYuDQo+ID4gVGhpcyBwYXRjaCBmaXhlcyB0aGVtLg0KPiANCj4gV2hpbGUgd2UgYXJlIGF0IHRo
aXMsIEkgdGhpbmsgdGhpcyBsb2dpYyBuZWVkIG1vcmUgc2VyaW91cyBmaXhpbmcuICBJIHNlZSB0
aGVyZSBpcw0KPiBubyBkcml2ZXIgYmluZCB3aXRoIHRoZSAiZnNsLHQxMDQwLXFlLXNpIiBvciAi
ZnNsLHQxMDQwLXFlLXNpcmFtIiBkZXZpY2UuICBTbw0KPiBhbGxvY2F0aW5nIHJlc291cmNlcyB1
c2luZyBkZXZtXyooKSB3aXRoIHRoZXNlIGRldmljZXMgd29uJ3QgcHJvdmlkZSBhDQo+IGNsZWFu
dXAgcGF0aCBmb3IgdGhlc2UgcmVzb3VyY2VzIHdoZW4gdGhlIGNhbGxlciBmYWlscy4gIEkgdGhp
bmsgd2Ugc2hvdWxkDQo+IHByb2JhYmx5IGFsbG9jYXRlIHJlc291cmNlIHVuZGVyIGRldmljZSBv
ZiBjYWxsZXIgKGUuZy4gdWNjLWhkbGMpLCBzbyB0aGF0IHdoZW4NCj4gY2FsbGVyIHByb2JlIGZh
aWxzIG9yIGlzIHJlbW92ZWQgaXQgd2lsbCB0cmlnZ2VyIHRoZSBjbGVhbnVwLg0KPiANCj4gPg0K
PiA+IFN1Z2dlc3RlZC1ieTogQ2hyaXN0b3BoZSBMRVJPWSA8Y2hyaXN0b3BoZS5sZXJveUBjLXMu
ZnI+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2VuIFlhbmcgPHdlbi55YW5nOTlAenRlLmNvbS5jbj4N
Cj4gPiBDQzogSnVsaWEgTGF3YWxsIDxqdWxpYS5sYXdhbGxAbGlwNi5mcj4NCj4gPiBDQzogWmhh
byBRaWFuZyA8cWlhbmcuemhhb0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3NvYy9m
c2wvcWUvcWVfdGRtLmMgfCAyMCArKysrKysrKysrLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9zb2MvZnNsL3FlL3FlX3RkbS5jIGIvZHJpdmVycy9zb2MvZnNsL3FlL3Fl
X3RkbS5jDQo+ID4gaW5kZXggZjc4YzM0Ni4uOWEyOWYwYiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL3NvYy9mc2wvcWUvcWVfdGRtLmMNCj4gPiArKysgYi9kcml2ZXJzL3NvYy9mc2wvcWUvcWVf
dGRtLmMNCj4gPiBAQCAtNDcsNyArNDcsNyBAQCBpbnQgdWNjX29mX3BhcnNlX3RkbShzdHJ1Y3Qg
ZGV2aWNlX25vZGUgKm5wLCBzdHJ1Y3QNCj4gdWNjX3RkbSAqdXRkbSwNCj4gPiAgICAgICAgIHN0
cnVjdCByZXNvdXJjZSAqcmVzOw0KPiA+ICAgICAgICAgc3RydWN0IGRldmljZV9ub2RlICpucDI7
DQo+ID4gICAgICAgICBzdGF0aWMgaW50IHNpcmFtX2luaXRfZmxhZzsNCj4gPiAtICAgICAgIHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXY7DQo+ID4gKyAgICAgICBzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2X3NpLCAqcGRldl9zaXJhbTsNCj4gPg0KPiA+ICAgICAgICAgc3Byb3AgPSBv
Zl9nZXRfcHJvcGVydHkobnAsICJmc2wscngtc3luYy1jbG9jayIsIE5VTEwpOw0KPiA+ICAgICAg
ICAgaWYgKHNwcm9wKSB7DQo+ID4gQEAgLTEyOSwxNiArMTI5LDE2IEBAIGludCB1Y2Nfb2ZfcGFy
c2VfdGRtKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsDQo+IHN0cnVjdCB1Y2NfdGRtICp1dGRtLA0K
PiA+ICAgICAgICAgaWYgKCFucDIpDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFM
Ow0KPiA+DQo+ID4gLSAgICAgICBwZGV2ID0gb2ZfZmluZF9kZXZpY2VfYnlfbm9kZShucDIpOw0K
PiA+IC0gICAgICAgaWYgKCFwZGV2KSB7DQo+ID4gKyAgICAgICBwZGV2X3NpID0gb2ZfZmluZF9k
ZXZpY2VfYnlfbm9kZShucDIpOw0KPiA+ICsgICAgICAgaWYgKCFwZGV2X3NpKSB7DQo+ID4gICAg
ICAgICAgICAgICAgIHByX2VycigiJXBPRm46IGZhaWxlZCB0byBsb29rdXAgcGRldlxuIiwgbnAy
KTsNCj4gPiAgICAgICAgICAgICAgICAgb2Zfbm9kZV9wdXQobnAyKTsNCj4gPiAgICAgICAgICAg
ICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiAgICAgICAgIG9m
X25vZGVfcHV0KG5wMik7DQo+ID4gLSAgICAgICByZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2Uo
cGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KPiA+IC0gICAgICAgdXRkbS0+c2lfcmVncyA9IGRl
dm1faW9yZW1hcF9yZXNvdXJjZSgmcGRldi0+ZGV2LCByZXMpOw0KPiA+ICsgICAgICAgcmVzID0g
cGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXZfc2ksIElPUkVTT1VSQ0VfTUVNLCAwKTsNCj4gPiAr
ICAgICAgIHV0ZG0tPnNpX3JlZ3MgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoJnBkZXZfc2ktPmRl
diwgcmVzKTsNCj4gPiAgICAgICAgIGlmIChJU19FUlIodXRkbS0+c2lfcmVncykpIHsNCj4gPiAg
ICAgICAgICAgICAgICAgcmV0ID0gUFRSX0VSUih1dGRtLT5zaV9yZWdzKTsNCj4gPiAgICAgICAg
ICAgICAgICAgZ290byBlcnJfbWlzc19zaXJhbV9wcm9wZXJ0eTsgQEAgLTE1MCw4ICsxNTAsOCBA
QA0KPiBpbnQNCj4gPiB1Y2Nfb2ZfcGFyc2VfdGRtKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsIHN0
cnVjdCB1Y2NfdGRtICp1dGRtLA0KPiA+ICAgICAgICAgICAgICAgICBnb3RvIGVycl9taXNzX3Np
cmFtX3Byb3BlcnR5Ow0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gLSAgICAgICBwZGV2ID0gb2Zf
ZmluZF9kZXZpY2VfYnlfbm9kZShucDIpOw0KPiA+IC0gICAgICAgaWYgKCFwZGV2KSB7DQo+ID4g
KyAgICAgICBwZGV2X3NpcmFtID0gb2ZfZmluZF9kZXZpY2VfYnlfbm9kZShucDIpOw0KPiA+ICsg
ICAgICAgaWYgKCFwZGV2X3NpcmFtKSB7DQo+ID4gICAgICAgICAgICAgICAgIHJldCA9IC1FSU5W
QUw7DQo+ID4gICAgICAgICAgICAgICAgIHByX2VycigiJXBPRm46IGZhaWxlZCB0byBsb29rdXAg
cGRldlxuIiwgbnAyKTsNCj4gPiAgICAgICAgICAgICAgICAgb2Zfbm9kZV9wdXQobnAyKTsNCj4g
PiBAQCAtMTU5LDggKzE1OSw4IEBAIGludCB1Y2Nfb2ZfcGFyc2VfdGRtKHN0cnVjdCBkZXZpY2Vf
bm9kZSAqbnAsIHN0cnVjdA0KPiB1Y2NfdGRtICp1dGRtLA0KPiA+ICAgICAgICAgfQ0KPiA+DQo+
ID4gICAgICAgICBvZl9ub2RlX3B1dChucDIpOw0KPiA+IC0gICAgICAgcmVzID0gcGxhdGZvcm1f
Z2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCj4gPiAtICAgICAgIHV0ZG0t
PnNpcmFtID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKCZwZGV2LT5kZXYsIHJlcyk7DQo+ID4gKyAg
ICAgICByZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldl9zaXJhbSwgSU9SRVNPVVJDRV9N
RU0sIDApOw0KPiA+ICsgICAgICAgdXRkbS0+c2lyYW0gPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2Uo
JnBkZXZfc2lyYW0tPmRldiwgcmVzKTsNCj4gPiAgICAgICAgIGlmIChJU19FUlIodXRkbS0+c2ly
YW0pKSB7DQo+ID4gICAgICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIodXRkbS0+c2lyYW0pOw0K
PiA+ICAgICAgICAgICAgICAgICBnb3RvIGVycl9taXNzX3NpcmFtX3Byb3BlcnR5OyBAQCAtMTc0
LDcgKzE3NCw3IEBADQo+IGludA0KPiA+IHVjY19vZl9wYXJzZV90ZG0oc3RydWN0IGRldmljZV9u
b2RlICpucCwgc3RydWN0IHVjY190ZG0gKnV0ZG0sDQo+ID4gICAgICAgICByZXR1cm4gcmV0Ow0K
PiA+DQo+ID4gIGVycl9taXNzX3NpcmFtX3Byb3BlcnR5Og0KPiA+IC0gICAgICAgZGV2bV9pb3Vu
bWFwKCZwZGV2LT5kZXYsIHV0ZG0tPnNpX3JlZ3MpOw0KPiA+ICsgICAgICAgZGV2bV9pb3VubWFw
KCZwZGV2X3NpLT5kZXYsIHV0ZG0tPnNpX3JlZ3MpOw0KPiA+ICAgICAgICAgcmV0dXJuIHJldDsN
Cj4gPiAgfQ0KPiA+ICBFWFBPUlRfU1lNQk9MKHVjY19vZl9wYXJzZV90ZG0pOw0KPiA+IC0tDQo+
ID4gMi45LjUNCj4gPg0K

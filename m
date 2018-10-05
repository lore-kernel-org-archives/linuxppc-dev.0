Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BC3C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 23:56:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47C242075C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 23:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="GwQmAnWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C242075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RmqZ3bYRzF3ck
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 09:56:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="GwQmAnWb";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=toradex.com
 (client-ip=40.107.0.129; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=marcel.ziswiler@toradex.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=toradex.com header.i=@toradex.com header.b="GwQmAnWb"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00129.outbound.protection.outlook.com [40.107.0.129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Rl1h3NTFzF3R8
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 08:34:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XgDEzzvgvaJU/Wit4tXKasa7jQqLzgZpYZKhcIpHt4=;
 b=GwQmAnWbe0TJLJBAwXa99Oky7NIvagn4zkFDTokTtqf9EqcCFPgReCSDrul99N87mCcbXpTrkBAVpF+LViyfIykYXwBABIbfeIPrFffRVekOLBj+eiL7ovqLrvjnXwmnQoYGGH1eD09UKLMsFa0XvzZExGOH4FzpPxp7InotHcE=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2046.eurprd05.prod.outlook.com (10.167.195.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.23; Fri, 5 Oct 2018 22:19:54 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::99b0:2276:18cf:18aa]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::99b0:2276:18cf:18aa%3]) with mapi id 15.20.1185.029; Fri, 5 Oct 2018
 22:19:54 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "robh@kernel.org" <robh@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH 33/36] dt-bindings: arm: Convert Tegra board/soc bindings
 to json-schema
Thread-Topic: [PATCH 33/36] dt-bindings: arm: Convert Tegra board/soc bindings
 to json-schema
Thread-Index: AQHUXPmKFEQDZuFh60uTtUYVBwBFkA==
Date: Fri, 5 Oct 2018 22:19:53 +0000
Message-ID: <1538777991.28477.6.camel@toradex.com>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-34-robh@kernel.org>
In-Reply-To: <20181005165848.3474-34-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [188.155.129.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0501MB2046;
 6:8ri7mYt+5dUtXuWpwpSYlfp2n4+LIgSa41ywAM4VrD6qpNzuZ1Tsh3bHY1PQpdIduoOLlqN12kWS3NmpGP5Uu09q85FC8OjBBWiZkwvuo+MictdeXrN7KAVMUWpI3KbkW9jAoMbQv1Mw5jPU8TxzVbdsOCsoFSnSfMe8X7/+RzjU/rkWulVc626+b02Mg/5TNPJNRMhURIRGP1olNarNcn/evuvEnHl+BgEpMZcS/wRz3m2HSDD6+dPau/Ti3tUzv6/AX7vPnzQllCHurSlk3Q9dIxWOEKrMwTsxIx1WzkUPoKsKNB9sDDypGw04WBM/lAgXL2kydKILGymncLpPo/o7/xkCnJuWG5q2xPpXwzwvmAGBBTSKogZEt+4g3EfzsGlGqXKTkHV05WGS/d3hzfdROc3QZCJ8gAI25wdKdtmiVuY40flB7RKKPa2krqtM+hHH2+TAQ2Xpl69mfLG9fg==;
 5:vkPekegzyHtlY9Trz71MiFNBgL8e/0ipxPpKBzV0p9yJUt8m5GMWbYMecUVtE5TQuzOh8qgem9UDq6Fd/JLTvJgZYBDVWiK1R0MjyH/5r/yLya+2XrchN06ijlSwD9g2XZwMpEByu853j1aQQuKMgZnJNrKpEGFZ5f0NCKG4yhM=;
 7:IiTTQLTRORtYTSme/BM/RbtUQ/auSG+SRHy7sEI5V6u+8vjmaSgVTdYiUmbA5i0XGsRmAjGlUObsakEYVBO4h9srz8d8HwsB2+em75N0OaPYiaT4LGLtdtaUSpPXmL9lUytxPMUo4qhebL8spfdMGw0mLhQ6NSvbBVWD8p2LCmkD/kK/qkljzJDK55dFklX+fV9fCeyqxH9ycVBrhTlsLDCSoFNgBlrOspbbkaCrfyvmI2J951tT4TnMIvQhqrTe
x-ms-office365-filtering-correlation-id: 95ed6c49-5d0a-4750-cef8-08d62b10aceb
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0501MB2046; 
x-ms-traffictypediagnostic: VI1PR0501MB2046:
x-microsoft-antispam-prvs: <VI1PR0501MB20460E25FF8A75910D360436FBEB0@VI1PR0501MB2046.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(180628864354917)(85827821059158)(18589796830644); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(4982022)(52105095)(3002001)(93006095)(93001095)(10201501046)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);
 SRVR:VI1PR0501MB2046; BCL:0; PCL:0; RULEID:; SRVR:VI1PR0501MB2046; 
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(396003)(366004)(376002)(346002)(136003)(199004)(189003)(6116002)(6506007)(25786009)(86362001)(186003)(3846002)(71200400001)(71190400001)(36756003)(316002)(68736007)(446003)(4326008)(44832011)(102836004)(2616005)(53376002)(476003)(6246003)(26005)(256004)(99286004)(76176011)(14444005)(39060400002)(2201001)(66066001)(2900100001)(11346002)(486006)(106356001)(103116003)(229853002)(105586002)(2906002)(14454004)(97736004)(110136005)(54906003)(6512007)(6306002)(8676002)(2501003)(5250100002)(53936002)(81166006)(305945005)(5660300001)(7736002)(81156014)(8936002)(7416002)(6436002)(966005)(478600001)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR0501MB2046;
 H:VI1PR0501MB2590.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: J0uLukMIfyJoNE00A49SdBtaaWVfIxG4ko0BG/tQf6uRvAIutzDaT7oOtu9+HpimbKW7C5k60lv2Mru3n5FZJrfw0D6dC7TjW0o1enO6IphDRVBn9pK/LEp7oqLbPAWIubehbpKXoRuqoRAJpHb0TaleTlIcNMLq+AB+VKbgcyQfa8EH5xzEb5kcN1HnsdVT2/xpndIhwfLA2yQPrWH4uP64HltC6DQibMSeHy/BRmSLaUTS8G4F7/Ee2no7r8pUHxIuXQ3ao8MHakEnWb4NCZpxv8nH1OyisPfGgpuNTG+CEASOwkmS982rlnDZaFBsltYWZF9dGijS/pLHK18woboHufi5etz0DrCkpTE1UR8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B5D91AD9DD9BA42BA22AC3EA27144B7@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ed6c49-5d0a-4750-cef8-08d62b10aceb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 22:19:53.8628 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2046
X-Mailman-Approved-At: Sat, 06 Oct 2018 09:42:00 +1000
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "kumar.gala@linaro.org" <kumar.gala@linaro.org>,
 "glikely@secretlab.ca" <glikely@secretlab.ca>, "arnd@arndb.de" <arnd@arndb.de>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "pantelis.antoniou@konsulko.com" <pantelis.antoniou@konsulko.com>,
 "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "olof@lixom.net" <olof@lixom.net>,
 "geert@linux-m68k.org" <geert@linux-m68k.org>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "frowand.list@gmail.com" <frowand.list@gmail.com>,
 "jic23@kernel.org" <jic23@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgUm9iDQoNCk9uIEZyaSwgMjAxOC0xMC0wNSBhdCAxMTo1OCAtMDUwMCwgUm9iIEhlcnJpbmcg
d3JvdGU6DQo+IENvbnZlcnQgVGVncmEgU29DIGJpbmRpbmdzIHRvIERUIHNjaGVtYSBmb3JtYXQg
dXNpbmcganNvbi1zY2hlbWEuDQo+IA0KPiBDYzogTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRA
YXJtLmNvbT4NCj4gQ2M6IFRoaWVycnkgUmVkaW5nIDx0aGllcnJ5LnJlZGluZ0BnbWFpbC5jb20+
DQo+IENjOiBKb25hdGhhbiBIdW50ZXIgPGpvbmF0aGFuaEBudmlkaWEuY29tPg0KPiBDYzogZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LXRlZ3JhQHZnZXIua2VybmVsLm9y
Zw0KPiBTaWduZWQtb2ZmLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiAtLS0N
Cj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS90ZWdyYS50eHQgICAgICAgICB8IDYwIC0t
LS0tLS0tLS0tLS0NCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS90ZWdyYS55YW1sICAg
ICAgICB8IDg4DQo+ICsrKysrKysrKysrKysrKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgODgg
aW5zZXJ0aW9ucygrKSwgNjAgZGVsZXRpb25zKC0pDQo+ICBkZWxldGUgbW9kZSAxMDA2NDQgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS90ZWdyYS50eHQNCj4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL3RlZ3JhLnlh
bWwNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL3RlZ3JhLnR4dA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
dGVncmEudHh0DQo+IGRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAzMmY2MmJiNzAw
NmQuLjAwMDAwMDAwMDAwMA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvYXJtL3RlZ3JhLnR4dA0KPiArKysgL2Rldi9udWxsDQo+IEBAIC0xLDYwICswLDAgQEANCj4g
LU5WSURJQSBUZWdyYSBkZXZpY2UgdHJlZSBiaW5kaW5ncw0KPiAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAtDQo+IC1Tb0NzDQo+IC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IC0NCj4gLUVhY2ggZGV2aWNlIHRyZWUg
bXVzdCBzcGVjaWZ5IHdoaWNoIFRlZ3JhIFNvQyBpdCB1c2VzLCB1c2luZyBvbmUgb2YNCj4gdGhl
DQo+IC1mb2xsb3dpbmcgY29tcGF0aWJsZSB2YWx1ZXM6DQo+IC0NCj4gLSAgbnZpZGlhLHRlZ3Jh
MjANCj4gLSAgbnZpZGlhLHRlZ3JhMzANCj4gLSAgbnZpZGlhLHRlZ3JhMTE0DQo+IC0gIG52aWRp
YSx0ZWdyYTEyNA0KPiAtICBudmlkaWEsdGVncmExMzINCj4gLSAgbnZpZGlhLHRlZ3JhMjEwDQo+
IC0gIG52aWRpYSx0ZWdyYTE4Ng0KPiAtICBudmlkaWEsdGVncmExOTQNCj4gLQ0KPiAtQm9hcmRz
DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IC0NCj4g
LUVhY2ggZGV2aWNlIHRyZWUgbXVzdCBzcGVjaWZ5IHdoaWNoIG9uZSBvciBtb3JlIG9mIHRoZSBm
b2xsb3dpbmcNCj4gLWJvYXJkLXNwZWNpZmljIGNvbXBhdGlibGUgdmFsdWVzOg0KPiAtDQo+IC0g
IGFkLG1lZGNvbS13aWRlDQo+IC0gIGFkLHBsdXR1eA0KPiAtICBhZCx0YW1vbnRlbg0KPiAtICBh
ZCx0ZWMNCj4gLSAgY29tcGFsLHBhejAwDQo+IC0gIGNvbXB1bGFiLHRyaW1zbGljZQ0KPiAtICBu
dmlkaWEsYmVhdmVyDQo+IC0gIG52aWRpYSxjYXJkaHUNCj4gLSAgbnZpZGlhLGNhcmRodS1hMDIN
Cj4gLSAgbnZpZGlhLGNhcmRodS1hMDQNCj4gLSAgbnZpZGlhLGRhbG1vcmUNCj4gLSAgbnZpZGlh
LGhhcm1vbnkNCj4gLSAgbnZpZGlhLGpldHNvbi10azENCj4gLSAgbnZpZGlhLG5vcnJpbg0KPiAt
ICBudmlkaWEscDIzNzEtMDAwMA0KPiAtICBudmlkaWEscDIzNzEtMjE4MA0KPiAtICBudmlkaWEs
cDI1NzENCj4gLSAgbnZpZGlhLHAyNzcxLTAwMDANCj4gLSAgbnZpZGlhLHAyOTcyLTAwMDANCj4g
LSAgbnZpZGlhLHJvdGgNCj4gLSAgbnZpZGlhLHNlYWJvYXJkDQo+IC0gIG52aWRpYSx0bjcNCj4g
LSAgbnZpZGlhLHZlbnRhbmENCj4gLSAgdG9yYWRleCxhcGFsaXNfdDMwDQo+IC0gIHRvcmFkZXgs
YXBhbGlzX3QzMC1ldmFsDQo+IC0gIHRvcmFkZXgsYXBhbGlzLXRrMQ0KPiAtICB0b3JhZGV4LGFw
YWxpcy10azEtZXZhbA0KPiAtICB0b3JhZGV4LGNvbGlicmlfdDIwLTUxMg0KPiAtICB0b3JhZGV4
LGNvbGlicmlfdDMwDQo+IC0gIHRvcmFkZXgsY29saWJyaV90MzAtZXZhbC12Mw0KPiAtICB0b3Jh
ZGV4LGlyaXMNCg0KQXJlIHlvdSBhd2FyZSB0aGF0IC1uZXh0IGFscmVhZHkgZmVhdHVyZXMgYSBm
ZXcgdXBkYXRpbmcgY29tbWl0cw0KdGhlcmVvZiBmcm9tIGFyb3VuZCB0aGUgYmVnaW5uaW5nIG9m
IFNlcHRlbWJlciBvbmUgb2Ygd2hpY2ggZXZlbiBiZWFycw0KeW91ciByZXZpZXdlZC1ieS4NCg0K
PiAtDQo+IC1UcnVzdGVkIEZvdW5kYXRpb25zDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQo+IC1UZWdyYSBzdXBwb3J0cyB0aGUgVHJ1c3RlZCBGb3VuZGF0
aW9uIHNlY3VyZSBtb25pdG9yLiBTZWUgdGhlDQo+IC0idGxtLHRydXN0ZWQtZm91bmRhdGlvbnMi
IGJpbmRpbmcncyBkb2N1bWVudGF0aW9uIGZvciBtb3JlIGRldGFpbHMuDQo+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL3RlZ3JhLnlhbWwNCj4gYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL3RlZ3JhLnlhbWwNCj4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi45Y2ViY2ZhYWFkMWUNCj4gLS0t
IC9kZXYvbnVsbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJt
L3RlZ3JhLnlhbWwNCj4gQEAgLTAsMCArMSw4OCBAQA0KPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogTm9uZQ0KPiArJVlBTUwgMS4yDQo+ICstLS0NCj4gKyRpZDogaHR0cDovL2RldmljZXRy
ZWUub3JnL3NjaGVtYXMvYmluZGluZ3MvYXJtL3RlZ3JhLnlhbWwjDQo+ICskc2NoZW1hOiBodHRw
Oi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gKw0KPiArdGl0bGU6
IE5WSURJQSBUZWdyYSBkZXZpY2UgdHJlZSBiaW5kaW5ncw0KPiArDQo+ICttYWludGFpbmVyczoN
Cj4gKyAgLSBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCg0K
V293LCBzZWVtcyBJIGdvdCBwcm9tb3RlZCB0byBtYWludGFpbmVyIG5vdy4gSSBndWVzcyB0aGF0
IG1heSBtYWtlDQpzZW5zZSBhdCBsZWFzdCBmb3IgdGhlIFRvcmFkZXggYmFzZWQgYm9hcmRzLg0K
DQo+ICsgIC0gUGV0ZXIgRGUgU2NocmlqdmVyIDxwZGVzY2hyaWp2ZXJAbnZpZGlhLmNvbT4NCj4g
Kw0KPiArcHJvcGVydGllczoNCj4gKyAgY29tcGF0aWJsZToNCj4gKyAgICBvbmVPZjoNCj4gKyAg
ICAgIC0gaXRlbXM6DQo+ICsgICAgICAgICAgLSBlbnVtOg0KPiArICAgICAgICAgICAgICAtIGNv
bXBhbCxwYXowMA0KPiArICAgICAgICAgICAgICAtIGNvbXB1bGFiLHRyaW1zbGljZQ0KPiArICAg
ICAgICAgICAgICAtIG52aWRpYSxoYXJtb255DQo+ICsgICAgICAgICAgICAgIC0gbnZpZGlhLHNl
YWJvYXJkDQo+ICsgICAgICAgICAgICAgIC0gbnZpZGlhLHZlbnRhbmENCj4gKyAgICAgICAgICAt
IGNvbnN0OiBudmlkaWEsdGVncmEyMA0KPiArICAgICAgLSBpdGVtczoNCj4gKyAgICAgICAgICAt
IGVudW06DQo+ICsgICAgICAgICAgICAgIC0gYWQsbWVkY29tLXdpZGUNCj4gKyAgICAgICAgICAg
ICAgLSBhZCxwbHV0dXgNCj4gKyAgICAgICAgICAgICAgLSBhZCx0ZWMNCj4gKyAgICAgICAgICAt
IGNvbnN0OiBhZCx0YW1vbnRlbg0KPiArICAgICAgICAgIC0gY29uc3Q6IG52aWRpYSx0ZWdyYTIw
DQo+ICsgICAgICAtIGl0ZW1zOg0KPiArICAgICAgICAgIC0gY29uc3Q6IHRvcmFkZXgsaXJpcw0K
PiArICAgICAgICAgIC0gY29uc3Q6IHRvcmFkZXgsY29saWJyaV90MjAtNTEyDQo+ICsgICAgICAg
ICAgLSBjb25zdDogbnZpZGlhLHRlZ3JhMjANCj4gKyAgICAgIC0gaXRlbXM6DQo+ICsgICAgICAg
ICAgLSBlbnVtOg0KPiArICAgICAgICAgICAgICAtIG52aWRpYSxiZWF2ZXINCj4gKyAgICAgICAg
ICAtIGNvbnN0OiBudmlkaWEsdGVncmEzMA0KPiArICAgICAgLSBpdGVtczoNCj4gKyAgICAgICAg
ICAtIGVudW06DQo+ICsgICAgICAgICAgICAgIC0gbnZpZGlhLGNhcmRodS1hMDINCj4gKyAgICAg
ICAgICAgICAgLSBudmlkaWEsY2FyZGh1LWEwNA0KPiArICAgICAgICAgIC0gY29uc3Q6IG52aWRp
YSxjYXJkaHUNCj4gKyAgICAgICAgICAtIGNvbnN0OiBudmlkaWEsdGVncmEzMA0KPiArICAgICAg
LSBpdGVtczoNCj4gKyAgICAgICAgICAtIGVudW06DQo+ICsgICAgICAgICAgICAgIC0gdG9yYWRl
eCxhcGFsaXNfdDMwLWV2YWwNCj4gKyAgICAgICAgICAtIGNvbnN0OiB0b3JhZGV4LGFwYWxpc190
MzANCj4gKyAgICAgICAgICAtIGNvbnN0OiBudmlkaWEsdGVncmEzMA0KPiArICAgICAgLSBpdGVt
czoNCj4gKyAgICAgICAgICAtIGVudW06DQo+ICsgICAgICAgICAgICAgIC0gdG9yYWRleCxjb2xp
YnJpX3QzMC1ldmFsLXYzDQo+ICsgICAgICAgICAgLSBjb25zdDogdG9yYWRleCxjb2xpYnJpX3Qz
MA0KPiArICAgICAgICAgIC0gY29uc3Q6IG52aWRpYSx0ZWdyYTMwDQo+ICsgICAgICAtIGl0ZW1z
Og0KPiArICAgICAgICAgIC0gZW51bToNCj4gKyAgICAgICAgICAgICAgLSBudmlkaWEsZGFsbW9y
ZQ0KPiArICAgICAgICAgICAgICAtIG52aWRpYSxyb3RoDQo+ICsgICAgICAgICAgICAgIC0gbnZp
ZGlhLHRuNw0KPiArICAgICAgICAgIC0gY29uc3Q6IG52aWRpYSx0ZWdyYTExNA0KPiArICAgICAg
LSBpdGVtczoNCj4gKyAgICAgICAgICAtIGVudW06DQo+ICsgICAgICAgICAgICAgIC0gbnZpZGlh
LGpldHNvbi10azENCj4gKyAgICAgICAgICAgICAgLSBudmlkaWEsdmVuaWNlMg0KPiArICAgICAg
ICAgIC0gY29uc3Q6IG52aWRpYSx0ZWdyYTEyNA0KPiArICAgICAgLSBpdGVtczoNCj4gKyAgICAg
ICAgICAtIGNvbnN0OiB0b3JhZGV4LGFwYWxpcy10azEtZXZhbA0KPiArICAgICAgICAgIC0gY29u
c3Q6IHRvcmFkZXgsYXBhbGlzLXRrMQ0KPiArICAgICAgICAgIC0gY29uc3Q6IG52aWRpYSx0ZWdy
YTEyNA0KPiArICAgICAgLSBpdGVtczoNCj4gKyAgICAgICAgICAtIGVudW06DQo+ICsgICAgICAg
ICAgICAgIC0gbnZpZGlhLG5vcnJpbg0KPiArICAgICAgICAgIC0gY29uc3Q6IG52aWRpYSx0ZWdy
YTEzMg0KPiArICAgICAgICAgIC0gY29uc3Q6IG52aWRpYSx0ZWdyYTEyNA0KPiArICAgICAgLSBp
dGVtczoNCj4gKyAgICAgICAgICAtIGVudW06DQo+ICsgICAgICAgICAgICAgIC0gbnZpZGlhLHAy
MzcxLTAwMDANCj4gKyAgICAgICAgICAgICAgLSBudmlkaWEscDIzNzEtMjE4MA0KPiArICAgICAg
ICAgICAgICAtIG52aWRpYSxwMjU3MQ0KPiArICAgICAgICAgIC0gY29uc3Q6IG52aWRpYSx0ZWdy
YTIxMA0KPiArICAgICAgLSBpdGVtczoNCj4gKyAgICAgICAgICAtIGVudW06DQo+ICsgICAgICAg
ICAgICAgIC0gbnZpZGlhLHAyNzcxLTAwMDANCj4gKyAgICAgICAgICAtIGNvbnN0OiBudmlkaWEs
dGVncmExODYNCj4gKyAgICAgIC0gaXRlbXM6DQo+ICsgICAgICAgICAgLSBlbnVtOg0KPiArICAg
ICAgICAgICAgICAtIG52aWRpYSxwMjk3Mi0wMDAwDQo+ICsgICAgICAgICAgLSBjb25zdDogbnZp
ZGlhLHRlZ3JhMTk0DQoNCk90aGVyIHRoYW4gdGhhdCBJJ20gYWxsIGluIHRvIG1vdmUgdG93YXJk
cyBtb3JlIHN0cnVjdHVyZWQgYmluZGluZ3MgZG9jdW1lbnRhdGlvbi4NCg0KQ2hlZXJzDQoNCk1h
cmNlbA==

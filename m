Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BC8C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 08:26:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D64AB208A3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 08:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QE9UpgGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64AB208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438FLc69khzDqdd
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 19:26:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QE9UpgGu";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=microchip.com
 (client-ip=68.232.154.123; helo=esa4.microchip.iphmx.com;
 envelope-from=nicolas.ferre@microchip.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=microchiptechnology.onmicrosoft.com
 header.i=@microchiptechnology.onmicrosoft.com header.b="QE9UpgGu"; 
 dkim-atps=neutral
X-Greylist: delayed 639 seconds by postgrey-1.36 at bilbo;
 Tue, 04 Dec 2018 19:23:25 AEDT
Received: from esa4.microchip.iphmx.com (esa4.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438FHd70rtzDqdM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 19:23:25 +1100 (AEDT)
X-IronPort-AV: E=Sophos;i="5.56,313,1539673200"; d="scan'208";a="23506625"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 04 Dec 2018 01:12:42 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Tue, 4 Dec 2018 01:12:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1hIZ5NYxxEl1AsLPNJqk4m9Tzh28WCDDZf77b855L8=;
 b=QE9UpgGu6EkAFuM7xDUJ6dr2UKHO10SOIs7cWg3euq9vKi1OU9UB+5L8hIgZFKrbibsp02awSllYHfl1qE3SKgsaE3LAfew9aFVE2dZSz+R4p/446616uVTng5pHBu5Udry+gKdFqtWGQ2220bOaFYXqcQeciKQZYzZUBFJDdx8=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1422.namprd11.prod.outlook.com (10.169.234.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Tue, 4 Dec 2018 08:12:39 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::f55a:dbdf:f578:ac79]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::f55a:dbdf:f578:ac79%4]) with mapi id 15.20.1382.023; Tue, 4 Dec 2018
 08:12:39 +0000
From: <Nicolas.Ferre@microchip.com>
To: <robh@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 15/34] dt-bindings: arm: Convert Atmel board/soc
 bindings to json-schema
Thread-Topic: [PATCH v2 15/34] dt-bindings: arm: Convert Atmel board/soc
 bindings to json-schema
Thread-Index: AQHUi0/1D2Sqi4yAbkKsMWshl7aNb6VuO5YA
Date: Tue, 4 Dec 2018 08:12:39 +0000
Message-ID: <61c52081-7d6d-4de3-81a6-1cd074ac9adc@microchip.com>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-16-robh@kernel.org>
In-Reply-To: <20181203213223.16986-16-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0029.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::17) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB1422;
 6:uKypX5uNqnVVpZnJJkPtyrlk1OSYqa83HzUiLK/B4GRrOmJOkqquJl/eTWFif9kheAkvKy+EzcL5dYLLq9GjlxL0EaleDxDIUAEJT/RVt2zh6FiUNhRhRHKe/janvOJWRmNnUZPoWHWfmcKdnsyw3EXCHlDHC0RGpzRS/ml6AJFqItyYLukHp/j9Cz9F2fL13Pi1tfQddgmMK5CFqrkVyE05Y+wpVLtDXCbh1QaA3iWvQKKZRKzdzNYHBQRaUUzpEkBLaEuE8tm5C57wvCqILWHqXPrvVXU+CTGEH9Nn76ZHGM6+HAEQ2x56zCNhe+ykgVjvJonFYWD3bMfJAEnXRbGBGOa2baqf8bMlODOrhOATQeZMtLzUM7vv33dZehq9orJ7mO9hGtkQa6zgGBxOP3ohaEcAWYKSryeG39Gp3hY9uEGgbVs7v4Ebuvj5HH0qR9naNvM4qKFB/Um6ekDvSg==;
 5:VjEXtMAgxddvUHPH5pzNBEQ3Md3l43WYgApgiWypjjBDf1NRhBop73X8rWp7tKRU/R+vH5B5o4XVBr/inrngiRP8YtswV/uf4VrXkpqwWibWeZ0sD2L+N4+cdNgsud58hZj60X3ZWfC2Zyn22uY6yiRTgny9fefNdDjrbCdfK7o=;
 7:uVqh/V0y6Hb6K3FueGSpDlxO4BhJWw/Y8cyZ4Ve2l3xKI2E2OdlCSzsyPErR2qYSQKeGkqRhFNvtd0PvyZK8DuaJWOuJNEWHIOdwYrzbd2HXvYON0fASOgqLSYiQD+DvPR4kozkTpGTCfr4xP2IM1g==
x-ms-office365-filtering-correlation-id: 40dc8bb7-e99c-46c0-1ed4-08d659c04205
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1422; 
x-ms-traffictypediagnostic: MWHPR11MB1422:
x-microsoft-antispam-prvs: <MWHPR11MB142223373D32D982769EDFF7E0AF0@MWHPR11MB1422.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(4982022)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:MWHPR11MB1422; BCL:0; PCL:0; RULEID:; SRVR:MWHPR11MB1422; 
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(136003)(396003)(376002)(346002)(39860400002)(199004)(189003)(53936002)(5660300001)(7416002)(6512007)(229853002)(6306002)(6436002)(316002)(68736007)(53376002)(14444005)(86362001)(2201001)(71200400001)(71190400001)(31686004)(6246003)(4326008)(31696002)(486006)(7736002)(76176011)(72206003)(966005)(53546011)(386003)(52116002)(6506007)(26005)(102836004)(11346002)(186003)(6116002)(3846002)(446003)(2616005)(476003)(14454004)(2501003)(105586002)(305945005)(66066001)(106356001)(478600001)(99286004)(81156014)(97736004)(110136005)(39060400002)(6486002)(256004)(8676002)(8936002)(25786009)(54906003)(2906002)(36756003)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1422;
 H:MWHPR11MB1662.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1NBTVkC5GbZuB1AfTBbT/vj4c70JjyZSCynW2fphnM7EuWdNS2UHe+S0qhKhhO87feUdNlhTbfQw8Nq5elTcVUshqbyMGYaA8ONdEKkNKOMVCdJp9CjXwXuzUeW4yoMMqyivJZFMjjDtBS+1lns0Z1WSVotHovrIKnrFVmmHfQbC1hvuvUTCt0FfxGXZYHyZBut4IsSrEhBXCwFgcRw09x2skftcjGoDA6RLOsmLI3U8uBD1txQzl31/DHYvbgW+BC63ZefsD9Mk5YFLa5VdWUdF7NRthnrwDKrYaQzqbpjX4fXF0RsRRMeXMbEnQ7I2uFfo6GxChnvFccY7zX0RLL46Y8oWHTRqWBAOsfnuJh0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <06A52C3C66949A4CB61A5B451EA0F0DE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 40dc8bb7-e99c-46c0-1ed4-08d659c04205
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 08:12:39.7249 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1422
X-OriginatorOrg: microchip.com
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
Cc: mark.rutland@arm.com, alexandre.belloni@bootlin.com, kumar.gala@linaro.org,
 arm@kernel.org, darknighte@darknighte.com, frowand.list@gmail.com,
 grant.likely@arm.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

T24gMDMvMTIvMjAxOCBhdCAyMjozMiwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IENvbnZlcnQgQXRt
ZWwgU29DIGJpbmRpbmdzIHRvIERUIHNjaGVtYSBmb3JtYXQgdXNpbmcganNvbi1zY2hlbWEuDQo+
IA0KPiBDYzogTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT4NCj4gQ2M6IE5pY29s
YXMgRmVycmUgPG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbT4NCg0KSSdtIGxpc3RlZCBoZXJl
Li4uDQoNCj4gQ2M6IEFsZXhhbmRyZSBCZWxsb25pIDxhbGV4YW5kcmUuYmVsbG9uaUBib290bGlu
LmNvbT4NCg0KUHJvcGVyIGVtYWlsIGFkZHJlc3MgaGVyZS4uLg0KDQoNCj4gQ2M6IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4g
LS0tDQo+ICAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLWF0OTEudHh0ICAgIHwg
IDcyIC0tLS0tLS0tLS0NCj4gICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXRtZWwtYXQ5
MS55YW1sICAgfCAxMzMgKysrKysrKysrKysrKysrKysrDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAx
MzMgaW5zZXJ0aW9ucygrKSwgNzIgZGVsZXRpb25zKC0pDQo+ICAgZGVsZXRlIG1vZGUgMTAwNjQ0
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXRtZWwtYXQ5MS50eHQNCj4g
ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Fy
bS9hdG1lbC1hdDkxLnlhbWwNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLWF0OTEudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2FybS9hdG1lbC1hdDkxLnR4dA0KPiBkZWxldGVkIGZpbGUgbW9kZSAxMDA2
NDQNCj4gaW5kZXggNGJmMWI0ZGE3NjU5Li4wMDAwMDAwMDAwMDANCj4gLS0tIGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9hdG1lbC1hdDkxLnR4dA0KPiArKysgL2Rldi9u
dWxsDQo+IEBAIC0xLDcyICswLDAgQEANCj4gLUF0bWVsIEFUOTEgZGV2aWNlIHRyZWUgYmluZGlu
Z3MuDQo+IC09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KDQpbLi5dDQoNCj4gZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXRtZWwtYXQ5
MS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9hdG1lbC1hdDkx
LnlhbWwNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi4xOTQz
MWY1OGI5MDYNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvYXJtL2F0bWVsLWF0OTEueWFtbA0KPiBAQCAtMCwwICsxLDEzMyBAQA0KPiAr
IyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiArJVlBTUwgMS4yDQo+ICstLS0N
Cj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvYXJtL2F0bWVsLWF0OTEueWFt
bCMNCj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55
YW1sIw0KPiArDQo+ICt0aXRsZTogQXRtZWwgQVQ5MSBkZXZpY2UgdHJlZSBiaW5kaW5ncy4NCj4g
Kw0KPiArbWFpbnRhaW5lcnM6DQo+ICsgIC0gQWxleGFuZHJlIEJlbGxvbmkgPGFsZXhhbmRyZS5i
ZWxsb25pQGZyZWUtZWxlY3Ryb25zLmNvbT4NCj4gKyAgLSBMdWRvdmljIERlc3JvY2hlcyA8bHVk
b3ZpYy5kZXNyb2NoZXNAYXRtZWwuY29tPg0KDQouLi4gYW5kIHNvcnJ5IGJ1dCBpdCdzIG5vdCBj
b3JyZWN0IGp1c3QgYWJvdmUgXl5eDQotIHdyb25nIEx1ZG92aWMncyBlbWFpbCBhZGRyZXNzDQot
IHdyb25nIEFsZXhhbmRlcidzIGVtYWlsIGFkZHJlc3MNCi0gYW5kIEknbSBub3QgcGFydCBvZiB0
aGUgZ2FtZSBhbnltb3JlLi4uDQoNClNvIGFjdHVhbGx5IG91ciBNQUlOVEFJTkVSJ3MgZW50cnkg
aXMgdXAtdG8tZGF0ZTogcGxlYXNlIHVzZSBpdC4NCg0KDQo+ICtkZXNjcmlwdGlvbjogfA0KPiAr
ICBCb2FyZHMgd2l0aCBhIFNvQyBvZiB0aGUgQXRtZWwgQVQ5MSBvciBTTUFSVCBmYW1pbHkgc2hh
bGwgaGF2ZSB0aGUgZm9sbG93aW5nDQo+ICsNCj4gK3Byb3BlcnRpZXM6DQo+ICsgICRub2RlbmFt
ZToNCj4gKyAgICBjb25zdDogJy8nDQo+ICsgIGNvbXBhdGlibGU6DQo+ICsgICAgb25lT2Y6DQo+
ICsgICAgICAtIGl0ZW1zOg0KPiArICAgICAgICAgIC0gY29uc3Q6IGF0bWVsLGF0OTFybTkyMDAN
Cj4gKyAgICAgIC0gaXRlbXM6DQo+ICsgICAgICAgICAgLSBlbnVtOg0KPiArICAgICAgICAgICAg
ICAtIG9saW1leCxzYW05LWw5MjYwDQo+ICsgICAgICAgICAgLSBlbnVtOg0KPiArICAgICAgICAg
ICAgICAtIGF0bWVsLGF0OTFzYW05MjYwDQo+ICsgICAgICAgICAgICAgIC0gYXRtZWwsYXQ5MXNh
bTkyNjENCj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxhdDkxc2FtOTI2Mw0KPiArICAgICAgICAg
ICAgICAtIGF0bWVsLGF0OTFzYW05ZzIwDQo+ICsgICAgICAgICAgICAgIC0gYXRtZWwsYXQ5MXNh
bTlnNDUNCj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxhdDkxc2FtOW4xMg0KPiArICAgICAgICAg
ICAgICAtIGF0bWVsLGF0OTFzYW05cmwNCj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxhdDkxc2Ft
OXhlDQo+ICsgICAgICAgICAgLSBjb25zdDogYXRtZWwsYXQ5MXNhbTkNCj4gKw0KPiArICAgICAg
LSBpdGVtczoNCj4gKyAgICAgICAgICAtIGVudW06DQo+ICsgICAgICAgICAgICAgIC0gYXRtZWws
YXQ5MXNhbTlnMTUNCj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxhdDkxc2FtOWcyNQ0KPiArICAg
ICAgICAgICAgICAtIGF0bWVsLGF0OTFzYW05ZzM1DQo+ICsgICAgICAgICAgICAgIC0gYXRtZWws
YXQ5MXNhbTl4MjUNCj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxhdDkxc2FtOXgzNQ0KPiArICAg
ICAgICAgIC0gY29uc3Q6IGF0bWVsLGF0OTFzYW05eDUNCj4gKyAgICAgICAgICAtIGNvbnN0OiBh
dG1lbCxhdDkxc2FtOQ0KPiArDQo+ICsgICAgICAtIGl0ZW1zOg0KPiArICAgICAgICAgIC0gY29u
c3Q6IGF0bWVsLHNhbWE1ZDI3DQo+ICsgICAgICAgICAgLSBjb25zdDogYXRtZWwsc2FtYTVkMg0K
PiArICAgICAgICAgIC0gY29uc3Q6IGF0bWVsLHNhbWE1DQo+ICsNCj4gKyAgICAgIC0gZGVzY3Jp
cHRpb246IE5hdHRpcyB2MiBib2FyZCB3aXRoIE5hdHRlIHYyIHBvd2VyIGJvYXJkDQo+ICsgICAg
ICAgIGl0ZW1zOg0KPiArICAgICAgICAgIC0gY29uc3Q6IGF4ZW50aWEsbmF0dGlzLTINCj4gKyAg
ICAgICAgICAtIGNvbnN0OiBheGVudGlhLG5hdHRlLTINCj4gKyAgICAgICAgICAtIGNvbnN0OiBh
eGVudGlhLGxpbmVhDQo+ICsgICAgICAgICAgLSBjb25zdDogYXRtZWwsc2FtYTVkMzENCj4gKyAg
ICAgICAgICAtIGNvbnN0OiBhdG1lbCxzYW1hNWQzDQo+ICsgICAgICAgICAgLSBjb25zdDogYXRt
ZWwsc2FtYTUNCj4gKw0KPiArICAgICAgLSBkZXNjcmlwdGlvbjogVFNFLTg1MCB2MyBib2FyZA0K
PiArICAgICAgICBpdGVtczoNCj4gKyAgICAgICAgICAtIGNvbnN0OiBheGVudGlhLHRzZTg1MHYz
DQo+ICsgICAgICAgICAgLSBjb25zdDogYXhlbnRpYSxsaW5lYQ0KPiArICAgICAgICAgIC0gY29u
c3Q6IGF0bWVsLHNhbWE1ZDMxDQo+ICsgICAgICAgICAgLSBjb25zdDogYXRtZWwsc2FtYTVkMw0K
PiArICAgICAgICAgIC0gY29uc3Q6IGF0bWVsLHNhbWE1DQo+ICsNCj4gKyAgICAgIC0gaXRlbXM6
DQo+ICsgICAgICAgICAgLSBjb25zdDogYXhlbnRpYSxsaW5lYQ0KPiArICAgICAgICAgIC0gY29u
c3Q6IGF0bWVsLHNhbWE1ZDMxDQo+ICsgICAgICAgICAgLSBjb25zdDogYXRtZWwsc2FtYTVkMw0K
PiArICAgICAgICAgIC0gY29uc3Q6IGF0bWVsLHNhbWE1DQo+ICsNCj4gKyAgICAgIC0gaXRlbXM6
DQo+ICsgICAgICAgICAgLSBlbnVtOg0KPiArICAgICAgICAgICAgICAtIGF0bWVsLHNhbWE1ZDMx
DQo+ICsgICAgICAgICAgICAgIC0gYXRtZWwsc2FtYTVkMzMNCj4gKyAgICAgICAgICAgICAgLSBh
dG1lbCxzYW1hNWQzNA0KPiArICAgICAgICAgICAgICAtIGF0bWVsLHNhbWE1ZDM1DQo+ICsgICAg
ICAgICAgICAgIC0gYXRtZWwsc2FtYTVkMzYNCj4gKyAgICAgICAgICAtIGNvbnN0OiBhdG1lbCxz
YW1hNWQzDQo+ICsgICAgICAgICAgLSBjb25zdDogYXRtZWwsc2FtYTUNCj4gKw0KPiArICAgICAg
LSBpdGVtczoNCj4gKyAgICAgICAgICAtIGVudW06DQo+ICsgICAgICAgICAgICAgIC0gYXRtZWws
c2FtYTVkNDENCj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxzYW1hNWQ0Mg0KPiArICAgICAgICAg
ICAgICAtIGF0bWVsLHNhbWE1ZDQzDQo+ICsgICAgICAgICAgICAgIC0gYXRtZWwsc2FtYTVkNDQN
Cj4gKyAgICAgICAgICAtIGNvbnN0OiBhdG1lbCxzYW1hNWQ0DQo+ICsgICAgICAgICAgLSBjb25z
dDogYXRtZWwsc2FtYTUNCj4gKw0KPiArICAgICAgLSBpdGVtczoNCj4gKyAgICAgICAgICAtIGVu
dW06DQo+ICsgICAgICAgICAgICAgIC0gYXRtZWwsc2FtczcwajE5DQo+ICsgICAgICAgICAgICAg
IC0gYXRtZWwsc2FtczcwajIwDQo+ICsgICAgICAgICAgICAgIC0gYXRtZWwsc2FtczcwajIxDQo+
ICsgICAgICAgICAgICAgIC0gYXRtZWwsc2FtczcwbjE5DQo+ICsgICAgICAgICAgICAgIC0gYXRt
ZWwsc2FtczcwbjIwDQo+ICsgICAgICAgICAgICAgIC0gYXRtZWwsc2FtczcwbjIxDQo+ICsgICAg
ICAgICAgICAgIC0gYXRtZWwsc2FtczcwcTE5DQo+ICsgICAgICAgICAgICAgIC0gYXRtZWwsc2Ft
czcwcTIwDQo+ICsgICAgICAgICAgICAgIC0gYXRtZWwsc2FtczcwcTIxDQo+ICsgICAgICAgICAg
LSBjb25zdDogYXRtZWwsc2FtczcwDQo+ICsgICAgICAgICAgLSBjb25zdDogYXRtZWwsc2FtdjcN
Cj4gKw0KPiArICAgICAgLSBpdGVtczoNCj4gKyAgICAgICAgICAtIGVudW06DQo+ICsgICAgICAg
ICAgICAgIC0gYXRtZWwsc2FtdjcwajE5DQo+ICsgICAgICAgICAgICAgIC0gYXRtZWwsc2Ftdjcw
ajIwDQo+ICsgICAgICAgICAgICAgIC0gYXRtZWwsc2FtdjcwbjE5DQo+ICsgICAgICAgICAgICAg
IC0gYXRtZWwsc2FtdjcwbjIwDQo+ICsgICAgICAgICAgICAgIC0gYXRtZWwsc2FtdjcwcTE5DQo+
ICsgICAgICAgICAgICAgIC0gYXRtZWwsc2FtdjcwcTIwDQo+ICsgICAgICAgICAgLSBjb25zdDog
YXRtZWwsc2FtdjcwDQo+ICsgICAgICAgICAgLSBjb25zdDogYXRtZWwsc2FtdjcNCj4gKw0KPiAr
ICAgICAgLSBpdGVtczoNCj4gKyAgICAgICAgICAtIGVudW06DQo+ICsgICAgICAgICAgICAgIC0g
YXRtZWwsc2FtdjcxajE5DQo+ICsgICAgICAgICAgICAgIC0gYXRtZWwsc2FtdjcxajIwDQo+ICsg
ICAgICAgICAgICAgIC0gYXRtZWwsc2FtdjcxajIxDQo+ICsgICAgICAgICAgICAgIC0gYXRtZWws
c2FtdjcxbjE5DQo+ICsgICAgICAgICAgICAgIC0gYXRtZWwsc2FtdjcxbjIwDQo+ICsgICAgICAg
ICAgICAgIC0gYXRtZWwsc2FtdjcxbjIxDQo+ICsgICAgICAgICAgICAgIC0gYXRtZWwsc2Ftdjcx
cTE5DQo+ICsgICAgICAgICAgICAgIC0gYXRtZWwsc2FtdjcxcTIwDQo+ICsgICAgICAgICAgICAg
IC0gYXRtZWwsc2FtdjcxcTIxDQo+ICsgICAgICAgICAgLSBjb25zdDogYXRtZWwsc2FtdjcxDQo+
ICsgICAgICAgICAgLSBjb25zdDogYXRtZWwsc2FtdjcNCj4gKw0KPiArLi4uDQo+IA0KDQoNCi0t
IA0KTmljb2xhcyBGZXJyZQ0K

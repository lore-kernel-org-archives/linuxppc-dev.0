Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A075AC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 14:12:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C92E20827
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 14:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XmSB4Ngr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C92E20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YvMy6NTXzDqYC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 01:12:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.6.89; helo=eur04-db3-obe.outbound.protection.outlook.com;
 envelope-from=camelia.groza@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="XmSB4Ngr"; 
 dkim-atps=neutral
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60089.outbound.protection.outlook.com [40.107.6.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YvGG43GLzDqXB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 01:07:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uJnHWlyOBdF4wj1GoCNftwsSWilUr+riX5YEfsgkdY=;
 b=XmSB4Ngr8cbkwqL3ekrTFoW4T6fMQvskpEWXQOPGC+wHA9XTbfqo9UQzvYa4MI0tTo2ZoF3xly6bDUxkwRTF6h2gs//5iAnUhxlatNU/iE3VYJbrOAIB+iBxAxOQ5CTb7wHo6QCTJ6QKtH7lYOHrGJ0ZLeGei30W/eQouR6nLiE=
Received: from VI1PR04MB4799.eurprd04.prod.outlook.com (20.177.48.220) by
 VI1PR04MB6158.eurprd04.prod.outlook.com (20.179.27.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Tue, 8 Jan 2019 14:07:10 +0000
Received: from VI1PR04MB4799.eurprd04.prod.outlook.com
 ([fe80::1503:3059:d104:d46f]) by VI1PR04MB4799.eurprd04.prod.outlook.com
 ([fe80::1503:3059:d104:d46f%4]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 14:07:10 +0000
From: Camelia Alexandra Groza <camelia.groza@nxp.com>
To: Scott Wood <oss@buserror.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, 
 "mark.rutland@arm.com" <mark.rutland@arm.com>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>
Subject: RE: [PATCH 2/3] powerpc/dts/fsl: t4240rdb: use the Cortina PHY driver
 compatible
Thread-Topic: [PATCH 2/3] powerpc/dts/fsl: t4240rdb: use the Cortina PHY
 driver compatible
Thread-Index: AQHUHo0Oh6sC9upw1k6mbDT3ta+JEKWLGm8AgBtcHUA=
Date: Tue, 8 Jan 2019 14:07:10 +0000
Message-ID: <VI1PR04MB47996AC5BC20CC53F505880EF28A0@VI1PR04MB4799.eurprd04.prod.outlook.com>
References: <cover.1531903211.git.camelia.groza@nxp.com>
 <6fa5aa04d257525c5703b7c8ca833ec0ae0047c7.1531903211.git.camelia.groza@nxp.com>
 <6a64c160360bae80a4908d3ca7a887d0c0cb35c9.camel@buserror.net>
In-Reply-To: <6a64c160360bae80a4908d3ca7a887d0c0cb35c9.camel@buserror.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=camelia.groza@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB6158;
 6:20xs7NLmg8jnp989S9Bvu74IXnqt5IAAAhbmb+vJJLGtB+/TF2fsnWZgUk6acc6NixoN+Yv1g/Qc4VZM7ewCaQ0fZuohQI81uVlpj8Hti5VgioggzuDbGe3FXwfwpfjX8+kYD6/bHtOJXxaEFoh88g5qR6Pa/ksFMPpdpDbZbSyXBAd3fHPllWvPaVAQELPMtnV0+PmCRKMQu2Fswsx3HH2HiaWM4hgrEffVjslGdjBOMr3DaCkCuU/su2CnoTyMiCag74EcDtLEtOgWx3PnoR/5fiMIY470s86Nxnqzuj89/kyuTymvozZ1G9q64/N5ven9BH6KsIdeERTQV2Ow0idxu/xyD5myBeLsq9PDavrUsZjTeUOHSsfDcTmicjWQATPQjHhP9Uluz/j+X+gS7a1hg1c0rInG4SkJANkQaREQdQ+6TgA6dVbwQh3OkSMsdm8NLf0UuJWdeszoVdJe6Q==;
 5:An+nXc+Vxz1Ha5eWwlwxyxyhp53Zowm3m/RZsN6HKItU0C1kaGkcS8L005bWzK5IlEHkFvQThOdgpgQvdPeaagkBbP1IZ98a0W3ofW8KQszpfMd6QngZgpej90D78qCIcfOpVzZG/lUcIWZnE9wdDU3ziEQecizUvSgPmm15oBCtkeALlCseSASsqzC8KOF6Llnz5HgTwT1x/GCCGz0K5A==;
 7:jmSLUCYRVX6fjlGVOGb7NQ6LA97nduAgYKmaki+6COgIVPvqyuNzmafo4dKQj7I03x9fG1Fg8Z0LDaZUpMRne3ZEBqyXgwJInYgph35KeQr/qB3DX6OSh+hsyQeHoCAFTw4VLWZ5dkXGPJy0TYIDeQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ff169065-967d-4f22-ca14-08d6757294f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB6158; 
x-ms-traffictypediagnostic: VI1PR04MB6158:
x-microsoft-antispam-prvs: <VI1PR04MB6158FDF5BCBEFD3333F5BA58F28A0@VI1PR04MB6158.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(6055026)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB6158; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB6158; 
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(13464003)(305945005)(105586002)(7736002)(68736007)(76176011)(26005)(186003)(8676002)(102836004)(66066001)(7696005)(2501003)(6436002)(106356001)(6506007)(55016002)(14454004)(81166006)(81156014)(99286004)(478600001)(316002)(53546011)(33656002)(229853002)(8936002)(54906003)(5660300001)(6246003)(256004)(2906002)(53936002)(86362001)(9686003)(97736004)(575784001)(3846002)(71190400001)(74316002)(71200400001)(110136005)(11346002)(476003)(486006)(25786009)(6116002)(446003)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB6158;
 H:VI1PR04MB4799.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Umx8rHTLrvngMtTwkpdICuiArovBowLOE5tImW9/aEQuIEK4zOxTCKMsQWErah6414cCgUGy9XSjskbvmTjPAGqOqYlf3lzBtF5Pi1q9p09sN4kX/REbQ2V2Wy4aeyOV87k16SRKF1Y2+Bjcv5SbmK+gKdzeYIoP1+wFKTkgC1PZ4RWl1b/DzH9xhfSnYIsn+KGFmgUn+HmFGdKUW56obXeK+RiR5i7IG6B8oyaKnOqoxSfN0wk2q4VBEVhhN6MZ+N+nlLSnSQVI5Mh/qu+wr9x4RmjC9UCbS9gNLcXZzqsZCoZMii11rj5YDRdrU/gF
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff169065-967d-4f22-ca14-08d6757294f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 14:07:10.3838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6158
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTY290dCBXb29kIDxvc3NAYnVz
ZXJyb3IubmV0Pg0KPiBTZW50OiBTYXR1cmRheSwgRGVjZW1iZXIgMjIsIDIwMTggMDY6MDcNCj4g
VG86IENhbWVsaWEgQWxleGFuZHJhIEdyb3phIDxjYW1lbGlhLmdyb3phQG54cC5jb20+Ow0KPiBy
b2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBiZW5oQGtlcm5lbC5jcmFz
aGluZy5vcmcNCj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOw0KPiBwYXVsdXNAc2FtYmEub3JnOyBsaW51eHBwYy1kZXZAbGlzdHMu
b3psYWJzLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvM10gcG93ZXJwYy9kdHMvZnNsOiB0
NDI0MHJkYjogdXNlIHRoZSBDb3J0aW5hIFBIWQ0KPiBkcml2ZXIgY29tcGF0aWJsZQ0KPiANCj4g
T24gV2VkLCAyMDE4LTA3LTE4IGF0IDE0OjQ2ICswMzAwLCBDYW1lbGlhIEdyb3phIHdyb3RlOg0K
PiA+IFRoZSBDb3J0aW5hIFBIWSByZXF1aXJlcyB0aGUgdXNlIG9mIHRoZSBkZWRpY2F0ZWQgQ29y
dGluYSBQSFkgZHJpdmVyDQo+ID4gaW5zdGVhZCBvZiB0aGUgZ2VuZXJpYyBvbmUuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBDYW1lbGlhIEdyb3phIDxjYW1lbGlhLmdyb3phQG54cC5jb20+DQo+
ID4gLS0tDQo+ID4gIGFyY2gvcG93ZXJwYy9ib290L2R0cy9mc2wvdDQyNDByZGIuZHRzIHwgOCAr
KysrLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9ib290L2R0cy9mc2wvdDQy
NDByZGIuZHRzDQo+ID4gYi9hcmNoL3Bvd2VycGMvYm9vdC9kdHMvZnNsL3Q0MjQwcmRiLmR0cw0K
PiA+IGluZGV4IDE1ZWIwYTMuLmE1NmE3MDUgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9wb3dlcnBj
L2Jvb3QvZHRzL2ZzbC90NDI0MHJkYi5kdHMNCj4gPiArKysgYi9hcmNoL3Bvd2VycGMvYm9vdC9k
dHMvZnNsL3Q0MjQwcmRiLmR0cw0KPiA+IEBAIC0yNjcsMjIgKzI2NywyMiBAQA0KPiA+DQo+ID4g
IAkJCW1kaW9AZmQwMDAgew0KPiA+ICAJCQkJeGZpcGh5MTogZXRoZXJuZXQtcGh5QDEwIHsNCj4g
PiAtCQkJCQljb21wYXRpYmxlID0gImV0aGVybmV0LXBoeS0NCj4gaWVlZTgwMi4zLQ0KPiA+IGM0
NSI7DQo+ID4gKwkJCQkJY29tcGF0aWJsZSA9ICJldGhlcm5ldC1waHktDQo+ID4gaWQxM2U1LjEw
MDIiOw0KPiA+ICAJCQkJCXJlZyA9IDwweDEwPjsNCj4gPiAgCQkJCX07DQo+ID4NCj4gPiAgCQkJ
CXhmaXBoeTI6IGV0aGVybmV0LXBoeUAxMSB7DQo+ID4gLQkJCQkJY29tcGF0aWJsZSA9ICJldGhl
cm5ldC1waHktDQo+IGllZWU4MDIuMy0NCj4gPiBjNDUiOw0KPiA+ICsJCQkJCWNvbXBhdGlibGUg
PSAiZXRoZXJuZXQtcGh5LQ0KPiA+IGlkMTNlNS4xMDAyIjsNCj4gPiAgCQkJCQlyZWcgPSA8MHgx
MT47DQo+ID4gIAkJCQl9Ow0KPiA+DQo+ID4gIAkJCQl4ZmlwaHkzOiBldGhlcm5ldC1waHlAMTMg
ew0KPiA+IC0JCQkJCWNvbXBhdGlibGUgPSAiZXRoZXJuZXQtcGh5LQ0KPiBpZWVlODAyLjMtDQo+
ID4gYzQ1IjsNCj4gPiArCQkJCQljb21wYXRpYmxlID0gImV0aGVybmV0LXBoeS0NCj4gPiBpZDEz
ZTUuMTAwMiI7DQo+ID4gIAkJCQkJcmVnID0gPDB4MTM+Ow0KPiA+ICAJCQkJfTsNCj4gPg0KPiA+
ICAJCQkJeGZpcGh5NDogZXRoZXJuZXQtcGh5QDEyIHsNCj4gPiAtCQkJCQljb21wYXRpYmxlID0g
ImV0aGVybmV0LXBoeS0NCj4gaWVlZTgwMi4zLQ0KPiA+IGM0NSI7DQo+ID4gKwkJCQkJY29tcGF0
aWJsZSA9ICJldGhlcm5ldC1waHktDQo+ID4gaWQxM2U1LjEwMDIiOw0KPiA+ICAJCQkJCXJlZyA9
IDwweDEyPjsNCj4gPiAgCQkJCX07DQo+ID4gIAkJCX07DQo+IA0KPiBJIGdldCBjcmFzaGVzIG9u
IGJvb3Qgd2hlbiB1c2luZyBhIGR0YiB3aXRoIHRoaXMgY2hhbmdlOg0KDQpIaQ0KDQpTb3JyeSBm
b3IgdGhlIGxhdGUgcmVwbGF5LiBJIHdhcyBvbiB2YWNhdGlvbi4gSSdtIGxvb2tpbmcgaW50byBp
dC4NCg0KUmVnYXJkcywNCkNhbWVsaWENCg==

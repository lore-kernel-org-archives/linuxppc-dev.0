Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61866C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 10:40:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E876205F4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 10:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LCKoFSpn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E876205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lPxn1RL8zF1C6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 21:40:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="LCKoFSpn";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=104.47.2.48; helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=xiaowei.bao@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="LCKoFSpn"; 
 dkim-atps=neutral
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0048.outbound.protection.outlook.com [104.47.2.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lPv6168LzDrS4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 21:38:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vf5m4GfcQ5qOCAytHg2GedEddCguSALriz86WnmV2LY=;
 b=LCKoFSpnYHV2DmEQfBLOHS3mV0qMnZ6NcYb8yH3Cmmziy+0EHau84I04Mt7dyFGdCO6xektdj+xdLsBoWjiWQNo+NTL3sSzu3AqUXytCCqbUQdTJ5gYoemQ5vkXmgEBam86r9SOA9YMnmiSuXlG6iXtcClV8OYCfuerwIbNqIqM=
Received: from HE1PR04MB1497.eurprd04.prod.outlook.com (10.163.176.23) by
 HE1PR04MB1388.eurprd04.prod.outlook.com (10.163.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.26; Wed, 31 Oct 2018 10:38:14 +0000
Received: from HE1PR04MB1497.eurprd04.prod.outlook.com
 ([fe80::4070:91bb:7cd2:1f63]) by HE1PR04MB1497.eurprd04.prod.outlook.com
 ([fe80::4070:91bb:7cd2:1f63%2]) with mapi id 15.20.1273.027; Wed, 31 Oct 2018
 10:38:14 +0000
From: Xiaowei Bao <xiaowei.bao@nxp.com>
To: Kishon Vijay Abraham I <kishon@ti.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org"
 <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "arnd@arndb.de"
 <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "M.h. Lian" <minghuan.lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, Roy
 Zang <roy.zang@nxp.com>, "kstewart@linuxfoundation.org"
 <kstewart@linuxfoundation.org>, "cyrille.pitchen@free-electrons.com"
 <cyrille.pitchen@free-electrons.com>, "pombredanne@nexb.com"
 <pombredanne@nexb.com>, "shawn.lin@rock-chips.com"
 <shawn.lin@rock-chips.com>, "niklas.cassel@axis.com"
 <niklas.cassel@axis.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 5/6] pci: layerscape: Add the EP mode support.
Thread-Topic: [PATCH 5/6] pci: layerscape: Add the EP mode support.
Thread-Index: AQHUbFPBC6aEqg5WuUCTs5ZVrmqyDqUxAPsAgAA8nBCAB2zBkIAAHa2AgAAAvtA=
Date: Wed, 31 Oct 2018 10:38:14 +0000
Message-ID: <HE1PR04MB1497DF7378927C9BB5DF3E15F5CD0@HE1PR04MB1497.eurprd04.prod.outlook.com>
References: <20181025110901.5680-1-xiaowei.bao@nxp.com>
 <20181025110901.5680-5-xiaowei.bao@nxp.com>
 <d9d07e05-556b-a56d-bb7f-eaec9fb739b8@ti.com>
 <HE1PR04MB1497DF7D9428A5C791CB6A03F5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
 <HE1PR04MB14979058170FA16A7465FF9EF5CD0@HE1PR04MB1497.eurprd04.prod.outlook.com>
 <a85a6900-2478-0750-6f33-2e787cf80d1d@ti.com>
In-Reply-To: <a85a6900-2478-0750-6f33-2e787cf80d1d@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HE1PR04MB1388;
 6:mTV5iQw+fRoGPDSs75P5plYjpyQXGFXwSuvnTDKvHaH46VinuCMN3oq7ehWSK348x7p60aq9BhnHjX+TZ9C6Kh1JQk6s70hcuII2Dn+MxAAp2u5v/MmpIGwprw9WXpMuwQUdjhH0TrgFKqMP9/+QKFOk/R/wt3zKGUJ7SSXpWvPTn1X99gpiLZXCAfc/Y6JSwfVNeWlSvhxqYAxlWjw2nMQU7P/pB4ao/vEXEgd6zkRTuiAhhaHiSKUCRb+JxJXmp6nQojV3ejD0W9G8mABJDZQL6hlsY2rUxpSLUia2zwrlhlWKui2ec0gsJdu3Ou4YVqx3+cBsJJMXSqiszNqUgQ+KDUK55o0MLZT36qX0ZYn2mrJes8+JFl4nK9xSGzJ2WDQoaIQlUyLFXGwssiEqpiYCqcVtSrlhOL8v+ht6663DgNBDwvR+CMu5ibnXDF/qAAgA7wrO1k+iomcsl6DxWw==;
 5:yL75sXghIl0x0+3Lm/q+hJkCoFgRS80jCHgLxDksOIQ6taaMmdmNKHkS6aFxHZHTdnVasP7DYPgUdJgQ+DgHUqMHjepvgwXQPiCOtOLq0HOSuufd9rkYO9JT5CD4cxLwbs+VOiE70iGO5SygwmErSuhnKo9rmrRag343tBl0vts=;
 7:Q0foJSTcQ30wuzDCFPit21WOAg1r4aY3gm1LCc5utSnWc1mL4SX9eSNGhhqwgWA42qL5FgGftPiaIQfoDbXLg11dqZuNVKePOBr5fev7G32DycV6IOOdyi7fN76apPQTUxRHxtVPupPhN4/3WTccNQ==
x-ms-office365-filtering-correlation-id: 0a4516c3-8c5b-4304-f53b-08d63f1cf660
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR04MB1388; 
x-ms-traffictypediagnostic: HE1PR04MB1388:
x-microsoft-antispam-prvs: <HE1PR04MB1388BDF64ED2848D48FBD409F5CD0@HE1PR04MB1388.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(180628864354917)(58145275503218)(9452136761055)(258649278758335)(65623756079841)(31051911155226)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:HE1PR04MB1388; BCL:0; PCL:0; RULEID:; SRVR:HE1PR04MB1388; 
x-forefront-prvs: 084285FC5C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(366004)(199004)(189003)(13464003)(6436002)(2900100001)(26005)(5250100002)(3846002)(6246003)(2201001)(97736004)(6116002)(5660300001)(76176011)(99286004)(7696005)(55016002)(7416002)(25786009)(476003)(93886005)(2501003)(6506007)(53936002)(575784001)(53546011)(86362001)(9686003)(316002)(102836004)(7736002)(33656002)(8936002)(74316002)(105586002)(68736007)(486006)(8676002)(81166006)(81156014)(14454004)(256004)(110136005)(106356001)(446003)(4326008)(66066001)(71190400001)(2906002)(305945005)(186003)(11346002)(44832011)(229853002)(71200400001)(478600001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR04MB1388;
 H:HE1PR04MB1497.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pcAC/KXRF7os8oTQpElUtAmovibVfbrmeV2bDxQy+OA//5SKbP2TQ4sivUP8pFqZFw+SiAZ2htk0zh5gDM6o0dA30+3CASYRporo+/pU60VjVDvF/l3/L0wLlNOt5BhiggF1gtU8day7t8aBinP3eR3aZE/sjWRPFr4J6IT5Q3KlAVL/TSmkTARKg0afSevhl85aFV9u+UfHkTU8IC3Ixrlga1eNaLdDjvxtXeodyzS3bJng6O7mHqa0DlLu4mpayeSwhsjLzEfhX0t7zEcA5DngroLdUAaQQfnRhdUbsaEEvG02Y0YoEPs+p1FwEgl8T+BbCdK18c9dXUbOgjoRiCR/dhYauC9VOtRkanaWL/Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4516c3-8c5b-4304-f53b-08d63f1cf660
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2018 10:38:14.2343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1388
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
Cc: Jiafei Pan <jiafei.pan@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLaXNob24gVmlqYXkgQWJyYWhh
bSBJIDxraXNob25AdGkuY29tPiANClNlbnQ6IDIwMTjlubQxMOaciDMx5pelIDEyOjE1DQpUbzog
WGlhb3dlaSBCYW8gPHhpYW93ZWkuYmFvQG54cC5jb20+OyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBy
b2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzaGF3bmd1b0BrZXJuZWwu
b3JnOyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47IGxvcmVuem8ucGllcmFsaXNpQGFybS5j
b207IGFybmRAYXJuZGIuZGU7IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBNLmguIExpYW4g
PG1pbmdodWFuLmxpYW5AbnhwLmNvbT47IE1pbmdrYWkgSHUgPG1pbmdrYWkuaHVAbnhwLmNvbT47
IFJveSBaYW5nIDxyb3kuemFuZ0BueHAuY29tPjsga3N0ZXdhcnRAbGludXhmb3VuZGF0aW9uLm9y
ZzsgY3lyaWxsZS5waXRjaGVuQGZyZWUtZWxlY3Ryb25zLmNvbTsgcG9tYnJlZGFubmVAbmV4Yi5j
b207IHNoYXduLmxpbkByb2NrLWNoaXBzLmNvbTsgbmlrbGFzLmNhc3NlbEBheGlzLmNvbTsgbGlu
dXgtcGNpQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcNCkNjOiBKaWFmZWkgUGFuIDxqaWFm
ZWkucGFuQG54cC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDUvNl0gcGNpOiBsYXllcnNjYXBl
OiBBZGQgdGhlIEVQIG1vZGUgc3VwcG9ydC4NCg0KSGksDQoNCk9uIDMxLzEwLzE4IDg6MDMgQU0s
IFhpYW93ZWkgQmFvIHdyb3RlOg0KPiANCj4gDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IFhpYW93ZWkgQmFvDQo+IFNlbnQ6IDIwMTjlubQxMOaciDI25pelIDE3OjE5DQo+
IFRvOiAnS2lzaG9uIFZpamF5IEFicmFoYW0gSScgPGtpc2hvbkB0aS5jb20+OyBiaGVsZ2Fhc0Bn
b29nbGUuY29tOyANCj4gcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsg
c2hhd25ndW9Aa2VybmVsLm9yZzsgTGVvIExpIA0KPiA8bGVveWFuZy5saUBueHAuY29tPjsgbG9y
ZW56by5waWVyYWxpc2lAYXJtLmNvbTsgYXJuZEBhcm5kYi5kZTsgDQo+IGdyZWdraEBsaW51eGZv
dW5kYXRpb24ub3JnOyBNLmguIExpYW4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47IE1pbmdrYWkg
DQo+IEh1IDxtaW5na2FpLmh1QG54cC5jb20+OyBSb3kgWmFuZyA8cm95LnphbmdAbnhwLmNvbT47
IA0KPiBrc3Rld2FydEBsaW51eGZvdW5kYXRpb24ub3JnOyBjeXJpbGxlLnBpdGNoZW5AZnJlZS1l
bGVjdHJvbnMuY29tOyANCj4gcG9tYnJlZGFubmVAbmV4Yi5jb207IHNoYXduLmxpbkByb2NrLWNo
aXBzLmNvbTsgDQo+IG5pa2xhcy5jYXNzZWxAYXhpcy5jb207IGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmc7IA0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgDQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGlu
dXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcNCj4gQ2M6IEppYWZlaSBQYW4gPGppYWZlaS5wYW5A
bnhwLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCA1LzZdIHBjaTogbGF5ZXJzY2FwZTogQWRk
IHRoZSBFUCBtb2RlIHN1cHBvcnQuDQo+IA0KPiANCj4gDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IEtpc2hvbiBWaWpheSBBYnJhaGFtIEkgPGtpc2hvbkB0aS5jb20+DQo+
IFNlbnQ6IDIwMTjlubQxMOaciDI25pelIDEzOjI5DQo+IFRvOiBYaWFvd2VpIEJhbyA8eGlhb3dl
aS5iYW9AbnhwLmNvbT47IGJoZWxnYWFzQGdvb2dsZS5jb207IA0KPiByb2JoK2R0QGtlcm5lbC5v
cmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8gTGkgDQo+
IDxsZW95YW5nLmxpQG54cC5jb20+OyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBhcm5kQGFy
bmRiLmRlOyANCj4gZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IE0uaC4gTGlhbiA8bWluZ2h1
YW4ubGlhbkBueHAuY29tPjsgTWluZ2thaSANCj4gSHUgPG1pbmdrYWkuaHVAbnhwLmNvbT47IFJv
eSBaYW5nIDxyb3kuemFuZ0BueHAuY29tPjsgDQo+IGtzdGV3YXJ0QGxpbnV4Zm91bmRhdGlvbi5v
cmc7IGN5cmlsbGUucGl0Y2hlbkBmcmVlLWVsZWN0cm9ucy5jb207IA0KPiBwb21icmVkYW5uZUBu
ZXhiLmNvbTsgc2hhd24ubGluQHJvY2stY2hpcHMuY29tOyANCj4gbmlrbGFzLmNhc3NlbEBheGlz
LmNvbTsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgDQo+IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyANCj4gbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIDUvNl0gcGNpOiBsYXllcnNjYXBlOiBBZGQgdGhlIEVQIG1vZGUg
c3VwcG9ydC4NCj4gDQo+IEhpLA0KPiANCj4gT24gVGh1cnNkYXkgMjUgT2N0b2JlciAyMDE4IDA0
OjM5IFBNLCBYaWFvd2VpIEJhbyB3cm90ZToNCj4+IEFkZCB0aGUgUENJZSBFUCBtb2RlIHN1cHBv
cnQgZm9yIGxheWVyc2NhcGUgcGxhdGZvcm0uDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWGlhb3dl
aSBCYW8gPHhpYW93ZWkuYmFvQG54cC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9NYWtlZmlsZSAgICAgICAgICAgIHwgICAgMiArLQ0KPj4gIGRyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaS1sYXllcnNjYXBlLWVwLmMgfCAgMTYxDQo+PiArKysrKysrKysr
KysrKysrKysrKysrKysNCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDE2MiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9ucygtKSAgY3JlYXRlIG1vZGUNCj4+IDEwMDY0NCBkcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2ktbGF5ZXJzY2FwZS1lcC5jDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL01ha2VmaWxlDQo+PiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL01ha2VmaWxlDQo+PiBpbmRleCA1ZDJjZTcyLi5iMjZkNjE3IDEwMDY0NA0KPj4gLS0tIGEv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvTWFrZWZpbGUNCj4+ICsrKyBiL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL01ha2VmaWxlDQo+PiBAQCAtOCw3ICs4LDcgQEAgb2JqLSQoQ09ORklH
X1BDSV9FWFlOT1MpICs9IHBjaS1leHlub3Mubw0KPj4gIG9iai0kKENPTkZJR19QQ0lfSU1YNikg
Kz0gcGNpLWlteDYubw0KPj4gIG9iai0kKENPTkZJR19QQ0lFX1NQRUFSMTNYWCkgKz0gcGNpZS1z
cGVhcjEzeHgubw0KPj4gIG9iai0kKENPTkZJR19QQ0lfS0VZU1RPTkUpICs9IHBjaS1rZXlzdG9u
ZS1kdy5vIHBjaS1rZXlzdG9uZS5vDQo+PiAtb2JqLSQoQ09ORklHX1BDSV9MQVlFUlNDQVBFKSAr
PSBwY2ktbGF5ZXJzY2FwZS5vDQo+PiArb2JqLSQoQ09ORklHX1BDSV9MQVlFUlNDQVBFKSArPSBw
Y2ktbGF5ZXJzY2FwZS5vIHBjaS1sYXllcnNjYXBlLWVwLm8NCj4+ICBvYmotJChDT05GSUdfUENJ
RV9RQ09NKSArPSBwY2llLXFjb20ubw0KPj4gIG9iai0kKENPTkZJR19QQ0lFX0FSTUFEQV84Sykg
Kz0gcGNpZS1hcm1hZGE4ay5vDQo+PiAgb2JqLSQoQ09ORklHX1BDSUVfQVJUUEVDNikgKz0gcGNp
ZS1hcnRwZWM2Lm8gZGlmZiAtLWdpdCANCj4+IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpLWxheWVyc2NhcGUtZXAuYw0KPj4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2kt
bGF5ZXJzY2FwZS1lcC5jDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAw
MC4uM2IzM2JiYw0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpLWxheWVyc2NhcGUtZXAuYw0KPj4gQEAgLTAsMCArMSwxNjEgQEANCj4+ICsv
LyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPj4gKy8qDQo+PiArICogUENJZSBj
b250cm9sbGVyIEVQIGRyaXZlciBmb3IgRnJlZXNjYWxlIExheWVyc2NhcGUgU29Dcw0KPj4gKyAq
DQo+PiArICogQ29weXJpZ2h0IChDKSAyMDE4IE5YUCBTZW1pY29uZHVjdG9yLg0KPj4gKyAqDQo+
PiArICogQXV0aG9yOiBYaWFvd2VpIEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT4gICovDQo+PiAr
DQo+PiArI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9pbml0
Lmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L29mX3BjaS5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9v
Zl9wbGF0Zm9ybS5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+DQo+PiArI2lu
Y2x1ZGUgPGxpbnV4L3BjaS5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2Uu
aD4NCj4+ICsjaW5jbHVkZSA8bGludXgvcmVzb3VyY2UuaD4NCj4+ICsNCj4+ICsjaW5jbHVkZSAi
cGNpZS1kZXNpZ253YXJlLmgiDQo+PiArDQo+PiArI2RlZmluZSBQQ0lFX0RCSTJfT0ZGU0VUCQkw
eDEwMDAJLyogREJJMiBiYXNlIGFkZHJlc3MqLw0KPiANCj4gVGhlIGJhc2UgYWRkcmVzcyBzaG91
bGQgY29tZSBmcm9tIGR0Lg0KPj4gKw0KPj4gK3N0cnVjdCBsc19wY2llX2VwIHsNCj4+ICsJc3Ry
dWN0IGR3X3BjaWUJCSpwY2k7DQo+PiArfTsNCj4+ICsNCj4+ICsjZGVmaW5lIHRvX2xzX3BjaWVf
ZXAoeCkJZGV2X2dldF9kcnZkYXRhKCh4KS0+ZGV2KQ0KPj4gKw0KPj4gK3N0YXRpYyBib29sIGxz
X3BjaWVfaXNfYnJpZGdlKHN0cnVjdCBsc19wY2llX2VwICpwY2llKSB7DQo+PiArCXN0cnVjdCBk
d19wY2llICpwY2kgPSBwY2llLT5wY2k7DQo+PiArCXUzMiBoZWFkZXJfdHlwZTsNCj4+ICsNCj4+
ICsJaGVhZGVyX3R5cGUgPSBpb3JlYWQ4KHBjaS0+ZGJpX2Jhc2UgKyBQQ0lfSEVBREVSX1RZUEUp
Ow0KPj4gKwloZWFkZXJfdHlwZSAmPSAweDdmOw0KPj4gKw0KPj4gKwlyZXR1cm4gaGVhZGVyX3R5
cGUgPT0gUENJX0hFQURFUl9UWVBFX0JSSURHRTsgfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgbHNf
cGNpZV9lc3RhYmxpc2hfbGluayhzdHJ1Y3QgZHdfcGNpZSAqcGNpKSB7DQo+PiArCXJldHVybiAw
Ow0KPj4gK30NCj4gDQo+IFRoZXJlIHNob3VsZCBiZSBzb21lIHdheSBieSB3aGljaCBFUCBzaG91
bGQgdGVsbCBSQyB0aGF0IGl0IGlzIG5vdCBjb25maWd1cmVkIHlldC4gQXJlIHRoZXJlIG5vIGJp
dHMgdG8gY29udHJvbCBMVFNTTSBzdGF0ZSBpbml0aWFsaXphdGlvbiBvciBDb25maWd1cmF0aW9u
IHJldHJ5IHN0YXR1cyBlbmFibGluZz8NCj4gW1hpYW93ZWkgQmFvXSBUaGVyZSBoYXZlIG5vdCBi
aXRzIHRvIGNvbnRyb2wgTFRTU00gc3RhdGUgdG8gdGVsbCB0aGUgUkMgaXQgaXMgY29uZmlndXJl
ZC4gVGhlIHN0YXJ0IGxpbmsgaXMgYXV0byBjb21wbGV0ZWQuDQo+IFtYaWFvd2VpIEJhb10gSGkg
S2lzaG9uLCBpcyB0aGVyZSBhbnkgYWR2aWNlPw0KDQpJZiB0aGVyZSBpcyBubyBIVyBzdXBwb3J0
LCBJIGRvbid0IHRoaW5rIGFueXRoaW5nIGNvdWxkIGJlIGRvbmUgaGVyZS4gVGhpcyBjb3VsZCBy
ZXN1bHQgaW4gUkMgcmVhZGluZyBjb25maWd1cmF0aW9uIHNwYWNlIGV2ZW4gYmVmb3JlIEVQIGlz
IGZ1bGx5IGluaXRpYWxpemVkLg0KW1hpYW93ZWkgQmFvXSBUaGUgYm9vdGxvYWRlciBoYXZlIGlu
aXRpYWxpemVkIHRoZSBFUCBkZXZpY2UgYW5kIHNldCB0aGUgY29uZmlnIHJlYWR5IGJpdCwgYW5k
IHRoZSBrZXJuZWwgZG9uJ3QgbmVlZCB0byBkbyBhbnl0aGluZy4gDQo+PiArDQo+PiArc3RhdGlj
IGNvbnN0IHN0cnVjdCBkd19wY2llX29wcyBsc19wY2llX2VwX29wcyA9IHsNCj4+ICsJLnN0YXJ0
X2xpbmsgPSBsc19wY2llX2VzdGFibGlzaF9saW5rLCB9Ow0KPj4gKw0KPj4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGxzX3BjaWVfZXBfb2ZfbWF0Y2hbXSA9IHsNCj4+ICsJeyAu
Y29tcGF0aWJsZSA9ICJmc2wsbHMtcGNpZS1lcCIsfSwNCj4+ICsJeyB9LA0KPj4gK307DQo+PiAr
DQo+PiArc3RhdGljIHZvaWQgbHNfcGNpZV9lcF9pbml0KHN0cnVjdCBkd19wY2llX2VwICplcCkg
ew0KPj4gKwlzdHJ1Y3QgZHdfcGNpZSAqcGNpID0gdG9fZHdfcGNpZV9mcm9tX2VwKGVwKTsNCj4+
ICsJc3RydWN0IHBjaV9lcGMgKmVwYyA9IGVwLT5lcGM7DQo+PiArCWVudW0gcGNpX2Jhcm5vIGJh
cjsNCj4+ICsNCj4+ICsJZm9yIChiYXIgPSBCQVJfMDsgYmFyIDw9IEJBUl81OyBiYXIrKykNCj4+
ICsJCWR3X3BjaWVfZXBfcmVzZXRfYmFyKHBjaSwgYmFyKTsNCj4+ICsNCj4+ICsJZXBjLT5mZWF0
dXJlcyB8PSBFUENfRkVBVFVSRV9OT19MSU5LVVBfTk9USUZJRVI7IH0NCj4+ICsNCj4+ICtzdGF0
aWMgaW50IGxzX3BjaWVfZXBfcmFpc2VfaXJxKHN0cnVjdCBkd19wY2llX2VwICplcCwgdTggZnVu
Y19ubywNCj4+ICsJCQkJICBlbnVtIHBjaV9lcGNfaXJxX3R5cGUgdHlwZSwgdTE2IGludGVycnVw
dF9udW0pIHsNCj4+ICsJc3RydWN0IGR3X3BjaWUgKnBjaSA9IHRvX2R3X3BjaWVfZnJvbV9lcChl
cCk7DQo+PiArDQo+PiArCXN3aXRjaCAodHlwZSkgew0KPj4gKwljYXNlIFBDSV9FUENfSVJRX0xF
R0FDWToNCj4+ICsJCXJldHVybiBkd19wY2llX2VwX3JhaXNlX2xlZ2FjeV9pcnEoZXAsIGZ1bmNf
bm8pOw0KPj4gKwljYXNlIFBDSV9FUENfSVJRX01TSToNCj4+ICsJCXJldHVybiBkd19wY2llX2Vw
X3JhaXNlX21zaV9pcnEoZXAsIGZ1bmNfbm8sIGludGVycnVwdF9udW0pOw0KPj4gKwljYXNlIFBD
SV9FUENfSVJRX01TSVg6DQo+PiArCQlyZXR1cm4gZHdfcGNpZV9lcF9yYWlzZV9tc2l4X2lycShl
cCwgZnVuY19ubywgaW50ZXJydXB0X251bSk7DQo+PiArCWRlZmF1bHQ6DQo+PiArCQlkZXZfZXJy
KHBjaS0+ZGV2LCAiVU5LTk9XTiBJUlEgdHlwZVxuIik7DQo+PiArCX0NCj4+ICsNCj4+ICsJcmV0
dXJuIDA7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBzdHJ1Y3QgZHdfcGNpZV9lcF9vcHMgcGNp
ZV9lcF9vcHMgPSB7DQo+PiArCS5lcF9pbml0ID0gbHNfcGNpZV9lcF9pbml0LA0KPj4gKwkucmFp
c2VfaXJxID0gbHNfcGNpZV9lcF9yYWlzZV9pcnEsDQo+PiArfTsNCj4+ICsNCj4+ICtzdGF0aWMg
aW50IF9faW5pdCBsc19hZGRfcGNpZV9lcChzdHJ1Y3QgbHNfcGNpZV9lcCAqcGNpZSwNCj4+ICsJ
CQkJCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+PiArew0KPj4gKwlzdHJ1Y3QgZHdf
cGNpZSAqcGNpID0gcGNpZS0+cGNpOw0KPj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBwY2ktPmRl
djsNCj4+ICsJc3RydWN0IGR3X3BjaWVfZXAgKmVwOw0KPj4gKwlzdHJ1Y3QgcmVzb3VyY2UgKnJl
czsNCj4+ICsJaW50IHJldDsNCj4+ICsNCj4+ICsJZXAgPSAmcGNpLT5lcDsNCj4+ICsJZXAtPm9w
cyA9ICZwY2llX2VwX29wczsNCj4+ICsNCj4+ICsJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNl
X2J5bmFtZShwZGV2LCBJT1JFU09VUkNFX01FTSwgImFkZHJfc3BhY2UiKTsNCj4+ICsJaWYgKCFy
ZXMpDQo+PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4+ICsNCj4+ICsJZXAtPnBoeXNfYmFzZSA9IHJl
cy0+c3RhcnQ7DQo+PiArCWVwLT5hZGRyX3NpemUgPSByZXNvdXJjZV9zaXplKHJlcyk7DQo+PiAr
DQo+PiArCXJldCA9IGR3X3BjaWVfZXBfaW5pdChlcCk7DQo+PiArCWlmIChyZXQpIHsNCj4+ICsJ
CWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGluaXRpYWxpemUgZW5kcG9pbnRcbiIpOw0KPj4gKwkJ
cmV0dXJuIHJldDsNCj4+ICsJfQ0KPj4gKw0KPj4gKwlyZXR1cm4gMDsNCj4+ICt9DQo+PiArDQo+
PiArc3RhdGljIGludCBfX2luaXQgbHNfcGNpZV9lcF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KSB7DQo+PiArCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+PiAr
CXN0cnVjdCBkd19wY2llICpwY2k7DQo+PiArCXN0cnVjdCBsc19wY2llX2VwICpwY2llOw0KPj4g
KwlzdHJ1Y3QgcmVzb3VyY2UgKmRiaV9iYXNlOw0KPj4gKwlpbnQgcmV0Ow0KPj4gKw0KPj4gKwlw
Y2llID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpwY2llKSwgR0ZQX0tFUk5FTCk7DQo+PiAr
CWlmICghcGNpZSkNCj4+ICsJCXJldHVybiAtRU5PTUVNOw0KPj4gKw0KPj4gKwlwY2kgPSBkZXZt
X2t6YWxsb2MoZGV2LCBzaXplb2YoKnBjaSksIEdGUF9LRVJORUwpOw0KPj4gKwlpZiAoIXBjaSkN
Cj4+ICsJCXJldHVybiAtRU5PTUVNOw0KPj4gKw0KPj4gKwlkYmlfYmFzZSA9IHBsYXRmb3JtX2dl
dF9yZXNvdXJjZV9ieW5hbWUocGRldiwgSU9SRVNPVVJDRV9NRU0sICJyZWdzIik7DQo+PiArCXBj
aS0+ZGJpX2Jhc2UgPSBkZXZtX3BjaV9yZW1hcF9jZmdfcmVzb3VyY2UoZGV2LCBkYmlfYmFzZSk7
DQo+PiArCWlmIChJU19FUlIocGNpLT5kYmlfYmFzZSkpDQo+PiArCQlyZXR1cm4gUFRSX0VSUihw
Y2ktPmRiaV9iYXNlKTsNCj4+ICsNCj4+ICsJcGNpLT5kYmlfYmFzZTIgPSBwY2ktPmRiaV9iYXNl
ICsgUENJRV9EQkkyX09GRlNFVDsNCj4+ICsJcGNpLT5kZXYgPSBkZXY7DQo+PiArCXBjaS0+b3Bz
ID0gJmxzX3BjaWVfZXBfb3BzOw0KPj4gKwlwY2llLT5wY2kgPSBwY2k7DQo+PiArDQo+PiArCWlm
IChsc19wY2llX2lzX2JyaWRnZShwY2llKSkNCj4+ICsJCXJldHVybiAtRU5PREVWOw0KPiANCj4g
Rm9yIGFuIGVuZHBvaW50IHRoaXMgY29uZGl0aW9uIHNob3VsZCBuZXZlciBvY2N1ci4gVGhpcyBz
aG91bGQgb25seSBtZWFuLCBhIHdyb25nIGNvbXBhdGlibGUgaGFzIGJlZW4gdXNlZCBpbiBkdC4N
Cj4gW1hpYW93ZWkgQmFvXSBUaGlzIGZ1bmN0aW9uIGlzIGEgd2F5IHRoYXQgY2FuIGNoZWNrIHRo
ZSBQQ0kgY29udHJvbGxlciB3aGV0aGVyIHdvcmsgaW4gRVAgbW9kZSwgSSB0aGluayBpdCBpcyBt
b3JlIHNhZmVyLiBPZiBjb3Vyc2UsIGl0IGNhbiBiZSByZW1vdmVkLg0KPiBbWGlhb3dlaSBCYW9d
IEhpIEtpc2hvbiwgaXMgdGhlcmUgYW55IGFkdmljZT8NCg0KSU1ITyB0aGlzIGNoZWNrIGlzIG5v
dCByZXF1aXJlZC4NCltYaWFvd2VpIEJhb10gT0ssIEkgd2lsbCByZW1vdmUgdGhpcyBmdW5jdGlv
biBpbiBwYXRjaC12Mi4NCg0KVGhhbmtzDQpLaXNob24NCg==

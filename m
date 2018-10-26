Return-Path: <SRS0=7Aff=NG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DF1C6786E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 09:21:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEE9B2082D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 09:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n2hHyLuu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE9B2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42hJQQ38t5zF3H4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 20:21:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="n2hHyLuu";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.4.40; helo=eur03-db5-obe.outbound.protection.outlook.com;
 envelope-from=xiaowei.bao@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="n2hHyLuu"; 
 dkim-atps=neutral
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr40040.outbound.protection.outlook.com [40.107.4.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42hJMc5cT2zF3Fx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 20:18:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ah98zx1WW62nHSWcA3mbrpIuPlqZEBywPNWfR2BF67U=;
 b=n2hHyLuubLBhNhh+Kk9cXGL/wD7y/KlccAymujYCbu4Sk4Ss/Ps6S7k64233TURil/LmCZv+faAanQ0npYPffZgkDqyJXNnxtBI283gyK2v0muQ9SNtg3BZlWOyv/Ely4rSvwmyV6wBhUjqiwu4VYo2AhoYq3N4iAhWA+0IxYAs=
Received: from HE1PR04MB1497.eurprd04.prod.outlook.com (10.163.176.23) by
 HE1PR04MB1564.eurprd04.prod.outlook.com (10.164.48.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Fri, 26 Oct 2018 09:18:38 +0000
Received: from HE1PR04MB1497.eurprd04.prod.outlook.com
 ([fe80::70d8:2ebf:92cf:5aae]) by HE1PR04MB1497.eurprd04.prod.outlook.com
 ([fe80::70d8:2ebf:92cf:5aae%2]) with mapi id 15.20.1250.032; Fri, 26 Oct 2018
 09:18:38 +0000
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
Thread-Index: AQHUbFPBC6aEqg5WuUCTs5ZVrmqyDqUxAPsAgAA8nBA=
Date: Fri, 26 Oct 2018 09:18:38 +0000
Message-ID: <HE1PR04MB1497DF7D9428A5C791CB6A03F5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
References: <20181025110901.5680-1-xiaowei.bao@nxp.com>
 <20181025110901.5680-5-xiaowei.bao@nxp.com>
 <d9d07e05-556b-a56d-bb7f-eaec9fb739b8@ti.com>
In-Reply-To: <d9d07e05-556b-a56d-bb7f-eaec9fb739b8@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HE1PR04MB1564;
 6:3qGXR2WKQhUwSnhN4EVaB9KdiJyvlmCIyLjijUGHI9tqWidSTPKzDvD2wiNby8Uu2NMARLFKoMWpSyBYi9aNhWFHUN3xPSp6f1tyF9f9Q9wQGrRxrdQpZp9UWW1fGSKP+gxFKAhaEv/qefT8PqPg088NZ9BiAUC/lZRQm4YkoVwb3fGfEJIz4e36vCdcuGKZzjihXRipSTBnnfoCwpECh9bGy7lDOKYDhywDnsyiUo+ewCHo36muoI5xa9k4QXmQnWkcXF54YZnfrIv3Jjp/XEV4sJa9hgy1nb7wNK1QXXz0mk5KX+oSGM5x+EX+gSwj6mDb6hY6Q7ltJkQVqWBiiv1TsKIHXKXsHSJ7li9txL7Q5dU8POaBlLIVpK36aSCUeCWYw7hEqCjrbGR+pQpHhEkoMMioo+P0DbZ0+p2WBJgx2N/fC4lh0P9eSRmHr1xKGikWY8z9X+CYcn3Lnfg80w==;
 5:3VM0nbqm2Se5aKoiDTEsz1YnYa5WqbEoZTxH2oJmx5+Areyf41iZJ5NPpKJXvQfQh9RD4a9otJzJHuZUKSiMfrL7o4OFurWdI2TCrDKmGM3yEa3cHeQPgNVCMNhBflcCNzRiJdQhx1XUShkePfW6jvv8+KibdDebM4t+vm6DqeQ=;
 7:4O7GoUTl5TFGa5BnrykUS647RaW6qSpcTLm1x7dO1/uRvact2vLiAbWgNYsUHw1y99QwEB4gC/Hz4lyB1ZGJ+Hfu2ctdBl3WEnPDjnPHxDp7yxW0AmyAuJQIssXAJWbZCWCzUWyt1yvXK2YizcjyESB+wIsoS+VRRXWlk+PIxw5NV7bzOb7mZeSFAAV4+Cou9iX+BnaVKxfeY+RmhBp95roDLroQEM0lFr92M0Oh7akhSsxWFMDN+zcslB/NovyL
x-ms-office365-filtering-correlation-id: 6edfc489-ce40-49e7-1249-08d63b24037a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR04MB1564; 
x-ms-traffictypediagnostic: HE1PR04MB1564:
x-microsoft-antispam-prvs: <HE1PR04MB15643783B8C10B9447B18303F5F00@HE1PR04MB1564.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(180628864354917)(58145275503218)(9452136761055)(258649278758335)(65623756079841)(31051911155226)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:HE1PR04MB1564; BCL:0; PCL:0; RULEID:; SRVR:HE1PR04MB1564; 
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(39860400002)(366004)(346002)(376002)(189003)(199004)(13464003)(68736007)(7736002)(97736004)(7416002)(66066001)(74316002)(305945005)(6246003)(5660300001)(2201001)(2501003)(55016002)(186003)(486006)(575784001)(86362001)(44832011)(53936002)(3846002)(6116002)(4326008)(316002)(9686003)(5250100002)(102836004)(229853002)(53546011)(25786009)(6506007)(446003)(99286004)(478600001)(76176011)(11346002)(8936002)(14454004)(26005)(256004)(476003)(6436002)(2906002)(33656002)(8676002)(2900100001)(71190400001)(71200400001)(106356001)(7696005)(81156014)(81166006)(110136005)(105586002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR04MB1564;
 H:HE1PR04MB1497.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: v4JCLeLS7Q1EDfKwthxnI58oYLp/WfVCeS6BnhGfHI5r8Flx3SrwxPz6lQRVzG2x1BxIbxdRVReyxIqE9oBCVOHJV/WwDUeOKMXCTLNuScA0HSTCPz2cMP6V1/na1ajwpzstdo3UiSpPEbpBN7z+nDwPO6CowIjRitBO1cI8glopkNCSSMEXySnrX3+kq/R/XTw3BuKvLOfAf9q9svyz8jdptn5JfpU7BAeFL7HsFiACUCjIhvnmoUYoqtuTqP7YkMIA3sY6+JrTp78V6+ebe2uTUnrW0fOMT4GmKANRbcMDhKbU01DqX8jl12QYAEEGAMZEQtyhkFm1DMtJGFnYRaYBfydA9CWwLH7W6ZV+sXw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6edfc489-ce40-49e7-1249-08d63b24037a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 09:18:38.1225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1564
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
bSBJIDxraXNob25AdGkuY29tPiANClNlbnQ6IDIwMTjlubQxMOaciDI25pelIDEzOjI5DQpUbzog
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
Lm9yZzsgbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0gg
NS82XSBwY2k6IGxheWVyc2NhcGU6IEFkZCB0aGUgRVAgbW9kZSBzdXBwb3J0Lg0KDQpIaSwNCg0K
T24gVGh1cnNkYXkgMjUgT2N0b2JlciAyMDE4IDA0OjM5IFBNLCBYaWFvd2VpIEJhbyB3cm90ZToN
Cj4gQWRkIHRoZSBQQ0llIEVQIG1vZGUgc3VwcG9ydCBmb3IgbGF5ZXJzY2FwZSBwbGF0Zm9ybS4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFhpYW93ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL01ha2VmaWxlICAgICAgICAgICAg
fCAgICAyICstDQo+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbGF5ZXJzY2FwZS1l
cC5jIHwgIDE2MSANCj4gKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAyIGZpbGVzIGNoYW5n
ZWQsIDE2MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKSAgY3JlYXRlIG1vZGUgDQo+IDEw
MDY0NCBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbGF5ZXJzY2FwZS1lcC5jDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvTWFrZWZpbGUgDQo+IGIv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvTWFrZWZpbGUNCj4gaW5kZXggNWQyY2U3Mi4uYjI2
ZDYxNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvTWFrZWZpbGUN
Cj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvTWFrZWZpbGUNCj4gQEAgLTgsNyAr
OCw3IEBAIG9iai0kKENPTkZJR19QQ0lfRVhZTk9TKSArPSBwY2ktZXh5bm9zLm8NCj4gIG9iai0k
KENPTkZJR19QQ0lfSU1YNikgKz0gcGNpLWlteDYubw0KPiAgb2JqLSQoQ09ORklHX1BDSUVfU1BF
QVIxM1hYKSArPSBwY2llLXNwZWFyMTN4eC5vDQo+ICBvYmotJChDT05GSUdfUENJX0tFWVNUT05F
KSArPSBwY2kta2V5c3RvbmUtZHcubyBwY2kta2V5c3RvbmUubw0KPiAtb2JqLSQoQ09ORklHX1BD
SV9MQVlFUlNDQVBFKSArPSBwY2ktbGF5ZXJzY2FwZS5vDQo+ICtvYmotJChDT05GSUdfUENJX0xB
WUVSU0NBUEUpICs9IHBjaS1sYXllcnNjYXBlLm8gcGNpLWxheWVyc2NhcGUtZXAubw0KPiAgb2Jq
LSQoQ09ORklHX1BDSUVfUUNPTSkgKz0gcGNpZS1xY29tLm8NCj4gIG9iai0kKENPTkZJR19QQ0lF
X0FSTUFEQV84SykgKz0gcGNpZS1hcm1hZGE4ay5vDQo+ICBvYmotJChDT05GSUdfUENJRV9BUlRQ
RUM2KSArPSBwY2llLWFydHBlYzYubyBkaWZmIC0tZ2l0IA0KPiBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaS1sYXllcnNjYXBlLWVwLmMgDQo+IGIvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpLWxheWVyc2NhcGUtZXAuYw0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRl
eCAwMDAwMDAwLi4zYjMzYmJjDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpLWxheWVyc2NhcGUtZXAuYw0KPiBAQCAtMCwwICsxLDE2MSBAQA0K
PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gKy8qDQo+ICsgKiBQQ0ll
IGNvbnRyb2xsZXIgRVAgZHJpdmVyIGZvciBGcmVlc2NhbGUgTGF5ZXJzY2FwZSBTb0NzDQo+ICsg
Kg0KPiArICogQ29weXJpZ2h0IChDKSAyMDE4IE5YUCBTZW1pY29uZHVjdG9yLg0KPiArICoNCj4g
KyAqIEF1dGhvcjogWGlhb3dlaSBCYW8gPHhpYW93ZWkuYmFvQG54cC5jb20+ICAqLw0KPiArDQo+
ICsjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvaW5pdC5oPg0K
PiArI2luY2x1ZGUgPGxpbnV4L29mX3BjaS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L29mX3BsYXRm
b3JtLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVzcy5oPg0KPiArI2luY2x1ZGUgPGxp
bnV4L3BjaS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiArI2lu
Y2x1ZGUgPGxpbnV4L3Jlc291cmNlLmg+DQo+ICsNCj4gKyNpbmNsdWRlICJwY2llLWRlc2lnbndh
cmUuaCINCj4gKw0KPiArI2RlZmluZSBQQ0lFX0RCSTJfT0ZGU0VUCQkweDEwMDAJLyogREJJMiBi
YXNlIGFkZHJlc3MqLw0KDQpUaGUgYmFzZSBhZGRyZXNzIHNob3VsZCBjb21lIGZyb20gZHQuDQo+
ICsNCj4gK3N0cnVjdCBsc19wY2llX2VwIHsNCj4gKwlzdHJ1Y3QgZHdfcGNpZQkJKnBjaTsNCj4g
K307DQo+ICsNCj4gKyNkZWZpbmUgdG9fbHNfcGNpZV9lcCh4KQlkZXZfZ2V0X2RydmRhdGEoKHgp
LT5kZXYpDQo+ICsNCj4gK3N0YXRpYyBib29sIGxzX3BjaWVfaXNfYnJpZGdlKHN0cnVjdCBsc19w
Y2llX2VwICpwY2llKSB7DQo+ICsJc3RydWN0IGR3X3BjaWUgKnBjaSA9IHBjaWUtPnBjaTsNCj4g
Kwl1MzIgaGVhZGVyX3R5cGU7DQo+ICsNCj4gKwloZWFkZXJfdHlwZSA9IGlvcmVhZDgocGNpLT5k
YmlfYmFzZSArIFBDSV9IRUFERVJfVFlQRSk7DQo+ICsJaGVhZGVyX3R5cGUgJj0gMHg3ZjsNCj4g
Kw0KPiArCXJldHVybiBoZWFkZXJfdHlwZSA9PSBQQ0lfSEVBREVSX1RZUEVfQlJJREdFOyB9DQo+
ICsNCj4gK3N0YXRpYyBpbnQgbHNfcGNpZV9lc3RhYmxpc2hfbGluayhzdHJ1Y3QgZHdfcGNpZSAq
cGNpKSB7DQo+ICsJcmV0dXJuIDA7DQo+ICt9DQoNClRoZXJlIHNob3VsZCBiZSBzb21lIHdheSBi
eSB3aGljaCBFUCBzaG91bGQgdGVsbCBSQyB0aGF0IGl0IGlzIG5vdCBjb25maWd1cmVkIHlldC4g
QXJlIHRoZXJlIG5vIGJpdHMgdG8gY29udHJvbCBMVFNTTSBzdGF0ZSBpbml0aWFsaXphdGlvbiBv
ciBDb25maWd1cmF0aW9uIHJldHJ5IHN0YXR1cyBlbmFibGluZz8NCltYaWFvd2VpIEJhb10gVGhl
cmUgaGF2ZSBub3QgYml0cyB0byBjb250cm9sIExUU1NNIHN0YXRlIHRvIHRlbGwgdGhlIFJDIGl0
IGlzIGNvbmZpZ3VyZWQuIFRoZSBzdGFydCBsaW5rIGlzIGF1dG8gY29tcGxldGVkLg0KPiArDQo+
ICtzdGF0aWMgY29uc3Qgc3RydWN0IGR3X3BjaWVfb3BzIGxzX3BjaWVfZXBfb3BzID0gew0KPiAr
CS5zdGFydF9saW5rID0gbHNfcGNpZV9lc3RhYmxpc2hfbGluaywgfTsNCj4gKw0KPiArc3RhdGlj
IGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbHNfcGNpZV9lcF9vZl9tYXRjaFtdID0gew0KPiAr
CXsgLmNvbXBhdGlibGUgPSAiZnNsLGxzLXBjaWUtZXAiLH0sDQo+ICsJeyB9LA0KPiArfTsNCj4g
Kw0KPiArc3RhdGljIHZvaWQgbHNfcGNpZV9lcF9pbml0KHN0cnVjdCBkd19wY2llX2VwICplcCkg
ew0KPiArCXN0cnVjdCBkd19wY2llICpwY2kgPSB0b19kd19wY2llX2Zyb21fZXAoZXApOw0KPiAr
CXN0cnVjdCBwY2lfZXBjICplcGMgPSBlcC0+ZXBjOw0KPiArCWVudW0gcGNpX2Jhcm5vIGJhcjsN
Cj4gKw0KPiArCWZvciAoYmFyID0gQkFSXzA7IGJhciA8PSBCQVJfNTsgYmFyKyspDQo+ICsJCWR3
X3BjaWVfZXBfcmVzZXRfYmFyKHBjaSwgYmFyKTsNCj4gKw0KPiArCWVwYy0+ZmVhdHVyZXMgfD0g
RVBDX0ZFQVRVUkVfTk9fTElOS1VQX05PVElGSUVSOyB9DQo+ICsNCj4gK3N0YXRpYyBpbnQgbHNf
cGNpZV9lcF9yYWlzZV9pcnEoc3RydWN0IGR3X3BjaWVfZXAgKmVwLCB1OCBmdW5jX25vLA0KPiAr
CQkJCSAgZW51bSBwY2lfZXBjX2lycV90eXBlIHR5cGUsIHUxNiBpbnRlcnJ1cHRfbnVtKSB7DQo+
ICsJc3RydWN0IGR3X3BjaWUgKnBjaSA9IHRvX2R3X3BjaWVfZnJvbV9lcChlcCk7DQo+ICsNCj4g
Kwlzd2l0Y2ggKHR5cGUpIHsNCj4gKwljYXNlIFBDSV9FUENfSVJRX0xFR0FDWToNCj4gKwkJcmV0
dXJuIGR3X3BjaWVfZXBfcmFpc2VfbGVnYWN5X2lycShlcCwgZnVuY19ubyk7DQo+ICsJY2FzZSBQ
Q0lfRVBDX0lSUV9NU0k6DQo+ICsJCXJldHVybiBkd19wY2llX2VwX3JhaXNlX21zaV9pcnEoZXAs
IGZ1bmNfbm8sIGludGVycnVwdF9udW0pOw0KPiArCWNhc2UgUENJX0VQQ19JUlFfTVNJWDoNCj4g
KwkJcmV0dXJuIGR3X3BjaWVfZXBfcmFpc2VfbXNpeF9pcnEoZXAsIGZ1bmNfbm8sIGludGVycnVw
dF9udW0pOw0KPiArCWRlZmF1bHQ6DQo+ICsJCWRldl9lcnIocGNpLT5kZXYsICJVTktOT1dOIElS
USB0eXBlXG4iKTsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3Rh
dGljIHN0cnVjdCBkd19wY2llX2VwX29wcyBwY2llX2VwX29wcyA9IHsNCj4gKwkuZXBfaW5pdCA9
IGxzX3BjaWVfZXBfaW5pdCwNCj4gKwkucmFpc2VfaXJxID0gbHNfcGNpZV9lcF9yYWlzZV9pcnEs
DQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgaW50IF9faW5pdCBsc19hZGRfcGNpZV9lcChzdHJ1Y3Qg
bHNfcGNpZV9lcCAqcGNpZSwNCj4gKwkJCQkJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4gK3sNCj4gKwlzdHJ1Y3QgZHdfcGNpZSAqcGNpID0gcGNpZS0+cGNpOw0KPiArCXN0cnVjdCBk
ZXZpY2UgKmRldiA9IHBjaS0+ZGV2Ow0KPiArCXN0cnVjdCBkd19wY2llX2VwICplcDsNCj4gKwlz
dHJ1Y3QgcmVzb3VyY2UgKnJlczsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJZXAgPSAmcGNpLT5l
cDsNCj4gKwllcC0+b3BzID0gJnBjaWVfZXBfb3BzOw0KPiArDQo+ICsJcmVzID0gcGxhdGZvcm1f
Z2V0X3Jlc291cmNlX2J5bmFtZShwZGV2LCBJT1JFU09VUkNFX01FTSwgImFkZHJfc3BhY2UiKTsN
Cj4gKwlpZiAoIXJlcykNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gKwllcC0+cGh5c19i
YXNlID0gcmVzLT5zdGFydDsNCj4gKwllcC0+YWRkcl9zaXplID0gcmVzb3VyY2Vfc2l6ZShyZXMp
Ow0KPiArDQo+ICsJcmV0ID0gZHdfcGNpZV9lcF9pbml0KGVwKTsNCj4gKwlpZiAocmV0KSB7DQo+
ICsJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGluaXRpYWxpemUgZW5kcG9pbnRcbiIpOw0KPiAr
CQlyZXR1cm4gcmV0Ow0KPiArCX0NCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICtz
dGF0aWMgaW50IF9faW5pdCBsc19wY2llX2VwX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpIHsNCj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiArCXN0cnVj
dCBkd19wY2llICpwY2k7DQo+ICsJc3RydWN0IGxzX3BjaWVfZXAgKnBjaWU7DQo+ICsJc3RydWN0
IHJlc291cmNlICpkYmlfYmFzZTsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJcGNpZSA9IGRldm1f
a3phbGxvYyhkZXYsIHNpemVvZigqcGNpZSksIEdGUF9LRVJORUwpOw0KPiArCWlmICghcGNpZSkN
Cj4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ICsNCj4gKwlwY2kgPSBkZXZtX2t6YWxsb2MoZGV2LCBz
aXplb2YoKnBjaSksIEdGUF9LRVJORUwpOw0KPiArCWlmICghcGNpKQ0KPiArCQlyZXR1cm4gLUVO
T01FTTsNCj4gKw0KPiArCWRiaV9iYXNlID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlX2J5bmFtZShw
ZGV2LCBJT1JFU09VUkNFX01FTSwgInJlZ3MiKTsNCj4gKwlwY2ktPmRiaV9iYXNlID0gZGV2bV9w
Y2lfcmVtYXBfY2ZnX3Jlc291cmNlKGRldiwgZGJpX2Jhc2UpOw0KPiArCWlmIChJU19FUlIocGNp
LT5kYmlfYmFzZSkpDQo+ICsJCXJldHVybiBQVFJfRVJSKHBjaS0+ZGJpX2Jhc2UpOw0KPiArDQo+
ICsJcGNpLT5kYmlfYmFzZTIgPSBwY2ktPmRiaV9iYXNlICsgUENJRV9EQkkyX09GRlNFVDsNCj4g
KwlwY2ktPmRldiA9IGRldjsNCj4gKwlwY2ktPm9wcyA9ICZsc19wY2llX2VwX29wczsNCj4gKwlw
Y2llLT5wY2kgPSBwY2k7DQo+ICsNCj4gKwlpZiAobHNfcGNpZV9pc19icmlkZ2UocGNpZSkpDQo+
ICsJCXJldHVybiAtRU5PREVWOw0KDQpGb3IgYW4gZW5kcG9pbnQgdGhpcyBjb25kaXRpb24gc2hv
dWxkIG5ldmVyIG9jY3VyLiBUaGlzIHNob3VsZCBvbmx5IG1lYW4sIGEgd3JvbmcgY29tcGF0aWJs
ZSBoYXMgYmVlbiB1c2VkIGluIGR0Lg0KW1hpYW93ZWkgQmFvXSBUaGlzIGZ1bmN0aW9uIGlzIGEg
d2F5IHRoYXQgY2FuIGNoZWNrIHRoZSBQQ0kgY29udHJvbGxlciB3aGV0aGVyIHdvcmsgaW4gRVAg
bW9kZSwgSSB0aGluayBpdCBpcyBtb3JlIHNhZmVyLiBPZiBjb3Vyc2UsIGl0IGNhbiBiZSByZW1v
dmVkLg0KVGhhbmtzDQpLaXNob24NCg==

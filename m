Return-Path: <SRS0=7Aff=NG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569B6C6786E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 03:48:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 904B72082D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 03:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l821JlTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904B72082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42h92D0ZDczF3G1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 14:48:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="l821JlTU";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=104.47.0.46; helo=eur01-he1-obe.outbound.protection.outlook.com;
 envelope-from=xiaowei.bao@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="l821JlTU"; 
 dkim-atps=neutral
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0046.outbound.protection.outlook.com [104.47.0.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42h8zS0BlHzF3FN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 14:45:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+SOo1Wup2E0Gsd1GiTwAbDKVJdp1pyuF0auxAYya5Q=;
 b=l821JlTUgNEWM2KE9N1lMsn4fP1k7/SOMsBZC/KtmG/K+3yYReI2wENrV8sSqc7tu8HuMjhrxjUdc7f03i6WwB7BBK+0yBuLv73hM3GYthjukTxO6VBLRAmNSST3udSHVkxFOQnk5V2afW/Ku4XgQ2Ai4kTK0OlvkddSBYtWEzc=
Received: from HE1PR04MB1497.eurprd04.prod.outlook.com (10.163.176.23) by
 HE1PR04MB1145.eurprd04.prod.outlook.com (10.162.248.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.25; Fri, 26 Oct 2018 03:45:43 +0000
Received: from HE1PR04MB1497.eurprd04.prod.outlook.com
 ([fe80::70d8:2ebf:92cf:5aae]) by HE1PR04MB1497.eurprd04.prod.outlook.com
 ([fe80::70d8:2ebf:92cf:5aae%2]) with mapi id 15.20.1250.032; Fri, 26 Oct 2018
 03:45:43 +0000
From: Xiaowei Bao <xiaowei.bao@nxp.com>
To: Rob Herring <robh@kernel.org>
Subject: RE: [PATCH 3/6] PCI: layerscape: Add the EP mode support
Thread-Topic: [PATCH 3/6] PCI: layerscape: Add the EP mode support
Thread-Index: AQHUbFO/sDtxRLGmJUqv9XRnx7sCWaUwgXkAgABfTVA=
Date: Fri, 26 Oct 2018 03:45:43 +0000
Message-ID: <HE1PR04MB149735C7EF2A23AEE982BB9FF5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
References: <20181025110901.5680-1-xiaowei.bao@nxp.com>
 <20181025110901.5680-3-xiaowei.bao@nxp.com> <20181025215246.GA14861@bogus>
In-Reply-To: <20181025215246.GA14861@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HE1PR04MB1145;
 6:SrM/fQwED3BEYxfUFqkf9ufOVuzQoQn0GKs42QAXmoUEYyb3E+NiIajdvlApW/uzD3ZcJ1iH/+R52H6Va/2qBJFfL/cd+S5xza3MrodVVbEpesuK7HV9+avfqLQCkPrtP1OAZrkzdTab6Mej0Uc5l4+tscybgUdgNBFlU6RuQ8X+RCtsxIUFRRanqH6zxRgapha24dRWdikh6AXztU/LO0hFBaPiV8zhndN8k8NDKEO8bvy56z1oZPpds+mkZeXjgxuAwmkyGa7fpx3oitBnVg1Eey9oldEceQTvgB2HBuhiAkasoDVNmrBBU6DGFlTdWxgSL8I3Oix6tOyoz/2wHiH1dJdAT+HTlE3R1HahZ96ujVrTq/qz+5egS7Q1cuK9YwJUZFTj7C/nma/IjmqJSnD4rZVVlR79kU8xvlC0DM3jg0R7aoK8ZdiayohOuWo7Kv6feuEbdZBFeZjrxHOGKw==;
 5:lU82wJy5BufL+dhL1W0+KvbXqWkteO1DfXR6DX9O9XWekaN+0ea3SivekWFD46wSyvF+KBLaaDJ8PtcPgm976qibMiIOG87ARwlTqEw2vbY6MEwh/vPAcLTzdiZ200VbJUfNjnnHgypCHp9bFhJTBobl1WnBuKF5561ObasPi1s=;
 7:RmLb4ygUrjttDO9g5ySE3EoG3gNXHQiq4Q62LsBGFY9u9lzJ3GV8o35G6NyzmCPAmpmlQSOQrVxJMjAIAIcGW/2jZlsP515UavooqvkQmumY5Z9wI61qWI3+E4EboLcQ3AxvITu3sd5w+19aXpcIrw==
x-ms-office365-filtering-correlation-id: b8b06685-e3ed-4729-1bae-08d63af581a1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR04MB1145; 
x-ms-traffictypediagnostic: HE1PR04MB1145:
x-microsoft-antispam-prvs: <HE1PR04MB1145A4B3BE12129A480E80B6F5F00@HE1PR04MB1145.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(180628864354917)(31051911155226)(58145275503218)(9452136761055)(258649278758335)(65623756079841)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:HE1PR04MB1145; BCL:0; PCL:0; RULEID:; SRVR:HE1PR04MB1145; 
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(396003)(39860400002)(376002)(136003)(366004)(13464003)(189003)(199004)(9686003)(6916009)(53936002)(4326008)(6116002)(3846002)(6436002)(25786009)(256004)(55016002)(2906002)(26005)(68736007)(54906003)(476003)(71200400001)(71190400001)(44832011)(5660300001)(486006)(446003)(11346002)(8936002)(478600001)(6246003)(8676002)(186003)(81166006)(81156014)(106356001)(33656002)(6506007)(53546011)(7736002)(305945005)(66066001)(105586002)(14454004)(99286004)(7696005)(76176011)(2900100001)(7416002)(102836004)(229853002)(86362001)(5250100002)(316002)(97736004)(74316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR04MB1145;
 H:HE1PR04MB1497.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UZZ7t1TksF6bY+YixBMtwbVJvNqkeGaQ/RIXOyIEUpPW8tYlDXoGYB4LHzdS/3k+hDmWB6VbNeO5BcFTZXegZlQiMqYhUTKpQymHkLp0Yv1jp8GmHSB12HMXoqCBYurNMeTFx60poGnI0kCx46JSb/8U/93Z2zzlLq1eV6ybupGEut5i6eOtSm9O0uJfud5Okd6G9WkZnXX9bC3cRoKrravwa2EoctKTAvMsJbu/eRntwk7BKdNAIWV2Po81S4sVxpEXQHyfYH8TS2+4Nv0onXMImKD0C2cCF8T3UVk7L0/EZovgAcLfIEGY9a0sAbYx9nkIpMFAtuUTJbDESZULI4QyIL3ZP9i8dCHybVVDPtk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b06685-e3ed-4729-1bae-08d63af581a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 03:45:43.3219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1145
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
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
 "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kishon@ti.com" <kishon@ti.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
 "cyrille.pitchen@free-electrons.com" <cyrille.pitchen@free-electrons.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "pombredanne@nexb.com" <pombredanne@nexb.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, Leo Li <leoyang.li@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
 Mingkai Hu <mingkai.hu@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPiANClNlbnQ6IDIwMTjE6jEw1MIyNsjVIDU6NTMNClRvOiBYaWFvd2VpIEJhbyA8
eGlhb3dlaS5iYW9AbnhwLmNvbT4NCkNjOiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBtYXJrLnJ1dGxh
bmRAYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgTGVvIExpIDxsZW95YW5nLmxpQG54cC5j
b20+OyBraXNob25AdGkuY29tOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBhcm5kQGFybmRi
LmRlOyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgTS5oLiBMaWFuIDxtaW5naHVhbi5saWFu
QG54cC5jb20+OyBNaW5na2FpIEh1IDxtaW5na2FpLmh1QG54cC5jb20+OyBSb3kgWmFuZyA8cm95
LnphbmdAbnhwLmNvbT47IGtzdGV3YXJ0QGxpbnV4Zm91bmRhdGlvbi5vcmc7IGN5cmlsbGUucGl0
Y2hlbkBmcmVlLWVsZWN0cm9ucy5jb207IHBvbWJyZWRhbm5lQG5leGIuY29tOyBzaGF3bi5saW5A
cm9jay1jaGlwcy5jb207IG5pa2xhcy5jYXNzZWxAYXhpcy5jb207IGxpbnV4LXBjaUB2Z2VyLmtl
cm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4cHBj
LWRldkBsaXN0cy5vemxhYnMub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIDMvNl0gUENJOiBsYXll
cnNjYXBlOiBBZGQgdGhlIEVQIG1vZGUgc3VwcG9ydA0KDQpPbiBUaHUsIE9jdCAyNSwgMjAxOCBh
dCAwNzowODo1OFBNICswODAwLCBYaWFvd2VpIEJhbyB3cm90ZToNCj4gQWRkIHRoZSBFUCBtb2Rl
IHN1cHBvcnQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBYaWFvd2VpIEJhbyA8eGlhb3dlaS5iYW9A
bnhwLmNvbT4NCj4gLS0tDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbGF5ZXJzY2Fw
ZS1wY2kudHh0ICAgICB8ICAgIDMgKysrDQo+ICAxIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcGNpL2xheWVyc2NhcGUtcGNpLnR4dCBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2kudHh0DQo+IGluZGV4IDY2ZGYx
ZTguLmQzZDdiZTEgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2kudHh0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2kudHh0DQo+IEBAIC0xMywxMiArMTMsMTUg
QEAgaW5mb3JtYXRpb24uDQo+ICANCj4gIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ICAtIGNvbXBh
dGlibGU6IHNob3VsZCBjb250YWluIHRoZSBwbGF0Zm9ybSBpZGVudGlmaWVyIHN1Y2ggYXM6DQo+
ICsgIFJDIG1vZGU6DQo+ICAgICAgICAgICJmc2wsbHMxMDIxYS1wY2llIiwgInNucHMsZHctcGNp
ZSINCj4gICAgICAgICAgImZzbCxsczIwODBhLXBjaWUiLCAiZnNsLGxzMjA4NWEtcGNpZSIsICJz
bnBzLGR3LXBjaWUiDQo+ICAgICAgICAgICJmc2wsbHMyMDg4YS1wY2llIg0KPiAgICAgICAgICAi
ZnNsLGxzMTA4OGEtcGNpZSINCj4gICAgICAgICAgImZzbCxsczEwNDZhLXBjaWUiDQo+ICAgICAg
ICAgICJmc2wsbHMxMDEyYS1wY2llIg0KPiArICBFUCBtb2RlOg0KPiArICAgICAgICAiZnNsLGxz
LXBjaWUtZXAiDQoNCllvdSBuZWVkIFNvQyBzcGVjaWZpYyBjb21wYXRpYmxlcyBmb3IgdGhlIHNh
bWUgcmVhc29ucyBhcyB0aGUgUkMuDQpbWGlhb3dlaSBCYW9dIEkgd2FudCB0byBjb250YWlucyBh
bGwgbGF5ZXJzY2FwZSBwbGF0Zm9ybSB1c2Ugb25lIGNvbXBhdGlibGUgaWYgdGhlIFBDSWUgY29u
dHJvbGxlciB3b3JrIGluIEVQIG1vZGUuDQoNClJvYg0K

Return-Path: <SRS0=6Lu7=PL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C216C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 15:58:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90D0E2070D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 15:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vAi2iRHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D0E2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Vsym5135zDqM0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 02:58:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.7.74; helo=eur04-he1-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="vAi2iRHb"; 
 dkim-atps=neutral
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70074.outbound.protection.outlook.com [40.107.7.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Vsx51TYlzDqDQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 02:56:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aS4uawZpQ/tGxparn2gR126OktVBBMsZD4OJH6AX7lc=;
 b=vAi2iRHbq05mDoBH1W92ZqOm3fyKqZMF8oCRLGo9mAGCZBK7kw0XA29fk+3PZYw6EsSEmZLlhHyrvpwCyDU6ZkS/tYmruHihJ32OqmworNfwRk+EcphsJEYKJDUIfwQbwiZH1UdZ8Mp5chYfp8YjnM8NggzaYf+UlKcYlEbF3ss=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB6253.eurprd04.prod.outlook.com (20.179.24.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Thu, 3 Jan 2019 15:56:47 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::ad47:75b9:3ed8:51f0]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::ad47:75b9:3ed8:51f0%6]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 15:56:47 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>
Subject: Re: [RFC PATCH] ASoC: fsl: Add Audio Mixer CPU DAI driver
Thread-Topic: [RFC PATCH] ASoC: fsl: Add Audio Mixer CPU DAI driver
Thread-Index: AQHUlu7sas942UE1M06TLvqfe6BTx6WRUdAAgAx6LQA=
Date: Thu, 3 Jan 2019 15:56:46 +0000
Message-ID: <1546531006.14398.83.camel@nxp.com>
References: <1545150569-14897-1-git-send-email-viorel.suman@nxp.com>
 <CAGoOwPQvc5w05NOVsp6Qw-Ee3CJJCcaU2Dtzwbf+7bUe_kFEbA@mail.gmail.com>
In-Reply-To: <CAGoOwPQvc5w05NOVsp6Qw-Ee3CJJCcaU2Dtzwbf+7bUe_kFEbA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB6253;
 6:O9+jJGVJtpImMxirSvuT98EcYmy9ccYp5gtnEsxWy+mgqIbdYgdjgwb3ir0JMK6m13N8TbijyhoiMppllVHrutmmIohpv8MIgTPZDN90k7HD8wSwE9TrfXE5zdJh7+VGgfXBMLVSYsDOPhVAzy5V/DvZJvWARk8FVr5u/IXkAeMSIq85Y7TlPwnwymABepV5sq95mleBFyWLc+Wlf/ixSpE2GQeB2pHkJziZsxlBbpTq0I3hFlgJOwetTyWGHwmJHYV64LUJR9m/QwuFoHCxzz57QeVym9SN2R/eVGLg6kdsh8cP2PEmGHJG3AAJuy2Ux/YgpvGMavCW1TB5gbthOrM0eGpr/XYqBVDep0haTYdWd8OlC8FeYGRHgTwe3aug7ZBDxEDLZyJfIwtmBOb43X5taHS+NTMNJb+nb9sCe3acHaltnWOUc9m+LHNLKijMVOaML5dLSGVmWogDqtOfPg==;
 5:8Ls+wgQuH49OHVJwrZ1MHerqs402ku1SE/ELuKv9p6fXwLfCtedXrP7LcWzeVLVAmeonUMPHogMUnBCfRn1jOSg8HOWdqzY4t6Ms7HSTwoDPpdS1tw/Q2Faa5pY+ekoA/s+SlHK0sRh5jjgqWHa+4Q47eNI3bZaueNOaYqyi44k=;
 7:WsZtjcxCCE7sX+dbh3kx9StsH09Twi8TUcMvYWlcFubpn1K0XGKgjfYCJ9Woa+VnFv4sikrE92qes4ORTiDgIBolaLUqJPWa+gRNJSggqMneqUBapTBz1/Lp/ncXYKa4wbKhmfagOduD1nHcUzr0tQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a77b6a92-1f74-4060-82e1-08d6719410d5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB6253; 
x-ms-traffictypediagnostic: VI1PR04MB6253:
x-microsoft-antispam-prvs: <VI1PR04MB62536D03CBF31F59E73300D2928D0@VI1PR04MB6253.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB6253; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB6253; 
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(346002)(136003)(396003)(376002)(366004)(199004)(189003)(71190400001)(71200400001)(217873002)(3846002)(6246003)(6116002)(4001150100001)(1411001)(305945005)(2906002)(2501003)(6306002)(54906003)(316002)(66066001)(97736004)(39060400002)(6512007)(86362001)(1361003)(53936002)(4326008)(26005)(229853002)(68736007)(6486002)(103116003)(486006)(53546011)(11346002)(2616005)(14444005)(476003)(8676002)(81166006)(81156014)(6916009)(99286004)(36756003)(1730700003)(44832011)(8936002)(345774005)(6436002)(6506007)(14454004)(105586002)(446003)(478600001)(76176011)(2351001)(7416002)(5660300001)(25786009)(186003)(256004)(106356001)(102836004)(7736002)(966005)(5640700003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB6253;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QCXGFqUGChhZtdAIQ7rLRQGeUiBbx9GkKRHX1TB8rhrBKgmk+Z9SWefRjVDGXWIzUcLB0M1BXN4LLraleNb9BvFR6D5uZuGysCamjvMAS1sU2fAWle9mka4t0Y3SlER4T5qyaZPaFKMvovGGjYLSuOZosCsC9kZQGxqlsd+Pkg8Qp6RTExW3a5SV8rkmYJdtYveI/I8sbx2Kd0f6OYKX+PEhQ1+Co6szPjiMj8+PklKVbz3hEJaphdifxG0USdXHZLKgGoYmYtjYjNMgyXdmt8IiH57D7kXXe7SgDrxTiJ0+KaetY96KR7+feDAT34MX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <715EE2B0FCEEE5478F6A6A47765F899E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a77b6a92-1f74-4060-82e1-08d6719410d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 15:56:46.9329 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6253
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
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Daniel Baluta <daniel.baluta@nxp.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, "perex@perex.cz" <perex@perex.cz>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgTmljb2xpbiwNCg0KVGhhbmsgeW91IGZvciB5b3VyIGZlZWRiYWNrLCBzYW1lIGhlcmUgLSBq
dXN0IGJhY2sgZnJvbSB2YWNhdGlvbi4NCg0KT24gSm8sIDIwMTgtMTItMjcgYXQgMDE6MjQgKzA4
MDAsIE5pY29saW4gQ2hlbiB3cm90ZToNCj4gSGkgVmlvcmVsLA0KPiANCj4gU29ycnkgZm9yIHRo
ZSBsYXRlIHJlc3BvbnNlLCBoYXZpbmcgYmVlbiBvbiBhIGxvbmcgdmFjYXRpb24uDQo+IA0KPiBU
aGUgY29kZSBsb29rcyBwcmV0dHkgY2xlYW4uIEp1c3Qgc29tZSBzbWFsbCBjb25jZXJucy9xdWVz
dGlvbnMNCj4gYmVsb3cuDQo+IA0KPiBPbiBXZWQsIERlYyAxOSwgMjAxOCBhdCAxMjozMCBBTSBW
aW9yZWwgU3VtYW4gPHZpb3JlbC5zdW1hbkBueHAuY29tPg0KPiB3cm90ZToNCj4gPiANCj4gPiAN
Cj4gPiBUaGlzIHBhdGNoIGltcGxlbWVudHMgQXVkaW8gTWl4ZXIgQ1BVIERBSSBkcml2ZXIgZm9y
IE5YUCBpTVg4IFNPQ3MuDQo+ID4gVGhlIEF1ZGlvIE1peGVyIGlzIGEgb24tY2hpcCBmdW5jdGlv
bmFsIG1vZHVsZSB0aGF0IGFsbG93cyBtaXhpbmcNCj4gPiBvZg0KPiA+IHR3byBhdWRpbyBzdHJl
YW1zIGludG8gYSBzaW5nbGUgYXVkaW8gc3RyZWFtLg0KPiA+IA0KPiA+IEF1ZGlvIE1peGVyIGRh
dGFzaGVldCBpcyBhdmFpbGFibGUgaGVyZToNCj4gPiBodHRwczovL3d3dy5ueHAuY29tL2RvY3Mv
ZW4vcmVmZXJlbmNlLW1hbnVhbC9JTVg4RFFYUFJNLnBkZg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFZpb3JlbCBTdW1hbiA8dmlvcmVsLnN1bWFuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gwqAu
Li4vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9mc2wsYW1peC50eHTCoMKgwqDCoMKgwqDCoMKg
wqB8wqDCoDQ1ICsrDQo+ID4gwqBzb3VuZC9zb2MvZnNsL0tjb25maWfCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8wqDCoMKgNyArDQo+
ID4gwqBzb3VuZC9zb2MvZnNsL01ha2VmaWxlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHzCoMKgwqAzICsNCj4gPiDCoHNvdW5kL3NvYy9m
c2wvZnNsX2FtaXguY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHwgNTU0DQo+ID4gKysrKysrKysrKysrKysrKysrKysrDQo+ID4gwqBzb3VuZC9z
b2MvZnNsL2ZzbF9hbWl4LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB8IDEwMSArKysrDQo+IEkgYWltbid0IGFnYWluc3QgdGhlIG5hbWluZyBo
ZXJlLCBidXQgaXQgc2VlbXMgdG8gYmUgQVVETUlYIGluIFJNPw0KPiANCj4gV291bGQgaXQgYmUg
YmV0dGVyIHRvIGFsaWduIHdpdGggdGhhdD8gSXQncyB5b3VyIGRlY2lzaW9uIHRob3VnaC4NCg0K
VG8gbWUgIkFVRE1JWCIgc291bmRzIG1vcmUgbGlrZSBzb21lIFJUTCBoaWdoIGxldmVsIGludGVn
cmF0aW9uIG1vZHVsZSwNCkkgd291bGQgcHJlZmVyIHRvIGtlZXAgaXQgYXMgaXQgaXMgaWYgdGhl
cmUgaXMgbm8gc3Ryb25nIHJlYXNvbiB0b8KgDQpyZW5hbWUgaXQuDQoNCj4gDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9mc2ws
YW1peC50eHQNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9m
c2wsYW1peC50eHQNCj4gPiArPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4g
K8KgwqAtIGNvbXBhdGlibGXCoMKgwqDCoMKgwqDCoMKgwqA6IENvbXBhdGlibGUgbGlzdCwgY29u
dGFpbnMgImZzbCxpbXg4cW0tDQo+ID4gYW1peCINCj4gPiArDQo+ID4gK8KgwqAtIHJlZ8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDogT2Zmc2V0IGFuZCBs
ZW5ndGggb2YgdGhlIHJlZ2lzdGVyDQo+ID4gc2V0IGZvciB0aGUgZGV2aWNlLg0KPiA+ICsNCj4g
PiArwqDCoC0gY2xvY2tzwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA6IE11c3QgY29udGFpbiBh
biBlbnRyeSBmb3IgZWFjaCBlbnRyeSBpbg0KPiA+IGNsb2NrLW5hbWVzLg0KPiA+ICsNCj4gPiAr
wqDCoC0gY2xvY2stbmFtZXPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDogTXVzdCBp
bmNsdWRlIHRoZSAiaXBnIiBmb3INCj4gPiByZWdpc3RlciBhY2Nlc3MuDQo+ID4gKw0KPiA+ICvC
oMKgLSBwb3dlci1kb21haW5zwqDCoMKgwqDCoMKgOiBNdXN0IGNvbnRhaW4gdGhlIHBoYW5kbGUg
dG8gdGhlIEFNSVgNCj4gPiBwb3dlciBkb21haW4gbm9kZQ0KPiA+ICsNCj4gPiArRGV2aWNlIGRy
aXZlciBjb25maWd1cmF0aW9uIGV4YW1wbGU6DQo+ID4gKz09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09DQo+ID4gK8KgwqBhbWl4OiBhbWl4QDU5ODQwMDAwIHsNCj4gPiArwqDC
oMKgwqBjb21wYXRpYmxlID0gImZzbCxpbXg4cW0tYW1peCI7DQo+ID4gK8KgwqDCoMKgcmVnID0g
PDB4MCAweDU5ODQwMDAwIDB4MCAweDEwMDAwPjsNCj4gPiArwqDCoMKgwqBjbG9ja3MgPSA8JmNs
ayBJTVg4UVhQX0FVRF9BTUlYX0lQRz47DQo+ID4gK8KgwqDCoMKgY2xvY2stbmFtZXMgPSAiaXBn
IjsNCj4gPiArwqDCoMKgwqBwb3dlci1kb21haW5zID0gPCZwZF9hbWl4PjsNCj4gPiArwqDCoH07
DQo+IEZyb20gdGhlIGRlc2NyaXB0aW9uIG9mIERUIGFuZCBSTSwgSSBkb24ndCBzZWUgaG93IGl0
IGNvbm5lY3RzIHRvDQo+IFNBSXMuDQo+IA0KPiBBcmUgdGhleSBmaXhlZCB0byBTQUkwIGFuZCBT
QUkxIGluIGlteDhxbT8gV29uZGVyaW5nIGlmIGl0J2QgYmUNCj4gYmV0dGVyIHRvIGhhdmUgc3Vj
aCBpbmZvcm1hdGlvbiBpbiB0aGUgZG9jLg0KDQpQbGVhc2UgY2hlY2sgY2hhcHRlciAiMTYuMS4y
LjIgQXVkaW8gTWl4ZXIiIGluIFJNOiBpdCBoYXMgdHdvIGRlZGljYXRlZA0KU0FJIGludGVyZmFj
ZXMsIFNBSTQgYW5kIFNBSTUuIEF1ZGlvIE1peGVyIG9wZXJhdGVzIG9uIGJpdCBjbG9jayBvZiBv
bmUNCm9mIHRoZXNlIGludGVyZmFjZXMuDQoNCj4gDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL3Nv
dW5kL3NvYy9mc2wvZnNsX2FtaXguYyBiL3NvdW5kL3NvYy9mc2wvZnNsX2FtaXguYw0KPiArc3Rh
dGljIGNvbnN0IGNoYXINCj4gKyAqd2lkdGhfc2VsW10gPSB7ICIxNmIiLCAiMThiIiwgIjIwYiIs
ICIyNGIiLCAiMzJiIiwgfSwNCj4gKyAqcG9sX3NlbFtdID0geyAiUG9zaXRpdmUgZWRnZSIsICJO
ZWdhdGl2ZSBlZGdlIiwgfSwNCj4gWy4uLl0NCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc29jX2Vu
dW0gZnNsX2FtaXhfZW51bVtdID0gew0KPiArLyogRlNMX0FNSVhfQ1RSIGVudW1zICovDQo+IFsu
Li5dDQo+ICtTT0NfRU5VTV9TSU5HTEVfUyhGU0xfQU1JWF9DVFIsIEZTTF9BTUlYX0NUUl9PVVRX
SURUSF9TSElGVCwNCj4gd2lkdGhfc2VsKSwNCj4gK1NPQ19FTlVNX1NJTkdMRV9TKEZTTF9BTUlY
X0NUUiwgRlNMX0FNSVhfQ1RSX09VVENLUE9MX1NISUZULA0KPiBwb2xfc2VsKSwNCj4gDQo+IFNo
b3VsZCB3ZSBoYW5kbGUgdGhlIHdpZHRoIGluIGh3X3BhcmFtKCk/DQoNClRoZSB3aWR0aCBvZiBB
TUlYIG91dHB1dCAobWl4ZWQpIHN0cmVhbSBtYXkgYmUgZGlmZmVyZW50IHRoYW4gdGhlIHdpZHRo
DQpvZiB0aGUgaW5wdXQgc3RyZWFtcywgdGhlIGFzc3VtcHRpb24gaXMgdGhhdCB0aGUgdXNlciBt
YXkgd2FudCB0bw0KY29udHJvbCBpdCBmcm9tIHVzZXJzcGFjZS4NCg0KPiANCj4gV2h5IGRvIHdl
IGNoYW5nZSBwb2wgaGVyZT8gSXQgZmVlbHMgbGlrZSBhZ2FpbnN0IHNldF9mbXQoKS4NCg0KWW91
J3JlIHJpZ2h0LCB3aWxsIHJlbW92ZSBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQo+IA0KPiA+
IA0KPiA+ICtzdGF0aWMgaW50IGZzbF9hbWl4X2RhaV9zZXRfZm10KHN0cnVjdCBzbmRfc29jX2Rh
aSAqZGFpLCB1bnNpZ25lZA0KPiA+IGludCBmbXQpDQo+ID4gK3sNCj4gPiArwqDCoMKgwqDCoMKg
wqAvKiBGb3IgcGxheWJhY2sgdGhlIEFNSVggaXMgc2xhdmUsIGFuZCBmb3IgcmVjb3JkIGlzIG1h
c3Rlcg0KPiA+ICovDQo+ID4gK8KgwqDCoMKgwqDCoMKgc3dpdGNoIChmbXQgJiBTTkRfU09DX0RB
SUZNVF9NQVNURVJfTUFTSykgew0KPiA+ICvCoMKgwqDCoMKgwqDCoGNhc2UgU05EX1NPQ19EQUlG
TVRfQ0JNX0NGTToNCj4gPiArwqDCoMKgwqDCoMKgwqBjYXNlIFNORF9TT0NfREFJRk1UX0NCU19D
RlM6DQo+IFNvIGl0J3MgdXNlZCBlaXRoZXIgZm9yIHBsYXliYWNrIG9yIGNhcHR1cmUgb25seSwg
bm90IGJvdGggYXQgc2FtZQ0KPiB0aW1lPw0KDQpGcm9tIElQIGZ1bmN0aW9uYWwgcGVyc3BlY3Rp
dmUgQU1JWCBjYXB0dXJlIGlzIHRoZSByZXN1bHQgb2YgQU1JWA0KcGxheWJhY2sgLSBBTUlYIG91
dHB1dCByZXByZXNlbnRzIHRoZSByZXN1bHRpbmcgbWl4ZWQgYXVkaW8gc3RyZWFtDQpyb3V0ZWQg
dG8gU0FJNCBSWCBzaWduYWxzIChiaXQgJiBmcmFtZSBjbG9ja3MgYW5kIGRhdGEpLiBTbyBvbmNl
IHdlDQpoYXZlIHBsYXliYWNrIG9uIGVpdGhlciBTQUk0IG9yIFNBSTUgKG9yIGJvdGgpIC0gd2Ug
Y2FuIGNhcHR1cmUgdGhlDQpBTUlYIG91dHB1dCBvbiBTQUk0Lg0KDQpJIGd1ZXNzIGl0IHdvdWxk
IGJlIG5pY2UgdG8gc2VuZCB0aGUgbWFjaGluZSBkcml2ZXIgYXMgcGFydCBvZiB0aGlzDQpwYXRj
aHNldCBhbHNvIC0gaXQgZGVmaW5lcyB0d28gaW5wdXQgU0FJIGludGVyZmFjZXMgYXMgZnJvbnRl
bmRzIGFuZA0KQU1JWCAtIGFzIGJhY2tlbmQuIFVzZXJzcGFjZSBzZWVzIG9ubHkgdHdvIFNBSSBp
bnRlcmZhY2VzIGV4cG9zZWQsIGJvdGgNCm9mIHRoZW0gaGF2aW5nIHBsYXliYWNrIGVuYWJsZWQs
IGFuZCBvbmx5IFNBSTQgaGF2aW5nIGNhcHR1cmUgZW5hYmxlZC4NCg0KPiANCj4gVGhhbmtzDQo+
IE5pY29saW4NCg0KVGhhbmsgeW91LA0KVmlvcmVsDQo=

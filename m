Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E238C6786F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 02:35:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 925812082B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 02:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d317BbKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 925812082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lCBH0nm3zF2Ds
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 13:35:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="d317BbKW";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.5.85; helo=eur03-ve1-obe.outbound.protection.outlook.com;
 envelope-from=xiaowei.bao@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="d317BbKW"; 
 dkim-atps=neutral
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50085.outbound.protection.outlook.com [40.107.5.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lC7M5t5RzF1fD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 13:33:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfdeKBHoTN4yjFZGub7rGGKHayCSlcUg7MJm87td+Hk=;
 b=d317BbKWGZFx+YtC3UlLDLwobdOtDi9tbKZT4FYKJtnDcco08MV1BXcR10ZMQw0SmjIlhtceWPozIs6NcNCeTSnsA8xCn8ydcVvBd9VNOTMP+plEivz+PmQCNK40/QMRcNXIWNPNThjcKn680yOuasfgbo8Pd4S30PlPRVfMdi0=
Received: from HE1PR04MB1497.eurprd04.prod.outlook.com (10.163.176.23) by
 HE1PR04MB1308.eurprd04.prod.outlook.com (10.162.249.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.26; Wed, 31 Oct 2018 02:33:05 +0000
Received: from HE1PR04MB1497.eurprd04.prod.outlook.com
 ([fe80::4070:91bb:7cd2:1f63]) by HE1PR04MB1497.eurprd04.prod.outlook.com
 ([fe80::4070:91bb:7cd2:1f63%2]) with mapi id 15.20.1273.027; Wed, 31 Oct 2018
 02:33:05 +0000
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
Thread-Index: AQHUbFPBC6aEqg5WuUCTs5ZVrmqyDqUxAPsAgAA8nBCAB2zBkA==
Date: Wed, 31 Oct 2018 02:33:04 +0000
Message-ID: <HE1PR04MB14979058170FA16A7465FF9EF5CD0@HE1PR04MB1497.eurprd04.prod.outlook.com>
References: <20181025110901.5680-1-xiaowei.bao@nxp.com>
 <20181025110901.5680-5-xiaowei.bao@nxp.com>
 <d9d07e05-556b-a56d-bb7f-eaec9fb739b8@ti.com>
 <HE1PR04MB1497DF7D9428A5C791CB6A03F5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
In-Reply-To: <HE1PR04MB1497DF7D9428A5C791CB6A03F5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HE1PR04MB1308;
 6:/ImTVOn7PWkZuWVgn26nhlToKASvALSA3zIBRRxWfh2JKhwdIi19RSSW7D52FlD4A1Y1ms+BqkTVP9XhpTSjNp/ubH+onJIPJmKqtLGMRQxD04LiZ71I8Ay9ui+mRvsZCSo2D1BZ5TIBw0QrM4xa1drnFkuPjcr9W2r5sqwW2DXkyNKz228eRLXkt32/emArdrOGzfBPoyPgc8bL8zzKkk3aZiWwCj2U2TyL7qaOfgRSVHBJwy8rMa77lInSo4Il8fe/tgekAsYrHAtRLw0TQyUJ6Ck6frpcfgyrHucyw2TGy9xN/nY2zfB1N3G0rWGsmqpCpyuLhgJoBh6zBOdqWsbMq7EbYa5JEQ2FYNPG0Wppf3jignRLtD/bXIWuO7cJHhxg9ES5MBP51H1H6a6sAYFywDUFwJd/03vEPtFHBI1iIjN+u74s3MsmYZ+G4kdEfFwKG24Imz/+Z2WpGijPkw==;
 5:POu6yZfSJmFeckwiecHKKCZfEa0knOokxR1ZGZd2aS+PJVnOZySPE17pIglTsICjvU9CNRk2aTJNANWX2e2ozyVlWfrPImkeV/AduqjCTu6E3qMREWK42uT8cywUtzLdue307JEGltEr33ZmoS/ZYZjxU49IfF3U5rgkqNVSf6s=;
 7:Sgv6rrZzdRHYzY4sfynFeXCuLDukpz2f/9ci7/4E3rP8FboKoF49p4QHI80n6HVyGTe28V6eZWucMEKrcqv3mwo/Gc0fyMkIqomqcTdQp2Cri2JkSLWqI7gdNhfiABNFNEkfKt8Q1QWLkzC2bNH8sw==
x-ms-office365-filtering-correlation-id: 3d6be900-b6a7-4391-76c2-08d63ed92fde
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR04MB1308; 
x-ms-traffictypediagnostic: HE1PR04MB1308:
x-microsoft-antispam-prvs: <HE1PR04MB13082F343E4CE326D9F0CE40F5CD0@HE1PR04MB1308.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(180628864354917)(58145275503218)(9452136761055)(258649278758335)(65623756079841)(31051911155226)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:HE1PR04MB1308; BCL:0; PCL:0; RULEID:; SRVR:HE1PR04MB1308; 
x-forefront-prvs: 084285FC5C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(346002)(136003)(376002)(396003)(199004)(189003)(13464003)(575784001)(53546011)(11346002)(446003)(99286004)(33656002)(76176011)(2201001)(86362001)(7696005)(106356001)(105586002)(14454004)(93886005)(44832011)(102836004)(486006)(6506007)(476003)(26005)(2900100001)(316002)(256004)(71190400001)(71200400001)(186003)(478600001)(4326008)(68736007)(74316002)(6116002)(3846002)(81166006)(66066001)(305945005)(25786009)(229853002)(55016002)(5250100002)(6436002)(53936002)(7416002)(2501003)(81156014)(6246003)(7736002)(8936002)(5660300001)(110136005)(2906002)(97736004)(9686003)(8676002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR04MB1308;
 H:HE1PR04MB1497.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /j4oySNFe+6dK/nISAvc8vU8TqSmHtEmItUgnp4G9tT/reu9jtf0lugoWgfTPATBAors1qAfqs0nGf9sm7J0zJ1x5pFLz234yjYRcZGh7s68DWJ8LS8DPaAb+JR7ZSA2YwPufHJkjMZc5zwdJz18bc4mj82H8nUsV8781XAgBmPss2l2lqPnxWLhIrRzOVtwlaRxM+SciU1FgKjgrBRbSfbttE8eL2Xtfo/TCvoeNJz/9/X8ACM4XtzPfe39/mbRgF2Q+Hx59pbVAnI/gq1HP9OQvgZ/Jbe3MZ/a3WPAKWBhy6/a1lpclbRHDe3f1n36nGWxCLY56NMBKHUR9b5QWBOpoFI0PTxCqq721M9teIQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6be900-b6a7-4391-76c2-08d63ed92fde
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2018 02:33:04.9093 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1308
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

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBYaWFvd2VpIEJhbyANClNlbnQ6
IDIwMTjlubQxMOaciDI25pelIDE3OjE5DQpUbzogJ0tpc2hvbiBWaWpheSBBYnJhaGFtIEknIDxr
aXNob25AdGkuY29tPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOyBt
YXJrLnJ1dGxhbmRAYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgTGVvIExpIDxsZW95YW5n
LmxpQG54cC5jb20+OyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBhcm5kQGFybmRiLmRlOyBn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgTS5oLiBMaWFuIDxtaW5naHVhbi5saWFuQG54cC5j
b20+OyBNaW5na2FpIEh1IDxtaW5na2FpLmh1QG54cC5jb20+OyBSb3kgWmFuZyA8cm95LnphbmdA
bnhwLmNvbT47IGtzdGV3YXJ0QGxpbnV4Zm91bmRhdGlvbi5vcmc7IGN5cmlsbGUucGl0Y2hlbkBm
cmVlLWVsZWN0cm9ucy5jb207IHBvbWJyZWRhbm5lQG5leGIuY29tOyBzaGF3bi5saW5Acm9jay1j
aGlwcy5jb207IG5pa2xhcy5jYXNzZWxAYXhpcy5jb207IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5v
cmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4cHBjLWRldkBs
aXN0cy5vemxhYnMub3JnDQpDYzogSmlhZmVpIFBhbiA8amlhZmVpLnBhbkBueHAuY29tPg0KU3Vi
amVjdDogUkU6IFtQQVRDSCA1LzZdIHBjaTogbGF5ZXJzY2FwZTogQWRkIHRoZSBFUCBtb2RlIHN1
cHBvcnQuDQoNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS2lzaG9uIFZp
amF5IEFicmFoYW0gSSA8a2lzaG9uQHRpLmNvbT4NClNlbnQ6IDIwMTjlubQxMOaciDI25pelIDEz
OjI5DQpUbzogWGlhb3dlaSBCYW8gPHhpYW93ZWkuYmFvQG54cC5jb20+OyBiaGVsZ2Fhc0Bnb29n
bGUuY29tOyByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzaGF3bmd1
b0BrZXJuZWwub3JnOyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47IGxvcmVuem8ucGllcmFs
aXNpQGFybS5jb207IGFybmRAYXJuZGIuZGU7IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBN
LmguIExpYW4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47IE1pbmdrYWkgSHUgPG1pbmdrYWkuaHVA
bnhwLmNvbT47IFJveSBaYW5nIDxyb3kuemFuZ0BueHAuY29tPjsga3N0ZXdhcnRAbGludXhmb3Vu
ZGF0aW9uLm9yZzsgY3lyaWxsZS5waXRjaGVuQGZyZWUtZWxlY3Ryb25zLmNvbTsgcG9tYnJlZGFu
bmVAbmV4Yi5jb207IHNoYXduLmxpbkByb2NrLWNoaXBzLmNvbTsgbmlrbGFzLmNhc3NlbEBheGlz
LmNvbTsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcNClN1YmplY3Q6IFJl
OiBbUEFUQ0ggNS82XSBwY2k6IGxheWVyc2NhcGU6IEFkZCB0aGUgRVAgbW9kZSBzdXBwb3J0Lg0K
DQpIaSwNCg0KT24gVGh1cnNkYXkgMjUgT2N0b2JlciAyMDE4IDA0OjM5IFBNLCBYaWFvd2VpIEJh
byB3cm90ZToNCj4gQWRkIHRoZSBQQ0llIEVQIG1vZGUgc3VwcG9ydCBmb3IgbGF5ZXJzY2FwZSBw
bGF0Zm9ybS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFhpYW93ZWkgQmFvIDx4aWFvd2VpLmJhb0Bu
eHAuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL01ha2VmaWxlICAg
ICAgICAgICAgfCAgICAyICstDQo+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbGF5
ZXJzY2FwZS1lcC5jIHwgIDE2MQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDIgZmls
ZXMgY2hhbmdlZCwgMTYyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pICBjcmVhdGUgbW9k
ZQ0KPiAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWxheWVyc2NhcGUtZXAu
Yw0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL01ha2VmaWxl
DQo+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvTWFrZWZpbGUNCj4gaW5kZXggNWQyY2U3
Mi4uYjI2ZDYxNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvTWFr
ZWZpbGUNCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvTWFrZWZpbGUNCj4gQEAg
LTgsNyArOCw3IEBAIG9iai0kKENPTkZJR19QQ0lfRVhZTk9TKSArPSBwY2ktZXh5bm9zLm8NCj4g
IG9iai0kKENPTkZJR19QQ0lfSU1YNikgKz0gcGNpLWlteDYubw0KPiAgb2JqLSQoQ09ORklHX1BD
SUVfU1BFQVIxM1hYKSArPSBwY2llLXNwZWFyMTN4eC5vDQo+ICBvYmotJChDT05GSUdfUENJX0tF
WVNUT05FKSArPSBwY2kta2V5c3RvbmUtZHcubyBwY2kta2V5c3RvbmUubw0KPiAtb2JqLSQoQ09O
RklHX1BDSV9MQVlFUlNDQVBFKSArPSBwY2ktbGF5ZXJzY2FwZS5vDQo+ICtvYmotJChDT05GSUdf
UENJX0xBWUVSU0NBUEUpICs9IHBjaS1sYXllcnNjYXBlLm8gcGNpLWxheWVyc2NhcGUtZXAubw0K
PiAgb2JqLSQoQ09ORklHX1BDSUVfUUNPTSkgKz0gcGNpZS1xY29tLm8NCj4gIG9iai0kKENPTkZJ
R19QQ0lFX0FSTUFEQV84SykgKz0gcGNpZS1hcm1hZGE4ay5vDQo+ICBvYmotJChDT05GSUdfUENJ
RV9BUlRQRUM2KSArPSBwY2llLWFydHBlYzYubyBkaWZmIC0tZ2l0IA0KPiBhL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaS1sYXllcnNjYXBlLWVwLmMNCj4gYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2ktbGF5ZXJzY2FwZS1lcC5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
IGluZGV4IDAwMDAwMDAuLjNiMzNiYmMNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbGF5ZXJzY2FwZS1lcC5jDQo+IEBAIC0wLDAgKzEsMTYx
IEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiArLyoNCj4gKyAq
IFBDSWUgY29udHJvbGxlciBFUCBkcml2ZXIgZm9yIEZyZWVzY2FsZSBMYXllcnNjYXBlIFNvQ3MN
Cj4gKyAqDQo+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMTggTlhQIFNlbWljb25kdWN0b3IuDQo+ICsg
Kg0KPiArICogQXV0aG9yOiBYaWFvd2VpIEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT4gICovDQo+
ICsNCj4gKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9pbml0
Lmg+DQo+ICsjaW5jbHVkZSA8bGludXgvb2ZfcGNpLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvb2Zf
cGxhdGZvcm0uaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+DQo+ICsjaW5jbHVk
ZSA8bGludXgvcGNpLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+
ICsjaW5jbHVkZSA8bGludXgvcmVzb3VyY2UuaD4NCj4gKw0KPiArI2luY2x1ZGUgInBjaWUtZGVz
aWdud2FyZS5oIg0KPiArDQo+ICsjZGVmaW5lIFBDSUVfREJJMl9PRkZTRVQJCTB4MTAwMAkvKiBE
QkkyIGJhc2UgYWRkcmVzcyovDQoNClRoZSBiYXNlIGFkZHJlc3Mgc2hvdWxkIGNvbWUgZnJvbSBk
dC4NCj4gKw0KPiArc3RydWN0IGxzX3BjaWVfZXAgew0KPiArCXN0cnVjdCBkd19wY2llCQkqcGNp
Ow0KPiArfTsNCj4gKw0KPiArI2RlZmluZSB0b19sc19wY2llX2VwKHgpCWRldl9nZXRfZHJ2ZGF0
YSgoeCktPmRldikNCj4gKw0KPiArc3RhdGljIGJvb2wgbHNfcGNpZV9pc19icmlkZ2Uoc3RydWN0
IGxzX3BjaWVfZXAgKnBjaWUpIHsNCj4gKwlzdHJ1Y3QgZHdfcGNpZSAqcGNpID0gcGNpZS0+cGNp
Ow0KPiArCXUzMiBoZWFkZXJfdHlwZTsNCj4gKw0KPiArCWhlYWRlcl90eXBlID0gaW9yZWFkOChw
Y2ktPmRiaV9iYXNlICsgUENJX0hFQURFUl9UWVBFKTsNCj4gKwloZWFkZXJfdHlwZSAmPSAweDdm
Ow0KPiArDQo+ICsJcmV0dXJuIGhlYWRlcl90eXBlID09IFBDSV9IRUFERVJfVFlQRV9CUklER0U7
IH0NCj4gKw0KPiArc3RhdGljIGludCBsc19wY2llX2VzdGFibGlzaF9saW5rKHN0cnVjdCBkd19w
Y2llICpwY2kpIHsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCg0KVGhlcmUgc2hvdWxkIGJlIHNvbWUg
d2F5IGJ5IHdoaWNoIEVQIHNob3VsZCB0ZWxsIFJDIHRoYXQgaXQgaXMgbm90IGNvbmZpZ3VyZWQg
eWV0LiBBcmUgdGhlcmUgbm8gYml0cyB0byBjb250cm9sIExUU1NNIHN0YXRlIGluaXRpYWxpemF0
aW9uIG9yIENvbmZpZ3VyYXRpb24gcmV0cnkgc3RhdHVzIGVuYWJsaW5nPw0KW1hpYW93ZWkgQmFv
XSBUaGVyZSBoYXZlIG5vdCBiaXRzIHRvIGNvbnRyb2wgTFRTU00gc3RhdGUgdG8gdGVsbCB0aGUg
UkMgaXQgaXMgY29uZmlndXJlZC4gVGhlIHN0YXJ0IGxpbmsgaXMgYXV0byBjb21wbGV0ZWQuDQpb
WGlhb3dlaSBCYW9dIEhpIEtpc2hvbiwgaXMgdGhlcmUgYW55IGFkdmljZT8NCj4gKw0KPiArc3Rh
dGljIGNvbnN0IHN0cnVjdCBkd19wY2llX29wcyBsc19wY2llX2VwX29wcyA9IHsNCj4gKwkuc3Rh
cnRfbGluayA9IGxzX3BjaWVfZXN0YWJsaXNoX2xpbmssIH07DQo+ICsNCj4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGxzX3BjaWVfZXBfb2ZfbWF0Y2hbXSA9IHsNCj4gKwl7IC5j
b21wYXRpYmxlID0gImZzbCxscy1wY2llLWVwIix9LA0KPiArCXsgfSwNCj4gK307DQo+ICsNCj4g
K3N0YXRpYyB2b2lkIGxzX3BjaWVfZXBfaW5pdChzdHJ1Y3QgZHdfcGNpZV9lcCAqZXApIHsNCj4g
KwlzdHJ1Y3QgZHdfcGNpZSAqcGNpID0gdG9fZHdfcGNpZV9mcm9tX2VwKGVwKTsNCj4gKwlzdHJ1
Y3QgcGNpX2VwYyAqZXBjID0gZXAtPmVwYzsNCj4gKwllbnVtIHBjaV9iYXJubyBiYXI7DQo+ICsN
Cj4gKwlmb3IgKGJhciA9IEJBUl8wOyBiYXIgPD0gQkFSXzU7IGJhcisrKQ0KPiArCQlkd19wY2ll
X2VwX3Jlc2V0X2JhcihwY2ksIGJhcik7DQo+ICsNCj4gKwllcGMtPmZlYXR1cmVzIHw9IEVQQ19G
RUFUVVJFX05PX0xJTktVUF9OT1RJRklFUjsgfQ0KPiArDQo+ICtzdGF0aWMgaW50IGxzX3BjaWVf
ZXBfcmFpc2VfaXJxKHN0cnVjdCBkd19wY2llX2VwICplcCwgdTggZnVuY19ubywNCj4gKwkJCQkg
IGVudW0gcGNpX2VwY19pcnFfdHlwZSB0eXBlLCB1MTYgaW50ZXJydXB0X251bSkgew0KPiArCXN0
cnVjdCBkd19wY2llICpwY2kgPSB0b19kd19wY2llX2Zyb21fZXAoZXApOw0KPiArDQo+ICsJc3dp
dGNoICh0eXBlKSB7DQo+ICsJY2FzZSBQQ0lfRVBDX0lSUV9MRUdBQ1k6DQo+ICsJCXJldHVybiBk
d19wY2llX2VwX3JhaXNlX2xlZ2FjeV9pcnEoZXAsIGZ1bmNfbm8pOw0KPiArCWNhc2UgUENJX0VQ
Q19JUlFfTVNJOg0KPiArCQlyZXR1cm4gZHdfcGNpZV9lcF9yYWlzZV9tc2lfaXJxKGVwLCBmdW5j
X25vLCBpbnRlcnJ1cHRfbnVtKTsNCj4gKwljYXNlIFBDSV9FUENfSVJRX01TSVg6DQo+ICsJCXJl
dHVybiBkd19wY2llX2VwX3JhaXNlX21zaXhfaXJxKGVwLCBmdW5jX25vLCBpbnRlcnJ1cHRfbnVt
KTsNCj4gKwlkZWZhdWx0Og0KPiArCQlkZXZfZXJyKHBjaS0+ZGV2LCAiVU5LTk9XTiBJUlEgdHlw
ZVxuIik7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBz
dHJ1Y3QgZHdfcGNpZV9lcF9vcHMgcGNpZV9lcF9vcHMgPSB7DQo+ICsJLmVwX2luaXQgPSBsc19w
Y2llX2VwX2luaXQsDQo+ICsJLnJhaXNlX2lycSA9IGxzX3BjaWVfZXBfcmFpc2VfaXJxLA0KPiAr
fTsNCj4gKw0KPiArc3RhdGljIGludCBfX2luaXQgbHNfYWRkX3BjaWVfZXAoc3RydWN0IGxzX3Bj
aWVfZXAgKnBjaWUsDQo+ICsJCQkJCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICt7
DQo+ICsJc3RydWN0IGR3X3BjaWUgKnBjaSA9IHBjaWUtPnBjaTsNCj4gKwlzdHJ1Y3QgZGV2aWNl
ICpkZXYgPSBwY2ktPmRldjsNCj4gKwlzdHJ1Y3QgZHdfcGNpZV9lcCAqZXA7DQo+ICsJc3RydWN0
IHJlc291cmNlICpyZXM7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCWVwID0gJnBjaS0+ZXA7DQo+
ICsJZXAtPm9wcyA9ICZwY2llX2VwX29wczsNCj4gKw0KPiArCXJlcyA9IHBsYXRmb3JtX2dldF9y
ZXNvdXJjZV9ieW5hbWUocGRldiwgSU9SRVNPVVJDRV9NRU0sICJhZGRyX3NwYWNlIik7DQo+ICsJ
aWYgKCFyZXMpDQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArDQo+ICsJZXAtPnBoeXNfYmFzZSA9
IHJlcy0+c3RhcnQ7DQo+ICsJZXAtPmFkZHJfc2l6ZSA9IHJlc291cmNlX3NpemUocmVzKTsNCj4g
Kw0KPiArCXJldCA9IGR3X3BjaWVfZXBfaW5pdChlcCk7DQo+ICsJaWYgKHJldCkgew0KPiArCQlk
ZXZfZXJyKGRldiwgImZhaWxlZCB0byBpbml0aWFsaXplIGVuZHBvaW50XG4iKTsNCj4gKwkJcmV0
dXJuIHJldDsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3RhdGlj
IGludCBfX2luaXQgbHNfcGNpZV9lcF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KSB7DQo+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gKwlzdHJ1Y3QgZHdf
cGNpZSAqcGNpOw0KPiArCXN0cnVjdCBsc19wY2llX2VwICpwY2llOw0KPiArCXN0cnVjdCByZXNv
dXJjZSAqZGJpX2Jhc2U7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCXBjaWUgPSBkZXZtX2t6YWxs
b2MoZGV2LCBzaXplb2YoKnBjaWUpLCBHRlBfS0VSTkVMKTsNCj4gKwlpZiAoIXBjaWUpDQo+ICsJ
CXJldHVybiAtRU5PTUVNOw0KPiArDQo+ICsJcGNpID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9m
KCpwY2kpLCBHRlBfS0VSTkVMKTsNCj4gKwlpZiAoIXBjaSkNCj4gKwkJcmV0dXJuIC1FTk9NRU07
DQo+ICsNCj4gKwlkYmlfYmFzZSA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZV9ieW5hbWUocGRldiwg
SU9SRVNPVVJDRV9NRU0sICJyZWdzIik7DQo+ICsJcGNpLT5kYmlfYmFzZSA9IGRldm1fcGNpX3Jl
bWFwX2NmZ19yZXNvdXJjZShkZXYsIGRiaV9iYXNlKTsNCj4gKwlpZiAoSVNfRVJSKHBjaS0+ZGJp
X2Jhc2UpKQ0KPiArCQlyZXR1cm4gUFRSX0VSUihwY2ktPmRiaV9iYXNlKTsNCj4gKw0KPiArCXBj
aS0+ZGJpX2Jhc2UyID0gcGNpLT5kYmlfYmFzZSArIFBDSUVfREJJMl9PRkZTRVQ7DQo+ICsJcGNp
LT5kZXYgPSBkZXY7DQo+ICsJcGNpLT5vcHMgPSAmbHNfcGNpZV9lcF9vcHM7DQo+ICsJcGNpZS0+
cGNpID0gcGNpOw0KPiArDQo+ICsJaWYgKGxzX3BjaWVfaXNfYnJpZGdlKHBjaWUpKQ0KPiArCQly
ZXR1cm4gLUVOT0RFVjsNCg0KRm9yIGFuIGVuZHBvaW50IHRoaXMgY29uZGl0aW9uIHNob3VsZCBu
ZXZlciBvY2N1ci4gVGhpcyBzaG91bGQgb25seSBtZWFuLCBhIHdyb25nIGNvbXBhdGlibGUgaGFz
IGJlZW4gdXNlZCBpbiBkdC4NCltYaWFvd2VpIEJhb10gVGhpcyBmdW5jdGlvbiBpcyBhIHdheSB0
aGF0IGNhbiBjaGVjayB0aGUgUENJIGNvbnRyb2xsZXIgd2hldGhlciB3b3JrIGluIEVQIG1vZGUs
IEkgdGhpbmsgaXQgaXMgbW9yZSBzYWZlci4gT2YgY291cnNlLCBpdCBjYW4gYmUgcmVtb3ZlZC4N
CltYaWFvd2VpIEJhb10gSGkgS2lzaG9uLCBpcyB0aGVyZSBhbnkgYWR2aWNlPw0KVGhhbmtzDQpL
aXNob24NCg0K

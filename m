Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFC9C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 04:10:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5BE206B7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 04:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jf3YSo2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5BE206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437WkX1sJJzDqTF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 15:10:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="jf3YSo2Q";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.14.74; helo=eur01-ve1-obe.outbound.protection.outlook.com;
 envelope-from=xiaowei.bao@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="jf3YSo2Q"; 
 dkim-atps=neutral
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr140074.outbound.protection.outlook.com [40.107.14.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437Wgf6t2PzDqRq
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Dec 2018 15:08:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrDVUyrxSheoAK+9Va+wkYM5Htc19aw/nbb1hJcwsCI=;
 b=jf3YSo2QJHaXrN81FiDmQ4Ww939hcSie5MxeXmaMTXJm7FGLJByEMeHvgz9BoxKqTJWmNoNzqjZSf5uLeDqVWcSJc4ElTts5lVKyjHh1Lx2kXBRi9m5UEEO2DKvgYv06qHFgtHTwhtMvtGegmL2R/rhnSR5+q9ionrQ+zfPIVgI=
Received: from HE1PR04MB1497.eurprd04.prod.outlook.com (10.163.176.23) by
 HE1PR04MB2092.eurprd04.prod.outlook.com (10.166.67.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 04:08:03 +0000
Received: from HE1PR04MB1497.eurprd04.prod.outlook.com
 ([fe80::dc32:150f:5344:715]) by HE1PR04MB1497.eurprd04.prod.outlook.com
 ([fe80::dc32:150f:5344:715%6]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 04:08:03 +0000
From: Xiaowei Bao <xiaowei.bao@nxp.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCHv2 5/6] pci: layerscape: Add the EP mode support.
Thread-Topic: [PATCHv2 5/6] pci: layerscape: Add the EP mode support.
Thread-Index: AQHUdOS+fZ8ZiYoBDEyRnIn10q3xo6Vop+yAgAPmt0A=
Date: Mon, 3 Dec 2018 04:08:03 +0000
Message-ID: <HE1PR04MB14979D3BA7142B0DE787B0D5F5AE0@HE1PR04MB1497.eurprd04.prod.outlook.com>
References: <20181105084653.26597-1-xiaowei.bao@nxp.com>
 <20181105084653.26597-5-xiaowei.bao@nxp.com>
 <20181130162214.GA23332@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181130162214.GA23332@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HE1PR04MB2092;
 6:4cQOcz2oazVmg2XO6cKhJn1DRr9uLwgAbirorfxt/7OHFfCjHgxKaSTr05D9WLDIZAUn2vqJqmcZkjEPPVYV3fk9ey9rJDRlVCsOS6o8GH7Bbo6vHugW9pGN98GaICcERfDCFZUpo3M4N531HDFi+R6C8bRsbFTOigeBLv+UFZtmEjbbnsQOJVaJUEPLMY/HqpboNhZ/6Jg+/ArCrWzyUExo2u8BhLKcRX9wzB5DjJ6+KYOhFYkaUfkV7smt/8TDOyKldsBIMCKfUDKdtjerR6BSGq6to5nvmgrDLBOgWX02+qTHtkJ1OlnTR5UE3kcQCU/HVEYLF3t2EaP9xg6dO996bhA9PBpn7hwvcIi+VtRkJFZo1SKno3uOYVtDInnn7nVPxoMW7iAN8O/P3O3my7Ph0gSu87EVVG/LxWhdR/J4SQTf2oVxtGwGFJMWcmqiW+SBpb18n6nctlFDvdhnnQ==;
 5:m+Ugq6L3isDdd6U9UhO9+uZFifT+7hr6e9lCo3tgULTmgTN4T7j41oc8rrI6nhQGYbJcfxJsDHQXVzRoJttmEoC+PDd6FYaHXmQxpuKSgm7vIcM/4xHTF9Yl2lzZojvS4z5HyGHXBRzqhKFgIPaCgjwGtlil2IeLfcAONJnMIpU=;
 7:73gL4ElrcJLXz6IzK1W6SA9JmavMfrMnigvIjs8KH6oBgtuhpX/EZnxaQ2+Qt4OSxkRaoiD6G+H2k0t4COBzS1uz8yDYRTirYmulNrXaRVC3ASwoIIhPZ4Zop2Hh/Nee/3DJExFac5c6VJO6QGM7zg==
x-ms-office365-filtering-correlation-id: 9a101491-46f9-453a-6587-08d658d4ec38
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR04MB2092; 
x-ms-traffictypediagnostic: HE1PR04MB2092:
x-microsoft-antispam-prvs: <HE1PR04MB209277AAE2FA33A376E2BC6BF5AE0@HE1PR04MB2092.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:HE1PR04MB2092; BCL:0; PCL:0; RULEID:; SRVR:HE1PR04MB2092; 
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(39860400002)(346002)(136003)(366004)(396003)(189003)(199004)(13464003)(14454004)(11346002)(446003)(97736004)(53936002)(99286004)(55016002)(476003)(54906003)(9686003)(575784001)(86362001)(7736002)(44832011)(66066001)(316002)(486006)(14444005)(256004)(8676002)(305945005)(71190400001)(8936002)(71200400001)(74316002)(2906002)(6916009)(25786009)(478600001)(229853002)(106356001)(81166006)(105586002)(81156014)(68736007)(102836004)(6506007)(53546011)(26005)(3846002)(33656002)(6436002)(6116002)(6246003)(76176011)(7696005)(5660300001)(4326008)(7416002)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR04MB2092;
 H:HE1PR04MB1497.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5LOi0rbSUuE4JBTFvcmigEKpKpvgmnR4InLk+rgag9d0fkqqxRcfiIE/6pc3ollOiFtYydrMEhSknXs2ipDGiVNjLpKh9S4TdXiUZ92HTxGpsuWFxoz9BbMlVUk1CkAFkJYSb+75m8yWRj5ZX+HULNnvBTh2YAAmc3X0TUlkwD+I4mXRqWU9hhgNnupuHHKjWeZt0ELZSbzm5DRTvryYtadzWeyjGZ75NE+y9RSSoX0AMFiKM3agQeYIsMnwkeJCnxSmm/u15hLn9wtbPNYRg2gfu8jXPdJh/LIfhCgZ6QIfMJgueYWUrkYkYABWNv0QuZ8tbYd3zH8c5GmC+F0n63jZv5aY6Bj1C64202sxQ8I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a101491-46f9-453a-6587-08d658d4ec38
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 04:08:03.6652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB2092
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
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
 "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
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

SGkgTG9yZW56bywNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExvcmVuem8g
UGllcmFsaXNpIDxsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tPiANClNlbnQ6IDIwMTjE6jEy1MIx
yNUgMDoyMg0KVG86IFhpYW93ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29tPg0KQ2M6IGJoZWxn
YWFzQGdvb2dsZS5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207
IHNoYXduZ3VvQGtlcm5lbC5vcmc7IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsga2lzaG9u
QHRpLmNvbTsgYXJuZEBhcm5kYi5kZTsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IE0uaC4g
TGlhbiA8bWluZ2h1YW4ubGlhbkBueHAuY29tPjsgTWluZ2thaSBIdSA8bWluZ2thaS5odUBueHAu
Y29tPjsgUm95IFphbmcgPHJveS56YW5nQG54cC5jb20+OyBrc3Rld2FydEBsaW51eGZvdW5kYXRp
b24ub3JnOyBjeXJpbGxlLnBpdGNoZW5AZnJlZS1lbGVjdHJvbnMuY29tOyBwb21icmVkYW5uZUBu
ZXhiLmNvbTsgc2hhd24ubGluQHJvY2stY2hpcHMuY29tOyBuaWtsYXMuY2Fzc2VsQGF4aXMuY29t
OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZw0KU3ViamVjdDogUmU6IFtQ
QVRDSHYyIDUvNl0gcGNpOiBsYXllcnNjYXBlOiBBZGQgdGhlIEVQIG1vZGUgc3VwcG9ydC4NCg0K
T24gTW9uLCBOb3YgMDUsIDIwMTggYXQgMDQ6NDY6NTJQTSArMDgwMCwgWGlhb3dlaSBCYW8gd3Jv
dGU6DQo+IEFkZCB0aGUgUENJZSBFUCBtb2RlIHN1cHBvcnQgZm9yIGxheWVyc2NhcGUgcGxhdGZv
cm0uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBYaWFvd2VpIEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNv
bT4NCj4gLS0tDQo+IHYyOg0KPiAgLSByZW1vdmUgdGhlIEVQIG1vZGUgY2hlY2sgZnVuY3Rpb24u
DQo+IA0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvTWFrZWZpbGUgICAgICAgICAgICB8
ICAgIDIgKy0NCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1sYXllcnNjYXBlLWVw
LmMgfCAgMTQ3IA0KPiArKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDIgZmlsZXMgY2hhbmdl
ZCwgMTQ4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pICBjcmVhdGUgbW9kZSANCj4gMTAw
NjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1sYXllcnNjYXBlLWVwLmMNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9NYWtlZmlsZSANCj4gYi9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9NYWtlZmlsZQ0KPiBpbmRleCA1ZDJjZTcyLi5iMjZk
NjE3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9NYWtlZmlsZQ0K
PiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9NYWtlZmlsZQ0KPiBAQCAtOCw3ICs4
LDcgQEAgb2JqLSQoQ09ORklHX1BDSV9FWFlOT1MpICs9IHBjaS1leHlub3Mubw0KPiAgb2JqLSQo
Q09ORklHX1BDSV9JTVg2KSArPSBwY2ktaW14Ni5vDQo+ICBvYmotJChDT05GSUdfUENJRV9TUEVB
UjEzWFgpICs9IHBjaWUtc3BlYXIxM3h4Lm8NCj4gIG9iai0kKENPTkZJR19QQ0lfS0VZU1RPTkUp
ICs9IHBjaS1rZXlzdG9uZS1kdy5vIHBjaS1rZXlzdG9uZS5vDQo+IC1vYmotJChDT05GSUdfUENJ
X0xBWUVSU0NBUEUpICs9IHBjaS1sYXllcnNjYXBlLm8NCj4gK29iai0kKENPTkZJR19QQ0lfTEFZ
RVJTQ0FQRSkgKz0gcGNpLWxheWVyc2NhcGUubyBwY2ktbGF5ZXJzY2FwZS1lcC5vDQo+ICBvYmot
JChDT05GSUdfUENJRV9RQ09NKSArPSBwY2llLXFjb20ubw0KPiAgb2JqLSQoQ09ORklHX1BDSUVf
QVJNQURBXzhLKSArPSBwY2llLWFybWFkYThrLm8NCj4gIG9iai0kKENPTkZJR19QQ0lFX0FSVFBF
QzYpICs9IHBjaWUtYXJ0cGVjNi5vIGRpZmYgLS1naXQgDQo+IGEvZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpLWxheWVyc2NhcGUtZXAuYyANCj4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2ktbGF5ZXJzY2FwZS1lcC5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4
IDAwMDAwMDAuLjI4OTYxOGINCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2ktbGF5ZXJzY2FwZS1lcC5jDQo+IEBAIC0wLDAgKzEsMTQ3IEBADQo+
ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiArLyoNCj4gKyAqIFBDSWUg
Y29udHJvbGxlciBFUCBkcml2ZXIgZm9yIEZyZWVzY2FsZSBMYXllcnNjYXBlIFNvQ3MNCj4gKyAq
DQo+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMTggTlhQIFNlbWljb25kdWN0b3IuDQo+ICsgKg0KPiAr
ICogQXV0aG9yOiBYaWFvd2VpIEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT4gICovDQo+ICsNCj4g
KyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9pbml0Lmg+DQo+
ICsjaW5jbHVkZSA8bGludXgvb2ZfcGNpLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvb2ZfcGxhdGZv
cm0uaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+DQo+ICsjaW5jbHVkZSA8bGlu
dXgvcGNpLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ICsjaW5j
bHVkZSA8bGludXgvcmVzb3VyY2UuaD4NCj4gKw0KPiArI2luY2x1ZGUgInBjaWUtZGVzaWdud2Fy
ZS5oIg0KPiArDQo+ICsjZGVmaW5lIFBDSUVfREJJMl9PRkZTRVQJCTB4MTAwMAkvKiBEQkkyIGJh
c2UgYWRkcmVzcyovDQo+ICsNCj4gK3N0cnVjdCBsc19wY2llX2VwIHsNCj4gKwlzdHJ1Y3QgZHdf
cGNpZQkJKnBjaTsNCj4gK307DQoNCkkgYW0gbm90IHJlYWxseSBzdXJlIHdoeSB5b3UgbmVlZCBh
biBhZGRpdGlvbmFsIHN0cnVjdC4NCltYaWFvd2VpIEJhb10gdGhhbmtzIGEgbG90IGZvciB5b3Vy
IGNvbW1lbnRzLCBJIGRlZmluZWQgdGhpcyBzdHJ1Y3R1cmUgaW4gb3JkZXIgdG8gYWRkIE5YUCdz
IG5ldyBjaGlwIFBDSWUgRVAgZHJpdmVyIGluIHRoZSBmdXR1cmUsIGJlY2F1c2Ugb3RoZXIgcGxh
dGZvcm1zIG1heSBoYXZlIHNvbWUgZXJyYXRhIHRvIGJlIHNvbHZlZC4gVGhlIHN0cnVjdHVyZSBv
ZiBkZWZpbmluZyBhbiBMWCBwbGF0Zm9ybSB3aWxsIGJlIG1vcmUgZmxleGlibGUuIEkgY2FuIHVz
ZSB0aGUgZHJpdmVyIG9mIHRoZSBEVyBwbGF0Zm9ybSBkaXJlY3RseS4gSnVzdCBuZWVkIHRvIG1v
ZGlmeSB0aGUgRFRTLCBidXQgZm9yIHRoZSBmdXR1cmUgZGV2ZWxvcG1lbnQgb2YgYWxsIE5YUCBw
bGF0Zm9ybSBFUCBkcml2ZXJzLCB0aHVzIGFkZGluZyBhIG5ldyBmaWxlLg0KDQo+ICsjZGVmaW5l
IHRvX2xzX3BjaWVfZXAoeCkJZGV2X2dldF9kcnZkYXRhKCh4KS0+ZGV2KQ0KDQpVbnVzZWQuDQoN
Cj4gKw0KPiArc3RhdGljIGludCBsc19wY2llX2VzdGFibGlzaF9saW5rKHN0cnVjdCBkd19wY2ll
ICpwY2kpIHsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVj
dCBkd19wY2llX29wcyBsc19wY2llX2VwX29wcyA9IHsNCj4gKwkuc3RhcnRfbGluayA9IGxzX3Bj
aWVfZXN0YWJsaXNoX2xpbmssIH07DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2
aWNlX2lkIGxzX3BjaWVfZXBfb2ZfbWF0Y2hbXSA9IHsNCj4gKwl7IC5jb21wYXRpYmxlID0gImZz
bCxscy1wY2llLWVwIix9LA0KPiArCXsgfSwNCj4gK307DQo+ICsNCj4gK3N0YXRpYyB2b2lkIGxz
X3BjaWVfZXBfaW5pdChzdHJ1Y3QgZHdfcGNpZV9lcCAqZXApIHsNCj4gKwlzdHJ1Y3QgZHdfcGNp
ZSAqcGNpID0gdG9fZHdfcGNpZV9mcm9tX2VwKGVwKTsNCj4gKwlzdHJ1Y3QgcGNpX2VwYyAqZXBj
ID0gZXAtPmVwYzsNCj4gKwllbnVtIHBjaV9iYXJubyBiYXI7DQo+ICsNCj4gKwlmb3IgKGJhciA9
IEJBUl8wOyBiYXIgPD0gQkFSXzU7IGJhcisrKQ0KPiArCQlkd19wY2llX2VwX3Jlc2V0X2Jhcihw
Y2ksIGJhcik7DQo+ICsNCj4gKwllcGMtPmZlYXR1cmVzIHw9IEVQQ19GRUFUVVJFX05PX0xJTktV
UF9OT1RJRklFUjsgfQ0KPiArDQo+ICtzdGF0aWMgaW50IGxzX3BjaWVfZXBfcmFpc2VfaXJxKHN0
cnVjdCBkd19wY2llX2VwICplcCwgdTggZnVuY19ubywNCj4gKwkJCQkgIGVudW0gcGNpX2VwY19p
cnFfdHlwZSB0eXBlLCB1MTYgaW50ZXJydXB0X251bSkgew0KPiArCXN0cnVjdCBkd19wY2llICpw
Y2kgPSB0b19kd19wY2llX2Zyb21fZXAoZXApOw0KPiArDQo+ICsJc3dpdGNoICh0eXBlKSB7DQo+
ICsJY2FzZSBQQ0lfRVBDX0lSUV9MRUdBQ1k6DQo+ICsJCXJldHVybiBkd19wY2llX2VwX3JhaXNl
X2xlZ2FjeV9pcnEoZXAsIGZ1bmNfbm8pOw0KPiArCWNhc2UgUENJX0VQQ19JUlFfTVNJOg0KPiAr
CQlyZXR1cm4gZHdfcGNpZV9lcF9yYWlzZV9tc2lfaXJxKGVwLCBmdW5jX25vLCBpbnRlcnJ1cHRf
bnVtKTsNCj4gKwljYXNlIFBDSV9FUENfSVJRX01TSVg6DQo+ICsJCXJldHVybiBkd19wY2llX2Vw
X3JhaXNlX21zaXhfaXJxKGVwLCBmdW5jX25vLCBpbnRlcnJ1cHRfbnVtKTsNCj4gKwlkZWZhdWx0
Og0KPiArCQlkZXZfZXJyKHBjaS0+ZGV2LCAiVU5LTk9XTiBJUlEgdHlwZVxuIik7DQo+ICsJfQ0K
PiArDQo+ICsJcmV0dXJuIDA7DQoNClNvIGlmIGl0IGZhbGxzIHRocm91Z2ggdG8gdGhlIGRlZmF1
bHQsIHdlIGxvZyBhbiBlcnJvciBidXQgcmV0dXJuIDAgPyBUaGlzIGRvZXMgbm90IG1ha2UgbXVj
aCBzZW5zZS4NCg0KSSBrbm93IHlvdSBwcm9iYWJseSBjb3B5L3Bhc3RlZCBjb2RlIGZyb20gRFdD
IHBsYXRmb3JtLCB0aGF0IGNvZGUgbXVzdCBiZSBmaXhlZCB0b28gSSBzdXBwb3NlLg0KDQpMb3Jl
bnpvDQpbWGlhb3dlaSBCYW9dIFRoYW5rcyBhIGxvdCBmb3IgeW91ciBjb21tZW50cywgSSB3aWxs
IHNlbmQgdGhlIHYzIHBhdGNoIGZpeCBpdC4NCg0KPiArfQ0KPiArDQo+ICtzdGF0aWMgc3RydWN0
IGR3X3BjaWVfZXBfb3BzIHBjaWVfZXBfb3BzID0gew0KPiArCS5lcF9pbml0ID0gbHNfcGNpZV9l
cF9pbml0LA0KPiArCS5yYWlzZV9pcnEgPSBsc19wY2llX2VwX3JhaXNlX2lycSwNCj4gK307DQo+
ICsNCj4gK3N0YXRpYyBpbnQgX19pbml0IGxzX2FkZF9wY2llX2VwKHN0cnVjdCBsc19wY2llX2Vw
ICpwY2llLA0KPiArCQkJCQlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiArew0KPiAr
CXN0cnVjdCBkd19wY2llICpwY2kgPSBwY2llLT5wY2k7DQo+ICsJc3RydWN0IGRldmljZSAqZGV2
ID0gcGNpLT5kZXY7DQo+ICsJc3RydWN0IGR3X3BjaWVfZXAgKmVwOw0KPiArCXN0cnVjdCByZXNv
dXJjZSAqcmVzOw0KPiArCWludCByZXQ7DQo+ICsNCj4gKwllcCA9ICZwY2ktPmVwOw0KPiArCWVw
LT5vcHMgPSAmcGNpZV9lcF9vcHM7DQo+ICsNCj4gKwlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3Vy
Y2VfYnluYW1lKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAiYWRkcl9zcGFjZSIpOw0KPiArCWlmICgh
cmVzKQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiArCWVwLT5waHlzX2Jhc2UgPSByZXMt
PnN0YXJ0Ow0KPiArCWVwLT5hZGRyX3NpemUgPSByZXNvdXJjZV9zaXplKHJlcyk7DQo+ICsNCj4g
KwlyZXQgPSBkd19wY2llX2VwX2luaXQoZXApOw0KPiArCWlmIChyZXQpIHsNCj4gKwkJZGV2X2Vy
cihkZXYsICJmYWlsZWQgdG8gaW5pdGlhbGl6ZSBlbmRwb2ludFxuIik7DQo+ICsJCXJldHVybiBy
ZXQ7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQg
X19pbml0IGxzX3BjaWVfZXBfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgew0K
PiArCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ICsJc3RydWN0IGR3X3BjaWUg
KnBjaTsNCj4gKwlzdHJ1Y3QgbHNfcGNpZV9lcCAqcGNpZTsNCj4gKwlzdHJ1Y3QgcmVzb3VyY2Ug
KmRiaV9iYXNlOw0KPiArCWludCByZXQ7DQo+ICsNCj4gKwlwY2llID0gZGV2bV9remFsbG9jKGRl
diwgc2l6ZW9mKCpwY2llKSwgR0ZQX0tFUk5FTCk7DQo+ICsJaWYgKCFwY2llKQ0KPiArCQlyZXR1
cm4gLUVOT01FTTsNCj4gKw0KPiArCXBjaSA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqcGNp
KSwgR0ZQX0tFUk5FTCk7DQo+ICsJaWYgKCFwY2kpDQo+ICsJCXJldHVybiAtRU5PTUVNOw0KPiAr
DQo+ICsJZGJpX2Jhc2UgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2VfYnluYW1lKHBkZXYsIElPUkVT
T1VSQ0VfTUVNLCAicmVncyIpOw0KPiArCXBjaS0+ZGJpX2Jhc2UgPSBkZXZtX3BjaV9yZW1hcF9j
ZmdfcmVzb3VyY2UoZGV2LCBkYmlfYmFzZSk7DQo+ICsJaWYgKElTX0VSUihwY2ktPmRiaV9iYXNl
KSkNCj4gKwkJcmV0dXJuIFBUUl9FUlIocGNpLT5kYmlfYmFzZSk7DQo+ICsNCj4gKwlwY2ktPmRi
aV9iYXNlMiA9IHBjaS0+ZGJpX2Jhc2UgKyBQQ0lFX0RCSTJfT0ZGU0VUOw0KPiArCXBjaS0+ZGV2
ID0gZGV2Ow0KPiArCXBjaS0+b3BzID0gJmxzX3BjaWVfZXBfb3BzOw0KPiArCXBjaWUtPnBjaSA9
IHBjaTsNCj4gKw0KPiArCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIHBjaWUpOw0KPiArDQo+
ICsJcmV0ID0gbHNfYWRkX3BjaWVfZXAocGNpZSwgcGRldik7DQo+ICsNCj4gKwlyZXR1cm4gcmV0
Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBsc19wY2llX2Vw
X2RyaXZlciA9IHsNCj4gKwkuZHJpdmVyID0gew0KPiArCQkubmFtZSA9ICJsYXllcnNjYXBlLXBj
aWUtZXAiLA0KPiArCQkub2ZfbWF0Y2hfdGFibGUgPSBsc19wY2llX2VwX29mX21hdGNoLA0KPiAr
CQkuc3VwcHJlc3NfYmluZF9hdHRycyA9IHRydWUsDQo+ICsJfSwNCj4gK307DQo+ICtidWlsdGlu
X3BsYXRmb3JtX2RyaXZlcl9wcm9iZShsc19wY2llX2VwX2RyaXZlciwgbHNfcGNpZV9lcF9wcm9i
ZSk7DQo+IC0tDQo+IDEuNy4xDQo+IA0K

Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1673FC46475
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 04:22:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B0112082D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 04:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lssu+Bcx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0112082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gYqr6MdKzDrcP
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 15:22:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Lssu+Bcx";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.8.84; helo=eur04-vi1-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="Lssu+Bcx"; 
 dkim-atps=neutral
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80084.outbound.protection.outlook.com [40.107.8.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gYn60kQSzDrS4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 15:19:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YE132cFQbpFoKse7RpgvhowRNkzd8+ReH/nhyBVx7is=;
 b=Lssu+Bcxqu19Q7qbz9kfWpdCYR7TGbdlvtYwy+lJMiC4M2AzdU8Ges75xXzC6NjfmkeHVb0Xvml4Sex+kgLmX3zq1kcKWyP8i1Y83JJEtOstS4T7K/+17cpF7M6bTuKdbAB1MGcVzdgnifyw+rNPVZ1bOCBHk20wdYlUunmoFkA=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB3198.eurprd04.prod.outlook.com (10.170.229.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Thu, 25 Oct 2018 04:19:43 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca%3]) with mapi id 15.20.1273.021; Thu, 25 Oct 2018
 04:19:43 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Subject: RE: [PATCH v4 5/6] arm64: dts: add QorIQ LX2160A SoC support
Thread-Topic: [PATCH v4 5/6] arm64: dts: add QorIQ LX2160A SoC support
Thread-Index: AQHUW+N9ACJPAcPv/U20yjsSX6IIpaUU3GYAgArN1LCAAOvQgIAO5Ztw
Date: Thu, 25 Oct 2018 04:19:43 +0000
Message-ID: <VI1PR04MB4800F4B5009B90F50B9C70F7F3F70@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <1538615031-7507-1-git-send-email-vabhav.sharma@nxp.com>
 <1538615031-7507-6-git-send-email-vabhav.sharma@nxp.com>
 <20181008054510.GG3587@dragon>
 <VI1PR04MB4800C0AB214B258793AF9ABAF3FD0@VI1PR04MB4800.eurprd04.prod.outlook.com>
 <153962211360.5275.18031876744546062419@swboyd.mtv.corp.google.com>
In-Reply-To: <153962211360.5275.18031876744546062419@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB3198;
 6:S2dUaILZkhrAcYYn17mhWn8xfBQnXQeVJiXvwZLpgZbWfzJNxVLsKRGHSBOpFkAmzsx5SFZcEDZGOjZm2UP7zgWkaiJ60NWzXrnaQiuBLY0H9zQgwnyQsR1wCl1G+nhRPx4YQq5SpkMEfiqYHC/kltugM4dj3iZyrd5L05/bSG6DsiEicHbucxy7VoSrHHmDEktXTLnzqrwL2JEvq2rFzTi8K4xgsWWkKCVM3qKqj05zsbUBFCA2bONUUYy3M4Ndw0+QSNAiSxjv1QDAijCNRcSSYahSJ0heaFF4rCKme8VW/STYI3LuJBV4U+WB33iz/dXs6azBK/EUxO8rrz7cpVrGon0HUDMB71URjXSBiTVPxMfFHJacecm2/J6vJuHIScZmG1Ic4ZbiJs8eUaF9MKOo8WItW5evFrxUSRb4WUjl+5+ZkaAYmwxu+HHMW+zg8WJkYbqUZpkYEASnF4pNxA==;
 5:6APrCtYVth9eR+gms/09R++nt/6o9xK1mhM6aFt/hXIrYEa78FfKrDr3B5V45V8B6GCElqXzUPKSGkuJDnaBKPfIq+2HGzr6XZhQ5FNYO6I3Y4Z/JBa7bijEdOz8Y6EkM2ORP3IpZTJPtZRlof4Cf1uv8X8qHubDtxw8HTMQkds=;
 7:YbrrcIDTOXez3TpWYG4JwQNfziXroVsjLEYTuHeO3qyQOaK17HvEC0YH3bFreZlX2Ww8ZigfwprLlJD51ctotOzg3qYh4bvTtkQWnorxQs6b22KIRTRMXtnOLEcTSniuvCsK78Db8Qdn3MW5ykPD4oBqJb0RQhMKtYY84EQJjQn9i+claQa5H6Xkph59bK5RtipAsbNlI01M7yvGEiBVKeT3OhQv5nwgd58vukrqqtuF91fGukkQBSr5gNGmBpaR
x-ms-office365-filtering-correlation-id: 5dc9a4ef-cb9a-4fb4-fd52-08d63a311729
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB3198; 
x-ms-traffictypediagnostic: VI1PR04MB3198:
x-microsoft-antispam-prvs: <VI1PR04MB3198FA851D05CE64EDDCA076F3F70@VI1PR04MB3198.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(180628864354917)(65623756079841)(258649278758335)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB3198; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB3198; 
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(346002)(366004)(376002)(136003)(396003)(13464003)(199004)(189003)(486006)(476003)(44832011)(97736004)(8676002)(9686003)(186003)(6436002)(5250100002)(55016002)(25786009)(26005)(68736007)(229853002)(4326008)(256004)(102836004)(99286004)(81166006)(81156014)(55236004)(316002)(2906002)(71200400001)(2900100001)(71190400001)(93886005)(4001150100001)(8936002)(53546011)(6506007)(478600001)(66066001)(5660300001)(105586002)(106356001)(14454004)(7416002)(33656002)(76176011)(11346002)(446003)(86362001)(53936002)(3846002)(7696005)(74316002)(110136005)(6116002)(54906003)(7736002)(305945005)(6246003)(21314003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB3198;
 H:VI1PR04MB4800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: a9QulpIFuyIQd8gDu2FBU+u4yXFqJ9BfjeuJ3OFm61/EbUBz0YSKNxw9eulL5Sp75vf50+KMy22gF/9iVw6aqu3dQwnHE/IDh/Cgrk11wo9gnQS6zPQ+8zLoLJQUusVVQLwa2Z0SZPXFhC8qSEs8sRGZI9ueLtR5CDZqcc30qQYWuclhpY3MirbEBe3Pd3CRF2Nw8Ixn0CxS5UrILiD5YtdwSLDeIniSl139xcG5V/KkPRVYCzUTVU6xYwXJ1L1NKGijhods4SG2607a57WG1eegOF4e94N/gZ+/JHkeo9TSH4/Xgf5NFokEx5DZvLC0CH4jAFt5mqGopnB1AKMFY/tlYI7SOSoQbhEmWSmWt50=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc9a4ef-cb9a-4fb4-fd52-08d63a311729
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 04:19:43.3596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3198
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
 "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
 Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "linux-kernel-owner@vger.kernel.org" <linux-kernel-owner@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
 Sriram Dash <sriram.dash@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Pankaj Bansal <pankaj.bansal@nxp.com>, Udit Kumar <udit.kumar@nxp.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "oss@buserror.net" <oss@buserror.net>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, Nipun Gupta <nipun.gupta@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Ramneek Mehresh <ramneek.mehresh@nxp.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 Ying Zhang <ying.zhang22455@nxp.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogZGV2aWNldHJlZS1vd25l
ckB2Z2VyLmtlcm5lbC5vcmcgPGRldmljZXRyZWUtb3duZXJAdmdlci5rZXJuZWwub3JnPg0KPiBP
biBCZWhhbGYgT2YgU3RlcGhlbiBCb3lkDQo+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAxNSwgMjAx
OCAxMDoxOSBQTQ0KPiBUbzogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgVmFiaGF2
IFNoYXJtYQ0KPiA8dmFiaGF2LnNoYXJtYUBueHAuY29tPg0KPiBDYzogc3VkZWVwLmhvbGxhQGFy
bS5jb207IG9zc0BidXNlcnJvci5uZXQ7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0
bGFuZEBhcm0uY29tOw0KPiBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsg
cmp3QHJqd3lzb2NraS5uZXQ7IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOw0KPiBsaW51eC1jbGtA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbC0N
Cj4gb3duZXJAdmdlci5rZXJuZWwub3JnOyBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbC5k
ZWFjb25AYXJtLmNvbTsNCj4gZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IGFybmRAYXJuZGIu
ZGU7DQo+IGtzdGV3YXJ0QGxpbnV4Zm91bmRhdGlvbi5vcmc7IHlhbWFkYS5tYXNhaGlyb0Bzb2Np
b25leHQuY29tOyBMZW8gTGkNCj4gPGxlb3lhbmcubGlAbnhwLmNvbT47IGxpbnV4QGFybWxpbnV4
Lm9yZy51azsgVmFydW4gU2V0aGkNCj4gPFYuU2V0aGlAbnhwLmNvbT47IFVkaXQgS3VtYXIgPHVk
aXQua3VtYXJAbnhwLmNvbT47IFBhbmthaiBCYW5zYWwNCj4gPHBhbmthai5iYW5zYWxAbnhwLmNv
bT47IFJhbW5lZWsgTWVocmVzaA0KPiA8cmFtbmVlay5tZWhyZXNoQG54cC5jb20+OyBZaW5nIFpo
YW5nIDx5aW5nLnpoYW5nMjI0NTVAbnhwLmNvbT47DQo+IE5pcHVuIEd1cHRhIDxuaXB1bi5ndXB0
YUBueHAuY29tPjsgUHJpeWFua2EgSmFpbg0KPiA8cHJpeWFua2EuamFpbkBueHAuY29tPjsgWW9n
ZXNoIE5hcmF5YW4gR2F1cg0KPiA8eW9nZXNobmFyYXlhbi5nYXVyQG54cC5jb20+OyBTcmlyYW0g
RGFzaCA8c3JpcmFtLmRhc2hAbnhwLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2NCA1LzZd
IGFybTY0OiBkdHM6IGFkZCBRb3JJUSBMWDIxNjBBIFNvQyBzdXBwb3J0DQo+IA0KPiBRdW90aW5n
IFZhYmhhdiBTaGFybWEgKDIwMTgtMTAtMTQgMTk6NTg6MTUpDQo+ID4gPiA+ICsNCj4gPiA+ID4g
KyAgIHBtdSB7DQo+ID4gPiA+ICsgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXJtLGNvcnRleC1h
NzItcG11IjsNCj4gPiA+ID4gKyAgICAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfUFBJIDcgSVJR
X1RZUEVfTEVWRUxfTE9XPjsNCj4gPiA+ID4gKyAgIH07DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAg
IHBzY2kgew0KPiA+ID4gPiArICAgICAgICAgICBjb21wYXRpYmxlID0gImFybSxwc2NpLTAuMiI7
DQo+ID4gPiA+ICsgICAgICAgICAgIG1ldGhvZCA9ICJzbWMiOw0KPiA+ID4gPiArICAgfTsNCj4g
PiA+ID4gKw0KPiA+ID4gPiArICAgbWVtb3J5QDgwMDAwMDAwIHsNCj4gPiA+ID4gKyAgICAgICAg
ICAgLy8gRFJBTSBzcGFjZSAtIDEsIHNpemUgOiAyIEdCIERSQU0NCj4gPiA+ID4gKyAgICAgICAg
ICAgZGV2aWNlX3R5cGUgPSAibWVtb3J5IjsNCj4gPiA+ID4gKyAgICAgICAgICAgcmVnID0gPDB4
MDAwMDAwMDAgMHg4MDAwMDAwMCAwIDB4ODAwMDAwMDA+Ow0KPiA+ID4gPiArICAgfTsNCj4gPiA+
ID4gKw0KPiA+ID4gPiArICAgZGRyMTogbWVtb3J5LWNvbnRyb2xsZXJAMTA4MDAwMCB7DQo+ID4g
PiA+ICsgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLHFvcmlxLW1lbW9yeS1jb250cm9sbGVy
IjsNCj4gPiA+ID4gKyAgICAgICAgICAgcmVnID0gPDB4MCAweDEwODAwMDAgMHgwIDB4MTAwMD47
DQo+ID4gPiA+ICsgICAgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSAxNyBJUlFfVFlQRV9M
RVZFTF9ISUdIPjsNCj4gPiA+ID4gKyAgICAgICAgICAgbGl0dGxlLWVuZGlhbjsNCj4gPiA+ID4g
KyAgIH07DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgIGRkcjI6IG1lbW9yeS1jb250cm9sbGVyQDEw
OTAwMDAgew0KPiA+ID4gPiArICAgICAgICAgICBjb21wYXRpYmxlID0gImZzbCxxb3JpcS1tZW1v
cnktY29udHJvbGxlciI7DQo+ID4gPiA+ICsgICAgICAgICAgIHJlZyA9IDwweDAgMHgxMDkwMDAw
IDB4MCAweDEwMDA+Ow0KPiA+ID4gPiArICAgICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkg
MTggSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ID4gPiA+ICsgICAgICAgICAgIGxpdHRsZS1lbmRp
YW47DQo+ID4gPiA+ICsgICB9Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICBzeXNjbGs6IHN5c2Ns
ayB7DQo+ID4gPg0KPiA+ID4gTmFtZSB0aGUgbm9kZSBhIGJpdCBnZW5lcmljIGxpa2UgY2xvY2st
eHh4Lg0KPiA+IFRoZXJlIGlzIG9ubHkgb25lIGNsb2NrLXVuaXQsIEJvb3Rsb2FkZXIoVS1ib290
KSByZXF1aXJlIHN5c2NsayBub2RlIGR1cmluZw0KPiBkZXZpY2UgdHJlZSBmaXgtdXAgYXMgZGlm
ZmVyZW50IHBsYXRmb3JtIHN1cHBvcnQgdmFyaWVkIHBsYXRmb3JtIGZyZXF1ZW5jeSBhcw0KPiBw
ZXIgcmVzZXQgY29uZmlndXJhdGlvbiB3b3JkIHVzZWQuDQo+ID4gUmVmZXJyZWQgb3RoZXIgQVJN
IGJhc2VkIHBsYXRmb3JtIHdpdGggb25lIGNsb2NrIHVzaW5nIG5hbWUgYXMgeDogeA0KPiANCj4g
UGxlYXNlIGFkZCBhIGNvbW1lbnQgYWJvdmUgdGhpcyBub2RlIHdpdGggdGhpcyBpbmZvcm1hdGlv
bi4gTmV3Y29tZXJzDQo+IHJlYWRpbmcgdGhpcyBEVFMgZmlsZSB3b24ndCBoYXZlIGFueSBpZGVh
IHdoeSB0aGlzIG5vZGUgaXMgc3BlY2lhbGx5IG5hbWVkDQo+IGFuZCBhIGNvbW1lbnQgd2lsbCBo
ZWxwIHRyZW1lbmRvdXNseSBoZXJlLg0KU3VyZQ0KDQo=

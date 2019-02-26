Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C58C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 10:11:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36281217F5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 10:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K8Wb+Kpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36281217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447vj71chZzDqJj
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 21:11:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.52; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="K8Wb+Kpa"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00052.outbound.protection.outlook.com [40.107.0.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447vgF0RVnzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 21:09:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cT8eMPIBD+bQdahfE5HcVLfMkvcxeQ79UjDhdNe9Sts=;
 b=K8Wb+KpaN3Rz17tSwKvAJGHSJT+NxX90TdBPk9+CRXmnc1IgTzrHIdD62c0iU2pXhiMXsSFscZSX3BO7JZE8NQ5RvfXJZ+3QRFZO0N24PKuythlK0hf0wCn/FjBDXy6myR97MpJPAFLmeM8h3UUUZnqQsrGZnjChJD0MsJIr0HE=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB5277.eurprd04.prod.outlook.com (20.177.51.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 10:09:18 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::7437:2195:ffd3:a33a]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::7437:2195:ffd3:a33a%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 10:09:18 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: Scott Wood <oss@buserror.net>, "sudeep.holla@arm.com"
 <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "mturquette@baylibre.com"
 <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org"
 <viresh.kumar@linaro.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "linux-kernel-owner@vger.kernel.org"
 <linux-kernel-owner@vger.kernel.org>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de"
 <arnd@arndb.de>, "kstewart@linuxfoundation.org"
 <kstewart@linuxfoundation.org>, "yamada.masahiro@socionext.com"
 <yamada.masahiro@socionext.com>, Leo Li <leoyang.li@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [PATCH 4/4] clk: qoriq: Add clockgen support for lx2160a
Thread-Topic: [PATCH 4/4] clk: qoriq: Add clockgen support for lx2160a
Thread-Index: AQHUza4hvZ73Kv/IW0iTEWsunnaw7qXx1JKAgAAGm4A=
Date: Tue, 26 Feb 2019 10:09:18 +0000
Message-ID: <VI1PR04MB4800DE15F522A6B4782323D5F37B0@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <1551126463-5341-1-git-send-email-vabhav.sharma@nxp.com>
 <1551126463-5341-5-git-send-email-vabhav.sharma@nxp.com>
 <07441256501ad8bd45b187cf6e25338b028bc9ac.camel@buserror.net>
In-Reply-To: <07441256501ad8bd45b187cf6e25338b028bc9ac.camel@buserror.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c41f4ecc-6195-4aac-5ee6-08d69bd2785e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5277; 
x-ms-traffictypediagnostic: VI1PR04MB5277:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI1Mjc3OzIzOjByL2J2a2I0RnN5SVRFMUNqdGorR1J4bVY0?=
 =?utf-8?B?bTEvZFRnWU4wQzBrQzEyN3pQNWhyQndpWVg4ZDNiR0NtT1NwV0wva2g1UkEx?=
 =?utf-8?B?TzB1UjZjU2E3aHZrbkxXVnV5clB3V3NkanF6bGs2QWFJT2kvcGRqR2xMaWkz?=
 =?utf-8?B?K1FkV3IrUklHdDRjV2FmYUY4RWxKbm00a1VRU1hkQ3dINVZLOVhSSkJhaG1o?=
 =?utf-8?B?Zmhoem90dW50Y3RrRGdUTDFxU0FsbllFMjNVVmFhS3M5S09WSkVFQ3BONXJX?=
 =?utf-8?B?YzdSdUlRWE51MGJBMXBVSUQ0ZnVIT3lVSWg4VGt5TFM2Umh6YzVJUm8wWFFm?=
 =?utf-8?B?ZzQzOTRvcDdwSjMrSk11UmxMSHg4c2N1RVIzYTlxT2JNcXdSUGN5Y29JVTE0?=
 =?utf-8?B?RDJBcndncC91SmFIV3VPK1hscXdDZHpuc09nVmF5N1dDSzRyTGxadnQ3d0Vr?=
 =?utf-8?B?WkhVSmREYlBNOE5yeXV0VnAyUTBhK1V6dzYrTlFXNFhndVp5Slh5WW1YbWox?=
 =?utf-8?B?cDF0dFN4RWlmc2w5emxmNk1aeFVXblJIanFKZjMrSURsVFA4Q3p1T1czMldy?=
 =?utf-8?B?TUtRUFNENXFDOXJzQ1BQSmpiTHZLOS9Uck5jK1dScVJ4Qlh3aVlvK3ZGalA3?=
 =?utf-8?B?dFRNakJNK2RxMlJlRUZhbHFmNXVkR2tvQTZqbngzQWFtdGxmZVEwL2dpSWwz?=
 =?utf-8?B?SlVCY1RoNm5hWDNLRFVOMkZVOFJ3c3Y4a0NmSkNOTE8rRStsbDdPUGVCQ004?=
 =?utf-8?B?d3FXMi9TTlRzMjBVSm9nem5vbzdTM1Z6Q3Y1dkZLYWV5OHllM2tlRy9OOW5U?=
 =?utf-8?B?OEdmZUxycFdZUHptOS9ZWDdNTlhudk1jb2xNMUN5TEhxQWs5RHhxM1JaUzQ4?=
 =?utf-8?B?czZ5ZGkvN0FnNytlaE9qTk82b3VWVTBjT3dEL0thZWRMeGZCeG9uQy9aS3Iw?=
 =?utf-8?B?ZUVzR1R3Mk1iT3ZYekR1ME43eTdDK2RIQVJIMW80c29GS05jenlEMlBtSVlL?=
 =?utf-8?B?RmZxdXE4d04ybUtjMVpMOUFiemx6eFNsRDBVUUFGbVc2TXgxallrcXA2eEdj?=
 =?utf-8?B?UEU3R1NsNGpRdTN4U2JCSCtTWGptYmRybThCTS82Yi9IamtQWDRaYk9TVTVi?=
 =?utf-8?B?SFRCZFN2RitDSzJyZHovNVlNUEpmUFZNZlU5NWkwdkpnQXFKK3R0YTUvL0x0?=
 =?utf-8?B?WEtCYjZIWk1yeDdUVXFKbDVDem01SUxHelZpbE9OQjlUTjhxMjdEWjBKTDZM?=
 =?utf-8?B?M08zTHJSVjhZU1ZGSDQvZE1pNEI5dXFzRXM2eFlxcWRwdWNWT0pzc2R6U1d3?=
 =?utf-8?B?NzlZU3VOenhnU04yQmFiS2RJMHlHaElCT2FSVjFoc3RhdWNaYXB6Zk00emFt?=
 =?utf-8?B?RkZMQWlvcDBlV1VERFl1N015UTFDVEhTTkdkVGd0Zy9LQ1BoTWMrV3ZNQjV1?=
 =?utf-8?B?Z1p6M1hTcFphNDEveVgrWmVtdFdWUEVYek1vTWtpNjVIVFFaaXJyOVhIcGZi?=
 =?utf-8?B?MnJqZ1p6aHdSSVpmbDVDK0ZRdDNYUzRjME42SllxVHhZQUx3c2lqbTVqQ0dq?=
 =?utf-8?B?alVLdHd5OEpsdnYwRVNOd2JnVEpySzNhZkh4YzQ5VlJ0aUhaUGJadUhja3NP?=
 =?utf-8?B?STBXQURSaEsvdDdrdEl2N1lBZ201T05JYkRPSUdjKyt3MHY5ekkwWUlvREV0?=
 =?utf-8?B?MjVZdExaeG9hSnFKMHhVcFJMVG5FUUJmMEdVOFVGTzVyZlpMUEhLS3pUMnRZ?=
 =?utf-8?B?N09Ib2NzejdiM0VTSXNjYWpzOE5XT2NFN282SEpUaGM4bTNobU5ZL2c4ajNj?=
 =?utf-8?B?ZHZGT2ZDRlY5Qk5LQ2ZyVlRPU1p4QlNYaUFMQjJESFNxTWxQcjFIVzY2a2t6?=
 =?utf-8?Q?QjdO2hjb0/o=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB5277C66F665F2392877BD8E3F37B0@VI1PR04MB5277.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(366004)(39860400002)(376002)(396003)(13464003)(189003)(199004)(81156014)(55016002)(81166006)(9686003)(33656002)(8676002)(53546011)(7696005)(53936002)(76176011)(6506007)(26005)(6436002)(4326008)(102836004)(25786009)(2501003)(99286004)(66066001)(8936002)(105586002)(14454004)(106356001)(2906002)(14444005)(256004)(6116002)(74316002)(229853002)(3846002)(6246003)(305945005)(478600001)(7736002)(486006)(86362001)(44832011)(11346002)(476003)(446003)(7416002)(68736007)(5660300002)(71190400001)(71200400001)(316002)(52536013)(2201001)(186003)(97736004)(110136005)(54906003)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5277;
 H:VI1PR04MB4800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A7OE0haRVSsAYCGJItakEQJvfY550hdKSwSlXGjCXOLWEYhc4giKIk7KG4ikDE1r7uRcuVDKEStgCm2YszAOsCfgzmVBaiIwOcG61OMegVy1Kd7IIMliSMmaoAItvLIJO2BZ8u1rti8KyfRgpG+EpNVYVKkC75HPzrXCIsf4t9QaHE4LUC+3YwhD2Rn6RKs0UrPdnQEiBY33H0bnKgjPJLk+yosBSmEWlET2URSoD5I+IdgIbRWBmAVjQpx081WoO3wBWFLpNO3VtJmahLjSTp2E2Rkipxg7CaRMyFzRv/3GhvOUC4z771VvZXQKPMPMWfzYzXxPMpBaxx6oh7jlY8fM/L3VJ/Lqdh6HXM/Kyaj70P/p6HM9xTjbveWdEggRNlL37esdun6aP/Cga9HgPWSmkhlYzSbSG+jgWWaq7kA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41f4ecc-6195-4aac-5ee6-08d69bd2785e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 10:09:18.2370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5277
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
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 Andy Tang <andy.tang@nxp.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2NvdHQgV29vZCA8b3Nz
QGJ1c2Vycm9yLm5ldD4NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMjYsIDIwMTkgMzoxNSBQ
TQ0KPiBUbzogVmFiaGF2IFNoYXJtYSA8dmFiaGF2LnNoYXJtYUBueHAuY29tPjsgc3VkZWVwLmhv
bGxhQGFybS5jb207DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnOw0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0u
Y29tOyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnOyBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsNCj4gc2JveWRAa2Vy
bmVsLm9yZzsgcmp3QHJqd3lzb2NraS5uZXQ7IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOyBsaW51
eC0NCj4gY2xrQHZnZXIua2VybmVsLm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWwtDQo+IG93bmVyQHZnZXIua2VybmVsLm9yZzsgY2F0YWxpbi5tYXJpbmFzQGFybS5j
b207IHdpbGwuZGVhY29uQGFybS5jb207DQo+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBh
cm5kQGFybmRiLmRlOw0KPiBrc3Rld2FydEBsaW51eGZvdW5kYXRpb24ub3JnOyB5YW1hZGEubWFz
YWhpcm9Ac29jaW9uZXh0LmNvbTsgTGVvIExpDQo+IDxsZW95YW5nLmxpQG54cC5jb20+OyBzaGF3
bmd1b0BrZXJuZWwub3JnDQo+IENjOiBsaW51eEBhcm1saW51eC5vcmcudWs7IGFkcmlhbi5odW50
ZXJAaW50ZWwuY29tOw0KPiB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOyBZb2dlc2ggTmFyYXlhbiBH
YXVyDQo+IDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT47IEFuZHkgVGFuZyA8YW5keS50YW5n
QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNC80XSBjbGs6IHFvcmlxOiBBZGQgY2xv
Y2tnZW4gc3VwcG9ydCBmb3IgbHgyMTYwYQ0KPiANCj4gT24gVHVlLCAyMDE5LTAyLTI2IGF0IDA4
OjM0ICswMDAwLCBWYWJoYXYgU2hhcm1hIHdyb3RlOg0KPiA+IEBAIC0xNDM1LDYgKzE0NDYsNyBA
QCBDTEtfT0ZfREVDTEFSRShxb3JpcV9jbG9ja2dlbl90MTAyMywNCj4gImZzbCx0MTAyMy0NCj4g
PiBjbG9ja2dlbiIsIGNsb2NrZ2VuX2luaXQpOyAgQ0xLX09GX0RFQ0xBUkUocW9yaXFfY2xvY2tn
ZW5fdDEwNDAsDQo+ID4gImZzbCx0MTA0MC1jbG9ja2dlbiIsIGNsb2NrZ2VuX2luaXQpOw0KPiA+
IENMS19PRl9ERUNMQVJFKHFvcmlxX2Nsb2NrZ2VuX3QyMDgwLCAiZnNsLHQyMDgwLWNsb2NrZ2Vu
IiwNCj4gPiBjbG9ja2dlbl9pbml0KTsgIENMS19PRl9ERUNMQVJFKHFvcmlxX2Nsb2NrZ2VuX3Q0
MjQwLA0KPiA+ICJmc2wsdDQyNDAtY2xvY2tnZW4iLCBjbG9ja2dlbl9pbml0KTsNCj4gPiArQ0xL
X09GX0RFQ0xBUkUocW9yaXFfY2xvY2tnZW5fbHgyMTYwYSwgImZzbCxseDIxNjBhLWNsb2NrZ2Vu
IiwNCj4gPiBjbG9ja2dlbl9pbml0KTsNCj4gDQo+IFRoZSBjaGlwcyB3ZXJlIHByZXZpb3VzbHkg
aW4gYWxwaGFiZXRpY2FsIG9yZGVyLi4uDQpPaw0KPiANCj4gLVNjb3R0DQo+IA0KDQo=

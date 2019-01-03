Return-Path: <SRS0=6Lu7=PL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84322C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 19:23:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007B0208E3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 19:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kAb9c1Xz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007B0208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43VyWR5zhWzDqLs
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 06:23:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.1.61; helo=eur02-he1-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="kAb9c1Xz"; 
 dkim-atps=neutral
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10061.outbound.protection.outlook.com [40.107.1.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43VyTc3y6GzDqGB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 06:21:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13HSnnbyMm9MLMAR3VgBMidpgRyiNJp8HSYwVkbiz4g=;
 b=kAb9c1XzUYfFYlcWO9w0IDeE8PJJPqqihrRwyVf//iwRmmK1PiMOSZze6PiG9IDKWIUnRwhvwlUqZSYtmCM6109jZKR4iV4reUDxw0VD7qR9QvmN4wpEHcn9xVIB4bIphi4HmU4JpOIKTKmxw88w2Iv6a0uWI+CxuppZZLAxxao=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB5392.eurprd04.prod.outlook.com (20.178.120.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Thu, 3 Jan 2019 19:21:45 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::ad47:75b9:3ed8:51f0]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::ad47:75b9:3ed8:51f0%6]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 19:21:45 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Rob Herring <robh+dt@kernel.org>
Subject: RE: [RFC PATCH] ASoC: fsl: Add Audio Mixer CPU DAI driver
Thread-Topic: [RFC PATCH] ASoC: fsl: Add Audio Mixer CPU DAI driver
Thread-Index: AQHUlu7sas942UE1M06TLvqfe6BTx6WRUdAAgAx6LQCAACmSgIAACePQ
Date: Thu, 3 Jan 2019 19:21:45 +0000
Message-ID: <VI1PR04MB4704FAAAA04C29EF365AD7B9928D0@VI1PR04MB4704.eurprd04.prod.outlook.com>
References: <1545150569-14897-1-git-send-email-viorel.suman@nxp.com>
 <CAGoOwPQvc5w05NOVsp6Qw-Ee3CJJCcaU2Dtzwbf+7bUe_kFEbA@mail.gmail.com>
 <1546531006.14398.83.camel@nxp.com>
 <CAL_JsqLcBjRBV_zOoMGGB9gFVgk=4LSx80sFam1-9neDVjAYfQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLcBjRBV_zOoMGGB9gFVgk=4LSx80sFam1-9neDVjAYfQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [92.81.104.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5392;
 6:MGVHR52brJg2LNxLsfKbv/JptTEcQTP8fA/efRQLFCowNTMvbast0K36cRs1X1UF2nxj0YbSYRTFzy1g0jsFpK8heCQC0F6vEhvjFyG7r7XvWFqVLl3yBNJrJNb7Il0MFsb50NXdS/KawLkeU7Noq1tAoCuurnt14wDcs5ZaL3OviSQn1dZ85r73wXkyq93Zh5Nfk+K21TGgMCTZQnpvUeIueLoAmzfPrhk10B+GzlhKzXD6ljGSHq7Z/7S1iIOR2LxyA76eI4Aninju5MIqBrHI0GKxfpypH4pMUTMWt/GPkkwLpmOH30WFMAogBE3kGcyPfqj8TdyzHxjsUGfGgUAHKCioZCEYtNb+p3zuBvTPh+nhRGL9Iaja/vwZIBJaZHegnDPw3gMyTFFCdfgKGG//aTpLzS7Xggo+A5BAJ7y/Mk6G832w1bfijmDdE26o6lnuSRypcEkXiLBdniEP7w==;
 5:UfmkySsfpNP1nR6dzhdci+45QBYCO0PGsnZnaicZHReo60yNkQ+vkEjEzbDC1QsE4PACvafv9YpQU86fGU5QuwlrDXwtnSbWDiLePpvFRSU4Da8B9dgu0XAaofmYiMymxl2nzQ+r1y/Aq587PgoTNVw4oICaVRPkSofZbtNtrQg=;
 7:rpeyHNob7s9XkcXKtKKPNEgoXraBemYjKzrLrw4Pol6kU/RYRmwHQH5X4zLDZGgC5losxO34XXtbUqdZtvsaEMp7KTzuG988vaI/qLZMVg5fPly5wQ4nHJM35si0MQapqjo5+6pGIKljLGS6O1cwtg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 84fb2385-da6c-48c8-d385-08d671b0b371
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5392; 
x-ms-traffictypediagnostic: VI1PR04MB5392:
x-microsoft-antispam-prvs: <VI1PR04MB5392DCB7A291D133F8E7B532928D0@VI1PR04MB5392.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB5392; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB5392; 
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(366004)(136003)(346002)(39860400002)(376002)(13464003)(199004)(189003)(966005)(217873002)(55016002)(25786009)(53936002)(478600001)(6246003)(4326008)(316002)(256004)(106356001)(39060400002)(71190400001)(71200400001)(446003)(7736002)(476003)(9686003)(97736004)(26005)(6306002)(4001150100001)(11346002)(186003)(229853002)(86362001)(93886005)(105586002)(14454004)(305945005)(74316002)(7416002)(68736007)(76176011)(6346003)(44832011)(3846002)(81166006)(102836004)(345774005)(7696005)(2906002)(54906003)(6116002)(66066001)(99286004)(6436002)(486006)(81156014)(8936002)(6506007)(53546011)(5660300001)(8676002)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5392;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J4SUiCok8ohn3pkrg0+D0Kc299FyhfOwvVtzvDvmNPs6abJIpfRq5hIQg0gqzPd4nE2urn0HqW3e5KooOiHD2jjqepIGfPvqRa3ZoxnwCQRV/hVpAdjhppKOwAnMBkuDifH6VY8avGBSUE3tr7TmsNgj9BEAzFKNXqK86u4puo4zxRmwURIFJKMy1KRUw2GCYw4fwnnDQ+YwfotXPZeYVTtEhTbVQWNsCcFjLSfqZhFzprE9GhR4HnFyabxprpInW9mCxWv+r8kYor1Y4WwA6K8yVY8yluHTyHOqpRMdkcbfue0w6kYE4ACkD5N1EmuC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84fb2385-da6c-48c8-d385-08d671b0b371
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 19:21:45.7117 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5392
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Daniel Baluta <daniel.baluta@nxp.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, "perex@perex.cz" <perex@perex.cz>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyBbbWFpbHRv
OnJvYmgrZHRAa2VybmVsLm9yZ10NCj4gU2VudDogVGh1cnNkYXksIEphbnVhcnkgMywgMjAxOSA4
OjI2IFBNDQo+IFRvOiBWaW9yZWwgU3VtYW4gPHZpb3JlbC5zdW1hbkBueHAuY29tPg0KPiBDYzog
bmljb2xlb3RzdWthQGdtYWlsLmNvbTsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47
IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eHBwYy1kZXZAbGlzdHMub3ps
YWJzLm9yZzsgdGltdXJAa2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IFhpdWJvLkxlZUBnbWFpbC5jb207IEZhYmlvIEVzdGV2YW0NCj4gPGZhYmlvLmVzdGV2YW1Abnhw
LmNvbT47IGJyb29uaWVAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IHRpd2Fp
QHN1c2UuY29tOyBsZ2lyZHdvb2RAZ21haWwuY29tOyBEYW5pZWwgQmFsdXRhDQo+IDxkYW5pZWwu
YmFsdXRhQG54cC5jb20+OyBwZXJleEBwZXJleC5jejsgYWxzYS1kZXZlbEBhbHNhLXByb2plY3Qu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIXSBBU29DOiBmc2w6IEFkZCBBdWRpbyBNaXhl
ciBDUFUgREFJIGRyaXZlcg0KPiANCj4gT24gVGh1LCBKYW4gMywgMjAxOSBhdCA5OjU5IEFNIFZp
b3JlbCBTdW1hbiA8dmlvcmVsLnN1bWFuQG54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGkgTmlj
b2xpbiwNCj4gPg0KPiA+IFRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjaywgc2FtZSBoZXJlIC0g
anVzdCBiYWNrIGZyb20gdmFjYXRpb24uDQo+ID4NCj4gPiBPbiBKbywgMjAxOC0xMi0yNyBhdCAw
MToyNCArMDgwMCwgTmljb2xpbiBDaGVuIHdyb3RlOg0KPiA+ID4gSGkgVmlvcmVsLA0KPiA+ID4N
Cj4gPiA+IFNvcnJ5IGZvciB0aGUgbGF0ZSByZXNwb25zZSwgaGF2aW5nIGJlZW4gb24gYSBsb25n
IHZhY2F0aW9uLg0KPiA+ID4NCj4gPiA+IFRoZSBjb2RlIGxvb2tzIHByZXR0eSBjbGVhbi4gSnVz
dCBzb21lIHNtYWxsIGNvbmNlcm5zL3F1ZXN0aW9ucw0KPiA+ID4gYmVsb3cuDQo+ID4gPg0KPiA+
ID4gT24gV2VkLCBEZWMgMTksIDIwMTggYXQgMTI6MzAgQU0gVmlvcmVsIFN1bWFuIDx2aW9yZWwu
c3VtYW5AbnhwLmNvbT4NCj4gPiA+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBU
aGlzIHBhdGNoIGltcGxlbWVudHMgQXVkaW8gTWl4ZXIgQ1BVIERBSSBkcml2ZXIgZm9yIE5YUCBp
TVg4IFNPQ3MuDQo+ID4gPiA+IFRoZSBBdWRpbyBNaXhlciBpcyBhIG9uLWNoaXAgZnVuY3Rpb25h
bCBtb2R1bGUgdGhhdCBhbGxvd3MgbWl4aW5nDQo+ID4gPiA+IG9mIHR3byBhdWRpbyBzdHJlYW1z
IGludG8gYSBzaW5nbGUgYXVkaW8gc3RyZWFtLg0KPiA+ID4gPg0KPiA+ID4gPiBBdWRpbyBNaXhl
ciBkYXRhc2hlZXQgaXMgYXZhaWxhYmxlIGhlcmU6DQo+ID4gPiA+IGh0dHBzOi8vd3d3Lm54cC5j
b20vZG9jcy9lbi9yZWZlcmVuY2UtbWFudWFsL0lNWDhEUVhQUk0ucGRmDQo+ID4gPiA+DQo+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IFZpb3JlbCBTdW1hbiA8dmlvcmVsLnN1bWFuQG54cC5jb20+DQo+
ID4gPiA+IC0tLQ0KPiA+ID4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvZnNsLGFt
aXgudHh0ICAgICAgICAgfCAgNDUgKysNCj4gPiA+ID4gIHNvdW5kL3NvYy9mc2wvS2NvbmZpZyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA3ICsNCj4gPiA+ID4gIHNvdW5kL3NvYy9m
c2wvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAzICsNCj4gPiA+ID4g
IHNvdW5kL3NvYy9mc2wvZnNsX2FtaXguYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgNTU0
DQo+ID4gPiA+ICsrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gPiAgc291bmQvc29jL2ZzbC9m
c2xfYW1peC5oICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMDEgKysrKw0KPiA+ID4gSSBh
aW1uJ3QgYWdhaW5zdCB0aGUgbmFtaW5nIGhlcmUsIGJ1dCBpdCBzZWVtcyB0byBiZSBBVURNSVgg
aW4gUk0/DQo+ID4gPg0KPiA+ID4gV291bGQgaXQgYmUgYmV0dGVyIHRvIGFsaWduIHdpdGggdGhh
dD8gSXQncyB5b3VyIGRlY2lzaW9uIHRob3VnaC4NCj4gPg0KPiA+IFRvIG1lICJBVURNSVgiIHNv
dW5kcyBtb3JlIGxpa2Ugc29tZSBSVEwgaGlnaCBsZXZlbCBpbnRlZ3JhdGlvbg0KPiA+IG1vZHVs
ZSwgSSB3b3VsZCBwcmVmZXIgdG8ga2VlcCBpdCBhcyBpdCBpcyBpZiB0aGVyZSBpcyBubyBzdHJv
bmcNCj4gPiByZWFzb24gdG8gcmVuYW1lIGl0Lg0KPiANCj4gQXQgbGVhc3QgZm9yIGNvbXBhdGli
bGUgc3RyaW5nIG5hbWVzLCBtYXRjaGluZyB3aGF0J3MgaW4gdGhlIFJNIG9yIFJUTCBpcyBtb3Jl
DQo+IGFwcHJvcHJpYXRlLiBXaGVyZSBkb2VzICJBTUlYIiBjb21lIGZyb20/DQo+IA0KPiBSb2IN
Cg0KVGhlcmUgYXJlIHBsYWNlcyBpbiBSTSB3aGVyZSBBdWRpbyBNaXhlciBpcyByZWZlcnJlZCBh
cyAiQU1JWCI6DQoxLiBQYWdlIDMzLCAiVGFibGUgMi02LiBBdWRpbyBETUEgTWVtb3J5IE1hcCIN
CjIuIFBhZ2UgMjU5LCAiTFBDR19BTUlYX1JFR1MiDQozLiBQYWdlIDY4MTYsICJUYWJsZSAxNi0x
LiBBRE1BIFN1YnN5c3RlbSBNb2R1bGVzIg0KDQovVmlvcmVsDQo=

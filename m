Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10BCC10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 02:56:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 301C6213F2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 02:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gaO4r5wj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301C6213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dX3r3q9VzDqHZ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 12:56:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.2.57; helo=eur02-ve1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="gaO4r5wj"; 
 dkim-atps=neutral
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20057.outbound.protection.outlook.com [40.107.2.57])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dX1x4pLNzDqHX
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 12:54:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLMDOReDQAQLCGVZ5IhtJ0RdUKY/8vRGa+L2lRsWCfo=;
 b=gaO4r5wjG+Ud/hwtXjyBhB5luZFN0RHu3CPIAhzfPwJzPet6Z3kQ0wZb0ve7U9yEtg2w/Wd9e0CWg4c7iIFxSJMyLQQtBQTpyRi4YTJdq1X5WHV1QuagJ/jPvJ+BzlFZTInva7vIZybfrtz12XiiMklMzsKEzMHWy40VbdHNfkQ=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6464.eurprd04.prod.outlook.com (20.179.233.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Tue, 9 Apr 2019 02:54:19 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%6]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 02:54:19 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, "timur@kernel.org"
 <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com"
 <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: RE: [EXT] Re: [PATCH V1] ASoC: fsl_esai: replace fall-through with
 break
Thread-Topic: [EXT] Re: [PATCH V1] ASoC: fsl_esai: replace fall-through with
 break
Thread-Index: AQHU7e1fLmmYRIJqIECtUR/V3RQ9hKYyaxcAgAC3L4A=
Date: Tue, 9 Apr 2019 02:54:19 +0000
Message-ID: <VE1PR04MB6479C16BB1C92E1AE291BB12E32D0@VE1PR04MB6479.eurprd04.prod.outlook.com>
References: <66c117128f300b0ec5f278f538412789c78b60a6.1554715589.git.shengjiu.wang@nxp.com>
 <38a6d36e-0f8e-fe3d-202b-30371042e248@embeddedor.com>
In-Reply-To: <38a6d36e-0f8e-fe3d-202b-30371042e248@embeddedor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b35f420-b1f0-4346-5e01-08d6bc96a980
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6464; 
x-ms-traffictypediagnostic: VE1PR04MB6464:
x-microsoft-antispam-prvs: <VE1PR04MB64641F1A0C68A9CC43C461B4E32D0@VE1PR04MB6464.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(346002)(376002)(396003)(136003)(189003)(199004)(52536014)(229853002)(3846002)(2201001)(81166006)(76176011)(74316002)(6116002)(186003)(68736007)(86362001)(102836004)(2906002)(66066001)(7736002)(81156014)(26005)(53546011)(6506007)(8936002)(305945005)(8676002)(5660300002)(14444005)(4326008)(14454004)(25786009)(478600001)(6436002)(7696005)(71190400001)(71200400001)(53936002)(105586002)(110136005)(97736004)(446003)(11346002)(486006)(476003)(33656002)(2501003)(55016002)(106356001)(316002)(256004)(99286004)(9686003)(6246003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6464;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kARwyNKKs5TqnvJNmsQ5GMggrJD1VHPoahGmVSDuBzGNZDa/RVs9oXT9oK/dMFwEUZo7Je0PJw9Ge9I4PEXee3DGC1wDiAQx7rYK49L3VBGesj/DEKJTHlyjydEES3IeBa1y/31ZLcNR2cDrsH2JxM/eqydn4yU7Wa4M1D2aa51RPXtjnlNWd0yFgasRIWIEJ9aoq2XKmv5V2zsboHZpERJMWkTvlIg0tYkaXiTAWSrU8rqLUSN31IV/JGdrcs/geWmU+MBqVx+byGRlAGZs9r3KtThSpbVqUr9PRp2Cq7VDmOl0wtqoxi2Ymc6kGKTwNSZZr5/RGaLf5pCHnoSQvF22InuJ+AeWfP64HxBZ7ZzMB2j0z4rwKPEr0KOv+Lij4kDrxf/rpZRBLHj3EcaOT564cMZlJugxAnNYBLhOmPw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b35f420-b1f0-4346-5e01-08d6bc96a980
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 02:54:19.4012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6464
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgR3VzdGF2bw0KDQo+IA0KPiANCj4gT24gNC84LzE5IDQ6MjggQU0sIFMuai4gV2FuZyB3cm90
ZToNCj4gPiBjYXNlIEVTQUlfSENLVF9FWFRBTCBhbmQgY2FzZSBFU0FJX0hDS1JfRVhUQUwgc2hv
dWxkIGJlDQo+IGluZGVwZW5kZW50IG9mDQo+ID4gZWFjaCBvdGhlciwgc28gcmVwbGFjZSBmYWxs
LXRocm91Z2ggd2l0aCBicmVhay4NCj4gPg0KPiBJZiB0aGlzIGlzIGNvcnJlY3QsIHRoZW4geW91
IHNob3VsZCB1c2UgdGhlIGZvbGxvd2luZyAiRml4ZXMiIHRhZyBpbnN0ZWFkLA0KPiB3aGljaCBp
cyB0aGUgb25lIHRoYXQgaW50cm9kdWNlZCB0aGUgYnVnOg0KPiANCj4gRml4ZXM6IDQzZDI0ZTc2
YjY5OCAoIkFTb0M6IGZzbF9lc2FpOiBBZGQgRVNBSSBDUFUgREFJIGRyaXZlciIpDQo+IA0KPiA+
IEZpeGVzOiAxNmJiZWIyYjQzYzMgKCJBU29DOiBmc2xfZXNhaTogTWFyayBleHBlY3RlZCBzd2l0
Y2gNCj4gPiBmYWxsLXRocm91Z2giKQ0KPiA+DQo+ICAgICAgICAgXl5eXg0KPiBiZWNhdXNlIHRo
aXMgZGlkbid0IGNoYW5nZSBhbnkgZnVuY3Rpb25hbGl0eS4NCg0KT2ssIHRoaXMgd2lsbCBiZSB1
cGRhdGVkLg0KDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoZW5naml1IFdhbmcgPHNoZW5naml1
LndhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgc291bmQvc29jL2ZzbC9mc2xfZXNhaS5jIHwg
MiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvZnNsL2ZzbF9lc2FpLmMgYi9zb3VuZC9z
b2MvZnNsL2ZzbF9lc2FpLmMgaW5kZXgNCj4gPiBjNzQxMGJiZmQyYWYuLmJhZDBkZmVkNmI2OCAx
MDA2NDQNCj4gPiAtLS0gYS9zb3VuZC9zb2MvZnNsL2ZzbF9lc2FpLmMNCj4gPiArKysgYi9zb3Vu
ZC9zb2MvZnNsL2ZzbF9lc2FpLmMNCj4gPiBAQCAtMjUxLDcgKzI1MSw3IEBAIHN0YXRpYyBpbnQg
ZnNsX2VzYWlfc2V0X2RhaV9zeXNjbGsoc3RydWN0DQo+IHNuZF9zb2NfZGFpICpkYWksIGludCBj
bGtfaWQsDQo+ID4gICAgICAgICAgICAgICBicmVhazsNCj4gPiAgICAgICBjYXNlIEVTQUlfSENL
VF9FWFRBTDoNCj4gPiAgICAgICAgICAgICAgIGVjciB8PSBFU0FJX0VDUl9FVEk7DQo+IA0KPiBB
bHNvLCB5b3Ugc2hvdWxkIHVzZSBhIHNpbXBsZSBhc3NpZ25tZW50IG9wZXJhdG9yICI9IiBpbnN0
ZWFkIG9mICJ8PSIgaW4NCj4gYm90aCBjYXNlcy4NCg0KVGhlIHJlc3VsdCBpcyBzYW1lIGZvciAi
PSIgYW5kICJ8PSIsIGJlY2F1c2UgdGhlcmUgaXMgImVjciA9IDAiIGluIGJlZ2lubmluZyBvZg0K
VGhpcyBmdW5jdGlvbi4gDQoNCj4gDQo+ID4gLSAgICAgICAgICAgICAvKiBmYWxsIHRocm91Z2gg
Ki8NCj4gPiArICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAgIGNhc2UgRVNBSV9IQ0tSX0VY
VEFMOg0KPiA+ICAgICAgICAgICAgICAgZWNyIHw9IGVzYWlfcHJpdi0+c3luY2hyb25vdXMgPyBF
U0FJX0VDUl9FVEkgOiBFU0FJX0VDUl9FUkk7DQo+ID4gICAgICAgICAgICAgICBicmVhazsNCj4g
Pg0KPiANCj4gVGhhbmtzDQo+IC0tDQo+IEd1c3Rhdm8NCg==

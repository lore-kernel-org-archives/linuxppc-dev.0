Return-Path: <SRS0=/GF9=P6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A2CC282C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 11:24:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C752084A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 11:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fdYo95nm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C752084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kQzz68pSzDqN9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 22:24:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.3.80; helo=eur03-am5-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="fdYo95nm"; 
 dkim-atps=neutral
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30080.outbound.protection.outlook.com [40.107.3.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kQtS1VcKzDqD8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 22:19:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDKpcMk7/fcgOxHG82Vk04DSFdDSCF1DMFWjXZ7zBCs=;
 b=fdYo95nm76uNFNrjbmdh8RtAJbemWFRpHeAudwgI+87+MpEKTgIu4qGuMSKQ7ZVXvr5mcUsF95S37XPAcXovQRvPE+WVBVcfIAH+duBTnBL3yp/9GPst5ONkDIstlQgakOqkHKakG8+NRSsUS4zfIziFfPQo9x4FKxt/9htWCjc=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB3072.eurprd04.prod.outlook.com (10.170.228.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Tue, 22 Jan 2019 11:19:37 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::e58a:8812:d380:2080]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::e58a:8812:d380:2080%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 11:19:37 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 0/4] Add NXP AUDMIX device and machine drivers
Thread-Topic: [PATCH v3 0/4] Add NXP AUDMIX device and machine drivers
Thread-Index: AQHUrmKoQmEVxQazyE68ciNiNCuyvqWzo60AgAFfkwCAAG0MAIAFu6UA
Date: Tue, 22 Jan 2019 11:19:36 +0000
Message-ID: <1548155976.13051.2.camel@nxp.com>
References: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
 <20190117161804.GA5760@bogus> <1547817384.11482.33.camel@nxp.com>
 <20190118194642.GA11798@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190118194642.GA11798@Asurada-Nvidia.nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB3072;
 6:ClOrgVCmwbr+1N+B0GR1+PtGzRmIgYWLo8zqQpRBHrZYwiCOcPeyi8pm5PIpMLo+o4IfQ/tO4h2UfEAIcyWyrBymckyNEtSZugglMPbXOZFZL959Z4oG6pvsIjkKXTRi2bHJGJbW1X0u0S0fHrefT3CxT9w2IJ05lEXirVPgwMpObsoMgZArSmRJu+EJBAumDsEl6XjoFXkxSzdcLOnZCPLJ5hyegue13SJm9VFz1aERPMz9lcbBw8LL/C1PX0ClEsHRyFSJtFfeArmJWQ0vme8mdiEJfz4T2O4XNWMGK6AKIB1DyM6bu7II+Vx6eysCskdFMuptSmsP/cvpgj2YAWyfYPNlkj9rvXO0Wy5CghJ5V4ZeMAwYzuMJb5hrjg88ysxXBx+uk0N7dOFz9dBlUPeRzhXfeyzX9snXpwiCW1DtBTGjmXrooPFO7GeqYrbS/PZW+pRhJ/n3q4e4umD57Q==;
 5:Tr8cPvlDJtZJ5kpPhkK8MkhsLtfu++fnHeJUrYDhS6fyFVFQkTZ43KflbtdAmlGpc7+/u6bAjofzrJ8ek28jmtLp87e8FoIOpKK8MnBTUDsrmZCfs4vDHUuExljsfDGLeTAPikc7SPSd6Z54Dh+2GdvttgRDPs7HQu6CE5t9G8seHbi6bTXdcyABRdvw2iOrMVBazn3OE19ydk5k4ERwAQ==;
 7:rGureO1e8P3p/WeBKqGnQQjKMYelKwzyzfHqlJtrSNDHGirB+yQ5qqxGg9U93RDStYL2HvUFy8EAsYGSpENeRbc2trSCCdpvdCIj1a7+owKzjpZiviQ7wiQTPjzUlWihm2wlWaMa2LoHmjTD/nKs1g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 596001fd-c4c4-4d11-b443-08d6805b7e72
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB3072; 
x-ms-traffictypediagnostic: VI1PR04MB3072:
x-microsoft-antispam-prvs: <VI1PR04MB3072D76D68F2884B33C982FF92980@VI1PR04MB3072.eurprd04.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(136003)(346002)(376002)(396003)(51444003)(199004)(189003)(7416002)(2616005)(11346002)(446003)(5640700003)(103116003)(6486002)(2501003)(86362001)(26005)(478600001)(3846002)(7736002)(305945005)(316002)(1361003)(6916009)(6116002)(476003)(6506007)(8936002)(217873002)(44832011)(102836004)(97736004)(486006)(54906003)(93886005)(1730700003)(81166006)(81156014)(8676002)(186003)(39060400002)(71200400001)(68736007)(4326008)(71190400001)(53936002)(6246003)(76176011)(345774005)(25786009)(6512007)(256004)(99286004)(2351001)(14454004)(66066001)(6436002)(2906002)(36756003)(229853002)(105586002)(1411001)(106356001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB3072;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: flpA+uVlXamQUVt3GSMeCFzVpUOmEDCMBs6xl7jrZ6nCf51zPX8cyZ0Vr9FY1BtUKLSUbGzZ2ulD4hV9Deu7QFu4G2BvfNAz3KYt4Db6gJtv8vDT+Z2J9WXhrT+OmZBceSMTfz30cZhG80xkWeMTBlG8ZCvJ7Ba9sYnUV8ho6UyudwBIcApJO9cZwpf5WUtPO1N8fHRP6S1vWhL/od5FAo6n2iW2eHJ+vtqqEBqYHgZ3ad9XBVubF1qndMmweI+y0bb9hOA1iWbXozWMwiOIZrd0tI+51bcMf2I99iNnSKZyV6pUQKLxBfVLHsuJgBGdxNT9ZTPCKuKHQuQ+LOM5fAEC9btapzXcwdZYdIRaARWmq4fF+ZKpLwUv9cOrMrGcE6qR9iKilWlOinImebTcGsssbdeS6mv+nldSPSF1Hi4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFCA4B8C8F29DB4A830D39B318FDA373@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 596001fd-c4c4-4d11-b443-08d6805b7e72
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 11:19:37.0235 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3072
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
 "S.j. Wang" <shengjiu.wang@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Daniel Baluta <daniel.baluta@nxp.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "viorel.suman@gmail.com" <viorel.suman@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Cosmin Samoila <cosmin.samoila@nxp.com>, "perex@perex.cz" <perex@perex.cz>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "robh@kernel.org" <robh@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgTmljb2xpbiwNCg0KT24gVmksIDIwMTktMDEtMTggYXQgMTE6NDYgLTA4MDAsIE5pY29saW4g
Q2hlbiB3cm90ZToNCj4gT24gRnJpLCBKYW4gMTgsIDIwMTkgYXQgMDE6MTY6MjRQTSArMDAwMCwg
VmlvcmVsIFN1bWFuIHdyb3RlOg0KPiA+IA0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiAxLiBN
b3ZlZCAiZGFpcyIgbm9kZSBmcm9tIG1hY2hpbmUgZHJpdmVyIERUUyBub2RlIHRvIGRldmljZQ0K
PiA+ID4gPiBkcml2ZXINCj4gPiA+ID4gRFRTIG5vZGUNCj4gPiA+ID4gwqAgYXMgc3VnZ2VzdGVk
IGJ5IFJvYi4NCj4gPiA+IFRoYXQgd2FzIG5vdCB3aGF0IEkgc3VnZ2VzdGVkLiBZb3Ugc3RpbGwg
aGF2ZSBhIHZpcnR1YWwgbm9kZQ0KPiA+ID4gd2hpY2gNCj4gPiA+IGxvb2tzIHRvIG1lIHRvIGJl
IHVubmVjZXNzYXJ5Lg0KPiA+IFRvIG1lIHJlbW92aW5nIHZpcnR1YWwgbm9kZSBpbXBsaWVzIHRo
YXQgQVVETUlYIG1hY2hpbmUgZHJpdmVyDQo+ID4gKGlteC0NCj4gPiBhdWRtaXguYyArIHZpcnR1
YWwgbm9kZSkgc2hhbGwgYmUgcmVtb3ZlZCBhbmQgbWFjaGluZSBkcml2ZXIgY29kZQ0KPiA+IG1l
cmdlZCBpbnRvIGRldmljZSBkcml2ZXIgKGZzbF9hdWRtaXguYyArIGRldmljZSBub2RlKSAtIHBs
ZWFzZSBsZXQNCj4gPiBtZQ0KPiA+IGtub3cgaWYgbXkgdW5kZXJzdGFuZGluZyBpcyB3cm9uZy4N
Cj4gV2UgY291bGQgdXNlIGEgbm9uLURUIGNvbmZpZ3VyYXRpb24gcmlnaHQ/IEZyb20gdGhlIGRy
aXZlciBsb2dpYywNCj4gRFQganVzdCByZWdpc3RlcnMgYSBkZXZpY2UgY29ycmVzcG9uZGluZyB0
byB0aGUgbWFjaGluZSBkcml2ZXIgc28NCj4gdGhhdCBpdCBjYW4gcHJvYmUoKS4gV2UgY291bGQg
cmVnaXN0ZXIgb25lIGluIGZzbF9hdWRtaXggaW5zdGVhZC4NCj4gUGxlYXNlIHJlZmVyIHRvIGhv
dyBmc2xfc3NpIHJlZ2lzdGVycyB0aGUgc291bmQgY2FyZCBkZXZpY2UuIFRoZQ0KPiBtYWNoaW5l
IGRyaXZlciBjYW4gZ2V0IGF1ZG1peF9ucCBmcm9tIHRoZSBwYXJlbnQgZGV2aWNlIHBvaW50ZXIs
DQo+IGFuZCBJIHRoaW5rIHRoYXQncyBhbGwgeW91IG5lZWQuDQo+IA0KPiBPciBtYXliZSBzb21l
b25lIGVsc2Ugd291bGQgcHJvdmlkZSBhIGJldHRlciB3YXkuIEJ1dCBpdCdkIHdvcmsuDQoNClNl
bnQgVjQgLSBpdCBpbXBsZW1lbnRzIHRoZSBhcHByb2FjaCB5b3Ugc3VnZ2VzdGVkLiBUaGFuayB5
b3UgZm9yIHRoZQ0KaGludCwgd29ya3Mgd2VsbCBpbmRlZWQuDQoNClJlZ2FyZHMsDQpWaW9yZWwN
Cg0K

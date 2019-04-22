Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E64C10F11
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 11:04:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0693206A3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 11:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xDgcKakH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0693206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nkGn55Y4zDq9l
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 21:04:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.5.85; helo=eur03-ve1-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="xDgcKakH"; 
 dkim-atps=neutral
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50085.outbound.protection.outlook.com [40.107.5.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nkF63YLQzDqNJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 21:02:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXMrdSPvgLqwtS+hZsgSlYuSfMnMI6UF0n1szvTKZgo=;
 b=xDgcKakHnReTMFnHnAL+AowfRZMBRMnuVKqlxTMR+09FfHtUpMa5QPyYMzjSK02eH9Z6gHoAQFXuWDS2xIF5x+vc8I6XNFfHlqKCK51gXylKo+zEXCRbdOO2OKnrbZgO6sn8fdS9daUnUesM22KQzwGcwz2h85MeQUYZMgyH5K0=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB4046.eurprd04.prod.outlook.com (10.171.182.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Mon, 22 Apr 2019 11:02:22 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888%3]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 11:02:22 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, Daniel Baluta
 <daniel.baluta@nxp.com>
Subject: Re: [PATCH 2/2] ASoC: fsl: Move clock operation to PM runtime
Thread-Topic: [PATCH 2/2] ASoC: fsl: Move clock operation to PM runtime
Thread-Index: AQHU95H75wiB/MHkJ0yWFp0W71EDhKZGHh+AgAHodQA=
Date: Mon, 22 Apr 2019 11:02:22 +0000
Message-ID: <1555930942.31656.4.camel@nxp.com>
References: <20190420155846.10027-1-daniel.baluta@nxp.com>
 <20190420155846.10027-3-daniel.baluta@nxp.com>
 <20190421055406.GC683@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190421055406.GC683@Asurada-Nvidia.nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41ab683b-75e1-4e4c-7e84-08d6c711ff12
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR04MB4046; 
x-ms-traffictypediagnostic: VI1PR04MB4046:
x-microsoft-antispam-prvs: <VI1PR04MB4046B831FE93994BE117308A92220@VI1PR04MB4046.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(136003)(366004)(39860400002)(396003)(346002)(199004)(189003)(2501003)(97736004)(256004)(6246003)(3450700001)(14444005)(36756003)(4326008)(6512007)(99286004)(53936002)(2906002)(43066004)(44832011)(6436002)(7416002)(8936002)(476003)(2616005)(486006)(5660300002)(6486002)(446003)(11346002)(102836004)(7736002)(6506007)(305945005)(76116006)(26005)(6636002)(73956011)(66476007)(66556008)(14454004)(64756008)(66446008)(68736007)(229853002)(66946007)(6116002)(3846002)(86362001)(25786009)(316002)(110136005)(54906003)(66066001)(478600001)(76176011)(103116003)(71190400001)(71200400001)(8676002)(186003)(81156014)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4046;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cRopYrCuTlg+rrl6XT3YaPRPFwUDsUJuzqGa2xRJP/SsI4XACTUgTVK3UDfsYDqP+uYa/6lNkGG1s0ze847kcVTau/BTQ2xPYwkYuWKKXxajqyosAfEQUS62GoA4MJE2YOsK6wlCF1/cXO/LRemJc7UQ8g+D7AzzBfYvO5jmPxh74f3Y4FCvDrYwjld57qaO69P/GuzMy8VClT57fVmoCTPprtbwP3MmDz/9UCSAIMivxmIOD9wi6HgTR11n6wijszgIkqkTk76Mj5izCcLg4iXKBihT+z9CX0GVdfp4/BkfFav0Nj9IOWWOiihqzeb0C/N/cLiqTvYIUg+ACLe2rJm/B78DyRiWox3oinkE5vsFQZraS6Xn5O7Fsv8UzR1jvTfZJ0CSVHfsWpdSDpkvCXOs6l0iq2xxH+bIuBmimn8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B80DF74A62A7F4296B3B96D49E701F6@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ab683b-75e1-4e4c-7e84-08d6c711ff12
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 11:02:22.6376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4046
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
Reply-To: Viorel Suman <viorel.suman@nxp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "S.j. Wang" <shengjiu.wang@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tiwai@suse.com" <tiwai@suse.com>, "broonie@kernel.org" <broonie@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, "perex@perex.cz" <perex@perex.cz>,
 "festevam@gmail.com" <festevam@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgTmljb2xpbiwNCg0KT24gU2IsIDIwMTktMDQtMjAgYXQgMjI6NTQgLTA3MDAsIE5pY29saW4g
Q2hlbiB3cm90ZToNCj4gT24gU2F0LCBBcHIgMjAsIDIwMTkgYXQgMDM6NTk6MDVQTSArMDAwMCwg
RGFuaWVsIEJhbHV0YSB3cm90ZToNCj4gPiANCj4gPiBUdXJuIG9mZi9vbiBjbG9ja3Mgd2hlbiBk
ZXZpY2UgZW50ZXJzIHN1c3BlbmQvcmVzdW1lLiBUaGlzDQo+ID4gaGVscHMgc2F2aW5nIHBvd2Vy
Lg0KPiA+IA0KPiA+IEBAIC05MzQsNiArOTMzLDI1IEBAIHN0YXRpYyBpbnQgZnNsX3NhaV9ydW50
aW1lX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+IMKgc3RhdGljIGludCBmc2xfc2Fp
X3J1bnRpbWVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiDCoHsNCj4gPiDCoAlzdHJ1
Y3QgZnNsX3NhaSAqc2FpID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gKwlpbnQgcmV0Ow0K
PiA+ICsNCj4gPiArCXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShzYWktPmJ1c19jbGspOw0KPiA+
ICsJaWYgKHJldCkgew0KPiA+ICsJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGVuYWJsZSBidXMg
Y2xvY2s6ICVkXG4iLCByZXQpOw0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKwl9DQo+ID4gKw0K
PiA+ICsJaWYgKHNhaS0+bWNsa19zdHJlYW1zICYgQklUKFNORFJWX1BDTV9TVFJFQU1fUExBWUJB
Q0spKSB7DQo+ID4gKwkJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKHNhaS0+bWNsa19jbGtbc2Fp
LT5tY2xrX2lkWzFdXSk7DQo+ID4gKwkJaWYgKHJldCkNCj4gPiArCQkJZ290byBkaXNhYmxlX2J1
c19jbGs7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYgKHNhaS0+bWNsa19zdHJlYW1zICYgQklU
KFNORFJWX1BDTV9TVFJFQU1fQ0FQVFVSRSkpIHsNCj4gPiArCQlyZXQgPSBjbGtfcHJlcGFyZV9l
bmFibGUoc2FpLT5tY2xrX2Nsa1tzYWktPm1jbGtfaWRbMF1dKTsNCj4gPiArCQlpZiAocmV0KQ0K
PiA+ICsJCQlnb3RvIGRpc2FibGVfdHhfY2xrOw0KPiA+ICsJfQ0KPiBUaGUgZHJpdmVyIG9ubHkg
ZW5hYmxlcyBtY2xrX2Nsa3MgZm9yIEkyUyBtYXN0ZXIgbW9kZS4gQnV0IHRoaXMNCj4gY2hhbmdl
IGVuYWJsZXMgdGhlbSBmb3IgSTJTIHNsYXZlIG1vZGUgYWxzby4gSXQgZG9lc24ndCBzb3VuZCBh
DQo+IHJpZ2h0IHRoaW5nIHRvIG1lIHNpbmNlIHdlIGFyZSBzdXBwb3NlZCB0byBzYXZlIHBvd2Vy
Pw0KDQpUaGlzIGNoYW5nZSBkb2VzIG5vdCBlbmFibGUgdGhlbSBmb3IgSTJTIHNsYXZlIG1vZGUs
IHBsZWFzZSBjaGVjayAiZnNsX3NhaV9od19wYXJhbXMiDQphbmQgImZzbF9zYWlfaHdfZnJlZSIg
ZnVuY3Rpb25zOiB0aGUgZmllbGQgInNhaS0+bWNsa19zdHJlYW1zIiBpcyBtb2RpZmllZCBvbmx5
IGZvcg0KdGhlIGNhc2Ugd2hlbiAiaWYgKCFzYWktPmlzX3NsYXZlX21vZGUpIjsNCg0KUmVnYXJk
cywNClZpb3JlbA==

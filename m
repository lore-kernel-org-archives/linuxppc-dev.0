Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767F2C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 08:42:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E63CA2082F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 08:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QrQnTcTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63CA2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44VwG35CrwzDqCY
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 19:42:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.78; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="QrQnTcTa"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00078.outbound.protection.outlook.com [40.107.0.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44VwCs3JXYzDqP3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 19:40:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uy4PuaegeCqW+7pr3uETNqgl/ETfqRH5MVAV/CmtLoU=;
 b=QrQnTcTaBWCqfjq9CmGvIbfvBWPswYB9C9rNoNWS8hOKiPjPFuEbRZ29RVNeVUAaSijF87VQHTeg8EeXEV9/78GAHzO2Hs8F6EN9VHiJLe7tDK5uC+ACQ9f+TOTPsZojT2AN5XXJgTI1zmwR0D1u6vI3ALOeP2wCa1bTTRYVpVU=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB5008.eurprd04.prod.outlook.com (20.177.49.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.19; Fri, 29 Mar 2019 08:39:59 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888%3]) with mapi id 15.20.1750.014; Fri, 29 Mar 2019
 08:39:59 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: dl-linux-imx <linux-imx@nxp.com>, "colin.king@canonical.com"
 <colin.king@canonical.com>, "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "mojha@codeaurora.org"
 <mojha@codeaurora.org>, "tiwai@suse.com" <tiwai@suse.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "shawnguo@kernel.org"
 <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "perex@perex.cz" <perex@perex.cz>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH][next] ASoC: fsl: fix spelling mistake: "missign" ->
 "missing"
Thread-Topic: [PATCH][next] ASoC: fsl: fix spelling mistake: "missign" ->
 "missing"
Thread-Index: AQHU5UibX1RD55Jjz0mN170KWKqiYqYg1JaAgAF2zoA=
Date: Fri, 29 Mar 2019 08:39:59 +0000
Message-ID: <1553848793.20793.0.camel@nxp.com>
References: <20190328092816.12883-1-colin.king@canonical.com>
 <acedd6b3-9234-390d-1626-ac02223c93cd@codeaurora.org>
In-Reply-To: <acedd6b3-9234-390d-1626-ac02223c93cd@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29db53a9-7a9a-4607-7282-08d6b42220dc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5008; 
x-ms-traffictypediagnostic: VI1PR04MB5008:
x-microsoft-antispam-prvs: <VI1PR04MB50088FD96CE0510090536726925A0@VI1PR04MB5008.eurprd04.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(376002)(39860400002)(396003)(366004)(346002)(189003)(199004)(11346002)(6246003)(6506007)(7736002)(53546011)(3846002)(2501003)(6116002)(54906003)(8936002)(186003)(14454004)(25786009)(36756003)(3450700001)(76176011)(2201001)(86362001)(256004)(26005)(14444005)(102836004)(6486002)(99286004)(106356001)(2906002)(81166006)(71200400001)(68736007)(486006)(5660300002)(446003)(44832011)(2616005)(81156014)(97736004)(6512007)(316002)(4326008)(7416002)(229853002)(305945005)(53936002)(66066001)(478600001)(103116003)(43066004)(4744005)(71190400001)(110136005)(6436002)(105586002)(8676002)(476003)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5008;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BT7K85c8JEbaErYi34lBD7BKzz+VFH/pxlQg0lhlY0OfqkwxOVsxoWSri6npbPSCCd/NbDcNNyWptjCGcgITlptqfwH66pVaHxbdS8lJP19J/e/2wT8G3KyDmj7FwTnpaKFHbYogDnAzoOUG50/T6ZydxhipHrEqqTpMH3Zx87yj/dj4cjpQeu1j1odYpdcsoCz1PXF4OpPGfMiy2m+HpTZUmJMcuzhSc6Yz3/pRhZC2tRdkmv7EvqiCSRlr9pOLvekd6OJ0P+KlHxst+mjXdX2ir5v8EDCH7kHF0FHLuwyB9yjBren6MJfBBAhW4mfIZJNUdzXIB+cZOrCpIQLfOP0mjR29ofp79Y624fdReFsbLO0okew3xLAbxIChvo4PmhtSkWWGfaMFiXEKGcohr3b3uN1oJGxwTv+46NRVHYM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58555B717F7797409ACD13AC72FD4F96@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29db53a9-7a9a-4607-7282-08d6b42220dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 08:39:59.1739 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5008
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
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

T24gSm8sIDIwMTktMDMtMjggYXQgMTU6NDggKzA1MzAsIE11a2VzaCBPamhhIHdyb3RlOg0KPiBP
biAzLzI4LzIwMTkgMjo1OCBQTSwgQ29saW4gS2luZyB3cm90ZToNCj4gPiANCj4gPiBGcm9tOiBD
b2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPiA+IA0KPiA+IFRoZXJl
IGlzIGEgc3BlbGxpbmcgbWlzdGFrZSBpbiBhIGRldl9lcnIgbWVzc2FnZS4gRml4IHRoaXMuDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25p
Y2FsLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBNdWtlc2ggT2poYSA8bW9qaGFAY29kZWF1cm9y
YS5vcmc+DQoNCkFja2VkLWJ5OiBWaW9yZWwgU3VtYW4gPHZpb3JlbC5zdW1hbkBueHAuY29tPg0K
DQo+IA0KPiAtTXVrZXNoDQo+IA0KPiA+IA0KPiA+IC0tLQ0KPiA+IMKgIHNvdW5kL3NvYy9mc2wv
aW14LWF1ZG1peC5jIHwgMiArLQ0KPiA+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvZnNsL2lt
eC1hdWRtaXguYyBiL3NvdW5kL3NvYy9mc2wvaW14LQ0KPiA+IGF1ZG1peC5jDQo+ID4gaW5kZXgg
NzJlMzdjYTZjZmJiLi43OTgzYmQzMzljMDEgMTAwNjQ0DQo+ID4gLS0tIGEvc291bmQvc29jL2Zz
bC9pbXgtYXVkbWl4LmMNCj4gPiArKysgYi9zb3VuZC9zb2MvZnNsL2lteC1hdWRtaXguYw0KPiA+
IEBAIC0xNjEsNyArMTYxLDcgQEAgc3RhdGljIGludCBpbXhfYXVkbWl4X3Byb2JlKHN0cnVjdA0K
PiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiDCoMKgCX0NCj4gPiDCoMKgDQo+ID4gwqDC
oAlpZiAoIWF1ZG1peF9ucCkgew0KPiA+IC0JCWRldl9lcnIoJnBkZXYtPmRldiwgIk1pc3NpZ24g
RFQgbm9kZSBmb3IgcGFyZW50DQo+ID4gZGV2aWNlLlxuIik7DQo+ID4gKwkJZGV2X2VycigmcGRl
di0+ZGV2LCAiTWlzc2luZyBEVCBub2RlIGZvciBwYXJlbnQNCj4gPiBkZXZpY2UuXG4iKTsNCj4g
PiDCoMKgCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiDCoMKgCX0NCj4gPiDCoMKg

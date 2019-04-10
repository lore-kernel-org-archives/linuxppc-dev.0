Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A52C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 11:09:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38472218D2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 11:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uBLHSD1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38472218D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fLyS6N4NzDqPW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 21:09:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe0c::624;
 helo=eur04-db3-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="uBLHSD1N"; 
 dkim-atps=neutral
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fLvV5kmXzDqNb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 21:06:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5f2w9UFRHiqTy21J+gzbOFMYTMeBlm8F1XkTlG5hWg=;
 b=uBLHSD1NKUxkjkK+/XE5tA3SwsjXIMTHWZe4eXgXfUYs8ADmeZAj08N1VkrHarDAw+SsF0CYlObfECJheA9BrpdoM0Jfh2sQW6G1356m6nnUu5AGQCBH3RW0wTvQrCenS0JU0/aymqi2NckhEdEKrvRDnNr/rufX/DZc/7fPHW8=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB4574.eurprd04.prod.outlook.com (20.177.55.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Wed, 10 Apr 2019 11:06:35 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888%3]) with mapi id 15.20.1792.009; Wed, 10 Apr 2019
 11:06:35 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Takashi Iwai <tiwai@suse.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Julia Lawall
 <Julia.Lawall@lip6.fr>
Subject: [PATCH v4 0/4] ASoC: fsl: audmix: remove "model" attribute and fix
 ref leaks
Thread-Topic: [PATCH v4 0/4] ASoC: fsl: audmix: remove "model" attribute and
 fix ref leaks
Thread-Index: AQHU74123FrfUXOzMUu+P8l2xCD0EA==
Date: Wed, 10 Apr 2019 11:06:35 +0000
Message-ID: <1554894380-25153-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0195.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::25) To VI1PR04MB4704.eurprd04.prod.outlook.com
 (2603:10a6:803:52::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9175e285-98d6-452e-1f40-08d6bda49870
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR04MB4574; 
x-ms-traffictypediagnostic: VI1PR04MB4574:
x-microsoft-antispam-prvs: <VI1PR04MB4574A830C9E860BEAD33BE26922E0@VI1PR04MB4574.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(39860400002)(376002)(136003)(346002)(189003)(199004)(386003)(6486002)(4744005)(71190400001)(6506007)(97736004)(486006)(256004)(186003)(7416002)(26005)(102836004)(2616005)(36756003)(99286004)(476003)(44832011)(68736007)(110136005)(86362001)(316002)(71200400001)(54906003)(66066001)(53936002)(508600001)(3846002)(106356001)(6116002)(105586002)(2906002)(6436002)(8936002)(50226002)(81166006)(5660300002)(7736002)(305945005)(6512007)(8676002)(4326008)(81156014)(14454004)(52116002)(25786009)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4574;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: suxaTH6q9Q6c00myw9V49hQALW5kq020KEf7ix849jJXEAW9a/JKQltw4saRW1gdeR9nkzqJDvt5B9e+bZ/HBHf5RKqxu6tL7iV4hraUizx4orv86JwV1G9jM8hITfZj0v77zarz2LXrPVs6k/IOIiq+jdxtV3bo6u+L5kQJiTBOHAtZxBMjL4xb7n64Fts8QpPbpaf3UONASrRvqpJILfPKBNrAW3FksFBmSVLT6dcLcUPJ4mBlbDRiiDMTTDk/KSYXGoblBgPEqMYFxx/JLME49SzineTt0i+z/XOpKbJO1859m5EZS4O4oFwYqP+5YG7QLA1AqKa7LuMyyWLKQ+5UgfnHbOHPZwW6XaANR/3gVn4OkozorJ7Y+TDyFd5FhsD7L5kiXei61rKSzkQPJeuTPMzRnoKoTO8kmtUQPoI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9175e285-98d6-452e-1f40-08d6bda49870
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 11:06:35.2187 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4574
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Viorel Suman <viorel.suman@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Viorel Suman <viorel.suman@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

VGhlIGxhdGVzdCBhdWRtaXggcGF0Y2gtc2V0ICh2NSkgaGFkIHRoZSAibW9kZWwiIGF0dHJpYnV0
ZSByZW1vdmVkIGFzDQpyZXF1ZXN0ZWQgYnkgTmljb2xpbiBDaGVuLCBidXQgbG9va3MgbGlrZSAo
djQpIHZlcnNpb24gb2YgREFJIGRyaXZlcg0KcmVhY2hlZCAiZm9yLW5leHQiIGJyYW5jaCAtIGZp
eCB0aGlzIGJ5IHJlbW92aW5nICJtb2RlbCIgYXR0cmlidXRlLg0KQXNzaWRlIG9mIHRoaXMgZml4
IG9iamVjdCByZWZlcmVuY2UgbGVha3MgaW4gbWFjaGluZSBwcm9iZSByZXBvcnRlZCBieQ0KSnVs
aWEgTGF3YWxsLg0KDQpWaW9yZWwgU3VtYW4gKDQpOg0KICBBU29DOiBmc2xfYXVkbWl4OiByZW1v
dmUgIm1vZGVsIiBhdHRyaWJ1dGUNCiAgQVNvQzogZnNsX2F1ZG1peDogcmVtb3ZlICJtb2RlbCIg
YXR0cmlidXRlIGZyb20gRFQgZG9jdW1lbnQNCiAgQVNvQzogaW14LWF1ZG1peDogZml4IG9iamVj
dCByZWZlcmVuY2UgbGVha3MgaW4gcHJvYmUNCiAgQVNvQzogZnNsX2F1ZG1peDogY2FjaGUgcGRl
di0+ZGV2IHBvaW50ZXINCg0KQ2hhbmdlcyBzaW5jZSBWMToNCiAgYSkgUmVtb3ZlZCAibW9kZWwi
IGF0dHJpYnV0ZSBmcm9tIGR0LWJpbmRpbmdzIGRvY3VtZW50YXRpb24NCiAgYikgQWRyZXNzZWQg
RGFuaWVsJ3MgY29tbWVudHMNCg0KQ2hhbmdlcyBzaW5jZSBWMjoNCiAgYSkgQ2FjaGUgcGRldi0+
ZGV2IHBvaW50ZXIgaW4gZnNsX2F1ZG1peCBwcm9iZSBhcyBzdWdnZXN0ZWQgYnkgTmljb2xpbg0K
DQpDaGFuZ2VzIHNpbmNlIFYzOg0KICBhKSBVc2Ugc3ViamVjdCBsaW5lcyBtYXRjaGluZyB0aGUg
c3R5bGUgZm9yIHRoZSBzdWJzeXN0ZW0uDQoNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3Vu
ZC9mc2wsYXVkbWl4LnR4dCAgICAgICB8ICA0IC0tDQogc291bmQvc29jL2ZzbC9mc2xfYXVkbWl4
LmMgICAgICAgICAgICAgICAgICAgICAgICAgfCA2MCArKysrKysrKysrKy0tLS0tLS0tLS0tDQog
c291bmQvc29jL2ZzbC9pbXgtYXVkbWl4LmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNCAr
Kw0KIDMgZmlsZXMgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgMzMgZGVsZXRpb25zKC0pDQoN
Ci0tIA0KMi43LjQNCg0K

Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318DAC282CE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 11:13:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A16DB20850
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 11:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="t8PTsUFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16DB20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fM3K0ccXzDqGc
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 21:13:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe0c::624;
 helo=eur04-db3-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="t8PTsUFI"; 
 dkim-atps=neutral
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fLvX4bZgzDqNb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 21:06:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zOxnLb7coYmHvJlVjsPNoRqqLujhbxECBBxoz38kCc=;
 b=t8PTsUFILCH6iFGDltbd4RGBDP8zEo/N/Tu4riGAdd3CW4OCbkYOP7KExJe1OI68Vgjw/Y0YIOxV9ODuYyrv/B/BSDC/DJMeqFk/Bk2kHxNRUFduim7rhcd/AgCXtTZfh0+YlFAGanC7ZIP2frUjnv9HZQGAunkSFx0gfodY4TM=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB4574.eurprd04.prod.outlook.com (20.177.55.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Wed, 10 Apr 2019 11:06:37 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888%3]) with mapi id 15.20.1792.009; Wed, 10 Apr 2019
 11:06:37 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Takashi Iwai <tiwai@suse.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Julia Lawall
 <Julia.Lawall@lip6.fr>
Subject: [PATCH v4 2/4] ASoC: fsl_audmix: remove "model" attribute from DT
 document
Thread-Topic: [PATCH v4 2/4] ASoC: fsl_audmix: remove "model" attribute from
 DT document
Thread-Index: AQHU7413eRhwBaARkkWbCMXxs9Abbg==
Date: Wed, 10 Apr 2019 11:06:37 +0000
Message-ID: <1554894380-25153-3-git-send-email-viorel.suman@nxp.com>
References: <1554894380-25153-1-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1554894380-25153-1-git-send-email-viorel.suman@nxp.com>
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
x-ms-office365-filtering-correlation-id: f79ea07a-f6aa-46bb-7577-08d6bda499c0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR04MB4574; 
x-ms-traffictypediagnostic: VI1PR04MB4574:
x-microsoft-antispam-prvs: <VI1PR04MB45741DA38EA8C165FED0D38A922E0@VI1PR04MB4574.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(39860400002)(376002)(136003)(346002)(189003)(199004)(386003)(6486002)(71190400001)(6506007)(97736004)(486006)(256004)(186003)(7416002)(26005)(102836004)(2616005)(446003)(36756003)(99286004)(476003)(44832011)(68736007)(110136005)(86362001)(316002)(71200400001)(11346002)(54906003)(66066001)(53936002)(508600001)(3846002)(106356001)(6116002)(105586002)(2906002)(6436002)(8936002)(50226002)(81166006)(5660300002)(7736002)(305945005)(6512007)(8676002)(4326008)(81156014)(14454004)(76176011)(52116002)(25786009)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4574;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EYXj5uos6PAtmeXIFBazsbTNtmbjYskTqVEnwMWVkfIivDErfhy/Yj/ZtImua5aglpXm0FSxxR5UC5iPUF81qlH3ZD1dd9rUvOGKkAPwkbWU8lgiPlTBlEPLfDaVppmudroxprdHfugg9pJrGy1weJnhgDAcmj5pKfD0SW7aEm9E2ZafLkWTiO29+oHGH6LKc+H0JeEMwZxZK5jtzd/uFiirbhu+v/6k1zKAGm70O1NGbUbgItIicUYgV+8iUyNMgtx/cnfsrHLcs1Pl47Xhixhyl58wBnR1Gm+YSIaK/KPjPtRgG5mEArq03AzRwDawFGfS1LoP+EzqOaBcebUKTfHgTIGAgU1LWI7N6WU/grKdjLzGDG8+0tflafj4kaacf+rm29ugHpAZSYEitY85yeTWvEDIpUCrta9iBToE2SE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f79ea07a-f6aa-46bb-7577-08d6bda499c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 11:06:37.4239 (UTC)
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

UmVtb3ZlICJtb2RlbCIgYXR0cmlidXRlIGZyb20gZnNsX2F1ZG1peCBEVCBkb2N1bWVudC4NCg0K
U2lnbmVkLW9mZi1ieTogVmlvcmVsIFN1bWFuIDx2aW9yZWwuc3VtYW5AbnhwLmNvbT4NCkFja2Vk
LWJ5OiBOaWNvbGluIENoZW4gPG5pY29sZW90c3VrYUBnbWFpbC5jb20+DQotLS0NCiBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvZnNsLGF1ZG1peC50eHQgfCA0IC0tLS0N
CiAxIGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9mc2wsYXVkbWl4LnR4dCBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9mc2wsYXVkbWl4LnR4dA0KaW5kZXggNDVm
ODA3ZS4uODQwYjdlMCAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9zb3VuZC9mc2wsYXVkbWl4LnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3NvdW5kL2ZzbCxhdWRtaXgudHh0DQpAQCAtMzgsOSArMzgsNiBAQCBEZXZpY2Ug
ZHJpdmVyIHJlcXVpcmVkIHByb3BlcnRpZXM6DQogCQkJICB0byBTQUkgaW50ZXJmYWNlcyB0byBi
ZSBwcm92aWRlZCwgdGhlIGZpcnN0IFNBSSBpbiB0aGUNCiAJCQkgIGxpc3QgYmVpbmcgdXNlZCB0
byByb3V0ZSB0aGUgQVVETUlYIG91dHB1dC4NCiANCi0gIC0gbW9kZWwJCTogTXVzdCBjb250YWlu
IG1hY2hpbmUgZHJpdmVyIG5hbWUgd2hpY2ggd2lsbCBjb25maWd1cmUNCi0JCQkgIGFuZCBpbnN0
YW50aWF0ZSB0aGUgYXBwcm9wcmlhdGUgYXVkaW8gY2FyZC4NCi0NCiBEZXZpY2UgZHJpdmVyIGNv
bmZpZ3VyYXRpb24gZXhhbXBsZToNCiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQ0KICAgYXVkbWl4OiBhdWRtaXhANTk4NDAwMDAgew0KQEAgLTUwLDUgKzQ3LDQgQEAgRGV2
aWNlIGRyaXZlciBjb25maWd1cmF0aW9uIGV4YW1wbGU6DQogICAgIGNsb2NrLW5hbWVzID0gImlw
ZyI7DQogICAgIHBvd2VyLWRvbWFpbnMgPSA8JnBkX2F1ZG1peD47DQogICAgIGRhaXMgPSA8JnNh
aTQ+LCA8JnNhaTU+Ow0KLSAgICBtb2RlbCA9ICJpbXgtYXVkbWl4IjsNCiAgIH07DQotLSANCjIu
Ny40DQoNCg==

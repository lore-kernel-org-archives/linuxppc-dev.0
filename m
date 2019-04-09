Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EF6C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 11:31:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B7A20857
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 11:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XTiH67AP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B7A20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dlVM11RzzDqLD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 21:31:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.49; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="XTiH67AP"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00049.outbound.protection.outlook.com [40.107.0.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dlQF1lsqzDqJj
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 21:27:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKHYWzD+YWUXtLfdQvkryqgwTZ0PgPWa0f+13fPJW5I=;
 b=XTiH67APd8zJsPLxVXsoE3rCvRPOVl0ZF534uFrlCP06q1XHD93WLuWgbI/Z/yEuiTHMVDfuqhhsbQJoNkvzVoPNa0xefLbf3ZrzVhzjm1GH+u8hW2Rd+6LWdoBzPR0gRvArUFUdCoBIGpOQLc0YMi7dnC8J17/CU/vUzCbHnL4=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB3086.eurprd04.prod.outlook.com (10.170.228.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Tue, 9 Apr 2019 11:27:38 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888%3]) with mapi id 15.20.1792.009; Tue, 9 Apr 2019
 11:27:38 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Takashi Iwai <tiwai@suse.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Julia Lawall
 <Julia.Lawall@lip6.fr>
Subject: [PATCH v2 0/3] ASoC: fsl: audmix: remove "model" attribute and fix
 ref leaks
Thread-Topic: [PATCH v2 0/3] ASoC: fsl: audmix: remove "model" attribute and
 fix ref leaks
Thread-Index: AQHU7sc8h0omtYu4aEyCmk0WvWJxAg==
Date: Tue, 9 Apr 2019 11:27:38 +0000
Message-ID: <1554809242-27475-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0187.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::17) To VI1PR04MB4704.eurprd04.prod.outlook.com
 (2603:10a6:803:52::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42c632c8-64d7-4b27-7595-08d6bcde5f0a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:VI1PR04MB3086; 
x-ms-traffictypediagnostic: VI1PR04MB3086:
x-microsoft-antispam-prvs: <VI1PR04MB308685E8FA3FF56549D27129922D0@VI1PR04MB3086.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(39860400002)(366004)(396003)(376002)(189003)(199004)(106356001)(71200400001)(71190400001)(256004)(68736007)(5660300002)(8676002)(81156014)(81166006)(105586002)(478600001)(97736004)(66066001)(36756003)(102836004)(6506007)(7416002)(486006)(476003)(2616005)(4326008)(8936002)(386003)(6512007)(26005)(186003)(14454004)(50226002)(25786009)(6436002)(53936002)(2906002)(54906003)(3846002)(6116002)(99286004)(44832011)(52116002)(305945005)(316002)(110136005)(4744005)(86362001)(6486002)(7736002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB3086;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 13uS4xd4e4PgpCH/lGYxoqeyFm14YsSUv6nXnnhC3vJPaCC1v5sIyINniatv1MIVH6l+hHyX5ewUGIIftEiDT16sRXoduT3wvrLEhcwcT5NMib5O8Azt4mmQsCL6nOOGd7UV1oRxC721JsvbLh3U5ONyrJ+so0m6HL/ZnepjdDkdCMxguaRw8bcTOHJm0AuNyCTcz42r5DkfFCzNjQOUpdI/NodsB9aCLO0xX8EMkf63hRQRsVLm+WFR84vHLq+6lcAco6nLj9oc1JEWXJXRo6MEyfoZWWTs+4jzr4ghRDmBRfkbWMCf0PBEPaaK28/TJo5Vf/bRML/8uwAggAuG6nf0dFQVZnUMx11dp94uVUcLH6Xjf9da0IyK90PbilkJY3zQhoYK6fURQ/6fUgMLU84yrWxan9qFQiEN0ArLx8A=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c632c8-64d7-4b27-7595-08d6bcde5f0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 11:27:38.6619 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3086
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
aWEgTGF3YWxsLg0KDQpWaW9yZWwgU3VtYW4gKDMpOg0KICBBU29DOiBmc2xfYXVkbWl4OiByZW1v
dmUgIm1vZGVsIiBhdHRyaWJ1dGUNCiAgZHQtYmluZGluZ3M6IGZzbCxhdWRtaXg6IHJlbW92ZSAi
bW9kZWwiIGF0dHJpYnV0ZQ0KICBBU29DOiBpbXgtYXVkbWl4OiBmaXggb2JqZWN0IHJlZmVyZW5j
ZSBsZWFrcyBpbiBwcm9iZQ0KDQpDaGFuZ2VzIHNpbmNlIFYxOg0KICBhKSBSZW1vdmVkICJtb2Rl
bCIgYXR0cmlidXRlIGZyb20gZHQtYmluZGluZ3MgZG9jdW1lbnRhdGlvbg0KICBiKSBBZHJlc3Nl
ZCBEYW5pZWwncyBjb21tZW50cw0KDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvZnNs
LGF1ZG1peC50eHQgICAgICAgfCAgNCAtLQ0KIHNvdW5kL3NvYy9mc2wvZnNsX2F1ZG1peC5jICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgNDMgKysrKysrKysrKysrLS0tLS0tLS0tLQ0KIHNvdW5k
L3NvYy9mc2wvaW14LWF1ZG1peC5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDQgKysNCiAz
IGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KDQotLSAN
CjIuNy40DQoNCg==

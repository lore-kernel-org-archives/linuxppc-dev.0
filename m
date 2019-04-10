Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100C8C10F14
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 10:43:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80FBC20830
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 10:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tu2g59tW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FBC20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fLN22Gt5zDqN8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 20:42:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.15.50; helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="Tu2g59tW"; 
 dkim-atps=neutral
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150050.outbound.protection.outlook.com [40.107.15.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fLFt3RXpzDqNt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 20:37:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Wg5LBWzzo0TW0565rTD/oN6fNM+fREk0ZCk4YWh9gU=;
 b=Tu2g59tWWd/PBDH2C7KyZhLnsz1Mk6JM3Azmr+jzYnxBTYlaKeAcnOX4fVcsu8c1byT7gz9LNyipyJr17BGXsb7gJQYJwl7cL/i1IOrpU+GUGLEo4VgsgQNdbtvqOlEW/k3IyRiGYkgGpbDzxCCBFgcsMs1gCETSqEWUAMS9nho=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB5311.eurprd04.prod.outlook.com (20.177.52.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Wed, 10 Apr 2019 10:37:30 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888%3]) with mapi id 15.20.1792.009; Wed, 10 Apr 2019
 10:37:30 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Takashi Iwai <tiwai@suse.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Julia Lawall
 <Julia.Lawall@lip6.fr>
Subject: [PATCH v3 2/4] dt-bindings: fsl,audmix: remove "model" attribute
Thread-Topic: [PATCH v3 2/4] dt-bindings: fsl, audmix: remove "model" attribute
Thread-Index: AQHU74lmyyBkUG6e/0616TsvWRCKcA==
Date: Wed, 10 Apr 2019 10:37:30 +0000
Message-ID: <1554892629-17646-3-git-send-email-viorel.suman@nxp.com>
References: <1554892629-17646-1-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1554892629-17646-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0085.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::11) To VI1PR04MB4704.eurprd04.prod.outlook.com
 (2603:10a6:803:52::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2ab7517-f2ed-4ec2-bd7e-08d6bda08860
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR04MB5311; 
x-ms-traffictypediagnostic: VI1PR04MB5311:
x-microsoft-antispam-prvs: <VI1PR04MB5311EA732E15FF1DA8C4169F922E0@VI1PR04MB5311.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(346002)(136003)(376002)(366004)(396003)(199004)(189003)(305945005)(386003)(256004)(186003)(7736002)(6512007)(25786009)(14454004)(52116002)(71200400001)(26005)(99286004)(110136005)(53936002)(102836004)(4744005)(54906003)(36756003)(76176011)(4326008)(316002)(97736004)(486006)(11346002)(50226002)(446003)(68736007)(44832011)(6436002)(476003)(6506007)(106356001)(3846002)(2906002)(508600001)(6116002)(5660300002)(6486002)(8936002)(66066001)(71190400001)(7416002)(86362001)(8676002)(81156014)(81166006)(2616005)(105586002)(921003)(142933001)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5311;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JfR3ryCHeWHcD0jUHkSFzKWf3x0lC43EulpPD3ThPuSYMK3wcQXbus21//QAZdhk81zYMbjh/mJ9UHrECh+Wsxw9pq1PVdlo0ftjc2Ue0ymB2cIbB8C7DkvHM6wwmNdgk/7PRgh2TMIGV2zMX5g5PWi3ANMdh57C28gctg6kE8HBa7fPNgB0QMLeYeBmXdy/NZqS9YtR6j9X6/d/DHKPeHQgBkWIq82Gw4ItuRyMhV1fDQL4pVhztdNSTl6txClHxK+zotUvs54MbLodlB4IYTuvA6Zp7exnWpm2ehAlW9vg5AAEukJ3l+fVjzJltOborxhnR++G7cwVeoq9LlUOf/om26Imzsccw+LrlEIngk27bX6LxG5AYcAlTHGax9aNgXoy9Bz9NmA/d9/ZRii8r54B4Ra86/2Cy1lsnbYpUnA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ab7517-f2ed-4ec2-bd7e-08d6bda08860
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 10:37:30.3734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5311
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

UmVtb3ZlICJtb2RlbCIgYXR0cmlidXRlLg0KDQpTaWduZWQtb2ZmLWJ5OiBWaW9yZWwgU3VtYW4g
PHZpb3JlbC5zdW1hbkBueHAuY29tPg0KQWNrZWQtYnk6IE5pY29saW4gQ2hlbiA8bmljb2xlb3Rz
dWthQGdtYWlsLmNvbT4NCi0tLQ0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
b3VuZC9mc2wsYXVkbWl4LnR4dCB8IDQgLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nv
dW5kL2ZzbCxhdWRtaXgudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nv
dW5kL2ZzbCxhdWRtaXgudHh0DQppbmRleCA0NWY4MDdlLi44NDBiN2UwIDEwMDY0NA0KLS0tIGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL2ZzbCxhdWRtaXgudHh0DQor
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvZnNsLGF1ZG1peC50
eHQNCkBAIC0zOCw5ICszOCw2IEBAIERldmljZSBkcml2ZXIgcmVxdWlyZWQgcHJvcGVydGllczoN
CiAJCQkgIHRvIFNBSSBpbnRlcmZhY2VzIHRvIGJlIHByb3ZpZGVkLCB0aGUgZmlyc3QgU0FJIGlu
IHRoZQ0KIAkJCSAgbGlzdCBiZWluZyB1c2VkIHRvIHJvdXRlIHRoZSBBVURNSVggb3V0cHV0Lg0K
IA0KLSAgLSBtb2RlbAkJOiBNdXN0IGNvbnRhaW4gbWFjaGluZSBkcml2ZXIgbmFtZSB3aGljaCB3
aWxsIGNvbmZpZ3VyZQ0KLQkJCSAgYW5kIGluc3RhbnRpYXRlIHRoZSBhcHByb3ByaWF0ZSBhdWRp
byBjYXJkLg0KLQ0KIERldmljZSBkcml2ZXIgY29uZmlndXJhdGlvbiBleGFtcGxlOg0KID09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQogICBhdWRtaXg6IGF1ZG1peEA1OTg0
MDAwMCB7DQpAQCAtNTAsNSArNDcsNCBAQCBEZXZpY2UgZHJpdmVyIGNvbmZpZ3VyYXRpb24gZXhh
bXBsZToNCiAgICAgY2xvY2stbmFtZXMgPSAiaXBnIjsNCiAgICAgcG93ZXItZG9tYWlucyA9IDwm
cGRfYXVkbWl4PjsNCiAgICAgZGFpcyA9IDwmc2FpND4sIDwmc2FpNT47DQotICAgIG1vZGVsID0g
ImlteC1hdWRtaXgiOw0KICAgfTsNCi0tIA0KMi43LjQNCg0K

Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B035C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 11:34:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F403C20857
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 11:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QjQ67Dno"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F403C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dlYw2L2GzDqLs
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 21:34:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.49; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="QjQ67Dno"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00049.outbound.protection.outlook.com [40.107.0.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dlQL0wpXzDqJk
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 21:27:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6NrgQhMOQwwBdEIxmvg14af3hG4jnoZ5T+SkoB+wJU=;
 b=QjQ67DnorCPSJWbXEtwoigWTK9kuD6looLJVxLKrUV1g9b4xr0PF1LqzY85AekMYcThox3O/kttfxuDgqjQ7KWXlSPH+FY3PZiEOZZLExgdbKbL7can01PoSeato1mZl5kWfqSrz589gQZJiCiL6JtCBFRnwkkJQGBbrpj4loxc=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB3086.eurprd04.prod.outlook.com (10.170.228.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Tue, 9 Apr 2019 11:27:41 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888%3]) with mapi id 15.20.1792.009; Tue, 9 Apr 2019
 11:27:40 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Takashi Iwai <tiwai@suse.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Julia Lawall
 <Julia.Lawall@lip6.fr>
Subject: [PATCH v2 2/3] dt-bindings: fsl,audmix: remove "model" attribute
Thread-Topic: [PATCH v2 2/3] dt-bindings: fsl, audmix: remove "model" attribute
Thread-Index: AQHU7sc+tBzccqTIbEGI7+Z1sKouvQ==
Date: Tue, 9 Apr 2019 11:27:40 +0000
Message-ID: <1554809242-27475-3-git-send-email-viorel.suman@nxp.com>
References: <1554809242-27475-1-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1554809242-27475-1-git-send-email-viorel.suman@nxp.com>
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
x-ms-office365-filtering-correlation-id: c86c69e9-90f9-4da6-9e10-08d6bcde606f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:VI1PR04MB3086; 
x-ms-traffictypediagnostic: VI1PR04MB3086:
x-microsoft-antispam-prvs: <VI1PR04MB30866BA84614C77C0EEE5851922D0@VI1PR04MB3086.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(39860400002)(366004)(396003)(376002)(189003)(199004)(106356001)(71200400001)(71190400001)(256004)(68736007)(5660300002)(8676002)(81156014)(81166006)(105586002)(478600001)(97736004)(66066001)(36756003)(102836004)(6506007)(7416002)(486006)(476003)(2616005)(11346002)(446003)(4326008)(8936002)(386003)(6512007)(26005)(186003)(14454004)(50226002)(25786009)(6436002)(53936002)(76176011)(2906002)(54906003)(3846002)(6116002)(99286004)(44832011)(52116002)(305945005)(316002)(110136005)(4744005)(86362001)(6486002)(7736002)(921003)(142933001)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB3086;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Nafi6YjdUjjf5he3lyG7UWSij61zj9CkDA8daQK8yNbl7uaMhI7fti3WZCKV224s3786ZXWkzuHMrkD27I3mKpwfc+nWcNqDXT+Fq5gpfVHoBZ1GrwBX9EjYudccJiu7UW2h9ID/vq90vis6NU/9jHNr5fT9fTx5D5gMbwz9rELYh/dorQ/TbSKExHHgjyZlCQpYskAYpm6nPEV/OAAGb+zraR5cK555FKa8VsBxFnWxSFduAY2x5lcWOT9i0opR/huzqznmll7sviBGiYlIOb4/pPSHvoniBM7b5119WEDrPy3UTmEHxImqknap5RuXtfgSNoGt2VTjxzoMGx+e4Uy9RiBh7D+r24IvftWW+rmhFAzuEspbqjD/1XmTEQNfF5kRXcXS/L6FSh9UO7/3HjCVpy/nWMU5DTb9QYMmP14=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c86c69e9-90f9-4da6-9e10-08d6bcde606f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 11:27:40.8654 (UTC)
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

UmVtb3ZlICJtb2RlbCIgYXR0cmlidXRlLg0KDQpTaWduZWQtb2ZmLWJ5OiBWaW9yZWwgU3VtYW4g
PHZpb3JlbC5zdW1hbkBueHAuY29tPg0KLS0tDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NvdW5kL2ZzbCxhdWRtaXgudHh0IHwgNCAtLS0tDQogMSBmaWxlIGNoYW5nZWQsIDQg
ZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc291bmQvZnNsLGF1ZG1peC50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc291bmQvZnNsLGF1ZG1peC50eHQNCmluZGV4IDQ1ZjgwN2UuLjg0MGI3ZTAgMTAwNjQ0
DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvZnNsLGF1ZG1p
eC50eHQNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9mc2ws
YXVkbWl4LnR4dA0KQEAgLTM4LDkgKzM4LDYgQEAgRGV2aWNlIGRyaXZlciByZXF1aXJlZCBwcm9w
ZXJ0aWVzOg0KIAkJCSAgdG8gU0FJIGludGVyZmFjZXMgdG8gYmUgcHJvdmlkZWQsIHRoZSBmaXJz
dCBTQUkgaW4gdGhlDQogCQkJICBsaXN0IGJlaW5nIHVzZWQgdG8gcm91dGUgdGhlIEFVRE1JWCBv
dXRwdXQuDQogDQotICAtIG1vZGVsCQk6IE11c3QgY29udGFpbiBtYWNoaW5lIGRyaXZlciBuYW1l
IHdoaWNoIHdpbGwgY29uZmlndXJlDQotCQkJICBhbmQgaW5zdGFudGlhdGUgdGhlIGFwcHJvcHJp
YXRlIGF1ZGlvIGNhcmQuDQotDQogRGV2aWNlIGRyaXZlciBjb25maWd1cmF0aW9uIGV4YW1wbGU6
DQogPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCiAgIGF1ZG1peDogYXVk
bWl4QDU5ODQwMDAwIHsNCkBAIC01MCw1ICs0Nyw0IEBAIERldmljZSBkcml2ZXIgY29uZmlndXJh
dGlvbiBleGFtcGxlOg0KICAgICBjbG9jay1uYW1lcyA9ICJpcGciOw0KICAgICBwb3dlci1kb21h
aW5zID0gPCZwZF9hdWRtaXg+Ow0KICAgICBkYWlzID0gPCZzYWk0PiwgPCZzYWk1PjsNCi0gICAg
bW9kZWwgPSAiaW14LWF1ZG1peCI7DQogICB9Ow0KLS0gDQoyLjcuNA0KDQo=

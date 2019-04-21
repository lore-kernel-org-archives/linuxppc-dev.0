Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE43C10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 19:42:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F4C720870
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 19:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="x1pMzD0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4C720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nKqZ35XrzDqVw
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 05:42:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.69; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=daniel.baluta@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="x1pMzD0B"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00069.outbound.protection.outlook.com [40.107.0.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nKls5lCrzDqTX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 05:39:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLmbyESTg8PMBPjLLFwRHhXAibJkXcywhwjpIIjQNtY=;
 b=x1pMzD0BZIt2bQOqEFKLTVrrd35VKwPy1ZnA5ANZG2KOKQL7va95OpHvV1Vorc2udK8CAyD5hieaVkrMfrNfDQFl2lHg4dG4mt7CWxql7yn1xH3kc602TkPMwiH/PuxkGEshHrrR3nAGhvptyIx5HRvaaXsU9L+hA9VYGPRUNBQ=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3470.eurprd04.prod.outlook.com (52.134.3.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Sun, 21 Apr 2019 19:39:08 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6%6]) with mapi id 15.20.1813.017; Sun, 21 Apr 2019
 19:39:08 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Subject: [PATCH 1/3 v2] ASoC: fsl_sai: Update is_slave_mode with correct value
Thread-Topic: [PATCH 1/3 v2] ASoC: fsl_sai: Update is_slave_mode with correct
 value
Thread-Index: AQHU+Hnj+IRH2WrQSkCHDXUN0RhrwA==
Date: Sun, 21 Apr 2019 19:39:08 +0000
Message-ID: <20190421193853.10188-2-daniel.baluta@nxp.com>
References: <20190421193853.10188-1-daniel.baluta@nxp.com>
In-Reply-To: <20190421193853.10188-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P18901CA0001.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::11) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf0f91a6-1418-4305-c4ad-08d6c6910558
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR0402MB3470; 
x-ms-traffictypediagnostic: VI1PR0402MB3470:
x-microsoft-antispam-prvs: <VI1PR0402MB3470C66EB46708AB1FE140F0F9210@VI1PR0402MB3470.eurprd04.prod.outlook.com>
x-forefront-prvs: 0014E2CF50
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(39860400002)(366004)(376002)(396003)(346002)(189003)(199004)(3846002)(6116002)(86362001)(71190400001)(71200400001)(44832011)(66476007)(64756008)(66556008)(66446008)(76176011)(66946007)(73956011)(6512007)(2906002)(6916009)(6486002)(50226002)(486006)(8936002)(476003)(2616005)(54906003)(11346002)(8676002)(305945005)(81156014)(6436002)(53936002)(1076003)(52116002)(1730700003)(7416002)(81166006)(7736002)(256004)(5640700003)(186003)(102836004)(446003)(478600001)(14454004)(316002)(68736007)(4326008)(26005)(66066001)(2501003)(6506007)(25786009)(386003)(2351001)(99286004)(97736004)(36756003)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3470;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BILEMROvZwfM31pB8q+L0BYQBzt50/sDr8HLaxgTaynst44KOVmga42WQkpCt1j/ZteDp7TOrsbF+1/7OP+E1y06OedtXOnjXQs/SU3GqPnFSDNoBM6KdSihFA+gr8RaS5AIL0pucbtZzTIa+3RFADIcZxG15I3cyblDtCukJD3g+mYA1y5onvZrNdBQdfI+9142S41BHnArU8Jqcf+o/68CsdO9NzhLn+uiGg8cy9rEnghJpmw7rXj7FhObOEOpW3qNyn9lg3ruHRvpoRtqykxjf3NZkLTttjz0pTLZx+IbA3tplbKsna2Rup92DcExOx1wSpNZCmMjWoP8jHIwr8H86A68LpRzambV9ohWCRxzq4ZZxGblXfpwDIz65hgh0Y1Q0kNM//JKMbo8NdeCxPwSa6U5ZzomJ4MgiB/4pTg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0f91a6-1418-4305-c4ad-08d6c6910558
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2019 19:39:08.4707 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3470
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
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "S.j. Wang" <shengjiu.wang@nxp.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 dl-linux-imx <linux-imx@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

aXNfc2xhdmVfbW9kZSBkZWZhdWx0cyB0byBmYWxzZSBiZWNhdXNlIHNhaSBzdHJ1Y3R1cmUNCnRo
YXQgY29udGFpbnMgaXQgaXMga3phbGxvYydlZC4NCg0KQW55aG93LCBpZiB3ZSBkZWNpZGUgdG8g
c2V0IHRoZSBmb2xsb3dpbmcgY29uZmlndXJhdGlvbg0KU0FJIHNsYXZlIC0+IFNBSSBtYXN0ZXIs
IGlzX3NsYXZlX21vZGUgd2lsbCByZW1haW4gc2V0IG9uIHRydWUNCmFsdGhvdWdoIFNBSSBiZWlu
ZyBtYXN0ZXIgaXQgc2hvdWxkIGJlIHNldCB0byBmYWxzZS4NCg0KRml4IHRoaXMgYnkgdXBkYXRp
bmcgaXNfc2xhdmVfbW9kZSBmb3IgZWFjaCBjYWxsIG9mDQpmc2xfc2FpX3NldF9kYWlfZm10Lg0K
DQpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFsdXRhQG54cC5jb20+DQot
LS0NCiBzb3VuZC9zb2MvZnNsL2ZzbF9zYWkuYyB8IDIgKysNCiAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvZnNsL2ZzbF9zYWkuYyBiL3Nv
dW5kL3NvYy9mc2wvZnNsX3NhaS5jDQppbmRleCBiNTYzMDA0ZmI4OWYuLmQ5ZGY5ODk3NWNmOCAx
MDA2NDQNCi0tLSBhL3NvdW5kL3NvYy9mc2wvZnNsX3NhaS5jDQorKysgYi9zb3VuZC9zb2MvZnNs
L2ZzbF9zYWkuYw0KQEAgLTI2OCwxMiArMjY4LDE0IEBAIHN0YXRpYyBpbnQgZnNsX3NhaV9zZXRf
ZGFpX2ZtdF90cihzdHJ1Y3Qgc25kX3NvY19kYWkgKmNwdV9kYWksDQogCWNhc2UgU05EX1NPQ19E
QUlGTVRfQ0JTX0NGUzoNCiAJCXZhbF9jcjIgfD0gRlNMX1NBSV9DUjJfQkNEX01TVFI7DQogCQl2
YWxfY3I0IHw9IEZTTF9TQUlfQ1I0X0ZTRF9NU1RSOw0KKwkJc2FpLT5pc19zbGF2ZV9tb2RlID0g
ZmFsc2U7DQogCQlicmVhazsNCiAJY2FzZSBTTkRfU09DX0RBSUZNVF9DQk1fQ0ZNOg0KIAkJc2Fp
LT5pc19zbGF2ZV9tb2RlID0gdHJ1ZTsNCiAJCWJyZWFrOw0KIAljYXNlIFNORF9TT0NfREFJRk1U
X0NCU19DRk06DQogCQl2YWxfY3IyIHw9IEZTTF9TQUlfQ1IyX0JDRF9NU1RSOw0KKwkJc2FpLT5p
c19zbGF2ZV9tb2RlID0gZmFsc2U7DQogCQlicmVhazsNCiAJY2FzZSBTTkRfU09DX0RBSUZNVF9D
Qk1fQ0ZTOg0KIAkJdmFsX2NyNCB8PSBGU0xfU0FJX0NSNF9GU0RfTVNUUjsNCi0tIA0KMi4xNy4x
DQoNCg==

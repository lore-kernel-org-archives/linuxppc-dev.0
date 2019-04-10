Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9C2C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 02:44:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07F0320857
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 02:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DeRjDUEn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F0320857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44f7lz1ttmzDqMB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 12:44:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe07::603;
 helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="DeRjDUEn"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02on0603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe07::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44f7k75j1gzDqJh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 12:42:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yIDnibElniD7g/VK1kKWK/VCl8tfLFKrfGvCcD6F6E=;
 b=DeRjDUEn/S93nQ5J1FSBec+KfZS8ICbDkYGbooBeeVNsZLU5q6SIHFjLq2VoOR5GcNQZ0DdIsNHaAsJpWSrjbh9vtQsqe2VlCm6n/xcEO1rX3SpoW85avOdpOgGqmOg1Clo1KTHB9lHK3ahDKrci8WQiCa57/uneDXdytW25e4o=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6510.eurprd04.prod.outlook.com (20.179.233.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Wed, 10 Apr 2019 02:42:45 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%6]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 02:42:45 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>, "gustavo@embeddedor.com"
 <gustavo@embeddedor.com>
Subject: [PATCH V2] ASoC: fsl_esai: replace fall-through with break
Thread-Topic: [PATCH V2] ASoC: fsl_esai: replace fall-through with break
Thread-Index: AQHU70cTwow3EQ3buU2LP9490KzdXg==
Date: Wed, 10 Apr 2019 02:42:45 +0000
Message-ID: <46e9b55edb223894392a90c7cdb6241a43cb9cff.1554864022.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK2PR06CA0023.apcprd06.prod.outlook.com
 (2603:1096:202:2e::35) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c2a173e-b59a-4747-c980-08d6bd5e35f8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6510; 
x-ms-traffictypediagnostic: VE1PR04MB6510:
x-microsoft-antispam-prvs: <VE1PR04MB651069554F2F2A109FE6785BE32E0@VE1PR04MB6510.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(39860400002)(136003)(366004)(396003)(346002)(199004)(189003)(4326008)(106356001)(71190400001)(71200400001)(14444005)(256004)(5660300002)(68736007)(118296001)(81156014)(81166006)(8676002)(105586002)(478600001)(36756003)(97736004)(66066001)(102836004)(486006)(50226002)(186003)(476003)(2616005)(6506007)(386003)(26005)(6486002)(8936002)(2501003)(14454004)(25786009)(6436002)(53936002)(2906002)(6512007)(2201001)(3846002)(110136005)(99286004)(52116002)(6116002)(316002)(4744005)(86362001)(305945005)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6510;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3g5WCy/c1D+0HQKT+V/JP1ty9lpE2SdfW84RN91FSX/0Z2R1+z2wySMwwCQOZnONEvV6wFcfu7j3kDwUR+W4lPccWzf9SeGEcmI2FpA477TqF9vYEqRj0T7gpYd7awKy91ocAOnpMI5ybDgdXaRtFYMfwpo0RbTFBtbe80YktP2DuFCXkZum/QMWLRXuxQNHfrh0qARLVcji3DQRft7YKR2v3/IixsD+nzP3aqr71P8RoryCevNr4AWd514nxvFrKhQk+ueVv06IcJ4aZq7U0eG7lstSU341niQ8eN/37L2BjVU7U1/lZpsbK+VwHSeRLEnZAJ3Kt2bIp+8wQzslfL030G0QdFEfxbP2ESuKAgjLL1H7rBt18mpKGnfZftUZQayxBL7bSXgo8U4gNKaRoS+uBA01gurWN1tW5Peas/c=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2a173e-b59a-4747-c980-08d6bd5e35f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 02:42:45.4089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6510
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

Y2FzZSBFU0FJX0hDS1RfRVhUQUwgYW5kIGNhc2UgRVNBSV9IQ0tSX0VYVEFMIHNob3VsZCBiZSBp
bmRlcGVuZGVudCBvZg0KZWFjaCBvdGhlciwgc28gcmVwbGFjZSBmYWxsLXRocm91Z2ggd2l0aCBi
cmVhay4NCg0KRml4ZXM6IDQzZDI0ZTc2YjY5OCAoIkFTb0M6IGZzbF9lc2FpOiBBZGQgRVNBSSBD
UFUgREFJIGRyaXZlciIpDQoNClNpZ25lZC1vZmYtYnk6IFNoZW5naml1IFdhbmcgPHNoZW5naml1
LndhbmdAbnhwLmNvbT4NCi0tLQ0KQ2hhbmdlcyBpbiB2Mg0KLSBmaXggdGhlIGZpeGVzIHRhZy4N
Cg0KIHNvdW5kL3NvYy9mc2wvZnNsX2VzYWkuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9mc2wv
ZnNsX2VzYWkuYyBiL3NvdW5kL3NvYy9mc2wvZnNsX2VzYWkuYw0KaW5kZXggYzc0MTBiYmZkMmFm
Li5iYWQwZGZlZDZiNjggMTAwNjQ0DQotLS0gYS9zb3VuZC9zb2MvZnNsL2ZzbF9lc2FpLmMNCisr
KyBiL3NvdW5kL3NvYy9mc2wvZnNsX2VzYWkuYw0KQEAgLTI1MSw3ICsyNTEsNyBAQCBzdGF0aWMg
aW50IGZzbF9lc2FpX3NldF9kYWlfc3lzY2xrKHN0cnVjdCBzbmRfc29jX2RhaSAqZGFpLCBpbnQg
Y2xrX2lkLA0KIAkJYnJlYWs7DQogCWNhc2UgRVNBSV9IQ0tUX0VYVEFMOg0KIAkJZWNyIHw9IEVT
QUlfRUNSX0VUSTsNCi0JCS8qIGZhbGwgdGhyb3VnaCAqLw0KKwkJYnJlYWs7DQogCWNhc2UgRVNB
SV9IQ0tSX0VYVEFMOg0KIAkJZWNyIHw9IGVzYWlfcHJpdi0+c3luY2hyb25vdXMgPyBFU0FJX0VD
Ul9FVEkgOiBFU0FJX0VDUl9FUkk7DQogCQlicmVhazsNCi0tIA0KMS45LjENCg0K

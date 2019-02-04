Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C015C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 09:15:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B61E206DD
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 09:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VzYAvzzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B61E206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tMWV2ByWzDqHv
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 20:15:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.1.81; helo=eur02-he1-obe.outbound.protection.outlook.com;
 envelope-from=pankaj.bansal@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="VzYAvzzv"; 
 dkim-atps=neutral
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10081.outbound.protection.outlook.com [40.107.1.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tMP15sGSzDqGQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 20:10:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xCn1TuqJK3ooi3+YgZ3ERaV+/AgrR/a1YnHqRGvXZs=;
 b=VzYAvzzvJvs4g7R6dMFD+eHpuypPwIwpOAwvNxTtycJls/c4pjQQBVX2eA4JrJo3kDqmLGmsB5pS0pLHhb0IDnApkj9o6C+OMubWPxFAuMWvgboGLT0Dgu4riR1q80oDmdQKmfwLMgAmyCV0FhaBcnNLMEBG7ReNrzx2wIV8DNM=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2640.eurprd04.prod.outlook.com (10.168.66.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Mon, 4 Feb 2019 09:10:02 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe%8]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 09:10:02 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: Leo Li <leoyang.li@nxp.com>
Subject: [PATCH v3 1/2] dt-bindings: soc: fsl: Document Qixis FPGA usage
Thread-Topic: [PATCH v3 1/2] dt-bindings: soc: fsl: Document Qixis FPGA usage
Thread-Index: AQHUvGlp8uj3aRTwvE2rsi77vi3Hgg==
Date: Mon, 4 Feb 2019 09:10:02 +0000
Message-ID: <20190204143449.25040-2-pankaj.bansal@nxp.com>
References: <20190204143449.25040-1-pankaj.bansal@nxp.com>
In-Reply-To: <20190204143449.25040-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::23) To VI1PR0401MB2496.eurprd04.prod.outlook.com
 (2603:10a6:800:56::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [92.120.1.69]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0401MB2640;
 6:PxTxXbObeFy6uLRI2/mIF2m4jP1oKzmiY2O7h25six5uNCGuI6LfZ6z6HQmko3OloMh1cn9A4+AGp1ZHuyNOEqTQ7p8ai/KGLqBsW9KE6oYTKD2Z5K5XLAf83R8+UZFkx34RnA5r3dsZVubIh3eeIwhLG7OSrcIuCEN8rc/4HZ0EnrRQxdE4se3ttydtxkfP8k+isZ1QGm9M3qDSKshTCaGH6klqizFKW6T8SzjszKp/9wQRaKBA7yv3faXWQm5lmPvJRIyOJfH0PEPkuJBDEw+zemydcWfB2a8pr850fyyQ8rdTb9tbHikelWabARky4aCgEGk68Jn/dDkhe8dTcZS0AnmSYyfV4aTlmSDIWenoXWLqDbHZbp645N/YoK6gOgz/veCoIDAS3jhzpDgCKUjLW2dpJ9roNFOrTCgPswX6xbAzTTGbGXQb2QO4r4dLXn8Y3Pu3Qnb/EKM0ZBcJiA==;
 5:InPSz1n5evyYfaZIVvd5F8ucMjBxkxzqd/zWa2zD/UcftljPh67dIC2vq/ONiUhRBSRqGgmIMJkyzdZEgWk3W4jJhY2LGRFCwix1+we9F7eNbhOoSyNEzLqs4OE2YcHnkKKrODUH0wdu87e354OiZ9u6P8EzhnDDODktLhQWZBEjLJVnK3r2vaLMun5Qdx3LggmP969V7oQDGlYvVf8+Ow==;
 7:bCxK+ImMj72ySGrmdEhM58JFpRPC7l1dGOduzoxsV7qok0V5LGdnHE6ibp98K9gQ+mE40IZJ32n2Kni09U3P0H6SdYb8t0syXYX5M7zKIopxkArOkikPVbiCMvJgSji5Q+Q8Ba+nbtRFujzyPCjq6Q==
x-ms-office365-filtering-correlation-id: 9249f6c5-8052-4a4e-a064-08d68a808b8a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0401MB2640; 
x-ms-traffictypediagnostic: VI1PR0401MB2640:
x-microsoft-antispam-prvs: <VI1PR0401MB264095241AFB7103F8D7C85DF16D0@VI1PR0401MB2640.eurprd04.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(136003)(396003)(366004)(39860400002)(346002)(189003)(199004)(66066001)(37006003)(316002)(6636002)(36756003)(99286004)(2906002)(54906003)(6512007)(53936002)(478600001)(14454004)(76176011)(256004)(52116002)(6486002)(6436002)(7736002)(6506007)(386003)(102836004)(186003)(26005)(68736007)(105586002)(97736004)(106356001)(305945005)(3846002)(6116002)(486006)(8936002)(44832011)(50226002)(11346002)(446003)(81166006)(81156014)(8676002)(476003)(2616005)(86362001)(6862004)(1076003)(25786009)(71200400001)(71190400001)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB2640;
 H:VI1PR0401MB2496.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eFYoPeRKfZbjrm4ExEeemSB04C3bNvs0mbzif7aO7jdKIe3b/U9s+NffLNtrs0r+jFY6NS6LHQOarn6udNgPGSg0eBWVe3Bi0LmVxej+EN2sEWL5zm7IHfwXY8pMbXLZY7QkbGRNlQ/5fu8OagScb5iAukqAbuYaNc3xdfdx3nstrehfPm1dlpawNuaClMB9WDMhJ1nHxZ3OKvrfn5COD9kXOUl9WGagL5pgItLRlyKJNx2JDMYpbL2uyIV3KzyughDe3xBIlmlDUvMuxpp+IpUbfpjm493NGT+8IKkWlpxKysE28zdZmufdguAgVXhowy5f12e97Dm4Mai8cE6KulOTuvPuENBAkQ7aG6hJXKJRzCcXHksIrudAPFTvJUTquzbJDt2oTd6i3qcA21B6fwt4Kci/TFbiMwk5NfI7Vsc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8D246FAB5B3944AA5A950C9C75D3417@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9249f6c5-8052-4a4e-a064-08d68a808b8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 09:10:01.1600 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2640
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
Cc: Pankaj Bansal <pankaj.bansal@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

YW4gRlBHQS1iYXNlZCBzeXN0ZW0gY29udHJvbGxlciwgY2FsbGVkIOKAnFFpeGlz4oCdLCB3aGlj
aA0KbWFuYWdlcyBzZXZlcmFsIGNyaXRpY2FsIHN5c3RlbSBmZWF0dXJlcywgaW5jbHVkaW5nOg0K
4oCiIFJlc2V0IHNlcXVlbmNpbmcNCuKAoiBQb3dlciBzdXBwbHkgY29uZmlndXJhdGlvbg0K4oCi
IEJvYXJkIGNvbmZpZ3VyYXRpb24NCuKAoiBoYXJkd2FyZSBjb25maWd1cmF0aW9uDQoNClRoZSBx
aXhpcyByZWdpc3RlcnMgYXJlIGFjY2Vzc2libGUgb3ZlciBvbmUgb3IgbW9yZSBzeXN0ZW0tc3Bl
Y2lmaWMNCmludGVyZmFjZXMsIHR5cGljYWxseSBJMkMsIEpUQUcgb3IgYW4gZW1iZWRkZWQgcHJv
Y2Vzc29yLg0KDQpTaWduZWQtb2ZmLWJ5OiBQYW5rYWogQmFuc2FsIDxwYW5rYWouYmFuc2FsQG54
cC5jb20+DQotLS0NCg0KTm90ZXM6DQogICAgVjM6DQogICAgLSBBZGRlZCBib2FyZG5hbWUgYmFz
ZWQgY29tcGF0aWJsZSBmaWVsZCBpbiBiaW5kaW5ncw0KICAgIC0gQWRkZWQgYmluZGluZ3MgZm9y
IE1NSU8gYmFzZWQgRlBHQQ0KICAgIFYyOg0KICAgIC0gTm8gY2hhbmdlDQoNCiAuLi4vYmluZGlu
Z3Mvc29jL2ZzbC9xaXhpc19jdHJsLnR4dCAgICAgICAgICB8IDUzICsrKysrKysrKysrKysrKysr
Kw0KIDEgZmlsZSBjaGFuZ2VkLCA1MyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL2ZzbC9xaXhpc19jdHJsLnR4dCBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvZnNsL3FpeGlzX2N0cmwudHh0DQpu
ZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMDAwMDAwLi41ZDUxMGRmMTRiZTgNCi0t
LSAvZGV2L251bGwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2Mv
ZnNsL3FpeGlzX2N0cmwudHh0DQpAQCAtMCwwICsxLDUzIEBADQorKiBRSVhJUyBGUEdBIGJsb2Nr
DQorDQorYW4gRlBHQS1iYXNlZCBzeXN0ZW0gY29udHJvbGxlciwgY2FsbGVkIOKAnFFpeGlz4oCd
LCB3aGljaA0KK21hbmFnZXMgc2V2ZXJhbCBjcml0aWNhbCBzeXN0ZW0gZmVhdHVyZXMsIGluY2x1
ZGluZzoNCivigKIgQ29uZmlndXJhdGlvbiBzd2l0Y2ggbW9uaXRvcmluZw0KK+KAoiBQb3dlciBv
bi9vZmYgc2VxdWVuY2luZw0KK+KAoiBSZXNldCBzZXF1ZW5jaW5nDQor4oCiIFBvd2VyIHN1cHBs
eSBjb25maWd1cmF0aW9uDQor4oCiIEJvYXJkIGNvbmZpZ3VyYXRpb24NCivigKIgaGFyZHdhcmUg
Y29uZmlndXJhdGlvbg0KK+KAoiBCYWNrZ3JvdW5kIHBvd2VyIGRhdGEgY29sbGVjdGlvbiAoRENN
KQ0KK+KAoiBGYXVsdCBtb25pdG9yaW5nDQor4oCiIFJDVyBieXBhc3MgU1JBTSAocmVwbGFjZSBm
bGFzaCBSQ1cgd2l0aCBpbnRlcm5hbCBSQ1cpIChOT1Igb25seSkNCivigKIgRGVkaWNhdGVkIGZ1
bmN0aW9uYWwgdmFsaWRhdGlvbiBibG9ja3MgKFBPU3QvSVJTLCB0cmlnZ2VyZWQgZXZlbnQsIGFu
ZCBzbyBvbikNCivigKIgSTJDIG1hc3RlciBmb3IgcmVtb3RlIGJvYXJkIGNvbnRyb2wgZXZlbiB3
aXRoIG5vIERVVCBhdmFpbGFibGUNCisNCitUaGUgcWl4aXMgcmVnaXN0ZXJzIGFyZSBhY2Nlc3Np
YmxlIG92ZXIgb25lIG9yIG1vcmUgc3lzdGVtLXNwZWNpZmljIGludGVyZmFjZXMsDQordHlwaWNh
bGx5IEkyQywgSlRBRyBvciBhbiBlbWJlZGRlZCBwcm9jZXNzb3IuDQorDQorRlBHQSBjb25uZWN0
ZWQgdG8gSTJDOg0KK1JlcXVpcmVkIHByb3BlcnRpZXM6DQorDQorIC0gY29tcGF0aWJsZTogc2hv
dWxkIGJlIGEgYm9hcmQtc3BlY2lmaWMgc3RyaW5nIGZvbGxvd2VkIGJ5IGEgc3RyaW5nDQorICAg
aW5kaWNhdGluZyB0aGUgdHlwZSBvZiBGUEdBLiAgRXhhbXBsZToNCisJImZzbCw8Ym9hcmQ+LWZw
Z2EiLCAiZnNsLGZwZ2EtcWl4aXMtaTJjIg0KKyAtIHJlZyA6IGkyYyBhZGRyZXNzIG9mIHRoZSBx
aXhpcyBkZXZpY2UuDQorDQorRXhhbXBsZSAoTFgyMTYwQS1RRFMpOg0KKwkvKiBUaGUgRlBHQSBu
b2RlICovDQorICAgICAgICBmcGdhQDY2IHsNCisJCWNvbXBhdGlibGUgPSAiZnNsLGx4MjE2MGFx
ZHMtZnBnYSIsICJmc2wsZnBnYS1xaXhpcy1pMmMiOw0KKwkJcmVnID0gPDB4NjY+Ow0KKwkJI2Fk
ZHJlc3MtY2VsbHMgPSA8MT47DQorCQkjc2l6ZS1jZWxscyA9IDwwPjsNCisJfQ0KKw0KKyogRnJl
ZXNjYWxlIG9uLWJvYXJkIEZQR0ENCisNCitUaGlzIGlzIHRoZSBtZW1vcnktbWFwcGVkIHJlZ2lz
dGVycyBmb3Igb24gYm9hcmQgRlBHQS4NCisNCitSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KKy0gY29t
cGF0aWJsZTogc2hvdWxkIGJlIGEgYm9hcmQtc3BlY2lmaWMgc3RyaW5nIGZvbGxvd2VkIGJ5IGEg
c3RyaW5nDQorICBpbmRpY2F0aW5nIHRoZSB0eXBlIG9mIEZQR0EuICBFeGFtcGxlOg0KKwkiZnNs
LDxib2FyZD4tZnBnYSIsICJmc2wsZnBnYS1xaXhpcyINCistIHJlZzogc2hvdWxkIGNvbnRhaW4g
dGhlIGFkZHJlc3MgYW5kIHRoZSBsZW5ndGggb2YgdGhlIEZQR0EgcmVnaXN0ZXIgc2V0Lg0KKw0K
K0V4YW1wbGUgKExTMjA4MEEtUkRCKToNCisNCisgICAgICAgIGNwbGRAMywwIHsNCisgICAgICAg
ICAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsbHMyMDgwYXJkYi1mcGdhIiwgImZzbCxmcGdhLXFp
eGlzIjsNCisgICAgICAgICAgICAgICAgcmVnID0gPDB4MyAwIDB4MTAwMDA+Ow0KKyAgICAgICAg
fTsNCisNCi0tIA0KMi4xNy4xDQoNCg==

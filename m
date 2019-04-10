Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F30C282CE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 03:17:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 883E921741
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 03:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fkkDU5Xh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 883E921741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44f8V96GD2zDqLw
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 13:17:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.13.84; helo=eur01-he1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="fkkDU5Xh"; 
 dkim-atps=neutral
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr130084.outbound.protection.outlook.com [40.107.13.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44f8Rs20dxzDqGL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 13:15:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQOrOTGuV2e+0Pg4s/3Q4cJrnqtU21auZvOaLClatI8=;
 b=fkkDU5Xhej1lYiJR+THDRHmyNTtnXG8Vlsef6Y0bd4TiulvHFEBYtlfGQOHlJgtuyLxjEGVApvXpZ8jsI6r1w63tUc1d26UbLrnS6ctETHTMVjOwWDGlk9/ydUXBTDP26SU4Am6eZzJzKPhHLzGmef7R0qqySlnYn3PLPGETvYk=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6685.eurprd04.prod.outlook.com (20.179.235.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Wed, 10 Apr 2019 03:15:27 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%6]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 03:15:27 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH] ASoC: fsl_asrc: replace the process_option table with function
Thread-Topic: [PATCH] ASoC: fsl_asrc: replace the process_option table with
 function
Thread-Index: AQHU70ukHNhK1tLZLUSA3IU+ZLcz3g==
Date: Wed, 10 Apr 2019 03:15:26 +0000
Message-ID: <1554866131-12088-1-git-send-email-shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK2PR04CA0083.apcprd04.prod.outlook.com
 (2603:1096:202:15::27) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6770c980-b8f6-4c2f-c2ca-08d6bd62c71b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6685; 
x-ms-traffictypediagnostic: VE1PR04MB6685:
x-microsoft-antispam-prvs: <VE1PR04MB6685F83070325A1E03C90D35E32E0@VE1PR04MB6685.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(136003)(396003)(366004)(346002)(39860400002)(189003)(199004)(97736004)(52116002)(7736002)(2501003)(71190400001)(2616005)(26005)(102836004)(6116002)(386003)(186003)(71200400001)(6506007)(14444005)(3846002)(53936002)(6512007)(86362001)(316002)(36756003)(2906002)(110136005)(256004)(2201001)(478600001)(8936002)(4326008)(106356001)(5660300002)(6486002)(305945005)(68736007)(476003)(81166006)(25786009)(81156014)(50226002)(8676002)(486006)(66066001)(14454004)(6436002)(105586002)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6685;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ph6piE0dUZLbr9/YhAN8H/mJT3bsWZsStNjK/OtdG+luSSlqilHTar3QoBSK15Ct94JWmRsGpkg+H6+3eBbnwNXo+UzPK+IiOiDU2pE5PLkieAMgZA1guCdG+giIAYW1YiltBTB6cEwEHdZEyc47RtHHZmgqymngHxhd+DIIUm/s6Tps/+dhaGx3ChoEAHVD4arPN3PdVS4YvLUhRBMt/4zHKCIbg0IDhp5yS4rsvXFepOht378gjY6XBpJejaA3kJJ13iC+AVSmKR8PRVureYRCNdI1YXU+u8VshwktkjAgSOdHU0f2NeSR78TIhlfWqqgAUKfVoYUDypvvW00H8Xea7b6T3O0uswywfbSAGT4rnx5MQm7VpY/bPPI5vyRDT17WltVSXhvivaQKF6gDcCiL9q45mpEmEGf6RMz3ioU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6770c980-b8f6-4c2f-c2ca-08d6bd62c71b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 03:15:26.9027 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6685
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

VGhlIHRhYmxlIGlzIG5vdCBmbGV4aWJsZSBpZiBzdXBwb3J0ZWQgc2FtcGxlIHJhdGUgaXMgbm90
IGluIHRoZQ0KdGFibGUsIHNvIHVzZSBhIGZ1bmN0aW9uIHRvIHJlcGxhY2UgaXQuDQoNClNpZ25l
ZC1vZmYtYnk6IFNoZW5naml1IFdhbmcgPHNoZW5naml1LndhbmdAbnhwLmNvbT4NCi0tLQ0KIHNv
dW5kL3NvYy9mc2wvZnNsX2FzcmMuYyB8IDczICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1MyBpbnNlcnRpb25zKCspLCAy
MCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9mc2wvZnNsX2FzcmMuYyBi
L3NvdW5kL3NvYy9mc2wvZnNsX2FzcmMuYw0KaW5kZXggMGI5Mzc5MjRkMmU0Li5hNTdjNmM4Mjkw
NjAgMTAwNjQ0DQotLS0gYS9zb3VuZC9zb2MvZnNsL2ZzbF9hc3JjLmMNCisrKyBiL3NvdW5kL3Nv
Yy9mc2wvZnNsX2FzcmMuYw0KQEAgLTI2LDI0ICsyNiw2IEBADQogI2RlZmluZSBwYWlyX2RiZyhm
bXQsIC4uLikgXA0KIAlkZXZfZGJnKCZhc3JjX3ByaXYtPnBkZXYtPmRldiwgIlBhaXIgJWM6ICIg
Zm10LCAnQScgKyBpbmRleCwgIyNfX1ZBX0FSR1NfXykNCiANCi0vKiBTYW1wbGUgcmF0ZXMgYXJl
IGFsaWduZWQgd2l0aCB0aGF0IGRlZmluZWQgaW4gcGNtLmggZmlsZSAqLw0KLXN0YXRpYyBjb25z
dCB1OCBwcm9jZXNzX29wdGlvbltdWzEyXVsyXSA9IHsNCi0JLyogOGtIeiAxMS4wMjVrSHogMTZr
SHogMjIuMDVrSHogMzJrSHogNDQuMWtIeiA0OGtIeiAgIDY0a0h6ICAgODguMmtIeiA5NmtIeiAg
IDE3NmtIeiAgMTkya0h6ICovDQotCXt7MCwgMX0sIHswLCAxfSwgezAsIDF9LCB7MCwgMH0sIHsw
LCAwfSwgezAsIDB9LCB7MCwgMH0sIHswLCAwfSwgezAsIDB9LCB7MCwgMH0sIHswLCAwfSwgezAs
IDB9LH0sCS8qIDU1MTJIeiAqLw0KLQl7ezAsIDF9LCB7MCwgMX0sIHswLCAxfSwgezAsIDF9LCB7
MCwgMH0sIHswLCAwfSwgezAsIDB9LCB7MCwgMH0sIHswLCAwfSwgezAsIDB9LCB7MCwgMH0sIHsw
LCAwfSx9LAkvKiA4a0h6ICovDQotCXt7MCwgMn0sIHswLCAxfSwgezAsIDF9LCB7MCwgMX0sIHsw
LCAwfSwgezAsIDB9LCB7MCwgMH0sIHswLCAwfSwgezAsIDB9LCB7MCwgMH0sIHswLCAwfSwgezAs
IDB9LH0sCS8qIDExMDI1SHogKi8NCi0Je3sxLCAyfSwgezAsIDJ9LCB7MCwgMX0sIHswLCAxfSwg
ezAsIDF9LCB7MCwgMX0sIHswLCAxfSwgezAsIDB9LCB7MCwgMH0sIHswLCAwfSwgezAsIDB9LCB7
MCwgMH0sfSwJLyogMTZrSHogKi8NCi0Je3sxLCAyfSwgezEsIDJ9LCB7MCwgMn0sIHswLCAxfSwg
ezAsIDF9LCB7MCwgMX0sIHswLCAxfSwgezAsIDB9LCB7MCwgMH0sIHswLCAwfSwgezAsIDB9LCB7
MCwgMH0sfSwJLyogMjIwNTBIeiAqLw0KLQl7ezEsIDJ9LCB7MiwgMX0sIHsyLCAxfSwgezAsIDJ9
LCB7MCwgMX0sIHswLCAxfSwgezAsIDF9LCB7MCwgMX0sIHswLCAxfSwgezAsIDB9LCB7MCwgMH0s
IHswLCAwfSx9LAkvKiAzMmtIeiAqLw0KLQl7ezIsIDJ9LCB7MiwgMn0sIHsyLCAxfSwgezIsIDF9
LCB7MCwgMn0sIHswLCAxfSwgezAsIDF9LCB7MCwgMX0sIHswLCAxfSwgezAsIDF9LCB7MCwgMH0s
IHswLCAwfSx9LAkvKiA0NC4xa0h6ICovDQotCXt7MiwgMn0sIHsyLCAyfSwgezIsIDF9LCB7Miwg
MX0sIHswLCAyfSwgezAsIDJ9LCB7MCwgMX0sIHswLCAxfSwgezAsIDF9LCB7MCwgMX0sIHswLCAw
fSwgezAsIDB9LH0sCS8qIDQ4a0h6ICovDQotCXt7MiwgMn0sIHsyLCAyfSwgezIsIDJ9LCB7Miwg
MX0sIHsxLCAyfSwgezAsIDJ9LCB7MCwgMn0sIHswLCAxfSwgezAsIDF9LCB7MCwgMX0sIHswLCAx
fSwgezAsIDB9LH0sCS8qIDY0a0h6ICovDQotCXt7MiwgMn0sIHsyLCAyfSwgezIsIDJ9LCB7Miwg
Mn0sIHsxLCAyfSwgezEsIDJ9LCB7MSwgMn0sIHsxLCAxfSwgezEsIDF9LCB7MSwgMX0sIHsxLCAx
fSwgezEsIDF9LH0sCS8qIDg4LjJrSHogKi8NCi0Je3syLCAyfSwgezIsIDJ9LCB7MiwgMn0sIHsy
LCAyfSwgezEsIDJ9LCB7MSwgMn0sIHsxLCAyfSwgezEsIDF9LCB7MSwgMX0sIHsxLCAxfSwgezEs
IDF9LCB7MSwgMX0sfSwJLyogOTZrSHogKi8NCi0Je3syLCAyfSwgezIsIDJ9LCB7MiwgMn0sIHsy
LCAyfSwgezIsIDJ9LCB7MiwgMn0sIHsyLCAyfSwgezIsIDF9LCB7MiwgMX0sIHsyLCAxfSwgezIs
IDF9LCB7MiwgMX0sfSwJLyogMTc2a0h6ICovDQotCXt7MiwgMn0sIHsyLCAyfSwgezIsIDJ9LCB7
MiwgMn0sIHsyLCAyfSwgezIsIDJ9LCB7MiwgMn0sIHsyLCAxfSwgezIsIDF9LCB7MiwgMX0sIHsy
LCAxfSwgezIsIDF9LH0sCS8qIDE5MmtIeiAqLw0KLX07DQotDQogLyogQ29ycmVzcG9uZGluZyB0
byBwcm9jZXNzX29wdGlvbiAqLw0KIHN0YXRpYyBpbnQgc3VwcG9ydGVkX2lucHV0X3JhdGVbXSA9
IHsNCiAJNTUxMiwgODAwMCwgMTEwMjUsIDE2MDAwLCAyMjA1MCwgMzIwMDAsIDQ0MTAwLCA0ODAw
MCwgNjQwMDAsIDg4MjAwLA0KQEAgLTc5LDYgKzYxLDQ5IEBADQogDQogc3RhdGljIHVuc2lnbmVk
IGNoYXIgKmNsa19tYXBbMl07DQogDQorc3RhdGljIGludCBwcm9jX2F1dG9zZWwoaW50IEZzaW4s
IGludCBGc291dCwgaW50ICpwcmVfcHJvYywgaW50ICpwb3N0X3Byb2MpDQorew0KKwlib29sIGRl
dF9vdXRfb3AyX2NvbmQ7DQorCWJvb2wgZGV0X291dF9vcDBfY29uZDsNCisNCisJZGV0X291dF9v
cDJfY29uZCA9ICgoKEZzaW4gKiAxNSA+IEZzb3V0ICogMTYpICYgKEZzb3V0IDwgNTYwMDApKSB8
DQorCQkJCQkoKEZzaW4gPiA1NjAwMCkgJiAoRnNvdXQgPCA1NjAwMCkpKTsNCisJZGV0X291dF9v
cDBfY29uZCA9IChGc2luICogMjMgPCBGc291dCAqIDgpOw0KKw0KKwkvKg0KKwkgKiBOb3Qgc3Vw
cG9ydGVkIGNhc2U6IFRzb3V0PjE2LjEyNSpUc2luLCBhbmQgVHNvdXQ+OC4xMjUqVHNpbi4NCisJ
ICovDQorCWlmIChGc2luICogOCA+IDEyOSAqIEZzb3V0KQ0KKwkJKnByZV9wcm9jID0gNTsNCisJ
ZWxzZSBpZiAoRnNpbiAqIDggPiA2NSAqIEZzb3V0KQ0KKwkJKnByZV9wcm9jID0gNDsNCisJZWxz
ZSBpZiAoRnNpbiAqIDggPiAzMyAqIEZzb3V0KQ0KKwkJKnByZV9wcm9jID0gMjsNCisJZWxzZSBp
ZiAoRnNpbiAqIDggPiAxNSAqIEZzb3V0KSB7DQorCQlpZiAoRnNpbiA+IDE1MjAwMCkNCisJCQkq
cHJlX3Byb2MgPSAyOw0KKwkJZWxzZQ0KKwkJCSpwcmVfcHJvYyA9IDE7DQorCX0gZWxzZSBpZiAo
RnNpbiA8IDc2MDAwKQ0KKwkJKnByZV9wcm9jID0gMDsNCisJZWxzZSBpZiAoRnNpbiA+IDE1MjAw
MCkNCisJCSpwcmVfcHJvYyA9IDI7DQorCWVsc2UNCisJCSpwcmVfcHJvYyA9IDE7DQorDQorCWlm
IChkZXRfb3V0X29wMl9jb25kKQ0KKwkJKnBvc3RfcHJvYyA9IDI7DQorCWVsc2UgaWYgKGRldF9v
dXRfb3AwX2NvbmQpDQorCQkqcG9zdF9wcm9jID0gMDsNCisJZWxzZQ0KKwkJKnBvc3RfcHJvYyA9
IDE7DQorDQorCWlmICgqcHJlX3Byb2MgPT0gNCB8fCAqcHJlX3Byb2MgPT0gNSkNCisJCXJldHVy
biAtRUlOVkFMOw0KKw0KKwlyZXR1cm4gMDsNCit9DQorDQogLyoqDQogICogUmVxdWVzdCBBU1JD
IHBhaXINCiAgKg0KQEAgLTIzOSw4ICsyNjQsMTAgQEAgc3RhdGljIGludCBmc2xfYXNyY19jb25m
aWdfcGFpcihzdHJ1Y3QgZnNsX2FzcmNfcGFpciAqcGFpcikNCiAJdTMyIGlucmF0ZSwgb3V0cmF0
ZSwgaW5kaXYsIG91dGRpdjsNCiAJdTMyIGNsa19pbmRleFsyXSwgZGl2WzJdOw0KIAlpbnQgaW4s
IG91dCwgY2hhbm5lbHM7DQorCWludCBwcmVfcHJvYywgcG9zdF9wcm9jOw0KIAlzdHJ1Y3QgY2xr
ICpjbGs7DQogCWJvb2wgaWRlYWw7DQorCWludCByZXQ7DQogDQogCWlmICghY29uZmlnKSB7DQog
CQlwYWlyX2VycigiaW52YWxpZCBwYWlyIGNvbmZpZ1xuIik7DQpAQCAtMzc3LDExICs0MDQsMTcg
QEAgc3RhdGljIGludCBmc2xfYXNyY19jb25maWdfcGFpcihzdHJ1Y3QgZnNsX2FzcmNfcGFpciAq
cGFpcikNCiAJCQkgICBBU1JDVFJfSURSaV9NQVNLKGluZGV4KSB8IEFTUkNUUl9VU1JpX01BU0so
aW5kZXgpLA0KIAkJCSAgIEFTUkNUUl9JRFIoaW5kZXgpIHwgQVNSQ1RSX1VTUihpbmRleCkpOw0K
IA0KKwlyZXQgPSBwcm9jX2F1dG9zZWwoaW5yYXRlLCBvdXRyYXRlLCAmcHJlX3Byb2MsICZwb3N0
X3Byb2MpOw0KKwlpZiAocmV0KSB7DQorCQlwYWlyX2VycigiTm8gc3VwcG9ydGVkIHByZS1wcm9j
ZXNzaW5nIG9wdGlvbnNcbiIpOw0KKwkJcmV0dXJuIHJldDsNCisJfQ0KKw0KIAkvKiBBcHBseSBj
b25maWd1cmF0aW9ucyBmb3IgcHJlLSBhbmQgcG9zdC1wcm9jZXNzaW5nICovDQogCXJlZ21hcF91
cGRhdGVfYml0cyhhc3JjX3ByaXYtPnJlZ21hcCwgUkVHX0FTUkNGRywNCiAJCQkgICBBU1JDRkdf
UFJFTU9EaV9NQVNLKGluZGV4KSB8CUFTUkNGR19QT1NUTU9EaV9NQVNLKGluZGV4KSwNCi0JCQkg
ICBBU1JDRkdfUFJFTU9EKGluZGV4LCBwcm9jZXNzX29wdGlvbltpbl1bb3V0XVswXSkgfA0KLQkJ
CSAgIEFTUkNGR19QT1NUTU9EKGluZGV4LCBwcm9jZXNzX29wdGlvbltpbl1bb3V0XVsxXSkpOw0K
KwkJCSAgIEFTUkNGR19QUkVNT0QoaW5kZXgsIHByZV9wcm9jKSB8DQorCQkJICAgQVNSQ0ZHX1BP
U1RNT0QoaW5kZXgsIHBvc3RfcHJvYykpOw0KIA0KIAlyZXR1cm4gZnNsX2FzcmNfc2V0X2lkZWFs
X3JhdGlvKHBhaXIsIGlucmF0ZSwgb3V0cmF0ZSk7DQogfQ0KLS0gDQoxLjkuMQ0KDQo=

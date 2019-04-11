Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB093C10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 08:45:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4980A2082E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 08:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KYctovrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4980A2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fvjY5ySCzDqPS
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 18:45:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe1f::604;
 helo=eur01-ve1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="KYctovrz"; 
 dkim-atps=neutral
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fvgQ0TdPzDqMn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 18:43:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lft6uG8B3h4bZQPbRGHxQ5yiuIRrTYbFHVOZdfGQvHA=;
 b=KYctovrzG6UkpbbUjfrx4hq4YQPABUNxEb1nSFEciTwt/0bKTeI5q2fh4EXlfYWioSx0RJ3zPG02m/I2pvRS/wBo/yNI52SMcST95CU/mbiSJcTOdmJs3cmPL6jzslVfr7AxBLuXla0ZrNzGKJcwInJfg/IAkqWKztVPNapax+I=
Received: from AM0PR04MB6468.eurprd04.prod.outlook.com (20.179.253.81) by
 AM0PR04MB5908.eurprd04.prod.outlook.com (20.178.203.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Thu, 11 Apr 2019 08:43:02 +0000
Received: from AM0PR04MB6468.eurprd04.prod.outlook.com
 ([fe80::107:1bdc:981e:e292]) by AM0PR04MB6468.eurprd04.prod.outlook.com
 ([fe80::107:1bdc:981e:e292%4]) with mapi id 15.20.1792.009; Thu, 11 Apr 2019
 08:43:02 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>, "gustavo@embeddedor.com"
 <gustavo@embeddedor.com>
Subject: [PATCH V5] ASoC: fsl_esai: Fix missing break in switch statement
Thread-Topic: [PATCH V5] ASoC: fsl_esai: Fix missing break in switch statement
Thread-Index: AQHU8EKSn+xtFGxdPk+wdQI8DtgB1w==
Date: Thu, 11 Apr 2019 08:43:01 +0000
Message-ID: <a2c4e289d292ac0e691131784962305f8207a4d8.1554971930.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK2PR02CA0170.apcprd02.prod.outlook.com
 (2603:1096:201:1f::30) To AM0PR04MB6468.eurprd04.prod.outlook.com
 (2603:10a6:208:16e::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 951e6f9f-5bb2-4d40-483a-08d6be59b4e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:AM0PR04MB5908; 
x-ms-traffictypediagnostic: AM0PR04MB5908:
x-microsoft-antispam-prvs: <AM0PR04MB59084E8BD66F99456D5024BEE32F0@AM0PR04MB5908.eurprd04.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(39860400002)(136003)(396003)(376002)(366004)(346002)(199004)(189003)(26005)(53936002)(4326008)(3846002)(25786009)(54906003)(102836004)(81166006)(36756003)(6116002)(97736004)(2906002)(6486002)(110136005)(66066001)(2501003)(316002)(50226002)(6436002)(105586002)(106356001)(52116002)(8936002)(14454004)(186003)(256004)(6506007)(8676002)(71190400001)(71200400001)(508600001)(2201001)(386003)(118296001)(4744005)(486006)(81156014)(5660300002)(2616005)(14444005)(6512007)(86362001)(7736002)(68736007)(476003)(305945005)(99286004)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5908;
 H:AM0PR04MB6468.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rSGhESaR96Spdmhbc0J+5tQHqb5qOkuSS/f61LPe05eKKq2Sp2FUunEsj0OLNdZJF7Dr9b3KBW2a7urMN6libFMTCGrtdo8/ggriM3NpFUH9PCGFF6Btw/f0am/hwCMoOeZwFeqKF70DJMOWH0TvRWAaIB7g38nga+DqIwRHeE4q7xHH9KJjWdeer4ZoK+GsrCpplowcvHE0O1yuH1GJFjLK2jyXlkTbpAVr1868qNSN74hcwWm0R3zhIBS1uGOwa5hzi57KJW7fereFfQPVYUDgKNMk4QIcVOmPVRfB/FBXjHqToRpCNxB895RWWtM/d6A0vgZcaxmV0NHaUmj9OnC6mZoj8ctNGs8SJNfwWk3UDBEo1TjEAHBnodapFqI28VHuk5ratxHcDEBGz5speW5brwlxqISw7WzxWoDiqws=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 951e6f9f-5bb2-4d40-483a-08d6be59b4e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 08:43:02.0010 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5908
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Y2FzZSBFU0FJX0hDS1RfRVhUQUwgYW5kIGNhc2UgRVNBSV9IQ0tSX0VYVEFMIHNob3VsZCBiZQ0K
aW5kZXBlbmRlbnQgb2YgZWFjaCBvdGhlciwgc28gcmVwbGFjZSBmYWxsLXRocm91Z2ggd2l0aCBi
cmVhay4NCg0KRml4ZXM6IDQzZDI0ZTc2YjY5OCAoIkFTb0M6IGZzbF9lc2FpOiBBZGQgRVNBSSBD
UFUgREFJIGRyaXZlciIpDQpTaWduZWQtb2ZmLWJ5OiBTaGVuZ2ppdSBXYW5nIDxzaGVuZ2ppdS53
YW5nQG54cC5jb20+DQpBY2tlZC1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGVvdHN1a2FAZ21haWwu
Y29tPg0KQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPg0KLS0tDQpDaGFuZ2VzIGluIHY1DQot
IHJlbW92ZSBuZXcgbGluZSBhZnRlciBGaXhlcw0KDQpDaGFuZ2VzIGluIHY0DQotIEFkZCBhY2tl
ZC1ieQ0KDQpDaGFuZ2VzIGluIHYzDQotIFVwZGF0ZSBzdWJqZWN0IGxpbmUgYW5kIGNjIHN0YWJs
ZQ0KDQpDaGFuZ2VzIGluIHYyDQotIEZpeCAiRml4ZXMiIHRhZw0KDQogc291bmQvc29jL2ZzbC9m
c2xfZXNhaS5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvc291bmQvc29jL2ZzbC9mc2xfZXNhaS5jIGIvc291bmQv
c29jL2ZzbC9mc2xfZXNhaS5jDQppbmRleCAzNjIzYWE5YTZmMmUuLjE1MjAyYTYzNzE5NyAxMDA2
NDQNCi0tLSBhL3NvdW5kL3NvYy9mc2wvZnNsX2VzYWkuYw0KKysrIGIvc291bmQvc29jL2ZzbC9m
c2xfZXNhaS5jDQpAQCAtMjUxLDcgKzI1MSw3IEBAIHN0YXRpYyBpbnQgZnNsX2VzYWlfc2V0X2Rh
aV9zeXNjbGsoc3RydWN0IHNuZF9zb2NfZGFpICpkYWksIGludCBjbGtfaWQsDQogCQlicmVhazsN
CiAJY2FzZSBFU0FJX0hDS1RfRVhUQUw6DQogCQllY3IgfD0gRVNBSV9FQ1JfRVRJOw0KLQkJLyog
ZmFsbCB0aHJvdWdoICovDQorCQlicmVhazsNCiAJY2FzZSBFU0FJX0hDS1JfRVhUQUw6DQogCQll
Y3IgfD0gRVNBSV9FQ1JfRVJJOw0KIAkJYnJlYWs7DQotLSANCjEuOS4xDQoNCg==

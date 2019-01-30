Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ADBC282D7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 11:36:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4455A20844
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 11:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="t+FrauO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4455A20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qLtL1Kb9zDqVH
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 22:36:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.54; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=pankaj.bansal@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="t+FrauO4"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00054.outbound.protection.outlook.com [40.107.0.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qLqw2cHbzDqTL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 22:34:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQD7LMeN7Qjv+VHZCoFCj8OgZVmUimKyTtPJzWnYZwo=;
 b=t+FrauO4F8FaMb15pI+oUoi+rA0URC+i8eMxi1TO/7hkv35pVsffcuDdNaRPht8a+kTavRJw/i2L91jJaH99/MHTldW1zbw3CNznIOkhDqmBeXPtryIYrnd41qUrC6qb9UbCISQY9w80XkMtKOYTF+pspxsG7m8/R6/44knahlM=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2509.eurprd04.prod.outlook.com (10.168.65.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Wed, 30 Jan 2019 11:34:27 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe%8]) with mapi id 15.20.1558.023; Wed, 30 Jan 2019
 11:34:27 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: Leo Li <leoyang.li@nxp.com>
Subject: [PATCH v2 0/2] add i2c controlled qixis driver
Thread-Topic: [PATCH v2 0/2] add i2c controlled qixis driver
Thread-Index: AQHUuI/CTtCFk0VeF0GnhkxMZRKU/A==
Date: Wed, 30 Jan 2019 11:34:27 +0000
Message-ID: <20190130165916.8628-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR01CA0111.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::27)
 To VI1PR0401MB2496.eurprd04.prod.outlook.com
 (2603:10a6:800:56::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [92.120.1.69]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0401MB2509;
 6:eqZ9fBmF6tirHU3959QZYOF3xU0b1/c1uuBvc40IH0pZMnNQEhy3fuQk8Sgwhzvi2nB4PZYFvueZpgbMebGCiiJYG8gegm+zHxzkiANf8JhjBXfnjmcm0acTQ5ddcERvOV9mHySittTviGMsgdB+FYuavVtX+pHnvCfWg3dW7faXrOoj8JU5BWMvrnKf9VwZE/pHa0ZO2eG1VbfcFFG5SFCTNJDy3M7cDA/IMOLAvARt2fvBY5Y2qoLn/FqL64zgR8Ra4zk6ukpBJ1jh2O033mqjV3iaN00z7UOiZn3kHUoAyW/vJTYlLTdrr7x2aEFfstcphyJ/26rEbSqcpfG9nvoCWys/vXiISqPoUJLpAi4ufaAWBW9JaV425TmVAlxVUBV7gqfCUkVKtArB9uzd+KCHFligL+nqeakdQKxEUgbFlqFpsYJeX67dnj2wzMMadrL+0AGjnyT1nyKEwh5g0A==;
 5:NVRURoyvK4edGMsAaoc6aXOnS30sRqbtBMXY9EF1uu6pRIuh5Xr+MV8jKKvF6Yr4lIEvzydSLG/ICYFW6Vsfizw7egY1bHspiY2tffvA6pLsI+lYVNsRbg+bDWxY5ot0uWvdz7r/+Kk4a6IxWtSjsxiexgxYyF+f05SW8c2VlZrrwDY6+4OccJAyldh1/+azC3f3K2aL/vNlMcq/AtAcdw==;
 7:MqidzKXQ4nCa4ATqLnvzq6u6G/Nmy8vvweirX+v4xDpHRPPZssyjBX/6Rwjl5cYhB2uZEWVQQMOaMYJ7QugR5dWdh9LLUxD31OJO4H7OHUsToGPX4zEQxPwW8t7a0qAZ4GfQCDxAzz0a7YBF7KAOMQ==
x-ms-office365-filtering-correlation-id: 060b202e-1dc8-4236-211f-08d686a6e43a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0401MB2509; 
x-ms-traffictypediagnostic: VI1PR0401MB2509:
x-microsoft-antispam-prvs: <VI1PR0401MB25095921B5246A9B0A901377F1900@VI1PR0401MB2509.eurprd04.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(366004)(396003)(136003)(346002)(376002)(189003)(199004)(2906002)(105586002)(8676002)(478600001)(26005)(25786009)(97736004)(6636002)(54906003)(6306002)(106356001)(6506007)(386003)(3846002)(316002)(102836004)(966005)(37006003)(14454004)(81166006)(81156014)(6116002)(36756003)(6486002)(6512007)(256004)(50226002)(7736002)(44832011)(1076003)(71190400001)(4744005)(8936002)(68736007)(6436002)(66066001)(71200400001)(99286004)(86362001)(4326008)(186003)(53936002)(486006)(2616005)(6862004)(52116002)(476003)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB2509;
 H:VI1PR0401MB2496.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E6npDNJHs0MhGhJzqqG2cGeDmz534QbMUkqL4rl1Ikr4udcN0QnIIPNUWBkKdXTWaSBXir2J2q6FUg45wK8fuh1ksDTZlcSh02ET6ZHTS281sGr1m+gCJsn5fVl6esVFYxi2ep6uxyvEa50ra0NFOxkwSPfA2wcKWfKJO+5OHUW7Pm5FmX9u22dXocosPuJd+yVAPUmSmhRpRpeaPoT1M24Wenb9BPWCkq1Aiv+A/42MtHS4MOHZEiH8keT3dCwsR+9uK7iQ9y9o9BELQZRqXF8E+xCqFrwCQ5hu2t4PJ47LlGMgjC+pmCo8flHGJcvwTETde681l9F945vYK0nEGDqj+19FlKICJXLWyHQgeZhSyuJr4sLT3YVkgZkFIJfGXmAh5f/oOQFwI4GYrRbzGlrXzjl1hL8wfmKBJpqGKto=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47D8698347954441A09E1102CF8FBAA4@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060b202e-1dc8-4236-211f-08d686a6e43a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 11:34:26.0274 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2509
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
 Varun Sethi <V.Sethi@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

RlBHQSBvbiBMWDIxNjBBUURTL0xYMjE2MEFSREIgY29ubmVjdGVkIG9uIEkyQyBidXMsIHNvIGFk
ZCBxaXhpcw0KZHJpdmVyIHdoaWNoIGlzIGJhc2ljYWxseSBhbiBpMmMgY2xpZW50IGRyaXZlciB0
byBjb250cm9sIEZQR0EuDQoNClRoaXMgZHJpdmVyIGlzIGVzc2VudGlhbCB0byBjb250cm9sIE1E
SU8gbXV4IG11bHRpcGxleGluZy4NCg0KVGhpcyBkcml2ZXIgaXMgZGVwZW5kZW50IG9uIGJlbG93
IHBhdGNoZXM6DQpodHRwczovL3d3dy5tYWlsLWFyY2hpdmUuY29tL25ldGRldkB2Z2VyLmtlcm5l
bC5vcmcvbXNnMjgxMjc0Lmh0bWwNCg0KVjEgb2YgdGhpcyBzZXJpZXM6DQpodHRwczovL3BhdGNo
d29yay5rZXJuZWwub3JnL2NvdmVyLzEwNjI3Mjk3Lw0KDQpDYzogVmFydW4gU2V0aGkgPFYuU2V0
aGlAbnhwLmNvbT4NCg0KUGFua2FqIEJhbnNhbCAoMik6DQogIGR0LWJpbmRpbmdzOiBzb2M6IGZz
bDogRG9jdW1lbnQgUWl4aXMgRlBHQSB1c2FnZQ0KICBmc2w6IGFkZCBpMmMgY29udHJvbGxlZCBx
aXhpcyBkcml2ZXINCg0KIC4uLi9iaW5kaW5ncy9zb2MvZnNsL3FpeGlzX2N0cmwudHh0ICAgICAg
ICAgICB8ICAzMyArKysrKw0KIGRyaXZlcnMvc29jL2ZzbC9LY29uZmlnICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgOCArKw0KIGRyaXZlcnMvc29jL2ZzbC9NYWtlZmlsZSAgICAgICAgICAgICAg
ICAgICAgICB8ICAgMSArDQogZHJpdmVycy9zb2MvZnNsL3FpeGlzX2N0cmwuYyAgICAgICAgICAg
ICAgICAgIHwgMTIxICsrKysrKysrKysrKysrKysrKw0KIDQgZmlsZXMgY2hhbmdlZCwgMTYzIGlu
c2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3NvYy9mc2wvcWl4aXNfY3RybC50eHQNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9zb2MvZnNsL3FpeGlzX2N0cmwuYw0KDQotLSANCjIuMTcuMQ0KDQo=

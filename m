Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78E3C282D7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 09:14:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F63B206DD
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 09:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RfOEfc9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F63B206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tMTN0bSkzDqBM
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 20:14:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.1.81; helo=eur02-he1-obe.outbound.protection.outlook.com;
 envelope-from=pankaj.bansal@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="RfOEfc9Y"; 
 dkim-atps=neutral
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10081.outbound.protection.outlook.com [40.107.1.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tMNy48K3zDqGY
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 20:10:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92FhkxR2k2N6UHpMDSv82Gx55fUz4fm2m5erdCvyWdc=;
 b=RfOEfc9YuYgRgsCNXSXSBkuju1dp35lIefs1Cc65/1H5j9EG4Ob5gsOz3nO72ACdgVAb7LXQw6/UYjNNpfM7ZeRpv8lq9UmZb0zx4Fd8ZY9lnGm724x8h4VNXQOGqzWwiYEtKRYAZlNkg3BhuTFXS6+Vc4NsBrkwEO7vp9cxbtY=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2640.eurprd04.prod.outlook.com (10.168.66.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Mon, 4 Feb 2019 09:10:01 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe%8]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 09:10:01 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: Leo Li <leoyang.li@nxp.com>
Subject: [PATCH v3 0/2] add qixis driver
Thread-Topic: [PATCH v3 0/2] add qixis driver
Thread-Index: AQHUvGloYp719U5yW0it7u7DV+gjxQ==
Date: Mon, 4 Feb 2019 09:10:00 +0000
Message-ID: <20190204143449.25040-1-pankaj.bansal@nxp.com>
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
 6:nRaAhPgsfPoQYiZQkQYRdK5h0EOIh1tmiPCQNsb3U0/8bqzbLyOWKxvEeqP6+Yetjug9MfyYti0QSfX3MLMwmCWVOTmrcLfLWy5Z+u4fq52vLB7kw3oSXWtFGH0jvsJhUUskKrvWqRGrXWfdvV9s3Aqiy/w4yK1/DdHKGZkwav+yqfzhSFMWhIlVHnUMQpNzxvAidFUkSM8xgNDO00Q3jvCbc+q2qtUB4BHHcDzQrhGjgqM1i8HdQOLfwouPVQwmQjozawiahXzi96BNcY8fVAdwcCfujFGLF0NoslZuyea65FU7BJdjG/vzdyhbMLiNtOBkiriss3MBndXuNVy4csNeT8tY2F0PVLTSy3UmAZhFqY2wGibbDG8sz4IWnaUJwOdEul5ymHUmkNclsh5c6cPl8NBe1pwaXxo1hObTgVoqE0L+Trcz6Mwx7ItHtm/lZkkOSew8NKp20FhqFdISwA==;
 5:4Gu0Um57T1ln+47mah97jK3rCrbl4ZoU1xndNtk+JOh8xQDYtxClmKA13zju+7eeNjLqtQOd3c9xN2yANH4oDd7VTZ35sM3xSEYWq3kHQiUr+wvHPbqqGk4uydWnx6vlon3SahdH1czukVujvNCtXuTm5OYsiatvj0uQI8ZIFJkCdXinqdGiOuFZDcETrUnti/GDjyA6RcHAUsuZ8NIjUQ==;
 7:4h10snF6xRfHsj6f/CQ1eq+LGI0M439lCciccWX4y8jNvMGKA0CAxnr28kUxJDff1eIO/P1Z3JGr4rLhXrJdjTY3t07rXdgfalgF+4RFqrgxC9dHwPbNSAtalg5wy2lvXg3mimkE1qMZykCVx3yKaQ==
x-ms-office365-filtering-correlation-id: 13925d73-a175-4625-929f-08d68a808a98
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0401MB2640; 
x-ms-traffictypediagnostic: VI1PR0401MB2640:
x-microsoft-antispam-prvs: <VI1PR0401MB26405A09E088274A4E2908F0F16D0@VI1PR0401MB2640.eurprd04.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(136003)(396003)(366004)(39860400002)(346002)(189003)(199004)(66066001)(37006003)(316002)(6636002)(36756003)(99286004)(2906002)(54906003)(6512007)(6306002)(53936002)(966005)(478600001)(14454004)(256004)(52116002)(6486002)(6436002)(7736002)(6506007)(386003)(102836004)(186003)(26005)(68736007)(105586002)(97736004)(106356001)(305945005)(3846002)(6116002)(486006)(8936002)(44832011)(50226002)(81166006)(81156014)(8676002)(476003)(2616005)(86362001)(6862004)(1076003)(25786009)(71200400001)(4744005)(71190400001)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB2640;
 H:VI1PR0401MB2496.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H1QTit5qRX13y3IItJnL5kh1w3zUOnBle4w1vyVSR7D84O4kydLXAcPbhADf3fHlf7ARKRrMMwNnSnVeSJZAdPdQJn8W93gUeiIqTMM0SMmZT+cw2JKm9iv8UkIp9UM0/EZHZJ26f7GY8Yz3n8X+kHJm07npa69SSfIjPr8t7YthyFNDwnH/mxtSyTqlzQp2OiWJlbfwGwMMVXvDSnYC/rMQNsQNPGS4SpdTkS0DGPvyVwokIheagHz/w5zsPu+wVHa7F7RnIxgvt92WlbhI63bThG/0ZFETKGlk45FSeztIejq+b/MOdyzCjIE/N4Ta0tstPirUElQ2DcJFkkbPuaivQvEGh/C6AjhHpa1vMRBbP10I80f3F2Y06bvjkxo6byLp4PjKZIaneuMWkN97eAPLHABlpuky8B+Z2K/9PPE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85281D6AD7A9FF4DB7E8D11AA684A809@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13925d73-a175-4625-929f-08d68a808a98
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 09:09:59.4166 (UTC)
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
 Varun Sethi <V.Sethi@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

RlBHQSBvbiBMWDIxNjBBUURTL0xYMjE2MEFSREIgY29ubmVjdGVkIG9uIEkyQyBidXMsDQpzbyBh
ZGQgcWl4aXMgZHJpdmVyIHdoaWNoIGlzIGJhc2ljYWxseSBhbiBpMmMgY2xpZW50IGRyaXZlciB0
byBjb250cm9sIEZQR0EuDQoNCkFsc28gYWRkZWQgcGxhdGZvcm0gZHJpdmVyIGZvciBNTUlPIGJh
c2VkIEZQR0EsIGxpa2UgdGhlIG9uZSBhdmFpbGFibGUNCm9uIExTMjA4OEFSREIvTFMyMDg4QVFE
Uy4NCg0KVGhpcyBkcml2ZXIgaXMgZXNzZW50aWFsIHRvIGNvbnRyb2wgTURJTyBtdXggbXVsdGlw
bGV4aW5nLg0KDQpUaGlzIGRyaXZlciBpcyBkZXBlbmRlbnQgb24gYmVsb3cgcGF0Y2hlczoNCmh0
dHBzOi8vd3d3Lm1haWwtYXJjaGl2ZS5jb20vbmV0ZGV2QHZnZXIua2VybmVsLm9yZy9tc2cyODEy
NzQuaHRtbA0KDQpDYzogVmFydW4gU2V0aGkgPFYuU2V0aGlAbnhwLmNvbT4NCg0KLS0tDQpOb3Rl
czoNCiAgICBWMjoNCiAgICAtIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvY292ZXIvMTA3
ODgzNDEvDQogICAgVjE6DQogICAgLSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL2NvdmVy
LzEwNjI3Mjk3Lw0KDQpQYW5rYWogQmFuc2FsICgyKToNCiAgZHQtYmluZGluZ3M6IHNvYzogZnNs
OiBEb2N1bWVudCBRaXhpcyBGUEdBIHVzYWdlDQogIGRyaXZlcnM6IHNvYzogZnNsOiBhZGQgcWl4
aXMgZHJpdmVyDQoNCiAuLi4vYmluZGluZ3Mvc29jL2ZzbC9xaXhpc19jdHJsLnR4dCAgICAgICAg
ICAgfCAgNTMgKysrKysNCiBkcml2ZXJzL3NvYy9mc2wvS2NvbmZpZyAgICAgICAgICAgICAgICAg
ICAgICAgfCAgMTEgKw0KIGRyaXZlcnMvc29jL2ZzbC9NYWtlZmlsZSAgICAgICAgICAgICAgICAg
ICAgICB8ICAgMSArDQogZHJpdmVycy9zb2MvZnNsL3FpeGlzX2N0cmwuYyAgICAgICAgICAgICAg
ICAgIHwgMjA3ICsrKysrKysrKysrKysrKysrKw0KIDQgZmlsZXMgY2hhbmdlZCwgMjcyIGluc2Vy
dGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NvYy9mc2wvcWl4aXNfY3RybC50eHQNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9zb2MvZnNsL3FpeGlzX2N0cmwuYw0KDQotLSANCjIuMTcuMQ0KDQo=

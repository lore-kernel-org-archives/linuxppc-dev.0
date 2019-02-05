Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F882C282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 10:16:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 823602083B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 10:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="v/+j3rwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823602083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43v0pz4SFSzDqMS
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 21:16:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe1f::623;
 helo=eur01-ve1-obe.outbound.protection.outlook.com;
 envelope-from=pankaj.bansal@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="v/+j3rwg"; 
 dkim-atps=neutral
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43v0n45PLlzDqJQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 21:14:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aH50gOLcom9OSQehZJpibvFWh4GYxhU1Iti8qPrl+zg=;
 b=v/+j3rwg2hH4Y9GUiAkiRm4kQxGWVYV0m66JmCYeSqd15fs6/dIlD9GSxeqaRHAuYT7yoULGScogi0at5n+e3hT7+qFaalSnGdhqSe9PqlgLwAKX7hJA3Ku3KL+2Xl5npgs54WuyRrzpANAgRzGCU2mJA9GhCGzlTY2fRnv9XbA=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2030.eurprd04.prod.outlook.com (10.166.141.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Tue, 5 Feb 2019 10:14:39 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 10:14:39 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 0/2] add qixis driver
Thread-Topic: [PATCH v4 0/2] add qixis driver
Thread-Index: AQHUvTuasEwNjg2eckWnM8rIkKU7jQ==
Date: Tue, 5 Feb 2019 10:14:39 +0000
Message-ID: <20190205153924.7204-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::29) To VI1PR0401MB2496.eurprd04.prod.outlook.com
 (2603:10a6:800:56::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [92.120.1.69]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0401MB2030;
 6:9L9CElNPsNVa5U/uFOj2F3SPSN66UfOyiEAzx4iIkEwASo9nlGeywQtUp9zVGT3UYsB2fxTljfOLqNuVszJTCULuYLO8oq5hNgQPGxDc80P68qZNv08KkV2NvmN7fXxRfM/xEP+btxBuyw4ZEz0Wd+RVvh4TDnWGsohKDvTnw32sj+bzsoKKEK5alWeZaarrhl0EYWyVp7q9u5um2C5Y6u5Nzyp5DcVg9Xhj/t+pOfm8JLGznLafWZOc6DHUMyApTrBtsJTILuKgOPD/jQxU5CjBuLbQmBtVb2KPdo2zPMRtg5iXMkSEkzcA55wlLWhMC38ogQh1dBOsx0lOhEed1CJo1LZAjtv1kjM5ie9dMrURxdbEsxlQkEIhzWLH1tw/Mxdr+t3kF9RIsMxNGmckTbauImb3Sg1M0qUAyi79l3u37CKdegIr/gP3XT/FFnElVZknI/qr7GHj25eD1mWeoA==;
 5:swFhlZ+9bmpw0LE2AbyYNoYveZkxkneiwZSjqh5XcHacXQgk6gHNyd1vyE9b46QxTAdQ7637yiktOsP0/CwTf/11acDnvLj0At2VqWJvnNORwbuHJDolCBQB14pgO8U50RXv4pixnL28zK0BpMCMtPzKFV98q3t+xRRuG2qat8BnLtpzMbCpDZJM2enAu5xzawr50rlC6e/IDTSOE9KeEw==;
 7:NY40+LZ/lS7pTARxQhHob6Oft3Gb4Of0Wn1bLd2GoS6LijN7iqV6KYTt9tOghSH5G6GlQvWFplDhp9UIHCM9fcvUZlRbsRv4HqB5MO0K29A/pqZrkTxINt0/DkMfBjhIqUIuHw4fVihx1qTTqckGbQ==
x-ms-office365-filtering-correlation-id: 0e573c03-a6d1-4240-2b5a-08d68b52bc92
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0401MB2030; 
x-ms-traffictypediagnostic: VI1PR0401MB2030:
x-microsoft-antispam-prvs: <VI1PR0401MB20305522A0B4E70F3936F315F16E0@VI1PR0401MB2030.eurprd04.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(376002)(366004)(136003)(346002)(199004)(189003)(25786009)(8676002)(2906002)(26005)(14454004)(102836004)(386003)(6506007)(99286004)(6436002)(6486002)(6512007)(4326008)(8936002)(71190400001)(81166006)(81156014)(71200400001)(256004)(6306002)(105586002)(36756003)(106356001)(52116002)(486006)(6116002)(3846002)(44832011)(7736002)(110136005)(476003)(2616005)(966005)(68736007)(316002)(86362001)(53936002)(186003)(1076003)(50226002)(305945005)(478600001)(97736004)(54906003)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB2030;
 H:VI1PR0401MB2496.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HPeNI84WXTTpUsGRACzywTWJnAGTm65bxzb4zILBH7Tp1XoAryHZ6VYuSNvQVzDzTazRzSGeiUfEZ6IysRmt816nnX7w5Ls13xaqomBpnJeAu5HB6D0aE/syrAy85FlcRPod0yvbMSBgUvjCpSjrtTIjqU1FqsAjotDMxDlb7NgVLrRfkphU0m+w8FGT6VDKNvuI2owJHjq0Fb1mxqxPnJIvJ58cbwCL/fR9imIaaW/IQoFD8+BwsMuaBlUq1nFxJ6lVBXr9Wgm1t4g8Gyp2Ev/Sk5f6d+1loanj2O9g6+rAoBlYbHttJI02GPLAfUAJDvRz9upMflad0PmEI191x+M7Y7Q2NzIGHJqcUt4O0lmt3qOwgeKCi+y3qXX9H3NVPhXIJVJrPzPlu1pqjfiB2DQOG2jz+aCy0/BhTsobOyM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F4E9F77F385CF47BE8D769A11A9B993@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e573c03-a6d1-4240-2b5a-08d68b52bc92
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 10:14:37.1656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2030
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
Cc: "open list : OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
 Pankaj Bansal <pankaj.bansal@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Varun Sethi <V.Sethi@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

RlBHQSBvbiBMWDIxNjBBUURTL0xYMjE2MEFSREIgY29ubmVjdGVkIG9uIEkyQyBidXMsIHNvIGFk
ZCBxaXhpcyBkcml2ZXIgd2hpY2ggaXMgYmFzaWNhbGx5IGFuIGkyYyBjbGllbnQgZHJpdmVyIHRv
IGNvbnRyb2wgRlBHQS4NCg0KQWxzbyBhZGRlZCBwbGF0Zm9ybSBkcml2ZXIgZm9yIE1NSU8gYmFz
ZWQgRlBHQSwgbGlrZSB0aGUgb25lIGF2YWlsYWJsZSBvbiBMUzIwODhBUkRCL0xTMjA4OEFRRFMu
DQoNClRoaXMgZHJpdmVyIGlzIGVzc2VudGlhbCB0byBjb250cm9sIE1ESU8gbXV4IG11bHRpcGxl
eGluZy4NCg0KVGhpcyBkcml2ZXIgaXMgZGVwZW5kZW50IG9uIGJlbG93IHBhdGNoZXM6DQpodHRw
czovL3d3dy5tYWlsLWFyY2hpdmUuY29tL25ldGRldkB2Z2VyLmtlcm5lbC5vcmcvbXNnMjgxMjc0
Lmh0bWwNCg0KQ2M6IFZhcnVuIFNldGhpIDxWLlNldGhpQG54cC5jb20+DQoNCi0tLQ0KTm90ZXM6
DQoJVjM6DQoJLSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL2NvdmVyLzEwNzk1MTk1Lw0K
CVYyOg0KCS0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9jb3Zlci8xMDc4ODM0MS8NCglW
MToNCgktIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvY292ZXIvMTA2MjcyOTcvDQoNClBh
bmthaiBCYW5zYWwgKDIpOg0KICBkdC1iaW5kaW5nczogc29jOiBmc2w6IERvY3VtZW50IFFpeGlz
IEZQR0EgdXNhZ2UNCiAgZHJpdmVyczogc29jOiBmc2w6IGFkZCBxaXhpcyBkcml2ZXINCg0KIC4u
Li9iaW5kaW5ncy9zb2MvZnNsL3FpeGlzX2N0cmwudHh0ICAgICAgICAgICB8ICA1MyArKysrKw0K
IGRyaXZlcnMvc29jL2ZzbC9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICB8ICAxMSArDQog
ZHJpdmVycy9zb2MvZnNsL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCiBk
cml2ZXJzL3NvYy9mc2wvcWl4aXNfY3RybC5jICAgICAgICAgICAgICAgICAgfCAyMjIgKysrKysr
KysrKysrKysrKysrDQogNCBmaWxlcyBjaGFuZ2VkLCAyODcgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0
ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL2ZzbC9x
aXhpc19jdHJsLnR4dA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3NvYy9mc2wvcWl4aXNf
Y3RybC5jDQoNCi0tIA0KMi4xNy4xDQoNCg==

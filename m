Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E195EC10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 19:41:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A6BA20859
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 19:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YslQK16M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6BA20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nKny1yrszDqVc
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 05:41:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.69; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=daniel.baluta@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="YslQK16M"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00069.outbound.protection.outlook.com [40.107.0.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nKlq3Gk7zDqTX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 05:39:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0l3RGxAAyvd1rrgBzANk+7BzoZxq1esCh/7eHfFTxWg=;
 b=YslQK16MTokN5S7U0vXm4e+pUNywFMOyJof6EFqOLZeNgo3mXiik6HPRdjeo/EDNEmBnAgpdf3iJIp8D21EqBIUR644103WCGzA+VjBsT3WAngkiMaSSAZf+5rHiOP/hkXur+ZAQWjxcdyY07NgqwLe5fB/ZgUKTXBXgOZtnKBE=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3470.eurprd04.prod.outlook.com (52.134.3.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Sun, 21 Apr 2019 19:39:07 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6%6]) with mapi id 15.20.1813.017; Sun, 21 Apr 2019
 19:39:07 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Subject: [PATCH 0/3] Add runtime PM for SAI digital audio interface
Thread-Topic: [PATCH 0/3] Add runtime PM for SAI digital audio interface
Thread-Index: AQHU+HniB0pOiFbgfkqh8XHYCYhAcQ==
Date: Sun, 21 Apr 2019 19:39:07 +0000
Message-ID: <20190421193853.10188-1-daniel.baluta@nxp.com>
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
x-ms-office365-filtering-correlation-id: a3ca1ebc-a0b6-4f56-5f0a-08d6c69104cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR0402MB3470; 
x-ms-traffictypediagnostic: VI1PR0402MB3470:
x-microsoft-antispam-prvs: <VI1PR0402MB34708EF0459C5A33DEE7B9D6F9210@VI1PR0402MB3470.eurprd04.prod.outlook.com>
x-forefront-prvs: 0014E2CF50
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(39860400002)(366004)(376002)(396003)(346002)(189003)(199004)(3846002)(6116002)(4744005)(86362001)(71190400001)(71200400001)(44832011)(66476007)(64756008)(66556008)(66446008)(66946007)(73956011)(6512007)(2906002)(6916009)(6486002)(50226002)(486006)(8936002)(476003)(2616005)(54906003)(8676002)(305945005)(81156014)(6436002)(53936002)(1076003)(52116002)(1730700003)(7416002)(81166006)(7736002)(14444005)(256004)(5640700003)(186003)(102836004)(478600001)(14454004)(316002)(68736007)(4326008)(26005)(66066001)(2501003)(6506007)(25786009)(386003)(2351001)(99286004)(97736004)(36756003)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3470;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sywwD7/rxywgXsbzygbDpeoklXJRRINejEAjrSn1DvERD+BcIP7BSRoLbqm+jyt5qhxr1fFNHbSxPudVDt1udlIrA7W/qcQux+bmBBcHPQ7Mx9bxrnTl3OfpA8UAusjx5veBXmMc9WC9N+kDqSCpDLvqci5w13/iuIs+X9uMqmf2/6c6GWtBBrSn+fRqlNoliIdCykuFbAN4F/XjEEIgG+s9uzror5TReoY9Z2OcLz5U9WBrZEJrmjUWNSE/VVhk1h8OITVz03JGGsuzTPN/QLM7U7WTMyqPM9FM35sAoc75s3RoDeJJsMAWQfR91TrI8ebM9fGPJEiDzbasPGeLgD+XsP6t3nR8j8+jqY/YEH5xTUw/a+0GdO6crD9McCkeyVNouPrI0WyBnh+y5yHYcGFzzdy1EMaymhRLLTdeQiQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ca1ebc-a0b6-4f56-5f0a-08d6c69104cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2019 19:39:07.6291 (UTC)
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

Rmlyc3QgcGF0Y2ggZml4ZXMgYSBidWcgYnkgY29ycmVjdGx5IHNldHRpbmcgaXNfc2xhdmVfbW9k
ZSwgdGhlbg0Kc2Vjb25kIHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgcnVudGltZSBQTSBhbmQgZmlu
YWxseSAzcmQgcGF0Y2ggbW92ZXMNCmNsb2NrIGhhbmRsaW5nIGZyb20gc3RhcnR1cC9zaHR1ZG93
biBmdW5jdGlvbiB0byBydW50aW1lIFBNIGhhbmRsZXJzLg0KDQpDaGFuZ2VzIHNpbmNlIHYxOg0K
CS0gYWRkZWQgcGF0Y2ggMQ0KCS0gYWRkZWQgZnNsX3NhaV9yZW1vdmUgaW4gb3JkZXIgdG8gY2Fs
bCBwbV9ydW50aW1lX2Rpc2FibGUNCgktIG9ubHkgZGlzYWJsZS9lbmFibGUgbWNsayB3aGVuIFNB
SSBpbiBtYXN0ZXIgbW9kZS4NCg0KRGFuaWVsIEJhbHV0YSAoMik6DQogIEFTb0M6IGZzbF9zYWk6
IFVwZGF0ZSBpc19zbGF2ZV9tb2RlIHdpdGggY29ycmVjdCB2YWx1ZQ0KICBBU29DOiBmc2xfc2Fp
OiBBZGQgc3VwcG9ydCBmb3IgcnVudGltZSBwbQ0KDQpTaGVuZ2ppdSBXYW5nICgxKToNCiAgQVNv
QzogZnNsX3NhaTogTW92ZSBjbG9jayBvcGVyYXRpb24gdG8gUE0gcnVudGltZQ0KDQogc291bmQv
c29jL2ZzbC9mc2xfc2FpLmMgfCA4NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA2OSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMo
LSkNCg0KLS0gDQoyLjE3LjENCg0K

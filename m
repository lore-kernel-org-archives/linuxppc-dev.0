Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1948C10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 09:41:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 151DE20818
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 09:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bt05gNiM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151DE20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fwyB5Q50zDqKM
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 19:41:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.8.70; helo=eur04-vi1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="Bt05gNiM"; 
 dkim-atps=neutral
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80070.outbound.protection.outlook.com [40.107.8.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fww11YVkzDqPS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 19:39:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3GBfspFjXMZeqFxGncGqO+34JsWBVPJovSY/BoAm4A=;
 b=Bt05gNiMZFauPykRb40zdQRx8Qnk9v1d4Cp04Xi08uQZyJyJfHvahzw/F88XXJGTEkP6DV744VJHuEXDXx879ZtaLCSezuvF/XPGpBn1Ky2MEzGZBO9PrFysQbbxY1qv2Gqdnt+OdhB0ZZbLCx+stWTZx6aBmfpk/2YRy/j5uPI=
Received: from AM0PR04MB6468.eurprd04.prod.outlook.com (20.179.253.81) by
 AM0PR04MB5492.eurprd04.prod.outlook.com (20.178.115.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Thu, 11 Apr 2019 09:39:03 +0000
Received: from AM0PR04MB6468.eurprd04.prod.outlook.com
 ([fe80::107:1bdc:981e:e292]) by AM0PR04MB6468.eurprd04.prod.outlook.com
 ([fe80::107:1bdc:981e:e292%4]) with mapi id 15.20.1792.009; Thu, 11 Apr 2019
 09:39:03 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH V2 0/2] Support more sample rate in asrc
Thread-Topic: [PATCH V2 0/2] Support more sample rate in asrc
Thread-Index: AQHU8EplFteQ9HyzsEON7fQqFJN+EQ==
Date: Thu, 11 Apr 2019 09:39:02 +0000
Message-ID: <cover.1554975348.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK2PR02CA0160.apcprd02.prod.outlook.com
 (2603:1096:201:1f::20) To AM0PR04MB6468.eurprd04.prod.outlook.com
 (2603:10a6:208:16e::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e29fcef7-d78d-4de7-9e04-08d6be61882c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:AM0PR04MB5492; 
x-ms-traffictypediagnostic: AM0PR04MB5492:
x-microsoft-antispam-prvs: <AM0PR04MB54925766B0BA23B2444B1256E32F0@AM0PR04MB5492.eurprd04.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(366004)(376002)(39860400002)(396003)(189003)(199004)(4744005)(52116002)(50226002)(36756003)(8936002)(2616005)(106356001)(476003)(6512007)(71190400001)(486006)(66066001)(81166006)(81156014)(8676002)(105586002)(256004)(2201001)(68736007)(5660300002)(97736004)(6436002)(54906003)(14454004)(110136005)(6486002)(2906002)(86362001)(6116002)(3846002)(316002)(7736002)(305945005)(508600001)(2501003)(25786009)(102836004)(71200400001)(99286004)(186003)(26005)(53936002)(386003)(4326008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5492;
 H:AM0PR04MB6468.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MC0od+W5lY05aWDG634TBvj7Q82lKo7AzTbiaQ8ZiPqUB+7wOm9PREWyCi1f20qP5giiWYOVNE69ngp4ZImkh4nsNjiCm2gOviTwEm74C/TeZdo4B48mE8TlD6lLgMsS1EM/7fli4HIIlZ4mBZPuc/rx7Uw9XQxfVETLwboTtZGw+bYI9vkbMqpNbdZCtnZexBn6KWN87NxOEEbkDL5XOJYyrTGD5mY/33Mfgz0a4GfLz6h0dFs0rGY2LvzYTGHHsYEfHOLZDpX2LNswF8ZEWWVQt7g2Iwwx+WKHzINx/Qwg+v8fdb0ICnaQKp2i5XaP7Jd9KIAPgolQUyfMIaSSA6VFYwcrggZVD3Ch7lQ7u1SMM3Peqe17luZYxsXT7DEt/9BanvIFNlDgyjyN4hi2aGxRh8aDI5iLZkRzbUffSUE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29fcef7-d78d-4de7-9e04-08d6be61882c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 09:39:02.9407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5492
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

U3VwcG9ydCBtb3JlIHNhbXBsZSByYXRlIGluIGFzcmMNCg0KU2hlbmdqaXUgV2FuZyAoMik6DQog
IEFTb0M6IGZzbF9hc3JjOiByZXBsYWNlIHRoZSBwcm9jZXNzX29wdGlvbiB0YWJsZSB3aXRoIGZ1
bmN0aW9uDQogIEFTb0M6IGZzbF9hc3JjOiBVbmlmeSB0aGUgc3VwcG9ydGVkIGlucHV0IGFuZCBv
dXRwdXQgcmF0ZQ0KDQpDaGFuZ2VzIGluIHYyDQotIGFkZCBtb3JlIGNvbW1lbnRzIGluIGNvZGUN
Ci0gYWRkIGNvbW1pdCAiVW5pZnkgdGhlIHN1cHBvcnRlZCBpbnB1dCBhbmQgb3V0cHV0IHJhdGUi
DQoNCiBzb3VuZC9zb2MvZnNsL2ZzbF9hc3JjLmMgfCAxMTYgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgODUgaW5zZXJ0aW9u
cygrKSwgMzEgZGVsZXRpb25zKC0pDQoNCi0tIA0KMS45LjENCg0K

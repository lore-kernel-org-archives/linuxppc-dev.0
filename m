Return-Path: <SRS0=ts8b=SV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7ACC282DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 10:25:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9040218EA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 10:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C6CHY3UF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9040218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lsYm2bfYzDqRX
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 20:25:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.13.75; helo=eur01-he1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="C6CHY3UF"; 
 dkim-atps=neutral
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr130075.outbound.protection.outlook.com [40.107.13.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lsWr5ZyhzDqJ3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 20:23:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/yPZU8hlMMWccQQfQUCYZG7ObICUqeMSHSwrdsuixY=;
 b=C6CHY3UFAW06MiIoROeOwaWg1MAnX7I605Y0N6AoMSbNuwBMjuHc0bpGuUMSRiOYtLwEHSnjTN4ys+FKwgtB/WYUQcVCznPY10FtycRUI1TGp5/ttsgEB24vcYEKOKGeHLxiPgsWniV9T94EDTj2L1QI7hreUaYPHC3M2/ssYKI=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6608.eurprd04.prod.outlook.com (20.179.235.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Fri, 19 Apr 2019 10:23:47 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1813.013; Fri, 19 Apr 2019
 10:23:47 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH V4 0/3] Support more sample rate in asrc
Thread-Topic: [PATCH V4 0/3] Support more sample rate in asrc
Thread-Index: AQHU9pn5d9jujLVToEGbByKQWfr3fg==
Date: Fri, 19 Apr 2019 10:23:46 +0000
Message-ID: <cover.1555669068.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR03CA0082.apcprd03.prod.outlook.com
 (2603:1096:203:72::22) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cc0837b-9a5a-4903-519d-08d6c4b11b3a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6608; 
x-ms-traffictypediagnostic: VE1PR04MB6608:
x-microsoft-antispam-prvs: <VE1PR04MB660877D3B4948E20BAD9EFFAE3270@VE1PR04MB6608.eurprd04.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(376002)(136003)(39860400002)(396003)(189003)(199004)(73956011)(36756003)(4326008)(478600001)(186003)(53936002)(6506007)(25786009)(386003)(68736007)(14454004)(66446008)(5660300002)(64756008)(7736002)(66946007)(6116002)(26005)(102836004)(66476007)(476003)(50226002)(8936002)(2616005)(6436002)(81166006)(86362001)(52116002)(6512007)(486006)(4744005)(305945005)(6486002)(8676002)(54906003)(316002)(81156014)(110136005)(2501003)(2201001)(256004)(97736004)(3846002)(71200400001)(2906002)(66556008)(71190400001)(99286004)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6608;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rJrFTtvDbu7pvQKxpG4XPQ3e9tfHCVu5m4+xDarQ89mw7Rx337vdlt6yvm0ZMrIzwv7BxhRomONPwORYjtur71JLdLtJr3OFvDgpblkAT1eE3nTetbZiY4lCMFSN0ST1qg/G/l2AxH1D5c57D9aZntT4CX/ckivDZxSjX9cv36ngx+XtPfgaan3NOx84K4fmrj/B58rghFbiUAssZh2sM1LPZhCAMLZK6t1MS3tzWdAmoxaBu7Ax2ZLUAz6tHv3Q4N4vXFcRwEXN9xhqzmcj5ehmbmyDF9D+KPZcmjijblqQ1Kn+4BXoh8l/JSWK4pjRfyy0pV8eYQH8wrvNzP0XMacr2SicaYbmMyEdyTYozkXcs79HGTi9LjbyDhgmDkmYFU2aGQ4yU5DYeJmBQoJoGckhWdJAlr/uaLFgbhROkz0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc0837b-9a5a-4903-519d-08d6c4b11b3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 10:23:47.0340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6608
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

U3VwcG9ydCBtb3JlIHNhbXBsZSByYXRlIGluIGFzcmMNCg0KU2hlbmdqaXUgV2FuZyAoMyk6DQog
IEFTb0M6IGZzbF9hc3JjOiBGaXggdGhlIGlzc3VlIGFib3V0IHVuc3VwcG9ydGVkIHJhdGUNCiAg
QVNvQzogZnNsX2FzcmM6IHJlcGxhY2UgdGhlIHByb2Nlc3Nfb3B0aW9uIHRhYmxlIHdpdGggZnVu
Y3Rpb24NCiAgQVNvQzogZnNsX2FzcmM6IFVuaWZ5IHRoZSBzdXBwb3J0ZWQgaW5wdXQgYW5kIG91
dHB1dCByYXRlDQoNCkNoYW5nZXMgaW4gdjQNCi0gYWRkIHBhdGNoIHRvIEZpeCB0aGUgWzhrSHos
IDMwa0h6XSBvcGVuIHNldCBpc3N1ZS4NCg0KQ2hhbmdlcyBpbiB2Mw0KLSByZW1vdmUgRlNMX0FT
UkNfUkFURVMNCi0gcmVmaW5lIGZzbF9hc3JjX3NlbF9wcm9jIGFjY29yZGluZyB0byBjb21tZW50
cw0KDQpDaGFuZ2VzIGluIHYyDQotIGFkZCBtb3JlIGNvbW1lbnRzIGluIGNvZGUNCi0gYWRkIGNv
bW1pdCAiVW5pZnkgdGhlIHN1cHBvcnRlZCBpbnB1dCBhbmQgb3V0cHV0IHJhdGUiDQoNCiBzb3Vu
ZC9zb2MvZnNsL2ZzbF9hc3JjLmMgfCAxMTMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNzcgaW5zZXJ0aW9ucygrKSwgMzYg
ZGVsZXRpb25zKC0pDQoNCi0tIA0KMS45LjENCg0K

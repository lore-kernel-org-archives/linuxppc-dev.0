Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689A3C282E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 04:53:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FE0120859
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 04:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n8v+8HkA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE0120859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nZ3W6g4VzDqS5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 14:53:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.1.44; helo=eur02-he1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="n8v+8HkA"; 
 dkim-atps=neutral
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10044.outbound.protection.outlook.com [40.107.1.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nZ1j5wjwzDqLL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 14:52:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhSthBvzVFYHqyk9+wUYct9EZHtuc34K5U+Ci1a4yvc=;
 b=n8v+8HkAZU3quDgq9uMhh+cLYc8F/2hpao/hae8O0HielCjqdyW42MFaKryJiOrQQTmXRU7E3ec28+CynYiWWDw+K8S1bWDMaxGEWtwYzpZarVfZ7ACZQya+J8rq7Cyh2RpMX0zlv7yZnjI1Gi9Y9eHlcNBL6xSyqGyTHDegF6Y=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Mon, 22 Apr 2019 04:51:59 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 04:51:59 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH V6 0/3] Support more sample rate in asrc
Thread-Topic: [PATCH V6 0/3] Support more sample rate in asrc
Thread-Index: AQHU+MceEhjop0FUhkmtmihIDHeFjw==
Date: Mon, 22 Apr 2019 04:51:58 +0000
Message-ID: <cover.1555908545.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::15) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 145e6134-2e77-4110-b414-08d6c6de4053
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6479; 
x-ms-traffictypediagnostic: VE1PR04MB6479:
x-microsoft-antispam-prvs: <VE1PR04MB6479F28737AB68EDAEB8B8F1E3220@VE1PR04MB6479.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(396003)(39860400002)(136003)(376002)(199004)(189003)(2201001)(486006)(26005)(99286004)(6436002)(5660300002)(186003)(316002)(66066001)(6486002)(86362001)(81156014)(81166006)(8676002)(476003)(2616005)(305945005)(7736002)(8936002)(50226002)(2501003)(97736004)(4744005)(54906003)(3846002)(14454004)(110136005)(4326008)(6512007)(2906002)(68736007)(478600001)(71200400001)(71190400001)(386003)(6506007)(53936002)(66556008)(52116002)(66476007)(256004)(36756003)(64756008)(73956011)(66446008)(66946007)(6116002)(102836004)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6479;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sqkE+/yYw5XoabWucPSfAbt7KhROSnZsUhOxVXdhQqDe+Ll4i+R0oQhe46gL/jyTHoLxMl9KqP0pfGsvXem4WtlcDpxEaCEJyX+uVglgDH+VU3mu9L62mXtkV3NQ1g9wBFlZqTPDGCZ4dBLiIUnSiWB9Ln8uVGm8GHuIrLGPsbx51wkZ161LsJ04xF88p6ljS4qNu7ew1nz9nhhhW0hMSNPGHTx6u0b8tGlUljAhkKlGywxcTd897fKMXRYYIyo7wjOU6uVXFuM7nDkVESFgn1sTbwU0/zu00Gh+a6/YCl5GmPWQK1S+Bny1lbk9jTKzsdT2RRqdM1zXGf1i2W52BDV+U6yEIjbPHZXFFUKgaw7S7wlIxaTY6vOLVC5KjZMcDq9RAGgQrFM9FmOyI0QywCFnimwnX+KnBPbe6kqYKPw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 145e6134-2e77-4110-b414-08d6c6de4053
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 04:51:58.9124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6479
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
dHB1dCByYXRlDQoNCkNoYW5nZXMgaW4gdjYNCi0gYWRkIGFja2VkLWJ5DQotIGZpeGVkIG1pbm9y
IGlzc3VlIGFjY29yZGluZyB0byBjb21tZW50cyBpbiB2NQ0KDQpDaGFuZ2VzIGluIHY1DQotIGZp
eCB0aGUgWzEvMjQsIDhdDQotIG1vdmUgZnNsX2FzcmNfc2VsX3Byb2MgYmVmb3JlIHNldHRpbmcN
Cg0KQ2hhbmdlcyBpbiB2NA0KLSBhZGQgcGF0Y2ggdG8gRml4IHRoZSBbOGtIeiwgMzBrSHpdIG9w
ZW4gc2V0IGlzc3VlLg0KDQpDaGFuZ2VzIGluIHYzDQotIHJlbW92ZSBGU0xfQVNSQ19SQVRFUw0K
LSByZWZpbmUgZnNsX2FzcmNfc2VsX3Byb2MgYWNjb3JkaW5nIHRvIGNvbW1lbnRzDQoNCkNoYW5n
ZXMgaW4gdjINCi0gYWRkIG1vcmUgY29tbWVudHMgaW4gY29kZQ0KLSBhZGQgY29tbWl0ICJVbmlm
eSB0aGUgc3VwcG9ydGVkIGlucHV0IGFuZCBvdXRwdXQgcmF0ZSINCg0KIHNvdW5kL3NvYy9mc2wv
ZnNsX2FzcmMuYyB8IDEwNSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA3MSBpbnNlcnRpb25zKCspLCAzNCBkZWxldGlvbnMo
LSkNCg0KLS0gDQoxLjkuMQ0KDQo=

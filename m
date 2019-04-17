Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF5BC10F12
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 09:07:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D65E206B6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 09:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kSmFRFnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D65E206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kbx82cjFzDqLK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 19:07:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe09::62f;
 helo=eur03-ve1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="kSmFRFnH"; 
 dkim-atps=neutral
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03on062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe09::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kbvL223DzDqKV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 19:06:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KQz5nJ3lv/h5igYk7LwiYON4/LPN1mTx+9eIDXNxvs=;
 b=kSmFRFnHuX+MSfrWPw+muVisqiVZ0iGou2xIVUFFNn+Rwcnj5B0J2R/P4EFdiT1SgilCibKSPdfom/20ZHGnUWzQCMkSpzc5yZSPJFRkE1Lb2bXvW+/mnUmzYbmRcJz7wr0rgDwQszHQuAj5XFw79IY9/zzHOITLcx5zxpuiI+k=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6640.eurprd04.prod.outlook.com (20.179.235.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Wed, 17 Apr 2019 09:06:15 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1792.018; Wed, 17 Apr 2019
 09:06:15 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH V3 0/2] Support more sample rate in asrc
Thread-Topic: [PATCH V3 0/2] Support more sample rate in asrc
Thread-Index: AQHU9PzPzRiVe17/HkeFvsOwAITqUw==
Date: Wed, 17 Apr 2019 09:06:15 +0000
Message-ID: <cover.1555491598.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::27) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c676e5d4-cf2a-4ae4-3c47-08d6c313f1ad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6640; 
x-ms-traffictypediagnostic: VE1PR04MB6640:
x-microsoft-antispam-prvs: <VE1PR04MB664066CE780976F694794499E3250@VE1PR04MB6640.eurprd04.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(39860400002)(366004)(376002)(396003)(136003)(199004)(189003)(54906003)(53936002)(99286004)(110136005)(186003)(102836004)(26005)(6506007)(386003)(8676002)(68736007)(478600001)(81166006)(81156014)(2201001)(50226002)(86362001)(6436002)(8936002)(305945005)(2501003)(6486002)(36756003)(7736002)(14454004)(71190400001)(256004)(105586002)(6116002)(25786009)(71200400001)(6512007)(97736004)(106356001)(5660300002)(4744005)(2616005)(476003)(486006)(316002)(2906002)(3846002)(4326008)(52116002)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6640;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jSYG7Adxvg5onodrMsewT9YvE5mIWiJ8K8N7IwoIAXku+uqQi7Py9O45zAyY54CcuOliupWMAJgwtBlSm0yJV1WdNnH+0SAekaTPoNOnXLv/TOI1FEW4XHxe03fE+wrh+IycejGvyWxhw/S+i/L35HCkaJY60rmk1w9dX9vrcpOjl7zN6IPpb+hytnkuZwOzUEbl0d+fQeX+oh5qUnXe0pdOfjA4SD1iBnk/Sr/r6+9BZxe+/UCpEASWZWovhl1I2YUXD8H97VDz+OQBRLX+WcYBy9YX4eFX3vDSpjZ6ZR+NnhCnbB94FInaZHd/SRww0Q42jjMybPpRJ2OqmpBayNF1CYLxI5U9q/nZZmIIcY9LBOOehgkASC/b38uayCPEmlN6v/u8mQ30ECXsevSPqjCbXZnEYlYHVyqP0VR9iAs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c676e5d4-cf2a-4ae4-3c47-08d6c313f1ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 09:06:15.1775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6640
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
dXRwdXQgcmF0ZQ0KDQpDaGFuZ2VzIGluIHYzDQotIHJlbW92ZSBGU0xfQVNSQ19SQVRFUw0KLSBy
ZWZpbmUgZnNsX2FzcmNfc2VsX3Byb2MgYWNjb3JkaW5nIHRvIGNvbW1lbnRzDQoNCkNoYW5nZXMg
aW4gdjINCi0gYWRkIG1vcmUgY29tbWVudHMgaW4gY29kZQ0KLSBhZGQgY29tbWl0ICJVbmlmeSB0
aGUgc3VwcG9ydGVkIGlucHV0IGFuZCBvdXRwdXQgcmF0ZSINCg0KIHNvdW5kL3NvYy9mc2wvZnNs
X2FzcmMuYyB8IDEwOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA3NiBpbnNlcnRpb25zKCspLCAzMiBkZWxldGlvbnMoLSkN
Cg0KLS0gDQoxLjkuMQ0KDQo=

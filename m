Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47559C10F14
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 02:35:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF03620870
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 02:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZUHAUjAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF03620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nVzq3jQLzDqQF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 12:35:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.7.70; helo=eur04-he1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="ZUHAUjAC"; 
 dkim-atps=neutral
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70070.outbound.protection.outlook.com [40.107.7.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nVwj2JJ6zDqQW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 12:32:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cKIFDOYDzwENsY7MyiZ7xF5Ejo/a7PFgVEVfbzY2CM=;
 b=ZUHAUjACJC8tcSDtuVeKAvX2c8gSiQ/faANP4DxloEuVSAXUyHwCyHrBygQGQ5v+AZVJCSeH6vN5t/794sLrxjRRK1jZlPFrvzb4NFQH+fOh5gebW/9498nNz692nlnnhc+3UH9D9Q9bNwtP7IQIhtP6LXJ3XpXoeYnoZEmGYaM=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6605.eurprd04.prod.outlook.com (20.179.234.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Mon, 22 Apr 2019 02:32:29 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 02:32:29 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH V5 0/3] Support more sample rate in asrc
Thread-Topic: [PATCH V5 0/3] Support more sample rate in asrc
Thread-Index: AQHU+LOhK8xjrEeaaUu/ufFIO3+/bg==
Date: Mon, 22 Apr 2019 02:32:29 +0000
Message-ID: <cover.1555900078.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0P153CA0044.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::32) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5668f8ae-fb18-466e-1e62-08d6c6cac3b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6605; 
x-ms-traffictypediagnostic: VE1PR04MB6605:
x-microsoft-antispam-prvs: <VE1PR04MB6605A1E3687BA0D928E8AA06E3220@VE1PR04MB6605.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(346002)(376002)(366004)(39860400002)(396003)(199004)(189003)(316002)(4326008)(36756003)(68736007)(256004)(25786009)(14454004)(2201001)(478600001)(8936002)(4744005)(50226002)(97736004)(7736002)(6116002)(3846002)(6436002)(81156014)(305945005)(8676002)(81166006)(186003)(2501003)(73956011)(66066001)(66446008)(6486002)(66946007)(66476007)(66556008)(64756008)(26005)(386003)(5660300002)(6506007)(102836004)(2906002)(99286004)(52116002)(486006)(110136005)(86362001)(54906003)(71190400001)(71200400001)(476003)(2616005)(6512007)(53936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6605;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tQcoWcxdd/cJerb5ENrPmpFqDxKyVijGa3jeierl29I01ddpVlu+4ORE6k1eSmYrVxoeg8lQiQ1hUnv0PjmHC9H5Z90TSn8qJoXw5FtMZTqCASXBKLn9btFHBocJOWH/73B4GdEEu1YXioa87O6etdPl8IlzvvOwFsxudKDLpAYbG19UtvuqKWLFxqijvP6G5uOUKMnRv9Dtt10GUkAhMWKrygqYY3oJ5Ux0b4pVaXNtQ/tNykDzMsODJmtOSbvN4JpzDBnXx0BilQwCS2cU7pz7u1mMkvUJvkmWG1k6qerdeGw4hm/OX1+4in0oWTEdBqNpAz4iu8zIjB2V2waZUpO0Lz3FuJQXKAqn9KDTAPEjUxHNzxUsP6lEUkrVql3RKPNRAsDTVKXzdGszAjm1f3OBES88X1c8B957in9QMks=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5668f8ae-fb18-466e-1e62-08d6c6cac3b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 02:32:29.2465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6605
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
dHB1dCByYXRlDQoNCkNoYW5nZXMgaW4gdjUNCi0gZml4IHRoZSBbMS8yNCwgOF0NCi0gbW92ZSBm
c2xfYXNyY19zZWxfcHJvYyBiZWZvcmUgc2V0dGluZw0KDQpDaGFuZ2VzIGluIHY0DQotIGFkZCBw
YXRjaCB0byBGaXggdGhlIFs4a0h6LCAzMGtIel0gb3BlbiBzZXQgaXNzdWUuDQoNCkNoYW5nZXMg
aW4gdjMNCi0gcmVtb3ZlIEZTTF9BU1JDX1JBVEVTDQotIHJlZmluZSBmc2xfYXNyY19zZWxfcHJv
YyBhY2NvcmRpbmcgdG8gY29tbWVudHMNCg0KQ2hhbmdlcyBpbiB2Mg0KLSBhZGQgbW9yZSBjb21t
ZW50cyBpbiBjb2RlDQotIGFkZCBjb21taXQgIlVuaWZ5IHRoZSBzdXBwb3J0ZWQgaW5wdXQgYW5k
IG91dHB1dCByYXRlIg0KDQogc291bmQvc29jL2ZzbC9mc2xfYXNyYy5jIHwgMTA0ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQs
IDcwIGluc2VydGlvbnMoKyksIDM0IGRlbGV0aW9ucygtKQ0KDQotLSANCjEuOS4xDQoNCg==

Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2718BC10F14
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 02:36:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9215C20859
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 02:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VM09vjos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9215C20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nW1X2BDPzDqRZ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 12:36:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.7.70; helo=eur04-he1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="VM09vjos"; 
 dkim-atps=neutral
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70070.outbound.protection.outlook.com [40.107.7.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nVwk1mHZzDqP9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 12:32:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwbeTDsH6BTbG3HIzJlPB5h2pc1WpbJrczHP1UiabwI=;
 b=VM09vjosqtiKAPTnpZPkKS+V5gkmYD+lYpJURBuyxBS/VRMryxqwOw3NhUBv7+yEHi4SfERQcNbEn30/irQtNvvQeEhJFKhpWV+LMs2cCIbXDQ/mRLgzHgbZudaryxvf3KG2exvNU62YhHiwNJSDze5NHPjUAsGD2xi95olVCbs=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6605.eurprd04.prod.outlook.com (20.179.234.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Mon, 22 Apr 2019 02:32:32 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 02:32:32 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH V5 1/3] ASoC: fsl_asrc: Fix the issue about unsupported rate
Thread-Topic: [PATCH V5 1/3] ASoC: fsl_asrc: Fix the issue about unsupported
 rate
Thread-Index: AQHU+LOjoU/1Ne74bEeGRdrWXzdVvw==
Date: Mon, 22 Apr 2019 02:32:32 +0000
Message-ID: <a74fe1798ef8f473e11f5e39452664b5e80515df.1555900078.git.shengjiu.wang@nxp.com>
References: <cover.1555900078.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1555900078.git.shengjiu.wang@nxp.com>
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
x-ms-office365-filtering-correlation-id: ea4b1e3d-87bf-4272-e4d8-08d6c6cac59b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6605; 
x-ms-traffictypediagnostic: VE1PR04MB6605:
x-microsoft-antispam-prvs: <VE1PR04MB6605999C356F00618F5EB5CCE3220@VE1PR04MB6605.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(346002)(376002)(366004)(39860400002)(396003)(199004)(189003)(316002)(4326008)(36756003)(68736007)(14444005)(256004)(25786009)(14454004)(2201001)(478600001)(8936002)(50226002)(97736004)(7736002)(6116002)(3846002)(11346002)(446003)(6436002)(81156014)(305945005)(8676002)(81166006)(186003)(2501003)(73956011)(66066001)(66446008)(6486002)(66946007)(66476007)(66556008)(64756008)(26005)(386003)(5660300002)(76176011)(6506007)(102836004)(2906002)(118296001)(99286004)(52116002)(486006)(110136005)(86362001)(54906003)(71190400001)(71200400001)(476003)(2616005)(6512007)(53936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6605;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Sg04pgzxKg1SCHpeXsAO4tu0Dljbs/rs4o/LLZWK5xJNXAzzqHKEg445hNWgzkE/BIFa9n81e/ND1qF0z/94OqmQ1Dp3ovY5FcxXshvAnBorxTiVlOai67mzmUEcz1jFYSUz95/c+rGvKvkLc5Vk9bU3pyFMs0eLKP/AusB9KWG5nTspOK8yH05xEUSSzI1yyR7Qdp7l3W5PtwBhDc5b8Xl1DA3MECjX5OU7dCVDUURfSlArdV7gfQyi+WTem0dsgm7jlViV3GdP1wXNlHmWsWY2fK1fBkOJv1Kb66ZRx/rpk25BCcA+BA9JhCTyzMov1y5CTowMhT3LQfIcZbMRI0S7uMUKdYTgMDfiU+LwTelRynb+KHirDhFDJ8n4+LE+mWn5i0hd2yZjU/sULOIc2IbVhryKDoPHYT8oBxXYhZ8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4b1e3d-87bf-4272-e4d8-08d6c6cac59b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 02:32:32.5148 (UTC)
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

V2hlbiB0aGUgb3V0cHV0IHNhbXBsZSByYXRlIGlzIFs4a0h6LCAzMGtIel0sIHRoZSBsaW1pdGF0
aW9uDQpvZiB0aGUgc3VwcG9ydGVkIHJhdGlvIHJhbmdlIGlzICgxLzI0LCA4KS4gSW4gdGhlIGRy
aXZlcg0Kd2UgdXNlICg4a0h6LCAzMGtIeikgaW5zdGVhZCBvZiBbOGtIeiwgMzBrSHpdLg0KU28g
dGhpcyBwYXRjaCBpcyB0byBmaXggdGhpcyBpc3N1ZSBhbmQgdGhlIHBvdGVudGlhbCByb3VuZGlu
Zw0KaXNzdWUgd2l0aCBkaXZpZGVyLg0KDQpGaXhlczogZmZmNmUwM2M3YjY1ICgiQVNvQzogZnNs
X2FzcmM6IGFkZCBzdXBwb3J0IGZvciA4LTMwa0h6DQpvdXRwdXQgc2FtcGxlIHJhdGUiKQ0KQ2M6
IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPg0KU2lnbmVkLW9mZi1ieTogU2hlbmdqaXUgV2FuZyA8
c2hlbmdqaXUud2FuZ0BueHAuY29tPg0KLS0tDQogc291bmQvc29jL2ZzbC9mc2xfYXNyYy5jIHwg
NCArKy0tDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9mc2wvZnNsX2FzcmMuYyBiL3NvdW5kL3NvYy9mc2wv
ZnNsX2FzcmMuYw0KaW5kZXggMGI5Mzc5MjRkMmU0Li5lYTAzNWMxMmEzMjUgMTAwNjQ0DQotLS0g
YS9zb3VuZC9zb2MvZnNsL2ZzbF9hc3JjLmMNCisrKyBiL3NvdW5kL3NvYy9mc2wvZnNsX2FzcmMu
Yw0KQEAgLTI4Miw4ICsyODIsOCBAQCBzdGF0aWMgaW50IGZzbF9hc3JjX2NvbmZpZ19wYWlyKHN0
cnVjdCBmc2xfYXNyY19wYWlyICpwYWlyKQ0KIAkJcmV0dXJuIC1FSU5WQUw7DQogCX0NCiANCi0J
aWYgKChvdXRyYXRlID4gODAwMCAmJiBvdXRyYXRlIDwgMzAwMDApICYmDQotCSAgICAob3V0cmF0
ZS9pbnJhdGUgPiAyNCB8fCBpbnJhdGUvb3V0cmF0ZSA+IDgpKSB7DQorCWlmICgob3V0cmF0ZSA+
PSA4MDAwICYmIG91dHJhdGUgPD0gMzAwMDApICYmDQorCSAgICAob3V0cmF0ZSA+IDI0ICogaW5y
YXRlIHx8IGlucmF0ZSA+IDggKiBvdXRyYXRlKSkgew0KIAkJcGFpcl9lcnIoImV4Y2VlZCBzdXBw
b3J0ZWQgcmF0aW8gcmFuZ2UgWzEvMjQsIDhdIGZvciBcDQogCQkJCWlucmF0ZS9vdXRyYXRlOiAl
ZC8lZFxuIiwgaW5yYXRlLCBvdXRyYXRlKTsNCiAJCXJldHVybiAtRUlOVkFMOw0KLS0gDQoxLjku
MQ0KDQo=

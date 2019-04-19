Return-Path: <SRS0=ts8b=SV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CADC282DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 10:27:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3A3E218EA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 10:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mUu9NprF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A3E218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lsbv428XzDq7W
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 20:27:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.13.89; helo=eur01-he1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="mUu9NprF"; 
 dkim-atps=neutral
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr130089.outbound.protection.outlook.com [40.107.13.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lsWx2dJtzDqFH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 20:23:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ex5LDqtSiyT4onlDL7EXqp16fNxNfTCERUiO3AGXePU=;
 b=mUu9NprFJpUPJB/Rf/HtjIgXLk8FYCJ9MmszmYuu4hbz7pBChTgpTEnB8pgFr+SNj1y0Ig1nYxZXi2STZOiJK/2VqekMK77k2P1otSWnKq8hv2rlxnpBFcMh006CcmQsFT9ARWqxIavyeSG4Dv3rc94whU3HN+Y0XRGAoZhssy0=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6349.eurprd04.prod.outlook.com (10.255.118.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Fri, 19 Apr 2019 10:23:50 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1813.013; Fri, 19 Apr 2019
 10:23:50 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH V4 1/3] ASoC: fsl_asrc: Fix the issue about unsupported rate
Thread-Topic: [PATCH V4 1/3] ASoC: fsl_asrc: Fix the issue about unsupported
 rate
Thread-Index: AQHU9pn6besxYMR+kU6PSL+q5hShdA==
Date: Fri, 19 Apr 2019 10:23:50 +0000
Message-ID: <06c3e420b9fabfbec67becc2f9de009ce79a1d4b.1555669068.git.shengjiu.wang@nxp.com>
References: <cover.1555669068.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1555669068.git.shengjiu.wang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 8bbf9e3b-d2a7-421d-bfe6-08d6c4b11d1f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6349; 
x-ms-traffictypediagnostic: VE1PR04MB6349:
x-microsoft-antispam-prvs: <VE1PR04MB6349858F787714D60CBDF197E3270@VE1PR04MB6349.eurprd04.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(376002)(136003)(366004)(346002)(189003)(199004)(97736004)(73956011)(25786009)(26005)(2501003)(2906002)(71190400001)(478600001)(7736002)(102836004)(2201001)(71200400001)(256004)(6506007)(386003)(14444005)(52116002)(53936002)(99286004)(66446008)(68736007)(66066001)(66476007)(64756008)(66556008)(3846002)(6116002)(86362001)(6436002)(6512007)(6486002)(76176011)(186003)(2616005)(316002)(54906003)(476003)(4326008)(486006)(5660300002)(8676002)(36756003)(81156014)(81166006)(118296001)(11346002)(110136005)(446003)(305945005)(14454004)(8936002)(50226002)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6349;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: l0S+oLPutAwcLYbSSYjPKmm1I+IQ0N9jmny2yzRsZsbUJi++x3sYHeecpAgMTK2+BhCrYEuPYGzFhlm0P0IszP1y8ga5rc7lnjzeVT3HFhZa1i74Ai6No6egVdbIfNZOGXz71qzPGdc15nSuzjdmAVyxM0jZ5tI3K3xikml6utFy3WjJXMYfetYN0mEDk13b9ZXUQH0uz6M98/rLK/f3FJlj4lMTLeyE2Is+KWj+mD6V54fUaQibsU28c/fU+ghZwRFplhmfX0jk5+WCdAUnbysF85n0T67zZ/MTaOA31/mt9MDlR8RhOmg/0Vuv66leGzK3bYRCjZPwkqsQ1xgTc/am7IRqOvW4mMrtH53xXtAc5N9lnzzzhGFi7HO6ApOWsW9KNBxJMlUzB5X4oFZKk16SkuGCU+TZlPZEKt1LRFs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbf9e3b-d2a7-421d-bfe6-08d6c4b11d1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 10:23:50.2103 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6349
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
OCArKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvZnNsL2ZzbF9hc3JjLmMgYi9zb3VuZC9zb2Mv
ZnNsL2ZzbF9hc3JjLmMNCmluZGV4IDBiOTM3OTI0ZDJlNC4uNWI4YWRjN2ZiMTE3IDEwMDY0NA0K
LS0tIGEvc291bmQvc29jL2ZzbC9mc2xfYXNyYy5jDQorKysgYi9zb3VuZC9zb2MvZnNsL2ZzbF9h
c3JjLmMNCkBAIC0yODIsMTAgKzI4MiwxMCBAQCBzdGF0aWMgaW50IGZzbF9hc3JjX2NvbmZpZ19w
YWlyKHN0cnVjdCBmc2xfYXNyY19wYWlyICpwYWlyKQ0KIAkJcmV0dXJuIC1FSU5WQUw7DQogCX0N
CiANCi0JaWYgKChvdXRyYXRlID4gODAwMCAmJiBvdXRyYXRlIDwgMzAwMDApICYmDQotCSAgICAo
b3V0cmF0ZS9pbnJhdGUgPiAyNCB8fCBpbnJhdGUvb3V0cmF0ZSA+IDgpKSB7DQotCQlwYWlyX2Vy
cigiZXhjZWVkIHN1cHBvcnRlZCByYXRpbyByYW5nZSBbMS8yNCwgOF0gZm9yIFwNCi0JCQkJaW5y
YXRlL291dHJhdGU6ICVkLyVkXG4iLCBpbnJhdGUsIG91dHJhdGUpOw0KKwlpZiAoKG91dHJhdGUg
Pj0gODAwMCAmJiBvdXRyYXRlIDw9IDMwMDAwKSAmJg0KKwkgICAgKG91dHJhdGUgPiAyNCAqIGlu
cmF0ZSB8fCBpbnJhdGUgPiA4ICogb3V0cmF0ZSkpIHsNCisJCXBhaXJfZXJyKCJleGNlZWQgc3Vw
cG9ydGVkIHJhdGlvIHJhbmdlICgxLzI0LCA4KSBmb3IgaW5yYXRlL291dHJhdGU6ICVkLyVkXG4i
LA0KKwkJCQlpbnJhdGUsIG91dHJhdGUpOw0KIAkJcmV0dXJuIC1FSU5WQUw7DQogCX0NCiANCi0t
IA0KMS45LjENCg0K

Return-Path: <SRS0=K0D4=SW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D32C282DD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 16:01:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 736B220651
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 16:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QJutH1Y7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736B220651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44mcyT2FnpzDqT4
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 02:01:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.81; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=daniel.baluta@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="QJutH1Y7"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00081.outbound.protection.outlook.com [40.107.0.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44mcwL4XmLzDqJ2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Apr 2019 01:59:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8djsVwsK7GA4GAiLcpNs5A79k2pP46JKRD8JuVtCYaQ=;
 b=QJutH1Y75A/f8gqfP3w2xngHi9iDRSJpgnYr538UtAoCnJPfVgA6K8BzVEBDxtYNPsD7lvvNBGO5lCmQcBgyShUusYjOlbnSoO414v/vechIXi5ag/GW256azue+7ZPtnSYnfJlVYYa4EVeoEwA5RWfEaz9d4wkh5/V/+S51qbg=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2783.eurprd04.prod.outlook.com (10.172.255.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.11; Sat, 20 Apr 2019 15:59:03 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6%6]) with mapi id 15.20.1813.017; Sat, 20 Apr 2019
 15:59:03 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Subject: [PATCH 0/2] Add runtime PM for SAI digital audio interface
Thread-Topic: [PATCH 0/2] Add runtime PM for SAI digital audio interface
Thread-Index: AQHU95H5uZtN45Q2tkG/h29ljYVulg==
Date: Sat, 20 Apr 2019 15:59:03 +0000
Message-ID: <20190420155846.10027-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VE1PR03CA0042.eurprd03.prod.outlook.com
 (2603:10a6:803:118::31) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d290f14-7fd3-4e3f-5e7c-08d6c5a91c0c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR0402MB2783; 
x-ms-traffictypediagnostic: VI1PR0402MB2783:
x-microsoft-antispam-prvs: <VI1PR0402MB2783551A01EC50CCD56DEFFDF9200@VI1PR0402MB2783.eurprd04.prod.outlook.com>
x-forefront-prvs: 0013079544
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(396003)(376002)(39860400002)(136003)(366004)(199004)(189003)(54906003)(99286004)(73956011)(68736007)(7736002)(5640700003)(6116002)(3846002)(6512007)(305945005)(2906002)(2351001)(102836004)(386003)(6506007)(53936002)(2616005)(186003)(486006)(52116002)(26005)(476003)(71200400001)(97736004)(5660300002)(6436002)(66556008)(2501003)(66066001)(256004)(44832011)(66946007)(64756008)(36756003)(71190400001)(81156014)(81166006)(8676002)(316002)(66476007)(478600001)(1730700003)(6916009)(1076003)(14454004)(4744005)(8936002)(86362001)(25786009)(66446008)(7416002)(4326008)(6486002)(50226002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2783;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PgoHM67MRe8bwgE3TNd/gvyzdrzbznsFvaSLW8qyrZTB/biVrYItYTg7VQV4qlNXE1G2fHjqcffrMFRwzB5ay9SY82ELRn7m1RqysFEvxjTzDsuhnbScAmovlg6PEejnrwbcYr3EEh+e99vUb4vXTH8ViT/NIL7S6/1hcXX32QMEgERPvOPGr2HY4q5ILqfLiQP+TnjEzPdagqmYfcA1PGURgp7XXa5epROSC7uxmeZsMKyxN1l03LWSgIDoCg3686+VGKcrz1NncGJweFIE2w9i/EylFX9vswYI53oM2cM2jvN26KyouUJxOvNb4UUE6ZFPIEHP3XCKlPbO/pyfMWmdLe2x4se7NCcu1QL7VCpkYonw/mVEbURuXm+VNtmeJrQt/h9b0lmgB0B/JQE2haXqSI4goRSuh3w4JvrnzdY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d290f14-7fd3-4e3f-5e7c-08d6c5a91c0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2019 15:59:03.5014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2783
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

Rmlyc3QgcGF0Y2ggdXNlcyBzeXN0ZW0gUE0gaGFuZGxlcnMgdG8gaW1wbGVtZW50IHJ1bnRpbWUg
UE0uIFdoaWxlDQp0aGUgc2Vjb25kIHBhdGNoIG1vdmVzIGNsb2NrIGhhbmRsaW5nIGZyb20gc3Rh
cnR1cC9zaHV0ZG93biB0byBydW50aW1lDQpQTSBoYW5kbGVycy4NCg0KRGFuaWVsIEJhbHV0YSAo
MSk6DQogIEFTb0M6IGZzbDogc2FpOiBBZGQgc3VwcG9ydCBmb3IgcnVudGltZSBwbQ0KDQpTaGVu
Z2ppdSBXYW5nICgxKToNCiAgQVNvQzogZnNsOiBNb3ZlIGNsb2NrIG9wZXJhdGlvbiB0byBQTSBy
dW50aW1lDQoNCiBzb3VuZC9zb2MvZnNsL2ZzbF9zYWkuYyB8IDcwICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDU1IGluc2VydGlvbnMo
KyksIDE1IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMTcuMQ0KDQo=

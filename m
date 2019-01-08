Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E82C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 13:19:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 103E3206B6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 13:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="v+frlK1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103E3206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YtCQ3w3DzDqLR
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 00:19:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.15.81; helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="v+frlK1X"; 
 dkim-atps=neutral
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150081.outbound.protection.outlook.com [40.107.15.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YsvX3LQdzDqTg
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 00:06:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77t1vH/WB//a1JY44bOGY4V+HNVgcZ1IJaSXQy/VJmk=;
 b=v+frlK1XEU5jjoKaY6LL8ueM8g46UKk4OhOBQu4kCttWCsllGjNf6PjNOld24RUHP55VXxgerQL5xbxjxVz1ANSAesjzWlAmtgCtAKBNUA+wCyCLRRAc8GIjJxGnv6tlPt4x34gtFm5lr9A6To3SmcnnG6RAeY4nzA7rxYVhDE4=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB6240.eurprd04.prod.outlook.com (20.179.24.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Tue, 8 Jan 2019 13:05:51 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::ad47:75b9:3ed8:51f0]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::ad47:75b9:3ed8:51f0%6]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 13:05:51 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi
 <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li
 <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Viorel Suman
 <viorel.suman@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta
 <daniel.baluta@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH v2 4/4] ASoC: add imx-audmix DT binding documentation
Thread-Topic: [PATCH v2 4/4] ASoC: add imx-audmix DT binding documentation
Thread-Index: AQHUp1LhnviDDK/AlkOS64n5/1avTg==
Date: Tue, 8 Jan 2019 13:05:51 +0000
Message-ID: <1546952716-2743-5-git-send-email-viorel.suman@nxp.com>
References: <1546952716-2743-1-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1546952716-2743-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P192CA0107.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::48) To VI1PR04MB4704.eurprd04.prod.outlook.com
 (2603:10a6:803:52::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB6240;
 6:mohSN8ZnhzxzBkPrCpgFQFV+joycPcs3LmS9ibAKgQizzqnMpTxVVLzFVGaAMIqmOqNLdl5uscsjz79FrLz/kxXJTdyUh5AIUKjDMb9Aop5PvZjIPHPeYyauZnj7tEE9smepv17bWcM4+ipxF58KDT9uUYjaIW7sjdTrq9rlFVdwkFCO8PPxjsZKIFpe+gXAXt1XDCqvTkSZDeZqaeMbmzFMN9ZCrRA/neckGSL7TtBRSBfR9tdZ3cqioYPRXqvWen8kDbxiAe1KB5u4bGYimYNwlhGwLqPz3M4QlrSB5F4HrTo9mFUXLTJynpspvkTmGVTE0UBzxKgtRoV+OLcX6Tl8SPH8Due+938UEbCMA+6bZcbrinmFDG6AL9mOvKXlRzJRoeX8a0hDeKDXgXZFuVU9qD8UPVvFycNxhNXk2K30cbv33kcXLJ9uTYQPkk41aMys5mM/wd5C6mSdMYkI2Q==;
 5:zce599Gwcit2fRdxbZT72lOixvcZNNwHl22Sa1Eh/9zMdIS7xeXIfKs0zHktAaTzWG4a1ZLbIeehAcPhOgppUMlS+rTzfrMgIAnOJIhGtdzZXH2g9y1rZkYWPU76OOY0VY+Hmjxje0UG3ivufpUj+YgVTzdoWuOo3QIbrVObsVTKYawyGQsFEnAxIE4M8ryhtIk1TaeW8sA0U0kggKDzxw==;
 7:eEdcs3KMlC87ygZMlLX+PbIUm1zOjeUqlMOWB+TquFuFY691AAOyvk4OPEDsNysAWbVbwg8FzulBUFTup0us0QbCXjFSF3PTVDbUiHrW3lUiqeSdJD3Mq4rt4z2ZwH4PVnYuGrNoXm8s6iyKVQN/HQ==
x-ms-office365-filtering-correlation-id: 11831838-c86d-42f6-9a96-08d6756a03ae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB6240; 
x-ms-traffictypediagnostic: VI1PR04MB6240:
x-microsoft-antispam-prvs: <VI1PR04MB624076C5D78F5B1FC7A8F091928A0@VI1PR04MB6240.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB6240; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB6240; 
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(189003)(2906002)(7736002)(106356001)(39060400002)(256004)(305945005)(81166006)(4326008)(6486002)(6636002)(25786009)(6436002)(105586002)(8676002)(36756003)(71200400001)(71190400001)(99286004)(486006)(54906003)(110136005)(316002)(81156014)(44832011)(66066001)(5660300001)(478600001)(68736007)(6512007)(2616005)(476003)(50226002)(11346002)(446003)(53936002)(386003)(6506007)(97736004)(52116002)(102836004)(14454004)(86362001)(76176011)(6116002)(8936002)(26005)(7416002)(3846002)(186003)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB6240;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QZa0pH1UoaHGY3rL6DU3cVWFl3sTOwMqH3h3yzE1Be1FbKtrdxFBEcNyN5Pu/5NaRByctwrqk5jtzkMtcxtLOz3MRHN/50KdvR2oriWJMYzejKJbhUHZ3fdqvQVFaxq7OtrJmOfwk5jrs8c1WvhAfXk5RwcJlT7Hkz7755BOU3NdT4hbcH/gk4xHXe269Qun9BxW5tnj4ddC5dkLH3l97+0bOxJcS/VCT8Qprc0hryNivrZrCISvUbVgbbaOFG1uc768QgPgn/YeVSp/MDCfb3sCf8VS7m3ifdpcZ79PIY3SPREhHiHUkznvqkFDkoVx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11831838-c86d-42f6-9a96-08d6756a03ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 13:05:49.4181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6240
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Viorel Suman <viorel.suman@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add the DT binding documentation for Audio Mixer
machine driver.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../devicetree/bindings/sound/imx-audmix.txt       | 24 ++++++++++++++++++=
++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audmix.txt

diff --git a/Documentation/devicetree/bindings/sound/imx-audmix.txt b/Docum=
entation/devicetree/bindings/sound/imx-audmix.txt
new file mode 100644
index 0000000..6ac1230
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/imx-audmix.txt
@@ -0,0 +1,24 @@
+NXP Audio Mixer (AUDMIX) machine driver.
+
+Required properties:
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+  - compatible		: Compatible list, contains "fsl,imx-audmix"
+
+  - model		: Short audio card description.
+
+  - dais		: Must contain a list of phandles to AUDMIX connected
+			  DAIs. The current implementation requires two phandles
+			  to SAI interfaces to be provided, the first SAI in the
+			  list being used to route the AUDMIX output.
+
+  - audmix-controller	: Must contain the phandle to the AUDMIX device node=
.
+
+Machine driver configuration example:
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+  sound-audmix-sai {
+    compatible =3D "fsl,imx-audmix";
+    model =3D "audmix-sai";
+    dais =3D <&sai4>, <&sai5>;
+    audmix-controller =3D <&audmix>;
+  };
+
--=20
2.7.4


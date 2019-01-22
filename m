Return-Path: <SRS0=/GF9=P6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890DFC282C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 11:20:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 030362084A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 11:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jKS4ppnh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030362084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kQtl6KCGzDqNs
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 22:19:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.1.89; helo=eur02-he1-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="jKS4ppnh"; 
 dkim-atps=neutral
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10089.outbound.protection.outlook.com [40.107.1.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kQmb1gCXzDqLs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 22:14:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnS28n6o47ffcPvZUaToGEjGJJbwyT5bIVkbrJEzdkE=;
 b=jKS4ppnhA804na/bmFNtwDM7xZFO60Suo8p3Rv4bZcFxouhweeuSJ23gJDr3GSRwGCrPBfMngih6/wKL1si4FZq2V7r41j5T5lMojnEHGK3ZakIx8C2WRiR1gk+YgVtQotW/m+cRWD8Pa8UVPrZdG8lGpk3ngGGusIq0lh7K13c=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB5789.eurprd04.prod.outlook.com (20.178.127.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.31; Tue, 22 Jan 2019 11:14:24 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::e58a:8812:d380:2080]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::e58a:8812:d380:2080%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 11:14:24 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi
 <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li
 <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Viorel Suman
 <viorel.suman@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta
 <daniel.baluta@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH v4 0/3] Add NXP AUDMIX device and machine drivers
Thread-Topic: [PATCH v4 0/3] Add NXP AUDMIX device and machine drivers
Thread-Index: AQHUskOhrw37GwsRZk+RXOoFXnURvQ==
Date: Tue, 22 Jan 2019 11:14:24 +0000
Message-ID: <1548155654-12985-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR05CA0019.eurprd05.prod.outlook.com
 (2603:10a6:20b:2e::32) To VI1PR04MB4704.eurprd04.prod.outlook.com
 (2603:10a6:803:52::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5789;
 6:A6aKbh/exabvxUMZRUGYZFbTke9SumuWSqNLUmISkXm82CFKOnrmIurnU72zlnn1GvBVeLWJprPsv+/hdC7yfJOFYiUtuHHXDMyJTM1Skp6fADhHdr66T8QMqPBaM0vNX29/+gS7J1yGOJv5L0tahGilGnCM9JTHHDeai6nCWk2e7O32Q16VKjuNIKN9F+ECRljRc/kPlu/D+Rz3wanYfHvYTRENC1bHMPiofM8fxY+J3SArH034frz6t37An8E5uvbtlZMClGXq2z6HIfMGYejecPHDa3yC6+hsVYcac5BemI7cWjojUCwdH7RXwsdKiLi88SrYCkWmkF2tySDATq4xJTcBqj3+FrlHPd0xCtm/Z2HHj7c4+Oaq301ykqDLj/65td/93f9JZBBcXhreWHHnOX7JcJ+eGbtLYLiOqMNPM6eGYbMlC2Syj3/uFoO85snGczxYtkIEH7pOQnCYpQ==;
 5:rYCmZkgN3B1io23Buyq0ybr7XB3Js5e+28fupk484rKlKvLM6tXJphaY/I2UxupEuYI1tvt3ZeNmNgAgj7k4OXWnSDkCszvh1zv/02HQpJHmi3LzqdrzoPki3hSd4a1cmH9zxaTRJPjrr0pqT/sOkP1guGlpGrBVVfdCgkzc+ZEnjyjvFd/Mjy/YbCR8IJFD++ocn3G40NEHGfyrN/FrZA==;
 7:uola8Ssf8nsCIZpqulhvVXGKfwelzC4KaqZWx1Z2TU0TEn2RRE5PTUms/ZMpZx3CVAbmiYe9l+QpeOgYrA4KMopMavTnVT1L9GT8Uxp8M1iuVXg0sZbsxCQmZ/qpiH6ftKoRNKYzxVLhu3eV8gE/ww==
x-ms-office365-filtering-correlation-id: d57cacd9-25b6-4557-2956-08d6805ac3f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5789; 
x-ms-traffictypediagnostic: VI1PR04MB5789:
x-microsoft-antispam-prvs: <VI1PR04MB5789F2EDEA58A000FB4B2E4C92980@VI1PR04MB5789.eurprd04.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(366004)(189003)(199004)(102836004)(386003)(6506007)(2616005)(486006)(52116002)(66066001)(476003)(8936002)(86362001)(71190400001)(305945005)(26005)(7736002)(14454004)(478600001)(71200400001)(25786009)(68736007)(186003)(2906002)(97736004)(53936002)(3846002)(6116002)(4326008)(6636002)(106356001)(6486002)(8676002)(39060400002)(81156014)(54906003)(110136005)(316002)(81166006)(7416002)(99286004)(6436002)(6512007)(44832011)(50226002)(105586002)(36756003)(256004)(217873002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5789;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: su2iRDM/mYmFC3Kr9O0kX3igdS2Io079qnCcX1dPCeTwbVusf7lwsbvAGld8g3+4FQbhjaaPJXs/BDgAn3Didznf8Abnx22Z5GKSUtrLhbtGIUdFs77FjDR7cjUWtgDgjgWIfuO0sx+qT2acssVVnSVloECk4eTiuFBQO2XQD/Rb1+mnQaEA0WemWwqAdYKOjZ6XWhGgVSOB3gk5w65Kg15hxRA3tr85wUZkCSBZGkXZkn1Cj7moFh1/y94uWZFu56hrPTjsfOca4TkGe7PE7ZWIWb3h6yFz1XcNH6vBSQ7fc63+dD+B4uCq3gaE/zwSdLaLDTh47RmCEFRZJFaygXQMKrSEKlK1bJbZ3b2E8y9FXLXlmk/6QgbHyR2gns+6jjM0c6el0gv+lQvruB7G0ErkoljV9eQtDsC81GA3c3I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d57cacd9-25b6-4557-2956-08d6805ac3f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 11:14:22.8840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5789
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

The patchset adds NXP Audio Mixer (AUDMIX) device and machine
drivers and related DT bindings documentation.

Changes since V3:
1. Removed machine driver DT bindings documentation.
2. Trigger machine driver probe from device driver as suggested by Nicolin.

Changes since V2:
1. Moved "dais" node from machine driver DTS node to device driver DTS node
  as suggested by Rob.

Changes since V1:
1. Original patch split into distinct patches for the device driver and
  DT binding documentation.
2. Replaced AMIX with AUDMIX in both code and file names as it looks more
  RM-compliant.
3. Removed polarity control from CPU DAI driver as suggested by Nicolin.
4. Added machine driver and related DT binding documentation.

Viorel Suman (3):
  ASoC: fsl: Add Audio Mixer CPU DAI driver
  ASoC: add fsl_audmix DT binding documentation
  ASoC: fsl: Add Audio Mixer machine driver

 .../devicetree/bindings/sound/fsl,audmix.txt       |  54 ++
 sound/soc/fsl/Kconfig                              |  16 +
 sound/soc/fsl/Makefile                             |   5 +
 sound/soc/fsl/fsl_audmix.c                         | 576 +++++++++++++++++=
++++
 sound/soc/fsl/fsl_audmix.h                         | 102 ++++
 sound/soc/fsl/imx-audmix.c                         | 327 ++++++++++++
 6 files changed, 1080 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt
 create mode 100644 sound/soc/fsl/fsl_audmix.c
 create mode 100644 sound/soc/fsl/fsl_audmix.h
 create mode 100644 sound/soc/fsl/imx-audmix.c

--=20
2.7.4


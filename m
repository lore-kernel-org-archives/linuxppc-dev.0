Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC638C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 13:09:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34422206BB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 13:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s+XhVYaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34422206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Ysz56BfTzDqVY
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 00:09:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe06::62f;
 helo=eur02-ve1-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="s+XhVYaM"; 
 dkim-atps=neutral
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02on062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe06::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YsvN0KX6zDqSl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 00:05:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQt58At7biId47dR9rWTXLwnZordk+E76Auj7mBrhwI=;
 b=s+XhVYaMZoW6CuWV6oR4LiQyQ1pyncGrrqhpzyBGdikAuk/clwL0HO5zsRhgwDikahR2jb7bpXbdbYKK1YGysKC0HQHPoEhV6LatGlR8RqNmH7N0aobsJbTncPvqTf0KWBQfLtI9OAoJA4/LAKUd39IvZiocygxsr0eLvj8gpbw=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB1581.eurprd04.prod.outlook.com (10.164.84.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Tue, 8 Jan 2019 13:05:43 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::ad47:75b9:3ed8:51f0]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::ad47:75b9:3ed8:51f0%6]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 13:05:43 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi
 <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li
 <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Viorel Suman
 <viorel.suman@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta
 <daniel.baluta@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH v2 0/4] Add NXP AUDMIX device and machine drivers
Thread-Topic: [PATCH v2 0/4] Add NXP AUDMIX device and machine drivers
Thread-Index: AQHUp1LcuUHf5VmQrUCyonXZLm1zuw==
Date: Tue, 8 Jan 2019 13:05:43 +0000
Message-ID: <1546952716-2743-1-git-send-email-viorel.suman@nxp.com>
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
x-microsoft-exchange-diagnostics: 1; VI1PR04MB1581;
 6:GGAnMSkrZP7Vg/kuhRnqZuJmu3nM+V6hv5J9cG3CYW4nDVjvVthr8id9Rk6GXV7xR3biFTJJGhpP/l+Q1pAjcMJI5aa6U12YRRQ7vM9LzkZoFYy/WYYVj3Xw4SJCQAaiC/U5iGACL5kf8+2TFbPSC9zQ3GobuHPyO/OAdI+51VcTOv+oqHLGJfO8Zts4ZM+mizI7+9r1PanzYSpA2ClCNKutk4XLgMNfyOxVehUCGp5MbkJCzquILoP59p4Ue2pg5i3D6jY2NTqmbq15wKGa8klBszqZnrQ3MTsDW4TBCKmyZFg4Vm2o6dHYjhEVXb+ej1TQ9hqwJeitTVGKt5c6BtdEBl9UqUNkSrmkxlg/U9FFYKk8Kt/sZzoneEvIV2DsNp1uAqJrJVd9Tkq37QMdzo6xM1u6OmVz58UnEHSxFivXubcz0vhnDuMC2P9tPBHqdNQcWimCVHD07CuN0c8yCw==;
 5:hOfLpColc3jxMsu5DoqhFrqETjxIyDflRAWa9iuzbxAdh+ky4uWxvXxpltc6uXI4y3ussLPj/D+uk4n/oYIT1Qtx1SDcOCXWLt6gf1GrVUCWMtyeyWUtEHgLRg5k/hWYxCigOVgdeHN9hVHLDb/utv0Djfu0cK3ip+iHjWZv2G/NTLvpsaSlo0thIMWCk13h3HGRNqJJWdiH0iCCpUd6hw==;
 7:xGgRURMRfvhl/Lg2YrVPSwYm6S6I3Qct2qfk1rYq+17Q9aBTi2KPw54f8ohiTZu1oM7ACKGkr40FCFBxYK427vlhXAO1XiqzG3k11+arEU5E+0CryjRwh+2xn3i7VQK2EXxqaCfNOVEhKgEEs4HEJQ==
x-ms-office365-filtering-correlation-id: 89a5fc67-1d8b-4d77-85e5-08d67569ff23
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB1581; 
x-ms-traffictypediagnostic: VI1PR04MB1581:
x-microsoft-antispam-prvs: <VI1PR04MB1581071AA8A37B6AEFFC5871928A0@VI1PR04MB1581.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB1581; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB1581; 
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(136003)(376002)(396003)(39860400002)(346002)(189003)(199004)(39060400002)(256004)(3846002)(25786009)(52116002)(386003)(6116002)(86362001)(53936002)(186003)(217873002)(2906002)(71190400001)(476003)(6436002)(4326008)(6486002)(44832011)(8676002)(71200400001)(14454004)(26005)(7736002)(36756003)(305945005)(99286004)(8936002)(106356001)(81156014)(7416002)(105586002)(486006)(2616005)(6636002)(478600001)(54906003)(81166006)(97736004)(102836004)(110136005)(66066001)(6506007)(5660300001)(68736007)(50226002)(316002)(6512007)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB1581;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jwosvEEd70Ac+n/vUrxMaN8ToecrjgxoNZEU5H1BceMza+LtJ/aeCWb6zjox0MCj0giEj0Lsgbmz1JgxS0dxWYOBUcdrsPBj/ZeeIWkLLjcTOF2sC9jcyNI1eH+Pm2w4f3LT+dYKzpL3VMPazi2bTAhiNhbC/b2GwQFYVBR+L97hTrRuQjAROJYY8m0mZ7FNP/YDKWp8MgtP6a9tkhxyt1Ap51UJT9j0UI3h3sGCD32TCsDxf6mH2htDsCJXEZOpKdRlPLUoAA07BsjVgT5+auOiuG5jPycY2m9ayoof3nb+K6kq2ks0C43yBQKw41Ep
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a5fc67-1d8b-4d77-85e5-08d67569ff23
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 13:05:41.8518 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1581
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

Changes since V1:
1. Original patch split into distinct patches for the device driver and
  DT binding documentation.
2. Replaced AMIX with AUDMIX in both code and file names as it looks more
  RM-compliant.
3. Removed polarity control from CPU DAI driver as suggested by Nicolin.
4. Added machine driver and related DT binding documentation.

Viorel Suman (4):
  ASoC: fsl: Add Audio Mixer CPU DAI driver
  ASoC: add fsl_audmix DT binding documentation
  ASoC: fsl: Add Audio Mixer machine driver
  ASoC: add imx-audmix DT binding documentation

 .../devicetree/bindings/sound/fsl,audmix.txt       |  44 ++
 .../devicetree/bindings/sound/imx-audmix.txt       |  24 +
 sound/soc/fsl/Kconfig                              |  16 +
 sound/soc/fsl/Makefile                             |   5 +
 sound/soc/fsl/fsl_audmix.c                         | 551 +++++++++++++++++=
++++
 sound/soc/fsl/fsl_audmix.h                         | 101 ++++
 sound/soc/fsl/imx-audmix.c                         | 328 ++++++++++++
 7 files changed, 1069 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audmix.txt
 create mode 100644 sound/soc/fsl/fsl_audmix.c
 create mode 100644 sound/soc/fsl/fsl_audmix.h
 create mode 100644 sound/soc/fsl/imx-audmix.c

--=20
2.7.4


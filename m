Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC971C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 12:56:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2003720657
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 12:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bwsQG3Vf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2003720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gPGH09h2zDqrW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 23:56:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.15.73; helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="bwsQG3Vf"; 
 dkim-atps=neutral
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150073.outbound.protection.outlook.com [40.107.15.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gP361GsrzDqjp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 23:46:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPQdcSFWDGG5DltDtQKpY+dCtnfUGXYyG78p85vE4XQ=;
 b=bwsQG3VfZ9aNxulwYjKcoP9bV8qrV0EGvcZXvdVDFg9G/wDSZfrHjNvyrYp3Y9UErJY1Fjaw1WnDOctrwpmYJcxIB2aooCkkT2YYcARJKvzgOT/luS2z4+VBggtC37PRMTVHvMQmsga1CfOsF2nzD4PCYIbyAi7i7jRGdfbiafo=
Received: from DB7PR04MB4699.eurprd04.prod.outlook.com (20.176.233.28) by
 DB7PR04MB4410.eurprd04.prod.outlook.com (52.135.137.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Thu, 17 Jan 2019 12:46:25 +0000
Received: from DB7PR04MB4699.eurprd04.prod.outlook.com
 ([fe80::f1a0:618e:40fc:a88c]) by DB7PR04MB4699.eurprd04.prod.outlook.com
 ([fe80::f1a0:618e:40fc:a88c%2]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 12:46:25 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi
 <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li
 <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Viorel Suman
 <viorel.suman@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta
 <daniel.baluta@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH v3 0/4] Add NXP AUDMIX device and machine drivers
Thread-Topic: [PATCH v3 0/4] Add NXP AUDMIX device and machine drivers
Thread-Index: AQHUrmKoQmEVxQazyE68ciNiNCuyvg==
Date: Thu, 17 Jan 2019 12:46:25 +0000
Message-ID: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR05CA0036.eurprd05.prod.outlook.com
 (2603:10a6:20b:2e::49) To DB7PR04MB4699.eurprd04.prod.outlook.com
 (2603:10a6:10:14::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB7PR04MB4410;
 6:CIhUirpiE9n+NmTTvftiHthAm/dHPoHuA6tHipC7fwNQW90qGEIgas/4Mbj3F8dzpGDMiJ7cVofshpbWi1kjDsDzbPL6gwhuVKhzx98awpPraHWIHj5NKm0oToWvpxl6qsa4TeODDlSDId7Xsct4+NXPgERZnw1R8oKeeREOo+sPBedCxqzaYH/Tm1y/dnKLnDF9INDsdSgFMSC1NZ4MfHNu1vBSoz7zrL8vUsDhW9LImyZ1ku1pQELz/CTCUZivxFidh20zvV9U8KJIjVTKWQd4PnCT2XIZxem7er3docRp4YLVuCz30w/r8QhkVZU6pex3SdiXwxrzNny2UlrvZzOt1y1V4Gtmk2d1m6spKAgdm0ZNLrFjIAszRZF5DPvaVshv85+Db7rnSzHituAHOzoAFcj4QJmbjk7Q9TUhLuabwK7qM17yXgsyjEzrjjHeAyzWqAaXvn/+X7+/+hFoqw==;
 5:j5HsomFzPZduEG6vEkH/W1p+PtSSdLg+N/70HpNSyYYIJJgzHJBvAhL0nZ5tZDzqyIBtgsh596VArD2g6m62vreu8LO4dIA5rHaB81WZR+Q4QOm8LgtppPsWo7bQpjYg+FGQmNPVZraV54wmHjcEbNIfXh74t626L0mmSMpTEoH/FMbiolHYEeAxrsZoO+eZChCHEaNO23aMYEJUro863g==;
 7:aaPwpwTyri5JQ3p8nBiAtLEebcaQPfDlR/VpY2Tnxh/uxs6sioGxh7DH0kHTg54K7nW2cnxetlNxyp2iRvhNHi/kYrq3RHWIsKHubTmOuEZqxrPzlZx2I/d5nAZuN9dYpNCVajMj5kAlV75WaiBq3Q==
x-ms-office365-filtering-correlation-id: 8d0797c8-caa2-4e16-424a-08d67c79cae7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB7PR04MB4410; 
x-ms-traffictypediagnostic: DB7PR04MB4410:
x-microsoft-antispam-prvs: <DB7PR04MB4410450AF94FAC3948D8005292830@DB7PR04MB4410.eurprd04.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(366004)(396003)(136003)(346002)(39860400002)(189003)(199004)(6512007)(39060400002)(6116002)(53936002)(3846002)(68736007)(36756003)(66066001)(105586002)(106356001)(14454004)(478600001)(7416002)(486006)(186003)(5660300001)(99286004)(71200400001)(71190400001)(44832011)(386003)(6506007)(102836004)(26005)(2616005)(316002)(256004)(476003)(2906002)(6436002)(6636002)(217873002)(97736004)(86362001)(54906003)(6486002)(110136005)(52116002)(25786009)(81156014)(81166006)(4326008)(8936002)(8676002)(305945005)(50226002)(7736002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR04MB4410;
 H:DB7PR04MB4699.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9C/8KHBw6bViGfxaPHYtTHo6mA+AW//d2e2UL9bco2Uw1sfNZEFMQlhRO57zNv46R3DvaSJWDblPQqQ/QcZ9SXuVQ7ObJC1b1nkPDn8GvrmFIfDPNGbOzBMiskRA55vDE7ZOUKuibq79wNvsMwUZ2PaiN4B+Ma42UKMJlMHb3uEBlr6ClC5j7Jvl01D02xfJDP1hZHWNg/hD/TephiDa3YstcoxY55oaB+zN4aNfkP7pbT+O6nzyGe919XnmVbFDvyikdD87RgsGF1E4yQ+SRt8DTwMAGA1zUoIdt9RMAvpLWvgi/tbB/R2Lkk7O4etTUVKXy8gOv138d93bR4eO+UOBSlmVZhv/eDnzFhtlxt6SivRoeYJdp9ZBMAddtSR+vGLeiuqib7k92wrQvAPVO8v38eW0yVHmLJF16pSHAzo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0797c8-caa2-4e16-424a-08d67c79cae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 12:46:24.0450 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4410
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

Viorel Suman (4):
  ASoC: fsl: Add Audio Mixer CPU DAI driver
  ASoC: add fsl_audmix DT binding documentation
  ASoC: fsl: Add Audio Mixer machine driver
  ASoC: add imx-audmix DT binding documentation

 .../devicetree/bindings/sound/fsl,audmix.txt       |  50 ++
 .../devicetree/bindings/sound/imx-audmix.txt       |  18 +
 sound/soc/fsl/Kconfig                              |  16 +
 sound/soc/fsl/Makefile                             |   5 +
 sound/soc/fsl/fsl_audmix.c                         | 551 +++++++++++++++++=
++++
 sound/soc/fsl/fsl_audmix.h                         | 102 ++++
 sound/soc/fsl/imx-audmix.c                         | 334 +++++++++++++
 7 files changed, 1076 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audmix.txt
 create mode 100644 sound/soc/fsl/fsl_audmix.c
 create mode 100644 sound/soc/fsl/fsl_audmix.h
 create mode 100644 sound/soc/fsl/imx-audmix.c

--=20
2.7.4


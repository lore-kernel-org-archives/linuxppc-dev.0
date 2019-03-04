Return-Path: <SRS0=bgOd=RH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4F0C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 10:38:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B0D206B8
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 10:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SBzzQwnD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B0D206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Cc1d5YJZzDqJ5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 21:38:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.2.64; helo=eur02-ve1-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="SBzzQwnD"; 
 dkim-atps=neutral
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20064.outbound.protection.outlook.com [40.107.2.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Cbzk54NFzDqG8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2019 21:36:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaWLUOXAFc2s49vUjV62Rj8Iw9GxDvXTc/QlUiIb17g=;
 b=SBzzQwnDBl8QvFGJCavMWHFEg638c7VGliQebnCkjEpAWt9KfRWj2oIak4EpfB52/jACL4gMTkicR4zHqorBVWs++dmSyoSVRRWsqS0fKheI+iKZbLer01Ch2MxZsaRS8Ttppd1tOFV0YQKNPBjNaylrGmL8krRZn68kT/Kaf0g=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB6270.eurprd04.prod.outlook.com (20.179.26.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Mon, 4 Mar 2019 10:36:23 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::78ad:1f42:aeff:b22e]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::78ad:1f42:aeff:b22e%4]) with mapi id 15.20.1665.020; Mon, 4 Mar 2019
 10:36:23 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi
 <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li
 <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Viorel Suman
 <viorel.suman@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta
 <daniel.baluta@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH RESEND v5 0/3] Add NXP AUDMIX device and machine drivers
Thread-Topic: [PATCH RESEND v5 0/3] Add NXP AUDMIX device and machine drivers
Thread-Index: AQHU0nYcwuzeOMGUAk69vV2GSiFK1A==
Date: Mon, 4 Mar 2019 10:36:23 +0000
Message-ID: <1551695748-21541-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR01CA0067.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::44) To VI1PR04MB4704.eurprd04.prod.outlook.com
 (2603:10a6:803:52::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc8d75a3-43f1-4a20-6a45-08d6a08d3f3c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB6270; 
x-ms-traffictypediagnostic: VI1PR04MB6270:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB6270;
 23:MTzIBDbCMGoEET/F0KaTQX4dfSaFqApgr5eZeMx?=
 =?iso-8859-1?Q?i+mbTFku05vIgcwvD1ofYU4j3O22qBkDsgVLiNtIKjrqjkDhJQbVZaozUy?=
 =?iso-8859-1?Q?oPeVW1hOkGcJnsCVsRpxneqzSBUdf3oZX4vSRlJCDdttXdWBY26Gb/JWJs?=
 =?iso-8859-1?Q?dSBnvzZoqlZyqjtEkidE88QPGQOQJ2sGOQUdcgjvTFkDxp3ec+/mrXPHGq?=
 =?iso-8859-1?Q?QEqTf4BZupXGNPVPYKtWSYuw7AYESYN5u7LVYet40OkM/hFDEi6yy0q4DA?=
 =?iso-8859-1?Q?rYuNR6fDFl25GotFCvUPEheDbIaIXWU4Q3yrufGuNDXVXGrxXON/+9z3j3?=
 =?iso-8859-1?Q?2UlIRgB5DaU7SpRUgUeHPPON9YJDxkhYlBgBch4GZNF339TXJOEHcX1Jmt?=
 =?iso-8859-1?Q?tzhwHIqTnL4eJRgjvN1YoR51GNK46oDpp/rpXGPLkQ84nXiRnFhDWhi6ai?=
 =?iso-8859-1?Q?8TEDCDvKbYrDIZvBqH5nySjBgVqgASDUcA2N1mDWPnrG+Z9U5nrd9S99G5?=
 =?iso-8859-1?Q?1n3wnl+TdB2lsAWzAHI2ODa2Uitw6AMLRm3DpJfAJGA0j3qbXrHyD9Q9ZE?=
 =?iso-8859-1?Q?J8srvCuMyWj0Qy7DGGpsxlKOclEbUZGnZxPu2DqFpI+yPv4WI8fuonYEib?=
 =?iso-8859-1?Q?vWLccecIa6pGl/3RbGr0Vf9UvHx2V7pAjesN4D0IktB9cQiCBwjKhXl/8D?=
 =?iso-8859-1?Q?53235hmefioaMTJDdCFONw1NRWP+gvc9yB6CqbqzgLh3SA5kW/PqP5UWeq?=
 =?iso-8859-1?Q?FU5V41icnUtnS2w7rErZYPaRicQWS0981wrnQCGOhd/HY/BM0JLOLmanBg?=
 =?iso-8859-1?Q?PAtjv0AKxhA4WC3N+ad6GS4xlN7yDKkPPq3U758E0i+ADwVylQa1oWgkWr?=
 =?iso-8859-1?Q?uff8VGWfu8/mcLcPm+0EQTNddtNzSkjkpFKGRhKHyebJm1KvpUWgpajxmg?=
 =?iso-8859-1?Q?LK1ybWS5ZLw2m1mn66ivNKIUHEFnM3wmMHwG850CW/00yYpwDevlIwDiMW?=
 =?iso-8859-1?Q?H+pWma8VkKaswRhQdL9aPs37seVjCvpigJ67yARQPEK3D6nacSurJz3awz?=
 =?iso-8859-1?Q?dwcDMZB6wGpE3Z0jsbqDVSGDLnnPR2ZHBJhLrzttZbhj08UrDzr2DjX+/u?=
 =?iso-8859-1?Q?2HZi15bU4cDtEi2UKETKLvY/wSnvzbZLEGJM4sgZaNaAt2jVGhyvGWf7hV?=
 =?iso-8859-1?Q?xmUkSD8rE/KemuYSCmM6UvUtcmGDBTaFw7vj+KlyAB4lc2QUCttYHM0Lae?=
 =?iso-8859-1?Q?ZWQkdIAbXoeQXlXtPkMklttMFFSaHhygwS1bozQ=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB6270BE50BECC135A4B3E48F492710@VI1PR04MB6270.eurprd04.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(189003)(199004)(186003)(26005)(81156014)(81166006)(8676002)(52116002)(102836004)(66066001)(2906002)(105586002)(386003)(6506007)(106356001)(478600001)(86362001)(305945005)(7736002)(99286004)(256004)(2616005)(486006)(44832011)(476003)(316002)(97736004)(6116002)(3846002)(36756003)(4326008)(8936002)(50226002)(68736007)(54906003)(110136005)(14454004)(71200400001)(6436002)(6486002)(53936002)(25786009)(6512007)(71190400001)(5660300002)(7416002)(6636002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB6270;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FcAq6+VwGIFCbcXf2XYiBxx+OLkPiiMtl9Bm56YRf0+v24oPhPQplZSI41mlfEoA0IWCpJaK7LhTwPKjWP/LrwzMRMxlDRK1lV0+a4lmU0WkLkyUoxXsHe65qSk0CIIqXpoZ+R9QBcW2OTYvuTxsmV7H8saI7NmGLqZEIDWJebbGZjmAkW5EfoGasfgkBjvrb4vUVfOK7JL/nFvwKDT7aIVDDyhTaDPDli0O5a3pGLaOJ5lRGkotLIIljqAT7rfh+zVs1y7KHQQbNeVypSxIV4h4J8VK2+N2yWXK1FtxcotBvzHz+GZ0J8azEVxFfnDIfslNCSmh10Li5NpLEym3YjMXIWYshPL/aznsQtinPvM8CqBh3fWCSsO5pqXnDGqjwWYqFUKzOa0/jhR7QwGWKUwR7KLohlT+vtucw6+ViXk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8d75a3-43f1-4a20-6a45-08d6a08d3f3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 10:36:23.4472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6270
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

Changes since V4:
1. Removed "model" attribute from device driver DT bindings documentation
   as suggested by Nicolin.

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

 .../devicetree/bindings/sound/fsl,audmix.txt       |  50 ++
 sound/soc/fsl/Kconfig                              |  16 +
 sound/soc/fsl/Makefile                             |   5 +
 sound/soc/fsl/fsl_audmix.c                         | 578 +++++++++++++++++=
++++
 sound/soc/fsl/fsl_audmix.h                         | 102 ++++
 sound/soc/fsl/imx-audmix.c                         | 327 ++++++++++++
 6 files changed, 1078 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt
 create mode 100644 sound/soc/fsl/fsl_audmix.c
 create mode 100644 sound/soc/fsl/fsl_audmix.h
 create mode 100644 sound/soc/fsl/imx-audmix.c

--=20
2.7.4


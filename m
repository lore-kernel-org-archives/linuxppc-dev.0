Return-Path: <SRS0=bgOd=RH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1133AC10F03
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 10:40:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E4521019
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 10:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fXlgHCTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E4521019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Cc3q2WhszDqHk
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 21:40:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.2.64; helo=eur02-ve1-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="fXlgHCTV"; 
 dkim-atps=neutral
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20064.outbound.protection.outlook.com [40.107.2.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Cbzn48mhzDqG8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2019 21:36:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZbVhLM8pO0Bcpn0qhzIqtJnzN+niu/K/E74MTKSO54=;
 b=fXlgHCTVbpX5ws5oX+OOdFK7SxkQb4+iXTu5wqtHynxdzi9pHR9qgPF+WlJKyPfTqBY1xRF03mqM8olKfiPnv3AGLsMI0iUsYDtP6JM2bKBs3wg1JDNw/8Oroj5JrmiSj7NFfV/o4rzadScpHEHlaX3EbiLdxj0+r0XMT1EkDjA=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB6270.eurprd04.prod.outlook.com (20.179.26.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Mon, 4 Mar 2019 10:36:25 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::78ad:1f42:aeff:b22e]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::78ad:1f42:aeff:b22e%4]) with mapi id 15.20.1665.020; Mon, 4 Mar 2019
 10:36:25 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi
 <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li
 <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Viorel Suman
 <viorel.suman@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta
 <daniel.baluta@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH RESEND v5 1/3] ASoC: fsl: Add Audio Mixer CPU DAI driver
Thread-Topic: [PATCH RESEND v5 1/3] ASoC: fsl: Add Audio Mixer CPU DAI driver
Thread-Index: AQHU0nYdTZbQbvmfpkGT7R2w3A7YqQ==
Date: Mon, 4 Mar 2019 10:36:25 +0000
Message-ID: <1551695748-21541-2-git-send-email-viorel.suman@nxp.com>
References: <1551695748-21541-1-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1551695748-21541-1-git-send-email-viorel.suman@nxp.com>
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
x-ms-office365-filtering-correlation-id: 7265f1c8-637c-4914-ac87-08d6a08d4041
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB6270; 
x-ms-traffictypediagnostic: VI1PR04MB6270:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB6270;
 23:mTb4UC3aMIAe3h0eFwKhk7WKOd56ziEpX04ZGSD?=
 =?iso-8859-1?Q?+/Gd8/yZ6831+/TuW9RHPBRJ5q7rQk5n7evxxGnIBISxFwlEyB9zvj6Yds?=
 =?iso-8859-1?Q?FrrUHqZW6ha3F94PlsdjBUaf41MiP+DhKqlMlCAqaRAs3bBa+mI0cbIyMD?=
 =?iso-8859-1?Q?WCj9vcRKRG3Hitt44uNj826OJkt5AfZUk6mqTbHiWC3EkSPDdrSNLOj2jv?=
 =?iso-8859-1?Q?54v4JsmhZWN2V3iaffltXkfD0tsA4r+IJ9ifmCa9xaodHauhpdA6iWfqi5?=
 =?iso-8859-1?Q?44zry8RPUnrj5v6wUldDcvJ82xe7jAYe6womZdy+SV/OTKnLBHbTfNxC6v?=
 =?iso-8859-1?Q?caIla/j7N+vF6dSUO8Mxp6XhV6PNVn+6vZMexloxSKuztE5RkAbvqAyHgI?=
 =?iso-8859-1?Q?xTC3Rcpz6X6RxbGSe2zjd7oBEc+BlAvnHiGMlN+ddpJJyk5WZt6mFvwVDc?=
 =?iso-8859-1?Q?DfiZRI0s6ys5oGlm8N5Mq3IS++YUPowB1rFp8V2mf7XHzRxm9o4vfTX9I0?=
 =?iso-8859-1?Q?FfbkpyU2yumXumpG5QdZK/1VBcn1oGu+WtqmbQlB1LzuWXobeXVajCgZSa?=
 =?iso-8859-1?Q?i7ahLdAf67tigIhs/rRE/LS5i1ShE0QqQPNjLB9pqqUS+jr3QIccBpk5Z9?=
 =?iso-8859-1?Q?l3baVstBjyp99idBCBsA7TAKzfkhsQDK0nxMiFQ7W2Nb1VYTWXH+h4xbv0?=
 =?iso-8859-1?Q?69mL8whd73EnchenlwYX+YsuiKK718ialhYeJozdXKnPue5NuTn/Dphuiu?=
 =?iso-8859-1?Q?8AqOC3VD5IG7ymtPcMWEeo2+oZdc9rVtIkZzktFwsAJvG5QEwC4jzmC5t7?=
 =?iso-8859-1?Q?9SPtjMjDXyUVNNbMU7xlgygJoU1EtZmlwru0EJQw7aTKmUXtibKUDYaPdu?=
 =?iso-8859-1?Q?x2ihXjNQ0TOyE5EqIGi2tI/CPXoWHMVEVA9v25KcyIQ8Nn7aFKY9tOA7WO?=
 =?iso-8859-1?Q?rFznJgRZI2ztiAR19wDM0TMgeTv8ozh8yGwem1uZv3WUlvPepgdQwILin7?=
 =?iso-8859-1?Q?ndu821yNJKXYYMLq9yOXE7RmHlErMEtYRZtq50SVSYOcZJjIzwSOBm/Q7K?=
 =?iso-8859-1?Q?1DZXaLhQ9wtmev5DTnFgAY3wU3mP5YZbqxmNxC/69tZmjVvIAIfsgbSMJp?=
 =?iso-8859-1?Q?0IWdzH4RUmEvATjRbiDWI+o17ZGXnrC3C4z90FbiZbER7nIYQ+XqJ7wGmF?=
 =?iso-8859-1?Q?7qzC8o48etzBM7Fh5WeQm6wDWyPDqY7ilhCz2AkIr9UcFL254CLhVNjfDS?=
 =?iso-8859-1?Q?0X2raX1QKpqucCFNzFIlw+BGGQUI51J4Uwvd5nLi7988wExnGUgwwRgsc2?=
 =?iso-8859-1?Q?ifJAXaMx+hkzgWYn87c6l3ybgOt3wf8EIHIoFELlU6uxzBUchyWsa+G5Vh?=
 =?iso-8859-1?Q?dFiCH0eWJEAOM9TF831WkaSJK7v3Lyg+O3qZXr75hM0kt/U7DG2m6bvhoN?=
 =?iso-8859-1?Q?qmAOwT9LIcmNp+6bIFZsdr+DeEYsQHu8m9T?=
x-microsoft-antispam-prvs: <VI1PR04MB6270DB4C5A432549AE3B231492710@VI1PR04MB6270.eurprd04.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(189003)(199004)(186003)(26005)(81156014)(81166006)(76176011)(8676002)(52116002)(102836004)(66066001)(2906002)(105586002)(386003)(6506007)(106356001)(478600001)(86362001)(305945005)(7736002)(99286004)(256004)(446003)(11346002)(2616005)(486006)(44832011)(476003)(316002)(966005)(97736004)(14444005)(6116002)(3846002)(36756003)(4326008)(8936002)(50226002)(68736007)(54906003)(110136005)(14454004)(71200400001)(6436002)(6486002)(53936002)(25786009)(6306002)(6512007)(53946003)(71190400001)(5660300002)(7416002)(30864003)(6636002)(921003)(1121003)(579004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB6270;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qVHVPGAD0dMXj6c1aMultjBzcc2wNyd1mQBTWRp4I1KfJhiHPWbjAHKGFxtIrrkqi2rpmZ0O9ztwTeAQlfTfi3sdbK89YmBhfsyCV0KGm73Uz1ssZ9yyh7hyusIsLcMCEU/l2SmwfcGEdzyyJfKMgQgWB44KoJTz0RN3f/a3KpSZwTsUTUQVOrPb/ThQAZJi++UOKUWCukz0xVc9K6clWtGTleBo3wdFIEjuciJUMENL76jpCmoypGCUHdGJq1l5Wz2KIQvKv0bw5muihP0cibcwLyL/N8uVqCRGBUGmKLGVVhIMcLYtsXn0p5fbQ+B+KFfqSXU8GQ8d256WKjj9/idopVgCG0FoOiz4XmoxeS7xJs+Jd4KLA5L96Yd2zH+ewnJpnQqN/yf4h8XUou/N/j5AakMLRSaFL4Ikr6eL2E4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7265f1c8-637c-4914-ac87-08d6a08d4041
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 10:36:25.2035 (UTC)
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

This patch implements Audio Mixer CPU DAI driver for NXP iMX8 SOCs.
The Audio Mixer is a on-chip functional module that allows mixing of
two audio streams into a single audio stream.

Audio Mixer datasheet is available here:
https://www.nxp.com/docs/en/reference-manual/IMX8DQXPRM.pdf

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/Kconfig      |   7 +
 sound/soc/fsl/Makefile     |   3 +
 sound/soc/fsl/fsl_audmix.c | 578 +++++++++++++++++++++++++++++++++++++++++=
++++
 sound/soc/fsl/fsl_audmix.h | 102 ++++++++
 4 files changed, 690 insertions(+)
 create mode 100644 sound/soc/fsl/fsl_audmix.c
 create mode 100644 sound/soc/fsl/fsl_audmix.h

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 7b1d997..0af2e056 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -24,6 +24,13 @@ config SND_SOC_FSL_SAI
 	  This option is only useful for out-of-tree drivers since
 	  in-tree drivers select it automatically.
=20
+config SND_SOC_FSL_AUDMIX
+	tristate "Audio Mixer (AUDMIX) module support"
+	select REGMAP_MMIO
+	help
+	  Say Y if you want to add Audio Mixer (AUDMIX)
+	  support for the NXP iMX CPUs.
+
 config SND_SOC_FSL_SSI
 	tristate "Synchronous Serial Interface module (SSI) support"
 	select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC !=3D n
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index 3c0ff31..4172d5a 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -12,6 +12,7 @@ snd-soc-p1022-rdk-objs :=3D p1022_rdk.o
 obj-$(CONFIG_SND_SOC_P1022_RDK) +=3D snd-soc-p1022-rdk.o
=20
 # Freescale SSI/DMA/SAI/SPDIF Support
+snd-soc-fsl-audmix-objs :=3D fsl_audmix.o
 snd-soc-fsl-asoc-card-objs :=3D fsl-asoc-card.o
 snd-soc-fsl-asrc-objs :=3D fsl_asrc.o fsl_asrc_dma.o
 snd-soc-fsl-sai-objs :=3D fsl_sai.o
@@ -22,6 +23,8 @@ snd-soc-fsl-esai-objs :=3D fsl_esai.o
 snd-soc-fsl-micfil-objs :=3D fsl_micfil.o
 snd-soc-fsl-utils-objs :=3D fsl_utils.o
 snd-soc-fsl-dma-objs :=3D fsl_dma.o
+
+obj-$(CONFIG_SND_SOC_FSL_AUDMIX) +=3D snd-soc-fsl-audmix.o
 obj-$(CONFIG_SND_SOC_FSL_ASOC_CARD) +=3D snd-soc-fsl-asoc-card.o
 obj-$(CONFIG_SND_SOC_FSL_ASRC) +=3D snd-soc-fsl-asrc.o
 obj-$(CONFIG_SND_SOC_FSL_SAI) +=3D snd-soc-fsl-sai.o
diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
new file mode 100644
index 0000000..07b72a3
--- /dev/null
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -0,0 +1,578 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NXP AUDMIX ALSA SoC Digital Audio Interface (DAI) driver
+ *
+ * Copyright 2017 NXP
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+
+#include "fsl_audmix.h"
+
+#define SOC_ENUM_SINGLE_S(xreg, xshift, xtexts) \
+	SOC_ENUM_SINGLE(xreg, xshift, ARRAY_SIZE(xtexts), xtexts)
+
+static const char
+	*tdm_sel[] =3D { "TDM1", "TDM2", },
+	*mode_sel[] =3D { "Disabled", "TDM1", "TDM2", "Mixed", },
+	*width_sel[] =3D { "16b", "18b", "20b", "24b", "32b", },
+	*endis_sel[] =3D { "Disabled", "Enabled", },
+	*updn_sel[] =3D { "Downward", "Upward", },
+	*mask_sel[] =3D { "Unmask", "Mask", };
+
+static const struct soc_enum fsl_audmix_enum[] =3D {
+/* FSL_AUDMIX_CTR enums */
+SOC_ENUM_SINGLE_S(FSL_AUDMIX_CTR, FSL_AUDMIX_CTR_MIXCLK_SHIFT, tdm_sel),
+SOC_ENUM_SINGLE_S(FSL_AUDMIX_CTR, FSL_AUDMIX_CTR_OUTSRC_SHIFT, mode_sel),
+SOC_ENUM_SINGLE_S(FSL_AUDMIX_CTR, FSL_AUDMIX_CTR_OUTWIDTH_SHIFT, width_sel=
),
+SOC_ENUM_SINGLE_S(FSL_AUDMIX_CTR, FSL_AUDMIX_CTR_MASKRTDF_SHIFT, mask_sel)=
,
+SOC_ENUM_SINGLE_S(FSL_AUDMIX_CTR, FSL_AUDMIX_CTR_MASKCKDF_SHIFT, mask_sel)=
,
+SOC_ENUM_SINGLE_S(FSL_AUDMIX_CTR, FSL_AUDMIX_CTR_SYNCMODE_SHIFT, endis_sel=
),
+SOC_ENUM_SINGLE_S(FSL_AUDMIX_CTR, FSL_AUDMIX_CTR_SYNCSRC_SHIFT, tdm_sel),
+/* FSL_AUDMIX_ATCR0 enums */
+SOC_ENUM_SINGLE_S(FSL_AUDMIX_ATCR0, 0, endis_sel),
+SOC_ENUM_SINGLE_S(FSL_AUDMIX_ATCR0, 1, updn_sel),
+/* FSL_AUDMIX_ATCR1 enums */
+SOC_ENUM_SINGLE_S(FSL_AUDMIX_ATCR1, 0, endis_sel),
+SOC_ENUM_SINGLE_S(FSL_AUDMIX_ATCR1, 1, updn_sel),
+};
+
+struct fsl_audmix_state {
+	u8 tdms;
+	u8 clk;
+	char msg[64];
+};
+
+static const struct fsl_audmix_state prms[4][4] =3D {{
+	/* DIS->DIS, do nothing */
+	{ .tdms =3D 0, .clk =3D 0, .msg =3D "" },
+	/* DIS->TDM1*/
+	{ .tdms =3D 1, .clk =3D 1, .msg =3D "DIS->TDM1: TDM1 not started!\n" },
+	/* DIS->TDM2*/
+	{ .tdms =3D 2, .clk =3D 2, .msg =3D "DIS->TDM2: TDM2 not started!\n" },
+	/* DIS->MIX */
+	{ .tdms =3D 3, .clk =3D 0, .msg =3D "DIS->MIX: Please start both TDMs!\n"=
 }
+}, {	/* TDM1->DIS */
+	{ .tdms =3D 1, .clk =3D 0, .msg =3D "TDM1->DIS: TDM1 not started!\n" },
+	/* TDM1->TDM1, do nothing */
+	{ .tdms =3D 0, .clk =3D 0, .msg =3D "" },
+	/* TDM1->TDM2 */
+	{ .tdms =3D 3, .clk =3D 2, .msg =3D "TDM1->TDM2: Please start both TDMs!\=
n" },
+	/* TDM1->MIX */
+	{ .tdms =3D 3, .clk =3D 0, .msg =3D "TDM1->MIX: Please start both TDMs!\n=
" }
+}, {	/* TDM2->DIS */
+	{ .tdms =3D 2, .clk =3D 0, .msg =3D "TDM2->DIS: TDM2 not started!\n" },
+	/* TDM2->TDM1 */
+	{ .tdms =3D 3, .clk =3D 1, .msg =3D "TDM2->TDM1: Please start both TDMs!\=
n" },
+	/* TDM2->TDM2, do nothing */
+	{ .tdms =3D 0, .clk =3D 0, .msg =3D "" },
+	/* TDM2->MIX */
+	{ .tdms =3D 3, .clk =3D 0, .msg =3D "TDM2->MIX: Please start both TDMs!\n=
" }
+}, {	/* MIX->DIS */
+	{ .tdms =3D 3, .clk =3D 0, .msg =3D "MIX->DIS: Please start both TDMs!\n"=
 },
+	/* MIX->TDM1 */
+	{ .tdms =3D 3, .clk =3D 1, .msg =3D "MIX->TDM1: Please start both TDMs!\n=
" },
+	/* MIX->TDM2 */
+	{ .tdms =3D 3, .clk =3D 2, .msg =3D "MIX->TDM2: Please start both TDMs!\n=
" },
+	/* MIX->MIX, do nothing */
+	{ .tdms =3D 0, .clk =3D 0, .msg =3D "" }
+}, };
+
+static int fsl_audmix_state_trans(struct snd_soc_component *comp,
+				  unsigned int *mask, unsigned int *ctr,
+				  const struct fsl_audmix_state prm)
+{
+	struct fsl_audmix *priv =3D snd_soc_component_get_drvdata(comp);
+	/* Enforce all required TDMs are started */
+	if ((priv->tdms & prm.tdms) !=3D prm.tdms) {
+		dev_dbg(comp->dev, prm.msg);
+		return -EINVAL;
+	}
+
+	switch (prm.clk) {
+	case 1:
+	case 2:
+		/* Set mix clock */
+		(*mask) |=3D FSL_AUDMIX_CTR_MIXCLK_MASK;
+		(*ctr)  |=3D FSL_AUDMIX_CTR_MIXCLK(prm.clk - 1);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int fsl_audmix_put_mix_clk_src(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *comp =3D snd_kcontrol_chip(kcontrol);
+	struct fsl_audmix *priv =3D snd_soc_component_get_drvdata(comp);
+	struct soc_enum *e =3D (struct soc_enum *)kcontrol->private_value;
+	unsigned int *item =3D ucontrol->value.enumerated.item;
+	unsigned int reg_val, val, mix_clk;
+	int ret =3D 0;
+
+	/* Get current state */
+	ret =3D snd_soc_component_read(comp, FSL_AUDMIX_CTR, &reg_val);
+	if (ret)
+		return ret;
+
+	mix_clk =3D ((reg_val & FSL_AUDMIX_CTR_MIXCLK_MASK)
+			>> FSL_AUDMIX_CTR_MIXCLK_SHIFT);
+	val =3D snd_soc_enum_item_to_val(e, item[0]);
+
+	dev_dbg(comp->dev, "TDMs=3Dx%08x, val=3Dx%08x\n", priv->tdms, val);
+
+	/**
+	 * Ensure the current selected mixer clock is available
+	 * for configuration propagation
+	 */
+	if (!(priv->tdms & BIT(mix_clk))) {
+		dev_err(comp->dev,
+			"Started TDM%d needed for config propagation!\n",
+			mix_clk + 1);
+		return -EINVAL;
+	}
+
+	if (!(priv->tdms & BIT(val))) {
+		dev_err(comp->dev,
+			"The selected clock source has no TDM%d enabled!\n",
+			val + 1);
+		return -EINVAL;
+	}
+
+	return snd_soc_put_enum_double(kcontrol, ucontrol);
+}
+
+static int fsl_audmix_put_out_src(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *comp =3D snd_kcontrol_chip(kcontrol);
+	struct fsl_audmix *priv =3D snd_soc_component_get_drvdata(comp);
+	struct soc_enum *e =3D (struct soc_enum *)kcontrol->private_value;
+	unsigned int *item =3D ucontrol->value.enumerated.item;
+	u32 out_src, mix_clk;
+	unsigned int reg_val, val, mask =3D 0, ctr =3D 0;
+	int ret =3D 0;
+
+	/* Get current state */
+	ret =3D snd_soc_component_read(comp, FSL_AUDMIX_CTR, &reg_val);
+	if (ret)
+		return ret;
+
+	/* "From" state */
+	out_src =3D ((reg_val & FSL_AUDMIX_CTR_OUTSRC_MASK)
+			>> FSL_AUDMIX_CTR_OUTSRC_SHIFT);
+	mix_clk =3D ((reg_val & FSL_AUDMIX_CTR_MIXCLK_MASK)
+			>> FSL_AUDMIX_CTR_MIXCLK_SHIFT);
+
+	/* "To" state */
+	val =3D snd_soc_enum_item_to_val(e, item[0]);
+
+	dev_dbg(comp->dev, "TDMs=3Dx%08x, val=3Dx%08x\n", priv->tdms, val);
+
+	/* Check if state is changing ... */
+	if (out_src =3D=3D val)
+		return 0;
+	/**
+	 * Ensure the current selected mixer clock is available
+	 * for configuration propagation
+	 */
+	if (!(priv->tdms & BIT(mix_clk))) {
+		dev_err(comp->dev,
+			"Started TDM%d needed for config propagation!\n",
+			mix_clk + 1);
+		return -EINVAL;
+	}
+
+	/* Check state transition constraints */
+	ret =3D fsl_audmix_state_trans(comp, &mask, &ctr, prms[out_src][val]);
+	if (ret)
+		return ret;
+
+	/* Complete transition to new state */
+	mask |=3D FSL_AUDMIX_CTR_OUTSRC_MASK;
+	ctr  |=3D FSL_AUDMIX_CTR_OUTSRC(val);
+
+	return snd_soc_component_update_bits(comp, FSL_AUDMIX_CTR, mask, ctr);
+}
+
+static const struct snd_kcontrol_new fsl_audmix_snd_controls[] =3D {
+	/* FSL_AUDMIX_CTR controls */
+	SOC_ENUM_EXT("Mixing Clock Source", fsl_audmix_enum[0],
+		     snd_soc_get_enum_double, fsl_audmix_put_mix_clk_src),
+	SOC_ENUM_EXT("Output Source", fsl_audmix_enum[1],
+		     snd_soc_get_enum_double, fsl_audmix_put_out_src),
+	SOC_ENUM("Output Width", fsl_audmix_enum[2]),
+	SOC_ENUM("Frame Rate Diff Error", fsl_audmix_enum[3]),
+	SOC_ENUM("Clock Freq Diff Error", fsl_audmix_enum[4]),
+	SOC_ENUM("Sync Mode Config", fsl_audmix_enum[5]),
+	SOC_ENUM("Sync Mode Clk Source", fsl_audmix_enum[6]),
+	/* TDM1 Attenuation controls */
+	SOC_ENUM("TDM1 Attenuation", fsl_audmix_enum[7]),
+	SOC_ENUM("TDM1 Attenuation Direction", fsl_audmix_enum[8]),
+	SOC_SINGLE("TDM1 Attenuation Step Divider", FSL_AUDMIX_ATCR0,
+		   2, 0x00fff, 0),
+	SOC_SINGLE("TDM1 Attenuation Initial Value", FSL_AUDMIX_ATIVAL0,
+		   0, 0x3ffff, 0),
+	SOC_SINGLE("TDM1 Attenuation Step Up Factor", FSL_AUDMIX_ATSTPUP0,
+		   0, 0x3ffff, 0),
+	SOC_SINGLE("TDM1 Attenuation Step Down Factor", FSL_AUDMIX_ATSTPDN0,
+		   0, 0x3ffff, 0),
+	SOC_SINGLE("TDM1 Attenuation Step Target", FSL_AUDMIX_ATSTPTGT0,
+		   0, 0x3ffff, 0),
+	/* TDM2 Attenuation controls */
+	SOC_ENUM("TDM2 Attenuation", fsl_audmix_enum[9]),
+	SOC_ENUM("TDM2 Attenuation Direction", fsl_audmix_enum[10]),
+	SOC_SINGLE("TDM2 Attenuation Step Divider", FSL_AUDMIX_ATCR1,
+		   2, 0x00fff, 0),
+	SOC_SINGLE("TDM2 Attenuation Initial Value", FSL_AUDMIX_ATIVAL1,
+		   0, 0x3ffff, 0),
+	SOC_SINGLE("TDM2 Attenuation Step Up Factor", FSL_AUDMIX_ATSTPUP1,
+		   0, 0x3ffff, 0),
+	SOC_SINGLE("TDM2 Attenuation Step Down Factor", FSL_AUDMIX_ATSTPDN1,
+		   0, 0x3ffff, 0),
+	SOC_SINGLE("TDM2 Attenuation Step Target", FSL_AUDMIX_ATSTPTGT1,
+		   0, 0x3ffff, 0),
+};
+
+static int fsl_audmix_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fm=
t)
+{
+	struct snd_soc_component *comp =3D dai->component;
+	u32 mask =3D 0, ctr =3D 0;
+
+	/* AUDMIX is working in DSP_A format only */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_A:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* For playback the AUDMIX is slave, and for record is master */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_NF:
+		/* Output data will be written on positive edge of the clock */
+		ctr |=3D FSL_AUDMIX_CTR_OUTCKPOL(0);
+		break;
+	case SND_SOC_DAIFMT_NB_NF:
+		/* Output data will be written on negative edge of the clock */
+		ctr |=3D FSL_AUDMIX_CTR_OUTCKPOL(1);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mask |=3D FSL_AUDMIX_CTR_OUTCKPOL_MASK;
+
+	return snd_soc_component_update_bits(comp, FSL_AUDMIX_CTR, mask, ctr);
+}
+
+static int fsl_audmix_dai_trigger(struct snd_pcm_substream *substream, int=
 cmd,
+				  struct snd_soc_dai *dai)
+{
+	struct fsl_audmix *priv =3D snd_soc_dai_get_drvdata(dai);
+
+	/* Capture stream shall not be handled */
+	if (substream->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE)
+		return 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		priv->tdms |=3D BIT(dai->driver->id);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		priv->tdms &=3D ~BIT(dai->driver->id);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops fsl_audmix_dai_ops =3D {
+	.set_fmt      =3D fsl_audmix_dai_set_fmt,
+	.trigger      =3D fsl_audmix_dai_trigger,
+};
+
+static struct snd_soc_dai_driver fsl_audmix_dai[] =3D {
+	{
+		.id   =3D 0,
+		.name =3D "audmix-0",
+		.playback =3D {
+			.stream_name =3D "AUDMIX-Playback-0",
+			.channels_min =3D 8,
+			.channels_max =3D 8,
+			.rate_min =3D 8000,
+			.rate_max =3D 96000,
+			.rates =3D SNDRV_PCM_RATE_8000_96000,
+			.formats =3D FSL_AUDMIX_FORMATS,
+		},
+		.capture =3D {
+			.stream_name =3D "AUDMIX-Capture-0",
+			.channels_min =3D 8,
+			.channels_max =3D 8,
+			.rate_min =3D 8000,
+			.rate_max =3D 96000,
+			.rates =3D SNDRV_PCM_RATE_8000_96000,
+			.formats =3D FSL_AUDMIX_FORMATS,
+		},
+		.ops =3D &fsl_audmix_dai_ops,
+	},
+	{
+		.id   =3D 1,
+		.name =3D "audmix-1",
+		.playback =3D {
+			.stream_name =3D "AUDMIX-Playback-1",
+			.channels_min =3D 8,
+			.channels_max =3D 8,
+			.rate_min =3D 8000,
+			.rate_max =3D 96000,
+			.rates =3D SNDRV_PCM_RATE_8000_96000,
+			.formats =3D FSL_AUDMIX_FORMATS,
+		},
+		.capture =3D {
+			.stream_name =3D "AUDMIX-Capture-1",
+			.channels_min =3D 8,
+			.channels_max =3D 8,
+			.rate_min =3D 8000,
+			.rate_max =3D 96000,
+			.rates =3D SNDRV_PCM_RATE_8000_96000,
+			.formats =3D FSL_AUDMIX_FORMATS,
+		},
+		.ops =3D &fsl_audmix_dai_ops,
+	},
+};
+
+static const struct snd_soc_component_driver fsl_audmix_component =3D {
+	.name		  =3D "fsl-audmix-dai",
+	.controls	  =3D fsl_audmix_snd_controls,
+	.num_controls	  =3D ARRAY_SIZE(fsl_audmix_snd_controls),
+};
+
+static bool fsl_audmix_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case FSL_AUDMIX_CTR:
+	case FSL_AUDMIX_STR:
+	case FSL_AUDMIX_ATCR0:
+	case FSL_AUDMIX_ATIVAL0:
+	case FSL_AUDMIX_ATSTPUP0:
+	case FSL_AUDMIX_ATSTPDN0:
+	case FSL_AUDMIX_ATSTPTGT0:
+	case FSL_AUDMIX_ATTNVAL0:
+	case FSL_AUDMIX_ATSTP0:
+	case FSL_AUDMIX_ATCR1:
+	case FSL_AUDMIX_ATIVAL1:
+	case FSL_AUDMIX_ATSTPUP1:
+	case FSL_AUDMIX_ATSTPDN1:
+	case FSL_AUDMIX_ATSTPTGT1:
+	case FSL_AUDMIX_ATTNVAL1:
+	case FSL_AUDMIX_ATSTP1:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool fsl_audmix_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case FSL_AUDMIX_CTR:
+	case FSL_AUDMIX_ATCR0:
+	case FSL_AUDMIX_ATIVAL0:
+	case FSL_AUDMIX_ATSTPUP0:
+	case FSL_AUDMIX_ATSTPDN0:
+	case FSL_AUDMIX_ATSTPTGT0:
+	case FSL_AUDMIX_ATCR1:
+	case FSL_AUDMIX_ATIVAL1:
+	case FSL_AUDMIX_ATSTPUP1:
+	case FSL_AUDMIX_ATSTPDN1:
+	case FSL_AUDMIX_ATSTPTGT1:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct reg_default fsl_audmix_reg[] =3D {
+	{ FSL_AUDMIX_CTR,       0x00060 },
+	{ FSL_AUDMIX_STR,       0x00003 },
+	{ FSL_AUDMIX_ATCR0,     0x00000 },
+	{ FSL_AUDMIX_ATIVAL0,   0x3FFFF },
+	{ FSL_AUDMIX_ATSTPUP0,  0x2AAAA },
+	{ FSL_AUDMIX_ATSTPDN0,  0x30000 },
+	{ FSL_AUDMIX_ATSTPTGT0, 0x00010 },
+	{ FSL_AUDMIX_ATTNVAL0,  0x00000 },
+	{ FSL_AUDMIX_ATSTP0,    0x00000 },
+	{ FSL_AUDMIX_ATCR1,     0x00000 },
+	{ FSL_AUDMIX_ATIVAL1,   0x3FFFF },
+	{ FSL_AUDMIX_ATSTPUP1,  0x2AAAA },
+	{ FSL_AUDMIX_ATSTPDN1,  0x30000 },
+	{ FSL_AUDMIX_ATSTPTGT1, 0x00010 },
+	{ FSL_AUDMIX_ATTNVAL1,  0x00000 },
+	{ FSL_AUDMIX_ATSTP1,    0x00000 },
+};
+
+static const struct regmap_config fsl_audmix_regmap_config =3D {
+	.reg_bits =3D 32,
+	.reg_stride =3D 4,
+	.val_bits =3D 32,
+	.max_register =3D FSL_AUDMIX_ATSTP1,
+	.reg_defaults =3D fsl_audmix_reg,
+	.num_reg_defaults =3D ARRAY_SIZE(fsl_audmix_reg),
+	.readable_reg =3D fsl_audmix_readable_reg,
+	.writeable_reg =3D fsl_audmix_writeable_reg,
+	.cache_type =3D REGCACHE_FLAT,
+};
+
+static const struct of_device_id fsl_audmix_ids[] =3D {
+	{
+		.compatible =3D "fsl,imx8qm-audmix",
+		.data =3D "imx-audmix",
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, fsl_audmix_ids);
+
+static int fsl_audmix_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct fsl_audmix *priv;
+	struct resource *res;
+	const char *mdrv;
+	const struct of_device_id *of_id;
+	void __iomem *regs;
+	int ret;
+
+	of_id =3D of_match_device(fsl_audmix_ids, dev);
+	if (!of_id || !of_id->data)
+		return -EINVAL;
+
+	mdrv =3D of_id->data;
+
+	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	/* Get the addresses */
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	regs =3D devm_ioremap_resource(dev, res);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	priv->regmap =3D devm_regmap_init_mmio_clk(dev, "ipg", regs,
+						 &fsl_audmix_regmap_config);
+	if (IS_ERR(priv->regmap)) {
+		dev_err(dev, "failed to init regmap\n");
+		return PTR_ERR(priv->regmap);
+	}
+
+	priv->ipg_clk =3D devm_clk_get(dev, "ipg");
+	if (IS_ERR(priv->ipg_clk)) {
+		dev_err(dev, "failed to get ipg clock\n");
+		return PTR_ERR(priv->ipg_clk);
+	}
+
+	platform_set_drvdata(pdev, priv);
+	pm_runtime_enable(dev);
+
+	ret =3D devm_snd_soc_register_component(dev, &fsl_audmix_component,
+					      fsl_audmix_dai,
+					      ARRAY_SIZE(fsl_audmix_dai));
+	if (ret) {
+		dev_err(dev, "failed to register ASoC DAI\n");
+		return ret;
+	}
+
+	priv->pdev =3D platform_device_register_data(dev, mdrv, 0, NULL, 0);
+	if (IS_ERR(priv->pdev)) {
+		ret =3D PTR_ERR(priv->pdev);
+		dev_err(dev, "failed to register platform %s: %d\n", mdrv, ret);
+	}
+
+	return ret;
+}
+
+static int fsl_audmix_remove(struct platform_device *pdev)
+{
+	struct fsl_audmix *priv =3D dev_get_drvdata(&pdev->dev);
+
+	if (priv->pdev)
+		platform_device_unregister(priv->pdev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int fsl_audmix_runtime_resume(struct device *dev)
+{
+	struct fsl_audmix *priv =3D dev_get_drvdata(dev);
+	int ret;
+
+	ret =3D clk_prepare_enable(priv->ipg_clk);
+	if (ret) {
+		dev_err(dev, "Failed to enable IPG clock: %d\n", ret);
+		return ret;
+	}
+
+	regcache_cache_only(priv->regmap, false);
+	regcache_mark_dirty(priv->regmap);
+
+	return regcache_sync(priv->regmap);
+}
+
+static int fsl_audmix_runtime_suspend(struct device *dev)
+{
+	struct fsl_audmix *priv =3D dev_get_drvdata(dev);
+
+	regcache_cache_only(priv->regmap, true);
+
+	clk_disable_unprepare(priv->ipg_clk);
+
+	return 0;
+}
+#endif /* CONFIG_PM */
+
+static const struct dev_pm_ops fsl_audmix_pm =3D {
+	SET_RUNTIME_PM_OPS(fsl_audmix_runtime_suspend,
+			   fsl_audmix_runtime_resume,
+			   NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
+
+static struct platform_driver fsl_audmix_driver =3D {
+	.probe =3D fsl_audmix_probe,
+	.remove =3D fsl_audmix_remove,
+	.driver =3D {
+		.name =3D "fsl-audmix",
+		.of_match_table =3D fsl_audmix_ids,
+		.pm =3D &fsl_audmix_pm,
+	},
+};
+module_platform_driver(fsl_audmix_driver);
+
+MODULE_DESCRIPTION("NXP AUDMIX ASoC DAI driver");
+MODULE_AUTHOR("Viorel Suman <viorel.suman@nxp.com>");
+MODULE_ALIAS("platform:fsl-audmix");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/fsl/fsl_audmix.h b/sound/soc/fsl/fsl_audmix.h
new file mode 100644
index 0000000..7812ffe
--- /dev/null
+++ b/sound/soc/fsl/fsl_audmix.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * NXP AUDMIX ALSA SoC Digital Audio Interface (DAI) driver
+ *
+ * Copyright 2017 NXP
+ */
+
+#ifndef __FSL_AUDMIX_H
+#define __FSL_AUDMIX_H
+
+#define FSL_AUDMIX_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			SNDRV_PCM_FMTBIT_S24_LE |\
+			SNDRV_PCM_FMTBIT_S32_LE)
+/* AUDMIX Registers */
+#define FSL_AUDMIX_CTR		0x200 /* Control */
+#define FSL_AUDMIX_STR		0x204 /* Status */
+
+#define FSL_AUDMIX_ATCR0	0x208 /* Attenuation Control */
+#define FSL_AUDMIX_ATIVAL0	0x20c /* Attenuation Initial Value */
+#define FSL_AUDMIX_ATSTPUP0	0x210 /* Attenuation step up factor */
+#define FSL_AUDMIX_ATSTPDN0	0x214 /* Attenuation step down factor */
+#define FSL_AUDMIX_ATSTPTGT0	0x218 /* Attenuation step target */
+#define FSL_AUDMIX_ATTNVAL0	0x21c /* Attenuation Value */
+#define FSL_AUDMIX_ATSTP0	0x220 /* Attenuation step number */
+
+#define FSL_AUDMIX_ATCR1	0x228 /* Attenuation Control */
+#define FSL_AUDMIX_ATIVAL1	0x22c /* Attenuation Initial Value */
+#define FSL_AUDMIX_ATSTPUP1	0x230 /* Attenuation step up factor */
+#define FSL_AUDMIX_ATSTPDN1	0x234 /* Attenuation step down factor */
+#define FSL_AUDMIX_ATSTPTGT1	0x238 /* Attenuation step target */
+#define FSL_AUDMIX_ATTNVAL1	0x23c /* Attenuation Value */
+#define FSL_AUDMIX_ATSTP1	0x240 /* Attenuation step number */
+
+/* AUDMIX Control Register */
+#define FSL_AUDMIX_CTR_MIXCLK_SHIFT	0
+#define FSL_AUDMIX_CTR_MIXCLK_MASK	BIT(FSL_AUDMIX_CTR_MIXCLK_SHIFT)
+#define FSL_AUDMIX_CTR_MIXCLK(i)	((i) << FSL_AUDMIX_CTR_MIXCLK_SHIFT)
+#define FSL_AUDMIX_CTR_OUTSRC_SHIFT	1
+#define FSL_AUDMIX_CTR_OUTSRC_MASK	(0x3 << FSL_AUDMIX_CTR_OUTSRC_SHIFT)
+#define FSL_AUDMIX_CTR_OUTSRC(i)	(((i) << FSL_AUDMIX_CTR_OUTSRC_SHIFT)\
+					      & FSL_AUDMIX_CTR_OUTSRC_MASK)
+#define FSL_AUDMIX_CTR_OUTWIDTH_SHIFT	3
+#define FSL_AUDMIX_CTR_OUTWIDTH_MASK	(0x7 << FSL_AUDMIX_CTR_OUTWIDTH_SHIFT=
)
+#define FSL_AUDMIX_CTR_OUTWIDTH(i)	(((i) << FSL_AUDMIX_CTR_OUTWIDTH_SHIFT)=
\
+					      & FSL_AUDMIX_CTR_OUTWIDTH_MASK)
+#define FSL_AUDMIX_CTR_OUTCKPOL_SHIFT	6
+#define FSL_AUDMIX_CTR_OUTCKPOL_MASK	BIT(FSL_AUDMIX_CTR_OUTCKPOL_SHIFT)
+#define FSL_AUDMIX_CTR_OUTCKPOL(i)	((i) << FSL_AUDMIX_CTR_OUTCKPOL_SHIFT)
+#define FSL_AUDMIX_CTR_MASKRTDF_SHIFT	7
+#define FSL_AUDMIX_CTR_MASKRTDF_MASK	BIT(FSL_AUDMIX_CTR_MASKRTDF_SHIFT)
+#define FSL_AUDMIX_CTR_MASKRTDF(i)	((i) << FSL_AUDMIX_CTR_MASKRTDF_SHIFT)
+#define FSL_AUDMIX_CTR_MASKCKDF_SHIFT	8
+#define FSL_AUDMIX_CTR_MASKCKDF_MASK	BIT(FSL_AUDMIX_CTR_MASKCKDF_SHIFT)
+#define FSL_AUDMIX_CTR_MASKCKDF(i)	((i) << FSL_AUDMIX_CTR_MASKCKDF_SHIFT)
+#define FSL_AUDMIX_CTR_SYNCMODE_SHIFT	9
+#define FSL_AUDMIX_CTR_SYNCMODE_MASK	BIT(FSL_AUDMIX_CTR_SYNCMODE_SHIFT)
+#define FSL_AUDMIX_CTR_SYNCMODE(i)	((i) << FSL_AUDMIX_CTR_SYNCMODE_SHIFT)
+#define FSL_AUDMIX_CTR_SYNCSRC_SHIFT	10
+#define FSL_AUDMIX_CTR_SYNCSRC_MASK	BIT(FSL_AUDMIX_CTR_SYNCSRC_SHIFT)
+#define FSL_AUDMIX_CTR_SYNCSRC(i)	((i) << FSL_AUDMIX_CTR_SYNCSRC_SHIFT)
+
+/* AUDMIX Status Register */
+#define FSL_AUDMIX_STR_RATEDIFF		BIT(0)
+#define FSL_AUDMIX_STR_CLKDIFF		BIT(1)
+#define FSL_AUDMIX_STR_MIXSTAT_SHIFT	2
+#define FSL_AUDMIX_STR_MIXSTAT_MASK	(0x3 << FSL_AUDMIX_STR_MIXSTAT_SHIFT)
+#define FSL_AUDMIX_STR_MIXSTAT(i)	(((i) & FSL_AUDMIX_STR_MIXSTAT_MASK) \
+					   >> FSL_AUDMIX_STR_MIXSTAT_SHIFT)
+/* AUDMIX Attenuation Control Register */
+#define FSL_AUDMIX_ATCR_AT_EN		BIT(0)
+#define FSL_AUDMIX_ATCR_AT_UPDN		BIT(1)
+#define FSL_AUDMIX_ATCR_ATSTPDIF_SHIFT	2
+#define FSL_AUDMIX_ATCR_ATSTPDFI_MASK	\
+				(0xfff << FSL_AUDMIX_ATCR_ATSTPDIF_SHIFT)
+
+/* AUDMIX Attenuation Initial Value Register */
+#define FSL_AUDMIX_ATIVAL_ATINVAL_MASK	0x3FFFF
+
+/* AUDMIX Attenuation Step Up Factor Register */
+#define FSL_AUDMIX_ATSTPUP_ATSTEPUP_MASK	0x3FFFF
+
+/* AUDMIX Attenuation Step Down Factor Register */
+#define FSL_AUDMIX_ATSTPDN_ATSTEPDN_MASK	0x3FFFF
+
+/* AUDMIX Attenuation Step Target Register */
+#define FSL_AUDMIX_ATSTPTGT_ATSTPTG_MASK	0x3FFFF
+
+/* AUDMIX Attenuation Value Register */
+#define FSL_AUDMIX_ATTNVAL_ATCURVAL_MASK	0x3FFFF
+
+/* AUDMIX Attenuation Step Number Register */
+#define FSL_AUDMIX_ATSTP_STPCTR_MASK	0x3FFFF
+
+#define FSL_AUDMIX_MAX_DAIS		2
+struct fsl_audmix {
+	struct platform_device *pdev;
+	struct regmap *regmap;
+	struct clk *ipg_clk;
+	u8 tdms;
+};
+
+#endif /* __FSL_AUDMIX_H */
--=20
2.7.4


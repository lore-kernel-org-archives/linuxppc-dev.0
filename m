Return-Path: <SRS0=bgOd=RH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C7BC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 10:43:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5693E20823
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 10:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YSm+HUyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5693E20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Cc7j3VF0zDqJ1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 21:43:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.2.64; helo=eur02-ve1-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="YSm+HUyT"; 
 dkim-atps=neutral
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20064.outbound.protection.outlook.com [40.107.2.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Cbzr3y9xzDqG8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2019 21:36:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLSjbFQgfdgUUpjeFb0kChb2+OLvQIjuNehzcusVzao=;
 b=YSm+HUyTDhUgq+vnIdD6LsqPkCavX31ixncKNbmCqZzLCxtVqjK4+PjaEHuAv/b45yqRbYZm9Llj3uwbd1BOHuC5TC/K1sN9Vxs1uDk05apiB67k5XnTQ+EcUDLyhwaTIrh+yxo1B453i6/UaqjtPOvzfZ1srEfAmQCoHaSoa2w=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB6270.eurprd04.prod.outlook.com (20.179.26.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Mon, 4 Mar 2019 10:36:28 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::78ad:1f42:aeff:b22e]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::78ad:1f42:aeff:b22e%4]) with mapi id 15.20.1665.020; Mon, 4 Mar 2019
 10:36:28 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi
 <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li
 <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Viorel Suman
 <viorel.suman@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta
 <daniel.baluta@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH RESEND v5 3/3] ASoC: fsl: Add Audio Mixer machine driver
Thread-Topic: [PATCH RESEND v5 3/3] ASoC: fsl: Add Audio Mixer machine driver
Thread-Index: AQHU0nYfrazud3uHBEWBo9zpGM//0Q==
Date: Mon, 4 Mar 2019 10:36:28 +0000
Message-ID: <1551695748-21541-4-git-send-email-viorel.suman@nxp.com>
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
x-ms-office365-filtering-correlation-id: 519e3426-1b59-46f4-94c6-08d6a08d424b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB6270; 
x-ms-traffictypediagnostic: VI1PR04MB6270:
x-ms-exchange-purlcount: 2
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB6270;
 23:tmZuEfhygFSrUs7P2ukCxzQzC13gbytRZPLj9c6?=
 =?iso-8859-1?Q?b00A4X+pbhRb++l0ik3IMf/r2JHHZeKaxkl/vGu5qrOOd279fVGslp3m3J?=
 =?iso-8859-1?Q?TBAmwYwYFHK6lQj72LUybqu4hd7BvwLsjYZPdOfVTN20gE59mSuuQ0y63f?=
 =?iso-8859-1?Q?Y0bEUplHymoPJTYds9WcN79RerTZzkd663+qs28KJm/ZeIuJWDBJ9+rCeh?=
 =?iso-8859-1?Q?bq2NZRKf1ylAMJGB5WA2Q1PGzPdRaq921nifog2bL9/uFHa6/q5EGUGF/R?=
 =?iso-8859-1?Q?7tWWWvNlAKRVb1p+rH59M5I5pTelvp5kfoM1rmvUVhPhUD2Z5pZSdo+G7C?=
 =?iso-8859-1?Q?RRWRVUTE3LVs6h+/YC+qJxmMaFj9oKTPPmMn6of+hZBfpFCh8LpTm900Kz?=
 =?iso-8859-1?Q?Ap75ZJtm7xP4Y4PyM6FSXRfCoJMa6eOk0LnlKT6l/DuIPoHKVoN5953TAP?=
 =?iso-8859-1?Q?JAmDo/8XYARqcnbXYBEsxb7uhPodEDCjRpGlrFr4O2kmttzQoYTJsTSJiU?=
 =?iso-8859-1?Q?W8VyAbPE/FoOL4homOj1d8rttX59X58QpUgLRVi8SQEXroliRUb9ryVYra?=
 =?iso-8859-1?Q?MA51oWdZM8BNBB+6vrpigpvNg9H9e3SGlDBLoA3qJWne41F3LSwHfTKfZZ?=
 =?iso-8859-1?Q?H8CDjocb/s3uEye4RtBuIw3Y4ifYQaEFQ/OLIt1eZPnjyENAnNE759yAnf?=
 =?iso-8859-1?Q?TBiAhBPPBf6ki6sf7wxaP2olPqBtlYNf8hhstHBnLmO90v/LmPM+opRBE9?=
 =?iso-8859-1?Q?rvNuadUafYzN9FVUKQ5C8XfQ9N4XU/owC8Q1kbhQ6vCRUfSuUysJcqZthb?=
 =?iso-8859-1?Q?WuIsgkQ8Y+z+jVGwcyORSaEEsld4IbOves5OhRLuZlklW9nuxVvKrKtdot?=
 =?iso-8859-1?Q?0qj+9OjNG37M8LLxDsLpvFtMlQxKd6gqEs4Q5f2bj1u0xq3kLaga7XlHqG?=
 =?iso-8859-1?Q?yTlvuqoQhg1hwoCwhB5iz3Dzsc88tkUKRKyaTr8M4MMa6I/1RPuIoonnr9?=
 =?iso-8859-1?Q?0UkWvpuZQdXuegod2k/HUnKOqiTPm3Us7IkNHh8lULPaAUHeAwBjBqpHM2?=
 =?iso-8859-1?Q?1gLmHbrs9GEPgyxoslHtG6ECHjVrJ2/FBtP4hz6EpJZ1LPcHB9f1heSvXY?=
 =?iso-8859-1?Q?P4AJYHJ6Dfkp9oFeB5EwDBWex8eXnA1RhGYeVKzlCeN+RT//BYBA214GzA?=
 =?iso-8859-1?Q?ts054aFGJElaNUueUHb3+WMuCF40sGWBCpO8QrX7e7OpotX5g1cpmmCLTW?=
 =?iso-8859-1?Q?xNh3UYX1NxhC9PrA5eli0T8UwWOElvEY1CFcLXpzgnyC2f1fHBVg4xkGlo?=
 =?iso-8859-1?Q?l4euO9I15HbpF2+McVoGL3Xo+V0zu/40Vw9As7jhl8QERVVJa1UA5GH1Bc?=
 =?iso-8859-1?Q?XN9kpyzSgDRXHjEaXunzl5TiA6qxh?=
x-microsoft-antispam-prvs: <VI1PR04MB6270FF383FDF5FD1B57AC42492710@VI1PR04MB6270.eurprd04.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(189003)(199004)(186003)(26005)(81156014)(81166006)(76176011)(8676002)(52116002)(102836004)(66066001)(2906002)(105586002)(386003)(6506007)(106356001)(478600001)(86362001)(305945005)(7736002)(99286004)(256004)(446003)(11346002)(2616005)(486006)(44832011)(476003)(316002)(966005)(97736004)(6116002)(3846002)(36756003)(4326008)(8936002)(50226002)(68736007)(54906003)(110136005)(14454004)(71200400001)(6436002)(6486002)(53936002)(25786009)(6306002)(6512007)(71190400001)(5660300002)(7416002)(30864003)(6636002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB6270;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6HOO8k1H8XQgnzdSHM+zMEFofl5/pdHmpocVyAJxEZLzTPNTE4myZLwh9w+zhu8VIOip1pAN7p04pP8ylJpz+H9TJVa5dD//BIHYc0becKKKPHSJqaragXTuaKRev0JAJG43W20TWFMvsPjERIk6sZwxVoB6+b4V/bVkENxMNrgBOuJIDnV0DVbwBd4CGAbaYszecGSKPtUSuXy7HFtG/UwDQxpDZAKBR63e4a8+AsoVy++bD/VVumcRRUCEh1bn4H5rbSCEX3+D7dPq88bXdd2AzIYIepCw4spAJqvNE4Z50qbTfHBrbMx8gH4QlcHMBz9IPbDDt2BLnq+jr8H1Q/CKKBF3IAeSt+mQN/clQb0lJ5Pr1AZZK8Vqk6QTwhT1iXOiV5J+QuqdfjHco+4158MK/b+yBvFZ1sPfx5iE0os=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 519e3426-1b59-46f4-94c6-08d6a08d424b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 10:36:28.5208 (UTC)
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

This patch implements Audio Mixer machine driver for NXP iMX8 SOCs.
It connects together Audio Mixer and related SAI instances.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/Kconfig      |   9 ++
 sound/soc/fsl/Makefile     |   2 +
 sound/soc/fsl/imx-audmix.c | 327 +++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 338 insertions(+)
 create mode 100644 sound/soc/fsl/imx-audmix.c

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 0af2e056..d87c842 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -303,6 +303,15 @@ config SND_SOC_FSL_ASOC_CARD
 	 CS4271, CS4272 and SGTL5000.
 	 Say Y if you want to add support for Freescale Generic ASoC Sound Card.
=20
+config SND_SOC_IMX_AUDMIX
+	tristate "SoC Audio support for i.MX boards with AUDMIX"
+	select SND_SOC_FSL_AUDMIX
+	select SND_SOC_FSL_SAI
+	help
+	  SoC Audio support for i.MX boards with Audio Mixer
+	  Say Y if you want to add support for SoC audio on an i.MX board with
+	  an Audio Mixer.
+
 endif # SND_IMX_SOC
=20
 endmenu
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index 4172d5a..c0dd044 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -62,6 +62,7 @@ snd-soc-imx-es8328-objs :=3D imx-es8328.o
 snd-soc-imx-sgtl5000-objs :=3D imx-sgtl5000.o
 snd-soc-imx-spdif-objs :=3D imx-spdif.o
 snd-soc-imx-mc13783-objs :=3D imx-mc13783.o
+snd-soc-imx-audmix-objs :=3D imx-audmix.o
=20
 obj-$(CONFIG_SND_SOC_EUKREA_TLV320) +=3D snd-soc-eukrea-tlv320.o
 obj-$(CONFIG_SND_SOC_PHYCORE_AC97) +=3D snd-soc-phycore-ac97.o
@@ -71,3 +72,4 @@ obj-$(CONFIG_SND_SOC_IMX_ES8328) +=3D snd-soc-imx-es8328.=
o
 obj-$(CONFIG_SND_SOC_IMX_SGTL5000) +=3D snd-soc-imx-sgtl5000.o
 obj-$(CONFIG_SND_SOC_IMX_SPDIF) +=3D snd-soc-imx-spdif.o
 obj-$(CONFIG_SND_SOC_IMX_MC13783) +=3D snd-soc-imx-mc13783.o
+obj-$(CONFIG_SND_SOC_IMX_AUDMIX) +=3D snd-soc-imx-audmix.o
diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
new file mode 100644
index 0000000..72e37ca
--- /dev/null
+++ b/sound/soc/fsl/imx-audmix.c
@@ -0,0 +1,327 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2017 NXP
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/clk.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <linux/pm_runtime.h>
+#include "fsl_sai.h"
+#include "fsl_audmix.h"
+
+struct imx_audmix {
+	struct platform_device *pdev;
+	struct snd_soc_card card;
+	struct platform_device *audmix_pdev;
+	struct platform_device *out_pdev;
+	struct clk *cpu_mclk;
+	int num_dai;
+	struct snd_soc_dai_link *dai;
+	int num_dai_conf;
+	struct snd_soc_codec_conf *dai_conf;
+	int num_dapm_routes;
+	struct snd_soc_dapm_route *dapm_routes;
+};
+
+static const u32 imx_audmix_rates[] =3D {
+	8000, 12000, 16000, 24000, 32000, 48000, 64000, 96000,
+};
+
+static const struct snd_pcm_hw_constraint_list imx_audmix_rate_constraints=
 =3D {
+	.count =3D ARRAY_SIZE(imx_audmix_rates),
+	.list =3D imx_audmix_rates,
+};
+
+static int imx_audmix_fe_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
+	struct imx_audmix *priv =3D snd_soc_card_get_drvdata(rtd->card);
+	struct snd_pcm_runtime *runtime =3D substream->runtime;
+	struct device *dev =3D rtd->card->dev;
+	unsigned long clk_rate =3D clk_get_rate(priv->cpu_mclk);
+	int ret;
+
+	if (clk_rate % 24576000 =3D=3D 0) {
+		ret =3D snd_pcm_hw_constraint_list(runtime, 0,
+						 SNDRV_PCM_HW_PARAM_RATE,
+						 &imx_audmix_rate_constraints);
+		if (ret < 0)
+			return ret;
+	} else {
+		dev_warn(dev, "mclk may be not supported %lu\n", clk_rate);
+	}
+
+	ret =3D snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_CHANNELS=
,
+					   1, 8);
+	if (ret < 0)
+		return ret;
+
+	return snd_pcm_hw_constraint_mask64(runtime, SNDRV_PCM_HW_PARAM_FORMAT,
+					    FSL_AUDMIX_FORMATS);
+}
+
+static int imx_audmix_fe_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
+	struct device *dev =3D rtd->card->dev;
+	bool tx =3D substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK;
+	unsigned int fmt =3D SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_NB_NF;
+	u32 channels =3D params_channels(params);
+	int ret, dir;
+
+	/* For playback the AUDMIX is slave, and for record is master */
+	fmt |=3D tx ? SND_SOC_DAIFMT_CBS_CFS : SND_SOC_DAIFMT_CBM_CFM;
+	dir  =3D tx ? SND_SOC_CLOCK_OUT : SND_SOC_CLOCK_IN;
+
+	/* set DAI configuration */
+	ret =3D snd_soc_dai_set_fmt(rtd->cpu_dai, fmt);
+	if (ret) {
+		dev_err(dev, "failed to set cpu dai fmt: %d\n", ret);
+		return ret;
+	}
+
+	ret =3D snd_soc_dai_set_sysclk(rtd->cpu_dai, FSL_SAI_CLK_MAST1, 0, dir);
+	if (ret) {
+		dev_err(dev, "failed to set cpu sysclk: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Per datasheet, AUDMIX expects 8 slots and 32 bits
+	 * for every slot in TDM mode.
+	 */
+	ret =3D snd_soc_dai_set_tdm_slot(rtd->cpu_dai, BIT(channels) - 1,
+				       BIT(channels) - 1, 8, 32);
+	if (ret)
+		dev_err(dev, "failed to set cpu dai tdm slot: %d\n", ret);
+
+	return ret;
+}
+
+static int imx_audmix_be_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
+	struct device *dev =3D rtd->card->dev;
+	bool tx =3D substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK;
+	unsigned int fmt =3D SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_NB_NF;
+	int ret;
+
+	if (!tx)
+		return 0;
+
+	/* For playback the AUDMIX is slave */
+	fmt |=3D SND_SOC_DAIFMT_CBM_CFM;
+
+	/* set AUDMIX DAI configuration */
+	ret =3D snd_soc_dai_set_fmt(rtd->cpu_dai, fmt);
+	if (ret)
+		dev_err(dev, "failed to set AUDMIX DAI fmt: %d\n", ret);
+
+	return ret;
+}
+
+static struct snd_soc_ops imx_audmix_fe_ops =3D {
+	.startup =3D imx_audmix_fe_startup,
+	.hw_params =3D imx_audmix_fe_hw_params,
+};
+
+static struct snd_soc_ops imx_audmix_be_ops =3D {
+	.hw_params =3D imx_audmix_be_hw_params,
+};
+
+static int imx_audmix_probe(struct platform_device *pdev)
+{
+	struct device_node *np =3D pdev->dev.of_node;
+	struct device_node *audmix_np =3D NULL, *out_cpu_np =3D NULL;
+	struct platform_device *audmix_pdev =3D NULL;
+	struct platform_device *cpu_pdev;
+	struct of_phandle_args args;
+	struct imx_audmix *priv;
+	int i, num_dai, ret;
+	const char *fe_name_pref =3D "HiFi-AUDMIX-FE-";
+	char *be_name, *be_pb, *be_cp, *dai_name, *capture_dai_name;
+
+	if (pdev->dev.parent) {
+		audmix_np =3D pdev->dev.parent->of_node;
+	} else {
+		dev_err(&pdev->dev, "Missing parent device.\n");
+		return -EINVAL;
+	}
+
+	if (!audmix_np) {
+		dev_err(&pdev->dev, "Missign DT node for parent device.\n");
+		return -EINVAL;
+	}
+
+	audmix_pdev =3D of_find_device_by_node(audmix_np);
+	if (!audmix_pdev) {
+		dev_err(&pdev->dev, "Missing AUDMIX platform device for %s\n",
+			np->full_name);
+		return -EINVAL;
+	}
+
+	num_dai =3D of_count_phandle_with_args(audmix_np, "dais", NULL);
+	if (num_dai !=3D FSL_AUDMIX_MAX_DAIS) {
+		dev_err(&pdev->dev, "Need 2 dais to be provided for %s\n",
+			audmix_np->full_name);
+		return -EINVAL;
+	}
+
+	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->num_dai =3D 2 * num_dai;
+	priv->dai =3D devm_kzalloc(&pdev->dev, priv->num_dai *
+				 sizeof(struct snd_soc_dai_link), GFP_KERNEL);
+	if (!priv->dai)
+		return -ENOMEM;
+
+	priv->num_dai_conf =3D num_dai;
+	priv->dai_conf =3D devm_kzalloc(&pdev->dev, priv->num_dai_conf *
+				      sizeof(struct snd_soc_codec_conf),
+				      GFP_KERNEL);
+	if (!priv->dai_conf)
+		return -ENOMEM;
+
+	priv->num_dapm_routes =3D 3 * num_dai;
+	priv->dapm_routes =3D devm_kzalloc(&pdev->dev, priv->num_dapm_routes *
+					 sizeof(struct snd_soc_dapm_route),
+					 GFP_KERNEL);
+	if (!priv->dapm_routes)
+		return -ENOMEM;
+
+	for (i =3D 0; i < num_dai; i++) {
+		ret =3D of_parse_phandle_with_args(audmix_np, "dais", NULL, i,
+						 &args);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "of_parse_phandle_with_args failed\n");
+			return ret;
+		}
+
+		cpu_pdev =3D of_find_device_by_node(args.np);
+		if (!cpu_pdev) {
+			dev_err(&pdev->dev, "failed to find SAI platform device\n");
+			return -EINVAL;
+		}
+
+		dai_name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s%s",
+					  fe_name_pref, args.np->full_name + 1);
+
+		dev_info(pdev->dev.parent, "DAI FE name:%s\n", dai_name);
+
+		if (i =3D=3D 0) {
+			out_cpu_np =3D args.np;
+			capture_dai_name =3D
+				devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s %s",
+					       dai_name, "CPU-Capture");
+		}
+
+		priv->dai[i].name =3D dai_name;
+		priv->dai[i].stream_name =3D "HiFi-AUDMIX-FE";
+		priv->dai[i].codec_dai_name =3D "snd-soc-dummy-dai";
+		priv->dai[i].codec_name =3D "snd-soc-dummy";
+		priv->dai[i].cpu_of_node =3D args.np;
+		priv->dai[i].cpu_dai_name =3D dev_name(&cpu_pdev->dev);
+		priv->dai[i].platform_of_node =3D args.np;
+		priv->dai[i].dynamic =3D 1;
+		priv->dai[i].dpcm_playback =3D 1;
+		priv->dai[i].dpcm_capture =3D (i =3D=3D 0 ? 1 : 0);
+		priv->dai[i].ignore_pmdown_time =3D 1;
+		priv->dai[i].ops =3D &imx_audmix_fe_ops;
+
+		/* Add AUDMIX Backend */
+		be_name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL,
+					 "audmix-%d", i);
+		be_pb =3D devm_kasprintf(&pdev->dev, GFP_KERNEL,
+				       "AUDMIX-Playback-%d", i);
+		be_cp =3D devm_kasprintf(&pdev->dev, GFP_KERNEL,
+				       "AUDMIX-Capture-%d", i);
+
+		priv->dai[num_dai + i].name =3D be_name;
+		priv->dai[num_dai + i].codec_dai_name =3D "snd-soc-dummy-dai";
+		priv->dai[num_dai + i].codec_name =3D "snd-soc-dummy";
+		priv->dai[num_dai + i].cpu_of_node =3D audmix_np;
+		priv->dai[num_dai + i].cpu_dai_name =3D be_name;
+		priv->dai[num_dai + i].platform_name =3D "snd-soc-dummy";
+		priv->dai[num_dai + i].no_pcm =3D 1;
+		priv->dai[num_dai + i].dpcm_playback =3D 1;
+		priv->dai[num_dai + i].dpcm_capture  =3D 1;
+		priv->dai[num_dai + i].ignore_pmdown_time =3D 1;
+		priv->dai[num_dai + i].ops =3D &imx_audmix_be_ops;
+
+		priv->dai_conf[i].of_node =3D args.np;
+		priv->dai_conf[i].name_prefix =3D dai_name;
+
+		priv->dapm_routes[i].source =3D
+			devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s %s",
+				       dai_name, "CPU-Playback");
+		priv->dapm_routes[i].sink =3D be_pb;
+		priv->dapm_routes[num_dai + i].source   =3D be_pb;
+		priv->dapm_routes[num_dai + i].sink     =3D be_cp;
+		priv->dapm_routes[2 * num_dai + i].source =3D be_cp;
+		priv->dapm_routes[2 * num_dai + i].sink   =3D capture_dai_name;
+	}
+
+	cpu_pdev =3D of_find_device_by_node(out_cpu_np);
+	if (!cpu_pdev) {
+		dev_err(&pdev->dev, "failed to find SAI platform device\n");
+		return -EINVAL;
+	}
+	priv->cpu_mclk =3D devm_clk_get(&cpu_pdev->dev, "mclk1");
+	if (IS_ERR(priv->cpu_mclk)) {
+		ret =3D PTR_ERR(priv->cpu_mclk);
+		dev_err(&cpu_pdev->dev, "failed to get DAI mclk1: %d\n", ret);
+		return -EINVAL;
+	}
+
+	priv->audmix_pdev =3D audmix_pdev;
+	priv->out_pdev  =3D cpu_pdev;
+
+	priv->card.dai_link =3D priv->dai;
+	priv->card.num_links =3D priv->num_dai;
+	priv->card.codec_conf =3D priv->dai_conf;
+	priv->card.num_configs =3D priv->num_dai_conf;
+	priv->card.dapm_routes =3D priv->dapm_routes;
+	priv->card.num_dapm_routes =3D priv->num_dapm_routes;
+	priv->card.dev =3D pdev->dev.parent;
+	priv->card.owner =3D THIS_MODULE;
+	priv->card.name =3D "imx-audmix";
+
+	platform_set_drvdata(pdev, &priv->card);
+	snd_soc_card_set_drvdata(&priv->card, priv);
+
+	ret =3D devm_snd_soc_register_card(pdev->dev.parent, &priv->card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card failed\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static struct platform_driver imx_audmix_driver =3D {
+	.probe =3D imx_audmix_probe,
+	.driver =3D {
+		.name =3D "imx-audmix",
+		.pm =3D &snd_soc_pm_ops,
+	},
+};
+module_platform_driver(imx_audmix_driver);
+
+MODULE_DESCRIPTION("NXP AUDMIX ASoC machine driver");
+MODULE_AUTHOR("Viorel Suman <viorel.suman@nxp.com>");
+MODULE_ALIAS("platform:imx-audmix");
+MODULE_LICENSE("GPL v2");
--=20
2.7.4


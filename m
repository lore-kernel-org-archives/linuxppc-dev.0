Return-Path: <emillbrandt@norco.coldhaus.com>
Received: from norco.coldhaus.com (norco.coldhaus.com [64.32.230.18])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (Client CN "norco.coldhaus.com",
 Issuer "StartCom Class 1 Primary Intermediate Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1D7432C0095
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 12:25:27 +1000 (EST)
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: Grant Likely <grant.likely@secretlab.ca>, Liam Girdwood <lrg@ti.com>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 5/5] ASoC: fsl: mpc5200 remove pcm030 and efika audio fabric
Date: Tue, 11 Sep 2012 22:14:49 -0400
Message-Id: <1347416089-23393-6-git-send-email-emillbrandt@dekaresearch.com>
In-Reply-To: <1347416089-23393-1-git-send-email-emillbrandt@dekaresearch.com>
References: <1347416089-23393-1-git-send-email-emillbrandt@dekaresearch.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MPC5200 ASoC setup can now be done in the device tree.

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
---
 sound/soc/fsl/Kconfig               |   17 -------
 sound/soc/fsl/Makefile              |    2 -
 sound/soc/fsl/efika-audio-fabric.c  |   91 -----------------------------------
 sound/soc/fsl/pcm030-audio-fabric.c |   91 -----------------------------------
 4 files changed, 0 insertions(+), 201 deletions(-)
 delete mode 100644 sound/soc/fsl/efika-audio-fabric.c
 delete mode 100644 sound/soc/fsl/pcm030-audio-fabric.c

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index b3eee63..54ba798 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -70,23 +70,6 @@ config SND_MPC52xx_SOC_AUDIO
 	  Say Y if you want to generic device-tree support for sound on the
 	  Freescale MPC5200
 
-config SND_MPC52xx_SOC_PCM030
-	tristate "SoC AC97 Audio support for Phytec pcm030 and WM9712"
-	depends on PPC_MPC5200_SIMPLE
-	select SND_SOC_MPC5200_AC97
-	select SND_SOC_WM9712
-	help
-	  Say Y if you want to add support for sound on the Phytec pcm030
-	  baseboard.
-
-config SND_MPC52xx_SOC_EFIKA
-	tristate "SoC AC97 Audio support for bbplan Efika and STAC9766"
-	depends on PPC_EFIKA
-	select SND_SOC_MPC5200_AC97
-	select SND_SOC_STAC9766
-	help
-	  Say Y if you want to add support for sound on the Efika.
-
 endif # SND_POWERPC_SOC
 
 menuconfig SND_IMX_SOC
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index d2e2e68..bd5f511 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -21,8 +21,6 @@ obj-$(CONFIG_SND_SOC_MPC5200_AC97) += mpc5200_psc_ac97.o
 
 # MPC5200 Machine Support
 obj-$(CONFIG_SND_MPC52xx_SOC_AUDIO) += mpc5200_soc_audio.o
-obj-$(CONFIG_SND_MPC52xx_SOC_PCM030) += pcm030-audio-fabric.o
-obj-$(CONFIG_SND_MPC52xx_SOC_EFIKA) += efika-audio-fabric.o
 
 # i.MX Platform Support
 snd-soc-imx-ssi-objs := imx-ssi.o
diff --git a/sound/soc/fsl/efika-audio-fabric.c b/sound/soc/fsl/efika-audio-fabric.c
deleted file mode 100644
index b2acd329..0000000
--- a/sound/soc/fsl/efika-audio-fabric.c
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- * Efika driver for the PSC of the Freescale MPC52xx
- * configured as AC97 interface
- *
- * Copyright 2008 Jon Smirl, Digispeaker
- * Author: Jon Smirl <jonsmirl@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/device.h>
-#include <linux/delay.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
-#include <linux/dma-mapping.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/initval.h>
-#include <sound/soc.h>
-
-#include "mpc5200_dma.h"
-#include "mpc5200_psc_ac97.h"
-#include "../codecs/stac9766.h"
-
-#define DRV_NAME "efika-audio-fabric"
-
-static struct snd_soc_dai_link efika_fabric_dai[] = {
-{
-	.name = "AC97",
-	.stream_name = "AC97 Analog",
-	.codec_dai_name = "stac9766-hifi-analog",
-	.cpu_dai_name = "mpc5200-psc-ac97.0",
-	.platform_name = "mpc5200-pcm-audio",
-	.codec_name = "stac9766-codec",
-},
-{
-	.name = "AC97",
-	.stream_name = "AC97 IEC958",
-	.codec_dai_name = "stac9766-hifi-IEC958",
-	.cpu_dai_name = "mpc5200-psc-ac97.1",
-	.platform_name = "mpc5200-pcm-audio",
-	.codec_name = "stac9766-codec",
-},
-};
-
-static struct snd_soc_card card = {
-	.name = "Efika",
-	.owner = THIS_MODULE,
-	.dai_link = efika_fabric_dai,
-	.num_links = ARRAY_SIZE(efika_fabric_dai),
-};
-
-static __init int efika_fabric_init(void)
-{
-	struct platform_device *pdev;
-	int rc;
-
-	if (!of_machine_is_compatible("bplan,efika"))
-		return -ENODEV;
-
-	pdev = platform_device_alloc("soc-audio", 1);
-	if (!pdev) {
-		pr_err("efika_fabric_init: platform_device_alloc() failed\n");
-		return -ENODEV;
-	}
-
-	platform_set_drvdata(pdev, &card);
-
-	rc = platform_device_add(pdev);
-	if (rc) {
-		pr_err("efika_fabric_init: platform_device_add() failed\n");
-		platform_device_put(pdev);
-		return -ENODEV;
-	}
-	return 0;
-}
-
-module_init(efika_fabric_init);
-
-
-MODULE_AUTHOR("Jon Smirl <jonsmirl@gmail.com>");
-MODULE_DESCRIPTION(DRV_NAME ": mpc5200 Efika fabric driver");
-MODULE_LICENSE("GPL");
-
diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
deleted file mode 100644
index b3af55d..0000000
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- * Phytec pcm030 driver for the PSC of the Freescale MPC52xx
- * configured as AC97 interface
- *
- * Copyright 2008 Jon Smirl, Digispeaker
- * Author: Jon Smirl <jonsmirl@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/device.h>
-#include <linux/delay.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
-#include <linux/dma-mapping.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/initval.h>
-#include <sound/soc.h>
-
-#include "mpc5200_dma.h"
-#include "mpc5200_psc_ac97.h"
-#include "../codecs/wm9712.h"
-
-#define DRV_NAME "pcm030-audio-fabric"
-
-static struct snd_soc_dai_link pcm030_fabric_dai[] = {
-{
-	.name = "AC97",
-	.stream_name = "AC97 Analog",
-	.codec_dai_name = "wm9712-hifi",
-	.cpu_dai_name = "mpc5200-psc-ac97.0",
-	.platform_name = "mpc5200-pcm-audio",
-	.codec_name = "wm9712-codec",
-},
-{
-	.name = "AC97",
-	.stream_name = "AC97 IEC958",
-	.codec_dai_name = "wm9712-aux",
-	.cpu_dai_name = "mpc5200-psc-ac97.1",
-	.platform_name = "mpc5200-pcm-audio",
-	.codec_name = "wm9712-codec",
-},
-};
-
-static struct snd_soc_card card = {
-	.name = "pcm030",
-	.owner = THIS_MODULE,
-	.dai_link = pcm030_fabric_dai,
-	.num_links = ARRAY_SIZE(pcm030_fabric_dai),
-};
-
-static __init int pcm030_fabric_init(void)
-{
-	struct platform_device *pdev;
-	int rc;
-
-	if (!of_machine_is_compatible("phytec,pcm030"))
-		return -ENODEV;
-
-	pdev = platform_device_alloc("soc-audio", 1);
-	if (!pdev) {
-		pr_err("pcm030_fabric_init: platform_device_alloc() failed\n");
-		return -ENODEV;
-	}
-
-	platform_set_drvdata(pdev, &card);
-
-	rc = platform_device_add(pdev);
-	if (rc) {
-		pr_err("pcm030_fabric_init: platform_device_add() failed\n");
-		platform_device_put(pdev);
-		return -ENODEV;
-	}
-	return 0;
-}
-
-module_init(pcm030_fabric_init);
-
-
-MODULE_AUTHOR("Jon Smirl <jonsmirl@gmail.com>");
-MODULE_DESCRIPTION(DRV_NAME ": mpc5200 pcm030 fabric driver");
-MODULE_LICENSE("GPL");
-
-- 
1.7.2.5

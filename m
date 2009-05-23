Return-Path: <jonsmirl@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id E999DDE184
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 09:13:14 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1211819ywt.39
	for <linuxppc-dev@ozlabs.org>; Sat, 23 May 2009 16:13:14 -0700 (PDT)
Subject: [PATCH V2 9/9] Support for AC97 on Phytec pmc030 base board.
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, broonie@sirena.org.uk
From: Jon Smirl <jonsmirl@gmail.com>
Date: Sat, 23 May 2009 19:13:13 -0400
Message-ID: <20090523231313.17919.93066.stgit@terra>
In-Reply-To: <20090523231148.17919.46103.stgit@terra>
References: <20090523231148.17919.46103.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Support for AC97 on Phytec pmc030 base board. A wm9712 AC97 codec is used.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 sound/soc/fsl/Kconfig               |    7 +++
 sound/soc/fsl/Makefile              |    1 
 sound/soc/fsl/pcm030-audio-fabric.c |   94 +++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/fsl/pcm030-audio-fabric.c

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index edd8516..5080e3e 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -47,4 +47,11 @@ config SND_MPC52xx_SOC_EFIKA
 	help
 	  Say Y if you want to add support for sound on the Efika.
 
+config SND_MPC52xx_SOC_PCM030
+	tristate "SoC AC97 Audio support for Phytec pcm030 and WM9712"
+	depends on PPC_MPC5200_SIMPLE
+	select SND_SOC_MPC5200_AC97
+	select SND_SOC_WM9712
+	help
+	  Say Y if you want to add support for sound on the Phytec pcm030 baseboard.
 
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index f406470..5806d11 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -17,4 +17,5 @@ obj-$(CONFIG_SND_SOC_MPC5200_AC97) += mpc5200_psc_ac97.o
 
 # MPC5200 Machine Support
 obj-$(CONFIG_SND_MPC52xx_SOC_EFIKA) += efika-audio-fabric.o
+obj-$(CONFIG_SND_MPC52xx_SOC_PCM030) += pcm030-audio-fabric.o
 
diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
new file mode 100644
index 0000000..4bd957a
--- /dev/null
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -0,0 +1,94 @@
+/*
+ * Phytec pcm030 driver for the PSC of the Freescale MPC52xx configured as AC97 interface
+ *
+ * Copyright 2008 Jon Smirl, Digispeaker
+ * Author: Jon Smirl <jonsmirl@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/dma-mapping.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+#include <sound/soc-of-simple.h>
+
+#include "mpc5200_dma.h"
+#include "mpc5200_psc_ac97.h"
+#include "../codecs/wm9712.h"
+
+static struct snd_soc_device device;
+static struct snd_soc_card card;
+
+static struct snd_soc_dai_link pcm030_fabric_dai[] = {
+{
+	.name = "AC97",
+	.stream_name = "AC97 Analog",
+	.codec_dai = &wm9712_dai[WM9712_DAI_AC97_HIFI],
+	.cpu_dai = &psc_ac97_dai[MPC5200_AC97_NORMAL],
+},
+{
+	.name = "AC97",
+	.stream_name = "AC97 IEC958",
+	.codec_dai = &wm9712_dai[WM9712_DAI_AC97_AUX],
+	.cpu_dai = &psc_ac97_dai[MPC5200_AC97_SPDIF],
+},
+};
+
+static __init int pcm030_fabric_init(void)
+{
+	struct platform_device *pdev;
+	int rc;
+
+	if (!machine_is_compatible("phytec,pcm030"))
+		return -ENODEV;
+
+	card.platform = &mpc5200_audio_dma_platform;
+	card.name = "pcm030";
+	card.dai_link = pcm030_fabric_dai;
+	card.num_links = ARRAY_SIZE(pcm030_fabric_dai);
+
+	device.card = &card;
+	device.codec_dev = &soc_codec_dev_wm9712;
+
+	pdev = platform_device_alloc("soc-audio", 1);
+	if (!pdev) {
+		pr_err("pcm030_fabric_init: platform_device_alloc() failed\n");
+		return -ENODEV;
+	}
+
+	platform_set_drvdata(pdev, &device);
+	device.dev = &pdev->dev;
+
+	rc = platform_device_add(pdev);
+	if (rc) {
+		pr_err("pcm030_fabric_init: platform_device_add() failed\n");
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static __exit void pcm030_fabric_exit(void)
+{
+}
+
+module_init(pcm030_fabric_init);
+module_exit(pcm030_fabric_exit);
+
+
+MODULE_AUTHOR("Jon Smirl <jonsmirl@gmail.com>");
+MODULE_DESCRIPTION(DRV_NAME ": mpc5200 pcm030 fabric driver");
+MODULE_LICENSE("GPL");
+

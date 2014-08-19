Return-Path: <shengjiu.wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0182.outbound.protection.outlook.com [207.46.163.182])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6DECF1A0877
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 19:36:59 +1000 (EST)
From: Shengjiu Wang <shengjiu.wang@freescale.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.de>, <nicoleotsuka@gmail.com>, <Li.Xiubo@freescale.com>,
 <shc_work@mail.ru>, <fabio.estevam@freescale.com>,
 <shengjiu.wang@freescale.com>, <xobs@kosagi.com>, <arnd@arndb.de>,
 <sfr@canb.auug.org.au>, <timur@tabi.org>
Subject: [PATCH V2] ASoC: fsl-asoc-card: move 'config SND_SOC_FSL_ASOC_CARD'
 to 'if SND_IMX_SOC'
Date: Tue, 19 Aug 2014 17:36:41 +0800
Message-ID: <bfed4dfd3cf1ef134dac1f114f3d2b8cedf55c68.1408440952.git.shengjiu.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Build kernel with SND_SOC_FSL_ASOC_CARD=m && SND_SOC_FSL_{SSI,SAI,ESAI}=y
leads the following error:

   sound/built-in.o: In function `fsl_sai_probe':
>> fsl_sai.c:(.text+0x5f662): undefined reference to `imx_pcm_dma_init'
   sound/built-in.o: In function `fsl_esai_probe':
>> fsl_esai.c:(.text+0x6044b): undefined reference to `imx_pcm_dma_init'

The config SND_SOC_FSL_ASOC_CARD is for IMX SOC, So move it under condition
of 'if SND_IMX_SOC'.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 sound/soc/fsl/Kconfig |   34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 417ff70..9348fef 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -58,23 +58,6 @@ config SND_SOC_FSL_ESAI
 config SND_SOC_FSL_UTILS
 	tristate
 
-config SND_SOC_FSL_ASOC_CARD
-	tristate "Generic ASoC Sound Card with ASRC support"
-	depends on OF && I2C
-	select SND_SOC_IMX_AUDMUX
-	select SND_SOC_IMX_PCM_DMA
-	select SND_SOC_FSL_ESAI
-	select SND_SOC_FSL_SAI
-	select SND_SOC_FSL_SSI
-	select SND_SOC_CS42XX8_I2C
-	select SND_SOC_SGTL5000
-	select SND_SOC_WM8962
-	help
-	 ALSA SoC Audio support with ASRC feature for Freescale SoCs that have
-	 ESAI/SAI/SSI and connect with external CODECs such as WM8962, CS42888
-	 and SGTL5000.
-	 Say Y if you want to add support for Freescale Generic ASoC Sound Card.
-
 config SND_SOC_IMX_PCM_DMA
 	tristate
 	select SND_SOC_GENERIC_DMAENGINE_PCM
@@ -285,6 +268,23 @@ config SND_SOC_IMX_MC13783
 	select SND_SOC_MC13783
 	select SND_SOC_IMX_PCM_DMA
 
+config SND_SOC_FSL_ASOC_CARD
+	tristate "Generic ASoC Sound Card with ASRC support"
+	depends on OF && I2C
+	select SND_SOC_IMX_AUDMUX
+	select SND_SOC_IMX_PCM_DMA
+	select SND_SOC_FSL_ESAI
+	select SND_SOC_FSL_SAI
+	select SND_SOC_FSL_SSI
+	select SND_SOC_CS42XX8_I2C
+	select SND_SOC_SGTL5000
+	select SND_SOC_WM8962
+	help
+	 ALSA SoC Audio support with ASRC feature for Freescale SoCs that have
+	 ESAI/SAI/SSI and connect with external CODECs such as WM8962, CS42888
+	 and SGTL5000.
+	 Say Y if you want to add support for Freescale Generic ASoC Sound Card.
+
 endif # SND_IMX_SOC
 
 endmenu
-- 
1.7.9.5

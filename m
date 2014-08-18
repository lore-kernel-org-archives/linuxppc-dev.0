Return-Path: <shengjiu.wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0181.outbound.protection.outlook.com [207.46.163.181])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 902B01A003B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Aug 2014 18:39:23 +1000 (EST)
From: Shengjiu Wang <shengjiu.wang@freescale.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.de>, <nicoleotsuka@gmail.com>, <Li.Xiubo@freescale.com>,
 <shc_work@mail.ru>, <fabio.estevam@freescale.com>,
 <shengjiu.wang@freescale.com>, <xobs@kosagi.com>, <arnd@arndb.de>,
 <sfr@canb.auug.org.au>, <timur@tabi.org>
Subject: [PATCH V1 1/3] ASoC: fsl: Kconfig: remove dependence of SND_IMX_SOC
 for SND_SOC_IMX_PCM_DMA
Date: Mon, 18 Aug 2014 16:38:38 +0800
Message-ID: <f30ba4e2c4eb6702fa40bd255036e6e9ad6eb47d.1408350626.git.shengjiu.wang@freescale.com>
In-Reply-To: <cover.1408350626.git.shengjiu.wang@freescale.com>
References: <cover.1408350626.git.shengjiu.wang@freescale.com>
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

Build kernel with SND_SOC_IMC_PCM_DMA=m && SND_IMX_SOC=n leads the following
error:

   sound/built-in.o: In function `fsl_sai_probe':
>> fsl_sai.c:(.text+0x5f662): undefined reference to `imx_pcm_dma_init'
   sound/built-in.o: In function `fsl_esai_probe':
>> fsl_esai.c:(.text+0x6044b): undefined reference to `imx_pcm_dma_init'

Most cpu driver in soc/fsl has use the function 'imx_pcm_dma_init' which is
defined in imx-pcm-dma.c, so need to select SND_SOC_IMX_PCM_DMA, but it depends
on SND_IMX_SOC, if SND_IMX_SOC=n, then SND_SOC_IMX_PCM_DMA will not be
selected.
So remove the dependence of SND_IMX_SOC for SND_SOC_IMX_PCM_DMA.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 sound/soc/fsl/Kconfig |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 5ae777a..3a3732c 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -15,7 +15,7 @@ config SND_SOC_FSL_ASRC
 config SND_SOC_FSL_SAI
 	tristate "Synchronous Audio Interface (SAI) module support"
 	select REGMAP_MMIO
-	select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
+	select SND_SOC_IMX_PCM_DMA
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y if you want to add Synchronous Audio Interface (SAI)
@@ -25,7 +25,7 @@ config SND_SOC_FSL_SAI
 
 config SND_SOC_FSL_SSI
 	tristate "Synchronous Serial Interface module support"
-	select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
+	select SND_SOC_IMX_PCM_DMA
 	select SND_SOC_IMX_PCM_FIQ if SND_IMX_SOC != n && (MXC_TZIC || MXC_AVIC)
 	select REGMAP_MMIO
 	help
@@ -37,7 +37,7 @@ config SND_SOC_FSL_SSI
 config SND_SOC_FSL_SPDIF
 	tristate "Sony/Philips Digital Interface module support"
 	select REGMAP_MMIO
-	select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
+	select SND_SOC_IMX_PCM_DMA
 	select SND_SOC_IMX_PCM_FIQ if SND_IMX_SOC != n && (MXC_TZIC || MXC_AVIC)
 	help
 	  Say Y if you want to add Sony/Philips Digital Interface (SPDIF)
@@ -48,7 +48,7 @@ config SND_SOC_FSL_SPDIF
 config SND_SOC_FSL_ESAI
 	tristate "Enhanced Serial Audio Interface (ESAI) module support"
 	select REGMAP_MMIO
-	select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
+	select SND_SOC_IMX_PCM_DMA
 	help
 	  Say Y if you want to add Enhanced Synchronous Audio Interface
 	  (ESAI) support for the Freescale CPUs.
-- 
1.7.9.5

Return-Path: <shengjiu.wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0145.outbound.protection.outlook.com [207.46.163.145])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5ED251A0AA9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Aug 2014 18:39:37 +1000 (EST)
From: Shengjiu Wang <shengjiu.wang@freescale.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.de>, <nicoleotsuka@gmail.com>, <Li.Xiubo@freescale.com>,
 <shc_work@mail.ru>, <fabio.estevam@freescale.com>,
 <shengjiu.wang@freescale.com>, <xobs@kosagi.com>, <arnd@arndb.de>,
 <sfr@canb.auug.org.au>, <timur@tabi.org>
Subject: [PATCH V1 3/3] ASoC: fsl: fsl-asoc-card: Select SND_SOC_IMX_AUDMUX
Date: Mon, 18 Aug 2014 16:38:40 +0800
Message-ID: <ee71a6cacc1d0bc1459bf9c21efc755c16e955b1.1408350626.git.shengjiu.wang@freescale.com>
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

Building kernel with SND_SOC_IMX_AUDMUX=n leads to the following error:

   sound/built-in.o: In function `fsl_asoc_card_probe':
>> fsl-asoc-card.c:(.text+0x1467b5): undefined reference to `imx_audmux_v2_configure_port'
>> fsl-asoc-card.c:(.text+0x1467d0): undefined reference to `imx_audmux_v2_configure_port'
>> fsl-asoc-card.c:(.text+0x1467ed): undefined reference to `imx_audmux_v2_configure_port'
>> fsl-asoc-card.c:(.text+0x146807): undefined reference to `imx_audmux_v2_configure_port'

Update Kconfig to select SND_SOC_IMX_AUDMUX when SND_SOC_FSL_ASOC_CARD=y.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 sound/soc/fsl/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 3a3732c..dc0d08b 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -61,6 +61,7 @@ config SND_SOC_FSL_UTILS
 config SND_SOC_FSL_ASOC_CARD
 	tristate "Generic ASoC Sound Card with ASRC support"
 	depends on OF && I2C
+	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_IMX_PCM_DMA
 	select SND_SOC_FSL_ESAI
 	select SND_SOC_FSL_SAI
-- 
1.7.9.5

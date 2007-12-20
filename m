Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id AFD5DDE5CA
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 15:00:15 +1100 (EST)
Date: Wed, 19 Dec 2007 22:06:34 -0600
From: Olof Johansson <olof@lixom.net>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Message-ID: <20071220040633.GA6732@lixom.net>
References: <11981089894052-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11981089894052-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

This is a fairly substantial driver to get through, but here are some
initial comments on some of the simpler stuff:


On Wed, Dec 19, 2007 at 06:03:09PM -0600, Timur Tabi wrote:
> This patch adds ALSA SoC device drivers for the Freescale MPC8610 SoC
> and the MPC8610-HPCD reference board.

[...]

> diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> index 6390895..6e1bde3 100644
> --- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> +++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> @@ -34,9 +34,27 @@
>  
>  #include <asm/mpic.h>
>  
> +#include <asm/of_platform.h>
>  #include <sysdev/fsl_pci.h>
>  #include <sysdev/fsl_soc.h>
>  
> +static struct of_device_id mpc8610_ids[] = {
> +	{ .type = "soc", },
> +	{}

Please scan based on compatible instead of device_type.

> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> new file mode 100644
> index 0000000..4a5bbd2
> --- /dev/null
> +++ b/sound/soc/fsl/Kconfig
> @@ -0,0 +1,21 @@
> +menu "ALSA SoC audio for Freescale SOCs"
> +
> +config SND_SOC_MPC8610
> +	bool "ALSA SoC support for the MPC8610 SOC"
> +	depends on SND_SOC #&& MPC8610_HPCD
> +	default y #if MPC8610
> +	help
> +	  Say Y if you want to add support for codecs attached to the SSI
> +          device on an MPC8610.

Don't default configs to 'y'. Also, what's with the commented-out
dependencies and if?

> +config SND_SOC_MPC8610_HPCD
> +	# ALSA SoC support for Freescale MPC8610HPCD
> +	bool "ALSA SoC support for the Freescale MPC8610 HPCD board"
> +	depends on SND_SOC_MPC8610
> +	select SND_SOC_CS4270
> +	select SND_SOC_CS4270_VD33_ERRATA
> +	default y #if MPC8610_HPCD
> +	help
> +	  Say Y if you want to enable audio on the Freescale MPC8610 HPCD.

Same here w.r.t. defaults and dependencies.

> diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
> new file mode 100644
> index 0000000..6b86be0
> --- /dev/null
> +++ b/sound/soc/fsl/fsl_dma.c
> @@ -0,0 +1,819 @@
> +/*
> + * Freescale DMA ALSA SoC PCM driver
> + *
> + * Author: Timur Tabi <timur@freescale.com>
> + *
> + * Copyright 2007 Freescale Semiconductor, Inc.  This file is licensed under
> + * the terms of the GNU General Public License version 2.  This program
> + * is licensed "as is" without any warranty of any kind, whether express
> + * or implied.
> + *
> + * This driver implements ASoC support for the Elo DMA controller, which is
> + * the DMA controller on Freescale 83xx, 85xx, and 86xx SOCs. In ALSA terms,
> + * the PCM driver is what handles the DMA buffer.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +
> +#include <sound/driver.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +
> +#include <asm/io.h>
> +
> +#include "fsl_dma.h"
> +
> +/*
> + * The formats that the DMA controller supports, which is anything
> + * that is 8, 16, or 32 bits.
> + */
> +#define FSLDMA_PCM_FORMATS (SNDRV_PCM_FMTBIT_S8 	| \
> +			    SNDRV_PCM_FMTBIT_U8 	| \
> +			    SNDRV_PCM_FMTBIT_S16_LE     | \
> +			    SNDRV_PCM_FMTBIT_S16_BE     | \
> +			    SNDRV_PCM_FMTBIT_U16_LE     | \
> +			    SNDRV_PCM_FMTBIT_U16_BE     | \
> +			    SNDRV_PCM_FMTBIT_S24_LE     | \
> +			    SNDRV_PCM_FMTBIT_S24_BE     | \
> +			    SNDRV_PCM_FMTBIT_U24_LE     | \
> +			    SNDRV_PCM_FMTBIT_U24_BE     | \
> +			    SNDRV_PCM_FMTBIT_S32_LE     | \
> +			    SNDRV_PCM_FMTBIT_S32_BE     | \
> +			    SNDRV_PCM_FMTBIT_U32_LE     | \
> +			    SNDRV_PCM_FMTBIT_U32_BE)
> +
> +#define FSLDMA_PCM_RATES (SNDRV_PCM_RATE_5512 | SNDRV_PCM_RATE_8000_192000 | \
> +			  SNDRV_PCM_RATE_CONTINUOUS)
> +
> +/* DMA global data.  This structure is used by fsl_dma_open() to determine
> + * which DMA channels to assign to a substream.  Unfortunately, ASoC V1 does
> + * not allow the machine driver to provide this information to the PCM
> + * driver in advance, and there's no way to differentiate between the two
> + * DMA controllers.  So for now, this driver only supports one SSI device
> + * using two DMA channels.  We cannot support multiple DMA devices.
> + *
> + * ssi_stx_phys: bus address of SSI STX register
> + * ssi_srx_phys: bus address of SSI SRX register
> + * dma_channel: pointer to the DMA channel's registers
> + * irq: IRQ for this DMA channel
> + * assigned: set to 1 if that DMA channel is assigned to a substream
> + */

This goes for the whole patch: You've got good documentation, but it's
not in docbook format. Please reformat it since it should be a pretty
simple thing to do.

> +/*
> + * Initialize this PCM driver.
> + *
> + * This function is called when the codec driver calls snd_soc_new_pcms(),
> + * once for each .dai_link in the machine driver's snd_soc_machine
> + * structure.
> + */
> +static int fsl_dma_new(struct snd_card *card, struct snd_soc_codec_dai *dai,
> +	struct snd_pcm *pcm)
> +{
> +	static u64 fsl_dma_dmamask = 0xffffffff;
> +	int ret;
> +
> +	if (!card->dev->dma_mask)
> +		card->dev->dma_mask = &fsl_dma_dmamask;

I haven't read how your channel allocation works, but providing a
pointer to a local static variable is a bit fishy no matter what.

> +	/* Find the DMA channels to use.  For now, we always use the first DMA
> +	   controller. */
> +	for_each_compatible_node(dma_np, NULL, "fsl,mpc8610-dma") {
> +		iprop = of_get_property(dma_np, "cell-index", NULL);
> +		if (iprop && (*iprop == 0)) {
> +			of_node_put(dma_np);
> +			break;
> +		}
> +	}

Do you ever anticipate having other dma users on the system, such as
memcpy offload? You'll probably need allocation support for channels
when that day comes (I ended up writing a simple library for dma channel
management for that very reason on my platform).


-Olof

Return-Path: <guangyu.chen@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0188.outbound.protection.outlook.com [207.46.163.188])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 259F01A0881
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 22:11:09 +1000 (EST)
Date: Thu, 7 Aug 2014 20:09:11 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: Re: [alsa-devel] [PATCH V2 2/2] Revert "ASoC: fsl-esai: Add
 .xlate_tdm_slot_mask() support."
Message-ID: <20140807120909.GA4153@MrMyself>
References: <cover.1407403727.git.shengjiu.wang@freescale.com>
 <5627d0f839900c33b1c15de4c21f745015d3e19d.1407403727.git.shengjiu.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <5627d0f839900c33b1c15de4c21f745015d3e19d.1407403727.git.shengjiu.wang@freescale.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, timur@tabi.org,
 arnd@arndb.de, shc_work@mail.ru, tiwai@suse.de, Li.Xiubo@freescale.com,
 lgirdwood@gmail.com, perex@perex.cz, nicoleotsuka@gmail.com,
 broonie@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Shengjiu,
   
On Thu, Aug 07, 2014 at 05:33:25PM +0800, Shengjiu Wang wrote:
> This reverts commit a603c8ee526f5ea9ad9b40710308766299ad8a69.
> 
> fsl_asoc_xlate_tdm_slot_mask() will invert the mask, which isn't fit for
> esai. The default function snd_soc_xlate_tdm_slot_mask() is ok for esai.

You should describe why that doesn't fit for ESAI and what's the result
if keeping it.

Thank you,
Nicolin

> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
> ---
>  sound/soc/fsl/Kconfig    |    1 -
>  sound/soc/fsl/fsl_esai.c |    2 --
>  2 files changed, 3 deletions(-)
> 
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index f54a8fc..f3012b6 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -49,7 +49,6 @@ config SND_SOC_FSL_ESAI
>  	tristate "Enhanced Serial Audio Interface (ESAI) module support"
>  	select REGMAP_MMIO
>  	select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
> -	select SND_SOC_FSL_UTILS
>  	help
>  	  Say Y if you want to add Enhanced Synchronous Audio Interface
>  	  (ESAI) support for the Freescale CPUs.
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index f252370..b2f6b3e 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -18,7 +18,6 @@
>  
>  #include "fsl_esai.h"
>  #include "imx-pcm.h"
> -#include "fsl_utils.h"
>  
>  #define FSL_ESAI_RATES		SNDRV_PCM_RATE_8000_192000
>  #define FSL_ESAI_FORMATS	(SNDRV_PCM_FMTBIT_S8 | \
> @@ -612,7 +611,6 @@ static struct snd_soc_dai_ops fsl_esai_dai_ops = {
>  	.hw_params = fsl_esai_hw_params,
>  	.set_sysclk = fsl_esai_set_dai_sysclk,
>  	.set_fmt = fsl_esai_set_dai_fmt,
> -	.xlate_tdm_slot_mask = fsl_asoc_xlate_tdm_slot_mask,
>  	.set_tdm_slot = fsl_esai_set_dai_tdm_slot,
>  };
>  
> -- 
> 1.7.9.5
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

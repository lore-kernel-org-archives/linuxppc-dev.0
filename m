Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AFF2D2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 13:05:09 +1000 (EST)
Date: Wed, 12 Sep 2012 11:04:59 +0800
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [PATCH 1/5] ASoC: fsl: mpc5200 multi-codec fixups
Message-ID: <20120912030457.GF9162@opensource.wolfsonmicro.com>
References: <1347416089-23393-1-git-send-email-emillbrandt@dekaresearch.com>
 <1347416089-23393-2-git-send-email-emillbrandt@dekaresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1347416089-23393-2-git-send-email-emillbrandt@dekaresearch.com>
Cc: alsa-devel@alsa-project.org, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, Liam Girdwood <lrg@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 11, 2012 at 10:14:45PM -0400, Eric Millbrandt wrote:
> Add platform DAI information that is needed to successfully register the
> mpc5200 platform.

I'm really not clear what this patch is supposed to be doing.  What are
the problems you are trying to fix and how does your patch fix them?
This should almost certainly be split into a bunch of smaller patches
with focused changelogs.

> --- a/arch/powerpc/platforms/52xx/Kconfig
> +++ b/arch/powerpc/platforms/52xx/Kconfig
> @@ -1,6 +1,7 @@
>  config PPC_MPC52xx
>  	bool "52xx-based boards"
>  	depends on 6xx
> +	select FSL_SOC
>  	select PPC_CLOCK
>  	select PPC_PCI_CHOICE

This doesnt seem to have much to do with the commit message...

> diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
> index 9a3f7c5..46fb518 100644
> --- a/sound/soc/fsl/mpc5200_dma.c
> +++ b/sound/soc/fsl/mpc5200_dma.c
> @@ -366,8 +366,8 @@ static void psc_dma_free(struct snd_pcm *pcm)
>  
>  static struct snd_soc_platform_driver mpc5200_audio_dma_platform = {
>  	.ops		= &psc_dma_ops,
> -	.pcm_new	= &psc_dma_new,
> -	.pcm_free	= &psc_dma_free,
> +	.pcm_new	= psc_dma_new,
> +	.pcm_free	= psc_dma_free,
>  };

Nor does this.

> -/* ALSA only supports a single AC97 device so static is recommend here */
> +/* ALSA only supports a single AC97 bus device so static is recommend here */
>  static struct psc_dma *psc_dma;

Or this.

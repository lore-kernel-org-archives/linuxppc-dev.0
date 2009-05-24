Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AE782DE8C7
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 21:27:02 +1000 (EST)
Date: Sun, 24 May 2009 12:26:49 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Message-ID: <20090524112648.GE4933@sirena.org.uk>
References: <20090523231148.17919.46103.stgit@terra>
	<20090523231305.17919.12239.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090523231305.17919.12239.stgit@terra>
Subject: Re: [alsa-devel] [PATCH V2 5/9] Main rewite of the mpc5200 audio
	DMA code
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, May 23, 2009 at 07:13:05PM -0400, Jon Smirl wrote:

This is all basically OK bearing in mind that I know nothing about the
hardware.  A couple of things, though:

> +/* ---------------------------------------------------------------------
> + * Sysfs attributes for debugging
> + */

These look like they may be better placed in debugfs?

> +EXPORT_SYMBOL_GPL(mpc5200_audio_dma_create);

> +EXPORT_SYMBOL_GPL(mpc5200_audio_dma_destroy);

> +static int __init mpc5200_soc_platform_init(void)
> +{
> +	/* Tell the ASoC OF helpers about it */
> +	return snd_soc_register_platform(&mpc5200_audio_dma_platform);
> +}
> +module_init(mpc5200_soc_platform_init);

> +static void __exit mpc5200_soc_platform_exit(void)
> +{
> +	snd_soc_unregister_platform(&mpc5200_audio_dma_platform);
> +}
> +module_exit(mpc5200_soc_platform_exit);

This all looks a bit odd - I'd expect to see the platform registering
with the core when it is probed rather than on module load.  Looking at
the code it appears that you're automatically instantiating the DMA
driver from the node for the DAI?  If that is the case then you ought
to be calling the platform registration functions from the dma_create()
and dma_destroy() functions instead.

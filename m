Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E6737DE189
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 20:34:48 +1000 (EST)
Date: Tue, 22 Jul 2008 11:34:43 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 3/3] ALSA SoC: Add Texas Instruments TLV320AIC26
	codec driver
Message-ID: <20080722103443.GC2572@rakim.wolfsonmicro.main>
References: <20080722065352.7306.60679.stgit@trillian.secretlab.ca>
	<20080722065403.7306.53226.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080722065403.7306.53226.stgit@trillian.secretlab.ca>
Cc: timur@freescale.com, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	liam.girdwood@wolfsonmicro.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 22, 2008 at 12:54:03AM -0600, Grant Likely wrote:

> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

with the same comments about outstanding issues as applied to the CPU
side.

> +static int aic26_hw_params(struct snd_pcm_substream *substream,
> +			   struct snd_pcm_hw_params *params)
> +{

> +	switch (params_rate(params)) {
> +	case 8000:  fsref = 48000; divisor = AIC26_DIV_6; break;

> +	/* Configure PLL */
> +	pval = 1;
> +	jval = (fsref == 44100) ? 7 : 8;
> +	dval = (fsref == 44100) ? 5264 : 1920;

Without having looked at the chip datasheet these parameters probably
all need to depend on the input clock rate and the PLL configuration
should be done in a set_pll() rather than here.

> +#if defined(CONFIG_SND_SOC_OF_SIMPLE)
> +	/* Tell the of_soc helper about this codec */
> +	of_snd_soc_register_codec(&aic26_soc_codec_dev, aic26, &aic26_dai,
> +				  spi->dev.archdata.of_node);
> +#endif

This won't work if the OF_SIMPLE stuff is a module.  There's also a
checkpatch issue which I'll fix up.

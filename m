Return-Path: <arnaud.mouiche@invoxia.com>
Received: from mail-wr0-x232.google.com (mail-wr0-x232.google.com
 [IPv6:2a00:1450:400c:c0c::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xs6lY0bq1zDr8P
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 00:35:20 +1000 (AEST)
Received: by mail-wr0-x232.google.com with SMTP id 108so23208433wra.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 07:35:20 -0700 (PDT)
Subject: Re: [PATCH] ASoC: fsl_ssi: Override bit clock rate based on slot
 number
To: Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, timur@tabi.org, lukma@denx.de,
 caleb@crome.org, max.krummenacher@toradex.com, mpa@pengutronix.de,
 mail@maciej.szmigiero.name
References: <1504848223-3376-1-git-send-email-nicoleotsuka@gmail.com>
From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Message-ID: <2020d72a-4517-55d0-59a1-171c71f91c7b@invoxia.com>
Date: Tue, 12 Sep 2017 16:35:13 +0200
MIME-Version: 1.0
In-Reply-To: <1504848223-3376-1-git-send-email-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Nicolin

On 08/09/2017 07:23, Nicolin Chen wrote:
> The set_sysclk() now is used to override the output bit clock rate.
> But this is not a common way to implement a set_dai_sysclk(). And
> this creates a problem when a general machine driver (simple-card
> for example) tries to do set_dai_sysclk() by passing an input clock
> rate for the baud clock instead of setting the bit clock rate as
> fsl_ssi driver expected.
>
> So this patch solves this problem by firstly removing set_sysclk()
> since the hw_params() can calculate the bit clock rate. Secondly,
> in order not to break those TDM use cases which previously might
> have been using set_sysclk() to override the bit clock rate, this
> patch changes the driver to override it based on the slot number.
>
> The patch also removes an obsolete comment of the dir parameter.
>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>   sound/soc/fsl/fsl_ssi.c | 26 ++++++++------------------
>   1 file changed, 8 insertions(+), 18 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 64598d1..3657c88 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -197,12 +197,12 @@ struct fsl_ssi_soc_data {
>    * @use_dma: DMA is used or FIQ with stream filter
>    * @use_dual_fifo: DMA with support for both FIFOs used
>    * @fifo_deph: Depth of the SSI FIFOs
> + * @slots: number of slots
>    * @rxtx_reg_val: Specific register settings for receive/transmit configuration
>    *
>    * @clk: SSI clock
>    * @baudclk: SSI baud clock for master mode
>    * @baudclk_streams: Active streams that are using baudclk
> - * @bitclk_freq: bitclock frequency set by .set_dai_sysclk
>    *
>    * @dma_params_tx: DMA transmit parameters
>    * @dma_params_rx: DMA receive parameters
> @@ -233,12 +233,12 @@ struct fsl_ssi_private {
>   	bool use_dual_fifo;
>   	bool has_ipg_clk_name;
>   	unsigned int fifo_depth;
> +	unsigned int slots;
>   	struct fsl_ssi_rxtx_reg_val rxtx_reg_val;
>   
>   	struct clk *clk;
>   	struct clk *baudclk;
>   	unsigned int baudclk_streams;
> -	unsigned int bitclk_freq;
>   
>   	/* regcache for volatile regs */
>   	u32 regcache_sfcsr;
> @@ -700,8 +700,7 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
>    * Note: This function can be only called when using SSI as DAI master
>    *
>    * Quick instruction for parameters:
> - * freq: Output BCLK frequency = samplerate * 32 (fixed) * channels
> - * dir: SND_SOC_CLOCK_OUT -> TxBCLK, SND_SOC_CLOCK_IN -> RxBCLK.
> + * freq: Output BCLK frequency = samplerate * 32 (fixed) * slots (or channels)

Slots are not necessarily 32 bits width.
Indeed, a simple grep of snd_soc_dai_set_tdm_slot shows 16, 24, 32 and 0 
bits usage. (don't know the real meaning of 0 BTW...)
So, it should be good to also remember the slots width given in 
snd_soc_dai_set_tdm_slot() call.

Anyway, there is something wrong in the snd_soc_codec_set_sysclk usage 
by fsl_ssi
Let's get a look again at the description:

    /**
      * snd_soc_dai_set_sysclk - configure DAI system or master clock.
      * @dai: DAI
      * @clk_id: DAI specific clock ID
      * @freq: new clock frequency in Hz
      * @dir: new clock direction - input/output.
      *
      * Configures the DAI master (MCLK) or system (SYSCLK) clocking.
      */
    int snd_soc_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
         unsigned int freq, int dir)

So, it can be used to configure 2 different clocks (and more) with 
different usages.

Lukasz complains that simple-card is configuring MCLK incorrectly. but 
simple-card, only want to configure the SYSCLK, whereas fsl_ssi 
understand "configure the MCLK..." (fsl_ssi doesn't check the clk_id at all)

I think the problem is here.
I would propose a new clk_id

     #define FSL_SSI_SYSCLK_MCLK 1

And leave fsl_ssi_set_dai_sysclk(xxx, FSL_SSI_SYSCLK_MCLK, ...) override 
the computed mlck.
This will leave a way for obscure TDM users to specify a specific a 
random mclk frequency for obscure reasons...
Unfortunately, such generic clock_id (sysclk, mclk) were never defined 
widely.

Is it really needed ? It is true that, up to now, we are using 
fsl_ssi_set_dai_sysclk() in addition to snd_soc_dai_set_tdm_slot() only 
because this was the only way to deal with correct mclk setting. And if 
now, snd_soc_dai_set_tdm_slot() do its job correctly, 
fsl_ssi_set_dai_sysclk() will become useless (except for obscure TDM 
users of course)

Will it break TDM users ?
I will say yes, surely, but TDM users (at least myself) may consider 
something will break in TDM audio area every-time we jump to a new linux 
release...

Arnaud

>    */
>   static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
>   		struct snd_soc_dai *cpu_dai,
> @@ -716,9 +715,9 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
>   	unsigned int freq;
>   	bool baudclk_is_used;
>   
> -	/* Prefer the explicitly set bitclock frequency */
> -	if (ssi_private->bitclk_freq)
> -		freq = ssi_private->bitclk_freq;
> +	/* Generate bit clock based on the slot or channel number */
> +	if (ssi_private->slots)
> +		freq = ssi_private->slots * 32 * params_rate(hw_params);
>   	else
>   		freq = params_channels(hw_params) * 32 * params_rate(hw_params);
>   
> @@ -805,16 +804,6 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
>   	return 0;
>   }
>   
> -static int fsl_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
> -		int clk_id, unsigned int freq, int dir)
> -{
> -	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
> -
> -	ssi_private->bitclk_freq = freq;
> -
> -	return 0;
> -}
> -
>   /**
>    * fsl_ssi_hw_params - program the sample size
>    *
> @@ -1121,6 +1110,8 @@ static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
>   
>   	regmap_update_bits(regs, CCSR_SSI_SCR, CCSR_SSI_SCR_SSIEN, val);
>   
> +	ssi_private->slots = slots;
> +
>   	return 0;
>   }
>   
> @@ -1191,7 +1182,6 @@ static const struct snd_soc_dai_ops fsl_ssi_dai_ops = {
>   	.hw_params	= fsl_ssi_hw_params,
>   	.hw_free	= fsl_ssi_hw_free,
>   	.set_fmt	= fsl_ssi_set_dai_fmt,
> -	.set_sysclk	= fsl_ssi_set_dai_sysclk,
>   	.set_tdm_slot	= fsl_ssi_set_dai_tdm_slot,
>   	.trigger	= fsl_ssi_trigger,
>   };

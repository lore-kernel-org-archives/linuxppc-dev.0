Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 265A31A0772
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 May 2015 17:11:49 +1000 (AEST)
Received: by padbw4 with SMTP id bw4so49886702pad.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 May 2015 00:11:46 -0700 (PDT)
Date: Sun, 24 May 2015 00:11:41 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Zidan Wang <zidan.wang@freescale.com>
Cc: timur@tabi.org, Xiubo.Lee@gmail.com, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.de,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel][PATCH 1/3] ASoC: fsl_sai: add sai master mode support
Message-ID: <20150524071140.GA2703@Asurada-CZ80>
References: <a60e5babb208b08fb4cd8188573606eb745cc1c4.1431414110.git.zidan.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a60e5babb208b08fb4cd8188573606eb745cc1c4.1431414110.git.zidan.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 12, 2015 at 03:07:39PM +0800, Zidan Wang wrote:
> When sai works on master mode, set its bit clock and frame clock.
> 
> SAI has 4 MCLK source, bus clock, MCLK1, MCLK2 and MCLK3. fsl_sai_set_bclk
> will select proper MCLK source, then calculate and set the bit clock divider.
> 
> After fsl_sai_set_bclk, enable the selected mclk in hw_params(), and add
> hw_free() to disable the mclk.

Besides these, there are also some bug-fixes that aren't related to
the topic while being a must to this support. I think at least you
should mention it in the commit log as well except you can separate
them into different small patches. (This includes copyright update)
 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> ---
>  sound/soc/fsl/fsl_sai.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++--
>  sound/soc/fsl/fsl_sai.h |   9 +++-
>  2 files changed, 121 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index ee2671b..1ccc10d1 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
  
> +static int fsl_sai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
> +{
> +	struct fsl_sai *sai = snd_soc_dai_get_drvdata(dai);
> +	unsigned long clk_rate;
> +	u32 savediv = 0, ratio, savesub = freq;
> +	u32 id;
> +	int ret = 0;
> +
> +	/* Don't apply to slave mode */
> +	if (sai->is_slave_mode)
> +		return 0;
> +
> +	for (id = 0; id < FSL_SAI_MCLK_MAX; id++) {
> +		clk_rate = clk_get_rate(sai->mclk_clk[id]);
> +		if (!clk_rate)
> +			continue;
> +
> +		ratio = clk_rate / freq;
> +
> +		ret = clk_rate - ratio * freq;
> +
> +		/*
> +		 * Drop the source that can not be
> +		 * divided into the required rate.
> +		 */
> +		if (ret != 0 && clk_rate / ret < 1000)
> +			continue;
> +
> +		dev_dbg(dai->dev,
> +			"ratio %d for freq %dHz based on clock %ldHz\n",
> +			ratio, freq, clk_rate);
> +
> +		if (ratio % 2 == 0 && ratio >= 2 && ratio <= 512)
> +			ratio /= 2;
> +		else
> +			continue;
> +
> +		if (ret < savesub) {
> +			savediv = ratio;
> +			sai->mclk_id[tx] = id;
> +			savesub = ret;
> +		}
> +
> +		if (ret == 0)
> +			break;
> +	}
> +
> +	if (savediv == 0) {
> +		dev_err(dai->dev, "failed to derive required %cx rate: %d\n",
> +				tx ? 'T' : 'R', freq);
> +		return -EINVAL;
> +	}
> +
> +	if ((tx && sai->synchronous[TX]) || (!tx && !sai->synchronous[RX])) {
> +		regmap_update_bits(sai->regmap, FSL_SAI_RCR2,
> +				   FSL_SAI_CR2_MSEL_MASK,
> +				   FSL_SAI_CR2_MSEL(sai->mclk_id[tx]));
> +		regmap_update_bits(sai->regmap, FSL_SAI_RCR2,
> +				   FSL_SAI_CR2_DIV_MASK, savediv - 1);
> +	} else {
> +		regmap_update_bits(sai->regmap, FSL_SAI_TCR2,
> +				   FSL_SAI_CR2_MSEL_MASK,
> +				   FSL_SAI_CR2_MSEL(sai->mclk_id[tx]));
> +		regmap_update_bits(sai->regmap, FSL_SAI_TCR2,
> +				   FSL_SAI_CR2_DIV_MASK, savediv - 1);
> +	}
> +
> +	dev_dbg(dai->dev, "best fit: clock id=%d, div=%d, deviation =%d\n",

id = %d, div = %d.... will be better

> +			sai->mclk_id[tx], savediv, savesub);
> +
> +	return 0;
> +}
> +
>  static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
>  		struct snd_pcm_hw_params *params,
>  		struct snd_soc_dai *cpu_dai)
> @@ -297,6 +372,24 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
>  	unsigned int channels = params_channels(params);
>  	u32 word_width = snd_pcm_format_width(params_format(params));
>  	u32 val_cr4 = 0, val_cr5 = 0;
> +	int ret;
> +
> +	if (!sai->is_slave_mode) {
> +		ret = fsl_sai_set_bclk(cpu_dai, tx,
> +			2 * word_width * params_rate(params));
> +		if (ret)
> +			return ret;
> +
> +		/* Do not enable the clock if it is already enabled */
> +		if (!(sai->mclk_streams & BIT(substream->stream))) {
> +			ret = clk_prepare_enable(sai->mclk_clk[sai->mclk_id[tx]]);
> +			if (ret)
> +				return ret;
> +
> +			sai->mclk_streams |= BIT(substream->stream);
> +		}
> +
> +	}
>  
>  	if (!sai->is_dsp_mode)
>  		val_cr4 |= FSL_SAI_CR4_SYWD(word_width);
> @@ -322,6 +415,22 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
>  	return 0;
>  }
>  
> +static int fsl_sai_hw_free(struct snd_pcm_substream *substream,
> +		struct snd_soc_dai *cpu_dai)
> +{
> +	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
> +	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
> +
> +	if (!sai->is_slave_mode &&
> +			sai->mclk_streams & BIT(substream->stream)) {

	if (!sai->is_slave_mode &&
	    sai->mclk_streams & BIT(substream->stream)) {
           ^indentation here.

> +		clk_disable_unprepare(sai->mclk_clk[sai->mclk_id[tx]]);
> +		sai->mclk_streams &= ~BIT(substream->stream);

Since the enabling order is (1) enable_clk (2) set bit, it might be
better to do disabling in a symmetrical way: (1) clear bit (2) disable_clk.

> @@ -600,8 +710,9 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  		sai->bus_clk = NULL;
>  	}
>  
> -	for (i = 0; i < FSL_SAI_MCLK_MAX; i++) {
> -		sprintf(tmp, "mclk%d", i + 1);
> +	sai->mclk_clk[0] = sai->bus_clk;
> +	for (i = 1; i < FSL_SAI_MCLK_MAX; i++) {
> +		sprintf(tmp, "mclk%d", i);
>  		sai->mclk_clk[i] = devm_clk_get(&pdev->dev, tmp);
>  		if (IS_ERR(sai->mclk_clk[i])) {
>  			dev_err(&pdev->dev, "failed to get mclk%d clock: %ld\n",

There is another line below here using i + 1 that you may need to modify.

Thank you
Nicolin

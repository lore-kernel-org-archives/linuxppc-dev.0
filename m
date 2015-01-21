Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pd0-x236.google.com (mail-pd0-x236.google.com
 [IPv6:2607:f8b0:400e:c02::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B969F1A0C33
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 17:07:11 +1100 (AEDT)
Received: by mail-pd0-f182.google.com with SMTP id z10so8338348pdj.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 22:07:10 -0800 (PST)
Date: Tue, 20 Jan 2015 22:07:03 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Zidan Wang <zidan.wang@freescale.com>
Subject: Re: [alsa-devel][PATCH 1/3] SoC: fsl_sai: add sai master mode support
Message-ID: <20150121060702.GB3275@Alpha>
References: <1421756480-7055-1-git-send-email-zidan.wang@freescale.com>
 <1421756480-7055-2-git-send-email-zidan.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421756480-7055-2-git-send-email-zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Xiubo.Lee@gmail.com,
 tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 perex@perex.cz, broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 20, 2015 at 08:21:18PM +0800, Zidan Wang wrote:
> +static int fsl_sai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)

> +	if ((tx && sai->synchronous[TX]) || (!tx && !sai->synchronous[RX])) {
> +		regmap_update_bits(sai->regmap, FSL_SAI_RCR2,
> +			FSL_SAI_CR2_MSEL_MASK, FSL_SAI_CR2_MSEL(sai->mclk_id));
> +		regmap_update_bits(sai->regmap, FSL_SAI_RCR2,
> +			FSL_SAI_CR2_DIV_MASK, savediv - 1);

Hmm...the case should be a bit more complicated here IMO.

"tx && sai->synchronous[TX]" means the playback in synchronous
mode (TX following RX). What if the recording has been already
activated with an MSEL setting at this point? Then the playback
stream, as a secondary stream, will overwrite MSEL of the first
stream -- Record. Same would happen to the DIV configuration.

> @@ -297,6 +368,24 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
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

It actually doesn't matter to enable the clock again since it
purely increaes its count. But we do need a protection for MSEL
overwritten issue resulted from the fsl_sai_set_bclk() call.

> @@ -133,10 +135,13 @@ struct fsl_sai {
>  	struct clk *mclk_clk[FSL_SAI_MCLK_MAX];
>  
>  	bool is_lsb_first;
> +	bool is_slave_mode;
>  	bool is_dsp_mode;
>  	bool sai_on_imx;
>  	bool synchronous[2];
>  
> +	unsigned int mclk_id;
> +	unsigned int mclk_streams;

Besides, I doubt that only one property of mclk_id can content
Asynchronous Mode -- TX and RX can fetch their clocks from
different MCLK sources.

Nicolin

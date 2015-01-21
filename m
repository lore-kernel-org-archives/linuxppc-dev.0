Return-Path: <B50113@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0137.outbound.protection.outlook.com [207.46.100.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 079B61A0D86
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 20:40:09 +1100 (AEDT)
Date: Wed, 21 Jan 2015 17:25:32 +0800
From: Zidan Wang <b50113@freescale.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [alsa-devel][PATCH 1/3] SoC: fsl_sai: add sai master mode support
Message-ID: <20150121092529.GA27441@b50113>
References: <1421756480-7055-1-git-send-email-zidan.wang@freescale.com>
 <1421756480-7055-2-git-send-email-zidan.wang@freescale.com>
 <20150121060702.GB3275@Alpha>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20150121060702.GB3275@Alpha>
Cc: alsa-devel@alsa-project.org, timur@tabi.org,
 Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com, tiwai@suse.de,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
 broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 20, 2015 at 10:07:03PM -0800, Nicolin Chen wrote:
> On Tue, Jan 20, 2015 at 08:21:18PM +0800, Zidan Wang wrote:
> > +static int fsl_sai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
> 
> > +	if ((tx && sai->synchronous[TX]) || (!tx && !sai->synchronous[RX])) {
> > +		regmap_update_bits(sai->regmap, FSL_SAI_RCR2,
> > +			FSL_SAI_CR2_MSEL_MASK, FSL_SAI_CR2_MSEL(sai->mclk_id));
> > +		regmap_update_bits(sai->regmap, FSL_SAI_RCR2,
> > +			FSL_SAI_CR2_DIV_MASK, savediv - 1);
> 
> Hmm...the case should be a bit more complicated here IMO.
> 
> "tx && sai->synchronous[TX]" means the playback in synchronous
> mode (TX following RX). What if the recording has been already
> activated with an MSEL setting at this point? Then the playback
> stream, as a secondary stream, will overwrite MSEL of the first
> stream -- Record. Same would happen to the DIV configuration.
> 
When TX following RX(or RX following TX), TX and RX works on same bit
clock and frame clock. They will use same MCLK source, and just need set
the bclk DIV for RX(or TX). The secondary stream will overwrite MSEL and
bclk DIV of the first stream, but it doesn't matter.

For RX(or TX) sync:
fsl_sai_dai.symmetric_rates = 1;
fsl_sai_dai.symmetric_channels = 1;
fsl_sai_dai.symmetric_samplebits = 1;

When TX and RX both works on async mode, TX and RX may works on
different bit clock and frame clock. We need set MCLK source and bclk
DIV for TX and RX. mclk_id just save a MCLK source id, so i need to define
mclk_id[2] for differnet stream.

For TX and RX async:
fsl_sai_dai.symmetric_rates = 0;
fsl_sai_dai.symmetric_channels = 0;
fsl_sai_dai.symmetric_samplebits = 0;

> > @@ -297,6 +368,24 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
> >  	unsigned int channels = params_channels(params);
> >  	u32 word_width = snd_pcm_format_width(params_format(params));
> >  	u32 val_cr4 = 0, val_cr5 = 0;
> > +	int ret;
> > +
> > +	if (!sai->is_slave_mode) {
> > +		ret = fsl_sai_set_bclk(cpu_dai, tx,
> > +			2 * word_width * params_rate(params));
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* Do not enable the clock if it is already enabled */
> 
> It actually doesn't matter to enable the clock again since it
> purely increaes its count. But we do need a protection for MSEL
> overwritten issue resulted from the fsl_sai_set_bclk() call.
> 
> > @@ -133,10 +135,13 @@ struct fsl_sai {
> >  	struct clk *mclk_clk[FSL_SAI_MCLK_MAX];
> >  
> >  	bool is_lsb_first;
> > +	bool is_slave_mode;
> >  	bool is_dsp_mode;
> >  	bool sai_on_imx;
> >  	bool synchronous[2];
> >  
> > +	unsigned int mclk_id;
> > +	unsigned int mclk_streams;
> 
> Besides, I doubt that only one property of mclk_id can content
> Asynchronous Mode -- TX and RX can fetch their clocks from
> different MCLK sources.
> 
When hw_params failed before mclk enable, hw_free will also decrease 
the clk usecount. So add mclk_streams, when clk successful enabled, 
set corresponding bit of mclk_stream. And clear such bit after clk disabled.
> Nicolin

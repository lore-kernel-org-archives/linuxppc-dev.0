Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKWfJ1H7lzDqZg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 09:40:39 +1100 (AEDT)
Subject: Re: [PATCH v2 13/16] ASoC: fsl_ssi: Clean up _fsl_ssi_set_dai_fmt()
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
References: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
 <1515652995-15996-14-git-send-email-nicoleotsuka@gmail.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <2e285df9-834b-41bf-1a09-a8de3f2a1f7c@maciej.szmigiero.name>
Date: Sun, 14 Jan 2018 23:40:31 +0100
MIME-Version: 1.0
In-Reply-To: <1515652995-15996-14-git-send-email-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11.01.2018 07:43, Nicolin Chen wrote:
> The _fsl_ssi_set_dai_fmt() is a helper function being called from
> fsl_ssi_set_dai_fmt() as an ASoC operation and fsl_ssi_hw_init()
> mainly for AC97 format initialization.
> 
> This patch cleans the _fsl_ssi_set_dai_fmt() in following ways:
> * Removing *dev pointer in the parameters as it's included in the
>   *ssi pointer of struct fsl_ssi.
> * Using regmap_update_bits() instead of regmap_read() with masking
>   the value manually.
> * Removing TXBIT0 configurations since this bit is set to 1 as its
>   reset value and there is no use case so far to unset it. And it
>   is safe to remove since regmap_update_bits() won't touch it.

The old code set this bit in any mode other than AC'97 (where the
hardware always treats this bit as set regardless of the actual value).
I would play safe here and not rely on this bit being set by a SSI
reset on all SSI models.

> * Moving baudclk check to the switch-case routine to skip the I2S
>   master check. And moving SxCCR.DC settings after baudclk check.
> * Adding format settings for SND_SOC_DAIFMT_AC97 like others.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Tested-by: Caleb Crome <caleb@crome.org>
> ---
>  sound/soc/fsl/fsl_ssi.c | 70 ++++++++++++++++++++++---------------------------
>  1 file changed, 31 insertions(+), 39 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 178c192..213962a 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -855,42 +855,27 @@ static int fsl_ssi_hw_free(struct snd_pcm_substream *substream,
>  	return 0;
>  }
>  
> -static int _fsl_ssi_set_dai_fmt(struct device *dev,
> -				struct fsl_ssi *ssi, unsigned int fmt)
> +static int _fsl_ssi_set_dai_fmt(struct fsl_ssi *ssi, unsigned int fmt)
>  {
> -	struct regmap *regs = ssi->regs;
> -	u32 strcr = 0, stcr, srcr, scr, mask;
> +	u32 strcr = 0, scr = 0, stcr, srcr, mask;
>  
>  	ssi->dai_fmt = fmt;
>  
> -	if (fsl_ssi_is_i2s_master(ssi) && IS_ERR(ssi->baudclk)) {
> -		dev_err(dev, "missing baudclk for master mode\n");
> -		return -EINVAL;
> -	}
> -
> -	regmap_read(regs, REG_SSI_SCR, &scr);
> -	scr &= ~(SSI_SCR_SYN | SSI_SCR_I2S_MODE_MASK);
>  	/* Synchronize frame sync clock for TE to avoid data slipping */
>  	scr |= SSI_SCR_SYNC_TX_FS;
>  
> -	mask = SSI_STCR_TXBIT0 | SSI_STCR_TFDIR | SSI_STCR_TXDIR |
> -	       SSI_STCR_TSCKP | SSI_STCR_TFSI | SSI_STCR_TFSL | SSI_STCR_TEFS;
> -	regmap_read(regs, REG_SSI_STCR, &stcr);
> -	regmap_read(regs, REG_SSI_SRCR, &srcr);
> -	stcr &= ~mask;
> -	srcr &= ~mask;
> -
>  	/* Use Network mode as default */
>  	ssi->i2s_net = SSI_SCR_NET;
>  	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>  	case SND_SOC_DAIFMT_I2S:
> -		regmap_update_bits(regs, REG_SSI_STCCR,
> -				   SSI_SxCCR_DC_MASK, SSI_SxCCR_DC(2));
> -		regmap_update_bits(regs, REG_SSI_SRCCR,
> -				   SSI_SxCCR_DC_MASK, SSI_SxCCR_DC(2));
>  		switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
>  		case SND_SOC_DAIFMT_CBM_CFS:
>  		case SND_SOC_DAIFMT_CBS_CFS:
> +			if (IS_ERR(ssi->baudclk)) {
> +				dev_err(ssi->dev,
> +					"missing baudclk for master mode\n");
> +				return -EINVAL;
> +			}

The original code did this check only for fsl_ssi_is_i2s_master(ssi),
that is, only for SND_SOC_DAIFMT_CBS_CFS while here you also do it for
SND_SOC_DAIFMT_CBM_CFS.
Was this changed on purpose?

Maciej

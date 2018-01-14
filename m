Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKWZH5VW0zF0XH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 09:37:11 +1100 (AEDT)
Subject: Re: [PATCH v2 06/16] ASoC: fsl_ssi: Clean up helper functions of
 trigger()
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
References: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
 <1515652995-15996-7-git-send-email-nicoleotsuka@gmail.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <6ebb0453-01ea-e94c-871d-689ca0c787bc@maciej.szmigiero.name>
Date: Sun, 14 Jan 2018 23:37:02 +0100
MIME-Version: 1.0
In-Reply-To: <1515652995-15996-7-git-send-email-nicoleotsuka@gmail.com>
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
> The trigger() calls fsl_ssi_tx_config() and fsl_ssi_rx_config(),
> and both of them jump to fsl_ssi_config(). And fsl_ssi_config()
> later calls another fsl_ssi_rxtx_config().
> 
> However, the whole routine, especially fsl_ssi_config() function,
> is too complicated because of the folowing reasons:
> 1) It has to handle the concern of the opposite stream.
> 2) It has to handle cases of offline configurations support.
> 3) It has to handle enable and disable operations while they're
>    mostly different.
> 
> Since the enable and disable routines have more differences than
> TX and RX rountines, this patch simplifies these helper functions
> with the following changes:
> - Changing to two helper functions of enable and disable instead
>   of TX and RX.
> - Removing fsl_ssi_rxtx_config() by separately integrating it to
>   two newly introduced enable & disable functions.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Tested-by: Caleb Crome <caleb@crome.org>
> ---
>  sound/soc/fsl/fsl_ssi.c | 256 +++++++++++++++++++++++-------------------------
>  1 file changed, 122 insertions(+), 134 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 263c067..09a571a 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -378,31 +378,83 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
>  }
>  
>  /**
> - * Enable or disable all rx/tx config flags at once
> + * Set SCR, SIER, STCR and SRCR registers with cached values in regvals
> + *
> + * Notes:
> + * 1) For offline_config SoCs, enable all necessary bits of both streams
> + *    when 1st stream starts, even if the opposite stream will not start
> + * 2) It also clears FIFO before setting regvals; SOR is safe to set online
>   */
> -static void fsl_ssi_rxtx_config(struct fsl_ssi *ssi, bool enable)
> +static void fsl_ssi_config_enable(struct fsl_ssi *ssi, bool tx)
>  {
> -	struct regmap *regs = ssi->regs;
>  	struct fsl_ssi_regvals *vals = ssi->regvals;
> +	bool dir = tx ? TX : RX;

A similar case as in patch 3 of a bool variable used for a bit index.

> +	u32 sier, srcr, stcr;
>  
> -	if (enable) {
> -		regmap_update_bits(regs, REG_SSI_SIER,
> -				   vals[RX].sier | vals[TX].sier,
> -				   vals[RX].sier | vals[TX].sier);
> -		regmap_update_bits(regs, REG_SSI_SRCR,
> -				   vals[RX].srcr | vals[TX].srcr,
> -				   vals[RX].srcr | vals[TX].srcr);
> -		regmap_update_bits(regs, REG_SSI_STCR,
> -				   vals[RX].stcr | vals[TX].stcr,
> -				   vals[RX].stcr | vals[TX].stcr);
> +	/* Clear dirty data in the FIFO; It also prevents channel slipping */
> +	regmap_update_bits(ssi->regs, REG_SSI_SOR,
> +			   SSI_SOR_xX_CLR(tx), SSI_SOR_xX_CLR(tx));
> +
> +	/*
> +	 * On offline_config SoCs, SxCR and SIER are already configured when
> +	 * the previous stream started. So skip all SxCR and SIER settings
> +	 * to prevent online reconfigurations, then jump to set SCR directly
> +	 */
> +	if (ssi->soc->offline_config && ssi->streams)
> +		goto enable_scr;
> +
> +	if (ssi->soc->offline_config) {
> +		/*
> +		 * Online reconfiguration not supported, so enable all bits for
> +		 * both streams at once to avoid necessity of reconfigurations
> +		 */
> +		srcr = vals[RX].srcr | vals[TX].srcr;
> +		stcr = vals[RX].stcr | vals[TX].stcr;
> +		sier = vals[RX].sier | vals[TX].sier;
>  	} else {
> -		regmap_update_bits(regs, REG_SSI_SRCR,
> -				   vals[RX].srcr | vals[TX].srcr, 0);
> -		regmap_update_bits(regs, REG_SSI_STCR,
> -				   vals[RX].stcr | vals[TX].stcr, 0);
> -		regmap_update_bits(regs, REG_SSI_SIER,
> -				   vals[RX].sier | vals[TX].sier, 0);
> +		/* Otherwise, only set bits for the current stream */
> +		srcr = vals[dir].srcr;
> +		stcr = vals[dir].stcr;
> +		sier = vals[dir].sier;
>  	}
> +
> +	/* Configure SRCR, STCR and SIER at once */
> +	regmap_update_bits(ssi->regs, REG_SSI_SRCR, srcr, srcr);
> +	regmap_update_bits(ssi->regs, REG_SSI_STCR, stcr, stcr);
> +	regmap_update_bits(ssi->regs, REG_SSI_SIER, sier, sier);
> +
> +enable_scr:
> +	/*
> +	 * Start DMA before setting TE to avoid FIFO underrun
> +	 * which may cause a channel slip or a channel swap
> +	 *
> +	 * TODO: FIQ cases might also need this upon testing
> +	 */
> +	if (ssi->use_dma && tx) {
> +		int try = 100;
> +		u32 sfcsr;
> +
> +		/* Enable SSI first to send TX DMA request */
> +		regmap_update_bits(ssi->regs, REG_SSI_SCR,
> +				   SSI_SCR_SSIEN, SSI_SCR_SSIEN);
> +
> +		/* Busy wait until TX FIFO not empty -- DMA working */
> +		do {
> +			regmap_read(ssi->regs, REG_SSI_SFCSR, &sfcsr);
> +			if (SSI_SFCSR_TFCNT0(sfcsr))
> +				break;
> +		} while (--try);
> +
> +		/* FIFO still empty -- something might be wrong */
> +		if (!SSI_SFCSR_TFCNT0(sfcsr))
> +			dev_warn(ssi->dev, "Timeout waiting TX FIFO filling\n");
> +	}
> +	/* Enable all remaining bits in SCR */
> +	regmap_update_bits(ssi->regs, REG_SSI_SCR,
> +			   vals[dir].scr, vals[dir].scr);
> +
> +	/* Log the enabled stream to the mask */
> +	ssi->streams |= BIT(dir);
>  }
>  
>  /**
> @@ -426,66 +478,53 @@ static void fsl_ssi_rxtx_config(struct fsl_ssi *ssi, bool enable)
>  	((vals) & _ssi_xor_shared_bits(vals, avals, aactive))
>  
>  /**
> - * Enable or disable SSI configuration.
> + * Unset SCR, SIER, STCR and SRCR registers with cached values in regvals
> + *
> + * Notes:
> + * 1) For offline_config SoCs, to avoid online reconfigurations, disable all
> + *    bits of both streams at once when the last stream is abort to end
> + * 2) It also clears FIFO after unsetting regvals; SOR is safe to set online
>   */
> -static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
> -			   struct fsl_ssi_regvals *vals)
> +static void fsl_ssi_config_disable(struct fsl_ssi *ssi, bool tx)
>  {
> -	bool tx = &ssi->regvals[TX] == vals;
> +	struct fsl_ssi_regvals *vals, *avals;
> +	u32 sier, srcr, stcr, scr;
>  	bool dir = tx ? TX : RX;
> -	struct regmap *regs = ssi->regs;
> -	struct fsl_ssi_regvals *avals;
>  	bool aactive;
>  
>  	/* Check if the opposite stream is active */
>  	aactive = ssi->streams & BIT(!dir);
>  
> -	/* Get the opposite direction to keep its values untouched */
> -	if (&ssi->regvals[RX] == vals)
> -		avals = &ssi->regvals[TX];
> -	else
> -		avals = &ssi->regvals[RX];
> +	vals = &ssi->regvals[dir];>  
> -	if (!enable) {
> -		/*
> -		 * To keep the other stream safe, exclude shared bits between
> -		 * both streams, and get safe bits to disable current stream
> -		 */
> -		u32 scr = ssi_excl_shared_bits(vals->scr, avals->scr, aactive);
> -		/* Safely disable SCR register for the stream */
> -		regmap_update_bits(regs, REG_SSI_SCR, scr, 0);
> -
> -		/* Log the disabled stream to the mask */
> -		ssi->streams &= ~BIT(dir);
> -	}
> +	/* Get regvals of the opposite stream to keep opposite stream safe */
> +	avals = &ssi->regvals[!dir];
			      ^
The same implicit assumption here as in patch 4.

Maciej

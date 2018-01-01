Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z9Qwk6Y7czDr4n
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jan 2018 05:40:04 +1100 (AEDT)
Subject: Re: [PATCH v1 01/15] ASoC: fsl_ssi: Clean up set_dai_tdm_slot()
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
References: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
 <1513702819-42310-2-git-send-email-nicoleotsuka@gmail.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <b910e12c-bee7-18ba-f878-bece9a9f9cc1@maciej.szmigiero.name>
Date: Mon, 1 Jan 2018 19:39:52 +0100
MIME-Version: 1.0
In-Reply-To: <1513702819-42310-2-git-send-email-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19.12.2017 18:00, Nicolin Chen wrote:
> This patch replaces the register read with ssi->i2s_net for
> simplification. It also removes masking SSIEN from scr value
> since it's handled later by regmap_update_bits() to set this
> scr value back.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  sound/soc/fsl/fsl_ssi.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index aecd00f..ed2712b 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -1051,9 +1051,7 @@ static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask,
>  	}
>  
>  	/* The slot number should be >= 2 if using Network mode or I2S mode */
> -	regmap_read(regs, REG_SSI_SCR, &val);
> -	val &= SSI_SCR_I2S_MODE_MASK | SSI_SCR_NET;
> -	if (val && slots < 2) {
> +	if (ssi->i2s_net && slots < 2) {
>  		dev_err(dai->dev, "slot number should be >= 2 in I2S or NET\n");
>  		return -EINVAL;
>  	}

Are you sure that ssi->i2s_net SSI_SCR_I2S_MODE_MASK | SSI_SCR_NET bits
(also known as SSI_SCR_I2S_NET_MASK) zero or non-zero status is always
consistent with that in the SCR register?

I can see that in fsl_ssi_hw_params() these bits in SCR are zeroed in
a one special case and in the second special case they are hardcoded
to SSI_SCR_I2S_MODE_NORMAL | SSI_SCR_NET, in both cases regardless of
what is currently in ssi->i2s_net.

Maciej

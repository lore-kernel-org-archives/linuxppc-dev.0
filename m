Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxrvn2RmjzDrpG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 09:29:06 +1100 (AEDT)
Subject: Re: [PATCH v2 03/11] ASoC: fsl_ssi: Refine all comments
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, timur@tabi.org, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
References: <1513146874-25476-1-git-send-email-nicoleotsuka@gmail.com>
 <1513146874-25476-4-git-send-email-nicoleotsuka@gmail.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <e264f260-c8df-a51a-4756-cf2ebf979c66@maciej.szmigiero.name>
Date: Wed, 13 Dec 2017 23:28:51 +0100
MIME-Version: 1.0
In-Reply-To: <1513146874-25476-4-git-send-email-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13.12.2017 07:34, Nicolin Chen wrote:
> This patch refines the comments by:
> 1) Removing all out-of-date comments
> 2) Removing all not-so-useful comments
> 3) Unifying the styles of all comments
> 4) Simplifying over-descriptive comments
> 5) Adding comments to improve code readablity
> 6) Moving all register related comments to fsl_ssi.h
> 7) Adding comments to all register and field defines
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> 
> Changelog
> v1->v2
>  * Added some new comments at "SoC specific data" to be more precise.
>  * Revised one comment in fsl_ssi_config().
>  * Revised the comment of fsl_ssi_setup_reg_vals().
>  * Added one comment for AC97 in fsl_ssi_setup_reg_vals().
>  * Revised the comment of fsl_ssi_hw_params() to be more precise.
>  * Added some comments in _fsl_ssi_set_dai_fmt() to help understand the formats.
>  * Added one comment in fsl_ssi_set_dai_fmt() to state why AC97 needs to bypass it.
>  * Revised comments in fsl_ssi_set_dai_tdm_slot() to be more precise.
>  * Revised comments around dual FIFO code in fsl_ssi_imx_probe() to be more precise.
> 
>  sound/soc/fsl/fsl_ssi.c     | 376 ++++++++++++++------------------------------
>  sound/soc/fsl/fsl_ssi.h     |  67 +++++++-
>  sound/soc/fsl/fsl_ssi_dbg.c |  12 +-
>  3 files changed, 188 insertions(+), 267 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index e903c92..796a7ea 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
(..)
> @@ -878,10 +794,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
>  	regmap_read(regs, CCSR_SSI_SCR, &scr_val);
>  	enabled = scr_val & CCSR_SSI_SCR_SSIEN;
>  
> -	/*
> -	 * If we're in synchronous mode, and the SSI is already enabled,
> -	 * then STCCR is already set properly.
> -	 */
> +	/* To support simultaneous TX and RX, bypass it if SSI is enabled */
>  	if (enabled && ssi->cpu_dai_drv.symmetric_rates)
>  		return 0;
>  

I would say that the old comment described better what is happening -
since in synchronous (& non-AC'97) mode STCCR controls both TX and RX
the first direction that is started (either playback or capture) is the
only direction that needs to configure SSI in hw_params().

When the opposite direction enters hw_params() (while the first one is
still running) there is no need to do anything and we can exit early.

Maciej

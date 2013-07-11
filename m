Return-Path: <shawn.guo@linaro.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 02D632C0313
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 00:08:14 +1000 (EST)
Date: Thu, 11 Jul 2013 22:07:57 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: fsl: Disable SSI in trigger() if RE/TE are both
 cleared
Message-ID: <20130711140755.GA3361@S2101-09.ap.freescale.net>
References: <1373453034-21618-1-git-send-email-b42378@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1373453034-21618-1-git-send-email-b42378@freescale.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org,
 broonie@kernel.org, linuxppc-dev@lists.ozlabs.org, timur@tabi.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 10, 2013 at 06:43:54PM +0800, Nicolin Chen wrote:
> The code enabled SSIEN when triggered by SNDRV_PCM_TRIGGER_START,
> so move the disable code to SNDRV_PCM_TRIGGER_STOP for symmetric.
> 
> This also allows us to use the SSI driver more flexible so that
> it can support some use cases like "aplay S16_LE.wav S24_LE.wav"
> which would call the driver in sequence like:
>  startup()->hw_params(S16_LE)->trigger(START)->tirgger(STOP)->
>  hw_params(S24_LE)->trigger(START)->tirgger(STOP)->shutdown()
> 
> If we disable SSIEN in shutdown(), the second hw_params() would
> bypass the sample bits setting while using symmetric_rate.
> 
> Signed-off-by: Nicolin Chen <b42378@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  sound/soc/fsl/fsl_ssi.c |   12 +++---------
>  1 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 2f2d837..b6ab341 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -510,6 +510,9 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
>  			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_TE, 0);
>  		else
>  			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_RE, 0);
> +
> +		if ((read_ssi(&ssi->scr) & (CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE)) == 0)
> +			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_SSIEN, 0);
>  		break;
>  
>  	default:
> @@ -534,15 +537,6 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
>  		ssi_private->first_stream = ssi_private->second_stream;
>  
>  	ssi_private->second_stream = NULL;
> -
> -	/*
> -	 * If this is the last active substream, disable the SSI.
> -	 */
> -	if (!ssi_private->first_stream) {
> -		struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
> -
> -		write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_SSIEN, 0);
> -	}
>  }
>  
>  static int fsl_ssi_dai_probe(struct snd_soc_dai *dai)
> -- 
> 1.7.1
> 
> 

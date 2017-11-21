Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ygm2737NjzDrMM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 11:00:47 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id p9so8684689pgc.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Nov 2017 16:00:47 -0800 (PST)
Date: Mon, 20 Nov 2017 16:00:43 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: call _fsl_ssi_set_dai_fmt()
 just once in AC'97 mode
Message-ID: <20171121000042.GB14136@Asurada-Nvidia>
References: <81ad2e7e-e070-c38e-b318-9607b4558ee7@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <81ad2e7e-e070-c38e-b318-9607b4558ee7@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 20, 2017 at 11:13:45PM +0100, Maciej S. Szmigiero wrote:
> In AC'97 mode we configure and start SSI RX / TX on probe path via
> a call to _fsl_ssi_set_dai_fmt() function.
> We don't need to call this function again later and in fact don't want to
> do it since this function temporarily sets STCR, SRCR and SCR to some
> intermediate values.
> 
> We need to make sure, however, that only proper channel slots are enabled
> at playback start time since some AC'97 CODECs (like VT1613) were observed
> requesting via SLOTREQ (and so enabling at SSI) spurious ones just after
> an AC'97 link is started but before the CODEC is configured by its driver.

I don't really understand this part. Why do we need to *make sure*
and set SACCDIS and SACCEN again since they're initialized already?

Could you please elaborate a bit more?

> Theoretically, this should be necessary only for the very first playback
> but let's play safe here and make sure that no extra slots are enabled
> every time a playback is started.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>  sound/soc/fsl/fsl_ssi.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 48bb850a34d9..dad80b4b0cfc 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -630,12 +630,6 @@ static void fsl_ssi_setup_ac97(struct fsl_ssi_private *ssi_private)
>  	regmap_write(regs, CCSR_SSI_SACNT,
>  			CCSR_SSI_SACNT_AC97EN | CCSR_SSI_SACNT_FV);
>  
> -	/* no SACC{ST,EN,DIS} regs on imx21-class SSI */
> -	if (!ssi_private->soc->imx21regs) {
> -		regmap_write(regs, CCSR_SSI_SACCDIS, 0xff);
> -		regmap_write(regs, CCSR_SSI_SACCEN, 0x300);
> -	}

> @@ -1149,9 +1146,16 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
>  	case SNDRV_PCM_TRIGGER_START:
>  	case SNDRV_PCM_TRIGGER_RESUME:
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> -		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +			/* no SACC{ST,EN,DIS} regs on imx21-class SSI */
> +			if (fsl_ssi_is_ac97(ssi_private) &&
> +				!ssi_private->soc->imx21regs) {
> +				regmap_write(regs, CCSR_SSI_SACCDIS, 0xff);
> +				regmap_write(regs, CCSR_SSI_SACCEN, 0x300);
> +			}

And second, why could we ignore them for STREAM_CAPTURE here?

Well, at least this part could be moved into fsl_ssi_tx_config()
since we have an abstraction layer of register configurations.

Thanks
Nic

> +
>  			fsl_ssi_tx_config(ssi_private, true);
> -		else
> +		} else
>  			fsl_ssi_rx_config(ssi_private, true);
>  		break;
>  
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ymjz74KmFzDrbN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 12:45:22 +1100 (AEDT)
Received: by mail-pl0-x244.google.com with SMTP id x4so1097774plv.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 17:45:22 -0800 (PST)
Date: Tue, 28 Nov 2017 17:45:25 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [alsa-devel] [PATCH v2 1/2] ASoC: fsl_ssi: only enable proper
 channel slots in AC'97 mode
Message-ID: <20171129014524.GA7918@Asurada-Nvidia>
References: <5fafe9ba-ef40-66ef-80ca-b8333e10774e@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5fafe9ba-ef40-66ef-80ca-b8333e10774e@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 22, 2017 at 12:54:26AM +0100, Maciej S. Szmigiero wrote:
> We need to make sure that only proper channel slots (in SACCST register)
> are enabled at playback start time since some AC'97 CODECs (like VT1613 on
> UDOO board) were observed requesting via SLOTREQ spurious ones just after
> an AC'97 link is started but before the CODEC is configured by its driver.
> When a bit for some channel slot is set in a SLOTREQ request then SSI sets
> the relevant bit in SACCST automatically, which then 'sticks' until it is
> manually unset.
> The SACCST register is not writable directly, we have to use SACCDIS and
> SACCEN registers to configure it instead (these aren't normal registers:
> writing a '1' bit at some position in SACCEN sets the relevant bit in
> SACCST; SACCDIS operates in a similar way but allows unsetting bits in
> SACCST).
> 
> Theoretically, this should be necessary only for the very first playback
> but since some CODECs are so untrustworthy and extra channel slots enabled
> mean ruined playback let's play safe here and make sure that no extra
> slots are enabled in SACCST every time a playback is started.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

The inline comments feel over descriptive but not critical. Anyway,
I plan to do some clean up to this driver after all pending changes
get finalized. So,

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
> Changes from v1: Split out this part from
> "fsl_ssi: call _fsl_ssi_set_dai_fmt() just once in AC'97 mode" commit,
> describe the problem and its solution better both in the commit message and
> in the code, move the SACCST setup code into a separate function and call
> it from TX config instead of doing it from trigger handler function.
> 
>  sound/soc/fsl/fsl_ssi.c | 52 +++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 46 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 48bb850a34d9..375aaaf6080d 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -574,8 +574,54 @@ static void fsl_ssi_rx_config(struct fsl_ssi_private *ssi_private, bool enable)
>  	fsl_ssi_config(ssi_private, enable, &ssi_private->rxtx_reg_val.rx);
>  }
>  
> +static void fsl_ssi_tx_ac97_saccst_setup(struct fsl_ssi_private *ssi_private)
> +{
> +	struct regmap *regs = ssi_private->regs;
> +
> +	/* no SACC{ST,EN,DIS} regs on imx21-class SSI */
> +	if (!ssi_private->soc->imx21regs) {
> +		/*
> +		 * Note that these below aren't just normal registers.
> +		 * They are a way to disable or enable bits in SACCST
> +		 * register:
> +		 * - writing a '1' bit at some position in SACCEN sets the
> +		 * relevant bit in SACCST,
> +		 * - writing a '1' bit at some position in SACCDIS unsets
> +		 * the relevant bit in SACCST register.
> +		 *
> +		 * The two writes below first disable all channels slots,
> +		 * then enable just slots 3 & 4 ("PCM Playback Left Channel"
> +		 * and "PCM Playback Right Channel").
> +		 */
> +		regmap_write(regs, CCSR_SSI_SACCDIS, 0xff);
> +		regmap_write(regs, CCSR_SSI_SACCEN, 0x300);
> +	}
> +}
> +
>  static void fsl_ssi_tx_config(struct fsl_ssi_private *ssi_private, bool enable)
>  {
> +	/*
> +	 * Why are we setting up SACCST everytime we are starting a
> +	 * playback?
> +	 * Some CODECs (like VT1613 CODEC on UDOO board) like to
> +	 * (sometimes) set extra bits in their SLOTREQ requests.
> +	 * When a bit is set in a SLOTREQ request then SSI sets the
> +	 * relevant bit in SACCST automatically (it is enough if a bit was
> +	 * set in a SLOTREQ just once, bits in SACCST are 'sticky').
> +	 * If an extra slot gets enabled that's a disaster for playback
> +	 * because some of normal left or right channel samples are
> +	 * redirected instead to this extra slot.
> +	 *
> +	 * A workaround implemented in fsl-asoc-card of setting an
> +	 * appropriate CODEC register so that slots 3 & 4 (the normal
> +	 * stereo playback slots) are used for S/PDIF seems to mostly fix
> +	 * this issue on the UDOO board but since this CODEC is so
> +	 * untrustworthy let's play safe here and make sure that no extra
> +	 * slots are enabled every time a playback is started.
> +	 */
> +	if (enable && fsl_ssi_is_ac97(ssi_private))
> +		fsl_ssi_tx_ac97_saccst_setup(ssi_private);
> +
>  	fsl_ssi_config(ssi_private, enable, &ssi_private->rxtx_reg_val.tx);
>  }
>  
> @@ -630,12 +676,6 @@ static void fsl_ssi_setup_ac97(struct fsl_ssi_private *ssi_private)
>  	regmap_write(regs, CCSR_SSI_SACNT,
>  			CCSR_SSI_SACNT_AC97EN | CCSR_SSI_SACNT_FV);
>  
> -	/* no SACC{ST,EN,DIS} regs on imx21-class SSI */
> -	if (!ssi_private->soc->imx21regs) {
> -		regmap_write(regs, CCSR_SSI_SACCDIS, 0xff);
> -		regmap_write(regs, CCSR_SSI_SACCEN, 0x300);
> -	}
> -
>  	/*
>  	 * Enable SSI, Transmit and Receive. AC97 has to communicate with the
>  	 * codec before a stream is started.
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

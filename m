Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ygl2m1tbfzDrKG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 10:16:15 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id x7so8432134pfa.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Nov 2017 15:16:15 -0800 (PST)
Date: Mon, 20 Nov 2017 15:16:09 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: remove duplicated flag
 setting in fsl_ssi_setup_reg_vals()
Message-ID: <20171120231608.GA14136@Asurada-Nvidia>
References: <9c78bea8-c264-0094-c2e9-950a9f7797e6@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9c78bea8-c264-0094-c2e9-950a9f7797e6@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 20, 2017 at 11:12:01PM +0100, Maciej S. Szmigiero wrote:
> We don't need to set CCSR_SSI_SIER_RFF0_EN / CCSR_SSI_SIER_TFE0_EN bits
> in reg->rx.sier / reg->tx.sier variables in a non-AC'97 mode considering we
> had just initialized these variables to these very values unconditionally a
> few lines earlier.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_ssi.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index f2f51e06e22c..48bb850a34d9 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -597,9 +597,7 @@ static void fsl_ssi_setup_reg_vals(struct fsl_ssi_private *ssi_private)
>  
>  	if (!fsl_ssi_is_ac97(ssi_private)) {
>  		reg->rx.scr = CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_RE;
> -		reg->rx.sier |= CCSR_SSI_SIER_RFF0_EN;
>  		reg->tx.scr = CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE;
> -		reg->tx.sier |= CCSR_SSI_SIER_TFE0_EN;
>  	}
>  
>  	if (ssi_private->use_dma) {
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

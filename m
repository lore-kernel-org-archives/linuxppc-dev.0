Return-Path: <guangyu.chen@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0185.outbound.protection.outlook.com [207.46.163.185])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 79E551A0875
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 14:35:33 +1000 (EST)
Date: Thu, 7 Aug 2014 12:26:27 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: Re: [alsa-devel] [PATCH V1 1/2] ASoC: fsl: esai: refine esai for tdm
 support
Message-ID: <20140807042626.GA2709@MrMyself>
References: <cover.1407320232.git.shengjiu.wang@freescale.com>
 <e68d8fbaaed7000b13688b0f1757b5b9557889d7.1407320232.git.shengjiu.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <e68d8fbaaed7000b13688b0f1757b5b9557889d7.1407320232.git.shengjiu.wang@freescale.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, timur@tabi.org,
 arnd@arndb.de, shc_work@mail.ru, tiwai@suse.de, Li.Xiubo@freescale.com,
 lgirdwood@gmail.com, perex@perex.cz, nicoleotsuka@gmail.com,
 broonie@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

About the title, please follow the old pattern:

ASoC: fsl_esai: Refine....

You can get the history from 'git log --oneline sound/soc/fsl/fsl_esai.c'

On Wed, Aug 06, 2014 at 06:23:03PM +0800, Shengjiu Wang wrote:
> Add parameter for slots, and caculate the number of TX/RX pins and bclk with
> slots. Then driver will be compatible with slots > 2 in TDM mode.

Hmm...although I totally understand what the patch's exactly improving,
I suggest to describe more so that other people can get a quick idea
even without looking at the code, like what the original driver lacks
or what's the problem of the original design, how this patch fulfills
this feature and why some change have to be done, those change in the
header file for example.

> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
> ---
>  sound/soc/fsl/fsl_esai.c |   10 +++++++---
>  sound/soc/fsl/fsl_esai.h |    8 ++++----
>  2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index 72d154e..89aa531 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -56,6 +56,7 @@ struct fsl_esai {
>  	struct clk *fsysclk;
>  	u32 fifo_depth;
>  	u32 slot_width;
> +	u32 slots;
>  	u32 hck_rate[2];
>  	u32 sck_rate[2];
>  	bool hck_dir[2];

Please append a description for the new member to the existing comments
above the structure define.

> @@ -363,6 +364,7 @@ static int fsl_esai_set_dai_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask,
>  			   ESAI_xSMB_xS_MASK, ESAI_xSMB_xS(rx_mask));
>  
>  	esai_priv->slot_width = slot_width;
> +	esai_priv->slots      = slots;

I prefer not to add indentation here, even thought this doesn't hurt.
Just...If there's going to be a subsequent patch adding a new member
assignment whose name's longer than slot_width, the style'll be broken
as well. For example:
	esai_priv->slot_width = slot_width;
	esai_priv->slots      = slots;
	esai_priv->slot_samplebit = slots;

The indentation for the 'slots' will look abnormal.
	
>  
>  	return 0;
>  }
> @@ -510,10 +512,11 @@ static int fsl_esai_hw_params(struct snd_pcm_substream *substream,
>  	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
>  	u32 width = snd_pcm_format_width(params_format(params));
>  	u32 channels = params_channels(params);
> +	u32 pin = DIV_ROUND_UP(channels, esai_priv->slots);

This may cause a 'Division by zero' here. The 'slots' is only assigned
in set_dai_tdm_slot(). As default, a machine driver who does not call
set_dai_tdm_slot() will get a zero slot. We must give 'slots' a default
value (2 for example) somewhere during initialization.

And another personal suggestion -- using name 'pins' might be better.

Thank you Shengjiu,
Nicolin

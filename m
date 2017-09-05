Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xmZS33DxMzDqZ9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 15:06:11 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id m9so1340256pgd.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Sep 2017 22:06:10 -0700 (PDT)
Date: Mon, 4 Sep 2017 22:06:03 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk when it is equal
 to system freq
Message-ID: <20170905050602.GA2774@Asurada-CZ80>
References: <1504436701-20700-1-git-send-email-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1504436701-20700-1-git-send-email-lukma@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 03, 2017 at 01:05:01PM +0200, Lukasz Majewski wrote:
> The problem is visible in the following setup (on the imx6q):
> "simple-audio-card" -> ssi2 -> I2S + I2C -> codec
> 
> The function call log (simple-card probe -> CONFIG_SND_SIMPLE_CARD):
> 
> asoc_simple_card_init_dai() @ sound/soc/generic/simple-card-utils.c
> snd_soc_dai_set_sysclk()
> fsl_ssi_set_dai_sysclk() @ sound/soc/fsl/fsl_ssi.c
> 
> The last call is changing the bit clock (BCLK) frequency to SSI's IP
> block clock (ipg = 66 MHz) [1].

I think a bigger question here is why the routine sets BCLK to 66MHz.

> This is wrong, since IMX SSI block requires the I2S BCLK to be less
> than 1/5 of [1].
> 
> As a result the driver initialization passes without any errors, but the
> speaker-test test case breaks.
> 
> This commit checks if the fsl_ssi_set_dai_sysclk() frequency passed is
> not equal to [1].

I don't feel it's quite comprehensive...what if it's being set to 67MHz.

Thanks
Nicolin

> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  sound/soc/fsl/fsl_ssi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 173cb84..1186fa9 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -809,6 +809,8 @@ static int fsl_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
>  		int clk_id, unsigned int freq, int dir)
>  {
>  	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
> +	if (clk_get_rate(ssi_private->clk) == freq)
> +		return 0;
>  
>  	ssi_private->bitclk_freq = freq;
>  
> -- 
> 2.1.4
> 

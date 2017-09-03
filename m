Return-Path: <lukma@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xlbHf69KFzDqjs
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Sep 2017 00:40:29 +1000 (AEST)
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk when it is equal
 to system freq
To: Fabio Estevam <fabio.estevam@nxp.com>, Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 "festevam@gmail.com" <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1504436701-20700-1-git-send-email-lukma@denx.de>
 <AM5PR0401MB262706674539BFE651706CC6E3900@AM5PR0401MB2627.eurprd04.prod.outlook.com>
From: =?UTF-8?Q?=c5=81ukasz_Majewski?= <lukma@denx.de>
Message-ID: <07e54d28-3bbc-aad2-146b-30867c0bc337@denx.de>
Date: Sun, 3 Sep 2017 16:40:21 +0200
MIME-Version: 1.0
In-Reply-To: <AM5PR0401MB262706674539BFE651706CC6E3900@AM5PR0401MB2627.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Fabio,


> [Sorry for the top-posting]
> 
> 
> The driver currently has:
> 
> 
> /*
> * Hardware limitation: The bclk rate must be
> * never greater than 1/5 IPG clock rate
> */
> if (freq * 5 > clk_get_rate(ssi_private->clk)) {
> dev_err(cpu_dai->dev, "bitclk > ipgclk/5\n");
> return -EINVAL;
> }
> 

Unfortunately not.

This is the part of fsl_ssi_set_bclk() function which is called after 
fsl_ssi_set_dai_sysclk() (which sets ssi_private->bitclk_freq = freq;).

Before the aforementioned check we do have:

	if (ssi_private->bitclk_freq)
		freq = ssi_private->bitclk_freq;
	else
		freq = params_channels(hw_params) * 32 * 	params_rate(hw_params);


Which assigns freq = bitclk_freq (66 MHz)

And then we break on this particular check:

66MHz * 5 > 66 MHz.



The culprit IMHO is the  ssi_private->bitclk_freq = freq; in the 
fsl_ssi_set_dai_sysclk(), since we _should_ set SSI's IP block clock 
(ssi_private->clk), not the bit clock (BCLK).


This patch just quits early if it detects change, which don't need to be 
done.

> 
> Isn't this properly taking care of the clock restriction?
> 
> ________________________________
> From: Lukasz Majewski <lukma@denx.de>
> Sent: Sunday, September 3, 2017 8:05:01 AM
> To: Timur Tabi; Nicolin Chen; Xiubo Li; Fabio Estevam; Liam Girdwood; Mark Brown; Jaroslav Kysela; Takashi Iwai
> Cc: alsa-devel@alsa-project.org; linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Lukasz Majewski
> Subject: [PATCH] sound: soc: fsl: Do not set DAI sysclk when it is equal to system freq
> 
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
> This is wrong, since IMX SSI block requires the I2S BCLK to be less
> than 1/5 of [1].
> 
> As a result the driver initialization passes without any errors, but the
> speaker-test test case breaks.
> 
> This commit checks if the fsl_ssi_set_dai_sysclk() frequency passed is
> not equal to [1].
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>   sound/soc/fsl/fsl_ssi.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 173cb84..1186fa9 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -809,6 +809,8 @@ static int fsl_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
>                   int clk_id, unsigned int freq, int dir)
>   {
>           struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
> +       if (clk_get_rate(ssi_private->clk) == freq)
> +               return 0;
> 
>           ssi_private->bitclk_freq = freq;
> 
> --
> 2.1.4
> 
> 


-- 
Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

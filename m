Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AEB121A0427
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Dec 2015 18:41:27 +1100 (AEDT)
Received: by mail-pa0-x231.google.com with SMTP id jx14so67173273pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Dec 2015 23:41:27 -0800 (PST)
Date: Sun, 20 Dec 2015 23:41:23 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: use different route map for AC'97
 mode
Message-ID: <20151221074122.GE3524@Asurada-CZ80>
References: <567710D5.5040405@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <567710D5.5040405@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Dec 20, 2015 at 09:34:29PM +0100, Maciej S. Szmigiero wrote:
> fsl_ssi uses different stream names ("AC97 Playback" / "AC97 Capture")
> in AC'97 mode so in this case fsl-asoc-card route map should
> also be using them.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl-asoc-card.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> index c63d89da51f1..562b3bd22d9a 100644
> --- a/sound/soc/fsl/fsl-asoc-card.c
> +++ b/sound/soc/fsl/fsl-asoc-card.c
> @@ -107,6 +107,13 @@ static const struct snd_soc_dapm_route audio_map[] = {
>  	{"CPU-Capture",  NULL, "Capture"},
>  };
>  
> +static const struct snd_soc_dapm_route audio_map_ac97[] = {
> +	{"AC97 Playback",  NULL, "ASRC-Playback"},
> +	{"Playback",  NULL, "AC97 Playback"},
> +	{"ASRC-Capture",  NULL, "AC97 Capture"},
> +	{"AC97 Capture",  NULL, "Capture"},
> +};
> +
>  /* Add all possible widgets into here without being redundant */
>  static const struct snd_soc_dapm_widget fsl_asoc_card_dapm_widgets[] = {
>  	SND_SOC_DAPM_LINE("Line Out Jack", NULL),
> @@ -579,7 +586,8 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>  	priv->card.dev = &pdev->dev;
>  	priv->card.name = priv->name;
>  	priv->card.dai_link = priv->dai_link;
> -	priv->card.dapm_routes = audio_map;
> +	priv->card.dapm_routes = fsl_asoc_card_is_ac97(priv) ?
> +				 audio_map_ac97 : audio_map;
>  	priv->card.late_probe = fsl_asoc_card_late_probe;
>  	priv->card.num_dapm_routes = ARRAY_SIZE(audio_map);
>  	priv->card.dapm_widgets = fsl_asoc_card_dapm_widgets;
> 

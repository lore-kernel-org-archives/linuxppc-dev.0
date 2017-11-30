Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x236.google.com (mail-pf0-x236.google.com
 [IPv6:2607:f8b0:400e:c00::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ynTRb2CPmzDrq6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 18:24:10 +1100 (AEDT)
Received: by mail-pf0-x236.google.com with SMTP id u25so2753136pfg.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 23:24:10 -0800 (PST)
Date: Wed, 29 Nov 2017 23:23:58 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v4 2/2] ASoC: fsl_ssi: add 20-bit sample format for AC'97
 and use it for capture
Message-ID: <20171130072357.GA992@Asurada>
References: <5dfa7813-385e-d9c7-84e0-12cf1f7d3a5f@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5dfa7813-385e-d9c7-84e0-12cf1f7d3a5f@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Maciej,

On Mon, Nov 27, 2017 at 11:34:44PM +0100, Maciej S. Szmigiero wrote:
> There is no problem in using different bit widths in playback and capture
> in AC'97 mode so allow this, too.

> @@ -1557,11 +1558,12 @@ static int fsl_ssi_probe(struct platform_device *pdev)
>  
>  	/* Are the RX and the TX clocks locked? */
>  	if (!of_find_property(np, "fsl,ssi-asynchronous", NULL)) {
> -		if (!fsl_ssi_is_ac97(ssi_private))
> +		if (!fsl_ssi_is_ac97(ssi_private)) {
>  			ssi_private->cpu_dai_drv.symmetric_rates = 1;
> +			ssi_private->cpu_dai_drv.symmetric_samplebits = 1;
> +		}
>  
>  		ssi_private->cpu_dai_drv.symmetric_channels = 1;
> -		ssi_private->cpu_dai_drv.symmetric_samplebits = 1;
>  	}

I was actually wondering how the AC97 works in the synchronous mode
while being able to handle different bit widths. Then I found that
the drivers does corresponding configurations for synchronous mode
only if symmetric_rates is set -- which is unset for AC97 cases. So
in fact AC97 case (symmetric_rates unset) is probably being treated
as asynchronous mode by the driver -- it'd be better if you confirm
this for me.

And I am not so sure about the physical pin connections in an AC97
situation, but I started to think that, instead of having a change
above, AC97 cases might be supposed to have "fsl,ssi-asynchronous"
property in DT since it's working when the driver sets both TX and
RX control registers (i.e. asynchronous mode), not like synchronous
mode that only sets TX's registers.

Thanks
Nicolin

Return-Path: <festevam@gmail.com>
Received: from mail-oi0-x230.google.com (mail-oi0-x230.google.com
 [IPv6:2607:f8b0:4003:c06::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xlcNh0sjFzDqgB
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Sep 2017 01:29:56 +1000 (AEST)
Received: by mail-oi0-x230.google.com with SMTP id r203so30031228oih.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Sep 2017 08:29:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <07e54d28-3bbc-aad2-146b-30867c0bc337@denx.de>
References: <1504436701-20700-1-git-send-email-lukma@denx.de>
 <AM5PR0401MB262706674539BFE651706CC6E3900@AM5PR0401MB2627.eurprd04.prod.outlook.com>
 <07e54d28-3bbc-aad2-146b-30867c0bc337@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 3 Sep 2017 12:29:53 -0300
Message-ID: <CAOMZO5Bifb8VcOLTd5dEY9KvnvY1jwVr4R4DVRT65Yzm7n6dpA@mail.gmail.com>
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk when it is equal
 to system freq
To: =?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@denx.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 3, 2017 at 11:40 AM, =C5=81ukasz Majewski <lukma@denx.de> wrote=
:

> This is the part of fsl_ssi_set_bclk() function which is called after
> fsl_ssi_set_dai_sysclk() (which sets ssi_private->bitclk_freq =3D freq;).
>
> Before the aforementioned check we do have:
>
>         if (ssi_private->bitclk_freq)
>                 freq =3D ssi_private->bitclk_freq;
>         else
>                 freq =3D params_channels(hw_params) * 32 *
> params_rate(hw_params);
>
>
> Which assigns freq =3D bitclk_freq (66 MHz)
>
> And then we break on this particular check:
>
> 66MHz * 5 > 66 MHz.
>
>
>
> The culprit IMHO is the  ssi_private->bitclk_freq =3D freq; in the
> fsl_ssi_set_dai_sysclk(), since we _should_ set SSI's IP block clock
> (ssi_private->clk), not the bit clock (BCLK).
>
>
> This patch just quits early if it detects change, which don't need to be
> done.

Thanks for the clarification.

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

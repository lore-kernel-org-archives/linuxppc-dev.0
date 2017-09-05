Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xmvsL5GCYzDqZx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 04:10:45 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id t3so2327524pgt.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Sep 2017 11:10:45 -0700 (PDT)
Date: Tue, 5 Sep 2017 11:11:09 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: =?utf-8?Q?=C5=81ukasz?= Majewski <lukma@denx.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Timur Tabi <timur@tabi.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, "festevam@gmail.com" <festevam@gmail.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk when it is equal
 to system freq
Message-ID: <20170905181108.GB23906@Asurada-Nvidia>
References: <1504436701-20700-1-git-send-email-lukma@denx.de>
 <AM5PR0401MB262706674539BFE651706CC6E3900@AM5PR0401MB2627.eurprd04.prod.outlook.com>
 <07e54d28-3bbc-aad2-146b-30867c0bc337@denx.de>
 <20170905052031.GB2774@Asurada-CZ80>
 <819784e1-910b-6833-997a-2097e147bd0c@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <819784e1-910b-6833-997a-2097e147bd0c@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 05, 2017 at 10:35:34AM +0200, Łukasz Majewski wrote:

> >And apparently, we shouldn't set bitclk to 66MHz either. Can
> >you help to find where this 66MHz comes from?

> 2. int asoc_simple_card_init_dai() @ simple-card-utils.c

Oh, I just searched in the simple-card.c but missed this file.

> In this function (point 2.) the
> simple_dai->sysclk is set and:
> snd_soc_dai_set_sysclk(dai, 0, simple_dai->sysclk, 0)
> which sets frequency to 66 MHz [*].
> 
> The asoc_simple_card_init_dai() is called in
> asoc_simple_card_dai_init() @ simple-card.c
> which is assigned to dai_link->init
> dai_link->init		= asoc_simple_card_dai_init; @ simple_card.c
> 
> And the sysclk itself is defined at:
> -------------------------------------
> dai_props->codec_dai->sysclk, which is used at:a

Why codec_dai? Why not dai_props->cpu_dai->sysclk since we are talking
about SSI?

> asoc_simple_card_startup(), asoc_simple_card_shutdown() and others
> functions at simple-card.c
> It is setup at:
> asoc_simple_card_parse_clk() @ simple-card-utils.c from macro:
> #define asoc_simple_card_parse_clk_cpu()
> And the problem is:
> -------------------
> 
> At the
> asoc_simple_card_parse_clk()
> we finally go to dts node:
> /soc/aips-bus@02100000/i2c@021a0000/tfa9879@6C

This tfa9879 should be the CODEC right?

> which has clock from I2C (66 MHz).

You mean I2C scl or I2S sclk?

-----------------------------------------------------------------

But anyway, I feel very confused here as you have 66MHz clock rate
(regardless of it purpose) for a codec dai but it's been passed to
a cpu dai (SSI).

> [*] - I could workaround this problem by setting:
> 
> system-clock-frequency = <0> in
> 
> 			dailink_master: cpu {
> 			    sound-dai = <&ssi2>;
> 			};
> 
> but this is IMHO even worse hack.... than this patch.

I haven't used simple-card for a while so I forgot how to define
its DT bindings specifically. But you should assign ssi2 as the
CPU dai and assign tfa9879 as a CODEC dai.

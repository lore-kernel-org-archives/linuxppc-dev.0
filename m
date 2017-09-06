Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x22d.google.com (mail-pf0-x22d.google.com
 [IPv6:2607:f8b0:400e:c00::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnYyR68h8zDqbZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 05:47:27 +1000 (AEST)
Received: by mail-pf0-x22d.google.com with SMTP id e1so349493pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Sep 2017 12:47:27 -0700 (PDT)
Date: Wed, 6 Sep 2017 12:47:49 -0700
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
Message-ID: <20170906194748.GA31334@Asurada-Nvidia>
References: <AM5PR0401MB262706674539BFE651706CC6E3900@AM5PR0401MB2627.eurprd04.prod.outlook.com>
 <07e54d28-3bbc-aad2-146b-30867c0bc337@denx.de>
 <20170905052031.GB2774@Asurada-CZ80>
 <819784e1-910b-6833-997a-2097e147bd0c@denx.de>
 <20170905181108.GB23906@Asurada-Nvidia>
 <cfb8f844-87aa-f1f3-bd55-4f2b60f3cf88@denx.de>
 <20170905225225.GA14132@Asurada-Nvidia>
 <ae1d3e2a-d618-05e2-1572-5593caff1ee0@denx.de>
 <20170906173348.GA28104@Asurada-Nvidia>
 <69352458-2e90-a847-2c2f-bba259a32162@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <69352458-2e90-a847-2c2f-bba259a32162@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 06, 2017 at 08:35:50PM +0200, Łukasz Majewski wrote:
 
> 	clocks = <&clks IMX6QDL_CLK_SSI2_IPG>,
> 		 <&clks IMX6QDL_CLK_SSI2>;
> 	clock-names = "ipg", "baud";

> >>  			dailink_master: cpu {
> >>  			    sound-dai = <&ssi2>;
> >>			    clock = <&SSSS>;
> 
> 	If possible I do prefer a solution, which uses only DTS.
> Side question - how to refer to baud clock from [1]?

Just add a property to this cpu node like:
	clock = <&clks IMX6QDL_CLK_SSI2>;

> >>			    system-clock-frequency = <XXXX>;

This would not be necessary unless you want to specify a clock rate
so as to override the clock rate configuration in hw_params().

> >This is the right solution based on current simple-card driver. For
> >SSI (having two clocks), you have to specify the baud clock in the
> >cpu node like that. I believe this is what the simple-card designer
> >expected users to do since the cpu node is the first place that the
> >driver tries to look at.
> 
> I will give a shoot the option with adding the ipg clock.

No, not ipg clock. You should use the second clock -- baud clock.

Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpGG529NyzDrXd
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 09:03:24 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id v82so517847pgb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Sep 2017 16:03:24 -0700 (PDT)
Date: Thu, 7 Sep 2017 16:03:48 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: =?utf-8?Q?=C5=81ukasz?= Majewski <lukma@denx.de>,
 Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk when it is equal
 to system freq
Message-ID: <20170907230345.GA20531@Asurada-Nvidia>
References: <1504436701-20700-1-git-send-email-lukma@denx.de>
 <20170905050602.GA2774@Asurada-CZ80>
 <bbcb123b-8700-501f-e6d9-cab9e212de40@denx.de>
 <20170905075247.GA6112@Asurada>
 <deb40031-9db0-d667-7314-352cf548c295@denx.de>
 <20170905151550.5mhb535p22lsohlh@sirena.org.uk>
 <20170905174528.GA23906@Asurada-Nvidia>
 <20170907134411.uzwh54lstzmvp6dd@sirena.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170907134411.uzwh54lstzmvp6dd@sirena.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 07, 2017 at 02:44:11PM +0100, Mark Brown wrote:
 
> > On the other hand, the sys clock (baudclk in the driver) should be
> > configured whenever it's related to external clock outputs. When I
> > implemented this set_sysclk() for fsl_ssi.c, I used it to set this
> > sys clock (baudclk) by a machine driver, in order to set bit clock.
> > Then someone patched the driver by moving all the code to set_bclk()
> > to make machine drivers simpler. Now the set_sysclk() is remained
> > to give machine drivers a chance to override clock configurations
> > in the hw_params(). This could be used in TDM or some other special
> > cases (It could also have a purpose for backwards compatibility).
> 
> > So here, we should set baudclk (BCLK generator).
> 
> No, that's just going to cause confusion - if all the other drivers are
> using set_sysclk() to set an input clock rate to the IP rather than an
> output clock but your driver does something else then sooner or later
> someone will run into trouble with that.  

I admit I had that concern. Probably I should have deprecated this
set_sysclk(). I will try to patch it and hw_params() accordingly.

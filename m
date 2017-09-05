Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xmvHn2xdLzDqq1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 03:45:08 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id 63so417079pgc.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Sep 2017 10:45:08 -0700 (PDT)
Date: Tue, 5 Sep 2017 10:45:29 -0700
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
Message-ID: <20170905174528.GA23906@Asurada-Nvidia>
References: <1504436701-20700-1-git-send-email-lukma@denx.de>
 <20170905050602.GA2774@Asurada-CZ80>
 <bbcb123b-8700-501f-e6d9-cab9e212de40@denx.de>
 <20170905075247.GA6112@Asurada>
 <deb40031-9db0-d667-7314-352cf548c295@denx.de>
 <20170905151550.5mhb535p22lsohlh@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170905151550.5mhb535p22lsohlh@sirena.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 05, 2017 at 04:15:50PM +0100, Mark Brown wrote:
 
> > Just to be clear:
> 
> > What clock shall be set with:
> 
> > struct snd_soc_dai_ops {
> > 	int (*set_sysclk)(struct snd_soc_dai *dai,
> > 		int clk_id, unsigned int freq, int dir);
> > }
> 
> > callback?
> 
> > The SSI IP block or BCLK ?
> 
> Not the BCLK, probably the IP clock but perhaps nothing.  The bclk is
> usually derived from the sample rate and width, the system clock is the
> clock rate going into the device.  It doesn't *have* to be configured
> (particuarly if it's discoverable by the IP and managable via the clock
> API).

Hmm...to clarify the things, some background here:
	
SSI has mainly two different clock inputs internally (not external
pads such as bclk or lrclk): IP block clock (ipg_clk in Reference
Manual) and sys clock (ccm_ssi_clk in Reference Manual). According
to RM, ccm_ssi_clk: "module/system clock for bit clock generation".

The ipg clock is merely used to access registers, and has nothing
(directly) to do with external clock outputs. The driver shall not
change the ipg clock as the system ipg clock (its parent clock)
might be messed and even system time would get weird -- happened
once when the fsl_spdif driver used to call clk_set_rate() on its
ipg clock. Although the clock controller should have some kind of
protection in my opinion, we just avoid IP clock rate change in all
audio drivers as well.

On the other hand, the sys clock (baudclk in the driver) should be
configured whenever it's related to external clock outputs. When I
implemented this set_sysclk() for fsl_ssi.c, I used it to set this
sys clock (baudclk) by a machine driver, in order to set bit clock.
Then someone patched the driver by moving all the code to set_bclk()
to make machine drivers simpler. Now the set_sysclk() is remained
to give machine drivers a chance to override clock configurations
in the hw_params(). This could be used in TDM or some other special
cases (It could also have a purpose for backwards compatibility).

So here, we should set baudclk (BCLK generator).

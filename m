Return-Path: <sha@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 90FAF2C01C5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 17:08:37 +1000 (EST)
Date: Fri, 16 Aug 2013 09:08:18 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v5 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Message-ID: <20130816070818.GM26614@pengutronix.de>
References: <cover.1376565456.git.b42378@freescale.com>
 <4eb991fafc171305ebc71847fecb7bdae0ede927.1376565456.git.b42378@freescale.com>
 <2188999.03O3zirCAO@flatron> <20130816044330.GD1846@MrMyself>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130816044330.GD1846@MrMyself>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, ian.campbell@citrix.com,
 pawel.moll@arm.com, swarren@wwwdotorg.org, festevam@gmail.com,
 Tomasz Figa <tomasz.figa@gmail.com>, rob.herring@calxeda.com, timur@tabi.org,
 broonie@kernel.org, p.zabel@pengutronix.de, galak@codeaurora.org,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 16, 2013 at 12:43:31PM +0800, Nicolin Chen wrote:
> Hi Tomasz,
>    
>    Thank you for the comments. I'll revise them in v6.
>    And below is my reply for you comments.
> 
> On Thu, Aug 15, 2013 at 02:18:22PM +0200, Tomasz Figa wrote:
> > > +  - clock-names : Includes the following entries:
> > > +	name		type		comments
> > > +	"core"		Required	The core clock of spdif controller
> > > +
> > > +	"rx"		Optional	Rx clock source for spdif record.
> > > +					If absent, will use core clock.
> > > +
> > > +	"tx"		Optional	Tx clock source for spdif playback.
> > > +					If absent, will use core clock.
> > > +
> > > +	"tx-32000"	Optional	Tx clock source for 32000Hz sample rate
> > > +					playback. If absent, will use tx clock.
> > > +
> > > +	"tx-44100"	Optional	Tx clock source for 44100Hz sample rate
> > > +					playback. If absent, will use tx clock.
> > > +
> > > +	"tx-48000"	Optional	Tx clock source for 48000Hz sample rate
> > > +					playback. If absent, will use tx clock.
> > > +
> > > +	"src<0-7>"	Optional	Clock source list for tx and rx clock
> > > +					to look up their clock source indexes.
> > > +					This clock list should be identical to
> > > +					the list of TxClk_Source bit value of
> > > +					register SPDIF_STC. If absent or failed
> > > +					to look up, tx and rx clock would then
> > > +					ignore the "rx", "tx" "tx-32000",
> > > +					"tx-44100", "tx-48000" clock phandles
> > > +					and select the core clock as default
> > > +					tx and rx clock.
> > 
> > I suspect a little abuse of clocks property here. From the description of
> > "core" and "src<0-7>" clocks I assume that the IP can have up to 9 clock
> > inputs - core clock and up to 8 extra source clocks. Is it correct?
> > 
> > If yes, this makes the "tx", "rx" and "tx-*" clocks describe
> > configuration, not hardware. IMHO it should be up to the driver which
> > source clocks to use for tx and rx channels and for each sampling rate.
> 
> First, you are right that all the properties you just commented are
> software configurations. And I got the point that device tree now
> can't allow any software configuration even if the actual hardware
> connection will depend on it.
> 
> If so, I would like to remove those abused clocks and also drop the 
> unused clocks in src<0-7>, then just remain those needed clocks src.
> I think that can be plausible because there'll be no more clock abuse
> and the driver will be able to get the source index from the name 
> 'src<num>'.
> 
> And you are right about the 9 clock inputs, just there're not only 9
> inputs but also an extra external clock from S/PDIF transmitter via
> coaxial cable or optical fiber -- RxCLK. Please check the following
> list:
> 
> 0000 if (DPLL Locked) SPDIF_RxClk else extal
> 0001 if (DPLL Locked) SPDIF_RxClk else spdif_clk
> 0010 if (DPLL Locked) SPDIF_RxClk else asrc_clk
> 0011 if (DPLL Locked) SPDIF_RxClk else spdif_extclk
> 0100 if (DPLL Locked) SPDIF_Rxclk else esai_hckt
> 0101 extal_clk
> 0110 spdif_clk
> 0111 asrc_clk
> 1000 spdif_extclk
> 1001 esai_hckt
> 1010 if (DPLL Locked) SPDIF_RxClk else mlb_clk
> 1011 if (DPLL Locked) SPDIF_RxClk else mlb_phy_clk
> 1100 mkb_clk
> 1101 mlb_phy_clk
> 
> When (DPLL Locked) condition matches, the rx clock can ignore the 8 input
> clocks from clock mux then use the external one from a S/PDIF transmitter.

So extal, spdif_clk, asrc_clk, spdif_extclk, esai_hckt, mlb_clk and
mlb_phy_clk are clocks provided to the S/PDIF core and thus should be
described in the devicetree.

Which of them the driver should use is configuration and thus normally
should *not* be described in the devicetree. However, there may be no
good way for the driver to know which clock to use in which case. There
may be additional board requirements which are unknown to the driver. So
in this case it might be valid to put the information which clock to use
into the devicetree. But be aware that from the moment you put this
information into the devicetree the driver is no longer free to chose
the best clock, even if in future we find a good way to automatically
guess the best clock. Do you have some insights in which case I would
use which input clock? Is this only about which clock has the best
suitable input frequency or is this also about synchronization of the
audio signal with some other unit?

Likewise with the rx-clksrc-lock property. what are the reasons to
enable/disable this property? Is this an option you want to change
during runtime? Is it an option you always want to use when it's
available?

If you don't know the answer then it might be a good option to just let
the driver pick a sane default. If someone feels the need to change the
default he probably comes up with a good reason why this is necessary.
And then we can discuss again whether we want to have the option in the
devicetree or some sysfs entry or whatever else.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

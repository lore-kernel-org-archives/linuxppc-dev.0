Return-Path: <sha@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 71FD32C019D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 18:56:48 +1000 (EST)
Date: Fri, 16 Aug 2013 10:56:32 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v5 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Message-ID: <20130816085632.GO26614@pengutronix.de>
References: <cover.1376565456.git.b42378@freescale.com>
 <4eb991fafc171305ebc71847fecb7bdae0ede927.1376565456.git.b42378@freescale.com>
 <2188999.03O3zirCAO@flatron> <20130816044330.GD1846@MrMyself>
 <20130816070818.GM26614@pengutronix.de>
 <20130816080124.GE1846@MrMyself>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130816080124.GE1846@MrMyself>
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

On Fri, Aug 16, 2013 at 04:01:25PM +0800, Nicolin Chen wrote:
> Hi Sascha,
> 
>    Thank you for the detailed comments.
> 
> On Fri, Aug 16, 2013 at 09:08:18AM +0200, Sascha Hauer wrote:
> > Which of them the driver should use is configuration and thus normally
> > should *not* be described in the devicetree. However, there may be no
> > good way for the driver to know which clock to use in which case. There
> > may be additional board requirements which are unknown to the driver. So
> > in this case it might be valid to put the information which clock to use
> > into the devicetree. But be aware that from the moment you put this
> > information into the devicetree the driver is no longer free to chose
> > the best clock, even if in future we find a good way to automatically
> > guess the best clock. Do you have some insights in which case I would
> > use which input clock? Is this only about which clock has the best
> > suitable input frequency or is this also about synchronization of the
> > audio signal with some other unit?
> 
> I understand. What I'm thinking now is to let the driver find the best
> clock source for tx clock and a correspond divisor like this:
> 
> "tx<0-8>"	Optional	Tx clock source for spdif playback.
> 				If absent, will use core clock.
> 				The index from 0 to 8 is identical
> 				to the clock source list described
> 				in TxClk_Source bit of register STC.
> 				Multiple clock source are allowed
> 				for this tx clock source. The driver
> 				will select one source from them for
> 				each supported sample rate according
> 				to the clock rates of these provided
> 				clock sources.

You mean tx<0-7>.

Also I would make this option required. Use a dummy clock for mux inputs
that are grounded for a specific SoC.

> 
> Please review this idea.
> 
> 
> And likewise for rx:
> 
> "rx<0-16>"	Optional	Rx clock source for spdif record.
> 				If absent, will use core clock.
> 				The index from 0 to 16 is identical
> 				to the clock source list described
> 				in ClkSrc_Sel bit of register SRPC.
> 				If the index provided contains an
> 				"if (DPLL Locked)" condition in its
> 				source, the correspond clock phandle
> 				should be the one in "else" path.
> 				Only one rx clock source should be
> 				defined here.

Again, describe the input clocks *to* *the* *S/PDIF* *core* in the
devicetree. Nothing more, nothing less. We've already been at the point
where we realized that half of the above clocks only describe the
'PDLL locked' condition. Also the tx clocks are from what I see identical
to the rx clocks. The following are the clocks:

clock-names: "core", "rxtx<0-7>" Required. The S/PDIF core has a core
clock and 8 clocks which are muxed internally to provide input/output
sample clocks.

This is all binding that is needed for now.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

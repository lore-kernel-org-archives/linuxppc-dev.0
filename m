Return-Path: <B42378@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 37C802C0261
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 19:56:29 +1000 (EST)
Date: Fri, 16 Aug 2013 17:53:58 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v5 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Message-ID: <20130816095357.GA4694@MrMyself>
References: <cover.1376565456.git.b42378@freescale.com>
 <4eb991fafc171305ebc71847fecb7bdae0ede927.1376565456.git.b42378@freescale.com>
 <2188999.03O3zirCAO@flatron> <20130816044330.GD1846@MrMyself>
 <20130816070818.GM26614@pengutronix.de>
 <20130816080124.GE1846@MrMyself>
 <20130816085632.GO26614@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20130816085632.GO26614@pengutronix.de>
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

On Fri, Aug 16, 2013 at 10:56:32AM +0200, Sascha Hauer wrote:
> > "tx<0-8>"	Optional	Tx clock source for spdif playback.
> > 				If absent, will use core clock.
> > 				The index from 0 to 8 is identical
> > 				to the clock source list described
> > 				in TxClk_Source bit of register STC.
> > 				Multiple clock source are allowed
> > 				for this tx clock source. The driver
> > 				will select one source from them for
> > 				each supported sample rate according
> > 				to the clock rates of these provided
> > 				clock sources.
> 
> You mean tx<0-7>

Yes. Thank you.

> Also I would make this option required. Use a dummy clock for mux inputs
> that are grounded for a specific SoC.

Some clocks are not from CCM and we haven't defined in imx6q-clk.txt,
so in most cases we can't provide a phandle for them, eg: spdif_ext.
I think it's a bit hard to force it to be 'required'. An 'optional'
looks more flexible to me and a default one is ensured even if it's
missing.

> > "rx<0-16>"	Optional	Rx clock source for spdif record.
> > 				If absent, will use core clock.
> > 				The index from 0 to 16 is identical
> > 				to the clock source list described
> > 				in ClkSrc_Sel bit of register SRPC.
> > 				If the index provided contains an
> > 				"if (DPLL Locked)" condition in its
> > 				source, the correspond clock phandle
> > 				should be the one in "else" path.
> > 				Only one rx clock source should be
> > 				defined here.
> 
> Again, describe the input clocks *to* *the* *S/PDIF* *core* in the
> devicetree. Nothing more, nothing less. We've already been at the point
> where we realized that half of the above clocks only describe the
> 'PDLL locked' condition. Also the tx clocks are from what I see identical
> to the rx clocks. The following are the clocks:
> 
> clock-names: "core", "rxtx<0-7>" Required. The S/PDIF core has a core
> clock and 8 clocks which are muxed internally to provide input/output
> sample clocks.

I know the reason why you suggest to combine two into 'rxtx<0-7>'
is because the clock mux is defined so. And the previous suggestion
'the option required' is also because of it. But actually the rxclk 
itself, can be not only routed from the clock mux but also derived
from DPLL of SPDIF Rx BLOCK as well. So, IMHO, it's more likely to
be a fact that rxclk actually has 9 clock source, 8 from mux and
1 from DPLL. But why we here have to exclude it?


WELL anyway, I know my opinion might not be concerned so much. So
I would like to follow the suggestion as an expediency because I
still wish this patch could be finally applied and merged into
mainline :(

But I still don't get why we need to be so obsessed to make this
impenetrable rule of devicetree that we here have to sacrifice
something we could have reasonably done.

And thank you for the comments again, Sascha.
Nicolin Chen

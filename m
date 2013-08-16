Return-Path: <B42378@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6FE9A2C0232
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 14:46:06 +1000 (EST)
Date: Fri, 16 Aug 2013 12:43:31 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v5 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Message-ID: <20130816044330.GD1846@MrMyself>
References: <cover.1376565456.git.b42378@freescale.com>
 <4eb991fafc171305ebc71847fecb7bdae0ede927.1376565456.git.b42378@freescale.com>
 <2188999.03O3zirCAO@flatron>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <2188999.03O3zirCAO@flatron>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, ian.campbell@citrix.com,
 pawel.moll@arm.com, swarren@wwwdotorg.org, festevam@gmail.com,
 s.hauer@pengutronix.de, timur@tabi.org, rob.herring@calxeda.com,
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

Hi Tomasz,
   
   Thank you for the comments. I'll revise them in v6.
   And below is my reply for you comments.

On Thu, Aug 15, 2013 at 02:18:22PM +0200, Tomasz Figa wrote:
> > +  - clock-names : Includes the following entries:
> > +	name		type		comments
> > +	"core"		Required	The core clock of spdif controller
> > +
> > +	"rx"		Optional	Rx clock source for spdif record.
> > +					If absent, will use core clock.
> > +
> > +	"tx"		Optional	Tx clock source for spdif playback.
> > +					If absent, will use core clock.
> > +
> > +	"tx-32000"	Optional	Tx clock source for 32000Hz sample rate
> > +					playback. If absent, will use tx clock.
> > +
> > +	"tx-44100"	Optional	Tx clock source for 44100Hz sample rate
> > +					playback. If absent, will use tx clock.
> > +
> > +	"tx-48000"	Optional	Tx clock source for 48000Hz sample rate
> > +					playback. If absent, will use tx clock.
> > +
> > +	"src<0-7>"	Optional	Clock source list for tx and rx clock
> > +					to look up their clock source indexes.
> > +					This clock list should be identical to
> > +					the list of TxClk_Source bit value of
> > +					register SPDIF_STC. If absent or failed
> > +					to look up, tx and rx clock would then
> > +					ignore the "rx", "tx" "tx-32000",
> > +					"tx-44100", "tx-48000" clock phandles
> > +					and select the core clock as default
> > +					tx and rx clock.
> 
> I suspect a little abuse of clocks property here. From the description of
> "core" and "src<0-7>" clocks I assume that the IP can have up to 9 clock
> inputs - core clock and up to 8 extra source clocks. Is it correct?
> 
> If yes, this makes the "tx", "rx" and "tx-*" clocks describe
> configuration, not hardware. IMHO it should be up to the driver which
> source clocks to use for tx and rx channels and for each sampling rate.

First, you are right that all the properties you just commented are
software configurations. And I got the point that device tree now
can't allow any software configuration even if the actual hardware
connection will depend on it.

If so, I would like to remove those abused clocks and also drop the 
unused clocks in src<0-7>, then just remain those needed clocks src.
I think that can be plausible because there'll be no more clock abuse
and the driver will be able to get the source index from the name 
'src<num>'.

And you are right about the 9 clock inputs, just there're not only 9
inputs but also an extra external clock from S/PDIF transmitter via
coaxial cable or optical fiber -- RxCLK. Please check the following
list:

0000 if (DPLL Locked) SPDIF_RxClk else extal
0001 if (DPLL Locked) SPDIF_RxClk else spdif_clk
0010 if (DPLL Locked) SPDIF_RxClk else asrc_clk
0011 if (DPLL Locked) SPDIF_RxClk else spdif_extclk
0100 if (DPLL Locked) SPDIF_Rxclk else esai_hckt
0101 extal_clk
0110 spdif_clk
0111 asrc_clk
1000 spdif_extclk
1001 esai_hckt
1010 if (DPLL Locked) SPDIF_RxClk else mlb_clk
1011 if (DPLL Locked) SPDIF_RxClk else mlb_phy_clk
1100 mkb_clk
1101 mlb_phy_clk

When (DPLL Locked) condition matches, the rx clock can ignore the 8 input
clocks from clock mux then use the external one from a S/PDIF transmitter.

So for the below part:

> > +Optional properties:
> > +
> > +  - rx-clksrc-lock: This is a boolean property. If present, ClkSrc_Sel
> > bit +  of SPDIF_SRPC would be set a clock source that cares DPLL locked
> > condition. +
> 
> This again looks like software configuration, not hardware description.
> Could you elaborate a bit more on meaning of this property?

I think the rx-clksrc-lock property should be included in DT as well, since
it's exactly a available clock source for rx. But I guess I just need to 
figure out a better way or a more elaborated description.

Thank you,
Nicolin Chen

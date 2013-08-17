Return-Path: <tomasz.figa@gmail.com>
Received: from mail-bk0-x22a.google.com (mail-bk0-x22a.google.com
 [IPv6:2a00:1450:4008:c01::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EFE652C0247
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Aug 2013 22:56:19 +1000 (EST)
Received: by mail-bk0-f42.google.com with SMTP id my10so972131bkb.29
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Aug 2013 05:56:16 -0700 (PDT)
From: Tomasz Figa <tomasz.figa@gmail.com>
To: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v5 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Sat, 17 Aug 2013 14:56:11 +0200
Message-ID: <2362958.X2QCBUPAyI@flatron>
In-Reply-To: <20130816044330.GD1846@MrMyself>
References: <cover.1376565456.git.b42378@freescale.com>
 <2188999.03O3zirCAO@flatron> <20130816044330.GD1846@MrMyself>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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

Hi Nicolin,

On Friday 16 of August 2013 12:43:31 Nicolin Chen wrote:
> Hi Tomasz,
> 
>    Thank you for the comments.

You're welcome.

>    I'll revise them in v6.
>    And below is my reply for you comments.

Thanks for your reply.

> On Thu, Aug 15, 2013 at 02:18:22PM +0200, Tomasz Figa wrote:
> > > +  - clock-names : Includes the following entries:
> > > +	name		type		comments
> > > +	"core"		Required	The core clock of spdif controller
> > > +
> > > +	"rx"		Optional	Rx clock source for spdif record.
> > > +					If absent, will use core clock.
> > > +
> > > +	"tx"		Optional	Tx clock source for spdif 
playback.
> > > +					If absent, will use core clock.
> > > +
> > > +	"tx-32000"	Optional	Tx clock source for 32000Hz sample 
rate
> > > +					playback. If absent, will use tx 
clock.
> > > +
> > > +	"tx-44100"	Optional	Tx clock source for 44100Hz sample 
rate
> > > +					playback. If absent, will use tx 
clock.
> > > +
> > > +	"tx-48000"	Optional	Tx clock source for 48000Hz sample 
rate
> > > +					playback. If absent, will use tx 
clock.
> > > +
> > > +	"src<0-7>"	Optional	Clock source list for tx and rx 
clock
> > > +					to look up their clock source 
indexes.
> > > +					This clock list should be 
identical to
> > > +					the list of TxClk_Source bit value 
of
> > > +					register SPDIF_STC. If absent or 
failed
> > > +					to look up, tx and rx clock would 
then
> > > +					ignore the "rx", "tx" "tx-32000",
> > > +					"tx-44100", "tx-48000" clock 
phandles
> > > +					and select the core clock as 
default
> > > +					tx and rx clock.
> > 
> > I suspect a little abuse of clocks property here. From the description
> > of "core" and "src<0-7>" clocks I assume that the IP can have up to 9
> > clock inputs - core clock and up to 8 extra source clocks. Is it
> > correct?
> > 
> > If yes, this makes the "tx", "rx" and "tx-*" clocks describe
> > configuration, not hardware. IMHO it should be up to the driver which
> > source clocks to use for tx and rx channels and for each sampling
> > rate.
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

OK.

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

Could you explain what the above values are? If they are values written to 
a 4-bit mux that selects RX clock source, then all the 16 clocks should be 
specified from device tree, even if they are duplicated.

Are the clock names you used above names of clock inputs of the S/PDIF 
block or names of SoC-wide clocks?

Can the assignment of clock inputs change? For example on one SoC

0000 if (DPLL Locked) SPDIF_RxClk else extal_clk
0001 if (DPLL Locked) SPDIF_RxClk else spdif_clk
...
0101 extal_clk
0110 spdif_clk
...

and on another

0000 if (DPLL Locked) SPDIF_RxClk else spdif_clk
0001 if (DPLL Locked) SPDIF_RxClk else extal_clk
...
0101 extal_clk
0110 spdif_clk
...

(notice the swapped 0000 and 0001 inputs)

Same goes for the TX mux. If it is a 3-bit, 8-input mux, then it should be 
described in device tree separately, as it is different than the 4-bit, 
16-input RX mux.

> When (DPLL Locked) condition matches, the rx clock can ignore the 8
> input clocks from clock mux then use the external one from a S/PDIF
> transmitter.

What happens if the "DPLL locked" condition doesn't match? When this can 
happen?

> So for the below part:
> > > +Optional properties:
> > > +
> > > +  - rx-clksrc-lock: This is a boolean property. If present,
> > > ClkSrc_Sel
> > > bit +  of SPDIF_SRPC would be set a clock source that cares DPLL
> > > locked
> > > condition. +
> > 
> > This again looks like software configuration, not hardware
> > description.
> > Could you elaborate a bit more on meaning of this property?
> 
> I think the rx-clksrc-lock property should be included in DT as well,
> since it's exactly a available clock source for rx. But I guess I just
> need to figure out a better way or a more elaborated description.

I still don't understand the meaning of this property. Could you explain 
it please?

Best regards,
Tomasz

Return-Path: <B42378@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0253.outbound.messaging.microsoft.com [213.199.154.253])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D4B432C0169
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 21:34:44 +1000 (EST)
Date: Mon, 19 Aug 2013 19:34:08 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v7 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Message-ID: <20130819113407.GA11489@MrMyself>
References: <cover.1376901081.git.b42378@freescale.com>
 <43416f3617951161b6e779277b4719438f844e49.1376901081.git.b42378@freescale.com>
 <20130819091809.GD3719@e106331-lin.cambridge.arm.com>
 <20130819093423.GB10950@MrMyself>
 <20130819095433.GG3719@e106331-lin.cambridge.arm.com>
 <20130819101303.GB11402@MrMyself>
 <20130819111349.GJ3719@e106331-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20130819111349.GJ3719@e106331-lin.cambridge.arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "timur@tabi.org" <timur@tabi.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "R65777@freescale.com" <R65777@freescale.com>,
 "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 19, 2013 at 12:13:49PM +0100, Mark Rutland wrote:
> > > > > > +       "rxtx<0-7>"     Clock source list for tx and rx clock.
> > > > > > +                       This clock list should be identical to
> > > > > > +                       the source list connecting to the spdif
> > > > > > +                       clock mux in "SPDIF Transceiver Clock
> > > > > > +                       Diagram" of SoC reference manual. It
> > > > > > +                       can also be referred to TxClk_Source
> > > > > > +                       bit of register SPDIF_STC.
> > Actually there's a clock mux for TxClk and it's connecting with 8 clock 
> > sources. So the TxClk_Source bit show the connection between its value
> > with the correspond source on the clock mux:
> > 
> > TxClk_Source	000 XTAL clk input
> > 		001 CCM spdif0_clk_root input
> > 		010 asrc_clk input
> > 		011 spdif_extclk input, from pads
> > 		100 esai_hckt input
> > 		101 frequency divided ipg_clk input
> > 		110 mlb_clk input
> > 		111 mlb phy clk input
> 
> Ah. So are these the actual input names on the mux, or the names of the
> outputs that are wired up to the mux? If the former, these may be better
> clock-names than rxtx<0-7>.

The clock names are actually different with different SoC. The list above
is only for i.MX6Q. So we can't specify these names here, because the driver
then would need to maintain a clock names list for different SoC as well.

> Is there a similar Rx mux?

Both Tx and RX clocks can be derived from the Tx mux.

> Given the "rxtx<0-7>" names you've given these clocks, are there 8 clock
> inputs that get duplicated within the spdif block and fed into both
> muxes, or are there 16 external inputs that happen to be two groups of 8
> identical sets of clocks in systems so far?

I think you can refer to the RM, since you just got it. The diagram doesn't
show which one you mentioned is true. But I think we can understand in both
ways. 

I'm going to send a v8. So I think I don't need to modify the description
right?

Thank you
Nicolin Chen

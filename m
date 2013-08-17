Return-Path: <tomasz.figa@gmail.com>
Received: from mail-bk0-x22d.google.com (mail-bk0-x22d.google.com
 [IPv6:2a00:1450:4008:c01::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8AD3D2C01C6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Aug 2013 01:38:21 +1000 (EST)
Received: by mail-bk0-f45.google.com with SMTP id mx11so949904bkb.18
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Aug 2013 08:38:17 -0700 (PDT)
From: Tomasz Figa <tomasz.figa@gmail.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v5 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Sat, 17 Aug 2013 17:38:13 +0200
Message-ID: <4160853.4nuiPWXiMi@flatron>
In-Reply-To: <20130817151409.GW26614@pengutronix.de>
References: <cover.1376565456.git.b42378@freescale.com>
 <2362958.X2QCBUPAyI@flatron> <20130817151409.GW26614@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, ian.campbell@citrix.com,
 pawel.moll@arm.com, swarren@wwwdotorg.org, festevam@gmail.com,
 Nicolin Chen <b42378@freescale.com>, timur@tabi.org, rob.herring@calxeda.com,
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

On Saturday 17 of August 2013 17:14:09 Sascha Hauer wrote:
> On Sat, Aug 17, 2013 at 02:56:11PM +0200, Tomasz Figa wrote:
> > Hi Nicolin,
> > 
> > > First, you are right that all the properties you just commented are
> > > software configurations. And I got the point that device tree now
> > > can't allow any software configuration even if the actual hardware
> > > connection will depend on it.
> > > 
> > > If so, I would like to remove those abused clocks and also drop the
> > > unused clocks in src<0-7>, then just remain those needed clocks src.
> > > I think that can be plausible because there'll be no more clock
> > > abuse
> > > and the driver will be able to get the source index from the name
> > > 'src<num>'.
> > 
> > OK.
> > 
> > > And you are right about the 9 clock inputs, just there're not only 9
> > > inputs but also an extra external clock from S/PDIF transmitter via
> > > coaxial cable or optical fiber -- RxCLK. Please check the following
> > > list:
> > > 
> > > 0000 if (DPLL Locked) SPDIF_RxClk else extal
> > > 0001 if (DPLL Locked) SPDIF_RxClk else spdif_clk
> > > 0010 if (DPLL Locked) SPDIF_RxClk else asrc_clk
> > > 0011 if (DPLL Locked) SPDIF_RxClk else spdif_extclk
> > > 0100 if (DPLL Locked) SPDIF_Rxclk else esai_hckt
> > > 0101 extal_clk
> > > 0110 spdif_clk
> > > 0111 asrc_clk
> > > 1000 spdif_extclk
> > > 1001 esai_hckt
> > > 1010 if (DPLL Locked) SPDIF_RxClk else mlb_clk
> > > 1011 if (DPLL Locked) SPDIF_RxClk else mlb_phy_clk
> > > 1100 mkb_clk
> > > 1101 mlb_phy_clk
> > 
> > Could you explain what the above values are? If they are values
> > written to a 4-bit mux that selects RX clock source, then all the 16
> > clocks should be specified from device tree, even if they are
> > duplicated.
> 
> The S/PDIF core can recover the clock for the tx signal from the rx
> signal. So if you have an S/PDIF input signal, then the DPLL will be
> locked and the SPDIF_RxClk can be used for tx. So the above are really 8
> clocks and one "If DPLL locked, use it" bit.

Yes, I'm aware of this and the solution you proposed is fully acceptable, 
but it complicates the driver a bit.

If you look at the mux inputs above, you can see that there is no single 
bit that specifies "if DPLL locked, use it" mode. Instead the conditional 
clock sources are mixed with fixed clock sources, without a linear 
translation to 0-7 range, which would have to be hardcoded in the driver.

I guess it's a matter of preference, but if the IP has a RX clock 
selection mux that has 16 inputs, the natural representation in device 
tree that comes to my mind is 16 clocks - one for each input of the mux. 
One might choose to abstract this as 8 clocks, though, since each clock is 
duplicated.

In this particular case, the driver would have to know which mux inputs 
can use DPLL anyway, so some hardcoding in the driver is still going to 
take place, so I guess both solutions are equally right.

Best regards,
Tomasz

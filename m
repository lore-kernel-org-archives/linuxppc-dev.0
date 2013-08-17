Return-Path: <sha@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 132F92C0225
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Aug 2013 01:14:23 +1000 (EST)
Date: Sat, 17 Aug 2013 17:14:09 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v5 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Message-ID: <20130817151409.GW26614@pengutronix.de>
References: <cover.1376565456.git.b42378@freescale.com>
 <2188999.03O3zirCAO@flatron> <20130816044330.GD1846@MrMyself>
 <2362958.X2QCBUPAyI@flatron>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2362958.X2QCBUPAyI@flatron>
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

On Sat, Aug 17, 2013 at 02:56:11PM +0200, Tomasz Figa wrote:
> Hi Nicolin,
> > First, you are right that all the properties you just commented are
> > software configurations. And I got the point that device tree now
> > can't allow any software configuration even if the actual hardware
> > connection will depend on it.
> > 
> > If so, I would like to remove those abused clocks and also drop the
> > unused clocks in src<0-7>, then just remain those needed clocks src.
> > I think that can be plausible because there'll be no more clock abuse
> > and the driver will be able to get the source index from the name
> > 'src<num>'.
> 
> OK.
> 
> > And you are right about the 9 clock inputs, just there're not only 9
> > inputs but also an extra external clock from S/PDIF transmitter via
> > coaxial cable or optical fiber -- RxCLK. Please check the following
> > list:
> > 
> > 0000 if (DPLL Locked) SPDIF_RxClk else extal
> > 0001 if (DPLL Locked) SPDIF_RxClk else spdif_clk
> > 0010 if (DPLL Locked) SPDIF_RxClk else asrc_clk
> > 0011 if (DPLL Locked) SPDIF_RxClk else spdif_extclk
> > 0100 if (DPLL Locked) SPDIF_Rxclk else esai_hckt
> > 0101 extal_clk
> > 0110 spdif_clk
> > 0111 asrc_clk
> > 1000 spdif_extclk
> > 1001 esai_hckt
> > 1010 if (DPLL Locked) SPDIF_RxClk else mlb_clk
> > 1011 if (DPLL Locked) SPDIF_RxClk else mlb_phy_clk
> > 1100 mkb_clk
> > 1101 mlb_phy_clk
> 
> Could you explain what the above values are? If they are values written to 
> a 4-bit mux that selects RX clock source, then all the 16 clocks should be 
> specified from device tree, even if they are duplicated.

The S/PDIF core can recover the clock for the tx signal from the rx
signal. So if you have an S/PDIF input signal, then the DPLL will be
locked and the SPDIF_RxClk can be used for tx. So the above are really 8
clocks and one "If DPLL locked, use it" bit.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

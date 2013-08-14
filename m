Return-Path: <B42378@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1B50B2C01BF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 20:39:49 +1000 (EST)
Date: Wed, 14 Aug 2013 18:23:46 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [alsa-devel] [PATCH v4 resent 1/2] ASoC: fsl: Add S/PDIF CPU DAI
 driver
Message-ID: <20130814102346.GK31651@MrMyself>
References: <cover.1376309076.git.b42378@freescale.com>
 <51808310dd97d2a35a28766ed7309f269521cafd.1376309076.git.b42378@freescale.com>
 <20130814075017.GE2324@pengutronix.de>
 <20130814084801.GH31651@MrMyself>
 <20130814095652.GX26614@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20130814095652.GX26614@pengutronix.de>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de,
 timur@tabi.org, rob.herring@calxeda.com, broonie@kernel.org,
 p.zabel@pengutronix.de, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Wed, Aug 14, 2013 at 11:56:52AM +0200, Sascha Hauer wrote:
> > I think I should first explain to you what this part is doing:
> > The driver needs to set Clk_source bit for TX/RX to select the 
> > clock from a clock mux. The names listed above are those of the 
> > clocks connecting to the mux, while they are not only internal 
> > clocks which're included in clk-imx6q.c but also external ones,
> > an on-board external osc for example.
> > 
> > The driver does get the clock by using the standard DT binding,
> > see the 'clocks = <&clks 197>' above, and then compare this
> > obtained clock->name with the name list to decide which value
> > should be set to the Clk_source bit.
> > 
> > ==================================================================
> > ClkSrc_Sel from i.MX6Q reference manual:
> > 
> > Clock source selection, all other settings not shown are reserved:
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
> > ==================================================================
> > 
> > So the name list here basically is not being used to obtain a
> > clock like what standardized DT binding does but to provide the
> > driver a full list to look up which value should be exactly used
> > according to the obtained clock.
> > 
> > I think I should revise the binding doc for these two lists. It 
> > might be hard to explain within that kinda short paragraph. 
> > 
> > Surely, if I misunderstand your point, please correct me. And
> > if you have any sage idea, please guide me.
> 
> Something like this:
> 
> clocks = <&clks 197>, <&clks 3>, <&clks 197>, <&clks 107>, <&clks SPDIF_EXT>,
>          <&clks 118>, <&clks 62>, <&clks 139>, <&clks MLB_PHY>
> clock-names = "core", "rxtx0", "rxtx1", "rxtx2", "rxtx3", "rxtx4", "rxtx5", "rxtx6", "rxtx7"
> 
> This describes the different input clocks to the spdif core and also
> gives a hint to the array index (rxtx_n_) to use.

Thank you for the idea, and..hmm..I'm a bit confused.. Is this really
a nicer way?

Actually the rx clock list and tx clock list are totally different.
So doing this I have to list, in the maximum case, 24 (8 + 16) clock
phandles for these two lists. And plussing another 6 I've listed in
this binding doc -- thus there are totally 30 clock phanldes. But
the 24 of 30 are only used to get two indexes.

I think I need a little help here to understand why this is better.
It looks more complicated to me.

Creating the two name lists just because I can describe them in the 
dtsi of SoC, since they are totally fixed and identical to the SoC
reference manual, while the clocks area can be remained for users
to select the actual clocks (core/rx/tx/tx-32000/tx-44100/tx-48000),
so they can configure these clocks in dts file of a specific board,
and they don't need to touch the name lists any more.

Thank you,
Nicolin Chen

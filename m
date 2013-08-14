Return-Path: <sha@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5C5862C00E9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 22:20:02 +1000 (EST)
Date: Wed, 14 Aug 2013 14:19:37 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Nicolin Chen <b42378@freescale.com>
Subject: Re: [alsa-devel] [PATCH v4 resent 1/2] ASoC: fsl: Add S/PDIF CPU
 DAI driver
Message-ID: <20130814121937.GY26614@pengutronix.de>
References: <cover.1376309076.git.b42378@freescale.com>
 <51808310dd97d2a35a28766ed7309f269521cafd.1376309076.git.b42378@freescale.com>
 <20130814075017.GE2324@pengutronix.de>
 <20130814084801.GH31651@MrMyself>
 <20130814095652.GX26614@pengutronix.de>
 <20130814102346.GK31651@MrMyself>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130814102346.GK31651@MrMyself>
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

On Wed, Aug 14, 2013 at 06:23:46PM +0800, Nicolin Chen wrote:
> Hi,
> 
> > > Surely, if I misunderstand your point, please correct me. And
> > > if you have any sage idea, please guide me.
> > 
> > Something like this:
> > 
> > clocks = <&clks 197>, <&clks 3>, <&clks 197>, <&clks 107>, <&clks SPDIF_EXT>,
> >          <&clks 118>, <&clks 62>, <&clks 139>, <&clks MLB_PHY>
> > clock-names = "core", "rxtx0", "rxtx1", "rxtx2", "rxtx3", "rxtx4", "rxtx5", "rxtx6", "rxtx7"
> > 
> > This describes the different input clocks to the spdif core and also
> > gives a hint to the array index (rxtx_n_) to use.
> 
> Thank you for the idea, and..hmm..I'm a bit confused.. Is this really
> a nicer way?

Yes, since the clk names are not an API. Exposing them to the devicetree
is not an option. The fact that the names are defined in
arch/arm/mach-imx/clk-imx6q.c and are used in the spdif driver makes
this really clear.

> 
> Actually the rx clock list and tx clock list are totally different.
> So doing this I have to list, in the maximum case, 24 (8 + 16) clock
> phandles for these two lists. And plussing another 6 I've listed in
> this binding doc -- thus there are totally 30 clock phanldes. But
> the 24 of 30 are only used to get two indexes.

The spdif core has 8 input clocks which have to be described in the
devicetree. Nobody says the mapping which clock name corresponds to
which bit combination has to be in the devicetree.

Look at the possible clocks:

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

Only half of them actually are clocks. "if (DPLL Locked) SPDIF_RxClk
else ..." is not a clock. Every sane hardware developer would have
introduced a mux with 8 entries and an additional "Use DPLL if possible"
bit. Now this is not the case here so we have to live with it and
maintain the above table in the driver. And another one for the i.MX35
and still another one for i.MX53.

> 
> I think I need a little help here to understand why this is better.

As said, the clock names are not an API. Nobody changing clk-imx6q.c
expects to break devicetree bindings.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

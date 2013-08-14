Return-Path: <p.zabel@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 12CEA2C0152
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 22:07:26 +1000 (EST)
Message-ID: <1376481984.3994.20.camel@pizza.hi.pengutronix.de>
Subject: Re: [PATCH v4 resent 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Nicolin Chen <b42378@freescale.com>
Date: Wed, 14 Aug 2013 14:06:24 +0200
In-Reply-To: <20130814084801.GH31651@MrMyself>
References: <cover.1376309076.git.b42378@freescale.com>
 <51808310dd97d2a35a28766ed7309f269521cafd.1376309076.git.b42378@freescale.com>
 <20130814075017.GE2324@pengutronix.de> <20130814084801.GH31651@MrMyself>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de,
 Sascha Hauer <s.hauer@pengutronix.de>, timur@tabi.org, rob.herring@calxeda.com,
 broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Mittwoch, den 14.08.2013, 16:48 +0800 schrieb Nicolin Chen:
> Hi Sascha,
> 
> On Wed, Aug 14, 2013 at 09:50:17AM +0200, Sascha Hauer wrote:
> > > +  - tx-clksrc-names : The names for all available clock sources for tx, which
> > > +  is also being listed in SoC reference manual, ClkSrc_Sel bit of SPDIF_SRPC.
> > > +  And the name list would be different between different SoC. Use 'null' for
> > > +  those unlisted names, and the max number of tx-clksrc-names should be 8.
> > > +
> > > +  - rx-clksrc-names : The names for all available clock sources for rx, which
> > > +  is also being listed in SoC reference manual, TxClk_Source bit of SPDIF_STC.
> > > +  And the name list would be different between different SoC. Use 'null' for
> > > +  those unlisted names, and the max number of rx-clksrc-names should be 16.
> > > +
> > > +Optional properties:
> > > +
> > > +  - rx-clksrc-lock: This is a boolean property. If present, ClkSrc_Sel bit
> > > +  of SPDIF_SRPC would be set a clock source that cares DPLL locked condition.
> > > +
> > > +Example1:
> > > +
> > > +spdif: spdif@02004000 {
> > > +	clocks = <&clks 197>;
> > > +	clock-names = "core";
> > > +	rx-clksrc-lock;
> > > +	rx-clksrc-names =
> > > +		"lock.ext", "lock.spdif", "lock.asrc",
> > > +		"lock.spdif_ext", "lock.esai", "ext",
> > > +		"spdif", "asrc", "spdif_ext", "esai",
> > > +		"lock.mlb", "lock.mlb_phy", "mlb",
> > > +		"mlb_phy";
> > > +	tx-clksrc-names =
> > > +		"xtal", "spdif", "asrc", "spdif_ext",
> > > +		"esai", "ipg", "mlb", "mlb_phy";
> > 
> > I had a hard time understanding what you are doing here.
> > 
> > With this the clk names in arch/arm/mach-imx/clk-imx6q.c become an API
> > between the Kernel and the devicetree. Don't do that.
> > 
> > There is a standardized devicetree binding for clocks. Use it.
>  
> I think I should first explain to you what this part is doing:
> The driver needs to set Clk_source bit for TX/RX to select the 
> clock from a clock mux. The names listed above are those of the 
> clocks connecting to the mux, while they are not only internal 
> clocks which're included in clk-imx6q.c but also external ones,
> an on-board external osc for example.
> 
> The driver does get the clock by using the standard DT binding,
> see the 'clocks = <&clks 197>' above, and then compare this
> obtained clock->name with the name list to decide which value
> should be set to the Clk_source bit.
> 
> ==================================================================
> ClkSrc_Sel from i.MX6Q reference manual:
> 
> Clock source selection, all other settings not shown are reserved:
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
> ==================================================================

==================================================================
>From i.MX53 reference manual:

0000 if (DPLL Locked) SPDIF_RxClk else extal
0001 if (DPLL Locked) SPDIF_RxClk else spdif_clk
0011 if (DPLL Locked) SPDIF_RxClk else asrc_clk
0100 if (DPLL Locked) SPDIF_Rxclk else esai_hckt
0101 extal_clk
0110 spdif_clk
1000 asrc_clk
1001 esai_hckt
1010 if (DPLL Locked) SPDIF_RxClk else mlb_clk
1011 if (DPLL Locked) SPDIF_RxClk else camp_clk
1100 mkb_clk
1101 camp_clk
==================================================================

To me this looks like the device tree should just contain the list of
unique clock inputs using phandles.
	/* for i.MX6Q: */
	clocks = <&...>;
	clock-names = "xtal", "spdif", "asrc",
	              "spdif_ext", "esai", "mlb";

	/* for i.MX53: */
	clocks = <&...>;
	clock-names = "xtal", "spdif", "asrc",
	              "esai", "mlb", "camp";

The driver could contain this list of named inputs to the multiplexer
and the DPLL locking information for each SoC version. The per-clock
DPLL locking bit shouldn't be in the device tree at all.

> So the name list here basically is not being used to obtain a
> clock like what standardized DT binding does but to provide the
> driver a full list to look up which value should be exactly used
> according to the obtained clock.
> 
> I think I should revise the binding doc for these two lists. It 
> might be hard to explain within that kinda short paragraph. 
> 
> Surely, if I misunderstand your point, please correct me. And
> if you have any sage idea, please guide me.

regards
Philipp

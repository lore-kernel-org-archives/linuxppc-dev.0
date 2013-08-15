Return-Path: <B42378@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2895D2C0213
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 12:38:12 +1000 (EST)
Date: Thu, 15 Aug 2013 10:28:14 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v4 resent 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Message-ID: <20130815022814.GB1846@MrMyself>
References: <cover.1376309076.git.b42378@freescale.com>
 <51808310dd97d2a35a28766ed7309f269521cafd.1376309076.git.b42378@freescale.com>
 <20130814075017.GE2324@pengutronix.de>
 <20130814084801.GH31651@MrMyself>
 <1376481984.3994.20.camel@pizza.hi.pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1376481984.3994.20.camel@pizza.hi.pengutronix.de>
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

Hi Philipp,

   Thank again for the comments.

On Wed, Aug 14, 2013 at 02:06:24PM +0200, Philipp Zabel wrote:
> ==================================================================
> From i.MX53 reference manual:
> 
> 0000 if (DPLL Locked) SPDIF_RxClk else extal
> 0001 if (DPLL Locked) SPDIF_RxClk else spdif_clk
> 0011 if (DPLL Locked) SPDIF_RxClk else asrc_clk
> 0100 if (DPLL Locked) SPDIF_Rxclk else esai_hckt
> 0101 extal_clk
> 0110 spdif_clk
> 1000 asrc_clk
> 1001 esai_hckt
> 1010 if (DPLL Locked) SPDIF_RxClk else mlb_clk
> 1011 if (DPLL Locked) SPDIF_RxClk else camp_clk
> 1100 mkb_clk
> 1101 camp_clk
> ==================================================================
> 
> To me this looks like the device tree should just contain the list of
> unique clock inputs using phandles.
> 	/* for i.MX6Q: */
> 	clocks = <&...>;
> 	clock-names = "xtal", "spdif", "asrc",
> 	              "spdif_ext", "esai", "mlb";
> 
> 	/* for i.MX53: */
> 	clocks = <&...>;
> 	clock-names = "xtal", "spdif", "asrc",
> 	              "esai", "mlb", "camp";
> 
> The driver could contain this list of named inputs to the multiplexer
> and the DPLL locking information for each SoC version. The per-clock
> DPLL locking bit shouldn't be in the device tree at all.

I understand your point. I'll put the DPLL-locking info to the driver.
And I just found that the DPLL-lock condition seems to be fixed within
the range -- {0x0 ~ 0x4, 0xa ~ 0xb} (I checked i.MX6Q/6SL/53/35, all
of them are in such pattern.) So I don't need to put them into DT.

I'll revise it in next ver.

Thank you,
Nicolin Chen

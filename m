Return-Path: <B42378@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2A8272C0104
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 12:43:23 +1000 (EST)
Date: Thu, 15 Aug 2013 10:33:32 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [alsa-devel] [PATCH v4 resent 1/2] ASoC: fsl: Add S/PDIF CPU DAI
 driver
Message-ID: <20130815023331.GC1846@MrMyself>
References: <cover.1376309076.git.b42378@freescale.com>
 <51808310dd97d2a35a28766ed7309f269521cafd.1376309076.git.b42378@freescale.com>
 <20130814075017.GE2324@pengutronix.de>
 <20130814084801.GH31651@MrMyself>
 <20130814095652.GX26614@pengutronix.de>
 <20130814102346.GK31651@MrMyself>
 <20130814121937.GY26614@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20130814121937.GY26614@pengutronix.de>
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

On Wed, Aug 14, 2013 at 02:19:37PM +0200, Sascha Hauer wrote:
> Yes, since the clk names are not an API. Exposing them to the devicetree
> is not an option. The fact that the names are defined in
> arch/arm/mach-imx/clk-imx6q.c and are used in the spdif driver makes
> this really clear.
> 
> The spdif core has 8 input clocks which have to be described in the
> devicetree. Nobody says the mapping which clock name corresponds to
> which bit combination has to be in the devicetree.

Thank you for the explain. I get your point and really appreciate it.

> Look at the possible clocks:
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
> 
> Only half of them actually are clocks. "if (DPLL Locked) SPDIF_RxClk
> else ..." is not a clock. Every sane hardware developer would have
> introduced a mux with 8 entries and an additional "Use DPLL if possible"
> bit. Now this is not the case here so we have to live with it and
> maintain the above table in the driver. And another one for the i.MX35
> and still another one for i.MX53.

I think I just have an idea for the table. I'll put them into the
next version. Please take a look after I send it.

Thank you,
Nicolin Chen
 

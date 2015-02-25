Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0101.outbound.protection.outlook.com [157.56.110.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 65F0B1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 10:44:25 +1100 (AEDT)
Message-ID: <1424907851.4698.63.camel@freescale.com>
Subject: Re: [PATCH] clk: ppc-corenet: Add support for the FMD clock
From: Scott Wood <scottwood@freescale.com>
To: Igal.Liberman <igal.liberman@freescale.com>
Date: Wed, 25 Feb 2015 17:44:11 -0600
In-Reply-To: <1421755411-26357-1-git-send-email-igal.liberman@freescale.com>
References: <1421755411-26357-1-git-send-email-igal.liberman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Emilian.Medve@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-01-20 at 14:03 +0200, Igal.Liberman wrote:
> +static u8 get_fm_clk_parent(struct clk_hw *hw)
> +{
> +	struct ccsr_guts __iomem *guts_regs = NULL;
> +	struct device_node *guts;
> +	uint32_t reg = 0;
> +	int clk_src = 0;
> +	int fm_clk_select = -EINVAL;
> +	int fm_id = 0;
> +
> +	guts = of_find_matching_node(NULL, guts_device_ids);
> +	if (!guts) {
> +		pr_err("could not find GUTS node\n");
> +		return -EINVAL;
> +	}

Error message lacks context (here and elsewhere).

Why are you going this on demand rather than in an init function
(specifically, a CLK_OF_DECLARE)?  You should not register this clock
handler in the first place if the hardware doesn't exist.

-EINVAL doesn't fit in u8.  Neither would the more appropriate -ENODEV.

> +	guts_regs = of_iomap(guts, 0);
> +	of_node_put(guts);
> +	if (!guts_regs) {
> +		pr_err("ioremap of GUTS node failed\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!strcmp(__clk_get_name(hw->clk), "fm1-clk"))
> +		fm_id = 1;
> +
> +	/* The FM clock provider is SoC dependent and it's determened by the

determined

> +	 * reset configuration word (RCW). We need to map the RCW options to
> +	 * the order of the providers in the device tree.
> +	 * This code makes assumptions about the clock provider order:
> +	 * In the PXXXX family:
> +	 *	0 - platform clock/2
> +	 *	1 - PLLx /2
> +	 *	2 - PLLx /4 (if possible).
> +	 * In B/T family:
> +	 *	The same order in which the clock providers are described in
> +	 *	the Reference Manual, starting from 0.

This belongs in a device tree binding document and should not
incorporate portions of the reference manual by reference -- what if a
new version of the reference manual changes the order in which clock
providers are described?  Or do you mean that the order corresponds to a
register value?


> +	 *
> +	 * In a case of only one possible provider, the index is 0.
> +	 */
> +
> +	if (of_device_is_compatible(guts, "fsl,p1023-guts") ||
> +		of_device_is_compatible(guts, "fsl,t1040-device-config"))
> +		/* P1023 and T1040 have only one optional clock source */
> +		fm_clk_select = 0;
> +	else if (of_device_is_compatible(guts, "fsl,p2041-device-config") ||
> +		 of_device_is_compatible(guts, "fsl,p3041-device-config") ||
> +		 of_device_is_compatible(guts, "fsl,p4080-device-config")) {
> +		/* Read RCW*/

/* Read RCW */

> @@ -352,3 +601,4 @@ CLK_OF_DECLARE(qoriq_core_mux_1, "fsl,qoriq-core-mux-1.0", core_mux_init);
>  CLK_OF_DECLARE(qoriq_core_mux_2, "fsl,qoriq-core-mux-2.0", core_mux_init);
>  CLK_OF_DECLARE(qoriq_pltfrm_pll_1, "fsl,qoriq-platform-pll-1.0", pltfrm_pll_init);
>  CLK_OF_DECLARE(qoriq_pltfrm_pll_2, "fsl,qoriq-platform-pll-2.0", pltfrm_pll_init);
> +CLK_OF_DECLARE(qoriq_fm_mux, "fsl,fman-clk-mux", fm_mux_init);

Where is the binding for this node?

-Scott

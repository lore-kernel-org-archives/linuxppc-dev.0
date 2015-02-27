Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6DD821A006F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2015 04:02:05 +1100 (AEDT)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] clk: ppc-corenet: Add support for the FMD clock
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1421755411-26357-1-git-send-email-igal.liberman@freescale.com>
Date: Fri, 27 Feb 2015 10:02:00 -0600
Message-Id: <0E6E0DAF-6DDC-4E36-BAFE-392F1BB091FC@kernel.crashing.org>
References: <1421755411-26357-1-git-send-email-igal.liberman@freescale.com>
To: "Igal.Liberman" <igal.liberman@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Emilian.Medve@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 20, 2015, at 6:03 AM, Igal.Liberman <igal.liberman@freescale.com> =
wrote:

> From: Igal Liberman <Igal.Liberman@freescale.com>

Really should have some commit text

>=20
> Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
>=20
> This patch is based on https://patchwork.ozlabs.org/patch/430966/

This belongs below the ---

> ---
> drivers/clk/clk-ppc-corenet.c |  250 =
+++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 250 insertions(+)

Any reason clk maintainers aren=92t CC=92d?

> diff --git a/drivers/clk/clk-ppc-corenet.c =
b/drivers/clk/clk-ppc-corenet.c
> index ff425e1..dcde0e6 100644
> --- a/drivers/clk/clk-ppc-corenet.c
> +++ b/drivers/clk/clk-ppc-corenet.c
> @@ -18,6 +18,7 @@
> #include <linux/of_platform.h>
> #include <linux/of.h>
> #include <linux/slab.h>
> +#include <asm/fsl_guts.h>
>=20
> struct cmux_clk {
> 	struct clk_hw hw;
> @@ -144,6 +145,254 @@ err_name:
> 	kfree(parent_names);
> }
>=20
> +/* Table for matching compatible strings, for device tree
> + * guts node, for QorIQ SOCs.
> + * "fsl,qoriq-device-config-2.0" corresponds to T4 & B4
> + * SOCs. For the older SOCs "fsl,qoriq-device-config-1.0"
> + * string would be used.
> + */
> +
> +static const struct of_device_id guts_device_ids[] =3D {
> +	{ .compatible =3D "fsl,qoriq-device-config-1.0", },
> +	{ .compatible =3D "fsl,qoriq-device-config-2.0", },
> +};
> +
> +/* P2, P3, P4, P5 */
> +#define FM1_CLK_SEL_SHIFT		30
> +#define FM1_CLK_SEL			BIT(FM1_CLK_SEL_SHIFT)
> +#define FM2_CLK_SEL_SHIFT		29
> +#define FM2_CLK_SEL			BIT(FM2_CLK_SEL_SHIFT)
> +#define HWA_ASYNC_DIV_SHIFT		26
> +#define HWA_ASYNC_DIV			BIT(HWA_ASYNC_DIV_SHIFT)
> +
> +/* B4, T2 */
> +#define HWA_CGA_M1_CLK_SEL_SHIFT	29
> +#define HWA_CGA_M1_CLK_SEL		(BIT(HWA_CGA_M1_CLK_SEL_SHIFT + =
2) |\
> +					 BIT(HWA_CGA_M1_CLK_SEL_SHIFT + =
1) |\
> +					 BIT(HWA_CGA_M1_CLK_SEL_SHIFT))
> +
> +/* T4240 */
> +#define HWA_CGB_M1_CLK_SEL_SHIFT	26
> +#define HWA_CGB_M1_CLK_SEL		(BIT(HWA_CGB_M1_CLK_SEL_SHIFT + =
2) |\
> +					 BIT(HWA_CGB_M1_CLK_SEL_SHIFT + =
1) |\
> +					 BIT(HWA_CGB_M1_CLK_SEL_SHIFT))
> +#define HWA_CGB_M2_CLK_SEL_SHIFT	3
> +#define HWA_CGB_M2_CLK_SEL		(BIT(HWA_CGB_M2_CLK_SEL_SHIFT + =
2) |\
> +					 BIT(HWA_CGB_M2_CLK_SEL_SHIFT + =
1) |\
> +					 BIT(HWA_CGB_M2_CLK_SEL_SHIFT))
> +
> +static u8 get_fm_clk_parent(struct clk_hw *hw)
> +{
> +	struct ccsr_guts __iomem *guts_regs =3D NULL;
> +	struct device_node *guts;
> +	uint32_t reg =3D 0;
> +	int clk_src =3D 0;
> +	int fm_clk_select =3D -EINVAL;
> +	int fm_id =3D 0;
> +
> +	guts =3D of_find_matching_node(NULL, guts_device_ids);
> +	if (!guts) {
> +		pr_err("could not find GUTS node\n");
> +		return -EINVAL;
> +	}
> +
> +	guts_regs =3D of_iomap(guts, 0);
> +	of_node_put(guts);
> +	if (!guts_regs) {
> +		pr_err("ioremap of GUTS node failed\n");
> +		return -EINVAL;
> +	}

Have you guys looked at using drivers/mfd/syscon.c for GUTS access.

> +
> +	if (!strcmp(__clk_get_name(hw->clk), "fm1-clk"))
> +		fm_id =3D 1;
> +
> +	/* The FM clock provider is SoC dependent and it's determened by =
the
> +	 * reset configuration word (RCW). We need to map the RCW =
options to
> +	 * the order of the providers in the device tree.
> +	 * This code makes assumptions about the clock provider order:
> +	 * In the PXXXX family:
> +	 *	0 - platform clock/2
> +	 *	1 - PLLx /2
> +	 *	2 - PLLx /4 (if possible).
> +	 * In B/T family:
> +	 *	The same order in which the clock providers are =
described in
> +	 *	the Reference Manual, starting from 0.
> +	 *
> +	 * In a case of only one possible provider, the index is 0.
> +	 */

Does it make sense to do all this parsing every time get_fm_clk_parent, =
why not do it during the init function once?

> +
> +	if (of_device_is_compatible(guts, "fsl,p1023-guts") ||
> +		of_device_is_compatible(guts, =
"fsl,t1040-device-config"))
> +		/* P1023 and T1040 have only one optional clock source =
*/
> +		fm_clk_select =3D 0;
> +	else if (of_device_is_compatible(guts, =
"fsl,p2041-device-config") ||
> +		 of_device_is_compatible(guts, =
"fsl,p3041-device-config") ||
> +		 of_device_is_compatible(guts, =
"fsl,p4080-device-config")) {
> +		/* Read RCW*/
> +		reg =3D in_be32(&guts_regs->rcwsr[7]);
> +
> +		/* Check bit 225 or bit 226 (FM2, P4080)
> +		 * 0 - The clock source is Platform PLL /2
> +		 * 1 - The clock source is PLL2 /2 (P2, P3) or PLL3 /2 =
(P4)
> +		 *
> +		 * Bit 225 represents FM1, Bit 226 represents FM2
> +		 */
> +		if (fm_id =3D=3D 0)
> +			fm_clk_select =3D (reg & FM1_CLK_SEL) >>
> +							=
FM1_CLK_SEL_SHIFT;
> +		else
> +			fm_clk_select =3D (reg & FM2_CLK_SEL) >>
> +							=
FM2_CLK_SEL_SHIFT;
> +	} else if (of_device_is_compatible(guts, =
"fsl,p5020-device-config") ||
> +		   of_device_is_compatible(guts, =
"fsl,p5040-device-config")) {
> +		/* Read RCW */
> +		reg =3D in_be32(&guts_regs->rcwsr[7]);
> +
> +		/* Check bit 225 or bit 226 (FM2, P5040)
> +		 * 0 - The clock source is Platform PLL /2
> +		 * 1 - If bit 225/226 is 1, we need to read bit 229.
> +		 *
> +		 * If bit 229 equals to:
> +		 * 0 -The clock source is PLL2 /2 (P5020) or PLL3 /2 =
(P040)
> +		 * 1 -The clock source is PLL2 /4 (P5020) or PLL3 /4 =
(P040)
> +		 *
> +		 * Bit 225 represents FM1, Bit 226 represents FM2
> +		 * Bit 229 represents both FMs
> +		 */
> +		if (fm_id =3D=3D 0)
> +			clk_src =3D (reg & FM1_CLK_SEL) >> =
FM1_CLK_SEL_SHIFT;
> +		else
> +			clk_src =3D (reg & FM2_CLK_SEL) >> =
FM2_CLK_SEL_SHIFT;
> +
> +		if (clk_src =3D=3D 0)
> +			fm_clk_select =3D 0;
> +		else {
> +			clk_src =3D (reg & HWA_ASYNC_DIV) >> =
HWA_ASYNC_DIV_SHIFT;
> +			fm_clk_select =3D clk_src + 1;
> +		}
> +	} else if (of_device_is_compatible(guts, "fsl,b4-device-config") =
||
> +		of_device_is_compatible(guts, =
"fsl,t2080-device-config")) {
> +		/* Read RCW */
> +		reg =3D in_be32(&guts_regs->rcwsr[7]);
> +
> +		/* Check bits 224-226
> +		 * 001 - PLL1
> +		 * 010 - PLL1 /2
> +		 * 011 - PLL1 /3
> +		 * 100 - PLL1 /4
> +		 * 101 - Platform PLL1
> +		 * 110 - PLL2 /2
> +		 * 111 - PLL2 /3
> +		 */
> +		clk_src =3D (reg & HWA_CGA_M1_CLK_SEL) >>
> +						=
HWA_CGA_M1_CLK_SEL_SHIFT;
> +		fm_clk_select =3D clk_src - 1;
> +	} else if (of_device_is_compatible(guts, =
"fsl,t4240-device-config")) {
> +		if (fm_id =3D=3D 0) {
> +			/* Check bits 227-229
> +			 * 010 - PLL 1 /2
> +			 * 011 - PLL 1 /3
> +			 * 100 - PLL 1 /4
> +			 * 101 - Platform PLL
> +			 * 110 - PLL 2 /2
> +			 */
> +			reg =3D in_be32(&guts_regs->rcwsr[7]);
> +			clk_src =3D (reg & HWA_CGB_M1_CLK_SEL) >>
> +						=
HWA_CGB_M1_CLK_SEL_SHIFT;
> +		} else {
> +			/* Check bits 506-508
> +			 * 010 - PLL 2 /2
> +			 * 011 - PLL 2 /3
> +			 * 100 - PLL 2 /4
> +			 * 101 - Platform PLL
> +			 * 110 - PLL 1 /2
> +			 * 111 - PLL 1 /3
> +			 */
> +			reg =3D in_be32(&guts_regs->rcwsr[15]);
> +			clk_src =3D (reg & HWA_CGB_M2_CLK_SEL) >>
> +						=
HWA_CGB_M2_CLK_SEL_SHIFT;
> +		}
> +		fm_clk_select =3D clk_src - 2;
> +	} else
> +		pr_err("Unsupported device! Can't determine FM clk =
source!\n");
> +
> +	iounmap(guts_regs);
> +
> +	return fm_clk_select;
> +}
> +
> +const struct clk_ops fm_clk_ops =3D {
> +	.get_parent =3D get_fm_clk_parent,
> +};
> +
> +static void __init fm_mux_init(struct device_node *np)
> +{
> +	struct clk_init_data *init;
> +	struct clk_hw *hw;
> +	int count, i, ret;
> +	struct clk *clk;
> +
> +	init =3D kmalloc((sizeof(struct clk_init_data)), GFP_KERNEL);
> +	if (!init)
> +		return;
> +
> +	/* get the input clock source count */
> +	count =3D of_property_count_strings(np, "clock-names");
> +	if (count < 0) {
> +		pr_err("%s: get clock count error\n", np->name);
> +		goto err_init;
> +	}
> +
> +	init->parent_names =3D kmalloc((sizeof(char *) * count), =
GFP_KERNEL);
> +	if (!init->parent_names)
> +		goto err_init;
> +
> +	for (i =3D 0; i < count; i++)
> +		init->parent_names[i] =3D of_clk_get_parent_name(np, i);
> +
> +	hw =3D kzalloc(sizeof(*hw), GFP_KERNEL);
> +	if (!hw)
> +		goto err_name;
> +
> +	ret =3D of_property_read_string_index(np,
> +				    "clock-output-names", 0, =
&init->name);
> +	if (ret) {
> +		pr_err("%s: read clock names error\n", np->name);
> +		goto err_clk_hw;
> +	}
> +
> +	init->ops =3D &fm_clk_ops;
> +	init->num_parents =3D count;
> +	init->flags =3D 0;
> +	hw->init =3D init;
> +
> +	clk =3D clk_register(NULL, hw);
> +	if (IS_ERR(clk)) {
> +		pr_err("%s: could not register clock\n", init->name);
> +		goto err_clk_hw;
> +	}
> +
> +	ret =3D of_clk_add_provider(np, of_clk_src_simple_get, clk);
> +	if (ret) {
> +		pr_err("Could not register clock provider for node: =
%s\n",
> +		       np->name);
> +		clk_unregister(clk);
> +		goto err_clk_hw;
> +	}
> +
> +	/* Free parent_names because they are reallocated when =
registered */
> +	kfree(init->parent_names);
> +
> +	return;
> +
> +err_clk_hw:
> +	kfree(hw);
> +err_name:
> +	kfree(init->parent_names);
> +err_init:
> +	kfree(init);
> +}
> +
> static void __init core_pll_init(struct device_node *np)
> {
> 	u32 mult;
> @@ -352,3 +601,4 @@ CLK_OF_DECLARE(qoriq_core_mux_1, =
"fsl,qoriq-core-mux-1.0", core_mux_init);
> CLK_OF_DECLARE(qoriq_core_mux_2, "fsl,qoriq-core-mux-2.0", =
core_mux_init);
> CLK_OF_DECLARE(qoriq_pltfrm_pll_1, "fsl,qoriq-platform-pll-1.0", =
pltfrm_pll_init);
> CLK_OF_DECLARE(qoriq_pltfrm_pll_2, "fsl,qoriq-platform-pll-2.0", =
pltfrm_pll_init);
> +CLK_OF_DECLARE(qoriq_fm_mux, "fsl,fman-clk-mux", fm_mux_init);
> --=20
> 1.7.9.5
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

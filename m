Return-Path: <Yuantian.Tang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0142.outbound.protection.outlook.com [157.56.111.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C331F1A0BE9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 14:00:09 +1100 (AEDT)
From: Yuantian Tang <Yuantian.Tang@freescale.com>
To: Emilian Medve <Emilian.Medve@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Scott Wood
 <scottwood@freescale.com>, "mturquette@linaro.org" <mturquette@linaro.org>,
 "haokexin@gmail.com" <haokexin@gmail.com>
Subject: RE: [PATCH v2 09/10] clk: qoriq: Add support for the platform PLL
Date: Thu, 29 Jan 2015 02:26:17 +0000
Message-ID: <DM2PR03MB5740F9736F2A3CAB6EFB509FA300@DM2PR03MB574.namprd03.prod.outlook.com>
References: <1421834611-9656-1-git-send-email-Emilian.Medve@Freescale.com>
 <1421834611-9656-10-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1421834611-9656-10-git-send-email-Emilian.Medve@Freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Emilian Medve <Emilian.Medve@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Emil Medve [mailto:Emilian.Medve@Freescale.com]
> Sent: Wednesday, January 21, 2015 6:04 PM
> To: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421;
> mturquette@linaro.org; haokexin@gmail.com; Tang Yuantian-B29983
> Cc: Medve Emilian-EMMEDVE1
> Subject: [PATCH v2 09/10] clk: qoriq: Add support for the platform PLL
>=20
> Change-Id: Iac11ed95f274485a86d2c11f32a3dc502bcd020f
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> ---
>  drivers/clk/clk-qoriq.c | 83
> +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>=20
> diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c index
> 07bdfc5..cda90a9 100644
> --- a/drivers/clk/clk-qoriq.c
> +++ b/drivers/clk/clk-qoriq.c
> @@ -271,9 +271,92 @@ static void __init sysclk_init(struct device_node
> *node)
>  	if (!IS_ERR(clk))
>  		of_clk_add_provider(np, of_clk_src_simple_get, clk);  }
> +
> +static void __init pltfrm_pll_init(struct device_node *np) {
> +	void __iomem *base;
> +	uint32_t mult;
> +	const char *parent_name, *clk_name;
> +	int i, _errno;
> +	struct clk_onecell_data *cod;
> +
> +	base =3D of_iomap(np, 0);
> +	if (!base) {
> +		pr_err("%s(): %s: of_iomap() failed\n", __func__, np->name);
> +		return;
> +	}
> +
> +	/* Get the multiple of PLL */
> +	mult =3D ioread32be(base);
> +
> +	iounmap(base);
> +
> +	/* Check if this PLL is disabled */
> +	if (mult & PLL_KILL) {
> +		pr_debug("%s(): %s: Disabled\n", __func__, np->name);
> +		return;
> +	}
> +	mult =3D (mult & GENMASK(6, 1)) >> 1;
> +
> +	parent_name =3D of_clk_get_parent_name(np, 0);
> +	if (!parent_name) {
> +		pr_err("%s(): %s: of_clk_get_parent_name() failed\n",
> +		       __func__, np->name);
> +		return;
> +	}
> +
> +	i =3D of_property_count_strings(np, "clock-output-names");
> +	if (i < 0) {
> +		pr_err("%s(): %s: of_property_count_strings(clock-output-
> names) =3D %d\n",
> +		       __func__, np->name, i);
> +		return;
> +	}
> +
> +	cod =3D kmalloc(sizeof(*cod) + i * sizeof(struct clk *), GFP_KERNEL);
> +	if (!cod)
> +		return;
> +	cod->clks =3D (struct clk **)(cod + 1);
> +	cod->clk_num =3D i;
> +
> +	for (i =3D 0; i < cod->clk_num; i++) {
> +		_errno =3D of_property_read_string_index(np, "clock-output-
> names",
> +						       i, &clk_name);
> +		if (_errno < 0) {
> +			pr_err("%s(): %s: of_property_read_string_index(clock-
> output-names) =3D %d\n",
> +			       __func__, np->name, _errno);
> +			goto return_clk_unregister;
> +		}
> +
> +		cod->clks[i] =3D clk_register_fixed_factor(NULL, clk_name,
> +					       parent_name, 0, mult, 1 + i);
> +		if (IS_ERR(cod->clks[i])) {
> +			pr_err("%s(): %s: clk_register_fixed_factor(%s) =3D
> %ld\n",
> +			       __func__, np->name,
> +			       clk_name, PTR_ERR(cod->clks[i]));
> +			goto return_clk_unregister;
> +		}
> +	}
> +
> +	_errno =3D of_clk_add_provider(np, of_clk_src_onecell_get, cod);
> +	if (_errno < 0) {
> +		pr_err("%s(): %s: of_clk_add_provider() =3D %d\n",
> +		       __func__, np->name, _errno);
> +		goto return_clk_unregister;
> +	}
> +
> +	return;
> +
> +return_clk_unregister:
> +	while (--i >=3D 0)
> +		clk_unregister(cod->clks[i]);
> +	kfree(cod);
> +}
> +
>  CLK_OF_DECLARE(qoriq_sysclk_1, "fsl,qoriq-sysclk-1.0", sysclk_init);
> CLK_OF_DECLARE(qoriq_sysclk_2, "fsl,qoriq-sysclk-2.0", sysclk_init);
> CLK_OF_DECLARE(qoriq_core_pll_1, "fsl,qoriq-core-pll-1.0",
> core_pll_init);  CLK_OF_DECLARE(qoriq_core_pll_2, "fsl,qoriq-core-pll-
> 2.0", core_pll_init);  CLK_OF_DECLARE(qoriq_core_mux_1, "fsl,qoriq-core-
> mux-1.0", core_mux_init);  CLK_OF_DECLARE(qoriq_core_mux_2, "fsl,qoriq-
> core-mux-2.0", core_mux_init);
> +CLK_OF_DECLARE(qoriq_pltfrm_pll_1, "fsl,qoriq-platform-pll-1.0",
> +pltfrm_pll_init); CLK_OF_DECLARE(qoriq_pltfrm_pll_2,
> +"fsl,qoriq-platform-pll-2.0", pltfrm_pll_init);
> --
> 2.2.1

Acked-by: Tang Yuantian <Yuantian.Tang@freescale.com>

Regards,
Yuantian

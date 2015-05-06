Return-Path: <sboyd@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 99C871A00F6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 17:02:52 +1000 (AEST)
Date: Wed, 6 May 2015 00:02:47 -0700
From: Stephen Boyd <sboyd@codeaurora.org>
To: "Igal.Liberman" <igal.liberman@freescale.com>
Subject: Re: [v4] clk: qoriq: Add support for the FMan clock
Message-ID: <20150506070247.GA27050@codeaurora.org>
References: <1429185945-6949-1-git-send-email-igal.liberman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1429185945-6949-1-git-send-email-igal.liberman@freescale.com>
Cc: scottwood@freescale.com, mturquette@linaro.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/16, Igal.Liberman wrote:
> From: Igal Liberman <Igal.Liberman@freescale.com>
> 
> This patch depends on the following patches:
> 	https://patchwork.ozlabs.org/patch/461151/
> 	https://patchwork.ozlabs.org/patch/461155/
> 
> This patche is described by the following binding document update:
> 	https://patchwork.ozlabs.org/patch/461166/
> 
> v4:	- Replaced "fsl,b4-device-config" with
> 	  "fsl,b4860/b4420-device-config"
> 	- Updated error messages
> 
> v3:	Updated commit message
> 
> v2:	- Added clock maintainers
> 	- Cached FMan clock parent during initialization
> 	- Register the clock after checking if the hardware exists
> 	- updated error messages
> 
> Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
> ---
>  drivers/clk/clk-qoriq.c |  213 +++++++++++++++++++++++++++++++++++++++++++++++

If I try to compile this on ARM (the Kconfig for this file shows
that ARM is possible) then it fails with this error message:

  CC      drivers/clk/clk-qoriq.o
  drivers/clk/clk-qoriq.c:22:26:
  fatal error: asm/fsl_guts.h: No such file or directory
  compilation terminated.

>  1 file changed, 213 insertions(+)
> 
> diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
> index cda90a9..871c6df 100644
> --- a/drivers/clk/clk-qoriq.c
> +++ b/drivers/clk/clk-qoriq.c
> +
> +static u8 get_fm_clk_parent(struct clk_hw *hw)
> +{
> +	return hw->init->flags;
> +}

This is very confusing. How is flags the parent index? Please
don't abuse framework data structures. I'm actually thinking we
should replace hw->init with NULL during clk_register() to avoid
this kind of abuse...

> +
> +static const struct clk_ops fm_clk_ops = {
> +	.get_parent = get_fm_clk_parent,
> +};
> +
> +static int get_fm_clk_idx(int fm_id, int *fm_clk_idx)
> +{
> +	struct ccsr_guts __iomem *guts_regs = NULL;

Unnecessary initialization to NULL. Also, marking a structure as
__iomem is odd. Why do we need to use a struct to figure out
offsets for registers? Why not just use #defines? That would
probably also make it easy to avoid the asm include here.

> +	struct device_node *guts;
> +	uint32_t reg = 0;

s/uint32_t/u32/

Also unnecessary initialization.

> +	int clk_src = 0;
> +
> +	guts = of_find_matching_node(NULL, guts_device_ids);
> +	if (!guts) {
> +		pr_err("%s(): could not find GUTS node\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	guts_regs = of_iomap(guts, 0);
> +	of_node_put(guts);
> +	if (!guts_regs) {
> +		pr_err("%s(): ioremap of GUTS node failed\n", __func__);
> +		return -ENODEV;
> +	}
[...]
> +
> +static void __init fm_mux_init(struct device_node *np)
> +{
> +	struct clk_init_data *init;
> +	struct clk_hw *hw;
> +	int count, i, ret, fm_id = 0, fm_clk_idx;
> +	struct clk *clk;
> +
> +	init = kmalloc((sizeof(struct clk_init_data)), GFP_KERNEL);

Please remove extra parens and do sizeof(*init) so that we don't
have to care about the type matching.

> +	if (!init)
> +		return;
> +
> +	/* get the input clock source count */
> +	count = of_property_count_strings(np, "clock-names");
> +	if (count < 0) {
> +		pr_err("%s(): %s: get clock count error\n",
> +		       __func__, np->name);
> +		goto err_init;
> +	}
> +
> +	init->parent_names = kmalloc((sizeof(char *) * count), GFP_KERNEL);

Use kcalloc please

> +	if (!init->parent_names)
> +		goto err_init;
> +
> +	for (i = 0; i < count; i++)
> +		init->parent_names[i] = of_clk_get_parent_name(np, i);
> +
> +	hw = kzalloc(sizeof(*hw), GFP_KERNEL);
> +	if (!hw)
> +		goto err_name;
> +
> +	ret = of_property_read_string_index(np, "clock-output-names", 0,
> +					    &init->name);
> +	if (ret) {
> +		pr_err("%s(): %s: read clock names error\n",
> +		       __func__, np->name);
> +		goto err_clk_hw;
> +	}
> +
> +	if (!strcmp(np->name, "fm1-clk-mux"))
> +		fm_id = 1;
> +
> +	ret = get_fm_clk_idx(fm_id, &fm_clk_idx);
> +	if (ret)
> +		goto err_clk_hw;
> +
> +	init->ops = &fm_clk_ops;
> +	init->num_parents = count;
> +	/* Save clock source index */
> +	init->flags = fm_clk_idx;

Don't do this.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

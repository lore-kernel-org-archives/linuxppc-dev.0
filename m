Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0137.outbound.protection.outlook.com [207.46.100.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 850581A0CFB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 20:03:52 +1100 (AEDT)
Message-ID: <54BF6B35.1080007@Freescale.com>
Date: Wed, 21 Jan 2015 03:02:45 -0600
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Tang Yuantian-B29983 <Yuantian.Tang@Freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Wood
 Scott-B07421" <scottwood@Freescale.com>, "mturquette@linaro.org"
 <mturquette@linaro.org>, "haokexin@gmail.com" <haokexin@gmail.com>
Subject: Re: [PATCH 8/8] clk: ppc-corenet: Add support for the platform PLL
References: <1421748570-14282-1-git-send-email-Emilian.Medve@Freescale.com>
 <1421748570-14282-9-git-send-email-Emilian.Medve@Freescale.com>
 <DM2PR03MB57442D24D55149AA78F3C8FFA480@DM2PR03MB574.namprd03.prod.outlook.com>
 <54BF6130.1070501@Freescale.com>
 <DM2PR03MB574B53C2F3BC01B56C937D3FA480@DM2PR03MB574.namprd03.prod.outlook.com>
In-Reply-To: <DM2PR03MB574B53C2F3BC01B56C937D3FA480@DM2PR03MB574.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Yuan-Tian,


On 01/21/2015 02:35 AM, Tang Yuantian-B29983 wrote:
> Hi Emil,
> 
> I don't think it is the best to add a function that is very similar to existing one. 
> If you think the function name is not appropriate, rename it.

It's not a naming matter. As I said, core_pll_init() assumptions and
decisions based on the number of clocks in the DT. My hunch is some of
these assumptions are not necessary and/or should be explicit based on
the node/device compatible. Having a standalone platform PLL
initialization function wasn't a unilateral lack of foresight


Cheers,


> Thanks,
> Yuantian
> 
>> -----Original Message-----
>> From: Emil Medve [mailto:Emilian.Medve@Freescale.com]
>> Sent: Wednesday, January 21, 2015 4:20 PM
>> To: Tang Yuantian-B29983; linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421;
>> mturquette@linaro.org; haokexin@gmail.com
>> Subject: Re: [PATCH 8/8] clk: ppc-corenet: Add support for the platform PLL
>>
>> Hello Yuan-Tian,
>>
>>
>> On 01/20/2015 11:42 PM, Tang Yuantian-B29983 wrote:
>>> Which platform are you trying to use this on?
>>
>> CoreNet chassis v1 and v2 SoC(s)
>>
>>> Can this be initialized by core pll function core_pll_init()?
>>> I just saw most of this function is silimar to the core_pll_init().
>>
>> Yes, the flow is similar, but core_pll_init() makes assumptions that it shouldn't or
>> are not relevant to the platform PLL
>>
>>
>> Cheers,
>>
>>
>>> Thanks,
>>> Yuantian
>>>
>>>> -----Original Message-----
>>>> From: Emil Medve [mailto:Emilian.Medve@Freescale.com]
>>>> Sent: Tuesday, January 20, 2015 6:10 PM
>>>> To: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421;
>>>> mturquette@linaro.org; haokexin@gmail.com; Tang Yuantian-B29983
>>>> Cc: Medve Emilian-EMMEDVE1
>>>> Subject: [PATCH 8/8] clk: ppc-corenet: Add support for the platform
>>>> PLL
>>>>
>>>> Change-Id: Iac11ed95f274485a86d2c11f32a3dc502bcd020f
>>>> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
>>>> ---
>>>>  drivers/clk/clk-ppc-corenet.c | 85
>>>> +++++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 85 insertions(+)
>>>>
>>>> diff --git a/drivers/clk/clk-ppc-corenet.c
>>>> b/drivers/clk/clk-ppc-corenet.c index
>>>> 91816b1..ff425e1 100644
>>>> --- a/drivers/clk/clk-ppc-corenet.c
>>>> +++ b/drivers/clk/clk-ppc-corenet.c
>>>> @@ -7,6 +7,9 @@
>>>>   *
>>>>   * clock driver for Freescale PowerPC corenet SoCs.
>>>>   */
>>>> +
>>>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>>> +
>>>>  #include <linux/clk-provider.h>
>>>>  #include <linux/io.h>
>>>>  #include <linux/kernel.h>
>>>> @@ -261,9 +264,91 @@ static void __init sysclk_init(struct device_node
>> *node)
>>>>  		of_clk_add_provider(np, of_clk_src_simple_get, clk);  }
>>>>
>>>> +static void __init pltfrm_pll_init(struct device_node *np) {
>>>> +	void __iomem *base;
>>>> +	uint32_t mult;
>>>> +	const char *parent_name, *clk_name;
>>>> +	int i, _errno;
>>>> +	struct clk_onecell_data *cod;
>>>> +
>>>> +	base = of_iomap(np, 0);
>>>> +	if (!base) {
>>>> +		pr_err("%s(): %s: of_iomap() failed\n", __func__, np->name);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	/* Get the multiple of PLL */
>>>> +	mult = ioread32be(base);
>>>> +
>>>> +	iounmap(base);
>>>> +
>>>> +	/* Check if this PLL is disabled */
>>>> +	if (mult & PLL_KILL) {
>>>> +		pr_debug("%s(): %s: Disabled\n", __func__, np->name);
>>>> +		return;
>>>> +	}
>>>> +	mult = (mult & GENMASK(6, 1)) >> 1;
>>>> +
>>>> +	parent_name = of_clk_get_parent_name(np, 0);
>>>> +	if (!parent_name) {
>>>> +		pr_err("%s(): %s: of_clk_get_parent_name() failed\n",
>>>> +		       __func__, np->name);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	i = of_property_count_strings(np, "clock-output-names");
>>>> +	if (i < 0) {
>>>> +		pr_err("%s(): %s: of_property_count_strings(clock-output-names)
>>>> = %d\n",
>>>> +		       __func__, np->name, i);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	cod = kmalloc(sizeof(*cod) + i * sizeof(struct clk *), GFP_KERNEL);
>>>> +	if (!cod)
>>>> +		return;
>>>> +	cod->clks = (struct clk **)(cod + 1);
>>>> +	cod->clk_num = i;
>>>> +
>>>> +	for (i = 0; i < cod->clk_num; i++) {
>>>> +		_errno = of_property_read_string_index(np, "clock-output-names",
>>>> +						       i, &clk_name);
>>>> +		if (_errno < 0) {
>>>> +			pr_err("%s(): %s:
>>>> of_property_read_string_index(clock-output-names) = %d\n",
>>>> +			       __func__, np->name, _errno);
>>>> +			goto return_clk_unregister;
>>>> +		}
>>>> +
>>>> +		cod->clks[i] = clk_register_fixed_factor(NULL, clk_name,
>>>> +					       parent_name, 0, mult, 1 + i);
>>>> +		if (IS_ERR(cod->clks[i])) {
>>>> +			pr_err("%s(): %s: clk_register_fixed_factor(%s) = %ld\n",
>>>> +			       __func__, np->name,
>>>> +			       clk_name, PTR_ERR(cod->clks[i]));
>>>> +			goto return_clk_unregister;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	_errno = of_clk_add_provider(np, of_clk_src_onecell_get, cod);
>>>> +	if (_errno < 0) {
>>>> +		pr_err("%s(): %s: of_clk_add_provider() = %d\n",
>>>> +		       __func__, np->name, _errno);
>>>> +		goto return_clk_unregister;
>>>> +	}
>>>> +
>>>> +	return;
>>>> +
>>>> +return_clk_unregister:
>>>> +	while (--i >= 0)
>>>> +		clk_unregister(cod->clks[i]);
>>>> +	kfree(cod);
>>>> +}
>>>> +
>>>>  CLK_OF_DECLARE(qoriq_sysclk_1, "fsl,qoriq-sysclk-1.0", sysclk_init);
>>>> CLK_OF_DECLARE(qoriq_sysclk_2, "fsl,qoriq-sysclk-2.0", sysclk_init);
>>>> CLK_OF_DECLARE(qoriq_core_pll_1, "fsl,qoriq-core-pll-1.0",
>>>> core_pll_init); CLK_OF_DECLARE(qoriq_core_pll_2,
>>>> "fsl,qoriq-core-pll-2.0", core_pll_init);
>>>> CLK_OF_DECLARE(qoriq_core_mux_1, "fsl,qoriq-core-mux-1.0",
>>>> core_mux_init); CLK_OF_DECLARE(qoriq_core_mux_2,
>>>> "fsl,qoriq-core-mux-2.0", core_mux_init);
>>>> +CLK_OF_DECLARE(qoriq_pltfrm_pll_1, "fsl,qoriq-platform-pll-1.0",
>>>> +pltfrm_pll_init); CLK_OF_DECLARE(qoriq_pltfrm_pll_2,
>>>> +"fsl,qoriq-platform-pll-2.0", pltfrm_pll_init);
>>>> --
>>>> 2.2.2

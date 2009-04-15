Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C3E98DDFC5
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 09:59:37 +1000 (EST)
Message-Id: <98F905BD-B447-4FAA-A7FE-9FCD025A9079@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: akpm@linux-foundation.org
In-Reply-To: <200904152227.n3FMRmdm007192@imap1.linux-foundation.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: + edac-cpc925-mc-platform-device-setup.patch added to -mm tree
Date: Wed, 15 Apr 2009 18:58:37 -0500
References: <200904152227.n3FMRmdm007192@imap1.linux-foundation.org>
Cc: mm-commits@vger.kernel.org,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Kumar Gala <galak@gate.crashing.org>, qingtao.cao@windriver.com,
	Doug Thompson <norsk5@yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 15, 2009, at 5:27 PM, akpm@linux-foundation.org wrote:

>
> The patch titled
>     edac: cpc925 MC platform device setup
> has been added to the -mm tree.  Its filename is
>     edac-cpc925-mc-platform-device-setup.patch
>
> Before you just go and hit "reply", please:
>   a) Consider who else should be cc'ed
>   b) Prefer to cc a suitable mailing list as well
>   c) Ideally: find the original patch on the mailing list and do a
>      reply-to-all to that, adding suitable additional cc's
>
> *** Remember to use Documentation/SubmitChecklist when testing your  
> code ***
>
> See http://userweb.kernel.org/~akpm/stuff/added-to-mm.txt to find
> out what to do about this
>
> The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/
>
> ------------------------------------------------------
> Subject: edac: cpc925 MC platform device setup
> From: Harry Ciao <qingtao.cao@windriver.com>
>
> Fix up the number of cells for the values of CPC925 Memory Controller,
> and setup related platform device during system booting up, against
> which CPC925 Memory Controller EDAC driver would be matched.
>
> Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
> Cc: Doug Thompson <norsk5@yahoo.com>
> Cc: Michael Ellerman <michael@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Kumar Gala <galak@gate.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
> arch/powerpc/kernel/prom_init.c      |   33 +++++++++++++
> arch/powerpc/platforms/maple/setup.c |   59 +++++++++++++++++++++++++
> 2 files changed, 92 insertions(+)
>
> diff -puN arch/powerpc/kernel/prom_init.c~edac-cpc925-mc-platform- 
> device-setup arch/powerpc/kernel/prom_init.c
> --- a/arch/powerpc/kernel/prom_init.c~edac-cpc925-mc-platform-device- 
> setup
> +++ a/arch/powerpc/kernel/prom_init.c
> @@ -1947,8 +1947,40 @@ static void __init fixup_device_tree_map
> 	prom_setprop(isa, name, "ranges",
> 			isa_ranges, sizeof(isa_ranges));
> }
> +
> +#define CPC925_MC_START		0xf8000000
> +#define CPC925_MC_LENGTH	0x1000000
> +/* The values for memory-controller don't have right number of  
> cells */
> +static void __init fixup_device_tree_maple_memory_controller(void)
> +{

I don't see why this cant be part of the existing  
fixup_device_tree_maple().

I also find it odd we don't ensure we are running on a maple before we  
apply this fixup.

- k

>
> +	phandle mc;
> +	u32 mc_reg[4];
> +	char *name = "/hostbridge@f8000000";
> +
> +	mc = call_prom("finddevice", 1, 1, ADDR(name));
> +	if (!PHANDLE_VALID(mc))
> +		return;
> +
> +	if (prom_getproplen(mc, "reg") != 8)
> +		return;
> +
> +	if (prom_getprop(mc, "reg", mc_reg, sizeof(mc_reg)) == PROM_ERROR)
> +		return;
> +
> +	if (mc_reg[0] != CPC925_MC_START || mc_reg[1] != CPC925_MC_LENGTH)
> +		return;
> +
> +	prom_printf("Fixing up bogus hostbridge on Maple...\n");
> +
> +	mc_reg[0] = 0x0;
> +	mc_reg[1] = CPC925_MC_START;
> +	mc_reg[2] = 0x0;
> +	mc_reg[3] = CPC925_MC_LENGTH;
> +	prom_setprop(mc, name, "reg", mc_reg, sizeof(mc_reg));
> +}
> #else
> #define fixup_device_tree_maple()
> +#define fixup_device_tree_maple_memory_controller()
> #endif
>
> #ifdef CONFIG_PPC_CHRP
> @@ -2189,6 +2221,7 @@ static void __init fixup_device_tree_efi
> static void __init fixup_device_tree(void)
> {
> 	fixup_device_tree_maple();
> +	fixup_device_tree_maple_memory_controller();
> 	fixup_device_tree_chrp();
> 	fixup_device_tree_pmac();
> 	fixup_device_tree_efika();
> diff -puN arch/powerpc/platforms/maple/setup.c~edac-cpc925-mc- 
> platform-device-setup arch/powerpc/platforms/maple/setup.c
> --- a/arch/powerpc/platforms/maple/setup.c~edac-cpc925-mc-platform- 
> device-setup
> +++ a/arch/powerpc/platforms/maple/setup.c
> @@ -335,3 +335,62 @@ define_machine(maple) {
> 	.progress		= maple_progress,
> 	.power_save		= power4_idle,
> };
> +
> +#ifdef CONFIG_EDAC
> +/*
> + * Register a platform device for CPC925 memory controller on
> + * Motorola ATCA-6101 blade.
> + */
> +#define MAPLE_CPC925_MODEL	"Motorola,ATCA-6101"
> +static int __init maple_cpc925_edac_setup(void)
> +{
> +	struct platform_device *pdev;
> +	struct device_node *np = NULL;
> +	struct resource r;
> +	const unsigned char *model;
> +	int ret;
> +
> +	np = of_find_node_by_path("/");
> +	if (!np) {
> +		printk(KERN_ERR "%s: Unable to get root node\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	model = (const unsigned char *)of_get_property(np, "model", NULL);
> +	if (!model) {
> +		printk(KERN_ERR "%s: Unabel to get model info\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	ret = strcmp(model, MAPLE_CPC925_MODEL);
> +	of_node_put(np);
> +
> +	if (ret != 0)
> +		return 0;
> +
> +	np = of_find_node_by_type(NULL, "memory-controller");
> +	if (!np) {
> +		printk(KERN_ERR "%s: Unable to find memory-controller node\n",
> +			__func__);
> +		return -ENODEV;
> +	}
> +
> +	ret = of_address_to_resource(np, 0, &r);
> +	of_node_put(np);
> +
> +	if (ret < 0) {
> +		printk(KERN_ERR "%s: Unable to get memory-controller reg\n",
> +			__func__);
> +		return -ENODEV;
> +	}
> +
> +	pdev = platform_device_register_simple("cpc925_edac", 0, &r, 1);
> +	if (IS_ERR(pdev))
> +		return PTR_ERR(pdev);
> +
> +	printk(KERN_INFO "%s: CPC925 platform device created\n", __func__);
> +
> +	return 0;
> +}
> +machine_device_initcall(maple, maple_cpc925_edac_setup);
> +#endif
> _
>
> Patches currently in -mm which might be from  
> qingtao.cao@windriver.com are
>
> edac-add-cpc925-memory-controller-driver.patch
> edac-add-cpc925-memory-controller-driver-cleanup.patch
> edac-add-edac_device_alloc_index.patch
> edac-add-edac_device_alloc_index-cleanup.patch
> edac-cpc925-mc-platform-device-setup.patch

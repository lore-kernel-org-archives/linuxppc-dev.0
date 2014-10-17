Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AAC741A02F4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 19:03:56 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2D09D1400BE
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2014 19:03:53 +1100 (AEDT)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] cpufreq: qoriq: Make the driver usable on all QorIQ
 platforms
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1413515616-15874-1-git-send-email-B29983@freescale.com>
Date: Fri, 17 Oct 2014 10:03:40 +0200
Message-Id: <8F5E4DA7-8A64-4614-91E7-BFB28D91C737@kernel.crashing.org>
References: <1413515616-15874-1-git-send-email-B29983@freescale.com>
To: b29983@freescale.com
Cc: Tang Yuantian <Yuantian.Tang@freescale.com>, viresh.kumar@linaro.org,
 linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 17, 2014, at 5:13 AM, b29983@freescale.com wrote:

> From: Tang Yuantian <Yuantian.Tang@freescale.com>
>=20
> Freescale introduced new ARM core-based SoCs which support dynamic
> frequency switch feature. DFS on new SoCs are compatible with current
> PowerPC CoreNet platforms. In order to support those new platforms,
> this driver needs to be slightly adjusted. The main changes include:
>=20
> 1. Changed the names of driver and functions in driver.

split the name changes/renaming into a separate patch from the other =
changes.

> 2. Added two new functions get_cpu_physical_id() and get_bus_freq().
> 3. Used a new way to get all the CPUs which sharing clock wire.
>=20
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> ---
> drivers/cpufreq/Kconfig.arm                        |   8 ++
> drivers/cpufreq/Kconfig.powerpc                    |  11 +-
> drivers/cpufreq/Makefile                           |   2 +-
> .../{ppc-corenet-cpufreq.c =3D> qoriq-cpufreq.c}     | 150 =
++++++++++++++-------
> 4 files changed, 114 insertions(+), 57 deletions(-)
> rename drivers/cpufreq/{ppc-corenet-cpufreq.c =3D> qoriq-cpufreq.c} =
(72%)
>=20
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 83a75dc..1925ae94 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -247,3 +247,11 @@ config ARM_TEGRA_CPUFREQ
> 	default y
> 	help
> 	  This adds the CPUFreq driver support for TEGRA SOCs.
> +
> +config QORIQ_CPUFREQ
> +	tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
> +	depends on OF && COMMON_CLK
> +	select CLK_PPC_CORENET

Why are you not also renaming =91CLK_PPC_CORENET=92 to =91CLK_QORIQ=92 =
or something like that?  Seems rather odd to select a PPC CLK support on =
ARM ;)

> +	help
> +	  This adds the CPUFreq driver support for Freescale QorIQ SoCs
> +	  which are capable of changing the CPU's frequency dynamically.
> diff --git a/drivers/cpufreq/Kconfig.powerpc =
b/drivers/cpufreq/Kconfig.powerpc
> index 72564b7..3a34248 100644
> --- a/drivers/cpufreq/Kconfig.powerpc
> +++ b/drivers/cpufreq/Kconfig.powerpc
> @@ -23,14 +23,13 @@ config CPU_FREQ_MAPLE
> 	  This adds support for frequency switching on Maple 970FX
> 	  Evaluation Board and compatible boards (IBM JS2x blades).
>=20
> -config PPC_CORENET_CPUFREQ
> -	tristate "CPU frequency scaling driver for Freescale E500MC =
SoCs"
> -	depends on PPC_E500MC && OF && COMMON_CLK
> +config QORIQ_CPUFREQ
> +	tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
> +	depends on OF && COMMON_CLK
> 	select CLK_PPC_CORENET
> 	help
> -	  This adds the CPUFreq driver support for Freescale e500mc,
> -	  e5500 and e6500 series SoCs which are capable of changing
> -	  the CPU's frequency dynamically.
> +	  This adds the CPUFreq driver support for Freescale QorIQ SoCs
> +	  which are capable of changing the CPU's frequency dynamically.
>=20
> config CPU_FREQ_PMAC
> 	bool "Support for Apple PowerBooks"
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 40c53dc..0020049 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -84,7 +84,7 @@ obj-$(CONFIG_CPU_FREQ_CBE)		+=3D =
ppc-cbe-cpufreq.o
> ppc-cbe-cpufreq-y			+=3D ppc_cbe_cpufreq_pervasive.o =
ppc_cbe_cpufreq.o
> obj-$(CONFIG_CPU_FREQ_CBE_PMI)		+=3D =
ppc_cbe_cpufreq_pmi.o
> obj-$(CONFIG_CPU_FREQ_MAPLE)		+=3D maple-cpufreq.o
> -obj-$(CONFIG_PPC_CORENET_CPUFREQ)   +=3D ppc-corenet-cpufreq.o
> +obj-$(CONFIG_QORIQ_CPUFREQ)   		+=3D qoriq-cpufreq.o
> obj-$(CONFIG_CPU_FREQ_PMAC)		+=3D pmac32-cpufreq.o
> obj-$(CONFIG_CPU_FREQ_PMAC64)		+=3D pmac64-cpufreq.o
> obj-$(CONFIG_PPC_PASEMI_CPUFREQ)	+=3D pasemi-cpufreq.o
> diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c =
b/drivers/cpufreq/qoriq-cpufreq.c
> similarity index 72%
> rename from drivers/cpufreq/ppc-corenet-cpufreq.c
> rename to drivers/cpufreq/qoriq-cpufreq.c
> index bee5df7..80def0c 100644
> --- a/drivers/cpufreq/ppc-corenet-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -1,7 +1,7 @@
> /*
>  * Copyright 2013 Freescale Semiconductor, Inc.
>  *
> - * CPU Frequency Scaling driver for Freescale PowerPC corenet SoCs.
> + * CPU Frequency Scaling driver for Freescale QorIQ SoCs.
>  *
>  * This program is free software; you can redistribute it and/or =
modify
>  * it under the terms of the GNU General Public License version 2 as
> @@ -20,7 +20,6 @@
> #include <linux/of.h>
> #include <linux/slab.h>
> #include <linux/smp.h>
> -#include <sysdev/fsl_soc.h>
>=20
> /**
>  * struct cpu_data - per CPU data struct
> @@ -69,9 +68,6 @@ static const u32 *fmask;
>=20
> static DEFINE_PER_CPU(struct cpu_data *, cpu_data);
>=20
> -/* cpumask in a cluster */
> -static DEFINE_PER_CPU(cpumask_var_t, cpu_mask);
> -
> #ifndef CONFIG_SMP
> static inline const struct cpumask *cpu_core_mask(int cpu)
> {
> @@ -79,6 +75,79 @@ static inline const struct cpumask =
*cpu_core_mask(int cpu)
> }
> #endif
>=20
> +#if defined(CONFIG_PPC_E500MC)

Probably should just be CONFIG_PPC, but do we need this at all.  Can=92t =
we just use topology_core_id() on both ARM & PPC?

> +static int get_cpu_physical_id(int cpu)
> +{
> +	return get_hard_smp_processor_id(cpu);
> +}
> +#elif defined(CONFIG_ARM)
> +static int get_cpu_physical_id(int cpu)
> +{
> +	return topology_core_id(cpu);
> +}
> +#endif
> +
> +static u32 get_bus_freq(void)
> +{
> +	struct device_node *soc;
> +	u32 sysfreq;
> +
> +	soc =3D of_find_node_by_type(NULL, "soc");
> +	if (!soc)
> +		return 0;
> +
> +	if (of_property_read_u32(soc, "bus-frequency", &sysfreq))
> +		sysfreq =3D 0;
> +
> +	of_node_put(soc);
> +
> +	return sysfreq;
> +}
> +
> +static struct device_node *cpu_to_clk_node(int cpu)
> +{
> +	struct device_node *np, *clk_np;
> +
> +	if (!cpu_present(cpu))
> +		return NULL;
> +
> +	np =3D of_get_cpu_node(cpu, NULL);
> +	if (!np)
> +		return NULL;
> +
> +	clk_np =3D of_parse_phandle(np, "clocks", 0);
> +	if (!clk_np)
> +		return NULL;
> +
> +	of_node_put(np);
> +
> +	return clk_np;
> +}
> +
> +/* traverse cpu nodes to get cpu mask of sharing clock wire */
> +static void set_affected_cpus(struct cpufreq_policy *policy)
> +{
> +	struct device_node *np, *clk_np;
> +	struct cpumask *dstp =3D policy->cpus;
> +	int i;
> +
> +	np =3D cpu_to_clk_node(policy->cpu);
> +	if (!np)
> +		return;
> +
> +	for_each_present_cpu(i) {
> +		clk_np =3D cpu_to_clk_node(i);
> +		if (!clk_np)
> +			continue;
> +
> +		if (clk_np =3D=3D np)
> +			cpumask_set_cpu(i, dstp);
> +
> +		of_node_put(clk_np);
> +	}
> +	of_node_put(np);
> +}
> +
> /* reduce the duplicated frequencies in frequency table */
> static void freq_table_redup(struct cpufreq_frequency_table =
*freq_table,
> 		int count)
> @@ -105,6 +174,7 @@ static void freq_table_sort(struct =
cpufreq_frequency_table *freq_table,
> 	int i, j, ind;
> 	unsigned int freq, max_freq;
> 	struct cpufreq_frequency_table table;
> +
> 	for (i =3D 0; i < count - 1; i++) {
> 		max_freq =3D freq_table[i].frequency;
> 		ind =3D i;
> @@ -129,7 +199,7 @@ static void freq_table_sort(struct =
cpufreq_frequency_table *freq_table,
> 	}
> }
>=20
> -static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +static int qoriq_cpufreq_cpu_init(struct cpufreq_policy *policy)
> {
> 	struct device_node *np;
> 	int i, count, ret;
> @@ -145,10 +215,8 @@ static int corenet_cpufreq_cpu_init(struct =
cpufreq_policy *policy)
> 		return -ENODEV;
>=20
> 	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
> -	if (!data) {
> -		pr_err("%s: no memory\n", __func__);
> +	if (!data)
> 		goto err_np;
> -	}
>=20
> 	policy->clk =3D of_clk_get(np, 0);
> 	if (IS_ERR(policy->clk)) {
> @@ -170,7 +238,7 @@ static int corenet_cpufreq_cpu_init(struct =
cpufreq_policy *policy)
> 	}
>=20
> 	if (fmask)
> -		mask =3D fmask[get_hard_smp_processor_id(cpu)];
> +		mask =3D fmask[get_cpu_physical_id(cpu)];
> 	else
> 		mask =3D 0x0;
>=20
> @@ -201,13 +269,13 @@ static int corenet_cpufreq_cpu_init(struct =
cpufreq_policy *policy)
> 	data->table =3D table;
>=20
> 	/* update ->cpus if we have cluster, no harm if not */
> -	cpumask_copy(policy->cpus, per_cpu(cpu_mask, cpu));
> -	for_each_cpu(i, per_cpu(cpu_mask, cpu))
> +	set_affected_cpus(policy);
> +	for_each_cpu(i, policy->cpus)
> 		per_cpu(cpu_data, i) =3D data;
>=20
> 	/* Minimum transition latency is 12 platform clocks */
> 	u64temp =3D 12ULL * NSEC_PER_SEC;
> -	do_div(u64temp, fsl_get_sys_freq());
> +	do_div(u64temp, get_bus_freq());
> 	policy->cpuinfo.transition_latency =3D u64temp + 1;
>=20
> 	of_node_put(np);
> @@ -227,7 +295,7 @@ err_np:
> 	return -ENODEV;
> }
>=20
> -static int __exit corenet_cpufreq_cpu_exit(struct cpufreq_policy =
*policy)
> +static int __exit qoriq_cpufreq_cpu_exit(struct cpufreq_policy =
*policy)
> {
> 	struct cpu_data *data =3D per_cpu(cpu_data, policy->cpu);
> 	unsigned int cpu;
> @@ -236,13 +304,13 @@ static int __exit =
corenet_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> 	kfree(data->table);
> 	kfree(data);
>=20
> -	for_each_cpu(cpu, per_cpu(cpu_mask, policy->cpu))
> +	for_each_cpu(cpu, policy->cpus)
> 		per_cpu(cpu_data, cpu) =3D NULL;
>=20
> 	return 0;
> }
>=20
> -static int corenet_cpufreq_target(struct cpufreq_policy *policy,
> +static int qoriq_cpufreq_target(struct cpufreq_policy *policy,
> 		unsigned int index)
> {
> 	struct clk *parent;
> @@ -252,18 +320,18 @@ static int corenet_cpufreq_target(struct =
cpufreq_policy *policy,
> 	return clk_set_parent(policy->clk, parent);
> }
>=20
> -static struct cpufreq_driver ppc_corenet_cpufreq_driver =3D {
> -	.name		=3D "ppc_cpufreq",
> +static struct cpufreq_driver qoriq_cpufreq_driver =3D {
> +	.name		=3D "qoriq_cpufreq",
> 	.flags		=3D CPUFREQ_CONST_LOOPS,
> -	.init		=3D corenet_cpufreq_cpu_init,
> -	.exit		=3D __exit_p(corenet_cpufreq_cpu_exit),
> +	.init		=3D qoriq_cpufreq_cpu_init,
> +	.exit		=3D __exit_p(qoriq_cpufreq_cpu_exit),
> 	.verify		=3D cpufreq_generic_frequency_table_verify,
> -	.target_index	=3D corenet_cpufreq_target,
> +	.target_index	=3D qoriq_cpufreq_target,
> 	.get		=3D cpufreq_generic_get,
> 	.attr		=3D cpufreq_generic_attr,
> };
>=20
> -static const struct of_device_id node_matches[] __initdata =3D {
> +static const struct of_device_id node_matches[] __initconst =3D {
> 	{ .compatible =3D "fsl,p2041-clockgen", .data =3D &sdata[0], },
> 	{ .compatible =3D "fsl,p3041-clockgen", .data =3D &sdata[0], },
> 	{ .compatible =3D "fsl,p5020-clockgen", .data =3D &sdata[1], },
> @@ -273,61 +341,43 @@ static const struct of_device_id node_matches[] =
__initdata =3D {
> 	{}
> };
>=20
> -static int __init ppc_corenet_cpufreq_init(void)
> +static int __init qoriq_cpufreq_init(void)
> {
> 	int ret;
> 	struct device_node  *np;
> 	const struct of_device_id *match;
> 	const struct soc_data *data;
> -	unsigned int cpu;
>=20
> 	np =3D of_find_matching_node(NULL, node_matches);
> 	if (!np)
> 		return -ENODEV;
>=20
> -	for_each_possible_cpu(cpu) {
> -		if (!alloc_cpumask_var(&per_cpu(cpu_mask, cpu), =
GFP_KERNEL))
> -			goto err_mask;
> -		cpumask_copy(per_cpu(cpu_mask, cpu), =
cpu_core_mask(cpu));
> -	}
> -
> 	match =3D of_match_node(node_matches, np);
> 	data =3D match->data;
> 	if (data) {
> 		if (data->flag)
> 			fmask =3D data->freq_mask;
> -		min_cpufreq =3D fsl_get_sys_freq();
> +		min_cpufreq =3D get_bus_freq();
> 	} else {
> -		min_cpufreq =3D fsl_get_sys_freq() / 2;
> +		min_cpufreq =3D get_bus_freq() / 2;
> 	}
>=20
> 	of_node_put(np);
>=20
> -	ret =3D cpufreq_register_driver(&ppc_corenet_cpufreq_driver);
> +	ret =3D cpufreq_register_driver(&qoriq_cpufreq_driver);
> 	if (!ret)
> -		pr_info("Freescale PowerPC corenet CPU frequency scaling =
driver\n");
> +		pr_info("Freescale QorIQ CPU frequency scaling =
driver\n");
>=20
> 	return ret;
> -
> -err_mask:
> -	for_each_possible_cpu(cpu)
> -		free_cpumask_var(per_cpu(cpu_mask, cpu));
> -
> -	return -ENOMEM;
> }
> -module_init(ppc_corenet_cpufreq_init);
> +module_init(qoriq_cpufreq_init);
>=20
> -static void __exit ppc_corenet_cpufreq_exit(void)
> +static void __exit qoriq_cpufreq_exit(void)
> {
> -	unsigned int cpu;
> -
> -	for_each_possible_cpu(cpu)
> -		free_cpumask_var(per_cpu(cpu_mask, cpu));
> -
> -	cpufreq_unregister_driver(&ppc_corenet_cpufreq_driver);
> +	cpufreq_unregister_driver(&qoriq_cpufreq_driver);
> }
> -module_exit(ppc_corenet_cpufreq_exit);
> +module_exit(qoriq_cpufreq_exit);
>=20
> MODULE_LICENSE("GPL");
> MODULE_AUTHOR("Tang Yuantian <Yuantian.Tang@freescale.com>");
> -MODULE_DESCRIPTION("cpufreq driver for Freescale e500mc series =
SoCs");
> +MODULE_DESCRIPTION("cpufreq driver for Freescale QorIQ series SoCs");
> --=20
> 2.1.0.27.g96db324
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe =
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

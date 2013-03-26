Return-Path: <viresh.linux@gmail.com>
Received: from mail-vc0-f180.google.com (mail-vc0-f180.google.com
 [209.85.220.180])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6BA932C008D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 16:03:08 +1100 (EST)
Received: by mail-vc0-f180.google.com with SMTP id m17so5186181vca.25
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 22:03:05 -0700 (PDT)
MIME-Version: 1.0
Sender: viresh.linux@gmail.com
In-Reply-To: <1364265391-26077-3-git-send-email-Yuantian.Tang@freescale.com>
References: <1364265391-26077-1-git-send-email-Yuantian.Tang@freescale.com>
 <1364265391-26077-3-git-send-email-Yuantian.Tang@freescale.com>
Date: Tue, 26 Mar 2013 10:33:04 +0530
Message-ID: <CAOh2x==ecrDkU8j=_Usq5sYC=RzkbD1P3EH809Lrh1aZ2ZUpUw@mail.gmail.com>
Subject: Re: [PATCH 3/3] cpufreq: Add cpufreq driver for Freescale e500mc SOCs
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yuantian.Tang@freescale.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: rjw@sisk.pl, linuxppc-dev@lists.ozlabs.org, cpufreq@vger.kernel.org,
 linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 26, 2013 at 8:06 AM,  <Yuantian.Tang@freescale.com> wrote:
> diff --git a/drivers/cpufreq/Kconfig.powerpc b/drivers/cpufreq/Kconfig.powerpc
> index e76992f..6339db4 100644
> --- a/drivers/cpufreq/Kconfig.powerpc
> +++ b/drivers/cpufreq/Kconfig.powerpc
> @@ -5,3 +5,13 @@ config CPU_FREQ_MAPLE
>         help
>           This adds support for frequency switching on Maple 970FX
>           Evaluation Board and compatible boards (IBM JS2x blades).
> +
> +config PPC_CORENET_CPUFREQ
> +       tristate "CPU frequency scaling driver for Freescale E500MC SoCs"
> +       depends on PPC_E500MC

depends on OF and COMMON_CLK too?

> +       select CPU_FREQ_TABLE
> +       select CLK_PPC_CORENET
> +       help
> +         This adds the CPUFreq driver support for Freescale e500mc,
> +         e5500 and e6500 series SoCs which are capable of changing
> +         the CPU's frequency dynamically.
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 863fd18..2416559 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile

> diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c

> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/cpufreq.h>
> +#include <linux/init.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/io.h>
> +#include <linux/clk-provider.h>

You shouldn't need this normally.

> +#include <linux/cpu.h>

Keep them in alphabetical order, so that we don't anyone twice by mistake.

> +/**
> + * struct cpufreq_data - cpufreq driver data
> + * @cpus_per_cluster: CPU numbers per cluster
> + * @cpufreq_lock: the mutex lock
> + */
> +struct cpufreq_data {
> +       int     cpus_per_cluster;
> +       struct mutex cpufreq_lock;
> +};
> +
> +/**
> + * struct cpu_data - per CPU data struct

For your case where you have 8 cpus in a cluster, only one of 8 variables
would be used... Better to create an array of struct with elements:
cpu and data.

> + * @np: the node of CPU
> + * @parent: the parent node of np
> + * @table: frequency table point
> + */
> +struct cpu_data {
> +       struct device_node  *np;
> +       struct device_node  *parent;
> +       struct cpufreq_frequency_table *table;
> +};
> +
> +static DEFINE_PER_CPU(struct cpu_data, cpu_data);
> +static struct cpufreq_data freq_data;
> +
> +static unsigned int corenet_cpufreq_get_speed(unsigned int cpu)
> +{
> +       struct clk *clk;
> +       struct cpu_data *data = &per_cpu(cpu_data, cpu);
> +
> +       clk = of_clk_get(data->np, 0);

You want to do this everytime? Want to store it?

> +       return clk_get_rate(clk) / 1000;
> +}
> +
> +/* reduce the duplicated frequency in frequency table */
> +static int freq_table_redup(struct cpufreq_frequency_table *freq_table,
> +               int cur)
> +{
> +       int i;
> +
> +       for (i = 0; i < cur; i++) {
> +               if (freq_table[i].frequency == CPUFREQ_ENTRY_INVALID ||
> +                       freq_table[i].frequency != freq_table[cur].frequency)
> +                       continue;
> +
> +               freq_table[cur].index = -1;

don't need this.

> +               freq_table[cur].frequency = CPUFREQ_ENTRY_INVALID;
> +               break;
> +       }
> +
> +       return (i == cur) ? 0 : 1;

return value isn't used by caller.

> +}
> +
> +static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{
> +       unsigned int cpu = policy->cpu;
> +       int i, count;
> +       struct clk *clk;
> +       struct cpufreq_frequency_table *table;
> +       struct cpu_data *data;
> +
> +       data = &per_cpu(cpu_data, cpu);
> +       data->np = of_get_cpu_node(cpu, NULL);
> +       if (!data->np)
> +               return -ENODEV;
> +
> +       data->parent = of_parse_phandle(data->np, "clocks", 0);

You need to details your DTB bindings in Documentation/devicetree/bindings and
cc devicetree-discuss@lists.ozlabs.org.

> +       if (!data->parent)
> +               return -ENODEV;

of_node_put(np)??

> +
> +       count = of_property_count_strings(data->parent, "clock-names");
> +       table = kcalloc(count + 1,

kzalloc??

> +                       sizeof(struct cpufreq_frequency_table), GFP_KERNEL);

sizeof(*table)

> +       if (!table)
> +               return -ENOMEM;
> +
> +       for (i = cpu; i < freq_data.cpus_per_cluster + cpu; i++)
> +               cpumask_set_cpu(i, policy->cpus);
> +
> +       for (i = 0; i < count; i++) {
> +               table[i].index = i;
> +               clk = of_clk_get(data->parent, i);
> +               table[i].frequency = clk_get_rate(clk) / 1000;
> +               freq_table_redup(table, i);

Don't call it everytime, fix all these in a single call.

> +       }
> +       table[i].index = -1;

-1 ??

> +       table[i].frequency = CPUFREQ_TABLE_END;
> +
> +       data->table = table;
> +       cpufreq_frequency_table_get_attr(table, cpu);

This must be done only when init() passed. What if
cpufreq_frequency_table_cpuinfo() failed?

> +
> +       /* FIXME: what's the actual transition time? in ns */
> +       policy->cpuinfo.transition_latency = 2000;

CPUFREQ_ETERNAL??

> +       policy->cur = corenet_cpufreq_get_speed(policy->cpu);
> +
> +       /* set the min and max frequency properly */
> +       return cpufreq_frequency_table_cpuinfo(policy, table);
> +}
> +
> +static int __exit corenet_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> +{
> +       cpufreq_frequency_table_put_attr(policy->cpu);
> +
> +       return 0;
> +}
> +
> +static int corenet_cpufreq_verify(struct cpufreq_policy *policy)
> +{
> +       struct cpufreq_frequency_table *table;
> +
> +       table = (&per_cpu(cpu_data, policy->cpu))->table;
> +       if (!table)
> +               return -EINVAL;

This should never be true.

> +       return cpufreq_frequency_table_verify(policy, table);
> +}
> +
> +static int corenet_cpufreq_target(struct cpufreq_policy *policy,
> +               unsigned int target_freq, unsigned int relation)
> +{
> +       struct cpufreq_freqs freqs;
> +       unsigned int new;
> +       struct clk *clk, *parent;
> +       int ret;
> +       struct cpu_data *data = &per_cpu(cpu_data, policy->cpu);
> +
> +       cpufreq_frequency_table_target(policy, data->table,
> +                       target_freq, relation, &new);
> +
> +       if (policy->cur == data->table[new].frequency)
> +               return 0;
> +
> +       freqs.old = policy->cur;
> +       freqs.new = data->table[new].frequency;
> +       freqs.cpu = policy->cpu;
> +
> +       mutex_lock(&freq_data.cpufreq_lock);
> +       cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> +
> +       clk = of_clk_get(data->np, 0);
> +       parent = of_clk_get(data->parent, new);
> +       ret = clk_set_parent(clk, parent);
> +       if (ret) {
> +               mutex_unlock(&freq_data.cpufreq_lock);
> +               return ret;
> +       }
> +
> +       cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> +       mutex_unlock(&freq_data.cpufreq_lock);
> +
> +       return 0;
> +}
> +
> +static struct freq_attr *corenet_cpu_clks_attr[] = {
> +       &cpufreq_freq_attr_scaling_available_freqs,
> +       NULL,
> +};
> +
> +static struct cpufreq_driver ppc_corenet_cpufreq_driver = {
> +       .name           = "ppc_cpufreq",
> +       .owner          = THIS_MODULE,
> +       .flags          = CPUFREQ_CONST_LOOPS,
> +       .init           = corenet_cpufreq_cpu_init,
> +       .exit           = __exit_p(corenet_cpufreq_cpu_exit),
> +       .verify         = corenet_cpufreq_verify,
> +       .target         = corenet_cpufreq_target,
> +       .get            = corenet_cpufreq_get_speed,
> +       .attr           = corenet_cpu_clks_attr,
> +};
> +
> +static const struct of_device_id node_matches[] __initconst = {
> +       { .compatible = "fsl,qoriq-clockgen-1.0", .data = (void *)1, },
> +       { .compatible = "fsl,qoriq-clockgen-2", .data = (void *)8, },
> +       {}
> +};
> +
> +static int __init ppc_corenet_cpufreq_init(void)
> +{
> +       int ret = 0;
> +       struct device_node  *np;
> +       const struct of_device_id *match;
> +
> +       np = of_find_matching_node(NULL, node_matches);
> +       if (!np)
> +               return -ENODEV;
> +
> +       match = of_match_node(node_matches, np);
> +       freq_data.cpus_per_cluster = (long)match->data;
> +       mutex_init(&freq_data.cpufreq_lock);
> +       of_node_put(np);
> +
> +       ret = cpufreq_register_driver(&ppc_corenet_cpufreq_driver);
> +       if (ret)
> +               return ret;
> +
> +       pr_info("Freescale PowerPC corenet CPU frequency scaling driver\n");
> +
> +       return ret;
> +}
> +
> +static void __exit ppc_corenet_cpufreq_exit(void)
> +{
> +       cpufreq_unregister_driver(&ppc_corenet_cpufreq_driver);
> +}
> +
> +module_init(ppc_corenet_cpufreq_init);
> +module_exit(ppc_corenet_cpufreq_exit);

Place them right below their respective functions without any blank
line in between.

> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Tang Yuantian <Yuantian.Tang@freescale.com>");
> +MODULE_DESCRIPTION("cpufreq driver for Freescale e500mc series SOCs");

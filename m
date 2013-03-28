Return-Path: <viresh.kumar@linaro.org>
Received: from mail-ob0-x231.google.com (mail-ob0-x231.google.com
 [IPv6:2607:f8b0:4003:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 078FA2C0040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2013 01:54:32 +1100 (EST)
Received: by mail-ob0-f177.google.com with SMTP id eh20so9138314obb.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2013 07:54:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1364464508-25393-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1364464508-25393-1-git-send-email-Yuantian.Tang@freescale.com>
Date: Thu, 28 Mar 2013 20:24:28 +0530
Message-ID: <CAKohpomPubV=E_wCLyOR6X0PQNvrJpTc94950PEF+YUam9ituw@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] cpufreq: Add cpufreq driver for Freescale e500mc
 SoCs
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

On 28 March 2013 15:25,  <Yuantian.Tang@freescale.com> wrote:
> From: Tang Yuantian <yuantian.tang@freescale.com>
>
> Add cpufreq driver for Freescale e500mc, e5500 and e6500 SoCs
> which are capable of changing the frequency of CPU dynamically
>
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> v2:
>         - change the per_cpu variable to point type
>         - fixed other issues

This changelog is pretty important and useful. People forget what comments
they gave on earlier version.

> diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c

> +/**
> + * struct cpufreq_data - cpufreq driver data
> + * @cpus_per_cluster: CPU numbers per cluster
> + * @cpufreq_lock: the mutex lock

rather add what's its purpose and what it protects.

> + */
> +struct cpufreq_data {
> +       int     cpus_per_cluster;
> +       struct mutex cpufreq_lock;
> +};

You actually need a struct for this? Simply create globals ?

> +/**
> + * struct cpu_data - per CPU data struct
> + * @clk: the clk data of CPU

remove "data"

> + * @parent: the parent node of clock of cpu

s/clock of cpu/cpu clock

> + * @table: frequency table point

point? you mean pointer? Just remove it.

> +struct cpu_data {
> +       struct clk *clk;
> +       struct device_node *parent;
> +       struct cpufreq_frequency_table *table;
> +};
> +
> +static DEFINE_PER_CPU(struct cpu_data *, cpu_data);
> +static struct cpufreq_data freq_data;
> +
> +static unsigned int corenet_cpufreq_get_speed(unsigned int cpu)
> +{
> +       struct cpu_data *data = per_cpu(cpu_data, cpu);
> +
> +       return clk_get_rate(data->clk) / 1000;
> +}
> +
> +/* reduce the duplicated frequency in frequency table */
> +static void freq_table_redup(struct cpufreq_frequency_table *freq_table,
> +               int count)
> +{
> +       int i, j;
> +
> +       for (i = 1; i < count; i++) {
> +               for (j = 0; j < i; j++) {
> +                       if (freq_table[j].frequency == CPUFREQ_ENTRY_INVALID ||
> +                                       freq_table[j].frequency !=
> +                                       freq_table[i].frequency)
> +                               continue;
> +
> +                       freq_table[i].frequency = CPUFREQ_ENTRY_INVALID;
> +                       break;
> +               }
> +       }
> +}

Looks better now :)

> +static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{
> +       unsigned int cpu = policy->cpu;
> +       struct device_node *np;
> +       int i, count;
> +       struct clk *clk;
> +       struct cpufreq_frequency_table *table;
> +       struct cpu_data *data;
> +
> +       np = of_get_cpu_node(cpu, NULL);
> +       if (!np)
> +               return -ENODEV;
> +
> +       data = kzalloc(sizeof(struct cpu_data), GFP_KERNEL);

I told you, you missed my comment earlier.

You need to write: sizeof(*data) :(

> +       if (!data)
> +               return -ENOMEM;
> +
> +       data->clk = of_clk_get(np, 0);
> +       data->parent = of_parse_phandle(np, "clocks", 0);
> +       if (!data->parent) {
> +               pr_err("%s: could not get clock information\n", __func__);
> +               goto err_nomem2;
> +       }
> +
> +       count = of_property_count_strings(data->parent, "clock-names");
> +
> +       table = kcalloc(count + 1,
> +                       sizeof(struct cpufreq_frequency_table), GFP_KERNEL);

sizeof(*table)

> +       if (!table) {
> +               pr_err("%s: no memory\n", __func__);
> +               goto err_nomem2;
> +       }
> +
> +       for (i = cpu; i < freq_data.cpus_per_cluster + cpu; i++)
> +               cpumask_set_cpu(i, policy->cpus);

I can see some regression here. Suppose you have two clusters of 4
cpus each: (0123) and (4567).. Now at boot time above code will work
perfectly fine. Now you hot unplug 0,1,2,3 and then hotplug 3 in.

Here, init would be called for cpu 3 and so you will end up saving 3456
in your policy->cpus

:)

> +       for (i = 0; i < count; i++) {
> +               table[i].index = i;
> +               clk = of_clk_get(data->parent, i);
> +               table[i].frequency = clk_get_rate(clk) / 1000;
> +       }
> +       freq_table_redup(table, count);
> +       table[i].frequency = CPUFREQ_TABLE_END;
> +
> +       data->table = table;
> +       per_cpu(cpu_data, cpu) = data;
> +
> +       policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
> +       policy->cur = corenet_cpufreq_get_speed(policy->cpu);
> +
> +       /* set the min and max frequency properly */
> +       i = cpufreq_frequency_table_cpuinfo(policy, table);

i doesn't suit here, use variable like ret or err..
And move this just after the line where you set freq as TABLE_END.
So that you don't execute unnecessary code for error case.

> +static int corenet_cpufreq_verify(struct cpufreq_policy *policy)
> +{
> +       struct cpufreq_frequency_table *table;
> +
> +       table = per_cpu(cpu_data, policy->cpu)->table;

merge above two lines.

> +       return cpufreq_frequency_table_verify(policy, table);
> +}
> +
> +static int corenet_cpufreq_target(struct cpufreq_policy *policy,
> +               unsigned int target_freq, unsigned int relation)
> +{
> +       struct cpufreq_freqs freqs;
> +       unsigned int new;
> +       struct clk *parent;
> +       int ret;
> +       struct cpu_data *data = per_cpu(cpu_data, policy->cpu);
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

You need to notify freq change for all cpus in this group :)

BUT you don't need to worry about it due to this:

http://patches.linaro.org/15569/

> +       parent = of_clk_get(data->parent, new);
> +       ret = clk_set_parent(data->clk, parent);
> +       if (ret) {
> +               mutex_unlock(&freq_data.cpufreq_lock);

Probably for error case too you need to notify others about completion
of freq change, but with old freq.

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

name it better, maybe corenet_cpufreq_attr ?

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
> +       freq_data.cpus_per_cluster = (unsigned long)match->data;
> +       mutex_init(&freq_data.cpufreq_lock);
> +       of_node_put(np);
> +
> +       ret = cpufreq_register_driver(&ppc_corenet_cpufreq_driver);
> +       if (ret)
> +               return ret;
> +
> +       pr_info("Freescale PowerPC corenet CPU frequency scaling driver\n");

Or write it as:

ret = cpufreq_register_driver();
if (!ret)
    pr_info();

return ret;

> +
> +       return ret;
> +}
> +module_init(ppc_corenet_cpufreq_init);
> +
> +static void __exit ppc_corenet_cpufreq_exit(void)
> +{
> +       cpufreq_unregister_driver(&ppc_corenet_cpufreq_driver);
> +}
> +module_exit(ppc_corenet_cpufreq_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Tang Yuantian <Yuantian.Tang@freescale.com>");
> +MODULE_DESCRIPTION("cpufreq driver for Freescale e500mc series SoCs");

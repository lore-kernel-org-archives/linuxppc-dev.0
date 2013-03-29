Return-Path: <viresh.kumar@linaro.org>
Received: from mail-ob0-x22f.google.com (mail-ob0-x22f.google.com
 [IPv6:2607:f8b0:4003:c01::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 503842C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2013 18:17:10 +1100 (EST)
Received: by mail-ob0-f175.google.com with SMTP id va7so215988obc.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2013 00:17:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1364536350-23788-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1364536350-23788-1-git-send-email-Yuantian.Tang@freescale.com>
Date: Fri, 29 Mar 2013 12:47:06 +0530
Message-ID: <CAKohpo=4ypXkE=VDBHOWnLHG_x2cbh7=OGA=87MEMLyNaTi=xg@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: Add cpufreq driver for Freescale e500mc SoCs
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

On 29 March 2013 11:22,  <Yuantian.Tang@freescale.com> wrote:
> diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
> +

Add following here for better debug prints (sorry, i should have done
it earlier)

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

> +#include <linux/clk.h>
> +#include <linux/cpu.h>
> +#include <linux/cpufreq.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +

> +static unsigned int    cpus_per_cluster;

remove tab with space after int.

> +static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{
> +       struct device_node *np;
> +       int i, count, ret;
> +       struct clk *clk;
> +       struct cpufreq_frequency_table *table;
> +       struct cpu_data *data;
> +       unsigned int cpu = policy->cpu;
> +
> +       np = of_get_cpu_node(cpu, NULL);
> +       if (!np)
> +               return -ENODEV;
> +
> +       data = kzalloc(sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       data->clk = of_clk_get(np, 0);

what if this fails?

> +       /* align the cpu id with cluster if any */
> +       i = (cpu / cpus_per_cluster) * cpus_per_cluster;
> +       for (count = 0; count < cpus_per_cluster; count++)
> +               cpumask_set_cpu(i + count, policy->cpus);

Better than before but i still see some regression with it :)

What if cpu order in DT is changed a bit and so cpus boot with following
order: 0 1 3 5 7 2 6 4

And so you will end up grouping 0135 and 7264 :)

See if topology_core_cpumask() gives you correct pairs.

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
> +       mutex_lock(&cpufreq_lock);
> +       cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);

What i wanted here from you was:

	for_each_cpu(freqs.cpu, policy->cpus)
		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);

Which would be fixed later by my patch, but until then you must have correct
code in your driver. What if my patchset is rejected :)

Mostly good now. Probably V4 would be the last one :)

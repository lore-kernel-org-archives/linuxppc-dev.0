Return-Path: <viresh.linux@gmail.com>
Received: from mail-ve0-x231.google.com (mail-ve0-x231.google.com
 [IPv6:2607:f8b0:400c:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C617C2C00A8
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 19:41:35 +1100 (EST)
Received: by mail-ve0-f177.google.com with SMTP id sa20so2207596veb.36
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 01:41:32 -0700 (PDT)
MIME-Version: 1.0
Sender: viresh.linux@gmail.com
In-Reply-To: <1395317460-14811-2-git-send-email-ego@linux.vnet.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-2-git-send-email-ego@linux.vnet.ibm.com>
Date: Fri, 21 Mar 2014 14:11:32 +0530
Message-ID: <CAOh2x=kp65vrKamtxxR9iCX+t-S3nDJP05+1mfpOiWzbWpfGYA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] powernv: cpufreq driver for powernv platform
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PM list <linux-pm@vger.kernel.org>, linuxppc-dev@ozlabs.org,
 Anton Blanchard <anton@samba.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 20, 2014 at 5:40 PM, Gautham R. Shenoy
<ego@linux.vnet.ibm.com> wrote:
> From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

Hi Vaidy,

> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 4b029c0..4ba1632 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -48,6 +48,7 @@ config CPU_FREQ_STAT_DETAILS
>  choice
>         prompt "Default CPUFreq governor"
>         default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1100_CPUFREQ || ARM_SA1110_CPUFREQ
> +       default CPU_FREQ_DEFAULT_GOV_ONDEMAND if POWERNV_CPUFREQ

Probably we should remove SA1100's entry as well from here. This is
not the right way of doing it. Imagine 100 platforms having entries here.
If you want it, then select it from your platforms Kconfig.

> diff --git a/drivers/cpufreq/Kconfig.powerpc b/drivers/cpufreq/Kconfig.powerpc
> index ca0021a..93f8689 100644
> --- a/drivers/cpufreq/Kconfig.powerpc
> +++ b/drivers/cpufreq/Kconfig.powerpc
> @@ -54,3 +54,16 @@ config PPC_PASEMI_CPUFREQ
>         help
>           This adds the support for frequency switching on PA Semi
>           PWRficient processors.
> +
> +config POWERNV_CPUFREQ
> +       tristate "CPU frequency scaling for IBM POWERNV platform"
> +       depends on PPC_POWERNV
> +       select CPU_FREQ_GOV_PERFORMANCE
> +       select CPU_FREQ_GOV_POWERSAVE
> +       select CPU_FREQ_GOV_USERSPACE
> +       select CPU_FREQ_GOV_ONDEMAND
> +       select CPU_FREQ_GOV_CONSERVATIVE

Nice :)

People normally do this from the defconfigs instead. And logically speaking
we might better have only dependencies here, isn't it? And obviously
governors aren't a dependency for this driver. :)

> +       default y
> +       help
> +        This adds support for CPU frequency switching on IBM POWERNV
> +        platform

> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> new file mode 100644
> index 0000000..ab1551f
> --- /dev/null
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -0,0 +1,277 @@
> +/*
> + * POWERNV cpufreq driver for the IBM POWER processors
> + *
> + * (C) Copyright IBM 2014
> + *
> + * Author: Vaidyanathan Srinivasan <svaidy at linux.vnet.ibm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2, or (at your option)
> + * any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#define pr_fmt(fmt)    "powernv-cpufreq: " fmt
> +
> +#include <linux/module.h>
> +#include <linux/cpufreq.h>
> +#include <linux/of.h>
> +#include <asm/cputhreads.h>

That's it? Sure?

Even if things compile for you, you must explicitly include all the
files on which
you depend.

> +/* FIXME: Make this per-core */
> +static DEFINE_MUTEX(freq_switch_mutex);
> +
> +#define POWERNV_MAX_PSTATES    256
> +
> +static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
> +static int powernv_pstate_ids[POWERNV_MAX_PSTATES+1];
> +
> +/*
> + * Initialize the freq table based on data obtained
> + * from the firmware passed via device-tree
> + */
> +
> +static int init_powernv_pstates(void)
> +{
> +       struct device_node *power_mgt;
> +       int nr_pstates = 0;
> +       int pstate_min, pstate_max, pstate_nominal;
> +       const __be32 *pstate_ids, *pstate_freqs;
> +       int i;
> +       u32 len_ids, len_freqs;
> +
> +       power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
> +       if (!power_mgt) {
> +               pr_warn("power-mgt node not found\n");
> +               return -ENODEV;
> +       }
> +
> +       if (of_property_read_u32(power_mgt, "ibm,pstate-min", &pstate_min)) {
> +               pr_warn("ibm,pstate-min node not found\n");
> +               return -ENODEV;
> +       }
> +
> +       if (of_property_read_u32(power_mgt, "ibm,pstate-max", &pstate_max)) {
> +               pr_warn("ibm,pstate-max node not found\n");
> +               return -ENODEV;
> +       }
> +
> +       if (of_property_read_u32(power_mgt, "ibm,pstate-nominal",
> +                                &pstate_nominal)) {
> +               pr_warn("ibm,pstate-nominal not found\n");
> +               return -ENODEV;
> +       }
> +       pr_info("cpufreq pstate min %d nominal %d max %d\n", pstate_min,
> +               pstate_nominal, pstate_max);
> +
> +       pstate_ids = of_get_property(power_mgt, "ibm,pstate-ids", &len_ids);
> +       if (!pstate_ids) {
> +               pr_warn("ibm,pstate-ids not found\n");
> +               return -ENODEV;
> +       }
> +
> +       pstate_freqs = of_get_property(power_mgt, "ibm,pstate-frequencies-mhz",
> +                                     &len_freqs);
> +       if (!pstate_freqs) {
> +               pr_warn("ibm,pstate-frequencies-mhz not found\n");
> +               return -ENODEV;
> +       }
> +
> +       WARN_ON(len_ids != len_freqs);
> +       nr_pstates = min(len_ids, len_freqs) / sizeof(u32);
> +       WARN_ON(!nr_pstates);

Why do you want to continue here?

> +       pr_debug("NR PStates %d\n", nr_pstates);
> +       for (i = 0; i < nr_pstates; i++) {
> +               u32 id = be32_to_cpu(pstate_ids[i]);
> +               u32 freq = be32_to_cpu(pstate_freqs[i]);
> +
> +               pr_debug("PState id %d freq %d MHz\n", id, freq);
> +               powernv_freqs[i].driver_data = i;

I don't think you are using this field at all and this is the field you can
use for driver_data and so you can get rid of powernv_pstate_ids[ ].

> +               powernv_freqs[i].frequency = freq * 1000; /* kHz */
> +               powernv_pstate_ids[i] = id;
> +       }
> +       /* End of list marker entry */
> +       powernv_freqs[i].driver_data = 0;

Not required.

> +       powernv_freqs[i].frequency = CPUFREQ_TABLE_END;
> +
> +       /* Print frequency table */
> +       for (i = 0; powernv_freqs[i].frequency != CPUFREQ_TABLE_END; i++)
> +               pr_debug("%d: %d\n", i, powernv_freqs[i].frequency);

You have already printed this table earlier..

> +
> +       return 0;
> +}
> +
> +static struct freq_attr *powernv_cpu_freq_attr[] = {
> +       &cpufreq_freq_attr_scaling_available_freqs,
> +       NULL,
> +};

Can use this instead: cpufreq_generic_attr?

> +/* Helper routines */
> +
> +/* Access helpers to power mgt SPR */
> +
> +static inline unsigned long get_pmspr(unsigned long sprn)

Looks big enough not be inlined?

> +{
> +       switch (sprn) {
> +       case SPRN_PMCR:
> +               return mfspr(SPRN_PMCR);
> +
> +       case SPRN_PMICR:
> +               return mfspr(SPRN_PMICR);
> +
> +       case SPRN_PMSR:
> +               return mfspr(SPRN_PMSR);
> +       }
> +       BUG();
> +}
> +
> +static inline void set_pmspr(unsigned long sprn, unsigned long val)
> +{

Same here..

> +       switch (sprn) {
> +       case SPRN_PMCR:
> +               mtspr(SPRN_PMCR, val);
> +               return;
> +
> +       case SPRN_PMICR:
> +               mtspr(SPRN_PMICR, val);
> +               return;
> +
> +       case SPRN_PMSR:
> +               mtspr(SPRN_PMSR, val);
> +               return;
> +       }
> +       BUG();
> +}
> +
> +static void set_pstate(void *pstate)
> +{
> +       unsigned long val;
> +       unsigned long pstate_ul = *(unsigned long *) pstate;

Why not sending value only to this routine instead of pointer?

> +
> +       val = get_pmspr(SPRN_PMCR);
> +       val = val & 0x0000ffffffffffffULL;

Maybe a blank line here?

> +       /* Set both global(bits 56..63) and local(bits 48..55) PStates */
> +       val = val | (pstate_ul << 56) | (pstate_ul << 48);

here as well?

> +       pr_debug("Setting cpu %d pmcr to %016lX\n", smp_processor_id(), val);
> +       set_pmspr(SPRN_PMCR, val);
> +}
> +
> +static int powernv_set_freq(cpumask_var_t cpus, unsigned int new_index)
> +{
> +       unsigned long val = (unsigned long) powernv_pstate_ids[new_index];

I think automatic type conversion will happen here.

> +
> +       /*
> +        * Use smp_call_function to send IPI and execute the
> +        * mtspr on target cpu.  We could do that without IPI
> +        * if current CPU is within policy->cpus (core)
> +        */

Hmm, interesting I also feel there are cases where this routine can
get called from other CPUs. Can you list those use cases where it can
happen? Governors will mostly call this from one of the CPUs present
in policy->cpus.

> +       val = val & 0xFF;
> +       smp_call_function_any(cpus, set_pstate, &val, 1);
> +       return 0;
> +}
> +
> +static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{
> +       int base, i;
> +
> +#ifdef CONFIG_SMP

What will break if you don't have this ifdef here? Without that as well
below code should work?

> +       base = cpu_first_thread_sibling(policy->cpu);
> +
> +       for (i = 0; i < threads_per_core; i++)
> +               cpumask_set_cpu(base + i, policy->cpus);
> +#endif
> +       policy->cpuinfo.transition_latency = 25000;
> +
> +       policy->cur = powernv_freqs[0].frequency;
> +       cpufreq_frequency_table_get_attr(powernv_freqs, policy->cpu);

This doesn't exist anymore.

> +       return cpufreq_frequency_table_cpuinfo(policy, powernv_freqs);

Have you written this driver long time back? CPUFreq core has been
cleaned up heavily since last few kernel releases and I think there are
better helper routines available now.

> +}
> +
> +static int powernv_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> +{
> +       cpufreq_frequency_table_put_attr(policy->cpu);
> +       return 0;
> +}

You don't need this..

> +static int powernv_cpufreq_verify(struct cpufreq_policy *policy)
> +{
> +       return cpufreq_frequency_table_verify(policy, powernv_freqs);
> +}

use generic verify function pointer instead..

> +static int powernv_cpufreq_target(struct cpufreq_policy *policy,
> +                             unsigned int target_freq,
> +                             unsigned int relation)

use target_index() instead..

> +{
> +       int rc;
> +       struct cpufreq_freqs freqs;
> +       unsigned int new_index;
> +
> +       cpufreq_frequency_table_target(policy, powernv_freqs, target_freq,
> +                                      relation, &new_index);
> +
> +       freqs.old = policy->cur;
> +       freqs.new = powernv_freqs[new_index].frequency;
> +       freqs.cpu = policy->cpu;
> +
> +       mutex_lock(&freq_switch_mutex);

Why do you need this lock for?

> +       cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
> +
> +       pr_debug("setting frequency for cpu %d to %d kHz index %d pstate %d",
> +                policy->cpu,
> +                powernv_freqs[new_index].frequency,
> +                new_index,
> +                powernv_pstate_ids[new_index]);
> +
> +       rc = powernv_set_freq(policy->cpus, new_index);
> +
> +       cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
> +       mutex_unlock(&freq_switch_mutex);
> +
> +       return rc;
> +}
> +
> +static struct cpufreq_driver powernv_cpufreq_driver = {
> +       .verify         = powernv_cpufreq_verify,
> +       .target         = powernv_cpufreq_target,

I think you have Srivatsa there who has seen lots of cpufreq code and
could have helped you a lot :)

> +       .init           = powernv_cpufreq_cpu_init,
> +       .exit           = powernv_cpufreq_cpu_exit,
> +       .name           = "powernv-cpufreq",
> +       .flags          = CPUFREQ_CONST_LOOPS,
> +       .attr           = powernv_cpu_freq_attr,

Would be better if you keep these callbacks in the order they are declared
in cpufreq.h..

> +};
> +
> +static int __init powernv_cpufreq_init(void)
> +{
> +       int rc = 0;
> +
> +       /* Discover pstates from device tree and init */
> +

Remove blank line.

> +       rc = init_powernv_pstates();
> +

same here..

> +       if (rc) {
> +               pr_info("powernv-cpufreq disabled\n");
> +               return rc;
> +       }
> +
> +       rc = cpufreq_register_driver(&powernv_cpufreq_driver);
> +       return rc;

Merge above two lines.

> +}
> +
> +static void __exit powernv_cpufreq_exit(void)
> +{
> +       cpufreq_unregister_driver(&powernv_cpufreq_driver);
> +}
> +
> +module_init(powernv_cpufreq_init);
> +module_exit(powernv_cpufreq_exit);

Place these right after the routines without any blank lines in between.

> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Vaidyanathan Srinivasan <svaidy at linux.vnet.ibm.com>");

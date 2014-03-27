Return-Path: <viresh.kumar@linaro.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5CCA914008C
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 17:39:56 +1100 (EST)
Received: by mail-ob0-f179.google.com with SMTP id va2so3781647obc.24
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2014 23:39:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1395852947-22290-2-git-send-email-ego@linux.vnet.ibm.com>
References: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395852947-22290-2-git-send-email-ego@linux.vnet.ibm.com>
Date: Thu, 27 Mar 2014 12:09:53 +0530
Message-ID: <CAKohponPb+b=8Pa=te3CkiN6QPAUAukngqLSdG4vxc9pUkD8OQ@mail.gmail.com>
Subject: Re: [PATCH v4] powernv, cpufreq: cpufreq driver for powernv platform
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PM list <linux-pm@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
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

Cc'ing Rafael.

On 26 March 2014 22:25, Gautham R. Shenoy <ego@linux.vnet.ibm.com> wrote:
> From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
>
> Backend driver to dynamically set voltage and frequency on
> IBM POWER non-virtualized platforms.  Power management SPRs
> are used to set the required PState.
>
> This driver works in conjunction with cpufreq governors
> like 'ondemand' to provide a demand based frequency and
> voltage setting on IBM POWER non-virtualized platforms.
>
> PState table is obtained from OPAL v3 firmware through device
> tree.
>
> powernv_cpufreq back-end driver would parse the relevant device-tree
> nodes and initialise the cpufreq subsystem on powernv platform.
>
> The code was originally written by svaidy@linux.vnet.ibm.com. Over
> time it was modified to accomodate bug-fixes as well as updates to the
> the cpu-freq core. Relevant portions of the change logs corresponding
> to those modifications are noted below:
>
>  * The policy->cpus needs to be populated in a hotplug-invariant
>    manner instead of using cpu_sibling_mask() which varies with
>    cpu-hotplug. This is because the cpufreq core code copies this
>    content into policy->related_cpus mask which is should not vary on

s/is /

>    cpu-hotplug. [Authored by srivatsa.bhat@linux.vnet.ibm.com]

:)

>  * On POWER systems, the CPU frequency is controlled at a core-level
>    and hence we need to serialize so that only one of the threads in
>    the core switches the core's frequency at a time. Introduce
>    per-core locking to enable finer-grained synchronization and
>    thereby enhance the speed and responsiveness of the cpufreq driver
>    to varying workload demands.
>
>      The design of per-core locking is very simple and
>    straight-forward: we first define a Per-CPU lock and use the ones
>    that belongs to the first thread sibling of the core.
>
>      cpu_first_thread_sibling() macro is used to find the *common*
>    lock for all thread siblings belonging to a core. [Authored by
>    srivatsa.bhat@linux.vnet.ibm.com]

We don't need that after serialization patch of core is accepted. And it
should be accepted soon, in one form or other.

>  * Create a helper routine that can return the cpu-frequency for the
>    corresponding pstate_id. Also, cache the values of the pstate_max,
>    pstate_min and pstate_nominal and nr_pstates in a static structure
>    so that they can be reused in the future to perform any
>    validations. [Authored by ego@linux.vnet.ibm.com]
>
>  * Create a driver attribute named cpuinfo_nominal_freq which creates
>    a sysfs read-only file named cpuinfo_nominal_freq. Export the
>    frequency corresponding to the nominal_pstate through this
>    interface.
>
>      Nominal frequency is the highest non-turbo frequency for the
>    platform.  This is generally used for setting governor policies
>    from user space for optimal energy efficiency. [Authored by
>    ego@linux.vnet.ibm.com]
>
>  * Implement a powernv_cpufreq_get(unsigned int cpu) method which will
>    return the current operating frequency. Export this via the sysfs
>    interface cpuinfo_cur_freq by setting powernv_cpufreq_driver.get to
>    powernv_cpufreq_get(). [Authored by ego@linux.vnet.ibm.com]
>
> [Change log updated by ego@linux.vnet.ibm.com]
>
> Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  arch/powerpc/configs/pseries_defconfig    |   1 +
>  arch/powerpc/configs/pseries_le_defconfig |   1 +
>  arch/powerpc/include/asm/reg.h            |   4 +
>  arch/powerpc/platforms/powernv/Kconfig    |   6 +
>  drivers/cpufreq/Kconfig.powerpc           |   8 +
>  drivers/cpufreq/Makefile                  |   1 +
>  drivers/cpufreq/powernv-cpufreq.c         | 372 ++++++++++++++++++++++++++++++
>  7 files changed, 393 insertions(+)
>  create mode 100644 drivers/cpufreq/powernv-cpufreq.c
>
> diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
> index e9a8b4e..a285d44 100644
> --- a/arch/powerpc/configs/pseries_defconfig
> +++ b/arch/powerpc/configs/pseries_defconfig
> @@ -353,3 +353,4 @@ CONFIG_CRYPTO_DEV_NX_ENCRYPT=m
>  CONFIG_VIRTUALIZATION=y
>  CONFIG_KVM_BOOK3S_64=m
>  CONFIG_KVM_BOOK3S_64_HV=y
> +CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
> diff --git a/arch/powerpc/configs/pseries_le_defconfig b/arch/powerpc/configs/pseries_le_defconfig
> index 62771e0..47e6161 100644
> --- a/arch/powerpc/configs/pseries_le_defconfig
> +++ b/arch/powerpc/configs/pseries_le_defconfig
> @@ -350,3 +350,4 @@ CONFIG_CRYPTO_LZO=m
>  # CONFIG_CRYPTO_ANSI_CPRNG is not set
>  CONFIG_CRYPTO_DEV_NX=y
>  CONFIG_CRYPTO_DEV_NX_ENCRYPT=m
> +CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y

don't know how Rafael want this, but probably this part could have gone
through ppc tree..

> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index 90c06ec..84f92ca 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -271,6 +271,10 @@
>  #define SPRN_HSRR1     0x13B   /* Hypervisor Save/Restore 1 */
>  #define SPRN_IC                0x350   /* Virtual Instruction Count */
>  #define SPRN_VTB       0x351   /* Virtual Time Base */
> +#define SPRN_PMICR     0x354   /* Power Management Idle Control Reg */
> +#define SPRN_PMSR      0x355   /* Power Management Status Reg */
> +#define SPRN_PMCR      0x374   /* Power Management Control Register */
> +
>  /* HFSCR and FSCR bit numbers are the same */
>  #define FSCR_TAR_LG    8       /* Enable Target Address Register */
>  #define FSCR_EBB_LG    7       /* Enable Event Based Branching */
> diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
> index 895e8a2..c252ee9 100644
> --- a/arch/powerpc/platforms/powernv/Kconfig
> +++ b/arch/powerpc/platforms/powernv/Kconfig
> @@ -11,6 +11,12 @@ config PPC_POWERNV
>         select PPC_UDBG_16550
>         select PPC_SCOM
>         select ARCH_RANDOM
> +       select CPU_FREQ
> +       select CPU_FREQ_GOV_PERFORMANCE
> +       select CPU_FREQ_GOV_POWERSAVE
> +       select CPU_FREQ_GOV_USERSPACE
> +       select CPU_FREQ_GOV_ONDEMAND
> +       select CPU_FREQ_GOV_CONSERVATIVE
>         default y
>
>  config PPC_POWERNV_RTAS
> diff --git a/drivers/cpufreq/Kconfig.powerpc b/drivers/cpufreq/Kconfig.powerpc
> index ca0021a..72564b7 100644
> --- a/drivers/cpufreq/Kconfig.powerpc
> +++ b/drivers/cpufreq/Kconfig.powerpc
> @@ -54,3 +54,11 @@ config PPC_PASEMI_CPUFREQ
>         help
>           This adds the support for frequency switching on PA Semi
>           PWRficient processors.
> +
> +config POWERNV_CPUFREQ
> +       tristate "CPU frequency scaling for IBM POWERNV platform"
> +       depends on PPC_POWERNV
> +       default y
> +       help
> +        This adds support for CPU frequency switching on IBM POWERNV
> +        platform
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 7494565..0dbb963 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -86,6 +86,7 @@ obj-$(CONFIG_PPC_CORENET_CPUFREQ)   += ppc-corenet-cpufreq.o
>  obj-$(CONFIG_CPU_FREQ_PMAC)            += pmac32-cpufreq.o
>  obj-$(CONFIG_CPU_FREQ_PMAC64)          += pmac64-cpufreq.o
>  obj-$(CONFIG_PPC_PASEMI_CPUFREQ)       += pasemi-cpufreq.o
> +obj-$(CONFIG_POWERNV_CPUFREQ)          += powernv-cpufreq.o
>
>  ##################################################################################
>  # Other platform drivers
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> new file mode 100644
> index 0000000..b35865b
> --- /dev/null
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -0,0 +1,372 @@
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
> +#include <linux/smp.h>
> +#include <linux/of.h>
> +#include <asm/cputhreads.h>

I thought I gave a comment on missing headers here?

> +/* Per-Core locking for frequency transitions */
> +static DEFINE_PER_CPU(struct mutex, freq_switch_lock);
> +
> +#define lock_core_freq(cpu)                            \
> +                       mutex_lock(&per_cpu(freq_switch_lock,\
> +                               cpu_first_thread_sibling(cpu)));
> +#define unlock_core_freq(cpu)                          \
> +                       mutex_unlock(&per_cpu(freq_switch_lock,\
> +                               cpu_first_thread_sibling(cpu)));
> +
> +#define POWERNV_MAX_PSTATES    256
> +
> +static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
> +static int powernv_pstate_ids[POWERNV_MAX_PSTATES+1];

I though we don't need this anymore? Either Rafael will take my patch as
is for the BOOST fixup or we will end up creating .isboost field in
struct cpufreq_frequency_table and so you could have used .driver_data here.

> +struct powernv_pstate_info {
> +       int pstate_min_id;
> +       int pstate_max_id;
> +       int pstate_nominal_id;
> +       int nr_pstates;
> +};
> +static struct powernv_pstate_info powernv_pstate_info;

Maybe write it as this (if you like :), as this is the only instance
of this struct):

Also, because 'powernv_pstate_info' is a local variable we can get rid of
powerenv_ from its name and name it just pstate_info. That will make
code shorter at many places and you may not be required to break
lines into two at some places. If you wish :)

+static struct powernv_pstate_info {
+       int pstate_min_id;
+       int pstate_max_id;
+       int pstate_nominal_id;
+       int nr_pstates;
+} powernv_pstate_info;

> +/*
> + * Initialize the freq table based on data obtained
> + * from the firmware passed via device-tree
> + */
> +static int init_powernv_pstates(void)
> +{
> +       struct device_node *power_mgt;
> +       int nr_pstates = 0;
> +       int pstate_min, pstate_max, pstate_nominal;
> +       const __be32 *pstate_ids, *pstate_freqs;
> +       int i;

Can merge all the int definitions into a single line.

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

Why do you need to get these from DT? And not find that yourself here instead?

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
> +       if (!nr_pstates) {
> +               WARN_ON(1);
> +               return -ENODEV;
> +       }

Maybe like this:

+       if (WARN_ON(!nr_pstates))
+               return -ENODEV;

> +       pr_debug("NR PStates %d\n", nr_pstates);
> +       for (i = 0; i < nr_pstates; i++) {
> +               u32 id = be32_to_cpu(pstate_ids[i]);
> +               u32 freq = be32_to_cpu(pstate_freqs[i]);
> +
> +               pr_debug("PState id %d freq %d MHz\n", id, freq);
> +               powernv_freqs[i].driver_data = i;

Looks like more than one comments aren't addressed :(
You can use this field for your id. And even if you couldn't have
done that, you don't need to initialize this field at all..

> +               powernv_freqs[i].frequency = freq * 1000; /* kHz */
> +               powernv_pstate_ids[i] = id;
> +       }
> +       /* End of list marker entry */
> +       powernv_freqs[i].frequency = CPUFREQ_TABLE_END;
> +
> +       powernv_pstate_info.pstate_min_id = pstate_min;
> +       powernv_pstate_info.pstate_max_id = pstate_max;
> +       powernv_pstate_info.pstate_nominal_id = pstate_nominal;
> +       powernv_pstate_info.nr_pstates = nr_pstates;
> +
> +       return 0;
> +}
> +
> +/*
> + * Returns the cpu frequency corresponding to the pstate_id.
> + */

Maybe:

+/* Returns the cpu frequency corresponding to the pstate_id. */

> +static unsigned int pstate_id_to_freq(int pstate_id)
> +{
> +       int i;
> +
> +       i = powernv_pstate_info.pstate_max_id - pstate_id;

It looks like these ids would always be contiguous? In that case
it would be better if you can mention this property at the top of this
file in some comment. So, that new people can understand things
quickly.

> +       BUG_ON(i >= powernv_pstate_info.nr_pstates || i < 0);
> +       WARN_ON(powernv_pstate_ids[i] != pstate_id);

Do you really want it? We have already confirmed that 'i' is
within limits.

> +       return powernv_freqs[i].frequency;
> +}
> +
> +/*
> + * cpuinfo_nominal_freq_show - Show the nominal CPU frequency as indicated by
> + * the firmware
> + */
> +static ssize_t cpuinfo_nominal_freq_show(struct cpufreq_policy *policy,
> +                                       char *buf)
> +{
> +       return sprintf(buf, "%u\n",
> +               pstate_id_to_freq(powernv_pstate_info.pstate_nominal_id));
> +}
> +
> +struct freq_attr cpufreq_freq_attr_cpuinfo_nominal_freq =
> +       __ATTR_RO(cpuinfo_nominal_freq);
> +
> +static struct freq_attr *powernv_cpu_freq_attr[] = {
> +       &cpufreq_freq_attr_scaling_available_freqs,
> +       &cpufreq_freq_attr_cpuinfo_nominal_freq,
> +       NULL,
> +};
> +
> +/* Helper routines */
> +
> +/* Access helpers to power mgt SPR */
> +
> +static inline unsigned long get_pmspr(unsigned long sprn)
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
> +/*
> + * Use objects of this type to query/update
> + * pstates on a remote cpu via smp_call_function.
> + */
> +struct powernv_smp_call_data {
> +       unsigned int freq;
> +       int pstate_id;
> +};
> +
> +/*
> + * powernv_read_cpu_freq: Reads the current frequency on this cpu.
> + *
> + * Called via smp_call_function.
> + *
> + * Note: The caller of the smp_call_function should pass an argument of
> + * the type 'struct powernv_smp_call_data *' along with this function.
> + *
> + * The current frequency on this cpu will be returned via
> + * ((struct powernv_smp_call_data *)arg)->freq;
> + */
> +static void powernv_read_cpu_freq(void *arg)
> +{
> +       unsigned long pmspr_val;
> +       s8 local_pstate_id;
> +        struct powernv_smp_call_data *freq_data;
> +
> +       freq_data = (struct powernv_smp_call_data *)arg;

don't need casting here ?

> +
> +       pmspr_val = get_pmspr(SPRN_PMSR);
> +
> +       /*
> +         * The local pstate id corresponds bits 48..55 in the PMSR.
> +         * Note: Watch out for the sign!
> +         */
> +       local_pstate_id = (pmspr_val >> 48) & 0xFF;
> +       freq_data->pstate_id = local_pstate_id;
> +       freq_data->freq = pstate_id_to_freq(freq_data->pstate_id);
> +
> +       pr_debug("cpu %d pmsr %lx pstate_id %d frequency %d kHz \n",
> +               smp_processor_id(), pmspr_val, freq_data->pstate_id,

s/smp_processor_id/raw_smp_processor_id ?

> +               freq_data->freq);
> +}
> +
> +/*
> + * powernv_cpufreq_get: Returns the cpu frequency as reported by the
> + * firmware for 'cpu'. This value is reported through the sysfs file
> + * cpuinfo_cur_freq.
> + */
> +unsigned int powernv_cpufreq_get(unsigned int cpu)
> +{
> +       struct powernv_smp_call_data freq_data;
> +
> +       smp_call_function_any(cpu_sibling_mask(cpu), powernv_read_cpu_freq,
> +                       &freq_data, 1);
> +
> +       return freq_data.freq;
> +}
> +
> +/*
> + * set_pstate: Sets the frequency on this cpu.
> + *
> + * This is called via an smp_call_function.
> + *
> + * The caller must ensure that freq_data is of the type
> + * (struct powernv_smp_call_data *) and the pstate_id which needs to be set
> + * on this cpu should be present in freq_data->pstate_id.
> + */
> +static void set_pstate(void *freq_data)
> +{
> +       unsigned long val;
> +       unsigned long pstate_ul =
> +               ((struct powernv_smp_call_data *) freq_data)->pstate_id;
> +
> +       val = get_pmspr(SPRN_PMCR);
> +       val = val & 0x0000ffffffffffffULL;
> +
> +       pstate_ul = pstate_ul & 0xFF;
> +
> +       /* Set both global(bits 56..63) and local(bits 48..55) PStates */
> +       val = val | (pstate_ul << 56) | (pstate_ul << 48);
> +
> +       pr_debug("Setting cpu %d pmcr to %016lX\n", smp_processor_id(), val);

s/smp_processor_id/raw_smp_processor_id ? At other places as well.

> +       set_pmspr(SPRN_PMCR, val);
> +}
> +
> +/*
> + * powernv_set_freq: Sets the frequency corresponding to the cpufreq
> + * table entry indexed by new_index on the cpus in the mask 'cpus'

Rafael doesn't like CPUs to be written as cpus.. I got this comment long
back :) (Applicable only for comments and logs)

> + */
> +static int powernv_set_freq(cpumask_var_t cpus, unsigned int new_index)

Why do you want to keep this routine separately? Why not have a single routine
powernv_cpufreq_target_index() ?

> +{
> +       struct powernv_smp_call_data freq_data;
> +
> +       freq_data.pstate_id = powernv_pstate_ids[new_index];
> +
> +       /*
> +        * Use smp_call_function to send IPI and execute the
> +        * mtspr on target cpu.  We could do that without IPI
> +        * if current CPU is within policy->cpus (core)
> +        */
> +       smp_call_function_any(cpus, set_pstate, &freq_data, 1);

Not sure how smp_call_function_any() behaves but wouldn't it be
a good optimization if you can check if raw_smp_processor_id()
returns one of the CPUs from 'cpus'? And in that case don't
shoot an IPI.

Same for the get part as well.

But then I looked at the implementation of these routines and found
they already have this optimization in :) .. But with overhead of few
locks and disable_preempt() :(

> +       return 0;
> +}
> +
> +static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{
> +       int base, i;
> +
> +       base = cpu_first_thread_sibling(policy->cpu);
> +
> +       for (i = 0; i < threads_per_core; i++)
> +               cpumask_set_cpu(base + i, policy->cpus);
> +
> +       policy->cpuinfo.transition_latency = 25000;
> +       policy->cur = powernv_freqs[0].frequency;

How can you be so sure? Also clock is doing this just after calling init()
and so you can just remove it :)

> +       return cpufreq_table_validate_and_show(policy, powernv_freqs);
> +}
> +
> +static int powernv_cpufreq_verify(struct cpufreq_policy *policy)
> +{
> +       return cpufreq_generic_frequency_table_verify(policy);
> +}
> +
> +static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
> +                                       unsigned int new_index)
> +{
> +       int rc;
> +
> +       lock_core_freq(policy->cpu);
> +       rc = powernv_set_freq(policy->cpus, new_index);
> +       unlock_core_freq(policy->cpu);
> +
> +       return rc;
> +}
> +
> +static struct cpufreq_driver powernv_cpufreq_driver = {
> +       .name           = "powernv-cpufreq",
> +       .flags          = CPUFREQ_CONST_LOOPS,
> +       .init           = powernv_cpufreq_cpu_init,
> +       .verify         = powernv_cpufreq_verify,

Can do this instead:
+       .verify         = cpufreq_generic_frequency_table_verify,

> +       .target_index   = powernv_cpufreq_target_index,
> +       .get            = powernv_cpufreq_get,
> +       .attr           = powernv_cpu_freq_attr,
> +};
> +
> +static int __init powernv_cpufreq_init(void)
> +{
> +       int cpu, rc = 0;
> +
> +       /* Discover pstates from device tree and init */
> +       rc = init_powernv_pstates();
> +       if (rc) {
> +               pr_info("powernv-cpufreq disabled\n");
> +               return rc;
> +       }
> +
> +       /* Init per-core mutex */
> +       for_each_possible_cpu(cpu)
> +               mutex_init(&per_cpu(freq_switch_lock, cpu));
> +
> +       return cpufreq_register_driver(&powernv_cpufreq_driver);
> +}
> +module_init(powernv_cpufreq_init);
> +
> +static void __exit powernv_cpufreq_exit(void)
> +{
> +       cpufreq_unregister_driver(&powernv_cpufreq_driver);
> +}
> +module_exit(powernv_cpufreq_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Vaidyanathan Srinivasan <svaidy at linux.vnet.ibm.com>");

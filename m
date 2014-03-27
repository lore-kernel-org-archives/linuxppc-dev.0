Return-Path: <ego@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AEA7314008C
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 20:31:06 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 27 Mar 2014 05:31:01 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id BA7A738C8027
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 05:30:58 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2R9UwR562980316
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 09:30:58 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2R9UvbU016394
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 05:30:58 -0400
Date: Thu, 27 Mar 2014 15:00:50 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4] powernv, cpufreq: cpufreq driver for powernv platform
Message-ID: <20140327093050.GA27777@in.ibm.com>
References: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395852947-22290-2-git-send-email-ego@linux.vnet.ibm.com>
 <CAKohponPb+b=8Pa=te3CkiN6QPAUAukngqLSdG4vxc9pUkD8OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKohponPb+b=8Pa=te3CkiN6QPAUAukngqLSdG4vxc9pUkD8OQ@mail.gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Linux PM list <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Anton Blanchard <anton@samba.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 27, 2014 at 12:09:53PM +0530, Viresh Kumar wrote:
> Cc'ing Rafael.
>

Thanks. It was a lapse on my part by not Cc'ing Rafael in the first
place.
 
> On 26 March 2014 22:25, Gautham R. Shenoy <ego@linux.vnet.ibm.com> wrote:
> > From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> >
> > Backend driver to dynamically set voltage and frequency on
> > IBM POWER non-virtualized platforms.  Power management SPRs
> > are used to set the required PState.
> >
> > This driver works in conjunction with cpufreq governors
> > like 'ondemand' to provide a demand based frequency and
> > voltage setting on IBM POWER non-virtualized platforms.
> >
> > PState table is obtained from OPAL v3 firmware through device
> > tree.
> >
> > powernv_cpufreq back-end driver would parse the relevant device-tree
> > nodes and initialise the cpufreq subsystem on powernv platform.
> >
> > The code was originally written by svaidy@linux.vnet.ibm.com. Over
> > time it was modified to accomodate bug-fixes as well as updates to the
> > the cpu-freq core. Relevant portions of the change logs corresponding
> > to those modifications are noted below:
> >
> >  * The policy->cpus needs to be populated in a hotplug-invariant
> >    manner instead of using cpu_sibling_mask() which varies with
> >    cpu-hotplug. This is because the cpufreq core code copies this
> >    content into policy->related_cpus mask which is should not vary on
> 
> s/is /

Good catch! Will fix this

[...]
> 
> >  * On POWER systems, the CPU frequency is controlled at a core-level
> >    and hence we need to serialize so that only one of the threads in
> >    the core switches the core's frequency at a time. Introduce
> >    per-core locking to enable finer-grained synchronization and
> >    thereby enhance the speed and responsiveness of the cpufreq driver
> >    to varying workload demands.
> >
> >      The design of per-core locking is very simple and
> >    straight-forward: we first define a Per-CPU lock and use the ones
> >    that belongs to the first thread sibling of the core.
> >
> >      cpu_first_thread_sibling() macro is used to find the *common*
> >    lock for all thread siblings belonging to a core. [Authored by
> >    srivatsa.bhat@linux.vnet.ibm.com]
> 
> We don't need that after serialization patch of core is accepted. And it
> should be accepted soon, in one form or other.

As of now, I prefer this patch be based on code that is in the -next
tree. I'll get rid of the per-core locking once the serialization
patch of the core is accepted.

[...]
> > --- a/arch/powerpc/configs/pseries_defconfig
> > +++ b/arch/powerpc/configs/pseries_defconfig
> > @@ -353,3 +353,4 @@ CONFIG_CRYPTO_DEV_NX_ENCRYPT=m
> >  CONFIG_VIRTUALIZATION=y
> >  CONFIG_KVM_BOOK3S_64=m
> >  CONFIG_KVM_BOOK3S_64_HV=y
> > +CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
> > diff --git a/arch/powerpc/configs/pseries_le_defconfig b/arch/powerpc/configs/pseries_le_defconfig
> > index 62771e0..47e6161 100644
> > --- a/arch/powerpc/configs/pseries_le_defconfig
> > +++ b/arch/powerpc/configs/pseries_le_defconfig
> > @@ -350,3 +350,4 @@ CONFIG_CRYPTO_LZO=m
> >  # CONFIG_CRYPTO_ANSI_CPRNG is not set
> >  CONFIG_CRYPTO_DEV_NX=y
> >  CONFIG_CRYPTO_DEV_NX_ENCRYPT=m
> > +CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
> 
> don't know how Rafael want this, but probably this part could have gone
> through ppc tree..
> 

That would mean multiple patches :-)

> > +
> > +#define pr_fmt(fmt)    "powernv-cpufreq: " fmt
> > +
> > +#include <linux/module.h>
> > +#include <linux/cpufreq.h>
> > +#include <linux/smp.h>
> > +#include <linux/of.h>
> > +#include <asm/cputhreads.h>
> 
> I thought I gave a comment on missing headers here?

Ok, so these seem to be the missing ones.

#include <linux/kernel.h>
#include <linux/percpu-defs.h>
#include <linux/mutex.h>
#include <linux/sysfs.h>
#include <linux/cpumask.h>

#include <asm/reg.h>

Have I missed anything else ?


> > +static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
> > +static int powernv_pstate_ids[POWERNV_MAX_PSTATES+1];
> 
> I though we don't need this anymore? Either Rafael will take my patch as
> is for the BOOST fixup or we will end up creating .isboost field in
> struct cpufreq_frequency_table and so you could have used .driver_data here.
> 

I mentioned in my reply to your BOOST fixup patch that we would like
pstate_ids to be of the type "signed int", while the .driver_data is
an "unsigned int". If we end up using .driver_data, we would have to
be careful and not use it directly but reassign it to a signed int (or
typecast it) before using it.

Not just that, the pr_debugs in the core which are printed during
frequency transitions will then end up printing large positive values
(since it will interpret negative pstate_ids as unsigned int) in the
place of pstate_ids, which would not be particularly useful.

> > +struct powernv_pstate_info {
> > +       int pstate_min_id;
> > +       int pstate_max_id;
> > +       int pstate_nominal_id;
> > +       int nr_pstates;
> > +};
> > +static struct powernv_pstate_info powernv_pstate_info;
> 
> Maybe write it as this (if you like :), as this is the only instance
> of this struct):
> 
> Also, because 'powernv_pstate_info' is a local variable we can get rid of
> powerenv_ from its name and name it just pstate_info. That will make
> code shorter at many places and you may not be required to break
> lines into two at some places. If you wish :)
> 
Ok fair enough!

> +static struct powernv_pstate_info {
> +       int pstate_min_id;
> +       int pstate_max_id;
> +       int pstate_nominal_id;
> +       int nr_pstates;
> +} powernv_pstate_info;
> 
> > +/*
> > + * Initialize the freq table based on data obtained
> > + * from the firmware passed via device-tree
> > + */
> > +static int init_powernv_pstates(void)
> > +{
> > +       struct device_node *power_mgt;
> > +       int nr_pstates = 0;
> > +       int pstate_min, pstate_max, pstate_nominal;
> > +       const __be32 *pstate_ids, *pstate_freqs;
> > +       int i;
> 
> Can merge all the int definitions into a single line.

Too many ints to be incorporated in a single line. But will see if I
can beautify it :-) 

> > +       u32 len_ids, len_freqs;
> > +
> > +       power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
> > +       if (!power_mgt) {
> > +               pr_warn("power-mgt node not found\n");
> > +               return -ENODEV;
> > +       }
> > +
> > +       if (of_property_read_u32(power_mgt, "ibm,pstate-min", &pstate_min)) {
> > +               pr_warn("ibm,pstate-min node not found\n");
> > +               return -ENODEV;
> > +       }
> > +
> > +       if (of_property_read_u32(power_mgt, "ibm,pstate-max", &pstate_max)) {
> > +               pr_warn("ibm,pstate-max node not found\n");
> > +               return -ENODEV;
> > +       }
> 
> Why do you need to get these from DT? And not find that yourself here instead?
>

Well, I think we can obtain a more accurate value from the DT which
would have already computed it. But I'll let vaidy answer this.

> > +       if (of_property_read_u32(power_mgt, "ibm,pstate-nominal",
> > +                                &pstate_nominal)) {
> > +               pr_warn("ibm,pstate-nominal not found\n");
> > +               return -ENODEV;
> > +       }
> > +       pr_info("cpufreq pstate min %d nominal %d max %d\n", pstate_min,
> > +               pstate_nominal, pstate_max);
> > +
> > +       pstate_ids = of_get_property(power_mgt, "ibm,pstate-ids", &len_ids);
> > +       if (!pstate_ids) {
> > +               pr_warn("ibm,pstate-ids not found\n");
> > +               return -ENODEV;
> > +       }
> > +
> > +       pstate_freqs = of_get_property(power_mgt, "ibm,pstate-frequencies-mhz",
> > +                                     &len_freqs);
> > +       if (!pstate_freqs) {
> > +               pr_warn("ibm,pstate-frequencies-mhz not found\n");
> > +               return -ENODEV;
> > +       }
> > +
> > +       WARN_ON(len_ids != len_freqs);
> > +       nr_pstates = min(len_ids, len_freqs) / sizeof(u32);
> > +       if (!nr_pstates) {
> > +               WARN_ON(1);
> > +               return -ENODEV;
> > +       }
> 
> Maybe like this:
> 
> +       if (WARN_ON(!nr_pstates))
> +               return -ENODEV;
> 

Thanks. This looks better.

> > +       pr_debug("NR PStates %d\n", nr_pstates);
> > +       for (i = 0; i < nr_pstates; i++) {
> > +               u32 id = be32_to_cpu(pstate_ids[i]);
> > +               u32 freq = be32_to_cpu(pstate_freqs[i]);
> > +
> > +               pr_debug("PState id %d freq %d MHz\n", id, freq);
> > +               powernv_freqs[i].driver_data = i;
> 
> Looks like more than one comments aren't addressed :(
> You can use this field for your id. And even if you couldn't have
> done that, you don't need to initialize this field at all..


Ok, since we are better off not using it, we shouldn't be initializing
it.

> 
> > +               powernv_freqs[i].frequency = freq * 1000; /* kHz */
> > +               powernv_pstate_ids[i] = id;
> > +       }
> > +       /* End of list marker entry */
> > +       powernv_freqs[i].frequency = CPUFREQ_TABLE_END;
> > +
> > +       powernv_pstate_info.pstate_min_id = pstate_min;
> > +       powernv_pstate_info.pstate_max_id = pstate_max;
> > +       powernv_pstate_info.pstate_nominal_id = pstate_nominal;
> > +       powernv_pstate_info.nr_pstates = nr_pstates;
> > +
> > +       return 0;
> > +}
> > +
> > +/*
> > + * Returns the cpu frequency corresponding to the pstate_id.
> > + */
> 
> Maybe:
> 
> +/* Returns the cpu frequency corresponding to the pstate_id. */
> 

Right, single line comment! Will fix this.

> > +static unsigned int pstate_id_to_freq(int pstate_id)
> > +{
> > +       int i;
> > +
> > +       i = powernv_pstate_info.pstate_max_id - pstate_id;
> 
> It looks like these ids would always be contiguous? In that case
> it would be better if you can mention this property at the top of this
> file in some comment. So, that new people can understand things
> quickly.
> 

Ok.

> > +       BUG_ON(i >= powernv_pstate_info.nr_pstates || i < 0);
> > +       WARN_ON(powernv_pstate_ids[i] != pstate_id);
> 
> Do you really want it? We have already confirmed that 'i' is
> within limits.

"i" might be within limits. But I want to make sure that the pstate_id
corresponding to "i" is the same as the pstate_id that we
requested. Not that anything would have changed since the
initialization, but I get paranoid about these things from time to
time :-)

> 
> > +       return powernv_freqs[i].frequency;
> > +}
> > +

[...]

> > +
> > +/*
> > + * powernv_read_cpu_freq: Reads the current frequency on this cpu.
> > + *
> > + * Called via smp_call_function.
> > + *
> > + * Note: The caller of the smp_call_function should pass an argument of
> > + * the type 'struct powernv_smp_call_data *' along with this function.
> > + *
> > + * The current frequency on this cpu will be returned via
> > + * ((struct powernv_smp_call_data *)arg)->freq;
> > + */
> > +static void powernv_read_cpu_freq(void *arg)
> > +{
> > +       unsigned long pmspr_val;
> > +       s8 local_pstate_id;
> > +        struct powernv_smp_call_data *freq_data;
> > +
> > +       freq_data = (struct powernv_smp_call_data *)arg;
> 
> don't need casting here ?

Doesn't harm having it there. Just like the #includes :-)

> 
> > +
> > +       pmspr_val = get_pmspr(SPRN_PMSR);
> > +
> > +       /*
> > +         * The local pstate id corresponds bits 48..55 in the PMSR.
> > +         * Note: Watch out for the sign!
> > +         */
> > +       local_pstate_id = (pmspr_val >> 48) & 0xFF;
> > +       freq_data->pstate_id = local_pstate_id;
> > +       freq_data->freq = pstate_id_to_freq(freq_data->pstate_id);
> > +
> > +       pr_debug("cpu %d pmsr %lx pstate_id %d frequency %d kHz \n",
> > +               smp_processor_id(), pmspr_val, freq_data->pstate_id,
> 
> s/smp_processor_id/raw_smp_processor_id ?

No. This function is called via smp_call_function(). So we have
preempt_disable on and it is safe to use smp_processor_id.

> 
> > +               freq_data->freq);
> > +}

[...]
> > +/*
> > + * set_pstate: Sets the frequency on this cpu.
> > + *
> > + * This is called via an smp_call_function.
> > + *
> > + * The caller must ensure that freq_data is of the type
> > + * (struct powernv_smp_call_data *) and the pstate_id which needs to be set
> > + * on this cpu should be present in freq_data->pstate_id.
> > + */
> > +static void set_pstate(void *freq_data)
> > +{
> > +       unsigned long val;
> > +       unsigned long pstate_ul =
> > +               ((struct powernv_smp_call_data *) freq_data)->pstate_id;
> > +
> > +       val = get_pmspr(SPRN_PMCR);
> > +       val = val & 0x0000ffffffffffffULL;
> > +
> > +       pstate_ul = pstate_ul & 0xFF;
> > +
> > +       /* Set both global(bits 56..63) and local(bits 48..55) PStates */
> > +       val = val | (pstate_ul << 56) | (pstate_ul << 48);
> > +
> > +       pr_debug("Setting cpu %d pmcr to %016lX\n", smp_processor_id(), val);
> 
> s/smp_processor_id/raw_smp_processor_id ? At other places as well.

Even this function is called via smp_call_function(). So, we should
have preempt disabled.

> 
> > +       set_pmspr(SPRN_PMCR, val);
> > +}
> > +
> > +/*
> > + * powernv_set_freq: Sets the frequency corresponding to the cpufreq
> > + * table entry indexed by new_index on the cpus in the mask 'cpus'
> 
> Rafael doesn't like CPUs to be written as cpus.. I got this comment long
> back :) (Applicable only for comments and logs)

Ah, ok. Will fix this.

> 
> > + */
> > +static int powernv_set_freq(cpumask_var_t cpus, unsigned int new_index)
> 
> Why do you want to keep this routine separately? Why not have a single routine
> powernv_cpufreq_target_index() ?
> 
> > +{
> > +       struct powernv_smp_call_data freq_data;
> > +
> > +       freq_data.pstate_id = powernv_pstate_ids[new_index];
> > +
> > +       /*
> > +        * Use smp_call_function to send IPI and execute the
> > +        * mtspr on target cpu.  We could do that without IPI
> > +        * if current CPU is within policy->cpus (core)
> > +        */
> > +       smp_call_function_any(cpus, set_pstate, &freq_data, 1);
> 
> Not sure how smp_call_function_any() behaves but wouldn't it be
> a good optimization if you can check if raw_smp_processor_id()
> returns one of the CPUs from 'cpus'? And in that case don't
> shoot an IPI.

That's what smp_call_function_any() does.

> 
> Same for the get part as well.
> 
> But then I looked at the implementation of these routines and found
> they already have this optimization in :) .. But with overhead of few
> locks and disable_preempt() :(
> 

Well, locks are taken when we are not running on this_cpu() so that we
can issue an IPI (or use some other optimized communication mechanism)
for executing set_pstate on one of the cpus in cpus. So this overhead
should be acceptable.

On the other hand if we are running on this_cpu(), we simply go ahead
and execute call which is what you're suggesting we do.

> > +}
> > +
> > +static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
> > +{
> > +       int base, i;
> > +
> > +       base = cpu_first_thread_sibling(policy->cpu);
> > +
> > +       for (i = 0; i < threads_per_core; i++)
> > +               cpumask_set_cpu(base + i, policy->cpus);
> > +
> > +       policy->cpuinfo.transition_latency = 25000;
> > +       policy->cur = powernv_freqs[0].frequency;
> 
> How can you be so sure? Also clock is doing this just after calling init()
> and so you can just remove it :)

You mean s/clock/core ? 

You're right, the core sets policy->cur by invoking driver->get()
which in our case will read it from the PMSR and initialize it with
the correct value. So these lines can be removed.

> 
> > +       return cpufreq_table_validate_and_show(policy, powernv_freqs);
> > +}
> > +
> > +static int powernv_cpufreq_verify(struct cpufreq_policy *policy)
> > +{
> > +       return cpufreq_generic_frequency_table_verify(policy);
> > +}
> > +
> > +static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
> > +                                       unsigned int new_index)
> > +{
> > +       int rc;
> > +
> > +       lock_core_freq(policy->cpu);
> > +       rc = powernv_set_freq(policy->cpus, new_index);
> > +       unlock_core_freq(policy->cpu);
> > +
> > +       return rc;
> > +}
> > +
> > +static struct cpufreq_driver powernv_cpufreq_driver = {
> > +       .name           = "powernv-cpufreq",
> > +       .flags          = CPUFREQ_CONST_LOOPS,
> > +       .init           = powernv_cpufreq_cpu_init,
> > +       .verify         = powernv_cpufreq_verify,
> 
> Can do this instead:
> +       .verify         = cpufreq_generic_frequency_table_verify,

Ok. 

> 

Thanks for a detailed review again.

I'll send out the updated patch today incorporating the comments. It
shouldn't be hard since most of the comments do not affect the
functionality.

--
Thanks and Regards
gautham.

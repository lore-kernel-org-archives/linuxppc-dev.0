Return-Path: <ego@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 636932C00B2
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 21:43:38 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 21 Mar 2014 06:43:35 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 441EA38C8027
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 06:43:33 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2LAhXXf9109856
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 10:43:33 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2LAhWJf030781
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 06:43:33 -0400
Date: Fri, 21 Mar 2014 16:13:17 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/5] powernv: cpufreq driver for powernv platform
Message-ID: <20140321104317.GA2493@in.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-2-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x=kp65vrKamtxxR9iCX+t-S3nDJP05+1mfpOiWzbWpfGYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOh2x=kp65vrKamtxxR9iCX+t-S3nDJP05+1mfpOiWzbWpfGYA@mail.gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Linux PM list <linux-pm@vger.kernel.org>, linuxppc-dev@ozlabs.org,
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

Hi Viresh,

On Fri, Mar 21, 2014 at 02:11:32PM +0530, Viresh Kumar wrote:
> On Thu, Mar 20, 2014 at 5:40 PM, Gautham R. Shenoy
> <ego@linux.vnet.ibm.com> wrote:
> > From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> 
> Hi Vaidy,
> 
> > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> > index 4b029c0..4ba1632 100644
> > --- a/drivers/cpufreq/Kconfig
> > +++ b/drivers/cpufreq/Kconfig
> > @@ -48,6 +48,7 @@ config CPU_FREQ_STAT_DETAILS
> >  choice
> >         prompt "Default CPUFreq governor"
> >         default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1100_CPUFREQ || ARM_SA1110_CPUFREQ
> > +       default CPU_FREQ_DEFAULT_GOV_ONDEMAND if POWERNV_CPUFREQ
> 
> Probably we should remove SA1100's entry as well from here. This is
> not the right way of doing it. Imagine 100 platforms having entries here.
> If you want it, then select it from your platforms Kconfig.

Sure. Will move these bits and the other governor related bits to the
Powernv Kconfig.

> > diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> > new file mode 100644
> > index 0000000..ab1551f
> > --- /dev/null
> > +
> > +#define pr_fmt(fmt)    "powernv-cpufreq: " fmt
> > +
> > +#include <linux/module.h>
> > +#include <linux/cpufreq.h>
> > +#include <linux/of.h>
> > +#include <asm/cputhreads.h>
> 
> That's it? Sure?
> 
> Even if things compile for you, you must explicitly include all the
> files on which
> you depend.

Ok. 

> 
> > +
> > +       WARN_ON(len_ids != len_freqs);
> > +       nr_pstates = min(len_ids, len_freqs) / sizeof(u32);
> > +       WARN_ON(!nr_pstates);
> 
> Why do you want to continue here?

Good point. We might be better off exiting at this point. 

> 
> > +       pr_debug("NR PStates %d\n", nr_pstates);
> > +       for (i = 0; i < nr_pstates; i++) {
> > +               u32 id = be32_to_cpu(pstate_ids[i]);
> > +               u32 freq = be32_to_cpu(pstate_freqs[i]);
> > +
> > +               pr_debug("PState id %d freq %d MHz\n", id, freq);
> > +               powernv_freqs[i].driver_data = i;
> 
> I don't think you are using this field at all and this is the field you can
> use for driver_data and so you can get rid of powernv_pstate_ids[ ].

Using driver_data to record powernv_pstate_ids won't work since
powernv_pstate_ids can be negative. So a pstate_id -3 can be confused
with CPUFREQ_BOOST_FREQ thereby not displaying the frequency
corresponding to pstate id -3. So for now I think we will be retaining
powernv_pstate_ids.

> 
> > +               powernv_freqs[i].frequency = freq * 1000; /* kHz */
> > +               powernv_pstate_ids[i] = id;
> > +       }
> > +       /* End of list marker entry */
> > +       powernv_freqs[i].driver_data = 0;
> 
> Not required.

Ok.
> 
> > +       powernv_freqs[i].frequency = CPUFREQ_TABLE_END;
> > +
> > +       /* Print frequency table */
> > +       for (i = 0; powernv_freqs[i].frequency != CPUFREQ_TABLE_END; i++)
> > +               pr_debug("%d: %d\n", i, powernv_freqs[i].frequency);
> 
> You have already printed this table earlier..

Fair enough.

> 
> > +
> > +       return 0;
> > +}
> > +
> > +static struct freq_attr *powernv_cpu_freq_attr[] = {
> > +       &cpufreq_freq_attr_scaling_available_freqs,
> > +       NULL,
> > +};
> 
> Can use this instead: cpufreq_generic_attr?

In this patch yes. But later patch introduces an additional attribute
for displaying the nominal frequency. Will handle that part in a clean
way in the next version.

> 
> > +/* Helper routines */
> > +
> > +/* Access helpers to power mgt SPR */
> > +
> > +static inline unsigned long get_pmspr(unsigned long sprn)
> 
> Looks big enough not be inlined?

It is called from one function. It has been defined separately for
readability. 

> 
> > +{
> > +       switch (sprn) {
> > +       case SPRN_PMCR:
> > +               return mfspr(SPRN_PMCR);
> > +
> > +       case SPRN_PMICR:
> > +               return mfspr(SPRN_PMICR);
> > +
> > +       case SPRN_PMSR:
> > +               return mfspr(SPRN_PMSR);
> > +       }
> > +       BUG();
> > +}
> > +
> > +static inline void set_pmspr(unsigned long sprn, unsigned long val)
> > +{
> 
> Same here..

Same reason as above.

> 
> > +       switch (sprn) {
> > +       case SPRN_PMCR:
> > +               mtspr(SPRN_PMCR, val);
> > +               return;
> > +
> > +       case SPRN_PMICR:
> > +               mtspr(SPRN_PMICR, val);
> > +               return;
> > +
> > +       case SPRN_PMSR:
> > +               mtspr(SPRN_PMSR, val);
> > +               return;
> > +       }
> > +       BUG();
> > +}
> > +
> > +static void set_pstate(void *pstate)
> > +{
> > +       unsigned long val;
> > +       unsigned long pstate_ul = *(unsigned long *) pstate;
> 
> Why not sending value only to this routine instead of pointer?

Well this function is called via an smp_call_function. so, cannot send
a value :(

> 
> > +
> > +       val = get_pmspr(SPRN_PMCR);
> > +       val = val & 0x0000ffffffffffffULL;
> 
> Maybe a blank line here?

Ok.

> 
> > +       /* Set both global(bits 56..63) and local(bits 48..55) PStates */
> > +       val = val | (pstate_ul << 56) | (pstate_ul << 48);
> 
> here as well?

Ok.
> 

> > +       pr_debug("Setting cpu %d pmcr to %016lX\n", smp_processor_id(), val);
> > +       set_pmspr(SPRN_PMCR, val);
> > +}
> > +
> > +static int powernv_set_freq(cpumask_var_t cpus, unsigned int new_index)
> > +{
> > +       unsigned long val = (unsigned long) powernv_pstate_ids[new_index];
> 
> I think automatic type conversion will happen here.

Ok. Will fix this.

> 
> > +
> > +       /*
> > +        * Use smp_call_function to send IPI and execute the
> > +        * mtspr on target cpu.  We could do that without IPI
> > +        * if current CPU is within policy->cpus (core)
> > +        */
> 
> Hmm, interesting I also feel there are cases where this routine can
> get called from other CPUs. Can you list those use cases where it can
> happen? Governors will mostly call this from one of the CPUs present
> in policy->cpus.

Consider the case when the governor is userspace and we are executing 

    # echo freqvalue  > 
         /sys/devices/system/cpu/cpu<i>/cpufreq/scaling_setspeed 

from a cpu <j> which is not in policy->cpus of cpu i. 


> > +static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
> > +{
> > +       int base, i;
> > +
> > +#ifdef CONFIG_SMP
> 
> What will break if you don't have this ifdef here? Without that as well
> below code should work?
> 
> > +       base = cpu_first_thread_sibling(policy->cpu);
> > +
> > +       for (i = 0; i < threads_per_core; i++)
> > +               cpumask_set_cpu(base + i, policy->cpus);
> > +#endif
> > +       policy->cpuinfo.transition_latency = 25000;
> > +
> > +       policy->cur = powernv_freqs[0].frequency;
> > +       cpufreq_frequency_table_get_attr(powernv_freqs, policy->cpu);
> 
> This doesn't exist anymore.

Didn't get this comment!

> 
> > +       return cpufreq_frequency_table_cpuinfo(policy, powernv_freqs);
> 
> Have you written this driver long time back? CPUFreq core has been
> cleaned up heavily since last few kernel releases and I think there are
> better helper routines available now.

Yup it was written quite a while ago. And yeah, CPUFreq has changed
quite a bit since the last time I saw it :-)

> 
> > +}
> > +
> > +static int powernv_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> > +{
> > +       cpufreq_frequency_table_put_attr(policy->cpu);
> > +       return 0;
> > +}
> 
> You don't need this..

Why not ?

> 
> > +static int powernv_cpufreq_verify(struct cpufreq_policy *policy)
> > +{
> > +       return cpufreq_frequency_table_verify(policy, powernv_freqs);
> > +}
> 
> use generic verify function pointer instead..
> 
> > +static int powernv_cpufreq_target(struct cpufreq_policy *policy,
> > +                             unsigned int target_freq,
> > +                             unsigned int relation)
> 
> use target_index() instead..
> 
> > +{
> > +       int rc;
> > +       struct cpufreq_freqs freqs;
> > +       unsigned int new_index;
> > +
> > +       cpufreq_frequency_table_target(policy, powernv_freqs, target_freq,
> > +                                      relation, &new_index);
> > +
> > +       freqs.old = policy->cur;
> > +       freqs.new = powernv_freqs[new_index].frequency;
> > +       freqs.cpu = policy->cpu;
> > +
> > +       mutex_lock(&freq_switch_mutex);
> 
> Why do you need this lock for?

I guess it was to serialize accesses to PMCR. But Srivatsa's patch
converts this to a per-core lock which probably is no longer required
after your cpufreq_freq_transition_begin/end() patch series.

> 
> > +       cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
> > +
> > +       pr_debug("setting frequency for cpu %d to %d kHz index %d pstate %d",
> > +                policy->cpu,
> > +                powernv_freqs[new_index].frequency,
> > +                new_index,
> > +                powernv_pstate_ids[new_index]);
> > +
> > +       rc = powernv_set_freq(policy->cpus, new_index);
> > +
> > +       cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
> > +       mutex_unlock(&freq_switch_mutex);
> > +
> > +       return rc;
> > +}
> > +
> > +static struct cpufreq_driver powernv_cpufreq_driver = {
> > +       .verify         = powernv_cpufreq_verify,
> > +       .target         = powernv_cpufreq_target,
> 
> I think you have Srivatsa there who has seen lots of cpufreq code and
> could have helped you a lot :)
> 
> > +       .init           = powernv_cpufreq_cpu_init,
> > +       .exit           = powernv_cpufreq_cpu_exit,
> > +       .name           = "powernv-cpufreq",
> > +       .flags          = CPUFREQ_CONST_LOOPS,
> > +       .attr           = powernv_cpu_freq_attr,
> 
> Would be better if you keep these callbacks in the order they are declared
> in cpufreq.h..

Sure.

> 
> > +module_init(powernv_cpufreq_init);
> > +module_exit(powernv_cpufreq_exit);
> 
> Place these right after the routines without any blank lines in
between.

Is this the new convention ?

> 
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Vaidyanathan Srinivasan <svaidy at linux.vnet.ibm.com>");
> 

Thanks for the detailed review.

--
Regards
gautham.

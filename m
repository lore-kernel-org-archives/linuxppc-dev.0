Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BAB2F2C0091
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2014 01:48:31 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Sat, 22 Mar 2014 00:48:31 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 310373578054
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2014 01:48:29 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2LESF5P50069706
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2014 01:28:16 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2LEmRfS025596
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2014 01:48:28 +1100
Date: Fri, 21 Mar 2014 20:18:18 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/5] powernv: cpufreq driver for powernv platform
Message-ID: <20140321144818.GA30371@dirshya.in.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-2-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x=kp65vrKamtxxR9iCX+t-S3nDJP05+1mfpOiWzbWpfGYA@mail.gmail.com>
 <20140321104317.GA2493@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20140321104317.GA2493@in.ibm.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linuxppc-dev@ozlabs.org,
 Anton Blanchard <anton@samba.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Reply-To: svaidy@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Gautham R Shenoy <ego@linux.vnet.ibm.com> [2014-03-21 16:13:17]:

> Hi Viresh,
> 
> On Fri, Mar 21, 2014 at 02:11:32PM +0530, Viresh Kumar wrote:
> > On Thu, Mar 20, 2014 at 5:40 PM, Gautham R. Shenoy
> > <ego@linux.vnet.ibm.com> wrote:
> > > From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> > 
> > Hi Vaidy,
> > 

Hi Viresh,

Thanks for the detailed review.

> > > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> > > index 4b029c0..4ba1632 100644
> > > --- a/drivers/cpufreq/Kconfig
> > > +++ b/drivers/cpufreq/Kconfig
> > > @@ -48,6 +48,7 @@ config CPU_FREQ_STAT_DETAILS
> > >  choice
> > >         prompt "Default CPUFreq governor"
> > >         default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1100_CPUFREQ || ARM_SA1110_CPUFREQ
> > > +       default CPU_FREQ_DEFAULT_GOV_ONDEMAND if POWERNV_CPUFREQ
> > 
> > Probably we should remove SA1100's entry as well from here. This is
> > not the right way of doing it. Imagine 100 platforms having entries here.
> > If you want it, then select it from your platforms Kconfig.
> 
> Sure. Will move these bits and the other governor related bits to the
> Powernv Kconfig.
> 
> > > diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> > > new file mode 100644
> > > index 0000000..ab1551f
> > > --- /dev/null
> > > +
> > > +#define pr_fmt(fmt)    "powernv-cpufreq: " fmt
> > > +
> > > +#include <linux/module.h>
> > > +#include <linux/cpufreq.h>
> > > +#include <linux/of.h>
> > > +#include <asm/cputhreads.h>
> > 
> > That's it? Sure?
> > 
> > Even if things compile for you, you must explicitly include all the
> > files on which
> > you depend.
> 
> Ok. 
> 
> > 
> > > +
> > > +       WARN_ON(len_ids != len_freqs);
> > > +       nr_pstates = min(len_ids, len_freqs) / sizeof(u32);
> > > +       WARN_ON(!nr_pstates);
> > 
> > Why do you want to continue here?
> 
> Good point. We might be better off exiting at this point. 

Yes, we could return here.  We do not generally come till this point
if the platform has a problem discovering PStates from device tree.
But there is no useful debug info after this point if nr_pstates is 0.

> > 
> > > +       pr_debug("NR PStates %d\n", nr_pstates);
> > > +       for (i = 0; i < nr_pstates; i++) {
> > > +               u32 id = be32_to_cpu(pstate_ids[i]);
> > > +               u32 freq = be32_to_cpu(pstate_freqs[i]);
> > > +
> > > +               pr_debug("PState id %d freq %d MHz\n", id, freq);
> > > +               powernv_freqs[i].driver_data = i;
> > 
> > I don't think you are using this field at all and this is the field you can
> > use for driver_data and so you can get rid of powernv_pstate_ids[ ].
> 
> Using driver_data to record powernv_pstate_ids won't work since
> powernv_pstate_ids can be negative. So a pstate_id -3 can be confused
> with CPUFREQ_BOOST_FREQ thereby not displaying the frequency
> corresponding to pstate id -3. So for now I think we will be retaining
> powernv_pstate_ids.

Yeah, I had the driver written using driver_data to store pstates.
Gautham found the bug that we are missing one PState when we match the
ID with CPUFREQ_BOOST_FREQ!

We did not know that you have taken care of those issues.  Ideally
I did expect that driver_data should not be touched by the framework.
Thanks for fixing that and allowing the back-end driver to use
driver_data.
 
> > 
> > > +               powernv_freqs[i].frequency = freq * 1000; /* kHz */
> > > +               powernv_pstate_ids[i] = id;
> > > +       }
> > > +       /* End of list marker entry */
> > > +       powernv_freqs[i].driver_data = 0;
> > 
> > Not required.
> 
> Ok.
> > 
> > > +       powernv_freqs[i].frequency = CPUFREQ_TABLE_END;
> > > +
> > > +       /* Print frequency table */
> > > +       for (i = 0; powernv_freqs[i].frequency != CPUFREQ_TABLE_END; i++)
> > > +               pr_debug("%d: %d\n", i, powernv_freqs[i].frequency);
> > 
> > You have already printed this table earlier..
> 
> Fair enough.
> 
> > 
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static struct freq_attr *powernv_cpu_freq_attr[] = {
> > > +       &cpufreq_freq_attr_scaling_available_freqs,
> > > +       NULL,
> > > +};
> > 
> > Can use this instead: cpufreq_generic_attr?
> 
> In this patch yes. But later patch introduces an additional attribute
> for displaying the nominal frequency. Will handle that part in a clean
> way in the next version.
> 
> > 
> > > +/* Helper routines */
> > > +
> > > +/* Access helpers to power mgt SPR */
> > > +
> > > +static inline unsigned long get_pmspr(unsigned long sprn)
> > 
> > Looks big enough not be inlined?
> 
> It is called from one function. It has been defined separately for
> readability. 

Let the compiler decide.  The code is straight forward :)

I wanted to keep this SPR operations in a separate function to
facilitate debug and also introduce any timing/sequence change here if
required.  Keeping this separate is helpful, if inlining is
successful, we get a bonus :)

> > 
> > > +{
> > > +       switch (sprn) {
> > > +       case SPRN_PMCR:
> > > +               return mfspr(SPRN_PMCR);
> > > +
> > > +       case SPRN_PMICR:
> > > +               return mfspr(SPRN_PMICR);
> > > +
> > > +       case SPRN_PMSR:
> > > +               return mfspr(SPRN_PMSR);
> > > +       }
> > > +       BUG();
> > > +}
> > > +
> > > +static inline void set_pmspr(unsigned long sprn, unsigned long val)
> > > +{
> > 
> > Same here..
> 
> Same reason as above.
> 
> > 
> > > +       switch (sprn) {
> > > +       case SPRN_PMCR:
> > > +               mtspr(SPRN_PMCR, val);
> > > +               return;
> > > +
> > > +       case SPRN_PMICR:
> > > +               mtspr(SPRN_PMICR, val);
> > > +               return;
> > > +
> > > +       case SPRN_PMSR:
> > > +               mtspr(SPRN_PMSR, val);
> > > +               return;
> > > +       }
> > > +       BUG();
> > > +}
> > > +
> > > +static void set_pstate(void *pstate)
> > > +{
> > > +       unsigned long val;
> > > +       unsigned long pstate_ul = *(unsigned long *) pstate;
> > 
> > Why not sending value only to this routine instead of pointer?
> 
> Well this function is called via an smp_call_function. so, cannot send
> a value :(
> 
> > 
> > > +
> > > +       val = get_pmspr(SPRN_PMCR);
> > > +       val = val & 0x0000ffffffffffffULL;
> > 
> > Maybe a blank line here?
> 
> Ok.
> 
> > 
> > > +       /* Set both global(bits 56..63) and local(bits 48..55) PStates */
> > > +       val = val | (pstate_ul << 56) | (pstate_ul << 48);
> > 
> > here as well?
> 
> Ok.
> > 
> 
> > > +       pr_debug("Setting cpu %d pmcr to %016lX\n", smp_processor_id(), val);
> > > +       set_pmspr(SPRN_PMCR, val);
> > > +}
> > > +
> > > +static int powernv_set_freq(cpumask_var_t cpus, unsigned int new_index)
> > > +{
> > > +       unsigned long val = (unsigned long) powernv_pstate_ids[new_index];
> > 
> > I think automatic type conversion will happen here.
> 
> Ok. Will fix this.

Most of the conversions are verbose mainly to help readability of the
required sign-extensions.  There is scope to make these concise.

> > 
> > > +
> > > +       /*
> > > +        * Use smp_call_function to send IPI and execute the
> > > +        * mtspr on target cpu.  We could do that without IPI
> > > +        * if current CPU is within policy->cpus (core)
> > > +        */
> > 
> > Hmm, interesting I also feel there are cases where this routine can
> > get called from other CPUs. Can you list those use cases where it can
> > happen? Governors will mostly call this from one of the CPUs present
> > in policy->cpus.
> 
> Consider the case when the governor is userspace and we are executing 
> 
>     # echo freqvalue  > 
>          /sys/devices/system/cpu/cpu<i>/cpufreq/scaling_setspeed 
> 
> from a cpu <j> which is not in policy->cpus of cpu i. 
> 
> 
> > > +static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
> > > +{
> > > +       int base, i;
> > > +
> > > +#ifdef CONFIG_SMP
> > 
> > What will break if you don't have this ifdef here? Without that as well
> > below code should work?
> > 
> > > +       base = cpu_first_thread_sibling(policy->cpu);
> > > +
> > > +       for (i = 0; i < threads_per_core; i++)
> > > +               cpumask_set_cpu(base + i, policy->cpus);
> > > +#endif
> > > +       policy->cpuinfo.transition_latency = 25000;
> > > +
> > > +       policy->cur = powernv_freqs[0].frequency;
> > > +       cpufreq_frequency_table_get_attr(powernv_freqs, policy->cpu);
> > 
> > This doesn't exist anymore.
> 
> Didn't get this comment!
> 
> > 
> > > +       return cpufreq_frequency_table_cpuinfo(policy, powernv_freqs);
> > 
> > Have you written this driver long time back? CPUFreq core has been
> > cleaned up heavily since last few kernel releases and I think there are
> > better helper routines available now.
> 
> Yup it was written quite a while ago. And yeah, CPUFreq has changed
> quite a bit since the last time I saw it :-)

Yes, the driver is more than a year old and based on even older
implementation that I had written.  I kept up until I got a compiler
warning or functional issue.  Definitely could not catch-up with your
cleanups :)

> > 
> > > +}
> > > +
> > > +static int powernv_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> > > +{
> > > +       cpufreq_frequency_table_put_attr(policy->cpu);
> > > +       return 0;
> > > +}
> > 
> > You don't need this..
> 
> Why not ?
> 
> > 
> > > +static int powernv_cpufreq_verify(struct cpufreq_policy *policy)
> > > +{
> > > +       return cpufreq_frequency_table_verify(policy, powernv_freqs);
> > > +}
> > 
> > use generic verify function pointer instead..
> > 
> > > +static int powernv_cpufreq_target(struct cpufreq_policy *policy,
> > > +                             unsigned int target_freq,
> > > +                             unsigned int relation)
> > 
> > use target_index() instead..
> > 
> > > +{
> > > +       int rc;
> > > +       struct cpufreq_freqs freqs;
> > > +       unsigned int new_index;
> > > +
> > > +       cpufreq_frequency_table_target(policy, powernv_freqs, target_freq,
> > > +                                      relation, &new_index);
> > > +
> > > +       freqs.old = policy->cur;
> > > +       freqs.new = powernv_freqs[new_index].frequency;
> > > +       freqs.cpu = policy->cpu;
> > > +
> > > +       mutex_lock(&freq_switch_mutex);
> > 
> > Why do you need this lock for?
> 
> I guess it was to serialize accesses to PMCR. But Srivatsa's patch
> converts this to a per-core lock which probably is no longer required
> after your cpufreq_freq_transition_begin/end() patch series.

Right.  Frequency transitions are per-core, the h/w SPRs are per-core.
We need to prevent threads from colliding on h/w SPR access.  We do
make the lock per-core later in the series as mentioned above.

Gautham has addressed most comments.

Thanks,
Vaidy

Return-Path: <ego@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40BDF140087
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 22:20:44 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 27 Mar 2014 05:20:41 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 14B0D19D8039
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 05:20:36 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2RBK4sc64815236
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 12:20:04 +0100
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2RBKdGt000911
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 05:20:39 -0600
Date: Thu, 27 Mar 2014 16:50:32 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4] powernv, cpufreq: cpufreq driver for powernv platform
Message-ID: <20140327112031.GC27777@in.ibm.com>
References: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395852947-22290-2-git-send-email-ego@linux.vnet.ibm.com>
 <CAKohponPb+b=8Pa=te3CkiN6QPAUAukngqLSdG4vxc9pUkD8OQ@mail.gmail.com>
 <20140327093050.GA27777@in.ibm.com>
 <CAKohponOe9Au+pe5u9FpddW3+f5pegZB953+5fmYBDusE9j0HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKohponOe9Au+pe5u9FpddW3+f5pegZB953+5fmYBDusE9j0HA@mail.gmail.com>
Cc: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>,
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

On Thu, Mar 27, 2014 at 03:29:36PM +0530, Viresh Kumar wrote:
> On 27 March 2014 15:00, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> > As of now, I prefer this patch be based on code that is in the -next
> > tree. I'll get rid of the per-core locking once the serialization
> > patch of the core is accepted.
> 
> Okay.. Then divide this patch into two parts, second one doing all
> the serialization stuff and I will review only the first one from V5 :)
> 
> Maybe mention that in Patch2 as well, that once serialization patches
> are accepted, its not required.

Sure. This would be a good idea.

> 
> >> don't know how Rafael want this, but probably this part could have gone
> >> through ppc tree..
> >
> > That would mean multiple patches :-)
> 
> I wasn't opposed to multiple patches at all, but multiple patches for
> basic functionality of same driver file. Otherwise separating things
> into patches is the best receipe.

Fair enough!

> 
> >> > +#define pr_fmt(fmt)    "powernv-cpufreq: " fmt
> >> > +
> >> > +#include <linux/module.h>
> >> > +#include <linux/cpufreq.h>
> >> > +#include <linux/smp.h>
> >> > +#include <linux/of.h>
> >> > +#include <asm/cputhreads.h>
> >>
> >> I thought I gave a comment on missing headers here?
> >
> > Ok, so these seem to be the missing ones.
> >
> > #include <linux/kernel.h>
> > #include <linux/percpu-defs.h>
> > #include <linux/mutex.h>
> 
> This may shift to Patch 2 ..

Ok.

> 
> > #include <linux/sysfs.h>
> > #include <linux/cpumask.h>
> >
> > #include <asm/reg.h>
> >
> > Have I missed anything else ?
> 
> Not sure :) .. I will see if I can find anymore..
>

Cool.
 
> >> > +static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
> >> > +static int powernv_pstate_ids[POWERNV_MAX_PSTATES+1];
> >>
> >> I though we don't need this anymore? Either Rafael will take my patch as
> >> is for the BOOST fixup or we will end up creating .isboost field in
> >> struct cpufreq_frequency_table and so you could have used .driver_data here.
> >>
> >
> > I mentioned in my reply to your BOOST fixup patch that we would like
> > pstate_ids to be of the type "signed int", while the .driver_data is
> > an "unsigned int". If we end up using .driver_data, we would have to
> > be careful and not use it directly but reassign it to a signed int (or
> > typecast it) before using it.
> 
> Probably many people would want it to be unsigned it, so that they
> can put some strange hex values there..
> 
> Which part of your code conflicts with this right now? I can see only
> this line in powernv_set_freq()

I am not denying the advantage of storing pstate_ids in .driver_data
since we will then have all the information in one place.
(That said, in the future if we want to export additional
information, say pertaining to the voltage, we will have to keep a
separate array anyway :-) )

However, as of now, I am wary about reusing a variable provided by
the core, whose type is fixed (which is not the type I am interested
in) and whose interpretation is ambiguous (since it is also being used
as a BOOST indicator).

When we have a .is_boost field, or a flags field in the cpufreq_table,
and once the .driver_data field is completely opaque, I would be
comfortable making use of .driver_data to store the pstate_ids. So
I'll send out those patches once the fixes are present in the
core. For now, let this code stay as it is. I think we should be ok
with the additional overhead of 1kb as of now.

> 
> freq_data.pstate_id = powernv_pstate_ids[new_index];
> 
> And I don't think we will have side effects here.
> 
> > Not just that, the pr_debugs in the core which are printed during
> > frequency transitions will then end up printing large positive values
> > (since it will interpret negative pstate_ids as unsigned int) in the
> > place of pstate_ids, which would not be particularly useful.
> 
> I have checked it again, those prints shouldn't have used that field.
> Will fix them.
> 
> And so you can use that field in your code and I will get core fixed
> for you..

Like I said earlier, once the core is fixed, I'll be comfortable using
the .driver_data field for the purpose I need. Not until then :-)

> 
> >> Why do you need to get these from DT? And not find that yourself here instead?
> >
> > Well, I think we can obtain a more accurate value from the DT which
> > would have already computed it. But I'll let vaidy answer this.
> 
> Can we simply refer to frequency values here for finding min and max
> pstates? If yes, then probably this is the better place as there can be
> human errors in DT.. Also those binding are just not required then.
> And obviously less headache for you as well when you are changing
> pstate tables.
> 
> >> > +       freq_data = (struct powernv_smp_call_data *)arg;
> >>
> >> don't need casting here ?
> >
> > Doesn't harm having it there. Just like the #includes :-)
> 
> Do you ever have these typecasts while you do kmalloc? It also
> returns void *.. That's the same..
> 
> CodingStyle: Chapter 14: Allocating memory:
> 
> Casting the return value which is a void pointer is redundant. The conversion
> from void pointer to any other pointer type is guaranteed by the C programming
> language.

Thanks. I shall keep this in mind in the future.

> 
> >> > +       pr_debug("cpu %d pmsr %lx pstate_id %d frequency %d kHz \n",
> >> > +               smp_processor_id(), pmspr_val, freq_data->pstate_id,
> >>
> >> s/smp_processor_id/raw_smp_processor_id ?
> >
> > No. This function is called via smp_call_function(). So we have
> > preempt_disable on and it is safe to use smp_processor_id.
> 
> My question wasn't about being safe, but avoiding the complexity
> of debug_smp_processor_id(). raw_smp_processor_id() can execute
> very quickly.

Well, in the scenarios that we're interested in, it is highly unlikely
that CONFIG_PREMPT is set. Hence we'll default to
raw_smp_processor_id() anyway. So, I think we can retain
smp_processor_id(). 

> 
> > You mean s/clock/core ?
> 
> Oops!! yes.
> 
> > Thanks for a detailed review again.
> 
> Its my job :)
> 
> > I'll send out the updated patch today incorporating the comments. It
> > shouldn't be hard since most of the comments do not affect the
> > functionality.
> 
> Probably they do now ? :)

Not really.

> 
--
Thanks and Regards
gautham.

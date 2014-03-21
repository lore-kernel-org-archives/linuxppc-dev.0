Return-Path: <ego@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 981082C00B5
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 22:04:57 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 21 Mar 2014 05:04:55 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 5B2313E4004C
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 05:04:52 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2LB4IBk10355154
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 12:04:18 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2LB4pP5025916
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 05:04:52 -0600
Date: Fri, 21 Mar 2014 16:34:45 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 5/5] powernv:cpufreq: Implement the driver->get() method
Message-ID: <20140321110445.GB2493@in.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-6-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x==9JT-q2w95Ub_Ck_UMPcWY_4vo_Y44-i=DPjtu0jxwZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOh2x==9JT-q2w95Ub_Ck_UMPcWY_4vo_Y44-i=DPjtu0jxwZg@mail.gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Linux PM list <linux-pm@vger.kernel.org>, linuxppc-dev@ozlabs.org
Reply-To: ego@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 21, 2014 at 03:01:29PM +0530, Viresh Kumar wrote:
> On Thu, Mar 20, 2014 at 5:41 PM, Gautham R. Shenoy
> <ego@linux.vnet.ibm.com> wrote:
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> >
> > The current frequency of a cpu is reported through the sysfs file
> > cpuinfo_cur_freq. This requires the driver to implement a
> > "->get(unsigned int cpu)" method which will return the current
> > operating frequency.
> >
> > Implement a function named powernv_cpufreq_get() which reads the local
> > pstate from the PMSR and returns the corresponding frequency.
> >
> > Set the powernv_cpufreq_driver.get hook to powernv_cpufreq_get().
> >
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > ---
> >  drivers/cpufreq/powernv-cpufreq.c | 38 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> 
> Please merge these fixups with the first patch which is creating the driver.
> I understand that a different guy has created this patch and so wanted
> to have a patch on his name but its really difficult to review this
way.

Heh! Well, that wasn't the reason why this was sent out as a separate
patch, but never mind. Though I don't understand why it would be
difficult to review the patch though.

> Better add your signed-off in the first patch instead. Sending such changes
> once the driver is mainlined looks fine.

Sure, this makes sense.

> 
> > diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> > index 46bee8a..ef6ed8c 100644
> > --- a/drivers/cpufreq/powernv-cpufreq.c
> > +++ b/drivers/cpufreq/powernv-cpufreq.c
> > @@ -206,6 +206,43 @@ static inline void set_pmspr(unsigned long sprn, unsigned long val)
> >         BUG();
> >  }
> >
> > +/*
> > + * Computes the current frequency on this cpu
> > + * and stores the result in *ret_freq.
> > + */
> > +static void powernv_read_cpu_freq(void *ret_freq)
> > +{
> > +       unsigned long pmspr_val;
> > +       s8 local_pstate_id;
> > +       int *cur_freq, freq, pstate_id;
> > +
> > +       cur_freq = (int *)ret_freq;
> 
> You don't need cur_freq variable at all..

I don't like it either. But the compiler complains without this hack
:-(

> 
> > +       pmspr_val = get_pmspr(SPRN_PMSR);
> > +
> > +       /* The local pstate id corresponds bits 48..55 in the PMSR.
> > +         * Note: Watch out for the sign! */
> > +       local_pstate_id = (pmspr_val >> 48) & 0xFF;
> > +       pstate_id = local_pstate_id;
> 
> similarly local_pstate_id

well, I am interested in the bits 48..55 of pmspr_val. That's the
pstate_id which can be negative. So I'll like to keep
local_pstate_id. 
> 
> > +
> > +       freq = pstate_id_to_freq(pstate_id);
> > +       pr_debug("cpu %d pmsr %lx pstate_id %d frequency %d \n",
> > +               smp_processor_id(), pmspr_val, pstate_id, freq);
> > +       *cur_freq = freq;
> 
> Move above print here after a blank line. Also remove freq variable as
> well and use *cur_freq directly.. And then you can rename it to freq
as well.

We can get rid of freq and use *cur_freq in its place.


Thanks for the detailed review.

--
Regards
gautham.

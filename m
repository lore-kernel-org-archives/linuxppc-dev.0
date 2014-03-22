Return-Path: <ego@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1C1C32C00AA
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2014 18:54:08 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Sat, 22 Mar 2014 01:54:06 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 0668119D803F
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2014 01:54:01 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2M5pCgO8651014
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2014 06:51:13 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2M7s3ED002767
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2014 01:54:03 -0600
Date: Sat, 22 Mar 2014 13:23:56 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 5/5] powernv:cpufreq: Implement the driver->get() method
Message-ID: <20140322075356.GA3857@in.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-6-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x==9JT-q2w95Ub_Ck_UMPcWY_4vo_Y44-i=DPjtu0jxwZg@mail.gmail.com>
 <20140321110445.GB2493@in.ibm.com>
 <1395442590.3460.85.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395442590.3460.85.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, ego@linux.vnet.ibm.com,
 Linux PM list <linux-pm@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Reply-To: ego@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

On Sat, Mar 22, 2014 at 09:56:30AM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2014-03-21 at 16:34 +0530, Gautham R Shenoy wrote:
> 
> > > >
> > > > +/*
> > > > + * Computes the current frequency on this cpu
> > > > + * and stores the result in *ret_freq.
> > > > + */
> > > > +static void powernv_read_cpu_freq(void *ret_freq)
> > > > +{
> > > > +       unsigned long pmspr_val;
> > > > +       s8 local_pstate_id;
> > > > +       int *cur_freq, freq, pstate_id;
> > > > +
> > > > +       cur_freq = (int *)ret_freq;
> > > 
> > > You don't need cur_freq variable at all..
> > 
> > I don't like it either. But the compiler complains without this hack
> > :-(
> 
> Casting integers into void * is a recipe for disaster... what is that
> supposed to be about ?

Like I mentioned elsewhere on this thread, we're calling
powernv_read_cpu_freq via an smp_call_function(). We use this to
obtain the frequency on the cpu where powernv_read_cpu_freq
executes and return it to the caller of smp_call_function.

> We lose all type checking and get exposed
> to endian issues etc... the day somebody uses a different type on both
> sides.
> 
Yes, I understand the problem now. I'll think of a safer way to pass
the return value.

> Also is "freq" a frequency ? In this case an int isn't big enough.

freq is the frequency stored in the cpufreq_table. The value is in
kHz. So, int should be big enough.

> Cheers,
> Ben.
> 
>

--
Thanks and Regards
gautham. 

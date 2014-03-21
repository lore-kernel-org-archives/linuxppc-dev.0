Return-Path: <ego@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4A65C2C00A0
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 23:31:18 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 21 Mar 2014 06:31:16 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 35F9A3E40026
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 06:31:13 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2LCUdJ01179996
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 13:30:39 +0100
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2LCVCb8021204
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 06:31:13 -0600
Date: Fri, 21 Mar 2014 18:01:06 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH v3 5/5] powernv:cpufreq: Implement the driver->get() method
Message-ID: <20140321123106.GC2493@in.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-6-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x==9JT-q2w95Ub_Ck_UMPcWY_4vo_Y44-i=DPjtu0jxwZg@mail.gmail.com>
 <20140321110445.GB2493@in.ibm.com>
 <CAKohpo=k-e1GLiLRNtJ3Xi3+NUWW1+gvtCNr_4Ag60j49dZvdQ@mail.gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6D0F6E5386@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D0F6E5386@AcuExch.aculab.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 'Viresh Kumar' <viresh.kumar@linaro.org>,
 Linux PM list <linux-pm@vger.kernel.org>,
 "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 21, 2014 at 12:01:07PM +0000, David Laight wrote:
> From: Viresh Kumar
>  
> > On 21 March 2014 16:34, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> > > Heh! Well, that wasn't the reason why this was sent out as a separate
> > > patch, but never mind. Though I don't understand why it would be
> > > difficult to review the patch though.
> > 
> > Because the initial driver wasn't complete earlier. There were 2-3 patches
> > after the first one which are changing what the first patch has added.
> > Nothing else :)
> > 
> > >> > +static void powernv_read_cpu_freq(void *ret_freq)
> > >> > +{
> > >> > +       unsigned long pmspr_val;
> > >> > +       s8 local_pstate_id;
> > >> > +       int *cur_freq, freq, pstate_id;
> > >> > +
> > >> > +       cur_freq = (int *)ret_freq;
> > >>
> > >> You don't need cur_freq variable at all..
> > >
> > > I don't like it either. But the compiler complains without this hack
> > > :-(
> > 
> > Why would the compiler warn for doing this?:
> > 
> > *(int *)ret_freq = freq;
> 
> Because it is very likely to be wrong.
> In general casts of pointers to integer types are dangerous.
> In this case why not make the function return the value?

Because this function is called via an smp_call_function(). And we
need a way of returning the value to the caller.

> 
> 	David
> 
> 

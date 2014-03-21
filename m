Return-Path: <ego@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E2C642C0084
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2014 00:05:02 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 21 Mar 2014 09:04:59 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 289306E803F
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 09:04:51 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2LD4uN86881542
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 13:04:56 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2LD4tDr011303
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 09:04:56 -0400
Date: Fri, 21 Mar 2014 18:34:51 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 5/5] powernv:cpufreq: Implement the driver->get() method
Message-ID: <20140321130450.GD2493@in.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-6-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x==9JT-q2w95Ub_Ck_UMPcWY_4vo_Y44-i=DPjtu0jxwZg@mail.gmail.com>
 <20140321110445.GB2493@in.ibm.com>
 <CAKohpo=k-e1GLiLRNtJ3Xi3+NUWW1+gvtCNr_4Ag60j49dZvdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKohpo=k-e1GLiLRNtJ3Xi3+NUWW1+gvtCNr_4Ag60j49dZvdQ@mail.gmail.com>
Cc: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>,
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

On Fri, Mar 21, 2014 at 05:15:34PM +0530, Viresh Kumar wrote:
> On 21 March 2014 16:34, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> > Heh! Well, that wasn't the reason why this was sent out as a separate
> > patch, but never mind. Though I don't understand why it would be
> > difficult to review the patch though.
> 
> Because the initial driver wasn't complete earlier. There were 2-3 patches
> after the first one which are changing what the first patch has added.
> Nothing else :)
> 
> >> > +static void powernv_read_cpu_freq(void *ret_freq)
> >> > +{
> >> > +       unsigned long pmspr_val;
> >> > +       s8 local_pstate_id;
> >> > +       int *cur_freq, freq, pstate_id;
> >> > +
> >> > +       cur_freq = (int *)ret_freq;
> >>
> >> You don't need cur_freq variable at all..
> >
> > I don't like it either. But the compiler complains without this hack
> > :-(
> 
> Why would the compiler warn for doing this?:
> 
> *(int *)ret_freq = freq;

The compiler doesn't complain if I do this.
> 
> >> > +       pmspr_val = get_pmspr(SPRN_PMSR);
> >> > +
> >> > +       /* The local pstate id corresponds bits 48..55 in the PMSR.
> >> > +         * Note: Watch out for the sign! */
> >> > +       local_pstate_id = (pmspr_val >> 48) & 0xFF;
> >> > +       pstate_id = local_pstate_id;
> >>
> >> similarly local_pstate_id
> >
> > well, I am interested in the bits 48..55 of pmspr_val. That's the
> > pstate_id which can be negative. So I'll like to keep
> > local_pstate_id.
> 
> Can you please explain at bit level how getting the value in a s8
> first and then into a s32 will help you here? Instead of getting it
> directly into s32.

Consider the case when pmspr = 0x00feffffffffffff;

We are interested in extracting the value 'fe'. And ensure that when
we store this value into an int, we get the sign extension right.

So the following doesn't work: 

   pstate_id = (pmspr_val >> 48) & 0xFFFFFFFF;

Since we get pstate_id = 0x000000fe, which is not the same as
0xfffffffe.

Of course, we could do the following, but I wasn't sure if
two levels of type casting helped on the readability front.

   pstate_id = (int) ((s8)((pmspr_val >> 48) & 0xFF));

--
Thanks and Regards
gautham.
> 

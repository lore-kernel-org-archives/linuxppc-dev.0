Return-Path: <ego@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5BF912C0082
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2014 01:55:09 +1100 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 21 Mar 2014 08:55:06 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id A505219D8040
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 08:55:00 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2LEt3wv47120596
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 15:55:03 +0100
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2LEt1Np003151
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 08:55:03 -0600
Date: Fri, 21 Mar 2014 20:24:52 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/5] powernv: cpufreq driver for powernv platform
Message-ID: <20140321145452.GA8755@in.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-2-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x=kp65vrKamtxxR9iCX+t-S3nDJP05+1mfpOiWzbWpfGYA@mail.gmail.com>
 <20140321104317.GA2493@in.ibm.com>
 <CAKohpo=JqHOPF_pdcAsvRgc1vENmS=Sg9pS8ZXPGhfMFnA8ZUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKohpo=JqHOPF_pdcAsvRgc1vENmS=Sg9pS8ZXPGhfMFnA8ZUA@mail.gmail.com>
Cc: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>,
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

On Fri, Mar 21, 2014 at 04:24:27PM +0530, Viresh Kumar wrote:
> >> > +static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
> >> > +{
> >> > +       int base, i;
> >> > +
> >> > +       base = cpu_first_thread_sibling(policy->cpu);
> >> > +
> >> > +       for (i = 0; i < threads_per_core; i++)
> >> > +               cpumask_set_cpu(base + i, policy->cpus);
> >> > +       policy->cpuinfo.transition_latency = 25000;
> >> > +
> >> > +       policy->cur = powernv_freqs[0].frequency;
> >> > +       cpufreq_frequency_table_get_attr(powernv_freqs, policy->cpu);
> >>
> >> This doesn't exist anymore.

Ok, I guess the right thing to do at this point is call

   cpufreq_table_validate_and_show(policy, powernv_freqs);

Will fix the code to take care of this.
--
Thanks and Regards
gautham.

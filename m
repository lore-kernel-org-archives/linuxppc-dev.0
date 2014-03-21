Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3C4A92C00B9
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2014 09:57:14 +1100 (EST)
Message-ID: <1395442590.3460.85.camel@pasglop>
Subject: Re: [PATCH v3 5/5] powernv:cpufreq: Implement the driver->get() method
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ego@linux.vnet.ibm.com
Date: Sat, 22 Mar 2014 09:56:30 +1100
In-Reply-To: <20140321110445.GB2493@in.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-6-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x==9JT-q2w95Ub_Ck_UMPcWY_4vo_Y44-i=DPjtu0jxwZg@mail.gmail.com>
 <20140321110445.GB2493@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Linux PM list <linux-pm@vger.kernel.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-03-21 at 16:34 +0530, Gautham R Shenoy wrote:

> > >
> > > +/*
> > > + * Computes the current frequency on this cpu
> > > + * and stores the result in *ret_freq.
> > > + */
> > > +static void powernv_read_cpu_freq(void *ret_freq)
> > > +{
> > > +       unsigned long pmspr_val;
> > > +       s8 local_pstate_id;
> > > +       int *cur_freq, freq, pstate_id;
> > > +
> > > +       cur_freq = (int *)ret_freq;
> > 
> > You don't need cur_freq variable at all..
> 
> I don't like it either. But the compiler complains without this hack
> :-(

Casting integers into void * is a recipe for disaster... what is that
supposed to be about ? We lose all type checking and get exposed
to endian issues etc... the day somebody uses a different type on both
sides.

Also is "freq" a frequency ? In this case an int isn't big enough.

Cheers,
Ben.

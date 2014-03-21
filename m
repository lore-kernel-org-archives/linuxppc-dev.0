Return-Path: <ego@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9915B2C00BC
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 20:55:46 +1100 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 21 Mar 2014 03:55:43 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id E5A6D1FF001A
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 03:55:40 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2L9swV511141548
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 10:54:58 +0100
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2L9tei6012399
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 03:55:40 -0600
Date: Fri, 21 Mar 2014 15:25:34 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 4/5] powernv:cpufreq: Export nominal frequency via
 sysfs.
Message-ID: <20140321095534.GF27293@in.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-5-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x=kLwDGFtHR5sBKhE-9L=3=npV4_i+B+BVm+yBocmmMvzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOh2x=kLwDGFtHR5sBKhE-9L=3=npV4_i+B+BVm+yBocmmMvzQ@mail.gmail.com>
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

On Fri, Mar 21, 2014 at 02:17:28PM +0530, Viresh Kumar wrote:
> > +static ssize_t show_cpuinfo_nominal_freq(struct cpufreq_policy *policy,
> > +                                       char *buf)
> > +{
> > +       int nominal_freq;
> > +       nominal_freq = pstate_id_to_freq(powernv_pstate_info.pstate_nominal_id);
> > +       return sprintf(buf, "%u\n", nominal_freq);
> 
> return sprintf(buf, "%u\n",
> pstate_id_to_freq(powernv_pstate_info.pstate_nominal_id));

Sure. Will fix this. 
> 
> ??
> 
> > +}
> > +
> > +
> 
> remove extra blank line.
> 
> > +struct freq_attr cpufreq_freq_attr_cpuinfo_nominal_freq = {
> > +       .attr = { .name = "cpuinfo_nominal_freq",
> > +                 .mode = 0444,
> > +               },
> 
> Align {}

Probably the use of ATTR_RO(cpuinfo_nominal_freq) and renaming
show_cpuinfo_nominal_freq to cpuinfo_nominal_freq_show() would be even
better. What do you think ?

> 
> > +       .show = show_cpuinfo_nominal_freq,
> > +};
> > +
> > +
> >  static struct freq_attr *powernv_cpu_freq_attr[] = {
> >         &cpufreq_freq_attr_scaling_available_freqs,
> > +       &cpufreq_freq_attr_cpuinfo_nominal_freq,
> >         NULL,
> >  };

This needs to be rewritten to include the entries of cpufreq_generic_attr.
>

Thanks for the review.

--
Regards
gautham. 

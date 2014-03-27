Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 76BD114008B
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 21:13:17 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Thu, 27 Mar 2014 15:43:09 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7FB2EE003F
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 15:47:07 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2RABO2v4391312
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 15:41:25 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2RABdTa012790
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 15:41:40 +0530
Date: Thu, 27 Mar 2014 15:41:37 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v4] powernv, cpufreq: cpufreq driver for powernv platform
Message-ID: <20140327101137.GA8747@dirshya.in.ibm.com>
References: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395852947-22290-2-git-send-email-ego@linux.vnet.ibm.com>
 <CAKohponPb+b=8Pa=te3CkiN6QPAUAukngqLSdG4vxc9pUkD8OQ@mail.gmail.com>
 <20140327093050.GA27777@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20140327093050.GA27777@in.ibm.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
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

* Gautham R Shenoy <ego@linux.vnet.ibm.com> [2014-03-27 15:00:50]:

[snip]
 
> > > +       u32 len_ids, len_freqs;
> > > +
> > > +       power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
> > > +       if (!power_mgt) {
> > > +               pr_warn("power-mgt node not found\n");
> > > +               return -ENODEV;
> > > +       }
> > > +
> > > +       if (of_property_read_u32(power_mgt, "ibm,pstate-min", &pstate_min)) {
> > > +               pr_warn("ibm,pstate-min node not found\n");
> > > +               return -ENODEV;
> > > +       }
> > > +
> > > +       if (of_property_read_u32(power_mgt, "ibm,pstate-max", &pstate_max)) {
> > > +               pr_warn("ibm,pstate-max node not found\n");
> > > +               return -ENODEV;
> > > +       }
> > 
> > Why do you need to get these from DT? And not find that yourself here instead?
> >
> 
> Well, I think we can obtain a more accurate value from the DT which
> would have already computed it. But I'll let vaidy answer this.

DT provides the values that we should use.  Ideally these are the
upper and lower limits of the PState table,  however as per the
platform spec, we should use the PState IDs between these limits.  We
would like to parse it and keep it in the driver for debug purposes.

The platform exports this info in the DT to be more explicit and not
have a strong dependency on the PState numbering or PState table
itself.  In the driver we parse it for debug/validation purpose.

--Vaidy

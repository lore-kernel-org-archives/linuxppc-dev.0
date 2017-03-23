Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpXrV0Cc0zDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 15:00:09 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2N3whup040041
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 00:00:03 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29c57dck6w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 00:00:03 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Thu, 23 Mar 2017 14:00:01 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2N3xoEw32833668
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 14:59:58 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2N3xPE0010879
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 14:59:26 +1100
Date: Thu, 23 Mar 2017 09:29:02 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv/cpuidle: Pass correct drv->cpumask for
 registration
Reply-To: svaidy@linux.vnet.ibm.com
References: <20170317180550.9931-1-svaidy@linux.vnet.ibm.com>
 <1489814882.5616.11.camel@neuling.org>
 <20170318064425.GC4225@drishya.in.ibm.com>
 <87k27kzlz0.fsf@concordia.ellerman.id.au>
 <20170320043112.GA4123@drishya.in.ibm.com>
 <87lgrxd1hl.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <87lgrxd1hl.fsf@concordia.ellerman.id.au>
Message-Id: <20170323035902.GA4842@drishya.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Michael Ellerman <mpe@ellerman.id.au> [2017-03-22 21:55:50]:

> Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> writes:
> > * Michael Ellerman <mpe@ellerman.id.au> [2017-03-20 14:05:39]:
> >> Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> writes:
> >  
> >> > On powernv platform cpu_present could be less than cpu_possible
> >> > in cases where firmware detects the cpu, but it is not available
> >> > for OS.
> >> 
> >> It's entirely normal for present < possible, on my laptop for example,
> >> so I don't see how that causes the bug.
> >
> > Yes, present < possible in itself not a problem.  It is whether
> > cpu_device exist for that cpu or not.
> ...
> >
> > Currently if CONFIG_HOTPLUG_CPU=n, then we skip calling register_cpu()
> > and that causes the problem.
> ...
> >> 
> >> I really don't understand how a CPU not being present leads to a crash
> >> in printf()? Something in that call chain should have checked that the
> >> CPU was registered before crashing in printf() - surely?
> >
> > Yes, we should have just failed to register the cpuidle driver.  I have
> > the fix here:
> >
> > [PATCH] cpuidle: Validate cpu_dev in cpuidle_add_sysfs
> > http://patchwork.ozlabs.org/patch/740634/
> 
> OK. Can you send a v2 of this with a better change log that includes all
> the clarifications above.
> 
> And despite your subject being powerpc/powernv/cpuidle, this is a
> cpuidle patch. I can merge it, but I at least need you to Cc the cpuidle
> maintainers so they have a chance to see it.

Thanks for the review, I will post a v2 with more detailed commit log
and CC cpuidle maintainers and linux-pm.

--Vaidy

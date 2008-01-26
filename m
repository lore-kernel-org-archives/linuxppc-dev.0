Return-Path: <vatsa@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EB817DDE02
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 14:53:59 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0Q3ru59013245
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 22:53:56 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0Q3ruIt161246
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 22:53:56 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0Q3rtw5031621
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 22:53:56 -0500
Date: Sat, 26 Jan 2008 09:37:34 +0530
From: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: ppc32: Weird process scheduling behaviour with 2.6.24-rc
Message-ID: <20080126040734.GA21365@linux.vnet.ibm.com>
References: <1200659696.23161.81.camel@thor.sulgenrain.local>
	<1201013786.4726.28.camel@thor.sulgenrain.local>
	<1201090699.9052.39.camel@thor.sulgenrain.local>
	<1201092131.6341.51.camel@lappy>
	<1201244082.6815.128.camel@pasglop>
	<1201244618.6815.130.camel@pasglop>
	<1201245901.6815.133.camel@pasglop>
	<1201251000.6341.108.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1201251000.6341.108.camel@lappy>
Cc: Ingo Molnar <mingo@elte.hu>,
	Michel.=?iso-8859-1?Q?D=E4nzer_=3Cmichel=40tungstengraphics=2Ecom=3E?=@snowy.in.ibm.com,
	linuxppc-dev@ozlabs.org
Reply-To: vatsa@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 25, 2008 at 09:50:00AM +0100, Peter Zijlstra wrote:
> 
> On Fri, 2008-01-25 at 18:25 +1100, Benjamin Herrenschmidt wrote:
> > On Fri, 2008-01-25 at 18:03 +1100, Benjamin Herrenschmidt wrote:
> > > On Fri, 2008-01-25 at 17:54 +1100, Benjamin Herrenschmidt wrote:
> > > > 
> > > > Here, I do the test of running 4 times the repro-case provided by Michel
> > > > with nice 19 and a dd eating CPU with nice 0.
> > > > 
> > > > Without this option, I get the dd at 100% and the nice 19 shells down
> > > > below it with whatever is left of the CPUs.
> > > > 
> > > > With this option, dd gets about 50% of one CPU and the niced processes
> > > > still get most of the time.

Ben,
	I presume you had CONFIG_FAIR_USER_SCHED turned on too? Also were the
dd process and the niced processes running under different user ids? If
so, that is expected behavior, that we divide CPU equally among
users first and then among the processes within each user.

> > > FYI. This is a 4 way G5 (ppc64)
> > 
> > I also tested responsiveness of X running with or without that option
> > and with niced CPU eaters in the background (still 4 of them, one per
> > CPU), and I can confirm Michel observations, it gets very sluggish
> > (maybe not -as- bad as his but still pretty annoying) with the fair
> > group scheduler enabled.

When CONFIG_FAIR_GROUP_SCHED (and CONFIG_FAIR_USER_SCHED) is not
enabled, X will be given higher priority for running on CPU when compared to 
other niced tasks. When the above options are turned on, X (running
under root uid) would be given lesser priority to run when compared to other
niced tasks running user different uids. Hence I expect some drop in
interactivity-experience with FAIR_GROUP_SCHED on.

Can you pls let me know if any of these makes a difference:

1. Run niced tasks as root. This would bring X and niced tasks in the
same "scheduler group" domain, which would give X much more CPU power
when compared to niced tasks.

2. Keep the niced tasks running under a non-root uid, but increase root users 
   cpu share.
	# echo 8192 > /sys/kernel/uids/0/cpu_share

   This should bump up root user's priority for running on CPU and also 
   give a better desktop experience.

> > Here, X is running with nice=0
> 
> Curious, sounds like an issue with the group load balancer, vatsa, any
> ideas?

The group scheduler's SMP-load balance in 2.6.24 is not the best it
could be. sched-devel has a better load balancer, which I am presuming
will go into 2.6.25 soon.

In this case, I suspect that's not the issue.  If X and the niced processes are 
running under different uids, this (niced processes getting more cpu power) is 
on expected lines. Will wait for Ben to confirm this. 

-- 
Regards,
vatsa

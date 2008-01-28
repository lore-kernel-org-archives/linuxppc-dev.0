Return-Path: <michel@tungstengraphics.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by ozlabs.org (Postfix) with ESMTP id 3CAD2DDE19
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 20:14:38 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so1448088fgg.39
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 01:14:37 -0800 (PST)
Subject: Re: ppc32: Weird process scheduling behaviour with 2.6.24-rc
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1201510236.6149.24.camel@lappy>
References: <1200659696.23161.81.camel@thor.sulgenrain.local>
	<1201013786.4726.28.camel@thor.sulgenrain.local>
	<1201090699.9052.39.camel@thor.sulgenrain.local>
	<1201092131.6341.51.camel@lappy> <1201244082.6815.128.camel@pasglop>
	<1201244618.6815.130.camel@pasglop> <1201245901.6815.133.camel@pasglop>
	<1201251000.6341.108.camel@lappy>
	<20080126040734.GA21365@linux.vnet.ibm.com>
	<1201320834.6815.160.camel@pasglop>
	<20080126050757.GB14177@linux.vnet.ibm.com>
	<1201450409.1931.23.camel@thor.sulgenrain.local>
	<1201510236.6149.24.camel@lappy>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Jan 2008 10:14:33 +0100
Message-Id: <1201511673.5923.46.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Cc: Ingo Molnar <mingo@elte.hu>, vatsa@linux.vnet.ibm.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-01-28 at 09:50 +0100, Peter Zijlstra wrote:
> On Sun, 2008-01-27 at 17:13 +0100, Michel Dänzer wrote:
> 
> > In summary, there are two separate problems with similar symptoms, which
> > had me confused at times:
> > 
> >       * With CONFIG_FAIR_USER_SCHED disabled, there are severe
> >         interactivity hickups with a niced CPU hog and top running. This
> >         started with commit 810e95ccd58d91369191aa4ecc9e6d4a10d8d0c8. 
> 
> The revert at the bottom causes the wakeup granularity to shrink for +
> nice and to grow for - nice. That is, it becomes easier to preempt a +
> nice task, and harder to preempt a - nice task.

Yeah, that matches my observations. :)

> I think we originally had that; didn't comment it, forgot the reason
> changed it because the units didn't match. Another reason might have
> been the more difficult preemption of - nice tasks. That might - niced
> tasks to cause horrible latencies - Ingo, any recollection?
> 
> Are you perhaps running with a very low HZ (HZ=100)? (If wakeup
> preemption fails, tick preemption will take over).

I haven't had it below 250 since that became an option, and I'm
currently at 1000 (and NO_HZ, but disabling that didn't seem to make a
difference).

> Also, could you try lowering:
>   /proc/sys/kernel/sched_wakeup_granularity_ns

Will try.


> >       * With CONFIG_FAIR_USER_SCHED enabled, X becomes basically
> >         unusable with a niced CPU hog, with or without top running. I
> >         don't know when this started, possibly when this option was
> >         first introduced.
> 
> Srivatsa found an issue that might explain the very bad behaviour under
> group scheduling. But I gather you're not at all interested in this
> feature?

That's right, but it's good to hear you have a lead there as well, and
if you can't find any interested testers, let me know and I'll try.


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer

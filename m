Return-Path: <michel@tungstengraphics.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by ozlabs.org (Postfix) with ESMTP id 947A4DDDFF
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 21:14:35 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so1819907fgg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 02:14:33 -0800 (PST)
Subject: Re: ppc32: Weird process scheduling behaviour with 2.6.24-rc
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20080128125631.GA8269@elte.hu>
References: <1201244618.6815.130.camel@pasglop>
	<1201245901.6815.133.camel@pasglop> <1201251000.6341.108.camel@lappy>
	<20080126040734.GA21365@linux.vnet.ibm.com>
	<1201320834.6815.160.camel@pasglop>
	<20080126050757.GB14177@linux.vnet.ibm.com>
	<1201450409.1931.23.camel@thor.sulgenrain.local>
	<1201510236.6149.24.camel@lappy> <20080128123253.GA32496@elte.hu>
	<1201524796.28547.5.camel@lappy>  <20080128125631.GA8269@elte.hu>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Jan 2008 11:14:29 +0100
Message-Id: <1201601669.6310.20.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	vatsa@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-01-28 at 13:56 +0100, Ingo Molnar wrote: 
> * Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
> > > i think it would be OK to do half of this: make it easier to preempt 
> > > a +nice task. Michel, do you really need the -nice portion as well? 
> > > It's not a problem to super-preempt positively reniced tasks, but it 
> > > can be quite annoying if negatively reniced tasks have super-slices.
> > 
> > This should do that (unless I need a stronger cup of tea).
> 
> cool - thanks Peter. Michel, could you check Peter's patch, does it 
> resolve all the interactivity problems you've been seeing?

I'm now running with this patch and Srivatsa's patch, and together they
provide good interactivity even with CONFIG_FAIR_USER_SCHED enabled and
the default value of /proc/sys/kernel/sched_wakeup_granularity_ns. :) So
both patches seem to have the expected effect.

/proc/sys/kernel/sched_features contains 7.


Thanks,


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer

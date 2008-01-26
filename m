Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 28E51DDDEF
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 15:14:39 +1100 (EST)
Subject: Re: ppc32: Weird process scheduling behaviour with 2.6.24-rc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: vatsa@linux.vnet.ibm.com
In-Reply-To: <20080126040734.GA21365@linux.vnet.ibm.com>
References: <1200659696.23161.81.camel@thor.sulgenrain.local>
	<1201013786.4726.28.camel@thor.sulgenrain.local>
	<1201090699.9052.39.camel@thor.sulgenrain.local>
	<1201092131.6341.51.camel@lappy> <1201244082.6815.128.camel@pasglop>
	<1201244618.6815.130.camel@pasglop> <1201245901.6815.133.camel@pasglop>
	<1201251000.6341.108.camel@lappy>
	<20080126040734.GA21365@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Sat, 26 Jan 2008 15:13:54 +1100
Message-Id: <1201320834.6815.160.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2008-01-26 at 09:37 +0530, Srivatsa Vaddagiri wrote:
> 
> Ben,
>         I presume you had CONFIG_FAIR_USER_SCHED turned on too?

Yes. It seems to be automatically turned on whenever FAIR_GROUP is
turned on. Considering how bad the behaviour is for a standard desktop
configuration, I'd be tempted to say to change it to default n.

> Also were the
> dd process and the niced processes running under different user ids? If
> so, that is expected behavior, that we divide CPU equally among
> users first and then among the processes within each user.

They were different users and that behaviour seems to be a very stupid
default behaviour for a desktop machine. Take this situation:

 - X running as root
 - User apps running as "user"
 - Background crap (indexing daemons etc...) running as their own user
or nobody

Unless you can get some kind of grouping based on user sessions
including suid binaries, X etc... I think this shouldn't default y in
Kconfig.

Not that it seems that Michel reported far worse behaviour than what I
saw, including pretty hickup'ish X behaviour even without the fair group
scheduler compared to 2.6.23. It might be because he's running X niced
to -1 (I leave X at 0 and let the scheduler deal with it in general)
though.

> When CONFIG_FAIR_GROUP_SCHED (and CONFIG_FAIR_USER_SCHED) is not
> enabled, X will be given higher priority for running on CPU when compared to 
> other niced tasks. When the above options are turned on, X (running
> under root uid) would be given lesser priority to run when compared to other
> niced tasks running user different uids. Hence I expect some drop in
> interactivity-experience with FAIR_GROUP_SCHED on.
> 
> Can you pls let me know if any of these makes a difference:
> 
> 1. Run niced tasks as root. This would bring X and niced tasks in the
> same "scheduler group" domain, which would give X much more CPU power
> when compared to niced tasks.

I'll dbl check. My tests where indeed done with different users.

> 2. Keep the niced tasks running under a non-root uid, but increase root users 
>    cpu share.
>         # echo 8192 > /sys/kernel/uids/0/cpu_share
> 
>    This should bump up root user's priority for running on CPU and also 
>    give a better desktop experience.

Allright, that's something that might need to be set by default by the
kernel ... as it will take some time to have knowledge of those knobs to
percolate to distros. Too bad you can't do the opposite by default for
"nobody" as there's no standard uid for it.

> The group scheduler's SMP-load balance in 2.6.24 is not the best it
> could be. sched-devel has a better load balancer, which I am presuming
> will go into 2.6.25 soon.
> 
> In this case, I suspect that's not the issue.  If X and the niced processes are 
> running under different uids, this (niced processes getting more cpu power) is 
> on expected lines. Will wait for Ben to confirm this. 

I would suggest turning the fair group scheduler to default n in stable
for now.

Cheers,
Ben.

Return-Path: <vatsa@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 270D9DDE16
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 15:54:03 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0Q4rn7f013132
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 23:53:49 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0Q4rn0l093128
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 21:53:49 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0Q4rmr1021276
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 21:53:49 -0700
Date: Sat, 26 Jan 2008 10:37:23 +0530
From: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ppc32: Weird process scheduling behaviour with 2.6.24-rc
Message-ID: <20080126050637.GA14177@linux.vnet.ibm.com>
References: <1200659696.23161.81.camel@thor.sulgenrain.local>
	<1201013786.4726.28.camel@thor.sulgenrain.local>
	<1201090699.9052.39.camel@thor.sulgenrain.local>
	<1201092131.6341.51.camel@lappy>
	<1201244082.6815.128.camel@pasglop>
	<1201244618.6815.130.camel@pasglop>
	<1201245901.6815.133.camel@pasglop>
	<1201251000.6341.108.camel@lappy>
	<20080126040734.GA21365@linux.vnet.ibm.com>
	<1201320834.6815.160.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1201320834.6815.160.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Michel.=?iso-8859-1?Q?D=E4nzer_=3Cmichel=40tungstengraphics=2Ecom=3E?=@snowy.in.ibm.com
Reply-To: vatsa@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jan 26, 2008 at 03:13:54PM +1100, Benjamin Herrenschmidt wrote:
> > Ben,
> >         I presume you had CONFIG_FAIR_USER_SCHED turned on too?
> 
> Yes. It seems to be automatically turned on whenever FAIR_GROUP is
> turned on. Considering how bad the behaviour is for a standard desktop
> configuration, I'd be tempted to say to change it to default n.

If I recall, CONFIG_FAIR_USER_SCHED was turned on as default at the same
time as CONFIG_FAIR_GROUP_SCHED as a means to flesh out fair-group
scheduler bugs. Also at that time, CONFIG_FAIR_CGROUP_SCHED was not
available in mainline as the second option for grouping tasks.

Going forward, I am of the favor to turn off CONFIG_FAIR_USER_SCHED by default, 
but turning on CONFIG_FAIR_GROUP_SCHED + CONFIG_FAIR_CGROUP_SCHED on by default.

That way all tasks belong to same group by default unless admin explicitly 
creates groups and moves around tasks between them. This will be good for 
desktop user who may choose to keep all tasks in one group by default, but also 
giving him/her the flexibility of exploiting fair-group scheduler by creating 
custom task groups and adjusting their cpu shares (for ex: kernel compile group 
or multi-media group). If someone still needs the fair-user scheduler (as 
provided by CONFIG_FAIR_USER_SCHED), they can still get it with 
CONFIG_FAIR_CGROUP_SCHED by running a daemon [1] that dynamically moves around 
tasks into different task group based on userid.

Ingo/Peter, what do you think?

> > Also were the
> > dd process and the niced processes running under different user ids? If
> > so, that is expected behavior, that we divide CPU equally among
> > users first and then among the processes within each user.
> 
> They were different users and that behaviour seems to be a very stupid
> default behaviour for a desktop machine. Take this situation:
> 
>  - X running as root
>  - User apps running as "user"
>  - Background crap (indexing daemons etc...) running as their own user
> or nobody
> 
> Unless you can get some kind of grouping based on user sessions
> including suid binaries, X etc... I think this shouldn't default y in
> Kconfig.

yes, see above.

> Not that it seems that Michel reported far worse behaviour than what I
> saw, including pretty hickup'ish X behaviour even without the fair group
> scheduler compared to 2.6.23. It might be because he's running X niced
> to -1 (I leave X at 0 and let the scheduler deal with it in general)
> though.

Hmm ..with X niced to -1, it should get more cpu power leading to a
better desktop experience.

Michel,
	You had reported that commit 810e95ccd58d91369191aa4ecc9e6d4a10d8d0c8 
was the cause for this bad behavior. Do you see behavior change (from good->bad)
immediately after applying that patch during your bisect process?

> > 2. Keep the niced tasks running under a non-root uid, but increase root users 
> >    cpu share.
> >         # echo 8192 > /sys/kernel/uids/0/cpu_share
> > 
> >    This should bump up root user's priority for running on CPU and also 
> >    give a better desktop experience.
> 
> Allright, that's something that might need to be set by default by the
> kernel ... as it will take some time to have knowledge of those knobs to
> percolate to distros. Too bad you can't do the opposite by default for
> "nobody" as there's no standard uid for it.
> 
> > The group scheduler's SMP-load balance in 2.6.24 is not the best it
> > could be. sched-devel has a better load balancer, which I am presuming
> > will go into 2.6.25 soon.
> > 
> > In this case, I suspect that's not the issue.  If X and the niced processes are 
> > running under different uids, this (niced processes getting more cpu power) is 
> > on expected lines. Will wait for Ben to confirm this. 
> 
> I would suggest turning the fair group scheduler to default n in stable
> for now.

I would prefer to have CONFIG_FAIR_GROUP_SCHED +
CONFIG_FAIR_CGROUP_SCHED on by default. Can you pls let me know how you
think is the desktop experience with that combination?

Reference:

1. http://article.gmane.org/gmane.linux.kernel/553267


-- 
Regards,
vatsa

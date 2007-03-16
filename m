Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 87575DDEDE
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 09:09:41 +1100 (EST)
Message-ID: <45FB159B.7020909@ru.mvista.com>
Date: Sat, 17 Mar 2007 01:09:31 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: tglx@linutronix.de
Subject: Re: [PATCH] PowerPC: dynamic tick support
References: <200611082337.28710.sshtylyov@ru.mvista.com>
In-Reply-To: <200611082337.28710.sshtylyov@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, greg.weeks@timesys.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, I wrote:

> Add dynamic tick support for PowerPC.

[...]


> Known issues:
> 1) with 2.6.18-hrt-dyntick2, dynamic tick mode causes bootup slowdown after the
>     HRT mode is entered (it seems to return to normal shortly);
> 2) with 2.6.18-rt7 (plus an extra patch to make it actually working :-) in the
>    kernel preemption mode other than RT, that slowdown seems permanent (this
>    was not happening with 2.6.18-rt6).

> I don't have time to investigate now, so anybody interested is welcome to...

    ... but I should have done it. :-/

> or I may even return to this if/when the time permits. :-)

    Looks like that was caused by that missing !need_resched_delayed() below. 
So, should be fixed with the latest 2.6.21-rc3-rt0 patch...

>  arch/powerpc/kernel/idle.c |    4 ++++
>  1 files changed, 4 insertions(+)
> 
> Index: linux-2.6/arch/powerpc/kernel/idle.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/kernel/idle.c
> +++ linux-2.6/arch/powerpc/kernel/idle.c
> @@ -49,6 +49,8 @@ void cpu_idle(void)
>  
>  	set_thread_flag(TIF_POLLING_NRFLAG);
>  	while (1) {
> +		hrtimer_stop_sched_tick();
> +
>  		while (!need_resched() && !cpu_should_die()) {
>  			ppc64_runlatch_off();
>  

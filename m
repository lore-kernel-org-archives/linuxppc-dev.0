Return-Path: <root@ucw.cz>
Received: from spitz.ucw.cz (gprs189-60.eurotel.cz [160.218.189.60])
	by ozlabs.org (Postfix) with ESMTP id DD20067C44
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 01:40:50 +1100 (EST)
Date: Tue, 12 Dec 2006 13:09:16 +0000
From: Pavel Machek <pavel@suse.cz>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [linux-pm] [RFC 1/3] support powermac G5 CPU hotplug
Message-ID: <20061212130916.GB5190@ucw.cz>
References: <20061211230208.526233000@sipsolutions.net>>
	<20061211230754.380263000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061211230754.380263000@sipsolutions.net>
Cc: linuxppc-dev@ozlabs.org, Torrance <torrance123@gmail.com>,
	Michael Buesch <mb@bu3sch.de>, linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi!

> This patch allows "hotplugging" of CPUs on G5 machines. CPUs that are
> disabled are put into an idle loop with interrupts hard-disabled, to wake
> them up again we kick them just like when bringing them up.
> 
> Maybe there's some way to actually turn off those CPUs even more?
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 


> --- linux-2.6-git.orig/arch/powerpc/kernel/smp.c	2006-12-11 23:34:47.693716759 +0100
> +++ linux-2.6-git/arch/powerpc/kernel/smp.c	2006-12-11 23:37:55.017716759 +0100
> @@ -558,6 +558,9 @@ int __devinit start_secondary(void *unus
>  
>  	local_irq_enable();
>  
> +	/* who knows what context the processor might have died in... */
> +	task_thread_info(paca[cpu].__current)->preempt_count = 0;
> +

?? Context for downing cpu should better be well-defined. Just do this
in cpu_die if it is really required.
							Pavel
-- 
Thanks for all the (sleeping) penguins.

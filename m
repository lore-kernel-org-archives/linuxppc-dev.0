Return-Path: <pochini@shiny.it>
Received: from smtp-out12.alice.it (smtp-out12.alice.it [85.37.17.107])
	by ozlabs.org (Postfix) with ESMTP id 330E2DDDEE
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Dec 2006 03:52:08 +1100 (EST)
Date: Fri, 29 Dec 2006 17:51:59 +0100
From: Giuliano Pochini <pochini@shiny.it>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: 2 CPUs, but only one is used
Message-Id: <20061229175159.4c7cb7bb.pochini@shiny.it>
In-Reply-To: <20061225055251.GR15713@localdomain>
References: <20061217144127.579f01f0.pochini@shiny.it>
	<20061220003545.7053b05c.pochini@shiny.it>
	<20061220141655.GJ15713@localdomain>
	<20061224175852.1b52740a.pochini@shiny.it>
	<20061225055251.GR15713@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[I resend this msg because I didn't receive it back from the lppc ml]

On Sun, 24 Dec 2006 23:52:51 -0600
Nathan Lynch <ntl@pobox.com> wrote:

> > At the end of kernel/cpu.c::cpu_up() both cpus are set as present, possible
> > and online. The problem is that in kernel/sched.c::find_idlest_group()
> > p->cpus_allowed is always 1 (it should be 3). I tried to put a dump_stack()
> > or a printk(mask) in set_cpu_mask() but it crashes badly when mask is not 3,
> > ie. anything different from khelper or kthread, so I couldn't know what sets
> > the wrong cpumask.
> 
> Does this fix it?
> 
> diff --git a/kernel/sched.c b/kernel/sched.c
> index b515e3c..3c8b1c5 100644
> --- a/kernel/sched.c
> +++ b/kernel/sched.c
> @@ -6875,7 +6875,7 @@ void __init sched_init_smp(void)
>  
>  	lock_cpu_hotplug();
>  	arch_init_sched_domains(&cpu_online_map);
> -	cpus_andnot(non_isolated_cpus, cpu_online_map, cpu_isolated_map);
> +	cpus_andnot(non_isolated_cpus, cpu_possible_map, cpu_isolated_map);
>  	if (cpus_empty(non_isolated_cpus))
>  		cpu_set(smp_processor_id(), non_isolated_cpus);
>  	unlock_cpu_hotplug();

Yes, it does. I also tested if tasks are migrated to/off cpu1 when I
enable/disable it and when I boot with or without maxcpus=1. It seems to
work correctly in all cases. Thank you.


--
Giuliano.

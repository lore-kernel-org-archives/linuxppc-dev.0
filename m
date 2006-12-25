Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 70230DDE2E
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Dec 2006 16:52:58 +1100 (EST)
Date: Sun, 24 Dec 2006 23:52:51 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Giuliano Pochini <pochini@shiny.it>
Subject: Re: 2 CPUs, but only one is used
Message-ID: <20061225055251.GR15713@localdomain>
References: <20061217144127.579f01f0.pochini@shiny.it>
	<20061220003545.7053b05c.pochini@shiny.it>
	<20061220141655.GJ15713@localdomain>
	<20061224175852.1b52740a.pochini@shiny.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061224175852.1b52740a.pochini@shiny.it>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Giuliano Pochini wrote:
> I have a dual G4 MDD mac running linux 2.6.19. When I boot with maxcpus=1 and
> then I issue "echo 1 >/sys/devices/system/cpu/cpu1/online" the second CPU is
> put online without errors, but it stays idle+wait=100% and of course
> user+system+nice=0%. It works fine without maxcpus=1. No problems with 2.6.18.

...

> At the end of kernel/cpu.c::cpu_up() both cpus are set as present, possible
> and online. The problem is that in kernel/sched.c::find_idlest_group()
> p->cpus_allowed is always 1 (it should be 3). I tried to put a dump_stack()
> or a printk(mask) in set_cpu_mask() but it crashes badly when mask is not 3,
> ie. anything different from khelper or kthread, so I couldn't know what sets
> the wrong cpumask.

Does this fix it?

diff --git a/kernel/sched.c b/kernel/sched.c
index b515e3c..3c8b1c5 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -6875,7 +6875,7 @@ void __init sched_init_smp(void)
 
 	lock_cpu_hotplug();
 	arch_init_sched_domains(&cpu_online_map);
-	cpus_andnot(non_isolated_cpus, cpu_online_map, cpu_isolated_map);
+	cpus_andnot(non_isolated_cpus, cpu_possible_map, cpu_isolated_map);
 	if (cpus_empty(non_isolated_cpus))
 		cpu_set(smp_processor_id(), non_isolated_cpus);
 	unlock_cpu_hotplug();

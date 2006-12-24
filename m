Return-Path: <pochini@shiny.it>
Received: from smtp-out13.alice.it (unknown [85.33.2.18])
	by ozlabs.org (Postfix) with ESMTP id 6A018DDE47
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Dec 2006 03:26:32 +1100 (EST)
Date: Sun, 24 Dec 2006 17:58:52 +0100
From: Giuliano Pochini <pochini@shiny.it>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: 2 CPUs, but only one is used
Message-Id: <20061224175852.1b52740a.pochini@shiny.it>
In-Reply-To: <20061220141655.GJ15713@localdomain>
References: <20061217144127.579f01f0.pochini@shiny.it>
	<20061220003545.7053b05c.pochini@shiny.it>
	<20061220141655.GJ15713@localdomain>
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

On Wed, 20 Dec 2006 08:16:55 -0600
Nathan Lynch <ntl@pobox.com> wrote:

> > > I have a dual G4 MDD mac running linux 2.6.19. When I boot with maxcpus=1 and
> > > then I issue "echo 1 >/sys/devices/system/cpu/cpu1/online" the second CPU is
> > > put online without errors, but it stays idle+wait=100% and of course
> > > user+system+nice=0%. It works fine without maxcpus=1. No problems with 2.6.18.
> > >
> > > I saw that there are some cpu hotplug related changes in 2.6.19, but I have
> > > no access to a non-ppc dual cpu box to check if the problem also affects
> > > other architectures right now.
> > 
> > I tried to reproduce the problem on an intel box, but I couldn't. /sys
> > contains only the cpu0 file if it boots with maxcpus=1.
> 
> Can you try to git bisect to find the change which caused the
> regression?
> 

I finally have some time to spend on this issue.

At the end of kernel/cpu.c::cpu_up() both cpus are set as present, possible
and online. The problem is that in kernel/sched.c::find_idlest_group()
p->cpus_allowed is always 1 (it should be 3). I tried to put a dump_stack()
or a printk(mask) in set_cpu_mask() but it crashes badly when mask is not 3,
ie. anything different from khelper or kthread, so I couldn't know what sets
the wrong cpumask.


--
Giuliano.

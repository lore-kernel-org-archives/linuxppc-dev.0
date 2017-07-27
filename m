Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJCQZ716zzDrJY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 23:25:25 +1000 (AEST)
Date: Thu, 27 Jul 2017 15:25:21 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: Possible circular locking dependency detected between
 cpu_hotplug_lock.rw_sem and wfc.work
In-Reply-To: <alpine.DEB.2.20.1707271523120.1903@nanos>
Message-ID: <alpine.DEB.2.20.1707271524580.1903@nanos>
References: <87mv7r5s1y.fsf@concordia.ellerman.id.au>
 <alpine.DEB.2.20.1707261437510.2186@nanos>
 <871sp2f20c.fsf@concordia.ellerman.id.au>
 <alpine.DEB.2.20.1707271523120.1903@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 27 Jul 2017, Thomas Gleixner wrote:
> On Thu, 27 Jul 2017, Michael Ellerman wrote:
> > Thomas Gleixner <tglx@linutronix.de> writes:
> > 
> > > On Wed, 26 Jul 2017, Michael Ellerman wrote:
> > >
> > >> Hi Thomas,
> > >> 
> > >> I'm seeing the lockdep barf below on some bare metal Power8 machines.
> > >> 
> > >> This seems to be caused by our smp_cpus_done(), which does:
> > >> 
> > >>   void __init smp_cpus_done(unsigned int max_cpus)
> > >>   {
> > >>   	/*
> > >>   	 * We want the setup_cpu() here to be called on the boot CPU, but
> > >>   	 * init might run on any CPU, so make sure it's invoked on the boot
> > >>   	 * CPU.
> > >>   	 */
> > >>   	if (smp_ops && smp_ops->setup_cpu)
> > >>   		work_on_cpu_safe(boot_cpuid, smp_setup_cpu_workfn, NULL);
> > >> 
> > >> 
> > >> I don't think CPU hotplug can happen at this point, so I don't think
> > >> there's really a bug.
> > >> 
> > >> But it looks like the work_on_cpu_safe() call could just go away, since
> > >> you pinned init to the boot CPU in 8fb12156b8db ("init: Pin init task to
> > >> the boot CPU, initially"). Though I can't see where init is unpinned, so
> > >> maybe we do still need to do it?
> > >
> > > It's undone in sched_init_smp(). So it looks safe. The call order is:
> > >
> > >      smp_init()
> > > 	...
> > > 	smp_cpus_done()
> > >
> > >      sched_init_smp()
> > 
> > Great thanks.
> > 
> > Patch on the way.
> 
> Hmm. Second thoughts. The issue is the stability of the CPUs. Surely the
> boot CPU can't go away at that point, but the debug stuff does not know
> about it. maybe I'm missing something ....

Ok. Now seeing your patch I know what I was missing :)

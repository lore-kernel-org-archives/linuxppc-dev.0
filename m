Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id CAD3067C45
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Aug 2006 00:42:10 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e991208eced0af7536e9f71bf6cb7016@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] powerpc: Improve IRQ radix tree locking
Date: Fri, 25 Aug 2006 09:42:03 -0500
To: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri Aug 25 16:04:52 EST 2006,  Benjamin Herrenschmidt wrote:
> When reworking the powerpc irq code, I figured out that we were using
> the radix tree in a racy way. As a temporary fix, I put a spinlock in
> there. However, this can have a significant impact on performances. 
> This
> patch reworks that to use a smarter technique based on the fact that
> what we need is in fact a rwlock with extremely rare writers (thus
> optimized for the read path).


> +static void irq_radix_wrlock(unsigned long *flags)
> +{
> +       unsigned int cpu, ok;
> +
> +       spin_lock_irqsave(&irq_big_lock, *flags);
> +       irq_radix_writer = 1;

I think the smp_mb() is needed after here

> +       do {
> +               ok = 1;
> +               smp_mb();

but not every time we poll the cpus.  We are only
updating our local variable ok which we have not
given anyone else.   It could even be a register.


> +               for_each_possible_cpu(cpu) {
> +                       if (per_cpu(irq_radix_reader, cpu)) {
> +                               ok = 0;
> +                               break;
> +                       }
> +               }
> +               if (!ok)
> +                       cpu_relax();

Hmmm.  the gcc barrier is conditional.   How about putting
barrier() before the ok=1 at the top, to avoid any optimization
blockage but still telling gcc you must read every time?

> +       } while(!ok);
> +}
> +

Oh, and how about some (un)likely in irq_radix_rdlock ?  It
could happen by default by why not show our expected path?


And, while I'm thinking of changes, when set ok=0 above add:
#ifdef CONFIG_SPINLOCK_DEBUG
                               BUG_ON(cpu == smp_processor_id());
#endif


Hmm... just thought of something .... we are spinning under
irq lock.  We are waiting on some other thread, but not
telling the hypervisor.   Should we confer our execution
over to the cpu we are waiting on?  I know, it sounds ugly
to call that code.   I guess we would want a
cpu_waiting_on(cpu) that calls cpu_relax and/or hypervisor.

milton

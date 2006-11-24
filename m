Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7790C67B6C
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Nov 2006 07:45:38 +1100 (EST)
Subject: Re: Worst case performance of up()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adrian Cox <adrian@humboldt.co.uk>
In-Reply-To: <1164385262.11292.76.camel@localhost.localdomain>
References: <1164385262.11292.76.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 25 Nov 2006 07:45:24 +1100
Message-Id: <1164401124.5653.86.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-11-24 at 16:21 +0000, Adrian Cox wrote:
> First the background: I've been investigating poor performance of a
> Firewire capture application, running on a dual-7450 board with a 2.6.17
> kernel. The kernel is based on a slightly earlier version of the
> mpc7448hpc2 board port, using arch/powerpc, which I've not yet updated
> to reflect the changes made when the board support entered the
> mainstream kernel. 
> 
> The application runs smoothly on a single processor. On the dual
> processor machine, the application sometimes suffers a drop in
> frame-rate, simultaneous with high CPU usage by the Firewire kernel
> thread.
> 
> Further investigation reveals that the kernel thread spends most of the
> time in one line: up(&fi->complete_sem) in __queue_complete_req() in
> drivers/iee1394/raw1394.c.  It seems that whenever the userspace thread
> calling raw1394_read() is scheduled on the opposite CPU to the kernel
> thread, the kernel thread takes much longer to execute up() - typically
> 10000 times longer.
> 
> Does anybody have any ideas what could make up() take so long in this
> circumstance? I'd expect cache transfers to make the operation about 100
> times slower, but this looks like repeated cache ping-pong between the
> two CPUs.

Is it hung in up() (toplevel) or __up (low level) ?

The former is mostly just a atomic_add_return which boils down to :

static __inline__ int atomic_add_return(int a, atomic_t *v)
{
        int t;

        __asm__ __volatile__(
        LWSYNC_ON_SMP
"1:     lwarx   %0,0,%2         # atomic_add_return\n\
        add     %0,%1,%0\n"
        PPC405_ERR77(0,%2)
"       stwcx.  %0,0,%2 \n\
        bne-    1b"
        ISYNC_ON_SMP
        : "=&r" (t)
        : "r" (a), "r" (&v->counter)
        : "cc", "memory");

        return t;
}

So yes, on SMP, you get an additional sync and isync in there, though
I'm surprised that you hit a code path where that would make such a big
difference (unless you are really up'ing a zillion times per sec).

Have you tried some oprofile runs to catch the exact instruction where
the cycles appear to be wasted ?

Maybe there is some contention on the reservation (though that would be
a bit strange to have a contention on a up...) or somewhat the semaphore
ends up sharing a cache line with something else. That would cause a
performance problem.

Have you tried moving the semaphore away from whatever other data might
be manipulated at the same time ? In it's own cache line maybe ?

Cheers,
Ben.

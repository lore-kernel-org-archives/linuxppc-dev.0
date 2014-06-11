Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 712801A03D5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 06:22:23 +1000 (EST)
Message-ID: <1402518131.14780.60.camel@pasglop>
Subject: Re: power and percpu: Could we move the paca into the percpu area?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Lameter <cl@gentwo.org>
Date: Thu, 12 Jun 2014 06:22:11 +1000
In-Reply-To: <alpine.DEB.2.10.1406111426480.10600@gentwo.org>
References: <alpine.DEB.2.10.1406111426480.10600@gentwo.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Tejun Heo <htejun@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-06-11 at 14:37 -0500, Christoph Lameter wrote:
> Looking at arch/powerpc/include/asm/percpu.h I see that the per cpu offset
> comes from a local_paca field and local_paca is in r13. That means that
> for all percpu operations we first have to determine the address through a
> memory access.
> 
> Would it be possible to put the paca at the beginning of the percpu data
> area and then have r31 point to the percpu area?
> 
> power has these nice instructions that fetch from an offset relative to a
> base register which could be used throughout for percpu operations in the
> kernel (similar to x86 segment registers).
> 
> With that we may also be able to use the atomic ops for fast percpu access
> so that we can avoid the irq enable/disable sequence that is now required
> for percpu atomics. Would result in fast and reliable percpu
> counters for powerpc.

So.... this is complicated :) And it's something I did want to tackle
for a while but haven't had a chance.

The issues off the top of my head are:

 - The PACA must be accessible in real mode, which means that when
running under a hypervisor, it must be allocated in the "RMA" which is
the low part of memory up to a limit that depends on the hypervisor, but
can be as low as 128M on some older machines.

 - However, we use percpu more than paca in normal kernel C code, the
PACA is mostly used during exception entry/exit, KVM, and for interrupt
soft-enable/disable. So it might make sense to change things so that r13
contains the per-cpu offset instead. However, doing that change and
updating the asm to cope isn't a trivial undertaking.

 - Direct offset from r13 in asm ... works as long as the offset is
within the signed 32k range. Otherwise we need at least one more addis
instruction. Anton mentioned the linker may have some smarts however for
removing that addis if the high part of the offset happens to be 0.

 - For atomics, the jury is still out as to whether it would be faster
or not. The atomic ops (lwarx/stwcx.) are expensive. They flush the
value out of the L1 (to L2) among others. On the other hand we have
interrupts soft-disable so masking interrupts isn't very expensive.
Unmasking, while cheap, is currently out of line however. I have been
wondering if we could move some of the soft-irq state instead to a CR
field and mark that -ffixed with gcc so we can make irq
soft-disable/enable even faster and more in-line.

Cheers,
Ben.

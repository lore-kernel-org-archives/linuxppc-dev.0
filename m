Return-Path: <paubert@iram.es>
Received: from marchena.puc.rediris.es (marchena.puc.rediris.es
 [130.206.18.21])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6583E1A0335
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 07:04:10 +1000 (EST)
Date: Wed, 11 Jun 2014 23:03:51 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: power and percpu: Could we move the paca into the percpu area?
Message-ID: <20140611210351.GA7155@visitor2.iram.es>
References: <alpine.DEB.2.10.1406111426480.10600@gentwo.org>
 <1402518131.14780.60.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1402518131.14780.60.camel@pasglop>
Cc: Tejun Heo <htejun@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Christoph Lameter <cl@gentwo.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 12, 2014 at 06:22:11AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2014-06-11 at 14:37 -0500, Christoph Lameter wrote:
> > Looking at arch/powerpc/include/asm/percpu.h I see that the per cpu offset
> > comes from a local_paca field and local_paca is in r13. That means that
> > for all percpu operations we first have to determine the address through a
> > memory access.
> > 
> > Would it be possible to put the paca at the beginning of the percpu data
> > area and then have r31 point to the percpu area?
> > 
> > power has these nice instructions that fetch from an offset relative to a
> > base register which could be used throughout for percpu operations in the
> > kernel (similar to x86 segment registers).
> > 
> > With that we may also be able to use the atomic ops for fast percpu access
> > so that we can avoid the irq enable/disable sequence that is now required
> > for percpu atomics. Would result in fast and reliable percpu
> > counters for powerpc.
> 
> So.... this is complicated :) And it's something I did want to tackle
> for a while but haven't had a chance.
> 
> The issues off the top of my head are:
> 
>  - The PACA must be accessible in real mode, which means that when
> running under a hypervisor, it must be allocated in the "RMA" which is
> the low part of memory up to a limit that depends on the hypervisor, but
> can be as low as 128M on some older machines.
> 
>  - However, we use percpu more than paca in normal kernel C code, the
> PACA is mostly used during exception entry/exit, KVM, and for interrupt
> soft-enable/disable. So it might make sense to change things so that r13
> contains the per-cpu offset instead. However, doing that change and
> updating the asm to cope isn't a trivial undertaking.
> 
>  - Direct offset from r13 in asm ... works as long as the offset is
> within the signed 32k range. Otherwise we need at least one more addis
> instruction. Anton mentioned the linker may have some smarts however for
> removing that addis if the high part of the offset happens to be 0.
> 
>  - For atomics, the jury is still out as to whether it would be faster
> or not. The atomic ops (lwarx/stwcx.) are expensive. They flush the
> value out of the L1 (to L2) among others. On the other hand we have
> interrupts soft-disable so masking interrupts isn't very expensive.
> Unmasking, while cheap, is currently out of line however. I have been
> wondering if we could move some of the soft-irq state instead to a CR
> field and mark that -ffixed with gcc so we can make irq
> soft-disable/enable even faster and more in-line.

Actually, from gcc/config/rs6000.h:

/* 1 for registers that have pervasive standard uses
   and are not available for the register allocator.

   On RS/6000, r1 is used for the stack.  On Darwin, r2 is available
   as a local register; for all other OS's r2 is the TOC pointer.

   cr5 is not supposed to be used.

   On System V implementations, r13 is fixed and not available for use.  */

#define FIXED_REGISTERS  \
  {0, 1, FIXED_R2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, FIXED_R13, 0, 0, \
   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
   0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1,          \
   /* AltiVec registers.  */                       \
   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
   1, 1                                            \
   , 1, 1, 1, 1, 1, 1                              \
}

So cr5, which is number 73, is never used by gcc. 
Disassembling a few kernels seems to confirm this.
This gives you 4 booleans to play with...

	Gabriel

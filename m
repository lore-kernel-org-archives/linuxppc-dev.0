Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A21F71A0065
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Oct 2014 17:39:57 +1100 (AEDT)
In-Reply-To: <alpine.DEB.2.11.1410211520470.20253@gentwo.org>
To: Christoph Lameter <cl@linux.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc: Replace __get_cpu_var uses
Message-Id: <20141029063957.76C6014008E@ozlabs.org>
Date: Wed, 29 Oct 2014 17:39:57 +1100 (AEDT)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-21-10 at 20:23:25 UTC, Christoph Lameter wrote:
> This still has not been merged and now powerpc is the only arch that does
> not have this change. Sorry about missing linuxppc-dev before.
> 
> --- linux.orig/arch/powerpc/include/asm/hardirq.h
> +++ linux/arch/powerpc/include/asm/hardirq.h
> @@ -21,7 +21,9 @@ DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpust
> 
>  #define __ARCH_IRQ_STAT
> 
> -#define local_softirq_pending()	__get_cpu_var(irq_stat).__softirq_pending
> +#define local_softirq_pending()	__this_cpu_read(irq_stat.__softirq_pending)
> +#define set_softirq_pending(x) __this_cpu_write(irq_stat._softirq_pending, (x))
> +#define or_softirq_pending(x) __this_cpu_or(irq_stat._softirq_pending, (x))

This breaks the build, because we also get the version of set_ and or_ from
include/linux/interrupt.h, and then because it's __softirq_pending.

Fixed by adding:

#define __ARCH_SET_SOFTIRQ_PENDING

And fixing the typo.

> --- linux.orig/arch/powerpc/kernel/process.c
> +++ linux/arch/powerpc/kernel/process.c
> @@ -499,7 +499,7 @@ static inline int set_dawr(struct arch_h
> 
>  void __set_breakpoint(struct arch_hw_breakpoint *brk)
>  {
> -	__get_cpu_var(current_brk) = *brk;
> +	__this_cpu_write(current_brk, *brk);

This breaks the build because we're trying to do a structure assignment but
__this_cpu_write() only supports certain sizes.

I replaced it with this which I think is right?

	memcpy(this_cpu_ptr(&current_brk), brk, sizeof(*brk));


cheers

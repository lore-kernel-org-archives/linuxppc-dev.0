Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40717N6QHTzDrJm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 22:11:12 +1100 (AEDT)
In-Reply-To: <20180321022228.9606-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64s: Fix lost pending interrupt due to race causing lost
 update to irq_happened
Message-Id: <40717N3jvQz9s0t@ozlabs.org>
Date: Fri, 23 Mar 2018 22:11:11 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-03-21 at 02:22:28 UTC, Nicholas Piggin wrote:
> force_external_irq_replay() can be called in the do_IRQ path with
> interrupts hard enabled and soft disabled if may_hard_irq_enable() set
> MSR[EE]=1. It updates local_paca->irq_happened with a load, modify,
> store sequence. If a maskable interrupt hits during this sequence, it
> will go to the masked handler to be marked pending in irq_happened.
> This update will be lost when the interrupt returns and the store
> instruction executes.  This can result in unpredictable latencies,
> timeouts, lockups, etc.
> 
> Fix this by ensuring hard interrupts are disabled before modifying
> irq_happened.
> 
> This could cause any maskable asynchronous interrupt to get lost, but
> it was noticed on P9 SMP system doing RDMA NVMe target over 100GbE,
> so very high external interrupt rate and high IPI rate. The hang was
> bisected down to enabling doorbell interrupts for IPIs. These provided
> an interrupt type that could run at high rates in the do_IRQ path,
> stressing the race.
> 
> Fixes: 1d607bb3bd ("powerpc/irq: Add mechanism to force a replay of interrupts")
> Reported-by: Carol L. Soto <clsoto@us.ibm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/ff6781fd1bb404d8a551c02c35c70c

cheers

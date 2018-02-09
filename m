Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zd1Yt4xKBzF18f
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 15:00:34 +1100 (AEDT)
In-Reply-To: <20180203071750.6469-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64s: fix may_hard_irq_enable for PMI soft masking
Message-Id: <3zd1Yt1bR4z9s72@ozlabs.org>
Date: Fri,  9 Feb 2018 15:00:34 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2018-02-03 at 07:17:50 UTC, Nicholas Piggin wrote:
> The soft IRQ masking code has to hard-disable interrupts in cases
> where the exception is not cleared by the masked handler. External
> interrupts used this approach for soft masking. Now recently PMU
> interrupts do the same thing.
> 
> The soft IRQ masking code additionally allowed for interrupt handlers
> to hard-enable interrupts after soft-disabling them. The idea is to
> allow PMU interrupts through to profile interrupt handlers.
> 
> So when interrupts are being replayed when there is a pending
> interrupt that requires hard-disabling, there is a test to prevent
> those handlers from hard-enabling them if there is a pending external
> interrupt. may_hard_irq_enable() handles this.
> 
> After f442d00480 ("powerpc/64s: Add support to mask perf interrupts
> and replay them"), may_hard_irq_enable() could prematurely enable
> MSR[EE] when a PMU exception exists, which would result in the
> interrupt firing again while masked, and MSR[EE] being disabled again.
> 
> I haven't seen that this could cause a serious problem, but it's
> more consistent to handle these soft-masked interrupts in the same
> way. So introduce a define for all types of interrupts that require
> MSR[EE] masking in their soft-disable handlers, and use that in
> may_hard_irq_enable().
> 
> Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/6cc3f91bf69fc8c1719704607474f9

cheers

Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNQz157cLzDqJC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 20:19:41 +1000 (AEST)
In-Reply-To: <20170801135928.22262-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64: Fix __check_irq_replay missing decrementer interrupt
Message-Id: <3xNQz124t5z9s65@ozlabs.org>
Date: Thu,  3 Aug 2017 20:19:41 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-08-01 at 13:59:28 UTC, Nicholas Piggin wrote:
> If the decrementer wraps and de-asserts the decrementer exception while
> hard-disabled, __check_irq_replay has a test to notice the wrap when
> interrupts are re-enabled.
> 
> The decrementer check must be done when clearing the PACA_IRQ_HARD_DIS
> flag, not when the PACA_IRQ_DEC flag is tested. Previously this worked
> because the decrementer interrupt was always the first one checked after
> clearing the hard disable flag, but HMI check was moved ahead of that,
> which introduced this bug.
> 
> This can cause a missed decrementer interrupt if we soft-disable
> interrupts then take an HMI which is recorded in irq_happened, then
> hard-disable interrupts for > 4s to wrap the decrementer.
> 
> Fixes: e0e0d6b739 ("powerpc/64: Replay hypervisor maintenance interrupt first")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/f283f06014c36acd1ce7f71985b8a3

cheers

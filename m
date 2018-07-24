Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Zg390QNyzDqyZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 23:59:49 +1000 (AEST)
In-Reply-To: <20180603122432.617-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v2] powerpc/64s: make PACA_IRQ_HARD_DIS track MSR[EE] closely
Message-Id: <41Zg386ybRz9s4V@ozlabs.org>
Date: Tue, 24 Jul 2018 23:59:48 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2018-06-03 at 12:24:32 UTC, Nicholas Piggin wrote:
> When the masked interrupt handler clears MSR[EE] for an interrupt in
> the PACA_IRQ_MUST_HARD_MASK set, it does not set PACA_IRQ_HARD_DIS.
> This makes them get out of synch.
> 
> With that taken into account, it's only low level irq manipulation
> (and interrupt entry before reconcile) where they can be out of synch.
> This makes the code less surprising.
> 
> It also allows the IRQ replay code to rely on the IRQ_HARD_DIS value
> and not have to mtmsrd again in this case (e.g., for an external
> interrupt that has been masked). The bigger benefit might just be
> that there is not such an element of surprise in these two bits of
> state.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9b81c0211c249c1bc8caec2ddbc86e

cheers

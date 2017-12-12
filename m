Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ywyXd6BQhzDqmD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 22:39:29 +1100 (AEDT)
In-Reply-To: <20171116160052.18672-3-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [2/4] powerpc/64: do not trace irqs-off at interrupt return to
 soft-disabled context
Message-Id: <3ywyXc72Dlz9t88@ozlabs.org>
Date: Tue, 12 Dec 2017 22:39:28 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-11-16 at 16:00:50 UTC, Nicholas Piggin wrote:
> When an interrupt is returning to a soft-disabled context (which can
> happen for non-maskable interrupts or synchronous interrupts), it goes
> through the motions of soft-disabling again, including calling
> TRACE_DISABLE_INTS (i.e., trace_hardirqs_off()).
> 
> This is not necessary, because we must already be soft-disabled in the
> interrupt context, it also may be causing crashes in the irq tracing
> code to re-enter as an nmi. Replace it with a warning to ensure that
> soft-interrupts are still disabled.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/acb1feab320e38588fccc568e37677

cheers

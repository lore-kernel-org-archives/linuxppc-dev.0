Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wGTdl1tBTzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 May 2017 12:58:51 +1000 (AEST)
In-Reply-To: <20170320063149.3068-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [1/2] powerpc/pasemi: do not process external or decrementer
 interrupts from sreset
Message-Id: <3wGTdl0j43z9sDB@ozlabs.org>
Date: Mon,  1 May 2017 12:58:51 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-03-20 at 06:31:48 UTC, Nicholas Piggin wrote:
> PA Semi will wake from low power state at the system reset interrupt,
> with the event encoded in SRR1, rather than waking at the interrupt
> vector that corresponds to that event.
> 
> The system reset handler for this platform decodes SRR1 event reason
> and calls the interrupt handler to process it directly from the system
> reset handlre.
> 
> A subsequent change will treat the system reset interrupt as a Linux NMI
> with its own per-CPU stack, and this will no longer work. Remove the
> external and decrementer handlers from the system reset handler.
> 
> - The external exception remains raised and will fire again at the
>   EE interrupt vector when system reset returns.
> 
> - The decrementer is set to 1 so it will be raised again and fire when
>   the system reset returns.
> 
> It is possible to branch to an idle handler from the system reset
> interrupt (like POWER does), then restore a normal stack and restore
> this optimisation. But simplicity wins for now.
> 
> Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/461e96a3374892d551fe270a975f33

cheers

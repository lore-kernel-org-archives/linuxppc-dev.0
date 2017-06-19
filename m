Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrqv93RFkzDqjl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 22:25:41 +1000 (AEST)
In-Reply-To: <20170613130557.26315-4-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [03/13] powerpc/64s: idle process interrupts from system reset
 wakeup
Message-Id: <3wrqv92rzZz9sBR@ozlabs.org>
Date: Mon, 19 Jun 2017 22:25:41 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-06-13 at 13:05:47 UTC, Nicholas Piggin wrote:
> When the CPU wakes from low power state, it begins at the system reset
> interrupt with the exception that caused the wakeup encoded in SRR1.
> 
> Today, powernv idle wakeup ignores the wakeup reason (except a special
> case for HMI), and the regular interrupt corresponding to the
> exception will fire after the idle wakeup exits.
> 
> Change this to replay the interrupt from the idle wakeup before
> interrupts are hard-enabled.
> 
> Test on POWER8 of context_switch selftests benchmark with polling idle
> disabled (e.g., always nap, giving cross-CPU IPIs) gives the following
> results:
> 
>                                 original         wakeup direct
> Different threads, same core:   315k/s           264k/s
> Different cores:                235k/s           242k/s
> 
> There is a slowdown for doorbell IPI (same core) case because system
> reset wakeup does not clear the message and the doorbell interrupt
> fires again needlessly.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/771d4304d07f080b6ce751e12f3579

cheers

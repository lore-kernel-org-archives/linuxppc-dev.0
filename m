Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Y7SY6fSYzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Apr 2018 21:12:45 +1000 (AEST)
In-Reply-To: <20180427015159.17270-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v2] powerpc: Fix deadlock with multiple calls to smp_send_stop
Message-Id: <40Y7SY5c3Cz9s16@ozlabs.org>
Date: Sat, 28 Apr 2018 21:12:45 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-04-27 at 01:51:59 UTC, Nicholas Piggin wrote:
> smp_send_stop can lock up the IPI path for any subsequent calls,
> because the receiving CPUs spin in their handler function. This
> started becoming a problem with the addition of an smp_send_stop
> call in the reboot path, because panics can reboot after doing
> their own smp_send_stop.
> 
> The NMI IPI variant was fixed with ac61c11566 ("powerpc: Fix
> smp_send_stop NMI IPI handling"), which leaves the smp_call_function
> variant.
> 
> This is fixed by having smp_send_stop only ever do the
> smp_call_function once. This is a bit less robust than the NMI IPI
> fix, because any other call to smp_call_function after smp_send_stop
> could deadlock, but that has always been the case, and it was not
> been a problem before.
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Fixes: f2748bdfe1573 ("powerpc/powernv: Always stop secondaries before reboot/shutdown")
> Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/6029755eed95e5c90f763188c87ae3

cheers

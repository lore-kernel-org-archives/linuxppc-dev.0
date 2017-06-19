Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrqv53HpbzDqkM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 22:25:37 +1000 (AEST)
In-Reply-To: <20170608153505.18857-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [1/2] powerpc/64s: syscall optimize hypercall/syscall entry
Message-Id: <3wrqv51dPqz9s8V@ozlabs.org>
Date: Mon, 19 Jun 2017 22:25:37 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-06-08 at 15:35:04 UTC, Nicholas Piggin wrote:
> After bc3551257a ("powerpc/64: Allow for relocation-on interrupts from
> guest to host"), a getppid() system call goes from 307 cycles to 358
> cycles (+17%) on POWER8. This is due significantly to the scratch SPR
> used by the hypercall check.
> 
> It turns out there are a some volatile registers common to both system
> call and hypercall (in particular, r12, cr0, ctr), which can be used to
> avoid the SPR and some other overheads. This brings getppid to 320 cycles
> (+4%).
> 
> Testing hcall entry performance by running "sc 1" in guest userspace
> before this patch is 854 cycles, afterwards is 826. Also a small win
> there.
> 
> POWER9 syscall is improved by about the same amount, hcall not tested.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/acd7d8cef01537062e318143d70035

cheers

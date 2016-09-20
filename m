Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdjhp6HhzzDsfs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 23:07:22 +1000 (AEST)
In-Reply-To: <20160915090321.787-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64s: optimise syscall entry for virtual, relocatable case
Message-Id: <3sdjhp5Kjqz9syB@ozlabs.org>
Date: Tue, 20 Sep 2016 23:07:22 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-15-09 at 09:03:21 UTC, Nicholas Piggin wrote:
> The mflr r10 instruction was left over saving of lr when the code used
> lr to branch to system_call_entry from the exception handler. That was
> changed by 6a404806d to use the count register. The value is never used
> now, so mflr can be removed, and r10 can be used for storage rather than
> spilling to the SPR scratch register.
> 
> The scratch register spill causes a long pipeline stall due to the SPR
> read after write. This change brings getppid syscall cost from 406 to
> 376 cycles on POWER8. getppid for non-relocatable case is 371 cycles.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/18e3f56b1cacb96017e2a66844

cheers

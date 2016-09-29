Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slFPS2dKvzDsjG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 23:13:16 +1000 (AEST)
In-Reply-To: <1474787813-22587-1-git-send-email-anton@ozlabs.org>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/vdso64: Use double word compare on pointers
Message-Id: <3slFPS1qsqz9sDG@ozlabs.org>
Date: Thu, 29 Sep 2016 23:13:16 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-25-09 at 07:16:53 UTC, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> __kernel_get_syscall_map and __kernel_clock_getres use cmpli to
> check if the passed in pointer is non zero. cmpli maps to a 32 bit
> compare on binutils, so we ignore the top 32 bits.
> 
> A simple test case can be created by passing in a bogus pointer with
> the bottom 32 bits clear. Using a clk_id that is handled by the VDSO,
> then one that is handled by the kernel shows the problem:
> 
>         printf("%d\n", clock_getres(CLOCK_REALTIME, (void *)0x100000000));
>         printf("%d\n", clock_getres(CLOCK_BOOTTIME, (void *)0x100000000));
> 
> And we get:
> 
> 0
> -1
> 
> The bigger issue is if we pass a valid pointer with the bottom 32 bits
> clear, in this case we will return success but won't write any data
> to the pointer.
> 
> I stumbled across this issue because the LLVM integrated assembler
> doesn't accept cmpli with 3 arguments. Fix this by converting them to
> cmpldi.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Anton Blanchard <anton@samba.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5045ea37377ce8cca6890d32b127ad

cheers

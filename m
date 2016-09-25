Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3shWzv4mKNzDrLj
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Sep 2016 13:00:11 +1000 (AEST)
In-Reply-To: <20160913030846.29790-3-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [2/8] powerpc/pseries: syscall remove trampoline
Message-Id: <3shWzv3bY8z9sf6@ozlabs.org>
Date: Sun, 25 Sep 2016 13:00:11 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-13-09 at 03:08:40 UTC, Nicholas Piggin wrote:
> The syscall trampoline is not required, remove it.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a24553dd02dc6c7d2912af0b4b

I rewrote the change log to be:

    powerpc/pseries: Remove unnecessary syscall trampoline

    When we originally added the ability to split the exception vectors from
    the kernel (commit 1f6a93e4c35e ("powerpc: Make it possible to move the
    interrupt handlers away from the kernel" 2008-09-15)), the LOAD_HANDLER() macro
    used an addi instruction to compute the offset of the common handler
    from the kernel base address.

    Using addi meant the handler had to be within 32K of the kernel base
    address, due to the addi instruction taking a signed immediate value.
    That necessitated creating a trampoline for the system call handler,
    because system_call_common (in entry64.S) is not linked within 32K of
    the kernel base address.

    Later in commit 61e2390ede3c ("powerpc: Make load_hander handle upto 64k
    offset" 2012-11-15) we changed LOAD_HANDLER to take a 64K offset, by
    changing it to use ori.

    Although system_call_common is not in head_64.S or exceptions-64s.S, it
    is included in head-y, which causes it to be linked early in the kernel
    text, so in practice it ends up below 64K. Additionally if it can't be
    placed below 64K the linker will fail to build with a "relocation
    truncated to fit" error.

    So remove the trampoline.

    Newer toolchains are able to work out that the ori in LOAD_HANDLER only
    takes a 16 bit offset, and so they generate a 16 bit relocation. Older
    toolchains (binutils 2.22 at least) are not so smart, so we have to add
    the @l annotation to tell the assembler to generate a 16 bit relocation.

cheers

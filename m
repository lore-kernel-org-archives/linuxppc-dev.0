Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spfzr0pjXzDrKS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 13:36:24 +1100 (AEDT)
In-Reply-To: <20160923061826.30790-3-cyrilbur@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v5,
 02/20] powerpc: Always restore FPU/VEC/VSX if hardware transactional
 memory in use
Message-Id: <3spfzq6qXzz9s9c@ozlabs.org>
Date: Wed,  5 Oct 2016 13:36:23 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-23-09 at 06:18:08 UTC, Cyril Bur wrote:
> Comment from arch/powerpc/kernel/process.c:967:
>  If userspace is inside a transaction (whether active or
>  suspended) and FP/VMX/VSX instructions have ever been enabled
>  inside that transaction, then we have to keep them enabled
>  and keep the FP/VMX/VSX state loaded while ever the transaction
>  continues.  The reason is that if we didn't, and subsequently
>  got a FP/VMX/VSX unavailable interrupt inside a transaction,
>  we don't know whether it's the same transaction, and thus we
>  don't know which of the checkpointed state and the ransactional
>  state to use.
> 
> restore_math() restore_fp() and restore_altivec() currently may not
> restore the registers. It doesn't appear that this is more serious
> than a performance penalty. If the math registers aren't restored the
> userspace thread will still be run with the facility disabled.
> Userspace will not be able to read invalid values. On the first access
> it will take an facility unavailable exception and the kernel will
> detected an active transaction, at which point it will abort the
> transaction. There is the possibility for a pathological case
> preventing any progress by transactions, however, transactions
> are never guaranteed to make progress.
> 
> Fixes: 70fe3d9 ("powerpc: Restore FPU/VEC/VSX if previously used")
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/dc16b553c949e81f37555777dc7bab

cheers

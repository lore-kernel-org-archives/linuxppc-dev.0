Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tVL1r139YzDw3H
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 14:56:48 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ben Hutchings <ben@decadent.org.uk>, linuxppc-dev@lists.ozlabs.org
Cc: Alexander Graf <agraf@suse.de>,
 Benjamin Herrenschmidt  <benh@kernel.crashing.org>, <paulus@samba.org>
Subject: Re: [PATCH 1/2] powerpc: Remove Mac-on-Linux hooks
In-Reply-To: <20161202023552.GJ2697@decadent.org.uk>
References: <20161202023552.GJ2697@decadent.org.uk>
Date: Fri, 02 Dec 2016 14:56:47 +1100
Message-ID: <87a8cf7zls.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben Hutchings <ben@decadent.org.uk> writes:

> [ Unknown signature status ]
> The symbols exported for use by MOL aren't getting CRCs and I was
> about to fix that.  But MOL is dead upstream, and the latest work on
> it was to make it use KVM instead of its own kernel module.  So remove
> them instead.

Sounds good to me.

> diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
> index 9d963547d243..87998430cd9b 100644
> --- a/arch/powerpc/kernel/head_32.S
> +++ b/arch/powerpc/kernel/head_32.S
> @@ -735,11 +735,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
>  	EXCEPTION(0x2c00, Trap_2c, unknown_exception, EXC_XFER_EE)
>  	EXCEPTION(0x2d00, Trap_2d, unknown_exception, EXC_XFER_EE)
>  	EXCEPTION(0x2e00, Trap_2e, unknown_exception, EXC_XFER_EE)
> -	EXCEPTION(0x2f00, MOLTrampoline, unknown_exception, EXC_XFER_EE_LITE)
> -
> -	.globl mol_trampoline
> -	.set mol_trampoline, i0x2f00
> -	EXPORT_SYMBOL(mol_trampoline)
> +	EXCEPTION(0x2f00, Trap_2f, unknown_exception, EXC_XFER_EE)
>  
>  	. = 0x3000
>  
> @@ -1289,7 +1285,6 @@ intercept_table:
>  	.long 0, 0, 0, 0, 0, 0, 0, 0
>  	.long 0, 0, 0, 0, 0, 0, 0, 0
>  	.long 0, 0, 0, 0, 0, 0, 0, 0
> -EXPORT_SYMBOL(intercept_table)

I don't see intercept_table used anywhere, so I think we can just remove
it entirely?

> diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
> index 09cc50c8dace..cddf14f60bf3 100644
> --- a/arch/powerpc/mm/hash_low_32.S
> +++ b/arch/powerpc/mm/hash_low_32.S
> @@ -34,7 +34,6 @@
>  	.globl mmu_hash_lock
>  mmu_hash_lock:
>  	.space	4
> -EXPORT_SYMBOL(mmu_hash_lock)
>  #endif /* CONFIG_SMP */

And now mmu_hash_lock is only used in this file, so doesn't need to be
global anymore.

I can fix both of those up here, will just wait a bit to see if anyone
else has comments.

cheers

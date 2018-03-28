Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B6sj6ZtdzF28V
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 23:40:09 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Anton Blanchard <anton@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc: Fix smp_wmb barrier definition use use lwsync
 consistently
In-Reply-To: <20180322104146.5350-1-npiggin@gmail.com>
References: <20180322104146.5350-1-npiggin@gmail.com>
Date: Wed, 28 Mar 2018 23:40:05 +1100
Message-ID: <874ll02x22.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> asm/barrier.h is not always included after asm/synch.h, which meant
> it was missing __SUBARCH_HAS_LWSYNC, so in some files smp_wmb() would
> be eieio when it should be lwsync. kernel/time/hrtimer.c is one case.

Wow nice catch. Only broken since 2008 presumably.

Some days I think maybe we aren't very good at this writing software
thing, good to have some certainty :)

> __SUBARCH_HAS_LWSYNC is only used in one place, so just fold it in
> to where it's used. Previously with my small simulator config, 377
> instances of eieio in the tree. After this patch there are 55.

At least for Book3S this isn't actually a terrible bug AFAICS:

 - smp_wmb() is only defined to order accesses to cacheable memory.
 - smp_wmb() only orders prior stores vs later stores.
 - eieio orders all prior stores vs all later stores for cacheable
   memory.
 - lwsync orders everything except prior stores vs later loads for
   cacheable memory.

So eieio and lwsync are both valid to use as smp_wmb(), but it's still
terrible fishy that we were using both in different places depending on
include ordering.

I'm inclined to tag this for stable unless anyone can think of a reason
not to?

cheers

> diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
> index 10daa1d56e0a..c7c63959ba91 100644
> --- a/arch/powerpc/include/asm/barrier.h
> +++ b/arch/powerpc/include/asm/barrier.h
> @@ -35,7 +35,8 @@
>  #define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
>  #define wmb()  __asm__ __volatile__ ("sync" : : : "memory")
>  
> -#ifdef __SUBARCH_HAS_LWSYNC
> +/* The sub-arch has lwsync */
> +#if defined(__powerpc64__) || defined(CONFIG_PPC_E500MC)
>  #    define SMPWMB      LWSYNC
>  #else
>  #    define SMPWMB      eieio
> diff --git a/arch/powerpc/include/asm/synch.h b/arch/powerpc/include/asm/synch.h
> index 63e7f5a1f105..6ec546090ba1 100644
> --- a/arch/powerpc/include/asm/synch.h
> +++ b/arch/powerpc/include/asm/synch.h
> @@ -6,10 +6,6 @@
>  #include <linux/stringify.h>
>  #include <asm/feature-fixups.h>
>  
> -#if defined(__powerpc64__) || defined(CONFIG_PPC_E500MC)
> -#define __SUBARCH_HAS_LWSYNC
> -#endif
> -
>  #ifndef __ASSEMBLY__
>  extern unsigned int __start___lwsync_fixup, __stop___lwsync_fixup;
>  extern void do_lwsync_fixups(unsigned long value, void *fixup_start,
> -- 
> 2.16.1

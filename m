Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHmYG4qykzDqjP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 22:14:58 +1100 (AEDT)
Subject: Re: [PATCH 2/2] powerpc/lib: Implement UACCESS_FLUSHCACHE API
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20171019071355.15324-1-oohall@gmail.com>
 <20171019071355.15324-2-oohall@gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <d9a12e8d-5cc4-1e20-b11a-4e8ee79c5e93@c-s.fr>
Date: Thu, 19 Oct 2017 13:14:53 +0200
MIME-Version: 1.0
In-Reply-To: <20171019071355.15324-2-oohall@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 19/10/2017 à 09:13, Oliver O'Halloran a écrit :
> Implement the architecture specific portitions of the UACCESS_FLUSHCACHE
> API. This provides functions for the copy_user_flushcache iterator that
> ensure that when the copy is finished the destination buffer contains
> a copy of the original and that the destination buffer is clean in the
> processor caches.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
>   arch/powerpc/Kconfig               |  1 +
>   arch/powerpc/include/asm/string.h  |  2 ++
>   arch/powerpc/include/asm/uaccess.h |  5 +++++
>   arch/powerpc/lib/pmem.c            | 33 +++++++++++++++++++++++++++++++++
>   4 files changed, 41 insertions(+)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 0996add8a572..09a207468f8b 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -142,6 +142,7 @@ config PPC
>   	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE
>   	select ARCH_HAS_SG_CHAIN
>   	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
> +	select ARCH_HAS_UACCESS_FLUSHCACHE	if PPC64

Same as previous patch in the serye, why restrict it to PPC64 ?

Christophe

>   	select ARCH_HAS_UBSAN_SANITIZE_ALL
>   	select ARCH_HAS_ZONE_DEVICE		if PPC_BOOK3S_64
>   	select ARCH_HAVE_NMI_SAFE_CMPXCHG
> diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
> index cc9addefb51c..2796eda17d92 100644
> --- a/arch/powerpc/include/asm/string.h
> +++ b/arch/powerpc/include/asm/string.h
> @@ -11,6 +11,7 @@
>   #define __HAVE_ARCH_MEMCMP
>   #define __HAVE_ARCH_MEMCHR
>   #define __HAVE_ARCH_MEMSET16
> +#define __HAVE_ARCH_MEMCPY_FLUSHCACHE
>   
>   extern char * strcpy(char *,const char *);
>   extern char * strncpy(char *,const char *, __kernel_size_t);
> @@ -23,6 +24,7 @@ extern void * memcpy(void *,const void *,__kernel_size_t);
>   extern void * memmove(void *,const void *,__kernel_size_t);
>   extern int memcmp(const void *,const void *,__kernel_size_t);
>   extern void * memchr(const void *,int,__kernel_size_t);
> +extern void * memcpy_flushcache(void *,const void *,__kernel_size_t);
>   
>   #ifdef CONFIG_PPC64
>   #define __HAVE_ARCH_MEMSET32
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index 9c0e60ca1666..e9c88b72584f 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -339,4 +339,9 @@ static inline unsigned long clear_user(void __user *addr, unsigned long size)
>   extern long strncpy_from_user(char *dst, const char __user *src, long count);
>   extern __must_check long strnlen_user(const char __user *str, long n);
>   
> +extern long __copy_from_user_flushcache(void *dst, const void __user *src,
> +		unsigned size);
> +extern void memcpy_page_flushcache(char *to, struct page *page, size_t offset,
> +			   size_t len);
> +
>   #endif	/* _ARCH_POWERPC_UACCESS_H */
> diff --git a/arch/powerpc/lib/pmem.c b/arch/powerpc/lib/pmem.c
> index 0fa09262ca13..53c018762e1c 100644
> --- a/arch/powerpc/lib/pmem.c
> +++ b/arch/powerpc/lib/pmem.c
> @@ -13,6 +13,7 @@
>   
>   #include <linux/string.h>
>   #include <linux/export.h>
> +#include <linux/uaccess.h>
>   
>   #include <asm/cacheflush.h>
>   
> @@ -32,3 +33,35 @@ void arch_invalidate_pmem(void *addr, size_t size)
>   	flush_inval_dcache_range(start, start + size);
>   }
>   EXPORT_SYMBOL(arch_invalidate_pmem);
> +
> +/*
> + * CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE symbols
> + */
> +long __copy_from_user_flushcache(void *dest, const void __user *src,
> +		unsigned size)
> +{
> +	unsigned long copied, start = (unsigned long) dest;
> +
> +	copied = __copy_from_user(dest, src, size);
> +	flush_inval_dcache_range(start, start + size);
> +
> +	return copied;
> +}
> +
> +void *memcpy_flushcache(void *dest, const void *src, size_t size)
> +{
> +	unsigned long start = (unsigned long) dest;
> +
> +	memcpy(dest, src, size);
> +	flush_inval_dcache_range(start, start + size);
> +
> +	return dest;
> +}
> +EXPORT_SYMBOL(memcpy_flushcache);
> +
> +void memcpy_page_flushcache(char *to, struct page *page, size_t offset,
> +	size_t len)
> +{
> +	memcpy_flushcache(to, page_to_virt(page) + offset, len);
> +}
> +EXPORT_SYMBOL(memcpy_page_flushcache);
> 

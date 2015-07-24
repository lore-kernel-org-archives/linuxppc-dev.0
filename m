Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B8FD91A0743
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2015 16:47:00 +1000 (AEST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 95C80140B04
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Jul 2015 16:46:56 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 24 Jul 2015 16:46:41 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7A8F72CE8050
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Jul 2015 16:46:39 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6O6kR9Z27852884
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Jul 2015 16:46:35 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6O6k6TO021194
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Jul 2015 16:46:07 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: Michael Neuling <mikey@neuling.org>, cyrilbur@gmail.com
Subject: Re: [PATCH] powerpc/mm: Fix pte_pagesize_index() crash on 4K w/64K
 hash
In-Reply-To: <1437715135-5131-1-git-send-email-mpe@ellerman.id.au>
References: <1437715135-5131-1-git-send-email-mpe@ellerman.id.au>
Date: Fri, 24 Jul 2015 12:15:46 +0530
Message-ID: <87si8eyrxh.fsf@linux.vnet.ibm.com>
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

Michael Ellerman <mpe@ellerman.id.au> writes:

> The powerpc kernel can be built to have either a 4K PAGE_SIZE or a 64K
> PAGE_SIZE.
>
> However when built with a 4K PAGE_SIZE there is an additional config
> option which can be enabled, PPC_HAS_HASH_64K, which means the kernel
> also knows how to hash a 64K page even though the base PAGE_SIZE is 4K.
>
> This is used in one obscure configuration, to support 64K pages for SPU
> local store on the Cell processor when the rest of the kernel is using
> 4K pages.
>
> In this configuration, pte_pagesize_index() is defined to just pass
> through its arguments to get_slice_psize(). However pte_pagesize_index()
> is called for both user and kernel addresses, whereas get_slice_psize()
> only knows how to handle user addresses.
>
> This has been broken forever, however until recently it happened to
> work. That was because in get_slice_psize() the large kernel address
> would cause the right shift of the slize mask to return zero.
>
> However in commit 7aa0727f3302 "powerpc/mm: Increase the slice range to
> 64TB", the get_slice_psize() code was changed so that instead of a right
> shift we do an array lookup based on the address. When passed a kernel
> address this means we index way off the end of the slice array and
> return random junk.
>
> That is only fatal if we happen to hit something non-zero, but when we
> do return a non-zero value we confuse the MMU code and eventually cause
> a check stop.
>
> This fix is ugly, but simple. When we're called for a kernel address we
> return 4K, which is always correct in this configuration, otherwise we
> use the slice mask.
>
> Fixes: 7aa0727f3302 ("powerpc/mm: Increase the slice range to 64TB")
> Reported-by: Cyril Bur <cyrilbur@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/pgtable-ppc64.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
> index 3bb7488bd24b..330ae1d81662 100644
> --- a/arch/powerpc/include/asm/pgtable-ppc64.h
> +++ b/arch/powerpc/include/asm/pgtable-ppc64.h
> @@ -135,7 +135,15 @@
>  #define pte_iterate_hashed_end() } while(0)
>  
>  #ifdef CONFIG_PPC_HAS_HASH_64K
> -#define pte_pagesize_index(mm, addr, pte)	get_slice_psize(mm, addr)
> +#define pte_pagesize_index(mm, addr, pte)			\
> +	({							\
> +		unsigned int psize;				\
> +		if (is_kernel_addr(addr))			\
> +			psize = MMU_PAGE_4K;			\
> +		else						\
> +			psize = get_slice_psize(mm, addr);	\
> +		psize;						\
> +	})
>  #else
>  #define pte_pagesize_index(mm, addr, pte)	MMU_PAGE_4K
>  #endif

That is confusing, because we enable PPC_HASH_HAS_64K for 64K page size
too. why not

psize = mmu_virtual_psize;


But that leave another question. What if kernel address used 16MB
mapping ? Or are we going to get a call for pte_pagesize_index, only for
vmalloc area of the kernel ? In any case, this need more comment
explaining the caller and possibly DEBUG_VM WARN_ON() to catch wrong
users ?

-aneesh

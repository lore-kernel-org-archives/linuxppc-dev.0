Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C07D1A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 15:34:41 +1000 (AEST)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A24081401E7
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 15:34:40 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 10 Aug 2015 11:04:38 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 3/5] powerpc/mm: Drop the 64K on 4K version of
 pte_pagesize_index()
In-Reply-To: <1438928387-6454-3-git-send-email-mpe@ellerman.id.au>
References: <1438928387-6454-1-git-send-email-mpe@ellerman.id.au>
 <1438928387-6454-3-git-send-email-mpe@ellerman.id.au>
Date: Mon, 10 Aug 2015 11:04:29 +0530
Message-ID: <87y4hjpuze.fsf@linux.vnet.ibm.com>
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

> Now that support for 64k pages with a 4K kernel is removed, this code is
> unreachable.
>
> CONFIG_PPC_HAS_HASH_64K can only be true when CONFIG_PPC_64K_PAGES is
> also true.
>
> But when CONFIG_PPC_64K_PAGES is true we include pte-hash64.h which
> includes pte-hash64-64k.h, which defines both pte_pagesize_index() and
> crucially __real_pte, which means this defintion can never be used.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/pgtable-ppc64.h | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
> index 7ee2300ee392..fa1dfb7f7b48 100644
> --- a/arch/powerpc/include/asm/pgtable-ppc64.h
> +++ b/arch/powerpc/include/asm/pgtable-ppc64.h
> @@ -134,23 +134,11 @@
>
>  #define pte_iterate_hashed_end() } while(0)
>
> -#ifdef CONFIG_PPC_HAS_HASH_64K
>  /*
>   * We expect this to be called only for user addresses or kernel virtual
>   * addresses other than the linear mapping.
>   */
> -#define pte_pagesize_index(mm, addr, pte)			\
> -	({							\
> -		unsigned int psize;				\
> -		if (is_kernel_addr(addr))			\
> -			psize = MMU_PAGE_4K;			\
> -		else						\
> -			psize = get_slice_psize(mm, addr);	\
> -		psize;						\
> -	})
> -#else
>  #define pte_pagesize_index(mm, addr, pte)	MMU_PAGE_4K
> -#endif
>
>  #endif /* __real_pte */
>
> -- 
> 2.1.4

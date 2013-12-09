Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B63942C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Dec 2013 19:42:43 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 9 Dec 2013 14:12:33 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 6AE7A394004E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Dec 2013 14:12:31 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rB98gROl983454
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Dec 2013 14:12:28 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rB98gSPO016149
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Dec 2013 14:12:29 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: "Hong H. Pham" <hong.pham@windriver.com>,
 linux-rt-users <linux-rt-users@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v3] powerpc: Fix PTE page address mismatch in pgtable
 ctor/dtor
In-Reply-To: <1386425193-24015-1-git-send-email-hong.pham@windriver.com>
References: <874n6muuw4.fsf@linux.vnet.ibm.com>
 <1386425193-24015-1-git-send-email-hong.pham@windriver.com>
Date: Mon, 09 Dec 2013 14:12:26 +0530
Message-ID: <87siu2bekt.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>, "Hong H. Pham" <hong.pham@windriver.com>,
 linux-stable <stable@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Hong H. Pham" <hong.pham@windriver.com> writes:

> From: "Hong H. Pham" <hong.pham@windriver.com>
>
> In pte_alloc_one(), pgtable_page_ctor() is passed an address that has
> not been converted by page_address() to the newly allocated PTE page.
>
> When the PTE is freed, __pte_free_tlb() calls pgtable_page_dtor()
> with an address to the PTE page that has been converted by page_address().
> The mismatch in the PTE's page address causes pgtable_page_dtor() to access
> invalid memory, so resources for that PTE (such as the page lock) is not
> properly cleaned up.
>
> On PPC32, only SMP kernels are affected.
>
> On PPC64, only SMP kernels with 4K page size are affected.
>
> This bug was introduced by commit d614bb041209fd7cb5e4b35e11a7b2f6ee8f62b8
> "powerpc: Move the pte free routines from common header".
>
> On a preempt-rt kernel, a spinlock is dynamically allocated for each
> PTE in pgtable_page_ctor().  When the PTE is freed, calling
> pgtable_page_dtor() with a mismatched page address causes a memory leak,
> as the pointer to the PTE's spinlock is bogus.
>
> On mainline, there isn't any immediately obvious symptoms, but the
> problem still exists here.
>
> Fixes: d614bb041209fd7c "powerpc: Move the pte free routes from common header"
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: linux-stable <stable@vger.kernel.org> # v3.10+
> Signed-off-by: Hong H. Pham <hong.pham@windriver.com>


Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>


> ---
>  arch/powerpc/include/asm/pgalloc-32.h | 6 ++----
>  arch/powerpc/include/asm/pgalloc-64.h | 6 ++----
>  2 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/pgalloc-32.h b/arch/powerpc/include/asm/pgalloc-32.h
> index 27b2386..842846c 100644
> --- a/arch/powerpc/include/asm/pgalloc-32.h
> +++ b/arch/powerpc/include/asm/pgalloc-32.h
> @@ -84,10 +84,8 @@ static inline void pgtable_free_tlb(struct mmu_gather *tlb,
>  static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
>  				  unsigned long address)
>  {
> -	struct page *page = page_address(table);
> -
>  	tlb_flush_pgtable(tlb, address);
> -	pgtable_page_dtor(page);
> -	pgtable_free_tlb(tlb, page, 0);
> +	pgtable_page_dtor(table);
> +	pgtable_free_tlb(tlb, page_address(table), 0);
>  }
>  #endif /* _ASM_POWERPC_PGALLOC_32_H */
> diff --git a/arch/powerpc/include/asm/pgalloc-64.h b/arch/powerpc/include/asm/pgalloc-64.h
> index f65e27b..256d6f8 100644
> --- a/arch/powerpc/include/asm/pgalloc-64.h
> +++ b/arch/powerpc/include/asm/pgalloc-64.h
> @@ -144,11 +144,9 @@ static inline void pgtable_free_tlb(struct mmu_gather *tlb,
>  static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
>  				  unsigned long address)
>  {
> -	struct page *page = page_address(table);
> -
>  	tlb_flush_pgtable(tlb, address);
> -	pgtable_page_dtor(page);
> -	pgtable_free_tlb(tlb, page, 0);
> +	pgtable_page_dtor(table);
> +	pgtable_free_tlb(tlb, page_address(table), 0);
>  }
>
>  #else /* if CONFIG_PPC_64K_PAGES */
> -- 
> 1.8.3.2

Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F15DD1A0986
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 03:41:24 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 20 Feb 2016 09:41:23 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 20DBD1FF0023
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 09:29:28 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1KGfIe630605396
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 09:41:18 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1KGfItl004222
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 09:41:18 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras via Linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH 4/9] powerpc/mm/book3s-64: Move _PAGE_PRESENT to the
 most significant bit
In-Reply-To: <1455948760-24710-5-git-send-email-paulus@samba.org>
References: <1455948760-24710-1-git-send-email-paulus@samba.org>
 <1455948760-24710-5-git-send-email-paulus@samba.org>
Date: Sat, 20 Feb 2016 22:11:14 +0530
Message-ID: <87vb5j72s5.fsf@linux.vnet.ibm.com>
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

Paul Mackerras <paulus@samba.org> writes:

> This changes _PAGE_PRESENT for 64-bit Book 3S processors from 0x2 to
> 0x8000_0000_0000_0000, because that is where PowerISA v3.0 CPUs in
> radix mode will expect to find it.

All the changes in this patch related to _PAGE_PRESENT movement or are
they cleanup that got added to this patch. I am looking at the hpte slot
array changes and wondering how that is related to _PAGE_PRESENT.

>
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
>  arch/powerpc/include/asm/book3s/64/hash-64k.h | 10 +++++-----
>  arch/powerpc/include/asm/book3s/64/hash.h     |  5 +++--
>  arch/powerpc/mm/mmu_decl.h                    |  2 +-
>  arch/powerpc/mm/pgtable_64.c                  |  2 +-
>  4 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> index a8c4c2a..ed390e1 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -210,30 +210,30 @@ static inline char *get_hpte_slot_array(pmd_t *pmdp)
>  /*
>   * The linux hugepage PMD now include the pmd entries followed by the address
>   * to the stashed pgtable_t. The stashed pgtable_t contains the hpte bits.
> - * [ 1 bit secondary | 3 bit hidx | 1 bit valid | 000]. We use one byte per
> + * [ 000 | 1 bit secondary | 3 bit hidx | 1 bit valid]. We use one byte per
>   * each HPTE entry. With 16MB hugepage and 64K HPTE we need 256 entries and
>   * with 4K HPTE we need 4096 entries. Both will fit in a 4K pgtable_t.
>   *
> - * The last three bits are intentionally left to zero. This memory location
> + * The top three bits are intentionally left as zero. This memory location
>   * are also used as normal page PTE pointers. So if we have any pointers
>   * left around while we collapse a hugepage, we need to make sure
>   * _PAGE_PRESENT bit of that is zero when we look at them
>   */
>  static inline unsigned int hpte_valid(unsigned char *hpte_slot_array, int index)
>  {
> -	return (hpte_slot_array[index] >> 3) & 0x1;
> +	return hpte_slot_array[index] & 0x1;
>  }
>
>  static inline unsigned int hpte_hash_index(unsigned char *hpte_slot_array,
>  					   int index)
>  {
> -	return hpte_slot_array[index] >> 4;
> +	return hpte_slot_array[index] >> 1;
>  }
>
>  static inline void mark_hpte_slot_valid(unsigned char *hpte_slot_array,
>  					unsigned int index, unsigned int hidx)
>  {
> -	hpte_slot_array[index] = hidx << 4 | 0x1 << 3;
> +	hpte_slot_array[index] = (hidx << 1) | 0x1;
>  }
>
>  /*
> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
> index fcab33f..72ea557 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> @@ -14,7 +14,6 @@
>   * combinations that newer processors provide but we currently don't.
>   */
>  #define _PAGE_PTE		0x00001	/* distinguishes PTEs from pointers */
> -#define _PAGE_PRESENT		0x00002 /* software: pte contains a translation */
>  #define _PAGE_BIT_SWAP_TYPE	2
>  #define _PAGE_USER		0x00004 /* page may be accessed by userspace */
>  #define _PAGE_EXEC		0x00008 /* execute permission */
> @@ -39,6 +38,8 @@
>  #define _PAGE_SOFT_DIRTY	0x00000
>  #endif
>
> +#define _PAGE_PRESENT		(1ul << 63)	/* pte contains a translation */
> +
>  /*
>   * We need to differentiate between explicit huge page and THP huge
>   * page, since THP huge page also need to track real subpage details
> @@ -399,7 +400,7 @@ static inline int pte_protnone(pte_t pte)
>
>  static inline int pte_present(pte_t pte)
>  {
> -	return pte_val(pte) & _PAGE_PRESENT;
> +	return !!(pte_val(pte) & _PAGE_PRESENT);
>  }
>
>  /* Conversion functions: convert a page and protection to a page entry,
> diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
> index 9f58ff4..92da107 100644
> --- a/arch/powerpc/mm/mmu_decl.h
> +++ b/arch/powerpc/mm/mmu_decl.h
> @@ -110,7 +110,7 @@ extern unsigned long Hash_size, Hash_mask;
>  #endif /* CONFIG_PPC32 */
>
>  #ifdef CONFIG_PPC64
> -extern int map_kernel_page(unsigned long ea, unsigned long pa, int flags);
> +extern int map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t flags);
>  #endif /* CONFIG_PPC64 */
>
>  extern unsigned long ioremap_bot;
> diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
> index 950c572..c50d9a2 100644
> --- a/arch/powerpc/mm/pgtable_64.c
> +++ b/arch/powerpc/mm/pgtable_64.c
> @@ -88,7 +88,7 @@ static __ref void *early_alloc_pgtable(unsigned long size)
>   * map_kernel_page adds an entry to the ioremap page table
>   * and adds an entry to the HPT, possibly bolting it
>   */
> -int map_kernel_page(unsigned long ea, unsigned long pa, int flags)
> +int map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t flags)
>  {
>  	pgd_t *pgdp;
>  	pud_t *pudp;
> -- 
> 2.5.0

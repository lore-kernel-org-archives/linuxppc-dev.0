Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D09491A03CB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 17:53:21 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 27 Nov 2015 16:53:20 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6415F3578047
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 17:53:15 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAR6r9Pu7536700
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 17:53:17 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAR6qfF0004039
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 17:52:43 +1100
Message-ID: <5657FDA6.4000007@linux.vnet.ibm.com>
Date: Fri, 27 Nov 2015 12:22:22 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
CC: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V5 21/31] powerpc/mm: make pte page hash index slot 8 bits
References: <1448274160-28446-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1448274160-28446-22-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448274160-28446-22-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/23/2015 03:52 PM, Aneesh Kumar K.V wrote:
> Currently we use 4 bits for each slot and pack all the 16 slot
> information related to a 64K linux page in a 64bit value. To do this
> we use 16 bits of pte_t. Move the hash slot valid bit out of pte_t

Looking into the existing function __real_pte, rpte.hidx is stored
in the second half of the PTE page not inside the pte_t as the
commit message points out. Also did not get how 16 bits of pte_t
is used to track 64 bits of subpage information tracked inside
the second half of the PTE page.

	rpte.hidx = pte_val(*((ptep) + PTRS_PER_PTE));

With the current patch, it changes the storage requirement of the
sub page tracking from (4 * 16 = 64 bits) into (8 * 16 = 128 bits)
which is now made accessible as a character array (the rpte.hidx)
instead of an unsigned long as it was happening previously before
the change.

> and place them in the second half of pte page. We also use 8 bit
> per each slot.
> 
> Acked-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hash-64k.h | 48 +++++++++++++++------------
>  arch/powerpc/include/asm/book3s/64/hash.h     |  5 ---
>  arch/powerpc/include/asm/page.h               |  4 +--
>  arch/powerpc/mm/hash64_64k.c                  | 34 +++++++++++++++----
>  4 files changed, 56 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> index ced5a17a8d1a..dafc2f31c843 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -78,33 +78,39 @@
>   * generic accessors and iterators here
>   */
>  #define __real_pte __real_pte
> -static inline real_pte_t __real_pte(unsigned long addr, pte_t pte, pte_t *ptep)
> -{
> -	real_pte_t rpte;
> -
> -	rpte.pte = pte;
> -	rpte.hidx = 0;
> -	if (pte_val(pte) & _PAGE_COMBO) {
> -		/*
> -		 * Make sure we order the hidx load against the _PAGE_COMBO
> -		 * check. The store side ordering is done in __hash_page_4K
> -		 */
> -		smp_rmb();
> -		rpte.hidx = pte_val(*((ptep) + PTRS_PER_PTE));

The previous function was storing it in the second half of the PTE page.

> -	}
> -	return rpte;
> -}
> -
> +extern real_pte_t __real_pte(unsigned long addr, pte_t pte, pte_t *ptep);
>  static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
>  {
>  	if ((pte_val(rpte.pte) & _PAGE_COMBO))
> -		return (rpte.hidx >> (index<<2)) & 0xf;
> +		return (unsigned long) rpte.hidx[index] >> 4;
>  	return (pte_val(rpte.pte) >> 12) & 0xf;
>  }
>  
> -#define __rpte_to_pte(r)	((r).pte)
> -#define __rpte_sub_valid(rpte, index) \
> -	(pte_val(rpte.pte) & (_PAGE_HPTE_SUB0 >> (index)))
> +static inline pte_t __rpte_to_pte(real_pte_t rpte)
> +{
> +	return rpte.pte;
> +}
> +/*
> + * we look at the second half of the pte page to determine whether
> + * the sub 4k hpte is valid. We use 8 bits per each index, and we have
> + * 16 index mapping full 64K page. Hence for each
> + * 64K linux page we use 128 bit from the second half of pte page.
> + * The encoding in the second half of the page is as below:
> + * [ index 15 ] .........................[index 0]
> + * [bit 127 ..................................bit 0]
> + * fomat of each index
> + * bit 7 ........ bit0
> + * [one bit secondary][ 3 bit hidx][1 bit valid][000]
> + */
> +static inline bool __rpte_sub_valid(real_pte_t rpte, unsigned long index)
> +{
> +	unsigned char index_val = rpte.hidx[index];
> +
> +	if ((index_val >> 3) & 0x1)
> +		return true;
> +	return false;
> +}
> +
>  /*
>   * Trick: we set __end to va + 64k, which happens works for
>   * a 16M page as well as we want only one iteration
> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
> index e18794d5a68c..b11197965c2f 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> @@ -212,11 +212,6 @@
>  
>  #define PMD_BAD_BITS		(PTE_TABLE_SIZE-1)
>  #define PUD_BAD_BITS		(PMD_TABLE_SIZE-1)
> -/*
> - * We save the slot number & secondary bit in the second half of the
> - * PTE page. We use the 8 bytes per each pte entry.
> - */

This previous comment also talked about it. ^^^^^^^^^^^^^^^

> -#define PTE_PAGE_HIDX_OFFSET (PTRS_PER_PTE * 8)
>  
>  #ifndef __ASSEMBLY__
>  #define	pmd_bad(pmd)		(!is_kernel_addr(pmd_val(pmd)) \
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index 9d2f38e1b21d..9c3211eb487c 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -295,7 +295,7 @@ static inline pte_basic_t pte_val(pte_t x)
>   * the "second half" part of the PTE for pseudo 64k pages
>   */
>  #if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC_STD_MMU_64)
> -typedef struct { pte_t pte; unsigned long hidx; } real_pte_t;
> +typedef struct { pte_t pte; unsigned char *hidx; } real_pte_t;
>  #else
>  typedef struct { pte_t pte; } real_pte_t;
>  #endif
> @@ -347,7 +347,7 @@ static inline pte_basic_t pte_val(pte_t pte)
>  }
>  
>  #if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC_STD_MMU_64)
> -typedef struct { pte_t pte; unsigned long hidx; } real_pte_t;
> +typedef struct { pte_t pte; unsigned char *hidx; } real_pte_t;
>  #else
>  typedef pte_t real_pte_t;
>  #endif
> diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
> index 456aa3bfa8f1..c40ee12cc922 100644
> --- a/arch/powerpc/mm/hash64_64k.c
> +++ b/arch/powerpc/mm/hash64_64k.c
> @@ -16,12 +16,32 @@
>  #include <asm/machdep.h>
>  #include <asm/mmu.h>
>  
> +real_pte_t __real_pte(unsigned long addr, pte_t pte, pte_t *ptep)
> +{
> +	int indx;
> +	real_pte_t rpte;
> +	pte_t *pte_headp;
> +
> +	rpte.pte = pte;
> +	rpte.hidx = NULL;
> +	if (pte_val(pte) & _PAGE_COMBO) {
> +		indx = pte_index(addr);
> +		pte_headp = ptep - indx;
> +		/*
> +		 * Make sure we order the hidx load against the _PAGE_COMBO
> +		 * check. The store side ordering is done in __hash_page_4K
> +		 */
> +		smp_rmb();
> +		rpte.hidx = (unsigned char *)(pte_headp + PTRS_PER_PTE) + (16 * indx);

The new scheme here also tracks these 16 byte information in the second
half of the PTE page.

> +	}
> +	return rpte;
> +}
> +
>  int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>  		   pte_t *ptep, unsigned long trap, unsigned long flags,
>  		   int ssize, int subpg_prot)
>  {
>  	real_pte_t rpte;
> -	unsigned long *hidxp;
>  	unsigned long hpte_group;
>  	unsigned int subpg_index;
>  	unsigned long shift = 12; /* 4K */
> @@ -90,7 +110,10 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>  
>  	subpg_index = (ea & (PAGE_SIZE - 1)) >> shift;
>  	vpn  = hpt_vpn(ea, vsid, ssize);
> -	rpte = __real_pte(ea, __pte(old_pte), ptep);
> +	if (!(old_pte & _PAGE_COMBO))
> +		rpte = __real_pte(ea, __pte(old_pte | _PAGE_COMBO), ptep);
> +	else
> +		rpte = __real_pte(ea, __pte(old_pte), ptep);

The above hunk can be replaced with just the following line which
adds _PAGE_COMBO flag no matter what.

rpte = __real_pte(ea, __pte(old_pte | _PAGE_COMBO), ptep);


>  	/*
>  	 *None of the sub 4k page is hashed
>  	 */
> @@ -188,11 +211,8 @@ repeat:
>  	 * Since we have _PAGE_BUSY set on ptep, we can be sure
>  	 * nobody is undating hidx.
>  	 */
> -	hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
> -	/* __real_pte use pte_val() any idea why ? FIXME!! */
> -	rpte.hidx &= ~(0xfUL << (subpg_index << 2));
> -	*hidxp = rpte.hidx  | (slot << (subpg_index << 2));
> -	new_pte |= (_PAGE_HPTE_SUB0 >> subpg_index);
> +	rpte.hidx[subpg_index] = (unsigned char)(slot << 4 | 0x1 << 3);

Dont we need to check anything before inserting the validity bit (0x1 << 3)
for the sub page into the 8 bit information ?

> +	new_pte |= _PAGE_HPTE_SUB0;
>  	/*
>  	 * check __real_pte for details on matching smp_rmb()
>  	 */
> 

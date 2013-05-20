Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc: use smp_rmb when looking at deposisted
 pgtable to store hash index
In-reply-to: <1368778503-23230-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1368778503-23230-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 20 May 2013 11:18:46 +1000
Message-ID: <26735.1369012726@ale.ozlabs.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:

> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> We need to use smb_rmb when looking at hpte slot array. Otherwise we could
> reorder the hpte_slot array load bfore even we marked the pmd trans huge.

Does this need to go back into the stable series?

Mikey

> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/pgtable-ppc64.h | 15 +++++++++++++++
>  arch/powerpc/mm/hugepage-hash64.c        |  6 +-----
>  arch/powerpc/mm/pgtable_64.c             |  6 +-----
>  3 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
> index d046289..46db094 100644
> --- a/arch/powerpc/include/asm/pgtable-ppc64.h
> +++ b/arch/powerpc/include/asm/pgtable-ppc64.h
> @@ -10,6 +10,7 @@
>  #else
>  #include <asm/pgtable-ppc64-4k.h>
>  #endif
> +#include <asm/barrier.h>
>  
>  #define FIRST_USER_ADDRESS	0
>  
> @@ -393,6 +394,20 @@ static inline void mark_hpte_slot_valid(unsigned char *hpte_slot_array,
>  	hpte_slot_array[index] = hidx << 4 | 0x1 << 3;
>  }
>  
> +static inline char *get_hpte_slot_array(pmd_t *pmdp)
> +{
> +	/*
> +	 * The hpte hindex is stored in the pgtable whose address is in the
> +	 * second half of the PMD
> +	 *
> +	 * Order this load with the test for pmd_trans_huge in the caller
> +	 */
> +	smp_rmb();
> +	return *(char **)(pmdp + PTRS_PER_PMD);
> +
> +
> +}
> +
>  extern void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
>  				   pmd_t *pmdp);
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
> index e430766..c3ba3d5 100644
> --- a/arch/powerpc/mm/hugepage-hash64.c
> +++ b/arch/powerpc/mm/hugepage-hash64.c
> @@ -84,11 +84,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
>  
>  	vpn = hpt_vpn(ea, vsid, ssize);
>  	hash = hpt_hash(vpn, shift, ssize);
> -	/*
> -	 * The hpte hindex are stored in the pgtable whose address is in the
> -	 * second half of the PMD
> -	 */
> -	hpte_slot_array = *(char **)(pmdp + PTRS_PER_PMD);
> +	hpte_slot_array = get_hpte_slot_array(pmdp);
>  
>  	valid = hpte_valid(hpte_slot_array, index);
>  	if (valid) {
> diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
> index 8dd7c83..19d6734 100644
> --- a/arch/powerpc/mm/pgtable_64.c
> +++ b/arch/powerpc/mm/pgtable_64.c
> @@ -701,11 +701,7 @@ void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
>  	 * Flush all the hptes mapping this hugepage
>  	 */
>  	s_addr = addr & HPAGE_PMD_MASK;
> -	/*
> -	 * The hpte hindex are stored in the pgtable whose address is in the
> -	 * second half of the PMD
> -	 */
> -	hpte_slot_array = *(char **)(pmdp + PTRS_PER_PMD);
> +	hpte_slot_array = get_hpte_slot_array(pmdp);
>  	/*
>  	 * IF we try to do a HUGE PTE update after a withdraw is done.
>  	 * we will find the below NULL. This happens when we do
> -- 
> 1.8.1.2
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

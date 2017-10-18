Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGxF14MxlzDrF7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 13:43:00 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id y7so3031757pgb.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 19:43:00 -0700 (PDT)
Date: Wed, 18 Oct 2017 13:42:49 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, hbabu@us.ibm.com,
 bauerman@linux.vnet.ibm.com, mhocko@kernel.org
Subject: Re: [RFC v7 02/25] powerpc: track allocation status of all pkeys
Message-ID: <20171018134249.0e7a248d@firefly.ozlabs.ibm.com>
In-Reply-To: <1501459946-11619-3-git-send-email-linuxram@us.ibm.com>
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
 <1501459946-11619-3-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 30 Jul 2017 17:12:03 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> Total 32 keys are available on power7 and above. However
> pkey 0,1 are reserved. So effectively we  have  30 pkeys.
> 
> On 4K kernels, we do not  have  5  bits  in  the  PTE to
> represent  all the keys; we only have 3bits.Two of those
> keys are reserved; pkey 0 and pkey 1. So effectively  we
> have 6 pkeys.
> 
> This patch keeps track of reserved keys, allocated  keys
> and keys that are currently free.
> 
> Also it  adds  skeletal  functions  and macros, that the
> architecture-independent code expects to be available.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/mmu.h |    9 +++
>  arch/powerpc/include/asm/mmu_context.h   |    1 +
>  arch/powerpc/include/asm/pkeys.h         |   98 ++++++++++++++++++++++++++++-
>  arch/powerpc/mm/mmu_context_book3s64.c   |    2 +
>  arch/powerpc/mm/pkeys.c                  |    2 +
>  5 files changed, 108 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
> index 77529a3..104ad72 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
> @@ -108,6 +108,15 @@ struct patb_entry {
>  #ifdef CONFIG_SPAPR_TCE_IOMMU
>  	struct list_head iommu_group_mem_list;
>  #endif
> +
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +	/*
> +	 * Each bit represents one protection key.
> +	 * bit set   -> key allocated
> +	 * bit unset -> key available for allocation
> +	 */
> +	u32 pkey_allocation_map;
> +#endif
>  } mm_context_t;
>  
>  /*
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index 4b93547..4705dab 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -184,6 +184,7 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
>  
>  #ifndef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
>  #define pkey_initialize()
> +#define pkey_mm_init(mm)
>  #endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
>  
>  #endif /* __KERNEL__ */
> diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> index 4ccb8f5..def385f 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -2,6 +2,8 @@
>  #define _ASM_PPC64_PKEYS_H
>  
>  extern bool pkey_inited;
> +extern int pkeys_total; /* total pkeys as per device tree */
> +extern u32 initial_allocation_mask;/* bits set for reserved keys */
>  
>  /*
>   * powerpc needs an additional vma bit to support 32 keys.
> @@ -20,21 +22,76 @@
>  #define VM_PKEY_BIT4	VM_HIGH_ARCH_4
>  #endif
>  
> -#define ARCH_VM_PKEY_FLAGS 0
> +#define arch_max_pkey()  pkeys_total
> +#define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
> +				VM_PKEY_BIT3 | VM_PKEY_BIT4)
> +
> +#define pkey_alloc_mask(pkey) (0x1 << pkey)
> +
> +#define mm_pkey_allocation_map(mm)	(mm->context.pkey_allocation_map)
> +
> +#define mm_set_pkey_allocated(mm, pkey) {	\
> +	mm_pkey_allocation_map(mm) |= pkey_alloc_mask(pkey); \
> +}
> +
> +#define mm_set_pkey_free(mm, pkey) {	\
> +	mm_pkey_allocation_map(mm) &= ~pkey_alloc_mask(pkey);	\
> +}
> +
> +#define mm_set_pkey_is_allocated(mm, pkey)	\
> +	(mm_pkey_allocation_map(mm) & pkey_alloc_mask(pkey))
> +
> +#define mm_set_pkey_is_reserved(mm, pkey) (initial_allocation_mask & \
> +					pkey_alloc_mask(pkey))
>  
>  static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
>  {
> -	return (pkey == 0);
> +	/* a reserved key is never considered as 'explicitly allocated' */
> +	return ((pkey < arch_max_pkey()) &&
> +		!mm_set_pkey_is_reserved(mm, pkey) &&
> +		mm_set_pkey_is_allocated(mm, pkey));

Sounds like this should be called mm_pkey_is_free()

>  }
>  
> +/*
> + * Returns a positive, 5-bit key on success, or -1 on failure.
> + */
>  static inline int mm_pkey_alloc(struct mm_struct *mm)
>  {
> -	return -1;
> +	/*
> +	 * Note: this is the one and only place we make sure
> +	 * that the pkey is valid as far as the hardware is
> +	 * concerned.  The rest of the kernel trusts that
> +	 * only good, valid pkeys come out of here.
> +	 */
> +	u32 all_pkeys_mask = (u32)(~(0x0));
> +	int ret;
> +
> +	if (!pkey_inited)
> +		return -1;
> +	/*
> +	 * Are we out of pkeys?  We must handle this specially
> +	 * because ffz() behavior is undefined if there are no
> +	 * zeros.
> +	 */
Point A

> +	if (mm_pkey_allocation_map(mm) == all_pkeys_mask)
> +		return -1;
> +
> +	ret = ffz((u32)mm_pkey_allocation_map(mm));

Point B

So the allocation occurs from MSB to LSB?  I also think you need
a preempt disable between points A, B.

Is this code reentrant?

> +	mm_set_pkey_allocated(mm, ret);
> +	return ret;
>  }
>  
>  static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
>  {
> -	return -EINVAL;
> +	if (!pkey_inited)
> +		return -1;
> +
> +	if (!mm_pkey_is_allocated(mm, pkey))
> +		return -EINVAL;
> +
> +	mm_set_pkey_free(mm, pkey);
> +
> +	return 0;
>  }
>  
>  /*
> @@ -58,12 +115,45 @@ static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
>  	return 0;
>  }
>  
> +static inline void pkey_mm_init(struct mm_struct *mm)
> +{
> +	if (!pkey_inited)
> +		return;
> +	mm_pkey_allocation_map(mm) = initial_allocation_mask;
> +}
> +
>  static inline void pkey_initialize(void)
>  {
> +	int os_reserved, i;
> +
>  	/* disable the pkey system till everything
>  	 * is in place. A patch further down the
>  	 * line will enable it.
>  	 */
>  	pkey_inited = false;

Why are we doing it this way?

> +
> +	/* Lets assume 32 keys */
> +	pkeys_total = 32;
> +
> +#ifdef CONFIG_PPC_4K_PAGES
> +	/*
> +	 * the OS can manage only 8 pkeys
> +	 * due to its inability to represent
> +	 * them in the linux 4K-PTE.
> +	 */
> +	os_reserved = pkeys_total-8;
> +#else
> +	os_reserved = 0;
> +#endif
> +	/*
> +	 * Bits are in LE format.
> +	 * NOTE: 1, 0 are reserved.
> +	 * key 0 is the default key, which allows read/write/execute.
> +	 * key 1 is recommended not to be used.
> +	 * PowerISA(3.0) page 1015, programming note.
> +	 */
> +	initial_allocation_mask = ~0x0;
> +	for (i = 2; i < (pkeys_total - os_reserved); i++)
> +		initial_allocation_mask &= ~(0x1<<i);

On radix key 0 is used for supervisor mode to implement SMEP
and SMAP. It would be nice to reserve key 0 for the OS for
hash as well. Why are the bits in LE format? The limitations
of the adjunct partition apply to Linux?

>  }
>  #endif /*_ASM_PPC64_PKEYS_H */
> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
> index a3edf81..34a16f3 100644
> --- a/arch/powerpc/mm/mmu_context_book3s64.c
> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
> @@ -16,6 +16,7 @@
>  #include <linux/string.h>
>  #include <linux/types.h>
>  #include <linux/mm.h>
> +#include <linux/pkeys.h>
>  #include <linux/spinlock.h>
>  #include <linux/idr.h>
>  #include <linux/export.h>
> @@ -120,6 +121,7 @@ static int hash__init_new_context(struct mm_struct *mm)
>  
>  	subpage_prot_init_new_context(mm);
>  
> +	pkey_mm_init(mm);
>  	return index;
>  }
>  
> diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> index c3acee1..37dacc5 100644
> --- a/arch/powerpc/mm/pkeys.c
> +++ b/arch/powerpc/mm/pkeys.c
> @@ -16,3 +16,5 @@
>  #include <linux/pkeys.h>                /* PKEY_*                       */
>  
>  bool pkey_inited;
> +int  pkeys_total;		/* total pkeys as per device tree */
> +u32  initial_allocation_mask;	/* bits set for reserved keys */

Balbir

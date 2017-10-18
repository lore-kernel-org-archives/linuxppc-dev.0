Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGzwB64cqzDrD6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 15:43:38 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id l24so3249486pgu.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 21:43:38 -0700 (PDT)
Date: Wed, 18 Oct 2017 15:43:27 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 16/25] powerpc: Program HPTE key protection bits
Message-ID: <20171018154327.2cafadf2@firefly.ozlabs.ibm.com>
In-Reply-To: <1504910713-7094-25-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-25-git-send-email-linuxram@us.ibm.com>
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

On Fri,  8 Sep 2017 15:45:04 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> Map the PTE protection key bits to the HPTE key protection bits,
> while creating HPTE  entries.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/mmu-hash.h |    5 +++++
>  arch/powerpc/include/asm/mmu_context.h        |    6 ++++++
>  arch/powerpc/include/asm/pkeys.h              |   13 +++++++++++++
>  arch/powerpc/mm/hash_utils_64.c               |    1 +
>  4 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> index 508275b..2e22357 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> @@ -90,6 +90,8 @@
>  #define HPTE_R_PP0		ASM_CONST(0x8000000000000000)
>  #define HPTE_R_TS		ASM_CONST(0x4000000000000000)
>  #define HPTE_R_KEY_HI		ASM_CONST(0x3000000000000000)
> +#define HPTE_R_KEY_BIT0		ASM_CONST(0x2000000000000000)
> +#define HPTE_R_KEY_BIT1		ASM_CONST(0x1000000000000000)
>  #define HPTE_R_RPN_SHIFT	12
>  #define HPTE_R_RPN		ASM_CONST(0x0ffffffffffff000)
>  #define HPTE_R_RPN_3_0		ASM_CONST(0x01fffffffffff000)
> @@ -104,6 +106,9 @@
>  #define HPTE_R_C		ASM_CONST(0x0000000000000080)
>  #define HPTE_R_R		ASM_CONST(0x0000000000000100)
>  #define HPTE_R_KEY_LO		ASM_CONST(0x0000000000000e00)
> +#define HPTE_R_KEY_BIT2		ASM_CONST(0x0000000000000800)
> +#define HPTE_R_KEY_BIT3		ASM_CONST(0x0000000000000400)
> +#define HPTE_R_KEY_BIT4		ASM_CONST(0x0000000000000200)
>  #define HPTE_R_KEY		(HPTE_R_KEY_LO | HPTE_R_KEY_HI)
>  
>  #define HPTE_V_1TB_SEG		ASM_CONST(0x4000000000000000)
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index 8e5a87e..04e9221 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -150,6 +150,12 @@ static inline int vma_pkey(struct vm_area_struct *vma)
>  {
>  	return 0;
>  }
> +
> +static inline u64 pte_to_hpte_pkey_bits(u64 pteflags)
> +{
> +	return 0x0UL;
> +}
> +
>  #endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
>  
>  #endif /* __KERNEL__ */
> diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> index 0d2488a..cd3924c 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -67,6 +67,19 @@ static inline int vma_pkey(struct vm_area_struct *vma)
>  #define AMR_RD_BIT 0x1UL
>  #define AMR_WR_BIT 0x2UL
>  #define IAMR_EX_BIT 0x1UL
> +
> +static inline u64 pte_to_hpte_pkey_bits(u64 pteflags)
> +{
> +	if (!pkey_inited)
> +		return 0x0UL;
> +
> +	return (((pteflags & H_PAGE_PKEY_BIT0) ? HPTE_R_KEY_BIT0 : 0x0UL) |
> +		((pteflags & H_PAGE_PKEY_BIT1) ? HPTE_R_KEY_BIT1 : 0x0UL) |
> +		((pteflags & H_PAGE_PKEY_BIT2) ? HPTE_R_KEY_BIT2 : 0x0UL) |
> +		((pteflags & H_PAGE_PKEY_BIT3) ? HPTE_R_KEY_BIT3 : 0x0UL) |
> +		((pteflags & H_PAGE_PKEY_BIT4) ? HPTE_R_KEY_BIT4 : 0x0UL));
> +}
> +
>  #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
>  				VM_PKEY_BIT3 | VM_PKEY_BIT4)
>  #define AMR_BITS_PER_PKEY 2
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 67f62b5..a739a2d 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -232,6 +232,7 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags)
>  		 */
>  		rflags |= HPTE_R_M;
>  
> +	rflags |= pte_to_hpte_pkey_bits(pteflags);
>  	return rflags;
>  }
>  


Looks good!

Acked-by: Balbir Singh <bsingharora@gmail.com>

Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qfwND6L6dzDq6S
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 16:11:40 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id zy2so3170238pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Apr 2016 23:11:40 -0700 (PDT)
Subject: Re: [PATCH 14/65] powerpc/mm/power9: Add partition table format
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1459067053-10835-14-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <5704A88E.5090906@gmail.com>
Date: Wed, 6 Apr 2016 16:11:26 +1000
MIME-Version: 1.0
In-Reply-To: <1459067053-10835-14-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 27/03/16 19:23, Aneesh Kumar K.V wrote:
> We also add mach dep call back for updating partition table entry.
The changelog needs to be enhanced.
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/mmu.h | 31 +++++++++++++++++++++++++++++--
>  arch/powerpc/include/asm/machdep.h       |  1 +
>  arch/powerpc/include/asm/reg.h           |  1 +
>  3 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
> index aadb0bbc5c71..b86786f2521c 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
> @@ -21,12 +21,39 @@ struct mmu_psize_def {
>  extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
>  #endif /* __ASSEMBLY__ */
>  
> -#ifdef CONFIG_PPC_STD_MMU_64
>  /* 64-bit classic hash table MMU */
>  #include <asm/book3s/64/mmu-hash.h>
> -#endif
>  
>  #ifndef __ASSEMBLY__
> +/*
> + * ISA 3.0 partiton and process table entry format
> + */
> +struct prtb_entry {
> +	__be64 prtb0;
> +	__be64 prtb1;
> +};
> +extern struct prtb_entry *process_tb;
> +
> +struct patb_entry {
> +	__be64 patb0;
> +	__be64 patb1;
> +};
> +extern struct patb_entry *partition_tb;
> +
> +#define PATB_HR		(1UL << 63)
> +#define PATB_GR		(1UL << 63)
> +#define RPDB_MASK	0x0ffffffffffff00fUL
> +#define RPDB_SHIFT	(1UL << 8)
Some comments on the fields and constants?
> +/*
> + * Limit process table to PAGE_SIZE table. This
> + * also limit the max pid we can support.
> + * MAX_USER_CONTEXT * 16 bytes of space.
> + */
> +#define PRTB_SIZE_SHIFT	(CONTEXT_BITS + 4)
> +/*
> + * Power9 currently only support 64K partition table size.
> + */
> +#define PATB_SIZE_SHIFT	16
>  
>  typedef unsigned long mm_context_id_t;
>  struct spinlock;
> diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
> index fd22442d30a9..6bdcd0da9e21 100644
> --- a/arch/powerpc/include/asm/machdep.h
> +++ b/arch/powerpc/include/asm/machdep.h
> @@ -256,6 +256,7 @@ struct machdep_calls {
>  #ifdef CONFIG_ARCH_RANDOM
>  	int (*get_random_seed)(unsigned long *v);
>  #endif
> +	int (*update_partition_table)(u64);
>  };
>  
>  extern void e500_idle(void);
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index 52ed654d01ba..257251ada3a3 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -587,6 +587,7 @@
>  #define SPRN_PIR	0x3FF	/* Processor Identification Register */
>  #endif
>  #define SPRN_TIR	0x1BE	/* Thread Identification Register */
> +#define SPRN_PTCR	0x1D0	/* Partition table control Register */
>  #define SPRN_PSPB	0x09F	/* Problem State Priority Boost reg */
>  #define SPRN_PTEHI	0x3D5	/* 981 7450 PTE HI word (S/W TLB load) */
>  #define SPRN_PTELO	0x3D6	/* 982 7450 PTE LO word (S/W TLB load) */

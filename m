Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AD0FADF901
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 07:41:13 +1000 (EST)
Message-Id: <B835DA11-AB52-476B-8DD9-327235DACB65@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Becky Bruce <becky.bruce@freescale.com>
In-Reply-To: <1219352996-22243-1-git-send-email-becky.bruce@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] POWERPC: Allow 32-bit pgtable code to support 36-bit
	physical
Date: Thu, 21 Aug 2008 16:40:59 -0500
References: <1219352996-22243-1-git-send-email-becky.bruce@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> #define _PMD_PRESENT	0
> #define _PMD_PRESENT_MASK (PAGE_MASK)
> @@ -517,7 +522,13 @@ extern unsigned long  
> bad_call_to_PMD_PAGE_SIZE(void);
>
> #define pte_none(pte)		((pte_val(pte) & ~_PTE_NONE_MASK) == 0)
> #define pte_present(pte)	(pte_val(pte) & _PAGE_PRESENT)
> +
> +#if (defined(CONFIG_PTE_64BIT) && (_PAGE_HASHPTE != 0))
> +#define pte_clear(mm, addr, ptep) \
> +	do { pte_update((ptep), (~_PAGE_HASHPTE), __pte(0)); } while (0)

drop the __pte(0), doesn't make sense for pte_update
>
> +#else
> #define pte_clear(mm,addr,ptep)	do { set_pte_at((mm), (addr),  
> (ptep), __pte(0)); } while (0)
> +#endif

Can we just always (for all ppc32) do:

#define pte_clear(mm,addr,ptep)        do { pte_update(ptep,  
(~_PAGE_HASHPTE), 0); } while (0)

I've already changed this to be:

#define pte_clear(mm,addr,ptep) do { pte_update(ptep, ~0, 0); } while  
(0)


> /*
> diff --git a/arch/powerpc/include/asm/types.h b/arch/powerpc/include/ 
> asm/types.h
> index d3374bc..a9a9262 100644
> --- a/arch/powerpc/include/asm/types.h
> +++ b/arch/powerpc/include/asm/types.h
> @@ -55,7 +55,7 @@ typedef u64 phys_addr_t;
> typedef u32 phys_addr_t;
> #endif
>
> -#ifdef __powerpc64__
> +#if defined(__powerpc64__) || defined(CONFIG_PHYS_64BIT)
> typedef u64 dma_addr_t;
> #else
> typedef u32 dma_addr_t;

is this really part of this patchset of the IOMMU changes?

- k

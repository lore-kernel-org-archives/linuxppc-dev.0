Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 71EC92C0082
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2012 17:53:44 +1000 (EST)
Message-ID: <1347004417.2385.53.camel@pasglop>
Subject: Re: [PATCH -V8 0/11] arch/powerpc: Add 64TB support to ppc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 07 Sep 2012 17:53:37 +1000
In-Reply-To: <871uiexuau.fsf@linux.vnet.ibm.com>
References: <1346945351-7672-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1346982235.2385.33.camel@pasglop> <871uiexuau.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-09-07 at 11:12 +0530, Aneesh Kumar K.V wrote:

> 
> diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
> index 428f23e..057a12a 100644
> --- a/arch/powerpc/include/asm/mmu-hash64.h
> +++ b/arch/powerpc/include/asm/mmu-hash64.h
> @@ -14,6 +14,7 @@
>  
>  #include <asm/asm-compat.h>
>  #include <asm/page.h>
> +#include <asm/pgtable-ppc64-range.h>

Nah, that's all too gross... I think the right thing to do is to move
the slice stuff out of page_64.h

>  /*
>   * Segment table
> @@ -415,12 +416,7 @@ extern void slb_set_size(u16 size);
>  	add	rt,rt,rx
>  
>  /* 4 bits per slice and we have one slice per 1TB */
> -#if 0 /* We can't directly include pgtable.h hence this hack */
>  #define SLICE_ARRAY_SIZE  (PGTABLE_RANGE >> 41)
> -#else
> -/* Right now we only support 64TB */
> -#define SLICE_ARRAY_SIZE  32
> -#endif
>  
>  #ifndef __ASSEMBLY__
>  
> diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
> index b55beb4..01ab518 100644
> --- a/arch/powerpc/include/asm/page_64.h
> +++ b/arch/powerpc/include/asm/page_64.h
> @@ -78,16 +78,14 @@ extern u64 ppc64_pft_size;
>  #define GET_LOW_SLICE_INDEX(addr)	((addr) >> SLICE_LOW_SHIFT)
>  #define GET_HIGH_SLICE_INDEX(addr)	((addr) >> SLICE_HIGH_SHIFT)
>  
> -/* 1 bit per slice and we have one slice per 1TB */
> -#if 0 /* We can't directly include pgtable.h hence this hack */
> -#define SLICE_MASK_SIZE (PGTABLE_RANGE >> 43)
> -#else
> -/*
> +/* 1 bit per slice and we have one slice per 1TB
>   * Right now we support only 64TB.
>   * IF we change this we will have to change the type
>   * of high_slices
>   */
>  #define SLICE_MASK_SIZE 8
> +#if (PGTABLE_RANGE >> 43) > SLICE_MASK_SIZE
> +#error PGTABLE_RANGE exceeds slice_mask high_slices size
>  #endif
>  
>  #ifndef __ASSEMBLY__
> diff --git a/arch/powerpc/include/asm/pgtable-ppc64-range.h b/arch/powerpc/include/asm/pgtable-ppc64-range.h
> new file mode 100644
> index 0000000..04a825c
> --- /dev/null
> +++ b/arch/powerpc/include/asm/pgtable-ppc64-range.h
> @@ -0,0 +1,16 @@
> +#ifndef _ASM_POWERPC_PGTABLE_PPC64_RANGE_H_
> +#define _ASM_POWERPC_PGTABLE_PPC64_RANGE_H_
> +
> +#ifdef CONFIG_PPC_64K_PAGES
> +#include <asm/pgtable-ppc64-64k.h>
> +#else
> +#include <asm/pgtable-ppc64-4k.h>
> +#endif
> +
> +/*
> + * Size of EA range mapped by our pagetables.
> + */
> +#define PGTABLE_EADDR_SIZE (PTE_INDEX_SIZE + PMD_INDEX_SIZE + \
> +			    PUD_INDEX_SIZE + PGD_INDEX_SIZE + PAGE_SHIFT)
> +#define PGTABLE_RANGE (ASM_CONST(1) << PGTABLE_EADDR_SIZE)
> +#endif
> diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
> index dea953f..ee783b4 100644
> --- a/arch/powerpc/include/asm/pgtable-ppc64.h
> +++ b/arch/powerpc/include/asm/pgtable-ppc64.h
> @@ -13,13 +13,7 @@
>  
>  #define FIRST_USER_ADDRESS	0
>  
> -/*
> - * Size of EA range mapped by our pagetables.
> - */
> -#define PGTABLE_EADDR_SIZE (PTE_INDEX_SIZE + PMD_INDEX_SIZE + \
> -                	    PUD_INDEX_SIZE + PGD_INDEX_SIZE + PAGE_SHIFT)
> -#define PGTABLE_RANGE (ASM_CONST(1) << PGTABLE_EADDR_SIZE)
> -
> +#include <asm/pgtable-ppc64-range.h>
>  
>  /* Some sanity checking */
>  #if TASK_SIZE_USER64 > PGTABLE_RANGE
> @@ -32,14 +26,6 @@
>  #endif
>  #endif
>  
> -#if (PGTABLE_RANGE >> 41) > SLICE_ARRAY_SIZE
> -#error PGTABLE_RANGE exceeds SLICE_ARRAY_SIZE
> -#endif
> -
> -#if (PGTABLE_RANGE >> 43) > SLICE_MASK_SIZE
> -#error PGTABLE_RANGE exceeds slice_mask high_slices size
> -#endif
> -
>  /*
>   * Define the address range of the kernel non-linear virtual area
>   */

Ben.

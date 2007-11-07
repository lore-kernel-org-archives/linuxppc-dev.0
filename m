Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5FE1EDDE18
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 10:19:51 +1100 (EST)
Subject: Re: [PATCH] [PPC 44x] L2-cache synchronization for ppc44x
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yuri Tikhonov <yur@emcraft.com>
In-Reply-To: <608329302.20071108021252@emcraft.com>
References: <608329302.20071108021252@emcraft.com>
Content-Type: text/plain
Date: Thu, 08 Nov 2007 10:19:33 +1100
Message-Id: <1194477573.6523.58.camel@pasglop>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-11-08 at 02:12 +0300, Yuri Tikhonov wrote:
> This is the updated patch for support synchronization of L2-Cache with the external memory on the ppc44x-based platforms.
> 
>  Differencies against the previous patch-set:
> - remove L2_CACHE config option;
> - introduce the ppc machdep to invalidate L2 cache lines;
> - some code clean-up.

Can you tell me more about how this cache operates ? I don't quite
understand why you would invalidate it on bidirectional DMAs rather than
flush it to memory (unless you get your terminology wrong) and why you
wouldn't flush it on transfers to the device.. Unless it is a
write-through cache ?

Ben.

> Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
> Signed-off-by: Pavel Kolesnikov <concord@emcraft.com>
> 
> --
> diff --git a/arch/powerpc/lib/dma-noncoherent.c b/arch/powerpc/lib/dma-noncoherent.c
> index 1947380..b06f05c 100644
> --- a/arch/powerpc/lib/dma-noncoherent.c
> +++ b/arch/powerpc/lib/dma-noncoherent.c
> @@ -31,6 +31,7 @@
>  #include <linux/dma-mapping.h>
>  
>  #include <asm/tlbflush.h>
> +#include <asm/machdep.h>
>  
>  /*
>   * This address range defaults to a value that is safe for all
> @@ -186,6 +187,8 @@ __dma_alloc_coherent(size_t size, dma_addr_t *handle, gfp_t gfp)
>  		unsigned long kaddr = (unsigned long)page_address(page);
>  		memset(page_address(page), 0, size);
>  		flush_dcache_range(kaddr, kaddr + size);
> +		if (ppc_md.l2cache_inv_range)
> +			ppc_md.l2cache_inv_range(__pa(kaddr), __pa(kaddr + size));
>  	}
>  
>  	/*
> @@ -351,12 +354,16 @@ void __dma_sync(void *vaddr, size_t size, int direction)
>  		BUG();
>  	case DMA_FROM_DEVICE:	/* invalidate only */
>  		invalidate_dcache_range(start, end);
> +		if (ppc_md.l2cache_inv_range)
> +			ppc_md.l2cache_inv_range(__pa(start), __pa(end));
>  		break;
>  	case DMA_TO_DEVICE:		/* writeback only */
>  		clean_dcache_range(start, end);
>  		break;
>  	case DMA_BIDIRECTIONAL:	/* writeback and invalidate */
>  		flush_dcache_range(start, end);
> +		if (ppc_md.l2cache_inv_range)
> +			ppc_md.l2cache_inv_range(__pa(start), __pa(end));
>  		break;
>  	}
>  }
> diff --git a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
> index 46cf8fa..31c9149 100644
> --- a/arch/ppc/kernel/misc.S
> +++ b/arch/ppc/kernel/misc.S
> @@ -25,6 +25,10 @@
>  #include <asm/thread_info.h>
>  #include <asm/asm-offsets.h>
>  
> +#ifdef CONFIG_44x
> +#include <asm/ibm44x.h>
> +#endif
> +
>  #ifdef CONFIG_8xx
>  #define ISYNC_8xx isync
>  #else
> @@ -386,6 +390,35 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
>  	sync				/* additional sync needed on g4 */
>  	isync
>  	blr
> +
> +#if defined(CONFIG_44x)
> +/*
> + * Invalidate the Level-2 cache lines corresponded to the address
> + * range.
> + *
> + * invalidate_l2cache_range(unsigned long start, unsigned long stop)
> + */
> +_GLOBAL(invalidate_l2cache_range)
> +	li	r5,PPC44X_L2_CACHE_BYTES-1	/* align on L2-cache line */
> +	andc	r3,r3,r5
> +	subf	r4,r3,r4
> +	add	r4,r4,r5
> +	srwi.	r4,r4,PPC44X_L2_CACHE_SHIFT
> +	mtctr	r4
> +
> +	lis	r4, L2C_CMD_INV>>16
> +1:	mtdcr	DCRN_L2C0_ADDR,r3	/* write address to invalidate */
> +	mtdcr	DCRN_L2C0_CMD,r4	/* issue the Invalidate cmd */
> +
> +2:	mfdcr	r5,DCRN_L2C0_SR		/* wait for complete */
> +	andis.	r5,r5,L2C_CMD_CLR>>16
> +	beq	2b
> +
> +	addi	r3,r3,PPC44X_L2_CACHE_BYTES	/* next address to invalidate */
> +	bdnz	1b
> +	blr
> +#endif
> +
>  /*
>   * Write any modified data cache blocks out to memory.
>   * Does not invalidate the corresponding cache lines (especially for
> diff --git a/arch/ppc/syslib/ibm440gx_common.c b/arch/ppc/syslib/ibm440gx_common.c
> index 6b1a801..64c663f 100644
> --- a/arch/ppc/syslib/ibm440gx_common.c
> +++ b/arch/ppc/syslib/ibm440gx_common.c
> @@ -12,6 +12,8 @@
>   */
>  #include <linux/kernel.h>
>  #include <linux/interrupt.h>
> +#include <asm/machdep.h>
> +#include <asm/cacheflush.h>
>  #include <asm/ibm44x.h>
>  #include <asm/mmu.h>
>  #include <asm/processor.h>
> @@ -201,6 +203,7 @@ void __init ibm440gx_l2c_enable(void){
>  
>  	asm volatile ("sync; isync" ::: "memory");
>  	local_irq_restore(flags);
> +	ppc_md.l2cache_inv_range = invalidate_l2cache_range;
>  }
>  
>  /* Disable L2 cache */
> diff --git a/include/asm-powerpc/cacheflush.h b/include/asm-powerpc/cacheflush.h
> index ba667a3..bdebfaa 100644
> --- a/include/asm-powerpc/cacheflush.h
> +++ b/include/asm-powerpc/cacheflush.h
> @@ -49,6 +49,7 @@ extern void flush_dcache_range(unsigned long start, unsigned long stop);
>  #ifdef CONFIG_PPC32
>  extern void clean_dcache_range(unsigned long start, unsigned long stop);
>  extern void invalidate_dcache_range(unsigned long start, unsigned long stop);
> +extern void invalidate_l2cache_range(unsigned long start, unsigned long stop);
>  #endif /* CONFIG_PPC32 */
>  #ifdef CONFIG_PPC64
>  extern void flush_inval_dcache_range(unsigned long start, unsigned long stop);
> diff --git a/include/asm-powerpc/machdep.h b/include/asm-powerpc/machdep.h
> index 71c6e7e..754f416 100644
> --- a/include/asm-powerpc/machdep.h
> +++ b/include/asm-powerpc/machdep.h
> @@ -201,6 +201,8 @@ struct machdep_calls {
>  	void		(*early_serial_map)(void);
>  	void		(*kgdb_map_scc)(void);
>  
> +	void		(*l2cache_inv_range)(unsigned long s, unsigned long e);
> +
>  	/*
>  	 * optional PCI "hooks"
>  	 */
> diff --git a/include/asm-ppc/ibm44x.h b/include/asm-ppc/ibm44x.h
> index 8078a58..8ac0a13 100644
> --- a/include/asm-ppc/ibm44x.h
> +++ b/include/asm-ppc/ibm44x.h
> @@ -138,7 +138,6 @@
>   * The "residual" board information structure the boot loader passes
>   * into the kernel.
>   */
> -#ifndef __ASSEMBLY__
>  
>  /*
>   * DCRN definitions
> @@ -596,6 +595,9 @@
>  #define  SRAM_DPC_ENABLE	0x80000000
>  
>  /* L2 Cache Controller 440GX/440SP/440SPe */
> +#define PPC44X_L2_CACHE_SHIFT	5
> +#define PPC44X_L2_CACHE_BYTES	(1 << PPC44X_L2_CACHE_SHIFT)
> +
>  #define DCRN_L2C0_CFG		0x030
>  #define  L2C_CFG_L2M		0x80000000
>  #define  L2C_CFG_ICU		0x40000000
> @@ -814,6 +816,5 @@
>  
>  #include <asm/ibm4xx.h>
>  
> -#endif /* __ASSEMBLY__ */
>  #endif /* __ASM_IBM44x_H__ */
>  #endif /* __KERNEL__ */
> diff --git a/include/asm-ppc/machdep.h b/include/asm-ppc/machdep.h
> index 293a444..4e7a270 100644
> --- a/include/asm-ppc/machdep.h
> +++ b/include/asm-ppc/machdep.h
> @@ -80,6 +80,8 @@ struct machdep_calls {
>  	void		(*nvram_write_val)(int addr, unsigned char val);
>  	void		(*nvram_sync)(void);
>  
> +	void		(*l2cache_inv_range)(unsigned long s, unsigned long e);
> +
>  	/*
>  	 * optional PCI "hooks"
>  	 */ 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

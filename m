Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0141.outbound.protection.outlook.com [207.46.163.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C737C2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 07:42:44 +1100 (EST)
Date: Wed, 19 Mar 2014 15:42:31 -0500
From: Scott Wood <scottwood@freescale.com>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Subject: Re: [RFC, v3] powerpc: Loading kernels over 8Mbytes without
 CONFIG_PIN_TLB
Message-ID: <20140319204230.GA13767@home.buserror.net>
References: <20131215150957.1F5C143E5B@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <20131215150957.1F5C143E5B@localhost.localdomain>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Dec 15, 2013 at 04:09:57PM +0100, LEROY Christophe wrote:
> Hereunder is a try to implement the sizing of the initial memory size based on
> initial-mapped-area size given by uboot in r7.
> As this has an impact on all powerpc platforms due to the need to provide the
> info up to function setup_initial_memory_limit(), I'm not completly sure of the
> proper implementation.
> Thanks to provide comments.
> 
> Today on the 8xx, the only way to load kernels whose size is greater than
> 8Mbytes is to activate CONFIG_PIN_TLB. Otherwise, the physical memory initially
> mapped is limited to 8Mbytes. This patch uses the size of initial memory mapped
> by the bootloader and given to the kernel through register r7.
> This is done regardless of whether CONFIG_PIN_TLB is active or not. It allows to
> load "big" kernels (for instance when activating CONFIG_LOCKDEP_SUPPORT) without
> having to activate CONFIG_PIN_TLB.
> 
> Not-yet-signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> ---
> Ce courrier électronique ne contient aucun virus ou logiciel malveillant parce que la protection avast! Antivirus est active.
> http://www.avast.com
> 
> Index: linux/arch/powerpc/include/asm/mmu.h
> ===================================================================
> --- linux/arch/powerpc/include/asm/mmu.h	(revision 5484)
> +++ linux/arch/powerpc/include/asm/mmu.h	(copie de travail)
> @@ -138,7 +138,8 @@
>  extern void early_init_mmu_secondary(void);
>  
>  extern void setup_initial_memory_limit(phys_addr_t first_memblock_base,
> -				       phys_addr_t first_memblock_size);
> +				       phys_addr_t first_memblock_size,
> +				       u64 init_mem_size);

What is the difference between first_memblock_size and init_mem_size, in
terms of what you expect setup_initial_memory_limit to do with them?

Can you just pass in min(first_memblock_size, init_mem_size), with the
non-ePAPR fallback handled in head_8xx.S (just load r30 with 8M instead
of zero)?

>  #ifdef CONFIG_PPC64
>  /* This is our real memory area size on ppc64 server, on embedded, we
> Index: linux/arch/powerpc/kernel/head_8xx.S
> ===================================================================
> --- linux/arch/powerpc/kernel/head_8xx.S	(revision 5484)
> +++ linux/arch/powerpc/kernel/head_8xx.S	(copie de travail)
> @@ -31,6 +31,8 @@
>  #include <asm/asm-offsets.h>
>  #include <asm/ptrace.h>
>  
> +#define EPAPR_MAGIC	0x65504150
> +
>  /* Macro to make the code more readable. */
>  #ifdef CONFIG_8xx_CPU6
>  #define DO_8xx_CPU6(val, reg)	\
> @@ -77,10 +79,19 @@
>  	.globl	__start
>  __start:
>  	mr	r31,r3			/* save device tree ptr */
> +	li	r30,0
>  
> +	lis	r8,EPAPR_MAGIC@h
> +	ori	r8,r8, EPAPR_MAGIC@l
> +	cmpw	cr0,r8, r6

Whitespace

> +	bne	1f
> +
> +	mr	r30,r7			/* save initial ram size */
> +
>  	/* We have to turn on the MMU right away so we get cache modes
>  	 * set correctly.
>  	 */
> +1:
>  	bl	initial_mmu
>  
>  /* We now have the lower 8 Meg mapped into TLB entries, and the caches
> @@ -717,6 +728,8 @@
>   */
>  	li	r3,0
>  	mr	r4,r31
> +	li	r5,0
> +	mr	r6,r30
>  	bl	machine_init
>  	bl	MMU_init
>  
> @@ -841,11 +854,17 @@
>  	ori	r8, r8, MI_BOOTINIT|0x2 /* Inhibit cache -- Cort */
>  	mtspr	SPRN_MD_RPN, r8
>  
> +	/* Map two more 8M kernel data pages if needed
> +	 * We check how much memory is mapped by the bootloader
> +	*/

Whitespace

> Index: linux/arch/powerpc/kernel/prom.c
> ===================================================================
> --- linux/arch/powerpc/kernel/prom.c	(revision 5484)
> +++ linux/arch/powerpc/kernel/prom.c	(copie de travail)
> @@ -649,7 +649,7 @@
>  	}
>  }
>  
> -void __init early_init_devtree(void *params)
> +void __init early_init_devtree(void *params, u64 init_mem_size)
>  {
>  	phys_addr_t limit;
>  
> @@ -697,7 +697,7 @@
>  	/* make sure we've parsed cmdline for mem= before this */
>  	if (memory_limit)
>  		first_memblock_size = min_t(u64, first_memblock_size, memory_limit);
> -	setup_initial_memory_limit(memstart_addr, first_memblock_size);
> +	setup_initial_memory_limit(memstart_addr, first_memblock_size, init_mem_size);

Line length.
Yes, I know there's an existing violation on the previous line. :-)

> Index: linux/arch/powerpc/mm/init_32.c
> ===================================================================
> --- linux/arch/powerpc/mm/init_32.c	(revision 5484)
> +++ linux/arch/powerpc/mm/init_32.c	(copie de travail)
> @@ -206,19 +206,16 @@
>  
>  #ifdef CONFIG_8xx /* No 8xx specific .c file to put that in ... */
>  void setup_initial_memory_limit(phys_addr_t first_memblock_base,
> -				phys_addr_t first_memblock_size)
> +				phys_addr_t first_memblock_size,
> +				u64 init_mem_size)
>  {
>  	/* We don't currently support the first MEMBLOCK not mapping 0
>  	 * physical on those processors
>  	 */
>  	BUG_ON(first_memblock_base != 0);
>  
> -#ifdef CONFIG_PIN_TLB
> -	/* 8xx can only access 24MB at the moment */
> -	memblock_set_current_limit(min_t(u64, first_memblock_size, 0x01800000));
> -#else
> -	/* 8xx can only access 8MB at the moment */
> -	memblock_set_current_limit(min_t(u64, first_memblock_size, 0x00800000));
> -#endif
> +	if (!init_mem_size)
> +		init_mem_size = 0x00800000;
> +	memblock_set_current_limit(min_t(u64, first_memblock_size, init_mem_size));

Line length

>  }
>  #endif /* CONFIG_8xx */
> Index: linux/arch/powerpc/mm/ppc_mmu_32.c
> ===================================================================
> --- linux/arch/powerpc/mm/ppc_mmu_32.c	(revision 5484)
> +++ linux/arch/powerpc/mm/ppc_mmu_32.c	(copie de travail)
> @@ -273,7 +273,8 @@
>  }
>  
>  void setup_initial_memory_limit(phys_addr_t first_memblock_base,
> -				phys_addr_t first_memblock_size)
> +				phys_addr_t first_memblock_size,
> +				u64 init_mem_size)
>  {
>  	/* We don't currently support the first MEMBLOCK not mapping 0
>  	 * physical on those processors
> Index: linux/arch/powerpc/mm/tlb_nohash.c
> ===================================================================
> --- linux/arch/powerpc/mm/tlb_nohash.c	(revision 5484)
> +++ linux/arch/powerpc/mm/tlb_nohash.c	(copie de travail)
> @@ -654,7 +654,8 @@
>  }
>  
>  void setup_initial_memory_limit(phys_addr_t first_memblock_base,
> -				phys_addr_t first_memblock_size)
> +				phys_addr_t first_memblock_size,
> +				u64 init_mem_size)
>  {
>  	/* On non-FSL Embedded 64-bit, we adjust the RMA size to match
>  	 * the bolted TLB entry. We know for now that only 1G

It seems a bit odd for this function to take init_mem_size on these other
platforms, but not use it.

-Scott

Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 020FB67BB2
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 00:15:37 +1000 (EST)
Date: Thu, 12 Oct 2006 09:14:55 -0500
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/4] powerpc: Cell timebase workaround
Message-ID: <20061012091455.6409046e@localhost.localdomain>
In-Reply-To: <1160641804.4792.136.camel@localhost.localdomain>
References: <1160641804.4792.136.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 12 Oct 2006 18:30:04 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> The Cell CPU timebase has an errata. When reading the entire 64 bits of
> the timebase with one mftb instruction, there is a handful of cycles
> window during which one might read a value with the low order 32 bits
> already reset to 0x00000000 but the high order bits not yet incremeted
> by one. Simply reading the timebase a second time if the low order bits
> are 0 is enough (the second read will always miss that window).
> 
> Note that there is still a potential issue if the process gets
> interrupted between the 2 reads for long enough that the second reads
> pricely hits that same window on the next 32 bits wrap. However, this is
> so extremely unlikely to happen that we choose not to do anything
> against it (the 32 bits wrap happens every few seconds or so, in fact
> every few minutes on IBM cell blades).
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> This is the "old" patch adapted to apply on top of the previous changes.
> I'll post tomorrow a new version of the patch using a different
> technique for the workaround
> 
> Index: linux-cell/arch/powerpc/kernel/vdso64/gettimeofday.S
> ===================================================================
> --- linux-cell.orig/arch/powerpc/kernel/vdso64/gettimeofday.S	2006-10-12 18:08:40.000000000 +1000
> +++ linux-cell/arch/powerpc/kernel/vdso64/gettimeofday.S	2006-10-12 18:18:15.000000000 +1000
> @@ -11,6 +11,7 @@
>   * as published by the Free Software Foundation; either version
>   * 2 of the License, or (at your option) any later version.
>   */
> +
>  #include <asm/processor.h>
>  #include <asm/ppc_asm.h>
>  #include <asm/vdso.h>
> @@ -229,8 +230,13 @@ V_FUNCTION_BEGIN(__do_get_xsec)
>  	xor	r0,r8,r8		/* create dependency */
>  	add	r3,r3,r0
>  
> -	/* Get TB & offset it */
> -	mftb	r7
> +	/* Get TB & offset it. We use the MFTB macro which will generate
> +	 * workaround code for Cell. The macro will generate the ELF bits
> +	 * for the CPU feature fixup though those aren't actually applied
> +	 * on the vDSO, which means that the workaround will always be
> +	 * executed if CONFIG_PPC_CELL is set.
> +	 */
> +	MFTB(r7)
>  	ld	r9,CFG_TB_ORIG_STAMP(r3)
>  	subf	r7,r9,r7
>  
> Index: linux-cell/include/asm-powerpc/cputable.h
> ===================================================================
> --- linux-cell.orig/include/asm-powerpc/cputable.h	2006-10-12 18:17:44.000000000 +1000
> +++ linux-cell/include/asm-powerpc/cputable.h	2006-10-12 18:18:15.000000000 +1000
> @@ -144,6 +144,7 @@ extern void do_cpu_ftr_fixups(unsigned l
>  #define CPU_FTR_CI_LARGE_PAGE		LONG_ASM_CONST(0x0000100000000000)
>  #define CPU_FTR_PAUSE_ZERO		LONG_ASM_CONST(0x0000200000000000)
>  #define CPU_FTR_PURR			LONG_ASM_CONST(0x0000400000000000)
> +#define CPU_FTR_CELL_TB_BUG		LONG_ASM_CONST(0x0000800000000000)
>  
>  #ifndef __ASSEMBLY__
>  
> @@ -332,7 +333,7 @@ extern void do_cpu_ftr_fixups(unsigned l
>  #define CPU_FTRS_CELL	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
>  	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
>  	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
> -	    CPU_FTR_PAUSE_ZERO | CPU_FTR_CI_LARGE_PAGE)
> +	    CPU_FTR_PAUSE_ZERO | CPU_FTR_CI_LARGE_PAGE | CPU_FTR_CELL_TB_BUG)
>  #define CPU_FTRS_PA6T (CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
>  	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | \
>  	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CI_LARGE_PAGE | \
> Index: linux-cell/include/asm-powerpc/ppc_asm.h
> ===================================================================
> --- linux-cell.orig/include/asm-powerpc/ppc_asm.h	2006-10-12 18:08:40.000000000 +1000
> +++ linux-cell/include/asm-powerpc/ppc_asm.h	2006-10-12 18:18:15.000000000 +1000
> @@ -29,10 +29,10 @@
>  BEGIN_FTR_SECTION;							\
>  	mfspr	ra,SPRN_PURR;		/* get processor util. reg */	\
>  END_FTR_SECTION_IFSET(CPU_FTR_PURR);					\
> -BEGIN_FTR_SECTION;							\
> -	mftb	ra;			/* or get TB if no PURR */	\
> -END_FTR_SECTION_IFCLR(CPU_FTR_PURR);					\
> -	ld	rb,PACA_STARTPURR(r13);				\
> +BEGIN_FTR_SECTION_NESTED(96);						\
> +	MFTB(ra);			/* or get TB if no PURR */	\
> +END_FTR_SECTION_NESTED(CPU_FTR_PURR, 0, 96);				\
> +	ld	rb,PACA_STARTPURR(r13);					\
>  	std	ra,PACA_STARTPURR(r13);					\
>  	subf	rb,rb,ra;		/* subtract start value */	\
>  	ld	ra,PACA_USER_TIME(r13);					\
> @@ -44,9 +44,9 @@ END_FTR_SECTION_IFCLR(CPU_FTR_PURR);				
>  BEGIN_FTR_SECTION;							\
>  	mfspr	ra,SPRN_PURR;		/* get processor util. reg */	\
>  END_FTR_SECTION_IFSET(CPU_FTR_PURR);					\
> -BEGIN_FTR_SECTION;							\
> -	mftb	ra;			/* or get TB if no PURR */	\
> -END_FTR_SECTION_IFCLR(CPU_FTR_PURR);					\
> +BEGIN_FTR_SECTION_NESTED(96);						\
> +	MFTB(ra);			/* or get TB if no PURR */	\
> +END_FTR_SECTION_NESTED(CPU_FTR_PURR, 0, 96);				\
>  	ld	rb,PACA_STARTPURR(r13);				\
>  	std	ra,PACA_STARTPURR(r13);					\
>  	subf	rb,rb,ra;		/* subtract start value */	\
> @@ -274,6 +274,18 @@ END_FTR_SECTION_IFSET(CPU_FTR_601)
>  #define ISYNC_601
>  #endif
>  
> +#ifdef CONFIG_PPC_CELL
> +#define MFTB(dest)			\
> +	mftb  dest;			\
> +BEGIN_FTR_SECTION;			\
> +	cmpwi dest,0;			\
> +	bne+  90f;			\
> +	mftb  dest;			\
> +90:					\
> +END_FTR_SECTION_IFSET(CPU_FTR_CELL_TB_BUG)
> +#else
> +#define MFTB(dest)			mftb dest
> +#endif


The above is a bit obfuscated. Please make the MFTB() macro use the
nested version of the feature definitions, and let the surrounding code
use the base one. Otherwise it will be really easy to mix them up by
mistake, there's no exposure at the time of MFTB() usage that it uses
feature labels.


-Olof

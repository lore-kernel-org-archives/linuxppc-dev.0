Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8392B6F9E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 15:53:56 +1000 (EST)
Subject: Re: [PATCH 1/3] powerpc: POWER7 optimised copy_page using VMX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20110617045421.538184870@samba.org>
References: <20110617045358.544896830@samba.org>
	<20110617045421.538184870@samba.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Jun 2011 15:53:48 +1000
Message-ID: <1308290028.32158.45.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-06-17 at 14:53 +1000, Anton Blanchard wrote:

> +#include <asm/page.h>
> +#include <asm/ppc_asm.h>
> +
> +#define STACKFRAMESIZE	112
> +
> +_GLOBAL(copypage_power7)
> +	mflr	r0
> +	std	r3,48(r1)
> +	std	r4,56(r1)
> +	std	r0,16(r1)
> +	stdu	r1,-STACKFRAMESIZE(r1)
> +
> +	bl	.enable_kernel_altivec

Don't you need to preempt disable ? Or even irq disable ? Or do we know
copy page will never called at irq time ?

Also I wonder if you wouldn't be better to instead just manually enable
it MSR and save some VRs (if no current thread regs is attached) ? That
would be re-entrant.

> +	ld	r12,STACKFRAMESIZE+16(r1)
> +	ld	r4,STACKFRAMESIZE+56(r1)
> +	li	r0,(PAGE_SIZE/128)
> +	li	r6,16
> +	ld	r3,STACKFRAMESIZE+48(r1)
> +	li	r7,32
> +	li	r8,48
> +	mtctr	r0
> +	li	r9,64
> +	li	r10,80
> +	mtlr	r12
> +	li	r11,96
> +	li	r12,112
> +	addi	r1,r1,STACKFRAMESIZE
> +
> +	.align	5

Do we know that the blank will be filled with something harmless ?

> +1:	lvx	vr7,r0,r4
> +	lvx	vr6,r4,r6
> +	lvx	vr5,r4,r7
> +	lvx	vr4,r4,r8
> +	lvx	vr3,r4,r9
> +	lvx	vr2,r4,r10
> +	lvx	vr1,r4,r11
> +	lvx	vr0,r4,r12
> +	addi	r4,r4,128
> +	stvx	vr7,r0,r3
> +	stvx	vr6,r3,r6
> +	stvx	vr5,r3,r7
> +	stvx	vr4,r3,r8
> +	stvx	vr3,r3,r9
> +	stvx	vr2,r3,r10
> +	stvx	vr1,r3,r11
> +	stvx	vr0,r3,r12
> +	addi	r3,r3,128
> +	bdnz	1b

What about lvxl ? You aren't likely to re-use the source data soon
right ?

Hrm... re-reading the arch, it looks like the "l" variant is quirky,
should really only used on the last load of a cache block, but in your
case that should be ok to put it on the last accesses since we know the
alignment.

> +	blr
> Index: linux-powerpc/arch/powerpc/lib/Makefile
> ===================================================================
> --- linux-powerpc.orig/arch/powerpc/lib/Makefile	2011-05-19 19:57:38.058570608 +1000
> +++ linux-powerpc/arch/powerpc/lib/Makefile	2011-06-17 07:39:58.996165527 +1000
> @@ -16,7 +16,8 @@ obj-$(CONFIG_HAS_IOMEM)	+= devres.o
>  
>  obj-$(CONFIG_PPC64)	+= copypage_64.o copyuser_64.o \
>  			   memcpy_64.o usercopy_64.o mem_64.o string.o \
> -			   checksum_wrappers_64.o hweight_64.o
> +			   checksum_wrappers_64.o hweight_64.o \
> +			   copypage_power7.o
>  obj-$(CONFIG_XMON)	+= sstep.o ldstfp.o
>  obj-$(CONFIG_KPROBES)	+= sstep.o ldstfp.o
>  obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= sstep.o ldstfp.o
> Index: linux-powerpc/arch/powerpc/lib/copypage_64.S
> ===================================================================
> --- linux-powerpc.orig/arch/powerpc/lib/copypage_64.S	2011-06-06 08:07:35.000000000 +1000
> +++ linux-powerpc/arch/powerpc/lib/copypage_64.S	2011-06-17 07:39:58.996165527 +1000
> @@ -17,7 +17,11 @@ PPC64_CACHES:
>          .section        ".text"
>  
>  _GLOBAL(copy_page)
> +BEGIN_FTR_SECTION
>  	lis	r5,PAGE_SIZE@h
> +FTR_SECTION_ELSE
> +        b       .copypage_power7
> +ALT_FTR_SECTION_END_IFCLR(CPU_FTR_POWER7)
>  	ori	r5,r5,PAGE_SIZE@l
>  BEGIN_FTR_SECTION
>  	ld      r10,PPC64_CACHES@toc(r2)
> 

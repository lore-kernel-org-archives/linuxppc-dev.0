Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D094F1A040C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 01:28:58 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 69567140BA3
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2016 01:28:58 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 25 Feb 2016 00:28:56 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 446292CE8059
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2016 01:28:53 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1OESj0F7668032
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2016 01:28:53 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1OESK4V031770
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2016 01:28:21 +1100
Date: Wed, 24 Feb 2016 19:57:38 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v5 1/9] selftests/powerpc: Test the preservation of FPU
 and VMX regs across syscall
Message-ID: <20160224142738.GB18778@naverao1-tp.ibm.com>
References: <1456198702-29657-1-git-send-email-cyrilbur@gmail.com>
 <1456198702-29657-2-git-send-email-cyrilbur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456198702-29657-2-git-send-email-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/02/23 02:38PM, Cyril Bur wrote:
> Test that the non volatile floating point and Altivec registers get
> correctly preserved across the fork() syscall.
> 
> fork() works nicely for this purpose, the registers should be the same for
> both parent and child
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
>  tools/testing/selftests/powerpc/Makefile           |   3 +-
>  tools/testing/selftests/powerpc/basic_asm.h        |  62 +++++++
>  tools/testing/selftests/powerpc/math/.gitignore    |   2 +
>  tools/testing/selftests/powerpc/math/Makefile      |  16 ++
>  tools/testing/selftests/powerpc/math/fpu_asm.S     | 161 +++++++++++++++++
>  tools/testing/selftests/powerpc/math/fpu_syscall.c |  90 ++++++++++
>  tools/testing/selftests/powerpc/math/vmx_asm.S     | 195 +++++++++++++++++++++
>  tools/testing/selftests/powerpc/math/vmx_syscall.c |  91 ++++++++++
>  8 files changed, 619 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/powerpc/basic_asm.h
>  create mode 100644 tools/testing/selftests/powerpc/math/.gitignore
>  create mode 100644 tools/testing/selftests/powerpc/math/Makefile
>  create mode 100644 tools/testing/selftests/powerpc/math/fpu_asm.S
>  create mode 100644 tools/testing/selftests/powerpc/math/fpu_syscall.c
>  create mode 100644 tools/testing/selftests/powerpc/math/vmx_asm.S
>  create mode 100644 tools/testing/selftests/powerpc/math/vmx_syscall.c
> 
> diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
> index 0c2706b..19e8191 100644
> --- a/tools/testing/selftests/powerpc/Makefile
> +++ b/tools/testing/selftests/powerpc/Makefile
> @@ -22,7 +22,8 @@ SUB_DIRS = benchmarks 		\
>  	   switch_endian	\
>  	   syscalls		\
>  	   tm			\
> -	   vphn
> +	   vphn         \
> +	   math
> 
>  endif
> 
> diff --git a/tools/testing/selftests/powerpc/basic_asm.h b/tools/testing/selftests/powerpc/basic_asm.h
> new file mode 100644
> index 0000000..f56482f
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/basic_asm.h
> @@ -0,0 +1,62 @@
> +#include <ppc-asm.h>
> +#include <asm/unistd.h>
> +
> +#if defined(_CALL_ELF) && _CALL_ELF == 2
> +#define STACK_FRAME_MIN_SIZE 32
> +#define STACK_FRAME_TOC_POS  24
> +#define __STACK_FRAME_PARAM(_param)  (32 + ((_param)*8))
> +#define __STACK_FRAME_LOCAL(_num_params,_var_num)  ((STACK_FRAME_PARAM(_num_params)) + ((_var_num)*8))
> +#else
> +#define STACK_FRAME_MIN_SIZE 112
> +#define STACK_FRAME_TOC_POS  40
> +#define __STACK_FRAME_PARAM(i)  (48 + ((i)*8))
> +/*
> + * Caveat: if a function passed more than 8 params, the caller will have
> + * made more space... this should be reflected by this C code.
> + * if (_num_params > 8)
> + *     total = 112 + ((_num_params - 8) * 8)
> + *
> + * And substitute the '112' for 'total' in the macro. Doable in preprocessor for ASM?
> + */

Per my understanding, the parameter save area is only for parameters to 
functions that *we* call. And since we control that, I don't think we 
need to worry about having more than 8 parameters.

> +#define __STACK_FRAME_LOCAL(_num_params,_var_num)  (112 + ((_var_num)*8))
> +#endif
> +/* Parameter x saved to the stack */
> +#define STACK_FRAME_PARAM(var)    __STACK_FRAME_PARAM(var)
> +/* Local variable x saved to the stack after x parameters */
> +#define STACK_FRAME_LOCAL(num_params,var)    __STACK_FRAME_LOCAL(num_params,var)

So this works, but I'm wondering if this is really worth the code 
complexity - every use needs to determine appropriate extra stack space, 
the number of parameters to save and so on.  This is after all for 
selftests and so, we probably don't need to be precise in stack space 
usage. We can get away using a larger fixed size stack.  That will 
simplify a lot of the code further on and future tests won't need to 
bother with all the details.

So, how about (not tested):

#define STACK_FRAME_PARAM_SAVE_AREA	64
#define STACK_FRAME_LOCAL_VAR		64
#define STACK_FRAME_FPU_SAVE_AREA	144
#define STACK_FRAME_GPR_SAVE_AREA	144
#define STACK_FRAME_VMX_SAVE_AREA	192

#if defined(_CALL_ELF) && _CALL_ELF == 2
#define STACK_FRAME_HEADER	32
#define STACK_FRAME_VRSAVE	0
#else
#define STACK_FRAME_HEADER	48
#define STACK_FRAME_VRSAVE	16
#endif

#define STACK_FRAME_SIZE	(STACK_FRAME_HEADER + \
				 STACK_FRAME_VRSAVE + \
				 STACK_FRAME_PARAM_SAVE_AREA + \
				 STACK_FRAME_LOCAL_VAR + \
				 STACK_FRAME_FPU_SAVE_AREA + \
				 STACK_FRAME_GPR_SAVE_AREA + \
				 STACK_FRAME_VMX_SAVE_AREA)

/* Accessors */
#define STACK_FRAME_LR_POS	16
#define STACK_FRAME_CR_POS	8
#if defined(_CALL_ELF) && _CALL_ELF == 2
#define STACK_FRAME_TOC_POS	24
#else
#define STACK_FRAME_TOC_POS	40
#endif

#define STACK_FRAME_PARAM(i)	(STACK_FRAME_HEADER + ((i) * 8))
#define STACK_FRAME_LOCAL(i)	(STACK_FRAME_HEADER + \
				 STACK_FRAME_PARAM_SAVE_AREA + \
				 ((i) * 8))

/* The below are referenced from the previous stack pointer */
#define STACK_FRAME_FPU(i)	(STACK_FRAME_SIZE - ((32 - (i)) * 8))
#define STACK_FRAME_GPR(i)	(STACK_FRAME_SIZE - \
				 STACK_FRAME_FPU_SAVE_AREA - \
				 ((32 - (i)) * 8))
#define STACK_FRAME_VMX(i)	(STACK_FRAME_SIZE - \
				 STACK_FRAME_FPU_SAVE_AREA - \
				 STACK_FRAME_GPR_SAVE_AREA - \
				 STACK_FRAME_VRSAVE - \
				 ((32 - (i)) * 16)

> +#define STACK_FRAME_LR_POS   16
> +#define STACK_FRAME_CR_POS   8
> +
> +#define LOAD_REG_IMMEDIATE(reg,expr) \
> +	lis	reg,(expr)@highest;	\
> +	ori	reg,reg,(expr)@higher;	\
> +	rldicr	reg,reg,32,31;	\
> +	oris	reg,reg,(expr)@high;	\
> +	ori	reg,reg,(expr)@l;
> +
> +/* It is very important to note here that _extra is the extra amount of
> + * stack space needed.
> + * This space must be accessed using STACK_FRAME_PARAM() or
> + * STACK_FRAME_LOCAL() macros!
> + *
> + * r1 and r2 are not defined in ppc-asm.h (instead they are defined as sp
> + * and toc). Kernel programmers tend to prefer rX even for r1 and r2, hence
> + * %1 and %r2. r0 is defined in ppc-asm.h and therefore %r0 gets
> + * preprocessed incorrectly, hence r0.
> + */
> +#define PUSH_BASIC_STACK(_extra) \
> +	mflr	r0; \
> +	std	r0,STACK_FRAME_LR_POS(%r1); \
> +	stdu	%r1,-(_extra + STACK_FRAME_MIN_SIZE)(%r1); \
> +	mfcr	r0; \
> +	stw	r0,STACK_FRAME_CR_POS(%r1); \
> +	std	%r2,STACK_FRAME_TOC_POS(%r1);
> +
> +#define POP_BASIC_STACK(_extra) \
> +	ld	%r2,STACK_FRAME_TOC_POS(%r1); \
> +	lwz	r0,STACK_FRAME_CR_POS(%r1); \
> +	mtcr	r0; \
> +	addi	%r1,%r1,(_extra + STACK_FRAME_MIN_SIZE); \
> +	ld	r0,STACK_FRAME_LR_POS(%r1); \
> +	mtlr	r0;
> +

So, these become:
#define PUSH_BASIC_STACK() \
	mflr	r0; \
	std	r0,STACK_FRAME_LR_POS(%r1); \
	stdu	%r1,-(STACK_FRAME_SIZE)(%r1); \
	mfcr	r0; \
	stw	r0,STACK_FRAME_CR_POS(%r1); \
	std	%r2,STACK_FRAME_TOC_POS(%r1);

#define POP_BASIC_STACK() \
	ld	%r2,STACK_FRAME_TOC_POS(%r1); \
	lwz	r0,STACK_FRAME_CR_POS(%r1); \
	mtcr	r0; \
	addi	%r1,%r1,(STACK_FRAME_SIZE); \
	ld	r0,STACK_FRAME_LR_POS(%r1); \
	mtlr	r0;


> diff --git a/tools/testing/selftests/powerpc/math/.gitignore b/tools/testing/selftests/powerpc/math/.gitignore
> new file mode 100644
> index 0000000..b19b269
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/math/.gitignore
> @@ -0,0 +1,2 @@
> +fpu_syscall
> +vmx_syscall
> diff --git a/tools/testing/selftests/powerpc/math/Makefile b/tools/testing/selftests/powerpc/math/Makefile
> new file mode 100644
> index 0000000..598e5df
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/math/Makefile
> @@ -0,0 +1,16 @@
> +TEST_PROGS := fpu_syscall vmx_syscall
> +
> +all: $(TEST_PROGS)
> +
> +#The general powerpc makefile adds -flto. This isn't interacting well with the custom ASM.
> +#filter-out -flto to avoid false failures.
> +$(TEST_PROGS): ../harness.c
> +$(TEST_PROGS): CFLAGS = $(filter-out -flto,$(CFLAGS) -O2 -g -pthread -m64 -maltivec)
> +
> +fpu_syscall: fpu_asm.S
> +vmx_syscall: vmx_asm.S
> +
> +include ../../lib.mk
> +
> +clean:
> +	rm -f $(TEST_PROGS) *.o
> diff --git a/tools/testing/selftests/powerpc/math/fpu_asm.S b/tools/testing/selftests/powerpc/math/fpu_asm.S
> new file mode 100644
> index 0000000..b12c051
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/math/fpu_asm.S
> @@ -0,0 +1,161 @@
> +/*
> + * Copyright 2015, Cyril Bur, IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include "../basic_asm.h"
> +
> +#define PUSH_FPU(pos) \
> +	stfd	f14,pos(sp); \
> +	stfd	f15,pos+8(sp); \
> +	stfd	f16,pos+16(sp); \
> +	stfd	f17,pos+24(sp); \
> +	stfd	f18,pos+32(sp); \
> +	stfd	f19,pos+40(sp); \
> +	stfd	f20,pos+48(sp); \
> +	stfd	f21,pos+56(sp); \
> +	stfd	f22,pos+64(sp); \
> +	stfd	f23,pos+72(sp); \
> +	stfd	f24,pos+80(sp); \
> +	stfd	f25,pos+88(sp); \
> +	stfd	f26,pos+96(sp); \
> +	stfd	f27,pos+104(sp); \
> +	stfd	f28,pos+112(sp); \
> +	stfd	f29,pos+120(sp); \
> +	stfd	f30,pos+128(sp); \
> +	stfd	f31,pos+136(sp);
> +

#define PUSH_FPU() \
	stfd	f14,STACK_FRAME_FPU(14)(sp); \
	stfd	f15,STACK_FRAME_FPU(15)(sp); \
	stfd	f16,STACK_FRAME_FPU(16)(sp); \
	stfd	f17,STACK_FRAME_FPU(17)(sp); \

... and so on without need for a parameter.

> +#define POP_FPU(pos) \
> +	lfd	f14,pos(sp); \
> +	lfd	f15,pos+8(sp); \
> +	lfd	f16,pos+16(sp); \
> +	lfd	f17,pos+24(sp); \
> +	lfd	f18,pos+32(sp); \

<snip>

> +
> +FUNC_START(test_fpu)
> +	#r3 holds pointer to where to put the result of fork
> +	#r4 holds pointer to the pid
> +	#f14-f31 are non volatiles
> +	PUSH_BASIC_STACK(256)
> +	std	r3,STACK_FRAME_PARAM(0)(sp) #Address of darray
> +	std r4,STACK_FRAME_PARAM(1)(sp) #Address of pid
> +	PUSH_FPU(STACK_FRAME_LOCAL(2,0))

The above now becomes:
FUNC_START(test_fpu)
	#r3 holds pointer to where to put the result of fork
	#r4 holds pointer to the pid
	#f14-f31 are non volatiles
	PUSH_BASIC_STACK()
	std	r3,STACK_FRAME_PARAM(0)(sp) #Address of darray
	std	r4,STACK_FRAME_PARAM(1)(sp) #Address of pid
	PUSH_FPU()

Also note that as per the ABI, the floating point registers save area is 
just below the previous stack pointer.

> +
> +	bl load_fpu
> +	nop
> +	li	r0,__NR_fork
> +	sc
> +
> +	#pass the result of the fork to the caller
> +	ld	r9,STACK_FRAME_PARAM(1)(sp)
> +	std	r3,0(r9)
> +
> +	ld r3,STACK_FRAME_PARAM(0)(sp)
> +	bl check_fpu
> +	nop
> +
> +	POP_FPU(STACK_FRAME_LOCAL(2,0))
> +	POP_BASIC_STACK(256)

And, just:

	POP_FPU()
	POP_BASIC_STACK()

In my opinion, that's much simpler.


- Naveen

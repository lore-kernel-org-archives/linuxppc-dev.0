Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 561501A0354
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 03:59:35 +1100 (AEDT)
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 574FB1402D6
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 03:59:34 +1100 (AEDT)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 15 Feb 2016 22:29:30 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1FGxFWg11206940
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Feb 2016 22:29:16 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1FGxQbd008580
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Feb 2016 22:29:27 +0530
Date: Mon, 15 Feb 2016 22:29:17 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, anton@samba.org
Subject: Re: [PATCH v4 1/9] selftests/powerpc: Test the preservation of FPU
 and VMX regs across syscall
Message-ID: <20160215165916.GH2599@naverao1-tp.ibm.com>
References: <1455512850-2543-1-git-send-email-cyrilbur@gmail.com>
 <1455512850-2543-2-git-send-email-cyrilbur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455512850-2543-2-git-send-email-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/02/15 04:07PM, Cyril Bur wrote:
> Test that the non volatile floating point and Altivec registers get
> correctly preserved across the fork() syscall.
> 
> fork() works nicely for this purpose, the registers should be the same for
> both parent and child
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
>  tools/testing/selftests/powerpc/Makefile           |   3 +-
>  tools/testing/selftests/powerpc/basic_asm.h        |  30 ++++
>  tools/testing/selftests/powerpc/math/.gitignore    |   2 +
>  tools/testing/selftests/powerpc/math/Makefile      |  14 ++
>  tools/testing/selftests/powerpc/math/fpu_asm.S     | 161 +++++++++++++++++
>  tools/testing/selftests/powerpc/math/fpu_syscall.c |  90 ++++++++++
>  tools/testing/selftests/powerpc/math/vmx_asm.S     | 193 +++++++++++++++++++++
>  tools/testing/selftests/powerpc/math/vmx_syscall.c |  92 ++++++++++
>  8 files changed, 584 insertions(+), 1 deletion(-)
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
> index 0000000..f243da0
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/basic_asm.h
> @@ -0,0 +1,30 @@
> +#include <ppc-asm.h>
> +#include <asm/unistd.h>
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
> + * This space must be accessed at sp + 32!

This looks to be specific to ABIv2. Is this series limited to ppc64le?  
If so, you might want to ensure this only builds there.

Also:
#define PPC_ABIV2_MIN_STACK_SIZE 32

or just:
#define PPC_MIN_STACK	32

... is helpful. And, you might want to base the rest of your code that 
use PUSH_BASIC_STACK() on that. If we ever want to have these tests run 
anywhere else, that'll help a lot. (See further below)

> + */
> +#define PUSH_BASIC_STACK(_extra) \
> +	mflr	r0; \
> +	std	r0,16(sp); \
> +	stdu	sp,-(_extra + 32)(sp); \
> +	mfcr	r0; \
> +	stw	r0,8(sp); \
> +	std	2,24(sp);
		^^
Better to use r2 here and below.

> +
> +#define POP_BASIC_STACK(_extra) \
> +	ld	2,24(sp); \
> +	lwz	r0,8(sp); \
> +	mtcr	r0; \
> +	addi	sp,sp,(_extra + 32); \
> +	ld	r0,16(sp); \
> +	mtlr	r0;
> +
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
> index 0000000..418bef1
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/math/Makefile
> @@ -0,0 +1,14 @@
> +TEST_PROGS := fpu_syscall vmx_syscall
> +
> +all: $(TEST_PROGS)
> +
> +$(TEST_PROGS): ../harness.c
> +$(TEST_PROGS): CFLAGS += -O2 -g -pthread -m64 -maltivec
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
> index 0000000..8733874
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
> +#define POP_FPU(pos) \
> +	lfd	f14,pos(sp); \
> +	lfd	f15,pos+8(sp); \
> +	lfd	f16,pos+16(sp); \
> +	lfd	f17,pos+24(sp); \
> +	lfd	f18,pos+32(sp); \
> +	lfd	f19,pos+40(sp); \
> +	lfd	f20,pos+48(sp); \
> +	lfd	f21,pos+56(sp); \
> +	lfd	f22,pos+64(sp); \
> +	lfd	f23,pos+72(sp); \
> +	lfd	f24,pos+80(sp); \
> +	lfd	f25,pos+88(sp); \
> +	lfd	f26,pos+96(sp); \
> +	lfd	f27,pos+104(sp); \
> +	lfd	f28,pos+112(sp); \
> +	lfd	f29,pos+120(sp); \
> +	lfd	f30,pos+128(sp); \
> +	lfd	f31,pos+136(sp);
> +
> +#Careful calling this, it will 'clobber' fpu (by design)
> +#Don't call this from C
> +FUNC_START(load_fpu)
> +	lfd	f14,0(r3)
> +	lfd	f15,8(r3)
> +	lfd	f16,16(r3)
> +	lfd	f17,24(r3)
> +	lfd	f18,32(r3)
> +	lfd	f19,40(r3)
> +	lfd	f20,48(r3)
> +	lfd	f21,56(r3)
> +	lfd	f22,64(r3)
> +	lfd	f23,72(r3)
> +	lfd	f24,80(r3)
> +	lfd	f25,88(r3)
> +	lfd	f26,96(r3)
> +	lfd	f27,104(r3)
> +	lfd	f28,112(r3)
> +	lfd	f29,120(r3)
> +	lfd	f30,128(r3)
> +	lfd	f31,136(r3)
> +	blr
> +FUNC_END(load_fpu)
> +
> +FUNC_START(check_fpu)
> +	mr r4,r3
> +	li	r3,1 #assume a bad result
> +	lfd	f0,0(r4)
> +	fcmpu	cr1,f0,f14
> +	bne	cr1,1f
> +	lfd	f0,8(r4)
> +	fcmpu	cr1,f0,f15
> +	bne	cr1,1f
> +	lfd	f0,16(r4)
> +	fcmpu	cr1,f0,f16
> +	bne	cr1,1f
> +	lfd	f0,24(r4)
> +	fcmpu	cr1,f0,f17
> +	bne	cr1,1f
> +	lfd	f0,32(r4)
> +	fcmpu	cr1,f0,f18
> +	bne	cr1,1f
> +	lfd	f0,40(r4)
> +	fcmpu	cr1,f0,f19
> +	bne	cr1,1f
> +	lfd	f0,48(r4)
> +	fcmpu	cr1,f0,f20
> +	bne	cr1,1f
> +	lfd	f0,56(r4)
> +	fcmpu	cr1,f0,f21
> +	bne	cr1,1f
> +	lfd	f0,64(r4)
> +	fcmpu	cr1,f0,f22
> +	bne	cr1,1f
> +	lfd	f0,72(r4)
> +	fcmpu	cr1,f0,f23
> +	bne	cr1,1f
> +	lfd	f0,80(r4)
> +	fcmpu	cr1,f0,f24
> +	bne	cr1,1f
> +	lfd	f0,88(r4)
> +	fcmpu	cr1,f0,f25
> +	bne	cr1,1f
> +	lfd	f0,96(r4)
> +	fcmpu	cr1,f0,f26
> +	bne	cr1,1f
> +	lfd	f0,104(r4)
> +	fcmpu	cr1,f0,f27
> +	bne	cr1,1f
> +	lfd	f0,112(r4)
> +	fcmpu	cr1,f0,f28
> +	bne	cr1,1f
> +	lfd	f0,120(r4)
> +	fcmpu	cr1,f0,f29
> +	bne	cr1,1f
> +	lfd	f0,128(r4)
> +	fcmpu	cr1,f0,f30
> +	bne	cr1,1f
> +	lfd	f0,136(r4)
> +	fcmpu	cr1,f0,f31
> +	bne	cr1,1f
> +	li	r3,0 #Sucess!!!
> +1:	blr
> +
> +FUNC_START(test_fpu)
> +	#r3 holds pointer to where to put the result of fork
> +	#r4 holds pointer to the pid
> +	#f14-f31 are non volatiles
> +	PUSH_BASIC_STACK(256)
> +	std	r3,40(sp) #Address of darray

So, this could be:
	PUSH_BASIC_STACK(256)
	std	r3,PPC_MIN_STACK+8(sp)

... though I wonder why there is +8 here?


- Naveen

Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E6BAE1A09C4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 03:57:13 +1100 (AEDT)
Date: Thu, 27 Nov 2014 10:56:50 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/2]powerpc: foundation code to handle CR5 for local_t
Message-ID: <20141127165650.GA28278@gate.crashing.org>
References: <1417090721-25298-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1417090721-25298-2-git-send-email-maddy@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417090721-25298-2-git-send-email-maddy@linux.vnet.ibm.com>
Cc: rusty@rustcorp.com.au, paulus@samba.org, anton@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 27, 2014 at 05:48:40PM +0530, Madhavan Srinivasan wrote:
> Here is the design of this patch. Since local_* operations 
> are only need to be atomic to interrupts (IIUC), patch uses 
> one of the Condition Register (CR) fields as a flag variable. When 
> entering the local_*, specific bit in the CR5 field is set
> and on exit, bit is cleared. CR bit checking is done in the
> interrupt return path. If CR5[EQ] bit set and if we return 
> to kernel, we reset to start of local_* operation.

Have you tested this with (upcoming) GCC 5.0?  GCC now uses CR5,
and it likes to use it very much, it might be more convenient to
use e.g. CR1 (which is allocated almost last, only before CR0).

> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -306,7 +306,26 @@ do_kvm_##n:								\
>  	std	r10,0(r1);		/* make stack chain pointer	*/ \
>  	std	r0,GPR0(r1);		/* save r0 in stackframe	*/ \
>  	std	r10,GPR1(r1);		/* save r1 in stackframe	*/ \
> -	beq	4f;			/* if from kernel mode		*/ \
> +BEGIN_FTR_SECTION;							   \
> +	lis	r9,4096;		/* Create a mask with HV and PR */ \
> +	rldicr	r9,r9,32,31;		/* bits, AND with the MSR       */ \
> +	mr	r10,r9;			/* to check for Hyp state       */ \
> +	ori	r9,r9,16384;						   \
> +	and	r9,r12,r9;						   \
> +	cmpd	cr3,r10,r9;							   \
> +	beq	cr3,66f;		/* Jump if we come from Hyp mode*/ \
> +	mtcrf	0x04,r10;		/* Clear CR5 if coming from usr */ \

Wow, such nastiness, only to avoid using dot insns (since you need to keep
the current CR0 value for the following beq 4f).  And CR0 already holds the
PR bit, so you need only to check the HV bit anyway?  Some restructuring
would make this a lot simpler and clearer.

> +	/*
> +	 * Now that we are about to exit from interrupt, lets check for
> +	 * cr5 eq bit. If it is set, then we may be in the middle of
> +	 * local_t update. In this case, we should rewind the NIP
> +	 * accordingly.
> +	 */
> +	mfcr	r3
> +	andi.	r4,r3,0x200
> +	beq	63f

This is just   bne cr5,63f   isn't it?

> index 72e783e..edb75a9 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -637,7 +637,7 @@ masked_##_H##interrupt:					\
>  	rldicl	r10,r10,48,1; /* clear MSR_EE */	\
>  	rotldi	r10,r10,16;				\
>  	mtspr	SPRN_##_H##SRR1,r10;			\
> -2:	mtcrf	0x80,r9;				\
> +2:	mtcrf	0x90,r9;				\
>  	ld	r9,PACA_EXGEN+EX_R9(r13);		\
>  	ld	r10,PACA_EXGEN+EX_R10(r13);		\
>  	ld	r11,PACA_EXGEN+EX_R11(r13);		\

What does this do?


Segher

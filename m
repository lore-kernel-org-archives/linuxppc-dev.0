Return-Path: <paubert@iram.es>
Received: from marchena.puc.rediris.es (marchena.puc.rediris.es
 [IPv6:2001:720:418:ca00::4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDSc25jxXzDqDD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 18:04:18 +1000 (AEST)
Date: Mon, 23 May 2016 19:26:29 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc32: use stmw/lmw for non volatile registers
 save/restore
Message-ID: <20160523172629.GB15830@visitor2.iram.es>
References: <20160523084637.063611A239A@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160523084637.063611A239A@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 23, 2016 at 10:46:36AM +0200, Christophe Leroy wrote:
> lmw/stmw have a 1 cycle (2 cycles for lmw on some ppc) in addition
> and implies serialising, however it reduces the amount of instructions
> hence the amount of instruction fetch compared to the equivalent
> operation with several lzw/stw. It means less pressure on cache and

Minor typo, s/lzw/lwz/.

> less fetching delays on slow memory.
> When we transfer 20 registers, it is worth it.
> gcc uses stmw/lmw at function entry/exit to save/restore non
> volatile register, so lets also do it that way.
> 
> On powerpc64, we can't use lmw/stmw as it only handles 32 bits, so
> we move longjmp() and setjmp() from misc.S to misc_64.S, and we
> write a 32 bits version in misc_32.S using stmw/lmw
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> The patch goes on top of "powerpc: inline current_stack_pointer()" or
> requires trivial manual merge in arch/powerpc/kernel/misc.S
> 
>  arch/powerpc/include/asm/ppc_asm.h |  6 ++--
>  arch/powerpc/kernel/misc.S         | 61 --------------------------------------
>  arch/powerpc/kernel/misc_32.S      | 22 ++++++++++++++
>  arch/powerpc/kernel/misc_64.S      | 61 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 85 insertions(+), 65 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
> index 2b31632..e29b649 100644
> --- a/arch/powerpc/include/asm/ppc_asm.h
> +++ b/arch/powerpc/include/asm/ppc_asm.h
> @@ -82,10 +82,8 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
>  #else
>  #define SAVE_GPR(n, base)	stw	n,GPR0+4*(n)(base)
>  #define REST_GPR(n, base)	lwz	n,GPR0+4*(n)(base)
> -#define SAVE_NVGPRS(base)	SAVE_GPR(13, base); SAVE_8GPRS(14, base); \
> -				SAVE_10GPRS(22, base)
> -#define REST_NVGPRS(base)	REST_GPR(13, base); REST_8GPRS(14, base); \
> -				REST_10GPRS(22, base)
> +#define SAVE_NVGPRS(base)	stmw	13, GPR0+4*13(base)
> +#define REST_NVGPRS(base)	lmw	13, GPR0+4*13(base)
>  #endif
>  
>  #define SAVE_2GPRS(n, base)	SAVE_GPR(n, base); SAVE_GPR(n+1, base)
> diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
> index 7ce26d4..9de71d8 100644
> --- a/arch/powerpc/kernel/misc.S
> +++ b/arch/powerpc/kernel/misc.S
> @@ -53,64 +53,3 @@ _GLOBAL(add_reloc_offset)
>  
>  	.align	3
>  2:	PPC_LONG 1b
> -
> -_GLOBAL(setjmp)
> -	mflr	r0
> -	PPC_STL	r0,0(r3)
> -	PPC_STL	r1,SZL(r3)
> -	PPC_STL	r2,2*SZL(r3)
> -	mfcr	r0
> -	PPC_STL	r0,3*SZL(r3)
> -	PPC_STL	r13,4*SZL(r3)
> -	PPC_STL	r14,5*SZL(r3)
> -	PPC_STL	r15,6*SZL(r3)
> -	PPC_STL	r16,7*SZL(r3)
> -	PPC_STL	r17,8*SZL(r3)
> -	PPC_STL	r18,9*SZL(r3)
> -	PPC_STL	r19,10*SZL(r3)
> -	PPC_STL	r20,11*SZL(r3)
> -	PPC_STL	r21,12*SZL(r3)
> -	PPC_STL	r22,13*SZL(r3)
> -	PPC_STL	r23,14*SZL(r3)
> -	PPC_STL	r24,15*SZL(r3)
> -	PPC_STL	r25,16*SZL(r3)
> -	PPC_STL	r26,17*SZL(r3)
> -	PPC_STL	r27,18*SZL(r3)
> -	PPC_STL	r28,19*SZL(r3)
> -	PPC_STL	r29,20*SZL(r3)
> -	PPC_STL	r30,21*SZL(r3)
> -	PPC_STL	r31,22*SZL(r3)
> -	li	r3,0
> -	blr
> -
> -_GLOBAL(longjmp)
> -	PPC_LCMPI r4,0
> -	bne	1f
> -	li	r4,1
> -1:	PPC_LL	r13,4*SZL(r3)
> -	PPC_LL	r14,5*SZL(r3)
> -	PPC_LL	r15,6*SZL(r3)
> -	PPC_LL	r16,7*SZL(r3)
> -	PPC_LL	r17,8*SZL(r3)
> -	PPC_LL	r18,9*SZL(r3)
> -	PPC_LL	r19,10*SZL(r3)
> -	PPC_LL	r20,11*SZL(r3)
> -	PPC_LL	r21,12*SZL(r3)
> -	PPC_LL	r22,13*SZL(r3)
> -	PPC_LL	r23,14*SZL(r3)
> -	PPC_LL	r24,15*SZL(r3)
> -	PPC_LL	r25,16*SZL(r3)
> -	PPC_LL	r26,17*SZL(r3)
> -	PPC_LL	r27,18*SZL(r3)
> -	PPC_LL	r28,19*SZL(r3)
> -	PPC_LL	r29,20*SZL(r3)
> -	PPC_LL	r30,21*SZL(r3)
> -	PPC_LL	r31,22*SZL(r3)
> -	PPC_LL	r0,3*SZL(r3)
> -	mtcrf	0x38,r0
> -	PPC_LL	r0,0(r3)
> -	PPC_LL	r1,SZL(r3)
> -	PPC_LL	r2,2*SZL(r3)
> -	mtlr	r0
> -	mr	r3,r4
> -	blr
> diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
> index d9c912b..de419e9 100644
> --- a/arch/powerpc/kernel/misc_32.S
> +++ b/arch/powerpc/kernel/misc_32.S
> @@ -1086,3 +1086,25 @@ relocate_new_kernel_end:
>  relocate_new_kernel_size:
>  	.long relocate_new_kernel_end - relocate_new_kernel
>  #endif
> +
> +_GLOBAL(setjmp)
> +	mflr	r0
> +	li	r3, 0
> +	stw	r0, 0(r3)

Huh? Explicitly writing to address 0? Has this code been test run at
least once?

At least move the li r3,0 to just before the blr.

    Gabriel

> +	stw	r1, 4(r3)
> +	stw	r2, 8(r3)
> +	mfcr	r12
> +	stmw	r12, 12(r3)
> +	blr
> +
> +_GLOBAL(longjmp)
> +	lwz	r0, 0(r3)
> +	lwz	r1, 4(r3)
> +	lwz	r2, 8(r3)
> +	lmw	r12, 12(r3)
> +	mtcrf	0x38, r12
> +	mtlr	r0
> +	mr.	r3, r4
> +	bnelr
> +	li	r3, 1
> +	blr
> diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
> index f28754c..7e25249 100644
> --- a/arch/powerpc/kernel/misc_64.S
> +++ b/arch/powerpc/kernel/misc_64.S
> @@ -701,3 +701,64 @@ _GLOBAL(kexec_sequence)
>  	li	r5,0
>  	blr	/* image->start(physid, image->start, 0); */
>  #endif /* CONFIG_KEXEC */
> +
> +_GLOBAL(setjmp)
> +	mflr	r0
> +	PPC_STL	r0,0(r3)
> +	PPC_STL	r1,SZL(r3)
> +	PPC_STL	r2,2*SZL(r3)
> +	mfcr	r0
> +	PPC_STL	r0,3*SZL(r3)
> +	PPC_STL	r13,4*SZL(r3)
> +	PPC_STL	r14,5*SZL(r3)
> +	PPC_STL	r15,6*SZL(r3)
> +	PPC_STL	r16,7*SZL(r3)
> +	PPC_STL	r17,8*SZL(r3)
> +	PPC_STL	r18,9*SZL(r3)
> +	PPC_STL	r19,10*SZL(r3)
> +	PPC_STL	r20,11*SZL(r3)
> +	PPC_STL	r21,12*SZL(r3)
> +	PPC_STL	r22,13*SZL(r3)
> +	PPC_STL	r23,14*SZL(r3)
> +	PPC_STL	r24,15*SZL(r3)
> +	PPC_STL	r25,16*SZL(r3)
> +	PPC_STL	r26,17*SZL(r3)
> +	PPC_STL	r27,18*SZL(r3)
> +	PPC_STL	r28,19*SZL(r3)
> +	PPC_STL	r29,20*SZL(r3)
> +	PPC_STL	r30,21*SZL(r3)
> +	PPC_STL	r31,22*SZL(r3)
> +	li	r3,0
> +	blr
> +
> +_GLOBAL(longjmp)
> +	PPC_LCMPI r4,0
> +	bne	1f
> +	li	r4,1
> +1:	PPC_LL	r13,4*SZL(r3)
> +	PPC_LL	r14,5*SZL(r3)
> +	PPC_LL	r15,6*SZL(r3)
> +	PPC_LL	r16,7*SZL(r3)
> +	PPC_LL	r17,8*SZL(r3)
> +	PPC_LL	r18,9*SZL(r3)
> +	PPC_LL	r19,10*SZL(r3)
> +	PPC_LL	r20,11*SZL(r3)
> +	PPC_LL	r21,12*SZL(r3)
> +	PPC_LL	r22,13*SZL(r3)
> +	PPC_LL	r23,14*SZL(r3)
> +	PPC_LL	r24,15*SZL(r3)
> +	PPC_LL	r25,16*SZL(r3)
> +	PPC_LL	r26,17*SZL(r3)
> +	PPC_LL	r27,18*SZL(r3)
> +	PPC_LL	r28,19*SZL(r3)
> +	PPC_LL	r29,20*SZL(r3)
> +	PPC_LL	r30,21*SZL(r3)
> +	PPC_LL	r31,22*SZL(r3)
> +	PPC_LL	r0,3*SZL(r3)
> +	mtcrf	0x38,r0
> +	PPC_LL	r0,0(r3)
> +	PPC_LL	r1,SZL(r3)
> +	PPC_LL	r2,2*SZL(r3)
> +	mtlr	r0
> +	mr	r3,r4
> +	blr
> -- 
> 2.1.0
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

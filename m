Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BCCF1A03EF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 12:06:24 +1100 (AEDT)
Received: from mail-pf0-x22c.google.com (mail-pf0-x22c.google.com
 [IPv6:2607:f8b0:400e:c00::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 62AAA140B9A
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2016 12:06:23 +1100 (AEDT)
Received: by mail-pf0-x22c.google.com with SMTP id c10so23399512pfc.2
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2016 17:06:23 -0800 (PST)
Subject: Re: [PATCH 08/12] powerpc/ftrace: Rework ftrace_caller()
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
 <1456324115-21144-8-git-send-email-mpe@ellerman.id.au>
Cc: duwe@lst.de, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56CE5387.5000608@gmail.com>
Date: Thu, 25 Feb 2016 12:06:15 +1100
MIME-Version: 1.0
In-Reply-To: <1456324115-21144-8-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 25/02/16 01:28, Michael Ellerman wrote:
> The main change is to just use paca->kernel_toc, rather than a branch to
> +4 and mflr etc. That makes the code simpler and should also perform
> better.
>
> There was also a sequence after ftrace_call() where we load from
> pt_regs->nip, move to LR, then a few instructions later load from LRSAVE
> and move to LR. Instead I think we want to put pt_regs->nip into CTR and
> branch to it later.
>
> We also rework some of the SPR loads to hopefully speed them up a bit.
> Also comment the asm much more, to hopefully make it clearer.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/entry_64.S | 94 ++++++++++++++++++++++++++++--------------
>  1 file changed, 62 insertions(+), 32 deletions(-)
>
> Squash.
>
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 149b659a25d9..f347f50024b8 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -1171,65 +1171,98 @@ _GLOBAL(ftrace_graph_stub)
>  	mtlr	r0
>  	addi	r1, r1, 112
>  #else
> +/*
> + *
> + * ftrace_caller() is the function that replaces _mcount() when ftrace is
> + * active.
> + *
> + * We arrive here after a function A calls function B, and we are the trace
> + * function for B. When we enter r1 points to A's stack frame, B has not yet
> + * had a chance to allocate one yet.
> + *
> + * Additionally r2 may point either to the TOC for A, or B, depending on
> + * whether B did a TOC setup sequence before calling us.
> + *
> + * On entry the LR points back to the _mcount() call site, and r0 holds the
> + * saved LR as it was on entry to B, ie. the original return address at the
> + * call site in A.
> + *
> + * Our job is to save the register state into a struct pt_regs (on the stack)
> + * and then arrange for the ftrace function to be called.
> + */
>  _GLOBAL(ftrace_caller)
> +	/* Save the original return address in A's stack frame */
>  	std	r0,LRSAVE(r1)
> -#if defined(_CALL_ELF) && _CALL_ELF == 2
> -	mflr	r0
> -	bl	2f
> -2:	mflr	r12
> -	mtlr	r0
> -	mr      r0,r2   /* save callee's TOC */
> -	addis	r2,r12,(.TOC.-ftrace_caller-12)@ha
> -	addi    r2,r2,(.TOC.-ftrace_caller-12)@l
> -#else
> -	mr	r0,r2
> -#endif
> -	ld	r12,LRSAVE(r1)	/* get caller's address */
>  
> +	/* Create our stack frame + pt_regs */
>  	stdu	r1,-SWITCH_FRAME_SIZE(r1)
>  
> -	std     r12, _LINK(r1)
> +	/* Save all gprs to pt_regs */
>  	SAVE_8GPRS(0,r1)
> -	std	r0, 24(r1)	/* save TOC */
>  	SAVE_8GPRS(8,r1)
>  	SAVE_8GPRS(16,r1)
>  	SAVE_8GPRS(24,r1)
>  
> +	/* Load special regs for save below */
> +	mfmsr   r8
> +	mfctr   r9
> +	mfxer   r10
> +	mfcr	r11
> +
> +	/* Get the _mcount() call site out of LR */
> +	mflr	r7
> +	/* Save it as pt_regs->nip & pt_regs->link */
> +	std     r7, _NIP(r1)
> +	std     r7, _LINK(r1)
> +
> +	/* Save callee's TOC in the ABI compliant location */
> +	std	r2, 24(r1)
> +	ld	r2,PACATOC(r13)	/* get kernel TOC in r2 */
> +
>  	addis	r3,r2,function_trace_op@toc@ha
>  	addi	r3,r3,function_trace_op@toc@l
>  	ld	r5,0(r3)
>  
> -	mflr    r3
> -	std     r3, _NIP(r1)
> -	std	r3, 16(r1)
> -	subi    r3, r3, MCOUNT_INSN_SIZE
> -	mfmsr   r4
> -	std     r4, _MSR(r1)
> -	mfctr   r4
> -	std     r4, _CTR(r1)
> -	mfxer   r4
> -	std     r4, _XER(r1)
> -	mr	r4, r12
> +	/* Calculate ip from nip-4 into r3 for call below */
> +	subi    r3, r7, MCOUNT_INSN_SIZE
> +
> +	/* Put the original return address in r4 as parent_ip */
> +	mr	r4, r0
> +
> +	/* Save special regs */
> +	std     r8, _MSR(r1)
> +	std     r9, _CTR(r1)
> +	std     r10, _XER(r1)
> +	std     r11, _CCR(r1)
> +
> +	/* Load &pt_regs in r6 for call below */
>  	addi    r6, r1 ,STACK_FRAME_OVERHEAD
>  
> +	/* ftrace_call(r3, r4, r5, r6) */
>  .globl ftrace_call
>  ftrace_call:
>  	bl	ftrace_stub
>  	nop
>  
> +	/* Load ctr with the possibly modified NIP */
>  	ld	r3, _NIP(r1)
> -	mtlr	r3
> +	mtctr	r3
>  
> +	/* Restore gprs */
>  	REST_8GPRS(0,r1)
>  	REST_8GPRS(8,r1)
>  	REST_8GPRS(16,r1)
>  	REST_8GPRS(24,r1)
>  
> +	/* Restore callee's TOC */
> +	ld	r2, 24(r1)
> +
> +	/* Pop our stack frame */
>  	addi r1, r1, SWITCH_FRAME_SIZE
>  
> -	ld	r12, LRSAVE(r1)  /* get caller's address */
> -	mtlr	r12
> -	mr	r2,r0		/* restore callee's TOC */
> +	/* Restore original LR for return to B */
> +	ld	r0, LRSAVE(r1)
> +	mtlr	r0
>  
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  	stdu	r1, -112(r1)
> @@ -1240,9 +1273,6 @@ _GLOBAL(ftrace_graph_stub)
>  	addi	r1, r1, 112
>  #endif
>  
> -	mflr	r0		/* move this LR to CTR */
> -	mtctr	r0
> -
>  	ld	r0,LRSAVE(r1)	/* restore callee's lr at _mcount site */
>  	mtlr	r0
>  	bctr			/* jump after _mcount site */

Reviewed-by: Balbir Singh <bsingharora@gmail.com>

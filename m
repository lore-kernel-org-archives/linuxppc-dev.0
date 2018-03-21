Return-Path: <SRS0=aJRt=GL=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405ryD0MTkzF1pv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 00:59:15 +1100 (AEDT)
Date: Wed, 21 Mar 2018 09:59:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras
 <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org, Anton Blanchard
 <anton@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 sathnaga@linux.vnet.ibm.com
Subject: Re: [PATCH v2 5/5] powerpc64/ftrace: Implement support for
 ftrace_regs_caller()
Message-ID: <20180321095912.212e0b0d@gandalf.local.home>
In-Reply-To: <764a63e7418b05185434fe660814ce762c93c7d0.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
 <764a63e7418b05185434fe660814ce762c93c7d0.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 21 Mar 2018 16:13:22 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

>  int module_finalize_ftrace(struct module *mod, const Elf_Shdr *sechdrs)
>  {
>  	mod->arch.toc = my_r2(sechdrs, mod);
> -	mod->arch.tramp = create_ftrace_stub(sechdrs, mod);
> +	mod->arch.tramp = create_ftrace_stub(sechdrs, mod,
> +					(unsigned long)ftrace_caller);
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +	mod->arch.tramp_regs = create_ftrace_stub(sechdrs, mod,
> +					(unsigned long)ftrace_regs_caller);

So you only reference ftrace_regs_caller if you have
DYNAMIC_FTRACE_WITH_REGS defined?

> +	if (!mod->arch.tramp_regs)
> +		return -ENOENT;
> +#endif
>  
>  	if (!mod->arch.tramp)
>  		return -ENOENT;


> diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
> index 8f2380304ef1..7b81db85f76e 100644
> --- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
> +++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
> @@ -20,8 +20,8 @@
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  /*
>   *
> - * ftrace_caller() is the function that replaces _mcount() when ftrace is
> - * active.
> + * ftrace_caller()/ftrace_regs_caller() is the function that replaces _mcount()
> + * when ftrace is active.
>   *
>   * We arrive here after a function A calls function B, and we are the trace
>   * function for B. When we enter r1 points to A's stack frame, B has not yet
> @@ -37,7 +37,7 @@
>   * Our job is to save the register state into a struct pt_regs (on the stack)
>   * and then arrange for the ftrace function to be called.
>   */

Perhaps you want to add:

#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS

here.

> -_GLOBAL(ftrace_caller)
> +_GLOBAL(ftrace_regs_caller)
>  	/* Save the original return address in A's stack frame */
>  	std	r0,LRSAVE(r1)
>  
> @@ -100,8 +100,8 @@ _GLOBAL(ftrace_caller)
>  	addi    r6, r1 ,STACK_FRAME_OVERHEAD
>  
>  	/* ftrace_call(r3, r4, r5, r6) */
> -.globl ftrace_call
> -ftrace_call:
> +.globl ftrace_regs_call
> +ftrace_regs_call:
>  	bl	ftrace_stub
>  	nop
>  
> @@ -162,6 +162,7 @@ ftrace_call:
>  	bne-	livepatch_handler
>  #endif
>  
> +ftrace_caller_common:
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  .globl ftrace_graph_call
>  ftrace_graph_call:
> @@ -182,6 +183,66 @@ ftrace_no_trace:
>  	mtlr	r0
>  	bctr
>  
> +_GLOBAL(ftrace_caller)
> +	/* Save the original return address in A's stack frame */
> +	std	r0, LRSAVE(r1)
> +
> +	/* Create our stack frame + pt_regs */
> +	stdu	r1, -SWITCH_FRAME_SIZE(r1)
> +
> +	/* Save all gprs to pt_regs */
> +	SAVE_8GPRS(3, r1)
> +
> +	lbz	r3, PACA_FTRACE_DISABLED(r13)
> +	cmpdi	r3, 0
> +	beq	ftrace_no_trace

Of course you would need to keep the ftrace_no_trace part out of the
#if block then.

-- Steve

> +
> +	/* Get the _mcount() call site out of LR */
> +	mflr	r7
> +	std     r7, _NIP(r1)
> +
> +	/* Save callee's TOC in the ABI compliant location */
> +	std	r2, 24(r1)
> +	ld	r2, PACATOC(r13)	/* get kernel TOC in r2 */
> +
> +	addis	r3, r2, function_trace_op@toc@ha
> +	addi	r3, r3, function_trace_op@toc@l
> +	ld	r5, 0(r3)
> +
> +	/* Calculate ip from nip-4 into r3 for call below */
> +	subi    r3, r7, MCOUNT_INSN_SIZE
> +
> +	/* Put the original return address in r4 as parent_ip */
> +	mr	r4, r0
> +
> +	/* Set pt_regs to NULL */
> +	li	r6, 0
> +
> +	/* ftrace_call(r3, r4, r5, r6) */
> +.globl ftrace_call
> +ftrace_call:
> +	bl	ftrace_stub
> +	nop
> +
> +	ld	r3, _NIP(r1)
> +	mtctr	r3
> +
> +	/* Restore gprs */
> +	REST_8GPRS(3,r1)
> +
> +	/* Restore callee's TOC */
> +	ld	r2, 24(r1)
> +
> +	/* Pop our stack frame */
> +	addi	r1, r1, SWITCH_FRAME_SIZE
> +
> +	/* Reload original LR */
> +	ld	r0, LRSAVE(r1)
> +	mtlr	r0
> +
> +	/* Handle function_graph or go back */
> +	b	ftrace_caller_common
> +
>  #ifdef CONFIG_LIVEPATCH
>  	/*
>  	 * This function runs in the mcount context, between two functions. As

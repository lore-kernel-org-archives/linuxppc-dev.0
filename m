Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk6VS5tmgzDqN8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 23:59:28 +1000 (AEST)
Date: Thu, 8 Jun 2017 22:59:23 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 3/4] powerpc/kprobes_on_ftrace: Skip
 livepatch_handler() for jprobes
Message-Id: <20170608225923.9f2c4e0c3602169d40304178@kernel.org>
In-Reply-To: <354168131ffd13a9109172f616255fe1e0983387.1496309487.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1496309487.git.naveen.n.rao@linux.vnet.ibm.com>
 <354168131ffd13a9109172f616255fe1e0983387.1496309487.git.naveen.n.rao@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu,  1 Jun 2017 16:18:17 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> ftrace_caller() depends on a modified regs->nip to detect if a certain
> function has been livepatched. However, with KPROBES_ON_FTRACE, it is
> possible for regs->nip to have been modified by the kprobes pre_handler
> (jprobes, for instance). In this case, we do not want to invoke the
> livepatch_handler so as not to consume the livepatch stack.
> 
> To distinguish between the two (kprobes and livepatch), we check if
> there is an active kprobe on the current function. If there is, then we
> know for sure that it must have modified the NIP as we don't support
> livepatching a kprobe'd function. In this case, we simply skip the
> livepatch_handler and branch to the new NIP. Otherwise, the
> livepatch_handler is invoked.

OK, this logic seems good to me, but I weould like to leave it for
PPC64 maintainer too.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!
> 
> Fixes: ead514d5fb30a ("powerpc/kprobes: Add support for
> KPROBES_ON_FTRACE")
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> v2: Changed to use current_kprobe->addr to determine jprobe vs.
> livepatch.
> 
>  arch/powerpc/include/asm/kprobes.h             |  1 +
>  arch/powerpc/kernel/kprobes.c                  |  6 +++++
>  arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 32 ++++++++++++++++++++++----
>  3 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
> index a83821f33ea3..8814a7249ceb 100644
> --- a/arch/powerpc/include/asm/kprobes.h
> +++ b/arch/powerpc/include/asm/kprobes.h
> @@ -103,6 +103,7 @@ extern int kprobe_exceptions_notify(struct notifier_block *self,
>  extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
>  extern int kprobe_handler(struct pt_regs *regs);
>  extern int kprobe_post_handler(struct pt_regs *regs);
> +extern int is_current_kprobe_addr(unsigned long addr);
>  #ifdef CONFIG_KPROBES_ON_FTRACE
>  extern int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
>  			   struct kprobe_ctlblk *kcb);
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index 0554d6e66194..ec9d94c82fbd 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -43,6 +43,12 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>  
>  struct kretprobe_blackpoint kretprobe_blacklist[] = {{NULL, NULL}};
>  
> +int is_current_kprobe_addr(unsigned long addr)
> +{
> +	struct kprobe *p = kprobe_running();
> +	return (p && (unsigned long)p->addr == addr) ? 1 : 0;
> +}
> +
>  bool arch_within_kprobe_blacklist(unsigned long addr)
>  {
>  	return  (addr >= (unsigned long)__kprobes_text_start &&
> diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
> index fa0921410fa4..e6837e85ec28 100644
> --- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
> +++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
> @@ -99,13 +99,37 @@ ftrace_call:
>  	bl	ftrace_stub
>  	nop
>  
> -	/* Load ctr with the possibly modified NIP */
> -	ld	r3, _NIP(r1)
> -	mtctr	r3
> +	/* Load the possibly modified NIP */
> +	ld	r15, _NIP(r1)
> +
>  #ifdef CONFIG_LIVEPATCH
> -	cmpd	r14,r3		/* has NIP been altered? */
> +	cmpd	r14, r15		/* has NIP been altered? */
> +#endif
> +
> +#if defined(CONFIG_LIVEPATCH) && defined(CONFIG_KPROBES_ON_FTRACE)
> +	beq	1f
> +
> +	/* Check if there is an active kprobe on us */
> +	subi	r3, r14, 4
> +	bl	is_current_kprobe_addr
> +	nop
> +
> +	/*
> +	 * If r3 == 1, then this is a kprobe/jprobe.
> +	 * else, this is livepatched function.
> +	 *
> +	 * The subsequent conditional branch for livepatch_handler
> +	 * will use the result of this compare. For kprobe/jprobe,
> +	 * we just need to branch to the new NIP, so nothing special
> +	 * is needed.
> +	 */
> +	cmpdi	r3, 1
> +1:
>  #endif
>  
> +	/* Load CTR with the possibly modified NIP */
> +	mtctr	r15
> +
>  	/* Restore gprs */
>  	REST_GPR(0,r1)
>  	REST_10GPRS(2,r1)
> -- 
> 2.12.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

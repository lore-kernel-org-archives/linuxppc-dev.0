Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wSGkT2bd1zDqPj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 11:21:53 +1000 (AEST)
Date: Wed, 17 May 2017 10:21:44 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/jprobes: Validate break handler invocation
 as being due to a jprobe_return()
Message-Id: <20170517102144.2c1ac103bbfda22589fe40de@kernel.org>
In-Reply-To: <d6b0691226623b3499d43dff1e31971ea46df9f9.1494871248.git.naveen.n.rao@linux.vnet.ibm.com>
References: <0572aa31dd57bef6f158ac97d0b666a0c545356a.1494871248.git.naveen.n.rao@linux.vnet.ibm.com>
 <d6b0691226623b3499d43dff1e31971ea46df9f9.1494871248.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Mon, 15 May 2017 23:35:04 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Fix a circa 2005 FIXME by implementing a check to ensure that we
> actually got into the jprobe break handler() due to the trap in
> jprobe_return().
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/kprobes.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index 19b053475758..1ebeb8c482db 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -627,25 +627,23 @@ NOKPROBE_SYMBOL(setjmp_pre_handler);
>  
>  void __used jprobe_return(void)
>  {
> -	asm volatile("trap" ::: "memory");
> +	asm volatile("jprobe_return_trap:\n"
> +		     "trap\n"
> +		     ::: "memory");
>  }
>  NOKPROBE_SYMBOL(jprobe_return);
>  
> -static void __used jprobe_return_end(void)
> -{
> -}
> -NOKPROBE_SYMBOL(jprobe_return_end);
> -
>  int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
>  {
>  	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>  	unsigned long sp;
>  
> -	/*
> -	 * FIXME - we should ideally be validating that we got here 'cos
> -	 * of the "trap" in jprobe_return() above, before restoring the
> -	 * saved regs...
> -	 */
> +	if (regs->nip != ppc_kallsyms_lookup_name("jprobe_return_trap")) {
> +		WARN(1, "longjmp_break_handler NIP (0x%lx) does not match jprobe_return_trap (0x%lx)\n",
> +				regs->nip, ppc_kallsyms_lookup_name("jprobe_return_trap"));
> +		return 0;

If you don't handle this break, you shouldn't warn it, because
program_check_exception() will continue to find how to handle it
by notify_die(). IOW, please return silently, or just add a
debug message.

Thank you,

> +	}
> +
>  	memcpy(regs, &kcb->jprobe_saved_regs, sizeof(struct pt_regs));
>  	sp = kernel_stack_pointer(regs);
>  	memcpy((void *)sp, &kcb->jprobes_stack, MIN_STACK_SIZE(sp));
> -- 
> 2.12.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

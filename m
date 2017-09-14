Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xt0541sYjzDrVt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 10:38:32 +1000 (AEST)
Date: Wed, 13 Sep 2017 17:38:29 -0700
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/5] powerpc/jprobes: Validate break handler invocation
 as being due to a jprobe_return()
Message-Id: <20170913173829.8845e0ada53fbd5338fa196f@kernel.org>
In-Reply-To: <58db21d55022d7fb95468f3b8fd3dbffec36a113.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
References: <2bc413d679c563d3ee338c318066777318577ab2.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
 <58db21d55022d7fb95468f3b8fd3dbffec36a113.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Thu, 14 Sep 2017 02:50:36 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Fix a circa 2005 FIXME by implementing a check to ensure that we
> actually got into the jprobe break handler() due to the trap in
> jprobe_return().
> 

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> This is v2 of the patch posted previously (*) to change the WARN() to a 
> pr_debug() as suggested by Masami.
> (*) https://patchwork.ozlabs.org/patch/762670/
> 
> - Naveen
> 
>  arch/powerpc/kernel/kprobes.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index db40b13fd3d1..5b26d5202273 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -648,24 +648,22 @@ NOKPROBE_SYMBOL(setjmp_pre_handler);
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
>  
> -	/*
> -	 * FIXME - we should ideally be validating that we got here 'cos
> -	 * of the "trap" in jprobe_return() above, before restoring the
> -	 * saved regs...
> -	 */
> +	if (regs->nip != ppc_kallsyms_lookup_name("jprobe_return_trap")) {
> +		pr_debug("longjmp_break_handler NIP (0x%lx) does not match jprobe_return_trap (0x%lx)\n",
> +				regs->nip, ppc_kallsyms_lookup_name("jprobe_return_trap"));
> +		return 0;
> +	}
> +
>  	memcpy(regs, &kcb->jprobe_saved_regs, sizeof(struct pt_regs));
>  	/* It's OK to start function graph tracing again */
>  	unpause_graph_tracing();
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

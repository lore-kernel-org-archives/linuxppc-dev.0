Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7Pn00Z5FzDq9B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 00:40:36 +1000 (AEST)
Date: Wed, 19 Apr 2017 23:40:25 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] powerpc: kprobes: factor out code to emulate
 instruction into a helper
Message-Id: <20170419234025.e0bc1137a87e2ebc2b7790dd@kernel.org>
In-Reply-To: <4fbd6652c2dd8944448fd4d84efa92f20a016d3b.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <4fbd6652c2dd8944448fd4d84efa92f20a016d3b.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Wed, 19 Apr 2017 18:21:04 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

Factor out code to emulate instruction into a try_to_emulate()
helper function. This makes ...

> No functional changes.

Thanks,

> 
> Acked-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/kprobes.c | 52 ++++++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index d743bacefa8c..46e8c1e03ce4 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -206,6 +206,35 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
>  	regs->link = (unsigned long)kretprobe_trampoline;
>  }
>  
> +int __kprobes try_to_emulate(struct kprobe *p, struct pt_regs *regs)
> +{
> +	int ret;
> +	unsigned int insn = *p->ainsn.insn;
> +
> +	/* regs->nip is also adjusted if emulate_step returns 1 */
> +	ret = emulate_step(regs, insn);
> +	if (ret > 0) {
> +		/*
> +		 * Once this instruction has been boosted
> +		 * successfully, set the boostable flag
> +		 */
> +		if (unlikely(p->ainsn.boostable == 0))
> +			p->ainsn.boostable = 1;
> +	} else if (ret < 0) {
> +		/*
> +		 * We don't allow kprobes on mtmsr(d)/rfi(d), etc.
> +		 * So, we should never get here... but, its still
> +		 * good to catch them, just in case...
> +		 */
> +		printk("Can't step on instruction %x\n", insn);
> +		BUG();
> +	} else if (ret == 0)
> +		/* This instruction can't be boosted */
> +		p->ainsn.boostable = -1;
> +
> +	return ret;
> +}
> +
>  int __kprobes kprobe_handler(struct pt_regs *regs)
>  {
>  	struct kprobe *p;
> @@ -301,18 +330,9 @@ int __kprobes kprobe_handler(struct pt_regs *regs)
>  
>  ss_probe:
>  	if (p->ainsn.boostable >= 0) {
> -		unsigned int insn = *p->ainsn.insn;
> +		ret = try_to_emulate(p, regs);
>  
> -		/* regs->nip is also adjusted if emulate_step returns 1 */
> -		ret = emulate_step(regs, insn);
>  		if (ret > 0) {
> -			/*
> -			 * Once this instruction has been boosted
> -			 * successfully, set the boostable flag
> -			 */
> -			if (unlikely(p->ainsn.boostable == 0))
> -				p->ainsn.boostable = 1;
> -
>  			if (p->post_handler)
>  				p->post_handler(p, regs, 0);
>  
> @@ -320,17 +340,7 @@ int __kprobes kprobe_handler(struct pt_regs *regs)
>  			reset_current_kprobe();
>  			preempt_enable_no_resched();
>  			return 1;
> -		} else if (ret < 0) {
> -			/*
> -			 * We don't allow kprobes on mtmsr(d)/rfi(d), etc.
> -			 * So, we should never get here... but, its still
> -			 * good to catch them, just in case...
> -			 */
> -			printk("Can't step on instruction %x\n", insn);
> -			BUG();
> -		} else if (ret == 0)
> -			/* This instruction can't be boosted */
> -			p->ainsn.boostable = -1;
> +		}
>  	}
>  	prepare_singlestep(p, regs);
>  	kcb->kprobe_status = KPROBE_HIT_SS;
> -- 
> 2.12.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

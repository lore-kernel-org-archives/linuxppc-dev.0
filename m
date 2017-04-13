Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3Scz3k1szDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 14:34:59 +1000 (AEST)
Date: Thu, 13 Apr 2017 13:34:48 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Ingo
 Molnar <mingo@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] powerpc: kprobes: factor out code to emulate
 instruction into a helper
Message-Id: <20170413133448.d13e8489238b4dc8bee9471c@kernel.org>
In-Reply-To: <6058a453bd013d5fad41201c01915889cccb0ac6.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
 <6058a453bd013d5fad41201c01915889cccb0ac6.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Wed, 12 Apr 2017 16:28:27 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> This helper will be used in a subsequent patch to emulate instructions
> on re-entering the kprobe handler. No functional change.

In this case, please merge this patch into the next patch which
actually uses the factored out function unless that changes
too much.

Thank you,

> 
> Acked-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/kprobes.c | 52 ++++++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index 0732a0291ace..8b48f7d046bd 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -207,6 +207,35 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
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
> @@ -302,18 +331,9 @@ int __kprobes kprobe_handler(struct pt_regs *regs)
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
> @@ -321,17 +341,7 @@ int __kprobes kprobe_handler(struct pt_regs *regs)
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

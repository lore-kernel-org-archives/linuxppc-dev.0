Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMDMs3hzgzDqfh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 13:18:49 +1100 (AEDT)
Date: Wed, 25 Oct 2017 11:18:44 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/4] powerpc/kprobes: Disable preemption before invoking
 probe handler for optprobes
Message-Id: <20171025111844.ec59221e18f43f7d7d56b283@kernel.org>
In-Reply-To: <2a4b854c7fc11db576e3b7ff6dcfda94c64d2842.1508776485.git.naveen.n.rao@linux.vnet.ibm.com>
References: <2a4b854c7fc11db576e3b7ff6dcfda94c64d2842.1508776485.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Mon, 23 Oct 2017 22:07:38 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Per Documentation/kprobes.txt, probe handlers need to be invoked with
> preemption disabled. Update optimized_callback() to do so. Also move
> get_kprobe_ctlblk() invocation post preemption disable, since it
> accesses pre-cpu data.
> 
> This was not an issue so far since optprobes wasn't selected if
> CONFIG_PREEMPT was enabled. Commit a30b85df7d599f ("kprobes: Use
> synchronize_rcu_tasks() for optprobe with CONFIG_PREEMPT=y") changes
> this.

Actually, if you local_irq_save(), it also disables preempt. So unless you
enables irqs, it should be safe.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,


> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/optprobes.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
> index 91e037ab20a1..60ba7f1370a8 100644
> --- a/arch/powerpc/kernel/optprobes.c
> +++ b/arch/powerpc/kernel/optprobes.c
> @@ -115,7 +115,6 @@ static unsigned long can_optimize(struct kprobe *p)
>  static void optimized_callback(struct optimized_kprobe *op,
>  			       struct pt_regs *regs)
>  {
> -	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>  	unsigned long flags;
>  
>  	/* This is possible if op is under delayed unoptimizing */
> @@ -124,13 +123,14 @@ static void optimized_callback(struct optimized_kprobe *op,
>  
>  	local_irq_save(flags);
>  	hard_irq_disable();
> +	preempt_disable();
>  
>  	if (kprobe_running()) {
>  		kprobes_inc_nmissed_count(&op->kp);
>  	} else {
>  		__this_cpu_write(current_kprobe, &op->kp);
>  		regs->nip = (unsigned long)op->kp.addr;
> -		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> +		get_kprobe_ctlblk()->kprobe_status = KPROBE_HIT_ACTIVE;
>  		opt_pre_handler(&op->kp, regs);
>  		__this_cpu_write(current_kprobe, NULL);
>  	}
> @@ -140,6 +140,7 @@ static void optimized_callback(struct optimized_kprobe *op,
>  	 * local_irq_restore() will re-enable interrupts,
>  	 * if they were hard disabled.
>  	 */
> +	preempt_enable_no_resched();
>  	local_irq_restore(flags);
>  }
>  NOKPROBE_SYMBOL(optimized_callback);
> -- 
> 2.14.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

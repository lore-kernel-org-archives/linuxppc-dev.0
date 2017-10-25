Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMDNs03S7zDqtL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 13:19:40 +1100 (AEDT)
Date: Wed, 25 Oct 2017 11:19:36 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/4] powerpc/kprobes: Do not disable interrupts for
 optprobes and kprobes_on_ftrace
Message-Id: <20171025111936.852065923d39aeda96f9c88e@kernel.org>
In-Reply-To: <60fe689be1e3251c001a6d4303fd808a3a760711.1508776485.git.naveen.n.rao@linux.vnet.ibm.com>
References: <2a4b854c7fc11db576e3b7ff6dcfda94c64d2842.1508776485.git.naveen.n.rao@linux.vnet.ibm.com>
 <60fe689be1e3251c001a6d4303fd808a3a760711.1508776485.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Mon, 23 Oct 2017 22:07:39 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Per Documentation/kprobes.txt, we don't necessarily need to disable
> interrupts before invoking the kprobe handlers. Masami submitted
> similar changes for x86 via commit a19b2e3d783964 ("kprobes/x86: Remove
> IRQ disabling from ftrace-based/optimized kprobes"). Do the same for
> powerpc.

Yes, and this requires to make preempt disable :)

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/kprobes-ftrace.c | 10 ++--------
>  arch/powerpc/kernel/optprobes.c      | 10 ----------
>  2 files changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
> index 4b1f34f685b1..7a1f99f1b47f 100644
> --- a/arch/powerpc/kernel/kprobes-ftrace.c
> +++ b/arch/powerpc/kernel/kprobes-ftrace.c
> @@ -75,11 +75,7 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
>  {
>  	struct kprobe *p;
>  	struct kprobe_ctlblk *kcb;
> -	unsigned long flags;
>  
> -	/* Disable irq for emulating a breakpoint and avoiding preempt */
> -	local_irq_save(flags);
> -	hard_irq_disable();
>  	preempt_disable();
>  
>  	p = get_kprobe((kprobe_opcode_t *)nip);
> @@ -105,16 +101,14 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
>  		else {
>  			/*
>  			 * If pre_handler returns !0, it sets regs->nip and
> -			 * resets current kprobe. In this case, we still need
> -			 * to restore irq, but not preemption.
> +			 * resets current kprobe. In this case, we should not
> +			 * re-enable preemption.
>  			 */
> -			local_irq_restore(flags);
>  			return;
>  		}
>  	}
>  end:
>  	preempt_enable_no_resched();
> -	local_irq_restore(flags);
>  }
>  NOKPROBE_SYMBOL(kprobe_ftrace_handler);
>  
> diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
> index 60ba7f1370a8..8237884ca389 100644
> --- a/arch/powerpc/kernel/optprobes.c
> +++ b/arch/powerpc/kernel/optprobes.c
> @@ -115,14 +115,10 @@ static unsigned long can_optimize(struct kprobe *p)
>  static void optimized_callback(struct optimized_kprobe *op,
>  			       struct pt_regs *regs)
>  {
> -	unsigned long flags;
> -
>  	/* This is possible if op is under delayed unoptimizing */
>  	if (kprobe_disabled(&op->kp))
>  		return;
>  
> -	local_irq_save(flags);
> -	hard_irq_disable();
>  	preempt_disable();
>  
>  	if (kprobe_running()) {
> @@ -135,13 +131,7 @@ static void optimized_callback(struct optimized_kprobe *op,
>  		__this_cpu_write(current_kprobe, NULL);
>  	}
>  
> -	/*
> -	 * No need for an explicit __hard_irq_enable() here.
> -	 * local_irq_restore() will re-enable interrupts,
> -	 * if they were hard disabled.
> -	 */
>  	preempt_enable_no_resched();
> -	local_irq_restore(flags);
>  }
>  NOKPROBE_SYMBOL(optimized_callback);
>  
> -- 
> 2.14.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

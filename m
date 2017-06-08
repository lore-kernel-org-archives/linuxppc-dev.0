Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk68h6sY1zDqN2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 23:44:04 +1000 (AEST)
Date: Thu, 8 Jun 2017 22:43:54 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/4] powerpc/kprobes: Pause function_graph tracing
 during jprobes handling
Message-Id: <20170608224354.495446a0cf6144b67816aa46@kernel.org>
In-Reply-To: <309db8dc9b7d60b1264d277bd815403fbd2d6545.1496309487.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1496309487.git.naveen.n.rao@linux.vnet.ibm.com>
 <309db8dc9b7d60b1264d277bd815403fbd2d6545.1496309487.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Thu,  1 Jun 2017 16:18:15 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> This fixes a crash when function_graph and jprobes are used together.
> This is essentially commit 237d28db036e ("ftrace/jprobes/x86: Fix
> conflict between jprobes and function graph tracing"), but for powerpc.
> 
> Jprobes breaks function_graph tracing since the jprobe hook needs to use
> jprobe_return(), which never returns back to the hook, but instead to
> the original jprobe'd function. The solution is to momentarily pause
> function_graph tracing before invoking the jprobe hook and re-enable it
> when returning back to the original jprobe'd function.
> 
> Fixes: 6794c78243bfd ("powerpc64: port of the function graph tracer")
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> ---
> v2: No changes since v1.
> 
>  arch/powerpc/kernel/kprobes.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index e1fb95385a9e..0554d6e66194 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -610,6 +610,15 @@ int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
>  	regs->gpr[2] = (unsigned long)(((func_descr_t *)jp->entry)->toc);
>  #endif
>  
> +	/*
> +	 * jprobes use jprobe_return() which skips the normal return
> +	 * path of the function, and this messes up the accounting of the
> +	 * function graph tracer.
> +	 *
> +	 * Pause function graph tracing while performing the jprobe function.
> +	 */
> +	pause_graph_tracing();
> +
>  	return 1;
>  }
>  NOKPROBE_SYMBOL(setjmp_pre_handler);
> @@ -635,6 +644,8 @@ int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
>  	 * saved regs...
>  	 */
>  	memcpy(regs, &kcb->jprobe_saved_regs, sizeof(struct pt_regs));
> +	/* It's OK to start function graph tracing again */
> +	unpause_graph_tracing();
>  	preempt_enable_no_resched();
>  	return 1;
>  }
> -- 
> 2.12.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

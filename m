Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 338061A1049
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2015 11:20:23 +1100 (AEDT)
Message-ID: <1449620422.6028.6.camel@ellerman.id.au>
Subject: Re: [RFC][PATCH] ppc: Implement save_stack_trace_regs()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,  linuxppc-dev@lists.ozlabs.org
Cc: chuhu@redhat.com
Date: Wed, 09 Dec 2015 11:20:22 +1100
In-Reply-To: <20151208135056.718b7668@gandalf.local.home>
References: <20151208135056.718b7668@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-12-08 at 13:50 -0500, Steven Rostedt wrote:

> It has come to my attention that kprobe event stack tracing does not
> work on powerpc.

Yep looks like you're right. I didn't realise it was separate from the regular
stack trace stuff.

> diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
> index ea43a347a104..0142c86801ba 100644
> --- a/arch/powerpc/kernel/stacktrace.c
> +++ b/arch/powerpc/kernel/stacktrace.c
> @@ -61,3 +61,10 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
>  	save_context_stack(trace, tsk->thread.ksp, tsk, 0);
>  }
>  EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
> +
> +void
> +save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
> +{
> +	save_context_stack(trace, regs->gpr[PT_R1], current, 0);

In the kernel we would normally use just '1' here rather than 'PT_R1', but it's
not a huge deal.

Should I take this via powerpc or do you want it to go in via tracing?

cheers

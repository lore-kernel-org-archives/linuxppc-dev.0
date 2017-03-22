Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vp6Ht3dthzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 22:03:54 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix /proc/self/stack
In-Reply-To: <20170317155921.24369-1-cascardo@canonical.com>
References: <20170317155921.24369-1-cascardo@canonical.com>
Date: Wed, 22 Mar 2017 22:03:53 +1100
Message-ID: <87inn1d146.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thadeu Lima de Souza Cascardo <cascardo@canonical.com> writes:

> For the current task, the kernel stack would only tell the last time the
> process was rescheduled, if ever. Use the current stack pointer for the
> current task.

You say "fix" in the subject, but is it a bug, or just an enhancement?

> This is also consistent with some other architectures.

Such as .. arm64 and x86 (though it's buried in the unwind code).

> diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
> index 6671195..2446066 100644
> --- a/arch/powerpc/kernel/stacktrace.c
> +++ b/arch/powerpc/kernel/stacktrace.c
> @@ -59,7 +59,12 @@ EXPORT_SYMBOL_GPL(save_stack_trace);
>  
>  void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
>  {
> -	save_context_stack(trace, tsk->thread.ksp, tsk, 0);
> +	unsigned long sp = tsk->thread.ksp;
> +
> +	if (tsk == current)
> +		sp = current_stack_pointer();
	else
		sp = tsk->thread.ksp;

Would be clearer IMHO.

> +
> +	save_context_stack(trace, sp, tsk, 0);
>  }
>  EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
>  
> -- 
> 2.9.3


cheers

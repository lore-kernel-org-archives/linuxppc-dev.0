Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 864E91A01B0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 17:14:46 +1000 (EST)
In-Reply-To: <1411621545-19310-1-git-send-email-anton@samba.org>
To: Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
 paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc: Print instruction when logging unhandled exceptions
Message-Id: <20141002071446.66E37140183@ozlabs.org>
Date: Thu,  2 Oct 2014 17:14:46 +1000 (EST)
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-25-09 at 05:05:45 UTC, Anton Blanchard wrote:
> It is often useful to see the instruction that caused an unhandled
> exception.
> 
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 0dc43f9..27e30c8 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -252,9 +252,18 @@ void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
>  	}
>  
>  	if (show_unhandled_signals && unhandled_signal(current, signr)) {
> +		u32 __user *nia = (u32 __user *)regs->nip;
> +		u32 insn = 0;
> +
> +		pagefault_disable();
> +		if (!access_ok(VERIFY_READ, nia, sizeof(*nia)) ||
> +		    __get_user_inatomic(insn, nia))
> +			insn = 0xffffffffUL;
> +		pagefault_enable();

Can you add a comment explaining that interesting construct?

Looks like we do something similar in the perf callchain code, though without
the access_ok() check?

cheers

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 976A61A02E4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 18:20:16 +1000 (EST)
Message-ID: <1403079615.32307.8.camel@concordia>
Subject: Re: [PATCH] powerpc: Reduce scariness of interrupt frames in stack
 traces
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>
Date: Wed, 18 Jun 2014 18:20:15 +1000
In-Reply-To: <20140612065308.GB16578@drongo>
References: <20140612065308.GB16578@drongo>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-06-12 at 16:53 +1000, Paul Mackerras wrote:
> Some people see things like "Exception: 501" in stack traces in dmesg
> and assume that means that something has gone badly wrong, when in
> fact "Exception: 501" just means a device interrupt was taken.
> This changes "Exception" to "interrupt" to make it clearer that we
> are just recording the fact of a change in control flow rather than
> some error condition.

Surely this would be preferable:

> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 31d0215..aa103dc 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1577,7 +1577,7 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
>  			struct pt_regs *regs = (struct pt_regs *)
>  				(sp + STACK_FRAME_OVERHEAD);
>  			lr = regs->link;
> -			printk("--- Exception: %lx at %pS\n    LR = %pS\n",
> +			printk("--- 👋🌷🌹🌻🌼🐷🐰🐱💜: %lx at %pS\n    LR = %pS\n",
>  			       regs->trap, (void *)regs->nip, (void *)lr);
>  			firstframe = 1;
>  		}

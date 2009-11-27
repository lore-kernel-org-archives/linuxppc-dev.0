Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8E6201007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 22:02:03 +1100 (EST)
Subject: Re: [PATCH] fix PPC floating point debug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefani Seibold <stefani@seibold.net>
In-Reply-To: <1259312340.9648.6.camel@wall-e>
References: <1259312340.9648.6.camel@wall-e>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 27 Nov 2009 22:01:56 +1100
Message-ID: <1259319716.2076.3.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-11-27 at 09:59 +0100, Stefani Seibold wrote:
> The PPC architecture is unable to debug applications using hardware
> floating point, because it would not save the floating point registers.
> 
> After returning from the debugger, the contents of register was
> modified. This patch fix this bug.

I'm not sure what problem you are trying to fix... debugging FP apps
works just fine afaik. You don't need to flush the FP state into the
thread when delivering the SIGTRAP. If you have a signal handler, that
will be done for you by the signal code before laying out the signal
frame. If you are using ptrace, you should be using the appropriate
ptrace calls to retrieve the FP state and they should do the right thing
to.

Do you have a precise example that doesn't work and which is fixed by
your patch ?

Cheers,
Ben.

> Signed-off-by: Stefani Seibold <stefani@seibold.net>
> ---
>  traps.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> --- linux-2.6.32-rc5/arch/powerpc/kernel/traps.c.orig	2009-11-27 09:47:37.989943124 +0100
> +++ linux-2.6.32-rc5/arch/powerpc/kernel/traps.c	2009-11-27 09:47:41.088330825 +0100
> @@ -559,6 +559,8 @@ void instruction_breakpoint_exception(st
>  		return;
>  	if (debugger_iabr_match(regs))
>  		return;
> +	if (regs->msr & MSR_FP)
> +		giveup_fpu(current);
>  	_exception(SIGTRAP, regs, TRAP_BRKPT, regs->nip);
>  }
>  
> @@ -577,6 +579,8 @@ void __kprobes single_step_exception(str
>  	if (debugger_sstep(regs))
>  		return;
>  
> +	if (regs->msr & MSR_FP)
> +		giveup_fpu(current);
>  	_exception(SIGTRAP, regs, TRAP_TRACE, regs->nip);
>  }
>  
> @@ -834,6 +838,8 @@ void __kprobes program_check_exception(s
>  			regs->nip += 4;
>  			return;
>  		}
> +		if (regs->msr & MSR_FP)
> +			giveup_fpu(current);
>  		_exception(SIGTRAP, regs, TRAP_BRKPT, regs->nip);
>  		return;
>  	}
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

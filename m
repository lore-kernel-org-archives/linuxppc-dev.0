Return-Path: <mikey@neuling.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 66065DDE28
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Mar 2009 10:58:00 +1100 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Fix ptrace compat wrapper for fpu register access 
In-reply-to: <m2k568xlfg.fsf@igel.home> 
References: <m2k568xlfg.fsf@igel.home>
Date: Mon, 30 Mar 2009 10:57:59 +1100
Message-ID: <13580.1238371079@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The ptrace compat wrapper mishandles access to the fpu registers.  The
> PTRACE_PEEKUSR and PTRACE_POKEUSR requests miscalculate the index into
> the fpr array due to the broken FPINDEX macro.  The
> PPC_PTRACE_PEEKUSR_3264 request needs to use the same formula that the
> native ptrace interface uses when operating on the register number (as
> opposed to the 4-byte offset).  The PPC_PTRACE_POKEUSR_3264 request
> didn't take TS_FPRWIDTH into account.
> 
> This was tested with the gdb testsuite on a G5.

So if you're looking fixing 32 bit apps ptracing 64 bit apps, does that
mean we can get a single 32 bit GDB that'll ptrace both 64 and 32 bit
apps?

I'd been looking for a ptrace test suite... thanks!

> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> 
> ---
> diff --git a/arch/powerpc/kernel/ptrace32.c b/arch/powerpc/kernel/ptrace32.c
> index 197d49c..f992eaf 100644
> --- a/arch/powerpc/kernel/ptrace32.c
> +++ b/arch/powerpc/kernel/ptrace32.c
> @@ -67,7 +67,7 @@ static long compat_ptrace_old(struct task_struct *child, lo
ng request,
>  /* Macros to workout the correct index for the FPR in the thread struct */
>  #define FPRNUMBER(i) (((i) - PT_FPR0) >> 1)
>  #define FPRHALF(i) (((i) - PT_FPR0) & 1)
> -#define FPRINDEX(i) TS_FPRWIDTH * FPRNUMBER(i) + FPRHALF(i)
> +#define FPRINDEX(i) TS_FPRWIDTH * FPRNUMBER(i) * 2 + FPRHALF(i)

ACK, I have the same patch here:
http://patchwork.ozlabs.org/patch/24940/

>  
>  long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
>  			compat_ulong_t caddr, compat_ulong_t cdata)
> @@ -169,7 +169,7 @@ long compat_arch_ptrace(struct task_struct *child, compat
_long_t request,
>  		if (numReg >= PT_FPR0) {
>  			flush_fp_to_thread(child);
>  			tmp = ((unsigned long int *)child->thread.fpr)
> -				[FPRINDEX(numReg)];
> +				[TS_FPRWIDTH * (numReg - PT_FPR0)];
>  		} else { /* register within PT_REGS struct */
>  			tmp = ptrace_get_reg(child, numReg);
>  		} 
> @@ -263,7 +263,8 @@ long compat_arch_ptrace(struct task_struct *child, compat
_long_t request,
>  			ret = ptrace_put_reg(child, numReg, freg);
>  		} else {
>  			flush_fp_to_thread(child);
> -			((unsigned int *)child->thread.regs)[index] = data;
> +			((unsigned int *)child->thread.regs)
> +				[FPRINDEX(index)] = data;

This index is into the ptregs structure not the fpr.  I'm not sure the
FPRINDEX macro is applicable here.

Mikey

>  			ret = 0;
>  		}
>  		break;
> 
> -- 
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
> "And now for something completely different."
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

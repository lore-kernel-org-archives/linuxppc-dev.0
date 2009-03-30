Return-Path: <mikey@neuling.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9244DDDDB6
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Mar 2009 20:52:31 +1100 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Fix ptrace compat wrapper for fpu register access 
In-reply-to: <m2vdpr2wv4.fsf@igel.home> 
References: <m2k568xlfg.fsf@igel.home> <13580.1238371079@neuling.org>
	<m2vdpr2wv4.fsf@igel.home>
Date: Mon, 30 Mar 2009 20:52:31 +1100
Message-ID: <29891.1238406751@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > So if you're looking fixing 32 bit apps ptracing 64 bit apps, does that
> > mean we can get a single 32 bit GDB that'll ptrace both 64 and 32 bit
> > apps?
> 
> Currently gdb only supports 32x64 debugging for the SPU.

Ok, thanks.

> >> @@ -263,7 +263,8 @@ long compat_arch_ptrace(struct task_struct *child, com
pat
> > _long_t request,
> >>  			ret = ptrace_put_reg(child, numReg, freg);
> >>  		} else {
> >>  			flush_fp_to_thread(child);
> >> -			((unsigned int *)child->thread.regs)[index] = data;
> >> +			((unsigned int *)child->thread.regs)
> >> +				[FPRINDEX(index)] = data;
> >
> > This index is into the ptregs structure not the fpr.  I'm not sure the
> > FPRINDEX macro is applicable here.
> 
> You're right, this hunk is bogus.  But indexing off thread.regs is
> totally bogus as well.  I think what was intented is this:
> 
> @@ -263,7 +263,9 @@ long compat_arch_ptrace(struct task_stru
>  			ret = ptrace_put_reg(child, numReg, freg);
>  		} else {
>  			flush_fp_to_thread(child);
> -			((unsigned int *)child->thread.regs)[index] = data;
> +			((unsigned int *)child->thread.fpr)
> +				[TS_FPRWIDTH * (numReg - PT_FPR0) * 2 +
> +				 index % 2] = data;

I think the indexing here should be the same as PEEKUSR_3264.  This
looks better but all this magic indexing makes me want to vomit.

I'd like to fix this stuff but I've been avoiding it since we don't have
a decent test case/suite to make sure it's not bust.

Mikey

>  			ret = 0;
>  		}
>  		break;
> 
> But gdb does not actually use PPC_PTRACE_POKEUSR_3264.
> 
> Andreas.
> 
> -- 
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
> "And now for something completely different."
> 

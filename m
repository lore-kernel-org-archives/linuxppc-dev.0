Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 501761A0191
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2015 21:05:19 +1100 (AEDT)
Message-ID: <1447668318.2191.10.camel@ellerman.id.au>
Subject: Re: [PATCH 3/5] powerpc/tm: Block signal return setting invalid MSR
 state
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>, benh@kernel.crashing.org
Cc: sam.bobroff@au1.ibm.com, linuxppc-dev@ozlabs.org, paulus@samba.org
Date: Mon, 16 Nov 2015 21:05:18 +1100
In-Reply-To: <1447390652-28355-3-git-send-email-mikey@neuling.org>
References: <1447390652-28355-1-git-send-email-mikey@neuling.org>
 <1447390652-28355-3-git-send-email-mikey@neuling.org>
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

On Fri, 2015-11-13 at 15:57 +1100, Michael Neuling wrote:

> Currently we allow both the MSR T and S bits to be set by userspace on
> a signal return.  Unfortunately this is a reserved configuration and
> will cause a TM Bad Thing exception if attempted (via rfid).
> 
> This patch checks for this case in both the 32 and 64bit signals code.
> If these are both set, we clear them and trigger the bad stack frame
> handling.
> 
> Found using a syscall fuzzer.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Is this fixes line right?

Fixes: 2b0a576d15e0 ("powerpc: Add new transactional memory state to the signal context")

Which went into v3.9.

In which case this:

> Cc: stable@vger.kernel.org

Should be:

Cc: stable@vger.kernel.org # v3.9+

> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index a908ada..2220f7a 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -108,6 +108,7 @@
>  #define MSR_TS_T	__MASK(MSR_TS_T_LG)	/*  Transaction Transactional */
>  #define MSR_TS_MASK	(MSR_TS_T | MSR_TS_S)   /* Transaction State bits */
>  #define MSR_TM_ACTIVE(x) (((x) & MSR_TS_MASK) != 0) /* Transaction active? */
> +#define MSR_TM_RESV(x) (((x) & MSR_TS_MASK) == MSR_TS_MASK) /* Reserved */

Is reserved a good name? I think illegal/bad/wrong would be more helpful,
though I haven't checked the arch to see if it uses "reserved".

>  #define MSR_TM_TRANSACTIONAL(x)	(((x) & MSR_TS_MASK) == MSR_TS_T)
>  #define MSR_TM_SUSPENDED(x)	(((x) & MSR_TS_MASK) == MSR_TS_S)
>  
> diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
> index 0dbee46..5b519c7 100644
> --- a/arch/powerpc/kernel/signal_32.c
> +++ b/arch/powerpc/kernel/signal_32.c
> @@ -874,7 +874,16 @@ static long restore_tm_user_regs(struct pt_regs *regs,
>  		       + ELF_NEVRREG))
>  		return 1;
>  #endif /* CONFIG_SPE */
> -

I know you didn't start the rot here, but can you please use your newline key a
bit more :D

> +	/* Get the top half of the MSR */

"top" scares me now that we have both kinds of endian, but you're just moving
that code anyway, and it is sane because it's a 32-bit value that we explicitly
put the top half of the 64-bit MSR in.

> +	if (__get_user(msr_hi, &tm_sr->mc_gregs[PT_MSR]))
> +		return 1;

> +	/* Pull in MSR TM from user context */
> +	regs->msr = (regs->msr & ~MSR_TS_MASK) | ((msr_hi<<32) & MSR_TS_MASK);

Using a tmp variable would be safer.

> +	/* Don't let the user set both TM bits */
> +	if (MSR_TM_RESV(regs->msr)) {
> +		regs->msr &= ~MSR_TS_MASK;

And avoid the clear here.

> +		return 1;
> +	}

At the (minor) expense of an assignment here to regs->msr.


> @@ -884,11 +893,6 @@ static long restore_tm_user_regs(struct pt_regs *regs,
>  	current->thread.tm_texasr |= TEXASR_FS;
>  	/* This loads the checkpointed FP/VEC state, if used */
>  	tm_recheckpoint(&current->thread, msr);
> -	/* Get the top half of the MSR */
> -	if (__get_user(msr_hi, &tm_sr->mc_gregs[PT_MSR]))
> -		return 1;
> -	/* Pull in MSR TM from user context */
> -	regs->msr = (regs->msr & ~MSR_TS_MASK) | ((msr_hi<<32) & MSR_TS_MASK);
>  
>  	/* This loads the speculative FP/VEC state, if used */
>  	if (msr & MSR_FP) {
> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
> index 20756df..b320689 100644
> --- a/arch/powerpc/kernel/signal_64.c
> +++ b/arch/powerpc/kernel/signal_64.c
> @@ -438,6 +438,12 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
>  
>  	/* get MSR separately, transfer the LE bit if doing signal return */
>  	err |= __get_user(msr, &sc->gp_regs[PT_MSR]);
> +	/* Don't allow reserved mode. */
> +	if (MSR_TM_RESV(msr)) {
> +		msr &= ~MSR_TS_MASK;

Why are you clearing the bits before returning, it's a local isn't it?

> +		return -EINVAL;
> +	}
> +
>  	/* pull in MSR TM from user context */
>  	regs->msr = (regs->msr & ~MSR_TS_MASK) | (msr & MSR_TS_MASK);
>  

cheers

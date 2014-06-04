Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A89F1A0835
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jun 2014 17:31:19 +1000 (EST)
Message-ID: <1401867077.9903.3.camel@concordia>
Subject: Re: [PATCH 1/1] powerpc: correct DSCR during TM context switch
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Wed, 04 Jun 2014 17:31:17 +1000
In-Reply-To: <f1ddc3bc4b970a480367a45cdca51e879cb14df0.1401852531.git.sam.bobroff@au1.ibm.com>
References: <f1ddc3bc4b970a480367a45cdca51e879cb14df0.1401852531.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, mikey@neuling.org, benh@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Sam,

Comments inline ..

On Wed, 2014-06-04 at 13:33 +1000, Sam Bobroff wrote:
> Correct the DSCR SPR becoming temporarily corrupted when a task is
> context switched when within a transaction. It is corrected when
> the transaction is aborted (which will happen after a context switch)
> but if the task has suspended (TSUSPEND) the transaction the incorrect
> value can be seen.

I don't quite follow this description. How is it corrected when the transaction
is aborted, and when does that usually happen? If that happens the task can't
ever see the corrupted value?

To hit the suspended case, the task starts a transaction, suspends it, is then
context switched out and back in, and at that point it can see the wrong value?


> The problem is caused by saving a thread's DSCR after it has already
> been reverted to the CPU's default value:
> 
> __switch_to() calls __switch_to_tm()
> 	which calls tm_reclaim_task()
> 	which calls tm_reclaim_thread()
> 	which calls tm_reclaim() where the DSCR is reset

Where the DSCR is set to DSCR_DEFAULT ? Or now PACA_DSCR since your previous
patches?

Could we instead fix the bug there by reverting to the thread's DSCR value?

> __switch_to() calls _switch
> 	_switch() saves the DSCR to thread.dscr
> 
> The fix is to treat the DSCR similarly to the TAR and save it early
> in __switch_to().
> 
> The program below will expose the problem:


Can you drop this in tools/testing/selftests/powerpc/tm ?

You'll need to create that directory, you can ape the Makefile from the pmu
directory, it should be fairly obvious. See the pmu tests for how to integrate
with the test harness etc., or bug me if it's not straight forward.


> diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
> index 2737f46..3efd0e5 100644
> --- a/arch/powerpc/include/asm/switch_to.h
> +++ b/arch/powerpc/include/asm/switch_to.h
> @@ -16,13 +16,15 @@ struct thread_struct;
>  extern struct task_struct *_switch(struct thread_struct *prev,
>  				   struct thread_struct *next);
>  #ifdef CONFIG_PPC_BOOK3S_64
> -static inline void save_tar(struct thread_struct *prev)
> +static inline void save_early_sprs(struct thread_struct *prev)
>  {
>  	if (cpu_has_feature(CPU_FTR_ARCH_207S))
>  		prev->tar = mfspr(SPRN_TAR);
> +	if (cpu_has_feature(CPU_FTR_DSCR))
> +		prev->dscr = mfspr(SPRN_DSCR);
>  }

Are we going to end up saving more SPRs in this code? What makes the TAR & DSCR
special vs everything else?

The nice thing about doing this in asm is it's nop'ed out for cpus that don't
have the DSCR. What does the generated code for this look like?

> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 662c6dd..a107f4a 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -432,12 +432,6 @@ BEGIN_FTR_SECTION
>  	std	r24,THREAD_VRSAVE(r3)
>  END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
>  #endif /* CONFIG_ALTIVEC */
> -#ifdef CONFIG_PPC64
> -BEGIN_FTR_SECTION
> -	mfspr	r25,SPRN_DSCR
> -	std	r25,THREAD_DSCR(r3)
> -END_FTR_SECTION_IFSET(CPU_FTR_DSCR)
> -#endif
>  	and.	r0,r0,r22
>  	beq+	1f
>  	andc	r22,r22,r0


cheers

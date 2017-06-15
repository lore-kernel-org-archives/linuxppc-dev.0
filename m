Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpJKC1RlvzDqL8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 19:35:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH 12/13] powerpc/64: runlatch CTRL[RUN] set optimisation
In-Reply-To: <20170614234400.214a1586@roar.ozlabs.ibm.com>
References: <20170613130557.26315-1-npiggin@gmail.com>
 <20170613130557.26315-13-npiggin@gmail.com>
 <87h8zi3ikj.fsf@concordia.ellerman.id.au>
 <20170614234400.214a1586@roar.ozlabs.ibm.com>
Date: Thu, 15 Jun 2017 19:35:58 +1000
Message-ID: <874lvhpp8h.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index baae104b16c7..f587c1fdf981 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1960,11 +1960,25 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
>  void notrace __ppc64_runlatch_on(void)
>  {
>  	struct thread_info *ti = current_thread_info();
> -	unsigned long ctrl;
>  
> -	ctrl = mfspr(SPRN_CTRLF);
> -	ctrl |= CTRL_RUNLATCH;
> -	mtspr(SPRN_CTRLT, ctrl);
> +	if (cpu_has_feature(CPU_FTR_ARCH_206)) {
> +		/*
> +		 * Least significant bit (RUN) is the only writable bit of
> +		 * the CTRL register, so we can avoid mfspr. 2.06 is not the
> +		 * earliest ISA where this is the case, but it's convenient.
> +		 */
> +		mtspr(SPRN_CTRLT, CTRL_RUNLATCH);
> +	} else {
> +		unsigned long ctrl;
> +
> +		/*
> +		 * Some architectures (e.g., Cell) have writable fields other
> +		 * than RUN, so do the read-modify-write.
> +		 */
> +		ctrl = mfspr(SPRN_CTRLF);
> +		ctrl |= CTRL_RUNLATCH;
> +		mtspr(SPRN_CTRLT, ctrl);
> +	}

Does the generated code look any good if you do something like:

        unsigned long ctrl;

	ctrl = 0;
	if (!cpu_has_feature(CPU_FTR_ARCH_206))
		ctrl = mfspr(SPRN_CTRLF);

	ctrl |= CTRL_RUNLATCH;
        mtspr(SPRN_CTRLT, ctrl);


That would offend me slightly less ;)

cheers

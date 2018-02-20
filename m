Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlljW0X6FzDrTq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 14:00:31 +1100 (AEDT)
Message-ID: <1519095630.7360.57.camel@neuling.org>
Subject: Re: [RFC PATCH 10/12] [WIP] powerpc/tm: Correctly save/restore
 checkpointed sprs
From: Michael Neuling <mikey@neuling.org>
To: Cyril Bur <cyrilbur@gmail.com>, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 20 Feb 2018 14:00:30 +1100
In-Reply-To: <20180220002241.29648-11-cyrilbur@gmail.com>
References: <20180220002241.29648-1-cyrilbur@gmail.com>
 <20180220002241.29648-11-cyrilbur@gmail.com>
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

This needs a description of what you're trying to do.  "Correctly" doesn't
really mean anything.


On Tue, 2018-02-20 at 11:22 +1100, Cyril Bur wrote:
> ---
>  arch/powerpc/kernel/process.c | 57 +++++++++++++++++++++++++++++++++++++=
++++-
> -
>  arch/powerpc/kernel/ptrace.c  |  9 +++----
>  2 files changed, 58 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.=
c
> index cd3ae80a6878..674f75c56172 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -859,6 +859,8 @@ static inline bool tm_enabled(struct task_struct *tsk=
)
>  	return tsk && tsk->thread.regs && (tsk->thread.regs->msr & MSR_TM);
>  }
> =20
> +static inline void save_sprs(struct thread_struct *t);
> +
>  static void tm_reclaim_thread(struct thread_struct *thr, uint8_t cause)
>  {
>  	/*
> @@ -879,6 +881,8 @@ static void tm_reclaim_thread(struct thread_struct *t=
hr,
> uint8_t cause)
>  	if (!MSR_TM_SUSPENDED(mfmsr()))
>  		return;
> =20
> +	save_sprs(thr);
> +
>  	giveup_all(container_of(thr, struct task_struct, thread));
> =20
>  	tm_reclaim(thr, cause);
> @@ -991,6 +995,37 @@ void tm_recheckpoint(struct thread_struct *thread)
> =20
>  	__tm_recheckpoint(thread);
> =20
> +	/*
> +	 * This is a stripped down restore_sprs(), we need to do this
> +	 * now as we might go straight out to userspace and currently
> +	 * the checkpointed values are on the CPU.
> +	 *
> +	 * TODO: Improve
> +	 */
> +#ifdef CONFIG_ALTIVEC
> +	if (cpu_has_feature(CPU_FTR_ALTIVEC))
> +		mtspr(SPRN_VRSAVE, thread->vrsave);
> +#endif
> +#ifdef CONFIG_PPC_BOOK3S_64
> +	if (cpu_has_feature(CPU_FTR_DSCR)) {
> +		u64 dscr =3D get_paca()->dscr_default;
> +		if (thread->dscr_inherit)
> +			dscr =3D thread->dscr;
> +
> +		mtspr(SPRN_DSCR, dscr);
> +	}
> +
> +	if (cpu_has_feature(CPU_FTR_ARCH_207S)) {
> +		/* The EBB regs aren't checkpointed */
> +		mtspr(SPRN_FSCR, thread->fscr);
> +
> +		mtspr(SPRN_TAR, thread->tar);
> +	}
> +
> +	/* I think we don't need to */
> +	if (cpu_has_feature(CPU_FTR_ARCH_300))
> +		mtspr(SPRN_TIDR, thread->tidr);
> +#endif

Why are you touching all the above hunk?

>  	local_irq_restore(flags);
>  }
> =20
> @@ -1193,6 +1228,11 @@ struct task_struct *__switch_to(struct task_struct
> *prev,
>  #endif
> =20
>  	new_thread =3D &new->thread;
> +	/*
> +	 * Why not &prev->thread; ?
> +	 * What is the difference between &prev->thread and
> +	 * &current->thread ?
> +	 */

Why not just work it out and FIX THE CODE, rather than just rabbiting on ab=
out
it! :-P

>  	old_thread =3D &current->thread;
> =20
>  	WARN_ON(!irqs_disabled());
> @@ -1237,8 +1277,16 @@ struct task_struct *__switch_to(struct task_struct
> *prev,
>  	/*
>  	 * We need to save SPRs before treclaim/trecheckpoint as these will
>  	 * change a number of them.
> +	 *
> +	 * Because we're now reclaiming on kernel entry, we've had to
> +	 * already save them. Don't do it again.
> +	 * Note: To deliver a signal in the signal context, we'll have
> +	 * turned off TM because we don't want the signal context to
> +	 * have the transactional state of the main thread - what if
> +	 * we go through switch to at that point? Can we?
>  	 */
> -	save_sprs(&prev->thread);
> +	if (!prev->thread.regs || !MSR_TM_ACTIVE(prev->thread.regs->msr))
> +		save_sprs(&prev->thread);
> =20
>  	/* Save FPU, Altivec, VSX and SPE state */
>  	giveup_all(prev);
> @@ -1260,8 +1308,13 @@ struct task_struct *__switch_to(struct task_struct
> *prev,
>  	 * for this is we manually create a stack frame for new tasks that
>  	 * directly returns through ret_from_fork() or
>  	 * ret_from_kernel_thread(). See copy_thread() for details.
> +	 *
> +	 * It isn't stricly nessesary that we avoid the restore here
> +	 * because we'll simply restore again after the recheckpoint,
> +	 * but we can avoid it for performance reasons.
>  	 */
> -	restore_sprs(old_thread, new_thread);
> +	if (!new_thread->regs || !MSR_TM_ACTIVE(new_thread->regs->msr))
> +		restore_sprs(old_thread, new_thread);
> =20
>  	last =3D _switch(old_thread, new_thread);
> =20
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index ca72d7391d40..16001987ba71 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -135,12 +135,9 @@ static void flush_tmregs_to_thread(struct task_struc=
t
> *tsk)
>  	if ((!cpu_has_feature(CPU_FTR_TM)) || (tsk !=3D current))
>  		return;
> =20
> -	if (MSR_TM_SUSPENDED(mfmsr())) {
> -		tm_reclaim_current(TM_CAUSE_SIGNAL);
> -	} else {
> -		tm_enable();
> -		tm_save_sprs(&(tsk->thread));
> -	}
> +	BUG_ON(MSR_TM_SUSPENDED(mfmsr()));
> +	tm_enable();
> +	tm_save_sprs(&(tsk->thread));
>  }
>  #else
>  static inline void flush_tmregs_to_thread(struct task_struct *tsk) { }

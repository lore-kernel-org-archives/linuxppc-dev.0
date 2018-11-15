Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3D1C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 01:06:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23911208E7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 01:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="FaayJWEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23911208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wNVT71m0zF3ZL
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 12:06:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=neuling.org header.i=@neuling.org header.b="FaayJWEZ";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wNRn1mD3zF3W4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 12:04:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.b="FaayJWEZ"; 
 dkim-atps=neutral
Received: from spoke.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 42wNRn0124z9s3q;
 Thu, 15 Nov 2018 12:04:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1542243861;
 bh=66uYRJFn5clG+Loic2J6Ki/RWiVQo+KiGiergjDBk7c=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=FaayJWEZJiSN++J5oQKACQLKc7SyaXHInWIY5Kd+Gfpa6j/yd7GoqOHm6WLxWJDG4
 0VoRdGHa6rUV3llTlPxHhFCd49VSlismXEPgjGLJKREhl158yACHAsNjkbRGFUbEEC
 AukEaYhJySqR3op5sbwtXtiyBJXUJPquXYDEGb95jo7NydlHh+YptvbvOODAtPcrl/
 93Dsa+EOQt2FHpEsTr1oIJQTY7SoRi1SiYtHQw5neWwAyMtKGfSr//qQYPvFZc8z+C
 vBPiGxLHp04okXDFYMojtnnD1lXhJSi2WnMWX+lBXZNHzC+nuYu2eaemawNzsRZLnQ
 eZ+PtQ7RUwWpg==
Received: by spoke.localdomain (Postfix, from userid 1000)
 id EB3B92A164D; Thu, 15 Nov 2018 12:04:20 +1100 (AEDT)
Message-ID: <30830ce78a59f238959b2ccc21dbe981397042da.camel@neuling.org>
Subject: Re: [RFC PATCH 05/14] powerpc/tm: Refactor the __switch_to_tm code
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 15 Nov 2018 12:04:20 +1100
In-Reply-To: <1541508028-31865-6-git-send-email-leitao@debian.org>
References: <1541508028-31865-1-git-send-email-leitao@debian.org>
 <1541508028-31865-6-git-send-email-leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: ldufour@linux.vnet.ibm.com, cyrilbur@gmail.com, gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2018-11-06 at 10:40 -0200, Breno Leitao wrote:
> __switch_to_tm is the function that switches between two tasks which migh=
t
> have TM enabled. This function is clearly split in two parts, the task th=
at
> is leaving the CPU, known as 'prev' and the task that is being scheduled,
> known as 'new'.
>=20
> It starts checking if the previous task had TM enable, if so, it increase=
s
> the load_tm (this is the only place we increment load_tm). It also saves
> the TM SPRs here.
>=20
> If the previous task was scheduled out with a transaction active, the
> failure cause needs to be updated, since it might contain the failure cau=
se
> that caused the exception, as TM_CAUSE_MISC. In this case, since there wa=
s
> a context switch, overwrite the failure cause.
>=20
> If the previous task has overflowed load_tm, disable TM, putting the
> facility save/restore lazy mechanism at lazy mode.
>=20
> Regarding the 'new' task being scheduled, restoring TM SPRs is enough if
> the task had TM enabled when it was de-scheduled. (Checking if a
> recheckpoint would be required will be done later, at restore_tm_state()
> stage.)
>=20
> On top of that, both tm_reclaim_task() and tm_recheckpoint_new_task()
> functions are not used anymore, removing them.

Is the above describing the previous functionality or the refactored
functionality?

>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/powerpc/kernel/process.c | 167 ++++++++++++++++------------------
>  1 file changed, 78 insertions(+), 89 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.=
c
> index 1842fd96b123..73872f751b33 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -912,48 +912,6 @@ void tm_reclaim_current(uint8_t cause)
>  	tm_reclaim_thread(&current->thread, cause);
>  }
> =20
> -static inline void tm_reclaim_task(struct task_struct *tsk)
> -{
> -	/* We have to work out if we're switching from/to a task that's in the
> -	 * middle of a transaction.
> -	 *
> -	 * In switching we need to maintain a 2nd register state as
> -	 * oldtask->thread.ckpt_regs.  We tm_reclaim(oldproc); this saves the
> -	 * checkpointed (tbegin) state in ckpt_regs, ckfp_state and
> -	 * ckvr_state
> -	 *
> -	 * We also context switch (save) TFHAR/TEXASR/TFIAR in here.
> -	 */
> -	struct thread_struct *thr =3D &tsk->thread;
> -
> -	if (!thr->regs)
> -		return;
> -
> -	if (!MSR_TM_ACTIVE(thr->regs->msr))
> -		goto out_and_saveregs;
> -
> -	WARN_ON(tm_suspend_disabled);
> -
> -	TM_DEBUG("--- tm_reclaim on pid %d (NIP=3D%lx, "
> -		 "ccr=3D%lx, msr=3D%lx, trap=3D%lx)\n",
> -		 tsk->pid, thr->regs->nip,
> -		 thr->regs->ccr, thr->regs->msr,
> -		 thr->regs->trap);
> -
> -	tm_reclaim_thread(thr, TM_CAUSE_RESCHED);
> -
> -	TM_DEBUG("--- tm_reclaim on pid %d complete\n",
> -		 tsk->pid);
> -
> -out_and_saveregs:
> -	/* Always save the regs here, even if a transaction's not active.
> -	 * This context-switches a thread's TM info SPRs.  We do it here to
> -	 * be consistent with the restore path (in recheckpoint) which
> -	 * cannot happen later in _switch().
> -	 */
> -	tm_save_sprs(thr);
> -}
> -
>  extern void __tm_recheckpoint(struct thread_struct *thread);
> =20
>  void tm_recheckpoint(struct thread_struct *thread)
> @@ -980,59 +938,91 @@ void tm_recheckpoint(struct thread_struct *thread)
>  	local_irq_restore(flags);
>  }
> =20
> -static inline void tm_recheckpoint_new_task(struct task_struct *new)
> +static void tm_change_failure_cause(struct task_struct *task, uint8_t ca=
use)
>  {
> -	if (!cpu_has_feature(CPU_FTR_TM))
> -		return;
> -
> -	/* Recheckpoint the registers of the thread we're about to switch to.
> -	 *
> -	 * If the task was using FP, we non-lazily reload both the original and
> -	 * the speculative FP register states.  This is because the kernel
> -	 * doesn't see if/when a TM rollback occurs, so if we take an FP
> -	 * unavailable later, we are unable to determine which set of FP regs
> -	 * need to be restored.
> -	 */
> -	if (!tm_enabled(new))
> -		return;
> -
> -	if (!MSR_TM_ACTIVE(new->thread.regs->msr)){
> -		tm_restore_sprs(&new->thread);
> -		return;
> -	}
> -	/* Recheckpoint to restore original checkpointed register state. */
> -	TM_DEBUG("*** tm_recheckpoint of pid %d (new->msr 0x%lx)\n",
> -		 new->pid, new->thread.regs->msr);
> -
> -	tm_recheckpoint(&new->thread);
> -
> -	/*
> -	 * The checkpointed state has been restored but the live state has
> -	 * not, ensure all the math functionality is turned off to trigger
> -	 * restore_math() to reload.
> -	 */
> -	new->thread.regs->msr &=3D ~(MSR_FP | MSR_VEC | MSR_VSX);
> -
> -	TM_DEBUG("*** tm_recheckpoint of pid %d complete "
> -		 "(kernel msr 0x%lx)\n",
> -		 new->pid, mfmsr());
> +	task->thread.tm_texasr &=3D ~TEXASR_FC;
> +	task->thread.tm_texasr |=3D (unsigned long) cause << TEXASR_FC_LG;
>  }
> =20
>  static inline void __switch_to_tm(struct task_struct *prev,
>  		struct task_struct *new)
>  {
> -	if (cpu_has_feature(CPU_FTR_TM)) {
> -		if (tm_enabled(prev) || tm_enabled(new))
> -			tm_enable();
> +	if (!cpu_has_feature(CPU_FTR_TM))
> +		return;
> +
> +	/* The task leaving the CPU was using TM, let's handle it */
> +	if (tm_enabled(prev)) {
> +		/*
> +		 * Load_tm is incremented only when the task is scheduled out
> +		 */
> +		prev->thread.load_tm++;
> +
> +		/*
> +		 * If TM is enabled for the thread, it needs to, at least,
> +		 * save the SPRs
> +		 */
> +		tm_enable();
> +		tm_save_sprs(&prev->thread);
> +
> +		/*
> +		 * If the task being descheduled had an active transaction
> +		 * during the exception that brought it here, the
> +		 * transaction was reclaimed by TM_KERNEL_ENTRY.
> +		 *
> +		 * Independently of the TEXASR failure code set at
> +		 * TM_KERNEL_ENTRY time, the task is being descheduled, and
> +		 * the failure code needs to be updated to reflect it.
> +		 */
> +		if (MSR_TM_ACTIVE(prev->thread.regs->msr)) {
> +			/*
> +			 * If there was an IRQ during trecheckpoint, it will
> +			 * cause an IRQ to be replayed. This replayed IRQ can
> +			 * invoke SCHEDULE_USER, thus, we arrive here with a TM
> +			 * active transaction.
> +			 * I.e, the task was leaving kernelspace to userspace,
> +			 * already trecheckpointed, but there was a IRQ during
> +			 * the trecheckpoint process (soft irq disabled), and
> +			 * on the IRQ replay, the process was de-scheduled, so,
> +			 * SCHEDULE_USER was called and here we are.
> +			 *
> +			 */
> +			if (WARN_ON(MSR_TM_ACTIVE(mfmsr())))
> +				tm_reclaim_current(TM_CAUSE_RESCHED);

Do we need the MSR_TM_ACTIVE() check gating this? if MSR_TM_ACTIVE(mfmsr())
after TM_KERNEL_ENTRY, something is pretty broken. (in fact you have this c=
heck
later... so just remove this one I think).


> =20
> -		if (tm_enabled(prev)) {
> -			prev->thread.load_tm++;
> -			tm_reclaim_task(prev);
> -			if (!MSR_TM_ACTIVE(prev->thread.regs->msr) && prev->thread.load_tm =
=3D=3D 0)
> +			/*
> +			 * If rescheduled with TM active, update the
> +			 * failure cause
> +			 */
> +			tm_change_failure_cause(prev, TM_CAUSE_RESCHED);
> +		} else {

else if to avoid more indenting...

> +			/*
> +			 * TM enabled but not transactional. Just disable TM
> +			 * if load_tm overflows. This should be the only place
> +			 * that disables the TM and reenables the laziness
> +			 * save/restore
> +			 */
> +			if (prev->thread.load_tm =3D=3D 0)
>  				prev->thread.regs->msr &=3D ~MSR_TM;
>  		}
> +	}
> =20
> -		tm_recheckpoint_new_task(new);
> +	/*
> +	 * It is a *bug* if we arrived so late with a transaction active
> +	 * (more precisely suspended)
> +	 */
> +	if (WARN_ON(MSR_TM_ACTIVE(mfmsr()))) {
> +		/* Recovery path. 0x99 shouldn't be exported to UAPI */
> +		tm_reclaim_current(0x99);
> +	}

As discussed privately, if we hit this case, either we BUG_ON() or we WARN_=
ON()
AND kill the process. Something is bust in the kernel at this point so we n=
eed
to do something more than just warning and limp along with a reclaim.

Also, no {} needed for single line if statements.

> +
> +	/*
> +	 * If the next task has TM enabled, restore the SPRs. Do not need to
> +	 * care about recheckpoint at this time. It will be done later if
> +	 * TIF_RESTORE_TM was set when the task was scheduled out
> +	 */
> +	if (tm_enabled(new)) {
> +		tm_enable();
> +		tm_restore_sprs(&new->thread);
>  	}
>  }
> =20
> @@ -1094,7 +1084,6 @@ void restore_tm_state(struct pt_regs *regs)
>  }
> =20
>  #else
> -#define tm_recheckpoint_new_task(new)
>  #define __switch_to_tm(prev, new)
>  #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
> =20
> @@ -1599,9 +1588,9 @@ int arch_dup_task_struct(struct task_struct *dst, s=
truct task_struct *src)
>  	/*
>  	 * Flush TM state out so we can copy it.  __switch_to_tm() does this
>  	 * flush but it removes the checkpointed state from the current CPU and
> -	 * transitions the CPU out of TM mode.  Hence we need to call
> -	 * tm_recheckpoint_new_task() (on the same task) to restore the
> -	 * checkpointed state back and the TM mode.
> +	 * transitions the CPU out of TM mode.  Hence we need to make sure
> +	 * TIF_RESTORE_TM is set so restore_tm_state is called to restore the
> +	 * checkpointed state and back to TM mode.
>  	 *
>  	 * Can't pass dst because it isn't ready. Doesn't matter, passing
>  	 * dst is only important for __switch_to()

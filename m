Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DsXD4zFszF1Rl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 15:50:04 +1000 (AEST)
Message-ID: <7647a2d788ceb979e6de8bb8bb988f4d37fb1877.camel@neuling.org>
Subject: Re: [RFC PATCH 10/11] powerpc/tm: Set failure summary
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Cc: paulus@ozlabs.org, gromero@linux.vnet.ibm.com, mpe@ellerman.id.au,
 ldufour@linux.vnet.ibm.com
Date: Tue, 18 Sep 2018 15:50:04 +1000
In-Reply-To: <1536781219-13938-11-git-send-email-leitao@debian.org>
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
 <1536781219-13938-11-git-send-email-leitao@debian.org>
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

On Wed, 2018-09-12 at 16:40 -0300, Breno Leitao wrote:
> Since the transaction will be doomed with treckpt., the TEXASR[FS]
> should be set, to reflect that the transaction is a failure. This patch
> ensures it before recheckpointing, and remove changes from other places
> that were calling recheckpoint.

TEXASR[FS] should be set by the reclaim. I don't know why you'd need to set=
 this
explicitly in process.c. The only case is when the user supplies a bad sign=
al
context, but we should check that in the signals code, not process.c

Hence I think this patch is wrong.

Also, according to the architecture, TEXASR[FS] HAS TO BE SET on trecheckpo=
int
otherwise you'll get a TM Bad Thing. You should say that rather than sugges=
ting
it's because the transaction is doomed. It's illegal to not do it. That's w=
hy we
have this check in arch/powerpc/kernel/tm.S.


	/* Do final sanity check on TEXASR to make sure FS is set.  Do this
	 * here before we load up the userspace r1 so any bugs we hit will get
	 * a call chain */
	mfspr	r5, SPRN_TEXASR
	srdi	r5, r5, 16
	li	r6, (TEXASR_FS)@h
	and	r6, r6, r5
1:	tdeqi	r6, 0
	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,0


Mikey

> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/powerpc/kernel/process.c   | 6 ++++++
>  arch/powerpc/kernel/signal_32.c | 2 --
>  arch/powerpc/kernel/signal_64.c | 2 --
>  3 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.=
c
> index 5cace1b744b1..77725b2e4dc1 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -937,6 +937,12 @@ void tm_recheckpoint(struct thread_struct *thread)
>  	local_irq_save(flags);
>  	hard_irq_disable();
> =20
> +	/*
> +	 * Make sure the failure summary is set, since the transaction will be
> +	 * doomed.
> +	 */
> +	thread->tm_texasr |=3D TEXASR_FS;
> +
>  	/* The TM SPRs are restored here, so that TEXASR.FS can be set
>  	 * before the trecheckpoint and no explosion occurs.
>  	 */
> diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal=
_32.c
> index 4a1b17409bf3..96956d50538e 100644
> --- a/arch/powerpc/kernel/signal_32.c
> +++ b/arch/powerpc/kernel/signal_32.c
> @@ -851,8 +851,6 @@ static long restore_tm_user_regs(struct pt_regs *regs=
,
>  	/* Pull in the MSR TM bits from the user context */
>  	regs->msr =3D (regs->msr & ~MSR_TS_MASK) | (msr_hi & MSR_TS_MASK);
> =20
> -	/* Make sure the transaction is marked as failed */
> -	current->thread.tm_texasr |=3D TEXASR_FS;
>  	/* Make sure restore_tm_state will be called */
>  	set_thread_flag(TIF_RESTORE_TM);
> =20
> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal=
_64.c
> index 32402aa23a5e..c84501711b14 100644
> --- a/arch/powerpc/kernel/signal_64.c
> +++ b/arch/powerpc/kernel/signal_64.c
> @@ -569,8 +569,6 @@ static long restore_tm_sigcontexts(struct task_struct
> *tsk,
>  		}
>  	}
>  #endif
> -	/* Make sure the transaction is marked as failed */
> -	tsk->thread.tm_texasr |=3D TEXASR_FS;
>  	/* Guarantee that restore_tm_state() will be called */
>  	set_thread_flag(TIF_RESTORE_TM);
> =20

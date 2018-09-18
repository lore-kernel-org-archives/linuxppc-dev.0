Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Ds7n13DKzDrTP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 15:32:21 +1000 (AEST)
Message-ID: <e4b31125fa6669131613b21b2575ea4f2de55699.camel@neuling.org>
Subject: Re: [RFC PATCH 07/11] powerpc/tm: Do not recheckpoint at sigreturn
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Cc: paulus@ozlabs.org, gromero@linux.vnet.ibm.com, mpe@ellerman.id.au,
 ldufour@linux.vnet.ibm.com
Date: Tue, 18 Sep 2018 15:32:20 +1000
In-Reply-To: <1536781219-13938-8-git-send-email-leitao@debian.org>
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
 <1536781219-13938-8-git-send-email-leitao@debian.org>
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
> Do not recheckpoint at signal code return. Just make sure TIF_RESTORE_TM =
is
> set, which will restore on the exit to userspace by restore_tm_state.

Cool, but what about the same for reclaim? Why not avoid treclaim since it'=
s
done on entry?

Mikey

>=20
> All the FP and VEC lazy restore was already done by tm_reclaim_current(),
> where it checked if FP/VEC was set, and filled out the ckfp and ckvr
> registers area to the expected value.
>=20
> The current FP/VEC restoration is not necessary, since the transaction wi=
ll
> be aborted and the checkpointed values will be restore.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/powerpc/kernel/signal_32.c | 23 +++--------------------
>  arch/powerpc/kernel/signal_64.c | 15 ++-------------
>  2 files changed, 5 insertions(+), 33 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal=
_32.c
> index e6474a45cef5..4a1b17409bf3 100644
> --- a/arch/powerpc/kernel/signal_32.c
> +++ b/arch/powerpc/kernel/signal_32.c
> @@ -850,28 +850,11 @@ static long restore_tm_user_regs(struct pt_regs *re=
gs,
>  		return 1;
>  	/* Pull in the MSR TM bits from the user context */
>  	regs->msr =3D (regs->msr & ~MSR_TS_MASK) | (msr_hi & MSR_TS_MASK);
> -	/* Now, recheckpoint.  This loads up all of the checkpointed (older)
> -	 * registers, including FP and V[S]Rs.  After recheckpointing, the
> -	 * transactional versions should be loaded.
> -	 */
> -	tm_enable();
> +
>  	/* Make sure the transaction is marked as failed */
>  	current->thread.tm_texasr |=3D TEXASR_FS;
> -	/* This loads the checkpointed FP/VEC state, if used */
> -	tm_recheckpoint(&current->thread);
> -
> -	/* This loads the speculative FP/VEC state, if used */
> -	msr_check_and_set(msr & (MSR_FP | MSR_VEC));
> -	if (msr & MSR_FP) {
> -		load_fp_state(&current->thread.fp_state);
> -		regs->msr |=3D (MSR_FP | current->thread.fpexc_mode);
> -	}
> -#ifdef CONFIG_ALTIVEC
> -	if (msr & MSR_VEC) {
> -		load_vr_state(&current->thread.vr_state);
> -		regs->msr |=3D MSR_VEC;
> -	}
> -#endif
> +	/* Make sure restore_tm_state will be called */
> +	set_thread_flag(TIF_RESTORE_TM);
> =20
>  	return 0;
>  }
> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal=
_64.c
> index 83d51bf586c7..32402aa23a5e 100644
> --- a/arch/powerpc/kernel/signal_64.c
> +++ b/arch/powerpc/kernel/signal_64.c
> @@ -569,21 +569,10 @@ static long restore_tm_sigcontexts(struct task_stru=
ct
> *tsk,
>  		}
>  	}
>  #endif
> -	tm_enable();
>  	/* Make sure the transaction is marked as failed */
>  	tsk->thread.tm_texasr |=3D TEXASR_FS;
> -	/* This loads the checkpointed FP/VEC state, if used */
> -	tm_recheckpoint(&tsk->thread);
> -
> -	msr_check_and_set(msr & (MSR_FP | MSR_VEC));
> -	if (msr & MSR_FP) {
> -		load_fp_state(&tsk->thread.fp_state);
> -		regs->msr |=3D (MSR_FP | tsk->thread.fpexc_mode);
> -	}
> -	if (msr & MSR_VEC) {
> -		load_vr_state(&tsk->thread.vr_state);
> -		regs->msr |=3D MSR_VEC;
> -	}
> +	/* Guarantee that restore_tm_state() will be called */
> +	set_thread_flag(TIF_RESTORE_TM);
> =20
>  	return err;
>  }

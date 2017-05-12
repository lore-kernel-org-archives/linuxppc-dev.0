Return-Path: <cyrilbur@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wPYjF2m1gzDqKs
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 May 2017 01:26:25 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id w69so7417583pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 08:26:25 -0700 (PDT)
Message-ID: <1494602774.21781.3.camel@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/tm: Fix FP and VMX register corruption
From: Cyril Bur <cyrilbur@gmail.com>
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Breno Leitao <brenohl@br.ibm.com>,
 Gustavo Bueno Romero <gromero@br.ibm.com>
Date: Sat, 13 May 2017 01:26:14 +1000
In-Reply-To: <20170508071627.21851-1-mikey@neuling.org>
References: <20170508071627.21851-1-mikey@neuling.org>
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

On Mon, 2017-05-08 at 17:16 +1000, Michael Neuling wrote:
> In this commit:
>   commit dc3106690b20305c3df06b42456fe386dd632ac9
>   Author: Cyril Bur <cyrilbur@gmail.com>
>   powerpc: tm: Always use fp_state and vr_state to store live registers
> 
> A section of code was removed that copied the current state to
> checkpointed state.  This should not have been removed.
> 

-[space]

> When an FP unavailable is taken inside a transaction, we need to abort
> the transaction. This is because at the time of the tbegin, the FP
> state is bogus so the state stored in the checkpointed registers is
> incorrect. To fix this, we treclaim (to get the checkpointed GPRs) and
> then copy the thread_struct FP live state into the checkpointed
> state. We then trecheckpoint so that the FP state is correctly
> restored into the CPU.
> 
> The coping of the FP registers from live to checkpointed is what was
> missing.
> 
> This simplifies the logic slightly from the original patch.
> tm_reclaim_thread() will now always write the checkpointed FP
> state. Either the checkpointed FP statte will be written as part of

state

> the actual treclaim (in tm.S), or it'll be a copy of the live
> state. Which one we use is based on MSR[FP] from userspace.
> 
> Similarly for VMX.
> 
> CC: <stable@vger.kernel.org> # 4.9+
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Reviewed-by: cyrilbur@gmail.com

> ---
>  arch/powerpc/kernel/process.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index d645da302b..6305353237 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -864,6 +864,25 @@ static void tm_reclaim_thread(struct thread_struct *thr,
>  	if (!MSR_TM_SUSPENDED(mfmsr()))
>  		return;
>  
> +	/*
> +	 * If we are in a transaction and FP is off then we can't have
> +	 * used FP inside that transaction. Hence the checkpointed
> +	 * state is the same as the live state. We need to copy the
> +	 * live state to the checkpointed state so that when the
> +	 * transaction is restored, the checkpointed state is correct
> +	 * and the aborted transaction sees the correct state.  We use

-[space]

> +	 * ckpt_regs.msr here as that's what tm_reclaim will use to
> +	 * determine if it's going to write the checkpointed state or
> +	 * not. So either this will write the checkpointed registers,
> +	 * or reclaim will.  Similarly for VMX.

-[space]

> +	 */
> +	if ((thr->ckpt_regs.msr & MSR_FP) == 0)
> +		memcpy(&thr->ckfp_state, &thr->fp_state,
> +		       sizeof(struct thread_fp_state));
> +	if ((thr->ckpt_regs.msr & MSR_VEC) == 0)
> +		memcpy(&thr->ckvr_state, &thr->vr_state,
> +		       sizeof(struct thread_vr_state));
> +
>  	giveup_all(container_of(thr, struct task_struct, thread));
>  
>  	tm_reclaim(thr, thr->ckpt_regs.msr, cause);

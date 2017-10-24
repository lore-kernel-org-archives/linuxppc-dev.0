Return-Path: <cyrilbur@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yM7VX0NNMzDqkr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 09:39:15 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id s75so15688825pgs.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 15:39:15 -0700 (PDT)
Message-ID: <1508884747.4272.4.camel@gmail.com>
Subject: Re: [PATCH] powerpc/tm: Set ckpt_regs.msr before using it.
From: Cyril Bur <cyrilbur@gmail.com>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <breno.leitao@debian.org>, Gustavo Romero
 <gusbromero@gmail.com>, Michael Neuling <mikey@neuling.org>
Date: Wed, 25 Oct 2017 09:39:07 +1100
In-Reply-To: <1508865185-11492-1-git-send-email-leitao@debian.org>
References: <1508865185-11492-1-git-send-email-leitao@debian.org>
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

On Tue, 2017-10-24 at 15:13 -0200, Breno Leitao wrote:
> From: Breno Leitao <breno.leitao@debian.org>
> 
> On commit commit f48e91e87e67 ("powerpc/tm: Fix FP and VMX register
> corruption"), we check ckpt_regs.msr to see if a feature (as VEC, VSX
> and FP) is disabled (thus the hot registers might be bogus during the
> reclaim), and then copy the previously saved thread registers, with the
> non-bogus values, into the checkpoint area for a later trecheckpoint.
> This mechanism is used to recheckpoints the proper register values when
> a transaction started using the bogus registers, and these values were
> sent to the memory checkpoint area.
> 
> I see a problem on this code that ckpt_regs.msr is not properly set when
> using it, as for example, when there is a vsx_unavailable_tm() in a code
> like the following, the ckpt_regs.msg[FP] is 0;
> 
>  1: sleep_until_{fp,vec,vsx} = 0
>  2: fadd
>  3: tbegin.
>  4: beq
>  5: xxmrghd
>  6: tend.
> 
> In this case, line 5 will raise an vsx_unavailable_tm() exception, and
> the ckpt_regs.msr[FP] will be zero before memcpy() block, executing the
> memcpy even with the the FP registers hot. That is not correct because
> we executed a float point instruction on line 2, and MSR[FP] was set to
> 1.
> 
> Fortunately this does not cause a big problem as I can see, other than
> this extra memcpy() because treclaim() will later overwrite this wrong
> copied value, since it relies on the correct MSR value, which was
> updated by giveup_all->check_if_tm_restore_required. There might be a
> problem when laziness is being turned on, but I was not able to
> reproduce it.

I believe this analysis is correct, I have come to the same conclusion
in the past. I've also done a bunch of testing with variants of this
patch and haven't seen a difference, however, I do believe the code is
more correct with this patch.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>

Having said all that, nothing rules out that our tests simply aren't
good enough ;)

 
> 
> The solution I am proposing is updating ckpt_regs.msr before using it.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Gustavo Romero <gusbromero@gmail.com>
> CC: Cyril Bur <cyrilbur@gmail.com>
> CC: Michael Neuling <mikey@neuling.org>
> ---
>  arch/powerpc/kernel/process.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index c051dc2b42ad..773e9c5594e7 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -860,6 +860,9 @@ static void tm_reclaim_thread(struct thread_struct *thr,
>  	if (!MSR_TM_SUSPENDED(mfmsr()))
>  		return;
>  
> +	/* Give up all the registers and set ckpt_regs.msr */
> +	giveup_all(container_of(thr, struct task_struct, thread));
> +
>  	/*
>  	 * If we are in a transaction and FP is off then we can't have
>  	 * used FP inside that transaction. Hence the checkpointed
> @@ -879,8 +882,6 @@ static void tm_reclaim_thread(struct thread_struct *thr,
>  		memcpy(&thr->ckvr_state, &thr->vr_state,
>  		       sizeof(struct thread_vr_state));
>  
> -	giveup_all(container_of(thr, struct task_struct, thread));
> -
>  	tm_reclaim(thr, thr->ckpt_regs.msr, cause);
>  }
>  

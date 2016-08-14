Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sByTf0VDZzDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Aug 2016 22:23:50 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id y134so2205469pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Aug 2016 05:23:49 -0700 (PDT)
Date: Sun, 14 Aug 2016 09:56:03 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org, mikey@neuling.org
Subject: Re: [PATCH v2 18/20] powerpc: tm: Always use fp_state and vr_state
 to store live registers
Message-ID: <20160814015602.GA21144@simonLocalRHEL7.x64>
References: <20160811232819.11453-1-cyrilbur@gmail.com>
 <20160811232819.11453-19-cyrilbur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160811232819.11453-19-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 12, 2016 at 09:28:17AM +1000, Cyril Bur wrote:
> @@ -846,7 +834,9 @@ static void tm_reclaim_thread(struct thread_struct *thr,
>  	if (!MSR_TM_SUSPENDED(mfmsr()))
>  		return;
>  
> -	tm_reclaim(thr, thr->regs->msr, cause);
> +	giveup_all(container_of(thr, struct task_struct, thread));
> +
> +	tm_reclaim(thr, msr_diff, cause);
>  
>  	/* Having done the reclaim, we now have the checkpointed
>  	 * FP/VSX values in the registers.  These might be valid

> @@ -1189,11 +1171,11 @@ struct task_struct *__switch_to(struct task_struct *prev,
>  	 */
>  	save_sprs(&prev->thread);
>  
> -	__switch_to_tm(prev);
> -
>  	/* Save FPU, Altivec, VSX and SPE state */
>  	giveup_all(prev);
>  
> +	__switch_to_tm(prev, new);
> +
>  	/*
>  	 * We can't take a PMU exception inside _switch() since there is a
>  	 * window where the kernel stack SLB and the kernel stack are out


There are 2 "giveall_all()" in above path:
__switch_to()
        giveup_all()  // first time
        __switch_to_tm()
                tm_reclaim_task()
                        tm_reclaim_thread()
                                giveup_all()  // again????
We should remove the one in __switch_to().

And another question, for following code in tm_reclaim_thread():
        /* Having done the reclaim, we now have the checkpointed
         * FP/VSX values in the registers.  These might be valid
         * even if we have previously called enable_kernel_fp() or
         * flush_fp_to_thread(), so update thr->regs->msr to
         * indicate their current validity.
         */
        thr->regs->msr |= msr_diff;

Does it imply the task being switched out of CPU, with TIF_RESTORE_TM
bit set,  might end with MSR_FP enabled? (I thought MSR_FP should not 
be enabled for a switched out task, as specified in
flush_fp_to_thread())

Thanks,
- Simon

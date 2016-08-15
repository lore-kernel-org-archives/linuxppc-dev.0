Return-Path: <cyrilbur@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sCRqZ2XlszDr3R
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 17:26:02 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id i6so3318264pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 00:26:02 -0700 (PDT)
Message-ID: <1471245953.24478.0.camel@gmail.com>
Subject: Re: [PATCH v2 18/20] powerpc: tm: Always use fp_state and vr_state
 to store live registers
From: Cyril Bur <cyrilbur@gmail.com>
To: Simon Guo <wei.guo.simon@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org, mikey@neuling.org
Date: Mon, 15 Aug 2016 17:25:53 +1000
In-Reply-To: <20160814015602.GA21144@simonLocalRHEL7.x64>
References: <20160811232819.11453-1-cyrilbur@gmail.com>
 <20160811232819.11453-19-cyrilbur@gmail.com>
 <20160814015602.GA21144@simonLocalRHEL7.x64>
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

On Sun, 2016-08-14 at 09:56 +0800, Simon Guo wrote:
> On Fri, Aug 12, 2016 at 09:28:17AM +1000, Cyril Bur wrote:
> > 
> > @@ -846,7 +834,9 @@ static void tm_reclaim_thread(struct
> > thread_struct *thr,
> >  	if (!MSR_TM_SUSPENDED(mfmsr()))
> >  		return;
> >  
> > -	tm_reclaim(thr, thr->regs->msr, cause);
> > +	giveup_all(container_of(thr, struct task_struct, thread));
> > +
> > +	tm_reclaim(thr, msr_diff, cause);
> >  
> >  	/* Having done the reclaim, we now have the checkpointed
> >  	 * FP/VSX values in the registers.  These might be valid
> 
> > 
> > @@ -1189,11 +1171,11 @@ struct task_struct *__switch_to(struct
> > task_struct *prev,
> >  	 */
> >  	save_sprs(&prev->thread);
> >  
> > -	__switch_to_tm(prev);
> > -
> >  	/* Save FPU, Altivec, VSX and SPE state */
> >  	giveup_all(prev);
> >  
> > +	__switch_to_tm(prev, new);
> > +
> >  	/*
> >  	 * We can't take a PMU exception inside _switch() since
> > there is a
> >  	 * window where the kernel stack SLB and the kernel stack
> > are out
> 
> 
> There are 2 "giveall_all()" in above path:
> __switch_to()
>         giveup_all()  // first time
>         __switch_to_tm()
>                 tm_reclaim_task()
>                         tm_reclaim_thread()
>                                 giveup_all()  // again????
> We should remove the one in __switch_to().

I don't think that will be possible, if a thread is not transactional
the second giveup_all() won't get called so we'll need to preserve the
one in __switch_to().
I don't think removing the second is a good idea as we can enter
tm_reclaim_thread() from other means than __switch_to_tm().
I did think that perhaps __switch_to_tm() could call giveup_all() in
the non transactional case but on reflection, doing nothing on the non
transactional case is cleaner.
The two calls are annoying but in the case where two calls are made,
the second should realise that nothing needs to be done and exit
quickly.

> And another question, for following code in tm_reclaim_thread():
>         /* Having done the reclaim, we now have the checkpointed
>          * FP/VSX values in the registers.  These might be valid
>          * even if we have previously called enable_kernel_fp() or
>          * flush_fp_to_thread(), so update thr->regs->msr to
>          * indicate their current validity.
>          */
>         thr->regs->msr |= msr_diff;
> 
> Does it imply the task being switched out of CPU, with TIF_RESTORE_TM
> bit set,  might end with MSR_FP enabled? (I thought MSR_FP should
> not 
> be enabled for a switched out task, as specified in
> flush_fp_to_thread())

Correct! I mistakenly thought it was solving a problem but you're
right. What you say is correct but it breaks signals, I've been
hesitating on how to get signals to work with the correct solution
here, I wasn't happy with my ideas but looks like it's pretty much the
only way to go unfortunately.

Thanks,
Cyril

> 
> Thanks,
> - Simon

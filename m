Return-Path: <cyrilbur@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zXbzr1QDxzF0XQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Feb 2018 10:34:15 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id a14so2598718pfi.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Feb 2018 15:34:15 -0800 (PST)
Message-ID: <1517528048.5450.0.camel@gmail.com>
Subject: Re: [PATCH] powerpc/tm: Remove struct thread_info param from
 tm_reclaim_thread()
From: Cyril Bur <cyrilbur@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: gromero@linux.vnet.ibm.com
Date: Fri, 02 Feb 2018 10:34:08 +1100
In-Reply-To: <87inbhe2q8.fsf@concordia.ellerman.id.au>
References: <20180201010746.413-1-cyrilbur@gmail.com>
 <87inbhe2q8.fsf@concordia.ellerman.id.au>
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

On Thu, 2018-02-01 at 15:46 +1100, Michael Ellerman wrote:
> Cyril Bur <cyrilbur@gmail.com> writes:
> 
> > tm_reclaim_thread() doesn't use the parameter anymore, both callers have
> > to bother getting it as they have no need for a struct thread_info
> > either.
> 
> In future please tell me why the parameter is unused and when it became
> unused.
> 

Thanks, will do!

> In this case it was previously used but the last usage was removed in:
> 
> dc3106690b20 ("powerpc: tm: Always use fp_state and vr_state to store live registers")
> 
> cheers
> 
> > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> > index bfdd783e3916..a47498da6562 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -853,8 +853,7 @@ static inline bool tm_enabled(struct task_struct *tsk)
> >  	return tsk && tsk->thread.regs && (tsk->thread.regs->msr & MSR_TM);
> >  }
> >  
> > -static void tm_reclaim_thread(struct thread_struct *thr,
> > -			      struct thread_info *ti, uint8_t cause)
> > +static void tm_reclaim_thread(struct thread_struct *thr, uint8_t cause)
> >  {
> >  	/*
> >  	 * Use the current MSR TM suspended bit to track if we have
> > @@ -901,7 +900,7 @@ static void tm_reclaim_thread(struct thread_struct *thr,
> >  void tm_reclaim_current(uint8_t cause)
> >  {
> >  	tm_enable();
> > -	tm_reclaim_thread(&current->thread, current_thread_info(), cause);
> > +	tm_reclaim_thread(&current->thread, cause);
> >  }
> >  
> >  static inline void tm_reclaim_task(struct task_struct *tsk)
> > @@ -932,7 +931,7 @@ static inline void tm_reclaim_task(struct task_struct *tsk)
> >  		 thr->regs->ccr, thr->regs->msr,
> >  		 thr->regs->trap);
> >  
> > -	tm_reclaim_thread(thr, task_thread_info(tsk), TM_CAUSE_RESCHED);
> > +	tm_reclaim_thread(thr, TM_CAUSE_RESCHED);
> >  
> >  	TM_DEBUG("--- tm_reclaim on pid %d complete\n",
> >  		 tsk->pid);
> > -- 
> > 2.16.1

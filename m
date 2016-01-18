Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A78131A003F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jan 2016 13:05:28 +1100 (AEDT)
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E98741402DE
 for <linuxppc-dev@ozlabs.org>; Mon, 18 Jan 2016 13:05:27 +1100 (AEDT)
Received: by mail-pa0-x244.google.com with SMTP id pv5so32985250pac.0
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Jan 2016 18:05:27 -0800 (PST)
Date: Mon, 18 Jan 2016 13:05:17 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V2 5/8] powerpc: Restore FPU/VEC/VSX if previously used
Message-ID: <20160118130517.1e4c67b4@camb691>
In-Reply-To: <1452837761.25634.36.camel@neuling.org>
References: <1452834254-22078-1-git-send-email-cyrilbur@gmail.com>
 <1452834254-22078-6-git-send-email-cyrilbur@gmail.com>
 <1452837761.25634.36.camel@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 15 Jan 2016 17:02:41 +1100
Michael Neuling <mikey@neuling.org> wrote:

Hey Mikey,

Thanks for the review, as always you're correct :).

> 
> Can you make the inline code easier to read?  Something like
> 
> #ifdef CONFIG_ALTIVEC
> #define loadvec(thr) ((thr).load_vec)
> #else
> #define loadvec(thr) 0
> #endif
> 
> void restore_math(struct pt_regs *regs)
> {
>        unsigned long msr;
> 
>        if (!current->thread.load_fp && !loadvec(current->thread)
> 		return;
> 
> > +
> > +       msr = regs->msr;
> > +       msr_check_and_set(msr_all_available);
> > +
> > +       /*
> > +        * Only reload if the bit is not set in the user MSR, the bit BEING set
> > +        * indicates that the registers are hot
> > +        */
> > +#ifdef CONFIG_PPC_FPU
> > +       if (current->thread.load_fp && !(msr & MSR_FP)) {
> > +               load_fp_state(&current->thread.fp_state);
> > +               msr |= MSR_FP | current->thread.fpexc_mode;
> > +               current->thread.load_fp++;
> > +       }
> > +#endif
> > +#ifdef CONFIG_ALTIVEC
> > +       if (current->thread.load_vec && !(msr & MSR_VEC) &&
> > +                       cpu_has_feature(CPU_FTR_ALTIVEC)) {
> > +               load_vr_state(&current->thread.vr_state);
> > +               current->thread.used_vr = 1;
> > +               msr |= MSR_VEC;
> > +               current->thread.load_vec++;
> > +       }
> > +#endif
> > +#ifdef CONFIG_VSX
> > +       if (!(msr & MSR_VSX) && (msr & (MSR_FP | MSR_VEC)) == (MSR_FP | MSR_VEC)) {  
> 
> What are you trying to hit with this if statement?
> 
> Seems you are turning on VSX if VSX is not already on but FP and VEC
> is.  Why do you need the check MSR_VSX is not used?  That seems redundant.
> 
> > +               current->thread.used_vsr = 1;
> > +               msr |= MSR_VSX;
> > +       }
> > +#endif
> > +
> > +       msr_check_and_clear(msr_all_available);  
> 
> Why are you doing this?  Why all, and not just the ones you've enabled above?
> 

This is part of the batching of MSR reads and writes. We turned everything on
at the start of restore_math() because it means only one write, the MSR
reads/writes are where the performance hit, not the number of bits changed.
Obviously we subsequently we turn everything off again because it also means
only one write (and we had unconditionally turned everything on).

The check at the start of restore_math() and in entry_64.S should mean that we
don't the msr_check_and_set()/msr_check_and_clear() block with nothing to do.

> > +
> > +       regs->msr = msr;
> > +}
> > +
> >  void flush_all_to_thread(struct task_struct *tsk)
> >  {
> >         if (tsk->thread.regs) {
> > @@ -832,17 +879,9 @@ void restore_tm_state(struct pt_regs *regs)  
>  
> >         msr_diff = current->thread.ckpt_regs.msr & ~regs->msr;
> >         msr_diff &= MSR_FP | MSR_VEC | MSR_VSX;
> > -       if (msr_diff & MSR_FP) {
> > -               msr_check_and_set(MSR_FP);
> > -               load_fp_state(&current->thread.fp_state);
> > -               msr_check_and_clear(MSR_FP);
> > -               regs->msr |= current->thread.fpexc_mode;
> > -       }
> > -       if (msr_diff & MSR_VEC) {
> > -               msr_check_and_set(MSR_VEC);
> > -               load_vr_state(&current->thread.vr_state);
> > -               msr_check_and_clear(MSR_VEC);
> > -       }
> > +
> > +       restore_math(regs);
> > +
> >         regs->msr |= msr_diff;
> >  }  
>  
> > @@ -1006,6 +1045,11 @@ struct task_struct *__switch_to(struct task_struct *prev,
> >                 batch = this_cpu_ptr(&ppc64_tlb_batch);
> >                 batch->active = 1;
> >         }
> > +
> > +       /* Don't do this on a kernel thread */  
> 
> Why not?
> 
> > +       if (current_thread_info()->task->thread.regs)
> > +               restore_math(current_thread_info()->task->thread.regs);
> > +
> >  #endif /* CONFIG_PPC_BOOK3S_64 */  
>  
> >         return last;
> > diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
> > index 162d0f7..038cff8 100644
> > --- a/arch/powerpc/kernel/vector.S
> > +++ b/arch/powerpc/kernel/vector.S
> > @@ -91,6 +91,10 @@ _GLOBAL(load_up_altivec)
> >         oris    r12,r12,MSR_VEC@h
> >         std     r12,_MSR(r1)
> >  #endif
> > +       /* Don't care if r4 overflows, this is desired behaviour */
> > +       lbz     r4,THREAD_LOAD_VEC(r5)
> > +       addi    r4,r4,1
> > +       stb     r4,THREAD_LOAD_VEC(r5)
> >         addi    r6,r5,THREAD_VRSTATE
> >         li      r4,1
> >         li      r10,VRSTATE_VSCR
> > -- 
> > 2.7.0  
> 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-devOn Fri, 2016-01-15 at 16:04 +1100, Cyril Bur wrote:  

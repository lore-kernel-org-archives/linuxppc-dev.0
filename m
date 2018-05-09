Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gv962WqgzF2MG
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 21:22:50 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id z4-v6so22524280pgu.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 May 2018 04:22:49 -0700 (PDT)
Date: Wed, 9 May 2018 21:22:26 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/64s/radix: reset mm_cpumask for single thread
 process when possible
Message-ID: <20180509212226.58cef9ee@roar.ozlabs.ibm.com>
In-Reply-To: <CAKTCnznBdZV5fBz4kQHuiiAYREB-CNKNobe2+R347r4=xOGO9Q@mail.gmail.com>
References: <20180509065613.14762-1-npiggin@gmail.com>
 <CAKTCnznBdZV5fBz4kQHuiiAYREB-CNKNobe2+R347r4=xOGO9Q@mail.gmail.com>
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

On Wed, 9 May 2018 18:23:48 +1000
Balbir Singh <bsingharora@gmail.com> wrote:

> On Wed, May 9, 2018 at 4:56 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> > When a single-threaded process has a non-local mm_cpumask and requires
> > a full PID tlbie invalidation, use that as an opportunity to reset the
> > cpumask back to the current CPU we're running on.
> >
> > No other thread can concurrently switch to this mm, because it must
> > have had a reference on mm_users before it could use_mm. mm_users can
> > be asynchronously incremented e.g., by mmget_not_zero, but those users
> > must not be doing use_mm.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/include/asm/mmu_context.h | 19 +++++++++
> >  arch/powerpc/include/asm/tlb.h         |  8 ++++
> >  arch/powerpc/mm/tlb-radix.c            | 57 +++++++++++++++++++-------
> >  3 files changed, 70 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> > index 1835ca1505d6..df12a994529f 100644
> > --- a/arch/powerpc/include/asm/mmu_context.h
> > +++ b/arch/powerpc/include/asm/mmu_context.h
> > @@ -6,6 +6,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/mm.h>
> >  #include <linux/sched.h>
> > +#include <linux/sched/mm.h>
> >  #include <linux/spinlock.h>
> >  #include <asm/mmu.h>
> >  #include <asm/cputable.h>
> > @@ -201,6 +202,24 @@ static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
> >  static inline void enter_lazy_tlb(struct mm_struct *mm,
> >                                   struct task_struct *tsk)
> >  {
> > +#ifdef CONFIG_PPC_BOOK3S_64
> > +       /*
> > +        * Under radix, we do not want to keep lazy PIDs around because
> > +        * even if the CPU does not access userspace, it can still bring
> > +        * in translations through speculation and prefetching.
> > +        *
> > +        * Switching away here allows us to trim back the mm_cpumask in
> > +        * cases where we know the process is not running on some CPUs
> > +        * (see mm/tlb-radix.c).
> > +        */
> > +       if (radix_enabled() && mm != &init_mm) {
> > +               mmgrab(&init_mm);  
> 
> This is called when a kernel thread decides to unuse a mm, I agree switching
> to init_mm as active_mm is reasonable thing to do.

We lose lazy PIDR switching. Should probably ifdef CONFIG_SMP it, and
possibly one day we could look into having an arch notification for
scheduler migrating tasks so we could restore the optimisation.

For now I could not measure a cost, but it will be a few cycles.

> 
> > +               tsk->active_mm = &init_mm;  
> 
> Are we called with irqs disabled? Don't we need it below?

Hmm, yeah you might be right.

> > +               switch_mm_irqs_off(mm, tsk->active_mm, tsk);
> > +               mmdrop(mm);
> > +       }
> > +#endif
> > +
> >         /* 64-bit Book3E keeps track of current PGD in the PACA */
> >  #ifdef CONFIG_PPC_BOOK3E_64
> >         get_paca()->pgd = NULL;
> > diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
> > index a7eabff27a0f..006fce98c403 100644
> > --- a/arch/powerpc/include/asm/tlb.h
> > +++ b/arch/powerpc/include/asm/tlb.h
> > @@ -76,6 +76,14 @@ static inline int mm_is_thread_local(struct mm_struct *mm)
> >                 return false;
> >         return cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm));
> >  }
> > +static inline void mm_reset_thread_local(struct mm_struct *mm)  
> reset_thread_local --> reset_to_thread_local?
> 
> > +{
> > +       WARN_ON(atomic_read(&mm->context.copros) > 0);  
> 
> Can we put this under DEBUG_VM, VM_WARN_ON?

Yeah we could, I worry nobody tests with them on...

> 
> > +       WARN_ON(!(atomic_read(&mm->mm_users) == 1 && current->mm == mm));  
> 
> 
> 
> > +       atomic_set(&mm->context.active_cpus, 1);
> > +       cpumask_clear(mm_cpumask(mm));
> > +       cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
> > +}
> >  #else /* CONFIG_PPC_BOOK3S_64 */
> >  static inline int mm_is_thread_local(struct mm_struct *mm)
> >  {
> > diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> > index 5ac3206c51cc..d5593a78702a 100644
> > --- a/arch/powerpc/mm/tlb-radix.c
> > +++ b/arch/powerpc/mm/tlb-radix.c
> > @@ -504,6 +504,15 @@ void radix__local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmadd
> >  }
> >  EXPORT_SYMBOL(radix__local_flush_tlb_page);
> >
> > +static bool mm_is_singlethreaded(struct mm_struct *mm)
> > +{  
> 
> mm_tlb_context_is_local?

It's not the same thing as _local. _local means only local TLBs.
_singlethreaded means only this thread can access the mappings.

> We should also skip init_mm from these checks

I don't think we should see init_mm here ever -- it has no user
mappings so won't get this user tlb flushing.

> 
> > +       if (atomic_read(&mm->context.copros) > 0)
> > +               return false;
> > +       if (atomic_read(&mm->mm_users) == 1 && current->mm == mm)
> > +               return true;
> > +       return false;
> > +}
> > +
> >  static bool mm_needs_flush_escalation(struct mm_struct *mm)
> >  {
> >         /*
> > @@ -511,7 +520,9 @@ static bool mm_needs_flush_escalation(struct mm_struct *mm)
> >          * caching PTEs and not flushing them properly when
> >          * RIC = 0 for a PID/LPID invalidate
> >          */
> > -       return atomic_read(&mm->context.copros) != 0;
> > +       if (atomic_read(&mm->context.copros) > 0)
> > +               return true;
> > +       return false;
> >  }
> >
> >  #ifdef CONFIG_SMP
> > @@ -525,12 +536,17 @@ void radix__flush_tlb_mm(struct mm_struct *mm)
> >
> >         preempt_disable();
> >         if (!mm_is_thread_local(mm)) {
> > -               if (mm_needs_flush_escalation(mm))
> > +               if (mm_is_singlethreaded(mm)) {
> >                         _tlbie_pid(pid, RIC_FLUSH_ALL);
> > -               else
> > +                       mm_reset_thread_local(mm);
> > +               } else if (mm_needs_flush_escalation(mm)) {
> > +                       _tlbie_pid(pid, RIC_FLUSH_ALL);
> > +               } else {
> >                         _tlbie_pid(pid, RIC_FLUSH_TLB);
> > -       } else
> > +               }
> > +       } else {
> >                 _tlbiel_pid(pid, RIC_FLUSH_TLB);
> > +       }
> >         preempt_enable();
> >  }
> >  EXPORT_SYMBOL(radix__flush_tlb_mm);
> > @@ -544,10 +560,13 @@ void radix__flush_all_mm(struct mm_struct *mm)
> >                 return;
> >
> >         preempt_disable();
> > -       if (!mm_is_thread_local(mm))
> > +       if (!mm_is_thread_local(mm)) {
> >                 _tlbie_pid(pid, RIC_FLUSH_ALL);
> > -       else
> > +               if (mm_is_singlethreaded(mm))
> > +                       mm_reset_thread_local(mm);
> > +       } else {
> >                 _tlbiel_pid(pid, RIC_FLUSH_ALL);
> > +       }
> >         preempt_enable();
> >  }
> >  EXPORT_SYMBOL(radix__flush_all_mm);
> > @@ -644,10 +663,14 @@ void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
> >                 if (local) {
> >                         _tlbiel_pid(pid, RIC_FLUSH_TLB);
> >                 } else {
> > -                       if (mm_needs_flush_escalation(mm))
> > +                       if (mm_is_singlethreaded(mm)) {
> > +                               _tlbie_pid(pid, RIC_FLUSH_ALL);
> > +                               mm_reset_thread_local(mm);
> > +                       } else if (mm_needs_flush_escalation(mm)) {
> >                                 _tlbie_pid(pid, RIC_FLUSH_ALL);
> > -                       else
> > +                       } else {
> >                                 _tlbie_pid(pid, RIC_FLUSH_TLB);
> > +                       }
> >                 }
> >         } else {
> >                 bool hflush = false;
> > @@ -802,13 +825,19 @@ static inline void __radix__flush_tlb_range_psize(struct mm_struct *mm,
> >         }
> >
> >         if (full) {
> > -               if (!local && mm_needs_flush_escalation(mm))
> > -                       also_pwc = true;
> > -
> > -               if (local)
> > +               if (local) {
> >                         _tlbiel_pid(pid, also_pwc ? RIC_FLUSH_ALL : RIC_FLUSH_TLB);
> > -               else
> > -                       _tlbie_pid(pid, also_pwc ? RIC_FLUSH_ALL: RIC_FLUSH_TLB);
> > +               } else {
> > +                       if (mm_is_singlethreaded(mm)) {
> > +                               _tlbie_pid(pid, RIC_FLUSH_ALL);
> > +                               mm_reset_thread_local(mm);
> > +                       } else {
> > +                               if (mm_needs_flush_escalation(mm))
> > +                                       also_pwc = true;
> > +
> > +                               _tlbie_pid(pid, also_pwc ? RIC_FLUSH_ALL : RIC_FLUSH_TLB);
> > +                       }
> > +               }
> >         } else {
> >                 if (local)
> >                         _tlbiel_va_range(start, end, pid, page_size, psize, also_pwc);  
> 
> 
> Looks good otherwise

Thanks,
Nick

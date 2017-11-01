Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRbzT20wxzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Nov 2017 16:16:19 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id l24so1159912pgu.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 22:16:18 -0700 (PDT)
Date: Wed, 1 Nov 2017 16:16:07 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 6/7] powerpc/64s/radix: reset mm_cpumask for single
 thread process when possible
Message-ID: <20171101161607.5f5098e2@roar.ozlabs.ibm.com>
In-Reply-To: <CAKTCnzk_PLJ3F6WyK2h9b+vdLAz33H6cOhNoUc+fZjpvHGQCnw@mail.gmail.com>
References: <20171031064432.25190-1-npiggin@gmail.com>
 <20171031071828.28448-1-npiggin@gmail.com>
 <CAKTCnzk_PLJ3F6WyK2h9b+vdLAz33H6cOhNoUc+fZjpvHGQCnw@mail.gmail.com>
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

On Wed, 1 Nov 2017 16:09:39 +1100
Balbir Singh <bsingharora@gmail.com> wrote:

> On Tue, Oct 31, 2017 at 6:18 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> > When a single-threaded process has a non-local mm_cpumask and requires
> > a full PID tlbie invalidation, use that as an opportunity to reset the
> > cpumask back to the current CPU we're running on.
> >
> > There is a lot of tuning we can do with this, and more sophisticated
> > management of PIDs and stale translations across CPUs, but this is
> > something simple that can be done to significantly help single threaded
> > processes without changing behaviour too much.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/include/asm/mmu_context.h | 19 +++++++++++++
> >  arch/powerpc/mm/tlb-radix.c            | 52 +++++++++++++++++++++++++++-------
> >  2 files changed, 60 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> > index 20eae6f76247..05516027fd82 100644
> > --- a/arch/powerpc/include/asm/mmu_context.h
> > +++ b/arch/powerpc/include/asm/mmu_context.h
> > @@ -5,6 +5,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/mm.h>
> >  #include <linux/sched.h>
> > +#include <linux/sched/mm.h>
> >  #include <linux/spinlock.h>
> >  #include <asm/mmu.h>
> >  #include <asm/cputable.h>
> > @@ -153,6 +154,24 @@ static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
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
> > +               tsk->active_mm = &init_mm;
> > +               switch_mm_irqs_off(mm, tsk->active_mm, tsk);
> > +               mmdrop(mm);
> > +       }
> > +#endif
> > +  
> 
> I thought we did not use enter_lazy_tlb for anything. Even unuse_mm() is not
> called from common paths, do we care?

Yes the core code uses this when switching to a kernel thread.

> 
> >         /* 64-bit Book3E keeps track of current PGD in the PACA */
> >  #ifdef CONFIG_PPC_BOOK3E_64
> >         get_paca()->pgd = NULL;
> > diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> > index 49cc581a31cd..db7e696e4faf 100644
> > --- a/arch/powerpc/mm/tlb-radix.c
> > +++ b/arch/powerpc/mm/tlb-radix.c
> > @@ -255,10 +255,18 @@ void radix__flush_tlb_mm(struct mm_struct *mm)
> >                 return;
> >
> >         preempt_disable();
> > -       if (!mm_is_thread_local(mm))
> > -               _tlbie_pid(pid, RIC_FLUSH_TLB);
> > -       else
> > +       if (!mm_is_thread_local(mm)) {
> > +               if (atomic_read(&mm->mm_users) == 1 && current->mm == mm) {
> > +                       _tlbie_pid(pid, RIC_FLUSH_ALL);
> > +                       atomic_set(&mm->context.active_cpus, 1);
> > +                       cpumask_clear(mm_cpumask(mm));  
> 
> I wonder if we can delegate this back to switch_mm_irqs_off() to lazily clear
> the previous cpumask and check for changes to the current mask

Yeah there are some interesting concerns here we have to flesh out more.
I think the first 5 patches in the series are reasonable and they don't
really change behaviour fundamentally except to better match the radix
tlbie instructions to the primitives we implement.

This one needs more work for sure :P

Thanks,
Nick

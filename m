Return-Path: <cyrilbur@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJBqC0xLBzDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 10:57:10 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id g202so7216520pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 17:57:10 -0700 (PDT)
Message-ID: <1471913823.758.21.camel@gmail.com>
Subject: Re: [PATCH v3 02/21] powerpc: Always restore FPU/VEC/VSX if
 hardware transactional memory in use
From: Cyril Bur <cyrilbur@gmail.com>
To: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 wei.guo.simon@gmail.com
Cc: anton@samba.org
Date: Tue, 23 Aug 2016 10:57:03 +1000
In-Reply-To: <1471588405.5780.116.camel@neuling.org>
References: <20160817034323.23053-1-cyrilbur@gmail.com>
 <20160817034323.23053-3-cyrilbur@gmail.com>
 <1471588405.5780.116.camel@neuling.org>
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

On Fri, 2016-08-19 at 16:33 +1000, Michael Neuling wrote:
> On Wed, 2016-08-17 at 13:43 +1000, Cyril Bur wrote:
> > 
> > Comment from arch/powerpc/kernel/process.c:967:
> >  If userspace is inside a transaction (whether active or
> >  suspended) and FP/VMX/VSX instructions have ever been enabled
> >  inside that transaction, then we have to keep them enabled
> >  and keep the FP/VMX/VSX state loaded while ever the transaction
> >  continues.  The reason is that if we didn't, and subsequently
> >  got a FP/VMX/VSX unavailable interrupt inside a transaction,
> >  we don't know whether it's the same transaction, and thus we
> >  don't know which of the checkpointed state and the ransactional
> >  state to use.
> > 
> > restore_math() restore_fp() and restore_altivec() currently may not
> > restore the registers. It doesn't appear that this is more serious
> > than a performance penalty. If the math registers aren't restored
> > the
> > userspace thread will still be run with the facility disabled.
> > Userspace will not be able to read invalid values. On the first
> > access
> > it will take an facility unavailable exception and the kernel will
> > detected an active transaction, at which point it will abort the
> > transaction. There is the possibility for a pathological case
> > preventing any progress by transactions, however, transactions
> > are never guaranteed to make progress.
> > 
> > Fixes: 70fe3d9 ("powerpc: Restore FPU/VEC/VSX if previously used")
> > Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> > ---
> >  arch/powerpc/kernel/process.c | 21 ++++++++++++++++++---
> >  1 file changed, 18 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/process.c
> > b/arch/powerpc/kernel/process.c
> > index 58ccf86..cdf2d20 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -88,7 +88,13 @@ static void check_if_tm_restore_required(struct
> > task_struct *tsk)
> >  		set_thread_flag(TIF_RESTORE_TM);
> >  	}
> >  }
> > +
> > +static inline bool msr_tm_active(unsigned long msr)
> > +{
> > +	return MSR_TM_ACTIVE(msr);
> > +}
> 
> I'm not sure what value this function is adding.  The MSR_TM_ACTIVE()
> is
> used in a lot of other places and is well known so I'd prefer to just
> keep
> using it, rather than adding some other abstraction that others have
> to
> learn.
> 

Admitedly right now it does seem silly, I want to add inlines to tm.h
to replace the macros so that we can stop having #ifdef CONFIG_TM...
everywhere and use the inlines which will work regardless of
CONFIG_TM..., I was going to add that patch to this series but it got a
bit long and I really just want to get this series finished. Happy to
replace with with more MSR_TM_ACTIVE() with #ifdefs for now...

Overall it is mostly a solution for the fact that I keep using these
macros in 32bit and 64bit code and every time forget the #ifdef...

> Other than that, the patch seems good.  
> 
> Mikey
> 
> > 
> >  #else
> > +static inline bool msr_tm_active(unsigned long msr) { return
> > false; }
> >  static inline void check_if_tm_restore_required(struct task_struct
> > *tsk)
> > { }
> >  #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
> >  
> > @@ -208,7 +214,7 @@ void enable_kernel_fp(void)
> >  EXPORT_SYMBOL(enable_kernel_fp);
> >  
> >  static int restore_fp(struct task_struct *tsk) {
> > -	if (tsk->thread.load_fp) {
> > +	if (tsk->thread.load_fp || msr_tm_active(tsk->thread.regs-
> > >msr)) 
> > {
> >  		load_fp_state(&current->thread.fp_state);
> >  		current->thread.load_fp++;
> >  		return 1;
> > @@ -278,7 +284,8 @@ EXPORT_SYMBOL_GPL(flush_altivec_to_thread);
> >  
> >  static int restore_altivec(struct task_struct *tsk)
> >  {
> > -	if (cpu_has_feature(CPU_FTR_ALTIVEC) && tsk-
> > >thread.load_vec) {
> > +	if (cpu_has_feature(CPU_FTR_ALTIVEC) &&
> > +		(tsk->thread.load_vec || msr_tm_active(tsk-
> > >thread.regs-
> > > 
> > > msr))) {
> >  		load_vr_state(&tsk->thread.vr_state);
> >  		tsk->thread.used_vr = 1;
> >  		tsk->thread.load_vec++;
> > @@ -464,7 +471,8 @@ void restore_math(struct pt_regs *regs)
> >  {
> >  	unsigned long msr;
> >  
> > -	if (!current->thread.load_fp && !loadvec(current->thread))
> > +	if (!msr_tm_active(regs->msr) &&
> > +		!current->thread.load_fp && !loadvec(current-
> > >thread))
> >  		return;
> >  
> >  	msr = regs->msr;
> > @@ -983,6 +991,13 @@ void restore_tm_state(struct pt_regs *regs)
> >  	msr_diff = current->thread.ckpt_regs.msr & ~regs->msr;
> >  	msr_diff &= MSR_FP | MSR_VEC | MSR_VSX;
> >  
> > +	/* Ensure that restore_math() will restore */
> > +	if (msr_diff & MSR_FP)
> > +		current->thread.load_fp = 1;
> > +#ifdef CONFIG_ALIVEC
> > +	if (cpu_has_feature(CPU_FTR_ALTIVEC) && msr_diff &
> > MSR_VEC)
> > +		current->thread.load_vec = 1;
> > +#endif
> >  	restore_math(regs);
> >  
> >  	regs->msr |= msr_diff;

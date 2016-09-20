Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdWcb0PdzzDsTW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 15:33:02 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id vz6so390249pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 22:33:02 -0700 (PDT)
Date: Tue, 20 Sep 2016 15:32:53 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64s: exception optimise MSR handling
Message-ID: <20160920153253.48086990@roar.ozlabs.ibm.com>
In-Reply-To: <87shsvrycz.fsf@concordia.ellerman.id.au>
References: <20160915090446.898-1-npiggin@gmail.com>
 <87shsvrycz.fsf@concordia.ellerman.id.au>
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

On Tue, 20 Sep 2016 14:25:48 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > mtmsrd with L=1 only affects MSR_EE and MSR_RI bits, and we always
> > know what state those bits are, so the kernel MSR does not need to be
> > loaded when modifying them.
> >
> > mtmsrd is often in the critical execution path, so avoiding dependency
> > on even L1 load is noticable. On a POWER8 this saves about 3 cycles
> > from the syscall path, and possibly a few from other exception returns
> > (not measured).  
> 
> This looks good in principle.
> 
> My worry is that these code paths have lots of assumptions about what's
> left in registers, so we may have a path somewhere which expects rX to
> contain PACAKMSR. Hence the review below ...
> 
> > diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> > index 6b8bc0d..585b9ca 100644
> > --- a/arch/powerpc/kernel/entry_64.S
> > +++ b/arch/powerpc/kernel/entry_64.S
> > @@ -139,7 +139,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
> >  #ifdef CONFIG_PPC_BOOK3E
> >  	wrteei	1
> >  #else
> > -	ld	r11,PACAKMSR(r13)
> > +	li	r11,MSR_RI
> >  	ori	r11,r11,MSR_EE
> >  	mtmsrd	r11,1
> >  #endif /* CONFIG_PPC_BOOK3E */  
> 
> 	/* We do need to set SOFTE in the stack frame or the return
> 	 * from interrupt will be painful
> 	 */
> 	li	r10,1
> 	std	r10,SOFTE(r1)
> 
> 	CURRENT_THREAD_INFO(r11, r1)
> 
> So that's one OK. r11 isn't used again until its clobbered here.
> 
> 
> > @@ -195,7 +195,6 @@ system_call:			/* label this so stack traces look sane */  
> 
> #ifdef CONFIG_PPC_BOOK3S
> 	/* No MSR:RI on BookE */
> 	andi.	r10,r8,MSR_RI
> 	beq-	unrecov_restore
> #endif
> 
> So at this point r10 == MSR_RI, otherwise we would have taken the branch.
> 
> 	/*
> 	 * Disable interrupts so current_thread_info()->flags can't change,
> 	 * and so that we don't get interrupted after loading SRR0/1.
> 	 */
> >  #ifdef CONFIG_PPC_BOOK3E
> >  	wrteei	0
> >  #else
> > -	ld	r10,PACAKMSR(r13)
> >  	/*
> >  	 * For performance reasons we clear RI the same time that we
> >  	 * clear EE. We only need to clear RI just before we restore r13
> >	 * below, but batching it with EE saves us one expensive mtmsrd call.
> >  	 * We have to be careful to restore RI if we branch anywhere from
> >  	 * here (eg syscall_exit_work).
> >  	 */
> > -	li	r9,MSR_RI
> > -	andc	r11,r10,r9
> > +	li	r11,0
> >  	mtmsrd	r11,1
> >  #endif /* CONFIG_PPC_BOOK3E */  
> 
> 	ld	r9,TI_FLAGS(r12)
> 	li	r11,-MAX_ERRNO
> 	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
> 	bne-	syscall_exit_work
> 
> Which is:
> 
> syscall_exit_work:
> #ifdef CONFIG_PPC_BOOK3S
> 	mtmsrd	r10,1		/* Restore RI */
> #endif
> 
> So that appears to still work. But it's super fragile.

Agreed. We'll go with the idea you mentioned offline to just load r10 again
here to avoid the long dependency -- it's not going to be a measurable cost.


> What I'd like to do is drop that optimisation of clearing RI early with
> EE. That would avoid us needing to restore RI in syscall_exit_work and
> before restore_math (and reclearing it after).
> 
> But I guess that will hurt performance too much :/

Yes that's something to look into. Newer cores, more kernel code using fp
registers. I'll look into it.

Thanks,
Nick

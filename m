Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 152031A0835
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jun 2014 20:03:36 +1000 (EST)
Message-ID: <1401876215.32587.58.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH 1/1] powerpc: correct DSCR during TM context switch
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 04 Jun 2014 20:03:35 +1000
In-Reply-To: <1401867077.9903.3.camel@concordia>
References: <f1ddc3bc4b970a480367a45cdca51e879cb14df0.1401852531.git.sam.bobroff@au1.ibm.com>
 <1401867077.9903.3.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Sam Bobroff <sam.bobroff@au1.ibm.com>, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-06-04 at 17:31 +1000, Michael Ellerman wrote:
> Hi Sam,
>=20
> Comments inline ..

Ditto....

>=20
> On Wed, 2014-06-04 at 13:33 +1000, Sam Bobroff wrote:
> > Correct the DSCR SPR becoming temporarily corrupted when a task is
> > context switched when within a transaction. It is corrected when
> > the transaction is aborted (which will happen after a context switch)
> > but if the task has suspended (TSUSPEND) the transaction the incorrect
> > value can be seen.
>=20
> I don't quite follow this description. How is it corrected when the trans=
action
> is aborted, and when does that usually happen? If that happens the task c=
an't
> ever see the corrupted value?
>=20
> To hit the suspended case, the task starts a transaction, suspends it, is=
 then
> context switched out and back in, and at that point it can see the wrong =
value?

Yep, that's it and it's corrupted until the transaction is rolled back
(normally at the tresume).  At the tresume it gets rolled back to the
checkpointed value at tbegin and is no longer corrupt.

> > The problem is caused by saving a thread's DSCR afterNo it's lost at th=
at point as we've not saved it and it was overwritten when we did the trecl=
aim.   it has already
> > been reverted to the CPU's default value:
> >=20
> > __switch_to() calls __switch_to_tm()
> > 	which calls tm_reclaim_task()
> > 	which calls tm_reclaim_thread()
> > 	which calls tm_reclaim() where the DSCR is reset
>=20
> Where the DSCR is set to DSCR_DEFAULT ? Or now PACA_DSCR since your previ=
ous
> patches?
>=20
> Could we instead fix the bug there by reverting to the thread's DSCR valu=
e?

We really need to save it earlier, before the treclaim which will
override it.

> > __switch_to() calls _switch
> > 	_switch() saves the DSCR to thread.dscrTBEGIN
> >=20
> > The fix is to treat the DSCR similarly to the TAR and save it early
> > in __switch_to().
> >=20
> > The program below will expose the problem:
>=20
>=20
> Can you drop this in tools/testing/selftests/powerpc/tm ?
>=20
> You'll need to create that directory, you can ape the Makefile from the p=
mu
> directory, it should be fairly obvious. See the pmu tests for how to inte=
grate
> with the test harness etc., or bug me if it's not straight forward.
>=20
>=20
> > diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/includ=
e/asm/switch_to.h
> > index 2737f46..3efd0e5 100644
> > --- a/arch/powerpc/include/asm/switch_to.h
> > +++ b/arch/powerpc/include/asm/switch_to.h
> > @@ -16,13 +16,15 @@ struct thread_struct;
> >  extern struct task_struct *_switch(struct thread_struct *prev,
> >  				   struct thread_struct *next);
> >  #ifdef CONFIG_PPC_BOOK3S_64
> > -static inline void save_tar(struct thread_struct *prev)
> > +static inline void save_early_sprs(struct thread_struct *prev)
> >  {
> >  	if (cpu_has_feature(CPU_FTR_ARCH_207S))
> >  		prev->tar =3D mfspr(SPRN_TAR);
> > +	if (cpu_has_feature(CPU_FTR_DSCR))
> > +		prev->dscr =3D mfspr(SPRN_DSCR);
> >  }
>=20
> Are we going to end up saving more SPRs in this code? What makes the TAR =
& DSCR
> special vs everything else?

There are only a limited set of SPRs that TM checkpoints.  The full list
is CR, LR, CTR, FPSCR, AMR, PPR, VRSAVE, VSCR, DSCR, and TAR. =20

http://www.scribd.com/doc/142877680/PowerISA-v2-07#outer_page_826

CR, LR, CTR, PPR are handled really early in the exception handler

FPSCR, VSCR are done in the FP/VMX/VSX code.

AMR we don't care about.

That just leaves the DSCR and the TAR for here....

... and the VRSAVE.  Sam: did you have a patch to save that one early
too?  I think we talked about it but forgot, or did we decide that it's
always broken anyway so we don't care? :-D

Mikey

> The nice thing about doing this in asm is it's nop'ed out for cpus that d=
on't
> have the DSCR. What does the generated code for this look like?
>=20
> > diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry=
_64.S
> > index 662c6dd..a107f4a 100644
> > --- a/arch/powerpc/kernel/entry_64.S
> > +++ b/arch/powerpc/kernel/entry_64.S
> > @@ -432,12 +432,6 @@ BEGIN_FTR_SECTION
> >  	std	r24,THREAD_VRSAVE(r3)
> >  END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
> >  #endif /* CONFIG_ALTIVEC */
> > -#ifdef CONFIG_PPC64
> > -BEGIN_FTR_SECTION
> > -	mfspr	r25,SPRN_DSCR
> > -	std	r25,THREAD_DSCR(r3)
> > -END_FTR_SECTION_IFSET(CPU_FTR_DSCR)
> > -#endif
> >  	and.	r0,r0,r22
> >  	beq+	1f
> >  	andc	r22,r22,r0
>=20
>=20
> cheers
>=20
>=20

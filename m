Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlpzN1cdvzDqYv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 16:27:44 +1100 (AEDT)
Message-ID: <1519104463.5655.4.camel@neuling.org>
Subject: Re: [RFC PATCH 10/12] [WIP] powerpc/tm: Correctly save/restore
 checkpointed sprs
From: Michael Neuling <mikey@neuling.org>
To: Cyril Bur <cyrilbur@gmail.com>, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 20 Feb 2018 16:27:43 +1100
In-Reply-To: <1519099169.6563.19.camel@gmail.com>
References: <20180220002241.29648-1-cyrilbur@gmail.com>
 <20180220002241.29648-11-cyrilbur@gmail.com>
 <1519095630.7360.57.camel@neuling.org> <1519099169.6563.19.camel@gmail.com>
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

On Tue, 2018-02-20 at 14:59 +1100, Cyril Bur wrote:
> On Tue, 2018-02-20 at 14:00 +1100, Michael Neuling wrote:
> > This needs a description of what you're trying to do.  "Correctly" does=
n't
> > really mean anything.
> >=20
> >=20
> > On Tue, 2018-02-20 at 11:22 +1100, Cyril Bur wrote:
> > > ---
> > >  arch/powerpc/kernel/process.c | 57 +++++++++++++++++++++++++++++++++=
++++++++-
> > > -
> > >  arch/powerpc/kernel/ptrace.c  |  9 +++----
> > >  2 files changed, 58 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/proc=
ess.c
> > > index cd3ae80a6878..674f75c56172 100644
> > > --- a/arch/powerpc/kernel/process.c
> > > +++ b/arch/powerpc/kernel/process.c
> > > @@ -859,6 +859,8 @@ static inline bool tm_enabled(struct task_struct =
*tsk)
> > >  	return tsk && tsk->thread.regs && (tsk->thread.regs->msr & MSR_TM);
> > >  }
> > > =20
> > > +static inline void save_sprs(struct thread_struct *t);
> > > +
> > >  static void tm_reclaim_thread(struct thread_struct *thr, uint8_t cau=
se)
> > >  {
> > >  	/*
> > > @@ -879,6 +881,8 @@ static void tm_reclaim_thread(struct thread_struc=
t *thr,
> > > uint8_t cause)
> > >  	if (!MSR_TM_SUSPENDED(mfmsr()))
> > >  		return;
> > > =20
> > > +	save_sprs(thr);
> > > +
> > >  	giveup_all(container_of(thr, struct task_struct, thread));
> > > =20
> > >  	tm_reclaim(thr, cause);
> > > @@ -991,6 +995,37 @@ void tm_recheckpoint(struct thread_struct *threa=
d)
> > > =20
> > >  	__tm_recheckpoint(thread);
> > > =20
> > > +	/*
> > > +	 * This is a stripped down restore_sprs(), we need to do this
> > > +	 * now as we might go straight out to userspace and currently
> > > +	 * the checkpointed values are on the CPU.
> > > +	 *
> > > +	 * TODO: Improve
> > > +	 */
> > > +#ifdef CONFIG_ALTIVEC
> > > +	if (cpu_has_feature(CPU_FTR_ALTIVEC))
> > > +		mtspr(SPRN_VRSAVE, thread->vrsave);
> > > +#endif
> > > +#ifdef CONFIG_PPC_BOOK3S_64
> > > +	if (cpu_has_feature(CPU_FTR_DSCR)) {
> > > +		u64 dscr =3D get_paca()->dscr_default;
> > > +		if (thread->dscr_inherit)
> > > +			dscr =3D thread->dscr;
> > > +
> > > +		mtspr(SPRN_DSCR, dscr);
> > > +	}
> > > +
> > > +	if (cpu_has_feature(CPU_FTR_ARCH_207S)) {
> > > +		/* The EBB regs aren't checkpointed */
> > > +		mtspr(SPRN_FSCR, thread->fscr);
> > > +
> > > +		mtspr(SPRN_TAR, thread->tar);
> > > +	}
> > > +
> > > +	/* I think we don't need to */
> > > +	if (cpu_has_feature(CPU_FTR_ARCH_300))
> > > +		mtspr(SPRN_TIDR, thread->tidr);
> > > +#endif
> >=20
> > Why are you touching all the above hunk?
>=20
> I copied restore_sprs. I'm tidying that up now - we can't call
> restore_sprs because we don't have a prev and next thread.

Yeah needs to be tided up... we can't have another copy of the code.. obvio=
usly.

>=20
> >=20
> > >  	local_irq_restore(flags);
> > >  }
> > > =20
> > > @@ -1193,6 +1228,11 @@ struct task_struct *__switch_to(struct task_st=
ruct
> > > *prev,
> > >  #endif
> > > =20
> > >  	new_thread =3D &new->thread;
> > > +	/*
> > > +	 * Why not &prev->thread; ?
> > > +	 * What is the difference between &prev->thread and
> > > +	 * &current->thread ?
> > > +	 */
> >=20
> > Why not just work it out and FIX THE CODE, rather than just rabbiting o=
n about
> > it! :-P
>=20
> Agreed - I started to and then had a mini freakout that things would
> end really badly if they're not the same. So I left that comment as a
> reminder to investigate.
>=20
> They should be the same though right?

Should be if prev =3D=3D current.

Mikey

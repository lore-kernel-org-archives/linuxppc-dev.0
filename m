Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 595541A039F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 21:30:46 +1100 (AEDT)
Message-ID: <1447756245.17316.112.camel@neuling.org>
Subject: Re: [PATCH 3/5] powerpc/tm: Block signal return setting invalid MSR
 state
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org
Cc: sam.bobroff@au1.ibm.com, linuxppc-dev@ozlabs.org, paulus@samba.org
Date: Tue, 17 Nov 2015 21:30:45 +1100
In-Reply-To: <1447668318.2191.10.camel@ellerman.id.au>
References: <1447390652-28355-1-git-send-email-mikey@neuling.org>
 <1447390652-28355-3-git-send-email-mikey@neuling.org>
 <1447668318.2191.10.camel@ellerman.id.au>
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

On Mon, 2015-11-16 at 21:05 +1100, Michael Ellerman wrote:
> On Fri, 2015-11-13 at 15:57 +1100, Michael Neuling wrote:
>=20
> > Currently we allow both the MSR T and S bits to be set by userspace
> > on
> > a signal return.  Unfortunately this is a reserved configuration
> > and
> > will cause a TM Bad Thing exception if attempted (via rfid).
> >=20
> > This patch checks for this case in both the 32 and 64bit signals
> > code.
> > If these are both set, we clear them and trigger the bad stack
> > frame
> > handling.
> >=20
> > Found using a syscall fuzzer.
> >=20
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
>=20
> Is this fixes line right?
>=20
> Fixes: 2b0a576d15e0 ("powerpc: Add new transactional memory state to
> the signal context")
>=20
> Which went into v3.9.
>=20
> In which case this:
>=20
> > Cc: stable@vger.kernel.org
>=20
> Should be:
>=20
> Cc: stable@vger.kernel.org # v3.9+

Ok.



>=20
> > diff --git a/arch/powerpc/include/asm/reg.h
> > b/arch/powerpc/include/asm/reg.h
> > index a908ada..2220f7a 100644
> > --- a/arch/powerpc/include/asm/reg.h
> > +++ b/arch/powerpc/include/asm/reg.h
> > @@ -108,6 +108,7 @@
> >  #define MSR_TS_T	__MASK(MSR_TS_T_LG)	/*  Transaction
> > Transactional */
> >  #define MSR_TS_MASK	(MSR_TS_T | MSR_TS_S)   /* Transaction
> > State bits */
> >  #define MSR_TM_ACTIVE(x) (((x) & MSR_TS_MASK) !=3D 0) /* Transaction
> > active? */
> > +#define MSR_TM_RESV(x) (((x) & MSR_TS_MASK) =3D=3D MSR_TS_MASK) /*
> > Reserved */
>=20
> Is reserved a good name? I think illegal/bad/wrong would be more
> helpful,
> though I haven't checked the arch to see if it uses "reserved".

It does actually call it "reserved".  In the description of the Machine
State Register, it has a little table and calls 0b11 reserved.


>=20
> >  #define MSR_TM_TRANSACTIONAL(x)	(((x) & MSR_TS_MASK) =3D=3D
> > MSR_TS_T)
> >  #define MSR_TM_SUSPENDED(x)	(((x) & MSR_TS_MASK) =3D=3D
> > MSR_TS_S)
> > =20
> > diff --git a/arch/powerpc/kernel/signal_32.c
> > b/arch/powerpc/kernel/signal_32.c
> > index 0dbee46..5b519c7 100644
> > --- a/arch/powerpc/kernel/signal_32.c
> > +++ b/arch/powerpc/kernel/signal_32.c
> > @@ -874,7 +874,16 @@ static long restore_tm_user_regs(struct
> > pt_regs *regs,
> >  		       + ELF_NEVRREG))
> >  		return 1;
> >  #endif /* CONFIG_SPE */
> > -
>=20
> I know you didn't start the rot here, but can you please use your
> newline key a
> bit more :D

ok, newline boy!

> > +	/* Get the top half of the MSR */
>=20
> "top" scares me now that we have both kinds of endian, but you're
> just moving
> that code anyway, and it is sane because it's a 32-bit value that we
> explicitly
> put the top half of the 64-bit MSR in.

Yeah, this code is just moved from below.  It needs to be run earlier
for this new test.

... and yes, this whole signals code (inside and out TM) needs a good sprin=
g clean.

> > +	if (__get_user(msr_hi, &tm_sr->mc_gregs[PT_MSR]))
> > +		return 1;
>=20
> > +	/* Pull in MSR TM from user context */
> > +	regs->msr =3D (regs->msr & ~MSR_TS_MASK) | ((msr_hi<<32) &
> > MSR_TS_MASK);
>=20
> Using a tmp variable would be safer.


> > +	/* Don't let the user set both TM bits */
> > +	if (MSR_TM_RESV(regs->msr)) {
> > +		regs->msr &=3D ~MSR_TS_MASK;
>=20
> And avoid the clear here.
>=20
> > +		return 1;
> > +	}
>=20
> At the (minor) expense of an assignment here to regs->msr.

Ok, I'll make that tmp variable cleanup

> > @@ -884,11 +893,6 @@ static long restore_tm_user_regs(struct
> > pt_regs *regs,
> >  	current->thread.tm_texasr |=3D TEXASR_FS;
> >  	/* This loads the checkpointed FP/VEC state, if used */
> >  	tm_recheckpoint(&current->thread, msr);
> > -	/* Get the top half of the MSR */
> > -	if (__get_user(msr_hi, &tm_sr->mc_gregs[PT_MSR]))
> > -		return 1;
> > -	/* Pull in MSR TM from user context */
> > -	regs->msr =3D (regs->msr & ~MSR_TS_MASK) | ((msr_hi<<32) &
> > MSR_TS_MASK);
> > =20
> >  	/* This loads the speculative FP/VEC state, if used */
> >  	if (msr & MSR_FP) {
> > diff --git a/arch/powerpc/kernel/signal_64.c
> > b/arch/powerpc/kernel/signal_64.c
> > index 20756df..b320689 100644
> > --- a/arch/powerpc/kernel/signal_64.c
> > +++ b/arch/powerpc/kernel/signal_64.c
> > @@ -438,6 +438,12 @@ static long restore_tm_sigcontexts(struct
> > pt_regs *regs,
> > =20
> >  	/* get MSR separately, transfer the LE bit if doing signal
> > return */
> >  	err |=3D __get_user(msr, &sc->gp_regs[PT_MSR]);
> > +	/* Don't allow reserved mode. */
> > +	if (MSR_TM_RESV(msr)) {
> > +		msr &=3D ~MSR_TS_MASK;
>=20
> Why are you clearing the bits before returning, it's a local isn't
> it?

You're right, my bad.

Mikey

>=20
> > +		return -EINVAL;
> > +	}
> > +
> >  	/* pull in MSR TM from user context */
> >  	regs->msr =3D (regs->msr & ~MSR_TS_MASK) | (msr &
> > MSR_TS_MASK);
> > =20
>=20
> cheers
>=20

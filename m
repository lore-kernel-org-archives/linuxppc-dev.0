Return-Path: <ebony.zhu@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 4B106DDE27
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 20:06:59 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l1896tEO009827
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Feb 2007 02:06:55 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l1896qxs028848
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Feb 2007 03:06:53 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch][5/5] powerpc V2: Add the general support for Embedded
	Floating-Point instructions
Date: Thu, 8 Feb 2007 17:06:50 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E8B7E97@zch01exm20.fsl.freescale.net>
In-Reply-To: <A726EA39-8CA7-418D-BF07-E33A127FFB50@kernel.crashing.org>
From: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Thursday, February 08, 2007 3:33 PM
> To: Zhu Ebony-r57400
> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [patch][5/5] powerpc V2: Add the general support=20
> for Embedded Floating-Point instructions
>=20
>=20
> On Feb 7, 2007, at 9:55 PM, ebony.zhu@freescale.com wrote:
>=20
> > Add the general support for Embedded Floating-Point instructions to=20
> > fully comply with IEEE-754.
> >
> > Signed-off-by:Ebony Zhu <ebony.zhu@freescale.com>
> > ---
> >  arch/powerpc/kernel/head_fsl_booke.S |    4
> >  arch/powerpc/kernel/traps.c          |   57 +++++
> >  arch/powerpc/math-emu/Makefile       |   25 ++
> >  arch/powerpc/math-emu/sfp-machine.h  |    2
> >  arch/powerpc/math-emu/spe.h          |    1
> >  arch/powerpc/sysdev/Makefile         |    1
> >  arch/powerpc/sysdev/sigfpe_handler.c |  361 +++++++++++++++++++++++
> > +++++++++++
> >  7 files changed, 442 insertions(+), 9 deletions(-)
>=20
> I thought we were going to have some general Kconfig option=20
> to enable all this?  EMDEDDED_FP_IEEE or something like that

So that users have chance to enable/disable fully IEEE compliance?
Segher
had mentioned this, and it sounds reasonable.=20

>=20
> >
> > diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/=20
> > kernel/head_fsl_booke.S
> > index 66877bd..0d05db0 100644
> > --- a/arch/powerpc/kernel/head_fsl_booke.S
> > +++ b/arch/powerpc/kernel/head_fsl_booke.S
> > @@ -705,7 +705,7 @@ #else
> >  #endif /* CONFIG_SPE */
> >
> >  	/* SPE Floating Point Round */
> > -	EXCEPTION(0x2050, SPEFloatingPointRound, unknown_exception, =20
> > EXC_XFER_EE)
> > +	EXCEPTION(0x2050, SPEFloatingPointRound, =20
> > SPEFloatingPointException_Round, EXC_XFER_EE)
> >
> >  	/* Performance Monitor */
> >  	EXCEPTION(0x2060, PerformanceMonitor, =20
> > performance_monitor_exception, EXC_XFER_STD)
> > @@ -840,6 +840,8 @@ load_up_spe:
> >  	oris	r5,r5,MSR_SPE@h
> >  	mtmsr	r5			/* enable use of SPE now */
> >  	isync
> > +	li	r5,(SPEFSCR_FINVE | SPEFSCR_FDBZE | SPEFSCR_FUNFE | =20
> > SPEFSCR_FOVFE)
> > +	mtspr   SPRN_SPEFSCR,r5
>=20
> We should do this via INIT_THREAD, is there a reason that you=20
> want to =20
> set these always?

I just thought it's the first time that an SPE instruction is
encountered, so I
enable the exceptions here.

>=20
> >  /*
> >   * For SMP, we don't do lazy SPE switching because it just gets too
> >   * horrendously complex, especially when a task switches=20
> from one CPU
> > diff --git a/arch/powerpc/kernel/traps.c=20
> b/arch/powerpc/kernel/traps.c
> > index 6915b91..30ab0f7 100644
> > --- a/arch/powerpc/kernel/traps.c
> > +++ b/arch/powerpc/kernel/traps.c
> > @@ -986,9 +986,16 @@ #endif /* CONFIG_FSL_BOOKE */
> >  #ifdef CONFIG_SPE
> >  void SPEFloatingPointException(struct pt_regs *regs)
> >  {
> > +	extern int spedata_handler(struct pt_regs *regs);
> >  	unsigned long spefscr;
> >  	int fpexc_mode;
> >  	int code =3D 0;
> > +	int err;
> > +=09
> > +	preempt_disable();
> > +	if (regs->msr & MSR_SPE)
> > +		giveup_spe(current);
> > +	preempt_enable();
>=20
> use flush_spe_to_thread(current);

OK. It works, and I'll change it.

>=20
> >
> >  	spefscr =3D current->thread.spefscr;
> >  	fpexc_mode =3D current->thread.fpexc_mode;
> > @@ -1013,9 +1020,55 @@ void SPEFloatingPointException(struct pt
> >  		code =3D FPE_FLTRES;
> >
> >  	current->thread.spefscr =3D spefscr;
> > +	err =3D spedata_handler(regs);
> > +	if (err =3D=3D 0) {
> > +		regs->nip +=3D 4;		/* skip emulated instruction */
> > +		emulate_single_step(regs);
> > +		return;
> > +	}
>=20
> Take a look at the path I put up that reworks the error=20
> handling from =20
> do_mathemu() we need to be doing something similar (in parsing =20
> spefscr/fpexc_mode to setup code properly)

It's new in trap.c? I'll look into it.


>=20
> > -	_exception(SIGFPE, regs, code, regs->nip);
> > -	return;
> > +	if (err =3D=3D -EFAULT) {
> > +		/* got an error reading the instruction */
> > +		_exception(SIGSEGV, regs, SEGV_ACCERR, regs->nip);
> > +	} else if (err =3D=3D -EINVAL) {
> > +		/* didn't recognize the instruction */
> > +		printk(KERN_ERR "unrecognized spe instruction "
> > +		       "in %s at %lx\n", current->comm, regs->nip);
>=20
> We should probably just SIGSEGV in this case since will never make =20
> forward progress once we hit this case.

Won't it hit the case that the instruction is not an spe instruction?


> >
> > diff --git a/arch/powerpc/math-emu/Makefile=20
> b/arch/powerpc/math-emu/=20
> > Makefile
> > index 29bc912..2da11ba 100644
> > --- a/arch/powerpc/math-emu/Makefile
> > +++ b/arch/powerpc/math-emu/Makefile
> > @@ -1,16 +1,29 @@
> >
> > -obj-y				:=3D math.o fmr.o lfd.o stfd.o
> > -
> > -obj-$(CONFIG_MATH_EMULATION)	+=3D fabs.o fadd.o=20
> fadds.o fcmpo.o =20
> > fcmpu.o \
> > +obj-y				:=3D fabs.o fneg.o=20
> types.o udivmodti4.o
>=20
> This isn't right, we don't want to always build these files.
>=20
fabs.o/fneg.o should be built in the case
that CONFIG_MATH_EMULATION or CONFIG_SPE or both are
enabled. Because I reused fabs.c and fneg.c to implement instruction
efdabs and
efdneg. Therefore, these two files should be build once we have chance
to build the files in directory math-emu. Types.c and udivmodti4.c
contain the function
that both math emulation instructions and spe instructions may call, so
they always need
to be built.

B.R
Ebony

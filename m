Return-Path: <ebony.zhu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 46425DDE22
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 18:48:51 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l0F7mnYA025350
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 00:48:49 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0F7mkxx017510
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 01:48:48 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch][5/5] powerpc: Add the general support for Embedded
	Floating-Point instructions
Date: Mon, 15 Jan 2007 15:48:44 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E816BD2@zch01exm20.fsl.freescale.net>
In-Reply-To: <F723B551-5777-4697-A269-D3E1BA5B5421@kernel.crashing.org>
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


> >>
> >> Why do we need a separate ret_from_except_spe_full?
> >
> > I'm not sure if the kernel will return from exception in a multi-=20
> > thread way, but the truth is if restoring EVRs in exsiting=20
> > ret_from_except_full, some non-SPE exception will try to=20
> retore EVR.=20
> > At that time, the MSR[SPE] may not be enabled, which will=20
> cause error.
>=20
> Well, with EE disabled nothing is going to interrupt the=20
> exception thread, so you can do all this in C code.

Do you mean disabling MSR[EE] in handler C code before calling
ret_from_except_full?


> >>> diff --git a/arch/powerpc/kernel/traps.c
> >> b/arch/powerpc/kernel/traps.c
> >>> index 535f506..68407d4 100644
> >>> --- a/arch/powerpc/kernel/traps.c
> >>> +++ b/arch/powerpc/kernel/traps.c
> >>> @@ -986,6 +986,22 @@ #endif /* CONFIG_FSL_BOOKE */  #ifdef
> >> CONFIG_SPE
> >>> void SPEFloatingPointException(struct pt_regs *regs)  {
> >>> +#ifdef CONFIG_E500
> >>> +	extern int sigfpe_handler(struct pt_regs *regs);
> >>> +	int err;
> >>> +	if (current->thread.spefscr & ~0x3f) {
> >>> +		err =3D sigfpe_handler(regs);
> >>> +		if (err =3D=3D 0) {
> >>> +			regs->nip +=3D 4;
> >>> +			return;
> >>> +		} else {
> >>> +			current->thread.spefscr =3D 0x0;
> >>
> >> Why do clear spefscr and re-execute?
> >
> > I tried to make the code more robust here. Currently, all the SPE=20
> > instructions that may cause execption are handled. But=20
> someday if the=20
> > instruction set is extended and not supported by software,=20
> this code=20
> > can make sure we handle it with powerpc default value, which won't=20
> > make kernel crash.
>=20
> Lets worry about that when it occurs, its probably better=20
> that the apps crash and we fixup the kernel when it happens.

Currently err !=3D 0 won't happen on PQ3/PQ38 cores. So does it mean
that we can simplify the code here?


>=20
> >>> +			return;
> >>> +		}
> >>> +	} else {
> >>> +		return;
> >>
> >> How else would we get here if not by having spefscr bit set?
> >
> > As above, I want to make it more robust. If no unexpected condition=20
> > would happen, we can remove this off.
>=20
> Lets remove it since it shouldn't happen
>=20
OK, I will.

> >>> +	current->thread.spefscr &=3D 0x3f;
> >>
> >> can't clear spefscr this way.
> >>
> >> Need to do what the existing handler was doing here.
> >
> > Do you mean I need to do it like this:
> >
> > 	unsigned long spefscr;
> > 	spefscr =3D current->thread.spefscr;
> > 	spefscr =3D 0x3f;
> > 	current->spefscr =3D spefscr ;
> >
> > I'm not really understand...
>=20
> What I meant is the existing handler uses the=20
> thread.fpexc_mode to keep track of the "exception" flags that=20
> an application may want to enable as part of the STND-C fpenv=20
> support (find a copy of the ANSI spec and read up on=20
> Floating-point Environment).  The std c-lib provides=20
> functions like fesetexceptflag(), fetestexcept(), fesetround (), etc..
>=20
> Some of this will end up calling into set_fpexc_mode() in the=20
> kernel via the prctl system call.
>=20
> The idea was we use thread.fpexc_mode to keep track of what=20
> the C runtime env wants the flags to be, than in the=20
> exception handler we can use those flags to decide if we=20
> should raise an software SIGFPE exception on the process.
>=20
> So when you emulate the instructions you need to handle=20
> determining if a software SIGFPE should be sent or not.
>=20
> I hope that makes sense.
>=20
> - k
>=20

I see. By this way we can synchronize kernel and runtime environment
for floating point flags.  Is it a correct way that we use the existing
handler
to track exception flags and set current->thread.spefscr, then entering
sigfpe_handler()?

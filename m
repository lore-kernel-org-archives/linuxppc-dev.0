Return-Path: <ebony.zhu@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 133DADDE32
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 20:54:33 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l0G9sWg3025593
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 02:54:32 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l0G9sQPp027621
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 03:54:28 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Subject: RE: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Tue, 16 Jan 2007 17:54:25 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E816D7D@zch01exm20.fsl.freescale.net>
In-Reply-To: <2C8EB4AF-97B2-40F5-8112-0CEE6E3D4D42@kernel.crashing.org>
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
> Sent: 2007=C4=EA1=D4=C215=C8=D5 22:37
> To: Zhu Ebony-r57400
> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [patch][0/5] powerpc: Add support to fully=20
> comply with IEEE-754 standard
>=20
>=20
> On Jan 15, 2007, at 12:37 AM, Zhu Ebony-r57400 wrote:
>=20
> >
> >
> >> -----Original Message-----
> >> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> >> Sent: 2007=C4=EA1=D4=C213=C8=D5 02:36
> >> To: Zhu Ebony-r57400
> >> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> >> Subject: Re: [patch][0/5] powerpc: Add support to fully=20
> comply with=20
> >> IEEE-754 standard
> >>
> >>
> >> On Jan 12, 2007, at 2:09 AM, Zhu Ebony-r57400 wrote:
> >>
> >>>  Hi Kumar,
> >>>
> >>>> -----Original Message-----
> >>>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> >>>> Sent: 2007=C4=EA1=D4=C212=C8=D5 14:42
> >>>> To: Zhu Ebony-r57400
> >>>> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> >>>> Subject: Re: [patch][0/5] powerpc: Add support to fully
> >> comply with
> >>>> IEEE-754 standard
> >>>>
> >>>>
> >>>> On Jan 11, 2007, at 11:19 PM, Zhu Ebony-r57400 wrote:
> >>>>
> >>>>> Hi Paul,
> >>>>>
> >>>>> This series of patch add support to fully comply with IEEE-754=20
> >>>>> standard for E500/E500v2 core when hardware floating point
> >>>> compiling
> >>>>> is used.
> >>>>>
> >>>>> Ebony
> >>>>
> >>>> Here are some general comments:
> >>>> * We should be able to support math-emu (as it stands) and
> >> the fixup
> >>>> handling [you break math-emu]
> >>>
> >>> I don't think I break the math-emu. I think the codes I
> >> added have no
> >>> impact to the existing math-emu.
> >>
> >> This snippet of code breaks it from math-emu/sfp-machine.h
> >>
> >>>> +#ifdef CONFIG_SPE
> >>>> +#define __FPU_FPSCR	(current->thread.spefscr)
> >>>> +#else
> >>>>  #define __FPU_FPSCR	(current->thread.fpscr.val)
> >>>> +#endif
> >>
> >> By doing this if I want 'classic FP' emulation as well as the IEEE=20
> >> fixup my fpscr for classic emu will not be updated properly.
> >
> > Logically, user can choose "SPE Support" and "Math=20
> emulation" at the=20
> > same time on menuconfig. But from my understanding, it is not=20
> > necessary to select math-emu on a SPE available system,=20
> since SPE can=20
> > do math operation.
>=20
> This is not true.  If I want to run a "classic" PPC binary=20
> with FP I need "Math emulation" and if I want to run an SPE=20
> one I enable "SPE Support".  I could want to run both of=20
> these types of binaries on the same system at the same time.
>=20
So how about defining a separate macro for spefscr?

 #define  __FPU_SPEFSCR	(current->thread.spefscr)=20


> >>>> * Copyrights / header comments should give credit to the orig
> >>>> math- emu code
> >>> I'd like to do this, but in most handler codes, I can't find=20
> >>> copyright information of the orig authors. I think the=20
> math-emu code=20
> >>> comes from
> >> glibc. In
> >>> the
> >>> sigfpe_handler.c, I gave credit to the orig author.
> >>
> >> I think a comment is sufficient stating this is take from=20
> the math-=20
> >> emu code.
> >>
> >>>> * Why isn't there any handling of SPEFloatingPointRound=20
> exceptions?
> >>>
> >>> I think the SPEFloatingPointRound exception is not necessary to=20
> >>> handle if we handle floating point exception this way.
> >>
> >> I dont believe this, you'll have to explain if this is really true.
> >> But, I'm almost sure that if the RND mode is set to +/-inf=20
> and we do=20
> >> an operation that is within the normal bounds that should round we=20
> >> will NOT get one of the other exceptions.
> >>
> >> - k
> >>
> >>
> >
> > I looked into the manual again, and found what you are saying is=20
> > correct. The reason for developing IEEE-754 fixup came from=20
> customer's=20
> > complain, which is about denormalized computation can't=20
> generate the=20
> > correct result as the same as on x86. So what I was=20
> concentrating on=20
> > is floating-point data interrupt. The truth is, FP round=20
> interrupt may=20
> > be taken on some circumstance that FP data interrupt doesn't take=20
> > place.
> >
> > As you said, if RND mode is set to +/- inf, FP round interrupt will=20
> > generate if we do an operation within the normal bounds. Do=20
> you think=20
> > we use the same way to handle FP round interrupt as FP data=20
> interrupt=20
> > is reasonable? How would you suggest?
>=20
> No, I think the round handler should try to do the rounding=20
> by hand.  =20
> Since you have the non rounded information provided by HW,=20
> its much simpler to just do the rounding step.
>=20

OK, I will study it.

Thanks,
Ebony

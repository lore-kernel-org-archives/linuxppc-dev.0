Return-Path: <ebony.zhu@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id E783EDDE30
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 17:37:28 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l0F6bP9Q017378
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jan 2007 23:37:25 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0F6bNP2025954
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 00:37:24 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Subject: RE: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Mon, 15 Jan 2007 14:37:15 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E816B9C@zch01exm20.fsl.freescale.net>
In-Reply-To: <567FCA2A-22B1-4644-98D3-2E7431423307@kernel.crashing.org>
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
> Sent: 2007=C4=EA1=D4=C213=C8=D5 02:36
> To: Zhu Ebony-r57400
> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [patch][0/5] powerpc: Add support to fully=20
> comply with IEEE-754 standard
>=20
>=20
> On Jan 12, 2007, at 2:09 AM, Zhu Ebony-r57400 wrote:
>=20
> >  Hi Kumar,
> >
> >> -----Original Message-----
> >> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> >> Sent: 2007=C4=EA1=D4=C212=C8=D5 14:42
> >> To: Zhu Ebony-r57400
> >> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> >> Subject: Re: [patch][0/5] powerpc: Add support to fully=20
> comply with=20
> >> IEEE-754 standard
> >>
> >>
> >> On Jan 11, 2007, at 11:19 PM, Zhu Ebony-r57400 wrote:
> >>
> >>> Hi Paul,
> >>>
> >>> This series of patch add support to fully comply with IEEE-754=20
> >>> standard for E500/E500v2 core when hardware floating point
> >> compiling
> >>> is used.
> >>>
> >>> Ebony
> >>
> >> Here are some general comments:
> >> * We should be able to support math-emu (as it stands) and=20
> the fixup=20
> >> handling [you break math-emu]
> >
> > I don't think I break the math-emu. I think the codes I=20
> added have no=20
> > impact to the existing math-emu.
>=20
> This snippet of code breaks it from math-emu/sfp-machine.h
>=20
> >> +#ifdef CONFIG_SPE
> >> +#define __FPU_FPSCR	(current->thread.spefscr)
> >> +#else
> >>  #define __FPU_FPSCR	(current->thread.fpscr.val)
> >> +#endif
>=20
> By doing this if I want 'classic FP' emulation as well as the=20
> IEEE fixup my fpscr for classic emu will not be updated properly.

Logically, user can choose "SPE Support" and "Math emulation" at the=20
same time on menuconfig. But from my understanding, it is not necessary
to select math-emu on a SPE available system, since SPE can do math =
operation.


>=20
> >
> >> * Copyrights / header comments should give credit to the orig
> >> math- emu code
> > I'd like to do this, but in most handler codes, I can't find =20
> > copyright information
> > of the orig authors. I think the math-emu code comes from=20
> glibc. In =20
> > the
> > sigfpe_handler.c, I gave credit to the orig author.
>=20
> I think a comment is sufficient stating this is take from the math-=20
> emu code.
>=20
> >> * Why isn't there any handling of SPEFloatingPointRound exceptions?
> >
> > I think the SPEFloatingPointRound exception is not necessary to =20
> > handle if we
> > handle floating point exception this way.
>=20
> I dont believe this, you'll have to explain if this is really true.  =20
> But, I'm almost sure that if the RND mode is set to +/-inf and we do =20
> an operation that is within the normal bounds that should round we =20
> will NOT get one of the other exceptions.
>=20
> - k
>=20
>=20

I looked into the manual again, and found what you are saying is =
correct. The reason
for developing IEEE-754 fixup came from customer's complain, which is =
about denormalized
computation can't generate the correct result as the same as on x86. So =
what I was
concentrating on is floating-point data interrupt. The truth is, FP =
round interrupt may
be taken on some circumstance that FP data interrupt doesn't take place.

As you said, if RND mode is set to +/- inf, FP round interrupt will =
generate if we
do an operation within the normal bounds. Do you think we use the same =
way to
handle FP round interrupt as FP data interrupt is reasonable? How would =
you suggest?

Thanks.

Ebony

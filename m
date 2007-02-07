Return-Path: <ebony.zhu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id EBF85DDEC1
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 19:04:51 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l1784mun010144
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 01:04:48 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l1784jcf001904
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 02:04:47 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Wed, 7 Feb 2007 16:04:44 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E8B7D20@zch01exm20.fsl.freescale.net>
In-Reply-To: <B20A9346-C296-4570-AD4A-E9412C591F7B@kernel.crashing.org>
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
> Sent: Wednesday, February 07, 2007 3:57 PM
> To: Zhu Ebony-r57400
> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [patch][0/5] powerpc: Add support to fully=20
> comply with IEEE-754 standard
>=20
>=20
> On Feb 7, 2007, at 1:21 AM, Zhu Ebony-r57400 wrote:
>=20
> >
> >
> >> -----Original Message-----
> >> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> >> Sent: Wednesday, February 07, 2007 3:12 PM
> >> To: Zhu Ebony-r57400
> >> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> >> Subject: Re: [patch][0/5] powerpc: Add support to fully=20
> comply with=20
> >> IEEE-754 standard
> >>
> >>
> >> On Feb 6, 2007, at 11:52 PM, Zhu Ebony-r57400 wrote:
> >>
> >>>>>> This snippet of code breaks it from math-emu/sfp-machine.h
> >>>>>>
> >>>>>>>> +#ifdef CONFIG_SPE
> >>>>>>>> +#define __FPU_FPSCR	(current->thread.spefscr)
> >>>>>>>> +#else
> >>>>>>>>  #define __FPU_FPSCR	(current->thread.fpscr.val)
> >>>>>>>> +#endif
> >>>>>>
> >>>>>> By doing this if I want 'classic FP' emulation as well
> >> as the IEEE
> >>>>>> fixup my fpscr for classic emu will not be updated properly.
> >>>>>
> >>>>> Logically, user can choose "SPE Support" and "Math
> >>>> emulation" at the
> >>>>> same time on menuconfig. But from my understanding, it is not=20
> >>>>> necessary to select math-emu on a SPE available system,
> >>>> since SPE can
> >>>>> do math operation.
> >>>>
> >>>> This is not true.  If I want to run a "classic" PPC binary
> >> with FP I
> >>>> need "Math emulation" and if I want to run an SPE one I
> >> enable "SPE
> >>>> Support".  I could want to run both of these types of
> >> binaries on the
> >>>> same system at the same time.
> >>>
> >>> If this is the case, maybe we need a separate macro like
> >>> #define __SPE_SPEFSCR	(current->thread.spefscr)
> >>> But if we do this, how does the kernel know if the=20
> emulation is for=20
> >>> "classic" PPC binary with FP or an SPE one, thus corresponding=20
> >>> registers(fpscr or spefscr) being updated?
> >>
> >> It's based on what instruction you are trying to emulate.
> >>
> > For example, the FP_ROUNDMODE now defined by __FPU_FPSCR is widely=20
> > used in existing code. If the kernel doesn't know the=20
> emulation is for=20
> > classic PPC or SPE fixup, then it doesn't know where to get the=20
> > correct rounding mode, from fpscr or spefscr? This has confused me.
>=20
> Yes, this is a good point, I guess in truth the two modes are=20
> mutually exclusive.
>=20
> Sorry for not figuring that out sooner.  (uugh, all the stuff=20
> to make IEEE emulation work properly on SPE is a pain :)

Defining FP_ROUNDMODE as (current->thread.spefscr & 0x3) in sigfpe
handler maybe
a feasible way to get correct rounding mode, and won't break existing
FPU simulation.
At least it works here :) I will submit revised patches soon.

B.R.
Ebony

Return-Path: <ebony.zhu@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 7770BDDEB7
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 16:52:35 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l175qYXX024832
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Feb 2007 22:52:34 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l175qWVW004982
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Feb 2007 23:52:33 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Wed, 7 Feb 2007 13:52:30 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E8B7CC3@zch01exm20.fsl.freescale.net>
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

If this is the case, maybe we need a separate macro like
#define __SPE_SPEFSCR	(current->thread.spefscr)
But if we do this, how does the kernel know if the emulation is for
"classic" PPC binary with FP or an SPE one, thus corresponding
registers(fpscr or spefscr) being updated?

B.R.
Ebony

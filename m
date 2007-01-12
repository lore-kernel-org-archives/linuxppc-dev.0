Return-Path: <ebony.zhu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 98416DDDFA
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 17:38:57 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l0C6ctLD006776
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 23:38:55 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0C6cqUR002593
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 00:38:54 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Subject: RE: [patch][0/5] powerpc: Add support to fully comply with
	IEEE-754standard
Date: Fri, 12 Jan 2007 14:38:50 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E816A18@zch01exm20.fsl.freescale.net>
In-Reply-To: <17831.7374.149397.133454@cargo.ozlabs.ibm.com>
From: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
To: "Paul Mackerras" <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

On SPE implemented E500/E500v2 core, the embedded floating-point
APU implements a floating-point system as defined in ANSI/IEEE
standard754-1985 but rely on software support in order to conform fully
with the standard. Thus, whenever an input operand of a floating-point
instruction has data values that are +infinity, =A8Cinfinity, denorm, or =
NaN,
or when the result of an operation produces an overflow or an underflow,
an interrupt may be taken and the interrupt handler is responsible for =
delivering
IEEE 754-compliant behavior if desired.

When floating-point invalid input exceptions are disabled
(SPEFSCR[FINVE] is cleared), default results are provided by the=20
hardware when an infinity, denorm, or NaN input is received, or for the
operation 0/0. When floating-point underflow exceptions are disabled
(SPEFSCR[FUNFE] is cleared) and the result of a floating-point operation
underflows, a signed zero result is produced. When floating-point =
overflow
exceptions are disabled (EFSCR[FOVFE] is cleared) and the result of a=20
floating-point operation overflows, a pmax or nmax result is produced.=20
A divide-by-zero exception enable flag (SPEFSCR[FDBZE]) is
provided for generating an interrupt when a divide-by-zero operation is
attempted to allow a software handler to conform to the IEEE 754 =
standard.

In current code, all of these exceptions are disabled, and the IEEE-754 =
standard
is not fully complied.

Let's see an example:

2.1E-44 * 1.5666666 =3D ?

On IEEE-754 fully complied system (x86, 7450, etc.), the result should =
be=20
3.22299e-44. But on E500/E500v2 core, the result is 0.

And there are much more cases show that E500 SPE core is not fully
IEEE-754 complied.

The approach I've taken to solve this issue is:
1. Enable SPEFSCR[FINVE|FDBZE|FUNFE|FOVFE] to make sure exceptions
can take place
2. Use exceptions handlers to handle the exceptions.
3. Restore registers and exit from exception.

In arch/powerpc/math, there are some files to emulate floating point =
instructions
on non-FPU systems, which may come from glibc. Some macros are provided =
to
emulate plus, minus, multiply, divide, etc. Therefore, I re-used some of =
the codes there
and add some new routines to emulated SPE instruction that may cause =
exception,
including SPFP instructions, DPFP instructions and Vector SPFP =
instructions.

Writing some independent codes to handle the exceptions my be an =
alternative way,
but I think re-use the existing interfaces in kernel is the best =
approach.

Ebony



> -----Original Message-----
> From: Paul Mackerras [mailto:paulus@samba.org]=20
> Sent: 2007=C4=EA1=D4=C212=C8=D5 13:30
> To: Zhu Ebony-r57400
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [patch][0/5] powerpc: Add support to fully=20
> comply with IEEE-754standard
>=20
> Zhu Ebony-r57400 writes:
>=20
> > This series of patch add support to fully comply with IEEE-754=20
> > standard for E500/E500v2 core when hardware floating point=20
> compiling is used.
>=20
> Your patch descriptions need to explain in detail in what way=20
> the current code doesn't comply with the IEEE-754 standard,=20
> and what approach you have taken to make it comply.  If there=20
> are alternative approaches, explain why the approach you have=20
> taken is the best.
>=20
> Thanks,
> Paul.
>=20

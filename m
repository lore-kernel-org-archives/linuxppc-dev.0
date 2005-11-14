Return-Path: <becky.bruce@freescale.com>
In-Reply-To: <1131955237.5504.148.camel@gaston>
References: <1131955237.5504.148.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <daaff9f9782443f3d943c2853fb9a476@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
Date: Mon, 14 Nov 2005 13:53:19 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: Merge align.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,

I talked to Kumar about this a little bit (I had started a merge of=20
this file, but got distracted!) and he doesn't have any test cases. =20
I'll put something together and test this out on some of the 32-bit=20
systems I have here in my lab.  It won't be complete, but it will be=20
something.......

Cheers,
B

On Nov 14, 2005, at 2:00 AM, Benjamin Herrenschmidt wrote:

> Need testing !!!
>
> This patch merges align.c, the result isn't quite what was in ppc64 =
nor
> what was in ppc32 :) It should implement all the functionalities of=20
> both
> though. Kumar, since you played with that in the past, I suppose you
> have some test cases for verifying that it works properly before I dig
> out the 601 machine ? :)
>
> Since it's likely that I won't be able to test all scenario, code
> inspection is much welcome.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
>
> Index: linux-work/arch/powerpc/kernel/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-work.orig/arch/powerpc/kernel/Makefile=A0=A0=A0=A0=A0=A0=A0 =
2005-11-14=20
> 15:17:57.000000000 +1100
> +++ linux-work/arch/powerpc/kernel/Makefile=A0=A0=A0=A0 2005-11-14=20
> 17:18:14.000000000 +1100
> @@ -12,7 +12,7 @@
> =A0endif
> =A0
> =A0obj-y=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 :=3D semaphore.o cputable.o ptrace.o=20
> syscalls.o \
> -=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0 irq.o signal_32.o pmc.o vdso.o
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0 irq.o align.o signal_32.o pmc.o=20
> vdso.o
> =A0obj-y=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 +=3D vdso32/
> =A0obj-$(CONFIG_PPC64)=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 +=3D setup_64.o =
binfmt_elf32.o=20
> sys_ppc32.o \
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0 signal_64.o ptrace32.o systbl.o \
> Index: linux-work/arch/powerpc/kernel/align.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null=A0=A0 1970-01-01 00:00:00.000000000 +0000
> +++ linux-work/arch/powerpc/kernel/align.c=A0=A0=A0=A0=A0 2005-11-14=20=

> 18:41:22.000000000 +1100
> @@ -0,0 +1,513 @@
> +/* align.c - handle alignment exceptions for the Power PC.
> + *
> + * Copyright (c) 1996 Paul Mackerras <paulus@cs.anu.edu.au>
> + * Copyright (c) 1998-1999 TiVo, Inc.
> + *=A0=A0 PowerPC 403GCX modifications.
> + * Copyright (c) 1999 Grant Erickson <grant@lcse.umn.edu>
> + *=A0=A0 PowerPC 403GCX/405GP modifications.
> + * Copyright (c) 2001-2002 PPC64 team, IBM Corp
> + *=A0=A0 64-bit and Power4 support
> + * Copyright (c) 2005 Benjamin Herrenschmidt, IBM Corp
> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
<benh@kernel.crashing.org>
> + *=A0=A0 Merge ppc32 and ppc64 implementations
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <asm/processor.h>
> +#include <asm/uaccess.h>
> +#include <asm/system.h>
> +#include <asm/cache.h>
> +#include <asm/cputable.h>
> +
> +struct aligninfo {
> +=A0=A0=A0=A0=A0=A0 unsigned char len;
> +=A0=A0=A0=A0=A0=A0 unsigned char flags;
> +};
> +
> +#define IS_XFORM(inst) (((inst) >> 26) =3D=3D 31)
> +#define IS_DSFORM(inst)=A0=A0=A0=A0=A0=A0=A0 (((inst) >> 26) >=3D 56)
> +
> +#define INVALID=A0=A0=A0=A0=A0=A0=A0 { 0, 0 }
> +
> +#define LD=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0 /* load */
> +#define ST=A0=A0=A0=A0 2=A0=A0=A0=A0=A0=A0 /* store */
> +#define=A0=A0=A0=A0=A0=A0=A0 SE=A0=A0=A0=A0=A0 4=A0=A0=A0=A0=A0=A0 /* =
sign-extend value */
> +#define F=A0=A0=A0=A0=A0 8=A0=A0=A0=A0=A0=A0 /* to/from fp regs */
> +#define U=A0=A0=A0=A0=A0 0x10=A0=A0=A0 /* update index register */
> +#define M=A0=A0=A0=A0=A0 0x20=A0=A0=A0 /* multiple load/store */
> +#define SW=A0=A0=A0=A0 0x40=A0=A0=A0 /* byte swap int or ... */
> +#define S=A0=A0=A0=A0=A0 0x40=A0=A0=A0 /* ... single-precision fp */
> +#define SX=A0=A0=A0=A0 0x40=A0=A0=A0 /* byte count in XER */
> +#define HARD=A0=A0 0x80=A0=A0=A0 /* string, stwcx. */
> +
> +#define DCBZ=A0=A0 0x5f=A0=A0=A0 /* 8xx/82xx dcbz faults when cache =
not enabled=20
> */
> +
> +#define SWAP(a, b)=A0=A0=A0=A0 (t =3D (a), (a) =3D (b), (b) =3D t)
> +
> +/*
> + * The PowerPC stores certain bits of the instruction that caused the
> + * alignment exception in the DSISR register.=A0 This array maps =
those
> + * bits to information about the operand length and what the
> + * instruction would do.
> + */
> +static struct aligninfo aligninfo[128] =3D {
> +=A0=A0=A0=A0=A0=A0 { 4, LD },=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* =
00 0 0000: lwz / lwarx */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 00 0 0001 */
> +=A0=A0=A0=A0=A0=A0 { 4, ST },=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* =
00 0 0010: stw */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 00 0 0011 */
> +=A0=A0=A0=A0=A0=A0 { 2, LD },=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* =
00 0 0100: lhz */
> +=A0=A0=A0=A0=A0=A0 { 2, LD+SE },=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 00 0 =
0101: lha */
> +=A0=A0=A0=A0=A0=A0 { 2, ST },=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* =
00 0 0110: sth */
> +=A0=A0=A0=A0=A0=A0 { 4, LD+M },=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 00 =
0 0111: lmw */
> +=A0=A0=A0=A0=A0=A0 { 4, LD+F+S },=A0 =A0=A0=A0=A0=A0=A0=A0 /* 00 0 =
1000: lfs */
> +=A0=A0=A0=A0=A0=A0 { 8, LD+F },=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 00 =
0 1001: lfd */
> +=A0=A0=A0=A0=A0=A0 { 4, ST+F+S },=A0 =A0=A0=A0=A0=A0=A0=A0 /* 00 0 =
1010: stfs */
> +=A0=A0=A0=A0=A0=A0 { 8, ST+F },=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 00 =
0 1011: stfd */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 00 0 1100 */
> +=A0=A0=A0=A0=A0=A0 { 8, LD },=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* =
00 0 1101: ld/ldu/lwa */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 00 0 1110 */
> +=A0=A0=A0=A0=A0=A0 { 8, ST },=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* =
00 0 1111: std/stdu */
> +=A0=A0=A0=A0=A0=A0 { 4, LD+U },=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 00 =
1 0000: lwzu */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 00 1 0001 */
> +=A0=A0=A0=A0=A0=A0 { 4, ST+U },=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 00 =
1 0010: stwu */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 00 1 0011 */
> +=A0=A0=A0=A0=A0=A0 { 2, LD+U },=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 00 =
1 0100: lhzu */
> +=A0=A0=A0=A0=A0=A0 { 2, LD+SE+U }, =A0=A0=A0=A0=A0=A0=A0 /* 00 1 =
0101: lhau */
> +=A0=A0=A0=A0=A0=A0 { 2, ST+U },=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 00 =
1 0110: sthu */
> +=A0=A0=A0=A0=A0=A0 { 4, ST+M },=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 00 =
1 0111: stmw */
> +=A0=A0=A0=A0=A0=A0 { 4, LD+F+S+U },=A0=A0=A0=A0=A0=A0=A0 /* 00 1 =
1000: lfsu */
> +=A0=A0=A0=A0=A0=A0 { 8, LD+F+U },=A0 =A0=A0=A0=A0=A0=A0=A0 /* 00 1 =
1001: lfdu */
> +=A0=A0=A0=A0=A0=A0 { 4, ST+F+S+U },=A0=A0=A0=A0=A0=A0=A0 /* 00 1 =
1010: stfsu */
> +=A0=A0=A0=A0=A0=A0 { 8, ST+F+U },=A0 =A0=A0=A0=A0=A0=A0=A0 /* 00 1 =
1011: stfdu */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 00 1 1100 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 00 1 1101 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 00 1 1110 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 00 1 1111 */
> +=A0=A0=A0=A0=A0=A0 { 8, LD },=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* =
01 0 0000: ldx */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 01 0 0001 */
> +=A0=A0=A0=A0=A0=A0 { 8, ST },=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* =
01 0 0010: stdx */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 01 0 0011 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 01 0 0100 */
> +=A0=A0=A0=A0=A0=A0 { 4, LD+SE },=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 01 0 =
0101: lwax */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 01 0 0110 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 01 0 0111 */
> +=A0=A0=A0=A0=A0=A0 { 4, LD+M+HARD+SX },=A0=A0=A0 /* 01 0 1000: lswx =
*/
> +=A0=A0=A0=A0=A0=A0 { 4, LD+M+HARD },=A0=A0=A0=A0=A0=A0 /* 01 0 1001: =
lswi */
> +=A0=A0=A0=A0=A0=A0 { 4, ST+M+HARD+SX },=A0=A0=A0 /* 01 0 1010: stswx =
*/
> +=A0=A0=A0=A0=A0=A0 { 4, ST+M+HARD },=A0=A0=A0=A0=A0=A0 /* 01 0 1011: =
stswi */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 01 0 1100 */
> +=A0=A0=A0=A0=A0=A0 { 8, LD+U },=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 01 =
0 1101: ldu */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 01 0 1110 */
> +=A0=A0=A0=A0=A0=A0 { 8, ST+U },=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 01 =
0 1111: stdu */
> +=A0=A0=A0=A0=A0=A0 { 8, LD+U },=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 01 =
1 0000: ldux */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 01 1 0001 */
> +=A0=A0=A0=A0=A0=A0 { 8, ST+U },=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 01 =
1 0010: stdux */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 01 1 0011 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 01 1 0100 */
> +=A0=A0=A0=A0=A0=A0 { 4, LD+SE+U }, =A0=A0=A0=A0=A0=A0=A0 /* 01 1 =
0101: lwaux */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 01 1 0110 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 01 1 0111 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 01 1 1000 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 01 1 1001 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 01 1 1010 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 01 1 1011 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 01 1 1100 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 01 1 1101 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 01 1 1110 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 01 1 1111 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 10 0 0000 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 10 0 0001 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 10 0 0010: stwcx. */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 10 0 0011 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 10 0 0100 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 10 0 0101 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 10 0 0110 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 10 0 0111 */
> +=A0=A0=A0=A0=A0=A0 { 4, LD+SW },=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 10 0 =
1000: lwbrx */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 10 0 1001 */
> +=A0=A0=A0=A0=A0=A0 { 4, ST+SW },=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 10 0 =
1010: stwbrx */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 10 0 1011 */
> +=A0=A0=A0=A0=A0=A0 { 2, LD+SW },=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 10 0 =
1100: lhbrx */
> +=A0=A0=A0=A0=A0=A0 { 4, LD+SE },=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 10 0 =
1101=A0 lwa */
> +=A0=A0=A0=A0=A0=A0 { 2, ST+SW },=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 10 0 =
1110: sthbrx */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 10 0 1111 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 10 1 0000 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 10 1 0001 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 10 1 0010 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 10 1 0011 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 10 1 0100 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 10 1 0101 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 10 1 0110 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 10 1 0111 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 10 1 1000 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 10 1 1001 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 10 1 1010 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 10 1 1011 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 10 1 1100 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 10 1 1101 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 10 1 1110 */
> +=A0=A0=A0=A0=A0=A0 { 0, ST+HARD }, =A0=A0=A0=A0=A0=A0=A0 /* 10 1 =
1111: dcbz */
> +=A0=A0=A0=A0=A0=A0 { 4, LD },=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* =
11 0 0000: lwzx */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 11 0 0001 */
> +=A0=A0=A0=A0=A0=A0 { 4, ST },=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* =
11 0 0010: stwx */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 11 0 0011 */
> +=A0=A0=A0=A0=A0=A0 { 2, LD },=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* =
11 0 0100: lhzx */
> +=A0=A0=A0=A0=A0=A0 { 2, LD+SE },=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 11 0 =
0101: lhax */
> +=A0=A0=A0=A0=A0=A0 { 2, ST },=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* =
11 0 0110: sthx */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 11 0 0111 */
> +=A0=A0=A0=A0=A0=A0 { 4, LD+F+S },=A0 =A0=A0=A0=A0=A0=A0=A0 /* 11 0 =
1000: lfsx */
> +=A0=A0=A0=A0=A0=A0 { 8, LD+F },=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 11 =
0 1001: lfdx */
> +=A0=A0=A0=A0=A0=A0 { 4, ST+F+S },=A0 =A0=A0=A0=A0=A0=A0=A0 /* 11 0 =
1010: stfsx */
> +=A0=A0=A0=A0=A0=A0 { 8, ST+F },=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 11 =
0 1011: stfdx */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 11 0 1100 */
> +=A0=A0=A0=A0=A0=A0 { 8, LD+M },=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 11 =
0 1101: lmd */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 11 0 1110 */
> +=A0=A0=A0=A0=A0=A0 { 8, ST+M },=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 11 =
0 1111: stmd */
> +=A0=A0=A0=A0=A0=A0 { 4, LD+U },=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 11 =
1 0000: lwzux */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 11 1 0001 */
> +=A0=A0=A0=A0=A0=A0 { 4, ST+U },=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 11 =
1 0010: stwux */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 11 1 0011 */
> +=A0=A0=A0=A0=A0=A0 { 2, LD+U },=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 11 =
1 0100: lhzux */
> +=A0=A0=A0=A0=A0=A0 { 2, LD+SE+U }, =A0=A0=A0=A0=A0=A0=A0 /* 11 1 =
0101: lhaux */
> +=A0=A0=A0=A0=A0=A0 { 2, ST+U },=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* 11 =
1 0110: sthux */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 11 1 0111 */
> +=A0=A0=A0=A0=A0=A0 { 4, LD+F+S+U },=A0=A0=A0=A0=A0=A0=A0 /* 11 1 =
1000: lfsux */
> +=A0=A0=A0=A0=A0=A0 { 8, LD+F+U },=A0 =A0=A0=A0=A0=A0=A0=A0 /* 11 1 =
1001: lfdux */
> +=A0=A0=A0=A0=A0=A0 { 4, ST+F+S+U },=A0=A0=A0=A0=A0=A0=A0 /* 11 1 =
1010: stfsux */
> +=A0=A0=A0=A0=A0=A0 { 8, ST+F+U },=A0 =A0=A0=A0=A0=A0=A0=A0 /* 11 1 =
1011: stfdux */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 11 1 1100 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 11 1 1101 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 11 1 1110 */
> +=A0=A0=A0=A0=A0=A0 INVALID,=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
/* 11 1 1111 */
> +};
> +
> +/*
> + * Create a DSISR value from the instruction
> + */
> +static inline unsigned make_dsisr(unsigned instr)
> +{
> +=A0=A0=A0=A0=A0=A0 unsigned dsisr;
> +
> +
> +=A0=A0=A0=A0=A0=A0 /* bits=A0 6:15 --> 22:31 */
> +=A0=A0=A0=A0=A0=A0 dsisr =3D (instr & 0x03ff0000) >> 16;
> +
> +=A0=A0=A0=A0=A0=A0 if ( IS_XFORM(instr) ) {
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* bits 29:30 --> 15:16 */
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 dsisr |=3D (instr & =
0x00000006) << 14;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* bit=A0=A0=A0=A0 25 -->=A0=A0=
=A0 17 */
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 dsisr |=3D (instr & =
0x00000040) << 8;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* bits 21:24 --> 18:21 */
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 dsisr |=3D (instr & =
0x00000780) << 3;
> +=A0=A0=A0=A0=A0=A0 }
> +=A0=A0=A0=A0=A0=A0 else {
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* bit=A0=A0=A0=A0=A0 5 =
-->=A0=A0=A0 17 */
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 dsisr |=3D (instr & =
0x04000000) >> 12;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* bits=A0 1: 4 --> 18:21 */
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 dsisr |=3D (instr & =
0x78000000) >> 17;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* bits 30:31 --> 12:13 */
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 if ( IS_DSFORM(instr) )
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 dsisr =
|=3D (instr & 0x00000003) << 18;
> +=A0=A0=A0=A0=A0=A0 }
> +
> +=A0=A0=A0=A0=A0=A0 return dsisr;
> +}
> +
> +/*
> + * The dcbz (data cache block zero) instruction
> + * gives an alignment fault if used on non-cacheable
> + * memory.=A0 We handle the fault mainly for the
> + * case when we are running with the cache disabled
> + * for debugging.
> + */
> +static int emulate_dcbz(struct pt_regs *regs, unsigned char __user=20
> *addr)
> +{
> +=A0=A0=A0=A0=A0=A0 long __user *p;
> +=A0=A0=A0=A0=A0=A0 int i, size;
> +
> +#ifdef __powerpc64__
> +=A0=A0=A0=A0=A0=A0 size =3D ppc64_caches.dline_size;
> +#else
> +=A0=A0=A0=A0=A0=A0 size =3D L1_CACHE_BYTES;
> +#endif
> +=A0=A0=A0=A0=A0=A0 p =3D (long __user *) (regs->dar & -size);
> +=A0=A0=A0=A0=A0=A0 if (user_mode(regs) && !access_ok(VERIFY_WRITE, p, =
size))
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 return -EFAULT;
> +=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < size / sizeof(long); ++i)
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 if (__put_user(0, p+i))
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 return =
-EFAULT;
> +=A0=A0=A0=A0=A0=A0 return 1;
> +}
> +
> +/*
> + * Emulate load & store multiple instructions
> + */
> +static int emulate_multiple(struct pt_regs *regs, unsigned char=20
> __user *addr,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=
 unsigned int reg, unsigned int nb,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=
 unsigned int flags, unsigned int instr)
> +{
> +=A0=A0=A0=A0=A0=A0 unsigned char *rptr;
> +=A0=A0=A0=A0=A0=A0 int nb0, i;
> +
> +=A0=A0=A0=A0=A0=A0 /*
> +=A0=A0=A0=A0=A0=A0=A0 * We do not try to emulate 8 bytes multiple as =
they aren't=20
> really
> +=A0=A0=A0=A0=A0=A0=A0 * available in our operating environments and =
we don't try to
> +=A0=A0=A0=A0=A0=A0=A0 * emulate multiples operations in kernel land =
as they should=20
> never
> +=A0=A0=A0=A0=A0=A0=A0 * be used/generated there at least not on =
unaligned boundaries
> +=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0 if (unlikely((nb > 4) || !user_mode(regs)))
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 return 0;
> +
> +=A0=A0=A0=A0=A0=A0 /* lmw, stmw, lswi/x, stswi/x */
> +=A0=A0=A0=A0=A0=A0 nb0 =3D 0;
> +=A0=A0=A0=A0=A0=A0 if (flags & HARD) {
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 if (flags & SX) {
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 nb =3D =
regs->xer & 127;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 if (nb =
=3D=3D 0)
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 return 1;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 } else {
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 if =
(__get_user(instr,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0 (unsigned int __user=20
> *)regs->nip))
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 return -EFAULT;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 nb =3D =
(instr >> 11) & 0x1f;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 if (nb =
=3D=3D 0)
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 nb =3D 32;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 }
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 if (nb + reg * 4 > 128) {
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 nb0 =3D =
nb + reg * 4 - 128;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 nb =3D =
128 - reg * 4;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 }
> +=A0=A0=A0=A0=A0=A0 } else {
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* lwm, stmw */
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 nb =3D (32 - reg) * 4;
> +=A0=A0=A0=A0=A0=A0 }
> +
> +=A0=A0=A0=A0=A0=A0 if (!access_ok((flags & ST ? VERIFY_WRITE: =
VERIFY_READ), addr,=20
> nb+nb0))
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 return -EFAULT; /* bad =
address */
> +
> +=A0=A0=A0=A0=A0=A0 rptr =3D (unsigned char *) &regs->gpr[reg];
> +=A0=A0=A0=A0=A0=A0 if (flags & LD) {
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < nb; ++i)
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 if =
(__get_user(rptr[i], addr + i))
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 return -EFAULT;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 if (nb0 > 0) {
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 rptr =3D=
 (unsigned char *) &regs->gpr[0];
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 addr =
+=3D nb;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 for (i =
=3D 0; i < nb0; ++i)
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 if (__get_user(rptr[i], addr + i))
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 return -EFAULT;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 }
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 for (; (i & 3) !=3D 0; ++i)
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
rptr[i] =3D 0;
> +=A0=A0=A0=A0=A0=A0 } else {
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < nb; ++i)
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 if =
(__put_user(rptr[i], addr + i))
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 return -EFAULT;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 if (nb0 > 0) {
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 rptr =3D=
 (unsigned char *) &regs->gpr[0];
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 addr =
+=3D nb;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 for (i =
=3D 0; i < nb0; ++i)
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 if (__put_user(rptr[i], addr + i))
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 return -EFAULT;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 }
> +=A0=A0=A0=A0=A0=A0 }
> +=A0=A0=A0=A0=A0=A0 return 1;
> +}
> +
> +
> +/*
> + * Called on alignment exception. Attempts to fixup
> + *
> + * Return 1 on success
> + * Return 0 if unable to handle the interrupt
> + * Return -EFAULT if data address is bad
> + */
> +
> +int fix_alignment(struct pt_regs *regs)
> +{
> +=A0=A0=A0=A0=A0=A0 unsigned int instr, nb, flags;
> +=A0=A0=A0=A0=A0=A0 unsigned int reg, areg;
> +=A0=A0=A0=A0=A0=A0 unsigned int dsisr;
> +=A0=A0=A0=A0=A0=A0 unsigned char __user *addr;
> +=A0=A0=A0=A0=A0=A0 unsigned char __user *p;
> +=A0=A0=A0=A0=A0=A0 int ret, t;
> +=A0=A0=A0=A0=A0=A0 union {
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 long ll;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 double dd;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 unsigned char v[8];
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 struct {
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
unsigned hi32;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
int=A0=A0=A0=A0=A0 low32;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 } x32;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 struct {
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
unsigned char hi48[6];
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
short=A0=A0 =A0=A0=A0=A0=A0 low16;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 } x16;
> +=A0=A0=A0=A0=A0=A0 } data;
> +
> +=A0=A0=A0=A0=A0=A0 /*
> +=A0=A0=A0=A0=A0=A0=A0 * We require a complete register set, if not, =
then our=20
> assembly
> +=A0=A0=A0=A0=A0=A0=A0 * is broken
> +=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0 CHECK_FULL_REGS(regs);
> +
> +=A0=A0=A0=A0=A0=A0 dsisr =3D regs->dsisr;
> +
> +=A0=A0=A0=A0=A0=A0 /* Some processors don't provide us with a DSISR =
we can use=20
> here,
> +=A0=A0=A0=A0=A0=A0=A0 * let's make one up from the instruction
> +=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0 if (cpu_has_feature(CPU_FTR_NODSISRALIGN)) {
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 unsigned int real_instr;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 if =
(unlikely(__get_user(real_instr,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 (unsigned int __user=20
> *)regs->nip)))
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 return =
-EFAULT;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 dsisr =3D =
make_dsisr(real_instr);
> +=A0=A0=A0=A0=A0=A0 }
> +
> +=A0=A0=A0=A0=A0=A0 /* extract the operation and registers from the =
dsisr */
> +=A0=A0=A0=A0=A0=A0 reg =3D (dsisr >> 5) & 0x1f;=A0=A0=A0=A0=A0 /* =
source/dest register */
> +=A0=A0=A0=A0=A0=A0 areg =3D dsisr & 0x1f;=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=
 /* register to update */
> +=A0=A0=A0=A0=A0=A0 instr =3D (dsisr >> 10) & 0x7f;
> +=A0=A0=A0=A0=A0=A0 instr |=3D (dsisr >> 13) & 0x60;
> +
> +=A0=A0=A0=A0=A0=A0 /* Lookup the operation in our table */
> +=A0=A0=A0=A0=A0=A0 nb =3D aligninfo[instr].len;
> +=A0=A0=A0=A0=A0=A0 flags =3D aligninfo[instr].flags;
> +
> +=A0=A0=A0=A0=A0=A0 /* DAR has the operand effective address */
> +=A0=A0=A0=A0=A0=A0 addr =3D (unsigned char __user *)regs->dar;
> +
> +=A0=A0=A0=A0=A0=A0 /* A size of 0 indicates an instruction we don't =
support, with
> +=A0=A0=A0=A0=A0=A0=A0 * the exception of DCBZ which is handled as a =
special case=20
> here
> +=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0 if (instr =3D=3D DCBZ)
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 return emulate_dcbz(regs, =
addr);
> +=A0=A0=A0=A0=A0=A0 if (unlikely(nb =3D=3D 0))
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 return 0;
> +
> +=A0=A0=A0=A0=A0=A0 /* Load/Store Multiple instructions are handled in =
their own
> +=A0=A0=A0=A0=A0=A0=A0 * function
> +=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0 if (flags & M)
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 return =
emulate_multiple(regs, addr, reg, nb, flags,=20
> instr);
> +
> +=A0=A0=A0=A0=A0=A0 /* Verify the address of the operand */
> +=A0=A0=A0=A0=A0=A0 if (unlikely(user_mode(regs) &&
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0 =
!access_ok((flags & ST ? VERIFY_WRITE :=20
> VERIFY_READ),
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 addr, nb)))
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 return -EFAULT;
> +
> +=A0=A0=A0=A0=A0=A0 /* Force the fprs into the save area so we can =
reference them=20
> */
> +=A0=A0=A0=A0=A0=A0 if (flags & F) {
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* userland only */
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 if =
(unlikely(!user_mode(regs)))
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 return =
0;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 flush_fp_to_thread(current);
> +=A0=A0=A0=A0=A0=A0 }
> +
> +=A0=A0=A0=A0=A0=A0 /* If we are loading, get the data from user =
space, else
> +=A0=A0=A0=A0=A0=A0=A0 * get it from register values
> +=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0 if (flags & LD) {
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 data.ll =3D 0;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ret =3D 0;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 p =3D addr;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 switch (nb) {
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 case 8:
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ret |=3D=
 __get_user(data.v[0], p++);
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ret |=3D=
 __get_user(data.v[1], p++);
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ret |=3D=
 __get_user(data.v[2], p++);
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ret |=3D=
 __get_user(data.v[3], p++);
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 case 4:
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ret |=3D=
 __get_user(data.v[4], p++);
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ret |=3D=
 __get_user(data.v[5], p++);
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 case 2:
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ret |=3D=
 __get_user(data.v[6], p++);
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ret |=3D=
 __get_user(data.v[7], p++);
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 if =
(unlikely(ret))
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 return -EFAULT;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 }
> +=A0=A0=A0=A0=A0=A0 } else if (flags & F)
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 data.dd =3D =
current->thread.fpr[reg];
> +=A0=A0=A0=A0=A0=A0 else
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 data.ll =3D regs->gpr[reg];
> +
> +=A0=A0=A0=A0=A0=A0 /* Perform other misc operations like sign =
extension, byteswap,
> +=A0=A0=A0=A0=A0=A0=A0 * or floating point single precision conversion
> +=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0 switch (flags & ~U) {
> +=A0=A0=A0=A0=A0=A0 case LD+SE:=A0=A0=A0=A0 /* sign extend */
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 if ( nb =3D=3D 2 )
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
data.ll =3D data.x16.low16;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 else=A0=A0=A0 /* nb must be =
4 */
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
data.ll =3D data.x32.low32;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 break;
> +=A0=A0=A0=A0=A0=A0 case LD+S:=A0=A0=A0=A0=A0 /* byte-swap */
> +=A0=A0=A0=A0=A0=A0 case ST+S:
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 if (nb =3D=3D 2) {
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
SWAP(data.v[6], data.v[7]);
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 } else {
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
SWAP(data.v[4], data.v[7]);
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
SWAP(data.v[5], data.v[6]);
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 }
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 break;
> +
> +=A0=A0=A0=A0=A0=A0 /* Single-precision FP load and store require =
conversions... */
> +=A0=A0=A0=A0=A0=A0 case LD+F+S:
> +#ifdef CONFIG_PPC_FPU
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 preempt_disable();
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 enable_kernel_fp();
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 cvt_fd((float *)&data.v[4], =
&data.dd,=20
> &current->thread);
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 preempt_enable();
> +#else
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 return 0;
> +#endif
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 break;
> +=A0=A0=A0=A0=A0=A0 case ST+F+S:
> +#ifdef CONFIG_PPC_FPU
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 preempt_disable();
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 enable_kernel_fp();
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 cvt_df(&data.dd, (float =
*)&data.v[4],=20
> &current->thread);
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 preempt_enable();
> +#else
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 return 0;
> +#endif
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 break;
> +=A0=A0=A0=A0=A0=A0 }
> +
> +=A0=A0=A0=A0=A0=A0 /* Store result to memory or update registers */
> +=A0=A0=A0=A0=A0=A0 if (flags & ST) {
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ret =3D 0;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 p =3D addr;
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 switch (nb) {
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 case 8:
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ret |=3D=
 __put_user(data.v[0], p++);
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ret |=3D=
 __put_user(data.v[1], p++);
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ret |=3D=
 __put_user(data.v[2], p++);
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ret |=3D=
 __put_user(data.v[3], p++);
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 case 4:
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ret |=3D=
 __put_user(data.v[4], p++);
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ret |=3D=
 __put_user(data.v[5], p++);
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 case 2:
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ret |=3D=
 __put_user(data.v[6], p++);
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ret |=3D=
 __put_user(data.v[7], p++);
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 }
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 if (unlikely(ret))
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 return =
-EFAULT;
> +=A0=A0=A0=A0=A0=A0 } else if (flags & F)
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 current->thread.fpr[reg] =3D =
data.dd;
> +=A0=A0=A0=A0=A0=A0 else
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 regs->gpr[reg] =3D data.ll;
> +
> +=A0=A0=A0=A0=A0=A0 /* Update RA as needed */
> +=A0=A0=A0=A0=A0=A0 if (flags & U)
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 regs->gpr[areg] =3D =
regs->dar;
> +
> +=A0=A0=A0=A0=A0=A0 return 1;
> +}
> Index: linux-work/arch/ppc/kernel/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-work.orig/arch/ppc/kernel/Makefile=A0=A0=A0 2005-11-11=20
> 10:14:48.000000000 +1100
> +++ linux-work/arch/ppc/kernel/Makefile 2005-11-14 18:42:30.000000000=20=

> +1100
> @@ -13,7 +13,7 @@
> =A0extra-y=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 =A0=A0=A0=A0=A0=A0=A0 +=3D vmlinux.lds
> =A0
> =A0obj-y=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=
=A0 :=3D entry.o traps.o idle.o time.o=20
> misc.o \
> -=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 process.o align.o \
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 process.o \
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 setup.o \
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 ppc_htab.o
> =A0obj-$(CONFIG_6xx)=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 +=3D l2cr.o =
cpu_setup_6xx.o
> Index: linux-work/arch/ppc64/kernel/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-work.orig/arch/ppc64/kernel/Makefile=A0 2005-11-14=20
> 15:20:05.000000000 +1100
> +++ linux-work/arch/ppc64/kernel/Makefile=A0=A0=A0=A0=A0=A0 2005-11-14=20=

> 18:42:12.000000000 +1100
> @@ -11,9 +11,7 @@
> =A0
> =A0endif
> =A0
> -obj-y=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +=3D idle.o dma.o \
> -=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
align.o \
> -=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
iommu.o
> +obj-y=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +=3D idle.o dma.o =
iommu.o
> =A0
> =A0pci-obj-$(CONFIG_PPC_MULTIPLATFORM)=A0=A0=A0 +=3D pci_dn.o =
pci_direct_iommu.o
> =A0
> Index: linux-work/include/asm-powerpc/cputable.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-work.orig/include/asm-powerpc/cputable.h=A0=A0=A0=A0=A0 =
2005-11-11=20
> 10:14:49.000000000 +1100
> +++ linux-work/include/asm-powerpc/cputable.h=A0=A0 2005-11-14=20
> 18:33:42.000000000 +1100
> @@ -90,6 +90,7 @@
> =A0#define CPU_FTR_NEED_COHERENT=A0 =A0=A0=A0=A0=A0=A0=A0 =
ASM_CONST(0x0000000000020000)
> =A0#define CPU_FTR_NO_BTIC=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0=20
> ASM_CONST(0x0000000000040000)
> =A0#define CPU_FTR_BIG_PHYS=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
ASM_CONST(0x0000000000080000)
> +#define CPU_FTR_NODSISRALIGN=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
ASM_CONST(0x0000000000100000)
> =A0
> =A0#ifdef __powerpc64__
> =A0/* Add the 64b processor unique features in the top half of the =
word=20
> */
> @@ -97,7 +98,6 @@
> =A0#define CPU_FTR_16M_PAGE=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
ASM_CONST(0x0000000200000000)
> =A0#define CPU_FTR_TLBIEL=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0=20
> ASM_CONST(0x0000000400000000)
> =A0#define CPU_FTR_NOEXECUTE=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
ASM_CONST(0x0000000800000000)
> -#define CPU_FTR_NODSISRALIGN=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
ASM_CONST(0x0000001000000000)
> =A0#define CPU_FTR_IABR=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=
 ASM_CONST(0x0000002000000000)
> =A0#define CPU_FTR_MMCRA=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0=20
> ASM_CONST(0x0000004000000000)
> =A0#define CPU_FTR_CTRL=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=
 ASM_CONST(0x0000008000000000)
> @@ -113,7 +113,6 @@
> =A0#define CPU_FTR_16M_PAGE=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
ASM_CONST(0x0)
> =A0#define CPU_FTR_TLBIEL=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 ASM_CONST(0x0)
> =A0#define CPU_FTR_NOEXECUTE=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
ASM_CONST(0x0)
> -#define CPU_FTR_NODSISRALIGN=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
ASM_CONST(0x0)
> =A0#define CPU_FTR_IABR=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=
 ASM_CONST(0x0)
> =A0#define CPU_FTR_MMCRA=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 ASM_CONST(0x0)
> =A0#define CPU_FTR_CTRL=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=
 ASM_CONST(0x0)
> @@ -273,18 +272,21 @@
> =A0=A0=A0=A0=A0=A0=A0 CPU_FTRS_POWER3_32 =3D CPU_FTR_COMMON | =
CPU_FTR_SPLIT_ID_CACHE |
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
> =A0=A0=A0=A0=A0=A0=A0 CPU_FTRS_POWER4_32 =3D CPU_FTR_COMMON | =
CPU_FTR_SPLIT_ID_CACHE |
> -=A0=A0=A0=A0=A0=A0 =A0=A0=A0 CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0 CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE | =
CPU_FTR_NODSISRALIGN,
> =A0=A0=A0=A0=A0=A0=A0 CPU_FTRS_970_32 =3D CPU_FTR_COMMON | =
CPU_FTR_SPLIT_ID_CACHE |
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE | =
CPU_FTR_ALTIVEC_COMP=20
> |
> -=A0=A0=A0=A0=A0=A0 =A0=A0=A0 CPU_FTR_MAYBE_CAN_NAP,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0 CPU_FTR_MAYBE_CAN_NAP | =
CPU_FTR_NODSISRALIGN,
> =A0=A0=A0=A0=A0=A0=A0 CPU_FTRS_8XX =3D CPU_FTR_SPLIT_ID_CACHE | =
CPU_FTR_USE_TB,
> -=A0=A0=A0=A0=A0=A0 CPU_FTRS_40X =3D CPU_FTR_SPLIT_ID_CACHE | =
CPU_FTR_USE_TB,
> -=A0=A0=A0=A0=A0=A0 CPU_FTRS_44X =3D CPU_FTR_SPLIT_ID_CACHE | =
CPU_FTR_USE_TB,
> -=A0=A0=A0=A0=A0=A0 CPU_FTRS_E200 =3D CPU_FTR_USE_TB,
> -=A0=A0=A0=A0=A0=A0 CPU_FTRS_E500 =3D CPU_FTR_SPLIT_ID_CACHE | =
CPU_FTR_USE_TB,
> +=A0=A0=A0=A0=A0=A0 CPU_FTRS_40X =3D CPU_FTR_SPLIT_ID_CACHE | =
CPU_FTR_USE_TB |
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0 CPU_FTR_NODSISRALIGN,
> +=A0=A0=A0=A0=A0=A0 CPU_FTRS_44X =3D CPU_FTR_SPLIT_ID_CACHE | =
CPU_FTR_USE_TB |
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0 CPU_FTR_NODSISRALIGN,
> +=A0=A0=A0=A0=A0=A0 CPU_FTRS_E200 =3D CPU_FTR_USE_TB | =
CPU_FTR_NODSISRALIGN,
> +=A0=A0=A0=A0=A0=A0 CPU_FTRS_E500 =3D CPU_FTR_SPLIT_ID_CACHE | =
CPU_FTR_USE_TB |
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0 CPU_FTR_NODSISRALIGN,
> =A0=A0=A0=A0=A0=A0=A0 CPU_FTRS_E500_2 =3D CPU_FTR_SPLIT_ID_CACHE | =
CPU_FTR_USE_TB |
> -=A0=A0=A0=A0=A0=A0 =A0=A0=A0 CPU_FTR_BIG_PHYS,
> -=A0=A0=A0=A0=A0=A0 CPU_FTRS_GENERIC_32 =3D CPU_FTR_COMMON,
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0 CPU_FTR_BIG_PHYS | CPU_FTR_NODSISRALIGN,
> +=A0=A0=A0=A0=A0=A0 CPU_FTRS_GENERIC_32 =3D CPU_FTR_COMMON | =
CPU_FTR_NODSISRALIGN,
> =A0#ifdef __powerpc64__
> =A0=A0=A0=A0=A0=A0=A0 CPU_FTRS_POWER3 =3D CPU_FTR_SPLIT_ID_CACHE | =
CPU_FTR_USE_TB |
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 CPU_FTR_HPTE_TABLE | CPU_FTR_IABR,
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

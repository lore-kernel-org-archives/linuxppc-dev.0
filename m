Return-Path: <schivers@csc.com.au>
Received: from mail1.bemta8.messagelabs.com (mail1.bemta8.messagelabs.com
 [216.82.243.207])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4315A2C009E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 12:28:09 +1100 (EST)
In-Reply-To: <20140206082635.GA7048@visitor2.iram.es>
References: <OF784BA598.ACFE9DA4-ONCA257C76.00827472-CA257C77.000BCFAD@csc.com>
 <20140206082635.GA7048@visitor2.iram.es>
To: Gabriel Paubert <paubert@iram.es>
MIME-Version: 1.0
Subject: Re: arch/powerpc/math-emu/mtfsf.c - incorrect mask?
From: Stephen N Chivers <schivers@csc.com.au>
Message-ID: <OFA4C1AF9F.B23E83EC-ONCA257C78.00044235-CA257C78.00080D50@csc.com>
Date: Fri, 7 Feb 2014 11:27:57 +1000
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Chris Proctor <cproctor@csc.com.au>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Gabriel Paubert <paubert@iram.es> wrote on 02/06/2014 07:26:37 PM:

> From: Gabriel Paubert <paubert@iram.es>
> To: Stephen N Chivers <schivers@csc.com.au>
> Cc: linuxppc-dev@lists.ozlabs.org, Chris Proctor <cproctor@csc.com.au>
> Date: 02/06/2014 07:26 PM
> Subject: Re: arch/powerpc/math-emu/mtfsf.c - incorrect mask?
>=20
> On Thu, Feb 06, 2014 at 12:09:00PM +1000, Stephen N Chivers wrote:
> > I have a MPC8548e based board and an application that makes
> > extensive use of floating point including numerous calls to cos.
> > In the same program there is the use of an sqlite database.
> >=20
> > The kernel is derived from 2.6.31 and is compiled with math emulation.
> >=20
> > At some point after the reading of the SQLITE database, the
> > return result from cos goes from an in range value to an out
> > of range value.
> >=20
> > This is as a result of the FP rounding mode mutating from "round to=20
> > nearest"
> > to "round toward zero".
> >=20
> > The cos in the glibc version being used is known to be sensitive to=20
> > rounding
> > direction and Joseph Myers has previously fixed glibc.
> >=20
> > The failure does not occur on a machine that has a hardware floating
> > point unit (a MPC7410 processor).
> >=20
> > I have traced the mutation to the following series of instructions:
> >=20
> >         mffs            f0
> >         mtfsb1          4*cr7+so
> >         mtfsb0          4*cr7+eq
> >         fadd            f13,f1,f2
> >         mtfsf           1, f0
> >=20
> > The instructions are part of the stream emitted by gcc for the=20
conversion
> > of a 128 bit floating point value into an integer in the sqlite=20
database=20
> > read.
> >=20
> > Immediately before the execution of the mffs instruction the "rounding
> > mode" is "round to nearest".
> >=20
> > On the MPC8548 board, the execution of the mtfsf instruction does not
> > restore the rounding mode to "round to nearest".
> >=20
> > I believe that the mask computation in mtfsf.c is incorrect and is=20
> > reversed.
> >=20
> > In the latest version of the file (linux-3.14-rc1), the mask is=20
computed=20
> > by:
> >=20
> >                  mask =3D 0;
> >                  if (FM & (1 << 0))
> >                         mask |=3D 0x90000000;
> >                  if (FM & (1 << 1))
> >                         mask |=3D 0x0f000000;
> >                  if (FM & (1 << 2))
> >                         mask |=3D 0x00f00000;
> >                  if (FM & (1 << 3))
> >                         mask |=3D 0x000f0000;
> >                  if (FM & (1 << 4))
> >                         mask |=3D 0x0000f000;
> >                  if (FM & (1 << 5))
> >                         mask |=3D 0x00000f00;
> >                  if (FM & (1 << 6))
> >                         mask |=3D 0x000000f0;
> >                  if (FM & (1 << 7))
> >                         mask |=3D 0x0000000f;
> >=20
> > I think it should be:
> >=20
> >                 mask =3D 0;
> >                 if (FM & (1 << 0))
> >                         mask |=3D 0x0000000f;
> >                 if (FM & (1 << 1))
> >                         mask |=3D 0x000000f0;
> >                 if (FM & (1 << 2))
> >                         mask |=3D 0x00000f00;
> >                 if (FM & (1 << 3))
> >                         mask |=3D 0x0000f000;
> >                 if (FM & (1 << 4))
> >                         mask |=3D 0x000f0000;
> >                 if (FM & (1 << 5))
> >                         mask |=3D 0x00f00000;
> >                 if (FM & (1 << 6))
> >                         mask |=3D 0x0f000000;
> >                 if (FM & (1 << 7))
> >                         mask |=3D 0x90000000;
> >=20
> > With the above mask computation I get consistent results for both the=20
> > MPC8548
> > and MPC7410 boards.
> >=20
> > Am I missing something subtle?
>=20
> No I think you are correct. This said, this code may probably be=20
optimized=20
> to eliminate a lot of the conditional branches. I think that:
>=20
> mask =3D (FM & 1);
> mask |=3D (FM << 3) & 0x10;
> mask |=3D (FM << 6) & 0x100;
> mask |=3D (FM << 9) & 0x1000;
> mask |=3D (FM << 12) & 0x10000;
> mask |=3D (FM << 15) & 0x100000;
> mask |=3D (FM << 18) & 0x1000000;
> mask |=3D (FM << 21) & 0x10000000;
> mask *=3D 15;
>=20
> should do the job, in less code space and without a single branch.
>=20
> Each one of the "mask |=3D" lines should be translated into an
> rlwinm instruction followed by an "or". Actually it should be possible
> to transform each of these lines into a single "rlwimi" instruction
> but I don't know how to coerce gcc to reach this level of optimization.
>=20
> Another way of optomizing this could be:
>=20
> mask =3D (FM & 0x0f) | ((FM << 12) & 0x000f0000);
> mask =3D (mask & 0x00030003) | ((mask << 6) & 0x03030303);
> mask =3D (mask & 0x01010101) | ((mask << 3) & 0x10101010);
> mask *=3D 15;
>=20
> It's not easy to see which of the solutions is faster, the second one
> needs to create quite a few constants, but its dependency length is=20
> lower. It is very likely that the first solution is faster in cache-cold
> case and the second in cache-hot.=20
>=20
> Regardless, the original code is rather na=EFve, larger and slower in all=
=20
cases,
> with timing variation depending on branch mispredictions.

Thanks for the response, it is appreciated.

I have tried simple test versions of the two suggestions above, both
produce the same results as the original formulation.

My toolchain is gcc-4.1.2 with binutils 2.17.

When compiled without optimization I get:

        original        58 instructions 20 memory accesses 9 branches
        method1 53 instructions 27 memory accesses 0 branches
        method2 37 instructions 13 memory accesses 0 branches

with optimization:

        original        25 instructions 0 memory accesses 8 branches
        method1 18 instructions 0 memory accesses 0 branches
        method2 21 instructions 0 memory accesses 0 branches

The memory accesses do not include "setup" such as moving FM to
a register.

The instruction counts for method1 and method2 include an extra
and operation to preserve the original behaviour wrt the sticky
FX bit (I think) although maybe that is also something else
that it is wrong with the original implementation.

In my naivety I would go with method2 as it generates fewer
instructions when  not optimized and isn't far from method1 when
optimized.

I will await more comments before providing a patch next week.
>=20
>    Regards,
>    Gabriel

Stephen Chivers,
CSC Australia Pty. Ltd.

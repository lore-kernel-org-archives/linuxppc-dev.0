Return-Path: <paubert@iram.es>
Received: from navarro.puc.rediris.es (navarro.puc.rediris.es
 [IPv6:2001:720:418:ca01::131])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0A7072C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 21:10:57 +1100 (EST)
Date: Fri, 7 Feb 2014 11:10:36 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Stephen N Chivers <schivers@csc.com.au>
Subject: Re: arch/powerpc/math-emu/mtfsf.c - incorrect mask?
Message-ID: <20140207101036.GA823@visitor2.iram.es>
References: <OF784BA598.ACFE9DA4-ONCA257C76.00827472-CA257C77.000BCFAD@csc.com>
 <20140206082635.GA7048@visitor2.iram.es>
 <OFA4C1AF9F.B23E83EC-ONCA257C78.00044235-CA257C78.00080D50@csc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <OFA4C1AF9F.B23E83EC-ONCA257C78.00044235-CA257C78.00080D50@csc.com>
Cc: Chris Proctor <cproctor@csc.com.au>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

	Hi Stephen,

On Fri, Feb 07, 2014 at 11:27:57AM +1000, Stephen N Chivers wrote:
> Gabriel Paubert <paubert@iram.es> wrote on 02/06/2014 07:26:37 PM:
> 
> > From: Gabriel Paubert <paubert@iram.es>
> > To: Stephen N Chivers <schivers@csc.com.au>
> > Cc: linuxppc-dev@lists.ozlabs.org, Chris Proctor <cproctor@csc.com.au>
> > Date: 02/06/2014 07:26 PM
> > Subject: Re: arch/powerpc/math-emu/mtfsf.c - incorrect mask?
> > 
> > On Thu, Feb 06, 2014 at 12:09:00PM +1000, Stephen N Chivers wrote:
> > > I have a MPC8548e based board and an application that makes
> > > extensive use of floating point including numerous calls to cos.
> > > In the same program there is the use of an sqlite database.
> > > 
> > > The kernel is derived from 2.6.31 and is compiled with math emulation.
> > > 
> > > At some point after the reading of the SQLITE database, the
> > > return result from cos goes from an in range value to an out
> > > of range value.
> > > 
> > > This is as a result of the FP rounding mode mutating from "round to 
> > > nearest"
> > > to "round toward zero".
> > > 
> > > The cos in the glibc version being used is known to be sensitive to 
> > > rounding
> > > direction and Joseph Myers has previously fixed glibc.
> > > 
> > > The failure does not occur on a machine that has a hardware floating
> > > point unit (a MPC7410 processor).
> > > 
> > > I have traced the mutation to the following series of instructions:
> > > 
> > >         mffs            f0
> > >         mtfsb1          4*cr7+so
> > >         mtfsb0          4*cr7+eq
> > >         fadd            f13,f1,f2
> > >         mtfsf           1, f0
> > > 
> > > The instructions are part of the stream emitted by gcc for the 
> conversion
> > > of a 128 bit floating point value into an integer in the sqlite 
> database 
> > > read.
> > > 
> > > Immediately before the execution of the mffs instruction the "rounding
> > > mode" is "round to nearest".
> > > 
> > > On the MPC8548 board, the execution of the mtfsf instruction does not
> > > restore the rounding mode to "round to nearest".
> > > 
> > > I believe that the mask computation in mtfsf.c is incorrect and is 
> > > reversed.
> > > 
> > > In the latest version of the file (linux-3.14-rc1), the mask is 
> computed 
> > > by:
> > > 
> > >                  mask = 0;
> > >                  if (FM & (1 << 0))
> > >                         mask |= 0x90000000;
> > >                  if (FM & (1 << 1))
> > >                         mask |= 0x0f000000;
> > >                  if (FM & (1 << 2))
> > >                         mask |= 0x00f00000;
> > >                  if (FM & (1 << 3))
> > >                         mask |= 0x000f0000;
> > >                  if (FM & (1 << 4))
> > >                         mask |= 0x0000f000;
> > >                  if (FM & (1 << 5))
> > >                         mask |= 0x00000f00;
> > >                  if (FM & (1 << 6))
> > >                         mask |= 0x000000f0;
> > >                  if (FM & (1 << 7))
> > >                         mask |= 0x0000000f;
> > > 
> > > I think it should be:
> > > 
> > >                 mask = 0;
> > >                 if (FM & (1 << 0))
> > >                         mask |= 0x0000000f;
> > >                 if (FM & (1 << 1))
> > >                         mask |= 0x000000f0;
> > >                 if (FM & (1 << 2))
> > >                         mask |= 0x00000f00;
> > >                 if (FM & (1 << 3))
> > >                         mask |= 0x0000f000;
> > >                 if (FM & (1 << 4))
> > >                         mask |= 0x000f0000;
> > >                 if (FM & (1 << 5))
> > >                         mask |= 0x00f00000;
> > >                 if (FM & (1 << 6))
> > >                         mask |= 0x0f000000;
> > >                 if (FM & (1 << 7))
> > >                         mask |= 0x90000000;
> > > 
> > > With the above mask computation I get consistent results for both the 
> > > MPC8548
> > > and MPC7410 boards.
> > > 
> > > Am I missing something subtle?
> > 
> > No I think you are correct. This said, this code may probably be 
> optimized 
> > to eliminate a lot of the conditional branches. I think that:
> > 
> > mask = (FM & 1);
> > mask |= (FM << 3) & 0x10;
> > mask |= (FM << 6) & 0x100;
> > mask |= (FM << 9) & 0x1000;
> > mask |= (FM << 12) & 0x10000;
> > mask |= (FM << 15) & 0x100000;
> > mask |= (FM << 18) & 0x1000000;
> > mask |= (FM << 21) & 0x10000000;
> > mask *= 15;
> > 
> > should do the job, in less code space and without a single branch.
> > 
> > Each one of the "mask |=" lines should be translated into an
> > rlwinm instruction followed by an "or". Actually it should be possible
> > to transform each of these lines into a single "rlwimi" instruction
> > but I don't know how to coerce gcc to reach this level of optimization.
> > 
> > Another way of optomizing this could be:
> > 
> > mask = (FM & 0x0f) | ((FM << 12) & 0x000f0000);
> > mask = (mask & 0x00030003) | ((mask << 6) & 0x03030303);
> > mask = (mask & 0x01010101) | ((mask << 3) & 0x10101010);
> > mask *= 15;
> > 
> > It's not easy to see which of the solutions is faster, the second one
> > needs to create quite a few constants, but its dependency length is 
> > lower. It is very likely that the first solution is faster in cache-cold
> > case and the second in cache-hot. 
> > 
> > Regardless, the original code is rather naïve, larger and slower in all 
> cases,
> > with timing variation depending on branch mispredictions.
> 
> Thanks for the response, it is appreciated.
> 
> I have tried simple test versions of the two suggestions above, both
> produce the same results as the original formulation.
> 
> My toolchain is gcc-4.1.2 with binutils 2.17.
> 
> When compiled without optimization I get:
> 
>         original        58 instructions 20 memory accesses 9 branches
>         method1 53 instructions 27 memory accesses 0 branches
>         method2 37 instructions 13 memory accesses 0 branches
> 
> with optimization:
> 
>         original        25 instructions 0 memory accesses 8 branches
>         method1 18 instructions 0 memory accesses 0 branches
>         method2 21 instructions 0 memory accesses 0 branches
> 
> The memory accesses do not include "setup" such as moving FM to
> a register.
> 
> The instruction counts for method1 and method2 include an extra
> and operation to preserve the original behaviour wrt the sticky
> FX bit (I think) although maybe that is also something else
> that it is wrong with the original implementation.

These bits are not sticky, they are actually a logical combination 
of other bits in the register. The code in mtfsf.c recomputes 
the FPSCR_VX and FPSCR_VEX bits from the contents of the new FPSCR, 
so, unless I miss something, the and operation is unnecessary.

> In my naivety I would go with method2 as it generates fewer
> instructions when  not optimized and isn't far from method1 when
> optimized.

I would never count the size of non-optimized gcc code as a valid 
benchmark. At least -O1 is necessary to implement basic, trivial
optimizations, as you see in the number of memory accesses.

Ok, I finally edited my sources and test compiled the suggestions
I gave. I'd say that method2 is the best overall indeed. You can
actually save one more instruction by setting mask to all ones in 
the case FM=0xff, but that's about all in this area.

This said, there are better ways to write the end of the routine
to be more compact. The __FPU_FPSCR is a global variable which is
accessed very often, and it would be better to use more the local
fpscr variable. I see really stupid things in the code, for example
the following:

        and. 8,10,0      #, tmp184, D.11439
==>     stw 0,740(2)     # current.0_21->thread.fp_state.fpscr, D.11439
        beq- 0,.L4       #
        oris 0,0,0x2000  #, tmp188, D.11439,
==>     stw 0,740(2)     # current.0_21->thread.fp_state.fpscr, tmp188
.L4:
==>     lwz 0,740(9)     # current.0_21->thread.fp_state.fpscr, fpscr
        lis 11,0x2000    # tmp227,

(and yes gcc also copies around r2, the current thread pointer, to
other registers, for no good reason).

Anyway, the first step would be to get the current patch in, then
work on more optimizations.

	Regards,
	Gabriel

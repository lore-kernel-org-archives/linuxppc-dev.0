Return-Path: <paubert@iram.es>
Received: from rudy.puc.rediris.es (rudy.puc.rediris.es
 [IPv6:2001:720:418:ca01::132])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 82C092C009C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Feb 2014 20:09:11 +1100 (EST)
Date: Thu, 6 Feb 2014 09:26:37 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Stephen N Chivers <schivers@csc.com.au>
Subject: Re: arch/powerpc/math-emu/mtfsf.c - incorrect mask?
Message-ID: <20140206082635.GA7048@visitor2.iram.es>
References: <OF784BA598.ACFE9DA4-ONCA257C76.00827472-CA257C77.000BCFAD@csc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <OF784BA598.ACFE9DA4-ONCA257C76.00827472-CA257C77.000BCFAD@csc.com>
Cc: Chris Proctor <cproctor@csc.com.au>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 06, 2014 at 12:09:00PM +1000, Stephen N Chivers wrote:
> I have a MPC8548e based board and an application that makes
> extensive use of floating point including numerous calls to cos.
> In the same program there is the use of an sqlite database.
> 
> The kernel is derived from 2.6.31 and is compiled with math emulation.
> 
> At some point after the reading of the SQLITE database, the
> return result from cos goes from an in range value to an out
> of range value.
> 
> This is as a result of the FP rounding mode mutating from "round to 
> nearest"
> to "round toward zero".
> 
> The cos in the glibc version being used is known to be sensitive to 
> rounding
> direction and Joseph Myers has previously fixed glibc.
> 
> The failure does not occur on a machine that has a hardware floating
> point unit (a MPC7410 processor).
> 
> I have traced the mutation to the following series of instructions:
> 
>         mffs            f0
>         mtfsb1          4*cr7+so
>         mtfsb0          4*cr7+eq
>         fadd            f13,f1,f2
>         mtfsf           1, f0
> 
> The instructions are part of the stream emitted by gcc for the conversion
> of a 128 bit floating point value into an integer in the sqlite database 
> read.
> 
> Immediately before the execution of the mffs instruction the "rounding
> mode" is "round to nearest".
> 
> On the MPC8548 board, the execution of the mtfsf instruction does not
> restore the rounding mode to "round to nearest".
> 
> I believe that the mask computation in mtfsf.c is incorrect and is 
> reversed.
> 
> In the latest version of the file (linux-3.14-rc1), the mask is computed 
> by:
> 
>                  mask = 0;
>                  if (FM & (1 << 0))
>                         mask |= 0x90000000;
>                  if (FM & (1 << 1))
>                         mask |= 0x0f000000;
>                  if (FM & (1 << 2))
>                         mask |= 0x00f00000;
>                  if (FM & (1 << 3))
>                         mask |= 0x000f0000;
>                  if (FM & (1 << 4))
>                         mask |= 0x0000f000;
>                  if (FM & (1 << 5))
>                         mask |= 0x00000f00;
>                  if (FM & (1 << 6))
>                         mask |= 0x000000f0;
>                  if (FM & (1 << 7))
>                         mask |= 0x0000000f;
> 
> I think it should be:
> 
>                 mask = 0;
>                 if (FM & (1 << 0))
>                         mask |= 0x0000000f;
>                 if (FM & (1 << 1))
>                         mask |= 0x000000f0;
>                 if (FM & (1 << 2))
>                         mask |= 0x00000f00;
>                 if (FM & (1 << 3))
>                         mask |= 0x0000f000;
>                 if (FM & (1 << 4))
>                         mask |= 0x000f0000;
>                 if (FM & (1 << 5))
>                         mask |= 0x00f00000;
>                 if (FM & (1 << 6))
>                         mask |= 0x0f000000;
>                 if (FM & (1 << 7))
>                         mask |= 0x90000000;
> 
> With the above mask computation I get consistent results for both the 
> MPC8548
> and MPC7410 boards.
> 
> Am I missing something subtle?

No I think you are correct. This said, this code may probably be optimized 
to eliminate a lot of the conditional branches. I think that:

mask = (FM & 1);
mask |= (FM << 3) & 0x10;
mask |= (FM << 6) & 0x100;
mask |= (FM << 9) & 0x1000;
mask |= (FM << 12) & 0x10000;
mask |= (FM << 15) & 0x100000;
mask |= (FM << 18) & 0x1000000;
mask |= (FM << 21) & 0x10000000;
mask *= 15;

should do the job, in less code space and without a single branch.

Each one of the "mask |=" lines should be translated into an
rlwinm instruction followed by an "or". Actually it should be possible
to transform each of these lines into a single "rlwimi" instruction
but I don't know how to coerce gcc to reach this level of optimization.

Another way of optomizing this could be:

mask = (FM & 0x0f) | ((FM << 12) & 0x000f0000);
mask = (mask & 0x00030003) | ((mask << 6) & 0x03030303);
mask = (mask & 0x01010101) | ((mask << 3) & 0x10101010);
mask *= 15;

It's not easy to see which of the solutions is faster, the second one
needs to create quite a few constants, but its dependency length is 
lower. It is very likely that the first solution is faster in cache-cold
case and the second in cache-hot. 

Regardless, the original code is rather naïve, larger and slower in all cases,
with timing variation depending on branch mispredictions.

	Regards,
	Gabriel

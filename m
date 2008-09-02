Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 3B02CDDE06
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Sep 2008 23:12:47 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-dev@ozlabs.org
Subject: Re: Efficient memcpy()/memmove() for G2/G3 cores...
Date: Tue, 2 Sep 2008 15:12:09 +0200
References: <200808251131.02071.david.jander@protonic.nl>
	<200809010923.28616.david.jander@protonic.nl>
	<1220261775.5234.217.camel@gentoo-jocke.transmode.se>
In-Reply-To: <1220261775.5234.217.camel@gentoo-jocke.transmode.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200809021512.10132.david.jander@protonic.nl>
Cc: munroesj@us.ibm.com, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 01 September 2008 11:36:15 Joakim Tjernlund wrote:
>[...]
> > Then I started my test program with LD_PRELOAD=...
> >
> > My test program only copies big chunks of aligned memory, so it will only
> > test for maximum throughput (such as copying video frames). I will make a
> > better one, to measure throughput on different sized blocks of aligned
> > and unaligned memory, but first I want to find out why I can't seem to
> > get even close to the expected RAM bandwidth (bursts occur at 1.6
> > Gbyte/s, sustained transfers might be able to reach 400 Mbyte/s in
> > theory, taking into account the video controller eating almost half of
> > it, I'd like to get somewhere close to 200).
> >
> > The result is quite a bit better than that of glibc-2.7 (13.2 Mbyte/s -->
> > 22 Mbyte/s), but still far from the 71.5 Mbyte/s achieved when using
> > bigger strides of 16 registers load/store at a time.
> > Note, that this is copy performance, one-way througput should be double
> > these figures.
>
> Yeah, the code is trying to do a reasonable job without knowing what
> micro arch it is running on. These could probably go to glibc
> as new general purpose memxxx() routines. You will probably see
> a big increase once dcbz is added to the copy/memset functions.
>
> Fire away :)

Ok here I go:

I have made some astonishing discoveries, and I'd like to post the used 
source-code somewhere in the meantime, any suggestions? To this list?

There seem to be some substantial differences between the e300 core used in 
the MPC5200B and in the MPC5121e (besides the MPC5121 having double the 
amount of cache). Memcpy()-performance wise, these differences amount to the 
following. The tests done are with vanilla glibc (version 2.6.1 and 2.7 
without any powerpc specific memcpy() optimizations), Gunnar von Boehns 
memcpy_e300 and my tweaked version, memcpy_e300_dj which basically uses 
16-register strides instead of 4-register strides in Gunnar's example.

memcpy() peak-performance (RAM memory throughput) on:

MPC5200B, glibc-2.6, no optimizations: 136 Mbyte/s
MPC5121e, glibc-2.7, no optimizations:  30 Mbyte/s

MPC5200B, memcpy_e300: 225 Mbyte/s
MPC5121e, memcpy_e300: 130 Mbyte/s

MPC5200B, memcpy_e300_dj: 200 Mbyte/s
MPC5121e, memcpy_e300_dj: 202 Mbyte/s

For the MPC5121e, 16-register strides seem to be most optimal, whereas for the 
MPC5200B, 4-register stides give best performance. Also, plain C memcpy() 
performance on MPC5121e is terribly poor! Does enyone know why? I don't quite 
seem to understand those results.

Some information on the test hardware:

MPC5200B-based board has 64 Mbyte DDR-SDRAM, 32-bit wide (two x16 chips), 
running ubuntu 7.10 with kernel 2.6.19.2.

MPC5121e-based board has 256 Mbyte DDR2-SDRAM, 32-bit wide (two x16 chips), 
running ubuntu 8.04.1 with kernel 2.6.24.5 from Freescale LTIB with the DIU 
turned OFF. When the DIU is turned on, maximum throughput drops from 202 to 
196 Mbyte/s.

memcpy_e300 variants basically use 4 or 16-register load/store strides, cache 
alignment and dcbz/bcbt cache-manipulation instructions to tweak performance.

I have not tried interleaving integer and fpu instructions.

Does anybody have any suggestion about where to start searching for an 
explaination of these results? I have the impression that there is something 
wrong with my setup, or with the e300c4-core, or both, but what????

Greetings,

-- 
David Jander

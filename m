Return-Path: <paubert@iram.es>
Received: from torres.puc.rediris.es (torres.puc.rediris.es
 [IPv6:2001:720:418:ca00::9])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B72D02C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Feb 2014 23:21:55 +1100 (EST)
Date: Mon, 10 Feb 2014 13:21:38 +0100
From: Gabriel Paubert <paubert@iram.es>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: arch/powerpc/math-emu/mtfsf.c - incorrect mask?
Message-ID: <20140210122138.GA30356@visitor2.iram.es>
References: <OF784BA598.ACFE9DA4-ONCA257C76.00827472-CA257C77.000BCFAD@csc.com>
 <20140206082635.GA7048@visitor2.iram.es>
 <OFA4C1AF9F.B23E83EC-ONCA257C78.00044235-CA257C78.00080D50@csc.com>
 <20140207101036.GA823@visitor2.iram.es>
 <alpine.LRH.2.00.1402071348380.10318@ra8135-ec1.am.freescale.net>
 <20140210110342.GA15806@visitor2.iram.es>
 <063D6719AE5E284EB5DD2968C1650D6D0F6BBCE9@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D0F6BBCE9@AcuExch.aculab.com>
Cc: James Yang <James.Yang@freescale.com>, Chris Proctor <cproctor@csc.com.au>,
 Stephen N Chivers <schivers@csc.com.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 10, 2014 at 11:17:38AM +0000, David Laight wrote:
> > > However, your other solutions are better.
> > >
> > >
> > > > > >
> > > > > > mask = (FM & 1);
> > > > > > mask |= (FM << 3) & 0x10;
> > > > > > mask |= (FM << 6) & 0x100;
> > > > > > mask |= (FM << 9) & 0x1000;
> > > > > > mask |= (FM << 12) & 0x10000;
> > > > > > mask |= (FM << 15) & 0x100000;
> > > > > > mask |= (FM << 18) & 0x1000000;
> > > > > > mask |= (FM << 21) & 0x10000000;
> > > > > > mask *= 15;
> > > > > >
> > > > > > should do the job, in less code space and without a single branch.
> ...
> > > > > > Another way of optomizing this could be:
> > > > > >
> > > > > > mask = (FM & 0x0f) | ((FM << 12) & 0x000f0000);
> > > > > > mask = (mask & 0x00030003) | ((mask << 6) & 0x03030303);
> > > > > > mask = (mask & 0x01010101) | ((mask << 3) & 0x10101010);
> > > > > > mask *= 15;
> ...
> > Ok, if you have measured that method1 is faster than method2, let us go for it.
> > I believe method2 would be faster if you had a large out-of-order execution
> > window, because more parallelism can be extracted from it, but this is probably
> > only true for high end cores, which do not need FPU emulation in the first place.
> 
> FWIW the second has a long dependency chain on 'mask', whereas the first can execute
> the shift/and in any order and then merge the results.
> So on most superscalar cpu, or one with result delays for arithmetic, the first
> is likely to be faster.

I disagree, perhaps mostly because the compiler is not clever enough, but right
now the code for solution 1 is (actually I have rewritten the code
and it reads:

	mask = (FM & 1)
			| ((FM << 3) & 0x10)
			| ((FM << 6) & 0x100)
			| ((FM << 9) & 0x1000)
			| ((FM << 12) & 0x10000)
			| ((FM << 15) & 0x100000)
			| ((FM << 18) & 0x1000000)
			| ((FM << 21) & 0x10000000);
to avoid sequence point in case it hampers the compiler)

and the output is:

        rlwinm 10,3,3,27,27      # D.11621, FM,,
        rlwinm 9,3,6,23,23       # D.11621, FM,,
        or 9,10,9        #, D.11621, D.11621, D.11621
        rlwinm 10,3,0,31,31      # D.11621, FM,
        or 9,9,10        #, D.11621, D.11621, D.11621
        rlwinm 10,3,9,19,19      # D.11621, FM,,
        or 9,9,10        #, D.11621, D.11621, D.11621
        rlwinm 10,3,12,15,15     # D.11621, FM,,
        or 9,9,10        #, D.11621, D.11621, D.11621
        rlwinm 10,3,15,11,11     # D.11621, FM,,
        or 9,9,10        #, D.11621, D.11621, D.11621
        rlwinm 10,3,18,7,7       # D.11621, FM,,
        or 9,9,10        #, D.11621, D.11621, D.11621
        rlwinm 3,3,21,3,3        # D.11621, FM,,
        or 9,9,3         #, mask, D.11621, D.11621
        mulli 9,9,15     # mask, mask,

see that r9 is used 7 times as both input and output operand, plus
once for rlwinm. This gives a dependency length of 8 at least.

In the other case (I've deleted the code) the dependency length
was significantly shorter. In any case that one is fewer instructions, 
which is good for occasional use. 

	Gabriel

Message-ID: <3BD83D3C.17FB9DD8@mvista.com>
Date: Thu, 25 Oct 2001 11:26:36 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: "ibm405.linux" <ibm405.linux@laposte.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405GP Dhrystone Benchmark
References: <AEEDJHMEPHBIHBAHOOCDIELKCAAA.ogoh@asu.edu> <3BD82D8A.F0DC3B77@mvista.com> <3BD8338B.B93FCF3C@laposte.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"ibm405.linux" wrote:
>
> Hi,
>
> Does anyone perform Dhrystone 2.1 benchmark with a 405GP  ?
> I've tried and i got : 172 Mips  (Walnut board @200Mhz, HHL2.0).
> I've also tried to run the same benchmark with the same board with the
> basic_os and the ibm "highcppc" compiler and i found
> 237 Mips (the 405GP specifications give 282 Mips @200Mhz, they told me that
> was obtained with a Diab compiler).
> Is there any reason my result (172 Mips) is so far from ~240 Mips.
> (i've used  : ppc_405-gcc   -DUNIX -DROPT -O2 -fomit-frame-pointer   dhry21a.c
> dhry21b.c timers_b.c -o dhry21 )

(To truely do a valid test you need to compare the compiler output when
running on the same OS, otherwise the numbers can not be validly
compared due to OS overhead, i.e. context switching.... but to address
you compiler question...)

This is just a guess... but...

GCC is a "generic" compiler.  It is designed to run on as many platforms
as possible and as such has to make some specific performance sacrifices
to remain portable.

Whereas IBM has the resources to make a compiler that is ultra fast on a
PPC system, it probably doesn't work (or at least wouldn't be the same
code-base) on say an intel system, HPPA, sh, mips, arm, etc systems..

So you are trading compatability for speeds.  (In most cases
compatability wins..)  For example think of the TiVo.  The hardware is
one component of the system, but the software is the true masterpiece.
If TiVo decides that the PPC isn't the best hardware or they can get
cheaper parts from another supplier they don't need to completely port
their code to a new compiler.  (Assuming no assembly) they could take
their user code and recompile it for another architecture.  They could
also maintain a code base between processors and update older and newer
units.  (This is all obviously hypothetical...)

The other thing to keep in mind is that some compilers (*note: I have
never used "diab" before so I am talking generically*) have been known
to have specific optimizations that boost performance benchmarks but do
little or not good in the real world.

Moral of the story, if you plan on using Linux, plan to use GCC.  If GCC
isn't fast enough for you, you have two options.

1) Find a commericial compiler that will produce Linux binaries
2) Help find and improve GCC

(2 is the preferable approach...)

--Mark
(I don't normally add this disclaimer, but these are my opinions and not
my employer's!)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

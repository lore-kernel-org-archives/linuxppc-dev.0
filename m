Message-Id: <200002030826.JAA27945@denx.local.net>
To: greyham@research.canon.com.au (Graham Stoney)
cc: alan@packetengines.com (Alan Mimms),
        linuxppc-embedded@lists.linuxppc.org (Linux PPC Embedded)
Subject: Re: Using LinuxPPC executables on 8xx processors
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 03 Feb 2000 16:25:32 +1100."
             <20000203052532.A3A581B568@elph.research.canon.com.au>
Date: Thu, 03 Feb 2000 09:26:21 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20000203052532.A3A581B568@elph.research.canon.com.au>
Graham Stoney writes:
>
> I believe you just answered your own question: You can indeed use dynamically
> linked LinuxPPC executables directly on MPC8xx targets. However, you need
> to rebuild the shared library they link against at runtime as Wolfgang
> describes. Note that memset.S and dl-machine.c are in the shared library, and
> not in the dynamically linked executables.

Well, in fact even the original (for instance LinuxPPC  R4)  binaries
*and*  libraries run pretty stable on the MPC8xx system once you have
the FPU emulation working. It seems that the cache line problem  does
not  show  up most of the time. So if you are running a test environ-
ment, where you occassionally need this tool or another, you may just
ignore this for a while.

However, for a production system which must run stable I recommend to
recompile the included libs and bins with (1) the the cache line size
adjusted and (2) soft-float (or - even better -avoid FP suff at all).


Finally: credit where credit is due. All I did was  putting  together
some  scripts to build the tools and libs - but most of the patches I
include where contributed by other people here on the list.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Living on Earth may be expensive, but it includes an annual free trip
around the Sun.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

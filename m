In-Reply-To: <Pine.LNX.4.05.10001261719320.12616-100000@callisto.of.borg>
Date: Wed, 26 Jan 2000 18:23:14 +0100
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: [linux-fbdev] Re: Fwd: Re: still no accelerated X ($#!$*)
Message-Id: <20000126182314.015542@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 26, 2000, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

>Very simple, cfr. include/asm-ppc/system.h:
>
>/*
> * Memory barrier.
> * The sync instruction guarantees that all memory accesses initiated
> * by this processor have been performed (with respect to all other
> * mechanisms that access memory).  The eieio instruction is a barrier
> * providing an ordering (separately) for (a) cacheable stores and (b)
> * loads and stores to non-cacheable memory (e.g. I/O devices).
> *
> * mb() prevents loads and stores being reordered across this point.
> * rmb() prevents loads being reordered across this point.
> * wmb() prevents stores being reordered across this point.
> *
> * We can use the eieio instruction for wmb, but since it doesn't
> * give any ordering guarantees about loads, we have to use the
> * stronger but slower sync instruction for mb and rmb.
> */
>#define mb()  __asm__ __volatile__ ("sync" : : : "memory")
>#define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
>#define wmb()  __asm__ __volatile__ ("eieio" : : : "memory")
>
>The *mb() macro's are portable across the different architectures
supported by
>Linux. Yes, *mb are Alpha mnemonics :-)

The semantics used here are a bit strange. Definitely sync is evil and
should be avoided except in rare few cases. It's not a memory barrier,
it's a lot more since it ensure synchronisation on the bus, inter-cpu
synchro, and interrupt synchro. It eats a lot of cycles on SMP configs
and with recent G3/G4 CPUs.

eieio is used for wmb, but it actually works for both reads and writes
provided that you actually want a _memory access_ barrier and not an
interrupt barrier or other means of syncing CPUs on the bus.

Note that include/asm/io.h contains iobarrer macros which are better
suited for io operations.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Wed, 26 Jan 2000 17:20:59 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James A Simmons <jsimmons@acsu.buffalo.edu>
cc: Benjamin Herrenschmidt <bh40@calva.net>, khendricks@ivey.uwo.ca,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Re: Fwd: Re: still no accelerated X ($#!$*)
In-Reply-To: <Pine.GSO.4.05.10001261006570.12458-100000@callisto.acsu.buffalo.edu>
Message-ID: <Pine.LNX.4.05.10001261719320.12616-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 26 Jan 2000, James A Simmons wrote:
>   I have seen alot of talk about wmb() and eieio(). Where can I find docs
> on these functions and how to program driver correctly using them? Thank
> you.

Very simple, cfr. include/asm-ppc/system.h:

/*
 * Memory barrier.
 * The sync instruction guarantees that all memory accesses initiated
 * by this processor have been performed (with respect to all other
 * mechanisms that access memory).  The eieio instruction is a barrier
 * providing an ordering (separately) for (a) cacheable stores and (b)
 * loads and stores to non-cacheable memory (e.g. I/O devices).
 *
 * mb() prevents loads and stores being reordered across this point.
 * rmb() prevents loads being reordered across this point.
 * wmb() prevents stores being reordered across this point.
 *
 * We can use the eieio instruction for wmb, but since it doesn't
 * give any ordering guarantees about loads, we have to use the
 * stronger but slower sync instruction for mb and rmb.
 */
#define mb()  __asm__ __volatile__ ("sync" : : : "memory")
#define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
#define wmb()  __asm__ __volatile__ ("eieio" : : : "memory")

The *mb() macro's are portable across the different architectures supported by
Linux. Yes, *mb are Alpha mnemonics :-)

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

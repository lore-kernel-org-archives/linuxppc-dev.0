From: Gabriel Paubert <paubert@iram.es>
Date: Fri, 14 May 2004 11:11:56 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bryan Rittmeyer <bryan@staidm.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: IBM 750GX SMP on Marvell Discovery II or III?
Message-ID: <20040514091156.GA30680@iram.es>
References: <3B3163BD-A2F0-11D8-95B9-003065F9B7DC@embeddededge.com> <16544.16999.648530.393071@cargo.ozlabs.ibm.com> <517E783F-A362-11D8-942E-003065F9B7DC@embeddededge.com> <16545.27647.651552.393992@cargo.ozlabs.ibm.com> <20040512080024.GA26628@iram.es> <16546.3723.214235.623354@cargo.ozlabs.ibm.com> <20040512134551.GB31780@iram.es> <Pine.GSO.4.58.0405121619110.19967@waterleaf.sonytel.be> <20040513043055.GB11357@staidm.org> <Pine.GSO.4.58.0405141001001.27660@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.58.0405141001001.27660@waterleaf.sonytel.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, May 14, 2004 at 10:02:10AM +0200, Geert Uytterhoeven wrote:
>
> On Wed, 12 May 2004, Bryan Rittmeyer wrote:
> > On Wed, May 12, 2004 at 04:21:04PM +0200, Geert Uytterhoeven wrote:
> > > Solution: divide memory in pieces, run multiple instances of Linux, each on its
> > > own CPU and memory piece, and use a piece of uncached RAM for implementing
> > > communication channels between CPUs ;-)
> >
> > Non-cacheable I/O throughput on the 60x bus is horrid; might be better to put a
> > 1000Mbps NIC on each CPU and cable em together ;-\
>
> You can always put the real data in cacheable memory, and keep only some
> control descriptors in uncached memory. Needs some explicit cache handling, but
> should be faster.

No the problem was the coherency of instruction and data caches. Data
caches are just coherent, no shared state so you'd rather avoid having
two processors actively reading from the same cache lines, but that's
about all. Just map them through a non-execute segment so that you are
sure that the

Hmmm, now that I tinbk of it, this means that one processor fetching
an instruction line will invalidate the same cache line in the L2 cache
of the other processor. Which means that the L2 cache is actually
useless for sharing code and you might actually force it to only cache
data by fiddling with HID0.

Well, MEI caches are actually worse than what I believed for SMP. They
work well enough for UP with DMA.

	Gabriel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14790.58502.25252.825448@argo.linuxcare.com.au>
Date: Tue, 19 Sep 2000 14:59:02 +1100 (EST)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
In-Reply-To: <Pine.LNX.4.10.10009172058340.715-100000@cassiopeia.home>
References: <Pine.LNX.4.10.10009172058340.715-100000@cassiopeia.home>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven writes:

[snip]
> +extern void *__ioremap_at(unsigned long phys, unsigned long size,
> +			  unsigned long flags);

> and wondered what __ioremap_at() is used for? It's nowhere defined.

Ah, did that leak into the patch?  It didn't need to go in but it
doesn't hurt I guess.

What I am intending to do is to map the I/O space of all the PCI host
bridges in consecutive areas beginning at some address such as
0xff000000, with some amount of space such as 64kB or 1MB per bridge,
whatever is appropriate.  Then we adjust the I/O port numbers in the
pci_dev structures by adding on host_bridge_nr * space_per_bridge.  As
a side effect, isa_io_base (which is really pci_io_base) becomes a
constant.

To do this we need a version of ioremap which takes a virtual address
as well as a physical address.  This is what __ioremap_at was intended
to be.  I got as far as duplicating the __ioremap declaration before
deciding that I needed to think about it a bit more. :-)

Specifically I need some input from people working on 8xx and prep
systems as to whether this idea will cause any problems.  It may make
it more difficult to use a BAT to map I/O regions.  I notice that prep
still uses isa_io_base = 0x80000000 and maps the whole 256MB starting
at 0x80000000 with a BAT.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <39C77803.F182709E@mvista.com>
Date: Tue, 19 Sep 2000 10:28:19 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
References: <Pine.LNX.4.10.10009172058340.715-100000@cassiopeia.home> <14790.58502.25252.825448@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> What I am intending to do is to map the I/O space of all the PCI host
> bridges in consecutive areas beginning at some address such as
> 0xff000000,

Hmmm.....

> To do this we need a version of ioremap which takes a virtual address
> as well as a physical address.

Hmmm.....


> Specifically I need some input from people working on 8xx and prep
> systems as to whether this idea will cause any problems.

OK.  On the 8xx, I currently rely on the effect that ioremap will
map virt->phys 1:1 before the kernel VM is initialized.  Often this
is space above 0xf0000000.  Since I understand what you are trying to
do, I can probably change this will little effort.  This brings up
another question....what happens if you ioremap before VM is set up?
Mapping through BATs usually covers most of this, but more processors
arriving (the IBM 4xx) don't have BATs either so we rely on page
tables of some sort.

The PReP machines (and I thought most systems) flip back and forth
between VM not/enabled during start up, and have a few things like
UARTs mapped 1:1 virt->phys (at least for debug).

In general, I like what you are doing because I am struggling to
find a better I/O mapping solution for some of these embedded
processors.  In particular I need a bus_to_virt() (or whatever we
call it) that can work on mapped addresses.  I was thinking about
fixing some virtual address ranges so I could do this more easily,
and you are sort of doing the same.

> .....  It may make
> it more difficult to use a BAT to map I/O regions.  I notice that prep
> still uses isa_io_base = 0x80000000 and maps the whole 256MB starting
> at 0x80000000 with a BAT.

Yes, that is a pretty nice feature......

I'm thinking.....(I'm thinking that Matt Porter should provide some
insight....he is used to working with Linux/PPC on systems with a
dozen or so PCI bridges....and likes it :-).


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

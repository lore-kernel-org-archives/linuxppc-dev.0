Date: Tue, 19 Sep 2000 15:06:21 -0700
From: Matt Porter <mporter@mvista.com>
To: Paul Mackerras <paulus@linuxcare.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
Message-ID: <20000919150621.A9826@cx258813-a.chnd1.az.home.com>
References: <Pine.LNX.4.10.10009172058340.715-100000@cassiopeia.home> <14790.58502.25252.825448@argo.linuxcare.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14790.58502.25252.825448@argo.linuxcare.com.au>; from paulus@linuxcare.com.au on Tue, Sep 19, 2000 at 02:59:02PM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Sep 19, 2000 at 02:59:02PM +1100, Paul Mackerras wrote:
> What I am intending to do is to map the I/O space of all the PCI host
> bridges in consecutive areas beginning at some address such as
> 0xff000000, with some amount of space such as 64kB or 1MB per bridge,
> whatever is appropriate.  Then we adjust the I/O port numbers in the
> pci_dev structures by adding on host_bridge_nr * space_per_bridge.  As
> a side effect, isa_io_base (which is really pci_io_base) becomes a
> constant.

Specifically, what problem are you trying to solve with this
implementation?  I gather that we're talking about the legacy I/O
problem that the kernel has.  What are the cases where you need
to use in*/out* calls targetting devices on host bridges other
than the "primary" one?

I recently did a port to the SBS K2 cPCI board which involves the
IBM CPC710 dual host bridge.  Due to the multi host bridge legacy
I/O difficulty, a documented assumption is that legacy I/O calls
would only be used on the "primary" host bridge.  I realize there
are plenty of drivers (like de4x5) that insist on using inw/outw
(and thus break on host bridge 2) but these drivers should be
fixed.

In the long run, the legacy I/O compatibility calls need to be
completely wiped out for non-x86 architectures.  It is all
memory mapped after all and only a few drivers like serial and
IDE would need separate low level access paths for x86/non-x86
architectures.

If we want a short term solution why not just per architecture
fixups to the pci_dev entries with the appropriate offsets when
on a multi host bridge machine?  This allows each architecture/board
maximum flexibility with their memory map and BAT settings.

> To do this we need a version of ioremap which takes a virtual address
> as well as a physical address.  This is what __ioremap_at was intended
> to be.  I got as far as duplicating the __ioremap declaration before
> deciding that I needed to think about it a bit more. :-)
>
> Specifically I need some input from people working on 8xx and prep
> systems as to whether this idea will cause any problems.  It may make
> it more difficult to use a BAT to map I/O regions.  I notice that prep
> still uses isa_io_base = 0x80000000 and maps the whole 256MB starting
> at 0x80000000 with a BAT.

If we can't cover I/O with a BAT then it will definitely have some
ramifications with serial ports in the legacy I/O range among other
things.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

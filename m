From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14791.61311.118516.747495@argo.linuxcare.com.au>
Date: Wed, 20 Sep 2000 09:58:07 +1100 (EST)
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
In-Reply-To: <20000919150621.A9826@cx258813-a.chnd1.az.home.com>
References: <Pine.LNX.4.10.10009172058340.715-100000@cassiopeia.home>
	<14790.58502.25252.825448@argo.linuxcare.com.au>
	<20000919150621.A9826@cx258813-a.chnd1.az.home.com>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Matt Porter writes:

> On Tue, Sep 19, 2000 at 02:59:02PM +1100, Paul Mackerras wrote:
> > What I am intending to do is to map the I/O space of all the PCI host
> > bridges in consecutive areas beginning at some address such as
> > 0xff000000, with some amount of space such as 64kB or 1MB per bridge,
> > whatever is appropriate.  Then we adjust the I/O port numbers in the
> > pci_dev structures by adding on host_bridge_nr * space_per_bridge.  As
> > a side effect, isa_io_base (which is really pci_io_base) becomes a
> > constant.
>
> Specifically, what problem are you trying to solve with this
> implementation?  I gather that we're talking about the legacy I/O
> problem that the kernel has.  What are the cases where you need
> to use in*/out* calls targetting devices on host bridges other
> than the "primary" one?

This is the situation: you have a machine with 2 or more PCI host
bridges.  You plug a board into the PCI bus behind the 2nd host
bridge.  The board has registers in PCI I/O space.  An address is
assigned for those registers in the BAR in config space.  If you read
the BAR and then do an inb from that port number, you don't get the
I/O port on your board.

One solution that has been proposed is to set the base I/O port number
in the pci_dev structure to be actually the virtual address where you
can access that I/O port.  I don't like that solution because it means
that drivers for legacy PC-style devices can't do inb/outb to the
usual well-known port numbers and find the device they expect.  For
example, inb(0x3f8) won't access the first serial port (this is on
machines such as prep and some chrp which have a lot of PC-style
devices).

My solution is to allocate say 1MB of I/O space per host bridge and
then adjust the pci_dev structures for the devices behind the 2nd and
subsequent host bridges.  So for example a board that has I/O ports at
0x1000 behind the 2nd host bridge would end up with its
pci_dev->resource[0].start == 0x101000.  The virtual <-> physical
mappings are set up so that the 2nd host bridge's I/O space is mapped
in starting at 0xff100000.  The result is that doing inb(0x101000)
accesses the device as expected.

> I recently did a port to the SBS K2 cPCI board which involves the
> IBM CPC710 dual host bridge.  Due to the multi host bridge legacy
> I/O difficulty, a documented assumption is that legacy I/O calls
> would only be used on the "primary" host bridge.  I realize there
> are plenty of drivers (like de4x5) that insist on using inw/outw
> (and thus break on host bridge 2) but these drivers should be
> fixed.

Fixed how?  I mean, how are you generically going to access PCI I/O
space without using inw/outw etc.?  On intel that is the only possible
way to do it so I just cannot see that you will persuade driver
authors that they shouldn't use inw/outw.

> In the long run, the legacy I/O compatibility calls need to be
> completely wiped out for non-x86 architectures.  It is all
> memory mapped after all and only a few drivers like serial and
> IDE would need separate low level access paths for x86/non-x86
> architectures.

I disagree.  There will always be PCI devices with registers in PCI
I/O space.  I really don't want to see a situation where drivers get
littered with ifdefs because you have to use different access
functions for accessing PCI I/O space on non-intel machines and intel
machines.  That would be just totally counter-productive.

> If we can't cover I/O with a BAT then it will definitely have some
> ramifications with serial ports in the legacy I/O range among other
> things.

Why?  Are you concerned about very early debugging?  If not, what?

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

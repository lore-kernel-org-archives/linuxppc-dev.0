Message-ID: <39C8DE1A.BC8EF0B6@mvista.com>
Date: Wed, 20 Sep 2000 11:56:10 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
References: <Pine.LNX.4.10.10009172058340.715-100000@cassiopeia.home>
		<14790.58502.25252.825448@argo.linuxcare.com.au>
		<20000919150621.A9826@cx258813-a.chnd1.az.home.com> <14791.61311.118516.747495@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:


> ....  The virtual <-> physical
> mappings are set up so that the 2nd host bridge's I/O space is mapped
> in starting at 0xff100000.  The result is that doing inb(0x101000)
> accesses the device as expected.

You still have to be careful here.  Drivers that are written to
do this may also make the assumption they can store that "address"
in a 16-bit (signed, even worse) variable.  You will have to change
drivers (or structures) in this case.

I don't so much care if in/out is used/abused, but I think device
drivers should be written such that they ask for addresses through
the PCI (or other I/O) subsystem, rather than just grab BARs and
expect to use them.  The x86 in/out was stupid back in 1983, and is
even less useful today.  It is lots easier to adopt a memory mapped
model and adapt it to x86, than for the rest of us to keep trying to
create contortions of an address map just so we can use poorly written
x86 device drivers.  I think it is easier to update a driver, which
I have done on a couple of occasions, to be more portable than to
try and find ways to use it without making any changes.  The authors
of the drivers have even accepted this in some cases :-).

These address mapping hacks were fine years ago when there was
only one PCI bus at a fixed address in the system.  Today, there
are lots of busses, with transparent (or not) bridges, and we have
a PCI subsystem in Linux that is maturing into a really useful set of
functions.  The embedded CompactPCI systems are way ahead of workstations
in terms of complexity of PCI (and other) bus structures.  In these
environments we rely heavily on the virtual mapping of I/O, and if
you have a BAR it doesn't mean much to your driver.  I would like to
see us look toward the future, to a model where we map I/O through
the VM subsystem, instead of trying to find hacks to support addressing
assumptions that just aren't valid any longer.


	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

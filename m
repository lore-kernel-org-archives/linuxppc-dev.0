From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14793.18115.38314.912204@argo.linuxcare.com.au>
Date: Thu, 21 Sep 2000 10:22:42 +1100 (EST)
To: Dan Malek <dan@mvista.com>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
In-Reply-To: <39C8DE1A.BC8EF0B6@mvista.com>
References: <Pine.LNX.4.10.10009172058340.715-100000@cassiopeia.home>
	<14790.58502.25252.825448@argo.linuxcare.com.au>
	<20000919150621.A9826@cx258813-a.chnd1.az.home.com>
	<14791.61311.118516.747495@argo.linuxcare.com.au>
	<39C8DE1A.BC8EF0B6@mvista.com>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek writes:

> You still have to be careful here.  Drivers that are written to
> do this may also make the assumption they can store that "address"
> in a 16-bit (signed, even worse) variable.  You will have to change
> drivers (or structures) in this case.

Sure.  Fortunately PPC isn't the only architecture where I/O ports can
be > 16 bits, I believe sparc64 runs into this too.  In fact sparc64
needs 32-bit interrupt numbers rather than 8-bit, as well.

> I don't so much care if in/out is used/abused, but I think device
> drivers should be written such that they ask for addresses through
> the PCI (or other I/O) subsystem, rather than just grab BARs and

Definitely, for drivers for PCI devices.

> expect to use them.  The x86 in/out was stupid back in 1983, and is
> even less useful today.  It is lots easier to adopt a memory mapped
> model and adapt it to x86, than for the rest of us to keep trying to
> create contortions of an address map just so we can use poorly written

"Virtual != physical" is "contortions" ???

> x86 device drivers.  I think it is easier to update a driver, which
> I have done on a couple of occasions, to be more portable than to
> try and find ways to use it without making any changes.  The authors
> of the drivers have even accepted this in some cases :-).

I suggest you post a patch on linux-kernel to change all the device
drivers to use memory-mapped I/O.  I wish you luck.  :-) :-)

> These address mapping hacks were fine years ago when there was
> only one PCI bus at a fixed address in the system.  Today, there
> are lots of busses, with transparent (or not) bridges, and we have
> a PCI subsystem in Linux that is maturing into a really useful set of
> functions.  The embedded CompactPCI systems are way ahead of workstations
> in terms of complexity of PCI (and other) bus structures.  In these
> environments we rely heavily on the virtual mapping of I/O, and if
> you have a BAR it doesn't mean much to your driver.  I would like to
> see us look toward the future, to a model where we map I/O through
> the VM subsystem, instead of trying to find hacks to support addressing
> assumptions that just aren't valid any longer.

You'll have to explain this a little more.  When you say "virtual
mapping of I/O", do you mean I/O devices in PCI memory space or in PCI
I/O space?  We (of course) already map I/O registers in PCI memory
space through the VM subsystem.  Are you talking about PCI I/O space?
What sorts of VM mapping tricks do you want to do for PCI I/O space,
and why?

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

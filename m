From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14794.54989.87038.231729@argo.linuxcare.com.au>
Date: Fri, 22 Sep 2000 14:49:33 +1100 (EST)
To: Dan Malek <dan@mvista.com>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
In-Reply-To: <39C9AFE2.25CB0ADA@mvista.com>
References: <Pine.LNX.4.10.10009172058340.715-100000@cassiopeia.home>
	<14790.58502.25252.825448@argo.linuxcare.com.au>
	<20000919150621.A9826@cx258813-a.chnd1.az.home.com>
	<14791.61311.118516.747495@argo.linuxcare.com.au>
	<39C8DE1A.BC8EF0B6@mvista.com>
	<14793.18115.38314.912204@argo.linuxcare.com.au>
	<39C96EBC.6BE23535@mvista.com>
	<14793.29680.948198.119368@argo.linuxcare.com.au>
	<39C98739.B3656E8F@mvista.com>
	<14793.38735.809789.111193@argo.linuxcare.com.au>
	<39C9AFE2.25CB0ADA@mvista.com>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek writes:

> > I think my basic point is that a setup where you can't do inb(n) to
> > read the byte at address n in PCI I/O space is broken.
>
> I agree.  I am not suggesting you shouldn't.  I'm just discussing
> what 'n' should be :-).

I think the only thing that makes sense is to say that `n' is the
value that the device sees on the PCI AD lines during the address
cycle.  It's the value that gets compared with the value in the
device's BARs.

This discussion has been useful, it has convinced me that we really
should have just one I/O space (or at least the illusion of a single
I/O space), not one I/O space per host bridge.  We should arrange that
PCI boards behind different host bridges are not assigned I/O
addresses in the same 4k range and then set up the virtual -> physical
mapping appropriately.

What I mean by that is that for each 4k range, say starting at i, we
identify which bridge `b' has stuff in that 4k range and then map
virtual _IO_BASE + i to physical io_base(b) + i, where io_base(b) is
the I/O physical base address for bridge b.  In other words we are
mapping the physical addresses where each bridge has its I/O space to
the same virtual area, and just mapping through the 4k regions where
each bridge has stuff.

> The "handle" (address) you use in the in/out or read/write will be
> mapped through the MMU of any processor other than the x86.  On the

Not correct actually, on sparc64 it is actually a physical address,
for read/write at least.

> > Huh???  the drivers won't have to be changed, they just go on doing
> > inb(pci_dev->resource[0].start) or whatever
>
> Ahhhh...OK....here we go...examples :-).  I contend that access is
> wrong...

No, it's correct.  I was going through my old emails yesterday and I
found this email from Dave Miller to linux-kernel:

>    Does this means that there is no way to mmap the PCI IO space on
>    any platform other than ia32?
>
> One needs to be a bit more specific for me to give you an
> answer :-)
>
> Inside the kernel:
>
> 1) PCI I/O space is accessed by obtaining the base address via the
>    appropriate pci_dev->resource[xxx] value, and feeding that directly
>    into inb/inw/inl and friends.
>
> 2) PCI MEM space is accessed by obtaining the opaque MEM base cookie
>    in pci_dev->resource[xxx], mapping it with ioremap(cookie), and
>    feeding what you obtain from that to readw and friends.  When
>    done with the MEM space area, you iounmap it.

So if I'm wrong, I'm in good company. :-) If you think I'm wrong, I
suggest that it is actually people like Dave Miller and Linus that you
need to be convincing, and that this discussion should move to
linux-kernel.

> > inb(n) should do whatever is necessary to access address n in PCI I/O
> > space.
>
> Ummm...no :-).  inb is an x86 instruction and you have to use it on
> that platform.  It's a wart they have to live with.  I think Linux

Ummm...no :-).  inb is the accessor function for reading bytes from
PCI I/O space.  It happens to have the same name as an x86 instruction
for hysterical raisins, that's all.  Next you'll be telling me that
cli is an x86 instruction and therefore we shouldn't use it in our
drivers.  (And yes, I know it's better to do spin_lock_irqsave.)

> None, if 'n' or the result of ioreamp() (I don't like that function
> much either :-), is ready to be used.  I just don't like doing all of
> the arithmetic in the in/out read/write macros.  That should all be
> done more intelligently by some platform functions only once.

Given how long I/O accesses take (hundreds of ns, at the minimum) the
cost of adding a constant is truly negligible.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

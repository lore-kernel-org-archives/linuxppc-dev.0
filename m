From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14793.29680.948198.119368@argo.linuxcare.com.au>
Date: Thu, 21 Sep 2000 13:35:28 +1100 (EST)
To: Dan Malek <dan@mvista.com>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
In-Reply-To: <39C96EBC.6BE23535@mvista.com>
References: <Pine.LNX.4.10.10009172058340.715-100000@cassiopeia.home>
	<14790.58502.25252.825448@argo.linuxcare.com.au>
	<20000919150621.A9826@cx258813-a.chnd1.az.home.com>
	<14791.61311.118516.747495@argo.linuxcare.com.au>
	<39C8DE1A.BC8EF0B6@mvista.com>
	<14793.18115.38314.912204@argo.linuxcare.com.au>
	<39C96EBC.6BE23535@mvista.com>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek writes:

> No, I mean the evolution of address maps of platforms has resulted
> in holes, restrictions, and just some weird things unique to any one
> of them.

At the physical address level?  Can't we hide that at the virtual
address level?

>  People make assumptions that a particular device always
> resides at a certain address, so they either hard code that or take
> short cuts based upon those assumptions.

If you have a super-I/O chip with a serial port at I/O address 0x3f8
(for example), you just have to know that number, there's nothing that
is going to tell you.

> As others have mentioned, we don't use all of the drivers in this
> manner.  There are some legacy drivers that have worked well given
> the PReP/CHRP/PMac mapping hacks we have done in the past.  With the new
> PowerMacs in particular, we now have a few drivers that need a little
> more work.  As I said, I have updated some of these.

Which ones in particular?

> I mean everywhere.  The PCI (or ISA, or any bus) should have a resource
> map (or data base or whatever you want to call it) of devices, addresses
> and attributes.  A driver should ask for these to be mapped (at some
> arbitrary virtual address) and then use the supplied virtual address.

Thereby assuming that all I/O is memory-mapped, making the driver
non-portable to intel machines.

> A driver should never simply 'inb(SERIAL_PORT_STATUS)' using some #define,

Why not?

> I don't think I would call it "tricks", but we need some layers of
> translation and flexibility.  The "trick" you have been proposing for
> PMac will work fine there, but won't work many other places because
> the bridges or systems don't have the flexibility.  My point is that

Huh?  All I am proposing is that we set up the virtual -> physical
mapping in a certain way.  The I/O space of a host bridge has to be
accessible somewhere in the physical address space, that's the only
way it can be accessible.  If the bridge connects the address lines up
in a strange way (e.g. the prep mapping option which puts 64 (I
think?) ports in each 4kB page) then inb/outb will have to cope with
that.  I hope it doesn't become necessary.

> you can do that on the PMac, but that assumption shouldn't find it's
> way into the in/out read/write macros.  The in/out macros should either
> map to in/out x86 instructions, or simply a memory access with any
> barrier instructions necessary.  When a driver asks for the address of
> that serial port on PCI bus 1, you can give them the 0xff10xxxx address.

No, that's broken.  That's what I don't want.  That's an extra
unnecessary incompatibility with intel.  Like it or not, not all
devices are PCI, and most drivers are developed and tested on intel
machines.

> When that same driver asks that question on a 8260 with PowerSPAN PCI
> bridge, it will get a very different address.  In this latter case,
> if they ask for the serial port on PCI bus 2, they are likely to get
> something that isn't even a reasonable address calculation from the
> previous.  Done correctly, you could even make some drivers switch from
> using I/O space to using memory mapped space, depending upon how the
> system resources can be allocated, without changing the driver.
> Unfortunately, too much of this information is coded into drivers today.

The access functions for PCI memory space will always be distinct from
the access functions for I/O space, because intel uses different
instructions.  Sorry.

> Although it doesn't result in portable drivers, people have asked to
> get ready to use mapped addresses to devices so they can manage their
> own memory barriers and take advantage of deep FIFOs in bridges for
> throughput rather than use any of the I/O macros.  This would also
> allow it.

That's fine for devices with registers in PCI memory space.  For
registers in PCI I/O space there are more constraints which mean that
you can't do these optimizations.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

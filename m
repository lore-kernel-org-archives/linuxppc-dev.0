Message-ID: <39C96EBC.6BE23535@mvista.com>
Date: Wed, 20 Sep 2000 22:13:16 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
References: <Pine.LNX.4.10.10009172058340.715-100000@cassiopeia.home>
		<14790.58502.25252.825448@argo.linuxcare.com.au>
		<20000919150621.A9826@cx258813-a.chnd1.az.home.com>
		<14791.61311.118516.747495@argo.linuxcare.com.au>
		<39C8DE1A.BC8EF0B6@mvista.com> <14793.18115.38314.912204@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> "Virtual != physical" is "contortions" ???

No, I mean the evolution of address maps of platforms has resulted
in holes, restrictions, and just some weird things unique to any one
of them.  People make assumptions that a particular device always
resides at a certain address, so they either hard code that or take
short cuts based upon those assumptions.  I think virtual != physical
is fine and it should _always_ be that way.  Further, a BAR is a
physical PCI address, you should never assume you can use that directly.

> I suggest you post a patch on linux-kernel to change all the device
> drivers to use memory-mapped I/O.  I wish you luck.  :-) :-)

As others have mentioned, we don't use all of the drivers in this
manner.  There are some legacy drivers that have worked well given
the PReP/CHRP/PMac mapping hacks we have done in the past.  With the new
PowerMacs in particular, we now have a few drivers that need a little
more work.  As I said, I have updated some of these.  I will probably
update some more in the future.  We need to adapt those that are
immediately necessary, and work with the other non-x86 folks to see
what they are doing about it.  I agree, you can't roll in and change
all of this overnight, but if you don't try to move in a better
direction to address the complexity, you end up with something that
looks like MS/DOS (or worse, Windows :-).


> You'll have to explain this a little more.  When you say "virtual
> mapping of I/O", do you mean I/O devices in PCI memory space or in PCI
> I/O space?


I mean everywhere.  The PCI (or ISA, or any bus) should have a resource
map (or data base or whatever you want to call it) of devices, addresses
and attributes.  A driver should ask for these to be mapped (at some
arbitrary virtual address) and then use the supplied virtual address.
A driver should never simply 'inb(SERIAL_PORT_STATUS)' using some #define,
or even with a partial address offset from some unknown base address.
I don't have all of the "how do we do this" answers, yet, but we have
to break the habit of memory mapping assumptions.  In some cases, you
can't autodetect or flexibly move things around, and this should be
hidden inside the platform specific resource manager, not assumed by
device drivers that we want to keep portable.


> ....  We (of course) already map I/O registers in PCI memory
> space through the VM subsystem.  Are you talking about PCI I/O space?

We actually VM map everything right now, even if it is through BATs
or page tables.  There are just assumptions built in that people
"utilize" :-).

> What sorts of VM mapping tricks do you want to do for PCI I/O space,
> and why?

I don't think I would call it "tricks", but we need some layers of
translation and flexibility.  The "trick" you have been proposing for
PMac will work fine there, but won't work many other places because
the bridges or systems don't have the flexibility.  My point is that
you can do that on the PMac, but that assumption shouldn't find it's
way into the in/out read/write macros.  The in/out macros should either
map to in/out x86 instructions, or simply a memory access with any
barrier instructions necessary.  When a driver asks for the address of
that serial port on PCI bus 1, you can give them the 0xff10xxxx address.
When that same driver asks that question on a 8260 with PowerSPAN PCI
bridge, it will get a very different address.  In this latter case,
if they ask for the serial port on PCI bus 2, they are likely to get
something that isn't even a reasonable address calculation from the
previous.  Done correctly, you could even make some drivers switch from
using I/O space to using memory mapped space, depending upon how the
system resources can be allocated, without changing the driver.
Unfortunately, too much of this information is coded into drivers today.

Treat I/O in the kernel just like you would if using mmap() from a
user application.  You request access to a device, you get an address,
you use it.  I don't personally like in/out read/write macros doing
address arithmetic to help me out.  Mapping these macros to processor
specific I/O instructions is OK (although asking me to use in/out on
PowerPC is kind of like asking the x86 person to use 'mtspr').
Although it doesn't result in portable drivers, people have asked to
get ready to use mapped addresses to devices so they can manage their
own memory barriers and take advantage of deep FIFOs in bridges for
throughput rather than use any of the I/O macros.  This would also
allow it.



	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

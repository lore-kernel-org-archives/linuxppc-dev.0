Subject: Re: Your valuable Suggestions / Advise for Beginners in Device
	Driver Development under Embedded Linux P
From: "McMullan, Jason" <jason.mcmullan@timesys.com>
To: m madhuker <mythri_madhuker@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040712064401.25378.qmail@web13604.mail.yahoo.com>
References: <20040712064401.25378.qmail@web13604.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1089639405.6032.25.camel@veena.timesys>
Mime-Version: 1.0
Date: Mon, 12 Jul 2004 09:36:45 -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2004-07-12 at 02:44, m madhuker wrote:
> 1]    Pre-requisite skills / knowledge and concepts to
> understand before embarking on the above project.

	O'Reilly's "Linux Device Drivers" - pick it up!
http://www.xml.com/ldd/chapter/book/

> 2]    Typical Project Environment for Device Driver
> Development under Embedded Linux Platform.

	1) Cross compilation tools
	2) Cross-compiled libc
	3) Cross-compiled init/bash/util-linux, etc

> 4]    Suppose I need to start off with the above
> project ( Device Drivers for Printers, Scanners, PDAs,
> LCDs,
>       Keypads ), what are the essential points to be
> kept in mind for smooth running of the project.

	*) Get all your hardware docs! Talk to your vendors,
	   and get EVERYTHING. Schematics can be *very* useful too!

	*) Set up a dedicated lan (a second ethernet on your host and
	   a patch cable is all you need) for your target.

	*) Get a good hardware debugger! For non-x86, Abatron's BDI-2000
	   is fantastic.

> 5]    What are the Initialization / Installation steps
> to be done regarding Embedded Linux. Please declare
>       the latest version to be used.

	For Linux 2.4.x, look in arch/ppc/kernel/setup.c

	For Linux 2.6.x, look in arch/ppc/platforms/* for examples.


>   Upon selecting
> the RTOS, how should I deal with the selection of
> Target
>       Board along with the Supporting Tools  ?

[ObPlug]
	TimeSys Corporation has a wide variety of BSP (Board Support Products)
for ARM, MIPS, XScale, SH3/SH4/SH5, PowerPC and x86. Our 2.4.x kernel
series has integrated hard real-time modifications, and our 2.6.x
products are in release for PowerPC 6xx/7xx/82xx, PowerPC 85xx, and x86.
[/ObPlug]

>
> 6]    Is it sufficient to use C, ignoring C++ & Java
> ?  Is Assembly Language essential  ?  Which part of C
> is
>       commonly used in Device Drivers  ?

	C is sufficient. Although you can use C++ (with my C++ kernel runtime
environment: http://www.evillabs.net/~gus/cppfake/index.html )
is it highly *not* recommended for kernel work.

	Java is right out.

	Assembly is not often used in driver work, but if you have coded your
own non-standard bootloader, it's very useful when modify the
arch/ppc/kernel/head*.S series of files.

>
> 7]    Please let me know the typical driver size (
> Footprint ) for Printer.  What could be the duration
> of  the
>       project  ?

	Printer drivers are composed of two parts - that which drives the
LPT/serial port the printer is connected to (kernel space), and the
render (user space, and a ghostscript driver).

	Which aspect are you talking about? For the kernel space, we're
probably only talking a few kb of code. For the renderer, it can be as
small as a few kb (simple rasterizer) to a couple of mb (lots of special
case code, embedded software fonts, etc)

> 9]    How does the Testing / Debugging takes place  ?
>   What are the Test / Debug Tools available for such
>       Operations  ?

The Linux Testing Project: http://ltp.sourceforge.net/

[ObPlug]
TimeSys' "TimeStorm" toolset includes an embedded test environment, with
the Linux Testing Project's test suite
[/ObPlug]

> 10]  Please let me know the Optimization Techniques
> involved in the Device Driver Development.

Are you optimizing for space? time? bandwidth? latency?
They're all different, and all have special techniques.
This topic alone is enough for several books.

> 11]  In this case of the Project, Linux Porting must
> be done prior to writing  Device Drivers. Am I right
> ?  Kindly
>       comment.

Yes. You need to get linux ported to your CPU (probably already done),
make sure/write firmware to do initial target setup (memory
configuation, bus config, chip selects, address spaces, etc), determine
a method of loading the kernel onto your target, make a simple serial
driver (polled), get IRQs working, get ethernet working, get an
IRQ-based serial driver working, then *poof* - you can start booting a
root filesystem via NFS, and do the rest of the project as loadable
modules.

> 12]  What Technical details should I need to
> understand under RTOS, C, Embedded Linux  ?  Is it
> necessary to
>         know any Protocol for Device Driver
> Development  ?

	Google is your friend.

	Sniff out a good IRC/email community for your target board

	See if anyone else has already ported Linux to your architecture

	SUBMIT YOUR PATCHES BACK TO THE KERNEL!

> 13]  How often do you use Oscillators / Logic Analyzer
>  ?  Please highlight me about the Connection /
>       Installation details.

	Usually I get the hardware after it's passed hardware verification, so
a JTAG debugger (ie the BDI-2000) is sufficient in most cases. If you
need to modify bus timings, cache timings, etc, then a sampling logic
probe is very useful.

--
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
** This list is shutting down 7/24/2004.

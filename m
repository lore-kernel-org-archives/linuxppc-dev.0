From: "Jason Wohlgemuth" <jsw-embedded@mindspring.com>
To: "Dan Malek" <dan@netx4.com>, <mporter@mvista.com>
Cc: <tjroberts@lucent.com>, <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: QUERY: Embedded PowerPC Linux?
Date: Wed, 24 May 2000 19:54:49 -0400
Message-ID: <NCBBKJKKGDLPHKDPAFFMAEMCCEAA.jsw-embedded@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <392C0B5D.A87105C@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

I actually modified head.S, not to get linux running, but to reboot the
system.  In our case, the gpio pin tied to the HRESET line actually reset
several boards, which would be a bad thing in some cases.  So I modified the
m8xx_gorom (I think), and messed with the PLPRCR to setup the auto-reset on
a checkstop, then cleared the DER and set something in the MSR to kick it
into a checkstop mode upon a machine check, and then caused a machine check
to reset it.  It was rather convoluted and I didn't really feel all that
great about it.  Do you think I should go back and do something else in the
m8xx_restart code inside m8xx_setup.c?  We used to use some code their that
just jumped to our bootrom's physical start address, but due to AMD's sector
protection idiosyncrocies, we had to move our bootrom and do some tricky
chip select changes and memory shadowing to get everything to boot correctly
and be able to independently sector protect the bootrom's sector; this
prevented us from jumping to the physical address at a later time.  Other
than that no changes were made, if I clean up that reset trick and it is
actually a good idea, rather than a crappy hack (in your opinion), I'll
clean it up a little and post it.  I probably should have gone to
ftp.mvista.com and looked what you all are currently doing.

Thanks,
Jason

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Dan
Malek
Sent: Wednesday, May 24, 2000 1:03 PM
To: mporter@mvista.com
Cc: tjroberts@lucent.com; linuxppc-embedded@lists.linuxppc.org
Subject: Re: QUERY: Embedded PowerPC Linux?



Matt Porter wrote:

> >Good advice, and that's what I was doing. However -- head.S is
> >incredibly convuoluted and complicated -- it's like someone insisted on
> >shaving nanoseconds and bytes everywhere possible, which is silly given
> >the rest of Linux....
>
> head.S is the start of everything.


There is nothing that should be modified in kernel/head.S for any
board/system port.  This file looks convoluted and complicated because
we are working with limited resources, touching special processor
registers and changing processor state.  There may be situations where it
appears we are trying to shave nanoseconds, but this is often due to
alignment or other processor restrictions.  While the techniques may
look the same, the reasons are different.


> >My other problem is that I do not have any sort of boot ROM, and

> Again, we are talking about kernel/head.S, right?  Well, no.  Linux
> isn't going to be what you want it to be into you add to it.  The

I will continue to point out that the Linux kernel is not a boot rom.
You first argue that head.S is too complicated, and then want to make
it initialize your processor???  I don't get it.  This is not the place
for processor initialization beyond what is necessary for Linux to
operate.  There is software in arch/ppc/mbxboot that does a little
more processor initialization for embedded systems, but that still isn't
a boot rom.

Further, writing processor initilization functions is very tedious. I
certainly don't want to be downloading a half megabyte or more of kernel
just to test a few processor initialization instructions.  When the
kernel doesn't boot, where do you start?

For example, if you write some minimal boot rom to initialize an 8xx
or 82xx processor, verify that you can read/write memory, you can boot
a Linux kernel very quickly.  If you have a boot rom, I can have a Linux
kernel running in a day or two by changing a couple of lines of code
in arch/ppc/mbxboot/embed_config.c.  Set up an environment for Linux
to run, and it does so very easily.

> I have several ports in which I simply set the MSR to a known value, ...
> .....  I can simply load/boot vmlinux at this point with
> no problems.

Absolutely.  The code within the Linux kernel is known to work on
all of these processors.  The more you change it, the less likely this
is to happen.  Localize your initialization outside of the kernel,
make it look like something that exists as much as possible, and you
are running very quickly.

> >I think we need to separate the CPU from the machine....
>
> It's being worked on as far as making a framework for non-chrp/pmac/prep
> 6xx/7xx/74xx ports.  There just hasn't been a real pressing need until
> lately.

The CPU and system/board are separate.  Some boards imply a particular
CPU, or vice versa.  You have to specify both for the configuration,
and depending upon which you ask first, you can reduce the selection
set for the latter.  Updating the configuration choices is just part
of adding a new board or processor.



	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

From: Steffen Haeuser <SteffenH@hyperion-software.de>
Reply-To: SteffenH@hyperion-software.de
To: Michel Dänzer <daenzerm@student.ethz.ch>, Iain Sandoe <iain@sandoe.co.uk>
CC: takashi oe <toe@unlserve.unl.edu>, linuxppc-dev@lists.linuxppc.org
Date: Mon, 31 Jul 2000 10:25:19 +0100
Message-ID: <yam8247.965.146578880@mail.lf-online.de>
In-Reply-To: <39852FD8.81721638@relog.ch>
Subject: Re: LinuxPPC X Server
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am 31-Jul-00 schrieb Michel Dänzer:

>Iain Sandoe wrote:

Hi!

>> > For DRI, you may have to edit even more files in config/cf/, AFAIK DRI is
>> > only built on i386 by default.
>>
>> Do I also need to enable different support in the kernel?
>> (e.g. /dev/agpart support ?)

>That would be good, but AFAIK there's no such thing for our hardware yet.

Exactly this is AFAIK currently the problem as to 3D Hardware support...
the /dev/agpart support... a solution might be to use GLX instead of
DRI ... after all since 4.0 Beta X Server Driver there *is* support for GLX
in the LinuxPPC X Server...

>You'll have to go to
>xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel and do make -f
>Makefile.linux (won't build out of the box - I've added '#include
><asm/pgtable.h> to drmP.h and changed the function in r128_dma.c containing
>i386 assembly to just call mb() - anyone knows if this makes sense?) and then
>modprobe r128.o

Hmmm... what sort of ASM is this ? Is this the only reason why agpart is not
supported on Mac yet, some lines of ASM ? (Well, AFAIK it is not even
confirmed
if this AGPart thing works with PCI, but AFAIK it was said that it "should").

>> (I have ATI{mach64,r128}/IMSTT support enabled by default - since these are
>> the cards I have).

>Only the r128 is even theoretically supported by DRI ATM.

I think a lot people confuse 2D Hardware Accelerated with 3D Hardware
Accelerated
Support. There *is* already 2D Hardware Acceleration for LinuxPPC, but not
3D...

The most clever thing probably would be to do a GLX Driver (which does not
require
this AGPart thing...). Of course all also depends if Chipset information is
available.
To do such a driver should be possible in 3-4 weeks at most... I know of what
I am speaking
as before Hyperion existed people of our company did the 3D Drivers for the
Amiga
3D Boards, and I know how long THEY took for a 3D Driver... (and before
someone
asks: No, these people are 100% busy with game coding now... no time for
drivers...).

Steffen

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

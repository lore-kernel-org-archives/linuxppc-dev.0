In-Reply-To: <v04003a00b3e8b6cc63fe@[216.81.20.86]>
Date: Wed, 25 Aug 1999 12:23:35 +0200
To: Tony Mantler <eek@escape.ca>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Performa 5200
Message-Id: <19990825122335.016707@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 24, 1999, Tony Mantler <eek@escape.ca> wrote:

>(2.1.12? I assume that's 2.3.12?)

Sorry for the typo, it's actually 2.2.12, I don't know if all this was
already included in the 2.3.x tree.

>It's a NuBus machine (though it doesn't actually have any NuBus slots). It
>shares the same address maps as the 68k machines, which puts ram in a
>contiguous block starting at 0x0, ROM at 0x40800000, IO at 0x50F00000 and
>NuBus 'super' regions from 0x90000000 to 0xEFFFFFFF, and NuBus 'regular'
>regions from 0xF9000000 to 0xFEFFFFFF (framebuffer is in slot $9 'regular'
>space, starts at 0xF9001000).
>
>I'm not sure which models have the f*ed up address maps, but I'm sure glad
>I don't have one of them. :)

all the x100 machines have address maps that depends on the population of
the RAM slots. Also, some of them have a DRAM-based frame buffer working
at a fixed physical address which can be either 0 or 1Mb.
BootX will load the kernel in the first contiguous region in memory it
can find, but that means that we have to copy the exception vectors to 0,
adjust them so they call correctly the kernel routines in the real base
of the kernel (which will not be 0 on some machines), and we'll have
virt_to_phys and co be non-constant. I read an interesting suggestion
some time ago of reserving a register during kernel compile with gcc and
using this register to store the real base of the kernel. Modules will
not be compatible, but that's not a real issue for now.
I don't know how the APUS code works, but I heard it is similar.

Also, we'll have to handle cache incoherency of DMA, and so on, but if
you manage to get the basic work done, I'll be able to help writing
driver (if I manage to get one of those machines, which is not sure).

>>LinuxPPC's interrupt handling code is not well suited to the design of the
>>interrupt hardware in the NuBus 5x00 machines, since A. it has no master
>>interrupt flag register or interrupt control register, and B. it has other
>>interrupt hardware scattered in weird places throughout the hardware.
>>It woudl be a _very_ massive hack to get it working under LinuxPPC,
>>especially since even 6/7/8100 support isn't there (which is a necessary
>>foundation for some of the MkLinux 5x00 changes).  It's also a heck of a
>>lot easier to start with something that almost works than to start with
>>somnething that's not remotely close.  ;-)
>
>Yeah, I figure the two biggest hurdles I'm going to have to deal with is a:
>getting it to boot, and b: getting the interrupts to work. After that, it's
>just a matter of tweaking drivers, and luckily there's a whole lot of
>shared code between Mac68k and LinuxPPC drivers. (CUDA ADB, Valkyrie video,
>I think the serial driver too, and so forth)
>
>(If anyone's interested, I wrote up a few docs on Mac68k interrupts, and
>the functioning of the evil VIAs (and emulations thereof))

>
>I'm starting to think that I should carve out a new machine class in the
>config options (#ifdef CONFIG_WUSSY_68K_PMAC?) ;)

Or simply CONFIG_NUBUS_PMAC... BootX will tell you if you are running on
one of those and will tell you if it's a PDM based (x100), performa or
powerbook (5300/1400). It will also give you the gestalt machineID and
the phys. memory map table. If you need more infos, tell me, but I
beleive most of the other infos will have to be hard coded.

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

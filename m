Date: Wed, 7 Apr 1999 17:25:23 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Jesper Skov <jskov@cygnus.co.uk>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Resurrecting mkLinux
In-Reply-To: <19990407165223.029538@mail.mipsys.com>
Message-ID: <Pine.LNX.4.03.9904071722160.27618-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 7 Apr 1999, Benjamin Herrenschmidt wrote:
> On Wed, Apr 7, 1999, Jesper Skov <jskov@cygnus.co.uk> wrote:
> 
> >My top priority is to get away from having an Amiga directory under
> >arch/ppc (or arch/ppc/mach_m68k). I would prefer to move all mach
> >drivers into a new mach hierarchy (so there would be e.g. mach/amiga
> >in the root of the kernel sources just as we now have arch/m68k).

Hence we need

    mach/amiga (m68k and PPC)
    mach/mac (m68k and PPC)
    mach/sun (SPARC and SPARC64)
    mach/pc (all legacy stuff)
    ...

> >The main motivation is obviously to avoid maintaining two different
> >sets of sources that do the same thing. Most of the ppc/amiga sources
> >are just 
> 
> Sounds good. The changes I'm making to the ADB code shoud fit nicely in
> this too. I beleive I could merge ADB of mac 68k and PPC implementations
> quite easily.
>
> Question: Who is using drivers/char/adbmouse.c ? I know linux-pmac does,
> of course, but could someone tell me what are the other archs/machines
> using this specific file. I would like to make changes to it (I tried to
> avoid them as much as possible until now) so I'll need to fix other archs too.

PowerMac, CHRP and Mac.

> Basically, adb.c core should be shared by all implentations, mac_keyb.c
> and it's specific mouse handlers too since those devices can be
> potentially plugged in any ADB machine (but defaults keymaps will
> probably be different). adbmouse as a bus-mouse compatibility driver
> should not depend on any implementation neither, I still need to cleanup
> things in this regard, but we won't get rid of the global-based "hook" if
> we want it to still be a module. I will probably put the definition of
> the global itself in adb.c core, eventually encapsulated within a structure.

Hence we need

    drivers/adb
    drivers/usb
    ...
    bus/pci
    bus/zorro
    bus/isa
    bus/dio
    bus/nubus
    bus/sbus
    bus/mbus
    bus/eisa
    bus/mca
    ...

Lot's of clean ups for 2.3.x ;-)

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

In-Reply-To: <ooyak4ikj4.fsf@lassi.cygnus.co.uk>
Date: Wed, 7 Apr 1999 16:52:23 +0200
To: Jesper Skov <jskov@cygnus.co.uk>
CC: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Resurrecting mkLinux
Message-Id: <19990407165223.029538@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Apr 7, 1999, Jesper Skov <jskov@cygnus.co.uk> wrote:

>My top priority is to get away from having an Amiga directory under
>arch/ppc (or arch/ppc/mach_m68k). I would prefer to move all mach
>drivers into a new mach hierarchy (so there would be e.g. mach/amiga
>in the root of the kernel sources just as we now have arch/m68k).
>
>The main motivation is obviously to avoid maintaining two different
>sets of sources that do the same thing. Most of the ppc/amiga sources
>are just 

Sounds good. The changes I'm making to the ADB code shoud fit nicely in
this too. I beleive I could merge ADB of mac 68k and PPC implementations
quite easily.

Question: Who is using drivers/char/adbmouse.c ? I know linux-pmac does,
of course, but could someone tell me what are the other archs/machines
using this specific file. I would like to make changes to it (I tried to
avoid them as much as possible until now) so I'll need to fix other archs too.

Basically, adb.c core should be shared by all implentations, mac_keyb.c
and it's specific mouse handlers too since those devices can be
potentially plugged in any ADB machine (but defaults keymaps will
probably be different). adbmouse as a bus-mouse compatibility driver
should not depend on any implementation neither, I still need to cleanup
things in this regard, but we won't get rid of the global-based "hook" if
we want it to still be a module. I will probably put the definition of
the global itself in adb.c core, eventually encapsulated within a structure.

I'm also thinking about letting userland install an auto-poll handler
thru the /dev/adb device. This would allow to write userland drivers for
non-mouse things (a tablet GIMP plugin for example) more easily. One
could "override" the default mouse_input/kbd_input handler by the
userland one, possibly inside a given vt (but the vt switch should
probably be handled by the userland code itself, I need some clues about
this).
This would also be useful for the mac-on-linux emulator, to grab directly
the ADB flow and pass it "as-is" to the emulator, lowering the overhead
when moving the mouse and allowing support of special devices vith MacOS
drivers inside the emulator.

So if you have anything in mind about ADB, please tell me now. I sent a
first set of patches last week to Cort and i still plan to add more
things in the upcoming one or two weeks and then I'll stabilize it and
submit the changes to Cort.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

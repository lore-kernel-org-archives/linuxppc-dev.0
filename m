Message-Id: <v03130302b3f1013159dd@[192.168.1.1]>
In-Reply-To: <199908310243.MAA17110@tango.anu.edu.au>
References: <199908301552.RAA23128@lxp03.cern.ch> (message from Jes
 Sorensen	on Mon, 30 Aug 1999 17:52:45 +0200)
 <v03130327b3ebecbebbd3@[192.168.1.1]>
 <199908270917.LAA04250@lxp03.cern.ch>
 <v03130308b3ec440550d3@[192.168.1.1]>
 <199908271414.QAA24261@lxp03.cern.ch>
 <37CAA6F5.D93A168B@biophys.uni-duesseldorf.de>
 <199908301552.RAA23128@lxp03.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 30 Aug 1999 23:25:35 -0500
To: Paul.Mackerras@cs.anu.edu.au, Jes.Sorensen@cern.ch
From: "David D. Kilzer" <ddkilzer@computer.org>
Subject: Re: mac-2.3.14.diff: adb
Cc: schmitz@opal.biophys.uni-duesseldorf.de, linux-mac68k@mac.linux-m68k.org,
        linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras <Paul.Mackerras@cs.anu.edu.au> wrote:

>The stuff in drivers/macintosh is basically stuff that I thought would
>only be useful on macs (powermacs initially but also potentially 68k
>macs).

If anyone continues the NeXT port of Linux (LiNeXT), these systems also use
ADB for mouse and keyboard.  It seems to be kind of dead right now, though.

  http://www.black.linux-m68k.org/

>What's in there breaks down into:
>
>ADB drivers: adb.c, macio-adb.c, via-cuda.c, via-pmu.c, mac_keyb.c

Add to that 68k-only stuff:  adb-iop.c, via-macii.c [and adb-iisi.c which
doesn't exist at the moment].

>zilog serial driver: macserial.[ch]

In drivers/char there exists mac_SCC.[ch] for m68k Macs, though it needs to
exist on its own outside of m68kserial.c (which is going away soon :^).

>powerbook media bay driver: mediabay.c
>
>/dev/nvram driver: nvram.c

Nothing equivalent (yet) on the m68k side, though we may soon have a PCMCIA
driver if Joshua Thompson gets it working on his PB 190cs.

>The CUDA and PMU drivers both have several functions, of which talking
>to the ADB bus is only one.  The CUDA and PMU are both responsible for
>talking to the real-time clock and NVRAM, and for reset and soft-power
>control.  The PMU also has the functions of controlling and reporting
>on the battery status and for putting the system to sleep.  The PMU
>driver exports a /dev/pmu device.

The adb-iop.c is an ADB driver for IOP-based Macs (IIfx, Quadra 900 and
950), the via-macii.c is a via driver for Mac II-based ADB systems (II,
SE/30), and adb-iisi.c will be a driver for the IIsi-style ADB.

>If there was a compelling reason for getting rid of drivers/macintosh,
>sure we could find other homes for the files in it.  I haven't seen
>any compelling reason yet though.  If the 68k-mac folks feel that they
>can't use drivers/macintosh, that is unfortunate and certainly not
>what I intended.

Actually, the m68k-mac folks don't care whether it goes in
drivers/macintosh or drivers/adb.  The m68k port maintainer, Jes Soresen,
won't accept any patches that put or modify files in drivers/macintosh.

To clear up any confusion, please note that Joshua Thompson submitted a
PPC-relevant patch to Paul Mackerras while I (David Kilzer) submitted an
m68k-relevant patch to Jes Sorensen.  Both were patches to files in
drivers/macintosh, and in some cases moved the files there from other
places.

The issue at hand is that Jes believes drivers/macintosh should not exist
while drivers/adb (for low-level adb stuff) and drivers/char/adb (for adb
devices) should exist instead.  Paul, it seems to me, would be happy either
way.

>I think the idea of having a drivers/adb directory is reasonable, and
>adb.c, mac_keyb.c and maybe adbmouse.c can go in there.  I don't see
>that via-cuda.c and via-pmu.c really fit well in there though.  Maybe
>the thing to do is to split the adb-related functions out of those
>files and put them in cuda-adb.c and pmu-adb.c in drivers/adb.
>
>I don't really mind whether macserial.[ch] stay in drivers/macintosh
>or go to drivers/char.  drivers/sbus/char/sunserial.[ch] is a
>precedent for keeping it in drivers/char.  nvram.c could go into
>drivers/char, I guess, but would have to have a name change.  I don't
>see that these things have to go in drivers/char just because they
>implement a character device.

I would appreciate it if Jes and Paul would come to an agreement on where
the code belongs so we can get on with the ADB merger.  :^)

Dave


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

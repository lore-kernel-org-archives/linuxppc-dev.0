Date: Tue, 31 Aug 1999 12:43:32 +1000
Message-Id: <199908310243.MAA17110@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: Jes.Sorensen@cern.ch
CC: schmitz@opal.biophys.uni-duesseldorf.de, ddkilzer@computer.org,
        linux-mac68k@mac.linux-m68k.org, linuxppc-dev@lists.linuxppc.org
In-reply-to: <199908301552.RAA23128@lxp03.cern.ch> (message from Jes Sorensen
	on Mon, 30 Aug 1999 17:52:45 +0200)
Subject: Re: mac-2.3.14.diff: adb
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <v03130327b3ebecbebbd3@[192.168.1.1]>
	<199908270917.LAA04250@lxp03.cern.ch>
	<v03130308b3ec440550d3@[192.168.1.1]>
	<199908271414.QAA24261@lxp03.cern.ch>
	<37CAA6F5.D93A168B@biophys.uni-duesseldorf.de> <199908301552.RAA23128@lxp03.cern.ch>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jes Sorensen <Jes.Sorensen@cern.ch> wrote:

> Wouldn't it be natural to move the Mac 8530 serial driver to
> drivers/char and the rest to drivers/adb? or is the via stuff not adb
> related?
> 
> Paul what do you think?

The stuff in drivers/macintosh is basically stuff that I thought would
only be useful on macs (powermacs initially but also potentially 68k
macs).

What's in there breaks down into:

ADB drivers: adb.c, macio-adb.c, via-cuda.c, via-pmu.c, mac_keyb.c

zilog serial driver: macserial.[ch]

powerbook media bay driver: mediabay.c

/dev/nvram driver: nvram.c

The CUDA and PMU drivers both have several functions, of which talking
to the ADB bus is only one.  The CUDA and PMU are both responsible for
talking to the real-time clock and NVRAM, and for reset and soft-power
control.  The PMU also has the functions of controlling and reporting
on the battery status and for putting the system to sleep.  The PMU
driver exports a /dev/pmu device.

If there was a compelling reason for getting rid of drivers/macintosh,
sure we could find other homes for the files in it.  I haven't seen
any compelling reason yet though.  If the 68k-mac folks feel that they
can't use drivers/macintosh, that is unfortunate and certainly not
what I intended.

I think the idea of having a drivers/adb directory is reasonable, and
adb.c, mac_keyb.c and maybe adbmouse.c can go in there.  I don't see
that via-cuda.c and via-pmu.c really fit well in there though.  Maybe
the thing to do is to split the adb-related functions out of those
files and put them in cuda-adb.c and pmu-adb.c in drivers/adb.

I don't really mind whether macserial.[ch] stay in drivers/macintosh
or go to drivers/char.  drivers/sbus/char/sunserial.[ch] is a
precedent for keeping it in drivers/char.  nvram.c could go into
drivers/char, I guess, but would have to have a name change.  I don't
see that these things have to go in drivers/char just because they
implement a character device.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

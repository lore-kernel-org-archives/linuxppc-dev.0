Date: Fri, 3 Nov 2000 15:55:58 +0100 (MET)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
Reply-To: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: linuxppc-dev@lists.linuxppc.org
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Albrecht@denx.muc.de, "[iso-8859-1] Dreﬂ" <ad@mpifr-bonn.mpg.de>,
        Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
In-Reply-To: <200011030559.XAA12796@lists.linuxppc.org>
Message-ID: <Pine.SOL.3.95.1001103151802.20257C-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 3 Nov 2000 13:22:10 +0100 (CET),
Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de> was rumoured to say:

>
> > pmud[333]: pmud [treshold = 420, margin = 15] started
> > modprobe: modprobe: Can't locate module char-major-56
> > pmud[333]: Couldn't open /dev/adb
> > pmud[333]: daemon stopped (Couldn't open /dev/adb)
>
> Nope, /dev/adb remains unchanged, just ADB mice aren't necessarily read
> via the adbmouse device anymore (but that was misc minor 10, the patch to
> handle keyboard and mouse data as separate ADB devices in the ADB major
> range never made it in).
>
> Make sure you the core adb support is compiled in. It currently is, unless
> CONFIG_MBX is set ... if CONFIG_ALL_PPC=y implies CONFIG_MBX=y, someone
> better fix this.
>
I suspect it is somehow related to mouse and keyboard being handled by
the new input layer, in pmac-stable this seems to be handled quite
differently from pmac-benh (at least, there's an extra config menu).
Maybe someone forgot that pmu/adb is handling more than keyboard and mouse?

> Did all your kernels that crash lack ADB support, or just the latest you
> built with CONFIG_ALL_PPC=y ?
>
I think there is some misunderstanding here. pmac-stable kernels w/o adb
_cannot_ crash on wakeup, because they can't sleep. At least that's my
experience. The benh-kernels may crash, but this doesn't seem to be
consistent, also I don't think it is related to the device bay.
I just had 2.2.18pre17-benh1 running (and sleeping) for about a week on
my Lombard, this morning it simply powered down and reset pram when I
tried to wake it up (battery was 95% full).

I also noted some other problems with sleep, mostly irregularly:

 xscreensaver tends to become somehow disconnected from the display, when
 	this happens, it will run in the background after wakeup and begin
	to consume 90%+ cpu, but doesn't blank the screen. It can be
	easily killed, however.
	I added some lines to pwrctl-local to kill it before sleeping
	and relaunch it afterwards, but even then it happenened once again
	(before, it was about every other time, though)

 power consumption during sleep is occasionally (not frequently) 5-10
	times the normal rate, which will discharge the battery within
	24-36 hours.

 sometimes I don't get my usb mouse back after wakeup. I haven't found any
	way to reset usb (unplugging doesn't help and it doesn't work with
	gpm either). So far I could not get the mouse (or any input layer
	device) to work as a module at all, so rmmod/insmod rules out
	as well (this was where I started experimenting with
	pmac-stable kernels in the first place).
	I think I saw this first with 2.2.18pre15-benh1. It seems to
	happen more frequently when I'm carrying the PB around during
	sleep, but this can't be a power supply issue, since I'm
	usually unplugging the AC when at home, too.

Sorry I can't give better statistics on these phenomena. I can live with
them, except for the crashes, though the usb failure is annoying, too.

Cheers,
							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

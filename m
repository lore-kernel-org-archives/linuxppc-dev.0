From: Benjamin Herrenschmidt <bh40@calva.net>
To: Derek Homeier <supas100@astrophysik.uni-kiel.de>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
Date: Fri, 3 Nov 2000 16:53:03 +0100
Message-Id: <19340928092447.1002@192.168.1.2>
In-Reply-To: <Pine.SOL.3.95.1001103151802.20257C-100000@juliet>
References: <Pine.SOL.3.95.1001103151802.20257C-100000@juliet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I suspect it is somehow related to mouse and keyboard being handled by
>the new input layer, in pmac-stable this seems to be handled quite
>differently from pmac-benh (at least, there's an extra config menu).
>Maybe someone forgot that pmu/adb is handling more than keyboard and mouse?

No. the input layer also needs the ADB core since it's the low level
code. I would bet for a config problem. I'll check that when I'm back,
this week-end.

>I think there is some misunderstanding here. pmac-stable kernels w/o adb
>_cannot_ crash on wakeup, because they can't sleep. At least that's my
>experience. The benh-kernels may crash, but this doesn't seem to be
>consistent, also I don't think it is related to the device bay.
>I just had 2.2.18pre17-benh1 running (and sleeping) for about a week on
>my Lombard, this morning it simply powered down and reset pram when I
>tried to wake it up (battery was 95% full).

I though that was fixed for a long time... weird.

>I also noted some other problems with sleep, mostly irregularly:
>
> xscreensaver tends to become somehow disconnected from the display, when
> 	this happens, it will run in the background after wakeup and begin
>	to consume 90%+ cpu, but doesn't blank the screen. It can be
>	easily killed, however.

Yup. Fortunately, even if you don't kill it, it tends to stop playing the
CPU hog after a few seconds (or minutes ?)

>	I added some lines to pwrctl-local to kill it before sleeping
>	and relaunch it afterwards, but even then it happenened once again
>	(before, it was about every other time, though)
>
> power consumption during sleep is occasionally (not frequently) 5-10
>	times the normal rate, which will discharge the battery within
>	24-36 hours.

Bizarre... The new sleep code is supposed to be a lot less robust to
those various issues. Well, I suggest you try again with pmac-stable once
the ADB problem is ironed out. Both Paul and I did various fixes to the
sleep process.

> sometimes I don't get my usb mouse back after wakeup. I haven't found any
>	way to reset usb (unplugging doesn't help and it doesn't work with
>	gpm either). So far I could not get the mouse (or any input layer
>	device) to work as a module at all, so rmmod/insmod rules out
>	as well (this was where I started experimenting with
>	pmac-stable kernels in the first place).
>	I think I saw this first with 2.2.18pre15-benh1. It seems to
>	happen more frequently when I'm carrying the PB around during
>	sleep, but this can't be a power supply issue, since I'm
>	usually unplugging the AC when at home, too.

Well, it can be a problem with sleep/wakeup code for the USB controller.
That code is not very clean in that sense that it should do more things
before putting the OHCI to sleep (like waiting for pending requests to
complete, etc...)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Thu, 10 Aug 2000 00:46:14 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Takashi Oe <toe@unlserve.unl.edu>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again...
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.1000809101853.866E-100000@ofey.earthlink.net>
Message-ID: <Pine.HPX.4.10.10008100027430.22126-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 9 Aug 2000, Takashi Oe wrote:

>
> On Wed, 9 Aug 2000, Benjamin Herrenschmidt wrote:
>
> > >Personally, I think UTC <-> local time conversion should be handled in
> > >userland.  Both hwclock and clock can handle both local time and UTC just
> > >fine.
> >
> > If we do that this way, we can't have proper in-kernel NTP update of the
> > RTC without a hack that let it only "correct" for less than 1 hour.
>
> Hmm, I don't really understand this NTP update problem.  Does NTP even
> work when the system time is off by more than 1 hour?

Oh yes, it will simply call settimeofday if the error is large or
adjtimex if it's small enough to drift smoothly in a reasonable time.
The question is, will it update the RTC correctly ?

It depends on many things, my PC clock was off by 20 minutes and it did
not update the RTC (limit is about 15 minutes since there are half hours
time zones). I had to use hwclock --systohc --utc to set it up once I had
ntp running and locked on a server, now te kernel automatically takes care
of it.

> > It used to be only in xpram. Recent MacOS also have a prefs file, I have
> > to check what happens when this file is out of sync with the xpram.
>
> Ok, at least on Mac OS 8.6, it looks okay.  At each boot, Mac OS honors
> the timezone setting in xpram over its configuration files, and it always
> assumes that RTC is in localtime as previously noted.  Now, the OS doesn't
> update its configuration files like for Location Manager, so users will
> have to deal with it, and that's okay.

Confused, but I've hardly ever even seen a Mac.

> How does kernel know when to update the tz so that it can save the info to
> xpram?  Since do_settimeofday() is not necessarily called when tz is
> changed, we'd have to save the tz to xpram every time do_settimeofday() is
> called even when tz is not at all changed.  Or is the xpram update only
> done when *set_rtc() is called?  How do you know when to set DST flag on
> xpram?
>
> Isn't it better to have a little userland app do the xpram manipulation?

Is it actually even necessary to manipulate it. Once the kernel clock is
in UTC, everything is userland under Unix. If MacOS detects that DST has
changed after a reboot, let it handle this, as long as it allows to find
UTC from RTC and xpram everything is fine.

>
> > It may be a "cultural" difference due to my years of MacOS background,
> > but rather than having userland set the timezone, I'd personally rather
> > see userland read the kernel timezone coming from xpram, and set the
> > appropriate userland env. vars depending on this timezone (especially
> > useful for portables). Well, that's my 2 cents, of course, nobody will
> > agree wit me ;)
>
> /dev/rtc aside, kernel only communicates through UTC, and timezone
> manipulation is best done in userland especially for portables.  When you
> go from one timezone to another, it requires some sort of userland
> intervention to get clock right anyway.

Indeed...

> Let's say /dev/rtc gives raw machine value and since Mac OS requires it to
> be localtime for P'Mac let me assume /dev/rtc gives localtime which is
> consistent with xpram timezone info.  As long as RTC and xpram timezone
> info is consistent (it does'nt have to be the correct timezone where the
> machine happens to be at the time), kernel can always figure out what UTC
> is at very early boot time.  If /dev/rtc time and kernel UTC derived
> localtime (via /etc/localtime) do not agree, we know something has
> happened and we can decide or ask users to set xpram timezone info (via

Why ?  On a portable it may simply mean that you are away and set
/etc/localtime to your new zone or anything else, but I'd rather keep
the filesystem timestamps on my FAT/hfs partitions to the local
timestamps of my default location. As long as I don't boot MacOS while I'm
away there is perhaps no reason to change the xpram offset...

> /dev/nvram or whatever) or change /etc/localtime link or whatever at boot
> time or user specified time.  And, if /dev/rtc time and kernel UTC derived
> localtime do agree, all is well and we have nothing to do.  Either way,
> there is nothing for kernel to decide.  See?

No policy in the kernel in indeed a good guideline.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

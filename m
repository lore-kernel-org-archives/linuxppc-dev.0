Date: Wed, 9 Aug 2000 11:37:55 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again...
In-Reply-To: <20000809084839.8039@mailhost.mipsys.com>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000809101853.866E-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 9 Aug 2000, Benjamin Herrenschmidt wrote:

> >Personally, I think UTC <-> local time conversion should be handled in
> >userland.  Both hwclock and clock can handle both local time and UTC just
> >fine.
>
> If we do that this way, we can't have proper in-kernel NTP update of the
> RTC without a hack that let it only "correct" for less than 1 hour.

Hmm, I don't really understand this NTP update problem.  Does NTP even
work when the system time is off by more than 1 hour?

> >Does Mac OS handle different timezone information in xpram well?  Timezone
> >information is saved in xpram but it's also saved in some of config files.
> >So, it appears to me that Mac OS will get confused or ignore or delete the
> >timezone setting in xpram if it doesn't agree with the config file.
>
> It used to be only in xpram. Recent MacOS also have a prefs file, I have
> to check what happens when this file is out of sync with the xpram.

Ok, at least on Mac OS 8.6, it looks okay.  At each boot, Mac OS honors
the timezone setting in xpram over its configuration files, and it always
assumes that RTC is in localtime as previously noted.  Now, the OS doesn't
update its configuration files like for Location Manager, so users will
have to deal with it, and that's okay.

> Saving the tz to xpram also makes sure the kernel is fine at boot accross
> multiple boots.

How does kernel know when to update the tz so that it can save the info to
xpram?  Since do_settimeofday() is not necessarily called when tz is
changed, we'd have to save the tz to xpram every time do_settimeofday() is
called even when tz is not at all changed.  Or is the xpram update only
done when *set_rtc() is called?  How do you know when to set DST flag on
xpram?

Isn't it better to have a little userland app do the xpram manipulation?

> It may be a "cultural" difference due to my years of MacOS background,
> but rather than having userland set the timezone, I'd personally rather
> see userland read the kernel timezone coming from xpram, and set the
> appropriate userland env. vars depending on this timezone (especially
> useful for portables). Well, that's my 2 cents, of course, nobody will
> agree wit me ;)

/dev/rtc aside, kernel only communicates through UTC, and timezone
manipulation is best done in userland especially for portables.  When you
go from one timezone to another, it requires some sort of userland
intervention to get clock right anyway.

Let's say /dev/rtc gives raw machine value and since Mac OS requires it to
be localtime for P'Mac let me assume /dev/rtc gives localtime which is
consistent with xpram timezone info.  As long as RTC and xpram timezone
info is consistent (it does'nt have to be the correct timezone where the
machine happens to be at the time), kernel can always figure out what UTC
is at very early boot time.  If /dev/rtc time and kernel UTC derived
localtime (via /etc/localtime) do not agree, we know something has
happened and we can decide or ask users to set xpram timezone info (via
/dev/nvram or whatever) or change /etc/localtime link or whatever at boot
time or user specified time.  And, if /dev/rtc time and kernel UTC derived
localtime do agree, all is well and we have nothing to do.  Either way,
there is nothing for kernel to decide.  See?


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

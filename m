Date: Fri, 4 Aug 2000 20:10:33 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again...
In-Reply-To: <20000804205524.383@192.168.1.10>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000804195419.649B-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 4 Aug 2000, Benjamin Herrenschmidt wrote:

> >Ok, the usage of "sys_tz" or "struct timezone" in general in kernel is not
> >well defined or confused.  kernel/time.c seems to assume "tz_minuteswest"
> >includes DST fix up, while fs/fat/misc.c uses "tz_minuteswest" for time
> >zone and "tz_dsttime" for DST fix up.  The code in pmac_set_rtc_time()
> >doesn't work if "tz_minuteswest" doesn't include the DST fix up, so, if
> >that's the correct behaviour, the following code in pmac_time_init() needs
> >to be tweaked for consistency in my opinion from:
> >
> >	sys_tz.tz_minuteswest = -delta/60;
> >	/* I _suppose_ this is 0:off, 1:on */
> >	sys_tz.tz_dsttime = dst;
> >
> >to
> >
> >	sys_tz.tz_minuteswest = -delta/60 - (dst? 60: 0);
> >	sys_tz.tz_dsttime = dst;
>
> Well, who is right ? time.c or fs/fat/misc.c ? Maybe we should query the
> powers that be... Did you look at what the userland hwclock expects in
> tz_dsttime ?

As Geert has pointed out, hwclock can give UTC or local time to /dev/rtc,
why don't we just let userland deal with this local time issue.  What I
mean is for pmac_set_rtc_time(), let's change:

	nowtime += RTC_OFFSET - sys_tz.tz_minuteswest * 60;

to

	nowtime += RTC_OFFSET;

and we assume that userland will give us the correct local time.

For pmac_time_init(), let's change:

	sys_tz.tz_minuteswest = -delta/60;
	/* I _suppose_ this is 0:off, 1:on */
	sys_tz.tz_dsttime = dst;

to

	sys_tz.tz_minuteswest = -delta/60 - (dst? 60: 0);
	sys_tz.tz_dsttime = 0;

which is what's been done in hwclock source and a reasonable compromise, I
think, so that both kernel/time.c and fs/fat/misc.c would be happy.

How about it?


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

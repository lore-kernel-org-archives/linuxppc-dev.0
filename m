Date: Wed, 9 Aug 2000 00:44:34 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again...
In-Reply-To: <20000808174157.21374@mailhost.mipsys.com>
Message-ID: <Pine.HPX.4.10.10008081952360.22126-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 8 Aug 2000, Benjamin Herrenschmidt wrote:

> The kernel keeps two things:
>
>  - xtime is the current time and should be UTC.
                                   ^^^^^^
				   must

>  - sys_tz is the current timezone (usually set from userland)

Indeed, and it is used mostly (only?) by some filesystems which keep time
in local time.

> When the kernel boots, it reads the time from the RTC. On pmac (or any
> other machine that has a local time), that means that the kernel boots
> with a wrong notion of time until that gets fixed from userland.
>
> That's why I added that code that calculates the real UTC from the xpram.
> It also initialize properly the sys_tz structure, since it's easy,
> doesn't cost much, and I think it's always better to have a correct value
> when we can ;) This would also allow some tools and/or installers to
> "read" the timezone at boot in order to propose a default choice or such
> things.
>
> Now there are several problems:
>
>  - The first one, well hidden in kernel/time.c (generic code) is the call
> to warp_time(). This is an awful hack that seem to be done because PCs
> apparently also set the RTC to local time.

This is necessary for people who dual boot some M$ stuff (my PC is UTC and
it just works fine).

> This hack will cause the
> kernel to "bump" the xtime the first time the syscall settimeofday() is
> called is it is called with a valid timezone and a NULL timevalue.


> With old broken behaviour, this code has the effect of causing the kernel
> to "adjust" it's internal time that was wrongly set to local time to be
> real UTC as soon as it is notified by userland of the real time zone.
> Obviously, this code breaks us. We should probably change it so that a
> global variables tells this code we have already inited sys_tz properly
> and there's no need to warp.

You could also call do_sys_settimeofday with correct tz from pram and a
null tv to adjust xtime and prevent userland from messing with it again
(faking the first call used to set timezone). do_sys_settimeofday is a
public symbol since it's used by sparc and alpha code (at least) for some
OSF and SunOS emulation.

Pushing this timezone setting policy to architecture dependant code is
another possibility, but the changes are bigger.

>  - The second one is that ppc_md.get/set_rtc_time are passed (or return)
> a time value independently of the timezone. That mean that they either do
> no conversion and so it's the responsibility of the caller to "know" if
> the RTC is in local time or UTC, or they do the conversion and so return
> (and get passed) an UTC time. That's what I decided to do, so on
> PowerMac, they do the adjustement from UTC to localtime and the opposite
> inside those functions. Paul recently added code to also save the
> timezone to the xpram. There's a small semantic problem with this code,
> since it takes the time to set to the RTC as a parameter but uses the
> global sys_tz. It should either use no parameter (and use only xtime/
> sys_tz), or be passed both parameters. In this case, we can probably move
> the init code that reads the initial time zone to the pmac_get_rtc_time() too.

I'm slightly lost :-(. But whether the clock is in UTC or not is a
parameter (defined in /etc/sysconfig/clock or another system configuration
file), so I think that translating to/from UTC when setting the clock is a
purely userland job and set/get_rtc_time should never have to handle this.

>
>  - There's apparently a problem with the definition of the DST field of
> sys_tz. The best way to handle this correctly is probably to see how
> userland tools like hwclock use it. What is responsible for managing DST
> on linux ? Is there a deamon for that ? A tool called from cron ?

No, AFAICT nothing bothers with it, only the clock program at boot.

First it is 99% a userland problem: just set export TZ=UTC or any path in
/usr/share/zoneinfo and all dates will appear as if you were in this
timezone (try date or ls -l).

The translation between UTC and localtime is performed in the C library,
using the TZ environment variable or /etc/localtime, and it will know when
to switch between DST and non DST.

The last problem is updating the clock through NTP when the RTC is running
in local time. Since these are generally small corrections, there are
solutions (but the comments of the i386 version say that it is buggy :-().

Until now I've found a single place where sys_tz.dsttime is used in the
kernel: fs/fat/misc.c when converting between Unix and FAT timestamps.
Interestingly it's used only in one direction, so it definitely looks like
a bug. Some other filesystems (affs/hfs/ncpfs/ufs) use the timezone
information but not the dst field, making FAT time handling look even
buggier.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Benjamin Herrenschmidt <bh40@calva.net>
To: Gabriel Paubert <paubert@iram.es>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: rtc again...
Date: Wed, 9 Aug 2000 10:44:22 +0200
Message-Id: <20000809084422.4567@mailhost.mipsys.com>
In-Reply-To: <Pine.HPX.4.10.10008081952360.22126-100000@gra-ux1.iram.es>
References: <Pine.HPX.4.10.10008081952360.22126-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>I'm slightly lost :-(. But whether the clock is in UTC or not is a
>parameter (defined in /etc/sysconfig/clock or another system configuration
>file), so I think that translating to/from UTC when setting the clock is a
>purely userland job and set/get_rtc_time should never have to handle this.

The problem is that those functions are in-kernel, and without proper
conversion, they could put incorrect time in the RTC. Those are called by
/dev/rtc on macintosh, additionally, get_rtc_time() is called at boot,
and set_rtc_time() used to be called regulary (the famous code I #if'ed out).

So if it's a userland-only thing, then the set_time() must be removed
since the kernel can't know if the RTC is UTC or local time. Except if we
decide that on PowerMac, we always follow Apple layout (to be compatible
with MacOS X) and implement the UTC/local conversion inside those so they
always expose UTC times to the kernel.

>No, AFAICT nothing bothers with it, only the clock program at boot.

And the fat file system (see below)

>First it is 99% a userland problem: just set export TZ=UTC or any path in
>/usr/share/zoneinfo and all dates will appear as if you were in this
>timezone (try date or ls -l).
>
>The translation between UTC and localtime is performed in the C library,
>using the TZ environment variable or /etc/localtime, and it will know when
>to switch between DST and non DST.
>
>The last problem is updating the clock through NTP when the RTC is running
>in local time. Since these are generally small corrections, there are
>solutions (but the comments of the i386 version say that it is buggy :-().

I see no solution to this problem but do the conversion in kernel. Also,
whatever userland does after boot, it's nice to have a correct time and
timezone as early as possible, especialy if it takes only a few lines of
kernel code to grab the correct MacOS values.

I don't see why we shouldn't have those in-kernel get/set time do the
conversion, at least on pmac. I see no point of trying to mimmic the PC
behaviour here. The Mac clock is supposed to run local time, but we do
have the timezone info in a known location in pram, I see no reason to
let users (on pmac at least) store UTC in the RTC. CHRP/PReP are a
different matter.

Now, I need to check how this interracts with our pmac /dev/rtc so that
userland "see" a consistent kernel interface. This new /dev/rtc driver
means userland will go thry the ppc_md.set/get time functions when using
this driver (the old "clock" program used to directly talk to Cuda/PMU
via /dev/adb, I wanted to get rid of that).

>Until now I've found a single place where sys_tz.dsttime is used in the
>kernel: fs/fat/misc.c when converting between Unix and FAT timestamps.
>Interestingly it's used only in one direction, so it definitely looks like
>a bug. Some other filesystems (affs/hfs/ncpfs/ufs) use the timezone
>information but not the dst field, making FAT time handling look even
>buggier.

Yep. My understanding (and that's also how MacOS uses it) is that the DST
correction is _included_ in the timezone offset, the dst field beeing
just an indication. So yes, FAT is probably broken.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

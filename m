From: Benjamin Herrenschmidt <bh40@calva.net>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: rtc again...
Date: Tue, 8 Aug 2000 19:41:57 +0200
Message-Id: <20000808174157.21374@mailhost.mipsys.com>
In-Reply-To: 
 <Pine.LNX.4.10.10008081855220.13215-100000@opal.biophys.uni-duesseldorf.de>
References: 
 <Pine.LNX.4.10.10008081855220.13215-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>So what about setting the kernel internal time to local time including all
>fixups at least on Powermacs (using the data passed by OF or read from
>NVRAM) and to UTC (or more precisely, whatever the RTC is set to) on all
>those where we cannot determine UTC and DST offsets from OF or NVRAM?
>Next, agree on either returning local time or UTC, at any rate a time
>without accounting for GMT and DST offset, via /dev/rtc so user space
>tools won't notice a difference ? I'd vote for UTC format for /dev/rtc.

I'm against changing the kernel time to something different on some
machines than on others. Let's resume my understanding of things:

The kernel keeps two things:

 - xtime is the current time and should be UTC.
 - sys_tz is the current timezone (usually set from userland)

When the kernel boots, it reads the time from the RTC. On pmac (or any
other machine that has a local time), that means that the kernel boots
with a wrong notion of time until that gets fixed from userland.

That's why I added that code that calculates the real UTC from the xpram.
It also initialize properly the sys_tz structure, since it's easy,
doesn't cost much, and I think it's always better to have a correct value
when we can ;) This would also allow some tools and/or installers to
"read" the timezone at boot in order to propose a default choice or such
things.

Now there are several problems:

 - The first one, well hidden in kernel/time.c (generic code) is the call
to warp_time(). This is an awful hack that seem to be done because PCs
apparently also set the RTC to local time. This hack will cause the
kernel to "bump" the xtime the first time the syscall settimeofday() is
called is it is called with a valid timezone and a NULL timevalue.
With old broken behaviour, this code has the effect of causing the kernel
to "adjust" it's internal time that was wrongly set to local time to be
real UTC as soon as it is notified by userland of the real time zone.
Obviously, this code breaks us. We should probably change it so that a
global variables tells this code we have already inited sys_tz properly
and there's no need to warp.

 - The second one is that ppc_md.get/set_rtc_time are passed (or return)
a time value independently of the timezone. That mean that they either do
no conversion and so it's the responsibility of the caller to "know" if
the RTC is in local time or UTC, or they do the conversion and so return
(and get passed) an UTC time. That's what I decided to do, so on
PowerMac, they do the adjustement from UTC to localtime and the opposite
inside those functions. Paul recently added code to also save the
timezone to the xpram. There's a small semantic problem with this code,
since it takes the time to set to the RTC as a parameter but uses the
global sys_tz. It should either use no parameter (and use only xtime/
sys_tz), or be passed both parameters. In this case, we can probably move
the init code that reads the initial time zone to the pmac_get_rtc_time() too.

 - There's apparently a problem with the definition of the DST field of
sys_tz. The best way to handle this correctly is probably to see how
userland tools like hwclock use it. What is responsible for managing DST
on linux ? Is there a deamon for that ? A tool called from cron ?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

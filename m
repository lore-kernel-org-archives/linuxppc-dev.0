Message-ID: <3991415D.2792242@wanadoo.fr>
Date: Wed, 09 Aug 2000 13:32:45 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: Gabriel Paubert <paubert@iram.es>, linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again...
References: <Pine.HPX.4.10.10008081952360.22126-100000@gra-ux1.iram.es> <20000809084422.4567@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> >
> >I'm slightly lost :-(. But whether the clock is in UTC or not is a
> >parameter (defined in /etc/sysconfig/clock or another system configuration
> >file), so I think that translating to/from UTC when setting the clock is a
> >purely userland job and set/get_rtc_time should never have to handle this.
>
> The problem is that those functions are in-kernel, and without proper
> conversion, they could put incorrect time in the RTC. Those are called by
> /dev/rtc on macintosh, additionally, get_rtc_time() is called at boot,
> and set_rtc_time() used to be called regulary (the famous code I #if'ed out).
>
> So if it's a userland-only thing, then the set_time() must be removed
> since the kernel can't know if the RTC is UTC or local time. Except if we
> decide that on PowerMac, we always follow Apple layout (to be compatible
> with MacOS X) and implement the UTC/local conversion inside those so they
> always expose UTC times to the kernel.

Do I understand this right: As a Pmac user, I have to set "UTC=yes" in
/etc/sysconfig/clock, and then everything will be working correctly? So
only those developers who want to lose their sanity by trying to hack
the kernel time routines have to know that the Pmac CMOS clock is
actually running in localtime, whereas for everyone else, kernel and
userland, it appears to run in UTC?

This makes sense. It also explains the recent confusion: I think I used
to have UTC=yes, until with the recent introduction of rtc.c, everyone
was claiming that the Pmac CMOS clock runs in localtime, so I switched
to UTC=false.

It would be nice to have the same system in all the kernel trees. Right
now, the 5 kernel trees at penguinppc.org have 4 different versions of
the {s|g}et_rtc_time() routines in arch/ppc/kernel/pmac_time.c. In the
bitkeeper-devel kernel, these 2 routines aren't even compatible: If you
say "hwclock --systohc" and then "hwclock --hctosys", you don't get the
same time as before.

<2 reboots later>
This is driving me nuts! What I wrote above worked nicely for a
bitkeeper-2.2.17 kernel with arch/ppc/kernel/pmac_time.c from pmac-benh.
I now tried it with a pmac-devel 2.4.0-test6 kernel which has the same
logic of offsets get_rtc_time() in pmac_time.c, if I am able to read.
But it does not give the same result! System time is off by 2 hours. So
this kernel wants "UTC=false"... And I am back to square one: Impossible
to configure my system using RTC and the new hwclock in such a way that
a 2.2.17 kernel and a 2.4.0 kernel boot up to the same system time.
</giving up>

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-Id: <200008030942.KAA14804@hyperion.valhalla.net>
Date: Thu, 03 Aug 2000 10:41:07 +0100
Subject: Re: rtc again...
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Benjamin Herrenschmidt <bh40@calva.net>,
        martin costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>I am using it as module both for 2.2.17-bk and for 2.4.0-test5. They
>>don't give the same time, and I think it is the one in 2.4.0 that is
>>right. I am at GMT+2:00, and the time in 2.2.17 is 2 hours early. When I
>>change /etc/sysconfig/clock from "UTC=false" to "UTC=true", both times
>>shift by 2 hours, but the discrepancy remains.
>>
>>The following patch for bitkeeper linuxppc_2_2 fixes this problem for
>>me. It brings 2.2.17pre13 in line with 2.4.0-test5 (and MacOS). I cannot
>>test the VIAPMU part, so maybe there the offset is necessary, but for
>>the VIACUDA part, it seems wrong.
>
> You patch reverts a fix I made some time ago. Basially, what probably
> happens is that your RTC is in UTC time, not in local time. The Mac RTC
> is supposed to be in local time, the offset corrects the kernel time on
> boot to account for this. Previously, without that fix, the kernel used
> to boot with a bogus UTC time until userland fixes it.

Hm.  I have exactly the same phenomenon.

I reset my RTC using NTP (on the Mac Side) last night and have daylight
saving set to "automatic".  The Mac timezone is correct (GB).  The Linux
timezone is also correct (GB).  I can't see any other random offsets around
the system.

If rtc is left out (and the module won't/isn't loaded).  2.2.17pre15 gets
the time right (UTC+0100).

If rtc is complied in (and I imagine the same will apply to a working
module) 2.217pre15 gets it one hour wrong. (UTC)

Under 2.4.0-t5 it's OK (well, it agrees with MacOS)...

Note that it has *always* been right with earlier versions of 2.2.x.

Unless, of course, Apple have changed to storing UTC in the transition to
9.0.4 (might ease the way to X?)

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

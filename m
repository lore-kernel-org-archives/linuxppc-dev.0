Date: Thu, 3 Aug 2000 13:25:32 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again...
In-Reply-To: <20000803111422.1301@mailhost.mipsys.com>
Message-ID: <Pine.HPX.4.10.10008031311040.9070-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 3 Aug 2000, Benjamin Herrenschmidt wrote:

> >
> >Actually given the problems with RTC being UTC or local time, the offset
> >might perhaps better be setup as a kernel parameter so that th system
> >start up in a known good state. It seems that it is in RAM for Macs, but
> >what about other machines (I have no problems since all my machines are
> >UTC and I simply refuse to use an OS which requires anything else) ?
>
> Most "sane" RTCs are in UTC. On PReP and CHRP, this is not a problem,
> they use, I think, legacy RTC hardware and so you just need to set it up
> correctly in UTC.
>
> On Macs, it's slightly different. MacOS expects the RTC to be in local
> time and stores the timezone and DSL state in PRAM. I recently added
> fixup code in pmac_time.c for reading that value and correctly setting
> the kernel timezone at boot from it. Paul improved on my code by adding
> the ability to save modified timezone back to PRAM. I think there's still
> an issue with DST. There's a field for storing it in the kernel tz
> structure, but I'm not sure it's fully defined or used. I beleive this
> could be easily fixed by looking at what hwclock does, and eventually
> fixing it.
>
> Note that all this affects only powermacs, and the /dev/rtc driver we are
> talking about here is the pmac-only one in drivers/macintosh.
>
> >Note that I have removed the #if 0 to prevent RTC update from Bemjamin,
> >the code was completely bogus to start with: you should only update the
> >RTC when STA_UNSYNC is clear, not when it is set. If you are using NTP,
> >you don't need anything else: set CONFIG_PPC_RTC off, NTP does RTC updates
> >through adjtimex and this should simply work right out of the box with
> >this patch, at least it does for me and the clock is very stable.
>
> Did you remove the #if 0 or did you remove the code that is #if 0'ed ?
> That code seem to originate from other archs and was causing a lot of
> trouble when enabling the pmac_rtc_set_time() since it was writing bogus
> times to the RTC during boot (at that time, I didn't yet added the code
> to read the timezone from the PRAM).
> Also, I didn't see why the kernel would keep updating the RTC hardware,
> the sounded bogus to me and a userland matter, not a kernel matter (but
> maybe I missed something). So I #if'ed it out. Removing it completely
> sounds fine.

No, I removed the #if 0, it was the condition STA_UNSYNC which was not
correctly tested (inverted actually), and was missing a few additional
conditions (on fractional seconds and so on):

- at boot you set STA_UNSYNC to prevent RTC updates (the inverted test
made that RTC was updated asap instead),

- if you use NTP (as I do) the system uses adjtimex syscall to write into
the RTC at regular intervals. NTP does not use /dev/rtc, it phases locks
to another good source and lets the kernel update the RTC at regular
intervals. This is how it works on all other archs, why would you want to
add a full featured RTC driver when you only need a small subset (and
this guarantees that your system time will be more or less correct when it
reboots and ntp has trouble connecting to the time server) ?

Anyway, we might need something like the Intel port which only sets the
minutes and seconds of the RTC for automatic RC updates. The problem is
that the Intel code is wrong too (it can get the hours wrong if you
change only the minutes). For the rest I looked at the Intel and Alpha
code before doing my patch, and I'm fairly sure that is is for the most
part correct given the results here (I'm rebooting regularly a machine and
noting the offsets of ntpdate at each reboot to be sure that I have got
the fractional second right).

As I said I want this patch tested, it might break some machines but will
be a major timekeeping improvement for all other.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Benjamin Herrenschmidt <bh40@calva.net>
To: Gabriel Paubert <paubert@iram.es>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: rtc again...
Date: Thu, 3 Aug 2000 13:14:22 +0200
Message-Id: <20000803111422.1301@mailhost.mipsys.com>
In-Reply-To: <Pine.HPX.4.10.10008031133480.9070-100000@gra-ux1.iram.es>
References: <Pine.HPX.4.10.10008031133480.9070-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Actually given the problems with RTC being UTC or local time, the offset
>might perhaps better be setup as a kernel parameter so that th system
>start up in a known good state. It seems that it is in RAM for Macs, but
>what about other machines (I have no problems since all my machines are
>UTC and I simply refuse to use an OS which requires anything else) ?

Most "sane" RTCs are in UTC. On PReP and CHRP, this is not a problem,
they use, I think, legacy RTC hardware and so you just need to set it up
correctly in UTC.

On Macs, it's slightly different. MacOS expects the RTC to be in local
time and stores the timezone and DSL state in PRAM. I recently added
fixup code in pmac_time.c for reading that value and correctly setting
the kernel timezone at boot from it. Paul improved on my code by adding
the ability to save modified timezone back to PRAM. I think there's still
an issue with DST. There's a field for storing it in the kernel tz
structure, but I'm not sure it's fully defined or used. I beleive this
could be easily fixed by looking at what hwclock does, and eventually
fixing it.

Note that all this affects only powermacs, and the /dev/rtc driver we are
talking about here is the pmac-only one in drivers/macintosh.

>Note that I have removed the #if 0 to prevent RTC update from Bemjamin,
>the code was completely bogus to start with: you should only update the
>RTC when STA_UNSYNC is clear, not when it is set. If you are using NTP,
>you don't need anything else: set CONFIG_PPC_RTC off, NTP does RTC updates
>through adjtimex and this should simply work right out of the box with
>this patch, at least it does for me and the clock is very stable.

Did you remove the #if 0 or did you remove the code that is #if 0'ed ?
That code seem to originate from other archs and was causing a lot of
trouble when enabling the pmac_rtc_set_time() since it was writing bogus
times to the RTC during boot (at that time, I didn't yet added the code
to read the timezone from the PRAM).
Also, I didn't see why the kernel would keep updating the RTC hardware,
the sounded bogus to me and a userland matter, not a kernel matter (but
maybe I missed something). So I #if'ed it out. Removing it completely
sounds fine.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Sat, 8 Dec 2001 12:24:58 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Michel Lanners <mlan@cpu.lu>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: NVRAM stuck in DST?
In-Reply-To: <200112070759.IAA00984@piglet.grunz.lu>
Message-ID: <Pine.LNX.4.33.0112081120400.2808-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 7 Dec 2001, Michel Lanners wrote:

>
> Hi all,
>
> For some time now (in fact since going back from summer time to winter
> time), my PowerMac 7500 gains one hour at very system boot. No matter
> how I configure it to save sytsem time as GMT or as localtime in the
> RTC, I _always_ get +1 hour on boot.

Do you use any program like adjtime, ntp or write directly to the clock
through the RTC driver ?

If it;s the former, I don't understand how it can happen since the
settimeofday/adjtimex interface will use the offset found in the NVRAM.

For the latter, your clock will be screwed up. But not consistently by 1
hour:

- at boot: read the clock which claims to be UT+2, substract 2 hours

- when writing system clock to RTC:
	- if localtime: write UT+1 to RTC, on next boot you will be
	one hour late
	- if UT: write system time to RTC, on next boot you will be
	two hours late

Unless I've got the signs wrong, your clock should be running late. And it
should depend on whether you are in UTC or not.

I agree there is a bug, but besides the fact that it's not easy to solve,
it should not produce the symptoms that you describe. IMHO time handling
should never go through the RTC driver to start with, or at least it
should be better abstracted: it's too important and too intimately related
to other parts of the kernel.

But believe me, you don't want to overwrite time offset of DST in the
NVRAM. Decent clocks are in UT or TAI...

>
> I've looked at kernel messages, and it says there:
>
> ...
> GMT Delta read from XPRAM: 120 minutes, DST: on
> ...
>
> Hmmm... DST on? That's wrong; we're not in DST anymore! And the current
> offset to GMT is one hour, not two hours. I'm wondering whether
> something else besides MacOS sets those values.

No, the only thing the kernel may overwrite is the time.

>
> If not, then I'll be stuck with whatever NVRAM values MacOS wrote there
> when it was last booted. Which means that unless at every DST time
> change, unless I bot MacOS once, I'll be stuck with the wrong time....

No, I don't think that it is the problem. I believe that the adjtimex
syscall should be enhanced to perform the task of saving time to RTC
when needed, because it is easier to abstract the platform specific
weirdness there than through the RTC driver.

>
> Also, just for my understanding, doesn't MacOS save the system time in
> the RTC in localtime?

It does, unfortunately (same for Windows).

> In that case I don't see how time _advances_ on
> boot... unless the MacOS RTC is in DST-less localtime.
>
> Anybody with more insight here?

Still trying to understand exactly what happens.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-Id: <200008081137.MAA10748@hyperion.valhalla.net>
Date: Tue, 08 Aug 2000 12:35:10 +0100
Subject: Re: rtc again...
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Gabriel Paubert <paubert@iram.es>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC: benjamin herrenschmidt <bh40@calva.net>,
        martin costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   Tue, Aug 8, 2000, Gabriel Paubert wrote:
> On Fri, 4 Aug 2000, Geert Uytterhoeven wrote:
>
>> > Actually given the problems with RTC being UTC or local time, the offset
>> > might perhaps better be setup as a kernel parameter so that th system
>> > start up in a known good state. It seems that it is in RAM for Macs, but
>> > what about other machines (I have no problems since all my machines are
>> > UTC and I simply refuse to use an OS which requires anything else) ?
>>
>> Why do you want to handle the offset in the kernel???
>>
>> Any decent distro (e.g. Debian) allows to configure the time system for a
>> hardware clock running in either UTC or local time, so the correction will be
>> done on boot up.
>>
>
> I think there is some misunderstanding here. I don't want to handle the
> offset in the kernel, with one possible exception: when reading the
> RTC for the first time to initialize xtime. Getting timestamps right as early
> as possible might be important in some cases, and it's not a big deal
> since the code to do this is small and thrown away anyway.
>
> Oh and I can't remember whether the clock or hwclock command ever worked
> on my machines. I think hwclock did once upon a time; life is so much
> simpler with NTP anyway (but it is run quite late in the boot process,
> actually just before the rc.local script on most of my machines and after
> mounting NFS file systems and starting daemons like syslogd/crond/inetd).

I seems to me (in summary) [since I started this thread :-) ]:

we can:

(a) Fix up time in the kernel to emulate UTC
(b) Fix up time in the kernel to emulates Local Time

Which (or will both) of these works with hwclock (since that is the
mechanism at 2.4.0 ?)  and for those of us switching to-and-ffo is also
being used at 2.2.17

I would like to make sure that timestamps are right during kernel boot -
and, at the moment, when using 2.2.17 I have to 'artificially' disable rtc
to get the correct time.

For many (paid-by-the-call) telephone network users NTP is not a suitable
option - they don't like the machine making calls without asking.

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

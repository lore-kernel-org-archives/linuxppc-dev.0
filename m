Message-Id: <200007142149.WAA03525@hyperion.valhalla.net>
Date: Fri, 14 Jul 2000 22:48:13 +0100
Subject: Re: [linux-audio-dev] [ANN] First latency test results for
	 linuxPPC  [2.2.17pre10-ben2]
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Roger Larsson <roger.larsson@norran.net>
CC: linux-audio-dev@ginette.musique.umontreal.ca,
        linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  Fri, Jul 14, 2000, Roger Larsson wrote:
> Iain Sandoe wrote:
>> I've posted the results of Benno's latency tests applied to 2.2.17pre10-ben2
>> on LinuxPPC.
[...]
>> No big surprises - although the PPC /proc fs seems to be a little slower
>> than the x86 one...
>>
>> Working on 2.4.0-test4 & thence to Andrew's patches on LinuxPPC...
[...]
> The green ticks on X11 test are interesting - something with a higher
> prio than
> the SCHED_FIFO max takes the processor away from it and runs for more
> than 1 ms.
>
> The only thing that can do that is interrupt routines / back handlers...
> (try to find this one)

Yeah, I've got a concern there... I have Jun Sun's IRQ latency test code
ported.  I'll re-do the patch and try it again.

I have a feeling that the first time through (with the IRQ code) I may have
made a mistake in the value of the freq of the VEA Timebase counter.

If this is true then the IRQ times for the PPC are truly awful on
occasions..

I.E. I had the freq as 300 MHz - but I think it is actually approx 18MHz.

If that is the case then there is/are something/some things that are holding
IRQs off for up to.... > 9 or so ***ms***  Yikes.

I'll check this out tomorrow... but locating them might be hard because most
of the longer times are recorded in 'softira.c' & 'irq.c' - which doesn't
narrow things down much.

Expect a re-do of the IRQ patch tomorrow - and a request to try it out :-)

> Disk read looks nice - others looks ...

ummm /proc was the one that looked worst to me...

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <39289B8C.6A565002@da-san.com>
Date: Mon, 22 May 2000 11:29:32 +0900
From: Seungdong Lee <sdlee@da-san.com>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8240 BogoMIPS
References: <39263EA0.69C60AA9@da-san.com> <3926CD15.441C87AB@embeddededge.com>
Content-Type: text/plain; charset=EUC-KR
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> Seungdong Lee wrote:
> >
> > Hi Dan, I have successfully ported Linux to my customized 8240 board.
>
> Cool!  Good job.  What version of software are you using?  Did you
> make any changes or want your board part of the kernel tree?
>

I used Sandpoint-8240 port from Hard Hat Linux as a starting point, and my
board is not widely available one.
So, I don't think that it is valuable to make a kernel tree for my work.

>
> > Linux runs fine, but I found that the performance is not as good as my
> > expectation.
>
> Is this just based on the BogoMIPS number, or do you have some
> benchmarks for comparison?
>

I am saying about only BogoMIPS. I know that 8xx board shows 50 BogoMIPS when
I/D-caches are enabled.
It is theoretically correct. BogoMIPS assumes that a loop consumes two
instructions, which is true for 366(or higher) system.
The same logic is applied to the other platforms. Test loop for PowerPC uses
only one instruction.
But, fortunately 8xx family consumes two clock  cycles for branch instruction,
so loops_per_sec is one half of CPU clock frequency.
BogoMIPS, that is 2*loops_per_sec, should be same to CPU freq. In case of 603
or 8240, branch instruction consumes only one CPU
clock. So, BogoMIPS is 2*loops_per_sec, or 2*(CPU freq).  I checked this
argument on PowerMAC(G4 and 7500).
G4 uses PowerPC 7400 and PowerMAC 7500 uses PowerPC 604. They shows double the
value of CPU clock as BogoMIPS.

>
> > BogoMIPS value of my board is currently 131.89.
>
> I have not booted my 8240 for a while, and I don't remember the number.
> I have another 8240 showing up soon, so I will be back on that before
> long and will pay attention to this.  For some reason, I do remember that
> with caches disabled this number is _really_ small, like 13 or 18 or
> something.
>

That's correct, if caches are disabled, it's 12.9. Loop itself is not affected
by D-cache because test loop doesn't have data load/store operation.
But, jiffies increment depends on Dectrementer exception handling. This part
makes D-cache has an impact on BogoMIPS.

>
> I don't believe any absolute number here.  I just use it for a quick
> reference when I am testing various cache combinations to indicate
> that I am booting the kernel I wish to be using.
>

I don't believe that, either. But, if CPU is running in low frequency, the
performance will be low.

>
> If this doesn't seem correct, ensure the processor is really running
> at the clock rate you expect.  Verify external clocks, PLLs and the like.
> Also, make sure the timers used to determine this value are properly
> programmed.  One test I always perform is to run 'sleep 10' at the
> shell prompt, and time it with my watch.  It should be really close
> to 10 seconds, 9 or 11 on my watch are not close :-).
>

Clock tick is correct, unless my watch is not out of order. And reference
clock and PLL configuration has been checked.
After booting, HID0 was checked and it's value matches what I configured.

>
> > Both I/D-cache are enabled. So, theoretical BogoMIPS should be around
> > 400.
>
> I wouldn't use BogoMIPS for any kind of benchmark.  There have been
> plenty of discussions on mailing lists (including linuxppc lists) to
> indicate this abosolute number doesn't mean much.  I have many PowerPC
> systems running Linux, from 8xx embedded though 7400/G4 systems.  I
> certainly can't predict what this number "should" be.
>

I am sure  that you could predict it if you looked into the logic of
measurement. :)
I know that it is not a performance barometer but can be a check point.

>
> Verify clocks and timers are working and run some real benchmarks.
>
>         -- Dan
>

Thank you for your interest.

-- Seungdong Lee


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

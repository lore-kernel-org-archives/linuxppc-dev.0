Date: Fri, 20 Apr 2001 05:27:02 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Steven Hein <ssh@sgi.com>
Cc: Dan Malek <dan@mvista.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 860 RTC support
In-Reply-To: <3ADF3F32.C42D6D6E@sgi.com>
Message-ID: <Pine.HPX.4.10.10104192144260.11443-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 19 Apr 2001, Steven Hein wrote:

> I looked through the source, and the difference between the 2.2.x
> (2.2.13
> and 2.2.14 mvista kernels) and the 2.4.3 kernel is that, in the
> 2.2.x kernel, the set_rtc_time function in timer_interrupt()
> can only be called if (time_status & STA_UNSYNC) != 0, where
> in the 2.4.x kernel set_rtc_time can only be called if the
> (time_status & STA_UNSYNC) == 0.  As I see it, the STA_UNSYNC bit
> is always set, so the RTC will never be updated!
>
> At first I suspected just a bug in the PPC code regarding this bit,
> but I glanced through the time code in some of the other arch's
> (sh, sparc, arm, etc.) and saw the identical logic:
>     - a call to do_settimeofday() *always* sets the
>       STA_UNSYNC bit in time_status
>     - the RTC is only updated when STA_UNSYNC is *not* set
> And I don't see any way that STA_UNSYNC gets cleared (unless it's
> cleared by adjtimex() or something like that......

True, the logic is now correct and similar with other archs, this means
that the RTC is regularly updated when the clock is locked to another
reference (ntp mostly). The only difference with x86 is that the clock is
completely rewritten (not only the minutes and the seconds). This means
that you should know whether your RTC is UTC or not.

I'd rather recommend using UTC unless you have to dual-boot with some OS
which requires local time RTC like MacOS, but even then the situation is
not as bad as it seems since Mac also store the timezone which allows
to correct for this.

However, if you don't want to add the /dev/rtc driver to your system,
which I understand (I don't use it either) and still update the rtc
without a process like NTP, it is fairly trivial to write a utility which
clears the STA_UNSYNC bit through adjtimex(2), waits for a quarter of an
hour and sets again STA_UNSYNC. As long as all the PLL variables are zero,
it should do no harm.

But this is a kludge, a much cleaner way would be to define an additional
bit in time_status, like STA_UPDATE_RTC which would bypass the
last_rtc_update and STA_UNSYNC checks in do_timer_interrupt and clear the
flag as soon as the clock has been updated (within one second actually).
Then copying the system clock to the RTC becomes very simple:
- set the time with settimeofday() if necessary (date command)
- adjtimex(...) to get the current status bits
- adjtimex(ADJ_STATUS,...) to set the STA_UPDATE_RTC flag
- sleep one second
- adjtimex(...) to check that STA_UPDATE_RTC has been cleared,
  return error if not.

The required kernel patch would be minimal since you don't even need to
modify kernel/timer.c.

If you are really paranoid because the STA_UPDATE_RTC could be cleared by
another (root) user before the update takes place, you'll define another
mode (ADJ_UPDATE_RTC) that will set STA_UPDATE_RTC (defined as a read-only
flag) and will be cleared by the timer interrupt. But in this case you'll
have to modify kernel/timer.c also.

> I had printk's in m8xx_set_rtc, and they never printed.
> (even after an hour or more).  Again, it looks like it all boils down
> to the value of the STA_UNSYNC bit in 'time_status' and how
> that gets manipulated.

Yes, but the solution is not to try to change these mechanisms, they are
designed to work with ntp (the PPC code has long had some interesting
bugs, like rewriting the RTC just after reading it at boot, but I had to
shutdown ntp to get the RTC updated !) What you need is an additional
mechanism that allows you to access ppc_md.set_rtc_time() with minimal
kernel bloat.

For more info, man {hw,}clock and adjtimex([28]), info date and pointers
from therein.

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

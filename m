Date: Fri, 20 Apr 2001 11:10:33 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Steven Hein <ssh@sgi.com>
Cc: Dan Malek <dan@mvista.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 860 RTC support
In-Reply-To: <3ADF3F32.C42D6D6E@sgi.com>
Message-ID: <Pine.HPX.4.10.10104201048060.11443-100000@gra-ux1.iram.es>
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

Right, I modified time handling to work like ther other archs when
rewriting the timer code, mostly to make it more robust, keeping time
despite bad-behaved code which masks interrupts long enough to lose ticks
(framebuffer at the time, it's claimed to be fixed now, and also printk on
serial consoles).

Indeed, only adjtimex can clear STA_UNSYNC. ntp does it as soon as it
acquires lock, don't ask me about adjtimex(8), I never used it.

> I had printk's in m8xx_set_rtc, and they never printed.
> (even after an hour or more).  Again, it looks like it all boils down
> to the value of the STA_UNSYNC bit in 'time_status' and how
> that gets manipulated.

Correct.

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

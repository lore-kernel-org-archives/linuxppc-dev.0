Message-ID: <3ADF1377.72242D3B@sgi.com>
Date: Thu, 19 Apr 2001 11:33:59 -0500
From: Steven Hein <ssh@sgi.com>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 860 RTC support
References: <3ADE0222.BF7F539C@sgi.com> <3ADE0501.321052F9@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
>
> > Is there a working method (to read the RTC value at boot-time)?
>
> The MPC8xx real-time clock is implicitly managed in the kernel.
> At boot time, the register is read and stored in the kernel
> time.  Whenever the kernel time is updated, the hardware register
> is also updated.  Since the 8xx is simply a 32-bit register
> access with an update rate that matches the kernel time, I
> chose to do it this way.
>

Dan,

My question was poorly worded (because at that point I
didn't understand the whole picture.....).  I know that the
860's RTC on my board is working properly, that's not the issue.

My problem is this:   when I set the date via the "date --set"
command (which calls stime()) or by calling settimeofday() directly,
it doesn't result in the 860's RTC being updated.
Yes, do_settimeofday() gets called properly, but it never results
in ppc_md.set_rtc_time ==> m8xx_set_rtc_time getting called!
(The only place I see that called is in timer_interrupt in
arch/ppc/kernel/time.c, and it's only called if the STA_UNSYNC
bit is not set in timer_status.  do_settimeofday() results
in the STA_UNSYNC bit being set and I don't see how it gets
cleared.....).

I also looked at the other approach of configuring in /dev/rtc
and using hwclock, but the kernel won't boot with this
drivers/char/rtc.c
built in, and that doesn't look like it has 8xx support anyway.

In your response, you said "Whenever the kernel time is updated, the
hardware register is also updated.".  Is settimeofday()/stime()
the methods of updating the kernel time that you were talking about?

I know I'm missing something, as it sounds like this works for others,
but I'd greatly appreciate it if someone would clue me in!
(Again, I'm using the 2.4.3 kernel, if that's relevant).

Thanks,
Steve

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

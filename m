Message-ID: <3ADF3F32.C42D6D6E@sgi.com>
Date: Thu, 19 Apr 2001 14:40:34 -0500
From: Steven Hein <ssh@sgi.com>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 860 RTC support
References: <3ADE0222.BF7F539C@sgi.com> <3ADE0501.321052F9@mvista.com> <3ADF1377.72242D3B@sgi.com> <3ADF3970.C015DB5D@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
>
>
> Ahh, OK.  I'll take a look at this.  I thought it used to work in
> older kernels.  It's on my list (or if someone else wants to take
> a look and send a patch ...... :-).
>

I looked through the source, and the difference between the 2.2.x
(2.2.13
and 2.2.14 mvista kernels) and the 2.4.3 kernel is that, in the
2.2.x kernel, the set_rtc_time function in timer_interrupt()
can only be called if (time_status & STA_UNSYNC) != 0, where
in the 2.4.x kernel set_rtc_time can only be called if the
(time_status & STA_UNSYNC) == 0.  As I see it, the STA_UNSYNC bit
is always set, so the RTC will never be updated!

At first I suspected just a bug in the PPC code regarding this bit,
but I glanced through the time code in some of the other arch's
(sh, sparc, arm, etc.) and saw the identical logic:
    - a call to do_settimeofday() *always* sets the
      STA_UNSYNC bit in time_status
    - the RTC is only updated when STA_UNSYNC is *not* set
And I don't see any way that STA_UNSYNC gets cleared (unless it's
cleared by adjtimex() or something like that......

>
> As I recall, there are events that occur to update the RTC from
> the kernel's notion of time, and one used to be some timeout.  Perhaps
> after you set the time, if you wait for a while it may update the RTC.
>

I had printk's in m8xx_set_rtc, and they never printed.
(even after an hour or more).  Again, it looks like it all boils down
to the value of the STA_UNSYNC bit in 'time_status' and how
that gets manipulated.


--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Steve Hein (ssh@sgi.com)              Engineering Diagnostics/Software
Silicon Graphics, Inc.
1168 Industrial Blvd.                 Phone: (715) 726-8410
Chippewa Falls, WI 54729              Fax:   (715) 726-6715
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

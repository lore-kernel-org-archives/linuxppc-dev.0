Message-ID: <3ADE0501.321052F9@mvista.com>
Date: Wed, 18 Apr 2001 17:20:01 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Steven Hein <ssh@sgi.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 860 RTC support
References: <3ADE0222.BF7F539C@sgi.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Hein wrote:

> Is there a working method (to read the RTC value at boot-time)?

The MPC8xx real-time clock is implicitly managed in the kernel.
At boot time, the register is read and stored in the kernel
time.  Whenever the kernel time is updated, the hardware register
is also updated.  Since the 8xx is simply a 32-bit register
access with an update rate that matches the kernel time, I
chose to do it this way.

If you provide the appropriate crystal and battery to the 8xx,
you get a non-volatile time of day clock.

Most implementations seem to choose an external time of day clock
that is already managed by one of the RTC drivers.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

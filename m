Message-ID: <380CCBAC.7C0DB544@netx4.com>
Date: Tue, 19 Oct 1999 15:51:08 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: Dan Malek <dan@penguin.netx4.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: /dev/watchdog for onchip MPC860 watchdog?
References: <19991019085603.D1026B23A@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:


> .... The watchdog can't
> be disabled/reenabled, and its maximum period is only a couple of seconds;
> there's no guarantee that the kernel will have booted and loaded the
> application by then, so the watchdog is likely to go off during the boot
> process. I think this probably puts my plans to use it on hold for now...

Maybe not.  I was thinking about this (when I should have been doing
other things :-) earlier today.  What we could do when the internal
watchdog is configured is to service it during the Linux timer
interrupt when an application doesn't have it "enabled".  This
doesn't provide a watchdog service, just ensures it doesn't
unexpectedly expire.  When an application decides it wants the
watchdog, we don't service it in the timer ISR.

We would have to litter the boot code with some service calls,
like when you wait at the Linux boot prompt, and make sure
you can uncompress and enable timer interrupts before the next
expiration.  Beyond that, we wouldn't have to look for any
watchdog service points in the kernel.

I may play with it later tonight........


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

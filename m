Message-ID: <380E002A.92B3AEC8@netx4.com>
Date: Wed, 20 Oct 1999 13:47:22 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Jeff Millar <jeff@wa1hco.mv.com>
CC: Dan Malek <dan@penguin.netx4.com>,
        Graham Stoney <greyham@research.canon.com.au>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: /dev/watchdog for onchip MPC860 watchdog?
References: <19991019085603.D1026B23A@elph.research.canon.com.au> <380CCBAC.7C0DB544@netx4.com> <003e01bf1a9e$59f44980$0201a8c0@home>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jeff Millar wrote:

> If the boot process goes bad, then the interrupt driven watchdog will
> keep getting reset and prevent the watchdog from firing...


Yes....The alternative is finding all of the places in the kernel
where you would have to service the watchdog during the boot process.
Probably not many.....Depends upon the timeout value.


> .......  So, what's the likely hood of the boot process
> going bad?

My experience has been that unless the hardware is broken, it
tends to either work every time or fail every time.

> Our application requires downloading new kernels and applications and this
> may
> increase the likely hood that a kernel fails to complete the boot process.

Yes, it will.  But....what do you do after the new software
load fails to boot?  It will just keep resetting and running the
same broken software......


> Maybe the timer can be set longer than the longest bootup time or at least
> until the first daemon gets going?

All of the timeout and other controls are in the write-once SYPCR.
Once you select the timeout and behavior, you have it until the
next reset.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

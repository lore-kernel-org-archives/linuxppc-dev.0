MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 4xx watchdog handling
Date: Wed, 22 Oct 2003 08:08:38 -0400
Message-ID: <C6D44AA99ECEB540A5498F15F92DA07D6888AD@amperion01>
From: "Jeff David" <jdavid@amperion.com>
To: "Brian Kuschak" <bkuschak@yahoo.com>,
	<linuxppc-embedded@lists.linuxppc.org>,
	<ppcboot-users@lists.sourceforge.net>,
	"Robert Labrecque" <lbrecque@us.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a problem with the 405H which may have been experienced and
possibly solved by someone out there in the user community.

We're using the ppc4xx watchdog handler that comes with Linux 2.4.17.
It uses the PIT, as described by Brian, below.

What we've seen is that the watchdog sometimes expires unexpectedly
during the ppc405wd_open function, specifically, when the Watchdog Reset
Control (WRC) bits are written to the TCR register.  (These bits control
the reset function.)

According to the manual, however, the reset function should not occur
when the ENW and WIS bits are cleared in the TSR register.  I have added
code to make absolutely certain that they are cleared just before
setting the WRC bits.

The only thing that I have not tried yet, is to turn off critical
interrupts (which control the watchdog interrupt) during the setting of
the WRC bits, but these seems drastic and unnecessary, since the
watchdog interrupt is not even enabled!  Does this seem like a viable
solution?

There is nothing in the 405 errata about this.  Has anybody else
experienced this problem?

Thanks,
Jeff


> -----Original Message-----
> From: Brian Kuschak [mailto:bkuschak@yahoo.com]
> Sent: Friday, November 01, 2002 2:14 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Cc: bkuschak@yahoo.com
> Subject: 4xx watchdog handling
>
>
>
> Regarding the way 2.4.19 handles the 4xx watchdog:
>
> The 4xx timer interrupt, the PIT, is the lowest
> priority exception (18). All the external IRQs come in
> at a higher priority (16).  This is opposite of x86,
> where the timer ISR is highest priority (0).
>
> This would seem to negate the effectiveness of drivers
> which implement "work limits" in their ISRs (like many
> ethernet drivers).  These drivers do an RFI after
> doing a certain amount of work, leaving the interrupt
> pending and returning later to finish up.  In the case
> of 4xx, a pending PIT interrupt would not be serviced
> due to its lower priority.  In the case of heavy IRQ
> load, the watchdog can expire.
>
> Has anyone considered implementing the 4xx watchdog
> interrupt itself as the place to refresh the watchdog?
>  We could still use the existing method of a heartbeat
> counter decremented each time, but just do the
> refreshing in a watchdog ISR rather than the timer
> ISR.  This way the watchdog could be reliably
> refreshed even during heavy IRQ loads.
>
> Any comments?
>
> -Brian
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

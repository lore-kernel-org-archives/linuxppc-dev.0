Return-Path: <dpelton@ciena.com>
Received: from mdmxm01.ciena.com (LIN1-118-39-26.ciena.com [63.118.39.26])
	by ozlabs.org (Postfix) with ESMTP id 4FD60679FC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Apr 2006 01:36:37 +1000 (EST)
Subject: RE: Watchdog on MPC82xx
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 19 Apr 2006 11:23:48 -0400
Message-ID: <3B9518857C91E345AA1806A6F53C0EB7016D1539@onmxm01.ciena.com>
From: "Pelton, Dave" <dpelton@ciena.com>
To: "linuxppc-embedded list" <linuxppc-embedded@ozlabs.org>
Cc: Bastos Fernandez Alexandre <alebas@televes.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Alex,

I have recently been trying to get the internal watchdog timer working
with 2.6.15 on a MPC8247 custom board (@ 266MHz), and hence I have been
following this thread with great interest.

I tried the heartbeat method (setting ppc_md.heartbeat to kick the
watchdog) and I was unable to get it to work correctly.  To help things
I tried sprinkling a few kicks of the watchdog through the early layers
of init code but this seemed to make no difference.

I also tried porting the mpc8xx watchdog driver to the mpc82xx
architecture (i.e. kicking the watchdog using the PIT interrupt).  This
seemed to fail in the same way.  I would see about 8 or 10 characters of
the initial start-up message (where it dumps the Linux version and the
build time) and then the watchdog would kick the card back to u-boot.

As a last resort I tried kicking the watchdog in the printk call (in
essentially the same way that you do below), and I found that this
worked correctly when used in conjunction with the ported version of the
mpc8xx watchdog driver.  I suspect it would work equally well with the
heartbeat method.

I don't understand why kicking the watchdog from printk fixes things,
and it really seems like an ugly way to fix this problem.  I did the
quick math to figure out how long it will take the watchdog to trigger,
and at my clock rate of 266MHz, the watchdog fires in about 0.5 seconds,
which means that anything that runs for longer than 0.25 seconds could
cause a watchdog trigger.  My best guess is that within printk there is
something that exceeds this margin, but looking in the code I can not
see what that would be (unless draining the printk console output over
the ttyCPM0 serial port somehow takes a long time).


Perhaps some of the wise ones on the list could provide some suggestions
on why printk seems to be the sticking point for the watchdog.


- David Pelton.


-----Original Message-----
Sent: Wednesday, April 19, 2006 7:14 AM
To: linuxppc-embedded list
Subject: Re: Watchdog on MPC82xx

Well,

I have tested two different approaches which has been confirmed to be
already working on MPC82xx boards.

One, from Paul Bilke, is based on modifiying printk to service the WDT
and reload the counter during boot time.
So I have modified kernel/printk.c and tested with this:

asmlinkage int printk(const char *fmt, ...) {
    va_list args;
    int r;

    force_wdt_reload();
    [...]
}


<< snip >>

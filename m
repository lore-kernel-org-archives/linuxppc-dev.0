Message-ID: <3AD5B240.49C8A846@pt.com>
Date: Thu, 12 Apr 2001 09:48:48 -0400
From: Scott Rogerson <sar@pt.com>
MIME-Version: 1.0
To: hea23587@bigwig.net
Cc: linuxppc-embedded@lists.linuxppc.org, jtm@smoothsmoothie.com
Subject: Re: Ethernet Bridging on 8260
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I encountered the same problem with the FCC driver for the 8260.  For
the most part I agree with your analysis of the problem.  I think
however that you may have an unintended consequence with your solution.

As you stated a packet is queued by the driver via netif_rx() which
before your modification occurred in the interrupt handler.  This queue
is then marked with mark_bh(NET_BH).  The network queue (for that matter
all bottom half queues) is normally drained prior to leaving the
interrupt context when no further interrupts are pending.  In other
words the queue is normally drained immediately.

By scheduling the netif_rx() call you may have introduced a lag of up to
1 jiffy 1/100th of a second between receiving a packet and processing
that packet. It's true that this delay is only associated with the first
packet but it will be there every time you leave the driver interrupt
service routine.

I solved it in a way similar to your suggestion of putting a quota on
the rx bd ring processing.  If while in the interrupt handler the quota
is exceeded, the rx interrupt gets turned off for 1 jiffie (I schedule a
task to turn it back on after 1 jiffy) thereby allowing user code to
run.   I experimented with the quota to ensure that normal traffic that
I want to process does not cause me to disable the interrupt.  It really
is only abnormal stuff (ie smart bits or perhaps a broadcast storm)
which will cause me to gate the rx process.  The end result is the same
in that the console responds normally under any smart bits load but
there is no lag in processing normal network stuff.

Good luck

Scott Rogerson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

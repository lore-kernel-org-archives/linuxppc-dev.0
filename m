Message-ID: <20021101191357.62463.qmail@web40912.mail.yahoo.com>
Date: Fri, 1 Nov 2002 11:13:57 -0800 (PST)
From: Brian Kuschak <bkuschak@yahoo.com>
Subject: 4xx watchdog handling
To: linuxppc-embedded@lists.linuxppc.org
Cc: bkuschak@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Regarding the way 2.4.19 handles the 4xx watchdog:

The 4xx timer interrupt, the PIT, is the lowest
priority exception (18). All the external IRQs come in
at a higher priority (16).  This is opposite of x86,
where the timer ISR is highest priority (0).

This would seem to negate the effectiveness of drivers
which implement "work limits" in their ISRs (like many
ethernet drivers).  These drivers do an RFI after
doing a certain amount of work, leaving the interrupt
pending and returning later to finish up.  In the case
of 4xx, a pending PIT interrupt would not be serviced
due to its lower priority.  In the case of heavy IRQ
load, the watchdog can expire.

Has anyone considered implementing the 4xx watchdog
interrupt itself as the place to refresh the watchdog?
 We could still use the existing method of a heartbeat
counter decremented each time, but just do the
refreshing in a watchdog ISR rather than the timer
ISR.  This way the watchdog could be reliably
refreshed even during heavy IRQ loads.

Any comments?

-Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

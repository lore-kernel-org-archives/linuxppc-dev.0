Message-ID: <3C112297.6DE37608@labs.mot.com>
Date: Fri, 07 Dec 2001 14:12:07 -0600
From: Steve Rossi <srossi@labs.mot.com>
MIME-Version: 1.0
To: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: high priority interrupts disabled
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,
I'm using linuxppc-2.4.16 on custom 855T based hardware. I've got an IDE
disk and I'm using the 8xx IDE driver in EXT_DIRECT mode. The ide
interface is using IRQ6, and I've got two other interrupts of interest
on IRQ1 and IRQ2. I have found that when I'm continuously streaming data
to the disk, one interrupt gets puts off for too long. I have observed
on a logic analyzer, IRQ2 gets asserted and remains asserted (without
being serviced) in excess of 10ms during which IRQ6 (hard disk) is
asserted and quickly serviced over 120 times, and IRQ1 is also asserted
and quickly serviced several times in that 10ms. IRQ2 doesn't get
serviced until the disk activity completes - perhaps at the end of
ide_multiwrite() - though I haven't verified this. So why is IRQ2 which
is higher priority than IRQ6 not being serviced yet IRQ1 is? I've set
drive->unmask=1 in the ide drive structure, so __cli() doesn't get
called in do_rw_disk(). IRQ1 is requested with the SA_INTERRUPT flag,
while IRQ2 is not - should this matter? I need for IRQ2 to be able to
preempt the disk write in the same way that IRQ1 is able to. If anyone
can offer any suggestions as to why its not, or where I should be
looking, that would be helpful.

Thanks,
Steve

--
-------------------------------------------------------
Steven K. Rossi                     srossi@labs.mot.com
Staff Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Thu, 11 Mar 1999 10:02:24 -0500 (EST)
From: Charles Lepple <clepple@ee.vt.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: IRQ handling in port to DY4 SVME-177
Message-ID: <Pine.GSO.3.96.990311095123.13324B-100000@birch.ee.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
I'm working on porting the kernel to a DY4 SVME-177 board, a mil-spec 603e
single-board system (no PCI, nonstandard I/O, the works).

Anyway, the problem is with the interrupt controller, and it's more of an
architectural question. A Tundra SCV64 has several 'local IRQ' lines, but
as it turns out, they put all the useful stuff (serial, ethernet, SCSI) on
the same level IRQ level (LIRQ5). The RTC and other timers each get their
own IRQ level, as does the MAXpack interface. Is it probable that I can
get by with this sharing arrangement in arch/ppc/kernel/irq.c, or am I
going to have to create pseudo-IRQs for each device, and make it look like
a cascaded interrupt? The IRQ lines themselves are all level-sensitive,
but I'm wondering if the IRQ mask code in irq.c is going to be enough.
After all, am I losing anything but performance by using the same
interrupt line? (not that I would have designed it this way...)

--Charles Lepple                    |  Check one:
System Administrator                |    ( ) Routine matter
Virginia Tech EE Workstation Labs   |    ( ) Urgent
clepple@ee.vt.edu                   |    ( ) The future of the known 
http://www.ee.vt.edu/help/          |        universe hangs in the balance


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

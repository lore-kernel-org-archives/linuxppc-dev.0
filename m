Subject: ppc826x BAD interrupts
From: Jeff Angielski <jeff@theptrgroup.com>
To: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1074268973.4323.13.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 16 Jan 2004 11:02:53 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Looking at /proc/interrupts, I see a large number of "BAD" interrups on
both my MPC8260 reference board (2.4.21) and my PPC8266 custom board
(2.4.23).  Both use u-boot as the bootloader.

bash-2.05# cat /proc/interrupts
           CPU0
 24:          0   8260 SIU   Edge      PCI IRQ demux
 33: 2658326944   8260 SIU   Edge      fenet
 40:      32524   8260 SIU   Edge      uart
 41:          0   8260 SIU   Edge      uart
BAD:    8862006  <<====== this the problem

The source of this count is ppc_spurious_interrupts which is incremented
in the arch/ppc/kernel/irq.c if:

	1) there is no interrupt handler installed

	2) SIVEC is showing zero (no interrupts pending)

Looking into the problem it would appear that the problem is the later
case and the get_irq() function in ppc8260_pic.c is indeed reading a
zero from the SIVEC.

The questions I have are:

1) Has anybody seen this behavior on their PowerPC platform?
2) Does anybody know why the SIVEC would be showing a zero?

TIA,
Jeff Angielski
The PTR Group


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: ppc826x BAD interrupts
Date: Fri, 16 Jan 2004 11:29:51 -0500
Message-ID: <8529B5552D4EAA4DAEDF49650C64B2B436E589@tarpon.mangrovesystems.com>
From: "Muhammad Sarwar" <msarwar@mangrovesystems.com>
To: "Jeff Angielski" <jeff@theptrgroup.com>,
	<linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This problem was discussed on mailing list before also and you can eliminate this problem by inserting a sync instruction at a certain place in the 8260 interrupt handling code. See, for example, http://www.geocrawler.com/archives/3/8358/2002/11/100/10173445/

Add a __asm__ volatile("sync"); at the end of the m8260_mask_and_ack  function in arch/ppc/kernel/ppc8260_pic.c to fix it.


Regards,
 
Muhammad Sarwar
Mangrove Systems Inc.


-----Original Message-----
From: Jeff Angielski [mailto:jeff@theptrgroup.com]
Sent: Friday, January 16, 2004 11:03 AM
To: linuxppc-dev@lists.linuxppc.org
Subject: ppc826x BAD interrupts


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

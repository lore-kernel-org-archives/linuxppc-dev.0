Content-Type: text/plain;
  charset="us-ascii"
From: Trevor Woerner <ppc339@vtnet.ca>
Reply-To: ppc339@vtnet.ca
To: linuxppc-dev@lists.linuxppc.org
Subject: lost interrupt
Date: Mon, 26 May 2003 23:41:59 -0400
MIME-Version: 1.0
Message-Id: <200305262341.59883.ppc339@vtnet.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm getting the dreaded "lost interrupt" whenever the kernel tries to
access my onboard CF card. I put an 'IDE_DEBUG' at the start of
'ide_intr()' so I could watch to see if/how many times my interrupt
occurs or gets called. As an example, after I run 'cardmgr' I'll get
7 'lost interrupt' messages. After the last one, I'll get 7
'IDE_DEBUG' messages indicating that there were 7 interrupts queued
and waiting on the correct interrupt line.

So if 7 interrupts are sitting there waiting on the correct line, why
can't they get into the kernel so it can know the CF card is ready,
instead of having to wait for each IDE operation to timeout? From
googling around the usual cause of 'lost interrupt' is setting the irq
incorrectly, but the fact that all 7 get delivered (eventually) to the
ide's 'ide_intr()' would seem to indicate that at least that part is
configured correctly, no?

[relevant info]
kernel: 2.4.20-rc1
interrupt: external #6 (known as 31 internally), shared
cpu: PPC405gp

in 'ide-cs.c' i call 'ide_setup_ports()' to configure the device and I
define an 'ack_intr()' in order to acknowledge and turn off the
shared interrupt. The interrupt is shared, but not with other IDE
hwif's. I'm not using DMA, chipset is 'ide_generic'. This is not a
PCI device.

How do 'ide_ack_intr()' and 'hwif->intrproc()' differ? I've only setup
'ide_ack_intr()', it appears to return a 1 if it determines the
shared interrupt source was the IDE, or 0 if it wasn't. I also use
this place to put the code to reset (or turn off) the interrupt. What
would 'intrproc()' do?

	Trevor

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <20030514051548.90794.qmail@web11008.mail.yahoo.com>
Date: Tue, 13 May 2003 22:15:48 -0700 (PDT)
From: Xupei Liang <tliang@yahoo.com>
Subject: IDE driver support in PPC440
To: linuxppc-embedded@lists.linuxppc.org
Cc: tliang@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am working on a PPC440 board that supports
a PCI-IDE device, and I am experiencing an
interrupt handling problem.

The PCI-IDE controller uses External Interrupt 7 and
the controller interrupt line is wired to the
processor directly. When the IDE device is
being initialized, I can see that the interrupt
goes off. But the code is stuck in the
ISR and can not get out. Here are the screen
debug messages:

<Linux booting up>
ide1: CMD649 Bus-Master DMA disabled (BIOS)
disabling irq 50 defensively
ppc405_uic_disable - irq 50 word 1 bit 0x12
hda: SanDisk SDCFB-128, ATA DISK drive
ppc405_uic_enable - irq 50 word 1 bit 0x12
ppc405_uic_enable - irq 50 word 1 bit 0x12
ide0 at 0x2000-0x2007,0x3002 on irq 50
hda: 250880 sectors (128 MB) w/1KiB Cache,
CHS=980/8/32
Partition check:
 hda:ppc405_pic_get_irq - irq 50 bit 0x2000
ppc405_uic_disable_and_ack - irq 50 word 1 bit 0x12
ppc405_pic_get_irq - irq 64 bit 0x0
ppc405_pic_get_irq - irq 64 bit 0x0
-------------

I am able to retrieve a stack trace when the
console is displaying the above messages. It is
shown as follows.

-----------
#8  0xc0004950 in do_IRQ (regs=0xc02b68a4) at
irq.c:585
#9  0xc00037cc in ret_from_fork () at entry.S:97
#10 0xc0004730 in ppc_irq_dispatch_handler
(regs=0xc02a522f, irq=3178)
    at irq.c:477
#11 0xc0004938 in do_IRQ (regs=0xc01dbf30) at
irq.c:583
------------

Does anybody have an explaination on what is
going on? Thank you for your help.

Regards,

Terry


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

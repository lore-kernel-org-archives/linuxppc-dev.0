Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: MPC5200Lite PCI & IRQ
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 4 Jun 2004 15:00:10 +0200
Message-ID: <5A96167EBCEA8440A48790B5419953AE13C443@gr-lafayette.lacie.com>
From: "Bertrand Baudet" <bbaudet@lacie.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm trying to plug a sata card in the PCI slot of the MPC5200Lite.

I'm using DENX linuxppc_2_4_devel CVS tree.


The INTA of the PCI bus is connected to the IRQ0 of the MPC5200.
In mpc5xxx.h IRQ0 is defined a 0:
#define MPC5xxx_CRIT_IRQ_BASE		0
#define MPC5xxx_IRQ0               (MPC5xxx_CRIT_IRQ_BASE + 0)

By default the IRQ line of the sata card is 0, so I don't have to set it
to another IRQ number under U-Boot.

>From the source code, it looks like a value 0 for the IRQ means the IRQ
is
disabled.

>From "drivers/ide/ide-probe.c", in the 'hwif_init' function:
...
if (!hwif->irq) {
   if (!(hwif->irq = ide_default_irq(hwif->io_ports[IDE_DATA_OFFSET])))
   {
      printk("%s: DISABLED, NO IRQ\n", hwif->name);
      return (hwif->present = 0);
   }
}
...

Commenting out the above code allow the PCI card to run properly.


Then I changed the IRQ0 to 1 by increasing the critical IRQ base value:
#define MPC5xxx_CRIT_IRQ_BASE		1
#define MPC5xxx_IRQ0               (MPC5xxx_CRIT_IRQ_BASE + 0)
and remove my comment around the above code (clean source).

By placing the interrupt line to 1 I was able to get the PCI card
to run properly.

I rather change the default critical IRQ base but I was wondering if
this
could have some bad effect somewhere else in the code?



Has anybody tried to plug a PCI card on the PCI slot of the MPC5200 and
have
the same issue?



Regards,
Bertrand

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

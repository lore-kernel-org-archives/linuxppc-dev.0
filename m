Return-Path: <nzeitler@osii.com>
Received: from OSIMAIL.osii.com (mail.osii.com [208.42.8.142])
	by ozlabs.org (Postfix) with ESMTP id B02DE2BE83
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Dec 2004 05:02:30 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 13 Dec 2004 11:50:20 -0600
Message-ID: <01C22B6B78D52B46BE3C38FB525617EF909AC5@osimail.osii.com>
From: "Zeitler, Nathan" <nzeitler@osii.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Lite5200 and PCI1520
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 Greetings all,
I would greatly appreciate some advice regarding getting Linux to read
and write to CompactFlash devices behind a PCI1520 PCI bridge on a
custom Lite5200 board.  I am admittedly new to this process within
embedded devices and could use some direction.  We're using a recent
2.4.25 kernel from Denx, as well as UBOOT 1.1.1 and ELDK2.1. =20

My status:
UBOOT detects the PCI Bridge just fine.  I'm able to read and write to
the registers within the PCI1520 using the BDI2000 as well as UBOOT's
pci command.  I've therefore set up the bridge to use its output to run
the power chip instead of reading an EEPROM for its settings.  I've also
set up the multifunction pins to be "parallel PCI only", as they are
connected to hardware "IRQ1" and "IRQ2" of the MPC5200.  I've tried
several different values for the Interrupt Line register, but am mostly
flying blind in this respect.  I've enabled most every PCMCIA option in
the Linux kernel I could find, enabled PnP and Cardbus support, but not
i82365 compatible bridge support as it seemed to scan for ISA resources
that weren't there (I understand the yenta driver doesn't want nor need
this anyway?).

My problem:
I can't access anything plugged into the sockets!  PCI1520 registers
detect a card is inserted, but I can't read and write to flash cards
from Linux.  I checked out PCMCIA Card Services from CVS, compiled and
ran cardmgr and it gives a seg-fault, but indicates it is watching the
sockets (debug output seems to confirm this).  I can read the status and
config using cardctl, but reading the identification or info causes
another seg fault.  I suspect I may be running into a combination of
interrupt and driver issues, but I need a knowledgeable opinion on this.
I'm most confused by the line between ISA and PCI IRQs, and how or why
CF uses these.  I've appended some interesting messages from Linux's
boot sequence.  Thanks in advance.

Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus]
yenta 00:18.0: no resource of type 100 available, trying to continue...

yenta 00:18.0: no resource of type 100 available, trying to continue...

yenta 00:18.1: no resource of type 100 available, trying to continue...

yenta 00:18.1: no resource of type 100 available, trying to continue...=20

/* type 100 =3D=3D IO_RESOURCE, recoding yenta.c to bind them=20
to a 0x5000nnnn address range stopped the error,=20
but seemed  to fix nothing */=20

...

Yenta ISA IRQ mask 0x0000, PCI irq 255
Socket status: 30000810
Yenta ISA IRQ mask 0x0000, PCI irq 255
Socket status: 30000006
/* 255 seems to be the default value,
But what should it be instead? */


Nathan Zeitler
Systems Engineer
Open Systems International, Inc.
3600 Holly Lane North, Suite 40
Minneapolis, MN 55447-1286
Phone: (763) 551-0559
Fax:     (763)551-0750
Email:  nzeitler@osii.com

From: DavidHo@nanometrics.ca
Subject: EXT_DIRECT IDE Mode
To: steven.scholz@imc-berlin.de
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF3324B9C2.51BE135A-ON85256E37.00512C20-85256E37.00527916@nanometrics.ca>
Date: Wed, 11 Feb 2004 10:00:49 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Steve,

My application needs a compactflash and a 1.8" disk drive connected to the
MPC852T.  Since the compact flash has already taken up the only PCMCIA
slot, the disk drive is directly attached to the PPC bus so I need to
enable EXT_DIRECT for the disk drive.

I haven't been able to make linux call the ide_init_hwif function.  I
looked at how ide.c works and it looks like it enables IDE interfaces on
the PCI first (ide_default_io_base returns non-zero).  I haven't yet been
able to find out where it call my function.

Would you be able to tell me how you got this mode working.

Regards,
David Ho




 >Subject: Re: MPC8xx IDE
 >From: Steven Scholz <steven.scholz@imc-berlin.de>
 >Date: Wed, 24 Oct 2001 14:02:33 +0200

 >> While trying to find an easy way to add non-volatile storage on a
 >> custion MPC860 board, I noticed that there was some support for IDE on
 >> the PCMCIA interface in the Linux kernel.

 >There are actually at least three ways for connecting an IDE HDD. See
 >ide-m8xx.c:

 >---
 >8xx_PCCARD uses the 8xx internal PCMCIA interface in combination
 >with a PC Card (e.g. ARGOSY portable Hard Disk Adapter),
 >ATA PC Card HDDs or ATA PC Flash Cards (example: TQM8xxL
 >systems)

 >8xx_DIRECT is used for directly connected IDE devices using the 8xx
 >internal PCMCIA interface (example: IVMS8 systems)

 >EXT_DIRECT is used for IDE devices directly connected to the 8xx
 >bus using some glue logic, but _not_ the 8xx internal
 >PCMCIA interface (example: IDIF860 systems)
 >---

 >I am probably the only one using EXT_DIRECT. ;-)

 >Drop me a line if you need schematics.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

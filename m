Message-ID: <A109131318C4D1119AC20060088DECE30B9826@amwmail.adaptivemicro.com>
From: Lucinda Schafer <lucsch@adaptivemicro.com>
To: "'Mike Coy'" <coym@embeddedplanet.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: RE: PCMCIA ATA flash support
Date: Tue, 27 Jun 2000 15:59:49 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I noticed an __init in front of m8xx_ide_init_hwif_ports.

According to init.h:

/* These macros are used to mark some functions or
 * initialized data (doesn't apply to uninitialized data)
 * as `initialization' functions. The kernel can take this
 * as hint that the function is used only during the initialization
 * phase and free up used memory resources after
 *
 * Usage:

If you are calling ide_register() after bootup, could this be a problem
(note: I am using 2.2.13 with no patches for the PCMCIA so this may not be
true in your case)?

However, if your function is missing, this could be your problem.

Maybe one of the more experienced "listees" could give a better answer.


Lucinda Schafer
Staff Software Engineer
Adaptive Micro-Ware, Inc.



-----Original Message-----
From: Mike Coy [mailto:coym@embeddedplanet.com]
Sent: Tuesday, June 27, 2000 2:58 PM
To: Lucinda Schafer; linuxppc-embedded@lists.linuxppc.org
Subject: RE: PCMCIA ATA flash support



NIP is c00def58 (m8xx_ide_init_hwif_ports)
LR is c0002da4 (inside ide_init_hwif_ports)

I gather that LR is the place you were called from and NIP is the next
instruction, in which case both of these seem to be correct.

mike


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

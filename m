From: Paul Miller <pmiller9@users.sourceforge.net>
To: jbeisert@eurodsn.de
Subject: Re: 405EP peripheral bus
Date: Fri, 21 Nov 2003 14:13:18 -0600
Cc: Embedded PPC <linuxppc-embedded@lists.linuxppc.org>
References: <200311191443.16246.pmiller9@users.sourceforge.net> <200311200952.04145.jbeisert@eurodsn.de>
In-Reply-To: <200311200952.04145.jbeisert@eurodsn.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311211413.18405.pmiller9@users.sourceforge.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Intrinsyc will not provide the physical address locations for anything
on their board, which is ridiculous.  I have determined, based on the
DCR registers, that the following memory addresses are used:

SDRAM is located at 0x00000000 with 32MB size.
(NOR??) located at 0xFFE000000 with size 2MB
(NAND??) located at 0x60000000 with size  1MB

Based on Intrinsyc's code, they appear to use 0x60000000 as the base
address for the NAND flash, but the register reads a 1MB size instead
of 32MB.  I suspect the other location is the NOR flash.

So now I'm trying to use address 0x04000000 with CS2\.

How do I map the phyiscal address?


/* EBC0 Registers */
EBC0_B0CR  : 0xffe3a000
EBC0_B1CR  : 0x60018000
EBC0_B2CR  : 0x00000000
EBC0_B3CR  : 0x00000000
EBC0_B4CR  : 0x00000000
EBC0_B0AP  : 0x04002480
EBC0_B1AP  : 0x04005480
EBC0_B2AP  : 0x00000000
EBC0_B3AP  : 0x00000000
EBC0_B4AP  : 0x00000000
EBC0_BEAR  : 0x00000000
EBC0_BESR0 : 0x00000000
EBC0_BESR1 : 0x00000000
EBC0_CFG   : 0x80400000

/* SDRAM0 Registers */
SDRAM0_CFG   : 0x80a00000
SDRAM0_STATUS: 0x80000000
SDRAM0_RTR   : 0x07e80000
SDRAM0_PMIT  : 0x07c00000
SDRAM0_B0CR  : 0x00062001
SDRAM0_B1CR  : 0x00000000
SDRAM0_TR    : 0x010bc01b

Setting up EBC registers...
EBC0_B2CR: 0x0403a000
EBC0_B2AP: 0x04002480

Thanks!
-Paul


On Thursday 20 November 2003 2:52 am, Juergen Beisert wrote:
> Am Mittwoch, 19. November 2003 21:43 schrieb Paul Miller:
> > and I changed B0CR to 0x0043a000 and I'm trying to use mmap like:
>
> How many RAM is in your System? Less than 64MiB? Or more? Maybe there
> is an overlapping?
>
> JB
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

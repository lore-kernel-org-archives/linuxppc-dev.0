Return-Path: <andrew.dennison@motec.com.au>
Received: from mail.netspace.net.au (whirlwind.netspace.net.au [203.10.110.76])
	by ozlabs.org (Postfix) with ESMTP id 655892BE83
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Dec 2004 11:45:10 +1100 (EST)
Received: from motec.com.au (dsl-210-15-234-78.VIC.netspace.net.au
	[210.15.234.78])
	by mail.netspace.net.au (Postfix) with SMTP id 9992E12B970
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Dec 2004 11:45:09 +1100 (EST)
From: "Andrew Dennison" <andrew.dennison@motec.com.au>
To: "'Zeitler, Nathan'" <nzeitler@osii.com>
Date: Tue, 14 Dec 2004 11:45:11 +1100
Message-ID: <002f01c4e176$2ab60920$4000a8c0@CAT>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <01C22B6B78D52B46BE3C38FB525617EF909AC8@osimail.osii.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Lite5200 and PCI1520 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday, 14 December 2004 11:06 AM, Zeitler, Nathan wrote:

> Hello Andrew,
>=20
>=20
> This would certainly help explain some of the pain in getting it to
> work.  :-/=20

I understand your pain :)

> I'm using the 2.4.25 kernel from Denx also.  The version I have is a
> couple months old (trying to keep from changing too many
> things at once!

I'm actually using the "RTAI validated" version, but tried top of tree =
and
it doesn't help - no changes to the relevant parts.

> It sounds like we're working towards the same end!  I would like to
> assist in some way if possible. =20

Cool - no point us both doing the same stuff. I've actually taken a =
break
from this for the last week but you've given me renewed enthusiasm:)

> I am willing to believe that
> remapping the PCI bus is a possible approach, although I'd like to
> hear the opinion of others as well.  Where in UBOOT did you change
> the PCI bus mappings?

//Relevant section of u-boot/include/configs/VPC.h

/*
 * Physical                 PCI                      Resource
 * 0x00000000 - 0x3fffffff  0x80000000 - 0xBfffffff  SDRAM
 * 0x40000000 - 0x4fffffff  0x40000000 - 0x4fffffff  PCI Memory
 * 0x50000000 - 0x50ffffff  0x00000000 - 0x00ffffff  PCI IO Space
 */

#define CONFIG_SDRAM_PHYS	CFG_SDRAM_BASE
#define CONFIG_SDRAM_BUS	0x80000000
#define CONFIG_SDRAM_SIZE	(1024 * 1024 * 1024)

#define CONFIG_PCI_MEM_PHYS	0x40000000
#define CONFIG_PCI_MEM_BUS	0x40000000
#define CONFIG_PCI_MEM_SIZE	0x10000000

#define CONFIG_PCI_IO_PHYS	0x50000000
#define CONFIG_PCI_IO_BUS	0x00000000
#define CONFIG_PCI_IO_SIZE	0x01000000

// This section does the actual pcmcia setup, and is kinda OT for this
list...
// but included for completeness

#define CONFIG_I82365

#define CFG_PCMCIA_MEM_ADDR	0x40400000 /* after last cardbus base
							* window assigend
by
							* pci_auto, but
can be anywhere in PCI_MEM range*/
#define CFG_PCMCIA_MEM_SIZE	0x1000

#define CONFIG_IDE_8xx_PCCARD	1	/* Use IDE with PC Card Adapter */
#define CFG_IDE_MAXBUS		1	/* max. 1 IDE bus		*/
#define CFG_IDE_MAXDEVICE	1	/* max. 1 drive per IDE bus	*/

#define CFG_ATA_IDE0_OFFSET	0

#define CFG_ATA_BASE_ADDR	CONFIG_PCI_IO_PHYS

/* Offset for data I/O			*/
#define CFG_ATA_DATA_OFFSET	0x100 /* don't change - hard coded in
i82365 */

/* Offset for normal register accesses	*/
#define CFG_ATA_REG_OFFSET	0x100 /* don't change - hard coded in
i82365 */

/* Offset for alternate registers	*/
#define CFG_ATA_ALT_OFFSET	0x108 /* don't change - hard coded in
i82365 */

#define CONFIG_PCMCIA_SLOT_A	/* there can be only one... */

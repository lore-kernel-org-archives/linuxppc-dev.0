Return-Path: <robertst@tihlde.org>
Received: from osl1smout1.broadpark.no (osl1smout1.broadpark.no [80.202.4.58])
	by ozlabs.org (Postfix) with ESMTP id 4175DDDF29
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  4 Mar 2007 23:50:32 +1100 (EST)
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
	by osl1smout1.broadpark.no
	(Sun Java System Messaging Server 6.1 HotFix 0.05 (built Oct 21 2004))
	with ESMTP id <0JED00111NK4EZB0@osl1smout1.broadpark.no> for
	linuxppc-embedded@ozlabs.org; Sun, 04 Mar 2007 12:50:28 +0100 (CET)
Received: from [127.0.0.1] ([84.48.53.104]) by osl1sminn1.broadpark.no
	(Sun Java System Messaging Server 6.1 HotFix 0.05 (built Oct 21 2004))
	with ESMTP id <0JED003NLNK2K060@osl1sminn1.broadpark.no> for
	linuxppc-embedded@ozlabs.org; Sun, 04 Mar 2007 12:50:28 +0100 (CET)
Date: Sun, 04 Mar 2007 12:50:07 +0100
From: Robert Staven <robertst@tihlde.org>
Subject: Getting the LED light up... (A&M Rattler 8250PCI  linux 2.6.13-AM)
To: linuxppc-embedded@ozlabs.org
Message-id: <45EAB26F.1060001@tihlde.org>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Got an Analogue & Micro Rattler 8250PCI board running Linux 2.6.13-AM

I'm trying to get the debug LEDs work (LED0-2 connected to PA0-2) but 
havent had any success yet (How #¤@"$! hard can it be to get a LED light 
up...? :)

Port D bit 24 is accessible on the boards expansion connector, and I 
successfully tested my code to use it as gen purpose I/O (both input and 
output).


But when I try to write (change) port A (bit 0-2), nothing changes in 
the register (nor do the LED light up). And my Ethernet FCC1 freezes 
up!! (fs mounted by NFS so I notice)

FCC1 is using a big part of port A, but I'm quite sure I don't touch any 
of those bits (see code below)

I'm a Linux newbie, but I'm starting to wonder if theres any 'lock' or 
something by the kernel on port A?

Any ideas/tips/anything welcome!

br
Robert

PS, I have a hard time find an immap for the 8250, but since the kernel 
and fs compile fine on my toolchain i assume it there somewhere?


---
snips of relevant parts of my code:

(it's written and compiled as a module)

typedef struct io_port {
	ulong	iop_padir;
	ulong	iop_papar;
	ulong	iop_pasor;
	ulong	iop_paodr;
	ulong	iop_padat;
	char	res1[12];
	ulong	iop_pbdir;
	ulong	iop_pbpar;
	ulong	iop_pbsor;
	ulong	iop_pbodr;
	ulong	iop_pbdat;
	char	res2[12];
	ulong	iop_pcdir;
	ulong	iop_pcpar;
	ulong	iop_pcsor;
	ulong	iop_pcodr;
	ulong	iop_pcdat;
	char	res3[12];
	ulong	iop_pddir;
	ulong	iop_pdpar;
	ulong	iop_pdsor;
	ulong	iop_pdodr;
	ulong	iop_pddat;
	//char	res4[12];
} iop8250_t;
#define IOPORT_BASE_ADDR 0x10D00 // Address to first reg in iop8250

volatile iop8250_t *iommap;

#define P0		0x8000 // P0 bit in registers
#define P1		0x4000 // P1 bit in registers
#define P2		0x2000 // P2 bit in registers
#define LED0 P2
#define LED1 P1
#define LED2 P0

iommap = (iop8250_t *)(CPM_MAP_ADDR+IOPORT_BASE_ADDR);

printk("PDIRA (0x%08X) = 0x%08X\n", &(iommap->iop_padir), 
iommap->iop_padir);
printk("PPARA (0x%08X) = 0x%08X\n", &(iommap->iop_papar), 
iommap->iop_papar);
printk("PSORA (0x%08X) = 0x%08X\n", &(iommap->iop_pasor), 
iommap->iop_pasor);
printk("PDATA (0x%08X) = 0x%08X\n", &(iommap->iop_padat), 
iommap->iop_padat);

iommap->iop_papar &= ~LED0; // set PA2 to general I/O
iommap->iop_padir |=  LED0; // set PA2 as output
iommap->iop_padat &= ~LED0; // Clear PA2 / LED0 on

printk("PDATA (0x%08X) = 0x%08X\n", &(iommap->iop_padat), 
iommap->iop_padat);

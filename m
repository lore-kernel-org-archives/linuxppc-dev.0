Return-Path: <powerpc440@googlemail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id A250EDDE9E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Mar 2007 03:08:00 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so939646ugf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 08 Mar 2007 08:07:59 -0800 (PST)
Message-ID: <45F03501.4040902@googlemail.com>
Date: Thu, 08 Mar 2007 17:08:33 +0100
From: powerpc440 <powerpc440@googlemail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: PPC405EP Custom Board. Question for PCI init.
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I have a custom board, based on Taihu with ppc405ep CPU. On the board
are 3 PCI devices: SATA, USB and graphic on PCI Slot. I made custom
board definition in Linux kernel, based on Taihu. The boot process is
OK, the command prompt is appears (over ttyS0), but seems that the PCI
units are not really initialized yet. This is part from dmesg:

................
libata version 1.20 loaded.
sata_sil 0000:00:02.0: version 0.9
sata_sil 0000:00:02.0: Applying R_ERR on DMA activate FIS errata fix
ata1: SATA max UDMA/100 cmd 0xD1050C80 ctl 0xD1050C8A bmdma 0xD1050C00
irq 29
ata2: SATA max UDMA/100 cmd 0xD1050CC0 ctl 0xD1050CCA bmdma 0xD1050C08
irq 29
ata3: SATA max UDMA/100 cmd 0xD1050E80 ctl 0xD1050E8A bmdma 0xD1050E00
irq 29
ata4: SATA max UDMA/100 cmd 0xD1050EC0 ctl 0xD1050ECA bmdma 0xD1050E08
irq 29
ata1: SATA link down (SStatus 0)
scsi0 : sata_sil
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 cfg 49:2f00 82:7c6b 83:5b09 84:4673 85:7c69 86:1a21 87:4663
88:007f
ata2: dev 0 ATA-7, max UDMA/133, 160086528 sectors: LBA
ata2: qc timeout (cmd 0xef)
ata2: failed to set xfermode, disabled
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
ata3: SATA link down (SStatus 0)
scsi2 : sata_sil
ata4: SATA link down (SStatus 0)
scsi3 : sata_sil
usbmon: debugfs is not available
ehci_hcd 0000:00:03.2: EHCI Host Controller
ehci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:03.2: irq 30, io mem 0xbfffcf00
ehci_hcd 0000:00:03.2: USB 2.0 started, EHCI 0.95, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
116x: driver isp116x-hcd, 03 Nov 2005
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd 0000:00:03.0: OHCI Host Controller
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:03.0: irq 30, io mem 0xbfffe000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ohci_hcd 0000:00:03.1: OHCI Host Controller
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:03.1: irq 30, io mem 0xbfffd000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
i2c /dev entries driver
....................

USBs and SATA ports are visible from system, but seems that the IRQs are
not corect.


There is part of taihu.c bord configuration:

/* Some IRQs unique to the board
 * Used by the generic 405 PCI setup functions in ppc4xx_pci.c
 */
int __init
ppc405_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
{
    static char pci_irq_table[][4] =
        /*
         *      PCI IDSEL/INTPIN->INTLINE
         *      A       B       C       D
         */
    {
        /*{25, 26, 27, 28},    *//* IDSEL 1 - PCI slot 1 */
        /*{26, 27, 28, 25},    *//* IDSEL 2 - PCI slot 2 */
    };

    const long min_idsel = 6, max_idsel = 7, irqs_per_slot = 4;
    return PCI_IRQ_TABLE_LOOKUP;
};

My question is what exactly means these values {25, 26, 27, 28}, and how
I can determinate and complete the correct config for my board.
The PCI slot IDSEL pin is connected to PCI_AD11 (CPU);
SATA IDSEL - to PCI_AD12;
USB IDSEL - to PCI_AD13

Best regards,
Zhivko Yordanov

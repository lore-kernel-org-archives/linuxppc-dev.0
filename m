Return-Path: <linuxppcdev@qbjnet.com>
Received: from kunk.qbjnet.com (ddsl1-28.ddsl.mr.net [137.192.135.28])
	by ozlabs.org (Postfix) with SMTP id 0D24067CA9
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 06:16:41 +1100 (EST)
Date: 13 Dec 2006 19:09:58 -0000
Message-ID: <20061213190958.16479.qmail@kunk.qbjnet.com>
From: Bob Brose <linuxppcdev@qbjnet.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Fix irq routing on some PowerMac 32
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I was hoping this might fix the irq mapping problem on the SuperMac 900
detected as 16 (Unknown PowerSurge), no such luck. Though the mapping
changed, the bottom 4 slots on the dec 21052 pci bridge still don't work
with interrupt enabled devices.

As a rehash, there was no problem through 2.6.15 and it's been broken since.

A representative error message (2.6.19 with the fix irq routing patch):

ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
PCI: Enabling device 0000:01:01.0 (0014 -> 0016)
ohci_hcd 0000:01:01.0: OHCI Host Controller
ohci_hcd 0000:01:01.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:01:01.0: irq 18, io mem 0x80800000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usb 1-2: new low speed USB device using ohci_hcd and address 2
ohci_hcd 0000:01:01.0: Unlink after no-IRQ?  Controller is probably using the wrong IRQ.

2.6.15
PCI: Enabling device 0000:01:01.0 (0014 -> 0016)
ohci_hcd 0000:01:01.0: OHCI Host Controller
ohci_hcd 0000:01:01.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:01:01.0: irq 25, io mem 0x80800000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usb 1-2: new low speed USB device using ohci_hcd and address 2
input: Logitech M4848 as /class/input/input4
input: USB HID v1.00 Mouse [Logitech M4848] on usb-0000:01:01.0-2


The interrupts in patched 2.6.19:
           CPU0       
 18:          0   PMAC-PIC  Edge      ohci_hcd:usb1
 19:          7   PMAC-PIC  Edge      53C94
 20:         17   PMAC-PIC  Edge      MACE
 21:          0   PMAC-PIC  Edge      MACE-txdma
 22:         36   PMAC-PIC  Edge      MACE-rxdma
 23:       1469   PMAC-PIC  Level     sym53c8xx
 26:          0   PMAC-PIC  Edge      PMac
 27:          0   PMAC-PIC  Edge      PMac Output
 28:          0   PMAC-PIC  Edge      PMac Input
 29:          0   PMAC-PIC  Edge      SWIM3
 31:      23138   PMAC-PIC  Edge      ADB
 32:         14   PMAC-PIC  Edge      MESH
BAD:          0

The interrupts in 2.6.15:
           CPU0       
  2:          0   PMAC-PIC  Edge      MACE-txdma
  3:         43   PMAC-PIC  Edge      MACE-rxdma
  8:          0   PMAC-PIC  Edge      PMac Output
  9:          0   PMAC-PIC  Edge      PMac Input
 12:          7   PMAC-PIC  Edge      53C94
 13:         14   PMAC-PIC  Edge      MESH
 14:         17   PMAC-PIC  Edge      MACE
 17:          0   PMAC-PIC  Edge      PMac
 18:      16293   PMAC-PIC  Edge      ADB
 19:          0   PMAC-PIC  Edge      SWIM3
 23:       1279   PMAC-PIC  Level     sym53c8xx
 25:      51282   PMAC-PIC  Level     ohci_hcd:usb1

(all devices on the 21052 gang on irq 25, these tests are  with only the
ohci adapter in place).

Return-Path: <linuxppcdev@qbjnet.com>
Received: from kunk.qbjnet.com (ddsl1-28.ddsl.mr.net [137.192.135.28])
	by ozlabs.org (Postfix) with SMTP id C8066679EF
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 01:23:06 +1000 (EST)
Date: 20 Apr 2006 15:22:50 -0000
Message-ID: <20060420152250.17407.qmail@kunk.qbjnet.com>
From: Robert Brose <linuxppcdev@qbjnet.com>
To: linuxppc-dev@ozlabs.org
Subject: powermac S900 6 slot PCI broken in 2.6.16
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The s900 has a 6 slot PCI bus. It works fine in 2.6.15. In 2.6.16 it
appears the interrupts are being assigned in an incorrect way, I get
an interrupt assignment failure on the device on the 21052 bridge.
(notice in the interrupt assignment at the end that the stuff on the
bridge is on irq 25 when it works in 2.6.15 and irq 1 when it doesn't
work in 2.6.16).

2.6.16 relevant dmesg
irq: Found primary Apple PIC /bandit/gc for 32 irqs
irq: System has 32 possible interrupts
.
.
ohci_hcd 0000:01:03.0: Unlink after no-IRQ?  Controller is probably using the wrong IRQ.


lspci
0000:00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 03)
0000:00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21052 (rev 01)
0000:00:10.0 ff00: Apple Computer Inc. Grand Central I/O (rev 02)

2.6.16 /proc/interrupts
           CPU0       
  1:          0   PMAC-PIC  Edge      ohci1394, ohci_hcd:usb1
  2:          0   PMAC-PIC  Edge      MACE-txdma
  3:        302   PMAC-PIC  Edge      MACE-rxdma
  8:          0   PMAC-PIC  Edge      Built-in Sound out
  9:          0   PMAC-PIC  Edge      Built-in Sound in
 13:         37   PMAC-PIC  Edge      MESH
 14:        640   PMAC-PIC  Edge      MACE
 17:          0   PMAC-PIC  Edge      Built-in Sound misc
 18:      18917   PMAC-PIC  Edge      ADB
 19:          0   PMAC-PIC  Edge      SWIM3
 23:        452   PMAC-PIC  Level     eth0
 24:       1159   PMAC-PIC  Level     ide0
BAD:          0

2.6.15 /proc/interrupts
           CPU0       
  2:          0   PMAC-PIC  Edge      MACE-txdma
  3:    3233732   PMAC-PIC  Edge      MACE-rxdma
  8:          0   PMAC-PIC  Edge      Built-in Sound out
  9:          0   PMAC-PIC  Edge      Built-in Sound in
 13:        109   PMAC-PIC  Edge      MESH
 14:    3148467   PMAC-PIC  Edge      MACE
 15:          4   PMAC-PIC  Edge      PowerMac Zilog
 17:          0   PMAC-PIC  Edge      Built-in Sound misc
 18:      18746   PMAC-PIC  Edge      ADB
 19:          0   PMAC-PIC  Edge      SWIM3
 23:    1123909   PMAC-PIC  Level     eth0
 24:     403989   PMAC-PIC  Level     ide0
 25:    9440212   PMAC-PIC  Level     ohci1394, ohci_hcd:usb1, r128@PCI:1:0:0


Bob

Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 7DFFEDE0AD
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 22:08:19 +1000 (EST)
Received: from pandora.intern.matrix-vision.de (g1.matrix-vision.com
	[217.7.222.190])
	by p15137414.pureserver.info (Postfix) with ESMTP id 6F53B3CC02E
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 14:08:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by pandora.intern.matrix-vision.de (Postfix) with ESMTP id 41119E3C0B
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 14:06:51 +0200 (CEST)
Received: from hegemone (hegemone.intern.matrix-vision.de [192.168.5.77])
	by pandora.intern.matrix-vision.de (Postfix) with ESMTP id 18EB2E3C0B
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 14:06:51 +0200 (CEST)
Received: from [192.168.65.5] (unknown [192.168.65.5])
	by hegemone (Postfix) with ESMTP id D33F253E
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 14:08:14 +0200 (CEST)
Message-ID: <4805EC2F.50909@matrix-vision.de>
Date: Wed, 16 Apr 2008 14:08:15 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: linux-ppc list <linuxppc-dev@ozlabs.org>
Subject: USB @ MPC8343
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear List,

on my MPC8343 based board there is a "USB3300" ULPI-PHY connected to the 
processor.
It's an OTG capable PHY but host mode should be enough right now.

Since USB is not used inside bootloader it's not configured at all...
As far as I can see the setup should be done inside the kernel completely.

My dts looks like this :

                usb@23000 {
                        device_type = "usb";
                        compatible = "fsl-usb2-dr";
                        reg = <0x23000 0x1000>;
                        #address-cells = <1>;
                        #size-cells = <0>;
                        interrupt-parent = <&ipic>;
                        interrupts = <38 0x8>;
                        dr_mode = "host";
                        phy_type = "ulpi";
                        port1;
                };


Since the MPC8343 has only one USB port I assume it is "port1" since the 
port1-pins are coming out of the package :-)
DR registers are located @ 0x23000



Kernel log :

fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1
fsl-ehci fsl-ehci.0: irq 38, io base 0xe0023000
fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: Freescale On-Chip EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.25-rc8-01233-g6249f9d-dirty ehci_hcd
usb usb1: SerialNumber: fsl-ehci.0
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
usbcore: registered new interface driver cdc_acm
drivers/usb/class/cdc-acm.c: v0.25:USB Abstract Control Model driver for 
USB modems and ISDN adapters
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver libusual



Clocks and communication are looking fine (from an electrical point of 
view) and bus power is applied.


But : no device (mouse, memory stick, ...) gets recognized.

No interrupts either.


An hints ?


regards,
Andre Schwarz
Matrix Vision

MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner

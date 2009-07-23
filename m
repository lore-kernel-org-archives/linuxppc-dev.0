Return-Path: <RichardRetanubun@ruggedcom.com>
Received: from mail.ruggedcom.com (mail.ruggedcom.com [204.50.190.93])
	by bilbo.ozlabs.org (Postfix) with ESMTP id F0E63B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 06:56:49 +1000 (EST)
Message-ID: <4A68CE8C.5050305@RuggedCom.com>
Date: Thu, 23 Jul 2009 16:56:44 -0400
From: Richard Retanubun <RichardRetanubun@RuggedCom.com>
MIME-Version: 1.0
To: Linuxppc-dev-mList <linuxppc-dev@lists.ozlabs.org>
Subject: FHCI: USB: The use of qe general purpose timer and usb device
	descriptor read/64, error -110
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I am working on Linux-2.6.29.5 on an MPC8360E, trying to make the FHCI USB working.

the output of clocks in u-boot is as follows:

 > Output of u-boot clocks command <
Clock configuration:
   Core:                533.333 MHz
   Coherent System Bus: 266.667 MHz
   QE:                  400  MHz
   BRG:                 200  MHz
   Local Bus Controller:266.667 MHz
   Local Bus:           66.667 MHz
   DDR:                 266.667 MHz
   DDR Secondary:       266.667 MHz
   SEC:                 88.889 MHz
   I2C1:                266.667 MHz
   I2C2:                266.667 MHz

rcm1:~# cat /proc/cpuinfo
processor       : 0
cpu             : e300c1
clock           : 533.333328MHz
revision        : 3.1 (pvr 8083 0031)
bogomips        : 133.12
timebase        : 66666666
platform        : MPC836x
model           : RC8360
Memory          : 512 MB


In the dts, because our cpu_clk and csb_clk is the same as mpc8360_rdk eval platfrom (533.333 MHz and 266.666 MHZ)
I modeled the gtm frame limit timer the same as mpc836x_rdk.dts, namely as follows:

timer@440 {
	compatible = "fsl,mpc8360-qe-gtm",
		     "fsl,qe-gtm", "fsl,gtm";
	reg = <0x440 0x40>;
	interrupts = <12 13 14 15>;
	interrupt-parent = <&qeic>;
	clock-frequency = <166666666>; /* RDK at 533.333 MHz */
	/* clock-frequency = <132000000>; [DISABLED] MDS at 528 MHz */
};

In the fhci-hdc.c code, the timer is used as the "Frame limit timer"

I am wondering how is the clock-frequency = <166666666> derived and what its function is for the fhci-usb driver?

Also, using the timer settings as shown, so far I can only got one USB flash mass-storage device to come up successfully.

The rest of the device will enumerate, but fails like this:

usb 1-1: new full speed USB device using fsl,usb-fhci and address 2
usb 1-1: New USB device found, idVendor=0204, idProduct=6025
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: Flash Disk
usb 1-1: Manufacturer: CBM
usb 1-1: SerialNumber: 2519130247661913
usb 1-1: configuration #1 chosen from 1 choice
scsi1 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
usb 1-1: reset full speed USB device using fsl,usb-fhci and address 2
usb 1-1: device descriptor read/64, error -110
usb 1-1: device descriptor read/64, error -110
usb 1-1: USB disconnect, address 2
usb-storage: device scan complete
usb 1-1: new full speed USB device using fsl,usb-fhci and address 3
usb 1-1: device descriptor read/64, error -110
usb 1-1: device descriptor read/64, error -110
hub 1-0:1.0: unable to enumerate USB device on port 1
usb 1-1: new full speed USB device using fsl,usb-fhci and address 5
usb 1-1: device descriptor read/64, error -110
usb 1-1: device descriptor read/64, error -110


 From web-search, the resolution for the usb 1-1: device descriptor read/64, error -110 is usually to modprobe -r ehci-hdc,
however I never enabled ehci driver because the fhci is the only one that works with MPC8360.

If it is indeed a timeout from getting the device information from the flash chip on the USB mass-storage, how can I extend this
timeout to allow for more time?


This is the relevant dmesg output on usb:
=========================================
fsl,usb-fhci e01006c0.usb: assuming board doesn't have speed gpio
fsl,usb-fhci e01006c0.usb: assuming board doesn't have power gpio
fsl,usb-fhci e01006c0.usb: at 0xe10386c0, irq 25
fsl,usb-fhci e01006c0.usb: FHCI HOST Controller
fsl,usb-fhci e01006c0.usb: new USB bus registered, assigned bus number 1
fsl,usb-fhci e01006c0.usb: irq 25, io mem 0x00000000
usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: FHCI HOST Controller
usb usb1: Manufacturer: Linux 2.6.29.5-dirty fsl,usb-fhci
usb usb1: SerialNumber: e01006c0.usb
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.

...

usb 1-1: new full speed USB device using fsl,usb-fhci and address 2
usb 1-1: New USB device found, idVendor=0204, idProduct=6025
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: Flash Disk
usb 1-1: Manufacturer: CBM
usb 1-1: SerialNumber: 2519130247661913
usb 1-1: configuration #1 chosen from 1 choice
scsi1 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
usb 1-1: reset full speed USB device using fsl,usb-fhci and address 2
usb 1-1: device descriptor read/64, error -110
usb 1-1: device descriptor read/64, error -110
usb 1-1: USB disconnect, address 2
usb-storage: device scan complete
usb 1-1: new full speed USB device using fsl,usb-fhci and address 3
usb 1-1: device descriptor read/64, error -110
usb 1-1: device descriptor read/64, error -110
hub 1-0:1.0: unable to enumerate USB device on port 1
usb 1-1: new full speed USB device using fsl,usb-fhci and address 5
usb 1-1: device descriptor read/64, error -110
usb 1-1: device descriptor read/64, error -110


Thanks for everyone's time

- Richard Retanubun
